"""CVX kill-switch (S-K.1, S-K.2): the analytic [EXP] plaquette Hessian against M8's finite-difference instrument, h1 against the
t-derivative of h(t phi), and the free slice gaps of both tori.  READING (double precision).
Run: python -u -E -P code/cvx_kat.py > rec/kat.<date>.txt
"""
import sys, time, os
import numpy as np
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from cvx_core import plaq_value, plaq_hess, plaq_h1, h0_plaq, Torus

SIG = np.array([[[0, 1], [1, 0]], [[0, -1j], [1j, 0]], [[1, 0], [0, -1]]], dtype=complex)


def su2(theta):                     # M8's verbatim
    r = np.linalg.norm(theta, axis=-1)
    c = np.cos(r)
    s = np.where(r > 1e-300, np.sin(r) / np.where(r > 1e-300, r, 1.0), 1.0)
    return c[..., None, None] * np.eye(2) + 1j * s[..., None, None] * np.einsum('...k,kij->...ij', theta, SIG)


def Fp_M8(phi):                     # M8's verbatim
    U1, U2, U3, U4 = su2(phi[..., 0, :]), su2(phi[..., 1, :]), su2(-phi[..., 2, :]), su2(-phi[..., 3, :])
    P = U1 @ U2 @ U3 @ U4
    return 1.0 - 0.5 * np.real(np.trace(P, axis1=-2, axis2=-1))


H_STEP = 1e-4
EYE12 = np.eye(12)


def hess_M8(phi):                   # M8's verbatim finite differences
    n = phi.shape[0]
    x = phi.reshape(n, 12)
    h = H_STEP
    pairs = [(i, j) for i in range(12) for j in range(i, 12)]
    out = np.zeros((n, 12, 12))
    pts = []
    for (i, j) in pairs:
        for si, sj in ((1, 1), (1, -1), (-1, 1), (-1, -1)):
            pts.append(si * h * EYE12[i] + sj * h * EYE12[j])
    D = np.array(pts)
    X = x[:, None, :] + D[None, :, :]
    f = Fp_M8(X.reshape(n, -1, 4, 3)).reshape(n, len(pairs), 4)
    vals = (f[:, :, 0] - f[:, :, 1] - f[:, :, 2] + f[:, :, 3]) / (4 * h * h)
    for idx, (i, j) in enumerate(pairs):
        out[:, i, j] = vals[:, idx]
        out[:, j, i] = vals[:, idx]
    return out


def main():
    rng = np.random.default_rng(20261102)
    t0 = time.time()
    # random phi in the unit ball per link
    n = 500
    d = rng.normal(size=(n, 4, 3)); d /= np.linalg.norm(d, axis=-1, keepdims=True)
    rad = rng.uniform(0, 1, size=(n, 4, 1)) ** (1 / 3)
    phi = d * rad
    print("S-K.1 (a) value: max |F_analytic - F_M8| over %d random phi (|phi_i| <= 1) = %.2e" % (n, np.abs(plaq_value(phi) - Fp_M8(phi)).max()))
    Ha, Hm = plaq_hess(phi), hess_M8(phi)
    print("S-K.1 (b) Hessian: max entry |H_analytic - H_M8fd| = %.3e (M8's finite-difference error ~1e-8)" % np.abs(Ha - Hm).max())
    print("          symmetric: %.1e" % np.abs(Ha - np.transpose(Ha, (0, 2, 1))).max())
    H00 = plaq_hess(np.zeros((1, 4, 3)))[0]
    print("S-K.1 (c) h0 eigenvalues:", np.round(np.linalg.eigvalsh(H00), 12), " |h0 - (ss^T)xI3| = %.1e" % np.abs(H00 - h0_plaq()).max())
    eps = 1e-4
    fd1 = (plaq_hess(eps * phi) - plaq_hess(-eps * phi)) / (2 * eps)
    H1 = plaq_h1(phi)
    print("S-K.1 (d) h1 vs central difference of h(t phi) at t = 0: max entry diff = %.3e" % np.abs(fd1 - H1).max())
    b = np.linalg.norm(phi, axis=-1).max(axis=1)
    nrm = np.abs(np.linalg.eigvalsh(H1)).max(axis=1)
    print("S-K.1 (e) ||h1(phi)|| / max|phi_i|: max %.4f, mean %.4f (M8 11.1: <= 6)" % ((nrm / b).max(), (nrm / b).mean()))
    # small-b sup of ||h(phi)-h0|| / b by multistart (M8's e(b)/b ~ 4.7 at b = 0.01 was a hill-climbed lower bound)
    best = 0.0
    for trial in range(4000):
        dd = rng.normal(size=(1, 4, 3)); dd /= np.linalg.norm(dd, axis=-1, keepdims=True)
        v = np.abs(np.linalg.eigvalsh(plaq_h1(dd))).max()
        best = max(best, v)
    print("          sup over 4000 random sphere configurations of ||h1||/b = %.4f (M8's e(b)/b at b = 0.01: 4.701)" % best)
    print("          (%.1f s)" % (time.time() - t0))
    for L in (2, 3):
        t1 = time.time()
        T = Torus(L)
        print("S-K.2 L = %d torus %s: sites %d, links %d, plaquettes %d, constraint rank %d, dim V0 = %d (per colour), dim V = %d"
              % (L, tuple(T.ext), T.nS, T.nLk, T.nP, T.rankC, T.dimV0, 3 * T.dimV0))
        print("       Q0 integer rows %s, max |entry| %d, SCALE %d; G0 columns %d; |Q0 G0| = %d"
              % (T.Q0.shape, np.abs(T.Q0).max(), T.SCALE, T.G0.shape[1], np.abs(T.Q0 @ T.G0).max()))
        Hz = T.hess(np.zeros(3 * T.nLk))
        print("       |assembled analytic H(0) - kron(curl^T curl, I3)| = %.1e" % np.abs(Hz - T.H0()).max())
        w0 = np.linalg.eigvalsh(T.T0.T @ T.H0c @ T.T0)
        print("       per-colour free slice: lambda_min = %.10f, next %s" % (w0[0], np.round(w0[1:6], 6)))
        if L == 2:
            Tf = T.full_T()
            wf = np.linalg.eigvalsh(Tf.T @ Hz @ Tf)
            print("       full 3-colour slice: lambda_min = %.10f (M8: 1.849564)" % wf[0])
        print("       (%.1f s)" % (time.time() - t1))


if __name__ == '__main__':
    main()
