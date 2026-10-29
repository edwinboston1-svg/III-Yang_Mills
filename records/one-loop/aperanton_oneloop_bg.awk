# aperanton_oneloop_bg.awk -- Σ1b's HARD HALF, PART (i), THE INSTRUMENT: the one-loop background dependence of the SU(2)
# Wilson fluctuation determinant (the ledger's §93-§94).  Bałaban's one-loop coefficient per step is the A-component of
# log Z^(k)(U) - log Z^(k)(1), Z the constrained Gaussian fluctuation integral (CMP 109 (1.3)-(1.4)); this instrument computes
# the UNCONSTRAINED lattice object first, whose answer is known, so that the constraint can be added to a checked core.
#
# THE OBJECT.  SU(2) Wilson action S = beta sum_p (1 - (1/2) Re Tr U_p) on an N^4 lattice; U = e^{iq} V with the abelian
# background V_mu(x) = exp(i a_mu(x) T3), a_2(x) = eps cos(p x_1), p = 2 pi/N, all other a zero (so only the 12-plaquettes carry
# flux, Phi(x_1) = a_2(x_1+1) - a_2(x_1)); fluctuations ANTIPERIODIC in all four directions (the IR regulator, no zero modes).
# The quadratic form in q (exact in the background, derived on the page §94): with the charged component w = q1 + i q2 and the
# plaquette's transported components p_1..p_4, s = p_1+p_2+p_3+p_4,
#   beta/8 [ cos(Phi/2)(|S3|^2 + |s|^2) - 2 sin(Phi/2) sum_{i<j} Im(conj(p_i) p_j) ]   on 12-plaquettes,
#   beta/8 [ |S3|^2 + |s|^2 ]                                                           on the others,
# plus the background-covariant Feynman gauge beta/8 |G|^2, G(x) = sum_mu [w_mu(x) - e^{i a_mu(x-mu)} w_mu(x-mu)], and the
# charged Faddeev-Popov operator sum_mu D_mu^dag D_mu.  The one-loop free energy F = -log Z is
#   F = log det M_vec - 2 log det M_gh   (the charged complex vector and its two real ghosts)
#     + (1/2) log det M_neu              (the neutral field, which feels the background only through cos(Phi/2)),
# each a product over the Fourier modes (k2, k3, k4) of a determinant on the x_1 line (4N, N and 4N square).
#
# THE READING.  With Sum_p Phi^2 = N^4 eps^2 phat^2/2 (phat^2 = 2 - 2 cos p) and S_eff = S + F:
#   Delta_N := beta_eff - beta = 16 [F(eps) - F(0)] / (eps^2 N^4 phat^2)  (Richardson in eps: 4F(eps) - F(2 eps) over 3).
# THE STAKE, written before the run: asymptotic freedom with the universal one-loop coefficient,
#   d beta_W / d ln(1/a) = 8 b0 = 11/(3 pi^2) = 0.371535 per e-fold, 0.257527 per doubling (beta_W = 4/g^2, b0 = 11/(24 pi^2)),
# so Delta_N - Delta_2N -> +0.2575 as N -> infinity (the IR scale is 1/N on both sides: the external momentum and the
# antiperiodic cutoff halve together); at N = 8 -> 16 within [0.22, 0.30].  THE CONTROLS: the neutral sector alone is the U(1)
# line -- no charge, no log: |Delta^neu_N - Delta^neu_2N| < 0.02; at eps = 0 the Feynman-gauge identity M_vec = M_gh (x) 1_4
# must hold to rounding (printed as FEYNMAN-IDENTITY); the free massless field has no background coupling (eps = 0 reads 0).
# usage: gawk -v N=8 [-v EPS=0.01] -f aperanton_oneloop_bg.awk
function cmul_r(ar, ai, br, bi) { return ar * br - ai * bi }
function cmul_i(ar, ai, br, bi) { return ar * bi + ai * br }
# add the rank-one form conj(v) v^T of the functional s = sum_j v_j w_j (stored in VR/VI over the index list VJ[1..nv])
function add_form(wt,   a, b, ja, jb) {
  for (a = 1; a <= nv; a++) for (b = 1; b <= nv; b++) { ja = VJ[a]; jb = VJ[b]
    MR[ja, jb] += wt * (VR[a] * VR[b] + VI[a] * VI[b]); MI[ja, jb] += wt * (VR[a] * VI[b] - VI[a] * VR[b]) } }
function vclear() { nv = 0 }
function vadd(j, cr, ci,   a) { for (a = 1; a <= nv; a++) if (VJ[a] == j) { VR[a] += cr; VI[a] += ci; return }
  nv++; VJ[nv] = j; VR[nv] = cr; VI[nv] = ci }
# the x_1 neighbour with the antiperiodic wrap: sets NX (index) and SG (sign)
function nxt(x) { if (x == N - 1) { NX = 0; SG = -1 } else { NX = x + 1; SG = 1 } }
function prv(x) { if (x == 0) { NX = N - 1; SG = -1 } else { NX = x - 1; SG = 1 } }
function idx(mu, x) { return (mu - 1) * N + x }
function mclear(n,   i, j) { for (i = 0; i < n; i++) for (j = 0; j < n; j++) { MR[i, j] = 0; MI[i, j] = 0 } }
# complex Cholesky of the Hermitian positive matrix MR/MI (n x n): returns log det (refuses by name if not positive)
function logdet(n,   i, j, k, d, sr, si, ld) { ld = 0
  for (j = 0; j < n; j++) {
    d = MR[j, j]; for (k = 0; k < j; k++) d -= LR[j, k] * LR[j, k] + LI[j, k] * LI[j, k]
    if (d <= 0) { print "REFUSED not-positive at " j " d=" d; exit 3 }
    LR[j, j] = sqrt(d); LI[j, j] = 0; ld += log(d)
    for (i = j + 1; i < n; i++) { sr = MR[i, j]; si = MI[i, j]
      for (k = 0; k < j; k++) { sr -= LR[i, k] * LR[j, k] + LI[i, k] * LI[j, k]; si -= LI[i, k] * LR[j, k] - LR[i, k] * LI[j, k] }
      LR[i, j] = sr / LR[j, j]; LI[i, j] = si / LR[j, j] } }
  return ld }
# the charged vector operator at momenta (k2, k3, k4) and background amplitude e (into MR/MI, size 4N); CHARGED = 1 keeps the
# transport phases and the spin term, CHARGED = 0 gives the neutral operator (no phases, cos weight only)
function build_vec(k2, k3, k4, e, charged,   x, al0, al1, phi, c, s, cr, ci, a, b, j, pr, pi_, wt) {
  mclear(4 * N)
  for (x = 0; x < N; x++) {
    al0 = e * cos(P * x); nxt(x); al1 = e * cos(P * (x + 1)); phi = al1 - al0
    if (!charged) { al0c = 0; al1c = 0 } else { al0c = al0; al1c = al1 }
    # (1,2): p1 = w1(x), p2 = w2(x+1), p3 = -e^{-i al(x+1)} e^{i k2} w1(x), p4 = -e^{-i Phi} w2(x)
    PJ[1] = idx(1, x); PCR[1] = 1; PCI[1] = 0
    PJ[2] = idx(2, NX); PCR[2] = SG; PCI[2] = 0
    PJ[3] = idx(1, x); PCR[3] = -cos(k2 - al1c); PCI[3] = -sin(k2 - al1c)
    PJ[4] = idx(2, x); PCR[4] = -cos(charged ? phi : 0); PCI[4] = (charged ? sin(phi) : 0)
    vclear(); for (a = 1; a <= 4; a++) vadd(PJ[a], PCR[a], PCI[a])
    add_form(cos(phi / 2))
    if (charged) { s = sin(phi / 2)
      for (a = 1; a <= 4; a++) for (b = a + 1; b <= 4; b++) {
        # M[n_a, n_b] += i s conj(c_a) c_b ; M[n_b, n_a] += -i s conj(c_b) c_a
        pr = PCR[a] * PCR[b] + PCI[a] * PCI[b]; pi_ = PCR[a] * PCI[b] - PCI[a] * PCR[b]
        MR[PJ[a], PJ[b]] += -s * pi_; MI[PJ[a], PJ[b]] += s * pr
        MR[PJ[b], PJ[a]] += -s * pi_; MI[PJ[b], PJ[a]] += -s * pr } }
    # (1,3) and (1,4): w1(x)(1 - e^{ik}) + w_nu(x+1) - w_nu(x)
    for (nu = 3; nu <= 4; nu++) { kk = (nu == 3 ? k3 : k4)
      vclear(); vadd(idx(1, x), 1 - cos(kk), -sin(kk)); vadd(idx(nu, NX), SG, 0); vadd(idx(nu, x), -1, 0); add_form(1) }
    # (2,3) and (2,4): w2(x)(1 - e^{ik}) + w_nu(x)(e^{-i al(x)} e^{i k2} - 1)
    for (nu = 3; nu <= 4; nu++) { kk = (nu == 3 ? k3 : k4)
      vclear(); vadd(idx(2, x), 1 - cos(kk), -sin(kk)); vadd(idx(nu, x), cos(k2 - al0c) - 1, sin(k2 - al0c)); add_form(1) }
    # (3,4): w3(x)(1 - e^{i k4}) + w4(x)(e^{i k3} - 1)
    vclear(); vadd(idx(3, x), 1 - cos(k4), -sin(k4)); vadd(idx(4, x), cos(k3) - 1, sin(k3)); add_form(1)
    # the gauge fixing G(x) = w1(x) - w1(x-1) + (1 - e^{i(al(x) - k2)}) w2(x) + (1 - e^{-i k3}) w3(x) + (1 - e^{-i k4}) w4(x)
    vclear(); vadd(idx(1, x), 1, 0); prv(x); vadd(idx(1, NX), -SG, 0)
    vadd(idx(2, x), 1 - cos(al0c - k2), -sin(al0c - k2)); vadd(idx(3, x), 1 - cos(k3), sin(k3)); vadd(idx(4, x), 1 - cos(k4), sin(k4))
    add_form(1)
  }
}
# the charged ghost operator sum_mu D_mu^dag D_mu on the x_1 line (size N)
function build_gh(k2, k3, k4, e,   x, al0) {
  mclear(N)
  for (x = 0; x < N; x++) { al0 = e * cos(P * x)
    vclear(); nxt(x); vadd(NX, SG, 0); vadd(x, -1, 0); add_form(1)
    vclear(); vadd(x, cos(k2 - al0) - 1, sin(k2 - al0)); add_form(1)
    vclear(); vadd(x, cos(k3) - 1, sin(k3)); add_form(1)
    vclear(); vadd(x, cos(k4) - 1, sin(k4)); add_form(1) }
}
function freeenergy(e,   n2, n3, n4, k2, k3, k4, w, fv, fg, fn) {
  FV = 0; FG = 0; FN = 0
  for (n2 = 0; n2 < N / 2; n2++) for (n3 = 0; n3 < N / 2; n3++) for (n4 = 0; n4 < N / 2; n4++) {
    k2 = (2 * PI * n2 + PI) / N; k3 = (2 * PI * n3 + PI) / N; k4 = (2 * PI * n4 + PI) / N; w = 8
    build_vec(k2, k3, k4, e, 1); FV += w * logdet(4 * N)
    build_gh(k2, k3, k4, e); FG += w * (-2) * logdet(N)
    build_vec(k2, k3, k4, e, 0); FN += w * 0.5 * logdet(4 * N) }
}
BEGIN {
  if (!N) N = 8; if (N % 2) { print "REFUSED odd N"; exit 2 }
  EPS = (EPS ? EPS : 0.01); PI = atan2(0, -1); P = 2 * PI / N; phat2 = 2 - 2 * cos(P)
  # the Feynman-gauge identity at eps = 0, one momentum: M_vec = M_gh (x) 1_4
  k2 = PI / N; k3 = 3 * PI / N; k4 = 5 * PI / N
  build_gh(k2, k3, k4, 0); for (i = 0; i < N; i++) for (j = 0; j < N; j++) { GR[i, j] = MR[i, j]; GI[i, j] = MI[i, j] }
  build_vec(k2, k3, k4, 0, 1); dev = 0
  for (mu = 1; mu <= 4; mu++) for (nu = 1; nu <= 4; nu++) for (i = 0; i < N; i++) for (j = 0; j < N; j++) {
    tr = (mu == nu) ? GR[i, j] : 0; ti = (mu == nu) ? GI[i, j] : 0
    d = MR[idx(mu, i), idx(nu, j)] - tr; if (d < 0) d = -d; if (d > dev) dev = d
    d = MI[idx(mu, i), idx(nu, j)] - ti; if (d < 0) d = -d; if (d > dev) dev = d }
  printf "FEYNMAN-IDENTITY N=%d max|M_vec - M_gh x 1_4| = %.3e\n", N, dev
  freeenergy(0); F0V = FV; F0G = FG; F0N = FN
  freeenergy(EPS); F1V = FV; F1G = FG; F1N = FN
  freeenergy(2 * EPS); F2V = FV; F2G = FG; F2N = FN
  # Richardson: the eps^2 coefficient from F(eps) and F(2 eps) with the eps^4 term removed
  cV = (16 * (F1V - F0V) - (F2V - F0V)) / (12 * EPS * EPS)
  cG = (16 * (F1G - F0G) - (F2G - F0G)) / (12 * EPS * EPS)
  cN = (16 * (F1N - F0N) - (F2N - F0N)) / (12 * EPS * EPS)
  norm = 16 / (N ^ 4 * phat2)
  printf "ONELOOP-BG N=%d eps=%g Delta_vec=%.6f Delta_gh=%.6f Delta_neu=%.6f Delta=%.6f\n", N, EPS, norm * cV, norm * cG, norm * cN, norm * (cV + cG + cN)
}
