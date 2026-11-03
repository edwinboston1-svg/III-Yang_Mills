"""CVX — the shaped majorant of the linear (cubic-vertex) part.  READING (the search); the certificate re-checks every LMI.

K^(c), c = 0..3: the 4x4 Hermitian form (on the charged combination omega = v^1 + i v^2 of the plaquette's links) that the cubic
vertex induces when ONE background link, at position c, points along e3 with unit length; zero row/column c; eigenvalues +-sqrt3, 0, 0.
Majorant: real symmetric x^(c) with x^(c) - K^(c) PSD; X = sum_c x^(c); per colour Qt = sum_p P_p^T X P_p.
nu(X) = lambda_max(Qt relative to H0 on V0).  Search: x^(c) = y^(c) + tau_c I, tau_c the least shift to feasibility.
Run: python -u -E -P code/cvx_major.py L [init_file] > rec/major_L<L>.<date>.txt ; writes rec/major_L<L>_best.npy (the 4 blocks)
"""
import sys, os, time
import numpy as np
from scipy.optimize import minimize
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from cvx_core import Torus, TRIPLES, SIGMA3


def K_pos(c):
    Om = np.zeros((4, 4))
    for t, (a, bb, cc) in enumerate(TRIPLES):
        sg = SIGMA3[t]
        if cc == c:
            i, j = a, bb
        elif bb == c:
            i, j = cc, a
        elif a == c:
            i, j = bb, cc
        else:
            continue
        Om[i, j] += 2 * sg
        Om[j, i] -= 2 * sg
    return Om / 2j, Om


KS = [K_pos(c)[0] for c in range(4)]
IU = np.triu_indices(4)


def sym_from(vec):
    M = np.zeros((4, 4))
    M[IU] = vec
    return M + M.T - np.diag(np.diag(M))


def feasible_block(y, c):
    lam = np.linalg.eigvalsh(y - KS[c])[0]
    tau = max(0.0, -lam) + 1e-12
    return y + tau * np.eye(4)


class Problem:
    def __init__(self, L):
        self.T = Torus(L)
        T = self.T
        A = T.T0.T @ T.H0c.astype(float) @ T.T0
        w, U = np.linalg.eigh(A)
        self.W = U @ np.diag(w ** -0.5) @ U.T
        self.gamma0 = w[0]
        self.R = []
        for (i, j) in zip(*IU):
            G = np.zeros((T.nLk, T.nLk))
            E = np.zeros((4, 4)); E[i, j] = 1.0; E[j, i] = 1.0
            if i == j:
                E[i, i] = 1.0
            for p in range(T.nP):
                li = T.plaqs[p]
                G[np.ix_(li, li)] += E
            self.R.append(self.W @ (T.T0.T @ G @ T.T0) @ self.W)
        self.R = np.array(self.R)

    def nu_of_X(self, X):
        coef = X[IU]
        M = np.tensordot(coef, self.R, axes=(0, 0))
        return np.linalg.eigvalsh(M)[-1]

    def X_of_params(self, params):
        X = np.zeros((4, 4))
        blocks = []
        for c in range(4):
            y = sym_from(params[10 * c:10 * c + 10])
            x = feasible_block(y, c)
            blocks.append(x)
            X += x
        return X, blocks

    def obj(self, params):
        X, _ = self.X_of_params(params)
        return self.nu_of_X(X)


def absK_params():
    p = []
    for c in range(4):
        w, U = np.linalg.eigh(KS[c])
        A = ((U * np.abs(w)) @ U.conj().T).real
        p.extend(A[IU])
    return np.array(p)


def main():
    L = int(sys.argv[1])
    t0 = time.time()
    P = Problem(L)
    print("L = %d: gamma0 = %.8f; K^(c) eigenvalues %s" % (L, P.gamma0, [np.round(np.linalg.eigvalsh(K), 6).tolist() for K in KS]))
    p0 = absK_params()
    if len(sys.argv) > 2 and os.path.exists(sys.argv[2]):
        blocks = np.load(sys.argv[2])
        p0 = np.concatenate([b[IU] for b in blocks])
        print("start from", sys.argv[2])
    print("|K| majorant: nu = %.6f (b_lin %.5f)" % (P.obj(absK_params()), 1 / P.obj(absK_params())))
    best = (P.obj(p0), p0)
    rng = np.random.default_rng(7)
    for rnd in range(int(os.environ.get('CVX_ROUNDS', '6'))):
        start = best[1] + (0.0 if rnd == 0 else 0.15) * rng.normal(size=40)
        res = minimize(P.obj, start, method='Powell', options={'maxiter': 20000, 'xtol': 1e-6, 'ftol': 1e-9})
        res = minimize(P.obj, res.x, method='Nelder-Mead', options={'maxiter': 40000, 'xatol': 1e-7, 'fatol': 1e-10, 'adaptive': True})
        print("  round %d: nu = %.6f (b_lin %.5f)  [%.0f s]" % (rnd, res.fun, 1 / res.fun, time.time() - t0), flush=True)
        if res.fun < best[0]:
            best = (res.fun, res.x)
    X, blocks = P.X_of_params(best[1])
    print("BEST nu = %.6f -> b_lin(q) = %.5f" % (best[0], 1 / best[0]))
    np.set_printoptions(precision=5, suppress=True, linewidth=150)
    print("X (sum of blocks) =\n", X)
    print("eig X:", np.linalg.eigvalsh(X))
    for c in range(4):
        print("block %d: min eig of x - K = %.3e; x =\n" % (c, np.linalg.eigvalsh(blocks[c] - KS[c])[0]), blocks[c])
    np.save(os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', 'rec', 'major_L%d_best.npy' % L), np.array(blocks))


if __name__ == '__main__':
    main()
