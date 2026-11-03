"""CVX — the per-plaquette remainder bound r(phi) >= -alpha h0 - rho(alpha, b) I on (ball_b)^4, rigorous (COMPUTED).

r(phi) = Q4(phi) + Q5(phi) + R6(phi), Q4 = (1/2) D4F(0)[phi,phi], Q5 = (1/6) D5F(0)[phi,phi,phi] (exact integer tensors / 3), and
 (i)   |phi| <= 2b (ball relaxation of the product of four b-balls):  -Q4(phi) - alpha h0 <= lambda_max(-4b^2 T - alpha (h0 (x) I12))_+ I,
       T_{(k,a),(l,b)} = (1/2) D4_{klab} (144 x 144);
 (ii)  |Q5(phi)[v,v]| <= sigma_max(U) |phi|^3 |v|^2 <= 8 b^3 sigma_max(U),  U_{(k,a),(l,b,c)} = (1/6) D5_{klabc} (144 x 1728);
 (iii) |R6[v,v]| <= (1/24)(sum|phi_i|)^4 (sum|v_i|)^2 <= (1024/24) b^4 |v|^2   (Dyson).
The eigenvalue bounds are CERTIFIED: lambda_max(S) <= mu by verified Cholesky of mu I - S (S scaled to integers: exact entries);
sigma_max(U)^2 = lambda_max(U U^T) <= mu by verified Cholesky of mu I - U U^T (U U^T computed exactly in integers).
Also the READING comparison with O2's hill-climbed sup.
Run: python -u -E -P code/cvx_rem.py > rec/rem.<date>.txt
"""
import sys, os, time
import numpy as np
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from cvx_core import h0_plaq
from cvx_verify import verified_lmin_lower

REC = os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', 'rec')


def load():
    D4i = np.load(os.path.join(REC, 'taylor_D4int.npy'))
    D5i = np.load(os.path.join(REC, 'taylor_D5int.npy'))
    den4, den5 = [int(x) for x in open(os.path.join(REC, 'taylor_den.txt')).read().split()]
    return D4i, den4, D5i, den5


def cert_lmax_upper(Sint, scale, mu_guess):
    """S = Sint / scale (Sint integer symmetric); certify lambda_max(S) <= mu by verified Cholesky of (mu scale I - Sint).
    returns the certified upper bound mu (smallest dyadic tried)."""
    for fac in (1.0 + 1e-6, 1.0 + 1e-4, 1.0 + 1e-2, 1.05, 1.2):
        mu = mu_guess * fac + 1e-12
        A = mu * scale * np.eye(Sint.shape[0]) - Sint.astype(float)
        # entries: mu*scale on the diagonal is a float product; bound its rounding by EA
        EA = np.zeros_like(A); np.fill_diagonal(EA, 4 * 2.0 ** -53 * (abs(mu * scale) + np.abs(np.diag(Sint)).astype(float)))
        lo, rb = verified_lmin_lower(A, 1e-9 * max(1.0, abs(mu * scale)), EA)
        if lo is not None and lo >= 0:
            return mu
    return None


def main():
    t0 = time.time()
    D4i, den4, D5i, den5 = load()
    # T = (1/2) D4 reshaped (k,a),(l,b) ; integer form: T = Tint / (2 den4)
    Tint = D4i.transpose(0, 2, 1, 3).reshape(144, 144)
    assert np.array_equal(Tint, Tint.T)
    h0 = h0_plaq().astype(np.int64)
    H0I = np.kron(h0, np.eye(12, dtype=np.int64))       # (k,a),(l,b) ordering: kron(h0_{kl}, delta_ab) -> index k*12+a
    # U = (1/6) D5 reshaped (k,a),(l,b,c) ; integer form Uint / (6 den5)
    Uint = D5i.transpose(0, 2, 1, 3, 4).reshape(144, 1728)
    UUt = Uint @ Uint.T                                   # exact int64
    print("T = Tint/%d, U = Uint/%d; max|Tint| %d, max|Uint| %d, max|U U^T int| %d" % (2 * den4, 6 * den5, np.abs(Tint).max(),
                                                                                      np.abs(Uint).max(), np.abs(UUt).max()))
    sig2 = np.linalg.eigvalsh(UUt.astype(float))[-1]
    smax_read = np.sqrt(sig2) / (6 * den5)
    mu = cert_lmax_upper(UUt, 1.0, sig2)
    smax_cert = np.sqrt(mu) / (6 * den5)
    print("sigma_max(U): READING %.6f, CERTIFIED <= %.6f  -> rho5(b) = 8 b^3 sigma_max = %.4f b^3" % (smax_read, smax_cert, 8 * smax_cert))
    print("rho6(b) = (1024/24) b^4 = %.4f b^4" % (1024 / 24))
    # c4(alpha') : rho4 = 4 b^2 lambda_max(-T - (alpha'/4) h0 (x) I)_+ with alpha = alpha' b^2
    print("quartic coefficient c4(alpha') [rho4 = c4 b^2, alpha = alpha' b^2]:")
    for ap in (0, 2, 4, 6, 8, 10, 12, 16, 20, 32, 64, 1e6):
        # S = -T - (ap/4) H0I ; scale to integers: multiply by 8 den4 (T = Tint/(2 den4)) -> -4 Tint - 2 ap den4 H0I
        if ap >= 1e5:
            # the limit: restrict -T to (ker h0) (x) R^12
            w, U_ = np.linalg.eigh(h0.astype(float))
            Pk = U_[:, w < 1e-9]
            Pbig = np.kron(Pk, np.eye(12))
            S = Pbig.T @ (-Tint.astype(float) / (2 * den4)) @ Pbig
            lm = np.linalg.eigvalsh(S)[-1]
            print("   alpha' -> inf: lambda_max(-T on ker h0) = %.6f -> c4 = %.4f (READING)" % (lm, 4 * max(lm, 0)))
            continue
        S_int = -4 * Tint - int(2 * ap * den4) * H0I       # = 8 den4 * (-T - (ap/4) H0I) exactly when 2*ap*den4 integer
        assert abs(2 * ap * den4 - int(2 * ap * den4)) < 1e-12
        lm_read = np.linalg.eigvalsh(S_int.astype(float))[-1] / (8 * den4)
        if lm_read <= 0:
            print("   alpha' = %5.1f: lambda_max <= 0 -> c4 = 0 (READING)" % ap)
            continue
        mu = cert_lmax_upper(S_int, 8 * den4, lm_read)
        print("   alpha' = %5.1f: lambda_max(-T - (alpha'/4) h0 x I) READING %.6f, CERTIFIED <= %s -> c4 = %.4f"
              % (ap, lm_read, ('%.6f' % mu) if mu else None, 4 * mu if mu else float('nan')))
    print("(%.1f s)" % (time.time() - t0))


if __name__ == '__main__':
    main()
