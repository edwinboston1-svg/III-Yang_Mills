# MPAIR sigma_eval.py -- the slab sigma-model of Durhuus-Froehlich (d = 4: a nearest-neighbour model on the 3-dimensional slice, six
# neighbours), checkerboard-decimated: given the even sites the odd sites are independent vMF-type laws nu_{eta_x}, |eta_x| <= 6 beta, and
# the even-site marginal has Dobrushin row sum  alpha_sigma(beta) = 30 * C_med(beta)  (no direct terms; WORK.md 7.1), C_med exactly
# THE GROUND's (SU(2), exact constants D5, T6) or MG2's (every group, Lemma NH).  Certified (mpmath intervals): the largest 4-decimal beta
# with alpha_sigma < 1.  Beside it: Bakry-Emery on the even marginal, K_sigma = Ric - 36 sbar(6b) b^2/d - 6 b mubar(6b) theta/sqrt(d).
import sys
from decimal import Decimal
sys.path.insert(0, sys.argv[1])
from mpmath import iv, mp
import mg2_general_eval as GE
import mg2_su2_eval as S2
import pairing_eval as PE
iv.prec = 200

def alpha_sigma_su2(beta):
    R = S2.alpha_su2(beta, 'EXACT')
    return R['med90'] / 3, R

def alpha_sigma_gen(g, beta):
    al, det = GE.alpha_G(g, beta)
    return det['Cmed90'] / 3, det

def K_sigma(g, beta, su2sharp=False):
    E = PE.be_K0(g, beta, su2sharp)
    b = iv.mpf(beta); d = iv.mpf(g['d'])
    return E['Ric'] - 36 * E['sb'] * b * b / d - 6 * b * E['mb'] * E['th'] / iv.sqrt(d)

if __name__ == '__main__':
    mode = sys.argv[2]
    G = GE.group_table()
    if mode == 'su2':
        ok = lambda beta: mp.mpf(alpha_sigma_su2(beta)[0].b) < 1
        b = PE.largest(ok, '0.30', '0.1')
        a, R = alpha_sigma_su2(str(b)); a2, R2 = alpha_sigma_su2(str(b + Decimal('0.0001')))
        print('SU(2) EXACT: alpha_sigma = 30 C_med < 1 certified up to beta^DF = %s (alpha_sigma = %s; omega=%s rho=%s D5=%s T6=%s); at %s: %s' % (
            b, PE.f(a, 8), PE.f(R['omega'], 5), PE.f(R['rho'], 6), PE.f(R['D5'], 6), PE.f(R['T6'], 6), b + Decimal('0.0001'), PE.f(a2, 8)))
        okk = lambda beta: mp.mpf(K_sigma(G[0], beta, True).a) > 0
        bk = PE.largest(okk, '0.05', '0.01')
        print('SU(2) EXACT: Bakry-Emery on the even marginal K_sigma > 0 certified up to %s (K = %s)' % (bk, PE.f(K_sigma(G[0], str(bk), True), 6)))
        for beta in ['0.2452', '0.30', '0.40', '0.45', '0.50']:
            a, R = alpha_sigma_su2(beta)
            print('   SU(2) EXACT beta=%s: alpha_sigma=%s  (Theorem 8.7 bulk alpha=%s)' % (beta, PE.f(a, 7), PE.f(R['alpha'], 7)))
            sys.stdout.flush()
    else:
        for g in G:
            ok = lambda beta, g=g: mp.mpf(alpha_sigma_gen(g, beta)[0].b) < 1
            b = PE.largest(ok, '0.01', '0.01')
            okk = lambda beta, g=g: mp.mpf(K_sigma(g, beta).a) > 0
            bk = PE.largest(okk, '0.001', '0.01')
            hk = mp.mpf(g['hk'].numerator) / g['hk'].denominator
            bstar = GE.certified_root(g)
            cen = {'SU(2)': 'Z2', 'SU(3)': 'Z3', 'SU(4)': 'Z4', 'SU(5)': 'Z5', 'Sp(2)': 'Z2', 'SO(6)': 'Z2', 'SO(8)': 'Z2', 'E6': 'Z3', 'E7': 'Z2'}.get(g['name'], 'trivial')
            print('%-6s centre %-7s beta^DF(Dobrushin, sigma)=%s  beta^DF(BE, sigma)=%s | CNS hk/48=%s | Thm 8.7_G beta*=%s | ratio DF/CNS=%s' % (
                g['name'], cen, b, bk, mp.nstr(hk / 48, 5), bstar, mp.nstr(mp.mpf(str(max(b, bk))) / (hk / 48), 4)))
            sys.stdout.flush()
