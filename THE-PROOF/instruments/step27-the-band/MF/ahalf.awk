# ahalf.awk -- a_1/2(beta) = I_2(beta)/I_1(beta), certified: positive-term series with directed rounding (gawk -M, PREC bits),
# lower sums rounded down, upper sums rounded up plus the geometric tail bound t_K r/(1-r), r = (beta/2)^2/((K+1)(K+n+1)).
# beta = BN/BD exact rational.  usage: gawk -M -v PREC=256 -v BN=11 -v BD=5 -f ahalf.awk
function bessel_bound(n, up,   k, t, s, x2, K, r, tail) {
  ROUNDMODE = up ? "U" : "D"
  x2 = (BN / BD / 2) * (BN / BD / 2); t = 1; for (k = 1; k <= n; k++) t = t * (BN / BD / 2) / k   # t_0 = (x/2)^n / n!
  s = 0; K = 120
  for (k = 0; k < K; k++) { s = s + t; t = t * x2 / ((k + 1) * (k + n + 1)) }
  if (up) { r = x2 / ((K + 1) * (K + n + 1)); tail = t / (1 - r); s = s + tail }
  return s }
BEGIN { i1lo = bessel_bound(1, 0); i1hi = bessel_bound(1, 1); i2lo = bessel_bound(2, 0); i2hi = bessel_bound(2, 1)
  ROUNDMODE = "D"; alo = i2lo / i1hi; ROUNDMODE = "U"; ahi = i2hi / i1lo
  ROUNDMODE = "D"; r14lo = 14 * alo; r18lo = 18 * alo; ROUNDMODE = "U"; r14hi = 14 * ahi; r18hi = 18 * ahi
  printf "AHALF beta=%d/%d a_1/2 in [%.15f, %.15f]\n14 a in [%.12f, %.12f]\n18 a in [%.12f, %.12f]\n", BN, BD, alo, ahi, r14lo, r14hi, r18lo, r18hi
  # the strong-coupling known answer: a_1/2(beta) -> beta/4 as beta -> 0; and the root of 14 a = 1 by bisection (lower-bound side)
}
