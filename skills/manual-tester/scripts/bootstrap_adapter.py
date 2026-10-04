#!/usr/bin/env python3
"""Bootstrap _project/testing/ (and _project/README.md) from this skill's templates.

Never overwrites an existing file, so it's safe to re-run in any repo at any time —
files that already exist are reported as skipped, not touched. An existing
`_project/README.md` gets this skill's section appended if it is missing.

Usage:
    python3 bootstrap_adapter.py [--repo-root PATH]
"""
from __future__ import annotations

import argparse
import sys

try:
    import tomllib
except ModuleNotFoundError:  # Python < 3.11
    try:
        import tomli as tomllib  # type: ignore[no-redef]
    except ModuleNotFoundError:
        sys.exit("error: needs Python 3.11+ (tomllib) or `pip install tomli`")

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
    ("gitignore", "_project/testing/.gitignore"),
]

# The README section this skill owns, bounded by these two headings in project-readme.md.
README_SECTION_MARKER = "### `testing/`"
README_SECTION_STOP = "## Further reading"


def looks_like_repo_root(root: Path) -> bool:
    return (root / ".git").exists() or (root / "package.json").exists()


def stamp_date(text: str, today: str) -> str:
    # TODO(date) is the one placeholder this script can resolve on its own.
    # TODO(confirm: ...) placeholders stay — they need a human/model to research them.
    return text.replace("TODO(date)", today)


def sync_project_readme(repo_root: Path, today: str) -> str:
    """Create, append to, or skip _project/README.md. Returns created/appended/skipped."""
    dest = repo_root / "_project/README.md"
    template_path = TEMPLATES_DIR / "project-readme.md"

    if not dest.exists():
        dest.parent.mkdir(parents=True, exist_ok=True)
        dest.write_text(stamp_date(template_path.read_text(), today))
        return "created"

    existing = dest.read_text()
    if any(line.strip() == README_SECTION_MARKER for line in existing.splitlines()):
        return "skipped"

    template_text = template_path.read_text()
    start = template_text.index(README_SECTION_MARKER)
    end = template_text.index(README_SECTION_STOP, start)
    section = stamp_date(template_text[start:end], today)
    dest.write_text(existing + "\n" + section)
    return "appended"


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

    appended: list[Path] = []
    readme_dest = repo_root / "_project/README.md"
    readme_outcome = sync_project_readme(repo_root, today)
    if readme_outcome == "created":
        created.append(readme_dest)
    elif readme_outcome == "appended":
        appended.append(readme_dest)
    else:
        skipped.append(readme_dest)

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

    print(
        f"created {len(created)} file(s), appended {len(appended)}, "
        f"skipped {len(skipped)} (already existed):"
    )
    for p in created:
        print(f"  created  {p.relative_to(repo_root)}")
    for p in appended:
        print(f"  appended {p.relative_to(repo_root)} (testing section)")
    for p in skipped:
        print(f"  skipped  {p.relative_to(repo_root)} (exists)")

    todo_confirms: list[tuple[Path, int, str]] = []
    for p in created + appended:
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
