#!/usr/bin/env bash
# new-html-deck.sh — scaffold a plain-HTML interactive presentation (no build step).
#
# Usage:  bash new-html-deck.sh <deck-name> [target-dir] [--title "Deck title"]
#
# Creates:
#   <target-dir>/<deck-name>/index.html        single self-contained deck (Tailwind via CDN)
#   <target-dir>/<deck-name>/assets/           images, icons, video
#   <target-dir>/<deck-name>/<deck-name>-notes.md   speaker notes (not projected)
#
# The deck runs by opening index.html directly in a browser — no server, no install.
# The template is fluid: slides fill the whole viewport at any aspect ratio (no fixed
# stage, no letterbox/pillarbox bars). Type scales with clamp() so it stays
# projection-legible. Edit the <section class="slide"> blocks.

set -euo pipefail

NAME="${1:-}"
if [[ -z "$NAME" ]]; then
  echo "Usage: bash new-html-deck.sh <deck-name> [target-dir] [--title \"...\"]" >&2
  exit 1
fi

TARGET_DIR="."
TITLE="$NAME"
shift || true
while [[ $# -gt 0 ]]; do
  case "$1" in
    --title) TITLE="${2:-$NAME}"; shift 2;;
    *) TARGET_DIR="$1"; shift;;
  esac
done

DECK_DIR="$TARGET_DIR/$NAME"
if [[ -e "$DECK_DIR" ]]; then
  echo "Refusing to overwrite existing path: $DECK_DIR" >&2
  exit 1
fi

mkdir -p "$DECK_DIR/assets"

cat > "$DECK_DIR/index.html" <<HTMLEOF
<!doctype html>
<html lang="vi">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>__TITLE__</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <link rel="preconnect" href="https://fonts.googleapis.com" />
  <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&family=Outfit:wght@500;600;700;800;900&display=swap" rel="stylesheet" />
  <style>
    :root { --accent:#9d6248; --ink:#1f2430; --bg:#f8f3e7; --soft:#6d6a66; }
    * { box-sizing:border-box; margin:0; padding:0; }
    html, body { width:100%; height:100%; overflow:hidden; background:var(--bg); }
    body { font-family:'Plus Jakarta Sans', system-ui, sans-serif; color:var(--ink); }
    h1,h2,h3 { font-family:'Outfit', system-ui, sans-serif; }

    /* Fluid layout. Slides fill the whole viewport at any aspect ratio — no fixed
       stage, so no letterbox/pillarbox bars on 16:10 laptops, ultrawides, or resized
       windows. Type scales with clamp() so it stays projection-legible. Author with
       clamp()/em/%/vh — not fixed px — so the deck breathes across screen sizes. */
    #viewport { position:fixed; inset:0 0 64px 0; overflow:hidden; }
    .slide {
      position:absolute; inset:0;
      /* Safe-area padding — keeps content away from the viewport edge. Do NOT
         override to zero; content that hugs the edge looks unfinished and is
         hard to read when projected. See references/design-system.md. */
      padding:clamp(40px,5.5vh,96px) clamp(48px,6.2vw,140px);
      display:none; flex-direction:column;
      opacity:0; transition:opacity .35s ease;
    }
    .slide.active { display:flex; opacity:1; }
    /* Scrollable content area — if content exceeds the slide height, it scrolls
       rather than clipping. The scrollbar is the browser's native default. */
    .slide-content {
      flex:1; min-height:0;
      display:flex; flex-direction:column;
      overflow-y:auto;
    }

    /* Typography — fluid clamp(min, vw/vh, max). These are MID-RANGE defaults; each
       role has a legible range (see references/design-system.md) and the `max` here is
       the projection size. Tune the `max` PER SLIDE, not these globals:
         - text-heavy slide  -> lower the max toward the floor so it doesn't overflow
                                 (body floor 40px; caption 32px; never below)
         - sparse/hero slide -> raise the max toward the ceiling for presence.
       Override on the specific <section>/element; keep these globals as the default. */
    .slide          { font-size:clamp(28px,2.6vw,44px); line-height:1.45; }
    .slide h1       { font-size:clamp(56px,6.4vw,104px); line-height:1.04; letter-spacing:-.03em; font-weight:900; }
    .slide h2       { font-size:clamp(38px,3.4vw,60px);  line-height:1.12; font-weight:800; }
    .slide .lead    { font-size:clamp(30px,2.9vw,48px);  color:var(--soft); }
    .slide .caption { font-size:clamp(22px,1.9vw,36px);  color:var(--soft); }
    .slide ul       { list-style:none; display:flex; flex-direction:column; gap:clamp(16px,2.4vh,28px); }
    .slide li       { display:flex; gap:.55em; align-items:flex-start; }
    .slide li::before { content:''; flex:none; width:.42em; height:.42em; margin-top:.5em; border-radius:.12em; background:var(--accent); }

    /* Bottom navigation bar — required on every deck. */
    #nav {
      position:fixed; left:0; right:0; bottom:0; height:64px; z-index:50;
      display:flex; align-items:center; justify-content:center; gap:20px;
      background:rgba(255,255,255,.82); backdrop-filter:blur(10px);
      border-top:1px solid rgba(0,0,0,.06);
    }
    #nav button { cursor:pointer; border:none; background:none; color:var(--ink); padding:8px 12px; font-size:18px; border-radius:10px; }
    #nav button:disabled { opacity:.25; cursor:default; }
    #dots { display:flex; gap:8px; align-items:center; max-width:60vw; overflow-x:auto; }
    .dot { width:10px; height:10px; border-radius:999px; background:#d5c8b4; border:none; cursor:pointer; transition:all .2s; flex:none; }
    .dot.active { width:26px; background:var(--accent); }
    #counter { font-size:18px; color:var(--soft); font-variant-numeric:tabular-nums; min-width:64px; text-align:center; }
  </style>
</head>
<body>
  <div id="viewport">

    <!-- ============ SLIDES ============ -->
    <!-- Each <section class="slide"> is one slide. The first one needs class "active".
         Wrap slide content in a <div class="slide-content"> so it scrolls if it overflows.
         Do NOT remove the .slide padding — content must stay inside the safe area. -->

    <section class="slide active">
      <div class="slide-content" style="justify-content:space-between;">
        <div style="display:flex; justify-content:space-between; align-items:flex-start;">
          <span style="display:inline-flex; align-items:center; background:rgba(157,98,72,.1); color:var(--accent); font-weight:700; padding:.45em .85em; border-radius:999px; font-size:clamp(20px,1.7vw,32px);">__NAME__</span>
        </div>
        <div style="display:flex; flex-direction:column; gap:clamp(20px,3vh,40px);">
          <h1>__TITLE__</h1>
          <p class="lead" style="max-width:28em;">Thay câu này bằng một dòng dẫn nói rõ bài này nói về điều gì — ngắn, thẳng, như đang nói trên sân khấu.</p>
        </div>
        <p class="caption">Tên người trình bày · Vai trò</p>
      </div>
    </section>

    <section class="slide">
      <div class="slide-content" style="gap:clamp(24px,4vh,52px); justify-content:center;">
        <h2>Tiêu đề slide nội dung</h2>
        <ul>
          <li>Ý chính thứ nhất — ngắn gọn, mỗi dòng một ý.</li>
          <li>Ý chính thứ hai — dùng visual thật khi cần minh họa.</li>
          <li>Ý chính thứ ba — tránh nhồi quá nhiều chữ vào một slide.</li>
        </ul>
      </div>
    </section>

    <section class="slide">
      <div class="slide-content" style="align-items:center; justify-content:center; text-align:center;">
        <h1 style="max-width:16em;">Một câu trích dẫn lớn để nhấn mạnh.</h1>
        <p class="caption" style="margin-top:1em;">— Nguồn trích dẫn</p>
      </div>
    </section>

    <!-- Copy a <section class="slide"> block above to add more slides.
         Always include the <div class="slide-content"> wrapper inside. -->
    <!-- ============ /SLIDES ============ -->

  </div>

  <nav id="nav">
    <button id="prev" aria-label="Slide trước">&larr; Trước</button>
    <div id="dots"></div>
    <span id="counter"></span>
    <button id="next" aria-label="Slide sau">Sau &rarr;</button>
  </nav>

  <script>
    const slides = Array.from(document.querySelectorAll('.slide'));
    const dotsBox = document.getElementById('dots');
    const counter = document.getElementById('counter');
    const prevBtn = document.getElementById('prev');
    const nextBtn = document.getElementById('next');
    let current = slides.findIndex(s => s.classList.contains('active'));
    if (current < 0) current = 0;

    slides.forEach((_, i) => {
      const d = document.createElement('button');
      d.className = 'dot';
      d.setAttribute('aria-label', 'Slide ' + (i + 1));
      d.addEventListener('click', () => go(i));
      dotsBox.appendChild(d);
    });
    const dots = Array.from(dotsBox.children);

    function render() {
      slides.forEach((s, i) => s.classList.toggle('active', i === current));
      dots.forEach((d, i) => d.classList.toggle('active', i === current));
      counter.textContent = (current + 1) + ' / ' + slides.length;
      prevBtn.disabled = current === 0;
      nextBtn.disabled = current === slides.length - 1;
    }
    function go(i) { current = Math.max(0, Math.min(slides.length - 1, i)); render(); }

    prevBtn.addEventListener('click', () => go(current - 1));
    nextBtn.addEventListener('click', () => go(current + 1));
    window.addEventListener('keydown', (e) => {
      if (e.key === 'ArrowRight' || e.key === ' ' || e.key === 'PageDown') { e.preventDefault(); go(current + 1); }
      else if (e.key === 'ArrowLeft' || e.key === 'PageUp') { e.preventDefault(); go(current - 1); }
      else if (e.key === 'Home') go(0);
      else if (e.key === 'End') go(slides.length - 1);
    });

    // Fluid layout: slides fill #viewport via CSS, so there is nothing to scale on
    // resize. Type uses clamp(), so it adapts to the viewport automatically.
    render();
  </script>
</body>
</html>
HTMLEOF

# Substitute placeholders without tripping shell expansion inside the heredoc.
python3 - "$DECK_DIR/index.html" "$TITLE" "$NAME" <<'PYEOF'
import sys
path, title, name = sys.argv[1], sys.argv[2], sys.argv[3]
s = open(path, encoding="utf-8").read()
s = s.replace("__TITLE__", title).replace("__NAME__", name)
open(path, "w", encoding="utf-8").write(s)
PYEOF

cat > "$DECK_DIR/$NAME-notes.md" <<NOTESEOF
# $TITLE — speaker notes

> Không chiếu. Dùng để chuẩn bị narrative, dàn bài, ghi chú nói.

## Dàn bài
1.

## Speaker notes theo slide
- Slide 1 (Title):
- Slide 2:
- Slide 3:
NOTESEOF

echo "✅ Created plain-HTML deck: $DECK_DIR"
echo "   Open in browser:   open \"$DECK_DIR/index.html\""
echo "   Slides live inside the <!-- SLIDES --> block in index.html."
echo "   Speaker notes:     $DECK_DIR/$NAME-notes.md"
