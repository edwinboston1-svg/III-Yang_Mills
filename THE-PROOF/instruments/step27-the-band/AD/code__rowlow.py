"""rowlow.py -- AD: the conditional row of a FITTED coarse action at EXPLICIT environments (every other coarse link given), exactly by
quadrature.  For the link c and every neighbour c' (neigh.json), the conditional law of (V_c, V_c') given all other coarse links is
  p(U, V) ~ exp( sum over loops through c or c' of theta_(fam,rep) g_rep(Re loop) ),
built loop by loop (the other links of each loop read from the environment), and rho(c, c' | xi) is its second singular value.  Any
environment in the support gives rho(c, c'| xi) <= R(c, c') = ess sup: the row at an explicit environment is a LOWER bound on the
fitted action's row (each pair may also take its own environment: the max over environments, pair by pair, is still a lower bound).
Environments: 'ordered' (every link 1), 'haar:SEED' (independent Haar links), 'mc:FILE:K' (the K-th saved coarse configuration).
usage: python rowlow.py FITJSON n MODEL ENV [ENV ...]"""
import sys, os, json, itertools, math
import numpy as np
here = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, here)
from pairmc import s3_rule, u1_rule, maxcorr, qmul
from row import coupling_by_family, gfun

L = json.load(open(os.path.join(here, 'loops.json')))
FAMN = ['plaquette', 'rectangle', 'chair', 'parallelogram']
LOOPS = [(fi, tuple(st), [tuple(s) for s in steps]) for fi, f in enumerate(FAMN) for st, steps in L[f]]
NEIGH = json.load(open(os.path.join(here, 'neigh.json')))

def loop_links(st, steps, base):
    x = [a + b for a, b in zip(base, st)]; out = []
    for d, s in steps:
        if s > 0: out.append((tuple(x), d, 1)); x[d] += 1
        else: x[d] -= 1; out.append((tuple(x), d, -1))
    return out

_LT = {}
def _loops_through_origin(d):
    res = []
    for b in itertools.product(range(-3, 4), repeat=4):
        for fi, st, steps in LOOPS:
            ls = loop_links(st, steps, b)
            if any((l[0], l[1]) == ((0, 0, 0, 0), d) for l in ls): res.append((fi, ls))
    return res
def loops_through(link):
    """every (family, ordered link list) containing link = (site, dir): the translate of the origin's list"""
    x, d = link
    if d not in _LT: _LT[d] = _loops_through_origin(d)
    return [(fi, [(tuple(a + b for a, b in zip(l[0], x)), l[1], l[2]) for l in ls]) for fi, ls in _LT[d]]

def conjq(q): return q * np.array([1.0, -1, -1, -1])

class Env:
    def __init__(self, spec, NC=6, gsu2=True):
        self.NC = NC; self.gsu2 = gsu2
        if spec == 'ordered':
            self.V = np.zeros((NC,) * 4 + (4, 4)); self.V[..., 0] = 1.0
        elif spec.startswith('haar:'):
            rng = np.random.default_rng(int(spec.split(':')[1]))
            if gsu2:
                g = rng.normal(size=(NC,) * 4 + (4, 4)); self.V = g / np.linalg.norm(g, axis=-1, keepdims=True)
            else:
                t = rng.uniform(0, 2 * np.pi, size=(NC,) * 4 + (4,)); self.V = np.zeros((NC,) * 4 + (4, 4))
                self.V[..., 0] = np.cos(t); self.V[..., 3] = np.sin(t)
        elif spec.startswith('mc:'):
            _, fn, k = spec.split(':', 2) if spec.count(':') == 2 else (None, None, None)
            fn, k = spec[3:].rsplit(':', 1); k = int(k)
            raw = np.fromfile(fn, dtype=np.float64)
            per = NC ** 4 * 4 * 4
            self.V = raw[k * per:(k + 1) * per].reshape((NC,) * 4 + (4, 4))
        self.spec = spec
    def link(self, x, d):
        return self.V[tuple(c % self.NC for c in x) + (d,)]

def pair_logp(c, cp, th, env, Q, gsu2):
    """log p(U_i, V_j) on the quadrature grid for the pair (c, c'), all other links from env"""
    n = len(Q)
    lp = np.zeros((n, n)); lu = np.zeros(n); lv = np.zeros(n)
    Qc = conjq(Q)
    seen = set()
    for (fi, ls) in loops_through(c) + loops_through(cp):
        key = (fi, tuple(sorted((l[0], l[1]) for l in ls)))
        if key in seen: continue
        seen.add(key)
        pos_c = [i for i, l in enumerate(ls) if (l[0], l[1]) == c]
        pos_p = [i for i, l in enumerate(ls) if (l[0], l[1]) == cp]
        m = len(ls)
        def prod(i0, i1):          # ordered product of links i0 .. i1-1 (cyclic indices), from the environment
            P = np.array([1.0, 0, 0, 0])
            for k in range(i0, i1):
                l = ls[k % m]; q = env.link(l[0], l[1]); P = qmul(P, q if l[2] > 0 else conjq(q))
            return P
        if pos_c and pos_p:
            a, b = pos_c[0], pos_p[0]
            sa, sb = ls[a][2], ls[b][2]
            if b < a: b += m
            X = prod(a + 1, b); Y = prod(b + 1, a + m)
            Vs = Q if sb > 0 else Qc
            Z = qmul(qmul(np.broadcast_to(X, Vs.shape), Vs), np.broadcast_to(Y, Vs.shape))     # X V^sb Y for every V
            Us = Q if sa > 0 else Qc
            x = Us @ conjq(Z).T                     # Re(U^sa Z) = <u^sa, conj Z>
            tgt = lp
        elif pos_c:
            a = pos_c[0]; sa = ls[a][2]; W = prod(a + 1, a + m)
            Us = Q if sa > 0 else Qc
            x = Us @ conjq(W); tgt = lu
        else:
            b = pos_p[0]; sb = ls[b][2]; W = prod(b + 1, b + m)
            Vs = Q if sb > 0 else Qc
            x = Vs @ conjq(W); tgt = lv
        for rep in range(3):
            t = th[fi, rep]
            if t != 0.0:
                tgt += t * gfun(gsu2, rep, x)
    return lp + lu[:, None] + lv[None, :]

def main():
    fj = json.load(open(sys.argv[1])); n = sys.argv[2]; model = sys.argv[3]; envs = sys.argv[4:]
    gsu2 = fj['G'] == 'su2'; NC = fj['N'] // int(n)
    Q, W = s3_rule(8) if gsu2 else u1_rule(256)
    th, jk = coupling_by_family(fj['blocks'][n], model)
    c = ((2, 2, 2, 2), 0)
    print('ROWLOW %s n=%s model=%s G=%s coarse %d^4; link c = %s' % (fj['prefix'], n, model, fj['G'], NC, c))
    best = None
    for spec in envs:
        env = Env(spec, NC, gsu2)
        tot = 0.0; per = []
        for cl in NEIGH:
            vals = []
            for (x, d) in cl['links']:
                cp = (tuple(a + b for a, b in zip(c[0], x)), d)
                lp = pair_logp(c, cp, th, env, Q, gsu2)
                vals.append(maxcorr(lp, W, W)[1])
            per.append(vals); tot += sum(vals)
        print('  env %-40s row = %.6f   per class (mean x n): %s' % (spec, tot, '  '.join('%.5f x %d' % (np.mean(v), len(v)) for v in per)))
        if best is None: best = [list(v) for v in per]
        else: best = [[max(a, b) for a, b in zip(bv, v)] for bv, v in zip(best, per)]
    print('  pair-by-pair max over the environments read: row >= %.6f' % sum(sum(v) for v in best))

if __name__ == '__main__':
    main()
