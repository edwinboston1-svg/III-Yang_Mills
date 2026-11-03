"""lemmaA.py -- AD: the averaging map's abelian identity (Lemma A) as a known answer on the FINITE torus.
For the photon on the N^4 torus (Feynman gauge, precision beta*k^2 per component, the zero mode dropped -- it does not enter a coarse plaquette),
the chain-map coarse plaquette C2 F_{01}(Y) = n^-4 sum_{x in B_Y} Flux(n x n square at x) has
  beta * Var = N^-4 sum_{k != 0} |K_n(k)|^2 (khat_0^2 + khat_1^2)/khat^2,   |K_n|^2 = n^-8 D_n(k_0)^2 D_n(k_1)^2 D_n(k_2) D_n(k_3)
(the n x n square's flux has Fourier factor (e^{ink0}-1)/(e^{ik0}-1) (e^{ink1}-1)/(e^{ik1}-1) times F_01(k); the start points average gives
the further box factor in all four directions).  Lemma A says the tree-averaged coarse plaquette of ymc.c IS C2 F for a U(1) field (to the
normalisation's third order), so -2 beta log E[cos Theta_coarse] on the sampled photon must reproduce these numbers.
usage: python lemmaA.py N  -> prints beta*Var for n = 1, 2, 4"""
import sys
import numpy as np

def Dn(p, n):
    s = np.sin(p / 2.0); out = np.empty_like(p); small = np.abs(s) < 1e-12
    out[~small] = (np.sin(n * p[~small] / 2.0) / s[~small]) ** 2; out[small] = float(n * n); return out

def torus(N, n):
    k = 2 * np.pi * np.arange(N) / N
    D = Dn(k, n); S = 4 * np.sin(k / 2) ** 2
    num = (D ** 2)[:, None, None, None] * (D ** 2)[None, :, None, None] * D[None, None, :, None] * D[None, None, None, :]
    den = S[:, None, None, None] + S[None, :, None, None] + S[None, None, :, None] + S[None, None, None, :]
    s01 = S[:, None, None, None] + S[None, :, None, None]
    with np.errstate(divide='ignore', invalid='ignore'):
        t = num * s01 / den
    t[0, 0, 0, 0] = 0.0
    return t.sum() / N ** 4 / float(n) ** 8

if __name__ == '__main__':
    N = int(sys.argv[1])
    for n in [1, 2, 4]:
        print('LEMMA-A torus N=%d n=%d: beta*Var(C2F) = %.8f' % (N, n, torus(N, n)))
