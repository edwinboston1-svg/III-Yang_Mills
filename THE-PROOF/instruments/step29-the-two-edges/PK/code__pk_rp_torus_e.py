#!/usr/bin/env python3
"""PK — run e: exact certificate for the quadratic (0++ at Gaussian level) two-point RP form of Maxwell on (Z/4)^4 under the swap."""
import sys, os, time
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from fractions import Fraction as Fr
import numpy as np
import pk_rp_torus as K

t0 = time.time()
T = K.Torus('H', 4, 4)
Gx = K.green_table(T, Fr(0), exact=True)
plaqs = K.plus_plaquettes(T, 'swap')
pulled = [K.pull_back(T, 'swap', p[3]) for p in plaqs]
n = len(plaqs)
C = [[K.link_cov(Gx, T, pulled[i], plaqs[j][3]) for j in range(n)] for i in range(n)]
K.out("exact C built: n=%d (%.1fs); exactly symmetric: %s" % (n, time.time() - t0, all(C[i][j] == C[j][i] for i in range(n) for j in range(i))))
Cn = np.array([[float(x) for x in row] for row in C])
A = 2 * Cn * Cn
ev, vec = np.linalg.eigh(A)
K.out("double: 2CoC lam_min=%.6e lam_max=%.6e neg=%d" % (ev[0], ev[-1], int(np.sum(ev < -1e-12))))
var = [K.link_cov(Gx, T, pulled[i], pulled[i]) for i in range(n)]
var2 = [K.link_cov(Gx, T, plaqs[i][3], plaqs[i][3]) for i in range(n)]
v = K.rationalize(vec[:, 0])
q = sum(v[i] * 2 * C[i][j] * C[i][j] * v[j] for i in range(n) if v[i] for j in range(n) if v[j])
qu = q + sum(v[i] * var[i] for i in range(n)) * sum(v[j] * var2[j] for j in range(n))
K.out("EXACT connected quadratic form v^T (2CoC) v = %.6e [%s]; unsubtracted = %.6e [%s]; sum(v)=%d (%.1fs)"
      % (float(q), "NEGATIVE: refuted" if q < 0 else "not negative", float(qu), "NEGATIVE: refuted" if qu < 0 else "not negative",
         sum(v), time.time() - t0))
