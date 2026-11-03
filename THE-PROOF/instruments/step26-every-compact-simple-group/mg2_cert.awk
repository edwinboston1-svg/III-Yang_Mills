# mg2_cert.awk -- ΟΛΟΚΛΗΡΩΣΙΣ Ο5, MG2's THRESHOLD FOR EVERY COMPACT G RE-DECIDED IN EXACT DIRECTED ROUNDING.  The the development MG2
# (STDLIB/build/aperanton/instruments/2026-11-02/math/MG2/code/general_eval.py; its run of record runs/general_eval.2026-11-02a.txt) certifies
# alpha_G(beta) < 1 on [0, beta*_G] in mpmath interval arithmetic at 200 bits.  This is the SAME formula (Lemma NH's five one-link
# constants from the group's seven numbers; the row sum 12 C_dir + 90 C_med) on a road sharing no line: every number an integer on the grid
# 2^-GB, every operation rounded outward (the KP certificate's idiom), exp by its series with the closed tail, roots by bisection on the
# grid, the tail phi_k(r) = sum_{j>=k} r^j/j! by its geometric bound.  Every quantity of the formula is non-negative and the formula is
# increasing in each, so alpha_hi is assembled from upper ends and alpha_lo from lower ends; PASS iff alpha_hi < 1, FAIL iff alpha_lo >= 1,
# WIDE otherwise (the enclosure alone undecided).  THE GROUP DATA IS READ FROM THE RECORD (the "== NAME ..." lines: n, d, t3, t4, o3, m4,
# c3exact) and beta*_G from its "CERTIFIED alpha_G < 1 on [0, B]" lines, never typed; the antisymmetric-cubic flag (G2, E8) is read from
# general_eval.py's table as DATA.  THE PARITY STAKED (the page's Ο5): PASS at beta* and FAIL at beta* + 1e-4 on this road; a parting is
# printed with both endpoints, never a tolerance (laws 18, 25).  Page DOCS/III-HOLOKLEROSIS-THE-COMPLETION-PREREGISTRATION.md (e6c1349a9).
# gawk traps honoured: 0 - x never -x; arrays named past the builtins; one BEGIN scope.
# usage: gawk -M [-v GB=128] -f mg2_cert.awk STDLIB/build/aperanton/instruments/2026-11-02/math/MG2/runs/general_eval.2026-11-02a.txt
function fdiv(n, d,   r) { r = n % d; if (r < 0) r += d; return (n - r) / d }
function cdiv(n, d,   q) { q = fdiv(n, d); return (q * d == n) ? q : q + 1 }
function g_lo(n, d) { return fdiv(n * SCALE, d) }
function g_hi(n, d) { return cdiv(n * SCALE, d) }
function mul_lo(a, b) { return fdiv(a * b, SCALE) }
function mul_hi(a, b) { return cdiv(a * b, SCALE) }
function div_lo(a, b) { return fdiv(a * SCALE, b) }
function div_hi(a, b) { return cdiv(a * SCALE, b) }
function sqrt_lo(a,   lo, hi, mid, t) { if (a <= 0) return 0; t = a * SCALE; lo = 0; hi = a + SCALE; while (hi - lo > 1) { mid = fdiv(lo + hi, 2); if (mid * mid <= t) lo = mid; else hi = mid } return lo }
function sqrt_hi(a,   lo, hi, mid, t) { if (a <= 0) return 0; t = a * SCALE; lo = 0; hi = a + SCALE; while (hi - lo > 1) { mid = fdiv(lo + hi, 2); if (mid * mid < t) lo = mid; else hi = mid } return hi }
function exp_lo(x,   t, s, k) { t = SCALE; s = SCALE; k = 0; while (1) { k++; t = fdiv(t * x, k * SCALE); if (t == 0) break; s += t } return s }
function exp_hi(x,   t, s, k, kx) { t = SCALE; s = SCALE; k = 0; kx = 2 * cdiv(x, SCALE) + 2
  while (1) { k++; t = cdiv(t * x, k * SCALE); s += t; if (k >= kx && t <= 1) break } return s + 2 * t + 2 }
# phi_k(r) = sum_{j>=k} r^j/j!: the first J terms, the tail (upper only) t_{k+J}/(1 - q), q = r/(k+J+1) < 1/2 required (as the python)
function phi_lo(k, r,   t, s, j) { t = SCALE; for (j = 1; j <= k; j++) t = fdiv(t * r, j * SCALE); s = 0; for (j = k; j < k + PJ; j++) { s += t; t = fdiv(t * r, (j + 1) * SCALE) } return s }
function phi_hi(k, r,   t, s, j, q) { t = SCALE; for (j = 1; j <= k; j++) t = cdiv(t * r, j * SCALE); s = 0; for (j = k; j < k + PJ; j++) { s += t; t = cdiv(t * r, (j + 1) * SCALE) }
  q = cdiv(r, k + PJ + 1); if (2 * q >= SCALE) { print "MG-REFUSED: the phi tail premise q < 1/2 fails"; exit 2 } return s + cdiv(t * SCALE, SCALE - q) }
function min2(a, b) { return (a < b) ? a : b }
# the five constants at r (lo/hi in RL/RH) for the current group; results in K_mu, K_s, K_D, K_T, K_Tx (suffix L/H)
function constants(rl, rh, tag,   p2l, p2h, p3l, p3h, p1l, p1h, s1l, s1h, s0l, s0h, mu1l, mu1h, mul, muh, a1l, a1h, sql, sqh, Dl, Dh, Tl, Th, Ql, Qh, Txl, Txh) {
  p1l = phi_lo(1, rl); p1h = phi_hi(1, rh); p2l = phi_lo(2, rl); p2h = phi_hi(2, rh); p3l = phi_lo(3, rl); p3h = phi_hi(3, rh)
  s1l = INVNL + mul_lo(rl, C3L) + mul_lo(p2l, M4L); s1h = INVNH + mul_hi(rh, C3H) + mul_hi(p2h, M4H)
  s0l = INVNL + mul_lo(rl, O3L) + mul_lo(p2l, M4L); s0h = INVNH + mul_hi(rh, O3H) + mul_hi(p2h, M4H)
  mu1l = mul_lo(rl, INVNL) + fdiv(mul_lo(mul_lo(rl, rl), C3L), 2) + mul_lo(p3l, sqrt_lo(mul_lo(M4L, INVNL)))
  mu1h = mul_hi(rh, INVNH) + cdiv(mul_hi(mul_hi(rh, rh), C3H), 2) + mul_hi(p3h, sqrt_hi(mul_hi(M4H, INVNH)))
  mul = min2(mu1l, mul_lo(rl, s1l)); muh = min2(mu1h, mul_hi(rh, s1h))
  a1l = mul_lo(rl, O3L) + mul_lo(p2l, M4L + INVN2L); a1h = mul_hi(rh, O3H) + mul_hi(p2h, M4H + INVN2H)
  Dl = 2 * a1l + mul_lo(mul, mul); Dh = 2 * a1h + mul_hi(muh, muh)
  sql = sqrt_lo(mul_lo(T4L, M4L)); sqh = sqrt_hi(mul_hi(T4H, M4H))
  Tl = T3L + mul_lo(p1l, sql) + 3 * mul_lo(mul, s0l) + 2 * mul_lo(mul_lo(mul, mul), mul)
  Th = T3H + mul_hi(p1h, sqh) + 3 * mul_hi(muh, s0h) + 2 * mul_hi(mul_hi(muh, muh), muh)
  Ql = T4L + mul_lo(p1l, sql) + 4 * mul_lo(mul, T3L + mul_lo(p1l, sql)) + 6 * mul_lo(mul_lo(mul, mul), s0l)
  Qh = T4H + mul_hi(p1h, sqh) + 4 * mul_hi(muh, T3H + mul_hi(p1h, sqh)) + 6 * mul_hi(mul_hi(muh, muh), s0h)
  Txl = sqrt_lo(mul_lo(s0l, Ql)); Txh = sqrt_hi(mul_hi(s0h, Qh))
  KL[tag, "mu"] = mul; KH[tag, "mu"] = muh; KL[tag, "s"] = s1l; KH[tag, "s"] = s1h; KL[tag, "D"] = Dl; KH[tag, "D"] = Dh
  KL[tag, "T"] = Tl; KH[tag, "T"] = Th; KL[tag, "Tx"] = Txl; KH[tag, "Tx"] = Txh }
# alpha at beta (grid lo/hi bl, bh): sets AL, AH
function alpha(bl, bh,   oml, omh, ompl, omph, Ml, Mh, cdl, cdh, xl, xh, yl, yh, mnl, mnh, cml, cmh, b2l, b2h, b3l, b3h) {
  constants(5 * bl, 5 * bh, 5); constants(6 * bl, 6 * bh, 6)
  b2l = mul_lo(bl, bl); b2h = mul_hi(bh, bh); b3l = mul_lo(b2l, bl); b3h = mul_hi(b2h, bh)
  oml = 3 * mul_lo(b2l, KL[5, "D"]) + 2 * mul_lo(b3l, KL[6, "T"]); omh = 3 * mul_hi(b2h, KH[5, "D"]) + 2 * mul_hi(b3h, KH[6, "T"])
  ompl = 12 * mul_lo(bl, KL[5, "mu"]) + oml; omph = 12 * mul_hi(bh, KH[5, "mu"]) + omh
  Ml = div_lo(exp_lo(fdiv(ompl, 2)), SQNH); Mh = div_hi(exp_hi(cdiv(omph, 2)), SQNL)
  cdl = mul_lo(mul_lo(Ml, bl), KL[5, "mu"]) + fdiv(mul_lo(b2l, KL[5, "D"]) + fdiv(2 * mul_lo(b3l, KL[6, "T"]), 3), 4)
  cdh = mul_hi(mul_hi(Mh, bh), KH[5, "mu"]) + cdiv(mul_hi(b2h, KH[5, "D"]) + cdiv(2 * mul_hi(b3h, KH[6, "T"]), 3), 4)
  xl = mul_lo(b2l, KL[5, "D"]); xh = mul_hi(b2h, KH[5, "D"]); yl = 2 * mul_lo(b3l, KL[5, "Tx"]); yh = 2 * mul_hi(b3h, KH[5, "Tx"])
  mnl = min2(xl, yl); mnh = min2(xh, yh)
  cml = mul_lo(mul_lo(Ml, b2l), KL[5, "s"]) + fdiv(mnl + fdiv(2 * mul_lo(b3l, KL[6, "T"]), 3), 4)
  cmh = mul_hi(mul_hi(Mh, b2h), KH[5, "s"]) + cdiv(mnh + cdiv(2 * mul_hi(b3h, KH[6, "T"]), 3), 4)
  AL = 12 * cdl + 90 * cml; AH = 12 * cdh + 90 * cmh; C12L = 12 * cdl; C12H = 12 * cdh; C90L = 90 * cml; C90H = 90 * cmh }
function dec(n, dig,   neg, ip, r, s, i, q) { neg = 0; if (n < 0) { neg = 1; n = 0 - n } ip = fdiv(n, SCALE); r = n - ip * SCALE; s = ""
  for (i = 0; i < dig; i++) { r *= 10; q = fdiv(r, SCALE); s = s q; r -= q * SCALE } return (neg ? "-" : "") ip "." s }
function frac_lo(s,   i, n, d) { i = index(s, "/"); if (i == 0) return g_lo(s + 0, 1); n = substr(s, 1, i - 1) + 0; d = substr(s, i + 1) + 0; return g_lo(n, d) }
function frac_hi(s,   i, n, d) { i = index(s, "/"); if (i == 0) return g_hi(s + 0, 1); n = substr(s, 1, i - 1) + 0; d = substr(s, i + 1) + 0; return g_hi(n, d) }
function kv(line, k,   i, n, parts, p) { n = split(line, parts, " "); for (i = 1; i <= n; i++) { p = index(parts[i], "="); if (p && substr(parts[i], 1, p - 1) == k) return substr(parts[i], p + 1) } return "" }
function verdict(l, h) { return (h < SCALE) ? "PASS" : (l >= SCALE) ? "FAIL" : "WIDE" }
BEGIN { GB = (GB ? GB : 128); SCALE = 2 ^ GB; PJ = (PJ ? PJ : 120); NG = 0
  ANTI["G2"] = 1; ANTI["E8"] = 1   # general_eval.py: antisym=True for G2 and E8 (read from the source in HEAD as data)
  SQ27 = 27 }
/^== / { NG++; GNAME[NG] = $2; GLINE[NG] = $0; next }
/CERTIFIED alpha_G < 1 on \[0, / { s = $0; sub(/.*on \[0, /, "", s); sub(/\].*/, "", s); GB_STAR[NG] = s; next }
END {
  if (NG == 0) { print "MG-REFUSED: no group lines in the record"; exit 2 }
  printf "MG-ROAD grid=2^-%d phi-terms=%d groups=%d\n", GB, PJ, NG
  met = 0; parted = 0
  for (g = 1; g <= NG; g++) { L = GLINE[g]; name = GNAME[g]
    n = kv(L, "n") + 0; d = kv(L, "d") + 0; t3s = kv(L, "t3"); t4s = kv(L, "t4"); o3s = kv(L, "o3"); m4s = kv(L, "m4"); c3s = kv(L, "c3exact")
    if (GB_STAR[g] == "") { printf "MG-CELL group=%s REFUSED: no certified beta* line in the record\n", name; continue }
    INVNL = g_lo(1, n); INVNH = g_hi(1, n); INVN2L = g_lo(1, n * n); INVN2H = g_hi(1, n * n); SQNL = sqrt_lo(g_lo(n, 1)); SQNH = sqrt_hi(g_hi(n, 1))
    T3L = frac_lo(t3s); T3H = frac_hi(t3s); if (T3L < 0) { T3L = 0 - T3H; T3H = 0 - frac_lo(t3s) }   # |t3|
    T4L = frac_lo(t4s); T4H = frac_hi(t4s); O3L = frac_lo(o3s); O3H = frac_hi(o3s); M4L = frac_lo(m4s); M4H = frac_hi(m4s)
    if (c3s != "None" && c3s != "") { C3L = frac_lo(c3s); C3H = frac_hi(c3s) }
    else { C3L = sqrt_lo(mul_lo(M4L, INVNL)); C3H = sqrt_hi(mul_hi(M4H, INVNH))
      if (name in ANTI) { al = div_lo(SCALE, sqrt_hi(g_hi(27 * d * d * d, 1))); ah = div_hi(SCALE, sqrt_lo(g_lo(27 * d * d * d, 1))); if (ah < C3H) { C3L = al; C3H = ah } } }
    # beta* as a decimal string -> P / 10^k, and beta* + 1e-4
    bs = GB_STAR[g]; k = 0; if (index(bs, ".")) k = length(bs) - index(bs, "."); P = bs; gsub(/\./, "", P); P = P + 0; Qd = 10 ^ k
    if (k < 4) { P = P * 10 ^ (4 - k); Qd = 10 ^ 4 }
    alpha(g_lo(P, Qd), g_hi(P, Qd)); v1 = verdict(AL, AH); a1l = AL; a1h = AH; c12 = C12H; c90 = C90H
    alpha(g_lo(P + Qd / 10000, Qd), g_hi(P + Qd / 10000, Qd)); v2 = verdict(AL, AH)
    par = (v1 == "PASS" && v2 == "FAIL") ? "MET" : "PARTED"; if (par == "MET") met++; else parted++
    printf "MG-CELL group=%s n=%d beta*=%s alpha_lo=%s alpha_hi=%s 12Cdir_hi=%s 90Cmed_hi=%s at-beta*=%s next=%s/%d alpha_next=[%s, %s] at-next=%s parity=%s\n", name, n, bs, dec(a1l, 7), dec(a1h, 7), dec(c12, 6), dec(c90, 6), v1, P + Qd / 10000, Qd, dec(AL, 7), dec(AH, 7), v2, par
    # the raw grid integers for the stranger's kernel (Ο7): alpha_hi(beta*) < 2^GB and alpha_lo(beta* + 1e-4) >= 2^GB are integer comparisons
    printf "MG-GRID group=%s scale=2^%d alpha_hi_at_beta*=%s alpha_lo_at_next=%s\n", name, GB, a1h, AL }
  printf "MG-END groups=%d parity-met=%d parted=%d verdict=%s\n", NG, met, parted, (parted == 0 && met == NG) ? "WHOLE" : "PARTING"
}
