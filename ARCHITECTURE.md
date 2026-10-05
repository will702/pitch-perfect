# PitchPerfect — Architecture Specification

## 1. Architecture Goals

The system should be:

- Real-time.
- Local-first.
- Modular.
- Testable.
- Model-agnostic.
- Suitable for Flutter.
- Easy to benchmark.

The core architecture separates:

1. Audio capture.
2. Speech recognition.
3. DSP/audio analysis.
4. Metrics aggregation.
5. Feedback logic.
6. UI.

---

## 2. High-Level Architecture

```text
                       ┌────────────────────┐
                       │    Flutter UI      │
                       └─────────┬──────────┘
                                 │
                       PracticeSessionController
                                 │
             ┌───────────────────┼────────────────────┐
             │                   │                    │
             ▼                   ▼                    ▼
     AudioCaptureService   MetricsAggregator    SessionRepository
             │
             ▼
        PCM Audio Bus
        /           \
       /             \
      ▼               ▼
ASR Engine        DSP Engine
      │               │
      ▼               ▼
Transcript       Acoustic Samples
      \               /
       \             /
        ▼           ▼
       Metrics Aggregator
               │
               ▼
          FeedbackEngine
               │
               ▼
          UI State Stream
```

---

## 3. Flutter Layers

```text
Presentation
    ↓
Application
    ↓
Domain
    ↓
Infrastructure
```

### Presentation

Responsible for:

- Widgets.
- Screens.
- Charts.
- Displaying live state.

### Application

Responsible for:

- Session lifecycle.
- Starting/stopping recording.
- Coordinating ASR + DSP.
- Managing timers.
- Aggregating streams.

### Domain

Contains:

- Entities.
- Interfaces.
- Metrics logic.
- Feedback rules.

### Infrastructure

Contains:

- Microphone implementation.
- whisper.cpp / ONNX bindings.
- SQLite/Drift.
- Native DSP.

---

## 4. Suggested Directory Layout

```text
lib/
├── main.dart
├── app/
│   ├── app.dart
│   ├── router.dart
│   └── theme.dart
│
├── core/
│   ├── audio/
│   │   ├── audio_chunk.dart
│   │   ├── audio_capture_service.dart
│   │   └── record_audio_capture_service.dart
│   │
│   ├── speech/
│   │   ├── speech_recognition_engine.dart
│   │   ├── speech_recognition_result.dart
│   │   └── local_asr_engine.dart
│   │
│   ├── analysis/
│   │   ├── audio_analysis_engine.dart
│   │   ├── pitch_detector.dart
│   │   ├── rms_calculator.dart
│   │   ├── pause_detector.dart
│   │   └── filler_detector.dart
│   │
│   ├── feedback/
│   │   ├── feedback_engine.dart
│   │   └── feedback_rule.dart
│   │
│   ├── database/
│   │   ├── database.dart
│   │   └── tables/
│   │
│   └── utils/
│
├── features/
│   ├── home/
│   ├── session_setup/
│   ├── practice/
│   │   ├── application/
│   │   │   └── practice_session_controller.dart
│   │   ├── domain/
│   │   │   ├── practice_session.dart
│   │   │   ├── session_metrics.dart
│   │   │   └── transcript_segment.dart
│   │   └── presentation/
│   │       ├── practice_screen.dart
│   │       └── widgets/
│   │
│   ├── session_result/
│   ├── history/
│   └── settings/
│
└── shared/
    ├── widgets/
    └── extensions/
```

---

## 5. Audio Stream Contract

```dart
class AudioChunk {
  final Float32List samples;
  final int sampleRate;
  final int channelCount;
  final Duration timestamp;

  const AudioChunk({
    required this.samples,
    required this.sampleRate,
    required this.channelCount,
    required this.timestamp,
  });
}
```

Internal normalization target:

```text
16,000 Hz
mono
Float32 [-1, 1]
```

---

## 6. ASR Contract

```dart
abstract interface class SpeechRecognitionEngine {
  Future<void> initialize();

  Stream<SpeechRecognitionResult> recognize(
    Stream<AudioChunk> audio,
  );

  Future<void> reset();

  Future<void> dispose();
}
```

Result:

```dart
class SpeechRecognitionResult {
  final String text;
  final Duration start;
  final Duration end;

  final bool isFinal;
  final double? confidence;

  const SpeechRecognitionResult({
    required this.text,
    required this.start,
    required this.end,
    required this.isFinal,
    this.confidence,
  });
}
```

UI must support replacing partial results with finalized ones.

---

## 7. Model Integration Options

### Option A — whisper.cpp

Recommended when local inference is a priority.

Architecture:

```text
Flutter
   ↓ Dart FFI / Platform Channel
Native Wrapper
   ↓
whisper.cpp
   ↓
Local Model
```

Advantages:

- Fully local.
- Well-known implementation.
- Quantized models available.

Risks:

- Native integration complexity.
- CPU load.
- Model file size.

### Option B — ONNX Runtime

Architecture:

```text
Flutter
   ↓
ONNX Runtime binding/native plugin
   ↓
Speech model
```

Advantages:

- Model portability.

Risks:

- Pre/post-processing must be implemented carefully.

### Option C — Native Platform Speech API

Useful only as an early prototype.

Do NOT rely on this for the final academic implementation if the objective is demonstrating your own local ASR pipeline.

---

## 8. DSP Pipeline

Per audio chunk:

```text
PCM
 ↓
DC / normalization if needed
 ↓
RMS
 ↓
Voice Activity / Silence
 ↓
F0 estimation for voiced segments
 ↓
AudioFeatureSample
```

Data model:

```dart
class AudioFeatureSample {
  final Duration timestamp;

  final double rms;
  final double? f0Hz;

  final bool isVoiced;
}
```

Sampling metrics can be reduced before storage.

Example:

```text
analysis = every 20–50 ms
UI update = every 250–500 ms
DB storage = every 500–1000 ms
```

This avoids unnecessary database growth.

---

## 9. Pitch Detection

Recommended MVP algorithm:

```text
YIN
```

Pipeline:

```text
Audio frame
 ↓
Difference function
 ↓
Cumulative mean normalized difference
 ↓
Threshold search
 ↓
Parabolic interpolation
 ↓
F0
```

Only calculate pitch for voiced frames.

Suggested human speech search ranges can be broad, for example:

```text
70–400 Hz
```

Do not use this range to infer gender.

---

## 10. WPM Calculation

Use finalized transcript words.

Rolling WPM:

```text
words in last N seconds
----------------------- × 60
          N
```

Suggested rolling window:

```text
15 seconds
```

Full-session WPM:

```text
total recognized words / spoken minutes
```

Optionally exclude long silent intervals.

---

## 11. Filler Detection

Normalize:

- lowercase.
- punctuation removal.
- repeated-space collapse.

Support single and multi-word fillers.

Example model:

```dart
class FillerDefinition {
  final String phrase;
  final String language;
}
```

Avoid counting words incorrectly where the same token is meaningful in context.

For MVP, accept approximate rule-based detection.

---

## 12. Pause Detection

Use RMS / VAD state.

State machine:

```text
VOICE
 ↓ silence begins
PENDING_SILENCE
 ↓ exceeds threshold
PAUSE
 ↓ voice resumes
VOICE
```

Store:

```dart
class PauseEvent {
  final Duration start;
  final Duration end;
  final Duration duration;
}
```

---

## 13. Metrics Aggregator

Input streams:

- ASR results.
- Audio feature samples.
- Pause events.

Output:

```dart
class LiveSessionMetrics {
  final Duration duration;
  final double rollingWpm;

  final int fillerCount;
  final int longPauseCount;

  final double? currentPitchHz;
  final double? rollingPitchStdDev;

  final double currentRms;

  final String partialTranscript;
}
```

The aggregator should contain no Flutter widget code.

---

## 14. Feedback Engine

Use deterministic rules first.

```dart
abstract interface class FeedbackRule {
  FeedbackEvent? evaluate(
    LiveSessionMetrics current,
    FeedbackContext context,
  );
}
```

Feedback context stores:

- last warning.
- cooldown.
- recent warning types.

Priority example:

```text
1. Audio failure
2. Long silence
3. Very high speech rate
4. Very low speech rate
5. Very low volume
6. Monotone speech
7. Filler burst
```

---

## 15. State Management

Recommended Riverpod state:

```text
practiceSessionControllerProvider
microphonePermissionProvider
sessionHistoryProvider
settingsProvider
```

Practice state:

```dart
sealed class PracticeState {}

class PracticeIdle extends PracticeState {}

class PracticeInitializing extends PracticeState {}

class PracticeRunning extends PracticeState {
  final LiveSessionMetrics metrics;
  final List<TranscriptSegment> transcript;
  final FeedbackEvent? feedback;
}

class PracticeStopping extends PracticeState {}

class PracticeCompleted extends PracticeState {
  final PracticeSession session;
}

class PracticeError extends PracticeState {
  final Object error;
}
```

---

## 16. Concurrency

Never run ASR inference on the Flutter UI isolate.

Possible execution:

```text
UI isolate
   │
   ├── DSP isolate
   │
   └── native ASR worker
```

Important:

- Bounded queues.
- Drop or merge stale metric frames if necessary.
- Do not drop required ASR context arbitrarily.

---

## 17. Persistence

Suggested SQLite tables:

```text
sessions
transcript_segments
feedback_events
metric_snapshots
```

Do not store every 20-ms DSP frame.

Aggregate before persistence.

---

## 18. Error Handling

Handle:

- Microphone permission denied.
- Audio device unavailable.
- Model missing.
- Model failed to initialize.
- ASR worker crash.
- Recording interruption.
- App backgrounded.
- Unsupported sample format.
- Insufficient storage.

The stop flow must always clean up:

```text
audio subscription
ASR worker
DSP worker
file handles
timers
```

---

## 19. Benchmark Hooks

Build benchmark instrumentation into the architecture.

ASR result should allow:

```text
audio_timestamp
inference_started_at
result_received_at
rendered_at
```

This enables measurement of:

```text
Inference latency
End-to-end latency
UI delivery latency
```

---

## 20. Testing Strategy

### Unit Tests

- WPM calculation.
- Filler detection.
- Pause classification.
- Score calculation.
- Feedback cooldown.
- Transcript normalization.

### Integration Tests

- Audio stream → DSP metrics.
- Mock ASR → transcript UI.
- Start/stop session lifecycle.
- Session persistence.

### Golden / Widget Tests

- Live metrics cards.
- Session summary.

### Model Evaluation

Separate scripts/tools may calculate:

- WER.
- CER.
- Latency statistics.

---

## 21. Recommended Development Order

Do not start with native ASR integration.

Build in this order:

```text
Flutter shell
→ microphone
→ mock ASR
→ live transcript UI
→ WPM
→ fillers
→ DSP
→ pitch
→ pause detection
→ local ASR
→ storage
→ summary
→ benchmark
```

This keeps the application usable throughout development.
