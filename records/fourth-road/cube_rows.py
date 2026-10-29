"""cube_rows.py -- the fourth road on the plan seat's candidate B (2026-10-29 05:1x): the FULL one-block row at scale 2.
For the kept link u (the vertical under b0) and EVERY other data link u' of the cube, Delta_cube(u, u') at the symmetric
datum (the mixed oscillation of the block's free energy in the two data links, exactly as g14's delta mode defines it),
each with the max-norm distance between the links' midpoints; the unweighted row sum and the sums weighted by e^{kappa d}.
Against it, the scale-1 row: one integrated link x with its six plaquettes and 18 data links, Delta_link(u, u') over the
17 other data links, same truncated weight w = 1 + 2 a1 tr V.  Uses cube_third_road's geometry and integrals; a pair of
data links sharing a cube link's external plaquette is carried as a joint (G, H) batch on that link.
usage: python cube_rows.py beta <b>      (cube row + single-link row)
       python cube_rows.py single <b>    (single-link row only)
"""
import sys, math, time, itertools
import numpy as np
import cube_third_road as C

def touching(link):
    return sorted(l for l in C.CUBE_LINKS if any(link in [r for r, _ in rest] for _, rest in C.LINK_DANG[l]))

def midpoint(link):
    s, mu = link
    m = [float(v) for v in s]; m[mu] += 0.5
    return m
def dist(a, b):
    ma, mb = midpoint(a), midpoint(b)
    return max(abs(x - y) for x, y in zip(ma, mb))

def compute_Z_pair(a1, u, up):
    UL, UPL = touching(u), touching(up)
    both = sorted(set(UL) & set(UPL))
    T0, TG, TH, TGH = {}, {}, {}, {}
    for l in C.CUBE_LINKS:
        fa, fb = [fi for fi, _, _ in C.LINK_FACES[l]]
        cases = [(), (fa,), (fb,), (fa, fb)]
        if l in both:
            phis = [[C.phi_poly(l, {u: C.Dm(g), up: C.Dm(h)}, a1) for h in C.DES] for g in C.DES]
            for case in cases:
                signs = [s for fi, _, s in C.LINK_FACES[l] if fi in case]
                TGH[(l, case)] = np.stack([np.stack([np.asarray(C.moment(p, signs)) for p in row]) for row in phis])
        elif l in UL or l in UPL:
            key = u if l in UL else up
            phis = [C.phi_poly(l, {key: C.Dm(q)}, a1) for q in C.DES]
            store = TG if l in UL else TH
            for case in cases:
                signs = [s for fi, _, s in C.LINK_FACES[l] if fi in case]
                store[(l, case)] = np.stack([np.asarray(C.moment(phi, signs)) for phi in phis])
        else:
            phi = C.phi_poly(l, {}, a1)
            for case in cases:
                signs = [s for fi, _, s in C.LINK_FACES[l] if fi in case]
                T0[(l, case)] = C.moment(phi, signs)
    Z = np.zeros((48, 48), dtype=complex)
    for r in range(7):
        for F in itertools.combinations(range(6), r):
            m = {}; k = 0
            for fi in F:
                for pos in range(4):
                    m[(fi, pos)] = C.LET[k]; k += 1
            ops, subs = [], []; pref = (2 * a1) ** len(F)
            for l in C.CUBE_LINKS:
                case = tuple(fi for fi, _, _ in C.LINK_FACES[l] if fi in F)
                sub = ''.join(m[(fi, pos)] + m[(fi, (pos + 1) % 4)] for fi, pos, s in C.LINK_FACES[l] if fi in F)
                if l in both: ops.append(TGH[(l, case)]); subs.append('GH' + sub)
                elif l in UL: ops.append(TG[(l, case)]); subs.append('G' + sub)
                elif l in UPL: ops.append(TH[(l, case)]); subs.append('H' + sub)
                elif case == (): pref = pref * T0[(l, case)]
                else: ops.append(T0[(l, case)]); subs.append(sub)
            Z += pref * np.einsum(','.join(subs) + '->GH', *ops, optimize='greedy')
    return Z

# ---- the single-link model: x = (0,0,0,0):1 with its six plaquettes; 18 data links
X = ((0, 0, 0, 0), 0)
SL_PLAQS = []
for nu in range(4):
    if nu == 0: continue
    for base in (X[0], C.add(X[0], nu, -1)):
        P = C.plaq(base, 0, nu)
        k = [i for i, (l, _) in enumerate(P) if l == X][0]
        SL_PLAQS.append((P[k][1], [P[(k + j) % 4] for j in (1, 2, 3)]))
SL_OUT = sorted({l for _, rest in SL_PLAQS for l, _ in rest})
assert len(SL_PLAQS) == 6 and len(SL_OUT) == 18

def single_Z(a1, u, up):
    Z = np.zeros((48, 48))
    for gi, g in enumerate(C.DES):
        for hi, h in enumerate(C.DES):
            data = {u: C.Dm(g), up: C.Dm(h)}
            p = C.ONE
            for (s, rest) in SL_PLAQS:
                p = C.pmul(p, C.padd(C.ONE, C.pscale(C.trUT(s, C.staple(rest, data)), 2 * a1)))
            Z[gi, hi] = C.integrate(p).real
    return Z

def delta(Z):
    Fm = -np.log(np.real(Z))
    br = Fm - Fm[:, :1]
    osc = br.max(axis=0) - br.min(axis=0)
    h = int(np.argmax(osc))
    return float(osc[h]), C.DES[h]

KAPPAS = (0.1, 0.25, 0.5)
def row_report(tag, u, others, dfun, a1):
    rows = []
    for up in others:
        t = time.time(); d, h = dfun(a1, u, up); dd = dist(u, up)
        rows.append((up, dd, d, h))
        print('%s  u\'=%s:%d  d=%.1f  Delta=%.6e  argmax=(%.3g,%.3g,%.3g,%.3g)  [%.1fs]' % (tag, up[0], up[1] + 1, dd, d, *h, time.time() - t), flush=True)
    tot = sum(r[2] for r in rows)
    print('%s ROW: %d neighbours, unweighted sum = %.6e, max = %.6e, by distance: %s' % (
        tag, len(rows), tot, max(r[2] for r in rows),
        '; '.join('d=%.1f: n=%d sum=%.3e' % (dd, sum(1 for r in rows if r[1] == dd), sum(r[2] for r in rows if r[1] == dd)) for dd in sorted({r[1] for r in rows}))), flush=True)
    for kappa in KAPPAS:
        print('%s ROW weighted kappa=%.2f: sum e^{kappa d} Delta = %.6e' % (tag, kappa, sum(math.exp(kappa * r[1]) * r[2] for r in rows)), flush=True)
    return rows

if __name__ == '__main__':
    mode = sys.argv[1]; beta = float(sys.argv[2]); a1 = C.a1_of_beta(beta)
    print('beta=%g a1=%.6f' % (beta, a1), flush=True)
    # single-link row: u = the data link with the largest coupling (choose u = (0,0,-1,0):3, the vertical under x, as in the cube)
    u1 = ((0, 0, -1, 0), 2); assert u1 in SL_OUT
    print('SINGLE LINK: x = (0,0,0,0):1, data links 18; u =', u1, flush=True)
    srows = row_report('SINGLE', u1, [l for l in SL_OUT if l != u1], lambda a, u, up: delta(single_Z(a, u, up)), a1)
    if mode == 'single': sys.exit(0)
    u = C.U_LINK
    print('CUBE: u =', u, 'in the external plaquettes of', ' '.join(C.NAMES[l] for l in touching(u)), flush=True)
    others = [l for l in C.OUT if l != u]
    crows = row_report('CUBE', u, others, lambda a, uu, up: delta(compute_Z_pair(a, uu, up)), a1)
    print('RATIO cube row / single-link row (unweighted) = %.6f' % (sum(r[2] for r in crows) / sum(r[2] for r in srows)), flush=True)
