# deferred_cuts.py -- the cut bound on every row the Yang-Mills author's batch DEFERRED (its record's DEFERRED lines carry
# the id and the edge list in my labels); per row the least bound over the 35 balanced splits and the 8 singles, r2, the
# per-corner bound, and RETIRED / NEEDS-EXACT against theta_max = 1.113533.  Usage: python deferred_cuts.py <record>
import sys, os, re, itertools
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
os.environ["MIXED_NOKAT"] = "1"; os.environ.setdefault("MAXCELLS", "120000000")
import cut_star as cs
from fractions import Fraction as Fr
TH = 1.113533
for line in open(sys.argv[1]):
    if "DEFERRED" not in line: continue
    mid = re.search(r"id=(\d+)", line); mk = re.search(r"\bk=(\d+)", line); mm = re.search(r"\bm=(\d+)", line)
    edges = re.findall(r"(\d)-(\d):(\d)", line)
    if not (mid and mk and mm and edges): print("UNPARSED", line.strip()[:120]); continue
    i, k, m = int(mid.group(1)), int(mk.group(1)), int(mm.group(1))
    spec = [(int(u), int(v), Fr(int(s), 2)) for (u, v, s) in edges]
    verts = sorted({v for e in spec for v in e[:2]}); n = len(verts)
    splits = [c for c in itertools.combinations(verts, n // 2) if verts[0] in c] + [(v,) for v in verts]
    b = cs.cut_bound(spec, splits=splits)
    if b is None: print("DEFERRED id=%d k=%d m=%d: every split REFUSED" % (i, k, m), flush=True); continue
    r2 = b[0] * 2.0 ** max(m - 2, 0); rate = r2 ** (1.0 / (2 * k))
    print("DEFERRED-CUT id=%d k=%d m=%d S<=%.6f r2<=%.4f rate<=%.5f %s split=%s" % (i, k, m, b[0], r2, rate, "RETIRED" if rate <= TH else "NEEDS-EXACT", b[1]), flush=True)
