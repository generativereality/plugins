# Remember This

Your life told back to you, from the photos, voice memos and notes already on your Mac. The
Remember This app keeps the story of your life and of the people you love; this companion skill lets
Claude Code work with it when you have the app installed.

## What this plugin does

It adds one skill to Claude Code. Ask for a part of your life told back to you, even without naming
the app, and Claude offers to hand it to the app, which writes it in one of its own sessions:

- *"What happened in my life last month?"*
- *"Write the chapter about our years in Berlin."*
- *"What were the kids up to the summer we moved?"*

Ask who was in your life at a given time, or where and when something happened, and Claude answers
in the conversation from the app's index, without changing anything:

- *"Who mattered most to me in 2019?"*
- *"When was I in Lisbon?"*

To do this, Claude runs the app's own command line on your computer. It uses it to:

- check that the app is installed, and start it when the work needs it
- pass on your answer to the app's opening question on first run
- look things up in the app's index
- hand over your requests, and your answers to the app's questions
- show Claude a photo a question needs, or open it in Apple Photos for you
- save a small correction or a note about a person or place that you state outright
- open a page the app wrote, such as a month or a Life Book chapter, in the app for you to read

Beyond first run, it does no work until you have answered the app's consent question. If you hit a
problem with the app, Claude can have the app send the Remember This team a bug report (what you
wrote, computer and app details, recent log lines), only after you have read it and said yes. If the
app is not installed, Claude points you to https://rememberthis.ai; the plugin installs nothing
itself.

## You need

- A Mac with the Remember This app: https://rememberthis.ai
- Claude Code

## Install

```
/plugin marketplace add generativereality/plugins
/plugin install rememberthis@generativereality
```

## Privacy

Claude reads the app's index and hands requests to the app as small files in your Remember This
folder; the plugin contacts no server of its own. The app sends us a bug report only when you have
read it and said yes. What Claude reads to answer you goes to your AI provider, as in any Claude Code
conversation. How the app handles your data: https://rememberthis.ai/legal/privacy-policy

Made by Augmented Mind AB, Helsinki, and published in the generativereality plugin marketplace.
This plugin's files are under the MIT licence.
