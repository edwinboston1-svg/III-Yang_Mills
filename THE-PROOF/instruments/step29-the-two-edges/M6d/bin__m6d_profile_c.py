"""M6d run c: the SUFFICIENCY PROFILE in the walk decay rate delta (WORK.md section 9): M from (M1)-(M3) with delta in place of 1/2, and
M_proved of (9.2) (M3g's Combes-Thomas route, untracked factor C*C_S*C'_S^2 = 1); the floor rows of run b evaluated there.
Certified with mpmath.iv.  Stakes: WORK.md section 10 (written before this file).
Run: python -E -P bin/m6d_profile_c.py > rec/profile_run.2026-11-02c.txt
"""
import math

import mpmath
from mpmath import iv, mpf

mpmath.mp.dps = 40
iv.dps = 40
LN10 = iv.log(iv.mpf(10))
SQRT7 = iv.sqrt(iv.mpf(7))
LN4 = iv.log(iv.mpf(4))
HALF_LN_11489 = iv.log(iv.mpf(11489)) / 2
LN91 = iv.log(iv.mpf(91))
D = 4


def sgn(v):
    return 1 if v.a > 0 else (-1 if v.b < 0 else 0)


def root(f, lo, hi, iters=300, tol=mpf("1e-20")):
    flo, fhi = sgn(f(iv.mpf(lo))), sgn(f(iv.mpf(hi)))
    assert flo * fhi == -1, ("no certified sign change", lo, hi, flo, fhi)
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


def lo_dec(x):
    return float((x / LN10).a)


def cells(L, half):
    return (2 * half) // L + 1 if (2 * half) % L == 0 else -(-(2 * half) // L) + 1


def packing(a):
    best = 0.0
    for s in range(2, a + 1):
        m = (a - 1) // s + 1
        if m >= 2:
            best = max(best, m ** 4 * (s - 1) / 2)
    return best


def R_floor(L, half=6):
    a = cells(L, half)
    if a <= 2:
        return 0.0, a
    return max((a ** 4 - 16) / 16, packing(a)), a


def kappa_fl(L):
    if L >= 12:
        return HALF_LN_11489 / (1 - iv.mpf(1) / L)
    if L >= 4:
        return LN91 / (1 - iv.mpf(1) / L)
    return iv.log(iv.mpf(46)) / (1 - iv.mpf(1) / L)


def M_delta(L, kap, delta):
    """least integer M with delta*M >= (12/sqrt2) a, delta*M >= kappa, delta*M/3 >= 1 + 2 kappa + 4 ln(L M) (not certainly violated)."""
    ku = 2 * kap / L
    a = ku + LN4
    dl = iv.mpf(delta)
    m1 = int(math.ceil(float((12 / iv.sqrt(iv.mpf(2)) * a / dl).b)))
    m3 = int(math.ceil(float((kap / dl).b)))
    lo = max(m1, m3, 2)
    # (M2): increasing in M beyond small M; find least M by doubling + bisection on the "not certainly violated" predicate
    def ok(M):
        f = dl * iv.mpf(M) / 3 - 1 - 2 * kap - 4 * iv.log(iv.mpf(L) * iv.mpf(M))
        return f.b >= 0
    hi = lo
    while not ok(hi):
        hi *= 2
    if hi == lo:
        return lo
    a_, b_ = hi // 2, hi
    while b_ - a_ > 1:
        m = (a_ + b_) // 2
        if ok(m):
            b_ = m
        else:
            a_ = m
    return max(lo, b_)


def small_X(L, kap, M, R, q_lnM):
    ku = 2 * kap / L
    S1 = SQRT7 * ku + q_lnM + iv.log(iv.mpf(2))
    S2 = 4 * iv.log(iv.mpf(L)) + q_lnM + kap * R
    S3a = 2 * iv.log(4 * iv.mpf(M) ** 4)
    S3 = iv.log(S3a if S3a.a >= (2 * ku).b else 2 * ku)
    S = S1 if S1.a >= S2.b else S2
    return 2 * S + S3


def A2(X):
    return 12 + iv.mpf("9.836") / X


T15LF2 = root(lambda X: iv.log(A2(X) * X) - X - 2 * iv.log(iv.mpf(2)), 1.5, 500)


def KJ(M):
    return iv.log(iv.mpf(3 * (D - 1))) + 2 * D * iv.log(100 * iv.mpf(M)) + 6 * iv.log(iv.mpf(M))


def J_B_ar(M):
    return root(lambda X: -X / 2 + KJ(M) + (1 + 2 * (D + 2)) * iv.log(X), 40, 1e7)


def rows(L, M):
    kap = kappa_fl(L)
    R, _ = R_floor(L, 6)
    lnM = iv.log(iv.mpf(M))
    Xs = small_X(L, kap, M, iv.mpf(R), 8 * lnM)
    q5 = 2 * iv.log(iv.mpf(5))
    Xd1 = small_X(L, kap, M, iv.mpf(R), lnM if lnM.a >= q5.b else q5)
    Xd0 = small_X(L, kap, M, iv.mpf(R), q5)
    jb = J_B_ar(M)
    return {"B_ar": max(lo_dec(Xs), lo_dec(jb)), "C": max(lo_dec(Xs), lo_dec(T15LF2)),
            "D(q1=1)": max(lo_dec(Xd1), lo_dec(T15LF2)), "D(q1=0)": max(lo_dec(Xd0), lo_dec(T15LF2))}


def c1(alpha, delta0):
    t = iv.exp(-iv.mpf(alpha) * iv.mpf(delta0))                 # sum_z e^{-s|z|} = (1 + e^{-s})/(1 - e^{-s}) = coth(s/2), exact
    c0 = (1 + t) / (1 - t)
    return 12 * c0 ** D, c0


def M_proved(L, delta0="0.5"):
    kap = kappa_fl(L)
    ku = 2 * kap / L
    a = ku + LN4
    c1h, _ = c1("0.5", delta0)
    val = (12 / iv.sqrt(iv.mpf(2))) * a * 16 * c1h * iv.mpf(L) ** 2 * 256 * (2 + 2 * D) * iv.mpf(L) ** (6 + D) * iv.mpf(12) ** 4 \
        * (4 / iv.mpf(delta0))
    return val


print("=" * 110)
print(f"M6d run c (mpmath {mpmath.__version__}, iv.dps = {iv.dps}); d = {D}")
c1h, c0q = c1("0.5", "0.5")
print(f"c0(1/4) = coth(1/16) in [{mpmath.nstr(c0q.a, 12)}, {mpmath.nstr(c0q.b, 12)}];  c1(1/2) = 12 c0(1/4)^4 in [{mpmath.nstr(c1h.a, 10)}, {mpmath.nstr(c1h.b, 10)}]")
print("-" * 110)
print("PROFILE IN delta (M from (M1)-(M3) with delta; optimum over L in {3..20, 24, 30, 40}; decades, lower endpoints)")
Ls = list(range(3, 21)) + [24, 30, 40]
for delta in ("0.5", "1e-2", "1e-4", "1e-8", "1e-16"):
    best = {}
    for L in Ls:
        M = M_delta(L, kappa_fl(L), delta)
        for k, v in rows(L, M).items():
            if k not in best or v < best[k][0]:
                best[k] = (v, L, M)
    print(f"  delta = {delta:>6}: " + "; ".join(f"{k} {v:9.4f} (L={L}, M={M:.4g})" for k, (v, L, M) in best.items()))
print("-" * 110)
print("THE PROVED ROUTE: M_proved(L) of (9.2), untracked factor C*C_S*C'_S^2 = 1, delta0 = 1/2")
best = {}
for L in Ls:
    Mp = M_proved(L)
    M = int(mpmath.ceil(Mp.b))
    r = rows(L, M)
    for k, v in r.items():
        if k not in best or v < best[k][0]:
            best[k] = (v, L, M)
    if L in (3, 4, 5, 6, 12, 20):
        print(f"  L = {L:2d}: M_proved in [{mpmath.nstr(Mp.a, 8)}, {mpmath.nstr(Mp.b, 8)}] (log10 = {float((iv.log(Mp)/LN10).a):.4f}): "
              + "; ".join(f"{k} {v:9.3f}" for k, v in r.items()))
print("  OPTIMA on the proved route: " + "; ".join(f"{k} {v:.4f} (L={L}, log10 M={math.log10(M):.3f})" for k, (v, L, M) in best.items()))
print("=" * 110)
