"""M6b run b: the rows after Lemma M_w and Lemma KP (both NAMED, not proved), certified with mpmath.iv.

kappa_KP(L) = ln 91/(1 - 2/L) (one Kotecky-Preiss payment per scale, the whole rescaling budget); E2's residual after Lemma M_w:
2(1-2delta) kappa d_{k+1}(box~^5/L) with d_{k+1}(box~^5/3) >= (4^4-16)/16 = 15 (a cube of side 11/3 meets >= 4^4 unit cubes) and
= 0 for L >= 11; the e^{5 kappa} row 10 kappa + ln(80 kappa); T18/T17 at M = L^3.
Run: python -E -P bin/m6b_thresholds_b.py > rec/thresholds_run.2026-11-02b.txt
"""
from fractions import Fraction

import mpmath
from mpmath import iv, mpf

mpmath.mp.dps = 50
iv.dps = 50
LN10 = iv.log(iv.mpf(10))
ln91 = iv.log(iv.mpf(91))


def rng(v):
    return f"[{mpmath.nstr(v.a, 12)}, {mpmath.nstr(v.b, 12)}]"


def sgn(v):
    return 1 if v.a > 0 else (-1 if v.b < 0 else 0)


def root(f, lo, hi, iters=300, tol=mpf("1e-30")):
    flo, fhi = sgn(f(iv.mpf(lo))), sgn(f(iv.mpf(hi)))
    assert flo * fhi == -1
    lo, hi = mpf(lo), mpf(hi)
    for _ in range(iters):
        if hi - lo < tol:
            break
        mid = (lo + hi) / 2
        s = sgn(f(iv.mpf(mid)))
        if s == 0:
            break
        if s == flo:
            lo = mid
        else:
            hi = mid
    return iv.mpf([lo, hi])


def om(L):
    return iv.mpf(4) / 5 if L == "inf" else 1 - iv.mpf(2) * (1 - iv.mpf(2) / L) / 10


def kKP(L):
    return ln91 if L == "inf" else ln91 / (1 - iv.mpf(2) / L)


res15 = iv.mpf(Fraction(4 ** 4 - 16, 16).numerator) / Fraction(4 ** 4 - 16, 16).denominator
print("=" * 100)
print(f"d_(k+1)(box~^5/3) >= (4^4-16)/16 = {Fraction(4**4-16,16)}; ln 91 in {rng(ln91)}")
for L in (3, 11, "inf"):
    k = kKP(L)
    row5 = 10 * k + iv.log(80 * k)
    print(f"L = {L}: kappa_KP in {rng(k)}; e^(5kappa) row log10 beta >= {rng(row5 / LN10)}")
k1 = iv.mpf(1)
resid = 2 * om(3) * k1 * res15 + 10 * k1 + iv.log(80 * k1)
print(f"E2 residual after Lemma M_w, L = 3, kappa = 1: log10 beta >= {rng(resid / LN10)}")
k = kKP(3)
resid = 2 * om(3) * k * res15 + 10 * k + iv.log(80 * k)
print(f"E2 residual + e^(5kappa) at L = 3, kappa = kappa_KP: log10 beta >= {rng(resid / LN10)}")
d = 4
M = 11 ** 3
K18 = iv.log(iv.mpf(2 * d)) + 6 * iv.log(iv.mpf(M)) + (d + 1) * iv.log(iv.mpf(100 * M))
X18 = root(lambda X: -X / 2 + 12 * iv.log(X) + K18, 24, 50000)
K17 = iv.log(iv.mpf("1.5")) + d * iv.log(iv.mpf(100 * M)) + 6 * iv.log(iv.mpf(M))
X17 = root(lambda X: -X / 2 + 12 * iv.log(X) + K17, 30, 50000)
print(f"L = 11, M = 1331: T18 (p0 = 10, r = 2) log10 beta in {rng(X18 / LN10)}; T17 (r = 2) log10 beta in {rng(X17 / LN10)}")
print("=" * 100)
