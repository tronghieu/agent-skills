#!/bin/bash
# add-remote.sh — add the phone remote to a deck that was scaffolded before it existed.
#
# Usage:  bash add-remote.sh <path-to-deck>
#
# Detects the track and copies slidewright-remote.mjs into place. Never overwrites
# an existing copy unless --force is given. Prints the manual edits still needed
# (the deck-side API), because patching a hand-edited deck by script is unreliable.

set -e

DECK=""
FORCE=0
for arg in "$@"; do
  case "$arg" in
    --force) FORCE=1;;
    *) DECK="$arg";;
  esac
done
if [[ -z "$DECK" || ! -d "$DECK" ]]; then
  echo "Usage: bash add-remote.sh <path-to-deck> [--force]" >&2
  exit 1
fi

SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/assets/remote"

copy() {
  local from="$1" to="$2"
  if [[ -e "$to" && "$FORCE" -eq 0 ]]; then
    echo "   skipped  $to (exists; --force to replace)"
  else
    cp "$from" "$to"
    echo "   created  $to"
  fi
}

if [[ -f "$DECK/package.json" && -d "$DECK/src" ]]; then
  echo "→ Vite + React deck: $DECK"
  mkdir -p "$DECK/remote"
  copy "$SRC/slidewright-remote.mjs" "$DECK/remote/slidewright-remote.mjs"
  copy "$SRC/slidewright-remote.d.mts" "$DECK/remote/slidewright-remote.d.mts"
  if grep -q "slidewrightRemote" "$DECK"/vite.config.* 2>/dev/null; then
    echo "   ok       vite.config already uses slidewrightRemote()"
  else
    echo "   TODO     vite.config.ts: import { slidewrightRemote } from './remote/slidewright-remote.mjs'"
    echo "            and add slidewrightRemote() to plugins"
  fi
  if grep -rq "window.slidewright" "$DECK/src" 2>/dev/null; then
    echo "   ok       Deck exposes window.slidewright"
  else
    echo "   TODO     Deck.tsx: expose window.slidewright + dispatch 'slidewright:change'"
    echo "            (see references/remote-control.md). Without it, only next/prev work."
  fi
  echo "   Run: npm run dev   (the QR code prints under Vite's URLs)"
elif [[ -f "$DECK/index.html" ]]; then
  echo "→ Plain-HTML deck: $DECK"
  copy "$SRC/slidewright-remote.mjs" "$DECK/slidewright-remote.mjs"
  if grep -q "window.slidewright" "$DECK/index.html"; then
    echo "   ok       index.html exposes window.slidewright"
  else
    echo "   TODO     index.html: expose window.slidewright + dispatch 'slidewright:change'"
    echo "            (see references/remote-control.md). Without it, only next/prev work."
  fi
  echo "   Run: node \"$DECK/slidewright-remote.mjs\""
else
  echo "Not a slidewright deck (no index.html, no package.json + src/): $DECK" >&2
  exit 1
fi
