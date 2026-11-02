"""M8 C1c READING: the real-space l1 norm of the fluctuation covariance (slice gauge, per colour), and of the curvature covariance,
for L = 2 half-open blocks, on the torus of nk coarse cells per direction (fine side 2 nk): for every source link (x0, mu0) in the cell,
S(x0, mu0) = beta * sum_{y, nu} |C((x0, mu0), (y, nu))|, and the decay of max_{nu} |C| with the coarse distance.

Run: python -u -E -P bin/m8_c1c_l1norm.py nk
"""
import sys, itertools, time
import numpy as np
sys.path.insert(0, __file__.rsplit('\\', 1)[0] if '\\' in __file__ else __file__.rsplit('/', 1)[0])
from m8_blockspin import BlockSpin

nk = int(sys.argv[1])
L = 2
bs = BlockSpin(L, 'half'); nal = bs.nal
grid1 = (np.arange(nk)) / nk * (2 * np.pi / L) - np.pi / L + np.pi / (L * nk)   # shifted grid (avoids k = 0)
ks = np.array(list(itertools.product(grid1, repeat=4)))
xs = np.array(list(itertools.product(range(L), repeat=4)))
# store Sig(k) in the alias basis
t0 = time.time()
SIG = np.zeros((len(ks), 4 * nal, 4 * nal), complex)
for i, k in enumerate(ks):
    Pk, Qk, Mk, Gk = bs.mats(k)
    N, T, rank, rg, resid = bs.gauge_inv_basis(Qk, Gk)
    H = T.conj().T @ Mk @ T
    SIG[i] = T @ np.linalg.solve(H, T.conj().T)
print("covariances computed: %d k-points, %.1f s" % (len(ks), time.time() - t0))
# real-space kernel: C((x0,mu0),(Y + r, nu)) = (1/(nk^4 L^4)) sum_k e^{-i k Y} sum_{m,m'} e^{i p_m x0} e^{-i p_m' r} SIG_k[(m,mu0),(m',nu)]
# (normalisation: the unconditioned check Var = (1/beta) * this at zero distance reproduces the C1 link variances)
Pall = ks[:, None, :] + 2 * np.pi * bs.mvec[None, :, :] / L          # (nk^4, nal, 4)
res = {}
for (ix, x0) in enumerate(xs):
    for mu0 in range(4):
        ph0 = np.exp(1j * np.einsum('kmd,d->km', Pall, x0))            # (nK, nal)
        tot = 0.0
        diag0 = 0.0
        maxd = {}
        for (ir, r) in enumerate(xs):
            phr = np.exp(-1j * np.einsum('kmd,d->km', Pall, r))          # (nK, nal)
            for nu in range(4):
                # g(k) = sum_{m,m'} ph0[k,m] phr[k,m'] SIG[k,(m,mu0),(m',nu)]
                g = np.einsum('km,kn,kmn->k', ph0, phr, SIG[:, mu0::4, nu::4]) / L ** 4
                G = g.reshape((nk,) * 4)
                # inverse transform over the coarse torus: C(Y) = (1/nk^4) sum_k e^{-i k Y} g(k); include the shift phase
                # k = 2 pi j/(L nk) + k_shift ; use explicit sum via FFT on j with the shift handled by a phase on Y
                Cj = np.fft.fftn(G) / nk ** 4                              # sum_j e^{-2 pi i j.Y / nk} g / nk^4
                Ys = np.array(list(itertools.product(range(nk), repeat=4)))
                kshift = grid1[0]
                phase = np.exp(-1j * kshift * L * Ys.sum(axis=1)).reshape((nk,) * 4)
                CY = (Cj * phase).real
                tot += np.abs(CY).sum()
                if ir == ix and nu == mu0:
                    diag0 = CY[(0,) * 4]
                dist = np.max(np.minimum(Ys, nk - Ys), axis=1).reshape((nk,) * 4)
                for dd in range(nk // 2 + 1):
                    m = np.abs(CY[dist == dd]).max()
                    maxd[dd] = max(maxd.get(dd, 0.0), m)
        res[(tuple(int(v) for v in x0), mu0)] = (tot, diag0, maxd)
vals = sorted(res.items(), key=lambda kv: -kv[1][0])
print("beta * sum_{y,nu} |C((x0,mu0),(y,nu))| (per colour), largest five sources:")
for key, (tot, d0, maxd) in vals[:5]:
    print("  source %s: l1 = %.5f ; variance (diag) = %.5f ; max |C| at coarse distance 0..%d: %s" % (
        key, tot, d0, nk // 2, " ".join("%.2e" % maxd[d] for d in sorted(maxd))))
print("smallest: %s l1 = %.5f" % (vals[-1][0], vals[-1][1][0]))
print("max over sources of the l1 norm: %.5f ; mean %.5f" % (max(v[0] for v in res.values()), np.mean([v[0] for v in res.values()])))
