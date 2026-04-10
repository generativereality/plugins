# generativereality/plugins

Claude Code plugin marketplace. Plugins are registered in `.claude-plugin/marketplace.json`.

## How it works

Plugin files (plugin.json, SKILL.md) are stored directly in this repo under `plugins/<name>/`. The `sync-plugin` script in each plugin's repo keeps them in sync.

## Release flow for cctabs (and other directory-sourced plugins)

1. Make changes in the plugin's own repo (`generativereality/cctabs`)
2. Run `npm run sync-plugin` — syncs plugin.json + SKILL.md here, commits, and pushes
3. Users update via Claude Code:
   - `/plugins` → Marketplaces → Update generativereality marketplace
   - Then update the individual plugin from the plugins list
