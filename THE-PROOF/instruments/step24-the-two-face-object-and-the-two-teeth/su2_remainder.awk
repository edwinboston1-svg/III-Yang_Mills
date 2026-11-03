# su2_remainder.awk -- THE PHOTON-CARRIED DECIDER, TOOTH 2, THE HOUSE INSTRUMENT (gawk; the author's order of 14:5x: no Python,
# .iii or awk).  The same object as su2_remainder.py, which stays in the record as the FOREIGN ANCHOR this port must reproduce:
#   the colour-3 photon theta(x) = eps cos(p x_0) on the links of direction `bg` of SU(2) Wilson; the charged pair w = x1 + i x2
#   and its ghosts integrated at Gaussian order around it; Gamma''(0) = d^2/d eps^2 [ln det K_w - 2 ln det M_gh];
#   beta_eff(p) = beta + 8 Gamma''/(V p_hat^2); the drift per L = 2 step D(p) = shift(p/2) - shift(p) -> -8 b0 ln 2 = -0.257512.
# NO HAND-DERIVED FEYNMAN RULE: the quadratic form is the exact second-order expansion of Re Tr U_p at the abelian background,
# (8/beta) S_2 = sum_p [cos(theta_p/2)|s_p|^2 - 2 s sin(theta_p/2) sum_{i<j} Im(conj(w_i) w_j)] + (1/xi) sum_x |(D.w)(x)|^2,
# every coefficient a trigonometric polynomial of degree <= 2 in the background's phase, read by Fourier projection over
# MS = 8 phase samples (exact for degree <= 2; modes 3 and 4 must vanish), carried as eps-jets to order 2.
# Known answers (the anchor's records): pure gauge (bg = 0) Gamma'' = 0; K0 = khat^2 I at xi = 1; N = 8, m = 2, bg = 1:
#   Gamma''_gl/V = -2.531357423902959e-01, ghost part -6.329260284330156e-03 (spin 1, xi 1); spin 0: -1.739012705359546e-01;
#   xi = 2: -2.846037386789051e-01 -- all four to 1e-12 or the port is wrong.
# usage: gawk -f su2_remainder.awk -v N=32 -v M=1,2,4,8 [-v SPIN=1] [-v XI=1] [-v GHOSTS=1] [-v BG=1] [-v SYM=1]
BEGIN {
  PI = atan2(0, -1); MS = 8; CHG = -1
  for (s = 0; s < MS; s++) PHI[s] = 2 * PI * s / MS
  if (N == "") N = 8; if (M == "") M = "1,2"; if (SPIN == "") SPIN = 1; if (XI == "") XI = 1
  if (GHOSTS == "") GHOSTS = 1; if (BG == "") BG = 1; if (SYM == "") SYM = 1
  nm = split(M, MLIST, ",")
  printf "RUN(awk) N=%d m=[%s] spin=%g xi=%g ghosts=%d bg=%d sym=%d\n", N, M, SPIN, XI, GHOSTS, BG, SYM
  for (im = 1; im <= nm; im++) {
    m = MLIST[im] + 0; p = 2 * PI * m / N
    t0 = systime()
    gamma2(p, BG, SPIN, XI, GHOSTS, SYM)   # sets G_GL, G_GH, HERM, K0D, ALIAS, IMAG
    ph2 = 4 * sin(p / 2) ^ 2
    tot = 8 * (G_GL + G_GH) / ph2
    SHIFT[m] = tot
    printf "  m=%3d p=%.6f  beta_eff - beta = % .9f  (gluon % .9f, ghost % .9f)  herm %.1e K0 %.1e alias %.1e imag %.1e  (%ds)\n", m, p, tot, 8 * G_GL / ph2, 8 * G_GH / ph2, HERM, K0D, ALIAS, IMAG, systime() - t0
    printf "  Gamma''_gl/V = %.15e  ghost part = %.15e\n", G_GL, G_GH
  }
  printf "  DRIFT PER STEP D(p) = shift(p/2) - shift(p)  [stake -0.257512]:\n"
  for (im = 1; im <= nm; im++) { m = MLIST[im] + 0; if (m % 2 == 0 && ((m / 2) in SHIFT)) printf "    p = %.6f (m %d -> %d): D = % .9f\n", 2 * PI * m / N, m, m / 2, SHIFT[m / 2] - SHIFT[m] }
  exit 0
}

# ---------------------------------------------------------------- jets over the phase samples: JR[id,o,s], JI[id,o,s], o = 0,1,2
function jet_one(id,   s) { for (s = 0; s < MS; s++) { JR[id, 0, s] = 1; JI[id, 0, s] = 0; JR[id, 1, s] = 0; JI[id, 1, s] = 0; JR[id, 2, s] = 0; JI[id, 2, s] = 0 } }
function jet_exp(id, b,   s) {   # exp(i CHG eps b[s]) to order 2: (1, i C b, -b^2/2)
  for (s = 0; s < MS; s++) { JR[id, 0, s] = 1; JI[id, 0, s] = 0; JR[id, 1, s] = 0; JI[id, 1, s] = CHG * b[s]; JR[id, 2, s] = -0.5 * b[s] * b[s]; JI[id, 2, s] = 0 }
}
function jet_scale(id, src, fr, fi,   o, s, xr, xi) {   # id = (fr + i fi) * src
  for (o = 0; o < 3; o++) for (s = 0; s < MS; s++) { xr = JR[src, o, s]; xi = JI[src, o, s]; JR[id, o, s] = fr * xr - fi * xi; JI[id, o, s] = fr * xi + fi * xr }
}
function jet_conj(id, src,   o, s) { for (o = 0; o < 3; o++) for (s = 0; s < MS; s++) { JR[id, o, s] = JR[src, o, s]; JI[id, o, s] = -JI[src, o, s] } }
function jet_mul(id, a, b,   s, ar0, ai0, ar1, ai1, ar2, ai2, br0, bi0, br1, bi1, br2, bi2) {   # (a0 b0, a0 b1 + a1 b0, a0 b2 + a1 b1 + a2 b0)
  for (s = 0; s < MS; s++) {
    ar0 = JR[a, 0, s]; ai0 = JI[a, 0, s]; ar1 = JR[a, 1, s]; ai1 = JI[a, 1, s]; ar2 = JR[a, 2, s]; ai2 = JI[a, 2, s]
    br0 = JR[b, 0, s]; bi0 = JI[b, 0, s]; br1 = JR[b, 1, s]; bi1 = JI[b, 1, s]; br2 = JR[b, 2, s]; bi2 = JI[b, 2, s]
    JR[id, 0, s] = ar0 * br0 - ai0 * bi0;                               JI[id, 0, s] = ar0 * bi0 + ai0 * br0
    JR[id, 1, s] = ar0 * br1 - ai0 * bi1 + ar1 * br0 - ai1 * bi0;         JI[id, 1, s] = ar0 * bi1 + ai0 * br1 + ar1 * bi0 + ai1 * br0
    JR[id, 2, s] = ar0 * br2 - ai0 * bi2 + ar1 * br1 - ai1 * bi1 + ar2 * br0 - ai2 * bi0
    JI[id, 2, s] = ar0 * bi2 + ai0 * br2 + ar1 * bi1 + ai1 * br1 + ar2 * bi0 + ai2 * br0
  }
}
function jet_set(id, r0, r1, r2, ir1,   s) {   # a jet with sample-dependent entries given as arrays (real part arrays, imag part of order 1)
  for (s = 0; s < MS; s++) { JR[id, 0, s] = r0[s]; JI[id, 0, s] = 0; JR[id, 1, s] = r1[s]; JI[id, 1, s] = ir1[s]; JR[id, 2, s] = r2[s]; JI[id, 2, s] = 0 }
}

# ---------------------------------------------------------------- the form table: FR[key,o,s], FI[key,o,s]; key = i|j|vb|vk
function vkey(a, b, c, d) { return a "," b "," c "," d }
function form_add(i, j, vb, vk, jet,   key, o, s) {
  key = i SUBSEP j SUBSEP vb SUBSEP vk
  if (!(key in KEYS)) { KEYS[key] = ++NKEY; KI[NKEY] = i; KJ[NKEY] = j; KVB[NKEY] = vb; KVK[NKEY] = vk; KEYOF[NKEY] = key }
  for (o = 0; o < 3; o++) for (s = 0; s < MS; s++) { FR[key, o, s] += JR[jet, o, s]; FI[key, o, s] += JI[jet, o, s] }
}
function form_clear(   k) { delete KEYS; delete FR; delete FI; delete FFR; delete FFI; NKEY = 0 }
function form_fourier(   k, key, n, o, s, re, im, c, sn, a, nv, v) {   # F[key][n][o] = (1/MS) sum_s F(o,s) e^{-i n phi_s}
  ALIAS = 0
  for (k = 1; k <= NKEY; k++) { key = KEYOF[k]
    nv = split(KVB[k], v, ","); KB0[k] = v[1]; KB1[k] = v[2]; KB2[k] = v[3]; KB3[k] = v[4]    # the offsets parsed once, not per momentum
    nv = split(KVK[k], v, ","); KK0[k] = v[1]; KK1[k] = v[2]; KK2[k] = v[3]; KK3[k] = v[4]
    for (n = -4; n <= 4; n++) for (o = 0; o < 3; o++) {
      re = 0; im = 0
      for (s = 0; s < MS; s++) { c = cos(n * PHI[s]); sn = -sin(n * PHI[s]); re += FR[key, o, s] * c - FI[key, o, s] * sn; im += FR[key, o, s] * sn + FI[key, o, s] * c }
      FFR[k, n, o] = re / MS; FFI[k, n, o] = im / MS
      if (n >= 3 || n <= -3) { a = sqrt(re * re + im * im) / MS; if (a > ALIAS) ALIAS = a }
    }
  }
}
# evaluate the form between bra e^{i kb.x} and ket e^{i kk.x} at mode n, order o: OUT[i,j] += c * exp(-i kb.vb + i kk.vk), dim x dim
function form_eval(kb0, kb1, kb2, kb3, kk0, kk1, kk2, kk3, o, n, dim,   i, j, k, cr, ci, ph, er, ei, nv, v) {
  for (i = 0; i < dim; i++) for (j = 0; j < dim; j++) { OR[i, j] = 0; OI[i, j] = 0 }
  for (k = 1; k <= NKEY; k++) {
    cr = FFR[k, n, o]; ci = FFI[k, n, o]
    if (cr * cr + ci * ci < 1e-30) continue
    ph = kk0 * KK0[k] + kk1 * KK1[k] + kk2 * KK2[k] + kk3 * KK3[k] - (kb0 * KB0[k] + kb1 * KB1[k] + kb2 * KB2[k] + kb3 * KB3[k])
    er = cos(ph); ei = sin(ph)
    OR[KI[k], KJ[k]] += cr * er - ci * ei; OI[KI[k], KJ[k]] += cr * ei + ci * er
  }
}

# ---------------------------------------------------------------- the forms
function gluon_form(p, bg, spin, xi,   mu, nu, s, ba, bb, bc, bd, bp, a, b, cosj, pre, ia, ib, va, vb, tmp, tmp2, gi, gj, bgf) {
  form_clear()
  for (mu = 0; mu < 4; mu++) for (nu = mu + 1; nu < 4; nu++) {
    for (s = 0; s < MS; s++) {
      BA[s] = (mu == bg) * cos(PHI[s]); BB[s] = (nu == bg) * cos(PHI[s] + p * (mu == 0))
      BC[s] = (mu == bg) * cos(PHI[s] + p * (nu == 0)); BD[s] = (nu == bg) * cos(PHI[s])
      BP[s] = BA[s] + BB[s] - BC[s] - BD[s]; ABC[s] = BA[s] + BB[s] - BC[s]
    }
    # the four transported fluctuations r_a = (index, site offset, jet): w_mu(x), e^{iC ba} w_nu(x+mu), -e^{iC(ba+bb-bc)} w_mu(x+nu), -e^{iC bp} w_nu(x)
    RI[0] = mu; RV[0] = vkey(0, 0, 0, 0);            jet_one("c0")
    RI[1] = nu; RV[1] = unitv(mu);                   jet_exp("c1", BA)
    RI[2] = mu; RV[2] = unitv(nu);                   jet_exp("t2", ABC); jet_scale("c2", "t2", -1, 0)
    RI[3] = nu; RV[3] = vkey(0, 0, 0, 0);            jet_exp("t3", BP);  jet_scale("c3", "t3", -1, 0)
    for (s = 0; s < MS; s++) { Z0[s] = 1; Z1[s] = 0; Z2[s] = -BP[s] * BP[s] / 8; ZI[s] = 0 }
    jet_set("cosj", Z0, Z1, Z2, ZI)                   # cos(theta_p/2) = 1 - (eps bp)^2/8 to order 2
    for (a = 0; a < 4; a++) for (b = 0; b < 4; b++) {
      jet_conj("ca", "c" a); jet_mul("tmp", "ca", "c" b); jet_mul("tmp2", "cosj", "tmp")
      form_add(RI[a], RI[b], RV[a], RV[b], "tmp2")
    }
    for (s = 0; s < MS; s++) { Z0[s] = 0; Z1[s] = -2 * spin * BP[s] / 2; Z2[s] = 0; ZI[s] = 0 }
    jet_set("pre", Z0, Z1, Z2, ZI)                    # -2 s sin(theta_p/2) = -2 s (eps bp / 2) to order 1
    for (a = 0; a < 4; a++) for (b = a + 1; b < 4; b++) {
      jet_conj("ca", "c" a); jet_mul("tmp", "ca", "c" b); jet_mul("tmp2", "pre", "tmp"); jet_scale("tmp3", "tmp2", 0, -0.5)   # /(2i) = * (-i/2)
      form_add(RI[a], RI[b], RV[a], RV[b], "tmp3")
      jet_conj("cb", "c" b); jet_mul("tmp", "cb", "c" a); jet_mul("tmp2", "pre", "tmp"); jet_scale("tmp3", "tmp2", 0, 0.5)    # -(.)/(2i) = * (i/2)
      form_add(RI[b], RI[a], RV[b], RV[a], "tmp3")
    }
  }
  # the gauge fixing (1/xi) |D.w|^2 with (D.w)(x) = sum_mu [w_mu(x) - e^{-iC th_mu(x-mu)} w_mu(x-mu)]
  for (mu = 0; mu < 4; mu++) {
    for (s = 0; s < MS; s++) BGF[s] = -((mu == bg) * cos(PHI[s] - p * (mu == 0)))
    GI[mu, 0] = mu; GV[mu, 0] = vkey(0, 0, 0, 0); jet_one("g" mu "_0")
    GI[mu, 1] = mu; GV[mu, 1] = negunitv(mu);     jet_exp("tg", BGF); jet_scale("g" mu "_1", "tg", -1, 0)
  }
  for (gi = 0; gi < 4; gi++) for (gj = 0; gj < 4; gj++) for (a = 0; a < 2; a++) for (b = 0; b < 2; b++) {
    jet_conj("ca", "g" gi "_" a); jet_mul("tmp", "ca", "g" gj "_" b); jet_scale("tmp2", "tmp", 1 / xi, 0)
    form_add(GI[gi, a], GI[gj, b], GV[gi, a], GV[gj, b], "tmp2")
  }
  form_fourier()
}
function ghost_form(p, bg,   mu, s, a, b) {   # D_mu c(x) = e^{iC th_mu(x)} c(x+mu) - c(x);  M = sum |D_mu c|^2
  form_clear()
  for (mu = 0; mu < 4; mu++) {
    for (s = 0; s < MS; s++) BMU[s] = (mu == bg) * cos(PHI[s])
    HV[0] = unitv(mu); jet_exp("h0", BMU)
    HV[1] = vkey(0, 0, 0, 0); jet_one("t1"); jet_scale("h1", "t1", -1, 0)
    for (a = 0; a < 2; a++) for (b = 0; b < 2; b++) { jet_conj("ca", "h" a); jet_mul("tmp", "ca", "h" b); form_add(0, 0, HV[a], HV[b], "tmp") }
  }
  form_fourier()
}
function unitv(mu) { return vkey(mu == 0, mu == 1, mu == 2, mu == 3) }
function negunitv(mu) { return vkey(-(mu == 0), -(mu == 1), -(mu == 2), -(mu == 3)) }

# ---------------------------------------------------------------- complex dim x dim linear algebra on AR/AI (copies), solve A X = B
function csolve(dim,   i, j, k, piv, pr, pi, mr, mi, br, bi, den, tr, ti) {   # in: SA (matrix), SB (rhs, dim x dim); out: SX
  for (i = 0; i < dim; i++) for (j = 0; j < dim; j++) { LR[i, j] = SAR[i, j]; LI[i, j] = SAI[i, j]; QR[i, j] = SBR[i, j]; QI[i, j] = SBI[i, j] }
  for (k = 0; k < dim; k++) {
    piv = k; mr = LR[k, k] * LR[k, k] + LI[k, k] * LI[k, k]
    for (i = k + 1; i < dim; i++) { tr = LR[i, k] * LR[i, k] + LI[i, k] * LI[i, k]; if (tr > mr) { mr = tr; piv = i } }
    if (piv != k) for (j = 0; j < dim; j++) { tr = LR[k, j]; LR[k, j] = LR[piv, j]; LR[piv, j] = tr; ti = LI[k, j]; LI[k, j] = LI[piv, j]; LI[piv, j] = ti; tr = QR[k, j]; QR[k, j] = QR[piv, j]; QR[piv, j] = tr; ti = QI[k, j]; QI[k, j] = QI[piv, j]; QI[piv, j] = ti }
    pr = LR[k, k]; pi = LI[k, k]; den = pr * pr + pi * pi
    for (i = k + 1; i < dim; i++) {
      mr = (LR[i, k] * pr + LI[i, k] * pi) / den; mi = (LI[i, k] * pr - LR[i, k] * pi) / den   # L[i,k]/L[k,k]
      for (j = k; j < dim; j++) { LR[i, j] -= mr * LR[k, j] - mi * LI[k, j]; LI[i, j] -= mr * LI[k, j] + mi * LR[k, j] }
      for (j = 0; j < dim; j++) { QR[i, j] -= mr * QR[k, j] - mi * QI[k, j]; QI[i, j] -= mr * QI[k, j] + mi * QR[k, j] }
    }
  }
  for (k = dim - 1; k >= 0; k--) {
    pr = LR[k, k]; pi = LI[k, k]; den = pr * pr + pi * pi
    for (j = 0; j < dim; j++) {
      br = QR[k, j]; bi = QI[k, j]
      for (i = k + 1; i < dim; i++) { br -= LR[k, i] * QR[i, j] - LI[k, i] * QI[i, j]; bi -= LR[k, i] * QI[i, j] + LI[k, i] * QR[i, j] }
      QR[k, j] = (br * pr + bi * pi) / den; QI[k, j] = (bi * pr - br * pi) / den
    }
  }
}
function copyA(dim,   i, j) { for (i = 0; i < dim; i++) for (j = 0; j < dim; j++) { SAR[i, j] = OR[i, j]; SAI[i, j] = OI[i, j] } }
function copyB(dim,   i, j) { for (i = 0; i < dim; i++) for (j = 0; j < dim; j++) { SBR[i, j] = OR[i, j]; SBI[i, j] = OI[i, j] } }

# the second derivative at one momentum: 2 tr(K0^-1 K2) - sum_s tr(K0^-1 K1r K0s^-1 K1); returns real part in T2R (imag in T2I), HERM updated
function second_derivative(k0, k1, k2, k3, p, dim,   i, j, s, ks0, tr, ti, h, d, tmp) {
  form_eval(k0, k1, k2, k3, k0, k1, k2, k3, 0, 0, dim); copyA(dim)
  for (i = 0; i < dim; i++) for (j = 0; j < dim; j++) { K0R[i, j] = OR[i, j]; K0I[i, j] = OI[i, j] }
  form_eval(k0, k1, k2, k3, k0, k1, k2, k3, 2, 0, dim); copyB(dim)
  csolve(dim); tr = 0; ti = 0
  for (i = 0; i < dim; i++) { tr += QR[i, i]; ti += QI[i, i] }
  T2R = 2 * tr; T2I = 2 * ti
  for (s = -1; s <= 1; s += 2) {
    ks0 = k0 + s * p
    form_eval(ks0, k1, k2, k3, ks0, k1, k2, k3, 0, 0, dim)                 # K0s
    for (i = 0; i < dim; i++) for (j = 0; j < dim; j++) { KSR[i, j] = OR[i, j]; KSI[i, j] = OI[i, j] }
    form_eval(ks0, k1, k2, k3, k0, k1, k2, k3, 1, s, dim)                   # K1 (bra k+sp, ket k, mode s)
    for (i = 0; i < dim; i++) for (j = 0; j < dim; j++) { K1R[i, j] = OR[i, j]; K1I[i, j] = OI[i, j] }
    form_eval(k0, k1, k2, k3, ks0, k1, k2, k3, 1, -s, dim)                  # K1r (bra k, ket k+sp, mode -s) = K1^H
    for (i = 0; i < dim; i++) for (j = 0; j < dim; j++) { h = sqrt((OR[i, j] - K1R[j, i]) ^ 2 + (OI[i, j] + K1I[j, i]) ^ 2); if (h > HERM) HERM = h }
    for (i = 0; i < dim; i++) for (j = 0; j < dim; j++) { SAR[i, j] = K0R[i, j]; SAI[i, j] = K0I[i, j]; SBR[i, j] = OR[i, j]; SBI[i, j] = OI[i, j] }
    csolve(dim); for (i = 0; i < dim; i++) for (j = 0; j < dim; j++) { QQR[i, j] = QR[i, j]; QQI[i, j] = QI[i, j] }   # X = K0^-1 K1r
    for (i = 0; i < dim; i++) for (j = 0; j < dim; j++) { SAR[i, j] = KSR[i, j]; SAI[i, j] = KSI[i, j]; SBR[i, j] = K1R[i, j]; SBI[i, j] = K1I[i, j] }
    csolve(dim)                                                             # Y = K0s^-1 K1 in XR/XI
    tr = 0; ti = 0
    for (i = 0; i < dim; i++) for (j = 0; j < dim; j++) { tr += QQR[i, j] * QR[j, i] - QQI[i, j] * QI[j, i]; ti += QQR[i, j] * QI[j, i] + QQI[i, j] * QR[j, i] }
    T2R -= tr; T2I -= ti
  }
}

# ---------------------------------------------------------------- the momentum sum (the antiperiodic midpoint grid; SYM: the orthant k2 <= k3, weights 16 x 1|2)
function gamma2(p, bg, spin, xi, ghosts, sym,   half, n0, n1, n2, n3, k0, k1, k2, k3, w, wsum, sg, sh, kh, i, j, d, V) {
  HERM = 0; K0D = 0; IMAG = 0; sg = 0; sh = 0; wsum = 0
  gluon_form(p, bg, spin, xi)
  for (i = 1; i <= NKEY; i++) for (j = -4; j <= 4; j++) for (d = 0; d < 3; d++) { GFR[i, j, d] = FFR[i, j, d]; GFI[i, j, d] = FFI[i, j, d] }
  GN = NKEY; for (i = 1; i <= NKEY; i++) { GKI[i] = KI[i]; GKJ[i] = KJ[i]; GVB[i] = KVB[i]; GVK[i] = KVK[i] }
  GALIAS = ALIAS
  if (ghosts) { ghost_form(p, bg); for (i = 1; i <= NKEY; i++) for (j = -4; j <= 4; j++) for (d = 0; d < 3; d++) { HFR[i, j, d] = FFR[i, j, d]; HFI[i, j, d] = FFI[i, j, d] }
    HN = NKEY; for (i = 1; i <= NKEY; i++) { HKI[i] = KI[i]; HKJ[i] = KJ[i]; HVB[i] = KVB[i]; HVK[i] = KVK[i] }; if (ALIAS > GALIAS) GALIAS = ALIAS }
  ALIAS = GALIAS
  half = sym ? N / 2 : N
  for (n0 = 0; n0 < half; n0++) { k0 = sym ? PI * (2 * n0 + 1) / N : 2 * PI * (n0 + 0.5) / N
  for (n1 = 0; n1 < half; n1++) { k1 = sym ? PI * (2 * n1 + 1) / N : 2 * PI * (n1 + 0.5) / N
  for (n2 = 0; n2 < half; n2++) { k2 = sym ? PI * (2 * n2 + 1) / N : 2 * PI * (n2 + 0.5) / N
  for (n3 = (sym ? n2 : 0); n3 < half; n3++) { k3 = sym ? PI * (2 * n3 + 1) / N : 2 * PI * (n3 + 0.5) / N
    w = sym ? (n3 > n2 ? 32 : 16) : 1; wsum += w
    use_form("G"); reparse_offsets(); second_derivative(k0, k1, k2, k3, p, 4); sg += w * T2R; if (T2I < 0) T2I = -T2I; if (T2I > IMAG) IMAG = T2I
    if (xi == 1) { kh = 4 * (sin(k0 / 2) ^ 2 + sin(k1 / 2) ^ 2 + sin(k2 / 2) ^ 2 + sin(k3 / 2) ^ 2)
      for (i = 0; i < 4; i++) for (j = 0; j < 4; j++) { d = sqrt((K0R[i, j] - (i == j ? kh : 0)) ^ 2 + K0I[i, j] ^ 2); if (d > K0D) K0D = d } }
    if (ghosts) { use_form("H"); reparse_offsets(); second_derivative(k0, k1, k2, k3, p, 1); sh += -2 * w * T2R }
  } } } }
  V = N ^ 4
  if (wsum - V > 0.5 || V - wsum > 0.5) { printf "REFUSED: grid weights sum to %g, not N^4 = %g\n", wsum, V; exit 2 }
  G_GL = sg / V; G_GH = ghosts ? sh / V : 0
}
function use_form(which,   i, j, d) {   # load the saved gluon (G) or ghost (H) Fourier table and offsets into the live arrays
  if (which == "G") { NKEY = GN; for (i = 1; i <= GN; i++) { KI[i] = GKI[i]; KJ[i] = GKJ[i]; KVB[i] = GVB[i]; KVK[i] = GVK[i]; for (j = -4; j <= 4; j++) for (d = 0; d < 3; d++) { FFR[i, j, d] = GFR[i, j, d]; FFI[i, j, d] = GFI[i, j, d] } } }
  else { NKEY = HN; for (i = 1; i <= HN; i++) { KI[i] = HKI[i]; KJ[i] = HKJ[i]; KVB[i] = HVB[i]; KVK[i] = HVK[i]; for (j = -4; j <= 4; j++) for (d = 0; d < 3; d++) { FFR[i, j, d] = HFR[i, j, d]; FFI[i, j, d] = HFI[i, j, d] } } }
}
# the saved offset vectors travel with the saved tables (use_form re-parses them from KVB/KVK)
function reparse_offsets(   k, nv, v) { for (k = 1; k <= NKEY; k++) { nv = split(KVB[k], v, ","); KB0[k] = v[1]; KB1[k] = v[2]; KB2[k] = v[3]; KB3[k] = v[4]; nv = split(KVK[k], v, ","); KK0[k] = v[1]; KK1[k] = v[2]; KK2[k] = v[3]; KK3[k] = v[4] } }
