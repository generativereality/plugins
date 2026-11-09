# Video: demos, explainers, reels, launch clips, memory films

Video prefers pieces that combine real footage, stills and animation over any single one. A narrated
slideshow is the least exciting format there is, and to many people it reads like the phone's own
automatic "memories" feature.

## The pipeline

1. **Script and shots first,** as one timeline file (JSON): shots, text, captions, focus points,
   music, end line. The agent's job is writing the timeline; any renderer can consume it.
2. **Voice (if any) and its transcript** for word timings (`audio.md`).
3. **Render:** for HTML-based motion, use **HyperFrames** (HTML + GSAP rendered to MP4 through Chrome
   and ffmpeg, Apache-2.0); read its own skills for the render contract (`tools.md`). For a
   zero-dependency route, use Pillow + ffmpeg. Remotion is the fastest renderer, but it is free only
   for up to three employees and doesn't normalise loudness. The renderers look nearly identical on the
   same timeline. HyperFrames' text came out slightly clearer.
4. **Check:** `hyperframes check` (it caught captions too short to read, an end card too short for its
   credits, overlaps, type under 28 px and low contrast), a contact sheet of frames to look at, then
   the encode checks below.

A timeline shape that has worked well for photo-and-clip films:

```json
{"width":1080,"height":1920,"fps":30,"style":"calm|cut",
 "shots":[
   {"photo":"<file>","seconds":3.2,"motion":"push|pull|pan-left|pan-right|none","focus":[0.5,0.4],"caption":"…","transition":"cut|dissolve"},
   {"clip":"<file>","from":1.2,"seconds":2.5,"sound":true,"caption":"…"},
   {"card":{"title":"Day 2 · Saturday","lines":["…"]},"seconds":2.0}],
 "music":"<file>","music_db":-10,"end_line":"…"}
```

Calm style pushes 1.00→1.09 with dissolves; cut style punches in 1.04→1.18 with hard cuts. A text that
needs longer than its shot's seconds is a warning to fix, not a render to ship.

## Cut craft

- **Open on the most specific moment,** never a title card.
- **A real person's recorded voice sets the order** (a memo, an interview, a founder talking): edit
  to the order of the telling, not to the timeline, and use the word timestamps to put each shot on
  the word that names it.
- **Cut on the words.** Hard cuts on the narrator's or speaker's words, using word timestamps.
- **Punch in** toward the face or the subject (1.04 to 1.18).
- **Real sound from real clips:** the loudest 2.5 s window of a clip, one to three times a film, ducked
  under any voice. Never use a performance's music.
- **One label per run of shots** (a day and place on a dark pill). Per-shot labels stack up and become
  unreadable in fast cuts.
- **Index and stats cards** (*"Day 2 · Saturday · harbour, market"*, counts computed from the data),
  and an **itinerary map** where the route matters: the camera follows the route, solid where there
  are pictures, dashed and captioned where not.
- **For what wasn't filmed:** an index card, a cut scene done properly in motion design, or generated
  stills in one style. Crude drawn shapes look terrible.
- **End on a line that lands,** or a face, or a line addressed to whoever the film is for.
- **Lengths:** social 35 to 45 s, product 45 to 55 s, scrapbook 30 to 40 s, calm slideshow 50 to 70 s.
- **Offer different styles** (social, product, scrapbook, calm) from the same material, and say which
  you'd pick and why. The person's favourite changes with the material.

## Showing a real product

Every frame is the real product. Record the real web app with Playwright and a Chrome DevTools
screencast (3× device pixel ratio, about 45 fps, recorded in real time), or record a native app with the
OS screen recorder, then compose the result with punch-ins and captions. Best: write the demo screen as
a page whose state is a pure `render(t)`, so the same page can be recorded live and seeked frame by
frame by the renderer. Caption pills must not cover the rows you are showing during a punch-in.

Recording a native app on macOS (four takes once captured the wrong thing without one error):
- **Use `screencapture -v`, not ffmpeg `-f avfoundation`.** avfoundation records whoever is on the
  console whatever user it runs as, its device numbers differ per session (one session's "screen" was
  the other's camera), and its feed froze while the file kept growing.
- **`screencapture -v` writes the file only when `-V <secs>` runs out; an interrupt saves nothing.**
  Record in short parts (`-V 60`) in a loop and stop by letting the part in flight finish.
- **Prove the picture moved:** hash the menu-bar clock region of each part's first and last frame. A
  frozen capture otherwise looks like a quiet screen.
- **Address footage by wall-clock time,** and have whatever drives the app write a UTC event log, so a
  cut is written against events and every on-screen line can be checked against what happened.
- Background tabs and covered windows aren't on camera: lay out the windows before the take, with the
  driven browser tab the one showing.
- **Compose screen recordings in a renderer with sub-pixel transforms,** not ffmpeg `zoompan`, which
  moves in whole-pixel jumps (still for 6 or 7 frames, then a jump): judder on interface text. Master
  at 4K, crop as clipping boxes, push in with a CSS transform, set captions as real text. Remotion
  writes full-range `yuvj420p` / bt470bg; convert to tv-range bt709 for deliverables. A zoomed-out
  recording at 720p leaves interface text at about 7 px.

## Captions

- **Caption text comes from the script; timing comes from the transcript,** zipped word by word by
  position. Whisper writes "That's spinach" for "That spinach?" and misspells names, so its text is never
  the caption.
- **Reading time** at least 0.5 s + 0.3 s a word; type at least 28 px at 1080 wide; contrast at least
  3:1. White on light images measured 1.4 to 2.3:1, so give them a soft dark backing.
- Bold word-by-word captions for social cuts; phrase captions for calm films. 17 to 20 characters a
  second is a comfortable pace.
- **Over a voice, a caption is on screen exactly while its line is spoken.** A separate reading-speed
  floor (15 characters a second) made every voiced cut drag and made a faster voice change nothing. A
  text-only cut of the same film takes the voiced cut's timings.
- Translated captions with no voice: spread the timing by word length.

## Crops

- 9:16 from landscape: set a focus point per shot (faces and saliency), or the subject is lost. Set it
  on the subject of the line being said: a portrait crop once cut someone out of their own goodbye.
- A group wider than the slice is shown whole over a blurred, darkened copy of itself. Never letterbox.

## Motion that survives a seek

HyperFrames renders by seeking. GSAP suppresses `call` and `onUpdate` on a seek, so counters are
stacked numbers switched with zero-length sets, and flicker is precomputed from a seed. Move with
transforms, not `top` (which snaps to pixels); use `svgOrigin` in SVG; never overlap tweens on one
element; start overlays hidden.

## HDR phone clips

iPhone clips are HDR (HLG), and some renderers then promote the whole film to HDR at a fraction of
real-time speed. Tone-map to SDR BT.709 first (`avconvert --preset Preset1920x1080` on a Mac in about
2 s a clip; ffmpeg `zscale` + `tonemap` elsewhere, which needs zimg), then render as SDR.

## Encode and verify

- Master: x264 CRF 18 at 1080p. Chat copy: H.264 720p at most about 15.5 MB. HEVC 1080p is about 10 to 16 MB.- Always `-movflags +faststart`, or a browser downloads the whole file before playing a frame. A `-c
  copy` concat doesn't inherit it, so name it again, and check the atom order (`moov` before `mdat`)
  rather than trusting the flag was passed. Ask what each intermediate is for: a clean master that
  existed only as a pre-burn concat had no faststart and no home.
- Loudness: −14 LUFS for social, −16 to −18 for a quiet film, true peak −1.5 dB (`audio.md`).
- **Verify by decoding, not by exit code:** `ffmpeg -v error -i out.mp4 -f null -` prints nothing when
  the file is sound; a killed render leaves a file of the right size that is truncated. Run a backgrounded
  build under `python3 -u`, or its log stays empty and reads as a hang. Transcribe the finished mix once
  more.
- **Count frames; never read `Duration:`** (it reported 7.62 s and 7.63 s for parts a whole frame
  apart). Count with `ffmpeg -v error -i f.mp4 -map 0:v -f null - -progress /dev/stdout`. Three causes
  it hides: `-t` before `-i` cuts at a packet boundary (after the filter it is exact); a video-only part
  rounds differently from one with audio, so build every part with the same command, silent track
  included; and `-shortest` with `-c copy` drops frames. Use `-shortest` only for a truly unbounded
  input (a looping bed, `anullsrc`).
- Some ffmpeg builds (Homebrew 9.x, Remotion's bundled one) have no `drawtext` and no subtitles filter.
  Text comes from the HTML layer or Pillow, never from ffmpeg. An app-bundled ffmpeg that has `drawtext`
  may lack a fontconfig configuration (pass `fontfile=`), and with a variable font a newline inside one
  `textfile` draws a missing-glyph box: one `drawtext` per line.
- **The poster frame is a deliverable,** with its own build step. Take it from the captioned master,
  and derive the timestamp from the subtitle cue whose line it should carry, so retiming the line moves
  the poster. Then check the page uses it: a site may mount its own local still, so re-uploading changes
  nothing a visitor sees (read the page's `poster=` attribute).

## Publishing the file

- **Serve a draft film at a stable URL** and overwrite it; mint a dated copy only when a published embed
  must not change underneath it. Check the CDN's caching before building around it: an overwrite may
  be live at once.
- **Verify an upload by hash, and know when the ETag can't answer.** For a single-part S3 or R2 upload the
  ETag is the MD5; above the multipart threshold (about 8 MB for `aws s3 cp`) it ends in `-<parts>` and
  never matches. Download and hash instead; don't recompute a multipart ETag, which depends on a
  configurable chunk size. Four perfect uploads once reported as failures this way, and a check that
  cries wolf on the normal case gets ignored on the real one.
- **"Is this new?"** When someone reports a fault in a cut they approved before, fetch the published
  version and compare before reasoning about recent edits. Validate the comparison first: a correlation
  at a guessed offset read 0.02 ("different files") for identical audio. Compare windowed RMS, and scan
  for the alignment if you correlate.
