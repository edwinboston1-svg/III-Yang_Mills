#!/bin/bash
# M5 sound_floor.sh -- (added after the stakes, on the advisor's item 1): the SOUND coplanar wall floor, one mode per pair at p,
# a'_1 + 4 |bhat_{1/2,1}|^{1/2} / 3 = 0.038257 (ordered) / 0.042724 (cancelling), run DIRECTLY (not inferred from the W* bisection), across
# alpha in {1,2,5,10,20,30,40,47,55,65,80}e-4, both dresses.  Also the literal MAX rule of RESULTS 4 (iii), |bhat|^{1/2}/3.
ROOT="/c/Users/Edwin Boston/OneDrive/Desktop/III"; W="$(cd "$(dirname "$0")" && pwd)"
for d in ordered cancel; do
  F="$ROOT/STDLIB/build/aperanton/surface-gas/w2n4_W2L2_modes.2026-11-01a.$d.txt"
  L="$(grep '^W2-CERT-CALL' "$F" | tr -d '\r')"; COEF="$(echo "$L" | sed 's/.*COEF=\([^ ]*\).*/\1/')"; REST="${COEF#*,}"; A2="${REST%%/*}"
  B12="$(grep '^W2-MODE a=1 c=2 ' "$F" | tr -d '\r' | sed 's/.*bhat(e^delta-1)=\([^ ]*\).*/\1/')"
  SOUND="$(gawk -M -v a2="$A2" -v b="$B12" 'BEGIN { if (b < 0) b = 0 - b; printf "%d", a2 + 4 * sqrt(b) / 3 * 1e12 + 0.5 }')"
  MAXR="$(gawk -M -v a2="$A2" -v b="$B12" 'BEGIN { if (b < 0) b = 0 - b; s = sqrt(b) / 3 * 1e12; printf "%d", (s > a2 ? s : a2) + 0.5 }')"
  for m in page local; do
    for tag in SOUND MAXR; do V="${!tag}"; pass=""; last=""
      for ak in 1 2 5 10 20 30 40 47 55 65 80; do out="$(bash "$W/cert_runs.sh" CALL $d $m $ak 10000 WALLN=$V)"
        if echo "$out" | grep -q -- '-> PASS'; then pass="$pass $ak"; else last="$(echo "$out" | sed 's/.*-> //')"; fi; done
      [ -n "$pass" ] && r="PASS at alpha (1e-4):$pass" || r="NO PASS for alpha in [1, 80]e-4 (last: $last)"
      echo "FLOOR $tag $d $m WALL=$V e-12: $r"; done; done; done
