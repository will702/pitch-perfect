import 'package:flutter/material.dart';

import '../../history/presentation/history_screen.dart';
import '../../session_setup/presentation/session_setup_screen.dart';
import '../../settings/presentation/settings_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    void go(Widget w) => Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => w));
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(Icons.record_voice_over, size: 72, color: cs.primary),
              const SizedBox(height: 12),
              Text('PitchPerfect',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 4),
              Text('Practice speaking with live, on-device feedback.',
                  textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 40),
              FilledButton.icon(
                onPressed: () => go(const SessionSetupScreen()),
                icon: const Icon(Icons.mic),
                label: const Text('Start Practice'),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: () => go(const HistoryScreen()),
                icon: const Icon(Icons.history),
                label: const Text('Session History'),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: () => go(const SettingsScreen()),
                icon: const Icon(Icons.settings),
                label: const Text('Settings'),
              ),
              const SizedBox(height: 24),
              Text('Audio is processed on this device and never stored.',
                  textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
      ),
    );
  }
}
