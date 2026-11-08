#!/usr/bin/env bash
# Render HTML frames to PNG with headless Chrome/Chromium (references/stills.md, recipe A).
# Usage: render-frames.sh OUT_DIR WIDTH HEIGHT frame.html [frame.html...]
# Output: OUT_DIR/<frame-basename>.png at WIDTH x HEIGHT CSS px (SCALE=2 for 2x pixels).
set -euo pipefail
[ $# -ge 4 ] || { echo "usage: $0 OUT_DIR WIDTH HEIGHT frame.html..." >&2; exit 2; }
OUT=$1; W=$2; H=$3; shift 3
mkdir -p "$OUT"
CHROME=${CHROME:-}
if [ -z "$CHROME" ]; then
  for c in "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" \
           "/Applications/Chromium.app/Contents/MacOS/Chromium" \
           "/c/Program Files/Google/Chrome/Application/chrome.exe" \
           "/c/Program Files (x86)/Google/Chrome/Application/chrome.exe" \
           "$(command -v google-chrome 2>/dev/null || true)" \
           "$(command -v chromium 2>/dev/null || true)" \
           "$(command -v chromium-browser 2>/dev/null || true)"; do
    if [ -n "$c" ] && [ -x "$c" ]; then CHROME=$c; break; fi
  done
fi
[ -n "$CHROME" ] || { echo "no Chrome/Chromium found; set CHROME=/path/to/chrome" >&2; exit 1; }
for f in "$@"; do
  abs=$(cd "$(dirname "$f")" && pwd)/$(basename "$f")
  png="$OUT/$(basename "${f%.*}").png"
  "$CHROME" --headless=new --disable-gpu --hide-scrollbars --no-first-run --no-default-browser-check \
    --force-device-scale-factor="${SCALE:-1}" --window-size="$W,$H" \
    --virtual-time-budget=3000 --screenshot="$png" "file://$abs" >/dev/null 2>&1 || true
  if [ -s "$png" ]; then echo "$png"; else echo "failed: $f" >&2; exit 1; fi
done
echo "Now open every PNG and look for collisions, crops and contrast before calling it done." >&2
