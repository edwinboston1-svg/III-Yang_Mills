# MPAIR sigma_l86.py -- alpha_sigma = 30 C_med with Lemma 8.6's constants in MG2's certified L86 mode (iv, 256 bits): the root on a 1e-4 grid.
import sys
from decimal import Decimal
sys.path.insert(0, sys.argv[1])
from mpmath import mp
import mg2_su2_eval as S2
b = Decimal('0.40'); step = Decimal('0.01')
f = lambda x: mp.mpf((S2.alpha_su2(str(x), 'L86')['med90'] / 3).b.b)
while True:
    nb = b + step
    if f(nb) < 1: b = nb
    else:
        if step <= Decimal('0.0001'): break
        step = step / 10
print('L86 CERTIFIED: 30*C_med < 1 at beta = %s (%s); at %s: %s' % (b, mp.nstr(f(b), 9), b + Decimal('0.0001'), mp.nstr(f(b + Decimal('0.0001')), 9)))
