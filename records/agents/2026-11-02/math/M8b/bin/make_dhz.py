"""Write bin/m8b_dhz.py: the convexity search with the DeGrand-Hasenfratz-Zhu eight-parameter FP action (hep-lat/9604018 Eq. 4,
Table 1, READ on the extracted text src_dhz/dhz.txt lines 123-147: S(V) = (1/2) sum_C [c1 (2 - Tr V_C) + c2 (2 - Tr V_C)^2 + c3 (.)^3
+ c4 (.)^4] over the plaquette and the perimeter-six loop (x,y,z,-x,-y,-z); plaquette .3333 .00402 .00674 .0152; six-link .08333 .0156
.0149 -.0035).  Per unit beta, with w = 1 - cos theta_C (so 2 - Tr V_C = 2 w):  g_C(w) = c1 w + 2 c2 w^2 + 4 c3 w^3 + 8 c4 w^4.
The weights script's machinery is reused (exec of its torus/slice block); the Hessian is assembled loop by loop, and the exact split
RADIAL / TRANSVERSE / COMPOSITION is taken over every loop (plaquettes and six-link loops), reported separately for the two classes."""
import os
here = os.path.dirname(os.path.abspath(__file__))
src = open(os.path.join(here, 'm8b_weights.py'), encoding='utf-8').read()
head_end = src.index('# ---------------------------------------------------------------- the weights g(theta) per unit beta')
torus_beg = src.index('# ---------------------------------------------------------------- the torus and the slice')
torus_end = src.index('IDX = (3 * plaqs')
modes_beg = src.index("if 'repro' in MODES:")
body = src[modes_beg:]
new = src[:head_end].replace('WEIGHT = sys.argv[1]', 'WEIGHT = sys.argv[1]  # must be dhz').replace(
    "assert WEIGHT in ('wilson', 'manton', 'hk')", "assert WEIGHT == 'dhz'")
new += '''
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

'''
new += src[torus_beg:torus_end]
new += '''
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

'''
new += body
open(os.path.join(here, 'm8b_dhz.py'), 'w', encoding='utf-8').write(new)
print('wrote m8b_dhz.py')
