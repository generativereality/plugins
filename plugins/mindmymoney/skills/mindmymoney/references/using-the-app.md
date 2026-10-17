# Using Mind My Money from this session

Every skill for Mind My Money starts here. These are the steps all of Augmented Mind's apps share; the skill that sent you
here says what to do with them.

## 1. Find the app's command line

Call it `$CLI` below.

- **macOS:** `/Applications/Mind My Money.app/Contents/MacOS/mindmymoney`, or the same under `~/Applications/`. Use the one that
exists (`ls`). In a session the app itself started, `mindmymoney` is already on the PATH.
- **Windows:** `mindmymoneyd.exe` in the app's install folder: `%LOCALAPPDATA%\Programs\Mind My Money\mindmymoneyd.exe`, or for an install
made before October 2026 `%LOCALAPPDATA%\Mind My Money\mindmymoneyd.exe`.
- **Neither exists:** Mind My Money is not installed. Say so and give the download page, https://mindmy.money. Never install it
yourself.

**Is it new enough?** `"$CLI" --help` works on every version: it must list an `app` line
(macOS: `"$CLI" --help | grep -qE '^\s+app\s'`; Windows: `& $CLI --help | Select-String -Quiet '^\s+app\s'`).
If it does not, the installed Mind My Money is older than this skill. Say so, ask the person to update it (the app's own
*Check for Updates*), and do not run `app` or `tool`: on an older version they open the app's window instead of
answering.

Every app tool is `"$CLI" tool <name> key=value …` (`"$CLI" tool list` lists them, `"$CLI" tool help <name>`
explains one). For anything with prose in it, write the arguments as one JSON object to `.tmp/args.json` with your
Write tool, then run `"$CLI" tool <name> @.tmp/args.json`: the shell check refuses inline JSON, a heredoc of JSON
and a `$` in double quotes.

## 2. Is the app running, and where is the vault?

`"$CLI" app status` prints JSON: `app_path`, `running` (a daemon serves this vault), `vault` (by default
`~/Mind My Money/`) and `first_run`. Run every other command from the vault folder.

If `running` is `false` and the task needs the app (anything that starts or steers work, or shows it to the person),
run `"$CLI" app start`: it opens Mind My Money the way a person does and waits for it, up to two minutes.

## 3. First run

`first_run.state` in `app status`:

- `not_started`: run `"$CLI" app start`. Mind My Money begins first run and shows its first question; then run
`app status` again.
- `waiting`: Mind My Money's first question is showing. Ask the person **that question, in its words**
(`first_run.question`; `first_run.note` is what the app says around it). You may help them answer: look at what
this session can already see (the repo it is in, a site, a folder they name) and suggest an answer, but the
answer is theirs. Write their answer to `.tmp/answer.md` and run `"$CLI" app first-answer @.tmp/answer.md`. The
app takes it as if it was typed in its window and starts its first work; tell the person they can watch it in
Mind My Money.
- `answered`: first run is behind them. Go on to step 4.

**Before any work: `consent` in `app status`.** `pending` means the person has not yet answered Mind My Money's card
that says what an agent working as them can do. Nothing starts until they do: every round and every note is
refused. Tell them to open Mind My Money and answer that card (it shows during first run), then run `app status` again.
Never answer it for them. `answered` means go on.

## 4. Hand the work to the app

The work runs in Mind My Money's own sessions, so it shows in the app, keeps the vault's rules and can be continued
there. **Do not do it in this session instead**: using the app has to be the better experience.

1. Write `{"cadence": "money-round", "note": "<the person's request, in their own words, and anything this
conversation knows that the work needs: links, file paths, where the team keeps its work>"}` to
`.tmp/args.json`, then run `"$CLI" tool trigger_dreamer @.tmp/args.json`. A round that is already running
gets the note; otherwise a round starts with it.
2. The round asks its questions as cards: `"$CLI" tool list_open_questions` shows them. Show them to the person
and pass on what they say with `answer_question`. Never answer for them.
3. Anything more for the running round: `send_dreamer_message` with `{"text": "…"}`.

## 5. Where the work lives

When the conversation shows where the person or their team keeps its work (a Google Drive, OneDrive, SharePoint
or Dropbox folder, a repo, a drafts folder), say so in the note: Mind My Money works from that place.

## 6. Say what changed and where to see it

Tell the person what the app did and where to look in Mind My Money. Never say nothing leaves the computer: what the agent
reads goes to their AI provider under its terms.
