"""M3R check 4: Remark 6.3's aligned-staple pair.  At large concentration the conditional law of one SU(2) link is a 3D Gaussian of
variance 1/(beta |S|) per tangent direction; flipping one of six aligned staples changes |S| from 6 to 4 and keeps the mode, so the
TV between the two conditional laws tends to TV(N(0, I_3), N(0, 1.5 I_3)) -- independent of beta.  Exact via chi-square(3) CDFs:
densities cross at r^2 = r0^2 with exp(-r0^2/2) = 1.5^{-3/2} exp(-r0^2/3)  =>  r0^2 = 9 ln 1.5; TV = F3(r0^2) - F3(r0^2/1.5).
Also the exact von Mises-Fisher TV on S^3 at finite beta, by quadrature over the rotation angle (Haar density (2/pi) sin^2 theta).
"""
import sys
sys.path.append(r"C:\Users\Edwin Boston\AppData\Roaming\Python\Python314\site-packages")
import mpmath as mp

mp.mp.dps = 30
F3 = lambda x: mp.gammainc(mp.mpf(3) / 2, 0, x / 2, regularized=True)
r0sq = 9 * mp.log(mp.mpf(3) / 2)
print("Gaussian limit TV =", mp.nstr(F3(r0sq) - F3(r0sq / mp.mpf(1.5)), 12), "; times 18 =", mp.nstr(18 * (F3(r0sq) - F3(r0sq / mp.mpf(1.5))), 6))


def tv_vmf(beta, s1, s2):
    # densities on S^3 proportional to exp(beta s cos theta), Haar measure (2/pi) sin^2 theta d theta (theta in [0, pi])
    def Z(s):
        return mp.quad(lambda t: (2 / mp.pi) * mp.sin(t) ** 2 * mp.exp(beta * s * (mp.cos(t) - 1)), [0, mp.pi])
    z1, z2 = Z(s1), Z(s2)
    return mp.quad(lambda t: (2 / mp.pi) * mp.sin(t) ** 2 * abs(mp.exp(beta * s1 * (mp.cos(t) - 1)) / z1 - mp.exp(beta * s2 * (mp.cos(t) - 1)) / z2), [0, mp.pi / 8, mp.pi / 2, mp.pi]) / 2


for beta in (2, 10, 100, 1000):
    print(f"  beta_eff = {beta}: vMF TV(|S|=6 vs |S|=4) = {mp.nstr(tv_vmf(mp.mpf(beta), 6, 4), 8)}")
