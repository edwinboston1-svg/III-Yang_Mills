# cut_star.py -- THE OPERATOR-FORM CUT BOUND for a mixed-spin star (S1 section 22 J10, section 24): for a bipartition
# (V1, V2) of the vertices,  S(G) <= sqrt( S(H1+) * S(H2+) ),  H_i+ = G[V_i] and a copy of it, every cross edge (v, w)
# with v in V_i turned into a RUNG (v, v*) of the same spin -- Cauchy-Schwarz over the cut legs, the projectors on each
# side having norm one (Frobenius norm over the cut legs = the doubled half).  Spin-1/2 cross edges give spin-1/2 rungs
# (the Bell pairing of D^1/2 with its conjugate).  Exact on the projector road (mixed_star); the minimum over the
# bipartitions tried is returned with the split that gave it.  Every value is an upper bound on S(G), never S itself.
import sys, os, itertools, math
from fractions import Fraction
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
os.environ.setdefault("MIXED_NOKAT", "1")
import mixed_star as ms
H = Fraction(1, 2)
def doubled_half(spec, V1):
    V1 = set(V1); off = 1000
    edges = []
    for (i, j, s) in spec:
        a, b = (i in V1), (j in V1)
        if a and b:
            edges.append((i, j, s)); edges.append((i + off, j + off, s))
        elif a and not b:
            edges.append((i, i + off, s))
        elif b and not a:
            edges.append((j, j + off, s))
    return edges
def cut_bound(spec, splits=None, quiet=True):
    """returns (bound, split, S1, S2): bound = sqrt(S1*S2) as a Fraction-exact pair (S1, S2) and a float bound"""
    verts = sorted({v for e in spec for v in e[:2]})
    if splits is None:
        n = len(verts); splits = []
        for r in range(1, n // 2 + 1):
            for V1 in itertools.combinations(verts, r):
                splits.append(V1)
    best = None
    for V1 in splits:
        V2 = [v for v in verts if v not in V1]
        if not V2: continue
        try:
            S1 = ms.star(doubled_half(spec, V1), quiet=True); S2 = ms.star(doubled_half(spec, V2), quiet=True)
        except (MemoryError, AssertionError) as e:
            continue
        if S1 < 0 or S2 < 0: raise ValueError("a doubled half read negative: the instrument is wrong")
        b = math.sqrt(float(S1) * float(S2))
        if best is None or b < best[0]: best = (b, tuple(V1), S1, S2)
    return best
if __name__ == "__main__":
    # known answer: K_{2,2,2,2} with the half {0,1,2,3}: S(H+) = 1578529/140625 (cut_k2222.py, the spin-1 road)
    K2222 = [(i, j, 1) for i in range(8) for j in range(i + 1, 8) if j != i ^ 1]
    b = cut_bound(K2222, splits=[(0, 1, 2, 3)])
    print("K2222 half {0,1,2,3}: S(H+) =", b[2], "=", float(b[2]), "bound", b[0], "(stake 1578529/140625 = 11.2251)")
    # the K4-of-walls configuration (exact 3271/3600 on the reduced four-cycle), every bipartition
    red4 = [(0, 2, H), (2, 4, H), (4, 6, H), (6, 0, H)]
    K4 = [(a, bb, 1) for a in (0, 2, 4, 6) for bb in (0, 2, 4, 6) if a < bb]
    b = cut_bound(red4 + K4)
    print("K4 walls: best cut bound", b[0], "split", b[1], "halves", b[2], b[3], "(exact S = 3271/3600 = 0.9086)")
    # the chord triangle (exact 3/4)
    tri = [(0, 1, H), (1, 2, H), (2, 0, H), (0, 1, 1), (1, 2, 1), (2, 0, 1)]
    b = cut_bound(tri)
    print("chord triangle: best cut bound", b[0], "split", b[1], "(exact 3/4)")
