#!/bin/bash
# build33.sh -- THE GROUND, revision 33: the reduction in L² (Theorem 8.5' with its lemmas, the proof agent M2's theorem, written by M2R,
# second-read by M2RR with repairs R1-R6 applied in M2RR/rev33_req/content4.js) and the S12-c' narrowing (M1); build, render, registers,
# PDF read. No commit here.
set -u
Y="/c/Users/Edwin Boston/OneDrive/Desktop/III-Yang_Mills"; G="$Y/source/ground"
S="/c/Users/EDWINB~1/AppData/Local/Temp/claude/C--Users-Edwin-Boston-OneDrive-Desktop-III/59ca2c52-22a2-4ac6-93d9-5dadb2bb3bcb/scratchpad"
R="$S/rev33"
cd "$Y" || exit 9
git diff --quiet && git diff --cached --quiet || { echo "REFUSED: tracked changes present"; git status --short | grep -v '^??' | head; exit 2; }
H0=$(git rev-parse --short HEAD); echo "HEAD $H0"
mkdir -p "$R/r33" && cp "$S/math/M2RR/rev33_req/content4.js" "$R/r33/content4.js" || exit 2
diff "$G/content4.js" "$R/r33/content4.js" | grep -q '^<' && { echo "REFUSED: the repaired copy deletes live lines"; exit 2; }
py -3.14 "$R/rev33_s12.py" "$R/r33/content4.js" || { echo "REFUSED: the S12 narrowing"; exit 2; }
cp "$R/r33/content4.js" "$G/content4.js" && cp "$R/r33/content4.js" "$Y/source/content4.js" || exit 2
node --check "$G/content4.js" || { echo "REFUSED: content4.js does not parse"; exit 2; }
export NODE_PATH="$(cygpath -w "$G/node_modules")"
( cd "$G" && node build.js "$(cygpath -w "$Y/THE-GROUND-Edwin-Boston-III.docx")" ) || { echo "REFUSED: the build"; exit 2; }
PG=$(powershell.exe -NoProfile -ExecutionPolicy Bypass -File "$(cygpath -w "$G/render.ps1")" -InDocx "$(cygpath -w "$Y/THE-GROUND-Edwin-Boston-III.docx")" -OutPdf "$(cygpath -w "$Y/THE-GROUND-Edwin-Boston-III.pdf")" -OutDocx "$(cygpath -w "$Y/THE-GROUND-Edwin-Boston-III.docx")" 2>&1 | tr -d '\r' | grep -o 'pages=[0-9]*' | cut -d= -f2)
[ -n "$PG" ] || { echo "REFUSED: no page count"; exit 2; }
echo "rendered: $PG pages"
sed -i 's/revised 2 November 2026 (revision 32)\./revised 2 November 2026 (revision 33)./' README.md
sed -i "s/[0-9]* pages (revision 32 of 2 November 2026;/$PG pages (revision 33 of 2 November 2026;/" ARXIV.md
grep -q "revision 33" README.md && grep -q "revision 33 of 2 November" ARXIV.md || { echo "REFUSED: the registers"; exit 2; }
python -c "
import fitz, re, sys
d = fitz.open(sys.argv[1]); t = re.sub(r'\s+', ' ', ''.join(p.get_text() for p in d))
need = ['Theorem 8.5′', 'Proposition 8.4′', 'Hypothesis I′', 'Hypothesis II′', 'rectangular cycle whose interior links', 'one on which the reduction below is empty', 'Theorem 8.9', 'revised 2 November 2026']
gone = [x for x in ['a skew hexagon or a planar cycle'] if x in t]
bad = [x for x in need if x not in t]
print('pdf pages', len(d), 'missing', bad, 'stale', gone); sys.exit(0 if not bad and not gone else 3)
" "$Y/THE-GROUND-Edwin-Boston-III.pdf" || { echo "REFUSED: the PDF does not carry revision 33"; exit 2; }
git status --short | grep -v '^??'
echo "BUILD33 DONE (uncommitted)"
