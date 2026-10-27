---
name: rememberthis
description: The story of your life and of the people you love, kept from the photos, voice memos and notes already on your computer, with Remember This (https://rememberthis.ai). Use this when the person wants a part of their life told back to them — "what happened in my life last month", "who mattered most to me in 2019", "write the chapter about our years in Berlin", "what were the kids up to the summer we moved" — a month of their life, the people in a year or period of it, a chapter of their life story (the Life Book); also when they look something up in their past ("when was I in Lisbon", "the voice memo about the house"), or ask about the Remember This app itself. Offer to do the work in Remember This even when they don't name it. Not for transcribing a single file (that is My Transcriber's skill) or for bookkeeping receipts (Clerk.AI's).
source: generativereality/rememberthis@0.14.0
---

# Remember This

Remember This keeps the story of a person's life and of the people they love. It reads their photo
library, Apple Voice Memos and notes on their own computer, writes each item down as markdown (captions,
transcripts, the text in photos, where and with whom), and keeps it in one folder, the **vault**. Its
sessions turn that into the story: a picture of each week and month, the people who mattered in each
period of their life (their children's too), and a draft of their life story (the Life Book), one
chapter at a time, asking back what only the person can answer.

**Using the app has to be the better experience.** So questions about their past are looked up here,
and any job that writes to the vault runs in one of the app's own sessions, where the person can
watch it, answer its questions and carry on from the app or their phone.

## 1. The app

Before anything else, follow `references/using-the-app.md`: it finds the app and its command line
(called `$CLI` below), starts the app, and does first run.

**Not installed:** say what Remember This would do for this request, link https://rememberthis.ai,
and stop. Never install it yourself.

**First run.** When `using-the-app.md` has you ask Remember This's first question (*"Tell me a bit about
yourself."*), know what it is for: it wants a person, not a list: who they live with, where they have lived, which years or people they most want to be
able to find again (the app's example: *"Two kids, moved to Helsinki in 2019, and I've got twenty
years of photos I've never once looked back through."*). Help from what they have told you in this
conversation and let them change it. Never invent facts about their life, and never read their
photos or recordings to answer it for them. After it, the app asks macOS for Photos, the microphone
and Full Disk Access (for Voice Memos); only the person can grant those, in the app.

The commands are in `references/commands.md`; `"$CLI" tool help <name>` prints one tool's arguments.
Run them from the vault folder. If `references/life-domains.md` exists, it lists the areas of life the
person set up in the app (family, health, work …); use their names for those areas in your answers and
in the notes you hand to the app.

## 2. Their story, and looking things up

A part of their life told back (a month, a year, a chapter) is written by the app's sessions (§3).
What can be read from the index is answered here, read-only:

| They ask | Use |
|---|---|
| who mattered in a year or a period, who was around the kids | `query_assets` over that span's photos and their `people`, then `get_entity` for each person (`relationship_to_user` says who is family) |
| a person | `search_by_person`, `list_people_entities`, `get_entity` |
| a word, a topic, "the voice memo about…" | `search_captions` (captions, transcripts and photo text together), `search_transcriptions`, `search_ocr` |
| a place or a trip | `search_by_location`, `list_places_entities` |
| a date range, counts, anything else | `query_assets` (one read-only SQL `SELECT` on `registry_items`; `"$CLI" tool help query_assets` lists the columns) |
| "what's new", "what is it still working on" | `list_recent_items`, `get_pending_items`, `get_stats` |
| a photo they want to see | `reveal_in_photos` opens it in Photos for them; `attach_photo` puts it in front of you |

Answer with dates and places, and say how sure you are: a caption is a model's guess, a face name
comes from Apple Photos, a place from the photo's GPS. Point at the file the answer came from.

**Their life is in here.** Open only the photos and recordings the question needs, say which ones
you are looking at, and never copy their content into anything that leaves this computer (an
email, a post, a public repo, a web form) unless they ask for exactly that.

## 3. Hand everything else to the app

Anything that writes to the vault (a month or a week of their life written up, a chapter of their
life story, notes and follow-ups from their voice memos, naming the people or groups in their photos)
runs in a Remember This session. Write `{"cadence": "<cadence>", "note": "<their request, in their words>"}`
to `.tmp/args-<session>.json` in the vault with the Write tool and run
`"$CLI" tool trigger_dreamer '@.tmp/args-<session>.json'`. If a session is already running, the note goes into it.

| The job | Cadence |
|---|---|
| the past month / the past week of their life | `monthly` / `weekly` |
| their life story, or one chapter of it (a period: the student years, the years in Berlin) | `biography` |
| the last day or two, follow-ups from their recordings, anything else they ask for | `narrative` |
| patterns and loose ends across the years | `detective` |

Give the session their words, not your summary of them. If the conversation names where they keep
other material (a folder of old letters, a shared family album, a journal elsewhere), put that in
the note. The session asks its questions on cards in the app and on their phone.

Small corrections the person states outright are the one thing done here: *"Anna is my sister"* →
`"$CLI" tool update_entity entity_type=people slug=anna field=relationship_to_user value=Family`;
notes about a person or place → `update_entity_notes`. Names come from Apple Photos and cannot be
changed here.

## 4. Show them the page

When the person wants to read something Remember This wrote (a Life Book chapter, a month of their life),
or a session you started has written one, open it in the app instead of pasting it here: write
`{"paths": ["Notes/life/biography.md"], "title": "Your Life Book"}` to `.tmp/args-<session>.json` and run
`"$CLI" tool open_review '@.tmp/args-<session>.json'` (several files, or a folder, open as a list). The app shows the
page, redraws it when a session revises it, and has a box and a mic under it: what they say there goes to a
Remember This session as a remark about that page.

## 5. Say what happened and where to see it

End with what changed and where it shows: *"A session is writing last month's summary; follow it in
Remember This → Sessions, and the result lands in Notes/life/months/."* If something could not be
done, say so plainly and what would fix it.

If the person hits a problem with the app itself, offer a bug report: `preview_bug_report`, then
`submit_bug_report` only after they have read the preview and said yes.

More: `references/vault.md` (where everything lives in the vault) and `references/commands.md`
(every command Remember This uses).
