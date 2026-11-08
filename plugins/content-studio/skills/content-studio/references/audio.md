# Voice, narration, music and sound

**Measure what you can't hear.** An agent can't listen, so every take is checked by numbers:
transcription against the script, words per second, pitch at line ends, loudness. A person must still
listen before a voice or a bed becomes a default; a choice made on numbers alone is provisional.

## Narration: whether to use one at all

- **For personal and family content: no narrator by default.** A synthetic voice telling someone's own
  memories reads as creepy, and it is easily in the wrong language. The person's own recorded words are
  the voice. Otherwise use on-screen text, or ask them to record a 20 s line. A narrator is a style
  someone chooses on purpose (a mock documentary, for fun).
- **For product, teaching and promo pieces:** a voice-over is fine and often carries the cut. The
  person's own voice beats any synthetic one.

## Engines (as of Nov 2026)

| Engine | Use | Notes |
|---|---|---|
| **MiniMax Speech 2.8 HD** (hosted) | default hosted narrator in any language | zero transcription errors in English, Swedish, Finnish and German, with commercial terms; about $0.03 per 30 s; 10 to 26 s a take; `<#0.5#>` pause markers; `speed 1.12` gives about 3.2 words/s; `emotion: happy` ended rising on 2 of 3 reads |
| **ElevenLabs** (v3, multilingual v2) | most expressive; good in English, Swedish, German | **the free tier is non-commercial and needs attribution**, so business use needs a paid plan; v3 reads slowly (2.3 to 2.5 words/s, so speed it up) and differently every call |
| **Qwen3-TTS 1.7B** (local, Apache-2.0) | free English and German, sounds really good | about real time on an Apple Silicon Mac, 4 to 5 GB; no Swedish or Finnish; a designed voice ignores gender (asked for male, got 208 Hz), so measure pitch before accepting |
| **Kokoro 82M** (local, Apache-2.0) | free English promo voice-over | 4× real time, ONNX on Windows; flattest, runs sentences together; its English front-end pulls in GPL espeak-ng (a bundling question) |
| Chatterbox (MIT) | cloning only | English into Finnish failed (84% word error rate) |
| Out | OmniVoice (non-commercial weights; Nordic voices sound American), Apple system voices (personal licence only), Piper (GPL engine, robotic), Voxtral, F5, XTTS (non-commercial), Ming (artefacts, wrong gender) | |

No local engine with a commercial licence passed Finnish (Nov 2026); hosted MiniMax, or ElevenLabs on a
paid plan, is the clean path for Nordic languages.

Engine traps (Aug to Oct 2026):
- **ElevenLabs v3 reads the same text differently on every call,** including a rising end on a
  statement (+2.2 semitones on one take, −3.1 on a plain re-read of the identical text). Generate several
  readings and keep one that falls, then pin that file in the edit, or a cache keyed on (voice, text)
  hands back whichever reading it got first.
- **On ElevenLabs v3 through Replicate, audio tags (`[confident]`) are spoken as words,** and one
  swallowed the words after it. Steer with `previous_text`, `stability` and re-reads. About $0.10 per
  1,000 characters.
- **Numbers are where voices fail:** one of three voices read "154" as "100 feet 4". Transcribe every take.
- ElevenLabs' free plan refuses voice design through the API. Gemini TTS takes a plain-language
  description in the prompt plus a prebuilt voice.
- Plain-language style controls exist on some engines (Qwen3-TTS `style_instruction`, "like an excited
  sports commentator"; MiniMax `emotion`; Chatterbox `exaggeration` and `cfg_weight`).

## Pace and energy

Measure words per second; "too slow" is the commonest note and it is a number. Engine defaults sit at
narration pace (MiniMax default 2.65 words/s; at `speed 1.35`, 4.22; Chatterbox 3.18; Qwen3-TTS 2.87;
Aug 2026). Live sports commentary runs about 3.5 to 5. **Speed is not energy:** a fast flat read is worse
than a slow one. Reach for `speed` first, then for a style or emotion control.

## What sounds machine-made

- **A narrow pitch range** (6 to 9 semitones against 11 to 14 for expressive voices).
- **Rising line ends,** which sound like questions. **Re-read the line; don't rewrite the script.**
  Measure the tail pitch (a negative slope means it falls). A leading "And" tells the speaker more is
  coming: removing it took one line from +1.3 to −7.5 semitones.
- **Metronomic gaps** between sentences. Set pauses per line.
- **Accent bleed** when cloning across languages.
- **A dropped word that changes the meaning,** so transcribe every take.
- Punctuation is a timing control: the same sentence measured 4.30 s with a full stop and 3.70 s with a
  dash, and a vocative comma before a name cost 0.33 s. Apply it one line at a time by ear and don't sweep
  it: the pause is wrong where a name interrupts a clause and right where it hands over a turn.

**Measuring delivery.** Estimate f0 by autocorrelation per 40 ms frame over 70 to 330 Hz, voiced frames
only, and report four numbers: the **tail** (the last ~350 ms in semitones against the line's median;
negative falls), the **median** (how high the line sits; this is excitement), the **range** (10th to 90th
percentile) and the loudness spread. A line called passive already had the widest range in its film; its
median was low (119 Hz), and `emotion: surprised` on the same words gave 132 Hz. So a style or emotion
control is the lever for energy and the median confirms it landed. This ranks takes of one sentence; it
can't hear warmth, and a line can measure well and still be wrong.

## Verifying speech

- Transcribe every take with whisper large-v3-turbo (mlx-whisper on a Mac, about 3 to 6 s per 30 s;
  whisper.cpp or faster-whisper elsewhere). Aim for a word error rate of 0 against the script.
- **Pass the people's names and odd words as the initial prompt.** Without them, "Mira's asleep" came
  back "mirrors asleep".
- Pace: 3.1 to 3.3 words/s is promo pace, 2.3 to 2.8 is narration, and 3.9 is rushed.
- **Whisper invents speech over music** (credits that were never there, loops over music-only tails)
  and can't check sung words. Clip to the speech, or separate stems first.
- Transcribe the **finished mix** again, not only the voice stem.
- Dialogue a video model generated is checked the same way: extract the audio
  (`ffmpeg -i shot.mp4 -vn -ac 1 -ar 16000 a.wav`), transcribe, and diff against the prompt's lines.

## Music

- **Local: ACE-Step 1.5** (MIT, outputs usable commercially). About a 10 GB download; 20 to 60 s a
  track; hits the asked length and tempo and the quiet-intro-then-band arc. Turn on its "thinking"
  model for lyrics. Its endings are cut, not composed, so fade the last 1.6 s. Reject takes that end
  early or have a hole mid-song.
- **Hosted:** MiniMax Music 2.5 (about $0.15, sings lyrics word for word); Lyria 2 (about $0.06,
  instrumental, always 32.8 s, flat); ElevenLabs Music (about $0.58 for 70 s, pleasant, generic); Suno
  through third-party APIs has a real arrangement but an unclear rights chain. Every hosted model
  ignored "drums enter after the intro". MusicGen weights are non-commercial.
- Tempo by cut: social about 104 bpm, product 110, scrapbook 92, calm 84. Choose music by what the
  piece is ("day in the life", "emotional"), never "motivational".
- The person's own track beats any generated one, if they have the rights to it.
- Beat detection misreads fingerpicked triplets and finds nothing in some generated beds. Check the
  number against the ear or the tempo you asked for.

## Sound effects

A generated sound needs an ear before it gets a level: four effects measured to a tenth of a decibel,
and three were rejected on the first listen ("too violent", "a weird breath"). A level says whether a
sound will sit in the mix, never whether it is the sound you asked for. **Build the way to hear it
before wiring it in:** a short sampler, each sound for five seconds behind a card naming it, at its mix
level. Ask what a model does with a class of request: two "moving air" sounds both came back breathy,
and two rejections of the same shape are a property of the generator, not of a prompt.
Put a sound on a visible action, peaking one frame after the picture. Some models pad every output
to a fixed length with silence and don't put the content first (`stable-audio-open` returns 47.6 s
whatever length is asked), so read the RMS envelope before trimming, or the trim grabs padding. **A rule
about a model's output applies to every file it made,** including those already in the cut: a 30 s bed
from the same model went silent for a third of a film when it was laid as one span.

## Mixing and loudness

- Voice in at about 0.5 s; bed ducked under the voice with `sidechaincompress` (about 12 dB for promo,
  8 to 11 dB for a quiet film; attack 0.5 s, release 0.8 s). The bed must be at least as long as the
  mix.
- **Loudness:** −14 LUFS integrated for social, −16 to −18 for a quiet film, true peak −1.5 dBTP:
  `loudnorm=I=-14:TP=-1.5:LRA=11`, AAC 192k, 48 kHz.
- Measure level in one-second windows at several timecodes, not with `volumedetect` (it reports the
  peak and hides a silent passage). `amix` divides by the number of inputs unless `normalize=0`: six
  lines on one bed came out about 14 dB quiet while the peak still read fine. Use a `qsin` (equal-power)
  crossfade between different material; a linear `tri` one dips 3 dB at the midpoint and is for a splice
  of the same material.
- **Not every measured gap is a defect.** Four time cards measured 25 dB below the film, and that
  silence was the editorial beat that made "fifteen minutes later" read; three fixes for it were
  rejected. Before repairing something in a piece already approved, ask whether it is load-bearing.
  Moving a per-scene element to the master also lays it under every segment that had none: list them
  before the move. When a fix is rejected twice, re-read the original note as a verdict on the first
  attempt.

## Reviewing voices

Four or five candidates per language, **the same script**, one player each, the voice's name visible
while it plays, loudness-matched (about −18 LUFS ± 1.5), and the voice heard **without** the bed first.
Filter first by hard rules (speaks the language, licence fits the use, error rate at most 5%, no known
artefact), then show the rest under "more voices". A pick records the candidates shown beside it,
because "chose George over MiniMax and Alice" teaches more than "chose George".

## Cloning a voice

Only with the owner's own consent, verified live, purpose-bound and revocable. Never a child's voice,
and never new words in a dead person's voice. The full rules are in `real-people.md`.

**A synthetic speaker generated on camera** can be carried into later shots by cloning their voice out
of the take: cut 3 to 4 s of one speaker and give it to a cloning engine as the reference (Chatterbox
`audio_prompt` takes a data URI; MiniMax has voice cloning). Two generated commentators, each cloned from
about 3.4 s of their own dialogue, said new lines correctly.
- **Find the hand-off by a relative dip, not `silencedetect`.** Generated takes carry room tone, so the
  gap never falls below an absolute floor and the detector reports one speech run, which also looks like
  a correct single-speaker take. Measure loudness in 0.2 s windows and take the quietest window mid-clip
  (one measured −45.5 dB against a −26.3 dB speaking median). Print the split and both reference
  windows, and warn when the dip is under about 8 dB, because then the lines ran together. Cutting the
  wrong side clones the wrong person, and it sounds like a perfectly working clone.
- **A clone inherits its reference's tempo:** two takes of one prompt gave about 4.2 and about 3.1
  words/s from the same lines, so picking the reference take picks the pace of every line. Measure it
  rather than forcing pace afterwards, which reads fast and flat.
