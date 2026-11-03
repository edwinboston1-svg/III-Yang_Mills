"""M8b N2 READING: loop sums of the slice-gauge fluctuation covariance (per colour, beta = 1) against their tree-graph substitutes.

For every source link (x0, mu0) in one coarse cell:  S_k(x0, mu0) = sum_{y, nu} |C((x0, mu0), (y, nu))|^k, k = 1, 2, 3, and the diagonal
C_00 = C((x0, mu0), (x0, mu0)).  A tree-graph (Brydges-Kennedy / Battle-Federbush) bound replaces every loop line by a sup and keeps one
l1 sum per vertex: the sunset sum S_3 is replaced by C_max^2 S_1, the bubble S_2 by C_max S_1.  The ratios printed are what a
loop-preserving remainder bound gains per two- and three-line loop.  Covariance as M8's m8_c1c_l1norm.py (its normalisation: the diagonal
reproduces M8's link variances 0.13145 / 0.09910 at L = 2).
Run: python -u -E -P bin/m8b_loopsums.py L kind nk > rec/loopsums_L{L}.<date>.txt
"""
import sys, itertools, time
import numpy as np
sys.path.insert(0, __file__.rsplit('\\', 1)[0] if '\\' in __file__ else __file__.rsplit('/', 1)[0])
from m8_blockspin import BlockSpin

L = int(sys.argv[1]); kind = sys.argv[2]; nk = int(sys.argv[3])
bs = BlockSpin(L, kind); nal = bs.nal
grid1 = (np.arange(nk)) / nk * (2 * np.pi / L) - np.pi / L + np.pi / (L * nk)
ks = np.array(list(itertools.product(grid1, repeat=4)))
xs = np.array(list(itertools.product(range(L), repeat=4)))
t0 = time.time()
SIG = np.zeros((len(ks), 4 * nal, 4 * nal), complex)
for i, k in enumerate(ks):
    Pk, Qk, Mk, Gk = bs.mats(k)
    N, T, rank, rg, resid = bs.gauge_inv_basis(Qk, Gk)
    H = T.conj().T @ Mk @ T
    SIG[i] = T @ np.linalg.solve(H, T.conj().T)
print("M8b loop sums: L = %d %s, coarse torus nk = %d (fine side %d); covariances %.1f s" % (L, kind, nk, L * nk, time.time() - t0))
Pall = ks[:, None, :] + 2 * np.pi * bs.mvec[None, :, :] / L
Ys = np.array(list(itertools.product(range(nk), repeat=4)))
kshift = grid1[0]
phase = np.exp(-1j * kshift * L * Ys.sum(axis=1)).reshape((nk,) * 4)
rows = []
for (ix, x0) in enumerate(xs):
    for mu0 in range(4):
        ph0 = np.exp(1j * np.einsum('kmd,d->km', Pall, x0))
        S = np.zeros(4); c00 = 0.0
        for (ir, r) in enumerate(xs):
            phr = np.exp(-1j * np.einsum('kmd,d->km', Pall, r))
            for nu in range(4):
                g = np.einsum('km,kn,kmn->k', ph0, phr, SIG[:, mu0::4, nu::4]) / L ** 4
                CY = (np.fft.fftn(g.reshape((nk,) * 4)) / nk ** 4 * phase).real
                a = np.abs(CY)
                S[1] += a.sum(); S[2] += (a ** 2).sum(); S[3] += (a ** 3).sum()
                if ir == ix and nu == mu0:
                    c00 = CY[(0,) * 4]
        rows.append((tuple(int(v) for v in x0), mu0, c00, S[1], S[2], S[3]))
rows.sort(key=lambda r: -r[3])
cmax = max(r[2] for r in rows)
print("source link | C_00 | S_1 (l1) | S_2 | S_3 | S_2/(C_max S_1) | S_3/(C_max^2 S_1)")
for r in rows[:6] + rows[-2:]:
    print("  %s mu=%d | %.5f | %.5f | %.6f | %.7f | %.4f | %.4f" % (r[0], r[1], r[2], r[3], r[4], r[5], r[4] / (cmax * r[3]), r[5] / (cmax ** 2 * r[3])))
S1 = max(r[3] for r in rows); S2 = max(r[4] for r in rows); S3 = max(r[5] for r in rows)
print("maxima over sources: C_max %.5f, S_1 %.5f, S_2 %.6f, S_3 %.7f ; tree substitutes C_max S_1 = %.5f, C_max^2 S_1 = %.6f ; gains %.2f (bubble), %.2f (sunset)"
      % (cmax, S1, S2, S3, cmax * S1, cmax ** 2 * S1, cmax * S1 / S2, cmax ** 2 * S1 / S3))
print("done [%.0f s]" % (time.time() - t0))
