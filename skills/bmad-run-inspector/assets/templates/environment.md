# bmad-loop Adapter — <project name>

This file is the context and knowledge layer over `environment.toml`. The TOML holds every
machine-shaped fact — the dev skill, the coding CLI, the mux backend, the stack's test
runner and type checker, the non-fatal verify steps, the backlog source; this file never
repeats a value the TOML already holds. What lives here instead: what's currently true
about this repo's bmad-loop setup that a config file can't express, and the judgment calls
a reading needs before it can be trusted.

## Current state (snapshot — rewrite, don't append)

<!-- TODO(confirm): what's actually running today, verified against a real run directory —
     confirm dev_skill, coding_cli, and mux_backend match what a run shows, and note any
     drift between policy.toml and reality. -->

## What the log heuristics assume here

<!-- TODO(confirm): name which of the extractor's stack-specific constants — the coding
     CLI's spinner vocabulary, its ⏺ tool-call glyph, its collapse marker, the test runner's
     pass/fail line format, the type checker's error format — actually match this repo, and
     which don't. This is the section that earns the file: a mismatch here is exactly why a
     broken run can read clean. -->

## Verify commands that cannot fail the run

<!-- TODO(confirm): list the steps named in environment.toml's [verify].non_fatal_steps and
     what each one being red actually means, since a green run hides it. -->

## Judgment calls before trusting a reading

<!-- TODO(confirm): anything a reader needs before trusting an extractor result — known
     gaps, stale fields, or cases where this adapter and a real run have disagreed before. -->
