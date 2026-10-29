# fontes_peierls.awk -- the single-plaquette large-angle probability of SU(2) Wilson theory's marginal, EXACT by quadrature,
# against Fontes's eq. (chess) mu(theta_p > theta*) <= exp(-beta(1 - cos theta*)); then the corrected Peierls floor with the
# tree-graph entropy e*c_conn = 20e and the full-Hessian Christoffel edge theta_c = 0.7383, and the KP activity z = C0 theta^2/(beta lambda).
# The marginal density of the class angle under the Wilson weight is prop. to exp(beta cos t) sin^2 t on [0, pi] (SU(2) Haar).
function mu1(beta, ts,   n, h, i, t, f, num, den, w) { n = 40000; h = 3.14159265358979 / n; num = 0; den = 0
  for (i = 0; i <= n; i++) { t = i * h; w = (i == 0 || i == n) ? 1 : (i % 2 ? 4 : 2); x = beta * (cos(t) - 1); f = (x < -700) ? 0 : w * exp(x) * sin(t) * sin(t)
    den += f; if (t > ts) num += f }
  return num / den }
BEGIN {
  print "beta      theta*   mu1(exact)   Fontes bound   ratio"
  split("9587 0.025 150 0.2237 150 0.20 20 0.7383 15 0.7383", A, " ")
  for (k = 1; k <= 10; k += 2) { b = A[k]; ts = A[k+1]; m = mu1(b, ts); fb = exp(-b * (1 - cos(ts)))
    printf "%-9s %-8s %-12.6f %-14.6f %.3f\n", b, ts, m, fb, m / fb }
  # the corrected floors at theta_c = 0.7383: Peierls 20e * mu1 < 1; KP activity C0 theta^2 / (3 beta) < 0.1 (his KP threshold, from his margin 26x at z = 0.004)
  tc = 0.7383; c = 20 * exp(1)
  lo = 5; hi = 200; for (i = 0; i < 60; i++) { mid = (lo + hi) / 2; if (c * mu1(mid, tc) > 1) lo = mid; else hi = mid }
  printf "Peierls floor at theta_c=%.4f with entropy 20e=%.2f: beta = %.2f\n", tc, c, hi
  lo = 5; hi = 200; for (i = 0; i < 60; i++) { mid = (lo + hi) / 2; if (20 * mu1(mid, tc) > 1) lo = mid; else hi = mid }
  printf "  (with Fontes's entropy 20 instead: beta = %.2f)\n", hi
  printf "KP activity z = C0 theta_c^2/(lambda beta) = 0.1 at beta = %.2f (lambda = 3), %.2f (lambda = 0.6893)\n", (32/3) * tc * tc / (3 * 0.1), (32/3) * tc * tc / (0.6893 * 0.1)
  # Fontes's own parameters re-read with the exact mu1 and the tree-graph entropy
  printf "his (9587, 0.025): 20e*mu1 = %.3f;  his (150, 0.2237): 20e*mu1 = %.3f\n", c * mu1(9587, 0.025), c * mu1(150, 0.2237)
}
