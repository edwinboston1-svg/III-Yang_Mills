"""sap.py -- AD: self-avoiding polygons through one link of Z^4, by length (4, 6, 8): the multiplicity behind the row's extended-loop share.
A polygon through the link (0 -> e_0) is counted once as a closed self-avoiding walk whose first step is +e_0.  Prints the count per length and,
for length 8, the shape classes (orbits of the polygon's link set under the hypercubic group fixing nothing -- shapes by sorted extent).
usage: python sap.py"""
import itertools
from collections import Counter
STEPS = [tuple((1 if j == i else 0) * s for j in range(4)) for i in range(4) for s in (1, -1)]

def closed_walks(L):
    out = []
    start = (0, 0, 0, 0); first = (1, 0, 0, 0)
    path = [start, first]; vis = {start, first}
    def rec():
        cur = path[-1]
        if len(path) == L:
            if sum(abs(a - b) for a, b in zip(cur, start)) == 1: out.append(list(path))
            return
        for s in STEPS:
            nx = tuple(a + b for a, b in zip(cur, s))
            if nx in vis: continue
            # prune: must be able to return within the remaining steps
            rem = L - len(path)
            if sum(abs(c) for c in nx) > rem: continue
            vis.add(nx); path.append(nx); rec(); path.pop(); vis.discard(nx)
    rec()
    return out

if __name__ == "__main__":
  for L in (4, 6, 8):
    ws = closed_walks(L)
    shapes = Counter()
    for w in ws:
        ext = tuple(sorted(max(p[i] for p in w) - min(p[i] for p in w) for i in range(4)))
        shapes[ext] += 1
    print('length %d: polygons through one link = %d; by sorted extent %s' % (L, len(ws), dict(shapes)))
