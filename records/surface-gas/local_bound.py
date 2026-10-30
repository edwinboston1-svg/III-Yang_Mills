# local_bound.py -- THE FALSIFIER of the local theorem (S1 section 24) over iii-ac's census: reads G50-LOCAL lines
#   G50-LOCAL F=11 |Y|=1 rho=4/1 rest(chi=2,comp=1,bf=1) vertices=4: (0,0,-1,0)Y[+1+3]S[+1-2,-2+3,+1+2,+2+3]L[+1:2/1,+2:2/0,-2:2/0,+3:2/1] ...
# and prints, per chamber, the exact N = rho / 2^chi(rest) beside the local bound prod_v r_v, with r_v^2 = 2^(m-2)
# S(C_m(1/2)(R_v) u Gamma_v) at a sheet vertex (R_v the rest links Y uses at v in the SHEET'S cyclic order, read off the
# S-pairs; m = 1 reads S(Gamma_v)) and S(Gamma_v) off the sheet.  VIOLATION is printed when N^2 > bound^2 (beyond 1e-12).
# Every star integral is exact; values are cached by the configuration's canonical form under the hyperoctahedral group.
# Usage: python local_bound.py <file> [maxlines]   (ENGINE=design|mixed as in local_sweep.py)
import sys, os, re, math
from fractions import Fraction
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import local_sweep as ls
H = Fraction(1, 2)
def dindex(tok):
    s, d = tok[0], int(tok[1:]); return 2 * (d - 1) + (0 if s == '+' else 1)
PAIR = re.compile(r'([+-]\d)([+-]\d)')
VERT = re.compile(r'\(([-\d,]+)\)Y\[([^\]]*)\]S\[([^\]]*)\]L\[([^\]]*)\]')
CACHE = {}
def star_ratio(Gamma, R_order, O):
    key = ls.canon(tuple(Gamma), tuple(R_order), tuple(O))
    if key in CACHE: return CACHE[key]
    try:
        S, r2 = ls.ratio(list(Gamma), tuple(R_order), list(O))
    except MemoryError as e:
        CACHE[key] = (None, None); return CACHE[key]
    CACHE[key] = (S, r2); return CACHE[key]
def sheet_order(Spairs, R):
    adj = {}
    for (a, b) in Spairs: adj.setdefault(a, []).append(b); adj.setdefault(b, []).append(a)
    if not Spairs: return tuple(sorted(R))
    start = next(iter(adj)); order = [start]; prev = None; cur = start
    while True:
        nxt = [x for x in adj[cur] if x != prev] or adj[cur]
        nxt = nxt[0]
        if nxt == start: break
        order.append(nxt); prev, cur = cur, nxt
        if len(order) > 16: raise ValueError("sheet star is not a single cycle: %s" % Spairs)
    return tuple(x for x in order if x in R)
def bound_line(line):
    head = re.match(r'G50-LOCAL F=(\d+) \|Y\|=(\d+) rho=(-?\d+)/(\d+) rest\(chi=(-?\d+),comp=(\d+),bf=(\d+)', line)
    if not head: return None
    F, k, rn, rd, chi, comp, bf = (int(head.group(i)) for i in range(1, 8))
    if bf != 1:
        # the theorem's sheet is a closed BRANCH-FREE surface (its vertex stars cycles, its weight the cycle law);
        # a rest with a contact link (four sheet plaquettes on one link) is S6/S12's object and is out of this reader's scope
        return ('SKIP-BRANCHED', F, k, chi, comp, bf)
    N = Fraction(rn, rd) / Fraction(2) ** chi
    factors = []; refused = False
    for v in VERT.finditer(line):
        Ypairs = [(dindex(a), dindex(b)) for (a, b) in PAIR.findall(v.group(2))]
        Spairs = [(dindex(a), dindex(b)) for (a, b) in PAIR.findall(v.group(3))]
        links = {}
        for tok in v.group(4).split(','):
            tok = tok.strip()
            if not tok: continue
            d, ms, my = re.match(r'([+-]\d):(\d+)/(\d+)', tok).groups(); links[dindex(d)] = (int(ms), int(my))
        if not Ypairs: continue
        Gamma = [tuple(sorted(p)) for p in Ypairs]
        Yv = {x for p in Gamma for x in p}
        R = [d for d in Yv if links[d][0] > 0]; O = [d for d in Yv if links[d][0] == 0]
        order = sheet_order(Spairs, set(R)) if R else ()
        S, r2 = star_ratio(Gamma, order, O)
        if r2 is None: refused = True; factors.append((v.group(1), None)); continue
        factors.append((v.group(1), r2))
    b2 = Fraction(1)
    for (_, r2) in factors:
        if r2 is not None: b2 *= r2
    ok = refused or (N * N) <= b2 * (1 + Fraction(1, 10**12))
    return F, k, N, b2, factors, ok, refused
if __name__ == "__main__":
    fn = sys.argv[1]; maxl = int(sys.argv[2]) if len(sys.argv) > 2 else 10**9
    n = 0; viol = 0; worst = 0.0; nref = 0
    with open(fn) as f:
        for line in f:
            if not line.startswith("G50-LOCAL"): continue
            res = bound_line(line.strip())
            if res is None: continue
            if res[0] == 'SKIP-BRANCHED':
                nskip = globals().get('nskip', 0) + 1; globals()['nskip'] = nskip
                print("SKIP-BRANCHED F=%d |Y|=%d chi=%d comp=%d bf=%d" % res[1:]); continue
            F, k, N, b2, factors, ok, refused = res; n += 1
            if refused: nref += 1
            ratio = float(N * N / b2) if b2 > 0 else float('inf')
            if not refused: worst = max(worst, ratio)
            if not ok: viol += 1
            print("%s F=%d |Y|=%d N=%s bound^2=%s N^2/bound^2=%.6f %s" % ("VIOLATION" if not ok else ("REFUSED" if refused else "ok"), F, k, N, b2, ratio, " ".join("%s:r2=%s" % (c, r) for c, r in factors)), flush=True)
            if n >= maxl: break
    print("SUMMARY chambers=%d violations=%d refused=%d skipped_branched=%d worst N^2/bound^2=%.6f cached_configurations=%d" % (n, viol, nref, globals().get("nskip", 0), worst, len(CACHE)))
