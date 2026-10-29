# (c) check: the Gaussian chessboard constant K for one SU(2) orientation class (3 colours) of plaquettes.
# log K^{|A|} = (3/2)[logdet(Q_full + m2) - logdet(Q_full - Q_A + m2)]  (abelian forms per colour, mass m2 on both;
# Q_A annihilates longitudinal modes, so m2 only regularizes the common kernel).  Road 1: dense real-space matrices
# on the L^4 torus.  Road 2: momentum blocks (4x4 for the full class A; 16x16 alias blocks for the index-4 sublattice
# A' = class (01) with x0, x1 even).  Then the large-L value of each.
import sys, itertools, numpy as np
def site(x, L): return ((x[0]*L + x[1])*L + x[2])*L + x[3]
def realspace(L, m2, sub):
    n = 4*L**4; C = []; sel = []
    for x in itertools.product(range(L), repeat=4):
        for mu in range(4):
            for nu in range(mu+1, 4):
                r = np.zeros(n)
                xm = list(x); xm[mu] = (xm[mu]+1) % L
                xn = list(x); xn[nu] = (xn[nu]+1) % L
                r[4*site(x,L)+mu] += 1; r[4*site(xm,L)+nu] += 1; r[4*site(xn,L)+mu] -= 1; r[4*site(x,L)+nu] -= 1
                C.append(r)
                inA = (mu, nu) == (0, 1) and (not sub or (x[0] % 2 == 0 and x[1] % 2 == 0))
                sel.append(inA)
    C = np.array(C); sel = np.array(sel)
    Qf = C.T @ C; Qr = C[~sel].T @ C[~sel]; I = np.eye(n)
    return np.linalg.slogdet(Qf + m2*I)[1] - np.linalg.slogdet(Qr + m2*I)[1], int(sel.sum())
def vrow(k):  # the (01) curl acting on A(k): F = A0 (1 - e^{ik1}) + A1 (e^{ik0} - 1)
    v = np.zeros(4, complex); v[0] = 1 - np.exp(1j*k[1]); v[1] = np.exp(1j*k[0]) - 1; return v
def Qk(k):
    w = [np.exp(1j*kk) - 1 for kk in k]; M = np.zeros((4,4), complex)
    for mu in range(4):
        for nu in range(mu+1, 4):
            f = np.zeros(4, complex); f[mu] = -w[nu]; f[nu] = w[mu]   # F_{mu nu} = (e^{ik_mu}-1)A_nu - (e^{ik_nu}-1)A_mu
            M += np.outer(f.conj(), f)
    return M
def momentum(L, m2, sub):
    ks = 2*np.pi*np.arange(L)/L; tot = 0.0; cnt = 0
    if not sub:
        for k in itertools.product(ks, repeat=4):
            Qf = Qk(k); v = vrow(k); Qr = Qf - np.outer(v.conj(), v)
            tot += np.linalg.slogdet(Qf + m2*np.eye(4))[1] - np.linalg.slogdet(Qr + m2*np.eye(4))[1]; cnt += 1
        return tot, cnt
    half = 2*np.pi*np.arange(L//2)/L
    for k in itertools.product(half, half, ks, ks):
        al = [np.array(k) + np.array(d) for d in ((0,0,0,0),(np.pi,0,0,0),(0,np.pi,0,0),(np.pi,np.pi,0,0))]
        Qf = np.zeros((16,16), complex); QA = np.zeros((16,16), complex)
        for i, ki in enumerate(al):
            Qf[4*i:4*i+4, 4*i:4*i+4] = Qk(ki)
            for j, kj in enumerate(al):
                QA[4*i:4*i+4, 4*j:4*j+4] = 0.25*np.outer(vrow(ki).conj(), vrow(kj))
        I = np.eye(16)
        tot += np.linalg.slogdet(Qf + m2*I)[1] - np.linalg.slogdet(Qf - QA + m2*I)[1]; cnt += 1
    return tot, cnt
m2 = 1e-3
for L in (4,):
    for sub in (False, True):
        r, nA = realspace(L, m2, sub); p, nb = momentum(L, m2, sub)
        print('L=%d %s: real-space %.10f  momentum %.10f  diff %.1e  |A|=%d  -> per-plaquette (3/2)x/|A| = %.6f'
              % (L, 'sublattice' if sub else 'full class', r, p, r - p, nA, 1.5*r/nA), flush=True)
