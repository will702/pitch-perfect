import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';
import '../../../core/feedback/feedback_rule.dart';

class AppSettings {
  final bool useLocalAsr;
  final double slowWpm;
  final double fastWpm;
  const AppSettings({this.useLocalAsr = true, this.slowWpm = 100, this.fastWpm = 190});

  AppSettings copyWith({bool? useLocalAsr, double? slowWpm, double? fastWpm}) => AppSettings(
        useLocalAsr: useLocalAsr ?? this.useLocalAsr,
        slowWpm: slowWpm ?? this.slowWpm,
        fastWpm: fastWpm ?? this.fastWpm,
      );

  FeedbackThresholds get thresholds =>
      FeedbackThresholds(slowWpm: slowWpm, fastWpm: fastWpm);
}

class SettingsNotifier extends Notifier<AppSettings> {
  @override
  AppSettings build() {
    _load();
    return const AppSettings();
  }

  Future<void> _load() async {
    final repo = ref.read(repositoryProvider);
    String? local, slow, fast;
    try {
      local = await repo.getSetting('useLocalAsr');
      slow = await repo.getSetting('slowWpm');
      fast = await repo.getSetting('fastWpm');
    } catch (_) {
      return; // defaults stay in effect if storage is unavailable
    }
    if (!ref.mounted) return;
    state = AppSettings(
      useLocalAsr: local == null ? true : local == 'true',
      slowWpm: double.tryParse(slow ?? '') ?? 100,
      fastWpm: double.tryParse(fast ?? '') ?? 190,
    );
  }

  Future<void> update(AppSettings s) async {
    state = s;
    final repo = ref.read(repositoryProvider);
    await repo.setSetting('useLocalAsr', '${s.useLocalAsr}');
    await repo.setSetting('slowWpm', '${s.slowWpm}');
    await repo.setSetting('fastWpm', '${s.fastWpm}');
  }
}
