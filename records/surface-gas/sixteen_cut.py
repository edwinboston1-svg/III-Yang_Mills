# sixteen_cut.py -- the cut bound at the antipodal split for THE SIXTEEN-CHORD VERTEX (the Yang-Mills seat's labels:
# a..d = 0..3, their antipodes 4..7; the Hamiltonian sheet cycle a c~ b d~ c a~ d b~ = 0 6 1 7 2 4 3 5 at spin 1/2;
# chords: K4 on 0123, K4 on 4567, the cross chords 0-7, 1-4, 2-5, 3-6 at spin 1).  r^2 = 2^(8-2) S; per corner (r^2)^(1/32).
import sys, os; sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
os.environ["MIXED_NOKAT"] = "1"; os.environ["MAXCELLS"] = os.environ.get("MAXCELLS", "120000000")
import cut_star as cs
from fractions import Fraction as Fr
H = Fr(1, 2)
cyc = [0, 6, 1, 7, 2, 4, 3, 5]
spec = [(cyc[i], cyc[(i + 1) % 8], H) for i in range(8)]
spec += [(a, b, Fr(1)) for a in range(4) for b in range(a + 1, 4)]
spec += [(a, b, Fr(1)) for a in range(4, 8) for b in range(a + 1, 8)]
spec += [(0, 7, Fr(1)), (1, 4, Fr(1)), (2, 5, Fr(1)), (3, 6, Fr(1))]
assert len(spec) == 8 + 16
b = cs.cut_bound(spec, splits=[(0, 1, 2, 3)])
S1, S2 = b[2], b[3]
print("S(H1+) =", S1, "=", float(S1), " S(H2+) =", S2, "=", float(S2))
bound = float(S1) ** 0.5 * float(S2) ** 0.5
print("cut bound on S: %.6f ; r2 <= 64 S <= %.4f ; per corner <= %.5f ; the K4-walls 1.113533 is beaten iff S > 0.4878" % (bound, 64 * bound, (64 * bound) ** (1 / 32)))
