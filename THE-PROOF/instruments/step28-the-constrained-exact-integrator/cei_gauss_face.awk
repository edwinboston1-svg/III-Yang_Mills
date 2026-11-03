# cei_gauss_face.awk -- THE GAUSSIAN FACE FIBRE (gawk): known answer (K4-face) of the face-fibre engine cei_face.c (campaign §31.11-§31.12).
# EI's bent two-face object: face A = the 2 x 2 block of plaquettes in the xy-plane at z = 0 (x, y in [0, 2]), face B = the 2 x 2 block in the
# yz-plane at x = 0 (y, z in [0, 2]); 22 object links; every link outside the object at the ordered datum, A = 0.  The Gaussian field A (one
# colour) on the 22 object links; the quadratic form P = sum over every plaquette holding an object link of (dA_p)^2 per unit beta (exterior
# links 0); THE SEVEN SINGLE-PATH CONSTRAINTS at Gaussian order: each coarse edge's two links' angles sum to zero (the Gaussian order of
# U_1 U_2 = 1).  No vertex has all its links in the object, so P is positive definite and no gauge fixing is needed; the constrained covariance
# is the (1,1) block of the inverse KKT matrix.  Observables: the (1,2)-plaquette at (0,0,0) (face A's plaquette 0 in the engine's numbering)
# and the (2,3)-plaquette at (0,0,0) (face B's plaquette 4); the connected <1/2 tr U_p 1/2 tr U_q> at Gaussian order is (3/2)(cov/beta)^2.
# usage: gawk -f cei_gauss_face.awk [-v BETA=2.2]
function isobj(x0, x1, x2, x3, mu) {   # the 22 object links
  if (x3 != 0) return 0
  if (mu == 1) return (x2 == 0 && x0 >= 0 && x0 <= 1 && x1 >= 0 && x1 <= 2)             # x-links of face A: 6
  if (mu == 2) return ((x2 == 0 && x0 >= 0 && x0 <= 2 && x1 >= 0 && x1 <= 1) || (x0 == 0 && x2 >= 0 && x2 <= 2 && x1 >= 0 && x1 <= 1))   # y-links: face A 6, face B 6, shared 2
  if (mu == 3) return (x0 == 0 && x1 >= 0 && x1 <= 2 && x2 >= 0 && x2 <= 1)             # z-links of face B: 6
  return 0 }
function lkey(x0, x1, x2, x3, mu,   k) { if (!isobj(x0, x1, x2, x3, mu)) return -1; k = x0 "," x1 "," x2 "," x3 "," mu; if (!(k in LID)) { LID[k] = NL; LNAME[NL] = k; NL++ } return LID[k] }
function step(x0, x1, x2, x3, mu, k) { X[0] = x0; X[1] = x1; X[2] = x2; X[3] = x3; X[mu - 1] += k }
function plaq(x0, x1, x2, x3, mu, nu) {   # the four links of the plaquette at x in the (mu, nu) plane, with signs; ids -1 if exterior
  PL[1] = lkey(x0, x1, x2, x3, mu); PS[1] = 1
  step(x0, x1, x2, x3, mu, 1); PL[2] = lkey(X[0], X[1], X[2], X[3], nu); PS[2] = 1
  step(x0, x1, x2, x3, nu, 1); PL[3] = lkey(X[0], X[1], X[2], X[3], mu); PS[3] = -1
  PL[4] = lkey(x0, x1, x2, x3, nu); PS[4] = -1 }
function invert(n,   i, j, k, piv, t, m, PM) {   # Gauss-Jordan with partial pivoting on M[][] -> MI[][]; a singular system refused by a relative pivot
  for (i = 0; i < n; i++) for (j = 0; j < n; j++) { W[i, j] = M[i, j]; MI[i, j] = (i == j) }
  for (k = 0; k < n; k++) {
    piv = k; m = (W[k, k] < 0) ? -W[k, k] : W[k, k]
    for (i = k + 1; i < n; i++) { t = (W[i, k] < 0) ? -W[i, k] : W[i, k]; if (t > m) { m = t; piv = i } }
    if (k == 0) PM = m; if (m < 1e-10 * PM) { print "REFUSED: singular system at column " k; exit 3 }
    if (piv != k) for (j = 0; j < n; j++) { t = W[k, j]; W[k, j] = W[piv, j]; W[piv, j] = t; t = MI[k, j]; MI[k, j] = MI[piv, j]; MI[piv, j] = t }
    t = W[k, k]; for (j = 0; j < n; j++) { W[k, j] /= t; MI[k, j] /= t }
    for (i = 0; i < n; i++) if (i != k && W[i, k] != 0) { t = W[i, k]; for (j = 0; j < n; j++) { W[i, j] -= t * W[k, j]; MI[i, j] -= t * MI[k, j] } } } }
function pfun(name, x0, x1, x2, x3, mu, nu,   q, ext) { plaq(x0, x1, x2, x3, mu, nu); ext = 0; for (q = 1; q <= 4; q++) { if (PL[q] < 0) ext++; else F[name, PL[q]] += PS[q] } return ext }
function cov(a, b, MAT,   i, j, s) { s = 0; for (i = 0; i < NL; i++) if ((a, i) in F) for (j = 0; j < NL; j++) if ((b, j) in F) s += F[a, i] * MAT[i, j] * F[b, j]; return s }
BEGIN { if (BETA == "") BETA = 2.2; NL = 0
  # the object links first (so the 22 ids are 0..21), by enumeration
  for (x0 = 0; x0 <= 2; x0++) for (x1 = 0; x1 <= 2; x1++) for (x2 = 0; x2 <= 2; x2++) for (mu = 1; mu <= 3; mu++) lkey(x0, x1, x2, 0, mu)
  if (NL != 22) { print "REFUSED: " NL " object links, not 22"; exit 3 }
  # P over every plaquette holding an object link (exterior links 0)
  for (x0 = -1; x0 <= 3; x0++) for (x1 = -1; x1 <= 3; x1++) for (x2 = -1; x2 <= 3; x2++) for (x3 = -1; x3 <= 1; x3++)
    for (mu = 1; mu <= 4; mu++) for (nu = mu + 1; nu <= 4; nu++) {
      plaq(x0, x1, x2, x3, mu, nu); any = 0; for (q = 1; q <= 4; q++) if (PL[q] >= 0) any = 1
      if (!any) continue; NP++
      for (q = 1; q <= 4; q++) for (r = 1; r <= 4; r++) if (PL[q] >= 0 && PL[r] >= 0) P[PL[q], PL[r]] += PS[q] * PS[r] }
  # the seven single-path constraints: each coarse edge's two links sum to zero
  NC = 0
  split("0,1,0,0,2:0,0,0,0,2 0,0,0,0,1:1,0,0,0,1 2,0,0,0,2:2,1,0,0,2 1,2,0,0,1:0,2,0,0,1 0,2,0,0,3:0,2,1,0,3 0,1,2,0,2:0,0,2,0,2 0,0,1,0,3:0,0,0,0,3", ED, " ")
  for (e = 1; e <= 7; e++) { split(ED[e], two, ":"); for (h = 1; h <= 2; h++) { if (!(two[h] in LID)) { print "REFUSED: edge link " two[h] " is not an object link"; exit 3 } C[NC, LID[two[h]]] = 1 } NC++ }
  NK = NL + NC
  # the unconstrained covariance (P alone) and the constrained one (the KKT block)
  for (i = 0; i < NL; i++) for (j = 0; j < NL; j++) M[i, j] = P[i, j]
  invert(NL); for (i = 0; i < NL; i++) for (j = 0; j < NL; j++) MU[i, j] = MI[i, j]
  for (i = 0; i < NK; i++) for (j = 0; j < NK; j++) M[i, j] = 0
  for (i = 0; i < NL; i++) for (j = 0; j < NL; j++) M[i, j] = P[i, j]
  for (a = 0; a < NC; a++) for (j = 0; j < NL; j++) if (C[a, j]) { M[NL + a, j] = C[a, j]; M[j, NL + a] = C[a, j] }
  invert(NK); for (i = 0; i < NL; i++) for (j = 0; j < NL; j++) SG[i, j] = MI[i, j]
  printf "CEI-GAUSS-FACE: 22 object links, %d plaquettes holding an object link, %d single-path constraints, beta = %g\n", NP, NC, BETA
  e1 = pfun("pA0", 0, 0, 0, 0, 1, 2); e2 = pfun("pB4", 0, 0, 0, 0, 2, 3); e3 = pfun("pA3", 1, 1, 0, 0, 1, 2); e4 = pfun("pB7", 0, 1, 1, 0, 2, 3)
  printf "  interior check (exterior links in the four plaquette functionals, must be 0): %d %d %d %d\n", e1, e2, e3, e4
  printf "  %-10s %16s %16s %10s\n", "pair", "unconstrained", "constrained", "ratio"
  n = split("pA0:pA0 pB4:pB4 pA0:pB4 pA3:pB7 pA0:pA3 pB4:pB7", PR, " ")
  for (q = 1; q <= n; q++) { split(PR[q], ab, ":"); u = cov(ab[1], ab[2], MU); c = cov(ab[1], ab[2], SG); printf "  %-10s %16.12f %16.12f %10.6f\n", PR[q], u, c, (u != 0) ? c / u : 0; if (PR[q] == "pA0:pB4") { U = u; CC = c }; if (PR[q] == "pA0:pA0") { VU = u; VC = c } }
  printf "  K4-FACE at beta = %g: the (A0, B4) cross-face covariance per unit beta: constrained %.12f, unconstrained %.12f; connected <1/2 tr 1/2 tr> at Gaussian order (3/2)(cov/beta)^2: constrained %.6e, unconstrained %.6e; <1/2 tr U_p> at Gaussian order 1 - (3/2) var/beta: constrained %.6f, unconstrained %.6f\n", BETA, CC, U, 1.5 * (CC / BETA)^2, 1.5 * (U / BETA)^2, 1 - 1.5 * VC / BETA, 1 - 1.5 * VU / BETA
  exit 0 }
