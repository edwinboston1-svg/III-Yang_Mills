"""M6 instrument, run c: the CMP 116 chain with the e^{5 kappa} of (2.28) carried (run a's chain() omitted it).
log beta_B >= 2 C2 kappa1 + 10 kappa + ln(80 kappa / gamma2) + 2 ln P, certified with mpmath.iv."""
import mpmath
from mpmath import iv

iv.dps = 50
LN10 = iv.log(iv.mpf(10))
k1 = 1 + 2 * iv.log(iv.mpf(13824))
for name, C2, kk1, kap in (("literal C2=56, kappa1=kappa1_min, kappa=1", iv.mpf(56), k1, 1),
                           ("C2=56, kappa=3, kappa1=(224/15)*3", iv.mpf(56), iv.mpf(224) / 15 * 3, 3),
                           ("decimal reading C2=7.8, kappa1=kappa1_min, kappa=1", iv.mpf("7.8"), k1, 1)):
    v = 2 * C2 * kk1 + 10 * kap + iv.log(iv.mpf(80) * kap)
    print(f"{name}: log beta_B >= [{mpmath.nstr(v.a, 12)}, {mpmath.nstr(v.b, 12)}]; "
          f"log10 beta_B >= [{mpmath.nstr((v / LN10).a, 10)}, {mpmath.nstr((v / LN10).b, 10)}]")
