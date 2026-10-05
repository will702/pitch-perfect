# PitchPerfect — Evaluation Protocol (Milestone 10)

The app and tools are built; recording the dataset and running the user study are manual steps.

## 1. ASR accuracy (WER / CER)

**Dataset** — 5–10 utterances (15–40 s) per condition, each with a ground-truth transcript:

| Condition | Language |
|---|---|
| Quiet | EN, ID |
| Moderate background noise | EN, ID |
| Fast speech (> 180 WPM) | EN, ID |
| Slow speech (< 100 WPM) | EN, ID |

**Procedure**
1. Practice session (Whisper on in Settings) while reading/playing each utterance.
2. From the result screen, copy the transcript into `hyp_<condition>.txt`, one utterance per line.
3. Write the matching ground truth to `ref_<condition>.txt`, same line order.
4. `dart run tool/wer.dart ref_quiet_en.txt hyp_quiet_en.txt` → per-line and corpus WER/CER.
5. Put corpus WER per condition in an accuracy table.

Text is lowercased and punctuation-stripped before comparison (`lib/core/benchmark/wer.dart`).

## 2. Latency

After a session, the result screen has **Export latency benchmark (JSON)**. It writes
`benchmark_<id>.json` to the app documents directory (pull with `adb` / device file explorer).

Each sample holds `audio_timestamp`, `inference_started_at`, `result_received_at`, `rendered_at`:

- **inference** = result_received_at − inference_started_at
- **end-to-end** = rendered_at − (wall time the audio was spoken)

```
dart run tool/latency_stats.dart benchmark_*.json
```

Prints mean / median / P95. Target: partial transcript < 2 s.
Only measure with the real engine (the mock emits instantly).

## 3. App performance

- 10+ minute session with Android Studio Profiler (or `flutter run --profile` + DevTools).
- Record CPU %, memory at 1/5/10 min (should be flat — buffers are bounded), dropped frames.
- Optional: battery % before/after.

## 4. User study

Recruit 5–10 users. Each does one 2–3 min practice, then rates (Likert 1–5, 1 = strongly disagree):

1. The live feedback was understandable.
2. The live feedback was useful.
3. The live feedback was distracting.
4. I became more aware of my speaking speed.
5. I would use this app before a real presentation.

Open questions: What was most helpful? What was annoying? What is missing?

Tabulate mean and standard deviation per question; summarize open answers by theme.
