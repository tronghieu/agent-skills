---
title: "_project/ — Project Adapter for Generic Skills"
type: index
status: draft
created: TODO(date)
updated: TODO(date)
related:
  - testing/environment.toml
  - testing/environment.md
  - testing/verification-queries.md
tags: [project-adapter, skills, index]
---

# `_project/` — Project Adapter for Generic Skills

This directory holds project-specific configuration consumed by generic, portable skills. A
skill under `.claude/skills/` defines a *contract*: the questions it needs answered to
operate on a real repo (which apps run where, which accounts exist, how to authenticate,
how to verify a claim against the database). `_project/` answers those questions for
**this** repo. The skill itself stays generic: copy it unchanged into another repo,
bootstrap a fresh `_project/` there, and it works.

## Current contents

### `testing/`

Consumed by `.claude/skills/manual-testing`.

<!-- TODO(confirm): note any other skill that also consumes this directory. -->

- **`environment.toml`** — every machine-shaped fact: ports, URLs, credentials, seed
  tenants/accounts, output paths, preflight checks. The single source of truth for values —
  nothing else in the adapter repeats a number this file holds.
- **`environment.md`** — the knowledge layer over the TOML: a dated "Current state"
  snapshot of what's actually implemented today, durable how-tos (e.g. how to authenticate),
  and judgment calls a session needs before trusting what it sees.
- **`verification-queries.md`** — read-only queries, organized by intent, for
  triangulating a UI claim against the database.

## Further reading

<!-- TODO(confirm): if the project keeps a testing-theory or conventions doc, link it here. -->

## Update discipline

Adapter files carry **dated snapshots**, not a running log. When a change lands that shifts
reality (a route ships, an app comes online, a testid gets fixed), whoever lands it updates
the adapter in place — rewrite the relevant section and bump its `updated` date, don't
append a new dated block. Don't wait for staleness to be *discovered* by a future session;
that's a bug that already happened once.
