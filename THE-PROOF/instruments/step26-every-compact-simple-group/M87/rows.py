#!/usr/bin/env python3
# rows.py -- M87's certified run: Theorem 8.7's row on a third road (exact rationals, outward rounding), the cell-certified sharp T6,
# and the block split of g27 -- uncorrected (the record's reading) and corrected (Lemma B's first-order block response) -- with
# directed-rounding Neumann enclosures. Usage: python rows.py geom.json > rows.<date>.txt
import sys, json, math, time
from fractions import Fraction as F
from ivr import I, F as FF, row, m_reg, m_bessel, Dabs, phi2, A_, B_, P_, PI, fmt_dn, fmt_up

T0 = time.time()
def say(*a): print(*a, flush=True)
def ok(c): return "MET" if c else "MISSED"
geom = json.load(open(sys.argv[1]))

# ------------------------------------------------------------------ 1. known answers (g24 record, Table 3, MG2)
say("M87-ROWS PREC=320 dyadic outward rounding; pi in", PI.s(25))
R = row(F("0.241")); t3 = R["alpha"].lo < F("0.9962975") and R["alpha"].hi > F("0.9962965")
say("KAT-TABLE3 beta=0.241 alpha", R["alpha"].s(12), "12Cdir", R["12Cdir"].s(7), "90Cmed", R["90Cmed"].s(7), "omega", R["omega"].s(7), "rho", R["rho"].s(7), "against 0.996297/0.363540/0.632756/0.009372/1.014124:", ok(t3))
for b, want in (("0.200", "0.669834"), ("0.220", "0.819554"), ("0.230", "0.901143"), ("0.240", "0.987407"), ("0.2415", "1.000760")):
    R = row(F(b)); w = F(want)
    say("KAT-TABLE3 beta=%s alpha %s against %s: %s" % (b, R["alpha"].s(9), want, ok(abs(F(R["alpha"].mid()) - w) <= F(5, 10 ** 7))))
R = row(F("0.2414"))
g24 = (F("0.999866075428161"), F("0.999866075428162"))
say("KAT-G24 PROVED ROW(0.2414)", R["alpha"].s(15), "against g24 [0.999866075428161, 0.999866075428162]:", ok(R["alpha"].lo >= g24[0] - F(1, 10 ** 15) and R["alpha"].hi <= g24[1] + F(1, 10 ** 15)))
say("   M5", R["M5"].s(15), "D5", R["D5"].s(15), "T6", R["T6"].s(15), "rho", R["rho"].s(14), "Cdir<=", fmt_up(R["Cdir"].hi, 16), "Cmed<=", fmt_up(R["Cmed"].hi, 16))
R2 = row(F("0.2415"))
say("KAT-G24 PROVED ROW(0.2415)", R2["alpha"].s(14), "against g24 [1.00075962398605, 1.00075962398606]:", ok(abs(R2["alpha"].lo - F("1.000759623986055")) < F(1, 10 ** 13)))
RS = row(F("0.2450"), sharp=True)
say("KAT-G24 SHARP beta=0.2450 ROW", RS["alpha"].s(12), "D5", RS["D5"].s(9), "T6", RS["T6"].s(9), "against 0.997770 / 0.026173 / 0.060470:",
    ok(abs(F(RS["alpha"].mid()) - F("0.997770")) < F(5, 10 ** 7) and abs(F(RS["D5"].mid()) - F("0.026173")) < F(5, 10 ** 7) and abs(F(RS["T6"].mid()) - F("0.060470")) < F(5, 10 ** 7)))
say("ROAD-CHECK m two roads (regular variables vs Bessel series) at r = 1.2, 1.4712, 2:",
    all(abs(m_reg(F(r)).mid() - m_bessel(F(r)).mid()) < 1e-30 for r in ("1.2", "1.4712", "2")) and "AGREE to 1e-30" or "DISAGREE")
m2 = m_reg(F(2))
say("LEMMA-D m(2)*2 =", (2 * m2).s(12), "< 1:", ok((2 * m2).hi < 1), " (so |D| increasing on [0, 2]; WORK.md 3.5)")

# ------------------------------------------------------------------ 2. the certified sup of the third cumulant (cells)
CACHE = {}
def ABP(z):
    if z not in CACHE: CACHE[z] = (A_(z), B_(z), P_(z))
    return CACHE[z]
def sqrt_up(x):  # upper bound of sqrt(x), x a nonnegative Fraction
    S = 1 << 200; n = (x.numerator * S * S) // x.denominator + 1; r = math.isqrt(n) + 1; return F(r, S)
def kstar_cell(r0, r1):
    z0 = r0 * r0 / 4; z1 = r1 * r1 / 4
    A0, B0, P0 = ABP(z0); A1, B1, P1 = ABP(z1)
    Alo, Ahi = A0.lo, A1.hi; Blo, Bhi = B0.lo, B1.hi; Plo, Phi = P0.lo, P1.hi
    a_lo = F(3) * r0 / 4 * Plo / (Bhi * Bhi); a_hi = F(3) * r1 / 4 * Phi / (Blo * Blo)
    f2_lo = Alo / (2 * Bhi) - z1 * Phi / (Blo * Blo); f2_hi = Ahi / (2 * Blo) - z0 * Plo / (Bhi * Bhi)
    assert f2_lo > 0
    b_lo = r0 * (Alo / Bhi) * f2_lo; b_hi = r1 * (Ahi / Blo) * f2_hi
    ab = max(abs(b_hi - a_lo), abs(b_lo - a_hi), abs(a_hi - b_lo), abs(a_lo - b_hi))   # max |a - b| over the box
    K_lo = 2 * a_lo - b_hi; K_hi = 2 * a_hi - b_lo
    top = b_lo >= F(5, 3) * a_hi
    if K_hi < a_lo / 3: return ab, top          # no interior critical point (needs K >= a/3)
    Kl = max(K_lo, a_lo / 3)
    if Kl <= 0: return max(ab, F(2, 3) * a_hi), top
    q = a_hi / (3 * Kl)
    inner = F(2, 3) * a_hi * (sqrt_up(q) if q < 1 else F(1))
    return max(ab, inner), top
RMAX = F(18, 10)
geo = []; rf = 1e-9  # geometric to 0.9, ratio 1.0201, points on the decimal grid 10^-12 (contiguous cells; the ratio is immaterial)
while rf < 0.9:
    p = F(round(rf * 10 ** 12), 10 ** 12)
    if not geo or p > geo[-1]: geo.append(p)
    rf *= 1.0201
uni = [F(9, 10) + F(k, 10000) for k in range(0, 9001)]  # uniform step 1e-4 on [0.9, 1.8]
pts = geo + uni
cells = []
for r0, r1 in zip(pts[:-1], pts[1:]):
    v, top = kstar_cell(r0, r1); cells.append((r0, r1, v, top))
say("T6-CELLS %d cells on [1e-9, 1.8] (geometric ratio 1.0201 to 0.9, then step 1e-4); the direction maximum at c = 1 certified on %d of %d cells (b >= 5a/3); [0, 1e-9] carries |kappa| <= r/16 + r/8 < 2e-10" % (len(cells), sum(1 for c in cells if c[3]), len(cells)))
def T6cell(beta):
    R6 = 6 * F(beta); best = F(2, 10 ** 10)
    assert R6 <= RMAX, "the T6 cells cover r <= 1.8 only"
    for r0, r1, v, top in cells:
        if r0 >= R6: break
        if v > best: best = v
    return I(best, best)
say("time %.1f s" % (time.time() - T0))

# ------------------------------------------------------------------ 3. the crossings of alpha on the grid beta = k/10^4
def alpha_proved(k): return row(F(k, 10 ** 4))["alpha"]
def alpha_sharp(k, cell=True):
    b = F(k, 10 ** 4)
    return row(b, sharp=True, T6=T6cell(b) if cell else None)["alpha"]
def cross(fn, lo, hi, target=F(1)):
    last_below = None; first_above = None
    for k in range(lo, hi + 1):
        a = fn(k)
        if a.hi < target: last_below = k
        elif a.lo > target and first_above is None: first_above = k; break
        elif not (a.hi < target) and not (a.lo > target): say("   REFUSED: k=%d straddles %s: %s" % (k, target, a.s(12))); break
    return last_below, first_above
lb, fa = cross(alpha_proved, 2400, 2430)
say("CROSS-ALPHA PROVED: certified alpha < 1 at beta = %s (hence on [0, %s], every term increasing in beta), > 1 at %s: beta* in [%s, %s)" % (F(lb, 10**4), F(lb, 10**4), F(fa, 10**4), float(F(lb, 10**4)), float(F(fa, 10**4))))
say("   alpha(%s) = %s ; alpha(%s) = %s" % (lb / 1e4, alpha_proved(lb).s(12), fa / 1e4, alpha_proved(fa).s(12)))
lbs, fas_ = cross(lambda k: alpha_sharp(k, cell=True), 2440, 2470)
say("CROSS-ALPHA SHARP (T6 = the certified cell sup over r <= 6 beta and all directions; D5 = |D(5 beta)| by Lemma D): last certified < 1 at %s" % (lbs / 1e4,))
a_lb = alpha_sharp(lbs, True); a_lbn = alpha_sharp(lbs + 1, False)
say("   alpha_sharp(%s) with the cell T6 %s = %s ; alpha_sharp(%s) with the POINTWISE T6 (a lower bound of the sup) = %s -> above 1: %s" %
    (lbs / 1e4, T6cell(F(lbs, 10**4)).s(10), a_lb.s(12), (lbs + 1) / 1e4, a_lbn.s(12), ok(a_lbn.lo > 1)))
say("   pointwise T6 at %s: %s (g24: 0.0604812424416606); cell sup: %s" % (lbs / 1e4, row(F(lbs, 10**4), sharp=True)["T6"].s(13), T6cell(F(lbs, 10**4)).s(13)))
say("time %.1f s" % (time.time() - T0))

# ------------------------------------------------------------------ 4. the block rows
SCL = 1 << 160
def toint_dn(x): return (x.numerator * SCL) // x.denominator
def toint_up(x): return -((-x.numerator * SCL) // x.denominator)
def matvec(Cint, x, up):
    out = []
    for Ci in Cint:
        s = 0
        for cij, xj in zip(Ci, x):
            if cij: s += cij * xj
        out.append(-((-s) // SCL) if up else s // SCL)
    return out
def neumann(Cint, rhs, up, cmax_up=None, K=400):
    # x = sum_n C^n rhs (C >= 0, rhs > 0, scaled integers). LOWER: the partial sums with rounding down (each <= the true sum).
    # UPPER: iterate with rounding up, inflate, and VERIFY the super-solution property y >= rhs + C y (matvec rounded up); for C >= 0
    # and rhs > 0 that property gives C y < y, hence rho(C) < 1 (Collatz-Wielandt) and y >= (I - C)^-1 rhs. No a-priori tail is used.
    x = list(rhs)
    for it in range(K):
        x = [a + b for a, b in zip(rhs, matvec(Cint, x, up))]
    if not up: return x
    for eta_exp in (60, 40, 25, 15, 8, 4):
        y = [v + v // (1 << eta_exp) + 1 for v in x]
        Cy = matvec(Cint, y, True)
        if all(yi >= ri + ci for yi, ri, ci in zip(y, rhs, Cy)): return y
    raise RuntimeError("super-solution not verified: the Neumann series may diverge (rho(C_BB) >= 1?)")
def block_rows(assign, Cd, Cm):
    # Cd, Cm: intervals of C_dir, C_med. Returns dict of enclosures per link of the block.
    blk = geom["G"][assign + "_block"]; links = blk["links"]; NI = blk["NI"]; NII = blk["NII"]; n = len(links)
    cls = geom["G"][assign]
    al = 12 * Cd + 90 * Cm
    Clo = [[toint_dn(NI[i][j] * Cd.lo + NII[i][j] * Cm.lo) for j in range(n)] for i in range(n)]
    Chi = [[toint_up(NI[i][j] * Cd.hi + NII[i][j] * Cm.hi) for j in range(n)] for i in range(n)]
    inrow_hi = max(sum(NI[i][j] * Cd.hi + NII[i][j] * Cm.hi for j in range(n)) for i in range(n))
    one = [SCL] * n
    s_lo = neumann(Clo, one, False); s_hi = neumann(Chi, one, True, inrow_hi)
    r_lo = [toint_dn((12 - cls[l]["n1in"]) * Cd.lo + (90 - cls[l]["n2in"]) * Cm.lo) for l in links]
    r_hi = [toint_up((12 - cls[l]["n1in"]) * Cd.hi + (90 - cls[l]["n2in"]) * Cm.hi) for l in links]
    t_lo = neumann(Clo, r_lo, False); t_hi = neumann(Chi, r_hi, True, inrow_hi)
    out = []
    for i, l in enumerate(links):
        s = I(F(s_lo[i], SCL), F(s_hi[i], SCL)); t = I(F(t_lo[i], SCL), F(t_hi[i], SCL)); rr = I(F(r_lo[i], SCL), F(r_hi[i], SCL))
        ident = 1 + (al - 1) * s
        out.append({"link": l, "tag": cls[l]["tag"], "r": rr, "s": s, "t": t, "ident": ident,
                    "agree": not (t.hi < ident.lo or t.lo > ident.hi)})
    return out, inrow_hi, al
def report_blocks(beta, sharp):
    b = F(beta)
    R = row(b, sharp=sharp, T6=T6cell(b) if sharp else None)
    Cd, Cm, al = R["Cdir"], R["Cmed"], R["alpha"]
    tag = "SHARP" if sharp else "PROVED"
    say("BLOCKS %s beta=%s  C_dir %s  C_med %s  alpha %s" % (tag, beta, Cd.s(10), Cm.s(10), al.s(10)))
    # the record's class-averaged reading (g27): fractions over the 24 classes of each tag
    for assign in ("plain", "base"):
        cls = geom["G"][assign]
        for tg in ("inter", "intra"):
            ks = [k for k in cls if cls[k]["tag"] == tg]
            f1 = F(sum(cls[k]["n1in"] for k in ks), 12 * len(ks)); f2 = F(sum(cls[k]["n2in"] for k in ks), 90 * len(ks))
            red = 12 * (1 - f1) * Cd + 90 * (1 - f2) * Cm
            say("   g27-READING %s %s (class-averaged fractions %.3f, %.3f): %s" % (assign, tg, float(f1), float(f2), red.s(6)))
        worst = max(cls, key=lambda k: (12 - cls[k]["n1in"]) * Cd.hi + (90 - cls[k]["n2in"]) * Cm.hi)
        wr = (12 - cls[worst]["n1in"]) * Cd + (90 - cls[worst]["n2in"]) * Cm
        say("   UNCORRECTED %s: per-link WORST off-block row at link %s (in-block %d, %d): %s  [%s]" % (assign, worst, cls[worst]["n1in"], cls[worst]["n2in"], wr.s(6), "BELOW-1" if wr.hi < 1 else ("ABOVE-1" if wr.lo > 1 else "STRADDLES")))
        out, inrow, al2 = block_rows(assign, Cd, Cm)
        mx = max(o["t"].hi for o in out); mn = min(o["t"].lo for o in out)
        avg_hi = sum(o["t"].hi for o in out) / len(out); avg_lo = sum(o["t"].lo for o in out) / len(out)
        joint_lo = sum(o["t"].lo for o in out)
        agree = all(o["agree"] for o in out)
        smax = max(o["s"].hi for o in out); smin = min(o["s"].lo for o in out)
        say("   CORRECTED %s (Lemma B, first order, block of %d links; max in-block row %.6f): block rows (I - C_BB)^-1 C_BO 1 in [%s, %s] (min lo, max hi); block average in [%s, %s]; identity 1 + (alpha - 1)s agrees on every link: %s; s in [%s, %s]; joint-TV block row >= %s" %
            (assign, len(out), float(inrow), fmt_dn(mn, 8), fmt_up(mx, 8), fmt_dn(avg_lo, 8), fmt_up(avg_hi, 8), "yes" if agree else "NO", fmt_dn(smin, 6), fmt_up(smax, 6), fmt_dn(joint_lo, 4)))
        if assign == "plain":
            say("      (plain: the %d inter links are singleton blocks; their corrected row is alpha = %s)" % (sum(1 for k in cls if cls[k]["tag"] == "inter"), al.s(8)))
        # S-7: what the averaged composition must buy, on the binding link and on the block average
        if al.lo > 1:
            need = []
            for o in out:
                e1 = o["t"] - o["r"]          # first-order indirect (in-block) part
                if o["r"].lo >= 1: need.append((None, o["link"]))
                else: need.append(((e1.lo) / (1 - o["r"].lo), o["link"]))   # factor by which e must shrink (lower bound)
            imposs = [l for f, l in need if f is None]
            if imposs:
                say("      S-7 max form: IMPOSSIBLE even with zero in-block propagation -- %d links have direct off-block row >= 1 (e.g. %s)" % (len(imposs), imposs[0]))
            else:
                fmax = max(f for f, l in need)
                say("      S-7 max form: the exact in-block indirect response must be below first order by a factor >= %.3f on the binding link" % float(fmax))
            e_sum = sum(o["t"].lo - o["r"].hi for o in out); slack = sum(1 - o["r"].lo for o in out)
            if slack > 0:
                say("      S-7 Dobrushin-Shlosman average form: the summed indirect response must shrink by a factor >= %.3f (first-order indirect sum >= %.4f against the slack %.4f)" % (float(e_sum / slack), float(e_sum), float(slack)))
            else:
                say("      S-7 average form: IMPOSSIBLE even with zero in-block propagation (summed direct off-block row >= |B|)")
for beta, sharp in (("0.2414", False), ("0.2415", False), ("0.2452", True), ("0.2453", True), ("0.26", False), ("0.28", False), ("0.30", False), ("0.26", True), ("0.28", True)):
    report_blocks(beta, sharp)
say("time %.1f s" % (time.time() - T0))

# ------------------------------------------------------------------ 5. crossings of the uncorrected readings and of the 17/16 ceiling
def worst_unc(assign, k, sharp):
    b = F(k, 10 ** 4); R = row(b, sharp=sharp, T6=T6cell(b) if sharp else None); Cd, Cm = R["Cdir"], R["Cmed"]; cls = geom["G"][assign]
    return max(((12 - cls[x]["n1in"]) * Cd + (90 - cls[x]["n2in"]) * Cm for x in cls), key=lambda v: v.hi)
def classavg(k, sharp):
    b = F(k, 10 ** 4); R = row(b, sharp=sharp, T6=T6cell(b) if sharp else None); Cd, Cm = R["Cdir"], R["Cmed"]
    return 7 * Cd + 68 * Cm   # base, inter: fractions 5/12 and 22/90 exactly (60/24 = 5 per link; 528/24 = 22)
for sharp in (False, True):
    tg = "SHARP" if sharp else "PROVED"
    lb, fa = cross(lambda k: worst_unc("base", k, sharp), 2600, 2990)
    say("CROSS-UNCORRECTED %s base per-link worst (8 C_dir + 73 C_med): below 1 at %s, above at %s" % (tg, lb / 1e4, fa / 1e4))
    lb, fa = cross(lambda k: classavg(k, sharp), 2700, 2995)
    say("CROSS-READING %s base inter class average (7 C_dir + 68 C_med, the record's 0.959981 at 0.28): below 1 at %s, above at %s" % (tg, lb / 1e4, fa / 1e4))
    lb, fa = cross(lambda k: (alpha_sharp(k, True) if sharp else alpha_proved(k)), 2420, 2600, target=F(17, 16))
    say("CROSS-17/16 %s (the second-decimation ceiling of WORK.md 5.2): alpha < 17/16 at %s, > 17/16 at %s" % (tg, lb / 1e4, fa / 1e4))
say("M87-ROWS DONE (%.1f s)" % (time.time() - T0))
