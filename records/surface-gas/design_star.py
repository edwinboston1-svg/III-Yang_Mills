# design_star.py -- EXACT mixed-spin star integrals S(G) = int prod_{e=(i,j)} chi_{j_e}(U_i^-1 U_j) dU over SU(2)^V
# by the binary icosahedral 11-design (120 unit quaternions = the 600-cell), exact when every vertex's total degree
# sum_{e at v} 2 j_e <= 11.  chi_1/2(U_i^-1 U_j) = 2<q_i,q_j>, chi_1 = 4<q_i,q_j>^2 - 1 (quaternion dot products).
# Arithmetic in Z[phi] (phi^2 = phi + 1) modulo several primes, reconstructed by CRT; the phi-part of the answer must
# vanish exactly (a built-in check), the rational part is divided by 120^V and the scaling powers of 2.
import itertools, math, sys
from fractions import Fraction
import numpy as np
PH = (0, 1); ONE = (1, 0); ZERO = (0, 0); INVPH = (-1, 1)   # 1/phi = phi - 1
def zadd(a, b): return (a[0]+b[0], a[1]+b[1])
def zmul(a, b): return (a[0]*b[0] + a[1]*b[1], a[0]*b[1] + a[1]*b[0] + a[1]*b[1])
def quats():
    Q = []
    for i in range(4):
        for s in (1, -1):
            v = [ZERO]*4; v[i] = (2*s, 0); Q.append(tuple(v))
    for signs in itertools.product((1, -1), repeat=4):
        Q.append(tuple((s, 0) for s in signs))
    base = [PH, ONE, INVPH, ZERO]
    evens = [p for p in itertools.permutations(range(4)) if sum(1 for i in range(4) for j in range(i) if p[j] > p[i]) % 2 == 0]
    for p in evens:
        for signs in itertools.product((1, -1), repeat=3):
            v = [None]*4
            vals = [zmul(base[0], (signs[0], 0)), zmul(base[1], (signs[1], 0)), zmul(base[2], (signs[2], 0)), ZERO]
            for k in range(4): v[p[k]] = vals[k]
            Q.append(tuple(v))
    assert len(Q) == 120
    return Q
Q = quats()
def gram():
    n = len(Q); A0 = np.zeros((n, n), dtype=object); A1 = np.zeros((n, n), dtype=object)
    for i in range(n):
        for j in range(n):
            s = ZERO
            for k in range(4): s = zadd(s, zmul(Q[i][k], Q[j][k]))
            A0[i, j] = s[0]; A1[i, j] = s[1]
    return A0, A1
A0, A1 = gram()
for i in range(120): assert (A0[i, i], A1[i, i]) == (4, 0), (i, A0[i, i], A1[i, i])
def zphi_sq(X0, X1): return X0*X0 + X1*X1, 2*X0*X1 + X1*X1
S0, S1 = zphi_sq(A0, A1)
HALF = Fraction(1, 2)
# scaled weights: chi_1/2 = A/2 ; chi_1 = (A^2 - 4)/4 ; chi_3/2 = (A^3 - 8A)/8 (chi_3/2 = chi_1/2^3 - 2 chi_1/2) ; chi_2 = (A^4 - 12 A^2 + 16)/16
C0, C1 = zphi_sq(S0, S1)   # A^4
T0 = S0*A0 + S1*A1; T1 = S0*A1 + S1*A0 + S1*A1   # A^3
W = {HALF: (A0, A1, 2), Fraction(1): (S0 - 4, S1, 4), Fraction(3, 2): (T0 - 8*A0, T1 - 8*A1, 8), Fraction(2): (C0 - 12*S0 + 16, C1 - 12*S1, 16)}
def modpair(X0, X1, p): return (np.array(X0 % p, dtype=np.int64), np.array(X1 % p, dtype=np.int64))
PRIMES = [33554393, 33554383, 33554371, 33554347, 33554341, 33554317, 33554291, 33554273, 33554267, 33554249, 33554233, 33554221, 33554201, 33554167, 33554159, 33554137]
def contract_mod(n, E, p, gauge=True):
    """Sum over the 120^n (or 120^(n-1), vertex 0 fixed at the identity -- exact by left invariance) assignments of
    the product of the scaled edge weights, in Z[phi] mod p.  Variable elimination: a vertex is eliminated by
    multiplying all but one of its incident factors (broadcast over the union of their open vertices) and
    contracting the last one over the vertex with tensordot, so no factor ever carries more open vertices than
    the elimination order forces.  Returns (x, y) = x + y phi mod p, with the gauge factor 120 restored."""
    Wm = {s: modpair(W[s][0], W[s][1], p) for s in W}
    factors = []   # (tuple of open vertices in increasing order, X0, X1)
    for (i, j, s) in E:
        M0, M1 = Wm[s]
        if i < j: factors.append(((i, j), M0.copy(), M1.copy()))
        else: factors.append(((j, i), M0.T.copy(), M1.T.copy()))
    def mulpair(a0, a1, b0, b1):
        return ((a0*b0 + a1*b1) % p, (a0*b1 + a1*b0 + a1*b1) % p)
    def dotpair(a0, a1, b0, b1, axa, axb):
        return ((np.tensordot(a0, b0, axes=(axa, axb)) + np.tensordot(a1, b1, axes=(axa, axb))) % p,
                (np.tensordot(a0, b1, axes=(axa, axb)) + np.tensordot(a1, b0, axes=(axa, axb)) + np.tensordot(a1, b1, axes=(axa, axb))) % p)
    remaining = set(range(n))
    if gauge and n >= 1:
        # slice every factor touching vertex 0 at index 0 (the identity quaternion)
        newf = []
        for (vs, F0, F1) in factors:
            if 0 in vs:
                ax = vs.index(0)
                F0 = np.take(F0, 0, axis=ax); F1 = np.take(F1, 0, axis=ax)
                vs = tuple(u for u in vs if u != 0)
            newf.append((vs, F0, F1))
        factors = newf; remaining.discard(0)
    while remaining:
        v = min(remaining, key=lambda u: len(set().union(*[set(f[0]) for f in factors if u in f[0]])) if any(u in f[0] for f in factors) else 0)
        inc = [f for f in factors if v in f[0]]; rest = [f for f in factors if v not in f[0]]
        if not inc:
            # isolated (all its factors already sliced away): contributes the free sum 120
            factors = rest + [((), np.int64(120 % p), np.int64(0))]; remaining.remove(v); continue
        inc.sort(key=lambda f: len(f[0]))
        last = inc[-1]; head = inc[:-1]
        L = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        if head:
            opn = sorted(set().union(*[set(f[0]) for f in head]))
            T0_ = np.ones([120]*len(opn), dtype=np.int64); T1_ = np.zeros([120]*len(opn), dtype=np.int64)
            for (vs, F0, F1) in head:
                idx = tuple(slice(None) if u in vs else None for u in opn)
                T0_, T1_ = mulpair(T0_, T1_, F0[idx], F1[idx])
            lvs, L0, L1 = last
            newopen = tuple(sorted((set(opn) | set(lvs)) - {v}))
            sub = "".join(L[u] for u in opn) + "," + "".join(L[u] for u in lvs) + "->" + "".join(L[u] for u in newopen)
            # the sum over v has 120 terms of products below 2^50: no overflow in int64
            R0 = (np.einsum(sub, T0_, L0) + np.einsum(sub, T1_, L1)) % p
            R1 = (np.einsum(sub, T0_, L1) + np.einsum(sub, T1_, L0) + np.einsum(sub, T1_, L1)) % p
        else:
            lvs, L0, L1 = last; lax = lvs.index(v)
            R0 = L0.sum(axis=lax) % p; R1 = L1.sum(axis=lax) % p
            newopen = tuple(u for u in lvs if u != v)
        factors = rest + [(newopen, R0, R1)]
        remaining.remove(v)
    x, y = 1, 0
    for (vs, F0, F1) in factors:
        assert vs == (), vs
        x, y = (x*int(F0) + y*int(F1)) % p, (x*int(F1) + y*int(F0) + y*int(F1)) % p
    if gauge and n >= 1:
        x, y = (x*120) % p, (y*120) % p
    return x, y
def crt(residues, primes):
    x, m = 0, 1
    for r, p in zip(residues, primes):
        t = ((r - x) * pow(m, -1, p)) % p; x += m*t; m *= p
    return x if x <= m//2 else x - m, m
def star(edges, label="", quiet=False):
    verts = sorted({v for e in edges for v in e[:2]}); n = len(verts)
    ren = {v: k for k, v in enumerate(verts)}
    E = [(ren[i], ren[j], Fraction(s)) for (i, j, s) in edges]
    deg = {v: Fraction(0) for v in range(n)}
    for (i, j, s) in E: deg[i] += 2*s; deg[j] += 2*s
    if max(deg.values()) > 11: raise ValueError("design exact only to degree 11; vertex degrees %s" % deg)
    bits = n*math.log2(120) + sum(float(2*s)*math.log2(3.3) for (_, _, s) in E) + 6
    used = []; need = 0.0
    for p in PRIMES:
        used.append(p); need += math.log2(p)
        if need > bits + 2: break
    rx = []; ry = []
    for p in used:
        x, y = contract_mod(n, E, p); rx.append(x); ry.append(y)
    X, m = crt(rx, used); Y, _ = crt(ry, used)
    assert Y == 0, ("phi-part nonzero", label, X, Y)
    scale = 120**n * math.prod(W[s][2] for (_, _, s) in E)
    val = Fraction(X, scale)
    if not quiet:
        print("DESIGN %-28s V=%d E=%2d degs=%s  S = %s = %.10f" % (label, n, len(E), [int(deg[v]) for v in range(n)], val, float(val)), flush=True)
    return val
if __name__ == "__main__":
    h = HALF
    star([(0,1,1),(1,2,1),(2,0,1)], "C3(1) 1/3")
    star([(0,1,1),(1,2,1),(2,3,1),(3,0,1)], "C4(1) 1/9")
    star([(0,1,h),(1,2,h),(2,0,h)], "C3(1/2) 1/2")
    star([(0,1,h),(1,2,h),(2,3,h),(3,0,h)], "C4(1/2) 1/4")
    star([(i,j,1) for i in range(4) for j in range(i+1,4)], "K4(1) 1/36")
    K222 = [(i,j,1) for i in range(6) for j in range(i+1,6) if (i,j) not in ((0,1),(2,3),(4,5))]
    star(K222, "K222(1) 16981/202500")
    star([(i,j,h) for (i,j,_) in K222], "K222(1/2) 73/324")
    star([(0,1,h),(0,1,h),(0,1,1)], "chord: 1")
    star([(0,1,h),(0,1,h),(0,2,1),(2,1,1)], "2-plaq vertex: 1/3")
    star([(0,1,1),(0,1,1),(1,2,1),(1,2,1),(2,0,1),(2,0,1)], "doubled C3(1): 23/15")
    for k in (3, 4, 5):
        edges = [(i, (i+1) % k, h) for i in range(k)] + [(k, i, 1) for i in range(k)]
        star(edges, "W%d(rim 1/2, spokes 1)" % k)
