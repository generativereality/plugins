# Stills: thumbnails, covers, carousels, lead images, collages

**Code sets the words, AI makes pictures and decoration, and no generative model touches a real photo
it isn't explicitly restoring.** That rule decides most of this file. Every model asked to "arrange" or
"restore" photos redrew faces a little. Every current model spells a headline correctly, so the
reason to set type in code isn't spelling: one word can change without re-rolling the picture, and
the brand stays exact.

## The idea comes from the subject

Seven image models answered one thumbnail brief with the same layout (condensed headline left, phone
in hand right). The only thumbnail that looked designed was built from the product's own output: a
transcript with its filler words struck out. **The sameness is the slop.** Start from something real
and specific to the subject: its own output, its own screen, a real photo, a real number. Write
the idea down before opening any tool.

## Recipe A: layout in code (the default)

1. One `brand.css` with tokens and fonts. Bundle OFL fonts locally, with no font CDN at render. **Never
   name a font family `Serif` or `Sans`**: unquoted, those are CSS generic keywords and Chrome silently
   draws Times. Give custom families unique names.
2. One HTML file per frame, sized exactly to the output.
3. Render with headless Chrome: `scripts/render-frames.sh <out-dir> <w> <h> <frame.html>…`. It uses the
   installed Chrome or Chromium, at 0.1 to 1 s a frame, and runs the same on Windows.
4. Gate: contrast and anti-slop (`npx impeccable detect <folder>` caught a real 3.2:1 grey), then
   **open every PNG and look**. Faults found only by looking: a title on a busy patch, a note behind a
   print, a cropped footer, a caption box over the screenshot, an accent dot vanishing on an
   accent-coloured slide.
5. Measure margins in code rather than by eye; uneven ones (71/61/61/52 px) read as sloppy.

Without a browser (a server, a Worker), use Satori with resvg (MPL-2.0, fine to bundle). It needs static
TTF fonts, an explicit width on every text box (or text won't wrap), and footers pinned with absolute
positioning.

## Recipe B: a generated background under typeset text

Ask the model for the picture only, and end the prompt with *"No printed matter, no writing, no labels,
no logos"*. Local models write gibberish on any paper or sign in the scene without it. Then use the
image as the CSS background in recipe A. See `generation.md` for models.

## Carousels

- Slide 1 carries the hook; each later slide is one item with its proof; the last slide is the next
  step. A list that overflows the screen gets saved.
- **Model-drawn carousels:** make slide 1, then pass it as the reference image for slides 2 to 5 with
  *"use the attached slide 1 as the exact design system"*, in parallel. Ask for 2K, because 1K returns
  928 × 1152, below Instagram's 1080 × 1350. One run of five cost $0.17 and took about 30 s (Nov 2026).
  The output is a flat bitmap, so a typo fix is a re-roll and the re-roll will differ. Prefer recipe A
  for anything with text that may change.

## Lead images of a real product

Use a real screenshot or a real recording frame, framed and captioned in code. Never mock up a screen,
and never let a model "improve" one. If the screenshot shows a stale or wrong state (another brand's
name in the header, a debug banner), get a new one; don't paint over it. Blur real people's names
in it. Test the image at the size the feed shows it (often about 400 px wide on a phone).

## Collage (the "paper reel")

A layout of 3 to 8 pictures on a generated paper, as a still and as a 5 to 10 s film. People find it
very shareable.
1. **Paper,** one per output size. Prompt: *"decorations only along the outer 12% of the frame; the
   whole centre plain, evenly lit; top-down; no photos, screens, text, people or hands"*. A hosted model
   at 2K costs about $0.05 and takes about 30 s; a local one is free but slower, with a less clean
   centre (put the title on a card). **The paper's mood is the choice**, and the layout follows it.
2. **Spec:** theme (notebook, desk, cork, scrapbook, album, journal), layout (scatter for many photos,
   grid for calm, hero with satellites, timeline for dates), motion (drop, fade or slide in; camera
   drift, push or pan).
3. **Layout in code:** take a decoration mask from the paper; detect faces (YuNet, MIT) so no crop cuts
   one; seed and score placements against decoration and overlap; put notes where they cover nothing
   and the title in the least decorated spot. Make the still from the end state, not the last frame
   of a camera move. Step the film frame by frame into ffmpeg.
4. **Accept only if** no face is cut, the title and prints overlap decoration by less than about 15%,
   you have looked at the still, and the film decodes.
5. A person's own photos are never altered and never sent to a hosted model without their yes. Make
   the paper locally or reuse one.

Faults seen: a still taken from a zoomed last frame crops the margins; strings or arrows drawn across
interface text make it unreadable; the hero print got buried under the others until grid cells fixed
it. Feeding all the photos into an image model to "arrange" them redrew every face.

## Thumbnails

Note the conventions of the outliers in the niche (colour, amount of text, face or no face,
composition) and decide on purpose. The title and the thumbnail are one promise, so don't repeat the
title in the image. Text readable at phone size. Make two or three that differ in idea, not in colour,
and let YouTube's Test & Compare decide, not taste.

## Covers

A cover makes someone stop and feel the claim. An illustration that carries the argument beats a data
chart; charts belong in the body as evidence. For a personal album or keepsake, the person's untouched
photo with a well-set title is usually the one to use. A painted version made from it is a separate,
labelled option.

## Restoring an old photo (a person's own, at their request)

- **Most faithful:** a top hosted editor with *"Do not change any face, expression or pose"* (Nano
  Banana Pro, about $0.15 at 2K, Nov 2026). **Best value:** Nano Banana 2.1 at 2K, about $0.05 (it slightly
  enlarged a child's eyes). **Best free:** a local FLUX 3 Klein edit, then Real-ESRGAN.
- **Always compare original and result side by side at the faces** before accepting.
- **Upscale only after cleaning:** Real-ESRGAN on a raw scan sharpens the scratches as detail.
- **Colourising invents facts** (eye and hair colour). Offer it as a separate, labelled version, never in
  place of the original.
- Don't use: GPT Image (reframed the photo and redrew two new children), Kontext's restore app
  (colourised unasked, with modern faces), GFPGAN and CodeFormer (kept every scratch and put blue eyes
  into a black-and-white photo; CodeFormer is also non-commercial), OpenCV inpainting (faces to mush).

## Fixing a bad generated detail

Remove the object rather than asking for a repair. A backwards hand was fixed by *"lying on the
surface, no hands"*. Asking a model to repair the hand kept it backwards and re-laid out the whole image.
