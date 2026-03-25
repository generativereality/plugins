# generativereality/plugins

Claude Code plugin marketplace. Plugins are registered in `.claude-plugin/marketplace.json`.

## How it works

Plugins use the **npm source type** — `marketplace.json` points to npm packages. Skills, plugin manifests, and versions are all read from the npm package. No plugin files are stored in this repo.

## Release flow for agentherder (and other npm-sourced plugins)

1. Bump version and publish the npm package in the plugin's own repo (`generativereality/agentherder`)
2. That's it — the marketplace auto-resolves the latest version from npm
3. Users update via Claude Code:
   - `/plugins` → Marketplaces → Update generativereality marketplace
   - Then update the individual plugin from the plugins list
