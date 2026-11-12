---
name: listen
description: >-
  Ask the person to answer by voice, through My Transcriber
  (https://mytranscriber.app): a small recording panel opens on their computer,
  they talk for as long as they need in any language, press Done, and their
  words come back into this session, transcribed on their computer. Use when
  the person types /mytranscriber:listen, says "let me just say it", "I'll
  explain out loud" or "can I talk instead", or when an answer you need is long
  or hard to type: how they want something built, a design question, feedback
  on what you made, the background to a task. Not for yes/no questions.
---

# Listen: the person answers by voice

`listen` asks My Transcriber to open its recording panel with your question on
it. The person talks, presses **Done** (or the shortcut), and the command prints
what they said. Whisper transcribes it on their computer and the recording is
kept in their My Transcriber library; the words you read here go to the
person's AI provider, like everything else in this session.

## 1. Find the app's command

Follow `${CLAUDE_PLUGIN_ROOT}/skills/mytranscriber/references/using-the-app.md`
to find My Transcriber and its command line (`$CLI` below) and to start it. If
first run is not done, send the person to the app's window first: the panel
needs the microphone permission that first run asks for.

## 2. Ask, in the background (the default)

Run it as a **background** command, so you can go on working while they talk:

```bash
"$CLI" listen --prompt "<your question, one or two plain sentences>"
```

(Bash tool with `run_in_background: true`.) Then tell the person, in one line,
that the panel is open: talk, then press Done, or **⌥⌘↩** on a Mac,
**Ctrl+Alt+Enter** on Windows. Carry on with whatever does not depend on the
answer, and say what you are doing meanwhile. When the command finishes you are
told; read its output then.

**`/mytranscriber:listen wait`** (or when nothing can move until they answer):
run the same command in the foreground and wait. A foreground command that runs
past the Bash tool's timeout (10 minutes at most) is moved to the background or
stopped, depending on the Claude Code version, so for anything that may run
longer, start it in the background.

Options: `--language <code>` when the person always speaks one language
(default: detected per recording); `--max <minutes>` to stop by itself;
`--no-keep` when the person asks for the recording not to be kept in their
library.

## 3. Read the answer

- **Exit 0**: the first line is a header (`Voice answer, 3 min 12 s:`), then
  their words. Act on them as if they had typed them. A spoken answer wanders;
  pick out what they decided, and ask about anything that stayed unclear rather
  than guessing. A very long answer ends with *"Read all of it from <file>"*:
  read that file before acting. `Voice answer, 4 s: (nothing was heard)` means the microphone
  caught nothing: say so and offer to ask again.
- **Exit 1** (`Cancelled: …`): they cancelled, or the session stopped waiting.
  Nothing was said. Do not ask again straight away; carry on, or ask in text.
- **Exit 2**: it could not ask or transcribe, and the output says why. *"did
  not open its recording panel"* means My Transcriber is older than 0.7: the
  person updates it (its menu, *Check for updates*) and you ask again.

## When to offer it

Offer it when typing the answer would be the slow part: a long explanation, a
decision with reasons, a description of how something should look or behave,
a review of what you made. Say why in one line ("this is easier to say than to
type: shall I open the recording panel?"), unless they asked for voice already.
Ask one question per recording; two sessions asking at once each get their own
turn on the panel.
