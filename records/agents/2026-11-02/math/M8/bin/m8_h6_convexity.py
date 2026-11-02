"""M8 (H6) READING: the convexity radius of the Wilson action on the slice V = ker Q minus the residual gauge (L = 2 half-open blocks,
Balaban's linearised average), SU(2), link variables U_l = exp(i B_l . sigma) (theta-convention: (1/2) tr U = cos|B|).

Part 1: e(b) = sup_{|phi_i| <= b} || Hess F_p(phi) - Hess F_p(0) ||_2 for one plaquette (12 variables), by multi-start optimisation.
Part 2: on the (4,2,2,2) torus (32 sites, 128 links, 384 variables; coarse sites (0,0,0,0) and (2,0,0,0); it carries the coarse
momenta k_1 in {0, pi/2}, so the face momentum where gamma0 is attained is present), the least link-angle radius b_neg at which a
configuration B in V has lambda_min(Hess S_W(B) restricted to V) < 0; search over directions (random, soft modes, hill climbing).
Everything per unit beta; the Haar term -2 log(sin r / r) per link is reported separately (it is convex and scales as 1/beta).

Run: python -u -E -P bin/m8_h6_convexity.py > rec/h6_convexity.<date>.txt
"""
import sys, itertools, time
import numpy as np

rng = np.random.default_rng(20261102)
SIG = np.array([[[0, 1], [1, 0]], [[0, -1j], [1j, 0]], [[1, 0], [0, -1]]], dtype=complex)


def su2(theta):
    """theta (..., 3) -> exp(i theta.sigma) (..., 2, 2)."""
    r = np.linalg.norm(theta, axis=-1)
    c = np.cos(r)
    s = np.where(r > 1e-300, np.sin(r) / np.where(r > 1e-300, r, 1.0), 1.0)
    M = c[..., None, None] * np.eye(2) + 1j * s[..., None, None] * np.einsum('...k,kij->...ij', theta, SIG)
    return M


def Fp(phi):
    """phi (..., 4, 3): plaquette 1 - (1/2) Re tr(U1 U2 U3^-1 U4^-1)."""
    U1, U2, U3, U4 = su2(phi[..., 0, :]), su2(phi[..., 1, :]), su2(-phi[..., 2, :]), su2(-phi[..., 3, :])
    P = U1 @ U2 @ U3 @ U4
    return 1.0 - 0.5 * np.real(np.trace(P, axis1=-2, axis2=-1))


H_STEP = 1e-4
EYE12 = np.eye(12)


def hess_plaq(phi):
    """phi (n, 4, 3) -> (n, 12, 12) Hessian of Fp by central differences (step 1e-4; reading accuracy ~1e-8)."""
    n = phi.shape[0]
    x = phi.reshape(n, 12)
    h = H_STEP
    pairs = [(i, j) for i in range(12) for j in range(i, 12)]
    out = np.zeros((n, 12, 12))
    # build all perturbed points in one batch
    pts = []
    for (i, j) in pairs:
        for si, sj in ((1, 1), (1, -1), (-1, 1), (-1, -1)):
            pts.append(si * h * EYE12[i] + sj * h * EYE12[j])
    D = np.array(pts)                                   # (4*npairs, 12)
    X = x[:, None, :] + D[None, :, :]                   # (n, 4*npairs, 12)
    f = Fp(X.reshape(n, -1, 4, 3)).reshape(n, len(pairs), 4)
    vals = (f[:, :, 0] - f[:, :, 1] - f[:, :, 2] + f[:, :, 3]) / (4 * h * h)
    for idx, (i, j) in enumerate(pairs):
        out[:, i, j] = vals[:, idx]
        out[:, j, i] = vals[:, idx]
    return out


# ------------------------------------------------------------------ Part 1: e(b)
H0 = hess_plaq(np.zeros((1, 4, 3)))[0]
print("Part 1. Hess F_p(0): eigenvalues", np.round(np.linalg.eigvalsh(H0), 8), "(expect 4 (x3) and 0 (x9))")


def e_of(phi):
    Hs = hess_plaq(phi)
    return np.abs(np.linalg.eigvalsh(Hs - H0[None])).max(axis=1)


def rand_ball(n, b):
    v = rng.normal(size=(n, 4, 3))
    v /= np.linalg.norm(v, axis=-1, keepdims=True)
    return b * v                                      # on the sphere |phi_i| = b (extreme points)


for b in [0.01, 0.02, 0.05, 0.1, 0.2, 0.3]:
    best = 0.0
    cand = rand_ball(4000, b)
    ev = e_of(cand)
    order = np.argsort(-ev)[:20]
    best = ev.max()
    # hill-climb the best 20 on the product of spheres
    for i0 in order:
        phi = cand[i0].copy(); cur = ev[i0]; step = 0.3
        for it in range(150):
            trial = phi + step * b * rng.normal(size=(4, 3))
            trial = b * trial / np.linalg.norm(trial, axis=-1, keepdims=True)
            val = e_of(trial[None])[0]
            if val > cur:
                phi, cur = trial, val
            else:
                step *= 0.97
        best = max(best, cur)
    print("  b = %.3f : e(b) >= %.6f   e(b)/b = %.4f" % (b, best, best / b))

# ------------------------------------------------------------------ Part 2: the torus
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
print("Part 2. torus extents", ext, ": sites %d, links %d, variables %d, plaquettes %d" % (nS, nLk, nV, len(plaqs)))

# residual gauge directions (linearised at the trivial background): lambda^a at non-coarse sites
coarse = [s for s in sites if all(s % 2 == 0)]
Gcols = []
for s in sites:
    if all(s % 2 == 0):
        continue
    for a in range(3):
        v = np.zeros(nV)
        for mu in range(4):
            v[3 * lid(s, mu) + a] -= 1.0                       # link (s, mu): A -> A + lambda(s+mu) - lambda(s)
            v[3 * lid(s - E[mu], mu) + a] += 1.0               # link (s - mu, mu)
        Gcols.append(v)
G = np.array(Gcols).T
# Balaban's linearised average for L = 2 half-open blocks: A'_mu(y) = 2^-4 sum_{n in {0,1}^4} [ sum_{j<2} A_mu(y+n+j mu)
#   + A(Gamma_{y->y+n}) - A(Gamma_{y+2mu -> y+n+2mu}) ], contours averaged over orderings of the nonzero directions of n.
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
                        row[lid(z, nu)] += sign / len(perms)      # n_nu = 1 > 0: one step in +nu
                        z = z + E[nu]
        row /= 16.0
        for a in range(3):
            r = np.zeros(nV); r[a::3] = row
            Qrows.append(r)
Qm = np.array(Qrows)
print("  constraint rows %d (rank %d); residual gauge columns %d; Q G max |entry| = %.2e (gauge covariance at the trivial background)"
      % (Qm.shape[0], np.linalg.matrix_rank(Qm), G.shape[1], np.abs(Qm @ G).max()))
# slice basis T: orthonormal basis of ker Q intersect range(G)^perp
U_, s_, Vh = np.linalg.svd(Qm)
N = Vh[(s_ > 1e-10).sum():].T
GN = N.T @ G
Ug, sg, _ = np.linalg.svd(GN, full_matrices=True)
T = N @ Ug[:, (sg > 1e-10).sum():]
print("  slice dimension %d (expected %d)" % (T.shape[1], nV - Qm.shape[0] - G.shape[1]))


def hess_full(B):
    """B (nV,) -> Wilson Hessian (nV, nV) per unit beta, and max plaquette angle."""
    Bl = B.reshape(nLk, 3)
    phi = Bl[plaqs]                                            # (np, 4, 3)
    Hs = hess_plaq(phi)
    Hf = np.zeros((nV, nV))
    idx = (3 * plaqs[:, :, None] + np.arange(3)[None, None, :]).reshape(len(plaqs), 12)
    for p in range(len(plaqs)):
        ii = idx[p]
        Hf[np.ix_(ii, ii)] += Hs[p]
    ang = np.arccos(np.clip(1.0 - Fp(phi), -1, 1))
    return Hf, ang.max()


def lam_min(B):
    Hf, amax = hess_full(B)
    return np.linalg.eigvalsh(T.T @ Hf @ T)[0], amax


l0, _ = lam_min(np.zeros(nV))
print("  lambda_min of the free form on the slice (torus gamma0 at k in {0, pi/2}): %.6f" % l0)
D0 = T.T @ hess_full(np.zeros(nV))[0] @ T
w0, v0 = np.linalg.eigh(D0)
print("  lowest free eigenvalues on the slice:", np.round(w0[:6], 6))


def crossing(direc, tmax=1.6):
    """direc in slice coordinates; B = t * T direc / max link angle; returns (b_cross, a_cross) or (None, None)."""
    B1 = T @ direc
    B1 = B1 / np.linalg.norm(B1.reshape(nLk, 3), axis=1).max()
    lo, hi = 0.0, None
    for t in np.linspace(0.1, tmax, 16):
        lm, am = lam_min(t * B1)
        if lm < 0:
            hi = t; break
        lo = t
    if hi is None:
        return None, None
    for _ in range(18):
        mid = 0.5 * (lo + hi)
        lm, am = lam_min(mid * B1)
        if lm < 0:
            hi = mid
        else:
            lo = mid
    lm, am = lam_min(hi * B1)
    return hi, am


t0 = time.time()
results = []
# soft modes
for j in range(4):
    bc, ac = crossing(v0[:, j])
    results.append((bc, ac, 'soft mode %d' % j))
    print("  direction = soft mode %d (free eig %.4f): b_cross = %s, max plaquette angle there %s" % (j, w0[j], bc, ac))
# random directions
for j in range(12):
    d = rng.normal(size=T.shape[1])
    bc, ac = crossing(d)
    results.append((bc, ac, 'random %d' % j))
    print("  random direction %2d: b_cross = %s, max plaquette angle %s   (%.0f s)" % (j, None if bc is None else round(bc, 5),
          None if ac is None else round(ac, 5), time.time() - t0))
best = min([r for r in results if r[0] is not None], key=lambda r: r[0])
print("  best so far: b_cross = %.5f (%s)" % (best[0], best[2]))
