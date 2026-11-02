"""M8b CONVEXITY UNDER THREE PLAQUETTE WEIGHTS (READING; double precision; never enters a bound).

The slice V = ker Q minus the residual gauge directions of M8 (L = 2 half-open Balaban blocks, the (4,2,2,2) torus: 32 sites,
128 links, 384 variables, slice dimension 270), SU(2) links U_l = exp(i B_l . sigma).  The action per unit beta is
    S/beta = sum_p g(theta_p)  [+ (1/beta) sum_l h(|B_l|) if HAAR],   h(r) = -2 log(sin r / r)  (the Haar density, convex),
with the plaquette weight g one of
    wilson : g = 1 - cos theta
    manton : g = theta^2 / 2                         (the beta -> infinity heat kernel; the labelled proxy of the perfect action's
                                                      large-field shape)
    hk     : g = -(1/beta) log[K_t(theta)/K_t(0)],   K_t(theta) = sum_n (theta + 2 pi n)/sin(theta) exp(-beta (theta + 2 pi n)^2 / 2),
             t = 1/(2 beta), windings n in {-2..2}  (the SU(2) heat kernel; principal branch + windings)
MODES (comma list): repro  = M8's adversarial loop verbatim (seed 7; b = 0.2, 0.3, 0.4, 0.5; 8 starts x 120 moves);
                    rays   = the free slice form's 4 softest modes + 12 random directions (seed 20261103), the first radius with
                             lambda_min < 0, and the exact split of the negative eigenvector's quadratic form into
                             RADIAL sum g''(th)(xh.Jv)^2 + TRANSVERSE sum (g'(th)/th)|P_perp Jv|^2 + COMPOSITION sum g'(th) xh.D2X[v,v]
                             (+ HAAR v.Hh.v), X_p = th_p xh_p the Lie-algebra plaquette, J_p = dX_p/dB;
                    adv    = the adversarial loop at the b list given (seed 7), with the same split at the best configuration.
Run: python -u -E -P bin/m8b_weights.py WEIGHT BETA HAAR MODES BLIST > rec/weights_<tag>.<date>.txt
     (BETA is used by hk and by HAAR; BLIST comma list of link-angle sup norms for adv)
"""
import sys, itertools, time
import numpy as np

WEIGHT = sys.argv[1]  # must be dhz
BETA = float(sys.argv[2])
HAAR = int(sys.argv[3])
MODES = sys.argv[4].split(',')
BLIST = [float(x) for x in sys.argv[5].split(',')] if len(sys.argv) > 5 and sys.argv[5] else []
assert WEIGHT == 'dhz'

SIG = np.array([[[0, 1], [1, 0]], [[0, -1j], [1j, 0]], [[1, 0], [0, -1]]], dtype=complex)
TWO_PI = 2 * np.pi


def su2(theta):
    r = np.linalg.norm(theta, axis=-1)
    c = np.cos(r)
    s = np.where(r > 1e-300, np.sin(r) / np.where(r > 1e-300, r, 1.0), 1.0)
    return c[..., None, None] * np.eye(2) + 1j * s[..., None, None] * np.einsum('...k,kij->...ij', theta, SIG)


def plaq(phi):
    """phi (..., 4, 3) -> (c, vvec) with U_p = c I + i vvec.sigma."""
    P = su2(phi[..., 0, :]) @ su2(phi[..., 1, :]) @ su2(-phi[..., 2, :]) @ su2(-phi[..., 3, :])
    c = P[..., 0, 0].real
    v = np.stack([P[..., 0, 1].imag, P[..., 0, 1].real, P[..., 0, 0].imag], axis=-1)
    return c, v



CPL = (0.3333, 0.00402, 0.00674, 0.0152)          # DHZ Table 1, plaquette
C6L = (0.08333, 0.0156, 0.0149, -0.0035)          # DHZ Table 1, six-link (x,y,z,-x,-y,-z)


def Pw(w, c):
    return c[0] * w + 2 * c[1] * w ** 2 + 4 * c[2] * w ** 3 + 8 * c[3] * w ** 4


def dPw(w, c):
    return c[0] + 4 * c[1] * w + 12 * c[2] * w ** 2 + 32 * c[3] * w ** 3


def d2Pw(w, c):
    return 4 * c[1] + 24 * c[2] * w + 96 * c[3] * w ** 2


def g_derivs_c(th, c):
    w = 1 - np.cos(th)
    return dPw(w, c) * np.sin(th), d2Pw(w, c) * np.sin(th) ** 2 + dPw(w, c) * np.cos(th)


def holo(phi, sg):
    """phi (..., n, 3), sg (n,) orientations -> (c, v) of the ordered product prod_i U_i^{s_i}."""
    P = su2(sg[0] * phi[..., 0, :])
    for i in range(1, phi.shape[-2]):
        P = P @ su2(sg[i] * phi[..., i, :])
    c = P[..., 0, 0].real
    v = np.stack([P[..., 0, 1].imag, P[..., 0, 1].real, P[..., 0, 0].imag], axis=-1)
    return c, v


def g_loop(phi, sg, coef):
    c, v = holo(phi, sg)
    return Pw(1.0 - c, coef)


H_STEP = 1e-4


def make_fd(n):
    E_ = np.eye(3 * n)
    pairs = [(i, j) for i in range(3 * n) for j in range(i, 3 * n)]
    D = []
    for (i, j) in pairs:
        for si, sj in ((1, 1), (1, -1), (-1, 1), (-1, -1)):
            D.append(si * H_STEP * E_[i] + sj * H_STEP * E_[j])
    return np.array(D), np.array([p[0] for p in pairs]), np.array([p[1] for p in pairs])


FD = {4: make_fd(4), 6: make_fd(6)}


def hess_loops(phi, sg, coef):
    n = phi.shape[1]
    D, PI_, PJ_ = FD[n]
    m = phi.shape[0]
    X = phi.reshape(m, 3 * n)[:, None, :] + D[None, :, :]
    f = g_loop(X.reshape(m, -1, n, 3), sg, coef).reshape(m, len(PI_), 4)
    vals = (f[:, :, 0] - f[:, :, 1] - f[:, :, 2] + f[:, :, 3]) / (4 * H_STEP * H_STEP)
    out = np.zeros((m, 3 * n, 3 * n))
    out[:, PI_, PJ_] = vals
    out[:, PJ_, PI_] = vals
    return out

# ---------------------------------------------------------------- the torus and the slice (M8's construction, verbatim)
ext = np.array([4, 2, 2, 2])
sites = [np.array(s) for s in itertools.product(*[range(e) for e in ext])]
sidx = {tuple(s): i for i, s in enumerate(sites)}
nS = len(sites)


def lid(s, mu):
    return 4 * sidx[tuple(np.mod(s, ext))] + mu


nLk = 4 * nS
nV = 3 * nLk
E = np.eye(4, dtype=int)
plaqs = []
for s in sites:
    for mu in range(4):
        for nu in range(mu + 1, 4):
            plaqs.append((lid(s, mu), lid(s + E[mu], nu), lid(s + E[nu], mu), lid(s, nu)))
plaqs = np.array(plaqs)
coarse = [s for s in sites if all(s % 2 == 0)]
Gcols = []
for s in sites:
    if all(s % 2 == 0):
        continue
    for a in range(3):
        v = np.zeros(nV)
        for mu in range(4):
            v[3 * lid(s, mu) + a] -= 1.0
            v[3 * lid(s - E[mu], mu) + a] += 1.0
        Gcols.append(v)
G = np.array(Gcols).T
Qrows = []
for y in coarse:
    for mu in range(4):
        row = np.zeros(nLk)
        for n in itertools.product(range(2), repeat=4):
            n = np.array(n)
            for j in range(2):
                row[lid(y + n + j * E[mu], mu)] += 1.0
            nz = [nu for nu in range(4) if n[nu] != 0]
            perms = list(itertools.permutations(nz))
            for start, sign in ((y, 1.0), (y + 2 * E[mu], -1.0)):
                for perm in perms:
                    z = start.copy()
                    for nu in perm:
                        row[lid(z, nu)] += sign / len(perms)
                        z = z + E[nu]
        row /= 16.0
        for a in range(3):
            r = np.zeros(nV); r[a::3] = row
            Qrows.append(r)
Qm = np.array(Qrows)
U_, s_, Vh = np.linalg.svd(Qm)
N = Vh[(s_ > 1e-10).sum():].T
GN = N.T @ G
Ug, sg, _ = np.linalg.svd(GN, full_matrices=True)
T = N @ Ug[:, (sg > 1e-10).sum():]

# the six-link loops (x,y,z,-x,-y,-z) on the torus: the shapes of m8b_fp_kernel.py's 'twist' class (16 per site), traversal order kept
import itertools as _it
def twist_shapes():
    seqs = []
    for perm in _it.permutations(range(4), 3):
        for sg_ in _it.product((1, -1), repeat=3):
            mu, nu, rho = perm; s1, s2, s3 = sg_
            seqs.append([(mu, s1), (nu, s2), (rho, s3), (mu, -s1), (nu, -s2), (rho, -s3)])
    shapes = {}
    for seq in seqs:
        x = np.zeros(4, int); links = []
        for (mu, s) in seq:
            if s > 0:
                links.append((tuple(x), mu, 1)); x[mu] += 1
            else:
                x[mu] -= 1; links.append((tuple(x), mu, -1))
        base = np.min(np.array([l[0] for l in links]), axis=0)
        key = frozenset((tuple(np.array(l[0]) - base), l[1]) for l in links)
        if key not in shapes:
            shapes[key] = [(np.array(l[0]) - base, l[1], l[2]) for l in links]
    return list(shapes.values())


TW = twist_shapes()
SG6 = None
six = []
sgn6 = []
for s in sites:
    for shp in TW:
        six.append([lid(s + x, mu) for (x, mu, sg_) in shp])
        sgn6.append([sg_ for (x, mu, sg_) in shp])
six = np.array(six); sgn6 = np.array(sgn6)
# group the six-link loops by their orientation pattern (the holonomy needs one sign vector per batch)
PATS = {}
for i in range(len(six)):
    PATS.setdefault(tuple(sgn6[i]), []).append(i)
SG4 = np.array([1, 1, -1, -1])
IDX4 = (3 * plaqs[:, :, None] + np.arange(3)[None, None, :]).reshape(len(plaqs), 12)
F4 = (np.repeat(IDX4[:, :, None], 12, axis=2) * nV + np.repeat(IDX4[:, None, :], 12, axis=1)).ravel()
F6 = {}
for pat, ids in PATS.items():
    I6 = (3 * six[ids][:, :, None] + np.arange(3)[None, None, :]).reshape(len(ids), 18)
    F6[pat] = (np.array(ids), (np.repeat(I6[:, :, None], 18, axis=2) * nV + np.repeat(I6[:, None, :], 18, axis=1)).ravel())
print("M8b DHZ: torus %s, plaquettes %d, six-link loops %d (%d shapes per site, %d orientation patterns); slice dim %d; |QG| = %.1e"
      % (ext, len(plaqs), len(six), len(TW), len(PATS), T.shape[1], np.abs(Qm @ G).max()))


def haar_hess(B):
    return np.zeros((nV, nV))


def hess_full(B):
    Bl = B.reshape(nLk, 3)
    phi4 = Bl[plaqs]
    Hf = np.bincount(F4, weights=hess_loops(phi4, SG4, CPL).ravel(), minlength=nV * nV)
    for pat, (ids, f6) in F6.items():
        Hf = Hf + np.bincount(f6, weights=hess_loops(Bl[six[ids]], np.array(pat), C6L).ravel(), minlength=nV * nV)
    Hf = Hf.reshape(nV, nV)
    c, v = holo(phi4, SG4)
    ang = np.arctan2(np.linalg.norm(v, axis=-1), c)
    return Hf, ang


def lam_min(B):
    Hf, ang = hess_full(B)
    return np.linalg.eigvalsh(T.T @ Hf @ T)[0], ang.max()


def X_of(phi, sg):
    c, v = holo(phi, sg)
    s = np.linalg.norm(v, axis=-1)
    th = np.arctan2(s, c)
    ratio = np.where(s > 1e-8, th / np.where(s > 1e-8, s, 1.0), 1.0 / np.maximum(c, 1e-300))
    return ratio[..., None] * v


def split_class(Bl, vl, loops_idx, sg, coef):
    phi = Bl[loops_idx]; vp = vl[loops_idx]
    h = 1e-5
    X0 = X_of(phi, sg); Xpl = X_of(phi + h * vp, sg); Xmi = X_of(phi - h * vp, sg)
    JV = (Xpl - Xmi) / (2 * h); D2 = (Xpl - 2 * X0 + Xmi) / (h * h)
    th = np.linalg.norm(X0, axis=-1)
    rad = trn = cmp_ = 0.0
    worst = []
    for p in range(len(loops_idx)):
        if th[p] < 1e-7:
            g1, g2 = 0.0, coef[0]
            rad += g2 * (JV[p] @ JV[p])
            continue
        xh = X0[p] / th[p]
        g1, g2 = g_derivs_c(th[p], coef)
        jr = xh @ JV[p]
        r_ = g2 * jr * jr; t_ = (g1 / th[p]) * (JV[p] @ JV[p] - jr * jr); c_ = g1 * (xh @ D2[p])
        rad += r_; trn += t_; cmp_ += c_
        worst.append((r_ + t_ + c_, th[p], r_, t_, c_))
    worst.sort()
    return rad, trn, cmp_, worst[:2]


def split(B):
    Hf, ang = hess_full(B)
    w, U = np.linalg.eigh(T.T @ Hf @ T)
    v = T @ U[:, 0]
    Bl = B.reshape(nLk, 3); vl = v.reshape(nLk, 3)
    r4, t4, c4, w4 = split_class(Bl, vl, plaqs, SG4, CPL)
    r6 = t6 = c6 = 0.0; w6 = []
    for pat, (ids, f6) in F6.items():
        a, b_, c_, ww = split_class(Bl, vl, six[ids], np.array(pat), C6L)
        r6 += a; t6 += b_; c6 += c_; w6 += ww
    w6.sort()
    return w[0], ang.max(), (r4, t4, c4, w4), (r6, t6, c6, w6[:2]), v @ (Hf @ v)


def fmt_split(sp):
    lam, am, P4, P6, tot = sp
    s = ("lambda_min %.6f | max plaq angle %.4f | PLAQ: RADIAL %+.5f TRANSVERSE %+.5f COMPOSITION %+.5f | SIX: RADIAL %+.5f TRANSVERSE %+.5f "
         "COMPOSITION %+.5f | sum %+.6f (v.Hv %+.6f)" % (lam, am, P4[0], P4[1], P4[2], P6[0], P6[1], P6[2], sum(P4[:3]) + sum(P6[:3]), tot))
    s += " | worst plaquettes " + "; ".join("(%+.4f, th %.3f, %+.4f, %+.4f, %+.4f)" % x for x in P4[3])
    s += " | worst six-links " + "; ".join("(%+.4f, th %.3f, %+.4f, %+.4f, %+.4f)" % x for x in P6[3])
    return s


t0 = time.time()
Hf0, _ = hess_full(np.zeros(nV))
D0 = T.T @ Hf0 @ T
w0, v0 = np.linalg.eigh(D0)
print("free form on the slice: lowest eigenvalues %s (the DHZ quadratic part differs from Wilson's at O(k^4): c1 = 1/3 + 8/12)" % np.round(w0[:6], 6))
tt = time.time(); _ = lam_min(np.zeros(nV)); print("one lambda_min evaluation: %.3f s" % (time.time() - tt))

if 'repro' in MODES:
    rng2 = np.random.default_rng(7)

    def at_b(d, b):
        B1 = T @ d
        return b * B1 / np.linalg.norm(B1.reshape(nLk, 3), axis=1).max()

    for b in (0.2, 0.3, 0.4, 0.5):
        best_all = (np.inf, None)
        for start in range(8):
            d = rng2.normal(size=T.shape[1])
            cur, amax = lam_min(at_b(d, b))
            step = 0.5
            for it in range(120):
                dt = d + step * rng2.normal(size=d.shape) * np.linalg.norm(d) / np.sqrt(d.size)
                val, am = lam_min(at_b(dt, b))
                if val < cur:
                    d, cur, amax = dt, val, am
                else:
                    step *= 0.98
            if cur < best_all[0]:
                best_all = (cur, amax)
            print("  repro b = %.2f start %d: lambda_min reached %.6f (max plaquette angle %.4f)  [%.0f s]" % (b, start, cur, amax, time.time() - t0))
        print("repro b = %.2f : most negative lambda_min found %.6f at max plaquette angle %.4f" % (b, best_all[0], best_all[1]))
    sys.stdout.flush()

if 'rays' in MODES:
    rng3 = np.random.default_rng(20261103)
    dirs = [('soft mode %d' % j, v0[:, j]) for j in range(4)] + [('random %d' % j, rng3.normal(size=T.shape[1])) for j in range(12)]
    tgrid = np.arange(0.05, 1.8001, 0.05)
    for name, d in dirs:
        B1 = T @ d
        B1 = B1 / np.linalg.norm(B1.reshape(nLk, 3), axis=1).max()
        lo, hi = 0.0, None
        for t in tgrid:
            lm, am = lam_min(t * B1)
            if lm < 0:
                hi = t; break
            lo = t
        if hi is None:
            print("  ray %-13s: convex up to link radius 1.80  [%.0f s]" % (name, time.time() - t0)); continue
        for _ in range(20):
            mid = 0.5 * (lo + hi)
            lm, am = lam_min(mid * B1)
            if lm < 0:
                hi = mid
            else:
                lo = mid
        sp = split(hi * B1)
        print("  ray %-13s: b_cross = %.5f ; at the crossing: %s  [%.0f s]" % (name, hi, fmt_split(sp), time.time() - t0))
        sys.stdout.flush()

if 'adv' in MODES:
    rng2 = np.random.default_rng(7)

    def at_b(d, b):
        B1 = T @ d
        return b * B1 / np.linalg.norm(B1.reshape(nLk, 3), axis=1).max()

    for b in BLIST:
        best_all = (np.inf, None, None)
        for start in range(8):
            d = rng2.normal(size=T.shape[1])
            cur, amax = lam_min(at_b(d, b))
            step = 0.5
            for it in range(120):
                dt = d + step * rng2.normal(size=d.shape) * np.linalg.norm(d) / np.sqrt(d.size)
                val, am = lam_min(at_b(dt, b))
                if val < cur:
                    d, cur, amax = dt, val, am
                else:
                    step *= 0.98
            if cur < best_all[0]:
                best_all = (cur, amax, d.copy())
            print("  adv b = %.2f start %d: lambda_min reached %.6f (max plaquette angle %.4f)  [%.0f s]" % (b, start, cur, amax, time.time() - t0))
        sp = split(at_b(best_all[2], b))
        print("adv b = %.2f : most negative lambda_min %.6f -> %s ; split at the best: %s" % (
            b, best_all[0], "NON-CONVEX EXHIBITED" if best_all[0] < 0 else "convex on all configurations tried", fmt_split(sp)))
        sys.stdout.flush()
print("done [%.0f s]" % (time.time() - t0))
