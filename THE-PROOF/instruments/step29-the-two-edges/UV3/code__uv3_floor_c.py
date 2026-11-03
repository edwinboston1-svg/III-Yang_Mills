"""UV3 run c: (H) the projected rung of the multiscale R-operation; (S) M6d's B_LP point re-checked against the preparatory pinch.
Certified with mpmath.iv.  Definitions: WORK.md section 13 (stakes written before this file).
Run: python -E -P code/uv3_floor_c.py > rec/floor_run.2026-11-02c.txt
"""
import mpmath
from mpmath import iv, mpf

iv.dps = 30
mpmath.mp.dps = 30
D = 4
LN10 = iv.log(iv.mpf(10))
with mpmath.workdps(50):
    U3 = mpmath.sqrt(6) / (32 * mpmath.pi ** 3) * mpmath.gamma(mpf(1) / 24) * mpmath.gamma(mpf(5) / 24) * \
        mpmath.gamma(mpf(7) / 24) * mpmath.gamma(mpf(11) / 24)
G3 = iv.mpf([U3 / 6 - mpf("1e-28"), U3 / 6 + mpf("1e-28")])


def sgn(v):
    return 1 if v.a > 0 else (-1 if v.b < 0 else 0)


def root(f, lo, hi):
    flo = sgn(f(iv.mpf(lo)))
    assert flo * sgn(f(iv.mpf(hi))) == -1
    lo, hi = mpf(lo), mpf(hi)
    while hi - lo > mpf("1e-20"):
        mid = (lo + hi) / 2
        s = sgn(f(iv.mpf(mid)))
        if s == 0:
            break
        lo, hi = (mid, hi) if s == flo else (lo, mid)
    return iv.mpf([lo, hi])


def dec(x):
    v = x / LN10
    return f"[{float(v.a):.6f}, {float(v.b):.6f}]"


print("UV3 run c; d = 4; G3 =", float(G3.a))
for L, M in ((4, 244), (5, 245), (6, 247), (12, 261), (13, 262)):
    Mi = iv.mpf(M)
    for withX in (False, True):
        def f(X, withX=withX):
            COST = (X if withX else iv.mpf(1)) * Mi ** D
            PLP = iv.sqrt(2 * COST)
            Ppin = 4 * iv.sqrt(G3 * COST)
            P = Ppin if Ppin.a > PLP.b else PLP
            return -X / 2 + iv.log(Mi * P)
        r = root(f, 1, 1000)
        print(f"  H{'(X in cost)' if withX else '(GR)       '} L = {L:2d}, M = {M}: X in [{float(r.a):.8f}, {float(r.b):.8f}]"
              f" -> log10 beta >= {dec(r)}")

# (S) M6d's B_LP solution: L = 6, M = 247, log10 beta = 120.40192 -> X = 120.40192 ln 10; R = X^2, N = R (printed), single-scale axial K_sb
L, M = 6, 247
X = iv.mpf("120.40192") * LN10
R = X ** 2
N = R
Mi, Li = iv.mpf(M), iv.mpf(L)
COST = 3 * (100 * Mi) ** D * X * R ** (D + 1)
PLP = iv.sqrt(2 * COST)
Ksb = D * 100 * Mi * (Li + 1) * R
Ppin_printedR9 = 4 * iv.sqrt(N) * iv.sqrt(2 * Ksb * COST / 2)
Ppin_reread = 4 * iv.sqrt(2 * Ksb * COST / 2)
print(f"  S: at M6d's B_LP point (L = 6, M = 247, X = {float(X.a):.4f}): P_LP = {float(PLP.a):.4e},"
      f" single-scale pinch (printed R9, N^1/2) = {float(Ppin_printedR9.a):.4e} (ratio {float((Ppin_printedR9 / PLP).a):.3e}),"
      f" (R9 re-read) = {float(Ppin_reread.a):.4e} (ratio {float((Ppin_reread / PLP).a):.3e})")
