---
title: "Adapter Bootstrap — Creating _project/testing/ in a Fresh Repo"
type: reference
status: draft
created: 2026-07-10
updated: 2026-07-10
related:
  - ../SKILL.md
  - proof-discipline.md
tags: [manual-testing, bootstrap, project-adapter, environment]
---

# Adapter Bootstrap — Creating `_project/testing/` in a Fresh Repo

Run this when the adapter is missing (or missing required sections). The goal is that a
bootstrapped adapter in any repo looks and behaves exactly like a hand-grown one — same
files, same tables, same discipline — so the skill works identically everywhere.

Bootstrap is **research → draft → confirm → verify**. Never run a testing session on an
unconfirmed adapter: every finding it produced would inherit the adapter's guesses.

## 1. Research — where each fact lives

Fill every value from a real file and keep the source path. A value you couldn't verify
gets `# TODO(confirm: <what you looked at>)` — an honest TODO beats a plausible guess,
because a wrong port produces false findings while a TODO produces a question.

| Fact | Where to look |
| --- | --- |
| Apps + dev ports | each app's `package.json` dev script (`-p`, `--port`), framework config; beware README tables — verify against the scripts, not the prose |
| Startup commands | root `package.json` scripts, `Makefile`, `docker-compose.yml`, turbo/nx config, CI workflow (the CI steps are a tested startup recipe) |
| Services (DB, email-catcher, mocks) | `docker-compose.yml`, `supabase/config.toml` or equivalent, `.env.example` |
| Database connection | integration-test setup files usually carry a working connection string; else the service config |
| Auth method + flow | auth service config, seed scripts, existing e2e helpers/fixtures |
| Seed accounts & tenants | seed scripts/SQL, e2e fixtures; read the actual literals, don't paraphrase |
| DB schema names | migration files — the ground truth for `verification-queries.md` |
| Docs conventions (frontmatter, language) | `docs/README.md` or equivalent; an existing doc as exemplar |
| Output locations | existing docs structure; propose `docs/testing/manual-sessions` + `docs/testing/bugs` + `docs/testing/screenshots` if nothing exists |

Also check for an existing sibling source of truth (e.g. another skill's test-data
reference). If one exists, point at it from `environment.md` and state which file wins on
disagreement — don't fork the facts.

## 2. Scaffold, then fill

Stamp the skeletons with the bundled script — never hand-copy them, so every repo gets
byte-identical structure:

```bash
python3 <skill-dir>/scripts/bootstrap_adapter.py --repo-root <repo>
```

It creates `_project/testing/` (and `_project/README.md` if the layer is new) from
`assets/templates/`, refuses to overwrite existing files, stamps today's date, validates
the TOML, and prints the checklist of `TODO(confirm)` placeholders left to fill.

Sibling testing skills (e.g. `e2e-test-builder`) bundle their own copies of the shared
base templates and may have bootstrapped some of these files already — the script
reporting them as *skipped* is the expected outcome, not a conflict. The shared files are
one adapter, whoever created them first.

The script does not create `_project/testing/manual-testing.toml`. That override is
optional. If §1 found project testing-policy docs (principles, status vocabulary, evidence
rules), propose adding them as `persistent_facts` there. Use the skill's `customize.toml`
as the key reference.

Then fill every placeholder **by editing the stamped files** with the facts from §1 —
required tables/sections and their meaning are documented inside the templates
themselves. Rules that still apply while filling:

- Every value comes from a real file; unverifiable values keep their `TODO(confirm: …)`.
- A table that genuinely doesn't apply stays present with a comment saying so — absence
  must be readable as a fact, not an oversight.
- Match the repo's docs conventions (frontmatter, language) found in §1.
- If a sibling source of truth exists (another skill's test-data reference), point at it
  from `environment.md` and state which file wins on disagreement.

## 3. Confirm with the user

Present, compactly:

- the drafted values **with their source paths**,
- every `TODO(confirm)` as an explicit question,
- anything surprising found while researching (stale READMEs, dead apps, live bugs) —
  these are pre-session findings and belong in "Current state".

Ask for confirmation *before* the first session. If the user corrects a value, fix the
TOML — and note what misled you in "Current state" so the next reader isn't misled too.

## 4. Verify the adapter itself

Before declaring bootstrap done:

- TOML parses (the scaffold script already validated the skeleton; re-validate after
  your edits: `python3 -c "import tomllib; tomllib.load(open('_project/testing/environment.toml','rb'))"`).
- Run the `[preflight]` checks — they are the adapter's own smoke test. A preflight that
  can't run is a broken adapter, whatever the services' actual state.
- If the environment is up, spot-check one `verification-queries.md` query end-to-end.

Only then is the repo ready for its first session.
