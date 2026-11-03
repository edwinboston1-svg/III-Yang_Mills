# hybrid_probe.py -- wall-dense vertices with off-sheet links added (the MIXED family near its wall extremes): does any
# per-corner rate exceed the K4-of-walls 1.113533?  Reduced four-cycle 0,2,4,6 at 1/2 (the Hamiltonian sheet), K4 walls,
# plus off-sheet links 8, 9 with spokes (each off-sheet link needs Gamma-degree >= 2).
import sys, os; sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
os.environ["MIXED_NOKAT"] = "1"; os.environ["MAXCELLS"] = "120000000"
import mixed_star as ms, cut_star as cs
from fractions import Fraction as Fr
H = Fr(1, 2)
def rate(label, edges, m, k):
    try:
        S = ms.star(edges, quiet=True); how = "EXACT"
    except MemoryError:
        verts = sorted({v for e in edges for v in e[:2]}); n = len(verts)
        splits = [c for c in __import__("itertools").combinations(verts, n // 2) if verts[0] in c] + [(v,) for v in verts]
        b = cs.cut_bound(edges, splits=splits); S = b[0]; how = "CUT split=%s" % (b[1],)
    r2 = float(S) * 2.0 ** (m - 2) if m >= 2 else float(S)
    print("%-58s S=%s r2=%.5f per-corner=%.5f %s" % (label, S, r2, r2 ** (1.0/(2*k)), how), flush=True)
red4 = [(0, 2, H), (2, 4, H), (4, 6, H), (6, 0, H)]
K4 = [(a, b, 1) for a in (0, 2, 4, 6) for b in (0, 2, 4, 6) if a < b]
rate("K4 walls alone (k=6)", red4 + K4, 4, 6)
rate("K4 walls + four-spine to 8 (k=10)", red4 + K4 + [(8, v, 1) for v in (0, 2, 4, 6)], 4, 10)
rate("K4 walls + two-spoke 0-8-2 (k=8)", red4 + K4 + [(8, 0, 1), (8, 2, 1)], 4, 8)
rate("K4 walls + two-spoke 0-8-4 (k=8)", red4 + K4 + [(8, 0, 1), (8, 4, 1)], 4, 8)
rate("K4 walls + three-spoke 8 to 0,2,4 (k=9)", red4 + K4 + [(8, 0, 1), (8, 2, 1), (8, 4, 1)], 4, 9)
rate("K4 walls + two four-spines 8,9 + 8-9 (k=15)", red4 + K4 + [(8, v, 1) for v in (0, 2, 4, 6)] + [(9, v, 1) for v in (0, 2, 4, 6)] + [(8, 9, 1)], 4, 15)
tri = [(0, 2, H), (2, 4, H), (4, 0, H), (0, 2, 1), (2, 4, 1), (0, 4, 1)]
rate("chord triangle alone (k=3)", tri, 3, 3)
rate("chord triangle + three-spoke 8 (k=6)", tri + [(8, 0, 1), (8, 2, 1), (8, 4, 1)], 3, 6)
rate("chord triangle + two-spoke 0-8-2 (k=5)", tri + [(8, 0, 1), (8, 2, 1)], 3, 5)
rate("W4 (four-spine alone, k=4)", red4 + [(8, v, 1) for v in (0, 2, 4, 6)], 4, 4)
rate("four-spine + one wall 0-2 (k=5)", red4 + [(8, v, 1) for v in (0, 2, 4, 6)] + [(0, 2, 1)], 4, 5)
rate("four-spine + diagonal wall 0-4 (k=5)", red4 + [(8, v, 1) for v in (0, 2, 4, 6)] + [(0, 4, 1)], 4, 5)
