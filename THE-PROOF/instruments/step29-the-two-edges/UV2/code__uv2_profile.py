"""UV2 run U1: M6d's proved-route M and floors recomputed with Theorem B (the kappa^{-1/2} rate of (QGQ*)^{-1}) and the walk branch
(WORK.md sections 3.3, 3.4, 5).  M6d's functions are taken VERBATIM from the byte-identical copy code/m6d_profile_d_copy.py (everything
above its first banner print).  Certified with mpmath.iv as M6d (M = ceiling of the upper endpoint).
Run: python -E -P code/uv2_profile.py > rec/profile_U1.2026-11-02a.txt
"""
import math, os
here = os.path.dirname(os.path.abspath(__file__))
_src = open(os.path.join(here, "m6d_profile_d_copy.py"), encoding="utf-8").read()
exec(_src.split('print("=" * 110)')[0])          # sgn, root, lo_dec, cells, packing, R_floor, kappa_fl, M_delta, small_X, A2, T15LF2, KJ, J_B_ar, rows, c1, M_proved

E = iv.exp(iv.mpf(1))
DELTA0 = "0.5"
K0 = iv.mpf(1)                                  # reference point C*C_S*C'_S^2 = 1 (M6d section 17.4)
ALPHAS = [f"{a / 100:.2f}" for a in range(30, 96)]


def C1p(L):
    return 256 * (2 + 2 * D) * iv.mpf(L) ** (6 + D) * iv.mpf(12) ** 4


def mu_star(L, alpha):
    c1a, _ = c1(alpha, DELTA0)
    r = (E / 2) / iv.sqrt(C1p(L) * K0 * c1a)
    return (1 - iv.mpf(alpha)) * iv.mpf(DELTA0) * r / (1 + r)


def best_mu(L):
    best = None
    for a in ALPHAS:
        m = mu_star(L, a)
        if best is None or m.a > best[1].a:
            best = (a, m)
    return best


def M_W(L):
    best = None
    for a in ALPHAS:
        c1a, _ = c1(a, DELTA0)
        v = 4 * K0 * c1a * C1p(L) / (E * (1 - iv.mpf(a)) * iv.mpf(DELTA0))
        if best is None or v.b < best[1].b:
            best = (a, v)
    return best


def M_from_delta(L, dl):
    """least integer M with (M1)-(M3) at decay rate dl (an iv), as M6d's M_delta (which takes a string)."""
    kap = kappa_fl(L)
    ku = 2 * kap / L
    a = ku + LN4
    m1 = int(mpmath.ceil(((12 / iv.sqrt(iv.mpf(2))) * a / dl).b))
    m3 = int(mpmath.ceil((kap / dl).b))
    lo = max(m1, m3, 2)

    def ok(M):
        f = dl * iv.mpf(M) / 3 - 1 - 2 * kap - 4 * iv.log(iv.mpf(L) * iv.mpf(M))
        return f.b >= 0
    hi = lo
    while not ok(hi):
        hi *= 2
    if hi == lo:
        return lo, m1
    a_, b_ = hi // 2, hi
    while b_ - a_ > 1:
        m = (a_ + b_) // 2
        if ok(m):
            b_ = m
        else:
            a_ = m
    return max(lo, b_), m1


def lg(x):
    return math.log10(x)


print("=" * 118)
print(f"UV2 run U1 (mpmath {mpmath.__version__}, iv.dps = {iv.dps}); d = {D}, delta0 = {DELTA0}, K0 = 1, C1' = 256(2+2d)L^(6+d) 12^4")
print("-" * 118)
Ls = [2] + list(range(3, 21)) + [24, 30, 40]
keys = ("B_ar", "C", "D(q1=1)", "D(q1=0)")
opt = {s: {k: None for k in keys} for s in ("M6d_M1", "old_full", "new_proved", "new_rate_only")}
for L in Ls:
    kap = kappa_fl(L)
    d_old = iv.mpf(DELTA0) / (16 * c1("0.5", DELTA0)[0] * iv.mpf(L) ** 2 * C1p(L))
    M_M6d = int(mpmath.ceil(M_proved(L).b))
    M_oldfull, _ = M_from_delta(L, d_old)
    am, mu = best_mu(L)
    M_rate, M_rate_m1 = M_from_delta(L, mu)
    aw, MWv = M_W(L)
    M_Wi = int(mpmath.ceil(MWv.b))
    M_new = max(M_rate, M_Wi)
    Ms = {"M6d_M1": M_M6d, "old_full": M_oldfull, "new_proved": M_new, "new_rate_only": M_rate}
    rr = {s: rows(L, M) for s, M in Ms.items()}
    for s in Ms:
        for k in keys:
            v = rr[s][k]
            if L >= 3 and (opt[s][k] is None or v < opt[s][k][0]):
                opt[s][k] = (v, L, Ms[s])
    print(f"L={L:2d}: mu*={mpmath.nstr(mu.a, 6)} (alpha={am}; old CT rate {mpmath.nstr(d_old.a, 6)}, gain x{mpmath.nstr((mu / d_old).a, 6)}); "
          f"log10 M: M6d(M1) {lg(M_M6d):.4f} | old(M1-M3) {lg(M_oldfull):.4f} | rate(M1) {lg(M_rate_m1):.4f} rate(M1-M3) {lg(M_rate):.4f} | "
          f"walk {lg(M_Wi):.4f} (alpha={aw}) | new proved {lg(M_new):.4f}")
    print("        rows (decades): " + " || ".join(f"{s}: " + ", ".join(f"{k} {rr[s][k]:.3f}" for k in keys) for s in Ms))
print("-" * 118)
print("OPTIMA over L in {3..20, 24, 30, 40} (M6d's list; L = 2 printed above, outside it):")
for s in opt:
    print(f"  {s:>14}: " + "; ".join(f"{k} {v:.4f} (L={L}, log10 M={lg(M):.3f})" for k, (v, L, M) in opt[s].items()))
print("=" * 118)
