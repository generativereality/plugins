# Revenue Magnet

**Build it, and they will come.**

"It" being a growth system that connects your product with the world, and Revenue Magnet helps you
build it.

## What Revenue Magnet does

It works out which part to build next and drafts it: a comparison or landing page for the searches
where visitors leave, a directory listing, a post about something that actually moved. You submit,
publish or set it live yourself.

It also reads the sources you connect (mail, calendar, analytics, Search Console) and draws one map:
every person and company around your product, on a ring from "never heard of you" to "recommends
you", each one linked to the email, meeting or page that put them there, with the next move drafted
for each. It is built to send nothing until you approve that exact message, and then from your own
account. Like any AI it makes mistakes, and you are the one responsible for what it does. It suggests a call or a meeting only when nothing else will move someone, and says why.

## Why an app, and not just more skills

You can get some of this by adding skills to Claude Code, and Revenue Magnet runs on Claude Code
and a library of skills itself. What skills alone don't give you is the way it feels to use day to
day.

The app runs the agents for you. It starts each round, gives it its part of the work, and brings
back what it found and what it drafted, so you never set up a session or keep track of one. You see
the result on the map: who came closer since you last looked, and what is waiting on you. Each draft
opens as a page you can read, with what it was built from and what a second pass doubted about it,
and you send it, change it or drop it there. The questions come to you in the app when they are
due, on your Mac or Windows PC and on the iPhone app, always with the context they need and the
review beside them, and you can answer them by voice.

This README went that way. A round drafted it, a second pass flagged the lines it doubted, and one
question reached my phone: use it? I answered out loud that "a bit of it is still a little bit too technical", and the next round
rewrote it.

The screens, the skills and the order the work happens in were all made for one job: growing the
part around your product. There is nothing to put together first. It is easier to try than to
explain, so try it on your own product.

## If you are reading this, it worked

Revenue Magnet is being grown through Revenue Magnet. This listing was worked out and drafted in the
app, through the rounds, reviews and questions above, and I submitted it myself. It is part of what
leads people to the product, and you found it, so on you, at least this far, it did its job.

## What this plugin does

It adds one skill to Claude Code. It comes into play when you ask for growth work (an SEO page, a
listing, a launch post, "who is using this?", what Search Console says), even if you don't name
Revenue Magnet. It works in Claude Code on the computer where the app is installed, and does nothing
in chat on claude.ai or in Cowork.

Claude checks that the app is installed and running (and opens it if the work needs it), and that
you have answered the app's consent question. Then it asks whether to do the work in Revenue Magnet.
If you say yes, it hands the app your request with what the conversation already knows (links, file
paths, the repo you are in), and carries the app's questions and your answers back and forth while
the work runs. If you say no, the skill gives Claude no other way to do that work in the
conversation: it tells Claude to do growth work in the app rather than in the conversation.
On first run it also sends the app your answer to its opening question. It passes all of this as
small files inside your Revenue Magnet folder. If the app is not
installed, Claude points you to https://revenuemag.net; the plugin installs nothing itself.

## You need

- The Revenue Magnet app, pay what you decide from €0: https://revenuemag.net
  (macOS 14 or later, or Windows 10 or later)
- Your own Claude Pro or Max subscription (or ChatGPT through Codex)

## Install

```
/plugin marketplace add generativereality/plugins
/plugin install revenuemagnet@generativereality
```

## Privacy

The map lives on your computer as Markdown files. What the agent reads goes to the AI provider you
signed in to, under its terms. The app sends us nothing from your map. What it does send is in the
privacy policy: your account, update checks with a random install number, feedback you choose to
send, problem reports you choose to send (with recent log lines, which can name people and companies
on your map), and, on a Mac, a follow-up report from Claude Code if you tick that box, which you do not see
before it goes.
https://revenuemag.net/legal/privacy-policy

Made by Fredrik Wollsén at Augmented Mind AB, Helsinki, and published in the generativereality
plugin marketplace. This plugin's files are under the MIT licence.
