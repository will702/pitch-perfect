import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';
import '../../../shared/widgets/metric_card.dart';
import '../../session_result/presentation/session_result_screen.dart';
import '../application/practice_session_controller.dart';
import '../domain/practice_session.dart';
import 'widgets/transcript_view.dart';

String fmtDuration(Duration d) {
  final m = d.inMinutes.toString().padLeft(2, '0');
  final s = (d.inSeconds % 60).toString().padLeft(2, '0');
  return '$m:$s';
}

class PracticeScreen extends ConsumerStatefulWidget {
  const PracticeScreen({super.key, required this.config});
  final SessionConfig config;

  @override
  ConsumerState<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends ConsumerState<PracticeScreen> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      ref.read(practiceSessionControllerProvider.notifier).start(widget.config);
    });
  }

  @override
  Widget build(BuildContext context) {
    final ctrl = ref.read(practiceSessionControllerProvider.notifier);
    final state = ref.watch(practiceSessionControllerProvider);

    ref.listen(practiceSessionControllerProvider, (_, next) {
      if (next is PracticeCompleted) {
        final json = ctrl.latency?.toJson();
        ctrl.reset();
        Navigator.of(context).pushReplacement(MaterialPageRoute<void>(
            builder: (_) => SessionResultScreen(session: next.session, benchmarkJson: json)));
      }
    });
    // Benchmark hook: stamp rendered_at after the frame that showed new results.
    SchedulerBinding.instance.addPostFrameCallback((_) => ctrl.latency?.markRendered());

    final running = state is PracticeRunning;
    return PopScope(
      canPop: !running && state is! PracticeStopping,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Press STOP to end the session.')));
        } else {
          ctrl.reset();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(children: [
            Icon(Icons.mic,
                color: running ? Colors.red : Theme.of(context).disabledColor, size: 20),
            const SizedBox(width: 8),
            Text(widget.config.title),
          ]),
          actions: [
            if (state is PracticeRunning)
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Center(
                    child: Text(fmtDuration(state.metrics.duration),
                        style: Theme.of(context).textTheme.titleMedium)),
              ),
          ],
        ),
        body: SafeArea(child: _body(context, state, ctrl)),
      ),
    );
  }

  Widget _body(BuildContext context, PracticeState state, PracticeSessionController ctrl) {
    switch (state) {
      case PracticeIdle():
        return const Center(child: CircularProgressIndicator());
      case PracticeInitializing(:final progress):
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Text(progress == null ? 'Preparing…' : 'Downloading speech model…'),
              const SizedBox(height: 16),
              LinearProgressIndicator(value: progress),
              if (progress != null) Text('${(progress * 100).round()}%'),
            ]),
          ),
        );
      case PracticeStopping():
        return const Center(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text('Finishing…'),
        ]));
      case PracticeError(:final error):
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Icon(Icons.error_outline, size: 48, color: Theme.of(context).colorScheme.error),
              const SizedBox(height: 12),
              Text('$error', textAlign: TextAlign.center),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () => ctrl.start(widget.config),
                child: const Text('Retry'),
              ),
              TextButton(
                onPressed: () async {
                  final s = ref.read(settingsProvider);
                  await ref
                      .read(settingsProvider.notifier)
                      .update(s.copyWith(useLocalAsr: false));
                  ctrl.start(widget.config);
                },
                child: const Text('Continue with simulated transcript'),
              ),
              TextButton(
                onPressed: () {
                  ctrl.reset();
                  Navigator.of(context).pop();
                },
                child: const Text('Back'),
              ),
            ]),
          ),
        );
      case PracticeCompleted():
        return const SizedBox.shrink();
      case PracticeRunning():
        return _running(context, state, ctrl);
    }
  }

  Widget _running(BuildContext context, PracticeRunning s, PracticeSessionController ctrl) {
    final m = s.metrics;
    final t = Theme.of(context).textTheme;
    final std = m.rollingPitchStdDev;
    final pitch = std == null ? '—' : std < 15 ? 'Flat' : std < 30 ? 'Moderate' : 'Varied';
    final base = m.rmsBaseline;
    final volume = base == null
        ? 'Calibrating…'
        : m.currentRms < base * 0.65
            ? 'Low'
            : m.currentRms > base * 1.8
                ? 'Spiking'
                : 'Stable';
    final target = s.config.targetDurationSeconds;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        if (target != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: LinearProgressIndicator(
                value: (m.duration.inSeconds / target).clamp(0.0, 1.0)),
          ),
        Text('LIVE TRANSCRIPT', style: t.labelSmall),
        const SizedBox(height: 4),
        Expanded(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: TranscriptView(segments: s.transcript, partial: m.partialTranscript),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Row(children: [
          Expanded(child: MetricCard(label: 'WPM', value: m.rollingWpm.round().toString())),
          const SizedBox(width: 8),
          Expanded(child: MetricCard(label: 'Fillers', value: '${m.fillerCount}')),
          const SizedBox(width: 8),
          Expanded(child: MetricCard(label: 'Pauses', value: '${m.pauseCount}')),
        ]),
        const SizedBox(height: 8),
        Text('Pitch variation: $pitch   ·   Volume: $volume', style: t.bodyMedium),
        if (s.keywordsHit.isNotEmpty) ...[
          const SizedBox(height: 8),
          Wrap(spacing: 6, children: [
            for (var i = 0; i < s.keywordsHit.length; i++)
              FilterChip(
                label: Text(s.config.keywords[i]),
                selected: s.keywordsHit[i],
                onSelected: null,
                showCheckmark: true,
              ),
          ]),
        ],
        const SizedBox(height: 8),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: s.feedback == null
              ? const SizedBox(height: 48, key: ValueKey('none'))
              : Container(
                  key: ValueKey(s.feedback!.type),
                  height: 48,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text('💡 ${s.feedback!.message}'),
                ),
        ),
        const SizedBox(height: 12),
        FilledButton.icon(
          style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
              minimumSize: const Size.fromHeight(52)),
          onPressed: ctrl.stop,
          icon: const Icon(Icons.stop),
          label: const Text('STOP'),
        ),
      ]),
    );
  }
}
