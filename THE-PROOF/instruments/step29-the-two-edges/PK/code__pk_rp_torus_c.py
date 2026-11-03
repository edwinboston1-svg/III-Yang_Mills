#!/usr/bin/env python3
"""PK — run c: does the diagonal-RP failure on hypercubic tori reach the TWO-POINT function of the QUADRATIC field
(the Gaussian/weak-coupling form of the 0++ field tr F^2), which is all Theorem 8.2 consumes?
For a Gaussian field with RP matrix C_{ij} = E[X_{R i} X_j] (linear observables), the quadratic observables Q_i = X_i^2 have
  E[Q_{R i} Q_j] = c_i c_j + 2 C_{ij}^2      (c_i = Var X_i),   connected part 2 C∘C (Hadamard square).
Checks: (1) connected form 2 C∘C; (2) unsubtracted form c c^T + 2 C∘C. Survey in double precision; for negative cases an
exact certificate (integer v, exact v^T A v < 0). Stake (written before this run, WORK.md §3.3): UNGUESSED — the Hadamard square
of an indefinite matrix may or may not be PSD; the answer decides whether Corollary 8.3's two-point form is hit at the Gaussian level."""
import sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from fractions import Fraction as Fr
import numpy as np
import pk_rp_torus as K


def gff_C(T, R, m2, exact, Dmax=None):
    G = K.green_table(T, m2, exact)
    plus = K.plus_sites(T, R, Dmax)
    C = [[G[K.diff(T, K.refl_site(T, R, x), y)] for y in plus] for x in plus]
    var = [G[K.diff(T, x, x)] for x in plus]          # Var X_x = G(0); and Var X_{Rx} = G(0) too
    return plus, C, var


def maxwell_C(T, R, exact):
    G = K.green_table(T, Fr(0) if exact else 0, exact)
    plaqs = K.plus_plaquettes(T, R)
    pulled = [K.pull_back(T, R, p[3]) for p in plaqs]
    C = [[K.link_cov(G, T, pulled[i], plaqs[j][3]) for j in range(len(plaqs))] for i in range(len(plaqs))]
    var = [K.link_cov(G, T, pulled[i], pulled[i]) for i in range(len(plaqs))]   # Var of X_{R p}
    var2 = [K.link_cov(G, T, plaqs[i][3], plaqs[i][3]) for i in range(len(plaqs))]
    return plaqs, C, var, var2


def analyse(label, C, var, var2, exact_data=None):
    Cn = np.array([[float(x) for x in row] for row in C])
    A = 2 * Cn * Cn
    ev1 = np.linalg.eigvalsh((Cn + Cn.T) / 2)
    evA, vecA = np.linalg.eigh((A + A.T) / 2)
    vv = np.array([float(x) for x in var]); vv2 = np.array([float(x) for x in var2])
    B = np.outer(vv, vv2) + A
    evB, vecB = np.linalg.eigh((B + B.T) / 2)
    K.out("%s: n=%d  linear lam_min=%.4e | connected 2CoC lam_min=%.4e lam_max=%.4e neg=%d | unsubtracted lam_min=%.4e neg=%d"
          % (label, len(C), ev1[0], evA[0], evA[-1], int(np.sum(evA < -1e-12)), evB[0], int(np.sum(evB < -1e-12))))
    if exact_data is not None:
        Cx, varx, var2x = exact_data
        for name, vec, mk in (("connected", vecA[:, 0], lambda i, j: 2 * Cx[i][j] * Cx[i][j]),
                              ("unsubtracted", vecB[:, 0], lambda i, j: varx[i] * var2x[j] + 2 * Cx[i][j] * Cx[i][j])):
            v = K.rationalize(vec)
            n = len(v)
            q = sum(v[i] * mk(i, j) * v[j] for i in range(n) if v[i] for j in range(n) if v[j])
            K.out("   EXACT %s form: v^T A v = %.6e  [%s]" % (name, float(q), "NEGATIVE: refuted" if q < 0 else "not negative (no certificate either way)"))


K.out("pk_rp_torus_c.py")
for (N, D) in ((4, None), (6, None), (6, 1)):
    T = K.Torus('H', N, 2)
    plus, Cx, varx = gff_C(T, 'swap', Fr(1), True, D)
    analyse("GFF H N=%d swap Dmax=%s" % (N, D), Cx, varx, varx, (Cx, varx, varx))
for N in (8, 12):
    T = K.Torus('H', N, 2)
    plus, C, var = gff_C(T, 'swap', 1.0, False)
    analyse("GFF H N=%d swap" % N, C, var, var)
for N in (4, 6):
    T = K.Torus('H', N, 2)
    plus, C, var = gff_C(T, 'coord', 1.0, False)
    analyse("GFF H N=%d coord (control)" % N, C, var, var)
for (N, d, ex) in ((4, 3, True), (6, 3, True), (4, 4, False)):
    T = K.Torus('H', N, d)
    plaqs, C, var, var2 = maxwell_C(T, 'swap', ex)
    analyse("MAXWELL H N=%d d=%d swap" % (N, d), C, var, var2, (C, var, var2) if ex else None)
T = K.Torus('H', 4, 3)
plaqs, C, var, var2 = maxwell_C(T, 'coord', False)
analyse("MAXWELL H N=4 d=3 coord (control)", C, var, var2)
T = K.Torus('A', 3, 3)
plaqs, C, var, var2 = maxwell_C(T, 'swap', False)
analyse("MAXWELL A N=3 d=3 swap (adapted control)", C, var, var2)
K.out("done")
