# generativereality/plugins

Claude Code plugin marketplace. Plugins live under `plugins/<name>/` and are registered in `.claude-plugin/marketplace.json`.

## Two authoring modes

- **Synced from an external plugin repo** — e.g. `cctabs` lives at `generativereality/cctabs`. That repo runs `npm run sync-plugin` to copy `plugin.json` + `SKILL.md` here, commit, and push.
- **Authored directly in this repo** — e.g. `mytranscriber`. Edit files under `plugins/<name>/` directly; no external repo, no sync script. Bump `version` in `plugin.json` when you ship a substantive change.

Whichever mode, the same on-disk layout is canonical:

```
plugins/<name>/
  .claude-plugin/plugin.json
  skills/<skill-name>/SKILL.md
  [.mcp.json]                    # optional, for plugins that ship an MCP server
```

## Release flow

**External-repo plugin:**
1. Make changes in the plugin's own repo
2. Run `npm run sync-plugin` — syncs files here, commits, and pushes

**Directly-authored plugin:**
1. Edit files in `plugins/<name>/`
2. Bump `version` in `plugin.json` if it's a substantive change
3. Commit + push from this repo

**Both:** users pick up updates via Claude Code:
- `/plugins` → Marketplaces → Update `generativereality`
- Then update the individual plugin from the plugins list
- `/reload-plugins` to apply in the current session

## Adding a new plugin

1. Create `plugins/<name>/.claude-plugin/plugin.json` (name, description, version, author, homepage, license)
2. Create `plugins/<name>/skills/<skill-name>/SKILL.md` with frontmatter (`name`, `description`)
3. Add an entry to `.claude-plugin/marketplace.json` under `plugins[]` (name, description, author, source `./plugins/<name>`, category, homepage)
4. Add a row to `README.md`'s plugins table
5. Commit and push
