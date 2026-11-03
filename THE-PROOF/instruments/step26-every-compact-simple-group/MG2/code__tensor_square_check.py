# MG2 tensor_square_check.py -- exact check of the Sym^2 / Lambda^2 decompositions used in WORK.md 4.5 (iii):
# for each group the claimed components (highest weights in MG's fundamental-weight labelling) must satisfy
#   sum d_lambda = d(d+1)/2 (Sym^2), d(d-1)/2 (Lambda^2),
#   sum d_lambda C2(lambda) = C2(rho) d (d+2) (Sym^2),  C2(rho) d (d-2) (Lambda^2)       [tr C2 on Sym^2 / Lambda^2]
# Exact rationals (MG's lie_data.py, imported read-only).
import sys
sys.path.insert(0, r'C:\Users\EDWINB~1\AppData\Local\Temp\the author\C--Users-Edwin-Boston-OneDrive-Desktop-III\59ca2c52-22a2-4ac6-93d9-5dadb2bb3bcb\scratchpad\math\MG')
from lie_data import data
from fractions import Fraction as Fr

CASES = [
  # name, typ, rank, rho, Sym2 components, Lambda2 components
  ('SU(2)', 'A', 1, (1,), [(2,)], [(0,)]),
  ('SU(3)', 'A', 2, (1, 0), [(2, 0)], [(0, 1)]),
  ('SU(4)', 'A', 3, (1, 0, 0), [(2, 0, 0)], [(0, 1, 0)]),
  ('SU(5)', 'A', 4, (1, 0, 0, 0), [(2, 0, 0, 0)], [(0, 1, 0, 0)]),
  ('Sp(2)', 'C', 2, (1, 0), [(2, 0)], [(0, 0), (0, 1)]),
  ('SO(3)', 'A', 1, (2,), [(0,), (4,)], [(2,)]),
  ('SO(5)', 'B', 2, (1, 0), [(0, 0), (2, 0)], [(0, 2)]),
  ('SO(6)', 'D', 3, (1, 0, 0), [(0, 0, 0), (2, 0, 0)], [(0, 1, 1)]),
  ('SO(7)', 'B', 3, (1, 0, 0), [(0, 0, 0), (2, 0, 0)], [(0, 1, 0)]),
  ('SO(8)', 'D', 4, (1, 0, 0, 0), [(0, 0, 0, 0), (2, 0, 0, 0)], [(0, 1, 0, 0)]),
  ('G2', 'G', 2, (1, 0), [(0, 0), (2, 0)], [(1, 0), (0, 1)]),
  ('F4', 'F', 4, (0, 0, 0, 1), [(0, 0, 0, 0), (0, 0, 0, 1), (0, 0, 0, 2)], [(1, 0, 0, 0), (0, 0, 1, 0)]),
  ('E6', 'E', 6, (1, 0, 0, 0, 0, 0), [(0, 0, 0, 0, 0, 1), (2, 0, 0, 0, 0, 0)], [(0, 0, 1, 0, 0, 0)]),
  ('E7', 'E', 7, (0, 0, 0, 0, 0, 0, 1), [(1, 0, 0, 0, 0, 0, 0), (0, 0, 0, 0, 0, 0, 2)], [(0, 0, 0, 0, 0, 0, 0), (0, 0, 0, 0, 0, 1, 0)]),
  ('E8', 'E', 8, (0, 0, 0, 0, 0, 0, 0, 1), [(0,) * 8, (1, 0, 0, 0, 0, 0, 0, 0), (0, 0, 0, 0, 0, 0, 0, 2)], [(0, 0, 0, 0, 0, 0, 0, 1), (0, 0, 0, 0, 0, 0, 1, 0)]),
]
allok = True
for name, typ, rk, rho, S2, L2 in CASES:
    D = data(typ, rk)
    d = D['dim'](rho); c = D['C2'](rho)
    sS = sum(D['dim'](m) for m in S2); sL = sum(D['dim'](m) for m in L2)
    cS = sum(D['dim'](m) * D['C2'](m) for m in S2); cL = sum(D['dim'](m) * D['C2'](m) for m in L2)
    ok = (sS == d * (d + 1) / 2 and sL == d * (d - 1) / 2 and cS == c * d * (d + 2) and cL == c * d * (d - 2))
    allok = allok and ok
    print('%-6s d=%s C2=%s hdual=%s dimG=%s | Sym2 %s dims=%s sum=%s/%s trC2=%s/%s | Lam2 %s dims=%s sum=%s/%s trC2=%s/%s | %s' % (
        name, d, c, D['hdual'], D['dimG'], S2, [int(D['dim'](m)) for m in S2], sS, d*(d+1)/2, cS, c*d*(d+2),
        L2, [int(D['dim'](m)) for m in L2], sL, d*(d-1)/2, cL, c*d*(d-2), 'OK' if ok else 'FAIL'))
print('ALL OK' if allok else 'SOME FAIL')
