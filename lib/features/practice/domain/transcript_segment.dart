class TranscriptSegment {
  final String id;
  final String sessionId;
  final double startSeconds;
  final double endSeconds;
  final String text;
  final bool isFinal;
  final double? confidence;

  const TranscriptSegment({
    required this.id,
    required this.sessionId,
    required this.startSeconds,
    required this.endSeconds,
    required this.text,
    required this.isFinal,
    this.confidence,
  });
}
