#!/bin/bash
# Initialize the critical-thinking coaching workspace.
# Usage: init-workspace.sh [target-dir]
#   target-dir  Directory to create thinking-gym/ under (default: cwd)
#
# Idempotent: if thinking-gym/ already exists, prints what's there and
# exits 0 without touching any file.
set -euo pipefail

TARGET_DIR="${1:-.}"
GYM_DIR="$TARGET_DIR/thinking-gym"

if [ -d "$GYM_DIR" ]; then
  echo "thinking-gym/ already exists at $GYM_DIR — nothing to do." >&2
  echo "Existing contents:" >&2
  find "$GYM_DIR" -maxdepth 2 -mindepth 1 | sort | sed 's/^/  /' >&2
  exit 0
fi

mkdir -p "$GYM_DIR/sessions"
touch "$GYM_DIR/sessions/.gitkeep"

cat > "$GYM_DIR/profile.md" <<'EOF'
# Reasoning profile

<!-- Update discipline: only write or edit an entry once a pattern has
     recurred roughly 3 times — one miss is noise, not a pattern. Every
     entry cites the session files it's built from. Record patterns,
     never traits: "misses [ASSUME] in financial documents, 4 of last 6"
     is usable; "credulous with numbers" is not and helps no one. -->

## Recurring blind spots
<!-- One entry per recurring miss-type, with count and session links.
     e.g. "[GAP] misses in vendor proposals — 3 of last 5
     (sessions: 2026-07-02-vendor-x, 2026-07-09-vendor-y, ...)" -->

## Strengths
<!-- Patterns the user consistently catches, with the same evidence
     discipline as blind spots. Prune a blind spot here once it stops
     recurring (caught 3+ times running) — visible progress is the
     strongest motivator this file has. -->

## Calibration
<!-- The calibration trend in prose: systematically over/underconfident,
     and on what kind of document, sourced from calibration.md. -->

## Watch next
<!-- Exactly one thing — carried over from the last progress review. -->
EOF

cat > "$GYM_DIR/calibration.md" <<'EOF'
# Calibration log

<!-- One row per audit session where the user committed (skipped
     commits are still logged, with confidence = "skipped"). Append-only;
     never edit or delete a past row. verdict-match is coarse by design:
     yes / partial / no / — (skipped) — coarse and consistent beats
     precise and abandoned. -->

| date | doc | mode | confidence | verdict-match | caught | missed | phantom |
|------|-----|------|------------|----------------|--------|--------|---------|
EOF

echo "Created thinking-gym/ at $GYM_DIR" >&2
echo "  profile.md" >&2
echo "  calibration.md" >&2
echo "  sessions/.gitkeep" >&2
