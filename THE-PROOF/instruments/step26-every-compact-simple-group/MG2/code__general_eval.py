# MG2 general_eval.py -- THEOREM 8.7_G's row sum alpha_G(beta) with the five one-link constants bounded by LEMMA NH (WORK.md 4.4) from the
# group's seven numbers (n, t3, t4, o3, c3, m4; WORK.md 4.5), in mpmath interval arithmetic (outward rounding).  For each group: the largest
# beta on a decimal grid at which alpha_G < 1 is CERTIFIED (alpha_G is increasing in beta: every constant is increasing in r and the formula is
# increasing in beta), its 't Hooft value lambda* = h kappa / beta*, and MG's Bakry-Emery value beta_BE = h kappa / 96 beside it.
import sys
from fractions import Fraction as Fr
from decimal import Decimal
from mpmath import iv, mp
iv.prec = 200

def I(x):
    if isinstance(x, Fr): return iv.mpf(x.numerator) / iv.mpf(x.denominator)
    return iv.mpf(x)

# ---- group data: (name, type, d, dimG, C2rho, hdual, M3/complex data, M4, Sym2 dims (nontrivial), Lam2 dims (nontrivial))
# t3, t4, o3 exact; m4 bound from the component weights; c3 exact or bounded.
def group_table():
    G = []
    def real_or_quat(name, typ, d, dimG, C2, h, M3, M4, symdims, lamdims, c3exact=None, antisym=False):
        n = d * d
        t3 = Fr(M3, d**3); t4 = Fr(M4, d**4); o3 = t3
        # E z^4 bound as a function of t, maximised over the t-interval (linear in t)
        if typ == 'R': tlo, thi = Fr(1, d), Fr(1)
        else: tlo, thi = Fr(1, d), Fr(1, 2)
        def bnd(t):
            WS = (1 + t) / 2; WL = (1 - t) / 2; b = Fr(1, d * d)
            if typ == 'R':
                b += (WS - Fr(1, d * d)) / min(symdims)
                if lamdims: b += WL / min(lamdims)
            else:
                b += WS / min(symdims)
                if lamdims: b += (WL - Fr(1, d * d)) / min(lamdims)
            return b
        Ez4 = max(bnd(tlo), bnd(thi))
        m4 = Ez4 / (d * d)
        G.append(dict(name=name, type=typ, d=d, n=n, dimG=dimG, C2=C2, h=h, t3=t3, t4=t4, o3=o3, m4=m4, c3exact=c3exact, antisym=antisym, M3=M3))
    def complex_(name, d, dimG, C2, h, t3, t4, o3, symdims, lamdims, Ez4abs=Fr(0), c3exact=None):
        n = 2 * d * d
        tlo, thi = Fr(1, d), Fr(1)
        def bnd(t):
            return ((1 + t) / 2) / min(symdims) + ((1 - t) / 2) / min(lamdims)
        Ezz = max(bnd(tlo), bnd(thi))
        ERe4 = (6 * Ezz + 2 * Ez4abs) / 16
        m4 = ERe4 / (d * d)
        G.append(dict(name=name, type='C', d=d, n=n, dimG=dimG, C2=C2, h=h, t3=t3, t4=t4, o3=o3, m4=m4, c3exact=c3exact, antisym=False, M3=None))
    real_or_quat('SU(2)', 'Q', 2, 3, Fr(3, 4), 2, 0, 2, [3], [], c3exact=Fr(0))
    complex_('SU(3)', 3, 8, Fr(4, 3), 3, Fr(1, 108), Fr(1, 108), Fr(1, 108), [6], [3], c3exact=Fr(1, 108))
    complex_('SU(4)', 4, 15, Fr(15, 8), 4, Fr(0), Fr(14, 4096), Fr(0), [10], [6], Ez4abs=Fr(1, 16), c3exact=Fr(0))
    complex_('SU(5)', 5, 24, Fr(12, 5), 5, Fr(0), Fr(12, 16 * 625), Fr(0), [15], [10], c3exact=Fr(0))
    real_or_quat('Sp(2)', 'Q', 4, 10, Fr(5, 4), 3, 0, 3, [10], [5], c3exact=Fr(0))
    real_or_quat('SO(3)', 'R', 3, 3, Fr(2), 2, 1, 3, [5], [3], c3exact=Fr(1, 27))
    real_or_quat('SO(5)', 'R', 5, 10, Fr(2), 3, 0, 3, [14], [10], c3exact=Fr(0))
    real_or_quat('SO(6)', 'R', 6, 15, Fr(5, 2), 4, 0, 3, [20], [15], c3exact=Fr(0))
    real_or_quat('SO(7)', 'R', 7, 21, Fr(3), 5, 0, 3, [27], [21], c3exact=Fr(0))
    real_or_quat('SO(8)', 'R', 8, 28, Fr(7, 2), 6, 0, 3, [35], [28], c3exact=Fr(0))
    real_or_quat('G2', 'R', 7, 14, Fr(2), 4, 1, 4, [27], [7, 14], antisym=True)
    real_or_quat('F4', 'R', 26, 52, Fr(6), 9, 1, 5, [26, 324], [52, 273])
    complex_('E6', 27, 78, Fr(26, 3), 12, Fr(1, 4 * 27**3), Fr(18, 16 * 27**4), Fr(1, 4 * 27**3), [27, 351], [351])
    real_or_quat('E7', 'Q', 56, 133, Fr(57, 4), 18, 0, 4, [133, 1463], [1539], c3exact=Fr(0))
    real_or_quat('E8', 'R', 248, 248, Fr(30), 30, 1, 5, [3875, 27000], [248, 30380], antisym=True)
    for g in G:
        g['T'] = Fr(g['d']) * g['C2'] / g['dimG']
        g['kappa'] = Fr(g['d']) / g['T']
        g['hk'] = g['h'] * g['kappa']
    return G

def phi(k, r):
    # sum_{j>=k} r^j/j! for an interval r >= 0, series with geometric tail
    s = iv.mpf(0); t = iv.mpf(1)
    for j in range(1, k + 1): t = t * r / j
    J = 120
    for j in range(k, k + J):
        s = s + t
        t = t * r / (j + 1)
    q = iv.mpf(r.b) / (k + J + 1)
    assert q.b < 0.5
    return s + iv.mpf([0, (t / (1 - q)).b])

def constants(g, r, c3):
    n = I(g['n']); t3 = abs(I(g['t3'])); t4 = I(g['t4']); o3 = I(g['o3']); m4 = I(g['m4'])
    s1 = 1 / n + r * c3 + phi(2, r) * m4
    s0 = 1 / n + r * o3 + phi(2, r) * m4
    mu1 = r / n + r * r * c3 / 2 + phi(3, r) * iv.sqrt(m4 / n)
    mubar = mu1 if mu1.b <= (r * s1).b else r * s1
    a1 = r * o3 + phi(2, r) * (m4 + 1 / (n * n))
    D = 2 * a1 + mubar * mubar
    sq = iv.sqrt(t4 * m4)
    T1 = t3 + phi(1, r) * sq + 3 * mubar * s0 + 2 * mubar ** 3
    Q = t4 + phi(1, r) * sq + 4 * mubar * (t3 + phi(1, r) * sq) + 6 * mubar * mubar * s0
    Tx = iv.sqrt(s0 * Q)
    return dict(mu=mubar, s=s1, D=D, T=T1, Tx=Tx)

def alpha_G(g, beta):
    b = iv.mpf(beta)
    n = I(g['n'])
    if g['c3exact'] is not None: c3 = I(g['c3exact'])
    else:
        c3 = iv.sqrt(I(g['m4']) / n)
        if g['antisym']:
            alt = iv.mpf(1) / (iv.sqrt(iv.mpf(27)) * iv.mpf(g['d']) ** iv.mpf(1.5))
            if alt.b < c3.b: c3 = alt
    K5 = constants(g, 5 * b, c3); K6 = constants(g, 6 * b, c3)
    om = 3 * b * b * K5['D'] + 2 * b ** 3 * K6['T']
    omp = 12 * b * K5['mu'] + om
    M = iv.exp(omp / 2) / iv.sqrt(n)
    Cdir = M * b * K5['mu'] + (b * b * K5['D'] + (iv.mpf(2) / 3) * b ** 3 * K6['T']) / 4
    x = b * b * K5['D']; y = 2 * b ** 3 * K5['Tx']
    mn = x if x.b <= y.b else y            # an upper bound of min(x, y) (both are upper bounds of the same quantity's two estimates)
    Cmed = M * b * b * K5['s'] + (mn + (iv.mpf(2) / 3) * b ** 3 * K6['T']) / 4
    return 12 * Cdir + 90 * Cmed, dict(Cdir12=12 * Cdir, Cmed90=90 * Cmed, M=M, om=om, omp=omp, K5=K5, K6=K6, c3=c3)

def certified_root(g, lo='0.01', step0='0.01', digits=4):
    # largest decimal beta with alpha_G(beta) < 1 certified: coarse march, then refine
    b = Decimal(lo); step = Decimal(step0)
    if mp.mpf(alpha_G(g, str(b))[0].b) >= 1: return None
    while True:
        nb = b + step
        if mp.mpf(alpha_G(g, str(nb))[0].b) < 1: b = nb
        else:
            if step <= Decimal(10) ** (-digits): break
            step = step / 10
    return b

def fmt(x, k=6):
    return mp.nstr(mp.mpf(x.b), k)

if __name__ == '__main__':
    G = group_table()
    which = sys.argv[1:] if len(sys.argv) > 1 else [g['name'] for g in G]
    for g in G:
        if g['name'] not in which: continue
        print('== %s type=%s d=%d n=%d h=%s kappa=%s hk=%s | t3=%s t4=%s o3=%s m4=%s (t4/m4 shows the m4 loss: %s) c3exact=%s' % (
            g['name'], g['type'], g['d'], g['n'], g['h'], g['kappa'], g['hk'], g['t3'], g['t4'], g['o3'], g['m4'],
            mp.nstr(mp.mpf(g['t4'].numerator) / g['t4'].denominator / (mp.mpf(g['m4'].numerator) / g['m4'].denominator), 4) if g['t4'] else '-', g['c3exact']))
        bstar = certified_root(g)
        al, det = alpha_G(g, str(bstar))
        hk = mp.mpf(g['hk'].numerator) / g['hk'].denominator
        print('   CERTIFIED alpha_G < 1 on [0, %s]: alpha=%s 12Cdir=%s 90Cmed=%s M*sqrt(n)=%s omega=%s | at 5b: mu=%s s=%s (1/n=%s) D=%s | T(6b)=%s Tx(5b)=%s c3=%s' % (
            bstar, fmt(al, 7), fmt(det['Cdir12']), fmt(det['Cmed90']), mp.nstr(mp.mpf((det['M'] * iv.sqrt(iv.mpf(g['n']))).b), 6), fmt(det['om']),
            fmt(det['K5']['mu']), fmt(det['K5']['s']), mp.nstr(mp.mpf(1) / g['n'], 6), fmt(det['K5']['D']), fmt(det['K6']['T']), fmt(det['K5']['Tx']), fmt(det['c3'])))
        print('   lambda* = h kappa / beta* = %s   |   beta_BE = h kappa/96 = %s   |   beta*/beta_BE = %s   |   S_D (MG, uniform) = 0.0556' % (
            mp.nstr(hk / mp.mpf(str(bstar)), 6), mp.nstr(hk / 96, 6), mp.nstr(mp.mpf(str(bstar)) / (hk / 96), 4)))
        sys.stdout.flush()
