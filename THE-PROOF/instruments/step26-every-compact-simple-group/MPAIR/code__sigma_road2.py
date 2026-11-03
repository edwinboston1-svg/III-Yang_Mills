# MPAIR sigma_road2.py -- a second road for alpha_sigma = 30 C_med (SU(2)) sharing no line with mg2_su2_eval.py:
# (A) READING: the exact constants D5 = max_{r<=5b}|D(r)|, T6 = max_{r<=6b, c in [0,1]} |phi'''(r)c^3 + 3(D(r)/r)c(1-c^2)| from mpmath Bessel
#     functions on a fine grid (double-check of the interval enclosures), then C_med and 30 C_med at the certified root 0.4924 and 0.4925;
# (B) CERTIFIED with Lemma 8.6's cruder constants (D5 = m(5b)^2/3, T6 = m(6b)/2), interval arithmetic with mpmath's own besseli: the L86 root.
import sys
from mpmath import mp, iv, besseli, mpf, pi as mpi
mp.dps = 30

def consts(r):
    I1 = besseli(1, r); I2 = besseli(2, r)
    m = I2 / I1
    p2 = 1 - 3 * m / r - m * m          # phi'' = m' = 1 - 3m/r - m^2 (Riccati)
    D = p2 - m / r
    p3 = 3 * abs(D) / r - 2 * m * p2    # phi''' = 3|D|/r - 2 m phi''
    return m, p2, D, p3

def Cmed_reading(b, nr=3000, nc=400):
    b = mpf(b)
    D5 = max(abs(consts(5 * b * (i + 1) / nr)[2]) for i in range(nr))
    T6 = mpf(0)
    for i in range(nr):
        r = 6 * b * (i + 1) / nr
        m, p2, D, p3 = consts(r)
        for j in range(nc + 1):
            c = mpf(j) / nc
            k = abs(p3 * c ** 3 + 3 * (D / r) * c * (1 - c * c))
            if k > T6: T6 = k
    om = 3 * b * b * D5 + 2 * b ** 3 * T6
    rho = (3 * mp.e ** om - 1) / 2
    Cmed = rho * b * b / (3 * mpi) + (min(b * b * D5, 2 * b ** 3 * T6) + mpf(2) / 3 * b ** 3 * T6) / 4
    return Cmed, D5, T6, om, rho

def Cmed_L86_iv(b):
    b = iv.mpf(b)
    def m_iv(r):
        # m = I2/I1 enclosed: mpmath besseli at the endpoints (m increasing in r: Lemma 8.6's monotonicity of m)
        lo = mp.besseli(2, r.a) / mp.besseli(1, r.a); hi = mp.besseli(2, r.b) / mp.besseli(1, r.b)
        return iv.mpf([lo * (1 - mpf(10) ** -25), hi * (1 + mpf(10) ** -25)])
    m5 = m_iv(5 * b); m6 = m_iv(6 * b)
    D5 = m5 * m5 / 3; T6 = m6 / 2
    om = 3 * b * b * D5 + 2 * b ** 3 * T6
    rho = (3 * iv.exp(om) - 1) / 2
    x = b * b * D5; y = 2 * b ** 3 * T6
    mn = x if x.b <= y.b else y
    return rho * b * b / (3 * iv.pi) + (mn + iv.mpf(2) / 3 * b ** 3 * T6) / 4

if __name__ == '__main__':
    for b in ['0.4924', '0.4925']:
        C, D5, T6, om, rho = Cmed_reading(b)
        print('READING beta=%s: D5=%s T6=%s omega=%s rho=%s  C_med=%s  30*C_med=%s' % (b, mp.nstr(D5, 8), mp.nstr(T6, 8), mp.nstr(om, 7), mp.nstr(rho, 8), mp.nstr(C, 8), mp.nstr(30 * C, 9)))
        sys.stdout.flush()
    from decimal import Decimal
    b = Decimal('0.30'); step = Decimal('0.01')
    while True:
        nb = b + step
        if mp.mpf((30 * Cmed_L86_iv(str(nb))).b) < 1: b = nb
        else:
            if step <= Decimal('0.0001'): break
            step = step / 10
    print('CERTIFIED (Lemma 8.6 constants): 30*C_med < 1 up to beta = %s (value %s); at %s: %s' % (b, mp.nstr(mp.mpf((30 * Cmed_L86_iv(str(b))).b), 8),
          b + Decimal('0.0001'), mp.nstr(mp.mpf((30 * Cmed_L86_iv(str(b + Decimal('0.0001')))).b), 8)))
