# My Transcriber

A skill that turns recordings into text with My Transcriber, the app that transcribes on your own
computer and keeps every recording and its transcript in a searchable library.

## What this plugin does

It adds one skill to Claude Code. When you want something transcribed (*"transcribe this
interview"*, *"what did I say about the budget in my memos?"*), or hand over an audio or video file,
even without naming the app, Claude offers to do it in My Transcriber. Before anything is
transcribed, Claude shows you the full path of each file and waits for your yes.

To do this, Claude runs the app's own command line on your computer: to check that the app is
installed and running and start it if it is not, to import a file and transcribe it in the app, to
list and search the transcripts already in the library, and to open a transcript in the app. On a
Mac, the app also picks up Apple Voice Memos by itself while it is running. If the app is not
installed, Claude points you to https://mytranscriber.app; the plugin installs nothing itself.

## You need

- My Transcriber, for Mac or Windows: https://mytranscriber.app
- Claude Code

## Install

```
/plugin marketplace add generativereality/plugins
/plugin install mytranscriber@generativereality
```

## Privacy

The recording is transcribed on your computer and is not uploaded. What Claude reads in the
session, a transcript included, goes to your AI provider. How the app handles your data:
https://mytranscriber.app/legal/privacy-policy

Made by Augmented Mind AB, Helsinki, and published in the generativereality plugin marketplace.
This plugin's files are under the MIT licence.
