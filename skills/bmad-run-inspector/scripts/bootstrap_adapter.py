#!/usr/bin/env python3
"""Bootstrap _project/bmad-loop/ (and _project/README.md) from this skill's templates.

Never overwrites an existing file, so it's safe to re-run in any repo, including one
where a sibling skill (or an earlier run) already wrote part of the shared _project/
adapter namespace.

Usage:
    python3 bootstrap_adapter.py [--repo-root PATH]
"""
from __future__ import annotations

import argparse
import json
import re
import sys
import tomllib
from datetime import date
from pathlib import Path

# Resolved relative to this script's own location, not cwd, so the skill (and this
# script) can be copied verbatim into any other repo and still find its templates.
TEMPLATES_DIR = Path(__file__).resolve().parent.parent / "assets" / "templates"

# (template filename in TEMPLATES_DIR, destination path relative to the repo root)
FILE_MAP = [
    ("environment.toml", "_project/bmad-loop/environment.toml"),
    ("environment.md", "_project/bmad-loop/environment.md"),
    ("project-readme.md", "_project/README.md"),
]

TOML_DEST = "_project/bmad-loop/environment.toml"

# Matches the [project].updated line regardless of what placeholder the template
# ships with (empty string, "TODO(date)", or a stale date from a prior stamp).
UPDATED_RE = re.compile(r'^(updated\s*=\s*)"[^"]*"', re.MULTILINE)


def looks_like_repo_root(root: Path) -> bool:
    # Deliberately language-agnostic: a manifest name would only recognise one stack,
    # and the adapter exists precisely so this skill stops assuming one.
    return (root / ".git").exists() or (root / ".bmad-loop").exists()


def stamp_updated(text: str, today: str) -> str:
    return UPDATED_RE.sub(lambda m: f'{m.group(1)}"{today}"', text, count=1)


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    # default=None (not Path.cwd()) so an explicit --repo-root never depends on cwd
    # even being resolvable.
    parser.add_argument("--repo-root", type=Path, default=None)
    args = parser.parse_args()

    repo_root = (args.repo_root or Path.cwd()).resolve()
    if not looks_like_repo_root(repo_root):
        print(
            f"error: {repo_root} doesn't look like a repo root (no .git or .bmad-loop)",
            file=sys.stderr,
        )
        return 2

    today = date.today().isoformat()
    created: list[Path] = []
    skipped: list[Path] = []

    for template_name, dest_rel in FILE_MAP:
        dest = repo_root / dest_rel
        if dest.exists():
            skipped.append(dest)
            continue

        template_path = TEMPLATES_DIR / template_name
        try:
            text = template_path.read_text()
        except OSError as e:
            print(f"error: can't read template {template_path}: {e}", file=sys.stderr)
            return 1

        if dest_rel == TOML_DEST:
            text = stamp_updated(text, today)

        dest.parent.mkdir(parents=True, exist_ok=True)
        dest.write_text(text)
        created.append(dest)

    # A scaffold that can't be parsed is worse than none — fail loudly rather than
    # hand back an adapter the skill will silently fail to read later.
    toml_dest = repo_root / TOML_DEST
    if toml_dest in created:
        with toml_dest.open("rb") as f:
            try:
                tomllib.load(f)
            except tomllib.TOMLDecodeError as e:
                print(f"error: stamped environment.toml doesn't parse: {e}", file=sys.stderr)
                return 1

    print(
        f"created {len(created)} file(s), skipped {len(skipped)} (already existed):",
        file=sys.stderr,
    )
    for p in created:
        print(f"  created  {p.relative_to(repo_root)}", file=sys.stderr)
    for p in skipped:
        print(f"  skipped  {p.relative_to(repo_root)} (exists)", file=sys.stderr)

    todos: list[dict] = []
    for p in created:
        for lineno, line in enumerate(p.read_text().splitlines(), start=1):
            if "TODO(confirm" not in line:
                continue
            # A comment-only TOML line is the template explaining the convention, not a
            # value awaiting research — counting it inflates the work the user is told to do.
            if p.suffix == ".toml" and line.lstrip().startswith("#"):
                continue
            todos.append(
                {"file": str(p.relative_to(repo_root)), "line": lineno, "text": line.strip()}
            )

    if todos:
        print(f"\n{len(todos)} value(s) need research before the adapter can be trusted:", file=sys.stderr)
        for t in todos:
            print(f"  {t['file']}:{t['line']}: {t['text']}", file=sys.stderr)

    summary = {
        "repo_root": str(repo_root),
        "created": [str(p.relative_to(repo_root)) for p in created],
        "skipped": [str(p.relative_to(repo_root)) for p in skipped],
        "todos": todos,
    }
    print(json.dumps(summary))

    return 0


if __name__ == "__main__":
    sys.exit(main())
