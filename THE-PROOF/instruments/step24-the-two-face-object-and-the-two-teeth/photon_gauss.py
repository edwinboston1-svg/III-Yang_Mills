"""photon_gauss.py -- THE PHOTON-CARRIED DECIDER, TOOTH 1 (the author's plan of 2026-11-02 11:1x), built by hand by the author.

The free 4D lattice photon (Villain U(1) at large beta_V, monopoles exponentially small) is Gaussian, so every quantity here is exact
up to quadrature: a flux observable Phi = <J, A> with J a closed 1-chain has Var(Phi) = (1/beta) <J, G J>, G = (-Delta)^{-1} on Z^4,
because <theta theta> = (1/beta) P_exact and d*1_S = dS (the Wilson-loop current).  beta = 1 throughout (every ratio is beta-free).

It decomposes the readings pipeline's U(1) failure (M7b: two pinned steps read beta_eff = 0.391 beta_V) into its parts:
  (a) CONVENTION: the pipeline inverts a single coarse plaquette's marginal through the ISOLATED-plaquette law (Var = 1/beta_eff);
      for the free photon a FINE plaquette already reads beta_eff = 1/Var = 2 beta (4D equipartition: Var(theta_p) = 1/(2 beta)).
  (b) THE HOLONOMY MAP'S PERIMETER SELF-ENERGY: the coarse plaquette is the flux through an n x n fine square, Var ~ perimeter.
  (c) PINNING: the exterior fixed at a datum (conditional variance, a Schur complement on the integrated region).
  (d) THE AVERAGED MAP (gauge-covariant: paths from block corner to block corner through every transverse offset).
  (e) TOOTH 1 IN ITS PROPER FORM: the effective coupling read from LONG-DISTANCE flux correlations, coarse pair at coarse separation
      R against fine pair at fine separation R: ratio -> 1 for ANY map exact on smooth fields (4D Maxwell is scale invariant).
Known answers checked first: G(0) = 0.15493339; G(0) - G(e1) = 1/8 exactly; Var(theta_p) = 1/2.
"""
import sys, itertools
import numpy as np
from scipy.special import ive
from scipy.integrate import quad
import scipy.sparse as sp
import scipy.sparse.linalg as spla

D = 4
_G = {}
def G(x):
    k = tuple(sorted(abs(int(c)) for c in x))
    if k not in _G:
        f = lambda t: np.prod([ive(n, 2.0 * t) for n in k])
        a, _ = quad(f, 0.0, 1.0, limit=200, epsabs=1e-14, epsrel=1e-12)
        b, _ = quad(f, 1.0, np.inf, limit=400, epsabs=1e-14, epsrel=1e-12)
        _G[k] = a + b
    return _G[k]

def e(mu):
    v = [0] * D; v[mu] = 1; return tuple(v)
def add(x, y): return tuple(a + b for a, b in zip(x, y))
def sub(x, y): return tuple(a - b for a, b in zip(x, y))

def step(J, x, mu, sgn, w):
    """walk one step from site x in direction sgn*mu, weight w; returns the new site"""
    if sgn > 0:
        J[(x, mu)] = J.get((x, mu), 0.0) + w; return add(x, e(mu))
    y = sub(x, e(mu)); J[(y, mu)] = J.get((y, mu), 0.0) - w; return y

def square(n, x0=(0, 0, 0, 0), mu=0, nu=1, w=1.0, J=None):
    """the boundary current of the n x n square at x0 in the (mu,nu) plane"""
    J = {} if J is None else J; x = x0
    for _ in range(n): x = step(J, x, mu, +1, w)
    for _ in range(n): x = step(J, x, nu, +1, w)
    for _ in range(n): x = step(J, x, mu, -1, w)
    for _ in range(n): x = step(J, x, nu, -1, w)
    return J

def avg_link(J, X0, mu, L, w):
    """the gauge-covariant averaged coarse link from corner X0 to X0 + L e_mu: the average over the L^3 transverse offsets y of the
    staircase path X0 -> X0+y -> X0+y+L e_mu -> X0 + L e_mu (transverse legs in a fixed order, out and back)"""
    tr = [d for d in range(D) if d != mu]
    for y in itertools.product(range(L), repeat=D - 1):
        x = X0; ww = w / L ** (D - 1)
        for d, k in zip(tr, y):
            for _ in range(k): x = step(J, x, d, +1, ww)
        for _ in range(L): x = step(J, x, mu, +1, ww)
        for d, k in zip(tr, y):
            for _ in range(k): x = step(J, x, d, -1, ww)
    return J

def avg_plaquette(L, X0=(0, 0, 0, 0), mu=0, nu=1, w=1.0, J=None):
    J = {} if J is None else J
    A = X0; B = add(A, tuple(L * c for c in e(mu))); C = add(B, tuple(L * c for c in e(nu))); Dd = add(A, tuple(L * c for c in e(nu)))
    avg_link(J, A, mu, L, w); avg_link(J, B, nu, L, w); avg_link(J, Dd, mu, L, -w); avg_link(J, A, nu, L, -w)
    return J

def pair(J1, J2):
    s = 0.0
    by1 = {}
    for (x, mu), c in J1.items():
        if c != 0.0: by1.setdefault(mu, []).append((x, c))
    for (y, nu), c2 in J2.items():
        if c2 == 0.0: continue
        for (x, c1) in by1.get(nu, []):
            s += c1 * c2 * G(sub(x, y))
    return s

def check_closed(J):
    div = {}
    for (x, mu), c in J.items():
        div[x] = div.get(x, 0.0) - c; y = add(x, e(mu)); div[y] = div.get(y, 0.0) + c
    return max(abs(v) for v in div.values()) if div else 0.0

def pinned_var(J, box_lo, box_hi, xi=1.0):
    """Var(<J,A>) given every link NOT inside the box pinned (links with both endpoints in the box are integrated)."""
    sites = list(itertools.product(*[range(a, b + 1) for a, b in zip(box_lo, box_hi)]))
    inb = lambda x: all(a <= c <= b for c, a, b in zip(x, box_lo, box_hi))
    links = [(x, mu) for x in sites for mu in range(D) if inb(add(x, e(mu)))]
    idx = {l: i for i, l in enumerate(links)}; n = len(links)
    rows, cols, vals = [], [], []
    for x in sites:  # plaquettes with at least one integrated link: every plaquette based at x or touching; enumerate by base point
        pass
    plaqs = set()
    for (x, mu) in links:
        for nu in range(D):
            if nu == mu: continue
            a, b = min(mu, nu), max(mu, nu)
            plaqs.add((x, a, b)); plaqs.add((sub(x, e(nu)), a, b) if nu != mu else None)
    plaqs.discard(None)
    for (x, a, b) in plaqs:
        ls = [((x, a), +1), ((add(x, e(a)), b), +1), ((add(x, e(b)), a), -1), ((x, b), -1)]
        ii = [(idx[l], s) for l, s in ls if l in idx]
        for i, si in ii:
            for j, sj in ii:
                rows.append(i); cols.append(j); vals.append(si * sj)
    for x in sites:  # gauge fixing xi (d*A)(x)^2 ONLY at interior sites (every incident link integrated): at a site touching a pinned
        # link the gauge freedom is already broken by the pinning, and a term there would reweight non-gauge directions (run a: 1e-4)
        if not all((x, mu) in idx and (sub(x, e(mu)), mu) in idx for mu in range(D)): continue
        ii = []
        for mu in range(D):
            if (x, mu) in idx: ii.append((idx[(x, mu)], -1))
            y = sub(x, e(mu))
            if (y, mu) in idx: ii.append((idx[(y, mu)], +1))
        for i, si in ii:
            for j, sj in ii:
                rows.append(i); cols.append(j); vals.append(xi * si * sj)
    K = sp.csc_matrix((vals, (rows, cols)), shape=(n, n))
    v = np.zeros(n)
    for l, c in J.items():
        if l not in idx: raise ValueError('current leaves the box: %s' % (l,))
        v[idx[l]] = c
    u = spla.spsolve(K, v)
    return float(v @ u), n

def main():
    out = []
    P = lambda s: (print(s), out.append(s))
    P('KNOWN ANSWERS')
    g0, g1 = G((0, 0, 0, 0)), G((1, 0, 0, 0))
    P('  G(0) = %.12f   (Watson, 4D: 0.154933390231)' % g0)
    P('  G(0) - G(e1) = %.12f   (exact 1/8 = 0.125)' % (g0 - g1))
    Jp = square(1); v1 = pair(Jp, Jp)
    P('  Var(fine plaquette) = %.12f   (equipartition 1/2)   closed: %.1e' % (v1, check_closed(Jp)))
    P('')
    P('(a)+(b) HOLONOMY MAP, EXTERIOR INTEGRATED (pipeline convention beta_eff = 1/Var; beta = 1)')
    P('  fine plaquette: Var = %.6f  beta_eff = %.6f' % (v1, 1 / v1))
    hol = {}
    for k, n in [(1, 2), (2, 4)]:
        J = square(n); v = pair(J, J); hol[k] = v
        P('  %d step(s), n = %d: Var = %.6f  beta_eff/beta = %.6f   (relative to the fine plaquette: %.6f)' % (k, n, v, 1 / v, v1 / v))
    P('')
    P('(c) HOLONOMY MAP, EXTERIOR PINNED outside a box of margin r around the square (links inside integrated)')
    for k, n in [(1, 2), (2, 4)]:
        J = square(n)
        for r in [0, 1, 2]:
            lo = (-r, -r, -r, -r); hi = (n + r, n + r, r, r)
            vv, nl = pinned_var(J, lo, hi)
            vx, _ = pinned_var(J, lo, hi, xi=0.37)
            P('  %d step(s), n = %d, margin %d (%6d links): Var = %.6f  beta_eff/beta = %.6f   (xi-independence: %.1e)' % (k, n, r, nl, vv, 1 / vv, abs(vv - vx)))
    P('')
    P('(d) AVERAGED MAP (gauge-covariant corner-to-corner paths), EXTERIOR INTEGRATED')
    for k, L in [(1, 2), (2, 4)]:
        J = avg_plaquette(L); v = pair(J, J)
        P('  %d step(s), L = %d: Var = %.6f  beta_eff/beta = %.6f   closed: %.1e   support %d links' % (k, L, v, 1 / v, check_closed(J), len(J)))
    P('')
    P('(e) TOOTH 1, PROPER FORM: long-distance flux correlation, coarse pair at coarse separation R vs fine pair at fine separation R')
    P('    (separation along the 3rd axis, perpendicular to the plaquettes\' plane; ratio -> 1 means beta_eff = beta)')
    rat = {}
    for Rs in [2, 3, 4, 6, 8, 10, 12]:
        f = pair(square(1), square(1, x0=(0, 0, Rs, 0)))
        for L in [2, 4]:
            hc = pair(square(L), square(L, x0=(0, 0, L * Rs, 0)))
            ac = pair(avg_plaquette(L), avg_plaquette(L, X0=(0, 0, L * Rs, 0)))
            rat[(L, 'hol', Rs)] = hc / f; rat[(L, 'avg', Rs)] = ac / f
            P('  R = %2d: fine %.6e | L=%d holonomy %.6e (ratio %.6f) | averaged %.6e (ratio %.6f)' % (Rs, f, L, hc, hc / f, ac, ac / f))
    P('  EXTRAPOLATION: fit ratio(R) = r_inf - c/R^2 - d/R^4 on R = 8, 10, 12 (a 3x3 solve); r_inf is the effective coupling ratio')
    for L in [2, 4]:
        for m in ['hol', 'avg']:
            Rv = [8, 10, 12]; A = np.array([[1.0, -1.0 / R ** 2, -1.0 / R ** 4] for R in Rv]); y = np.array([rat[(L, m, R)] for R in Rv])
            ri, c, d = np.linalg.solve(A, y)
            A2 = np.array([[1.0, -1.0 / R ** 2] for R in [10, 12]]); ri2, c2 = np.linalg.solve(A2, np.array([rat[(L, m, R)] for R in [10, 12]]))
            P('    L=%d %s: r_inf = %.5f (c = %.3f, d = %.2f); two-term fit on R = 10, 12: r_inf = %.5f' % (L, m, ri, c, d, ri2))
    return out

if __name__ == '__main__':
    res = main()
    if len(sys.argv) > 1:
        with open(sys.argv[1], 'w', encoding='utf-8') as h: h.write('\n'.join(res) + '\n')
