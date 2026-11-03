"""M8 — the linearised Balaban block-spin step on Z^4, per colour (abelian part), in Fourier space.

Library used by the C1 reading and the certification scripts.  Conventions (WORK.md section 3):
  fine momenta p in [-pi, pi)^4, forward difference symbol phat_mu = exp(i p_mu) - 1;
  Wilson quadratic form per colour  sum_{mu<nu} |phat_mu A_nu - phat_nu A_mu|^2 = A^dag M(p) A,  M = |phat|^2 I - phat phat^dag;
  Balaban's average (CMP 109 (0.4)) linearised, for the coarse bond (y, y + L e_mu), block B(y) = y + Bset:
     A'_mu(y) = L^-4 sum_{n in Bset} [ sum_{j<L} A_mu(y+n+j e_mu) + A(Gamma_{y->y+n}) - A(Gamma'_{y+L e_mu -> y+n+L e_mu}) ],
  the contours averaged over the orderings of the nonzero directions of n (straight segments, CMP 109 p. 252);
  in Fourier: Qhat_{mu nu}(p) = L^-4 [ delta_{mu nu} E(p) S_mu(p) + (1 - exp(i L p_mu)) G_nu(p) ],
     E(p) = sum_n exp(i p.n), S_mu(p) = sum_{j<L} exp(i p_mu j), G(p) = sum_n g_n(p) (the averaged contour sums);
  per coarse momentum k the L^4 aliases p_m = k + 2 pi m / L carry 4 L^4 field components; the constraint matrix is
     Q(k)[mu, (m, nu)] = L^-4 Qhat_{mu nu}(p_m).
Bset: 'centred' = {-(L-1)/2 .. (L-1)/2}^4 (L odd, Balaban); 'half' = {0 .. L-1}^4 (corner blocks, the crossover's L = 2).
"""
import itertools
import numpy as np


def block_set(L, kind):
    if kind == 'centred':
        assert L % 2 == 1
        r = range(-(L - 1) // 2, (L - 1) // 2 + 1)
    elif kind == 'half':
        r = range(0, L)
    else:
        raise ValueError(kind)
    return [np.array(n) for n in itertools.product(r, repeat=4)]


def contour_steps(Bset):
    """Aggregate the averaged contour sums: returns list of (nu, z (base point), coef) with
    G_nu(p) = sum coef * exp(i p.z) over entries with that nu (sign of traversal included in coef)."""
    agg = {}
    for n in Bset:
        nz = [mu for mu in range(4) if n[mu] != 0]
        perms = list(itertools.permutations(nz))
        w = 1.0 / len(perms)
        for perm in perms:
            z = np.zeros(4, int)
            for mu in perm:
                s = 1 if n[mu] > 0 else -1
                for _ in range(abs(int(n[mu]))):
                    if s > 0:
                        key = (mu, tuple(z)); agg[key] = agg.get(key, 0.0) + w
                        z[mu] += 1
                    else:
                        z[mu] -= 1
                        key = (mu, tuple(z)); agg[key] = agg.get(key, 0.0) - w
    out = [(mu, np.array(z), c) for (mu, z), c in agg.items() if abs(c) > 1e-15]
    return out


class BlockSpin:
    def __init__(self, L, kind):
        self.L, self.kind = L, kind
        self.Bset = block_set(L, kind)
        assert len(self.Bset) == L ** 4
        self.steps = contour_steps(self.Bset)
        self.nvec = np.array(self.Bset)                    # (L^4, 4)
        self.mvec = np.array(list(itertools.product(range(L), repeat=4)))   # alias labels
        self.nal = L ** 4
        # step arrays for vectorised G
        self.st_mu = np.array([s[0] for s in self.steps])
        self.st_z = np.array([s[1] for s in self.steps])
        self.st_c = np.array([s[2] for s in self.steps])

    def phat(self, P):
        return np.exp(1j * P) - 1.0

    def Qhat(self, P):
        """P: (n, 4) fine momenta -> (n, 4, 4) complex Qhat."""
        L = self.L
        E = np.exp(1j * P @ self.nvec.T).sum(axis=1)                   # (n,)
        S = np.zeros((P.shape[0], 4), complex)
        for j in range(L):
            S += np.exp(1j * P * j)
        ph = np.exp(1j * P @ self.st_z.T) * self.st_c[None, :]        # (n, nsteps)
        G = np.zeros((P.shape[0], 4), complex)
        for mu in range(4):
            G[:, mu] = ph[:, self.st_mu == mu].sum(axis=1)
        Q = np.zeros((P.shape[0], 4, 4), complex)
        for mu in range(4):
            Q[:, mu, mu] += E * S[:, mu]
            Q[:, mu, :] += (1.0 - np.exp(1j * L * P[:, mu]))[:, None] * G
        return Q / L ** 4

    def aliases(self, k):
        return k[None, :] + 2 * np.pi * self.mvec / self.L          # (L^4, 4)

    def mats(self, k):
        """Return P (aliases), Qk (4 x 4L^4), Mk (4L^4 x 4L^4 block diag), Gk (gauge basis, 4L^4 x (L^4-1))."""
        P = self.aliases(k)
        nal = self.nal
        ph = self.phat(P)                                              # (nal, 4)
        Qh = self.Qhat(P)                                              # (nal, 4, 4)
        Qk = (Qh.transpose(1, 0, 2).reshape(4, 4 * nal)) / self.L ** 4  # rows mu, cols (m, nu)
        Mk = np.zeros((4 * nal, 4 * nal), complex)
        for m in range(nal):
            v = ph[m]
            blk = np.vdot(v, v).real * np.eye(4) - np.outer(v, v.conj())
            Mk[4 * m:4 * m + 4, 4 * m:4 * m + 4] = blk
        # residual gauge directions: (phat_m lambda_m)_m with sum_m lambda_m = 0
        Gk = np.zeros((4 * nal, nal - 1), complex)
        for j in range(1, nal):
            Gk[4 * j:4 * j + 4, j - 1] += ph[j]
            Gk[0:4, j - 1] -= ph[0]
        return P, Qk, Mk, Gk

    def gauge_inv_basis(self, Qk, Gk, tol=1e-10):
        """Orthonormal basis T of ker Q minus the residual gauge directions; also N (orthonormal ker Q)."""
        U, s, Vh = np.linalg.svd(Qk)
        rank = int((s > tol * s.max()).sum())
        N = Vh[rank:].conj().T                                         # (4nal, 4nal - rank)
        GN = N.conj().T @ Gk                                           # coordinates of gauge dirs in N
        resid = np.linalg.norm(Gk - N @ GN) / max(1.0, np.linalg.norm(Gk))
        Ug, sg, Vgh = np.linalg.svd(GN, full_matrices=True)
        rg = int((sg > tol * max(1.0, sg.max())).sum())
        Tn = Ug[:, rg:]                                                # complement of gauge in N coords
        T = N @ Tn
        return N, T, rank, rg, resid

    def wvecs(self, P):
        """curvature row vectors: for orientation (mu,nu) and alias m, w with F = w^T A_m, w_nu = phat_mu, w_mu = -phat_nu."""
        ph = self.phat(P)
        planes = [(mu, nu) for mu in range(4) for nu in range(mu + 1, 4)]
        W = np.zeros((6, self.nal, 4), complex)
        for a, (mu, nu) in enumerate(planes):
            W[a, :, nu] = ph[:, mu]
            W[a, :, mu] = -ph[:, nu]
        return planes, W
