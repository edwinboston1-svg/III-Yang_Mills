# kp_point.py -- the float road of kp_reach6.py evaluated AT ONE COUPLING: for BETA (env) scan alpha on the grid k*2e-4 and print, for
# the first alpha where KP holds, the triple (beta, alpha, kappa) and the leaf sum, so a certificate in exact rationals (aperanton_kp_cert.awk)
# can be handed the same point and asked to confirm it with outward rounding.  No bisection: the point is given.  GTABLE/F0/MU as kp_reach6.
# usage: BETA=0.477 GTABLE=3,3,3.9316,3.9316,4.1493,4.6125,4.6125,6.2208 python -I kp_point.py
import math, os, sys
sys.argv = [sys.argv[0]]
src = open(os.path.join(os.path.dirname(os.path.abspath(__file__)), "kp_reach6.py"), encoding="utf-8").read()
src = src.split("b, best = reach()")[0]          # the functions only; no bisection
exec(compile(src, "kp_reach6.py", "exec"))
beta = float(os.environ.get("BETA", "0.477"))
a = prep(beta)
print("# kp_point: beta = %.6f  F0 = %d  MU = %.2f  KTREE = %.0f  GTABLE = %s  u = %.6f  a1 = %.6f" % (beta, F0, MU, KTREE, GTABLE, a[1], a[2]))
found = None
for k in range(1, 2001):
    al = k * 2e-4
    kap = kappa_dress(a, KTREE * al)
    if kap == float("inf"): continue
    S = leaf_sum(a, KTREE * al, kap)
    if S <= al:
        found = (al, kap, S); break
if found:
    al, kap, S = found
    print("KP-POINT beta=%.6f alpha=%.6f kappa=%.9f leafsum=%.9f margin=%.3e HOLDS" % (beta, al, kap, S, al - S))
else:
    best = None
    for k in range(1, 2001):
        al = k * 2e-4; kap = kappa_dress(a, KTREE * al)
        if kap == float("inf"): continue
        S = leaf_sum(a, KTREE * al, kap)
        if S != float("inf") and (best is None or S - al < best[2] - best[0]): best = (al, kap, S)
    print("KP-POINT beta=%.6f REFUSED (no alpha on the grid): nearest alpha=%.6f kappa=%.9f leafsum=%.9f" % ((beta,) + (best if best else (0, 0, float("inf")))))
