# local_sweep.py -- THE LOCAL SWEEP (S1 section 24): every admissible local configuration of a piece at one lattice
# vertex with k Y-plaquettes there, k <= KMAX, up to the hyperoctahedral symmetry of the eight directions, with its
# star ratio r_v^2 and per-corner rate r_v^(1/k).  Sheet vertex: R = the rest links Y uses (a subset of the sheet's
# links), in the sheet's cyclic order; Gamma = Y's spin-1 star on R u O; r^2 = 2^(m-2) S(C_m(1/2)(R) u Gamma), m = |R|
# (m = 1: r^2 = S(Gamma)).  Off-sheet vertex: Gamma on O with every degree >= 2; r^2 = S(Gamma).
# Admissibility: Gamma a simple subgraph of K_{2,2,2,2} (no antipodal pair spans a plaquette); off-S links have
# Gamma-degree >= 2 (closedness), rest links >= 1; a sheet cycle through R in the given order exists in K_{2,2,2,2}
# avoiding Gamma's rest-rest edges and the off-S directions, simple, of length >= 3.
# ENGINE=design (default; the 2I design, degrees <= 11) or ENGINE=mixed (the projector road, any degree, memory-capped).
import itertools, sys, os, math
from fractions import Fraction
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
ENGINE = os.environ.get("ENGINE", "design")
if ENGINE == "mixed":
    os.environ["MIXED_NOKAT"] = os.environ.get("MIXED_NOKAT", "1"); import mixed_star as eng
else:
    import design_star as eng
H = Fraction(1, 2)
DIRS = list(range(8)); ANTI = lambda i: i ^ 1
KEDGES = [(i, j) for i in DIRS for j in DIRS if i < j and j != ANTI(i)]
assert len(KEDGES) == 24
def group():
    G = []
    for perm in itertools.permutations(range(4)):
        for signs in itertools.product((0, 1), repeat=4):
            m = {}
            for a in range(4):
                for s in (0, 1):
                    m[2*a + s] = 2*perm[a] + (s ^ signs[a])
            G.append(m)
    return G
GROUP = group(); assert len(GROUP) == 384
def canon(Gamma, R_order, O):
    best = None
    m = len(R_order)
    rots = []
    if m >= 3:
        for s in range(m):
            rots.append(R_order[s:] + R_order[:s]); rots.append(tuple(reversed(R_order[s:] + R_order[:s])))
    else:
        rots = [R_order]
    for g in GROUP:
        E = tuple(sorted(tuple(sorted((g[i], g[j]))) for (i, j) in Gamma))
        Og = tuple(sorted(g[o] for o in O))
        for ro in rots:
            key = (E, tuple(g[r] for r in ro), Og)
            if best is None or key < best: best = key
    return best
def sheet_cycle_exists(R_order, O, Gamma):
    R = set(R_order); A = [d for d in DIRS if d not in R and d not in O]
    forb = {tuple(sorted(e)) for e in Gamma if e[0] in R and e[1] in R}
    m = len(R_order)
    adj = lambda a, b: a != b and b != ANTI(a)
    def search(i, used, length):
        if i == m:
            return length >= 3
        a = R_order[i]; b = R_order[(i + 1) % m]
        if m >= 2 and adj(a, b) and tuple(sorted((a, b))) not in forb:
            if search(i + 1, used, length + 1): return True
        def walk(cur, usedl, ln):
            for x in A:
                if x in usedl or not adj(cur, x): continue
                if adj(x, b) and (x != b):
                    if search(i + 1, usedl | {x}, ln + 2): return True
                if walk(x, usedl | {x}, ln + 1): return True
            return False
        return walk(a, used, length)
    return search(0, frozenset(), 0)
def ratio(Gamma, R_order, O):
    m = len(R_order)
    edges = [(i, j, Fraction(1)) for (i, j) in Gamma]
    if m == 0 or m == 1:
        S = eng.star(edges, quiet=True); return S, S
    if m == 2:
        edges += [(R_order[0], R_order[1], H), (R_order[0], R_order[1], H)]
    else:
        edges += [(R_order[i], R_order[(i + 1) % m], H) for i in range(m)]
    S = eng.star(edges, quiet=True)
    return S, S * Fraction(2) ** (m - 2)
def degrees_ok(Gamma, R, O):
    deg = {}
    for (i, j) in Gamma:
        deg[i] = deg.get(i, 0) + 1; deg[j] = deg.get(j, 0) + 1
    for o in O:
        if deg.get(o, 0) < 2: return False
    for r in R:
        if deg.get(r, 0) < 1: return False
    if ENGINE == "design":
        for r in R:
            if deg[r] > 4: return None
        for o in O:
            if deg[o] > 5: return None
    return True
def sweep(KMAX, out, KMIN=1):
    seen = {}
    rows = []
    for k in range(KMIN, KMAX + 1):
        best = {}
        for Gamma in itertools.combinations(KEDGES, k):
            V = sorted({v for e in Gamma for v in e})
            deg = {v: 0 for v in V}
            for (i, j) in Gamma: deg[i] += 1; deg[j] += 1
            free = [v for v in V if deg[v] >= 2]
            forced = [v for v in V if deg[v] == 1]
            for pick in itertools.product((0, 1), repeat=len(free)):
                R = set(forced) | {v for v, p in zip(free, pick) if p}
                O = set(V) - R
                ok = degrees_ok(Gamma, R, O)
                if ok is False: continue
                if not R:
                    key = canon(Gamma, (), O)
                    if key in seen: continue
                    if ok is None: seen[key] = ('OUT-OF-REACH', None); rows.append((k, 'off', Gamma, (), 'OUT-OF-REACH', None, None)); continue
                    try: S, r2 = ratio(Gamma, (), O)
                    except MemoryError as e: seen[key] = ('REFUSED', None); rows.append((k, 'off', Gamma, (), 'REFUSED %s' % e, None, None)); continue
                    seen[key] = (S, r2)
                    rate = float(r2) ** (1.0 / (2 * k)); rows.append((k, 'off', Gamma, (), S, r2, rate))
                    if 'off' not in best or rate > best['off'][0]: best['off'] = (rate, Gamma, (), S, r2)
                    continue
                Rl = sorted(R)
                orders = [tuple(Rl)] if len(Rl) <= 2 else [tuple([Rl[0]] + list(p)) for p in itertools.permutations(Rl[1:])]
                for order in orders:
                    key = canon(Gamma, order, O)
                    if key in seen: continue
                    if not sheet_cycle_exists(order, O, Gamma): seen[key] = ('NO-SHEET', None); continue
                    if ok is None: seen[key] = ('OUT-OF-REACH', None); rows.append((k, 'sheet', Gamma, order, 'OUT-OF-REACH', None, None)); continue
                    try: S, r2 = ratio(Gamma, order, O)
                    except MemoryError as e: seen[key] = ('REFUSED', None); rows.append((k, 'sheet', Gamma, order, 'REFUSED %s' % e, None, None)); continue
                    seen[key] = (S, r2)
                    rate = float(r2) ** (1.0 / (2 * k)); rows.append((k, 'sheet', Gamma, order, S, r2, rate))
                    tag = 'sheet-m%d' % len(order)
                    if tag not in best or rate > best[tag][0]: best[tag] = (rate, Gamma, order, S, r2)
        with open(out, 'a') as f:
            f.write("== k = %d : %d configurations read (cumulative seen %d) engine=%s\n" % (k, sum(1 for r in rows if r[0] == k), len(seen), ENGINE))
            for tag in sorted(best):
                rate, Gamma, order, S, r2 = best[tag]
                f.write("MAX k=%d %-9s rate=%.6f r2=%s S=%s Gamma=%s R=%s\n" % (k, tag, rate, r2, S, list(Gamma), list(order)))
            for (kk, kind, Gamma, order, S, r2, rate) in rows:
                if kk == k:
                    f.write("ROW k=%d %s Gamma=%s R=%s S=%s r2=%s rate=%s\n" % (k, kind, list(Gamma), list(order), S, r2, ("%.6f" % rate) if rate is not None else "-"))
            f.flush()
        print("k=%d done; maxima: %s" % (k, {t: round(b[0], 5) for t, b in best.items()}), flush=True)
if __name__ == "__main__":
    KMAX = int(os.environ.get("KMAX", "4")); KMIN = int(os.environ.get("KMIN", "1")); out = os.environ.get("OUT", "local_sweep.txt")
    if KMIN == 1: open(out, 'w').close()
    sweep(KMAX, out, KMIN)
