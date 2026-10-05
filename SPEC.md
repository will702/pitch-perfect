# PitchPerfect — Product & Technical Specification

## 1. Project Overview

**Project Name:** PitchPerfect  
**Platform:** Flutter (Android-first, optionally iOS/Desktop)  
**Category:** Real-Time Speech Recognition + Voice Delivery Coaching  
**Primary Goal:** Help users practice presentations and public speaking by providing live transcription and real-time feedback on how they speak.

PitchPerfect is not only a speech-to-text application. It analyzes both:

1. **Linguistic signals** — what the user says.
2. **Acoustic signals** — how the user says it.

The application should work locally as much as possible so that speech processing is fast, private, and suitable for the Speech Recognition final project requirement.

---

## 2. Core Problem

Students and young professionals often practice presentations without objective feedback.

Common problems include:

- Speaking too quickly.
- Speaking too slowly.
- Excessive filler words.
- Long pauses.
- Monotonous delivery.
- Weak vocal emphasis.
- Reading a script too closely.
- Forgetting key points.
- Lack of immediate feedback during practice.

PitchPerfect addresses these problems using real-time speech recognition and lightweight audio analysis.

---

## 3. Target Users

### Primary Users
- University students.
- Competition / pitch participants.
- Students practicing presentations.
- Young professionals preparing talks.

### Secondary Users
- Teachers.
- Public speaking coaches.
- Interview candidates.
- Content creators.

---

## 4. Main User Flow

```text
Home
  ↓
Create Practice Session
  ↓
Optional: Paste / Import Script
  ↓
Start Microphone
  ↓
Real-Time Audio Stream
  ├── Speech Recognition
  │      ↓
  │   Partial Transcript
  │
  └── Audio Feature Extraction
         ↓
      Pitch / Energy / Pause Analysis
         ↓
Real-Time Coaching Dashboard
  ↓
Stop Session
  ↓
Session Summary
  ↓
Detailed Feedback + Transcript
```

---

## 5. MVP Features

### 5.1 Real-Time Speech Recognition

The application must continuously capture microphone audio and produce incremental speech recognition results.

Required behavior:

- Microphone audio streaming.
- Partial transcription while user is speaking.
- Finalized transcription segments.
- Timestamp for each segment.
- Offline/local inference preferred.
- Indonesian and English should be supported if technically feasible.

Example:

```text
[00:01] Good morning everyone...
[00:04] Today I would like to introduce...
```

### 5.2 Speech Rate Analysis

Calculate Words Per Minute (WPM).

Suggested zones:

| WPM | Feedback |
|---|---|
| < 100 | Too slow |
| 100–130 | Calm |
| 130–170 | Good |
| 170–190 | Fast |
| > 190 | Too fast |

Thresholds should be configurable.

### 5.3 Filler Word Detection

Detect common filler words from finalized transcript segments.

English examples:

- um
- uh
- like
- actually
- basically
- you know

Indonesian examples:

- eh
- emm
- eee
- anu
- jadi
- kayak
- mungkin

Output:

```text
Filler words: 7
Most frequent: "emm" × 3
```

### 5.4 Pause Detection

Detect silence gaps in the audio stream.

Suggested classification:

- < 300 ms: normal speech gap
- 300–1000 ms: short pause
- 1–3 seconds: intentional pause
- > 3 seconds: long pause

Store pause events for post-session analysis.

### 5.5 Voice Pitch Analysis

Estimate fundamental frequency (F0).

Metrics:

- Average F0.
- Minimum F0.
- Maximum F0.
- F0 standard deviation.
- Pitch range.
- Pitch variation over time.

The purpose is NOT to judge whether the user's voice is "good".

It is used to estimate variation in vocal delivery.

Possible feedback:

```text
Your vocal pitch remained relatively flat for the last 20 seconds.
Try emphasizing important keywords.
```

### 5.6 Volume / Energy Analysis

Use RMS or similar signal energy measurement.

Metrics:

- Average loudness.
- Relative loudness variation.
- Low-volume periods.
- Sudden peaks.

Feedback examples:

- "Your voice became quieter."
- "Volume is stable."
- "Large volume spikes detected."

Do not claim medically accurate decibel values unless proper calibration is implemented.

### 5.7 Session Summary

After stopping a session, show:

- Duration.
- Transcript.
- Average WPM.
- Filler word count.
- Number of long pauses.
- Average pitch.
- Pitch variation.
- Voice energy consistency.
- Overall delivery score.
- Key recommendations.

---

## 6. Optional Features

### 6.1 Script Coverage

User pastes a presentation script before practice.

The system compares recognized speech with the script.

Metrics:

- Script coverage percentage.
- Missed sections.
- Additional unscripted sections.
- Keyword coverage.

Possible implementation:

- Normalize text.
- Token-level similarity.
- Levenshtein distance.
- TF-IDF / cosine similarity.
- Sentence embedding similarity as future enhancement.

### 6.2 Keyword Checklist

Instead of requiring exact script matching, users define important points.

Example:

```text
[x] Problem
[x] Solution
[ ] Business Model
[x] Traction
[ ] Closing
```

This is more flexible than strict script matching.

### 6.3 Presentation Modes

#### Free Practice
No script.

#### Script Practice
Compare with prepared text.

#### Pitch Mode
Short 1–5 minute practice with stricter timing.

#### Interview Mode
Future feature.

---

## 7. Real-Time Feedback Rules

Avoid showing too many warnings while users speak.

Recommended strategy:

- Update metrics continuously.
- Only show coaching tips after a sustained condition.
- Add cooldown between tips.

Example rules:

```text
IF WPM > 190 for >= 8 seconds
THEN show "Slow down slightly."

IF pitch_variation < threshold for >= 20 seconds
THEN show "Try adding more vocal variation."

IF silence > 4 seconds
THEN show "Long pause detected."

IF volume_rms < baseline * 0.65 for >= 5 seconds
THEN show "Speak a little louder."
```

Maximum:

```text
1 active coaching message at a time.
```

Suggested cooldown:

```text
8–15 seconds
```

---

## 8. UI Screens

### 8.1 Home Screen

Components:

- App logo.
- Start Practice.
- Session History.
- Settings.

### 8.2 Session Setup

Fields:

- Session title.
- Language.
- Practice mode.
- Optional target duration.
- Optional script.
- Optional keywords.

CTA:

```text
Start Practice
```

### 8.3 Live Practice Screen

Main layout:

```text
┌──────────────────────────────────┐
│ PitchPerfect            01:24    │
├──────────────────────────────────┤
│ LIVE TRANSCRIPT                  │
│                                  │
│ "...today I want to introduce..."│
│                                  │
├──────────────────────────────────┤
│ 145 WPM   Fillers 2   Pauses 1   │
├──────────────────────────────────┤
│ Pitch Variation: Moderate        │
│ Volume: Stable                   │
├──────────────────────────────────┤
│ 💡 Try slowing down slightly     │
├──────────────────────────────────┤
│             STOP                 │
└──────────────────────────────────┘
```

### 8.4 Session Result

Sections:

1. Overall Score.
2. Transcript.
3. Speech Rate.
4. Filler Words.
5. Pauses.
6. Pitch Variation.
7. Volume.
8. Script / Keyword Coverage.
9. Recommendations.

---

## 9. Scoring Model

Use transparent heuristic scoring for the MVP.

Example:

```text
Overall Score =
    25% Speech Rate
  + 20% Filler Control
  + 15% Pause Control
  + 20% Pitch Variation
  + 10% Volume Stability
  + 10% Script / Keyword Coverage
```

Scores should be presented as coaching indicators rather than objective measures of public-speaking quality.

---

## 10. Flutter Technical Stack

### Framework

- Flutter
- Dart

### State Management

Recommended:

- Riverpod

Alternative:

- Bloc

### Local Storage

MVP:

- SQLite via Drift

Alternative:

- Isar

Stored entities:

- PracticeSession.
- TranscriptSegment.
- AudioMetricSample.
- FeedbackEvent.

### Audio Capture

Possible Flutter packages:

- `record`
- `flutter_sound`

The chosen package must provide PCM audio access if real-time local inference is required.

Preferred format:

```text
PCM 16-bit
Mono
16 kHz
```

### Charts

- `fl_chart`

Charts:

- WPM timeline.
- Pitch timeline.
- Voice energy timeline.

---

## 11. Speech Recognition Strategy

Architecture should isolate speech recognition behind an interface.

```dart
abstract class SpeechRecognitionEngine {
  Future<void> initialize();

  Stream<SpeechRecognitionResult> transcribe(
    Stream<AudioChunk> audioStream,
  );

  Future<void> dispose();
}
```

This enables models/implementations to be swapped without rewriting the UI.

Candidate backends may include:

- Whisper-family models.
- whisper.cpp through FFI/platform channel.
- ONNX Runtime.
- Native local speech model.
- Server backend only as temporary development fallback.

Final project preference:

```text
On-device / local inference.
```

---

## 12. Audio Analysis Engine

```dart
abstract class AudioAnalysisEngine {
  AudioFeatures analyze(AudioChunk chunk);
}
```

Example output:

```dart
class AudioFeatures {
  final double rms;
  final double? f0Hz;
  final bool voiced;
  final double timestamp;
}
```

Potential algorithms:

### Energy
RMS:

```text
sqrt(sum(x²) / N)
```

### Pitch / F0

Candidate algorithms:

- YIN.
- Autocorrelation.
- pYIN.
- Native DSP implementation.

For MVP, YIN is recommended because it is relatively straightforward and robust for voice.

---

## 13. Application Architecture

Recommended Flutter architecture:

```text
lib/
├── app/
├── core/
│   ├── audio/
│   ├── speech/
│   ├── analysis/
│   ├── database/
│   └── utils/
├── features/
│   ├── home/
│   ├── practice/
│   ├── session_setup/
│   ├── session_result/
│   ├── history/
│   └── settings/
└── shared/
```

Use feature-first clean architecture without excessive abstraction.

Each feature may contain:

```text
data/
domain/
presentation/
```

when necessary.

---

## 14. Core Data Models

### PracticeSession

```dart
class PracticeSession {
  String id;
  String title;
  DateTime startedAt;
  DateTime? endedAt;

  String language;
  PracticeMode mode;

  double? targetDurationSeconds;

  String? referenceScript;

  SessionMetrics metrics;
}
```

### TranscriptSegment

```dart
class TranscriptSegment {
  String id;
  String sessionId;

  double startSeconds;
  double endSeconds;

  String text;
  bool isFinal;
  double? confidence;
}
```

### SessionMetrics

```dart
class SessionMetrics {
  double averageWpm;
  int fillerCount;
  int pauseCount;
  int longPauseCount;

  double? averagePitchHz;
  double? pitchStdDev;

  double? averageRms;
  double? volumeVariation;

  double? scriptCoverage;

  double? overallScore;
}
```

### FeedbackEvent

```dart
class FeedbackEvent {
  String type;
  String message;
  double timestamp;
  FeedbackSeverity severity;
}
```

---

## 15. Real-Time Processing Pipeline

```text
Microphone
   ↓
AudioRecorderService
   ↓
PCM Stream
   ├──────────────→ ASR Worker
   │                   ↓
   │            Partial Transcript
   │                   ↓
   │             Transcript Store
   │
   └──────────────→ DSP Worker
                       ↓
                F0 / RMS / Silence
                       ↓
                 Metric Aggregator
                       ↓
                  Rule Engine
                       ↓
                 Coaching Event
```

Important:

Heavy DSP and inference should NOT block Flutter's UI thread.

Use:

- Dart Isolates, or
- Native threads behind FFI/platform channels.

---

## 16. Performance Requirements

Target:

- UI remains smooth during recording.
- Partial transcript latency ideally < 2 seconds.
- Metric UI updates around 2–5 times/second.
- No unbounded audio buffer.
- Memory usage remains stable for 10+ minute sessions.

Suggested audio chunks:

```text
20–100 ms for DSP
500–2000 ms context windows for ASR depending on model
```

---

## 17. Privacy

Preferred design:

```text
Microphone audio remains on-device.
```

The application should clearly state:

- When microphone recording is active.
- Whether raw audio is stored.
- Whether transcription is processed locally.

MVP recommendation:

```text
Do not permanently store raw microphone audio by default.
```

Store derived metrics and transcript instead.

---

## 18. Evaluation Plan

### Speech Recognition Evaluation

Use:

- Word Error Rate (WER).
- Character Error Rate (CER), optionally.

Test conditions:

1. Quiet environment.
2. Moderate background noise.
3. Fast speech.
4. Slow speech.
5. Indonesian.
6. English.

### Latency Evaluation

Measure:

```text
audio spoken → partial transcript displayed
```

Metrics:

- Mean latency.
- Median latency.
- P95 latency.

### Application Performance

Measure:

- CPU usage.
- Memory usage.
- Battery impact if practical.
- Dropped audio chunks.
- UI responsiveness.

### User Evaluation

Potential questionnaire:

- Was live feedback understandable?
- Was feedback useful?
- Was feedback distracting?
- Did the user feel more aware of speaking speed?
- Would they use the app before a presentation?

Use Likert scale 1–5.

---

## 19. Minimum Acceptance Criteria

The MVP is considered complete when:

- [ ] Flutter application records microphone audio.
- [ ] Real-time partial speech transcription works.
- [ ] Final transcript segments are stored.
- [ ] WPM is calculated.
- [ ] Filler words are detected.
- [ ] Pause events are detected.
- [ ] Basic F0/pitch variation is measured.
- [ ] Live feedback is shown.
- [ ] Session can be stopped safely.
- [ ] Session summary is generated.
- [ ] Previous session results can be viewed.
- [ ] ASR latency can be measured.
- [ ] WER evaluation can be performed.

---

## 20. Out of Scope for MVP

Avoid spending early development time on:

- User accounts.
- Cloud synchronization.
- Social features.
- AI-generated speeches.
- Complex LLM coaching.
- Speaker identification.
- Emotion recognition.
- Medical voice analysis.
- Singing note correctness.

These can be future improvements.

---

## 21. Future Extensions

Possible upgrades:

- LLM-generated post-session coaching.
- Presentation slide synchronization.
- Camera-based body-language analysis.
- Interview simulation.
- Personalized baseline voice model.
- Speaker confidence estimation.
- Adaptive coaching.
- Gamified challenges.
- Daily streaks.
- Speech improvement progression.

---

## 22. Project Positioning

One-line description:

> PitchPerfect is a Flutter-based real-time speech recognition and vocal delivery coach that helps users improve presentations through live transcription, speaking-rate analysis, filler detection, pause detection, and voice pitch feedback.

Academic framing:

> The project investigates how local real-time speech recognition can be combined with lightweight acoustic analysis to provide immediate and actionable presentation-practice feedback.
