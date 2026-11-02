# MG2 su2_eval.py -- THE KNOWN ANSWER: Theorem 8.7's row sum (8.12) for SU(2), in mpmath interval arithmetic (outward rounding),
# sharing no line with THE GROUND's aperanton_decimation_cert.awk.  Two constant sets:
#   L86  : Lemma 8.6's bounds  D5 = m(5b)^2/3,  T6 = m(6b)/2,  covariance norm 1/4,  MAD 4/(3 pi)
#   EXACT: D5 = sup_{r<=5b} |D(r)|,  T6 = sup_{r<=6b, c in [0,1]} |phi'''(r) c^3 + 3 (D(r)/r) c (1-c^2)|  (the largest third cumulant),
#          enclosed on an interval grid of r (each cell's enclosure is an interval evaluation over the whole cell: certified sup).
# Bessel I_1, I_2 by their series with a geometric tail bound, all in iv.
import sys
from mpmath import iv, mp
iv.prec = 256

def bessel_I(nu, r):
    # r: iv interval with r.a >= 0.  I_nu(r) = sum_k (r/2)^(2k+nu)/(k!(k+nu)!).  Tail after K terms bounded by term_K*q/(1-q).
    h = r / 2
    h2 = h * h
    t = h ** nu
    for j in range(1, nu + 1):
        t = t / j
    s = iv.mpf(0)
    K = 60
    for k in range(K):
        s = s + t
        t = t * h2 / ((k + 1) * (k + 1 + nu))
    # remaining terms from k = K: t is term_K (an interval); ratio bound q = h2.b/((K+1)(K+1+nu))
    q = iv.mpf(h2.b) / ((K + 1) * (K + 1 + nu))
    assert q.b < 0.5
    tail = t * (1 / (1 - q))
    s = s + iv.mpf([0, tail.b])
    return s

def m_of(r):
    return bessel_I(2, r) / bessel_I(1, r)

def zseries(coef, z, K=40):
    # sum_k coef(k) z^k for an interval z >= 0, positive terms; tail after K terms by a geometric bound on the term ratio
    s = iv.mpf(0)
    for k in range(K):
        s = s + coef(k) * z ** k
    tK = coef(K) * z ** K
    q = coef(K + 1) / coef(K) * iv.mpf(z.b)          # ratio of consecutive coefficients is decreasing in k for A, B, P below
    assert q.b < 0.5
    return s + iv.mpf([0, (tK * (1 / (1 - q))).b])

from math import factorial as _f
def cA(k): return iv.mpf(1) / (_f(k) * _f(k + 2))
def cB(k): return iv.mpf(1) / (_f(k) * _f(k + 1))
def cP(k): return iv.mpf(_f(4 + 2 * k)) / (_f(k) * _f(4 + k) * _f(2 + k) * _f(3 + k))   # A^2 - BC = P(z) (THE GROUND's Turan coefficients)

def phis_regular(r):
    # THE GROUND's variables: z = r^2/4, A = (2/r)^2 I_2, B = (2/r) I_1, A^2 - BC = P(z) > 0.  All regular at r = 0:
    #   m = r A/(2B);  phi'' = 1/4 - z (A^2 + 3P)/(4 B^2);  D = -z P/B^2;  D/r = -(r/4) P/B^2;  phi''' = r [ (3/4) P/B^2 - (A/B) phi'' ]
    z = r * r / 4
    A = zseries(cA, z); B = zseries(cB, z); P = zseries(cP, z)
    m = r * A / (2 * B)
    p2 = iv.mpf(1) / 4 - z * (A * A + 3 * P) / (4 * B * B)
    D = -z * P / (B * B)
    Dr = -(r / 4) * P / (B * B)
    p3 = r * ((iv.mpf(3) / 4) * P / (B * B) - (A / B) * p2)
    return m, p2, D, Dr, p3

def phis(r):
    m, p2, D, Dr, p3 = phis_regular(r)
    return m, p2, D, p3

def cum3_max(r):
    # sup over c in [0,1] of |phi''' c^3 + 3 (D/r) c (1-c^2)| on the interval r: grid in c with cell enclosures
    # kappa(c) = c (a + b c^2), a = 3 D/r, b = phi''' - 3 D/r; on a c-cell [c1, c2] it is c times a function LINEAR in s = c^2, so
    # |kappa| <= c2 * max(|a + b s1|, |a + b s2|) with a, b intervals (no dependency loss)
    m, p2, D, Dr, p3 = phis_regular(r)
    a = 3 * Dr; bb = p3 - 3 * Dr
    best = iv.mpf(0)
    N = 256
    for i in range(N):
        c1 = iv.mpf(mp.mpf(i) / N); c2 = iv.mpf(mp.mpf(i + 1) / N)
        v1 = abs(a + bb * c1 * c1); v2 = abs(a + bb * c2 * c2)
        hi = c2 * iv.mpf(max(mp.mpf(v1.b), mp.mpf(v2.b)))
        if hi.b > best.b:
            best = iv.mpf(hi.b)
    return best

def sup_over_r(f, R, cells=600, r0=0):
    # certified sup over r in (0, R] of f(r) (f returns a nonnegative interval); the cell [0, r0] handled by continuity bound
    best = iv.mpf(0)
    edges = [mp.mpf(r0) + (mp.mpf(R) - mp.mpf(r0)) * i / cells for i in range(cells + 1)]
    for i in range(cells):
        r = iv.mpf([edges[i], edges[i + 1]])
        v = f(r)
        if v.b > best.b:
            best = iv.mpf(v.b)
    return best

PI = iv.pi

def alpha_su2(beta, mode):
    b = iv.mpf(str(beta)) if isinstance(beta, str) else iv.mpf(beta)   # a decimal string is enclosed exactly
    m5 = m_of(5 * b)
    if mode == 'L86':
        D5 = m5 * m5 / 3
        T6 = m_of(6 * b) / 2
    else:
        D5 = sup_over_r(lambda r: abs(phis(r)[2]), mp.mpf((5 * b).b))
        T6 = sup_over_r(cum3_max, mp.mpf((6 * b).b))
    om = 3 * b ** 2 * D5 + 2 * b ** 3 * T6
    rho = (3 * iv.exp(om) - 1) / 2
    Cdir = rho * (4 * b / (3 * PI)) * m5 + (b ** 2 * D5 + (iv.mpf(2) / 3) * b ** 3 * T6) / 4
    mn = b ** 2 * D5 if (b ** 2 * D5).b <= (2 * b ** 3 * T6).a else (2 * b ** 3 * T6 if (2 * b ** 3 * T6).b <= (b ** 2 * D5).a else iv.mpf([min((b**2*D5).a, (2*b**3*T6).a), max((b**2*D5).b, (2*b**3*T6).b)]))
    Cmed = rho * b ** 2 / (3 * PI) + (mn + (iv.mpf(2) / 3) * b ** 3 * T6) / 4
    al = 12 * Cdir + 90 * Cmed
    return dict(alpha=al, dir12=12 * Cdir, med90=90 * Cmed, omega=om, rho=rho, D5=D5, T6=T6, m5=m5)

def fmt(x, n=8):
    lo = mp.mpf(x.a.a); hi = mp.mpf(x.b.b)
    return '[%s, %s]' % (mp.nstr(lo, n), mp.nstr(hi, n))

def root(mode, lo, hi, step):
    # largest grid point beta (step) in [lo, hi] with certified alpha < 1 (alpha increasing in beta)
    from decimal import Decimal
    b = Decimal(lo); last = None
    while b <= Decimal(hi) + Decimal(step) / 10:
        R = alpha_su2(str(b), mode)
        if mp.mpf(R['alpha'].b.b) < 1: last = b
        else: break
        b += Decimal(step)
    return last, b

if __name__ == '__main__':
    mode = sys.argv[1] if len(sys.argv) > 1 else 'L86'
    if len(sys.argv) > 2 and sys.argv[2] == 'root':
        last, first_fail = root(mode, sys.argv[3], sys.argv[4], sys.argv[5])
        print('%s ROOT: certified alpha < 1 at beta = %s; first grid point not certified: %s' % (mode, last, first_fail))
        sys.exit(0)
    for beta in ['0.200', '0.220', '0.230', '0.240', '0.241', '0.2415', '0.245', '0.2452', '0.2455', '0.246', '0.247']:
        R = alpha_su2(beta, mode)
        print('%s beta=%s alpha=%s 12Cdir=%s 90Cmed=%s omega=%s rho=%s D5=%s T6=%s' % (mode, beta, fmt(R['alpha']), fmt(R['dir12'], 7), fmt(R['med90'], 7), fmt(R['omega'], 6), fmt(R['rho'], 7), fmt(R['D5'], 6), fmt(R['T6'], 6)))
        sys.stdout.flush()
