import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'database.g.dart';

class Sessions extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get language => text()();
  IntColumn get mode => integer()();
  RealColumn get targetDurationSeconds => real().nullable()();
  TextColumn get script => text().nullable()();
  TextColumn get keywordsJson => text().withDefault(const Constant('[]'))();
  DateTimeColumn get startedAt => dateTime()();
  DateTimeColumn get endedAt => dateTime().nullable()();
  TextColumn get metricsJson => text()();
  TextColumn get extraJson => text().withDefault(const Constant('{}'))();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('TranscriptRow')
class TranscriptSegments extends Table {
  TextColumn get id => text()();
  TextColumn get sessionId =>
      text().references(Sessions, #id, onDelete: KeyAction.cascade)();
  RealColumn get startSeconds => real()();
  RealColumn get endSeconds => real()();
  TextColumn get body => text()();
  RealColumn get confidence => real().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class FeedbackEventRows extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get sessionId =>
      text().references(Sessions, #id, onDelete: KeyAction.cascade)();
  TextColumn get type => text()();
  TextColumn get message => text()();
  RealColumn get timestamp => real()();
  IntColumn get severity => integer()();
}

class MetricSnapshotRows extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get sessionId =>
      text().references(Sessions, #id, onDelete: KeyAction.cascade)();
  RealColumn get t => real()();
  RealColumn get wpm => real()();
  RealColumn get f0 => real().nullable()();
  RealColumn get rms => real()();
}

class PauseEventRows extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get sessionId =>
      text().references(Sessions, #id, onDelete: KeyAction.cascade)();
  IntColumn get startMs => integer()();
  IntColumn get endMs => integer()();
}

class SettingRows extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();

  @override
  Set<Column> get primaryKey => {key};
}

@DriftDatabase(tables: [
  Sessions,
  TranscriptSegments,
  FeedbackEventRows,
  MetricSnapshotRows,
  PauseEventRows,
  SettingRows,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? e]) : super(e ?? driftDatabase(name: 'pitch_perfect'));

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        beforeOpen: (d) async => customStatement('PRAGMA foreign_keys = ON'),
      );
}
