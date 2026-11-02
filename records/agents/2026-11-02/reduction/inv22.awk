# inv.awk -- invert a_half(beta) = I_2(beta)/I_1(beta) for the coarse loop expectations E = E[chi_half(A)] = 2 a'.
# STAKE (the 027_P reader's values, written before this run): E 0.815 -> 1.8469 ; 0.561 -> 1.1859 ; 0.038 -> 0.0760 ;
#   0.621 -> 1.3304 ; 0.146 -> 0.2930 ; 0.111 -> 0.2225 ; and a_half(2.2) = 0.46448 (the mkflow record's c_1).
function bessel(n, x,    k, t, s, h) { h = x / 2; t = 1; for (k = 1; k <= n; k++) t *= h / k; s = t;
  for (k = 1; k < 200; k++) { t *= h * h / (k * (k + n)); s += t; if (t < 1e-30 * s) break } return s }
function ahalf(b) { return bessel(2, b) / bessel(1, b) }
function inv(a,    lo, hi, mid, i) { lo = 1e-9; hi = 20; for (i = 0; i < 200; i++) { mid = (lo + hi) / 2; if (ahalf(mid) < a) lo = mid; else hi = mid } return (lo + hi) / 2 }
BEGIN { printf "a_half(2.2) = %.6f\n", ahalf(2.2); n = split("0.14556 0.24326 0.27890 0.11070 0.15188 0.18604", E, " ");
  for (i = 1; i <= n; i++) printf "E = %s  a' = %.4f  beta_eff = %.4f\n", E[i], E[i] / 2, inv(E[i] / 2);
  printf "check: a_half(0.4764) = %.6f  1/(2a) = %.3f ; a_half(0.05) -> 1/(2a) = %.3f\n", ahalf(0.4764), 1 / (2 * ahalf(0.4764)), 1 / (2 * ahalf(0.05)) }
