# feven_norm.awk -- certified enclosure of E[g^p] for g = f_even = cosh(beta/2 tr U)/c0 - 1 (the integer-spin part of the plaquette
# weight) and of f_odd likewise, p = 2, 4, 6, at beta = P/Q.  M1c, 2026-11-02.
# For U in SU(2) with tr U = 2x, x = cos(psi), psi with density (2/pi) sin^2(psi): E[e^{t x}] = Phi(t) := 2 I_1(|t|)/|t| = sum_m (t^2/4)^m/(m!(m+1)!).
# cosh(beta x)^k = 2^{-k} sum_i C(k,i) e^{(k-2i) beta x}, so E[(cosh(beta x)/c0 - 1)^p] = sum_k C(p,k)(-1)^{p-k} c0^{-k} 2^{-k} sum_i C(k,i) Phi((k-2i)beta),
# c0 = Phi(beta).  f_odd = sinh(beta x)/c0 (odd in x): E[f_odd^p] for even p = c0^{-p} 2^{-p} sum_i C(p,i)(-1)^i Phi((p-2i)beta).
# Every Phi is an interval [lo, hi] of integers on the grid 2^-GB (partial sum floored/ceiled; tail <= 2 * the first omitted term once the
# ratio is below 1/2, checked); products of intervals by sign; the alternating sums by sign.  KAT: E[g^2] against sum_{j in N, j>=1} d_j^2 a_j^2
# with a_j = I_{2j+1}/I_1 from their own series (a second road for p = 2), and E[f_odd^2] against sum_{j half-int} d_j^2 a_j^2.
# Output: E[g^p] in [lo, hi] and the p-th root's upper bound ||g||_p <= R (the least grid point with R^p >= hi).
# usage: gawk -M -v P=4764 -v Q=10000 -f feven_norm.awk
function fdiv(n, d,   r) { r = n % d; if (r < 0) r += d; return (n - r) / d }
function cdiv(n, d,   q) { q = fdiv(n, d); return (q * d == n) ? q : q + 1 }
function binom(n, k,   r, i) { r = 1; for (i = 1; i <= k; i++) r = r * (n - k + i) / i; return r }
# Phi(t) at t = num/den (num >= 0): sets PL, PH on the grid
function phi(num, den,   t2n, t2d, termN, termD, m, sl, sh, tN, tD, lastN, lastD) {
  # term_m = (t^2/4)^m / (m! (m+1)!) as an exact rational termN/termD
  t2n = num * num; t2d = 4 * den * den; termN = 1; termD = 1; sl = 0; sh = 0; m = 0
  while (1) { sl += fdiv(termN * SCALE, termD); sh += cdiv(termN * SCALE, termD)
    # next term: multiply by t2/((m+1)(m+2))
    termN = termN * t2n; termD = termD * t2d * (m + 1) * (m + 2); m++
    # stop when the next term is below 2^-(GB+8) and the ratio t2/((m+1)(m+2)) <= 1/2 (then the tail is <= 2 * term)
    if (2 * t2n <= t2d * (m + 1) * (m + 2) && termN * SCALE * 256 < termD) { sh += 2 * cdiv(termN * SCALE, termD) + 1; break } }
  PL = sl; PH = sh }
# interval product of two nonnegative intervals
function mlo(a, b) { return fdiv(a * b, SCALE) }
function mhi(a, b) { return cdiv(a * b, SCALE) }
BEGIN { GB = (GB ? GB : 512); SCALE = 2 ^ GB; if (!P) { P = 4764; Q = 10000 }
  # c0 = Phi(beta), 1/c0 interval
  phi(P, Q); C0L = PL; C0H = PH; IC0L = fdiv(SCALE * SCALE, C0H); IC0H = cdiv(SCALE * SCALE, C0L)
  # Phi(n beta) for n = 0..6
  for (n = 0; n <= 6; n++) { phi(n * P, Q); FL[n] = PL; FH[n] = PH }
  for (p = 2; p <= 6; p += 2) {
    lo = 0; hi = 0
    for (k = 0; k <= p; k++) {
      # A_k = E[cosh^k] = 2^-k sum_i C(k,i) Phi(|k-2i| beta)
      al = 0; ah = 0; for (i = 0; i <= k; i++) { nn = k - 2 * i; if (nn < 0) nn = -nn; al += binom(k, i) * FL[nn]; ah += binom(k, i) * FH[nn] }
      al = fdiv(al, 2 ^ k); ah = cdiv(ah, 2 ^ k)
      # c0^-k
      cl = SCALE; ch = SCALE; for (t = 0; t < k; t++) { cl = mlo(cl, IC0L); ch = mhi(ch, IC0H) }
      tl = mlo(al, cl); th = mhi(ah, ch); co = binom(p, k); sg = ((p - k) % 2 == 0) ? 1 : -1
      if (sg > 0) { lo += co * tl; hi += co * th } else { lo -= co * th; hi -= co * tl } }
    EGL[p] = lo; EGH[p] = hi
    # f_odd: E[sinh^p] = 2^-p sum_i C(p,i) (-1)^i e^{(p-2i) beta x} -> Phi
    ol = 0; oh = 0; for (i = 0; i <= p; i++) { nn = p - 2 * i; if (nn < 0) nn = -nn; co = binom(p, i); if (i % 2 == 0) { ol += co * FL[nn]; oh += co * FH[nn] } else { ol -= co * FH[nn]; oh -= co * FL[nn] } }
    ol = fdiv(ol, 2 ^ p); oh = cdiv(oh, 2 ^ p); cl = SCALE; ch = SCALE; for (t = 0; t < p; t++) { cl = mlo(cl, IC0L); ch = mhi(ch, IC0H) }
    if (ol < 0) ol = 0; EOL[p] = mlo(ol, cl); EOH[p] = mhi(oh, ch) }
  # KAT, second road for p = 2: sum_j d_j^2 a_j^2, a_j = I_{2j+1}(beta)/I_1(beta), I_n by its series (exact rationals, floats only for printing)
  # I_n(beta) / (beta/2)^n = sum_m (beta^2/4)^m/(m!(m+n)!); a_j = (beta/2)^{2j} * S_{2j+1} / S_1
  for (n = 1; n <= 17; n++) { sN = 0; sD = 1; tN = 1; tD = 1; for (j = 1; j <= n; j++) tD *= j; for (m = 0; m < 60; m++) { sN = sN * tD + tN * sD; sD = sD * tD; g = 1; tN = tN * P * P; tD = tD * 4 * Q * Q * (m + 1) * (m + 1 + n) }
    SN[n] = sN; SD[n] = sD }
  ke = 0; ko = 0
  for (n = 2; n <= 16; n++) { # j = (n-1)/2, d_j = n
    aN = SN[n] * SD[1] * P ^ (n - 1); aD = SD[n] * SN[1] * (2 * Q) ^ (n - 1)
    v = n * n * aN * aN * SCALE / (aD * aD); if (n % 2 == 1) ke += v; else ko += v }
  printf "FEVEN beta=%d/%d: c0 in [%.30e, %.30e]\n", P, Q, C0L / SCALE, C0H / SCALE
  for (p = 2; p <= 6; p += 2) printf "FEVEN E[f_even^%d] in [%.20e, %.20e]   E[f_odd^%d] in [%.20e, %.20e]\n", p, EGL[p] / SCALE, EGH[p] / SCALE, p, EOL[p] / SCALE, EOH[p] / SCALE
  printf "FEVEN KAT (p = 2, second road from the Bessel ratios, j <= 15/2): sum_{j int} d_j^2 a_j^2 = %.20e   sum_{j half} d_j^2 a_j^2 = %.20e\n", ke / SCALE, ko / SCALE
  # p-th roots, upper bound on the grid 2^-128 (coarser grid for the reported root)
  for (p = 2; p <= 6; p += 2) { G2 = 2 ^ 128; tgt = cdiv(EGH[p] * G2 ^ p, SCALE); lo2 = 0; hi2 = G2; while (hi2 - lo2 > 1) { mid = fdiv(lo2 + hi2, 2); if (mid ^ p >= tgt) hi2 = mid; else lo2 = mid }
    ROOTP[p] = hi2; printf "FEVEN ||f_even||_%d <= %.20e  (the least x on the 2^-128 grid with x^%d >= the upper end; as a rational x = %s/2^128)\n", p, hi2 / G2, p, hi2 }
  # a_1 for reference and the ratio ||f_even||_6 / a_1
  a1 = (SN[3] * SD[1] * P ^ 2) / (SD[3] * SN[1] * 4 * Q * Q)
  printf "FEVEN a_1 = %.15e   ||f_even||_6 / a_1 <= %.10f   (15^{1/6} * 3 = %.10f is the spin-1 leading value)\n", a1, (ROOTP[6] / 2 ^ 128) / a1, 3 * 15 ^ (1 / 6) }
