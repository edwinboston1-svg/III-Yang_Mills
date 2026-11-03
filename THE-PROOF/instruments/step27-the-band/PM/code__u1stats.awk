# u1stats.awk -- the reader of u1mh's records: per configuration "k plaq PLAIN Re[m][q] (15) MH Re[m][q] (15) MH Im[m][q] (15)", m in 0..2,
# q in -2..2 (m-major).  Binned means and errors of the MH channels; the folded (C-even) table T[m][n] = E[e_m(A) e_n(B)], e_m = sqrt(2) cos m Phi
# (T[m][n] = Re E[e^{i(mA+nB)}] + Re E[e^{i(mA-nB)}] for m, n >= 1; T[m][0] = sqrt(2) Re E[e^{imA}]), its connected moments by jackknife over
# bins, the 2D exact law with -v EXACT2D=1 -v BETA= -v N=, and the table in U1-CLASS lines for u1modes.awk (with -v EMIT=1).
# usage: gawk -v B=10 [-v EXACT2D=1 -v BETA= -v N=] [-v EMIT=1] -f u1stats.awk record.txt
function bes(m, x,   t, s, k, i) { if (m < 0) m = -m; t = 1; for (i = 1; i <= m; i++) t *= (x / 2) / i; s = 0; for (k = 0; k < 400; k++) { s += t; t *= (x / 2) * (x / 2) / ((k + 1) * (k + m + 1)); if (t < 1e-20 * s) break } return s }
function abs(x) { return x < 0 ? -x : x }
function idx(m, q) { return 3 + 15 + 5 * m + (q + 2) }     # the MH Re field
function fold(Mv, m, n) { if (m == 0 && n == 0) return 1; if (n == 0) return sqrt(2) * Mv[m, 0]; if (m == 0) return sqrt(2) * Mv[0, n]; return Mv[m, n] + Mv[m, -n] }
/^#/ { next }
NF >= 47 { nc++; P[nc] = $2; for (m = 0; m <= 2; m++) for (q = -2; q <= 2; q++) { X[nc, m, q] = $(idx(m, q)); XI[nc, m, q] = $(idx(m, q) + 15) } }
END {
  if (!B) B = 10; nb = int(nc / B); if (nb < 2) { print "U1STATS REFUSED: fewer than two bins"; exit 2 }
  for (b = 1; b <= nb; b++) { pb[b] = 0; for (m = 0; m <= 2; m++) for (q = -2; q <= 2; q++) Y[b, m, q] = 0
    for (i = (b - 1) * B + 1; i <= b * B; i++) { pb[b] += P[i] / B; for (m = 0; m <= 2; m++) for (q = -2; q <= 2; q++) Y[b, m, q] += X[i, m, q] / B } }
  s = 0; qq = 0; for (b = 1; b <= nb; b++) { s += pb[b]; qq += pb[b] ^ 2 } mp = s / nb; printf "U1STATS configs=%d bins=%d (B=%d) plaquette %.6f +- %.6f\n", nc, nb, B, mp, sqrt((qq / nb - mp * mp) / (nb - 1))
  for (m = 0; m <= 2; m++) for (q = -2; q <= 2; q++) { s = 0; qq = 0; for (b = 1; b <= nb; b++) { s += Y[b, m, q]; qq += Y[b, m, q] ^ 2 } MN[m, q] = s / nb; ER[m, q] = sqrt((qq / nb - MN[m, q] ^ 2) / (nb - 1))
    si = 0; for (i = 1; i <= nc; i++) si += XI[i, m, q]; line = sprintf("U1STATS MH Re E[e^{i(%d A %+d B)}] = %+.6e +- %.2e  (Im mean %+.1e)", m, q, MN[m, q], ER[m, q], si / nc)
    if (EXACT2D) { e = (bes(m, BETA) / bes(0, BETA)) ^ (N * N) * (bes(q, BETA) / bes(0, BETA)) ^ (N * N); line = line sprintf("  EXACT2D %+.6e (%+.2f sigma)", e, (MN[m, q] - e) / (ER[m, q] > 0 ? ER[m, q] : 1)) }
    print line }
  # folded table, connected by jackknife
  for (m = 0; m <= 2; m++) for (n = 0; n <= 2; n++) { for (mm = 0; mm <= 2; mm++) for (q = -2; q <= 2; q++) Mv[mm, q] = MN[mm, q]
    T = fold(Mv, m, n); CF = T - fold(Mv, m, 0) * fold(Mv, 0, n); js = 0; jq = 0
    for (b = 1; b <= nb; b++) { for (mm = 0; mm <= 2; mm++) for (q = -2; q <= 2; q++) Jv[mm, q] = (MN[mm, q] * nb - Y[b, mm, q]) / (nb - 1)
      jt = fold(Jv, m, n) - fold(Jv, m, 0) * fold(Jv, 0, n); js += jt; jq += jt * jt; jtt[b] = fold(Jv, m, n) }
    jm = js / nb; jv = (nb - 1) / nb * (jq - nb * jm * jm); if (jv < 0) jv = 0
    s = 0; for (b = 1; b <= nb; b++) s += jtt[b]; s /= nb; v = 0; for (b = 1; b <= nb; b++) v += (jtt[b] - s) ^ 2; v *= (nb - 1) / nb
    TAB[m, n] = T; printf "U1STATS FOLDED T[%d][%d] = %+.6e +- %.2e   connected %+.6e +- %.2e\n", m, n, T, sqrt(v), CF, sqrt(jv) }
  if (EMIT) for (m = 0; m <= 2; m++) for (n = 0; n <= 2; n++) printf "U1-CLASS m=%d n=%d T = %+.12e\n", m, n, TAB[m, n] }
