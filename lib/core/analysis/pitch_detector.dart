import 'dart:typed_data';

/// YIN fundamental-frequency estimator (de Cheveigné & Kawahara, 2002).
/// Returns null when no clear periodicity is found (unvoiced).
class PitchDetector {
  PitchDetector({
    this.sampleRate = 16000,
    this.minHz = 70,
    this.maxHz = 400,
    this.threshold = 0.15,
  });

  final int sampleRate;
  final double minHz;
  final double maxHz;
  final double threshold;

  double? detect(Float32List frame) {
    final tauMin = (sampleRate / maxHz).floor();
    final tauMax = (sampleRate / minHz).ceil();
    final half = frame.length ~/ 2;
    if (half <= tauMax) throw ArgumentError('frame too short for $minHz Hz');

    // Difference function + cumulative mean normalized difference.
    final cmnd = Float64List(tauMax + 1);
    cmnd[0] = 1;
    var running = 0.0;
    for (var tau = 1; tau <= tauMax; tau++) {
      var d = 0.0;
      for (var i = 0; i < half; i++) {
        final delta = frame[i] - frame[i + tau];
        d += delta * delta;
      }
      running += d;
      cmnd[tau] = running == 0 ? 1 : d * tau / running;
    }

    // First dip below threshold, then descend to its local minimum.
    var tau = -1;
    for (var t = tauMin; t < tauMax; t++) {
      if (cmnd[t] < threshold) {
        while (t + 1 < tauMax && cmnd[t + 1] < cmnd[t]) {
          t++;
        }
        tau = t;
        break;
      }
    }
    if (tau < 0) return null;

    // Parabolic interpolation.
    var better = tau.toDouble();
    if (tau > 1 && tau < tauMax) {
      final s0 = cmnd[tau - 1], s1 = cmnd[tau], s2 = cmnd[tau + 1];
      final denom = 2 * (2 * s1 - s2 - s0);
      if (denom != 0) better = tau + (s2 - s0) / denom;
    }
    return sampleRate / better;
  }
}
