import 'dart:typed_data';

/// Normalized audio: 16 kHz, mono, Float32 in [-1, 1].
class AudioChunk {
  final Float32List samples;
  final int sampleRate;
  final int channelCount;

  /// Offset of the first sample from the start of the session.
  final Duration timestamp;

  const AudioChunk({
    required this.samples,
    required this.sampleRate,
    required this.channelCount,
    required this.timestamp,
  });

  Duration get duration =>
      Duration(microseconds: samples.length * 1000000 ~/ sampleRate);

  Duration get end => timestamp + duration;
}
