# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

PitchPerfect: local-first Flutter app (Android primary) for real-time speech recognition plus delivery coaching. `SPEC.md`, `ARCHITECTURE.md` and `TASKS.md` are the source of truth. `TASKS.md` ends with the agent coding rules, e.g. no cloud dependencies for core features, never store raw mic audio, keep business logic out of widgets, keep benchmark instrumentation.

## Commands

```bash
flutter pub get
dart run build_runner build          # regenerate lib/core/database/database.g.dart after editing database.dart
flutter analyze
flutter test                         # all
flutter test test/analysis_test.dart --plain-name "YIN"   # single file / single test
dart run tool/wer.dart ref.txt hyp.txt                    # WER/CER, line-aligned files
dart run tool/latency_stats.dart benchmark_*.json         # mean/median/P95 from exported benchmarks
flutter build apk --debug            # first build ~18 min (Gradle + native libs)
```

`database.g.dart` is committed; regenerate and commit it whenever tables change.

## Architecture

Pipeline (one session): `AudioCaptureService` (PCM16 16 kHz mono → Float32 `AudioChunk`) → broadcast stream → two independent consumers:
- `SpeechRecognitionEngine.recognize()` → partial/final `SpeechRecognitionResult`
- `AudioAnalysisEngine.analyze()` → `AudioFeatureSample` (RMS, YIN F0, voiced flag)

Both feed `MetricsAggregator` (`core/metrics`) → `LiveSessionMetrics` → `FeedbackEngine` (`core/feedback`). `PracticeSessionController` (`features/practice/application`) is the only orchestrator: it owns lifecycle, a 250 ms tick, 1 Hz snapshots, and the sealed `PracticeState`. On stop it finalizes metrics, computes script/keyword coverage and score, and saves through `SessionRepository`.

Things that span several files:
- **Audio clock.** All timestamps and "now" values are audio time (end of the latest chunk), not wall time. Wall time is used only for the mic-stall check and `LatencyRecorder` (anchored from the first chunk).
- **Engines are swappable via Riverpod factory providers** in `app/providers.dart` (`audioCaptureFactoryProvider`, `asrEngineFactoryProvider`, `analysisEngineFactoryProvider`). Tests override these with fakes (see `test/session_flow_test.dart`). The Settings toggle picks `LocalAsrEngine` vs `MockSpeechRecognitionEngine`.
- **`LocalAsrEngine`** (sherpa-onnx, Whisper-tiny int8, downloaded once by `ModelManager`) runs in its own isolate. Whisper is offline-only, so partials come from re-decoding the current utterance buffer about every second. An utterance is finalized after 700 ms of trailing silence or at 20 s. Decode backoff keeps it from falling behind real time.
- **DSP isolate.** `IsolateAudioAnalysisEngine` wraps the pure-Dart `FrameAnalyzer` (1024-sample window, 512 hop). Unit tests call `FrameAnalyzer` directly; don't put widget or Flutter imports in `core/analysis`, `core/metrics` or `core/feedback`.
- **Persistence stores aggregates only.** Transcript segments, 1 Hz metric snapshots, pause events, feedback events. Raw 20 ms frames and raw audio are never persisted. Settings are a key/value Drift table, not shared_preferences.
- **Scoring** (`core/analysis/scoring.dart`) is a transparent heuristic with SPEC §9 weights. If there is no script or keywords, the coverage weight is redistributed. Keep it described as a coaching indicator.
- **Feedback rules** hold sustained-condition timers in `FeedbackContext`. Engine rule order is the priority. There is one active tip, a 10 s global cooldown, and a 30 s per-type cooldown.

## Gotchas

- Drift: a table column named `text` clashes with the `text()` builder (it is `body` in `TranscriptSegments`), and the row class is renamed via `@DataClassName('TranscriptRow')` to avoid colliding with the domain `TranscriptSegment`.
- Riverpod is v3 (`Notifier` / `NotifierProvider`).
- The stop flow must always run `_cleanup()` (capture, ASR and DSP isolates, timers). `_emit` is guarded so late ASR results can't overwrite `PracticeStopping`.
- Local-ASR and mic behavior can only be verified on a real device; the unit and integration tests use the mock engine and a fake capture.
