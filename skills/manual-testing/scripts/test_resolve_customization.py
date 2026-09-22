#!/usr/bin/env python3
"""Tests for resolve_customization.py.

Usage:
    python3 .agents/skills/manual-testing/scripts/test_resolve_customization.py
"""
from __future__ import annotations

import json
import shutil
import subprocess
import sys
import tempfile
import tomllib
import unittest
from pathlib import Path

SCRIPT = Path(__file__).resolve().parent / "resolve_customization.py"

BASE_TOML = (
    "[workflow]\n"
    "activation_steps_prepend = []\n"
    "activation_steps_append = []\n"
    "persistent_facts = []\n"
    'on_complete = ""\n'
    "\n"
    '[[checks]]\n'
    'id = "a"\n'
    "value = 1\n"
    "\n"
    '[[checks]]\n'
    'id = "b"\n'
    "value = 2\n"
)


def write(path: Path, content: str) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(content)


def run(skill_root: Path, repo_root: Path, *extra_args: str) -> subprocess.CompletedProcess:
    return subprocess.run(
        [
            sys.executable,
            str(SCRIPT),
            "--skill-root",
            str(skill_root),
            "--repo-root",
            str(repo_root),
            *extra_args,
        ],
        capture_output=True,
        text=True,
    )


class ResolveCustomizationTest(unittest.TestCase):
    def setUp(self) -> None:
        self.skill_root = Path(tempfile.mkdtemp())
        self.repo_root = Path(tempfile.mkdtemp())
        self.addCleanup(shutil.rmtree, self.skill_root, ignore_errors=True)
        self.addCleanup(shutil.rmtree, self.repo_root, ignore_errors=True)

    def test_defaults_only(self):
        write(self.skill_root / "customize.toml", BASE_TOML)
        result = run(self.skill_root, self.repo_root)
        self.assertEqual(result.returncode, 0, result.stderr)
        out = json.loads(result.stdout)
        self.assertTrue(out["layers"][0]["loaded"])
        self.assertFalse(out["layers"][1]["loaded"])
        self.assertFalse(out["layers"][2]["loaded"])
        self.assertEqual(out["customization"], tomllib.loads(BASE_TOML))

    def test_list_append_dedupe_across_layers(self):
        write(self.skill_root / "customize.toml", BASE_TOML)
        write(
            self.repo_root / "_project/testing/manual-testing.toml",
            '[workflow]\nactivation_steps_append = ["a", "b"]\n',
        )
        write(
            self.repo_root / "_project/testing/manual-testing.user.toml",
            '[workflow]\nactivation_steps_append = ["b", "c"]\n',
        )
        out = json.loads(run(self.skill_root, self.repo_root).stdout)
        self.assertEqual(
            out["customization"]["workflow"]["activation_steps_append"], ["a", "b", "c"]
        )

    def test_scalar_replace_user_beats_team_beats_default(self):
        write(self.skill_root / "customize.toml", BASE_TOML)
        write(
            self.repo_root / "_project/testing/manual-testing.toml",
            '[workflow]\non_complete = "team-value"\n',
        )
        write(
            self.repo_root / "_project/testing/manual-testing.user.toml",
            '[workflow]\non_complete = "user-value"\n',
        )
        out = json.loads(run(self.skill_root, self.repo_root).stdout)
        self.assertEqual(out["customization"]["workflow"]["on_complete"], "user-value")

    def test_array_of_tables_merge_by_id(self):
        write(self.skill_root / "customize.toml", BASE_TOML)
        write(
            self.repo_root / "_project/testing/manual-testing.toml",
            '[[checks]]\nid = "a"\nvalue = 99\n\n[[checks]]\nid = "c"\nvalue = 3\n',
        )
        out = json.loads(run(self.skill_root, self.repo_root).stdout)
        self.assertEqual(
            out["customization"]["checks"],
            [{"id": "a", "value": 99}, {"id": "b", "value": 2}, {"id": "c", "value": 3}],
        )

    def test_project_root_substitution_and_glob_expansion(self):
        write(
            self.skill_root / "customize.toml",
            "[workflow]\n"
            "activation_steps_prepend = []\n"
            "activation_steps_append = []\n"
            'persistent_facts = ["file:{project-root}/_project/testing/*.md"]\n'
            'on_complete = ""\n',
        )
        write(self.repo_root / "_project/testing/a.md", "a")
        write(self.repo_root / "_project/testing/b.md", "b")
        result = run(self.skill_root, self.repo_root)
        self.assertEqual(result.returncode, 0, result.stderr)
        out = json.loads(result.stdout)
        expected = sorted(
            f"file:{(self.repo_root / '_project/testing' / name).resolve()}"
            for name in ("a.md", "b.md")
        )
        self.assertEqual(
            sorted(out["customization"]["workflow"]["persistent_facts"]), expected
        )
        self.assertEqual(out["warnings"], [])

    def test_unmatched_glob_dropped_with_warning(self):
        write(
            self.skill_root / "customize.toml",
            "[workflow]\n"
            "activation_steps_prepend = []\n"
            "activation_steps_append = []\n"
            'persistent_facts = ["file:{project-root}/_project/testing/missing-*.md"]\n'
            'on_complete = ""\n',
        )
        result = run(self.skill_root, self.repo_root)
        self.assertEqual(result.returncode, 0, result.stderr)
        out = json.loads(result.stdout)
        self.assertEqual(out["customization"]["workflow"]["persistent_facts"], [])
        self.assertEqual(len(out["warnings"]), 1)
        self.assertIn("no file matches", out["warnings"][0])

    def test_invalid_toml_in_team_layer_exits_2(self):
        write(self.skill_root / "customize.toml", BASE_TOML)
        bad_path = self.repo_root / "_project/testing/manual-testing.toml"
        write(bad_path, "this is not valid toml [[[")
        result = run(self.skill_root, self.repo_root)
        self.assertEqual(result.returncode, 2)
        self.assertIn(str(bad_path), result.stderr)

    def test_key_flag_filters_output(self):
        write(self.skill_root / "customize.toml", BASE_TOML)
        result = run(
            self.skill_root,
            self.repo_root,
            "--key",
            "workflow.on_complete",
            "--key",
            "nope.missing",
        )
        self.assertEqual(result.returncode, 0, result.stderr)
        out = json.loads(result.stdout)
        self.assertEqual(
            out["customization"], {"workflow.on_complete": "", "nope.missing": None}
        )


if __name__ == "__main__":
    unittest.main()
