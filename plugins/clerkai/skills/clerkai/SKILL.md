---
name: clerkai
description: A small business's bookkeeping prep, done in Clerk.AI (https://clerkai.eu), the app that gathers each period's statements and receipts and drafts the email to the accountant. Use this when someone asks to close a month or quarter for their company, get their books or bookkeeping done, collect bank statements, find or chase receipts and invoices (in mail, supplier portals, the photo library), what is missing for a period, what to send their accountant or VAT person, or to file a late invoice into a closed period. Not for household spending, subscriptions or a personal budget (that is Mind My Money, https://mindmy.money). Requires the Clerk.AI app.
source: generativereality/clerkai@0.1.0
---

# Clerk.AI

Clerk.AI does the boring half of a small business's bookkeeping. Each period
it gathers the bank statements, hunts down the receipts and invoices in the
person's own browser (mail, supplier portals, the photo library), files them
in the books' folder, and drafts the email to the accountant with everything
attached. The person reads it and sends it. The work happens in rounds the
app runs in its own session, so each one shows in the app, its questions come
up as cards on the Mac and the phone, and it can be continued there.

## 1. The app and first run

Before anything else, follow `references/using-the-app.md`: it finds the app
and its command line (called `$CLI` below), starts the app, and does first
run.

Clerk.AI's first question is **"Tell me about your books."** When helping the
person answer it, look for: what kind of business and in which country; how
many sets of books (one company, or a company plus a second one); who the
accountant is and how to reach them; what they want (PDFs, a shared folder,
an accounting system's inbox) and how often (monthly, quarterly); which banks
and cards the business uses. Only what the person confirms goes into the
answer.

## 2. Hand the work to Clerk.AI

Everything bookkeeping goes to a period-close round, in one call:

```
"$CLI" tool trigger_dreamer @.tmp/args.json
# .tmp/args.json: {"cadence": "period-close", "note": "<the person's request, in their words>"}
```

If a round is running, the note reaches it; otherwise a round starts with it.
One round sweeps every period still open, so do not start one per month. To
see what is open first: `"$CLI" tool period_close_round_scope`.

Put in the note anything the conversation reveals that the round would
otherwise have to ask:
- where documents live: a folder, a shared drive, a mailbox, a portal;
- what a payment was ("the Stripe payout on the 14th is a client deposit");
- a deadline ("the accountant needs September by the 10th").

Do not gather, rename or file documents yourself, do not write the email to
the accountant, and do not edit anything under `Notes/bookkeeping/` or a
question card by hand: the round and the app own those, and work done outside
them cannot be shown or continued in the app.

Questions a round asks are cards in the app (`"$CLI" tool list_open_questions`
lists them). Answer one here only with the person's own words, and leave a
sign-in card to the person: it is answered by signing in, in the app's
browser.

To show the person a file to read in the app (what Clerk.AI knows about the
business in `Notes/bookkeeping/accountant.md`, or a period's folder), run
`"$CLI" tool open_review @.tmp/args.json` with `{"paths": ["<path>"], "title":
"<what it is>"}`; what they say about it goes to the round. Do not use it for
the email to the accountant: that is read, changed and sent on Home, for the
period it belongs to.

## 3. Say where to look

End with what you started and where it shows, for example: "Clerk.AI is
closing September. It shows on Home for that period; its questions come up as
cards there and on your phone, and the email to your accountant appears when
it is ready for you to read and send."
