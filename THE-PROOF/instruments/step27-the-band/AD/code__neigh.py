"""neigh.py -- AD: the neighbour structure of the fitted loop family.  For the link c = (0, mu = 0): every other link c' that shares at least
one loop with c, the list of shared loops (family index), grouped into classes by the multiset of shared families.  The row of a fitted
action is a sum over these c'.  Also the sup-distance of c' from c (link midpoints, coarse units) for the e^{kappa |y - y'|} weights.
usage: python neigh.py  -> neigh.json"""
import json, itertools, os
from collections import defaultdict, Counter
here = os.path.dirname(os.path.abspath(__file__))
L = json.load(open(os.path.join(here, 'loops.json')))
fams = ['plaquette', 'rectangle', 'chair', 'parallelogram']
loops = [(fi, tuple(st), [tuple(s) for s in steps]) for fi, f in enumerate(fams) for st, steps in L[f]]

def links_of(st, steps, base):
    x = [a + b for a, b in zip(base, st)]; out = []
    for d, s in steps:
        if s > 0: out.append((tuple(x), d)); x[d] += 1
        else: x[d] -= 1; out.append((tuple(x), d))
    return out

c = ((0, 0, 0, 0), 0)
shared = defaultdict(list)
W = range(-3, 4)
for b in itertools.product(W, repeat=4):
    for li, (fi, st, steps) in enumerate(loops):
        ls = links_of(st, steps, b)
        if c in ls:
            for l in ls:
                if l != c: shared[l].append(fi)
def mid(l):
    x, d = l; m = [float(v) for v in x]; m[d] += 0.5; return m
def dist(l):
    m1, m2 = mid(c), mid(l); return max(abs(a - b) for a, b in zip(m1, m2))
classes = defaultdict(list)
for l, fl in shared.items():
    key = tuple(sorted(Counter(fl).items()))
    classes[key].append(l)
tot = 0
out = []
for key, ls in sorted(classes.items(), key=lambda kv: (-len(kv[1]), kv[0])):
    ds = sorted(set(dist(l) for l in ls))
    print('class %-45s  links %3d  sup-distances %s' % (' + '.join('%d x %s' % (m, fams[f]) for f, m in key), len(ls), ds))
    out.append({'shared': [[f, m] for f, m in key], 'n': len(ls), 'dist': [dist(l) for l in ls], 'links': [[list(l[0]), l[1]] for l in ls]})
    tot += len(ls)
print('neighbours of one link: %d; loop incidences through it: %d' % (tot, sum(len(v) for v in shared.values())))
json.dump(out, open(os.path.join(here, 'neigh.json'), 'w'))
