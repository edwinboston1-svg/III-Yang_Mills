"""M8b CERTIFIED TABLES (mpmath interval arithmetic, 50 digits, outward rounding; every printed number an interval or its rounded-out end).

(1) THE STEP TOLERANCES AGAINST L (SU(2), beta = 4/g^2):  c1 = 8 b0 ln L, K2 = 32 b1 ln L, eps = c1 - delta_min (delta_min = 0.05);
    RT-centred A1 = K2 (Theorem A2); tree-centred A1 = S'K_r + K2 with S'K_r = 2 (M8's ESTIMATE, printed for comparison only);
    beta*(K3) = [A1 + sqrt(A1^2 + 4 eps K3)]/(2 eps) for K3 = 1, 10, 100, 1000.
    SU(N) (beta = 2N/g^2): c1 = 4N b0 ln L, K2 = 8N^2 b1 ln L, b0 = 11 N/(48 pi^2), b1 = (34/3) N^2/(16 pi^2)^2; K2/c1 = 2N b1/b0.
(2) THE LARGE-FIELD PRICES: Shearer's z_c(20) = 19^19/20^20 (hard-core single events on the 20-regular plaquette graph); the animal
    bound mu <= e(Delta - 1) = 19 e for connected plaquette sets (sharing a link) and the percolation price z_perc = 1/(19 e); the
    Kotecky-Preiss price z_KP = max_x x exp(-21 x/(1 - 19 e x)) for hard-core connected polymers with activity z^{|X|}
    (incompatibility neighbourhood <= 21 |X|).
(3) THE FREE-ENERGY GAP C(beta) of Lemma CB-0: per site,
       U1 = 3 ln c(beta),  c(t) = 2 e^{-t} I_1(t)/t  (axial gauge, the (i,rho) plaquettes only: Z_1 <= c(beta)^{3 N_s (1 - 1/N_rho)}),
       L0 = max_t { 3 ln c(t) + 3 t (1 - r(t)) - 3 beta (2 - r(t)^2 - r(t)^4) },  r(t) = I_2(t)/I_1(t)
            (Gibbs' variational principle with the product trial nu = e^{t cos theta} dHaar/norm on every non-axial link; E_nu[U] = r(t) I,
             so E[1 - cos theta_p] = 1 - r^n EXACTLY for a plaquette with n non-axial links: n = 2 (three (i,rho)), n = 4 (three spatial)),
       C(beta) = U1 - L0  (an upper bound on ln Z_1/N_s - ln Z_0/N_s; the ln beta terms cancel).
    The floor of Lemma CB-0: ln z_0(a) <= -(sqrt(beta s(a)) - sqrt(C(beta)))^2, s(a) = 1 - cos a, and beta_LF(a; z*) = the least beta
    with (sqrt(beta s(a)) - sqrt(C(beta)))^2 >= ln(1/z*).
Run: python -u -E -P bin/m8b_certified.py > rec/certified.<date>.txt
"""
from mpmath import iv, mp, mpf
iv.dps = 50
mp.dps = 50


def show(x, d=8):
    return "[%s, %s]" % (mp.nstr(mpf(x.a), d), mp.nstr(mpf(x.b), d))


PI = iv.pi
DMIN = iv.mpf('0.05')


def su_n(N):
    b0 = iv.mpf(11) * N / (48 * PI ** 2)
    b1 = (iv.mpf(34) / 3) * N ** 2 / (16 * PI ** 2) ** 2
    return b0, b1


print("(1) STEP TOLERANCES (outward-rounded intervals)")
for N in (2, 3):
    b0, b1 = su_n(N)
    print(" SU(%d): b0 = %s, b1 = %s, K2/c1 = 2N b1/b0 = %s" % (N, show(b0, 12), show(b1, 12), show(2 * N * b1 / b0, 10)))
    print("   L | c1 | K2 | eps = c1 - 0.05 | A1/eps RT-centred (K2/eps) | A1/eps tree-centred ((2 + K2)/eps) | beta*(K3 = 1, 10, 100, 1000), A1 = K2")
    for L in (2, 3, 4, 5, 7, 9, 11, 27, 81):
        lnL = iv.log(iv.mpf(L))
        c1 = 4 * N * b0 * lnL
        K2 = 8 * N ** 2 * b1 * lnL
        eps = c1 - DMIN
        bstar = []
        for K3 in (1, 10, 100, 1000):
            bstar.append((K2 + iv.sqrt(K2 ** 2 + 4 * eps * K3)) / (2 * eps))
        print("  %2d | %s | %s | %s | %s | %s | %s" % (L, show(c1, 6), show(K2, 6), show(eps, 6), show(K2 / eps, 5), show((2 + K2) / eps, 5),
                                                     " ".join(mp.nstr(mpf(x.b), 5) for x in bstar)))

print("\n(2) LARGE-FIELD PRICES")
zc20 = iv.mpf(19) ** 19 / iv.mpf(20) ** 20
mu = 19 * iv.e
zperc = 1 / mu
print("  Shearer z_c(20) = %s ; animal growth bound 19e = %s ; z_perc = 1/(19e) = %s" % (show(zc20, 10), show(mu, 8), show(zperc, 10)))
# z_KP = max_x x exp(-21x/(1 - 19 e x)); scan x on a fine grid in interval arithmetic, keep the best certified LOWER end
best = None
for i in range(1, 4000):
    x = iv.mpf(i) / 200000
    den = 1 - mu * x
    if den.a <= 0:
        break
    z = x * iv.exp(-21 * x / den)
    if best is None or z.a > best[1].a:
        best = (x, z)
print("  Kotecky-Preiss price z_KP >= %s at x = %s (alpha = 21x/(1 - 19ex) = %s)" % (mp.nstr(mpf(best[1].a), 10), mp.nstr(mpf(best[0].a), 6),
                                                                                      show(21 * best[0] / (1 - mu * best[0]), 6)))
zKP = iv.mpf(best[1].a)


def besselI(nu, x, K=None):
    """I_nu(x) for integer nu >= 0, x > 0 an interval: series with a closed geometric tail (all terms positive)."""
    half = x / 2
    term = half ** nu / iv.factorial(nu)
    s = term
    k = 0
    while True:
        k += 1
        term = term * half ** 2 / (k * (k + nu))
        s = s + term
        ratio = half ** 2 / ((k + 1) * (k + 1 + nu))
        if k > 10 and ratio.b < 0.5 and (term * ratio / (1 - ratio)).b < mpf(10) ** (-45) * s.a:
            tail = term * ratio / (1 - ratio)
            return s + iv.mpf([0, tail.b])


def c_of(t):
    return 2 * iv.exp(-t) * besselI(1, t) / t


def r_of(t):
    return besselI(2, t) / besselI(1, t)


def L0(beta):
    # maximise over t on a grid (any t gives a valid lower bound; keep the best certified lower end)
    best = None
    for f in [mpf(x) / 20 for x in range(100, 126)]:
        t = iv.mpf(f) * beta
        r = r_of(t)
        val = 3 * iv.log(c_of(t)) + 3 * t * (1 - r) - 3 * beta * (2 - r ** 2 - r ** 4)
        if best is None or val.a > best[1].a:
            best = (f, val)
    return best


print("\n(3) THE FREE-ENERGY GAP C(beta) = U1 - L0 (per site) AND THE CHESSBOARD LARGE-FIELD FLOOR")
Cs = {}
for beta in (5, 10, 15, 20, 30, 50, 100):
    b = iv.mpf(beta)
    U1 = 3 * iv.log(c_of(b))
    f, l0 = L0(b)
    C = U1 - l0
    Cs[beta] = C
    print("  beta = %5d: U1 = %s ; L0 >= %s (best t = %s beta) ; C(beta) <= %s ; U1 + 4.5 ln beta = %s"
          % (beta, show(U1, 10), mp.nstr(mpf(l0.a), 10), mp.nstr(f, 4), mp.nstr(mpf(C.b), 8), show(U1 + iv.mpf('4.5') * iv.log(b), 8)))


def floor(s, zstar):
    """least beta (on a 1/100 grid, certified) with (sqrt(beta s) - sqrt(C(beta)))^2 >= ln(1/zstar); C(beta) computed at beta."""
    target = iv.log(1 / zstar)
    lo, hi = 1.0, 2000.0
    def ok(beta):
        b = iv.mpf(beta)
        C = 3 * iv.log(c_of(b)) - L0(b)[1]
        x = iv.sqrt(b * s) - iv.sqrt(iv.mpf(C.b))
        return x.a > 0 and (x ** 2).a >= target.b
    if not ok(hi):
        return None
    for _ in range(22):
        mid = 0.5 * (lo + hi)
        if ok(mid):
            hi = mid
        else:
            lo = mid
    return hi


print("  floors beta_LF(a) [Wilson barrier s(a) = 1 - cos a, kappa = 1 (the constant-field configuration attains it for the collective event)]:")
print("    a (rad) | s(a) | z* = z_perc | z* = Shearer z_c(20) | z* = z_KP")
for a in ('0.5', '1.0', '1.5707963267948966', '2.0', '2.4', '3.1415926535897932'):
    s = 1 - iv.cos(iv.mpf(a))
    fl = [floor(s, z) for z in (zperc, zc20, zKP)]
    print("    %6s | %s | %s | %s | %s" % (a[:6], show(s, 6), *["%.2f" % x if x else ">2000" for x in fl]))
print("  for comparison, the Gaussian heuristics (M6 section 6, M8 section 6.3; NOT bounds): plaquette domain 5.736/a^2, link domain 1.4771/b^2 (L = 2)")
