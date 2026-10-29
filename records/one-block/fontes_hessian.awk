# fontes_hessian.awk -- re-derive R. Fontes's one-block constants (ym_v65.tex, Theorem thm:spectrum, Theorem thm:antisym) with
# the tree's own hands, and beside them the FULL-EMBEDDING Hessian his enumeration omits.  Pure gawk, no library.
#   The block B = {0,1}^4, its 32 edges ("interior links"): (v, mu) with v in B, v_mu = 0.
#   A plaquette (v, mu, nu), mu < nu, has the oriented edges (v,mu,+), (v+e_mu,nu,+), (v+e_nu,mu,-), (v,nu,-).
#   FONTES's set: base vertices v in {0,1,2}^4 (his code: product(range(3), repeat=4)) with at least one interior edge -> 72.
#   THE FULL set: base vertices v in {-1,0,1,2}^4 with at least one interior edge -> every plaquette meeting the block.
#   H = P^T P (32 x 32 integer); eigenvalues by cyclic Jacobi (double precision; the full set's spectrum is integral and is
#   also checked EXACTLY by the annihilating polynomial (H-3)(H-7)(H-9)(H-11) = 0 in integer arithmetic).
#   S (the Christoffel link-coupling matrix) over the 24 faces: S_{ll'} = sum_p eps_l eps_l' s(l before l'), antisymmetric;
#   ||S||^2 = lambda_max(S^T S) = lambda_max(-S^2).
function vkey(a, b, c, d) { return a "," b "," c "," d }
function edge_index(a, b, c, d, mu,   v) { v = (a*8 + b*4 + c*2 + d); return EIDX[v "," mu] }
function in01(x) { return x == 0 || x == 1 }
function build(lo,   a, b, c, d, mu, nu, i, j, n, e, sgn, key, ea, eb, ec, ed, emu, k, l) {
  # enumerate plaquettes with base coordinates in [lo, 2]
  np = 0; delete P; delete PL; delete PS; delete PN
  for (a = lo; a <= 2; a++) for (b = lo; b <= 2; b++) for (c = lo; c <= 2; c++) for (d = lo; d <= 2; d++)
    for (mu = 0; mu < 4; mu++) for (nu = mu + 1; nu < 4; nu++) {
      V[0] = a; V[1] = b; V[2] = c; V[3] = d
      # the four oriented edges: (base, dir, sign) in product order
      for (k = 0; k < 4; k++) { for (l = 0; l < 4; l++) EB[k, l] = V[l] }
      EB[1, mu] += 1; EB[2, nu] += 1
      ED[0] = mu; ED[1] = nu; ED[2] = mu; ED[3] = nu
      ES[0] = 1; ES[1] = 1; ES[2] = -1; ES[3] = -1
      n = 0
      for (k = 0; k < 4; k++) {
        if (in01(EB[k,0]) && in01(EB[k,1]) && in01(EB[k,2]) && in01(EB[k,3]) && EB[k, ED[k]] == 0) {
          e = edge_index(EB[k,0], EB[k,1], EB[k,2], EB[k,3], ED[k]); PL[np, n] = e; PS[np, n] = ES[k]; PN[np, n] = k; n++ } }
      if (n > 0) { PC[np] = n; np++ }
    }
  return np
}
function hessian(   p, i, j) { delete H; for (i = 0; i < 32; i++) for (j = 0; j < 32; j++) H[i, j] = 0
  for (p = 0; p < np; p++) for (i = 0; i < PC[p]; i++) for (j = 0; j < PC[p]; j++) H[PL[p, i], PL[p, j]] += PS[p, i] * PS[p, j] }
function trace(M, n,   i, t) { t = 0; for (i = 0; i < n; i++) t += M[i, i]; return t }
function jacobi(M, n, EV,   A, i, j, k, off, t, c, s, th, tau, aii, ajj, aij, sweep, g, h) {
  for (i = 0; i < n; i++) for (j = 0; j < n; j++) A[i, j] = M[i, j]
  for (sweep = 0; sweep < 100; sweep++) {
    off = 0; for (i = 0; i < n; i++) for (j = i + 1; j < n; j++) off += A[i, j] * A[i, j]
    if (off < 1e-22) break
    for (i = 0; i < n; i++) for (j = i + 1; j < n; j++) {
      if (A[i, j] == 0) continue
      th = (A[j, j] - A[i, i]) / (2 * A[i, j]); t = (th >= 0 ? 1 : -1) / (sqrt(th * th + 1) + (th >= 0 ? th : -th))
      c = 1 / sqrt(t * t + 1); s = t * c
      for (k = 0; k < n; k++) { g = A[k, i]; h = A[k, j]; A[k, i] = c * g - s * h; A[k, j] = s * g + c * h }
      for (k = 0; k < n; k++) { g = A[i, k]; h = A[j, k]; A[i, k] = c * g - s * h; A[j, k] = s * g + c * h }
    }
  }
  for (i = 0; i < n; i++) EV[i] = A[i, i]
  # sort ascending
  for (i = 0; i < n; i++) for (j = i + 1; j < n; j++) if (EV[j] < EV[i]) { t = EV[i]; EV[i] = EV[j]; EV[j] = t }
  return sweep
}
function spectrum_line(EV, n,   i, s, cur, m, out) {
  out = ""; cur = EV[0]; m = 1
  for (i = 1; i <= n; i++) { if (i < n && EV[i] - cur < 1e-6) { m++; continue }
    out = out sprintf("%.6f x%d  ", cur, m); if (i < n) { cur = EV[i]; m = 1 } }
  return out
}
BEGIN {
  # edges of the 4-cube: index 0..31
  ne = 0
  for (v = 0; v < 16; v++) for (mu = 0; mu < 4; mu++) { bit = int(v / (2 ^ (3 - mu))) % 2; if (bit == 0) { EIDX[v "," mu] = ne; ne++ } }
  printf "edges of the block: %d\n", ne
  # ---- Fontes's enumeration: base in {0,1,2}^4
  n72 = build(0); hessian(); t72 = trace(H, 32)
  printf "FONTES SET: plaquettes=%d trace=%d\n", n72, t72
  for (i = 0; i < 32; i++) for (j = 0; j < 32; j++) H72[i, j] = H[i, j]
  jacobi(H72, 32, EV72); printf "  spectrum: %s\n", spectrum_line(EV72, 32)
  # per-edge external count (diagonal minus faces): how many external plaquettes each edge gets in his set
  delete DEG; for (i = 0; i < 32; i++) DEG[H72[i, i]]++
  s = ""; for (k = 0; k <= 6; k++) if (DEG[k] > 0) s = s sprintf("diag=%d:%d  ", k, DEG[k]); printf "  diagonal census: %s\n", s
  # ---- the full embedding: base in {-1,0,1,2}^4
  n120 = build(-1); hessian(); t120 = trace(H, 32)
  printf "FULL SET: plaquettes=%d trace=%d\n", n120, t120
  for (i = 0; i < 32; i++) for (j = 0; j < 32; j++) HF[i, j] = H[i, j]
  jacobi(HF, 32, EVF); printf "  spectrum: %s\n", spectrum_line(EVF, 32)
  delete DEG; for (i = 0; i < 32; i++) DEG[HF[i, i]]++
  s = ""; for (k = 0; k <= 6; k++) if (DEG[k] > 0) s = s sprintf("diag=%d:%d  ", k, DEG[k]); printf "  diagonal census: %s\n", s
  # exact annihilating polynomial (H-3)(H-7)(H-9)(H-11) on the full set, integer arithmetic
  for (i = 0; i < 32; i++) for (j = 0; j < 32; j++) M[i, j] = (i == j)
  split("3 7 9 11", R, " ")
  for (r = 1; r <= 4; r++) { for (i = 0; i < 32; i++) for (j = 0; j < 32; j++) { s = 0; for (k = 0; k < 32; k++) s += M[i, k] * (HF[k, j] - (k == j) * R[r]); N[i, j] = s }
    for (i = 0; i < 32; i++) for (j = 0; j < 32; j++) M[i, j] = N[i, j] }
  z = 0; for (i = 0; i < 32; i++) for (j = 0; j < 32; j++) if (M[i, j] != 0) z++
  printf "  (H-3)(H-7)(H-9)(H-11) nonzero entries: %d  (0 = the spectrum is contained in {3,7,9,11} EXACTLY)\n", z
  # traces of H, H^2, H^3 for the multiplicities (exact integers)
  for (i = 0; i < 32; i++) for (j = 0; j < 32; j++) { s = 0; for (k = 0; k < 32; k++) s += HF[i, k] * HF[k, j]; H2[i, j] = s }
  for (i = 0; i < 32; i++) for (j = 0; j < 32; j++) { s = 0; for (k = 0; k < 32; k++) s += H2[i, k] * HF[k, j]; H3[i, j] = s }
  printf "  tr H=%d tr H^2=%d tr H^3=%d  (15,6,8,3 at 3,7,9,11 predict 192, 1440, 11952)\n", trace(HF, 32), trace(H2, 32), trace(H3, 32)
  # ---- the Christoffel matrix S over the 24 faces (base in {0,1}^4 with v_mu = v_nu = 0: exactly the plaquettes with 4 interior edges)
  nf = 0; delete S; for (i = 0; i < 32; i++) for (j = 0; j < 32; j++) S[i, j] = 0
  for (p = 0; p < np; p++) if (PC[p] == 4) { nf++
    for (i = 0; i < 4; i++) for (j = 0; j < 4; j++) if (i != j) S[PL[p, i], PL[p, j]] += PS[p, i] * PS[p, j] * (PN[p, i] < PN[p, j] ? 1 : -1) }
  tSS = 0; for (i = 0; i < 32; i++) for (j = 0; j < 32; j++) tSS += S[i, j] * S[i, j]
  for (i = 0; i < 32; i++) for (j = 0; j < 32; j++) { s = 0; for (k = 0; k < 32; k++) s += S[k, i] * S[k, j]; STS[i, j] = s }
  jacobi(STS, 32, EVS)
  printf "FACES: %d  tr(S^T S)=%d  ||S||^2 = %.6f  ||S|| = %.6f  (Fontes: 288; [35.52, 35.53]; 5.96)\n", nf, tSS, EVS[31], sqrt(EVS[31])
  printf "  S^T S spectrum: %s\n", spectrum_line(EVS, 32)
  # the Christoffel threshold: lambda cos t - t ||S||/2 = 0, for lambda = 0.6893 (his) and for the full set's lambda_min
  for (pass = 1; pass <= 2; pass++) { lam = (pass == 1 ? 0.6893 : EVF[0]); lo = 0; hi = 1.5
    for (k = 0; k < 60; k++) { mid = (lo + hi) / 2; if (lam * cos(mid) - mid * 6.01 / 2 > 0) lo = mid; else hi = mid }
    printf "  theta_c(lambda_min=%.4f, ||S||=6.01) = %.4f rad;  ln20/(1-cos theta_c) = %.2f\n", lam, lo, log(20) / (1 - cos(lo)) }
}
