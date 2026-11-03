# cei_gauss.awk -- THE CONSTRAINED GAUSSIAN TWO-BLOCK FIBRE (gawk): known answer (K4) of the constrained exact integrator (CEI blueprint §4).
# REVISED 16:5x: the gauge mode at the shared-face vertex (x0 = 2) is NOT a symmetry of the constrained problem (it rotates block 1's
# endpoint and block 2's start, so C g != 0): the constrained covariance is read from the KKT system [[P + delta G13, C^T], [C, 0]] with the
# gauge fixing at the two mid-path vertices only (x0 = 1, 3); the unconstrained comparison uses P + delta G123.  Both delta-independent.
# Two adjacent L = 2 blocks along direction 0 (sites x0 = 0..3, x1,x2,x3 = 0..1; block 1 = x0 in {0,1}, block 2 = x0 in {2,3}); the 128
# region links (x, mu) with x in the region carry a Gaussian field A (one colour; SU(2)'s three colours are three copies at Gaussian
# order); every link outside the region sits at the ordered datum A = 0.  The quadratic form P = sum over every plaquette touching the
# region of (dA_p)^2, per unit beta; the fine gauge modes at the three fully interior vertices (x0 in {1,2,3}, x1 = x2 = x3 = 1) are exact
# zero modes of P and are fixed by delta * sum_x (g_x . A)^2 with g_x the mode itself, which leaves every gauge-invariant covariance
# unchanged (P and G act on orthogonal subspaces) -- the delta-independence is this file's own known answer.  The straight-path constraint
# at Gaussian order: for each block b and direction mu, the sum of A over the block's sixteen mu-links vanishes (B = 1 to first order) --
# eight linear constraints.  The constrained covariance Sigma = M^-1 - M^-1 C^T (C M^-1 C^T)^-1 C M^-1, M = P + delta G, read on the
# plaquette functionals dA_p of interior plaquettes of the two blocks.  The connected <1/2 tr U_p1  1/2 tr U_p2> at Gaussian order is
# (3/2) (cov/beta)^2 (Wick, three colours).  usage: gawk -f cei_gauss.awk [-v DELTA=1]
function sid(x0, x1, x2, x3) { return ((x0 * 2 + x1) * 2 + x2) * 2 + x3 }
function inreg(x0, x1, x2, x3) { return (x0 >= 0 && x0 <= 3 && x1 >= 0 && x1 <= 1 && x2 >= 0 && x2 <= 1 && x3 >= 0 && x3 <= 1) }
function lid(x0, x1, x2, x3, mu) { if (!inreg(x0, x1, x2, x3)) return -1; return sid(x0, x1, x2, x3) * 4 + mu }
function step(x0, x1, x2, x3, mu, k) { X[0] = x0; X[1] = x1; X[2] = x2; X[3] = x3; X[mu] += k }
# the four links of the plaquette at x in the (mu, nu) plane with their signs, into PL[1..4], PS[1..4] (ids, -1 if exterior)
function plaq(x0, x1, x2, x3, mu, nu,   a, b) {
  PL[1] = lid(x0, x1, x2, x3, mu); PS[1] = 1
  step(x0, x1, x2, x3, mu, 1); PL[2] = lid(X[0], X[1], X[2], X[3], nu); PS[2] = 1
  step(x0, x1, x2, x3, nu, 1); PL[3] = lid(X[0], X[1], X[2], X[3], mu); PS[3] = -1
  PL[4] = lid(x0, x1, x2, x3, nu); PS[4] = -1
}
function invert(n,   i, j, k, piv, t, m) {     # Gauss-Jordan with partial pivoting on M[][] -> MI[][]
  for (i = 0; i < n; i++) for (j = 0; j < n; j++) { W[i, j] = M[i, j]; MI[i, j] = (i == j) }
  for (k = 0; k < n; k++) {
    piv = k; m = (W[k, k] < 0) ? -W[k, k] : W[k, k]
    for (i = k + 1; i < n; i++) { t = (W[i, k] < 0) ? -W[i, k] : W[i, k]; if (t > m) { m = t; piv = i } }
    if (k == 0) PMAX = m; if (m < 1e-10 * PMAX) { print "REFUSED: singular M at column " k; exit 3 }
    if (piv != k) for (j = 0; j < n; j++) { t = W[k, j]; W[k, j] = W[piv, j]; W[piv, j] = t; t = MI[k, j]; MI[k, j] = MI[piv, j]; MI[piv, j] = t }
    t = W[k, k]; for (j = 0; j < n; j++) { W[k, j] /= t; MI[k, j] /= t }
    for (i = 0; i < n; i++) if (i != k && W[i, k] != 0) { t = W[i, k]; for (j = 0; j < n; j++) { W[i, j] -= t * W[k, j]; MI[i, j] -= t * MI[k, j] } }
  }
}
function invert8(   i, j, k, piv, t, m) {      # the 8 x 8 Schur complement S[][] -> SI[][]
  for (i = 0; i < 8; i++) for (j = 0; j < 8; j++) { W8[i, j] = S[i, j]; SI[i, j] = (i == j) }
  for (k = 0; k < 8; k++) {
    piv = k; m = (W8[k, k] < 0) ? -W8[k, k] : W8[k, k]
    for (i = k + 1; i < 8; i++) { t = (W8[i, k] < 0) ? -W8[i, k] : W8[i, k]; if (t > m) { m = t; piv = i } }
    if (k == 0) PMAX8 = m; if (m < 1e-10 * PMAX8) { print "REFUSED: singular Schur complement at " k; exit 3 }
    if (piv != k) for (j = 0; j < 8; j++) { t = W8[k, j]; W8[k, j] = W8[piv, j]; W8[piv, j] = t; t = SI[k, j]; SI[k, j] = SI[piv, j]; SI[piv, j] = t }
    t = W8[k, k]; for (j = 0; j < 8; j++) { W8[k, j] /= t; SI[k, j] /= t }
    for (i = 0; i < 8; i++) if (i != k && W8[i, k] != 0) { t = W8[i, k]; for (j = 0; j < 8; j++) { W8[i, j] -= t * W8[k, j]; SI[i, j] -= t * SI[k, j] } }
  }
}
# a plaquette functional into F[name, id]; returns the number of exterior links (must be 0 for an interior plaquette)
function pfun(name, x0, x1, x2, x3, mu, nu,   q, ext) { plaq(x0, x1, x2, x3, mu, nu); ext = 0; for (q = 1; q <= 4; q++) { if (PL[q] < 0) ext++; else F[name, PL[q]] += PS[q] } return ext }
# u = M^-1 f for a functional f (sparse in F[name, *]); then cov(f, f') unconstrained = f . u', constrained = f . u' - (C u)^T SI (C u')
function mv(name,   i, j) { for (i = 0; i < NL; i++) { U[name, i] = 0; for (j = 0; j < NL; j++) if ((name, j) in F) U[name, i] += MI[i, j] * F[name, j] } for (i = 0; i < 8; i++) { CU[name, i] = 0; for (j = 0; j < NL; j++) CU[name, i] += C[i, j] * U[name, j] } }
function cov_un(a, b,   i, s) { s = 0; for (i = 0; i < NL; i++) if ((a, i) in F) s += F[a, i] * U[b, i]; return s }
function cov_con(a, b,   i, j, s) { s = cov_un(a, b); for (i = 0; i < 8; i++) for (j = 0; j < 8; j++) s -= CU[a, i] * SI[i, j] * CU[b, j]; return s }
BEGIN {
  if (DELTA == "") DELTA = 1; if (PATHS == "") PATHS = 8; NL = 128; NK = NL + 8
  for (x0 = -1; x0 <= 4; x0++) for (x1 = -1; x1 <= 2; x1++) for (x2 = -1; x2 <= 2; x2++) for (x3 = -1; x3 <= 2; x3++)
    for (mu = 0; mu < 4; mu++) for (nu = mu + 1; nu < 4; nu++) {
      plaq(x0, x1, x2, x3, mu, nu); any = 0; for (q = 1; q <= 4; q++) if (PL[q] >= 0) any = 1
      if (!any) continue; NP++
      for (q = 1; q <= 4; q++) for (r = 1; r <= 4; r++) if (PL[q] >= 0 && PL[r] >= 0) P[PL[q], PL[r]] += PS[q] * PS[r]
    }
  # the constraints first (their rows decide which gauge modes are symmetries of the constrained problem)
  for (b = 0; b < 2; b++) for (mu = 0; mu < 4; mu++) { np = 0
    for (x0 = 2 * b; x0 <= 2 * b + 1; x0++) for (x1 = 0; x1 <= 1; x1++) for (x2 = 0; x2 <= 1; x2++) for (x3 = 0; x3 <= 1; x3++) {
      X[0] = x0 - 2 * b; X[1] = x1; X[2] = x2; X[3] = x3; pidx = 0; for (d = 0; d < 4; d++) if (d != mu) pidx = pidx * 2 + X[d]
      if (pidx < PATHS) C[b * 4 + mu, lid(x0, x1, x2, x3, mu)] = 1 } }
  for (x0 = 1; x0 <= 3; x0++) { x1 = 1; x2 = 1; x3 = 1
    delete g; for (mu = 0; mu < 4; mu++) { g[lid(x0, x1, x2, x3, mu)] -= 1; step(x0, x1, x2, x3, mu, -1); g[lid(X[0], X[1], X[2], X[3], mu)] += 1 }
    moves = 0; for (a = 0; a < 8; a++) { s = 0; for (i in g) if ((a, i) in C) s += C[a, i] * g[i]; if (s != 0) moves++ }   # a mode moving no constraint is a symmetry of the constrained problem and must be fixed
    for (i in g) for (j in g) { G123[i, j] += DELTA * g[i] * g[j]; if (moves == 0) G13[i, j] += DELTA * g[i] * g[j] }
    MOVES[x0] = moves
    if (x0 == 2) for (i in g) F["gauge2", i] = g[i]
  }
  # the unconstrained covariance: M = P + delta G123
  for (i = 0; i < NL; i++) for (j = 0; j < NL; j++) M[i, j] = P[i, j] + G123[i, j]
  invert(NL); for (i = 0; i < NL; i++) for (j = 0; j < NL; j++) MU[i, j] = MI[i, j]
  # the constrained covariance: the KKT system with the mid-path gauge fixing only
  for (i = 0; i < NK; i++) for (j = 0; j < NK; j++) M[i, j] = 0
  for (i = 0; i < NL; i++) for (j = 0; j < NL; j++) M[i, j] = P[i, j] + G13[i, j]
  for (a = 0; a < 8; a++) for (j = 0; j < NL; j++) if (C[a, j]) { M[NL + a, j] = C[a, j]; M[j, NL + a] = C[a, j] }
  invert(NK); for (i = 0; i < NL; i++) for (j = 0; j < NL; j++) SG[i, j] = MI[i, j]
  # the Cg control: the face vertex mode is not a constrained symmetry, the mid-path ones are
  cg = MOVES[2]
  printf "CEI-GAUSS two blocks (128 links), %d plaquettes touching the region, delta = %g, PATHS = %d per coarse link; the face mode moves %d constraint(s) (2 at PATHS = 8, 0 below, then it is fixed too), the mid-path modes %d, %d\n", NP, DELTA, PATHS, cg, MOVES[1], MOVES[3]
  e1 = pfun("p01a", 0, 0, 0, 0, 0, 1); e2 = pfun("p01b", 2, 0, 0, 0, 0, 1); e3 = pfun("p23a", 0, 0, 0, 0, 2, 3); e4 = pfun("p23b", 2, 0, 0, 0, 2, 3)
  e5 = pfun("p23c", 0, 1, 0, 0, 2, 3); e6 = pfun("p12a", 0, 0, 0, 0, 1, 2); e7 = pfun("p12b", 2, 0, 0, 0, 1, 2)
  printf "  interior check (exterior links in the functionals, must be 0): %d %d %d %d %d %d %d\n", e1, e2, e3, e4, e5, e6, e7
  printf "  %-14s %16s %16s %10s\n", "pair", "unconstrained", "constrained", "ratio"
  n = split("p01a:p01a p01b:p01b p01a:p01b p23a:p23a p23b:p23b p23a:p23b p23a:p23c p12a:p12b", PR, " ")
  for (q = 1; q <= n; q++) { split(PR[q], ab, ":"); u = 0; c = 0
    for (i = 0; i < NL; i++) if ((ab[1], i) in F) for (j = 0; j < NL; j++) if ((ab[2], j) in F) { u += F[ab[1], i] * MU[i, j] * F[ab[2], j]; c += F[ab[1], i] * SG[i, j] * F[ab[2], j] }
    printf "  %-14s %16.12f %16.12f %10.6f\n", PR[q], u, c, (u != 0) ? c / u : 0; if (PR[q] == "p01a:p01b") { U01 = u; C01 = c } }
  printf "  K4 (block distance 1, orientation (0,1), the ordered datum outside): constrained cov per unit beta = %.12f, unconstrained %.12f; connected <1/2 tr 1/2 tr> at Gaussian order (3/2)(cov/beta)^2: beta 50 %.6e, 100 %.6e, 2.2 %.6e (Gaussian order at 2.2 is a reference, not a reading)\n", C01, U01, 1.5 * (C01 / 50)^2, 1.5 * (C01 / 100)^2, 1.5 * (C01 / 2.2)^2
  exit 0
}
