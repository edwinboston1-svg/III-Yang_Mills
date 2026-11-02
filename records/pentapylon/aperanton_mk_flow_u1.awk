# mk_flow_u1.awk -- THE MIGDAL-KADANOFF FLOW OF U(1) LATTICE GAUGE THEORY IN THE FOURIER BASIS, THE ABELIAN CONTROL OF mk_flow.awk
# (ΑΠΕΡΑΝΤΟΝ §53, 2026-10-28 20:1x; T4: every window argument is run on U(1) first, where the answer is deconfinement at large beta).
# THE OBJECT: the plaquette weight w(theta) = sum_n c_n e^{i n theta}, c_{-n} = c_n, c_0 = 1 (the Wilson weight exp(beta cos theta)
# has c_n = I_n(beta) / I_0(beta)); the MK step with b = 2 in d dimensions: bond-moving = the pointwise power w^(b^(d-2)), whose
# Fourier coefficients are the (b^(d-2))-fold convolution of c; the 2D decimation = the coefficients to the power b^2.  So in d = 4:
# c'_n = [ (c*c*c*c)_n / (c*c*c*c)_0 ]^4.  THE STAKE (§53, from the mechanism read on SU(2): the descent is the Haar measure's
# (theta / sin theta) factor, which U(1) lacks): at large beta the U(1) flow is MARGINAL up to exponentially small terms -- the
# descent per step falls to zero as beta grows (beta' - beta -> 0 like e^{-c beta} or a power), where SU(2)'s stays near 0.25.
# gawk traps honoured: 0 - x never -x; arrays named past the builtins; no parameter named after a builtin.
# usage: gawk -v D=4 -v BETA=4 [-v NMAX=120] [-v KMAX=40] -f mk_flow_u1.awk
function abs(x) { return x < 0 ? 0 - x : x }
function besseli(nu, x,   k, term, sum) { term = 1; for (k = 1; k <= nu; k++) term *= (x / 2) / k; sum = term
  for (k = 1; k <= 400; k++) { term *= (x / 2) * (x / 2) / (k * (k + nu)); sum += term; if (term < 1e-18 * sum) break }
  return sum }
function wilson(beta, n) { return besseli(n, beta) / besseli(0, beta) }
function beta_of_c1(c1,   lo, hi, mid, it) { if (c1 <= 0) return 0; lo = 0; hi = 1; while (wilson(hi, 1) < c1 && hi < 1e6) hi *= 2
  for (it = 0; it < 60; it++) { mid = (lo + hi) / 2; if (wilson(mid, 1) < c1) lo = mid; else hi = mid }; return (lo + hi) / 2 }
# the convolution of two symmetric coefficient sequences, cut at NMAX (indices 0..NMAX stand for |n|)
function conv(A, Bv, OUT,   m, n, k) {
  for (k = 0; k <= NMAX; k++) OUT[k] = 0
  for (m = 0 - NMAX; m <= NMAX; m++) { if (A[abs(m)] == 0) continue; for (n = 0 - NMAX; n <= NMAX; n++) { k = m + n; if (k < 0 || k > NMAX) continue; OUT[k] += A[abs(m)] * Bv[abs(n)] } } }
function mkstep(C, CN,   k, P2, P4, z) {
  if (D == 2) { for (k = 0; k <= NMAX; k++) CN[k] = C[k] ^ 4; return }
  conv(C, C, P2); if (D == 3) { z = P2[0]; for (k = 0; k <= NMAX; k++) CN[k] = (P2[k] / z) ^ 4; return }
  conv(P2, P2, P4); z = P4[0]; for (k = 0; k <= NMAX; k++) CN[k] = (P4[k] / z) ^ 4 }
BEGIN {
  if (D == "") D = 4; D += 0; if (BETA == "") BETA = 4; BETA += 0; if (NMAX == "") NMAX = 120; NMAX += 0; if (KMAX == "") KMAX = 40; KMAX += 0; if (BETA0 == "") BETA0 = 0.131; BETA0 += 0
  for (k = 0; k <= NMAX; k++) C[k] = wilson(BETA, k)
  printf "MKU1-FLOW d=%d beta=%s NMAX=%d c_1=%.12f c_2=%.12f c_NMAX=%.3e\n", D, BETA, NMAX, C[1], C[2], C[NMAX]
  be = BETA; kstar = -1; rises = 0
  for (step = 1; step <= KMAX; step++) { mkstep(C, CN); for (k = 0; k <= NMAX; k++) C[k] = CN[k]
    bprev = be; be = beta_of_c1(C[1])
    printf "MKU1-STEP d=%d beta=%s step=%d c_1=%.12f beta_eff=%.9f descent=%.3e c_2=%.12f (Wilson at beta_eff %.12f) %s\n", D, BETA, step, C[1], be, bprev - be, C[2], wilson(be, 2), (be > bprev) ? "RISE" : "descent"
    if (be > bprev) rises++
    if (be < BETA0 && kstar < 0) { kstar = step; break } }
  printf "MKU1-FLOW d=%d beta=%s K*=%d rises=%d final_beta_eff=%.9f %s\n", D, BETA, kstar, rises, be, (kstar > 0) ? "REACHES-STRONG-COUPLING" : "NOT-REACHED-IN-KMAX"
  printf "# mk_flow_u1 done\n"
}
