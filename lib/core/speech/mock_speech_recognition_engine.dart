import 'dart:async';

import '../audio/audio_chunk.dart';
import 'speech_recognition_engine.dart';
import 'speech_recognition_result.dart';

const _enScript = [
  'good morning everyone um today I would like to introduce our product',
  'basically it helps students practice presentations with live feedback',
  'you know the problem is that nobody tells you how you actually sound',
  'our solution listens to your voice and coaches you in real time',
  'thank you for listening',
];

const _idScript = [
  'selamat pagi semuanya eee hari ini saya ingin memperkenalkan produk kami',
  'jadi aplikasi ini membantu mahasiswa berlatih presentasi dengan umpan balik langsung',
  'anu masalahnya adalah tidak ada yang memberi tahu bagaimana suara kita',
  'solusi kami mendengarkan suara anda dan melatih anda secara langsung',
  'terima kasih',
];

/// Emits canned words while voiced audio flows, so the whole pipeline works
/// without a model. One word per [wordInterval] of voiced audio.
class MockSpeechRecognitionEngine implements SpeechRecognitionEngine {
  MockSpeechRecognitionEngine({
    this.language = 'en',
    this.wordInterval = const Duration(milliseconds: 400),
    this.voiceThreshold = 0.01,
    this.silenceToFinalize = const Duration(milliseconds: 700),
  });

  final String language;
  final Duration wordInterval;
  final double voiceThreshold;
  final Duration silenceToFinalize;

  StreamSubscription<AudioChunk>? _sub;
  StreamController<SpeechRecognitionResult>? _out;
  int _sentence = 0;
  List<String> _words = [];
  Duration _segStart = Duration.zero;
  Duration _voicedSinceWord = Duration.zero;
  Duration _silence = Duration.zero;

  @override
  Stream<double> get initProgress => const Stream.empty();

  @override
  Future<void> initialize() async {}

  List<String> get _script => language == 'id' ? _idScript : _enScript;

  @override
  Stream<SpeechRecognitionResult> recognize(Stream<AudioChunk> audio) {
    final out = StreamController<SpeechRecognitionResult>();
    _out = out;
    _sub = audio.listen((c) => _onChunk(c, out), onDone: () {
      _flush(Duration.zero, out);
      out.close();
    });
    return out.stream;
  }

  double _rms(AudioChunk c) {
    var s = 0.0;
    for (final x in c.samples) {
      s += x * x;
    }
    return c.samples.isEmpty ? 0 : (s / c.samples.length);
  }

  void _onChunk(AudioChunk c, StreamController<SpeechRecognitionResult> out) {
    final voiced = _rms(c) > voiceThreshold * voiceThreshold;
    if (!voiced) {
      _silence += c.duration;
      if (_words.isNotEmpty && _silence >= silenceToFinalize) {
        _flush(c.end, out);
      }
      return;
    }
    _silence = Duration.zero;
    _voicedSinceWord += c.duration;
    if (_voicedSinceWord < wordInterval) return;
    _voicedSinceWord = Duration.zero;

    final sentence = _script[_sentence % _script.length].split(' ');
    if (_words.isEmpty) _segStart = c.timestamp;
    _words.add(sentence[_words.length]);
    final now = DateTime.now();
    final done = _words.length == sentence.length;
    out.add(SpeechRecognitionResult(
      text: _words.join(' '),
      start: _segStart,
      end: c.end,
      isFinal: done,
      confidence: 0.9,
      inferenceStartedAt: now,
      resultReceivedAt: now,
    ));
    if (done) {
      _words = [];
      _sentence++;
    }
  }

  /// Finalizes a pending partial after silence / end of stream.
  void _flush(Duration end, StreamController<SpeechRecognitionResult> out) {
    if (_words.isEmpty || out.isClosed) return;
    final now = DateTime.now();
    out.add(SpeechRecognitionResult(
      text: _words.join(' '),
      start: _segStart,
      end: end == Duration.zero ? _segStart : end,
      isFinal: true,
      confidence: 0.9,
      inferenceStartedAt: now,
      resultReceivedAt: now,
    ));
    _words = [];
    _sentence++;
  }

  @override
  Future<void> reset() async {
    _words = [];
    _sentence = 0;
    _voicedSinceWord = Duration.zero;
    _silence = Duration.zero;
  }

  @override
  Future<void> dispose() async {
    await _sub?.cancel();
    _sub = null;
    final out = _out;
    _out = null;
    if (out != null && !out.isClosed) await out.close();
  }
}
