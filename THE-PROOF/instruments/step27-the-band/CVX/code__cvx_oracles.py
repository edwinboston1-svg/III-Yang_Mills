"""CVX ceiling oracles (READINGS; double precision; never enter a bound).
 O1  the exact linear-box value t* = max_{v in V} sum_l |m_l(v)| / v^T H0 v  (b_lin = 1/t*), alternating maximisation;
 O2  the per-plaquette remainder ceiling rho(alpha, b) = sup_phi lambda_max(h0 + h1(phi) - h(phi) - alpha h0) over (ball_b)^4;
     also e(b) = sup ||h(phi) - h0|| (M8's quantity) and the first-order sup ||h1|| / b;
 O3  majorant ceilings nu(q) = lambda_max(Q, H0 on V) for the diagonal and the |K|-majorants.
Run: python -u -E -P code/cvx_oracles.py WHICH L [args] > rec/oracle_<which>.<date>.txt
"""
import sys, time, os
import numpy as np
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from cvx_core import plaq_hess, plaq_h1, h0_plaq, Torus, TRIPLES, SIGMA3

rng = np.random.default_rng(int(os.environ.get('CVX_SEED', '20261102')))


def gen_whiten(T, H0):
    A = T.T @ H0 @ T
    w, U = np.linalg.eigh(A)
    W = U @ np.diag(w ** -0.5) @ U.T
    return W


def o1(L, nstart, maxit):
    Tor = Torus(L)
    Tf = Tor.full_T()
    H0 = Tor.H0()
    W = gen_whiten(Tf, H0)
    best = (0.0, None, None)
    t0 = time.time()
    hist = []
    for st in range(nstart):
        x = rng.normal(size=Tf.shape[1])
        v = Tf @ (W @ x)
        t_old = 0.0
        for it in range(maxit):
            m = Tor.m_vectors(v)
            nm = np.linalg.norm(m, axis=1)
            t = nm.sum() / (v @ H0 @ v)
            u = -m / np.where(nm[:, None] > 0, nm[:, None], 1.0)
            K = -Tor.H1(u.ravel())
            Mw = W @ (Tf.T @ K @ Tf) @ W
            ev, evec = np.linalg.eigh(Mw)
            v = Tf @ (W @ evec[:, -1])
            if t - t_old < 1e-10 * t:
                break
            t_old = t
        m = Tor.m_vectors(v)
        t = np.linalg.norm(m, axis=1).sum() / (v @ H0 @ v)
        hist.append(t)
        print("    start %3d: t = %.6f (b_lin %.5f) after %d iterations  [%.0f s]" % (st, t, 1 / t, it + 1, time.time() - t0), flush=True)
        if t > best[0]:
            best = (t, v.copy(), m.copy())
    t, v, m = best
    hist = np.sort(np.array(hist))[::-1]
    print("O1 L = %d: %d starts, t* (best) = %.6f -> b_lin = 1/t* = %.6f;  top-5 t: %s;  median %.4f  (%.0f s)"
          % (L, nstart, t, 1 / t, np.round(hist[:5], 5), np.median(hist), time.time() - t0))
    # structure of the maximiser
    vl = v.reshape(Tor.nLk, 3)
    sv = np.linalg.svd(vl, compute_uv=False)
    print("    maximiser v: colour singular values (normalised) %s; v^T H0 v / |v|^2 = %.5f (gamma0 %.5f)"
          % (np.round(sv / sv[0], 4), (v @ H0 @ v) / (v @ v), np.linalg.eigvalsh(Tf.T @ H0 @ Tf)[0]))
    nm = np.linalg.norm(m, axis=1)
    u = -m / np.where(nm[:, None] > 0, nm[:, None], 1.0)
    # the worst B = b_lin * u : its plaquette angles and whether it lies near V
    B = (1 / t) * u.ravel()
    from cvx_core import plaq_value
    th = np.arccos(np.clip(1 - plaq_value(Tor.plaq_phi(B)), -1, 1))
    PV = Tf @ (Tf.T @ B)
    print("    worst B at b_lin: max plaquette angle %.4f, mean %.4f; |P_V B| / |B| = %.4f (fraction of the box direction inside V)"
          % (th.max(), th.mean(), np.linalg.norm(PV) / np.linalg.norm(B)))
    # check: lambda_min(H0 + H1(B)) on V at B = b_lin * u should be ~ 0
    lm = np.linalg.eigvalsh(Tf.T @ (H0 + Tor.H1(B)) @ Tf)[0]
    print("    check: lambda_min(H0 + H1(b_lin u)) on V = %.3e (0 at the critical b by construction for the maximiser)" % lm)
    # the full nonlinear Hessian at the same B (READING): is the linear worst case non-convex in the true action?
    for fac in (0.8, 1.0, 1.2, 1.5):
        lmf = np.linalg.eigvalsh(Tf.T @ Tor.hess(fac * B) @ Tf)[0]
        print("    full Hessian at %.1f x b_lin u: lambda_min on V = %.5f" % (fac, lmf))
    return t


def rand_ball(n, b, sphere_frac=0.5):
    d = rng.normal(size=(n, 4, 3)); d /= np.linalg.norm(d, axis=-1, keepdims=True)
    rad = rng.uniform(0, 1, size=(n, 4, 1)) ** (1 / 3)
    ns = int(n * sphere_frac)
    rad[:ns] = 1.0
    return b * d * rad


def proj_ball(phi, b):
    r = np.linalg.norm(phi, axis=-1, keepdims=True)
    return np.where(r > b, phi * (b / np.maximum(r, 1e-300)), phi)


def o2_objective(phi, alpha, kind):
    h = plaq_hess(phi)
    h0 = h0_plaq()[None]
    if kind == 'rem':          # lambda_max(h0 + h1 - h - alpha h0)
        M = h0 + plaq_h1(phi) - h - alpha * h0
        return np.linalg.eigvalsh(M)[:, -1]
    if kind == 'full':         # lambda_max(h0 - h - alpha h0): the full change, relative
        M = h0 - h - alpha * h0
        return np.linalg.eigvalsh(M)[:, -1]
    if kind == 'enorm':        # ||h - h0|| (M8's e(b))
        return np.abs(np.linalg.eigvalsh(h - h0)).max(axis=1)
    raise ValueError(kind)


def o2_sup(b, alpha, kind, npop=3000, ntop=40, nit=250, nprop=24):
    phi = rand_ball(npop, b)
    val = o2_objective(phi, alpha, kind)
    order = np.argsort(-val)[:ntop]
    best_val = val.max()
    best_phi = phi[order[0]]
    for i0 in order:
        cur = phi[i0].copy(); cv = val[i0]; step = 0.5 * b
        for it in range(nit):
            prop = proj_ball(cur[None] + step * rng.normal(size=(nprop, 4, 3)), b)
            pv = o2_objective(prop, alpha, kind)
            k = int(np.argmax(pv))
            if pv[k] > cv:
                cur, cv = prop[k], pv[k]
            else:
                step *= 0.93
            if step < 1e-4 * b:
                break
        if cv > best_val:
            best_val, best_phi = cv, cur
    return best_val, best_phi


def o2(blist, alist):
    t0 = time.time()
    for b in blist:
        e, ph = o2_sup(b, 0.0, 'enorm')
        print("O2 b = %.3f: e(b) = sup ||h - h0|| >= %.5f (e/b = %.4f)  [%.0f s]" % (b, e, e / b, time.time() - t0))
        for kind in ('rem', 'full'):
            row = []
            for a in alist:
                r, ph = o2_sup(b, a, kind)
                row.append(r)
                rr = np.linalg.norm(ph, axis=-1)
                print("    %-4s alpha = %.2f: sup lambda_max = %.5f  (/b^2 = %.3f; link radii at the sup %s)  [%.0f s]"
                      % (kind, a, r, r / b ** 2, np.round(rr, 3), time.time() - t0))


def o3(L):
    """majorant ceilings: (i) the diagonal sqrt(3)-majorant, (ii) the |K|-majorant per (p, c)."""
    Tor = Torus(L)
    T0 = Tor.T0
    H0c = Tor.H0c.astype(float)
    g0 = np.linalg.eigvalsh(T0.T @ H0c @ T0)[0]
    # (ii) per plaquette p, per background link c in p: the charged Hermitian form K_{p,c} on the 3 other links;
    # |K| = sqrt(3)(I - n n^T), n the unit null vector of the real antisymmetric Omega (K = -i Omega).
    Qa = np.zeros((Tor.nLk, Tor.nLk))
    Qd = np.zeros((Tor.nLk, Tor.nLk))
    # build Omega_{p,c} from SIGMA3 and the det structure: coefficient of Im(conj w_a w_b) for the pair (a,b) when phi_c = e3
    for p in range(Tor.nP):
        links = Tor.plaqs[p]
        for c in range(4):
            others = [i for i in range(4) if i != c]
            Om = np.zeros((4, 4))
            for t, (a, bb, cc) in enumerate(TRIPLES):
                sg = SIGMA3[t]
                # derivative wrt phi_c of h1[v,v] = 2 sg (pair cross product) along the cyclic order
                if cc == c:
                    i, j = a, bb      # 2 sg (v_a x v_b)
                elif bb == c:
                    i, j = cc, a      # 2 sg (v_c x v_a)
                elif a == c:
                    i, j = bb, cc     # 2 sg (v_b x v_c)
                else:
                    continue
                # e3 . (v_i x v_j) = Im(conj w_i w_j): coefficient 2 sg on the ordered pair (i, j)
                Om[i, j] += 2 * sg
                Om[j, i] -= 2 * sg
            # Hermitian K = Om / (2i) on w; its absolute value
            K = Om / 2j
            w, U = np.linalg.eigh(K)
            absK = (U * np.abs(w)) @ U.conj().T
            assert np.abs(absK.imag).max() < 1e-12
            absK = absK.real
            for ii in range(4):
                for jj in range(4):
                    Qa[links[ii], links[jj]] += absK[ii, jj]
            for ii in others:
                Qd[links[ii], links[ii]] += np.sqrt(3.0)
            if p == 0 and c == 0:
                print("O3 L = %d: K_{p,c} eigenvalues %s ; |K| eigenvalues %s" % (L, np.round(np.linalg.eigvalsh(K), 6), np.round(np.linalg.eigvalsh(absK), 6)))
    for name, Qm in (('diagonal sqrt(3)', Qd), ('|K| per (p,c)', Qa)):
        A = T0.T @ H0c @ T0
        Bm = T0.T @ Qm @ T0
        w, U = np.linalg.eigh(A)
        Wh = U @ np.diag(w ** -0.5) @ U.T
        nu = np.linalg.eigvalsh(Wh @ Bm @ Wh)[-1]
        print("    %-18s: lambda_max(Q) on V = %.4f, nu = lambda_max(Q, H0|V) = %.4f -> b_lin(q) = 1/nu = %.5f  (gamma0 %.5f)"
              % (name, np.linalg.eigvalsh(Bm)[-1], nu, 1 / nu, g0))


if __name__ == '__main__':
    which = sys.argv[1]
    if which == 'o1':
        o1(int(sys.argv[2]), int(sys.argv[3]), int(sys.argv[4]))
    elif which == 'o2':
        o2([float(x) for x in sys.argv[2].split(',')], [float(x) for x in sys.argv[3].split(',')])
    elif which == 'o3':
        o3(int(sys.argv[2]))
