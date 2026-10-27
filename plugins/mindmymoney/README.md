# Mind My Money

A companion skill that hands the money questions you raise in Claude Code to Mind My Money, the
app that goes through your bank statements on your own computer and shows where the money went.

## What this plugin does

It adds one skill to Claude Code. When you ask about your own money (*"where did our money go in
September?"*, *"what was this PayPal payment?"*, *"which subscriptions should I cancel?"*, *"which
bills are due?"*), Claude hands the request to the Mind My Money app in your own words, and passes
the app's questions and your answers back and forth while the work runs. A quick question about a
report the app has already written, Claude answers from the files on your computer.

The bank work, cancellations and payments happen in the app, not in the conversation. You sign in
to your bank yourself, in the browser window the app shows, and nothing is cancelled or paid without
your answer about that one action.

To do this, Claude runs the app's own command line on your computer: to check that the app is
installed and running, to start it if it is not running, to hand over the request, and to pass the
app's questions and your answers. If the app is not installed, Claude points you to
https://mindmy.money; the plugin installs nothing itself.

## You need

- Mind My Money: https://mindmy.money
- Claude Code

## Install

```
/plugin marketplace add generativereality/plugins
/plugin install mindmymoney@generativereality
```

## Privacy

The plugin itself contacts no server: it passes your request to the app on your computer. What
the app reads goes to the AI provider you signed in to (Anthropic, or OpenAI through Codex), under
its terms. Nothing about your money reaches us: the app contacts Augmented Mind only to check for
updates (with a random install number), to open one page on our site during setup to check it can
drive your browser, to sign you in if you choose to, to fetch the public list of money coaches, and
to send a problem report or a few words you choose to send, which you read before they go.
https://mindmy.money/legal/privacy-policy

Made by Augmented Mind AB, Helsinki, and published in the generativereality plugin marketplace.
This plugin's files are under the MIT licence.
