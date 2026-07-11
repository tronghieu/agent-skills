#!/bin/bash
# Initialize a product-manager workspace for one product.
# Usage: init-product.sh <product-dir> <product-name>
#   product-dir   Directory to create (or reuse) for this product
#   product-name  Product name, quoted (e.g. "Acme Analytics")
#
# Idempotent: never overwrites existing files, so it is safe to re-run
# against a workspace that has been lived in for months.
set -e

PRODUCT_DIR="${1:?Usage: init-product.sh <product-dir> <product-name>}"
NAME="${2:?Usage: init-product.sh <product-dir> <product-name>}"
TODAY="$(date +%Y-%m-%d)"

mkdir -p "$PRODUCT_DIR/discovery" "$PRODUCT_DIR/strategy" \
         "$PRODUCT_DIR/backlog" "$PRODUCT_DIR/specs" \
         "$PRODUCT_DIR/experiments" "$PRODUCT_DIR/launches"
created=()
skipped=()

write_if_absent() {
  local file="$1"
  if [ -f "$PRODUCT_DIR/$file" ]; then
    skipped+=("$file")
    return 1
  fi
  created+=("$file")
  return 0
}

if write_if_absent "product.md"; then
  cat > "$PRODUCT_DIR/product.md" <<EOF
# $NAME

## Vision & positioning
(what this product is, for whom, against what alternative — confirmed at orient)

## Users & segments
(who uses it; which segment leads — cite [I#]/[S#] where evidence exists)

## Stage & constraints
(lifecycle stage, team size, deadlines, technical or business constraints)

## Standing strategy inputs
(links to strategy-board recommendations or other upstream decisions, if any)
EOF
fi

if write_if_absent "state.md"; then
  cat > "$PRODUCT_DIR/state.md" <<EOF
# State: $NAME

open_plays: none yet
waiting_on_user: nothing yet
last_session: $TODAY — workspace initialized
EOF
fi

if write_if_absent "decisions.md"; then
  cat > "$PRODUCT_DIR/decisions.md" <<EOF
# Decision log: $NAME

Append-only. Every entry: decision, alternatives considered, why,
dissent (if any), and a revisit-when trigger. Schema in
references/pm-discipline.md.

## $TODAY — workspace initialized
EOF
fi

if write_if_absent "discovery/sources.md"; then
  cat > "$PRODUCT_DIR/discovery/sources.md" <<EOF
# Sources

| ID | Source | Publisher | Published | Accessed | Confidence | Notes |
|----|--------|-----------|-----------|----------|------------|-------|
EOF
fi

if write_if_absent "discovery/insights.md"; then
  cat > "$PRODUCT_DIR/discovery/insights.md" <<EOF
# Insights

([I#] blocks — imported from a design-thinking workspace or registered
here under the same schema: Evidence / Interpretation / Status /
Confidence. Every insight traces to [S#] or is labelled a hypothesis.)
EOF
fi

if write_if_absent "discovery/feedback-log.md"; then
  cat > "$PRODUCT_DIR/discovery/feedback-log.md" <<EOF
# Feedback log

| ID | Date | Channel | Who (segment) | Verbatim / summary | Source | Routed to |
|----|------|---------|---------------|--------------------|--------|-----------|
EOF
fi

if write_if_absent "strategy/metrics.md"; then
  cat > "$PRODUCT_DIR/strategy/metrics.md" <<EOF
# Metrics: $NAME

## North star
(not chosen yet — run the define-metrics play)

## Metrics tree
(L1 input metrics, each with a labelled current value or "not instrumented ⚠")

## Guardrails
(numbers that must not get worse)

## Instrumentation gaps
(the honest list)
EOF
fi

if write_if_absent "backlog/opportunities.md"; then
  cat > "$PRODUCT_DIR/backlog/opportunities.md" <<EOF
# Opportunities

(OP# entries as job stories, each tracing to [I#]/FB#/[S#] evidence or
carrying a hypothesis label. Schema in references/prioritization.md.)
EOF
fi

if write_if_absent "backlog/assumptions.md"; then
  cat > "$PRODUCT_DIR/backlog/assumptions.md" <<EOF
# Assumptions

| ID | Statement | Basis | Range (low–high) | Used by | Status |
|----|-----------|-------|------------------|---------|--------|
EOF
fi

echo "Product workspace ready at $PRODUCT_DIR" >&2
[ ${#skipped[@]} -gt 0 ] && echo "Existing files preserved: ${skipped[*]}" >&2

printf '{"product_dir":"%s","name":"%s","created":[' "$PRODUCT_DIR" "$NAME"
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
