# fontes_christoffel.awk -- the NON-UNIFORM Christoffel constant of the 2^4 block.  Fontes bounds the Christoffel correction for a
# UNIFORM background (all plaquette angles theta_0 in one direction n): ||Delta_Chr||/beta = (1/2) theta_0 ||S|| = 2.98 theta_0.
# For a general small field |theta_p| <= theta* with directions n_p free, the correction is (beta/2) sum_p theta_p ([n_p]_x (x) S_p)
# and its quadratic form at a unit x in R^96 is (beta/2) sum_p theta_p n_p . w_p(x), w_p(x) = sum_{l,l'} S_p[l,l'] (x_l' x x_l);
# so ||Delta_Chr||/beta <= (theta*/2) M with M := sup_{|x|=1} sum_p |w_p(x)|.  THE CRUDE RIGOROUS BOUND: |w_p| <= sum 2|S_p[l l']||x_l||x_l'|,
# summed over p the pairs sharing a face give |x|^T A |x| <= lambda_max(A) = 9 (A the 9-regular face-sharing adjacency on 32 edges):
# M <= 9.  THE UNIFORM CASE gives M >= ||S|| = 5.96.  This program reads M from below by gradient ascent on the sphere (random
# restarts) -- a READING, a lower bound on M -- and then the Christoffel edge theta_c (3 cos t = (M/2) t) and the Peierls floor
# 54.4 mu1(beta, theta_c) < 1 for M = 9 (rigorous crude) and for the M read.
function mu1(beta, ts,   n, h, i, t, f, num, den, w, x) { n = 20000; h = 3.14159265358979 / n; num = 0; den = 0
  for (i = 0; i <= n; i++) { t = i * h; w = (i == 0 || i == n) ? 1 : (i % 2 ? 4 : 2); x = beta * (cos(t) - 1); f = (x < -700) ? 0 : w * exp(x) * sin(t) * sin(t)
    den += f; if (t > ts) num += f }
  return num / den }
function edge_index(a, b, c, d, mu) { return EIDX[(a*8 + b*4 + c*2 + d) "," mu] }
function in01(x) { return x == 0 || x == 1 }
function cross(a1, a2, a3, b1, b2, b3) { CX[1] = a2*b3 - a3*b2; CX[2] = a3*b1 - a1*b3; CX[3] = a1*b2 - a2*b1 }
function F_and_grad(   p, l, m, k, a, s, nw, tot, f) {
  tot = 0; for (l = 0; l < 32; l++) for (a = 1; a <= 3; a++) G[l, a] = 0
  for (p = 0; p < nf; p++) {
    W[1] = 0; W[2] = 0; W[3] = 0
    for (k = 0; k < NP[p]; k++) { l = PA[p, k]; m = PB[p, k]; s = PSGN[p, k]   # ordered pairs (l, m) with S_p[l,m] = s
      cross(X[m,1], X[m,2], X[m,3], X[l,1], X[l,2], X[l,3]); W[1] += s * CX[1]; W[2] += s * CX[2]; W[3] += s * CX[3] }
    nw = sqrt(W[1]*W[1] + W[2]*W[2] + W[3]*W[3]); tot += nw
    if (nw > 1e-12) { U[1] = W[1]/nw; U[2] = W[2]/nw; U[3] = W[3]/nw
      for (k = 0; k < NP[p]; k++) { l = PA[p, k]; m = PB[p, k]; s = PSGN[p, k]   # dF/dx_l += 2 s (u x x_m)
        cross(U[1], U[2], U[3], X[m,1], X[m,2], X[m,3]); G[l,1] += 2*s*CX[1]; G[l,2] += 2*s*CX[2]; G[l,3] += 2*s*CX[3] } }
  }
  return tot
}
BEGIN {
  srand(20261029)
  ne = 0; for (v = 0; v < 16; v++) for (mu = 0; mu < 4; mu++) { bit = int(v / (2 ^ (3 - mu))) % 2; if (bit == 0) { EIDX[v "," mu] = ne; ne++ } }
  # the 24 faces: base v in {0,1}^4 with v_mu = v_nu = 0; edges in product order (v,mu,+),(v+e_mu,nu,+),(v+e_nu,mu,-),(v,nu,-)
  nf = 0
  for (a = 0; a <= 1; a++) for (b = 0; b <= 1; b++) for (c = 0; c <= 1; c++) for (d = 0; d <= 1; d++) for (mu = 0; mu < 4; mu++) for (nu = mu+1; nu < 4; nu++) {
    V[0] = a; V[1] = b; V[2] = c; V[3] = d; if (V[mu] != 0 || V[nu] != 0) continue
    for (k = 0; k < 4; k++) for (l = 0; l < 4; l++) EB[k, l] = V[l]
    EB[1, mu] += 1; EB[2, nu] += 1; ED[0] = mu; ED[1] = nu; ED[2] = mu; ED[3] = nu; ES[0] = 1; ES[1] = 1; ES[2] = -1; ES[3] = -1
    for (k = 0; k < 4; k++) FE[k] = edge_index(EB[k,0], EB[k,1], EB[k,2], EB[k,3], ED[k])
    n = 0; for (i = 0; i < 4; i++) for (j = 0; j < 4; j++) if (i != j) { PA[nf, n] = FE[i]; PB[nf, n] = FE[j]; PSGN[nf, n] = ES[i] * ES[j] * (i < j ? 1 : -1); n++ }
    NP[nf] = n; nf++ }
  printf "faces: %d (expect 24)\n", nf
  # the face-sharing adjacency's largest eigenvalue (the crude bound): 9-regular -> 9; check the degree
  delete DEG; for (p = 0; p < nf; p++) for (k = 0; k < NP[p]; k++) DEG[PA[p,k]]++
  mind = 99; maxd = 0; for (l = 0; l < 32; l++) { if (DEG[l] < mind) mind = DEG[l]; if (DEG[l] > maxd) maxd = DEG[l] }
  printf "face-sharing degree per edge: min %d max %d (ordered pairs; 9 neighbours each) -> crude M <= 9\n", mind, maxd
  # uniform check: x = a fixed unit 3-vector times the top singular vector of S is not needed; instead evaluate F at random x and ascend
  best = 0
  for (r = 0; r < 60; r++) {
    nx = 0; for (l = 0; l < 32; l++) for (a = 1; a <= 3; a++) { X[l,a] = rand() - 0.5; nx += X[l,a]*X[l,a] }
    nx = sqrt(nx); for (l = 0; l < 32; l++) for (a = 1; a <= 3; a++) X[l,a] /= nx
    step = 0.05; fprev = 0
    for (it = 0; it < 400; it++) { f = F_and_grad()
      # project the gradient onto the tangent space, step, renormalise
      dot = 0; for (l = 0; l < 32; l++) for (a = 1; a <= 3; a++) dot += G[l,a] * X[l,a]
      nx = 0; for (l = 0; l < 32; l++) for (a = 1; a <= 3; a++) { X[l,a] += step * (G[l,a] - dot * X[l,a]); nx += X[l,a]*X[l,a] }
      nx = sqrt(nx); for (l = 0; l < 32; l++) for (a = 1; a <= 3; a++) X[l,a] /= nx
      if (f < fprev) step *= 0.7; fprev = f }
    f = F_and_grad(); if (f > best) best = f
  }
  printf "M read from below (60 restarts, 400 ascent steps): %.4f   [uniform ||S|| = 5.9601; crude upper 9]\n", best
  for (pass = 1; pass <= 3; pass++) { Mv = (pass == 1 ? 5.9601 : (pass == 2 ? best : 9))
    lo = 0; hi = 1.5; for (k = 0; k < 60; k++) { mid = (lo + hi)/2; if (3 * cos(mid) - mid * Mv / 2 > 0) lo = mid; else hi = mid }
    tc = lo; blo = 5; bhi = 400; for (k = 0; k < 50; k++) { mid = (blo + bhi)/2; if (54.37 * mu1(mid, tc) > 1) blo = mid; else bhi = mid }
    printf "M = %.4f: theta_c = %.4f rad, Peierls floor (54.4 mu1 < 1) beta = %.1f, KP floor (C0 theta_c^2/(3 beta) < 0.1) beta = %.1f\n", Mv, tc, bhi, (32/3) * tc * tc / 0.3 }
}
