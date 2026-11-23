#!/bin/bash
# extract-structure.sh <source.txt>
#
# Heuristic outline seed: scans a prepared source.txt for lines that look
# like headings and prints them with their page number. This is intentionally
# noisy (it is a seed to confirm against the real table of contents, not a
# final chapters.tsv) — see SKILL.md for how it's meant to be used.
set -euo pipefail

usage() {
  echo "Usage: extract-structure.sh <source.txt>" >&2
  exit 1
}

[ $# -eq 1 ] || usage
source_txt="$1"
[ -f "$source_txt" ] || { echo "Source file not found: $source_txt" >&2; exit 1; }

awk '
# POSIX awk tolower() is ASCII-only: it leaves "É" untouched, so a pattern like
# ^preface never matches "Préface". Fold accents by hand before comparing, and
# keep the non-English patterns below pure ASCII.
function fold_accents(s) {
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

BEGIN {
  page = 0
  # --- Heading heuristics: the single source of truth for the pattern list ---
  # 1. English section markers with a number: Chapter/CHAPTER/Part/PART/Book N
  #    (digits or roman numerals), matched case-insensitively via tolower().
  re_en_num   = "^(chapter|part|book)[[:blank:]]+([0-9]+|[ivxlcdm]+)([[:blank:]:.,-]|$)"
  # 2. Vietnamese section markers with a number: Chuong/Phan/Muc N. Matched
  #    case-sensitively against the raw line: POSIX awk tolower() is ASCII-only
  #    and does not reliably fold Vietnamese accented capitals.
  re_vi_num   = "(Chương|chương|Phần|phần|Mục|mục)[[:blank:]]+[0-9IVXLCDMivxlcdm]+([[:blank:]:.,-]|$)"
  # 3. Numbered headings: "1", "2.3", "4)" followed by whitespace and more text.
  re_numbered = "^[0-9]+(\\.[0-9]+)*[.)]?[[:blank:]]+[^[:blank:]]"
  # 4. Standalone structural words (front/back matter), matched case-insensitively
  #    via tolower(); optionally followed by a short label ("Appendix A") or a
  #    trailing colon/period. This also covers reasonable ALL-CAPS variants,
  #    since ALL CAPS lowercases to the same pattern.
  re_struct   = "^(preface|foreword|introduction|prologue|contents|abstract|conclusion|epilogue|appendix|glossary|bibliography|references|index|acknowledgments|acknowledgements)([[:blank:]]+[a-z0-9]+)?[:.]?[[:blank:]]*$"
  # 5. French numbered sections: Chapitre/Livre/Partie/Tome/Section/Acte followed
  #    by a digit, a roman numeral, or a spelled-out ordinal ("CHAPITRE PREMIER",
  #    "Deuxième partie"). Matched against the accent-folded line, so these
  #    patterns stay ASCII.
  re_fr_num   = "^(chapitre|livre|partie|tome|section|acte)[[:blank:]]+([0-9]+|[ivxlcdm]+|premier|premiere|second|seconde|deuxieme|troisieme|quatrieme|cinquieme|sixieme|septieme|huitieme|neuvieme|dixieme|onzieme|douzieme)([[:blank:]:.,-]|$)"
  # 6. French structural headings (front/back matter), optionally followed by a
  #    short label ("Annexe A") or a trailing colon/period.
  re_fr_struct = "^(preface|avant-propos|avertissement|dedicace|epigraphe|introduction|prologue|table des matieres|sommaire|conclusion|epilogue|postface|annexe|appendice|glossaire|bibliographie|references|index|remerciements|notes|cahier|hors-texte)([[:blank:]]+[a-z0-9]+)?[:.]?[[:blank:]]*$"
}
/^\[\[page [0-9]+\]\]$/ {
  page = $0
  gsub(/[^0-9]/, "", page)
  next
}
{
  line = $0
  gsub(/^[[:blank:]]+|[[:blank:]]+$/, "", line)
  if (line == "" || length(line) > 120) next
  lower = tolower(line)
  folded = tolower(fold_accents(line))
  if (lower ~ re_en_num || line ~ re_vi_num || line ~ re_numbered || lower ~ re_struct \
      || folded ~ re_fr_num || folded ~ re_fr_struct) {
    print "- [p. " page "] " line
  }
}
' "$source_txt"
