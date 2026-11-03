"""ME2b P-1..P-3: the marginal sector of the PLANAR skew block, exact rational arithmetic.

R = rotation by arctan(4/3) in the (0,1)-plane (5R integral).  G' = B4 cap R B4 R^-1.
P-1  |G'|, orientation-reversing count, structure.
P-2  G'-invariant symmetric bilinear forms on Lambda^2 R^4: dimension, diagonality in the e_mu^e_nu basis,
     decomposition into isotropic / theta / metric (1,1) / Weyl (2,0)+(0,2).
P-3  S4-irreducible summand of each diagonal invariant (trivial / standard / two-dimensional), and the sign
     subgroup's characters on off-diagonal pairs.
Run:  python -I me2b_planar.py
"""
from fractions import Fraction as Fr
from itertools import permutations, product, combinations

def mmul(A, B):
    return [[sum(A[i][k] * B[k][j] for k in range(len(B))) for j in range(len(B[0]))] for i in range(len(A))]
def mT(A): return [list(r) for r in zip(*A)]
def key(A): return tuple(tuple(r) for r in A)
def det4(A):
    # Laplace expansion, exact
    def det(M):
        if len(M) == 1: return M[0][0]
        return sum(((-1) ** j) * M[0][j] * det([r[:j] + r[j+1:] for r in M[1:]]) for j in range(len(M)))
    return det(A)

# --- B4: signed permutation matrices ---
B4 = []
for perm in permutations(range(4)):
    for signs in product((1, -1), repeat=4):
        M = [[Fr(0)] * 4 for _ in range(4)]
        for i in range(4): M[perm[i]][i] = Fr(signs[i])
        B4.append(M)
B4set = {key(M) for M in B4}
assert len(B4) == 384

c, s = Fr(3, 5), Fr(4, 5)
R = [[c, -s, 0, 0], [s, c, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]]
R = [[Fr(x) for x in r] for r in R]
RT = mT(R)
assert mmul(RT, R) == [[Fr(int(i == j)) for j in range(4)] for i in range(4)]
assert all((5 * x).denominator == 1 for r in R for x in r)

Gp = [b for b in B4 if key(mmul(RT, mmul(b, R))) in B4set]
nrev = sum(1 for g in Gp if det4(g) == -1)
print(f"P-1  |G'| = {len(Gp)}, orientation-reversing = {nrev}")
# structure: does G' preserve the (0,1)-plane and the (2,3)-plane?
pres = all(g[i][j] == 0 for g in Gp for i in (0, 1) for j in (2, 3)) and all(g[i][j] == 0 for g in Gp for i in (2, 3) for j in (0, 1))
blk01 = {key([r[:2] for r in g[:2]]) for g in Gp}
blk23 = {key([r[2:] for r in g[2:]]) for g in Gp}
dets01 = sorted({det4([[g[0][0], g[0][1], 0, 0], [g[1][0], g[1][1], 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]]) for g in Gp})
print(f"     preserves (01) and (23) planes: {pres}; |block01| = {len(blk01)} (dets {dets01}), |block23| = {len(blk23)}, "
      f"product order {len(blk01) * len(blk23)}")

# --- Lambda^2 ---
pairs = list(combinations(range(4), 2))           # (0,1),(0,2),(0,3),(1,2),(1,3),(2,3)
def L2(g):
    # (L2 g)_{(rs),(mn)} = g_rm g_sn - g_sm g_rn
    return [[g[r][m] * g[s_][n] - g[s_][m] * g[r][n] for (m, n) in pairs] for (r, s_) in pairs]

# unknown symmetric 6x6 form B: 21 unknowns; invariance (L2 g)^T B (L2 g) = B
idx = [(i, j) for i in range(6) for j in range(i, 6)]
def Bfrom(vec):
    B = [[Fr(0)] * 6 for _ in range(6)]
    for t, (i, j) in enumerate(idx):
        B[i][j] = vec[t]; B[j][i] = vec[t]
    return B
rows = []
for g in Gp:
    Lg = L2(g)
    for t0 in range(21):
        e = [Fr(int(t == t0)) for t in range(21)]
        Bt = mmul(mT(Lg), mmul(Bfrom(e), Lg))
        # column t0 of the linear map vec -> (Lg^T B Lg - B)
        rows.append((t0, [Bt[i][j] - (Bfrom(e)[i][j]) for (i, j) in idx]))
# assemble matrix A (rows = conditions) acting on vec
A = []
nG = len(Gp)
for gi in range(nG):
    block = rows[gi * 21:(gi + 1) * 21]
    for comp in range(21):
        A.append([block[t0][1][comp] for t0 in range(21)])
# nullspace by exact Gaussian elimination
def nullspace(M, ncols):
    M = [r[:] for r in M]
    piv = []; r = 0
    for col in range(ncols):
        p = next((i for i in range(r, len(M)) if M[i][col] != 0), None)
        if p is None: continue
        M[r], M[p] = M[p], M[r]
        inv = 1 / M[r][col]
        M[r] = [x * inv for x in M[r]]
        for i in range(len(M)):
            if i != r and M[i][col] != 0:
                f = M[i][col]; M[i] = [a - f * b for a, b in zip(M[i], M[r])]
        piv.append(col); r += 1
        if r == len(M): break
    free = [cc for cc in range(ncols) if cc not in piv]
    basis = []
    for fcol in free:
        v = [Fr(0)] * ncols; v[fcol] = Fr(1)
        for i, pc in enumerate(piv):
            v[pc] = -M[i][fcol]
        basis.append(v)
    return basis
NS = nullspace(A, 21)
print(f"P-2  dim of G'-invariant symmetric forms on Lambda^2 = {len(NS)}")
diag_all = True
for v in NS:
    B = Bfrom(v)
    off = [(pairs[i], pairs[j], B[i][j]) for i in range(6) for j in range(6) if i < j and B[i][j] != 0]
    if off: diag_all = False
    print("     basis form, diagonal entries w_{mn}:", {f"{pairs[i][0]}{pairs[i][1]}": str(B[i][i]) for i in range(6)},
          "off-diagonal:", [(f"{a[0]}{a[1]}", f"{b[0]}{b[1]}", str(x)) for a, b, x in off])
print(f"     every invariant form diagonal: {diag_all}")

# --- decomposition: iso, theta, metric(h traceless), Weyl = complement ---
def form_metric(h):
    d = lambda a, b: Fr(int(a == b))
    return [[h[m][r] * d(n, s_) - h[m][s_] * d(n, r) - h[n][r] * d(m, s_) + h[n][s_] * d(m, r)
             for (r, s_) in pairs] for (m, n) in pairs]
Iso = [[Fr(int(i == j)) for j in range(6)] for i in range(6)]
eps = {(0, 1, 2, 3): 1}
def levi(a, b, cc, d):
    p = [a, b, cc, d]
    if len(set(p)) < 4: return 0
    sgn = 1
    for i in range(4):
        for j in range(i + 1, 4):
            if p[i] > p[j]: sgn = -sgn
    return sgn
Theta = [[Fr(levi(m, n, r, s_)) for (r, s_) in pairs] for (m, n) in pairs]
metric_basis = []
for (a, b) in [(i, j) for i in range(4) for j in range(i, 4)]:
    h = [[Fr(0)] * 4 for _ in range(4)]
    h[a][b] += 1; h[b][a] += 1 if a != b else 0
    if a == b:
        h[a][b] = Fr(1)
    metric_basis.append(h)
# make traceless: subtract trace part
mb = []
for h in metric_basis:
    tr = sum(h[i][i] for i in range(4))
    hh = [[h[i][j] - (tr / 4 if i == j else 0) for j in range(4)] for i in range(4)]
    mb.append(form_metric(hh))
def ip(B1, B2): return sum(B1[i][j] * B2[i][j] for i in range(6) for j in range(6))
def flat(B): return [B[i][j] for (i, j) in idx]
# rank of metric span (should be 9) and orthogonality to Iso, Theta
def rank(vecs):
    M = [v[:] for v in vecs]; r = 0
    ncol = len(M[0]) if M else 0
    for col in range(ncol):
        p = next((i for i in range(r, len(M)) if M[i][col] != 0), None)
        if p is None: continue
        M[r], M[p] = M[p], M[r]
        for i in range(len(M)):
            if i != r and M[i][col] != 0:
                f = M[i][col] / M[r][col]; M[i] = [x - f * y for x, y in zip(M[i], M[r])]
        r += 1
    return r
print(f"     rank(metric forms) = {rank([flat(B) for B in mb])}, <Iso,metric> = {[str(ip(Iso,B)) for B in mb[:3]]}..., "
      f"<Theta,metric> = {sorted({str(ip(Theta,B)) for B in mb})}")
# components of each invariant
sub_iso_theta_metric = [flat(Iso), flat(Theta)] + [flat(B) for B in mb]
r_itm = rank(sub_iso_theta_metric)
for v in NS:
    B = Bfrom(v)
    ci, ct = ip(B, Iso), ip(B, Theta)
    in_itm = rank(sub_iso_theta_metric + [flat(B)]) == r_itm
    print(f"     invariant: <B,Iso> = {ci}, <B,Theta> = {ct}, lies in iso+theta+metric span: {in_itm}")
# explicit stake checks
w_metric = {(0, 1): 2, (2, 3): -2}
w_weyl = {(0, 1): 1, (2, 3): 1, (0, 2): Fr(-1, 2), (0, 3): Fr(-1, 2), (1, 2): Fr(-1, 2), (1, 3): Fr(-1, 2)}
def diagform(w): return [[Fr(w.get(pairs[i], 0)) if i == j else Fr(0) for j in range(6)] for i in range(6)]
span = [flat(Bfrom(v)) for v in NS]
for name, w in (("metric stake", w_metric), ("Weyl stake", w_weyl)):
    B = diagform(w)
    print(f"     {name}: in invariant span: {rank(span + [flat(B)]) == len(NS)}; "
          f"in iso+theta+metric span: {rank(sub_iso_theta_metric + [flat(B)]) == r_itm}; <B,Iso> = {ip(B, Iso)}")
# Weyl stake orthogonal to all metric forms?
B = diagform(w_weyl)
print(f"     Weyl stake orthogonal to every metric form: {all(ip(B, M) == 0 for M in mb)}; to Theta: {ip(B, Theta) == 0}")
B = diagform(w_metric)
hst = [[Fr(1), 0, 0, 0], [0, Fr(1), 0, 0], [0, 0, Fr(-1), 0], [0, 0, 0, Fr(-1)]]
FM = form_metric(hst)
print(f"     metric stake equals form_metric(h=(1,1,-1,-1)) up to scale: "
      f"{all(FM[i][j] * B[0][0] == B[i][j] * FM[0][0] for i in range(6) for j in range(6))} (FM diag = {[str(FM[i][i]) for i in range(6)]})")

# --- P-3: S4 summands of diagonal forms; sign characters of off-diagonal pairs ---
def s4_component(w):
    # w: dict pair->value on 6 pairs. trivial = mean; standard: span h_m + h_n (sum h = 0); two-dim: sum_n w_mn = 0 for all m
    vals = [Fr(w.get(p, 0)) for p in pairs]
    mean = sum(vals) / 6
    rowsum = [sum(Fr(w.get(tuple(sorted((m, n))), 0)) for n in range(4) if n != m) for m in range(4)]
    return mean, rowsum
for name, w in (("metric", w_metric), ("Weyl", w_weyl)):
    mean, rs = s4_component(w)
    print(f"P-3  {name} invariant: mean (trivial part) = {mean}, row sums sum_n w_mn = {[str(x) for x in rs]}")
# standard summand membership for metric: w_mn = h_m + h_n with sum h = 0 -> solve h from w
# two-dim summand membership for Weyl: row sums all zero and mean zero
offchar = []
for i in range(6):
    for j in range(i + 1, 6):
        (m, n), (r, s_) = pairs[i], pairs[j]
        cnt = [ [m, n, r, s_].count(t) % 2 for t in range(4)]
        offchar.append(any(cnt))
print(f"     every off-diagonal pair carries a non-trivial sign character: {all(offchar)} ({len(offchar)} pairs)")
