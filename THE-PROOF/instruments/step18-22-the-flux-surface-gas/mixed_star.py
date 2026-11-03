# mixed_star.py -- EXACT mixed-spin star integrals on the PROJECTOR road (S1 section 24): spin-1 edges carry a 9-dim
# index (A,B) with chi_1(U_i^-1 U_j) = sum_{AB} R_i[A,B] R_j[A,B]; spin-1/2 edges carry a 4-dim index mu with
# chi_1/2(U_i^-1 U_j) = sum_mu (sqrt2 q_i^mu)(sqrt2 q_j^mu).  A vertex with d spin-1 legs and no sheet legs carries
# P_d = E[R^{(x)d}] (star_table's exact projector); a sheet vertex (two sheet legs mu, nu and d spin-1 legs) carries
#   T[mu,nu;A;B] = E[2 q^mu q^nu prod_j R_{A_j B_j}] = 1/2 delta_{mu nu} P_d[A;B] + sum_{CD} beta^{mu nu}_{CD} P_{d+1}[(C,A);(D,B)]
# by the identity 2 q^mu q^nu = 1/2 delta_{mu nu} + sum_{CD} beta^{mu nu}_{CD} R_{CD}(q) on the unit sphere (the nine
# traceless symmetric quadratics on R^4 are the entries of the rotation matrix; beta solved exactly over Q).
# Contraction: variable elimination over vertices with edge-indexed intermediates, modulo primes, CRT; refuses by
# name when an intermediate would exceed MAXCELLS.  Known answers run at load unless MIXED_NOKAT=1.
import itertools, math, os, sys
from fractions import Fraction
import numpy as np
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import star_table as st
H = Fraction(1, 2)
MAXCELLS = int(os.environ.get("MAXCELLS", "60000000"))
# ---- the rotation matrix's quadratic forms M_{CD} (R_{CD}(q) = q^T M_{CD} q, q = (a,b,c,d)) ----
def Mmats():
    M = {}
    def sym(pairs, diag=None):
        A = [[Fraction(0)]*4 for _ in range(4)]
        if diag:
            for i, s in enumerate(diag): A[i][i] = Fraction(s)
        for (i, j, s) in pairs: A[i][j] += Fraction(s); A[j][i] += Fraction(s)
        return A
    M[(0,0)] = sym([], (1, 1, -1, -1)); M[(1,1)] = sym([], (1, -1, 1, -1)); M[(2,2)] = sym([], (1, -1, -1, 1))
    M[(0,1)] = sym([(1,2,1),(0,3,-1)]); M[(0,2)] = sym([(1,3,1),(0,2,1)])
    M[(1,0)] = sym([(1,2,1),(0,3,1)]);  M[(1,2)] = sym([(2,3,1),(0,1,-1)])
    M[(2,0)] = sym([(1,3,1),(0,2,-1)]); M[(2,1)] = sym([(2,3,1),(0,1,1)])
    return M
MM = Mmats()
def solve_beta():
    """beta[(mu,nu)][(C,D)] with 2 E_sym(mu,nu) = 1/2 delta I + sum beta M_{CD} as 4x4 symmetric matrices"""
    keys = [(C, D) for C in range(3) for D in range(3)]
    # unknowns: 9 betas; equations: the 10 independent entries (i<=j) of the symmetric matrix identity
    cells = [(i, j) for i in range(4) for j in range(i, 4)]
    beta = {}
    for mu in range(4):
        for nu in range(4):
            # target T = 2 E_sym - 1/2 delta_{mu nu} I
            T = [[Fraction(0)]*4 for _ in range(4)]
            T[mu][nu] += Fraction(1); T[nu][mu] += Fraction(1)
            if mu == nu:
                for i in range(4): T[i][i] -= H
            # least-squares-free exact solve: 10 equations, 9 unknowns (consistent); Gaussian elimination
            A = [[MM[k][i][j] for k in keys] + [T[i][j]] for (i, j) in cells]
            n = len(keys); rows = A; piv = []
            r = 0
            for c in range(n):
                p = next((k for k in range(r, len(rows)) if rows[k][c] != 0), None)
                if p is None: continue
                rows[r], rows[p] = rows[p], rows[r]
                pv = rows[r][c]; rows[r] = [x / pv for x in rows[r]]
                for k in range(len(rows)):
                    if k != r and rows[k][c] != 0:
                        f = rows[k][c]; rows[k] = [x - f*y for x, y in zip(rows[k], rows[r])]
                piv.append(c); r += 1
            assert r == n, "beta system rank %d" % r
            for k in range(r, len(rows)): assert all(x == 0 for x in rows[k]), "beta system inconsistent"
            sol = [Fraction(0)]*n
            for k, c in enumerate(piv): sol[c] = rows[k][n]
            beta[(mu, nu)] = {keys[k]: sol[k] for k in range(n)}
    return beta
BETA = solve_beta()
# sanity: the identity at a few quaternions
def _check_beta():
    import random
    for _ in range(20):
        q = [Fraction(random.randint(-5, 5)) for _ in range(4)]
        nrm2 = sum(x*x for x in q)
        if nrm2 == 0: continue
        # work projectively: R_{CD}(q)/|q|^2 and 2 q q /|q|^2
        R = {k: sum(q[i]*MM[k][i][j]*q[j] for i in range(4) for j in range(4)) / nrm2 for k in MM}
        for mu in range(4):
            for nu in range(4):
                lhs = 2*q[mu]*q[nu] / nrm2
                rhs = (H if mu == nu else 0) + sum(BETA[(mu, nu)][k]*R[k] for k in MM)
                assert lhs == rhs, ("beta identity fails", mu, nu, lhs, rhs)
_check_beta()
TCACHE = {}
def vertex_tensor(nhalf, d):
    """integer tensor and denominator: axes = nhalf sheet legs (dim 4) then d spin-1 legs (dim 9)"""
    key = (nhalf, d)
    if key in TCACHE: return TCACHE[key]
    if nhalf == 0:
        N, den = st.projector(d)                       # N/den as a 3^d x 3^d matrix [A-vector; B-vector]
        X = np.zeros((9,)*d, dtype=object)
        for idx in itertools.product(range(9), repeat=d):
            A = tuple(i // 3 for i in idx); B = tuple(i % 3 for i in idx)
            ia = sum(a*3**(d-1-k) for k, a in enumerate(A)); ib = sum(b*3**(d-1-k) for k, b in enumerate(B))
            v = N[ia, ib]
            if v: X[idx] = v
        TCACHE[key] = (X, den); return TCACHE[key]
    assert nhalf == 2
    Nd, dend = st.projector(d); Nd1, dend1 = st.projector(d + 1)
    # common denominator: lcm(2*dend, dend1 * lcm of beta denominators)
    bden = 1
    for mn in BETA.values():
        for v in mn.values(): bden = bden*v.denominator // math.gcd(bden, v.denominator)
    den = 2*dend*dend1*bden   # a product, never an lcm: every term has a denominator dividing it
    X = np.zeros((4, 4) + (9,)*d, dtype=object)
    for idx in itertools.product(range(9), repeat=d):
        A = tuple(i // 3 for i in idx); B = tuple(i % 3 for i in idx)
        ia = sum(a*3**(d-1-k) for k, a in enumerate(A)); ib = sum(b*3**(d-1-k) for k, b in enumerate(B))
        base = Nd[ia, ib]                                   # P_d numerator
        for mu in range(4):
            for nu in range(4):
                val = Fraction(0)
                if mu == nu and base: val += H * Fraction(int(base), dend)
                for (C, D), b in BETA[(mu, nu)].items():
                    if b == 0: continue
                    ia1 = C*3**d + ia; ib1 = D*3**d + ib
                    v1 = Nd1[ia1, ib1]
                    if v1: val += b * Fraction(int(v1), dend1)
                if val:
                    num = val * den; assert num.denominator == 1
                    X[(mu, nu) + idx] = int(num)
    TCACHE[key] = (X, den); return TCACHE[key]
def _primes_below(n, count):
    out = []; x = n - 1
    while len(out) < count:
        if all(x % q for q in range(2, int(x ** 0.5) + 1)): out.append(x)
        x -= 2 if x % 2 else 1
    return out
# primes just below 2^20: residues < 2^20, products < 2^40, so a tensordot may sum up to 2^23 terms (9^7) without int64 overflow
PRIMES = _primes_below(1 << 20, 48)
def contract_mod(vt, edges, p):
    """vt: {v: (X, den)} with X's axes in the order of edges incident to v (as listed in `inc`); edges: list of (i, j, dim)"""
    inc = {}
    for k, (i, j, dim) in enumerate(edges):
        inc.setdefault(i, []).append(k); inc.setdefault(j, []).append(k)
    factors = []
    for v, (X, den) in vt.items():
        factors.append((tuple(inc[v]), np.array(X % p if X.dtype == object else X, dtype=np.int64) % p))
    # fix the axis order: vertex_tensor axes follow inc[v] by construction (caller guarantees)
    remaining = set(vt.keys())
    # elimination order: min open-cell count (greedy)
    while len(factors) > 1:
        best = None
        for a in range(len(factors)):
            for b in range(a+1, len(factors)):
                sh = [e for e in factors[a][0] if e in factors[b][0]]
                if not sh: continue
                opn = [e for e in factors[a][0] if e not in sh] + [e for e in factors[b][0] if e not in sh]
                cells = 1
                for e in opn: cells *= edges[e][2]
                if best is None or cells < best[0]: best = (cells, a, b, sh, opn)
        if best is None:
            # disconnected pieces: outer product of scalars at the end; take any two
            a, b = 0, 1; sh = []; opn = list(factors[a][0]) + list(factors[b][0]); cells = 1
            for e in opn: cells *= edges[e][2]
        else: cells, a, b, sh, opn = best
        if cells > MAXCELLS: raise MemoryError("REFUSED CELLS %d > %d (open edges %s)" % (cells, MAXCELLS, opn))
        ea, Xa = factors[a]; eb, Xb = factors[b]
        if sh:
            terms = 1
            for e in sh: terms *= edges[e][2]
            assert terms < (1 << 23), ("too many summed terms for int64 at 2^20 primes", terms)
            Z = np.tensordot(Xa, Xb, axes=([ea.index(e) for e in sh], [eb.index(e) for e in sh]))
            Z = Z % p
        else:
            Z = np.multiply.outer(Xa, Xb) % p
        factors = [f for k, f in enumerate(factors) if k not in (a, b)] + [(tuple(opn), Z)]
    (eo, Z) = factors[0]
    assert eo == (), eo
    return int(Z) % p
def star(spec, label="", quiet=False):
    """spec: list of edges (i, j, spin) with spin in {1/2, 1}; every vertex's sheet-leg count must be 0 or 2"""
    verts = sorted({v for e in spec for v in e[:2]}); ren = {v: k for k, v in enumerate(verts)}
    edges = [(ren[i], ren[j], 4 if Fraction(s) == H else 9) for (i, j, s) in spec]
    # per vertex: sheet legs first, then spin-1 legs: reorder edges so that inc[v] lists sheet edges first
    nh = {v: sum(1 for (i, j, dim) in edges if dim == 4 and v in (i, j)) for v in range(len(verts))}
    nd = {v: sum(1 for (i, j, dim) in edges if dim == 9 and v in (i, j)) for v in range(len(verts))}
    for v in range(len(verts)):
        assert nh[v] in (0, 2), ("a vertex must carry 0 or 2 sheet legs", v, nh[v])
    # build vertex tensors with axes in incidence order; incidence order must be: sheet edges first, then spin-1
    order = sorted(range(len(edges)), key=lambda k: (0 if edges[k][2] == 4 else 1, k))
    edges = [edges[k] for k in order]
    vt = {}; dens = 1
    for v in range(len(verts)):
        X, den = vertex_tensor(nh[v], nd[v]); vt[v] = (X, den); dens *= den
    # sum over at most 9^(shared) terms of products < 2^62 could overflow for shared >= 2 axes: use primes < 2^31 and
    # restrict: products < 2^62, sums over 9^k terms need k <= 1 for safety at 2^31 -> use smaller primes when needed
    bits = sum(math.log2(dim) for (_, _, dim) in edges) + sum(math.log2(max(1, int(np.max(np.abs(np.array(X, dtype=object)))) if X.size else 1)) for (X, _) in vt.values()) + 8
    used = []; have = 0.0
    for p in PRIMES:
        used.append(p); have += math.log2(p)
        if have > bits + 2: break
    res = [contract_mod(vt, edges, p) for p in used]
    X, m = st.star_integral.__globals__['crt'](res, used) if 'crt' in st.star_integral.__globals__ else crt(res, used)
    val = Fraction(X, dens)
    if not quiet:
        print("MIXED %-28s V=%d E=%2d  S = %s = %.10f" % (label, len(verts), len(edges), val, float(val)), flush=True)
    return val
def crt(residues, primes):
    x, m = 0, 1
    for r, p in zip(residues, primes):
        t = ((r - x) * pow(m, -1, p)) % p; x += m*t; m *= p
    return (x if x <= m//2 else x - m), m
if __name__ == "__main__" or os.environ.get("MIXED_NOKAT") != "1":
    if os.environ.get("MIXED_NOKAT") != "1":
        assert star([(0,1,H),(1,2,H),(2,0,H)], "C3(1/2) 1/2", quiet=True) == Fraction(1, 2)
        assert star([(0,1,H),(0,1,H),(0,1,1)], "chord 1", quiet=True) == 1
        assert star([(0,1,1),(1,2,1),(2,0,1)], "C3(1) 1/3", quiet=True) == Fraction(1, 3)
        assert star([(0,1,H),(1,2,H),(2,0,H),(3,0,1),(3,1,1),(3,2,1)], "W3 1/9", quiet=True) == Fraction(1, 9)
        assert star([(0,1,H),(1,2,H),(2,0,H),(0,1,1),(1,2,1),(2,0,1)], "chord triangle 3/4", quiet=True) == Fraction(3, 4)
        print("MIXED KAT: C3(1/2)=1/2, chord=1, C3(1)=1/3, W3=1/9, chord-triangle=3/4 -- all met", flush=True)
if __name__ == "__main__":
    star([(0,1,H),(1,2,H),(2,3,H),(3,0,H)] + [(4,i,1) for i in range(4)], "W4 7/108")
    C4 = [(0, 2, H), (2, 1, H), (1, 3, H), (3, 0, H)]
    K44 = [(r, o, 1) for r in (0, 1, 2, 3) for o in (4, 5, 6, 7)]
    star(C4 + K44, "C4(1/2)+K44 303479/5062500")
