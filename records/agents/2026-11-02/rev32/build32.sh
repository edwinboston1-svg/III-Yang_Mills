#!/bin/bash
# build32.sh -- THE GROUND, revision 32, up to the commit: apply the three revision scripts to a fresh copy, copy content4.js to both
# source trees, build, render through Word, write the registers, read the PDF. No commit here (ship32_commit.sh does that, after review).
set -u
Y="/c/Users/Edwin Boston/OneDrive/Desktop/III-Yang_Mills"; G="$Y/source/ground"
S="/c/Users/EDWINB~1/AppData/Local/Temp/claude/C--Users-Edwin-Boston-OneDrive-Desktop-III/59ca2c52-22a2-4ac6-93d9-5dadb2bb3bcb/scratchpad"
R="$S/rev32"
cd "$Y" || exit 9
git diff --quiet && git diff --cached --quiet || { echo "REFUSED: the III-Yang_Mills tree has uncommitted changes"; git status --short | head; exit 2; }
H0=$(git rev-parse --short HEAD); echo "HEAD $H0"
rm -rf "$R/r32" && py -3.14 "$R/rev32_blockmap.py" "$G" "$R/r32" && py -3.14 "$R/rev32_supremum.py" "$R/r32" && py -3.14 "$R/rev32_fixes.py" "$R/r32" || { echo "REFUSED: a revision script"; exit 2; }
cp "$R/r32/content4.js" "$G/content4.js" && cp "$R/r32/content4.js" "$Y/source/content4.js" || { echo "REFUSED: copy"; exit 2; }
node --check "$G/content4.js" || { echo "REFUSED: content4.js does not parse"; exit 2; }
export NODE_PATH="$(cygpath -w "$G/node_modules")"
( cd "$G" && node build.js "$(cygpath -w "$Y/THE-GROUND-Edwin-Boston-III.docx")" ) || { echo "REFUSED: the build failed"; exit 2; }
PG=$(powershell.exe -NoProfile -ExecutionPolicy Bypass -File "$(cygpath -w "$G/render.ps1")" -InDocx "$(cygpath -w "$Y/THE-GROUND-Edwin-Boston-III.docx")" -OutPdf "$(cygpath -w "$Y/THE-GROUND-Edwin-Boston-III.pdf")" -OutDocx "$(cygpath -w "$Y/THE-GROUND-Edwin-Boston-III.docx")" 2>&1 | tr -d '\r' | grep -o 'pages=[0-9]*' | cut -d= -f2)
[ -n "$PG" ] || { echo "REFUSED: the render printed no page count"; exit 2; }
echo "rendered: $PG pages"
sed -i 's/revised 2 November 2026 (revision 31)\./revised 2 November 2026 (revision 32)./' README.md
sed -i "s/46 pages (revision 31 of 2 November 2026;/$PG pages (revision 32 of 2 November 2026;/" ARXIV.md
grep -q "revision 32" README.md && grep -q "revision 32 of 2 November" ARXIV.md || { echo "REFUSED: the registers"; exit 2; }
python -c "
import fitz, re, sys
d = fitz.open(sys.argv[1]); t = re.sub(r'\s+', ' ', ''.join(p.get_text() for p in d))
need = ['one on which the reduction below is empty', 'It cannot be weakened to typical coarse configurations', 'interior links at its straight vertices have multiplicity two', 'nothing above 0.4816', 'once each is extended measurably', 'the time extent an even multiple when', 'Theorem 8.8', 'Theorem 8.9', 'the budget closes at the eighth step', 'revised 2 November 2026']
gone = [x for x in ['with the remaining links in a fixed gauge, is such a map.', 'nothing above 0.4764 is proved at all', 'with L = 2, blocked at the coarse scale'] if x in t]
bad = [x for x in need if x not in t]
print('pdf pages', len(d), 'missing', bad, 'stale', gone); sys.exit(0 if not bad and not gone else 3)
" "$Y/THE-GROUND-Edwin-Boston-III.pdf" || { echo "REFUSED: the PDF does not carry revision 32"; exit 2; }
git status --short
git diff --stat | tail -3
echo "BUILD32 DONE (uncommitted)"
