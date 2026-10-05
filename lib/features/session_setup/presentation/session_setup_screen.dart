import 'package:flutter/material.dart';

import '../../practice/domain/practice_session.dart';
import '../../practice/presentation/practice_screen.dart';

class SessionSetupScreen extends StatefulWidget {
  const SessionSetupScreen({super.key});

  @override
  State<SessionSetupScreen> createState() => _SessionSetupScreenState();
}

class _SessionSetupScreenState extends State<SessionSetupScreen> {
  final _title = TextEditingController(text: 'Practice');
  final _script = TextEditingController();
  final _keywords = TextEditingController();
  String _lang = 'en';
  PracticeMode _mode = PracticeMode.free;
  double _minutes = 3;

  @override
  void dispose() {
    _title.dispose();
    _script.dispose();
    _keywords.dispose();
    super.dispose();
  }

  void _start() {
    final kws = _keywords.text
        .split(RegExp(r'[,\n]'))
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();
    final script = _mode == PracticeMode.script ? _script.text.trim() : '';
    final config = SessionConfig(
      title: _title.text.trim().isEmpty ? 'Practice' : _title.text.trim(),
      language: _lang,
      mode: _mode,
      targetDurationSeconds: _mode == PracticeMode.pitch ? _minutes * 60 : null,
      script: script.isEmpty ? null : script,
      keywords: kws,
    );
    Navigator.of(context).push(
        MaterialPageRoute<void>(builder: (_) => PracticeScreen(config: config)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Practice')),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        TextField(
          controller: _title,
          decoration: const InputDecoration(labelText: 'Session title', border: OutlineInputBorder()),
        ),
        const SizedBox(height: 16),
        DropdownButtonFormField<String>(
          initialValue: _lang,
          decoration: const InputDecoration(labelText: 'Language', border: OutlineInputBorder()),
          items: const [
            DropdownMenuItem(value: 'en', child: Text('English')),
            DropdownMenuItem(value: 'id', child: Text('Indonesian')),
          ],
          onChanged: (v) => setState(() => _lang = v ?? 'en'),
        ),
        const SizedBox(height: 16),
        SegmentedButton<PracticeMode>(
          segments: const [
            ButtonSegment(value: PracticeMode.free, label: Text('Free')),
            ButtonSegment(value: PracticeMode.script, label: Text('Script')),
            ButtonSegment(value: PracticeMode.pitch, label: Text('Pitch')),
          ],
          selected: {_mode},
          onSelectionChanged: (s) => setState(() => _mode = s.first),
        ),
        if (_mode == PracticeMode.pitch) ...[
          const SizedBox(height: 16),
          Text('Target duration: ${_minutes.round()} min'),
          Slider(
              value: _minutes,
              min: 1,
              max: 5,
              divisions: 4,
              onChanged: (v) => setState(() => _minutes = v)),
        ],
        if (_mode == PracticeMode.script) ...[
          const SizedBox(height: 16),
          TextField(
            controller: _script,
            minLines: 5,
            maxLines: 10,
            decoration: const InputDecoration(
                labelText: 'Script', alignLabelWithHint: true, border: OutlineInputBorder()),
          ),
        ],
        const SizedBox(height: 16),
        TextField(
          controller: _keywords,
          decoration: const InputDecoration(
            labelText: 'Key points (comma or line separated)',
            helperText: 'Optional checklist, e.g. Problem, Solution, Traction',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 24),
        FilledButton(onPressed: _start, child: const Text('Start Practice')),
      ]),
    );
  }
}
