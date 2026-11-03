# MPAIR sigma_search.py -- READING (a search from below, not a bound): the mediated interdependence coefficient of the checkerboard-decimated
# slab sigma-model for SU(2).  The conditional law of an even site's u in S^3 is p(u) ∝ Π_{j=1..6} Z(|c_j + β u|), Z(r) = 2 I1(r)/r, where
# c_j = L_j^T w_j ranges over the ball of radius 5β (the isometries absorbed).  A mediated change moves one c_j by Δ, |Δ| <= 2β.
# We maximise TV(p, p') over (c_1..c_6, Δ) by random restarts + Powell, on a Hopf-coordinate quadrature of S^3, and compare with the proved
# bound C_med(β) of THE GROUND's (8.12) (exact constants), read from runs/sigma_eval_su2.
import sys
import numpy as np
from scipy.special import i1e
from scipy.optimize import minimize

def grid(n1, n2):
    # Hopf coordinates: u = (cos x1 sin e, sin x1 sin e, cos x2 cos e, sin x2 cos e), dvol ∝ sin e cos e de dx1 dx2 (midpoint rule)
    e = (np.arange(n1) + 0.5) * (np.pi / 2) / n1
    x = (np.arange(n2) + 0.5) * (2 * np.pi) / n2
    E, X1, X2 = np.meshgrid(e, x, x, indexing='ij')
    U = np.stack([np.cos(X1) * np.sin(E), np.sin(X1) * np.sin(E), np.cos(X2) * np.cos(E), np.sin(X2) * np.cos(E)], axis=-1).reshape(-1, 4)
    W = (np.sin(E) * np.cos(E)).reshape(-1)
    return U, W / W.sum()

def logZ(r):
    # log(2 I1(r)/r), stable: I1(r) = i1e(r) e^r
    r = np.maximum(r, 1e-12)
    small = r < 1e-6
    out = np.log(2 * i1e(r) / r) + r
    out[small] = r[small] ** 2 / 8
    return out

def density(C, beta, U, W):
    s = np.zeros(U.shape[0])
    for c in C:
        s += logZ(np.linalg.norm(c[None, :] + beta * U, axis=1))
    s -= s.max()
    p = np.exp(s) * W
    return p / p.sum()

def unpack(x, beta):
    C = x[:24].reshape(6, 4); D = x[24:28]
    # project into the admissible set: |c_j| <= 5β, |Δ| <= 2β, |c_1 + Δ| <= 5β
    C = np.array([c * min(1.0, 5 * beta / max(np.linalg.norm(c), 1e-15)) for c in C])
    D = D * min(1.0, 2 * beta / max(np.linalg.norm(D), 1e-15))
    c1 = C[0] + D
    if np.linalg.norm(c1) > 5 * beta: D = c1 * (5 * beta / np.linalg.norm(c1)) - C[0]
    return C, D

def tv(x, beta, U, W):
    C, D = unpack(x, beta)
    p = density(C, beta, U, W)
    C2 = C.copy(); C2[0] = C[0] + D
    q = density(C2, beta, U, W)
    return 0.5 * np.abs(p - q).sum()

if __name__ == '__main__':
    beta = float(sys.argv[1]); cmed = float(sys.argv[2]); restarts = int(sys.argv[3]); seed = int(sys.argv[4])
    rng = np.random.default_rng(seed)
    Uc, Wc = grid(24, 48)
    Uf, Wf = grid(64, 128)
    best = 0.0; bx = None
    for r in range(restarts):
        x0 = rng.normal(size=28) * beta * 3
        res = minimize(lambda x: -tv(x, beta, Uc, Wc), x0, method='Powell', options={'maxfev': 3000, 'xtol': 1e-4, 'ftol': 1e-7})
        v = -res.fun
        if v > best: best = v; bx = res.x
    vf = tv(bx, beta, Uf, Wf)
    C, D = unpack(bx, beta)
    print('beta=%.4f restarts=%d seed=%d: max TV found (coarse grid) %.6f, refined on the fine grid %.6f; proved bound C_med = %.6f; ratio %.3f'
          % (beta, restarts, seed, best, vf, cmed, vf / cmed))
    print('   at |c_j| = %s, |Delta| = %.4f (2beta = %.4f)' % (np.round(np.linalg.norm(C, axis=1) / beta, 3), np.linalg.norm(D), 2 * beta))
