# the Bessel ratios I_{s+1}(b)/I_1(b), s = 1..K, in double precision (the engine's own series), comma-joined
function bes(n, x,   s, t, f, i, k) { t = (x/2)^n; f = 1; for (i = 1; i <= n; i++) f *= i; t /= f; s = 0; for (k = 0; k < 400; k++) { s += t; t *= (x/2)*(x/2)/((k+1.0)*(k+n+1.0)); if (t < 1e-300) break } return s }
BEGIN { out = ""; for (s = 1; s <= K; s++) out = out (s > 1 ? "," : "") sprintf("%.17e", bes(s+1, B)/bes(1, B)); print out }
