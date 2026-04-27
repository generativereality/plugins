---
name: transcribe
description: Transcribe audio or video files locally with My Transcriber (Whisper large-v3-turbo, on-device, no cloud). Use this when the user asks to transcribe a recording, voice memo, meeting, podcast, or any audio/video file — including "transcribe my latest recording" with no specific path. Requires the My Transcriber app installed from https://mytranscriber.app.
---

# Transcribe (My Transcriber)

Transcribe audio or video files locally using the My Transcriber CLI. Runs Whisper `large-v3-turbo` on-device — no upload, no cloud, no per-minute fees.

## Prerequisite: locate the daemon

The CLI ships inside the My Transcriber app bundle. Detect it in this order:

1. `/Applications/My Transcriber.app/Contents/MacOS/mytranscriber-daemon` ← preferred
2. `/Applications/Remember This.app/Contents/MacOS/rememberthis-daemon` ← same daemon, different brand
3. `~/Applications/My Transcriber.app/Contents/MacOS/mytranscriber-daemon` ← user-scoped install

```bash
for p in \
  "/Applications/My Transcriber.app/Contents/MacOS/mytranscriber-daemon" \
  "$HOME/Applications/My Transcriber.app/Contents/MacOS/mytranscriber-daemon" \
  "/Applications/Remember This.app/Contents/MacOS/rememberthis-daemon"; do
  [ -x "$p" ] && DAEMON="$p" && break
done
echo "${DAEMON:-NOT_FOUND}"
```

If none are found, stop and tell the user:

> My Transcriber isn't installed. Download it from https://mytranscriber.app and re-run.

Do not attempt to install it automatically. The user installs the app, then re-asks.

## Quality policy

**Prefer the original recording over any auto-generated transcript.** Teams/Zoom/Meet auto-captions (WEBVTT) are noticeably worse than local Whisper: garbled words, attribution drift, dropped phrases. If the user has the source `.mp4`/`.m4a`/`.mp3`, transcribe that — don't fall back to platform captions unless the recording is genuinely unavailable.

## CLI surface

```
mytranscriber-daemon transcribe <FILE> [OPTIONS]

  -o, --output <FILE>        Output file (default: stdout)
  -l, --language <CODE>      Language code: en, sv, auto, etc. [default: auto]
  -t, --translate            Translate to English
  -m, --model <MODEL>        tiny | base | small | medium | large-v3 | large-v3-turbo
                             [default: large-v3-turbo]
```

Supports M4A, WAV, MP3, MOV, MP4, and other ffmpeg-readable formats.

Speed: roughly **5–15 minutes per hour of audio** on Apple Silicon at `large-v3-turbo`. The default model is the best quality/speed balance — only drop to `medium`/`small` if the user explicitly wants faster turnaround at lower accuracy.

## Outcome A: transcribe a given file

The user gives you a path. Default to writing the transcript next to the source as `<basename>.transcript.md`.

```bash
"$DAEMON" transcribe "/path/to/recording.m4a" \
  --output "/path/to/recording.transcript.md"
```

After the command completes, show the user the output path and the first ~10 lines of the transcript.

For meeting/batch contexts, prefer the `.meeting-transcripts/YYYY-MM-DD-<slug>.md` convention (gitignore-friendly working dir).

## Outcome B: transcribe the user's latest recording

When the user says "transcribe my latest voice memo" or "transcribe the meeting I just recorded" with no path, scan a small set of common locations by modification time, pick the newest audio/video file, **confirm the path with the user**, then transcribe.

Candidate locations (check those that exist, skip those that don't):

```bash
candidates=(
  "$HOME/Library/Group Containers/group.com.apple.VoiceMemos.shared/Recordings"
  "$HOME/Documents/Sound Recordings"
  "$HOME/Movies"
  "$HOME/Downloads"
  "$HOME/Desktop"
)
# Add OneDrive Recordings folders if present
for od in "$HOME/Library/CloudStorage"/OneDrive*/Recordings; do
  [ -d "$od" ] && candidates+=("$od")
done
```

Find the newest audio/video file across these:

```bash
find "${candidates[@]}" -type f \
  \( -iname '*.m4a' -o -iname '*.wav' -o -iname '*.mp3' \
     -o -iname '*.mp4' -o -iname '*.mov' -o -iname '*.aac' \
     -o -iname '*.flac' -o -iname '*.ogg' \) \
  -not -path '*/.Trash/*' \
  2>/dev/null \
  | xargs -I{} stat -f '%m %N' {} \
  | sort -rn | head -5
```

Show the top 5 to the user, ask which one (or default to the most recent), then transcribe.

**Do not silently transcribe** — Voice Memos and Downloads can contain personal recordings the user didn't intend to process.

## Language and translation

- Default `--language auto` works well for most cases.
- Force a specific language only when auto-detect picks wrong (common with very short clips or heavy accents): `--language en`, `--language sv`, etc.
- For non-English source that the user wants in English, add `--translate` (single-pass — faster than transcribing then translating).

## Output format

The CLI writes plain text by default — paragraphs, no timestamps, no speaker labels (the daemon doesn't emit diarization). For Markdown structure, the user or follow-up step can post-process; don't attempt to inject timestamps from this skill.

If the user wants a Markdown transcript with sections, do the transcription first, then offer to format the output.

## Common pitfalls

- **Wrong binary name.** It's `mytranscriber-daemon` (or `rememberthis-daemon`). Older docs and PATH installations may reference `transcriber` — that's stale.
- **Spaces in the app path.** Always quote: `"/Applications/My Transcriber.app/Contents/MacOS/mytranscriber-daemon"`.
- **Long files.** A 2-hour recording can take 10–30 minutes. Run in a backgrounded shell or warn the user before starting.
- **Sandboxed Voice Memos.** The shared group container path above is read-accessible; don't try to use the older `~/Library/Application Support/com.apple.voicememos/` path (sandboxed away on recent macOS).

## Notes

- 100% local. No file leaves the machine.
- The same daemon ships in two app brands — My Transcriber and Remember This. Detection logic above handles both.
- Apple Silicon required for usable speed. Intel Macs work but are 5–10× slower.
