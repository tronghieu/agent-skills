#!/bin/bash
# self-test.sh
#
# Self-contained regression suite for the deep-reader scripts. Generates its
# own synthetic fixture in a temp workspace, runs every script through its
# documented behavior (including the two bugs found during development), and
# reports PASS/FAIL/SKIP. Doubles as an install doctor: it reports whether
# the optional pdftotext/pandoc dependencies are present before running.
#
# Usage: bash ./scripts/self-test.sh   (no arguments; nothing outside the
# temp workspace is read or written)
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

WORKDIR="$(mktemp -d)"
cleanup() { rm -rf "${WORKDIR:-}" 2>/dev/null; return 0; }
trap cleanup EXIT

PASS_COUNT=0
FAIL_COUNT=0
SKIP_COUNT=0

pass() { PASS_COUNT=$((PASS_COUNT + 1)); printf 'PASS  %s\n' "$1"; }
fail() { FAIL_COUNT=$((FAIL_COUNT + 1)); printf 'FAIL  %s -- %s\n' "$1" "${2:-}"; }
skip() { SKIP_COUNT=$((SKIP_COUNT + 1)); printf 'SKIP  %s -- %s\n' "$1" "${2:-}"; }

# --- runcap: runs a command without letting `set -e` abort this script on a
# non-zero exit (many checks below deliberately expect failure). Captures
# stdout/stderr to fixed files and the exit code into LAST_EXIT. ---
LAST_EXIT=0
LAST_STDOUT="$WORKDIR/.last.out"
LAST_STDERR="$WORKDIR/.last.err"
runcap() {
  set +e
  "$@" >"$LAST_STDOUT" 2>"$LAST_STDERR"
  LAST_EXIT=$?
  set -e
  return 0
}

expect_exit() {
  local name="$1" expected="$2"
  if [ "$LAST_EXIT" -eq "$expected" ]; then
    pass "$name"
  else
    fail "$name" "expected exit $expected, got $LAST_EXIT (stderr: $(head -c 200 "$LAST_STDERR" | tr '\n' ' '))"
  fi
}

expect_stdout_has() {
  local name="$1" needle="$2"
  if grep -qF -- "$needle" "$LAST_STDOUT" 2>/dev/null; then
    pass "$name"
  else
    fail "$name" "stdout did not contain: $needle"
  fi
}

expect_stderr_has() {
  local name="$1" needle="$2"
  if grep -qF -- "$needle" "$LAST_STDERR" 2>/dev/null; then
    pass "$name"
  else
    fail "$name" "stderr did not contain: $needle"
  fi
}

expect_stdout_count() {
  local name="$1" pattern="$2" expected="$3" actual
  actual=$(grep -Ec -- "$pattern" "$LAST_STDOUT" 2>/dev/null || true)
  if [ "$actual" -eq "$expected" ]; then
    pass "$name"
  else
    fail "$name" "expected $expected match(es) of /$pattern/, got $actual"
  fi
}

expect_json_num_gt() {
  local name="$1" file="$2" key="$3" threshold="$4" val
  val=$(grep -o "\"$key\"[[:blank:]]*:[[:blank:]]*[0-9][0-9]*" "$file" | head -1 | grep -o '[0-9]*$' || true)
  if [ -n "$val" ] && [ "$val" -gt "$threshold" ]; then
    pass "$name"
  else
    fail "$name" "$key=${val:-<missing>}, expected > $threshold"
  fi
}

expect_json_field() {
  local name="$1" file="$2" key="$3" expected="$4" val
  val=$(grep -o "\"$key\"[[:blank:]]*:[[:blank:]]*\"\{0,1\}[A-Za-z0-9_-]*" "$file" | head -1 | sed -E 's/.*:[[:blank:]]*"?//')
  if [ "$val" = "$expected" ]; then
    pass "$name"
  else
    fail "$name" "$key=${val:-<missing>}, expected $expected"
  fi
}

# =====================================================================
# Header: report bash/awk/optional-dependency status (install doctor)
# =====================================================================
echo "== deep-reader self-test =="
echo "bash: $(bash --version | head -1)"
echo "awk:  $(awk --version 2>&1 | head -1 || awk -W version 2>&1 | head -1 || echo unknown)"
HAVE_PDFTOTEXT=false
HAVE_PANDOC=false
if command -v pdftotext >/dev/null 2>&1; then
  HAVE_PDFTOTEXT=true
  echo "pdftotext: present ($(command -v pdftotext))"
else
  echo "pdftotext: MISSING (install: brew install poppler | apt-get install poppler-utils) -- PDF branch will be exercised via its exit-2 fallback only"
fi
if command -v pandoc >/dev/null 2>&1; then
  HAVE_PANDOC=true
  echo "pandoc: present ($(command -v pandoc))"
else
  echo "pandoc: MISSING (install: brew install pandoc | apt-get install pandoc) -- EPUB/DOCX branch will be exercised via its exit-2 fallback only"
fi
echo "workspace: $WORKDIR"
echo "============================"
echo

# =====================================================================
# Fixture: synthetic ~10k-word, 6-chapter book with a planted quote
# =====================================================================
TITLE1="The Activity of Reading"
TITLE2="The Levels of Reading"
TITLE3="Inspectional Reading"
TITLE4="Analytical Reading"
TITLE5="Coming to Terms with an Author"
TITLE6="Criticizing a Book Fairly"
TITLES_JOINED="$TITLE1|$TITLE2|$TITLE3|$TITLE4|$TITLE5|$TITLE6"

PLANTED_QUOTE="The art of reading is the art of getting more out of a book with less effort than any other reader thought possible"
PLANTED_HYPHEN_QUOTE="This book explores the lowest-end of the value-add spectrum for careful readers everywhere"

BOOK_TXT="$WORKDIR/sample-book.txt"
awk -v titles_str="$TITLES_JOINED" -v planted="$PLANTED_QUOTE" -v planted_hyphen="$PLANTED_HYPHEN_QUOTE" '
BEGIN {
  srand(1)
  npool = split("the quick brown fox jumps over lazy dog reading books attention memory cognition philosophy science history language culture argument evidence proposition claim theory method structure analysis synthesis understanding knowledge wisdom truth author reader text chapter section paragraph word idea concept term meaning context narrative plot character scene setting", pool, " ")
  ntitles = split(titles_str, titles, "|")

  print "THE ART OF DEEP READING"
  print "A Study in Method"
  print ""
  print "PREFACE"
  print ""
  paragraph(100)
  print "CONTENTS"
  print ""
  for (c = 1; c <= ntitles; c++) print "Chapter " c ". " titles[c]
  print ""

  for (c = 1; c <= ntitles; c++) {
    print "Chapter " c
    print titles[c]
    print ""
    for (p = 1; p <= 12; p++) paragraph(140)
    if (c == 2) { print planted "."; print ""; print planted_hyphen "."; print "" }
  }

  print "CONCLUSION"
  print ""
  paragraph(120)
  print "APPENDIX A"
  print ""
  paragraph(60)
  print "BIBLIOGRAPHY"
  print ""
  paragraph(40)
  print "INDEX"
  print ""
  paragraph(30)
}
function randword() { return pool[int(rand() * npool) + 1] }
function paragraph(n,    i, s) {
  s = ""
  for (i = 1; i <= n; i++) s = (i == 1) ? randword() : s " " randword()
  s = toupper(substr(s, 1, 1)) substr(s, 2) "."
  print s
  print ""
}
' > "$BOOK_TXT"

word_count=$(wc -w < "$BOOK_TXT" | tr -d ' ')
echo "fixture: $word_count words, 6 chapters, planted quote in chapter 2"
echo

# =====================================================================
# 1. prepare-text.sh
# =====================================================================
runcap "$SCRIPT_DIR/prepare-text.sh" "$BOOK_TXT" "$WORKDIR/book-notes"
expect_exit "prepare-text: fresh conversion succeeds (regression: EXIT trap must not swallow exit status)" 0
cp "$LAST_STDOUT" "$WORKDIR/.prep1.json"
expect_json_field "prepare-text: fresh run reports format=txt" "$WORKDIR/.prep1.json" "format" "txt"
expect_json_field "prepare-text: fresh run reports synthetic_pages=true" "$WORKDIR/.prep1.json" "synthetic_pages" "true"
expect_json_field "prepare-text: fresh run reports existing=false" "$WORKDIR/.prep1.json" "existing" "false"
expect_json_num_gt "prepare-text: fresh run reports pages > 1" "$WORKDIR/.prep1.json" "pages" 1

runcap "$SCRIPT_DIR/prepare-text.sh" "$BOOK_TXT" "$WORKDIR/book-notes"
expect_exit "prepare-text: idempotent re-run succeeds" 0
expect_json_field "prepare-text: idempotent re-run reports existing=true" "$LAST_STDOUT" "existing" "true"

WORKSPACE="$WORKDIR/book-notes"
SOURCE_TXT="$WORKSPACE/source.txt"
max_page=$(grep -Ec '^\[\[page [0-9]+\]\]$' "$SOURCE_TXT")

# --- Regression: word-granularity synthetic pagination ---
# pandoc --wrap=none (and plain unwrapped text) can put an entire multi-
# thousand-word paragraph on one line; the old line-granularity pager never
# split such a line into multiple pages.
LONGLINE_TXT="$WORKDIR/longline.txt"
awk 'BEGIN { s=""; for (i=1;i<=3000;i++) s = (i==1) ? "word" : (s " word"); print s }' > "$LONGLINE_TXT"
runcap "$SCRIPT_DIR/prepare-text.sh" "$LONGLINE_TXT" "$WORKDIR/longline-notes"
expect_exit "prepare-text: long-single-line fixture converts (txt branch)" 0
expect_json_num_gt "prepare-text: unwrapped 3000-word single line splits into multiple pages (regression: word-granularity pagination, txt branch)" "$LAST_STDOUT" "pages" 1

if [ "$HAVE_PANDOC" = true ]; then
  LONGLINE_MD="$WORKDIR/longline.md"
  awk 'BEGIN { print "# Test"; print ""; s=""; for (i=1;i<=3000;i++) s = (i==1) ? "word" : (s " word"); print s }' > "$LONGLINE_MD"
  if pandoc "$LONGLINE_MD" -o "$WORKDIR/longline.epub" >/dev/null 2>&1; then
    runcap "$SCRIPT_DIR/prepare-text.sh" "$WORKDIR/longline.epub" "$WORKDIR/longline-epub-notes"
    expect_exit "prepare-text: long-single-line epub fixture converts (epub branch)" 0
    expect_json_num_gt "prepare-text: unwrapped 3000-word single line splits into multiple pages (regression: word-granularity pagination, epub branch)" "$LAST_STDOUT" "pages" 1
  else
    skip "prepare-text: epub word-granularity regression" "pandoc could not build the test fixture"
  fi
else
  skip "prepare-text: epub word-granularity regression" "pandoc not installed"
fi

# --- PDF branch ---
if [ "$HAVE_PDFTOTEXT" = true ]; then
  # Hand-build a minimal valid multi-page PDF (no external tools needed
  # beyond bash/printf) so the real conversion path gets exercised.
  gen_pdf() {
    local out="$1"; shift
    local pages=("$@")
    local npages=${#pages[@]}
    : > "$out"
    printf '%%PDF-1.4\n' >> "$out"
    local offsets=() kids="" i
    for ((i = 0; i < npages; i++)); do kids="$kids $((3 + i * 2)) 0 R"; done
    offsets[1]=$(wc -c < "$out")
    printf '1 0 obj << /Type /Catalog /Pages 2 0 R >> endobj\n' >> "$out"
    offsets[2]=$(wc -c < "$out")
    printf '2 0 obj << /Type /Pages /Kids [%s] /Count %d >> endobj\n' "$kids" "$npages" >> "$out"
    for ((i = 0; i < npages; i++)); do
      local pageobj=$((3 + i * 2)) contobj=$((4 + i * 2))
      offsets[pageobj]=$(wc -c < "$out")
      printf '%d 0 obj << /Type /Page /Parent 2 0 R /MediaBox [0 0 300 300] /Contents %d 0 R /Resources << /Font << /F1 %d 0 R >> >> >> endobj\n' \
        "$pageobj" "$contobj" "$((3 + npages * 2))" >> "$out"
      local text="${pages[$i]}" stream slen
      stream="BT /F1 12 Tf 20 150 Td (${text}) Tj ET"
      slen=${#stream}
      offsets[contobj]=$(wc -c < "$out")
      printf '%d 0 obj << /Length %d >>\nstream\n%s\nendstream\nendobj\n' "$contobj" "$slen" "$stream" >> "$out"
    done
    local fontobj=$((3 + npages * 2))
    offsets[fontobj]=$(wc -c < "$out")
    printf '%d 0 obj << /Type /Font /Subtype /Type1 /BaseFont /Helvetica >> endobj\n' "$fontobj" >> "$out"
    local nobjs=$fontobj xref_offset
    xref_offset=$(wc -c < "$out")
    printf 'xref\n0 %d\n' "$((nobjs + 1))" >> "$out"
    printf '0000000000 65535 f \n' >> "$out"
    for ((i = 1; i <= nobjs; i++)); do printf '%010d 00000 n \n' "${offsets[$i]}" >> "$out"; done
    printf 'trailer << /Size %d /Root 1 0 R >>\nstartxref\n%d\n%%%%EOF\n' "$((nobjs + 1))" "$xref_offset" >> "$out"
  }
  gen_pdf "$WORKDIR/sample.pdf" "Page one text" "Page two text" "Page three text"
  runcap "$SCRIPT_DIR/prepare-text.sh" "$WORKDIR/sample.pdf" "$WORKDIR/pdf-notes"
  expect_exit "prepare-text: PDF conversion succeeds" 0
  expect_json_field "prepare-text: PDF conversion reports synthetic_pages=false" "$LAST_STDOUT" "synthetic_pages" "false"
  expect_json_field "prepare-text: PDF conversion reports pages=3" "$LAST_STDOUT" "pages" "3"
else
  skip "prepare-text: PDF conversion" "pdftotext not installed"
  # Negative path is exactly what a user without poppler will see.
  : > "$WORKDIR/fake.pdf"
  runcap "$SCRIPT_DIR/prepare-text.sh" "$WORKDIR/fake.pdf" "$WORKDIR/fake-pdf-notes"
  expect_exit "prepare-text: missing pdftotext gives exit 2 with install hint" 2
  expect_stderr_has "prepare-text: missing pdftotext stderr mentions install hint" "brew install poppler"
fi

if [ "$HAVE_PANDOC" = false ]; then
  : > "$WORKDIR/fake.epub"
  runcap "$SCRIPT_DIR/prepare-text.sh" "$WORKDIR/fake.epub" "$WORKDIR/fake-epub-notes"
  expect_exit "prepare-text: missing pandoc gives exit 2 with install hint" 2
  expect_stderr_has "prepare-text: missing pandoc stderr mentions install hint" "brew install pandoc"
fi

echo

# =====================================================================
# 2. extract-structure.sh
# =====================================================================
runcap "$SCRIPT_DIR/extract-structure.sh" "$SOURCE_TXT"
expect_exit "extract-structure: runs successfully" 0
EXTRACT_OUT="$WORKDIR/.extract.out"
cp "$LAST_STDOUT" "$EXTRACT_OUT"
expect_stdout_count "extract-structure: finds all 6 bare 'Chapter N' headings" '^- \[p\. [0-9]+\] Chapter [0-9]+$' 6
expect_stdout_has "extract-structure: finds PREFACE" "PREFACE"
expect_stdout_has "extract-structure: finds CONCLUSION" "CONCLUSION"
echo

# =====================================================================
# 3. read-pages.sh
# =====================================================================
runcap "$SCRIPT_DIR/read-pages.sh" "$SOURCE_TXT" 2
expect_exit "read-pages: single page succeeds" 0
expect_stdout_has "read-pages: single page includes its marker" "[[page 2]]"

runcap "$SCRIPT_DIR/read-pages.sh" "$SOURCE_TXT" 2 3
expect_exit "read-pages: page range succeeds" 0
expect_stdout_count "read-pages: page range includes both markers" '^\[\[page (2|3)\]\]$' 2

runcap "$SCRIPT_DIR/read-pages.sh" "$SOURCE_TXT" $((max_page + 50))
expect_exit "read-pages: out-of-range page gives exit 1" 1
expect_stderr_has "read-pages: out-of-range stderr shows valid range" "valid range is 1-$max_page"

runcap "$SCRIPT_DIR/read-pages.sh" "$SOURCE_TXT" 10 5
expect_exit "read-pages: from>to gives exit 1" 1

runcap "$SCRIPT_DIR/read-pages.sh" "$SOURCE_TXT" abc
expect_exit "read-pages: non-numeric from gives exit 1" 1
echo

# =====================================================================
# 4. search-book.sh
# =====================================================================
runcap "$SCRIPT_DIR/search-book.sh" "$SOURCE_TXT" "art of reading"
expect_exit "search-book: matching pattern succeeds" 0
expect_stdout_has "search-book: match is prefixed with its page" "art of reading"

runcap "$SCRIPT_DIR/search-book.sh" "$SOURCE_TXT" "zz_definitely_not_present_zz"
expect_exit "search-book: no-match pattern gives exit 1" 1
expect_stderr_has "search-book: no-match stderr says no matches" "no matches"

runcap "$SCRIPT_DIR/search-book.sh" "$SOURCE_TXT" "^Chapter 3$" 1
expect_exit "search-book: context lines succeeds" 0
expect_stdout_count "search-book: context prints 3 lines (1 before, match, 1 after)" '^p\.' 3

TRUNC_FIXTURE="$WORKDIR/truncate-fixture.txt"
{
  echo "[[page 1]]"
  i=1
  while [ "$i" -le 250 ]; do
    echo "line number $i has the word needle in it"
    i=$((i + 1))
  done
} > "$TRUNC_FIXTURE"
runcap "$SCRIPT_DIR/search-book.sh" "$TRUNC_FIXTURE" "needle"
expect_exit "search-book: >200 matches still exits 0" 0
expect_stdout_count "search-book: >200 matches truncated to exactly 200 lines" '.' 200
expect_stderr_has "search-book: >200 matches prints narrowing note" "narrow the pattern"
echo

# =====================================================================
# 4b. split-chapters.sh + build-diagram.sh
# =====================================================================
# Derive chapters.tsv from the extract-structure seed, mirroring the real
# inspectional-pass workflow, rather than hardcoding page numbers.
CH_PAGES=()
CH_NUMS=()
while IFS= read -r ln; do
  pg=$(printf '%s' "$ln" | sed -E 's/^- \[p\. ([0-9]+)\].*/\1/')
  num=$(printf '%s' "$ln" | sed -E 's/.*Chapter ([0-9]+)$/\1/')
  CH_PAGES+=("$pg")
  CH_NUMS+=("$num")
done < <(grep -E '^- \[p\. [0-9]+\] Chapter [0-9]+$' "$EXTRACT_OUT")

TITLES=("$TITLE1" "$TITLE2" "$TITLE3" "$TITLE4" "$TITLE5" "$TITLE6")
CHAPTERS_TSV="$WORKSPACE/chapters.tsv"
: > "$CHAPTERS_TSV"
nch=${#CH_PAGES[@]}
for ((i = 0; i < nch; i++)); do
  from="${CH_PAGES[$i]}"
  if [ $((i + 1)) -lt "$nch" ]; then
    to=$((CH_PAGES[i + 1] - 1))
  else
    to="$max_page"
  fi
  printf 'ch%02d\t%s\t%s\t%s\n' "$((i + 1))" "$from" "$to" "${TITLES[$i]}" >> "$CHAPTERS_TSV"
done

runcap "$SCRIPT_DIR/split-chapters.sh" "$SOURCE_TXT" "$CHAPTERS_TSV"
expect_exit "split-chapters: splits successfully" 0
nfiles=$(ls "$WORKSPACE/chapters" 2>/dev/null | wc -l | tr -d ' ')
if [ "$nfiles" -eq 6 ]; then pass "split-chapters: produces 6 chapter files"; else fail "split-chapters: produces 6 chapter files" "got $nfiles"; fi

runcap "$SCRIPT_DIR/split-chapters.sh" "$SOURCE_TXT" "$CHAPTERS_TSV"
expect_exit "split-chapters: re-run (idempotent) still exits 0" 0
nfiles2=$(ls "$WORKSPACE/chapters" 2>/dev/null | wc -l | tr -d ' ')
if [ "$nfiles2" -eq 6 ]; then pass "split-chapters: re-run does not duplicate files"; else fail "split-chapters: re-run does not duplicate files" "got $nfiles2"; fi

runcap "$SCRIPT_DIR/build-diagram.sh" "$WORKSPACE"
expect_exit "build-diagram: flat mode succeeds" 0
expect_stdout_has "build-diagram: flat mode emits a mermaid mindmap" "mindmap"
expect_stdout_count "build-diagram: flat mode lists all 6 chapters" 'ch0[1-6]:' 6

printf '# The Art of Deep Reading\n\nIntro.\n' > "$WORKSPACE/map.md"
runcap "$SCRIPT_DIR/build-diagram.sh" "$WORKSPACE" --append
expect_exit "build-diagram: --append (1st) succeeds" 0
runcap "$SCRIPT_DIR/build-diagram.sh" "$WORKSPACE" --append
expect_exit "build-diagram: --append (2nd) succeeds" 0
starts=$(grep -c '<!-- diagram:start -->' "$WORKSPACE/map.md")
if [ "$starts" -eq 1 ]; then pass "build-diagram: --append is idempotent (exactly one block survives)"; else fail "build-diagram: --append is idempotent (exactly one block survives)" "found $starts start markers"; fi

# Nested Part-row mode, in an isolated mini-workspace.
NESTED_WS="$WORKDIR/nested-ws"
mkdir -p "$NESTED_WS"
cat > "$NESTED_WS/chapters.tsv" << 'EOF'
p1	1	8	Part I: Foundations
ch01	1	4	The Activity of Reading
ch02	5	8	The Levels of Reading
EOF
runcap "$SCRIPT_DIR/build-diagram.sh" "$NESTED_WS"
expect_exit "build-diagram: nested (Part-row) mode succeeds" 0
expect_stdout_has "build-diagram: nested mode indents chapters under their Part" '    "ch01:'

EMPTY_WS="$WORKDIR/empty-ws"
mkdir -p "$EMPTY_WS"
runcap "$SCRIPT_DIR/build-diagram.sh" "$EMPTY_WS"
expect_exit "build-diagram: missing chapters.tsv gives exit 1 with hint" 1
expect_stderr_has "build-diagram: missing chapters.tsv stderr names the file" "chapters.tsv"
echo

# =====================================================================
# 5. verify-quotes.sh
# =====================================================================
mkdir -p "$WORKSPACE/notes"
true_page=$(awk -v pat="$PLANTED_QUOTE" '
  index($0, pat) > 0 { print page; f=1; exit }
  /^\[\[page [0-9]+\]\]$/ { p=$0; gsub(/[^0-9]/,"",p); page=p+0 }
  END { if (!f) print "" }
' "$SOURCE_TXT")

if [ -z "$true_page" ]; then
  fail "verify-quotes: could not locate planted quote's page" "fixture generation problem"
else
  wrong_page=$((true_page > 5 ? true_page - 5 : true_page + 5))

  cat > "$WORKSPACE/notes/verify-basic.md" << EOF
Correct: "$PLANTED_QUOTE" (p. $true_page).

Wrong page: "$PLANTED_QUOTE" (p. $wrong_page).

Fabricated: "This sentence was never written anywhere in the source text" (p. $true_page).
EOF
  runcap "$SCRIPT_DIR/verify-quotes.sh" "$WORKSPACE"
  expect_exit "verify-quotes: correct + wrong-page + fabricated -> exit 1" 1
  expect_stdout_count "verify-quotes: exactly 1 OK line" '^OK\b' 1
  expect_stdout_count "verify-quotes: exactly 2 FAIL lines (wrong page + fabricated)" '^FAIL\b' 2
  expect_json_field "verify-quotes: summary reports checked=3" "$LAST_STDOUT" "checked" "3"
  expect_json_field "verify-quotes: summary reports ok=1" "$LAST_STDOUT" "ok" "1"
  expect_json_field "verify-quotes: summary reports fail=2" "$LAST_STDOUT" "fail" "2"

  cat > "$WORKSPACE/notes/verify-basic.md" << EOF
Correct: "$PLANTED_QUOTE" (p. $true_page).
EOF
  runcap "$SCRIPT_DIR/verify-quotes.sh" "$WORKSPACE"
  expect_exit "verify-quotes: fixed note -> exit 0" 0
  expect_json_field "verify-quotes: fixed note summary reports fail=0" "$LAST_STDOUT" "fail" "0"

  rm -f "$WORKSPACE/notes/verify-basic.md"
  near_page=$((true_page + 1))
  range_lo=$((true_page > 1 ? true_page - 1 : true_page))
  cat > "$WORKSPACE/notes/verify-forms.md" << EOF
Adjacent-page (should be NEAR): "$PLANTED_QUOTE" (p. $near_page).

Range form covering the true page (should be OK): "$PLANTED_QUOTE" (pp. $range_lo-$true_page).

Vietnamese tr. form on the true page (should be OK): "$PLANTED_QUOTE" (tr. $true_page).
EOF
  runcap "$SCRIPT_DIR/verify-quotes.sh" "$WORKSPACE"
  expect_exit "verify-quotes: NEAR + pp. range + tr. forms -> exit 0 (none FAIL)" 0
  expect_stdout_count "verify-quotes: exactly 1 NEAR line (adjacent page)" '^NEAR\b' 1
  expect_stdout_count "verify-quotes: exactly 2 OK lines (pp. range + tr. forms)" '^OK\b' 2
  expect_json_field "verify-quotes: forms summary reports near=1" "$LAST_STDOUT" "near" "1"
  expect_json_field "verify-quotes: forms summary reports ok=2" "$LAST_STDOUT" "ok" "2"
  rm -f "$WORKSPACE/notes/verify-forms.md"

  # --- Regression: hyphen/space normalization ---
  # The book prints "lowest-end"/"value-add"; a note quoting it with plain
  # spaces instead of hyphens must still match (dashes fold to a space).
  hyphen_page=$(awk -v pat="$PLANTED_HYPHEN_QUOTE" '
    index($0, pat) > 0 { print page; f=1; exit }
    /^\[\[page [0-9]+\]\]$/ { p=$0; gsub(/[^0-9]/,"",p); page=p+0 }
    END { if (!f) print "" }
  ' "$SOURCE_TXT")
  if [ -z "$hyphen_page" ]; then
    fail "verify-quotes: could not locate planted hyphen quote's page" "fixture generation problem"
  else
    dehyphenated=$(printf '%s' "$PLANTED_HYPHEN_QUOTE" | tr '-' ' ')
    cat > "$WORKSPACE/notes/verify-hyphen.md" << EOF
Quoted with spaces where the book uses hyphens: "$dehyphenated" (p. $hyphen_page).
EOF
    runcap "$SCRIPT_DIR/verify-quotes.sh" "$WORKSPACE"
    expect_exit "verify-quotes: hyphen/space variant -> exit 0 (regression: dash-to-space normalization)" 0
    expect_stdout_count "verify-quotes: hyphen/space variant reports OK (regression: dash-to-space normalization)" '^OK\b' 1
    expect_json_field "verify-quotes: hyphen/space variant summary reports fail=0" "$LAST_STDOUT" "fail" "0"
    rm -f "$WORKSPACE/notes/verify-hyphen.md"
  fi

  # --- Regression: fenced code blocks must be invisible to the scanner ---
  # A fabricated "quote" inside a ```mermaid fence (mirroring a concept-map
  # node label) must not be checked at all -- not OK, not FAIL, not counted.
  cat > "$WORKSPACE/notes/verify-fenced.md" << EOF
Real quote outside the fence: "$PLANTED_QUOTE" (p. $true_page).

\`\`\`mermaid
graph TD
  A["This fabricated quote never appeared in the book at all"] --> B (p. $true_page)
\`\`\`

More prose after the fence, unrelated to any citation.
EOF
  runcap "$SCRIPT_DIR/verify-quotes.sh" "$WORKSPACE"
  expect_exit "verify-quotes: fenced fabricated quote ignored -> exit 0 (regression: fenced code blocks skipped)" 0
  expect_json_field "verify-quotes: fenced-block summary reports checked=1 (only the real quote, regression: fenced code blocks skipped)" "$LAST_STDOUT" "checked" "1"
  expect_json_field "verify-quotes: fenced-block summary reports ok=1" "$LAST_STDOUT" "ok" "1"
  expect_json_field "verify-quotes: fenced-block summary reports fail=0" "$LAST_STDOUT" "fail" "0"
  rm -f "$WORKSPACE/notes/verify-fenced.md"
fi
echo

# =====================================================================
# 6. French support (regression: guillemets « » and French headings)
# =====================================================================
FR_WS="$WORKDIR/fr-workspace"
mkdir -p "$FR_WS/notes"
cat > "$FR_WS/source.txt" << 'EOF'
[[page 1]]
Préface
Le livre commence ici avec des mots ordinaires pour occuper la page entière.
[[page 2]]
Chapitre 2
La phrase que nous allons citer se trouve sur cette page précise du livre.
EOF

FR_QUOTE="La phrase que nous allons citer se trouve sur cette page précise du livre"
cat > "$FR_WS/notes/citation.md" << EOF
Comme le dit l'auteur : « $FR_QUOTE » (p. 2).
EOF
runcap "$SCRIPT_DIR/verify-quotes.sh" "$FR_WS"
expect_exit "verify-quotes: French guillemets citation -> exit 0" 0
expect_json_field "verify-quotes: French guillemets are scanned (checked=1)" "$LAST_STDOUT" "checked" "1"
expect_json_field "verify-quotes: French guillemets are verified (ok=1)" "$LAST_STDOUT" "ok" "1"

cat > "$FR_WS/notes/citation-fausse.md" << 'EOF'
Citation inventée : « Voici une phrase entièrement fabriquée qui n'existe nulle part dans ce livre » (p. 2).
EOF
runcap "$SCRIPT_DIR/verify-quotes.sh" "$FR_WS"
expect_exit "verify-quotes: fabricated French citation -> exit 1" 1
expect_json_field "verify-quotes: fabricated French citation is scanned (checked=2)" "$LAST_STDOUT" "checked" "2"
expect_json_field "verify-quotes: fabricated French citation is caught (fail=1)" "$LAST_STDOUT" "fail" "1"
rm -f "$FR_WS/notes/citation-fausse.md"

# --- Page range with a typographic en dash (pp. 12–15) ---
# Isolated workspace: the check must prove the marker itself was parsed, not
# borrow an "ok" from another note in the shared workspace.
FR_DASH_WS="$WORKDIR/fr-dash-workspace"
mkdir -p "$FR_DASH_WS/notes"
cp "$FR_WS/source.txt" "$FR_DASH_WS/source.txt"
cat > "$FR_DASH_WS/notes/citation-plage.md" << EOF
Guillemets français et plage au demi-cadratin : « $FR_QUOTE » (pp. 2–2).
EOF
runcap "$SCRIPT_DIR/verify-quotes.sh" "$FR_DASH_WS"
expect_exit "verify-quotes: en-dash page range -> exit 0" 0
expect_json_field "verify-quotes: en-dash page range is scanned (checked=1)" "$LAST_STDOUT" "checked" "1"
expect_json_field "verify-quotes: en-dash page range is verified (ok=1)" "$LAST_STDOUT" "ok" "1"

# --- Structure extraction on French headings ---
FR_TXT="$WORKDIR/fr-structure.txt"
cat > "$FR_TXT" << 'EOF'
[[page 1]]
PRÉFACE
[[page 2]]
CHAPITRE PREMIER
[[page 3]]
Chapitre 2
[[page 4]]
Table des matières
[[page 5]]
ÉPILOGUE
[[page 6]]
Annexe A
[[page 7]]
Remerciements
EOF
runcap "$SCRIPT_DIR/extract-structure.sh" "$FR_TXT"
expect_exit "extract-structure: French fixture -> exit 0" 0
expect_stdout_has "extract-structure: finds PRÉFACE" "PRÉFACE"
expect_stdout_has "extract-structure: finds CHAPITRE PREMIER" "CHAPITRE PREMIER"
expect_stdout_has "extract-structure: finds Chapitre 2" "Chapitre 2"
expect_stdout_has "extract-structure: finds Table des matières" "Table des matières"
expect_stdout_has "extract-structure: finds ÉPILOGUE" "ÉPILOGUE"
expect_stdout_has "extract-structure: finds Annexe A" "Annexe A"
expect_stdout_has "extract-structure: finds Remerciements" "Remerciements"
echo

# =====================================================================
# Summary
# =====================================================================
printf '\n== %d passed, %d failed, %d skipped (%ds) ==\n' "$PASS_COUNT" "$FAIL_COUNT" "$SKIP_COUNT" "$SECONDS"

if [ "$FAIL_COUNT" -eq 0 ]; then
  exit 0
else
  exit 1
fi
