# Tool skills this one routes to, and where it overrides them

content-studio holds the process and the craft. For a tool's own mechanics, read that tool's skill
when it is installed. Where a tool skill's defaults conflict with the rules here, **this skill wins**,
because its rules protect the person (cost, consent, nothing going out). Those conflicts are listed
below.

| Tool skill | Use it for | Overrides from content-studio |
|---|---|---|
| `hyperframes` (+ `hyperframes-cli`, `hyperframes-registry`) | HTML-to-video: the render contract, motion craft, captions, the registry of ready-made blocks (transitions, titles, charts, maps). Search the registry before hand-building any named visual. | Telemetry off (`npx hyperframes telemetry disable` or `HYPERFRAMES_NO_TELEMETRY=1`); `init --skip-skills` so it doesn't write skills into the person's global folder; **never** its `publish`, `cloud`, `billing` or `feedback` commands, and no cloud render, without the person's yes; render only after the person picked (the pick in `review.md` replaces its own approval step) |
| `media-use` | sourcing media for a HyperFrames video: catalog music and images, logos (never redrawn), cutouts, colour treatments, transcripts | **Always show what a run cost** (it says never to); local and free first where quality is equal, not only when asked; no HeyGen-hosted generation of a real person |
| `review-md` | rendering a markdown review page to one HTML file, or an artifact | media pages need `--allow-html` and `media-src 'self' file:` in the CSP, or `<video>`/`<audio>` are silently refused; verify a media page by decoding each embedded file, because an automation browser may load no audio |
| `browser-automation` | reading a place's rules and outliers in the person's signed-in browser; preparing a post in its form for the person to send; screen-recording a web app | read-only unless preparing a draft; never press post, send or submit |
| A personal voice skill or voice notes (whatever the person keeps) | their voice, their banned words, their lessons | it overrides `voice.md` wherever they differ |
| A strategy or growth skill (positioning, channels, bets) | what to say, to whom, where and why now | content-studio never overrides its decisions; it raises doubts in the brief |

## Scripts in this skill

| Script | What it does |
|---|---|
| `scripts/voice-sweep.sh <file>` | the mechanical machine-prose sweep: em dashes against paragraphs, short fragments, banned words, negative-parallel shapes, drumbeat lines. Exit 0 always; read the hits |
| `scripts/render-frames.sh <out-dir> <w> <h> <frame.html>…` | renders HTML frames to PNG with the installed Chrome/Chromium headless (macOS, Linux, Windows Git Bash) |
| `scripts/spend.mjs add|total` | the per-piece spend ledger (`spend.jsonl` in the piece's folder) |
