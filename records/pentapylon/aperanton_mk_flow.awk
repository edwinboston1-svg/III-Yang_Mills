# mk_flow.awk -- THE MIGDAL-KADANOFF FLOW OF SU(2) LATTICE GAUGE THEORY IN THE CHARACTER BASIS, EXACT UP TO THE CUT (ΑΠΕΡΑΝΤΟΝ
# §53, 2026-10-28 20:0x; the stakes in §53 before this run; HK=1 the heat-kernel start and the second-order law's prediction, 20:2x).
# THE OBJECT: the plaquette weight as a class function w(U) = sum_n d_n c_n chi_n(U), n = 2j, d_n = n + 1, c_0 = 1 (the Wilson
# weight exp((beta/2) tr U) has c_n = I_{n+1}(beta) / I_1(beta); the heat kernel of Gaussian width t has c_n = exp(-n(n+2) t/2));
# the Migdal-Kadanoff step with scale b = 2 in d dimensions: bond-moving puts b^(d-2) plaquettes of a plane onto one (the weight
# to the power b^(d-2), re-expanded in characters by the Clebsch-Gordan series chi_m chi_n = sum_{k = |m-n| .. m+n, step 2} chi_k),
# then the exact two-dimensional decimation of a b x b block (the coefficients to the power b^2 -- YM2's heat-kernel composition,
# exact in d = 2 where the step is c -> c^4 with no bond-moving).  So c'_n = [ (w^(b^(d-2)))_n / (w^(b^(d-2)))_0 ]^(b^2):
# d = 2: c' = c^4 (the known answer: a 2 x 2 block of Wilson plaquettes IS the four-plaquette loop, coefficient c^4);
# d = 3: c'_n = [(w^2)_n / (w^2)_0]^4;   d = 4: c'_n = [(w^4)_n / (w^4)_0]^4.  At tree level in d = 4 the step is the identity
# (beta' = beta, the marginal coupling); the nonlinear part is the MK beta-function: THE SECOND-ORDER LAW (§53 RESULTS 2) says a
# heat kernel of width t maps to one of width t + t^2/4 + t^3/12 + O(t^4), i.e. beta' = beta - 1/4 + O(1/beta), from the Haar
# measure's (theta/sin theta)^3 broadening of the bond-moved weight.  READINGS per step: c_1, beta_eff with c_1(beta_eff) = c_1
# (the Wilson form inverted), the deviation of c_2, c_3 from the Wilson form at beta_eff, the step's descent in beta_eff; the flow
# stops when beta_eff < BETA0 (the kernel's one-link threshold 0.131, §49) or after KMAX steps: K* the number of steps to the
# strongly-coupled place.  The cut at n <= NMAX is checked by printing c_NMAX; TAIL=1 reruns the first step with NMAX doubled.
# gawk traps honoured: 0 - x never -x; arrays named past the builtins; no parameter named after a builtin; exp guarded against underflow.
# usage: gawk -v D=4 -v BETA=2.3 [-v NMAX=60] [-v KMAX=40] [-v BETA0=0.131] [-v HK=1] [-v TAIL=1] -f mk_flow.awk
function abs(x) { return x < 0 ? 0 - x : x }
function gexp(x) { return (x < -700) ? 0 : exp(x) }
function besseli(nu, x,   k, term, sum) { term = 1; for (k = 1; k <= nu; k++) term *= (x / 2) / k; sum = term
  for (k = 1; k <= 400; k++) { term *= (x / 2) * (x / 2) / (k * (k + nu)); sum += term; if (term < 1e-18 * sum) break }
  return sum }
function wilson(beta, n) { return besseli(n + 1, beta) / besseli(1, beta) }
function beta_of_c1(c1,   lo, hi, mid, it) { if (c1 <= 0) return 0; lo = 0; hi = 1; while (wilson(hi, 1) < c1 && hi < 1e6) hi *= 2
  for (it = 0; it < 60; it++) { mid = (lo + hi) / 2; if (wilson(mid, 1) < c1) lo = mid; else hi = mid }; return (lo + hi) / 2 }
function cgprod(A, Bv, OUT,   m, n, k, acc) {
  for (k = 0; k <= NMAX; k++) OUT[k] = 0
  for (m = 0; m <= NMAX; m++) { if (A[m] == 0) continue; for (n = 0; n <= NMAX; n++) { if (Bv[n] == 0) continue; acc = (m + 1) * (n + 1) * A[m] * Bv[n]
    for (k = abs(m - n); k <= m + n && k <= NMAX; k += 2) OUT[k] += acc / (k + 1) } } }
function mkstep(C, CN,   k, P2, P4, z) {
  if (D == 2) { for (k = 0; k <= NMAX; k++) CN[k] = C[k] ^ 4; return }
  cgprod(C, C, P2)
  if (D == 3) { z = P2[0]; for (k = 0; k <= NMAX; k++) CN[k] = (P2[k] / z) ^ 4; return }
  cgprod(P2, P2, P4); z = P4[0]; for (k = 0; k <= NMAX; k++) CN[k] = (P4[k] / z) ^ 4 }
BEGIN {
  if (D == "") D = 4; D += 0; if (BETA == "") BETA = 2.3; BETA += 0; if (NMAX == "") NMAX = 60; NMAX += 0; if (KMAX == "") KMAX = 40; KMAX += 0; if (BETA0 == "") BETA0 = 0.131; BETA0 += 0; HK += 0
  if (HK) { t0 = 1 / BETA; for (k = 0; k <= NMAX; k++) C[k] = gexp(0 - k * (k + 2) * t0 / 2); t1 = t0 + t0 * t0 / 4
    printf "MK-HK beta=%s t=1/beta=%.9f: the heat-kernel start; the second-order law predicts after one step t1 = t + t^2/4 = %.9f, c_1 = %.12f, c_2 = %.12f, c_3 = %.12f\n", BETA, t0, t1, gexp(0 - 3 * t1 / 2), gexp(0 - 8 * t1 / 2), gexp(0 - 15 * t1 / 2) }
  else for (k = 0; k <= NMAX; k++) C[k] = wilson(BETA, k)
  printf "MK-FLOW d=%d beta=%s NMAX=%d HK=%d c_1=%.12f c_2=%.12f c_3=%.12f c_NMAX=%.3e (the d = 2 known answer is c -> c^4)\n", D, BETA, NMAX, HK, C[1], C[2], C[3], C[NMAX]
  be = BETA; kstar = -1; rises = 0
  for (step = 1; step <= KMAX; step++) { mkstep(C, CN); for (k = 0; k <= NMAX; k++) C[k] = CN[k]
    bprev = be; be = beta_of_c1(C[1]); dev2 = C[2] - wilson(be, 2); dev3 = C[3] - wilson(be, 3)
    if (HK && step == 1) { tm = 0 - 2 * log(C[1]) / 3; printf "MK-HK-STEP beta=%s after one step: c_1=%.12f (predicted %.12f, residual %.3e) c_2=%.12f (predicted %.12f, residual %.3e) c_3=%.12f (predicted %.12f, residual %.3e); the width read from c_1: t1=%.9f, t1 - t - t^2/4 = %.3e, over t^3 = %.5f (the cubic coefficient; 1/12 = 0.08333)\n", BETA, C[1], gexp(0 - 3 * t1 / 2), C[1] - gexp(0 - 3 * t1 / 2), C[2], gexp(0 - 8 * t1 / 2), C[2] - gexp(0 - 8 * t1 / 2), C[3], gexp(0 - 15 * t1 / 2), C[3] - gexp(0 - 15 * t1 / 2), tm, tm - t1, (tm - t1) / (t0 * t0 * t0) }
    printf "MK-STEP d=%d beta=%s step=%d c_1=%.12f beta_eff=%.9f descent=%.9f c_2=%.12f (Wilson at beta_eff %.12f, dev %.3e) c_3=%.12f (dev %.3e) c_NMAX=%.3e %s\n", D, BETA, step, C[1], be, bprev - be, C[2], wilson(be, 2), dev2, C[3], dev3, C[NMAX], (be > bprev) ? "RISE" : "descent"
    if (be > bprev) rises++
    if (be < BETA0 && kstar < 0) { kstar = step; break } }
  printf "MK-FLOW d=%d beta=%s K*=%d (steps to beta_eff < %s) rises=%d final_beta_eff=%.9f %s\n", D, BETA, kstar, BETA0, rises, be, (kstar > 0 && rises == 0) ? "DESCENDS-TO-STRONG-COUPLING" : (kstar > 0 ? "REACHES-STRONG-COUPLING-WITH-RISES" : "NOT-REACHED-IN-KMAX")
  if (TAIL) { NMAX2 = 2 * NMAX; for (k = 0; k <= NMAX2; k++) C[k] = HK ? gexp(0 - k * (k + 2) * (1 / BETA) / 2) : wilson(BETA, k); NMAXS = NMAX; NMAX = NMAX2; mkstep(C, CN); printf "MK-TAIL d=%d beta=%s NMAX=%d first-step c_1=%.12f (against NMAX=%d above)\n", D, BETA, NMAX2, CN[1], NMAXS }
  printf "# mk_flow done\n"
}
