#!/bin/bash
# Initialize a market-researcher workspace.
# Usage: init-research.sh <output-dir> <topic> [mode]
#   output-dir  Directory to create (or reuse) for this research
#   topic       Research topic, quoted (e.g. "AI email clients for executives")
#   mode        quick-scan (default) | deep-dive
#
# Idempotent: never overwrites existing files, so it is safe to run against a
# caller's workspace that already has a sources.md.
set -e

OUTPUT_DIR="${1:?Usage: init-research.sh <output-dir> <topic> [mode]}"
TOPIC="${2:?Usage: init-research.sh <output-dir> <topic> [mode]}"
MODE="${3:-quick-scan}"
TODAY="$(date +%Y-%m-%d)"

if [ "$MODE" != "quick-scan" ] && [ "$MODE" != "deep-dive" ]; then
  echo "Error: mode must be 'quick-scan' or 'deep-dive', got '$MODE'" >&2
  exit 1
fi

mkdir -p "$OUTPUT_DIR"
created=()
skipped=()

if [ -f "$OUTPUT_DIR/sources.md" ]; then
  skipped+=("sources.md")
else
  cat > "$OUTPUT_DIR/sources.md" <<EOF
# Sources

| ID | Source | Publisher | Published | Accessed | Confidence | Notes |
|----|--------|-----------|-----------|----------|------------|-------|
EOF
  created+=("sources.md")
fi

if [ -f "$OUTPUT_DIR/state.md" ]; then
  skipped+=("state.md")
else
  cat > "$OUTPUT_DIR/state.md" <<EOF
# Research state: $TOPIC

mode: $MODE
lanes:
output: $OUTPUT_DIR

## Log
- $TODAY: workspace initialized
EOF
  created+=("state.md")
fi

if [ -f "$OUTPUT_DIR/report.md" ]; then
  skipped+=("report.md")
else
  cat > "$OUTPUT_DIR/report.md" <<EOF
---
topic: $TOPIC
mode: $MODE
market_definition:
lanes_completed: []
verification: pending
verdict:
---

# Market research: $TOPIC

(Sections are written at synthesis — see references/report-templates.md)
EOF
  created+=("report.md")
fi

echo "Workspace ready at $OUTPUT_DIR (mode: $MODE)" >&2
[ ${#skipped[@]} -gt 0 ] && echo "Existing files preserved: ${skipped[*]}" >&2

printf '{"output_dir":"%s","topic":"%s","mode":"%s","created":[' "$OUTPUT_DIR" "$TOPIC" "$MODE"
for i in "${!created[@]}"; do
  [ "$i" -gt 0 ] && printf ','
  printf '"%s"' "${created[$i]}"
done
printf '],"skipped":['
for i in "${!skipped[@]}"; do
  [ "$i" -gt 0 ] && printf ','
  printf '"%s"' "${skipped[$i]}"
done
printf ']}\n'
