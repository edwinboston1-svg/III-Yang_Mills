# aperanton_kp_cert.awk -- C2: THE KOTECKÝ–PREISS INEQUALITY OF THE FLUX-SURFACE GAS, CERTIFIED (III-Yang_Mills S1 §14's statement,
# every input named by its lemma; ledger §117).  At a trial (beta, alpha) with alpha~ = kappa_T alpha (kappa_T = 4, the tree's load):
#   the dressing (DRESS=page, S1 §14 / 16.65-a as written): kappa = the least root of
#     kappa = 2 z1 e^kappa + 8 sum_{s>=2} 5^{s-1} max(z_surf(s), z_br(s)) e^{kappa s};
#   the dressing (DRESS=tree, the DEFAULT; the repaired proof, ledger §119): the walls counted once on the whole closed set U u Delta'
#   (2|U u Delta'| - 1.5E of them, (W3)), the pieces of size >= 2 as a forest hanging from the SITES (q, l) of their parent -- a piece
#   of s plaquettes has at most P(s) = 4 min(2s, s(s-1)/2) sites (4 per link of multiplicity >= 2) -- so with kappa' the least root of
#     kappa' = 8 sum_{s>=2} 5^{s-1} max(z_surf(s), z_br(s)) e^{2 z1 s} e^{P(s) kappa'/8}
#   the leaf's dressing is kappa_U = 2 z1 + kappa' (and kappa_U <= the page's kappa, so record a's PASSes stand),
#     z1 = e^{2 alpha~} sum_{j>=1} d_j a_j,   z_surf(s) = e^{2 alpha~ s} sum_{j>=1} d_j a_j^s,   z_br(s) = 3 (gamma a_1 e^{2 alpha~})^s  (s >= 3),
#   u~ = u e^kappa,  r = 5 u~ e^{2 alpha~},  sigma(F) = 1 + sum_{j>=1} d_j^2 (a_j/u)^F  (every j >= 1, half-integers included; z1 and z_surf integer j only),
#   PASS iff  3 [ sum_{F<=F0} (N(F) 4 sigma(F) + 4 N_c(F)) u~^F e^{2 alpha~ F} + (4/5) r^{F0+1}/(1-r) sigma(F0+1) ] <= alpha,
#   N(F) = 4, 60, 80, 1092, 2728, 23508, 80480, 551408 at F = 6, 10, 12, 14, 16, 18, 20, 22 (the census, two roads),
#   N_c(18) = 576, N_c(20) = 3840 + 960 (the contact leaves), a_j = I_{2j+1}(beta)/I_1(beta), u = a_{1/2}, d_j = 2j + 1.
# EVERYTHING IS AN INTERVAL OF EXACT INTEGERS ON THE GRID 2^-GB (floor and ceiling by exact integer division, never a float):
# the Bessel ratios from aperanton_bessel_cert.awk (series with closed tails, rational), exp by its series with the tail 2 t_{K+1}
# once k >= 2x + 2, the spin sums over j <= J with the tail 2 d_{J+1} a_{J+1}^s (a_{j+1}/a_j <= 1/8 for beta <= 2, j >= 1, the
# (1+m)-weighted geometric sum below 2), the s-sum to S with the tail (c2 + 3)/5 rho^{S+1}/(1 - rho), rho = 5 gamma' a_1 e^{2 alpha~ + kappa},
# the dressing root bracketed from below by iteration from 0 (R increasing) and from above by a kappa-bar with R_hi(kappa-bar) <= kappa-bar.
# A PASS is certified; a FAIL is a FAIL of this certificate (the root unbracketed, rho or r at one, or the inequality's upper end above alpha).
# MODES: one point (P/Q, AN/AD, GN/GD, F0); SCAN=1 sweeps beta = BETA0..BETA1 (units 1e-4, step 2) and alpha = AK0..AK1 (units 1e-4) and
# prints beta* = the largest beta with a passing alpha, the KAT being S1 §14's 0.4266 at gamma = 6, F0 = 20.
# F0 = 22 needs NC22 (the contact leaves at 22 are not in the census) or is refused by name.
# gawk traps honoured: 0 - x never -x; arrays named past the builtins; one BEGIN scope, names read whole; no float in a bound.
# usage: AWKPATH=STDLIB/scripts gawk -M -v BESSEL_LIB=1 [-v DRESS=tree|page] [-v P=4266 -v Q=10000 -v AN=2 -v AD=1000 -v GN=6 -v GD=1 -v F0=20] -f STDLIB/scripts/aperanton_kp_cert.awk
#        AWKPATH=STDLIB/scripts gawk -M -v BESSEL_LIB=1 -v SCAN=1 -v BETA0=4200 -v BETA1=4300 -v AK0=10 -v AK1=40 -v GN=6 -v GD=1 -f STDLIB/scripts/aperanton_kp_cert.awk
#        (the Bessel library is found through AWKPATH, so a gate's tooth on the library runs the certificate against the bent copy)
@include "aperanton_bessel_cert.awk"
function fdiv(n, d,   r) { r = n % d; if (r < 0) r += d; return (n - r) / d }
function cdiv(n, d,   q) { q = fdiv(n, d); return (q * d == n) ? q : q + 1 }
function g_lo(n, d) { return fdiv(n * SCALE, d) }
function g_hi(n, d) { return cdiv(n * SCALE, d) }
function mul_lo(a, b) { return fdiv(a * b, SCALE) }
function mul_hi(a, b) { return cdiv(a * b, SCALE) }
function div_lo(a, b) { return fdiv(a * SCALE, b) }
function div_hi(a, b) { return cdiv(a * SCALE, b) }
function pow_lo(a, n,   r, i) { r = SCALE; for (i = 0; i < n; i++) r = mul_lo(r, a); return r }
function pow_hi(a, n,   r, i) { r = SCALE; for (i = 0; i < n; i++) r = mul_hi(r, a); return r }
function exp_lo(x,   t, s, k) { t = SCALE; s = SCALE; k = 0; while (1) { k++; t = fdiv(t * x, k * SCALE); if (t == 0) break; s += t } return s }
function exp_hi(x,   t, s, k, kx) { t = SCALE; s = SCALE; k = 0; kx = 2 * cdiv(x, SCALE) + 2
  while (1) { k++; t = cdiv(t * x, k * SCALE); s += t; if (k >= kx && t <= 1) break } return s + 2 * t + 2 }
function max(a, b) { return a > b ? a : b }
function dec(n, dig,   neg, ip, r, s, i, q) { neg = 0; if (n < 0) { neg = 1; n = 0 - n } ip = fdiv(n, SCALE); r = n - ip * SCALE; s = ""
  for (i = 0; i < dig; i++) { r *= 10; q = fdiv(r, SCALE); s = s q; r -= q * SCALE } return (neg ? "-" : "") ip "." s }
# the Bessel ratios at beta = P/Q on the grid: AL[j2], AH[j2] for j = j2/2, j2 = 1..2J+2
function bessel_table(   j2, tl, th) { if (COEF == "") for (j2 = 1; j2 <= 2 * J + 2; j2++) { aj_lo(j2); AL[j2] = g_lo(RN, RD); aj_hi(j2); AH[j2] = g_hi(RN, RD) }
  # THE EXIT BUDGET's tilt (the far shore section 10, 2026-11-01): TILTN/TILTD per plaquette multiplies every a_j by e^{TILTN/TILTD} in directed rounding --
  # every polymer's weight by e^{tilt |X|}, the Kotecky-Preiss weight a(X) = alpha |L(X)| + tilt |X|; unset, nothing moves.
  if (TILTN > 0) { tl = exp_lo(g_lo(TILTN, TILTD)); th = exp_hi(g_hi(TILTN, TILTD)); for (j2 = 1; j2 <= 2 * J + 2; j2++) { AL[j2] = mul_lo(AL[j2], tl); AH[j2] = mul_hi(AH[j2], th) } }
  # THE COEFFICIENT-SUPPLIED MODE (the far shore section 10 RESULTS 4 (c), 2026-11-01): COEF replaces the Bessel ratios by the blocked
  # one-plaquette weight's own ratios, exact rationals on the grid; refused by name on a wrong count, a negative entry, or a broken tail premise
  if (COEF != "") { ncf = split(COEF, CFL, ","); if (ncf != 2 * J + 2) { printf "KP-CERT REFUSED: COEF needs %d entries (j2 = 1..%d), got %d\n", 2 * J + 2, 2 * J + 2, ncf; exit 2 }
    for (j2 = 1; j2 <= 2 * J + 2; j2++) { split(CFL[j2], cfp, "/"); cfn = cfp[1] + 0; cfd = (cfp[2] == "" ? 1 : cfp[2] + 0); if (cfn < 0 || cfd <= 0) { printf "KP-CERT REFUSED: COEF entry %d is not a non-negative rational\n", j2; exit 2 } AL[j2] = g_lo(cfn, cfd); AH[j2] = g_hi(cfn, cfd) }
    for (j2 = 1; j2 + 2 <= 2 * J + 2; j2++) if (8 * AH[j2 + 2] > AL[j2]) { printf "KP-CERT REFUSED: COEF entries %d and %d break the tail premise a_{j+1} <= a_j / 8\n", j2, j2 + 2; exit 2 }
    for (j2 = 1; j2 + 1 <= 2 * J + 2; j2++) if (AH[j2 + 1] > AL[j2]) { printf "KP-CERT REFUSED: COEF entries %d and %d are not non-increasing in the spin\n", j2, j2 + 1; exit 2 } }
  if (HALFN > 0) { AL[1] = mul_lo(AL[1], g_lo(HALFN, HALFD)); AH[1] = mul_hi(AH[1], g_hi(HALFN, HALFD)) }
  UL = AL[1]; UH = AH[1] }
# the sites of a piece of s plaquettes: 4 per link of multiplicity >= 2, at most min(2s, s(s-1)/2) such links (two plaquettes share
# at most one link; sum m = 4s) -- 4, 12, 24, 40, 48, ... = 8s from s = 5
function psite(s,   a, b) { a = 2 * s; b = s * (s - 1) / 2; return 4 * (a < b ? a : b) }
# R(k): the dressing recursion's right side at k on the grid, rounded down (hi = 0) or up (hi = 1); needs Z1L/Z1H, ZML/ZMH, E2ZL/E2ZH, S
function dress_R(k, hi,   r, s, e, eh2, p, w, ps) {
  if (DRESS == "page") {
    e = hi ? exp_hi(k) : exp_lo(k); r = hi ? 2 * mul_hi(Z1H, e) : 2 * mul_lo(Z1L, e); p = SCALE
    for (s = 2; s <= S; s++) { p = hi ? mul_hi(p, e) : mul_lo(p, e); if (s == 2) p = hi ? mul_hi(e, e) : mul_lo(e, e)
      r += 8 * 5 ^ (s - 1) * (hi ? mul_hi(ZMH[s], p) : mul_lo(ZML[s], p)) }
    return r }
  e = hi ? exp_hi(k) : exp_lo(k); eh2 = hi ? exp_hi(cdiv(k, 2)) : exp_lo(fdiv(k, 2)); r = 0
  for (s = 2; s <= S; s++) {
    ps = psite(s)
    if (ps == 4) p = eh2; else if (ps == 12) p = (hi ? mul_hi(eh2, e) : mul_lo(eh2, e)); else p = (hi ? pow_hi(e, ps / 8) : pow_lo(e, ps / 8))
    w = hi ? mul_hi(pow_hi(E2ZH, s), p) : mul_lo(pow_lo(E2ZL, s), p)
    r += 8 * 5 ^ (s - 1) * (hi ? mul_hi(ZMH[s], w) : mul_lo(ZML[s], w)) }
  return r }
# the test at (beta = P/Q, alpha = AN/AD, gamma = GN/GD, F0); sets VERDICT and the report fields
function kp_test(   ggl, ggh, a2l, a2h, e2l, e2h, s, j2, sl, sh, zl, zh, bl, bh, gl, gh, c2h, rhoh, kl, kh, kp, it, delta, el, eh, rl, rh, ul, uh, tl, th, F, sum_h, sum_l, sgl, sgh, term, tail, lhs_l, lhs_h, al, rbar, ok, rterm, ek, pl, ph, tailr) {
  VERDICT = "FAIL"; WHY = ""
  # alpha~ = 4 alpha on the grid, e^{2 alpha~}
  a2l = g_lo(8 * AN, AD); a2h = g_hi(8 * AN, AD); e2l = exp_lo(a2l); e2h = exp_hi(a2h); E2L = e2l; E2H = e2h
  # gamma and gamma' = max(gamma, 1) on the grid
  gl = g_lo(GN, GD); gh = g_hi(GN, GD); if (gh < SCALE) { gpl = SCALE; gph = SCALE } else { gpl = gl; gph = gh }
  # THE NECK (S1 section 25 (m), (m') after the seat iii-73's second read, 2026-11-01): mu_hi = 4 sum_{j2 >= 3} ((j2 + 1) a_{j2} / (2 a_1))^5 --
  # the per-plaquette ratio d_j a_j / (d_1/2 a_1/2) to the fifth (the cup, the least side), two channels at the neck's links times two sides --
  # the mixed-side factor on the dressing's z1 and z_surf upper ends
  MIXH = 0; for (j2 = 3; j2 <= 2 * J + 2; j2++) MIXH += 4 * pow_hi(div_hi((j2 + 1) * AH[j2], 2 * AL[1]), 5); MIXF = SCALE + MIXH
  # z1
  sl = 0; sh = 0; for (j2 = 2; j2 <= 2 * J; j2 += 2) { sl += (j2 + 1) * AL[j2]; sh += (j2 + 1) * AH[j2] } sh += 2 * (2 * J + 3) * AH[2 * J + 2]
  Z1L = mul_lo(e2l, sl); Z1H = mul_hi(mul_hi(e2h, sh), MIXF)
  # THE WALL FLOOR (RESULTS 4 (b)(iii)): the branch terms price walls and patches at max(a_1, WALLN/WALLD); the surface uses of a_1 are untouched
  W1L = AL[2]; W1H = AH[2]; if (WALLN > 0) { wfl = g_lo(WALLN, WALLD); wfh = g_hi(WALLN, WALLD); if (wfl > W1L) W1L = wfl; if (wfh > W1H) W1H = wfh }
  # zmax(s), s = 2..S, and c2 = sum_j d_j (a_j/a_1)^2 (hi)
  c2h = 0; for (j2 = 2; j2 <= 2 * J; j2 += 2) c2h += (j2 + 1) * pow_hi(div_hi(AH[j2], AL[2]), 2); c2h += 2 * (2 * J + 3) * pow_hi(div_hi(AH[2 * J + 2], AL[2]), 2)
  for (s = 2; s <= S; s++) { sl = 0; sh = 0
    for (j2 = 2; j2 <= 2 * J; j2 += 2) { sl += (j2 + 1) * pow_lo(AL[j2], s); sh += (j2 + 1) * pow_hi(AH[j2], s) } sh += 2 * (2 * J + 3) * pow_hi(AH[2 * J + 2], s)
    zl = mul_lo(pow_lo(e2l, s), sl); zh = mul_hi(mul_hi(pow_hi(e2h, s), sh), MIXF)
    if (GRADED) { ggl = (s <= SMAX) ? GTL[s] : GSL; ggh = (s <= SMAX) ? GTH[s] : GSH; bl = pow_lo(mul_lo(mul_lo(ggl, W1L), e2l), s); bh = pow_hi(mul_hi(mul_hi(ggh, W1H), e2h), s) }
    else if (s >= 3) { bl = 3 * pow_lo(mul_lo(mul_lo(gl, W1L), e2l), s); bh = 3 * pow_hi(mul_hi(mul_hi(gh, W1H), e2h), s) } else { bl = 0; bh = 0 }
    ZML[s] = max(zl, bl); ZMH[s] = max(zh, bh) }
  # the dressing root (DRESS = page or tree, dress_R above): lower by iteration from 0 (R increasing, every iterate below the least
  # root), upper by a kappa-bar on a quartering ladder from the grid's own scale with R_hi(kappa-bar) <= kappa-bar
  E2ZL = exp_lo(2 * Z1L); E2ZH = exp_hi(2 * Z1H)
  kl = 0
  for (it = 1; it <= KITER; it++) { kp = dress_R(kl, 0)
    if (kp > 3 * SCALE) { WHY = "the dressing iteration leaves [0, 3]: no root"; return }
    if (kp - kl <= 1) { kl = kp; break } kl = kp }
  delta = 2; ok = 0
  while (delta <= 2 * SCALE) { rbar = kl + delta; eh = exp_hi(rbar)
    # rho, the ratio of the s-tail: 5 gamma' a_1 e^{2 alpha~} e^kappa (page) or 5 gamma' a_1 e^{2 alpha~} e^{2 z1} e^{kappa'} (tree)
    rhoh = mul_hi(mul_hi(mul_hi(5 * (GRADED ? (GMAXH < SCALE ? SCALE : GMAXH) : gph), W1H), e2h), eh); if (DRESS != "page") rhoh = mul_hi(rhoh, E2ZH)
    if (rhoh >= SCALE) { WHY = "rho >= 1 at the upper bracket: the s-sum's tail is not closed"; return }
    kh = dress_R(rbar, 1)
    # the tail of the s-sum: (c2 + 3)/5 rho^{S+1}/(1 - rho)
    tailr = cdiv(mul_hi(c2h + (GRADED ? 1 : 3) * SCALE, pow_hi(rhoh, S + 1)) * SCALE, 5 * (SCALE - rhoh)); kh += 8 * tailr
    if (kh <= rbar) { ok = 1; break } delta *= 4 }
  if (!ok) { WHY = "no kappa-bar with R_hi(kappa-bar) <= kappa-bar below 2"; return }
  KL = kl; KH = rbar
  # the leaf's dressing kappa_U: the root itself (page) or 2 z1 + kappa' (tree)
  if (DRESS == "page") { KUL = KL; KUH = KH } else { KUL = KL + 2 * Z1L; KUH = KH + 2 * Z1H }
  # u~, r
  ul = mul_lo(UL, exp_lo(KUL)); uh = mul_hi(UH, exp_hi(KUH)); UTL = ul; UTH = uh
  rl = 5 * mul_lo(ul, e2l); rh = 5 * mul_hi(uh, e2h); RL = rl; RH = rh
  if (rh >= SCALE) { WHY = "r >= 1: the tail over F > F0 does not close"; return }
  # the leaf sum
  sum_l = 0; sum_h = 0
  for (F = 6; F <= F0; F += 2) { if (!(F in NF_) ) continue
    sgl = SCALE; sgh = SCALE
    for (j2 = 2; j2 <= 2 * J; j2++) { sgl += (j2 + 1) ^ 2 * pow_lo(div_lo(AL[j2], UH), F); sgh += (j2 + 1) ^ 2 * pow_hi(div_hi(AH[j2], UL), F) }
    sgh += 3 * (2 * J + 2) ^ 2 * pow_hi(div_hi(AH[2 * J + 1], UL), F)
    # M1 NCSIG=1: a census contact leaf (m = 1, one spin per leaf) carries sigma(F) like a surface (S11 at spin j: a_j^F d_j^2)
    nch = (NCSIG ? sgh : SCALE); ncl = (NCSIG ? sgl : SCALE)
    term = mul_hi(NF_[F] * 4 * sgh + 4 * NC_[F] * nch, mul_hi(pow_hi(uh, F), pow_hi(e2h, F))); sum_h += term
    term = mul_lo(NF_[F] * 4 * sgl + 4 * NC_[F] * ncl, mul_lo(pow_lo(ul, F), pow_lo(e2l, F))); sum_l += term }
  # the tail: (4/5) r^{F0+1}/(1-r) sigma(F0+1)
  sgh = SCALE; for (j2 = 2; j2 <= 2 * J; j2++) sgh += (j2 + 1) ^ 2 * pow_hi(div_hi(AH[j2], UL), F0 + 1); sgh += 3 * (2 * J + 2) ^ 2 * pow_hi(div_hi(AH[2 * J + 1], UL), F0 + 1)
  tail = mul_hi(cdiv(4 * pow_hi(rh, F0 + 1) * SCALE, 5 * (SCALE - rh)), sgh)
  sgl = SCALE; for (j2 = 2; j2 <= 2 * J; j2++) sgl += (j2 + 1) ^ 2 * pow_lo(div_lo(AL[j2], UH), F0 + 1)
  tl = mul_lo(fdiv(4 * pow_lo(rl, F0 + 1) * SCALE, 5 * (SCALE - rl)), sgl)
  if (EVENTAIL) {   # M1 2026-11-02 (WORK.md section 1): the tail over EVEN F >= F0 + 2 only (Lemma T1, closed sets have even size) with
    # N(F) <= 5^{F-2} (Lemma T2, the last closing step is forced): 3 (4C/25) sigma(F0+2) (rK)^{F0+2} / (1 - (rK)^2).
    # K = TKN/TKD and C = TCN/TCD multiply the TAIL ONLY (default 1): never the enumerated leaves, never the dressing.
    rkh = mul_hi(rh, KTH); rkl = mul_lo(rl, KTL)
    if (rkh >= SCALE) { WHY = "rK >= 1: the even tail does not close"; return }
    r2h = mul_hi(rkh, rkh); r2l = mul_lo(rkl, rkl)
    sgh = SCALE; for (j2 = 2; j2 <= 2 * J; j2++) sgh += (j2 + 1) ^ 2 * pow_hi(div_hi(AH[j2], UL), F0 + 2); sgh += 3 * (2 * J + 2) ^ 2 * pow_hi(div_hi(AH[2 * J + 1], UL), F0 + 2)
    sgl = SCALE; for (j2 = 2; j2 <= 2 * J; j2++) sgl += (j2 + 1) ^ 2 * pow_lo(div_lo(AL[j2], UH), F0 + 2)
    tail = mul_hi(mul_hi(cdiv(4 * pow_hi(rkh, F0 + 2) * SCALE, 25 * (SCALE - r2h)), sgh), CTH)
    tl = mul_lo(mul_lo(fdiv(4 * pow_lo(rkl, F0 + 2) * SCALE, 25 * (SCALE - r2l)), sgl), CTL)
    tcondh = tail
    if (UNCOND) {   # M1 (WORK.md section 3, Corollary U): every Z2-minimal leaf, all spins, NO STAKE:
      # sum_spins |W| <= 4 u^F [C1 K1^F + CI KI^F], K1 = (2(1+d1))^{5/8}, C1 = (1+d1)(2(1+d1))^{5/2}, KI = 2^{5/4} e1, CI = 32,
      # d1 = sum_{j half >= 3/2} (d_j/2)^2 16 a_j/u (Lemma S (d)), e1 = sum_{j int >= 1} (d_j/2)^2 a_j/u (Lemma S (c)); all rounded UP
      d1h = 0; for (j2 = 3; j2 <= 2 * J + 1; j2 += 2) d1h += ((j2 + 1) / 2) ^ 2 * 16 * div_hi(AH[j2], UL)
      d1h += 2 * (J + 2) ^ 2 * 16 * div_hi(AH[2 * J + 1], UL)
      e1h = 0; for (j2 = 2; j2 <= 2 * J; j2 += 2) e1h += cdiv((j2 + 1) ^ 2 * div_hi(AH[j2], UL), 4)
      e1h += cdiv(2 * (2 * J + 3) ^ 2 * div_hi(AH[2 * J + 2], UL), 4)
      Bh = 2 * (SCALE + d1h)
      # K1 = least grid x with x^8 >= B^5 (pow_lo(x,8) >= pow_hi(B,5)); sqrt(B) likewise; 2^{5/4} = least x with x^4 >= 32
      tgt = pow_hi(Bh, 5); lo = SCALE; hi = 4 * SCALE; while (hi - lo > 1) { mid = fdiv(lo + hi, 2); if (pow_lo(mid, 8) >= tgt) hi = mid; else lo = mid } K1H = hi
      tgt = Bh; lo = SCALE; hi = 4 * SCALE; while (hi - lo > 1) { mid = fdiv(lo + hi, 2); if (pow_lo(mid, 2) >= tgt) hi = mid; else lo = mid } SQBH = hi
      C1H = mul_hi(mul_hi(SCALE + d1h, mul_hi(Bh, Bh)), SQBH)
      tgt = 32 * SCALE; lo = SCALE; hi = 4 * SCALE; while (hi - lo > 1) { mid = fdiv(lo + hi, 2); if (pow_lo(mid, 4) >= tgt) hi = mid; else lo = mid } KIH = mul_hi(hi, e1h)
      CIH = 32 * SCALE
      if (U712) {   # M1 Lemma M' + (E3''): the exponent is b1(G) + b1(G6) <= (7/12)F + 7/3 (WORK.md section 3b):
        # K1 = (2(1+d1))^{7/12} (least x with x^12 >= B^7), C1 = (1+d1)(2(1+d1))^{7/3} = (1+d1) B^2 B^{1/3}, KI = 2^{7/6} e1, CI = 2^{14/3}
        tgt = pow_hi(Bh, 7); lo = SCALE; hi = 4 * SCALE; while (hi - lo > 1) { mid = fdiv(lo + hi, 2); if (pow_lo(mid, 12) >= tgt) hi = mid; else lo = mid } K1H = hi
        tgt = Bh; lo = SCALE; hi = 4 * SCALE; while (hi - lo > 1) { mid = fdiv(lo + hi, 2); if (pow_lo(mid, 3) >= tgt) hi = mid; else lo = mid } CBH = hi
        C1H = mul_hi(mul_hi(SCALE + d1h, mul_hi(Bh, Bh)), CBH)
        tgt = 128 * SCALE; lo = SCALE; hi = 4 * SCALE; while (hi - lo > 1) { mid = fdiv(lo + hi, 2); if (pow_lo(mid, 6) >= tgt) hi = mid; else lo = mid } KIH = mul_hi(hi, e1h)
        tgt = 16384 * SCALE; lo = SCALE; hi = 64 * SCALE; while (hi - lo > 1) { mid = fdiv(lo + hi, 2); if (pow_lo(mid, 3) >= tgt) hi = mid; else lo = mid } CIH = hi }
      if (U12) {   # M1 Lemma E4 (WORK.md section 13; the 027_P relay's lattice fact E <= 4V - 4 per component, and (E2) sharpened by the
        # same fact on X's 1-skeleton): B = b1(G) + b1(G6) <= (3/4)(N4 + 2 N6) <= F/2 + 1, b1(G) <= F/2 + 1. Hence
        # K1 = (2(1+d1))^{1/2} = SQBH (least grid x with x^2 >= B), C1 = (1+d1) B, KI = 2 e1, CI = 4.
        K1H = SQBH; C1H = mul_hi(SCALE + d1h, Bh); KIH = 2 * e1h; CIH = 4 * SCALE }
      if (UPQ) {   # M1b (its WORK.md section 5): a PROJECTION mode, a theorem only where its hypothesis is: IF b1(G) + b1(G6) <= c'F + C0
        # and b1(G) <= c'F + C0 with c' = UPN/UPD and C0 = UC0 (integer >= 0), Lemma S gives K1 = B^{c'} (least grid x with x^UPD >= B^UPN),
        # C1 = (1+d1) B^{C0}, KI = 4^{c'} e1 (least grid x with x^UPD >= 4^UPN, times e1), CI = 4^{C0}. UPN=1 UPD=2 UC0=1 is U12 exactly.
        tgt = pow_hi(Bh, UPN); lo = SCALE; hi = 4 * SCALE; while (hi - lo > 1) { mid = fdiv(lo + hi, 2); if (pow_lo(mid, UPD) >= tgt) hi = mid; else lo = mid } K1H = hi
        C1H = SCALE + d1h; for (iq = 0; iq < UC0; iq++) C1H = mul_hi(C1H, Bh)
        tgt = 4 ^ UPN * SCALE; lo = SCALE; hi = 4 * SCALE; while (hi - lo > 1) { mid = fdiv(lo + hi, 2); if (pow_lo(mid, UPD) >= tgt) hi = mid; else lo = mid } KIH = mul_hi(hi, e1h)
        CIH = 4 ^ UC0 * SCALE }
      rk1 = mul_hi(rh, K1H); rki = mul_hi(rh, KIH)
      if (rk1 >= SCALE) { WHY = "r K1 >= 1: the unconditional tail does not close"; D1H = d1h; E1H = e1h; return }
      t1 = mul_hi(cdiv(4 * pow_hi(rk1, F0 + 2) * SCALE, 25 * (SCALE - mul_hi(rk1, rk1))), C1H)
      ti = mul_hi(cdiv(4 * pow_hi(rki, F0 + 2) * SCALE, 25 * (SCALE - mul_hi(rki, rki))), CIH)
      tail = mul_hi(t1 + ti, sgh); tl = 0; D1H = d1h; E1H = e1h
      if (FMIN1 > 0) {   # M1 PROJECTION (WORK.md section 8 (1)), NOT A THEOREM: IF every Z2-minimal leaf with F < FMIN1 had a forest
        # contact graph (b1(G) = 0: one piece, the proved 4 sigma(F) u^F), the tail would be the conditional even tail over every
        # F >= F0 + 2 (an upper bound on its part below FMIN1) plus Corollary U' summed over even F >= FMIN1.
        t1 = mul_hi(cdiv(4 * pow_hi(rk1, FMIN1) * SCALE, 25 * (SCALE - mul_hi(rk1, rk1))), C1H)
        ti = mul_hi(cdiv(4 * pow_hi(rki, FMIN1) * SCALE, 25 * (SCALE - mul_hi(rki, rki))), CIH)
        tail = tcondh + mul_hi(t1 + ti, sgh) }
      if (UNCREC) {   # M1 control: Corollary U's activity under the RECORD's counting (N(F) <= 5^{F-1}, every F >= F0 + 1):
        # (4/5) sigma(F0+1) [C1 (rK1)^{F0+1}/(1 - rK1) + CI (rKI)^{F0+1}/(1 - rKI)] -- what the density lemma buys without T1, T2
        s1h = SCALE; for (j2 = 2; j2 <= 2 * J; j2++) s1h += (j2 + 1) ^ 2 * pow_hi(div_hi(AH[j2], UL), F0 + 1); s1h += 3 * (2 * J + 2) ^ 2 * pow_hi(div_hi(AH[2 * J + 1], UL), F0 + 1)
        t1 = mul_hi(cdiv(4 * pow_hi(rk1, F0 + 1) * SCALE, 5 * (SCALE - rk1)), C1H)
        ti = mul_hi(cdiv(4 * pow_hi(rki, F0 + 1) * SCALE, 5 * (SCALE - rki)), CIH)
        tail = mul_hi(t1 + ti, s1h) } } }
  SUMH = sum_h; TAILH = tail
  lhs_h = 3 * (sum_h + tail); lhs_l = 3 * (sum_l + tl); LHSL = lhs_l; LHSH = lhs_h
  al = g_lo(AN, AD); ALPHA_G = al
  if (lhs_h <= al) VERDICT = "PASS"; else WHY = "the inequality's upper end is above alpha" }
function report() { printf "KP-CERT dress=%s%s%s beta=%s alpha=%d/%d gamma=%d/%d F0=%d: kappa_U in [%s, %s] root in [%s, %s] u in [%s, %s] u~ in [%s, %s] r_hi=%s LHS in [%s, %s] alpha=%s -> %s%s mix=%s\n", DRESS, (GRADED ? GTAG : ""), TTAG, (COEF != "" ? "supplied" : P "/" Q), AN, AD, GN, GD, F0, dec(KUL, 6), dec(KUH, 6), dec(KL, 6), dec(KH, 6), dec(UL, 8), dec(UH, 8), dec(UTL, 8), dec(UTH, 8), dec(RH, 6), dec(LHSL, 7), dec(LHSH, 7), dec(ALPHA_G, 7), VERDICT, (WHY == "" ? "" : " (" WHY ")"), dec(MIXH, 12); if (EVENTAIL) printf "KP-CERT M1-TAIL enum_hi=%s tail_hi=%s rK_hi=%s\n", dec(3 * SUMH, 7), dec(3 * TAILH, 7), dec(mul_hi(RH, KTH), 6); if (UNCOND) printf "KP-CERT M1-UNCOND delta1_hi=%s eps1_hi=%s K1_hi=%s C1_hi=%s KI_hi=%s rK1_hi=%s\n", dec(D1H, 8), dec(E1H, 8), dec(K1H, 8), dec(C1H, 6), dec(KIH, 8), dec(mul_hi(RH, K1H), 6) }
# THE GRADED COLUMN'S ROOTS (S1 section 21): the m-th root of the rational n/d bracketed on the grid -- below by the largest x with
# pow_hi(x, m) <= [n/d]_lo (then x^m <= n/d), above by the least x with pow_lo(x, m) >= [n/d]_hi (then x^m >= n/d); 16 is the ceiling
function rootm_lo(n, d, m,   lo, hi, mid, G) { G = g_lo(n, d); lo = 0; hi = 16 * SCALE; while (hi - lo > 1) { mid = fdiv(lo + hi, 2); if (pow_hi(mid, m) <= G) lo = mid; else hi = mid } return lo }
function rootm_hi(n, d, m,   lo, hi, mid, G) { G = g_hi(n, d); lo = 0; hi = 16 * SCALE; while (hi - lo > 1) { mid = fdiv(lo + hi, 2); if (pow_lo(mid, m) >= G) hi = mid; else lo = mid } return hi }
BEGIN { GB = (GB ? GB : 128); SCALE = 2 ^ GB; PREC = 128; J = (J ? J : 7); S = (S ? S : 40); KITER = (KITER ? KITER : 200); K = (K ? K : 24)
  if (!F0) F0 = 20; if (!GN) { GN = 6; GD = 1 } if (!GD) GD = 1; if (!AD) AD = 1000; if (!AN) AN = 2; if (!TILTN) TILTN = 0; if (!TILTD) TILTD = 1; TTAG = (TILTN > 0) ? (" tilt=" TILTN "/" TILTD) : ""
  if (!HALFN) HALFN = 0; if (!HALFD) HALFD = 1; if (!WALLN) WALLN = 0; if (!WALLD) WALLD = 1
  if (!TKN) { TKN = 1; TKD = 1 } if (!TKD) TKD = 1; if (!TCN) { TCN = 1; TCD = 1 } if (!TCD) TCD = 1
  KTL = g_lo(TKN, TKD); KTH = g_hi(TKN, TKD); CTL = g_lo(TCN, TCD); CTH = g_hi(TCN, TCD)
  if (EVENTAIL) TTAG = TTAG " eventail K=" TKN "/" TKD " C=" TCN "/" TCD
  if (COEF != "") TTAG = TTAG " coef=supplied"; if (HALFN > 0) TTAG = TTAG " half=" HALFN "/" HALFD; if (WALLN > 0) TTAG = TTAG " wall=" WALLN "/" WALLD
  if (!DRESS) DRESS = "tree"; if (DRESS != "tree" && DRESS != "page") { print "KP-CERT REFUSED: DRESS must be tree or page"; exit 2 }
  # THE GRADED COLUMN (GRADED=1): gamma(s) from the junction theorem's closed form, bracketed on the grid; the sub-gas of m_T = 1 pieces
  GTAG = " graded=S21-subgas"
  # THE LOCAL THEOREM'S COLUMN (LOCAL=1; S1 section 24, 2026-10-30): gamma(s) = 3 theta(s)^4 with theta(s) = max_{k <= s} r2max(k)^{1/(2k)} and
  # r2max(k) the EXACT maximum of r_v^2 over the whole local family at k plaquettes (307,529 configurations through k = 8, the intertwiner
  # engine, local_stars_exact.2026-10-30b.txt): 1, 1, 3/2, 3/2, 9/4, 3271/900, 85/27, 8531/3240 for k = 1..8, so gamma(s) = 3 (r2max^2)^{1/k}
  # maximised over k <= s, each root bracketed on the grid; the s-tail (s >= 9) at the STAKED rate TN/TD (gamma(9+) >= gamma(8) by monotonicity)
  # until the k = 9..24 maxima are read from the whole enumeration (local_enum_c.2026-10-30c.txt, 1,284,303 configurations), when TN/TD is
  # replaced by the exact tail and the stake retired.  z_br(s) = (gamma(s) a_1 e^{2 alpha~})^s with no prefactor, as the graded column.
  if (LOCAL) { GRADED = 1; SMAX = 8; GTAG = " graded=S24-local"
    R2N[1] = 1; R2D[1] = 1; R2N[2] = 1; R2D[2] = 1; R2N[3] = 3; R2D[3] = 2; R2N[4] = 3; R2D[4] = 2; R2N[5] = 9; R2D[5] = 4; R2N[6] = 3271; R2D[6] = 900; R2N[7] = 85; R2D[7] = 27; R2N[8] = 8531; R2D[8] = 3240
    for (s = 1; s <= 8; s++) { ll = 3 * rootm_lo(R2N[s] ^ 2, R2D[s] ^ 2, s); hh = 3 * rootm_hi(R2N[s] ^ 2, R2D[s] ^ 2, s)
      GTL[s] = (s > 1 && GTL[s - 1] > ll) ? GTL[s - 1] : ll; GTH[s] = (s > 1 && GTH[s - 1] > hh) ? GTH[s - 1] : hh }
    if (R2TAB != "") {   # THE TABLE MODE (2026-10-30 06:4x EDT, the trunk seat): sixteen more rows, k = 9..24.  The family is FINITE -- a vertex star is a
      # simple subgraph of K_{2,2,2,2}, so k <= 24 -- and the "s-tail" is this table: gamma(s >= 25) = gamma(24).  Each entry is an UPPER BOUND on
      # r2max(k) as a rational n/d: the exact maximum where every row at k has been read by the engine, else the Frobenius sieve's proven bound
      # over the unread rows (local_tail_table.awk builds the list from the pass records and the tail enumeration).  Nothing staked.
      nt = split(R2TAB, TB, ","); if (nt != 16) { print "KP-CERT REFUSED: R2TAB needs sixteen entries (k = 9..24)"; exit 2 }
      for (s = 9; s <= 24; s++) { split(TB[s - 8], tf, "/"); tn = tf[1] + 0; td = (tf[2] == "" ? 1 : tf[2] + 0); if (tn <= 0 || td <= 0) { print "KP-CERT REFUSED: R2TAB entry " (s - 8) " is not a positive rational"; exit 2 }
        ll = 3 * rootm_lo(tn ^ 2, td ^ 2, s); hh = 3 * rootm_hi(tn ^ 2, td ^ 2, s); GTL[s] = (GTL[s - 1] > ll) ? GTL[s - 1] : ll; GTH[s] = (GTH[s - 1] > hh) ? GTH[s - 1] : hh }
      SMAX = 24; GSL = GTL[24]; GSH = GTH[24]; GMAXH = GSH; GTAG = " graded=S24-table"
      printf "KP-CERT LOCAL TABLE (S1 section 24: the exact table through k = 8, then the k = 9..24 upper bounds of R2TAB): gamma(s) = 3 max_{k<=s} (r2max(k)^2)^{1/k}:"
      for (s = 1; s <= 24; s++) printf " s=%s [%s, %s]", s, dec(GTL[s], 6), dec(GTH[s], 6); printf "; s>=25 at gamma(24) (the family ends at k = 24); no prefactor 3\n" }
    else { if (!TN) { TN = 46125; TD = 10000 } if (!TD) TD = 1
      GSL = g_lo(TN, TD); GSH = g_hi(TN, TD); if (GSL < GTL[8]) GSL = GTL[8]; if (GSH < GTH[8]) GSH = GTH[8]; GMAXH = GSH
      printf "KP-CERT LOCAL (S1 section 24, the local theorem's exact table through k = 8): gamma(s) = 3 max_{k<=s} (r2max(k)^2)^{1/k}:"
      for (s = 1; s <= 8; s++) printf " s=%s [%s, %s]", s, dec(GTL[s], 6), dec(GTH[s], 6); printf "; s>=9 at the STAKED tail gamma = %d/%d in [%s, %s] (the k = 9..24 maxima unread); no prefactor 3\n", TN, TD, dec(GSL, 6), dec(GSH, 6) } }
  else if (GRADED) {
    # THE SUB-GAS MODE REWRITTEN 2026-10-31 23:5x-00:0x (S1 section 21 J6', section 24 Theorem L).  J6' (iii-ac's referee read SIGNED it
    # step by step): for a piece of s <= 8 plaquettes with singly-used rest links the free spokes count exactly, sum_v r_v = sum_q (2 j_q - 2 c_q)
    # with j_q - c_q <= 2, so |N(Y)| <= (e(D)^{2/D})^s and gamma(s) = 3 e(D)^{2/D} = E(D)^{2/D}, D = min(8, s), E(r) = (3^r + 3(-1)^r)/4;
    # gamma(2) = sqrt 3 (S9 exact).  The s >= 9 tail is NOT J5's 3^k (the double cut and capped: its first inequality is REFUSED AS DISPLAYED
    # by the same read) -- it is Theorem L's through the TABLE, gamma(s) = 3 max_{k<=s} (r2max(k)^2)^{1/k} (the exact table through k = 8,
    # R2TAB's certified bounds beyond), which bounds every piece and so the sub-gas; for s <= 8 the lesser of the two proved rates is taken.
    # J6's 3 e(D)^{3/D} and its tail 9.2709 rested on the false step k <= |Y| - |T|/3 and are gone.  Without R2TAB the mode REFUSES.
    if (R2TAB == "") { print "KP-CERT REFUSED: the graded mode's s >= 9 tail needs the table (R2TAB) -- J5's 3^k is refused as displayed (S1 section 21, 2026-10-31)"; exit 2 }
    R2N[1] = 1; R2D[1] = 1; R2N[2] = 1; R2D[2] = 1; R2N[3] = 3; R2D[3] = 2; R2N[4] = 3; R2D[4] = 2; R2N[5] = 9; R2D[5] = 4; R2N[6] = 3271; R2D[6] = 900; R2N[7] = 85; R2D[7] = 27; R2N[8] = 8531; R2D[8] = 3240
    for (s = 1; s <= 8; s++) { ll = 3 * rootm_lo(R2N[s] ^ 2, R2D[s] ^ 2, s); hh = 3 * rootm_hi(R2N[s] ^ 2, R2D[s] ^ 2, s)
      TTL[s] = (s > 1 && TTL[s - 1] > ll) ? TTL[s - 1] : ll; TTH[s] = (s > 1 && TTH[s - 1] > hh) ? TTH[s - 1] : hh }
    nt = split(R2TAB, TB, ","); if (nt != 16) { print "KP-CERT REFUSED: R2TAB needs sixteen entries (k = 9..24)"; exit 2 }
    for (s = 9; s <= 24; s++) { split(TB[s - 8], tf, "/"); tn = tf[1] + 0; td = (tf[2] == "" ? 1 : tf[2] + 0); if (tn <= 0 || td <= 0) { print "KP-CERT REFUSED: R2TAB entry " (s - 8) " is not a positive rational"; exit 2 }
      ll = 3 * rootm_lo(tn ^ 2, td ^ 2, s); hh = 3 * rootm_hi(tn ^ 2, td ^ 2, s); TTL[s] = (TTL[s - 1] > ll) ? TTL[s - 1] : ll; TTH[s] = (TTH[s - 1] > hh) ? TTH[s - 1] : hh }
    GTL[1] = TTL[1]; GTH[1] = TTH[1]
    jl = rootm_lo(3, 1, 2); jh = rootm_hi(3, 1, 2); GTL[2] = (jl < TTL[2]) ? jl : TTL[2]; GTH[2] = (jh < TTH[2]) ? jh : TTH[2]
    for (s = 3; s <= 8; s++) { Es = (3 ^ s + (s % 2 ? -3 : 3)) / 4; jl = rootm_lo(Es ^ 2, 1, s); jh = rootm_hi(Es ^ 2, 1, s); GTL[s] = (jl < TTL[s]) ? jl : TTL[s]; GTH[s] = (jh < TTH[s]) ? jh : TTH[s] }
    for (s = 9; s <= 24; s++) { GTL[s] = TTL[s]; GTH[s] = TTH[s] }
    SMAX = 24; GSL = GTL[24]; GSH = GTH[24]; GMAXH = GSH; for (s = 2; s <= 24; s++) if (GTH[s] > GMAXH) GMAXH = GTH[s]; GTAG = " graded=S21-J6prime+S24-table"
    printf "KP-CERT GRADED (S1 section 21 J6-prime with Theorem L's tail, the sub-gas of m_T = 1 pieces): gamma(s) = min(E(D)^{2/D}, 3 theta(s)^4) for s <= 8 (gamma(2) = sqrt 3), D = min(8, s), E(r) = (3^r + 3(-1)^r)/4; gamma(s) = 3 theta(s)^4 from the table for s = 9..24:"
    for (s = 1; s <= 24; s++) printf " s=%s [%s, %s]", s, dec(GTL[s], 6), dec(GTH[s], 6); printf "; s>=25 at gamma(24); no prefactor 3; J5 not used\n" }
  NF_[6] = 4; NF_[10] = 60; NF_[12] = 80; NF_[14] = 1092; NF_[16] = 2728; NF_[18] = 23508; NF_[20] = 80480; NF_[22] = 551408
  for (F = 6; F <= 22; F += 2) NC_[F] = 0; NC_[18] = 576; NC_[20] = 3840 + 960
  if (F0 == 22) { if (!NC22) { print "KP-CERT REFUSED: F0 = 22 needs NC22, the contact-leaf count at 22, which the census does not hold"; exit 2 } NC_[22] = NC22 + 0 }
  if (F0 != 20 && F0 != 22) { print "KP-CERT REFUSED: F0 must be 20 or 22"; exit 2 }
  if (!SCAN) { if (!P) { P = 4266; Q = 10000 } if (!Q) Q = 1; if (2 * Q < P) { print "KP-CERT REFUSED: beta > 2 is outside the series' halving range"; exit 2 }
    bessel_table(); kp_test(); report(); exit 0 }
  # the scan: beta in units of 1e-4, step 2; alpha in units of 1e-4
  if (!BETA0) BETA0 = 4000; if (!BETA1) BETA1 = 4400; if (!AK0) AK0 = 10; if (!AK1) AK1 = 40
  best = 0; Q = 10000; AD = 10000
  for (bp = BETA0; bp <= BETA1; bp += 2) { P = bp; bessel_table(); firstpass = 0; lastpass = 0
    for (ak = AK0; ak <= AK1; ak++) { AN = ak; kp_test(); if (VERDICT == "PASS") { if (!firstpass) firstpass = ak; lastpass = ak } }
    if (firstpass) { best = bp; printf "KP-CERT SCAN dress=%s%s beta=%.4f gamma=%d/%d F0=%d: PASS for alpha in [%.4f, %.4f]\n", DRESS, (GRADED ? GTAG : ""), bp / 10000, GN, GD, F0, firstpass / 10000, lastpass / 10000 }
    else printf "KP-CERT SCAN dress=%s%s beta=%.4f gamma=%d/%d F0=%d: no passing alpha in [%.4f, %.4f] (last: %s)\n", DRESS, (GRADED ? GTAG : ""), bp / 10000, GN, GD, F0, AK0 / 10000, AK1 / 10000, WHY }
  printf "KP-CERT SCAN dress=%s%s gamma=%d/%d F0=%d: beta* = %.4f (the largest beta with a certified PASS on the 2e-4 grid, alpha on the 1e-4 grid)\n", DRESS, (GRADED ? GTAG : ""), GN, GD, F0, best / 10000 }
