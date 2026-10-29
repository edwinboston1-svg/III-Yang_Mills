#!/bin/bash
# g36_flow_datum.sh -- THE ONE-STEP BLOCKED-COUPLING MAP ITERATED AT THE ORDERED AND AT TWO RANDOM DATA, BOTH GROUPS (ΠΕΝΤΑΠΥΛΟΝ G36b, 2026-10-29
# 06:0x EDT, the desktop seat; the plan seat's order: the ordered datum's share of the running READ, not assumed; the loop characters printed at
# every step so the truncation's scale travels with the number).  A random datum = every outside link Haar-random (SU(2)) / every outside angle
# uniform (U(1)), seeded, re-drawn with the same seed at every step.  Each step prints beta_eff and the big loop's first characters.
cd "$(dirname "$0")"
step() { local g=$1 b=$2 d=$3; if [ "$g" = su2 ]; then G34_DATUM=$d perl g34_su2_square.pl "$b" base 2 3 2>&1 | grep -E 'G34-BASE|died|not' | sed 's/.*W(2,2) = E\[tr W\]\/2 = \([-0-9.]*\); the loop.s characters \([-0-9.,]*\); BLOCKED COUPLING beta_eff(2a) = \([0-9.]*\).*/\3 (W22 \1, chars \2)/'; else G35_DATUM=$d perl g35_u1_square.pl "$b" base 10 2>&1 | grep -E 'G35-BASE|died|not' | sed 's/.*second mode E\[cos 2Phi\] = \([-0-9.]*\);.* W(2,2) = \([-0-9.]*\);.*beta_eff(2a) = \([0-9.]*\).*/\3 (W22 \2, cos2 \1)/'; fi; }
for start in "su2 2.2" "su2 1.5" "u1 2.0" "u1 1.2"; do set -- $start; g=$1; b0=$2; for d in ordered random:1 random:2; do b=$b0; line="G36D-FLOW $g from $b0 datum=$d:"; for k in 1 2 3 4 5 6; do out=$(step $g $b $d); nb=${out%% *}; case "$nb" in ''|*[!0-9.]*) line="$line [step $k: $out]"; break;; esac; line="$line | $out"; b=$nb; awk -v x="$b" 'BEGIN { exit !(x < 0.02 || x > 40) }' && break; done; echo "$line"; done; done
