"""M3R check 1: the two-loop SU(2) coefficients and the normalisation conversions, exact rationals times powers of pi,
then interval enclosures (mpmath.iv).  Nothing here is read from the draft; every number is recomputed from
b0 = 11N/(48 pi^2), b1 = 34N^2/(3 (16 pi^2)^2) at N = 2.
"""
import sys
sys.path.append(r"C:\Users\Edwin Boston\AppData\Roaming\Python\Python314\site-packages")  # user site (python -I drops it)
from fractions import Fraction as Fr
import mpmath as mp

N = 2
# coefficient of 1/pi^2 in b0 and of 1/pi^4 in b1
b0 = Fr(11 * N, 48)              # b0 = (11N/48)/pi^2
b1 = Fr(34 * N * N, 3 * 256)      # b1 = (34N^2/(3*256))/pi^4
print("b0 =", b0, "/ pi^2   (expect 11/24)")
print("b1 =", b1, "/ pi^4   (expect 17/96)")
# d(1/g^2)/dln mu = 2 b0 + 2 b1 g^2 ; x = 4/g_YM^2 = 1/g_B^2 , g_YM^2 = 4 g_B^2
one_loop = 4 * 2 * b0            # dx/dln mu one-loop: 4*(2 b0) = 8 b0
two_loop = 4 * 2 * b1 * 4         # 4*(2 b1 g_YM^2) = 8 b1 * 4 g_B^2 = 32 b1 g_B^2
print("8 b0  =", one_loop, "/ pi^2   (draft: 11/3)")
print("32 b1 =", two_loop, "/ pi^4   (draft: 17/3)  [coefficient of g_B^2]")
print("4 b1/b0 =", 4 * b1 / b0, "/ pi^2  (draft: 0.156588...)")
# the same running written in g_YM: d(4/g^2)/dlnmu = 8 b0 + 8 b1 g_YM^2 -> coefficient of g_YM^2 is 8 b1
print("8 b1 (coefficient of g_YM^2) =", 8 * b1, "/ pi^4")

iv = mp.iv
iv.dps = 40
pi = iv.pi
def enc(name, v):
    print(f"  {name:28s} in [{mp.nstr(v.a, 16)}, {mp.nstr(v.b, 16)}]")
print("== interval enclosures (iv, 40 digits)")
enc("8b0 = 11/(3pi^2)", iv.mpf(one_loop.numerator) / (one_loop.denominator * pi**2))
enc("c(2) = 8b0 ln2", iv.mpf(one_loop.numerator) / (one_loop.denominator * pi**2) * iv.log(2))
enc("c(3) = 8b0 ln3", iv.mpf(one_loop.numerator) / (one_loop.denominator * pi**2) * iv.log(3))
enc("32b1 = 17/(3pi^4)", iv.mpf(two_loop.numerator) / (two_loop.denominator * pi**4))
enc("32b1 ln2", iv.mpf(two_loop.numerator) / (two_loop.denominator * pi**4) * iv.log(2))
q = 4 * b1 / b0
enc("4b1/b0 = 17/(11pi^2)", iv.mpf(q.numerator) / (q.denominator * pi**2))
# the continuum check of beta = 4/g^2: 1 - cos(theta) with theta = a^2|F|/2 -> |F|^2 a^4/8; beta/8 sum_{mu<nu} = beta/16 sum_{mu,nu}
# must equal 1/(4 g^2): beta = 4/g^2
print("beta from beta/16 = 1/(4g^2):  beta * g^2 =", Fr(16, 4))
