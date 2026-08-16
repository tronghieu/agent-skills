# `_project/` — Project Adapter for Generic Skills

This directory holds project-specific configuration and knowledge consumed by generic,
portable skills. A skill defines a *contract* — the questions it needs answered to operate
on a real repo; `_project/` answers those questions for **this** repo, so the skill itself
stays copy-paste portable across repos.

Skills that own files here keep them under a subdirectory named after themselves, so
multiple skills can share this directory without collisions. Some skills predate that
convention and use the directory flat instead — the `project-manager` skill keeps its own
workspace directly under `_project/`, with no subdirectory of its own. Check a skill's own
docs before assuming every file under here follows one layout.

## Current contents

### `bmad-loop/`

Consumed by the bmad-run-inspector skill.

- **`environment.toml`** — every machine-shaped fact the skill needs: the dev skill and
  coding CLI the loop drives, the mux backend, the stack's test runner and type checker, the
  verify steps that can't fail a run, and what feeds the backlog. The single source of truth
  for values — nothing else in the adapter repeats a value this file holds.
- **`environment.md`** — the knowledge layer over the TOML: a dated "Current state"
  snapshot, which of the log heuristics' assumptions actually hold for this repo, the verify
  commands that can't fail the run, and judgment calls a reading needs before it's trusted.

## Update discipline

Adapter files carry **dated snapshots**, not a running log. When a change lands that shifts
reality, whoever lands it updates the adapter in place — rewrite the relevant section and
bump its `updated` date, don't append a new dated block. Don't wait for staleness to be
*discovered* by a future session; that's a bug that already happened once.
