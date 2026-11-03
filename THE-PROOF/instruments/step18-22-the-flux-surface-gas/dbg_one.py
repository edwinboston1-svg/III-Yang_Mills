import sys, os; sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import local_bound as lb, local_sweep as ls
line = open("viol1.txt").read().strip()
for v in lb.VERT.finditer(line):
    Ypairs = [(lb.dindex(a), lb.dindex(b)) for (a, b) in lb.PAIR.findall(v.group(2))]
    Spairs = [(lb.dindex(a), lb.dindex(b)) for (a, b) in lb.PAIR.findall(v.group(3))]
    links = {}
    for tok in v.group(4).split(','):
        d, ms, my = lb.re.match(r'([+-]\d):(\d+)/(\d+)', tok.strip()).groups(); links[lb.dindex(d)] = (int(ms), int(my))
    if not Ypairs: continue
    Gamma = [tuple(sorted(p)) for p in Ypairs]; Yv = {x for p in Gamma for x in p}
    R = [d for d in Yv if links[d][0] > 0]; O = [d for d in Yv if links[d][0] == 0]
    order = lb.sheet_order(Spairs, set(R)) if R else ()
    S, r2 = ls.ratio(list(Gamma), tuple(order), list(O))
    print(v.group(1), "Y", v.group(2), "S", v.group(3), "L", v.group(4), "-> R", R, "O", O, "order", order, "S=", S, "r2=", r2)
