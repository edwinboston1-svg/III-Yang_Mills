"""M8 C1 READING (double precision; never enters a bound): the free constrained fluctuation problem for L = 3 centred and
L = 2 half-open.  Prints: the gauge-covariance identity residual, the zero-mode count of M on ker Q, the gap gamma0(k), the
conditional per-colour plaquette variance beta*Var(F_{mu nu}(x) | coarse) at every position and orientation, the unconditioned
value (known answer 1/2), the tree-level coarse kernel against the coarse Wilson kernel at small k, and the xi-conditioned
variance at one k (corrected stake S-C1.5').

Run: python -E -P bin/m8_c1_reading.py L kind nk > rec/c1_reading_L{L}_{kind}.<date>.txt
"""
import sys, time, itertools
import numpy as np
sys.path.insert(0, __file__.rsplit('\\', 1)[0] if '\\' in __file__ else __file__.rsplit('/', 1)[0])
from m8_blockspin import BlockSpin

L = int(sys.argv[1]); kind = sys.argv[2]; nk = int(sys.argv[3])
bs = BlockSpin(L, kind)
nal = bs.nal
print("M8 C1 reading: L = %d, blocks = %s, nk = %d per direction (midpoint grid on the coarse zone)" % (L, kind, nk))
print("contour steps aggregated: %d" % len(bs.steps))

# 1. gauge covariance identity: sum_nu Qhat_{mu nu}(p) phat_nu = exp(i L p_mu) - 1
rng = np.random.default_rng(1)
P = rng.uniform(-np.pi, np.pi, size=(200, 4))
Qh = bs.Qhat(P)
lhs = np.einsum('nij,nj->ni', Qh, bs.phat(P))
rhs = np.exp(1j * L * P) - 1.0
print("gauge covariance identity max residual over 200 random p: %.3e" % np.abs(lhs - rhs).max())
Q0 = bs.Qhat(np.zeros((1, 4)))[0]
print("Qhat(0) (expect L * identity):", np.round(Q0.real, 12).diagonal(), " offdiag max %.2e" % np.abs(Q0 - np.diag(Q0.diagonal())).max())

planes = [(mu, nu) for mu in range(4) for nu in range(mu + 1, 4)]
xs = np.array(list(itertools.product(range(L), repeat=4)))      # positions mod L
grid1 = (np.arange(nk) + 0.5) / nk * (2 * np.pi / L) - np.pi / L
acc = np.zeros((len(xs), 6))
acc0 = np.zeros((len(xs), 6))
g0min, g0arg = np.inf, None
zero_counts = set()
gmax_seen = 0.0
resid_max = 0.0
t0 = time.time()
count = 0
for kk in itertools.product(grid1, repeat=4):
    k = np.array(kk)
    Pk, Qk, Mk, Gk = bs.mats(k)
    N, T, rank, rg, resid = bs.gauge_inv_basis(Qk, Gk)
    resid_max = max(resid_max, resid)
    ev_N = np.linalg.eigvalsh(N.conj().T @ Mk @ N)
    nzero = int((np.abs(ev_N) < 1e-9).sum())
    zero_counts.add((rank, rg, nzero))
    H = T.conj().T @ Mk @ T
    ev = np.linalg.eigvalsh(H)
    if ev[0] < g0min:
        g0min, g0arg = ev[0], k.copy()
    gmax_seen = max(gmax_seen, ev[-1])
    Hinv = np.linalg.inv(H)
    Sig = T @ Hinv @ T.conj().T                                   # (4nal, 4nal)
    _, W = bs.wvecs(Pk)                                           # (6, nal, 4)
    ph_x = np.exp(1j * xs @ Pk.T)                                 # (npos, nal)
    for a in range(6):
        U = (ph_x[:, :, None] * W[a][None, :, :]).reshape(len(xs), 4 * nal)   # rows u_x^T
        v = np.einsum('ij,jk,ik->i', U, Sig, U.conj()).real
        acc[:, a] += v
        # unconditioned: sum_m (|phat_mu|^2 + |phat_nu|^2)/|phat|^2 at the aliases (position independent)
    ph = bs.phat(Pk)
    a2 = (np.abs(ph) ** 2)
    for a, (mu, nu) in enumerate(planes):
        acc0[:, a] += ((a2[:, mu] + a2[:, nu]) / a2.sum(axis=1)).sum()
    count += 1
acc /= (count * L ** 4)
acc0 /= (count * L ** 4)
print("grid points: %d, time %.1f s" % (count, time.time() - t0))
print("(rank Q, gauge dim in ker Q, zero modes of M on ker Q) seen:", sorted(zero_counts), " expected (4, %d, %d)" % (nal - 1, nal - 1))
print("gauge-direction residual outside ker Q (max): %.2e" % resid_max)
print("gamma0 = min over grid of the smallest eigenvalue of M on (ker Q minus residual gauge): %.6f at k = %s" % (g0min, np.round(g0arg, 4)))
print("largest eigenvalue seen: %.6f (the Wilson form's norm is 16 per colour)" % gmax_seen)
print("unconditioned beta*Var(F) per orientation (known answer 0.5): min %.8f max %.8f" % (acc0.min(), acc0.max()))
print("conditional beta*Var(F | coarse): min %.6f max %.6f mean %.6f" % (acc.min(), acc.max(), acc.mean()))
# list distinct values by orientation class
vals = {}
for i, x in enumerate(xs):
    for a, (mu, nu) in enumerate(planes):
        vals.setdefault(round(acc[i, a], 6), []).append((tuple(x), (mu, nu)))
print("distinct conditional values (rounded 1e-6) and multiplicity:")
for v in sorted(vals):
    ex = vals[v][0]
    print("  %.6f  x%d   e.g. x=%s plane=%s" % (v, len(vals[v]), ex[0], ex[1]))

# 2. tree-level coarse kernel vs the coarse Wilson kernel at small k
print("tree-level coarse kernel K'(k) against the coarse Wilson kernel (transverse eigenvalue ratio):")
for kmag in [0.4, 0.2, 0.1, 0.05, 0.025]:
    for direc in [np.array([1, 0, 0, 0.]), np.array([1, 1, 0, 0.]) / np.sqrt(2), np.array([1, 1, 1, 1.]) / 2]:
        k = kmag * direc / L
        Pk, Qk, Mk, Gk = bs.mats(k)
        N, T, rank, rg, resid = bs.gauge_inv_basis(Qk, Gk)
        H = T.conj().T @ Mk @ T
        Qp = np.linalg.pinv(Qk)
        Proj = np.eye(4 * nal) - N @ N.conj().T   # not used; min over affine space computed via T (M kills gauge in N)
        # min_{a: Qa = a'} a^dag M a = a0^dag M a0 - a0^dag M T H^-1 T^dag M a0 with a0 = Q^+ a'  (gauge part of N has M = 0)
        Kp = Qp.conj().T @ (Mk - Mk @ T @ np.linalg.solve(H, T.conj().T @ Mk)) @ Qp / L ** 4
        kc = np.exp(1j * L * k) - 1.0
        Mc = np.vdot(kc, kc).real * np.eye(4) - np.outer(kc, kc.conj())
        # transverse eigenvalues: restrict to the complement of kc
        Pt = np.eye(4) - np.outer(kc, kc.conj()) / np.vdot(kc, kc).real
        evK = np.linalg.eigvalsh(Pt @ Kp @ Pt)
        evM = np.linalg.eigvalsh(Pt @ Mc @ Pt)
        print("  |k|L = %.3f dir %s : K' transverse eig %s ; coarse Wilson %s ; ratio %s ; K'(kc) %.2e" % (
            kmag, np.round(direc, 3), np.round(evK[-3:], 8), np.round(evM[-3:], 8), np.round(evK[-3:] / evM[-3:], 8),
            abs(np.vdot(kc, Kp @ kc)) / np.vdot(kc, kc).real))

# 3. xi-conditioned variance at one k (corrected stake S-C1.5')
k = np.array([0.31, 0.17, 0.11, 0.07]) / L
Pk, Qk, Mk, Gk = bs.mats(k)
N, T, rank, rg, resid = bs.gauge_inv_basis(Qk, Gk)
H = T.conj().T @ Mk @ T
SigR = T @ np.linalg.inv(H) @ T.conj().T
_, W = bs.wvecs(Pk)
ph_x = np.exp(1j * xs @ Pk.T)
U = (ph_x[:, :, None] * W[0][None, :, :]).reshape(len(xs), 4 * nal)
vR = np.einsum('ij,jk,ik->i', U, SigR, U.conj()).real
ph = bs.phat(Pk)
print("xi-conditioning at k = %s (plane 01, first 3 positions):" % np.round(k, 4))
print("  R-quotient (Balaban):", np.round(vR[:3], 8))
for xi in [10.0, 1.0, 0.1, 0.01, 0.001]:
    Mx = Mk.copy()
    for m in range(nal):
        v = ph[m]
        Mx[4 * m:4 * m + 4, 4 * m:4 * m + 4] += xi * np.outer(v, v.conj())
    S0 = np.linalg.inv(Mx)
    Sc = S0 - S0 @ Qk.conj().T @ np.linalg.solve(Qk @ S0 @ Qk.conj().T, Qk @ S0)
    vx = np.einsum('ij,jk,ik->i', U, Sc, U.conj()).real
    print("  xi = %-6g:" % xi, np.round(vx[:3], 8))
