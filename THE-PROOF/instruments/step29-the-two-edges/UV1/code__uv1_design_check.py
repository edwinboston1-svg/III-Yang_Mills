"""UV1: MECHANICAL CHECK OF THEOREM U'S DESIGN (the combinatorial step of WORK.md 3.3).

Simulates the stated integration order on an open box (spatial n^3, times 0..T-1, axial gauge along time) for the model with the
mu-nu plaquettes removed, consuming each plaquette at the first group that contains one of its links, and asserts:
 (I0) no plaquette other than a group's designated internal plaquette contains two links of the group being integrated;
 (I1) every interior single pair (U(x,2m), U(x,2m+1)) carries fields k = 2 (lower) and k' = 1 (upper);
 (I2) every interior P*_mu-sigma group carries k = (1,1,1,1);
 (I3) every interior P*_nu-sigma group carries k = (2,2,2,1) as a multiset if x_mu is even and (2,1,1,1) if x_mu is odd, each extra on a
      distinct link;
 (I4) every plaquette is consumed exactly once; every link integrated exactly once.
Interior = spatial coordinates in [3, n-4], slabs not the top or bottom one. Prints counts; exit status 1 on any violation.
Run: python -u -E -P code/uv1_design_check.py > rec/design.<date>.txt
"""
import sys
from collections import defaultdict, Counter

n, T = 12, 10                     # spatial box n^3, times 0..T-1 (slabs (9,8), (7,6), ..., (1,0))
MU, NU, SG = 0, 1, 2
E = [(1, 0, 0), (0, 1, 0), (0, 0, 1)]


def add(x, d):
    return (x[0] + E[d][0], x[1] + E[d][1], x[2] + E[d][2])


def inside(x):
    return all(0 <= c < n for c in x)


links = set()
for t in range(T):
    for a in range(n):
        for b in range(n):
            for c in range(n):
                x = (a, b, c)
                for d in (MU, NU, SG):
                    if inside(add(x, d)):
                        links.add((x, d, t))
plaqs = {}   # name -> tuple of links
for (x, d, t) in links:
    if t + 1 < T:
        plaqs[('T', x, d, t)] = ((x, d, t), (x, d, t + 1))
for t in range(T):
    for a in range(n):
        for b in range(n):
            for c in range(n):
                x = (a, b, c)
                for (i, j, nm) in ((MU, SG, 'MS'), (NU, SG, 'NS')):
                    ls = ((x, i, t), (add(x, i), j, t), (add(x, j), i, t), (x, j, t))
                    if all(l in links for l in ls):
                        plaqs[(nm, x, t)] = ls
by_link = defaultdict(list)
for nm, ls in plaqs.items():
    for l in ls:
        by_link[l].append(nm)

consumed = {}
integrated = {}
kfield = Counter()
errors = []
groups_log = []


def integrate(group_links, internal, tag):
    gl = set(group_links)
    for l in gl:
        if l in integrated:
            errors.append(("link twice", l))
    touched = set()
    for l in gl:
        for nm in by_link[l]:
            if nm not in consumed:
                touched.add(nm)
    for nm in touched:
        inter = [l for l in plaqs[nm] if l in gl]
        if nm == internal:
            if len(inter) != len(plaqs[nm]) and tag != 'pair':
                errors.append(("internal not whole", nm))
        else:
            if len(inter) != 1:
                errors.append(("two group links in an external plaquette", nm, tag))
            kfield[inter[0]] += 1
        consumed[nm] = tag
    for l in gl:
        integrated[l] = tag
    groups_log.append((tag, tuple(group_links), internal))


def is_single(x, d):
    return (d == MU and x[0] % 2 == 1) or (d == NU and x[1] % 2 == 1)


for m in range(T // 2 - 1, -1, -1):
    lo, hi = 2 * m, 2 * m + 1
    # (1) single pairs, ordered by increasing x_sigma
    singles = sorted({(x, d) for (x, d, t) in links if t == hi and is_single(x, d)}, key=lambda s: (s[0][2], s[1], s[0][0], s[0][1]))
    for (x, d) in singles:
        integrate([(x, d, lo), (x, d, hi)], ('T', x, d, lo), 'pair')
    for t in (hi, lo):
        # (2) P*_nu-sigma groups: x_nu even, x_sigma odd; order: increasing x_sigma, then x_mu even before odd
        gns = []
        gms = []
        for (nm, ls) in plaqs.items():
            if nm[0] == 'NS' and nm[2] == t and nm[1][1] % 2 == 0 and nm[1][2] % 2 == 1:
                gns.append(nm)
            if nm[0] == 'MS' and nm[2] == t and nm[1][0] % 2 == 0 and nm[1][2] % 2 == 0:
                gms.append(nm)
        gns.sort(key=lambda nm: (nm[1][2], nm[1][0] % 2, nm[1][0], nm[1][1]))
        for nm in gns:
            integrate(list(plaqs[nm]), nm, 'NSgroup')
        for nm in sorted(gms, key=lambda nm: (nm[1][2], nm[1][0], nm[1][1])):
            integrate(list(plaqs[nm]), nm, 'MSgroup')
        # boundary leftovers (links whose group plaquette sticks out of the box): integrate singly
        for l in sorted(l for l in links if l[2] == t and l not in integrated):
            integrate([l], None, 'leftover')


def interior_x(x):
    return all(3 <= c <= n - 4 for c in x)


def interior_t(t):
    return 2 <= t <= T - 3


# (I4)
unconsumed = [nm for nm in plaqs if nm not in consumed]
unintegrated = [l for l in links if l not in integrated]
print("links %d, plaquettes %d, unconsumed %d, unintegrated %d, structural errors %d" % (
    len(links), len(plaqs), len(unconsumed), len(unintegrated), len(errors)))
for e in errors[:10]:
    print("  ERROR", e)
viol = 0
cnt = Counter()
for (tag, gls, internal) in groups_log:
    if not all(interior_x(l[0]) and interior_t(l[2]) for l in gls):
        continue
    if tag == 'pair':
        (xl, dl, tl), (xh, dh, th) = gls
        ok = (kfield[gls[0]] == 2 and kfield[gls[1]] == 1)
        cnt[('pair', ok)] += 1
        viol += (not ok)
    elif tag == 'MSgroup':
        ks = tuple(sorted(kfield[l] for l in gls))
        ok = ks == (1, 1, 1, 1)
        cnt[('MS', ks)] += 1
        viol += (not ok)
    elif tag == 'NSgroup':
        ks = tuple(sorted((kfield[l] for l in gls), reverse=True))
        xmu = internal[1][0]
        want = (2, 2, 2, 1) if xmu % 2 == 0 else (2, 1, 1, 1)
        ok = ks == want
        cnt[('NS', 'xmu even' if xmu % 2 == 0 else 'xmu odd', ks)] += 1
        viol += (not ok)
    elif tag == 'leftover':
        cnt[('leftover in interior',)] += 1
        viol += 1
for k, v in sorted(cnt.items(), key=str):
    print("  interior", k, v)
# per-site plaquette accounting in the interior: every interior link's total field
print("interior violations: %d" % viol)
sys.exit(1 if (viol or errors or unconsumed or unintegrated) else 0)
