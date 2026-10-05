import 'dart:math';

import '../../features/practice/domain/session_metrics.dart';

double _clamp01(double x) => x.clamp(0.0, 1.0).toDouble();

/// Trapezoid: 1 inside [goodLo, goodHi], linear falloff to 0 at [lo]/[hi].
double _band(double x, double lo, double goodLo, double goodHi, double hi) {
  if (x >= goodLo && x <= goodHi) return 1;
  if (x <= lo || x >= hi) return 0;
  return x < goodLo ? (x - lo) / (goodLo - lo) : (hi - x) / (hi - goodHi);
}

class ScoreBreakdown {
  final double speechRate, fillers, pauses, pitch, volume;
  final double? coverage;
  final double overall;
  const ScoreBreakdown(this.speechRate, this.fillers, this.pauses, this.pitch,
      this.volume, this.coverage, this.overall);
}

/// Transparent heuristic (SPEC §9). Weights: rate 25, fillers 20, pauses 15,
/// pitch 20, volume 10, coverage 10 (redistributed proportionally if absent).
/// A coaching indicator, not an objective quality measure.
ScoreBreakdown calculateScore(SessionMetrics m, Duration duration) {
  final minutes = max(duration.inSeconds / 60, 1 / 60);
  final rate = _band(m.averageWpm, 60, 130, 170, 220);
  final fillersPerMin = m.fillerCount / minutes;
  final fillers = _clamp01(1 - fillersPerMin / 6); // 0 fillers/min = 1, >=6/min = 0
  final pauses = _clamp01(1 - m.longPauseCount / max(1, minutes * 2));
  final std = m.pitchStdDev;
  final pitch = std == null ? 0.5 : _clamp01(std / 30); // >=30 Hz std = full marks
  final cv = m.volumeVariation;
  final volume = cv == null ? 0.5 : _band(cv, -1, 0, 0.6, 1.2);
  final cov = m.keywordCoverage != null && m.scriptCoverage != null
      ? (m.keywordCoverage! + m.scriptCoverage!) / 2
      : m.scriptCoverage ?? m.keywordCoverage;

  final parts = <(double, double)>[
    (0.25, rate),
    (0.20, fillers),
    (0.15, pauses),
    (0.20, pitch),
    (0.10, volume),
    if (cov != null) (0.10, cov),
  ];
  final w = parts.fold<double>(0, (a, p) => a + p.$1);
  final overall = parts.fold<double>(0, (a, p) => a + p.$1 * p.$2) / w * 100;
  return ScoreBreakdown(rate, fillers, pauses, pitch, volume, cov, overall);
}

List<String> recommendations(SessionMetrics m, ScoreBreakdown b, Duration d) {
  final r = <String>[];
  if (m.averageWpm > 190) {
    r.add('You spoke very fast (${m.averageWpm.round()} WPM). Breathe between sentences.');
  } else if (m.averageWpm > 170) {
    r.add('Pace was a bit fast (${m.averageWpm.round()} WPM). Aim for 130–170.');
  } else if (m.averageWpm > 0 && m.averageWpm < 100) {
    r.add('Pace was slow (${m.averageWpm.round()} WPM). Try rehearsing until it flows.');
  }
  if (b.fillers < 0.6) {
    r.add('${m.fillerCount} filler words. Replace them with a short silent pause.');
  }
  if (m.longPauseCount > 0) {
    r.add('${m.longPauseCount} long pause(s) over 3 s. Use a cue card for key points.');
  }
  if (b.pitch < 0.5) {
    r.add('Pitch stayed fairly flat. Emphasize key words by changing pitch.');
  }
  if (b.volume < 0.5) {
    r.add('Volume varied a lot. Keep a steady distance from the microphone.');
  }
  if (b.coverage != null && b.coverage! < 0.6) {
    r.add('Covered only ${(b.coverage! * 100).round()}% of your script/keywords.');
  }
  if (r.isEmpty) r.add('Solid delivery. Keep practicing to stay consistent.');
  return r;
}
