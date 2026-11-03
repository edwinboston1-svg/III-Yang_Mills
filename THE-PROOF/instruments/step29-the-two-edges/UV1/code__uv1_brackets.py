"""UV1 item 2: TWO-SIDED brackets of the two free energies (COMPUTED, intervals), beside their Gaussian asymptotics (READING).

 f0 (Wilson, six orientations):   L0(beta) <= f0 <= U0(beta) := ln c(3b) + ln c(2b) + ln c(b)
      (U0: sequential, within-site order sigma < mu < nu after the temporal plaquette: n = (3, 2, 1); Lemma AF (G1))
 f1 (mu-nu removed):              L1(beta) <= f1 <= U1(beta) (Theorem U, design B')
      L1 = max_t [3 ln c(t) + 3t(1 - r) - beta(3(1 - r^2) + 2(1 - r^4))]   (product trial, two spatial orientations left)
 Gaussian: f0 ~ 1.5 ln(2/pi) - 4.5 ln b - 3 G4 ; f1 ~ 1.5 ln(2/pi) - 4.5 ln b - 1.5 (G4 + G2) (G4 = 1.99970764452, G2 = 1.16624361612).
Run: python -u -E -P code/uv1_brackets.py > rec/brackets.<date>.txt
"""
import math
import sys

sys.path.insert(0, __file__.rsplit("\\", 1)[0] if "\\" in __file__ else __file__.rsplit("/", 1)[0])
from uv1_c import U1_designs, L0t, topt, bessels, nstr   # noqa: E402
from mpmath import iv, mp, mpf

G4 = mpf('1.99970764452')
G2 = mpf('1.16624361612')


def L1t(beta, t):
    I = bessels(t, 3)
    c = 2 * iv.exp(-t) * I[1] / t
    r = I[2] / I[1]
    return 3 * iv.log(c) + 3 * t * (1 - r) - beta * (3 * (1 - r ** 2) + 2 * (1 - r ** 4))


def L1_float(beta, t):
    t = mpf(t)
    I1 = mp.besseli(1, t)
    I2 = mp.besseli(2, t)
    c = 2 * mp.exp(-t) * I1 / t
    r = I2 / I1
    return 3 * mp.log(c) + 3 * t * (1 - r) - beta * (3 * (1 - r ** 2) + 2 * (1 - r ** 4))


def topt1(beta):
    lo, hi = 1.5 * beta, 10.0 * beta
    g = (math.sqrt(5) - 1) / 2
    x1 = hi - g * (hi - lo)
    x2 = lo + g * (hi - lo)
    f1, f2 = L1_float(beta, x1), L1_float(beta, x2)
    for _ in range(60):
        if f1 < f2:
            lo, x1, f1 = x1, x2, f2
            x2 = lo + g * (hi - lo)
            f2 = L1_float(beta, x2)
        else:
            hi, x2, f2 = x2, x1, f1
            x1 = hi - g * (hi - lo)
            f1 = L1_float(beta, x1)
    return mpf((lo + hi) / 2)


print(" beta | f0: [L0, U0]            | Gauss f0 | f1: [L1, U1]            | Gauss f1 | C <= U1 - L0 | C_Gauss | widths U0-L0, U1-L1")
for b in (5, 10, 15, 20, 30, 60, 120):
    B = iv.mpf(b)
    m8b, seqA, Bp, bd, lc1, lc2 = U1_designs(B)
    I3 = bessels(3 * B, 3)
    lc3 = iv.log(2 * iv.exp(-3 * B) * I3[1] / (3 * B))
    U0 = lc3 + lc2 + lc1
    L0 = L0t(B, iv.mpf(topt(mpf(b))))
    L1 = L1t(B, iv.mpf(topt1(mpf(b))))
    g0 = 1.5 * mp.log(2 / mp.pi) - 4.5 * mp.log(b) - 3 * G4
    g1 = 1.5 * mp.log(2 / mp.pi) - 4.5 * mp.log(b) - 1.5 * (G4 + G2)
    print(" %4d | [%s, %s] | %s | [%s, %s] | %s | %s | %s | %s, %s" % (
        b, nstr(L0.a, 7), nstr(U0.b, 7), nstr(g0, 7), nstr(L1.a, 7), nstr(Bp.b, 7), nstr(g1, 7),
        nstr(mpf(Bp.b) - mpf(L0.a), 7), nstr(g1 - g0, 6), nstr(mpf(U0.b) - mpf(L0.a), 5), nstr(mpf(Bp.b) - mpf(L1.a), 5)))
