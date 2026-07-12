#!/bin/bash
# Initialize a project-manager workspace for one project.
# Usage: init-project.sh <project-name> [parent-dir]
#   project-name  Project name, quoted (e.g. "Capigo Mobile App")
#   parent-dir    Directory that owns the project (default: current dir).
#                 The workspace is always created at <parent-dir>/_project
#
# Idempotent: never overwrites existing files, so it is safe to re-run
# against a workspace that has been lived in for months.
set -e

NAME="${1:?Usage: init-project.sh <project-name> [parent-dir]}"
PARENT_DIR="${2:-.}"
WS="$PARENT_DIR/_project"
TODAY="$(date +%Y-%m-%d)"

mkdir -p "$WS/context" "$WS/registers" "$WS/plan" "$WS/status"
created=()
skipped=()

write_if_absent() {
  local file="$1"
  if [ -f "$WS/$file" ]; then
    skipped+=("$file")
    return 1
  fi
  created+=("$file")
  return 0
}

# ---------- root ----------

if write_if_absent "state.md"; then
  cat > "$WS/state.md" <<EOF
# State: $NAME

open_plays: none yet
waiting_on_user: nothing yet
last_session: $TODAY — workspace initialized
EOF
fi

# ---------- context/ (slow-changing truth; every entry carries an
# origin label and a revisit-trigger — see references/initiation.md) ----------

if write_if_absent "context/charter.md"; then
  cat > "$WS/context/charter.md" <<EOF
# Charter: $NAME

## Objective & success criteria
(why this project exists; what "done" means, measurably — origin label each entry)

## Scope
### In
### Out (explicit — the Won't list)

## Sponsor & decision authority
(who owns go/no-go, who approves CH# changes)

## Key dates & budget envelope
(committed externally vs internal targets — label which is which)

## Revisit when
(sponsor changes / objective renegotiated / re-baseline)
EOF
fi

if write_if_absent "context/methodology.md"; then
  cat > "$WS/context/methodology.md" <<EOF
# Methodology: $NAME

choice: (predictive | agile | hybrid — decided at initiate, with rationale)
cadences: (planning cycle, status cadence, review/retro cadence)
tailoring: (what this project does differently from the textbook, and why)
revisit when: (delivery consistently misses cadence / team or scope shifts shape)
EOF
fi

if write_if_absent "context/team.md"; then
  cat > "$WS/context/team.md" <<EOF
# Team: $NAME

## Roster
| Person | Role | Capacity | Notes |
|--------|------|----------|-------|

## RACI (filled when a play needs it, not before)
EOF
fi

if write_if_absent "context/stakeholders.md"; then
  cat > "$WS/context/stakeholders.md" <<EOF
# Stakeholders: $NAME

## Map
| Stakeholder | Interest | Influence | Attitude | Origin |
|-------------|----------|-----------|----------|--------|

## Communication plan
| Audience | What they get | Cadence | Channel | Owner |
|----------|---------------|---------|---------|-------|
EOF
fi

if write_if_absent "context/environment.md"; then
  cat > "$WS/context/environment.md" <<EOF
# Environment: $NAME

## Tools & sources of record
(where the real data lives: issue tracker, repo, sheet — status reports cite exports from here as EV#)

## External dependencies
(other teams, vendors, approvals outside this project's control)

## Constraints & calendar
(fixed dates, freeze windows, holidays, compliance requirements)
EOF
fi

if write_if_absent "context/glossary.md"; then
  cat > "$WS/context/glossary.md" <<EOF
# Glossary: $NAME

| Term | Meaning here |
|------|--------------|
EOF
fi

# ---------- registers/ (living books) ----------

if write_if_absent "registers/decisions.md"; then
  cat > "$WS/registers/decisions.md" <<EOF
# Decision log: $NAME

Append-only. Every entry: decision, alternatives considered, why, dissent
(if any), and a revisit-when trigger. Schema in references/pm-discipline.md.

## $TODAY — workspace initialized
EOF
fi

if write_if_absent "registers/risks.md"; then
  cat > "$WS/registers/risks.md" <<EOF
# Risk register: $NAME

| ID | Risk | P | I | Score | ROAM | Owner | Trigger / next review | Status |
|----|------|---|---|-------|------|-------|-----------------------|--------|

(P/I scales, ROAM criteria, escalation rules: references/risk.md.
Every risk names an owner from context/team.md — "the team" owns nothing.)
EOF
fi

if write_if_absent "registers/changes.md"; then
  cat > "$WS/registers/changes.md" <<EOF
# Change register: $NAME

| ID | Date | Request | Origin | Impact (schedule/cost/risk/quality) | Decision | By | Decided |
|----|------|---------|--------|--------------------------------------|----------|----|---------|

(No change is "in" until its row has an impact assessment and a decision
by the authority named in context/charter.md — references/change-control.md.)
EOF
fi

if write_if_absent "registers/actions.md"; then
  cat > "$WS/registers/actions.md" <<EOF
# Action items: $NAME

| ID | Action | Owner | Due | Source | Status |
|----|--------|-------|-----|--------|--------|

(Source = the meeting or status snapshot that created it. Overdue items
surface at every re-entry until closed.)
EOF
fi

if write_if_absent "registers/assumptions.md"; then
  cat > "$WS/registers/assumptions.md" <<EOF
# Assumptions: $NAME

| ID | Statement | Basis | Range (low–high) | Used by | Status |
|----|-----------|-------|------------------|---------|--------|
EOF
fi

if write_if_absent "registers/lessons.md"; then
  cat > "$WS/registers/lessons.md" <<EOF
# Lessons learned: $NAME

| ID | Date | Context | Planned vs actual | Lesson | Feeds |
|----|------|---------|-------------------|--------|-------|

("Feeds" names the estimate class or checklist this lesson should change —
a lesson that feeds nothing is a diary entry. references/lessons.md.)
EOF
fi

if write_if_absent "registers/evidence.md"; then
  cat > "$WS/registers/evidence.md" <<EOF
# Evidence registry: $NAME

| ID | Date | Fact | Source | Notes |
|----|------|------|--------|-------|

(Facts only: demo accepted, export received, milestone signed off, test
passed. Status colors and forecasts cite EV# rows — never vibes.)
EOF
fi

# ---------- plan/ ----------

if write_if_absent "plan/schedule.md"; then
  cat > "$WS/plan/schedule.md" <<EOF
# Schedule: $NAME

(M# milestones, dependencies, critical path — shape follows
context/methodology.md; schema in references/planning.md. Baselines are
frozen into plan/baseline-<date>.md; this file is the living plan.)

## Milestones
| ID | Milestone | Target | Depends on | Status | Evidence |
|----|-----------|--------|------------|--------|----------|
EOF
fi

if write_if_absent "plan/estimates.md"; then
  cat > "$WS/plan/estimates.md" <<EOF
# Estimates: $NAME

| Item | Basis | Low–High | Reference class (L# / history) | Buffer | Label |
|------|-------|----------|--------------------------------|--------|-------|

(Ranges, not points; buffers are visible line items; every row's Label is
EV#, A#, or (user, date) — references/estimation.md.)
EOF
fi

echo "Project workspace ready at $WS" >&2
[ ${#skipped[@]} -gt 0 ] && echo "Existing files preserved: ${skipped[*]}" >&2

printf '{"workspace":"%s","name":"%s","created":[' "$WS" "$NAME"
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
