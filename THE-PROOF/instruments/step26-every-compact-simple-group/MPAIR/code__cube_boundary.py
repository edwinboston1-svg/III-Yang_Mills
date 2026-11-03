# MPAIR cube_boundary.py -- the perfect cover of THE GROUND (period 2) inside Chatterjee's cubes.
# For a cube B = c + {0..N}^4 (Chatterjee: edges of B = both endpoints in B; boundary edges = both endpoints on the boundary of B, i.e.
# edges lying in a face; interior edges = the rest), every interior L0 link x has six plaquettes, all inside B.  A plaquette is
# INTEGRATED if its cover link is interior (that link is integrated exactly given L0) and BARE if its cover link is a (fixed) boundary edge.
# For each interior L0 link we record the tuple (k, Ndir, Nmed, Nbare):
#   k     = number of bare plaquettes at x,
#   Ndir  = sum over integrated plaquettes p of the number of INTERIOR links among p's two other L0 links,
#   Nmed  = sum over integrated p of the number of interior links among the 15 L0 links of the other five plaquettes of p's cover link,
#   Nbare = sum over bare p of the number of interior links among p's two other L0 links.
# Interdependence row sum of x in the cube's L0 marginal <= Ndir*C_dir + Nmed*C_med + Nbare*C_bare (THE GROUND's count, with multiplicity).
import sys, itertools

def cover_dir(x):
    a = [v % 2 for v in x]
    x1, x2, x3, x4 = a
    hits = []
    if x2 == x3 == x4: hits.append(0)
    if x4 == x1 and x1 != x3: hits.append(1)
    if x2 == x1 and x1 != x4: hits.append(2)
    if x3 == x1 and x1 != x2: hits.append(3)
    assert len(hits) == 1, (x, hits)
    return hits[0]

E = [(1,0,0,0),(0,1,0,0),(0,0,1,0),(0,0,0,1)]
def add(x, y, s=1): return tuple(x[i] + s * y[i] for i in range(4))

def is_cover(link):
    x, mu = link
    return cover_dir(x) == mu

def plaq_links(y, mu, nu):
    # plaquette at base y in plane (mu, nu): its four links as (base, dir)
    return [(y, mu), (add(y, E[mu]), nu), (add(y, E[nu]), mu), (y, nu)]

def plaquettes_of(link):
    x, mu = link
    out = []
    for nu in range(4):
        if nu == mu: continue
        for y in (x, add(x, E[nu], -1)):
            a, b = (mu, nu) if mu < nu else (nu, mu)
            out.append(tuple(plaq_links(y, a, b)))
    return out

def check_cover():
    # S-1: the rule partitions the residues (asserted in cover_dir) and each plaquette of the side-2 torus has exactly one cover link
    cnt = {}
    bad = 0; tot = 0
    for y in itertools.product(range(2), repeat=4):
        for mu, nu in itertools.combinations(range(4), 2):
            L = plaq_links(y, mu, nu)
            c = sum(1 for (b, d) in L if cover_dir(tuple(v % 2 for v in b)) == d)
            tot += 1
            if c != 1: bad += 1
    return tot, bad

def enumerate_cube(c, N):
    lo = c; hi = tuple(ci + N for ci in c)
    def inB(v): return all(lo[i] <= v[i] <= hi[i] for i in range(4))
    def interior_v(v): return all(lo[i] < v[i] < hi[i] for i in range(4))
    def edge_in_B(l):
        x, mu = l
        return inB(x) and inB(add(x, E[mu]))
    def interior_e(l):
        x, mu = l
        return edge_in_B(l) and (interior_v(x) or interior_v(add(x, E[mu])))
    tuples = {}
    nint0 = 0
    for x in itertools.product(*[range(lo[i], hi[i] + 1) for i in range(4)]):
        for mu in range(4):
            l = (x, mu)
            if not interior_e(l) or is_cover(l): continue
            nint0 += 1
            k = Nd = Nm = Nb = 0
            for p in plaquettes_of(l):
                assert all(edge_in_B(q) for q in p)          # all plaquettes of an interior edge lie in B
                covs = [q for q in p if is_cover(q)]
                assert len(covs) == 1
                a = covs[0]
                others = [q for q in p if q != l and q != a]
                assert len(others) == 2 and not any(is_cover(q) for q in others)
                if interior_e(a):
                    Nd += sum(1 for q in others if interior_e(q))
                    for p2 in plaquettes_of(a):
                        if set(p2) == set(p): continue
                        assert l not in p2
                        Nm += sum(1 for q in p2 if q != a and interior_e(q))
                else:
                    k += 1
                    Nb += sum(1 for q in others if interior_e(q))
            key = (k, Nd, Nm, Nb)
            tuples[key] = tuples.get(key, 0) + 1
    return tuples, nint0

if __name__ == '__main__':
    tot, bad = check_cover()
    print('S-1 CHECK: plaquettes of the side-2 torus %d, with cover-count != 1: %d' % (tot, bad))
    allt = {}
    for N in (6, 7):
        for c in itertools.product(range(2), repeat=4):
            t, n0 = enumerate_cube(c, N)
            for key, v in t.items():
                allt.setdefault(key, set()).add((N, c))
    print('distinct tuples (k, Ndir, Nmed, Nbare) over N in {6,7} and all 16 offsets: %d' % len(allt))
    for key in sorted(allt):
        print('  ', key, 'realised in', len(allt[key]), 'cubes')
    kmax = max(k[0] for k in allt)
    print('max k =', kmax, '; max Nbare =', max(k[3] for k in allt), '; bulk tuple present:', (0, 12, 90, 0) in allt)
