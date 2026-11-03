"""M8b THE GRIBOV CHECK (READING): at a soft-mode ray crossing (L = 2 torus slice), is the negative eigenvector v of the slice Hessian a
GAUGE-ORBIT TANGENT at the configuration B?  Gauge tangents at B: for every non-trivial site x and colour a, the derivative of the link
coordinates under U_l -> g U_l h^{-1} with g = exp(i eps sigma_a) at the link's tail (x) or h at its head (x + mu); computed by central
differences of the exponential coordinates B_l = log U_l (principal branch).  Prints the overlap |P_gauge v|/|v| (P_gauge the orthogonal
projector on the span of the 3 N_s tangents at B), its value for a random slice vector (the control: random vectors overlap by about
sqrt(dim span / 384)), and the same at the origin (where the slice is orthogonal to the gauge directions by construction: overlap 0).
Run: python -u -E -P bin/m8b_gribov.py WEIGHT BETA > rec/gribov_<w>.<date>.txt
"""
import os, sys
import numpy as np
here = os.path.dirname(os.path.abspath(__file__))
WEIGHT = sys.argv[1]; BETA = sys.argv[2]
sys.argv = [sys.argv[0], WEIGHT, BETA, '0', 'none', '']
src = open(os.path.join(here, 'm8b_weights.py'), encoding='utf-8').read()
cut = src.index("if 'repro' in MODES:")
exec(src[:cut])


def log_su2(U):
    """U (2x2) -> B with U = exp(i B.sigma), principal branch |B| <= pi."""
    c = U[0, 0].real
    v = np.array([U[0, 1].imag, U[0, 1].real, U[0, 0].imag])
    s = np.linalg.norm(v)
    th = np.arctan2(s, c)
    return v * (th / s if s > 1e-14 else 1.0)


def links_U(B):
    return su2(B.reshape(nLk, 3))


def gauge_tangents(B, eps=1e-6):
    Ul = links_U(B)
    cols = []
    for si, s in enumerate(sites):
        for a in range(3):
            g_p = su2(eps * np.eye(3)[a]); g_m = su2(-eps * np.eye(3)[a])
            dB = np.zeros(nV)
            for mu in range(4):
                l_out = lid(s, mu)                        # link leaving s: U -> g U
                l_in = lid(s - E[mu], mu)                 # link entering s: U -> U g^{-1}
                dB[3 * l_out:3 * l_out + 3] += (log_su2(g_p @ Ul[l_out]) - log_su2(g_m @ Ul[l_out])) / (2 * eps)
                dB[3 * l_in:3 * l_in + 3] += (log_su2(Ul[l_in] @ g_m) - log_su2(Ul[l_in] @ g_p)) / (2 * eps)
            cols.append(dB)
    return np.array(cols).T


def overlap(vec, Gt):
    Qg, Rg = np.linalg.qr(Gt)
    keep = np.abs(np.diag(Rg)) > 1e-9 * np.abs(np.diag(Rg)).max()
    Qg = Qg[:, keep]
    return np.linalg.norm(Qg.T @ vec) / np.linalg.norm(vec), Qg.shape[1]


rng = np.random.default_rng(5)
Gt0 = gauge_tangents(np.zeros(nV))
o0, r0 = overlap(T @ rng.normal(size=T.shape[1]), Gt0)
print("at B = 0: gauge tangent span rank %d; overlap of a random slice vector with it %.2e (the slice is orthogonal there by construction)" % (r0, o0))
for j in range(4):
    d = v0[:, j]
    B1 = T @ d
    B1 = B1 / np.linalg.norm(B1.reshape(nLk, 3), axis=1).max()
    lo, hi = 0.0, None
    for t in np.arange(0.05, 1.8001, 0.05):
        lm, am = lam_min(t * B1)
        if lm < 0:
            hi = t; break
        lo = t
    for _ in range(20):
        mid = 0.5 * (lo + hi)
        lm, am = lam_min(mid * B1)
        if lm < 0:
            hi = mid
        else:
            lo = mid
    Bc = hi * B1
    Hf, ang = hess_full(Bc)
    w, U = np.linalg.eigh(T.T @ Hf @ T)
    v = T @ U[:, 0]
    Gt = gauge_tangents(Bc)
    ov, rk = overlap(v, Gt)
    ovr = np.mean([overlap(T @ rng.normal(size=T.shape[1]), Gt)[0] for _ in range(20)])
    ov2, _ = overlap(T @ U[:, 1], Gt)
    print("soft mode %d: crossing b = %.5f, lambda_min = %.2e, max plaquette angle %.4f | gauge span rank at B: %d | overlap of the negative "
          "eigenvector with the gauge tangent space: %.6f | second eigenvector (lambda %.4f): %.4f | random slice vectors (mean of 20): %.4f"
          % (j, hi, w[0], ang.max(), rk, ov, w[1], ov2, ovr))
    sys.stdout.flush()
