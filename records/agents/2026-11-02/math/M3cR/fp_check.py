r"""M3cR: numerical (double precision) check of M3c's Lemma FP on a structural toy.

SU(2) on a 2-D periodic N x N lattice, blocks of side 3 centred at sites with both coordinates = 1 mod 3.
Constraint: coarse link = ordered product along the straight fine path through two block centres; the middle
fine link b0(c) of each coarse path is eliminated exactly.  Residual group R = gauge transformations trivial at
block centres.  Gauge fixing on Federbush-averaged contour variables U(y,x), x in B(y) minus {y}.
Background = minimiser of (gauge fixing + Wilson action) on the constraint surface (axial representative of the
constrained minimal orbit).

Group elements are QUATERNIONS q = (a0, a1, a2, a3) <-> U = a0 I + i (a.sigma), so every function is real on real
inputs and holomorphic: complex-step first derivatives are then exact to rounding (the 2x2-matrix version fails:
tr U carries a 1e-16 imaginary rounding that a complex step of 1e-20 amplifies).

This is a CHECK of the linear-algebra / Morse-Bott structure of Lemma FP, not a proof, and not Balaban's operators.
usage: python fp_check.py N seed1 [seed2 ...]
"""
import sys, time
import numpy as np
import scipy.optimize as so

HCS = 1e-30     # complex-step size (exact first derivatives)
HFD = 1e-5      # finite-difference step for the second derivative
SIG = np.array([[[0, 1], [1, 0]], [[0, -1j], [1j, 0]], [[1, 0], [0, -1]]], dtype=complex)


# ------------------------------------------------------------------ quaternion group arithmetic
def qmul(p, q):
    p0, pv = p[..., :1], p[..., 1:]
    q0, qv = q[..., :1], q[..., 1:]
    r0 = p0 * q0 - np.sum(pv * qv, axis=-1, keepdims=True)
    rv = p0 * qv + q0 * pv - np.cross(pv, qv)
    return np.concatenate([r0, rv], axis=-1)


def qinv(q):
    n2 = np.sum(q * q, axis=-1, keepdims=True)
    return np.concatenate([q[..., :1], -q[..., 1:]], axis=-1) / n2


def expX(X):
    """quaternion of exp(i X.sigma/2), X[...,3] (complex allowed)."""
    z2 = 0.25 * np.sum(X * X, axis=-1)
    small = np.abs(z2) < 1e-6
    zs = np.sqrt(np.where(small, 1.0, z2) + 0j)
    c = np.where(small, 1 - z2 / 2 + z2 ** 2 / 24 - z2 ** 3 / 720, np.cos(zs))
    s = np.where(small, 1 - z2 / 6 + z2 ** 2 / 120 - z2 ** 3 / 5040, np.sin(zs) / zs)
    if not np.iscomplexobj(X):
        c, s = c.real, s.real
    return np.concatenate([c[..., None], 0.5 * s[..., None] * X], axis=-1)


def logX(q):
    """X with q = exp(i X.sigma/2), q near the identity (a0 > 0)."""
    a = q[..., 1:]
    s2 = np.sum(a * a, axis=-1)
    small = np.abs(s2) < 1e-6
    ss = np.sqrt(np.where(small, 0.25, s2) + 0j)
    r = np.where(small, 1 + s2 / 6 + 3 * s2 ** 2 / 40 + 5 * s2 ** 3 / 112 + 35 * s2 ** 4 / 1152,
                 np.arcsin(ss) / ss)
    if not np.iscomplexobj(q):
        r = r.real
    return 2 * a * r[..., None]


def q2mat(q):
    return q[..., 0, None, None] * np.eye(2) + 1j * np.einsum('...a,aij->...ij', q[..., 1:], SIG)


IDQ = np.array([1.0, 0.0, 0.0, 0.0])


class Lattice:
    def __init__(self, N):
        assert N % 3 == 0
        self.N = N
        self.nlink = 2 * N * N
        self.lid = lambda i, j, mu: ((i % N) * N + (j % N)) * 2 + mu
        self.centres = [(i, j) for i in range(1, N, 3) for j in range(1, N, 3)]
        cset = set(self.centres)
        self.noncentre = [(i, j) for i in range(N) for j in range(N) if (i, j) not in cset]
        self.coarse = []
        for (i, j) in self.centres:
            for mu in (0, 1):
                e = (1, 0) if mu == 0 else (0, 1)
                self.coarse.append((self.lid(i, j, mu), self.lid(i + e[0], j + e[1], mu),
                                    self.lid(i + 2 * e[0], j + 2 * e[1], mu)))
        self.b0 = np.array([c[1] for c in self.coarse])
        self.cfirst = np.array([c[0] for c in self.coarse])
        self.clast = np.array([c[2] for c in self.coarse])
        mask = np.ones(self.nlink, bool)
        mask[self.b0] = False
        self.free = np.nonzero(mask)[0]
        self.nfree = len(self.free)
        self.plaq = np.array([(self.lid(i, j, 0), self.lid(i + 1, j, 1), self.lid(i, j + 1, 0), self.lid(i, j, 1))
                              for i in range(N) for j in range(N)])
        # gauge-fixing contours (CMP 109 (0.11)): from centre y to x = y + n, n in {-1,0,1}^2 minus 0
        self.gf = []
        for (i, j) in self.centres:
            for n0 in (-1, 0, 1):
                for n1 in (-1, 0, 1):
                    if n0 == 0 and n1 == 0:
                        continue
                    paths = []
                    orders = [(0, 1), (1, 0)] if (n0 != 0 and n1 != 0) else [(0, 1)]
                    for order in orders:
                        cur = [i, j]
                        path = []
                        for mu in order:
                            step = n0 if mu == 0 else n1
                            if step == 0:
                                continue
                            if step > 0:
                                path.append((self.lid(cur[0], cur[1], mu), +1))
                                cur[mu] += 1
                            else:
                                cur[mu] -= 1
                                path.append((self.lid(cur[0], cur[1], mu), -1))
                        paths.append(path)
                    self.gf.append(paths)
        self.ngf = len(self.gf)
        gs_k, gs_l, gs_s, gd_k, gd = [], [], [], [], []
        for k, paths in enumerate(self.gf):
            if len(paths) == 1:
                assert len(paths[0]) == 1
                gs_k.append(k); gs_l.append(paths[0][0][0]); gs_s.append(paths[0][0][1])
            else:
                assert len(paths) == 2 and len(paths[0]) == 2 and len(paths[1]) == 2
                gd_k.append(k)
                gd.append([paths[0][0][0], paths[0][0][1], paths[0][1][0], paths[0][1][1],
                           paths[1][0][0], paths[1][0][1], paths[1][1][0], paths[1][1][1]])
        self.gs_k, self.gs_l, self.gs_s = np.array(gs_k), np.array(gs_l), np.array(gs_s)
        self.gd_k, self.gd = np.array(gd_k), np.array(gd)
        self.lsite0 = np.empty(self.nlink, int)
        self.lsite1 = np.empty(self.nlink, int)
        for i in range(N):
            for j in range(N):
                for mu in (0, 1):
                    e = (1, 0) if mu == 0 else (0, 1)
                    l = self.lid(i, j, mu)
                    self.lsite0[l] = i * N + j
                    self.lsite1[l] = ((i + e[0]) % N) * N + (j + e[1]) % N

    def build(self, Xfree, Uref, W):
        dt = complex if (np.iscomplexobj(Xfree) or np.iscomplexobj(Uref)) else float
        U = np.array(Uref, dtype=dt)
        U[self.free] = qmul(expX(Xfree.reshape(-1, 3)), Uref[self.free])
        U[self.b0] = qmul(qmul(qinv(U[self.cfirst]), W), qinv(U[self.clast]))
        return U

    def coarse_links(self, U):
        return qmul(qmul(U[self.cfirst], U[self.b0]), U[self.clast])

    def plaquettes(self, U):
        p = self.plaq
        return qmul(qmul(qmul(U[p[:, 0]], U[p[:, 1]]), qinv(U[p[:, 2]])), qinv(U[p[:, 3]]))

    def wilson(self, U):
        return np.sum(1 - self.plaquettes(U)[:, 0])

    def contour_vars_loop(self, U):
        out = []
        for paths in self.gf:
            prods = []
            for path in paths:
                M = IDQ.astype(U.dtype)
                for (l, s) in path:
                    M = qmul(M, U[l] if s > 0 else qinv(U[l]))
                prods.append(M)
            if len(prods) == 1:
                out.append(prods[0])
            else:
                out.append(qmul(expX(0.5 * logX(qmul(prods[0], qinv(prods[1])))), prods[1]))
        return np.array(out)

    def contour_vars(self, U):
        Ui = qinv(U)
        pick = lambda l, s: np.where((s > 0)[:, None], U[l], Ui[l])
        out = np.empty((self.ngf, 4), dtype=U.dtype)
        out[self.gs_k] = pick(self.gs_l, self.gs_s)
        g = self.gd
        P1 = qmul(pick(g[:, 0], g[:, 1]), pick(g[:, 2], g[:, 3]))
        P2 = qmul(pick(g[:, 4], g[:, 5]), pick(g[:, 6], g[:, 7]))
        # Federbush average (CMP 109 (0.10)) of two elements: exp(1/2 log(P1 P2^-1)) P2
        out[self.gd_k] = qmul(expX(0.5 * logX(qmul(P1, qinv(P2)))), P2)
        return out

    def gaugefix(self, U):
        return np.sum(1 - self.contour_vars(U)[:, 0])

    def gauge_transform(self, U, g):
        """U(x,mu) -> g(x) U(x,mu) g(x+e_mu)^-1, g[N*N,4]."""
        return qmul(qmul(g[self.lsite0], U), qinv(g)[self.lsite1])


def cs_grad(f, x, h=HCS):
    n = len(x)
    g = np.empty(n)
    xc = x.astype(complex)
    for k in range(n):
        xc[k] += 1j * h
        g[k] = np.imag(f(xc)) / h
        xc[k] -= 1j * h
    return g


def cs_jac(f, x, h=HCS):
    n = len(x)
    xc = x.astype(complex)
    cols = []
    for k in range(n):
        xc[k] += 1j * h
        cols.append(np.imag(np.asarray(f(xc)).ravel()) / h)
        xc[k] -= 1j * h
    return np.array(cols).T


def hessian(f, x, k=HFD):
    n = len(x)
    H = np.empty((n, n))
    for j in range(n):
        e = np.zeros(n)
        e[j] = k
        H[:, j] = (cs_grad(f, x + e) - cs_grad(f, x - e)) / (2 * k)
    asym = np.max(np.abs(H - H.T))
    return 0.5 * (H + H.T), asym


def rand_su2(rng, n, scale):
    return expX(scale * rng.standard_normal((n, 3)))


def find_background(lat, W, Uinit, log):
    """BFGS on (Wilson + gauge fixing) over the constraint surface, then Newton polish (the gauge-fixing term
    makes the Hessian non-degenerate), re-centring the chart after every step."""
    Uref = np.array(Uinit)
    n = 3 * lat.nfree

    def make(Uref):
        def phi(X):
            U = lat.build(X, Uref, W)
            return lat.wilson(U) + lat.gaugefix(U)
        return phi

    def recentre(Uref, X):
        U = lat.build(X, Uref, W)
        U = U / np.sqrt(np.sum(U * U, axis=-1, keepdims=True))   # back onto SU(2)
        return lat.build(np.zeros(n), U, W)

    for rnd in range(3):
        phi = make(Uref)
        res = so.minimize(lambda X: float(np.real(phi(X))), np.zeros(n), jac=lambda X: cs_grad(phi, X),
                          method='BFGS', options={'gtol': 1e-10, 'maxiter': 2000})
        Uref = recentre(Uref, res.x)
        gn = np.linalg.norm(cs_grad(make(Uref), np.zeros(n)))
        log(f"   BFGS round {rnd}: Phi={float(np.real(make(Uref)(np.zeros(n)))):.15f} |grad|={gn:.2e} nit={res.nit}")
        if gn < 1e-6:
            break
    for it in range(4):
        phi = make(Uref)
        g0 = cs_grad(phi, np.zeros(n))
        Hphi, _ = hessian(phi, np.zeros(n))
        step = -np.linalg.solve(Hphi, g0)
        Uref = recentre(Uref, step)
        gn = np.linalg.norm(cs_grad(make(Uref), np.zeros(n)))
        log(f"   Newton {it}: |step|={np.linalg.norm(step):.2e} |grad|={gn:.2e} "
            f"min eig Hess(Phi)={np.linalg.eigvalsh(Hphi).min():+.3e}")
        if gn < 1e-12:
            break
    return Uref


def analyse(lat, Ubg, W, label, log):
    n = 3 * lat.nfree
    z = np.zeros(n)
    F = lambda X: lat.wilson(lat.build(X, Ubg, W))
    gradF = cs_grad(F, z)
    Cbg_inv = qinv(lat.contour_vars(Ubg))
    Bt = lambda X: logX(qmul(lat.contour_vars(lat.build(X, Ubg, W)), Cbg_inv))
    t0 = time.time()
    H, asym = hessian(F, z)
    L = cs_jac(Bt, z)
    Gcols = []
    Ubg_free_inv = qinv(Ubg[lat.free])
    for (i, j) in lat.noncentre:
        for a in range(3):
            g = np.tile(IDQ, (lat.N * lat.N, 1)).astype(complex)
            e = np.zeros(3, complex)
            e[a] = 1j * HCS
            g[i * lat.N + j] = expX(e)
            Ut = lat.gauge_transform(Ubg.astype(complex), g)
            Gcols.append(np.imag(logX(qmul(Ut[lat.free], Ubg_free_inv)).ravel()) / HCS)
    G = np.array(Gcols).T
    pang = np.linalg.norm(logX(lat.plaquettes(Ubg)), axis=-1)
    log(f"[{label}] n={n} dimR={G.shape[1]} rows(L)={L.shape[0]} |gradF|={np.linalg.norm(gradF):.2e} "
        f"axial residual max|logU(y,x)|={np.max(np.abs(logX(lat.contour_vars(Ubg)))):.2e} plaquette |angle| "
        f"min {pang.min():.3f} max {pang.max():.3f}; Hessian asymmetry {asym:.1e} (time {time.time()-t0:.1f}s)")
    return dict(H=H, L=L, G=G, gradF=gradF)


def ratio_test(H, L, G, nT, label, log, ws=(1.0,), ds=(0.3, -0.25, 0.1 + 0.2j)):
    HG = np.linalg.norm(H @ G) / (np.linalg.norm(H) * np.linalg.norm(G))
    sv = np.linalg.svd(L @ G, compute_uv=False)
    rankL = np.linalg.matrix_rank(L, tol=1e-9 * np.linalg.norm(L))
    log(f"[{label}] |HG|/(|H||G|)={HG:.2e}  sv(LG): min {sv.min():.3e} max {sv.max():.3e}  rank L={rankL} "
        f"dimG={G.shape[1]} nT={nT}")
    worst = 0.0
    for w in ws:
        q1 = H + w * (L.T @ L)
        ev = np.linalg.eigvalsh(q1)
        s1, l1 = np.linalg.slogdet(q1)
        for d in ds:
            qd = ((1 + d) * H + w * (L.T @ L)).astype(complex)
            sd, ld = np.linalg.slogdet(qd)
            diff = (ld - l1) + np.log(sd / s1) - nT * np.log(1 + d)
            diff = diff.real + 1j * ((diff.imag + np.pi) % (2 * np.pi) - np.pi)
            rel = abs(np.expm1(diff))
            worst = max(worst, rel)
            log(f"   w={w:<5} d={d!s:<12} logdet q1={l1:+.8f} mineig q1={ev.min():+.3e} "
                f"|ratio/(1+d)^nT - 1| = {rel:.3e}")
    return dict(worst=worst, HG=HG)


def main():
    N = int(sys.argv[1])
    seeds = [int(s) for s in sys.argv[2:]] or [1]
    lat = Lattice(N)

    def log(s):
        print(s, flush=True)

    n = 3 * lat.nfree
    dimR = 3 * len(lat.noncentre)
    nT = n - dimR
    log(f"N={N} links={lat.nlink} coarse={len(lat.coarse)} free={lat.nfree} n={n} dimR={dimR} nT={nT} "
        f"gauge-fixing rows={3*lat.ngf}")
    # ---------------- instrument self-tests (known answers)
    rng0 = np.random.default_rng(12345)
    Xt = 0.7 * rng0.standard_normal((50, 3))
    log(f"selftest expX/logX round trip max err = {np.max(np.abs(logX(expX(Xt)) - Xt)):.2e}")
    A, B = rand_su2(rng0, 20, 1.3), rand_su2(rng0, 20, 1.3)
    log(f"selftest quaternion product vs 2x2 matrices max err = "
        f"{np.max(np.abs(q2mat(qmul(A, B)) - q2mat(A) @ q2mat(B))):.2e}; inverse err = "
        f"{np.max(np.abs(q2mat(qinv(A)) @ q2mat(A) - np.eye(2))):.2e}; "
        f"expX vs matrix exponential err = "
        f"{max(np.max(np.abs(q2mat(expX(x)) - __import__('scipy.linalg').linalg.expm(0.5j*np.einsum('a,aij->ij', x, SIG)))) for x in Xt[:5]):.2e}")
    Wt = rand_su2(rng0, len(lat.coarse), 1.0)
    Utt = lat.build(np.zeros(n), rand_su2(rng0, lat.nlink, 0.5), Wt)
    log(f"selftest contour_vars vectorised vs loop max err = "
        f"{np.max(np.abs(lat.contour_vars(Utt) - lat.contour_vars_loop(Utt))):.2e}")
    gR = rand_su2(rng0, lat.N * lat.N, 1.0)
    for (i, j) in lat.centres:
        gR[i * lat.N + j] = IDQ
    UR = lat.gauge_transform(Utt, gR)
    log(f"selftest: R preserves the constraint (max coarse-link change) = "
        f"{np.max(np.abs(lat.coarse_links(UR) - lat.coarse_links(Utt))):.2e}; Wilson change = "
        f"{abs(lat.wilson(UR) - lat.wilson(Utt)):.2e}")
    gC = np.tile(IDQ, (lat.N * lat.N, 1))
    ci, cj = lat.centres[0]
    gC[ci * lat.N + cj] = rand_su2(rng0, 1, 1.0)[0]
    UC = lat.gauge_transform(Utt, gC)
    log(f"selftest (sighted): a gauge transformation AT a centre moves the coarse links by "
        f"{np.max(np.abs(lat.coarse_links(UC) - lat.coarse_links(Utt))):.2e} (must be O(1))")
    f_t = lambda X: lat.wilson(lat.build(X, Utt, Wt))
    x_t = 0.01 * rng0.standard_normal(n)
    gcs = cs_grad(f_t, x_t)
    k = 3
    e = np.zeros(n); e[k] = 1e-6
    gfd = (f_t(x_t + e) - f_t(x_t - e)) / 2e-6
    log(f"selftest complex-step gradient vs central difference (one entry): {gcs[k]:.10f} vs {gfd:.10f}")
    summary, logdets = [], []
    light = N >= 9          # large lattice: skip N1, N4 and the second flux background (cost)
    for seed in seeds:
        rng = np.random.default_rng(seed)
        W = rand_su2(rng, len(lat.coarse), 1.2)
        U0 = lat.build(np.zeros(n), rand_su2(rng, lat.nlink, 0.4), W)
        log(f"=== seed {seed}: W random (scale 1.2); coarse-link check {np.max(np.abs(lat.coarse_links(U0) - W)):.1e}")
        if not light:
            info0 = analyse(lat, U0, W, f"N1 seed{seed} non-critical start point", log)
            r = ratio_test(info0['H'], info0['L'], info0['G'], nT, f"N1 seed{seed}", log)
            summary.append(('N1 non-critical', seed, r['worst'], r['HG']))
        Ubg = find_background(lat, W, U0, log)
        info = analyse(lat, Ubg, W, f"P1 seed{seed} background", log)
        r = ratio_test(info['H'], info['L'], info['G'], nT, f"P1 seed{seed}", log, ws=(0.25, 1.0, 4.0))
        summary.append(('P1 constrained min', seed, r['worst'], r['HG']))
        logdets.append(np.linalg.slogdet(info['H'] + info['L'].T @ info['L'])[1])
        Pbg_inv = qinv(lat.plaquettes(Ubg))
        Kf = lambda X: logX(qmul(lat.plaquettes(lat.build(X, Ubg, W)), Pbg_inv)[[0, 7]])
        K = cs_jac(Kf, np.zeros(n))
        r = ratio_test(info['H'], np.vstack([info['L'], K]), info['G'], nT, f"N2 seed{seed} over-complete", log)
        summary.append(('N2 over-complete gf', seed, r['worst'], r['HG']))
        r = ratio_test(info['H'] + 0.1 * np.eye(n), info['L'], info['G'], nT, f"N3 seed{seed} non-invariant", log)
        summary.append(('N3 non-invariant', seed, r['worst'], r['HG']))
        if light:
            continue
        Fall = lambda Y: lat.wilson(qmul(expX(Y.reshape(-1, 3)), Ubg))
        Hall, asym = hessian(Fall, np.zeros(3 * lat.nlink))
        Ubg_inv = qinv(Ubg)
        Yof = lambda X: logX(qmul(lat.build(X, Ubg, W), Ubg_inv)).ravel()
        J = cs_jac(Yof, np.zeros(n))
        Hnaive = J.T @ Hall @ J
        gradall = cs_grad(Fall, np.zeros(3 * lat.nlink))
        log(f"[N4 seed{seed}] |H - J^T Hall J|/|H| = {np.linalg.norm(info['H'] - Hnaive)/np.linalg.norm(info['H']):.3e}"
            f"   |grad A over all links| = {np.linalg.norm(gradall):.3e} (nonzero: a Lagrange multiplier is present)")
        r = ratio_test(Hnaive, info['L'], info['G'], nT, f"N4 seed{seed} Hessian without Lagrange term", log)
        summary.append(('N4 no Lagrange term', seed, r['worst'], r['HG']))
    for m in ((1,) if light else (1, 2)):
        Nn = lat.N
        f = 2 * np.pi * m / Nn ** 2
        Xab = np.zeros((lat.nlink, 3))
        for i in range(Nn):
            for j in range(Nn):
                Xab[lat.lid(i, j, 1), 2] = 2 * f * i
                if i == Nn - 1:
                    Xab[lat.lid(i, j, 0), 2] = -2 * f * Nn * j
        Uab = expX(Xab)
        Wab = lat.coarse_links(Uab)
        Uab = lat.build(np.zeros(n), Uab, Wab)
        info = analyse(lat, Uab, Wab, f"P3 abelian flux m={m} (critical, not a minimum)", log)
        ev = np.linalg.eigvalsh(info['H'] + info['L'].T @ info['L'])
        log(f"   eigenvalues of q1 below 0: {np.sum(ev < 0)}; smallest |eig| = {np.min(np.abs(ev)):.3e}")
        r = ratio_test(info['H'], info['L'], info['G'], nT, f"P3 flux m={m}", log, ws=(1.0, 4.0))
        summary.append((f'P3 flux m={m}', 0, r['worst'], r['HG']))
        logdets.append(np.linalg.slogdet(info['H'] + info['L'].T @ info['L'])[1])
    log("=== log|det q_1| at the backgrounds (S-P2): " + ", ".join(f"{x:.6f}" for x in logdets))
    log("=== SUMMARY (test, seed, worst |ratio/(1+d)^nT - 1|, |HG|/(|H||G|))")
    for row in summary:
        log(f"   {row[0]:<22} seed {row[1]:<3} worst {row[2]:.3e}   HG {row[3]:.2e}")


if __name__ == '__main__':
    main()
