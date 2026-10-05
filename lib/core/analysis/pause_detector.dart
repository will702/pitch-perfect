enum PauseKind { normal, short, intentional, long }

PauseKind classifyPause(Duration d) {
  final ms = d.inMilliseconds;
  if (ms < 300) return PauseKind.normal;
  if (ms < 1000) return PauseKind.short;
  if (ms <= 3000) return PauseKind.intentional;
  return PauseKind.long;
}

class PauseEvent {
  final Duration start;
  final Duration end;
  const PauseEvent(this.start, this.end);
  Duration get duration => end - start;
  PauseKind get kind => classifyPause(duration);
}

/// VOICE -> PENDING_SILENCE -> (voice resumes) emits PauseEvent if the silence
/// was at least [minPause]. Feed frames in time order.
class PauseDetector {
  PauseDetector({this.minPause = const Duration(milliseconds: 300)});

  final Duration minPause;
  bool _seenVoice = false;
  Duration? _silenceStart;

  /// Current silence length once speech has started (for live "long pause" tips).
  Duration currentSilence(Duration now) =>
      _silenceStart == null ? Duration.zero : now - _silenceStart!;

  PauseEvent? onFrame(Duration at, bool voiced) {
    if (voiced) {
      final s = _silenceStart;
      _silenceStart = null;
      _seenVoice = true;
      if (s != null && at - s >= minPause) return PauseEvent(s, at);
      return null;
    }
    if (_seenVoice) _silenceStart ??= at;
    return null;
  }

  /// Closes a pause still open at session end.
  PauseEvent? finish(Duration at) {
    final s = _silenceStart;
    _silenceStart = null;
    if (s != null && at - s >= minPause) return PauseEvent(s, at);
    return null;
  }
}
