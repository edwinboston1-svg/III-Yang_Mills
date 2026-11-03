# realign_bound.py -- THE REALIGNED OPERATOR-NORM BOUND ON A VERTEX STAR, PROTOTYPE FOR MEASUREMENT (the author, 2026-10-30 07:1x EDT).
# S(G) = the contraction of one Haar projector P_l per link along the plaquette edges, each edge two strands (the a- and b-indices of the
# character).  Contract the nodes in an order: |S| <= ||P_1||_F * prod_{t=2}^{n-1} ||M_t||_op * ||P_n||_F, with M_t the projector of node t
# REALIGNED as a matrix from its strands toward the uncontracted nodes to its strands toward the cluster (||AB||_F <= ||A||_F ||B||_op node
# by node, Cauchy-Schwarz at the last).  For P = sum_tau |tau><tau| (tau an orthonormal basis of the invariants) M = sum_tau tau_mat x conj(tau_mat),
# and the Schur test gives ||M||_op <= sqrt(max_s sum_tau r_tau(s)^2 * max_n sum_tau c_tau(n)^2), r_tau(s) = sum_n |tau_mat[s,n]|, c the column
# sums -- every quantity from the invariant basis alone.  The Frobenius sieve is the special case that pays ||P||_F = sqrt(R) at EVERY node;
# here the middle nodes pay a realigned norm that is a fraction of sqrt(R) when the invariants are entangled across the split (K_4 at spin 1:
# 1/3 per middle node, bound 1/9 against the sieve's 1 and the exact 1/36).  The invariant basis: products of delta (1,1), epsilon (1,1,1),
# epsilon_2 (1/2,1/2) and sigma (1; 1/2,1/2) blocks over the legs, orthonormalised (complex floats; a MEASUREMENT instrument -- the certified
# version, if the measured gain warrants it, computes the same Schur sums in exact arithmetic from an integer basis and the Gram inverse).
# usage: python -I realign_bound.py KAT
#        python -I realign_bound.py ROWS <file of WCONF or STAR-EXACT-FILE lines> [max rows]   (bound, Frobenius, threshold, exact if r2= given)
import sys, itertools, math
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
RIO = [1, 0, 1, 1, 3, 6, 15, 36, 91, 232, 603]
EPS3 = {(0, 1, 2): 1, (1, 2, 0): 1, (2, 0, 1): 1, (0, 2, 1): -1, (2, 1, 0): -1, (1, 0, 2): -1}
SIG = [[[0, 1], [1, 0]], [[0, -1j], [1j, 0]], [[1, 0], [0, -1]]]          # Pauli
EPS2 = [[0, 1], [-1, 0]]


def sigeps(a):
    """(sigma^a epsilon)_{alpha beta}: the invariant coupling a spin-1 leg (component a) to two spin-1/2 legs"""
    out = {}
    for al in range(2):
        for be in range(2):
            v = sum(SIG[a][al][g] * EPS2[g][be] for g in range(2))
            if abs(v) > 0:
                out[(al, be)] = v
    return out


def tensor_product(blocks, L):
    """blocks: list of (legs tuple, dict index-tuple -> value); returns a sparse dict over all L legs"""
    out = {(): 1}
    for legs, blk in blocks:
        new = {}
        for k, v in out.items():
            for bk, bv in blk.items():
                new[k + tuple(zip(legs, bk))] = v * bv
        out = new
    res = {}
    for k, v in out.items():
        idx = [None] * L
        for leg, val in k:
            idx[leg] = val
        t = tuple(idx)
        res[t] = res.get(t, 0) + v
    return {k: v for k, v in res.items() if abs(v) > 0}


def set_partitions_pairs_triples(items):
    """all partitions of the list into blocks of size 2 or 3"""
    if not items:
        yield []
        return
    first = items[0]
    rest = items[1:]
    for j in range(len(rest)):
        for p in set_partitions_pairs_triples(rest[:j] + rest[j + 1:]):
            yield [(first, rest[j])] + p
    for j in range(len(rest)):
        for k in range(j + 1, len(rest)):
            for p in set_partitions_pairs_triples(rest[:j] + rest[j + 1:k] + rest[k + 1:]):
                yield [(first, rest[j], rest[k])] + p


def blocks_of(part):
    bl = []
    for b in part:
        if len(b) == 2:
            bl.append((b, {(a, a): 1 for a in range(3)}))
        else:
            bl.append((b, dict(EPS3)))
    return bl


def diagrams(d, h):
    """spanning set of Inv(V_1^{x d} (x) V_{1/2}^{x h}); legs 0..d-1 spin 1, d..d+h-1 spin 1/2 (h in {0, 2})"""
    L = d + h
    one = list(range(d))
    halves = list(range(d, d + h))
    out = []
    if h == 0:
        for part in set_partitions_pairs_triples(one):
            out.append(tensor_product(blocks_of(part), L))
    else:
        for part in set_partitions_pairs_triples(one):   # the two halves paired by epsilon_2 (the V_0 part of 1/2 x 1/2)
            out.append(tensor_product(blocks_of(part) + [((halves[0], halves[1]), {(0, 1): 1, (1, 0): -1})], L))
        # the V_1 part of 1/2 x 1/2 is a virtual spin-1 leg c realised as (sigma^c epsilon)_{alpha beta}: every pairs/triples partition of the
        # d + 1 legs {0..d-1, c} -- the block holding c becomes sigma^a (a pair (a, c)) or epsilon_{abc} sigma^c (a triple (a, b, c)); the first
        # draft had the pairs only and the dimension check caught it at d = 2 (Rio(2) + Rio(3) = 2, one found)
        C = d   # the virtual leg's label in the partition
        for part in set_partitions_pairs_triples(one + [C]):
            bl = []
            for b in part:
                if C not in b:
                    bl.extend(blocks_of([b]))
                elif len(b) == 2:
                    s = b[0] if b[1] == C else b[1]
                    blk = {}
                    for a in range(3):
                        for (al, be), v in sigeps(a).items():
                            blk[(a, al, be)] = v
                    bl.append(((s, halves[0], halves[1]), blk))
                else:
                    s, t = [x for x in b if x != C]
                    blk = {}
                    for (a, bb, c), e in EPS3.items():
                        for (al, be), v in sigeps(c).items():
                            blk[(a, bb, al, be)] = blk.get((a, bb, al, be), 0) + e * v
                    bl.append(((s, t, halves[0], halves[1]), blk))
            out.append(tensor_product(bl, L))
    return out


def dot(x, y):
    return sum(x[k].conjugate() * y[k] for k in x if k in y)


def orthonormal(vecs):
    basis = []
    for v in vecs:
        w = {k: complex(val) for k, val in v.items()}
        for b in basis:
            c = dot(b, w)
            if c != 0:
                for k, bv in b.items():
                    w[k] = w.get(k, 0) - c * bv
        nrm = math.sqrt(abs(dot(w, w)))
        if nrm > 1e-9:
            basis.append({k: val / nrm for k, val in w.items() if abs(val) > 1e-13})
    return basis


BASIS = {}


def basis(d, h):
    if (d, h) not in BASIS:
        B = orthonormal(diagrams(d, h))
        expect = RIO[d] if h == 0 else RIO[d] + RIO[d + 1]
        assert len(B) == expect, ("basis dimension", d, h, len(B), expect)
        BASIS[(d, h)] = B
    return BASIS[(d, h)]


NORM = {}


def realigned_norm(d, h, S):
    """Schur bound on ||M||_op for the split: legs in S toward the cluster, the rest toward the uncontracted nodes"""
    key = (d, h, frozenset(S))
    if key in NORM:
        return NORM[key]
    L = d + h
    Sl = sorted(S)
    Nl = [l for l in range(L) if l not in S]
    rows = {}
    cols = {}   # rows[s] = sum_tau r_tau(s)^2 ; cols[n] = sum_tau c_tau(n)^2
    pertau = 0.0   # the second bound: ||M||_op <= sum_tau ||tau_mat||_op^2, each ||tau_mat||_op bounded by the Schur test on tau_mat and by
    #                Gershgorin on tau_mat^H tau_mat and tau_mat tau_mat^H (every one a valid upper bound; the least is kept)
    for tau in basis(d, h):
        r = {}
        c = {}
        ent = {}
        for idx, v in tau.items():
            s = tuple(idx[l] for l in Sl)
            n = tuple(idx[l] for l in Nl)
            r[s] = r.get(s, 0) + abs(v)
            c[n] = c.get(n, 0) + abs(v)
            ent[(s, n)] = ent.get((s, n), 0) + v
        for s, val in r.items():
            rows[s] = rows.get(s, 0) + val * val
        for n, val in c.items():
            cols[n] = cols.get(n, 0) + val * val
        schur = math.sqrt(max(r.values()) * max(c.values()))
        # Gershgorin on G = tau^H tau (indexed by n): row sums of |G|
        byn = {}
        bys = {}
        for (s, n), v in ent.items():
            byn.setdefault(n, {})[s] = v
            bys.setdefault(s, {})[n] = v
        g1 = 0.0
        for n, col in byn.items():
            tot = 0.0
            for n2, col2 in byn.items():
                tot += abs(sum(col[s].conjugate() * col2[s] for s in col if s in col2))
            g1 = max(g1, tot)
        g2 = 0.0
        for s, row in bys.items():
            tot = 0.0
            for s2, row2 in bys.items():
                tot += abs(sum(row[n] * row2[n].conjugate() for n in row if n in row2))
            g2 = max(g2, tot)
        pertau += min(schur, math.sqrt(g1), math.sqrt(g2)) ** 2
    # the third bound, Cauchy-Schwarz for a sum of tensor products: ||sum_tau A_tau x B_tau|| <= ||sum A_tau A_tau^H||^{1/2} ||sum B_tau^H B_tau||^{1/2}
    # with A_tau = tau_mat (S x N) and B_tau = conj(tau_mat): the two factors are the PARTIAL TRACES of the projector over the N legs and
    # over the S legs (PSD, traces R), their operator norms bounded by Gershgorin (max absolute row sum) -- at a flat partial trace this
    # reaches R / sqrt(dim_S dim_N) against the sieve's sqrt R
    trN = {}   # (s, s') -> sum_tau sum_n tau[s,n] conj(tau[s',n])
    trS = {}   # (n, n') -> sum_tau sum_s conj(tau[s,n]) tau[s,n']
    for tau in basis(d, h):
        bys = {}
        byn = {}
        for idx, v in tau.items():
            s = tuple(idx[l] for l in Sl)
            n = tuple(idx[l] for l in Nl)
            bys.setdefault(s, {})[n] = v
            byn.setdefault(n, {})[s] = v
        for s, row in bys.items():
            for s2, row2 in bys.items():
                v = sum(row[n] * row2[n].conjugate() for n in row if n in row2)
                if v != 0:
                    trN[(s, s2)] = trN.get((s, s2), 0) + v
        for n, col in byn.items():
            for n2, col2 in byn.items():
                v = sum(col[s].conjugate() * col2[s] for s in col if s in col2)
                if v != 0:
                    trS[(n, n2)] = trS.get((n, n2), 0) + v
    gN = {}
    for (s, s2), v in trN.items():
        gN[s] = gN.get(s, 0) + abs(v)
    gS = {}
    for (n, n2), v in trS.items():
        gS[n] = gS.get(n, 0) + abs(v)
    cs = math.sqrt(max(gN.values()) * max(gS.values()))
    NORM[key] = min(math.sqrt(max(rows.values()) * max(cols.values())), pertau, cs)
    return NORM[key]


def frob(d, h):
    return math.sqrt(RIO[d] if h == 0 else RIO[d] + RIO[d + 1])


def star_bound(edges):
    """edges: list of (u, v, spin2) with spin2 in {1, 2}; returns (best bound on |S|, Frobenius bound, order) or None"""
    nodes = sorted({u for u, v, s in edges} | {v for u, v, s in edges})
    legs = {x: [] for x in nodes}    # per node: list of (edge index, spin2)
    for e, (u, v, s) in enumerate(edges):
        if u == v:
            return None        # a loop: the partial-trace case, not bounded here
        legs[u].append((e, s))
        legs[v].append((e, s))
    typ = {}
    pos = {}
    for x in nodes:
        ones = [e for e, s in legs[x] if s == 2]
        halves = [e for e, s in legs[x] if s == 1]
        if len(halves) not in (0, 2):
            return None
        typ[x] = (len(ones), len(halves))
        pos[x] = {e: i for i, e in enumerate(ones + halves)}
    fb = 1.0
    for x in nodes:
        fb *= frob(*typ[x])
    best = None
    bestorder = None
    n = len(nodes)
    for order in itertools.permutations(nodes):
        val = frob(*typ[order[0]]) * frob(*typ[order[-1]])
        done = {order[0]}
        for t in range(1, n - 1):
            x = order[t]
            S = [pos[x][e] for e, s in legs[x] if (edges[e][0] in done or edges[e][1] in done)]
            val *= realigned_norm(typ[x][0], typ[x][1], S)
            done.add(x)
            if best is not None and val >= best:
                break
        if best is None or val < best:
            best = val
            bestorder = order
    return best, fb, bestorder


def parse(line):
    edges = []
    k = m = 0
    idn = ""
    r2 = None
    for tok in line.split():
        if tok.startswith("k="):
            k = int(tok[2:])
        elif tok.startswith("m="):
            m = int(tok[2:])
        elif tok.startswith("id="):
            idn = tok[3:]
        elif tok.startswith("r2=") and "/" in tok:
            a, b = tok[3:].split("/")
            r2 = int(a) / int(b)
        elif "-" in tok and ":" in tok and tok[0].isdigit():
            uv, s = tok.split(":")
            u, v = uv.split("-")
            edges.append((int(u), int(v), int(s)))
    return idn, k, m, edges, r2


if __name__ == "__main__":
    if sys.argv[1:] == ["KAT"] or not sys.argv[1:]:
        kats = [
            ("K4 spin 1 (exact 1/36)", [(0, 1, 2), (0, 2, 2), (0, 3, 2), (1, 2, 2), (1, 3, 2), (2, 3, 2)], 1 / 36),
            ("C3 spin 1 (exact 1/3)", [(0, 1, 2), (1, 2, 2), (2, 0, 2)], 1 / 3),
            ("C4 spin 1 (exact 1/9)", [(0, 1, 2), (1, 2, 2), (2, 3, 2), (3, 0, 2)], 1 / 9),
            ("the chord: C2(1/2) + one spin-1 edge (exact 1)", [(0, 1, 1), (0, 1, 1), (0, 1, 2)], 1.0),
            ("W3: C3(1/2) + three spokes (exact 1/9)", [(0, 1, 1), (1, 2, 1), (2, 0, 1), (0, 3, 2), (1, 3, 2), (2, 3, 2)], 1 / 9),
            ("K4 of walls: C4(1/2) + K4(1) (exact 3271/14400 = 0.22715)", [(0, 1, 1), (1, 2, 1), (2, 3, 1), (3, 0, 1), (0, 1, 2), (0, 2, 2), (0, 3, 2), (1, 2, 2), (1, 3, 2), (2, 3, 2)], 3271 / 14400),
            ("K222 spin 1 (exact 16981/202500 = 0.08386)", [(u, v, 2) for u in range(6) for v in range(u + 1, 6) if v != u + 3], 16981 / 202500),
        ]
        for name, edges, exact in kats:
            b, fb, order = star_bound(edges)
            print("KAT %-62s bound %.6f  frobenius %.6f  exact %.6f  bound/exact %.2f  frob/bound %.1f" % (name, b, fb, exact, b / exact, fb / b))
        for (d, h) in [(2, 0), (3, 0), (4, 0), (5, 0), (6, 0), (0, 2), (1, 2), (2, 2), (3, 2), (4, 2), (5, 2)]:
            print("basis d=%d h=%d: dim %d (Riordan %d)" % (d, h, len(basis(d, h)), RIO[d] if h == 0 else RIO[d] + RIO[d + 1]))
    elif sys.argv[1] == "ROWS":
        mx = int(sys.argv[3]) if len(sys.argv) > 3 else 10 ** 9
        n = 0
        THETA = 1.113533
        for line in open(sys.argv[2], encoding="utf-8", errors="replace"):
            if not (line.startswith("WCONF") or line.startswith("CONF") or line.startswith("STAR-EXACT-FILE")):
                continue
            idn, k, m, edges, r2 = parse(line)
            if not edges or m <= 1:
                continue
            res = star_bound(edges)
            if res is None:
                continue
            b, fb, order = res
            r2b = 2 ** (m - 2) * b
            r2f = 2 ** (m - 2) * fb
            thr = THETA ** (2 * k)
            extra = ("  exact r2=%.6g ratio %.1f" % (r2, r2b / r2)) if r2 else ""
            print("ROW id=%s k=%d m=%d r2<= %.6g (realigned)  %.6g (frobenius)  threshold %.6g  %s%s" % (idn, k, m, r2b, r2f, thr, "RETIRED-R" if r2b <= thr else "open", extra))
            n += 1
            if n >= mx:
                break
