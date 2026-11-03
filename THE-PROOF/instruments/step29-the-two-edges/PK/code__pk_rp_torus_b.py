#!/usr/bin/env python3
"""PK — run b (after run a): (i) an EXACT certificate that the diagonal-RP defect reaches observables away from the twisted set
(GFF (Z/6)^2, +side d <= 1, two units from d = 3); (ii) READINGS of the defect's decay with the distance to the twisted set at two
masses (double precision, no claim); (iii) the same restriction for Maxwell on (Z/6)^3, exact."""
import sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from fractions import Fraction as Fr
import numpy as np
import pk_rp_torus as K

K.out("pk_rp_torus_b.py")
K.out("== (i) exact: GFF (Z/6)^2, swap, +side d <= 1 (the twisted set is d = 3) ==")
for m2 in (1, Fr(1, 4)):
    K.gff_case('H', 6, 2, 'swap', m2, exact_cert=True, exact_psd_check=True, Dmax=1, label="b-i")
K.out("== (ii) readings: GFF (Z/N)^2, swap, lam_min against D (distance to the twisted set N/2 - D) ==")
for m2 in (1.0, 0.04):
    for N in (12, 16):
        for D in range(1, N // 2):
            K.gff_case('H', N, 2, 'swap', m2, exact_cert=False, exact_psd_check=False, Dmax=D, label="b-ii")


def maxwell_restricted(N, d, Dmax, exact):
    T = K.Torus('H', N, d)
    Gf = K.green_table(T, 0, exact=False)
    plaqs = [p for p in K.plus_plaquettes(T, 'swap')
             if all(((2 * (s[0] - s[1]) + (1 if mu == 0 else -1 if mu == 1 else 0)) % (2 * N)) <= 2 * Dmax for (s, mu) in p[3])]
    M = K.maxwell_matrix(T, 'swap', Gf, plaqs)
    ev, evec = np.linalg.eigh((M + M.T) / 2)
    K.out("MAXWELL b-iii N=%d d=%d swap, +side plaquettes with every link midpoint d <= %d: n=%d lam_min=%.6e lam_max=%.6e neg=%d"
          % (N, d, Dmax, len(plaqs), ev[0], ev[-1], int(np.sum(ev < -1e-12))))
    if exact:
        Gx = K.green_table(T, Fr(0), exact=True)
        v = K.rationalize(evec[:, 0])
        a, b = {}, {}
        for vi, p in zip(v, plaqs):
            if vi == 0:
                continue
            for key, c in K.pull_back(T, 'swap', p[3]).items():
                a[key] = a.get(key, 0) + vi * c
            for key, c in p[3].items():
                b[key] = b.get(key, 0) + vi * c
        q = K.link_cov(Gx, T, a, b)
        K.out("   EXACT certificate: v^T M v = %s = %.6e [%s]" % (q, float(q), "NEGATIVE: RP REFUTED" if q < 0 else "not negative"))

K.out("== (iii) Maxwell (Z/6)^3, swap, +side plaquettes with all link midpoints at d <= 1 (twisted set d = 3) ==")
maxwell_restricted(6, 3, 1, exact=True)
K.out("done")
