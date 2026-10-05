import 'dart:async';
import 'dart:isolate';
import 'dart:math';
import 'dart:typed_data';

import 'package:sherpa_onnx/sherpa_onnx.dart' as sherpa;

import '../audio/audio_chunk.dart';
import 'model_manager.dart';
import 'speech_recognition_engine.dart';
import 'speech_recognition_result.dart';

/// On-device Whisper via sherpa-onnx, running in a dedicated isolate.
/// Whisper is an offline model, so partials are produced by re-decoding the
/// current utterance buffer about every second; an utterance is finalized
/// after ~700 ms of trailing silence or when the buffer reaches 20 s.
class LocalAsrEngine implements SpeechRecognitionEngine {
  LocalAsrEngine({this.language = 'en', ModelManager? models})
      : _models = models ?? ModelManager();

  final String language;
  final ModelManager _models;
  final _progress = StreamController<double>.broadcast();

  Isolate? _isolate;
  ReceivePort? _rx;
  SendPort? _tx;
  StreamController<SpeechRecognitionResult>? _out;
  StreamSubscription<AudioChunk>? _sub;

  @override
  Stream<double> get initProgress => _progress.stream;

  @override
  Future<void> initialize() async {
    final paths = await _models.ensure(_progress.add);
    final rx = ReceivePort();
    _rx = rx;
    final ready = Completer<void>();
    rx.listen((m) {
      if (m is SendPort) {
        _tx = m;
        m.send(['init', paths.encoder, paths.decoder, paths.tokens, language]);
      } else if (m == 'ready') {
        if (!ready.isCompleted) ready.complete();
      } else if (m is String && m.startsWith('error:')) {
        final e = StateError(m.substring(6));
        if (!ready.isCompleted) {
          ready.completeError(e);
        } else {
          _out?.addError(e);
        }
      } else if (m == 'done') {
        _out?.close();
      } else if (m is List) {
        _out?.add(SpeechRecognitionResult(
          text: m[0] as String,
          start: Duration(microseconds: m[1] as int),
          end: Duration(microseconds: m[2] as int),
          isFinal: m[3] as bool,
          inferenceStartedAt: DateTime.fromMicrosecondsSinceEpoch(m[4] as int),
          resultReceivedAt: DateTime.now(),
        ));
      }
    });
    _isolate = await Isolate.spawn(_entry, rx.sendPort);
    await ready.future.timeout(const Duration(seconds: 60));
  }

  @override
  Stream<SpeechRecognitionResult> recognize(Stream<AudioChunk> audio) {
    final out = StreamController<SpeechRecognitionResult>();
    _out = out;
    _sub = audio.listen(
      (c) => _tx?.send([
        'audio',
        c.timestamp.inMicroseconds,
        TransferableTypedData.fromList([c.samples]),
      ]),
      onDone: () => _tx?.send(['flush']),
    );
    return out.stream;
  }

  @override
  Future<void> reset() async => _tx?.send(['reset']);

  @override
  Future<void> dispose() async {
    await _sub?.cancel();
    _sub = null;
    _isolate?.kill(priority: Isolate.immediate);
    _isolate = null;
    _rx?.close();
    _rx = null;
    _tx = null;
    final out = _out;
    _out = null;
    if (out != null && !out.isClosed) await out.close();
    await _progress.close();
  }

  // ---- isolate side ----

  static void _entry(SendPort reply) {
    final port = ReceivePort();
    reply.send(port.sendPort);
    _Worker? w;
    port.listen((m) {
      final l = m as List;
      try {
        switch (l[0]) {
          case 'init':
            sherpa.initBindings();
            w = _Worker(reply, l[1], l[2], l[3], l[4]);
            reply.send('ready');
          case 'audio':
            w?.add(
              (l[2] as TransferableTypedData).materialize().asFloat32List(),
              l[1] as int,
            );
          case 'flush':
            w?.finalizeUtterance();
            reply.send('done');
          case 'reset':
            w?.clear();
        }
      } catch (e) {
        reply.send('error:$e');
      }
    });
  }
}

class _Worker {
  _Worker(this._reply, String encoder, String decoder, String tokens, String lang)
      : _rec = sherpa.OfflineRecognizer(sherpa.OfflineRecognizerConfig(
          model: sherpa.OfflineModelConfig(
            whisper: sherpa.OfflineWhisperModelConfig(
              encoder: encoder,
              decoder: decoder,
              language: lang,
              task: 'transcribe',
            ),
            tokens: tokens,
            numThreads: 2,
            debug: false,
          ),
        ));

  static const _sr = 16000;
  static const _maxSamples = 20 * _sr;
  static const _prerollSamples = _sr * 3 ~/ 10;
  static const _silenceToFinal = Duration(milliseconds: 700);
  static const _partialEvery = Duration(seconds: 1);
  static const _voiceRms = 0.012;

  final SendPort _reply;
  final sherpa.OfflineRecognizer _rec;
  final Float32List _buf = Float32List(_maxSamples);
  int _len = 0;
  int _startMicros = 0;
  int _voicedSamples = 0;
  int _trailingSilence = 0;
  int _sinceDecode = 0;
  int _decodeBackoff = 0; // samples to wait, grows when decode is slow
  String _lastPartial = '';

  void clear() {
    _len = 0;
    _voicedSamples = 0;
    _trailingSilence = 0;
    _sinceDecode = 0;
    _lastPartial = '';
  }

  void add(Float32List s, int tsMicros) {
    var e = 0.0;
    for (final x in s) {
      e += x * x;
    }
    final voiced = sqrt(e / s.length) > _voiceRms;

    if (_voicedSamples == 0 && !voiced) {
      // Idle: keep only a short pre-roll so the first phoneme isn't clipped.
      _append(s, tsMicros, isIdle: true);
      return;
    }
    _append(s, tsMicros);
    if (voiced) {
      _voicedSamples += s.length;
      _trailingSilence = 0;
    } else {
      _trailingSilence += s.length;
    }
    _sinceDecode += s.length;

    final silenceDone = _trailingSilence * 1000000 ~/ _sr >= _silenceToFinal.inMicroseconds;
    if (_len >= _maxSamples || silenceDone) {
      finalizeUtterance();
    } else if (_voicedSamples >= _sr ~/ 4 &&
        _sinceDecode >= _partialEvery.inMicroseconds * _sr ~/ 1000000 + _decodeBackoff) {
      _decode(isFinal: false);
    }
  }

  void _append(Float32List s, int tsMicros, {bool isIdle = false}) {
    if (_len == 0) _startMicros = tsMicros;
    var src = s;
    if (_len + src.length > _maxSamples) {
      src = Float32List.sublistView(src, 0, _maxSamples - _len);
    }
    _buf.setRange(_len, _len + src.length, src);
    _len += src.length;
    if (isIdle && _len > _prerollSamples) {
      final keep = _prerollSamples;
      _buf.setRange(0, keep, _buf, _len - keep);
      _startMicros = tsMicros + s.length * 1000000 ~/ _sr - keep * 1000000 ~/ _sr;
      _len = keep;
    }
  }

  void finalizeUtterance() {
    if (_voicedSamples >= _sr ~/ 5 && _len > 0) _decode(isFinal: true);
    clear();
  }

  void _decode({required bool isFinal}) {
    final t0 = DateTime.now();
    final stream = _rec.createStream();
    try {
      stream.acceptWaveform(
          samples: Float32List.sublistView(_buf, 0, _len), sampleRate: _sr);
      _rec.decode(stream);
      final text = _rec.getResult(stream).text.trim();
      _sinceDecode = 0;
      final took = DateTime.now().difference(t0);
      // If decoding is slower than real time, wait proportionally longer.
      _decodeBackoff = max(0, (took.inMicroseconds * 2 * _sr ~/ 1000000) - _partialEvery.inSeconds * _sr);
      if (text.isEmpty || (!isFinal && text == _lastPartial)) return;
      _lastPartial = text;
      _reply.send([
        text,
        _startMicros,
        _startMicros + _len * 1000000 ~/ _sr,
        isFinal,
        t0.microsecondsSinceEpoch,
      ]);
    } finally {
      stream.free();
    }
  }
}
