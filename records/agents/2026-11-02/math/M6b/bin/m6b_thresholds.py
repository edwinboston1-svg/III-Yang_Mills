"""M6b instrument, run a: the threshold of Balaban's induction after LEMMA RD, certified with mpmath.iv (outward rounding).

(A) M6's chain with the C2*kappa1 term removed (the run requested), every other row recomputed as M6 did.
(B) the BASE ROW: Lemma 1's relocalized history terms live on Y > box0 = (box~)^5 (11^4 M-cubes); in Balaban's output format
    (decay e^{-(1-2 delta) kappa d_k(Y)}) the constant must carry e^{(1-2 delta) kappa d_k(box0)}; d_k(box0) >= (11^4-16)/16
    (Lemma MS, Minkowski-Steiner).  Also Balaban's own printed chain with Lemma 1's constant carried.
(C) the PAGE'S FLOOR on kappa: p. 9 uses (1.26) at rate delta*kappa, delta = (1-2/L)/10 (p. 21); Lemma F: the sum diverges
    below ln c3, c3 = #connected induced subgraphs of Q3 containing a fixed vertex (computed here by brute force).
Roots are certified by bisection with interval-evaluated signs (M6's root()).  X = log(beta) = log(1/gamma^2).

Run: python -E -P bin/m6b_thresholds.py > rec/thresholds_run.2026-11-02a.txt
"""
import hashlib
import itertools
from fractions import Fraction

import mpmath
from mpmath import iv, mpf

mpmath.mp.dps = 50
iv.dps = 50
LN10 = iv.log(iv.mpf(10))


def lg10(x):
    return x / LN10


def sgn(v):
    if v.a > 0:
        return 1
    if v.b < 0:
        return -1
    return 0


def root(f, lo, hi, iters=300, tol=mpf("1e-30")):
    flo, fhi = sgn(f(iv.mpf(lo))), sgn(f(iv.mpf(hi)))
    assert flo * fhi == -1, ("no certified sign change", lo, hi)
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
    return lo, hi


def rng(v):
    return f"[{mpmath.nstr(v.a, 12)}, {mpmath.nstr(v.b, 12)}]"


def show_logbeta(name, v):
    print(f"{name}: log beta >= {rng(v)}; log10 beta >= {rng(lg10(v))}")


def show_root(name, lo, hi):
    X = iv.mpf([lo, hi])
    print(f"{name}: X* in [{mpmath.nstr(lo, 12)}, {mpmath.nstr(hi, 12)}]; log10 beta in {rng(lg10(X))}")
    return lg10(X)


print("=" * 110)
print("M6b run a (mpmath %s, iv.dps = %d)" % (mpmath.__version__, iv.dps))

# ------------------------------------------------------------------------------------------------ provenance of the pages
for name, path, want in (("CMP 116", r"C:\Users\Edwin Boston\Downloads\Download (3).pdf", "ee39523a0f7b83af"),
                         ("CMP 109", r"C:\Users\Edwin Boston\Downloads\Download (1).pdf", "1c2d2e500fd1e6a1")):
    h = hashlib.sha256(open(path, "rb").read()).hexdigest()[:16]
    print(f"sha256[:16] {name} = {h}  (M3b section 0: {want})  {'EQUAL' if h == want else 'DIFFERENT'}")

# ------------------------------------------------------------------------------------------------ Lemma F: c_{n} by brute force
def connected_containing(n, v0=0):
    """Number of vertex subsets of the n-cube graph Q_n that contain v0 and induce a connected subgraph; by size."""
    N = 1 << n
    by_size = {}
    for mask in range(1 << N):
        if not (mask >> v0) & 1:
            continue
        # BFS inside mask from v0
        seen = 1 << v0
        stack = [v0]
        while stack:
            u = stack.pop()
            for b in range(n):
                w = u ^ (1 << b)
                if (mask >> w) & 1 and not (seen >> w) & 1:
                    seen |= 1 << w
                    stack.append(w)
        if seen == mask:
            k = bin(mask).count("1")
            by_size[k] = by_size.get(k, 0) + 1
    return by_size


for n in (2, 3):
    bs = connected_containing(n)
    print(f"Lemma F: c_{n} = #connected induced subgraphs of Q_{n} containing a fixed vertex = {sum(bs.values())};"
          f" by size {dict(sorted(bs.items()))}")
c3 = sum(connected_containing(3).values())
ln_c3 = iv.log(iv.mpf(c3))
print(f"  ln c3 = ln {c3} in {rng(ln_c3)}")

# ------------------------------------------------------------------------------------------------ Lemma MS
d0 = Fraction(11 ** 4 - 16, 16)
print(f"Lemma MS: d_k(box~^5) >= (11^4 - 16)/16 = {d0} = {float(d0)};  box~^4: {Fraction(9**4-16,16)} ;"
      f" box~^2: {Fraction(5**4-16,16)};  Balaban (2.30): 11^4/24 = {float(Fraction(11**4,24)):.4f}")
D0 = iv.mpf(d0.numerator) / d0.denominator

k1_min = 1 + 2 * iv.log(iv.mpf(13824))
print(f"kappa1_min (CMP 116 (1.27)) in {rng(k1_min)}")
ln80 = iv.log(iv.mpf(80))


def one_minus_2delta(L):
    if L == "inf":
        return iv.mpf(4) / 5
    return 1 - iv.mpf(2) * (1 - iv.mpf(2) / L) / 10


def delta_of(L):
    if L == "inf":
        return iv.mpf(1) / 10
    return (1 - iv.mpf(2) / L) / 10


# ================================================================================================= (A) the requested run
print("-" * 110)
print("(A) M6's chain with C2*kappa1 -> 0 (kappa = 1, gamma2 = 1, P = 1 unless stated)")
kap = iv.mpf(1)
A1 = 10 * kap + iv.log(80 * kap)
show_logbeta("A1 T11' (2.28)+(2.31), C2k1 -> 0", A1)
A2 = A1 + 2 * 8 * iv.log(iv.mpf(27))
show_logbeta("A2 T11' with M^q, q = 8, M = 27 (P >= M^8)", A2)
for p0 in (10, 13):
    f = lambda X, p0=p0: -X / 2 + p0 * iv.log(X) + 5 * kap
    lo, hi = root(f, 2 * p0, 20000)
    show_root(f"A3 T13' complete model, p0 = {p0}, e^(5kappa) carried, C2k1 -> 0", lo, hi)
    f = lambda X, p0=p0: -X / 2 + p0 * iv.log(X)
    lo, hi = root(f, 2 * p0, 20000)
    show_root(f"   T13' in M6's form (no e^(5kappa)), p0 = {p0}", lo, hi)
A4 = 2 * 24 * kap + ln80
show_logbeta("A4 T14' LFR II (1.93) with T11', C2k1 -> 0", A4)
rowsA = {}
for p0 in (10, 13):
    f = lambda X, p0=p0: -X / 2 + p0 * iv.log(X) - iv.log(iv.mpf(2))
    lo, hi = root(f, 2 * p0, 2000)
    rowsA[f"T15 p0={p0}"] = show_root(f"A5 T15 large-field definition eps(g) < 2, p0 = {p0}, A0 = 1", lo, hi)
d = 4
for M in (27, 81, 243, 729):
    K = iv.log(iv.mpf("1.5")) + d * iv.log(iv.mpf(100 * M)) + 6 * iv.log(iv.mpf(M))
    f = lambda X, K=K: -X / 2 + (d + 2) * 2 * iv.log(X) + K
    lo, hi = root(f, 30, 50000)
    rowsA[f"T17 M={M}"] = show_root(f"A6 T17 LFR II (1.88) x LFR I (1.87), r = 2, M = {M}", lo, hi)
for p0 in (10, 13):
    for M in (27, 81, 243, 729):
        K = iv.log(iv.mpf(2 * d)) + 6 * iv.log(iv.mpf(M)) + (d + 1) * iv.log(iv.mpf(100 * M))
        f = lambda X, p0=p0, K=K: -X / 2 + (p0 + 2) * iv.log(X) + K
        lo, hi = root(f, 2 * (p0 + 2), 50000)
        rowsA[f"T18 p0={p0} M={M}"] = show_root(f"A7 T18 LFR II (1.9), p0 = {p0}, r = 2, M = {M}", lo, hi)
best = max(rowsA.items(), key=lambda kv: kv[1].a if kv[0].endswith("M=27") or kv[0].startswith("T15 p0=10") else -1)
print(f"  (A) bottleneck among the rows at their most favourable parameters (p0 = 10, M = 27): T18 p0=10 M=27 = "
      f"{rng(rowsA['T18 p0=10 M=27'])}; next T17 M=27 = {rng(rowsA['T17 M=27'])}; T11' with M^8: {rng(lg10(A2))}")

# ================================================================================================= (B) the base row, kappa = 1
print("-" * 110)
print("(B) the base row (Lemma 1's relocalization on box~^5) at kappa = 1")
for L in (3, "inf"):
    om = one_minus_2delta(L)
    k1 = k1_min if L == 3 else k1_min  # (1.27) floor; (K2) 16(1-2delta) kappa < k1_min at kappa = 1
    k1 = iv.mpf([max(k1.a, (16 * om * kap).a), max(k1.b, (16 * om * kap).b)])
    C2k1_L1 = 16 * k1 + k1 * D0 / 16 + om * kap * D0
    C2k1_L2 = 56 * k1
    lit = 2 * C2k1_L1 + 10 * kap + iv.log(80 * kap)
    print(f"  L = {L}: 1-2delta = {rng(om)}; kappa1 = {rng(k1)}; Lemma 1 needs C2k1 >= {rng(C2k1_L1)}, Lemma 2 (M6) 56k1 = {rng(C2k1_L2)}")
    show_logbeta(f"  B2 Balaban's printed chain with Lemma 1 carried, L = {L}", lit)
    base = 2 * om * kap * D0 + 10 * kap + iv.log(80 * kap)
    show_logbeta(f"  B3 Lemma RD in Balaban's format (base row), L = {L}", base)

# ================================================================================================= (C) the page's floor on kappa
print("-" * 110)
print("(C) the page's floor kappa >= ln c3 / delta, delta = (1 - 2/L)/10")
for L in (3, 5, 7, 9, "inf"):
    om, de = one_minus_2delta(L), delta_of(L)
    kmin = ln_c3 / de
    C4 = 10 * kmin + iv.log(80 * kmin)
    C3 = 2 * om * kmin * D0 + C4
    k1 = 16 * om * kmin
    assert k1.a > k1_min.b
    C2k1 = 16 * k1 + k1 * D0 / 16 + om * kmin * D0
    C5 = 2 * C2k1 + C4
    print(f"  L = {L}: kappa_min in {rng(kmin)}")
    show_logbeta(f"    C3 base row at kappa_min", C3)
    show_logbeta(f"    C4 e^(5 kappa) row alone (A1 at kappa_min)", C4)
    show_logbeta(f"    C5 Balaban's printed chain at its own floor (kappa1 = 16(1-2delta)kappa)", C5)
print("=" * 110)
