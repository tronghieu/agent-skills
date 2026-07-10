#!/bin/bash
# Initialize a design-thinking project workspace.
# Usage: init-project.sh <project-dir> <title>
#   project-dir  Directory to create (or reuse) for this project
#   title        Project title, quoted (e.g. "Fintech onboarding for first-timers")
#
# Idempotent: never overwrites existing files, so it is safe to re-run against
# a workspace that already has artifacts (e.g. after a loop-back round).
set -e

PROJECT_DIR="${1:?Usage: init-project.sh <project-dir> <title>}"
TITLE="${2:?Usage: init-project.sh <project-dir> <title>}"
TODAY="$(date +%Y-%m-%d)"

mkdir -p "$PROJECT_DIR/research/raw" "$PROJECT_DIR/research/market" \
         "$PROJECT_DIR/prototypes" "$PROJECT_DIR/tests"
created=()
skipped=()

write_if_absent() {
  local file="$1"
  if [ -f "$PROJECT_DIR/$file" ]; then
    skipped+=("$file")
    return 1
  fi
  created+=("$file")
  return 0
}

if write_if_absent "project.md"; then
  cat > "$PROJECT_DIR/project.md" <<EOF
# $TITLE

## Problem space
(what hurts, for whom — confirmed at Kickoff)

## Target users
(who we are designing for — segments, not personas yet)

## Scope & constraints
(what's in/out, deadlines, budget, technical or political constraints)

## Success looks like
(how the user will judge this project)
EOF
fi

if write_if_absent "phase-state.md"; then
  cat > "$PROJECT_DIR/phase-state.md" <<EOF
# Phase state: $TITLE

round: 1
phase: kickoff
gate_status: pending (user confirms the frame)
waiting_on_user: nothing yet

## Phase history
- $TODAY: workspace initialized

## Gate reports
(verifier gate reports are appended here — see references/insight-discipline.md)
EOF
fi

if write_if_absent "journal.md"; then
  cat > "$PROJECT_DIR/journal.md" <<EOF
# Journal: $TITLE

## $TODAY — session 1
- Workspace initialized.
EOF
fi

if write_if_absent "research/sources.md"; then
  cat > "$PROJECT_DIR/research/sources.md" <<EOF
# Sources

| ID | Source | Publisher | Published | Accessed | Confidence | Notes |
|----|--------|-----------|-----------|----------|------------|-------|
EOF
fi

if write_if_absent "insights.md"; then
  cat > "$PROJECT_DIR/insights.md" <<EOF
# Insights

(Insight blocks [I#] are written in Define — schema in
references/insight-discipline.md. Every insight traces to [S#] evidence or
is labelled a hypothesis.)
EOF
fi

if write_if_absent "personas.md"; then
  cat > "$PROJECT_DIR/personas.md" <<EOF
# Personas

(Each persona carries an evidence-base banner — see
references/insight-discipline.md. No unlabelled narrative decoration.)
EOF
fi

if write_if_absent "hmw.md"; then
  cat > "$PROJECT_DIR/hmw.md" <<EOF
# POV statements & How-Might-We questions

(POV: user + need + insight, each part cited. HMW questions open a POV into
a solution space and inherit its citations.)
EOF
fi

if write_if_absent "ideas.md"; then
  cat > "$PROJECT_DIR/ideas.md" <<EOF
# Idea portfolio

(Filled in Ideate: diverge wide, then converge with desirability /
feasibility / viability scoring. Ideas cite the [I#]/HMW they serve.)
EOF
fi

echo "Workspace ready at $PROJECT_DIR" >&2
[ ${#skipped[@]} -gt 0 ] && echo "Existing files preserved: ${skipped[*]}" >&2

printf '{"project_dir":"%s","title":"%s","created":[' "$PROJECT_DIR" "$TITLE"
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
