---
name: content-studio
description: Read first whenever anything is to be made for people to read, watch or hear - a post, thread, article, newsletter, page, guide, listing, launch, ad, email to many, script, video, reel, short, demo, explainer, clip, carousel, thumbnail, cover, image, collage, narration, voice-over, podcast segment, music bed, or a memory film of someone's photos - for brand building, audience building, teaching, product work or personal sharing. Holds the whole production process (brief, variations, one best version shown for a pick, making it well in each medium, checks, learning from picks and results) and routes to the craft and tool references for copy, voice, channels, search, stills, generated images and video, editing, animation, audio and real people's photos. Use also for "make this better", "make it less boring", "sounds like AI", "which should I post", hooks, scripts, content ideas or a content calendar.
---

# content-studio: making content well

This skill is how to make content well, in any medium and for any purpose. It covers what a small,
good studio does between "we need a post / a clip / a page" and a finished file that someone is glad
to have read, watched or heard. Read this file first and keep to its process. The references hold the
craft and the tools for each medium; load only the ones the brief needs.

**What this skill decides and what it doesn't.** It decides **how to make** the piece. **What to
say, to whom, through which channel and why now** (positioning, the offer, which bet, whether to post
at all) belong to the person and to whatever strategy or growth skill sent the brief. When such a
skill exists in this project, its decisions are inputs to the brief here. Do not overrule them; do
raise a doubt about them in the brief.

## The rules under everything

1. **Facts are strict, craft is free.** A claim about a product, a number, a person, a customer or a
   competitor is true, and you can say where it came from. A hook, an angle, a joke, an analogy, a
   framing, a visual, a title or a sound needs no source; its tests are whether it is true to the
   subject and the person, whether the reader would stop for it, and whether it leads where the brief
   wants. Never invent a number "for illustration", a quote, a testimonial, a user or a result. Never
   show a product doing what it does not do: every picture of a product is the real product (a real
   screenshot or a real recording).
2. **The person's own material comes first.** Anything you write alone reads as machine prose,
   however much craft went into it. The moment, the opinion, the thing that annoyed them, in their
   words, is what makes a piece theirs. Get it before the first draft (`references/voice.md`).
3. **Real people are not raw material.** Never redraw, animate, clone or put words in the mouth of a
   real person without their consent. A person's own photos are shown as they are
   (`references/real-people.md`).
4. **Nothing goes out without the person's yes** for that exact piece, unless they gave a standing
   approval that covers it. You make the piece; you never post, publish, upload, send, comment, buy or
   sign up. Making it ready to post, open in their browser, is fine.
5. **Every paid call is logged with its cost**, inside a budget the person set. Say what each piece cost
   and how long it took. Free and local is the default where the quality is as good; otherwise the best
   tool within the budget (`references/costs-and-licences.md`).

## The process

### 1. Brief

Write one short brief before making anything (`references/brief.md` has the template). It names:

- **the purpose** (brand, audience, teaching, product, personal) and the **one next step** the piece
  should cause, and how you will know it did;
- **the reader**: who they are, where they meet the piece, and how aware they already are;
- **the one idea**, in one sentence that would still hold if everything else were cut;
- **the channel and format**: length, ratio, what the place rewards, its rules and its requirements
  on the account;
- **the proof and material**: the person's own words, real screenshots, real numbers, real photos;
- **the voice**: whose it is, and where their voice notes and lessons are;
- **the budget** in money and time, and what has been sent back before and why.

If a strategy skill sent the brief, keep its fields and add the ones it lacks. Never start making from a
one-line request without writing this down.

### 2. Study what already works

Before writing a word, look at the place it will appear. Find the pieces in that niche and channel that
did 3 to 5 times better than their author's usual. Note their hook form, length, structure and what the
first second or line does, then borrow the **form**, never the content (`references/copy.md` §study).
Write down three to five of them with links. That is the evidence for the angles you choose.

### 3. Variations, then choose the best yourself

Make many cheap variations before making anything well: ten to twenty hooks or titles, three to five
angles (a story, a confession, a contrarian take, a how-to, a before and after, a demo, a list with an
opinion), and two or three formats. Vary the tone as well as the words. Humour is one option and never
the default.

Then **do the choosing yourself**. Pick the best version and finish it to the point where it could
go out as it stands, and pick two or three real alternatives that differ in angle or format, not in
wording. Your job is to bring the person a recommendation, not a parts list.

### 4. The pick

Show the person **one best version, finished, first**, with two or three alternatives below it, on a
review page they can open where they are, which is often a phone (`references/review.md`). Each option
is labelled with what it is, what it cost and how long it took, and comparable things sit side by side.
Never ask them to assemble a combination of numbered parts ("T4 + body B + image 2"). An answer
should take one tap or one sentence.

The person's part is taste, true stories and opinions, never forms. Every no teaches: write the reason
down (step 7).

### 5. Make it well

Make the pick properly, in its medium:

| Making | Read |
|---|---|
| Words: posts, articles, pages, scripts, captions, emails to many | `references/copy.md`, `references/voice.md`, `references/channels.md` |
| A page meant to be found in search or cited by AI assistants | `references/search.md` |
| Stills: thumbnails, covers, carousels, quote cards, collages, lead images | `references/stills.md` |
| A generated picture or clip (background, scene, B-roll, restoration) | `references/generation.md` |
| Video: demos, explainers, reels, launch clips, memory films, edits | `references/video.md` |
| Voice, narration, music, sound | `references/audio.md` |
| Anyone's real photos, face or voice; personal and family content | `references/real-people.md` |
| Which outside tool skill to use, and where this skill overrides it | `references/tools.md` |

Set the words in code and keep them editable. Let AI make pictures, motion and sound. Never let a
model redraw a real person. Captions go on every video, because most people watch without sound.
Every piece carries the link or tag the brief measures it by.

### 6. Check before anyone sees it

Each reference ends with its own checks. The ones that apply to every piece:

- **Facts:** every claim has its source written down beside the draft, and nothing is invented.
- **Voice:** run `scripts/voice-sweep.sh` over the text, then read it aloud as the person would say
  it. The grep is a net with holes; the reading is the check (`references/voice.md`).
- **Look and listen:** open every image, every frame sheet and every clip. Transcribe every voice track
  back and compare it with the script. A green exit code means nothing until a human or an agent has
  actually looked or listened.
- **The reader's test:** read it cold, as the brief's reader meeting it in that channel. Would they
  stop, understand the one idea in a sentence, and know the next step? (`references/copy.md` §check).
- **The place's rules:** length, format, sizes, and the community's own rules and account requirements
  (`references/channels.md`).

Fix what fails and check again. Doubts about craft get fixed, never handed to the person as a question.

### 7. Learn

Write each pick and each refusal, with the person's reason in their words, into the lessons file the
brief names (a studio's `lessons.md`, or the project's house style). Once results come in, write the
winning **formula**, not the piece, into the house style for that channel (for example *"a confession
title, a 150-word body with one real screenshot, a closing question"*). The next brief starts by reading
both. A piece that flops teaches as much as one that works: note whether it was the hook, the topic or
the angle (`references/copy.md` §ceilings).

## Where work lives

Keep the brief, the variations, every take, the review page, the spend log and the lessons together
in one folder per piece. When a project already has a studio or content folder, use that and say
where it is. **Never overwrite a take that cost money**: a new attempt is a new file. Keep media out of
git unless the project says otherwise, and record each asset's licence and where it came from beside it.

## Never

- Make one version and ask whether it is good; or make twenty and ask the person to choose among them
  all.
- Post, publish, upload, send, comment, sign up or buy.
- Invent a fact, a number, a quote, a user or a result, or show a product doing what it does not.
- Use a real person's face, voice, words or work without their consent.
- Redraft a piece the person sent back by polishing the same text. Ask what is off, then rebuild from
  their answer (`references/voice.md` §critique).
- Spend past the budget. When you reach it, stop and say so.
