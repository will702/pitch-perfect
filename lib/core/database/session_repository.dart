import 'dart:convert';

import 'package:drift/drift.dart';

import '../analysis/pause_detector.dart';
import '../../features/practice/domain/practice_session.dart';
import '../../features/practice/domain/session_metrics.dart';
import '../../features/practice/domain/transcript_segment.dart';
import 'database.dart';

class SessionRepository {
  SessionRepository(this.db);
  final AppDatabase db;

  Future<void> save(PracticeSession s) => db.transaction(() async {
        final m = s.metrics;
        await db.into(db.sessions).insertOnConflictUpdate(SessionsCompanion.insert(
              id: s.id,
              title: s.config.title,
              language: s.config.language,
              mode: s.config.mode.index,
              targetDurationSeconds: Value(s.config.targetDurationSeconds),
              script: Value(s.config.script),
              keywordsJson: Value(jsonEncode(s.config.keywords)),
              startedAt: s.startedAt,
              endedAt: Value(s.endedAt),
              metricsJson: jsonEncode({
                'averageWpm': m.averageWpm,
                'fillerCount': m.fillerCount,
                'pauseCount': m.pauseCount,
                'longPauseCount': m.longPauseCount,
                'averagePitchHz': m.averagePitchHz,
                'pitchStdDev': m.pitchStdDev,
                'averageRms': m.averageRms,
                'volumeVariation': m.volumeVariation,
                'scriptCoverage': m.scriptCoverage,
                'keywordCoverage': m.keywordCoverage,
                'overallScore': m.overallScore,
              }),
              extraJson: Value(jsonEncode({
                'fillers': s.fillerBreakdown,
                'missedKeywords': s.missedKeywords,
                'missedSentences': s.missedScriptSentences,
              })),
            ));
        await db.batch((b) {
          b.insertAll(db.transcriptSegments, [
            for (final t in s.transcript)
              TranscriptSegmentsCompanion.insert(
                id: t.id,
                sessionId: s.id,
                startSeconds: t.startSeconds,
                endSeconds: t.endSeconds,
                body: t.text,
                confidence: Value(t.confidence),
              )
          ]);
          b.insertAll(db.feedbackEventRows, [
            for (final f in s.feedback)
              FeedbackEventRowsCompanion.insert(
                sessionId: s.id,
                type: f.type,
                message: f.message,
                timestamp: f.timestamp,
                severity: f.severity.index,
              )
          ]);
          b.insertAll(db.metricSnapshotRows, [
            for (final x in s.snapshots)
              MetricSnapshotRowsCompanion.insert(
                sessionId: s.id,
                t: x.t,
                wpm: x.wpm,
                f0: Value(x.f0Hz),
                rms: x.rms,
              )
          ]);
          b.insertAll(db.pauseEventRows, [
            for (final p in s.pauses)
              PauseEventRowsCompanion.insert(
                sessionId: s.id,
                startMs: p.start.inMilliseconds,
                endMs: p.end.inMilliseconds,
              )
          ]);
        });
      });

  /// Newest first; metrics only (no child rows).
  Stream<List<PracticeSession>> watchAll() {
    final q = db.select(db.sessions)
      ..orderBy([(t) => OrderingTerm.desc(t.startedAt)]);
    return q.watch().map((rows) => [for (final r in rows) _toSession(r)]);
  }

  Future<PracticeSession?> get(String id) async {
    final row = await (db.select(db.sessions)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    if (row == null) return null;
    final segs = await (db.select(db.transcriptSegments)
          ..where((t) => t.sessionId.equals(id))
          ..orderBy([(t) => OrderingTerm.asc(t.startSeconds)]))
        .get();
    final fb = await (db.select(db.feedbackEventRows)
          ..where((t) => t.sessionId.equals(id))
          ..orderBy([(t) => OrderingTerm.asc(t.timestamp)]))
        .get();
    final snaps = await (db.select(db.metricSnapshotRows)
          ..where((t) => t.sessionId.equals(id))
          ..orderBy([(t) => OrderingTerm.asc(t.t)]))
        .get();
    final pauses = await (db.select(db.pauseEventRows)
          ..where((t) => t.sessionId.equals(id))
          ..orderBy([(t) => OrderingTerm.asc(t.startMs)]))
        .get();
    return _toSession(
      row,
      transcript: [
        for (final t in segs)
          TranscriptSegment(
            id: t.id,
            sessionId: id,
            startSeconds: t.startSeconds,
            endSeconds: t.endSeconds,
            text: t.body,
            isFinal: true,
            confidence: t.confidence,
          )
      ],
      feedback: [
        for (final f in fb)
          FeedbackEvent(
            type: f.type,
            message: f.message,
            timestamp: f.timestamp,
            severity: FeedbackSeverity.values[f.severity],
          )
      ],
      snapshots: [for (final x in snaps) MetricSnapshot(x.t, x.wpm, x.f0, x.rms)],
      pauses: [
        for (final p in pauses)
          PauseEvent(Duration(milliseconds: p.startMs), Duration(milliseconds: p.endMs))
      ],
    );
  }

  Future<void> delete(String id) =>
      (db.delete(db.sessions)..where((t) => t.id.equals(id))).go();

  Future<String?> getSetting(String key) async => (await (db.select(db.settingRows)
            ..where((t) => t.key.equals(key)))
          .getSingleOrNull())
      ?.value;

  Future<void> setSetting(String key, String value) => db
      .into(db.settingRows)
      .insertOnConflictUpdate(SettingRowsCompanion.insert(key: key, value: value));

  PracticeSession _toSession(
    Session r, {
    List<TranscriptSegment> transcript = const [],
    List<FeedbackEvent> feedback = const [],
    List<MetricSnapshot> snapshots = const [],
    List<PauseEvent> pauses = const [],
  }) {
    final m = jsonDecode(r.metricsJson) as Map<String, dynamic>;
    final x = jsonDecode(r.extraJson) as Map<String, dynamic>;
    double? d(String k) => (m[k] as num?)?.toDouble();
    return PracticeSession(
      id: r.id,
      config: SessionConfig(
        title: r.title,
        language: r.language,
        mode: PracticeMode.values[r.mode],
        targetDurationSeconds: r.targetDurationSeconds,
        script: r.script,
        keywords: (jsonDecode(r.keywordsJson) as List).cast<String>(),
      ),
      startedAt: r.startedAt,
      endedAt: r.endedAt,
      metrics: SessionMetrics(
        averageWpm: d('averageWpm') ?? 0,
        fillerCount: (m['fillerCount'] as num?)?.toInt() ?? 0,
        pauseCount: (m['pauseCount'] as num?)?.toInt() ?? 0,
        longPauseCount: (m['longPauseCount'] as num?)?.toInt() ?? 0,
        averagePitchHz: d('averagePitchHz'),
        pitchStdDev: d('pitchStdDev'),
        averageRms: d('averageRms'),
        volumeVariation: d('volumeVariation'),
        scriptCoverage: d('scriptCoverage'),
        keywordCoverage: d('keywordCoverage'),
        overallScore: d('overallScore'),
      ),
      transcript: transcript,
      feedback: feedback,
      snapshots: snapshots,
      pauses: pauses,
      fillerBreakdown: (x['fillers'] as Map? ?? {}).map((k, v) => MapEntry(k as String, (v as num).toInt())),
      missedKeywords: (x['missedKeywords'] as List? ?? []).cast<String>(),
      missedScriptSentences: (x['missedSentences'] as List? ?? []).cast<String>(),
    );
  }
}
