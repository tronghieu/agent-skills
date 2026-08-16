# Adapter Bootstrap — Creating `_project/bmad-loop/` in a Fresh Repo

Run this when `_project/bmad-loop/environment.toml` is missing, or missing a required
section. The goal is that a bootstrapped adapter looks and behaves exactly like a
hand-grown one, so the rest of this skill reads the same file everywhere and never has to
special-case a repo.

Bootstrap is **research → scaffold → fill → confirm → verify**, in that order. Never run a
real inspection against an unconfirmed adapter — every reading it produces (which coding
CLI's log vocabulary applies, whether an absent `result.json` is normal, which verify steps
are allowed to fail silently) inherits the adapter's guesses.

## 1. Research — where each field's value comes from

Derive every value from a real file or a real command. Keep the source you used; you repeat
it in the confirm step. A value you couldn't verify gets
`TODO(confirm: <what you looked at>)` — never a guess. The stakes are asymmetric: a wrong
`coding_cli` or `test_runner` does not error. It makes the extractor's pattern matching miss
silently, so `results` and `errors` sections come back empty, and an empty section reads
exactly like a clean run. A `TODO` at least asks a question; a wrong guess asserts a lie.

| TOML field | Where the value comes from | Needs a run? |
|---|---|---|
| `project.name` | repo name — root manifest (`package.json` `name`, `pyproject.toml`) or the directory name if neither exists | no |
| `project.updated` | today's date; rewritten in place every time you touch the file, never appended to | no |
| `loop.runs_dir`, `loop.archive_dir`, `loop.policy_path` | bmad-loop's own conventional paths — confirm `.bmad-loop/runs`, `.bmad-loop/archive`, `.bmad-loop/policy.toml` actually exist (`ls .bmad-loop/`); only diverge from the skeleton defaults if `bmad-loop init` was run with non-standard paths | no |
| `orchestrator.dev_skill` | a run's `state.json` → `policy_snapshot.dev.skill`. There is no live-file fallback: a real, many-times-run `.bmad-loop/policy.toml`'s top-level tables are exactly `adapter, cleanup, gates, limits, notify, operator, plugins, review, scm, sweep, tui, verify` — no `[dev]` table exists there. The snapshot is resolved policy with defaults filled in, which is also why it carries more sub-tables than the live file | yes |
| `orchestrator.coding_cli` | `bmad-loop adapters` — lists every registered adapter kind and which profiles select it, and works without a run. Cross-check against a run's `state.json` → `policy_snapshot.adapter.name`, which records what that specific run actually launched, once one exists. The CLI output tells you what a profile *would* select; the snapshot tells you what one *did* | no — cross-check prefers a run |
| `orchestrator.mux_backend` | `bmad-loop mux` (bare) — prints every registered backend and marks the SELECTED one, and works without a run. A run's `policy_snapshot.mux.backend` can read as an empty string even when a backend was in fact used — that key only holds an explicit override written by `mux set`, not the resolved default — so treat the bare `bmad-loop mux` command, not the snapshot, as authoritative for this field. The live `policy.toml` has no `[mux]` table either, so there is no file to fall back to — `bmad-loop mux` is the only source, run or no run | no |
| `orchestrator.writes_result_json` | see its own note below | yes, unavoidably |
| `stack.test_runner`, `stack.type_checker` | the repo's own manifest — `package.json` scripts/devDependencies, lockfile name (`pnpm-lock.yaml`, `yarn.lock`, `package-lock.json`), `tsconfig.json` presence for the type checker. In a monorepo, check the root manifest first, then the workspace(s) the loop actually touches | no |
| `verify.non_fatal_steps` | a run's `state.json` → `policy_snapshot.verify.commands`, filtered for entries ending in `\|\| true`. Falls back to `.bmad-loop/policy.toml`'s `[verify] commands` when no run exists — unlike `dev_skill` and `source`, this table does exist in the live file, so the fallback is real, just less trustworthy than a snapshot because the live file may have been edited since the last run | prefer yes |
| `backlog.source` | a run's `state.json` top-level `source` field directly (not nested under `policy_snapshot`). No live-file fallback: `.bmad-loop/policy.toml` has no `source` key at that path or anywhere else — it exists only once a run has happened | yes |

**When no run exists yet**: `coding_cli` and `mux_backend` don't need one — `bmad-loop
adapters` and `bmad-loop mux` both work standalone, so fill them from the command output and
treat the cross-check against a snapshot as a later confirmation, not a prerequisite.
`verify.non_fatal_steps` degrades to reading `.bmad-loop/policy.toml`'s `[verify] commands`
table directly, which does exist in the live file — a real value, just less trustworthy than
a snapshot until the first run confirms it, because the live file may have been edited since.
`dev_skill` and `backlog.source` have no such fallback: the live `policy.toml`'s top-level
tables are `adapter, cleanup, gates, limits, notify, operator, plugins, review, scm, sweep,
tui, verify` — there is no `[dev]` table and no `source` key anywhere in it. Looking for
either there will not turn up a wrong value, it will turn up nothing; don't invent one from
defaults, and don't stall the whole adapter over it. Leave `dev_skill` and `backlog.source`
`TODO(confirm: no run exists to read state.json)`, alongside `writes_result_json`, and say
plainly that all three need a run to answer.

### Whether the dev skill writes `result.json` — its own note

This one cannot be read off policy. `policy_snapshot.dev.skill` tells you *which* skill runs
the dev session, but whether that skill's contract with the adapter includes writing
`tasks/<task-id>/result.json` is a property of the skill itself, not of anything bmad-loop
records. Some dev-skill contracts write it; others never do, and the adapter synthesises the
result from the story spec's frontmatter instead. Policy is silent on this either way.

The only honest procedure is to open a real run and look: `ls .bmad-loop/runs/<run-id>/tasks/<task-id>/`
and record exactly what's there. A `result.json` present settles it `true`. Its absence is
not automatic proof of `false` — check the task dir for `resultless-stops.jsonl` too
(`references/run-anatomy.md`: "only on a Stop whose artifact read-back was empty"); its
presence means the skill's contract expected a result and didn't get one, which is still
evidence the contract calls for one, just that this particular session failed to produce it.
When no run exists yet, this field stays `TODO(confirm: no run exists to inspect a task
directory)` — do not infer it from the dev skill's name or from what similar skills usually
do.

## 2. Scaffold

```bash
python3 <skill-dir>/scripts/bootstrap_adapter.py --repo-root <repo>
```

Writes `_project/bmad-loop/environment.toml`, `_project/bmad-loop/environment.md`, and
`_project/README.md` if the `_project/` layer is new — from the skill's bundled templates,
stamped with today's date, skipping any file that already exists. A skip is reported, not
treated as a conflict: `_project/` is a shared adapter namespace, and another skill (e.g.
`project-manager`) may have created `_project/README.md` first. Never hand-copy the
skeletons — the script is what keeps every repo's adapter byte-identical in structure.

## 3. Fill

Edit the stamped files with the values from §1, one field at a time:

- Every value carries its source in `environment.md`'s "Current state" section (path or
  command, not just the value) so the next reader — human or agent — can re-verify it
  without redoing the research.
- Unverifiable values keep `TODO(confirm: <what you looked at>)`, never a plausible-looking
  placeholder. An empty `results` section that should have matched is indistinguishable
  from a clean run until someone checks the constants against a real log — that is exactly
  the failure mode a `TODO` prevents and a guess causes.
- `environment.md`'s "What the log heuristics assume here" section is where
  `orchestrator.coding_cli` earns its keep: name, for this repo, whether the extractor's
  Claude Code vocabulary (spinner frames, `Done(N tool uses · T tokens · Ns)`, the
  `… +N lines (ctrl+o to expand)` collapse marker) actually matches a sample of a real log,
  or whether this repo runs a different adapter and the section should say so plainly.
- `environment.md`'s "Verify commands that cannot fail the run" section restates
  `verify.non_fatal_steps` in prose — which command, why it's non-fatal, what its silent
  failure would look like downstream (e.g. a sprint-backlog count that never moves even
  though a story reached `done`).

## 4. Confirm with the user

Before the first real inspection, present compactly:

- every drafted value **with its source** (file path, or the exact command you ran),
- every `TODO(confirm)` as an explicit question — `writes_result_json` will usually be one
  of these on a fresh repo,
- anything surprising found while researching (a `policy.toml` that disagrees with the last
  run's snapshot, a `mux_backend` that isn't what `bmad-loop mux` reports as selected,
  `verify.commands` with more `|| true` steps than expected).

Do not run a probe or a transcript extraction against this adapter until the user has
confirmed it. A wrong `coding_cli` confirmed by nobody produces a confidently wrong report
later, and by then the wrong value looks load-bearing instead of provisional.

## 5. Verify the adapter itself

- The TOML parses:
  `python3 -c "import tomllib; tomllib.load(open('_project/bmad-loop/environment.toml','rb'))"`.
- `orchestrator.coding_cli` matches what `bmad-loop adapters` reports for the profile this
  repo actually runs.
- `orchestrator.writes_result_json` matches what a real run's `tasks/<task-id>/` directory
  actually contains — not what the dev-skill's name suggests it should contain.
- `orchestrator.mux_backend` matches the SELECTED row of `bmad-loop mux`.
- `backlog.source` matches a real run's `state.json` `source` field, if one exists.

Only once these hold is the repo ready for its first real inspection.

## When the adapter and reality disagree later

If a later inspection turns up a run whose `policy_snapshot.adapter.name`,
`policy_snapshot.dev.skill`, or `source` no longer matches the adapter's recorded value, that
is a finding about the adapter, not a reason to silently read around it. Report the mismatch
to the user, fix the TOML in place, and bump `project.updated`. Do not carry a private
correction in your head and keep using it unrecorded — the next reader of the adapter, human
or agent, has no way to see a correction that only lived in one session's reasoning.
