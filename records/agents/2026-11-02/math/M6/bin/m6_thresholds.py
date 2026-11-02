"""M6 instrument: the thresholds that Balaban's printed inequalities impose on gamma, certified with mpmath.iv.

Every quantity is an interval with outward rounding.  A root X* of a function f (log-form of a constraint) is certified by
bisection: f(lo) and f(hi) are interval-evaluated and must have strictly opposite signs (the interval for f(lo) entirely of
one sign, the interval for f(hi) entirely of the other), so the root lies in [lo, hi].  X = log(1/gamma^2) = log(beta_B);
the script prints log10(beta_B) = X / ln 10 as an interval.

Run: python -E -P bin/m6_thresholds.py > rec/thresholds_run.<date>.txt
"""
import mpmath
from mpmath import iv, mpf

mpmath.mp.dps = 50
iv.dps = 50

LN10 = iv.log(iv.mpf(10))


def lg10(x):
    return x / LN10


def sgn(v):
    """+1 if the interval v is entirely > 0, -1 if entirely < 0, 0 if it straddles 0."""
    if v.a > 0:
        return 1
    if v.b < 0:
        return -1
    return 0


def root(f, lo, hi, iters=200, tol=mpf("1e-30")):
    """Certified bisection: requires sgn(f(lo)) * sgn(f(hi)) == -1; returns (lo, hi) bracketing the unique sign change."""
    flo, fhi = sgn(f(iv.mpf(lo))), sgn(f(iv.mpf(hi)))
    assert flo * fhi == -1, ("no certified sign change", lo, hi, f(iv.mpf(lo)), f(iv.mpf(hi)))
    lo, hi = mpf(lo), mpf(hi)
    for _ in range(iters):
        if hi - lo < tol:
            break
        mid = (lo + hi) / 2
        s = sgn(f(iv.mpf(mid)))
        if s == 0:
            break  # cannot decide the sign at mid: keep the certified bracket
        if s == flo:
            lo = mid
        else:
            hi = mid
    return lo, hi


def show(name, lo, hi):
    X = iv.mpf([lo, hi])
    print(f"{name}: X* = log(beta) in [{mpmath.nstr(lo, 12)}, {mpmath.nstr(hi, 12)}];"
          f" log10(beta) in [{mpmath.nstr(lg10(X).a, 10)}, {mpmath.nstr(lg10(X).b, 10)}]")


print("=" * 100)
print("M6 thresholds (mpmath %s, iv.dps = %d)" % (mpmath.__version__, iv.dps))

# ---------------------------------------------------------------- (K1) CMP 116 (1.27): 8*12^3*exp(-(k1-1)/2) <= 1
k1_min = 1 + 2 * iv.log(iv.mpf(8 * 12 ** 3))
print(f"(K1) kappa1_min = 1 + 2 ln(8*12^3 = {8*12**3}) in [{mpmath.nstr(k1_min.a, 15)}, {mpmath.nstr(k1_min.b, 15)}]")
k1_128 = 2 + 16 * iv.log(iv.mpf(24))
print(f"     (1.28) read at d_k(Y)=1: kappa1 >= 2 + 16 ln 24 in [{mpmath.nstr(k1_128.a, 15)}, {mpmath.nstr(k1_128.b, 15)}]")

# ---------------------------------------------------------------- (K2) kappa1 >= 16(1-2 delta) kappa, delta = (1-2/L)/10
for L in (3, 5, 7):
    delta = (1 - mpmath.mpf(2) / L) / 10
    fac = 16 * (1 - 2 * delta)
    print(f"(K2) L = {L}: delta = {mpmath.nstr(delta, 12)}, kappa1 >= {mpmath.nstr(fac, 15)} * kappa")

# ---------------------------------------------------------------- (3.1) the CMP 116 chain
def chain(C2, k1, kappa=1, gamma2=1, P=1):
    return 2 * C2 * k1 + iv.log(iv.mpf(80) * kappa / gamma2) + 2 * iv.log(iv.mpf(P))

print("-" * 100)
print("(3.1) log beta_B >= 2 C2 kappa1 + log(80 kappa/gamma2) + 2 log P   [P = 2 E0 C1 M^q/(alpha4 alpha6)]")
cases = [
    ("literal: C2=56, kappa1=kappa1_min(1.27), kappa=1, gamma2=1, P=1", iv.mpf(56), k1_min, 1),
    ("decimal reading C2=7.8, kappa1=kappa1_min, kappa=1", iv.mpf("7.8"), k1_min, 1),
    ("(1.28) reading kappa1=2+16 ln 24, C2=56, kappa=1", iv.mpf(56), k1_128, 1),
    ("(K2) with kappa=3 at L=3: kappa1=(224/15)*3, C2=56", iv.mpf(56), iv.mpf(224) / 15 * 3, 3),
]
for name, C2, k1, kap in cases:
    v = chain(C2, k1, kappa=kap)
    print(f"  {name}: log beta_B >= [{mpmath.nstr(v.a, 10)}, {mpmath.nstr(v.b, 10)}]; "
          f"log10 beta_B >= [{mpmath.nstr(lg10(v).a, 10)}, {mpmath.nstr(lg10(v).b, 10)}]")

# ---------------------------------------------------------------- the trade-off if (1.27) is relaxed (kappa1 free)
#   minimise h(k1) = C2 k1 + 13824 exp(-(k1-1)/2) : the 2^(#cubes)-type entropy absorbed as a constant instead
C2 = mpmath.mpf(56)
k1_star = 1 + 2 * mpmath.log(13824 / (2 * C2))
h_star = C2 * k1_star + 13824 * mpmath.exp(-(k1_star - 1) / 2)
print(f"  relaxed (1.27): argmin k1 = {mpmath.nstr(k1_star, 10)}, min exponent C2 k1 + 13824 e^(-(k1-1)/2) = {mpmath.nstr(h_star, 10)};"
      f" log10 beta_B >= {mpmath.nstr(2 * h_star / mpmath.log(10), 10)} (before (K2))")
k1_K2 = mpmath.mpf(224) / 15
h_K2 = C2 * k1_K2 + 13824 * mpmath.exp(-(k1_K2 - 1) / 2)
print(f"  relaxed (1.27) but (K2) at kappa=1, L=3 (kappa1 >= 224/15): exponent {mpmath.nstr(h_K2, 10)};"
      f" log10 beta_B >= {mpmath.nstr(2 * h_K2 / mpmath.log(10), 10)}")

# ---------------------------------------------------------------- the large-field definition: g A0 X^p0 < 2
print("-" * 100)
print("Large-field threshold eps(g) = g A0 (log g^-2)^p0 (CMP 119 (2.4)); X = log g^-2, g = e^(-X/2)")
for p0 in (10, 12, 13):
    Xmax = 2 * p0
    epsmax = (mpmath.mpf(2 * p0) / mpmath.e) ** p0
    print(f"  p0 = {p0}: eps(g) is maximal at X = 2 p0 = {Xmax}, eps_max = A0 (2p0/e)^p0 = A0 * {mpmath.nstr(epsmax, 8)}")
    for A0 in (1, 10):
        f = lambda X, p0=p0, A0=A0: iv.log(iv.mpf(A0)) - X / 2 + p0 * iv.log(X) - iv.log(iv.mpf(2))
        lo, hi = root(f, Xmax, 2000)
        show(f"   vacuity eps(g) >= 2 ends (largest root), A0 = {A0}", lo, hi)
        if A0 == 1:
            # the small root (eps < 2 again only for g near 1)
            lo2, hi2 = root(f, mpf("0.01"), Xmax)
            show(f"   vacuity begins (smallest root), A0 = {A0}", lo2, hi2)

# ---------------------------------------------------------------- the complete-model variant of (K4): delta_k in place of eps1
print("-" * 100)
print("Complete-model variant: g A1 X^p0 e^(C2 kappa1) P <= 1  (CMP 119 (1.8) fluctuation threshold in CMP 116 (2.28))")
for p0 in (10, 13):
    f = lambda X, p0=p0: -X / 2 + p0 * iv.log(X) + 56 * k1_min
    lo, hi = root(f, 100, 20000)
    show(f"  p0 = {p0}, A1 = P = 1, C2 = 56, kappa1 = kappa1_min", lo, hi)

# ---------------------------------------------------------------- LFR II (1.9): O(1) M^6 R eps <= gamma0/(2d(100M)^(d+1))
print("-" * 100)
print("LFR II (1.9): g A0 X^(p0+r) M^6 * 2d (100M)^(d+1) <= gamma0   (R_k >= X^r, O(1) = A0 = gamma0 = 1, d = 4)")
d = 4
for p0, r in ((10, 2), (13, 2)):
    for M in (27, 729):
        K = iv.log(iv.mpf(2 * d)) + 6 * iv.log(iv.mpf(M)) + (d + 1) * iv.log(iv.mpf(100 * M))
        f = lambda X, p0=p0, r=r, K=K: -X / 2 + (p0 + r) * iv.log(X) + K
        lo, hi = root(f, 2 * (p0 + r), 50000)
        show(f"  p0 = {p0}, r = {r}, M = {M}", lo, hi)

# ---------------------------------------------------------------- LFR II (1.88) pinched against LFR I (1.87)
print("-" * 100)
print("LFR II (1.88) A0 X^p0 >= 1.5 (100M)^d R^(d+2) pinched against LFR I (1.87) g A0 X^p0 B M^6 <= 1 (B = O(1) = 1, r = 2)")
for M in (27, 729):
    for Lb in (3,):
        # R < L X^r (R is the smallest power of L >= X^r): use R >= X^r for a LOWER bound on the threshold
        K = iv.log(iv.mpf("1.5")) + d * iv.log(iv.mpf(100 * M)) + 6 * iv.log(iv.mpf(M))
        f = lambda X, K=K: -X / 2 + (d + 2) * 2 * iv.log(X) + K
        lo, hi = root(f, 30, 50000)
        show(f"  M = {M}", lo, hi)

# ---------------------------------------------------------------- the architecture-free floor
print("-" * 100)
print("Floor: free-field plaquette angle, Shearer radius of the plaquette-adjacency graph, chi^2_3 tail")
# equipartition: sum_p <(dA)_p^2>/e^2 = rank(d_1) = dV - (V-1) - d on the torus; per plaquette -> 2/d
for V in (3 ** 4, 10 ** 4, 10 ** 8):
    per = mpmath.mpf(d * V - (V - 1) - d) / (mpmath.mpf(d * (d - 1) * V) / 2)
    print(f"  torus V = {V}: <(theta^a_p)^2>/g_B^2 = rank(d_1)/#plaquettes = {mpmath.nstr(per, 15)}  (V -> oo: 2/d = {2/d})")
print("  so per colour component Var(theta^a_p) = g_B^2/2 = 1/(2 beta); <1 - 1/2 Tr U_p> = 3/(4 beta) + O(beta^-2)")
Delta = 2 * (d - 1) * 4 - 4  # 4 links per plaquette, each in 2(d-1) plaquettes, minus the plaquette itself on each link
assert Delta == 20
zc = iv.mpf(Delta - 1) ** (Delta - 1) / iv.mpf(Delta) ** Delta
print(f"  plaquette-adjacency degree Delta = {Delta}; Shearer radius z_c = 19^19/20^20 in [{mpmath.nstr(zc.a, 12)}, {mpmath.nstr(zc.b, 12)}]")


def chi3_tail(t):
    # P(chi^2_3 >= t) = erfc(sqrt(t/2)) + sqrt(2 t/pi) e^{-t/2}
    s = iv.sqrt(t / 2)
    return iv.erfc(s) + iv.sqrt(2 * t / iv.pi) * iv.exp(-t / 2) if hasattr(iv, "erfc") else None


def chi3_tail_mp(t):
    s = mpmath.sqrt(t / 2)
    return mpmath.erfc(s) + mpmath.sqrt(2 * t / mpmath.pi) * mpmath.exp(-t / 2)


# iv has no erfc: certify the root with mp at high precision on both sides, bracket checked with a margin
zc_mid = mpmath.mpf(19) ** 19 / mpmath.mpf(20) ** 20
g = lambda t: chi3_tail_mp(t) - zc_mid
lo, hi = mpmath.mpf(5), mpmath.mpf(20)
assert g(lo) > 0 and g(hi) < 0
for _ in range(200):
    mid = (lo + hi) / 2
    if g(mid) > 0:
        lo = mid
    else:
        hi = mid
t_star = (lo + hi) / 2
p_min = mpmath.sqrt(t_star / 2)
print(f"  chi^2_3 tail = z_c at t* = {mpmath.nstr(t_star, 15)} (mp.dps = 50 bisection, bracket width {mpmath.nstr(hi-lo, 3)})")
print(f"  p_min = sqrt(t*/2) = {mpmath.nstr(p_min, 15)}   [threshold eps = p_min g_B = p_min / sqrt(beta)]")
for beta in (2, 3, 4, 5, 8, 10):
    eps = p_min / mpmath.sqrt(beta)
    ang = 2 * mpmath.asin(eps / 2) * 180 / mpmath.pi if eps < 2 else mpmath.inf
    print(f"  beta = {beta:>2}: required small-field radius eps = {mpmath.nstr(eps, 8)}  (rotation angle {mpmath.nstr(ang, 6)} deg)")
for a, lab in ((mpmath.sqrt(2), "sqrt 2 (single-plaquette convexity, angle 90 deg)"), (1, "1"), (mpmath.mpf("0.5"), "0.5"),
               (mpmath.mpf("0.3"), "0.3"), (mpmath.mpf("0.1"), "0.1"), (mpmath.mpf("0.01"), "0.01")):
    print(f"  small-field radius a = {lab}: floor beta >= (p_min/a)^2 = {mpmath.nstr((p_min / a) ** 2, 8)}")
print("=" * 100)
