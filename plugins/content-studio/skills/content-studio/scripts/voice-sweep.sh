#!/usr/bin/env bash
# Mechanical sweep for machine-prose tells (references/voice.md §3-4).
# A candidate list, not a verdict: read every hit, then read the text aloud.
# Usage: voice-sweep.sh FILE [FILE...]
set -u
for F in "$@"; do
  [ -f "$F" ] || { echo "no such file: $F" >&2; continue; }
  # Strip YAML frontmatter, fenced code, HTML comments and markdown quote markers.
  TXT=$(awk 'NR==1&&/^---$/{fm=1;next} fm&&/^---$/{fm=0;next} fm{next}
       /^```/{code=!code;next} code{next}
       /<!--/{c=1} !c{print} /-->/{c=0}' "$F" | sed 's/^[[:space:]]*>[[:space:]]*//')
  # In code files, drop comment lines too, or a dash in a JSDoc counts as one in the copy.
  case "$F" in *.svelte|*.ts|*.tsx|*.js|*.jsx|*.mjs) TXT=$(printf '%s\n' "$TXT" | grep -vE '^[[:space:]]*(\*|/\*|\*/|//)');; esac
  t() { printf '%s\n' "$TXT"; }
  paras=$(t | awk 'BEGIN{RS="";n=0}{n++}END{print n}')
  dashes=$(t | grep -oE '—|&mdash;' | wc -l | tr -d ' ')
  echo "== $F"
  echo "paragraphs: $paras · em dashes: $dashes  (about one per paragraph is the tell)"
  echo "-- banned words and phrases"
  t | grep -noiE "\b(delve|tapestry|testament|pivotal|vibrant|boasts?|foster|landscape|intricate|meticulous|showcase|garner|seamless(ly)?|unlock|supercharge|game.changer|underscore|honest(ly)?|serves as|functions as|in today's|the reality is|fast-paced)\b" | head -40
  echo "-- meta-narration and negative parallelism"
  t | grep -noiE "(here'?s (the|what|why|how)|here (is|are) (the|what|why|how)|the part (that|nobody)|let me (explain|close)|that'?s not (what|how|why|the)|\. not [a-z]+[.,]|it'?s not (about )?[a-z]+[,.] it'?s|, not [a-z]+[.,]|, not (from|about|for|because|just|only|what|the|a|an) |not just [a-z]+ but|(isn'?t|wasn'?t) [a-z]+[^.]{0,40}\. (it'?s|it was))" | head -40
  t | grep -noiE "(is|was|are|were) not [^.]{1,50}\. (It|That|They) (is|was|are|were) " | head -20
  echo "-- short fragments (candidates: brand names with dots are false positives)"
  t | grep -oE "(^|[.!?]\"?[[:space:]]+)[A-Z][A-Za-z'-]{0,11}[.!?]" | sed 's/^[.!?"]*[[:space:]]*//' | sort | uniq -c | sort -rn | head -20
  echo "-- drumbeat lines (2+ adjacent hits = three parallel sentences)"
  t | grep -nE "^(The|An|A|Your|It|We|You) [a-z]+ [a-z]+ .{0,70}\.$" | head -10
  echo "-- one-line paragraphs"
  t | awk 'BEGIN{RS=""}{n=split($0,l,"\n"); if(n==1 && length($0)<60 && $0 !~ /^#|^[-*|]/) print "  " $0}' | head -15
done
echo "Now read it aloud as the person would say it. The sweep is a net with holes."
