import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pitch_perfect/app/providers.dart';
import 'package:pitch_perfect/core/analysis/audio_analysis_engine.dart';
import 'package:pitch_perfect/core/analysis/audio_features.dart';
import 'package:pitch_perfect/core/audio/audio_capture_service.dart';
import 'package:pitch_perfect/core/audio/audio_chunk.dart';
import 'package:pitch_perfect/core/database/database.dart';
import 'package:pitch_perfect/core/database/session_repository.dart';
import 'package:pitch_perfect/core/speech/mock_speech_recognition_engine.dart';
import 'package:pitch_perfect/features/practice/application/practice_session_controller.dart';
import 'package:pitch_perfect/features/practice/domain/practice_session.dart';

/// 100 ms chunks: [voicedSec] of 200 Hz tone, [silenceSec] of silence, [voicedSec] again.
class FakeCapture implements AudioCaptureService {
  FakeCapture({this.voicedSec = 3, this.silenceSec = 1.5});
  final double voicedSec, silenceSec;
  StreamController<AudioChunk>? _c;
  bool disposed = false;

  @override
  Future<bool> requestPermission() async => true;

  @override
  Future<Stream<AudioChunk>> start() async {
    final c = StreamController<AudioChunk>();
    _c = c;
    scheduleMicrotask(() async {
      var n = 0;
      Float32List chunk(bool voiced) => Float32List.fromList([
            for (var i = 0; i < 1600; i++)
              voiced ? 0.4 * sin(2 * pi * 200 * (n * 1600 + i) / 16000) : 0.0
          ]);
      final total = ((voicedSec * 2 + silenceSec) * 10).round();
      for (; n < total && !c.isClosed; n++) {
        final t = n / 10;
        final voiced = t < voicedSec || t >= voicedSec + silenceSec;
        c.add(AudioChunk(
          samples: chunk(voiced),
          sampleRate: 16000,
          channelCount: 1,
          timestamp: Duration(milliseconds: n * 100),
        ));
        await Future<void>.delayed(const Duration(milliseconds: 2));
      }
    });
    return c.stream;
  }

  @override
  Future<void> stop() async {
    final c = _c;
    if (c != null && !c.isClosed) await c.close();
  }

  @override
  Future<void> dispose() async {
    disposed = true;
    await stop();
  }
}

/// Synchronous in-process DSP so the test is deterministic.
class InlineAnalysis implements AudioAnalysisEngine {
  @override
  Stream<AudioFeatureSample> analyze(Stream<AudioChunk> audio) {
    final a = FrameAnalyzer();
    return audio.expand((c) => a.add(c.samples, c.timestamp));
  }

  @override
  Future<void> dispose() async {}
}

void main() {
  late AppDatabase db;
  late FakeCapture capture;
  late ProviderContainer container;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    capture = FakeCapture();
    container = ProviderContainer(overrides: [
      databaseProvider.overrideWithValue(db),
      repositoryProvider.overrideWithValue(SessionRepository(db)),
      audioCaptureFactoryProvider.overrideWithValue(() => capture),
      asrEngineFactoryProvider
          .overrideWithValue((lang) => MockSpeechRecognitionEngine(language: lang)),
      analysisEngineFactoryProvider.overrideWithValue(InlineAnalysis.new),
    ]);
  });

  tearDown(() async {
    container.dispose();
    await db.close();
  });

  test('start -> live transcript -> stop -> saved and reloadable', () async {
    final ctrl = container.read(practiceSessionControllerProvider.notifier);
    await ctrl.start(const SessionConfig(
        title: 'T', keywords: ['product', 'zebra'], script: 'good morning everyone'));

    // wait for transcript to appear
    PracticeRunning? running;
    for (var i = 0; i < 100; i++) {
      await Future<void>.delayed(const Duration(milliseconds: 100));
      final s = container.read(practiceSessionControllerProvider);
      if (s is PracticeRunning && s.transcript.isNotEmpty && s.metrics.duration.inSeconds >= 7) {
        running = s;
        break;
      }
    }
    expect(running, isNotNull, reason: 'transcript never appeared');
    expect(running!.metrics.fillerCount, greaterThan(0)); // canned script has "um"
    expect(running.keywordsHit.length, 2);

    await ctrl.stop();
    final done = container.read(practiceSessionControllerProvider);
    expect(done, isA<PracticeCompleted>());
    final session = (done as PracticeCompleted).session;
    expect(session.transcript, isNotEmpty);
    expect(session.metrics.pauseCount, greaterThanOrEqualTo(1));
    expect(session.metrics.averagePitchHz, closeTo(200, 5));
    expect(session.metrics.averageWpm, greaterThan(0));
    expect(session.metrics.scriptCoverage, isNotNull);
    expect(session.metrics.overallScore, inInclusiveRange(0, 100));
    expect(session.snapshots, isNotEmpty);
    expect(capture.disposed, isTrue, reason: 'mic must be released on stop');

    // persisted: reload as if after app restart
    final loaded = await SessionRepository(db).get(session.id);
    expect(loaded, isNotNull);
    expect(loaded!.transcript.length, session.transcript.length);
    expect(loaded.transcript.first.text, session.transcript.first.text);
    expect(loaded.metrics.averageWpm, session.metrics.averageWpm);
    expect(loaded.config.keywords, ['product', 'zebra']);
    expect(loaded.pauses.length, session.pauses.length);
    expect(loaded.fillerBreakdown, session.fillerBreakdown);

    // delete cascades
    await SessionRepository(db).delete(session.id);
    expect(await SessionRepository(db).get(session.id), isNull);
    expect(await db.select(db.transcriptSegments).get(), isEmpty);
  });

  test('permission denied -> error state, nothing left running', () async {
    final denied = _Denied();
    final c = ProviderContainer(overrides: [
      databaseProvider.overrideWithValue(db),
      repositoryProvider.overrideWithValue(SessionRepository(db)),
      audioCaptureFactoryProvider.overrideWithValue(() => denied),
    ]);
    addTearDown(c.dispose);
    await c.read(practiceSessionControllerProvider.notifier).start(const SessionConfig());
    expect(c.read(practiceSessionControllerProvider), isA<PracticeError>());
    expect(denied.disposed, isTrue);
  });

  test('mock engine: partial replaced, then final', () async {
    final e = MockSpeechRecognitionEngine();
    final audio = StreamController<AudioChunk>();
    final out = <String>[];
    final finals = <String>[];
    e.recognize(audio.stream).listen((r) => (r.isFinal ? finals : out).add(r.text));
    for (var i = 0; i < 100; i++) {
      audio.add(AudioChunk(
        samples: Float32List.fromList(List.filled(1600, 0.3)),
        sampleRate: 16000,
        channelCount: 1,
        timestamp: Duration(milliseconds: i * 100),
      ));
    }
    await audio.close();
    await Future<void>.delayed(const Duration(milliseconds: 20));
    expect(out.first, 'good');
    expect(out[1], 'good morning'); // each partial extends the previous
    expect(finals.first, startsWith('good morning everyone um today'));
  });
}

class _Denied extends FakeCapture {
  @override
  Future<bool> requestPermission() async => false;
}
