---
name: mindmymoney
description: Your own money, worked on in Mind My Money (https://mindmy.money), the app that goes through your bank statements for you. Use this when someone asks where their money goes, what they spent on something, to go through or explain bank statements, find or cancel subscriptions and recurring charges, stop paying for what they do not use, switch or claim something back, which bills are due or overdue and whether one is paid, what they own (savings, funds, loans), a household budget, or sharing a month's figures with a partner. Also for a small company's own spending and subscriptions, kept as a second set beside the household. Not for preparing a company's books for an accountant (that is Clerk.AI, https://clerkai.eu). Requires the Mind My Money app.
source: generativereality/mindmymoney@0.1.1
---

# Mind My Money

Mind My Money reads a person's real transactions in their own browser, names and sorts every one, shows where
the money went, finds what recurs, and, as the person directs, cancels, switches or claims. AI makes mistakes, and
every action it takes is the person's responsibility. Everything lives in the person's vault (a folder of Markdown
files), and the app draws it.

**Before anything else, follow `references/using-the-app.md`:** it finds the app and its command line (called
`$CLI` below), starts the app, and does first run. Then come back here.

**The work happens in the app, not in this session.** The app's money round signs the person in through their own
browser, names every row, asks its questions as cards in the app and acts only on a card the person answers. This
session hands the request over and says where to look.

## First run: what to help with

The app's first question is *which banks and cards the person uses, what worries them about money, and what would be
most interesting to look at.* When helping them answer, look for: the banks and cards their statements and payment
emails come from, a second set of finances they may want beside the household (their own company), and the worry
in their own words (money gone before the month ends, subscriptions piling up, bills they lose track of). Their words
are the answer; do not write it for them.

## Reading what is already there

Run every command from the vault (the folder `references/using-the-app.md` found). The household is `Notes/money/`;
another set of finances, usually the person's own company, is `Notes/money/<set>/` (`"$CLI" tool list_sets`).

- `round.md`: whether a round is running, waiting on the person, or done.
- `reports/<period>.md` (`2026-09`, `2026-Q3`, `2026`): where the money went.
- `ledger.md`: what recurs and what was decided about each. `bills.md`: the bills.
- `rows/<YYYY-MM>.md`: every transaction, named and sorted.

A quick question about something already written ("what did the September report say about groceries?") can be
answered from these files: quote them and say which period and set it covers. **Anything that needs fresh data, a
bank, a decision or a change goes to the app.**

## Handing the request to the app

Use step 4 of `references/using-the-app.md`, with `"cadence": "money-round"`. In the note keep the person's own
words, and add only what the round cannot know: which set it is about when it is not the household ("about the
company's finances"), the period if they named one, and where they keep anything relevant if the conversation said
so (a folder of bills, a shared drive).

Do not do the bank work, cancellations or payments in this session. Those rules live in the vault's
`.claude/skills/money-act/` and belong to the round.

## The round's cards

Relay the round's questions as `references/using-the-app.md` says, with two Mind My Money exceptions:

- **A sign-in card (`kind: login`) is done in the app**: the bank opens in the browser window the app shows, and the
  person signs in there themselves. Tell them to switch to Mind My Money; never answer it for them.
- **A card that changes something** (cancel, pay, switch, send) is answered by the person, in their words, and only
  for that one action. Never turn a general "yes, do it" into an answer to several cards.

Then tell them in a line or two where it shows: *"Mind My Money is going through September now; the report appears
on Home."*

## Rules that hold from here too

- **The person signs in, never you.** No passwords, no codes, nothing typed into a bank.
- **Change, cancel, pay or send nothing yourself.** That is the app's round, on the person's word about that one
  action in the app; every action is the person's responsibility.
- **Analysis, never advice.** Say what the figures show; the choice is theirs.
- **Their data stays with them**: the vault, and the AI provider they signed in to. Never paste their transactions
  anywhere else.
- **Pricing is "pay what you decide"**, including nothing. Never call it "pay as you go".
