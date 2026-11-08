# Generated images and video

The models change monthly. **Read the live price and input schema before every batch.** Treat the
names and numbers here as the shape of the answer, dated. Swapping the hosted model is the cheapest
quality fix there is.

## Calling a hosted model

- **POST, then poll.** Never hold a request open (`Prefer: wait`) for anything long: a dropped
  connection is paid for twice, and on Replicate the output of a dropped prediction can be purged.
  Submit all jobs first, then poll them all, about every 10 s.
- **Read the live schema** (`GET /v1/models/{owner}/{name}`) and grep it for every control you are
  about to describe in words. A schema field such as `camera_fixed` works; the same request written as
  prose in the prompt doesn't.
- **Read the live price** from the model page and check its unit (per image, per second, per 1,000
  images). Replicate's API exposes no price, but each model page embeds its billing table as JSON:
  fetch the page to a file and parse the `"criteria"` / `"prices"` objects (read the file in a heredoc
  script; `python3 -c "…"` lost its inner quotes to bash). **Check every parsed number against its
  unit:** the same parser read one model correctly at $0.04 an image and another as "$3", which was
  per 1,000. A price two orders of magnitude off its neighbour is the tell. Prices are tiered by
  resolution and by audio on or off, so one number per model is wrong by construction, and a rate
  carried in a doc was once half the real one when a shoot was planned on it.
- **Spend is computed, not measured, on Replicate:** there is no billing endpoint, and the predictions
  list 403s intermittently on paging, so a ledger built from it is silently partial. Compute from the
  rate table and say so. OpenRouter returns the real cost per call in `usage.cost`.
- **Log every call:** model, settings, seed, cost, wall time, output file (`scripts/spend.mjs`).
- **Never overwrite a take.** A take that exists has usually been cut against, and re-shooting over it
  pays twice and swaps the file the edit and the review point at (a queued job once landed a second take
  on top of the one a scene was built from; the provider's copy of the first had not yet expired). Skip
  outputs that exist; `--force` writes `<name>-2`. **A cache key must name everything the output depends
  on:** cloned voice-over keyed on the line and not on the reference take kept the wrong voices.
- **Retry a 429 after the server's `retry_after`** and keep looping: low-balance accounts are throttled
  but still finish. Space batch calls a few seconds apart.
- **No silent fallback to a second provider.** A fallback once returned JPEG bytes saved as `.png`;
  a clean failure is better. Output may be a string or a one-item array, so handle both.
- API traps: community models need `POST /v1/predictions` with a version id; the model endpoint returns
  a bare 404 for them although `GET /v1/models/{owner}/{name}` returns 200. A GET without a
  `User-Agent` can be refused with a 403 that reads like a bad token (POSTs pass, curl never sees it).
  The predictions list omits `output`; fetch each prediction. Prediction ids are about 26 characters, and a
  truncated id gives a 404 that looks like a vanished prediction.
- Credentials come from wherever the person keeps them (a keychain entry, an environment variable).
  Ask, never print them, and never paste them into files that get committed. When minting a token in a
  browser, capture it by command substitution straight into the store, never by reading the page into
  the transcript. On macOS a keychain read on a locked login keychain can hang on a prompt nobody can
  answer ("In dark wake, no UI possible"): stop retrying, only a person at the machine fixes it.
- **Hosts:** switching models saves money, switching hosts mostly doesn't (Veo 3.1 and Kling 2.5 cost the
  same on Replicate as first-party, Aug 2026). Move hosts for a model one lacks (query the API, not the
  collection page, which omitted models it serves), lower cold starts (fal.ai) for interactive work, or a
  consumer plan whose included generations beat per-second billing, after checking its terms for
  commercial use and visible watermarks.
- **OpenRouter** (Oct 2026) serves image and video leaders Replicate lacked (MAI-Image, Muse, HeyGen
  Video 1, MiniMax H3): `POST /api/v1/images` is synchronous (base64 in `data[0].b64_json`, references
  as `input_references`), `POST /api/v1/videos` is async (poll, then download `/content`). List a host's
  models with `GET /api/v1/models?output_modalities=image|video|audio`.

## Images: what to reach for (as of Nov 2026)

Image leaderboard (Artificial Analysis, read 24 to 26 Oct 2026): GPT Image 2.5 (~1220 Elo), Nano Banana
2.1 (~1180), MAI-Image 2.6, Grok Imagine 2, Muse, FLUX 3 Image (~1120), Seedream 5 Pro, Qwen-Image 3 Pro.
FLUX Kontext pro (~920, around 78th) and FLUX 1.1 pro (~870, around 90th) look dated: over-processed
"AI portrait".

| Need | Use | Price and time (Nov 2026) |
|---|---|---|
| Default hosted picture; text that must be right; one design across slides; a consistent cast | **Nano Banana 2.1** | $0.034 at 1K, $0.05 at 2K; 17 to 30 s (once 135 s under load) |
| Cheapest | Muse Image ($0.01, 17 s); GPT Image 2.5 at medium quality via OpenRouter ($0.011 to $0.016, 15 to 27 s) | |
| Designed, illustrated look | **Recraft v4** ($0.04, 11 s) | watch hands |
| Restoration, faces changed least | Nano Banana Pro ($0.15 at 2K) | |
| Nothing uploaded | **FLUX 3 Klein locally** (mflux on a Mac with 32 GB+, 2 to 4.5 min an image, 30 GB weights; free under US$5M revenue) | Mac only through MLX; Windows needs an NVIDIA GPU |
| Most photographic local | Z-Image Turbo | ignores colour constraints |

Faults to expect: Nano Banana tends toward an orange-glow "ad" look and over-even lighting, and once
added a second parent unasked. Seedream ignored a colour instruction. Ideogram drew nonsense phone
screens. MAI-Image refuses any scene with a child. Recognisable copyrighted characters were refused by
GPT Image 2.5, Nano Banana 2.1, FLUX 3 Image and Seedream, and drawn by Qwen-Image 3 Pro and FLUX 1.1
pro (Oct 2026); don't make them for anything published.

For a transparent cutout (sprites, props), run a background-remover model on the finished image.
Identity-preserving variations of one character (another outfit, another palette) come from an
editing model given the base image and an edit instruction; plain text-to-image makes a new character
each time.

## Prompting what renders

- **Models render the ordinary well and turn the extraordinary into cliché** ("humanoid robot",
  "figure made of light"). Prompt the room, the light and the action, not the concept. Flat interiors,
  one deadpan figure doing something mundane, two people at a table in available light and a period
  video look (grain hides artefacts) all render reliably; scale effects and invented creatures don't.
  Test a look with cheap stills before paying for video.
- **A negative prompt can't enforce an absence.** Four "closed laptop" takes failed across two model
  families. Remove the object, or describe physical facts instead of states.
- **Props and wardrobe don't arrive reliably; posture and movement do.** Anything that must be seen
  should be an action.
- **Say the age** of any child in the scene, or the model will age them up.
- **Ask for the real number.** An invented "six tabs" was really five, and five looked better (five
  different things, so the beats differed, and a counted number can't be caught out). Find the real
  figure, count or label before it reaches a frame; it is usually one search away.
- **In video, screens and paper in shot come out as gibberish.** Prompt them illegible on purpose
  (angled, defocused, turned away) and composite every readable word afterwards.
- For backgrounds under text, end with *"No printed matter, no writing, no labels, no logos."*

## Consistency across images and shots

- **A cast sheet as the reference image, with the clothes named in the prompt.** Without named clothes,
  local models copy the reference portraits' outfits. GPT Image 2.5, Nano Banana 2.1, FLUX 3 Image,
  Seedream 5 Pro and Muse kept everyone recognisable in a bench of family scenes.
- **Chain the style:** use the first accepted still as the style reference for the next ones.
- **One room across shots is not a prompt problem, and no seed fixes it.** Four separate text-to-video
  takes of "the identical room" gave four rooms, and the same seed with one clause changed gave two (a
  seed reproduces one generation; it carries nothing between them). Generate several shots in one call
  where the model supports it (Kling v3 `multi_prompt`, up to 6 shots; Seedance 2.5, 30 s in one call),
  or chain: one still of the room, edits of that still that change only the light or time, each fed as
  the clip's start image, and start plus last frame where two shots must join.
- **Repair rather than re-roll:** models that take a `reference_video` as a base (Kling omni) edit a
  clip you already paid for in plain language, so a take wrong in one object is a cheap edit, not a
  reject.
- **A locked-off composition holds** (one room stable over ten seconds). A static camera with no
  recurring face is the cheapest reliable shot. Where the schema has `camera_fixed`, set it; the same
  wish written in the prompt and negative prompt is a hope.
- **One recurring face:** use the model's `reference_images` (counts differ by model). Decide this
  before boarding, because it decides the model and the price.
- An on-camera speaker commits you to a voice the video model can't reproduce: it re-rolls the voice on
  every generation, and no seed or id fixes it. Generate the face once, then clone the voice from that
  take (`audio.md`) only if it is a synthetic person, never a real one (`real-people.md`). Decide
  whether anyone speaks on camera before boarding.

## Video: what to reach for (as of Nov 2026)

| Model | Price | Use, and what it does wrong |
|---|---|---|
| **Seedance 1.5 Pro** (image to video) | about $0.026/s silent, $0.052/s with audio at 720p; 5 s ≈ $0.13 at 720p, $0.30 at 1080p | the liveliest and best looking. **Invents things:** an extra person in a group, drips, sprouting leaves; cut to a new shot mid-clip despite `camera_fixed`. Never on anything that must stay true without an invention check |
| **Kling 2.5 Turbo Pro** | about $0.07/s | faithful (kept the right number of people), native 1080p; slower |
| Wan 2.2 i2v fast | about $0.11 a clip | **out for anything shown: choppy, as if 10 to 15 fps** |
| Text to video leaders (read 26 Oct) | Wan 3 $0.05/s, HeyGen Video 1 $0.036/s, MiniMax H3 $0.08/s, Seedance 2.5 $0.23/s, Kling 3 Pro $0.34/s | judge by frames |
| Local (LTX-2.5, Wan 2.2 5B) | free; about 10 min for 10 s, or over an hour a clip, 70+ GB weights | not practical on a laptop |

Controls differ per model, and a model's ceiling is not the medium's (read Aug to Oct 2026; re-read the
schema before boarding, because the newer models were the ones that had grown the controls an older
shoot failed for want of):

| Model | Durations | Sound | Controls worth knowing |
|---|---|---|---|
| Veo 3.1 (and fast, lite) | 4 / 6 / 8 s | yes, with dialogue | `reference_images` 1 to 3; `image` + `last_frame` to join shots |
| Kling 2.5 Turbo Pro | 5 / 10 s | no | start and end image; no seed |
| Kling v3 | 3 to 15 s | yes | `multi_prompt`, up to 6 shots in one call |
| Kling v3 omni | 3 to 15 s | yes | `reference_images` up to 7; `reference_video` as a base to edit a clip |
| Seedance 1.5 Pro | 2 to 12 s | optional | `camera_fixed`, `seed`, first and last frame; 720p only on Replicate |
| Seedance 2.5 | up to 30 s | yes, with dialogue | `reference_images` up to 30, `reference_videos` up to 10, `seed` |

- **Spend on the expensive models only where a face or spoken dialogue has to persist.** A held static
  shot with no face is the commonest thing a board asks for, and the cheapest model does it for about a
  fortieth of the dearest (per-second prices in `costs-and-licences.md`). In one production a single 6 s
  take on the dearest model was a third of the spend for a fourteenth of the footage.
- **One-shot to test a concept, composite to build it.** Veo will one-shot a split screen with spoken
  commentary ($1.20 for 8 s on the fast tier), which answers "does this idea work" in minutes. It can't
  re-roll half a frame, hold one room in both halves, set its own lettering or keep voices across shots;
  compositing separate panes can.
- **Provider overload is not your prompt.** Veo's `high load` failure (`code: 8`) once failed one shot
  eight times in a row while a sibling succeeded. Retry unchanged; don't rewrite the prompt.
- **Check a model is still served** before boarding on it, on the vendor's own deprecations page:
  OpenAI removed Sora 2 and its Videos API on 24 Sep 2026 while a reseller still listed it, and a shot cut
  from a removed model can't be re-rolled.
- **A cheap concept test:** one 8 s Seedance call with audio (about $0.42) made a three-shot ad that
  spoke every scripted line correctly. Its product interface was gibberish and the voice unnatural, so
  it tests an idea and never ships.
- **Budget 3 to 5 attempts a shot.** One production made 7 takes and kept 3, for $7.22. The price spread
  between models for the same shot is about 15×, and that spread is the budget.
- **Board before shooting:** write the shots and get the plan approved, check the schema against every
  rule, make one cheap still per setup, then video. One $7 set made before its board was approved
  returned 3 usable seconds.

## The invention check (for any generated motion near real things)

Review every clip by its frames, not by its first frame. For anything that must stay true: count faces
on about 20 frames against the source; ask a vision model narrow questions (*"any person, figure,
silhouette or animal?"*), not open ones (an open "boats: yes" turned out to mean the cabin the camera
was in); measure camera shift; map where the pixels changed. **Only animate stills whose motion is
obvious and that have no faces** (water, fire, light, sky).

## Generating assets for a product build

When generated images or music ship inside an app or a game, generate them at build time and commit
the output as the offline content. The shipped build then holds the files, never the keys or the
generation code, and makes no network calls for them. If users later generate their own at run time,
that is a separate code path that calls the project's own server, which holds the key; never bundle a
key into a client. Keep one canonical copy of the generated files and let other targets mirror it,
never regenerate per target. Large binaries go through git LFS: commit `.gitattributes` before the
files, and after a fresh clone check the build reads real bytes, not LFS pointers. A chain of
providers (best quality first, a cheaper one, then a free on-device floor) lets a run degrade instead of
failing, chosen by which keys are present and logged per file (this is a planned chain, unlike a
silent fallback); check each level's licence (MusicGen weights are
non-commercial).
