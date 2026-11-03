# star_table.py -- THE VERTEX-STAR TABLE (S1 section 23): the star integral  S(G) = int prod_{(i,j) in E(G)} chi_1(U_i^-1 U_j) dU
# over SU(2)^{V(G)}, EXACTLY, for the vertex graphs of closed spin-1 complexes (vertices = links at a vertex of the complex,
# edges = plaquettes there; parallel edges allowed, as in a double).  Road: chi_1(U_i^-1 U_j) = sum_{AB} D(U_i)_{AB} D(U_j)_{AB}
# (D the real adjoint matrix), so each vertex i carries int D(U_i)^{(x) deg i} = P_d, the orthogonal projector onto
# Inv(1^{(x)d}), built EXACTLY as B (B^T B)^{-1} B^T from an integer basis B of the invariants (delta-matchings, and
# epsilon-triples times matchings for odd d), and the graph is one integer tensor contraction, done modulo primes with the
# Chinese remainder theorem (int64, each product of residues < 2^30, each sum over at most 9^8 terms), so no float enters.
import itertools, sys, os, math
from fractions import Fraction
import numpy as np
# ---------- exact projectors P_d = N_d / den_d, d = 2..6 ----------
def eps(a, b, c):
    return {(0,1,2):1,(1,2,0):1,(2,0,1):1,(0,2,1):-1,(2,1,0):-1,(1,0,2):-1}.get((a,b,c), 0)
def matchings(items):
    items = list(items)
    if not items: yield []; return
    a = items[0]
    for k in range(1, len(items)):
        b = items[k]; rest = items[1:k] + items[k+1:]
        for m in matchings(rest): yield [(a, b)] + m
def invariant_candidates(d):
    """integer vectors spanning Inv(1^{(x)d}) in (R^3)^{(x)d}, as dicts index-tuple -> int"""
    vecs = []
    if d % 2 == 0:
        for m in matchings(range(d)):
            v = {}
            for idx in itertools.product(range(3), repeat=d):
                if all(idx[a] == idx[b] for a, b in m): v[idx] = 1
            vecs.append(v)
    else:
        for T in itertools.combinations(range(d), 3):
            rest = [k for k in range(d) if k not in T]
            for m in matchings(rest):
                v = {}
                for idx in itertools.product(range(3), repeat=d):
                    e = eps(idx[T[0]], idx[T[1]], idx[T[2]])
                    if e != 0 and all(idx[a] == idx[b] for a, b in m): v[idx] = e
                vecs.append(v)
    return vecs
def independent_subset(vecs, d):
    """exact Gaussian elimination over Q to pick an independent subset"""
    keys = list(itertools.product(range(3), repeat=d))
    rows = []; chosen = []
    pivots = []   # list of (pivot column, row as dict)
    for vi, v in enumerate(vecs):
        r = dict(v)
        for pc, pr in pivots:
            if pc in r and r[pc] != 0:
                f = Fraction(r[pc], pr[pc])
                for k, val in pr.items():
                    r[k] = r.get(k, 0) - f*val
                    if r[k] == 0: del r[k]
        nz = [k for k in keys if r.get(k, 0) != 0]
        if nz:
            pivots.append((nz[0], r)); chosen.append(vi)
    return [vecs[i] for i in chosen]
PCACHE = {}
def projector(d):
    """returns (N, den): integer matrix N (3^d x 3^d) with P_d = N/den"""
    if d in PCACHE: return PCACHE[d]
    if d == 0:
        PCACHE[0] = (np.ones((1,1), dtype=object), 1); return PCACHE[0]
    if d == 1:
        PCACHE[1] = (np.zeros((3,3), dtype=object), 1); return PCACHE[1]
    basis = independent_subset(invariant_candidates(d), d)
    keys = list(itertools.product(range(3), repeat=d)); pos = {k: i for i, k in enumerate(keys)}
    r = len(basis); n = 3**d
    B = [[Fraction(0)]*r for _ in range(n)]
    for j, v in enumerate(basis):
        for k, val in v.items(): B[pos[k]][j] = Fraction(val)
    # Gram G = B^T B (r x r), inverse exactly
    G = [[sum(B[i][a]*B[i][b] for i in range(n)) for b in range(r)] for a in range(r)]
    # invert G by Gauss-Jordan over Fractions
    M = [row[:] + [Fraction(int(i == j)) for j in range(r)] for i, row in enumerate(G)]
    for c in range(r):
        p = next(i for i in range(c, r) if M[i][c] != 0); M[c], M[p] = M[p], M[c]
        pv = M[c][c]; M[c] = [x/pv for x in M[c]]
        for i in range(r):
            if i != c and M[i][c] != 0:
                f = M[i][c]; M[i] = [x - f*y for x, y in zip(M[i], M[c])]
    Ginv = [row[r:] for row in M]
    # P = B Ginv B^T ; compute as integers over the lcm of denominators
    BG = [[sum(B[i][a]*Ginv[a][b] for a in range(r)) for b in range(r)] for i in range(n)]
    # P[i][k] = sum_b BG[i][b] * B[k][b]; entries rational; find common denominator
    den = 1
    for row in Ginv:
        for x in row: den = den*x.denominator//math.gcd(den, x.denominator)
    N = np.zeros((n, n), dtype=object)
    Bint = [[int(B[k][b]) for b in range(r)] for k in range(n)]
    BGd = [[int(BG[i][b]*den) for b in range(r)] for i in range(n)]
    for i in range(n):
        rowi = BGd[i]
        if not any(rowi): continue
        for k in range(n):
            s = 0
            for b in range(r):
                if rowi[b] and Bint[k][b]: s += rowi[b]*Bint[k][b]
            if s: N[i, k] = s
    # checks: N N = den N (projector), trace N = den * r
    PCACHE[d] = (N, den)
    return PCACHE[d]
def check_projector(d):
    N, den = projector(d); n = 3**d
    Nf = np.array(N, dtype=object)
    tr = sum(int(Nf[i, i]) for i in range(n))
    r = tr // den; assert tr == den*r, (d, tr, den)
    # spot-check N N == den N on a few random rows
    import random
    for i in random.sample(range(n), min(n, 5)):
        row = [int(x) for x in Nf[i]]
        for k in random.sample(range(n), min(n, 5)):
            s = sum(row[j]*int(Nf[j, k]) for j in range(n) if row[j])
            assert s == den*int(Nf[i, k]), ("projector check failed", d)
    return r, den
# ---------- the graph contraction, modulo a prime ----------
def star_integral(edges, label="", primes=(32749, 32719, 32717, 32713, 32707, 32693, 32687, 32653, 32647, 32633, 32621, 32611, 32609, 32603, 32587, 32579)):
    verts = sorted({v for e in edges for v in e}); n = len(verts)
    deg = {v: sum(1 for e in edges if v in e) for v in verts}
    inc = {v: [k for k, e in enumerate(edges) if v in e] for v in verts}
    dens = 1; degs = []
    for v in verts:
        N, den = projector(deg[v]); dens *= den; degs.append(deg[v])
    # bound on |numerator|: 9^|E| * prod den  (|P entries| <= 1)
    bound_bits = len(edges)*math.log2(9) + sum(math.log2(projector(deg[v])[1]) for v in verts) + 2
    need = 1; used = []
    for p in primes:
        used.append(p); need *= p
        if math.log2(need) > bound_bits + 1: break
    residues = []
    for p in used:
        # vertex tensors mod p: X_v[(A_e,B_e) for e in inc[v]] = N_d[A-vector ; B-vector] mod p
        T = {}
        for v in verts:
            d = deg[v]; N, den = projector(d)
            X = np.zeros((9,)*d, dtype=np.int64)
            for idx in itertools.product(range(9), repeat=d):
                A = tuple(i // 3 for i in idx); B = tuple(i % 3 for i in idx)
                ia = sum(a*3**(d-1-k) for k, a in enumerate(A)); ib = sum(b*3**(d-1-k) for k, b in enumerate(B))
                val = int(N[ia, ib]) % p
                if val: X[idx] = val
            T[v] = (X, list(inc[v]))
        # greedy contraction: merge the pair of tensors minimising the open-edge count
        tensors = list(T.values())
        while len(tensors) > 1:
            best = None
            for i in range(len(tensors)):
                for j in range(i+1, len(tensors)):
                    sh = [e for e in tensors[i][1] if e in tensors[j][1]]
                    if not sh: continue
                    opn = len(tensors[i][1]) + len(tensors[j][1]) - 2*len(sh)
                    if best is None or opn < best[0]: best = (opn, i, j, sh)
            if best is None:   # disconnected: outer product
                i, j = 0, 1; sh = []
            else: _, i, j, sh = best
            Xi, ei = tensors[i]; Xj, ej = tensors[j]
            if sh:
                Z = np.tensordot(Xi, Xj, axes=([ei.index(e) for e in sh], [ej.index(e) for e in sh])) % p
            else:
                Z = np.multiply.outer(Xi, Xj) % p
            ez = [e for e in ei if e not in sh] + [e for e in ej if e not in sh]
            tensors = [t for k, t in enumerate(tensors) if k not in (i, j)] + [(Z, ez)]
        residues.append(int(tensors[0][0]) % p)
    # CRT
    x, m = 0, 1
    for r, p in zip(residues, used):
        t = ((r - x) * pow(m, -1, p)) % p
        x += m*t; m *= p
    if x > m//2: x -= m
    S = Fraction(x, dens)
    s = float(S) ** (1.0/len(edges)) if S > 0 else float('nan')
    print("STAR %-14s V=%d E=%2d degrees=%s  S = %s = %.10f  s = S^(1/E) = %.4f" % (label, n, len(edges), sorted(degs), S, float(S), s), flush=True)
    return S
if __name__ == "__main__":
    for d in (2, 3, 4, 5, 6):
        r, den = check_projector(d); print("P_%d: rank %d, denominator %d" % (d, r, den), flush=True)
    C = lambda k: [(i, (i+1) % k) for i in range(k)]
    star_integral(C(3), "C3"); star_integral(C(4), "C4"); star_integral(C(5), "C5"); star_integral(C(6), "C6")
    star_integral([(0,1),(0,1)], "2-cycle")
    star_integral([(0,1),(1,2),(2,3),(3,0),(0,1),(2,3)], "C4+2 doubled")
    K4 = [(i, j) for i in range(4) for j in range(i+1, 4)]; star_integral(K4, "K4")
    star_integral([(0,2),(0,3),(0,4),(1,2),(1,3),(1,4)], "K_{2,3}")
    star_integral([(0,2),(0,3),(0,4),(0,5),(1,2),(1,3),(1,4),(1,5)], "K_{2,4}")
    star_integral([(0,3),(0,4),(0,5),(1,3),(1,4),(1,5),(2,3),(2,4),(2,5)], "K_{3,3}")
    # K_{2,2,1}: pairs (0,1),(2,3), single 4 ; edges: all pairs except (0,1),(2,3)
    K221 = [(i,j) for i in range(5) for j in range(i+1,5) if (i,j) not in ((0,1),(2,3))]; star_integral(K221, "K_{2,2,1}")
    K2111 = [(i,j) for i in range(5) for j in range(i+1,5) if (i,j) != (0,1)]; star_integral(K2111, "K_{2,1,1,1}")
    K222 = [(i,j) for i in range(6) for j in range(i+1,6) if (i,j) not in ((0,1),(2,3),(4,5))]; star_integral(K222, "K_{2,2,2}")
    K2211 = [(i,j) for i in range(6) for j in range(i+1,6) if (i,j) not in ((0,1),(2,3))]; star_integral(K2211, "K_{2,2,1,1}")
