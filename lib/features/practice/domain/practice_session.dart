import '../../../core/analysis/pause_detector.dart';
import 'session_metrics.dart';
import 'transcript_segment.dart';

enum PracticeMode { free, script, pitch }

class SessionConfig {
  final String title;
  final String language; // 'en' | 'id'
  final PracticeMode mode;
  final double? targetDurationSeconds;
  final String? script;
  final List<String> keywords;

  const SessionConfig({
    this.title = 'Practice',
    this.language = 'en',
    this.mode = PracticeMode.free,
    this.targetDurationSeconds,
    this.script,
    this.keywords = const [],
  });
}

enum FeedbackSeverity { info, warning }

class FeedbackEvent {
  final String type;
  final String message;
  final double timestamp; // seconds from session start
  final FeedbackSeverity severity;
  const FeedbackEvent({
    required this.type,
    required this.message,
    required this.timestamp,
    this.severity = FeedbackSeverity.info,
  });
}

/// ~1 Hz aggregate; raw 20 ms DSP frames are never persisted.
class MetricSnapshot {
  final double t;
  final double wpm;
  final double? f0Hz;
  final double rms;
  const MetricSnapshot(this.t, this.wpm, this.f0Hz, this.rms);
}

class PracticeSession {
  final String id;
  final SessionConfig config;
  final DateTime startedAt;
  final DateTime? endedAt;
  final SessionMetrics metrics;
  final List<TranscriptSegment> transcript;
  final List<FeedbackEvent> feedback;
  final List<MetricSnapshot> snapshots;
  final List<PauseEvent> pauses;
  final Map<String, int> fillerBreakdown;
  final List<String> missedKeywords;
  final List<String> missedScriptSentences;

  const PracticeSession({
    required this.id,
    required this.config,
    required this.startedAt,
    required this.endedAt,
    required this.metrics,
    required this.transcript,
    required this.feedback,
    required this.snapshots,
    required this.pauses,
    this.fillerBreakdown = const {},
    this.missedKeywords = const [],
    this.missedScriptSentences = const [],
  });

  Duration get duration =>
      (endedAt ?? DateTime.now()).difference(startedAt);
}
