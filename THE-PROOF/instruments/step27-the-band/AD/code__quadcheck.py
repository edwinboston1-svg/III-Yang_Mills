"""quadcheck.py -- AD: the quadrature error of the ordered-environment pair correlations: the two dominant orbits at m = 8 (1024 points,
degree 15) against m = 10 (2000 points, degree 19) and m = 12 (3456 points, degree 23).
usage: python quadcheck.py FITJSON n MODEL"""
import sys, os, json
here = os.path.dirname(os.path.abspath(__file__)); sys.path.insert(0, here)
from pairmc import s3_rule, maxcorr
from row import coupling_by_family
from rowlow import Env, pair_logp
fj = json.load(open(sys.argv[1])); n = sys.argv[2]; model = sys.argv[3]
th, _ = coupling_by_family(fj['blocks'][n], model)
env = Env('ordered', fj['N'] // int(n), True)
c = ((2, 2, 2, 2), 0)
for rel in [((0, -1, 0, 0), 1), ((0, -1, 0, 0), 0), ((0, -1, -1, 0), 1)]:
    cp = (tuple(a + b for a, b in zip(c[0], rel[0])), rel[1])
    vals = []
    for m in (8, 10, 12):
        Q, W = s3_rule(m)
        vals.append(maxcorr(pair_logp(c, cp, th, env, Q, True), W, W)[1])
    print('QUADCHECK orbit %s: m=8 %.12f  m=10 %.12f  m=12 %.12f  |8-12| = %.2e' % (str(rel), vals[0], vals[1], vals[2], abs(vals[0] - vals[2])))
