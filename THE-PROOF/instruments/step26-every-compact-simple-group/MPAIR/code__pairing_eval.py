# MPAIR pairing_eval.py -- certified (mpmath interval, outward rounding) evaluations for the two pairings.
#  chatterjee : the cube row sum max_tuple [Ndir*C_dir + Nmed*C_med + Nbare*C_bare] over the 40 realised tuples (cube_boundary runs),
#               for SU(2) with THE GROUND's exact constants and for every group with MG2's universal constants (Lemma NH);
#               the largest 4-decimal beta at which it is certified < 1 (the row sum is increasing in beta).
#  be         : Bakry-Emery on the decimated L0 marginal: K0 = Ric - 108 sbar(6b) b^2/d - 18 b mubar(6b) theta/sqrt(d)  (WORK.md 5.2);
#               largest beta with K0 > 0 certified, and the lifted LSI / Poincare constants of the FULL measure at chosen betas (5.4).
import sys
from decimal import Decimal
from fractions import Fraction as Fr
sys.path.insert(0, sys.argv[1])
from mpmath import iv, mp
import mg2_general_eval as GE
import mg2_su2_eval as S2
iv.prec = 200

TUPLES = [(0,10,68,0),(0,10,69,0),(0,10,70,0),(0,10,71,0),(0,10,72,0),(0,11,77,0),(0,11,78,0),(0,11,79,0),(0,11,80,0),(0,11,81,0),
          (0,12,86,0),(0,12,87,0),(0,12,88,0),(0,12,89,0),(0,12,90,0),
          (1,8,50,2),(1,8,53,2),(1,8,55,2),(1,9,61,2),(1,9,63,2),(1,10,69,2),(1,10,71,2),
          (2,3,37,3),(2,3,38,3),(2,3,39,3),(2,3,41,4),(2,3,42,4),(2,3,43,4),(2,4,44,3),(2,4,45,3),(2,4,46,3),(2,4,48,4),(2,4,49,4),(2,4,50,4),
          (3,2,28,4),(3,2,29,4),(3,2,32,5),(3,3,35,4),(3,3,38,5),(4,0,10,4)]
PI = iv.pi

def su2_constants(beta):
    R = S2.alpha_su2(beta, 'EXACT')
    b = iv.mpf(beta)
    Cdir = R['dir12'] / 12; Cmed = R['med90'] / 90
    Cbare = R['rho'] * 4 * b / (3 * PI)      # sharp MAD 4/(3 pi) holds under EVERY vMF law (THE GROUND 8.1), so a bare field costs nothing extra
    return {k: (Cdir, Cmed, Cbare) for k in range(5)}, R['alpha']

def gen_constants(g, beta):
    b = iv.mpf(beta)
    al, det = GE.alpha_G(g, beta)
    n = GE.I(g['n'])
    K5 = det['K5']; K6 = det['K6']; om = det['om']
    x = b * b * K5['D']; y = 2 * b ** 3 * K5['Tx']
    mn = x if x.b <= y.b else y
    out = {}
    for k in range(5):
        ompk = 2 * (k * b + (6 - k) * b * K5['mu']) + om     # density oscillation of the conditional law w.r.t. Haar with k bare fields
        Mk = iv.exp(ompk / 2) / iv.sqrt(n)
        Cdir = Mk * b * K5['mu'] + (b * b * K5['D'] + (iv.mpf(2) / 3) * b ** 3 * K6['T']) / 4
        Cmed = Mk * b * b * K5['s'] + (mn + (iv.mpf(2) / 3) * b ** 3 * K6['T']) / 4
        Cbare = Mk * b
        out[k] = (Cdir, Cmed, Cbare)
    return out, al

def cube_rowsum(C):
    best = None; arg = None
    for t in TUPLES:
        k, nd, nm, nb = t
        cd, cm, cb = C[k]
        r = nd * cd + nm * cm + nb * cb
        if best is None or r.b > best.b: best = r; arg = t
    return best, arg

def largest(fn, lo, step0, digits=4):
    b = Decimal(lo); step = Decimal(step0)
    if not fn(str(b)): return None
    while True:
        nb = b + step
        if fn(str(nb)): b = nb
        else:
            if step <= Decimal(10) ** (-digits): break
            step = step / 10
    return b

def theta(g):
    # sup ||rho(X)||_op / |rho(X)|_HS on the Lie algebra (PROVED bounds, WORK.md 5.2)
    nm = g['name']
    if nm.startswith('SU('):
        N = g['d']; return iv.sqrt(iv.mpf(N - 1) / N)          # attained at diag(N-1, -1, ..., -1)
    if nm == 'E6':
        return iv.sqrt(iv.mpf(26) / 27)                        # crude (traceless): ||A||^2 <= (d-1)/d |A|^2
    return 1 / iv.sqrt(iv.mpf(2))                               # real/quaternionic type: eigenvalues in pairs +-i t

def ricci(g):
    return GE.I(g['hk']) / (4 * g['d'])                        # Ric = h kappa / (4 d) in the metric g_rho (MG2 5.2; SZZ's C_Ric)

def be_K0(g, beta, su2sharp=False):
    b = iv.mpf(beta)
    d = iv.mpf(g['d']); th = theta(g); Ric = ricci(g)
    if su2sharp:
        sb = iv.mpf(1) / 4; mb = S2.m_of(6 * b)
    else:
        n = GE.I(g['n'])
        if g['c3exact'] is not None: c3 = GE.I(g['c3exact'])
        else:
            c3 = iv.sqrt(GE.I(g['m4']) / n)
            if g['antisym']:
                alt = iv.mpf(1) / (iv.sqrt(iv.mpf(27)) * iv.mpf(g['d']) ** iv.mpf(1.5))
                if alt.b < c3.b: c3 = alt
        K6 = GE.constants(g, 6 * b, c3); sb = K6['s']; mb = K6['mu']
    K0 = Ric - 108 * sb * b * b / d - 18 * b * mb * th / iv.sqrt(d)
    kx = Ric - 6 * sb * b * b / d - 6 * b * mb * th / iv.sqrt(d)          # single-site BE constant of the L0 conditional law
    k1 = Ric - 6 * b * th / iv.sqrt(d)                                     # BE constant of a cover link's law nu_w, |w| <= 6b
    k1hs = Ric * iv.exp(-12 * b)                                           # Holley-Stroock alternative
    if k1hs.a > k1.a: k1 = k1hs
    return dict(K0=K0, kx=kx, k1=k1, Ric=Ric, sb=sb, mb=mb, th=th)

def opt_eps(A, B, C):
    # min over eps>0 of max{A(1+eps), B + C(1+1/eps)}: equality root; A, B, C positive reals (mp)
    a = A; bq = A - B - C; cq = -C
    eps = (-bq + mp.sqrt(bq * bq - 4 * a * cq)) / (2 * a)
    return A * (1 + eps), eps

def lifted(g, beta, su2sharp=False, alpha=None):
    # explicit LSI and Poincare constants of the FULL measure from: kappa0 (BE on mu0), lambda0 (Poincare of mu0 by Dobrushin coupling),
    # the cover-link constants; all lower bounds -> use the interval's lower ends; returns mp numbers (conservative).
    b = mp.mpf(beta)
    E = be_K0(g, beta, su2sharp)
    d = g['d']
    k0 = mp.mpf(E['K0'].a); k1 = mp.mpf(E['k1'].a); lc = k1
    kx = mp.mpf(E['kx'].a)
    lam_x = kx                                   # single-site gap of the L0 conditional law (BE)
    lam0 = (1 - mp.mpf(alpha.b)) * lam_x if alpha is not None else None
    res = dict(K0=k0, k1=k1, kx=kx, lam0=lam0)
    if k0 > 0:
        A = 1 / k0; Bq = 1 / k1; Cq = 243 * b * b / (d * lc * k0)
        v, eps = opt_eps(A, Bq, Cq)
        res['kappa_full'] = 1 / v
    if lam0 is not None and lam0 > 0:
        A = 1 / lam0; Bq = 1 / lc; Cq = 108 * b * b / (d * lc * lam0)
        v, eps = opt_eps(A, Bq, Cq)
        res['lambda_full'] = 1 / v
    return res

def f(x, k=6):
    return mp.nstr(mp.mpf(x.b if hasattr(x, 'b') else x), k)

if __name__ == '__main__':
    mode = sys.argv[2]
    G = GE.group_table()
    if mode == 'chatterjee':
        # SU(2) sharp
        def ok_su2(beta):
            C, al = su2_constants(beta); r, t = cube_rowsum(C)
            return mp.mpf(r.b) < 1
        bC = largest(ok_su2, '0.20', '0.01')
        C, al = su2_constants(str(bC)); r, t = cube_rowsum(C)
        C2, al2 = su2_constants(str(bC + Decimal('0.0001'))); r2, t2 = cube_rowsum(C2)
        print('SU(2) EXACT: beta^C = %s certified (cube row sum %s at tuple %s; bulk alpha %s); next grid point %s: row sum %s at %s' % (
            bC, f(r, 8), t, f(al, 8), bC + Decimal('0.0001'), f(r2, 8), t2))
        for beta in ['0.2000', '0.2200', '0.2400', '0.2452']:
            C, al = su2_constants(beta); r, t = cube_rowsum(C)
            print('   SU(2) EXACT beta=%s: cube row sum %s (worst tuple %s), bulk alpha %s' % (beta, f(r, 7), t, f(al, 7)))
        sys.stdout.flush()
        for g in G:
            def ok(beta, g=g):
                C, al = gen_constants(g, beta); r, t = cube_rowsum(C)
                return mp.mpf(r.b) < 1
            bstar = GE.certified_root(g)
            bC = largest(ok, '0.01', '0.01')
            C, al = gen_constants(g, str(bC)); r, t = cube_rowsum(C)
            cen = {'SU(2)': 'Z2', 'SU(3)': 'Z3', 'SU(4)': 'Z4', 'SU(5)': 'Z5', 'Sp(2)': 'Z2', 'SO(6)': 'Z2', 'SO(8)': 'Z2', 'E6': 'Z3', 'E7': 'Z2'}.get(g['name'], 'trivial')
            print('%-6s centre %-7s beta*=%s  beta^C=%s  ratio %s  (cube row sum %s at %s)' % (g['name'], cen, bstar, bC,
                  mp.nstr(mp.mpf(str(bC)) / mp.mpf(str(bstar)), 4), f(r, 7), t))
            sys.stdout.flush()
    elif mode == 'be':
        def okbe_su2(beta):
            return mp.mpf(be_K0(G[0], beta, True)['K0'].a) > 0
        bbe = largest(okbe_su2, '0.05', '0.01')
        E = be_K0(G[0], str(bbe), True)
        print('SU(2) EXACT (s=1/4, m(6b)): BE on mu0 certified K0 > 0 up to beta^BE = %s (K0 = %s); SZZ line h kappa/96 = 0.0833333' % (bbe, f(E['K0'], 6)))
        for beta in ['0.05', '0.0833', '0.10', '0.15']:
            R, al = su2_constants(beta)
            L = lifted(G[0], beta, True, al)
            Ric = 1; Kszz = 1 - 24 * mp.mpf(beta) / 2
            print('   beta=%s: K0(mu0)=%s kx=%s k1=%s lambda0(Poinc. mu0)=%s | FULL measure: LSI kappa >= %s, Poincare >= %s | SZZ K = %s' % (
                beta, mp.nstr(L['K0'], 5), mp.nstr(L['kx'], 5), mp.nstr(L['k1'], 5), mp.nstr(L['lam0'], 5),
                mp.nstr(L.get('kappa_full', mp.mpf(0)), 5), mp.nstr(L.get('lambda_full', mp.mpf(0)), 5), mp.nstr(Kszz, 5) if Kszz > 0 else 'n/a (outside)'))
        sys.stdout.flush()
        for g in G:
            def okbe(beta, g=g):
                return mp.mpf(be_K0(g, beta)['K0'].a) > 0
            bbe = largest(okbe, '0.001', '0.01')
            hk = mp.mpf(g['hk'].numerator) / g['hk'].denominator
            bszz = hk / 96
            bstar = GE.certified_root(g)
            print('%-6s Ric=%s theta=%s | BE on mu0 (explicit LSI): beta^BE=%s | SZZ beta=%s | Dobrushin beta*=%s | beta^BE/SZZ=%s' % (
                g['name'], f(ricci(g), 5), f(theta(g), 5), bbe, mp.nstr(bszz, 5), bstar, mp.nstr(mp.mpf(str(bbe)) / bszz, 4) if bbe else '-'))
            sys.stdout.flush()
    elif mode == 'lift':
        # lifted constants for each group at beta = half its BE threshold and at SZZ's half-line, plus Poincare at beta* - margin
        for g in G:
            def okbe(beta, g=g):
                return mp.mpf(be_K0(g, beta)['K0'].a) > 0
            bbe = largest(okbe, '0.001', '0.01')
            hk = mp.mpf(g['hk'].numerator) / g['hk'].denominator
            out = []
            for beta in [str((bbe / 2).quantize(Decimal('0.0001'))), str(bbe)]:
                al, det = GE.alpha_G(g, beta)
                L = lifted(g, beta, False, al)
                Kszz = mp.mpf(ricci(g).a) - 24 * mp.mpf(beta) / g['d']
                out.append('b=%s: kappa0=%s kappa_full=%s lambda_full=%s SZZ_K=%s' % (beta, mp.nstr(L['K0'], 4), mp.nstr(L.get('kappa_full', mp.mpf(0)), 4),
                           mp.nstr(L.get('lambda_full', mp.mpf(0)), 4), mp.nstr(Kszz, 4) if Kszz > 0 else 'outside'))
            print('%-6s ' % g['name'] + ' | '.join(out))
            sys.stdout.flush()
