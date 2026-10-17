# Where things live in a Remember This vault

The vault is a plain folder (default `~/Remember This`). `Notes/` is also an Obsidian vault.

```
Remember This/
├── CLAUDE.md                     the person's own instructions (theirs; read it, never rewrite it)
├── Media/                        drop folder: files put here are processed
├── Registry/<identity>/          one folder per identity (a person or a group); app-managed
│   ├── cloud/icloud/photos/YYYY/MM/DD/   one .md per photo or video
│   ├── cloud/icloud/voice/YYYY/          one .md per voice memo, transcript in the body
│   ├── people/<slug>.md          people, from Apple Photos face clusters
│   ├── places/<slug>.md          places, from photo GPS
│   ├── groups/<slug>.md          people who often appear together
│   ├── questions/<slug>.md       question cards the app shows
│   ├── eras/ narratives/         drafts written by sessions
└── Notes/
    ├── life/days|weeks|months|years/   rollups the app writes on a schedule
    ├── life/eras.md, life/biography.md the Life Book drafts
    ├── life/people/                    person notes the person keeps
    ├── diary/                          diary entries
    ├── todos/inbox.md                  tasks caught from voice memos
    └── orientation-board.md            what matters right now
```

## Rules that keep the app working

- **Registry files are the app's.** Change people and places through `update_entity` /
  `update_entity_notes`, never by editing the file: the app regenerates them and keeps only those
  fields.
- **A transcript is stored as Whisper wrote it.** Never tidy or shorten one in place.
- **The index is a cache of the markdown.** `query_assets` reads it; to change a fact, change the
  markdown (through a session), never the database.
- **Everything a session concludes is a draft**, marked as such, with the evidence it rests on.
  "It looks like…", not "You did…".
- Find files by name with `find_vault_files`, or `find Registry -path "*/voice/*" -name "*.md"`.
