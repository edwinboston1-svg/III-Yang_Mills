#!/bin/bash
# g36_flow_w4.sh -- THE SU(2) ONE-STEP MAP ITERATED AT SPINS <= 2 (ΠΕΝΤΑΠΥΛΟΝ G36c, 2026-10-29 06:4x EDT): the spin-1 truncation's 2.2 -> 1.354
# carried a large truncation error (spins <= 2 read 1.888 at 2.2); the flow from 2.2 re-read with g34_su2_square.v3.pl at G34_WMAX=4, caps loop 4 /
# face 5, the ordered datum; each step prints beta_eff and the loop's characters.  Staked: below 0.2414 within eight steps, monotone.
cd "$(dirname "$0")"
b=1.887861; line="G36W-FLOW su2 spins<=2 from 2.2: 1.887861 (step 1 of record g34_su2_base_w4_b2.2)"
for k in 2 3 4 5 6 7 8; do out=$(G34_WMAX=4 perl g34_su2_square.v3.pl $b base 4 5 2>&1 | grep -E 'G34-BASE|not positive|died'); nb=$(echo "$out" | sed 's/.*BLOCKED COUPLING beta_eff(2a) = \([0-9.]*\).*/\1/'); case "$nb" in ''|*[!0-9.]*) line="$line | step $k: $out"; break;; esac
  ch=$(echo "$out" | sed 's/.*the loop.s characters \([-0-9.,]*\);.*/\1/'); line="$line | $nb (chars $ch)"; echo "G36W-STEP $k beta_in=$b beta_eff=$nb chars $ch ($(date +%H:%M))"; b=$nb; awk -v x="$b" 'BEGIN { exit !(x < 0.05) }' && break; done
echo "$line"
