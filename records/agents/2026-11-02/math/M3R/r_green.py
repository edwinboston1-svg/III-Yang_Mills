"""M3R check 2: an independent evaluation of the block-map record's small-n rows and of the slope constant.

Independent of m3_blockmap.py in library (mpmath, 30 digits, not scipy), in tail handling (the large-t tail is
integrated term by term from the asymptotic series of e^{-z} I_nu(z), not truncated), and in organisation (each
variance is expanded into a finite signed sum of 4D lattice Green function values G4(x), each computed once).

  G_d(x) = int_0^inf prod_{nu<d} e^{-2t} I_{x_nu}(2t) dt      (lattice Green function of -Delta, khat^2 = sum 2(1-cos))

Checks:
  (a) G4(0) against the known 0.1549333902310...; the identity G4(0) - G4(e1) = 1/8 (exact).
  (b) G3(0) by the integral against Watson's closed form W/6, W = sqrt(6)/(32 pi^3) Gamma(1/24)Gamma(5/24)Gamma(7/24)Gamma(11/24);
      the slope 4 G3(0) = 2W/3.
  (c) the n = 2 row of the record, all three columns, from finite sums of G4 values:
      Var_path(2)/g^2 = 2 int F H J^2,   Var_1dir(2)/g^2 = 2 int F^2 H J / 4,   Var_avg(2)/g^2 = 2 int F^3 G / 64,
      with the 1D factors written as index->weight maps (F = sum_{|m|<n}(n-|m|) e_m, H = 2e_0 - e_n - e_{-n}, J = e_0,
      G = sum_{|m|<n}(n-|m|)(2e_m - e_{m+n} - e_{m-n})).
"""
import sys
sys.path.append(r"C:\Users\Edwin Boston\AppData\Roaming\Python\Python314\site-packages")
import mpmath as mp
from itertools import product

mp.mp.dps = 30
T = mp.mpf(300)
NTERMS = 14


def asym_coeffs(nu):
    # e^{-z} I_nu(z) ~ (2 pi z)^{-1/2} sum_k (-1)^k a_k z^{-k},  a_k = prod_{j=1..k}(4nu^2-(2j-1)^2) / (k! 8^k)
    out = []
    a = mp.mpf(1)
    out.append(a)
    for k in range(1, NTERMS):
        a = a * (4 * nu * nu - (2 * k - 1) ** 2) / (k * 8)
        out.append(a)
    return out


def series_in_inv_t(nu):
    # e^{-2t} I_nu(2t) = (4 pi t)^{-1/2} sum_k c_k t^{-k},  c_k = (-1)^k a_k / 2^k
    a = asym_coeffs(nu)
    return [((-1) ** k) * a[k] / mp.mpf(2) ** k for k in range(NTERMS)]


def polymul(p, q):
    r = [mp.mpf(0)] * NTERMS
    for i, pi_ in enumerate(p):
        for j, qj in enumerate(q):
            if i + j < NTERMS:
                r[i + j] += pi_ * qj
    return r


_cache = {}


def Gd(x):
    key = tuple(sorted(abs(v) for v in x))
    if key in _cache:
        return _cache[key]
    d = len(key)
    f = lambda t: mp.fprod([mp.besseli(m, 2 * t) * mp.exp(-2 * t) for m in key]) if t > 0 else mp.mpf(1 if all(m == 0 for m in key) else 0)
    pts = [mp.mpf(0)] + [mp.mpf(2) ** k / 64 for k in range(0, 15)]
    pts = [p for p in pts if p < T] + [T]
    head = mp.quad(f, pts)
    # tail: (4pi)^{-d/2} sum_k C_k int_T^inf t^{-d/2-k} dt
    ser = [mp.mpf(1)] + [mp.mpf(0)] * (NTERMS - 1)
    for m in key:
        ser = polymul(ser, series_in_inv_t(m))
    tail = mp.mpf(0)
    for k, ck in enumerate(ser):
        e = mp.mpf(d) / 2 + k
        tail += ck * T ** (1 - e) / (e - 1)
    tail *= (4 * mp.pi) ** (-mp.mpf(d) / 2)
    val = head + tail
    _cache[key] = val
    return val


def fac_F(n):
    return {m: mp.mpf(n - abs(m)) for m in range(-(n - 1), n)}


def fac_H(n):
    return {0: mp.mpf(2), n: mp.mpf(-1), -n: mp.mpf(-1)}


def fac_J():
    return {0: mp.mpf(1)}


def fac_G(n):
    out = {}
    for m in range(-(n - 1), n):
        w = mp.mpf(n - abs(m))
        for idx, c in ((m, 2), (m + n, -1), (m - n, -1)):
            out[idx] = out.get(idx, mp.mpf(0)) + w * c
    return out


def integral(facs):
    # int_0^inf prod_nu (sum_m w_m e^{-2t} I_m(2t)) dt = sum over index tuples of prod w * G4(indices)
    tot = mp.mpf(0)
    for combo in product(*[list(f.items()) for f in facs]):
        w = mp.fprod([c for (_, c) in combo])
        if w != 0:
            tot += w * Gd([m for (m, _) in combo])
    return tot


if __name__ == "__main__":
    g40 = Gd([0, 0, 0, 0])
    g4e = Gd([1, 0, 0, 0])
    print("(a) G4(0)          =", mp.nstr(g40, 20), "  (known 0.15493339023106...)")
    print("    G4(0) - G4(e1) =", mp.nstr(g40 - g4e, 20), "  (exact 1/8)")
    g30 = Gd([0, 0, 0])
    W = mp.sqrt(6) / (32 * mp.pi ** 3) * mp.gamma(mp.mpf(1) / 24) * mp.gamma(mp.mpf(5) / 24) * mp.gamma(mp.mpf(7) / 24) * mp.gamma(mp.mpf(11) / 24)
    print("(b) G3(0) integral =", mp.nstr(g30, 20))
    print("    W/6 (Watson)   =", mp.nstr(W / 6, 20), "  W =", mp.nstr(W, 20))
    print("    4 G3(0) = 2W/3 =", mp.nstr(2 * W / 3, 20), "  (record: 1.0109240394; fit 1.010921)")
    print("    2/pi^2 (the predicted ln n coefficient of Var_path) =", mp.nstr(2 / mp.pi ** 2, 12), " (fit 0.2024)")
    for n in (1, 2, 3):
        vp = 2 * integral([fac_F(n), fac_H(n), fac_J(), fac_J()])
        v1 = 2 * integral([fac_F(n), fac_H(n), fac_F(n), fac_J()]) / n ** 2
        va = 2 * integral([fac_F(n), fac_G(n), fac_F(n), fac_F(n)]) / n ** 6
        print(f"(c) n={n}: Var_path/g2 = {mp.nstr(vp, 15)}   Var_1dir/g2 = {mp.nstr(v1, 15)}   Var_avg/g2 = {mp.nstr(va, 15)}")
    print("    record n=2: 1.369312  0.816690  0.28810407 ;  n=3: 2.305193  1.032882  0.23667640")
