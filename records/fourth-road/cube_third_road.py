#!/usr/bin/env python
"""cube_third_road.py -- an independent exact evaluator of the cube's one-link mixed difference Delta
(the third road on PENTAPYLON RESULTS 16.9's fourth-order law), the seat iii-3a, 2026-10-29.

THE MODEL (iii-38's statement; g14_su2_cube.pl's header, read for the definition only): the twelve links
of the unit cube in directions 1-3 of Z^4; every plaquette weight truncated at spin 1/2, w(V) = 1 + 2 a_1 tr V,
a_1 = I_2(beta)/I_1(beta); the six faces and the 48 external plaquettes, each external plaquette with its
three outside links as DATA, shared as the lattice shares them (a vertex link of directions 1-3 lies in two
external plaquettes).  Z_d = int over the twelve cube links of prod_faces w prod_ext w.  F = -log Z.
Delta(u, u') = max over g' of the oscillation over g (both in the 48-point binary octahedral design) of
[F(d with u -> g u, u' -> g' u') - F(d with u -> g u)] at the symmetric datum (every outside link 1),
u = (0,0,-1,0):3 (the vertical down at corner (0,0), under b0) and u' = (0,0,1,0):3 (the vertical up at
corner (0,0), over t0).

THE ROAD (nothing of g14's): exact Haar integration over each link by the S^3 monomial formula
   int_{S^3} z^a zbar^b v^c vbar^d  =  [a = b][c = d] a! c! / (a + c + 1)!        (U = [[z, v], [-vbar, zbar]]),
per-link moment tensors  int phi_l(U) (U^{s_1})_{i_1 j_1} (U^{s_2})_{i_2 j_2} dU  with phi_l the product of the
link's four external plaquette weights, the six faces expanded as the 2^6 sum over active faces, each active
face a trace around its four links (a chain of 2x2 matrix elements) contracted by einsum over all links at once,
the two perturbed sides carried as batch axes over the design (G for u's side, H for u''s side).

usage:  python cube_third_road.py check            # the five readings of record (beta = 0.3 0.5 0.7 0.9 1.0)
        python cube_third_road.py beta <b> [<b>...] # Delta at given beta
        python cube_third_road.py a1 <a> [<a>...]   # Delta at given a_1
        python cube_third_road.py series [r N]      # the Taylor coefficients of F in a_1 by a circle FFT: the mixed
                                                    # difference's coefficients at orders 3..6 (the order question decided exactly)
"""
import itertools, math, sys, time, string
import numpy as np

def bessel(n, x):
    s = 0.0; t = (x / 2) ** n / math.factorial(n)
    for k in range(80):
        s += t; t *= (x / 2) ** 2 / ((k + 1) * (k + 1 + n))
    return s
def a1_of_beta(beta): return bessel(2, beta) / bessel(1, beta)

# ---------------- geometry
def add(s, mu, k=1):
    t = list(s); t[mu] += k; return tuple(t)
CUBE_SITES = [(x, y, z, 0) for x in (0, 1) for y in (0, 1) for z in (0, 1)]
CUBE_LINKS = sorted({(s, mu) for s in CUBE_SITES for mu in range(3) if s[mu] == 0})
assert len(CUBE_LINKS) == 12
CL = set(CUBE_LINKS)
def plaq(base, a, b):   # the loop base -> base+a -> base+a+b -> base+b -> base, as (link, traversal sign)
    return [((base, a), +1), ((add(base, a), b), +1), ((add(base, b), a), -1), ((base, b), -1)]
PL = {}
for (s, mu) in CUBE_LINKS:
    for nu in range(4):
        if nu == mu: continue
        a, b = (mu, nu) if mu < nu else (nu, mu)
        for base in (s, add(s, nu, -1)):
            P = plaq(base, a, b)
            assert any(l == (s, mu) for l, _ in P)
            PL[(base, a, b)] = P
FACES = []; DANG = []
for key, P in PL.items():
    n = sum(1 for l, _ in P if l in CL)
    if n == 4: FACES.append(key)
    elif n == 1: DANG.append(key)
    else: raise RuntimeError(key)
FACES.sort(); DANG.sort()
assert len(FACES) == 6 and len(DANG) == 48, (len(FACES), len(DANG))
OUT = sorted({l for key in DANG for l, _ in PL[key] if l not in CL})
assert len(OUT) == 88, len(OUT)
CORNERS = [(0, 0), (1, 0), (1, 1), (0, 1)]
def name(link):   # g14's names: v_i the vertical at corner i, b_i / t_i the bottom / top edge from corner i to i+1
    (x, y, z, _), mu = link
    if mu == 2: return 'v%d' % CORNERS.index((x, y))
    for i in range(4):
        c0, c1 = CORNERS[i], CORNERS[(i + 1) % 4]
        lo = (min(c0[0], c1[0]), min(c0[1], c1[1])); d = 0 if c0[1] == c1[1] else 1
        if (x, y) == lo and mu == d: return ('b%d' if z == 0 else 't%d') % i
    raise RuntimeError(link)
NAMES = {l: name(l) for l in CUBE_LINKS}
U_LINK = ((0, 0, -1, 0), 2)      # u  = (0,0,-1,0):3
UP_LINK = ((0, 0, 1, 0), 2)      # u' = (0,0,1,0):3
assert U_LINK in OUT and UP_LINK in OUT

LINK_DANG = {l: [] for l in CUBE_LINKS}      # (sign of the cube link in the loop, the three outside (link, sign) after it)
for key in DANG:
    P = PL[key]
    k = [i for i, (l, _) in enumerate(P) if l in CL][0]
    l, s = P[k]
    LINK_DANG[l].append((s, [P[(k + j) % 4] for j in (1, 2, 3)]))
assert all(len(v) == 4 for v in LINK_DANG.values())
LINK_FACES = {l: [] for l in CUBE_LINKS}     # (face index, position in the loop, sign), faces in index order
for fi, key in enumerate(FACES):
    for pos, (l, s) in enumerate(PL[key]):
        LINK_FACES[l].append((fi, pos, s))
assert all(len(v) == 2 for v in LINK_FACES.values())
ULINKS = sorted(l for l in CUBE_LINKS if any(U_LINK in [r for r, _ in rest] for _, rest in LINK_DANG[l]))
UPLINKS = sorted(l for l in CUBE_LINKS if any(UP_LINK in [r for r, _ in rest] for _, rest in LINK_DANG[l]))
assert not set(ULINKS) & set(UPLINKS)

# ---------------- the design and the spin-1/2 matrix (g14's map, so argmax labels agree)
def design():
    h = 1 / math.sqrt(2); D = []
    for i in range(4):
        for s in (1, -1):
            q = [0., 0., 0., 0.]; q[i] = s; D.append(tuple(q))
    for a in (1, -1):
        for b in (1, -1):
            for c in (1, -1):
                for d in (1, -1):
                    D.append((a / 2, b / 2, c / 2, d / 2))
    for i in range(4):
        for j in range(i + 1, 4):
            for a in (1, -1):
                for b in (1, -1):
                    q = [0., 0., 0., 0.]; q[i] = a * h; q[j] = b * h; D.append(tuple(q))
    return D
DES = design(); assert len(DES) == 48 and DES[0] == (1., 0., 0., 0.)
def Dm(q):
    w, x, y, z = q
    return np.array([[w + 1j * x, y + 1j * z], [-y + 1j * z, w - 1j * x]], dtype=complex)

# ---------------- polynomials in (z, zbar, v, vbar) and the exact S^3 integral
def padd(p, q):
    r = dict(p)
    for k, v in q.items(): r[k] = r.get(k, 0) + v
    return r
def pmul(p, q):
    r = {}
    for k1, v1 in p.items():
        for k2, v2 in q.items():
            k = (k1[0] + k2[0], k1[1] + k2[1], k1[2] + k2[2], k1[3] + k2[3])
            r[k] = r.get(k, 0) + v1 * v2
    return r
def pscale(p, c): return {k: v * c for k, v in p.items()}
ONE = {(0, 0, 0, 0): 1.0 + 0j}
UP = {(0, 0): {(1, 0, 0, 0): 1.0}, (0, 1): {(0, 0, 1, 0): 1.0}, (1, 0): {(0, 0, 0, 1): -1.0}, (1, 1): {(0, 1, 0, 0): 1.0}}
UM = {(0, 0): {(0, 1, 0, 0): 1.0}, (0, 1): {(0, 0, 1, 0): -1.0}, (1, 0): {(0, 0, 0, 1): 1.0}, (1, 1): {(1, 0, 0, 0): 1.0}}
def Uent(s, i, j): return UP[(i, j)] if s == 1 else UM[(i, j)]
def trUT(s, T):   # tr(U^s T) = sum_ij (U^s)_ij T_ji
    p = {}
    for i in range(2):
        for j in range(2):
            p = padd(p, pscale(Uent(s, i, j), complex(T[j, i])))
    return p
FACT = [math.factorial(n) for n in range(24)]
def integrate(p):
    tot = 0j
    for (a, b, c, d), v in p.items():
        if a == b and c == d:
            tot += v * FACT[a] * FACT[c] / FACT[a + c + 1]
    return tot
# known answers for the integral (the fundamental character's orthogonality, and two singlets in four spin-1/2):
assert abs(integrate(pmul(trUT(1, np.eye(2)), trUT(-1, np.eye(2)))) - 1) < 1e-14
_t = trUT(1, np.eye(2)); assert abs(integrate(pmul(pmul(_t, _t), pmul(_t, _t))) - 2) < 1e-14
assert abs(integrate(_t)) < 1e-14

def staple(rest, data):
    T = np.eye(2, dtype=complex)
    for (l, s) in rest:
        M = data.get(l)
        if M is None: continue
        T = T @ (M if s == 1 else M.conj().T)
    return T
def phi_poly(link, data, a1):
    p = ONE
    for (s, rest) in LINK_DANG[link]:
        p = pmul(p, padd(ONE, pscale(trUT(s, staple(rest, data)), 2 * a1)))
    return p
def moment(phi, signs):
    n = len(signs)
    if n == 0: return integrate(phi)
    M = np.zeros((2,) * (2 * n), dtype=complex)
    for idx in itertools.product((0, 1), repeat=2 * n):
        p = phi
        for e in range(n):
            p = pmul(p, Uent(signs[e], idx[2 * e], idx[2 * e + 1]))
        M[idx] = integrate(p)
    return M

LET = string.ascii_lowercase
def compute_Z(a1):
    """Z[G, H] for u -> D(DES[G]) u, u' -> D(DES[H]) u', every other outside link 1."""
    T0, TG, TH = {}, {}, {}
    for l in CUBE_LINKS:
        fa, fb = [fi for fi, _, _ in LINK_FACES[l]]
        cases = [(), (fa,), (fb,), (fa, fb)]
        if l in ULINKS or l in UPLINKS:
            store, key = (TG, U_LINK) if l in ULINKS else (TH, UP_LINK)
            phis = [phi_poly(l, {key: Dm(q)}, a1) for q in DES]
            for case in cases:
                signs = [s for fi, _, s in LINK_FACES[l] if fi in case]
                store[(l, case)] = np.stack([np.asarray(moment(phi, signs)) for phi in phis])
        else:
            phi = phi_poly(l, {}, a1)
            for case in cases:
                signs = [s for fi, _, s in LINK_FACES[l] if fi in case]
                T0[(l, case)] = moment(phi, signs)
    Z = np.zeros((48, 48), dtype=complex)
    for r in range(7):
        for F in itertools.combinations(range(6), r):
            m = {}; k = 0
            for fi in F:
                for pos in range(4):
                    m[(fi, pos)] = LET[k]; k += 1
            ops, subs = [], []; pref = (2 * a1) ** len(F)
            for l in CUBE_LINKS:
                case = tuple(fi for fi, _, _ in LINK_FACES[l] if fi in F)
                sub = ''.join(m[(fi, pos)] + m[(fi, (pos + 1) % 4)] for fi, pos, s in LINK_FACES[l] if fi in F)
                if l in ULINKS: ops.append(TG[(l, case)]); subs.append('G' + sub)
                elif l in UPLINKS: ops.append(TH[(l, case)]); subs.append('H' + sub)
                elif case == (): pref = pref * T0[(l, case)]
                else: ops.append(T0[(l, case)]); subs.append(sub)
            Z += pref * np.einsum(','.join(subs) + '->GH', *ops, optimize='greedy')
    return Z

def delta_of_Z(Z):
    assert np.abs(Z.imag).max() < 1e-9 * np.abs(Z.real).max(), np.abs(Z.imag).max()
    Fm = -np.log(Z.real)
    br = Fm - Fm[:, :1]                      # F(g, g') - F(g, 1); H = 0 is the identity
    osc = br.max(axis=0) - br.min(axis=0)    # over g, per g'
    h = int(np.argmax(osc))
    return float(osc[h]), DES[h], osc

def report(a1, beta=None):
    t = time.time(); Z = compute_Z(a1); d, h, osc = delta_of_Z(Z)
    tag = ('beta=%g ' % beta) if beta is not None else ''
    print('%sa1=%.6f  Delta=%.6e  Delta/a1^4=%.4f  Delta/a1^5=%.4f  argmax g\'=(%.4g,%.4g,%.4g,%.4g)  osc(g\'=-1)=%.6e  osc(quarter -0.707,0.707,0,0)=%.6e  [%.1fs]'
          % (tag, a1, d, d / a1 ** 4, d / a1 ** 5, *h, osc[1], osc[DES.index((-1 / math.sqrt(2), 1 / math.sqrt(2), 0., 0.))], time.time() - t), flush=True)
    return d

if __name__ == '__main__':
    print('cube links:', ' '.join(NAMES[l] for l in CUBE_LINKS))
    print('u in the external plaquettes of:', ' '.join(NAMES[l] for l in ULINKS), '; u\' in those of:', ' '.join(NAMES[l] for l in UPLINKS), flush=True)
    mode = sys.argv[1] if len(sys.argv) > 1 else 'check'
    if mode == 'check':
        for b in (0.3, 0.5, 0.7, 0.9, 1.0): report(a1_of_beta(b), b)
    elif mode == 'beta':
        for b in sys.argv[2:]: report(a1_of_beta(float(b)), float(b))
    elif mode == 'a1':
        for a in sys.argv[2:]: report(float(a))
    elif mode == 'series':
        r = float(sys.argv[2]) if len(sys.argv) > 2 else 0.02
        N = int(sys.argv[3]) if len(sys.argv) > 3 else 32
        Fs = []
        for k in range(N):
            a1 = r * np.exp(2j * np.pi * k / N)
            Z = compute_Z(a1); Fs.append(-np.log(Z))
            print('  point %d/%d done' % (k + 1, N), flush=True)
        Fs = np.array(Fs)   # (N, 48, 48)
        coef = {}
        for n in range(0, 8):
            c = np.zeros((48, 48), dtype=complex)
            for k in range(N):
                a1 = r * np.exp(2j * np.pi * k / N)
                c += Fs[k] * a1 ** (-n)
            coef[n] = c / N
        for n in range(2, 8):
            mixed = (coef[n] - coef[n][:, :1]).real
            osc = mixed.max(axis=0) - mixed.min(axis=0)
            h = int(np.argmax(osc))
            print('order %d: max |mixed coefficient| = %.6e ; max over g\' of osc over g = %.6f at g\'=(%.4g,%.4g,%.4g,%.4g); osc at g\'=-1: %.6f; max |Im| = %.1e'
                  % (n, np.abs(mixed).max(), osc[h], *DES[h], osc[1], np.abs((coef[n] - coef[n][:, :1]).imag).max()), flush=True)
        np.save("series_coef.npy", np.array([coef[n] for n in range(0, 8)]))
        # the by-hand form of the fifth-order DOUBLE difference: both families read tr(g^-1 g'^-1) = 2 Re(g g'); 32 clusters x 2 a1^5 in log Z
        def re_prod(g, h): return g[0]*h[0] - g[1]*h[1] - g[2]*h[2] - g[3]*h[3]
        pred = np.array([[-128 * (re_prod(g, h) - g[0] - h[0] + 1) for h in DES] for g in DES])
        c5 = coef[5].real; got = c5 - c5[:, :1] - c5[:1, :] + c5[0, 0]
        print('order 5 double difference against the by-hand form -128(Re(g g\x27) - w_g - w_g\x27 + 1): max |difference| = %.3e (max |term| %.3f)' % (np.abs(got - pred).max(), np.abs(pred).max()))
        c7 = coef[7].real; d7 = c7 - c7[:, :1] - c7[:1, :] + c7[0, 0]; print('order 7 double difference: osc at g\x27=-1 = %.6f, ratio to order 5 = %.6f' % ((d7[:, 1].max() - d7[:, 1].min()), (d7[:, 1].max() - d7[:, 1].min()) / 512))
