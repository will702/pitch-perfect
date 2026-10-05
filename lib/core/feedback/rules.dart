import '../metrics/metrics_aggregator.dart';
import '../../features/practice/domain/practice_session.dart';
import 'feedback_rule.dart';

FeedbackEvent _ev(String type, String msg, LiveSessionMetrics m,
        [FeedbackSeverity s = FeedbackSeverity.info]) =>
    FeedbackEvent(
        type: type,
        message: msg,
        timestamp: m.duration.inMilliseconds / 1000,
        severity: s);

class LongPauseRule implements FeedbackRule {
  @override
  final type = 'long_pause';
  @override
  FeedbackEvent? evaluate(LiveSessionMetrics m, FeedbackContext c) =>
      m.silence > c.thresholds.longSilence
          ? _ev(type, 'Long pause detected.', m, FeedbackSeverity.warning)
          : null;
}

class FastSpeechRule implements FeedbackRule {
  @override
  final type = 'too_fast';
  @override
  FeedbackEvent? evaluate(LiveSessionMetrics m, FeedbackContext c) =>
      c.sustained(type, m.rollingWpm > c.thresholds.fastWpm, m.duration,
              const Duration(seconds: 8))
          ? _ev(type, 'Slow down slightly.', m, FeedbackSeverity.warning)
          : null;
}

class SlowSpeechRule implements FeedbackRule {
  @override
  final type = 'too_slow';
  @override
  FeedbackEvent? evaluate(LiveSessionMetrics m, FeedbackContext c) {
    // Only while speaking: rolling WPM > 0 and silence is short.
    final slow = m.rollingWpm > 0 &&
        m.rollingWpm < c.thresholds.slowWpm &&
        m.silence < const Duration(seconds: 2);
    return c.sustained(type, slow, m.duration, const Duration(seconds: 8))
        ? _ev(type, 'Pick up the pace a little.', m)
        : null;
  }
}

class LowVolumeRule implements FeedbackRule {
  @override
  final type = 'low_volume';
  @override
  FeedbackEvent? evaluate(LiveSessionMetrics m, FeedbackContext c) {
    final base = m.rmsBaseline;
    final low = base != null &&
        m.silence == Duration.zero &&
        m.currentRms < base * c.thresholds.lowVolumeRatio;
    return c.sustained(type, low, m.duration, const Duration(seconds: 5))
        ? _ev(type, 'Speak a little louder.', m)
        : null;
  }
}

class MonotoneRule implements FeedbackRule {
  @override
  final type = 'monotone';
  @override
  FeedbackEvent? evaluate(LiveSessionMetrics m, FeedbackContext c) {
    final std = m.rollingPitchStdDev;
    final flat = std != null && std < c.thresholds.monotoneStdHz;
    return c.sustained(type, flat, m.duration, const Duration(seconds: 20))
        ? _ev(type, 'Try adding more vocal variation.', m)
        : null;
  }
}

class FillerBurstRule implements FeedbackRule {
  @override
  final type = 'filler_burst';
  @override
  FeedbackEvent? evaluate(LiveSessionMetrics m, FeedbackContext c) =>
      m.fillersLast15s >= c.thresholds.fillerBurst
          ? _ev(type, 'Lots of filler words lately. Pause instead.', m)
          : null;
}

/// Priority order (ARCHITECTURE §14); audio failure is raised by the controller.
List<FeedbackRule> defaultRules() => [
      LongPauseRule(),
      FastSpeechRule(),
      SlowSpeechRule(),
      LowVolumeRule(),
      MonotoneRule(),
      FillerBurstRule(),
    ];
