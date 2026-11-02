"""M8 (H1) READING: the tree-level map of the dimension-six content of the free kernel under one blocking step.
Fine kernel: plaquette + rectangle, M_c(p) = sum_{mu<nu} w_{mu nu}(p) |phat_mu A_nu - phat_nu A_mu|^2,
   w_{mu nu}(p) = c0 + c1 (|1 + e^{i p_mu}|^2 + |1 + e^{i p_nu}|^2), c0 + 8 c1 = 1 (beta = the continuum F^2 coefficient);
its relative O(p^2) part is tau_fine(p) = -c1 (p_mu^2 + p_nu^2) + (Wilson's own -sum p^2/12-type terms).
Blocked kernel K'(k) by the exact Gaussian minimum (as in m8_c1_reading.py); tau(k) := K'_transverse / (coarse Wilson kernel) - 1.
Reports d tau / d c1 at small k (axis and diagonal) against the canonical expectation: a fine-scale term c1 * p^2 appears at the coarse
scale as (c1 / L^2) (kL)^2 — contraction L^-2 — plus the aliases' contribution.  Also iterates: the coarse kernel's own tau is compared
with the rectangle-equivalent c1 it represents.

Run: python -E -P bin/m8_h1_band.py L kind
"""
import sys
import numpy as np
sys.path.insert(0, __file__.rsplit('\\', 1)[0] if '\\' in __file__ else __file__.rsplit('/', 1)[0])
from m8_blockspin import BlockSpin

L = int(sys.argv[1]); kind = sys.argv[2]
bs = BlockSpin(L, kind); nal = bs.nal


def Mblock(Pk, c1):
    c0 = 1 - 8 * c1
    ph = bs.phat(Pk)
    Mk = np.zeros((4 * nal, 4 * nal), complex)
    for m in range(nal):
        v = ph[m]
        blk = np.zeros((4, 4), complex)
        for mu in range(4):
            for nu in range(mu + 1, 4):
                w = c0 + c1 * (abs(1 + np.exp(1j * Pk[m, mu])) ** 2 + abs(1 + np.exp(1j * Pk[m, nu])) ** 2)
                wv = np.zeros(4, complex); wv[nu] = v[mu]; wv[mu] = -v[nu]      # F = wv^T A
                blk += w * np.outer(wv.conj(), wv)
        Mk[4 * m:4 * m + 4, 4 * m:4 * m + 4] = blk
    return Mk


def tau(k, c1):
    Pk, Qk, Mk0, Gk = bs.mats(k)
    Mk = Mblock(Pk, c1)
    N, T, rank, rg, resid = bs.gauge_inv_basis(Qk, Gk)
    H = T.conj().T @ Mk @ T
    Qp = np.linalg.pinv(Qk)
    Kp = Qp.conj().T @ (Mk - Mk @ T @ np.linalg.solve(H, T.conj().T @ Mk)) @ Qp / L ** 4
    kc = np.exp(1j * L * k) - 1.0
    Mc = np.vdot(kc, kc).real * np.eye(4) - np.outer(kc, kc.conj())
    Pt = np.eye(4) - np.outer(kc, kc.conj()) / np.vdot(kc, kc).real
    evK = np.linalg.eigvalsh(Pt @ Kp @ Pt)[-3:]
    evM = np.linalg.eigvalsh(Pt @ Mc @ Pt)[-3:]
    return evK / evM - 1.0


print("M8 (H1) reading, L = %d %s" % (L, kind))
# check: Mblock at c1 = 0 equals the Wilson block of mats()
Pk, Qk, Mk0, Gk = bs.mats(np.array([0.1, 0.2, 0.05, 0.3]))
print("Mblock(c1=0) vs Wilson: max diff %.2e" % np.abs(Mblock(Pk, 0.0) - Mk0).max())
for name, d in (("axis", np.array([1, 0, 0, 0.])), ("diag2", np.array([1, 1, 0, 0.]) / np.sqrt(2)), ("diag4", np.array([1, 1, 1, 1.]) / 2)):
    for kL in (0.05, 0.025):
        k = kL * d / L
        t0 = tau(k, 0.0); tp = tau(k, 0.01); tm = tau(k, -0.01)
        dt = (tp - tm) / 0.02
        print("  %-5s |k|L = %.3f : tau(c1=0)/(kL)^2 = %s ; d tau/d c1 /(kL)^2 = %s" % (
            name, kL, np.round(t0 / kL ** 2, 6), np.round(dt / kL ** 2, 6)))
# the fine kernel's own response: tau_fine for the same c1 at fine momentum p = k (fine units), i.e. -(c1)(p_mu^2+p_nu^2) weighted;
# canonical contraction predicts d tau_coarse / d c1 = (d tau_fine / d c1) / L^2 when expressed per (kL)^2
for name, d in (("axis", np.array([1, 0, 0, 0.])), ("diag2", np.array([1, 1, 0, 0.]) / np.sqrt(2)), ("diag4", np.array([1, 1, 1, 1.]) / 2)):
    p = 0.01 * d
    # fine transverse eigenvalue ratio of M_c to Wilson at momentum p
    def ftau(c1):
        ph = bs.phat(p[None, :])[0]
        Mw = np.vdot(ph, ph).real * np.eye(4) - np.outer(ph, ph.conj())
        Mc = Mblock(p[None, :], c1)
        Pt = np.eye(4) - np.outer(ph, ph.conj()) / np.vdot(ph, ph).real
        return np.linalg.eigvalsh(Pt @ Mc @ Pt)[-3:] / np.linalg.eigvalsh(Pt @ Mw @ Pt)[-3:] - 1
    dft = (ftau(0.01) - ftau(-0.01)) / 0.02 / 0.01 ** 2
    print("  fine kernel d tau/d c1 / p^2 (%s): %s ; divided by L^2: %s" % (name, np.round(dft, 6), np.round(dft / L ** 2, 6)))
