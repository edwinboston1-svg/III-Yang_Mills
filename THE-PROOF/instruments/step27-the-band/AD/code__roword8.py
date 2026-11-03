"""roword8.py -- AD: the ordered-environment row of the 17-coupling action (twelve plaquette/6-link terms + five 8-link classes, spin 1/2).
At the ordered environment every link other than c, c' is 1, so an 8-loop through c alone contributes t_k Re(U) (Re U^-1 = Re U), through c'
alone t_k Re(V), and through both t_k Re(U^s1 V^s2) with s1, s2 the orientations of c, c' in it (the links between them are 1).  The
8-loop incidences are enumerated from sap.py's walks, per orbit representative.  Same orbits and quadrature as roword.py.
usage: python roword8.py FITJSON(17-feature) MODEL [njack]"""
import sys, os, json, math
import numpy as np
here = os.path.dirname(os.path.abspath(__file__)); sys.path.insert(0, here)
from pairmc import s3_rule, maxcorr, qmul
from rowlow import Env, pair_logp, NEIGH
from roword import sym_group, act
from sap import closed_walks

CLS = {(0, 0, 1, 3): 0, (0, 0, 2, 2): 1, (0, 1, 1, 1): 2, (0, 1, 1, 2): 3, (1, 1, 1, 1): 4}
NK = [24, 60, 48, 1440, 1296]

def loops8_through_c():
    """the 2868 polygons through c = ((0,0,0,0), 0), as (class, [(site, dir, sign)])"""
    out = []
    for w in closed_walks(8):
        ext = tuple(sorted(max(p[i] for p in w) - min(p[i] for p in w) for i in range(4)))
        links = []
        for k in range(8):
            a, b = w[k], w[(k + 1) % 8]
            d = [i for i in range(4) if a[i] != b[i]][0]
            links.append((tuple(a), d, 1) if b[d] > a[d] else (tuple(b), d, -1))
        out.append((CLS[ext], links))
    return out

def theta17(fit_block, model, js=None):
    m = fit_block['models'][model]
    vals = m['theta'] if js is None else js
    th = np.zeros((4, 3)); t8 = np.zeros(5)
    for k, f in enumerate(m['idx']):
        if f < 12: fam, rep = divmod(f, 3); th[fam, rep] = vals[k]
        else: t8[f - 12] = vals[k]
    return th, t8

def main():
    fj = json.load(open(sys.argv[1])); model = sys.argv[2]; njack = int(sys.argv[3]) if len(sys.argv) > 3 else 0
    blk = fj['blocks']['4']; NC = fj['N'] // 4
    Q, W = s3_rule(8); Qc = Q * np.array([1.0, -1, -1, -1])
    L8 = loops8_through_c()
    G = sym_group(); links = [(tuple(x), d) for cl in NEIGH for (x, d) in cl['links']]
    orbits = []; seen = set()
    for l in links:
        if l in seen: continue
        orb = {act(g, l) for g in G}; seen |= orb; orbits.append(sorted(orb))
    env = Env('ordered', NC, True)
    c = ((2, 2, 2, 2), 0)
    reU = Q[:, 0]
    # per orbit: shared 8-loops by (class, s1, s2) and the count of shared per class
    shared = []
    for orb in orbits:
        x, d = orb[0]
        cnt = {}; S = np.zeros(5)
        for k, ls in L8:
            sc = [l[2] for l in ls if (l[0], l[1]) == ((0, 0, 0, 0), 0)]
            sp = [l[2] for l in ls if (l[0], l[1]) == (tuple(x), d)]
            if sp:
                cnt[(k, sc[0], sp[0])] = cnt.get((k, sc[0], sp[0]), 0) + 1; S[k] += 1
        shared.append((cnt, S))
    def row_for(th, t8):
        tot = 0.0; per = []
        for orb, (cnt, S) in zip(orbits, shared):
            x, d = orb[0]
            cp = (tuple(a + b for a, b in zip(c[0], x)), d)
            lp = pair_logp(c, cp, th, env, Q, True)
            # 8-loops: unshared through c and through c' (the 2868 through each, minus the shared ones), shared by orientation
            lp += (np.dot(t8, np.array(NK) - S)) * (reU[:, None] + reU[None, :])
            for (k, s1, s2), m in cnt.items():
                Us = Q if s1 > 0 else Qc; Vs = Q if s2 > 0 else Qc
                lp += t8[k] * m * (Us @ (Vs * np.array([1.0, -1, -1, -1])).T)     # Re(U^s1 V^s2) = <u^s1, conj(v^s2)>
            r = maxcorr(lp, W, W)[1]; per.append(r); tot += r * len(orb)
        return tot, per
    th, t8 = theta17(blk, model)
    tot, per = row_for(th, t8)
    print('ROWORD8 %s model=%s: t8 = %s' % (fj['prefix'], model, ' '.join('%+.6f' % v for v in t8)))
    for orb, (cnt, S), r in zip(orbits, shared, per):
        print('   orbit of %-22s size %3d  shared 8-loops %s  rho = %.8f  share %.6f' % (str(orb[0]), len(orb), [int(v) for v in S], r, r * len(orb)))
    print('   ORDERED-ENVIRONMENT ROW (17 couplings) = %.6f' % tot)
    if njack:
        vals = []
        for js in blk['models'][model]['jack'][:njack]:
            a, b = theta17(blk, model, js); vals.append(row_for(a, b)[0])
        arr = np.array(vals); nb = len(arr); err = math.sqrt((nb - 1) / nb * ((arr - arr.mean()) ** 2).sum())
        print('   jackknife (%d): row = %.6f +- %.6f' % (nb, tot, err))

if __name__ == '__main__':
    main()
