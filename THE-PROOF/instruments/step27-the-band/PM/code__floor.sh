#!/bin/bash
# floor.sh B N REC... -- THE DATA-INTEGRATED WALL FLOOR WITH ITS ERROR (PM, 2026-11-02): the A<->B-symmetrised Monte Carlo table of the su2mh
# records -> w2_modes.awk (MIR's, byte-identical: sha dfc0e8c3...) at grid N; then the jackknife over bins of B configurations (each bin left out
# in turn) -> the standard error of every spin-1-creating mode bhat and of a'_1; then Fact D4's interval:
#   upper = (a'_1 + 2 s(a'_1))^+ + (16/3) sum_i (|bhat_i| + 2 s_i)^{1/2},   lower = (16/3) sum_i (max(|bhat_i| - 2 s_i, 0))^{1/2},
# and the pass line against the certificate's wall ceiling 0.0161.  Writes floor_full.txt, floor_jk.txt in the current directory.
B=$1; N=$2; shift 2
D="$(cd "$(dirname "$0")" && pwd)"
gawk -v SYM=1 -f "$D/mc2table.awk" "$@" > table_full.txt
gawk -v N=$N -f "$D/w2_modes.awk" table_full.txt > floor_full.txt
NC=$(cat "$@" | grep -vc '^#'); NB=$((NC / B))
: > floor_jk.txt
for ((k = 1; k <= NB; k++)); do gawk -v SYM=1 -v B=$B -v DROP=$k -f "$D/mc2table.awk" "$@" > table_jk.txt
  gawk -v N=$N -f "$D/w2_modes.awk" table_jk.txt | gawk -v K=$k '/^W2-MODE/ || /^W2-SHARES/ || /^W2-COEF j2=2 / { print "JK" K, $0 }' >> floor_jk.txt; done
gawk -v NB=$NB '
  function abs(x) { return x < 0 ? -x : x }
  # the full table
  FILENAME ~ /floor_full/ && /^W2-MODE/ { a = substr($2, 3) + 0; c = substr($3, 3) + 0; split($4, t, "="); B0[a, c] = t[2] + 0; if (a > L) L = a }
  FILENAME ~ /floor_full/ && /^W2-COEF j2=2 / { split($3, t, "="); A1 = t[2] + 0 }
  FILENAME ~ /floor_full/ && /^W2-SHARES/ { FULLLINE = $0 }
  FILENAME ~ /floor_jk/ && /W2-MODE/ { k = substr($1, 3) + 0; a = substr($3, 3) + 0; c = substr($4, 3) + 0; split($5, t, "="); J[k, a, c] = t[2] + 0 }
  FILENAME ~ /floor_jk/ && /W2-COEF j2=2 / { k = substr($1, 3) + 0; split($4, t, "="); JA1[k] = t[2] + 0 }
  END {
    # the spin-1-creating modes: one index 2, the other > 0 and != 2 (w2_modes rule)
    up = 0; lo = 0; n = 0
    for (a = 0; a <= L; a++) for (c = 0; c <= L; c++) { if (!((a == 2 && c > 0 && c != 2) || (c == 2 && a > 0 && a != 2))) continue
      s = 0; q = 0; for (k = 1; k <= NB; k++) { s += J[k, a, c]; q += J[k, a, c] ^ 2 } m = s / NB; v = (NB - 1) / NB * (q - NB * m * m); if (v < 0) v = 0; se = sqrt(v)
      printf "FLOOR-MODE (%d,%d) bhat = %+.4e +- %.2e (jackknife over %d bins)\n", a, c, B0[a, c], se, NB
      up += sqrt(abs(B0[a, c]) + 2 * se); x = abs(B0[a, c]) - 2 * se; lo += (x > 0 ? sqrt(x) : 0); face += sqrt(abs(B0[a, c])) }
    s = 0; q = 0; for (k = 1; k <= NB; k++) { s += JA1[k]; q += JA1[k] ^ 2 } m = s / NB; v = (NB - 1) / NB * (q - NB * m * m); if (v < 0) v = 0; sa = sqrt(v)
    a1up = A1 + 2 * sa; if (a1up < 0) a1up = 0
    printf "FLOOR a1prime = %+.4e +- %.2e (its upper end %.4e enters)\n", A1, sa, a1up
    printf "FLOOR the face value (w2_modes, signed a_1): %s\n", FULLLINE
    printf "FLOOR INTERVAL (Fact D4): lower %.6f  face %.6f  upper %.6f  against the wall ceiling 0.0161: %s\n", 16 * lo / 3, A1 + 16 * face / 3, a1up + 16 * up / 3, (a1up + 16 * up / 3 < 0.0161) ? "THE UPPER END IS BELOW -- PASS (READING)" : ((16 * lo / 3 > 0.0161) ? "THE LOWER END IS ABOVE -- KILL-SWITCH (READING)" : "UNDECIDED") }' floor_full.txt floor_jk.txt
