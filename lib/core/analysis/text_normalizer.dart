/// Lowercase, strip punctuation, collapse whitespace.
String normalizeText(String s) => s
    .toLowerCase()
    .replaceAll(RegExp(r"[^\p{L}\p{N}\s']", unicode: true), ' ')
    .replaceAll(RegExp(r'\s+'), ' ')
    .trim();

List<String> tokenize(String s) {
  final n = normalizeText(s);
  return n.isEmpty ? const [] : n.split(' ');
}
