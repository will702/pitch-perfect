import 'dart:async';
import 'dart:isolate';

import '../audio/audio_chunk.dart';
import 'audio_features.dart';

/// Runs [FrameAnalyzer] in its own isolate so DSP never blocks the UI isolate.
abstract interface class AudioAnalysisEngine {
  Stream<AudioFeatureSample> analyze(Stream<AudioChunk> audio);
  Future<void> dispose();
}

class IsolateAudioAnalysisEngine implements AudioAnalysisEngine {
  Isolate? _isolate;
  ReceivePort? _rx;
  StreamSubscription<AudioChunk>? _sub;
  StreamController<AudioFeatureSample>? _out;

  @override
  Stream<AudioFeatureSample> analyze(Stream<AudioChunk> audio) {
    final out = StreamController<AudioFeatureSample>();
    _out = out;
    final rx = ReceivePort();
    _rx = rx;
    SendPort? tx;
    final pending = <AudioChunk>[];

    rx.listen((m) {
      if (m is SendPort) {
        tx = m;
        for (final c in pending) {
          _send(tx!, c);
        }
        pending.clear();
      } else if (m is List) {
        for (final f in m) {
          final l = f as List;
          out.add(AudioFeatureSample(Duration(microseconds: l[0] as int),
              l[1] as double, l[2] as double?, l[3] as bool));
        }
      }
    });

    Isolate.spawn(_entry, rx.sendPort).then((i) => _isolate = i);
    _sub = audio.listen((c) {
      if (tx == null) {
        if (pending.length < 100) pending.add(c); // bounded
      } else {
        _send(tx!, c);
      }
    }, onDone: () => out.close());
    return out.stream;
  }

  static void _send(SendPort p, AudioChunk c) =>
      p.send([c.timestamp.inMicroseconds, TransferableTypedData.fromList([c.samples])]);

  static void _entry(SendPort reply) {
    final port = ReceivePort();
    reply.send(port.sendPort);
    final analyzer = FrameAnalyzer();
    port.listen((m) {
      final l = m as List;
      final samples = (l[1] as TransferableTypedData)
          .materialize()
          .asFloat32List();
      final feats = analyzer.add(samples, Duration(microseconds: l[0] as int));
      if (feats.isEmpty) return;
      reply.send([
        for (final f in feats)
          [f.timestamp.inMicroseconds, f.rms, f.f0Hz, f.isVoiced]
      ]);
    });
  }

  @override
  Future<void> dispose() async {
    await _sub?.cancel();
    _isolate?.kill(priority: Isolate.immediate);
    _isolate = null;
    _rx?.close();
    _rx = null;
    final out = _out;
    _out = null;
    if (out != null && !out.isClosed) await out.close();
  }
}
