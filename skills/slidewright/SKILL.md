---
name: slidewright
description: >-
  Build interactive presentation websites — slide decks projected to a room, controlled
  by one presenter. Use this skill WHENEVER the user wants to create, build, or design a
  presentation, slide deck, talk, or "bài thuyết trình / slide / trình chiếu", and also
  when they ask to add/edit slides, restyle a deck, scaffold a new presentation project,
  reuse their presentation setup in another repo, or export slides to PDF — even if they
  don't say the word "slide" but clearly need projected talk visuals (e.g. "I'm giving a
  talk next week and need visuals", "dựng deck cho buổi chia sẻ", "làm mấy trang chiếu
  cho hội thảo"). Supports two tracks: a zero-build single HTML file, or a Vite + React
  project. Do NOT use it for printable documents, normal web apps, or dashboards meant
  for individual users to interact with.
---

# Interactive presentation builder

Build slide decks that run as a website and are **projected to a room**. The deck is the
visual half of a talk; the presenter does the talking. Two ways to build, one shared
design language.

## First, the mental model (read before writing any code)

There is **one operator** (the presenter) on **one machine**. Slides go on a big screen;
the audience only **looks** — they never click, type, or interact. Everything below
follows from this. Three failure modes to avoid:

- **Text too small.** Slides are read from across a room, not on a laptop. Never use
  web-reading sizes (`text-sm`, `16px`) or fixed Tailwind text classes (`text-4xl`).
  Always use fluid `clamp()` so text scales with the screen. Honour the typography floor
  (body ≥ ~40px on a 1080p canvas). See `references/design-system.md`.
- **Content hugging the edge.** Slide content must never touch the viewport edge — it
  looks unfinished and is hard to read when projected. Both scaffolds enforce safe-area
  padding; don't override it to zero. Even `fullBleed` slides keep text content inset.
- **Building an app.** No input fields, no "Submit", no login, no data collection — there
  is no backend and nowhere for data to go. Interaction is only the presenter clicking to
  reveal/advance content. If a component asks "where does this data go?", it's wrong.

`references/design-system.md` is the heart of this skill — the typography floor, safe-area
padding, content overflow, layout recipes, motion, and palette. Read it whenever you design
or restyle slide content.

## Workflow

1. **Understand the talk.** Topic, audience, speaker (name/role for the title slide), tone,
   rough number of slides, and any brand colours/logo. For Vietnamese content the default
   voice is plain, honest, direct — no marketing hype.
2. **Pick a track** (below). If unsure, ask once; otherwise default to plain HTML for
   small/quick decks and React for substantial, maintained talks.
3. **Scaffold** with the matching script — don't hand-assemble the boilerplate.
4. **Build slides** following `references/design-system.md`: one idea per slide, few
   words, real visuals, projection-legible type, presenter-only interaction.
5. **Keep the required chrome:** a visible bottom navigation slider (dot strip) and slide
   number. Both scaffolds include it — don't remove it.
6. **Write speaker notes** in the `<deck-name>-notes.md` file the scaffold creates (never
   on the slides themselves).
7. **Export to PDF** if asked — see `references/export-pdf.md`.

Put each deck in its own folder. Keep any live-demo app as a separate project, not inside
the deck.

## Choosing a track

| Pick | When | Reference |
| --- | --- | --- |
| **Plain HTML** | Zero setup wanted; runs by opening a file; quick deck; shareable anywhere; no toolchain. Gets unwieldy past ~15–20 rich slides. | `references/html-track.md` |
| **Vite + React** | Many slides, reusable components, state-driven interactions, TypeScript, Framer Motion, maintained/re-run talks. | `references/react-track.md` |

Both produce the same projected experience and obey the same design system; they differ
only in implementation.

## Scaffolding

**Plain HTML** — single self-contained `index.html`, Tailwind via CDN, no build:

```bash
bash scripts/new-html-deck.sh <deck-name> [target-dir] [--title "Deck title"]
```

**Vite + React** — scaffolds with the official Vite tool and installs the **latest**
React, Tailwind, Framer Motion, and Lucide (versions are intentionally not pinned, so
each deck starts on current tooling), then layers the `App → Deck → Slide` architecture:

```bash
bash scripts/new-react-deck.sh <deck-name> [target-dir] [--no-install]
cd <deck-name> && npm run dev
```

After scaffolding, read the matching track reference for how slides are structured and how
to add/reorder them, then build the content.

## Files in this skill

- `references/design-system.md` — projection rules, typography floor, layout recipes,
  motion, palette. The core; consult for any content/design work.
- `references/html-track.md` — plain-HTML deck structure, template internals, adding slides.
- `references/react-track.md` — Vite+React architecture, slide ordering, Tailwind wiring.
- `references/export-pdf.md` — PDF export options and speaker-notes convention.
- `scripts/new-html-deck.sh` — scaffold a plain-HTML deck.
- `scripts/new-react-deck.sh` — scaffold a Vite + React deck.
- `scripts/export-deck-pdf.py` — export a deck to a content-complete PDF (waits for render
  and reveals hidden content; image-based).
