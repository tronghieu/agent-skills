# SlideWright

**Language:** [English](./README.md) | [Tiếng Việt](./README.vi.md) | [中文](./README.zh.md)

Build projection-ready web slides that let a live speaker lead the room.

## Quick install

```bash
npx skills add tronghieu/agent-skills --skill slidewright
```

## Try it

```text
/slidewright Build a 10-minute conference deck about practical AI agents for product leaders. Use a warm, editorial visual direction and include speaker notes.

/slidewright Turn these project-pitch notes into a 12-slide deck for investors. The venue is a 16:9 screen; use our logo and make the narrative decisive but not hype-driven.

/slidewright Restyle my existing workshop deck for projection: one idea per slide, clearer hierarchy, and presenter-controlled reveals only where they improve pacing.

/slidewright Create a reusable React deck for our quarterly engineering review, then prepare a PDF version to share after the talk.
```

## Why not use an ordinary chatbot?

An ordinary chat response can produce slide text, but it may treat the result like a document or a small web page. SlideWright works from the conditions of a live talk: the audience watches from a distance, one presenter controls the deck, and the speaker—not dense on-screen copy—carries the detail. It keeps text projection-legible, separates speaker notes from audience visuals, includes live navigation, and chooses an implementation track suited to the deck.

## Who it is for and when to use it

Use SlideWright for talks, conference sessions, workshops, classes, demos, project pitches, and internal presentations that will be projected or screen-shared. It suits speakers, educators, consultants, founders, and developers. It is not for a reading document, a dashboard, or a website the audience must operate.

## How a deck takes shape

1. Share the talk outcome and the one message people should remember.
2. Shape a concise narrative and visual direction around the audience and setting.
3. Build each slide around one idea, using large, room-readable type and visuals where they clarify the point.
4. Add only presenter-controlled movement: navigation, a progressive reveal, or a comparison that supports the story.
5. Check the deck for the target screen and prepare separate speaker notes; request a PDF when you need a shareable record.

The detailed projection rules, layout patterns, and export behavior live in [`references/`](./references/), so this page can stay focused on the outcome.

## Choose a track

| Track | Choose it when | Mental model |
| --- | --- | --- |
| **Single HTML file** | You need a short, quick, portable deck or do not want a build step. | One self-contained deck that opens in a browser; best for a focused talk, but less comfortable once a rich deck grows beyond roughly 15–20 slides. |
| **Vite + React** | You expect many slides, reusable components, richer motion, state-driven presenter interactions, or a deck you will maintain. | A presentation project with slides as ordered components; it needs Node.js and a package manager. |

Both tracks create the same audience experience: a full-screen deck with visible presenter navigation and a slide number. Pick for the deck’s complexity and lifespan, not for visual quality.

## Interaction: for the presenter, not the audience

The presenter advances with the keyboard or bottom navigation and can jump between slides. A reveal, tab, comparison, timer, or animation is appropriate only when it changes what the presenter is explaining. Forms, logins, submissions, answer collection, and stored audience data do not belong in this kind of deck.

## What to provide

Bring what you have: talk goal, audience, duration, key message, source material, required slide count, venue or screen constraints, and any brand colours, logo, images, or tone guidance. Say whether you want a fast HTML deck or a maintainable React project; if you are unsure, describe the deck and the skill can help choose.

## What you receive

- A runnable HTML or React presentation website
- A coherent visual direction with projection-scale layouts and typography
- Presenter navigation, slide numbers, and only purposeful reveals or motion
- A separate Markdown file for speaker notes
- Guidance for visual checking and, when requested, a faithful PDF export for sharing

## Useful companions

- Start with [Brainstorm Coach](../brainstorm-coach/README.md) when the talk’s angle, central message, or examples are still open; use it to explore and narrow possibilities before building the narrative.
- Use [Critical Thinking](../critical-thinking/README.md) when a pitch, strategy talk, or evidence-heavy deck needs its argument stress-tested; it helps find unsupported claims and the strongest objection before the audience does.

## Limits

SlideWright supports one presenter operating one screen while an audience watches. It does not build audience-facing apps, collect or store responses, or replace the presenter’s judgment about claims and source material. A PDF is a shareable capture of the deck rather than a substitute for accessible source documents, and you should rehearse and check the final deck in the actual event environment.
