# activity_b.py -- condition (b), first exact pass, both dimensions: the 2^d block with frozen boundary, the per-colour Gaussian
# covariance (4/beta) H^-1 with H = F^T F + diag(external counts) (exact), the plaquette-angle variance coefficients g_p, and the
# two leading activity terms at the orders the expansion starts: the quartic term of beta(1 - cos(|v|/2)) at the trivial background,
# E|W4| <= (15*16/384) g^2/beta = 0.625 g^2/beta, and the cubic vertex at a background angle phi <= theta*, second order,
# (15/72) sin^2(phi) g^3/beta.  ABELIAN approximation of the plaquette angle (v_p = (F A)_p); the non-abelian commutator terms are
# not yet bounded here -- this is the computation's first stage, not the proof.
import itertools, numpy as np
from math import e, sin, cos, log
def block(d):
    V = list(itertools.product([0, 1], repeat=d))
    E = [(v, m) for v in V for m in range(d) if v[m] == 0]; ei = {x: i for i, x in enumerate(E)}
    def sh(v, m): w = list(v); w[m] += 1; return tuple(w)
    P = [(v, m, n) for v in V for m in range(d) for n in range(m + 1, d) if v[m] == 0 and v[n] == 0]
    F = np.zeros((len(P), len(E)))
    for r, (v, m, n) in enumerate(P):
        F[r, ei[(v, m)]] += 1; F[r, ei[(sh(v, m), n)]] += 1; F[r, ei[(sh(v, n), m)]] -= 1; F[r, ei[(v, n)]] -= 1
    interior = (np.abs(F) > 0).sum(axis=0)          # interior plaquettes per link
    ext = 2 * (d - 1) - interior                    # each link lies in 2(d-1) plaquettes
    H = F.T @ F + np.diag(ext)
    G = np.linalg.inv(H)
    g_int = np.diag(F @ G @ F.T); g_ext = np.repeat(np.diag(G), ext)
    return len(E), len(P), int(ext.sum()), np.linalg.eigvalsh(H), g_int, g_ext
for d, cd, K, edge in ((4, 18, 3146.9, 0.5636), (3, 12, 63.6, 0.5636)):
    nE, nP, nX, ev, gi, gx = block(d)
    g = np.concatenate([gi, gx]); gmax = g.max(); gmean = g.mean()
    print(f"d={d}: links {nE}, interior plaquettes {nP}, external {nX}; H spectrum {sorted(set(np.round(ev, 6)))}")
    print(f"   g_p interior: max {gi.max():.6f} mean {gi.mean():.6f};  external: max {gx.max():.6f} mean {gx.mean():.6f}")
    for th in (0.4774, edge, 0.72):
        a = 0.625 * gmax**2 + (15 / 72) * sin(th)**2 * gmax**3            # activity times beta, worst plaquette
        b_kp = cd * e**2 * a                                               # KP floor: c_d z e^2 < 1, z = a/beta
        s_c = log(20 * e * K) if d == 4 else log(12 * e * K)
        b_peierls = s_c / (1 - cos(th))
        print(f"   theta*={th}: activity*beta <= {a:.4f} (Fontes's form C0 theta*^2/lambda = {10.6667*th**2/(3 if d==4 else 2):.4f});"
              f" KP floor {b_kp:.1f}, Peierls floor {b_peierls:.1f}, floor = max = {max(b_kp, b_peierls):.1f}")
