"""M6 instrument, run b: the remaining ladder rows, certified with mpmath.iv (outward rounding).

Rows:
 (B1) CMP 116 (1.40) domain e^{16 k1} C1 eps1 <= a1/3 with (2.31) gamma^2 <= gamma2 eps1^2/(80 kappa): log beta >= 32 k1 + ln 80
 (B2) CMP 116 (1.21) e^{32 k1} eps1 <= const with (2.31):                                         log beta >= 64 k1 + ln 80
 (B3) CMP 116 (2.28) with LFR II (1.93) alpha <= e^{-6(1+b)kappa d}, alpha ~ eps1 e^{C2 k1}:          log beta >= 2(56 k1 + 24 kappa) + ln 80
 (B4) LFR II (1.88) entropy pinch at FIXED localisation scale R (r = 0): beta >= (1.5 (100M)^d R^(d+2) M^6 / a)^2, R = 1, a = 1
 (B5) the same without the LFR I (1.87) M^6 factor: beta >= (1.5 (100M)^d)^2
All existential constants at 1 (the value most favourable to a small threshold), kappa = 1, d = 4.
"""
import mpmath
from mpmath import iv

iv.dps = 50
LN10 = iv.log(iv.mpf(10))
k1 = 1 + 2 * iv.log(iv.mpf(13824))
ln80 = iv.log(iv.mpf(80))


def pr(name, v):
    print(f"{name}: log beta >= [{mpmath.nstr(v.a, 12)}, {mpmath.nstr(v.b, 12)}];"
          f" log10 beta >= [{mpmath.nstr((v / LN10).a, 10)}, {mpmath.nstr((v / LN10).b, 10)}]")


print("=" * 100)
print(f"kappa1_min = [{mpmath.nstr(k1.a, 15)}, {mpmath.nstr(k1.b, 15)}]")
pr("(B1) CMP 116 (1.40) domain + (2.31)", 32 * k1 + ln80)
pr("(B2) CMP 116 (1.21) + (2.31)", 64 * k1 + ln80)
pr("(B3) CMP 116 (2.28) + LFR II (1.93) (kappa = 1, beta-param -> 0) + (2.31)", 2 * (56 * k1 + 24) + ln80)
d = 4
for M in (27, 81, 243, 729):
    v4 = 2 * (iv.log(iv.mpf("1.5")) + d * iv.log(iv.mpf(100 * M)) + 6 * iv.log(iv.mpf(M)))
    v5 = 2 * (iv.log(iv.mpf("1.5")) + d * iv.log(iv.mpf(100 * M)))
    pr(f"(B4) LFR II (1.88) x LFR I (1.87) at fixed R = 1, M = {M}", v4)
    pr(f"(B5) LFR II (1.88) entropy alone at fixed R = 1, M = {M}", v5)
print("=" * 100)
