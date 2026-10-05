import 'dart:async';
import 'dart:typed_data';

import 'package:record/record.dart';

import 'audio_capture_service.dart';
import 'audio_chunk.dart';

const kSampleRate = 16000;

/// Converts little-endian PCM16 bytes to Float32 [-1, 1].
Float32List pcm16ToFloat(Uint8List bytes) {
  final n = bytes.length ~/ 2;
  final view = ByteData.sublistView(bytes);
  final out = Float32List(n);
  for (var i = 0; i < n; i++) {
    out[i] = view.getInt16(i * 2, Endian.little) / 32768.0;
  }
  return out;
}

class RecordAudioCaptureService implements AudioCaptureService {
  final AudioRecorder _recorder = AudioRecorder();
  StreamSubscription<Uint8List>? _sub;
  StreamController<AudioChunk>? _out;

  @override
  Future<bool> requestPermission() => _recorder.hasPermission();

  @override
  Future<Stream<AudioChunk>> start() async {
    if (!await _recorder.hasPermission()) {
      throw StateError('Microphone permission denied');
    }
    final out = StreamController<AudioChunk>();
    _out = out;
    var samplesSeen = 0;
    final raw = await _recorder.startStream(const RecordConfig(
      encoder: AudioEncoder.pcm16bits,
      sampleRate: kSampleRate,
      numChannels: 1,
    ));
    _sub = raw.listen(
      (bytes) {
        final samples = pcm16ToFloat(bytes);
        if (samples.isEmpty) return;
        out.add(AudioChunk(
          samples: samples,
          sampleRate: kSampleRate,
          channelCount: 1,
          timestamp: Duration(microseconds: samplesSeen * 1000000 ~/ kSampleRate),
        ));
        samplesSeen += samples.length;
      },
      onError: out.addError,
      onDone: out.close,
    );
    return out.stream;
  }

  @override
  Future<void> stop() async {
    try {
      await _sub?.cancel();
      if (await _recorder.isRecording()) await _recorder.stop();
    } finally {
      _sub = null;
      final out = _out;
      _out = null;
      if (out != null && !out.isClosed) await out.close();
    }
  }

  @override
  Future<void> dispose() async {
    await stop();
    await _recorder.dispose();
  }
}
