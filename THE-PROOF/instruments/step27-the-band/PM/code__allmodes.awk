# allmodes.awk -- every mode bhat(a, c) of R - 1 (a, c <= 4) from floor.sh's floor_full.txt with its jackknife error from floor_jk.txt, and
# M7b's sharp inputs (M7b/WORK.md Lemma 3.1, Corollaries 3.2-3.3) at the measured table: the creating (1/2,1/2) bond's relative content
# r_hh = bhat(1,1)/(2 a'_1/2)^2, the (1,1) bond's absolute share |bhat(2,2)|^{1/2}, the (1/2,1) share |bhat(2,1)|^{1/2}, each with its upper end
# (|bhat| + 2s).  usage: gawk -f allmodes.awk floor_full.txt floor_jk.txt
function abs(x) { return x < 0 ? -x : x }
FILENAME ~ /floor_full/ && /^W2-MODE/ { a = substr($2, 3) + 0; c = substr($3, 3) + 0; split($4, t, "="); B0[a, c] = t[2] + 0; if (a > L) L = a }
FILENAME ~ /floor_full/ && /^W2-COEF j2=1 / { split($3, t, "="); AH = t[2] + 0 }
FILENAME ~ /floor_full/ && /^W2-COEF j2=2 / { split($3, t, "="); A1 = t[2] + 0 }
FILENAME ~ /floor_jk/ && /W2-MODE/ { k = substr($1, 3) + 0; if (k > NB) NB = k; a = substr($3, 3) + 0; c = substr($4, 3) + 0; split($5, t, "="); J[k, a, c] = t[2] + 0 }
END {
  for (a = 0; a <= L; a++) for (c = 0; c <= L; c++) { if (a + c == 0) continue; s = 0; q = 0; for (k = 1; k <= NB; k++) { s += J[k, a, c]; q += J[k, a, c] ^ 2 }
    m = s / NB; v = (NB - 1) / NB * (q - NB * m * m); if (v < 0) v = 0; SE[a, c] = sqrt(v)
    if (a <= 2 && c <= 2 || (a == 2 || c == 2)) printf "ALLMODES (%d,%d) bhat = %+.4e +- %.2e\n", a, c, B0[a, c], SE[a, c] }
  rhh = B0[1, 1] / (2 * AH) ^ 2; rhhu = (abs(B0[1, 1]) + 2 * SE[1, 1]) / (2 * AH) ^ 2
  printf "SHARP a'_1/2 = %.6e ; r_hh = bhat(1,1)/(2a'_1/2)^2 = %+.4f (upper end %.4f)\n", AH, rhh, rhhu
  printf "SHARP (1,1) bond share |bhat(2,2)|^1/2 = %.4e (upper end %.4e) ; (1/2,1) share |bhat(2,1)|^1/2 = %.4e (upper end %.4e)\n", sqrt(abs(B0[2, 2])), sqrt(abs(B0[2, 2]) + 2 * SE[2, 2]), sqrt(abs(B0[2, 1])), sqrt(abs(B0[2, 1]) + 2 * SE[2, 1]) }
