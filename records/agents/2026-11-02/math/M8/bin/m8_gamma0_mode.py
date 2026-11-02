"""M8 READING: the structure of the gap minimiser at the zone-face centre k = (pi/L, 0, 0, 0): is the softest constrained mode the pure
m = 0 alias transverse mode (annihilated by Q), whose Wilson eigenvalue is |phat|^2 = 4 sin^2(pi/(2L))?  Prints the eigenvalue, the
weight of the eigenvector on the m = 0 alias, and |Q v|.

Run: python -E -P bin/m8_gamma0_mode.py L kind
"""
import sys
import numpy as np
sys.path.insert(0, __file__.rsplit('\\', 1)[0] if '\\' in __file__ else __file__.rsplit('/', 1)[0])
from m8_blockspin import BlockSpin

L = int(sys.argv[1]); kind = sys.argv[2]
bs = BlockSpin(L, kind)
k = np.array([np.pi / L, 0, 0, 0])
Pk, Qk, Mk, Gk = bs.mats(k)
N, T, rank, rg, resid = bs.gauge_inv_basis(Qk, Gk)
H = T.conj().T @ Mk @ T
w, V = np.linalg.eigh(H)
print("L = %d %s, k = (pi/L,0,0,0): lowest eigenvalues %s ; 4 sin^2(pi/(2L)) = %.10f" % (L, kind, np.round(w[:6], 10), 4 * np.sin(np.pi / (2 * L)) ** 2))
m0 = [i for i in range(bs.nal) if not bs.mvec[i].any()][0]
for j in range(4):
    v = T @ V[:, j]
    wt0 = np.linalg.norm(v[4 * m0:4 * m0 + 4]) ** 2
    print("  mode %d: eigenvalue %.10f ; weight on the m = 0 alias %.10f ; |Q v| = %.2e ; m = 0 components %s" % (
        j, w[j], wt0, np.linalg.norm(Qk @ v), np.round(v[4 * m0:4 * m0 + 4], 6)))
# the m = 0 alias transverse vectors themselves: e_nu (nu = 2,3,4) at alias m0 — are they in ker Q?
for nu in range(1, 4):
    e = np.zeros(4 * bs.nal, complex); e[4 * m0 + nu] = 1.0
    print("  e_%d at m = 0: |Q e| = %.3e ; Rayleigh quotient %.10f" % (nu, np.linalg.norm(Qk @ e), np.real(e.conj() @ Mk @ e)))
