# Design system — projection-grade slides

This is the shared design language for every deck, regardless of track (plain HTML or
React). The rules here exist because the output is **projected to a room**, not read on
a personal screen. Internalise the mental model first; the specifics follow from it.

## The one mental model: this is projection, not a web app

There is exactly **one operator** — the presenter — on **one machine**. Slides are
thrown onto a big screen (projector, or screen-share in Meet/Zoom). The audience only
**looks**. They never click, type, or touch anything.

Two mistakes follow from forgetting this, and both are common:

1. **Text too small.** Web-sized type (`text-sm`, `16px`, `1rem`) is illegible from the
   back of a room. On a 1080p canvas, `16px ≈ 8pt` — half the minimum.
2. **Treating it like an app.** Building input fields, "Submit" buttons, login, score
   collection, anything that stores data. There is no backend and nowhere for data to
   go. If a component raises the question *"where does this data go / who reads it?"*,
   it is wrong — remove it.

## Typography floor (non-negotiable)

Sizes are projection sizes on a **1920×1080** screen (1pt ≈ 2px). There is **no single
"correct" size** — each role has a **range**, and you pick within it per slide based on how
much content is on it. The floor is the hard bottom; the hero ceiling is the hard top.

| Role                | Floor (hard min) | Projection range — pick per slide | Hero ceiling |
| ------------------- | ---------------- | --------------------------------- | ------------ |
| Body / bullet       | 20pt · 40px      | **40–48px**                       | 52px         |
| Subtitle / lead     | 24pt · 48px      | **48–60px**                       | 64px         |
| Section head (h2)   | —                | **52–64px**                       | 72px         |
| Main title (h1)     | 36pt · 72px      | **80–104px**                      | 120px        |
| Caption / slide no. | 16pt · 32px*     | **32–38px**                       | —            |

\* caption/slide-number is the one role allowed below the body floor (never < 16pt = 32px),
since it isn't primary reading.

**How to pick within the range — this is the point:**

- **Text-heavy slide** (several bullets, a long quote, a dense table): drop toward the
  **bottom of the range** — down to the floor if needed — so the content fits without
  overflowing or scrolling. A slide that overflows is worse than one a notch smaller.
- **Sparse slide** (a few words, one stat, a cover): move toward the **top of the range**,
  or use the hero ceiling on a *single* hero element (cover title, one big number). Bump
  *that one element*, not the globals.
- **Ordinary slide:** land in the middle of the range. Don't default to the ceiling —
  oversized type looks shouty and crowds the slide.
- **Never below the floor**, whatever the content. If it still won't fit at the floor, the
  slide has too much on it — split it into two, don't shrink past the floor.

- **Always use fluid `clamp()` for slide text — not fixed `px`, `rem`, or Tailwind size
  classes** (`text-sm`, `text-lg`, `text-4xl`). Both templates are fluid: `clamp(min,
  vw/vh, max)` for type, `em`/`%`/`vh` for spacing. The `max` is the projection size you
  pick from the range above. Fixed `px` only belongs in a fixed-canvas deck that is then
  scaled (not the default). Tailwind text utilities (`text-base`, `text-xl`, etc.) map to
  fixed `rem` values, so they don't scale with the viewport — avoid them for slide content.
- **Acceptance test:** zoom the screen to ~33% (or stand 3–4 m back). If you can still
  read the bullets, it passes — and nothing is clipped at the slide edges.

### Clamp() cheatsheet — copy-paste these

Use these as starting points. Tune the `max` per slide (tighten toward floor on dense
slides; push toward ceiling on sparse/hero slides):

| Role              | Ordinary slide                      | Text-heavy slide                    | Sparse / hero slide                  |
| ----------------- | ----------------------------------- | ----------------------------------- | ------------------------------------ |
| Body / bullet     | `clamp(28px, 2.6vw, 44px)`         | `clamp(28px, 2.4vw, 40px)`         | `clamp(28px, 2.8vw, 48px)`          |
| Subtitle / lead   | `clamp(30px, 2.9vw, 48px)`         | `clamp(30px, 2.7vw, 44px)`         | `clamp(30px, 3.2vw, 56px)`          |
| Section head (h2) | `clamp(38px, 3.4vw, 60px)`         | `clamp(38px, 3.0vw, 52px)`         | `clamp(38px, 4.0vw, 68px)`          |
| Main title (h1)   | `clamp(56px, 6.4vw, 104px)`        | `clamp(56px, 5.6vw, 88px)`         | `clamp(56px, 7.5vw, 120px)`         |
| Caption / slide # | `clamp(22px, 1.9vw, 36px)`         | `clamp(22px, 1.7vw, 32px)`         | `clamp(22px, 2.0vw, 38px)`          |

In JSX, apply via `style={{ fontSize: 'clamp(28px, 2.6vw, 44px)' }}`. In the HTML
template, use the same value in inline `style` or in `<style>` overrides.

### Two scaling strategies

- **Fluid `clamp()`** (both templates' default): the `max` is the projection size, the
  `min` is a small-window fallback, the middle scales with the viewport. Slides fill the
  whole screen at any aspect ratio — no letterbox/pillarbox bars. **Best default.**
- **Fixed canvas + scale**: size everything in px on a 1920×1080 stage, then
  `transform: scale()` to fit. Sizes are pixel-exact, but the deck letterboxes/pillarboxes
  on any non-16:9 screen (16:10 laptops, ultrawides, resized windows). Use only when you
  truly need pixel-locked layout and control the projector's aspect ratio.

## Content discipline

- One idea per slide. Few words. Let the presenter's voice carry the detail.
- Prefer a real visual (image, diagram, screenshot) over a paragraph.
- Vietnamese copy should sound like someone talking on stage — plain, honest, direct.
  No marketing tone, no hype. Say what the tech does and what it doesn't.

## Allowed interaction (presenter-controlled only)

Interaction exists to make the slide change visually while the presenter clicks:

- ✅ Reveal content step by step (progressive bullets, expand a card, flip).
- ✅ Move between slides; jump via the dot strip / table of contents.
- ✅ Toggle a before/after compare, tabs, or an accordion **whose content already exists**.
- ✅ Timers, countdowns, animation, highlight, hover.

Never: text inputs, "Submit/Save", answer collection, scoring, login, or anything that
assumes storage (DB, an API call, localStorage for someone's answers).

## Two-layer padding contract (non-negotiable)

Good spacing has two independent layers. Both must pass:

1. **Viewport → slide content:** the projector/browser edge needs a safe area.
2. **Visible container → its content:** every card, panel, callout, bordered box, tinted
   region, blurred overlay, or other content-bearing surface needs its own inner inset.

Padding does not inherit through the layout tree. A padded slide can still contain an
unpadded card, and that card will still look broken. Likewise, `gap` only separates
siblings and margin only moves an element from its neighbours; neither creates breathing
room between a container's boundary and its children.

### Layer 1 — viewport safe area

Slide content must never touch the viewport edge — it looks unfinished and is hard to read
when projected. Both scaffolds enforce a padding floor, and you should not override it to
zero.

| Slide type    | Vertical padding floor            | Horizontal padding floor          |
| ------------- | --------------------------------- | --------------------------------- |
| Normal slide  | `clamp(40px, 5vh, 80px)`          | `clamp(48px, 5vw, 120px)`        |
| Full-bleed    | `clamp(32px, 4vh, 64px)`          | `clamp(40px, 4vw, 96px)`         |

"Full-bleed" means the **background** fills edge-to-edge (for images, gradients, colour
blocks), but the **text content** still sits inside the safe area. Think of it like a TV's
safe-area overlay — the picture goes to the edge, the text doesn't.

More padding than the floor is fine. Less is not. If content needs to touch the edge
(e.g. a full-bleed photo), the photo itself goes edge-to-edge but any text overlay sits
inside the safe area.

### Layer 2 — content-surface inset

Treat a visible boundary as a promise of interior space: if an element paints a
`background`, `border`, `outline`, `box-shadow`, rounded surface, or backdrop blur around
content, that same element must own non-zero padding on all four sides.

| Surface type | Recommended inset |
| ------------ | ----------------- |
| Card, panel, callout, compare column, quote box | `clamp(24px, 2.5vw, 48px)` on all sides |
| Compact badge, chip, or pill | about `.45em .85em` |
| Text panel over full-bleed media | `clamp(24px, 2.5vw, 48px)` on all sides |

The scaffolds expose `--surface-inset` and `.slide-surface`. Use the helper on ordinary
content surfaces, then add the desired colour, border, radius, or shadow:

```html
<article class="slide-surface rounded-3xl border border-black/10 bg-white/80">
  <!-- text and icons now have a real inset from every edge -->
</article>
```

```tsx
<article className="slide-surface rounded-3xl border border-black/10 bg-white/80">
  {/* content */}
</article>
```

For a two-column comparison, put `gap` on the grid **and** `.slide-surface` on each
column. Nested visible surfaces each own their own inset; outer padding never excuses an
inner surface from having padding.

Intentional exceptions are narrow: an image/video crop, a decorative wrapper that owns
no text or primary content, or a background layer may touch its box. If text overlays
that media, place the text in a nested `.slide-surface` rather than directly against the
media boundary.

### Spacing acceptance test

Inspect every slide at 1920×1080 and one smaller viewport before handoff:

- No text, icon, chart label, or other primary content crosses the viewport safe area.
- Every content-bearing element with a visible boundary has padding on all four sides.
- No card relies on grid `gap`, child margin, or the slide's padding as its inner inset.
- Full-bleed media may reach an edge; any text overlay remains inside a padded surface.
- Padding remains visible after resizing; it is not cancelled by a local `p-0`,
  `padding: 0`, negative margin, or absolute positioning.

## Content overflow

If a slide has more content than fits (dense bullets, a big table, a long quote), the
slide's content area scrolls vertically rather than clipping. This is a safety net, not a
design goal — prefer splitting into two slides when practical. But clipping is worse than
scrolling, because the presenter silently loses content without realising.

Both scaffolds set `overflow-y: auto` on the content area. The scrollbar is the browser's
native default — no custom styling.

## Required chrome on every deck

- A visible **navigation slider** (the dot strip) and **slide number** at the bottom,
  so the presenter can jump around live. Both scaffolds include this — keep it.
- Keyboard navigation: → / Space / PageDown advance; ← / PageUp go back; Home/End jump.

## Slide layout recipes

Reach for these instead of inventing structure each time. (Tailwind classes shown for
the React track; the plain-HTML template uses equivalent inline styles.)

**Title** — badge top, big headline + one-line lead centre, presenter line bottom.
`flex flex-col justify-between`, headline `clamp(64px,9vw,120px) font-black`.

**Bulleted point** — `h2` heading + 3–5 short bullets, generous `gap`. Keep bullets to
one line each; if a bullet wraps twice, split the slide.

**Two-column compare** — `grid grid-cols-2 gap-12`, each column a card
(`slide-surface rounded-3xl`). The grid gap separates the cards; `.slide-surface` keeps
content away from each card's own boundary. Use for before/after, problem/solution,
myth/reality.

**Big stat** — one huge number (`clamp(120px,18vw,260px)`) + a short caption. One stat
per slide; the number is the whole point.

**Quote** — centred, large italic/serif line, attribution as caption below.

**Full-bleed image** — `fullBleed` slide, image `object-cover` filling the frame, text
in an overlaid `.slide-surface` panel with a translucent/blurred background for contrast.

## Motion (React track: Framer Motion)

- Slide transitions are handled by `Deck` (a short cross-fade). Don't fight it.
- Inside a slide, animate entrance with small `initial → animate` offsets
  (`y: 24, opacity: 0` → `y: 0, opacity: 1`, ~0.4s), staggering with `delay`. Subtle
  beats flashy — motion should guide the eye, not perform.
- For step-by-step reveals, drive a local `useState` step counter from the same keyboard
  handler pattern, or split into separate slides (simpler and usually better).

## Optional: ambient background

A drifting gradient backdrop adds polish but is never required and must never reduce
text contrast. If you want it, the pattern (from real decks) is: 2–3 large blurred
radial "blobs" absolutely positioned with slow CSS keyframe drift, plus optional
floating dust motes. Keep it behind a `z-index` floor and `pointer-events: none`.
Reference implementation lives in the repo decks; copy and re-tint per deck palette.

## Palette

The scaffolds ship a warm neutral default (`--bg #f8f3e7`, `--ink #1f2430`,
`--accent #9d6248`, `--soft #6d6a66`). Replace per deck/brand — change the CSS variables
(HTML) or the hex values in `Deck`/`Slide`/`index.css` (React). Keep one accent colour
and use it consistently for emphasis.
