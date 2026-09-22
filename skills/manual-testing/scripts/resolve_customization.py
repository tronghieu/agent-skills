#!/usr/bin/env python3
"""Merge the manual-testing skill's three TOML customization layers and print
the result as JSON, so an agent can read one resolved view instead of three files.

Usage:
    python3 resolve_customization.py [--skill-root PATH] [--repo-root PATH] [--key DOTTED.KEY ...]
"""
from __future__ import annotations

import argparse
import glob
import json
import os
import sys

try:
    import tomllib
except ModuleNotFoundError:  # Python < 3.11
    try:
        import tomli as tomllib  # type: ignore[no-redef]
    except ModuleNotFoundError:
        sys.exit("error: needs Python 3.11+ (tomllib) or `pip install tomli`")

from pathlib import Path

# Resolved relative to this script's own location, not cwd, so the skill (and this
# script) can be copied verbatim into any other repo and still find its own default.
DEFAULT_SKILL_ROOT = Path(__file__).resolve().parent.parent

# (path relative to skill root or repo root, required)
LAYER_SPECS = [
    ("customize.toml", True),
    ("_project/testing/manual-testing.toml", False),
    ("_project/testing/manual-testing.user.toml", False),
]


def find_repo_root(start: Path) -> Path | None:
    for candidate in [start, *start.parents]:
        if (candidate / "_project").is_dir() or (candidate / ".git").exists():
            return candidate
    return None


def load_toml(path: Path) -> dict:
    with path.open("rb") as f:
        return tomllib.load(f)


def is_table_list(items: list) -> bool:
    # Empty is vacuously a table-list: it must not force a plain-list append
    # when the other side is a real array-of-tables keyed by id.
    return all(isinstance(item, dict) and "id" in item for item in items)


def merge_table_lists(base: list, override: list) -> list:
    result = list(base)
    index_by_id = {item["id"]: i for i, item in enumerate(result)}
    for item in override:
        if item["id"] in index_by_id:
            result[index_by_id[item["id"]]] = item
        else:
            index_by_id[item["id"]] = len(result)
            result.append(item)
    return result


def merge_plain_list(base: list, override: list) -> list:
    result = list(base)
    for item in override:
        if item not in result:
            result.append(item)
    return result


def merge(base, override):
    if isinstance(base, dict) and isinstance(override, dict):
        merged = dict(base)
        for key, value in override.items():
            merged[key] = merge(merged[key], value) if key in merged else value
        return merged
    if isinstance(base, list) and isinstance(override, list):
        if (base or override) and is_table_list(base) and is_table_list(override):
            return merge_table_lists(base, override)
        return merge_plain_list(base, override)
    # Scalar, or a type mismatch (list vs string, table vs scalar, ...): override wins.
    return override


def substitute(value, mapping: dict[str, str]):
    if isinstance(value, str):
        for placeholder, replacement in mapping.items():
            value = value.replace(placeholder, replacement)
        return value
    if isinstance(value, dict):
        return {key: substitute(v, mapping) for key, v in value.items()}
    if isinstance(value, list):
        return [substitute(v, mapping) for v in value]
    return value


def expand_persistent_facts(customization: dict) -> list[str]:
    workflow = customization.get("workflow")
    if not isinstance(workflow, dict) or not isinstance(workflow.get("persistent_facts"), list):
        return []

    warnings: list[str] = []
    expanded: list[str] = []
    for entry in workflow["persistent_facts"]:
        if isinstance(entry, str) and entry.startswith("file:"):
            pattern = entry[len("file:"):]
            matches = sorted(p for p in glob.glob(pattern, recursive=True) if os.path.isfile(p))
            if not matches:
                warnings.append(f"persistent_facts: no file matches {pattern}")
                continue
            expanded.extend(f"file:{os.path.abspath(m)}" for m in matches)
        else:
            expanded.append(entry)

    deduped: list[str] = []
    for item in expanded:
        if item not in deduped:
            deduped.append(item)
    workflow["persistent_facts"] = deduped
    return warnings


def get_dotted(tree: dict, dotted_key: str):
    node = tree
    for part in dotted_key.split("."):
        if isinstance(node, dict) and part in node:
            node = node[part]
        else:
            return None
    return node


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--skill-root", type=Path, default=None)
    parser.add_argument("--repo-root", type=Path, default=None)
    parser.add_argument("--key", action="append", dest="keys", default=None)
    args = parser.parse_args()

    skill_root = (args.skill_root or DEFAULT_SKILL_ROOT).resolve()

    if args.repo_root is not None:
        repo_root = args.repo_root.resolve()
    else:
        found = find_repo_root(Path.cwd())
        if found is None:
            print(
                "error: no repo root found (no _project/ or .git from cwd upward)",
                file=sys.stderr,
            )
            return 2
        repo_root = found

    roots = {"customize.toml": skill_root}
    merged: dict = {}
    layers_meta: list[dict] = []

    for rel_path, required in LAYER_SPECS:
        root = roots.get(rel_path, repo_root)
        path = root / rel_path
        if not path.exists():
            if required:
                print(f"error: required customization file missing: {path}", file=sys.stderr)
                return 2
            layers_meta.append({"path": str(path), "loaded": False})
            continue
        try:
            data = load_toml(path)
        except tomllib.TOMLDecodeError as e:
            print(f"error: invalid TOML in {path}: {e}", file=sys.stderr)
            return 2
        merged = merge(merged, data)
        layers_meta.append({"path": str(path), "loaded": True})

    merged = substitute(
        merged, {"{project-root}": str(repo_root), "{skill-root}": str(skill_root)}
    )
    warnings = expand_persistent_facts(merged)

    customization = (
        {key: get_dotted(merged, key) for key in args.keys} if args.keys else merged
    )

    print(
        json.dumps(
            {
                "repo_root": str(repo_root),
                "skill_root": str(skill_root),
                "layers": layers_meta,
                "customization": customization,
                "warnings": warnings,
            },
            indent=2,
            ensure_ascii=False,
        )
    )
    return 0


if __name__ == "__main__":
    sys.exit(main())
