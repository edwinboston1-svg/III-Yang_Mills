# wall_sweep.py -- THE WALL TABLE (S1 section 24): every wall-only local configuration -- a sheet cycle C in K_{2,2,2,2}
# (length 3..8) and a set Gamma of chords (non-antipodal pairs of C's vertices that are not edges of C), every chord a
# lone wall at v -- up to the hyperoctahedral symmetry, with r_v^2 = 2^(m-2) S(reduced cycle on V(Gamma) at 1/2 u Gamma)
# read EXACTLY on the projector road where the memory cap allows and otherwise bounded by the operator-form cut
# (cut_star), the per-corner rate (r^2)^(1/2k) and its maximum per k; a cut-bounded row is marked CUT and its value is an
# upper bound.  CYCLES=all (default) or a comma list of cycle lengths; KMAX caps the chord count.
import sys, os, itertools, math
from fractions import Fraction
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
os.environ.setdefault("MIXED_NOKAT", "1")
import local_sweep as ls, mixed_star as ms, cut_star as cs
H = Fraction(1, 2)
DIRS = ls.DIRS; ANTI = ls.ANTI
def cycles_up_to_symmetry():
    """simple cycles of K_{2,2,2,2} of length 3..8 as vertex tuples, one per orbit under the group (and rotation/reflection)"""
    reps = {}
    adj = lambda a, b: a != b and b != ANTI(a)
    for d in range(3, 9):
        for verts in itertools.permutations(DIRS, d):
            if verts[0] != min(verts): continue              # fix the rotation
            if all(adj(verts[i], verts[(i + 1) % d]) for i in range(d)):
                key = ls.canon((), verts, ())                   # canonical under group x dihedral
                if key not in reps: reps[key] = verts
    return sorted(reps.values(), key=len)
def cycle_stabilizer(C):
    """the group elements mapping the cycle C onto itself as a set of edges (rotations and reflections included)"""
    d = len(C); E = {tuple(sorted((C[i], C[(i + 1) % d]))) for i in range(d)}
    return [g for g in ls.GROUP if {tuple(sorted((g[a], g[b]))) for (a, b) in E} == E]
def wall_configs(C, KMAX):
    d = len(C); pos = {v: i for i, v in enumerate(C)}
    chords = [(a, b) for a in C for b in C if pos[a] < pos[b] and b != ANTI(a) and (pos[b] - pos[a]) % d not in (1, d - 1)]
    stab = cycle_stabilizer(C)
    seen = set()
    for k in range(1, min(KMAX, len(chords)) + 1):
        for Gamma in itertools.combinations(chords, k):
            # canonical under the cycle's own stabilizer (a chord set's image under g is a chord set of the same cycle)
            key = min(tuple(sorted(tuple(sorted((g[a], g[b]))) for (a, b) in Gamma)) for g in stab)
            if key in seen: continue
            seen.add(key)
            R = sorted({v for e in Gamma for v in e}, key=lambda v: pos[v])
            yield k, Gamma, tuple(R)
def evaluate(Gamma, order):
    m = len(order)
    edges = [(i, j, Fraction(1)) for (i, j) in Gamma]
    if m == 2: edges += [(order[0], order[1], H), (order[0], order[1], H)]
    elif m >= 3: edges += [(order[i], order[(i + 1) % m], H) for i in range(m)]
    try:
        S = ms.star(edges, quiet=True); return S * Fraction(2) ** (m - 2), "EXACT", None
    except MemoryError:
        b = cs.cut_bound(edges)
        if b is None: return None, "REFUSED", None
        return float(b[0]) * 2.0 ** (m - 2), "CUT", b[1]
if __name__ == "__main__":
    KMAX = int(os.environ.get("KMAX", "16")); out = os.environ.get("OUT", "wall_sweep.txt")
    which = os.environ.get("CYCLES", "all")
    cyc = cycles_up_to_symmetry()
    if which != "all": cyc = [C for C in cyc if len(C) in {int(x) for x in which.split(",")}]
    best = {}
    with open(out, "w") as f:
        f.write("WALL SWEEP: %d sheet cycles up to symmetry: %s\n" % (len(cyc), [len(C) for C in cyc]))
        for C in cyc:
            f.write("== cycle %s (length %d)\n" % (list(C), len(C))); f.flush()
            n = 0
            for k, Gamma, order in wall_configs(C, KMAX):
                r2, how, split = evaluate(Gamma, order); n += 1
                if r2 is None: f.write("ROW d=%d k=%d m=%d REFUSED Gamma=%s\n" % (len(C), k, len(order), list(Gamma))); continue
                rate = float(r2) ** (1.0 / (2 * k))
                f.write("ROW d=%d k=%d m=%d %s r2=%s rate=%.6f Gamma=%s R=%s%s\n" % (len(C), k, len(order), how, r2, rate, list(Gamma), list(order), (" split=%s" % (split,)) if split else ""))
                if k not in best or rate > best[k][0]: best[k] = (rate, how, len(C), Gamma, r2)
                if n % 50 == 0: f.flush()
            f.write("== cycle %s done: %d configurations\n" % (list(C), n)); f.flush()
            print("cycle", list(C), "configurations", n, flush=True)
        f.write("== THETA_WALL(k): max per-corner rate over wall configurations (CUT rows are upper bounds)\n")
        for k in sorted(best):
            rate, how, d, Gamma, r2 = best[k]
            f.write("THETA k=%d rate=%.6f %s d=%d r2=%s Gamma=%s\n" % (k, rate, how, d, r2, list(Gamma)))
    print("done", flush=True)
