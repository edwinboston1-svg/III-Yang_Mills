#!/bin/bash
# tolcurve.sh DRESS F0 BETA(1e-4 units) OUT: the TOLERANCE kappa*(beta) = the largest tail-only per-plaquette factor K (TKN/10000,
# EVENTAIL: the tail 3 (4/25) sigma(F0+2) (rK)^{F0+2}/(1-(rK)^2), i.e. every leaf of size >= F0+2 at 4 sigma(F) (K u)^F) with a
# certified PASS at beta (alpha on the 1e-4 grid in [0.0010, 0.0120], the scan's own search). Bisection on TKN in [10000, 40000];
# valid because the left side increases with K. Both ends checked first.
W="$(cd "$(dirname "$0")" && pwd)"; D="$1"; F0="$2"; B="$3"; OUT="$4"; TAB=$(cat "$W/r2tab_g.txt")
one() { AWKPATH="/c/Users/Edwin Boston/OneDrive/Desktop/III/STDLIB/scripts" gawk -M -v BESSEL_LIB=1 -v LOCAL=1 -v "R2TAB=$TAB" -v DRESS="$D" -v SCAN=1 -v BETA0="$B" -v BETA1="$B" -v AK0=10 -v AK1=120 -v F0="$F0" -v NC22=46816 -v EVENTAIL=1 -v NCSIG=1 -v TKN="$1" -v TKD=10000 -f "$W/kp_cert_m1.awk" 2>&1 | tr -d '\r' | grep "KP-CERT SCAN.*beta=0\.$(printf %04d $B) "; }
{ echo "START $(date '+%Y-%m-%d %H:%M:%S') engine md5=$(md5sum "$W/kp_cert_m1.awk" | cut -c1-32) dress=$D F0=$F0 beta=0.$(printf %04d $B)"
  LO=10000; HI=40000
  l=$(one $LO); echo "K=1.0000 $l"; echo "$l" | grep -q "PASS for" || { echo "TOL REFUSED: no PASS at K = 1"; echo "END $(date '+%Y-%m-%d %H:%M:%S')"; exit 0; }
  h=$(one $HI); echo "K=4.0000 $h"; echo "$h" | grep -q "PASS for" && { echo "TOL: PASS even at K = 4"; echo "END $(date '+%Y-%m-%d %H:%M:%S')"; exit 0; }
  while [ $((HI - LO)) -gt 10 ]; do M=$(( (LO + HI) / 2 )); r=$(one $M); echo "K=$(awk -v m=$M 'BEGIN{printf "%.4f", m/10000}') $r"; if echo "$r" | grep -q "PASS for"; then LO=$M; else HI=$M; fi; done
  echo "TOL beta=0.$(printf %04d $B) kappa* in [$(awk -v m=$LO 'BEGIN{printf "%.4f", m/10000}'), $(awk -v m=$HI 'BEGIN{printf "%.4f", m/10000}')) (PASS at the lower, FAIL at the upper)"
  echo "END $(date '+%Y-%m-%d %H:%M:%S')"; } > "$W/$OUT"
grep "TOL" "$W/$OUT"
