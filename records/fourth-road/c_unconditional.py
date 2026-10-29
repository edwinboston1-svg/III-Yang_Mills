# The unconditional chessboard constant for SU(2) Wilson LGT on the even 4-torus, full (mu nu) class:
#   upper half (proved): Z_{Lam\A} e^{-beta(N-|A|)} <= I(beta)^{3|Lam|(1-1/L)}   [temporal gauge, (i4) plaquettes i.i.d. Haar]
#   lower half (proved here): Z e^{-beta N} >= I(6 beta)^{3|Lam|+1}           [tree gauge, i.i.d. single-link Gibbs trial
#        at coupling 6 beta; E Re U_p = prod_i c_i exactly by independence + conjugation invariance; 1-c^m <= m(1-c)]
#   => K_A(beta) <= (I(beta)/I(6 beta))^3 * (finite-L factors -> 1),  I(l) = 2 I_1(l) e^{-l} / l
import math
from scipy.special import ive
I = lambda l: 2.0*ive(1, l)/l
f = lambda l: l**1.5 * I(l)
grid = [10**(k/50.0) for k in range(-150, 251)]
inc = all(f(grid[i+1]) > f(grid[i]) for i in range(len(grid)-1))
print('l^{3/2} I(l) increasing on [1e-3, 1e5] (401 log-spaced points): %s;  limit sqrt(2/pi) = %.6f, f(1e5) = %.6f'
      % (inc, math.sqrt(2/math.pi), f(1e5)))
print('6^{9/2} = %.4f   (Gaussian K_inf = 3.4911; conditional ceiling 403.08)' % 6**4.5)
for b in (10, 31, 50, 61.8, 70.9, 98.1, 150, 181, 1000):
    K = (I(b)/I(6*b))**3
    print('beta = %7.1f   K <= (I(b)/I(6b))^3 = %9.2f   s_c = log(20 e K) = %.4f' % (b, K, math.log(20*math.e*K)))
