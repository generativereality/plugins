# Search: pages that rank and are worth landing on

A page meant to be found has two jobs, and it fails if it only does one. It has to answer the query
well enough that a search engine or an AI assistant puts it in front of someone, and it has to be
worth that person's time once they arrive. Both jobs fail the same way: writing what we want to say
about our product, in our own words for it, on a query nobody types.

## 1. The query is measured, never guessed

Choose the target query from measured volume (Google Keyword Planner, Search Console, Bing Webmaster
Tools), and write the measurement down with its date the same day, in a numbered file in the
project's research folder, because scratch files vanish. Keyword Planner without ad spend gives buckets
(10–100, 100–1K, 1K–10K, 10K–100K, 100K–1M): precise enough to choose with, too coarse to forecast with.
What has changed decisions:

- **People search the job, not the container.** An AI-prefixed phrasing ("ai expense tracker app")
  has measured two to four volume buckets below its plain twin ("expense tracker app"), and in other
  languages the AI-prefixed form often returns nothing. The AI belongs in the answer, not in the title.
- **People search the label and the product, not the idea.** A bank-statement label or a product name
  carries thousands a month; an idea like "private budgeting" carries almost nothing. A page about an
  idea needs a product or label word in its title.
- **A brand nobody searches can't carry a comparison page.** Check the brand's own volume first.
- **Volume isn't intent.** Read the results before choosing: a query whose top ten are all about fees
  can't be won by a page about something else with the same words.

## 2. Read the results page before writing

Open the query in a real browser and write down what is there:

- **Who owns the top three, and whether any small independent site ranks at all.** That second point
  is the winnability test, and it is usually kinder than it looks.
- **What takes the click before the results.** Where an AI overview answers completely, a page that
  only summarises loses, but **being cited is a way in that ranking isn't**: overviews often cite
  small sites. Note the narrowing question the overview asks at the end; each split it offers is a
  page.
- **People Also Ask, word for word.** They are the best outline for the page's sections. Put FAQ
  schema only on questions the page visibly answers.
- **Freshness.** Results dated this week mean a maintained query; undated results mean an open one.
- **Intent.** "Personal expense tracker" turned out to be a spreadsheet-template query.
- **What the ranking pages do well:** a method section with numbers in it, a spec block with
  identical fields per item, jump links, an FAQ, a visible date checked, named experts where real.
  The best openings in one read of thirteen ranking pages were first-person failure stories, usable
  only when the failure is real.
- **What they all leave out.** The gaps are where the page comes from.

## 3. The bar: what does this page have that nobody else's does?

A page about a job **teaches the job in full**: the job in the heading, what makes it annoying, how to
do it yourself step by step, the named operators people search for in the detail actually verified,
then the offer to let the product do it. The call to action is gated; the page isn't. Someone who never
downloads anything should be able to finish the job with the page alone, and that is what makes it
worth ranking.

**Before writing, name the one thing on this page that neither the ranking pages nor the company's
own help pages carry.** If you can't name it, don't write the page yet. Sourcing every sentence from
the operator's own help pages is a reliable way to make a page that adds nothing to those pages. Kinds
of novelty that have worked:

- **A real run:** we did the job and wrote down what happened, including what went wrong.
- **A synthesis nobody has done:** the same questions asked of every option, in one table.
- **What the company doesn't say**, found by reading its pages against each other.
- **The consequence people act against:** a regulator's sentence that changes what to do.
- **Something made from the reader's own kind of data:** a real household's numbers (anonymised,
  presented as "one household", never identifying anyone).

A real run on people's own data is presented as **one household's, never as "ours"**, with every
identifying detail left out (whose profile, children, names, places). A run on the author's own account
told in the first person is different, because it concerns nobody else. A paraphrase of the company's
help pages may sit on the page as the reference half, short and saying whose rules they are, after the
novel part and never as the reason the page exists.

Three tests before publishing:
1. **Delete the product paragraph.** Is the page still worth reading?
2. **Can someone actually follow it?** Real steps with the real friction: which button, which export,
   what goes wrong the first time.
3. **Does it answer the awkward question too**, honestly, even when the honest answer sends the reader
   elsewhere?

## 4. Facts from the primary page, quoted and dated

- The vendor's, operator's or regulator's own page is the only acceptable source; directories and
  review sites are often wrong or stale (three of sixteen listings checked in one directory were).
- Quote the sentence and keep its address and the date read beside the draft; a footnote lets a
  reader check it.
- "Not stated on their site" is a finding, and isn't the same as "no".
- **Never invent a number for illustration.** If it wasn't measured, write the sentence without it.
- A page whose facts age shows the date they were checked, where the reader sees it.

## 5. The opening is for the reader

The first lines say who the page is for and answer the question, then date the facts. It is not a
note about our research. Headings are plain and say the thing.

## 6. Comparison pages

A title like *"X or Y?"* tells the reader they are choosing. When the two don't do the same job, say
so: frame it as "who does what" (tables like "a month with both", not "a month with each"), with no row
leaning our way and at least two rows where we answer "no". Record per comparison whether the other
product competes, and let a test pin the page's framing to it. A comparison with no real difference in
it is a pitch with a new heading.

## 7. Writing for AI assistants as well

- In a study of generative engines (GEO, KDD 2024), adding quotations, statistics and cited sources
  raised a page's visibility in AI answers the most, roughly 30 to 40%. An authoritative tone didn't
  help, and keyword stuffing did worse than nothing. Answer the question in the first two sentences;
  write self-contained, citable claims, each number with its source.
- Assistants search in long specific queries (about 12 words on average for one of them, 2026) and lean
  on *best*, *review*, *vs*, *alternative* and the year. A title should contain the words such a query
  would: on an "X alternative" query they cited small pages with *alternative* in the title and missed
  pages titled "X or Y?".
- Answer each sub-question in its own paragraph or table row, because assistants lift the piece that
  answers their part.
- Carry a `dateModified` (Article schema) from the date the facts were checked.
- Where assistants look matters more than markup: ChatGPT search, Copilot and DuckDuckGo use Bing's
  index; one major assistant most likely uses Brave's, which has no submission console and finds pages
  through links from sites it already indexes (forums, code hosts, directories); Perplexity has its own.
  Ping Bing (IndexNow) after every release that adds or changes pages; a 403 on the first run after a new
  key is key validation, so run it again. `llms.txt` exists but no major assistant has committed to
  reading it.
- **Describe the product exactly**, because an assistant repeats it word for word. Never claim more
  privacy or capability than is true.
- Search engines accept AI-assisted pages that add value and treat mass pages without it as spam.

## 8. After it is live

Check the page serves (grep for a phrase only the new build has), is in the sitemap and isn't
blocked by robots.txt. A page waiting for approval must not ride along on someone else's release, so
keep it on its own branch. Search Console and Bing Webmaster Tools are the feedback, not opinion:
impressions with no clicks means a title or answer problem; neither means not indexed or not
competitive. Search Console data lags about four days and covers Google only. Bing Webmaster Tools'
AI Performance report shows Copilot citations and the grounding queries behind them, the nearest thing
to a list of what assistants search. Which crawlers actually read a page is in the CDN's request logs
by user agent (OAI-SearchBot and ChatGPT-User, ClaudeBot, PerplexityBot, DuckAssistBot). Expect nothing
for weeks on a young domain: the first pages are an investment in a corpus, not a test of one page.
