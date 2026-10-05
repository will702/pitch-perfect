import '../analysis/text_normalizer.dart';

int _edit<T>(List<T> a, List<T> b) {
  var prev = List.generate(b.length + 1, (j) => j);
  for (var i = 1; i <= a.length; i++) {
    final cur = List.filled(b.length + 1, 0);
    cur[0] = i;
    for (var j = 1; j <= b.length; j++) {
      final sub = prev[j - 1] + (a[i - 1] == b[j - 1] ? 0 : 1);
      final del = prev[j] + 1;
      final ins = cur[j - 1] + 1;
      cur[j] = sub < del ? (sub < ins ? sub : ins) : (del < ins ? del : ins);
    }
    prev = cur;
  }
  return prev[b.length];
}

/// Word-level edit distance after normalization.
({int edits, int refLength}) wordEdits(String reference, String hypothesis) {
  final r = tokenize(reference), h = tokenize(hypothesis);
  return (edits: _edit(r, h), refLength: r.length);
}

({int edits, int refLength}) charEdits(String reference, String hypothesis) {
  final r = normalizeText(reference).split(''), h = normalizeText(hypothesis).split('');
  return (edits: _edit(r, h), refLength: r.length);
}

double wer(String reference, String hypothesis) {
  final e = wordEdits(reference, hypothesis);
  return e.refLength == 0 ? (e.edits == 0 ? 0 : 1) : e.edits / e.refLength;
}

double cer(String reference, String hypothesis) {
  final e = charEdits(reference, hypothesis);
  return e.refLength == 0 ? (e.edits == 0 ? 0 : 1) : e.edits / e.refLength;
}

/// Corpus-level WER over line-aligned lists (sum of edits / sum of ref words).
double corpusWer(List<String> refs, List<String> hyps) {
  var edits = 0, len = 0;
  for (var i = 0; i < refs.length; i++) {
    final e = wordEdits(refs[i], i < hyps.length ? hyps[i] : '');
    edits += e.edits;
    len += e.refLength;
  }
  return len == 0 ? 0 : edits / len;
}
