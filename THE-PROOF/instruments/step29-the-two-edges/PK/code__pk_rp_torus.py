#!/usr/bin/env python3
"""PK — reflection positivity of diagonal reflections on lattice tori (stakes S-1..S-6 of WORK.md §2).

Gaussian models only (for a Gaussian measure, RP <=> the covariance is reflection positive on +side linear observables):
  GFF      covariance (-Delta + m^2)^{-1}, nearest-neighbour Laplacian, site variables;
  MAXWELL  lattice U(1) Gaussian (beta = 1), Feynman gauge link covariance delta_{mu nu} G0 (G0 = pseudo-inverse of -Delta),
           observables = plaquette variables F_p (gauge invariant, so the gauge choice is immaterial).
Tori:  'H' hypercubic (Z/N)^d;  'A' adapted in the (0,1)-plane: Z^d / <N(1,1,0..), N(1,-1,0..), N e_2, ..., N e_{d-1}>.
Reflections: 'swap' (x0 <-> x1, directions 0 <-> 1), 'coord' site reflection x0 -> -x0, 'bond' x0 -> -1 - x0.
RP matrix M_ij = E[O_i(R Phi) O_j(Phi)] over +side observables. Survey in double precision (numpy eigvalsh: a READING);
certificates in exact rational arithmetic: (a) an integer vector v with exact v^T M v < 0 refutes RP; (b) an exact LDL^T with
all pivots >= 0 (zero pivots with zero rows) proves the matrix PSD.
"""
import sys, itertools, math, time
from fractions import Fraction as Fr
import numpy as np

# ---------------------------------------------------------------- exact cosines (Niven: rational iff denom in {1,2,3,4,6})
def cos_turn(fr):
    """cos(2*pi*fr) for a Fraction fr whose reduced denominator divides 12 and lies in {1,2,3,4,6}; exact."""
    fr = fr - (fr.numerator // fr.denominator)
    table = {Fr(0): Fr(1), Fr(1, 2): Fr(-1), Fr(1, 3): Fr(-1, 2), Fr(2, 3): Fr(-1, 2), Fr(1, 4): Fr(0), Fr(3, 4): Fr(0),
             Fr(1, 6): Fr(1, 2), Fr(5, 6): Fr(1, 2)}
    if fr not in table:
        raise ValueError("cos(2 pi * %s) is not rational" % fr)
    return table[fr]

# ---------------------------------------------------------------- tori
class Torus:
    def __init__(self, kind, N, d):
        self.kind, self.N, self.d = kind, N, d
        if kind == 'H':
            self.sites = list(itertools.product(range(N), repeat=d))
            # momenta as fractions of a full turn per coordinate: k_mu = 2 pi * n_mu / N
            self.moms = [tuple(Fr(n, N) for n in ns) for ns in itertools.product(range(N), repeat=d)]
        elif kind == 'A':
            rest = list(itertools.product(range(N), repeat=d - 2))
            self.sites = [(a, b) + r for a in range(N) for b in range(2 * N) for r in rest]
            # dual lattice: k_0, k_1 = (pi/N)(a, b), a = b mod 2, a, b mod 2N  ->  turns a/(2N), b/(2N)
            self.moms = [(Fr(a, 2 * N), Fr(b, 2 * N)) + tuple(Fr(c, N) for c in cs)
                         for a in range(2 * N) for b in range(2 * N) if (a - b) % 2 == 0
                         for cs in itertools.product(range(N), repeat=d - 2)]
        else:
            raise ValueError(kind)
        assert len(self.moms) == len(self.sites)
        self.index = {s: i for i, s in enumerate(self.sites)}
        self.V = len(self.sites)

    def canon(self, x):
        N, d = self.N, self.d
        if self.kind == 'H':
            return tuple(c % N for c in x)
        q = x[0] // N
        x0, x1 = x[0] - q * N, x[1] - q * N
        return (x0, x1 % (2 * N)) + tuple(c % N for c in x[2:])

    def lap(self, k):            # sum_mu (2 - 2 cos k_mu), exact
        return sum(2 - 2 * cos_turn(km) for km in k)

    def lapf(self, k):
        return sum(2 - 2 * math.cos(2 * math.pi * float(km)) for km in k)


def green_table(T, m2, exact):
    """G(x) for every canonical site x; m2 = 0 gives the pseudo-inverse (k = 0 excluded)."""
    G = {}
    for x in T.sites:
        if exact:
            s = Fr(0)
            for k in T.moms:
                den = m2 + T.lap(k)
                if den == 0:
                    continue
                s += cos_turn(sum(km * xc for km, xc in zip(k, x))) / den
            G[x] = s / T.V
        else:
            s = 0.0
            for k in T.moms:
                den = float(m2) + T.lapf(k)
                if den == 0:
                    continue
                s += math.cos(2 * math.pi * float(sum(km * xc for km, xc in zip(k, x)))) / den
            G[x] = s / T.V
    return G

# ---------------------------------------------------------------- reflections on sites and links
def refl_site(T, R, x):
    if R == 'swap':
        y = (x[1], x[0]) + tuple(x[2:])
    elif R == 'coord':
        y = (-x[0],) + tuple(x[1:])
    elif R == 'bond':
        y = (-1 - x[0],) + tuple(x[1:])
    return T.canon(y)

def refl_link(T, R, x, mu):
    """(R A)_mu(x) = eps * A_{mu'}(x');  returns (eps, x', mu')."""
    if R == 'swap':
        mup = {0: 1, 1: 0}.get(mu, mu)
        return 1, refl_site(T, R, x), mup
    if R == 'coord':
        if mu == 0:   # link (x, x+e0) -> (Rx, Rx - e0), reversed
            y = refl_site(T, R, x)
            return -1, T.canon((y[0] - 1,) + tuple(y[1:])), 0
        return 1, refl_site(T, R, x), mu
    raise ValueError(R)

# ---------------------------------------------------------------- +side sets
def dval(T, x):
    """d = x0 - x1 reduced to [0, P) with P the period of d on this torus (N for H, 2N for A)."""
    P = T.N if T.kind == 'H' else 2 * T.N
    return (x[0] - x[1]) % P, P

def plus_sites(T, R, Dmax=None):
    out = []
    for x in T.sites:
        if R == 'swap':
            d, P = dval(T, x)
            ok = d < P // 2 if T.kind == 'H' else d <= P // 2      # H: [0, N/2) ; A: [0, N] (both fixed components)
            if Dmax is not None:
                ok = ok and d <= Dmax
        elif R == 'coord':
            ok = x[0] <= T.N // 2
        elif R == 'bond':
            ok = x[0] <= T.N // 2 - 1
        if ok:
            out.append(x)
    return out

def plus_link(T, R, x, mu):
    if R == 'swap':
        N = T.N
        P = N if T.kind == 'H' else 2 * N
        twice = (2 * (x[0] - x[1]) + (1 if mu == 0 else -1 if mu == 1 else 0)) % (2 * P)   # 2 * midpoint d
        if mu in (0, 1):
            return 0 < twice < P                     # midpoint in (0, P/2)
        return twice == 0 or (0 < twice < P) or (T.kind == 'A' and twice == P)
    if R == 'coord':
        h = T.N // 2
        if mu == 0:
            return 0 <= x[0] <= h - 1
        return 0 <= x[0] <= h
    raise ValueError(R)

# ---------------------------------------------------------------- observables
def plaquette_weights(T, x, mu, nu):
    """F_{mu nu}(x) = A_mu(x) + A_nu(x+e_mu) - A_mu(x+e_nu) - A_nu(x) as {(site, dir): coeff}."""
    def sh(y, e):
        z = list(y); z[e] += 1
        return T.canon(tuple(z))
    w = {}
    for (s, dd, c) in ((x, mu, 1), (sh(x, mu), nu, 1), (sh(x, nu), mu, -1), (x, nu, -1)):
        w[(s, dd)] = w.get((s, dd), 0) + c
    return w

def plus_plaquettes(T, R):
    out = []
    for x in T.sites:
        for mu in range(T.d):
            for nu in range(mu + 1, T.d):
                w = plaquette_weights(T, x, mu, nu)
                if all(plus_link(T, R, s, dd) for (s, dd) in w):
                    out.append((x, mu, nu, w))
    return out

def pull_back(T, R, w):
    """weights of O(R A) as a functional of A."""
    out = {}
    for (x, mu), c in w.items():
        eps, xp, mup = refl_link(T, R, x, mu)
        out[(xp, mup)] = out.get((xp, mup), 0) + eps * c
    return out

def diff(T, x, y):
    return T.canon(tuple(a - b for a, b in zip(x, y)))

# ---------------------------------------------------------------- RP matrices
def gff_matrix(T, R, G, plus, stagger=False):
    n = len(plus)
    M = np.zeros((n, n))
    for i, x in enumerate(plus):
        rx = refl_site(T, R, x)
        for j, y in enumerate(plus):
            v = float(G[diff(T, rx, y)])
            if stagger:
                v *= (-1) ** ((rx[0] + y[0]) % 2)
            M[i, j] = v
    return M

def link_cov(G, T, a, b):
    """sum_mu sum_{x,y} a_mu(x) b_mu(y) G(x - y) for weight dicts a, b (exact if G exact)."""
    s = 0
    bymu = {}
    for (y, mu), c in b.items():
        bymu.setdefault(mu, []).append((y, c))
    for (x, mu), ca in a.items():
        for (y, cb) in bymu.get(mu, ()):
            s += ca * cb * G[diff(T, x, y)]
    return s

def maxwell_matrix(T, R, G, plaqs):
    n = len(plaqs)
    pulled = [pull_back(T, R, p[3]) for p in plaqs]
    M = np.zeros((n, n))
    for i in range(n):
        for j in range(n):
            M[i, j] = float(link_cov(G, T, pulled[i], plaqs[j][3]))
    return M

# ---------------------------------------------------------------- exact certificates
def exact_psd(Mx):
    """Exact symmetric elimination with diagonal pivoting. Returns (True, None) if PSD, (False, info) otherwise."""
    A = [row[:] for row in Mx]
    idx = list(range(len(A)))
    while idx:
        p = max(idx, key=lambda i: A[i][i])
        if A[p][p] < 0:
            return False, ("negative pivot", A[p][p])
        if A[p][p] == 0:
            for i in idx:
                if A[i][i] != 0:
                    break
            # all remaining diagonals are 0 (max is 0): PSD requires the remaining block to vanish
            for i in idx:
                for j in idx:
                    if A[i][j] != 0:
                        return False, ("zero diagonal with nonzero off-diagonal", (i, j))
            return True, None
        piv = A[p][p]
        idx.remove(p)
        for i in idx:
            if A[i][p] == 0:
                continue
            f = A[i][p] / piv
            for j in idx:
                A[i][j] -= f * A[p][j]
    return True, None

def rationalize(v, scale=1000):
    v = np.asarray(v)
    v = v / np.max(np.abs(v))
    return [int(round(scale * t)) for t in v]

# ---------------------------------------------------------------- runs
def out(*a):
    print(*a)
    sys.stdout.flush()

def gff_case(kind, N, d, R, m2, exact_cert, exact_psd_check, Dmax=None, stagger=False, label=""):
    T = Torus(kind, N, d)
    t0 = time.time()
    Gf = green_table(T, m2, exact=False)
    plus = plus_sites(T, R, Dmax)
    M = gff_matrix(T, R, Gf, plus, stagger)
    asym = np.max(np.abs(M - M.T))
    ev, evec = np.linalg.eigh((M + M.T) / 2)
    lam_min, lam_max = ev[0], ev[-1]
    vmin = evec[:, 0]
    # where does the negative direction live?  weight by d
    wt = {}
    for c, x in zip(vmin, plus):
        key = dval(T, x)[0] if R == 'swap' else x[0]
        wt[key] = wt.get(key, 0.0) + c * c
    out("GFF %s kind=%s N=%d d=%d R=%s m2=%s +side=%d  asym=%.1e  lam_min=%.6e  lam_max=%.6e  neg_count=%d  weight_of_min_vec_by_%s=%s  (%.1fs)"
        % (label, kind, N, d, R, m2, len(plus), asym, lam_min, lam_max, int(np.sum(ev < -1e-12)),
           'd' if R == 'swap' else 'x0', {k: round(v, 3) for k, v in sorted(wt.items())}, time.time() - t0))
    if exact_cert or exact_psd_check:
        Gx = green_table(T, Fr(m2), exact=True)
        Mx = []
        for x in plus:
            rx = refl_site(T, R, x)
            row = []
            for y in plus:
                v = Gx[diff(T, rx, y)]
                if stagger:
                    v *= (-1) ** ((rx[0] + y[0]) % 2)
                row.append(v)
            Mx.append(row)
        symm = all(Mx[i][j] == Mx[j][i] for i in range(len(Mx)) for j in range(len(Mx)))
        if exact_cert:
            v = rationalize(vmin)
            q = sum(v[i] * Mx[i][j] * v[j] for i in range(len(v)) for j in range(len(v)))
            out("   EXACT certificate: integer v (max |v_i| = 1000, %d nonzero) gives v^T M v = %s = %.6e  [%s]  (M symmetric exactly: %s)"
                % (sum(1 for t in v if t), q, float(q), "NEGATIVE: RP REFUTED" if q < 0 else "not negative", symm))
            out("   v =", v)
        if exact_psd_check:
            ok, info = exact_psd(Mx)
            out("   EXACT LDL^T: %s %s  (M symmetric exactly: %s)" % ("PSD (all pivots >= 0)" if ok else "NOT PSD", "" if ok else info, symm))
    return lam_min

def maxwell_case(kind, N, d, R, exact_cert, exact_psd_check, label=""):
    T = Torus(kind, N, d)
    t0 = time.time()
    Gf = green_table(T, 0, exact=False)
    plaqs = plus_plaquettes(T, R)
    M = maxwell_matrix(T, R, Gf, plaqs)
    asym = np.max(np.abs(M - M.T))
    ev, evec = np.linalg.eigh((M + M.T) / 2)
    vmin = evec[:, 0]
    wt = {}
    for c, p in zip(vmin, plaqs):
        key = ((p[0][0] - p[0][1]) % (T.N if kind == 'H' else 2 * T.N), p[1], p[2]) if R == 'swap' else (p[0][0], p[1], p[2])
        wt[key[0]] = wt.get(key[0], 0.0) + c * c
    out("MAXWELL %s kind=%s N=%d d=%d R=%s +side plaquettes=%d  asym=%.1e  lam_min=%.6e  lam_max=%.6e  neg_count=%d  weight_of_min_vec_by_%s=%s  (%.1fs)"
        % (label, kind, N, d, R, len(plaqs), asym, ev[0], ev[-1], int(np.sum(ev < -1e-12)),
           'base_d' if R == 'swap' else 'base_x0', {k: round(v, 3) for k, v in sorted(wt.items())}, time.time() - t0))
    if exact_cert or exact_psd_check:
        t1 = time.time()
        Gx = green_table(T, Fr(0), exact=True)
        out("   exact G0 table built (%.1fs)" % (time.time() - t1))
        if exact_cert:
            v = rationalize(vmin)
            a, b = {}, {}
            for vi, p in zip(v, plaqs):
                if vi == 0:
                    continue
                for key, c in pull_back(T, R, p[3]).items():
                    a[key] = a.get(key, 0) + vi * c
                for key, c in p[3].items():
                    b[key] = b.get(key, 0) + vi * c
            q = link_cov(Gx, T, a, b)
            out("   EXACT certificate: integer v (max |v_i| = 1000, %d nonzero) gives v^T M v = %s = %.6e  [%s]"
                % (sum(1 for t in v if t), q, float(q), "NEGATIVE: RP REFUTED" if q < 0 else "not negative"))
        if exact_psd_check:
            pulled = [pull_back(T, R, p[3]) for p in plaqs]
            Mx = [[link_cov(Gx, T, pulled[i], plaqs[j][3]) for j in range(len(plaqs))] for i in range(len(plaqs))]
            symm = all(Mx[i][j] == Mx[j][i] for i in range(len(Mx)) for j in range(len(Mx)))
            ok, info = exact_psd(Mx)
            out("   EXACT LDL^T: %s %s  (M symmetric exactly: %s)" % ("PSD (all pivots >= 0)" if ok else "NOT PSD", "" if ok else info, symm))
    return ev[0]


if __name__ == "__main__":
    out("pk_rp_torus.py — stakes S-1..S-6 (WORK.md §2)")
    out("== S-1: GFF, hypercubic torus, diagonal swap ==")
    for N in (4, 6, 8, 10):
        gff_case('H', N, 2, 'swap', 1, exact_cert=(N in (4, 6)), exact_psd_check=False, label="S-1")
    out("== S-2: GFF, hypercubic torus, coordinate site reflection (sighted positive control) ==")
    for N in (4, 6, 8, 10):
        gff_case('H', N, 2, 'coord', 1, exact_cert=False, exact_psd_check=(N in (4, 6)), label="S-2")
    out("== S-3: GFF, adapted torus, diagonal swap (positive control) ==")
    for N in (2, 3, 4, 5):
        gff_case('A', N, 2, 'swap', 1, exact_cert=False, exact_psd_check=(N in (2, 3)), label="S-3")
    out("== S-4: staggered GFF across the coordinate bond reflection (sighted negative control) ==")
    for N in (4, 6, 8):
        gff_case('H', N, 2, 'bond', 1, exact_cert=(N in (4, 6)), exact_psd_check=False, stagger=True, label="S-4")
    out("   (unstaggered bond reflection, the PSD reference of S-4:)")
    for N in (4, 6):
        gff_case('H', N, 2, 'bond', 1, exact_cert=False, exact_psd_check=True, stagger=False, label="S-4ref")
    out("== S-5: Maxwell (Gaussian U(1)) ==")
    maxwell_case('H', 4, 3, 'swap', exact_cert=True, exact_psd_check=False, label="S-5")
    maxwell_case('H', 4, 3, 'coord', exact_cert=False, exact_psd_check=True, label="S-5ctl")
    maxwell_case('A', 2, 3, 'swap', exact_cert=False, exact_psd_check=True, label="S-5ctlA")
    maxwell_case('A', 3, 3, 'swap', exact_cert=False, exact_psd_check=False, label="S-5ctlA")
    maxwell_case('H', 6, 3, 'swap', exact_cert=True, exact_psd_check=False, label="S-5")
    maxwell_case('H', 6, 3, 'coord', exact_cert=False, exact_psd_check=False, label="S-5ctl")
    maxwell_case('H', 4, 4, 'swap', exact_cert=True, exact_psd_check=False, label="S-5")
    maxwell_case('H', 4, 4, 'coord', exact_cert=False, exact_psd_check=False, label="S-5ctl")
    out("== S-6 (UNGUESSED reading): GFF (Z/12)^2, swap, +side restricted to d <= D ==")
    for D in (1, 2, 3, 5):
        gff_case('H', 12, 2, 'swap', 1, exact_cert=False, exact_psd_check=False, Dmax=D, label="S-6")
    out("done")
