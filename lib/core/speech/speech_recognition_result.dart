class SpeechRecognitionResult {
  final String text;
  final Duration start;
  final Duration end;
  final bool isFinal;
  final double? confidence;

  /// Benchmark hooks (ARCHITECTURE §19). `end` is the audio_timestamp.
  final DateTime? inferenceStartedAt;
  final DateTime? resultReceivedAt;

  const SpeechRecognitionResult({
    required this.text,
    required this.start,
    required this.end,
    required this.isFinal,
    this.confidence,
    this.inferenceStartedAt,
    this.resultReceivedAt,
  });
}
