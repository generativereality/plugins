# Using Clerk.AI from this session

Every skill for Clerk.AI starts here. These are the steps all of Augmented Mind's apps share; the skill that sent you
here says what to do with them.

## 1. Find the app's command line

Call it `$CLI` below.

- **macOS:** `/Applications/Clerk.AI.app/Contents/MacOS/clerkai`, or the same under `~/Applications/`. Use the one that
exists (`ls`). In a session the app itself started, `clerkai` is already on the PATH.
- **Windows:** `clerkd.exe` in the app's install folder: `%LOCALAPPDATA%\Programs\Clerk.AI\clerkd.exe`, or for an install
made before October 2026 `%LOCALAPPDATA%\Clerk.AI\clerkd.exe`.
- **Neither exists:** Clerk.AI is not installed. Say so and give the download page, https://clerkai.eu. Never install it
yourself.

**Is it new enough?** `"$CLI" --help` works on every version: it must list an `app` line
(macOS: `"$CLI" --help | grep -qE '^\s+app\s'`; Windows: `& $CLI --help | Select-String -Quiet '^\s+app\s'`).
If it does not, the installed Clerk.AI is older than this skill. Say so, ask the person to update it (the app's own
*Check for Updates*), and do not run `app` or `tool`: on an older version they open the app's window instead of
answering.

Every app tool is `"$CLI" tool <name> key=value …` (`"$CLI" tool list` lists them, `"$CLI" tool help <name>`
explains one). For anything with prose in it, write the arguments as one JSON object to `.tmp/args-<session>.json`
with your Write tool, where `<session>` is a name of this session's own (this tab's name, or a short word you pick
once and keep): other sessions share the vault's `.tmp/`, and a shared file is overwritten between your Write and
your run. Then run `"$CLI" tool <name> '@.tmp/args-<session>.json'` (quoted: PowerShell reads a bare `@` as
splatting). The shell check refuses inline JSON, a heredoc of JSON and a `$` in double quotes.

## 2. Is the app running, and where is the vault?

`"$CLI" app status` prints JSON: `app_path`, `running` (a daemon serves this vault), `vault` (by default
`~/Clerk.AI/`) and `first_run`. Run every other command from the vault folder.

If `running` is `false` and the task needs the app (anything that starts or steers work, or shows it to the person),
run `"$CLI" app start`: it opens Clerk.AI the way a person does and waits for it, up to two minutes.

## 3. First run

`first_run.state` in `app status`:

- `not_started`: run `"$CLI" app start`. Clerk.AI begins first run and shows its first question; then run
`app status` again.
- `waiting`: Clerk.AI's first question is showing. Ask the person **that question, in its words**
(`first_run.question`; `first_run.note` is what the app says around it). You may help them answer: look at what
this session can already see (the repo it is in, a site, a folder they name) and suggest an answer, but the
answer is theirs. Write their answer to `.tmp/answer.md` and run `"$CLI" app first-answer @.tmp/answer.md`. The
app takes it as if it was typed in its window and starts its first work; tell the person they can watch it in
Clerk.AI.
- `answered`: first run is behind them. Go on to step 4.

**Before any work: `consent` in `app status`.** `pending` means the person has not yet answered Clerk.AI's card
that says what an agent working as them can do. Nothing starts until they do: every round and every note is
refused. Tell them to open Clerk.AI and answer that card (it shows during first run), then run `app status` again.
Never answer it for them. `answered` means go on.

## 4. Hand the work to the app

The work runs in Clerk.AI's own sessions, so it shows in the app, keeps the vault's rules and can be continued
there. **Do not do it in this session instead**: using the app has to be the better experience.

1. Write `{"cadence": "period-close", "note": "<the person's request, in their own words, and anything
this conversation knows that the work needs: links, file paths, where the team keeps its work>"}` to your
arguments file, then run `"$CLI" tool trigger_dreamer '@.tmp/args-<session>.json'`. A round that is already
running gets the note; otherwise a round starts with it. The answer says which happened, and an
error means the note did not arrive.
2. The round asks its questions as cards, which the person answers **in Clerk.AI** (or its phone companion): tell them
a card is waiting there, and do not repeat it here, or they answer the same card twice. Only when they ask you to
take a card here, read it with `"$CLI" tool list_open_questions` and pass on their words with `answer_question`.
Never answer for them.
3. Anything more for the running round: `send_dreamer_message` with `{"text": "…"}`.

## 5. Where the work lives

When the conversation shows where the person or their team keeps its work (a Google Drive, OneDrive, SharePoint
or Dropbox folder, a repo, a drafts folder), say so in the note: Clerk.AI works from that place.

## 6. Say what changed and where to see it

Tell the person what the app did and where to look in Clerk.AI. Never say nothing leaves the computer: what the agent
reads goes to their AI provider under its terms.
