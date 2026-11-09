# Channels: each place's form, rules and what it rewards

Each channel gets its own piece. A directory tagline, a forum post, a launch page, a newsletter and
a short clip are written separately, in that place's form. **Read the place's own rules before
drafting, and link them in the brief.** Rules change, so the notes below are a starting point, not a
substitute for reading them. Dates say when a fact was checked.

## Before any community post: the account

A community's requirements on the **account** are rules too, and a post that misses one is removed
unread. Many subreddits and forums set a minimum karma (overall or earned in that community), account
age or self-promotion ratio, often enforced by a bot and stated only in the sidebar, wiki or a pinned
post. Read all of them and check the person's account against each, in their signed-in browser. If the
account falls short, **don't post yet**. Earn the standing inside the rules first, with real comments
in the person's own words. A removed post stays removed: never propose asking moderators to approve it
or to waive a rule.

Look at what the community is talking about that day. A post about running many AI sessions, made
the evening after a thread about usage limits blowing up, got answered with "dude loves wasting tokens".

## Places

**Reddit.** Posting your own work is allowed in reason, and each subreddit's own rules decide what
counts as promotion (flair, a weekly thread, account age, karma). The "9:1 rule" isn't in Reddit's
current pages, so treat it as folklore. What wins in maker-friendly subs: a short plain first-person
title in the shape *"I had problem X, so I made Y do Z"*, with no brand name in front; a short body
(the top maker posts run about eight short lines); a striking real visual or clip; the maker says in
the first line that they made it and whether it is free; it names the alternatives and how it
differs; it ends on a genuine question. Links in the first comment when the sub filters new domains in
bodies; no tracking parameters where referral links are banned. Be ready in the comments for "is this
an ad?", "how is this different from X?" and the cost.

**Hacker News, Show HN.** For something people can try, ideally without sign-up; not a landing page or
a blog post. The title is `Show HN: <name> – <what it is, in words HN already uses>`, with no
superlatives or capitals for emphasis. The maker posts it and stays to answer. **Show HN bans generated
text in posts and comments**, so the person writes their own; you can prepare notes for them (what
they tried first and why it fell short, how this differs from named alternatives, what is rough, the
likely questions). Never ask for votes.

**Product Hunt.** A tagline of 60 characters or fewer, no gimmicks; a gallery whose first image works
on its own; the maker's first comment tells the story, who it is for and what is rough, and asks for
feedback, never votes.

**A directory of tools, plugins or apps.** Readers are solution aware and comparing. The first
sentence says what it does, for whom, and how it differs from the alternative, in the directory's own
fields and limits.

**Building in public** (progress posts on any channel). Share a decision, a mistake or a lesson, each
tied to something concrete that happened. A dump of metrics with no lesson reads as a status report and
invites "so what?"; a number belongs only when it is the lesson.

**A blog post.** Something a stranger can use even if they never try the product: a lesson, a method,
a mistake and what fixed it. The product comes in as the way the author did it. Plan the pictures with
the words (`copy.md` §5). For search, read `search.md`. Before it goes: every link opens, the title
and subtitle are set, and there is a one-to-two-sentence meta description. When a post is excerpted
elsewhere (a forum, a professional network, a short post), each excerpt is written for that place and
links back to the original.

**A newsletter** (Substack, Beehiiv, Ghost, email). This is the highest-intent channel and the one the
person owns. Frameworks, breakdowns and real stories, with no filler. Most reach often comes from
forwarding person to person, so a piece someone would send a colleague does best. Avoid holiday weeks
for anything whose next step is a work action.
- *Substack mechanics, when preparing a draft through its API from a signed-in browser* (read Jul to
  Oct 2026):
  - **The editor's ProseMirror schema is strict,** and a draft that saves through the API can still open
    blank ("Failed to parse JSON for post"). Copy the shape of an existing draft
    (`GET /api/v1/drafts/<id>`): the doc has no `attrs`; paragraphs and headings carry
    `attrs:{textAlign:null}` (headings also `level`); lists are `bullet_list` → `list_item` →
    `paragraph`; a link mark carries `href`, `target:'_blank'`, `rel:'noopener noreferrer nofollow'` and
    `class:null`; bold and italic are `strong` and `em`. Open the draft in the editor before calling it done.
  - **The cover field only drives the social preview and feed thumbnail.** A picture shown at the top of
    the post must also be the body's first node, a `captionedImage` (copy its exact shape from a post that
    has one; its width and height are the display box, scaled to 1456 px wide). Upload images with
    `POST /api/v1/image` (a data URI) from a script over CDP, since the payload is too big for a one-line
    eval. The cover field wants the signed CDN form of the URL, whose signature can be read from a
    published page's `og:image`.
  - **An open editor tab saves its copy back over an API update,** minutes or hours later and from any
    device. Before an update, find every tab on that post's editor (the person's own too) and navigate it
    away; re-verify about 30 s after pushing, not only at once. If the live body matches an earlier
    version exactly, it was this, not a failed write. `GET /api/v1/drafts/<id>/versions` lists every save
    with time, user and content hash: use it whenever a draft "changed by itself".
  - **Never rely on Substack's scheduled send;** a stale tab's save went out by email on a schedule once,
    and an emailed copy can't be fixed. Snapshot the approved body, and at publish time compare the
    draft with it (block sequence and every paragraph's text). On any mismatch, stop and tell the person.
    Publish only when the person says so, then compare the public post's `body_html` with the snapshot.
  - **A published post is a separate snapshot:** a `PUT` to the draft changes nothing live. Use the
    editor's Update → Update now, which sends no second email; never re-POST publish.
  - Authorship reads correctly from `postBylines`, not `draft_bylines` (empty even when right). The editor
    page is heavy enough that evals time out; do API work from a light tab on the dashboard. Sign-in is a
    one-time code: read the newest one, scoped to the address it was sent to, and switch accounts with
    `change_user=true` (plain sign-in keeps the current session). A prepublish `MISSING_SUBSCRIBE_CTA`
    offers to insert subscribe widgets.

**LinkedIn.** Professional readers; a hook that gets to its purpose at once, often with an opinion.
200 to 500 words, short paragraphs, the person's real story or framework. Plain register works,
and the person's own speech register beats "professional" polish. Don't open by diagnosing a
stranger's organisation ("your team isn't X-limited, it's Y-limited") before you have any credibility
with them: lead with what surprised you and the receipts, and let the diagnosis come as the answer to
the question the reader asks next. Close with an invitation, not a call to action. Links in a post are commonly believed to reduce reach. If that matters, test it.
- *Mechanics:* uploads can report failure and land anyway, and a message compose box can still be
  bound to the previous conversation. Check which thread you are in, and read the result, before
  assuming anything.

**X.** Plain contrarian one-liners and predictions; a thread only when every post earns its place.

**Instagram (feed, carousel, Reels).** It distributes on **sends** (shares in DMs) and watch time. At
most five hashtags; keywords in the caption and the on-screen text. Carousels save when the list
overflows and each slide carries proof.

**TikTok and Shorts.** The first two seconds decide; a contrarian or surprising line within four
seconds; native, phone-shot, talking or showing.

**YouTube.** Story-driven teaching; the title and thumbnail are one promise (`stills.md`). Most channels
see a click-through rate of 2 to 10% (YouTube Help). Compare videos with each other by traffic source,
not against a universal number. Use YouTube's Test & Compare to test thumbnails, not taste.

**Email to many** (a launch note, an update). One reader in mind, one next step, a subject that says
what it is. A one-to-one cold email is sales work and belongs to whatever relationship or sales skill
the project has, not here.

**Answer engines** (ChatGPT, Claude, Perplexity, Copilot, Google's AI answers): see `search.md`.

## Sizes and lengths

| Format | Size | Notes |
|---|---|---|
| Feed image / carousel slide (Instagram, LinkedIn) | 1080 × 1350 (4:5) | the tallest that shows in feed |
| Square | 1080 × 1080 | |
| Story / Reel / Short / TikTok | 1080 × 1920 (9:16) | keep text inside the safe band, about 250 px clear top and bottom |
| YouTube thumbnail | 1280 × 720 | readable at phone size |
| Reddit or link lead image | 1200 × 900 or 1200 × 630 | shown smaller in feed; test at about 400 px wide |
| Open Graph / social preview | 1200 × 630 | |
| Product Hunt gallery | 1270 × 760 | the first image must work alone |
| Video for chat apps (WhatsApp) | H.264 720p, at most about 15.5 MB | `+faststart` |
| Video for a TV | landscape 1080p HEVC | from the same edit as the portrait cut; pan across faces, never letterbox |
| Video for a digital photo frame | silent, captioned, 30 s or less | frames play without sound |
| Short-form clip length | 15 to 45 s | the payoff before 80% of the runtime |

## Never

- Post, upload, publish or comment. Prepare it, open it in the person's browser, and let them press
  the button.
- Reuse one piece unchanged across channels.
- Write *upvote*, *please share* or *support us*, or hide that the person made it.
