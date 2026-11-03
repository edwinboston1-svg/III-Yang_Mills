"""UV1 item 2 (H5): THE FREE-ENERGY GAP C, CERTIFIED ON A GRID, AND THE LARGE-FIELD FLOORS IT GIVES.

C(beta) = (ln Z1 - ln Z0)/N <= U1(beta) - L0(beta)   (WORK.md section 3)
 U1: Theorem U (design B': time pairs of singles + four-link plaquette groups, Lemma AF's aligned-field character sums);
 L0: Lemma L (M8b's product trial, t optimised per cell in floating point, evaluated in intervals: any t is valid).
On a cell [b_i, b_{i+1}]: U1 is nonincreasing in beta (every group integral is int e^{-beta*(nonneg)}), L0_t is nonincreasing in beta
(fixed t), so C <= Cbar_i := U1(b_i).upper - L0_t(b_{i+1}).lower.  Beyond the grid: Lemma T, C <= 4.5 ln 6.
Bessel functions: I_{N+1}, I_N by their positive series with a geometric tail bound, then the backward recurrence
I_{n-1} = I_{n+1} + (2n/x) I_n (all terms positive: interval-stable).  Tails of the character sums by the exact identity
sum_d d a_d(x) = e^x and the monotonicity of a_d(x)/d = 2 I_d(x)/x in d.
Run: python -u -E -P code/uv1_c.py > rec/c.<date>.txt
"""
import math
import sys
from mpmath import iv, mp, mpf

iv.dps = 30
mp.dps = 30
ONE = iv.mpf(1)


def bessel_series(n, x):
    """I_n(x) for x > 0 (interval), positive series + geometric tail."""
    half = x / 2
    h2 = half * half
    term = ONE
    for k in range(1, n + 1):
        term = term * half / k
    s = term
    k = 0
    while True:
        k += 1
        term = term * h2 / (k * (k + n))
        s = s + term
        q = h2 / ((k + 1) * (k + 1 + n))
        if q.b < 0.5 and term.b < s.a * mpf(10) ** (-(iv.dps + 4)):
            tail = term * q / (1 - q)
            return s + iv.mpf([0, tail.b])


def bessels(x, N):
    """[I_0(x), ..., I_{N+1}(x)] as intervals."""
    I = [None] * (N + 2)
    I[N + 1] = bessel_series(N + 1, x)
    I[N] = bessel_series(N, x)
    for n in range(N, 0, -1):
        I[n - 1] = I[n + 1] + (2 * n / x) * I[n]
    return I


def a_list(x, I, D):
    """a_d(x) = 2 d I_d(x)/x for d = 1..D (index d)."""
    return [None] + [2 * d * I[d] / x for d in range(1, D + 1)]


def logc(x, I=None):
    if I is None:
        I = bessels(x, 3)
    return iv.log(2 * iv.exp(-x) * I[1] / x)


def D_of(beta):
    return int(16 + 8 * math.sqrt(float(beta)))


class BetaData:
    """Bessel data at x = beta and x = 2 beta."""

    def __init__(self, beta):
        self.beta = beta
        self.D = D_of(beta)
        self.I1 = bessels(beta, self.D + 1)
        self.I2 = bessels(2 * beta, self.D + 1)
        self.a1 = a_list(beta, self.I1, self.D)
        self.a2 = a_list(2 * beta, self.I2, self.D)
        # complements sum_{d<=D} d a_d(x) and the tail factor 2 I_{D+1}(x)/x
        self.S1 = sum((d * self.a1[d] for d in range(1, self.D + 1)), iv.mpf(0))
        self.S2 = sum((d * self.a2[d] for d in range(1, self.D + 1)), iv.mpf(0))
        self.t1 = 2 * self.I1[self.D + 1] / beta
        self.t2 = 2 * self.I2[self.D + 1] / (2 * beta)

    def a(self, k, d):
        return self.a1[d] if k == 1 else self.a2[d]

    def tailf(self, k):
        return self.t1 if k == 1 else self.t2

    def comp(self, k):
        x = self.beta * k
        return iv.exp(x) - (self.S1 if k == 1 else self.S2)


def logG4(bd, ks):
    """ln G4(k; beta) = -beta(1 + sum k) + ln sum_d a_d(beta) prod a_d(k_i beta)/d^3 (Lemma AF (G4))."""
    beta = bd.beta
    s = iv.mpf(0)
    for d in range(1, bd.D + 1):
        t = bd.a1[d]
        for k in ks:
            t = t * bd.a(k, d)
        s = s + t / d ** 3
    # tail: term_d = (a_d(beta)/d) prod_{i<4}(a_d(k_i beta)/d) * d a_d(k_4 beta), with k_4 the smallest k
    kk = sorted(ks)
    k4 = kk[0]
    tail = bd.t1
    for k in kk[1:]:
        tail = tail * bd.tailf(k)
    tail = tail * bd.comp(k4)
    s = s + iv.mpf([0, tail.b])
    return -beta * (1 + sum(ks)) + iv.log(s)


def logP2(bd, k, kp):
    """ln P2 = -beta(1 + k + k') + ln sum_d a_d(k beta) a_d(k' beta) a_d(beta)/d (Lemma AF (P2)); k' >= 1."""
    beta = bd.beta
    s = iv.mpf(0)
    for d in range(1, bd.D + 1):
        s = s + bd.a(k, d) * bd.a(kp, d) * bd.a1[d] / d
    kk = sorted([k, kp])
    tail = bd.t1 * bd.tailf(kk[1]) * bd.comp(kk[0])
    s = s + iv.mpf([0, tail.b])
    return -beta * (1 + k + kp) + iv.log(s)


def U1_designs(beta):
    bd = BetaData(beta)
    lc1 = iv.log(2 * iv.exp(-beta) * bd.I1[1] / beta)
    lc2 = iv.log(2 * iv.exp(-2 * beta) * bd.I2[1] / (2 * beta))
    m8b = 3 * lc1
    seqA = 2 * lc2 + lc1
    Bp = (logP2(bd, 2, 1) / 2 + logG4(bd, (2, 2, 2, 1)) / 8 + logG4(bd, (2, 1, 1, 1)) / 8 + logG4(bd, (1, 1, 1, 1)) / 4)
    return m8b, seqA, Bp, bd, lc1, lc2


def L0t(beta, t):
    I = bessels(t, 3)
    c = 2 * iv.exp(-t) * I[1] / t
    r = I[2] / I[1]
    return 3 * iv.log(c) + 3 * t * (1 - r) - 3 * beta * (2 - r ** 2 - r ** 4)


def L0_float(beta, t):
    t = mpf(t)
    I1 = mp.besseli(1, t)
    I2 = mp.besseli(2, t)
    c = 2 * mp.exp(-t) * I1 / t
    r = I2 / I1
    return 3 * mp.log(c) + 3 * t * (1 - r) - 3 * beta * (2 - r ** 2 - r ** 4)


def topt(beta):
    lo, hi = 2.0 * beta, 10.0 * beta
    g = (math.sqrt(5) - 1) / 2
    x1 = hi - g * (hi - lo)
    x2 = lo + g * (hi - lo)
    f1 = L0_float(beta, x1)
    f2 = L0_float(beta, x2)
    for _ in range(60):
        if f1 < f2:
            lo, x1, f1 = x1, x2, f2
            x2 = lo + g * (hi - lo)
            f2 = L0_float(beta, x2)
        else:
            hi, x2, f2 = x2, x1, f1
            x1 = hi - g * (hi - lo)
            f1 = L0_float(beta, x1)
    return mpf((lo + hi) / 2)


def nstr(x, n=8):
    try:
        return mp.nstr(mpf(x), n)
    except Exception:
        return mp.nstr(mpf(x.a), n) + "~" + mp.nstr(mpf(x.b), n)


if __name__ == "__main__":
    # ---- 0. instrument checks ----
    print("=== 0. INSTRUMENT CHECKS ===")
    for x in (mpf('0.7'), mpf(5), mpf(37.5), mpf(400)):
        I = bessels(iv.mpf(x), 12)
        worst = max(abs((mpf(I[n].a) + mpf(I[n].b)) / 2 / mp.besseli(n, x) - 1) for n in range(0, 13))
        print("  x = %s: max rel. diff of interval I_0..I_12 midpoints vs mpmath.besseli = %s; width of I_12: %s" % (
            nstr(x, 4), nstr(worst, 3), nstr((mpf(I[12].b) - mpf(I[12].a)) / mpf(I[12].a), 3)))
    # identity sum_d d a_d(x) = e^x
    x = iv.mpf(20)
    I = bessels(x, 60)
    ssum = sum((d * 2 * d * I[d] / x for d in range(1, 61)), iv.mpf(0))
    print("  identity: sum_{d<=60} d a_d(20) / e^20 = %s (must be 1 - tail)" % nstr((ssum / iv.exp(x)).a, 20))
    # Gaussian kill-switch: ln G4 - sum ln c(k_i beta) -> -1.5 ln kappa ; ln P2 - ln c(2b) - ln c(b) -> -1.5 ln 2.5
    print("=== 0b. GAUSSIAN KILL-SWITCH (beta -> infinity) ===")
    for beta in (iv.mpf(50), iv.mpf(200), iv.mpf(800)):
        bd = BetaData(beta)
        lc = {1: logc(beta), 2: logc(2 * beta)}
        for ks, kap in (((1, 1, 1, 1), 5), ((2, 1, 1, 1), 4.5), ((2, 2, 2, 1), 3.5)):
            v = logG4(bd, ks) - sum(lc[k] for k in ks)
            print("  beta = %s  G4%s: ln G4 - sum ln c = %s ; Gaussian -1.5 ln kappa = %s" % (
                nstr(beta.a, 4), ks, nstr(v.a, 10), nstr(-1.5 * mp.log(kap), 10)))
        v = logP2(bd, 2, 1) - lc[2] - lc[1]
        print("  beta = %s  P2(2,1): ln P2 - ln c(2b) - ln c(b) = %s ; Gaussian -1.5 ln 2.5 = %s" % (
            nstr(beta.a, 4), nstr(v.a, 10), nstr(-1.5 * mp.log(2.5), 10)))

    # ---- 1. the certified grid ----
    print("=== 1. CERTIFIED CELLS: Cbar = U1(b_i) - L0_t(b_{i+1}) ===")
    grid = [mpf(2) + mpf(k) / 4 for k in range(0, 233)]          # 2 .. 60 step 1/4
    grid += [mpf(61) + k for k in range(0, 140)]                  # 61 .. 200 step 1
    cells = []
    sys.stdout.flush()
    U_cache = {}
    for i in range(len(grid) - 1):
        bi, bj = grid[i], grid[i + 1]
        if bi not in U_cache:
            U_cache[bi] = U1_designs(iv.mpf(bi))
        m8b, seqA, Bp, bd, lc1, lc2 = U_cache[bi]
        t = topt((bi + bj) / 2)
        L = L0t(iv.mpf(bj), iv.mpf(t))
        Cb = mpf(Bp.b) - mpf(L.a)
        Cm = mpf(m8b.b) - mpf(L.a)
        Ca = mpf(seqA.b) - mpf(L.a)
        cells.append((bi, bj, Cb, Cm, Ca))
        if i % 10 == 0 or bi in (mpf(5), mpf(10), mpf(15), mpf(20), mpf(30), mpf(40), mpf(60), mpf(100), mpf(150), mpf(199)):
            print("  [%6s,%6s]: Cbar(B') = %s   (M8b's U1: %s ; sequential A: %s)   t = %s  D = %d" % (
                nstr(bi, 5), nstr(bj, 5), nstr(Cb, 7), nstr(Cm, 7), nstr(Ca, 7), nstr(t, 6), bd.D))
            sys.stdout.flush()
    print("  max Cbar(B') over the grid = %s ; at beta = 200: %s" % (nstr(max(c[2] for c in cells), 8), nstr(cells[-1][2], 8)))
    print("  Lemma T beyond the grid: C <= 4.5 ln 6 = %s" % nstr(4.5 * mp.log(6), 10))

    # ---- 2. floors ----
    print("=== 2. FLOORS beta_LF(a): least grid point from which the activity bound is <= z* on every cell (and beyond, by Lemma T) ===")
    zc20 = iv.mpf(19) ** 19 / iv.mpf(20) ** 20
    zperc = 1 / (19 * iv.e)
    zKP = iv.mpf('0.006488429773')
    PR = (('z_perc', zperc), ('Shearer', zc20), ('KP', zKP))
    CT = 4.5 * mp.log(6)

    def floor(s, which, form, mult=1):
        res = []
        for name, z in PR:
            target = mult * mpf(iv.log(1 / z).b)
            ok = []
            for (bi, bj, Cb, Cm, Ca) in cells:
                C = {'Bp': Cb, 'm8b': Cm}[which]
                if form == 'lin':
                    ok.append(bi * s - C >= target)
                else:   # M8b's sqrt form
                    v = mp.sqrt(bi * s) - mp.sqrt(C)
                    ok.append(v > 0 and v * v >= target)
            tail_ok = (grid[-1] * s - CT >= target) if form == 'lin' else ((mp.sqrt(grid[-1] * s) - mp.sqrt(CT)) ** 2 >= target)
            f = None
            if tail_ok:
                for i in range(len(cells) - 1, -1, -1):
                    if ok[i]:
                        f = cells[i][0]
                    else:
                        break
            res.append(f)
        return res

    def fmt(v):
        return ("%.2f" % float(v)) if v is not None else ">200"

    print("  a (rad) | s(a)     | M8b sqrt-form, M8b C | linear form, M8b C | linear form, C(B')   [z_perc / Shearer / KP]")
    for a in ('1.0', '1.08', '1.2', '1.25', '1.4', '1.5707963267948966', '2.0', '2.4', '3.141592653589793'):
        s = 1 - mp.cos(mpf(a))
        r1 = floor(s, 'm8b', 'sqrt')
        r2 = floor(s, 'm8b', 'lin')
        r3 = floor(s, 'Bp', 'lin')
        print("  %7s | %8s | %s | %s | %s" % (a[:7], nstr(s, 6), " / ".join(fmt(v) for v in r1), " / ".join(fmt(v) for v in r2),
                                               " / ".join(fmt(v) for v in r3)))
    print("  MIXED ORIENTATIONS, global Hoelder form (activity e^{(-beta s + C)/6} per plaquette), C(B'), linear:")
    for a in ('1.2', '1.5707963267948966', '2.0', '3.141592653589793'):
        s = 1 - mp.cos(mpf(a))
        r = floor(s, 'Bp', 'lin', mult=6)
        print("  %7s | %8s | %s" % (a[:7], nstr(s, 6), " / ".join(fmt(v) for v in r)))
    # the dense-cell constant -L0/6
    print("  DENSE CELLS: per-plaquette constant -L0(beta)/6 (all 24 faces of every cell in P):")
    for b in (5, 10, 15, 20, 30, 60):
        t = topt(mpf(b))
        L = L0t(iv.mpf(b), iv.mpf(t))
        print("    beta = %d: -L0/6 <= %s" % (b, nstr(-mpf(L.a) / 6, 7)))
