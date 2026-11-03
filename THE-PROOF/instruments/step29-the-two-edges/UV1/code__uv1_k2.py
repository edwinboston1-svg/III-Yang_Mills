"""UV1 item 1: THE FIRST KNOWN ANSWER, K2 = 32 b1 ln L (SU(2), beta = 4/g^2), and its form for every compact simple G.

Three independent roads, one number:
 (A) the formula, in outward-rounded interval arithmetic (mpmath.iv, 50 digits): K2 = 2 (d_R/T_R)^2 b1 ln L, c1 = 2 (d_R/T_R) b0 ln L,
     b0 = 11 h/(48 pi^2), b1 = (34/3) h^2/(16 pi^2)^2 (h = dual Coxeter number; SU(N) fundamental: d_R/T_R = 2N).
 (B) the EXACT two-loop step map: the RG invariant Phi(x) = x/(2 b0) - (b1/(2 b0^2)) ln(b0 x + b1), x = 1/g^2, satisfies
     Phi(x') = Phi(x) - ln L over one coarse-graining step; solved by Newton at 80 digits for beta = 1e3 .. 1e9, then
     beta*(beta' - beta + c1) -> -K2 read off by Richardson extrapolation in 1/beta (a READING to many digits, no formula used).
 (C) the step map of the three-loop MS-bar flow (b2 = (2857/54) h^3/(16 pi^2)^3, pure gauge), integrated by mpmath's Taylor ODE
     solver: the 1/beta coefficient must be the SAME K2 (universality), the 1/beta^2 coefficient K3_MS = 128 (b0 b1 ln^2 L + b2 ln L)
     (SU(2)), and a scheme change beta2 = beta1 + a + b/beta1 must move only the 1/beta^2 coefficient, by a K2 - b c1.
Run: python -u -E -P code/uv1_k2.py > rec/k2.<date>.txt
"""
import mpmath as m
from mpmath import iv, mp, mpf

mp.dps = 80
iv.dps = 50


def consts_iv(h, dRT):
    pi = iv.pi
    b0 = iv.mpf(11) * h / (48 * pi ** 2)
    b1 = (iv.mpf(34) / 3) * h ** 2 / (16 * pi ** 2) ** 2
    b2 = (iv.mpf(2857) / 54) * h ** 3 / (16 * pi ** 2) ** 3
    return b0, b1, b2


def fmt(x, n=14):
    return "[%s, %s]" % (m.nstr(mpf(x.a), n), m.nstr(mpf(x.b), n))


print("=== (A) THE FORMULA, outward-rounded (mpmath.iv, 50 digits) ===")
groups = [("SU(2)", 2, 4), ("SU(3)", 3, 6), ("SU(4)", 4, 8), ("SU(5)", 5, 10)]
for name, h, dRT in groups:
    b0, b1, b2 = consts_iv(iv.mpf(h), iv.mpf(dRT))
    print("%s: h = %d, d_R/T_R = %d, b0 = %s, b1 = %s" % (name, h, dRT, fmt(b0), fmt(b1)))
    for L in (2, 3, 4):
        lnL = iv.log(iv.mpf(L))
        c1 = 2 * dRT * b0 * lnL
        K2 = 2 * dRT ** 2 * b1 * lnL
        print("   L = %d: c1 = %s  K2 = %s  K2/c1 = %s  K2/(c1 - 0.05) = %s" % (L, fmt(c1), fmt(K2), fmt(K2 / c1), fmt(K2 / (c1 - iv.mpf('0.05')))))
    print("   K2/c1 (L-independent) = (d_R/T_R)(17/88) h/pi^2 = %s" % fmt(iv.mpf(dRT) * iv.mpf(17) / 88 * h / iv.pi ** 2))
b0, b1, b2 = consts_iv(iv.mpf(2), iv.mpf(4))
print("SU(2) check of the tube's numbers: 32 b1 ln 2 = %s (M8b: 0.040323; M8 rec/c3_table: 0.0403230743812)" % fmt(32 * b1 * iv.log(2)))
print("                                  32 b1 ln 3 = %s (M8: 0.0639105608081)" % fmt(32 * b1 * iv.log(3)))
print("                                   8 b0 ln 2 = %s (M8: 0.257511806833)" % fmt(8 * b0 * iv.log(2)))
print("SU(2) MS-bar three-loop: K3_MS(L) = 128 (b0 b1 ln^2 L + b2 ln L): L = 2: %s, L = 3: %s" % (
    fmt(128 * (b0 * b1 * iv.log(2) ** 2 + b2 * iv.log(2))), fmt(128 * (b0 * b1 * iv.log(3) ** 2 + b2 * iv.log(3)))))

print()
print("=== (B) THE EXACT TWO-LOOP STEP MAP, Newton on the RG invariant (80 digits), Richardson in 1/beta ===")


def step2(beta, L, h=2, dRT=4):
    pi = mp.pi
    B0 = mpf(11) * h / (48 * pi ** 2)
    B1 = (mpf(34) / 3) * h ** 2 / (16 * pi ** 2) ** 2
    x = beta / dRT                         # x = 1/g^2
    Phi = lambda y: y / (2 * B0) - (B1 / (2 * B0 ** 2)) * m.log(B0 * y + B1)
    target = Phi(x) - m.log(L)
    y = x - 2 * B0 * m.log(L)              # one-loop guess
    for _ in range(200):
        f = Phi(y) - target
        df = 1 / (2 * B0) - (B1 / (2 * B0)) / (B0 * y + B1)
        dy = f / df
        y -= dy
        if abs(dy) < mpf(10) ** (-75) * abs(y):
            break
    return dRT * y, B0, B1


for (h, dRT, name) in ((2, 4, "SU(2)"), (3, 6, "SU(3)")):
    for L in (2, 3):
        betas = [mpf(10) ** k for k in range(3, 10)]
        vals = []
        for bt in betas:
            bp, B0, B1 = step2(bt, L, h, dRT)
            c1 = 2 * dRT * B0 * m.log(L)
            vals.append(-(bp - bt + c1) * bt)      # -> K2 + K3'/beta + ...
        # Richardson in u = 1/beta (geometric ratio 10): eliminate u, u^2, u^3
        R = vals[:]
        for k in range(1, 4):
            R = [(10 ** k * R[i + 1] - R[i]) / (10 ** k - 1) for i in range(len(R) - 1)]
        K2f = 2 * dRT ** 2 * B1 * m.log(L)
        print("%s L = %d: beta*(beta - c1 - beta') at beta = 1e3..1e9: %s" % (name, L, ", ".join(m.nstr(v, 12) for v in vals)))
        print("          Richardson limit = %s ; formula 2(d/T)^2 b1 ln L = %s ; |diff| = %s" % (
            m.nstr(R[-1], 30), m.nstr(K2f, 30), m.nstr(abs(R[-1] - K2f), 3)))
        # the two-loop flow's own 1/beta^2 coefficient: 2 (d/T)^3 b0 b1 ln^2 L (b2 = 0 here)
        sec = [(v - K2f) * bt for v, bt in zip(vals, betas)]
        print("          beta*(that - K2) -> 2(d/T)^3 b0 b1 ln^2 L = %s ; read at 1e9: %s" % (
            m.nstr(2 * dRT ** 3 * B0 * B1 * m.log(L) ** 2, 15), m.nstr(sec[-1], 15)))

print()
print("=== (C) THREE-LOOP MS-bar FLOW BY TAYLOR ODE (40 digits), AND A SCHEME CHANGE ===")
mp.dps = 40


def step3(beta, L, h=2, dRT=4, b2on=True):
    pi = mp.pi
    B0 = mpf(11) * h / (48 * pi ** 2)
    B1 = (mpf(34) / 3) * h ** 2 / (16 * pi ** 2) ** 2
    B2 = (mpf(2857) / 54) * h ** 3 / (16 * pi ** 2) ** 3 if b2on else mpf(0)
    # x = 1/g^2 ; along coarse-graining s = ln(scale): dx/ds = -(2 B0 + 2 B1/x + 2 B2/x^2)
    f = m.odefun(lambda s, x: -(2 * B0 + 2 * B1 / x + 2 * B2 / x ** 2), 0, beta / dRT)
    return dRT * f(m.log(L)), B0, B1, B2


L = 2
betas = [mpf(10) ** k for k in (2, 3, 4, 5)]
rows = []
for bt in betas:
    bp, B0, B1, B2 = step3(bt, L)
    c1 = 8 * B0 * m.log(L)
    D = bt - c1 - bp
    rows.append((bt, D))
K2f = 32 * B1 * m.log(L)
K3f = 128 * (B0 * B1 * m.log(L) ** 2 + B2 * m.log(L))
print("SU(2) L = 2, three-loop MS-bar flow: beta*(beta - c1 - beta') = " + ", ".join(m.nstr(D * bt, 14) for bt, D in rows))
print("   -> K2 = %s (formula)" % m.nstr(K2f, 20))
print("   beta^2*(D - K2/beta) = " + ", ".join(m.nstr((D - K2f / bt) * bt ** 2, 12) for bt, D in rows) + "  -> K3_MS = %s" % m.nstr(K3f, 15))
# scheme change: beta2 = beta1 + a + b/beta1
a, b = mpf('1.11'), mpf('0.7')
print("scheme change beta2 = beta1 + a + b/beta1 with a = %s, b = %s:" % (a, b))
for bt, D in rows:
    bp = bt - 8 * B0 * m.log(L) - D
    b2_ = bt + a + b / bt
    b2p = bp + a + b / bp
    D2 = b2_ - 8 * B0 * m.log(L) - b2p
    print("   beta2 = %s: beta2*D2 = %s ; beta2^2*(D2 - K2/beta2) = %s" % (
        m.nstr(b2_, 10), m.nstr(D2 * b2_, 14), m.nstr((D2 - K2f / b2_) * b2_ ** 2, 12)))
print("   predicted: the 1/beta coefficient unchanged (K2), the 1/beta^2 coefficient K3 + a K2 - b c1 = %s" % m.nstr(
    K3f + a * K2f - b * 8 * B0 * m.log(L), 12))
