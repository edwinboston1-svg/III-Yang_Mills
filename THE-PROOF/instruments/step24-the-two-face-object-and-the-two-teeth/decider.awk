# decider.awk -- THE DECIDER'S VERDICT RULE IN THE HOUSE LANGUAGE (gawk; replaces decider.py, which stays as the anchor).
# The decider IS the theorem's own hypothesis examined by a calibrated path.  A path speaks at a coupling only if (a) its output
# is the theorem's input (a Dobrushin row with a Perron certificate, or KP on L1-Haar activities) and (b) it passed every tooth
# through the SAME code: T1 the abelian refuter alive, T2 the weak side (SU(2)'s one-loop drift -8 b0 ln 2 = -0.257512 per
# L = 2 step), T0 the strong side.  Otherwise its reading prints UNVALIDATED.  Alphabet (infix-free): CERTIFIED / REFUSED / UNVALIDATED.
# It reads the runs of record and computes nothing new.  Usage: gawk -f decider.awk  (the verdict is the token, never the exit code)
BEGIN {
  C1 = 0.257512
  # ---- T1: the proper-form ratios (photon_gauss, the anchor record b; the house record when it exists) and the charged-scalar control
  nr = 0; while ((getline line < "photon_gauss.2026-11-02b.txt") > 0) if (match(line, /r_inf = ([0-9.]+) \(c =/, m)) { RINF[++nr] = m[1] + 0 }
  close("photon_gauss.2026-11-02b.txt")
  nh = 0; while ((getline line < "photon_gauss.awk.2026-11-02a.txt") > 0) if (match(line, /r_inf = ([0-9.]+)/, m)) { HRINF[++nh] = m[1] + 0 }
  close("photon_gauss.awk.2026-11-02a.txt")
  while ((getline line < "arms.2026-11-02b.txt") > 0) { if (match(line, /^ARM N=([0-9]+)/, m)) N = m[1] + 0; if (match(line, /p = 0\.785398 \(m [0-9]+ -> [0-9]+\): D = +([-0-9.]+)/, m)) { SD = m[1] + 0; SN = N } }
  close("arms.2026-11-02b.txt")
  t1 = (nr > 0); for (i = 1; i <= nr; i++) if (RINF[i] < 0.99 || RINF[i] > 1.01) t1 = 0
  if (SN == "") t1 = 0; else if (SD <= 0) t1 = 0
  # ---- T2: the shifts paired across the anchor records b, c, d (Python) and the house record (awk), fit D = D0 + a p^2 + c/(pN)^2
  readshifts("su2_remainder.2026-11-02b.txt", "anchor"); readshifts("su2_remainder.2026-11-02c.txt", "anchor"); readshifts("su2_remainder.2026-11-02d.txt", "anchor")
  readshifts("su2_remainder.awk.2026-11-02b.txt", "house")
  readshifts("../../holoklerosis/su2_remainder.c.2026-11-02b.txt", "house-c")   # ΟΛΟΚΛΗΡΩΣΙΣ' C port of the gawk engine (21:2x): the N = 64, 96, 128 rows the gawk engine could not reach in a night
  readshifts("../../holoklerosis/su2_remainder.c.2026-11-02c.txt", "house-c")   # its reach past every anchor: N = 192, 256 (21:3x)
  for (src in SRCS) { fit(src) }
  print "THE DECIDER (awk) -- teeth through the same code, verdicts CERTIFIED / REFUSED / UNVALIDATED"
  print "  P1 (one loop: photon exact, charged remainder at Gaussian order; output = a coupling, a CALIBRATOR not a speaker)"
  s = ""; for (i = 1; i <= nr; i++) s = s sprintf("%.5f ", RINF[i])
  printf "     T1 %s  (r_inf %s; scalar D(0.785) %s)\n", (t1 ? "PASS" : "FAIL"), (nr ? s : "none"), (SN != "" ? sprintf("%+.6f at N=%d", SD, SN) : "none")
  if (nh > 0) { s = ""; for (i = 1; i <= nh; i++) s = s sprintf("%.5f ", HRINF[i]); printf "        house record (awk): r_inf %s\n", s }
  for (src in SRCS) printf "     T2 [%s] %s  (D0 = %+.5f from %d rows; stake %+.6f; a = %+.4f c = %+.2f)\n", src, (PASS[src] ? "PASS" : "FAIL"), D0[src], NROWS[src], -C1, AA[src], CC[src]
  print "     T0 NOT-PASSABLE  (perturbation theory has no strong-coupling output)"
  print "     reading at beta = 2.2: UNVALIDATED (T0; and a coupling is not the theorem's input)"
  print "  P2 (the exact engine inside, the Gaussian exterior integrated, block-averaged coordinates): T1 NOT-RUN T2 NOT-RUN T0 NOT-RUN"
  print "     reading at beta = 2.2: UNVALIDATED"
  print "  THE COARSE SECTOR'S CRITERION: the single-link averaged row FAILS at a_c = 4a as a supremum (AD); the wall passes on average (PM); Theorem U's two numbers unread"
  print "DECIDER-VERDICT-AT-2.2: UNVALIDATED"
  exit 0
}
function readshifts(file, src,   line, m, N) {
  N = ""
  while ((getline line < file) > 0) {
    if (line ~ /^RUN/) { N = ""; if (match(line, /^RUN(\((awk|c)\))? N=([0-9]+) m=\[[^]]*\] spin=1 xi=1 ghosts=(True|1) bg=1/, m)) N = m[3] + 0; continue }
    if (N == "") continue
    if (match(line, /m= *([0-9]+) p=[0-9.]+ +beta_eff - beta = +([-0-9.]+)/, m)) { SH[src, N, m[1] + 0] = m[2] + 0; SRCS[src] = 1 }
  }
  close(file)
}
function fit(src,   k, parts, N, mm, p, d, n, s00, s01, s02, s11, s12, s22, b0, b1, b2, det, x0, x1, x2) {
  # rows D(p, N) = SH[N, m/2] - SH[N, m] for even m with p <= 0.8, N >= 48, m >= 4; least squares on [1, p^2, 1/(pN)^2] by the normal equations
  n = 0; s00 = s01 = s02 = s11 = s12 = s22 = b0 = b1 = b2 = 0
  for (k in SH) { split(k, parts, SUBSEP); if (parts[1] != src) continue; N = parts[2] + 0; mm = parts[3] + 0
    if (mm % 2 || !((src SUBSEP N SUBSEP (mm / 2)) in SH)) continue
    p = 2 * atan2(0, -1) * mm / N; if (p > 0.8 || N < 48 || mm < 4) continue
    d = SH[src, N, mm / 2] - SH[src, N, mm]; n++
    x0 = 1; x1 = p * p; x2 = 1 / ((p * N) ^ 2)
    s00 += x0 * x0; s01 += x0 * x1; s02 += x0 * x2; s11 += x1 * x1; s12 += x1 * x2; s22 += x2 * x2; b0 += x0 * d; b1 += x1 * d; b2 += x2 * d }
  NROWS[src] = n; if (n < 3) { PASS[src] = 0; D0[src] = 0; AA[src] = 0; CC[src] = 0; return }
  det = s00 * (s11 * s22 - s12 * s12) - s01 * (s01 * s22 - s12 * s02) + s02 * (s01 * s12 - s11 * s02)
  D0[src] = (b0 * (s11 * s22 - s12 * s12) - s01 * (b1 * s22 - s12 * b2) + s02 * (b1 * s12 - s11 * b2)) / det
  AA[src] = (s00 * (b1 * s22 - s12 * b2) - b0 * (s01 * s22 - s12 * s02) + s02 * (s01 * b2 - b1 * s02)) / det
  CC[src] = (s00 * (s11 * b2 - b1 * s12) - s01 * (s01 * b2 - b1 * s02) + b0 * (s01 * s12 - s11 * s02)) / det
  PASS[src] = (D0[src] + C1 <= 0.01 && D0[src] + C1 >= -0.01)
}
