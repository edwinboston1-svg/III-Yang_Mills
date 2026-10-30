# local_table.py -- THE LOCAL TABLE: every distinct local configuration met in iii-ac's branch-free census (canonical
# under the hyperoctahedral group), with its star integral S, its ratio r_v^2, its per-corner rate, and how many
# chamber-vertices carry it.  Usage: python local_table.py <census file>
import sys, os, re
from fractions import Fraction
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import local_bound as lb, local_sweep as ls
counts = {}; example = {}
for line in open(sys.argv[1]):
    if not line.startswith("G50-LOCAL"): continue
    head = re.match(r'G50-LOCAL F=(\d+) \|Y\|=(\d+) rho=(-?\d+)/(\d+) rest\(chi=(-?\d+),comp=(\d+),bf=(\d+)', line)
    if not head or int(head.group(7)) != 1: continue
    for v in lb.VERT.finditer(line):
        Ypairs = [(lb.dindex(a), lb.dindex(b)) for (a, b) in lb.PAIR.findall(v.group(2))]
        Spairs = [(lb.dindex(a), lb.dindex(b)) for (a, b) in lb.PAIR.findall(v.group(3))]
        links = {}
        for tok in v.group(4).split(','):
            d, ms, my = re.match(r'([+-]\d):(\d+)/(\d+)', tok.strip()).groups(); links[lb.dindex(d)] = (int(ms), int(my))
        if not Ypairs: continue
        Gamma = [tuple(sorted(p)) for p in Ypairs]; Yv = {x for p in Gamma for x in p}
        R = [d for d in Yv if links[d][0] > 0]; O = [d for d in Yv if links[d][0] == 0]
        order = lb.sheet_order(Spairs, set(R)) if R else ()
        key = ls.canon(tuple(Gamma), tuple(order), tuple(O))
        counts[key] = counts.get(key, 0) + 1
        if key not in example: example[key] = (Gamma, order, O, v.group(2), v.group(3))
NAMES = {0:'+1',1:'-1',2:'+2',3:'-2',4:'+3',5:'-3',6:'+4',7:'-4'}
rows = []
for key, c in counts.items():
    Gamma, order, O, ytxt, stxt = example[key]
    S, r2 = ls.ratio(list(Gamma), tuple(order), list(O))
    k = len(Gamma); m = len(order)
    rate = float(r2) ** (1.0/(2*k)) if r2 > 0 else 0.0
    rows.append((k, m, len(O), c, S, r2, rate, ytxt, stxt, [NAMES[x] for x in order], [NAMES[x] for x in O]))
rows.sort()
print("LOCAL TABLE: %d distinct configurations over the branch-free census" % len(rows))
print("k m |O| vertices  S  r2  rate | Y pairs at v | sheet pairs at v | R in sheet order | O")
for (k, m, no, c, S, r2, rate, ytxt, stxt, Ro, Oo) in rows:
    print("%d %d %d %7d  S=%s r2=%s rate=%.5f | Y[%s] S[%s] | R=%s O=%s" % (k, m, no, c, S, r2, rate, ytxt, stxt, Ro, Oo))
