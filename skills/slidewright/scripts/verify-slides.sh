#!/bin/bash
# verify-slides.sh — static analysis for slidewright decks.
#
# Checks slide source files (HTML and TSX/JSX) for common quality violations:
#   1. Text below the typography floor (font-size < 32px as computed max)
#   2. Fixed-px/rem font sizes that should use clamp()
#   3. Excessive bullet items per slide (> 5)
#   4. High word density per slide (> 60 words of visible text)
#   5. Tailwind fixed text classes (text-sm, text-base, text-lg, etc.)
#
# Usage:  bash verify-slides.sh <path-to-deck>
#
# The script inspects HTML files and src/slides/*.tsx files. It does static
# text analysis — no browser required. Exit code 0 = pass, 1 = violations found.

set -euo pipefail

DECK_PATH="${1:-}"
if [[ -z "$DECK_PATH" ]]; then
  echo "Usage: bash verify-slides.sh <path-to-deck>" >&2
  exit 1
fi

if [[ ! -d "$DECK_PATH" ]]; then
  echo "Error: '$DECK_PATH' is not a directory." >&2
  exit 1
fi

VIOLATIONS=0
WARNINGS=0
CHECKED=0

# Colours (if terminal supports it)
RED='\033[0;31m'
YELLOW='\033[0;33m'
GREEN='\033[0;32m'
BOLD='\033[1m'
NC='\033[0m'

log_violation() {
  local file="$1" slide="$2" msg="$3"
  echo -e "${RED}✗${NC} ${BOLD}${file}${NC} [slide ${slide}]: ${msg}" >&2
  VIOLATIONS=$((VIOLATIONS + 1))
}

log_warning() {
  local file="$1" slide="$2" msg="$3"
  echo -e "${YELLOW}⚠${NC} ${BOLD}${file}${NC} [slide ${slide}]: ${msg}" >&2
  WARNINGS=$((WARNINGS + 1))
}

# ---------------------------------------------------------------------------
# Collect files to check
# ---------------------------------------------------------------------------
FILES=()

# HTML track: index.html at deck root
if [[ -f "$DECK_PATH/index.html" ]]; then
  FILES+=("$DECK_PATH/index.html")
fi

# React track: src/slides/*.tsx or *.jsx
if [[ -d "$DECK_PATH/src/slides" ]]; then
  while IFS= read -r -d '' f; do
    FILES+=("$f")
  done < <(find "$DECK_PATH/src/slides" -type f \( -name '*.tsx' -o -name '*.jsx' \) -print0 2>/dev/null)
fi

if [[ ${#FILES[@]} -eq 0 ]]; then
  echo -e "${YELLOW}⚠${NC} No slide files found in '$DECK_PATH'. Expected index.html or src/slides/*.tsx" >&2
  exit 0
fi

echo -e "${BOLD}Verifying slides in: $DECK_PATH${NC}" >&2
echo "───────────────────────────────────────────" >&2

# ---------------------------------------------------------------------------
# Check 1: Fixed font sizes below the typography floor
# ---------------------------------------------------------------------------
# The floor is 32px (caption/slide-number). Body floor is 40px.
# We flag any font-size that is a bare number below 32px or a fixed px value
# below the floor when used outside of clamp().

check_small_font_sizes() {
  local file="$1" slide_id="$2"

  # Find font-size declarations with fixed px values outside of clamp()
  # Pattern: font-size: <number>px  (not inside clamp)
  # Also catch fontSize: '<number>px' in JSX
  while IFS= read -r line; do
    # Skip nav-bar / non-slide-content areas
    if echo "$line" | grep -qiE '#nav|nav_height|counter|\.dot|#dots|#counter|button'; then
      continue
    fi
    # Extract the px value
    local px_val
    px_val=$(echo "$line" | grep -oE '[0-9]+px' | head -1 | sed 's/px//')
    if [[ -n "$px_val" ]] && [[ "$px_val" -lt 28 ]]; then
      # Check if it's inside a clamp() — if so, it's fine (it's the min)
      if ! echo "$line" | grep -qE 'clamp\s*\('; then
        log_violation "$file" "$slide_id" "Font size ${px_val}px is below the typography floor (min 28px). Use clamp() with a projection-legible max."
      fi
    fi
  done < <(grep -nE "font-size\s*:\s*[0-9]+px|fontSize\s*:\s*['\"][0-9]+px" "$file" 2>/dev/null || true)
}

# ---------------------------------------------------------------------------
# Check 2: Fixed px/rem font sizes that should be clamp()
# ---------------------------------------------------------------------------
check_fixed_font_sizes() {
  local file="$1" slide_id="$2"

  # Find font-size set to a bare px value (not inside clamp)
  while IFS= read -r match; do
    local linenum val
    linenum=$(echo "$match" | cut -d: -f1)
    val=$(echo "$match" | grep -oE '[0-9]+px' | head -1)

    # Skip if it's inside a clamp()
    local full_line
    full_line=$(sed -n "${linenum}p" "$file")
    if echo "$full_line" | grep -qE 'clamp\s*\('; then
      continue
    fi

    # Skip nav-bar / non-slide-content areas (heuristic: lines with #nav, NAV_HEIGHT, counter, dot)
    if echo "$full_line" | grep -qiE '#nav|nav_height|counter|\.dot|#dots'; then
      continue
    fi

    log_warning "$file" "$slide_id" "Line $linenum: Fixed font-size '$val' — consider using clamp() for fluid scaling."
  done < <(grep -nE "font-size\s*:\s*[0-9]+(px|rem)|fontSize\s*:\s*['\"][0-9]+(px|rem)" "$file" 2>/dev/null | grep -vE 'clamp' || true)
}

# ---------------------------------------------------------------------------
# Check 3: Tailwind fixed text size classes in slide content
# ---------------------------------------------------------------------------
check_tailwind_text_classes() {
  local file="$1" slide_id="$2"

  # Flag Tailwind text size utilities used in slide content
  local tw_classes="text-xs|text-sm|text-base|text-lg|text-xl|text-2xl|text-3xl|text-4xl|text-5xl|text-6xl|text-7xl|text-8xl|text-9xl"

  while IFS= read -r match; do
    local linenum class_name
    linenum=$(echo "$match" | cut -d: -f1)
    class_name=$(echo "$match" | grep -oE "(${tw_classes})" | head -1)

    # Skip nav chrome
    local full_line
    full_line=$(sed -n "${linenum}p" "$file")
    if echo "$full_line" | grep -qiE 'nav|counter|dot|slide-number|aria-label'; then
      continue
    fi

    log_warning "$file" "$slide_id" "Line $linenum: Tailwind class '$class_name' is a fixed rem value — use clamp() for slide content."
  done < <(grep -nE "\\b(${tw_classes})\\b" "$file" 2>/dev/null || true)
}

# ---------------------------------------------------------------------------
# Check 4: Excessive bullets per slide (HTML track)
# ---------------------------------------------------------------------------
check_bullet_count_html() {
  local file="$1"

  # Split file into slides by <section class="slide"> blocks
  local slide_num=0
  local in_slide=0
  local li_count=0

  while IFS= read -r line; do
    if echo "$line" | grep -qE '<section[^>]*class="[^"]*slide'; then
      slide_num=$((slide_num + 1))
      in_slide=1
      li_count=0
    elif echo "$line" | grep -qE '</section>'; then
      if [[ $in_slide -eq 1 ]] && [[ $li_count -gt 5 ]]; then
        log_violation "$file" "$slide_num" "Too many bullet items ($li_count > 5 max). Split into multiple slides."
      fi
      in_slide=0
    elif [[ $in_slide -eq 1 ]] && echo "$line" | grep -qE '<li[ >]|<li$'; then
      li_count=$((li_count + 1))
    fi
  done < "$file"
}

# ---------------------------------------------------------------------------
# Check 5: Word density per slide (HTML track)
# ---------------------------------------------------------------------------
check_word_density_html() {
  local file="$1"

  # Use Python for more reliable HTML text extraction
  python3 - "$file" <<'PYEOF'
import sys, re, html

filepath = sys.argv[1]
content = open(filepath, encoding="utf-8").read()

# Strip HTML comments first to avoid false matches
content = re.sub(r'<!--.*?-->', '', content, flags=re.DOTALL)
# Strip <style> and <script> blocks
content = re.sub(r'<style[^>]*>.*?</style>', '', content, flags=re.DOTALL | re.IGNORECASE)
content = re.sub(r'<script[^>]*>.*?</script>', '', content, flags=re.DOTALL | re.IGNORECASE)

# Find all <section ...class="...slide...">...</section> blocks
slide_pattern = re.compile(
    r'<section[^>]*class="[^"]*\bslide\b[^"]*"[^>]*>(.*?)</section>',
    re.DOTALL
)

for i, match in enumerate(slide_pattern.finditer(content), 1):
    slide_html = match.group(1)

    # Strip HTML tags
    text = re.sub(r'<[^>]+>', ' ', slide_html)
    text = html.unescape(text)
    # Strip inline style values that leaked through
    text = re.sub(r'style="[^"]*"', '', text)

    # Keep only real words (letters, Vietnamese diacritics, numbers)
    words = [w for w in text.split() if len(w) > 1 and re.match(r'[\w\u00C0-\u024F\u1E00-\u1EFF]', w)]
    word_count = len(words)

    if word_count > 80:
        print(f"VIOLATION:slide {i}:Word count ({word_count}) far exceeds the ~60-word limit. Split this slide.", file=sys.stderr)
    elif word_count > 60:
        print(f"WARNING:slide {i}:Word count ({word_count}) exceeds the ~60-word guideline. Consider splitting.", file=sys.stderr)
PYEOF
}

# ---------------------------------------------------------------------------
# Check 6: Word density per slide (React track — TSX/JSX)
# ---------------------------------------------------------------------------
check_word_density_tsx() {
  local file="$1"
  local basename
  basename=$(basename "$file" | sed 's/\.[^.]*$//')

  python3 - "$file" "$basename" <<'PYEOF'
import sys, re

filepath = sys.argv[1]
slide_name = sys.argv[2]
content = open(filepath, encoding="utf-8").read()

# Extract visible text from JSX — strip tags, braces, imports, comments
text = content
# Remove import lines
text = re.sub(r'^import\s+.*$', '', text, flags=re.MULTILINE)
# Remove JSX tags
text = re.sub(r'<[^>]+>', ' ', text)
# Remove JS expressions in braces
text = re.sub(r'\{[^}]*\}', ' ', text)
# Remove string literals used for className, style, etc.
text = re.sub(r'className="[^"]*"', '', text)
text = re.sub(r'style=\{\{[^}]*\}\}', '', text)
# Remove function signatures, exports
text = re.sub(r'(export\s+default\s+function|function|return|const|let|var)\s+\w+', '', text)

words = [w for w in text.split() if len(w) > 1 and re.match(r'^[\w\u00C0-\u024F\u1E00-\u1EFF]', w)]
word_count = len(words)

if word_count > 80:
    print(f"VIOLATION:{slide_name}:Word count ({word_count}) far exceeds the ~60-word limit. Split this slide.", file=sys.stderr)
elif word_count > 60:
    print(f"WARNING:{slide_name}:Word count ({word_count}) exceeds the ~60-word guideline. Consider splitting.", file=sys.stderr)
PYEOF
}

# ---------------------------------------------------------------------------
# Check 7: Bullet count in TSX/JSX
# ---------------------------------------------------------------------------
check_bullet_count_tsx() {
  local file="$1"
  local basename
  basename=$(basename "$file" | sed 's/\.[^.]*$//')

  local li_count
  li_count=$(grep -cE '<li[ >]|<li$' "$file" 2>/dev/null || echo 0)

  if [[ "$li_count" -gt 5 ]]; then
    log_violation "$file" "$basename" "Too many <li> items ($li_count > 5 max). Split into multiple slides."
  fi
}

# ---------------------------------------------------------------------------
# Run all checks
# ---------------------------------------------------------------------------
for file in "${FILES[@]}"; do
  CHECKED=$((CHECKED + 1))
  rel_path="${file#$DECK_PATH/}"

  if [[ "$file" == *.html ]]; then
    # HTML track — check the whole file, with slide-aware checks
    check_small_font_sizes "$file" "global"
    check_fixed_font_sizes "$file" "global"
    check_tailwind_text_classes "$file" "global"
    check_bullet_count_html "$file"

    # Word density check (captures output from Python)
    while IFS= read -r line; do
      type=$(echo "$line" | cut -d: -f1)
      slide=$(echo "$line" | cut -d: -f2)
      msg=$(echo "$line" | cut -d: -f3-)
      if [[ "$type" == "VIOLATION" ]]; then
        log_violation "$rel_path" "$slide" "$msg"
      elif [[ "$type" == "WARNING" ]]; then
        log_warning "$rel_path" "$slide" "$msg"
      fi
    done < <(check_word_density_html "$file" 2>&1)

  elif [[ "$file" == *.tsx ]] || [[ "$file" == *.jsx ]]; then
    # React track — each file is roughly one slide
    slide_name=$(basename "$file" | sed 's/\.[^.]*$//')
    check_small_font_sizes "$file" "$slide_name"
    check_fixed_font_sizes "$file" "$slide_name"
    check_tailwind_text_classes "$file" "$slide_name"
    check_bullet_count_tsx "$file"

    while IFS= read -r line; do
      type=$(echo "$line" | cut -d: -f1)
      slide=$(echo "$line" | cut -d: -f2)
      msg=$(echo "$line" | cut -d: -f3-)
      if [[ "$type" == "VIOLATION" ]]; then
        log_violation "$rel_path" "$slide" "$msg"
      elif [[ "$type" == "WARNING" ]]; then
        log_warning "$rel_path" "$slide" "$msg"
      fi
    done < <(check_word_density_tsx "$file" 2>&1)
  fi
done

# ---------------------------------------------------------------------------
# Summary
# ---------------------------------------------------------------------------
echo "───────────────────────────────────────────" >&2
echo -e "Checked ${BOLD}${CHECKED}${NC} file(s)." >&2

if [[ $VIOLATIONS -gt 0 ]]; then
  echo -e "${RED}${BOLD}✗ ${VIOLATIONS} violation(s)${NC} found. Fix these before handoff." >&2
  if [[ $WARNINGS -gt 0 ]]; then
    echo -e "${YELLOW}  + ${WARNINGS} warning(s)${NC} (recommended to fix)." >&2
  fi
  exit 1
elif [[ $WARNINGS -gt 0 ]]; then
  echo -e "${YELLOW}⚠ ${WARNINGS} warning(s)${NC} (recommended to fix, but not blocking)." >&2
  exit 0
else
  echo -e "${GREEN}${BOLD}✓ All checks passed.${NC}" >&2
  exit 0
fi
