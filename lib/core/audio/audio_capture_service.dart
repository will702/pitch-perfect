import 'audio_chunk.dart';

abstract interface class AudioCaptureService {
  Future<bool> requestPermission();

  /// Starts capture. Stream ends after [stop]. Raw audio is never persisted.
  Future<Stream<AudioChunk>> start();

  Future<void> stop();

  Future<void> dispose();
}
