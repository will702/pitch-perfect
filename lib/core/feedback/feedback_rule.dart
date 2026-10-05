import '../metrics/metrics_aggregator.dart';
import '../../features/practice/domain/practice_session.dart';

class FeedbackThresholds {
  final double slowWpm;
  final double fastWpm;
  final double monotoneStdHz;
  final double lowVolumeRatio;
  final Duration longSilence;
  final int fillerBurst;

  const FeedbackThresholds({
    this.slowWpm = 100,
    this.fastWpm = 190,
    this.monotoneStdHz = 15,
    this.lowVolumeRatio = 0.65,
    this.longSilence = const Duration(seconds: 4),
    this.fillerBurst = 3,
  });
}

/// Tracks how long a condition has held continuously.
class FeedbackContext {
  FeedbackContext({this.thresholds = const FeedbackThresholds()});

  final FeedbackThresholds thresholds;
  final Map<String, Duration> _since = {};

  bool sustained(String key, bool condition, Duration now, Duration needed) {
    if (!condition) {
      _since.remove(key);
      return false;
    }
    final start = _since.putIfAbsent(key, () => now);
    return now - start >= needed;
  }

  void clear(String key) => _since.remove(key);
}

abstract interface class FeedbackRule {
  String get type;
  FeedbackEvent? evaluate(LiveSessionMetrics current, FeedbackContext context);
}
