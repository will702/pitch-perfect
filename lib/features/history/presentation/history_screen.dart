import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';
import '../../session_result/presentation/session_result_screen.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessions = ref.watch(sessionHistoryProvider);
    final repo = ref.read(repositoryProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Session History')),
      body: sessions.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('$e')),
        data: (list) => list.isEmpty
            ? const Center(child: Text('No sessions yet.'))
            : ListView.separated(
                itemCount: list.length,
                separatorBuilder: (_, _) => const Divider(height: 1),
                itemBuilder: (context, i) {
                  final s = list[i];
                  return Dismissible(
                    key: ValueKey(s.id),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: Theme.of(context).colorScheme.error,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 16),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    onDismissed: (_) => repo.delete(s.id),
                    child: ListTile(
                      title: Text(s.config.title),
                      subtitle: Text(
                          '${s.startedAt.toString().substring(0, 16)} · ${s.duration.inMinutes}m ${s.duration.inSeconds % 60}s · ${s.metrics.averageWpm.round()} WPM'),
                      trailing: Text('${(s.metrics.overallScore ?? 0).round()}',
                          style: Theme.of(context).textTheme.titleLarge),
                      onTap: () async {
                        final full = await repo.get(s.id);
                        if (full != null && context.mounted) {
                          Navigator.of(context).push(MaterialPageRoute<void>(
                              builder: (_) => SessionResultScreen(session: full)));
                        }
                      },
                    ),
                  );
                },
              ),
      ),
    );
  }
}
