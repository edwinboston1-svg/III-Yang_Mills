"""pairmc.py -- AD: the maximal correlation of a pair of SU(2) (or U(1)) variables under a given joint density, by product quadrature
(Nystrom).  SU(2) = S^3: U = (cos a, sin a n), Haar = (2/pi) sin^2 a da dOmega/(4 pi); t = cos a by Gauss-Chebyshev of the 2nd kind
(m nodes), n by Gauss-Legendre (m) x uniform phi (2m): exact for polynomials of degree <= 2m - 1.  The maximal correlation is the second
singular value of the kernel  w_i^1/2 p(U_i, V_j) w_j^1/2 / sqrt(pU_i pV_j)  (the first is 1).
KAT: p = exp(theta Re(U V)), free marginals: rho = I_2(theta)/I_1(theta).
"""
import numpy as np
from scipy.special import iv

def s3_rule(m):
    k = np.arange(1, m + 1)
    t = np.cos(k * np.pi / (m + 1)); wt = (np.pi / (m + 1)) * np.sin(k * np.pi / (m + 1)) ** 2   # int sqrt(1-t^2) dt = pi/2
    wt = wt / wt.sum()
    z, wz = np.polynomial.legendre.leggauss(m); wz = wz / wz.sum()
    ph = 2 * np.pi * (np.arange(2 * m) + 0.5) / (2 * m); wp = np.full(2 * m, 1.0 / (2 * m))
    T, Z, PH = np.meshgrid(t, z, ph, indexing='ij')
    W = (wt[:, None, None] * wz[None, :, None] * wp[None, None, :]).ravel()
    s = np.sqrt(1 - T ** 2); r = np.sqrt(1 - Z ** 2)
    Q = np.stack([T, s * r * np.cos(PH), s * r * np.sin(PH), s * Z], axis=-1).reshape(-1, 4)
    return Q, W

def u1_rule(m):
    th = 2 * np.pi * (np.arange(m) + 0.5) / m
    Q = np.stack([np.cos(th), 0 * th, 0 * th, np.sin(th)], axis=-1)
    return Q, np.full(m, 1.0 / m)

def qmul(a, b):
    """quaternion product, broadcasting over leading axes; a, b [..., 4]"""
    aw, ax, ay, az = a[..., 0], a[..., 1], a[..., 2], a[..., 3]
    bw, bx, by, bz = b[..., 0], b[..., 1], b[..., 2], b[..., 3]
    return np.stack([aw * bw - ax * bx - ay * by - az * bz, aw * bx + ax * bw + ay * bz - az * by,
                     aw * by - ax * bz + ay * bw + az * bx, aw * bz + ax * by - ay * bx + az * bw], axis=-1)

def maxcorr(logp, W1, W2, k=3):
    """logp: [n1, n2] log density at the quadrature points (unnormalised); W1, W2 weights.  Returns the top singular values."""
    lp = logp - logp.max()
    P = np.exp(lp) * W1[:, None] * W2[None, :]
    P /= P.sum()
    pu = P.sum(1); pv = P.sum(0)
    Kt = P / np.sqrt(pu[:, None] * pv[None, :])
    s = np.linalg.svd(Kt, compute_uv=False)
    return s[:k]

if __name__ == '__main__':
    for m in [6, 8, 10]:
        Q, W = s3_rule(m)
        # exactness checks: E u0^2 = 1/4, E u0^4 = 1/8, E u1^2 u2^2 = 1/24
        print('S3 rule m=%d (%d points): E u0^2 = %.15f (1/4)  E u0^4 = %.15f (1/8)  E u1^2 u2^2 = %.15f (1/24)' % (
            m, len(W), (W * Q[:, 0] ** 2).sum(), (W * Q[:, 0] ** 4).sum(), (W * Q[:, 1] ** 2 * Q[:, 2] ** 2).sum()))
        for th in [0.1, 0.25, 1.0, 2.2]:
            ReUV = qmul(Q[:, None, :], Q[None, :, :])[..., 0]
            s = maxcorr(th * ReUV, W, W)
            print('   theta=%.2f: rho = %.12f   I2/I1 = %.12f   sigma1 = %.12f  sigma3 = %.6f' % (th, s[1], iv(2, th) / iv(1, th), s[0], s[2]))
