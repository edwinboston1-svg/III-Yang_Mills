"""CVX — the CERTIFIED UPPER BOUND on the convexity radius (derivative-free three-point test), seeded by O1's linear worst case.
 1. reproduce O1's maximiser direction u (|u_l| = 1) on the L = 2 torus (READING);
 2. adversarial climb inside V at fixed sup norm b, from P_V(u) (READING): lambda_min(Hess S(B)|V) against b;
 3. CERTIFIED: B*, w EXACTLY in V (rational basis of ker C0, dyadic coefficients), S at B* - eps w, B*, B* + eps w in mpmath
    interval arithmetic (60 digits); S(B* + eps w) + S(B* - eps w) - 2 S(B*) < 0 and all three points in D_{b'} (box checked exactly)
    => S is not convex on D_{b'}.
Run: python -u -E -P code/cvx_upper.py L > rec/upper_L<L>.<date>.txt
"""
import sys, os, time
from fractions import Fraction as Fr
import numpy as np
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from cvx_core import Torus, plaq_value

REC = os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', 'rec')


def o1_direction(Tor, Tf, H0, rng, nstart=12, maxit=60):
    A = Tf.T @ H0 @ Tf
    w, U = np.linalg.eigh(A)
    W = U @ np.diag(w ** -0.5) @ U.T
    best = (0, None)
    for st in range(nstart):
        v = Tf @ (W @ rng.normal(size=Tf.shape[1]))
        t_old = 0
        for it in range(maxit):
            m = Tor.m_vectors(v)
            nm = np.linalg.norm(m, axis=1)
            t = nm.sum() / (v @ H0 @ v)
            u = -m / np.where(nm[:, None] > 0, nm[:, None], 1.0)
            K = -Tor.H1(u.ravel())
            ev, evec = np.linalg.eigh(W @ (Tf.T @ K @ Tf) @ W)
            v = Tf @ (W @ evec[:, -1])
            if t - t_old < 1e-10 * t:
                break
            t_old = t
        if t > best[0]:
            best = (t, u.copy())
    return best


def lam_min(Tor, Tf, B):
    return np.linalg.eigvalsh(Tf.T @ Tor.hess(B) @ Tf)


def supn(Tor, B):
    return np.linalg.norm(B.reshape(Tor.nLk, 3), axis=1).max()


def climb(Tor, Tf, B0, b, rng, nit=300, nprop=12):
    """minimise lambda_min over B in V with sup norm exactly b, from B0 (READING)."""
    def norm_to(B):
        return b * B / supn(Tor, B)
    cur = norm_to(B0); cv = lam_min(Tor, Tf, cur)[0]; step = 0.3
    for it in range(nit):
        props = [norm_to(cur + step * b * (Tf @ rng.normal(size=Tf.shape[1])) / np.sqrt(Tf.shape[1]) * 4) for _ in range(nprop)]
        vals = [lam_min(Tor, Tf, P)[0] for P in props]
        k = int(np.argmin(vals))
        if vals[k] < cv:
            cur, cv = props[k], vals[k]
        else:
            step *= 0.9
        if step < 1e-3:
            break
    return cur, cv


def exact_kernel_basis(C):
    """rational basis of ker C (C integer numpy), via Fraction RREF.  returns list of Fraction column vectors (as lists)."""
    m, n = C.shape
    R = [[Fr(int(x)) for x in row] for row in C]
    piv = []
    r = 0
    for c in range(n):
        p = None
        for i in range(r, m):
            if R[i][c] != 0:
                p = i; break
        if p is None:
            continue
        R[r], R[p] = R[p], R[r]
        inv = 1 / R[r][c]
        R[r] = [x * inv for x in R[r]]
        for i in range(m):
            if i != r and R[i][c] != 0:
                f = R[i][c]
                R[i] = [a - f * bb for a, bb in zip(R[i], R[r])]
        piv.append(c)
        r += 1
        if r == m:
            break
    free = [c for c in range(n) if c not in piv]
    basis = []
    for fc in free:
        vec = [Fr(0)] * n
        vec[fc] = Fr(1)
        for i, pc in enumerate(piv):
            vec[pc] = -R[i][fc]
        basis.append(vec)
    return basis


def S_interval(Tor, Bq, mp):
    """Wilson action per unit beta at the rational configuration Bq (list over links of 3 Fractions), mpmath interval."""
    iv = mp.iv
    quats = []
    for l in range(Tor.nLk):
        b = Bq[l]
        r2 = b[0] * b[0] + b[1] * b[1] + b[2] * b[2]
        if r2 == 0:
            quats.append((iv.mpf(1), iv.mpf(0), iv.mpf(0), iv.mpf(0)))
            continue
        r2i = iv.mpf([r2.numerator, r2.numerator]) / iv.mpf([r2.denominator, r2.denominator])
        r = iv.sqrt(r2i)
        c = iv.cos(r)
        s = iv.sin(r) / r
        comps = [iv.mpf([x.numerator, x.numerator]) / iv.mpf([x.denominator, x.denominator]) for x in b]
        quats.append((c, -s * comps[0], -s * comps[1], -s * comps[2]))

    def qm(p, q):
        p0, p1, p2, p3 = p; q0, q1, q2, q3 = q
        return (p0 * q0 - p1 * q1 - p2 * q2 - p3 * q3, p0 * q1 + q0 * p1 + p2 * q3 - p3 * q2,
                p0 * q2 + q0 * p2 + p3 * q1 - p1 * q3, p0 * q3 + q0 * p3 + p1 * q2 - p2 * q1)

    def conj(q):
        return (q[0], -q[1], -q[2], -q[3])
    tot = iv.mpf(0)
    for (a, b, c, d) in Tor.plaqs:
        P = qm(qm(qm(quats[a], quats[b]), conj(quats[c])), conj(quats[d]))
        tot = tot + (1 - P[0])
    return tot


def main():
    L = int(sys.argv[1])
    t0 = time.time()
    rng = np.random.default_rng(20261102)
    Tor = Torus(L)
    Tf = Tor.full_T()
    H0 = Tor.H0()
    t, u = o1_direction(Tor, Tf, H0, rng)
    print("1. O1 direction reproduced: t = %.6f (b_lin %.5f)  [%.0f s]" % (t, 1 / t, time.time() - t0), flush=True)
    PVu = Tf @ (Tf.T @ u.ravel())
    print("   |P_V u| / |u| = %.4f; sup-norm of P_V u = %.4f" % (np.linalg.norm(PVu) / np.linalg.norm(u), supn(Tor, PVu)))
    # 2. scan of the projected direction, then the climb
    print("2. the projected direction B = s P_V u / sup|P_V u| (sup norm s):")
    Bhat = PVu / supn(Tor, PVu)
    for s in (0.2, 0.25, 0.3, 0.35, 0.4, 0.45, 0.5):
        lm = lam_min(Tor, Tf, s * Bhat)[0]
        th = np.arccos(np.clip(1 - plaq_value(Tor.plaq_phi(s * Bhat)), -1, 1))
        print("   sup norm %.3f: lambda_min = % .5f   (max plaquette angle %.4f)" % (s, lm, th.max()), flush=True)
    results = {}
    for b in (0.25, 0.3, 0.35, 0.4):
        B, lv = climb(Tor, Tf, Bhat, b, rng)
        results[b] = (B, lv)
        th = np.arccos(np.clip(1 - plaq_value(Tor.plaq_phi(B)), -1, 1))
        print("   climb at sup norm %.3f: lambda_min = % .5f (max plaquette angle %.4f)  [%.0f s]" % (b, lv, th.max(), time.time() - t0), flush=True)
    # 3. certification at the smallest b with a clearly negative lambda_min
    cand = [b for b in sorted(results) if results[b][1] < -0.05]
    if not cand:
        print("no clearly non-convex configuration below 0.4"); return
    b = cand[0]
    B, lv = results[b]
    np.save(os.path.join(REC, 'upper_L%d_B.npy' % L), B)
    import mpmath as mp
    mp.mp.dps = 60
    mp.iv.dps = 60
    C0 = np.vstack([Tor.Q0, Tor.G0.T]).astype(np.int64)
    basis = exact_kernel_basis(C0)
    N0 = np.array([[float(x) for x in col] for col in basis]).T          # (nLk, dimV0), float image of the exact basis
    print("3. exact rational basis of ker C0: %d vectors (dim V0 = %d)" % (len(basis), Tor.dimV0))
    # coefficients: B (nLk x 3) ~ N0 c per colour, least squares, rounded to dyadic
    Bl = B.reshape(Tor.nLk, 3)
    w, U_ = np.linalg.eigh(Tf.T @ Tor.hess(B) @ Tf)
    wvec = (Tf @ U_[:, 0]).reshape(Tor.nLk, 3)
    def exact_coeffs(Y):
        c, *_ = np.linalg.lstsq(N0, Y, rcond=None)
        return [[Fr(int(round(x * 2 ** 30)), 2 ** 30) for x in c[:, a]] for a in range(3)]
    cB = exact_coeffs(Bl)
    cw = exact_coeffs(wvec)
    def assemble(cc, scale=Fr(1)):
        out = []
        for l in range(Tor.nLk):
            row = basis  # noqa
            vals = []
            for a in range(3):
                vals.append(sum((basis[k][l] * cc[a][k] for k in range(len(basis)) if basis[k][l] != 0), Fr(0)) * scale)
            out.append(vals)
        return out
    Bq = assemble(cB)
    Wq = assemble(cw)
    # check exact membership: C0 applied to each colour component is exactly zero
    for a in range(3):
        col = [Bq[l][a] for l in range(Tor.nLk)]
        for row in C0:
            assert sum(int(row[l]) * col[l] for l in range(Tor.nLk) if row[l] != 0) == 0
    print("   B* and w rebuilt EXACTLY in V (C0 . component = 0 exactly, all three colours)")
    for eps in (Fr(1, 50), Fr(1, 100)):
        Bp = [[Bq[l][a] + eps * Wq[l][a] for a in range(3)] for l in range(Tor.nLk)]
        Bm = [[Bq[l][a] - eps * Wq[l][a] for a in range(3)] for l in range(Tor.nLk)]
        sup2 = max(max(sum(x * x for x in P[l]) for l in range(Tor.nLk)) for P in (Bq, Bp, Bm))
        Sp, Sm, S0 = S_interval(Tor, Bp, mp), S_interval(Tor, Bm, mp), S_interval(Tor, Bq, mp)
        D = Sp + Sm - 2 * S0
        bprime = mp.sqrt(mp.mpf(sup2.numerator) / sup2.denominator)
        print("   eps = %s: second difference S(B+ew) + S(B-ew) - 2S(B) in %s; all three points have link radius <= %s"
              % (eps, D, mp.nstr(bprime, 12)))
        if D.b < 0:
            print("   CERTIFIED: S is NOT convex on D_b' with b' = %s (exact sup of the three points; rounded up: %.6f)"
                  % (mp.nstr(bprime, 15), float(bprime) + 1e-12))
    print("(%.0f s)" % (time.time() - t0))


if __name__ == '__main__':
    main()
