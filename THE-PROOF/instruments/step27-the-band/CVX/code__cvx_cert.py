"""CVX — THE CONVEXITY CERTIFICATE (COMPUTED; every inequality verified in IEEE double with rigorous error bounds).

THEOREM CHAIN (WORK.md §1.1, §6, §10): for B in V with |B_l| <= b on every link,
   Hess S(B)|_V  >=  (1 - alpha) H0 - b Qt (x) I3 - 6 rho(alpha, b) I    on V,
 (a) Lemma M: Qt = sum_p P_p^T X P_p, X = sum_c x^(c), x^(c) - K^(c) PSD (verified here, 8x8 real embedding);
 (b) remainder: r(phi) >= -alpha h0 - rho I, rho = c4(alpha') b^2 + 40.2658 b^3 + 42.6667 b^4, alpha = alpha' b^2 (rec/rem.*);
 (c) global: lambda_min(((1 - alpha) H0c - b Qt)|V0) >= mu by Finsler + verified Cholesky; certified c = mu - 6 rho.
Run: python -u -E -P code/cvx_cert.py L blocks(|K| or path.npy) b_list > rec/cert_L<L>.<date>.txt
"""
import sys, os, time
import numpy as np
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from cvx_core import Torus
from cvx_major import K_pos
from cvx_verify import verified_lmin_lower

U = 2.0 ** -53
# certified quartic coefficients c4(alpha') (rec/rem.2026-11-02a.txt: CERTIFIED upper bounds), quintic and sextic constants
# the certified upper bounds were printed with %.6f (round to nearest): each transcribed figure is rounded UP at its last digit
_C4_PRINTED = {0: 14.240295, 2: 12.359730, 4: 10.512284, 6: 8.712043, 8: 6.980660, 10: 5.351103,
               12: 3.870727, 16: 2.497267, 20: 2.444646, 32: 2.363657, 64: 2.342426}
C4 = {k: 4 * (v + 1e-6) for k, v in _C4_PRINTED.items()}
C5 = 8 * (5.033225 + 1e-6)
C6 = 1024.0 / 24.0


def rho_up(ap, b):
    r = C4[ap] * b * b + C5 * b ** 3 + C6 * b ** 4
    return r * (1 + 1e-12) + 1e-300


def dyadic(x, bits=24):
    return np.round(np.asarray(x) * 2 ** bits) / 2 ** bits


def absK_blocks():
    out = []
    for c in range(4):
        K = K_pos(c)[0]
        w, Uv = np.linalg.eigh(K)
        out.append(((Uv * np.abs(w)) @ Uv.conj().T).real)
    return out


def verify_blocks(blocks):
    """rigorous: x^(c) - K^(c) PSD via the real embedding [[x, -Om/2],[Om/2, x]] (Om/2 has entries 0, +-1)."""
    res = []
    for c in range(4):
        K, Om = K_pos(c)
        x = blocks[c]
        E = np.block([[x, -Om / 2], [Om / 2, x]])
        assert np.array_equal(E, E.T)
        lo, rb = verified_lmin_lower(E, 0.0)
        # delta = 0 is allowed: lambda_min >= -rb then; we need lo >= -something? require a strictly positive certificate:
        lo2, rb2 = verified_lmin_lower(E, 1e-10)
        res.append(lo2)
    return res


def main():
    L = int(sys.argv[1])
    which = sys.argv[2]
    blist = [float(x) for x in sys.argv[3].split(',')]
    t0 = time.time()
    # KAT: h1(phi with only link c = e3)[v,v] == omega^dag K^(c) omega, omega = v^1 + i v^2, for random v
    from cvx_core import plaq_h1
    rng = np.random.default_rng(11)
    worst = 0.0
    for c in range(4):
        phi = np.zeros((1, 4, 3)); phi[0, c, 2] = 1.0
        H1 = plaq_h1(phi)[0]
        K = K_pos(c)[0]
        for _ in range(20):
            v = rng.normal(size=12)
            om = v.reshape(4, 3)[:, 0] + 1j * v.reshape(4, 3)[:, 1]
            worst = max(worst, abs(v @ H1 @ v - (om.conj() @ K @ om).real), abs((om.conj() @ K @ om).imag))
    print("KAT: |h1(e3 at c)[v,v] - omega^dag K^(c) omega| max over 80 samples = %.2e" % worst)
    assert worst < 1e-12
    T = Torus(L)
    if which == 'absK':
        blocks = absK_blocks()
        # the |K| blocks are exact multiples of sqrt(3): round UP to dyadic by adding a tiny multiple of I (keeps x >= K)
        blocks = [dyadic(x + 1e-6 * np.eye(4)) for x in blocks]
    else:
        raw = np.load(which)
        blocks = [dyadic(x + 1e-6 * np.eye(4)) for x in raw]
    cert = verify_blocks(blocks)
    print("L = %d, majorant %s: x^(c) - K^(c) certified PSD with lambda_min >= %s" % (L, which, ['%.3e' % c for c in cert]))
    if min(c is not None and c > 0 for c in cert) is False:
        print("MAJORANT NOT CERTIFIED"); return
    X = sum(blocks)
    Qt = np.zeros((T.nLk, T.nLk))
    PtP = np.zeros(T.nLk, dtype=np.int64)
    for p in range(T.nP):
        li = T.plaqs[p]
        Qt[np.ix_(li, li)] += X
        assert len(set(li.tolist())) == 4
        PtP[li] += 1
    assert np.all(PtP == 6), "a link not in exactly six plaquettes"
    print("assert: sum_p P_p^T P_p = 6 I on this torus (every link in exactly six plaquettes, four distinct links per plaquette): OK")
    A0 = T.T0.T @ T.H0c.astype(float) @ T.T0
    w0, U0 = np.linalg.eigh(A0)
    W0 = U0 @ np.diag(w0 ** -0.5) @ U0.T
    nu = np.linalg.eigvalsh(W0 @ (T.T0.T @ Qt @ T.T0) @ W0)[-1]
    print("nu = lambda_max(Qt relative to H0 on V0) = %.6f  (b_lin of this majorant %.5f)" % (nu, 1 / nu))
    H0c = T.H0c.astype(float)
    # Finsler penalty P = kQ Q0^T Q0 + kG G0 G0^T (PSD, vanishes on V0; Q0 G0 = 0 so range(Q0^T) is orthogonal to range(G0) and
    # lambda_min(P on V0-perp) = min(kQ smin(Q0)^2, kG smin(G0)^2))
    QtQ = (T.Q0.astype(np.int64).T @ T.Q0.astype(np.int64))
    GGt = (T.G0.astype(np.int64) @ T.G0.astype(np.int64).T)
    assert np.abs(T.Q0.astype(np.int64) @ T.G0.astype(np.int64)).max() == 0
    sq = np.linalg.svd(T.Q0.astype(float), compute_uv=False); sq = sq[sq > 1e-9 * sq[0]]
    sg = np.linalg.svd(T.G0.astype(float), compute_uv=False); sg = sg[sg > 1e-9 * sg[0]]
    T0 = T.T0
    print("torus %s: dim V0 = %d; Q0 singular values [%.3f, %.3f], G0 [%.4f, %.4f]; |X| entries max %.4f"
          % (tuple(T.ext), T.dimV0, sq.min(), sq.max(), sg.min(), sg.max(), np.abs(X).max()))
    best = None
    for b in blist:
        b = float(dyadic(b, 16))
        rows = []
        for ap in sorted(C4):
            alpha = ap * b * b
            if alpha >= 1:
                continue
            M = (1 - alpha) * H0c - b * Qt
            lam = np.linalg.eigvalsh(T0.T @ M @ T0)[0]
            rho = rho_up(ap, b)
            rows.append((lam - 6 * rho, ap, alpha, lam, rho, M))
        rows.sort(key=lambda r: -r[0])
        cpred, ap, alpha, lam, rho, M = rows[0]
        line = "b = %.6f: best alpha' = %d (alpha %.5f): lambda_min((1-alpha)H0 - bQt | V0) READING %.5f, 6 rho = %.5f -> c READING %.5f" % (
            b, ap, alpha, lam, 6 * rho, cpred)
        if cpred <= 0:
            print(line + "   [no certificate attempted]")
            continue
        mu = 6 * rho + 0.5 * cpred
        normM = np.abs(M - mu * np.eye(T.nLk)).sum(axis=1).max()
        target = 4 * (normM + normM * normM / (0.5 * cpred))
        kQ = 2.0 ** np.ceil(np.log2(target / sq.min() ** 2))
        kG = 2.0 ** np.ceil(np.log2(target / sg.min() ** 2))
        A = M - mu * np.eye(T.nLk) + kQ * QtQ.astype(float) + kG * GGt.astype(float)
        # entrywise error of forming A in floats (M, kQ QtQ, kG GGt exact; the sums and the diagonal shift round)
        EA = 4 * U * (np.abs(M) + kQ * np.abs(QtQ).astype(float) + kG * np.abs(GGt).astype(float) + mu * np.eye(T.nLk))
        lo, rb = verified_lmin_lower(A, 0.25 * 0.5 * cpred, EA)
        ok = lo is not None and lo >= 0
        print(line + "\n      Finsler kQ = 2^%d, kG = 2^%d: verified lambda_min(A) >= %s (residual bound %s) -> %s: lambda_min(Hess S|V) >= %.5f on D_b"
              % (int(np.log2(kQ)), int(np.log2(kG)), lo, rb, 'CERTIFIED' if ok else 'NOT CERTIFIED', mu - 6 * rho if ok else float('nan')), flush=True)
        if ok:
            best = (b, mu - 6 * rho, ap)
    print("LARGEST CERTIFIED b in the list: %s  (%.0f s)" % (best, time.time() - t0))


if __name__ == '__main__':
    main()
