# aperanton_bessel_cert.awk -- CERTIFIED RATIONAL ENCLOSURES OF THE STRONG-COUPLING CHARACTER COEFFICIENTS a_j(beta) = I_{2j+1}(beta)/I_1(beta)
# (the flux-surface gas's u = a_{1/2} = I_2/I_1 and the higher spins), for C2 of the trunk's lane: every quantity an EXACT RATIONAL
# interval [lo, hi] in gawk -M integers -- the only approximation is the truncation of the Bessel series, and its tail is a closed
# form.  I_nu(x) = sum_{k>=0} (x/2)^{2k+nu} / (k! (k+nu)!), every term positive; after K terms the tail is at most 2 t_{K+1} since
# consecutive terms have ratio z/((k+1)(k+nu+1)) <= 1/2 for z = x^2/4 <= 1 (beta <= 2).  So I_nu in [S_K, S_K + 2 t_{K+1}] exactly,
# and a quotient of enclosures is enclosed by the crossed quotients (positivity).  Rationals are (num, den) pairs of big integers,
# reduced by gcd; nothing is ever rounded except the DECIMAL PRINT, which rounds outward.  beta is given as a rational P/Q.
# Doors (for a certificate that @includes this file):  bessel_lo(nu) / bessel_hi(nu) set RN, RD to the enclosure's ends of
# I_nu(beta); aj_lo(j2) / aj_hi(j2) the ends of a_{j2/2} = I_{j2+1}/I_1; rat_* the interval arithmetic.
# KAT (run standalone): a_{1/2}(1) = I_2(1)/I_1(1) = 0.240194 (A&S: I_1(1) = 0.565159104, I_2(1) = 0.135747670) and a_{1/2}(1/4)
# against the same series in MPFR floats at 256 bits (a second road to the truncation only), and the enclosure's width.
# gawk traps honoured: 0 - x never -x; arrays named past the builtins; one BEGIN scope, names read whole.
# usage: gawk -M [-v P=2452 -v Q=10000] [-v K=24] -f aperanton_bessel_cert.awk
function gcd(a, b,   t) { if (a < 0) a = 0 - a; if (b < 0) b = 0 - b; while (b != 0) { t = a % b; a = b; b = t } return a }
function rat_set(n, d,   g) { if (d < 0) { n = 0 - n; d = 0 - d } g = gcd(n, d); if (g > 1) { n /= g; d /= g } RN = n; RD = d }
function fact(n,   r, i) { r = 1; for (i = 2; i <= n; i++) r *= i; return r }
# the K-term partial sum of I_nu at beta = P/Q as a rational (SN, SD), and the (K+1)-th term (TN, TD)
function bessel_series(nu,   k, num, den, sn, sd, tn, td, g) {
  sn = 0; sd = 1
  for (k = 0; k <= K; k++) { num = P ^ (2 * k + nu); den = (2 * Q) ^ (2 * k + nu) * fact(k) * fact(k + nu)
    sn = sn * den + num * sd; sd = sd * den; g = gcd(sn, sd); if (g > 1) { sn /= g; sd /= g } }
  tn = P ^ (2 * (K + 1) + nu); td = (2 * Q) ^ (2 * (K + 1) + nu) * fact(K + 1) * fact(K + 1 + nu); g = gcd(tn, td); if (g > 1) { tn /= g; td /= g }
  SN = sn; SD = sd; TN = tn; TD = td }
function bessel_lo(nu) { bessel_series(nu); rat_set(SN, SD) }
function bessel_hi(nu) { bessel_series(nu); rat_set(SN * TD + 2 * TN * SD, SD * TD) }
# a_{j2/2} = I_{j2+1} / I_1: lo = lo(I_{j2+1}) / hi(I_1), hi = hi(I_{j2+1}) / lo(I_1)
function aj_lo(j2,   n1, d1) { bessel_lo(j2 + 1); n1 = RN; d1 = RD; bessel_hi(1); rat_set(n1 * RD, d1 * RN) }
function aj_hi(j2,   n1, d1) { bessel_hi(j2 + 1); n1 = RN; d1 = RD; bessel_lo(1); rat_set(n1 * RD, d1 * RN) }
# decimal print of a rational, rounded DOWN (dir = -1) or UP (dir = +1) at DIG digits
function rat_dec(n, d, dir, dig,   neg, ip, fp, s, i, r, q) { neg = 0; if (n < 0) { neg = 1; n = 0 - n; dir = 0 - dir }
  ip = int(n / d); r = n - ip * d; s = ""; for (i = 0; i < dig; i++) { r *= 10; q = int(r / d); s = s q; r -= q * d }
  if (dir > 0 && r > 0) { # round the last digit up with carry
    i = dig; while (i > 0 && substr(s, i, 1) == "9") { s = substr(s, 1, i - 1) "0" substr(s, i + 1); i-- }
    if (i == 0) ip++; else s = substr(s, 1, i - 1) (substr(s, i, 1) + 1) substr(s, i + 1) }
  return (neg ? "-" : "") ip "." s }
function enclosure(j2,   ln, ld, hn, hd) { aj_lo(j2); ln = RN; ld = RD; aj_hi(j2); hn = RN; hd = RD
  printf "BESSEL-CERT beta=%d/%d a_{%d/2} in [%s, %s] width < 1e-%d (K=%d terms, tail 2 t_{K+1})\n", P, Q, j2, rat_dec(ln, ld, -1, DIG), rat_dec(hn, hd, 1, DIG), width_digits(ln, ld, hn, hd), K }
function width_digits(ln, ld, hn, hd,   wn, wd, e) { wn = hn * ld - ln * hd; wd = hd * ld; if (wn <= 0) return 99; e = 0; while (wn * 10 ^ e < wd && e < 200) e++; return e }
# the second road for the KAT: the same series in MPFR floats at 256 bits (not a certificate, a check on the truncation)
function i_float(nu, x,   k, t, s) { t = (x / 2) ^ nu / fact(nu); s = t; for (k = 1; k <= 60; k++) { t = t * (x * x / 4) / (k * (k + nu)); s += t } return s }
BEGIN { PREC = 256; if (!P) { P = 2452; Q = 10000 } if (!Q) Q = 1; if (!K) K = 24; if (!DIG) DIG = 40
  if (!BESSEL_LIB) {   # standalone: the KAT and the enclosures; as a library (-v BESSEL_LIB=1, @included by aperanton_kp_cert.awk) the doors only
  if (KAT || (P == 2452 && Q == 10000)) { Psave = P; Qsave = Q
    P = 1; Q = 1; aj_lo(1); printf "BESSEL-CERT KAT a_{1/2}(1) lo = %s, A&S I_2(1)/I_1(1) = 0.240194 ; float road %.12f\n", rat_dec(RN, RD, -1, 12), i_float(2, 1) / i_float(1, 1)
    P = Psave; Q = Qsave }
  for (j2 = 1; j2 <= 5; j2++) enclosure(j2)
  aj_lo(1); printf "BESSEL-CERT beta=%d/%d u float road = %.30f (the certificate's lo above it, hi above that)\n", P, Q, i_float(2, P / Q) / i_float(1, P / Q)
  }
}
