# two_roads_diff.py -- THE TWO-ROAD CHECK on the wall family: my projector-road rows (wall_sweep.2026-10-29b.txt, the
# n-th ROW is WCONF id n: same generator, same order) against the Yang-Mills seat's intertwiner-engine record
# (wall_stars_exact.2026-10-29a.txt: STAR-EXACT-FILE id=n ... r2=p/q ...).  Prints the overlap count, the agreements,
# and every disagreement with both values.  CUT rows on my side are bounds and are compared as bounds (theirs <= mine).
import sys, re
from fractions import Fraction
mine = {}
for i, line in enumerate(l for l in open(sys.argv[1]) if l.startswith("ROW ")):
    m = re.search(r" (EXACT|CUT) r2=(\S+) ", line)
    if m: mine[i + 1] = (m.group(1), m.group(2))
theirs = {}
for line in open(sys.argv[2]):
    m = re.match(r"STAR-EXACT-FILE id=(\d+) .*? r2=(\S+)", line)
    if m: theirs[int(m.group(1))] = m.group(2)
agree = 0; dis = []
for i in sorted(set(mine) & set(theirs)):
    how, r2m = mine[i]; r2t = theirs[i]
    if how == "EXACT":
        if Fraction(r2m) == Fraction(r2t): agree += 1
        else: dis.append((i, r2m, r2t))
    else:
        if Fraction(r2t) <= Fraction(float(r2m)) * (1 + Fraction(1, 10**9)): agree += 1
        else: dis.append((i, "CUT " + r2m, r2t))
print("overlap %d, agree %d, disagree %d" % (len(set(mine) & set(theirs)), agree, len(dis)))
for d in dis[:20]: print("DISAGREE id=%d mine=%s theirs=%s" % d)
