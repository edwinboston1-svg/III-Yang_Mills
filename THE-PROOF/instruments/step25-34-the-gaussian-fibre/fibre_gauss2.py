"""fibre_gauss2.py -- fibre_gauss.py vectorised: the same object (the free field's fibre covariance given every block average,
exact on Z^4 by the block Fourier transform), batched over the block momenta.  The pseudo-inverse on V_0 is taken exactly as
(A + c Pi)^{-1} - Pi/c with Pi = 1 1^T/16 (A kills the block-average direction on both sides, so A + c Pi is invertible and
the identity is exact for any c > 0).  Known answers: the full-field variance at m = 0 is Watson's G(0) = 0.154933390231;
the fibre's asymptotic rate is MF's cosh kappa_2 = 3, kappa_2 = 1.762747 per block (Theorem 3.1).
Usage: python fibre_gauss2.py [NK=48] [m=0.0] [dmax=10]
"""
import sys, itertools, time
import numpy as np

B = 2; NB = B ** 4
SITES = list(itertools.product(range(B), repeat=4)); IDX = {s: i for i, s in enumerate(SITES)}


def hop_matrices():
    """J_hat(K) = J0 + sum_mu (e^{iK_mu} Tp[mu] + e^{-iK_mu} Tm[mu]); J0 holds the diagonal and the in-block hops"""
    J0 = np.zeros((NB, NB)); Tp = np.zeros((4, NB, NB)); Tm = np.zeros((4, NB, NB))
    for s in SITES:
        i = IDX[s]; J0[i, i] += 8.0
        for mu in range(4):
            for sgn in (+1, -1):
                t = list(s); t[mu] += sgn
                if t[mu] == B: t[mu] = 0; Tp[mu, i, IDX[tuple(t)]] += -1.0
                elif t[mu] < 0: t[mu] = B - 1; Tm[mu, i, IDX[tuple(t)]] += -1.0
                else: J0[i, IDX[tuple(t)]] += -1.0
    return J0, Tp, Tm


def main():
    NK = int(sys.argv[1]) if len(sys.argv) > 1 else 48
    m = float(sys.argv[2]) if len(sys.argv) > 2 else 0.0
    dmax = int(sys.argv[3]) if len(sys.argv) > 3 else 10
    assert 2 * dmax < NK, 'aliasing: need NK > 2 dmax'
    J0, Tp, Tm = hop_matrices(); J0 = J0 + m * m * np.eye(NB)
    Pi = np.ones((NB, NB)) / NB; P0 = np.eye(NB) - Pi
    ks = 2.0 * np.pi * (np.arange(NK) - NK // 2 + 0.5) / NK
    E = np.exp(1j * ks)
    Cfib = np.zeros((dmax + 1, NB, NB), complex); Cfull = np.zeros((dmax + 1, NB, NB), complex)
    t0 = time.time()
    K2, K3 = np.meshgrid(ks, ks, indexing='ij'); e2 = np.exp(1j * K2).ravel(); e3 = np.exp(1j * K3).ravel()
    base23 = (e2[:, None, None] * Tp[2] + np.conj(e2)[:, None, None] * Tm[2] + e3[:, None, None] * Tp[3] + np.conj(e3)[:, None, None] * Tm[3])
    for i0, k0 in enumerate(ks):
        ph = np.exp(1j * k0 * np.arange(dmax + 1))
        for i1, k1 in enumerate(ks):
            J = J0 + E[i0] * Tp[0] + np.conj(E[i0]) * Tm[0] + E[i1] * Tp[1] + np.conj(E[i1]) * Tm[1] + base23   # (NK^2, 16, 16)
            A = P0 @ J @ P0
            Cf = np.linalg.inv(A + Pi) - Pi            # c = 1
            Cu = np.linalg.inv(J)
            sf = Cf.sum(axis=0); su = Cu.sum(axis=0)
            Cfib += ph[:, None, None] * sf[None]; Cfull += ph[:, None, None] * su[None]
    Cfib /= NK ** 4; Cfull /= NK ** 4
    print('FIBRE COVARIANCE ALONG AN AXIS, L = 2, m = %g, NK = %d, %.0fs (known answer kappa = arccosh 3 = 1.762747 per block)' % (m, NK, time.time() - t0))
    nf = [np.linalg.norm(Cfib[d], 2) for d in range(dmax + 1)]; nu = [np.linalg.norm(Cfull[d], 2) for d in range(dmax + 1)]
    print('  d   |C_fib(d)|_op      ratio      rate     |   |C_full(d)|_op    ratio   (2d/(2d+2))^2')
    for d in range(dmax + 1):
        rf = nf[d] / nf[d - 1] if d else float('nan'); ru = nu[d] / nu[d - 1] if d else float('nan')
        print('  %2d  %.6e   %8.5f  %8.5f   |   %.6e   %8.5f   %8.5f' % (d, nf[d], rf, -np.log(rf) if d else float('nan'), nu[d], ru, ((2 * d) / (2 * d + 2)) ** 2 if d else float('nan')))
    print('  imag residue fibre %.1e full %.1e' % (abs(Cfib.imag).max(), abs(Cfull.imag).max()))
    print('  full-field variance %.9f (Watson 0.154933390231); in-block fibre variance %.9f' % (np.real(np.trace(Cfull[0])) / NB, np.real(np.trace(Cfib[0])) / NB))
    # the slowest fibre mode: the largest eigenvalue ratio of the Hermitian blocks is a sharper rate than the author norm
    lam = [np.linalg.eigvalsh((Cfib[d] + Cfib[d].conj().T) / 2) for d in range(dmax + 1)]
    print('  rate from the largest eigenvalue, d = %d -> %d: %.5f ; cosh(rate) = %.5f (MF: 3)' % (dmax - 1, dmax, -np.log(lam[dmax].max() / lam[dmax - 1].max()), np.cosh(-np.log(lam[dmax].max() / lam[dmax - 1].max()))))


if __name__ == '__main__':
    main()
