import 'text_normalizer.dart';

const defaultFillers = <String>[
  // English
  'um', 'uh', 'like', 'actually', 'basically', 'you know',
  // Indonesian
  'eh', 'emm', 'eee', 'anu', 'jadi', 'kayak', 'mungkin',
];

/// Rule-based, approximate (ARCHITECTURE §11). Multi-word phrases are matched
/// first, longest phrase wins; tokens are never double-counted.
class FillerDetector {
  FillerDetector([Iterable<String> fillers = defaultFillers])
      : _phrases = (fillers.map(tokenize).where((p) => p.isNotEmpty).toList()
          ..sort((a, b) => b.length.compareTo(a.length)));

  final List<List<String>> _phrases;

  /// phrase -> count in [text].
  Map<String, int> count(String text) {
    final tokens = tokenize(text);
    final out = <String, int>{};
    var i = 0;
    while (i < tokens.length) {
      var matched = false;
      for (final p in _phrases) {
        if (i + p.length > tokens.length) continue;
        var ok = true;
        for (var j = 0; j < p.length; j++) {
          if (tokens[i + j] != p[j]) {
            ok = false;
            break;
          }
        }
        if (ok) {
          final key = p.join(' ');
          out[key] = (out[key] ?? 0) + 1;
          i += p.length;
          matched = true;
          break;
        }
      }
      if (!matched) i++;
    }
    return out;
  }
}
