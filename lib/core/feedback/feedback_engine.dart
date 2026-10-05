import '../metrics/metrics_aggregator.dart';
import '../../features/practice/domain/practice_session.dart';
import 'feedback_rule.dart';
import 'rules.dart';

/// One active tip at a time, global cooldown between tips, per-type re-arm.
class FeedbackEngine {
  FeedbackEngine({
    List<FeedbackRule>? rules,
    FeedbackThresholds thresholds = const FeedbackThresholds(),
    this.cooldown = const Duration(seconds: 10),
    this.displayFor = const Duration(seconds: 6),
    this.perTypeCooldown = const Duration(seconds: 30),
  })  : rules = rules ?? defaultRules(),
        _ctx = FeedbackContext(thresholds: thresholds);

  final List<FeedbackRule> rules;
  final Duration cooldown;
  final Duration displayFor;
  final Duration perTypeCooldown;
  final FeedbackContext _ctx;

  FeedbackEvent? _active;
  Duration? _activeAt;
  final _lastByType = <String, Duration>{};

  /// Returns a newly emitted event (to persist) or null. See [active] for display.
  FeedbackEvent? update(LiveSessionMetrics m) {
    final now = m.duration;
    if (_active != null && now - _activeAt! >= displayFor) _active = null;
    // Evaluate every rule so sustained-condition timers keep tracking.
    FeedbackEvent? candidate;
    for (final r in rules) {
      final e = r.evaluate(m, _ctx);
      if (e != null && candidate == null) candidate = e;
    }
    if (candidate == null) return null;
    if (_activeAt != null && now - _activeAt! < cooldown) return null;
    final last = _lastByType[candidate.type];
    if (last != null && now - last < perTypeCooldown) return null;
    _active = candidate;
    _activeAt = now;
    _lastByType[candidate.type] = now;
    return candidate;
  }

  FeedbackEvent? get active => _active;

  /// Direct injection (e.g. audio failure) bypassing rules; highest priority.
  FeedbackEvent inject(FeedbackEvent e, Duration now) {
    _active = e;
    _activeAt = now;
    return e;
  }
}
