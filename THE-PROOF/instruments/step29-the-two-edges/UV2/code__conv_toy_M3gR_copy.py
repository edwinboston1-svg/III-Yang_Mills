# M3gR: a CONSISTENT Dirichlet 2D abelian toy of Balaban's multiscale operators at U = 1 (CMP 96 Sect. A / CMP 99 (3.16),
# (3.25)-(3.27), (3.122)), under three readings of the block bonds of (3.16):
#  (A) M3g's: j-bonds with at least one end-point in Lambda_j;
#  (B) both end-points in Lambda_j;
#  (C) CMP 96 (2.3) taken for BOND sets: j-bonds touching Omega_j^(j) and not touching Omega_{j+1}^(j).
# Consistency: scalars lambda on sites of Omega_0 = [0,N)^2, zero outside; fields A on every bond touching Omega_0, zero on
# bonds outside; D0 lambda on all those bonds; D1 on every plaquette meeting a field bond; D1 D0 = 0 exactly; Lap = D0^T D0
# (Dirichlet). R = orthogonal projection onto Lap N(Q') (CMP 96 (2.10)); also Balaban's formula (2.17) as a cross-check.
# Double precision: a CHECK, not a proof.
import numpy as np, scipy.sparse as sp, scipy.sparse.linalg as spla, sys, time

def geometry(N, levels):
    """levels: list of (s, lo, hi) outer->inner; Omega_j = [lo,hi)^2 (sites); the first must be (s0, 0, N).
    Returns per level: s, set of s-labels of Omega_j, set of Lambda_j labels, set of s-labels inside Omega_{j+1}."""
    out = []
    for j, (s, lo, hi) in enumerate(levels):
        assert lo % s == 0 and hi % s == 0
        Om = {(X, Y) for X in range(lo, hi, s) for Y in range(lo, hi, s)}
        if j + 1 < len(levels):
            s1, lo1, hi1 = levels[j + 1]
            Nx = {(X, Y) for (X, Y) in Om if lo1 <= X < hi1 and lo1 <= Y < hi1}
        else:
            Nx = set()
        out.append(dict(s=s, Om=Om, Lam=Om - Nx, Nx=Nx))
    return out

def geometry_sets(N, levels_sets):
    """levels_sets: list of (s, set_of_sites_of_Omega_j) outer->inner (arbitrary unions of s-blocks)."""
    out = []
    for j, (s, sites) in enumerate(levels_sets):
        Om = {(X, Y) for (X, Y) in {(x - x % s, y - y % s) for (x, y) in sites}
              if all((X + p, Y + q) in sites for p in range(s) for q in range(s))}
        if j + 1 < len(levels_sets):
            nxt = levels_sets[j + 1][1]
            Nx = {(X, Y) for (X, Y) in Om if (X, Y) in nxt}
        else:
            Nx = set()
        out.append(dict(s=s, Om=Om, Lam=Om - Nx, Nx=Nx))
    return out

def build(N, geo, conv, a=1.0):
    sites = [(x, y) for x in range(N) for y in range(N)]
    sid = {p: i for i, p in enumerate(sites)}; ns = len(sites)
    inside = lambda p: 0 <= p[0] < N and 0 <= p[1] < N
    bonds = [(x, y, 0) for x in range(-1, N) for y in range(N)] + [(x, y, 1) for x in range(N) for y in range(-1, N)]
    bonds = [b for b in bonds if inside((b[0], b[1])) or inside((b[0] + (b[2] == 0), b[1] + (b[2] == 1)))]
    bid = {b: i for i, b in enumerate(bonds)}; nb = len(bonds)
    r, c, v = [], [], []
    for i, (x, y, mu) in enumerate(bonds):
        p1 = (x + (mu == 0), y + (mu == 1))
        if inside(p1): r.append(i); c.append(sid[p1]); v.append(1.0)
        if inside((x, y)): r.append(i); c.append(sid[(x, y)]); v.append(-1.0)
    D0 = sp.csr_matrix((v, (r, c)), shape=(nb, ns))
    r, c, v = [], [], []; npq = 0
    for x in range(-1, N):
        for y in range(-1, N):
            row = []
            for (bx, by, mu, sg) in ((x, y, 0, 1.0), (x + 1, y, 1, 1.0), (x, y + 1, 0, -1.0), (x, y, 1, -1.0)):
                k = bid.get((bx, by, mu))
                if k is not None: row.append((k, sg))
            if row:
                for k, sg in row: r.append(npq); c.append(k); v.append(sg)
                npq += 1
    D1 = sp.csr_matrix((v, (r, c)), shape=(npq, nb))
    assert abs(D1 @ D0).max() < 1e-12, "D1 D0 != 0"
    Lap = (D0.T @ D0).tocsc()
    # constraints C (rows: block averages at Lambda_j labels); Q' as in (3.19) at U = 1
    r, c, v = [], [], []; nC = 0; lsite = []
    for lev in geo:
        s = lev['s']
        for (X, Y) in sorted(lev['Lam']):
            for p in range(s):
                for q in range(s): r.append(nC); c.append(sid[(X + p, Y + q)]); v.append(1.0 / (s * s))
            lsite.append(s); nC += 1
    C = sp.csr_matrix((v, (r, c)), shape=(nC, ns))
    # block bonds
    keys = []
    for jl, lev in enumerate(geo):
        s = lev['s']; Om, Lam, Nx = lev['Om'], lev['Lam'], lev['Nx']
        if s == 1:
            cand = [((x, y), (x + (mu == 0), y + (mu == 1)), mu) for (x, y, mu) in bonds]
        else:
            labs = {(X, Y) for X in range(0, N, s) for Y in range(0, N, s)}
            cand = []
            for (X, Y) in labs:
                for mu in (0, 1):
                    Y2 = (X + s * (mu == 0), Y + s * (mu == 1))
                    if Y2 in labs: cand.append(((X, Y), Y2, mu))   # both blocks inside the box (slab in Omega_0)
        for (y1, y2, mu) in cand:
            if conv == 'A': ok = (y1 in Lam) or (y2 in Lam)
            elif conv == 'B': ok = (y1 in Lam) and (y2 in Lam)
            elif conv == 'C': ok = ((y1 in Om) or (y2 in Om)) and (y1 not in Nx) and (y2 not in Nx)
            else: raise ValueError
            if ok: keys.append((s, y1, mu))
    keys = sorted(set(keys))
    nc = len(keys)
    r, c, v = [], [], []
    side = np.zeros(nc)
    for k, (s, (X, Y), mu) in enumerate(keys):
        side[k] = s
        for t in range(s):
            for p in range(s):
                for q in range(s):
                    pos = p + q
                    b = (X + pos, Y + t, 0) if mu == 0 else (X + t, Y + pos, 1)
                    r.append(k); c.append(bid[b]); v.append(1.0 / s ** 3)
    Q = sp.csr_matrix((v, (r, c)), shape=(nc, nb))
    # R: projection onto Lap N(Q'); complement range = Lap^{-1} range(C^T)
    V = spla.spsolve(Lap, C.T.tocsc()).toarray() if nC > 0 else np.zeros((ns, 0))
    P = V @ np.linalg.solve(V.T @ V, V.T)
    R = np.eye(ns) - P
    # fine-bond scale ell(b): side of the region containing the bond (min over its end-points' regions)
    reg = {}
    for lev in geo:
        s = lev['s']
        for (X, Y) in lev['Lam']:
            for p in range(s):
                for q in range(s): reg[(X + p, Y + q)] = s
    ellb = np.zeros(nb)
    for i, (x, y, mu) in enumerate(bonds):
        e = [reg[p] for p in ((x, y), (x + (mu == 0), y + (mu == 1))) if p in reg]
        ellb[i] = min(e)
    return dict(N=N, ns=ns, nb=nb, nc=nc, nC=nC, D0=D0, D1=D1, Lap=Lap, C=C, Q=Q, R=R, V=V, side=side, keys=keys,
                ellb=ellb, sid=sid, bonds=bonds, a=a, geo=geo, lsite=np.array(lsite))

def analyze(tag, N, geo, conv, a=1.0, extra=True, rec=None):
    t0 = time.time()
    o = build(N, geo, conv, a)
    D0, D1, Q, R, C, Lap = o['D0'].toarray(), o['D1'], o['Q'].toarray(), o['R'], o['C'].toarray(), o['Lap']
    Ginv = (D1.T @ D1).toarray() + D0 @ R @ D0.T + a * Q.T @ Q
    evG = np.linalg.eigvalsh(Ginv)
    line = f"{tag} conv={conv}: N={N} nb={o['nb']} nc={o['nc']} nC={o['nC']} Ginv min eig={evG[0]:.3e}"
    # gauge defect: max over nu in N(Q') of |Q D0 nu| / |nu|
    U_, S_, Vt = np.linalg.svd(C, full_matrices=True)
    rk = int((S_ > 1e-12 * S_.max()).sum())
    Nb = Vt[rk:].T                                     # orthonormal basis of N(Q') = ker C
    QDn = Q @ D0 @ Nb
    gam = np.linalg.norm(QDn, 2) if QDn.size else 0.0
    gref = np.linalg.norm(Q @ D0, 2)
    line += f" gauge defect={gam:.3e} (|QD0|={gref:.3f})"
    # check R against Balaban's (2.17): R_B = I - G'Q'*(Q'G'^2Q'*)^-1 Q'G', G' = (Lap + C^T W a C)^-1, W = diag(s^2)
    W1 = np.diag(o['lsite'] ** 2.0)
    Gp = np.linalg.inv(Lap.toarray() + C.T @ W1 @ C)
    X = Gp @ C.T @ W1
    RB = np.eye(o['ns']) - X @ np.linalg.solve(C @ Gp @ Gp @ C.T @ W1, C @ Gp)
    line += f" |R-R_Balaban|={np.abs(R - RB).max():.1e}"
    res = dict(minG=evG[0], gam=gam)
    if evG[0] > 1e-9:
        G = np.linalg.inv(Ginv)
        W = np.diag(o['side'] ** 2.0)
        RDGQ = R @ D0.T @ G @ Q.T @ W
        line += f" |RD*GQ*|={np.abs(RDGQ).max():.3e}"
        T = Q @ G @ Q.T                                  # d = 2: spectrum of T-hat
        evT, vecT = np.linalg.eigh((T + T.T) / 2)
        Riesz = np.linalg.eigvalsh(np.sqrt(W) @ Q @ Q.T @ np.sqrt(W))
        # where does the lam_min eigenvector live
        vmin = vecT[:, 0] ** 2
        sides = sorted(set(o['side']))
        share = {int(s_): float(vmin[o['side'] == s_].sum()) for s_ in sides}
        line += (f" lam_min(That)={evT[0]:.6f} lam_max(That)={evT[-1]:.9f} Riesz min={Riesz[0]:.4f}"
                 f" eigvec share by side={ {k: round(v, 3) for k, v in share.items()} }")
        res.update(lmin=evT[0], lmax=evT[-1], riesz=Riesz[0])
        if extra:
            # slice pure-gauge modes: lambda = Lap^-2 C^T w spans the slice {R Lap lambda = 0}
            Ld = Lap.toarray()
            Xs = D0 @ np.linalg.solve(Ld, np.linalg.solve(Ld, C.T))
            num = a * (Q @ Xs).T @ (Q @ Xs) + Xs.T @ Ginv @ Xs * 0.0
            num2 = Xs.T @ Ginv @ Xs
            den = Xs.T @ np.diag(1.0 / o['ellb'] ** 2) @ Xs
            import scipy.linalg as sla
            ev_pg = sla.eigh((num2 + num2.T) / 2, (den + den.T) / 2, eigvals_only=True)
            # smooth one: lambda_smooth = sin sin, projected to the slice
            xs = np.array([p[0] for p in o['sid']]); ys = np.array([p[1] for p in o['sid']])
            lam = np.sin(np.pi * (xs + 1) / (N + 1)) * np.sin(np.pi * (ys + 1) / (N + 1))
            lam_s = lam - np.linalg.solve(Ld, R @ (Ld @ lam))
            A = D0 @ lam_s
            rq_smooth = (A @ Ginv @ A) / (A @ (A / o['ellb'] ** 2))
            # the next object: lam_min of ell G^-1 ell
            Lb = np.diag(o['ellb'])
            ev_next = np.linalg.eigvalsh(Lb @ Ginv @ Lb)[0]
            line += (f" | slice-pure-gauge Rayleigh min={ev_pg[0]:.4f} smooth={rq_smooth:.4f} (a={a})"
                     f" lam_min(ell Ginv ell)={ev_next:.4f}")
            res.update(pg=ev_pg[0], pgs=rq_smooth, nxt=ev_next)
    line += f" [{time.time() - t0:.1f}s]"
    print(line, flush=True)
    if rec: rec.write(line + "\n"); rec.flush()
    return res

if __name__ == "__main__":
    which = sys.argv[1] if len(sys.argv) > 1 else 'small'
    recname = sys.argv[2] if len(sys.argv) > 2 else None
    rec = open(recname, 'a', encoding='utf-8') if recname else None
    G = []
    if which == 'small':
        G.append(("L2 two scales N=24 (1|2, Omega1=[8,16) 4x4 blocks)", 24, geometry(24, [(1, 0, 24), (2, 8, 16)])))
    elif which == 'main':
        G.append(("L2 two scales N=32 (1|2, Omega1=[8,24))", 32, geometry(32, [(1, 0, 32), (2, 8, 24)])))
        G.append(("L2 three scales N=32 (1|2|4 M3g's)", 32, geometry(32, [(1, 0, 32), (2, 4, 28), (4, 8, 24)])))
        G.append(("L2 three scales N=40 (thicker, M3g's)", 40, geometry(40, [(1, 0, 40), (2, 4, 36), (4, 12, 28)])))
    elif which == 'L4':
        G.append(("L4 two scales N=40 (1|4, Omega1=[12,28))", 40, geometry(40, [(1, 0, 40), (4, 12, 28)])))
        G.append(("L4 two scales 2|8 N=48 (M3g's, no scale-0 ring)", 48, geometry(48, [(2, 0, 48), (8, 16, 32)])))
    elif which == 'adv':
        G.append(("L2 minimal big block 3x3 of side 2, N=22", 22, geometry(22, [(1, 0, 22), (2, 8, 14)])))
        sites1 = {(x, y) for x in range(8, 20) for y in range(8, 14)} | {(x, y) for x in range(8, 14) for y in range(14, 20)}
        G.append(("L2 L-shaped Omega1 (three 6x6 big blocks), N=28", 28,
                  geometry_sets(28, [(1, {(x, y) for x in range(28) for y in range(28)}), (2, sites1)])))
        G.append(("L2 four scales 1|2|4|8 N=48", 48, geometry(48, [(1, 0, 48), (2, 4, 44), (4, 8, 40), (8, 16, 32)])))
    convs = sys.argv[3].split(',') if len(sys.argv) > 3 else ['A', 'B', 'C']
    for tag, N, geo in G:
        for conv in convs:
            analyze(tag, N, geo, conv, rec=rec, extra=(N <= 40))
    if rec: rec.close()
