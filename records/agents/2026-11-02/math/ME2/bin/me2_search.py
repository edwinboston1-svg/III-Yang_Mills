"""ME2: the anisotropic marginal sector of a skew block, over many rational rotations R (exact integer arithmetic).

For R = M/n (M integer, M^T M = n^2 I) and each signed permutation b, R^-1 b R = M^T b M / n^2.
G' = {b : R^-1 b R is a signed permutation}. For each distinct G' we compute the invariant symmetric forms on
Lambda^2 R^4 and their isotropic / theta / metric(1,1) / Weyl(2,0)+(0,2) ranks.
Stake (S-N): Weyl rank >= 1 for every R not in G2304 (R not in G2304 is tested by: R maps the 48 normalized F4 roots
into themselves? -> for rational R with an odd prime in the denominator this always fails; we test directly that
M has an entry not divisible by n, i.e. R is not a signed permutation, and that n has an odd prime factor).
Run: python -I me2_search.py <outfile>
"""
import sys
from fractions import Fraction as Fr
from itertools import permutations, product, combinations

def signed_perms():
    out = []
    for p in permutations(range(4)):
        for s in product((1, -1), repeat=4):
            m = [[0] * 4 for _ in range(4)]
            for j in range(4): m[p[j]][j] = s[j]
            out.append(tuple(tuple(r) for r in m))
    return out
SP = signed_perms(); SPset = set(SP)
def imul(A, B): return tuple(tuple(sum(A[i][k] * B[k][j] for k in range(4)) for j in range(4)) for i in range(4))
def iT(A): return tuple(tuple(A[j][i] for j in range(4)) for i in range(4))
def det(A):
    A = [list(map(Fr, r)) for r in A]; d = Fr(1)
    for c in range(4):
        p = next((i for i in range(c, 4) if A[i][c] != 0), None)
        if p is None: return 0
        if p != c: A[c], A[p] = A[p], A[c]; d = -d
        d *= A[c][c]
        for i in range(c + 1, 4):
            f = A[i][c] / A[c][c]; A[i] = [x - f * y for x, y in zip(A[i], A[c])]
    return d

def Gprime(M, n):
    MT = iT(M); n2 = n * n; G = []
    for b in SP:
        C = imul(imul(MT, b), M)
        if all(x % n2 == 0 for r in C for x in r):
            Cn = tuple(tuple(x // n2 for x in r) for r in C)
            if Cn in SPset: G.append(b)
    return G

pairs = [(0, 1), (0, 2), (0, 3), (1, 2), (1, 3), (2, 3)]
def wedge2(A): return [[A[i][k] * A[j][l] - A[i][l] * A[j][k] for (k, l) in pairs] for (i, j) in pairs]
def nullspace(rows, ncols):
    Mx = [list(map(Fr, r)) for r in rows]; piv = []; r = 0
    for c in range(ncols):
        p = next((i for i in range(r, len(Mx)) if Mx[i][c] != 0), None)
        if p is None: continue
        Mx[r], Mx[p] = Mx[p], Mx[r]; inv = 1 / Mx[r][c]; Mx[r] = [x * inv for x in Mx[r]]
        for i in range(len(Mx)):
            if i != r and Mx[i][c] != 0:
                f = Mx[i][c]; Mx[i] = [x - f * y for x, y in zip(Mx[i], Mx[r])]
        piv.append(c); r += 1
        if r == len(Mx): break
    free = [c for c in range(ncols) if c not in piv]; basis = []
    for f in free:
        v = [Fr(0)] * ncols; v[f] = Fr(1)
        for i, c in enumerate(piv): v[c] = -Mx[i][f]
        basis.append(v)
    return basis
sym_idx = [(a, b) for a in range(6) for b in range(a, 6)]
def inv_forms(G):
    rows = []
    for g in G:
        W = wedge2(g)
        for (i, j) in sym_idx:
            row = [Fr(0)] * 21
            for k in range(6):
                for l in range(6):
                    if W[k][i] and W[l][j]:
                        a, b = (k, l) if k <= l else (l, k)
                        row[sym_idx.index((a, b))] += W[k][i] * W[l][j]
            row[sym_idx.index((i, j))] -= 1
            rows.append(row)
    basis = nullspace(rows, 21); forms = []
    for v in basis:
        B = [[Fr(0)] * 6 for _ in range(6)]
        for n_, (a, b) in enumerate(sym_idx): B[a][b] = v[n_]; B[b][a] = v[n_]
        forms.append(B)
    return forms
star = [[Fr(0)] * 6 for _ in range(6)]
for src, dst, s in (((0, 1), (2, 3), 1), ((2, 3), (0, 1), 1), ((0, 2), (1, 3), -1), ((1, 3), (0, 2), -1), ((0, 3), (1, 2), 1), ((1, 2), (0, 3), 1)):
    star[pairs.index(dst)][pairs.index(src)] = Fr(s)
def mm(A, B): return [[sum(A[i][k] * B[k][j] for k in range(6)) for j in range(6)] for i in range(6)]
def madd(A, B, c=1): return [[A[i][j] + c * B[i][j] for j in range(6)] for i in range(6)]
def msc(A, c): return [[c * x for x in r] for r in A]
Id6 = [[Fr(int(i == j)) for j in range(6)] for i in range(6)]
Pp = msc(madd(Id6, star), Fr(1, 2)); Pm = msc(madd(Id6, star, -1), Fr(1, 2))
def decompose(B):
    Bpp = mm(mm(Pp, B), Pp); Bmm = mm(mm(Pm, B), Pm); Bpm = madd(mm(mm(Pp, B), Pm), mm(mm(Pm, B), Pp))
    tpp = sum(Bpp[i][i] for i in range(6)); tmm = sum(Bmm[i][i] for i in range(6))
    Wp = madd(Bpp, msc(Pp, tpp / 3), -1); Wm = madd(Bmm, msc(Pm, tmm / 3), -1)
    return [(tpp + tmm) / 6], [(tpp - tmm) / 6], [x for r in Bpm for x in r], [x for r in madd(Wp, Wm) for x in r]
def rank_of(vs):
    if not vs: return 0
    return len(vs) - len(nullspace([list(c) for c in zip(*vs)], len(vs)))
cache = {}
def sector(G):
    key = frozenset(G)
    if key not in cache:
        forms = inv_forms(G); parts = [decompose(B) for B in forms]
        cache[key] = (len(forms),) + tuple(rank_of([p[t] for p in parts]) for t in range(4))
    return cache[key]

def quat_L(a, b, c, d):   # integer matrix of left multiplication by a+bi+cj+dk
    return ((a, -b, -c, -d), (b, a, -d, c), (c, d, a, -b), (d, -c, b, a))
def quat_R(a, b, c, d):   # right multiplication
    return ((a, -b, -c, -d), (b, a, d, -c), (c, -d, a, b), (d, c, -b, a))
def reps(n):
    out = []
    r = int(n ** 0.5) + 1
    for a in range(-r, r + 1):
        for b in range(-r, r + 1):
            for c in range(-r, r + 1):
                d2 = n - a * a - b * b - c * c
                if d2 < 0: continue
                d = int(round(d2 ** 0.5))
                for dd in ({d, -d} if d else {0}):
                    if dd * dd == d2: out.append((a, b, c, dd))
    return sorted(set(out))

lines = []
def say(s): print(s); lines.append(s)
stats = {}
def test(name, M, n):
    MT = iT(M)
    assert imul(MT, M) == tuple(tuple(n * n * int(i == j) for j in range(4)) for i in range(4)), name
    if all(x % n == 0 for r in M for x in r): return None   # R integral -> signed permutation, skip
    G = Gprime(M, n); tot, iso, th, met, wey = sector(G)
    rev = sum(1 for g in G if det(g) < 0)
    key = (len(G), rev, tot, iso, th, met, wey)
    stats.setdefault(key, []).append(name)
    return key

# 1) left and right multiplications by unit quaternions of norm 9, 25, 169 (denominators 3, 5, 13)
for n in (3, 5, 13):
    for (a, b, c, d) in reps(n * n):
        test(f"L({a},{b},{c},{d})/{n}", quat_L(a, b, c, d), n)
        test(f"R({a},{b},{c},{d})/{n}", quat_R(a, b, c, d), n)
# 2) two-sided x -> alpha x beta / 25, alpha, beta of norm 25 (sample: all alpha with a>0 sorted, first 12 beta)
A25 = reps(25); B25 = A25[:: max(1, len(A25) // 12)]
for al in A25:
    for be in B25:
        M = imul(quat_L(*al), quat_R(*be)); test(f"L{al}R{be}/25", M, 25)
# 3) planar Pythagorean rotations in each coordinate plane, and double rotations in two orthogonal planes
pyth = [(3, 4, 5), (5, 12, 13), (8, 15, 17)]
def planar(i, j, c, s, n):
    M = [[n * int(r == t) for t in range(4)] for r in range(4)]
    M[i][i] = c; M[j][j] = c; M[i][j] = -s; M[j][i] = s
    return tuple(tuple(r) for r in M)
for (c, s, n) in pyth:
    for (i, j) in combinations(range(4), 2):
        test(f"planar({i}{j}) {c}/{n}", planar(i, j, c, s, n), n)
for (c, s, n) in pyth:
    for (c2, s2, n2) in pyth:
        # rotation in (01) by (c,s)/n and in (23) by (c2,s2)/n2 ; common denominator n*n2
        N = n * n2
        M = [[0] * 4 for _ in range(4)]
        M[0][0] = c * n2; M[1][1] = c * n2; M[0][1] = -s * n2; M[1][0] = s * n2
        M[2][2] = c2 * n; M[3][3] = c2 * n; M[2][3] = -s2 * n; M[3][2] = s2 * n
        test(f"double (01){c}/{n} (23){c2}/{n2}", tuple(tuple(r) for r in M), N)

say("ME2 skew-block marginal sector census. key = (|G'|, #orientation-reversing, dim inv forms, iso, theta, metric(1,1), Weyl)")
minW = min(k[6] for k in stats); minAniso = min(k[4] + k[5] + k[6] for k in stats)
for key in sorted(stats, key=lambda k: (k[4] + k[5] + k[6], -k[0])):
    say(f"  {key}: {len(stats[key])} rotations, e.g. {stats[key][:3]}")
say(f"minimum Weyl rank over all {sum(len(v) for v in stats.values())} rotations tested: {minW}")
say(f"minimum anisotropic (theta+metric+Weyl) rank: {minAniso}")
with open(sys.argv[1], "w", encoding="utf-8") as fh: fh.write("\n".join(lines) + "\n")
