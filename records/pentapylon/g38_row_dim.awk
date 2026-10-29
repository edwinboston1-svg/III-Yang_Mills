# g38_row_dim.awk -- THE PERFECT DECIMATION'S ROW IN DIMENSION D, PROVED CONSTANTS, AND ITS CROSSING (ΠΕΝΤΑΠΥΛΟΝ G38, 2026-10-29 06:1x EDT, the
# desktop seat; the plan seat's C3).  THE TRANSCRIPTION of aperanton_decimation_cert.awk (the ledger §73 ter) from D = 4 to D: a decimated link has
# P = 2(D-1) plaquettes; in the coarse conditional of a kept link x, each of its P plaquettes p contributes Z(|w_p + theta_p(U)|) with w_p the sum of
# the decimated link's OTHER P - 1 staples (|w_p| <= (P-1) beta) and |theta_p| = beta; so M5 -> M = m((P-1) beta), D5 -> Dc = M^2/3, T6 -> T = m(P beta)/2,
# and the reweighting exponent omega = 3 beta^2 D5 + 2 beta^3 T6 = P x (beta^2 D5/2 + beta^3 T6/3) -> P x (beta^2 Dc/2 + beta^3 T/3); the per-pair
# constants keep their form, C_dir = rho (4 beta/(3 pi)) M + (beta^2 Dc + (2/3) beta^3 T)/4, C_med = rho beta^2/(3 pi) + (min(beta^2 Dc, 2 beta^3 T)
# + (2/3) beta^3 T)/4, rho = (3 e^omega - 1)/2; THE COUNTS per kept link are g37's, enumerated from the covers: DIRECT 4(D-1), MEDIUM 6(D-1)(2D-3)
# (D = 4: 12 and 90; D = 3: 8 and 36; D = 2: 4 and 6).  The reading of omega's P-scaling is this seat's transcription of the cert's two coefficients
# (3 = 6 x 1/2, 2 = 6 x 1/3) and is to be confirmed by the formula's owner.  KNOWN ANSWER: D = 4 must reproduce the cert's crossing 0.2410 (ROW_hi
# 0.996297 at 0.2410).  gawk -M, PREC 256, every quantity padded outward by 1e-50 as the cert does.
function series_A(z,   k, t, s) { t = 0.5; s = t; for (k = 1; k <= 60; k++) { t = t * z / (k * (k + 2)); s += t } return s + 2 * t * z }
function series_B(z,   k, t, s) { t = 1; s = t; for (k = 1; k <= 60; k++) { t = t * z / (k * (k + 1)); s += t } return s }
function m_hi(r,   z) { z = r * r / 4; return r * series_A(z) / (2 * series_B(z)) * (1 + PAD) }
function exp_hi(x,   k, t, s) { t = 1; s = 1; for (k = 1; k <= 120; k++) { t = t * x / k; s += t } return s * (1 + PAD) }
function min(a, b) { return a < b ? a : b }
function row(D, b,   P, M, Dc, T, om, rho, c3, cdir, cmed) { P = 2 * (D - 1); M = m_hi((P - 1) * b); Dc = M * M / 3; T = m_hi(P * b) / 2;
  om = P * (b * b * Dc / 2 + b * b * b * T / 3) * (1 + PAD); rho = (3 * exp_hi(om) - 1) / 2; c3 = 1 / (3 * PI_LO);
  cdir = rho * 4 * b * c3 * M + (b * b * Dc + (2 / 3) * b * b * b * T) / 4; cmed = rho * b * b * c3 + (min(b * b * Dc, 2 * b * b * b * T) + (2 / 3) * b * b * b * T) / 4;
  ND = 4 * (D - 1); NM = 6 * (D - 1) * (2 * D - 3); RD = ND * cdir; RM = NM * cmed; OM = om; return (RD + RM) * (1 + PAD) }
BEGIN { PREC = 256; PAD = 1e-50; PI_LO = 3.14159265358979323846264338327950288419716939937510
  r = row(4, 0.2410); printf "G38-KAT D=4 beta=0.2410: ROW_hi = %.9f against the cert's 0.996297 [%s]\n", r, (r > 0.9962965 && r < 0.9962975) ? "MET" : "MISSED"
  for (D = 2; D <= 4; D++) { last = 0; for (k = 1000; k <= 20000; k++) { b = k / 10000; r = row(D, b); if (r < 1) { last = b; lr = r; ld = RD; lm = RM; lo = OM } else break }
    printf "G38-CROSS D=%d: the row (%d direct + %d mediated per kept link) stays below 1 to beta0 = %.4f (ROW_hi = %.9f = %.6f direct + %.6f mediated; omega %.6f); first grid beta above: %.4f (ROW_hi %.6f)\n", D, ND, NM, last, lr, ld, lm, lo, last + 0.0001, row(D, last + 0.0001) } }
