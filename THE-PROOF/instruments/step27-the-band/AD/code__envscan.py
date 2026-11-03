"""envscan.py -- AD: how far an environment lifts a pair's maximal correlation above the free value, for the spin-1/2 one-loop coupling.
Pair law p(u, v) ~ exp(<u, A> + <v, B> + theta <u, v>) on S^3 x S^3 (every one-loop spin-1/2 pair reduces to this by the bijections
U -> U X, V -> V Y; A, B the summed spin-1/2 staples of the loops through each link that the other does not share, |A|, |B| <= the coupling
budget a).  Invariants: |A|, |B|, and the angle between A and B (SO(4) acting on (A, B) diagonally).  Scans the 3-parameter box and prints
rho / rho_free.  READING (quadrature m = 8, exact to degree 15; checked against m = 10 at the maximum).
usage: python envscan.py theta amax"""
import sys
import numpy as np
from pairmc import s3_rule, maxcorr

theta = float(sys.argv[1]); amax = float(sys.argv[2])
Q, W = s3_rule(8)
UV = Q @ Q.T                                      # <u, v> = Re(U conj(V)) -- the coupling written as <u, v>
free = maxcorr(theta * UV, W, W)[1]
print('ENVSCAN theta=%.4f amax=%.4f: free rho = %.10f' % (theta, amax, free))
best = (0, None)
grid = np.linspace(0, amax, 7)
for a in grid:
    for b in grid:
        if b < a: continue
        for ang in np.linspace(0, np.pi, 7):
            A = np.array([a, 0, 0, 0]); B = b * np.array([np.cos(ang), np.sin(ang), 0, 0])
            lp = theta * UV + (Q @ A)[:, None] + (Q @ B)[None, :]
            r = maxcorr(lp, W, W)[1]
            if r > best[0]: best = (r, (a, b, ang))
print('ENVSCAN max over the grid: rho = %.10f = %.4f x free at |A| = %.3f |B| = %.3f angle = %.3f' % (best[0], best[0] / free, *best[1]))
Q2, W2 = s3_rule(10); UV2 = Q2 @ Q2.T
a, b, ang = best[1]; A = np.array([a, 0, 0, 0]); B = b * np.array([np.cos(ang), np.sin(ang), 0, 0])
print('ENVSCAN check m=10 at the maximum: rho = %.10f' % maxcorr(theta * UV2 + (Q2 @ A)[:, None] + (Q2 @ B)[None, :], W2, W2)[1])
# a radial profile at equal |A| = |B| and the three special angles
for ang in [0.0, np.pi / 2, np.pi]:
    row = []
    for a in np.linspace(0, amax, 6):
        A = np.array([a, 0, 0, 0]); B = a * np.array([np.cos(ang), np.sin(ang), 0, 0])
        row.append(maxcorr(theta * UV + (Q @ A)[:, None] + (Q @ B)[None, :], W, W)[1] / free)
    print('ENVSCAN |A|=|B| angle %.3f: rho/free at |A| = %s : %s' % (ang, ' '.join('%.3f' % x for x in np.linspace(0, amax, 6)), ' '.join('%.4f' % x for x in row)))
