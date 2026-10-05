import 'dart:io';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../../../core/analysis/pause_detector.dart';
import '../../../core/analysis/scoring.dart';
import '../../../shared/widgets/metric_card.dart';
import '../../../shared/widgets/mini_line_chart.dart';
import '../../practice/domain/practice_session.dart';

class SessionResultScreen extends StatelessWidget {
  const SessionResultScreen({super.key, required this.session, this.benchmarkJson});
  final PracticeSession session;

  /// Present only right after a live session.
  final String? benchmarkJson;

  String _fmt(Duration d) =>
      '${d.inMinutes}:${(d.inSeconds % 60).toString().padLeft(2, '0')}';

  Future<void> _export(BuildContext context) async {
    final dir = await getApplicationDocumentsDirectory();
    final f = File(p.join(dir.path, 'benchmark_${session.id}.json'));
    await f.writeAsString(benchmarkJson!);
    if (context.mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Saved ${f.path}')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final m = session.metrics;
    final b = calculateScore(m, session.duration);
    final recs = recommendations(m, b, session.duration);
    final t = Theme.of(context).textTheme;
    final snaps = session.snapshots;
    List<FlSpot> spots(double? Function(MetricSnapshot) f) =>
        [for (final s in snaps) if (f(s) != null) FlSpot(s.t, f(s)!)];
    final longPauses = session.pauses.where((x) => x.kind == PauseKind.long).length;

    Widget section(String title, Widget child) => Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: t.titleMedium),
            const SizedBox(height: 8),
            child,
          ]),
        );

    return Scaffold(
      appBar: AppBar(title: Text(session.config.title)),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(children: [
              Text('${(m.overallScore ?? b.overall).round()}',
                  style: t.displayLarge?.copyWith(fontWeight: FontWeight.bold)),
              const Text('Delivery score (a coaching indicator, not a verdict)'),
              const SizedBox(height: 8),
              Text('Duration ${_fmt(session.duration)}'),
            ]),
          ),
        ),
        const SizedBox(height: 12),
        Row(children: [
          Expanded(child: MetricCard(label: 'Avg WPM', value: m.averageWpm.round().toString())),
          const SizedBox(width: 8),
          Expanded(child: MetricCard(label: 'Fillers', value: '${m.fillerCount}')),
          const SizedBox(width: 8),
          Expanded(child: MetricCard(label: 'Long pauses', value: '$longPauses')),
        ]),
        section('Recommendations',
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              for (final r in recs)
                Padding(padding: const EdgeInsets.only(bottom: 4), child: Text('• $r')),
            ])),
        section('Speech rate', MiniLineChart(title: 'WPM over time', points: spots((s) => s.wpm))),
        section(
            'Pitch variation',
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(m.averagePitchHz == null
                  ? 'No voiced pitch detected.'
                  : 'Average ${m.averagePitchHz!.round()} Hz · std dev ${(m.pitchStdDev ?? 0).round()} Hz'),
              const SizedBox(height: 8),
              MiniLineChart(title: 'F0 (Hz)', points: spots((s) => s.f0Hz)),
            ])),
        section(
            'Volume',
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(m.volumeVariation == null
                  ? 'No voice detected.'
                  : 'Relative variation ${(m.volumeVariation! * 100).round()}% (uncalibrated, not dB)'),
              const SizedBox(height: 8),
              MiniLineChart(title: 'Energy (RMS)', points: spots((s) => s.rms)),
            ])),
        section(
            'Filler words',
            session.fillerBreakdown.isEmpty
                ? const Text('None detected.')
                : Wrap(spacing: 8, children: [
                    for (final e in (session.fillerBreakdown.entries.toList()
                          ..sort((a, b) => b.value.compareTo(a.value))))
                      Chip(label: Text('"${e.key}" × ${e.value}')),
                  ])),
        section(
            'Pauses',
            Text('${m.pauseCount} pauses (${session.pauses.where((x) => x.kind == PauseKind.intentional).length} intentional, $longPauses long)')),
        if (m.scriptCoverage != null || m.keywordCoverage != null)
          section(
              'Coverage',
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                if (m.scriptCoverage != null)
                  Text('Script coverage: ${(m.scriptCoverage! * 100).round()}%'),
                for (final s in session.missedScriptSentences) Text('Missed: "$s"'),
                if (m.keywordCoverage != null)
                  Text('Key points: ${(m.keywordCoverage! * 100).round()}%'),
                if (session.missedKeywords.isNotEmpty)
                  Text('Missing: ${session.missedKeywords.join(', ')}'),
              ])),
        section(
            'Transcript',
            session.transcript.isEmpty
                ? const Text('No speech recognized.')
                : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    for (final s in session.transcript)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Text(
                            '[${(s.startSeconds ~/ 60).toString().padLeft(2, '0')}:${(s.startSeconds.floor() % 60).toString().padLeft(2, '0')}] ${s.text}'),
                      ),
                  ])),
        if (benchmarkJson != null) ...[
          const SizedBox(height: 20),
          OutlinedButton.icon(
            onPressed: () => _export(context),
            icon: const Icon(Icons.speed),
            label: const Text('Export latency benchmark (JSON)'),
          ),
        ],
        const SizedBox(height: 24),
      ]),
    );
  }
}
