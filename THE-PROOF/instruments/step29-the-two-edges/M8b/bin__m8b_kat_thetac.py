"""M8b S-HK.0: the heat-kernel weight's KAT — the zero theta_c(beta) of the radial second derivative of g = -(1/beta) log K_t,
principal branch (closed form 1 + (1/beta)(1/theta^2 - 1/sin^2 theta)) and with the windings n in {-2..2} (finite differences of the
script's own g), by bisection.  READING (double precision).
Run: python -u -E -P bin/m8b_kat_thetac.py > rec/kat_thetac.<date>.txt
"""
import numpy as np

TWO_PI = 2 * np.pi


def logK(th, beta):
    Bsum = th
    for n in (-2, -1, 1, 2):
        Bsum = Bsum + (th + TWO_PI * n) * np.exp(-TWO_PI * beta * n * (th + np.pi * n))
    return -beta * th ** 2 / 2.0 + np.log(Bsum / np.sin(th))


def g2_wind(th, beta, h=1e-4):
    f = [-logK(t, beta) / beta for t in (th - h, th, th + h)]
    return (f[2] - 2 * f[1] + f[0]) / (h * h)


def g2_princ(th, beta):
    return 1.0 + (1.0 / th ** 2 - 1.0 / np.sin(th) ** 2) / beta


def root(f, lo=0.5, hi=np.pi - 1e-6):
    assert f(lo) > 0
    if f(hi) > 0:
        return None
    for _ in range(80):
        mid = 0.5 * (lo + hi)
        if f(mid) > 0:
            lo = mid
        else:
            hi = mid
    return 0.5 * (lo + hi)


print("beta | theta_c principal (rad, deg) | theta_c with windings | 1 - cos(theta_c) | theta_c^2/2")
for beta in (1.0, 2.0, 2.5, 5.0, 10.0, 20.0, 50.0):
    tp = root(lambda t: g2_princ(t, beta))
    tw = root(lambda t: g2_wind(t, beta), hi=np.pi - 1e-3)
    print("%5.1f | %.5f (%.2f deg) | %s | %.5f | %.5f" % (beta, tp, np.degrees(tp), "%.5f" % tw if tw else "none below pi - 1e-3",
                                                       1 - np.cos(tp), tp * tp / 2))
print("Wilson: g'' = cos(theta) vanishes at pi/2 = %.5f for every beta; Manton: g'' = 1 up to the cut locus pi" % (np.pi / 2))
