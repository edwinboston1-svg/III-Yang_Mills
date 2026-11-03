# cc_core.py -- CC, 2026-11-02. The covariance composition's coefficients (WORK.md §4.2, Lemma K) and a certified solver.
# Exact rationals with outward rounding (ivr.py, M87's, byte-identical copy); matrices as integers scaled by 2^SCB with directed rounding;
# every solution enclosed by a VERIFIED super-solution (upper) and sub-solution (lower) -- for G >= 0 with rho(G) < 1, (I - G)y >= b gives
# y >= (I - G)^-1 b and (I - G)y <= b gives y <= (I - G)^-1 b; rho(G_hi) < 1 is itself certified by a strictly positive super-solution for a
# strictly positive right side (Collatz-Wielandt). Floating point only PROPOSES candidates; no float enters an enclosure.
import math
from fractions import Fraction as F
import numpy as np
from ivr import I, imin, m_reg, Dabs, phi3abs, A_, B_, P_, PI, exp_, fmt_dn, fmt_up

SCB = 160
SCL = 1 << SCB
def dn(x): return (x.numerator * SCL) // x.denominator
def up(x): return -((-x.numerator * SCL) // x.denominator)

# ------------------------------------------------------------------ the certified sup of the third cumulant (M87 rows.py, ported verbatim)
_CACHE = {}
def _ABP(z):
    if z not in _CACHE: _CACHE[z] = (A_(z), B_(z), P_(z))
    return _CACHE[z]
def _sqrt_up(x):
    S = 1 << 200; n = (x.numerator * S * S) // x.denominator + 1; r = math.isqrt(n) + 1; return F(r, S)
def _kstar_cell(r0, r1):
    z0 = r0 * r0 / 4; z1 = r1 * r1 / 4
    A0, B0, P0 = _ABP(z0); A1, B1, P1 = _ABP(z1)
    Alo, Ahi = A0.lo, A1.hi; Blo, Bhi = B0.lo, B1.hi; Plo, Phi = P0.lo, P1.hi
    a_lo = F(3) * r0 / 4 * Plo / (Bhi * Bhi); a_hi = F(3) * r1 / 4 * Phi / (Blo * Blo)
    f2_lo = Alo / (2 * Bhi) - z1 * Phi / (Blo * Blo); f2_hi = Ahi / (2 * Blo) - z0 * Plo / (Bhi * Bhi)
    assert f2_lo > 0
    b_lo = r0 * (Alo / Bhi) * f2_lo; b_hi = r1 * (Ahi / Blo) * f2_hi
    ab = max(abs(b_hi - a_lo), abs(b_lo - a_hi), abs(a_hi - b_lo), abs(a_lo - b_hi))
    K_lo = 2 * a_lo - b_hi; K_hi = 2 * a_hi - b_lo
    top = b_lo >= F(5, 3) * a_hi
    if K_hi < a_lo / 3: return ab, top
    Kl = max(K_lo, a_lo / 3)
    if Kl <= 0: return max(ab, F(2, 3) * a_hi), top
    q = a_hi / (3 * Kl)
    inner = F(2, 3) * a_hi * (_sqrt_up(q) if q < 1 else F(1))
    return max(ab, inner), top
_CELLS = None
def _cells():
    global _CELLS
    if _CELLS is None:
        geo = []; rf = 1e-9
        while rf < 0.9:
            p = F(round(rf * 10 ** 12), 10 ** 12)
            if not geo or p > geo[-1]: geo.append(p)
            rf *= 1.0201
        uni = [F(9, 10) + F(k, 10000) for k in range(0, 9001)]
        pts = geo + uni
        _CELLS = [(r0, r1) + _kstar_cell(r0, r1) for r0, r1 in zip(pts[:-1], pts[1:])]
    return _CELLS
def T6cell(R):   # certified sup over r <= R (R <= 1.8) and all directions of the third cumulant (M87 S-3)
    best = F(2, 10 ** 10)
    assert R <= F(18, 10)
    for r0, r1, v, top in _cells():
        if r0 >= R: break
        if v > best: best = v
    return I(best, best)

# ------------------------------------------------------------------ the constants (THE GROUND (8.11), (8.12); WORK.md §1, §4.2)
C2HAAR = 3 * math.sqrt(3) / (16 * math.pi)     # READING only (S-11): E[(X^2 - 1/4)^+] for a coordinate of the uniform point of S^3
def consts(beta, sharp, pointwise_T6=False):
    b = I(F(beta)); bf = F(beta)
    M5 = m_reg(5 * bf)
    if sharp:
        D5 = Dabs(5 * bf)
        T6 = phi3abs(6 * bf) if pointwise_T6 else T6cell(6 * bf)
    else:
        D5 = M5 * M5 / 3; T6 = m_reg(6 * bf) / 2
    om = 3 * b * b * D5 + 2 * b * b * b * T6
    eom = exp_(om); eomh = exp_(om * F(1, 2))
    rho = (3 * eom - 1) / 2
    rate = rho * 2 / (3 * PI)                       # TV per unit shift of the vMF parameter (the MAD lemma with its tilt factor)
    cov = eom / 4                                   # mean shift per unit shift of the parameter (Lemma 8.6(i) with the tilt, F-b)
    CNd = (b * b * D5 + F(2, 3) * b * b * b * T6) / 4
    CNm = (imin(b * b * D5, 2 * b * b * b * T6) + F(2, 3) * b * b * b * T6) / 4
    lI = b * M5; lII = b * b / 4; eII = b * b * b * T6 / 2
    CLd = 2 * rate * lI; CLm = 2 * rate * lII       # = rho(4b/(3pi))m(5b) and rho b^2/(3pi): THE GROUND's linear parts, identically
    Cd = CLd + CNd; Cm = CLm + CNm
    alpha = 12 * Cd + 90 * Cm
    r0 = 6 * bf * M5.hi                             # the conditional law's radius bound 6 beta m(5 beta) (rounded up)
    return dict(beta=bf, sharp=sharp, M5=M5, D5=D5, T6=T6, om=om, eom=eom, eomh=eomh, rho=rho, rate=rate, cov=cov, CNd=CNd, CNm=CNm,
                lI=lI, lII=lII, eII=eII, CLd=CLd, CLm=CLm, Cd=Cd, Cm=Cm, alpha=alpha, r0=r0)

def remainder_set(c, setting):
    # R0: the IDEAL degree-one value (every remainder 0; the tilt's own mean shift kept -- it is not a remainder)
    # R1: PROVED remainders (WORK.md §4.2: c2 = e^w/4, T~ = e^w/2, the TYPE II remainder at T6, the tilt-gradient cross term)
    # R2: READING -- remainders at their Haar-point / sharp values (c2 = e^w * 3 sqrt3/(16 pi), T~ = e^w |phi'''(r0)|, TYPE II at |phi'''(5b)|)
    if setting == "R0": return dict(c2=I(0), Tt=I(0), e=I(0), cross=0)
    if setting == "R1": return dict(c2=c["cov"], Tt=c["eom"] / 2, e=c["eII"], cross=1)
    if setting == "R2":
        bf = c["beta"]
        T5s = phi3abs(5 * bf)
        return dict(c2=c["eom"] * F(C2HAAR), Tt=c["eom"] * phi3abs(c["r0"]), e=I(bf * bf * bf) * T5s / 2, cross=1)
    if setting == "R3":
        # THE CLASS FLOOR (READING): what any sup-over-configurations degree-one scheme must pay at the Haar point, which is attainable
        # (WORK.md §7.4): the TV-channel remainder's true oscillation (l^2/2) sup_{e,f} E[(X_e^2 - X_f^2)^+] = (l^2/2)(1/(2 pi)), i.e. an
        # effective c2 = 1/(4 pi); the mean channel's curvature (an odd moment) 0; the TYPE II remainder (grad^3 phi(0) = 0) 0; no cross term.
        return dict(c2=I(F(1, 4)) / PI, Tt=I(0), e=I(0), cross=0)
    raise ValueError(setting)

def pair_coef(c, rs, nI, nII):
    # Lemma K for a neighbour z in nI TYPE I and nII TYPE II positions relative to x (WORK.md §4.2)
    l = nI * c["lI"] + nII * c["lII"]; e = nII * rs["e"]; Cn = nI * c["CNd"] + nII * c["CNm"]; lp = l + e
    cTM = c["rate"] * l
    cMM = c["cov"] * l
    if rs["cross"]:
        cTT = Cn * (1 + 2 * c["eomh"] * lp) + rs["c2"] * l * l + c["rate"] * 2 * e
        cMT = c["eomh"] * Cn + 2 * c["eom"] * Cn * lp + rs["Tt"] * l * l + c["eom"] / 2 * e
    else:
        cTT = Cn + rs["c2"] * l * l; cMT = c["eomh"] * Cn + rs["Tt"] * l * l
    return cTM, cTT, cMM, cMT

def bound_inputs(c, oI, oII):
    # an outside link (or a class of them) in oI TYPE I and oII TYPE II positions relative to z: z's kernel moves by TV <= bT and its mean by <= bM
    bT = oI * c["Cd"] + oII * c["Cm"]
    bM = c["cov"] * (oI * 2 * c["lI"] + oII * 2 * c["lII"]) + c["eomh"] * (oI * c["CNd"] + oII * c["CNm"])
    return bT, bM

# ------------------------------------------------------------------ the certified linear solver
def matvec(Gint, y, rnd_up):
    out = []
    for row in Gint:
        s = 0
        for g, v in zip(row, y):
            if g: s += g * v
        out.append(-((-s) >> SCB) if rnd_up else s >> SCB)
    return out
class Solver:
    """Encloses y = (I - G)^-1 b for G = [Glo, Ghi] >= 0 (n x n Fractions/I), several right sides [blo, bhi] (lists of Fractions)."""
    def __init__(self, Glo, Ghi):
        self.n = len(Glo)
        self.Glo = [[dn(x) for x in r] for r in Glo]; self.Ghi = [[up(x) for x in r] for r in Ghi]
        self.Gm = np.array([[float((a + b) / 2) for a, b in zip(r1, r2)] for r1, r2 in zip(Glo, Ghi)])
        self.u = None
    def certify_positive(self, blo, bhi):
        # a strictly positive right side: verified super-solution u, (I - Ghi) u >= bhi > 0 => rho(Ghi) < 1
        assert all(x > 0 for x in blo)
        y0 = np.linalg.solve(np.eye(self.n) - self.Gm, np.array([float(x) for x in bhi]))
        assert (y0 > 0).all()
        bh = [up(x) for x in bhi]
        for k in (40, 30, 24, 18, 12):
            y = [up(F(float(v)) * (1 + F(1, 1 << k))) for v in y0]
            Gy = matvec(self.Ghi, y, True)
            if all(yi >= bi + gi for yi, bi, gi in zip(y, bh, Gy)):
                self.u = y; return True
        return False
    def solve(self, blo, bhi):
        assert self.u is not None, "certify_positive first"
        bl = np.array([float(x) for x in blo]); bh_ = np.array([float(x) for x in bhi])
        y0h = np.linalg.solve(np.eye(self.n) - self.Gm, bh_); y0l = np.linalg.solve(np.eye(self.n) - self.Gm, bl)
        bh = [up(x) for x in bhi]; bl_i = [dn(x) for x in blo]
        hi = lo = None
        for k, dl in ((40, 36), (32, 30), (24, 24), (16, 18)):
            y = [up(F(float(v)) * (1 + F(1, 1 << k))) + (uu >> dl) + 1 for v, uu in zip(y0h, self.u)]
            Gy = matvec(self.Ghi, y, True)
            if all(yi >= bi + gi for yi, bi, gi in zip(y, bh, Gy)): hi = y; break
        for k, dl in ((40, 36), (32, 30), (24, 24), (16, 18)):
            y = [dn(F(float(v)) * (1 - F(1, 1 << k))) - (uu >> dl) - 1 for v, uu in zip(y0l, self.u)]
            Gy = matvec(self.Glo, y, False)
            if all(yi <= bi + gi for yi, bi, gi in zip(y, bl_i, Gy)): lo = y; break
        if hi is None or lo is None: raise RuntimeError("enclosure not verified")
        return [F(v, SCL) for v in lo], [F(v, SCL) for v in hi]

# ------------------------------------------------------------------ the two-component block system and the first-order comparator
def block_system(geom, c, mode, rs=None):
    """mode 'two': the degree-one recursion (M_x, T_x) on the 48 in-block links (WORK.md §4.3);
       mode 'first': THE SAME CODE with the M-channel replaced by 2T and every remainder 0 -> T = r + Cbar_BB T (tooth i)."""
    n = 48
    if mode == "two": N = 2 * n
    else: N = n
    Glo = [[F(0)] * N for _ in range(N)]; Ghi = [[F(0)] * N for _ in range(N)]
    for x in range(n):
        for zs, (nI, nII) in geom["inb"][x].items():
            z = int(zs)
            if mode == "two":
                cTM, cTT, cMM, cMT = pair_coef(c, rs, nI, nII)
                for (i, j, v) in ((x, z, cMM), (x, n + z, cMT), (n + x, z, cTM), (n + x, n + z, cTT)):
                    Glo[i][j] = v.lo; Ghi[i][j] = v.hi
            else:
                cTM, cTT, cMM, cMT = pair_coef(c, remainder_set(c, "R0"), nI, nII)
                v = 2 * cTM + cTT                      # = nI Cdir + nII Cmed exactly (the accounting check of §4.2)
                Glo[x][z] = v.lo; Ghi[x][z] = v.hi
    # right sides: per class j and the total
    rhs = {}
    tot_lo = [F(0)] * N; tot_hi = [F(0)] * N
    for j in range(n):
        blo = [F(0)] * N; bhi = [F(0)] * N
        for x in range(n):
            o = geom["out"][x].get(str(j))
            if not o: continue
            bT, bM = bound_inputs(c, o[0], o[1])
            if mode == "two":
                blo[x] = bM.lo; bhi[x] = bM.hi; blo[n + x] = bT.lo; bhi[n + x] = bT.hi
            else:
                blo[x] = bT.lo; bhi[x] = bT.hi
        rhs[j] = (blo, bhi)
        tot_lo = [a + b for a, b in zip(tot_lo, blo)]; tot_hi = [a + b for a, b in zip(tot_hi, bhi)]
    return Glo, Ghi, rhs, (tot_lo, tot_hi)

def run_block(geom, c, mode, rs=None, per_class=True):
    Glo, Ghi, rhs, (tl, th) = block_system(geom, c, mode, rs)
    S = Solver(Glo, Ghi)
    if not S.certify_positive(tl, th): raise RuntimeError("rho(G) < 1 not certified")
    n = 48; off = n if mode == "two" else 0
    ylo, yhi = S.solve(tl, th)
    T = [(ylo[off + x], yhi[off + x]) for x in range(n)]
    r = [(tl[off + x], th[off + x]) for x in range(n)]
    Mt = None
    if per_class:
        Mt = [[None] * n for _ in range(n)]
        for j in range(n):
            a, b = S.solve(*rhs[j])
            for x in range(n): Mt[x][j] = (a[off + x], b[off + x])
    inrow_hi = max(sum(Ghi[off + x][off + z] for z in range(n)) for x in range(n))
    return dict(T=T, r=r, Mt=Mt, inrow_TT_hi=inrow_hi, Glo=Glo, Ghi=Ghi)

def summarize(res):
    T = res["T"]; r = res["r"]; n = len(T)
    e_lo = sum(t[0] - q[1] for t, q in zip(T, r)); e_hi = sum(t[1] - q[0] for t, q in zip(T, r))
    sl_lo = sum(1 - q[1] for q in r); sl_hi = sum(1 - q[0] for q in r)
    avg = (sum(t[0] for t in T) / n, sum(t[1] for t in T) / n)
    return dict(e=(e_lo, e_hi), slack=(sl_lo, sl_hi), avg=avg, mn=min(t[0] for t in T), mx=max(t[1] for t in T))

def perron_cert(Mt):
    """Collatz-Wielandt both ways for the folded 48 x 48 matrix with entries [lo, hi]: returns (theta_lo, theta_hi, v) with
    theta_lo <= rho(M_lo) <= rho(M_true) <= rho(M_hi) <= theta_hi, v the (float-proposed, rational-verified) positive vector."""
    n = len(Mt)
    Mm = np.array([[float((a + b) / 2) for a, b in row] for row in Mt])
    w, V = np.linalg.eig(Mm)
    k = int(np.argmax(w.real)); v = np.abs(V[:, k].real); v = v / v.max()
    vq = [F(max(float(x), 1e-12)).limit_denominator(10 ** 15) for x in v]
    hi = max(sum(Mt[i][j][1] * vq[j] for j in range(n)) / vq[i] for i in range(n))
    lo = min(sum(Mt[i][j][0] * vq[j] for j in range(n)) / vq[i] for i in range(n))
    return lo, hi, vq, float(w.real[k])
