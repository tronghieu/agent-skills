#!/usr/bin/env python3
"""Validate v2 CV evidence reports and calculate scores using only the stdlib."""

import argparse
import copy
from datetime import date
from decimal import Decimal, ROUND_HALF_UP
import json
from pathlib import Path
import sys


class ReportError(ValueError):
    """Invalid report input."""


def require(condition, message):
    if not condition:
        raise ReportError(message)


def fields(value, required, path, optional=()):
    require(isinstance(value, dict), f"{path}: expected object")
    missing = set(required) - value.keys()
    extra = value.keys() - set(required) - set(optional)
    require(not missing, f"{path}: missing fields {sorted(missing)}")
    require(not extra, f"{path}: unknown fields {sorted(extra)}")


def string(value, path):
    require(isinstance(value, str) and bool(value.strip()), f"{path}: expected nonempty string")


def array(value, path, nonempty=False):
    require(isinstance(value, list), f"{path}: expected array")
    require(not nonempty or bool(value), f"{path}: must not be empty")


def strings(value, path):
    array(value, path)
    for item in value:
        string(item, path)


def quote(value, path):
    fields(value, ("quote", "location"), path)
    for key in ("quote", "location"):
        string(value[key], f"{path}.{key}")


def weight(value, path):
    require(isinstance(value, (int, float, Decimal)) and not isinstance(value, bool),
            f"{path}: expected number")
    number = Decimal(str(value))
    require(number.is_finite() and 0 < number <= 100, f"{path}: must be finite and in (0, 100]")
    require(number == number.quantize(Decimal("0.01")), f"{path}: at most two decimal places")
    return number


def displayed(value):
    return float(value.quantize(Decimal("0.01"), rounding=ROUND_HALF_UP))


def validate(report):
    fields(report, ("schema_version", "assessment_date", "rubric", "candidates"),
           "report", ("batch",))
    require(report["schema_version"] == "2.0", "report.schema_version: expected '2.0'; v1 is not supported")
    string(report["assessment_date"], "assessment_date")
    try:
        require(date.fromisoformat(report["assessment_date"]).isoformat() == report["assessment_date"],
                "assessment_date: use YYYY-MM-DD")
    except ValueError as exc:
        raise ReportError("assessment_date: invalid ISO date") from exc
    rubric = report["rubric"]
    fields(rubric, ("id", "version", "job_title", "source", "assumptions", "criteria"), "rubric")
    for key in ("id", "version", "job_title", "source"):
        string(rubric[key], f"rubric.{key}")
    strings(rubric["assumptions"], "rubric.assumptions")
    array(rubric["criteria"], "rubric.criteria", nonempty=True)
    criteria = {}
    weights = {}
    for item in rubric["criteria"]:
        fields(item, ("id", "description", "importance", "weight", "jd_evidence", "anchors"), "criterion")
        for key in ("id", "description"):
            string(item[key], f"criterion.{key}")
        key = item["id"]
        require(key not in criteria, f"duplicate criterion ID: {key}")
        require(item["importance"] in ("must_have", "preferred"), f"{key}: invalid importance")
        quote(item["jd_evidence"], f"{key}.jd_evidence")
        fields(item["anchors"], ("0", "1", "2", "3", "4"), f"{key}.anchors")
        for anchor in item["anchors"].values():
            string(anchor, f"{key}.anchors")
        weights[key] = weight(item["weight"], f"{key}.weight")
        criteria[key] = item
    require(sum(weights.values()) == 100, "criterion weights must sum to exactly 100")
    array(report["candidates"], "candidates", nonempty=True)
    ids = set()
    for candidate in report["candidates"]:
        fields(candidate, ("id", "name", "source", "extraction", "assessments", "summary",
                           "highlights", "verification_items", "interview_questions"),
               "candidate", ("calculation",))
        for key in ("id", "name", "source", "summary"):
            string(candidate[key], f"candidate.{key}")
        cid = candidate["id"]
        require(cid not in ids, f"duplicate candidate ID: {cid}")
        ids.add(cid)
        strings(candidate["highlights"], f"{cid}.highlights")
        extraction = candidate["extraction"]
        fields(extraction, ("status", "limitations"), f"{cid}.extraction")
        require(extraction["status"] in ("readable", "partial", "unreadable"), f"{cid}: invalid extraction status")
        strings(extraction["limitations"], f"{cid}.limitations")
        require(extraction["status"] == "readable" or bool(extraction["limitations"]),
                f"{cid}: incomplete extraction needs a limitation")
        array(candidate["assessments"], f"{cid}.assessments")
        seen = set()
        for assessment in candidate["assessments"]:
            fields(assessment, ("criterion_id", "status", "score", "evidence", "searched_locations",
                                "rationale", "contradiction"), f"{cid}.assessment", ("weighted_points",))
            key = assessment["criterion_id"]
            string(key, f"{cid}.criterion_id")
            require(key in criteria, f"{cid}: unknown criterion ID: {key}")
            require(key not in seen, f"{cid}: duplicate assessment: {key}")
            seen.add(key)
            status, score = assessment["status"], assessment["score"]
            require(status in ("met", "partial", "unmet", "unknown"), f"{cid}/{key}: invalid status")
            if status == "unknown":
                require(score is None, f"{cid}/{key}: unknown score must be null")
            else:
                require(type(score) is int, f"{cid}/{key}: score must be an integer")
                allowed = {"met": (4,), "partial": (1, 2, 3), "unmet": (0,)}
                require(score in allowed[status], f"{cid}/{key}: score does not match status")
            array(assessment["evidence"], f"{cid}/{key}.evidence")
            for item in assessment["evidence"]:
                quote(item, f"{cid}/{key}.evidence")
            strings(assessment["searched_locations"], f"{cid}/{key}.searched_locations")
            string(assessment["rationale"], f"{cid}/{key}.rationale")
            require(type(assessment["contradiction"]) is bool, f"{cid}/{key}: contradiction must be boolean")
            require(status == "unknown" or bool(assessment["evidence"]), f"{cid}/{key}: known status needs evidence")
            require(status != "unknown" or bool(assessment["searched_locations"]), f"{cid}/{key}: unknown needs searched locations")
            if assessment["contradiction"]:
                require(status == "unknown" and len(assessment["evidence"]) >= 2,
                        f"{cid}/{key}: contradiction needs unknown status and at least two quotes")
        require(seen == criteria.keys(), f"{cid}: assessments must cover every rubric criterion")
        for list_key, keys in (("verification_items", ("criterion_id", "issue", "question")),
                               ("interview_questions", ("criterion_id", "question"))):
            array(candidate[list_key], f"{cid}.{list_key}")
            for item in candidate[list_key]:
                fields(item, keys, f"{cid}.{list_key}")
                for key in keys:
                    string(item[key], f"{cid}.{list_key}.{key}")
                require(item["criterion_id"] in criteria, f"{cid}.{list_key}: unknown criterion ID")
    return criteria, weights


def calculate(report):
    """Return a checked copy; never trust caller-supplied derived fields."""
    criteria, weights = validate(report)
    result = copy.deepcopy(report)
    exact_scores = {}
    exact_ranges = {}
    eligible = []
    unranked = []
    for candidate in result["candidates"]:
        cid = candidate["id"]
        total, unknown_weight = Decimal(0), Decimal(0)
        unmet, unknown = [], []
        contradiction = False
        for item in candidate["assessments"]:
            key, status = item["criterion_id"], item["status"]
            if status == "unknown":
                unknown_weight += weights[key]
                item["weighted_points"] = None
            else:
                points = weights[key] * item["score"] / 4
                total += points
                item["weighted_points"] = displayed(points)
            if criteria[key]["importance"] == "must_have":
                if status == "unknown":
                    unknown.append(key)
                elif status != "met":
                    unmet.append(key)
            contradiction = contradiction or item["contradiction"]
        mandatory = "not_applicable"
        if any(c["importance"] == "must_have" for c in criteria.values()):
            mandatory = "unmet" if unmet else "unknown" if unknown else "met"
        readable = candidate["extraction"]["status"] == "readable"
        review = ("insufficient_input" if not readable else "criteria_review" if unmet else
                  "needs_verification" if unknown_weight else "ready_for_human_review")
        reasons = []
        if not readable:
            reasons.append("incomplete_extraction")
        if unknown:
            reasons.append("unknown_must_haves")
        if contradiction:
            reasons.append("contradictory_evidence")
        if unknown_weight == 100:
            reasons.append("no_assessed_criteria")
        possible = total + unknown_weight
        calculation = {
            "documented_score": displayed(total) if readable else None,
            "possible_score": displayed(possible) if readable else None,
            "coverage_percent": displayed(100 - unknown_weight) if readable else None,
            "score_range": [displayed(total), displayed(possible)] if readable else None,
            "alignment_band": ("high" if total >= 70 else "moderate" if total >= 50 else "limited") if readable else None,
            "mandatory_status": mandatory,
            "unmet_must_haves": sorted(unmet),
            "unknown_must_haves": sorted(unknown),
            "review_status": review,
            "rank_eligible": not reasons,
            "unranked_reasons": reasons,
        }
        candidate["calculation"] = calculation
        if reasons:
            unranked.append({"candidate_id": cid, "reasons": reasons})
        else:
            exact_scores[cid] = total
            exact_ranges[cid] = (total, possible)
            eligible.append(candidate)
    eligible.sort(key=lambda c: (-exact_scores[c["id"]], c["id"]))
    ranking = []
    last_score, rank = None, 0
    for index, candidate in enumerate(eligible, 1):
        cid, calc = candidate["id"], candidate["calculation"]
        if exact_scores[cid] != last_score:
            rank = index
        last_score = exact_scores[cid]
        ranking.append({"rank": rank, "candidate_id": cid, **{key: calc[key] for key in
                        ("documented_score", "score_range", "mandatory_status", "review_status")}})
    provisional = bool(unranked)
    for index, candidate in enumerate(eligible):
        a, b = exact_ranges[candidate["id"]]
        for other in eligible[index + 1:]:
            c, d = exact_ranges[other["id"]]
            if (a != b or c != d) and max(a, c) <= min(b, d):
                provisional = True
    result["batch"] = {"ordering_provisional": provisional, "ranking": ranking,
                       "unranked": sorted(unranked, key=lambda c: c["candidate_id"])}
    return result


def unique_object(pairs):
    result = {}
    for key, value in pairs:
        require(key not in result, f"duplicate JSON key: {key}")
        result[key] = value
    return result


def reject_constant(value):
    raise ReportError(f"non-finite JSON number: {value}")


def json_ready(value):
    if isinstance(value, Decimal):
        return float(value)
    if isinstance(value, list):
        return [json_ready(item) for item in value]
    if isinstance(value, dict):
        return {key: json_ready(item) for key, item in value.items()}
    return value


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("input", type=Path, help="UTF-8 v2 JSON report")
    mode = parser.add_mutually_exclusive_group()
    mode.add_argument("--output", type=Path, help="write JSON to a new file instead of stdout")
    mode.add_argument("--check", action="store_true", help="validate and calculate without emitting JSON")
    args = parser.parse_args(argv)
    try:
        raw = json.loads(args.input.read_text(encoding="utf-8"), parse_float=Decimal,
                         parse_constant=reject_constant, object_pairs_hook=unique_object)
        result = calculate(raw)
        if not args.check:
            payload = json.dumps(json_ready(result), ensure_ascii=False, indent=2, allow_nan=False) + "\n"
            if args.output:
                with args.output.open("x", encoding="utf-8") as handle:
                    handle.write(payload)
            else:
                sys.stdout.write(payload)
        print(f"Validated {len(result['candidates'])} candidate(s); rubric {result['rubric']['id']} v{result['rubric']['version']}.", file=sys.stderr)
        return 0
    except (OSError, ValueError, ArithmeticError) as exc:
        print(f"Invalid report: {exc}", file=sys.stderr)
        return 2


if __name__ == "__main__":
    sys.exit(main())
