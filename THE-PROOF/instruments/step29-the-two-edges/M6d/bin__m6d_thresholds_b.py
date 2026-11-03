"""M6d run a: the JOINT large-field floor (Theorem J: (1.88) x T18c share the free function P(g) = eps_k/g_k), Lemma LP (quadratic
budget), the LF' corridor R_min of (2.1), and the history half of Lemma PS (q1 = 1 from CMP 109's alpha-conditions).  Small-field rows,
kappa_fl, M_free, Theorem B: copied verbatim from M6c run d (bin/m6c_thresholds_d.py), so M6c's numbers are reproduced first.
Certified with mpmath.iv (outward rounding); roots by bisection on certified signs.  X = log(beta) = log(1/g^2).  d = 4.
Definitions: WORK.md sections 2-3.  Stakes: WORK.md section 4 (written before this file).
Run: python -E -P bin/m6d_thresholds.py > rec/thresholds_run.2026-11-02a.txt
"""
import math

import mpmath
from mpmath import iv, mpf

mpmath.mp.dps = 50
iv.dps = 50
LN10 = iv.log(iv.mpf(10))
SQRT7 = iv.sqrt(iv.mpf(7))
LN4 = iv.log(iv.mpf(4))
HALF_LN_11489 = iv.log(iv.mpf(11489)) / 2
LN91 = iv.log(iv.mpf(91))
Q = 8
D = 4


def sgn(v):
    if v.a > 0:
        return 1
    if v.b < 0:
        return -1
    return 0


def root(f, lo, hi, iters=400, tol=mpf("1e-30")):
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


def dec(x):
    v = x / LN10
    return f"[{mpmath.nstr(v.a, 10)}, {mpmath.nstr(v.b, 10)}]"


def lo_dec(x):
    return float((x / LN10).a)


# ---------------------------------------------------------------- M6c run d, verbatim (Theorem B, Theorem P, M, small-field rows)
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


def M_alpha(L, kap):
    M = 25
    while True:
        f = iv.mpf(M) / 6 - 1 - 2 * kap - 4 * iv.log(iv.mpf(L * M))
        if f.b >= 0:
            return M
        M += 1


def M_free(L, kap, ku):
    a = ku + LN4
    walk = 12 * iv.sqrt(iv.mpf(2)) * a
    m1 = int(math.ceil(float(walk.b)))
    m3 = int(math.ceil(float((2 * kap).b)))
    return max(m1, m3, M_alpha(L, kap))


def small_rows(L, kap, M, R, q_lnM):
    ku = 2 * kap / L
    S1 = SQRT7 * ku + q_lnM + iv.log(iv.mpf(2))
    S2 = 4 * iv.log(iv.mpf(L)) + q_lnM + kap * R
    S3a = 2 * iv.log(4 * iv.mpf(M) ** 4)
    S3b = 2 * ku
    S3 = iv.log(S3a if S3a.a >= S3b.b else S3b)
    S = S1 if S1.a >= S2.b else S2
    return 2 * S + S3, S1, S2, S3


def A2(X):
    return 12 + iv.mpf("9.836") / X


def T15_LF(r0):
    return root(lambda X: iv.log(A2(X) * X) - X - 2 * iv.log(iv.mpf(r0)), 1.5, 500)


def T18c(M):   # M6c's row: P(g) = X^10 (p0 = 5r, A0 = 1), R = X^2
    K = iv.log(iv.mpf(6)) + 6 * iv.log(iv.mpf(M)) + 4 * iv.log(iv.mpf(100 * M))
    return root(lambda X: -X / 2 + 12 * iv.log(X) + K, 40, 50000)


def T17(M):    # M6c's row: (1.88) pinched with T16
    K = iv.log(iv.mpf("1.5")) + 4 * iv.log(iv.mpf(100 * M)) + 6 * iv.log(iv.mpf(M))
    return root(lambda X: -X / 2 + 12 * iv.log(X) + K, 40, 50000)


# ---------------------------------------------------------------- Theorem J and Lemma LP (WORK.md 3.2-3.4)
def KJ(M):     # ln(3(d-1)) + 2d ln(100M) + 6 ln M
    return iv.log(iv.mpf(3 * (D - 1))) + 2 * D * iv.log(iv.mpf(100 * M)) + 6 * iv.log(iv.mpf(M))


def KLP(M):    # ln(2(d-1)) + (1/2) ln 3 + (3d/2) ln(100M) + 6 ln M
    return (iv.log(iv.mpf(2 * (D - 1))) + iv.log(iv.mpf(3)) / 2 + iv.mpf(3 * D) / 2 * iv.log(iv.mpf(100 * M))
            + 6 * iv.log(iv.mpf(M)))


def J_B_pr(M):  # R = X^2: X/2 = KJ + (d+3) ln X^2
    return root(lambda X: -X / 2 + KJ(M) + 2 * (D + 3) * iv.log(X), 40, 50000)


def J_B_ar(M):  # X/2 = KJ + ln X + (d+2) ln X^2
    return root(lambda X: -X / 2 + KJ(M) + (1 + 2 * (D + 2)) * iv.log(X), 40, 50000)


def J_B_LP(M):  # X/2 = KLP + (1/2) ln X + ((d+3)/2) ln X^2
    return root(lambda X: -X / 2 + KLP(M) + (iv.mpf(1) / 2 + (D + 3)) * iv.log(X), 40, 50000)


def Rstar(c, k, lo=None):
    """larger root of R - k ln R = c (c interval); returns an interval containing every root for c in the interval."""
    def f_at(cv):
        g = lambda R: R - k * iv.log(R) - cv
        return root(g, k + 1e-9 if lo is None else lo, 1e6)
    ra = f_at(iv.mpf(c.a))
    rb = f_at(iv.mpf(c.b))
    return iv.mpf([ra.a, rb.b])


def R_LFp_ar(M, X):   # R - 10 ln R = ln(6.75 (100M)^12 X^2)  [R6 = ln(3 P^2 (100M)^4), P = 1.5(100M)^4 X R^5]  (run b: 8 -> 12)
    c = iv.log(iv.mpf("6.75")) + 12 * iv.log(iv.mpf(100 * M)) + 2 * iv.log(X)
    return Rstar(c, 10)


def R_LFp_LP(M, X):   # R - 5 ln R = ln(9 (100M)^8 X)  [R6 with P = (3(100M)^4 X R^5)^(1/2)]
    c = iv.log(iv.mpf(9)) + 8 * iv.log(iv.mpf(100 * M)) + iv.log(X)
    return Rstar(c, 5)


def J_LFp_ar(M):
    return root(lambda X: -X / 2 + KJ(M) + iv.log(X) + (D + 2) * iv.log(R_LFp_ar(M, X)), 40, 50000)


def J_LFp_LP(M):
    return root(lambda X: -X / 2 + KLP(M) + iv.log(X) / 2 + iv.mpf(D + 3) / 2 * iv.log(R_LFp_LP(M, X)), 40, 50000)


def N8(M, L, R, P):
    return ((D + 5) * iv.log(iv.mpf(M)) + (D - 1) * iv.log(R) + 2 * iv.log(P)) / ((D - 1) * iv.log(iv.mpf(L)))


def N9(M, L, N):
    return (6 * iv.log(iv.mpf(M)) + iv.log(iv.mpf(2)) + iv.log(N) / 2) / iv.log(iv.mpf(L))


# ================================================================ header
print("=" * 120)
print(f"M6d run b (mpmath {mpmath.__version__}, iv.dps = {iv.dps}); d = {D}")

print("-" * 120)
print("CHECK: M6c run d reproduced at L = 5, 6, 12 (X_small, T17, T18c; C, D)")
t15lf2 = T15_LF(2)
for L in (5, 6, 12):
    kap = kappa_fl(L)
    ku = 2 * kap / L
    R, _ = R_floor(L, 6)
    M = M_free(L, kap, ku)
    Xs, *_ = small_rows(L, kap, M, iv.mpf(R), Q * iv.log(iv.mpf(M)))
    Xd, *_ = small_rows(L, kap, M, iv.mpf(R), 2 * iv.log(iv.mpf(5)))
    print(f"  L = {L:2d}: M = {M}, X_small = {dec(Xs)}, T17 = {dec(T17(M))}, T18c = {dec(T18c(M))}, "
          f"C = {max(lo_dec(Xs), lo_dec(t15lf2)):.5f}, D = {max(lo_dec(Xd), lo_dec(t15lf2)):.5f}")

# ================================================================ sweep
print("-" * 120)
print("SWEEP over L (M = M_free(L); decades; lower endpoints of certified intervals)")
print("   L      M   X_small    J_B_pr    J_B_ar    J_B_LP  J_LFp_ar  J_LFp_LP | B_pr     B_ar     B_LP     LFp_ar   LFp_LP   D(q1=1)")
best = {}
rows = {}
for L in list(range(3, 21)) + [24, 30, 40]:
    kap = kappa_fl(L)
    ku = 2 * kap / L
    R, _ = R_floor(L, 6)
    M = M_free(L, kap, ku)
    Xs, S1, S2, S3 = small_rows(L, kap, M, iv.mpf(R), Q * iv.log(iv.mpf(M)))
    qh = iv.log(iv.mpf(M))
    q5 = 2 * iv.log(iv.mpf(5))
    Xd1, *_ = small_rows(L, kap, M, iv.mpf(R), qh if qh.a >= q5.b else q5)
    jbpr, jbar, jblp, jlar, jllp = J_B_pr(M), J_B_ar(M), J_B_LP(M), J_LFp_ar(M), J_LFp_LP(M)
    rows[L] = (M, Xs, jbpr, jbar, jblp, jlar, jllp)
    vals = {"B_pr": max(lo_dec(Xs), lo_dec(jbpr)), "B_ar": max(lo_dec(Xs), lo_dec(jbar)), "B_LP": max(lo_dec(Xs), lo_dec(jblp)),
            "LFp_ar": max(lo_dec(Xs), lo_dec(jlar)), "LFp_LP": max(lo_dec(Xs), lo_dec(jllp)),
            "D(q1=1)": max(lo_dec(Xd1), lo_dec(t15lf2))}
    for k, v in vals.items():
        if k not in best or v < best[k][0]:
            best[k] = (v, L, M)
    print(f"  {L:3d} {M:6d} {lo_dec(Xs):9.3f} {lo_dec(jbpr):9.3f} {lo_dec(jbar):9.3f} {lo_dec(jblp):9.3f} {lo_dec(jlar):9.3f}"
          f" {lo_dec(jllp):9.3f} | " + " ".join(f"{vals[k]:8.3f}" for k in ("B_pr", "B_ar", "B_LP", "LFp_ar", "LFp_LP", "D(q1=1)")))
print("  OPTIMA (lower endpoints, decades):")
for k, (v, L, M) in best.items():
    print(f"    {k:8s}: log10 beta_B >= {v:.5f} at L = {L}, M = {M}")

# ================================================================ details
for L in (5, 6, 12):
    M, Xs, jbpr, jbar, jblp, jlar, jllp = rows[L]
    print("-" * 120)
    print(f"DETAIL L = {L}, M = {M}: J_B_pr = {dec(jbpr)}, J_B_ar = {dec(jbar)}, J_B_LP = {dec(jblp)}, J_LFp_ar = {dec(jlar)},"
          f" J_LFp_LP = {dec(jllp)}")
    for name, J, Rf, Pf in (("LFp_ar", jlar, R_LFp_ar, lambda X, R: iv.mpf("1.5") * iv.mpf(100 * M) ** 4 * X * R ** 5),
                            ("LFp_LP", jllp, R_LFp_LP, lambda X, R: iv.sqrt(3 * iv.mpf(100 * M) ** 4 * X * R ** 5))):
        X = iv.mpf(J.b)
        R = Rf(M, X)
        P = Pf(X, R)
        n8 = N8(M, L, R, P)
        n9 = N9(M, L, iv.mpf(n8.b))
        print(f"  {name}: at X = {mpmath.nstr(J.b, 10)}: R_min = R6 in [{mpmath.nstr(R.a, 8)}, {mpmath.nstr(R.b, 8)}];"
              f" ln P in [{mpmath.nstr(iv.log(P).a, 8)}, {mpmath.nstr(iv.log(P).b, 8)}]; N8 <= {mpmath.nstr(n8.b, 6)}; N9 <= {mpmath.nstr(n9.b, 6)}"
              f"  -> R6 binds: {bool(R.a > n8.b and R.a > n9.b)}")
    Xb = iv.mpf(jbar.b)
    parts = {"ln 9 + 8 ln(100M) + 6 ln M  [per-M-cube bookkeeping]": KJ(M), "13 ln X  [R = X^2 powers and X]": 13 * iv.log(Xb)}
    print("  B_ar decomposed (X = 2 x sum; decades):")
    for k_, v in parts.items():
        print(f"     {k_:56s} {float((2 * v / LN10).a):9.4f}")
print("=" * 120)
