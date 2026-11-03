# stats.awk -- the reader of su2mh's records: per-configuration lines "m plaq PLAIN[3][3] MH[3][3]" (a-major), binned (bins of B
# configurations), means with binned standard errors, the connected moments M[a,c] - M[a,0]M[0,c] by jackknife over bins, the A<->B symmetric
# (2,1)/(1,2) average (Lemma D3), and, with -v EXACT2D=1 -v BETA= -v N=, the 2D exact law d_a a_a^{n^2} d_c a_c^{n^2} beside every channel.
# usage: gawk -v B=10 [-v SKIP=0] [-v EXACT2D=1 -v BETA=2.2 -v N=2] -f stats.awk record.txt
function bes(m, x,   t, s, k, i) { t = 1; for (i = 1; i <= m; i++) t *= (x / 2) / i; s = 0; for (k = 0; k < 400; k++) { s += t; t *= (x / 2) * (x / 2) / ((k + 1) * (k + m + 1)); if (t < 1e-20 * s) break } return s }
function abs(x) { return x < 0 ? -x : x }
/^#/ { next }
NF >= 20 { if ($1 + 0 < SKIP) next; nc++; P[nc] = $2; for (k = 0; k < 18; k++) X[nc, k] = $(3 + k) }
END {
  if (!B) B = 10; nb = int(nc / B); if (nb < 2) { print "STATS REFUSED: fewer than two bins"; exit 2 }
  for (b = 1; b <= nb; b++) { pb[b] = 0; for (k = 0; k < 18; k++) Y[b, k] = 0
    for (i = (b - 1) * B + 1; i <= b * B; i++) { pb[b] += P[i] / B; for (k = 0; k < 18; k++) Y[b, k] += X[i, k] / B } }
  # means and binned errors
  for (k = -1; k < 18; k++) { s = 0; q = 0; for (b = 1; b <= nb; b++) { v = (k < 0) ? pb[b] : Y[b, k]; s += v; q += v * v } m = s / nb; var = (q / nb - m * m) * nb / (nb - 1); if (var < 0) var = 0; MEAN[k] = m; SEM[k] = sqrt(var / nb) }
  printf "STATS configs=%d bins=%d (B=%d)  plaquette %.6f +- %.6f\n", nc, nb, B, MEAN[-1], SEM[-1]
  if (EXACT2D) { for (j = 0; j <= 2; j++) aj[j] = bes(j + 1, BETA) / bes(1, BETA); for (j = 0; j <= 2; j++) ex[j] = (j + 1) * aj[j] ^ (N * N) }
  for (a = 0; a <= 2; a++) for (c = 0; c <= 2; c++) { kp = 3 * a + c; km = 9 + 3 * a + c
    # jackknife connected
    for (h = 0; h < 2; h++) { kk = h ? km : kp; k10 = (h ? 9 : 0) + 3 * a; k01 = (h ? 9 : 0) + c
      full = MEAN[kk] - MEAN[k10] * MEAN[k01]; js = 0; jq = 0
      for (b = 1; b <= nb; b++) { m1 = (MEAN[kk] * nb - Y[b, kk]) / (nb - 1); m2 = (MEAN[k10] * nb - Y[b, k10]) / (nb - 1); m3 = (MEAN[k01] * nb - Y[b, k01]) / (nb - 1); jv = m1 - m2 * m3; js += jv; jq += jv * jv }
      jm = js / nb; jvar = (nb - 1) / nb * (jq - nb * jm * jm); if (jvar < 0) jvar = 0; CONN[h, a, c] = full; CERR[h, a, c] = sqrt(jvar) }
    line = sprintf("STATS (a,c)=(%d,%d)  PLAIN %+.6e +- %.2e   MH %+.6e +- %.2e   conn PLAIN %+.4e +- %.2e  conn MH %+.4e +- %.2e", a, c, MEAN[kp], SEM[kp], MEAN[km], SEM[km], CONN[0, a, c], CERR[0, a, c], CONN[1, a, c], CERR[1, a, c])
    if (EXACT2D) { e = ex[a] * ex[c]; line = line sprintf("   EXACT2D %+.6e  (MH-exact)/err %+.2f  conn/err %+.2f", e, (MEAN[km] - e) / (SEM[km] > 0 ? SEM[km] : 1), CONN[1, a, c] / (CERR[1, a, c] > 0 ? CERR[1, a, c] : 1)) }
    print line }
  # the symmetric (2,1)/(1,2) connected moment, jackknife on the average
  for (h = 0; h < 2; h++) { o = h ? 9 : 0; js = 0; jq = 0
    full = 0.5 * ((MEAN[o + 7] - MEAN[o + 6] * MEAN[o + 1]) + (MEAN[o + 5] - MEAN[o + 3] * MEAN[o + 2]))
    for (b = 1; b <= nb; b++) { for (k = 0; k < 9; k++) jmn[k] = (MEAN[o + k] * nb - Y[b, o + k]) / (nb - 1)
      jv = 0.5 * ((jmn[7] - jmn[6] * jmn[1]) + (jmn[5] - jmn[3] * jmn[2])); js += jv; jq += jv * jv }
    jm = js / nb; jvar = (nb - 1) / nb * (jq - nb * jm * jm); if (jvar < 0) jvar = 0
    printf "STATS SYMMETRIC connected (2,1)/(1,2) %s: %+.6e +- %.3e\n", h ? "MH" : "PLAIN", full, sqrt(jvar) }
  # per-configuration spread of the MH (2,1) and symmetric estimators (the variance staked in M3)
  s = 0; q = 0; for (i = 1; i <= nc; i++) { v = 0.5 * (X[i, 9 + 7] + X[i, 9 + 5]); s += v; q += v * v } m = s / nc; printf "STATS per-configuration sd of the MH symmetric joint (2,1)/(1,2): %.4e (configs %d)\n", sqrt((q / nc - m * m) * nc / (nc - 1)), nc }
