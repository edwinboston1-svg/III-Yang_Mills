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
# --- the block matrix: JC[i,j,p] the coefficient of z^p (p in -1, 0, 1) of J_ij, over the scale MD
function build_hops(   s0, s1, s2, s3, i, mu, sg, t0, t1, t2, t3, j, k, tv) {
  for (i = 0; i < 16; i++) for (j = 0; j < 16; j++) for (k = -1; k <= 1; k++) JC[i, j, k] = 0
  for (s0 = 0; s0 < 2; s0++) for (s1 = 0; s1 < 2; s1++) for (s2 = 0; s2 < 2; s2++) for (s3 = 0; s3 < 2; s3++) {
    i = sitei(s0, s1, s2, s3); JC[i, i, 0] += 8 * MD + MN
    for (mu = 0; mu < 4; mu++) for (sg = -1; sg <= 1; sg += 2) {
      t0 = s0; t1 = s1; t2 = s2; t3 = s3
      if (mu == 0) t0 += sg; else if (mu == 1) t1 += sg; else if (mu == 2) t2 += sg; else t3 += sg
      tv = (mu == 0) ? t0 : (mu == 1) ? t1 : (mu == 2) ? t2 : t3
      if (tv == 2) {          # the hop leaves the block in +mu: wraps to 0, carries the phase e^{+iK_mu}
        if (mu == 0) t0 = 0; else if (mu == 1) t1 = 0; else if (mu == 2) t2 = 0; else t3 = 0
        j = sitei(t0, t1, t2, t3)
        if (mu == 0) JC[i, j, 1] -= MD; else JC[i, j, 0] -= MD * EPS[mu]
      } else if (tv < 0) {    # the hop leaves the block in -mu: wraps to 1, the phase e^{-iK_mu}
        if (mu == 0) t0 = 1; else if (mu == 1) t1 = 1; else if (mu == 2) t2 = 1; else t3 = 1
        j = sitei(t0, t1, t2, t3)
        if (mu == 0) JC[i, j, -1] -= MD; else JC[i, j, 0] -= MD * EPS[mu]
      } else { j = sitei(t0, t1, t2, t3); JC[i, j, 0] -= MD }
    }
  }
}
# C(z) at an integer z: the integer matrix CM[i,j] = z * (256 J_ij - 16 c_j - 16 r_i + T + 16 MD)   (all over the scale MD; z >= 1)
function eval_C(z,   i, j, v, r, c, T) {
  T = 0
  for (i = 0; i < 16; i++) { RSM[i] = 0; CSM[i] = 0 }
  for (i = 0; i < 16; i++) for (j = 0; j < 16; j++) { v = JC[i, j, -1] + JC[i, j, 0] * z + JC[i, j, 1] * z * z   # z * J_ij
    ZJ[i, j] = v; RSM[i] += v; CSM[j] += v; T += v }
  for (i = 0; i < 16; i++) for (j = 0; j < 16; j++) CM[i, j] = 256 * ZJ[i, j] - 16 * CSM[j] - 16 * RSM[i] + T + 16 * MD * z
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
# --- THE OBJECT, EXPORTED (EXPORT=1; off by default, the plain output unchanged): the author itself for a stranger's road, not its
# description.  FM-J: the 16 x 16 Laurent matrix J(z) at this cell, entry (i, j) as the integer coefficients of z^-1, z^0, z^1 over the
# scale MD (J = (8 MD + MN) I minus the eight nearest-neighbour hops, a hop leaving the block in +mu carrying z (mu = 0) or E_mu, in -mu
# 1/z or E_mu); FM-C: the polynomial matrix C(z) = z (256 J - 16 c_j - 16 r_i + T + 16 MD) whose determinant the record reads, entry
# (i, j) as the integer coefficients of z^0, z^1, z^2 (c_j, r_i, T the column, row and total sums of J).  Sites i = 8 s0 + 4 s1 + 2 s2
# + s3, s_mu in {0, 1}, mu = 0 the longitudinal direction, z = e^{i K0}; C(z) = 256 z (P0 J P0 + Pi), Pi = 11^T/16, P0 = 1 - Pi.
function export_matrix(   i, j, p, k, v) {
  printf "FM-OBJECT the block-averaged Gaussian fibre's cell operator: dimension 16 (the 2^4 block), sites i = 8 s0 + 4 s1 + 2 s2 + s3, z = e^{iK0}, transverse phases E=(%d,%d,%d) (K_mu = 0 for +1, pi for -1), mass m2=%d/%d, scale MD=%d; J(z) = (8 MD + MN) I - hops; C(z) = z (256 J - 16 c_j - 16 r_i + T + 16 MD) = 256 z (P0 J P0 + Pi); D(z) = det C(z)\n", EPS[1], EPS[2], EPS[3], MN, MD, MD
  for (i = 0; i < 16; i++) for (j = 0; j < 16; j++) printf "FM-J Kperp=(%s,%s,%s) m2=%d/%d i=%d j=%d z^-1=%d z^0=%d z^1=%d\n", (EPS[1] == 1 ? "0" : "pi"), (EPS[2] == 1 ? "0" : "pi"), (EPS[3] == 1 ? "0" : "pi"), MN, MD, i, j, JC[i, j, -1], JC[i, j, 0], JC[i, j, 1]
  for (p = 0; p <= 2; p++) { XT[p] = 0; for (i = 0; i < 16; i++) { XR[i, p] = 0; XC[i, p] = 0 }
    for (i = 0; i < 16; i++) for (j = 0; j < 16; j++) { v = JC[i, j, p - 1]; XR[i, p] += v; XC[j, p] += v; XT[p] += v } }
  for (i = 0; i < 16; i++) for (j = 0; j < 16; j++) { for (p = 0; p <= 2; p++) XV[p] = 256 * JC[i, j, p - 1] - 16 * XC[j, p] - 16 * XR[i, p] + XT[p] + ((p == 1) ? 16 * MD : 0)
    printf "FM-C Kperp=(%s,%s,%s) m2=%d/%d i=%d j=%d z^0=%d z^1=%d z^2=%d\n", (EPS[1] == 1 ? "0" : "pi"), (EPS[2] == 1 ? "0" : "pi"), (EPS[3] == 1 ? "0" : "pi"), MN, MD, i, j, XV[0], XV[1], XV[2] }
}
BEGIN {
  if (!NPTS) NPTS = 40; if (!MD) MD = 1; if (!MN) MN = 0; if (!E1) E1 = 1; if (!E2) E2 = 1; if (!E3) E3 = 1
  EPS[1] = E1; EPS[2] = E2; EPS[3] = E3
  build_hops()
  if (EXPORT) export_matrix()
  # the KAT of the geometry: at z = 1 and Kperp = 0, m = 0 the block matrix is the massless Laplacian's block, every row sum ZERO
  if (E1 == 1 && E2 == 1 && E3 == 1 && MN == 0) { eval_C(1); bad = 0; for (i = 0; i < 16; i++) if (RSM[i] != 0) bad++
    printf "FP-KAT rowsums-at-K0 zero=%d of 16%s\n", 16 - bad, (bad ? " REFUSED: not the massless Laplacian's block" : " MET"); if (bad) exit 2 }
  for (k = 0; k < NPTS; k++) { X[k] = k + 1; eval_C(k + 1); Y[k] = bareiss(16) }
  deg = newton(NPTS)
  # the true degree: strip the vanishing top coefficients
  while (deg > 0 && rn(P[deg]) == 0) deg--
  if (!integral(deg)) { print "FP-REFUSED: a non-integer coefficient in the interpolated determinant"; exit 2 }
  printf "FP-DET Kperp=(%s,%s,%s) m2=%d/%d degree=%d points=%d top=%s constant=%s\n", (E1 == 1 ? "0" : "pi"), (E2 == 1 ? "0" : "pi"), (E3 == 1 ? "0" : "pi"), MN, MD, deg, NPTS, PI[deg], PI[0]
  # the degree bound check: NPTS - 1 >= 32 points admit degree 32 at most; the interpolant's degree below NPTS - 1 is the consistency
  if (deg > 32) { print "FP-REFUSED: the determinant's degree exceeds 32 -- the matrix is not what the page says"; exit 2 }
  # palindromic after the power of z is stripped (z <-> 1/z: the Laurent symmetry of the block matrix, det C = z^16 det B)
  low = 0; while (low < deg && PI[low] == 0) low++
  pal = 1; for (k = 0; k + low <= deg; k++) if (PI[low + k] != PI[deg - k]) pal = 0
  printf "FP-SYMMETRY lowest-power=%d palindromic=%s\n", low, (pal ? "yes" : "no")
  # the integer coefficients of det C(z), z^0 .. z^deg, for the stranger's kernel (Ο7): the division is re-decided there from these literals
  printf "FP-COEFFS Kperp=(%s,%s,%s) m2=%d/%d coefficients=", (E1 == 1 ? "0" : "pi"), (E2 == 1 ? "0" : "pi"), (E3 == 1 ? "0" : "pi"), MN, MD
  for (k = 0; k <= deg; k++) printf "%s%s", PI[k], (k < deg ? "," : "\n")
  # every reading line carries its CELL: a bare "cosh=3 divides" was satisfied by the massive cell under a bent diagonal (the
  # diagbend tooth of 2026-11-02 survived on it), so no line here is a pin unless it names Kperp and m^2 (law 46 at the record)
  for (c = 2; c <= 40; c++) if (divides_quad(deg, c)) printf "FP-QUAD Kperp=(%s,%s,%s) m2=%d/%d cosh=%d divides: z^2 + %d z + 1 DIVIDES det\n", (E1 == 1 ? "0" : "pi"), (E2 == 1 ? "0" : "pi"), (E3 == 1 ? "0" : "pi"), MN, MD, c, 2 * c
  # THE LAW (staked on the page as 3 + m^2 at Kperp = 0 and read at the transverse cells): cosh kappa = 3 + 2 n + m^2, n the number of
  # transverse directions at pi; as a rational 2c = (6 + 4n) + 2 MN/MD -> the quadratic MD z^2 + ((6 + 4n) MD + 2 MN) z + MD, made
  # primitive (Gauss: an integer polynomial divisible over Q by a primitive one is divisible over Z), tested by synthetic division
  npi = (E1 == -1) + (E2 == -1) + (E3 == -1)
  for (k = 0; k <= deg; k++) Q[k] = PI[k]
  bb = (6 + 4 * npi) * MD + 2 * MN; ok = 1; gq = gcd(MD, bb); qa = MD / gq; qb = bb / gq
  for (k = deg; k >= 2; k--) { if (Q[k] % qa != 0) { ok = 0; break } t = Q[k] / qa; Q[k] = 0; Q[k - 1] -= qb * t; Q[k - 2] -= qa * t }
  printf "FP-LAW npi=%d m2=%d/%d cosh=3+2npi+m2=%d/%d quadratic=%d z^2 + %d z + %d %s\n", npi, MN, MD, (3 + 2 * npi) * MD + MN, MD, qa, qb, qa, (ok && Q[0] == 0 && Q[1] == 0) ? "DIVIDES" : "DOES-NOT-DIVIDE"
  n = negative_roots(deg)
  for (k = 0; k < n; k++) { num = ROOTN[k]; den = ROOTD[k]
    # cosh kappa = -(z + 1/z)/2 = (num^2 + den^2) / (-2 num den)
    printf "FP-ROOT Kperp=(%s,%s,%s) m2=%d/%d z in [%s, %s] cosh=%s\n", (E1 == 1 ? "0" : "pi"), (E2 == 1 ? "0" : "pi"), (E3 == 1 ? "0" : "pi"), MN, MD, dec(num, den, 12), dec(num + 1, den, 12), dec(num * num + den * den, 0 - 2 * num * den, 9) }
  printf "FP-END Kperp=(%s,%s,%s) m2=%d/%d negative-roots=%d\n", (E1 == 1 ? "0" : "pi"), (E2 == 1 ? "0" : "pi"), (E3 == 1 ? "0" : "pi"), MN, MD, n
}
