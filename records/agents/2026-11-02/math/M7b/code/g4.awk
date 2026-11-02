# the free photon at coupling beta_V: a(n) = exp(-S(n)/(2 beta)), the adjacent pair's relative content in its attractive channel r(n) = exp(C(n)/beta) - 1
# (C the larger of |planar|, |bent|), and P2's sharp coefficient c(n) = a (1 + min(2r, 4 sqrt r)); S, C read from gauss.c at n = 1..32 (M = 256,
# converged to 10^-6 against M = 512), extrapolated linearly in n beyond 32 by the last two points (S = n - 0.85, C = 0.2435 n to 1 %)
BEGIN { nn = split("1 2 4 8 16 32", N, " "); split("0.500000 1.369312 3.261484 7.167860 15.115403 31.149942", S, " "); split("0.107781 0.326966 0.803658 1.781252 3.768573 7.792988", C, " ")
  dS = (S[6] - S[5]) / 16; dC = (C[6] - C[5]) / 16
  for (bi = 1; bi <= split(BS, BL, ","); bi++) { b = BL[bi] + 0; land = 0; line = ""
    for (k = 0; k <= 9; k++) { n = 2 ^ k; if (k <= 5) { s = S[k + 1]; c = C[k + 1] } else { s = S[6] + dS * (n - 32); c = C[6] + dC * (n - 32) }
      a = exp(-s / (2 * b)); r = exp(c / b) - 1; ch = (2 * r < 4 * sqrt(r)) ? 2 * r : 4 * sqrt(r); cc = a * (1 + ch)
      line = line sprintf(" n=%d: a=%.3g r=%.3g c=%.3g;", n, a, r, cc); if (!land && cc < 0.134) land = n }
    printf "G4 beta_V=%s:%s  P2 LANDS at n = %d (%d steps)\n", b, line, land, (land ? log(land)/log(2) : -1) } }
