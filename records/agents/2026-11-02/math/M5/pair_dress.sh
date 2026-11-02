#!/bin/bash
# M5 pair_dress.sh -- stake S4 (WORK.md section 1b): the vortex pair mode as a LABELLED HYPOTHESIS H1, never a theorem.
# H1: every spin-1/2 plaquette coefficient a'_1/2 multiplied by (1 + 2r), r = the (1/2,1/2) pair mode in Wilson pair units (the reader's
# "ratio" column at a=1 c=1), i.e. the per-adjacent-pair dressing of a branch-free surface (four neighbours, AM-GM) at leading order.
# Runs (WALL off, HALF as recorded): H1 at the planar r, and the largest r* that still PASSes (bisection), both dresses, alpha = 1/1000.
ROOT="/c/Users/Edwin Boston/OneDrive/Desktop/III"; W="$(cd "$(dirname "$0")" && pwd)"
for d in ordered cancel; do
  F="$ROOT/STDLIB/build/aperanton/surface-gas/w2n4_W2L2_modes.2026-11-01a.$d.txt"
  L="$(grep '^W2-CERT-CALL' "$F" | tr -d '\r')"; COEF="$(echo "$L" | sed 's/.*COEF=\([^ ]*\).*/\1/')"
  A1="${COEF%%/*}"; REST="${COEF#*,}"
  R="$(grep '^W2-MODE a=1 c=1 ' "$F" | tr -d '\r' | sed 's/.*ratio=\([^ ]*\).*/\1/')"
  for m in page local; do
    # H1 at the planar r
    NA="$(gawk -M -v a="$A1" -v r="$R" 'BEGIN { printf "%d", a * (1 + 2 * r) + 0.5 }')"
    out="$(bash "$W/cert_runs.sh" CALL $d $m 1 1000 WALLN=0 "COEF=$NA/1000000000000,$REST" | sed 's/.*u in \[\([0-9.]*\),.*-> \(.*\)/u=\1 -> \2/')"
    echo "S4 H1 $d $m r=$R: a'_1/2 x (1+2r) = $NA e-12: $out"
    # r* by bisection on r in [0, 2], units 1e-4
    lo=0; hi=20000
    while [ $((hi - lo)) -gt 1 ]; do mid=$(( (lo + hi) / 2 ))
      NA="$(gawk -M -v a="$A1" -v r="$mid" 'BEGIN { printf "%d", a * (1 + 2 * r / 10000) + 0.5 }')"
      if bash "$W/cert_runs.sh" CALL $d $m 1 1000 WALLN=0 "COEF=$NA/1000000000000,$REST" | grep -q -- '-> PASS'; then lo=$mid; else hi=$mid; fi; done
    echo "S4 r* $d $m: the largest passing r in [$lo, $hi]e-4 (a'_1/2 = $A1 e-12, HALF as recorded, WALL off)"
  done
done
