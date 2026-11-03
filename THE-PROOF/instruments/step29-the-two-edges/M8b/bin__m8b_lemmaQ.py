"""M8b LEMMA Q AT FINITE DEPTH (READING, double precision): is T_2 o T_2 = T_4 (half-open blocks) and T_3 (centred) vs T_2 o T_2 on the
gauge-invariant free kernel?  Compares K from Wilson after two L = 2 half-open steps with K after one L = 4 half-open step (Lemma Q (b)-(c)
predict equality to rounding), and the L = 2 half-open step with the L = 2 ... and the L = 3 centred step with the L = 3 half-open step
(Lemma Q (a)-(b): the block's base point and contours do not enter).
Run: python -u -E -P bin/m8b_lemmaQ.py > rec/lemmaQ.<date>.txt
"""
import sys, itertools
import numpy as np
sys.path.insert(0, __file__.rsplit('\\', 1)[0] if '\\' in __file__ else __file__.rsplit('/', 1)[0])
from m8_blockspin import BlockSpin


def phat(P):
    return np.exp(1j * P) - 1.0


def wilson_K(P):
    ph = phat(P)
    return (np.abs(ph) ** 2).sum(1)[:, None, None] * np.eye(4) - ph[:, :, None] * ph[:, None, :].conj()


def curvW(P):
    ph = phat(P)
    W = np.zeros((P.shape[0], 6, 4), complex)
    a = 0
    for mu in range(4):
        for nu in range(mu + 1, 4):
            W[:, a, nu] = ph[:, mu]; W[:, a, mu] = -ph[:, nu]; a += 1
    return W


def pinv_herm(A, rel=1e-10):
    w, U = np.linalg.eigh(A)
    tol = rel * np.abs(w).max(axis=1, keepdims=True)
    winv = np.where(np.abs(w) > tol, 1.0 / np.where(np.abs(w) > tol, w, 1.0), 0.0)
    return (U * winv[:, None, :]) @ U.conj().transpose(0, 2, 1)


def step(bs, Pparent, Kfun):
    L = bs.L
    MV = bs.mvec.astype(float)
    Pc = ((Pparent[:, None, :] + 2 * np.pi * MV[None, :, :]) / L).reshape(-1, 4)
    Kc = Kfun(Pc)
    ph = phat(Pc)
    Gc = np.linalg.inv(Kc + ph[:, :, None] * ph[:, None, :].conj())
    Qc = bs.Qhat(Pc)
    T = Qc @ Gc @ Qc.conj().transpose(0, 2, 1)
    Gp = T.reshape(Pparent.shape[0], L ** 4, 4, 4).sum(axis=1) / L ** 4
    W = curvW(Pparent)
    C = pinv_herm(W @ Gp @ W.conj().transpose(0, 2, 1))
    return W.conj().transpose(0, 2, 1) @ C @ W


rng = np.random.default_rng(3)
P = rng.uniform(-np.pi, np.pi, size=(40, 4))
b2h, b4h, b3c, b3h = BlockSpin(2, 'half'), BlockSpin(4, 'half'), BlockSpin(3, 'centred'), BlockSpin(3, 'half')
K22 = step(b2h, P, lambda Q: step(b2h, Q, wilson_K))
K4 = step(b4h, P, wilson_K)
K3c = step(b3c, P, wilson_K)
K3h = step(b3h, P, wilson_K)
scale = np.abs(K4).max(axis=(1, 2))
print("T_2 o T_2 (half) against T_4 (half): max relative entry difference over 40 random momenta = %.3e" % (np.abs(K22 - K4).max(axis=(1, 2)) / scale).max())
print("T_3 centred against T_3 half-open: max relative entry difference = %.3e" % (np.abs(K3c - K3h).max(axis=(1, 2)) / np.abs(K3c).max(axis=(1, 2))).max())
print("control (should NOT vanish): T_4 against T_3 centred = %.3e" % (np.abs(K4 - K3c).max(axis=(1, 2)) / scale).max())
