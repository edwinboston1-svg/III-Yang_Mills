# rowdim.py -- iii-43's second road on the perfect-decimation row in dimension D (2026-10-29 06:2x), beside iii-38's
# g38_row_dim.awk and sharing no line with it.  The row of Theorem 8.7's proof with P = 2(D-1) plaquettes per link:
#   direct entries 2P = 4(D-1), mediated 3P(P-1) = 6(D-1)(2D-3); M = m((P-1)b); D_P = M^2/3 (hand) or |D((P-1)b)| (true);
#   T = m(Pb)/2 (hand) or |phi'''(Pb)| (true); omega = P (b^2 D_P/2 + b^3 T/3) (the per-plaquette term of the 4D proof,
#   3 = 6/2 and 2 = 6/3 read off the proof's text); rho = (3 e^omega - 1)/2;
#   C_dir = rho (2/(3 pi)) 2 b M + (b^2 D_P + (2/3) b^3 T)/4;  C_med = rho b^2/(3 pi) + (min(b^2 D_P, 2 b^3 T) + (2/3) b^3 T)/4.
# Known answer: D = 4 reproduces Table 3 (ROW(0.2410) = 0.996297; the crossing 0.241415 hand / 0.2452 true).
from decimal import Decimal as Dm, getcontext
from math import factorial
getcontext().prec = 60
PI = Dm("3.14159265358979323846264338327950288419716939937510")
def I(nu, r, terms=120):
    h = r / 2; s = Dm(0)
    for k in range(terms):
        s += h ** (2 * k + nu) / (Dm(factorial(k)) * Dm(factorial(k + nu)))
    return s
def m(r): return I(2, r) / I(1, r)
def Dfun(r):
    mm = m(r); return 1 - 4 * mm / r - mm * mm
def phi3(r):
    mm = m(r); mp = 1 - 3 * mm / r - mm * mm
    return -3 * mp / r + 3 * mm / (r * r) - 2 * mm * mp
def row(D, b, true=False):
    b = Dm(b); P = 2 * (D - 1); Nd = 2 * P; Nm = 3 * P * (P - 1)
    M = m((P - 1) * b)
    DP = abs(Dfun((P - 1) * b)) if true else M * M / 3
    T = abs(phi3(P * b)) if true else m(P * b) / 2
    om = P * (b * b * DP / 2 + b ** 3 * T / 3)
    rho = (3 * om.exp() - 1) / 2
    Cdir = rho * (2 / (3 * PI)) * 2 * b * M + (b * b * DP + Dm(2) / 3 * b ** 3 * T) / 4
    Cmed = rho * b * b / (3 * PI) + (min(b * b * DP, 2 * b ** 3 * T) + Dm(2) / 3 * b ** 3 * T) / 4
    return Nd * Cdir, Nm * Cmed, Nd * Cdir + Nm * Cmed
def close(D, true, lo, hi):
    lo, hi = Dm(lo), Dm(hi)
    for _ in range(50):
        mid = (lo + hi) / 2
        if row(D, mid, true)[2] < 1: lo = mid
        else: hi = mid
    return lo
print("KAT D=4: ROW(0.2410) hand =", f"{row(4, '0.2410')[2]:.9f}", "(Table 3: 0.996297)")
for D in (2, 3, 4):
    P = 2 * (D - 1)
    print(f"D={D}: P={P} direct={2*P} mediated={3*P*(P-1)}")
    for bs in {2: ["0.70", "0.80", "0.82", "0.83", "0.85"], 3: ["0.30", "0.35", "0.37", "0.374", "0.38", "0.40"], 4: ["0.2300", "0.2410", "0.2452", "0.2500"]}[D]:
        d, mm, R = row(D, bs); Rt = row(D, bs, True)[2]
        print(f"  beta={bs}: direct={d:.6f} mediated={mm:.6f} ROW(hand)={R:.9f}  ROW(true)={Rt:.6f}")
    bh = close(D, False, "0.05", "1.5"); bt = close(D, True, "0.05", "1.5")
    print(f"  ROW = 1 at beta = {bh:.6f} (hand constants)   {bt:.6f} (true constants)")
