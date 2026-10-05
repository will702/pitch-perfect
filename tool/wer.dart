// ignore_for_file: avoid_print
// Usage: dart run tool/wer.dart <reference.txt> <hypothesis.txt>
// One utterance per line, line-aligned. Prints corpus WER/CER and per-line WER.
import 'dart:io';

import 'package:pitch_perfect/core/benchmark/wer.dart';

void main(List<String> args) {
  if (args.length != 2) {
    stderr.writeln('usage: dart run tool/wer.dart <reference.txt> <hypothesis.txt>');
    exit(64);
  }
  final refs = File(args[0]).readAsLinesSync().where((l) => l.trim().isNotEmpty).toList();
  final hyps = File(args[1]).readAsLinesSync().where((l) => l.trim().isNotEmpty).toList();
  if (refs.length != hyps.length) {
    stderr.writeln('warning: ${refs.length} references vs ${hyps.length} hypotheses');
  }
  for (var i = 0; i < refs.length; i++) {
    final h = i < hyps.length ? hyps[i] : '';
    print('line ${i + 1}: WER ${(wer(refs[i], h) * 100).toStringAsFixed(1)}%  CER ${(cer(refs[i], h) * 100).toStringAsFixed(1)}%');
  }
  var ce = 0, cl = 0;
  for (var i = 0; i < refs.length; i++) {
    final e = charEdits(refs[i], i < hyps.length ? hyps[i] : '');
    ce += e.edits;
    cl += e.refLength;
  }
  print('CORPUS WER ${(corpusWer(refs, hyps) * 100).toStringAsFixed(2)}%  CER ${(cl == 0 ? 0 : ce / cl * 100).toStringAsFixed(2)}%');
}
