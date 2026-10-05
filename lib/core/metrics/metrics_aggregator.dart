import 'dart:math';

import '../analysis/audio_features.dart';
import '../analysis/filler_detector.dart';
import '../analysis/pause_detector.dart';
import '../analysis/text_normalizer.dart';
import '../analysis/wpm_calculator.dart';
import '../speech/speech_recognition_result.dart';
import '../../features/practice/domain/practice_session.dart';
import '../../features/practice/domain/session_metrics.dart';

class LiveSessionMetrics {
  final Duration duration;
  final double rollingWpm;
  final int fillerCount;
  final int fillersLast15s;
  final int pauseCount;
  final int longPauseCount;
  final double? currentPitchHz;
  final double? rollingPitchStdDev;
  final double currentRms;
  final double? rmsBaseline;
  final Duration silence;
  final String partialTranscript;

  const LiveSessionMetrics({
    this.duration = Duration.zero,
    this.rollingWpm = 0,
    this.fillerCount = 0,
    this.fillersLast15s = 0,
    this.pauseCount = 0,
    this.longPauseCount = 0,
    this.currentPitchHz,
    this.rollingPitchStdDev,
    this.currentRms = 0,
    this.rmsBaseline,
    this.silence = Duration.zero,
    this.partialTranscript = '',
  });
}

class _Welford {
  int n = 0;
  double mean = 0, _m2 = 0;
  void add(double x) {
    n++;
    final d = x - mean;
    mean += d / n;
    _m2 += d * (x - mean);
  }

  double get std => n < 2 ? 0 : sqrt(_m2 / n);
}

/// No Flutter code. Memory bounded: only 20 s of pitch + 15 s of filler stamps kept.
class MetricsAggregator {
  MetricsAggregator({FillerDetector? fillers, this.baselineWindow = const Duration(seconds: 10)})
      : _fillers = fillers ?? FillerDetector();

  final FillerDetector _fillers;
  final Duration baselineWindow;
  final _wpm = WpmCalculator();
  final fillerBreakdown = <String, int>{};
  final pauses = <PauseEvent>[];

  int _fillerCount = 0;
  final List<Duration> _fillerTimes = [];
  String _partial = '';
  double _rms = 0;
  double? _f0;
  final List<(Duration, double)> _pitchWindow = [];
  final _pitchAll = _Welford();
  final _rmsAll = _Welford();
  final List<double> _baselineRms = [];
  double? _baseline;
  Duration _now = Duration.zero;
  final _pauseDetector = PauseDetector();

  void onResult(SpeechRecognitionResult r) {
    if (!r.isFinal) {
      _partial = r.text;
      return;
    }
    _partial = '';
    final words = tokenize(r.text).length;
    _wpm.addSegment(words, r.start, r.end);
    final f = _fillers.count(r.text);
    for (final e in f.entries) {
      fillerBreakdown[e.key] = (fillerBreakdown[e.key] ?? 0) + e.value;
      _fillerCount += e.value;
      for (var i = 0; i < e.value; i++) {
        _fillerTimes.add(r.end);
      }
    }
  }

  PauseEvent? onFeature(AudioFeatureSample s) {
    _now = s.timestamp;
    _rms = s.rms;
    _f0 = s.f0Hz;
    if (s.isVoiced) {
      _rmsAll.add(s.rms);
      if (_baseline == null) {
        _baselineRms.add(s.rms);
        if (_baselineRms.length >= 150) {
          // ~10 s of voiced frames at 32 ms hop; median is robust to peaks.
          final sorted = [..._baselineRms]..sort();
          _baseline = sorted[sorted.length ~/ 2];
          _baselineRms.clear();
        }
      }
      final f0 = s.f0Hz;
      if (f0 != null) {
        _pitchAll.add(f0);
        _pitchWindow.add((s.timestamp, f0));
      }
    }
    _pitchWindow.removeWhere((e) => s.timestamp - e.$1 > const Duration(seconds: 20));
    final p = _pauseDetector.onFrame(s.timestamp, s.isVoiced);
    if (p != null) pauses.add(p);
    return p;
  }

  LiveSessionMetrics live(Duration now) {
    _fillerTimes.removeWhere((t) => now - t > const Duration(seconds: 15));
    double? std;
    if (_pitchWindow.length >= 20) {
      final w = _Welford();
      for (final e in _pitchWindow) {
        w.add(e.$2);
      }
      std = w.std;
    }
    return LiveSessionMetrics(
      duration: now,
      rollingWpm: _wpm.rollingWpm(now),
      fillerCount: _fillerCount,
      fillersLast15s: _fillerTimes.length,
      pauseCount: pauses.length,
      longPauseCount: pauses.where((p) => p.kind == PauseKind.long).length,
      currentPitchHz: _f0,
      rollingPitchStdDev: std,
      currentRms: _rms,
      rmsBaseline: _baseline,
      silence: _pauseDetector.currentSilence(_now),
      partialTranscript: _partial,
    );
  }

  MetricSnapshot snapshot(Duration now) =>
      MetricSnapshot(now.inMilliseconds / 1000, _wpm.rollingWpm(now), _f0, _rms);

  SessionMetrics finish(Duration elapsed) {
    final tail = _pauseDetector.finish(elapsed);
    if (tail != null) pauses.add(tail);
    final longPauseTime = pauses
        .where((p) => p.kind == PauseKind.long)
        .fold(Duration.zero, (a, p) => a + p.duration);
    return SessionMetrics(
      averageWpm: _wpm.averageWpm(elapsed, excludedPause: longPauseTime),
      fillerCount: _fillerCount,
      pauseCount: pauses.length,
      longPauseCount: pauses.where((p) => p.kind == PauseKind.long).length,
      averagePitchHz: _pitchAll.n == 0 ? null : _pitchAll.mean,
      pitchStdDev: _pitchAll.n < 2 ? null : _pitchAll.std,
      averageRms: _rmsAll.n == 0 ? null : _rmsAll.mean,
      volumeVariation: _rmsAll.n < 2 || _rmsAll.mean == 0 ? null : _rmsAll.std / _rmsAll.mean,
    );
  }
}
