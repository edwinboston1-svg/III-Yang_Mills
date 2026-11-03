# cei_gauss_strip.awk -- THE GAUSSIAN FIBRE OF THE STRIP (gawk): the holonomy-constrained free field on the K-cell planar strip's object links
# (campaign 31.15's Gaussian comparison): P = sum over every plaquette holding an object link of (dA_p)^2 per unit beta, exterior links 0 (the
# ordered datum); the 3K + 1 single-path constraints (each coarse edge's two links sum to zero); the constrained covariance the (1,1) block of the
# KKT inverse; the plaquette functionals of face 0's far column (base (n-1, 0)) and face f's far column (base (-f n, 0)) at separations f n + 1;
# the connected <1/2 tr U_p 1/2 tr U_q> at Gaussian order is (3/2)(cov/beta)^2, so the Gaussian factor per cell is the squared covariance ratio.
# usage: gawk -v K=5 -v n=2 -v BETA=2.2 -f cei_gauss_strip.awk
function isobj(x0, x1, x2, x3, mu) { if (x3 != 0 || x2 != 0) return 0
  if (mu == 1) return (x0 >= -(K - 1) * n && x0 <= n - 1 && x1 >= 0 && x1 <= n)
  if (mu == 2) return (x0 >= -(K - 1) * n && x0 <= n && x1 >= 0 && x1 <= n - 1)
  return 0 }
function lkey(x0, x1, x2, x3, mu,   k) { if (!isobj(x0, x1, x2, x3, mu)) return -1; k = x0 "," x1 "," x2 "," x3 "," mu; if (!(k in LID)) { LID[k] = NL; LNAME[NL] = k; NL++ } return LID[k] }
function step(x0, x1, x2, x3, mu, k) { X[0] = x0; X[1] = x1; X[2] = x2; X[3] = x3; X[mu - 1] += k }
function plaq(x0, x1, x2, x3, mu, nu) { PL[1] = lkey(x0, x1, x2, x3, mu); PS[1] = 1
  step(x0, x1, x2, x3, mu, 1); PL[2] = lkey(X[0], X[1], X[2], X[3], nu); PS[2] = 1
  step(x0, x1, x2, x3, nu, 1); PL[3] = lkey(X[0], X[1], X[2], X[3], mu); PS[3] = -1
  PL[4] = lkey(x0, x1, x2, x3, nu); PS[4] = -1 }
function invert(nn,   i, j, k, piv, t, m, PM) { for (i = 0; i < nn; i++) for (j = 0; j < nn; j++) { W[i, j] = M[i, j]; MI[i, j] = (i == j) }
  for (k = 0; k < nn; k++) { piv = k; m = (W[k, k] < 0) ? -W[k, k] : W[k, k]
    for (i = k + 1; i < nn; i++) { t = (W[i, k] < 0) ? -W[i, k] : W[i, k]; if (t > m) { m = t; piv = i } }
    if (k == 0) PM = m; if (m < 1e-10 * PM) { print "REFUSED: singular system at column " k; exit 3 }
    if (piv != k) for (j = 0; j < nn; j++) { t = W[k, j]; W[k, j] = W[piv, j]; W[piv, j] = t; t = MI[k, j]; MI[k, j] = MI[piv, j]; MI[piv, j] = t }
    t = W[k, k]; for (j = 0; j < nn; j++) { W[k, j] /= t; MI[k, j] /= t }
    for (i = 0; i < nn; i++) if (i != k && W[i, k] != 0) { t = W[i, k]; for (j = 0; j < nn; j++) { W[i, j] -= t * W[k, j]; MI[i, j] -= t * MI[k, j] } } } }
function pfun(name, x0, x1, x2, x3, mu, nu,   q, ext) { plaq(x0, x1, x2, x3, mu, nu); ext = 0; for (q = 1; q <= 4; q++) { if (PL[q] < 0) ext++; else F[name, PL[q]] += PS[q] } return ext }
function cov(a, b, MAT,   i, j, s) { s = 0; for (i = 0; i < NL; i++) if ((a, i) in F) for (j = 0; j < NL; j++) if ((b, j) in F) s += F[a, i] * MAT[i, j] * F[b, j]; return s }
function addc(x0, y0, mu, x1, y1,   a, b) { a = lkey(x0, y0, 0, 0, mu); b = lkey(x1, y1, 0, 0, mu); if (a < 0 || b < 0) { print "REFUSED: an edge link is not an object link (" x0 "," y0 " d" mu " / " x1 "," y1 ")"; exit 3 } C[NC, a] = 1; C[NC, b] = 1; NC++ }
BEGIN { if (K == "") K = 5; if (n == "") n = 2; if (BETA == "") BETA = 2.2; NL = 0
  for (x0 = -(K - 1) * n; x0 <= n; x0++) for (x1 = 0; x1 <= n; x1++) for (mu = 1; mu <= 2; mu++) lkey(x0, x1, 0, 0, mu)
  if (NL != K * n * (2 * n + 1) + n) { print "REFUSED: " NL " object links, not " K * n * (2 * n + 1) + n; exit 3 }
  for (x0 = -(K - 1) * n - 1; x0 <= n + 1; x0++) for (x1 = -1; x1 <= n + 1; x1++) for (x2 = -1; x2 <= 1; x2++) for (x3 = -1; x3 <= 1; x3++)
    for (mu = 1; mu <= 4; mu++) for (nu = mu + 1; nu <= 4; nu++) { plaq(x0, x1, x2, x3, mu, nu); any = 0; for (q = 1; q <= 4; q++) if (PL[q] >= 0) any = 1
      if (!any) continue; NP++; for (q = 1; q <= 4; q++) for (r = 1; r <= 4; r++) if (PL[q] >= 0 && PL[r] >= 0) P[PL[q], PL[r]] += PS[q] * PS[r] }
  # the coarse edges: vertical at x = n, 0, -n, ..., -(K-1)n (K + 1), horizontal at y = 0 and y = n in every cell (2K); n = 2 pairs of links
  NC = 0; for (f = -1; f <= K - 1; f++) addc(-f * n, 0, 2, -f * n, 1)
  for (f = 0; f < K; f++) { xl = -f * n; for (yy = 0; yy <= n; yy += n) addc(xl, yy, 1, xl + 1, yy) }
  if (NC != 3 * K + 1) { print "REFUSED: " NC " constraints, not " 3 * K + 1; exit 3 }
  NK = NL + NC; for (i = 0; i < NK; i++) for (j = 0; j < NK; j++) M[i, j] = 0
  for (i = 0; i < NL; i++) for (j = 0; j < NL; j++) M[i, j] = P[i, j]
  for (a = 0; a < NC; a++) for (j = 0; j < NL; j++) if (C[a, j]) { M[NL + a, j] = C[a, j]; M[j, NL + a] = C[a, j] }
  invert(NK); for (i = 0; i < NL; i++) for (j = 0; j < NL; j++) SG[i, j] = MI[i, j]
  printf "CEI-GAUSS-STRIP K=%d n=%d: %d object links, %d plaquettes holding an object link, %d single-path constraints, beta = %g\n", K, n, NL, NP, NC, BETA
  e0 = pfun("p", n - 1, 0, 0, 0, 1, 2); printf "  interior check p: %d exterior links in the functional (must be 0)\n", e0
  vp = cov("p", "p", SG); printf "  var(dA_p) constrained = %.9f; <1/2 tr U_p> at Gaussian order = 1 - (3/8) var/beta = %.6f\n", vp, 1 - 0.375 * vp / BETA
  prev = ""; for (f = 1; f < K; f++) { nm = "q" f; e = pfun(nm, -f * n, 0, 0, 0, 1, 2); c = cov("p", nm, SG); conn = 1.5 * (c / BETA) ^ 2
    printf "  sep %2d (face %d's far column): cov = %+.9e  connected(Gaussian) = %.6e  exterior links %d", f * n + 1, f, c, conn, e
    if (prev != "") printf "  factor per cell (connected) = %.3f (cov ratio %.4f)", (prev / conn), sqrt(prev / conn); printf "\n"; prev = conn } }
