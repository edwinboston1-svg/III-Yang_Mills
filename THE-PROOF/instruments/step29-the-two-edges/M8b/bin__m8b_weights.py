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

WEIGHT = sys.argv[1]
BETA = float(sys.argv[2])
HAAR = int(sys.argv[3])
MODES = sys.argv[4].split(',')
BLIST = [float(x) for x in sys.argv[5].split(',')] if len(sys.argv) > 5 and sys.argv[5] else []
assert WEIGHT in ('wilson', 'manton', 'hk')

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


# ---------------------------------------------------------------- the weights g(theta) per unit beta
def hk_logK(th):
    """log K_t(theta) (unnormalised), th >= 0 array."""
    th = np.asarray(th, float)
    out = np.empty_like(th)
    small = th < 0.5
    ts = th[small]
    # theta/sin(theta) by series below 1e-3
    ratio = np.where(ts > 1e-3, ts / np.sin(np.where(ts > 1e-3, ts, 1.0)), 1.0 + ts ** 2 / 6.0 + 7.0 * ts ** 4 / 360.0)
    out[small] = -BETA * ts ** 2 / 2.0 + np.log(ratio)
    tl = th[~small]
    Bsum = tl.copy()
    for n in (-2, -1, 1, 2):
        Bsum = Bsum + (tl + TWO_PI * n) * np.exp(-TWO_PI * BETA * n * (tl + np.pi * n))
    out[~small] = -BETA * tl ** 2 / 2.0 + np.log(Bsum / np.sin(tl))
    return out


HK_LOGK0 = 0.0
if WEIGHT == 'hk':
    B0 = 1.0 + sum((1.0 - 4 * np.pi ** 2 * BETA * n * n) * np.exp(-2 * np.pi ** 2 * BETA * n * n) for n in (-2, -1, 1, 2))
    HK_LOGK0 = np.log(B0)


def g_of_theta(th):
    if WEIGHT == 'wilson':
        return 1.0 - np.cos(th)
    if WEIGHT == 'manton':
        return 0.5 * th ** 2
    return -(hk_logK(th) - HK_LOGK0) / BETA


def g_derivs(th):
    """g'(th), g''(th) (scalars)."""
    if WEIGHT == 'wilson':
        return np.sin(th), np.cos(th)
    if WEIGHT == 'manton':
        return th, 1.0
    h = 1e-4
    t = max(th, 2 * h)
    f = g_of_theta(np.array([t - h, t, t + h]))
    return (f[2] - f[0]) / (2 * h), (f[2] - 2 * f[1] + f[0]) / (h * h)


def g_plaq(phi):
    if WEIGHT == 'wilson':      # M8's formula verbatim (1 - (1/2) Re tr), so the reproduction is bit-for-bit
        P = su2(phi[..., 0, :]) @ su2(phi[..., 1, :]) @ su2(-phi[..., 2, :]) @ su2(-phi[..., 3, :])
        return 1.0 - 0.5 * np.real(np.trace(P, axis1=-2, axis2=-1))
    c, v = plaq(phi)
    s = np.linalg.norm(v, axis=-1)
    return g_of_theta(np.arctan2(s, c))


H_STEP = 1e-4
EYE12 = np.eye(12)
PAIRS = [(i, j) for i in range(12) for j in range(i, 12)]
DPTS = []
for (i, j) in PAIRS:
    for si, sj in ((1, 1), (1, -1), (-1, 1), (-1, -1)):
        DPTS.append(si * H_STEP * EYE12[i] + sj * H_STEP * EYE12[j])
DPTS = np.array(DPTS)
PI_, PJ_ = np.array([p[0] for p in PAIRS]), np.array([p[1] for p in PAIRS])


def hess_plaq(phi):
    n = phi.shape[0]
    X = phi.reshape(n, 12)[:, None, :] + DPTS[None, :, :]
    f = g_plaq(X.reshape(n, -1, 4, 3)).reshape(n, len(PAIRS), 4)
    vals = (f[:, :, 0] - f[:, :, 1] - f[:, :, 2] + f[:, :, 3]) / (4 * H_STEP * H_STEP)
    out = np.zeros((n, 12, 12))
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
IDX = (3 * plaqs[:, :, None] + np.arange(3)[None, None, :]).reshape(len(plaqs), 12)
ROWS = np.repeat(IDX[:, :, None], 12, axis=2)
COLS = np.repeat(IDX[:, None, :], 12, axis=1)
FLATIDX = (ROWS * nV + COLS).ravel()
print("M8b weights: WEIGHT = %s, BETA = %g, HAAR = %d, MODES = %s, BLIST = %s" % (WEIGHT, BETA, HAAR, MODES, BLIST))
print("torus %s: sites %d, links %d, variables %d, plaquettes %d; constraint rows %d (rank %d); residual gauge %d; slice dim %d; |QG| = %.1e"
      % (ext, nS, nLk, nV, len(plaqs), Qm.shape[0], np.linalg.matrix_rank(Qm), G.shape[1], T.shape[1], np.abs(Qm @ G).max()))


def haar_hess(B):
    """block-diagonal (nV, nV) Hessian of (1/beta) sum_l h(|B_l|)."""
    Bl = B.reshape(nLk, 3)
    r = np.linalg.norm(Bl, axis=1)
    hpp = np.where(r > 1e-3, 2.0 / np.sin(np.maximum(r, 1e-3)) ** 2 - 2.0 / np.maximum(r, 1e-3) ** 2, 2.0 / 3 + 2 * r ** 2 / 15)
    hpr = np.where(r > 1e-3, (-2.0 / np.tan(np.maximum(r, 1e-3)) + 2.0 / np.maximum(r, 1e-3)) / np.maximum(r, 1e-3), 2.0 / 3 + 2 * r ** 2 / 45)
    bh = np.where(r[:, None] > 1e-12, Bl / np.where(r[:, None] > 1e-12, r[:, None], 1.0), 0.0)
    Hh = np.zeros((nV, nV))
    for l in range(nLk):
        blk = hpr[l] * np.eye(3) + (hpp[l] - hpr[l]) * np.outer(bh[l], bh[l])
        Hh[3 * l:3 * l + 3, 3 * l:3 * l + 3] = blk / BETA
    return Hh


def hess_full(B):
    Bl = B.reshape(nLk, 3)
    phi = Bl[plaqs]
    Hs = hess_plaq(phi)
    Hf = np.bincount(FLATIDX, weights=Hs.ravel(), minlength=nV * nV).reshape(nV, nV)   # plaquette-major accumulation, as M8's loop
    if HAAR:
        Hf += haar_hess(B)
    c, v = plaq(phi)
    ang = np.arctan2(np.linalg.norm(v, axis=-1), c)
    return Hf, ang


def lam_min(B):
    Hf, ang = hess_full(B)
    return np.linalg.eigvalsh(T.T @ Hf @ T)[0], ang.max()


def Xp(phi):
    """Lie-algebra plaquette X = theta * vhat for phi (..., 4, 3)."""
    c, v = plaq(phi)
    s = np.linalg.norm(v, axis=-1)
    th = np.arctan2(s, c)
    ratio = np.where(s > 1e-8, th / np.where(s > 1e-8, s, 1.0), 1.0 / np.maximum(c, 1e-300))
    return ratio[..., None] * v


def split(B):
    """lambda_min, the eigenvector, and the exact split of v^T Hess v (v = T u, |u| = 1)."""
    Hf, ang = hess_full(B)
    w, U = np.linalg.eigh(T.T @ Hf @ T)
    u = U[:, 0]
    v = T @ u
    Bl = B.reshape(nLk, 3); vl = v.reshape(nLk, 3)
    phi = Bl[plaqs]; vp = vl[plaqs]
    h = 1e-5
    X0 = Xp(phi); Xpl = Xp(phi + h * vp); Xmi = Xp(phi - h * vp)
    JV = (Xpl - Xmi) / (2 * h)
    D2 = (Xpl - 2 * X0 + Xmi) / (h * h)
    th = np.linalg.norm(X0, axis=-1)
    rad = trn = cmp_ = 0.0
    rad_neg = 0.0
    worst = []
    for p in range(len(plaqs)):
        if th[p] < 1e-7:
            rad += JV[p] @ JV[p]
            continue
        xh = X0[p] / th[p]
        g1, g2 = g_derivs(th[p])
        jr = xh @ JV[p]
        r_ = g2 * jr * jr
        t_ = (g1 / th[p]) * (JV[p] @ JV[p] - jr * jr)
        c_ = g1 * (xh @ D2[p])
        rad += r_; trn += t_; cmp_ += c_
        worst.append((r_ + t_ + c_, th[p], r_, t_, c_))
    hq = v @ haar_hess(B) @ v if HAAR else 0.0
    worst.sort()
    return w[0], ang.max(), rad, trn, cmp_, hq, v @ (Hf @ v), worst[:3]


def fmt_split(sp):
    lam, am, rad, trn, cmp_, hq, tot, worst = sp
    s = ("lambda_min %.6f | max plaq angle %.4f | RADIAL %+.5f TRANSVERSE %+.5f COMPOSITION %+.5f HAAR %+.5f sum %+.6f (v.Hv %+.6f)"
         % (lam, am, rad, trn, cmp_, hq, rad + trn + cmp_ + hq, tot))
    s += " | three most negative plaquettes (total, theta, rad, trn, cmp): " + "; ".join(
        "(%+.4f, %.3f, %+.4f, %+.4f, %+.4f)" % w for w in worst)
    return s


t0 = time.time()
Hf0, _ = hess_full(np.zeros(nV))
D0 = T.T @ Hf0 @ T
w0, v0 = np.linalg.eigh(D0)
print("free form on the slice: lowest eigenvalues %s  (Wilson's free gamma0 on this torus 1.849564; hk scales it by 1 - 1/(3 beta); "
      "HAAR adds 2/(3 beta))" % np.round(w0[:6], 6))
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
