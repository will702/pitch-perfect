import 'dart:convert';

import '../speech/speech_recognition_result.dart';

class LatencySample {
  final bool isFinal;
  final Duration audioTimestamp; // end of audio covered by the result
  final DateTime? inferenceStartedAt;
  final DateTime resultReceivedAt;
  DateTime? renderedAt;

  LatencySample(this.isFinal, this.audioTimestamp, this.inferenceStartedAt,
      this.resultReceivedAt);

  /// Spoken -> ASR result delivered to the app.
  Duration? inferenceLatency(DateTime sessionStart) =>
      inferenceStartedAt == null ? null : resultReceivedAt.difference(inferenceStartedAt!);

  /// Audio spoken (capture clock) -> pixels drawn.
  Duration? endToEnd(DateTime sessionStart) =>
      renderedAt?.difference(sessionStart.add(audioTimestamp));

  Map<String, dynamic> toJson(DateTime sessionStart) => {
        'isFinal': isFinal,
        'audio_timestamp_ms': audioTimestamp.inMilliseconds,
        'inference_ms': inferenceLatency(sessionStart)?.inMilliseconds,
        'end_to_end_ms': endToEnd(sessionStart)?.inMilliseconds,
      };
}

class LatencyStats {
  final double mean, median, p95;
  final int count;
  const LatencyStats(this.count, this.mean, this.median, this.p95);
}

LatencyStats latencyStats(List<num> ms) {
  if (ms.isEmpty) return const LatencyStats(0, 0, 0, 0);
  final s = ms.map((e) => e.toDouble()).toList()..sort();
  double pct(double p) {
    final i = (p * (s.length - 1));
    final lo = i.floor(), hi = i.ceil();
    return s[lo] + (s[hi] - s[lo]) * (i - lo);
  }

  return LatencyStats(s.length, s.reduce((a, b) => a + b) / s.length, pct(0.5), pct(0.95));
}

/// Keeps a bounded number of samples (10+ minute sessions stay flat in memory).
class LatencyRecorder {
  LatencyRecorder({this.maxSamples = 5000});
  final int maxSamples;
  final List<LatencySample> samples = [];
  DateTime? _sessionStart;
  final List<LatencySample> _pendingRender = [];

  DateTime? get sessionStart => _sessionStart;

  /// First chunk anchors audio time 0 to the wall clock.
  void onChunk(Duration timestamp, Duration chunkDuration) {
    _sessionStart ??= DateTime.now().subtract(timestamp + chunkDuration);
  }

  void onResult(SpeechRecognitionResult r) {
    final s = LatencySample(r.isFinal, r.end, r.inferenceStartedAt,
        r.resultReceivedAt ?? DateTime.now());
    samples.add(s);
    _pendingRender.add(s);
    if (samples.length > maxSamples) samples.removeAt(0);
  }

  /// Call from a post-frame callback after the UI shows new results.
  void markRendered() {
    final now = DateTime.now();
    for (final s in _pendingRender) {
      s.renderedAt = now;
    }
    _pendingRender.clear();
  }

  String toJson() {
    final start = _sessionStart ?? DateTime.now();
    final e2e = [for (final s in samples) ?s.endToEnd(start)?.inMilliseconds];
    final inf = [for (final s in samples) ?s.inferenceLatency(start)?.inMilliseconds];
    LatencyStats st(List<int> l) => latencyStats(l);
    Map<String, dynamic> m(LatencyStats x) =>
        {'n': x.count, 'mean_ms': x.mean, 'median_ms': x.median, 'p95_ms': x.p95};
    return const JsonEncoder.withIndent('  ').convert({
      'end_to_end': m(st(e2e)),
      'inference': m(st(inf)),
      'samples': [for (final s in samples) s.toJson(start)],
    });
  }
}
