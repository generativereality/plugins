# Clerk.AI (https://clerkai.eu)

A companion skill that hands the accounting prep you raise in Claude Code to Clerk.AI, the app
that gathers each period's bank statements and receipts and drafts the email to your accountant.

## What this plugin does

It adds one skill to Claude Code. When you talk about your company's accounting prep (*"close
September"*, *"which receipts are still missing?"*, *"what do I send my accountant?"*), even
without naming the app, Claude hands the app your request with what the conversation already
knows, such as where your documents live or the accountant's deadline. The app does the work in
its own session, where you can see and continue it, and Claude carries the app's questions and
your answers back and forth while it runs.

To do this, Claude runs the app's own command line on your computer: to check that the app is
installed and running, to start it if it is not running, to hand over the request, and to pass the
app's questions and your answers. If the app is not installed, or cannot be reached (as in chat on
claude.ai or in Cowork), Claude points you to https://clerkai.eu; the plugin installs
nothing itself.

## You need

- Clerk.AI, for Mac or Windows: https://clerkai.eu
- Claude Code

## Install

```
/plugin marketplace add generativereality/plugins
/plugin install clerkai@generativereality
```

## Privacy

The plugin itself contacts no server: it passes your request to the app as small files in the
app's folder on your computer. How the app handles your data:
https://clerkai.eu/legal/privacy-policy

Made by Augmented Mind AB, Helsinki, and published in the generativereality plugin marketplace.
This plugin's files are under the MIT licence.

## Trade mark

CLERK.AI is a registered trade mark of Augmented Mind AB in the European Union (EUTM 017646613)
and the United Kingdom (UK00917646613). The MIT licence covers this plugin's files, not the name.
This plugin is not affiliated with other companies or products that use the word "Clerk".
