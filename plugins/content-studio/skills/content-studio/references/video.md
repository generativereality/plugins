# Video: the process for any short video, and its presets (teaching reels, demos, launch clips, ads, memory films)

Video prefers pieces that combine real footage, stills and animation over any single one. A narrated
slideshow is the least exciting format there is, and to many people it reads like the phone's own
automatic "memories" feature.

## The process (every short video)

Every short video goes through the same steps in the same order: a teaching reel, a product demo, an
ad, a launch film, a family film. What changes per kind is a preset (§Presets). A video made by jumping
from the brief to the render looks like it: the steps below are where it starts to look professional.
The person approves at three points (the idea, the script, the storyboard) and picks at the end;
everything between is the studio's job.

| # | Step | What comes out | The person |
|---|---|---|---|
| 0 | **Brief and references.** Who it is for, where they meet it, the one next step (`brief.md`). Study three to five videos that worked in that place, the person's own saved examples first (SKILL step 2): pacing, hook, structure, cuts per second. Keep the form, change the content. | brief, reference notes with links | |
| 1 | **One true thing.** Problem, audience, goal and the feeling it should leave, in four lines; the one fact or moment the film exists for; every fact with its source. | one page | |
| 2 | **The idea.** At least three ideas of different kinds (a real task followed through the product, a character story, a held talking head, a typographic essay, a montage of real output, a stillness that breaks). Cover the logo: if it would work as well for a competitor, it is not the idea yet. | three concepts, one recommended, a cost estimate | approves |
| 3 | **Script and voice plan.** Hook (what it is about, a pull, a turn), setup, the steps, the payoff before 80% of the runtime, one ask. About 2.5 to 3 spoken words a second, one line per beat. Whose voice (`audio.md` §Narration). | script with cues, voice plan | approves |
| 4 | **Characters and world.** One look for the whole film, the cast locked before any scene is made, the places, and which real screens or footage get captured (§Characters and world). | look sheet, cast sheets, capture list | |
| 5 | **Storyboard.** One row per beat: its role, what it makes the viewer believe, the line, the picture (described so it works with the words covered), how it hands over to the next beat, the assets and the tool for each. Never three beats of the same kind in a row; one hero moment worth a screenshot. Shown as a contact sheet, one frame per beat. | storyboard, contact sheet | approves |
| 6 | **Animatic.** Grey shapes (rough HTML, or blocked-out 3D) timed to a scratch voice. Fix camera, timing and pacing here, where it costs nothing. | animatic | |
| 7 | **Assets, hardest beat first.** The voice take, real screen recordings, generated plates and clips (`generation.md`). Estimate before every paid call; never overwrite a take that cost money. Look at stills of the hero beat before building the rest. | assets, spend log | |
| 8 | **Edit and sound.** Cut on the words and on motion, word-synced captions (§Captions), silence before the hit, music ducked under the voice, a few placed sounds, about -14 LUFS (`audio.md`). | the cut | |
| 9 | **Look honestly, then fix.** The gates below, computed on the render; describe every frame of the contact sheet in one sentence; transcribe the voice back. Fix in this order: anything untrue, the idea, the links between beats, hierarchy, timing, finish, sound. | the final | picks |
| 10 | **Deliver and learn.** The file, its editable source, a note (what is real, what is generated, the gate results), the caption; the pick and its reasons into the house style (SKILL step 7). | | |

A small piece may fold steps together (a 15 s clip of one real screen needs no cast), never skip
the idea, the storyboard or the gates.

### The gates (a fail is fixed, not argued)

Check these on the rendered file, by measuring, not by memory of what was meant:

| Gate | Passes when |
|---|---|
| Renders | it decodes, moves, runs the planned length, and has audio |
| Proof is readable | real interface or document text is at least 4% of the frame height, magnified by the camera, never a full screen shrunk to fit |
| No dead frames | never more than 3 identical frames in a row outside a planned hold |
| Short end | the end hold is at most 1.4 s, and the last shot at most a quarter of the film |
| One hero per frame | one thing to look at; two panels only if one is clearly the larger |
| No page chrome | no corner labels, step counters, progress bars, timecodes, a headline block held on screen, text typed out letter by letter, or made-up interface cards |
| Voice matches | the transcript of the render matches the script (§Encode and verify) |

Motion that reads as made by a professional: things arrive by moving, not by fading in; a landing
slows down, a leaving speeds up; most moves last about a third of a second; nothing grows from
zero; cut on motion, and cut often in a short piece.

### Characters and world

Decide the world before any scene, because changing it later re-makes every scene.

- **A look sheet:** one ground, one light, one texture, one type system, a few colours. Every scene is
  checked against it.
- **The cast, locked:** each recurring character as a sheet in several views (front, three-quarter,
  side, a few expressions), clothes named, approved before any scene. Each scene is made from the sheet
  as its reference, never from a fresh prompt (`generation.md` §Consistency).
- **Places as plates:** one still per location, then edits of that still for light or time of day.
- **A reference map** beside every generation: which input stands for what (this image is the
  character, this one the room, this one the light), so a model does not mix them up.
- **Block it before paying for it:** grey shapes for the camera and timing (step 6) before any paid
  video model, so a paid take only adds the look.
- **Real people are not cast.** A real person appears as themselves, in their own photos and footage,
  and is never redrawn, animated or voiced without their consent (SKILL rule 3, `real-people.md`).
  Real products are recorded, never drawn (§Showing a real product).

### Presets

| Kind | What changes | Read |
|---|---|---|
| Teaching reel | 20 to 45 s, one method in two to four visible steps, narrated, the method repeated in the caption | §Short educational reel |
| Product demo or launch | every product frame is the real product, magnified; 15 to 55 s | §Showing a real product |
| Ad | many hooks on one body; vary one thing at a time | `copy.md`, `channels.md` |
| Memory film | the person's own photos as they are, no narrator by default, the telling sets the order; no cast and no generated people | §Cut craft, `real-people.md` |

## Rendering

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

## Short educational reel (teaching, 20 to 45 s)

A reel that teaches one method. It is the format people save and send on, and the one most easily made
badly: a post's text typed out in motion, with no voice, nothing taught and no hook, is not this format.

- **Hook in the first 2 s, three parts** (`copy.md` §3, *context, pull, turn*): say what it is about,
  then a pull, then the turn. The pull is one of four: **taboo** (slightly uncomfortable to say aloud),
  **dark** (something hidden happening to the viewer), **contradiction** (against what they believe),
  **proof** (a real number shown). The first picture shows what the first words say. Check it against
  the four S's: the **subject** is clear, the **stakes** are clear, the words are **simple**, the
  sentences **short**. Read the hook alone: if a stranger can't say what the reel is about, rewrite it.
- **Hook shapes that suit teaching** (the ones saved most often in how-to niches; pick one, write at
  least five hooks across shapes, choose one):
  - *Diagnosis:* "Your squats are just knee bends." / "It's not your back. It's your hips." Names the viewer's
    mistake, then teaches the fix.
  - *The one everyone gets wrong:* "Three steps. Number 3 is the one everyone gets wrong." Holds them
    to the end.
  - *Prerequisites:* "Don't try X until you can do these 5 things." The list is the lesson.
  - *In order:* "6 steps, in this order. Don't skip one." A progression the viewer follows.
  - *Fixed-length series:* "X in 30 seconds." The title promises the length and makes a series.
  - *Ladder:* "Level 1 to level 4. Which one are you on?" The viewer places themselves and comments.
  - *Hindsight:* "Twenty years in. Here's what I wish I'd known in year one." Earned authority, then rules.
  - *Attention triggers* (`copy.md` §3) in the line right after the hook: a big result in little time,
    a specific number, a person the viewer wants to be like.
- **Teaching shapes:** a *wrong way, then right way* (❌ then ✅, the same move shown both ways) teaches
  without a word and works muted; a *one problem, the obvious fix, why it breaks, what works* shape
  suits a method for managers and teams; *application* (the method shown working on a real case or a
  live build) beats a list with no opinion (`copy.md` §4).
- **One method, two to four steps you can see.** Name the method early. Each step is drawn while it is
  said: the checklist appears as "write it all down" is spoken, each box ticks as its item is
  named. A step only written on screen, or only spoken, teaches half.
- **Narration carries it.** The person's own recorded voice first. Otherwise a licensed narrator
  (`audio.md`), with every first-person line ("I did this with ten clients") moved to on-screen text with
  the person's name, because a hired voice saying "I" is speaking for them. A clone of the person's
  own voice only with their consent, labelled as a clone (`real-people.md`); never anyone else's. A
  request for animation is not a request for silence (`audio.md`).
- **Proof from the person's own numbers and cases**, said and shown: a real count, a real before and
  after. Never an invented number for effect (SKILL rule 1).
- **Pay the promise before 80%** of the runtime; then one line that turns it into the viewer's next
  step. No recap.
- **Captions word by word**, bold, on screen while each word is spoken, at about 5 to 10 words a
  second (§Captions). Most viewers start muted: the hook, the steps and the payoff must read without
  sound.
- **The method again in the post's caption**, as the steps in a short list, so the reel is worth
  saving.
- **End on one ask**: try it once, comment one word, follow for the next step. One, never three. A save
  ask carries a reason to come back ("save it for the next time you…"); a share ask names one person
  ("send it to the one on your team who…"). A comment keyword that sends a free guide is a funnel the
  person must have set up and approved; never promise a DM nobody will send.
- **Make it a series when it works:** the same title shape, length and look each time (`copy.md` §7),
  so one hit becomes a format.

**Build it as a timeline keyed to the voice.** Each beat is one line of narration and the animation
that goes with it; a beat's start is where its line starts, measured from the take (`audio.md`, word
timings), never a fixed number of seconds. Then re-recording in the person's voice re-times every
animation without touching the drawing. A shape that has worked: the script as beats (`id`, `say`,
what is drawn), one voice take per beat, measured durations in a timing file, a page that draws any
moment `t` from the beats (code-drawn shapes, real screenshots, the person's numbers), rendered frame
by frame in headless Chrome into ffmpeg with the voice and a quiet bed, loudness to -14 LUFS, then
transcribed back and compared with the script (§Encode and verify).

**Before the gallery, check it against the person's saved examples** when they keep any (SKILL step 2):
does the first second do what the reels they saved do? Say which of their saves it borrows the form of.

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
