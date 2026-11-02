# S2 (M3g): 2D abelian Balaban operators at U = 1, built from the definitions; a CHECK in double precision, not a proof.
import numpy as np, sys, time

def build(N, blocks, a=1.0, ap=1.0):
    # sites
    sid = {(x, y): i for i, (x, y) in enumerate((x, y) for x in range(N) for y in range(N))}
    ns = len(sid)
    # internal bonds: (x,y,mu) with endpoint inside
    bonds = []
    for x in range(N):
        for y in range(N):
            if x + 1 < N: bonds.append((x, y, 0))
            if y + 1 < N: bonds.append((x, y, 1))
    bid = {b: i for i, b in enumerate(bonds)}
    nb = len(bonds)
    # d0_int: sites -> internal bonds
    d0 = np.zeros((nb, ns))
    for i, (x, y, mu) in enumerate(bonds):
        x2, y2 = (x + 1, y) if mu == 0 else (x, y + 1)
        d0[i, sid[(x2, y2)]] += 1.0
        d0[i, sid[(x, y)]] -= 1.0
    # Dirichlet scalar Laplacian on the box (bonds to the outside included)
    Lap = np.zeros((ns, ns))
    for (x, y), i in sid.items():
        Lap[i, i] = 4.0
        for dx, dy in ((1, 0), (-1, 0), (0, 1), (0, -1)):
            j = sid.get((x + dx, y + dy))
            if j is not None: Lap[i, j] -= 1.0
    # plaquettes touching the box
    plaq = []
    for x in range(-1, N):
        for y in range(-1, N):
            row = {}
            for (bx, by, mu, sg) in ((x, y, 0, 1.0), (x + 1, y, 1, 1.0), (x, y + 1, 0, -1.0), (x, y, 1, -1.0)):
                k = bid.get((bx, by, mu))
                if k is not None: row[k] = row.get(k, 0.0) + sg
            if row: plaq.append(row)
    d1 = np.zeros((len(plaq), nb))
    for p, row in enumerate(plaq):
        for k, v in row.items(): d1[p, k] = v
    # blocks: list of (x0,y0,side); block of each site
    blockof = {}
    for bi, (x0, y0, s) in enumerate(blocks):
        for x in range(x0, x0 + s):
            for y in range(y0, y0 + s):
                assert (x, y) not in blockof
                blockof[(x, y)] = bi
    assert len(blockof) == ns, "blocks must partition the box"
    bset = {(x0, y0, s): bi for bi, (x0, y0, s) in enumerate(blocks)}
    # scalar averaging Q' (rows: blocks)
    Qp = np.zeros((len(blocks), ns))
    for bi, (x0, y0, s) in enumerate(blocks):
        for x in range(x0, x0 + s):
            for y in range(y0, y0 + s):
                Qp[bi, sid[(x, y)]] = 1.0 / (s * s)
    # block bonds (same side, adjacent, both in the list) and the tent Q, competitor E
    cb = []
    for bi, (x0, y0, s) in enumerate(blocks):
        for mu in (0, 1):
            nb2 = (x0 + s, y0, s) if mu == 0 else (x0, y0 + s, s)
            if nb2 in bset: cb.append((x0, y0, s, mu))
    nc = len(cb)
    Q = np.zeros((nc, nb)); E = np.zeros((nb, nc)); side = np.zeros(nc)
    for c, (x0, y0, s, mu) in enumerate(cb):
        side[c] = s
        raw = [min(t + 1, s - t) for t in range(s)]; m = sum(raw) / s; bprof = [r / m for r in raw]
        for t in range(s):          # transverse coordinate
            for p in range(s):      # start position inside B1 along mu
                for q in range(s):  # step along the line
                    pos = p + q
                    x, y = (x0 + pos, y0 + t) if mu == 0 else (x0 + t, y0 + pos)
                    Q[c, bid[(x, y, mu)]] += 1.0 / s ** 3
            for pos in range(2 * s - 1):
                x, y = (x0 + pos, y0 + t) if mu == 0 else (x0 + t, y0 + pos)
                E[bid[(x, y, mu)], c] = (min(pos + 1, 2 * s - 1 - pos) / s) * bprof[t]
    # scalar G' and R
    Gp = np.linalg.inv(Lap + ap * Qp.T @ Qp)
    X = Gp @ Qp.T
    P = X @ np.linalg.solve(Qp @ Gp @ Gp @ Qp.T, X.T)
    R = np.eye(ns) - P
    Ginv = d1.T @ d1 + d0 @ R @ d0.T + a * Q.T @ Q      # d = 2: (L^j eta)^{d-2} = 1
    return dict(Q=Q, E=E, R=R, Ginv=Ginv, side=side, nc=nc, nb=nb, ns=ns, cb=cb, P=P)

def analyze(tag, N, blocks):
    t0 = time.time()
    o = build(N, blocks)
    Q, E, R, Ginv = o['Q'], o['E'], o['R'], o['Ginv']
    projerr = max(np.abs(R @ R - R).max(), np.abs(R - R.T).max())
    G = np.linalg.inv(Ginv)
    That = Q @ G @ Q.T          # symmetrized T-hat in d = 2 (W = l^2)
    ev = np.linalg.eigvalsh((That + That.T) / 2)
    QE = Q @ E
    # M of (L2) for comparison on the same index set
    Mm = np.zeros_like(QE)
    for c, (x0, y0, s, mu) in enumerate(o['cb']):
        for c2, (x1, y1, s1, mu1) in enumerate(o['cb']):
            if mu1 != mu or s1 != s: continue
            if mu == 0 and y1 == y0 and x1 == x0: Mm[c, c2] = (2 * s * s + 1) / (3 * s * s)
            elif mu == 0 and y1 == y0 and abs(x1 - x0) == s: Mm[c, c2] = (s * s - 1) / (6 * s * s)
            elif mu == 1 and x1 == x0 and y1 == y0: Mm[c, c2] = (2 * s * s + 1) / (3 * s * s)
            elif mu == 1 and x1 == x0 and abs(y1 - y0) == s: Mm[c, c2] = (s * s - 1) / (6 * s * s)
    qe_err = np.abs(QE - Mm).max()
    # competitor at the worst B (top eigenvector of That^{-1} = bottom of That)
    w, V = np.linalg.eigh((That + That.T) / 2)
    B = V[:, 0]
    AB = E @ np.linalg.solve(QE, B)
    cons = np.abs(Q @ AB - B).max()
    ratio_comp = AB @ Ginv @ AB / (B @ B)
    ratio_min = 1.0 / w[0]
    # also a random B
    rng = np.random.default_rng(1)
    Br = rng.standard_normal(o['nc'])
    ABr = E @ np.linalg.solve(QE, Br)
    ratio_r = ABr @ Ginv @ ABr / (Br @ Br)
    ratio_rmin = Br @ np.linalg.solve(That, Br) / (Br @ Br)
    print(f"{tag}: N={N} bonds={o['nb']} blockbonds={o['nc']} |R^2-R|,|R-R^T|={projerr:.1e} "
          f"lam_min(That)={ev[0]:.6f} lam_max(That)={ev[-1]:.6f} |QE-M|={qe_err:.1e} |QA_B-B|={cons:.1e} "
          f"worstB: comp/min energy={ratio_comp:.4f}/{ratio_min:.4f} randomB: comp/min={ratio_r:.4f}/{ratio_rmin:.4f} "
          f"[{time.time()-t0:.1f}s]", flush=True)
    return ev[0]

if __name__ == "__main__":
    Bk = 6
    res = {}
    for n in (1, 2, 4, 8):
        N = n * Bk
        blocks = [(x0, y0, n) for x0 in range(0, N, n) for y0 in range(0, N, n)]
        res[n] = analyze(f"single n={n}", N, blocks)
    # three scales nested: outer ring (width 4) side 1, middle ring side 2, centre side 4; N = 32
    N = 32
    blocks = []
    inner = lambda x, y, lo, hi: lo <= x < hi and lo <= y < hi
    for x0 in range(8, 24, 4):
        for y0 in range(8, 24, 4): blocks.append((x0, y0, 4))
    for x0 in range(4, 28, 2):
        for y0 in range(4, 28, 2):
            if not inner(x0, y0, 8, 24): blocks.append((x0, y0, 2))
    for x0 in range(0, 32):
        for y0 in range(0, 32):
            if not inner(x0, y0, 4, 28): blocks.append((x0, y0, 1))
    res['3scale'] = analyze("three scales 1/2/4", N, blocks)
    print("ratio lam_min(n=8)/lam_min(n=4) =", res[8] / res[4])
    print("lam_min(3scale)/min(single) =", res['3scale'] / min(res[n] for n in (1, 2, 4, 8)))
