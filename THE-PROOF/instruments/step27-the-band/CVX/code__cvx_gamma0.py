"""CVX — the free slice gap gamma0 CERTIFIED (two-sided) on both tori.
Lower: lambda_min(H0c|V0) >= mu by Finsler + verified Cholesky of H0c - mu I + kQ Q0^T Q0 + kG G0 G0^T (all integer/dyadic, exact).
Upper: lambda_min(H0c|V0) <= Rayleigh quotient of an EXACT rational vector of V0 (Fraction arithmetic) — the eigenvector rounded
into the exact kernel basis.
Run: python -u -E -P code/cvx_gamma0.py > rec/gamma0.<date>.txt
"""
import sys, os, time
from fractions import Fraction as Fr
import numpy as np
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from cvx_core import Torus
from cvx_verify import verified_lmin_lower
from cvx_upper import exact_kernel_basis

U = 2.0 ** -53


def main():
    for L in (2, 3):
        t0 = time.time()
        T = Torus(L)
        H = T.H0c.astype(np.int64)
        w, Uv = np.linalg.eigh(T.T0.T @ H.astype(float) @ T.T0)
        g = w[0]
        mu = np.floor(g * 2 ** 20 - 2) / 2 ** 20              # dyadic just below the reading
        QtQ = T.Q0.astype(np.int64).T @ T.Q0.astype(np.int64)
        GGt = T.G0.astype(np.int64) @ T.G0.astype(np.int64).T
        sq = np.linalg.svd(T.Q0.astype(float), compute_uv=False); sq = sq[sq > 1e-9 * sq[0]]
        sg = np.linalg.svd(T.G0.astype(float), compute_uv=False); sg = sg[sg > 1e-9 * sg[0]]
        margin = w[1] - mu if abs(w[1] - g) > 1e-9 else (g - mu)
        normM = np.abs(H.astype(float) - mu * np.eye(T.nLk)).sum(axis=1).max()
        # the margin on V0 is g - mu (tiny) ; Finsler needs the penalty to dominate N^2/margin: use the true gap to the next
        # eigenvalue is irrelevant; take the certified target mu with slack s = g - mu
        s = g - mu
        target = 4 * (normM + normM * normM / s)
        kQ = 2.0 ** np.ceil(np.log2(target / sq.min() ** 2))
        kG = 2.0 ** np.ceil(np.log2(target / sg.min() ** 2))
        A = H.astype(float) - mu * np.eye(T.nLk) + kQ * QtQ.astype(float) + kG * GGt.astype(float)
        EA = 4 * U * (np.abs(H).astype(float) + kQ * np.abs(QtQ).astype(float) + kG * np.abs(GGt).astype(float) + mu * np.eye(T.nLk))
        lo, rb = verified_lmin_lower(A, 0.25 * s, EA)
        print("L = %d: gamma0 READING %.12f; Finsler lower bound at mu = %.10f: verified lambda_min(A) >= %s (residual %s) -> %s"
              % (L, g, mu, lo, rb, 'CERTIFIED gamma0 >= %.10f' % mu if (lo is not None and lo >= 0) else 'NOT CERTIFIED'))
        if lo is None or lo < 0:
            # fall back to a coarser mu
            for mu2 in (np.floor(g * 2 ** 12) / 2 ** 12 - 2 ** -12, np.floor(g * 2 ** 8) / 2 ** 8 - 2 ** -8):
                s2 = g - mu2
                target = 4 * (normM + normM * normM / s2)
                kQ = 2.0 ** np.ceil(np.log2(target / sq.min() ** 2)); kG = 2.0 ** np.ceil(np.log2(target / sg.min() ** 2))
                A = H.astype(float) - mu2 * np.eye(T.nLk) + kQ * QtQ.astype(float) + kG * GGt.astype(float)
                EA = 4 * U * (np.abs(H).astype(float) + kQ * np.abs(QtQ).astype(float) + kG * np.abs(GGt).astype(float) + mu2 * np.eye(T.nLk))
                lo2, rb2 = verified_lmin_lower(A, 0.25 * s2, EA)
                print("       retry mu = %.8f: lambda_min(A) >= %s (residual %s) -> %s" % (mu2, lo2, rb2,
                      'CERTIFIED' if (lo2 is not None and lo2 >= 0) else 'NOT CERTIFIED'))
                if lo2 is not None and lo2 >= 0:
                    break
        # upper bound by an exact rational vector of V0
        C0 = np.vstack([T.Q0, T.G0.T]).astype(np.int64)
        basis = exact_kernel_basis(C0)
        N0 = np.array([[float(x) for x in col] for col in basis]).T
        vec = T.T0 @ Uv[:, 0]
        c, *_ = np.linalg.lstsq(N0, vec, rcond=None)
        cq = [Fr(int(round(x * 2 ** 24)), 2 ** 24) for x in c]
        vq = [sum((basis[k][l] * cq[k] for k in range(len(basis)) if basis[k][l] != 0), Fr(0)) for l in range(T.nLk)]
        for row in C0:
            assert sum(int(row[l]) * vq[l] for l in range(T.nLk) if row[l] != 0) == 0
        num = Fr(0)
        for (a, b, cc, d) in T.plaqs:
            cu = vq[a] + vq[b] - vq[cc] - vq[d]
            num += cu * cu
        den = sum(x * x for x in vq)
        rq = num / den
        print("       exact rational V0 vector: Rayleigh quotient = %s ~ %.12f -> CERTIFIED gamma0 <= %.12f  (%.0f s)"
              % ('%d/%d digits' % (len(str(rq.numerator)), len(str(rq.denominator))), float(rq), float(rq) + 1e-12, time.time() - t0))


if __name__ == '__main__':
    main()
