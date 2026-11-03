# ivr.py -- M87: exact rational interval arithmetic with outward rounding to a dyadic grid, and the constants of THE GROUND's Theorem 8.7.
# Every quantity is an interval [lo, hi] of Fractions; after each operation the endpoints are rounded OUTWARD to multiples of 2^-PREC
# (lo down, hi up), so every printed enclosure contains the true value. No floating point enters any enclosure.
from fractions import Fraction as F
from math import factorial
PREC = 320
SC = 1 << PREC

def _dn(x):  # round a Fraction down to the grid
    return F((x.numerator * SC) // x.denominator, SC)
def _up(x):
    return F(-((-x.numerator * SC) // x.denominator), SC)

class I:
    __slots__ = ("lo", "hi")
    def __init__(self, lo, hi=None):
        if hi is None: hi = lo
        lo = F(lo); hi = F(hi)
        if lo > hi: raise ValueError("empty interval %s > %s" % (lo, hi))
        self.lo = _dn(lo); self.hi = _up(hi)
    @staticmethod
    def c(x): return x if isinstance(x, I) else I(x)
    def __add__(s, o): o = I.c(o); return I(s.lo + o.lo, s.hi + o.hi)
    __radd__ = __add__
    def __sub__(s, o): o = I.c(o); return I(s.lo - o.hi, s.hi - o.lo)
    def __rsub__(s, o): return I.c(o) - s
    def __mul__(s, o):
        o = I.c(o); p = [s.lo * o.lo, s.lo * o.hi, s.hi * o.lo, s.hi * o.hi]; return I(min(p), max(p))
    __rmul__ = __mul__
    def __truediv__(s, o):
        o = I.c(o)
        if o.lo <= 0 <= o.hi: raise ZeroDivisionError("interval division by an interval containing 0")
        return s * I(1 / o.hi, 1 / o.lo)
    def __rtruediv__(s, o): return I.c(o) / s
    def __neg__(s): return I(-s.hi, -s.lo)
    def __lt__(s, o): o = I.c(o); return s.hi < o.lo      # CERTIFIED less-than
    def __gt__(s, o): o = I.c(o); return s.lo > o.hi
    def mid(s): return float((s.lo + s.hi) / 2)
    def w(s): return float(s.hi - s.lo)
    def s(s, n=15): return "[%s, %s]" % (fmt_dn(s.lo, n), fmt_up(s.hi, n))

def imin(a, b): return I(min(a.lo, b.lo), min(a.hi, b.hi))

def fmt_dn(x, n):  # decimal string of x rounded down to n digits after the point
    q = (x.numerator * 10 ** n) // x.denominator; sgn = "-" if q < 0 else ""; q = abs(q)
    return "%s%d.%0*d" % (sgn, q // 10 ** n, n, q % 10 ** n)
def fmt_up(x, n):
    q = -((-x.numerator * 10 ** n) // x.denominator); sgn = "-" if q < 0 else ""; q = abs(q)
    return "%s%d.%0*d" % (sgn, q // 10 ** n, n, q % 10 ** n)

EPS = F(1, 1 << (PREC + 20))

def series(term0, ratio, x):
    # sum_{k>=0} t_k with t_0 = term0 (Fraction > 0), t_{k+1} = t_k * ratio(k) * x, ratio(k) positive and DECREASING in k;
    # partial sum until the geometric tail bound is below EPS; returns I(S, S + tail)
    t = term0; S = F(0); k = 0
    while True:
        S += t
        t = t * ratio(k) * x
        q = ratio(k + 1) * x
        if q < 1:
            tail = t / (1 - q)
            if tail < EPS: return I(S, S + tail)
        k += 1
        if k > 100000: raise RuntimeError("series did not converge")

# ---- the regular variables of THE GROUND's Lemma 8.6 proof, z = r^2/4:
# A = sum z^k/(k!(k+2)!), B = sum z^k/(k!(k+1)!), P = A^2 - BC = sum c_k z^k, c_k = (4+2k)!/(k!(4+k)!(2+k)!(3+k)!)  (all positive)
def A_(z): return series(F(1, 2), lambda k: F(1, (k + 1) * (k + 3)), z)
def B_(z): return series(F(1, 1), lambda k: F(1, (k + 1) * (k + 2)), z)
def P_(z): return series(F(1, 12), lambda k: F((6 + 2 * k) * (5 + 2 * k), (k + 1) * (5 + k) * (3 + k) * (4 + k)), z)

# Bessel I_nu(x) for the m-road (a second road to m that shares no line with the regular variables)
def bessel(nu, x):
    h = F(x) / 2
    return series(h ** nu / factorial(nu), lambda k: F(1, (k + 1) * (k + 1 + nu)), h * h)

def m_bessel(r):
    r = F(r); return bessel(2, r) / bessel(1, r)
def m_reg(r):
    r = F(r); z = r * r / 4; return r * A_(z) / (2 * B_(z))

def Dabs(r):   # |D(r)| = z P / B^2   (THE GROUND (8.10): D = -z(A^2 - BC)/B^2)
    r = F(r); z = r * r / 4; B = B_(z); return z * P_(z) / (B * B)
def phi2(r):   # phi'' = m/r + D = A/(2B) - zP/B^2
    r = F(r); z = r * r / 4; A = A_(z); B = B_(z); return A / (2 * B) - z * P_(z) / (B * B)
def phi3abs(r):  # |phi'''| = 2 m phi'' - 3|D|/r  (phi''' = 3|D|/r - 2 m phi'' <= 0 here; the sign is checked by the caller)
    r = F(r); return 2 * m_reg(r) * phi2(r) - 3 * Dabs(r) / r

# ---- pi by Machin's formula, each arctan an alternating series bracketed by consecutive partial sums
def atan_inv(n, K):
    lo = F(0); hi = F(0); s = F(0)
    for k in range(K):
        s += F((-1) ** k, (2 * k + 1) * n ** (2 * k + 1))
        if k == K - 2: a = s
    b = s
    return I(min(a, b), max(a, b))
PI = 16 * atan_inv(5, 160) - 4 * atan_inv(239, 60)

def exp_(x):  # x an interval with 0 <= x.hi <= 1/2: Taylor with remainder (e^t <= 2 on [0, 1/2])
    assert 0 <= x.lo and x.hi <= F(1, 2)
    def tay(t, upper):
        s = F(0); term = F(1); k = 0
        while True:
            s += term; k += 1; term = term * t / k
            if term < EPS: break
        return s + (2 * term if upper else 0)
    return I(tay(x.lo, False), tay(x.hi, True))

def constants(beta, sharp):
    b = F(beta)
    M5 = m_reg(5 * b)
    if sharp:
        D5 = Dabs(5 * b)          # sup over r <= 5 beta by the monotonicity lemma of WORK.md section 3.4
        T6 = phi3abs(6 * b)       # pointwise; the certified sup over r <= 6 beta and directions is cell_T6 below
    else:
        D5 = M5 * M5 / 3
        T6 = m_reg(6 * b) / 2
    return M5, D5, T6

def row(beta, sharp=False, T6=None, D5=None, tilt=F(1, 4)):
    b = I(F(beta))
    M5, D5c, T6c = constants(beta, sharp)
    if T6 is None: T6 = T6c
    if D5 is None: D5 = D5c
    om = 3 * b * b * D5 + 2 * b * b * b * T6
    rho = (3 * exp_(om) - 1) / 2
    a1 = b * b * D5
    mn = imin(a1, 2 * b * b * b * T6)
    Cdir = rho * (4 * b / (3 * PI)) * M5 + tilt * (a1 + F(2, 3) * b * b * b * T6)
    Cmed = rho * b * b / (3 * PI) + tilt * (mn + F(2, 3) * b * b * b * T6)
    al = 12 * Cdir + 90 * Cmed
    return {"beta": F(beta), "M5": M5, "D5": D5, "T6": T6, "omega": om, "rho": rho, "Cdir": Cdir, "Cmed": Cmed, "alpha": al,
            "12Cdir": 12 * Cdir, "90Cmed": 90 * Cmed}

# ---- the certified sup of the largest third cumulant over r in [0, R] and all directions (cells with monotone series enclosures)
def kappa_star_cell(r0, r1):
    # on r in [r0, r1] (0 < r0 < r1): enclose a = 3|D|/r = (3r/4) P/B^2 and b = 2 m phi'' = r (A/B) phi'', phi'' = A/(2B) - zP/B^2,
    # using that A, B, P are increasing in z; return an upper bound of max_{c in [0,1]} |a c(2c^2 - 1) - b c^3|
    z0 = r0 * r0 / 4; z1 = r1 * r1 / 4
    A0, A1 = A_(z0), A_(z1); B0, B1 = B_(z0), B_(z1); P0, P1 = P_(z0), P_(z1)
    Alo, Ahi = A0.lo, A1.hi; Blo, Bhi = B0.lo, B1.hi; Plo, Phi = P0.lo, P1.hi
    a_lo = F(3) * r0 / 4 * Plo / (Bhi * Bhi); a_hi = F(3) * r1 / 4 * Phi / (Blo * Blo)
    f2_lo = Alo / (2 * Bhi) - z1 * Phi / (Blo * Blo); f2_hi = Ahi / (2 * Blo) - z0 * Plo / (Bhi * Bhi)
    if f2_lo <= 0: return None
    b_lo = r0 * (Alo / Bhi) * f2_lo; b_hi = r1 * (Ahi / Blo) * f2_hi
    if b_lo >= F(5, 3) * a_hi:     # the maximum over directions sits at c = 1 on the whole cell (WORK.md section 3.5)
        return b_hi - a_lo, True
    # otherwise a crude cover: |a c(2c^2-1) - b c^3| <= a + b
    return a_hi + b_hi, False

def cell_T6(R, n_geo=2000, rmin=F(1, 10 ** 9)):
    # cells: [0, rmin] handled by |kappa| <= a + b <= r (crude: a <= m^2/r <= r/16, b <= 2 m phi'' <= r/8), then a geometric grid to R
    best = rmin; alltop = True
    ratio = (F(R) / rmin) ** 1  # placeholder for type
    import math
    q = math.exp(math.log(float(F(R) / rmin)) / n_geo)
    pts = [rmin]
    for i in range(1, n_geo):
        pts.append(F(pts[-1] * F(q).limit_denominator(10 ** 12)))
    pts = [p for p in pts if p < F(R)] + [F(R)]
    for r0, r1 in zip(pts[:-1], pts[1:]):
        v, top = kappa_star_cell(r0, r1)
        alltop = alltop and top
        if v > best: best = v
    return best, alltop, len(pts) - 1
