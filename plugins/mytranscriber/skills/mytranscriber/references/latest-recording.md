# Finding "my latest recording"

Use this when the person asks for their latest recording, memo or meeting and
names no file. Show what you find and let them choose; never pick a default
(SKILL.md, section 3).

## 1. The library first

Recordings My Transcriber already has are in its vault. Ask the app:

```
"$CLI" tool list_recent_items hours=48
```

If the one they mean is there, its transcript is already done: read it from the
file the tool names.

## 2. Then the usual places on disk (macOS)

```bash
candidates=(
  "$HOME/Library/Group Containers/group.com.apple.VoiceMemos.shared/Recordings"
  "$HOME/Documents/Sound Recordings"
  "$HOME/Movies"
  "$HOME/Downloads"
  "$HOME/Desktop"
)
for od in "$HOME/Library/CloudStorage"/OneDrive*/Recordings; do
  [ -d "$od" ] && candidates+=("$od")
done
for d in "${candidates[@]}"; do [ -d "$d" ] && echo "$d"; done | while read -r d; do
  find "$d" -type f \( -iname '*.m4a' -o -iname '*.qta' -o -iname '*.wav' -o -iname '*.mp3' \
    -o -iname '*.mp4' -o -iname '*.mov' -o -iname '*.aac' -o -iname '*.flac' -o -iname '*.ogg' \) \
    -not -path '*/.Trash/*' -size +0 -exec stat -f '%m %N' {} + 2>/dev/null
done | sort -rn | head -5
```

Apple Voice Memos writes `.qta` as well as `.m4a`; both are recordings. Ignore
`.waveform`, `.composition` folders and `CloudRecordings.db`, which are Voice
Memos' own bookkeeping. Do not use the old
`~/Library/Application Support/com.apple.voicememos/` path.

On Windows, look in `%USERPROFILE%\Documents\Sound Recordings`, `Videos`,
`Downloads` and `Desktop`.

## Voice Memos from an iPhone arrive late

A memo recorded on an iPhone appears on the Mac only after Voice Memos itself
has been opened on the Mac since the recording. So the newest file can look
days old while newer memos exist.

- Say what you see: *"The newest I can find is from 14 Oct, 09:12. If you have
  recorded since, Voice Memos on the Mac has not fetched it yet."*
- With the person's OK, run `open -a "Voice Memos"`, wait 10 seconds and look
  again.
- A hint, not proof: `CloudRecordings.db-shm` much newer than the newest
  recording means a sync is probably pending.

My Transcriber picks a memo up by itself once it is on disk, but only while the
app is running and has Full Disk Access.
