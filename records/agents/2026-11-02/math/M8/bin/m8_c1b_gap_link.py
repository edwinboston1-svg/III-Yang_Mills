"""M8 C1b READING: (i) the fluctuation gap gamma0 refined (local minimisation from the grid minimum, plus the zone faces and
corners); (ii) the per-colour LINK variance of the fluctuation in the slice gauge (ker Q minus the residual gauge, l2-orthogonal),
K_link = beta * max over link positions of Var(B_l^a | coarse), averaged over the coarse zone on a midpoint grid; (iii) the same for
the unconstrained Landau gauge (known answer: (3/4) * Z0-type integral int d^4p/(2pi)^4 1/|phat|^2 = 0.75 * 0.154933 = 0.1162).

Run: python -E -P bin/m8_c1b_gap_link.py L kind nk
"""
import sys, itertools, time
import numpy as np
from scipy.optimize import minimize
sys.path.insert(0, __file__.rsplit('\\', 1)[0] if '\\' in __file__ else __file__.rsplit('/', 1)[0])
from m8_blockspin import BlockSpin

L = int(sys.argv[1]); kind = sys.argv[2]; nk = int(sys.argv[3])
bs = BlockSpin(L, kind); nal = bs.nal


def gap(k):
    Pk, Qk, Mk, Gk = bs.mats(np.asarray(k, float))
    N, T, rank, rg, resid = bs.gauge_inv_basis(Qk, Gk)
    return np.linalg.eigvalsh(T.conj().T @ Mk @ T)[0]


print("M8 C1b: L = %d %s" % (L, kind))
h = np.pi / L
# faces / corners scan: k_mu in {0, h/2, h} combinations (h = zone half-width; k = h is the face)
best = (np.inf, None)
for kk in itertools.product([0.0, 0.25 * h, 0.5 * h, 0.75 * h, h], repeat=4):
    if all(x == 0.0 for x in kk):
        continue
    g = gap(kk)
    if g < best[0]:
        best = (g, kk)
print("scan of the 5^4 lattice {0, h/4, h/2, 3h/4, h}^4 (h = pi/L), k != 0: min gamma0 = %.6f at k/h = %s" % (best[0], np.round(np.array(best[1]) / h, 3)))
# near k = 0 along a few directions
for t in [1e-1, 1e-2, 1e-3]:
    print("  near k=0, k = (%g,0,0,0)*h: gamma0 = %.6f ; k = %g*(1,1,1,1)*h: %.6f" % (t, gap([t * h, 0, 0, 0]), t, gap([t * h] * 4)))
res = minimize(lambda k: gap(np.clip(k, -h, h)), x0=np.array(best[1]), method='Nelder-Mead',
               options={'xatol': 1e-6, 'fatol': 1e-10, 'maxiter': 2000})
print("local minimisation from the scan minimum: gamma0 = %.8f at k/h = %s (%s)" % (res.fun, np.round(np.clip(res.x, -h, h) / h, 5), res.message))

# link variance in the slice gauge
grid1 = (np.arange(nk) + 0.5) / nk * (2 * h) - h
xs = np.array(list(itertools.product(range(L), repeat=4)))
accL = np.zeros((len(xs), 4))
accLandau = 0.0
cnt = 0
t0 = time.time()
for kk in itertools.product(grid1, repeat=4):
    k = np.array(kk)
    Pk, Qk, Mk, Gk = bs.mats(k)
    N, T, rank, rg, resid = bs.gauge_inv_basis(Qk, Gk)
    H = T.conj().T @ Mk @ T
    Sig = T @ np.linalg.solve(H, T.conj().T)                  # covariance of the alias vector (slice gauge)
    ph_x = np.exp(1j * xs @ Pk.T)                            # (npos, nal)
    for mu in range(4):
        # link (x, mu): A_mu(x) = sum_m e^{i p_m x} A_mu(p_m)  -> vector with entries e^{i p_m x} at slot (m, mu)
        U = np.zeros((len(xs), 4 * nal), complex)
        U[:, mu::4] = ph_x
        accL[:, mu] += np.einsum('ij,jk,ik->i', U, Sig, U.conj()).real
    ph = bs.phat(Pk)
    a2 = (np.abs(ph) ** 2).sum(axis=1)
    accLandau += (0.75 / a2).sum()       # Landau gauge: per colour per direction, trace of P_perp / |phat|^2 averaged over mu = (3/4)/|phat|^2
    cnt += 1
accL /= (cnt * L ** 4)
accLandau /= (cnt * L ** 4)
print("grid %d points, %.1f s" % (cnt, time.time() - t0))
print("slice-gauge link variance beta*Var(B_l^a | coarse): min %.6f max %.6f mean %.6f" % (accL.min(), accL.max(), accL.mean()))
vals = {}
for i, x in enumerate(xs):
    for mu in range(4):
        vals.setdefault(round(accL[i, mu], 5), []).append((tuple(int(v) for v in x), mu))
for v in sorted(vals):
    print("  %.5f x%d  e.g. %s" % (v, len(vals[v]), vals[v][0]))
print("unconstrained Landau-gauge link variance (midpoint grid on the fine zone, reading): %.6f  [known: 0.75*0.154933 = 0.116200]" % accLandau)
