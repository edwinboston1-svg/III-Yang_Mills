# g19_vmf.awk -- THE vMF MOMENTS ON S^3 AND THE ONE-FACE ANISOTROPY, ENCLOSED (ΠΕΝΤΑΠΥΛΟΝ G19, 2026-10-29 02:2x EDT, the desktop seat;
# iii-43's order of 02:1x carrying the plan seat's and the Yang-Mills seat's object).  gawk -M, PREC 256, every lower endpoint computed under
# ROUNDMODE "D" and every upper under "U" (checked at load: U > D on exp, 1/3, log), so no rounding is priced by hand.
# THE OBJECT.  For U ~ vMF(kappa) on S^3: m = I_2(kappa)/I_1(kappa) = E<U, e>; Var_par = 1 - 3m/kappa - m^2 (the axis coordinate's variance);
# Var_perp = m/kappa (each perpendicular coordinate's); the anisotropy A = Var_perp - Var_par; P = 1 - 4m/kappa = m^2 - A.  For W = U_b^-1 U U_a
# under independent vMF(kappa_a), vMF(kappa_b) (iii-43's closed form of 02:1x, its derivation with the Yang-Mills seat): Cov(W) = c_1 I + D g g^T,
# c_1 = Var_perp,a + P_a Var_perp,b, D = P_a P_b - m_a^2 m_b^2, |Cov W| = max(c_1, c_1 + D) <= 1/4; the face transmission's anisotropy is |D|.
# THE ENCLOSURES.  Bessel by its positive series (every truncation a lower bound, a geometric remainder the upper); m INCREASING in kappa is a
# THEOREM (m' = Var_par = the second derivative of log Z(kappa)), so m over [x_lo, x_hi] lies in [m(x_lo), m(x_hi)] and every corner value is an
# interval of two Bessel quotients.  THE SUP OF |D| OVER THE SQUARE [0, 5 beta]^2 IS AT THE CORNER (5 beta, 5 beta) by four inequalities:
#   (B1) P increasing  <=>  4m - kappa (1 - m^2) > 0        (the same inequality as Var_perp decreasing);
#   (B2) Var_par decreasing  <=>  phi = 3k - 12m + 2k^2 m - 9k m^2 - 2k^2 m^3 > 0;
#   (B3) A increasing  <=>  psi = 4k - 16m + 2k^2 m - 10k m^2 - 2k^2 m^3 > 0;
#   (C)  -D increasing in each variable on [kappa_0, 5 beta]^2  <=>  2 m_a Var_par,a m_b^2 >= P_a' P_b,  P' = 4 (4m - kappa (1 - m^2)) / kappa^2,
# each certified on interval CELLS over [kappa_0, 2] (B1-B3, 1D) and [kappa_0, 2]^2 (C, 2D) with m's monotonicity bracketing every cell, and on
# [0, kappa_0] by THE HAND LEMMA (the page carries the proof): with x = kappa^2/4, m = (kappa/4) N(x)/D(x), N = sum 2 x^k/(k!(k+2)!), D = sum x^k/(k!(k+1)!),
# the defect N/D - 1 + x/6 = (sum_{k>=2} e_k x^k)/D with e_k = k(k+4)(k-1)/(6 k!(k+2)!) >= 0, so m >= (kappa/4)(1 - kappa^2/24) for ALL kappa, and
# e_{k+1}/e_k = (k+5)/((k+3)(k+4)(k-1)) <= 7/30 gives m <= (kappa/4)(1 - kappa^2/24 + R), R = kappa^4/(384 (1 - 0.06 kappa^2)) for kappa <= 1; whence
# (B1) on [0, 2) outright: 4m - k(1 - m^2) >= k^3 (1/48 - k^2/192); (B2) on (0, 0.5]: phi/k^3 >= 1/8 + 1/2 - k^2/48 - (9/16)(1+R)^2 - (k^2/32)(1+R)^3 - 3R/k^2;
# (B3) on (0, 0.5]: psi/k^3 >= 1/6 + 1/2 - k^2/48 - (5/8)(1+R)^2 - (k^2/32)(1+R)^3 - 4R/k^2 -- the margins at kappa = 0.5 printed (G19-HAND); and in
# the strip min(kappa_a, kappa_b) < kappa_0: |D| <= max(m(kappa_0)^2 m(5 beta)^2, P(kappa_0) P(5 beta)), compared with the corner's lower endpoint.
# THE KNOWN ANSWER: iii-43's Monte Carlo |D(5 beta, 5 beta)| = 0.0072 / 0.0306 / 0.0588 at beta = 0.3 / 0.5 / 0.7 (third digit) must lie within
# 3e-4 of the enclosure; THE LIAR: the same D with 3m/kappa in place of 4m/kappa must MISS at least one of them; and D(0.01, 0.01) must enclose
# below 1e-6 (isotropy at kappa -> 0).  The planted liar of the cells: the claim "Var_par INCREASING" (-phi > 0) must be REFUSED on every cell.
# usage: gawk -M -v betas="0.30 0.32 0.34 0.35 0.36 0.38 0.40" [-v K0=0.5] [-v NC=192] -f g19_vmf.awk     (NC cells on [K0, 2], dyadic grid)
function dn() { ROUNDMODE = "D" }
function up() { ROUNDMODE = "U" }
function fl(x) { ROUNDMODE = "D"; return sprintf("%.18g", x) }
function fh(x) { ROUNDMODE = "U"; return sprintf("%.18g", x) }
function fn(x) { ROUNDMODE = "N"; return sprintf("%.10g", x) }
function bessel_lo(nu, x, K,   k, t, s, i, f) { dn(); f = 1; for (i = 1; i <= nu; i++) f = f * i; t = (x / 2) ^ nu / f; s = t; for (k = 0; k < K; k++) { t = t * (x / 2) ^ 2 / ((k + 1) * (k + 1 + nu)); s = s + t } return s }
function bessel_hi(nu, x, K,   k, t, s, i, f, rho, den) { up(); f = 1; for (i = 1; i <= nu; i++) f = f * i; t = (x / 2) ^ nu / f; s = t; for (k = 0; k < K; k++) { t = t * (x / 2) ^ 2 / ((k + 1) * (k + 1 + nu)); s = s + t }
  rho = (x / 2) ^ 2 / ((K + 1) * (K + 1 + nu)); if (rho >= 1) { print "G19-REFUSED bessel: K too small for x=" x; exit 3 } dn(); den = 1 - rho; up(); return s + t * rho / den }
# m on [xl, xh]: MLO = I_2(xl)/I_1(xl) rounded down, MHI = I_2(xh)/I_1(xh) rounded up (m increasing)
function mint(xl, xh,   i1, i2) { if (xl <= 0) MLO = 0; else { i2 = bessel_lo(2, xl, KB); i1 = bessel_hi(1, xl, KB); dn(); MLO = i2 / i1 }
  if (xh <= 0) MHI = 0; else { i2 = bessel_hi(2, xh, KB); i1 = bessel_lo(1, xh, KB); up(); MHI = i2 / i1 } }
# the derived moments on [xl, xh] with m in [ml, mh]: Var_perp VQ, Var_par VP, A, P, m^2 M2, m^4 M4 (each _L, _H)
function derive(xl, xh, ml, mh,   t1, t2) {
  dn(); VQL = ml / xh; up(); VQH = mh / xl
  up(); t1 = 3 * mh / xl; t2 = mh * mh; dn(); VPL = 1 - t1 - t2
  dn(); t1 = 3 * ml / xh; t2 = ml * ml; up(); VPH = 1 - t1 - t2
  dn(); AL = VQL - VPH; up(); AH = VQH - VPL
  up(); t1 = 4 * mh / xl; dn(); PL = 1 - t1
  dn(); t1 = 4 * ml / xh; up(); PH = 1 - t1
  dn(); M2L = ml * ml; M4L = M2L * M2L; up(); M2H = mh * mh; M4H = M2H * M2H }
# interval product [al, ah] x [bl, bh] -> RL, RH (signs free)
function imul(al, ah, bl, bh,   p1, p2, p3, p4) { dn(); p1 = al * bl; p2 = al * bh; p3 = ah * bl; p4 = ah * bh; RL = p1; if (p2 < RL) RL = p2; if (p3 < RL) RL = p3; if (p4 < RL) RL = p4
  up(); p1 = al * bl; p2 = al * bh; p3 = ah * bl; p4 = ah * bh; RH = p1; if (p2 > RH) RH = p2; if (p3 > RH) RH = p3; if (p4 > RH) RH = p4 }
# D(a, b) = P_a P_b - m_a^2 m_b^2 from the two corners' intervals (PA*, M2A*, PB*, M2B*) -> DL, DH; and c_1 -> C1L, C1H
function dint(pal, pah, m2al, m2ah, pbl, pbh, m2bl, m2bh,   ppl, pph, mml, mmh) { imul(pal, pah, pbl, pbh); ppl = RL; pph = RH; imul(m2al, m2ah, m2bl, m2bh); mml = RL; mmh = RH; dn(); DL = ppl - mmh; up(); DH = pph - mml }
BEGIN { PREC = 256; KB = 160; if (betas == "") betas = "0.30 0.32 0.34 0.35 0.36 0.38 0.40"; K0 = (K0 == "") ? 0.5 : K0 + 0; NC = (NC == "") ? 1024 : NC + 0
  dn(); a = exp(1); b = 1 / 3; c = log(3); up(); A = exp(1); B = 1 / 3; C = log(3); if (!(A > a && B > b && C > c)) { print "G19-REFUSED directed rounding not in force"; exit 3 }
  printf "G19-LOAD PREC=256 directed rounding in force (U > D on exp, 1/3, log); Bessel series K=%d; cells on [%g, 2] NC=%d; the hand lemma on [0, %g]\n", KB, K0, NC, K0
  # ---- THE HAND LEMMA'S MARGINS at kappa = 0.5 and 0.25 (the three brackets of the header, every term rounded against the claim)
  nk = split("0.5 0.25", KK, " "); for (ii = 1; ii <= nk; ii++) { kk = KK[ii] + 0; up(); R = kk ^ 4 / (384 * (1 - 0.06 * kk * kk)); r1 = (1 + R) ^ 2; r2 = (1 + R) ^ 3
    dn(); b1 = 1 / 48 - kk * kk / 192; up(); t1 = kk * kk / 48 + 9 * r1 / 16 + kk * kk * r2 / 32 + 3 * R / (kk * kk); dn(); b2 = 1 / 8 + 1 / 2 - t1
    up(); t1 = kk * kk / 48 + 5 * r1 / 8 + kk * kk * r2 / 32 + 4 * R / (kk * kk); dn(); b3 = 1 / 6 + 1 / 2 - t1
    printf "G19-HAND kappa=%g R<=%s: (B1)/k^3 >= %s  (B2)/k^3 >= %s  (B3)/k^3 >= %s  [%s]\n", kk, fh(R), fl(b1), fl(b2), fl(b3), (b1 > 0 && b2 > 0 && b3 > 0) ? "POSITIVE" : "NOT-POSITIVE" }
  # ---- THE 1D CELLS on [K0, 2]: grid x_i = K0 + i H, H = (2 - K0)/NC (dyadic for K0 = 0.5, NC a power of two)
  dn(); H = (2 - K0) / NC; for (i = 0; i <= NC; i++) { x = K0 + i * H; X[i] = x; mint(x, x); ML[i] = MLO; MH[i] = MHI }
  f1 = 0; f2 = 0; f3 = 0; liar = 0; worst1 = 1e9; worst2 = 1e9; worst3 = 1e9; hand1 = 0; hand2 = 0; hand3 = 0
  for (i = 0; i < NC; i++) { a = X[i]; b = X[i + 1]; mla = ML[i]; mhb = MH[i + 1]; ok1 = 0; ok2 = 0; ok3 = 0
    # THE HAND ROAD on a cell with b <= 1: the header's three brackets, each DECREASING in kappa (every kappa-term negative and growing), so the
    # value at b bounds the cell; (B1)'s bracket 1/48 - k^2/192 holds to 2 but is taken here only to 1 with the others (the direct road covers the rest)
    if (b <= 1) { up(); R = b ^ 4 / (384 * (1 - 0.06 * b * b)); r1 = (1 + R) ^ 2; r2 = (1 + R) ^ 3; bb = b * b
      dn(); h1 = 1 / 48 - bb / 192; up(); t1 = bb / 48 + 9 * r1 / 16 + bb * r2 / 32 + 3 * R / bb; dn(); h2 = 1 / 8 + 1 / 2 - t1
      up(); t1 = bb / 48 + 5 * r1 / 8 + bb * r2 / 32 + 4 * R / bb; dn(); h3 = 1 / 6 + 1 / 2 - t1
      if (h1 > 0) { ok1 = 1; hand1++ } if (h2 > 0) { ok2 = 1; hand2++ } if (h3 > 0) { ok3 = 1; hand3++ } }
    # THE DIRECT ROAD: the polynomial's lower bound on the cell from m in [mla, mhb] (it cancels at small kappa, where the hand road holds)
    dn(); s = mla * mla; up(); t = 1 - s; t = b * t; dn(); e1 = 4 * mla - t; if (e1 > 0) ok1 = 1; if (!ok1) f1++; if (e1 < worst1) worst1 = e1               # (B1) 4m - k(1-m^2) > 0
    dn(); p1 = 3 * a; p2 = 2 * a * a * mla; up(); n1 = 12 * mhb; n2 = 9 * b * mhb * mhb; n3 = 2 * b * b * mhb * mhb * mhb; dn(); e2 = p1 + p2 - n1 - n2 - n3; if (e2 > 0) ok2 = 1; if (!ok2) f2++; if (e2 < worst2) worst2 = e2   # (B2)
    dn(); p1 = 4 * a; up(); n1 = 16 * mhb; n2 = 10 * b * mhb * mhb; dn(); e3 = p1 + p2 - n1 - n2 - n3; if (e3 > 0) ok3 = 1; if (!ok3) f3++; if (e3 < worst3) worst3 = e3                                         # (B3)
    # the planted liar: "Var_par increasing" <=> -phi > 0; its lower bound is  -(upper bound of phi) = -(3b + 2b^2 mhb - 12 mla - 9a mla^2 - 2a^2 mla^3)
    up(); q1 = 3 * b + 2 * b * b * mhb; dn(); q2 = 12 * mla + 9 * a * mla * mla + 2 * a * a * mla * mla * mla; up(); phihi = q1 - q2; dn(); el = 0 - phihi; if (el > 0) liar++ }
  printf "G19-CELLS1D [%g, 2] in %d cells: (B1) by hand %d, failed %d, the direct road's worst lower bound %s; (B2) by hand %d, failed %d, worst %s; (B3) by hand %d, failed %d, worst %s; the planted liar (Var_par increasing) admitted on %d cells  [%s]\n", K0, NC, hand1, f1, fl(worst1), hand2, f2, fl(worst2), hand3, f3, fl(worst3), liar, (f1 == 0 && f2 == 0 && f3 == 0 && liar == 0) ? "CELLS-GREEN" : "CELLS-RED"
  # ---- THE 2D CELLS on [K0, 2]^2 for (C): 2 m_a Var_par,a m_b^2 - P_a' P_b >= 0 on every cell (i for kappa_a, j for kappa_b)
  fc = 0; worstc = 1e9
  for (i = 0; i < NC; i++) { a = X[i]; b = X[i + 1]; mla = ML[i]; mhb = MH[i + 1]
    up(); t1 = 3 * mhb / a; t2 = mhb * mhb; dn(); vlo = 1 - t1 - t2; if (vlo < 0) vlo = 0                                                     # Var_par's lower bound on cell i
    if (b <= 1) { dn(); t = a * a * a / 24; up(); R = b ^ 4 / (384 * (1 - 0.06 * b * b)); num = 0 - t + b * R + b * mhb * mhb }              # the hand numerator 4m - k(1-m^2) = -k^3/24 + k r + k m^2, no cancellation
    else { up(); u = mhb * mhb; dn(); s = a * (1 - u); up(); num = 4 * mhb - s }                                                             # the direct bracket past kappa = 1
    dn(); aa = a * a; up(); PPH[i] = 4 * num / aa                                                                                            # P'(cell i) upper bound
    dn(); LA[i] = 2 * mla * vlo }
  for (j = 0; j < NC; j++) { bj = X[j + 1]; dn(); t = 4 * ML[j + 1] / bj; up(); PHJ[j] = 1 - t; dn(); MLB2[j] = ML[j] * ML[j] }                      # P(cell j) upper bound; m_b^2 lower bound
  for (i = 0; i < NC; i++) for (j = 0; j < NC; j++) { dn(); L = LA[i] * MLB2[j]; up(); Rr = PPH[i] * PHJ[j]; dn(); cc = L - Rr; if (cc < 0) fc++; if (cc < worstc) worstc = cc }
  printf "G19-CELLS2D [%g, 2]^2 in %d cells: (C) -D increasing in each variable failed %d, worst lower bound %s  [%s]\n", K0, NC * NC, fc, fl(worstc), (fc == 0) ? "CELLS2D-GREEN" : "CELLS2D-RED"
  cellsok = (f1 == 0 && f2 == 0 && f3 == 0 && liar == 0 && fc == 0)
  # the strip's crude bound needs m(K0) and P(K0)
  mint(K0, K0); mK0l = MLO; mK0h = MHI; derive(K0, K0, mK0l, mK0h); pK0h = PH; up(); m2K0h = mK0h * mK0h
  dint(PL, PH, M2L, M2H, PL, PH, M2L, M2H); dK0h = DH; printf "G19-BASE D(%g, %g) in [%s, %s]: %s at the square's base corner, so -D >= 0 on [%g, 2]^2 by (C) and |D| = -D there  [%s]\n", K0, K0, fl(DL), fh(DH), (dK0h < 0) ? "negative" : "NOT NEGATIVE", K0, (dK0h < 0) ? "BASE-OK" : "BASE-RED"
  if (!(dK0h < 0)) cellsok = 0
  # ---- THE CORNERS at 4 beta and 5 beta for every beta, the sup over the square, and the known answers
  nb = split(betas, BB, " "); allsup = 1
  for (ib = 1; ib <= nb; ib++) { bs = BB[ib]; if (bs ~ /\./) { split(bs, bq, "."); bp = (bq[1] bq[2]) + 0; bQ = 10 ^ length(bq[2]) } else { bp = bs + 0; bQ = 1 }
    for (mult = 4; mult <= 5; mult++) { dn(); xl = mult * bp / bQ; up(); xh = mult * bp / bQ; mint(xl, xh); ml = MLO; mh = MHI; derive(xl, xh, ml, mh)
      dn(); c1l = VQL + PL * VQL; up(); c1h = VQH + PH * VQH; dint(PL, PH, M2L, M2H, PL, PH, M2L, M2H)
      printf "G19-CORNER beta=%s kappa=%dbeta=%s: m in [%s, %s] Var_par in [%s, %s] Var_perp in [%s, %s] A in [%s, %s] P in [%s, %s] m^2 in [%s, %s] m^4 in [%s, %s] c_1 in [%s, %s] D in [%s, %s]\n", bs, mult, fn(xl), fl(ml), fh(mh), fl(VPL), fh(VPH), fl(VQL), fh(VQH), fl(AL), fh(AH), fl(PL), fh(PH), fl(M2L), fh(M2H), fl(M4L), fh(M4H), fl(c1l), fh(c1h), fl(DL), fh(DH)
      if (mult == 5) { K5 = xh; m5l = ml; m5h = mh; vp5l = VPL; vq5l = VQL; a5h = AH; p5h = PH; d5l = DL; d5h = DH; m25h = M2H } }
    # |D| at the corner: D < 0 there (checked), |D| in [-DH, -DL]; the strip bound; the sup claim on [0, 5 beta]^2 needs 5 beta <= 2 (the cells' range)
    dn(); adl = 0 - d5h; up(); adh = 0 - d5l; up(); s1 = m2K0h * m25h; s2 = pK0h * p5h; strip = (s1 > s2) ? s1 : s2
    inrange = (K5 <= 2.0000001); supok = (d5h < 0 && strip <= adl && cellsok && inrange)
    printf "G19-SUP beta=%s: |D(5beta, 5beta)| in [%s, %s]; the strip min(kappa) < %g bound %s %s the corner's lower endpoint; D < 0 at the corner: %s; cells: %s; 5beta <= 2: %s  => sup over [0, 5beta]^2 of |D| at the corner  [%s]\n", bs, fl(adl), fh(adh), K0, fh(strip), (strip <= adl) ? "<=" : ">", (d5h < 0) ? "yes" : "NO", cellsok ? "green" : "RED", inrange ? "yes" : "NO", supok ? "CORNER-CERTIFIED" : "NOT-CERTIFIED"
    printf "G19-RANGE beta=%s over [0, 5beta]: m in [0, %s]; Var_par in [%s, 1/4]; Var_perp in [%s, 1/4]; A in [0, %s]  (the inf/sup by (B1)-(B3) and the hand lemma; 1/4 the kappa -> 0 limit)\n", bs, fh(m5h), fl(vp5l), fl(vq5l), fh(a5h)
    if (!supok) allsup = 0 }
  # ---- THE KNOWN ANSWER and THE LIAR at beta = 0.3, 0.5, 0.7 (the corner 5 beta: 1.5, 2.5, 3.5), and isotropy at 0.01
  nk = split("0.3 0.5 0.7", KB3, " "); split("0.0072 0.0306 0.0588", MC, " "); katok = 1; liarmiss = 0
  for (ik = 1; ik <= nk; ik++) { kb = KB3[ik]; split(kb, kq, "."); kp = (kq[1] kq[2]) + 0; kQ = 10 ^ length(kq[2]); dn(); x = 5 * kp / kQ; up(); xh = 5 * kp / kQ; mint(x, xh); derive(x, xh, MLO, MHI); dint(PL, PH, M2L, M2H, PL, PH, M2L, M2H); dn(); adl = 0 - DH; up(); adh = 0 - DL
    mc = MC[ik] + 0; dn(); dlo = mc - 3e-4; up(); dhi = mc + 3e-4; met = !(adh < dlo || adl > dhi)
    # the liar: P~ = 1 - 3m/kappa
    up(); t = 3 * MHI / x; dn(); ptl = 1 - t; dn(); t = 3 * MLO / x; up(); pth = 1 - t; dint(ptl, pth, M2L, M2H, ptl, pth, M2L, M2H); dn(); ldl = 0 - DH; up(); ldh = 0 - DL; lmet = !(ldh < dlo || ldl > dhi)
    printf "G19-KAT beta=%s kappa=5beta=%s: |D| in [%s, %s] against the Monte Carlo %s +- 3e-4: %s; the liar (3m/kappa) |D~| in [%s, %s]: %s\n", kb, fn(x), fl(adl), fh(adh), MC[ik], met ? "MET" : "MISSED", fl(ldl), fh(ldh), lmet ? "ADMITTED" : "ESCAPES"
    if (!met) katok = 0; if (!lmet) liarmiss++ }
  mint(0.01, 0.01); derive(0.01, 0.01, MLO, MHI); dint(PL, PH, M2L, M2H, PL, PH, M2L, M2H); iso = (DL > -1e-6 && DH < 1e-6)
  printf "G19-KAT isotropy D(0.01, 0.01) in [%s, %s] (below 1e-6: %s)\n", fl(DL), fh(DH), iso ? "MET" : "MISSED"
  verdict = (katok && liarmiss > 0 && iso && cellsok) ? "G19-GREEN" : "G19-RED"
  printf "G19-VERDICT known answers %s, the liar escapes at %d of 3, isotropy %s, cells %s, the corner sup certified at every beta in range: %s  [%s]\n", katok ? "MET" : "MISSED", liarmiss, iso ? "MET" : "MISSED", cellsok ? "GREEN" : "RED", allsup ? "yes" : "NO", verdict
  if (verdict != "G19-GREEN") exit 1 }
