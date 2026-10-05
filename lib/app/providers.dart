import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/analysis/audio_analysis_engine.dart';
import '../core/audio/audio_capture_service.dart';
import '../core/audio/record_audio_capture_service.dart';
import '../core/database/database.dart';
import '../core/database/session_repository.dart';
import '../core/speech/local_asr_engine.dart';
import '../core/speech/mock_speech_recognition_engine.dart';
import '../core/speech/speech_recognition_engine.dart';
import '../features/practice/domain/practice_session.dart';
import '../features/settings/application/settings.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

final repositoryProvider =
    Provider<SessionRepository>((ref) => SessionRepository(ref.watch(databaseProvider)));

final settingsProvider =
    NotifierProvider<SettingsNotifier, AppSettings>(SettingsNotifier.new);

final sessionHistoryProvider = StreamProvider<List<PracticeSession>>(
    (ref) => ref.watch(repositoryProvider).watchAll());

/// Override in tests with fakes.
final audioCaptureFactoryProvider =
    Provider<AudioCaptureService Function()>((ref) => RecordAudioCaptureService.new);

final asrEngineFactoryProvider =
    Provider<SpeechRecognitionEngine Function(String language)>((ref) {
  final local = ref.watch(settingsProvider).useLocalAsr;
  return (lang) =>
      local ? LocalAsrEngine(language: lang) : MockSpeechRecognitionEngine(language: lang);
});

final analysisEngineFactoryProvider = Provider<AudioAnalysisEngine Function()>(
    (ref) => IsolateAudioAnalysisEngine.new);
