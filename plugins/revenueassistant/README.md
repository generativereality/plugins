# The Revenue Assistant

A companion skill that hands the customer, deal and pipeline work you raise in Claude Code to The
Revenue Assistant, the app and service that works your sales pipeline in your own systems.

## What this plugin does

It adds one skill to Claude Code. When you talk about your customers, deals or pipeline (*"who has
gone quiet?"*, *"update the CRM after my call"*), even without naming the app, Claude asks whether to do the work in The Revenue Assistant. If you say
yes, it hands the app your request with what the conversation already knows, and carries the app's
questions and your answers back and forth while the work runs. If you say no, Claude carries on in the
conversation as usual.

To do this, Claude runs the app's own command line on your computer: to check that the app is
installed and running, to start it if it is not running, to hand over the request, and to pass the
app's questions and your answers. If the app is not installed, or cannot be reached (as in chat on
claude.ai or in Cowork), Claude points you to https://therevenueassistant.com/download; the plugin
installs nothing itself.

## You need

- The Revenue Assistant, for Mac or Windows: https://therevenueassistant.com
- Claude Code

## Install

```
/plugin marketplace add generativereality/plugins
/plugin install revenueassistant@generativereality
```

## Privacy

The plugin itself contacts no server: it passes your request to the app as small files in the
app's folder on your computer. How the app handles your data:
https://therevenueassistant.com/legal/privacy-policy

Made by Augmented Mind AB, Helsinki, and published in the generativereality plugin marketplace.
This plugin's files are under the MIT licence.
