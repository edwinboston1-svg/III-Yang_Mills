"""UV3 run a: LF IN FULL -- the floor ladder (rungs A..G) with Theorem J' (the preparatory pinch) and the Coulomb-slice instrument.
Small-field rows, kappa_fl, M_free, Theorem B: copied verbatim from M6d's bin/m6d_thresholds_e.py (= M6c run d), so M6d is reproduced first.
Certified with mpmath.iv (outward rounding); roots by bisection on certified signs.  X = log(beta) = log(1/g^2).  d = 4.
Self-consistent design parameters (R_eff, N) are iterated FROM BELOW (monotone map, lower endpoints carried), so every root printed is a
lower bound on the scheme's threshold (a valid FLOOR).
Definitions: WORK.md sections 3, 5, 6, 7.  Stakes: WORK.md sections 4 and 7 (written before this file).
Run: python -E -P code/uv3_floor_a.py > rec/floor_run.2026-11-02a.txt
"""
import math

import mpmath
from mpmath import iv, mpf

mpmath.mp.dps = 50
iv.dps = 50
LN10 = iv.log(iv.mpf(10))
SQRT7 = iv.sqrt(iv.mpf(7))
SQRT2 = iv.sqrt(iv.mpf(2))
LN4 = iv.log(iv.mpf(4))
HALF_LN_11489 = iv.log(iv.mpf(11489)) / 2
LN91 = iv.log(iv.mpf(91))
Q = 8
D = 4


def I(x):
    return iv.mpf(x)


def sgn(v):
    if v.a > 0:
        return 1
    if v.b < 0:
        return -1
    return 0


def root(f, lo, hi, iters=200, tol=mpf("1e-14")):
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


def imax(*xs):
    return iv.mpf([max(x.a for x in xs), max(x.b for x in xs)])


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


# ---------------------------------------------------------------- the instrument (WORK.md section 5)
def CP(ell):
    """CD-1: the exact Coulomb-Dirichlet Poincare constant of the cube of side ell (sites)."""
    s = iv.sin(iv.pi / (2 * (I(ell) + 1)))
    return 1 / ((D - 1) * 4 * s * s)


def u3_closed():
    """Watson's integral for the simple cubic lattice, closed form (Glasser-Zucker): sqrt(6)/(32 pi^3) G(1/24)G(5/24)G(7/24)G(11/24)."""
    with mpmath.workdps(60):
        v = mpmath.sqrt(6) / (32 * mpmath.pi ** 3) * mpmath.gamma(mpf(1) / 24) * mpmath.gamma(mpf(5) / 24) * \
            mpmath.gamma(mpf(7) / 24) * mpmath.gamma(mpf(11) / 24)
    return v


U3 = u3_closed()
G3 = iv.mpf([U3 / 6 - mpf("1e-45"), U3 / 6 + mpf("1e-45")])   # CD-2's constant G_{Z^3}(0) = u3/6


def u3_quad():
    """cross-check (not certified): u3 = int_0^inf e^{-t} I0(t/3)^3 dt."""
    with mpmath.workdps(30):
        return mpmath.quad(lambda t: mpmath.exp(-t) * mpmath.besseli(0, t / 3) ** 3, [0, 10, 100, mpmath.inf])


# ---------------------------------------------------------------- the rungs (WORK.md section 7)
def rung_K(rung, L, M, X, want_detail=False):
    """Return (K_binding, K_A'column or None, detail dict): the binding large-field row reads X/2 = K."""
    Mi, Li = I(M), I(L)
    det = {}
    if rung in ("A", "B"):                       # printed design: R = X^2, N = R
        R = X ** 2
        N = R
        COST = 3 * (100 * Mi) ** D * X * R ** (D + 1)
        PJ1 = COST / 2
        Creg = PJ1
        if rung == "A":
            Ksb = 6 * (D + 3) * (100 * Mi * (Li + 1) * R) ** (D + 2)
        else:
            Ksb = D * 100 * Mi * (Li + 1) * R
        Ppin = 4 * iv.sqrt(N) * iv.sqrt(2 * Ksb * Creg)
        P = imax(PJ1, Ppin)
        K = iv.log(2 * (D - 1) * (100 * Mi) ** D * Mi ** 6 * R * P)
        Kcol = None
        if rung == "A":
            Kcol = iv.log(P * N * (100 * Mi * R) ** D * Mi ** 6 * R * 12 * (D + 3) * (100 * Mi * (Li + 1) * R) ** (D + 2))
        det = dict(P=P, PJ1=PJ1, Ppin=Ppin, R=R, N=N)
        return K, Kcol, det
    if rung == "G":                              # the M-cube floor: one M-cube, one step, ell = M, c_F = 1
        COST = X * Mi ** D
        PLP = iv.sqrt(2 * COST)
        Ppin = 4 * iv.sqrt(G3 * COST)
        P = imax(PLP, Ppin)
        ell = Mi
        cF = I(1)
        K = iv.log(SQRT2 * (D - 1) * ell * cF * P / ((1 - 1 / SQRT2) * iv.sin(iv.pi / (2 * (ell + 1)))))
        det = dict(P=P, PLP=PLP, Ppin=Ppin, ell=ell, cF=cF, R=I(1), N=I(1))
        return K, None, det
    # rungs C, D, E, F: self-consistent (R_eff, N) from below
    Rl, Nl = mpf(1), mpf(1)
    for _ in range(80):
        R, N = I(Rl), I(Nl)
        W = Mi * R
        if rung == "F":
            COST = X * (3 * W) ** D * N
            ell = 3 * W + 2 * Mi
            area = (3 * W) ** (D - 1)
        else:
            COST = 3 * (100 * W) ** D * X * N
            ell = 100 * Mi
            area = (100 * W) ** (D - 1)
        PLP = iv.sqrt(2 * COST)
        if rung == "C":
            Ksb = D * 100 * W * (Li + 1)
            Ppin = 4 * iv.sqrt(2 * Ksb * COST / 2)
            cF = None
        else:
            Ppin = 4 * iv.sqrt(G3 * COST)
            cF = 2 + 128 * CP(ell) if rung == "D" else I(1)
        P = imax(PLP, Ppin)
        if rung == "C":
            R6 = iv.log(3 * Mi ** 6 * P ** 2 * (100 * Mi) ** D)
            N8 = ((D + 5) * iv.log(Mi) + (D - 1) * iv.log(R) + 2 * iv.log(P)) / ((D - 1) * iv.log(Li))
            N9 = (6 * iv.log(Mi) + iv.log(I(2)) + iv.log(N) / 2) / iv.log(Li)
        else:
            M0 = (D - 1) * ell * cF
            R6 = iv.log(3 * M0 * P ** 2 * ell ** D)
            N8 = iv.log(4 * D * (D - 1) * area * cF * P ** 2) / ((D - 1) * iv.log(Li))
            N9 = iv.log(4 * (D - 1) * ell * cF) / iv.log(Li)
        Rn = max(mpf(1), (2 * R6 / Mi).a)
        Nn = max(mpf(1), N8.a, N9.a)
        if abs(Rn - Rl) < mpf("1e-25") and abs(Nn - Nl) < mpf("1e-25"):
            Rl, Nl = Rn, Nn
            break
        Rl, Nl = max(Rl, Rn), max(Nl, Nn)       # monotone from below
    R, N = I(Rl), I(Nl)
    if rung == "C":
        K = iv.log(2 * (D - 1) * (100 * Mi) ** D * Mi ** 6 * R * P)
    else:
        K = iv.log(SQRT2 * (D - 1) * ell * cF * P / ((1 - 1 / SQRT2) * iv.sin(iv.pi / (2 * (ell + 1)))))
    det = dict(P=P, PLP=PLP, Ppin=Ppin, R=R, N=N, ell=ell, cF=cF, R6=R6, N8=N8, N9=N9)
    return K, None, det


def lf_root(rung, L, M, column=False):
    def f(X):
        K, Kc, _ = rung_K(rung, L, M, X)
        return -X / 2 + (Kc if column else K)
    return root(f, 10, 60000)


# ================================================================ header and checks
print("=" * 130)
print(f"UV3 run a (mpmath {mpmath.__version__}, iv.dps = {iv.dps}); d = {D}")
print(f"CD-2 constant: u3 (closed form) = {mpmath.nstr(U3, 25)};  u3 (quadrature cross-check) = {mpmath.nstr(u3_quad(), 20)};"
      f"  G3 = u3/6 in [{mpmath.nstr(G3.a, 20)}, {mpmath.nstr(G3.b, 20)}]")
for ell in (261, 1305, 26100):
    c = CP(ell)
    print(f"CD-1: C_P({ell}) in [{mpmath.nstr(c.a, 12)}, {mpmath.nstr(c.b, 12)}]   (bound (ell+1)^2/(4(d-1)) = {(ell + 1) ** 2 / 12:.6e};"
          f" comb lower bound (ell^(d-1)-1)(ell-1)/((d-1)ell) = {(ell ** 3 - 1) * (ell - 1) / (3 * ell):.6e}; comb upper (d-1)ell^d = {3 * ell ** 4:.6e})")

print("-" * 130)
print("CHECK: M6d run e reproduced (X_small, B_ar = rung B at L = 4; C = X_small(12); D(q1 = 1) at L = 12)")
t15lf2 = T15_LF(2)
SMALL = {}
for L in list(range(3, 21)) + [24, 30, 40]:
    kap = kappa_fl(L)
    ku = 2 * kap / L
    Rb, _ = R_floor(L, 6)
    M = M_free(L, kap, ku)
    Xs, *_ = small_rows(L, kap, M, iv.mpf(Rb), Q * iv.log(iv.mpf(M)))
    qh = iv.log(iv.mpf(M))
    q5 = 2 * iv.log(iv.mpf(5))
    Xd1, *_ = small_rows(L, kap, M, iv.mpf(Rb), qh if qh.a >= q5.b else q5)
    Xd0, *_ = small_rows(L, kap, M, iv.mpf(Rb), q5)
    SMALL[L] = (M, Xs, Xd1, Xd0)
for L in (4, 12):
    M, Xs, Xd1, Xd0 = SMALL[L]
    print(f"  L = {L:2d}: M = {M}, X_small = {dec(Xs)}, PS(q1=1) small = {dec(Xd1)}, PS(q1=0) small = {dec(Xd0)}")
print(f"  T15_LF(2) = {dec(t15lf2)}")

# ================================================================ sweep
RUNGS = ["A", "B", "C", "D", "E", "F", "G"]
print("-" * 130)
print("SWEEP over L: the large-field row of each rung (decades, lower endpoints); A' = (1.77) additive column")
print("   L      M   X_small  PS(q1=1) PS(q1=0) |       A       A'        B        C        D        E        F        G")
LF = {}
for L in list(range(3, 21)) + [24, 30, 40]:
    M, Xs, Xd1, Xd0 = SMALL[L]
    row = {}
    for r in RUNGS:
        row[r] = lf_root(r, L, M)
    row["A'"] = lf_root("A", L, M, column=True)
    LF[L] = row
    print(f"  {L:3d} {M:6d} {lo_dec(Xs):9.3f} {lo_dec(Xd1):8.3f} {lo_dec(Xd0):8.3f} | " +
          " ".join(f"{lo_dec(row[k]):8.3f}" for k in ["A", "A'", "B", "C", "D", "E", "F", "G"]))

print("-" * 130)
print("FLOORS: max(small-field row, large-field row), optimum over L (decades, lower endpoints)")
for r in ["A", "A'", "B", "C", "D", "E", "F", "G"]:
    for label, idx in (("small", 1), ("PS q1=1", 2), ("PS q1=0", 3)):
        best = None
        for L, row in LF.items():
            v = max(lo_dec(SMALL[L][idx]), lo_dec(row[r]), lo_dec(t15lf2))
            if best is None or v < best[0]:
                best = (v, L, SMALL[L][0], lo_dec(SMALL[L][idx]), lo_dec(row[r]))
        print(f"  rung {r:3s} with {label:8s}: log10 beta >= {best[0]:.5f} at L = {best[1]}, M = {best[2]}"
              f"  (small row {best[3]:.3f}, large-field row {best[4]:.3f})")

# ================================================================ details at L = 4, 5, 12
for L in (4, 5, 12):
    M = SMALL[L][0]
    print("-" * 130)
    print(f"DETAIL L = {L}, M = {M}")
    for r in RUNGS:
        X = iv.mpf(LF[L][r].b)
        K, Kc, det = rung_K(r, L, M, X)
        parts = []
        for k in ("P", "PJ1", "PLP", "Ppin", "R", "N", "ell", "cF", "R6", "N8", "N9"):
            if k in det and det[k] is not None:
                parts.append(f"{k} = {mpmath.nstr(det[k].a, 6)}")
        print(f"  rung {r}: X = {mpmath.nstr(X.a, 10)} ({lo_dec(LF[L][r]):.4f} decades): " + ", ".join(parts))
print("=" * 130)
