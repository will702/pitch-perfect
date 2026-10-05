import 'dart:math';
import 'dart:typed_data';

import 'pause_detector.dart';
import 'pitch_detector.dart';
import 'rms_calculator.dart';

class AudioFeatureSample {
  final Duration timestamp;
  final double rms;
  final double? f0Hz;
  final bool isVoiced;
  const AudioFeatureSample(this.timestamp, this.rms, this.f0Hz, this.isVoiced);
}

/// Frames a PCM stream (1024 window / 512 hop) into feature samples.
/// Pure Dart; run inside an isolate by AudioAnalysisEngine.
class FrameAnalyzer {
  FrameAnalyzer({this.sampleRate = 16000, this.frame = 1024, this.hop = 512})
      : _pitch = PitchDetector(sampleRate: sampleRate);

  final int sampleRate;
  final int frame;
  final int hop;
  final PitchDetector _pitch;
  final _buf = <double>[];
  int _consumed = 0; // samples dropped from buf head
  double _noiseFloor = 0.003;

  /// ponytail: adaptive floor = slow min-tracker; voiced = rms > 3x floor and > 0.008
  List<AudioFeatureSample> add(Float32List samples, Duration chunkStart) {
    if (_buf.isEmpty) _consumed = chunkStart.inMicroseconds * sampleRate ~/ 1000000;
    _buf.addAll(samples);
    final out = <AudioFeatureSample>[];
    while (_buf.length >= frame) {
      final f = Float32List.fromList(_buf.sublist(0, frame));
      final r = rms(f);
      _noiseFloor = r < _noiseFloor ? r : _noiseFloor * 0.9995 + r * 0.0005;
      final voiced = r > max(0.008, _noiseFloor * 3);
      final f0 = voiced ? _pitch.detect(f) : null;
      final t = Duration(microseconds: (_consumed + frame ~/ 2) * 1000000 ~/ sampleRate);
      out.add(AudioFeatureSample(t, r, f0, voiced));
      _buf.removeRange(0, hop);
      _consumed += hop;
    }
    return out;
  }
}

/// Convenience used by tests: pauses from a sequence of samples.
List<PauseEvent> pausesOf(Iterable<AudioFeatureSample> s) {
  final d = PauseDetector();
  final out = <PauseEvent>[];
  for (final x in s) {
    final e = d.onFrame(x.timestamp, x.isVoiced);
    if (e != null) out.add(e);
  }
  return out;
}
