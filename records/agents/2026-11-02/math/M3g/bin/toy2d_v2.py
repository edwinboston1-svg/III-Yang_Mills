# S2' (M3g): the multiscale toy with Balaban's bond convention (CMP 96 p. 224): at scale j the block bonds are the
# j-lattice bonds with AT LEAST ONE endpoint in Lambda_j (so interface-crossing block bonds are included).
# Double precision, a CHECK. Reports positivity of G^{-1}, lam_min/max of T-hat, the Riesz constant of Q, and the
# cosine of the angle between the spans of adjacent scales' functionals.
import numpy as np, sys, os, time
sys.path.insert(0, os.path.dirname(__file__))

def build_v2(N, blocks, a=1.0, ap=1.0):
    sid = {(x, y): i for i, (x, y) in enumerate((x, y) for x in range(N) for y in range(N))}
    ns = len(sid)
    bonds = []
    for x in range(N):
        for y in range(N):
            if x + 1 < N: bonds.append((x, y, 0))
            if y + 1 < N: bonds.append((x, y, 1))
    bid = {b: i for i, b in enumerate(bonds)}; nb = len(bonds)
    d0 = np.zeros((nb, ns))
    for i, (x, y, mu) in enumerate(bonds):
        x2, y2 = (x + 1, y) if mu == 0 else (x, y + 1)
        d0[i, sid[(x2, y2)]] += 1.0; d0[i, sid[(x, y)]] -= 1.0
    Lap = np.zeros((ns, ns))
    for (x, y), i in sid.items():
        Lap[i, i] = 4.0
        for dx, dy in ((1, 0), (-1, 0), (0, 1), (0, -1)):
            j = sid.get((x + dx, y + dy))
            if j is not None: Lap[i, j] -= 1.0
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
    Qp = np.zeros((len(blocks), ns))
    for bi, (x0, y0, s) in enumerate(blocks):
        for x in range(x0, x0 + s):
            for y in range(y0, y0 + s): Qp[bi, sid[(x, y)]] = 1.0 / (s * s)
    # block bonds: j-lattice bonds with at least one endpoint a block of the list (same side s); key = (lower corner, s, mu)
    keyset = set()
    for (x0, y0, s) in blocks:
        for mu in (0, 1):
            for sgn in (1, -1):
                lo = (x0, y0) if sgn == 1 else ((x0 - s, y0) if mu == 0 else (x0, y0 - s))
                hi_end = (lo[0] + 2 * s - 1, lo[1] + s - 1) if mu == 0 else (lo[0] + s - 1, lo[1] + 2 * s - 1)
                if lo[0] < 0 or lo[1] < 0 or hi_end[0] >= N or hi_end[1] >= N: continue   # slab must lie in Omega_0
                keyset.add((lo[0], lo[1], s, mu))
    cb = sorted(keyset)
    nc = len(cb)
    Q = np.zeros((nc, nb)); side = np.zeros(nc)
    for c, (x0, y0, s, mu) in enumerate(cb):
        side[c] = s
        for t in range(s):
            for p in range(s):
                for q in range(s):
                    pos = p + q
                    x, y = (x0 + pos, y0 + t) if mu == 0 else (x0 + t, y0 + pos)
                    Q[c, bid[(x, y, mu)]] += 1.0 / s ** 3
    Gp = np.linalg.inv(Lap + ap * Qp.T @ Qp)
    X = Gp @ Qp.T
    P = X @ np.linalg.solve(Qp @ Gp @ Gp @ Qp.T, X.T)
    R = np.eye(ns) - P
    Ginv = d1.T @ d1 + d0 @ R @ d0.T + a * Q.T @ Q
    return dict(Q=Q, R=R, Ginv=Ginv, side=side, cb=cb, nb=nb, nc=nc)

def analyze(tag, N, blocks):
    t0 = time.time()
    o = build_v2(N, blocks)
    Q, Ginv, side = o['Q'], o['Ginv'], o['side']
    evG = np.linalg.eigvalsh(Ginv)
    G = np.linalg.inv(Ginv)
    inv_err = np.abs(Ginv @ G - np.eye(len(G))).max()
    That = Q @ G @ Q.T                     # d = 2: symmetrized T-hat
    ev = np.linalg.eigvalsh((That + That.T) / 2)
    W = np.diag(side ** 2)
    Riesz = np.linalg.eigvalsh(np.sqrt(W) @ Q @ Q.T @ np.sqrt(W))   # <h,QQ*h>_B / ||h||_B^2 with Q* = Q^T W
    # angle between spans of functionals of different scales (normalized by block measure)
    F = (Q.T * side)            # columns f_c / l_c^{d/2} * ... : f_c = Q^T W e_c restricted; normalize f_c by l_c (d=2: l^{d/2}=l)
    cos = {}
    for s1 in sorted(set(side)):
        for s2 in sorted(set(side)):
            if s2 <= s1: continue
            A1 = F[:, side == s1]; A2 = F[:, side == s2]
            U1, S1, _ = np.linalg.svd(A1, full_matrices=False); U1 = U1[:, S1 > 1e-10 * S1.max()]
            U2, S2, _ = np.linalg.svd(A2, full_matrices=False); U2 = U2[:, S2 > 1e-10 * S2.max()]
            cos[(s1, s2)] = np.linalg.svd(U1.T @ U2, compute_uv=False).max()
    print(f"{tag}: N={N} bonds={o['nb']} blockbonds={o['nc']} Ginv eig min={evG[0]:.3e} |Ginv G-I|={inv_err:.1e} "
          f"lam_min(That)={ev[0]:.6f} lam_max(That)={ev[-1]:.6f} Riesz min/max={Riesz[0]:.4f}/{Riesz[-1]:.4f} "
          f"cos(adjacent scales)={ {k: round(v, 4) for k, v in cos.items()} } [{time.time()-t0:.1f}s]", flush=True)
    return ev[0]

def rings(N, layout):
    # layout: list of (lo, hi, s) from outer to inner; blocks of side s fill [lo,hi)^2 minus the next inner square
    blocks = []
    for idx, (lo, hi, s) in enumerate(layout):
        nxt = layout[idx + 1] if idx + 1 < len(layout) else None
        for x0 in range(lo, hi, s):
            for y0 in range(lo, hi, s):
                if nxt and nxt[0] <= x0 < nxt[1] and nxt[0] <= y0 < nxt[1]: continue
                blocks.append((x0, y0, s))
    return blocks

if __name__ == "__main__":
    res = {}
    for n in (2, 4, 8):
        N = 6 * n
        res[n] = analyze(f"single n={n}", N, [(x0, y0, n) for x0 in range(0, N, n) for y0 in range(0, N, n)])
    res['3s'] = analyze("three scales 1/2/4 (N=32)", 32, rings(32, [(0, 32, 1), (4, 28, 2), (8, 24, 4)]))
    res['3s_b'] = analyze("three scales 1/2/4 (N=40, thicker)", 40, rings(40, [(0, 40, 1), (4, 36, 2), (12, 28, 4)]))
    res['2s'] = analyze("two scales 2/8 (L=4, N=48)", 48, rings(48, [(0, 48, 2), (16, 32, 8)]))
    print("lam_min(n=8)/lam_min(n=4) =", res[8] / res[4], " lam_min(3s)/lam_min(n=4) =", res['3s'] / res[4])
