# aperanton_decimation_rowsum.awk -- the coarse specification's Dobrushin row sum under the period-2 PERFECT DECIMATION of Z^4
# (one integrated link per site meeting every plaquette exactly once; the fibre a product measure), leading orders, double
# precision.  Per coarse link: 12 DIRECT neighbours (the two other coarse links of each of its 6 plaquettes, the staple
# averaged over the plaquette's integrated link a ~ vMF(kappa_a <= 5 beta)): (4 beta/(3 pi)) m(5 beta) each; 90 MEDIATED
# neighbours (the 15 coarse links of each a's five other plaquettes): beta^2/(3 pi) each (the mean's Jacobian is the
# covariance, ||Cov|| <= 1/4, a staple's change <= 2, the MAD constant 2/(3 pi)) plus beta^2 |D(5 beta)|/2 for the second
# cumulant's anisotropy (D = 1 - 4 m/k - m^2, the single-vMF form of iii-43's closed form).  The reweighting factor
# rho(omega) = e^omega (1 + e^omega)/2 with omega = 3 beta^2 |D(5 beta)| (six integrated plaquettes, the isotropic part of the
# second cumulant U-independent).  Columns: beta, m(5b), D(5b), direct, mediated, rho, ROW; the radius is where ROW = 1.
function besI(n, x,   k, t, s) { t = (x/2)^n; for (k = 1; k <= n; k++) t /= k; s = t;
  for (k = 1; k <= 60; k++) { t *= (x/2)^2 / (k * (k + n)); s += t } return s }
function m(x) { if (x == 0) return 0; return besI(2, x) / besI(1, x) }
BEGIN { pi = 3.14159265358979323846; printf "%-6s %-8s %-9s %-8s %-8s %-8s %-8s\n", "beta", "m(5b)", "D(5b)", "direct", "mediat", "rho", "ROW";
  n = split("0.131 0.15 0.18 0.20 0.22 0.23 0.24 0.245 0.25 0.26 0.28 0.30", B, " ");
  for (i = 1; i <= n; i++) { b = B[i] + 0; k = 5*b; m5 = m(k); D = 1 - 4*m5/k - m5*m5; dir = 12 * (4*b/(3*pi)) * m5;
    med = 90 * (b*b/(3*pi) + b*b*(D < 0 ? -D : D)/2); om = 3*b*b*(D < 0 ? -D : D); rho = exp(om)*(1+exp(om))/2;
    printf "%-6.4f %-8.4f %-9.5f %-8.4f %-8.4f %-8.4f %-8.4f\n", b, m5, D, dir, med, rho, rho*(dir+med) } }
