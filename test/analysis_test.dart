import 'dart:math';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:pitch_perfect/core/analysis/audio_features.dart';
import 'package:pitch_perfect/core/analysis/filler_detector.dart';
import 'package:pitch_perfect/core/analysis/pause_detector.dart';
import 'package:pitch_perfect/core/analysis/pitch_detector.dart';
import 'package:pitch_perfect/core/analysis/rms_calculator.dart';
import 'package:pitch_perfect/core/analysis/script_coverage.dart';
import 'package:pitch_perfect/core/analysis/text_normalizer.dart';
import 'package:pitch_perfect/core/analysis/wpm_calculator.dart';

Float32List sine(double hz, double seconds, {double amp = 0.5, int sr = 16000}) =>
    Float32List.fromList([
      for (var i = 0; i < seconds * sr; i++) amp * sin(2 * pi * hz * i / sr)
    ]);

void main() {
  test('normalize + tokenize', () {
    expect(normalizeText('  Hello,   WORLD! '), 'hello world');
    expect(tokenize("It's fine."), ["it's", 'fine']);
    expect(tokenize('...'), isEmpty);
  });

  group('filler detection', () {
    final d = FillerDetector();
    test('english incl. multi-word', () {
      expect(d.count('Um, you know, I actually like it'),
          {'um': 1, 'you know': 1, 'actually': 1, 'like': 1});
    });
    test('indonesian', () {
      expect(d.count('Eee jadi anu emm kayak mungkin'),
          {'eee': 1, 'jadi': 1, 'anu': 1, 'emm': 1, 'kayak': 1, 'mungkin': 1});
    });
    test('no false positives on substrings', () {
      expect(d.count('umbrella unlike'), isEmpty);
    });
  });

  group('wpm', () {
    test('rolling 15 s window', () {
      final w = WpmCalculator();
      w.addSegment(30, Duration.zero, const Duration(seconds: 15));
      expect(w.rollingWpm(const Duration(seconds: 15)), closeTo(120, 0.5));
      // 30 words in the last 15 s of a 30 s session -> still 120.
      expect(w.rollingWpm(const Duration(seconds: 30)), 0);
    });
    test('average excludes pauses', () {
      final w = WpmCalculator()..addSegment(100, Duration.zero, const Duration(seconds: 30));
      expect(w.averageWpm(const Duration(seconds: 60)), 100);
      expect(
          w.averageWpm(const Duration(seconds: 60),
              excludedPause: const Duration(seconds: 30)),
          200);
    });
    test('zones', () {
      expect(wpmZone(90), WpmZone.tooSlow);
      expect(wpmZone(120), WpmZone.calm);
      expect(wpmZone(150), WpmZone.good);
      expect(wpmZone(180), WpmZone.fast);
      expect(wpmZone(200), WpmZone.tooFast);
    });
  });

  group('pause detection', () {
    test('classification boundaries', () {
      expect(classifyPause(const Duration(milliseconds: 299)), PauseKind.normal);
      expect(classifyPause(const Duration(milliseconds: 300)), PauseKind.short);
      expect(classifyPause(const Duration(seconds: 1)), PauseKind.intentional);
      expect(classifyPause(const Duration(seconds: 3)), PauseKind.intentional);
      expect(classifyPause(const Duration(milliseconds: 3001)), PauseKind.long);
    });
    test('state machine ignores leading silence and emits on resume', () {
      final d = PauseDetector();
      Duration t(int ms) => Duration(milliseconds: ms);
      expect(d.onFrame(t(0), false), isNull); // before first voice: not a pause
      expect(d.onFrame(t(500), true), isNull);
      expect(d.onFrame(t(600), false), isNull);
      expect(d.currentSilence(t(900)), t(300));
      final e = d.onFrame(t(2000), true)!;
      expect(e.duration, t(1400));
      expect(e.kind, PauseKind.intentional);
    });
    test('real audio: speech, 2 s silence, speech -> one pause', () {
      final a = FrameAnalyzer();
      final samples = Float32List.fromList([
        ...sine(200, 1),
        ...Float32List(32000),
        ...sine(200, 1),
      ]);
      final feats = <AudioFeatureSample>[];
      for (var i = 0; i < samples.length; i += 1600) {
        feats.addAll(a.add(Float32List.sublistView(samples, i, min(i + 1600, samples.length)),
            Duration(microseconds: i * 1000000 ~/ 16000)));
      }
      final p = pausesOf(feats);
      expect(p, hasLength(1));
      expect(p.single.duration.inMilliseconds, inInclusiveRange(1800, 2200));
    });
  });

  test('rms of sine = amp/sqrt2', () {
    expect(rms(sine(440, 0.1, amp: 1)), closeTo(1 / sqrt2, 0.01));
    expect(rms(Float32List(100)), 0);
  });

  group('YIN', () {
    final y = PitchDetector();
    test('220 Hz sine within 2 Hz', () {
      final f0 = y.detect(sine(220, 0.1).sublist(0, 1024));
      expect(f0, isNotNull);
      expect(f0!, closeTo(220, 2));
    });
    test('120 Hz and 350 Hz', () {
      expect(y.detect(sine(120, 0.1).sublist(0, 1024))!, closeTo(120, 2));
      expect(y.detect(sine(350, 0.1).sublist(0, 1024))!, closeTo(350, 3));
    });
    test('silence and noise are unvoiced', () {
      expect(y.detect(Float32List(1024)), isNull);
      final r = Random(1);
      final noise = Float32List.fromList([for (var i = 0; i < 1024; i++) r.nextDouble() - 0.5]);
      expect(y.detect(noise), isNull);
    });
  });

  group('script coverage', () {
    const script = 'Good morning everyone. Today we introduce our product. Thank you.';
    test('full coverage', () {
      final r = scriptCoverage(script, 'good morning everyone today we introduce our product thank you');
      expect(r.coverage, 1);
      expect(r.unscripted, 0);
      expect(r.missedSentences, isEmpty);
    });
    test('partial with missed sentence and extra words', () {
      final r = scriptCoverage(script, 'good morning everyone um well thank you');
      expect(r.coverage, closeTo(5 / 10, 0.01));
      expect(r.missedSentences, ['Today we introduce our product.']);
      expect(r.unscripted, closeTo(2 / 7, 0.01));
    });
    test('keywords', () {
      final k = keywordCoverage(['Problem', 'Business Model', 'Traction'],
          'the problem is big and our traction is growing');
      expect(k.coverage, closeTo(2 / 3, 0.01));
      expect(k.missed, ['Business Model']);
    });
  });
}
