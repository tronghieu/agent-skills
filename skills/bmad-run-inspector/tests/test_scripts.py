#!/usr/bin/env python3
"""Regression tests for the bmad-run-inspector helper scripts."""

from __future__ import annotations

import importlib.util
import json
import tempfile
import time
import unittest
from pathlib import Path


SKILL_ROOT = Path(__file__).resolve().parents[1]


def load_script(name: str):
    path = SKILL_ROOT / "scripts" / f"{name}.py"
    spec = importlib.util.spec_from_file_location(f"bmad_run_inspector_{name}", path)
    if spec is None or spec.loader is None:
        raise RuntimeError(f"cannot load {path}")
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


class ExtractTranscriptTests(unittest.TestCase):
    def test_subagent_elapsed_normalization_imports_on_python_39(self):
        extract = load_script("extract_transcript")

        result = extract.classify(["Done(10 tool uses · 99.2k tokens · 1m 0s)"])

        self.assertEqual(result["subagents"], ["10 tool uses · 99.2k tokens · 1m0s"])


class RunProbeAttentionTests(unittest.TestCase):
    def setUp(self):
        self.probe = load_script("run_probe")
        self.temp = tempfile.TemporaryDirectory()
        self.run = Path(self.temp.name)

    def tearDown(self):
        self.temp.cleanup()

    @staticmethod
    def epoch(stamp: str) -> float:
        return time.mktime(time.strptime(stamp, "%Y-%m-%d %H:%M:%S"))

    def cur(self, attention: dict) -> dict:
        return {
            "run_id": "run-1",
            "flags": {},
            "limits": {},
            "pid": "",
            "attention": attention,
            "tasks": {},
            "heartbeats": {},
            "journal_failures": [],
            "stop_request": None,
            "logs": {},
            "isolation": None,
        }

    def test_new_notice_is_reported_from_snapshot_delta(self):
        path = self.run / "ATTENTION"
        path.write_text("[2026-08-26 10:00:00] warning: first\n", encoding="utf-8")
        before = self.probe.attention_state(str(self.run), [])
        path.write_text(
            "[2026-08-26 10:00:00] warning: first\n"
            "[2026-08-26 10:00:05] CRITICAL escalation: Status: done\n",
            encoding="utf-8",
        )
        after = self.probe.attention_state(str(self.run), [])
        previous = {"run_id": "run-1", "attention": before, "tasks": {}, "logs": {}}

        findings = self.probe.diagnose(self.cur(after), previous, {"dirty_count": 0})

        self.assertTrue(any("T1 new since last probe ATTENTION" in item for item in findings))

    def test_later_structured_resolution_makes_notice_historical(self):
        stamp = "2026-08-26 10:00:00"
        (self.run / "ATTENTION").write_text(
            f"[{stamp}] story warning: retry budget\n", encoding="utf-8"
        )
        attention = self.probe.attention_state(
            str(self.run),
            [{"kind": "story-done", "ts": self.epoch(stamp) + 5}],
        )

        findings = self.probe.diagnose(self.cur(attention), None, {"dirty_count": 0})

        self.assertTrue(attention["historical"])
        self.assertFalse(any(item.startswith("T1") and "ATTENTION" in item for item in findings))
        self.assertTrue(any("historical notices" in item for item in findings))

    def test_missing_final_newline_marks_possible_partial_append(self):
        (self.run / "ATTENTION").write_text(
            "[2026-08-26 10:00:00] warning: cut mid-wo", encoding="utf-8"
        )

        attention = self.probe.attention_state(str(self.run), [])

        self.assertTrue(attention["possible_partial_append"])

    def test_stop_request_only_trusts_explicit_hard_mode(self):
        path = self.run / "stop-request.json"
        path.write_text(json.dumps({"mode": "hard", "requested_at": "now"}), encoding="utf-8")
        self.assertEqual(self.probe.stop_request(str(self.run))["mode"], "hard")

        path.write_text("not json", encoding="utf-8")
        self.assertEqual(self.probe.stop_request(str(self.run))["mode"], "graceful")


if __name__ == "__main__":
    unittest.main()
