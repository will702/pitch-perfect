import 'package:flutter_test/flutter_test.dart';
import 'package:pitch_perfect/core/analysis/scoring.dart';
import 'package:pitch_perfect/core/benchmark/latency_recorder.dart';
import 'package:pitch_perfect/core/benchmark/wer.dart';
import 'package:pitch_perfect/core/feedback/feedback_engine.dart';
import 'package:pitch_perfect/core/metrics/metrics_aggregator.dart';
import 'package:pitch_perfect/features/practice/domain/session_metrics.dart';

LiveSessionMetrics live(int sec, {double wpm = 150, Duration silence = Duration.zero, int fillers = 0}) =>
    LiveSessionMetrics(
        duration: Duration(seconds: sec),
        rollingWpm: wpm,
        silence: silence,
        fillersLast15s: fillers);

void main() {
  group('feedback engine', () {
    test('fast speech only after 8 s sustained', () {
      final e = FeedbackEngine();
      for (var s = 0; s < 8; s++) {
        expect(e.update(live(s, wpm: 200)), isNull, reason: 't=$s');
      }
      expect(e.update(live(8, wpm: 200))?.type, 'too_fast');
    });
    test('condition reset restarts timer', () {
      final e = FeedbackEngine();
      for (var s = 0; s < 6; s++) {
        e.update(live(s, wpm: 200));
      }
      e.update(live(6, wpm: 150)); // back to normal
      for (var s = 7; s < 14; s++) {
        expect(e.update(live(s, wpm: 200)), isNull, reason: 't=$s');
      }
    });
    test('one tip at a time, cooldown, and priority', () {
      final e = FeedbackEngine();
      // long pause outranks filler burst when both fire
      final first = e.update(live(10, silence: const Duration(seconds: 5), fillers: 5));
      expect(first?.type, 'long_pause');
      // within cooldown nothing else fires
      expect(e.update(live(12, fillers: 5)), isNull);
      expect(e.active?.type, 'long_pause');
      // after cooldown (10 s) next tip may show
      expect(e.update(live(21, fillers: 5))?.type, 'filler_burst');
      // same type suppressed by per-type cooldown (30 s)
      expect(e.update(live(33, fillers: 5)), isNull);
    });
    test('tip expires from display', () {
      final e = FeedbackEngine();
      e.update(live(10, silence: const Duration(seconds: 5)));
      expect(e.active, isNotNull);
      e.update(live(17));
      expect(e.active, isNull);
    });
  });

  group('score', () {
    test('good delivery scores high, poor scores low', () {
      const good = SessionMetrics(
          averageWpm: 150, fillerCount: 1, longPauseCount: 0, pitchStdDev: 35, volumeVariation: 0.3);
      const bad = SessionMetrics(
          averageWpm: 240, fillerCount: 40, longPauseCount: 6, pitchStdDev: 3, volumeVariation: 1.5);
      const d = Duration(minutes: 5);
      expect(calculateScore(good, d).overall, greaterThan(85));
      expect(calculateScore(bad, d).overall, lessThan(25));
    });
    test('coverage weight redistributed when absent', () {
      const m = SessionMetrics(
          averageWpm: 150, pitchStdDev: 40, volumeVariation: 0.2);
      final without = calculateScore(m, const Duration(minutes: 2)).overall;
      final withFull = calculateScore(m.copyWith(scriptCoverage: 1), const Duration(minutes: 2)).overall;
      expect(without, closeTo(100, 0.01));
      expect(withFull, closeTo(100, 0.01));
      final withZero = calculateScore(m.copyWith(scriptCoverage: 0), const Duration(minutes: 2)).overall;
      expect(withZero, closeTo(90, 0.01));
    });
  });

  group('wer', () {
    test('basics', () {
      expect(wer('a b c d', 'a b c d'), 0);
      expect(wer('a b c d', 'a x c d'), 0.25);
      expect(wer('a b c d', 'a b'), 0.5);
      expect(wer('Hello, World!', 'hello world'), 0);
      expect(cer('abcd', 'abxd'), 0.25);
    });
    test('corpus is weighted by length', () {
      expect(corpusWer(['a b c d', 'e'], ['a b c d', 'x']), closeTo(1 / 5, 1e-9));
    });
  });

  test('latency stats', () {
    final s = latencyStats([100, 200, 300, 400, 500]);
    expect(s.mean, 300);
    expect(s.median, 300);
    expect(s.p95, closeTo(480, 0.01));
  });
}
