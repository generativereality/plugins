# Exercise log

A skill that keeps a training log from what you say you did.

## What this plugin does

It adds one skill to Claude Code. After a workout, tell Claude what you did in your own words
(*"pull-ups, 6 then 5 then 4, held an L-sit maybe 8 seconds, felt strong"*). Claude writes it down as
a plain Markdown file for that day, keeps your words beside its table, and reads it back to you.

Then ask about it: how often you trained this month, what has moved, what you have not done in a while.

If you follow a program that publishes its levels and tests, Claude reads the program's own file and
tells you where you are and which test comes next. [Calisthenics Tree](https://calitree.app) is the
worked example: its file for AI assistants is https://calitree.app/llms.txt.

The log lives in `~/exercise-log/`, one file per day, unless your project's instructions name another
folder.

## What it does not do

It logs, counts and compares, and repeats a program's own tests and form notes. It never gives health,
medical, injury, diet or weight advice. If you mention pain or an injury, it is logged in your words,
and harder moves for that part of the body are left to you and your doctor or physiotherapist.

## Install

```
/plugin marketplace add generativereality/plugins
/plugin install exercise-log@generativereality
```
