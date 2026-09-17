# generativereality/plugins

Claude Code plugin marketplace for [generativereality](https://github.com/generativereality).

## Install

```bash
/plugin marketplace add generativereality/plugins
```

## Plugins

| Plugin | Description | Install |
|--------|-------------|---------|
| [cctabs](https://cctabs.com) | Claude Code tab manager. Terminal tabs as the UI, no tmux. | `/plugin install cctabs@generativereality` |
| [browser-automation](https://github.com/generativereality/browser-automation) | Browser automation for Claude Code. Persistent Chrome profile, CDP connection. | `/plugin install browser-automation@generativereality` |
| [mytranscriber](https://mytranscriber.app) | Local audio/video transcription via My Transcriber CLI. On-device Whisper, no cloud. | `/plugin install mytranscriber@generativereality` |
| [review-md](https://github.com/generativereality/review-md) | Markdown → one self-contained styled HTML file. Mermaid inlined at build time, dark mode, print stylesheet. | `/plugin install review-md@generativereality` |

## Troubleshooting

### A plugin is missing, or stuck at an old version

`~/.claude/plugins/marketplaces/<name>` **is a git clone**, and
`claude plugin marketplace update` is a pull. Two failures look alike and have different fixes.

**Merely behind** — the plugin is missing or the version is old, and an update fixes it:

```bash
claude plugin marketplace update generativereality
claude plugin update <plugin>@generativereality
```

Worth doing unprompted: installed plugins lag silently and nothing says so. Measured 2026-09-17 on
one machine — `browser-automation` at 0.4.8 against 0.4.13, `cctabs` at 0.3.1 against 0.5.4.

**History diverged** — the update fails, or the plugin stays missing after a successful update.
This happens when this repo has been force-pushed (it has, to scrub an internal hostname from
public history): the local clone no longer descends from the remote, and a pull cannot reconcile
it. Reset rather than pull:

```bash
cd ~/.claude/plugins/marketplaces/generativereality
git fetch origin && git reset --hard origin/main
```

or throw the clone away:

```bash
claude plugin marketplace remove generativereality
claude plugin marketplace add generativereality/plugins
```

### "review-md isn't in the marketplace"

A cache from before **2026-08-22 19:28** genuinely does not contain it — the entry was named
`render-doc` until then, and that repo was deleted and recreated as `review-md`. So
`/plugin install review-md@generativereality` correctly reports it missing while this repo is
perfectly fine. Update the marketplace first; if that fails, it is the diverged case above.
