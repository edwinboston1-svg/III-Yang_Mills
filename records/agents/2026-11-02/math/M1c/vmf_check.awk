# vmf_check.awk -- the two premises under Theorem 8.7's exact constants (THE GROUND after Table 3), read on a grid at 256-bit MPFR:
# with m = I2/I1, phi'' = 1 - 3m/r - m^2 (Riccati), D = phi'' - m/r <= 0, a := 3|D|/r, b := 2 m phi'', phi''' = a - b:
#  (P1) d|D|/dr = 2 m phi'' - 4|D|/r = b - (4/3) a >= 0 on [0, 5 beta]   (so sup_{r <= 5beta} |D| = |D(5 beta)|);
#  (P2) the third cumulant along a unit vector at angle c to w, k3(c) = (2a - b) c^3 - a c, has max_c |k3| = |phi'''| = b - a whenever 3b >= 5a
#       (the critical point c*^2 = a/(3(2a - b)) then lies at or beyond 1, or 2a <= b), and |phi'''| = b - a is nondecreasing on [0, 6 beta].
# A grid reading with the minimum margins printed; not a certificate (the margins are what a certificate would need).
function besI(n, x,   s, t, k) { s = 0; t = (x / 2) ^ n; for (k = 1; k <= n; k++) t /= k; k = 0; while (1) { s += t; t *= (x * x / 4) / ((k + 1) * (k + 1 + n)); k++; if (t < 1e-70 * s) break } return s }
BEGIN { PREC = 256; beta = 0.2452; r5 = 5 * beta; r6 = 6 * beta; h = 0.0005
  m1 = 1e9; m2 = 1e9; m3 = 1e9; prevba = -1; minincr = 1e9
  for (r = h; r <= r6 + 1e-12; r += h) { I1 = besI(1, r); I2 = besI(2, r); m = I2 / I1; pp = 1 - 3 * m / r - m * m; D = pp - m / r; a = 3 * (-D) / r; b = 2 * m * pp
    if (r <= r5 + 1e-12) { q = (3 * b) / (4 * a); if (q < m1) { m1 = q; r1 = r } }
    q = (3 * b) / (5 * a); if (q < m2) { m2 = q; r2 = r }
    ba = b - a; if (prevba >= 0) { d = ba - prevba; if (d < minincr) { minincr = d; r3 = r } } prevba = ba }
  printf "VMF (P1) min over (0, 5beta = %.4f] of 3b/(4a) = %.6f at r = %.4f  (>= 1 means |D| increasing)\n", r5, m1, r1
  printf "VMF (P2) min over (0, 6beta = %.4f] of 3b/(5a) = %.6f at r = %.4f  (>= 1 means the max over directions is at c = 1)\n", r6, m2, r2
  printf "VMF (P2') min step of |phi'''| = b - a on the grid h = %.4f: %.3e at r = %.4f  (> 0 means |phi'''| increasing)\n", h, minincr, r3
  for (k = 5; k <= 6; k++) { r = k * beta; I1 = besI(1, r); I2 = besI(2, r); m = I2 / I1; pp = 1 - 3 * m / r - m * m; D = pp - m / r; a = 3 * (-D) / r; b = 2 * m * pp
    printf "VMF r = %d beta = %.4f: m = %.12f  |D| = %.12e  m^2/3 = %.12e   |phi'''| = %.12e  m/2 = %.12e\n", k, r, m, -D, m * m / 3, b - a, m / 2 } }
