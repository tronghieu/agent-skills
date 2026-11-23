#!/bin/bash
# verify-quotes.sh <workspace-dir>
#
# Mechanical anti-hallucination check for study mode: every quoted, page-cited
# sentence in the workspace's .md notes gets checked against source.txt.
set -euo pipefail

usage() {
  echo "Usage: verify-quotes.sh <workspace-dir>" >&2
  exit 1
}

[ $# -eq 1 ] || usage
workspace="$1"
[ -d "$workspace" ] || { echo "Workspace directory not found: $workspace" >&2; exit 1; }
workspace="$(cd "$workspace" && pwd)"

[ -f "$workspace/source.txt" ] || {
  echo "source.txt not found in $workspace; cannot verify quotes without it." >&2
  exit 1
}

tmp_awk="$(mktemp)"
cleanup() { rm -f "$tmp_awk" 2>/dev/null; return 0; }
trap cleanup EXIT

cd "$workspace"

md_files=()
while IFS= read -r f; do
  md_files+=("$f")
done < <(find . -type f -name '*.md' | sed 's#^\./##' | sort)

if [ "${#md_files[@]}" -eq 0 ]; then
  echo "No markdown files found under $workspace to verify." >&2
  printf '{"checked": 0, "ok": 0, "near": 0, "fail": 0}\n'
  exit 0
fi

cat > "$tmp_awk" <<'AWK_EOF'
function fold_accents(s) {
  # French text carries accents that the ASCII normalizer below would delete
  # (it strips every byte outside [a-z0-9 -]), which silently shortens both the
  # quoted span and the page blob. Fold accented letters to their base letters
  # instead, so "café" and "cafe" compare equal and no letter is lost.
  # Each gsub uses a literal multi-byte pattern; character classes are avoided
  # because they behave differently across awk implementations.
  gsub(/à|â|ä/, "a", s)
  gsub(/À|Â|Ä/, "a", s)
  gsub(/é|è|ê|ë/, "e", s)
  gsub(/É|È|Ê|Ë/, "e", s)
  gsub(/î|ï/, "i", s)
  gsub(/Î|Ï/, "i", s)
  gsub(/ô|ö/, "o", s)
  gsub(/Ô|Ö/, "o", s)
  gsub(/ù|û|ü/, "u", s)
  gsub(/Ù|Û|Ü/, "u", s)
  gsub(/ÿ/, "y", s)
  gsub(/Ÿ/, "y", s)
  gsub(/ç/, "c", s)
  gsub(/Ç/, "c", s)
  gsub(/œ/, "oe", s)
  gsub(/Œ/, "oe", s)
  gsub(/æ/, "ae", s)
  gsub(/Æ/, "ae", s)
  return s
}

function normalize(s,    r) {
  r = fold_accents(s)
  gsub(/“/, "\"", r)
  gsub(/”/, "\"", r)
  gsub(/‘/, "'", r)
  gsub(/’/, "'", r)
  gsub(/–/, "-", r)
  gsub(/—/, "-", r)
  r = tolower(r)
  gsub(/[^a-z0-9 -]/, "", r)
  # Dashes/hyphens fold to a space (not preserved as "-"): a printed
  # "lowest-end" and a quoted "lowest end" must compare equal.
  gsub(/-+/, " ", r)
  gsub(/[[:blank:]]+/, " ", r)
  gsub(/^ +/, "", r)
  gsub(/ +$/, "", r)
  return r
}

function wordcount(s,    tmp, warr) {
  tmp = s
  gsub(/^[[:blank:]]+/, "", tmp)
  gsub(/[[:blank:]]+$/, "", tmp)
  if (tmp == "") return 0
  return split(tmp, warr, /[[:blank:]]+/)
}

function first_n_words(s, n,    c, arr, out, i, lim) {
  c = split(s, arr, /[[:blank:]]+/)
  lim = (c < n) ? c : n
  out = ""
  for (i = 1; i <= lim; i++) out = (i == 1) ? arr[i] : out " " arr[i]
  return out
}

# Extracts quoted spans (>=5 words) from a line. Curly double quotes, French
# guillemets « » and low-9 quotes „ are folded to straight quotes first, so a
# single scan handles every style; the returned text is used only for the
# human-readable preview.
function extract_quotes(line,    conv, i, start, end, span, n) {
  conv = line
  gsub(/“/, "\"", conv)
  gsub(/”/, "\"", conv)
  gsub(/«/, "\"", conv)
  gsub(/»/, "\"", conv)
  gsub(/„/, "\"", conv)
  n = 0
  i = 1
  while (1) {
    start = index(substr(conv, i), "\"")
    if (start == 0) break
    start = i + start - 1
    end = index(substr(conv, start + 1), "\"")
    if (end == 0) break
    end = start + end
    span = substr(conv, start + 1, end - start - 1)
    if (wordcount(span) >= 5) {
      n++
      found[n] = span
    }
    i = end + 1
  }
  return n
}

BEGIN {
  checked = 0; ok = 0; near = 0; fail = 0
  max_page = 0
  finalized_pages = 0
  curpage = ""
}

# --- Stage A: source.txt (first file) - build one normalized text blob per page ---
FNR == NR {
  if ($0 ~ /^\[\[page [0-9]+\]\]$/) {
    if (curpage != "") pageblob[curpage] = blob
    p = $0
    gsub(/[^0-9]/, "", p)
    curpage = p + 0
    blob = ""
  } else {
    blob = blob " " normalize($0)
  }
  next
}

# --- Transition: finalize page blobs once, on the first record of the first .md file ---
!finalized_pages {
  if (curpage != "") pageblob[curpage] = blob
  max_page = curpage + 0
  finalized_pages = 1
}

# --- Stage B: scan .md files for quote + page-citation pairs ---
# Fenced code blocks (``` or ~~~, e.g. Mermaid diagrams) are not prose and
# must never be treated as quotable/citable text. Fence state resets at the
# start of each file so an unclosed fence in one note can't swallow another.
FNR == 1 { in_fence = 0 }
$0 ~ /^[[:blank:]]*(```+|~~~+)/ { in_fence = !in_fence; next }
in_fence { next }

{
  line = $0
  # Page citation marker. The range separator accepts the ASCII hyphen plus the
  # typographic en dash (U+2013) and em dash (U+2014): French documents usually
  # print ranges as (pp. 12–15). The dashes are spelled out as alternatives, not
  # as a bracket class: they are multi-byte sequences, and mawk matches a class
  # byte by byte, so [-–—] would never match a whole dash.
  if (!match(line, /\((pp?|tr)\.[[:blank:]]*[0-9]+((-|–|—)[0-9]+)?\)/)) next

  cit = substr(line, RSTART, RLENGTH)
  inner = substr(cit, 2, length(cit) - 2)

  if (substr(inner, 1, 2) == "pp") {
    prefix = "pp."
    rest = inner
    sub(/^pp\.[[:blank:]]*/, "", rest)
  } else if (substr(inner, 1, 2) == "tr") {
    prefix = "tr."
    rest = inner
    sub(/^tr\.[[:blank:]]*/, "", rest)
  } else {
    prefix = "p."
    rest = inner
    sub(/^p\.[[:blank:]]*/, "", rest)
  }

  # Fold a typographic dash to the ASCII hyphen before splitting the range, for
  # the same multi-byte reason as the marker match above.
  gsub(/–|—/, "-", rest)
  if (rest ~ /-/) {
    split(rest, rg, "-")
    lo_exact = rg[1] + 0; hi_exact = rg[2] + 0
  } else {
    lo_exact = rest + 0; hi_exact = rest + 0
  }
  lo_win = lo_exact - 1; hi_win = hi_exact + 1
  if (lo_win < 1) lo_win = 1
  if (hi_win > max_page) hi_win = max_page
  if (lo_exact < 1) lo_exact = 1
  if (hi_exact > max_page) hi_exact = max_page

  citation_display = prefix rest

  nq = extract_quotes(line)
  for (qi = 1; qi <= nq; qi++) {
    quote = found[qi]
    norm_q = normalize(quote)
    if (norm_q == "") continue

    exact_blob = ""
    for (pg = lo_exact; pg <= hi_exact; pg++) exact_blob = exact_blob " " pageblob[pg]
    win_blob = ""
    for (pg = lo_win; pg <= hi_win; pg++) win_blob = win_blob " " pageblob[pg]

    checked++
    status = "FAIL"
    if (index(exact_blob, norm_q) > 0) status = "OK"
    else if (index(win_blob, norm_q) > 0) status = "NEAR"

    if (status == "OK") ok++
    else if (status == "NEAR") near++
    else fail++

    printf "%s\t%s:%d\t%s\t%s...\n", status, FILENAME, FNR, citation_display, first_n_words(quote, 8)
  }
}

END {
  printf "{\"checked\": %d, \"ok\": %d, \"near\": %d, \"fail\": %d}\n", checked, ok, near, fail
  if (fail > 0) exit 1
  exit 0
}
AWK_EOF

awk -f "$tmp_awk" source.txt "${md_files[@]}"
