/// A finalized word with the time it was spoken (session offset).
class TimedWord {
  final Duration at;
  const TimedWord(this.at);
}

class WpmCalculator {
  WpmCalculator({this.window = const Duration(seconds: 15)});

  final Duration window;
  final List<Duration> _words = [];

  int get totalWords => _words.length;

  /// Adds [count] words spread evenly over [start]..[end].
  void addSegment(int count, Duration start, Duration end) {
    if (count <= 0) return;
    final span = (end - start).inMicroseconds;
    for (var i = 0; i < count; i++) {
      _words.add(start + Duration(microseconds: span * (i + 1) ~/ count));
    }
  }

  /// words in last [window] / window * 60. Window shrinks to elapsed time early on.
  double rollingWpm(Duration now) {
    if (_words.isEmpty) return 0;
    final w = now < window ? now : window;
    if (w.inMilliseconds <= 0) return 0;
    final from = now - w;
    final n = _words.where((t) => t > from && t <= now).length;
    return n * 60000 / w.inMilliseconds;
  }

  /// total words / spoken minutes, excluding [excludedPause] time.
  double averageWpm(Duration elapsed, {Duration excludedPause = Duration.zero}) {
    final spoken = elapsed - excludedPause;
    if (spoken.inMilliseconds <= 0 || _words.isEmpty) return 0;
    return _words.length * 60000 / spoken.inMilliseconds;
  }
}

enum WpmZone { tooSlow, calm, good, fast, tooFast }

WpmZone wpmZone(double wpm,
    {double slow = 100, double calm = 130, double good = 170, double fast = 190}) {
  if (wpm < slow) return WpmZone.tooSlow;
  if (wpm < calm) return WpmZone.calm;
  if (wpm < good) return WpmZone.good;
  if (wpm <= fast) return WpmZone.fast;
  return WpmZone.tooFast;
}
