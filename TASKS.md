# PitchPerfect — Implementation Task List

## Milestone 0 — Project Setup

- [ ] Create Flutter project.
- [ ] Configure Android microphone permission.
- [ ] Configure iOS microphone permission if required.
- [ ] Add Riverpod.
- [ ] Add Drift/SQLite.
- [ ] Add audio recording package.
- [ ] Add routing.
- [ ] Add linting.
- [ ] Add unit-test setup.

Definition of done:

```text
App launches and navigates Home → Session Setup → Practice.
```

---

## Milestone 1 — Microphone Pipeline

- [ ] Request microphone permission.
- [ ] Start PCM recording.
- [ ] Expose audio as a Dart stream.
- [ ] Convert samples to normalized mono representation.
- [ ] Display microphone active state.
- [ ] Implement clean stop/dispose.

Definition of done:

```text
Live PCM chunks are received continuously without UI freezing.
```

---

## Milestone 2 — Mock Real-Time ASR

Before native model integration:

- [ ] Create `SpeechRecognitionEngine`.
- [ ] Implement `MockSpeechRecognitionEngine`.
- [ ] Emit partial results.
- [ ] Emit final results.
- [ ] Build transcript UI.
- [ ] Correctly replace partial text.

Definition of done:

```text
Practice UI behaves exactly like real streaming transcription even before the model exists.
```

---

## Milestone 3 — Speech Metrics

- [ ] Transcript tokenizer.
- [ ] Rolling WPM calculation.
- [ ] Session average WPM.
- [ ] English filler dictionary.
- [ ] Indonesian filler dictionary.
- [ ] Filler counter.
- [ ] Live metrics cards.

Definition of done:

```text
Mock transcript updates WPM and filler counters in real time.
```

---

## Milestone 4 — Audio DSP

- [ ] RMS calculation.
- [ ] Silence detection.
- [ ] Pause state machine.
- [ ] Long-pause event.
- [ ] F0 interface.
- [ ] YIN pitch detector.
- [ ] Voiced/unvoiced detection.
- [ ] Pitch rolling statistics.

Definition of done:

```text
Speaking produces changing RMS/F0 metrics and silence produces pause events.
```

---

## Milestone 5 — Feedback Engine

- [ ] Create feedback rule interface.
- [ ] Fast-speech rule.
- [ ] Slow-speech rule.
- [ ] Long-pause rule.
- [ ] Low-volume rule.
- [ ] Monotone-delivery rule.
- [ ] Filler-burst rule.
- [ ] Add cooldown.
- [ ] Add feedback priority.

Definition of done:

```text
Only one useful coaching tip is shown at a time without rapidly flashing warnings.
```

---

## Milestone 6 — Local ASR

Recommended target:

```text
whisper.cpp or equivalent local inference runtime
```

Tasks:

- [ ] Benchmark candidate model sizes.
- [ ] Select model.
- [ ] Add native build integration.
- [ ] Create Dart ↔ native bridge.
- [ ] Implement ASR worker.
- [ ] Feed audio windows.
- [ ] Return partial/final transcript.
- [ ] Add timestamps.
- [ ] Add model loading state.
- [ ] Add error state.

Definition of done:

```text
User speaks into microphone and sees local partial transcription in Flutter.
```

---

## Milestone 7 — Session Persistence

- [ ] Sessions table.
- [ ] Transcript table.
- [ ] Feedback table.
- [ ] Metric snapshots table.
- [ ] Save completed session.
- [ ] History screen.
- [ ] Session-detail screen.
- [ ] Delete session.

Definition of done:

```text
A completed practice can be reopened after restarting the application.
```

---

## Milestone 8 — Session Summary

- [ ] Duration.
- [ ] Average WPM.
- [ ] WPM chart.
- [ ] Filler summary.
- [ ] Pause summary.
- [ ] Pitch variation chart.
- [ ] Voice energy chart.
- [ ] Overall score.
- [ ] Recommendations.

Definition of done:

```text
Stopping a practice session immediately opens a useful performance report.
```

---

## Milestone 9 — Script Mode

- [ ] Script input.
- [ ] Script normalization.
- [ ] Coverage calculation.
- [ ] Missing keyword detection.
- [ ] Display coverage score.
- [ ] Highlight covered sections if feasible.

Definition of done:

```text
User can practice against a prepared script and receive approximate coverage feedback.
```

---

## Milestone 10 — Benchmark & Final Project Evaluation

### Dataset

Prepare a small controlled test set.

Include:

- [ ] Indonesian speech.
- [ ] English speech.
- [ ] Quiet samples.
- [ ] Noisy samples.
- [ ] Fast speech.
- [ ] Slow speech.

### ASR Accuracy

- [ ] Ground-truth transcripts.
- [ ] WER calculation.
- [ ] CER calculation if useful.
- [ ] Accuracy table.

### Latency

- [ ] Measure end-of-audio → partial transcript.
- [ ] Mean latency.
- [ ] Median latency.
- [ ] P95 latency.

### App Performance

- [ ] Memory profile.
- [ ] CPU profile.
- [ ] Long-session stability.

### User Evaluation

- [ ] Questionnaire.
- [ ] Recruit test users.
- [ ] Record Likert responses.
- [ ] Summarize results.
- [ ] Capture qualitative feedback.

---

# Suggested Sprint Plan

## Sprint 1

Goal:

```text
Functional Flutter recording prototype.
```

Tasks:

- Project setup.
- Navigation.
- Session screen.
- Microphone stream.
- Mock ASR.

## Sprint 2

Goal:

```text
Real-time coaching metrics.
```

Tasks:

- WPM.
- Fillers.
- RMS.
- Silence.
- Pitch.
- Feedback rules.

## Sprint 3

Goal:

```text
Real local ASR.
```

Tasks:

- Native model integration.
- Streaming inference.
- Latency optimization.

## Sprint 4

Goal:

```text
Complete polished application.
```

Tasks:

- Database.
- Summary.
- History.
- Script mode.
- Error states.

## Sprint 5

Goal:

```text
Academic evaluation and final presentation.
```

Tasks:

- WER.
- Latency benchmark.
- User study.
- Charts.
- Documentation.
- Demo preparation.

---

# Priority Levels

## P0 — Required

- Real-time microphone audio.
- Local real-time ASR.
- Partial transcript.
- WPM.
- Filler words.
- Pause detection.
- Session summary.

## P1 — Strongly Recommended

- Pitch variation.
- RMS/volume analysis.
- Session history.
- Feedback engine.
- Benchmark instrumentation.

## P2 — Nice to Have

- Script coverage.
- Keyword coverage.
- Gamification.
- LLM feedback.
- Presentation slide integration.

---

# Agent Coding Rules

When using Codex / Claude Code / another coding agent:

1. Do not replace working architecture without explicit reason.
2. Keep business logic independent of Flutter widgets.
3. Do not run ASR inference on the main Dart UI isolate.
4. Every service should have an interface where swapping implementation is likely.
5. Add tests for metric calculations.
6. Avoid unnecessary packages.
7. Do not introduce cloud dependencies for core functionality.
8. Never store raw microphone audio by default.
9. Every recording resource must be disposed on session stop.
10. Prefer small incremental commits.
11. Maintain Android support as the primary target.
12. Avoid fake confidence or pitch-quality claims.
13. Keep scoring heuristic transparent.
14. Include timestamps in transcript data.
15. Preserve benchmark instrumentation.

---

# Initial Agent Prompt

Use the following prompt to bootstrap implementation:

```text
Build PitchPerfect, a Flutter-based local-first real-time speech recognition
and public-speaking coaching application.

Read SPEC.md and ARCHITECTURE.md before modifying the project.

Start with Milestone 0–2 only.

Requirements:
- Flutter + Dart
- Riverpod for state management
- feature-first structure
- microphone streaming abstraction
- SpeechRecognitionEngine interface
- MockSpeechRecognitionEngine initially
- live practice screen with partial transcript
- clean start/stop session lifecycle
- unit-testable business logic
- no cloud dependency
- do not implement native ASR yet
- do not run expensive work on the Flutter UI isolate

After implementation:
1. run analyzer,
2. run tests,
3. list changed files,
4. describe remaining blockers for the next milestone.
```
