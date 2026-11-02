"""M3b instrument. S-A: W(B4) invariant dimensions by exact character averaging over all 384 signed permutations.
S-B: the two-loop source multiplier m_K = prod(1 + b/x_j^2) against beta(x_K)/beta(x_0), certified with mpmath.iv."""
import itertools
from fractions import Fraction
import mpmath
from mpmath import iv

# ---------- S-A: the hyperoctahedral group W(B4) as 4x4 signed permutation matrices ----------
def group():
    G = []
    for perm in itertools.permutations(range(4)):
        for signs in itertools.product((1, -1), repeat=4):
            M = [[0] * 4 for _ in range(4)]
            for i in range(4):
                M[perm[i]][i] = signs[i]
            G.append(M)
    return G

def trace(M):
    return sum(M[i][i] for i in range(len(M)))

def mat_on_lambda2(M):
    pairs = [(a, b) for a in range(4) for b in range(a + 1, 4)]
    # action on e_a ^ e_b : M e_a ^ M e_b ; coefficient of e_c ^ e_d is M[c][a]M[d][b] - M[d][a]M[c][b]
    R = [[0] * 6 for _ in range(6)]
    for j, (a, b) in enumerate(pairs):
        for i, (c, d) in enumerate(pairs):
            R[i][j] = M[c][a] * M[d][b] - M[d][a] * M[c][b]
    return R

def det4(M):
    # exact determinant by permutation expansion
    s = 0
    for p in itertools.permutations(range(4)):
        sign = 1
        for i in range(4):
            for j in range(i + 1, 4):
                if p[i] > p[j]:
                    sign = -sign
        prod = 1
        for i in range(4):
            prod *= M[i][p[i]]
        s += sign * prod
    return s

def matmul(A, B):
    n = len(A)
    return [[sum(A[i][k] * B[k][j] for k in range(n)) for j in range(n)] for i in range(n)]

def sym2_char(R):
    # chi_{Sym^2}(g) = (chi(g)^2 + chi(g^2))/2
    t = trace(R)
    return Fraction(t * t + trace(matmul(R, R)), 2)

G = group()
assert len(G) == 384
n = Fraction(len(G))
inv_sym2_lambda2 = sum(sym2_char(mat_on_lambda2(M)) for M in G) / n
inv_vec = sum(Fraction(trace(M)) for M in G) / n
inv_t3 = sum(Fraction(trace(M) ** 3) for M in G) / n
inv_t5 = sum(Fraction(trace(M) ** 5) for M in G) / n
inv_sym2_vec = sum(sym2_char(M) for M in G) / n
inv_lambda4 = sum(Fraction(det4(M)) for M in G) / n
print("S-A  |W(B4)| =", len(G))
print("S-A  dim Inv Sym^2(Lambda^2 R^4) =", inv_sym2_lambda2)
print("S-A  dim Inv R^4 =", inv_vec, "; (R^4)^{x3} =", inv_t3, "; (R^4)^{x5} =", inv_t5)
print("S-A  dim Inv Sym^2(R^4) =", inv_sym2_vec, "; Lambda^4 R^4 (epsilon) =", inv_lambda4)

# ---------- S-B: the two-loop multiplier, certified ----------
mpmath.mp.dps = 50
iv.dps = 50
pi = iv.pi
b0 = iv.mpf(11) / (24 * pi ** 2)        # mu dg/dmu = -b0 g^3 - b1 g^5, N = 2 (g_YM)
b1 = iv.mpf(17) / (96 * pi ** 4)
L = 3
lnL = iv.log(iv.mpf(L))
c = 8 * b0 * lnL                        # one-loop decrement of x = 1/g_B^2 = 4/g_YM^2 per step
b = 32 * b1 * lnL                       # two-loop coefficient: x -> x - c - b/x
print("S-B  c(3) =", c, " b(3) =", b, " 4 b1/b0 =", 4 * b1 / b0)

def backward(X, K):
    # find x_0 with x_K = X under x -> x - c - b/x by inverting each step: x_j = x_{j+1} + c + b/x_j
    # solve x_j from x_{j+1}: x_j^2 - (x_{j+1} + c) x_j - b = 0, positive root (exact up to interval rounding)
    xs = [iv.mpf(X)]
    for _ in range(K):
        y = xs[-1]
        s = y + c
        xj = (s + iv.sqrt(s * s + 4 * b)) / 2
        xs.append(xj)
    xs.reverse()            # xs[0] = x_0 (bare), xs[K] = X
    return xs

for X in (4, 8):
    limit = 1 + b / (c * X)
    for K in (10, 100, 1000):
        xs = backward(X, K)
        m = iv.mpf(1)
        for j in range(K):
            m *= (1 + b / xs[j] ** 2)
        ratio = (c + b / xs[K]) / (c + b / xs[0])
        rel = (m - ratio) / ratio
        print(f"S-B  X={X} K={K}: x_0={mpmath.nstr(xs[0].mid, 12)}  m_K={mpmath.nstr(m.mid, 15)} (width {mpmath.nstr(m.delta, 3)})"
              f"  beta-ratio={mpmath.nstr(ratio.mid, 15)}  rel.diff={mpmath.nstr(rel.mid, 6)}  limit 1+b/(cX)={mpmath.nstr(limit.mid, 15)}")
