---
title: "Testing — Environment Knowledge for <Project>'s Local Dev Stack"
type: reference
status: draft
created: TODO(date)
updated: TODO(date)
related:
  - environment.toml
  - verification-queries.md
tags: [testing, environment, local-dev, seed-data]
---

# Environment Knowledge

This file is the context and knowledge layer over `environment.toml`. The TOML holds every
machine-shaped fact — ports, URLs, credentials, account list, preflight commands; this file
never repeats a number the TOML already holds. What lives here instead: what's currently
true about the running app that a config file can't express, the durable how-tos, and the
judgment calls a testing session needs before it can trust what it sees.

## Current state (snapshot — rewrite, don't append)

_Last verified: TODO(date)_

<!-- TODO(confirm): what's implemented vs spec-only, stale docs to distrust, known quirks
     and live bugs a session will trip over. Write this as bullets a session can act on. -->

- TODO(confirm: ...)
- TODO(confirm: ...)

**Update rule:** whoever lands a change that makes any bullet above stale rewrites this
section in place (don't append a new dated block) and bumps this date + `[project].updated`
in `environment.toml`.

## Authentication — how to get an authenticated state

<!-- TODO(confirm): the step-by-step to reach an authenticated state — which method, where
     codes/links land, extraction pitfalls, timing gotchas. If no real auth route exists
     yet, say so explicitly and document whatever oracle (API, seed fixture) stands in for
     it today. -->

## Project conventions a session must judge by

<!-- TODO(confirm): conventions a session needs in order to judge what it sees — e.g.
     cookie/session scoping rules, tenant-isolation expectations, formatting or locale
     conventions, soft-delete vs hard-delete semantics. -->

## Reporting & evidence

The `[outputs]` dirs in the TOML say *where*; this section says *how* this project stores
and consumes test artifacts — every project does this differently, so a session must not
assume.

<!-- TODO(confirm): answer at least —
     - Are reports and screenshots committed to git, or kept out of it (.gitignore)?
     - Who reads the reports (devs in-repo? external stakeholders?) and in what format —
       is markdown the final deliverable, or is something built from it (docx/PDF export)?
     - Retention: are old sessions' notes and screenshots kept forever, pruned, archived? -->

## Ground rules

- **Local dev only.** Never point a session at anything but the hosts in `environment.toml`.
- **Database is read-only from a testing session.** Verify state with `SELECT` via `psql`
  (see `verification-queries.md`) — never `INSERT`/`UPDATE`/`DELETE` directly. A session
  that mutates the DB outside the app under test invalidates its own findings for anyone who
  reruns the same steps.
- **If seed state is too dirty to trust, ask the user to run the project's database reset command** rather than
  hand-cleaning rows — a manual cleanup can silently leave the DB in a state the seed script
  itself would never produce.
- **Never start services without user confirmation.** `db:reset` in particular is
  destructive — it resets and reseeds data a human may be mid-way through inspecting.
