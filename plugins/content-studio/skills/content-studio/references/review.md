# The pick: showing work so a person can choose

The pick is where most studio work has failed: not because the work was bad, but because the
person could not choose between options. They couldn't open the page where they were, they couldn't
tell the samples apart, or they were asked to assemble a combination. A review page is part of the
product.

## One best, then a few real alternatives

- **Lead with your recommendation, finished.** The first thing on the page is the version you would
  post, complete (title, body, image, first comment, everything), ready to approve as it is.
- **Then two or three alternatives**, each one also complete, and each different in **angle or
  format**, not in wording. One line under each says how it differs and when it would be the better
  choice.
- **Never a parts menu.** A page of 19 titles, 5 bodies and 4 images asked one person to compose about
  380 combinations. They answered by asking whether it was a bug. If the titles matter, show the best
  title on the recommended version and list three alternative titles beneath it, no more.
- **Keep the variations, out of the way.** All the hooks and angles you tried can go at the bottom
  under a plain heading, for anyone who wants to look. The decision must not depend on reading them.

## Make it reviewable where the person is

- **It opens on a phone.** Use the review mechanism the project has (a card with a review page, a
  shared document, an artifact link). A local file path opens nowhere but on the machine that has it.
  Put the full clickable link in the message.
- **Size:** each image under about 1.5 MB, and the whole page under about 6 MB, or phones drop it. Use
  stills and short clips. Never embed a full-resolution master.
- **Label every sample** with what it is, the tool or model that made it, what it cost and how long it
  took. Unlabelled samples cannot be judged: a reviewer who couldn't tell which voice was which in a
  concatenated sampler could review none of them.
- **Side by side** for anything compared (two cuts, two thumbnails, before and after). **One player per
  voice or clip**, never one long file with all the takes.
- **Show it as it will be seen:** a feed image at feed size, a vertical clip in a phone frame, a title
  as it will look in the feed, with the first line of the body under it.
- **Numbered lists render as lists**, and verdicts and notes stay separate from the work itself.

## Reviewing generated media: board, shoot, review

- **Board before shoot.** No paid clip before the board is approved (`generation.md`).
- **Re-render the review after every shoot**, including a small one, before reporting. A take nobody
  has watched isn't a deliverable.
- **One review doc for the production, not one per round.** Retire superseded material out of it and
  leave a short ledger of what went and why, so nothing is re-shot by accident; with two docs, the
  person reads whichever they opened last.
- **Say what is wrong with each take in the doc, beside it.** The faults found are the review's output;
  the clips are the evidence.
- **Import the prompts from the generation script; never retype them.** Guard the script's run loop
  behind `main()` so the review builder can import its job table. A doc that claimed to extract its
  prompts while carrying a hand-pasted copy drifted.
- Keep the markdown body as the source and let a build step embed the clips. Stage web-sized copies
  somewhere persistent beside the takes, never `/tmp` (one staging folder was wiped mid-project).
  Transcode small first (about 854 px wide, CRF 27).
- With a markdown renderer, wrap a `<video>` in a `<figure>` on **one line**: `<video>` isn't a CommonMark
  block tag and `<figure>` is, and a newline inside the figure leaks the rest as escaped text.
- With `review-md` (`tools.md`): media needs `--allow-html` and `media-src 'self' file:` in the CSP, or
  the players look normal and refuse every clip. Confirm in the tab by loading each element
  (`x.load()`, then `x.error`), not by the player being visible. Heading ids carry no section number, so
  list them before linking (`[...document.querySelectorAll("h2")].map(h=>h.id)`), and add `?v=N` to
  reload a re-rendered file the browser has cached.
- **Verify the render, not its exit code:** count the missing-clip markers the builder writes (it
  should write a visible one, never a gap), count `<video>` tags, grep for `&lt;figure` leaks, then open
  it. **Prove an embed is current by hashing it,** not by mtime and not by opening a heavy page (evals
  timed out on a 13 MB render): decode every `data:` payload, hash it, and match it to the current files;
  one that matches nothing is stale. When the change under review is to the sound or grade, also measure
  the embedded clip, because a current file can still be the cut before the fix.

## The question

One question, one line: *"Post the recommended version?"*. Offer up to three one-tap answers that are
real answers (*"Post it as is"*, *"Use alternative B"*, *"Shorter"*). Always leave a free answer, and
always a way to say it is wrong, which is not one of the buttons.

## After the answer

- Write the pick or the no, with the person's reason in their own words, into the lessons file.
- A reason like "sounds like AI" or "not good enough" is new material, not a request to polish: ask
  what is off and what they would say instead (`voice.md` §critique).
- A preference is one person's taste, and a fault they saw or heard (choppy motion, a wrong accent, a
  face that changed) rules a tool out for everyone. Record which kind it was.
- If they pick, make that version well. Don't ask again about what they have already decided.
