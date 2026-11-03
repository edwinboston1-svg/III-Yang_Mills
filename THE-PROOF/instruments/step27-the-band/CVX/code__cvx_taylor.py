"""CVX — the EXACT Taylor coefficients (rational) of the plaquette function F(phi) = 1 - Re(q(phi1) q(phi2) q(-phi3) q(-phi4)) to
total degree 5 in the 12 [EXP] coordinates, q(phi) = (cos r, -sinc(r) phi).  Writes rec/taylor_D4.npy (12^4, exact as float: the
entries are small rationals, checked exactly representable) and rec/taylor_D5.npy (12^5).
Checks: degree-2 part = |sum s_i phi_i|^2 / 2 (h0); degree-3 part = V3 (the cubic vertex, sum of four determinants); the numerical
analytic Hessian's even part (h(t phi) + h(-t phi) - 2 h0)/(2 t^2) -> Q4(phi) = (1/2) D4F(0)[phi, phi].
Run: python -u -E -P code/cvx_taylor.py > rec/taylor.<date>.txt
"""
import sys, os, time, itertools
from fractions import Fraction as Fr
import numpy as np
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

DEG = 5
NV = 12


def padd(a, b, s=1):
    out = dict(a)
    for k, v in b.items():
        out[k] = out.get(k, 0) + s * v
        if out[k] == 0:
            del out[k]
    return out


def pmul(a, b):
    out = {}
    for ka, va in a.items():
        da = sum(ka)
        for kb, vb in b.items():
            if da + sum(kb) > DEG:
                continue
            k = tuple(x + y for x, y in zip(ka, kb))
            out[k] = out.get(k, 0) + va * vb
    return {k: v for k, v in out.items() if v != 0}


def pscale(a, c):
    return {k: v * c for k, v in a.items()} if c != 0 else {}


def var(i):
    k = [0] * NV; k[i] = 1
    return {tuple(k): Fr(1)}


ONE = {tuple([0] * NV): Fr(1)}


def qpoly(link, sgn):
    """quaternion (4 polys) of q(sgn*phi_link) to degree DEG."""
    ph = [pscale(var(3 * link + a), Fr(sgn)) for a in range(3)]
    r2 = {}
    for a in range(3):
        r2 = padd(r2, pmul(ph[a], ph[a]))
    r4 = pmul(r2, r2)
    cosr = padd(padd(ONE, pscale(r2, Fr(-1, 2))), pscale(r4, Fr(1, 24)))
    sinc = padd(padd(ONE, pscale(r2, Fr(-1, 6))), pscale(r4, Fr(1, 120)))
    vec = [pscale(pmul(sinc, ph[a]), Fr(-1)) for a in range(3)]
    return [cosr] + vec


def qmulp(p, q):
    p0, p1, p2, p3 = p
    q0, q1, q2, q3 = q
    m = pmul
    s = lambda *terms: _sum(terms)
    return [s(m(p0, q0), pscale(m(p1, q1), -1), pscale(m(p2, q2), -1), pscale(m(p3, q3), -1)),
            s(m(p0, q1), m(q0, p1), m(p2, q3), pscale(m(p3, q2), -1)),
            s(m(p0, q2), m(q0, p2), m(p3, q1), pscale(m(p1, q3), -1)),
            s(m(p0, q3), m(q0, p3), m(p1, q2), pscale(m(p2, q1), -1))]


def _sum(terms):
    out = {}
    for t in terms:
        out = padd(out, t)
    return out


def deriv_tensor(F, d, scaled=False):
    """the symmetric d-th derivative tensor at 0 of the homogeneous degree-d part.  scaled=False: float array (asserted exact);
    scaled=True: (integer array, denominator) with tensor = integer array / denominator EXACTLY."""
    import math
    vals = {}
    den = 1
    for k, c in F.items():
        if sum(k) != d:
            continue
        idx = []
        mult = 1
        for i, e in enumerate(k):
            idx += [i] * e
            mult *= math.factorial(e)
        val = c * mult
        vals[tuple(idx)] = val
        den = den * val.denominator // math.gcd(den, val.denominator)
    if scaled:
        T = np.zeros((NV,) * d, dtype=np.int64)
        for idx, val in vals.items():
            iv = val * den
            assert iv.denominator == 1
            for perm in set(itertools.permutations(idx)):
                T[perm] = int(iv)
        return T, den
    T = np.zeros((NV,) * d)
    for idx, val in vals.items():
        fv = float(val)
        assert Fr(fv) == val, ("not exactly representable", val)
        for perm in set(itertools.permutations(idx)):
            T[perm] = fv
    return T


def main():
    t0 = time.time()
    qs = [qpoly(0, 1), qpoly(1, 1), qpoly(2, -1), qpoly(3, -1)]
    P = qmulp(qmulp(qmulp(qs[0], qs[1]), qs[2]), qs[3])
    F = padd(ONE, P[0], -1)
    by_deg = {d: sum(1 for k in F if sum(k) == d) for d in range(DEG + 1)}
    print("F to degree %d: monomials by degree %s  (%.1f s)" % (DEG, by_deg, time.time() - t0))
    # checks
    from cvx_core import h0_plaq, plaq_h1, plaq_hess, S_SIGN
    D2 = deriv_tensor(F, 2)
    print("check degree 2: |D2F(0) - h0| = %.1e" % np.abs(D2 - h0_plaq()).max())
    D3 = deriv_tensor(F, 3)
    rng = np.random.default_rng(3)
    phi = rng.normal(size=(5, 4, 3)) * 0.3
    h1 = plaq_h1(phi)
    h1t = np.einsum('abc,nc->nab', D3, phi.reshape(5, 12))
    print("check degree 3: |D3F(0)[phi] - h1(phi)| = %.1e" % np.abs(h1t - h1).max())
    D4i, den4 = deriv_tensor(F, 4, scaled=True)
    D5i, den5 = deriv_tensor(F, 5, scaled=True)
    print("D4 = integer tensor / %d (max |int| %d); D5 = integer tensor / %d (max |int| %d)" % (den4, np.abs(D4i).max(), den5, np.abs(D5i).max()))
    D4 = D4i / den4
    D5 = D5i / den5
    recdir0 = os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', 'rec')
    np.save(os.path.join(recdir0, 'taylor_D4int.npy'), D4i)
    np.save(os.path.join(recdir0, 'taylor_D5int.npy'), D5i)
    with open(os.path.join(recdir0, 'taylor_den.txt'), 'w') as fh:
        fh.write("%d %d\n" % (den4, den5))
    # numerical check of Q4 = (1/2) D4[phi,phi] and Q5 = (1/6) D5[phi,phi,phi] via h(t phi) Taylor
    x = phi.reshape(5, 12)
    Q4 = 0.5 * np.einsum('klab,na,nb->nkl', D4, x, x)
    Q5 = np.einsum('klabc,na,nb,nc->nkl', D5, x, x, x) / 6.0
    for t in (1e-1, 3e-2, 1e-2):
        ht = plaq_hess(t * phi)
        pred = h0_plaq()[None] + t * h1 + t * t * Q4 + t ** 3 * Q5
        print("check: |h(t phi) - (h0 + t h1 + t^2 Q4 + t^3 Q5)| at t = %.0e: %.3e (should scale as t^4)" % (t, np.abs(ht - pred).max()))
    recdir = os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', 'rec')
    np.save(os.path.join(recdir, 'taylor_D4.npy'), D4)
    np.save(os.path.join(recdir, 'taylor_D5.npy'), D5)
    print("saved D4 (%d nonzero), D5 (%d nonzero); max |D4| %.4f, max |D5| %.4f  (%.1f s)"
          % ((D4 != 0).sum(), (D5 != 0).sum(), np.abs(D4).max(), np.abs(D5).max(), time.time() - t0))


if __name__ == '__main__':
    main()
