# S1: exact rational check of Lemma L2 (M3g). Tents phi, transverse profile b_n, competitor matrix Q(1)E(1) = M.
from fractions import Fraction as F
import itertools, sys

def tent(n):
    # phi(s) = min(s+1, 2n-1-s)/n on bond positions s = 0..2n-2 of the slab S(c)
    return [F(min(s + 1, 2 * n - 1 - s), n) for s in range(2 * n - 1)]

def bprof(n):
    raw = [min(t + 1, n - t) for t in range(n)]
    m = F(sum(raw), n)
    return [F(r) / m for r in raw], m

def check_gram(n):
    ph = tent(n)
    diag = sum(p * p for p in ph)
    # neighbour slab starts n positions later
    off = sum(ph[s] * ph[s - n] for s in range(n, 2 * n - 1))
    ok = (diag == F(2 * n * n + 1, 3 * n)) and (off == F(n * n - 1, 6 * n))
    return ok, diag, off

def competitor_matrix(n, d, K):
    # chain of K block bonds in direction mu; cross-section {0..n-1}^(d-1); compute (Q(1) psi_c)(c') exactly
    ph = tent(n)
    b, m = bprof(n)
    # sum over cross-section of beta = n^(d-1) (product of per-coordinate sums n)
    sb = 1
    for _ in range(d - 1):
        sb *= sum(b)
    assert sb == n ** (d - 1)
    # mu-positions: chain occupies positions 0 .. (K+1)n - 1 (bond positions); slab of c_m starts at m*n
    L = (K + 1) * n
    def prof(mm):
        v = [F(0)] * L
        for s, p in enumerate(ph):
            v[mm * n + s] = p
        return v
    P = [prof(mm) for mm in range(K)]
    M = [[F(0)] * K for _ in range(K)]
    for a in range(K):
        for c in range(K):
            # (Q(1) psi_c)(c_a) = n^{-d} * sum_{s,z} phi_a(s) * phi_c(s) beta(z)  (Q coefficient = phi_a(s), psi_c = phi_c beta)
            M[a][c] = F(1, n ** d) * sb * sum(P[a][s] * P[c][s] for s in range(L))
    return M

def min_eig_sym(M):
    # exact-enough: use numpy on floats for eigenvalue; entries are exact rationals
    import numpy as np
    A = np.array([[float(x) for x in row] for row in M])
    return float(np.linalg.eigvalsh(A).min())

allok = True
for n in range(1, 33):
    ok, dg, of = check_gram(n)
    allok &= ok
    if n in (1, 2, 3, 4, 8, 16, 32):
        print(f"n={n:2d} Gram diag={dg} off={of} formula_ok={ok}")
print("S1a all Gram entries equal the closed forms for n=1..32:", allok)

worst = 10.0
okM = True
for d in (2, 3, 4):
    for n in (1, 2, 3, 4, 5, 8):
        for K in range(1, 13):
            M = competitor_matrix(n, d, K)
            for a in range(K):
                for c in range(K):
                    if a == c:
                        want = F(2 * n * n + 1, 3 * n * n)
                    elif abs(a - c) == 1:
                        want = F(n * n - 1, 6 * n * n)
                    else:
                        want = F(0)
                    if M[a][c] != want:
                        okM = False
            lam = min_eig_sym(M)
            bound = (n * n + 2) / (3 * n * n)
            worst = min(worst, lam - bound)
print("S1b Q(1)E(1) == M entrywise (d=2,3,4; n=1,2,3,4,5,8; K=1..12):", okM)
print("S1c min over cases of [lambda_min(M) - (n^2+2)/(3n^2)] =", worst, "(must be >= 0)")
