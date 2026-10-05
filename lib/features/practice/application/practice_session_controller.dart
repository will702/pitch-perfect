import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';
import '../../../core/analysis/audio_analysis_engine.dart';
import '../../../core/analysis/script_coverage.dart';
import '../../../core/analysis/scoring.dart';
import '../../../core/audio/audio_capture_service.dart';
import '../../../core/benchmark/latency_recorder.dart';
import '../../../core/feedback/feedback_engine.dart';
import '../../../core/metrics/metrics_aggregator.dart';
import '../../../core/speech/speech_recognition_engine.dart';
import '../../../core/speech/speech_recognition_result.dart';
import '../domain/practice_session.dart';
import '../domain/transcript_segment.dart';

sealed class PracticeState {
  const PracticeState();
}

class PracticeIdle extends PracticeState {
  const PracticeIdle();
}

class PracticeInitializing extends PracticeState {
  /// Model download progress 0..1, null when not downloading.
  final double? progress;
  const PracticeInitializing([this.progress]);
}

class PracticeRunning extends PracticeState {
  final LiveSessionMetrics metrics;
  final List<TranscriptSegment> transcript;
  final FeedbackEvent? feedback;
  final List<bool> keywordsHit;
  final SessionConfig config;
  final bool micActive;

  const PracticeRunning({
    required this.metrics,
    required this.transcript,
    required this.feedback,
    required this.keywordsHit,
    required this.config,
    required this.micActive,
  });
}

class PracticeStopping extends PracticeState {
  const PracticeStopping();
}

class PracticeCompleted extends PracticeState {
  final PracticeSession session;
  const PracticeCompleted(this.session);
}

class PracticeError extends PracticeState {
  final Object error;
  const PracticeError(this.error);
}

class PracticeSessionController extends Notifier<PracticeState> {
  AudioCaptureService? _capture;
  SpeechRecognitionEngine? _asr;
  AudioAnalysisEngine? _dsp;
  StreamSubscription<dynamic>? _asrSub, _dspSub, _progressSub;
  Timer? _tick;
  Completer<void>? _asrDone;

  MetricsAggregator? _agg;
  FeedbackEngine? _feedback;
  LatencyRecorder? _latency;
  SessionConfig _config = const SessionConfig();
  String _sessionId = '';
  DateTime _startedAt = DateTime.now();
  Duration _clock = Duration.zero; // audio clock: end of latest chunk
  DateTime _lastChunkWall = DateTime.now();
  final List<TranscriptSegment> _transcript = [];
  final List<FeedbackEvent> _feedbackLog = [];
  final List<MetricSnapshot> _snapshots = [];
  Duration _lastSnapshot = Duration.zero;
  bool _cleaning = false;

  LatencyRecorder? get latency => _latency;

  @override
  PracticeState build() {
    ref.onDispose(_cleanup);
    return const PracticeIdle();
  }

  Future<void> start(SessionConfig config) async {
    if (state is PracticeInitializing || state is PracticeRunning) return;
    _config = config;
    _sessionId = DateTime.now().microsecondsSinceEpoch.toString();
    _startedAt = DateTime.now();
    _clock = Duration.zero;
    _lastSnapshot = Duration.zero;
    _transcript.clear();
    _feedbackLog.clear();
    _snapshots.clear();
    _agg = MetricsAggregator();
    _feedback = FeedbackEngine(thresholds: ref.read(settingsProvider).thresholds);
    _latency = LatencyRecorder();
    state = const PracticeInitializing();

    try {
      _capture = ref.read(audioCaptureFactoryProvider)();
      if (!await _capture!.requestPermission()) {
        throw StateError('Microphone permission denied');
      }
      _asr = ref.read(asrEngineFactoryProvider)(config.language);
      _progressSub = _asr!.initProgress.listen((p) => state = PracticeInitializing(p));
      await _asr!.initialize();
      await _progressSub?.cancel();
      _progressSub = null;

      _dsp = ref.read(analysisEngineFactoryProvider)();
      final audio = (await _capture!.start()).asBroadcastStream();
      _lastChunkWall = DateTime.now();
      audio.listen((c) {
        _clock = c.end;
        _lastChunkWall = DateTime.now();
        _latency?.onChunk(c.timestamp, c.duration);
      });

      _asrDone = Completer<void>();
      _asrSub = _asr!.recognize(audio).listen(_onResult,
          onError: (Object e) => _fail(e), onDone: () => _asrDone?.complete());
      _dspSub = _dsp!.analyze(audio).listen((f) => _agg!.onFeature(f));
      _tick = Timer.periodic(const Duration(milliseconds: 250), (_) => _onTick());
      _emit();
    } catch (e) {
      await _cleanup();
      state = PracticeError(e);
    }
  }

  void _onResult(SpeechRecognitionResult result) {
    _latency?.onResult(result);
    _agg!.onResult(result);
    if (result.isFinal && result.text.trim().isNotEmpty) {
      _transcript.add(TranscriptSegment(
        id: '${_sessionId}_${_transcript.length}',
        sessionId: _sessionId,
        startSeconds: result.start.inMilliseconds / 1000,
        endSeconds: result.end.inMilliseconds / 1000,
        text: result.text.trim(),
        isFinal: true,
        confidence: result.confidence,
      ));
    }
    _emit();
  }

  void _onTick() {
    final agg = _agg, fb = _feedback;
    if (agg == null || fb == null) return;
    // Mic stalled for >2 s while we think we are running.
    if (DateTime.now().difference(_lastChunkWall) > const Duration(seconds: 2)) {
      final e = fb.inject(
        FeedbackEvent(
          type: 'audio_failure',
          message: 'No audio from microphone.',
          timestamp: _clock.inMilliseconds / 1000,
          severity: FeedbackSeverity.warning,
        ),
        _clock,
      );
      if (_feedbackLog.isEmpty || _feedbackLog.last.type != 'audio_failure') {
        _feedbackLog.add(e);
      }
    } else {
      final e = fb.update(agg.live(_clock));
      if (e != null) _feedbackLog.add(e);
    }
    if (_clock - _lastSnapshot >= const Duration(seconds: 1)) {
      _snapshots.add(agg.snapshot(_clock));
      _lastSnapshot = _clock;
    }
    _emit();
  }

  void _emit() {
    final agg = _agg;
    if (agg == null || _cleaning || state is PracticeStopping) return;
    final spoken = _transcript.map((t) => t.text).join(' ');
    final kws = _config.keywords;
    final hit = kws.isEmpty
        ? const <bool>[]
        : () {
            final miss = keywordCoverage(kws, spoken).missed.toSet();
            return [for (final k in kws) !miss.contains(k)];
          }();
    state = PracticeRunning(
      metrics: agg.live(_clock),
      transcript: List.unmodifiable(_transcript),
      feedback: _feedback?.active,
      keywordsHit: hit,
      config: _config,
      micActive: true,
    );
  }

  void _fail(Object e) {
    _cleanup();
    state = PracticeError(e);
  }

  Future<void> stop() async {
    if (state is! PracticeRunning) return;
    state = const PracticeStopping();
    final agg = _agg!;
    try {
      _tick?.cancel();
      await _capture?.stop(); // closes audio -> ASR flushes final segment
      await _asrDone?.future.timeout(const Duration(seconds: 5), onTimeout: () {});
      final elapsed = _clock;
      final metrics = agg.finish(elapsed);
      final spoken = _transcript.map((t) => t.text).join(' ');

      double? scriptCov;
      var missedSentences = <String>[];
      final script = _config.script;
      if (script != null && script.trim().isNotEmpty) {
        final r = scriptCoverage(script, spoken);
        scriptCov = r.coverage;
        missedSentences = r.missedSentences;
      }
      double? kwCov;
      var missedKw = <String>[];
      if (_config.keywords.isNotEmpty) {
        final r = keywordCoverage(_config.keywords, spoken);
        kwCov = r.coverage;
        missedKw = r.missed;
      }
      var m = metrics.copyWith(scriptCoverage: scriptCov, keywordCoverage: kwCov);
      m = m.copyWith(overallScore: calculateScore(m, elapsed).overall);

      final session = PracticeSession(
        id: _sessionId,
        config: _config,
        startedAt: _startedAt,
        endedAt: _startedAt.add(elapsed),
        metrics: m,
        transcript: List.of(_transcript),
        feedback: List.of(_feedbackLog),
        snapshots: List.of(_snapshots),
        pauses: List.of(agg.pauses),
        fillerBreakdown: Map.of(agg.fillerBreakdown),
        missedKeywords: missedKw,
        missedScriptSentences: missedSentences,
      );
      await ref.read(repositoryProvider).save(session);
      state = PracticeCompleted(session);
    } catch (e) {
      state = PracticeError(e);
    } finally {
      await _cleanup();
    }
  }

  /// Back to idle (e.g. after result screen / error dismissed).
  void reset() {
    if (state is PracticeRunning || state is PracticeInitializing) return;
    state = const PracticeIdle();
  }

  Future<void> _cleanup() async {
    if (_cleaning) return;
    _cleaning = true;
    try {
      _tick?.cancel();
      _tick = null;
      await _progressSub?.cancel();
      await _asrSub?.cancel();
      await _dspSub?.cancel();
      _progressSub = _asrSub = _dspSub = null;
      await _capture?.dispose();
      await _asr?.dispose();
      await _dsp?.dispose();
      _capture = null;
      _asr = null;
      _dsp = null;
    } finally {
      _cleaning = false;
    }
  }
}

final practiceSessionControllerProvider =
    NotifierProvider<PracticeSessionController, PracticeState>(
        PracticeSessionController.new);
