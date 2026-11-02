# Bessel-ratio inversions (double precision; readings only): G=su2 solves I2(x)/I1(x) = v; G=u1 solves I1(x)/I0(x) = v; bisection on [1e-9, 40]
function I(n, x,   k, t, s) { t = (x / 2) ^ n; for (k = 1; k <= n; k++) t /= k; s = t; for (k = 0; k < 400; k++) { t *= (x / 2) * (x / 2) / ((k + 1) * (k + n + 1)); s += t; if (t < 1e-300) break } return s }
function r(x) { return (G == "u1") ? I(1, x) / I(0, x) : I(2, x) / I(1, x) }
BEGIN { lo = 1e-9; hi = 40; for (i = 0; i < 200; i++) { m = (lo + hi) / 2; if (r(m) < v) lo = m; else hi = m } printf "%s %s -> beta_eff %.4f\n", G, v, (lo + hi) / 2 }
