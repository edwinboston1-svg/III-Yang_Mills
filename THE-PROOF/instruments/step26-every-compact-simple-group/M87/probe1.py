import time
from fractions import Fraction as F
from ivr import *
t=time.time()
for beta in ["0.241","0.2414","0.2415"]:
    R=row(F(beta)); print(beta, "alpha", R["alpha"].s(12), "12Cdir", R["12Cdir"].s(9), "90Cmed", R["90Cmed"].s(9), "omega", R["omega"].s(9), "rho", R["rho"].s(9))
print("m two roads at 1.2:", m_bessel(F(6,5)).s(20), m_reg(F(6,5)).s(20))
print("PI", PI.s(30))
for beta in ["0.2450","0.2452","0.2453"]:
    R=row(F(beta),sharp=True); print(beta, "SHARP alpha", R["alpha"].s(12), "D5", R["D5"].s(10), "T6", R["T6"].s(10))
r=F(6)*F("0.2452"); z=r*r/4
a=3*Dabs(r)/r; b=2*m_reg(r)*phi2(r)
print("r=6beta", float(r), "a", a.s(8), "b", b.s(8), "b/a", (b/a).s(6), "5/3=", 5/3)
print("time", time.time()-t)
