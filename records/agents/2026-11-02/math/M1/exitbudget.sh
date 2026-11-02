#!/bin/bash
# exitbudget.sh DRESS OUT [extra -v ...]: THE EXIT BUDGET eps(beta) in the TABLE mode of record (LOCAL=1, R2TAB = tag g), alpha = 1/1000,
# F0 = 20: the largest tilt t (units 1/1000) with a certified PASS, every a_j multiplied by e^{t} in directed rounding (the engine's TILT
# mode, the far shore section 10's definition), found by bisection on the integer grid t in [0, 4000].  PASS at t means PASS at every
# smaller tilt (the left side is increasing in every a_j), so bisection is valid.  Prints one line per beta.
W="$(cd "$(dirname "$0")" && pwd)"; D="$1"; OUT="$2"; shift 2
TAB=$(cat "$W/r2tab_g.txt")
pass() { AWKPATH="/c/Users/Edwin Boston/OneDrive/Desktop/III/STDLIB/scripts" gawk -M -v BESSEL_LIB=1 -v LOCAL=1 -v "R2TAB=$TAB" -v DRESS="$D" -v P="$1" -v Q=10000 -v AN=1 -v AD=1000 -v F0=20 -v TILTN="$2" -v TILTD=1000 "$@" -f "$W/kp_cert_m1.awk" 2>&1 | tr -d '\r' | grep "KP-CERT dress" | grep -q -- "-> PASS"; }
{ echo "START $(date '+%Y-%m-%d %H:%M:%S') dress=$D extra=$*"
for P in 500 1000 1500 2000 2500 3000 3500 4000 4500 4764 5000; do
  lo=-1; hi=4001
  # t = 0 must pass, else eps < 0 (reported as none)
  if ! AWKPATH="/c/Users/Edwin Boston/OneDrive/Desktop/III/STDLIB/scripts" gawk -M -v BESSEL_LIB=1 -v LOCAL=1 -v "R2TAB=$TAB" -v DRESS="$D" -v P="$P" -v Q=10000 -v AN=1 -v AD=1000 -v F0=20 "$@" -f "$W/kp_cert_m1.awk" 2>&1 | tr -d '\r' | grep "KP-CERT dress" | grep -q -- "-> PASS"; then echo "beta=0.$(printf %04d $P) eps: no PASS at tilt 0 (alpha = 0.001)"; continue; fi
  lo=0
  while [ $((hi - lo)) -gt 1 ]; do mid=$(( (lo + hi) / 2 ))
    if AWKPATH="/c/Users/Edwin Boston/OneDrive/Desktop/III/STDLIB/scripts" gawk -M -v BESSEL_LIB=1 -v LOCAL=1 -v "R2TAB=$TAB" -v DRESS="$D" -v P="$P" -v Q=10000 -v AN=1 -v AD=1000 -v F0=20 -v TILTN="$mid" -v TILTD=1000 "$@" -f "$W/kp_cert_m1.awk" 2>&1 | tr -d '\r' | grep "KP-CERT dress" | grep -q -- "-> PASS"; then lo=$mid; else hi=$mid; fi
  done
  echo "beta=0.$(printf %04d $P) eps in [$(awk -v l=$lo 'BEGIN{printf "%.3f", l/1000}'), $(awk -v h=$hi 'BEGIN{printf "%.3f", h/1000}')) (PASS at tilt $lo/1000, FAIL at $hi/1000)"
done
echo "END $(date '+%Y-%m-%d %H:%M:%S')"; } > "$W/$OUT"
cat "$W/$OUT"
