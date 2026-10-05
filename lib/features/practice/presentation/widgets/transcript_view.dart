import 'package:flutter/material.dart';

import '../../domain/transcript_segment.dart';

String _ts(double s) {
  final m = (s ~/ 60).toString().padLeft(2, '0');
  final sec = (s.floor() % 60).toString().padLeft(2, '0');
  return '[$m:$sec]';
}

/// Final segments are fixed; the single partial is replaced in place.
class TranscriptView extends StatefulWidget {
  const TranscriptView({super.key, required this.segments, this.partial = ''});
  final List<TranscriptSegment> segments;
  final String partial;

  @override
  State<TranscriptView> createState() => _TranscriptViewState();
}

class _TranscriptViewState extends State<TranscriptView> {
  final _scroll = ScrollController();

  @override
  void didUpdateWidget(TranscriptView old) {
    super.didUpdateWidget(old);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scroll.hasClients) _scroll.jumpTo(_scroll.position.maxScrollExtent);
    });
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme.bodyLarge;
    final grey = Theme.of(context).colorScheme.onSurfaceVariant;
    if (widget.segments.isEmpty && widget.partial.isEmpty) {
      return Center(child: Text('Start speaking…', style: t?.copyWith(color: grey)));
    }
    return ListView(controller: _scroll, children: [
      for (final s in widget.segments)
        Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Text.rich(TextSpan(children: [
            TextSpan(text: '${_ts(s.startSeconds)} ', style: t?.copyWith(color: grey)),
            TextSpan(text: s.text, style: t),
          ])),
        ),
      if (widget.partial.isNotEmpty)
        Text('… ${widget.partial}', style: t?.copyWith(color: grey, fontStyle: FontStyle.italic)),
    ]);
  }
}
