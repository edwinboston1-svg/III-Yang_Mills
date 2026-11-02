"""M8 (H6) adversarial READING: at fixed link-angle sup norm b, hill-climb over slice directions to MINIMISE lambda_min of the Wilson
Hessian restricted to the slice V (L = 2 half-open blocks, (4,2,2,2) torus) — an upper bound on the convexity radius b_cvx is any b at
which a configuration with lambda_min < 0 is exhibited.  Reuses the machinery of m8_h6_convexity.py (imported by exec of its
definitions up to Part 2's search).

Run: python -u -E -P bin/m8_h6_adversary.py > rec/h6_adversary.<date>.txt
"""
import sys, time
import numpy as np
here = __file__.rsplit('\\', 1)[0] if '\\' in __file__ else __file__.rsplit('/', 1)[0]
src = open(here + '/m8_h6_convexity.py', encoding='utf-8').read()
cut = src.index('# ------------------------------------------------------------------ Part 1: e(b)')
cut2 = src.index('# ------------------------------------------------------------------ Part 2: the torus')
cut3 = src.index('def crossing(')
exec(src[:cut] + src[cut2:cut3])          # definitions: su2, Fp, hess_plaq, torus, T, hess_full, lam_min; H0 needed by nothing here

rng2 = np.random.default_rng(7)


def at_b(d, b):
    B1 = T @ d
    return b * B1 / np.linalg.norm(B1.reshape(nLk, 3), axis=1).max()


t0 = time.time()
for b in (0.2, 0.3, 0.4, 0.5):
    best_all = (np.inf, None)
    for start in range(8):
        d = rng2.normal(size=T.shape[1])
        cur, amax = lam_min(at_b(d, b))
        step = 0.5
        for it in range(120):
            dt = d + step * rng2.normal(size=d.shape) * np.linalg.norm(d) / np.sqrt(d.size)
            val, am = lam_min(at_b(dt, b))
            if val < cur:
                d, cur, amax = dt, val, am
            else:
                step *= 0.98
        if cur < best_all[0]:
            best_all = (cur, amax)
        print("  b = %.2f start %d: lambda_min reached %.6f (max plaquette angle %.4f)  [%.0f s]" % (b, start, cur, amax, time.time() - t0))
    print("b = %.2f : most negative lambda_min found %.6f at max plaquette angle %.4f -> %s" % (
        b, best_all[0], best_all[1], "NON-CONVEX EXHIBITED (b_cvx <= %.2f)" % b if best_all[0] < 0 else "convex on all configurations tried"))
