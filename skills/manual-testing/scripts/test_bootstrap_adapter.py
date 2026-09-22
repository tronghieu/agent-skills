#!/usr/bin/env python3
"""Tests for bootstrap_adapter.py.

Usage:
    python3 scripts/test_bootstrap_adapter.py
"""
from __future__ import annotations

import subprocess
import sys
import tempfile
import unittest
from pathlib import Path

SCRIPT = Path(__file__).resolve().parent / "bootstrap_adapter.py"

CREATED_FILES = [
    "_project/testing/environment.toml",
    "_project/testing/environment.md",
    "_project/testing/verification-queries.md",
    "_project/testing/.gitignore",
    "_project/README.md",
]

EXISTING_README = (
    "# Adapter\n\n### `bmad-loop/`\n\nowned by another skill\n"
)


def run(repo_root: Path) -> subprocess.CompletedProcess:
    return subprocess.run(
        [sys.executable, str(SCRIPT), "--repo-root", str(repo_root)],
        capture_output=True,
        text=True,
    )


class BootstrapAdapterTest(unittest.TestCase):
    def setUp(self) -> None:
        self.tmp = tempfile.TemporaryDirectory()
        self.repo_root = Path(self.tmp.name)
        (self.repo_root / ".git").mkdir()

    def tearDown(self) -> None:
        self.tmp.cleanup()

    def test_fresh_repo_creates_everything(self) -> None:
        result = run(self.repo_root)
        self.assertEqual(result.returncode, 0, result.stderr)

        for rel in CREATED_FILES:
            path = self.repo_root / rel
            self.assertTrue(path.exists(), f"{rel} was not created")
            self.assertNotIn("TODO(date)", path.read_text(), rel)

        gitignore = (self.repo_root / "_project/testing/.gitignore").read_text()
        self.assertIn("*.user.toml", gitignore)

    def test_second_run_skips_everything_unchanged(self) -> None:
        run(self.repo_root)
        before = {
            rel: (self.repo_root / rel).read_bytes() for rel in CREATED_FILES
        }

        result = run(self.repo_root)
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertIn("created 0 file(s)", result.stdout)
        self.assertIn("appended 0", result.stdout)
        self.assertIn(f"skipped {len(CREATED_FILES)}", result.stdout)

        for rel in CREATED_FILES:
            self.assertEqual((self.repo_root / rel).read_bytes(), before[rel], rel)

    def test_appends_to_existing_readme_without_marker(self) -> None:
        readme = self.repo_root / "_project/README.md"
        readme.parent.mkdir(parents=True)
        readme.write_text(EXISTING_README)

        result = run(self.repo_root)
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertIn("appended _project/README.md (testing section)", result.stdout)

        content = readme.read_text()
        self.assertTrue(content.startswith(EXISTING_README))
        self.assertIn("### `testing/`", content)
        self.assertNotIn("## Further reading", content)

        # A third run must not append the section again.
        run(self.repo_root)
        content_after = readme.read_text()
        self.assertEqual(content_after.count("### `testing/`"), 1)

    def test_readme_with_marker_already_present_is_untouched(self) -> None:
        readme = self.repo_root / "_project/README.md"
        readme.parent.mkdir(parents=True)
        content = EXISTING_README + "\n### `testing/`\n\nalready here\n"
        readme.write_text(content)
        before = readme.read_bytes()

        result = run(self.repo_root)
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertIn("skipped", result.stdout)
        self.assertEqual(readme.read_bytes(), before)


if __name__ == "__main__":
    unittest.main()
