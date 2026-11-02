#!/bin/bash
# m1r_lib.sh -- the second reader M1R's drivers (2026-11-02). Sourced, never edited while a run reads it.
# Every call is the engine of the named file, gawk -M on the 2^-128 grid, AWKPATH = III STDLIB/scripts (the Bessel library, read only),
# the table of record tag g (R2TAB read from local_tail_table.2026-10-31g.txt, cmp-identical to M1's r2tab_g.txt).
W="/c/Users/EDWINB~1/AppData/Local/Temp/claude/C--Users-Edwin-Boston-OneDrive-Desktop-III/59ca2c52-22a2-4ac6-93d9-5dadb2bb3bcb/scratchpad/math/M1R"
AWKP="/c/Users/Edwin Boston/OneDrive/Desktop/III/STDLIB/scripts"
TAB=$(cat "$W/r2tab_g_mine.txt")
# point ENGINE BETA(1e-4) ALPHA(1e-4) DRESS F0 [extra -v ...]: one certified point, the report lines
point() { local E="$1" B="$2" A="$3" D="$4" F="$5"; shift 5
  AWKPATH="$AWKP" gawk -M -v BESSEL_LIB=1 -v DRESS="$D" -v P="$B" -v Q=10000 -v AN="$A" -v AD=10000 -v F0="$F" -v NC22=46816 "$@" -f "$W/$E" 2>&1 | tr -d '\r'; }
# scan1 ENGINE BETA(1e-4) DRESS F0 AK0 AK1 [extra]: the single-beta scan line (the scan's own alpha search on the 1e-4 grid)
scan1() { local E="$1" B="$2" D="$3" F="$4" K0="$5" K1="$6"; shift 6
  AWKPATH="$AWKP" gawk -M -v BESSEL_LIB=1 -v DRESS="$D" -v SCAN=1 -v BETA0="$B" -v BETA1="$B" -v AK0="$K0" -v AK1="$K1" -v F0="$F" -v NC22=46816 "$@" -f "$W/$E" 2>&1 | tr -d '\r' | grep "KP-CERT SCAN.*beta=0\.$(printf %04d $B) "; }
# vscan ENGINE BETA DRESS F0 AK0 AK1 [extra]: the variant's verbose scan -- every alpha's report line, then the scan line
vscan() { local E="$1" B="$2" D="$3" F="$4" K0="$5" K1="$6"; shift 6
  AWKPATH="$AWKP" gawk -M -v BESSEL_LIB=1 -v DRESS="$D" -v SCAN=1 -v VSCAN=1 -v BETA0="$B" -v BETA1="$B" -v AK0="$K0" -v AK1="$K1" -v F0="$F" -v NC22=46816 "$@" -f "$W/$E" 2>&1 | tr -d '\r'; }
# bis ENGINE DRESS F0 LO HI AK0 AK1 [extra]: the largest beta on the 2e-4 grid with a PASS, by bisection over single-beta scans (LO must PASS,
# HI must FAIL, both read first); valid where PASS is monotone in beta, which the bisection does not check -- the endpoints' neighbours are read after
bis() { local E="$1" D="$2" F="$3" LO="$4" HI="$5" K0="$6" K1="$7"; shift 7; local l h M r
  l=$(scan1 "$E" "$LO" "$D" "$F" "$K0" "$K1" "$@"); echo "$l"; echo "$l" | grep -q "PASS for" || { echo "BISECT REFUSED: lo=$LO does not PASS"; return; }
  h=$(scan1 "$E" "$HI" "$D" "$F" "$K0" "$K1" "$@"); echo "$h"; echo "$h" | grep -q "PASS for" && { echo "BISECT REFUSED: hi=$HI PASSES"; return; }
  while [ $((HI - LO)) -gt 2 ]; do M=$(( (LO + HI) / 2 )); M=$(( M - M % 2 )); [ $M -le $LO ] && M=$((LO + 2))
    r=$(scan1 "$E" "$M" "$D" "$F" "$K0" "$K1" "$@"); echo "$r"; if echo "$r" | grep -q "PASS for"; then LO=$M; else HI=$M; fi; done
  echo "BISECT beta* = 0.$(printf %04d $LO) (PASS), refused at 0.$(printf %04d $HI)"; }
stamp() { echo "$1 $(date '+%Y-%m-%d %H:%M:%S')"; }
