"""CVX — the three-point certificate on the PROJECTED O1 direction itself (no climb): B = s P_V u / sup|P_V u|, s in a list.
Same exactness discipline as cvx_upper.py (exact rational V, interval S).
Run: python -u -E -P code/cvx_upper2.py L s_list > rec/upper2_L<L>.<date>.txt
"""
import sys, os, time
from fractions import Fraction as Fr
import numpy as np
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from cvx_core import Torus, plaq_value
from cvx_upper import o1_direction, lam_min, supn, exact_kernel_basis, S_interval

REC = os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', 'rec')


def main():
    L = int(sys.argv[1]); slist = [float(x) for x in sys.argv[2].split(',')]
    t0 = time.time()
    rng = np.random.default_rng(20261102)
    Tor = Torus(L); Tf = Tor.full_T(); H0 = Tor.H0()
    t, u = o1_direction(Tor, Tf, H0, rng)
    np.save(os.path.join(REC, 'o1_u_L%d.npy' % L), u)
    PVu = Tf @ (Tf.T @ u.ravel())
    Bhat = PVu / supn(Tor, PVu)
    print("O1 direction t = %.6f; P_V u normalised to sup norm 1  [%.0f s]" % (t, time.time() - t0), flush=True)
    import mpmath as mp
    mp.mp.dps = 60; mp.iv.dps = 60
    C0 = np.vstack([Tor.Q0, Tor.G0.T]).astype(np.int64)
    basis = exact_kernel_basis(C0)
    N0 = np.array([[float(x) for x in col] for col in basis]).T
    def exact_coeffs(Y):
        c, *_ = np.linalg.lstsq(N0, Y, rcond=None)
        return [[Fr(int(round(x * 2 ** 30)), 2 ** 30) for x in c[:, a]] for a in range(3)]
    nz = [[k for k in range(len(basis)) if basis[k][l] != 0] for l in range(Tor.nLk)]
    def assemble(cc):
        return [[sum((basis[k][l] * cc[a][k] for k in nz[l]), Fr(0)) for a in range(3)] for l in range(Tor.nLk)]
    for s in slist:
        B = s * Bhat
        w, U_ = np.linalg.eigh(Tf.T @ Tor.hess(B) @ Tf)
        th = np.arccos(np.clip(1 - plaq_value(Tor.plaq_phi(B)), -1, 1))
        print("s = %.4f: lambda_min READING % .6f (max plaquette angle %.4f)" % (s, w[0], th.max()), flush=True)
        if w[0] > -0.02:
            continue
        wvec = (Tf @ U_[:, 0]).reshape(Tor.nLk, 3)
        Bq = assemble(exact_coeffs(B.reshape(Tor.nLk, 3)))
        Wq = assemble(exact_coeffs(wvec))
        for a in range(3):
            for P in (Bq, Wq):
                col = [P[l][a] for l in range(Tor.nLk)]
                for row in C0:
                    assert sum(int(row[l]) * col[l] for l in range(Tor.nLk) if row[l] != 0) == 0
        for eps in (Fr(1, 64), Fr(1, 128)):
            Bp = [[Bq[l][a] + eps * Wq[l][a] for a in range(3)] for l in range(Tor.nLk)]
            Bm = [[Bq[l][a] - eps * Wq[l][a] for a in range(3)] for l in range(Tor.nLk)]
            sup2 = max(max(sum(x * x for x in P[l]) for l in range(Tor.nLk)) for P in (Bq, Bp, Bm))
            D = S_interval(Tor, Bp, mp) + S_interval(Tor, Bm, mp) - 2 * S_interval(Tor, Bq, mp)
            bprime = mp.sqrt(mp.mpf(sup2.numerator) / sup2.denominator)
            verdict = 'CERTIFIED NON-CONVEX on D_b\' with b\' = %s' % mp.nstr(bprime, 12) if D.b < 0 else 'not certified'
            print("   eps = %s: B, w EXACTLY in V; second difference in [%s, %s]; sup link radius of the three points %s -> %s  [%.0f s]"
                  % (eps, mp.nstr(D.a, 8), mp.nstr(D.b, 8), mp.nstr(bprime, 12), verdict, time.time() - t0), flush=True)
            if D.b < 0:
                break


if __name__ == '__main__':
    main()
