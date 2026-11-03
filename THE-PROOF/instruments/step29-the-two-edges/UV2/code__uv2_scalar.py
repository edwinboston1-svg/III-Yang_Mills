# UV2: the SLICE POINCARE SCALAR INEQUALITY, direct instrument (d = 2 or 3, U = 1, abelian component, eta = 1).
#   Slice:  lambda = Lap^{-2} C^T w   (R Lap lambda = 0, R the projection onto Lap N(Q'))   -- M3gR's parametrization
#   ratio:  num/den,  num = a * sum_{c in B} s_c^{d-2} |(Q D lambda)(c)|^2,  den = sum_b ell_b^{-2} |(D lambda)(b)|^2
#   block bonds of (3.16) under convention C (CMP 96 (2.3) for BOND sets: outward crossing bonds in, inward out);
#   fine-bond scale ell_b: 'min' over the end-points' regions (M3gR's toy) or 'max' (the coarser, alternative).
# Double precision: a CHECK / READING, not a proof.  Usage: python -I uv2_scalar.py <case> <recfile>
import sys, time, itertools
import numpy as np, scipy.sparse as sp, scipy.sparse.linalg as spla, scipy.linalg as sla

def build(d, N, levels, ellconv='min', a=1.0):
    """levels: list of (s, lo, hi) outer->inner, Omega_j = [lo,hi)^d (sites), first = (1, 0, N)."""
    sites = list(itertools.product(range(N), repeat=d))
    sid = {p: i for i, p in enumerate(sites)}; ns = len(sites)
    inside = lambda p: all(0 <= q < N for q in p)
    E = [tuple(int(i == m) for i in range(d)) for m in range(d)]
    add = lambda p, v, k=1: tuple(p[i] + k * v[i] for i in range(d))
    # fine bonds: every bond touching Omega_0 (box), stored as (x, mu) with x the lower end
    bonds = []
    for m in range(d):
        for x in itertools.product(range(-1, N), repeat=d):
            if any(x[i] < 0 for i in range(d) if i != m):
                continue
            y = add(x, E[m])
            if inside(x) or inside(y):
                bonds.append((x, m))
    bid = {b: i for i, b in enumerate(bonds)}; nb = len(bonds)
    r, c, v = [], [], []
    for i, (x, m) in enumerate(bonds):
        y = add(x, E[m])
        if inside(y): r.append(i); c.append(sid[y]); v.append(1.0)
        if inside(x): r.append(i); c.append(sid[x]); v.append(-1.0)
    D0 = sp.csr_matrix((v, (r, c)), shape=(nb, ns))
    Lap = (D0.T @ D0).tocsc()
    # regions
    geo = []
    for j, (s, lo, hi) in enumerate(levels):
        Om = {X for X in itertools.product(range(lo, hi, s), repeat=d)}
        if j + 1 < len(levels):
            s1, lo1, hi1 = levels[j + 1]
            Nx = {X for X in Om if all(lo1 <= X[i] < hi1 for i in range(d))}
        else:
            Nx = set()
        geo.append(dict(s=s, Om=Om, Lam=Om - Nx, Nx=Nx))
    reg = {}
    for lev in geo:
        s = lev['s']
        for X in lev['Lam']:
            for p in itertools.product(range(s), repeat=d):
                reg[add(X, p)] = s
    assert len(reg) == ns
    ellb = np.zeros(nb); cross = np.zeros(nb, dtype=bool)
    for i, (x, m) in enumerate(bonds):
        y = add(x, E[m])
        e = [reg[p] for p in (x, y) if p in reg]
        ellb[i] = min(e) if ellconv == 'min' else max(e)
        cross[i] = (len(set(e)) > 1)
    # constraints: block averages on Lambda_j labels
    r, c, v = [], [], []; nC = 0; Csz = []
    for lev in geo:
        s = lev['s']
        for X in sorted(lev['Lam']):
            for p in itertools.product(range(s), repeat=d):
                r.append(nC); c.append(sid[add(X, p)]); v.append(1.0 / s ** d)
            Csz.append(s); nC += 1
    C = sp.csr_matrix((v, (r, c)), shape=(nC, ns))
    # block bonds, convention C
    keys = []
    for lev in geo:
        s, Om, Nx = lev['s'], lev['Om'], lev['Nx']
        if s == 1:
            cand = [(x, add(x, E[m]), m) for (x, m) in bonds]
        else:
            labs = set(itertools.product(range(0, N, s), repeat=d))
            cand = [(X, add(X, E[m], s), m) for X in labs for m in range(d) if add(X, E[m], s) in labs]
        for (y1, y2, m) in cand:
            if ((y1 in Om) or (y2 in Om)) and (y1 not in Nx) and (y2 not in Nx):
                keys.append((s, y1, m))
    keys = sorted(set(keys)); nc = len(keys)
    r, c, v = [], [], []; side = np.zeros(nc)
    for k, (s, X, m) in enumerate(keys):
        side[k] = s
        others = [i for i in range(d) if i != m]
        for pos in range(2 * s - 1):
            wpos = min(pos + 1, 2 * s - 1 - pos)
            for t in itertools.product(range(s), repeat=d - 1):
                x = list(X); x[m] += pos
                for ii, o in enumerate(others): x[o] += t[ii]
                b = (tuple(x), m)
                r.append(k); c.append(bid[b]); v.append(wpos / s ** (d + 1))
    Q = sp.csr_matrix((v, (r, c)), shape=(nc, nb))
    return dict(d=d, N=N, ns=ns, nb=nb, nc=nc, nC=nC, D0=D0, Lap=Lap, C=C, Q=Q, side=side, ellb=ellb, cross=cross,
                reg=reg, sid=sid, sites=sites, bonds=bonds, keys=keys, geo=geo, Csz=np.array(Csz), a=a)

def check_identity(o, rng):
    """Q D lambda = Dbar Q' lambda at U = 1 (CMP 99 (3.115)); returns max abs defect over random lambda."""
    d, N = o['d'], o['N']
    lam = rng.standard_normal(o['ns'])
    QD = o['Q'] @ (o['D0'] @ lam)
    E = [tuple(int(i == m) for i in range(d)) for m in range(d)]
    def avg(s, X):
        tot = 0.0
        for p in itertools.product(range(s), repeat=d):
            q = tuple(X[i] + p[i] for i in range(d))
            tot += lam[o['sid'][q]] if q in o['sid'] else 0.0
        return tot / s ** d
    dmax = 0.0
    for k, (s, X, m) in enumerate(o['keys']):
        Y = tuple(X[i] + s * E[m][i] for i in range(d))
        db = (avg(s, Y) - avg(s, X)) / s
        dmax = max(dmax, abs(db - QD[k]))
    return dmax

def slice_min(o, nev=3):
    t0 = time.time()
    Lap = o['Lap']; C = o['C']
    lu = spla.splu(Lap)
    CT = C.T.toarray()
    X = lu.solve(lu.solve(CT))                       # Lap^{-2} C^T   (ns x nC)
    DX = o['D0'] @ X                                  # D lambda for the basis
    QDX = o['Q'] @ DX
    d = o['d']
    num = o['a'] * (QDX.T * (o['side'] ** (d - 2))) @ QDX
    den = (DX.T * (1.0 / o['ellb'] ** 2)) @ DX
    num = (num + num.T) / 2; den = (den + den.T) / 2
    ev, vec = sla.eigh(num, den)
    w = vec[:, 0]; lam = X @ w; Dl = o['D0'] @ lam
    contrib = (Dl ** 2) / o['ellb'] ** 2; tot = contrib.sum()
    out = dict(ev=ev[:nev], t=time.time() - t0, lam=lam, Dl=Dl, contrib=contrib / tot)
    return out

def where(o, res):
    """share of the denominator on: crossing fine bonds; bonds in each region (by ell); and per distance from Omega_1."""
    c = res['contrib']; cr = o['cross']
    sh = {'crossing': float(c[cr].sum())}
    for s in sorted(set(o['ellb'][~cr])):
        sh[f'ell={int(s)}'] = float(c[(~cr) & (o['ellb'] == s)].sum())
    return sh

CASES = {
    # 2D, reproduce M3gR (conv_toy 'main', 'L4', 'adv' geometries) and extend
    'r2_L2_two_24':   (2, 24, [(1, 0, 24), (2, 8, 16)]),
    'r2_L2_two_32':   (2, 32, [(1, 0, 32), (2, 8, 24)]),
    'r2_L2_three_32': (2, 32, [(1, 0, 32), (2, 4, 28), (4, 8, 24)]),
    'r2_L2_three_40': (2, 40, [(1, 0, 40), (2, 4, 36), (4, 12, 28)]),
    'r2_L4_two_40':   (2, 40, [(1, 0, 40), (4, 12, 28)]),
    'r2_L2_min_22':   (2, 22, [(1, 0, 22), (2, 8, 14)]),
}

if __name__ == "__main__":
    which = sys.argv[1]; recname = sys.argv[2] if len(sys.argv) > 2 else None
    rec = open(recname, 'a', encoding='utf-8') if recname else None
    def say(s):
        print(s, flush=True)
        if rec: rec.write(s + "\n"); rec.flush()
    rng = np.random.default_rng(20261102)
    todo = []
    if which in CASES:
        todo = [(which,) + CASES[which]]
    elif which == 'repro':
        todo = [(k,) + CASES[k] for k in CASES]
    elif which.startswith('Lscan2'):           # two scales 1|L in 2D, Omega_1 = 4x4 big blocks of side L, collar 3L
        for L in (2, 3, 4, 5, 6, 8):
            n1 = 4 * L; col = 3 * L; N = n1 + 2 * col
            todo.append((f'2D two scales 1|{L} N={N}', 2, N, [(1, 0, N), (L, col, col + n1)]))
    elif which.startswith('vol2'):
        for N, lo in ((24, 8), (32, 8), (40, 12), (48, 16)):
            todo.append((f'2D 1|2 N={N} Om1=[{lo},{N-lo})', 2, N, [(1, 0, N), (2, lo, N - lo)]))
    elif which.startswith('d3'):
        todo.append(('3D 1|2 N=16 Om1=[4,12)', 3, 16, [(1, 0, 16), (2, 4, 12)]))
        todo.append(('3D 1|2 N=20 Om1=[6,14)', 3, 20, [(1, 0, 20), (2, 6, 14)]))
    for conv in (sys.argv[3].split(',') if len(sys.argv) > 3 else ['min']):
        for (tag, d, N, levels) in todo:
            o = build(d, N, levels, ellconv=conv)
            idd = check_identity(o, rng)
            res = slice_min(o)
            sh = where(o, res)
            say(f"{tag} [ell={conv}] d={d} N={N} ns={o['ns']} nb={o['nb']} nc={o['nc']} nC={o['nC']} |QDl-DbarQ'l|={idd:.1e} "
                f"slice min ratio={res['ev'][0]:.5f} next={res['ev'][1]:.5f},{res['ev'][2]:.5f} "
                f"den share {{{', '.join(f'{k}: {v:.3f}' for k, v in sh.items())}}} [{res['t']:.1f}s]")
    if rec: rec.close()
