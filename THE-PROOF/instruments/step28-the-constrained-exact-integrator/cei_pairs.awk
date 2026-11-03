# cei_pairs.awk -- the dropped pair terms of the diagonal exterior model, ranked: R = S - P_kept off its diagonal, from cei_dtn's output
# (DTN-S rows, DTN-KEFF rows give x y z d and S_ii - kappa_i = PK_ii; the off-diagonal of P_kept is the face and corner plaquettes' -1/+1 entries,
# re-derived here from the link table: two object links share a kept plaquette iff they are two sides of one face or corner plaquette)
/^  DTN-S/ { n++; for (c = 1; c <= 22; c++) S[n, c] = $(c + 1) + 0 }
/^  DTN-KEFF/ { m++; X[m] = $2; Y[m] = $3; Z[m] = $4; DIR[m] = $5; NF4[m] = $6; NC2[m] = $7 }
function isobj(x, y, z, mu) { if (mu == 1) return (z == 0 && x >= 0 && x <= 1 && y >= 0 && y <= 2); if (mu == 2) return ((z == 0 && x >= 0 && x <= 2 && y >= 0 && y <= 1) || (x == 0 && z >= 0 && z <= 2 && y >= 0 && y <= 1)); if (mu == 3) return (x == 0 && y >= 0 && y <= 2 && z >= 0 && z <= 1); return 0 }
function idx(x, y, z, mu,   i) { for (i = 1; i <= 22; i++) if (X[i] == x && Y[i] == y && Z[i] == z && DIR[i] == mu) return i; return 0 }
END {
  # the kept off-diagonal: every plaquette (base b, directions mu < nu) in the box around the object; its four links with signs +,+,-,-
  for (x = -1; x <= 2; x++) for (y = -1; y <= 2; y++) for (z = -1; z <= 2; z++) for (t = -1; t <= 0; t++) for (mu = 1; mu <= 4; mu++) for (nu = mu + 1; nu <= 4; nu++) {
    b[1] = x; b[2] = y; b[3] = z; b[4] = t; for (k = 1; k <= 4; k++) q[k] = b[k]
    L[1] = (t == 0 && mu <= 3) ? idx(b[1], b[2], b[3], mu) : 0; q[mu]++; L[2] = (q[4] == 0 && nu <= 3) ? idx(q[1], q[2], q[3], nu) : 0
    for (k = 1; k <= 4; k++) q[k] = b[k]; q[nu]++; L[3] = (q[4] == 0 && mu <= 3) ? idx(q[1], q[2], q[3], mu) : 0; L[4] = (t == 0 && nu <= 3) ? idx(b[1], b[2], b[3], nu) : 0
    sg[1] = 1; sg[2] = 1; sg[3] = -1; sg[4] = -1; nobj = 0; for (k = 1; k <= 4; k++) if (L[k]) nobj++
    if (nobj == 4 || nobj == 2) for (k = 1; k <= 4; k++) for (l = 1; l <= 4; l++) if (L[k] && L[l] && k != l) PK[L[k], L[l]] += sg[k] * sg[l] }
  tot = 0; np = 0
  for (i = 1; i <= 22; i++) for (j = i + 1; j <= 22; j++) { r = S[i, j] - PK[i, j]; np++; RI[np] = i; RJ[np] = j; RV[np] = r; tot += 2 * r * r }
  for (a = 1; a <= np; a++) for (bq = a + 1; bq <= np; bq++) if (RV[bq] * RV[bq] > RV[a] * RV[a]) { t1 = RI[a]; RI[a] = RI[bq]; RI[bq] = t1; t1 = RJ[a]; RJ[a] = RJ[bq]; RJ[bq] = t1; t2 = RV[a]; RV[a] = RV[bq]; RV[bq] = t2 }
  printf "CEI-PAIRS the dropped pair terms R_ij = (S - P_kept)_ij, i < j, %d pairs, ||offdiag R||_F = %.6f; ranked by |R_ij| with the cumulative share of ||offdiag R||_F^2:\n", np, sqrt(tot)
  cum = 0; for (a = 1; a <= np; a++) { cum += 2 * RV[a] * RV[a]; i = RI[a]; j = RJ[a]; if (a <= 40 || cum / tot < 0.999) printf "  PAIR %2d  (%d,%d,%d)d%d -- (%d,%d,%d)d%d  R = %+.6f  share %.4f  cumulative %.4f\n", a, X[i], Y[i], Z[i], DIR[i], X[j], Y[j], Z[j], DIR[j], RV[a], 2 * RV[a] * RV[a] / tot, cum / tot }
  nz = 0; for (a = 1; a <= np; a++) if (RV[a] * RV[a] > 1e-12) nz++; printf "  pairs above 1e-6: %d of %d\n", nz, np }
