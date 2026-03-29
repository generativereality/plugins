---
name: browser
description: Launch and control a browser via Playwright MCP — navigate pages, click elements, fill forms, take snapshots, and automate web tasks. Use this when you need to interact with websites that require authentication or dynamic content.
---

# Browser Automation (Playwright MCP)

Control a real Chrome browser instance via Playwright MCP tools. The browser uses a persistent profile so logins, cookies, and preferences are preserved across sessions.

## Setup

Before using any `mcp__playwright__*` tools, ensure Chrome is running with remote debugging enabled.

Check if Chrome CDP is already available:

```bash
curl -s -o /dev/null -w "%{http_code}" http://localhost:9223/json/version
```

If it returns `000` or fails, launch Chrome:

```bash
/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome \
  --remote-debugging-port=9223 \
  --user-data-dir="$HOME/Library/Application Support/Google/Chrome/browser-automation" \
  --no-first-run --no-default-browser-check 'about:blank' &
```

Wait for it to be ready:

```bash
for i in {1..10}; do
  curl -s -o /dev/null http://localhost:9223/json/version && echo "Ready" && break
  sleep 0.5
done
```

## Available Tools

Once Chrome is running, these Playwright MCP tools are available:

| Tool | Purpose |
|------|---------|
| `mcp__playwright__browser_navigate` | Navigate to a URL |
| `mcp__playwright__browser_snapshot` | Get an accessibility snapshot of the current page |
| `mcp__playwright__browser_click` | Click an element (by ref from snapshot) |
| `mcp__playwright__browser_type` | Type text into an input field |
| `mcp__playwright__browser_select_option` | Select from a dropdown |
| `mcp__playwright__browser_hover` | Hover over an element |
| `mcp__playwright__browser_drag` | Drag between elements |
| `mcp__playwright__browser_screenshot` | Take a screenshot |
| `mcp__playwright__browser_run_code` | Execute JavaScript in the page |
| `mcp__playwright__browser_wait` | Wait for a specified time |
| `mcp__playwright__browser_tab_list` | List open tabs |
| `mcp__playwright__browser_tab_new` | Open a new tab |
| `mcp__playwright__browser_tab_select` | Switch to a tab |
| `mcp__playwright__browser_tab_close` | Close a tab |

## Usage Pattern

1. Always check/launch Chrome first (see Setup above)
2. Navigate to the target URL with `browser_navigate`
3. Take a snapshot with `browser_snapshot` to see the page structure
4. Interact using `browser_click`, `browser_type`, etc. using refs from the snapshot
5. Take new snapshots after interactions to verify state changes

## Working with Heavy UIs (Porkbun, Cloudflare, etc.)

Some web apps have very large DOMs that cause snapshot timeouts, cookie banners that block clicks, and CSRF tokens that expire between interactions.

### Cookie banners blocking clicks

Remove them via JS before clicking:
```js
// browser_evaluate
() => { document.querySelector('[role="dialog"]').remove(); }
```

### CSRF / "Security Error" on form submit

If a site's built-in submit function (e.g. `nsDrawerSubmit()`) silently fails or returns a security error, bypass the UI and call the API directly using the page's jQuery (which auto-includes CSRF cookies):

```js
// browser_evaluate — Porkbun nameserver update example
() => {
  return new Promise((resolve) => {
    $.post('/api/domains/updateDomainNameservers', {
      domain: 'example.com',
      nameservers: 'ns1.cloudflare.com\nns2.cloudflare.com',
      confirmed: '',
      leaveDnssec: ''
    }, function(data) {
      resolve('result: ' + JSON.stringify(data));
    }).fail(function(xhr) {
      resolve('fail: ' + xhr.status);
    });
  });
}
```

To find the correct API endpoint, inspect the site's submit function:
```js
// browser_evaluate
() => { return window.someSubmitFunction.toString().substring(0, 1000); }
```

### Large DOMs causing snapshot timeouts

Use `browser_evaluate` instead of `browser_snapshot` to extract specific data:
```js
// browser_evaluate
() => { const ta = document.querySelector('textarea'); return ta ? ta.value : 'not found'; }
```

### Finding and clicking buttons in large DOMs

Use `browser_evaluate` to find and click by attribute rather than waiting for snapshot refs:
```js
// browser_evaluate
() => {
  const btn = Array.from(document.querySelectorAll('button'))
    .find(b => b.getAttribute('aria-label')?.includes('cctabs.com'));
  if (btn) { btn.click(); return 'clicked'; }
  return 'not found';
}
```

## Notes

- The `browser-automation` profile is separate from your normal Chrome profile — no conflicts
- Logins persist between sessions, so you only need to authenticate once per site
- For pages with very large or complex DOMs, prefer `browser_evaluate` over `browser_snapshot`
- Some pages load slowly — wait a few seconds after navigation before taking snapshots
- CAPTCHA challenges may appear as empty snapshots — retry or navigate directly
- When `browser_snapshot` returns empty or times out, use `browser_evaluate` to inspect the page
- Always verify side effects (e.g. `dig NS domain @8.8.8.8`) rather than trusting UI feedback
