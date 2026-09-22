# Manual Testing

**Language:** [English](./README.md) | [Tiếng Việt](./README.vi.md) | [中文](./README.zh.md)

Test a running app by hand, the way a skeptical tester does, and prove every finding against the database before calling it a bug.

```bash
npx skills add tronghieu/agent-skills --skill manual-testing
```

## Quick start

```text
Exploratory session on the invitation flow. Timebox 30 minutes.
```

```text
Verify the fix for bug #214: the order total ignored the discount.
```

```text
Smoke test after the deploy: sign in, create a record, check the list.
```

```text
Review the checkout screen's Vietnamese copy.
```

```text
Ask the in-app assistant five questions about this tenant's orders and check its answers against the database.
```

## Why not just click around?

An agent driving a browser sees what the page shows. The page can lie: a toast says "saved" while the row never landed, a list looks empty because the filter is wrong, an error is swallowed before it reaches the screen. A report built on screenshots alone produces false bugs, and one false bug costs more trust than ten real ones earn.

This skill treats the UI as one witness among three. Every finding is triangulated: what the screen showed, what the database row says, what the network and console recorded. "I could not test it" is UNVERIFIED, never FAIL. Judgment calls such as confusing wording stay OBSERVATIONS for a human, with no verdict attached.

## Who it's for

Teams whose automated suites re-check known promises and who need someone to look for the rest: unknown bugs, a fix that broke its neighbor, a screen that reads wrong in one locale, an AI assistant that answers confidently and incorrectly.

## How it works

1. **Resolve the project's testing policy.** `scripts/resolve_customization.py` merges the skill's defaults with the team override in `_project/testing/manual-testing.toml` and a personal `.user.toml`. Policy documents named there stay in context for the whole session and outrank the skill's own defaults.
2. **Read the project adapter.** Ports, services, seeded accounts, auth method, output paths, and preflight checks come from `_project/testing/environment.toml`. The dated "current state" and the how-tos come from `environment.md`. Read-only SQL comes from `verification-queries.md`. On a fresh repo the skill bootstraps the adapter from templates, reads each value from a real file, marks what it cannot confirm, and asks before the first session.
3. **Pick a mode and write the mission.** Exploratory (a charter), verification (one falsifiable claim), smoke (a fixed breadth list), assessment (one lens over a set of screens), or AI probe (a grounded question set). Given a test design or test-case IDs, it first sorts the conditions by which ones need a human at all.
4. **Drive and log.** Browser automation with a running log of action, observation, conclusion. After each step: console, network, i18n keys, tenant leakage, auth boundaries, silent failures.
5. **Verify before verdict.** Read-only SELECT against the local database. Self-check before any FAIL: right account, right element, page loaded, reproduces twice from clean state.
6. **Report.** A session note with a coverage map, one bug report per FAIL, and automation candidates phrased as scenario plus oracle.

## What comes back

- A session note, even when nothing was found, with what was visited, skipped, and never reached.
- A bug report per failure, complete enough for a developer who was not there.
- Observations for human judgment, kept apart from verdicts.
- Automation candidates: what to hand to the e2e or integration suite next.

## Limits

The skill runs only against a local development stack. It never writes to the database and asks before any irreversible action. Database verification assumes a SQL database reachable with `psql` or an equivalent read-only client. It does not write automated tests; it names what to automate. Trust in its findings is bounded by the adapter: a stale `environment.md` produces confident findings about a version of the app that no longer exists, so the adapter is dated and rewritten in place, never appended.
