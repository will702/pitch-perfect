// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $SessionsTable extends Sessions with TableInfo<$SessionsTable, Session> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _languageMeta = const VerificationMeta(
    'language',
  );
  @override
  late final GeneratedColumn<String> language = GeneratedColumn<String>(
    'language',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _modeMeta = const VerificationMeta('mode');
  @override
  late final GeneratedColumn<int> mode = GeneratedColumn<int>(
    'mode',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetDurationSecondsMeta =
      const VerificationMeta('targetDurationSeconds');
  @override
  late final GeneratedColumn<double> targetDurationSeconds =
      GeneratedColumn<double>(
        'target_duration_seconds',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _scriptMeta = const VerificationMeta('script');
  @override
  late final GeneratedColumn<String> script = GeneratedColumn<String>(
    'script',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _keywordsJsonMeta = const VerificationMeta(
    'keywordsJson',
  );
  @override
  late final GeneratedColumn<String> keywordsJson = GeneratedColumn<String>(
    'keywords_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endedAtMeta = const VerificationMeta(
    'endedAt',
  );
  @override
  late final GeneratedColumn<DateTime> endedAt = GeneratedColumn<DateTime>(
    'ended_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _metricsJsonMeta = const VerificationMeta(
    'metricsJson',
  );
  @override
  late final GeneratedColumn<String> metricsJson = GeneratedColumn<String>(
    'metrics_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _extraJsonMeta = const VerificationMeta(
    'extraJson',
  );
  @override
  late final GeneratedColumn<String> extraJson = GeneratedColumn<String>(
    'extra_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('{}'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    language,
    mode,
    targetDurationSeconds,
    script,
    keywordsJson,
    startedAt,
    endedAt,
    metricsJson,
    extraJson,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sessions';
  @override
  VerificationContext validateIntegrity(
    Insertable<Session> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('language')) {
      context.handle(
        _languageMeta,
        language.isAcceptableOrUnknown(data['language']!, _languageMeta),
      );
    } else if (isInserting) {
      context.missing(_languageMeta);
    }
    if (data.containsKey('mode')) {
      context.handle(
        _modeMeta,
        mode.isAcceptableOrUnknown(data['mode']!, _modeMeta),
      );
    } else if (isInserting) {
      context.missing(_modeMeta);
    }
    if (data.containsKey('target_duration_seconds')) {
      context.handle(
        _targetDurationSecondsMeta,
        targetDurationSeconds.isAcceptableOrUnknown(
          data['target_duration_seconds']!,
          _targetDurationSecondsMeta,
        ),
      );
    }
    if (data.containsKey('script')) {
      context.handle(
        _scriptMeta,
        script.isAcceptableOrUnknown(data['script']!, _scriptMeta),
      );
    }
    if (data.containsKey('keywords_json')) {
      context.handle(
        _keywordsJsonMeta,
        keywordsJson.isAcceptableOrUnknown(
          data['keywords_json']!,
          _keywordsJsonMeta,
        ),
      );
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('ended_at')) {
      context.handle(
        _endedAtMeta,
        endedAt.isAcceptableOrUnknown(data['ended_at']!, _endedAtMeta),
      );
    }
    if (data.containsKey('metrics_json')) {
      context.handle(
        _metricsJsonMeta,
        metricsJson.isAcceptableOrUnknown(
          data['metrics_json']!,
          _metricsJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_metricsJsonMeta);
    }
    if (data.containsKey('extra_json')) {
      context.handle(
        _extraJsonMeta,
        extraJson.isAcceptableOrUnknown(data['extra_json']!, _extraJsonMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Session map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Session(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      language: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}language'],
      )!,
      mode: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}mode'],
      )!,
      targetDurationSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}target_duration_seconds'],
      ),
      script: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}script'],
      ),
      keywordsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}keywords_json'],
      )!,
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      )!,
      endedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}ended_at'],
      ),
      metricsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}metrics_json'],
      )!,
      extraJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}extra_json'],
      )!,
    );
  }

  @override
  $SessionsTable createAlias(String alias) {
    return $SessionsTable(attachedDatabase, alias);
  }
}

class Session extends DataClass implements Insertable<Session> {
  final String id;
  final String title;
  final String language;
  final int mode;
  final double? targetDurationSeconds;
  final String? script;
  final String keywordsJson;
  final DateTime startedAt;
  final DateTime? endedAt;
  final String metricsJson;
  final String extraJson;
  const Session({
    required this.id,
    required this.title,
    required this.language,
    required this.mode,
    this.targetDurationSeconds,
    this.script,
    required this.keywordsJson,
    required this.startedAt,
    this.endedAt,
    required this.metricsJson,
    required this.extraJson,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['language'] = Variable<String>(language);
    map['mode'] = Variable<int>(mode);
    if (!nullToAbsent || targetDurationSeconds != null) {
      map['target_duration_seconds'] = Variable<double>(targetDurationSeconds);
    }
    if (!nullToAbsent || script != null) {
      map['script'] = Variable<String>(script);
    }
    map['keywords_json'] = Variable<String>(keywordsJson);
    map['started_at'] = Variable<DateTime>(startedAt);
    if (!nullToAbsent || endedAt != null) {
      map['ended_at'] = Variable<DateTime>(endedAt);
    }
    map['metrics_json'] = Variable<String>(metricsJson);
    map['extra_json'] = Variable<String>(extraJson);
    return map;
  }

  SessionsCompanion toCompanion(bool nullToAbsent) {
    return SessionsCompanion(
      id: Value(id),
      title: Value(title),
      language: Value(language),
      mode: Value(mode),
      targetDurationSeconds: targetDurationSeconds == null && nullToAbsent
          ? const Value.absent()
          : Value(targetDurationSeconds),
      script: script == null && nullToAbsent
          ? const Value.absent()
          : Value(script),
      keywordsJson: Value(keywordsJson),
      startedAt: Value(startedAt),
      endedAt: endedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(endedAt),
      metricsJson: Value(metricsJson),
      extraJson: Value(extraJson),
    );
  }

  factory Session.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Session(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      language: serializer.fromJson<String>(json['language']),
      mode: serializer.fromJson<int>(json['mode']),
      targetDurationSeconds: serializer.fromJson<double?>(
        json['targetDurationSeconds'],
      ),
      script: serializer.fromJson<String?>(json['script']),
      keywordsJson: serializer.fromJson<String>(json['keywordsJson']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      endedAt: serializer.fromJson<DateTime?>(json['endedAt']),
      metricsJson: serializer.fromJson<String>(json['metricsJson']),
      extraJson: serializer.fromJson<String>(json['extraJson']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'language': serializer.toJson<String>(language),
      'mode': serializer.toJson<int>(mode),
      'targetDurationSeconds': serializer.toJson<double?>(
        targetDurationSeconds,
      ),
      'script': serializer.toJson<String?>(script),
      'keywordsJson': serializer.toJson<String>(keywordsJson),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'endedAt': serializer.toJson<DateTime?>(endedAt),
      'metricsJson': serializer.toJson<String>(metricsJson),
      'extraJson': serializer.toJson<String>(extraJson),
    };
  }

  Session copyWith({
    String? id,
    String? title,
    String? language,
    int? mode,
    Value<double?> targetDurationSeconds = const Value.absent(),
    Value<String?> script = const Value.absent(),
    String? keywordsJson,
    DateTime? startedAt,
    Value<DateTime?> endedAt = const Value.absent(),
    String? metricsJson,
    String? extraJson,
  }) => Session(
    id: id ?? this.id,
    title: title ?? this.title,
    language: language ?? this.language,
    mode: mode ?? this.mode,
    targetDurationSeconds: targetDurationSeconds.present
        ? targetDurationSeconds.value
        : this.targetDurationSeconds,
    script: script.present ? script.value : this.script,
    keywordsJson: keywordsJson ?? this.keywordsJson,
    startedAt: startedAt ?? this.startedAt,
    endedAt: endedAt.present ? endedAt.value : this.endedAt,
    metricsJson: metricsJson ?? this.metricsJson,
    extraJson: extraJson ?? this.extraJson,
  );
  Session copyWithCompanion(SessionsCompanion data) {
    return Session(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      language: data.language.present ? data.language.value : this.language,
      mode: data.mode.present ? data.mode.value : this.mode,
      targetDurationSeconds: data.targetDurationSeconds.present
          ? data.targetDurationSeconds.value
          : this.targetDurationSeconds,
      script: data.script.present ? data.script.value : this.script,
      keywordsJson: data.keywordsJson.present
          ? data.keywordsJson.value
          : this.keywordsJson,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      endedAt: data.endedAt.present ? data.endedAt.value : this.endedAt,
      metricsJson: data.metricsJson.present
          ? data.metricsJson.value
          : this.metricsJson,
      extraJson: data.extraJson.present ? data.extraJson.value : this.extraJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Session(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('language: $language, ')
          ..write('mode: $mode, ')
          ..write('targetDurationSeconds: $targetDurationSeconds, ')
          ..write('script: $script, ')
          ..write('keywordsJson: $keywordsJson, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('metricsJson: $metricsJson, ')
          ..write('extraJson: $extraJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    language,
    mode,
    targetDurationSeconds,
    script,
    keywordsJson,
    startedAt,
    endedAt,
    metricsJson,
    extraJson,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Session &&
          other.id == this.id &&
          other.title == this.title &&
          other.language == this.language &&
          other.mode == this.mode &&
          other.targetDurationSeconds == this.targetDurationSeconds &&
          other.script == this.script &&
          other.keywordsJson == this.keywordsJson &&
          other.startedAt == this.startedAt &&
          other.endedAt == this.endedAt &&
          other.metricsJson == this.metricsJson &&
          other.extraJson == this.extraJson);
}

class SessionsCompanion extends UpdateCompanion<Session> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> language;
  final Value<int> mode;
  final Value<double?> targetDurationSeconds;
  final Value<String?> script;
  final Value<String> keywordsJson;
  final Value<DateTime> startedAt;
  final Value<DateTime?> endedAt;
  final Value<String> metricsJson;
  final Value<String> extraJson;
  final Value<int> rowid;
  const SessionsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.language = const Value.absent(),
    this.mode = const Value.absent(),
    this.targetDurationSeconds = const Value.absent(),
    this.script = const Value.absent(),
    this.keywordsJson = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.endedAt = const Value.absent(),
    this.metricsJson = const Value.absent(),
    this.extraJson = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SessionsCompanion.insert({
    required String id,
    required String title,
    required String language,
    required int mode,
    this.targetDurationSeconds = const Value.absent(),
    this.script = const Value.absent(),
    this.keywordsJson = const Value.absent(),
    required DateTime startedAt,
    this.endedAt = const Value.absent(),
    required String metricsJson,
    this.extraJson = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title),
       language = Value(language),
       mode = Value(mode),
       startedAt = Value(startedAt),
       metricsJson = Value(metricsJson);
  static Insertable<Session> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? language,
    Expression<int>? mode,
    Expression<double>? targetDurationSeconds,
    Expression<String>? script,
    Expression<String>? keywordsJson,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? endedAt,
    Expression<String>? metricsJson,
    Expression<String>? extraJson,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (language != null) 'language': language,
      if (mode != null) 'mode': mode,
      if (targetDurationSeconds != null)
        'target_duration_seconds': targetDurationSeconds,
      if (script != null) 'script': script,
      if (keywordsJson != null) 'keywords_json': keywordsJson,
      if (startedAt != null) 'started_at': startedAt,
      if (endedAt != null) 'ended_at': endedAt,
      if (metricsJson != null) 'metrics_json': metricsJson,
      if (extraJson != null) 'extra_json': extraJson,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SessionsCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<String>? language,
    Value<int>? mode,
    Value<double?>? targetDurationSeconds,
    Value<String?>? script,
    Value<String>? keywordsJson,
    Value<DateTime>? startedAt,
    Value<DateTime?>? endedAt,
    Value<String>? metricsJson,
    Value<String>? extraJson,
    Value<int>? rowid,
  }) {
    return SessionsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      language: language ?? this.language,
      mode: mode ?? this.mode,
      targetDurationSeconds:
          targetDurationSeconds ?? this.targetDurationSeconds,
      script: script ?? this.script,
      keywordsJson: keywordsJson ?? this.keywordsJson,
      startedAt: startedAt ?? this.startedAt,
      endedAt: endedAt ?? this.endedAt,
      metricsJson: metricsJson ?? this.metricsJson,
      extraJson: extraJson ?? this.extraJson,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (language.present) {
      map['language'] = Variable<String>(language.value);
    }
    if (mode.present) {
      map['mode'] = Variable<int>(mode.value);
    }
    if (targetDurationSeconds.present) {
      map['target_duration_seconds'] = Variable<double>(
        targetDurationSeconds.value,
      );
    }
    if (script.present) {
      map['script'] = Variable<String>(script.value);
    }
    if (keywordsJson.present) {
      map['keywords_json'] = Variable<String>(keywordsJson.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (endedAt.present) {
      map['ended_at'] = Variable<DateTime>(endedAt.value);
    }
    if (metricsJson.present) {
      map['metrics_json'] = Variable<String>(metricsJson.value);
    }
    if (extraJson.present) {
      map['extra_json'] = Variable<String>(extraJson.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SessionsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('language: $language, ')
          ..write('mode: $mode, ')
          ..write('targetDurationSeconds: $targetDurationSeconds, ')
          ..write('script: $script, ')
          ..write('keywordsJson: $keywordsJson, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('metricsJson: $metricsJson, ')
          ..write('extraJson: $extraJson, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TranscriptSegmentsTable extends TranscriptSegments
    with TableInfo<$TranscriptSegmentsTable, TranscriptRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TranscriptSegmentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sessionIdMeta = const VerificationMeta(
    'sessionId',
  );
  @override
  late final GeneratedColumn<String> sessionId = GeneratedColumn<String>(
    'session_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES sessions (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _startSecondsMeta = const VerificationMeta(
    'startSeconds',
  );
  @override
  late final GeneratedColumn<double> startSeconds = GeneratedColumn<double>(
    'start_seconds',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endSecondsMeta = const VerificationMeta(
    'endSeconds',
  );
  @override
  late final GeneratedColumn<double> endSeconds = GeneratedColumn<double>(
    'end_seconds',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bodyMeta = const VerificationMeta('body');
  @override
  late final GeneratedColumn<String> body = GeneratedColumn<String>(
    'body',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _confidenceMeta = const VerificationMeta(
    'confidence',
  );
  @override
  late final GeneratedColumn<double> confidence = GeneratedColumn<double>(
    'confidence',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    sessionId,
    startSeconds,
    endSeconds,
    body,
    confidence,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'transcript_segments';
  @override
  VerificationContext validateIntegrity(
    Insertable<TranscriptRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('session_id')) {
      context.handle(
        _sessionIdMeta,
        sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('start_seconds')) {
      context.handle(
        _startSecondsMeta,
        startSeconds.isAcceptableOrUnknown(
          data['start_seconds']!,
          _startSecondsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_startSecondsMeta);
    }
    if (data.containsKey('end_seconds')) {
      context.handle(
        _endSecondsMeta,
        endSeconds.isAcceptableOrUnknown(data['end_seconds']!, _endSecondsMeta),
      );
    } else if (isInserting) {
      context.missing(_endSecondsMeta);
    }
    if (data.containsKey('body')) {
      context.handle(
        _bodyMeta,
        body.isAcceptableOrUnknown(data['body']!, _bodyMeta),
      );
    } else if (isInserting) {
      context.missing(_bodyMeta);
    }
    if (data.containsKey('confidence')) {
      context.handle(
        _confidenceMeta,
        confidence.isAcceptableOrUnknown(data['confidence']!, _confidenceMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TranscriptRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TranscriptRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      sessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}session_id'],
      )!,
      startSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}start_seconds'],
      )!,
      endSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}end_seconds'],
      )!,
      body: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}body'],
      )!,
      confidence: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}confidence'],
      ),
    );
  }

  @override
  $TranscriptSegmentsTable createAlias(String alias) {
    return $TranscriptSegmentsTable(attachedDatabase, alias);
  }
}

class TranscriptRow extends DataClass implements Insertable<TranscriptRow> {
  final String id;
  final String sessionId;
  final double startSeconds;
  final double endSeconds;
  final String body;
  final double? confidence;
  const TranscriptRow({
    required this.id,
    required this.sessionId,
    required this.startSeconds,
    required this.endSeconds,
    required this.body,
    this.confidence,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['session_id'] = Variable<String>(sessionId);
    map['start_seconds'] = Variable<double>(startSeconds);
    map['end_seconds'] = Variable<double>(endSeconds);
    map['body'] = Variable<String>(body);
    if (!nullToAbsent || confidence != null) {
      map['confidence'] = Variable<double>(confidence);
    }
    return map;
  }

  TranscriptSegmentsCompanion toCompanion(bool nullToAbsent) {
    return TranscriptSegmentsCompanion(
      id: Value(id),
      sessionId: Value(sessionId),
      startSeconds: Value(startSeconds),
      endSeconds: Value(endSeconds),
      body: Value(body),
      confidence: confidence == null && nullToAbsent
          ? const Value.absent()
          : Value(confidence),
    );
  }

  factory TranscriptRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TranscriptRow(
      id: serializer.fromJson<String>(json['id']),
      sessionId: serializer.fromJson<String>(json['sessionId']),
      startSeconds: serializer.fromJson<double>(json['startSeconds']),
      endSeconds: serializer.fromJson<double>(json['endSeconds']),
      body: serializer.fromJson<String>(json['body']),
      confidence: serializer.fromJson<double?>(json['confidence']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'sessionId': serializer.toJson<String>(sessionId),
      'startSeconds': serializer.toJson<double>(startSeconds),
      'endSeconds': serializer.toJson<double>(endSeconds),
      'body': serializer.toJson<String>(body),
      'confidence': serializer.toJson<double?>(confidence),
    };
  }

  TranscriptRow copyWith({
    String? id,
    String? sessionId,
    double? startSeconds,
    double? endSeconds,
    String? body,
    Value<double?> confidence = const Value.absent(),
  }) => TranscriptRow(
    id: id ?? this.id,
    sessionId: sessionId ?? this.sessionId,
    startSeconds: startSeconds ?? this.startSeconds,
    endSeconds: endSeconds ?? this.endSeconds,
    body: body ?? this.body,
    confidence: confidence.present ? confidence.value : this.confidence,
  );
  TranscriptRow copyWithCompanion(TranscriptSegmentsCompanion data) {
    return TranscriptRow(
      id: data.id.present ? data.id.value : this.id,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      startSeconds: data.startSeconds.present
          ? data.startSeconds.value
          : this.startSeconds,
      endSeconds: data.endSeconds.present
          ? data.endSeconds.value
          : this.endSeconds,
      body: data.body.present ? data.body.value : this.body,
      confidence: data.confidence.present
          ? data.confidence.value
          : this.confidence,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TranscriptRow(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('startSeconds: $startSeconds, ')
          ..write('endSeconds: $endSeconds, ')
          ..write('body: $body, ')
          ..write('confidence: $confidence')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, sessionId, startSeconds, endSeconds, body, confidence);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TranscriptRow &&
          other.id == this.id &&
          other.sessionId == this.sessionId &&
          other.startSeconds == this.startSeconds &&
          other.endSeconds == this.endSeconds &&
          other.body == this.body &&
          other.confidence == this.confidence);
}

class TranscriptSegmentsCompanion extends UpdateCompanion<TranscriptRow> {
  final Value<String> id;
  final Value<String> sessionId;
  final Value<double> startSeconds;
  final Value<double> endSeconds;
  final Value<String> body;
  final Value<double?> confidence;
  final Value<int> rowid;
  const TranscriptSegmentsCompanion({
    this.id = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.startSeconds = const Value.absent(),
    this.endSeconds = const Value.absent(),
    this.body = const Value.absent(),
    this.confidence = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TranscriptSegmentsCompanion.insert({
    required String id,
    required String sessionId,
    required double startSeconds,
    required double endSeconds,
    required String body,
    this.confidence = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       sessionId = Value(sessionId),
       startSeconds = Value(startSeconds),
       endSeconds = Value(endSeconds),
       body = Value(body);
  static Insertable<TranscriptRow> custom({
    Expression<String>? id,
    Expression<String>? sessionId,
    Expression<double>? startSeconds,
    Expression<double>? endSeconds,
    Expression<String>? body,
    Expression<double>? confidence,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sessionId != null) 'session_id': sessionId,
      if (startSeconds != null) 'start_seconds': startSeconds,
      if (endSeconds != null) 'end_seconds': endSeconds,
      if (body != null) 'body': body,
      if (confidence != null) 'confidence': confidence,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TranscriptSegmentsCompanion copyWith({
    Value<String>? id,
    Value<String>? sessionId,
    Value<double>? startSeconds,
    Value<double>? endSeconds,
    Value<String>? body,
    Value<double?>? confidence,
    Value<int>? rowid,
  }) {
    return TranscriptSegmentsCompanion(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      startSeconds: startSeconds ?? this.startSeconds,
      endSeconds: endSeconds ?? this.endSeconds,
      body: body ?? this.body,
      confidence: confidence ?? this.confidence,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (sessionId.present) {
      map['session_id'] = Variable<String>(sessionId.value);
    }
    if (startSeconds.present) {
      map['start_seconds'] = Variable<double>(startSeconds.value);
    }
    if (endSeconds.present) {
      map['end_seconds'] = Variable<double>(endSeconds.value);
    }
    if (body.present) {
      map['body'] = Variable<String>(body.value);
    }
    if (confidence.present) {
      map['confidence'] = Variable<double>(confidence.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TranscriptSegmentsCompanion(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('startSeconds: $startSeconds, ')
          ..write('endSeconds: $endSeconds, ')
          ..write('body: $body, ')
          ..write('confidence: $confidence, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FeedbackEventRowsTable extends FeedbackEventRows
    with TableInfo<$FeedbackEventRowsTable, FeedbackEventRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FeedbackEventRowsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _sessionIdMeta = const VerificationMeta(
    'sessionId',
  );
  @override
  late final GeneratedColumn<String> sessionId = GeneratedColumn<String>(
    'session_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES sessions (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _messageMeta = const VerificationMeta(
    'message',
  );
  @override
  late final GeneratedColumn<String> message = GeneratedColumn<String>(
    'message',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timestampMeta = const VerificationMeta(
    'timestamp',
  );
  @override
  late final GeneratedColumn<double> timestamp = GeneratedColumn<double>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _severityMeta = const VerificationMeta(
    'severity',
  );
  @override
  late final GeneratedColumn<int> severity = GeneratedColumn<int>(
    'severity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    sessionId,
    type,
    message,
    timestamp,
    severity,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'feedback_event_rows';
  @override
  VerificationContext validateIntegrity(
    Insertable<FeedbackEventRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('session_id')) {
      context.handle(
        _sessionIdMeta,
        sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('message')) {
      context.handle(
        _messageMeta,
        message.isAcceptableOrUnknown(data['message']!, _messageMeta),
      );
    } else if (isInserting) {
      context.missing(_messageMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    if (data.containsKey('severity')) {
      context.handle(
        _severityMeta,
        severity.isAcceptableOrUnknown(data['severity']!, _severityMeta),
      );
    } else if (isInserting) {
      context.missing(_severityMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FeedbackEventRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FeedbackEventRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      sessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}session_id'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      message: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}message'],
      )!,
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}timestamp'],
      )!,
      severity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}severity'],
      )!,
    );
  }

  @override
  $FeedbackEventRowsTable createAlias(String alias) {
    return $FeedbackEventRowsTable(attachedDatabase, alias);
  }
}

class FeedbackEventRow extends DataClass
    implements Insertable<FeedbackEventRow> {
  final int id;
  final String sessionId;
  final String type;
  final String message;
  final double timestamp;
  final int severity;
  const FeedbackEventRow({
    required this.id,
    required this.sessionId,
    required this.type,
    required this.message,
    required this.timestamp,
    required this.severity,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['session_id'] = Variable<String>(sessionId);
    map['type'] = Variable<String>(type);
    map['message'] = Variable<String>(message);
    map['timestamp'] = Variable<double>(timestamp);
    map['severity'] = Variable<int>(severity);
    return map;
  }

  FeedbackEventRowsCompanion toCompanion(bool nullToAbsent) {
    return FeedbackEventRowsCompanion(
      id: Value(id),
      sessionId: Value(sessionId),
      type: Value(type),
      message: Value(message),
      timestamp: Value(timestamp),
      severity: Value(severity),
    );
  }

  factory FeedbackEventRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FeedbackEventRow(
      id: serializer.fromJson<int>(json['id']),
      sessionId: serializer.fromJson<String>(json['sessionId']),
      type: serializer.fromJson<String>(json['type']),
      message: serializer.fromJson<String>(json['message']),
      timestamp: serializer.fromJson<double>(json['timestamp']),
      severity: serializer.fromJson<int>(json['severity']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sessionId': serializer.toJson<String>(sessionId),
      'type': serializer.toJson<String>(type),
      'message': serializer.toJson<String>(message),
      'timestamp': serializer.toJson<double>(timestamp),
      'severity': serializer.toJson<int>(severity),
    };
  }

  FeedbackEventRow copyWith({
    int? id,
    String? sessionId,
    String? type,
    String? message,
    double? timestamp,
    int? severity,
  }) => FeedbackEventRow(
    id: id ?? this.id,
    sessionId: sessionId ?? this.sessionId,
    type: type ?? this.type,
    message: message ?? this.message,
    timestamp: timestamp ?? this.timestamp,
    severity: severity ?? this.severity,
  );
  FeedbackEventRow copyWithCompanion(FeedbackEventRowsCompanion data) {
    return FeedbackEventRow(
      id: data.id.present ? data.id.value : this.id,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      type: data.type.present ? data.type.value : this.type,
      message: data.message.present ? data.message.value : this.message,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      severity: data.severity.present ? data.severity.value : this.severity,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FeedbackEventRow(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('type: $type, ')
          ..write('message: $message, ')
          ..write('timestamp: $timestamp, ')
          ..write('severity: $severity')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, sessionId, type, message, timestamp, severity);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FeedbackEventRow &&
          other.id == this.id &&
          other.sessionId == this.sessionId &&
          other.type == this.type &&
          other.message == this.message &&
          other.timestamp == this.timestamp &&
          other.severity == this.severity);
}

class FeedbackEventRowsCompanion extends UpdateCompanion<FeedbackEventRow> {
  final Value<int> id;
  final Value<String> sessionId;
  final Value<String> type;
  final Value<String> message;
  final Value<double> timestamp;
  final Value<int> severity;
  const FeedbackEventRowsCompanion({
    this.id = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.type = const Value.absent(),
    this.message = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.severity = const Value.absent(),
  });
  FeedbackEventRowsCompanion.insert({
    this.id = const Value.absent(),
    required String sessionId,
    required String type,
    required String message,
    required double timestamp,
    required int severity,
  }) : sessionId = Value(sessionId),
       type = Value(type),
       message = Value(message),
       timestamp = Value(timestamp),
       severity = Value(severity);
  static Insertable<FeedbackEventRow> custom({
    Expression<int>? id,
    Expression<String>? sessionId,
    Expression<String>? type,
    Expression<String>? message,
    Expression<double>? timestamp,
    Expression<int>? severity,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sessionId != null) 'session_id': sessionId,
      if (type != null) 'type': type,
      if (message != null) 'message': message,
      if (timestamp != null) 'timestamp': timestamp,
      if (severity != null) 'severity': severity,
    });
  }

  FeedbackEventRowsCompanion copyWith({
    Value<int>? id,
    Value<String>? sessionId,
    Value<String>? type,
    Value<String>? message,
    Value<double>? timestamp,
    Value<int>? severity,
  }) {
    return FeedbackEventRowsCompanion(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      type: type ?? this.type,
      message: message ?? this.message,
      timestamp: timestamp ?? this.timestamp,
      severity: severity ?? this.severity,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sessionId.present) {
      map['session_id'] = Variable<String>(sessionId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (message.present) {
      map['message'] = Variable<String>(message.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<double>(timestamp.value);
    }
    if (severity.present) {
      map['severity'] = Variable<int>(severity.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FeedbackEventRowsCompanion(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('type: $type, ')
          ..write('message: $message, ')
          ..write('timestamp: $timestamp, ')
          ..write('severity: $severity')
          ..write(')'))
        .toString();
  }
}

class $MetricSnapshotRowsTable extends MetricSnapshotRows
    with TableInfo<$MetricSnapshotRowsTable, MetricSnapshotRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MetricSnapshotRowsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _sessionIdMeta = const VerificationMeta(
    'sessionId',
  );
  @override
  late final GeneratedColumn<String> sessionId = GeneratedColumn<String>(
    'session_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES sessions (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _tMeta = const VerificationMeta('t');
  @override
  late final GeneratedColumn<double> t = GeneratedColumn<double>(
    't',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _wpmMeta = const VerificationMeta('wpm');
  @override
  late final GeneratedColumn<double> wpm = GeneratedColumn<double>(
    'wpm',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _f0Meta = const VerificationMeta('f0');
  @override
  late final GeneratedColumn<double> f0 = GeneratedColumn<double>(
    'f0',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _rmsMeta = const VerificationMeta('rms');
  @override
  late final GeneratedColumn<double> rms = GeneratedColumn<double>(
    'rms',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, sessionId, t, wpm, f0, rms];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'metric_snapshot_rows';
  @override
  VerificationContext validateIntegrity(
    Insertable<MetricSnapshotRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('session_id')) {
      context.handle(
        _sessionIdMeta,
        sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('t')) {
      context.handle(_tMeta, t.isAcceptableOrUnknown(data['t']!, _tMeta));
    } else if (isInserting) {
      context.missing(_tMeta);
    }
    if (data.containsKey('wpm')) {
      context.handle(
        _wpmMeta,
        wpm.isAcceptableOrUnknown(data['wpm']!, _wpmMeta),
      );
    } else if (isInserting) {
      context.missing(_wpmMeta);
    }
    if (data.containsKey('f0')) {
      context.handle(_f0Meta, f0.isAcceptableOrUnknown(data['f0']!, _f0Meta));
    }
    if (data.containsKey('rms')) {
      context.handle(
        _rmsMeta,
        rms.isAcceptableOrUnknown(data['rms']!, _rmsMeta),
      );
    } else if (isInserting) {
      context.missing(_rmsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MetricSnapshotRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MetricSnapshotRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      sessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}session_id'],
      )!,
      t: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}t'],
      )!,
      wpm: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}wpm'],
      )!,
      f0: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}f0'],
      ),
      rms: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}rms'],
      )!,
    );
  }

  @override
  $MetricSnapshotRowsTable createAlias(String alias) {
    return $MetricSnapshotRowsTable(attachedDatabase, alias);
  }
}

class MetricSnapshotRow extends DataClass
    implements Insertable<MetricSnapshotRow> {
  final int id;
  final String sessionId;
  final double t;
  final double wpm;
  final double? f0;
  final double rms;
  const MetricSnapshotRow({
    required this.id,
    required this.sessionId,
    required this.t,
    required this.wpm,
    this.f0,
    required this.rms,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['session_id'] = Variable<String>(sessionId);
    map['t'] = Variable<double>(t);
    map['wpm'] = Variable<double>(wpm);
    if (!nullToAbsent || f0 != null) {
      map['f0'] = Variable<double>(f0);
    }
    map['rms'] = Variable<double>(rms);
    return map;
  }

  MetricSnapshotRowsCompanion toCompanion(bool nullToAbsent) {
    return MetricSnapshotRowsCompanion(
      id: Value(id),
      sessionId: Value(sessionId),
      t: Value(t),
      wpm: Value(wpm),
      f0: f0 == null && nullToAbsent ? const Value.absent() : Value(f0),
      rms: Value(rms),
    );
  }

  factory MetricSnapshotRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MetricSnapshotRow(
      id: serializer.fromJson<int>(json['id']),
      sessionId: serializer.fromJson<String>(json['sessionId']),
      t: serializer.fromJson<double>(json['t']),
      wpm: serializer.fromJson<double>(json['wpm']),
      f0: serializer.fromJson<double?>(json['f0']),
      rms: serializer.fromJson<double>(json['rms']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sessionId': serializer.toJson<String>(sessionId),
      't': serializer.toJson<double>(t),
      'wpm': serializer.toJson<double>(wpm),
      'f0': serializer.toJson<double?>(f0),
      'rms': serializer.toJson<double>(rms),
    };
  }

  MetricSnapshotRow copyWith({
    int? id,
    String? sessionId,
    double? t,
    double? wpm,
    Value<double?> f0 = const Value.absent(),
    double? rms,
  }) => MetricSnapshotRow(
    id: id ?? this.id,
    sessionId: sessionId ?? this.sessionId,
    t: t ?? this.t,
    wpm: wpm ?? this.wpm,
    f0: f0.present ? f0.value : this.f0,
    rms: rms ?? this.rms,
  );
  MetricSnapshotRow copyWithCompanion(MetricSnapshotRowsCompanion data) {
    return MetricSnapshotRow(
      id: data.id.present ? data.id.value : this.id,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      t: data.t.present ? data.t.value : this.t,
      wpm: data.wpm.present ? data.wpm.value : this.wpm,
      f0: data.f0.present ? data.f0.value : this.f0,
      rms: data.rms.present ? data.rms.value : this.rms,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MetricSnapshotRow(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('t: $t, ')
          ..write('wpm: $wpm, ')
          ..write('f0: $f0, ')
          ..write('rms: $rms')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, sessionId, t, wpm, f0, rms);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MetricSnapshotRow &&
          other.id == this.id &&
          other.sessionId == this.sessionId &&
          other.t == this.t &&
          other.wpm == this.wpm &&
          other.f0 == this.f0 &&
          other.rms == this.rms);
}

class MetricSnapshotRowsCompanion extends UpdateCompanion<MetricSnapshotRow> {
  final Value<int> id;
  final Value<String> sessionId;
  final Value<double> t;
  final Value<double> wpm;
  final Value<double?> f0;
  final Value<double> rms;
  const MetricSnapshotRowsCompanion({
    this.id = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.t = const Value.absent(),
    this.wpm = const Value.absent(),
    this.f0 = const Value.absent(),
    this.rms = const Value.absent(),
  });
  MetricSnapshotRowsCompanion.insert({
    this.id = const Value.absent(),
    required String sessionId,
    required double t,
    required double wpm,
    this.f0 = const Value.absent(),
    required double rms,
  }) : sessionId = Value(sessionId),
       t = Value(t),
       wpm = Value(wpm),
       rms = Value(rms);
  static Insertable<MetricSnapshotRow> custom({
    Expression<int>? id,
    Expression<String>? sessionId,
    Expression<double>? t,
    Expression<double>? wpm,
    Expression<double>? f0,
    Expression<double>? rms,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sessionId != null) 'session_id': sessionId,
      if (t != null) 't': t,
      if (wpm != null) 'wpm': wpm,
      if (f0 != null) 'f0': f0,
      if (rms != null) 'rms': rms,
    });
  }

  MetricSnapshotRowsCompanion copyWith({
    Value<int>? id,
    Value<String>? sessionId,
    Value<double>? t,
    Value<double>? wpm,
    Value<double?>? f0,
    Value<double>? rms,
  }) {
    return MetricSnapshotRowsCompanion(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      t: t ?? this.t,
      wpm: wpm ?? this.wpm,
      f0: f0 ?? this.f0,
      rms: rms ?? this.rms,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sessionId.present) {
      map['session_id'] = Variable<String>(sessionId.value);
    }
    if (t.present) {
      map['t'] = Variable<double>(t.value);
    }
    if (wpm.present) {
      map['wpm'] = Variable<double>(wpm.value);
    }
    if (f0.present) {
      map['f0'] = Variable<double>(f0.value);
    }
    if (rms.present) {
      map['rms'] = Variable<double>(rms.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MetricSnapshotRowsCompanion(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('t: $t, ')
          ..write('wpm: $wpm, ')
          ..write('f0: $f0, ')
          ..write('rms: $rms')
          ..write(')'))
        .toString();
  }
}

class $PauseEventRowsTable extends PauseEventRows
    with TableInfo<$PauseEventRowsTable, PauseEventRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PauseEventRowsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _sessionIdMeta = const VerificationMeta(
    'sessionId',
  );
  @override
  late final GeneratedColumn<String> sessionId = GeneratedColumn<String>(
    'session_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES sessions (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _startMsMeta = const VerificationMeta(
    'startMs',
  );
  @override
  late final GeneratedColumn<int> startMs = GeneratedColumn<int>(
    'start_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endMsMeta = const VerificationMeta('endMs');
  @override
  late final GeneratedColumn<int> endMs = GeneratedColumn<int>(
    'end_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, sessionId, startMs, endMs];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pause_event_rows';
  @override
  VerificationContext validateIntegrity(
    Insertable<PauseEventRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('session_id')) {
      context.handle(
        _sessionIdMeta,
        sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('start_ms')) {
      context.handle(
        _startMsMeta,
        startMs.isAcceptableOrUnknown(data['start_ms']!, _startMsMeta),
      );
    } else if (isInserting) {
      context.missing(_startMsMeta);
    }
    if (data.containsKey('end_ms')) {
      context.handle(
        _endMsMeta,
        endMs.isAcceptableOrUnknown(data['end_ms']!, _endMsMeta),
      );
    } else if (isInserting) {
      context.missing(_endMsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PauseEventRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PauseEventRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      sessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}session_id'],
      )!,
      startMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}start_ms'],
      )!,
      endMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}end_ms'],
      )!,
    );
  }

  @override
  $PauseEventRowsTable createAlias(String alias) {
    return $PauseEventRowsTable(attachedDatabase, alias);
  }
}

class PauseEventRow extends DataClass implements Insertable<PauseEventRow> {
  final int id;
  final String sessionId;
  final int startMs;
  final int endMs;
  const PauseEventRow({
    required this.id,
    required this.sessionId,
    required this.startMs,
    required this.endMs,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['session_id'] = Variable<String>(sessionId);
    map['start_ms'] = Variable<int>(startMs);
    map['end_ms'] = Variable<int>(endMs);
    return map;
  }

  PauseEventRowsCompanion toCompanion(bool nullToAbsent) {
    return PauseEventRowsCompanion(
      id: Value(id),
      sessionId: Value(sessionId),
      startMs: Value(startMs),
      endMs: Value(endMs),
    );
  }

  factory PauseEventRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PauseEventRow(
      id: serializer.fromJson<int>(json['id']),
      sessionId: serializer.fromJson<String>(json['sessionId']),
      startMs: serializer.fromJson<int>(json['startMs']),
      endMs: serializer.fromJson<int>(json['endMs']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sessionId': serializer.toJson<String>(sessionId),
      'startMs': serializer.toJson<int>(startMs),
      'endMs': serializer.toJson<int>(endMs),
    };
  }

  PauseEventRow copyWith({
    int? id,
    String? sessionId,
    int? startMs,
    int? endMs,
  }) => PauseEventRow(
    id: id ?? this.id,
    sessionId: sessionId ?? this.sessionId,
    startMs: startMs ?? this.startMs,
    endMs: endMs ?? this.endMs,
  );
  PauseEventRow copyWithCompanion(PauseEventRowsCompanion data) {
    return PauseEventRow(
      id: data.id.present ? data.id.value : this.id,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      startMs: data.startMs.present ? data.startMs.value : this.startMs,
      endMs: data.endMs.present ? data.endMs.value : this.endMs,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PauseEventRow(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('startMs: $startMs, ')
          ..write('endMs: $endMs')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, sessionId, startMs, endMs);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PauseEventRow &&
          other.id == this.id &&
          other.sessionId == this.sessionId &&
          other.startMs == this.startMs &&
          other.endMs == this.endMs);
}

class PauseEventRowsCompanion extends UpdateCompanion<PauseEventRow> {
  final Value<int> id;
  final Value<String> sessionId;
  final Value<int> startMs;
  final Value<int> endMs;
  const PauseEventRowsCompanion({
    this.id = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.startMs = const Value.absent(),
    this.endMs = const Value.absent(),
  });
  PauseEventRowsCompanion.insert({
    this.id = const Value.absent(),
    required String sessionId,
    required int startMs,
    required int endMs,
  }) : sessionId = Value(sessionId),
       startMs = Value(startMs),
       endMs = Value(endMs);
  static Insertable<PauseEventRow> custom({
    Expression<int>? id,
    Expression<String>? sessionId,
    Expression<int>? startMs,
    Expression<int>? endMs,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sessionId != null) 'session_id': sessionId,
      if (startMs != null) 'start_ms': startMs,
      if (endMs != null) 'end_ms': endMs,
    });
  }

  PauseEventRowsCompanion copyWith({
    Value<int>? id,
    Value<String>? sessionId,
    Value<int>? startMs,
    Value<int>? endMs,
  }) {
    return PauseEventRowsCompanion(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      startMs: startMs ?? this.startMs,
      endMs: endMs ?? this.endMs,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sessionId.present) {
      map['session_id'] = Variable<String>(sessionId.value);
    }
    if (startMs.present) {
      map['start_ms'] = Variable<int>(startMs.value);
    }
    if (endMs.present) {
      map['end_ms'] = Variable<int>(endMs.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PauseEventRowsCompanion(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('startMs: $startMs, ')
          ..write('endMs: $endMs')
          ..write(')'))
        .toString();
  }
}

class $SettingRowsTable extends SettingRows
    with TableInfo<$SettingRowsTable, SettingRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SettingRowsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [key, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'setting_rows';
  @override
  VerificationContext validateIntegrity(
    Insertable<SettingRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  SettingRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SettingRow(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
    );
  }

  @override
  $SettingRowsTable createAlias(String alias) {
    return $SettingRowsTable(attachedDatabase, alias);
  }
}

class SettingRow extends DataClass implements Insertable<SettingRow> {
  final String key;
  final String value;
  const SettingRow({required this.key, required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    return map;
  }

  SettingRowsCompanion toCompanion(bool nullToAbsent) {
    return SettingRowsCompanion(key: Value(key), value: Value(value));
  }

  factory SettingRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SettingRow(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
    };
  }

  SettingRow copyWith({String? key, String? value}) =>
      SettingRow(key: key ?? this.key, value: value ?? this.value);
  SettingRow copyWithCompanion(SettingRowsCompanion data) {
    return SettingRow(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SettingRow(')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SettingRow &&
          other.key == this.key &&
          other.value == this.value);
}

class SettingRowsCompanion extends UpdateCompanion<SettingRow> {
  final Value<String> key;
  final Value<String> value;
  final Value<int> rowid;
  const SettingRowsCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SettingRowsCompanion.insert({
    required String key,
    required String value,
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       value = Value(value);
  static Insertable<SettingRow> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SettingRowsCompanion copyWith({
    Value<String>? key,
    Value<String>? value,
    Value<int>? rowid,
  }) {
    return SettingRowsCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SettingRowsCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $SessionsTable sessions = $SessionsTable(this);
  late final $TranscriptSegmentsTable transcriptSegments =
      $TranscriptSegmentsTable(this);
  late final $FeedbackEventRowsTable feedbackEventRows =
      $FeedbackEventRowsTable(this);
  late final $MetricSnapshotRowsTable metricSnapshotRows =
      $MetricSnapshotRowsTable(this);
  late final $PauseEventRowsTable pauseEventRows = $PauseEventRowsTable(this);
  late final $SettingRowsTable settingRows = $SettingRowsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    sessions,
    transcriptSegments,
    feedbackEventRows,
    metricSnapshotRows,
    pauseEventRows,
    settingRows,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'sessions',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('transcript_segments', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'sessions',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('feedback_event_rows', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'sessions',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('metric_snapshot_rows', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'sessions',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('pause_event_rows', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$SessionsTableCreateCompanionBuilder =
    SessionsCompanion Function({
      required String id,
      required String title,
      required String language,
      required int mode,
      Value<double?> targetDurationSeconds,
      Value<String?> script,
      Value<String> keywordsJson,
      required DateTime startedAt,
      Value<DateTime?> endedAt,
      required String metricsJson,
      Value<String> extraJson,
      Value<int> rowid,
    });
typedef $$SessionsTableUpdateCompanionBuilder =
    SessionsCompanion Function({
      Value<String> id,
      Value<String> title,
      Value<String> language,
      Value<int> mode,
      Value<double?> targetDurationSeconds,
      Value<String?> script,
      Value<String> keywordsJson,
      Value<DateTime> startedAt,
      Value<DateTime?> endedAt,
      Value<String> metricsJson,
      Value<String> extraJson,
      Value<int> rowid,
    });

final class $$SessionsTableReferences
    extends BaseReferences<_$AppDatabase, $SessionsTable, Session> {
  $$SessionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$TranscriptSegmentsTable, List<TranscriptRow>>
  _transcriptSegmentsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.transcriptSegments,
        aliasName: 'sessions__id__transcript_segments__session_id',
      );

  $$TranscriptSegmentsTableProcessedTableManager get transcriptSegmentsRefs {
    final manager = $$TranscriptSegmentsTableTableManager(
      $_db,
      $_db.transcriptSegments,
    ).filter((f) => f.sessionId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _transcriptSegmentsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$FeedbackEventRowsTable, List<FeedbackEventRow>>
  _feedbackEventRowsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.feedbackEventRows,
        aliasName: 'sessions__id__feedback_event_rows__session_id',
      );

  $$FeedbackEventRowsTableProcessedTableManager get feedbackEventRowsRefs {
    final manager = $$FeedbackEventRowsTableTableManager(
      $_db,
      $_db.feedbackEventRows,
    ).filter((f) => f.sessionId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _feedbackEventRowsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$MetricSnapshotRowsTable, List<MetricSnapshotRow>>
  _metricSnapshotRowsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.metricSnapshotRows,
        aliasName: 'sessions__id__metric_snapshot_rows__session_id',
      );

  $$MetricSnapshotRowsTableProcessedTableManager get metricSnapshotRowsRefs {
    final manager = $$MetricSnapshotRowsTableTableManager(
      $_db,
      $_db.metricSnapshotRows,
    ).filter((f) => f.sessionId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _metricSnapshotRowsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PauseEventRowsTable, List<PauseEventRow>>
  _pauseEventRowsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.pauseEventRows,
    aliasName: 'sessions__id__pause_event_rows__session_id',
  );

  $$PauseEventRowsTableProcessedTableManager get pauseEventRowsRefs {
    final manager = $$PauseEventRowsTableTableManager(
      $_db,
      $_db.pauseEventRows,
    ).filter((f) => f.sessionId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_pauseEventRowsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SessionsTableFilterComposer
    extends Composer<_$AppDatabase, $SessionsTable> {
  $$SessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get language => $composableBuilder(
    column: $table.language,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get mode => $composableBuilder(
    column: $table.mode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get targetDurationSeconds => $composableBuilder(
    column: $table.targetDurationSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get script => $composableBuilder(
    column: $table.script,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get keywordsJson => $composableBuilder(
    column: $table.keywordsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get metricsJson => $composableBuilder(
    column: $table.metricsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get extraJson => $composableBuilder(
    column: $table.extraJson,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> transcriptSegmentsRefs(
    Expression<bool> Function($$TranscriptSegmentsTableFilterComposer f) f,
  ) {
    final $$TranscriptSegmentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transcriptSegments,
      getReferencedColumn: (t) => t.sessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TranscriptSegmentsTableFilterComposer(
            $db: $db,
            $table: $db.transcriptSegments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> feedbackEventRowsRefs(
    Expression<bool> Function($$FeedbackEventRowsTableFilterComposer f) f,
  ) {
    final $$FeedbackEventRowsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.feedbackEventRows,
      getReferencedColumn: (t) => t.sessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FeedbackEventRowsTableFilterComposer(
            $db: $db,
            $table: $db.feedbackEventRows,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> metricSnapshotRowsRefs(
    Expression<bool> Function($$MetricSnapshotRowsTableFilterComposer f) f,
  ) {
    final $$MetricSnapshotRowsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.metricSnapshotRows,
      getReferencedColumn: (t) => t.sessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MetricSnapshotRowsTableFilterComposer(
            $db: $db,
            $table: $db.metricSnapshotRows,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> pauseEventRowsRefs(
    Expression<bool> Function($$PauseEventRowsTableFilterComposer f) f,
  ) {
    final $$PauseEventRowsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pauseEventRows,
      getReferencedColumn: (t) => t.sessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PauseEventRowsTableFilterComposer(
            $db: $db,
            $table: $db.pauseEventRows,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $SessionsTable> {
  $$SessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get language => $composableBuilder(
    column: $table.language,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get mode => $composableBuilder(
    column: $table.mode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get targetDurationSeconds => $composableBuilder(
    column: $table.targetDurationSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get script => $composableBuilder(
    column: $table.script,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get keywordsJson => $composableBuilder(
    column: $table.keywordsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get metricsJson => $composableBuilder(
    column: $table.metricsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get extraJson => $composableBuilder(
    column: $table.extraJson,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SessionsTable> {
  $$SessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get language =>
      $composableBuilder(column: $table.language, builder: (column) => column);

  GeneratedColumn<int> get mode =>
      $composableBuilder(column: $table.mode, builder: (column) => column);

  GeneratedColumn<double> get targetDurationSeconds => $composableBuilder(
    column: $table.targetDurationSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<String> get script =>
      $composableBuilder(column: $table.script, builder: (column) => column);

  GeneratedColumn<String> get keywordsJson => $composableBuilder(
    column: $table.keywordsJson,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get endedAt =>
      $composableBuilder(column: $table.endedAt, builder: (column) => column);

  GeneratedColumn<String> get metricsJson => $composableBuilder(
    column: $table.metricsJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get extraJson =>
      $composableBuilder(column: $table.extraJson, builder: (column) => column);

  Expression<T> transcriptSegmentsRefs<T extends Object>(
    Expression<T> Function($$TranscriptSegmentsTableAnnotationComposer a) f,
  ) {
    final $$TranscriptSegmentsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.transcriptSegments,
          getReferencedColumn: (t) => t.sessionId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$TranscriptSegmentsTableAnnotationComposer(
                $db: $db,
                $table: $db.transcriptSegments,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> feedbackEventRowsRefs<T extends Object>(
    Expression<T> Function($$FeedbackEventRowsTableAnnotationComposer a) f,
  ) {
    final $$FeedbackEventRowsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.feedbackEventRows,
          getReferencedColumn: (t) => t.sessionId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$FeedbackEventRowsTableAnnotationComposer(
                $db: $db,
                $table: $db.feedbackEventRows,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> metricSnapshotRowsRefs<T extends Object>(
    Expression<T> Function($$MetricSnapshotRowsTableAnnotationComposer a) f,
  ) {
    final $$MetricSnapshotRowsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.metricSnapshotRows,
          getReferencedColumn: (t) => t.sessionId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$MetricSnapshotRowsTableAnnotationComposer(
                $db: $db,
                $table: $db.metricSnapshotRows,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> pauseEventRowsRefs<T extends Object>(
    Expression<T> Function($$PauseEventRowsTableAnnotationComposer a) f,
  ) {
    final $$PauseEventRowsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pauseEventRows,
      getReferencedColumn: (t) => t.sessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PauseEventRowsTableAnnotationComposer(
            $db: $db,
            $table: $db.pauseEventRows,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SessionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SessionsTable,
          Session,
          $$SessionsTableFilterComposer,
          $$SessionsTableOrderingComposer,
          $$SessionsTableAnnotationComposer,
          $$SessionsTableCreateCompanionBuilder,
          $$SessionsTableUpdateCompanionBuilder,
          (Session, $$SessionsTableReferences),
          Session,
          PrefetchHooks Function({
            bool transcriptSegmentsRefs,
            bool feedbackEventRowsRefs,
            bool metricSnapshotRowsRefs,
            bool pauseEventRowsRefs,
          })
        > {
  $$SessionsTableTableManager(_$AppDatabase db, $SessionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SessionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> language = const Value.absent(),
                Value<int> mode = const Value.absent(),
                Value<double?> targetDurationSeconds = const Value.absent(),
                Value<String?> script = const Value.absent(),
                Value<String> keywordsJson = const Value.absent(),
                Value<DateTime> startedAt = const Value.absent(),
                Value<DateTime?> endedAt = const Value.absent(),
                Value<String> metricsJson = const Value.absent(),
                Value<String> extraJson = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SessionsCompanion(
                id: id,
                title: title,
                language: language,
                mode: mode,
                targetDurationSeconds: targetDurationSeconds,
                script: script,
                keywordsJson: keywordsJson,
                startedAt: startedAt,
                endedAt: endedAt,
                metricsJson: metricsJson,
                extraJson: extraJson,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String title,
                required String language,
                required int mode,
                Value<double?> targetDurationSeconds = const Value.absent(),
                Value<String?> script = const Value.absent(),
                Value<String> keywordsJson = const Value.absent(),
                required DateTime startedAt,
                Value<DateTime?> endedAt = const Value.absent(),
                required String metricsJson,
                Value<String> extraJson = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SessionsCompanion.insert(
                id: id,
                title: title,
                language: language,
                mode: mode,
                targetDurationSeconds: targetDurationSeconds,
                script: script,
                keywordsJson: keywordsJson,
                startedAt: startedAt,
                endedAt: endedAt,
                metricsJson: metricsJson,
                extraJson: extraJson,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SessionsTable, Session>(table),
                  $$SessionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                transcriptSegmentsRefs = false,
                feedbackEventRowsRefs = false,
                metricSnapshotRowsRefs = false,
                pauseEventRowsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (transcriptSegmentsRefs) db.transcriptSegments,
                    if (feedbackEventRowsRefs) db.feedbackEventRows,
                    if (metricSnapshotRowsRefs) db.metricSnapshotRows,
                    if (pauseEventRowsRefs) db.pauseEventRows,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (transcriptSegmentsRefs)
                        await $_getPrefetchedData<
                          Session,
                          $SessionsTable,
                          TranscriptRow
                        >(
                          currentTable: table,
                          referencedTable: $$SessionsTableReferences
                              ._transcriptSegmentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SessionsTableReferences(
                                db,
                                table,
                                p0,
                              ).transcriptSegmentsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.sessionId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (feedbackEventRowsRefs)
                        await $_getPrefetchedData<
                          Session,
                          $SessionsTable,
                          FeedbackEventRow
                        >(
                          currentTable: table,
                          referencedTable: $$SessionsTableReferences
                              ._feedbackEventRowsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SessionsTableReferences(
                                db,
                                table,
                                p0,
                              ).feedbackEventRowsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.sessionId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (metricSnapshotRowsRefs)
                        await $_getPrefetchedData<
                          Session,
                          $SessionsTable,
                          MetricSnapshotRow
                        >(
                          currentTable: table,
                          referencedTable: $$SessionsTableReferences
                              ._metricSnapshotRowsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SessionsTableReferences(
                                db,
                                table,
                                p0,
                              ).metricSnapshotRowsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.sessionId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (pauseEventRowsRefs)
                        await $_getPrefetchedData<
                          Session,
                          $SessionsTable,
                          PauseEventRow
                        >(
                          currentTable: table,
                          referencedTable: $$SessionsTableReferences
                              ._pauseEventRowsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SessionsTableReferences(
                                db,
                                table,
                                p0,
                              ).pauseEventRowsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.sessionId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$SessionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SessionsTable,
      Session,
      $$SessionsTableFilterComposer,
      $$SessionsTableOrderingComposer,
      $$SessionsTableAnnotationComposer,
      $$SessionsTableCreateCompanionBuilder,
      $$SessionsTableUpdateCompanionBuilder,
      (Session, $$SessionsTableReferences),
      Session,
      PrefetchHooks Function({
        bool transcriptSegmentsRefs,
        bool feedbackEventRowsRefs,
        bool metricSnapshotRowsRefs,
        bool pauseEventRowsRefs,
      })
    >;
typedef $$TranscriptSegmentsTableCreateCompanionBuilder =
    TranscriptSegmentsCompanion Function({
      required String id,
      required String sessionId,
      required double startSeconds,
      required double endSeconds,
      required String body,
      Value<double?> confidence,
      Value<int> rowid,
    });
typedef $$TranscriptSegmentsTableUpdateCompanionBuilder =
    TranscriptSegmentsCompanion Function({
      Value<String> id,
      Value<String> sessionId,
      Value<double> startSeconds,
      Value<double> endSeconds,
      Value<String> body,
      Value<double?> confidence,
      Value<int> rowid,
    });

final class $$TranscriptSegmentsTableReferences
    extends
        BaseReferences<_$AppDatabase, $TranscriptSegmentsTable, TranscriptRow> {
  $$TranscriptSegmentsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $SessionsTable _sessionIdTable(_$AppDatabase db) =>
      db.sessions.createAlias('transcript_segments__session_id__sessions__id');

  $$SessionsTableProcessedTableManager get sessionId {
    final $_column = $_itemColumn<String>('session_id')!;

    final manager = $$SessionsTableTableManager(
      $_db,
      $_db.sessions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sessionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TranscriptSegmentsTableFilterComposer
    extends Composer<_$AppDatabase, $TranscriptSegmentsTable> {
  $$TranscriptSegmentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get startSeconds => $composableBuilder(
    column: $table.startSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get endSeconds => $composableBuilder(
    column: $table.endSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnFilters(column),
  );

  $$SessionsTableFilterComposer get sessionId {
    final $$SessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.sessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionsTableFilterComposer(
            $db: $db,
            $table: $db.sessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TranscriptSegmentsTableOrderingComposer
    extends Composer<_$AppDatabase, $TranscriptSegmentsTable> {
  $$TranscriptSegmentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get startSeconds => $composableBuilder(
    column: $table.startSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get endSeconds => $composableBuilder(
    column: $table.endSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnOrderings(column),
  );

  $$SessionsTableOrderingComposer get sessionId {
    final $$SessionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.sessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionsTableOrderingComposer(
            $db: $db,
            $table: $db.sessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TranscriptSegmentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TranscriptSegmentsTable> {
  $$TranscriptSegmentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get startSeconds => $composableBuilder(
    column: $table.startSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<double> get endSeconds => $composableBuilder(
    column: $table.endSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<String> get body =>
      $composableBuilder(column: $table.body, builder: (column) => column);

  GeneratedColumn<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => column,
  );

  $$SessionsTableAnnotationComposer get sessionId {
    final $$SessionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.sessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionsTableAnnotationComposer(
            $db: $db,
            $table: $db.sessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TranscriptSegmentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TranscriptSegmentsTable,
          TranscriptRow,
          $$TranscriptSegmentsTableFilterComposer,
          $$TranscriptSegmentsTableOrderingComposer,
          $$TranscriptSegmentsTableAnnotationComposer,
          $$TranscriptSegmentsTableCreateCompanionBuilder,
          $$TranscriptSegmentsTableUpdateCompanionBuilder,
          (TranscriptRow, $$TranscriptSegmentsTableReferences),
          TranscriptRow,
          PrefetchHooks Function({bool sessionId})
        > {
  $$TranscriptSegmentsTableTableManager(
    _$AppDatabase db,
    $TranscriptSegmentsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TranscriptSegmentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TranscriptSegmentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TranscriptSegmentsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> sessionId = const Value.absent(),
                Value<double> startSeconds = const Value.absent(),
                Value<double> endSeconds = const Value.absent(),
                Value<String> body = const Value.absent(),
                Value<double?> confidence = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TranscriptSegmentsCompanion(
                id: id,
                sessionId: sessionId,
                startSeconds: startSeconds,
                endSeconds: endSeconds,
                body: body,
                confidence: confidence,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String sessionId,
                required double startSeconds,
                required double endSeconds,
                required String body,
                Value<double?> confidence = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TranscriptSegmentsCompanion.insert(
                id: id,
                sessionId: sessionId,
                startSeconds: startSeconds,
                endSeconds: endSeconds,
                body: body,
                confidence: confidence,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TranscriptSegmentsTable, TranscriptRow>(table),
                  $$TranscriptSegmentsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({sessionId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (sessionId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.sessionId,
                                referencedTable:
                                    $$TranscriptSegmentsTableReferences
                                        ._sessionIdTable(db),
                                referencedColumn:
                                    $$TranscriptSegmentsTableReferences
                                        ._sessionIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$TranscriptSegmentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TranscriptSegmentsTable,
      TranscriptRow,
      $$TranscriptSegmentsTableFilterComposer,
      $$TranscriptSegmentsTableOrderingComposer,
      $$TranscriptSegmentsTableAnnotationComposer,
      $$TranscriptSegmentsTableCreateCompanionBuilder,
      $$TranscriptSegmentsTableUpdateCompanionBuilder,
      (TranscriptRow, $$TranscriptSegmentsTableReferences),
      TranscriptRow,
      PrefetchHooks Function({bool sessionId})
    >;
typedef $$FeedbackEventRowsTableCreateCompanionBuilder =
    FeedbackEventRowsCompanion Function({
      Value<int> id,
      required String sessionId,
      required String type,
      required String message,
      required double timestamp,
      required int severity,
    });
typedef $$FeedbackEventRowsTableUpdateCompanionBuilder =
    FeedbackEventRowsCompanion Function({
      Value<int> id,
      Value<String> sessionId,
      Value<String> type,
      Value<String> message,
      Value<double> timestamp,
      Value<int> severity,
    });

final class $$FeedbackEventRowsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $FeedbackEventRowsTable,
          FeedbackEventRow
        > {
  $$FeedbackEventRowsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $SessionsTable _sessionIdTable(_$AppDatabase db) =>
      db.sessions.createAlias('feedback_event_rows__session_id__sessions__id');

  $$SessionsTableProcessedTableManager get sessionId {
    final $_column = $_itemColumn<String>('session_id')!;

    final manager = $$SessionsTableTableManager(
      $_db,
      $_db.sessions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sessionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$FeedbackEventRowsTableFilterComposer
    extends Composer<_$AppDatabase, $FeedbackEventRowsTable> {
  $$FeedbackEventRowsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get message => $composableBuilder(
    column: $table.message,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get severity => $composableBuilder(
    column: $table.severity,
    builder: (column) => ColumnFilters(column),
  );

  $$SessionsTableFilterComposer get sessionId {
    final $$SessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.sessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionsTableFilterComposer(
            $db: $db,
            $table: $db.sessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FeedbackEventRowsTableOrderingComposer
    extends Composer<_$AppDatabase, $FeedbackEventRowsTable> {
  $$FeedbackEventRowsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get message => $composableBuilder(
    column: $table.message,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get severity => $composableBuilder(
    column: $table.severity,
    builder: (column) => ColumnOrderings(column),
  );

  $$SessionsTableOrderingComposer get sessionId {
    final $$SessionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.sessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionsTableOrderingComposer(
            $db: $db,
            $table: $db.sessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FeedbackEventRowsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FeedbackEventRowsTable> {
  $$FeedbackEventRowsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get message =>
      $composableBuilder(column: $table.message, builder: (column) => column);

  GeneratedColumn<double> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<int> get severity =>
      $composableBuilder(column: $table.severity, builder: (column) => column);

  $$SessionsTableAnnotationComposer get sessionId {
    final $$SessionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.sessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionsTableAnnotationComposer(
            $db: $db,
            $table: $db.sessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FeedbackEventRowsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FeedbackEventRowsTable,
          FeedbackEventRow,
          $$FeedbackEventRowsTableFilterComposer,
          $$FeedbackEventRowsTableOrderingComposer,
          $$FeedbackEventRowsTableAnnotationComposer,
          $$FeedbackEventRowsTableCreateCompanionBuilder,
          $$FeedbackEventRowsTableUpdateCompanionBuilder,
          (FeedbackEventRow, $$FeedbackEventRowsTableReferences),
          FeedbackEventRow,
          PrefetchHooks Function({bool sessionId})
        > {
  $$FeedbackEventRowsTableTableManager(
    _$AppDatabase db,
    $FeedbackEventRowsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FeedbackEventRowsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FeedbackEventRowsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FeedbackEventRowsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> sessionId = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> message = const Value.absent(),
                Value<double> timestamp = const Value.absent(),
                Value<int> severity = const Value.absent(),
              }) => FeedbackEventRowsCompanion(
                id: id,
                sessionId: sessionId,
                type: type,
                message: message,
                timestamp: timestamp,
                severity: severity,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String sessionId,
                required String type,
                required String message,
                required double timestamp,
                required int severity,
              }) => FeedbackEventRowsCompanion.insert(
                id: id,
                sessionId: sessionId,
                type: type,
                message: message,
                timestamp: timestamp,
                severity: severity,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$FeedbackEventRowsTable, FeedbackEventRow>(table),
                  $$FeedbackEventRowsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({sessionId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (sessionId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.sessionId,
                                referencedTable:
                                    $$FeedbackEventRowsTableReferences
                                        ._sessionIdTable(db),
                                referencedColumn:
                                    $$FeedbackEventRowsTableReferences
                                        ._sessionIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$FeedbackEventRowsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FeedbackEventRowsTable,
      FeedbackEventRow,
      $$FeedbackEventRowsTableFilterComposer,
      $$FeedbackEventRowsTableOrderingComposer,
      $$FeedbackEventRowsTableAnnotationComposer,
      $$FeedbackEventRowsTableCreateCompanionBuilder,
      $$FeedbackEventRowsTableUpdateCompanionBuilder,
      (FeedbackEventRow, $$FeedbackEventRowsTableReferences),
      FeedbackEventRow,
      PrefetchHooks Function({bool sessionId})
    >;
typedef $$MetricSnapshotRowsTableCreateCompanionBuilder =
    MetricSnapshotRowsCompanion Function({
      Value<int> id,
      required String sessionId,
      required double t,
      required double wpm,
      Value<double?> f0,
      required double rms,
    });
typedef $$MetricSnapshotRowsTableUpdateCompanionBuilder =
    MetricSnapshotRowsCompanion Function({
      Value<int> id,
      Value<String> sessionId,
      Value<double> t,
      Value<double> wpm,
      Value<double?> f0,
      Value<double> rms,
    });

final class $$MetricSnapshotRowsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $MetricSnapshotRowsTable,
          MetricSnapshotRow
        > {
  $$MetricSnapshotRowsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $SessionsTable _sessionIdTable(_$AppDatabase db) =>
      db.sessions.createAlias('metric_snapshot_rows__session_id__sessions__id');

  $$SessionsTableProcessedTableManager get sessionId {
    final $_column = $_itemColumn<String>('session_id')!;

    final manager = $$SessionsTableTableManager(
      $_db,
      $_db.sessions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sessionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$MetricSnapshotRowsTableFilterComposer
    extends Composer<_$AppDatabase, $MetricSnapshotRowsTable> {
  $$MetricSnapshotRowsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get t => $composableBuilder(
    column: $table.t,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get wpm => $composableBuilder(
    column: $table.wpm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get f0 => $composableBuilder(
    column: $table.f0,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get rms => $composableBuilder(
    column: $table.rms,
    builder: (column) => ColumnFilters(column),
  );

  $$SessionsTableFilterComposer get sessionId {
    final $$SessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.sessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionsTableFilterComposer(
            $db: $db,
            $table: $db.sessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MetricSnapshotRowsTableOrderingComposer
    extends Composer<_$AppDatabase, $MetricSnapshotRowsTable> {
  $$MetricSnapshotRowsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get t => $composableBuilder(
    column: $table.t,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get wpm => $composableBuilder(
    column: $table.wpm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get f0 => $composableBuilder(
    column: $table.f0,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get rms => $composableBuilder(
    column: $table.rms,
    builder: (column) => ColumnOrderings(column),
  );

  $$SessionsTableOrderingComposer get sessionId {
    final $$SessionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.sessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionsTableOrderingComposer(
            $db: $db,
            $table: $db.sessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MetricSnapshotRowsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MetricSnapshotRowsTable> {
  $$MetricSnapshotRowsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get t =>
      $composableBuilder(column: $table.t, builder: (column) => column);

  GeneratedColumn<double> get wpm =>
      $composableBuilder(column: $table.wpm, builder: (column) => column);

  GeneratedColumn<double> get f0 =>
      $composableBuilder(column: $table.f0, builder: (column) => column);

  GeneratedColumn<double> get rms =>
      $composableBuilder(column: $table.rms, builder: (column) => column);

  $$SessionsTableAnnotationComposer get sessionId {
    final $$SessionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.sessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionsTableAnnotationComposer(
            $db: $db,
            $table: $db.sessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MetricSnapshotRowsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MetricSnapshotRowsTable,
          MetricSnapshotRow,
          $$MetricSnapshotRowsTableFilterComposer,
          $$MetricSnapshotRowsTableOrderingComposer,
          $$MetricSnapshotRowsTableAnnotationComposer,
          $$MetricSnapshotRowsTableCreateCompanionBuilder,
          $$MetricSnapshotRowsTableUpdateCompanionBuilder,
          (MetricSnapshotRow, $$MetricSnapshotRowsTableReferences),
          MetricSnapshotRow,
          PrefetchHooks Function({bool sessionId})
        > {
  $$MetricSnapshotRowsTableTableManager(
    _$AppDatabase db,
    $MetricSnapshotRowsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MetricSnapshotRowsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MetricSnapshotRowsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MetricSnapshotRowsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> sessionId = const Value.absent(),
                Value<double> t = const Value.absent(),
                Value<double> wpm = const Value.absent(),
                Value<double?> f0 = const Value.absent(),
                Value<double> rms = const Value.absent(),
              }) => MetricSnapshotRowsCompanion(
                id: id,
                sessionId: sessionId,
                t: t,
                wpm: wpm,
                f0: f0,
                rms: rms,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String sessionId,
                required double t,
                required double wpm,
                Value<double?> f0 = const Value.absent(),
                required double rms,
              }) => MetricSnapshotRowsCompanion.insert(
                id: id,
                sessionId: sessionId,
                t: t,
                wpm: wpm,
                f0: f0,
                rms: rms,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$MetricSnapshotRowsTable, MetricSnapshotRow>(
                    table,
                  ),
                  $$MetricSnapshotRowsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({sessionId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (sessionId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.sessionId,
                                referencedTable:
                                    $$MetricSnapshotRowsTableReferences
                                        ._sessionIdTable(db),
                                referencedColumn:
                                    $$MetricSnapshotRowsTableReferences
                                        ._sessionIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$MetricSnapshotRowsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MetricSnapshotRowsTable,
      MetricSnapshotRow,
      $$MetricSnapshotRowsTableFilterComposer,
      $$MetricSnapshotRowsTableOrderingComposer,
      $$MetricSnapshotRowsTableAnnotationComposer,
      $$MetricSnapshotRowsTableCreateCompanionBuilder,
      $$MetricSnapshotRowsTableUpdateCompanionBuilder,
      (MetricSnapshotRow, $$MetricSnapshotRowsTableReferences),
      MetricSnapshotRow,
      PrefetchHooks Function({bool sessionId})
    >;
typedef $$PauseEventRowsTableCreateCompanionBuilder =
    PauseEventRowsCompanion Function({
      Value<int> id,
      required String sessionId,
      required int startMs,
      required int endMs,
    });
typedef $$PauseEventRowsTableUpdateCompanionBuilder =
    PauseEventRowsCompanion Function({
      Value<int> id,
      Value<String> sessionId,
      Value<int> startMs,
      Value<int> endMs,
    });

final class $$PauseEventRowsTableReferences
    extends BaseReferences<_$AppDatabase, $PauseEventRowsTable, PauseEventRow> {
  $$PauseEventRowsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $SessionsTable _sessionIdTable(_$AppDatabase db) =>
      db.sessions.createAlias('pause_event_rows__session_id__sessions__id');

  $$SessionsTableProcessedTableManager get sessionId {
    final $_column = $_itemColumn<String>('session_id')!;

    final manager = $$SessionsTableTableManager(
      $_db,
      $_db.sessions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sessionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PauseEventRowsTableFilterComposer
    extends Composer<_$AppDatabase, $PauseEventRowsTable> {
  $$PauseEventRowsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get startMs => $composableBuilder(
    column: $table.startMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get endMs => $composableBuilder(
    column: $table.endMs,
    builder: (column) => ColumnFilters(column),
  );

  $$SessionsTableFilterComposer get sessionId {
    final $$SessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.sessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionsTableFilterComposer(
            $db: $db,
            $table: $db.sessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PauseEventRowsTableOrderingComposer
    extends Composer<_$AppDatabase, $PauseEventRowsTable> {
  $$PauseEventRowsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get startMs => $composableBuilder(
    column: $table.startMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get endMs => $composableBuilder(
    column: $table.endMs,
    builder: (column) => ColumnOrderings(column),
  );

  $$SessionsTableOrderingComposer get sessionId {
    final $$SessionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.sessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionsTableOrderingComposer(
            $db: $db,
            $table: $db.sessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PauseEventRowsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PauseEventRowsTable> {
  $$PauseEventRowsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get startMs =>
      $composableBuilder(column: $table.startMs, builder: (column) => column);

  GeneratedColumn<int> get endMs =>
      $composableBuilder(column: $table.endMs, builder: (column) => column);

  $$SessionsTableAnnotationComposer get sessionId {
    final $$SessionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.sessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionsTableAnnotationComposer(
            $db: $db,
            $table: $db.sessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PauseEventRowsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PauseEventRowsTable,
          PauseEventRow,
          $$PauseEventRowsTableFilterComposer,
          $$PauseEventRowsTableOrderingComposer,
          $$PauseEventRowsTableAnnotationComposer,
          $$PauseEventRowsTableCreateCompanionBuilder,
          $$PauseEventRowsTableUpdateCompanionBuilder,
          (PauseEventRow, $$PauseEventRowsTableReferences),
          PauseEventRow,
          PrefetchHooks Function({bool sessionId})
        > {
  $$PauseEventRowsTableTableManager(
    _$AppDatabase db,
    $PauseEventRowsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PauseEventRowsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PauseEventRowsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PauseEventRowsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> sessionId = const Value.absent(),
                Value<int> startMs = const Value.absent(),
                Value<int> endMs = const Value.absent(),
              }) => PauseEventRowsCompanion(
                id: id,
                sessionId: sessionId,
                startMs: startMs,
                endMs: endMs,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String sessionId,
                required int startMs,
                required int endMs,
              }) => PauseEventRowsCompanion.insert(
                id: id,
                sessionId: sessionId,
                startMs: startMs,
                endMs: endMs,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PauseEventRowsTable, PauseEventRow>(table),
                  $$PauseEventRowsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({sessionId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (sessionId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.sessionId,
                                referencedTable: $$PauseEventRowsTableReferences
                                    ._sessionIdTable(db),
                                referencedColumn:
                                    $$PauseEventRowsTableReferences
                                        ._sessionIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PauseEventRowsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PauseEventRowsTable,
      PauseEventRow,
      $$PauseEventRowsTableFilterComposer,
      $$PauseEventRowsTableOrderingComposer,
      $$PauseEventRowsTableAnnotationComposer,
      $$PauseEventRowsTableCreateCompanionBuilder,
      $$PauseEventRowsTableUpdateCompanionBuilder,
      (PauseEventRow, $$PauseEventRowsTableReferences),
      PauseEventRow,
      PrefetchHooks Function({bool sessionId})
    >;
typedef $$SettingRowsTableCreateCompanionBuilder =
    SettingRowsCompanion Function({
      required String key,
      required String value,
      Value<int> rowid,
    });
typedef $$SettingRowsTableUpdateCompanionBuilder =
    SettingRowsCompanion Function({
      Value<String> key,
      Value<String> value,
      Value<int> rowid,
    });

class $$SettingRowsTableFilterComposer
    extends Composer<_$AppDatabase, $SettingRowsTable> {
  $$SettingRowsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SettingRowsTableOrderingComposer
    extends Composer<_$AppDatabase, $SettingRowsTable> {
  $$SettingRowsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SettingRowsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SettingRowsTable> {
  $$SettingRowsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);
}

class $$SettingRowsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SettingRowsTable,
          SettingRow,
          $$SettingRowsTableFilterComposer,
          $$SettingRowsTableOrderingComposer,
          $$SettingRowsTableAnnotationComposer,
          $$SettingRowsTableCreateCompanionBuilder,
          $$SettingRowsTableUpdateCompanionBuilder,
          (
            SettingRow,
            BaseReferences<_$AppDatabase, $SettingRowsTable, SettingRow>,
          ),
          SettingRow,
          PrefetchHooks Function()
        > {
  $$SettingRowsTableTableManager(_$AppDatabase db, $SettingRowsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SettingRowsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SettingRowsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SettingRowsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SettingRowsCompanion(key: key, value: value, rowid: rowid),
          createCompanionCallback:
              ({
                required String key,
                required String value,
                Value<int> rowid = const Value.absent(),
              }) => SettingRowsCompanion.insert(
                key: key,
                value: value,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SettingRowsTable, SettingRow>(table),
                  BaseReferences<_$AppDatabase, $SettingRowsTable, SettingRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SettingRowsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SettingRowsTable,
      SettingRow,
      $$SettingRowsTableFilterComposer,
      $$SettingRowsTableOrderingComposer,
      $$SettingRowsTableAnnotationComposer,
      $$SettingRowsTableCreateCompanionBuilder,
      $$SettingRowsTableUpdateCompanionBuilder,
      (
        SettingRow,
        BaseReferences<_$AppDatabase, $SettingRowsTable, SettingRow>,
      ),
      SettingRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$SessionsTableTableManager get sessions =>
      $$SessionsTableTableManager(_db, _db.sessions);
  $$TranscriptSegmentsTableTableManager get transcriptSegments =>
      $$TranscriptSegmentsTableTableManager(_db, _db.transcriptSegments);
  $$FeedbackEventRowsTableTableManager get feedbackEventRows =>
      $$FeedbackEventRowsTableTableManager(_db, _db.feedbackEventRows);
  $$MetricSnapshotRowsTableTableManager get metricSnapshotRows =>
      $$MetricSnapshotRowsTableTableManager(_db, _db.metricSnapshotRows);
  $$PauseEventRowsTableTableManager get pauseEventRows =>
      $$PauseEventRowsTableTableManager(_db, _db.pauseEventRows);
  $$SettingRowsTableTableManager get settingRows =>
      $$SettingRowsTableTableManager(_db, _db.settingRows);
}
