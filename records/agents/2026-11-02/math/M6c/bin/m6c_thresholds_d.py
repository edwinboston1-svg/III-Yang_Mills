"""M6c run d (= run c with kappa_fl corrected for (2.36)'s enclosure, WORK.md 12.2-12.3): floors of Balaban's induction after Lemma RD (M6b, proved given), Lemma KP, Lemma M_w, Theorems B and P (this
agent), with M priced consistently; then the variants with Lemma LF' / LF / PS (open or proved-given, labelled in WORK.md).
Certified with mpmath.iv (outward rounding); roots by bisection on certified signs (M6's root()).  X = log(beta) = log(1/gamma^2).
Definitions: WORK.md section 9.  Stakes: WORK.md section 10 (written before this file).
Run: python -E -P bin/m6c_thresholds.py > rec/thresholds_run.2026-11-02c.txt
"""
import math

import mpmath
from mpmath import iv, mpf

mpmath.mp.dps = 50
iv.dps = 50
LN10 = iv.log(iv.mpf(10))
SQRT7 = iv.sqrt(iv.mpf(7))
LN4 = iv.log(iv.mpf(4))
LAM4 = iv.mpf(7) ** 7 / iv.mpf(6) ** 6          # 17.6513..., Lemma U tree bound (max degree 8)
HALF_LN_11489 = iv.log(iv.mpf(11489)) / 2
LN91 = iv.log(iv.mpf(91))
Q = 8                                            # (2.18): q >= 8


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


# ----------------------------------------------------------------------------------------------- Theorem B and Theorem P
def cells(L, half):  # worst number of (k+1)-blocks per axis met by the cells [i-half, i+half]
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


def kappa_fl(L):  # run d (WORK.md 12.2): closure of X~ as (2.36); diagonal family L >= 12, straight 4..11, antipodal-forced (46) at L = 3
    if L >= 12:
        return HALF_LN_11489 / (1 - iv.mpf(1) / L)
    if L >= 4:
        return LN91 / (1 - iv.mpf(1) / L)
    return iv.log(iv.mpf(46)) / (1 - iv.mpf(1) / L)


# ----------------------------------------------------------------------------------------------- M, consistently (section 6)
def M_alpha(L, kap):
    """least integer M such that M/6 >= 1 + 2 kap + 4 ln(L M) is NOT certainly violated, scanning upward (f increasing for M > 24)."""
    M = 25
    while True:
        f = iv.mpf(M) / 6 - 1 - 2 * kap - 4 * iv.log(iv.mpf(L * M))
        if f.b >= 0:  # not certainly negative: M is the first value not excluded
            return M
        M += 1


def M_free(L, kap, ku, a_extra=None, sufficiency=False):
    a = ku + LN4 if a_extra is None else ku + a_extra
    walk = (64 * a + 2) if sufficiency else (12 * iv.sqrt(iv.mpf(2)) * a)   # sufficiency: Lemma G count; floor: 12/sqrt2 per M-length, delta0 <= 1/2
    m1 = int(math.ceil(float(walk.b)))
    m3 = int(math.ceil(float((2 * kap).b)))
    return max(m1, m3, M_alpha(L, kap))


def M_chain(L, Mf):
    M = L
    while M < max(Mf, L ** 3):
        M *= L
    return M


# ----------------------------------------------------------------------------------------------- the rows (section 9)
def small_rows(L, kap, M, R, q_lnM):
    ku = 2 * kap / L
    S1 = SQRT7 * ku + q_lnM + iv.log(iv.mpf(2))
    S2 = 4 * iv.log(iv.mpf(L)) + q_lnM + kap * R
    S3a = 2 * iv.log(4 * iv.mpf(M) ** 4)
    S3b = 2 * ku
    S3 = iv.log(S3a if S3a.a >= S3b.b else S3b)
    S = S1 if S1.a >= S2.b else S2
    X = 2 * S + S3
    return X, S1, S2, S3


def T15():
    return root(lambda X: -X / 2 + 10 * iv.log(X) - iv.log(iv.mpf(2)), 40, 5000)


def T17(M):
    K = iv.log(iv.mpf("1.5")) + 4 * iv.log(iv.mpf(100 * M)) + 6 * iv.log(iv.mpf(M))
    return root(lambda X: -X / 2 + 12 * iv.log(X) + K, 40, 50000)


def T18(M):
    K = iv.log(iv.mpf(8)) + 6 * iv.log(iv.mpf(M)) + 5 * iv.log(iv.mpf(100 * M))
    return root(lambda X: -X / 2 + 12 * iv.log(X) + K, 40, 50000)


def T18c(M):
    K = iv.log(iv.mpf(6)) + 6 * iv.log(iv.mpf(M)) + 4 * iv.log(iv.mpf(100 * M))
    return root(lambda X: -X / 2 + 12 * iv.log(X) + K, 40, 50000)


def A2(X):
    return 12 + iv.mpf("9.836") / X


def T18_LFp(M):
    def f(X):
        A = iv.sqrt(A2(X))
        R = iv.log(3 * A2(X) * X * iv.mpf(100 * M) ** 4)
        return (-X / 2 + iv.log(X) / 2 + iv.log(A * R) + iv.log(iv.mpf(6)) + 6 * iv.log(iv.mpf(M))
                + 4 * iv.log(iv.mpf(100 * M)))
    return root(f, 20, 50000)


def T15_LF(r0):
    return root(lambda X: iv.log(A2(X) * X) - X - 2 * iv.log(iv.mpf(r0)), 1.5, 500)


# ================================================================================================= header and checks
print("=" * 118)
print(f"M6c run c (mpmath {mpmath.__version__}, iv.dps = {iv.dps})")
print(f"constants: sqrt7 in {mpmath.nstr(SQRT7.a, 12)}; 7^7/6^6 in {mpmath.nstr(LAM4.a, 12)}; ln(7^7/6^6) = {mpmath.nstr(iv.log(LAM4).a, 10)};"
      f" 16 ln(7^7/6^6) = {mpmath.nstr((16 * iv.log(LAM4)).a, 10)}; (1/2) ln 11489 = {mpmath.nstr(HALF_LN_11489.a, 12)};"
      f" sqrt(11489) = {mpmath.nstr(iv.sqrt(iv.mpf(11489)).a, 12)}; ln 91 = {mpmath.nstr(LN91.a, 12)}")

print("-" * 118)
print("c2 THEOREM B: worst blocks per axis a(L) and the residual floor R(L) (box~^6 = (2.36)'s enclosure; box~^5 for comparison)")
for L in range(3, 17):
    R6, a6 = R_floor(L, 6)
    R5, a5 = R_floor(L, 5)
    print(f"  L = {L:2d}: box~^6 a = {a6}, R >= {R6:7.4f} (MS {(a6**4-16)/16 if a6 > 2 else 0:.4f}, packing {packing(a6) if a6 > 2 else 0:.4f});"
          f"  box~^5 a = {a5}, R >= {R5:7.4f}")

print("-" * 118)
print("c3 THEOREM P: kappa_fl(L)")
for L in (3, 4, 5, 6, 8, 12, 16, 20, 40, 1000):
    k = kappa_fl(L)
    print(f"  L = {L:4d}: kappa_fl in [{mpmath.nstr(k.a, 10)}, {mpmath.nstr(k.b, 10)}]")
print(f"  L -> inf: {mpmath.nstr(HALF_LN_11489.a, 10)}")

print("-" * 118)
print("c10 entropy: c3(x) = 1 + 3x + 9x^2 + 19x^3 + 30x^4 + 21x^5 + 7x^6 + x^7 at x = e^{-a_v}; mu_d bracket")
N3 = [1, 3, 9, 19, 30, 21, 7, 1]
for av in ("0", "0.5", "1", "1.5", "2", "3", "4.466"):
    x = iv.exp(-iv.mpf(av))
    c3 = sum(n * x ** k for k, n in enumerate(N3))
    print(f"  a_v = {av:>5}: c3 in [{mpmath.nstr(c3.a, 8)}, {mpmath.nstr(c3.b, 8)}]")
print(f"  mu_d >= sqrt(11489) = {mpmath.nstr(iv.sqrt(iv.mpf(11489)).a, 10)};  ln mu_d <= 16 ln(7^7/6^6) = {mpmath.nstr((16*iv.log(LAM4)).b, 10)}")

# ================================================================================================= the sweep over L
print("-" * 118)
print("SWEEP (floors; X in decades; M_free = consistent M; M_chain = least power of L >= max(M_free, L^3))")
t15 = T15()
t15lf2, t15lf03 = T15_LF(2), T15_LF("0.3")
print(f"  T15 (Balaban, p0 = 10) = {dec(t15)};  T15_LF(radius 2) = {dec(t15lf2)} (beta = {mpmath.nstr(iv.exp(t15lf2).a, 6)});"
      f"  T15_LF(radius 0.3) = {dec(t15lf03)} (beta = {mpmath.nstr(iv.exp(t15lf03).a, 6)})")
best = {}
for mode in ("free", "chain"):
    print(f"  --- M {mode} ---")
    print("   L  kappa   M     R     X_small   T17      T18c     T18      T18_LF'  |  B        C'       C        D")
    for L in list(range(3, 21)) + [24, 30, 40]:
        kap = kappa_fl(L)
        ku = 2 * kap / L
        R, _ = R_floor(L, 6)
        Mf = M_free(L, kap, ku)
        M = Mf if mode == "free" else M_chain(L, Mf)
        qlnM = Q * iv.log(iv.mpf(M))
        Xs, S1, S2, S3 = small_rows(L, kap, M, iv.mpf(R), qlnM)
        Xd, _, _, _ = small_rows(L, kap, M, iv.mpf(R), 2 * iv.log(iv.mpf(5)))
        t17, t18c, t18, t18lf = T17(M), T18c(M), T18(M), T18_LFp(M)
        B = max(lo_dec(Xs), lo_dec(t15), lo_dec(t17), lo_dec(t18c))
        Cp = max(lo_dec(Xs), lo_dec(t15lf2), lo_dec(t18lf))
        C = max(lo_dec(Xs), lo_dec(t15lf2))
        D = max(lo_dec(Xd), lo_dec(t15lf2))
        for name, v in (("B", B), ("C'", Cp), ("C", C), ("D", D)):
            key = (mode, name)
            if key not in best or v < best[key][0]:
                best[key] = (v, L, M)
        print(f"  {L:3d} {float(kap.a):6.3f} {M:6d} {R:6.2f} {lo_dec(Xs):9.3f} {lo_dec(t17):8.3f} {lo_dec(t18c):8.3f} {lo_dec(t18):8.3f}"
              f" {lo_dec(t18lf):8.3f}  | {B:8.3f} {Cp:8.3f} {C:8.3f} {D:8.3f}")
print("  OPTIMA (lower endpoints, decades):")
for (mode, name), (v, L, M) in sorted(best.items()):
    print(f"    {name:2s} M {mode:5s}: log10 beta_B >= {v:.4f} at L = {L}, M = {M}")

# ================================================================================================= detail at L = 12 (c4) and L = 6
for L in (12, 6):
    kap = kappa_fl(L)
    ku = 2 * kap / L
    R, _ = R_floor(L, 6)
    M = M_free(L, kap, ku)
    qlnM = Q * iv.log(iv.mpf(M))
    Xs, S1, S2, S3 = small_rows(L, kap, M, iv.mpf(R), qlnM)
    print("-" * 118)
    print(f"DETAIL L = {L}: kappa = {mpmath.nstr(kap.a, 10)}, kappa_u = {mpmath.nstr(ku.a, 8)}, R = {R}, M_free = {M}"
          f" (M_alpha = {M_alpha(L, kap)}, 12 sqrt2 a = {mpmath.nstr((12*iv.sqrt(iv.mpf(2))*(ku+LN4)).b, 8)}, 2 kappa = {mpmath.nstr((2*kap).b, 6)})")
    print(f"  S1 = [{mpmath.nstr(S1.a, 10)}, {mpmath.nstr(S1.b, 10)}]  S2 = [{mpmath.nstr(S2.a, 10)}, {mpmath.nstr(S2.b, 10)}]"
          f"  S3 = [{mpmath.nstr(S3.a, 10)}, {mpmath.nstr(S3.b, 10)}]")
    print(f"  X_small = {dec(Xs)}; T15 = {dec(t15)}; T17 = {dec(T17(M))}; T18c = {dec(T18c(M))}; T18 = {dec(T18(M))}; T18_LF' = {dec(T18_LFp(M))}")
    t = T18c(M)
    parts = {"(p0+2) ln X  [polylog: p0 >= 10, R_k >= (log)^2]": 12 * iv.log(t), "6 ln M  [LFR I (1.83)]": 6 * iv.log(iv.mpf(M)),
             "4 ln(100M)  [Poincare, comb gauge]": 4 * iv.log(iv.mpf(100 * M)), "ln 6": iv.log(iv.mpf(6))}
    print("  T18c decomposed (X = 2 x sum; decades):")
    for k_, v in parts.items():
        print(f"     {k_:52s} {float((2 * v / LN10).a):9.4f}")

# ================================================================================================= c11 kappa-dependence at L = 12
print("-" * 118)
L = 12
kap0 = iv.mpf(0)
M0 = M_free(L, kap0, kap0)
Xs0, *_ = small_rows(L, kap0, M0, iv.mpf(0), Q * iv.log(iv.mpf(M0)))
kap = kappa_fl(L)
M1 = M_free(L, kap, 2 * kap / L)
Xs1, *_ = small_rows(L, kap, M1, iv.mpf(0), Q * iv.log(iv.mpf(M1)))
print(f"c11 kappa-dependence of X_small at L = 12: kappa = 0+ (M = {M0}): {dec(Xs0)};  kappa = kappa_fl (M = {M1}): {dec(Xs1)};"
      f"  difference {float(((Xs1 - Xs0) / LN10).a):.4f} decades")

# ================================================================================================= c12 entropy-constant profiles
print("-" * 118)
print("c12 ENTROPY-CONSTANT PROFILES at L = 12 (existential constants at 1; NOT a sufficiency proof)")
aE = 16 * iv.log(LAM4)
kd = aE / (1 - iv.mpf(2) / L)
kud = 2 * kd / L
av = iv.log(2 * LAM4)
Md = M_free(L, kd, kud, a_extra=av, sufficiency=True)
qd = Q * iv.log(iv.mpf(Md))
S1d = SQRT7 * kud + qd + iv.log(iv.mpf(2))
S2d = 4 * iv.log(iv.mpf(L)) + qd + 2 * kd
S3d = iv.log(2 * iv.log(4 * iv.mpf(Md) ** 4))
Xd = 2 * (S1d if S1d.a >= S2d.b else S2d) + S3d
print(f"  d-format, a_E = 16 ln(7^7/6^6): kappa = {mpmath.nstr(kd.a, 8)}, M = {Md}, S1 = {mpmath.nstr(S1d.a, 8)}, S2 (junction 2 kappa) = {mpmath.nstr(S2d.a, 8)}:"
      f" log10 beta = {dec(Xd)}")
avout = LN4 / (1 - iv.mpf(1) / L)
Mv = M_free(L, iv.mpf(0), iv.mpf(0), a_extra=av + avout, sufficiency=True)
qv = Q * iv.log(iv.mpf(Mv))
S1v = qv + iv.log(iv.mpf(2))
S2v = 4 * iv.log(iv.mpf(L)) + qv
S3v = iv.log(2 * iv.log(4 * iv.mpf(Mv) ** 4))
Xv = 2 * (S1v if S1v.a >= S2v.b else S2v) + S3v
Xv2 = 2 * (S2v + 16 * avout) + S3v
print(f"  volume-priced, a_v = ln(2 x 17.65) = {mpmath.nstr(av.a, 6)}, a_v,out = ln4/(1-1/L) = {mpmath.nstr(avout.a, 6)}, kappa -> 0+: M = {Mv};"
      f" base images exempt: {dec(Xv)};  not exempt (+16 a_v,out in S2): {dec(Xv2)}")
print("=" * 118)
