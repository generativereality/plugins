# Voice: the person's words, and prose that doesn't read as machine-made

Readers now assume low-effort text is machine-made and trust it less. Merriam-Webster's word of 2025
was *slop*. In a 2025 survey of 3,000 US adults, trust in a piece fell by nearly half when people
believed AI made it, whether or not it did (Raptive). Some places ban generated text outright (Hacker
News). So voice is the first craft problem, not the last polish.

## 1. The person's material first

Before the first draft of anything published under someone's name:

1. **Ask for their material, not the copy.** One question with no draft attached, built from what you
   found: *"What did you think when you saw the first real sign-up?"*, *"Which of these three threads
   would you actually reply to, and what would you say?"*. Never *"what should the post say?"*. Say a
   spoken answer is welcome and that a minute is enough.
2. **Build from their answer.** Keep their phrases, their order of telling and their opinion. Cut and
   arrange; don't paraphrase into smoother words. On the review page, mark which lines are theirs.
3. **Look for their written voice.** Their published posts, a voice notes file, their lessons from
   earlier picks, and any voice skill they keep for themselves. Read those before writing, and follow
   them over this file wherever they differ.
4. **Name the sources** of the person's material beside the draft (which answer, which memo, which
   earlier post), so the next version can go back to them.

A piece the person didn't shape isn't ready for review, however well it scores.

## 2. The critique is new material {#critique}

When the person says it sounds like AI, misses the point, or asks how this is good, **do not reword
the same draft**. Answer their question honestly (including *"it isn't, and here is why"*), ask what is
off and what they would say instead, and rebuild from their reply. After a piece has been sent back
once, offer two or three one-line directions or ask for their dictation; don't write another full
draft on your own.

## 3. The tells

Machine drafts perform emotion instead of expressing thought: they build suspense, stage reveals and
punch up clauses, where a person talks through a thought and lets the content be the drama. Each of
these tells has killed a real draft. Rewrite the sentence; don't just swap a word.

1. **Dramatic fragments and one-line paragraphs.** *"That's not what happened."* *"Free. Local. Yours."*
   Carry the beat inside a full sentence.
2. **Meta-narration.** *"Here's the part that…"*, *"Here is the trap"*, *"Let me explain"*, *"The part
   nobody puts in these posts"*. Do the thing instead of announcing it.
3. **Negative parallelism.** *"Not X. Not Y. Z."*, *"It's not about X, it's about Y"*, and the
   two-sentence version *"X was not the total. It was the spread."* Say what the thing is.
4. **Rule of three.** Triads for rhythm read as machine rhythm. Use two items, four, or a sentence.
5. **Zinger endings.** Paragraphs ending on a quotable punch line. End with the thought completed.
6. **Rhetorical question answered at once.** *"Is it faster? No."* Make it a statement. Real questions
   to the reader are fine.
7. **Em-dash punch-ups.** One dash per paragraph is the tell. Commas, parentheses and colons do the work.
   When you remove a dash, re-read the sentence, because removing the pause can change the meaning
   (*"the ones that were not — in a browser on your own machine"* became a sentence about something
   else). Split the sentence or use a full stop. A dash doing comma or colon work isn't the tell; dashes
   added for emphasis, about one a paragraph, are.
8. **Uniform rhythm.** Every paragraph two to four sentences of the same length. Vary it the way speech
   varies.
9. **Escalation.** Everything world-changing. Plain understatement carries the extraordinary better.
10. **AI vocabulary.** pivotal, delve, tapestry, testament, vibrant, boasts, foster, leverage (as
    filler), landscape, intricate, meticulous, showcase, garner, seamless, unlock, supercharge,
    game-changer, "in today's fast-paced world", "the reality is", and the sincerity tic ("to be
    honest").
11. **Copula avoidance.** *"serves as"*, *"functions as"*, *"marks"*, *"represents"* where *is* would do.
12. **Elegant variation.** Rotating synonyms to avoid repeating a word. People repeat their words.
13. **Trailing -ing clauses** (*"…, highlighting the importance of"*), emoji bullets, a bold lead-in
    on every line, a summary at the end.

What reads as a person: long sentences that carry a whole thought, in speech order, connected with
*and*, *so*, *but*, *because*; concrete names, numbers and what actually happened; the writer's own
uncertainty said plainly; a dry aside; plain descriptive headings; an invitation instead of a call to
action; numbers stated once, precisely, without ceremony.

**Where this applies:** everything published under the person's name, and correspondence sent as them
too (a support request, a reply to a partner), where one staged sentence is a large share of a short
message and the register is plainer still. Release notes count: they drift into feature-marketing
voice, every item a small triumph with a beat at the end. Channels change the register (tighter on a
professional network, more instructional in a course), never the list of tells.

## 4. The sweep, and why it isn't the check

Run `scripts/voice-sweep.sh <file>` over every text before review. It counts em dashes against
paragraphs, lists short fragments, and finds the banned phrases and the commonest negative-parallel
shapes. It is a net with known holes. Pages have gone out passing every grep while carrying two tells
in one sentence. A launch post sent back as "way too AI generated" came up almost clean: what gave it
away was its shape (a slogan argued with in the title, tidy labelled sections, a bullet list explaining
itself), which no grep sees. So, after the sweep:

- **Read it aloud as the person.** Would they say this sentence on a call? Rewrite any sentence you
  can picture on a conference slide.
- **Count the shapes no grep finds:** how many paragraphs end on a punchy clause (more than one or two
  means the prose is performing), and whether three paragraphs in a row have the same shape.
- **Three parallel full-length sentences** starting the same way (*"The … you meant to …"* three times)
  are a fragment drumbeat even though each is long.
- **Negative parallelism split by a full stop** (*"X was not the total. It was the spread."*) and the
  bare *"What it is missing is not A. It is B, C and D"* slip past comma patterns; the sweep has a line
  for the first shape, and reading catches the rest.

The fragment list is candidates, not verdicts: brand names with a dot and abbreviations come back as
false positives, and a short fragment is sometimes right (a deliberate two-word line in an approved
hero). On `.svelte`, `.ts` or `.html` files the sweep skips comments, so a dash in a code comment doesn't
count as one in the copy.

## 5. A document is not a log of itself

A post, page or guide reads as if written this morning by one author who knew everything in it. No
*"updated on…"*, *"this section used to say…"*, no editor's notes. A date that says how old a fact
is ("prices as read on 3 November") is a property of the fact and stays. A date that says when the
text was edited goes.

This holds for any document meant to be read through, internal plans and review packs included, not
only published prose. Most self-history wraps a warning a first-time reader needs, because they would
make the same wrong inference: **keep the correction, drop the autobiography.** Re-aim it from the
document's past to the reader (*"What this does not mean: X is not solved"*, not *"this section said X
was solved for a few hours"*). The one exception is an agent-facing operations file, which may name a
wrong version that escaped into other docs or habits, because someone may still hold it; if nobody does,
it is autobiography there too.
