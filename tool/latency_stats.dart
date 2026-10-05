// ignore_for_file: avoid_print
// Usage: dart run tool/latency_stats.dart <benchmark_*.json> [more.json ...]
// Reads files exported from the result screen; prints mean/median/P95.
import 'dart:convert';
import 'dart:io';

import 'package:pitch_perfect/core/benchmark/latency_recorder.dart';

void main(List<String> args) {
  if (args.isEmpty) {
    stderr.writeln('usage: dart run tool/latency_stats.dart <benchmark.json> ...');
    exit(64);
  }
  final e2e = <num>[], inf = <num>[];
  for (final path in args) {
    final j = jsonDecode(File(path).readAsStringSync()) as Map<String, dynamic>;
    for (final s in j['samples'] as List) {
      final m = s as Map<String, dynamic>;
      if (m['end_to_end_ms'] != null) e2e.add(m['end_to_end_ms'] as num);
      if (m['inference_ms'] != null) inf.add(m['inference_ms'] as num);
    }
  }
  void show(String name, List<num> l) {
    final s = latencyStats(l);
    print('$name: n=${s.count} mean=${s.mean.toStringAsFixed(0)}ms '
        'median=${s.median.toStringAsFixed(0)}ms p95=${s.p95.toStringAsFixed(0)}ms');
  }

  show('end-to-end (audio spoken -> rendered)', e2e);
  show('inference', inf);
}
