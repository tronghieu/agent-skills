#!/usr/bin/env python3
"""Behavioral checks for arithmetic, evidence validation, and the CLI contract."""

import copy
from decimal import Decimal
import importlib.util
import json
from pathlib import Path
import subprocess
import sys
import tempfile
import unittest

ROOT = Path(__file__).resolve().parents[1]
SCRIPT = ROOT / 'scripts' / 'score_report.py'
spec = importlib.util.spec_from_file_location('score_report', SCRIPT)
scorer = importlib.util.module_from_spec(spec)
spec.loader.exec_module(scorer)


def example():
    return json.loads((ROOT / 'evals' / 'fixtures' / 'example-report.json').read_text())


def set_status(assessment, status, score):
    assessment.update(status=status, score=score, contradiction=False)
    if status == 'unknown':
        assessment['evidence'] = []
        assessment['searched_locations'] = ['Experience', 'Skills']
    else:
        assessment['evidence'] = [{'quote': 'Synthetic supporting statement.', 'location': 'Experience'}]
        assessment['searched_locations'] = []


class ScoringTests(unittest.TestCase):
    def test_documented_score_does_not_renormalize_unknown(self):
        result = scorer.calculate(example())
        calc = result['candidates'][0]['calculation']
        self.assertEqual((calc['documented_score'], calc['possible_score'], calc['coverage_percent']), (60, 100, 60))
        self.assertEqual(calc['score_range'], [60, 100])
        self.assertIsNone(result['candidates'][0]['assessments'][1]['weighted_points'])
        self.assertEqual(calc['review_status'], 'needs_verification')

    def test_high_score_does_not_cancel_required_mismatch(self):
        report = example()
        report['rubric']['criteria'][0]['weight'] = 10
        report['rubric']['criteria'][1]['weight'] = 90
        assessments = report['candidates'][0]['assessments']
        set_status(assessments[0], 'unmet', 0)
        set_status(assessments[1], 'met', 4)
        calc = scorer.calculate(report)['candidates'][0]['calculation']
        self.assertEqual(calc['documented_score'], 90)
        self.assertEqual(calc['alignment_band'], 'high')
        self.assertEqual(calc['mandatory_status'], 'unmet')
        self.assertEqual(calc['review_status'], 'criteria_review')
        self.assertEqual(calc['unmet_must_haves'], ['api'])

    def test_unknown_required_is_unranked(self):
        report = example()
        set_status(report['candidates'][0]['assessments'][0], 'unknown', None)
        result = scorer.calculate(report)
        calc = result['candidates'][0]['calculation']
        self.assertEqual(calc['mandatory_status'], 'unknown')
        self.assertEqual(calc['unknown_must_haves'], ['api'])
        self.assertEqual(result['batch']['ranking'], [])
        self.assertIn('unknown_must_haves', result['batch']['unranked'][0]['reasons'])

    def test_partial_required_needs_review(self):
        report = example()
        set_status(report['candidates'][0]['assessments'][0], 'partial', 3)
        calc = scorer.calculate(report)['candidates'][0]['calculation']
        self.assertEqual(calc['documented_score'], 45)
        self.assertEqual(calc['mandatory_status'], 'unmet')
        self.assertEqual(calc['review_status'], 'criteria_review')

    def test_incomplete_extraction_withholds_totals(self):
        for state in ('partial', 'unreadable'):
            with self.subTest(state=state):
                report = example()
                report['candidates'][0]['extraction'] = {'status': state, 'limitations': ['Page 2 unavailable.']}
                result = scorer.calculate(report)
                calc = result['candidates'][0]['calculation']
                for field in ('documented_score', 'possible_score', 'coverage_percent', 'score_range', 'alignment_band'):
                    self.assertIsNone(calc[field])
                self.assertEqual(calc['review_status'], 'insufficient_input')
                self.assertEqual(result['batch']['ranking'], [])

    def test_contradiction_requires_two_quotes_and_is_unranked(self):
        report = example()
        item = report['candidates'][0]['assessments'][1]
        item.update(contradiction=True, evidence=[{'quote': 'Valid until 2027.', 'location': 'Page 1'},
                                                 {'quote': 'Expired in 2025.', 'location': 'Page 2'}])
        result = scorer.calculate(report)
        self.assertEqual(result['batch']['ranking'], [])
        self.assertIn('contradictory_evidence', result['batch']['unranked'][0]['reasons'])
        item['evidence'].pop()
        with self.assertRaises(scorer.ReportError):
            scorer.calculate(report)

    def test_ties_and_order_name_invariance(self):
        report = example()
        a = report['candidates'][0]
        set_status(a['assessments'][1], 'met', 4)
        b = copy.deepcopy(a)
        b.update(id='candidate-b', name='Another name')
        c = copy.deepcopy(a)
        c.update(id='candidate-c', name='Third name')
        set_status(c['assessments'][1], 'unmet', 0)
        report['candidates'] += [b, c]
        before = scorer.calculate(report)['batch']
        report['candidates'].reverse()
        for candidate in report['candidates']:
            candidate['name'] = 'Different name'
        after = scorer.calculate(report)['batch']
        self.assertEqual(before, after)
        self.assertEqual([row['rank'] for row in before['ranking']], [1, 1, 3])
        self.assertFalse(before['ordering_provisional'])

    def test_overlapping_uncertainty_ranges_are_provisional(self):
        report = example()
        b = copy.deepcopy(report['candidates'][0])
        b['id'] = 'candidate-b'
        set_status(b['assessments'][1], 'met', 4)
        report['candidates'].append(b)
        result = scorer.calculate(report)
        self.assertTrue(result['batch']['ordering_provisional'])
        self.assertEqual(result['batch']['ranking'][0]['candidate_id'], 'candidate-b')

    def test_band_uses_exact_score_before_half_up_display(self):
        report = example()
        report['rubric']['criteria'][0]['weight'] = Decimal('93.33')
        report['rubric']['criteria'][1]['weight'] = Decimal('6.67')
        set_status(report['candidates'][0]['assessments'][0], 'partial', 3)
        set_status(report['candidates'][0]['assessments'][1], 'unmet', 0)
        calc = scorer.calculate(report)['candidates'][0]['calculation']
        self.assertEqual(calc['documented_score'], 70)
        self.assertEqual(calc['alignment_band'], 'moderate')

    def test_exact_ranking_can_distinguish_same_displayed_score(self):
        report = example()
        report['rubric']['criteria'][0]['weight'] = Decimal('93.32')
        report['rubric']['criteria'][1]['weight'] = Decimal('6.67')
        third = copy.deepcopy(report['rubric']['criteria'][1])
        third.update(id='tiny', weight=Decimal('0.01'))
        report['rubric']['criteria'].append(third)
        a = report['candidates'][0]
        set_status(a['assessments'][0], 'partial', 3)
        set_status(a['assessments'][1], 'unmet', 0)
        tiny = copy.deepcopy(a['assessments'][1])
        tiny['criterion_id'] = 'tiny'
        a['assessments'].append(tiny)
        b = copy.deepcopy(a)
        b['id'] = 'candidate-b'
        set_status(b['assessments'][2], 'partial', 1)
        report['candidates'].append(b)
        rows = scorer.calculate(report)['batch']['ranking']
        self.assertEqual([row['documented_score'] for row in rows], [69.99, 69.99])
        self.assertEqual([row['candidate_id'] for row in rows], ['candidate-b', 'candidate-a'])
        self.assertEqual([row['rank'] for row in rows], [1, 2])

    def test_zero_score_is_valid_when_explicitly_unmet(self):
        report = example()
        for assessment in report['candidates'][0]['assessments']:
            set_status(assessment, 'unmet', 0)
        calc = scorer.calculate(report)['candidates'][0]['calculation']
        self.assertEqual(calc['score_range'], [0, 0])
        self.assertEqual(calc['coverage_percent'], 100)

    def test_no_must_haves(self):
        report = example()
        report['rubric']['criteria'][0]['importance'] = 'preferred'
        self.assertEqual(scorer.calculate(report)['candidates'][0]['calculation']['mandatory_status'], 'not_applicable')

    def test_no_known_evidence_cannot_be_ranked_even_without_must_haves(self):
        report = example()
        for criterion in report['rubric']['criteria']:
            criterion['importance'] = 'preferred'
        for assessment in report['candidates'][0]['assessments']:
            set_status(assessment, 'unknown', None)
        result = scorer.calculate(report)
        self.assertEqual(result['candidates'][0]['calculation']['score_range'], [0, 100])
        self.assertEqual(result['batch']['ranking'], [])
        self.assertEqual(result['batch']['unranked'][0]['reasons'], ['no_assessed_criteria'])

    def test_recompute_ignores_forged_derived_values(self):
        report = scorer.calculate(example())
        report['candidates'][0]['calculation'] = {'documented_score': 100, 'review_status': 'hire'}
        report['candidates'][0]['assessments'][0]['weighted_points'] = 999
        report['batch'] = {'ranking': [{'candidate_id': 'ghost', 'rank': 1}]}
        result = scorer.calculate(report)
        self.assertEqual(result['candidates'][0]['calculation']['documented_score'], 60)
        self.assertEqual(result['candidates'][0]['assessments'][0]['weighted_points'], 60)
        self.assertEqual(result['batch']['ranking'][0]['candidate_id'], 'candidate-a')

    def test_does_not_mutate_input(self):
        report = example()
        before = copy.deepcopy(report)
        scorer.calculate(report)
        self.assertEqual(report, before)


class ValidationTests(unittest.TestCase):
    def assertInvalid(self, change):
        report = example()
        change(report)
        with self.assertRaises(scorer.ReportError):
            scorer.calculate(report)

    def test_invalid_weights(self):
        for value in (True, '60', -1, 0, 101, float('nan'), float('inf'), Decimal('60.001')):
            with self.subTest(value=value):
                self.assertInvalid(lambda r: r['rubric']['criteria'][0].update(weight=value))
        self.assertInvalid(lambda r: r['rubric']['criteria'][0].update(weight=59))

    def test_missing_or_duplicate_criteria(self):
        self.assertInvalid(lambda r: r['rubric']['criteria'].append(copy.deepcopy(r['rubric']['criteria'][0])))
        self.assertInvalid(lambda r: r['candidates'][0]['assessments'].pop())
        self.assertInvalid(lambda r: r['candidates'][0]['assessments'].append(copy.deepcopy(r['candidates'][0]['assessments'][0])))
        self.assertInvalid(lambda r: r['candidates'][0]['assessments'][0].update(criterion_id='ghost'))

    def test_duplicate_candidate_id(self):
        self.assertInvalid(lambda r: r['candidates'].append(copy.deepcopy(r['candidates'][0])))

    def test_evidence_and_source_location_required(self):
        self.assertInvalid(lambda r: r['candidates'][0]['assessments'][0].update(evidence=[]))
        self.assertInvalid(lambda r: r['candidates'][0]['assessments'][0]['evidence'][0].update(location=''))
        self.assertInvalid(lambda r: r['candidates'][0]['assessments'][1].update(searched_locations=[]))
        self.assertInvalid(lambda r: r['rubric']['criteria'][0]['jd_evidence'].update(quote=''))

    def test_status_score_consistency(self):
        for status, score in (('unknown', 0), ('met', 3), ('partial', 4), ('unmet', 1), ('met', True), ('met', 4.0)):
            with self.subTest(status=status, score=score):
                self.assertInvalid(lambda r: r['candidates'][0]['assessments'][0].update(status=status, score=score))

    def test_schema_and_required_fields(self):
        self.assertInvalid(lambda r: r.update(schema_version='1.0'))
        self.assertInvalid(lambda r: r['candidates'][0].update(total_score=100))
        self.assertInvalid(lambda r: r.pop('assessment_date'))
        self.assertInvalid(lambda r: r.update(assessment_date='2026-02-30'))
        self.assertInvalid(lambda r: r['rubric']['criteria'][0]['anchors'].pop('2'))
        self.assertInvalid(lambda r: r['candidates'][0].update(extraction={'status': 'partial', 'limitations': []}))
        self.assertInvalid(lambda r: r['candidates'][0]['interview_questions'][0].update(criterion_id='ghost'))


class CLITests(unittest.TestCase):
    def run_cli(self, path, *args):
        return subprocess.run([sys.executable, str(SCRIPT), str(path), *map(str, args)], capture_output=True, text=True)

    def test_stdout_is_json_and_stderr_is_status(self):
        result = self.run_cli(ROOT / 'evals' / 'fixtures' / 'example-report.json')
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(json.loads(result.stdout)['candidates'][0]['calculation']['score_range'], [60, 100])
        self.assertIn('Validated', result.stderr)

    def test_check_does_not_write_json(self):
        result = self.run_cli(ROOT / 'evals' / 'fixtures' / 'example-report.json', '--check')
        self.assertEqual(result.returncode, 0)
        self.assertEqual(result.stdout, '')

    def test_output_preserves_existing_file_and_input(self):
        with tempfile.TemporaryDirectory() as work:
            src, dest = Path(work) / 'input.json', Path(work) / 'output.json'
            src.write_text(json.dumps(example()))
            original = src.read_bytes()
            result = self.run_cli(src, '--output', dest)
            self.assertEqual(result.returncode, 0, result.stderr)
            self.assertEqual(result.stdout, '')
            self.assertEqual(json.loads(dest.read_text())['schema_version'], '2.0')
            saved = dest.read_bytes()
            self.assertEqual(self.run_cli(src, '--output', dest).returncode, 2)
            self.assertEqual(dest.read_bytes(), saved)
            self.assertEqual(self.run_cli(src, '--output', src).returncode, 2)
            self.assertEqual(src.read_bytes(), original)

    def test_invalid_json_returns_error_without_traceback(self):
        for payload in ('{', '{"schema_version":"2.0","schema_version":"1.0"}', 'NaN', '[]'):
            with self.subTest(payload=payload), tempfile.TemporaryDirectory() as work:
                path = Path(work) / 'bad.json'
                path.write_text(payload)
                result = self.run_cli(path)
                self.assertEqual(result.returncode, 2)
                self.assertEqual(result.stdout, '')
                self.assertNotIn('Traceback', result.stderr)

    def test_decimal_input_and_rerun(self):
        with tempfile.TemporaryDirectory() as work:
            src, checked, rerun = [Path(work) / name for name in ('input.json', 'checked.json', 'rerun.json')]
            report = example()
            report['rubric']['criteria'][0]['weight'] = 60.25
            report['rubric']['criteria'][1]['weight'] = 39.75
            src.write_text(json.dumps(report))
            self.assertEqual(self.run_cli(src, '--output', checked).returncode, 0)
            self.assertEqual(self.run_cli(checked, '--output', rerun).returncode, 0)
            self.assertEqual(checked.read_bytes(), rerun.read_bytes())


if __name__ == '__main__':
    unittest.main()
