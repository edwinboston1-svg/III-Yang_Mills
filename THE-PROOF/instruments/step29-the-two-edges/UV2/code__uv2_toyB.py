# UV2 run U2: Theorem A / Theorem B checked on M3gR's consistent 2D toy under convention C (U = 1, a = 1).
# In d = 2 the counting-measure conjugate of T-hat is exactly QGQ^T (M3gR's T; WORK.md section 3.3 (i)).
# Metric: CMP 96 (2.46)-type scaled distance -- shortest fine-lattice path, a fine step costing the mean of 1/s over its end-points'
# regions (s the region's block side); a block bond sits at its base site.  Any pseudometric is admissible in Theorem A.
# Double precision: a CHECK of a proved theorem on a finite object, and READINGS of the true rates.
import sys, time
import numpy as np, scipy.sparse as sp
from scipy.sparse.csgraph import dijkstra
sys.path.insert(0, __file__.rsplit('\\', 1)[0] if '\\' in __file__ else __file__.rsplit('/', 1)[0])
from conv_toy_M3gR_copy import geometry, build

def scaled_metric(o, N):
    reg = {}
    for lev in o['geo']:
        s = lev['s']
        for (X, Y) in lev['Lam']:
            for p in range(s):
                for q in range(s): reg[(X + p, Y + q)] = s
    sid = o['sid']; ns = len(sid)
    r, c, v = [], [], []
    for (x, y), i in sid.items():
        for (dx, dy) in ((1, 0), (0, 1)):
            p = (x + dx, y + dy)
            if p in sid:
                w = 0.5 * (1.0 / reg[(x, y)] + 1.0 / reg[p])
                r += [i, sid[p]]; c += [sid[p], i]; v += [w, w]
    Gs = sp.csr_matrix((v, (r, c)), shape=(ns, ns))
    base = [sid[k[1]] if k[1] in sid else sid[(k[1][0] + (k[2] == 0), k[1][1] + (k[2] == 1))] for k in o['keys']]
    ub = sorted(set(base)); pos = {b: i for i, b in enumerate(ub)}
    Dm = dijkstra(Gs, directed=False, indices=ub)            # (len(ub), ns)
    idx = np.array([pos[b] for b in base])
    return Dm[idx][:, np.array(base)]                       # (nc, nc)

def analyze(tag, N, levels, rec):
    t0 = time.time()
    geo = geometry(N, levels)
    o = build(N, geo, 'C')
    D0, Q, R = o['D0'].toarray(), o['Q'].toarray(), o['R']
    Ginv = (o['D1'].T @ o['D1']).toarray() + D0 @ R @ D0.T + Q.T @ Q
    G = np.linalg.inv(Ginv)
    T = Q @ G @ Q.T; T = (T + T.T) / 2
    ev = np.linalg.eigvalsh(T); lam = ev[0]
    Ti = np.linalg.inv(T)
    d = scaled_metric(o, N)
    A = np.abs(T); Ai = np.abs(Ti)
    out = [f"{tag}: nc={o['nc']} lam_min(T~)={lam:.6f} lam_max={ev[-1]:.9f} kappa={ev[-1] / lam:.2f} diam(d)={d.max():.2f}"]
    # Theorem A with the EXACT Theta of this finite operator; first-order CT with exact Schur sums
    Th = lambda m: ((np.cosh(m * d) - 1) * A).sum(axis=1).max()        # increasing in m
    Ct = lambda m: ((np.exp(m * d) - 1) * A).sum(axis=1).max()         # increasing in m
    def bis(f, target):
        lo, hi = 0.0, 4.0
        for _ in range(50):
            mid = (lo + hi) / 2
            if f(mid) <= target: lo = mid
            else: hi = mid
        return lo
    muA = bis(Th, lam / 2); muC = bis(Ct, lam / 2); muA_full = bis(Th, lam * (1 - 1e-12))
    # check the theorem's conclusion on a 24-point grid of admissible mu: max_{y,y'} |T~^{-1}| e^{mu d} (lam - Theta) <= 1
    worst = 0.0
    for m in np.linspace(0, muA_full, 25)[1:]:
        t = Th(m)
        if t < lam:
            worst = max(worst, (Ai * np.exp(m * d)).max() * (lam - t))
    # true rates: upper envelope of log|.| over distance bins, fitted on the middle range
    def rate(Mx):
        dd = d.ravel(); vv = np.log(np.maximum(Mx.ravel(), 1e-300))
        bins = np.floor(dd).astype(int); top = {}
        for b, val in zip(bins, vv):
            if b not in top or val > top[b]: top[b] = val
        bs = np.array(sorted(top)); ys = np.array([top[b] for b in bs])
        sel = (bs >= 2) & (bs <= 0.6 * bs.max())
        p = np.polyfit(bs[sel], ys[sel], 1)
        return -p[0]
    muT = rate(A); muTi = rate(Ai)
    # the kernel constant K0 and rate delta0 of T~ in this metric (the inputs of Corollary A'): K0 := max |T~| e^{delta0 d}
    K0 = (A * np.exp(muT * d)).max()
    out.append(f"   Theorem A (exact Theta): mu*_A = {muA:.4f};  first-order CT (exact sums): mu_CT = {muC:.4f};  ratio CT/A = {muC / muA if muA else 0:.3f}")
    out.append(f"   CHECK of the conclusion on every pair and admissible mu: max |T~^-1| e^(mu d)(lam - Theta) = {worst:.4f} (must be <= 1)")
    out.append(f"   true rates (envelope fit): T~: {muT:.4f}, T~^-1: {muTi:.4f};  mu*_A / rate(T~^-1) = {muA / muTi:.3f};  rate(T~^-1)/rate(T~) = {muTi / muT:.3f}")
    out.append(f"   K0 (with delta0 = rate(T~)) = {K0:.4f};  [{time.time() - t0:.1f}s]")
    for s in out:
        print(s, flush=True); rec.write(s + "\n"); rec.flush()

if __name__ == "__main__":
    rec = open(sys.argv[1], 'a', encoding='utf-8')
    analyze("L=2 two scales N=32 (1|2, Om1=[8,24))", 32, [(1, 0, 32), (2, 8, 24)], rec)
    analyze("L=2 three scales N=32 (1|2|4)", 32, [(1, 0, 32), (2, 4, 28), (4, 8, 24)], rec)
    analyze("L=4 two scales N=40 (1|4, Om1=[12,28))", 40, [(1, 0, 40), (4, 12, 28)], rec)
    rec.close()
