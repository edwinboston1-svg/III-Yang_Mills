# large-L (midpoint-grid) value of log K per orbit plaquette, m2 = 0, 3 colours:
#   full class A:  (3/2) < log det Qf(k) / det (Qf - QA)(k) >' over k   (should be (3/2)(J4 - J2) = 1.250196)
#   sublattice A': (3/2) < log det16 Qf / det16 (Qf - QA') > over reduced-zone k'   (per A' plaquette)
# determinants on the transverse part: add m2 = 1e-30? no -- longitudinal modes are exact zeros of both; use pseudo-det
# by adding P_long (the projector onto k-hat directions) to both, which leaves the transverse blocks untouched.
import numpy as np, itertools, sys
def Qk(k):  # k: (N,4) -> (N,4,4)
    w = np.exp(1j*k) - 1; N = k.shape[0]; M = np.zeros((N,4,4), complex)
    for mu in range(4):
        for nu in range(mu+1, 4):
            f = np.zeros((N,4), complex); f[:,mu] = -w[:,nu]; f[:,nu] = w[:,mu]
            M += np.einsum('ni,nj->nij', f.conj(), f)
    return M
def Plong(k):  # projector onto the gradient direction (e^{ik}-1)
    w = np.exp(1j*k) - 1; n = np.einsum('ni,ni->n', w.conj(), w).real
    return np.einsum('ni,nj->nij', w, w.conj()) / n[:,None,None]
def vrow(k):
    v = np.zeros((k.shape[0],4), complex); v[:,0] = 1 - np.exp(1j*k[:,1]); v[:,1] = np.exp(1j*k[:,0]) - 1; return v
def grid(L, ranges):
    ax = [2*np.pi*(np.arange(n) + 0.5)/L for n in ranges]
    return np.stack(np.meshgrid(*ax, indexing='ij'), -1).reshape(-1, 4)
for L in [int(a) for a in sys.argv[1:]]:
    k = grid(L, (L, L, L, L)); Qf = Qk(k); v = vrow(k); Pl = Plong(k)
    QA = np.einsum('ni,nj->nij', v.conj(), v)
    full = np.mean(np.linalg.slogdet(Qf + Pl)[1] - np.linalg.slogdet(Qf - QA + Pl)[1])
    kk = grid(L, (L//2, L//2, L, L)); tot = 0.0
    shifts = np.array([(0,0,0,0),(np.pi,0,0,0),(0,np.pi,0,0),(np.pi,np.pi,0,0)])
    N = kk.shape[0]; Qf16 = np.zeros((N,16,16), complex); Pl16 = np.zeros((N,16,16), complex); QA16 = np.zeros((N,16,16), complex)
    vs = [vrow(kk + s) for s in shifts]
    for i, s in enumerate(shifts):
        Qf16[:,4*i:4*i+4,4*i:4*i+4] = Qk(kk + s); Pl16[:,4*i:4*i+4,4*i:4*i+4] = Plong(kk + s)
        for j in range(4):
            QA16[:,4*i:4*i+4,4*j:4*j+4] = 0.25*np.einsum('ni,nj->nij', vs[i].conj(), vs[j])
    sub = np.mean(np.linalg.slogdet(Qf16 + Pl16)[1] - np.linalg.slogdet(Qf16 - QA16 + Pl16)[1])
    print('L=%3d  full class: logK = %.6f (K = %.4f)   sublattice: logK\' = %.6f (K\' = %.4f)'
          % (L, 1.5*full, np.exp(1.5*full), 1.5*sub, np.exp(1.5*sub)), flush=True)
print('target for the full class: (3/2)(J4 - J2) = %.6f' % (1.5*(1.999707644517 - 1.166243616123)))
