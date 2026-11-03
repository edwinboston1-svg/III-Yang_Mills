import sys, os; sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import local_bound as lb, local_sweep as ls
from fractions import Fraction
line = open("census_local_snapshot.2026-10-29b.txt").read().split("\n")[97]
print(line[:80])
for v in lb.VERT.finditer(line):
    Ypairs = [(lb.dindex(a), lb.dindex(b)) for (a, b) in lb.PAIR.findall(v.group(2))]
    Spairs = [(lb.dindex(a), lb.dindex(b)) for (a, b) in lb.PAIR.findall(v.group(3))]
    links = {}
    for tok in v.group(4).split(','):
        d, ms, my = lb.re.match(r'([+-]\d):(\d+)/(\d+)', tok.strip()).groups(); links[lb.dindex(d)] = (int(ms), int(my))
    Gamma = [tuple(sorted(p)) for p in Ypairs]; Yv = {x for p in Gamma for x in p}
    R = [d for d in Yv if links[d][0] > 0]; O = [d for d in Yv if links[d][0] == 0]
    order = lb.sheet_order(Spairs, set(R)) if R else ()
    S, r2 = ls.ratio(list(Gamma), tuple(order), list(O))
    print(v.group(1), "Y", Ypairs, "S", Spairs, "R", R, "O", O, "order", order, "S=", S, "r2=", r2)
