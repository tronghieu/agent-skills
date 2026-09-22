#!/usr/bin/env python3
"""Bootstrap _project/testing/ (and _project/README.md) from this skill's templates.

Never overwrites an existing file, so it's safe to re-run in any repo at any time —
files that already exist are reported as skipped, not touched.

Usage:
    python3 bootstrap_adapter.py [--repo-root PATH]
"""
from __future__ import annotations

import argparse
import sys
import tomllib
from datetime import date
from pathlib import Path

# Resolved relative to this script's own location, not cwd, so the skill (and this
# script) can be copied verbatim into any other repo and still find its templates.
TEMPLATES_DIR = Path(__file__).resolve().parent.parent / "assets" / "templates"

# (template filename in TEMPLATES_DIR, destination path relative to the repo root)
FILE_MAP = [
    ("environment.toml", "_project/testing/environment.toml"),
    ("environment.md", "_project/testing/environment.md"),
    ("verification-queries.md", "_project/testing/verification-queries.md"),
    ("project-readme.md", "_project/README.md"),
]


def looks_like_repo_root(root: Path) -> bool:
    return (root / ".git").exists() or (root / "package.json").exists()


def stamp_date(text: str, today: str) -> str:
    # TODO(date) is the one placeholder this script can resolve on its own.
    # TODO(confirm: ...) placeholders stay — they need a human/model to research them.
    return text.replace("TODO(date)", today)


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    # default=None (not Path.cwd()) so an explicit --repo-root never depends on cwd
    # even being resolvable.
    parser.add_argument("--repo-root", type=Path, default=None)
    args = parser.parse_args()

    repo_root = (args.repo_root or Path.cwd()).resolve()
    if not looks_like_repo_root(repo_root):
        print(
            f"error: {repo_root} doesn't look like a repo root (no .git or package.json)",
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
        dest.parent.mkdir(parents=True, exist_ok=True)
        text = stamp_date((TEMPLATES_DIR / template_name).read_text(), today)
        dest.write_text(text)
        created.append(dest)

    # The template is a promise of valid TOML; if the stamped copy doesn't parse,
    # the template itself is broken — fail loudly rather than hand back a bad adapter.
    toml_dest = repo_root / "_project/testing/environment.toml"
    if toml_dest in created:
        with toml_dest.open("rb") as f:
            try:
                tomllib.load(f)
            except tomllib.TOMLDecodeError as e:
                print(f"error: stamped environment.toml doesn't parse: {e}", file=sys.stderr)
                return 1

    print(f"created {len(created)} file(s), skipped {len(skipped)} (already existed):")
    for p in created:
        print(f"  created  {p.relative_to(repo_root)}")
    for p in skipped:
        print(f"  skipped  {p.relative_to(repo_root)} (exists)")

    todo_confirms: list[tuple[Path, int, str]] = []
    for p in created:
        for lineno, line in enumerate(p.read_text().splitlines(), start=1):
            if "TODO(confirm" in line:
                todo_confirms.append((p, lineno, line.strip()))

    if todo_confirms:
        print(
            f"\n{len(todo_confirms)} value(s) need research"
            " — see references/adapter-bootstrap.md §1:"
        )
        for p, lineno, line in todo_confirms:
            print(f"  {p.relative_to(repo_root)}:{lineno}: {line}")

    return 0


if __name__ == "__main__":
    sys.exit(main())
