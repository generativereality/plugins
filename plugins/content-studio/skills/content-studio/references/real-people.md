# Real people: photos, faces, voices, and personal content

This applies to anyone's real photos, videos, voice or words, and to personal pieces for family and
friends (a trip, a month, a child's year, a tribute).

## Consent and what leaves the computer

- **A person's own media is shown as it is.** Never redraw, "enhance", animate, age or re-pose a real
  person, and never generate a person into real memories. Restoration is the one exception, and only
  at the owner's request, compared with the original at the faces (`stills.md`).
- **Nothing of a person's goes to a hosted model without a yes for that specific use.** Keep the pixels
  local. An agent can plan a film from text alone (local captions, face boxes, times, places, transcripts),
  and the quality checks can run locally too.
- **Say exactly what is local and what isn't.** Never write "nothing leaves your computer" when an AI
  provider reads anything.
- **Names come only from the person's own tags or words.** Someone tagged nowhere stays unnamed.
- **Never use synthetic faces as evidence of quality.** Generated "family" photos (everyone centred,
  facing the camera, in the same jacket) read as AI-made and say nothing about real material.
- **Real people in demos and posts:** blur names and faces of anyone who hasn't agreed. A customer is
  named only with their consent.

## Cloning a voice

1. Consent from the **voice's owner**, never from whoever uploads the audio. Verify it live (they read
   a random phrase shown on screen).
2. Purpose-bound, revocable, deletable. Treat the voice as biometric data: encrypted, on the device,
   never used for training.
3. An older relative consents in their own voice while alive. After death: only with consent given in
   life or the next of kin's agreement, and only to read words they actually wrote or said. **Never
   invent new statements in a dead person's voice.**
4. **No children's voices.**
5. Label every cloned output, in the piece and in its metadata, and keep the engine's watermark. The EU
   AI Act's disclosure rules (Art. 50) apply from August 2026 (check the regulation's current text).
6. No free-text speech with a cloned voice, rate limits, and never export the voice model.
7. The engine needs a commercial licence for anything published.

## Get the facts right before anything creative

- **Time and place come from the metadata; what is in the picture comes from looking.** A caption
  called a cabin window "a train at sunset"; the data said 07:10, at sea.
- **Compute every count and weekday.** "Three cities" was invented, and the data said five. "Saturday"
  was said for a Sunday.
- **No inferences dressed as facts:** "friends" becomes the tagged names; "sunrise" becomes "at sea"
  when 07:10 was before sunrise; "a new outfit" was said where she only tried one on.
- **Local time comes from the place's time zone,** not the camera's.
- A line never runs over a shot from another time or place.
- **Received photos** (forwarded in a chat) are labelled or left out. A dozen photos stamped the same
  minute with no location are probably someone else's phone, so say so and ask. Generated images found
  in a library stay out.

## Read every trail before asking

Before asking the person anything, read everything available (tags, notes, messages, the calendar,
memos, the work log) and say what you read. Then look for gaps: lay out each day's photos by hour,
mark waking-hours gaps of two hours or more, and mark which are explained. **Ask one question**, about
the gap that matters most, neutrally (*"what was happening on Sunday afternoon?"*, not *"what was so
funny?"*). Fourteen questions is too many. Say which source could have answered it, had it been
connected.

## The language follows who it is for

Dates, times (Swedish writes 14.20 and lower-case weekdays), and place names (Helsingfors for Helsinki
in Swedish) move with the language. Translated words aren't quotes, so drop the quotation marks.
Scan every visible text node for words left in the wrong language. A word the language needs but
the data lacks (Swedish distinguishes a mother's sister from a father's) is looked for in every trail,
then asked, never guessed.

## Photos: technical faults that ruin a film

- **Orientation.** Phone HEICs carry an EXIF orientation tag. Converting while keeping the tag and also
  rotating the pixels makes browsers rotate again: 58 of 120 photos came out sideways. Bake the rotation
  and strip the tag (ImageIO `CreateThumbnailWithTransform` on a Mac; libheif or pillow-heif applying
  `irot`/`imir` elsewhere). **ffmpeg applies a HEIC's grid rotation (`irot`) while decoding, even with
  `-noautorotate`**, so a pipeline that also applies the EXIF turn rotates the photo twice. Portrait
  phone photos came out sideways that way. The test: if the decoded size equals the stored size with
  width and height swapped, ffmpeg has already turned it, so don't turn it again. **Check the rendered frames**, not the source files: each shot should match
  its source best at 0°, and the face roll measured at full resolution should match the source's. A
  film with one sideways photo isn't a candidate.
- **Edits in the photo app are lost** when you read the original file. A crop or adjustment the
  person made isn't in it, so read the edited rendition where the library offers one.
- **Junk filter:** a utility classifier (receipts, screenshots, decoys) is reliable as a filter (20 of
  20, no false positives, in one test). An aesthetic score ranks posed groups highest, so never use it
  to pick.
- **Live Photos** hold 1 to 3 s of real motion and sound, the authentic version of what image-to-video
  fakes. A shot longer than its clip plays the clip up to the key moment, then settles on the still. A
  shorter one centres on the key moment. Keep the sound, ducked. Real motion went from 34% to 85% of
  a film this way.
- **Real motion first, generated motion last,** and only on stills with obvious motion and no faces,
  after the invention check (`generation.md`).

## The personal register

Personal content is the opposite of growth content, so keep its own template: slow dissolves or
honest cuts, real sound kept (wind, laughter), a serif caption, no kinetic type, no "motivational"
music. Seven rules for a 30 to 60 s memory piece:
1. Open on the most specific moment.
2. One throughline.
3. A small turn near the end.
4. Captions in the family's own words.
5. Music chosen as "day in the life" or "emotional".
6. Unproduced on purpose. Sharpening and smooth AI transitions push it toward an ad.
7. End on a face, or a line addressed to the person it is for.

What people respond to: one relationship, one small moment, a line that lands, made to be sent to one
person. Useful feedback-to-change mapping: "boring, like the phone's automatic memories" → a social or
product cut opening on the most specific moment; "too fast" → longer shots, no word captions; "I wasn't
there" → an index card or a cut scene; "who's that?" → only tagged names; "make one for <child>" →
their photos first, labels in their language, no narrator, about 30 s.
