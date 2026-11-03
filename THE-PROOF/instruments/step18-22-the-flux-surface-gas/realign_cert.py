# realign_cert.py -- THE REALIGNED OPERATOR-NORM BOUND ON A VERTEX STAR, CERTIFIED (the author, 2026-10-31 23:1x EDT; the measurement
# prototype is realign_bound.py beside it, 10-30 07:1x).  THE LEMMA (S1 section 25).  S(G) is the contraction of one Haar projector P_l per
# link l of the star along the edges of G, each edge two strands (the a- and b-indices of the character).  Contract the nodes in any order
# 1..n: with C_1 = P_1 and C_t = C_{t-1} M_t, where M_t is P_t REALIGNED as a matrix from its strands toward the cluster {1..t-1} to its
# strands toward the uncontracted nodes, ||C_t||_F <= ||C_{t-1}||_F ||M_t||_op (||AB||_F <= ||A||_F ||B||_op), and the last node closes by
# Cauchy-Schwarz: |S| <= ||P_1||_F prod_{t=2}^{n-1} ||M_t||_op ||P_n||_F, with ||P||_F = sqrt(R), R = dim Inv (the Frobenius sieve is the
# case ||M_t||_op <= ||M_t||_F = sqrt R at every node).  For P = sum_{a,b} Ginv_ab |tau_a><tau_b| (tau an integer basis of the invariants,
# G its Gram matrix), M_t = sum_ab Ginv_ab T_a (x) T_b with T_a the unfolding of tau_a along the split, and the block Cauchy-Schwarz
# ||sum_a A_a (x) B_a||_op^2 <= ||sum A_a A_a^T||_op ||sum B_a^T B_a||_op gives ||M_t||_op^2 <= lam_max(Tr_N P) lam_max(Tr_S P): the two
# PARTIAL TRACES of the projector over the two sides of the split, real symmetric positive semidefinite rational matrices of trace R.
# Every number here is EXACT: the invariants are integer vectors in the real basis (e_x, i e_y, e_z) of each spin-1 leg (the metric becomes
# diag(1, -1, 1), epsilon and the (1; 1/2, 1/2) coupling real after a scalar on each block; the projector's norms do not see a unitary change
# of basis), Ginv is the exact inverse of an integer Gram matrix, the partial traces are exact rationals, and lam_max(A) <= mu is CERTIFIED by
# the exact LDL^T decomposition of mu I - A (every pivot positive: Sylvester) at a mu one part in 2^20 above a floating estimate, or by the
# exact Gershgorin row sum where the matrix is large.  The bound is carried SQUARED, bound2 = 4^(m-2) R_1 R_n prod_t mu_A,t mu_B,t >= r2^2,
# a rational the table takes as it takes the sieve's integer B (the ceiling of its square root at 1e-18).  The contraction ORDER is taken
# from the float prototype (any order gives a valid bound; the prototype picks a good one).  CONTROLS: Tr(Tr_N P) = Tr(Tr_S P) = R exactly at
# every key (a bent Gram inverse is refused by name: NEGCTL mode plants one); P^2 = P exactly on the small types in KAT mode; the known
# answers of the prototype (exact S known) must satisfy exact^2 <= bound2S <= Frobenius^2; and law 6 outside this file: the DISCORD census
# of local_tail_table.awk over every read row that also carries a REALIGN line.
# usage: python -I realign_cert.py KAT | NEGCTL | ROWS <file of WCONF/STAR-EXACT-FILE lines> [max rows]
import sys, os, math, itertools
from fractions import Fraction as Fr
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import realign_bound as proto   # the float prototype: the contraction order only

RIO = [1, 0, 1, 1, 3, 6, 15, 36, 91, 232, 603]
EPS3 = {(0, 1, 2): 1, (1, 2, 0): 1, (2, 0, 1): 1, (0, 2, 1): -1, (2, 1, 0): -1, (1, 0, 2): -1}
MET = {0: 1, 1: -1, 2: 1}                       # the spin-1 metric in the real basis (e_x, i e_y, e_z)
SIGEPS = {0: {(0, 0): -1, (1, 1): 1}, 1: {(0, 0): 1, (1, 1): 1}, 2: {(0, 1): 1, (1, 0): 1}}   # (sigma^a epsilon) in that basis, real
EPS2 = {(0, 1): 1, (1, 0): -1}
NEGCTL = False


def tensor_product(blocks, L):
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
    return {k: v for k, v in res.items() if v != 0}


def blocks_of(part):
    bl = []
    for b in part:
        if len(b) == 2:
            bl.append((b, {(a, a): MET[a] for a in range(3)}))
        else:
            bl.append((b, dict(EPS3)))
    return bl


def diagrams(d, h):
    """an integer spanning set of Inv(V_1^{x d} (x) V_{1/2}^{x h}) in the real basis; legs 0..d-1 spin 1, d..d+h-1 spin 1/2; h in {0, 2}"""
    L = d + h
    one = list(range(d))
    halves = list(range(d, d + h))
    out = []
    if h == 0:
        for part in proto.set_partitions_pairs_triples(one):
            out.append(tensor_product(blocks_of(part), L))
        return out
    for part in proto.set_partitions_pairs_triples(one):          # the two halves paired by epsilon_2
        out.append(tensor_product(blocks_of(part) + [((halves[0], halves[1]), dict(EPS2))], L))
    C = d                                                          # the virtual spin-1 leg of the halves' V_1 part
    for part in proto.set_partitions_pairs_triples(one + [C]):
        bl = []
        for b in part:
            if C not in b:
                bl.extend(blocks_of([b]))
            elif len(b) == 2:
                s = b[0] if b[1] == C else b[1]
                blk = {}
                for a in range(3):
                    for (al, be), v in SIGEPS[a].items():
                        blk[(a, al, be)] = v
                bl.append(((s, halves[0], halves[1]), blk))
            else:
                s, t = [x for x in b if x != C]
                blk = {}
                for (a, bb, c), e in EPS3.items():
                    for (al, be), v in SIGEPS[c].items():
                        blk[(a, bb, al, be)] = blk.get((a, bb, al, be), 0) + e * MET[c] * v
                bl.append(((s, t, halves[0], halves[1]), blk))
        out.append(tensor_product(bl, L))
    return out


def dot(x, y):
    return sum(x[k] * y[k] for k in x if k in y)


def inverse(G):
    """exact inverse of a square rational matrix (Gauss-Jordan); None if singular"""
    n = len(G)
    A = [[Fr(G[i][j]) for j in range(n)] + [Fr(1 if i == j else 0) for j in range(n)] for i in range(n)]
    for c in range(n):
        p = next((r for r in range(c, n) if A[r][c] != 0), None)
        if p is None:
            return None
        A[c], A[p] = A[p], A[c]
        pv = A[c][c]
        A[c] = [v / pv for v in A[c]]
        for r in range(n):
            if r != c and A[r][c] != 0:
                f = A[r][c]
                A[r] = [a - f * b for a, b in zip(A[r], A[c])]
    return [row[n:] for row in A]


BASIS = {}


def basis(d, h):
    """(tau list, Ginv) : a maximal independent subset of the diagrams and the exact inverse of its Gram matrix"""
    if (d, h) in BASIS:
        return BASIS[(d, h)]
    cand = diagrams(d, h)
    expect = RIO[d] if h == 0 else RIO[d] + RIO[d + 1]
    chosen = []
    for v in cand:
        trial = chosen + [v]
        G = [[dot(x, y) for y in trial] for x in trial]
        if inverse(G) is not None:
            chosen = trial
            if len(chosen) == expect:
                break
    assert len(chosen) == expect, ("basis dimension", d, h, len(chosen), expect)
    G = [[dot(x, y) for y in chosen] for x in chosen]
    Ginv = inverse(G)
    if NEGCTL and (d, h) == (2, 0):
        Ginv[0][0] = Ginv[0][0] * 2            # the planted defect: a wrong Gram inverse
    BASIS[(d, h)] = (chosen, Ginv)
    return BASIS[(d, h)]


def projector(d, h):
    taus, Ginv = basis(d, h)
    R = len(taus)
    keys = sorted({k for t in taus for k in t})
    P = {}
    for a in range(R):
        for b in range(R):
            g = Ginv[a][b]
            if g == 0:
                continue
            for ka, va in taus[a].items():
                for kb, vb in taus[b].items():
                    P[(ka, kb)] = P.get((ka, kb), 0) + g * va * vb
    return P, R, keys


def gershgorin(A, idx):
    return max(sum(abs(A.get((i, j), 0)) for j in idx) for i in idx) if idx else Fr(0)


def power_lambda(A, idx):
    """a floating estimate of the largest eigenvalue of the symmetric PSD matrix A on the support idx"""
    n = len(idx)
    pos = {s: i for i, s in enumerate(idx)}
    rowsf = [[] for _ in range(n)]
    for (i, j), v in A.items():
        rowsf[pos[i]].append((pos[j], float(v)))
    x = [1.0 / math.sqrt(n)] * n
    lam = 0.0
    for it in range(400):
        y = [sum(v * x[j] for j, v in rowsf[i]) for i in range(n)]
        nrm = math.sqrt(sum(t * t for t in y))
        if nrm == 0:
            return 0.0
        lam_new = sum(x[i] * y[i] for i in range(n))
        x = [t / nrm for t in y]
        if it > 20 and abs(lam_new - lam) <= 1e-12 * max(1.0, abs(lam_new)):
            lam = lam_new
            break
        lam = lam_new
    return lam


def ldl_posdef(A, idx, mu):
    """exact: is mu I - A positive definite on the support idx (Sylvester: every LDL^T pivot positive)?"""
    n = len(idx)
    pos = {s: i for i, s in enumerate(idx)}
    M = [[Fr(0)] * n for _ in range(n)]
    for i in range(n):
        M[i][i] = Fr(mu)
    for (i, j), v in A.items():
        M[pos[i]][pos[j]] -= v
    L = [[Fr(0)] * n for _ in range(n)]
    D = [Fr(0)] * n
    for j in range(n):
        s = M[j][j] - sum(L[j][k] * L[j][k] * D[k] for k in range(j) if L[j][k] != 0)
        if s <= 0:
            return False
        D[j] = s
        for i in range(j + 1, n):
            t = M[i][j] - sum(L[i][k] * L[j][k] * D[k] for k in range(j) if L[i][k] != 0 and L[j][k] != 0)
            L[i][j] = t / s
    return True


LDL_MAX = 200


def lam_max_cert(A, idx):
    """a certified rational upper bound on lam_max(A), and how it was certified"""
    g = gershgorin(A, idx)
    if len(idx) > LDL_MAX:
        return g, "gershgorin"
    est = power_lambda(A, idx)
    slack = Fr(1, 2 ** 20)
    for attempt in range(12):
        mu = Fr(est).limit_denominator(2 ** 40) * (1 + slack) + Fr(1, 2 ** 60)
        if mu >= g:
            return g, "gershgorin"
        if ldl_posdef(A, idx, mu):
            return mu, "ldl"
        slack = slack * 4
    return g, "gershgorin"


NORM2 = {}


def realigned_norm2(d, h, dS, hS):
    """a certified rational upper bound on ||M||_op^2 for the split (dS spin-1 and hS spin-1/2 legs toward the cluster), with its certificate"""
    key = (d, h, dS, hS)
    if key in NORM2:
        return NORM2[key]
    taus, Ginv = basis(d, h)
    R = len(taus)
    L = d + h
    Sl = list(range(dS)) + list(range(d, d + hS))          # any split with these counts: the projector commutes with leg permutations
    Nl = [l for l in range(L) if l not in Sl]
    U = []
    for t in taus:
        bys = {}
        for idx, v in t.items():
            s = tuple(idx[l] for l in Sl)
            n = tuple(idx[l] for l in Nl)
            bys.setdefault(s, {})[n] = v
        U.append(bys)
    A = {}
    B = {}
    for a in range(R):
        for b in range(R):
            g = Ginv[a][b]
            if g == 0:
                continue
            Ua = U[a]
            Ub = U[b]
            for s, rowa in Ua.items():
                for s2, rowb in Ub.items():
                    v = sum(rowa[n] * rowb[n] for n in rowa if n in rowb)
                    if v != 0:
                        A[(s, s2)] = A.get((s, s2), 0) + g * v
            byn_a = {}
            for s, rowa in Ua.items():
                for n, v in rowa.items():
                    byn_a.setdefault(n, {})[s] = v
            byn_b = {}
            for s, rowb in Ub.items():
                for n, v in rowb.items():
                    byn_b.setdefault(n, {})[s] = v
            for n, cola in byn_a.items():
                for n2, colb in byn_b.items():
                    v = sum(cola[s] * colb[s] for s in cola if s in colb)
                    if v != 0:
                        B[(n, n2)] = B.get((n, n2), 0) + g * v
    A = {k: v for k, v in A.items() if v != 0}
    B = {k: v for k, v in B.items() if v != 0}
    idxA = sorted({i for i, j in A} | {j for i, j in A})
    idxB = sorted({i for i, j in B} | {j for i, j in B})
    trA = sum(A.get((i, i), 0) for i in idxA)
    trB = sum(B.get((i, i), 0) for i in idxB)
    if trA != R or trB != R:
        print("REALIGN REFUSED: the partial traces of the projector at type d=%d h=%d split (%d,%d) have traces %s and %s, not R = %d -- the Gram inverse is not the inverse" % (d, h, dS, hS, trA, trB, R))
        sys.exit(3)
    for (i, j), v in A.items():
        if A.get((j, i), 0) != v:
            print("REALIGN REFUSED: Tr_N P is not symmetric at type d=%d h=%d split (%d,%d)" % (d, h, dS, hS))
            sys.exit(3)
    muA, howA = lam_max_cert(A, idxA)
    muB, howB = lam_max_cert(B, idxB)
    if muA > R:
        muA = Fr(R)                                # a PSD matrix's largest eigenvalue is at most its trace
    if muB > R:
        muB = Fr(R)
    NORM2[key] = (muA * muB, muA, howA, len(idxA), muB, howB, len(idxB))
    return NORM2[key]


def frob2(d, h):
    return RIO[d] if h == 0 else RIO[d] + RIO[d + 1]


def star_cert(edges):
    """(bound2S, frob2S, order, per-node report) : S^2 <= bound2S certified; None for a shape outside the lemma (a loop, h not in {0,2})"""
    res = proto.star_bound(edges)
    if res is None:
        return None
    best, fb, order = res
    nodes = sorted({u for u, v, s in edges} | {v for u, v, s in edges})
    legs = {x: [] for x in nodes}
    for e, (u, v, s) in enumerate(edges):
        legs[u].append((e, s))
        legs[v].append((e, s))
    typ = {x: (len([e for e, s in legs[x] if s == 2]), len([e for e, s in legs[x] if s == 1])) for x in nodes}
    f2 = Fr(1)
    for x in nodes:
        f2 *= frob2(*typ[x])
    b2 = Fr(frob2(*typ[order[0]])) * frob2(*typ[order[-1]])
    rep = ["%s:F" % order[0]]
    done = {order[0]}
    for t in range(1, len(order) - 1):
        x = order[t]
        dS = len([1 for e, s in legs[x] if s == 2 and (edges[e][0] in done or edges[e][1] in done)])
        hS = len([1 for e, s in legs[x] if s == 1 and (edges[e][0] in done or edges[e][1] in done)])
        m2, muA, howA, nA, muB, howB, nB = realigned_norm2(typ[x][0], typ[x][1], dS, hS)
        b2 *= m2
        rep.append("%s:(%d,%d|%d,%d)%s%d/%s%d" % (x, typ[x][0], typ[x][1], dS, hS, howA[0], nA, howB[0], nB))
        done.add(x)
    rep.append("%s:F" % order[-1])
    return b2, f2, order, rep


def fmt(fr):
    return "%d/%d" % (fr.numerator, fr.denominator)


def main():
    global NEGCTL
    mode = sys.argv[1] if sys.argv[1:] else "KAT"
    if mode == "NEGCTL":
        NEGCTL = True
        star_cert([(0, 1, 2), (1, 2, 2), (2, 0, 2)])
        print("NEGCTL FAILED: the planted Gram defect was not refused")
        sys.exit(4)
    if mode == "KAT":
        for (d, h) in [(2, 0), (3, 0), (4, 0), (0, 2), (1, 2), (2, 2), (3, 2)]:
            P, R, keys = projector(d, h)
            tr = sum(P.get((k, k), 0) for k in keys)
            byrow = {}
            for (i, j), v in P.items():
                byrow.setdefault(i, {})[j] = v
            ok = True
            for i, row in byrow.items():
                for j in keys:
                    v = sum(row[k] * P.get((k, j), 0) for k in row)
                    if v != P.get((i, j), 0):
                        ok = False
                        break
                if not ok:
                    break
            print("PROJECTOR d=%d h=%d: dim Inv %d (Riordan %d) trace %s idempotent %s" % (d, h, R, RIO[d] if h == 0 else RIO[d] + RIO[d + 1], tr, "YES" if ok else "NO"))
            if not ok or tr != R:
                print("REALIGN REFUSED: the projector of type d=%d h=%d fails P^2 = P or Tr P = R" % (d, h))
                sys.exit(3)
        kats = [
            ("K4 spin 1 (exact 1/36)", [(0, 1, 2), (0, 2, 2), (0, 3, 2), (1, 2, 2), (1, 3, 2), (2, 3, 2)], Fr(1, 36)),
            ("C3 spin 1 (exact 1/3)", [(0, 1, 2), (1, 2, 2), (2, 0, 2)], Fr(1, 3)),
            ("C4 spin 1 (exact 1/9)", [(0, 1, 2), (1, 2, 2), (2, 3, 2), (3, 0, 2)], Fr(1, 9)),
            ("the chord: C2(1/2) + one spin-1 edge (exact 1)", [(0, 1, 1), (0, 1, 1), (0, 1, 2)], Fr(1)),
            ("W3: C3(1/2) + three spokes (exact 1/9)", [(0, 1, 1), (1, 2, 1), (2, 0, 1), (0, 3, 2), (1, 3, 2), (2, 3, 2)], Fr(1, 9)),
            ("K4 of walls: C4(1/2) + K4(1) (exact 3271/14400)", [(0, 1, 1), (1, 2, 1), (2, 3, 1), (3, 0, 1), (0, 1, 2), (0, 2, 2), (0, 3, 2), (1, 2, 2), (1, 3, 2), (2, 3, 2)], Fr(3271, 14400)),
            ("K222 spin 1 (exact 16981/202500)", [(u, v, 2) for u in range(6) for v in range(u + 1, 6) if v != u + 3], Fr(16981, 202500)),
        ]
        bad = 0
        for name, edges, exact in kats:
            b2, f2, order, rep = star_cert(edges)
            ok = exact * exact <= b2 <= f2
            if not ok:
                bad += 1
            print("KAT %-50s bound2S=%s (%.6g) frob2S=%s exact^2=%.6g  %s  bound/exact %.2f  order %s  %s" % (name, fmt(b2), float(b2), fmt(f2), float(exact * exact), "HELD" if ok else "FAILED", math.sqrt(float(b2)) / float(exact), "".join(str(x) for x in order), " ".join(rep)))
        if bad:
            print("REALIGN KAT FAILED: %d known answers outside exact^2 <= bound2S <= Frobenius^2" % bad)
            sys.exit(3)
        print("REALIGN KAT HELD: %d known answers inside exact^2 <= bound2S <= Frobenius^2; projectors idempotent with trace R on 7 types" % len(kats))
        return
    if mode == "ROWS":
        mx = int(sys.argv[3]) if len(sys.argv) > 3 else 10 ** 9
        n = 0
        disc = 0
        for line in open(sys.argv[2], encoding="utf-8", errors="replace"):
            if not (line.startswith("WCONF") or line.startswith("CONF") or line.startswith("STAR-EXACT-FILE")):
                continue
            idn, k, m, edges, r2 = proto.parse(line)
            r2x = None
            for tok in line.split():
                if tok.startswith("r2=") and "/" in tok:
                    a, b = tok[3:].split("/")
                    r2x = Fr(int(a), int(b))
            if not edges:
                continue
            # m = 0 (a star with no half-edge, off the sheet) is inside the lemma: r2 = S / 4, bound2 = 4^(m-2) bound2S with m - 2 = -2.
            # (The prototype skipped m <= 1 and the first census and slices inherited the skip, 23:1x-23:4x: 48 census rows and 215 rows
            # of the unread input, all k = 18..24 at m = 0, were left to the Frobenius sieve; re-run whole at 23:5x.)
            res = star_cert(edges)
            if res is None:
                print("REALIGN id=%s k=%d m=%d REFUSED-SHAPE (a loop or an odd half-degree: outside the lemma)" % (idn, k, m))
                continue
            b2, f2, order, rep = res
            bound2 = Fr(4) ** (m - 2) * b2
            frob2v = Fr(4) ** (m - 2) * f2
            extra = ""
            if r2x is not None:
                held = r2x * r2x <= bound2
                if not held:
                    disc += 1
                extra = " exact r2=%s exact2<=bound2 %s" % (fmt(r2x), "HELD" if held else "DISCORD")
            print("REALIGN id=%s k=%d m=%d bound2=%s r2<=%.6g (realigned) %.6g (frobenius) per-corner %.6f order=%s nodes %s%s" % (
                idn, k, m, fmt(bound2), math.sqrt(float(bound2)), math.sqrt(float(frob2v)), math.exp(math.log(float(bound2)) / (4 * k)), "".join(str(x) for x in order), " ".join(rep), extra))
            n += 1
            if n >= mx:
                break
        print("REALIGN ROWS END: %d rows bounded, %d DISCORD (an exact value above its own realigned bound)" % (n, disc))
        if disc:
            sys.exit(5)
        return
    print("usage: realign_cert.py KAT | NEGCTL | ROWS <file> [max]")
    sys.exit(2)


if __name__ == "__main__":
    main()
