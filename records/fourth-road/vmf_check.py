"""vmf_check.py -- a fourth-road spot check of the two lemmas Theorem 8.7 leans on (THE GROUND rev. 14, pp. 33-35):
(a) the sharp one-link lemma: the mean absolute deviation of <U, e> under the von Mises-Fisher law nu_w on S^3 is at most
    4/(3 pi) for every unit e and every w  (deterministic 2-D quadrature, no sampling);
(b) Lemma 8.6 (i)-(iii): m/r <= 1/4, phi'' <= 1/4, -m^2/3 <= D <= 0, |third cumulant along u| <= m/2;
(c) the row sum (8.12) at beta = 0.241 and 0.2415, by the paper's own formulas, in double precision."""
import numpy as np, math

def bessel(n, x):
    s = 0.0; t = (x / 2) ** n / math.factorial(n)
    for k in range(120):
        s += t; t *= (x / 2) ** 2 / ((k + 1) * (k + 1 + n))
    return s
def m(r): return bessel(2, r) / bessel(1, r) if r > 0 else 0.0

# (a) MAD of <U, e> under nu_{r e0}; U = (cos th, sin th * n), n uniform on S^2; e = cos a e0 + sin a e1;
#     <U, e> = cos a cos th + sin a sin th n1; density  e^{r cos th} sin^2 th dth  x  dn1/2 on [-1, 1].
th = np.linspace(0, np.pi, 4001); n1 = np.linspace(-1, 1, 2001)
TH, N1 = np.meshgrid(th, n1, indexing='ij')
worst = 0.0
for r in (0.0, 0.25, 0.5, 1.0, 1.205, 1.446, 2.0, 3.0, 5.0, 10.0):
    wgt = np.exp(r * np.cos(TH)) * np.sin(TH) ** 2
    wgt /= np.trapezoid(np.trapezoid(wgt, n1, axis=1), th)
    for a in np.linspace(0, np.pi / 2, 7):
        X = np.cos(a) * np.cos(TH) + np.sin(a) * np.sin(TH) * N1
        mean = np.trapezoid(np.trapezoid(X * wgt, n1, axis=1), th)
        mad = np.trapezoid(np.trapezoid(np.abs(X - mean) * wgt, n1, axis=1), th)
        worst = max(worst, mad)
        print('r=%6.3f angle=%.3f  MAD=%.6f  (4/3pi = %.6f)' % (r, a, mad, 4 / (3 * np.pi)))
print('(a) worst MAD over the grid = %.6f against 4/(3 pi) = %.6f  ->  %s' % (worst, 4 / (3 * np.pi), 'HOLDS' if worst <= 4 / (3 * np.pi) + 1e-6 else 'FAILS'))

# (b) Lemma 8.6 by finite differences of phi = log(2 I1(r)/r)
def phi(r): return math.log(2 * bessel(1, r) / r) if r > 0 else 0.0
bad = []
for r in np.linspace(0.05, 12, 240):
    h = 1e-3
    d1 = (phi(r + h) - phi(r - h)) / (2 * h); d2 = (phi(r + h) - 2 * phi(r) + phi(r - h)) / h ** 2
    d3 = (phi(r + 2 * h) - 2 * phi(r + h) + 2 * phi(r - h) - phi(r - 2 * h)) / (2 * h ** 3)
    mr = m(r); D = d2 - mr / r
    ok = (mr / r <= 0.25 + 1e-6) and (d2 <= 0.25 + 1e-6) and (-mr ** 2 / 3 - 1e-6 <= D <= 1e-6)
    # third cumulant along u with <u, w^> = c: phi''' c^3 + 3 (D/r) c (1 - c^2)
    k3 = max(abs(d3 * c ** 3 + 3 * (D / r) * c * (1 - c ** 2)) for c in np.linspace(-1, 1, 201))
    ok = ok and (k3 <= mr / 2 + 1e-5)
    if not ok: bad.append((r, mr / r, d2, D, k3, mr / 2))
print('(b) Lemma 8.6 (i)-(iii) on 240 radii in [0.05, 12]: %s' % ('HOLDS' if not bad else 'FAILS at %s' % bad[:3]))

# (c) the row sum (8.12)
def alpha(b):
    D5 = m(5 * b) ** 2 / 3; T6 = m(6 * b) / 2
    om = 3 * b ** 2 * D5 + 2 * b ** 3 * T6; rho = (3 * math.exp(om) - 1) / 2
    Cd = rho * 4 * b / (3 * math.pi) * m(5 * b) + 0.25 * (b ** 2 * D5 + (2 / 3) * b ** 3 * T6)
    Cm = rho * b ** 2 / (3 * math.pi) + 0.25 * (min(b ** 2 * D5, 2 * b ** 3 * T6) + (2 / 3) * b ** 3 * T6)
    return 12 * Cd, 90 * Cm, 12 * Cd + 90 * Cm, om, rho
for b in (0.2, 0.22, 0.23, 0.24, 0.241, 0.2415):
    print('(c) beta=%.4f  12Cdir=%.6f  90Cmed=%.6f  alpha=%.6f  omega=%.6f  rho=%.6f' % ((b,) + alpha(b)))
