# MG instrument A: exact Lie data (Weyl dimension formula, Casimirs, Dynkin indices) for the compact simple groups used in WORK.md.
# Exact rational arithmetic throughout. Normalisation: long roots of length^2 2, so C2(theta) = h_dual and T(rho) = d C2 / dim G.
from fractions import Fraction as Fr
import sys

def F(*xs): return tuple(Fr(x) for x in xs)
def dot(a, b): return sum(x*y for x, y in zip(a, b))
def add(a, b): return tuple(x+y for x, y in zip(a, b))
def sub(a, b): return tuple(x-y for x, y in zip(a, b))
def scl(c, a): return tuple(c*x for x in a)

def e(n, i, c=1):
    v = [Fr(0)]*n; v[i] = Fr(c); return tuple(v)

def simple_roots(typ, n):
    if typ == 'A':  # e_i - e_{i+1} in R^{n+1}
        return [sub(e(n+1, i), e(n+1, i+1)) for i in range(n)]
    if typ == 'B':  # e_i - e_{i+1}, e_n ; long length^2 2
        return [sub(e(n, i), e(n, i+1)) for i in range(n-1)] + [e(n, n-1)]
    if typ == 'C':  # (e_i - e_{i+1})/sqrt2 ... use 2e_n long: scale so long roots length^2 2
        r = [sub(e(n, i), e(n, i+1)) for i in range(n-1)] + [scl(2, e(n, n-1))]
        return [scl(Fr(1, 2), x) for x in r] if False else r  # rescaled below
    if typ == 'D':
        return [sub(e(n, i), e(n, i+1)) for i in range(n-1)] + [add(e(n, n-2), e(n, n-1))]
    if typ == 'G':  # in the plane x+y+z=0: short e1-e2, long -2e1+e2+e3 ; rescaled below
        return [F(1, -1, 0), F(-2, 1, 1)]
    if typ == 'F':
        h = Fr(1, 2)
        return [F(0, 1, -1, 0), F(0, 0, 1, -1), F(0, 0, 0, 1), (h, -h, -h, -h)]
    if typ == 'E':  # Bourbaki E8 realisation; E6, E7 are the first 6, 7 simple roots
        h = Fr(1, 2)
        a = [(h, -h, -h, -h, -h, -h, -h, h), add(e(8, 0), e(8, 1)), sub(e(8, 1), e(8, 0)), sub(e(8, 2), e(8, 1)),
             sub(e(8, 3), e(8, 2)), sub(e(8, 4), e(8, 3)), sub(e(8, 5), e(8, 4)), sub(e(8, 6), e(8, 5))]
        return a[:n]
    raise ValueError(typ)

def normalise(roots):
    # rescale the inner product so that the longest simple root has length^2 2 (returns a scale factor for dot)
    m = max(dot(r, r) for r in roots)
    return Fr(2) / m

def reflect(v, a, s):
    # s_a(v) = v - 2 (v,a)/(a,a) a  (scale s cancels)
    return sub(v, scl(Fr(2) * dot(v, a) / dot(a, a), a))

def positive_roots(simple):
    roots = set(simple); frontier = list(simple)
    while frontier:
        new = []
        for r in frontier:
            for a in simple:
                t = reflect(r, a, 1)
                if t not in roots:
                    roots.add(t); new.append(t)
        frontier = new
    # positivity: express in simple-root coordinates via a generic functional: use height via solving is costly;
    # instead pick a functional positive on simple roots: the vector rho_dual = sum of fundamental coweights ~ use Gram solve
    return roots

def solve(M, b):
    n = len(M); A = [list(M[i]) + [b[i]] for i in range(n)]
    for c in range(n):
        p = next(r for r in range(c, n) if A[r][c] != 0); A[c], A[p] = A[p], A[c]
        piv = A[c][c]; A[c] = [x / piv for x in A[c]]
        for r in range(n):
            if r != c and A[r][c] != 0:
                f = A[r][c]; A[r] = [x - f*y for x, y in zip(A[r], A[c])]
    return [A[i][n] for i in range(n)]

def data(typ, n):
    S = simple_roots(typ, n)
    s = normalise(S)
    ip = lambda a, b: s * dot(a, b)
    allr = positive_roots(S)
    G = [[ip(a, b) for b in S] for a in S]
    # coordinates of a root in the simple basis: solve G c = ((r, a_j))_j
    def coords(r): return solve(G, [ip(r, a) for a in S])
    pos = [r for r in allr if all(c >= 0 for c in coords(r))]
    # fundamental weights: (w_i, a_j^vee) = delta_ij, a^vee = 2a/(a,a); w_i = sum_k x_k a_k
    W = []
    for i in range(n):
        rhs = [Fr(1 if j == i else 0) * ip(S[j], S[j]) / 2 for j in range(n)]
        x = solve(G, rhs)
        w = tuple(Fr(0) for _ in S[0])
        for k in range(n): w = add(w, scl(x[k], S[k]))
        W.append(w)
    delta = tuple(Fr(0) for _ in S[0])
    for w in W: delta = add(delta, w)
    def weight(m):
        v = tuple(Fr(0) for _ in S[0])
        for k in range(n): v = add(v, scl(Fr(m[k]), W[k]))
        return v
    def dim(m):
        lam = weight(m); num = Fr(1); den = Fr(1)
        for a in pos: num *= ip(add(lam, delta), a); den *= ip(delta, a)
        return num / den
    def C2(m):
        lam = weight(m); return ip(lam, add(lam, scl(2, delta))) / 2
    theta = max(pos, key=lambda r: sum(coords(r)))
    hdual = ip(theta, add(theta, scl(2, delta))) / 2
    dimG = 2*len(pos) + n
    return dict(S=S, pos=pos, W=W, dim=dim, C2=C2, hdual=hdual, dimG=dimG, ip=ip, weight=weight, delta=delta)

def T(d, m): return d['dim'](m) * d['C2'](m) / d['dimG']

def report(name, typ, n, minimal, dual, extra=()):
    d = data(typ, n)
    dims = [d['dim'](tuple(1 if j == i else 0 for j in range(n))) for i in range(n)]
    print(f"== {name}: dim G = {d['dimG']}, h_dual = {d['hdual']}, #pos roots = {len(d['pos'])}, fundamental dims = {[int(x) for x in dims]}")
    m = minimal; dm = d['dim'](m); c2 = d['C2'](m); t = T(d, m)
    two = tuple(2*x for x in m); d2 = d['dim'](two)
    kappa = dm / t
    rx = 1 - d['hdual'] / (2*c2)
    print(f"   minimal rep {m}: d = {dm}, C2 = {c2}, T = {t}, kappa = d/T = {kappa}, h*kappa = {d['hdual']*kappa}")
    print(f"   Cartan square 2w: d = {d2}; ratio d^2/(2 d_2w) = {Fr(dm*dm, 2*d2)} = {float(Fr(dm*dm, 2*d2)):.6f}; crossing r_x = 1 - h/(2C2) = {rx}")
    if dual is not None:
        mix = tuple(a+b for a, b in zip(m, dual)); dmix = d['dim'](mix)
        print(f"   complex rep: dual {dual}, d_(w+w*) = {dmix}; mixed ratio d^2/d_mix = {Fr(dm*dm, dmix)} = {float(Fr(dm*dm, dmix)):.6f}")
    for lab, mm in extra:
        print(f"   extra {lab} {mm}: d = {d['dim'](mm)}, C2 = {d['C2'](mm)}, T = {T(d, mm)}")
    return d

if __name__ == '__main__':
    import math
    report('SU(2)=A1', 'A', 1, (1,), None, [('adj', (2,))])
    report('SU(3)=A2', 'A', 2, (1, 0), (0, 1), [('adj', (1, 1)), ('6', (2, 0)), ('10', (3, 0)), ('27', (2, 2))])
    report('G2', 'G', 2, (1, 0), None, [('w2', (0, 1)), ('27=2w1', (2, 0))])
    report('F4', 'F', 4, (0, 0, 0, 1), None, [('w1', (1, 0, 0, 0))])
    report('E6', 'E', 6, (1, 0, 0, 0, 0, 0), (0, 0, 0, 0, 0, 1), [('w2', (0, 1, 0, 0, 0, 0))])
    report('E7', 'E', 7, (0, 0, 0, 0, 0, 0, 1), None, [('w1', (1, 0, 0, 0, 0, 0, 0))])
    report('E8', 'E', 8, (0, 0, 0, 0, 0, 0, 0, 1), None, [('w1', (1, 0, 0, 0, 0, 0, 0, 0))])
    report('Sp(2)=C2', 'C', 2, (1, 0), None, [('w2', (0, 1))])
    report('Spin(7)=B3 vector', 'B', 3, (1, 0, 0), None, [('spinor', (0, 0, 1))])
    # the universal numbers
    c1 = 11 / (24 * math.pi**2)
    print(f"== universal: one-loop drift of 1/lambda per doubling = 2 b0 ln2 / h = 11 ln2/(24 pi^2) = {c1*math.log(2):.9f}")
    print(f"   b1/b0^2 = {Fr(17*2304, 384*121)} (pure YM, every G)")
EOF_GUARD = None
