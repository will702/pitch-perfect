import '../audio/audio_chunk.dart';
import 'speech_recognition_result.dart';

abstract interface class SpeechRecognitionEngine {
  /// Loads models etc. May emit progress via [initProgress].
  Future<void> initialize();

  /// 0..1 while [initialize] is working (e.g. model download); null otherwise.
  Stream<double> get initProgress;

  /// Emits partial results (isFinal=false) that are superseded by the next
  /// result, and final results that are never revised.
  Stream<SpeechRecognitionResult> recognize(Stream<AudioChunk> audio);

  Future<void> reset();

  Future<void> dispose();
}
