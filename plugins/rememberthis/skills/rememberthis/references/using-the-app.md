# Using Remember This from this session

Every skill for Remember This starts here. These are the steps all of Augmented Mind's apps share; the skill that sent you
here says what to do with them.

## 1. Find the app's command line

Call it `$CLI` below.

- **macOS:** `/Applications/Remember This.app/Contents/MacOS/rememberthis`, or the same under `~/Applications/`. Use the one that
exists (`ls`). In a session the app itself started, `rememberthis` is already on the PATH.
- **Windows:** `rememberthisd.exe` in the app's install folder: `%LOCALAPPDATA%\Programs\Remember This\rememberthisd.exe`, or for an install
made before October 2026 `%LOCALAPPDATA%\Remember This\rememberthisd.exe`.
- **Neither exists:** Remember This is not installed. Say so and give the download page, https://rememberthis.ai. Never install it
yourself.

**Is it new enough?** `"$CLI" --help` works on every version: it must list an `app` line
(macOS: `"$CLI" --help | grep -qE '^\s+app\s'`; Windows: `& $CLI --help | Select-String -Quiet '^\s+app\s'`).
If it does not, the installed Remember This is older than this skill. Say so, ask the person to update it (the app's own
*Check for Updates*), and do not run `app` or `tool`: on an older version they open the app's window instead of
answering.

Every app tool is `"$CLI" tool <name> key=value …` (`"$CLI" tool list` lists them, `"$CLI" tool help <name>`
explains one). For anything with prose in it, write the arguments as one JSON object to `.tmp/args.json` with your
Write tool, then run `"$CLI" tool <name> @.tmp/args.json`: the shell check refuses inline JSON, a heredoc of JSON
and a `$` in double quotes.

## 2. Is the app running, and where is the vault?

`"$CLI" app status` prints JSON: `app_path`, `running` (a daemon serves this vault), `vault` (by default
`~/Remember This/`) and `first_run`. Run every other command from the vault folder.

If `running` is `false` and the task needs the app (anything that starts or steers work, or shows it to the person),
run `"$CLI" app start`: it opens Remember This the way a person does and waits for it, up to two minutes.

## 3. First run

`first_run.state` in `app status`:

- `not_started`: run `"$CLI" app start`. Remember This begins first run and shows its first question; then run
`app status` again.
- `waiting`: Remember This's first question is showing. Ask the person **that question, in its words**
(`first_run.question`; `first_run.note` is what the app says around it). You may help them answer: look at what
this session can already see (the repo it is in, a site, a folder they name) and suggest an answer, but the
answer is theirs. Write their answer to `.tmp/answer.md` and run `"$CLI" app first-answer @.tmp/answer.md`. The
app takes it as if it was typed in its window and starts its first work; tell the person they can watch it in
Remember This.
- `answered`: first run is behind them. Go on to step 4.

**Before any work: `consent` in `app status`.** `pending` means the person has not yet answered Remember This's card
that says what an agent working as them can do. Nothing starts until they do: every round and every note is
refused. Tell them to open Remember This and answer that card (it shows during first run), then run `app status` again.
Never answer it for them. `answered` means go on.

## 4. Hand the work to the app

The work runs in Remember This's own sessions, so it shows in the app and keeps the vault's rules. The skill that
sent you here names the round: write `{"cadence": "<that round>", "note": "<the person's request, in their
own words>"}` to `.tmp/args.json` and run `"$CLI" tool trigger_dreamer @.tmp/args.json`. Questions come back
as cards (`list_open_questions`); pass on the person's answers with `answer_question`, never your own.

## 5. Where the work lives

When the conversation shows where the person or their team keeps its work (a Google Drive, OneDrive, SharePoint
or Dropbox folder, a repo, a drafts folder), say so in the note: Remember This works from that place.

## 6. Say what changed and where to see it

Tell the person what the app did and where to look in Remember This. Never say nothing leaves the computer: what the agent
reads goes to their AI provider under its terms.
