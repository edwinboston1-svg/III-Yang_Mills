# g24_rowsum.awk -- THE PERFECT DECIMATION'S ROW SUM ENCLOSED AND ITS CROSSING BRACKETED, THE SECOND ROAD (ΠΕΝΤΑΠΥΛΟΝ G24, 2026-10-29
# 03:2x EDT, the desktop seat; the plan seat's §73 formula of 03:1x with every constant's source, its own road aperanton_decimation_cert.awk).
# gawk -M, PREC 256, every lower endpoint under ROUNDMODE "D" and every upper under "U" (checked at load), pi enclosed by atan2 under both modes.
# THE FORMULA (the plan seat's, verbatim in structure):  ROW(beta) = 12 C_dir + 90 C_med,
#   C_dir = rho (4 beta/(3 pi)) M5 + (beta^2 D5 + (2/3) beta^3 T6)/4,
#   C_med = rho beta^2/(3 pi) + (min(beta^2 D5, 2 beta^3 T6) + (2/3) beta^3 T6)/4,
#   omega = 3 beta^2 D5 + 2 beta^3 T6,  rho = (3 e^omega - 1)/2,  M5 = m(5 beta),  m = I_2/I_1.
# TWO CONSTANT SETS: PROVED (Turan, termwise): D5 = m(5 beta)^2/3, T6 = m(6 beta)/2;  SHARP (g19 record b): D5 = |D(5 beta)| = A(5 beta) =
# m^2 - (1 - 4m/kappa) at kappa = 5 beta (the sup over r <= 5 beta at the end by (B3), A increasing on [0, 2]), T6 = |phi'''(6 beta)| = -mu_3(6 beta)
# (the sup over r <= 6 beta and directions at the end by (E2b) and (E2DIR) on [0, 1.5]) -- so the sharp set is valid for 6 beta <= 1.5.
# MONOTONICITY: every term rises with beta (m increasing; D5, T6 rising in both sets by the same lemmas), so ROW(beta) <= ROW(beta_0) on [0, beta_0]
# and the crossing is bracketed by the last grid beta with ROW_hi < 1 and the first with ROW_lo > 1.  beta on the grid is the exact rational p/10^4.
# KNOWN ANSWERS (the plan seat's road): PROVED beta_0 = 0.2410 with ROW_hi = 0.996297; SHARP beta_0 = 0.2450 with ROW_hi = 0.997770 (D5 = 0.026173,
# T6 = 0.060470) -- each must agree to the printed digits.  THE LIAR: the same row with the half-oscillation tilt (1/2 in place of 1/4) must cross
# ABOVE 1 at beta = 0.2410 (the plan seat: "with 1/2 osc the row fails at 0.241"); a crossing the grid cannot bracket is a REFUSAL, never a pass.
# usage: gawk -M [-v LO=2380 -v HI=2480] -f g24_rowsum.awk      (the grid beta = k/10^4, k = LO..HI)
function dn() { ROUNDMODE = "D" }
function up() { ROUNDMODE = "U" }
function fl(x) { ROUNDMODE = "D"; return sprintf("%.15g", x) }
function fh(x) { ROUNDMODE = "U"; return sprintf("%.15g", x) }
function bessel_lo(nu, x, K,   k, t, s, i, f) { dn(); f = 1; for (i = 1; i <= nu; i++) f = f * i; t = (x / 2) ^ nu / f; s = t; for (k = 0; k < K; k++) { t = t * (x / 2) ^ 2 / ((k + 1) * (k + 1 + nu)); s = s + t } return s }
function bessel_hi(nu, x, K,   k, t, s, i, f, rho, den) { up(); f = 1; for (i = 1; i <= nu; i++) f = f * i; t = (x / 2) ^ nu / f; s = t; for (k = 0; k < K; k++) { t = t * (x / 2) ^ 2 / ((k + 1) * (k + 1 + nu)); s = s + t }
  rho = (x / 2) ^ 2 / ((K + 1) * (K + 1 + nu)); if (rho >= 1) { print "G24-REFUSED bessel"; exit 3 } dn(); den = 1 - rho; up(); return s + t * rho / den }
function mint(xl, xh,   i1, i2) { i2 = bessel_lo(2, xl, KB); i1 = bessel_hi(1, xl, KB); dn(); MLO = i2 / i1; i2 = bessel_hi(2, xh, KB); i1 = bessel_lo(1, xh, KB); up(); MHI = i2 / i1 }
# -mu_3 at kappa in [a, b] from m in [ml, mh] (the direct road of g19: E[u^2] = 1 - 3Q, E[u^3] = m - 3P/kappa, Q = m/kappa, P = 1 - 4Q; here a, b
# bracket one point to 1e-70, so the naive brackets are tight)
function negmu3(a, b, ml, mh,   ql, qh, pl, ph, pkl, pkh, s2l, s2h, s3l, s3h, m3l, m3h, m3L, m3H) {
  dn(); ql = ml / b; up(); qh = mh / a; dn(); pl = 1 - 4 * qh; up(); ph = 1 - 4 * ql; dn(); pkl = pl / b; up(); pkh = ph / a
  dn(); s2l = 1 - 3 * qh; up(); s2h = 1 - 3 * ql; dn(); s3l = ml - 3 * pkh; up(); s3h = mh - 3 * pkl
  dn(); m3l = ml * ml * ml; up(); m3h = mh * mh * mh
  dn(); m3L = s3l - 3 * mh * s2h + 2 * m3l; up(); m3H = s3h - 3 * ml * s2l + 2 * m3h
  dn(); NM3L = 0 - m3H; up(); NM3H = 0 - m3L }
# the row at beta = k/10^4 with the constant set "proved" or "sharp" and the tilt factor TF (1/4, or the liar's 1/2) -> RL, RH (and the parts)
function row(k, set, TF,   bl, bh, m5l, m5h, m6l, m6h, d5l, d5h, t6l, t6h, x5l, x5h, x6l, x6h, oml, omh, rhol, rhoh, a1l, a1h, a2l, a2h, mnl, mnh, cdl, cdh, cml, cmh, ql, qh, pl, ph) {
  dn(); bl = k / 10000; up(); bh = k / 10000
  dn(); x5l = 5 * bl; up(); x5h = 5 * bh; mint(x5l, x5h); m5l = MLO; m5h = MHI
  dn(); x6l = 6 * bl; up(); x6h = 6 * bh; mint(x6l, x6h); m6l = MLO; m6h = MHI
  if (set == "proved") { dn(); d5l = m5l * m5l / 3; t6l = m6l / 2; up(); d5h = m5h * m5h / 3; t6h = m6h / 2 }
  else { dn(); ql = m5l / x5h; up(); qh = m5h / x5l; dn(); pl = 1 - 4 * qh; up(); ph = 1 - 4 * ql; dn(); d5l = m5l * m5l - ph; up(); d5h = m5h * m5h - pl
    negmu3(x6l, x6h, m6l, m6h); t6l = NM3L; t6h = NM3H }
  D5L = d5l; D5H = d5h; T6L = t6l; T6H = t6h; M5L = m5l; M5H = m5h
  dn(); oml = 3 * bl * bl * d5l + 2 * bl * bl * bl * t6l; up(); omh = 3 * bh * bh * d5h + 2 * bh * bh * bh * t6h
  dn(); rhol = (3 * exp(oml) - 1) / 2; up(); rhoh = (3 * exp(omh) - 1) / 2; RHOL = rhol; RHOH = rhoh
  dn(); a1l = bl * bl * d5l; a2l = 2 * bl * bl * bl * t6l; up(); a1h = bh * bh * d5h; a2h = 2 * bh * bh * bh * t6h
  mnl = (a1l < a2l) ? a1l : a2l; mnh = (a1h < a2h) ? a1h : a2h
  dn(); cdl = rhol * (4 * bl / (3 * PIH)) * m5l + TF * (a1l + (2 / 3) * bl * bl * bl * t6l); cml = rhol * bl * bl / (3 * PIH) + TF * (mnl + (2 / 3) * bl * bl * bl * t6l)
  up(); cdh = rhoh * (4 * bh / (3 * PIL)) * m5h + TF * (a1h + (2 / 3) * bh * bh * bh * t6h); cmh = rhoh * bh * bh / (3 * PIL) + TF * (mnh + (2 / 3) * bh * bh * bh * t6h)
  CDL = cdl; CDH = cdh; CML = cml; CMH = cmh
  dn(); RL = 12 * cdl + 90 * cml; up(); RH = 12 * cdh + 90 * cmh }
function gb(k) { return sprintf("0.%04d", k) }
function crossing(set, TF, tag,   k, lastbelow, firstabove, r) { lastbelow = -1; firstabove = -1
  for (k = LO; k <= HI; k++) { row(k, set, TF); if (RH < 1) lastbelow = k; if (RL > 1 && firstabove < 0) firstabove = k }
  if (lastbelow < 0 || firstabove < 0) { printf "G24-REFUSED %s: the grid [%d, %d]/10^4 does not bracket the crossing (last below %d, first above %d)\n", tag, LO, HI, lastbelow, firstabove; return }
  row(lastbelow, set, TF); r = sprintf("ROW(%s) in [%s, %s]  (M5 in [%s, %s], D5 in [%s, %s], T6 in [%s, %s], rho in [%s, %s], C_dir <= %s, C_med <= %s)", gb(lastbelow), fl(RL), fh(RH), fl(M5L), fh(M5H), fl(D5L), fh(D5H), fl(T6L), fh(T6H), fl(RHOL), fh(RHOH), fh(CDH), fh(CMH))
  row(firstabove, set, TF)
  printf "G24-CROSS %s: the row is certified below 1 on [0, %s] and above 1 from %s: beta_0 in [%s, %s); at the last grid point %s; at the first above ROW in [%s, %s]\n", tag, gb(lastbelow), gb(firstabove), gb(lastbelow), gb(firstabove), r, fl(RL), fh(RH)
  CROSSK[tag] = lastbelow }
BEGIN { PREC = 256; KB = 160; LO = (LO == "") ? 2380 : LO + 0; HI = (HI == "") ? 2480 : HI + 0
  dn(); a = exp(1); b = 1 / 3; c = log(3); PIL = atan2(0, -1); up(); A = exp(1); B = 1 / 3; C = log(3); PIH = atan2(0, -1)
  if (!(A > a && B > b && C > c && PIH > PIL && PIL > 3.14159265358 && PIH < 3.14159265359)) { print "G24-REFUSED directed rounding or pi not enclosed"; exit 3 }
  printf "G24-LOAD PREC=256 directed rounding in force; pi in [%s, %s]; the grid beta = k/10^4 for k in [%d, %d]\n", fl(PIL), fh(PIH), LO, HI
  crossing("proved", 1 / 4, "PROVED (D5 = m(5b)^2/3, T6 = m(6b)/2, tilt 1/4)")
  crossing("sharp", 1 / 4, "SHARP (D5 = |D(5b)|, T6 = |phi'''(6b)|, tilt 1/4)")
  # the known answers: the plan seat's ROW_hi at its beta_0 on each set, to its printed six digits
  row(2410, "proved", 1 / 4); kp = (RH > 0.9962965 && RH < 0.9962975); printf "G24-KAT PROVED at beta = 0.2410: ROW in [%s, %s] against the plan seat's ROW_hi = 0.996297: %s\n", fl(RL), fh(RH), kp ? "MET" : "MISSED"
  row(2450, "sharp", 1 / 4); ks = (RH > 0.9977695 && RH < 0.9977705); kd = (D5H > 0.0261725 && D5L < 0.0261735); kt = (T6H > 0.0604695 && T6L < 0.0604705)
  printf "G24-KAT SHARP at beta = 0.2450: ROW in [%s, %s] against 0.997770: %s; D5 in [%s, %s] against 0.026173: %s; T6 in [%s, %s] against 0.060470: %s\n", fl(RL), fh(RH), ks ? "MET" : "MISSED", fl(D5L), fh(D5H), kd ? "MET" : "MISSED", fl(T6L), fh(T6H), kt ? "MET" : "MISSED"
  row(2410, "proved", 1 / 2); liarok = (RL > 1); printf "G24-LIAR the half-oscillation tilt (1/2 in place of 1/4) on the proved constants at beta = 0.2410: ROW in [%s, %s] -- %s\n", fl(RL), fh(RH), liarok ? "certified ABOVE 1, the liar fails where the plan seat said it does" : "NOT above 1, the liar is admitted"
  v = (kp && ks && kd && kt && liarok && (CROSSK["PROVED (D5 = m(5b)^2/3, T6 = m(6b)/2, tilt 1/4)"] != "") && (CROSSK["SHARP (D5 = |D(5b)|, T6 = |phi'''(6b)|, tilt 1/4)"] != "") && CROSSK["PROVED (D5 = m(5b)^2/3, T6 = m(6b)/2, tilt 1/4)"] >= 2410 && CROSSK["SHARP (D5 = |D(5b)|, T6 = |phi'''(6b)|, tilt 1/4)"] >= 2450)
  printf "G24-VERDICT the plan seat's known answers %s, the liar refused at 0.2410: %s; the row certified below 1 to beta = %s (proved) and %s (sharp)  [%s]\n", (kp && ks && kd && kt) ? "MET" : "MISSED", liarok ? "yes" : "NO", gb(CROSSK["PROVED (D5 = m(5b)^2/3, T6 = m(6b)/2, tilt 1/4)"]), gb(CROSSK["SHARP (D5 = |D(5b)|, T6 = |phi'''(6b)|, tilt 1/4)"]), v ? "G24-GREEN" : "G24-RED"
  if (!v) exit 1 }
