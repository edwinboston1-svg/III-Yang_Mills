# -*- coding: utf-8 -*-
"""M2RR: double-precision sighted tests of revision 33's Proposition 8.4' (the L^2 tilt lemma) and its three facts,
Corollary 8.5F (i) and (ii), Theorem 8.5D's (8.8c) with COMPLEX observables, Proposition 8.5E, Proposition 8.1',
and the complex-variance bound l_y(F) <= delta_y(F)/2 of the setting paragraph.
Readings, not certificates.  Usage: python tilt_test.py <seed> <out>"""
import sys
import itertools
import numpy as np

seed = int(sys.argv[1]) if len(sys.argv) > 1 else 1
out = open(sys.argv[2], "w", encoding="utf-8") if len(sys.argv) > 2 else sys.stdout
rng = np.random.default_rng(seed)
TINY = 1e-300


def say(*a):
    print(*a, file=out)
    out.flush()


def maxcorr(P):
    """Maximal correlation of a finite joint law P (n x m, sums to 1): second singular value of
    diag(p)^-1/2 P diag(q)^-1/2 on the marginal supports; 0 if either support is a single point."""
    p = P.sum(1)
    q = P.sum(0)
    I = p > 1e-300
    J = q > 1e-300
    Q = P[np.ix_(I, J)]
    if Q.shape[0] < 2 or Q.shape[1] < 2:
        return 0.0
    B = Q / np.sqrt(np.outer(p[I], q[J]))
    s = np.linalg.svd(B, compute_uv=False)
    return float(s[1])


def supp(P):
    p = P.sum(1)
    q = P.sum(0)
    return p > 1e-300, q > 1e-300


def oscs(delta, I, J):
    """o_X, o_W, Delta of Proposition 8.4' for delta on the product of the marginal supports."""
    d = delta[np.ix_(I, J)]
    oX = float(np.max(d.max(0) - d.min(0))) if d.shape[0] > 0 else 0.0      # sup_w osc_x
    oW = float(np.max(d.max(1) - d.min(1))) if d.shape[1] > 0 else 0.0      # sup_x osc_w
    Dl = 0.0
    m = d.shape[1]
    for a in range(m):
        diff = d - d[:, [a]]                     # delta(x,w) - delta(x,w_a), columns w
        Dl = max(Dl, float(np.max(diff.max(0) - diff.min(0))))
    return oX, oW, Dl


def tilt(P, delta):
    Q = P * np.exp(delta - delta.max())
    return Q / Q.sum()


def rand_law(n, m, kind):
    if kind == 0:                      # full support, flat-ish
        P = rng.random((n, m))
    elif kind == 1:                    # heavy-tailed: near-degenerate cells
        P = rng.random((n, m)) ** rng.uniform(1, 8)
    elif kind == 2:                    # zero cells
        P = rng.random((n, m)) * (rng.random((n, m)) > rng.uniform(0.1, 0.6))
        if P.sum() == 0:
            P[0, 0] = 1.0
    elif kind == 3:                    # strongly correlated: near-diagonal
        k = min(n, m)
        P = 1e-3 * rng.random((n, m))
        for i in range(k):
            P[i, i] += rng.random()
    else:                              # near product
        a = rng.random(n)
        b = rng.random(m)
        P = np.outer(a, b) * (1 + rng.uniform(0, 0.3) * rng.standard_normal((n, m)).clip(-0.9, 5))
        P = np.abs(P)
    return P / P.sum()


def rand_delta(n, m):
    s1, s2, s3 = rng.exponential(1.0, 3) * rng.choice([0.01, 0.1, 1.0, 3.0], 3)
    a = rng.standard_normal(n)[:, None]
    b = rng.standard_normal(m)[None, :]
    J = rng.standard_normal((n, m))
    mode = rng.integers(4)
    if mode == 0:
        return s1 * a + s2 * b + s3 * J
    if mode == 1:
        return s3 * J                         # mixed only (plus whatever product part J carries)
    if mode == 2:
        return s1 * a + s2 * b                # product tilt only: Delta = 0
    J = J - J.mean(0, keepdims=True) - J.mean(1, keepdims=True) + J.mean()
    return s1 * a + s2 * b + s3 * J           # pure interaction + product part


def rhs84(rho, oX, oW, Dl):
    return np.exp((oX + oW) / 2.0) * rho + 1.0 - np.exp(-2.0 * Dl)


# ------------------------------------------------------------------ 1. Proposition 8.4' on random instances
def test_84_random(N):
    worst_diff = -np.inf
    worst_incr = -np.inf
    nviol = 0
    rec = None
    for t in range(N):
        n = int(rng.integers(2, 7))
        m = int(rng.integers(2, 7))
        P = rand_law(n, m, int(rng.integers(5)))
        dl = rand_delta(n, m)
        I, J = supp(P)
        r0 = maxcorr(P)
        r1 = maxcorr(tilt(P, dl))
        oX, oW, Dl = oscs(dl, I, J)
        R = rhs84(r0, oX, oW, Dl)
        diff = r1 - R
        if diff > 1e-12:
            nviol += 1
        if diff > worst_diff:
            worst_diff = diff
            rec = (n, m, r0, r1, oX, oW, Dl, R)
        inc_den = R - r0
        if inc_den > 1e-9:
            worst_incr = max(worst_incr, (r1 - r0) / inc_den)
    return nviol, worst_diff, worst_incr, rec


# ------------------------------------------------------------------ 2. first order at delta = 0
def test_84_first_order(N):
    """d/de rho(pi_{e eta}) at e = 0 against (oX+oW)/2 rho + 2 Delta, both read on eta."""
    worst = -np.inf
    rec = None
    for t in range(N):
        n = int(rng.integers(2, 6))
        m = int(rng.integers(2, 6))
        P = rand_law(n, m, int(rng.integers(5)))
        I, J = supp(P)
        eta = rand_delta(n, m)
        oX, oW, Dl = oscs(eta, I, J)
        lin = (oX + oW) / 2.0
        r0 = maxcorr(P)
        bound = lin * r0 + 2.0 * Dl
        if bound < 1e-9:
            continue
        e = 1e-6
        der = (maxcorr(tilt(P, e * eta)) - maxcorr(tilt(P, -e * eta))) / (2 * e)
        # one-sided slopes too (the second singular value can be non-smooth at a crossing)
        der = max(der, (maxcorr(tilt(P, e * eta)) - r0) / e)
        ratio = der / bound
        if ratio > worst:
            worst = ratio
            rec = (n, m, r0, der, oX, oW, Dl)
    return worst, rec


# ------------------------------------------------------------------ 3. adversarial ascent on the increment ratio
def incr_ratio(P, dl):
    I, J = supp(P)
    r0 = maxcorr(P)
    r1 = maxcorr(tilt(P, dl))
    oX, oW, Dl = oscs(dl, I, J)
    R = rhs84(r0, oX, oW, Dl)
    den = R - r0
    if den < 1e-10:
        return -np.inf, r1 - R
    return (r1 - r0) / den, r1 - R


def test_84_adversarial(restarts, steps):
    best = -np.inf
    best_diff = -np.inf
    rec = None
    for rs in range(restarts):
        n = int(rng.integers(2, 5))
        m = int(rng.integers(2, 5))
        logP = rng.standard_normal((n, m)) * rng.uniform(0.2, 3)
        dl = rand_delta(n, m)
        P = np.exp(logP)
        P /= P.sum()
        cur, cd = incr_ratio(P, dl)
        step = 0.3
        for it in range(steps):
            logP2 = logP + step * rng.standard_normal((n, m)) * (rng.random() < 0.5)
            dl2 = dl + step * rng.standard_normal((n, m)) * rng.choice([0.01, 0.1, 1.0])
            P2 = np.exp(logP2 - logP2.max())
            P2 /= P2.sum()
            v, d2 = incr_ratio(P2, dl2)
            best_diff = max(best_diff, d2)
            if v > cur:
                logP, dl, cur, P = logP2, dl2, v, P2
            if it % 200 == 199:
                step *= 0.7
        if cur > best:
            best = cur
            I, J = supp(P)
            rec = (n, m, maxcorr(P), maxcorr(tilt(P, dl)), *oscs(dl, I, J))
    return best, best_diff, rec


# ------------------------------------------------------------------ 4. the three facts separately
def fact1_gap(P):
    """inf over nonconstant F of [E Var(F|X) + E Var(F|W)] / Var F, on the support cells, by an eigenproblem."""
    cells = np.argwhere(P > 1e-300)
    w = P[P > 1e-300]
    k = len(w)
    xs = cells[:, 0]
    ws = cells[:, 1]
    PX = np.zeros((k, k))
    PW = np.zeros((k, k))
    for i in range(k):
        mx = xs == xs[i]
        PX[i, mx] = w[mx] / w[mx].sum()
        mw = ws == ws[i]
        PW[i, mw] = w[mw] / w[mw].sum()
    A = 2 * np.eye(k) - PX - PW                      # self-adjoint in L^2(w)
    Dh = np.sqrt(w)
    S = (Dh[:, None] * A) / Dh[None, :]
    S = 0.5 * (S + S.T)
    u = Dh / np.linalg.norm(Dh)                       # the constants
    Pr = np.eye(k) - np.outer(u, u)
    M = Pr @ S @ Pr
    ev = np.linalg.eigvalsh(M)
    # remove the zero eigenvalue carried by the constant direction
    idx = np.argmin(np.abs(ev - 0.0) + 0.0)
    evs = np.sort(ev)
    # the constant direction gives an exact zero of M; drop one zero
    j = int(np.argmin(np.abs(evs)))
    evs = np.delete(evs, j)
    return float(evs[0]) if len(evs) else np.nan


def test_facts(N):
    w1 = -np.inf    # |fact1 - (1 - rho)|
    w2 = -np.inf    # (a/b)(1-rho(pi)) - (1-rho(pi'')) : must be <= 0
    w3 = -np.inf    # rho(pi1) / (sqrt(...) rho(pi)) : must be <= 1
    w3c = -np.inf   # log(rho1/rho0)/(oX+oW) over product tilts (the constant 1/2)
    for t in range(N):
        n = int(rng.integers(2, 6))
        m = int(rng.integers(2, 6))
        P = rand_law(n, m, int(rng.integers(5)))
        r0 = maxcorr(P)
        g = fact1_gap(P)
        w1 = max(w1, abs(g - (1 - r0)))
        a = rng.uniform(0.05, 1.0)
        b = a * np.exp(rng.exponential(1.0))
        h = rng.uniform(a, b, (n, m))
        P2 = P * h
        P2 = P2 / P2.sum()           # density hP/Z: bounds a/Z, b/Z, ratio b/a unchanged
        r2 = maxcorr(P2)
        w2 = max(w2, (a / b) * (1 - r0) - (1 - r2))
        u = np.exp(rng.standard_normal(n) * rng.exponential(1.0))
        s = np.exp(rng.standard_normal(m) * rng.exponential(1.0))
        P1 = P * np.outer(u, s)
        P1 /= P1.sum()
        r1 = maxcorr(P1)
        I, J = supp(P)
        uu = u[I]
        ss = s[J]
        fac = np.sqrt(uu.max() * ss.max() / (uu.min() * ss.min()))
        if r0 > 1e-12:
            w3 = max(w3, r1 / (fac * r0))
            o = np.log(uu.max() / uu.min()) + np.log(ss.max() / ss.min())
            if o > 1e-9 and r1 > 1e-12:
                w3c = max(w3c, np.log(r1 / r0) / o)
    return w1, w2, w3, w3c


# ------------------------------------------------------------------ 5. three- and four-site systems: Cor 8.5F, (8.8c), Prop 8.5E
def pair_laws(lam, y, z):
    """yield (xi, conditional 2-d law of (v_y, v_z) given xi) for every environment xi with positive mass."""
    S = lam.ndim
    others = [k for k in range(S) if k not in (y, z)]
    shp = [lam.shape[k] for k in others]
    for xi in itertools.product(*[range(s) for s in shp]):
        idx = [slice(None)] * S
        for k, v in zip(others, xi):
            idx[k] = v
        sub = lam[tuple(idx)]
        if y > z:
            sub = sub.T
        tot = sub.sum()
        if tot > 1e-300:
            yield xi, sub / tot


def Rmat(lam):
    S = lam.ndim
    R = np.zeros((S, S))
    for y in range(S):
        for z in range(S):
            if y != z:
                R[y, z] = max(maxcorr(c) for _, c in pair_laws(lam, y, z))
    return R


def mixed(field, y, z):
    """Delta_{yz}(field): sup over environments and a,a',b,b' of |f(a,b)-f(a,b')-f(a',b)+f(a',b')|."""
    S = field.ndim
    others = [k for k in range(S) if k not in (y, z)]
    best = 0.0
    for xi in itertools.product(*[range(field.shape[k]) for k in others]):
        idx = [slice(None)] * S
        for k, v in zip(others, xi):
            idx[k] = v
        f = field[tuple(idx)]
        if y > z:
            f = f.T
        for b in range(f.shape[1]):
            d = f - f[:, [b]]
            best = max(best, float(np.max(d.max(0) - d.min(0))))
    return best


def osc_site(field, y):
    """o_y(field): sup over configurations of the oscillation of field in the variable at y."""
    return float(np.max(field.max(axis=y) - field.min(axis=y)))


def C_dob(lam, y, z):
    """Dobrushin's C(y, z): sup over configurations differing at z of the TV of the conditional laws at y
    (positive measures, so the conditional laws are the canonical ones at every configuration)."""
    S = lam.ndim
    others = [k for k in range(S) if k not in (y, z)]
    best = 0.0
    for xi in itertools.product(*[range(lam.shape[k]) for k in others]):
        idx = [slice(None)] * S
        for k, v in zip(others, xi):
            idx[k] = v
        f = lam[tuple(idx)]
        if y > z:
            f = f.T
        cond = f / f.sum(0, keepdims=True)          # columns: law of v_y given v_z = b
        for b in range(cond.shape[1]):
            for b2 in range(cond.shape[1]):
                best = max(best, 0.5 * float(np.abs(cond[:, b] - cond[:, b2]).sum()))
    return best


def local_fluct(lam, F, y):
    """l_y(F) = (E Var(F | v_{y^c}))^{1/2}, complex F allowed."""
    w = lam.sum(axis=y, keepdims=True)
    mean = (lam * F).sum(axis=y, keepdims=True) / w
    var = (lam * np.abs(F - mean) ** 2).sum()
    return float(np.sqrt(max(var, 0.0)))


def test_systems(N):
    w_i = -np.inf       # R/(1 - e^{-Delta(A)})
    w_ii = -np.inf      # R_j - [e^{(oy+oz)/2} R_j1 + 1 - e^{-2 Delta(delta)}]
    w_ii_r = -np.inf
    w_cov = -np.inf     # |Cov| / l(F)^T D l(G), complex F, G
    w_var = -np.inf
    w_E = -np.inf       # R^2 / (C(y,z) C(z,y))
    ncov = 0
    for t in range(N):
        S = int(rng.integers(3, 5))
        shape = tuple(int(rng.integers(2, 4)) for _ in range(S))
        if S == 4:
            shape = tuple(min(s, 2) if k > 1 else s for k, s in enumerate(shape))
        A = rng.standard_normal(shape) * rng.choice([0.1, 0.5, 1.5, 3.0])
        m = [rng.random(s) + 0.05 for s in shape]
        prodm = m[0]
        for k in range(1, S):
            prodm = np.multiply.outer(prodm, m[k])
        lam1 = np.exp(-A) * prodm
        lam1 /= lam1.sum()
        R1 = Rmat(lam1)
        # (i): R <= 1 - exp(-Delta(A))
        for y in range(S):
            for z in range(S):
                if y != z:
                    D = mixed(A, y, z)
                    if D > 1e-12:
                        w_i = max(w_i, R1[y, z] / (1 - np.exp(-D)))
                    Cyz = C_dob(lam1, y, z)
                    Czy = C_dob(lam1, z, y)
                    if Cyz * Czy > 1e-14:
                        w_E = max(w_E, R1[y, z] ** 2 / (Cyz * Czy))
        # (ii): tilt by delta
        dl = rng.standard_normal(shape) * rng.choice([0.05, 0.2, 1.0, 2.5])
        lam = lam1 * np.exp(dl)
        lam /= lam.sum()
        R = Rmat(lam)
        for y in range(S):
            for z in range(S):
                if y != z:
                    bound = np.exp((osc_site(dl, y) + osc_site(dl, z)) / 2) * R1[y, z] + 1 - np.exp(-2 * mixed(dl, y, z))
                    w_ii = max(w_ii, R[y, z] - bound)
                    if bound > 1e-12:
                        w_ii_r = max(w_ii_r, R[y, z] / bound)
        # (8.8c) with complex F, G
        ev = np.max(np.abs(np.linalg.eigvalsh(R)))
        if ev < 1 - 1e-9:
            Dm = np.linalg.inv(np.eye(S) - R)
            for k in range(8):
                F = rng.standard_normal(shape) + 1j * rng.standard_normal(shape)
                G = rng.standard_normal(shape) + 1j * rng.standard_normal(shape)
                lF = np.array([local_fluct(lam, F, y) for y in range(S)])
                lG = np.array([local_fluct(lam, G, y) for y in range(S)])
                cov = (lam * F * G).sum() - (lam * F).sum() * (lam * G).sum()
                bnd = lF @ Dm @ lG
                w_cov = max(w_cov, abs(cov) / bnd)
                var = (lam * np.abs(F - (lam * F).sum()) ** 2).sum()
                w_var = max(w_var, var / ((lF @ lF) / (1 - ev)))
                ncov += 1
    return w_i, w_ii, w_ii_r, w_cov, w_var, w_E, ncov


# ------------------------------------------------------------------ 6. Proposition 8.1'
def test_81p(N):
    w_norm = 0.0
    w_chi = 0.0
    w_dob = -np.inf
    for t in range(N):
        n = int(rng.integers(3, 12))
        Bm = rng.random((n, n)) + 0.01
        T = Bm @ Bm.T / n + np.diag(rng.uniform(0.2, 2.0, n))   # symmetric, strictly positive, positive definite,
                                                                # top eigenvalue not overwhelmingly dominant
        dx = rng.random(n) + 0.1                     # reference measure dy
        # operator on L^2(dx): (T u)(x) = sum_y t(x,y) u(y) dx(y); symmetric in L^2(dx) as t symmetric
        Ms = np.sqrt(dx)[:, None] * T * np.sqrt(dx)[None, :]
        lam, vec = np.linalg.eigh(Ms)
        order = np.argsort(lam)[::-1]
        lam = lam[order]
        vec = vec[:, order]
        psi0 = vec[:, 0] / np.sqrt(dx)
        psi0 *= np.sign(psi0.sum())
        pi = psi0 ** 2 * dx
        Pk = (T * dx[None, :] * psi0[None, :]) / (lam[0] * psi0[:, None])   # Doob kernel P(x,y)
        for k in range(1, 5):
            Q = np.linalg.matrix_power(Pk, k)
            # norm on L^2_0(pi)
            Dh = np.sqrt(pi)
            Sm = (Dh[:, None] * Q) / Dh[None, :]
            u = Dh
            Pr = np.eye(n) - np.outer(u, u)
            nrm = np.linalg.norm(Pr @ Sm @ Pr, 2)
            w_norm = max(w_norm, abs(nrm - (lam[1] / lam[0]) ** k))
            dob = max(0.5 * np.abs(Q[a] - Q[b]).sum() for a in range(n) for b in range(n))
            w_dob = max(w_dob, nrm / dob if dob > 0 else 0)
            dens = Q / pi[None, :]
            chi = (pi[:, None] * pi[None, :] * (dens - 1) ** 2).sum()
            ref = (lam[1:] / lam[0]) ** (2 * k)
            w_chi = max(w_chi, abs(chi - ref.sum()))
    return w_norm, w_chi, w_dob


# ------------------------------------------------------------------ 7. the complex variance against the squared oscillation
def test_complex_var():
    vals = np.exp(2j * np.pi * np.arange(3) / 3)
    var = np.mean(np.abs(vals - vals.mean()) ** 2)
    osc = max(abs(a - b) for a in vals for b in vals)
    return var, osc, np.sqrt(var) / osc


if __name__ == "__main__":
    say("M2RR tilt_test seed=%d (numpy %s, double precision; readings, not certificates)" % (seed, np.__version__))
    nv, wd, wi, rec = test_84_random(200000)
    say("8.4' random 200000: violations(>1e-12)=%d  max(lhs-rhs)=%.3e  max increment ratio=%.6f  worst rec=%s"
        % (nv, wd, wi, tuple(np.round(rec, 6))))
    fo, rec = test_84_first_order(20000)
    say("8.4' first order 20000: max slope/(bound slope)=%.6f  rec=%s" % (fo, tuple(np.round(rec, 6))))
    ba, bd, rec = test_84_adversarial(60, 1500)
    say("8.4' adversarial ascent 60x1500: max increment ratio=%.6f  max(lhs-rhs) seen=%.3e  rec=%s"
        % (ba, bd, tuple(np.round(rec, 6))))
    w1, w2, w3, w3c = test_facts(50000)
    say("facts 50000: |fact1 - (1-rho)| max=%.2e ; fact2 max[(a/b)(1-rho)-(1-rho'')]=%.3e (<=0 holds) ; "
        "fact3 max rho1/(fac rho0)=%.6f (<=1 holds) ; product-tilt exponent max log(rho1/rho0)/(oX+oW)=%.4f" % (w1, w2, w3, w3c))
    r = test_systems(1500)
    say("systems 1500: Cor8.5F(i) max R/(1-e^-Delta(A))=%.6f ; Cor8.5F(ii) max(R_j - bound)=%.3e, max ratio=%.6f ; "
        "(8.8c) complex max |Cov|/l^T D l=%.6f ; var max=%.6f ; 8.5E max R^2/(C C)=%.6f ; complex pairs=%d" % r)
    a, b, c = test_81p(400)
    say("8.1' 400 kernels k=1..4: norm abs err max=%.2e ; chi^2 identity abs err max=%.2e ; max norm/delta(P^k)=%.6f" % (a, b, c))
    v, o, rr = test_complex_var()
    say("complex variance: three equiprobable cube roots of unity: Var=%.6f osc=%.6f  l/osc=%.6f  (1/2 claimed; 1/sqrt3=%.6f)"
        % (v, o, rr, 1 / np.sqrt(3)))
