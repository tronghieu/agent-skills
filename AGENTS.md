# AGENTS.md

This file provides guidance to AI coding agents (Claude Code, Cursor, Copilot, etc.) when working with code in this repository.
use skill-creator skill for creating agent skill

## Repository Overview

A collection of skills for AI agents. Skills are packaged instructions and scripts that extend Claude's capabilities.

## Creating a New Skill

### Directory Structure

```
skills/
  {skill-name}/           # kebab-case directory name
    SKILL.md              # Required: skill definition
    scripts/              # Required: executable scripts
      {script-name}.sh    # Bash or Python, both first-class (.sh / .py)
  {skill-name}.zip        # Required: packaged for distribution
```

### Naming Conventions

- **Skill directory**: `kebab-case` (e.g., `system-prompt-creator`, `log-monitor`)
- **SKILL.md**: Always uppercase, always this exact filename
- **Scripts**: `kebab-case.sh` for Bash (e.g., `deploy.sh`, `fetch-logs.sh`); `snake_case.py` for new Python scripts (e.g., `profile_data.py`, `board_check.py`) — one older script, `export-deck-pdf.py`, predates this and stays kebab-case
- **Zip file**: Must match directory name exactly: `{skill-name}.zip`

### SKILL.md Format

```markdown
---
name: {skill-name}
description: {One sentence describing when to use this skill. Include trigger phrases like "Deploy my app", "Check logs", etc.}
---

# {Skill Title}

{Brief description of what the skill does.}

## How It Works

{Numbered list explaining the skill's workflow}

## Usage

```bash
bash /mnt/skills/user/{skill-name}/scripts/{script}.sh [args]
```

**Arguments:**
- `arg1` - Description (defaults to X)

**Examples:**
{Show 2-3 common usage patterns}

## Output

{Show example output users will see}

## Present Results to User

{Template for how Claude should format results when presenting to users}

## Troubleshooting

{Common issues and solutions, especially network/permissions errors}
```

### Best Practices for Context Efficiency

Skills are loaded on-demand — only the skill name and description are loaded at startup. The full `SKILL.md` loads into context only when the agent decides the skill is relevant. To minimize context usage:

- **Keep SKILL.md under 500 lines** — put detailed reference material in separate files
- **Write specific descriptions** — helps the agent know exactly when to activate the skill
- **Use progressive disclosure** — reference supporting files that get read only when needed
- **Prefer scripts over inline code** — script execution doesn't consume context (only output does)
- **File references work one level deep** — link directly from SKILL.md to supporting files

### Script Requirements

Bash and Python are both first-class — pick whichever fits the job, don't rank one over the other:

- **Bash** for scaffolding and orchestration: creating files/directories, calling other CLIs, idempotent setup that reports created-vs-skipped (e.g., `init-project.sh`).
- **Python** for analysis tools: parsing, statistics, structured checks whose consumer is an agent reading prose, not a pipeline (e.g., `profile_data.py`, `board_check.py`).
- Bash scripts use a `#!/bin/bash` shebang and `set -e` for fail-fast behavior. Python scripts use a `#!/usr/bin/env python3` shebang.
- Status on stderr and machine-readable JSON on stdout are required only for scripts whose output is meant to be consumed programmatically — not for a scaffolder reporting to a human or an analysis tool an agent reads as prose.
- A script that serves both audiences should offer a `--json` flag (the convention, e.g. `run_probe.py --json`) rather than choosing one output for everyone.
- Include a cleanup trap only in scripts that create temporary state (e.g. files under `/tmp`); a script that only writes its own permanent output doesn't need one.
- Reference the script path as `/mnt/skills/user/{skill-name}/scripts/{script}.sh` (or `.py` for Python scripts)

### Creating the Zip Package

After creating or updating a skill:

```bash
cd skills
zip -r {skill-name}.zip {skill-name}/
```

### End-User Installation

Document these two installation methods for users:

**Coding agent**
```bash
cp -r skills/{skill-name} ~/.agents/skills/
```

**Claude Code:**
```bash
cp -r skills/{skill-name} ~/.claude/skills/
```

**claude.ai:**
Add the skill to project knowledge or paste SKILL.md contents into the conversation.

If the skill requires network access, instruct users to add required domains at `claude.ai/settings/capabilities`.

## Project-specific facts: the `_project/` adapter

A skill that needs facts about the user's repository (ports, seeded accounts, which coding CLI, which test runner) keeps them out of the skill and reads them from `_project/` at the repository root. The skill stays generic. The adapter answers its questions for one repository.

Contract:

- `_project/` is one shared root. A skill claims one subpath and writes nowhere else. Today: `bmad-run-inspector` owns `_project/bmad-loop/`, `manual-testing` owns `_project/testing/`, `scrum-master` owns `_project/scrum-master/`. `project-manager` owns the root itself; it predates this rule and is the only exception.
- Files at the root (`README.md`, `tools.md`) belong to every skill. Create one if absent, append your own section, never rewrite another skill's.
- Values a script reads go in TOML (`environment.toml`). Knowledge and judgment calls go in Markdown (`environment.md`) with a dated "current state" section, rewritten in place, never appended.
- A team override is `<skill>.toml`, committed. A personal override is `<skill>.user.toml`, gitignored. Layers merge base, then team, then user. A skill that supports overrides ships its own `customize.toml` as the schema and its own resolver script.
- A bootstrap script scaffolds the subpath from `assets/templates/`, never overwrites an existing file, reports created versus skipped, and marks every value it could not read from a real file as `TODO(confirm: <source>)`. It never guesses.
- The skill must work when `_project/` is absent: bootstrap it, or degrade and say so. A missing adapter is never an error.
- This repository has no shared runtime. Each skill is installed on its own, so each ships its own scripts. Copy the resolver into the new skill. Never depend on another skill being present.
