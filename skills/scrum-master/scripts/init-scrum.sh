#!/bin/bash
# Initialize a scrum-master workspace for one team.
# Usage: init-scrum.sh <team or project name> [parent-dir]
#   team or project name  Team or project name, quoted (e.g. "Capigo Mobile Squad")
#   parent-dir            Directory that owns the workspace (default: current dir).
#                         The workspace is always created at <parent-dir>/_project
#
# Idempotent: never overwrites existing files, so it is safe to re-run
# against a workspace that has been lived in for months. The shared
# base (README.md, tools.md) is write-if-absent too — another skill
# may have created it first; a skip there is normal, not an error.
set -e

NAME="${1:?Usage: init-scrum.sh <team or project name> [parent-dir]}"
PARENT_DIR="${2:-.}"
WS="$PARENT_DIR/_project"

mkdir -p "$WS/scrum-master"
created=()
skipped=()

write_if_absent() {
  local file="$1"
  if [ -f "$WS/$file" ]; then
    skipped+=("$file")
    echo "skipped  $WS/$file"
    return 1
  fi
  created+=("$file")
  echo "created  $WS/$file"
  return 0
}

# ---------- shared base (write-if-absent; another skill may go first) ----------

if write_if_absent "README.md"; then
  cat > "$WS/README.md" <<'EOF'
# `_project/` — shared workspace namespace

Shared across agent skills. Each skill that uses it owns one
subdirectory, named after itself.

**Exception:** `project-manager` predates this convention. It keeps
flat files at this root — `context/`, `registers/`, `plan/`,
`status/`, `state.md` — instead of a subdirectory.

Shared root files, like `tools.md`, are append-only. Any skill may
add an entry. No skill may rewrite another skill's entry.
EOF
fi

if write_if_absent "tools.md"; then
  cat > "$WS/tools.md" <<'EOF'
# Tool connections — shared

<!-- One entry per tool: exact fetch command, field mapping, and a verified date. -->
<!-- Any skill may append a new entry below its own heading. -->
<!-- Fetch fails, or no access? Ask the user for an export instead. -->
<!-- Never invent tool data — an unverified number poisons every metric downstream. -->

<!--
## jira — issue tracker
- fetch: `jira sprint list --board 12`
- maps: sprint backlog ← board 12, active sprint; estimate ← field "Story Points"
- added by: scrum-master, verified YYYY-MM-DD
-->
EOF
fi

# ---------- scrum-master/ (skill-owned) ----------

if write_if_absent "scrum-master/state.md"; then
  cat > "$WS/scrum-master/state.md" <<'EOF'
# State

## Current sprint

## Open loops

## Waiting on

## Last session
EOF
fi

if write_if_absent "scrum-master/context.md"; then
  cat > "$WS/scrum-master/context.md" <<EOF
# Team context — $NAME

## Team

## Cadence

## Definition of Done

## Working agreements

| Date | Agreement | Origin |
|------|-----------|--------|
EOF
fi

if write_if_absent "scrum-master/impediments.md"; then
  cat > "$WS/scrum-master/impediments.md" <<EOF
# Impediments — $NAME

| IM# | Opened | What & who it blocks | Owner | State | Last action | Links |
|-----|--------|-----------------------|-------|-------|-------------|-------|
EOF
fi

if write_if_absent "scrum-master/retros.md"; then
  cat > "$WS/scrum-master/retros.md" <<EOF
# Retrospectives — $NAME

## Improvement register

| PI# | Born | Improvement | Owner | Due | Status | Note |
|-----|------|-------------|-------|-----|--------|------|
EOF
fi

if [ -d "$WS/scrum-master/sprints" ]; then
  skipped+=("scrum-master/sprints/")
  echo "skipped  $WS/scrum-master/sprints/"
else
  mkdir -p "$WS/scrum-master/sprints"
  created+=("scrum-master/sprints/")
  echo "created  $WS/scrum-master/sprints/"
fi

echo "Scrum-master workspace ready at $WS (${#created[@]} created, ${#skipped[@]} skipped)."
