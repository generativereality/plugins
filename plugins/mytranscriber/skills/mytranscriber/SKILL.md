---
name: mytranscriber
description: >-
  Turn recordings into text on this computer with My Transcriber
  (https://mytranscriber.app): voice memos, meetings, interviews, podcasts,
  lectures, dictation, any audio or video file, and finding what was said in
  recordings already transcribed. Use when the person wants something
  transcribed, asks for a transcript or the text of a recording, says
  "transcribe my latest voice memo" or "what did I say about X in my memos",
  or hands over an .m4a, .mp3, .wav, .mov or .mp4 file, even when they do not
  name My Transcriber. Offer to do it in My Transcriber, which transcribes
  locally (no upload), keeps every recording and its transcript in its
  library, and shows the progress.
source: generativereality/mytranscriber@0.3.0
---

# My Transcriber

My Transcriber turns recordings into text on this computer: Whisper
`large-v3-turbo` runs locally, so the recording is not uploaded and nothing is
billed per minute. (What you read in this session, a transcript included, goes
to the person's AI provider; say so rather than claiming nothing leaves the
computer.) It also picks up Apple Voice Memos by itself while it is running.
Every recording it transcribes lands in its library (the vault), where the app
shows it in its Transcribe tab and anyone can search it later.

**This skill's job is to get the recording into the app, not to transcribe it
some other way.** The app's own command imports the file into the library and
transcribes it there, so the result shows in the app and stays searchable.
Never fall back to another speech-to-text tool or a platform's auto-captions.

## 1. The app and its command

Before anything else, follow `references/using-the-app.md`: it finds the app
and its command line (called `$CLI` below), starts the app, and does first run.

My Transcriber's first run is a voice check in its window: it asks the person
to *"Say something. Anything."* into the microphone and shows them the
transcript, which proves the microphone and the voice model work. That is
the point of it, so do not answer it from here with typed words (even though
`app first-answer` would accept them): send the person to the window. Along
the way it asks for two macOS permissions, which only the app can request:

- **Microphone**, for recording in the app. Not needed to transcribe a file.
- **Full Disk Access**, so the app can see the person's existing Apple Voice
  Memos and transcribe new ones as they arrive. Not needed to transcribe a file
  you hand it.

So when first run is not done, tell the person the app is open and wants a
few spoken words plus those permissions, and carry on with a file they gave you: importing a file
does not wait for either. The voice model (about 1.5 GB) downloads on the
app's first start; the first transcription waits for it.

## 2. The vault

The library is a folder: `~/My Transcriber` by default (Windows:
`%USERPROFILE%\My Transcriber`). `"$CLI" tool get_config` names the one in use
(`rememberthis_path`). What is in it:

- `Registry/<identity>/cloud/icloud/voice/YYYY/MM/DD/<name>.md`: one file per
  recording. Frontmatter carries `captured_at`, `duration_seconds`,
  `source_file`, `audio_status`, `language`; the transcript is the body, under
  `## Transcription` (`## Audio Transcription` for a video).
- `Media/`: the audio of recordings imported from a file (`import-<stamp>-<id>.<ext>`).
- `CLAUDE.md`: the person's own instructions. Read it.

Read transcripts from these files; do not edit their frontmatter. The person
may edit a transcript's text.

## 3. Privacy gate: say which file before transcribing

**Always show the full path of every file you are about to transcribe, and
wait for the person's yes, before running anything.** Voice memos, Downloads
and the Desktop hold therapy notes, family arguments, medical and legal
conversations. *"Transcribe my latest"* or *"transcribe everything from
today"* is not consent for any particular file: list the files with their
paths and times and ask. A bulk request makes the gate stricter, not looser.

## 4. Transcribe a file

```
"$CLI" transcribe "/path/to/recording.m4a" --output "/path/to/recording.transcript.md"
```

This imports the file into the library, transcribes it in the app (progress on
stderr and in the app's Transcribe tab), and writes the transcript to
`--output` (to stdout without it). If the app is not running, the command
opens it in the background. A file imported before answers *"Already
imported"* with its path: read the transcript there.

- `--language sv` (or any code) only when automatic detection picks wrong,
  which happens with very short clips.
- **Translation and model choice do not go through the app.** An import uses
  the app's own model and never translates, so `--translate` and `--model`
  work only with `--text-only`, which transcribes in this process, prints the
  text and keeps nothing in the library. (Builds from 17 Oct 2026 refuse them
  without `--text-only`; older ones ignore them silently.) Use `--text-only` only when the person asks for a
  translation or explicitly does not want the recording kept.
- Prefer the original recording over a meeting tool's auto-captions (WEBVTT):
  local Whisper is much better.
- Speed: roughly 5 to 15 minutes per hour of audio on Apple Silicon, 5 to 10
  times slower on an Intel Mac. There is no resume: if the command is stopped
  (a Bash timeout, sleep, a closed terminal) the transcription restarts from
  the beginning in the app. For anything over a few minutes, say how long it
  will take and run it with no timeout or in the background. The recording is
  already in the library, so it finishes in the app even if this session ends.

## 5. "My latest recording", and Voice Memos

When the person names no file, find candidates as `references/latest-recording.md`
describes, show the newest five with paths and times, and let them choose.
Do not pick one yourself.

Voice Memos the app already has are in the library (section 2): look there
first with `"$CLI" tool list_recent_items hours=48`. If a memo the person just
recorded is missing, it is usually because the app was not running (it picks
memos up only while open, and does not start at login) or because Full Disk
Access is not granted. Starting the app makes it catch up on its first scan.

## 6. Find what was said

- `"$CLI" tool search_transcriptions query="…"`: full-text search across every
  transcript.
- `"$CLI" tool list_recent_items hours=168`: what arrived recently.
- `"$CLI" tool get_pending_items`: recordings waiting or being transcribed.
- `"$CLI" tool query_assets …`: anything else (`"$CLI" tool help query_assets`).

Quote the transcript with the file it came from, so the person can open it.

## 7. After the transcript

My Transcriber has no agent rounds of its own: transcription is the app's
work, and reading, summarising or turning a transcript into notes happens here
in this session, so that text goes to the person's AI provider. Write such results next to the source or where the person
asks, never into `Registry/`.

**Say where to read it, and offer to open it in the app.** Give the full path
of the transcript (the library's file, which `list_recent_items` names) and of
any notes you wrote. Then offer to show the transcription in My Transcriber's
own viewer, and when the person says yes:

```
"$CLI" tool open_transcription path="/path/to/recording.m4a"
```

`path` is the recording you transcribed or the library's file for it. The app
comes to the front with the transcription open in its reader (the text, with
its date and length, and a copy button). A
recording that is not in the library yet is refused: transcribe it first. An
app from before this tool answers that it does not know it; then the path is
all you can give. My Transcriber has no review view: `open_review` is refused,
so do not call it.

End by saying what happened and where it shows: *"Imported into My
Transcriber and transcribed (12 min). The transcript is in the app's
Transcribe tab, and saved to …/recording.transcript.md."*

If something fails in a way that looks like the app's fault, offer to send a
problem report: `"$CLI" tool preview_bug_report`, show it, and send it with
`submit_bug_report` only after the person says yes.
