"""M3 instrument: S-1 (running coefficients, interval-certified) and S-2 (the block-map test).

S-2: 4D lattice gauge field in Feynman gauge, covariance g^2 (-Delta)^{-1} delta_{mu nu}.  For a test function h_mu on links,
Var(<h, A>)/g^2 = int d^4k/(2pi)^4 sum_mu |h_mu^(k)|^2 / khat^2,  khat^2 = sum_nu 2(1 - cos k_nu).
Heat kernel: 1/khat^2 = int_0^inf exp(-t khat^2) dt, and int dk/(2pi) exp(-2t(1-cos k)) e^{ikm} = e^{-2t} I_m(2t) = ive(m,2t).
Every 4D integral below is therefore a 1D t-integral of products of 1D factors (exact reduction, no approximation).

PATH variable (the paper's example block map): flux of an n x n square loop in the 12-plane.
  Var_path/g^2 = 2 int_0^inf F(t) H(t) J(t)^2 dt
AVERAGED variable (each coarse link = average over the n^3 parallel fine paths of its block, coarse plaquette of 4 such links):
  Var_avg/g^2  = 2 int_0^inf F(t)^3 G(t) dt / n^6
ONE-DIRECTION average (each coarse link = average over n paths displaced along x3 only):
  Var_1/g^2    = 2 int_0^inf F(t)^2 H(t) J(t) dt / n^2
with  F = sum_{|m|<n} (n-|m|) ive(m,2t)            [|D_n(k)|^2]
      H = 2 ive(0,2t) - 2 ive(n,2t)                [|1 - e^{ikn}|^2]
      J = ive(0,2t)                                [no dependence]
      G = sum_{|m|<n} (n-|m|) (2 ive(m) - ive(m+n) - ive(m-n))(2t)   [|D_n|^2 |1-e^{ikn}|^2]
"""
import sys
import numpy as np
from scipy.special import ive
from scipy.integrate import quad
import mpmath as mp


def S1():
    iv = mp.iv
    iv.dps = 40
    pi = iv.pi
    c_unit = iv.mpf(11) / (3 * pi**2)          # 8 b0 in Balaban's normalisation, per unit log
    two_loop = iv.mpf(17) / (3 * pi**4)        # 32 b1
    b0 = iv.mpf(11) / (24 * pi**2)
    b1 = iv.mpf(17) / (96 * pi**4)
    out = []
    out.append(("8b0 = 11/(3 pi^2)", c_unit))
    out.append(("c(2) = 8b0 ln 2", c_unit * iv.log(2)))
    out.append(("c(3) = 8b0 ln 3", c_unit * iv.log(3)))
    out.append(("32b1 = 17/(3 pi^4)", two_loop))
    out.append(("4 b1/b0", 4 * b1 / b0))
    return out


def factors(t, n):
    x = 2.0 * t
    ms = np.arange(-(n - 1), n)
    w = (n - np.abs(ms)).astype(float)
    Im = ive(ms, x)
    F = np.dot(w, Im)
    J = ive(0, x)
    H = 2.0 * ive(0, x) - 2.0 * ive(n, x)
    G = np.dot(w, 2.0 * Im - ive(ms + n, x) - ive(ms - n, x))
    return F, H, J, G


def tint(fun):
    # integrate over t in (0, inf) via t = e^u; split the range for robustness
    g = lambda u: fun(np.exp(u)) * np.exp(u)
    total, err = 0.0, 0.0
    edges = [-40, -10, -5, -2, 0, 2, 4, 6, 8, 10, 12, 14, 16, 18.0]  # t <= e^18 = 6.6e7 (ive finite); tail <= n^4/(32 pi^2 T^2), printed
    for a, b in zip(edges[:-1], edges[1:]):
        v, e = quad(g, a, b, limit=400, epsabs=1e-15, epsrel=1e-12)
        total += v
        err += e
    return total, err


def G0():
    return tint(lambda t: ive(0, 2 * t) ** 4)


def var_path(n):
    return tint(lambda t: 2.0 * (lambda F, H, J, G: F * H * J * J)(*factors(t, n)))


def var_avg(n):
    return tint(lambda t: 2.0 * (lambda F, H, J, G: F ** 3 * G)(*factors(t, n)) / n ** 6)


def var_one(n):
    return tint(lambda t: 2.0 * (lambda F, H, J, G: F * F * H * J)(*factors(t, n)) / n ** 2)


def lattice_G_axis(m):
    # G(m e1) = int_0^inf ive(m,2t) ive(0,2t)^3 dt
    return tint(lambda t: ive(m, 2 * t) * ive(0, 2 * t) ** 3)


if __name__ == "__main__":
    print("== S-1 (interval arithmetic, mpmath.iv, 40 digits)")
    for name, val in S1():
        print(f"  {name:22s} in [{mp.nstr(val.a, 12)}, {mp.nstr(val.b, 12)}]")
    print("== S-2 the block-map test")
    g0, e0 = G0()
    print(f"  G(0) = {g0:.12f}  (quad err {e0:.1e}; known 0.154933390231...)")
    # the analytic lower bound's constant: 4 G(0)
    print(f"  4 G(0) = {4*g0:.10f}")
    nmax = int(sys.argv[1]) if len(sys.argv) > 1 else 64
    ns = [n for n in (1, 2, 3, 4, 6, 8, 12, 16, 24, 32, 48, 64, 96, 128) if n <= nmax]
    print("   n    Var_path/g2   Var_path/(g2 n)   Var_one/g2    Var_avg/g2")
    rows = []
    for n in ns:
        vp, ep = var_path(n)
        v1, e1 = var_one(n)
        va, ea = var_avg(n)
        rows.append((n, vp, v1, va))
        print(f"  {n:4d}  {vp:12.6f}   {vp/n:12.8f}   {v1:12.6f}  {va:12.8f}   (errs {ep:.0e},{e1:.0e},{ea:.0e}; tail<={n**4/(32*np.pi**2*np.exp(36)):.0e})")
    # along the asymptotically free sequence: g_YM^2 = 4/(x_c + c(2) log2 n), x_c = 1/g_c^2 = 1 (illustrative) and 4
    c2 = 11.0 / (3 * np.pi ** 2) * np.log(2.0)
    for xc in (4.0, 16.0):
        print(f"  AF sequence x_c = {xc}: n, g_YM^2, g^2 Var_path, g^2 Var_avg, <cos(theta_path/2)>~exp(-3/8 g^2 Var)")
        for (n, vp, v1, va) in rows:
            gym2 = 4.0 / (xc + c2 * np.log2(n)) if n > 1 else 4.0 / xc
            print(f"     {n:4d}  {gym2:.5f}  {gym2*vp:10.5f}  {gym2*va:10.6f}  {np.exp(-0.375*gym2*vp):.3e}")
