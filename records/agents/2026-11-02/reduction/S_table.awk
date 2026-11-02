# S_table.awk -- the constant of the reduction (Hypothesis I from Hypothesis II(b) and the coarse kernel's contraction delta):
#   S(K', rho', kappa) = sum_{r >= 1} n(r) * min(1, 80 K' rho'^(r-1)) * e^(kappa r),   n(r) = (2r+1)^4 - (2r-1)^4,
#   and the threshold delta* = 1/(1 + S): Hypothesis I holds with alpha = delta S/(1 - delta) < 1 iff delta < delta*.
# Double precision (a table of the threshold as a function of the fibre's constants; no number here enters a proof).
# STAKE (written before the run): K' = 1, rho' = e^-1, kappa = 0.5 gives S ~ 10^6 (the near shells, where II(b)'s factor 80 K'
#   exceeds one, dominate); rho' = e^-8 (a fibre whose rate per coarse unit is set by a physical correlation length well below
#   the block) gives S ~ 80 e^kappa + 544 e^(2 kappa) at kappa = 1, i.e. ~ 4.2e3, delta* ~ 2e-4.
BEGIN { split("1 10", KP, " "); split("1 2 4 8 16", LR, " "); split("0.5 1 2 4", KA, " ");
  printf "%-4s %-9s %-6s %-14s %-12s\n", "K'", "-ln rho'", "kappa", "S", "delta*";
  for (a in KP) for (b = 1; b <= 5; b++) for (c = 1; c <= 4; c++) {
    K = KP[a] + 0; L = LR[b] + 0; k = KA[c] + 0; if (k >= L) continue;
    s = 0; for (r = 1; r <= 4000; r++) { n = (2*r+1)^4 - (2*r-1)^4; m = 80 * K * exp(-L * (r - 1)); if (m > 1) m = 1;
      t = n * m * exp(k * r); s += t; if (r > 50 && t < 1e-12 * s) break }
    printf "%-4d %-9g %-6g %-14.6g %-12.4g\n", K, L, k, s, 1 / (1 + s) } }
