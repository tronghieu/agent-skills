# Vite + React track

Use this when the deck is substantial: many slides, reusable slide components,
state-driven interactions, TypeScript, Framer Motion, or an embedded live demo. This is
the default for talks you will maintain and re-run.

## Scaffold

```bash
bash scripts/new-react-deck.sh <deck-name> [target-dir] [--no-install]
```

This deliberately **does not pin versions**. It runs the official Vite scaffolder
(`npm create vite@latest -- --template react-ts`) and installs the **latest** React,
`framer-motion`, `lucide-react`, `tailwindcss`, and `@tailwindcss/vite`. Then it writes
the deck architecture on top. So each new deck starts on current tooling.

Then:

```bash
cd <deck-name>
npm run dev      # local dev with HMR
npm run build    # production build into dist/
```

## Architecture

```
src/
  App.tsx              renders <Deck/>
  components/
    Deck.tsx           navigation: keyboard, prev/next, dot strip, slide counter
    Slide.tsx          shared slide frame (padding, max-width, fullBleed option)
  slides/
    index.ts           ordered array of slide components — the source of slide order
    00-Title.tsx       one component per slide
  index.css            Tailwind import + base typography
```

- **`Deck`** owns all navigation and the required bottom slider + slide number. You
  rarely edit it; it reads `slides` from `src/slides/index.ts`.
- **`Slide`** is the frame every slide renders inside. It always applies safe-area
  padding so content never touches the viewport edge. Use `fullBleed` for slides where
  the **background** goes edge-to-edge (title, full image, colour block) — the background
  fills the frame, but text content still has a smaller safe-area inset. Without
  `fullBleed`, the slide uses a wider padding and a centred, max-width column.

  If content exceeds the slide height, the inner area scrolls vertically (browser-native
  scrollbar). Prefer splitting into more slides when practical.

## Adding / reordering slides

1. Create `src/slides/NN-Name.tsx` exporting a component that returns `<Slide>...</Slide>`.
2. Import it in `src/slides/index.ts` and add it to the `slides` array.
3. Reorder by reordering that array — it is the single source of truth for order.

Name files with a zero-padded numeric prefix (`00-`, `01-`) matching narrative order so
the directory reads top-to-bottom.

## Typography in JSX

Honour the floor (see design-system.md). Always use fluid `clamp()` — not fixed px, rem,
or Tailwind text size classes (`text-sm`, `text-base`, `text-4xl` — these are fixed rem
values that don't scale with the viewport).

- Hero heading: `style={{ fontSize: 'clamp(56px, 7.5vw, 100px)' }}`
- Lead / subtitle: `style={{ fontSize: 'clamp(30px, 2.9vw, 48px)' }}`
- Body text: `style={{ fontSize: 'clamp(28px, 2.6vw, 44px)' }}`
- Caption: `style={{ fontSize: 'clamp(22px, 1.9vw, 36px)' }}`

See the full clamp() cheatsheet in `references/design-system.md`. Tune the `max` per
slide — tighten toward the floor on dense slides, push toward the ceiling on sparse ones.

The slide-number in `Deck` is the one exception — it's nav chrome, not slide content.

## Tailwind wiring (verify against current docs if it ever breaks)

The scaffold wires Tailwind the v4 way:

- `vite.config.ts` uses the `@tailwindcss/vite` plugin (no `postcss.config.js`, no
  `tailwind.config.js` required).
- `src/index.css` starts with `@import "tailwindcss";`.

If a future Tailwind version changes setup, follow `tailwindcss.com` install-for-Vite
docs and adjust those two spots. The deck components themselves are framework-version
independent and won't need changes.

## Framer Motion

- Slide-to-slide transition is handled in `Deck` (cross-fade). Leave it.
- Animate inside slides with small entrance offsets and short durations (~0.4s), staggered
  via `delay`. See `00-Title.tsx` for the pattern.

## Embedded live demos

If the talk demos a real product, keep that demo as a **separate project** (its own
folder/app), not inside the deck. Link to it or screen-switch during the talk. Mixing a
real app into the deck blurs "projection" and "product" and makes both harder to run.
