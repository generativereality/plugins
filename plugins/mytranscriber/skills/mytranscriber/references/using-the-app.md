# Using My Transcriber from this session

Every skill for My Transcriber starts here. These are the steps all of Augmented Mind's apps share; the skill that sent you
here says what to do with them.

## 1. Find the app's command line

Call it `$CLI` below.

- **macOS:** `/Applications/My Transcriber.app/Contents/MacOS/transcriber`, or the same under `~/Applications/`. Use the one that
exists (`ls`). In a session the app itself started, `transcriber` is already on the PATH.
- **Windows:** `transcriberd.exe` in the app's install folder: `%LOCALAPPDATA%\Programs\My Transcriber\transcriberd.exe`, or for an install
made before October 2026 `%LOCALAPPDATA%\My Transcriber\transcriberd.exe`.
- **Neither exists:** My Transcriber is not installed. Say so and give the download page, https://mytranscriber.app. Never install it
yourself.

**Is it new enough?** `"$CLI" --help` works on every version: it must list an `app` line
(macOS: `"$CLI" --help | grep -qE '^\s+app\s'`; Windows: `& $CLI --help | Select-String -Quiet '^\s+app\s'`).
If it does not, the installed My Transcriber is older than this skill. Say so, ask the person to update it (the app's own
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
`~/My Transcriber/`) and `first_run`. Run every other command from the vault folder.

If `running` is `false` and the task needs the app (anything that starts or steers work, or shows it to the person),
run `"$CLI" app start`: it opens My Transcriber the way a person does and waits for it, up to two minutes.

## 3. First run

`first_run.state` in `app status`:

- `not_started`: My Transcriber's first run happens in its window (permissions and a short check), and asks no question you
can answer here. Run `"$CLI" app start`, tell the person what the window asks for, and go on with what does not
need it.
- `done`: first run is behind them. Go on to step 4.

## 4. Hand the work to the app

My Transcriber has no rounds: the work is the command the skill that sent you here names. It runs in the app and
shows there. Do not do the work another way in this session.

## 5. Where the work lives

When the conversation shows where the person or their team keeps its work (a Google Drive, OneDrive, SharePoint
or Dropbox folder, a repo, a drafts folder), say so in the note: My Transcriber works from that place.

## 6. Say what changed and where to see it

Tell the person what the app did and where to look in My Transcriber. Never say nothing leaves the computer: what the agent
reads goes to their AI provider under its terms.
