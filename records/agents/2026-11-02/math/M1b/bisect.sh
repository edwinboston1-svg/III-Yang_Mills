#!/bin/bash
# bisect.sh ENGINE DRESS F0 LO HI OUT [extra -v ...]: the largest beta on the 2e-4 grid with a certified PASS, by bisection over
# single-beta SCAN calls (alpha on the 1e-4 grid in [0.0010, 0.0120], the scan's own search). Valid where PASS is monotone in
# beta (the left side increases with beta); both ends are checked first: LO must PASS, HI must FAIL, else the run says so.
W="$(cd "$(dirname "$0")" && pwd)"; E="$1"; D="$2"; F0="$3"; LO="$4"; HI="$5"; OUT="$6"; shift 6
TAB=$(cat "$W/r2tab_g.txt")
one() { AWKPATH="/c/Users/Edwin Boston/OneDrive/Desktop/III/STDLIB/scripts" gawk -M -v BESSEL_LIB=1 -v LOCAL=1 -v "R2TAB=$TAB" -v DRESS="$D" -v SCAN=1 -v BETA0="$1" -v BETA1="$1" -v AK0=10 -v AK1=120 -v F0="$F0" -v NC22=46816 "${@:2}" -f "$W/$E" 2>&1 | tr -d '\r' | grep "KP-CERT SCAN.*beta=0\.$(printf %04d $1) "; }
{ echo "START $(date '+%Y-%m-%d %H:%M:%S') engine=$E md5=$(md5sum "$W/$E" | cut -c1-32) dress=$D F0=$F0 lo=$LO hi=$HI extra=$*"
  l=$(one "$LO" "$@"); echo "$l"; echo "$l" | grep -q "PASS for" || { echo "BISECT REFUSED: lo=$LO does not PASS"; echo "END $(date '+%Y-%m-%d %H:%M:%S')"; exit 0; }
  h=$(one "$HI" "$@"); echo "$h"; echo "$h" | grep -q "PASS for" && { echo "BISECT REFUSED: hi=$HI PASSES (raise hi)"; echo "END $(date '+%Y-%m-%d %H:%M:%S')"; exit 0; }
  while [ $((HI - LO)) -gt 2 ]; do M=$(( (LO + HI) / 2 )); M=$(( M - M % 2 )); [ $M -le $LO ] && M=$((LO + 2)); r=$(one "$M" "$@"); echo "$r"; if echo "$r" | grep -q "PASS for"; then LO=$M; else HI=$M; fi; done
  echo "BISECT beta* = 0.$(printf %04d $LO) (PASS), refused at 0.$(printf %04d $HI)"
  echo "END $(date '+%Y-%m-%d %H:%M:%S')"; } > "$W/$OUT"
grep "BISECT" "$W/$OUT"
