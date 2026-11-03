"""fibre_pole4.py -- the fibre's pole on the line Re k0 = pi (MF Theorem 3.1: the decay is ALTERNATING, (-1)^d e^{-kappa d}, with the
minimum over k_perp at k_perp = 0 on that line): K = (pi + i x, k_perp), e^{iK0} = -e^{-x}."""
import numpy as np, itertools
from fibre_gauss2 import hop_matrices, NB
J0, Tp, Tm = hop_matrices(); Pi = np.ones((NB, NB)) / NB; P0 = np.eye(NB) - Pi
def jhat_pi(x, k, m2=0.0):
    J = J0 + m2 * np.eye(NB) - np.exp(-x) * Tp[0] - np.exp(x) * Tm[0]
    for mu in (1, 2, 3):
        J = J + np.exp(1j * k[mu - 1]) * Tp[mu] + np.exp(-1j * k[mu - 1]) * Tm[mu]
    return J
def smin(x, k, m2=0.0): return np.linalg.svd(P0 @ jhat_pi(x, k, m2) @ P0 + Pi, compute_uv=False).min()
def first_min(f, lo, hi, n=3000):
    xs = np.linspace(lo, hi, n); v = np.array([f(x) for x in xs]); i = int(np.argmin(v)); a, b = xs[max(i-1,0)], xs[min(i+1,n-1)]
    for _ in range(80):
        m1, m2_ = a + (b-a)/3, b - (b-a)/3
        if f(m1) < f(m2_): b = m2_
        else: a = m1
    x = 0.5*(a+b); return x, f(x)
for k in [(0.0, 0.0, 0.0), (np.pi/4, 0, 0), (np.pi/2, 0, 0), (np.pi, 0, 0), (np.pi, np.pi, np.pi)]:
    x, s = first_min(lambda t: smin(t, k), 0.05, 4.5)
    print('  Re k0 = pi, k_perp = (%.3f, %.3f, %.3f): x = %.9f  (s_min %.1e)%s' % (k[0], k[1], k[2], x, s, '  <- POLE' if s < 1e-6 else ''))
x0, s0 = first_min(lambda t: smin(t, (0.0, 0.0, 0.0)), 0.05, 4.5)
print('FIBRE POLE on Re k0 = pi at k_perp = 0: x = %.9f; cosh x = %.9f (MF Theorem 3.1: cosh kappa_2 = 3, kappa_2 = %.9f); the tail ratios 0.130-0.146 at d = 6-10 rise toward e^-x = %.6f' % (x0, np.cosh(x0), np.arccosh(3.0), np.exp(-x0)))
for m in (0.5, 1.0):
    xm, sm = first_min(lambda t: smin(t, (0.0, 0.0, 0.0), m*m), 0.05, 4.5)
    print('  m = %g: x = %.9f (MF: independent of m)' % (m, xm))
