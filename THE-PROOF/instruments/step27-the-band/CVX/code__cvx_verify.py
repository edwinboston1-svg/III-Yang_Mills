"""CVX verified positive definiteness (COMPUTED, rigorous under IEEE-754 double arithmetic).

verified_lmin_lower(A, delta, EA): A a symmetric float64 matrix, EA >= 0 an entrywise bound on |A_true - A| (0 if A is exact).
Computes a float Cholesky A - delta I ~= L L^T and the RIGOROUS bound
   ||A_true - delta I - L L^T||_2 <= rbound := max_i sum_j [ |Rc_ij|(1+u) + u|A_ij - delta d_ij| + g |L||L|^T_ij + EA_ij ](1 + 4 n u),
   Rc = fl(fl(A - delta I) - fl(L L^T)),  g = gamma_{n+2} = (n+2)u / (1 - (n+2)u)   (the a-priori error of a float inner product of
length n, any summation order, FMA or not), and returns lambda_min(A_true) >= delta - rbound (L L^T is PSD), or None if the
factorisation breaks down.  The infinity norm bounds the spectral norm of the symmetric residual.

finsler_lower(M, C, mu, kappa, EM): lambda_min(M|ker C) >= mu  is certified if  A = M - mu I + kappa C^T C  passes with a
nonnegative lower bound (for v in ker C, v^T (M - mu) v = v^T A v >= 0).  C integer (exact C^T C in int64), kappa a power of 2.
"""
import numpy as np

U_ROUND = 2.0 ** -53


def verified_lmin_lower(A, delta, EA=None):
    n = A.shape[0]
    A = np.asarray(A, float)
    As = A - delta * np.eye(n)
    try:
        L = np.linalg.cholesky(As)
    except np.linalg.LinAlgError:
        return None, None
    LLt = L @ L.T
    Rc = As - LLt
    g = (n + 2) * U_ROUND / (1 - (n + 2) * U_ROUND)
    absL = np.abs(L)
    bnd = np.abs(Rc) * (1 + U_ROUND) + U_ROUND * np.abs(As) + g * (absL @ absL.T)
    if EA is not None:
        bnd = bnd + EA
    rbound = bnd.sum(axis=1).max() * (1 + 4 * n * U_ROUND) + 1e-300
    return delta - rbound, rbound


def finsler_lower(M, C, mu, kappa, EM=None, delta=None):
    """certify lambda_min(M restricted to ker C) >= mu; C integer (int64), kappa a power of two."""
    Ci = np.asarray(C, dtype=np.int64)
    CtC = Ci.T @ Ci
    assert np.abs(CtC).max() < 2 ** 52 / max(kappa, 1)
    A = M - mu * np.eye(M.shape[0]) + kappa * CtC.astype(float)
    if delta is None:
        # a shift comfortably above the float error scale
        delta = 1e-9 * max(1.0, np.abs(A).max())
    lo, rb = verified_lmin_lower(A, delta, EM)
    return lo, rb, delta


def selftest():
    rng = np.random.default_rng(0)
    n = 60
    X = rng.normal(size=(n, n))
    A = X @ X.T + 0.5 * np.eye(n)
    w = np.linalg.eigvalsh(A)[0]
    lo, rb = verified_lmin_lower(A, 0.5 * w)
    print("selftest: true lambda_min %.6f; certified lower bound with delta = lambda_min/2: %.6f (residual bound %.2e)" % (w, lo, rb))
    lo2, rb2 = verified_lmin_lower(A, 1.01 * w)
    print("selftest: delta above lambda_min -> %s (must be None: the factorisation of an indefinite matrix breaks down)" % (lo2,))
    # Finsler on a known constrained problem: M = diag(-1, 2, 3), C = [1 0 0] -> lambda_min on ker C = 2
    M = np.diag([-1.0, 2.0, 3.0]); C = np.array([[1, 0, 0]])
    lo3, rb3, d3 = finsler_lower(M, C, 1.5, 4.0)
    print("selftest: Finsler, lambda_min(diag(-1,2,3) | x1 = 0) >= 1.5: lower bound of the shifted form %.3e (>= 0 certifies)" % lo3)
    lo4, rb4, d4 = finsler_lower(M, C, 2.5, 4.0)
    print("selftest: Finsler at mu = 2.5 (false claim): %s (must be None)" % (lo4,))


if __name__ == '__main__':
    selftest()
