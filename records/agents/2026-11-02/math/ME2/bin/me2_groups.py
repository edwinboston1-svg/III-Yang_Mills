"""ME2 group-theory checks, exact arithmetic (Fractions and Q(sqrt2)).

S-1  Lambda^2 R^4 absolutely irreducible under B4 (commutant dim 1); invariant symmetric forms dim 1.
S-2  finite overgroups of B4 inside G2304 = stabilizer of the 48 normalized F4 roots: orders 384, 1152, 2304 only;
     plus the double-coset structure.
S-3  q = (1+2i+2j+4k)/5: R = L_q orthogonal, 5R and 5R^-1 integral, cos(theta) = 1/5, R not in G2304,
     R^-1 B4 R not inside G2304.
S-4  [Z^4 : Z^4 cap R Z^4] (kernel of M^T mod 5).
S-5  G' = B4 cap R B4 R^-1 and the G'-invariant symmetric bilinear forms on Lambda^2, split into
     isotropic (F^2), theta (F wedge F), metric-type (1,1) and Weyl-type (2,0)+(0,2) components.
Run:  python -I me2_groups.py
"""
from fractions import Fraction as Fr
from itertools import permutations, product, combinations
import sys

# ---------------- Q(sqrt2) ----------------
class Q2:
    __slots__ = ("a", "b")
    def __init__(self, a, b=0):
        self.a = Fr(a); self.b = Fr(b)
    def __add__(s, o):
        o = o if isinstance(o, Q2) else Q2(o); return Q2(s.a + o.a, s.b + o.b)
    __radd__ = __add__
    def __neg__(s): return Q2(-s.a, -s.b)
    def __sub__(s, o):
        o = o if isinstance(o, Q2) else Q2(o); return Q2(s.a - o.a, s.b - o.b)
    def __mul__(s, o):
        o = o if isinstance(o, Q2) else Q2(o)
        return Q2(s.a * o.a + 2 * s.b * o.b, s.a * o.b + s.b * o.a)
    __rmul__ = __mul__
    def __eq__(s, o):
        o = o if isinstance(o, Q2) else Q2(o); return s.a == o.a and s.b == o.b
    def __hash__(s): return hash((s.a, s.b))
    def iszero(s): return s.a == 0 and s.b == 0
    def __repr__(s):
        return f"{s.a}" if s.b == 0 else f"({s.a}+{s.b}r2)"

ZERO, ONE = Q2(0), Q2(1)
R2INV = Q2(0, Fr(1, 2))          # 1/sqrt2 = sqrt2/2

def mat(rows): return tuple(tuple(x if isinstance(x, Q2) else Q2(x) for x in r) for r in rows)
def mmul(A, B):
    n, m, p = len(A), len(B), len(B[0])
    return tuple(tuple(sum((A[i][k] * B[k][j] for k in range(m)), ZERO) for j in range(p)) for i in range(n))
def mT(A): return tuple(tuple(A[j][i] for j in range(len(A))) for i in range(len(A[0])))
def mvec(A, v): return tuple(sum((A[i][k] * v[k] for k in range(len(v))), ZERO) for i in range(len(A)))
I4 = mat([[1 if i == j else 0 for j in range(4)] for i in range(4)])

# quaternion left/right multiplication in basis (1,i,j,k)
def qmul(p, q):
    a1, b1, c1, d1 = p; a2, b2, c2, d2 = q
    return (a1*a2 - b1*b2 - c1*c2 - d1*d2,
            a1*b2 + b1*a2 + c1*d2 - d1*c2,
            a1*c2 - b1*d2 + c1*a2 + d1*b2,
            a1*d2 + b1*c2 - c1*b2 + d1*a2)
def Lmat(q):
    cols = [qmul(q, e) for e in ((ONE, ZERO, ZERO, ZERO), (ZERO, ONE, ZERO, ZERO), (ZERO, ZERO, ONE, ZERO), (ZERO, ZERO, ZERO, ONE))]
    return tuple(tuple(cols[j][i] for j in range(4)) for i in range(4))
def Rmat(q):
    cols = [qmul(e, q) for e in ((ONE, ZERO, ZERO, ZERO), (ZERO, ONE, ZERO, ZERO), (ZERO, ZERO, ONE, ZERO), (ZERO, ZERO, ZERO, ONE))]
    return tuple(tuple(cols[j][i] for j in range(4)) for i in range(4))

# ---------------- the 48 normalized F4 roots = binary octahedral group 2O ----------------
pts = []
for i in range(4):
    for s in (1, -1):
        v = [ZERO] * 4; v[i] = Q2(s); pts.append(tuple(v))
for signs in product((1, -1), repeat=4):
    pts.append(tuple(Q2(Fr(s, 2)) for s in signs))
for i, j in combinations(range(4), 2):
    for si, sj in product((1, -1), repeat=2):
        v = [ZERO] * 4; v[i] = Q2(0, Fr(si, 2)); v[j] = Q2(0, Fr(sj, 2)); pts.append(tuple(v))
assert len(pts) == 48
pidx = {p: n for n, p in enumerate(pts)}

def as_perm(A):
    """permutation of the 48 points induced by A, or None if A does not preserve the set"""
    out = []
    for p in pts:
        w = mvec(A, p)
        if w not in pidx: return None
        out.append(pidx[w])
    return tuple(out)
def pcomp(p, q): return tuple(p[q[n]] for n in range(48))   # (p o q)
def closure(gens):
    e = tuple(range(48)); seen = {e}; frontier = [e]
    while frontier:
        nf = []
        for x in frontier:
            for g in gens:
                y = pcomp(g, x)
                if y not in seen: seen.add(y); nf.append(y)
        frontier = nf
    return seen

out = []
def say(s=""):
    print(s); out.append(s)

# B4 generators: transposition (01), 4-cycle, sign change
def permmat(sig):
    return mat([[1 if sig[j] == i else 0 for j in range(4)] for i in range(4)])
t01 = permmat((1, 0, 2, 3)); c4 = permmat((1, 2, 3, 0)); s0 = mat([[-1 if (i == j == 0) else (1 if i == j else 0) for j in range(4)] for i in range(4)])
B4gens = [as_perm(m) for m in (t01, c4, s0)]
B4 = closure(B4gens)
# W(F4): add reflection in h = (1,1,1,1)/2 : I - 2 h h^T = I - (1/2) J
sh = mat([[Fr(1) - Fr(1, 2) if i == j else -Fr(1, 2) for j in range(4)] for i in range(4)])
WF4 = closure(B4gens + [as_perm(sh)])
# G2304: add left multiplication by (1+i)/sqrt2
Lsw = Lmat((R2INV, R2INV, ZERO, ZERO))
G = closure(B4gens + [as_perm(sh), as_perm(Lsw)])
say(f"S-2  |B4| = {len(B4)}, |W(F4)| = {len(WF4)}, |G2304| = {len(G)}")

# all subgroups K with B4 <= K <= G2304: K is a union of left cosets gB4; enumerate all 2^5 unions
B4f = frozenset(B4)
cosets = []; covered = set(B4)
for g in sorted(G):
    if g in covered: continue
    cs = frozenset(pcomp(g, b) for b in B4)
    cosets.append((g, cs)); covered |= cs
say(f"S-2  number of left cosets of B4 in G2304 (besides B4): {len(cosets)}")
subgroups = {}
for r in range(len(cosets) + 1):
    for S in combinations(range(len(cosets)), r):
        U = set(B4f)
        for i in S: U |= cosets[i][1]
        K = closure(B4gens + [cosets[i][0] for i in S])
        if K == U: subgroups[frozenset(K)] = S
orders = sorted(len(K) for K in subgroups)
say(f"S-2  subgroups K with B4 <= K <= G2304: {len(subgroups)}, orders {orders}")
say(f"     W(F4) among them: {frozenset(WF4) in subgroups}; G2304 among them: {frozenset(G) in subgroups}")
# double cosets B4 g B4
dcs = []; seen_dc = set(B4)
for g in sorted(G):
    if g in seen_dc: continue
    D = set(pcomp(pcomp(b1, g), b2) for b1 in B4 for b2 in B4)
    dcs.append(len(D)); seen_dc |= D
say(f"     double cosets B4\\G2304/B4 besides B4: sizes {dcs}")

# ---------------- Lambda^2 and its forms ----------------
pairs = [(0, 1), (0, 2), (0, 3), (1, 2), (1, 3), (2, 3)]
def wedge2(A):
    """6x6 matrix of Lambda^2(A) in basis e_i ^ e_j (i<j)"""
    M = []
    for (i, j) in pairs:
        row = []
        for (k, l) in pairs:
            row.append(A[i][k] * A[j][l] - A[i][l] * A[j][k])
        M.append(row)
    return tuple(tuple(r) for r in M)

def nullspace(rows, ncols):
    """rational nullspace of a list of rows (each a list of Fractions); returns basis vectors"""
    Mx = [list(r) for r in rows]
    piv = []; r = 0
    for c in range(ncols):
        p = None
        for i in range(r, len(Mx)):
            if Mx[i][c] != 0: p = i; break
        if p is None: continue
        Mx[r], Mx[p] = Mx[p], Mx[r]
        inv = 1 / Mx[r][c]; Mx[r] = [x * inv for x in Mx[r]]
        for i in range(len(Mx)):
            if i != r and Mx[i][c] != 0:
                f = Mx[i][c]; Mx[i] = [x - f * y for x, y in zip(Mx[i], Mx[r])]
        piv.append(c); r += 1
        if r == len(Mx): break
    free = [c for c in range(ncols) if c not in piv]
    basis = []
    for f in free:
        v = [Fr(0)] * ncols; v[f] = Fr(1)
        for i, c in enumerate(piv): v[c] = -Mx[i][f]
        basis.append(v)
    return basis

def rat(x):
    assert x.b == 0, "irrational entry"; return x.a

def commutant_dim(mats):
    # unknown X (6x6): X W - W X = 0 for all W
    rows = []
    for W in mats:
        Wr = [[rat(x) for x in r] for r in W]
        for i in range(6):
            for j in range(6):
                row = [Fr(0)] * 36
                for k in range(6):
                    row[i * 6 + k] += Wr[k][j]      # (X W)_{ij} = sum_k X_ik W_kj
                    row[k * 6 + j] -= Wr[i][k]      # (W X)_{ij} = sum_k W_ik X_kj
                rows.append(row)
    return len(nullspace(rows, 36))

sym_idx = [(a, b) for a in range(6) for b in range(a, 6)]   # 21 coordinates of a symmetric 6x6 B
def invariant_forms(mats):
    # B = W^T B W for all W ; unknown symmetric B
    rows = []
    for W in mats:
        Wr = [[rat(x) for x in r] for r in W]
        for (i, j) in sym_idx:
            row = [Fr(0)] * 21
            # (W^T B W)_{ij} - B_{ij} = sum_{k,l} W_ki B_kl W_lj - B_ij
            for k in range(6):
                for l in range(6):
                    a, b = (k, l) if k <= l else (l, k)
                    row[sym_idx.index((a, b))] += Wr[k][i] * Wr[l][j]
            row[sym_idx.index((i, j))] -= 1
            rows.append(row)
    basis = nullspace(rows, 21)
    out_b = []
    for v in basis:
        B = [[Fr(0)] * 6 for _ in range(6)]
        for n, (a, b) in enumerate(sym_idx):
            B[a][b] = v[n]; B[b][a] = v[n]
        out_b.append(B)
    return out_b

# Hodge star on Lambda^2 R^4 (Euclidean): *(e0^e1) = e2^e3, *(e0^e2) = -e1^e3, *(e0^e3) = e1^e2, and *^2 = 1
star = [[Fr(0)] * 6 for _ in range(6)]
def setstar(src, dst, sgn):
    star[pairs.index(dst)][pairs.index(src)] = Fr(sgn)
setstar((0, 1), (2, 3), 1); setstar((2, 3), (0, 1), 1)
setstar((0, 2), (1, 3), -1); setstar((1, 3), (0, 2), -1)
setstar((0, 3), (1, 2), 1); setstar((1, 2), (0, 3), 1)
def mm(A, B): return [[sum(A[i][k] * B[k][j] for k in range(len(B))) for j in range(len(B[0]))] for i in range(len(A))]
def madd(A, B, c=1): return [[A[i][j] + c * B[i][j] for j in range(len(A[0]))] for i in range(len(A))]
def mscale(A, c): return [[c * x for x in r] for r in A]
Id6 = [[Fr(1 if i == j else 0) for j in range(6)] for i in range(6)]
assert mm(star, star) == Id6
Pp = mscale(madd(Id6, star), Fr(1, 2)); Pm = mscale(madd(Id6, star, -1), Fr(1, 2))

def decompose(B):
    """split a symmetric form B on Lambda^2 into isotropic, theta, metric (1,1), Weyl (2,0)+(0,2) parts"""
    Bpp = mm(mm(Pp, B), Pp); Bmm = mm(mm(Pm, B), Pm)
    Bpm = madd(mm(mm(Pp, B), Pm), mm(mm(Pm, B), Pp))
    tpp = sum(Bpp[i][i] for i in range(6)); tmm = sum(Bmm[i][i] for i in range(6))
    iso = (tpp + tmm) / 6; th = (tpp - tmm) / 6
    Wp = madd(Bpp, mscale(Pp, tpp / 3), -1); Wm = madd(Bmm, mscale(Pm, tmm / 3), -1)
    weyl = madd(Wp, Wm)
    return iso, th, Bpm, weyl

def rank_of(vectors):
    """rank of a list of vectors: (number of vectors) - (dim of linear relations among them)"""
    if not vectors: return 0
    relation_rows = [list(c) for c in zip(*vectors)]      # coordinate rows; unknowns = coefficients
    return len(vectors) - len(nullspace(relation_rows, len(vectors)))

def analyse(name, groupmats):
    W = [wedge2(A) for A in groupmats]
    cd = commutant_dim(W)
    forms = invariant_forms(W)
    isos, ths, mets, weyls = [], [], [], []
    for B in forms:
        iso, th, met, weyl = decompose(B)
        isos.append([iso]); ths.append([th]); mets.append([x for r in met for x in r]); weyls.append([x for r in weyl for x in r])
    say(f"{name}: commutant dim on Lambda^2 = {cd}; invariant symmetric forms dim = {len(forms)}; "
        f"rank of components: isotropic {rank_of(isos)}, theta {rank_of(ths)}, metric(1,1) {rank_of(mets)}, Weyl(2,0)+(0,2) {rank_of(weyls)}")
    return cd, len(forms)

# matrices of B4 (rational)
def perm_to_mat(p):
    # recover the 4x4 matrix from the action on e_i (points 0..7 are +-e_i in order e0,-e0,e1,-e1,...)
    cols = []
    for i in range(4):
        cols.append(pts[p[2 * i]])
    return tuple(tuple(cols[j][i] for j in range(4)) for i in range(4))
B4mats = [perm_to_mat(p) for p in B4]
analyse("S-1  B4", B4mats)
analyse("     W(F4)", [perm_to_mat(p) for p in WF4])

# ---------------- the rotation R = L_q, q = (1+2i+2j+4k)/5 ----------------
def analyse_R(name, R):
    RT = mT(R)
    assert mmul(RT, R) == I4, "not orthogonal"
    five = any(x.a.denominator not in (1, 2, 4) or x.b != 0 for r in R for x in r)
    inG = as_perm(R) is not None
    # R^-1 B4 R inside G2304?
    conj_out = sum(1 for A in B4mats if as_perm(mmul(mmul(RT, A), R)) is None)
    # G' = B4 cap R B4 R^-1 : b in B4 with R^-1 b R signed permutation
    def is_signed_perm(A):
        for r in A:
            nz = [x for x in r if not x.iszero()]
            if len(nz) != 1 or not (nz[0] == ONE or nz[0] == Q2(-1)): return False
        return True
    Gp = [A for A in B4mats if is_signed_perm(mmul(mmul(RT, A), R))]
    ndet = sum(1 for A in Gp if det4(A) == Q2(-1))
    say(f"{name}: R not in G2304: {not inG}; #b in B4 with R^-1 b R outside G2304: {conj_out}/384; |G'| = {len(Gp)} "
        f"(orientation-reversing: {ndet})")
    analyse(f"     G' for {name}", Gp)
    return Gp

def det4(A):
    # Laplace expansion exact
    def det(M):
        n = len(M)
        if n == 1: return M[0][0]
        s = ZERO
        for j in range(n):
            if M[0][j].iszero(): continue
            minor = [row[:j] + row[j + 1:] for row in M[1:]]
            term = M[0][j] * det(minor)
            s = s + term if j % 2 == 0 else s - term
        return s
    return det([list(r) for r in A])

f5 = Fr(1, 5)
q = (Q2(f5), Q2(2 * f5), Q2(2 * f5), Q2(4 * f5))
R = Lmat(q)
say("S-3  R = L_q, q = (1+2i+2j+4k)/5:")
say("     5R = " + str([[int(5 * x.a) for x in r] for r in R]))
say("     5R^-1 = 5R^T = " + str([[int(5 * x.a) for x in r] for r in mT(R)]))
say(f"     trace R = {sum((R[i][i] for i in range(4)), ZERO)} (= 4 cos theta, cos theta = 1/5)")
Gp = analyse_R("L_q", R)

# S-4 index of Z^4 cap R Z^4 : x with M^T x = 0 mod 5
M = [[int(5 * x.a) for x in r] for r in R]
MT = [[M[j][i] % 5 for j in range(4)] for i in range(4)]
def rank_mod_p(A, p):
    A = [r[:] for r in A]; rk = 0; rows = len(A); cols = len(A[0])
    for c in range(cols):
        piv = None
        for i in range(rk, rows):
            if A[i][c] % p: piv = i; break
        if piv is None: continue
        A[rk], A[piv] = A[piv], A[rk]
        inv = pow(A[rk][c], p - 2, p)
        A[rk] = [(x * inv) % p for x in A[rk]]
        for i in range(rows):
            if i != rk and A[i][c] % p:
                f = A[i][c]; A[i] = [(x - f * y) % p for x, y in zip(A[i], A[rk])]
        rk += 1
    return rk
rk = rank_mod_p(MT, 5)
say(f"S-4  rank of M^T mod 5 = {rk}; [Z^4 : Z^4 cap R Z^4] = 5^{rk} = {5 ** rk}; [Z^4 : 5Z^4] = 625")
# count points of R Z^4 in the centred cube [-5/2, 5/2)^4 : x = R n
cnt = 0
for n in product(range(-6, 7), repeat=4):
    x = [sum(Fr(M[i][k]) * n[k] for k in range(4)) / 5 for i in range(4)]
    if all(Fr(-5, 2) <= xi < Fr(5, 2) for xi in x): cnt += 1
say(f"     points of R(Z^4) in the centred cube [-5/2,5/2)^4: {cnt} (one block type: 5Z^4 <= R Z^4)")

# other choices of R
fr = Fr
Rp = mat([[fr(3, 5), fr(-4, 5), 0, 0], [fr(4, 5), fr(3, 5), 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]])
analyse_R("planar rotation (3/5,4/5) in (01)", Rp)
u = (ZERO, Q2(fr(3, 5)), Q2(fr(4, 5)), ZERO)
analyse_R("L_u, u=(3i+4j)/5 (order 4)", Lmat(u))
q3 = (Q2(fr(1, 3)), Q2(fr(2, 3)), Q2(fr(2, 3)), ZERO)
analyse_R("L_q3, q3=(1+2i+2j)/3 (L = 3)", Lmat(q3))
# two-sided: x -> q x q'  (q' = (1+2i+2j+4k)/5 conjugate pattern)
qb = (Q2(f5), Q2(-2 * f5), Q2(-4 * f5), Q2(2 * f5))
analyse_R("x -> q x qb' (two-sided)", mmul(Lmat(q), Rmat(qb)))

with open(sys.argv[1] if len(sys.argv) > 1 else "me2_groups_run.txt", "w", encoding="utf-8") as fh:
    fh.write("\n".join(out) + "\n")
