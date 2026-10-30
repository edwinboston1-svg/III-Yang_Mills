# seven_cuts.py -- the cut bound on the sixteen-chord vertex of each of the SEVEN Hamiltonian sheet-cycle classes (the
# Yang-Mills seat's hamcycles.graphs.txt; u-v:1 = spin 1/2, u-v:2 = spin 1), over every balanced 4|4 split (35) and the
# eight 1|7 splits; per class the least bound on S, r^2 <= 64 S, the per-corner bound (64 S)^(1/32), and whether the
# class needs an exact read (S bound > 0.4878, the K4-of-walls threshold 1.113533^32/64).
import sys, os, re, itertools, math
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
os.environ["MIXED_NOKAT"] = "1"; os.environ.setdefault("MAXCELLS", "120000000")
import cut_star as cs
from fractions import Fraction as Fr
for line in open(os.path.join(os.path.dirname(os.path.abspath(__file__)), "hamcycles.graphs.txt")):
    m = re.match(r"class (\d+): GRAPH=(.*)", line.strip())
    if not m: continue
    cls = int(m.group(1)); spec = []
    for tok in m.group(2).split(","):
        u, v, s = re.match(r"(\d)-(\d):(\d)", tok).groups(); spec.append((int(u), int(v), Fr(int(s), 2)))
    assert len(spec) == 24
    splits = [c for c in itertools.combinations(range(8), 4) if 0 in c] + [(v,) for v in range(8)]
    b = cs.cut_bound(spec, splits=splits)
    if b is None: print("class %d: every split REFUSED" % cls, flush=True); continue
    bound, split, S1, S2 = b
    print("class %d: S <= %.6f (split %s, halves %s %s) ; r2 <= %.4f ; per corner <= %.5f ; %s" % (cls, bound, split, S1, S2, 64*bound, (64*bound)**(1/32), "NEEDS EXACT (bound > 0.4878)" if bound > 0.4878 else "RETIRED (bound <= 0.4878: below the K4-of-walls rate)"), flush=True)
