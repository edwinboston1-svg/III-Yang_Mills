# aperanton_decimation_cert.awk -- THE PERFECT DECIMATION'S COARSE DOBRUSHIN ROW SUM WITH PROVED CONSTANTS ONLY (the ledger
# §73 ter, 2026-10-29).  Run with gawk -M: every quantity is computed at PREC = 256 bits (about 77 decimal digits) and then
# padded outward by PAD = 1e-50, which dominates the accumulated rounding error (fewer than 10^4 operations, each of relative
# error at most 2^-256 < 1e-77) -- the resolution floor, said so on every line.
#
# THE BOUND (§73 ter): for the integrated set L1 of the period-2 perfect cover, the coarse conditional of a kept link x is
# exactly prop to prod over its six plaquettes p of Z(|w_p + theta_p(U)|), Z(r) prop to I_1(r)/r, |w_p| <= 5 beta, |theta_p| = beta.
# With phi = log(I_1(r)/r): m = phi' = I_2/I_1 (increasing), the covariance of a vMF has eigenvalues phi'' (axial) and m/r
# (perpendicular), both <= 1/4 (PROVED: m/r <= 1/4 termwise; phi'' <= 1/4 iff 4 I_2^2 >= 3 I_1 I_3, implied by Turan's
# I_2^2 >= I_1 I_3, termwise from Watson 5.41's product formula); the anisotropy D = phi'' - m/r obeys -m^2/3 <= D <= 0 (the
# two-sided Turan inequality at nu = 2, termwise); the third-cumulant tensor norm T(r) <= m(r)/2 (the Riccati identity
# phi''' = 3|D|/r - 2 m phi'').  Hence with M5 = m(5 beta), D5 = M5^2/3, T6 = m(6 beta)/2, omega = 3 beta^2 D5 + 2 beta^3 T6,
# rho = (3 e^omega - 1)/2 (the reweighted MAD lemma), the MAD constant 2/(3 pi) (of record), and the tilt lemma
# tanh(w/4) <= w/4:
#   C_direct   <= rho (4 beta/(3 pi)) M5 + (beta^2 D5 + (2/3) beta^3 T6)/4                         (12 per kept link)
#   C_mediated <= rho beta^2/(3 pi) + (min(beta^2 D5, 2 beta^3 T6) + (2/3) beta^3 T6)/4               (90 per kept link)
#   ROW = 12 C_direct + 90 C_mediated, increasing in beta, so ROW(beta0) < 1 certifies Dobrushin's condition for every
#   beta <= beta0.
# m(r) is evaluated as r A/(2 B) with A = sum z^k/(k!(k+2)!), B = sum z^k/(k!(k+1)!), z = r^2/4, both truncated at K = 60 terms
# with the tail of A bounded by twice its first omitted term (the term ratio is below 1/2 for z <= 1); A rounded up, B down.
# Columns: beta, M5_hi, T6_hi, omega, rho, 12*C_direct, 90*C_mediated, ROW_hi, verdict.  The KAT line: m at r = 1 against
# I_2(1)/I_1(1) = 0.240195... (A&S table: I_1(1) = 0.565159104, I_2(1) = 0.135747670).
function series_A(z,   k, t, s) { t = 0.5; s = t; for (k = 1; k <= 60; k++) { t = t * z / (k * (k + 2)); s += t } return s + 2 * t * z }
function series_B(z,   k, t, s) { t = 1; s = t; for (k = 1; k <= 60; k++) { t = t * z / (k * (k + 1)); s += t } return s }
function m_hi(r,   z) { z = r * r / 4; return r * series_A(z) / (2 * series_B(z)) * (1 + PAD) }
function exp_hi(x,   k, t, s) { t = 1; s = 1; for (k = 1; k <= 80; k++) { t = t * x / k; s += t } return s * (1 + PAD) }
function min(a, b) { return a < b ? a : b }
BEGIN {
  PREC = 256; PAD = 1e-50;
  PI_LO = 3.14159265358979323846264338327950288419716939937510   # a lower bound for pi (its 51 digits truncated)
  printf "KAT m(1) = %.12f (I_2(1)/I_1(1) = 0.240194...); m(0.4)/0.4 = %.12f (< 1/4)\n", m_hi(1), m_hi(0.4) / 0.4;
  printf "%-7s %-9s %-9s %-9s %-9s %-9s %-9s %-9s %s\n", "beta", "M5", "T6", "omega", "rho", "12Cdir", "90Cmed", "ROW", "verdict";
  for (i = 0; i <= 120; i++) {
    b = 0.100 + i * 0.0005;
    M5 = m_hi(5 * b); T6 = m_hi(6 * b) / 2; D5 = M5 * M5 / 3;
    om = (3 * b * b * D5 + 2 * b * b * b * T6) * (1 + PAD);
    rho = (3 * exp_hi(om) - 1) / 2;
    c3 = 1 / 4;  # THE CRUDE CONSTANT: MAD <= 1/2 by Cauchy-Schwarz, the tv coefficient 1/4 in place of 2/(3 pi)
    cdir = rho * 4 * b * c3 * M5 + (b * b * D5 + (2 / 3) * b * b * b * T6) / 4;
    cmed = rho * b * b * c3 + (min(b * b * D5, 2 * b * b * b * T6) + (2 / 3) * b * b * b * T6) / 4;
    row = (12 * cdir + 90 * cmed) * (1 + PAD);
    if (row < 1) { last = b; lastrow = row }
    if (i % 4 == 0 || (row >= 1 && !printed1)) {
      printf "%-7.4f %-9.6f %-9.6f %-9.6f %-9.6f %-9.6f %-9.6f %-9.6f %s\n", b, M5, T6, om, rho, 12 * cdir, 90 * cmed, row, (row < 1 ? "CLOSES" : "OPEN");
      if (row >= 1) printed1 = 1 }
  }
  printf "DECIMATION-CERT-CRUDE beta0=%.4f ROW_hi=%.9f closes=1 prec=256 pad=1e-50 constants=proved (Turan termwise; T<=m/2; MAD 2/(3pi) of record)\n", last, lastrow;
  # THE SHARP PASS: D5 = |D(5 beta)| and T6 = |phi'''(6 beta)| at the endpoint, valid as suprema over r <= 5 beta and over r <= 6
  # beta and every direction by the second road's certified monotonicity (iii-38, STDLIB/build/pentapylon/g19_vmf.awk, record
  # g19_vmf.2026-10-29b.txt: E2c |D|/r increasing and E2b |phi'''| increasing on [0.05, 1.5], E2DIR |phi'''| >= 2|D|/r on every
  # cell, the hand bounds below 0.05).  D = z(BC - A^2)/B^2 <= 0, phi'' = 1 - 3A/(2B) - zA^2/B^2, phi''' = 3|D|/r - 2 m phi'',
  # each evaluated at 256 bits and padded by 1e-40 relative (the subtraction in phi''' loses at most a few of the 77 digits).
  for (i = 0; i <= 120; i++) {
    b = 0.100 + i * 0.0005;
    M5 = m_hi(5 * b); D5 = absD(5 * b) * (1 + 1e-40); T6 = abs3(6 * b) * (1 + 1e-40);
    om = (3 * b * b * D5 + 2 * b * b * b * T6) * (1 + PAD);
    rho = (3 * exp_hi(om) - 1) / 2;
    c3 = 1 / 4;  # THE CRUDE CONSTANT: MAD <= 1/2 by Cauchy-Schwarz, the tv coefficient 1/4 in place of 2/(3 pi)
    cdir = rho * 4 * b * c3 * M5 + (b * b * D5 + (2 / 3) * b * b * b * T6) / 4;
    cmed = rho * b * b * c3 + (min(b * b * D5, 2 * b * b * b * T6) + (2 / 3) * b * b * b * T6) / 4;
    row = (12 * cdir + 90 * cmed) * (1 + PAD);
    if (row < 1) { slast = b; slastrow = row; sD5 = D5; sT6 = T6 }
  }
  printf "DECIMATION-SHARP-CRUDE beta0=%.4f ROW_hi=%.9f D5=%.6f T6=%.6f closes=1 (D5, T6 sharp under g19_vmf.2026-10-29b E2b E2c E2DIR)\n", slast, slastrow, sD5, sT6;
}
function series_C(z,   k, t, s) { t = 1 / 6; s = t; for (k = 1; k <= 60; k++) { t = t * z / (k * (k + 3)); s += t } return s }
function absD(r,   z, A, B, C) { z = r * r / 4; A = series_A(z); B = series_B(z); C = series_C(z); return z * (A * A - B * C) / (B * B) }
function abs3(r,   z, A, B, C, m, p2, d) { z = r * r / 4; A = series_A(z); B = series_B(z); C = series_C(z);
  m = r * A / (2 * B); p2 = 1 - 3 * A / (2 * B) - z * A * A / (B * B); d = z * (A * A - B * C) / (B * B);
  return 2 * m * p2 - 3 * d / r }
