# Plain-HTML track

Use this when you want zero setup: a single `index.html` that runs by double-clicking it
in a browser. No Node, no build, no server. Best for quick decks, sharing a file someone
can open anywhere, or environments without a toolchain.

## Scaffold

```bash
bash scripts/new-html-deck.sh <deck-name> [target-dir] [--title "Deck title"]
```

Creates `<deck-name>/index.html`, `<deck-name>/assets/`, and a `<deck-name>-notes.md`
speaker-notes file. Open with `open <deck-name>/index.html`.

## How the template works

- **Fluid layout.** Slides are positioned `absolute; inset:0` inside `#viewport` and fill
  the whole screen at any aspect ratio — no fixed stage, so **no letterbox/pillarbox bars**
  on 16:10 laptops, ultrawides, or resized windows. Type scales with `clamp(min, vw/vh,
  max)` so it stays projection-legible; spacing uses `em`/`%`/`vh`. There is nothing to
  scale on resize.
- **Safe-area padding.** Each `.slide` has `clamp()`-based padding that keeps content away
  from the viewport edge — do not override it to zero. See `references/design-system.md`
  for the floor values.
- **Surface inset.** Use `.slide-surface` on every content-bearing card, panel, callout,
  bordered box, or text overlay. It supplies responsive padding inside that visible
  boundary. A slide's safe-area padding and a grid's `gap` do not pad nested surfaces.
- **Content scrolling.** Slide content lives inside a `.slide-content` wrapper with
  `overflow-y: auto`. If content exceeds the slide height, it scrolls rather than clipping.
  The scrollbar is the browser default.
- **Slides** are `<section class="slide">` elements inside `#stage`. The first has
  `class="slide active"`. JS shows one at a time and cross-fades.
- **Navigation** (required) is the bottom `#nav`: prev/next buttons, a generated dot
  strip, and a `current / total` counter. Keyboard: → / Space / PageDown / ← / PageUp /
  Home / End.
- **Tailwind** loads from CDN (`cdn.tailwindcss.com`) so utility classes work with no
  build. The base typography (`.slide h1`, `.slide li`, etc.) is defined in `<style>` to
  enforce the floor; you can still add Tailwind classes on elements.

## Adding / editing slides

- Duplicate a `<section class="slide">...</section>` block and edit it. Order in the file
  is the slide order; dots and counter update automatically.
- Use fluid units for any new sizing: `clamp(min, vw/vh, max)` for type, `em`/`%`/`vh`
  for spacing and max-widths. Pick the `max` from each role's range in
  `references/design-system.md` based on how much content the slide holds — tighten toward
  the floor on text-heavy slides so nothing overflows, open up on sparse/hero slides.
  Never below the floor (body 40px, caption 32px). Don't hard-code fixed px or use
  Tailwind text size classes (`text-sm`, `text-base`, `text-4xl`) — they don't scale.
- Do **not** override the `.slide` padding to zero. Content must stay inside the safe area
  (see `references/design-system.md` "Two-layer padding contract").
- Whenever an element gains a background, border, outline, shadow, rounded surface, or
  backdrop blur around content, also give it `.slide-surface` (or an equal/larger explicit
  padding). Do not count sibling `gap`, child margin, or outer slide padding as that inset.
- Put images in `assets/` and reference them with a relative path (`assets/foo.png`).
- For a step reveal, give elements `style="opacity:0"` and flip them on a click/keyboard
  handler — but prefer splitting into more slides; it's simpler and more robust.

## When to switch to the React track instead

Move to Vite + React if the deck needs: many slides with shared components, complex
state-driven interactions, TypeScript safety, Framer Motion orchestration, or a embedded
live demo. The plain-HTML file gets unwieldy past ~15–20 rich slides.
