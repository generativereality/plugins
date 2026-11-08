# Costs, licences, disk, local or hosted, Windows

## Budget and the spend log

- Work inside a budget the person set, in money and time. When you reach it, stop and say so. Running
  past it "because it was nearly done" is still over budget.
- Log every paid call (`scripts/spend.mjs add …`) with the model, settings, cost, wall time and output
  file, and report the total per piece (`scripts/spend.mjs total`). Show the person what each sample
  cost and how long it took. Some tool skills say never to tell the person prices: this skill
  overrides that.
- Typical spends (Nov 2026): a full round of image, video and voice experiments for one area cost $1 to $2.
  A 30 s product clip with three generated shots cost $1 to $8 depending on the model. Generation was
  about $20 against about $300 of agent tokens in one production, so the agent's own time is usually the
  bigger cost.
- **Budget attempts, not length.** A discarded take costs the same as a kept one; the keep rate in one
  production was 3 of 7.
- Video per second of output (Replicate, read 25 Aug 2026, 1080p unless noted; re-read before boarding):
  Seedance 1.5 Pro $0.026 (720p, silent), Kling 2.5 Turbo Pro $0.07, Veo 3.1 lite $0.08 ($0.05 at
  720p), Runway Gen-4.5 $0.12, Veo 3.1 fast $0.15 ($0.10 at 720p), Kling v3 pro $0.224 ($0.336 with
  audio), Seedance 2.5 $0.23 (720p), Veo 3.1 $0.40. **The spread for the same shot is about 15×, and
  that spread is the budget.**
- Local electricity is small (about €0.0003 an image, €0.01 a local video clip at €0.20/kWh); what
  local costs is wall time and disk.
- Never create an account, start a trial, accept a licence or buy anything on the person's behalf.

## Local or hosted

Local and free by default **where the quality is as good**. Otherwise use the best tool within the
budget. In Nov 2026 on an Apple Silicon Mac with 32 GB or more, these run well locally: FLUX 3 Klein and
Z-Image (images), ACE-Step (music), Qwen3-TTS and Kokoro (voice), and whisper (transcription). Local
video is impractical (10 minutes to over an hour a clip, 70+ GB weights). Hosted wins on video, on
Nordic voices and on images that must hold a design or a cast.

- **macOS kills long GPU jobs while someone uses the screen**
  (`kIOGPUCommandBufferCallbackErrorImpactingInteractivity`). Run long local generation at night, or
  shrink the input.
- Hugging Face downloads stall on xet transfer: `HF_HUB_DISABLE_XET=1 hf download … --max-workers 1`. If
  the client deadlocks, delete the model's `.locks` and `*.incomplete` files and retry. One `--exclude`
  per pattern. Download one model at a time.
- mflux needs `pillow<13`.

## Disk

Check free space before any model download, and stay inside a cap the person agrees (models run from
2 GB to 80 GB each). Install into the project's own folder (venvs, local `node_modules`), not
system-wide. List what can be deleted when you finish. Keep generated media out of git unless the
project says otherwise.

## Licences: what may be used for what

Read the licence on the **model card**, not the GitHub badge. A repository's code licence often
differs from its weights' licence.

| Class | Examples | Meaning |
|---|---|---|
| Apache-2.0, MIT, BSD | HyperFrames, Kokoro, Qwen3-TTS, Chatterbox, ACE-Step, Wan 2.2 weights, Real-ESRGAN, mflux, whisper, YuNet, Playwright, Z-Image Turbo | use, bundle, sell |
| MPL-2.0 | Satori, resvg | bundle; publish only changes to those files |
| Free under a revenue or size limit | FLUX 3 Klein (under US$5M), LTX-2.x (under US$10M ARR), Remotion (up to 3 employees), MiniMax Music 3 local (under US$20M, credit in the UI), Stable Audio (under US$1M) | fine while under it; plan a licence past it |
| GPL, AGPL | Piper's engine, espeak-ng, ComfyUI, OpenMontage | fine as a separate program a person runs on their own content; bundling it makes the product GPL, and AGPL also covers a network service |
| Non-commercial weights | OmniVoice, Voxtral, MusicGen, F5, XTTS, CodeFormer, Qwen-Image-2.1, FLUX.2 dev | private use only, never behind anything sold |
| Free tiers | ElevenLabs free (attribution required), Apple system voices (personal use) | not for anything published for a business |
| Regional | HunyuanVideo (licence excludes the EU, UK and South Korea) | not for companies there |

The outputs of the major hosted models are usable commercially under each provider's terms. Some
carry an invisible watermark (SynthID on Google's). Openly licensed photos, clips and music come with
their licence from the Wikimedia Commons API (CC0, public domain, CC BY, CC BY-SA, attributing BY and
BY-SA) or Openverse. **Record each asset's licence and source beside it.**

## Windows

HyperFrames, Remotion, Playwright, ffmpeg, Kokoro (ONNX), whisper.cpp and Real-ESRGAN run the same on
Windows. MLX models (mflux, mlx-audio, mlx-whisper) are Apple-only. Local image and video models need an
NVIDIA GPU there (ComfyUI or diffusers), so a Windows machine without one uses the hosted models.
Replace Apple's Vision with an ONNX face detector plus OCR text density, and HEIC handling with libheif.
On a smaller machine, make fewer variants and use a pre-made library of music beds.
