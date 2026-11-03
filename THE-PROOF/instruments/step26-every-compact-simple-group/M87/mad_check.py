# mad_check.py -- M87, READING (high-precision quadrature, not a certificate): the MAD of u = <U, e> under vMF(kappa) on S^3,
# against the second-order expansion derived in WORK.md 5.4:
#   MAD(kappa, alpha) = 4/(3 pi) - (kappa^2/pi) [ (13/120) cos^2 alpha + (1/30) sin^2 alpha ] + O(kappa^4).
# Law of u (g18's rotation reduction): density on [-1, 1] proportional to e^{k1 u} sqrt(1-u^2) phi(k2 sqrt(1-u^2)), phi(z) = sinh z / z.
import mpmath as mp
mp.mp.dps = 40
def mad(kappa, alpha):
    k1 = kappa * mp.cos(alpha); k2 = kappa * mp.sin(alpha)
    def phi(z): return mp.sinh(z) / z if z != 0 else mp.mpf(1)
    f = lambda u: mp.e ** (k1 * u) * mp.sqrt(1 - u * u) * phi(k2 * mp.sqrt(1 - u * u))
    Z = mp.quad(f, [-1, 0, 1]); m = mp.quad(lambda u: u * f(u), [-1, 0, 1]) / Z
    return mp.quad(lambda u: abs(u - m) * f(u), [-1, m, 1]) / Z
base = 4 / (3 * mp.pi)
print("MAD at kappa=0:", mad(mp.mpf(0), 0), "4/(3pi) =", base)
for kappa in (mp.mpf("0.05"), mp.mpf("0.1"), mp.mpf("0.2"), mp.mpf("0.4254")):
    for alpha in (mp.mpf(0), mp.pi / 4, mp.pi / 2):
        v = mad(kappa, alpha)
        pred = base - kappa ** 2 / mp.pi * (mp.mpf(13) / 120 * mp.cos(alpha) ** 2 + mp.mpf(1) / 30 * mp.sin(alpha) ** 2)
        print("kappa=%s alpha=%.4f MAD=%s  2nd-order=%s  (MAD-base)/kappa^2*pi=%s  residual/kappa^4=%s" % (
            mp.nstr(kappa, 5), float(alpha), mp.nstr(v, 15), mp.nstr(pred, 15), mp.nstr((v - base) / kappa ** 2 * mp.pi, 10), mp.nstr((v - pred) / kappa ** 4, 6)))
