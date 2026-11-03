"""M8b (A) READING: the classically perfect (fixed-point) action's QUADRATIC kernel for Balaban's linearised average, by iterating the
free block map on propagators from Wilson's kernel, and the size of its tail outside the four six-link loop classes.

  one step:  G'(k) = L^-4 sum_m Qhat(p_m) G(p_m) Qhat(p_m)^dag,   p_m = (k + 2 pi m)/L,   K'(k) = W(k)^dag [W G' W^dag]^+ W(k)
             (W the 6x4 curvature map, F_{mu nu} = khat_mu A_nu - khat_nu A_mu, khat = e^{ik} - 1; G = (K + phat phat^dag)^{-1} — the
             longitudinal part of G is irrelevant because Qhat maps longitudinal fine modes to coarse longitudinal modes, M8 section 4)
  K_0 = Wilson, K_n = n blocking steps;  K_* := K_N at the deepest N computed (L = 2: N = 5; L = 3: N = 3), the convergence printed.
  The loop classes: plaquette, 1x2 rectangle, chair (bent rectangle), parallelogram (the six-link loop on a 3-cube), each kernel
  sum over shapes per site of w w^dag (w the Fourier symbol of the loop's flux), normalised by its k^2 weight n_i.
  The fit: K_4 = sum_i c_i K_i, sum_i c_i n_i = 1, least squares of the RELATIVE deviation on the transverse space over a momentum set.
  The tail norms (per colour, beta = 1): tau_sup = max over k of |generalised eigenvalues of (K_* - K_4) relative to K_*|;
  <dS> = (1/2) int d^4k/(2pi)^4 tr(G_* (K_* - K_4)) (the expected tail action per site and colour in the perfect Gaussian), and the same
  with |eigenvalues| (the absolute moment).  The same norms for Wilson (the entry transient) and for the iterates (the contraction).
Run: python -u -E -P bin/m8b_fp_kernel.py L kind NDEPTH NK > rec/fp_kernel_L{L}.<date>.txt
"""
import sys, itertools, time
import numpy as np
sys.path.insert(0, __file__.rsplit('\\', 1)[0] if '\\' in __file__ else __file__.rsplit('/', 1)[0])
from m8_blockspin import BlockSpin

L = int(sys.argv[1]); kind = sys.argv[2]; NDEPTH = int(sys.argv[3]); NK = int(sys.argv[4])
NLINE = int(sys.argv[5]) if len(sys.argv) > 5 else NDEPTH          # a deeper depth on the line momenta (convergence check)
bs = BlockSpin(L, kind)
MV = bs.mvec.astype(float)                 # (L^4, 4) alias labels
CH = 1 << 15


def phat(P):
    return np.exp(1j * P) - 1.0


def Qhat(P):
    out = np.empty((P.shape[0], 4, 4), complex)
    for i in range(0, P.shape[0], CH):
        out[i:i + CH] = bs.Qhat(P[i:i + CH])
    return out


def wilson_K(P):
    ph = phat(P)
    return (np.abs(ph) ** 2).sum(1)[:, None, None] * np.eye(4) - ph[:, :, None] * ph[:, None, :].conj()


def curvW(P):
    ph = phat(P)
    W = np.zeros((P.shape[0], 6, 4), complex)
    a = 0
    for mu in range(4):
        for nu in range(mu + 1, 4):
            W[:, a, nu] = ph[:, mu]; W[:, a, mu] = -ph[:, nu]; a += 1
    return W


def pinv_herm(A, rel=1e-10):
    w, U = np.linalg.eigh(A)
    tol = rel * np.abs(w).max(axis=1, keepdims=True)
    winv = np.where(np.abs(w) > tol, 1.0 / np.where(np.abs(w) > tol, w, 1.0), 0.0)
    return (U * winv[:, None, :]) @ U.conj().transpose(0, 2, 1)


def block_step(Pparent, Kchild, Pchild):
    """Kchild (Np*L^4, 4, 4) at Pchild (children of parent i are rows i*L^4 .. (i+1)*L^4 - 1) -> K at Pparent."""
    ph = phat(Pchild)
    Gc = np.linalg.inv(Kchild + ph[:, :, None] * ph[:, None, :].conj())
    Qc = Qhat(Pchild)
    T = Qc @ Gc @ Qc.conj().transpose(0, 2, 1)
    Gp = T.reshape(Pparent.shape[0], L ** 4, 4, 4).sum(axis=1) / L ** 4
    W = curvW(Pparent)
    C = pinv_herm(W @ Gp @ W.conj().transpose(0, 2, 1))
    return W.conj().transpose(0, 2, 1) @ C @ W


def K_depth(P, n):
    """K_n at the momenta P (Np, 4): the alias tree built level by level, folded back up; returns [K_0(P), ..., K_n(P)] at P."""
    levels = [P]
    for _ in range(n):
        Pc = (levels[-1][:, None, :] + 2 * np.pi * MV[None, :, :]) / L
        levels.append(Pc.reshape(-1, 4))
    out = []
    # K_j(P) for j = 0..n: K_j at level 0 needs levels 0..j
    for j in range(n + 1):
        K = wilson_K(levels[j])
        for lev in range(j, 0, -1):
            K = block_step(levels[lev - 1], K, levels[lev])
        out.append(K)
    return out


# ------------------------------------------------------------------ loop classes
def loops(cls):
    seqs = []
    dirs = range(4)
    for perm in itertools.permutations(dirs, 3 if cls in ('chair', 'twist') else 2):
        for sg in itertools.product((1, -1), repeat=3):
            if cls == 'plaq':
                mu, nu = perm; s1, s2 = sg[:2]; seqs.append([(mu, s1), (nu, s2), (mu, -s1), (nu, -s2)])
            elif cls == 'rect':
                mu, nu = perm; s1, s2 = sg[:2]; seqs.append([(mu, s1), (mu, s1), (nu, s2), (mu, -s1), (mu, -s1), (nu, -s2)])
            elif cls == 'chair':
                mu, nu, rho = perm; s1, s2, s3 = sg
                seqs.append([(mu, s1), (nu, s2), (mu, -s1), (rho, s3), (nu, -s2), (rho, -s3)])
            elif cls == 'twist':
                mu, nu, rho = perm; s1, s2, s3 = sg
                seqs.append([(mu, s1), (nu, s2), (rho, s3), (mu, -s1), (nu, -s2), (rho, -s3)])
    shapes = {}
    for seq in seqs:
        x = np.zeros(4, int); links = []
        for (mu, s) in seq:
            if s > 0:
                links.append((tuple(x), mu, 1)); x[mu] += 1
            else:
                x[mu] -= 1; links.append((tuple(x), mu, -1))
        assert not x.any()
        base = np.min(np.array([l[0] for l in links]), axis=0)
        key = frozenset((tuple(np.array(l[0]) - base), l[1]) for l in links)
        if key not in shapes:
            shapes[key] = [(np.array(l[0]) - base, l[1], l[2]) for l in links]
    return list(shapes.values())


LOOPS = {c: loops(c) for c in ('plaq', 'rect', 'chair', 'twist')}


def class_K(P, cls):
    K = np.zeros((P.shape[0], 4, 4), complex)
    for shp in LOOPS[cls]:
        w = np.zeros((P.shape[0], 4), complex)
        for (x, mu, s) in shp:
            w[:, mu] += s * np.exp(1j * P @ x)
        K += w[:, :, None].conj() * w[:, None, :]          # K_ab = conj(w_a) w_b: A^dag K A = |w.A|^2 (M8's convention)
    return K


def transverse_basis(P):
    ph = phat(P)
    out = np.empty((P.shape[0], 4, 3), complex)
    for i in range(P.shape[0]):
        u = ph[i] / np.linalg.norm(ph[i])
        Q, _ = np.linalg.qr(np.column_stack([u, np.eye(4)]))
        out[i] = Q[:, 1:4]
    return out


def rel_eigs(Kstar, D, Tb):
    """generalised eigenvalues of D relative to Kstar on the transverse space: (3 per k)."""
    A = Tb.conj().transpose(0, 2, 1) @ Kstar @ Tb
    B = Tb.conj().transpose(0, 2, 1) @ D @ Tb
    w, U = np.linalg.eigh(A)
    Ais = (U / np.sqrt(w)[:, None, :]) @ U.conj().transpose(0, 2, 1)
    return np.linalg.eigvalsh(Ais @ B @ Ais)


t0 = time.time()
print("M8b FP kernel: L = %d (%s blocks), depth %d, NK = %d" % (L, kind, NDEPTH, NK))
for c in LOOPS:
    print("  loop class %-6s: %d shapes per site" % (c, len(LOOPS[c])))
# k^2 weights n_i from a small momentum
ks = np.array([[1e-3, 0, 0, 0]])
nw = {}
for c in LOOPS:
    Kc = class_K(ks, c)
    nw[c] = Kc[0, 1, 1].real / (1e-3) ** 2           # transverse component for k along axis 0
print("  k^2 weights n_i (transverse, k -> 0): " + ", ".join("%s %.6f" % (c, nw[c]) for c in LOOPS) + "   (Luescher-Weisz: 1, 8, 16, 8)")

# the momentum set: NK^4 midpoint grid on the zone (integration) + axis and diagonal lines (shape)
g1 = (np.arange(NK) + 0.5) / NK * 2 * np.pi - np.pi
P = np.array(list(itertools.product(g1, repeat=4)))
lines = []
for t in (0.1, 0.3, 0.6, 1.0, 1.5, 2.0, 2.5, 3.0):
    lines += [[t, 0, 0, 0], [t / np.sqrt(2), t / np.sqrt(2), 0, 0], [t / 2, t / 2, t / 2, t / 2]]
Pl = np.array(lines)
Kall = []
B = max(1, (1 << 18) // L ** (4 * NDEPTH))
for i in range(0, P.shape[0], B):
    Kall.append(K_depth(P[i:i + B], NDEPTH))
Ks = [np.concatenate([blk[j] for blk in Kall]) for j in range(NDEPTH + 1)]
BL_ = max(1, (1 << 18) // L ** (4 * NLINE))
Klb = [K_depth(Pl[i:i + BL_], NLINE) for i in range(0, Pl.shape[0], BL_)]
Kl = [np.concatenate([blk[j] for blk in Klb]) for j in range(NLINE + 1)]
print("  iterates computed on %d grid momenta (depth %d) + %d line momenta (depth %d): %.1f s" % (P.shape[0], NDEPTH, Pl.shape[0], NLINE, time.time() - t0))
Tb = transverse_basis(P); Tbl = transverse_basis(Pl)
# the line momenta at the deeper depth: the iterate differences there read the contraction rate directly
print("  line momenta, successive iterate differences |K_{j+1} - K_j| (tau_sup over the lines):")
prevd = None
for j in range(NLINE):
    d = np.abs(rel_eigs(Kl[-1], Kl[j + 1] - Kl[j], Tbl)).max()
    print("    j = %d -> %d: %.4e%s" % (j, j + 1, d, "" if prevd is None else "   ratio %.4f (L^-2 = %.4f)" % (d / prevd, L ** -2.0)))
    prevd = d
# Richardson: K_* = K_N + (K_N - K_{N-1}) rho/(1 - rho), rho = L^-2 (the leading irrelevant eigenvalue, M3f 6.3 / M8 S-H1.1)
rho = L ** -2.0
Kstar = Ks[-1] + (Ks[-1] - Ks[-2]) * rho / (1 - rho)
print("  grid K_* := Richardson extrapolation of depths %d, %d with rho = L^-2; its distance from K_%d: tau_sup %.3e"
      % (NDEPTH - 1, NDEPTH, NDEPTH, np.abs(rel_eigs(Kstar, Ks[-1] - Kstar, Tb)).max()))
if NLINE > NDEPTH:
    Kle = Kl[NDEPTH] + (Kl[NDEPTH] - Kl[NDEPTH - 1]) * rho / (1 - rho)
    print("  check on the lines: the depth-%d Richardson value against depth %d: tau_sup %.3e (against the depth-%d iterate itself: %.3e)"
          % (NDEPTH, NLINE, np.abs(rel_eigs(Kl[-1], Kle - Kl[-1], Tbl)).max(), NLINE, np.abs(rel_eigs(Kl[-1], Kl[NDEPTH] - Kl[-1], Tbl)).max()))
    Kl[-1] = Kl[-1] + (Kl[-1] - Kl[-2]) * rho / (1 - rho)
# convergence of the iterates (the tree-level contraction of the transient from Wilson)
print("  convergence |K_j - K_*| relative (tau_sup over the grid; ratio of successive):")
prev = None
for j in range(NDEPTH):
    e = np.abs(rel_eigs(Kstar, Ks[j] - Kstar, Tb)).max()
    el = np.abs(rel_eigs(Kl[-1], Kl[j] - Kl[-1], Tbl)).max()
    print("    j = %d: tau_sup(grid) %.4e  tau_sup(lines) %.4e%s" % (j, e, el, "" if prev is None else "   ratio %.4f" % (e / prev)))
    prev = e
print("    successive iterate differences |K_{j+1} - K_j| (tau_sup, grid), the contraction rate read directly:")
prevd = None
for j in range(NDEPTH):
    d = np.abs(rel_eigs(Kstar, Ks[j + 1] - Ks[j], Tb)).max()
    print("      j = %d -> %d: %.4e%s" % (j, j + 1, d, "" if prevd is None else "   ratio %.4f (L^-2 = %.4f)" % (d / prevd, L ** -2.0)))
    prevd = d
# the transverse eigenvalue along the lines: perfect vs continuum vs Wilson
print("  transverse eigenvalues on the lines (K_*, then k^2, then Wilson's |khat|^2):")
for i, p in enumerate(Pl):
    ev = np.linalg.eigvalsh(Tbl[i].conj().T @ Kl[-1][i] @ Tbl[i])
    k2 = (p ** 2).sum(); wil = (np.abs(phat(p[None]))[0] ** 2).sum()
    print("    k = %s : K_* %s | k^2 %.6f | Wilson %.6f | K_*/k^2 - 1 = %s" % (np.round(p, 4), np.round(ev, 6), k2, wil, np.round(ev / k2 - 1, 6)))
# the four-class fit
Kc = {c: class_K(P, c) / 1.0 for c in LOOPS}
names = list(LOOPS)
# parametrise c = c0 e_plaq + ... with sum c_i n_i = 1: solve least squares on the relative transverse deviation
A = []; bvec = []
w_, U_ = np.linalg.eigh(Tb.conj().transpose(0, 2, 1) @ Kstar @ Tb)
Ais = (U_ / np.sqrt(w_)[:, None, :]) @ U_.conj().transpose(0, 2, 1)
def proj(M):
    return Ais @ (Tb.conj().transpose(0, 2, 1) @ M @ Tb) @ Ais
Rc = {c: proj(Kc[c]) for c in names}
Rs = proj(Kstar)
# unknowns c_rect, c_chair, c_twist; c_plaq = (1 - 8.. ) / n_plaq via the weights
def assemble(cv):
    cp = (1.0 - sum(cv[i] * nw[names[i + 1]] for i in range(3))) / nw['plaq']
    return [cp] + list(cv)
cols = []
for i in range(3):
    cols.append((Rc[names[i + 1]] - Rc['plaq'] * nw[names[i + 1]] / nw['plaq']).reshape(-1))
Amat = np.column_stack(cols)
rhs = (Rs - Rc['plaq'] / nw['plaq']).reshape(-1)
Ar = np.vstack([Amat.real, Amat.imag]); br = np.concatenate([rhs.real, rhs.imag])
sol, *_ = np.linalg.lstsq(Ar, br, rcond=None)
cfit = assemble(sol)
print("  four-class least-squares fit (sum c_i n_i = 1): " + ", ".join("c_%s = %.6f" % (names[i], cfit[i]) for i in range(4)))
K4 = sum(cfit[i] * Kc[names[i]] for i in range(4))
Kw = Kc['plaq'] / nw['plaq']
Ksym = (1 + 8.0 / 12) * Kc['plaq'] / nw['plaq'] - (1.0 / 12) * Kc['rect'] / 1.0   # tree-level Symanzik c1 = -1/12, c0 = 1 + 8/12
for lab, K in (('four-class fit', K4), ('Wilson (entry transient)', Kw), ('tree-level Symanzik c1 = -1/12', Ksym)):
    ev = rel_eigs(Kstar, K - Kstar, Tb)      # (K - K*) relative to K*: the tail is K* - K, sign reversed
    trm = 0.5 * np.mean(ev.sum(axis=1)); tra = 0.5 * np.mean(np.abs(ev).sum(axis=1))
    print("  %-32s: tau_sup %.5f ; <dS> = %+.6f ; <|dS|> = %.6f per site and colour (signed / absolute; beta = 1)"
          % (lab, np.abs(ev).max(), -trm, tra))
print("done [%.0f s]" % (time.time() - t0))
