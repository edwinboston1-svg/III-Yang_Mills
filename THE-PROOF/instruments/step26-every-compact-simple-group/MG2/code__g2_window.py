# MG2 g2_window.py -- G2's window, the readings this run can take EXACTLY (double precision, known answers first; READINGS, not bounds):
#  (A) Weyl characters of A1 and G2 in Dynkin coordinates on a shifted uniform torus grid (exact quadrature for trigonometric polynomials
#      of degree < n); KATs: sum of Haar weights = 1, <chi_a, chi_b> = delta, chi(1) = Weyl dimension, fusion 7x7 = 1+7+14+27.
#  (B) the F-matrix |F_ij|^2 of 7 x 7 x 7 -> 7 over the channels {1,7,14,27}, from explicit g2 = stabiliser of the octonion 3-form in so(7).
#  (C) the n = 1 PLANAR two-face object (two plaquettes sharing one link; zero blocking steps; clean) with the ORDERED datum (each private
#      link in 5 outside staples, the shared link in 4, all outside links = 1): every link weight is a class function, so the joint law of the
#      two plaquette loops on class functions is  P(A,B) ~ w(A) w(B) sum_{a,b} chi_a(A) phiX_a M_ab phiY_b chi_b(B),  phiX = (phi^(5))^3,
#      M_ab = E_{w^4}[chi_a chi_b];  its maximal correlation over class functions of A and of B (= (W-S) at n = 1 for G2, no centre); for SU(2)
#      beside it the full value and the centre-even (SO(3)) channel.  FREE datum control: correlation 0.
import sys, itertools
import numpy as np

def weyl_group(A):
    r = A.shape[0]
    gens = []
    for i in range(r):
        S = np.eye(r, dtype=int)
        S[i, :] = -A[i, :] + (np.arange(r) == i) * 0     # placeholder, replaced below
        gens.append(S)
    # s_i acting on Dynkin row vectors m: (s_i m)_j = m_j - m_i A_ij  ->  m' = m @ S_i with S_i = I - e_i (row i of A)
    gens = []
    for i in range(r):
        S = np.eye(r, dtype=int); S[i, :] -= A[i, :]
        gens.append(S)
    W = [np.eye(r, dtype=int)]; seen = {tuple(W[0].flatten())}; fr = list(W)
    while fr:
        new = []
        for g in fr:
            for s in gens:
                h = g @ s
                k = tuple(h.flatten())
                if k not in seen: seen.add(k); W.append(h); new.append(h)
        fr = new
    return W

class Group:
    def __init__(self, name, A, norms, rho, ngrid):
        self.name = name; self.A = np.array(A, dtype=int); self.r = len(A)
        self.W = weyl_group(self.A); self.sgn = [int(round(np.linalg.det(w))) for w in self.W]
        # inner products of fundamental weights: (w_i, w_j) = (A^-1)_{ij} (alpha_j, alpha_j)/2
        Ainv = np.linalg.inv(self.A.astype(float))
        self.G = np.array([[Ainv[i, j] * norms[j] / 2 for j in range(self.r)] for i in range(self.r)])
        self.delta = np.ones(self.r, dtype=int); self.rho = np.array(rho)
        n = ngrid; self.n = n
        # constant shifts keep the uniform grid exact for trigonometric polynomials of degree < n and must avoid every wall b.x in Z
        # (b the Dynkin labels of a root): (0.5) for A1 (n even); (0.25, 0.6) for G2 (checked against all six positive roots)
        shifts = [0.5] if self.r == 1 else [0.25, 0.6]
        axes = [(np.arange(n) + shifts[k]) / n for k in range(self.r)]
        mesh = np.meshgrid(*axes, indexing='ij'); self.X = np.stack([m.flatten() for m in mesh], axis=1)   # (N, r)
        self.Ad = self.alt(self.delta)
        self.h = np.abs(self.Ad) ** 2 / (len(self.W) * self.X.shape[0])
        # positive roots (Dynkin labels): the W-orbits of the simple roots with nonnegative simple-root coordinates c = m A^{-1}
        roots = set()
        for w in self.W:
            for i in range(self.r):
                roots.add(tuple(int(v) for v in (self.A[i, :] @ w)))
        self.pos = [np.array(b) for b in roots if np.all(np.array(b) @ Ainv >= -1e-9)]
    def alt(self, mu):
        s = np.zeros(self.X.shape[0], dtype=complex)
        for w, e in zip(self.W, self.sgn):
            s += e * np.exp(2j * np.pi * (self.X @ (np.array(mu) @ w)))
        return s
    def C2(self, lam):
        l = np.array(lam, float); d = self.delta.astype(float)
        return float(l @ self.G @ (l + 2 * d)) / 2
    def dim(self, lam):
        # Weyl dimension formula, exact product over positive roots: prod (lam + delta, beta)/(delta, beta)
        l = np.array(lam, float) + self.delta; num = 1.0; den = 1.0
        for b in self.pos:
            num *= l @ self.G @ b; den *= self.delta @ self.G @ b
        return int(round(num / den))
    def chi(self, lam):
        return (self.alt(np.array(lam) + self.delta) / self.Ad).real
    def irreps(self, Cmax, labmax=60):
        L = [lam for lam in itertools.product(range(labmax), repeat=self.r) if self.C2(lam) <= Cmax + 1e-9]
        return sorted(L, key=lambda l: (self.C2(l), l))

def group(name, ngrid):
    if name == 'SU2': return Group('SU(2)', [[2]], [2.0], (1,), ngrid)
    if name == 'G2': return Group('G2', [[2, -1], [-3, 2]], [2.0 / 3, 2.0], (1, 0), ngrid)   # alpha1 short (7 = w1), alpha2 long (14 = w2)
    raise ValueError(name)

def kats(g, L, chis):
    out = {'sum_h': g.h.sum()}
    gram = np.array([[np.sum(g.h * chis[i] * chis[j]) for j in range(len(L))] for i in range(len(L))])
    out['orth_err'] = np.abs(gram - np.eye(len(L))).max()
    return out, gram

def window_reading(g, beta, Cmax, datum='ordered', want_even=False):
    L = g.irreps(Cmax); chis = np.array([g.chi(l) for l in L]); dims = np.array([g.dim(l) for l in L])
    d = g.dim(g.rho); chir = g.chi(g.rho)
    def law(k):
        f = np.exp((k * beta / d) * chir - k * beta)          # scaled; class density up to normalisation
        c0 = np.sum(g.h * f)
        return f / c0
    w1 = law(1)
    if datum == 'free':
        phi5 = np.array([1.0 if np.sum(l) == 0 else 0.0 for l in L]); f4 = np.ones_like(chir)
    else:
        f5 = law(5); f4 = law(4)
        phi5 = np.array([np.sum(g.h * chis[i] * f5) / dims[i] for i in range(len(L))])
    phiX = phi5 ** 3
    M = np.array([[np.sum(g.h * chis[i] * chis[j] * f4) for j in range(len(L))] for i in range(len(L))])
    K = (phiX[:, None] * M) * phiX[None, :]
    rho_link = chis.T @ K @ chis                                # (N, N) on grid points
    pos_min = rho_link.min()
    P = (g.h * w1)[:, None] * rho_link * (g.h * w1)[None, :]
    P = P / P.sum()
    def maxcorr(P):
        pa = P.sum(1); pb = P.sum(0)
        ka = pa > 1e-300; kb = pb > 1e-300
        Q = P[np.ix_(ka, kb)] / np.sqrt(np.outer(pa[ka], pb[kb]))
        s = np.linalg.svd(Q, compute_uv=False)
        return s[0], s[1], s[2] if len(s) > 2 else 0.0
    s0, s1, s2 = maxcorr(P)
    res = dict(L=len(L), tail=float(np.abs(phiX[-5:]).max()), phi_rho=float(phi5[[i for i, l in enumerate(L) if tuple(l) == tuple(g.rho)][0]]),
               pos_min=float(pos_min / np.abs(rho_link).max()), s0=s0, maxcorr=s1, second=s2)
    if want_even:
        # SU(2) centre -1 <-> x -> x + 1/2 : pair grid point i with i + n/2 and pass to the quotient (centre-even class functions)
        n = g.n; idx = np.arange(n); j = (idx + n // 2) % n
        Pe = P[:n // 2 * 0 + n, :]                               # full
        Pq = np.zeros((n, n));
        for a in range(n):
            for b in range(n):
                Pq[min(a, j[a]), min(b, j[b])] += P[a, b]
        keep = [a for a in range(n) if a <= j[a]]
        Pq = Pq[np.ix_(keep, keep)]
        res['even_maxcorr'] = maxcorr(Pq)[1]
    return res

def F_matrix_G2():
    # octonion 3-form, Fano triples (one standard choice)
    trip = [(1, 2, 3, 1), (1, 4, 5, 1), (1, 6, 7, 1), (2, 4, 6, 1), (2, 5, 7, -1), (3, 4, 7, -1), (3, 5, 6, -1)]
    phi = np.zeros((7, 7, 7))
    for (a, b, c, s) in trip:
        a -= 1; b -= 1; c -= 1
        for (x, y, z), sg in [((a, b, c), 1), ((b, c, a), 1), ((c, a, b), 1), ((b, a, c), -1), ((a, c, b), -1), ((c, b, a), -1)]:
            phi[x, y, z] = s * sg
    # so(7) basis and the stabiliser of phi
    basis = []
    for i in range(7):
        for j in range(i + 1, 7):
            E = np.zeros((7, 7)); E[i, j] = 1; E[j, i] = -1; basis.append(E)
    def act(X):
        return np.einsum('ad,dbc->abc', X, phi) + np.einsum('bd,adc->abc', X, phi) + np.einsum('cd,abd->abc', X, phi)
    Mlin = np.array([act(E).flatten() for E in basis]).T          # 343 x 21
    u, s, vt = np.linalg.svd(Mlin)
    null = vt[np.sum(s > 1e-9):]                                   # kernel coefficients
    gens = [sum(c * E for c, E in zip(v, basis)) for v in null]
    dimg = len(gens)
    # orthonormalise w.r.t. -tr(XY)
    Gm = np.array([[-np.trace(X @ Y) for Y in gens] for X in gens]); ev, U = np.linalg.eigh(Gm)
    gens = [sum(U[k, i] * gens[k] for k in range(dimg)) / np.sqrt(ev[i]) for i in range(dimg)]
    I7 = np.eye(7)
    Cas1 = sum(X @ X for X in gens)                                # on V: scalar
    c7 = -Cas1[0, 0]
    # V x V Casimir and channel projectors
    def tot2(X): return np.kron(X, I7) + np.kron(I7, X)
    C2 = -sum(tot2(X) @ tot2(X) for X in gens)
    ev2, U2 = np.linalg.eigh(C2)
    vals = sorted(set(np.round(ev2, 6)))
    proj = {}
    for v in vals:
        cols = U2[:, np.abs(ev2 - v) < 1e-6]; proj[v] = cols @ cols.T
    dims2 = {v: int(round(np.trace(proj[v]))) for v in vals}
    # V^{x3}: P_i^(12), P_j^(23), and the projector onto the 7-isotypic component (total Casimir = c7)
    I49 = np.eye(49)
    def tot3(X): return np.kron(np.kron(X, I7), I7) + np.kron(np.kron(I7, X), I7) + np.kron(np.kron(I7, I7), X)
    C3 = -sum(tot3(X) @ tot3(X) for X in gens)
    ev3, U3 = np.linalg.eigh(C3)
    cols = U3[:, np.abs(ev3 - c7) < 1e-6]; Pi7 = cols @ cols.T
    order = sorted(vals, key=lambda v: dims2[v])                    # 1, 7, 14, 27 by dimension
    O = np.zeros((4, 4))
    for a, va in enumerate(order):
        A12 = np.kron(proj[va], I7)
        for b, vb in enumerate(order):
            B23 = np.kron(I7, proj[vb])
            O[a, b] = np.trace(Pi7 @ A12 @ B23) / 7
    return dict(dimg=dimg, c7=c7, chan=[(dims2[v], v) for v in order], dimPi7=int(round(np.trace(Pi7))), F2=O)

if __name__ == '__main__':
    mode = sys.argv[1]
    if mode == 'kat':
        for name, ng, Cm in [('SU2', 64, 60), ('G2', 40, 30)]:
            g = group(name, ng); L = g.irreps(Cm); chis = np.array([g.chi(l) for l in L])
            k, gram = kats(g, L, chis)
            print('==', g.name, '|W| =', len(g.W), 'irreps', len(L), 'first:', [(tuple(l), g.dim(l), round(g.C2(l), 4)) for l in L[:8]])
            print('   KAT sum h =', k['sum_h'], ' max|<chi_a,chi_b> - delta| =', k['orth_err'])
            if name == 'G2':
                c7 = g.chi((1, 0)); fus = {tuple(l): round(float(np.sum(g.h * c7 * c7 * g.chi(l))), 10) for l in L[:10]}
                print('   7x7 fusion multiplicities:', fus, ' int chi7^3 =', round(float(np.sum(g.h * c7 ** 3)), 10), ' int chi7^4 =', round(float(np.sum(g.h * c7 ** 4)), 10))
    elif mode == 'F':
        R = F_matrix_G2()
        print('== G2 from the octonion 3-form: dim g2 =', R['dimg'], ' Casimir on 7 =', R['c7'], ' channels (dim, Casimir eigenvalue on 7x7):', R['chan'], ' dim of the 7-isotypic part of 7^3 =', R['dimPi7'])
        np.set_printoptions(precision=6, suppress=True)
        print('   |F_ij|^2 (rows: channel of (12), cols: channel of (23); order 1,7,14,27):'); print(R['F2'])
        print('   row sums', R['F2'].sum(1), ' col sums', R['F2'].sum(0), ' stake row 1 = d_j/49:', np.array([1, 7, 14, 27]) / 49)
    elif mode == 'read':
        name = sys.argv[2]; beta = float(sys.argv[3]); ng = int(sys.argv[4]); Cm = float(sys.argv[5]); datum = sys.argv[6] if len(sys.argv) > 6 else 'ordered'
        g = group(name, ng)
        R = window_reading(g, beta, Cm, datum, want_even=(name == 'SU2'))
        print('== %s beta=%g datum=%s grid=%d Cmax=%g irreps=%d | phi^(5)_rho=%.6f tail(phiX)=%.2e rho_link min/max=%.2e | top s0=%.6f MAXCORR=%.6f next=%.6f %s' % (
            g.name, beta, datum, ng, Cm, R['L'], R['phi_rho'], R['tail'], R['pos_min'], R['s0'], R['maxcorr'], R['second'],
            ('centre-even (SO(3)) MAXCORR=%.6f' % R['even_maxcorr']) if 'even_maxcorr' in R else ''))
