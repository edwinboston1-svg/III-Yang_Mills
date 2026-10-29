#!/bin/bash
# g39_maxdatum.sh -- DOES THE ORDERED DATUM MAXIMISE EVERY LOOP OF THE 2x2 SQUARE? (ΠΕΝΤΑΠΥΛΟΝ G39, 2026-10-29 06:2x EDT, the desktop seat.)  For U(1)
# the spin-glass bound |<e^{i Phi}>_phi| <= <cos Phi>_0 (Ginibre's duplication) makes this a THEOREM -- the U(1) half is the instrument's control; for
# SU(2) it is a non-abelian Ginibre inequality, a form of Conjecture G -- the SU(2) half is the test.  Near-ordered data: every outside link perturbed
# by eps x a standard normal (an angle / an su(2) vector), eps in 0.02 .. 0.8, eight seeds each; printed: the largest W(datum) - W(ordered) over the
# data for W(1,1), W(2,1), W(1,2) (U(1)) and W(1,1), W(2,2) (both).  A positive difference beyond 1e-9 is a datum that beats the ordered one.
cd "$(dirname "$0")"
for b in 0.5 1.0 2.0; do o=$(perl g35_u1_square.pl $b base 10 2>&1 | grep G35-BASE); w0=$(echo "$o" | sed 's/.*W(1,1) = \([0-9.-]*\) W(1,2) = \([0-9.-]*\) W(2,1) = \([0-9.-]*\) W(2,2) = \([0-9.-]*\);.*/\1 \2 \3 \4/');
  best="-9 -9 -9 -9"; arg=""; for e in 0.02 0.05 0.1 0.2 0.4 0.8; do for s in 1 2 3 4 5 6 7 8; do o=$(G35_DATUM=near:$s:$e perl g35_u1_square.pl $b base 10 2>&1 | grep G35-BASE); w=$(echo "$o" | sed 's/.*W(1,1) = \([0-9.-]*\) W(1,2) = \([0-9.-]*\) W(2,1) = \([0-9.-]*\) W(2,2) = \([0-9.-]*\);.*/\1 \2 \3 \4/');
    best=$(awk -v a="$best" -v w="$w" -v z="$w0" 'BEGIN { split(a, A); split(w, W); split(z, Z); for (i = 1; i <= 4; i++) { d = W[i] - Z[i]; if (d > A[i]) A[i] = d } printf "%.3e %.3e %.3e %.3e", A[1], A[2], A[3], A[4] }'); done; done
  echo "G39-U1 beta=$b ordered W(1,1) W(1,2) W(2,1) W(2,2) = $w0; the largest W(near datum) - W(ordered) over 48 data: $best $(awk -v a="$best" 'BEGIN { split(a, A); m = A[1]; for (i = 2; i <= 4; i++) if (A[i] > m) m = A[i]; print (m > 1e-9 ? "[A-DATUM-BEATS-ORDERED]" : "[ORDERED-MAXIMAL]") }')"; done
for b in 0.5 1.0 2.2; do o=$(perl g34_su2_square.pl $b base 2 3 2>&1 | grep G34-BASE); w0=$(echo "$o" | sed 's/.*W(1,1) = E\[tr P_0\]\/2 = \([0-9.-]*\); W(2,2) = E\[tr W\]\/2 = \([0-9.-]*\);.*/\1 \2/');
  best="-9 -9"; for e in 0.02 0.05 0.1 0.2 0.4 0.8; do for s in 1 2 3 4 5 6 7 8; do o=$(G34_DATUM=near:$s:$e perl g34_su2_square.pl $b base 2 3 2>&1 | grep -E 'G34-BASE|died|not real'); w=$(echo "$o" | sed 's/.*W(1,1) = E\[tr P_0\]\/2 = \([0-9.-]*\); W(2,2) = E\[tr W\]\/2 = \([0-9.-]*\);.*/\1 \2/');
    case "$w" in *[a-zA-Z]*) echo "G39-SU2 beta=$b datum near:$s:$e REFUSED: $o" | cut -c1-200; continue;; esac
    best=$(awk -v a="$best" -v w="$w" -v z="$w0" 'BEGIN { split(a, A); split(w, W); split(z, Z); for (i = 1; i <= 2; i++) { d = W[i] - Z[i]; if (d > A[i]) A[i] = d } printf "%.3e %.3e", A[1], A[2] }'); done; done
  echo "G39-SU2 beta=$b ordered W(1,1) W(2,2) = $w0; the largest W(near datum) - W(ordered) over 48 data: $best $(awk -v a="$best" 'BEGIN { split(a, A); m = (A[1] > A[2]) ? A[1] : A[2]; print (m > 1e-9 ? "[A-DATUM-BEATS-ORDERED]" : "[ORDERED-MAXIMAL]") }')"; done
