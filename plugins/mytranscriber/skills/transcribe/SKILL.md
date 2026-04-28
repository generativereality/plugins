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

## Privacy gate (read before transcribing anything)

**Always echo the resolved file path(s) and wait for explicit user ack before invoking the daemon.** This applies to every invocation — single file, batch, "transcribe everything", "do my latest", anything. No exceptions for "obvious" cases.

**Why:** Voice Memos, Downloads, and Desktop commonly contain therapy notes, family arguments, medical or legal conversations the user did not intend to feed to an LLM. A user saying *"transcribe my latest"* or *"transcribe everything from today"* is **not** consent for any specific file — they may not remember what's currently in the queue. Burning that trust once is one time too many.

**Anti-pattern (do not do this):**

> User: *"transcribe everything from this morning"*
> Agent: *runs find, picks 5 files, transcribes all 5 without echoing paths first* ❌

**Correct pattern:**

> User: *"transcribe everything from this morning"*
> Agent: *lists the 5 files with full paths and mtimes, asks "transcribe all of these?"*
> User: *"yes"* ✅

If a request is bulk-flavored ("everything", "all of them", "the latest batch"), the gate gets **stronger**, not weaker — show every file path and require an explicit yes. Do not partition the list and proceed on the "obvious" subset.

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

Show the top 5 to the user with full paths and mtimes. Ask which one(s) to transcribe. **Do not pick a default** — even if the top result is obviously today's recording, echo it and wait for ack. See "Privacy gate" above; that rule overrides any apparent shortcut here.

### Voice Memos iCloud sync gotcha (macOS)

Voice memos recorded on an iPhone with iCloud sync **do not appear in the macOS shared container until the user has launched the Voice Memos.app on the Mac at least once after the recording**. The folder list above will look frozen at the date Voice Memos.app was last opened — even though Apple's `CloudRecordings.db*` next to the recordings has updated metadata.

If the user expects more recent recordings than the scan returns:

1. **Warn before defaulting to the newest file.** Mention explicitly: *"newest I can see is YYYY-MM-DD HH:MM — if you've recorded since, open Voice Memos.app on the Mac to trigger sync."*
2. **Soft sync trigger.** With user OK, run `open -a "Voice Memos"` and re-scan after 5–10 seconds; new .m4a files often appear quickly.
3. **Detection heuristic** (imperfect but useful): if `~/Library/Group Containers/group.com.apple.VoiceMemos.shared/Recordings/CloudRecordings.db-shm` mtime is significantly newer than the newest `.m4a` mtime, sync may be pending.

This silently breaks "transcribe my latest voice memo" workflows when the user records on iPhone but works in Wave/terminal on Mac (Voice Memos.app not in their normal flow). Always disclose what you actually see before transcribing.

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
- **Long files have no resume.** A 2-hour recording can take 10–30 minutes. If the daemon is killed mid-stream (Bash timeout, terminal close, system sleep), the partial output is lost — you restart from segment 0. For files >5 minutes, tell the user the expected duration up front and either run with no Bash timeout or background the job in a separate cctabs tab. Tracked upstream as RT Issue #56.
- **Sandboxed Voice Memos.** The shared group container path above is read-accessible; don't try to use the older `~/Library/Application Support/com.apple.voicememos/` path (sandboxed away on recent macOS).

## Notes

- 100% local. No file leaves the machine.
- The same daemon ships in two app brands — My Transcriber and Remember This. Detection logic above handles both.
- Apple Silicon required for usable speed. Intel Macs work but are 5–10× slower.
