"""roword.py -- AD: the row of a fitted coarse action at the ORDERED environment (every coarse link 1), by orbits.  The ordered environment
and the fitted action (complete loop families) are invariant under the 96 lattice symmetries fixing the link c = (0, e_0) as a set (permutations
and reflections of axes 1, 2, 3, and the reflection of axis 0 about the link's midpoint, which reverses c); a symmetry maps the pair (c, c') to
(c, g c') with each variable carried by a bijection (U -> U^-1 where a link is reversed), so rho(c, c' | ordered) is constant on orbits.
One representative per orbit, times the orbit size; the jackknife over the fitted couplings gives the error.
usage: python roword.py FITJSON n MODEL [njack]"""
import sys, os, json, itertools, math
import numpy as np
here = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, here)
from pairmc import s3_rule, u1_rule, maxcorr
from row import coupling_by_family
from rowlow import Env, pair_logp, NEIGH

def sym_group():
    G = []
    for perm in itertools.permutations([1, 2, 3]):
        for sg in itertools.product([1, -1], repeat=3):
            for r0 in (False, True):
                G.append((perm, sg, r0))
    return G

def act(g, link):
    """image of the link (x, d) (x the base site, d the direction) under g; c = ((0,0,0,0), 0) occupies x0 in [0, 1]"""
    perm, sg, r0 = g
    x, d = link
    # map the two endpoints, then rebuild the link
    a = list(x); b = list(x); b[d] += 1
    def mp(p):
        q = [0, 0, 0, 0]
        q[0] = (1 - p[0]) if r0 else p[0]
        for i, ax in enumerate([1, 2, 3]):
            q[perm[i]] = sg[i] * p[ax]
        return q
    A, B = mp(a), mp(b)
    dd = [i for i in range(4) if A[i] != B[i]][0]
    base = A if B[dd] > A[dd] else B
    return (tuple(base), dd)

def main():
    fj = json.load(open(sys.argv[1])); n = sys.argv[2]; model = sys.argv[3]; njack = int(sys.argv[4]) if len(sys.argv) > 4 else 0
    gsu2 = fj['G'] == 'su2'; NC = fj['N'] // int(n)
    Q, W = s3_rule(8) if gsu2 else u1_rule(256)
    th, jk = coupling_by_family(fj['blocks'][n], model)
    G = sym_group()
    c0 = ((0, 0, 0, 0), 0)
    assert all(act(g, c0) == c0 for g in G)
    links = [((tuple(x), d)) for cl in NEIGH for (x, d) in cl['links']]
    lset = set(links)
    orbits = []; seen = set()
    for l in links:
        if l in seen: continue
        orb = {act(g, l) for g in G}
        assert orb <= lset, 'orbit leaves the neighbour set'
        seen |= orb; orbits.append(sorted(orb))
    assert sum(len(o) for o in orbits) == len(links) == 122
    env = Env('ordered', NC, gsu2)
    c = ((2, 2, 2, 2), 0)
    def row_for(t):
        tot = 0.0; per = []
        for orb in orbits:
            x, d = orb[0]
            cp = (tuple(a + b for a, b in zip(c[0], x)), d)
            r = maxcorr(pair_logp(c, cp, t, env, Q, gsu2), W, W)[1]
            per.append(r); tot += r * len(orb)
        return tot, per
    tot, per = row_for(th)
    print('ROWORD %s n=%s model=%s: %d orbits (sizes %s)' % (fj['prefix'], n, model, len(orbits), [len(o) for o in orbits]))
    for orb, r in zip(orbits, per):
        print('   orbit of %-22s size %3d  rho = %.8f  share %.6f' % (str(orb[0]), len(orb), r, r * len(orb)))
    print('   ORDERED-ENVIRONMENT ROW = %.6f' % tot)
    if njack:
        vals = [row_for(t)[0] for t in jk[:njack]]
        nb = len(vals); arr = np.array(vals)
        err = math.sqrt((nb - 1) / nb * ((arr - arr.mean()) ** 2).sum())
        print('   jackknife (%d samples): row = %.6f +- %.6f   (row - 1)/err = %.1f' % (nb, tot, err, (tot - 1) / err))

if __name__ == '__main__':
    main()
