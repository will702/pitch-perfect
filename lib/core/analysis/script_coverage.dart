import 'text_normalizer.dart';

class ScriptCoverageResult {
  final double coverage; // fraction of script tokens matched in order
  final double unscripted; // fraction of spoken tokens not in script alignment
  final List<String> missedSentences; // sentences with < 50% tokens covered
  final List<bool> coveredTokens; // per script token, for highlighting
  const ScriptCoverageResult(
      this.coverage, this.unscripted, this.missedSentences, this.coveredTokens);
}

/// Token-level LCS alignment between script and spoken text.
/// ponytail: O(n*m) memory; fine for scripts under a few thousand words.
ScriptCoverageResult scriptCoverage(String script, String spoken) {
  final s = tokenize(script);
  final t = tokenize(spoken);
  if (s.isEmpty) return const ScriptCoverageResult(0, 0, [], []);
  final dp = List.generate(s.length + 1, (_) => List.filled(t.length + 1, 0));
  for (var i = 1; i <= s.length; i++) {
    for (var j = 1; j <= t.length; j++) {
      dp[i][j] = s[i - 1] == t[j - 1]
          ? dp[i - 1][j - 1] + 1
          : (dp[i - 1][j] > dp[i][j - 1] ? dp[i - 1][j] : dp[i][j - 1]);
    }
  }
  final covered = List.filled(s.length, false);
  var i = s.length, j = t.length;
  while (i > 0 && j > 0) {
    if (s[i - 1] == t[j - 1]) {
      covered[i - 1] = true;
      i--;
      j--;
    } else if (dp[i - 1][j] >= dp[i][j - 1]) {
      i--;
    } else {
      j--;
    }
  }
  final lcs = dp[s.length][t.length];

  // Missed sentences: map tokens back to sentences.
  final missed = <String>[];
  var idx = 0;
  for (final sent in script.split(RegExp(r'(?<=[.!?\n])\s+'))) {
    final n = tokenize(sent).length;
    if (n == 0) continue;
    final hit = covered.sublist(idx, idx + n).where((c) => c).length;
    if (hit * 2 < n) missed.add(sent.trim());
    idx += n;
  }
  return ScriptCoverageResult(
    lcs / s.length,
    t.isEmpty ? 0 : (t.length - lcs) / t.length,
    missed,
    covered,
  );
}

/// Keyword is covered if all its tokens appear (any order) in the spoken text.
({double coverage, List<String> missed}) keywordCoverage(
    List<String> keywords, String spoken) {
  if (keywords.isEmpty) return (coverage: 0, missed: <String>[]);
  final bag = tokenize(spoken).toSet();
  final missed = [
    for (final k in keywords)
      if (!tokenize(k).every(bag.contains)) k
  ];
  return (coverage: 1 - missed.length / keywords.length, missed: missed);
}
