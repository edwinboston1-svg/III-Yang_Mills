"""fibre_gauss.py -- THE FIBRE'S COLLECTIVE CLUSTERING RATE, THE GAUSSIAN TOOTH (Theorem X (ii) of THE CROSSING CAMPAIGN §29;
built by hand by the author, 2026-11-02 13:4x).

The fibre of the averaging block map is the law of the fine field given every block average.  For the free scalar field on Z^4
with precision J = -Delta + m^2 and blocks of side L, the fibre is Gaussian with covariance C_fib = P (P J P)^{-1} P, P the
projection onto the block-zero-mean subspace V_0 (MF, Theorem G).  Exact on Z^4 by the block (supercell) Fourier transform:
J is block-circulant on the block lattice, so in the basis (block momentum K, in-block site u) it is a 16 x 16 matrix J_hat(K)
per K, and C_fib(X, u; Y, v) = int dK/(2 pi)^4 e^{iK.(X - Y)} [P_0 J_hat(K) P_0]^{+}(u, v), the pseudo-inverse on the
15-dimensional zero-mean subspace (P_0 = I - (1/16) 1 1^T is K-independent because every block average is the same linear form).
The collective rate: the author norm of the 16 x 16 block C_fib(X, Y) at block distance d along an axis decays as e^{-kappa d};
KNOWN ANSWER (MF Theorem 3.1): cosh kappa_L = 2 + 3/(L^2 - 1), kappa_2 = arccosh 3 = 1.762747 per block, independent of m and d.
Two-sided: the massless field's FULL covariance (no block constraint) decays as a power law; the instrument must read that too.
Usage: python fibre_gauss.py [NK=48] [m=0.0]
"""
import sys, itertools
import numpy as np

L = 4  # kept as a name for the lattice dimension in comments; the block side is B
B = 2
NB = B ** 4
SITES = list(itertools.product(range(B), repeat=4))
IDX = {s: i for i, s in enumerate(SITES)}


def jhat(K, m2):
    """J_hat(K): the 16 x 16 precision of the free field at block momentum K (K in [-pi, pi)^4 on the block lattice)"""
    J = np.zeros((NB, NB), complex)
    for s in SITES:
        i = IDX[s]
        J[i, i] += 8.0 + m2
        for mu in range(4):
            for sgn in (+1, -1):
                t = list(s); t[mu] += sgn
                shift = 0
                if t[mu] == B: t[mu] = 0; shift = +1
                if t[mu] < 0: t[mu] = B - 1; shift = -1
                j = IDX[tuple(t)]
                J[i, j] += -1.0 * np.exp(1j * shift * K[mu])
    return J


def main():
    NK = int(sys.argv[1]) if len(sys.argv) > 1 else 48
    m = float(sys.argv[2]) if len(sys.argv) > 2 else 0.0
    m2 = m * m
    ks = 2.0 * np.pi * (np.arange(NK) - NK // 2 + 0.5) / NK      # midpoint grid avoids K = 0 exactly (massless full field)
    P0 = np.eye(NB) - np.ones((NB, NB)) / NB
    # C_fib along axis 0 for block distances d = 0..6, and the FULL covariance C_full for the two-sided control
    dmax = 6
    Cfib = np.zeros((dmax + 1, NB, NB), complex); Cfull = np.zeros((dmax + 1, NB, NB), complex)
    for k0 in ks:
        for k1 in ks:
            for k2 in ks:
                for k3 in ks:
                    K = (k0, k1, k2, k3)
                    J = jhat(K, m2)
                    A = P0 @ J @ P0
                    Cf = np.linalg.pinv(A, rcond=1e-12, hermitian=True)   # the inverse on V_0, zero on the block-average direction
                    Cu = np.linalg.inv(J)
                    for d in range(dmax + 1):
                        ph = np.exp(1j * k0 * d)
                        Cfib[d] += ph * Cf; Cfull[d] += ph * Cu
    Cfib /= NK ** 4; Cfull /= NK ** 4
    print('FIBRE COVARIANCE ALONG AN AXIS, L = 2, m = %g, NK = %d (known answer kappa = arccosh 3 = 1.762747 per block)' % (m, NK))
    nf = [np.linalg.norm(Cfib[d], 2) for d in range(dmax + 1)]
    nu = [np.linalg.norm(Cfull[d], 2) for d in range(dmax + 1)]
    print('  d   |C_fib(d)|_op      ratio     rate    |   |C_full(d)|_op   ratio   (the unconstrained field: power law, no rate)')
    for d in range(dmax + 1):
        rf = nf[d] / nf[d - 1] if d else float('nan'); ru = nu[d] / nu[d - 1] if d else float('nan')
        print('  %d   %.6e   %8.5f  %8.5f   |   %.6e   %8.5f' % (d, nf[d], rf, -np.log(rf) if d else float('nan'), nu[d], ru))
    print('  imag residue fibre %.1e full %.1e' % (abs(Cfib.imag).max(), abs(Cfull.imag).max()))
    print('  in-block fibre variance (d = 0, diagonal mean) %.6f ; full-field variance %.6f' % (np.real(np.trace(Cfib[0])) / NB, np.real(np.trace(Cfull[0])) / NB))


if __name__ == '__main__':
    main()
