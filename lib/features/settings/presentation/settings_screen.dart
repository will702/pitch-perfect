import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = ref.watch(settingsProvider);
    final n = ref.read(settingsProvider.notifier);
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        SwitchListTile(
          title: const Text('On-device Whisper recognition'),
          subtitle: const Text(
              'Off = simulated transcript (mock engine). On first use the model (~100 MB) is downloaded once.'),
          value: s.useLocalAsr,
          onChanged: (v) => n.update(s.copyWith(useLocalAsr: v)),
        ),
        const Divider(),
        ListTile(title: Text('"Too slow" below ${s.slowWpm.round()} WPM')),
        Slider(
            value: s.slowWpm,
            min: 60,
            max: 130,
            onChanged: (v) => n.update(s.copyWith(slowWpm: v))),
        ListTile(title: Text('"Too fast" above ${s.fastWpm.round()} WPM')),
        Slider(
            value: s.fastWpm,
            min: 150,
            max: 240,
            onChanged: (v) => n.update(s.copyWith(fastWpm: v))),
        const Divider(),
        const ListTile(
          leading: Icon(Icons.lock_outline),
          title: Text('Privacy'),
          subtitle: Text(
              'The microphone is only active during a session (shown on screen). Audio is analysed on this device and never saved; only transcript and derived metrics are stored.'),
        ),
      ]),
    );
  }
}
