"""ME2 check of Lemma 6.2' in its SCALAR analogue (double precision; a check, not an input of any proof).

Free scalar field. Original: fine lattice Z^4, centred box average over {-2..2}^4 onto 5Z^4.
Rotated: fine lattice R Z^4 (R = L_q, q = (1+2i+2j+4k)/5), average over the 625 points of R Z^4 in [-5/2,5/2)^4 onto 5Z^4.
Blocked covariance G(P) = sum over the 625 dual cosets k of |Q(P+k)|^2 / K0(P+k); blocked kernel K1 = 1/G.
STAKE (written in WORK.md before the run): K1 - |P|^2 = O(|P|^4) for both (the dimension-two term is isotropic with
coefficient 1); (K1^R - K1)/|P|^4 tends to a direction-dependent, nonzero limit (values UNGUESSED).
KNOWN ANSWERS checked first: Q(0) = 1; Q(k) = 0 at every nonzero coset (character sums), both lattices.
Run: python -I me2_skewkernel.py <outfile>
"""
import sys, math, cmath
from itertools import product

M = [[1, -2, -2, -4], [2, 1, -4, 2], [2, 4, 1, -2], [4, -2, 2, 1]]       # 5R
R = [[x / 5 for x in r] for r in M]
def Rvec(n): return [sum(R[i][k] * n[k] for k in range(4)) for i in range(4)]
# block points
Bstd = [list(n) for n in product(range(-2, 3), repeat=4)]
Brot = []
for n in product(range(-6, 7), repeat=4):
    x = [sum(M[i][k] * n[k] for k in range(4)) for i in range(4)]       # 5 * (R n)
    if all(-25 <= 2 * xi < 25 for xi in x): Brot.append([xi / 5 for xi in x])
assert len(Bstd) == 625 and len(Brot) == 625, (len(Bstd), len(Brot))
# dual cosets: k = 2 pi m / 5, m mod (fine reciprocal)
ks_std = [[2 * math.pi * mi / 5 for mi in m] for m in product(range(5), repeat=4)]
seen = {}; MT = [[M[j][i] for j in range(4)] for i in range(4)]
for m in product(range(25), repeat=4):
    key = tuple(sum(MT[i][k] * m[k] for k in range(4)) % 25 for i in range(4))
    if key not in seen: seen[key] = m
    if len(seen) == 625: break
assert len(seen) == 625, len(seen)
ks_rot = [[2 * math.pi * mi / 5 for mi in m] for m in seen.values()]
axes_rot = [[R[i][mu] for i in range(4)] for mu in range(4)]           # R e_mu (columns)

def Q(p, B):
    s = 0j
    for x in B: s += cmath.exp(1j * (p[0] * x[0] + p[1] * x[1] + p[2] * x[2] + p[3] * x[3]))
    return s / len(B)
def K0std(p): return sum(4 * math.sin(pm / 2) ** 2 for pm in p)
def K0rot(p): return sum(4 * math.sin(sum(p[i] * a[i] for i in range(4)) / 2) ** 2 for a in axes_rot)
def G(P, B, ks, K0):
    s = 0.0
    for k in ks:
        p = [P[i] + k[i] for i in range(4)]
        q = Q(p, B); s += (abs(q) ** 2) / K0(p)
    return s

out = []
def say(s): print(s); out.append(s)
# known answers
say(f"Q_std(0) = {Q([0,0,0,0], Bstd):.3e}, Q_rot(0) = {Q([0,0,0,0], Brot):.3e}")
mx_s = max(abs(Q(k, Bstd)) for k in ks_std if any(abs(c) > 1e-12 for c in k))
mx_r = max(abs(Q(k, Brot)) for k in ks_rot if any(abs(c) > 1e-12 for c in k))
say(f"max |Q(k)| over nonzero cosets: std {mx_s:.2e}, rot {mx_r:.2e}")
dirs = {"e1": [1, 0, 0, 0], "(1,1,0,0)/r2": [1, 1, 0, 0], "(1,1,1,1)/2": [1, 1, 1, 1], "Re1=(1,2,2,4)/5": [1, 2, 2, 4], "rand": [0.3, -0.7, 0.5, 0.41]}
for name, n in dirs.items():
    nn = math.sqrt(sum(c * c for c in n)); n = [c / nn for c in n]
    for t in (0.08, 0.04, 0.02, 0.01):
        P = [t * c for c in n]
        K1s = 1 / G(P, Bstd, ks_std, K0std); K1r = 1 / G(P, Brot, ks_rot, K0rot)
        p2 = t * t
        say(f"{name:16s} t={t:5.3f}  (K1std-|P|^2)/|P|^4={(K1s - p2) / p2**2: .6f}  (K1rot-|P|^2)/|P|^4={(K1r - p2) / p2**2: .6f}  (K1rot-K1std)/|P|^4={(K1r - K1s) / p2**2: .6f}")
with open(sys.argv[1], "w", encoding="utf-8") as fh: fh.write("\n".join(out) + "\n")
