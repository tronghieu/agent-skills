#!/usr/bin/env bash
# new-react-deck.sh — scaffold a Vite + React + TypeScript interactive presentation.
#
# Usage:  bash new-react-deck.sh <deck-name> [target-dir] [--no-install]
#
# It does NOT pin versions: it runs the official Vite scaffolder and installs the
# latest React, Tailwind, Framer Motion and Lucide. That way the deck always starts
# on current tooling. It then layers the deck architecture on top:
#
#   src/App.tsx               renders <Deck/>
#   src/components/Deck.tsx    navigation: arrows, dots, slide counter, keyboard
#   src/components/Slide.tsx   shared slide frame
#   src/slides/index.ts        ordered list of slides (add/reorder here)
#   src/slides/00-Title.tsx    sample title slide
#
# Tailwind is wired the v4 way (@tailwindcss/vite plugin + `@import "tailwindcss"`).
# If a future Tailwind changes its setup, check the latest docs and adjust the two
# wiring spots flagged below — the deck code itself is version-independent.

set -euo pipefail

NAME="${1:-}"
if [[ -z "$NAME" ]]; then
  echo "Usage: bash new-react-deck.sh <deck-name> [target-dir] [--no-install]" >&2
  exit 1
fi

TARGET_DIR="."
DO_INSTALL=1
shift || true
while [[ $# -gt 0 ]]; do
  case "$1" in
    --no-install) DO_INSTALL=0; shift;;
    *) TARGET_DIR="$1"; shift;;
  esac
done

DECK_DIR="$TARGET_DIR/$NAME"
if [[ -e "$DECK_DIR" ]]; then
  echo "Refusing to overwrite existing path: $DECK_DIR" >&2
  exit 1
fi

echo "→ Scaffolding Vite (react-ts) at $DECK_DIR ..."
npm create vite@latest "$DECK_DIR" -- --template react-ts >/dev/null

cd "$DECK_DIR"

if [[ "$DO_INSTALL" -eq 1 ]]; then
  echo "→ Installing dependencies (latest) ..."
  npm install >/dev/null
  npm install framer-motion lucide-react >/dev/null
  npm install -D tailwindcss @tailwindcss/vite >/dev/null
fi

# --- Tailwind wiring spot #1: Vite plugin ------------------------------------
cat > vite.config.ts <<'EOF'
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
import tailwindcss from '@tailwindcss/vite'

export default defineConfig({
  plugins: [react(), tailwindcss()],
})
EOF

# --- Tailwind wiring spot #2: CSS entry + base styles ------------------------
cat > src/index.css <<'EOF'
@import url('https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&family=Outfit:wght@500;600;700;800;900&display=swap');
@import "tailwindcss";

* { box-sizing: border-box; margin: 0; padding: 0; }
html, body, #root { width: 100%; height: 100%; overflow: hidden; }
body {
  font-family: 'Plus Jakarta Sans', system-ui, -apple-system, sans-serif;
  color: #1f2430;
  background: #f8f3e7;
  -webkit-font-smoothing: antialiased;
}
h1, h2, h3 { font-family: 'Outfit', system-ui, sans-serif; }
button { font: inherit; }
EOF

cat > src/App.tsx <<'EOF'
import Deck from './components/Deck'

export default function App() {
  return <Deck />
}
EOF

mkdir -p src/components src/slides
rm -f src/App.css  # default Vite styles; the deck supplies its own in index.css

cat > src/components/Slide.tsx <<'EOF'
import type { ReactNode } from 'react'

const NAV_HEIGHT = 64

interface SlideProps {
  children: ReactNode
  className?: string
  /**
   * fullBleed: the slide's background fills edge-to-edge (for images, gradients,
   * colour blocks), but content still gets safe-area padding so text never hugs
   * the viewport edge. The padding is smaller than on a normal slide.
   */
  fullBleed?: boolean
}

/**
 * Shared slide frame. Fills the viewport above the nav bar and centres content
 * in a readable column.
 *
 * Safe-area padding is always applied — even on fullBleed slides — so content
 * never touches the viewport edge. Do not override it to zero.
 *
 * If content exceeds the slide height, the inner area scrolls vertically
 * (browser-native scrollbar). Prefer splitting into more slides when practical,
 * but clipping is worse than scrolling.
 */
export default function Slide({ children, className = '', fullBleed = false }: SlideProps) {
  return (
    <div
      className={`w-full overflow-hidden ${className}`}
      style={{ height: `calc(100vh - ${NAV_HEIGHT}px)` }}
    >
      <div
        className={`flex h-full w-full flex-col ${
          fullBleed
            ? 'px-10 py-8'          /* safe-area: smaller but never zero */
            : 'justify-center px-16 py-14'
        }`}
        style={{
          maxWidth: fullBleed ? '100%' : '1500px',
          margin: '0 auto',
          minHeight: 0,
          overflowY: 'auto',
        }}
      >
        {children}
      </div>
    </div>
  )
}
EOF

cat > src/components/Deck.tsx <<'EOF'
import { useCallback, useEffect, useState } from 'react'
import { AnimatePresence, motion } from 'framer-motion'
import { ChevronLeft, ChevronRight } from 'lucide-react'
import { slides } from '../slides'

const NAV_HEIGHT = 64

/**
 * Owns slide navigation for the whole deck: keyboard (arrows / space / home / end),
 * prev/next buttons, a clickable dot strip and a slide counter. A visible slider
 * and slide number are required on every deck so the presenter can jump around live.
 */
export default function Deck() {
  const [current, setCurrent] = useState(0)
  const total = slides.length

  const go = useCallback(
    (i: number) => setCurrent(() => Math.max(0, Math.min(total - 1, i))),
    [total],
  )

  useEffect(() => {
    function onKey(e: KeyboardEvent) {
      if (e.key === 'ArrowRight' || e.key === ' ' || e.key === 'PageDown') {
        e.preventDefault()
        go(current + 1)
      } else if (e.key === 'ArrowLeft' || e.key === 'PageUp') {
        e.preventDefault()
        go(current - 1)
      } else if (e.key === 'Home') {
        go(0)
      } else if (e.key === 'End') {
        go(total - 1)
      }
    }
    window.addEventListener('keydown', onKey)
    return () => window.removeEventListener('keydown', onKey)
  }, [current, go, total])

  const CurrentSlide = slides[current]

  return (
    <div className="flex h-screen w-full flex-col bg-[#f8f3e7]">
      <div className="relative flex-1 overflow-hidden">
        <AnimatePresence mode="wait">
          <motion.div
            key={current}
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            exit={{ opacity: 0 }}
            transition={{ duration: 0.3, ease: 'easeInOut' }}
            className="absolute inset-0"
          >
            <CurrentSlide />
          </motion.div>
        </AnimatePresence>
      </div>

      <div
        className="flex shrink-0 items-center gap-4 border-t border-black/10 bg-white/80 px-6 backdrop-blur"
        style={{ height: NAV_HEIGHT }}
      >
        <button
          onClick={() => go(current - 1)}
          disabled={current === 0}
          className="flex h-9 w-9 items-center justify-center rounded-lg text-[#1f2430] disabled:opacity-25"
          aria-label="Slide trước"
        >
          <ChevronLeft size={22} />
        </button>

        <div className="flex flex-1 items-center justify-center gap-2 overflow-x-auto">
          {slides.map((_, index) => (
            <button
              key={index}
              onClick={() => go(index)}
              aria-label={`Slide ${index + 1}`}
              className="shrink-0 rounded-full transition-all"
              style={{
                width: index === current ? 26 : 10,
                height: 10,
                backgroundColor: index === current ? '#9d6248' : '#d5c8b4',
              }}
            />
          ))}
        </div>

        <div className="min-w-16 text-center text-base font-medium tabular-nums text-[#6d6a66]">
          {current + 1} / {total}
        </div>

        <button
          onClick={() => go(current + 1)}
          disabled={current === total - 1}
          className="flex h-9 w-9 items-center justify-center rounded-lg text-[#1f2430] disabled:opacity-25"
          aria-label="Slide sau"
        >
          <ChevronRight size={22} />
        </button>
      </div>
    </div>
  )
}
EOF

cat > src/slides/00-Title.tsx <<'EOF'
import { motion } from 'framer-motion'
import Slide from '../components/Slide'

export default function TitleSlide() {
  return (
    <Slide fullBleed>
      {/* Slide.tsx applies safe-area padding automatically on fullBleed slides.
          No need to add px-16 py-14 manually — content is already inset. */}
      <div className="flex h-full flex-col justify-between">
        <div className="flex items-start justify-between">
          <span className="inline-flex items-center rounded-full bg-[#9d62481a] px-6 py-3 text-2xl font-bold text-[#9d6248]">
            DECK · 2026
          </span>
        </div>

        <div className="flex flex-col gap-8">
          <motion.h1
            initial={{ opacity: 0, y: 24 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.45, ease: 'easeOut' }}
            className="font-black leading-[1.0] tracking-tight text-[#1f2430]"
            style={{ fontSize: 'clamp(56px, 7.5vw, 100px)' }}
          >
            Tiêu đề bài nói
          </motion.h1>
          <motion.p
            initial={{ opacity: 0, y: 18 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.45, delay: 0.12, ease: 'easeOut' }}
            className="max-w-4xl text-[#6d6a66]"
            style={{ fontSize: 'clamp(26px, 2.8vw, 40px)', lineHeight: 1.4 }}
          >
            Một dòng dẫn ngắn, nói thẳng bài này nói về điều gì.
          </motion.p>
        </div>

        <p className="text-[#6d6a66]" style={{ fontSize: 'clamp(20px, 1.8vw, 32px)' }}>
          Tên người trình bày · Vai trò
        </p>
      </div>
    </Slide>
  )
}
EOF

cat > src/slides/index.ts <<'EOF'
import TitleSlide from './00-Title'

// Add a slide: create src/slides/NN-Name.tsx, import it, and place it in this list.
// Reorder slides by reordering this array — it is the single source of slide order.
export const slides = [
  TitleSlide,
]
EOF

# Point the page <title> at the deck name.
if [[ -f index.html ]]; then
  python3 - "index.html" "$NAME" <<'PYEOF'
import re, sys
path, name = sys.argv[1], sys.argv[2]
s = open(path, encoding="utf-8").read()
s = re.sub(r"<title>.*?</title>", f"<title>{name}</title>", s, flags=re.S)
open(path, "w", encoding="utf-8").write(s)
PYEOF
fi

cat > "$NAME-notes.md" <<NOTESEOF
# $NAME — speaker notes

> Không chiếu. Dùng để chuẩn bị narrative, dàn bài, ghi chú nói.

## Dàn bài
1.

## Speaker notes theo slide
- 00 Title:
NOTESEOF

echo ""
echo "✅ Created Vite + React deck: $DECK_DIR"
echo "   cd \"$DECK_DIR\" && npm run dev"
echo "   Slides: src/slides/  (order is controlled by src/slides/index.ts)"
echo "   Speaker notes: $DECK_DIR/$NAME-notes.md"
if [[ "$DO_INSTALL" -eq 0 ]]; then
  echo "   ⚠ Dependencies NOT installed (--no-install). Run: npm install && npm install framer-motion lucide-react && npm install -D tailwindcss @tailwindcss/vite"
fi
