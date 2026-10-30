# local_enum.py -- THE ENUMERATOR of admissible local configurations (S1 section 24), without any star integral:
# for each k in [KMIN, KMAX], every k-edge subgraph Gamma of K_{2,2,2,2} up to the hyperoctahedral group (orbit
# representatives by the minimal encoding), every rest/off-sheet assignment of its vertices (degree-one vertices rest,
# off-sheet degree >= 2), every cyclic order of the rest links realisable by a sheet cycle in K_{2,2,2,2} (arcs through
# distinct intermediates, avoiding Gamma's rest-rest edges and the off-sheet directions, length >= 3), emitted ONCE per
# canonical configuration as one line in the star engines' format:
#   CONF k=<k> m=<m> o=<|O|> id=<n> edges: a-b:2 a-b:2 ... r-r':1 r-r':1 ...   (2 = spin 1 (2j), 1 = spin 1/2)
# with the reduced sheet cycle on the rest links at spin 1/2 (a loop for m = 1 is omitted: r^2 = S(Gamma) there; for m = 2
# the doubled 1/2 edge), followed by  ratio: r2 = 2^(m-2) * S  (the factor the reader applies).  Directions 0..7 = +1 -1 +2 -2 +3 -3 +4 -4.
import itertools, sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import local_sweep as ls
def edge_canon(Gamma):
    best = None
    for g in ls.GROUP:
        E = tuple(sorted(tuple(sorted((g[i], g[j]))) for (i, j) in Gamma))
        if best is None or E < best: best = E
    return best
def enumerate_k(k, out, start_id=0):
    n = start_id; seen = set(); reps = 0
    for Gamma in itertools.combinations(ls.KEDGES, k):
        if edge_canon(Gamma) != tuple(sorted(Gamma)): continue
        reps += 1
        V = sorted({v for e in Gamma for v in e})
        deg = {v: 0 for v in V}
        for (i, j) in Gamma: deg[i] += 1; deg[j] += 1
        free = [v for v in V if deg[v] >= 2]; forced = [v for v in V if deg[v] == 1]
        for pick in itertools.product((0, 1), repeat=len(free)):
            R = set(forced) | {v for v, p in zip(free, pick) if p}; O = set(V) - R
            if any(deg[o] < 2 for o in O): continue
            if not R:
                key = ls.canon(Gamma, (), tuple(sorted(O)))
                if key in seen: continue
                seen.add(key); n += 1
                out.write("CONF k=%d m=0 o=%d id=%d edges: %s ratio: r2 = S\n" % (k, len(O), n, " ".join("%d-%d:2" % e for e in Gamma)))
                continue
            Rl = sorted(R)
            orders = [tuple(Rl)] if len(Rl) <= 2 else [tuple([Rl[0]] + list(p)) for p in itertools.permutations(Rl[1:])]
            for order in orders:
                key = ls.canon(Gamma, order, tuple(sorted(O)))
                if key in seen: continue
                seen.add(key)
                if not ls.sheet_cycle_exists(order, O, Gamma): continue
                n += 1; m = len(order)
                sheet = []
                if m == 2: sheet = ["%d-%d:1" % (order[0], order[1])] * 2
                elif m >= 3: sheet = ["%d-%d:1" % (order[i], order[(i + 1) % m]) for i in range(m)]
                out.write("CONF k=%d m=%d o=%d id=%d edges: %s %s ratio: r2 = 2^%d * S\n" % (k, m, len(O), n, " ".join("%d-%d:2" % e for e in Gamma), " ".join(sheet), max(m - 2, 0) if m >= 2 else 0))
    return n, reps
if __name__ == "__main__":
    KMIN = int(os.environ.get("KMIN", "1")); KMAX = int(os.environ.get("KMAX", "6")); fn = os.environ.get("OUT", "local_enum.txt")
    with open(fn, "w") as out:
        n = 0
        for k in range(KMIN, KMAX + 1):
            n0 = n; n, reps = enumerate_k(k, out, n)
            out.write("== k=%d: %d edge-orbit representatives, %d admissible configurations (cumulative %d)\n" % (k, reps, n - n0, n)); out.flush()
            print("k=%d: reps=%d confs=%d" % (k, reps, n - n0), flush=True)
