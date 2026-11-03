import sys, os; sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
os.environ["MIXED_NOKAT"] = "1"
import mixed_star as ms
from fractions import Fraction as Fr
H = Fr(1, 2)
def rate(label, edges, m, k):
    S = ms.star(edges, quiet=True); r2 = S * Fr(2) ** (m - 2) if m >= 2 else S
    print("%-52s S = %s  r2 = %s = %.5f  per-corner = %.5f  (3/2)^(k/3) = %.5f" % (label, S, r2, float(r2), float(r2) ** (1.0/(2*k)), 1.5 ** (k/3.0)), flush=True)
# (i) the hexagonal sheet +1,-2,+3,-1,+2,-3 = directions 0,3,4,1,2,5 with BOTH chord triangles (0,4,2) and (3,1,5)
hexa = [0, 3, 4, 1, 2, 5]
C6 = [(hexa[i], hexa[(i+1) % 6], H) for i in range(6)]
T1 = [(0, 4, 1), (4, 2, 1), (0, 2, 1)]; T2 = [(3, 1, 1), (1, 5, 1), (3, 5, 1)]
rate("hexagon + one triangle (k=3)", C6 + T1, 6, 3)
rate("hexagon + two triangles (k=6)", C6 + T1 + T2, 6, 6)
# (ii) the 8-cycle sheet +1,-3,+2,-4,+3,-1,+4,-2 (0,5,2,7,4,1,6,3) with K4 on the four positive directions 0,2,4,6 (k=6)
C8 = [0, 5, 2, 7, 4, 1, 6, 3]
Cyc8 = [(C8[i], C8[(i+1) % 8], H) for i in range(8)]
K4 = [(a, b, 1) for a in (0, 2, 4, 6) for b in (0, 2, 4, 6) if a < b]
# reduced: only the rest links 0,2,4,6 matter: the reduced 4-cycle in the sheet's order 0,2,4,6 (arcs of length 2)
red4 = [(0, 2, H), (2, 4, H), (4, 6, H), (6, 0, H)]
rate("reduced C4(1/2)(+1,+2,+3,+4) + K4 walls (k=6, m=4)", red4 + K4, 4, 6)
rate("full 8-cycle(1/2) + K4 walls (same object, unreduced)", Cyc8 + K4, 8, 6)
# (iii) reduced C4 + 5 of the 6 K4 edges (k=5), + 4 (a 4-cycle of walls on the reduced square: all fused)
rate("reduced C4(1/2) + K4 minus one diagonal (k=5)", red4 + [e for e in K4 if e != (0, 4, 1)], 4, 5)
rate("reduced C4(1/2) + the 4 fused walls (k=4)", red4 + [(0,2,1),(2,4,1),(4,6,1),(6,0,1)], 4, 4)
rate("reduced C4(1/2) + 2 adjacent fused walls + 1 diagonal (k=3)", red4 + [(0,2,1),(2,4,1),(0,4,1)], 4, 3)
