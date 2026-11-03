# UV2: the ceiling of the interpolant route (P) in the bulk, by Bloch (READING, double precision):
#   any interpolant obeys ||Delta lt||^2 >= ||Delta lambda_phi||^2 (Delta^2-minimality), and in the bulk
#   ||Delta lambda_phi||^2 / N(phi) = n^4 / (sigma_B(k) S2(k)) per Bloch momentum (WORK.md section 8); C_a^opt := sup_k of it.
#   Also C_c^opt := sup over nu in N(Q') of ||ell^-1 D nu||^2/||Delta nu||^2 in the bulk (per k: constrained Rayleigh quotient).
import sys, itertools, numpy as np
sys.path.insert(0, 'code')
from uv2_bloch import R
def S(n, d, k, p):
    ms = np.array(list(itertools.product(range(n), repeat=d)), dtype=float)
    th = (k[None, :] + 2 * np.pi * ms) / n
    st2 = np.sin(th / 2) ** 2
    h2 = np.prod(np.where(st2 > 0, np.sin(k / 2)[None, :] ** 2 / (n * n * st2), 1.0), axis=1)
    sig = 4 * st2.sum(axis=1)
    return h2, sig
for d, ns in ((2, (2, 4, 8)), (4, (2, 3, 4, 6))):
    for n in ns:
        best_a = 0.0; best_c = 0.0
        g = 14 if d == 4 else 60
        for k in itertools.combinations_with_replacement(np.pi * np.arange(1, g + 1) / g, d):
            k = np.array(k); h2, sig = S(n, d, k, 2)
            S2 = (h2 / sig ** 2).sum(); sB = 4 * (np.sin(k / 2) ** 2).sum()
            best_a = max(best_a, n ** 4 / (sB * S2))
            # constrained Rayleigh: maximize sum sig|v|^2 / (n^2 sum sig^2 |v|^2) subject to sum conj(h) v = 0, h = sqrt(h2) (phases irrelevant)
            h = np.sqrt(h2); A = np.diag(sig) / n ** 2; B = np.diag(sig ** 2)
            P = np.eye(len(h)) - np.outer(h, h) / (h @ h)
            # restrict to range of P: generalized eig on P A P vs P B P (B positive)
            U, s, Vt = np.linalg.svd(P); Ub = U[:, s > 0.5]
            ev = np.linalg.eigvals(np.linalg.solve(Ub.T @ B @ Ub, Ub.T @ A @ Ub)).real
            best_c = max(best_c, ev.max())
        cb = R(n, d, np.full((1, d), np.pi))[0]
        ceil_max = 1 / (np.sqrt(1 / cb) + np.sqrt(best_a * 0.25)) ** 2
        ceil_opt = 1 / (np.sqrt(1 / cb) + np.sqrt(best_a * best_c)) ** 2
        print(f"d={d} n={n}: C_a^opt = {best_a:.3f} (sup over the grid); C_c^opt(bulk) = {best_c:.5f} (Lemma N's constant 1/4); "
              f"c_bulk = {cb:.4f}; route-(P) ceiling with C_c = 1/4: {ceil_max:.5f}; with C_c^opt: {ceil_opt:.5f}")
