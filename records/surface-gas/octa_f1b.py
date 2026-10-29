# octa_f1.py -- the spin-1 octahedron integral F := int_{SU(2)^6} prod_{(i,j) in E(octahedron)} chi_1(U_i U_j) dU,
# which is 3^12 * W(D_box)/(3a1)^24, the double of the 2x2x2 box interior (S1 section 21 (c)).
# Road A: exact by representation theory -- expand each chi_1(U_i U_j) = sum_{AB} D1(U_i)_{AB} D1(U_j)_{BA} and
#         integrate every U_i (degree 4) with the projector onto Inv(1^{(x)4}) given in the Pauli-trace basis:
#         int D1(U)_{a1b1} D1(U)_{a2b2} D1(U)_{a3b3} D1(U)_{a4b4} dU = sum_{s,t} G^{-1}_{st} T_s(a) T_t(b), T the three pairings
#         delta_{12}delta_{34}, delta_{13}delta_{24}, delta_{14}delta_{23}, G their Gram matrix (9,3,3;3,9,3;3,3,9).
# Road B: float Monte Carlo is NOT used (the operator's rule); instead a second exact road: the same integral as
#         tr over the 729-dim space of the octahedron's edge pairing -- a direct 3^12 contraction done with numpy ints.
import numpy as np, itertools, os
ORIENT = os.environ.get("ORIENT", "inv")   # inv: the box double's convention chi_1(V_i V_j^-1) (derived S1 s22: the plaquette pair gives chi_1(V_f2^-1 V_f1), V_a = U_a U*_a^-1); same: chi_1(U_i U_j), a different integral on the non-bipartite octahedron
# --- the projector onto Inv(V1^{(x)4}) in index form: P[a1a2a3a4, b1b2b3b4]
d = np.eye(3, dtype=np.int64)
T = []
T.append(np.einsum('ab,cd->abcd', d, d))   # delta_12 delta_34
T.append(np.einsum('ac,bd->abcd', d, d))   # delta_13 delta_24
T.append(np.einsum('ad,bc->abcd', d, d))   # delta_14 delta_23
G = np.array([[np.sum(T[i]*T[j]) for j in range(3)] for i in range(3)], dtype=np.int64)   # Gram: 9 on the diagonal, 3 off
# G = 6I + 3J, so G^{-1} = (5I - J)/30 = (1/30) [[4,-1,-1],[-1,4,-1],[-1,-1,4]]  (check: G*(5I-J) = 30I)
Ginv_num = np.array([[4,-1,-1],[-1,4,-1],[-1,-1,4]], dtype=np.int64); Ginv_den = 30
assert (G @ Ginv_num == Ginv_den*np.eye(3, dtype=np.int64)).all()
# P[a,b] * 24 = sum_{s,t} Ginv_num[s,t] T_s(a) T_t(b)
P30 = np.zeros((81, 81), dtype=np.int64)
for s in range(3):
    for t in range(3):
        P30 += Ginv_num[s, t] * np.outer(T[s].reshape(81), T[t].reshape(81))
# sanity: P is a projector of rank 3: (P24/24)^2 = P24/24  <=>  P24 @ P24 == 24 * P24
assert (P30 @ P30 == 30*P30).all()
assert np.trace(P30) == 3*30
# --- the octahedron: vertices 0..5 = +x,-x,+y,-y,+z,-z; edges = pairs not antipodal (12 edges); each vertex has 4 edges
V = list(range(6)); anti = {0:1,1:0,2:3,3:2,4:5,5:4}
E = [(i,j) for i in V for j in V if i < j and anti[i] != j]
assert len(E) == 12
# chi_1(U_i U_j) = sum_{A,B} D(U_i)_{AB} D(U_j)_{BA}: each edge contributes one index pair (A at i's slot, B at j's slot).
# At vertex i the four slots are (row index, column index) pairs of D(U_i) for its four edges; the integral over U_i
# contracts them with P: int prod_e D(U_i)_{r_e c_e} = (1/30) * P30[r_e1 r_e2 r_e3 r_e4, c_e1 c_e2 c_e3 c_e4].
# F = (1/30)^6 * sum over all edge indices of prod_i P24_i.  Do it as a tensor contraction with int64 (exact: the
# total is an integer times 24^-6, and intermediate sums stay < 2^63 by the sizes here).
# edge e=(i,j): index A_e at i (row of D(U_i)), index B_e at j (column of D(U_i)? no: chi_1(U_i U_j) = tr(D(U_i)D(U_j))
# = sum_{A,B} D(U_i)_{AB} D(U_j)_{BA}: at i the edge contributes row A, column B of D(U_i); at j row B, column A of D(U_j).
# So each edge e carries TWO indices (A_e, B_e); at vertex i (first endpoint) the pair (row=A_e, col=B_e), at j (row=B_e, col=A_e).
inc = {i: [] for i in V}
for k, (i, j) in enumerate(E):
    inc[i].append((k, 0)); inc[j].append((k, 1))      # 0: (row A, col B); 1: (row B, col A)
for i in V: assert len(inc[i]) == 4
# contract: the state is a tensor over the 12 edges' (A,B) pairs = 9^12 = 282 billion: too big to hold. Instead
# contract vertex by vertex, keeping only the open edges' indices (treewidth of the octahedron's line structure).
# Order the vertices 0..5; open edges after processing a prefix: at most 9 edges open -> 9^9 = 387 M entries of int64 = 3 GB: too big.
# Better: process in the order +x,-x (antipodal, disjoint edge sets): after {0,1}: open edges = the 8 edges from {0,1} to {2,3,4,5}: 9^8 = 43 M entries (344 MB) -- acceptable.
from functools import reduce
def vertex_tensor(i):
    # returns tensor over its 4 edges' (A,B) index pairs: X[(A1,B1),(A2,B2),(A3,B3),(A4,B4)] = P24[rows, cols]
    ks = inc[i]
    X = np.zeros((9,)*4, dtype=np.int64)
    for idx in itertools.product(range(9), repeat=4):
        rows = []; cols = []
        for (k, side), ab in zip(ks, idx):
            A, B = divmod(ab, 3)
            if side == 0 or ORIENT == "inv": rows.append(A); cols.append(B)   # inv: chi_1(U_i U_j^-1) = sum_AB D(U_i)_AB D(U_j)_AB (D real orthogonal)
            else:         rows.append(B); cols.append(A)
        r = rows[0]*27 + rows[1]*9 + rows[2]*3 + rows[3]
        c = cols[0]*27 + cols[1]*9 + cols[2]*3 + cols[3]
        X[idx] = P30[r, c]
    return X, [k for (k, s) in ks]
# contract with einsum over edge labels (letters)
# --- explicit contraction order (the einsum greedy path stalled): antipodal pairs first, then the equator, then the poles
import time
t0 = time.time()
X = {}; ed = {}
for i in V:
    X[i], ed[i] = vertex_tensor(i)
# T01 = outer(X0, X1): the two antipodal vertices share no edge
T = np.multiply.outer(X[0], X[1]); axes = ed[0] + ed[1]          # 8 open edges, 9^8 entries
def contract_in(T, axes, i):
    Xi, ei = X[i], ed[i]
    shared = [e for e in ei if e in axes]
    a_T = [axes.index(e) for e in shared]; a_X = [ei.index(e) for e in shared]
    T2 = np.tensordot(T, Xi, axes=(a_T, a_X))
    new_axes = [e for e in axes if e not in shared] + [e for e in ei if e not in shared]
    return T2, new_axes
for i in (2, 3, 4, 5):
    T, axes = contract_in(T, axes, i)
    print("after vertex", i, "open edges", len(axes), "elapsed %.0fs" % (time.time() - t0), flush=True)
num = int(T); den = 30**6
from math import gcd
g = gcd(num, den)
print("sum over edge indices of prod_i P30_i =", num)
print("F = %d / %d = %.10f" % (num//g, den//g, num/den))
print("3^12 =", 3**12, "; W(D_box)/(3a1)^24 = F/3^12 = %.6e" % (num/den/3**12), "; sqrt = %.6e" % ((num/den/3**12)**0.5))
print("junction bound for the box: (7/3)^3 = %.4f times sqrt(double) = %.6f ; rho = %.4f" % ((7/3)**3, (7/3)**3*((num/den/3**12)**0.5), (num/den/3**12)**(1/24)))
