# Revenue Magnet

**Build it, and they will come.**

"It" being a growth system that connects your product with the world, and Revenue Magnet helps you
build it.

## What Revenue Magnet does

It works out which part to build next and drafts it: a comparison or landing page for the searches
where visitors leave, a directory listing, a post about something that actually moved. From the
sources you connect (mail, calendar, analytics, Search Console) it keeps one map of every person and
company around your product, each linked to the email, meeting or page that put them there. It is
built to send nothing until you approve that exact message, and then from your own account. Like any
AI it makes mistakes, and you are the one responsible for what it does.

## If you are reading this, it worked

Revenue Magnet is being grown through Revenue Magnet. Its first map of itself showed that every
sign-up so far was its founder's own test. This listing is one of the parts it drafted next, and you found it.

## What this plugin does

It adds one companion skill to Claude Code. It wakes when you ask for growth work (an SEO page, a
listing, a launch post, *"who is using this?"*), even if you don't name the app. Claude checks that
the app is installed and running, and that you have answered its consent question. It opens the app
if the work needs it. Then it asks whether to do the work in Revenue Magnet.

If you say yes, Claude hands the app your request and what the conversation already knows: links,
file paths, the repo you are in. The app's questions come to you as cards in Revenue Magnet. Claude
tells you when one is waiting, and passes on your answer only if you ask. If you say no, nothing is handed over, and Claude carries on in the
conversation as usual.

All of this runs through the app's own command line on your computer. On first run it also passes on
your answer to the app's opening question. If the app is not installed, or cannot be reached (as in
chat on claude.ai or in Cowork), Claude points you to https://revenuemag.net. The plugin installs
nothing itself.

## You need

- The Revenue Magnet app, for Mac or Windows: https://revenuemag.net
- Claude Code, on your own Claude Pro or Max plan

## Install

```
/plugin marketplace add generativereality/plugins
/plugin install revenuemagnet@generativereality
```

## Privacy

The plugin itself contacts no server: it passes your request to the app as small files in your
Revenue Magnet folder. Your map is kept as files on your computer, and read through your own iCloud
if you use the iPhone app. What the agent reads goes to the AI provider you signed in to, under its
terms.

The app sends us nothing from your map. It does send a sign-in token when you sign in, update checks,
and feedback you choose to send. It sends problem reports only when you choose to, and their recent log lines can name
people and companies on your map. If you tick that box on a report, a follow-up report from Claude
Code goes too, which you do not see before it goes. Details:
https://revenuemag.net/legal/privacy-policy

Made by Fredrik Wollsén at Augmented Mind AB, Helsinki, and published in the generativereality
plugin marketplace. This plugin's files are under the MIT licence.
