#!/usr/bin/env python3
"""even_stars.py -- THE EVEN STARS (S1 §27, the trunk seat, 2026-11-01 03:0x EST): the exact spin-½ star integral
S_½(G) = ∫_{SU(2)^{V(G)}} Π_{(i,j) ∈ E(G)} χ_½(U_i⁻¹ U_j) dU over every even (Eulerian) simple subgraph G of the
cocktail-party graph K_{2,2,2,2} on the eight half-axes of ℤ⁴ at a vertex, one orbit under the hyperoctahedral group B₄
(order 384) at a time -- the local alphabet of a leaf's self-contacts (Theorem V at spin ½, §23 (i)).

THE FORMULA (exact, no float): tr(U_i⁻¹U_j) = 2⟨u_i, u_j⟩ for unit quaternions, and the moments of the uniform
measure on S³ are Wick sums with E[u_{a1}⋯u_{a2k}] = (Σ_pairings Π δ) / (2^k (k+1)!), so
    S_½(G) = 2^{|E|} · N(G) / Π_h 2^{k_h} (k_h+1)!,     N(G) = Σ_M 4^{L(M)},
M a choice of a perfect matching of the incident edges at every vertex h (k_h = deg h / 2), L(M) the number of loops
the matchings and the edges close -- computed by a transfer over the vertices whose state is the pairing of the open
edges.  A matching at a degree-4 half-axis is a resolution of that link's four plaquettes into corner pairs and L(M) the
number of sheet vertices over v in it, so N(G) also reads the resolutions' 4^{m_v}.

KATs (refused by name if unmet, before any table line): the cycle C_d → 2^{2−d}; the full 3-star K_{2,2,2} → 73/324
(§24's known answer); the empty graph → 1; disjoint unions multiply.

usage: python even_stars.py kat            -- the known answers, exit 3 if any fails
       python even_stars.py table [out]    -- every orbit: mask, |E|, degrees, N, S, e², e, m_max, #matchings
       python even_stars.py one <mask>     -- one subgraph by its 24-bit edge mask
"""
import sys, itertools, math
from fractions import Fraction
from collections import defaultdict

# ---- K_{2,2,2,2}: half-axes 0..7 (axis a = h//2, sign h%2); edges between half-axes of different axes
HALF = list(range(8))
EDGES = [(i, j) for i in range(8) for j in range(i + 1, 8) if i // 2 != j // 2]   # 24 edges
assert len(EDGES) == 24
EIDX = {e: n for n, e in enumerate(EDGES)}

def degrees(mask):
    d = [0] * 8
    for n, (i, j) in enumerate(EDGES):
        if mask >> n & 1:
            d[i] += 1; d[j] += 1
    return d

def is_even(mask):
    return all(x % 2 == 0 for x in degrees(mask))

# ---- the hyperoctahedral group B4: permutations of the 4 axes times sign flips, acting on half-axes then on edges
def group_edge_perms():
    perms = []
    for p in itertools.permutations(range(4)):
        for s in range(16):
            hmap = [0] * 8
            for a in range(4):
                for sg in range(2):
                    sg2 = sg ^ ((s >> a) & 1)
                    hmap[2 * a + sg] = 2 * p[a] + sg2
            ep = [0] * 24
            for n, (i, j) in enumerate(EDGES):
                a, b = hmap[i], hmap[j]
                if a > b: a, b = b, a
                ep[n] = EIDX[(a, b)]
            perms.append(ep)
    assert len(perms) == 384
    return perms

GP = group_edge_perms()

def act(mask, ep):
    m = 0
    for n in range(24):
        if mask >> n & 1:
            m |= 1 << ep[n]
    return m

def canon(mask):
    return min(act(mask, ep) for ep in GP)

# ---- the cycle space: a spanning tree's fundamental cycles span the even subgraphs
def cycle_space():
    parent = list(range(8))
    def find(x):
        while parent[x] != x:
            parent[x] = parent[parent[x]]; x = parent[x]
        return x
    tree = []; nontree = []
    for n, (i, j) in enumerate(EDGES):
        ri, rj = find(i), find(j)
        if ri != rj:
            parent[ri] = rj; tree.append(n)
        else:
            nontree.append(n)
    assert len(tree) == 7 and len(nontree) == 17
    # tree adjacency for paths
    adj = defaultdict(list)
    for n in tree:
        i, j = EDGES[n]; adj[i].append((j, n)); adj[j].append((i, n))
    def tree_path(a, b):
        prev = {a: None}; stack = [a]
        while stack:
            x = stack.pop()
            if x == b: break
            for y, n in adj[x]:
                if y not in prev:
                    prev[y] = (x, n); stack.append(y)
        m = 0; x = b
        while prev[x] is not None:
            px, n = prev[x]; m |= 1 << n; x = px
        return m
    basis = []
    for n in nontree:
        i, j = EDGES[n]
        basis.append((1 << n) | tree_path(i, j))
    return basis

def all_even():
    basis = cycle_space()
    out = []
    for bits in range(1 << 17):
        m = 0
        for t in range(17):
            if bits >> t & 1:
                m ^= basis[t]
        out.append(m)
    return out

# ---- the matching transfer: N(G) = Σ_M 4^{L(M)}, exact integer
def matchings(items):
    if not items:
        yield []
        return
    a = items[0]
    for k in range(1, len(items)):
        b = items[k]
        rest = items[1:k] + items[k + 1:]
        for m in matchings(rest):
            yield [(a, b)] + m

def N_and_mmax(mask):
    """returns (N, m_max, n_matchings): the loop-weighted matching sum, the largest loop count, the number of M."""
    inc = defaultdict(list)
    for n, (i, j) in enumerate(EDGES):
        if mask >> n & 1:
            inc[i].append(n); inc[j].append(n)
    order = sorted(inc.keys(), key=lambda h: -len(inc[h]))   # densest first keeps the frontier small enough
    # state: a tuple of sorted pairs (partner map on open edges) ; value: dict loops -> count
    states = {(): {0: 1}}
    seen = set()
    for h in order:
        es = inc[h]
        new = defaultdict(lambda: defaultdict(int))
        for st, lc in states.items():
            partner = dict()
            for a, b in st:
                partner[a] = b; partner[b] = a
            for M in matchings(list(es)):
                p = dict(partner); closed = 0
                for e, f in M:
                    eo = e in p; fo = f in p
                    if eo and fo:
                        pe, pf = p.pop(e), p.pop(f)
                        p.pop(pe, None); p.pop(pf, None)
                        if pe == f:          # e and f were each other's partners: a loop closes
                            closed += 1
                        else:
                            p[pe] = pf; p[pf] = pe
                    elif eo:
                        pe = p.pop(e); p.pop(pe, None); p[pe] = f; p[f] = pe
                    elif fo:
                        pf = p.pop(f); p.pop(pf, None); p[pf] = e; p[e] = pf
                    else:
                        p[e] = f; p[f] = e
                key = tuple(sorted((a, b) for a, b in p.items() if a < b))
                for loops, cnt in lc.items():
                    new[key][loops + closed] += cnt
        states = {k: dict(v) for k, v in new.items()}
        seen.update(es)
    assert list(states.keys()) == [()], states.keys()
    lc = states[()]
    N = sum(cnt * 4 ** loops for loops, cnt in lc.items())
    mmax = max(lc.keys())
    nm = sum(lc.values())
    return N, mmax, nm

def S_half(mask):
    d = degrees(mask)
    E = bin(mask).count("1")
    N, mmax, nm = N_and_mmax(mask)
    den = 1
    for x in d:
        k = x // 2
        den *= (2 ** k) * math.factorial(k + 1)
    S = Fraction(2 ** E * N, den)
    return S, N, mmax, nm, d, E

def cycle_mask(halves):
    m = 0
    for t in range(len(halves)):
        a, b = halves[t], halves[(t + 1) % len(halves)]
        if a > b: a, b = b, a
        m |= 1 << EIDX[(a, b)]
    return m

def kat():
    ok = True
    # K1: cycles of length 3..8 through half-axes of distinct axes in sequence
    cyc = {3: [0, 2, 4], 4: [0, 2, 4, 6], 5: [0, 2, 4, 6, 3], 6: [0, 2, 4, 1, 3, 5], 7: [0, 2, 4, 6, 1, 3, 5], 8: [0, 2, 4, 6, 1, 3, 5, 7]}
    for d, hs in cyc.items():
        S = S_half(cycle_mask(hs))[0]
        want = Fraction(1, 2 ** (d - 2))
        print(f"KAT C_{d}: S = {S} (want {want}) {'MET' if S == want else 'FAILED'}")
        ok &= S == want
    # K2: K_{2,2,2} on the half-axes of axes 0,1,2
    m = 0
    for n, (i, j) in enumerate(EDGES):
        if i < 6 and j < 6: m |= 1 << n
    S, N, mmax, nm, d, E = S_half(m)
    print(f"KAT K_2,2,2: S = {S} (want 73/324) N = {N} m_max = {mmax} matchings = {nm} {'MET' if S == Fraction(73, 324) else 'FAILED'}")
    ok &= S == Fraction(73, 324)
    # K3: empty
    S0 = S_half(0)[0]; print(f"KAT empty: S = {S0} {'MET' if S0 == 1 else 'FAILED'}"); ok &= S0 == 1
    # K4: disjoint union multiplies: a triangle on {0,2,4} and a triangle on {1,3,5}
    S1 = S_half(cycle_mask([0, 2, 4]))[0]; S2 = S_half(cycle_mask([1, 3, 5]))[0]; S12 = S_half(cycle_mask([0, 2, 4]) | cycle_mask([1, 3, 5]))[0]
    print(f"KAT disjoint union: {S12} = {S1} * {S2} {'MET' if S12 == S1 * S2 else 'FAILED'}"); ok &= S12 == S1 * S2
    # E2 (the stake, printed beside the KATs but not a KAT): the pinch star, two cycles sharing half-axis 0: C3 on {0,2,4} and C4 on {0,3,5,7}
    mp = cycle_mask([0, 2, 4]) | cycle_mask([0, 3, 5, 7])
    S, N, mmax, nm, d, E = S_half(mp)
    e2 = S / Fraction(1, 2 ** (sum(d) // 2 - 2))
    print(f"E2 pinch star (C3 + C4 sharing half-axis 0): S = {S} (stake 24/2^7 = {Fraction(24, 128)}) e2 = {e2} (stake 6) m_max = {mmax}")
    return ok

def row(mask):
    S, N, mmax, nm, d, E = S_half(mask)
    dv = sum(d) // 2            # the number of plaquettes at v = |E|
    e2 = S / Fraction(1, 2 ** (dv - 2)) if dv >= 2 else Fraction(1)
    e = math.sqrt(e2)
    return f"mask={mask:024b} E={E} deg={''.join(str(x) for x in d)} N={N} S={S} e2={e2} e={e:.6f} mmax={mmax} matchings={nm}"

def table(out):
    evens = all_even()
    orbits = {}
    for m in evens:
        c = canon(m)
        orbits[c] = orbits.get(c, 0) + 1
    reps = sorted(orbits.keys(), key=lambda m: (bin(m).count("1"), m))
    with open(out, "w") as f:
        f.write(f"# even_stars.py table: {len(evens)} even subgraphs of K_2,2,2,2, {len(reps)} orbits under B4 (order 384)\n")
        best = (0, None)
        for m in reps:
            r = row(m)
            f.write(r + f" orbit={orbits[m]}\n")
            e2 = Fraction(r.split("e2=")[1].split()[0])
            if e2 > best[0]: best = (e2, m)
        f.write(f"# max e2 = {best[0]} ({math.sqrt(best[0]):.6f}) at mask {best[1]:024b}\n")
    print(f"{len(evens)} even subgraphs, {len(reps)} orbits -> {out}; max e2 = {best[0]} (e = {math.sqrt(best[0]):.6f})")

if __name__ == "__main__":
    mode = sys.argv[1] if len(sys.argv) > 1 else "kat"
    if mode == "kat":
        sys.exit(0 if kat() else 3)
    elif mode == "table":
        table(sys.argv[2] if len(sys.argv) > 2 else "even_stars.table.txt")
    elif mode == "one":
        print(row(int(sys.argv[2], 0)))
    else:
        print(__doc__); sys.exit(2)
