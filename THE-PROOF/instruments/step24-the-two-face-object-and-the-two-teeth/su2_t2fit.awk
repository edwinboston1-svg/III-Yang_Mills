# su2_t2fit.awk -- THE DECIDER'S T2 RULE RE-RUN ON GIVEN RECORDS (the fit of decider.awk, line for line: rows D(p, N) = shift(N, m/2) -
# shift(N, m) for even m >= 4 with m/2 present, p <= 0.8, N >= 48; least squares on [1, p^2, 1/(pN)^2] by the normal equations; PASS iff
# |D0 + 0.257512| <= 0.01).  It is a READING handed to the development; the verdict stays decider.awk's.
# usage: gawk -f su2_t2fit.awk -v FILES="rec1|rec2|..."  (bar-separated: a path may hold a space)   (spin 1, xi 1, ghosts, bg 1 rows only, as the decider reads them)
BEGIN {
  C1 = 0.257512; nf = split(FILES, FL, "|")   # the separator is a BAR: a path here holds a SPACE (§4)
  for (i = 1; i <= nf; i++) readshifts(FL[i])
  n = 0; s00 = s01 = s02 = s11 = s12 = s22 = b0 = b1 = b2 = 0
  for (k in SH) { split(k, parts, SUBSEP); N = parts[1] + 0; mm = parts[2] + 0
    if (mm % 2 || !((N SUBSEP (mm / 2)) in SH)) continue
    p = 2 * atan2(0, -1) * mm / N; if (p > 0.8 || N < 48 || mm < 4) continue
    d = SH[N, mm / 2] - SH[N, mm]; n++; ROW[n] = sprintf("N=%d p=%.6f (m %d -> %d) D=% .9f", N, p, mm, mm / 2, d)
    x0 = 1; x1 = p * p; x2 = 1 / ((p * N) ^ 2)
    s00 += x0 * x0; s01 += x0 * x1; s02 += x0 * x2; s11 += x1 * x1; s12 += x1 * x2; s22 += x2 * x2; b0 += x0 * d; b1 += x1 * d; b2 += x2 * d }
  for (i = 1; i <= n; i++) print "  T2-ROW " ROW[i]
  if (n < 3) { printf "T2-FIT rows=%d verdict=FAIL (fewer than three rows)\n", n; exit 0 }
  det = s00 * (s11 * s22 - s12 * s12) - s01 * (s01 * s22 - s12 * s02) + s02 * (s01 * s12 - s11 * s02)
  D0 = (b0 * (s11 * s22 - s12 * s12) - s01 * (b1 * s22 - s12 * b2) + s02 * (b1 * s12 - s11 * b2)) / det
  AA = (s00 * (b1 * s22 - s12 * b2) - b0 * (s01 * s22 - s12 * s02) + s02 * (s01 * b2 - b1 * s02)) / det
  CC = (s00 * (s11 * b2 - b1 * s12) - s01 * (s01 * b2 - b1 * s02) + b0 * (s01 * s12 - s11 * s02)) / det
  pass = (D0 + C1 <= 0.01 && D0 + C1 >= -0.01)
  printf "T2-FIT rows=%d D0=% .6f a=% .5f c=% .3f stake=%+.6f |D0-stake|=%.6f verdict=%s\n", n, D0, AA, CC, -C1, (D0 + C1 < 0 ? -(D0 + C1) : D0 + C1), (pass ? "PASS" : "FAIL")
  exit 0
}
function readshifts(file,   line, m, N) {
  N = ""
  while ((getline line < file) > 0) { sub(/\r$/, "", line)
    if (line ~ /^RUN/) { N = ""; if (match(line, /^RUN(\([a-z]*\))? N=([0-9]+) m=\[[^]]*\] spin=1 xi=1 ghosts=(True|1) bg=1/, m)) N = m[2] + 0; continue }
    if (N == "") continue
    if (match(line, /m= *([0-9]+) p=[0-9.]+ +beta_eff - beta = +([-0-9.]+)/, m)) SH[N, m[1] + 0] = m[2] + 0
  }
  close(file)
}
