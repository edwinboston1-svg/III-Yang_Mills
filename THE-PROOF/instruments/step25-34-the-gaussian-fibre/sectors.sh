#!/usr/bin/env bash
# sectors.sh -- ΟΛΟΚΛΗΡΩΣΙΣ Ο4, THE SECTOR FREE ENERGIES ON THE HINGE, READ: ΣΤΡΟΦΙΓΞ's runs of record (STDLIB/build/strophinx/g_kat.txt,
# g_q8.txt: Z_e(L)/Z_0(L) as reduced fractions for G in {Z2, Q8}, y = e^{-2 beta} in {1/2, 1/4}, e in {10, 01, 11}, L = 1..6; g_s3.txt:
# S3's sectors refused by name, the centre trivial).  F(e) - F(0) = -log(Z_e/Z_0) > 0 iff the fraction is below one: every cell is
# compared with 1 EXACTLY by cross-multiplication in gawk -M, every column's monotonicity in L by cross-multiplication of consecutive
# fractions, the Q8 cell against the Z2 cell at equal (y, e, L) likewise.  No number of its own.  The reading is a FINITE-SHADOW
# reading (a finite-group gauge theory on 2 x 2 x L): it says nothing of SU(2)'s range and nothing of an area law.
# Page: DOCS/III-HOLOKLEROSIS-THE-COMPLETION-PREREGISTRATION.md (e6c1349a9), Ο4.
set -u
ROOT="${HLK_ROOT:-$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)}"; cd "$ROOT" || exit 9
KAT="STDLIB/build/strophinx/g_kat.txt"; Q8="STDLIB/build/strophinx/g_q8.txt"; S3="STDLIB/build/strophinx/g_s3.txt"
REFUSED=0
refuse(){ echo "SEC-REFUSED $*"; REFUSED=$((REFUSED+1)); }
for f in "$KAT" "$Q8" "$S3"; do [ -f "$f" ] || refuse "record absent: $f"; done
if [ "$REFUSED" -gt 0 ]; then echo "SEC-END cells=0 verdict=VACUOUS refused=$REFUSED"; exit 0; fi
# the cells, deduplicated by (G, y, e, L), the fraction kept; TAB-separated for awk
cat "$KAT" "$Q8" | tr -d '\r' | grep -E '^SFX G=(Z2|Q8) y=1/[24] e=[01][01] L=[1-6] Z=' \
  | awk '{ for (i = 1; i <= NF; i++) { split($i, kv, "="); if (kv[1] == "G") g = kv[2]; if (kv[1] == "y") y = kv[2]; if (kv[1] == "e") e = kv[2]; if (kv[1] == "L") l = kv[2]; if (kv[1] == "frac") fr = kv[2] }
           key = g "\t" y "\t" e "\t" l; if (!(key in seen)) { seen[key] = 1; print key "\t" fr } }' | sort > "${TMPDIR:-/tmp}/sec_cells.$$"
C="${TMPDIR:-/tmp}/sec_cells.$$"
gawk -M -F'\t' '
  function num(fr) { return substr(fr, 1, index(fr, "/") - 1) + 0 }
  function den(fr) { return substr(fr, index(fr, "/") + 1) + 0 }
  { g = $1; y = $2; e = $3; l = $4 + 0; fr = $5; FR[g, y, e, l] = fr; if (e == "00") next
    cells++; a = num(fr); b = den(fr); below = (a < b) ? "yes" : "no"; if (a < b) nbelow++
    printf "SEC-CELL G=%s y=%s e=%s L=%d frac=%s below-one=%s\n", g, y, e, l, fr, below
    KEYS[g, y, e] = 1 }
  END {
    # the columns: decreasing in L?
    for (k in KEYS) { split(k, p, SUBSEP); g = p[1]; y = p[2]; e = p[3]; dec = 1; steps = 0
      for (l = 1; l < 6; l++) { if (!((g, y, e, l) in FR) || !((g, y, e, l + 1) in FR)) continue
        a1 = num(FR[g, y, e, l]); b1 = den(FR[g, y, e, l]); a2 = num(FR[g, y, e, l + 1]); b2 = den(FR[g, y, e, l + 1]); steps++
        if (!(a1 * b2 > a2 * b1)) dec = 0 }
      cols++; if (dec) ndec++
      printf "SEC-COLUMN G=%s y=%s e=%s steps=%d decreasing=%s\n", g, y, e, steps, (dec ? "yes" : "no") }
    # Q8 against Z2 at equal (y, e, L)
    for (k in KEYS) { split(k, p, SUBSEP); if (p[1] != "Q8") continue; y = p[2]; e = p[3]
      for (l = 1; l <= 6; l++) { if (!(("Q8", y, e, l) in FR) || !(("Z2", y, e, l) in FR)) continue
        aq = num(FR["Q8", y, e, l]); bq = den(FR["Q8", y, e, l]); az = num(FR["Z2", y, e, l]); bz = den(FR["Z2", y, e, l]); pairs++
        q8below = (aq * bz < az * bq) ? "yes" : "no"; if (aq * bz < az * bq) nq8++
        printf "SEC-PAIR y=%s e=%s L=%d q8-below-z2=%s\n", y, e, l, q8below } }
    printf "SEC-COUNT cells=%d below-one=%d columns=%d decreasing=%d pairs=%d q8-below=%d\n", cells, nbelow, cols, ndec, pairs, nq8
  }' "$C" | sort -t' ' -k1,1 -s > "$C.out"
rm -f "$C"
cat "$C.out"
# the two-sided control: S3's centre is trivial and its sectors are refused by name
if grep -qF 'SFX-NOCENTRE: the centre is trivial, the shifts refused, one electric sector' "$S3"; then S3V=yes; else S3V=no; fi
echo "SEC-CONTROL S3 refused-by-name=$S3V"
read -r _ cells below cols dec pairs q8 <<< "$(grep '^SEC-COUNT ' "$C.out" | sed 's/[a-z0-9-]*=//g')"
rm -f "$C.out"
V=SUPPRESSED; { [ "$cells" = "$below" ] && [ "$cells" -gt 0 ]; } || V=EXCEEDED
M=FALLING; [ "$cols" = "$dec" ] || M=WOBBLING
echo "SEC-END cells=$cells below-one=$below verdict=$V columns=$cols decreasing=$dec monotone=$M pairs=$pairs q8-below=$q8 s3-refused=$S3V refused=$REFUSED"
