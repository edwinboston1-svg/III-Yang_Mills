# u1modes.awk -- THE U(1) ANALOGUE OF w2_modes.awk ON THE FOLDED (C-EVEN) CHARGE LAW OF TWO COARSE LOOPS (PM, 2026-11-02).
# The folded basis e_0 = 1, e_m = sqrt(2) cos(m Phi) (orthonormal for dPhi/pi on [0, pi]: the U(1) analogue of SU(2)'s class functions, the
# maximal torus seen through the Weyl reflection).  Input: either a table "U1-CLASS m= n= T = v" (T[m][n] = E[e_m(A) e_n(B)], m, n <= L), or,
# with -v GAUSS=1 -v S2=<sigma^2> -v R=<r> -v L=<cap>, the exact table of a bivariate Gaussian flux pair (the Villain spin-wave part):
# E[e^{i(m Phi_A + n Phi_B)}] = exp(-S2 (m^2 + n^2 + 2 m n R)/2), so T[m][n] = E[cos(mA + nB)] + E[cos(mA - nB)] (m, n >= 1), T[m][0] = sqrt(2) E[cos mA].
# Builds W = sum T e_m e_n on an N x N midpoint grid, the marginals, R = W/(W_A W_B), the modes bhat of R - 1, and the floor with SU(2)'s
# arithmetic (index 2 the "modifying" charge, as spin 1 is in w2_modes): floor = a'_2 + 16 s_one / 3, a'_2 = E[cos 2 Phi_A] = T[2][0]/sqrt(2),
# s_one = sum |bhat_{mn}|^{1/2} over m = 2, n > 0, n != 2 and the mirror (the creating count 2 for each, as in w2_modes).  Also printed with the
# dimension-1 unit (16 s_one in place of 16 s_one / 3).  REFUSES by name when W is not positive on the grid.
# usage: gawk [-v N=256] [-v GAUSS=1 -v S2= -v R= -v L=] -f u1modes.awk [table]
function abs(x) { return x < 0 ? -x : x }
/^U1-CLASS m=/ { m = substr($2, 3) + 0; n = substr($3, 3) + 0; T[m, n] = $6 + 0; if (m > L) L = m; if (n > L) L = n; nread++ }
END {
  if (!N) N = 256; PI = 3.141592653589793
  if (GAUSS) { if (!L) L = 4
    for (m = 0; m <= L; m++) for (n = 0; n <= L; n++) {
      if (m == 0 && n == 0) T[m, n] = 1
      else if (n == 0) T[m, n] = sqrt(2) * exp(-S2 * m * m / 2)
      else if (m == 0) T[m, n] = sqrt(2) * exp(-S2 * n * n / 2)
      else T[m, n] = exp(-S2 * (m * m + n * n + 2 * m * n * R) / 2) + exp(-S2 * (m * m + n * n - 2 * m * n * R) / 2) }
    printf "U1-MODES GAUSS sigma^2 = %.6f r = %.6f, charges <= %d (the exact Villain spin-wave table)\n", S2, R, L }
  else if (!nread) { print "U1-MODES REFUSED: no table"; exit 2 }
  if (abs(T[0, 0] - 1) > 1e-9) { print "U1-MODES REFUSED: T[0][0] is not 1"; exit 2 }
  for (m = 0; m <= L; m++) for (n = 0; n <= L; n++) printf "U1-TABLE m=%d n=%d T = %+.9e  conn = %+.9e\n", m, n, T[m, n], T[m, n] - T[m, 0] * T[0, n]
  for (i = 1; i <= N; i++) { ph[i] = (i - 0.5) * PI / N; w[i] = 1.0 / N; for (m = 0; m <= 2 * L; m++) E[i, m] = (m == 0) ? 1 : sqrt(2) * cos(m * ph[i]) }
  for (i = 1; i <= N; i++) { WA[i] = 0; WB[i] = 0; for (m = 0; m <= L; m++) { WA[i] += T[m, 0] * E[i, m]; WB[i] += T[0, m] * E[i, m] } }
  neg = 0; supd = 0
  for (i = 1; i <= N; i++) for (j = 1; j <= N; j++) { s = 0; for (m = 0; m <= L; m++) for (n = 0; n <= L; n++) s += T[m, n] * E[i, m] * E[j, n]
    if (s <= 0 || WA[i] <= 0 || WB[j] <= 0) { neg++; continue } RR[i, j] = s / (WA[i] * WB[j]); if (abs(log(RR[i, j])) > supd) supd = abs(log(RR[i, j])) }
  if (neg) { printf "U1-MODES REFUSED: the truncated density is not positive at %d of %d cells (L = %d)\n", neg, N * N, L; exit 2 }
  sone = 0
  for (m = 0; m <= 2 * L; m++) for (n = 0; n <= 2 * L; n++) { if (m + n == 0) continue; b = 0; for (i = 1; i <= N; i++) for (j = 1; j <= N; j++) b += w[i] * w[j] * (RR[i, j] - 1) * E[i, m] * E[j, n]
    if ((m == 2 && n > 0 && n != 2) || (n == 2 && m > 0 && m != 2)) { sone += sqrt(abs(b)); printf "U1-MODE m=%d n=%d bhat = %+.9e (a charge-2-facing-creating mode)\n", m, n, b }
    else if (m <= 2 && n <= 2) printf "U1-MODE m=%d n=%d bhat = %+.9e\n", m, n, b }
  a2 = T[2, 0] / sqrt(2)
  printf "U1-FLOOR sup|delta_2| = %.4e; a'_2 = %.6e; s_one = %.6e; floor (SU(2) arithmetic, 16 s_one/3) = %.6f; floor (dimension-1 unit, 16 s_one) = %.6f; the ceiling 0.0161: %s\n", supd, a2, sone, a2 + 16 * sone / 3, a2 + 16 * sone, (a2 + 16 * sone / 3 <= 0.0161) ? "BELOW" : "ABOVE" }
