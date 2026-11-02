"""M8 C3: the certified numbers of the cone inequality (2.3) and the large-field/convexity floor, with mpmath.iv (outward rounding).

Certified here: c1(L) = 8 b0 ln L, b0 = 11 C_A/(48 pi^2); K2(L) = 32 b1 ln L, b1 = (34/3) C_A^2/(16 pi^2)^2 (SU(2): C_A = 2);
Shearer's z_c(D) = (D-1)^(D-1)/D^D; the chi^2_3 upper quantile q(z) (P(chi^2_3 >= q) = z), certified by bisection on the closed form
P(chi^2_3 >= t) = erfc(sqrt(t/2)) + sqrt(2t/pi) exp(-t/2); the floor beta >= K q / b^2; and the remainder budget
K3max(beta) = beta^2 (eps - A1/beta) for the perturbative O(1/beta) constant A1 (A1 = S'K_r + K2, or K2 alone when the one-loop
fixed-point correction is computed) and eps = c1 - delta_min.
The inputs K_var, K_link, b are READINGS from records c1_*, c1b_*, h6_* (labelled at their strength in WORK.md).

Run: python -E -P bin/m8_c3_table.py > rec/c3_table.<date>.txt
"""
import mpmath
from mpmath import iv, mpf

iv.dps = 40
PI = iv.pi


def lo(x):
    return mpmath.mpf(x.a.a)


def hi(x):
    return mpmath.mpf(x.b.b)


def s(x, n=10):
    return "[%s, %s]" % (mpmath.nstr(lo(x), n), mpmath.nstr(hi(x), n))


def erf_iv(x, N=120):
    """erf by its Taylor series in interval arithmetic; the alternating tail after the terms decrease is bounded by the first
    omitted term (valid for 0 <= x <= 5, N = 120: the terms decrease monotonically from n ~ x^2 on)."""
    x = iv.mpf(x)
    tot = iv.mpf(0)
    term = x
    for n in range(N):
        tot += term / (2 * n + 1)
        term = -term * x * x / (n + 1)
    rem = abs(term) / (2 * N + 1)
    tot += iv.mpf([-hi(rem), hi(rem)])
    return 2 / iv.sqrt(PI) * tot


def tail3(t):
    t = iv.mpf(t)
    return 1 - erf_iv(iv.sqrt(t / 2)) + iv.sqrt(2 * t / PI) * iv.exp(-t / 2)


def quantile3(z, lo=0.1, hi=60.0):
    z = iv.mpf(z)
    lo, hi = mpf(lo), mpf(hi)
    for _ in range(140):
        mid = (lo + hi) / 2
        v = tail3(mid) - z
        if v.a > 0:
            lo = mid
        elif v.b < 0:
            hi = mid
        else:
            break
    return iv.mpf([lo, hi])


CA = 2
b0 = iv.mpf(11) * CA / (48 * PI ** 2)
b1 = iv.mpf(34) / 3 * CA ** 2 / (16 * PI ** 2) ** 2
print("SU(2): b0 = %s ; b1 = %s" % (s(b0, 12), s(b1, 12)))
for L in (2, 3):
    c1 = 8 * b0 * iv.log(L)
    K2 = 32 * b1 * iv.log(L)
    print("L = %d: c1 = 8 b0 ln L = %s ; K2 = 32 b1 ln L = %s (two-loop beta-units coefficient per step)" % (L, s(c1, 12), s(K2, 12)))

for D in (18, 20):
    zc = iv.mpf(D - 1) ** (D - 1) / iv.mpf(D) ** D
    q = quantile3(zc / 2)
    q1 = quantile3(zc)
    print("Shearer z_c(%d) = %s ; chi2_3 quantile at z_c/2: %s ; at z_c: %s" % (D, s(zc, 10), s(q, 10), s(q1, 10)))

zc18 = iv.mpf(17) ** 17 / iv.mpf(18) ** 18
q18 = quantile3(zc18 / 2)
zc20 = iv.mpf(19) ** 19 / iv.mpf(20) ** 20
q20 = quantile3(zc20 / 2)
print()
print("FLOORS beta >= K q / b^2 (link-angle domain: K = K_link, D = 18; plaquette-angle domain: K = K_var = 1/2, D = 20):")
for label, K, q in (("link, L=2 (K_link = 0.13145 reading)", iv.mpf('0.13145'), q18),
                    ("link, L=3 (K_link = 0.10987 reading)", iv.mpf('0.10987'), q18),
                    ("plaquette, K_var = 1/2 (PROVED upper bound)", iv.mpf('0.5'), q20)):
    row = []
    for b in ('0.033', '0.063', '0.1', '0.2', '0.3', '0.5', '0.9246'):
        row.append("b=%s: %s" % (b, mpmath.nstr(hi(K * q / iv.mpf(b) ** 2), 6)))
    print("  %-46s " % label + " ; ".join(row))

print()
print("REMAINDER BUDGET K3max(beta) = beta^2 (eps - A1/beta), eps = c1 - delta_min, delta_min = 0.05:")
for L in (2, 3):
    c1 = 8 * b0 * iv.log(L)
    K2 = 32 * b1 * iv.log(L)
    eps = c1 - iv.mpf('0.05')
    for A1lab, A1 in (("A1 = K2 (one-loop FP correction computed)", K2), ("A1 = 2 + K2 (S'K_r = 2, ESTIMATED)", 2 + K2),
                      ("A1 = 6 + K2 (S'K_r = 6, pessimistic)", 6 + K2)):
        row = []
        for beta in (10, 20, 50, 100, 1000, 10000):
            v = iv.mpf(beta) ** 2 * (eps - A1 / beta)
            row.append("%d: %s" % (beta, mpmath.nstr(lo(v), 5)))
        print("  L=%d, eps = %s, %-44s " % (L, mpmath.nstr(lo(eps), 6), A1lab) + " | ".join(row))
print()
print("STEP COUNTS (one loop): (1e4 - 5)/c1:")
for L in (2, 3):
    c1 = 8 * b0 * iv.log(L)
    n = (iv.mpf(10000) - 5) / c1
    print("  L = %d: %s steps" % (L, s(n, 8)))
