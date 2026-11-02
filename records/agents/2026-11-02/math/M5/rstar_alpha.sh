#!/bin/bash
# M5 rstar_alpha.sh -- (added after the stakes; the alpha bias of S4 named by the advisor): r* under H1 at alpha = 20e-4 and 40e-4 (page
# dress, WALL off, HALF as recorded), both data -- the largest pair ratio r for which a'_1/2 (1 + 2r) still passes.
ROOT="/c/Users/Edwin Boston/OneDrive/Desktop/III"; W="$(cd "$(dirname "$0")" && pwd)"
for d in ordered cancel; do
  F="$ROOT/STDLIB/build/aperanton/surface-gas/w2n4_W2L2_modes.2026-11-01a.$d.txt"
  L="$(grep '^W2-CERT-CALL' "$F" | tr -d '\r')"; COEF="$(echo "$L" | sed 's/.*COEF=\([^ ]*\).*/\1/')"; A1="${COEF%%/*}"; REST="${COEF#*,}"
  for ak in 20 40; do lo=0; hi=30000
    while [ $((hi - lo)) -gt 1 ]; do mid=$(( (lo + hi) / 2 ))
      NA="$(gawk -M -v a="$A1" -v r="$mid" 'BEGIN { printf "%d", a * (1 + 2 * r / 10000) + 0.5 }')"
      if bash "$W/cert_runs.sh" CALL $d page $ak 10000 WALLN=0 "COEF=$NA/1000000000000,$REST" | grep -q -- '-> PASS'; then lo=$mid; else hi=$mid; fi; done
    echo "RSTAR $d page alpha=${ak}e-4: r* in [$lo, $hi]e-4"; done; done
