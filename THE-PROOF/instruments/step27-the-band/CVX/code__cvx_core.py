"""CVX core library: the analytic plaquette Hessian of the SU(2) Wilson action in ADDITIVE EXPONENTIAL coordinates [EXP]
(U = exp(i B.sigma), M8's convention), the cubic-vertex Hessian h1, and the two torus slices of M8/M8b with INTEGER-SCALED
constraint rows (so exact arithmetic is available downstream).

Quaternions: q = (w, x, y, z), standard product (a0, a)(b0, b) = (a0 b0 - a.b, a0 b + b0 a + a x b).
U(phi) = cos r + i sin r phihat.sigma  <->  q(phi) = (cos r, -A(r) phi),  A = sin r / r   (i sigma_a <-> -e_a), so that
(1/2) tr(U1 U2 ...) = Re(q1 q2 ...).
Derivatives: d_a q = (-A phi_a, -(A e_a + B phi_a phi)),  d_a d_b q = (-A d_ab - B phi_a phi_b, -(B (phi_b e_a + phi_a e_b + d_ab phi)
+ C phi_a phi_b phi)),  B = A'/r = (r cos r - sin r)/r^3,  C = B'/r = (3 sin r - 3 r cos r - r^2 sin r)/r^5  (entire in r^2; series
below r = 0.2).
Plaquette (links 1: (x,mu), 2: (x+mu,nu), 3: (x+nu,mu), 4: (x,nu)), F = 1 - Re(q(phi1) q(phi2) q(-phi3) q(-phi4)), s = (1,1,-1,-1).
"""
import itertools
import numpy as np

S_SIGN = np.array([1.0, 1.0, -1.0, -1.0])


# ------------------------------------------------------------------ scalar functions A, B, C (float; series for small r)
def _ABC(r):
    r = np.asarray(r, float)
    r2 = r * r
    small = r < 0.2
    rs = np.where(small, 1.0, r)
    A = np.where(small, 1 - r2 / 6 + r2 ** 2 / 120 - r2 ** 3 / 5040 + r2 ** 4 / 362880, np.sin(rs) / rs)
    B = np.where(small, -1.0 / 3 + r2 / 30 - r2 ** 2 / 840 + r2 ** 3 / 45360 - r2 ** 4 / 3991680,
                 (rs * np.cos(rs) - np.sin(rs)) / rs ** 3)
    # C series: sum_j (-1)^j (2j+4)(2j+2)/(2j+5)! r^{2j}
    C = np.where(small, 1.0 / 15 - r2 / 210 + r2 ** 2 / 7560 - r2 ** 3 / 498960 + r2 ** 4 / 51891840,
                 (3 * np.sin(rs) - 3 * rs * np.cos(rs) - rs * rs * np.sin(rs)) / rs ** 5)
    return A, B, C


def qmul(p, q):
    """quaternion product, broadcasting over leading axes; p, q (..., 4)."""
    p0, p1, p2, p3 = p[..., 0], p[..., 1], p[..., 2], p[..., 3]
    q0, q1, q2, q3 = q[..., 0], q[..., 1], q[..., 2], q[..., 3]
    return np.stack([p0 * q0 - p1 * q1 - p2 * q2 - p3 * q3,
                     p0 * q1 + q0 * p1 + p2 * q3 - p3 * q2,
                     p0 * q2 + q0 * p2 + p3 * q1 - p1 * q3,
                     p0 * q3 + q0 * p3 + p1 * q2 - p2 * q1], axis=-1)


def qjets(phi):
    """phi (..., 3) -> (q (...,4), dq (...,3,4), d2q (...,3,3,4))."""
    r = np.linalg.norm(phi, axis=-1)
    A, B, C = _ABC(r)
    sh = phi.shape[:-1]
    q = np.zeros(sh + (4,))
    q[..., 0] = np.cos(r)
    q[..., 1:] = -A[..., None] * phi
    E3 = np.eye(3)
    dq = np.zeros(sh + (3, 4))
    dq[..., :, 0] = -A[..., None] * phi
    dq[..., :, 1:] = -(A[..., None, None] * E3 + B[..., None, None] * phi[..., :, None] * phi[..., None, :])
    d2q = np.zeros(sh + (3, 3, 4))
    pp = phi[..., :, None] * phi[..., None, :]
    d2q[..., 0] = -(A[..., None, None] * E3 + B[..., None, None] * pp)
    # vector part: -(B (phi_b e_a + phi_a e_b + d_ab phi) + C phi_a phi_b phi)
    vec = (B[..., None, None, None] * (phi[..., None, :, None] * E3[:, None, :] + phi[..., :, None, None] * E3[None, :, :]
                                        + E3[:, :, None] * phi[..., None, None, :])
           + C[..., None, None, None] * pp[..., :, :, None] * phi[..., None, None, :])
    d2q[..., 1:] = -vec
    return q, dq, d2q


def plaq_value(phi):
    """phi (n, 4, 3) -> F (n,)."""
    f = [qjets(S_SIGN[i] * phi[:, i, :])[0] for i in range(4)]
    P = qmul(qmul(qmul(f[0], f[1]), f[2]), f[3])
    return 1.0 - P[:, 0]


def plaq_hess(phi):
    """phi (n, 4, 3) -> analytic Hessian of F in the 12 [EXP] coordinates, (n, 12, 12)."""
    n = phi.shape[0]
    jets = [qjets(S_SIGN[i] * phi[:, i, :]) for i in range(4)]
    f = [j[0] for j in jets]
    df = [S_SIGN[i] * jets[i][1] for i in range(4)]            # (n, 3, 4)
    d2f = [jets[i][2] for i in range(4)]                        # (n, 3, 3, 4)  (s_i^2 = 1)
    H = np.zeros((n, 12, 12))
    for i in range(4):
        for j in range(i, 4):
            if i == j:
                # replace factor i by d2f[i][a,b]
                facs = [f[k][:, None, None, :] if k != i else d2f[i] for k in range(4)]
                P = qmul(qmul(qmul(facs[0], facs[1]), facs[2]), facs[3])     # (n, 3, 3, 4)
                H[:, 3 * i:3 * i + 3, 3 * i:3 * i + 3] = -P[..., 0]
            else:
                facs = []
                for k in range(4):
                    if k == i:
                        facs.append(df[i][:, :, None, :])                   # a index
                    elif k == j:
                        facs.append(df[j][:, None, :, :])                   # b index
                    else:
                        facs.append(f[k][:, None, None, :])
                P = qmul(qmul(qmul(facs[0], facs[1]), facs[2]), facs[3])     # (n, 3, 3, 4)
                blk = -P[..., 0]
                H[:, 3 * i:3 * i + 3, 3 * j:3 * j + 3] = blk
                H[:, 3 * j:3 * j + 3, 3 * i:3 * i + 3] = np.transpose(blk, (0, 2, 1))
    return H


def cross_mat(w):
    """w (..., 3) -> [w]_x (..., 3, 3), [w]_x u = w x u."""
    z = np.zeros(w.shape[:-1])
    return np.stack([np.stack([z, -w[..., 2], w[..., 1]], -1),
                     np.stack([w[..., 2], z, -w[..., 0]], -1),
                     np.stack([-w[..., 1], w[..., 0], z], -1)], -2)


# V3 = sum_triples sigma_abc det[phi_a, phi_b, phi_c], sigma = -s_a s_b s_c
TRIPLES = [(0, 1, 2), (0, 1, 3), (0, 2, 3), (1, 2, 3)]
SIGMA3 = np.array([-S_SIGN[a] * S_SIGN[b] * S_SIGN[c] for (a, b, c) in TRIPLES])


def plaq_h1(phi):
    """the cubic-vertex Hessian h1(phi) = Hess V3 (linear in phi), (n, 12, 12)."""
    n = phi.shape[0]
    H = np.zeros((n, 12, 12))
    X = [cross_mat(phi[:, i, :]) for i in range(4)]
    for t, (a, b, c) in enumerate(TRIPLES):
        sg = SIGMA3[t]
        # det(v_a, v_b, phi_c): H_ab += -sg [phi_c]x ; det(v_a, phi_b, v_c): H_ac += +sg [phi_b]x ; det(phi_a, v_b, v_c): H_bc += -sg [phi_a]x
        for (i, j, M) in ((a, b, -sg * X[c]), (a, c, sg * X[b]), (b, c, -sg * X[a])):
            H[:, 3 * i:3 * i + 3, 3 * j:3 * j + 3] += M
            H[:, 3 * j:3 * j + 3, 3 * i:3 * i + 3] += np.transpose(M, (0, 2, 1))
    return H


def h0_plaq():
    s = S_SIGN
    return np.kron(np.outer(s, s), np.eye(3))


# ------------------------------------------------------------------ the tori and slices
class Torus:
    """L = 2 half-open blocks on (4,2,2,2) (M8) or L = 3 centred blocks on (6,3,3,3) (M8b).  Integer-scaled constraints."""
    def __init__(self, L, ext=None):
        self.L = L
        if ext is None:
            ext = (4, 2, 2, 2) if L == 2 else (6, 3, 3, 3)
        self.ext = np.array(ext)
        self.sites = [np.array(s) for s in itertools.product(*[range(e) for e in self.ext])]
        self.sidx = {tuple(s): i for i, s in enumerate(self.sites)}
        self.nS = len(self.sites)
        self.nLk = 4 * self.nS
        E = np.eye(4, dtype=int)
        self.E = E
        pl = []
        for s in self.sites:
            for mu in range(4):
                for nu in range(mu + 1, 4):
                    pl.append((self.lid(s, mu), self.lid(s + E[mu], nu), self.lid(s + E[nu], mu), self.lid(s, nu)))
        self.plaqs = np.array(pl)
        self.nP = len(pl)
        if L == 2:
            self.iscoarse = lambda s: all(s % 2 == 0)
            bset = [np.array(n) for n in itertools.product(range(2), repeat=4)]
        else:
            self.iscoarse = lambda s: all(s % L == 0)
            bset = [np.array(n) for n in itertools.product(range(-(L - 1) // 2, (L - 1) // 2 + 1), repeat=4)]
        self.coarse = [s for s in self.sites if self.iscoarse(s)]
        # residual gauge columns (per colour, integer)
        Gc = []
        for s in self.sites:
            if self.iscoarse(s):
                continue
            v = np.zeros(self.nLk, dtype=np.int64)
            for mu in range(4):
                v[self.lid(s, mu)] -= 1
                v[self.lid(s - E[mu], mu)] += 1
            Gc.append(v)
        self.G0 = np.array(Gc).T                       # (nLk, ngauge)
        # Balaban's linearised average rows (per colour), scaled by SCALE = L^4 * 24 to integers
        self.SCALE = L ** 4 * 24
        Qr = []
        for y in self.coarse:
            for mu in range(4):
                row = np.zeros(self.nLk, dtype=np.int64)
                for nvec in bset:
                    for j in range(L):
                        row[self.lid(y + nvec + j * E[mu], mu)] += 24
                    nz = [nu for nu in range(4) if nvec[nu] != 0]
                    perms = list(itertools.permutations(nz))
                    w = 24 // len(perms)
                    for start, sign in ((y, 1), (y + L * E[mu], -1)):
                        for perm in perms:
                            z = start.copy()
                            for nu in perm:
                                for _ in range(abs(int(nvec[nu]))):
                                    if nvec[nu] > 0:
                                        row[self.lid(z, nu)] += sign * w
                                        z = z + E[nu]
                                    else:
                                        z = z - E[nu]
                                        row[self.lid(z, nu)] -= sign * w
                Qr.append(row)
        self.Q0 = np.array(Qr)                          # (ncons, nLk), = SCALE * (true average rows)
        # free per-colour form: curl^T curl (integer)
        D = np.zeros((self.nP, self.nLk), dtype=np.int64)
        for p, (a, b, c, d) in enumerate(self.plaqs):
            D[p, a] += 1; D[p, b] += 1; D[p, c] -= 1; D[p, d] -= 1
        self.curl = D
        self.H0c = D.T @ D                              # per colour
        # orthonormal float basis of V0 (per colour)
        C = np.vstack([self.Q0.astype(float), self.G0.T.astype(float)])
        U_, s_, Vh = np.linalg.svd(C)
        rk = int((s_ > 1e-9 * s_[0]).sum())
        self.rankC = rk
        self.T0 = Vh[rk:].T                             # (nLk, dimV0)
        self.dimV0 = self.T0.shape[1]

    def lid(self, s, mu):
        return 4 * self.sidx[tuple(np.mod(s, self.ext))] + mu

    def full_T(self):
        """orthonormal basis of V = V0 (x) R^3 in the interleaved ordering 3*link + colour."""
        return np.kron(self.T0, np.eye(3))

    def plaq_phi(self, B):
        """B (nLk*3,) or (nLk,3) -> phi (nP, 4, 3)."""
        Bl = B.reshape(self.nLk, 3)
        return Bl[self.plaqs]

    def assemble(self, Hp):
        """per-plaquette (nP, 12, 12) -> global (3 nLk, 3 nLk) dense."""
        n = 3 * self.nLk
        Hf = np.zeros((n, n))
        idx = (3 * self.plaqs[:, :, None] + np.arange(3)[None, None, :]).reshape(self.nP, 12)
        rows = np.repeat(idx[:, :, None], 12, axis=2).ravel()
        cols = np.repeat(idx[:, None, :], 12, axis=1).ravel()
        np.add.at(Hf, (rows, cols), Hp.ravel())
        return Hf

    def hess(self, B):
        return self.assemble(plaq_hess(self.plaq_phi(B)))

    def H1(self, B):
        return self.assemble(plaq_h1(self.plaq_phi(B)))

    def H0(self):
        return np.kron(self.H0c.astype(float), np.eye(3))

    def m_vectors(self, v):
        """m_l(v)^a = d/dB_l^a [v^T H1(B) v] (independent of B), (nLk, 3)."""
        vl = v.reshape(self.nLk, 3)[self.plaqs]          # (nP, 4, 3)
        m = np.zeros((self.nLk, 3))
        for t, (a, b, c) in enumerate(TRIPLES):
            sg = SIGMA3[t]
            # d/dphi_c: 2 sg (v_a x v_b); d/dphi_b: 2 sg (v_c x v_a); d/dphi_a: 2 sg (v_b x v_c)
            np.add.at(m, self.plaqs[:, c], 2 * sg * np.cross(vl[:, a], vl[:, b]))
            np.add.at(m, self.plaqs[:, b], 2 * sg * np.cross(vl[:, c], vl[:, a]))
            np.add.at(m, self.plaqs[:, a], 2 * sg * np.cross(vl[:, b], vl[:, c]))
        return m
