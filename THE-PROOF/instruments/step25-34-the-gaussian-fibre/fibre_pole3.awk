# fibre_pole3.awk -- ΟΛΟΚΛΗΡΩΣΙΣ ADDENDUM I, S-A2: THE FIBRE'S POLE AT THE RATIONAL POINTS OF THE CIRCLE.  The Bloch variable of the first
# transverse direction kept symbolic and represented by the companion matrix of W^2 - uW + 1 at an INTEGER u = 2 cos K_1 in {2, 1, 0, -1, -2}
# (K_1 = 0, pi/3, pi/2, 2pi/3, pi), so the 16 x 16 problem becomes a 32 x 32 integer one whose determinant is D(z, u)^2; the exact polynomial
# square root is taken (refused by name if the symmetry is broken) and D's negative zeros bracketed exactly -- the leading pole is the one
# nearest -1.  The corners u = +-2 must reproduce Ο1 (the corner law's quadratic divides).  usage: gawk -M -v U=<int> -v E2=+-1 -v E3=+-1
# [-v MN= -v MD=] -f fibre_pole3.awk.  Derived from fibre_pole2.awk, whose header follows for the machinery kept:
# fibre_pole2.awk -- ΟΛΟΚΛΗΡΩΣΙΣ ADDENDUM I, THE BIVARIATE DETERMINANT: fibre_pole.awk with the FIRST transverse direction carrying its
# Bloch variable W = e^{iK_1} (the hop leaving the block in +1 carries W, in -1 carries 1/W, the whole block matrix scaled by W to stay
# integral: diagonal (8 MD + MN) W, every other hop -MD W, the +1 crossing -MD W^2, the -1 crossing -MD; the projector's constant 16 MD z W),
# run at an INTEGER W (an evaluation point of the polynomial identity, not a momentum), K_2, K_3 in {0, pi}, m^2 = MN/MD.  THE STAKE S-A1
# (page, Addendum I, before this ran): 2 cosh kappa = 8 + 2 m^2 + 4 n' - (W + 1/W), so the primitive form of (MD W) z^2 + ((8 MD + 2 MN +
# 4 n' MD) W - MD W^2 - MD) z + (MD W) DIVIDES det C(z, W) at every W; the wrapper sweeps W = 1 .. 48 and the page says why 48 points prove
# the identity.  usage: gawk -M -v W=<int> -v E2=+-1 -v E3=+-1 [-v MN= -v MD=] -f fibre_pole2.awk   (E1 is fixed at 1: direction 1 carries W)
# The original header follows, unchanged, for the machinery this file keeps:
# fibre_pole.awk -- ΟΛΟΚΛΗΡΩΣΙΣ Ο1, THE FIBRE'S EXACT POLE.  The massless Gaussian free field on Z^4 with the block average over
# 2^4 blocks as the observer: the 16 x 16 block matrix at block momentum K = (K0, Kperp), z = e^{iK0}, with Kperp in {0, pi}^3
# (every transverse phase +-1, so every entry is an integer Laurent polynomial in z), the fibre propagator (P0 J P0 + Pi)^{-1} - Pi,
# Pi = 11^T/16, P0 = 1 - Pi, and its poles the zeros of D(z) = det(P0 J(z) P0 + Pi).  EXACT: 256 (P0 J P0 + Pi)_ij = 256 J_ij - 16 c_j
# - 16 r_i + T + 16 (r_i, c_j, T the row, column and total sums of J), C(z) = z B(z) a 16 x 16 matrix of integer polynomials of degree
# <= 2, det C(z) a polynomial of degree <= 32 recovered by EVALUATION at the integers 1..NPTS (each a fraction-free Bareiss
# determinant) and NEWTON INTERPOLATION in exact rationals, the extra points checked against the degree bound.  A pole on the line
# Re K0 = pi is a negative real zero z = -e^{-kappa}; cosh kappa = c <=> z^2 + 2c z + 1 = 0, so the reading is: which quadratics
# z^2 + 2c z + 1 (c = 2..40) DIVIDE det C(z), and where the negative zeros of largest modulus below 1 lie (exact bisection on the sign).
# MF Theorem 3.1 (math/MF/part_3b.md line 30): cosh kappa_2 = 3 at Kperp = 0, m = 0.  The massive cells: J0 + m^2 I with m^2 = MN/MD,
# the whole matrix scaled by MD to stay integral (the zeros unchanged).
# Sharing no line with photon_carried/fibre_gauss2.py (numpy) or fibre_pole4.py: the hop matrices are built here from the block
# geometry, the determinant is exact, no float anywhere.  gawk traps honoured: 0 - x never -x; arrays named past the builtins.
# usage: gawk -M -v E1=1 -v E2=1 -v E3=1 [-v MN=0 -v MD=1] [-v NPTS=40] -f fibre_pole.awk     (E_mu = +1 for K_mu = 0, -1 for K_mu = pi)
function sitei(s0, s1, s2, s3) { return ((s0 * 2 + s1) * 2 + s2) * 2 + s3 }
# --- exact rationals as "n/d" strings with d > 0, reduced
function gcd(a, b,   t) { if (a < 0) a = 0 - a; if (b < 0) b = 0 - b; while (b != 0) { t = a % b; a = b; b = t } return a }
function rmk(n, d,   g) { if (d < 0) { n = 0 - n; d = 0 - d } g = gcd(n, d); if (g == 0) g = 1; return (n / g) "/" (d / g) }
function rn(r) { return substr(r, 1, index(r, "/") - 1) + 0 }
function rd(r) { return substr(r, index(r, "/") + 1) + 0 }
function radd(a, b) { return rmk(rn(a) * rd(b) + rn(b) * rd(a), rd(a) * rd(b)) }
function rsub(a, b) { return rmk(rn(a) * rd(b) - rn(b) * rd(a), rd(a) * rd(b)) }
function rmul(a, b) { return rmk(rn(a) * rn(b), rd(a) * rd(b)) }
function rdiv(a, b) { return rmk(rn(a) * rd(b), rd(a) * rn(b)) }
# --- the block matrix with the Bloch variable of direction 1 kept SYMBOLIC: JC[i,j,p,d] the coefficient of z^p W^d (p, d in -1, 0, 1) of
# J_ij over the scale MD; the +1 crossing is the channel d = +1, the -1 crossing d = -1, everything else d = 0 (no W scaling here)
function build_hops(   s0, s1, s2, s3, i, mu, sg, t0, t1, t2, t3, j, k, d, tv) {
  for (i = 0; i < 16; i++) for (j = 0; j < 16; j++) for (k = -1; k <= 1; k++) for (d = -1; d <= 1; d++) JC[i, j, k, d] = 0
  for (s0 = 0; s0 < 2; s0++) for (s1 = 0; s1 < 2; s1++) for (s2 = 0; s2 < 2; s2++) for (s3 = 0; s3 < 2; s3++) {
    i = sitei(s0, s1, s2, s3); JC[i, i, 0, 0] += 8 * MD + MN
    for (mu = 0; mu < 4; mu++) for (sg = -1; sg <= 1; sg += 2) {
      t0 = s0; t1 = s1; t2 = s2; t3 = s3
      if (mu == 0) t0 += sg; else if (mu == 1) t1 += sg; else if (mu == 2) t2 += sg; else t3 += sg
      tv = (mu == 0) ? t0 : (mu == 1) ? t1 : (mu == 2) ? t2 : t3
      if (tv == 2) {          # the hop leaves the block in +mu: wraps to 0, carries the phase e^{+iK_mu}
        if (mu == 0) t0 = 0; else if (mu == 1) t1 = 0; else if (mu == 2) t2 = 0; else t3 = 0
        j = sitei(t0, t1, t2, t3)
        if (mu == 0) JC[i, j, 1, 0] -= MD; else if (mu == 1) JC[i, j, 0, 1] -= MD; else JC[i, j, 0, 0] -= MD * EPS[mu]
      } else if (tv < 0) {    # the hop leaves the block in -mu: wraps to 1, the phase e^{-iK_mu}
        if (mu == 0) t0 = 1; else if (mu == 1) t1 = 1; else if (mu == 2) t2 = 1; else t3 = 1
        j = sitei(t0, t1, t2, t3)
        if (mu == 0) JC[i, j, -1, 0] -= MD; else if (mu == 1) JC[i, j, 0, -1] -= MD; else JC[i, j, 0, 0] -= MD * EPS[mu]
      } else { j = sitei(t0, t1, t2, t3); JC[i, j, 0, 0] -= MD }
    }
  }
}
# C(z) at an integer z and an integer u = W + 1/W, as the 32 x 32 INTEGER matrix of the real representation W -> M = [[u,-1],[1,0]]
# (M^-1 = [[0,1],[-1,u]], det M = 1): the entry a + b W + c W^-1 is the 2 x 2 block a I + b M + c M^-1.  The projector formula
# 256 (P0 J P0 + Pi) = 256 J - 16 c_j - 16 r_i + T + 16 MD is linear in J, so it passes through the representation channel by channel.
# det_32(z, u) = D(z, W) D(z, 1/W) = D(z, u)^2 where D is the symmetric determinant of the 16 x 16 problem.
function eval_C(z,   i, j, v0, v1, vm, T0, T1, Tm, x0, x1, xm) {
  T0 = 0; T1 = 0; Tm = 0
  for (i = 0; i < 16; i++) { RS0[i] = 0; RS1[i] = 0; RSm[i] = 0; CS0[i] = 0; CS1[i] = 0; CSm[i] = 0 }
  for (i = 0; i < 16; i++) for (j = 0; j < 16; j++) {
    v0 = JC[i, j, -1, 0] + JC[i, j, 0, 0] * z + JC[i, j, 1, 0] * z * z      # z * J_ij, channel W^0
    v1 = JC[i, j, -1, 1] + JC[i, j, 0, 1] * z + JC[i, j, 1, 1] * z * z      # channel W^+1
    vm = JC[i, j, -1, -1] + JC[i, j, 0, -1] * z + JC[i, j, 1, -1] * z * z   # channel W^-1
    Z0[i, j] = v0; Z1[i, j] = v1; Zm[i, j] = vm
    RS0[i] += v0; RS1[i] += v1; RSm[i] += vm; CS0[j] += v0; CS1[j] += v1; CSm[j] += vm; T0 += v0; T1 += v1; Tm += vm }
  for (i = 0; i < 16; i++) for (j = 0; j < 16; j++) {
    x0 = 256 * Z0[i, j] - 16 * CS0[j] - 16 * RS0[i] + T0 + 16 * MD * z
    x1 = 256 * Z1[i, j] - 16 * CS1[j] - 16 * RS1[i] + T1
    xm = 256 * Zm[i, j] - 16 * CSm[j] - 16 * RSm[i] + Tm
    CM[2 * i, 2 * j] = x0 + U * x1;  CM[2 * i, 2 * j + 1] = xm - x1
    CM[2 * i + 1, 2 * j] = x1 - xm;  CM[2 * i + 1, 2 * j + 1] = x0 + U * xm }
  # the row sums of the W^0 channel at K = 0 (the geometry KAT reads them)
  for (i = 0; i < 16; i++) RSM[i] = RS0[i] + RS1[i] + RSm[i]
}
# the exact square root of the integer polynomial PI[0..deg] (deg even): SQ[0..deg/2], or 0 when it is not a perfect square
function isqrt(n,   lo, hi, mid) { if (n < 0) return -1; lo = 0; hi = 1; while (hi * hi <= n) hi *= 2; while (hi - lo > 1) { mid = (lo + hi) / 2; mid = mid - (mid % 1); if (mid * mid <= n) lo = mid; else hi = mid } return lo }
function polysqrt(deg,   m, k, i, acc, s) {
  if (deg % 2 != 0) return 0
  m = deg / 2; s = isqrt(PI[deg]); if (s < 0 || s * s != PI[deg]) return 0
  SQ[m] = s
  for (k = m - 1; k >= 0; k--) { acc = PI[m + k]; for (i = k + 1; i <= m - 1; i++) acc -= SQ[i] * SQ[m + k - i]
    if (acc % (2 * s) != 0) return 0; SQ[k] = acc / (2 * s) }
  # the lower half must agree: P_j = sum_{i+l=j} SQ_i SQ_l for j < m
  for (k = 0; k < m; k++) { acc = 0; for (i = 0; i <= k; i++) acc += SQ[i] * SQ[k - i]; if (acc != PI[k]) return 0 }
  SDEG = m; return 1
}
# fraction-free Bareiss determinant of CM (n x n integers), exact
function bareiss(n,   i, j, k, prev, sgn, t, r, p) {
  for (i = 0; i < n; i++) for (j = 0; j < n; j++) BM[i, j] = CM[i, j]
  prev = 1; sgn = 1
  for (k = 0; k < n - 1; k++) {
    if (BM[k, k] == 0) { p = -1; for (r = k + 1; r < n; r++) if (BM[r, k] != 0) { p = r; break }
      if (p < 0) return 0
      for (j = 0; j < n; j++) { t = BM[k, j]; BM[k, j] = BM[p, j]; BM[p, j] = t } sgn = 0 - sgn }
    for (i = k + 1; i < n; i++) for (j = k + 1; j < n; j++) BM[i, j] = (BM[i, j] * BM[k, k] - BM[i, k] * BM[k, j]) / prev
    prev = BM[k, k]
  }
  return sgn * BM[n - 1, n - 1]
}
# Newton interpolation through (X[0..m-1], Y[0..m-1]) in exact rationals -> the polynomial P[0..m-1] (coefficients of z^0..z^{m-1})
function newton(m,   i, j, k, c, t, acc) {
  for (i = 0; i < m; i++) DD[i] = Y[i] "/1"
  for (j = 1; j < m; j++) for (i = m - 1; i >= j; i--) DD[i] = rdiv(rsub(DD[i], DD[i - 1]), rmk(X[i] - X[i - j], 1))
  for (k = 0; k < m; k++) P[k] = "0/1"
  # P = DD[m-1]; for i = m-2 .. 0: P = P * (z - X[i]) + DD[i]
  P[0] = DD[m - 1]; deg = 0
  for (i = m - 2; i >= 0; i--) {
    for (k = deg + 1; k >= 1; k--) P[k] = rsub((k - 1 <= deg) ? P[k - 1] : "0/1", rmul(P[k], rmk(X[i], 1)))
    P[0] = rsub("0/1", rmul(P[0], rmk(X[i], 1))); P[0] = radd(P[0], DD[i]); deg++
  }
  return deg
}
# the polynomial as integers: every coefficient must have denominator 1 (the determinant of an integer matrix is an integer)
function integral(deg,   k) { for (k = 0; k <= deg; k++) { if (rd(P[k]) != 1) return 0; PI[k] = rn(P[k]) } return 1 }
function evalP(deg, num, den,   k, acc) { # P(num/den) * den^deg, exact integer
  acc = 0; for (k = deg; k >= 0; k--) acc = acc * num + PI[k] * (den ^ (deg - k)); return acc }
# remainder of PI by z^2 + 2c z + 1: synthetic division, exact; returns 1 iff the remainder is zero
function divides_quad(deg, c,   k, a, b, t) {
  for (k = 0; k <= deg; k++) Q[k] = PI[k]
  for (k = deg; k >= 2; k--) { t = Q[k]; Q[k] = 0; Q[k - 1] -= 2 * c * t; Q[k - 2] -= t }
  return (Q[0] == 0 && Q[1] == 0) ? 1 : 0 }
# the negative zeros in (-1, 0): the sign of P at -a/2^B over a grid, bisected to 2^-48; prints each root's bracket and its cosh
function negative_roots(deg,   B, a, s0, s1, lo, hi, mid, it, slo, shi, n, root) {
  B = 48; n = 0
  s0 = sgn(evalP(deg, 0, 1))
  for (a = 1; a <= 1024; a++) { s1 = sgn(evalP(deg, 0 - a, 1024))
    if (s1 == 0) { ROOTN[n] = 0 - a; ROOTD[n] = 1024; n++ }
    else if (s0 != 0 && s1 != s0) {   # a sign change in (-(a)/1024, -(a-1)/1024): bisect
      lo = 0 - a; hi = 0 - (a - 1); slo = s1; shi = s0
      sc = 1024
      for (it = 10; it < B; it++) { lo *= 2; hi *= 2; sc *= 2; mid = (lo + hi) / 2; t = sgn(evalP(deg, mid, sc))
        if (t == 0) { lo = mid; hi = mid; break } if (t == slo) lo = mid; else hi = mid }
      ROOTN[n] = lo; ROOTD[n] = sc; n++ }
    s0 = s1 }
  return n }
function sgn(x) { return (x > 0) ? 1 : (x < 0) ? -1 : 0 }
function fdiv(n, d,   r) { r = n % d; if (r < 0) r += d; return (n - r) / d }
function dec(n, d, dig,   neg, ip, r, s, i, q) { neg = 0; if (n < 0) { neg = 1; n = 0 - n } ip = fdiv(n, d); r = n - ip * d; s = ""
  for (i = 0; i < dig; i++) { r *= 10; q = fdiv(r, d); s = s q; r -= q * d } return (neg ? "-" : "") ip "." s }
BEGIN {
  if (!NPTS) NPTS = 66; if (!MD) MD = 1; if (!MN) MN = 0; if (!E2) E2 = 1; if (!E3) E3 = 1; if (U == "") U = 2
  U = U + 0
  if (U < -2 || U > 2) { print "FP3-REFUSED: u = 2 cos K_1 must lie in [-2, 2] (a momentum on the circle)"; exit 2 }
  EPS[2] = E2; EPS[3] = E3
  build_hops()
  cell = sprintf("u=%d K1=%s K23=(%s,%s) m2=%d/%d", U, (U == 2 ? "0" : U == 1 ? "pi/3" : U == 0 ? "pi/2" : U == -1 ? "2pi/3" : "pi"), (E2 == 1 ? "0" : "pi"), (E3 == 1 ? "0" : "pi"), MN, MD)
  # the KAT of the geometry at K = 0 (u = 2), m = 0: the massless Laplacian's block, every row sum of the three channels ZERO
  if (U == 2 && E2 == 1 && E3 == 1 && MN == 0) { eval_C(1); bad = 0; for (i = 0; i < 16; i++) if (RSM[i] != 0) bad++
    printf "FP3-KAT u=2 rowsums-at-K0 zero=%d of 16%s\n", 16 - bad, (bad ? " REFUSED: not the massless Laplacian's block" : " MET"); if (bad) exit 2 }
  for (k = 0; k < NPTS; k++) { X[k] = k + 1; eval_C(k + 1); Y[k] = bareiss(32) }
  deg = newton(NPTS)
  while (deg > 0 && rn(P[deg]) == 0) deg--
  if (!integral(deg)) { print "FP3-REFUSED: a non-integer coefficient in the interpolated determinant"; exit 2 }
  printf "FP3-DET32 %s degree=%d points=%d top=%s\n", cell, deg, NPTS, PI[deg]
  if (deg > 64) { print "FP3-REFUSED: the determinant's degree exceeds 64 -- the matrix is not what the page says"; exit 2 }
  # det_32 = D(z, u)^2: the exact polynomial square root, refused by name when the W-symmetry is broken
  if (!polysqrt(deg)) { printf "FP3-REFUSED %s det_32 is not a perfect square -- the W <-> 1/W symmetry is broken\n", cell; exit 2 }
  for (k = 0; k <= SDEG; k++) PI[k] = SQ[k]; deg = SDEG
  low = 0; while (low < deg && PI[low] == 0) low++
  pal = 1; for (k = 0; k + low <= deg; k++) if (PI[low + k] != PI[deg - k]) pal = 0
  printf "FP3-SQRT %s degree=%d lowest-power=%d palindromic=%s top=%s\n", cell, deg, low, (pal ? "yes" : "no"), PI[deg]
  # THE COSH POLYNOMIAL: D(z,u)/z^(low) is palindromic of degree 2m, so D/z^(low+m) = sum_k a_k (z^k + z^-k) = F(v), v = z + 1/z = -2 cosh kappa,
  # with V_0 = 2 (a_0 taken once), V_1 = v, V_k = v V_{k-1} - V_{k-2} (the Chebyshev recurrence); F's integer coefficients are printed for the
  # stranger's factoring -- the pole's minimal polynomial is the next instrument, not read here
  if (pal) { m = (deg - low) / 2
    for (k = 0; k <= m; k++) FC[k] = 0
    for (k = 0; k <= m; k++) VP[k] = 0; VP[0] = 2            # V_0
    for (k = 0; k <= m; k++) VQ[k] = 0; VQ[1] = 1            # V_1 = v
    FC[0] += PI[low + m]                                      # a_0 * 1 (half of V_0 * a_0)
    for (k = 1; k <= m; k++) { for (i = 0; i <= m; i++) FC[i] += PI[low + m + k] * VQ[i]
      if (k < m) { for (i = m; i >= 1; i--) VR[i] = VQ[i - 1]; VR[0] = 0; for (i = 0; i <= m; i++) { t = VR[i] - VP[i]; VP[i] = VQ[i]; VQ[i] = t } } }
    printf "FP3-COSHPOLY %s degree=%d coefficients(v=z+1/z=-2cosh)=", cell, m; for (k = 0; k <= m; k++) printf "%s%s", FC[k], (k < m ? "," : "\n") }
  # the corner known answers through this road: at u = 2 the quadratic z^2 + 2(3 + 2n + m^2) z + 1 of the corner law divides (Ο1); at u = -2 with n + 1
  npi = (E2 == -1) + (E3 == -1); cc = 3 + 2 * npi + (U == -2 ? 2 : 0)
  if ((U == 2 || U == -2) && MD == 1) printf "FP3-CORNER %s corner-law cosh=%d quadratic z^2 + %d z + 1 %s\n", cell, cc + MN, 2 * (cc + MN), divides_quad(deg, cc + MN) ? "DIVIDES" : "DOES-NOT-DIVIDE"
  n = negative_roots(deg)
  for (k = 0; k < n; k++) { num = ROOTN[k]; den = ROOTD[k]
    printf "FP3-ROOT %s z in [%s, %s] cosh=%s\n", cell, dec(num, den, 12), dec(num + 1, den, 12), dec(num * num + den * den, 0 - 2 * num * den, 9) }
  # the leading pole: the negative zero of largest modulus below 1 is the first root found (the grid walks from 0 outward... the roots are
  # listed from z = 0 toward -1; the pole with the SMALLEST cosh is the zero nearest -1, the last listed)
  if (n > 0) { num = ROOTN[n - 1]; den = ROOTD[n - 1]; printf "FP3-POLE %s cosh=%s (the zero nearest -1: the fibre's leading rate)\n", cell, dec(num * num + den * den, 0 - 2 * num * den, 9) }
  printf "FP3-END %s negative-roots=%d\n", cell, n
}
