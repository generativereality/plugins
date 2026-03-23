# generativereality/plugins

Claude Code plugin marketplace. Each directory under `plugins/` is a registered plugin.

## Adding or updating a plugin

Each plugin entry only needs a `.claude-plugin/plugin.json` with `name`, `version`, `description`, `author`, and `homepage`.

The version here must match the npm package version — Claude Code uses this to detect available updates.

## Release flow for agentherder (and other plugins)

1. Bump version and publish the npm package in the plugin's own repo (`generativereality/agentherder`)
   - Skills and `.claude-plugin/plugin.json` are bundled in the npm package — no need to duplicate them here
2. Update the version in `plugins/<name>/.claude-plugin/plugin.json` here to match, commit and push
3. Users update via Claude Code:
   - `/plugins` → Marketplaces → Update generativereality marketplace
   - Then update the individual plugin from the plugins list
