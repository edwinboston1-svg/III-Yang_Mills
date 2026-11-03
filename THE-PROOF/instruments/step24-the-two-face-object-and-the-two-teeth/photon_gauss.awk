# photon_gauss.awk -- THE PHOTON-CARRIED DECIDER, TOOTH 1, THE HOUSE INSTRUMENT (gawk; the author's order of 14:5x: no Python).
# The same object as photon_gauss.py, which stays in the record as the FOREIGN ANCHOR this port must reproduce: the free 4D
# lattice photon (Villain U(1) at large beta_V) with Var<J, A> = (1/beta) <J, G J>, G = (-Delta)^{-1} on Z^4, for closed
# currents J; beta = 1 throughout.  G(x) by the Bessel integral G(x) = int_0^inf dt prod_mu [I_{x_mu}(2t) e^{-2t}], every
# scaled Bessel order at one t by Miller's backward recurrence normalised by e^{z} = I_0 + 2 sum I_n (exact), Simpson on
# [0, T] and the asymptotic tail prod I ~ (4 pi t)^{-2} (1 - c/(4t) + ...) integrated in closed form beyond T.
# KNOWN ANSWERS: G(0) = 0.154933390231 (Watson); G(0) - G(e1) = 1/8 EXACTLY (the lattice Laplace equation at 0); Var(theta_p) = 1/2;
#   the anchor's integrated holonomy: one step 0.730294, two steps 0.306609; the averaged-per-direction-tree map (28.1's column,
#   relabelled by AD's Lemma A) one step 2.043488, two steps 0.690342; the proper-form ratios at R = 10 / 12, L = 2 holonomy
#   0.950106 / 0.965960, L = 4 0.938943 / 0.958053, r_inf 0.99900 / 0.99905.
# usage: gawk -f photon_gauss.awk [-v MODE=kat|run] [-v T=400] [-v NS=8000]
BEGIN {
  PI = atan2(0, -1); if (MODE == "") MODE = "kat"; if (T == "") T = 5000; if (NS == "") NS = 9900
  NMAX = 70
  printf "PHOTON(awk) mode=%s T=%g NS=%d\n", MODE, T, NS
  g0 = G4(0, 0, 0, 0); g1 = G4(1, 0, 0, 0)
  printf "KNOWN ANSWERS: G(0) = %.12f (Watson 0.154933390231)  G(0)-G(e1) = %.12f (exact 0.125)\n", g0, g0 - g1
  printf "  LAPLACE residuals (sum over neighbours - 8 G + delta): x=0 %.1e  e1 %.1e  12e1 %.1e  24e1 %.1e  48e1 %.1e  24e1+24e2 %.1e  (two-sided: a wrong tail breaks these at the large offsets)\n", laplace_res(0, 0, 0, 0), laplace_res(1, 0, 0, 0), laplace_res(12, 0, 0, 0), laplace_res(24, 0, 0, 0), laplace_res(48, 0, 0, 0), laplace_res(24, 24, 0, 0)
  nj = square_current(1, 0, 0, 0, 0, 1.0, "P"); v1 = pair("P", "P")
  printf "  Var(fine plaquette) = %.12f (equipartition 1/2)  closed %.1e\n", v1, closed("P")
  if (MODE == "kat") exit 0
  printf "(a)+(b) HOLONOMY MAP, EXTERIOR INTEGRATED (beta_eff = 1/Var; beta = 1): fine %.6f\n", 1 / v1
  square_current(2, 0, 0, 0, 0, 1.0, "H2"); v = pair("H2", "H2"); printf "  1 step, n = 2: Var = %.6f  beta_eff/beta = %.6f   (anchor 0.730294)\n", v, 1 / v
  square_current(4, 0, 0, 0, 0, 1.0, "H4"); v = pair("H4", "H4"); printf "  2 steps, n = 4: Var = %.6f  beta_eff/beta = %.6f   (anchor 0.306609)\n", v, 1 / v
  printf "(d) THE PER-DIRECTION-TREE AVERAGED MAP (28.1's column; NOT THE GROUND's one-tree map, AD Lemma A), EXTERIOR INTEGRATED\n"
  avg_plaquette(2, 0, 0, 0, 0, 1.0, "A2"); v = pair("A2", "A2"); printf "  1 step, L = 2: Var = %.6f  beta_eff/beta = %.6f  closed %.1e  (anchor 2.043488)\n", v, 1 / v, closed("A2")
  avg_plaquette(4, 0, 0, 0, 0, 1.0, "A4"); v = pair("A4", "A4"); printf "  2 steps, L = 4: Var = %.6f  beta_eff/beta = %.6f  closed %.1e  (anchor 0.690342)\n", v, 1 / v, closed("A4")
  printf "(e) TOOTH 1, PROPER FORM: coarse pair at coarse separation R vs fine pair at fine separation R (separation along axis 2)\n"
  nr = split("2 3 4 6 8 10 12", RL, " ")
  for (ir = 1; ir <= nr; ir++) { R = RL[ir] + 0
    square_current(1, 0, 0, R, 0, 1.0, "PR"); f = pair("P", "PR")
    for (L = 2; L <= 4; L += 2) {
      square_current(L, 0, 0, 0, 0, 1.0, "HL"); square_current(L, 0, 0, L * R, 0, 1.0, "HLR"); hc = pair("HL", "HLR")
      avg_plaquette(L, 0, 0, 0, 0, 1.0, "AL"); avg_plaquette(L, 0, 0, L * R, 0, 1.0, "ALR"); ac = pair("AL", "ALR")
      RAT[L, "hol", R] = hc / f; RAT[L, "avg", R] = ac / f
      printf "  R = %2d: fine %.6e | L=%d holonomy %.6e (ratio %.6f) | averaged %.6e (ratio %.6f)\n", R, f, L, hc, hc / f, ac, ac / f
    }
  }
  printf "  EXTRAPOLATION ratio(R) = r_inf - c/R^2 - d/R^4 on R = 8, 10, 12 (anchor r_inf 0.99900/0.99901 at L = 2, 0.99905/0.99905 at L = 4)\n"
  for (L = 2; L <= 4; L += 2) for (mm = 1; mm <= 2; mm++) { mp = (mm == 1) ? "hol" : "avg"
    y8 = RAT[L, mp, 8]; y10 = RAT[L, mp, 10]; y12 = RAT[L, mp, 12]
    # solve the 3x3 [1, -1/R^2, -1/R^4] system by Cramer
    a11 = 1; a12 = -1 / 64; a13 = -1 / 4096; a21 = 1; a22 = -1 / 100; a23 = -1 / 10000; a31 = 1; a32 = -1 / 144; a33 = -1 / 20736
    det = a11 * (a22 * a33 - a23 * a32) - a12 * (a21 * a33 - a23 * a31) + a13 * (a21 * a32 - a22 * a31)
    rinf = (y8 * (a22 * a33 - a23 * a32) - a12 * (y10 * a33 - a23 * y12) + a13 * (y10 * a32 - a22 * y12)) / det
    printf "    L=%d %s: r_inf = %.5f\n", L, mp, rinf
  }
  exit 0
}

# ---------------------------------------------------------------- scaled Bessel I_n(z) e^{-z}, n = 0..NMAX, by Miller's backward recurrence
# the corrected Miller recurrence: keep every order of the backward recurrence, normalise over all of them
function bessel_scaled(z,   n, start, ip1, i0, k, im1, nrm) {
  if (z < 1e-12) { for (n = 0; n <= NMAX; n++) BI[n] = (n == 0) ? 1 : 0; return }
  start = NMAX + 40 + int(3 * sqrt(z) + z / 3)
  # the recurrence writes RR[0 .. start-1] and the normalisation reads RR[0 .. start]: RR[start] must be this call's zero, not a stale value
  # of an earlier call at a larger argument (found 19:5x: with the reach at T = 5000 the stale element at the small arguments of the next
  # offset's panel swamped the normalisation -- G(0) - G(e1) read 0.1528 against the exact 1/8; at T = 400 it happened to be negligible)
  delete RR
  ip1 = 0; i0 = 1e-300
  for (k = start; k >= 1; k--) { im1 = ip1 + (2 * k / z) * i0; RR[k - 1] = im1; ip1 = i0; i0 = im1
    if (i0 > 1e200) { ip1 /= 1e200; i0 /= 1e200; for (n = k - 1; n <= start; n++) RR[n] /= 1e200 } }
  nrm = RR[0]; for (n = 1; n <= start; n++) nrm += 2 * RR[n]
  for (n = 0; n <= NMAX; n++) BI[n] = RR[n] / nrm
}
# G(x): the 4D lattice Green function, cached by the sorted absolute offsets
function G4(a, b, c, d,   key, s, i, j, t, h, sum, w, n0, n1, n2, n3, f, cc, tail, cnt, TB, N1, N2, s2) {
  a = (a < 0) ? -a : a; b = (b < 0) ? -b : b; c = (c < 0) ? -c : c; d = (d < 0) ? -d : d
  key = sort4(a, b, c, d)
  if (key in GC) return GC[key]
  split(key, Q, ","); n0 = Q[1]; n1 = Q[2]; n2 = Q[3]; n3 = Q[4]
  if (n3 > NMAX) { printf "REFUSED: offset %s beyond NMAX %d\n", key, NMAX; exit 2 }
  # three Simpson panels: [0, TB] fine (the e^{-8t} boundary layer), [TB, TM] at h = 0.05 (the orders' rise, I_n(2t) e^{-2t} ~ e^{-n^2/(4t)}),
  # [TM, T] at h = (T - TM)/NS (the t^{-2} decay); the tail beyond T from the large-argument expansion of each factor to second order.
  # THE FIRST RUN OF RECORD'S DEFECT (2026-11-02 19:4x): T = 400 with the tail to first order is a divergent series at the orders the coarse
  # correlations need -- (4n^2 - 1)/(16 T) = 1.44 at n = 48 -- so every G at an offset past ~12 was wrong (the L = 4, R = 12 ratio read 1.55
  # against the anchor's 0.958); the expansion is valid only for T >> n^2/4, so T = 5000 (0.115 at n = 48, the second-order term 0.0066).
  TB = 4; TM = 50; N1 = 16000; NM = 920; N2 = NS; sum = 0
  h = TB / N1
  for (i = 0; i <= N1; i++) { t = i * h; bessel_scaled(2 * t); f = BI[n0] * BI[n1] * BI[n2] * BI[n3]; w = (i == 0 || i == N1) ? 1 : ((i % 2) ? 4 : 2); sum += w * f }
  sum *= h / 3
  h = (TM - TB) / NM; s2 = 0
  for (i = 0; i <= NM; i++) { t = TB + i * h; bessel_scaled(2 * t); f = BI[n0] * BI[n1] * BI[n2] * BI[n3]; w = (i == 0 || i == NM) ? 1 : ((i % 2) ? 4 : 2); s2 += w * f }
  sum += s2 * h / 3
  h = (T - TM) / N2; s2 = 0
  for (i = 0; i <= N2; i++) { t = TM + i * h; bessel_scaled(2 * t); f = BI[n0] * BI[n1] * BI[n2] * BI[n3]; w = (i == 0 || i == N2) ? 1 : ((i % 2) ? 4 : 2); s2 += w * f }
  sum += s2 * h / 3
  # each factor: I_n(z) e^{-z} sqrt(2 pi z) = 1 - (mu-1)/(8z) + (mu-1)(mu-9)/(2 (8z)^2) - ...  with mu = 4 n^2 and z = 2t; the product of the four
  # = 1 - A/t + B/t^2 + O(1/t^3), A = sum (mu_i - 1)/16, B = sum (mu_i - 1)(mu_i - 9)/512 + sum_{i<j} a_i a_j; and (2 pi 2t)^{-2} = 1/(16 pi^2 t^2)
  split(n0 "," n1 "," n2 "," n3, NN, ","); A = 0; B = 0
  for (i = 1; i <= 4; i++) { mu = 4 * NN[i] * NN[i]; AA[i] = (mu - 1) / 16; A += AA[i]; B += (mu - 1) * (mu - 9) / 512 }
  for (i = 1; i <= 4; i++) for (j = i + 1; j <= 4; j++) B += AA[i] * AA[j]
  tail = (1 / (16 * PI * PI)) * (1 / T - A / (2 * T * T) + B / (3 * T * T * T))
  GC[key] = sum + tail
  return GC[key]
}
# the lattice Laplace identity sum_mu [G(x + e_mu) + G(x - e_mu)] - 8 G(x) = -delta_{x,0}, a two-sided known answer at every scale of offset
function laplace_res(a, b, c, d,   s) { s = G4(a + 1, b, c, d) + G4(a - 1, b, c, d) + G4(a, b + 1, c, d) + G4(a, b - 1, c, d) + G4(a, b, c + 1, d) + G4(a, b, c - 1, d) + G4(a, b, c, d + 1) + G4(a, b, c, d - 1) - 8 * G4(a, b, c, d)
  return s + ((a == 0 && b == 0 && c == 0 && d == 0) ? 1 : 0) }
function sort4(a, b, c, d,   v, i, j, tmp) { v[1] = a; v[2] = b; v[3] = c; v[4] = d
  for (i = 1; i <= 4; i++) for (j = i + 1; j <= 4; j++) if (v[j] < v[i]) { tmp = v[i]; v[i] = v[j]; v[j] = tmp }
  return v[1] "," v[2] "," v[3] "," v[4] }

# ---------------------------------------------------------------- currents: C[name, x0,x1,x2,x3, mu] = weight (a link from x in direction mu)
function step(name, x0, x1, x2, x3, mu, sgn, w,   k) {   # walk one link from x in direction sgn*mu with weight w; updates X0..X3 to the new site
  if (sgn > 0) { k = name SUBSEP x0 SUBSEP x1 SUBSEP x2 SUBSEP x3 SUBSEP mu; CUR[k] += w; CN[name] = 1
    X0 = x0 + (mu == 0); X1 = x1 + (mu == 1); X2 = x2 + (mu == 2); X3 = x3 + (mu == 3) }
  else { X0 = x0 - (mu == 0); X1 = x1 - (mu == 1); X2 = x2 - (mu == 2); X3 = x3 - (mu == 3)
    k = name SUBSEP X0 SUBSEP X1 SUBSEP X2 SUBSEP X3 SUBSEP mu; CUR[k] -= w; CN[name] = 1 }
}
function clear_current(name,   k, parts) { for (k in CUR) { split(k, parts, SUBSEP); if (parts[1] == name) delete CUR[k] } }
function square_current(n, x0, x1, x2, x3, w, name,   i) {   # the boundary of the n x n square at x in the (0,1) plane
  clear_current(name); X0 = x0; X1 = x1; X2 = x2; X3 = x3
  for (i = 0; i < n; i++) step(name, X0, X1, X2, X3, 0, +1, w)
  for (i = 0; i < n; i++) step(name, X0, X1, X2, X3, 1, +1, w)
  for (i = 0; i < n; i++) step(name, X0, X1, X2, X3, 0, -1, w)
  for (i = 0; i < n; i++) step(name, X0, X1, X2, X3, 1, -1, w)
}
# the per-direction-tree averaged coarse link from X0 to X0 + L e_mu: the average over the L^3 transverse offsets y of the staircase
# X0 -> X0+y -> X0+y+L e_mu -> X0 + L e_mu (transverse legs in a fixed order out and back) -- 28.1's map, not THE GROUND's
function avg_link(name, x0, x1, x2, x3, mu, L, w,   tr, ntr, y1, y2, y3, ww, d, k, i, YY) {
  ntr = 0; for (d = 0; d < 4; d++) if (d != mu) tr[++ntr] = d
  for (y1 = 0; y1 < L; y1++) for (y2 = 0; y2 < L; y2++) for (y3 = 0; y3 < L; y3++) {
    YY[1] = y1; YY[2] = y2; YY[3] = y3; ww = w / (L * L * L); X0 = x0; X1 = x1; X2 = x2; X3 = x3
    for (d = 1; d <= 3; d++) for (k = 0; k < YY[d]; k++) step(name, X0, X1, X2, X3, tr[d], +1, ww)
    for (i = 0; i < L; i++) step(name, X0, X1, X2, X3, mu, +1, ww)
    for (d = 1; d <= 3; d++) for (k = 0; k < YY[d]; k++) step(name, X0, X1, X2, X3, tr[d], -1, ww)
  }
}
function avg_plaquette(L, x0, x1, x2, x3, w, name) {   # A -> B (mu=0) -> C (nu=1) -> D -> A
  clear_current(name)
  avg_link(name, x0, x1, x2, x3, 0, L, w)             # A -> B
  avg_link(name, x0 + L, x1, x2, x3, 1, L, w)         # B -> C
  avg_link(name, x0, x1 + L, x2, x3, 0, L, -w)        # D -> C reversed
  avg_link(name, x0, x1, x2, x3, 1, L, -w)            # A -> D reversed
}
function closed(name,   k, parts, x0, x1, x2, x3, mu, c, mx, s) {   # the divergence must vanish at every site
  delete DIV
  for (k in CUR) { split(k, parts, SUBSEP); if (parts[1] != name) continue; c = CUR[k]; if (c == 0) continue
    x0 = parts[2]; x1 = parts[3]; x2 = parts[4]; x3 = parts[5]; mu = parts[6]
    DIV[x0 "," x1 "," x2 "," x3] -= c
    DIV[(x0 + (mu == 0)) "," (x1 + (mu == 1)) "," (x2 + (mu == 2)) "," (x3 + (mu == 3))] += c }
  mx = 0; for (s in DIV) { c = DIV[s]; if (c < 0) c = -c; if (c > mx) mx = c }
  return mx
}
function pair(n1, n2,   k1, k2, p1, p2, s, c1, c2) {   # <J1, G J2> = sum over links of the same direction of c1 c2 G(x1 - x2)
  s = 0
  for (k1 in CUR) { split(k1, p1, SUBSEP); if (p1[1] != n1) continue; c1 = CUR[k1]; if (c1 == 0) continue
    for (k2 in CUR) { split(k2, p2, SUBSEP); if (p2[1] != n2) continue; if (p2[6] != p1[6]) continue; c2 = CUR[k2]; if (c2 == 0) continue
      s += c1 * c2 * G4(p1[2] - p2[2], p1[3] - p2[3], p1[4] - p2[4], p1[5] - p2[5]) } }
  return s
}
