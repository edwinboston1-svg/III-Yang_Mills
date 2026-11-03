#!/usr/bin/env python3
# geom.py -- M87: the perfect-cover decimation's position structure, per kept link, with block assignments (2026-11-02).
# Two covers: (G) g27's cover, re-derived by the same backtracking in the same candidate order as g27_blocksplit.pl (ported line by line);
# (P) THE GROUND's explicit period-2 cover (section 8.3, line 30): with coordinates x1..x4 mod 2, the link from x in direction 1 when
# x2 = x3 = x4, direction 2 when x4 = x1 != x3, direction 3 when x2 = x1 != x4, direction 4 when x3 = x1 != x2.
# Positions are counted on Z^4 (no wrap): TYPE I = the two other kept links of each of the 6 plaquettes of x; TYPE II = the 3 kept links of
# each of the 5 other plaquettes of the cover link a_p of each plaquette p of x. Block assignments: PLAIN (a link is in the block of its base
# point iff its base coordinate in its own direction is even, i.e. both ends in one side-2 block; inter-block links are singletons) and
# BASE (every link in the block of its base point).
# Output: g27-format lines (to compare with the records), checks, and a JSON file with the block-0 matrices for rows.py.
import sys, json, itertools
from collections import defaultdict

PAIRS = [(0, 1), (0, 2), (0, 3), (1, 2), (1, 3), (2, 3)]

def cellidx(x):
    s = 0
    for d in range(4): s = s * 2 + (x[d] % 2)
    return s

def bits(s): return tuple((s >> (3 - d)) & 1 for d in range(4))

# ---------- cover (G): port of g27's backtracking (period-2 torus, plaquette ids sidx*6+k) ----------
def cover_g27():
    def pid(x, a, b):
        k = PAIRS.index((a, b)); return cellidx(x) * 6 + k
    cand = []
    for s in range(16):
        x = bits(s)
        for d in range(4):
            t = set()
            for e in range(4):
                if e == d: continue
                a, b = sorted((d, e))
                y = list(x); y[e] -= 1
                t.add(pid(x, a, b)); t.add(pid(tuple(y), a, b))
            cand.append((sorted(t), s, d))
    cov = [0] * 96; sol = []
    def rec():
        bc = next((i for i in range(96) if not cov[i]), None)
        if bc is None: return True
        for c in cand:
            if bc not in c[0]: continue
            if any(cov[i] for i in c[0]): continue
            for i in c[0]: cov[i] = 1
            sol.append(c)
            if rec(): return True
            sol.pop()
            for i in c[0]: cov[i] = 0
        return False
    if not rec(): raise SystemExit("no period-2 cover")
    D = {}
    for c in sol: D[c[1]] = c[2]
    return D

# ---------- cover (P): the paper's rule ----------
def cover_paper():
    D = {}
    for s in range(16):
        x = bits(s)  # x[0..3] = x1..x4
        x1, x2, x3, x4 = x
        ds = []
        if x2 == x3 == x4: ds.append(0)
        if x4 == x1 and x1 != x3: ds.append(1)
        if x2 == x1 and x1 != x4: ds.append(2)
        if x3 == x1 and x1 != x2: ds.append(3)
        if len(ds) != 1: raise SystemExit("paper rule does not partition residues at %s: %s" % (x, ds))
        D[s] = ds[0]
    return D

def make(D):
    def inS(x, d): return D[cellidx(x)] == d
    return inS

def plaq_links(x, a, b):
    xa = list(x); xa[a] += 1; xb = list(x); xb[b] += 1
    return [(tuple(x), a), (tuple(xa), b), (tuple(xb), a), (tuple(x), b)]

def plaqs_of(x, d):
    P = []
    for e in range(4):
        if e == d: continue
        a, b = sorted((d, e))
        P.append((tuple(x), a, b))
        y = list(x); y[e] -= 1
        P.append((tuple(y), a, b))
    return P

def blockof(x): return tuple(v // 2 for v in x)
def intra(l): x, d = l; return x[d] % 2 == 0

def check_cover(inS, R=3):
    # every plaquette of the box [-R, R]^4 holds exactly one cover link; one cover link per site
    bad = 0
    for x in itertools.product(range(-R, R + 1), repeat=4):
        if sum(1 for d in range(4) if inS(x, d)) != 1: bad += 1
        for (a, b) in PAIRS:
            if sum(1 for l in plaq_links(x, a, b) if inS(*l)) != 1: bad += 1
    return bad

def positions(inS, y):
    # list of (type, link) positions of kept link y; TYPE I: (1, l), TYPE II: (2, l)
    x, d = y
    out = []
    for p in plaqs_of(x, d):
        ls = plaq_links(*p)
        S = [l for l in ls if inS(*l)]
        assert len(S) == 1, "plaquette with %d cover links" % len(S)
        a = S[0]
        for l in ls:
            if l == y or inS(*l): continue
            out.append((1, l))
        for q in plaqs_of(*a):
            if q == p: continue
            for l in plaq_links(*q):
                if inS(*l): continue
                out.append((2, l))
    return out

def run(name, D, records):
    inS = make(D)
    res = {"name": name}
    print("M87-COVER %s: residues -> direction %s; box check (|x| <= 3) defects = %d" % (name, [D[s] for s in range(16)], check_cover(inS)))
    kept = [(bits(s), d) for s in range(16) for d in range(4) if not inS(bits(s), d)]
    assert len(kept) == 48
    # per-link counts, both assignments, g27 line format
    for assign in ("plain", "base"):
        lines = []
        cls = {}
        for y in kept:
            pos = positions(inS, y)
            n1 = sum(1 for t, l in pos if t == 1); n2 = sum(1 for t, l in pos if t == 2)
            if assign == "base":
                inb = lambda l: blockof(l[0]) == blockof(y[0])
            else:
                inb = lambda l: intra(y) and intra(l) and blockof(l[0]) == blockof(y[0])
            n1in = sum(1 for t, l in pos if t == 1 and inb(l)); n2in = sum(1 for t, l in pos if t == 2 and inb(l))
            # coplanar count as in g27: TYPE II positions whose plaquette q is coplanar with p
            cop = 0
            x, d = y
            for p in plaqs_of(x, d):
                ls = plaq_links(*p); a = [l for l in ls if inS(*l)][0]
                for q in plaqs_of(*a):
                    if q == p: continue
                    if (q[1], q[2]) == (p[1], p[2]):
                        cop += sum(1 for l in plaq_links(*q) if not inS(*l))
            tag = "intra" if intra(y) else "inter"
            key = ",".join(map(str, y[0])) + ":%d" % y[1]
            lines.append("G27-LINK y=%s (%s) TYPE I %d (in-block %d), TYPE II %d (in-block %d; coplanar %d, other-plane %d)" % (key, tag, n1, n1in, n2, n2in, cop, n2 - cop))
            cls[key] = {"tag": tag, "n1": n1, "n2": n2, "n1in": n1in, "n2in": n2in}
        res[assign] = cls
        if records.get(assign):
            want = [l.rstrip("\r\n") for l in open(records[assign], encoding="utf-8") if l.startswith("G27-LINK")]
            same = sum(1 for a, b in zip(lines, want) if a == b)
            print("M87-REPRO %s/%s: %d of %d G27-LINK lines identical to %s  [%s]" % (name, assign, same, len(want), records[assign].split("/")[-1], "MET" if same == len(want) == len(lines) else "MISSED"))
        res[assign + "_lines"] = lines
    # symmetry, multiplicity, distinct neighbours (on Z^4)
    NI = defaultdict(int); NII = defaultdict(int)
    for y in kept:
        for t, l in positions(inS, y):
            (NI if t == 1 else NII)[(y, l)] += 1
    asym = 0
    for y in kept:
        for t, l in positions(inS, y):
            # symmetric partner: translate l to its class representative and y by the same vector
            sh = tuple((v % 2) - v for v in l[0])
            l0 = (tuple(v + s for v, s in zip(l[0], sh)), l[1])
            y0 = (tuple(v + s for v, s in zip(y[0], sh)), y[1])
            M = NI if t == 1 else NII
            if M.get((l0, y0), 0) != M[(y, l)]: asym += 1
    maxNI = max(NI.values()); maxNII = max(NII.values())
    distinct = []
    for y in kept:
        nb = defaultdict(lambda: [0, 0])
        for t, l in positions(inS, y): nb[l][t - 1] += 1
        multi = sum(1 for v in nb.values() if sum(v) > 1)
        both = sum(1 for v in nb.values() if v[0] > 0 and v[1] > 0)
        distinct.append((len(nb), multi, both, max(sum(v) for v in nb.values())))
    print("M87-SYM %s: asymmetric position entries = %d; max N_I = %d; max N_II = %d" % (name, asym, maxNI, maxNII))
    dd = sorted(set(distinct))
    print("M87-DISTINCT %s: (distinct kept neighbours, links in >1 position, links in both a TYPE I and a TYPE II position, max positions of one link) over the 48 classes: %s" % (name, dd))
    # block-0 matrices for the two assignments
    for assign in ("plain", "base"):
        if assign == "base":
            B = [((tuple(v + 0 for v in bits(s))), d) for s in range(16) for d in range(4) if not inS(bits(s), d)]
        else:
            B = [(bits(s), d) for s in range(16) for d in range(4) if not inS(bits(s), d) and intra((bits(s), d))]
        idx = {l: i for i, l in enumerate(B)}
        n = len(B)
        mI = [[0] * n for _ in range(n)]; mII = [[0] * n for _ in range(n)]
        for y in B:
            for t, l in positions(inS, y):
                if l in idx:
                    (mI if t == 1 else mII)[idx[y]][idx[l]] += 1
        rowI = [sum(r) for r in mI]; rowII = [sum(r) for r in mII]
        res[assign + "_block"] = {"links": [",".join(map(str, l[0])) + ":%d" % l[1] for l in B], "NI": mI, "NII": mII}
        print("M87-BLOCK %s/%s: block 0 holds %d kept links; in-block (TYPE I, TYPE II) row counts %s" % (name, assign, n, sorted(set(zip(rowI, rowII)))))
        # consistency with the per-link counts
        ok = all(rowI[i] == res[assign][res[assign + "_block"]["links"][i]]["n1in"] and rowII[i] == res[assign][res[assign + "_block"]["links"][i]]["n2in"] for i in range(n))
        print("M87-BLOCK %s/%s: block-0 matrix rows equal the per-link in-block counts: %s" % (name, assign, "yes" if ok else "NO"))
    return res

if __name__ == "__main__":
    rec = sys.argv[1] if len(sys.argv) > 1 else None
    records = {}
    if rec:
        records = {"plain": rec + "/g_g27.txt", "base": rec + "/g27_blocksplit_base.2026-10-29a.txt"}
    out = {}
    out["G"] = run("G(g27 backtracking)", cover_g27(), records)
    out["P"] = run("P(paper line 30)", cover_paper(), {})
    json.dump(out, open(sys.argv[2] if len(sys.argv) > 2 else "geom.json", "w"))
    print("M87-GEOM written")
