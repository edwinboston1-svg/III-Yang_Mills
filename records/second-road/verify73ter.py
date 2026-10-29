# verify73ter.py -- iii-43's second road for the YM seat's section 73 ter (2026-10-29 03:1x).
# Shares no line with STDLIB/scripts/aperanton_decimation_cert.awk or aperanton_perfect_cover.pl.
# (1) the perfect cover: parse the record's 16 links, check every plaquette of the 2^4 torus AND of
#     the 4^4 torus (period-2 extension) has exactly one cover link; check one cover link per site.
# (2) the row sum: m(r) = I2(r)/I1(r) by Decimal series (60 digits), the seat's formula verbatim,
#     compared with the record; then the same formula with the true constants
#     (|D(5b)| for m(5b)^2/3; |phi'''(6b)| for m(6b)/2), the directional sup being |phi'''| at c = 1.
# (3) the Turan coefficient identities, exactly in fractions, for k = 0..40.
import sys
from decimal import Decimal as Dm, getcontext
from fractions import Fraction as Fr
from math import factorial
getcontext().prec = 60

# ---------- (1) the cover ----------
rec = sys.argv[1]
cover = {}
for line in open(rec, encoding="utf-8"):
    line = line.strip()
    if line.startswith("link"):
        coords = line[line.index("(") + 1:line.index(")")]
        x = tuple(int(c) for c in coords.split(","))
        d = int(line.split("dir")[1]) - 1
        cover[x] = d
assert len(cover) == 16, len(cover)
def is_cover(x, d, P=2):
    return cover[tuple(c % 2 for c in x)] == d
def check(L):
    bad = 0; total = 0
    import itertools
    for x in itertools.product(range(L), repeat=4):
        for i in range(4):
            for j in range(i + 1, 4):
                ei = [0] * 4; ei[i] = 1
                ej = [0] * 4; ej[j] = 1
                xi = tuple((x[k] + ei[k]) % L for k in range(4))
                xj = tuple((x[k] + ej[k]) % L for k in range(4))
                links = [(x, i), (xi, j), (xj, i), (x, j)]
                n = sum(1 for (y, d) in links if is_cover(y, d))
                total += 1
                if n != 1:
                    bad += 1
    return total, bad
for L in (2, 4):
    t, b = check(L)
    print(f"COVER L={L}: plaquettes={t} with count != 1: {b}")
# a bent rule must fail (sighted control): flip one site's direction
save = cover[(0, 0, 0, 0)]
cover[(0, 0, 0, 0)] = (save + 1) % 4
t, b = check(2)
print(f"COVER CONTROL (one site bent) L=2: plaquettes={t} with count != 1: {b}  (must be > 0)")
cover[(0, 0, 0, 0)] = save

# ---------- (3) Turan coefficient identities, exact ----------
okT = True
for k in range(41):
    c22 = Fr(factorial(4 + 2 * k), factorial(k) * factorial(2 + k) * factorial(2 + k) * factorial(4 + k))
    c13 = Fr(factorial(4 + 2 * k), factorial(k) * factorial(1 + k) * factorial(3 + k) * factorial(4 + k))
    claimed = Fr(factorial(4 + 2 * k), factorial(k) * factorial(4 + k) * factorial(2 + k) * factorial(3 + k))
    if c22 - c13 != claimed or claimed <= 0:
        okT = False
    if not (2 * c22 <= 3 * c13):
        okT = False
print(f"TURAN k=0..40: coef(I2^2 - I1 I3) = (4+2k)!/(k!(4+k)!(2+k)!(3+k)!) > 0 and 2 I2^2 <= 3 I1 I3 termwise: {okT}")

# ---------- (2) the row sum ----------
def I(nu, r, terms=90):
    h = r / 2
    s = Dm(0)
    for k in range(terms):
        s += h ** (2 * k + nu) / (Dm(factorial(k)) * Dm(factorial(k + nu)))
    return s
def m(r):
    return I(2, r) / I(1, r)
def D(r):           # phi'' - m/r = 1 - 4m/r - m^2  (<= 0)
    mm = m(r)
    return 1 - 4 * mm / r - mm * mm
def phi3(r):        # phi''' = m'' = -3m'/r + 3m/r^2 - 2 m m'
    mm = m(r); mp = 1 - 3 * mm / r - mm * mm
    return -3 * mp / r + 3 * mm / (r * r) - 2 * mm * mp
PI = Dm("3.14159265358979323846264338327950288419716939937510")
print(f"KAT m(1) = {m(Dm(1)):.12f}  (record: 0.240193723870)")

def row(b, D5, T6):
    b = Dm(b)
    M5 = m(5 * b)
    om = 3 * b * b * D5 + 2 * b ** 3 * T6
    rho = (3 * om.exp() - 1) / 2
    Cdir = rho * (2 / (3 * PI)) * 2 * b * M5 + (b * b * D5 + Dm(2) / 3 * b ** 3 * T6) / 4
    Cmed = rho * b * b / (3 * PI) + (min(b * b * D5, 2 * b ** 3 * T6) + Dm(2) / 3 * b ** 3 * T6) / 4
    return M5, om, rho, 12 * Cdir, 90 * Cmed, 12 * Cdir + 90 * Cmed

recrows = {}
for line in open(sys.argv[2], encoding="utf-8"):
    p = line.split()
    if len(p) >= 9 and p[0][0] == "0":
        recrows[p[0]] = p
print("beta    ROW(seat formula, iii-43 road)   record ROW   |diff|        ROW(true constants)  T6_true   D5_true")
worst = Dm(0)
for bs in ["0.2000", "0.2200", "0.2300", "0.2400", "0.2410", "0.2415", "0.2420", "0.2440", "0.2450", "0.2460", "0.2500"]:
    b = Dm(bs)
    M5 = m(5 * b); M6 = m(6 * b)
    _, om, rho, d12, m90, R = row(bs, M5 * M5 / 3, M6 / 2)
    D5t = abs(D(5 * b)); T6t = abs(phi3(6 * b))
    Rt = row(bs, D5t, T6t)[5]
    rr = recrows.get(bs)
    rs = rr[7] if rr else "-"
    diff = abs(R - Dm(rs)) if rr else Dm(0)
    if diff > worst:
        worst = diff
    print(f"{bs}  {R:.9f}                     {rs:>9}   {diff:.2e}     {Rt:.6f}             {T6t:.6f}  {D5t:.6f}")
print(f"worst |diff| against the record over the shared rows: {worst:.2e}")
# the closing coupling under each set of constants, by bisection on [0.20, 0.26]
def close(f):
    lo, hi = Dm("0.20"), Dm("0.26")
    for _ in range(40):
        mid = (lo + hi) / 2
        if f(mid) < 1: lo = mid
        else: hi = mid
    return lo
bh = close(lambda b: row(b, m(5 * b) ** 2 / 3, m(6 * b) / 2)[5])
bt = close(lambda b: row(b, abs(D(5 * b)), abs(phi3(6 * b)))[5])
print(f"ROW = 1 at beta = {bh:.6f} (hand constants: Turan |D| <= m^2/3, T <= m/2)")
print(f"ROW = 1 at beta = {bt:.6f} (true constants: |D(5b)|, |phi'''(6b)|; the directional sup at c = 1)")
# the directional-sup claim: sup over c in [0,1] of |phi''' c^3 + 3(D/r) c (1-c^2)| equals |phi'''| at r = 6b
for bs in ["0.2410", "0.2440"]:
    r = 6 * Dm(bs)
    f3 = phi3(r); dr = D(r) / r
    best = max(abs(f3 * (Dm(i) / 1000) ** 3 + 3 * dr * (Dm(i) / 1000) * (1 - (Dm(i) / 1000) ** 2)) for i in range(1001))
    print(f"DIRSUP r = 6*{bs}: max_c |E(c)| = {best:.6f}, |phi'''| = {abs(f3):.6f}, m/2 = {m(r)/2:.6f}")
