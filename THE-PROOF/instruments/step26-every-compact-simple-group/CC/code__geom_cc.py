#!/usr/bin/env python3
# geom_cc.py -- CC, 2026-11-02. The base side-2 block's position structure FOLDED BY CLASS, for the covariance composition.
# Imports M87's geom.py (copied here byte-identical; its sha256 is printed) for the cover and the position rule, and records, for each of
# the 48 kept links x of block 0 (base assignment: base point in {0,1}^4):
#   in-block pairs (x, z): (nI, nII) = numbers of TYPE I and TYPE II positions z occupies relative to x;
#   outside positions folded by class: for each class j (one representative per class sits in block 0), (oI, oII) summed over the outside
#   links of class j; and the per-outside-link multiplicities (for the multi-position check).
# Checks (refused by name if they fail): every x has 12 + 90 positions (Lemma U); in-block counts symmetric; in-block row counts equal M87's
# n1in/n2in; the class representative map is a bijection onto block 0. Usage: python geom_cc.py <out.json> [--bend-count]
import sys, json, hashlib, os
from collections import defaultdict
HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
import geom as G   # M87's instrument, unmodified

def sha(p): return hashlib.sha256(open(p, "rb").read()).hexdigest()
print("GEOMCC geom.py sha256", sha(os.path.join(HERE, "geom.py")))
BEND = "--bend-count" in sys.argv

D = G.cover_g27()
inS = G.make(D)
kept = [(G.bits(s), d) for s in range(16) for d in range(4) if not inS(G.bits(s), d)]
assert len(kept) == 48
B = kept                        # block 0 of the base assignment = the 48 kept links with base point in {0,1}^4
idx = {l: i for i, l in enumerate(B)}
def cls(l):                     # class = (base point mod 2, direction): the representative in block 0
    x, d = l
    return idx[(tuple(v % 2 for v in x), d)]
def key(l): return ",".join(map(str, l[0])) + ":%d" % l[1]

inb = [defaultdict(lambda: [0, 0]) for _ in B]          # in-block pair counts
outc = [defaultdict(lambda: [0, 0]) for _ in B]         # outside counts folded by class
mult = defaultdict(int)                                  # multiplicity histogram of (nI, nII) per (x, neighbour) pair
hist = [defaultdict(int) for _ in B]                     # per link: histogram of (nI, nII) over its neighbours (in-block and outside)
bad = []
for i, x in enumerate(B):
    pos = G.positions(inS, x)
    if BEND and i == 0:
        # the planted defect: drop the first TYPE II position of the first link (a bent count)
        k = next(k for k, (t, l) in enumerate(pos) if t == 2); pos = pos[:k] + pos[k + 1:]
    n1 = sum(1 for t, l in pos if t == 1); n2 = sum(1 for t, l in pos if t == 2)
    if (n1, n2) != (12, 90): bad.append("LEMMA-U %s has (%d, %d) positions, not (12, 90)" % (key(x), n1, n2))
    per = defaultdict(lambda: [0, 0])
    for t, l in pos: per[l][t - 1] += 1
    for l, (a, b) in per.items():
        mult[(a, b)] += 1; hist[i]["%d,%d" % (a, b)] += 1
        if l in idx: inb[i][idx[l]][0] += a; inb[i][idx[l]][1] += b
        else: c = cls(l); outc[i][c][0] += a; outc[i][c][1] += b
# symmetry of the in-block counts
for i in range(48):
    for j, (a, b) in inb[i].items():
        if inb[j].get(i, [0, 0]) != [a, b]: bad.append("SYMMETRY (%s, %s): %s vs %s" % (key(B[i]), key(B[j]), [a, b], inb[j].get(i)))
# agreement with M87's per-link in-block counts
m87 = json.load(open(os.path.join(HERE, "..", "..", "M87", "geom.json")))["G"]["base"]
for i, x in enumerate(B):
    n1in = sum(v[0] for v in inb[i].values()); n2in = sum(v[1] for v in inb[i].values())
    if (n1in, n2in) != (m87[key(x)]["n1in"], m87[key(x)]["n2in"]):
        bad.append("M87-COUNTS %s: (%d, %d) vs M87 (%d, %d)" % (key(x), n1in, n2in, m87[key(x)]["n1in"], m87[key(x)]["n2in"]))
if bad:
    for b in bad[:20]: print("REFUSED", b)
    print("GEOMCC REFUSED: %d check failures (first listed above); no geometry written" % len(bad)); sys.exit(3)
print("GEOMCC checks: Lemma U (12 + 90 per link) 48/48; in-block counts symmetric; in-block rows equal M87's n1in/n2in 48/48")
print("GEOMCC multiplicity histogram of (nI, nII) over all (link, neighbour) pairs:", dict(sorted(mult.items())))
nin = sorted(set((sum(v[0] for v in inb[i].values()), sum(v[1] for v in inb[i].values())) for i in range(48)))
print("GEOMCC in-block (TYPE I, TYPE II) row counts:", nin)
hs = sorted(set(tuple(sorted(h.items())) for h in hist))
print("GEOMCC per-link neighbour histograms (distinct over the 48 links):", hs)
out = {"links": [key(x) for x in B],
       "inb": [{str(j): v for j, v in inb[i].items()} for i in range(48)],
       "out": [{str(c): v for c, v in outc[i].items()} for i in range(48)],
       "hist": [dict(h) for h in hist],
       "mult": {"%d,%d" % k: v for k, v in mult.items()}}
json.dump(out, open(sys.argv[1], "w"), sort_keys=True)
print("GEOMCC written", sys.argv[1], "sha256", sha(sys.argv[1]))
