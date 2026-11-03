# MPAIR dfpath.py -- THE DF PATH as one code (WORK.md §16): the theorem's input alpha_sigma (the Dobrushin row of the checkerboard-decimated
# slab sigma-model) for SU(2) Wilson, compact U(1) Wilson and Villain U(1), two-sided:
#   R+ : certified UPPER bound 30*C_med (SU(2): THE GROUND's exact constants via MG2's su2_eval EXACT; U(1): MG2's Theorem 8.7_G constants with a
#        U(1) entry n=2, t3=o3=c3=0, t4=m4=3/8).  Villain: no R+ (its one-link family is not an exponential family in u).
#   R- : COMPUTED LOWER bound of the TRUE row, sum over the 18 even sites at distance 2 of the TV between the even site's conditional laws at an
#        exhibited pair of configurations: 6 axis positions (one shared odd site, a single flip) and 12 diagonal positions (two shared odd
#        sites, flipped together by the centre element -1).  Wilson witnesses: every other contribution to the odd sites cancels exactly
#        (unit vectors summing to zero), so the TV is EXACTLY (A-B)/(A+B) of two one-dimensional integrals, enclosed by interval Riemann sums.
#        Villain witness: balanced environments (4-fold at the shared odd site, 5-fold at the others); the even site's density is a product of
#        trigonometric polynomials (the Villain weight truncated at |k| <= K, tail bounded), and TV >= |E_p cos - E_q cos|/2 from exact Fourier
#        coefficients (no quadrature).
# Verdicts (campaign §28.3): CERTIFIED if R+ < 1; REFUSED if R+ >= 1 (marked 'row' when R- >= 1 too: the row itself reads above one);
# a reading whose path failed a tooth prints UNVALIDATED.
import sys
from decimal import Decimal
sys.path.insert(0, sys.argv[1])
from mpmath import iv, mp, mpf
import mg2_su2_eval as S2
import mg2_general_eval as GE
iv.prec = 96
mp.dps = 40

# ---------- series in z = r^2/4 (regular at 0, positive terms, geometric tail bound) ----------
def zser(z, kind, K=60):
    # kind 'Z2' : 2 I_1(r)/r = sum z^k/(k!(k+1)!) ;  kind 'I0' : I_0(r) = sum z^k/(k!)^2
    s = iv.mpf(0); t = iv.mpf(1)
    for k in range(K):
        s = s + t
        t = t * z / ((k + 1) * ((k + 2) if kind == 'Z2' else (k + 1)))
    q = iv.mpf(z.b) / ((K + 1) * (K + 1))
    assert q.b < 0.5
    return s + iv.mpf([0, (t / (1 - q)).b])

def wilson_tv(beta, kind, power, N=1600):
    # SU(2) (kind Z2, weight sin^2 phi on phi in [0, pi/2], c = cos phi) / U(1) (kind I0, weight 1):
    # D = int [F(z+)^power - F(z-)^power] w dphi,  S = int [F(z+)^power + F(z-)^power] w dphi,  z+- = beta^2 (1 +- cos phi)/2;  TV = D/S
    b = iv.mpf(beta)
    D = iv.mpf(0); S = iv.mpf(0)
    h = iv.pi / 2 / N
    for i in range(N):
        ph = iv.mpf([(iv.pi / 2 * i / N).a, (iv.pi / 2 * (i + 1) / N).b])
        c = iv.cos(ph)
        zp = b * b * (1 + c) / 2; zm = b * b * (1 - c) / 2
        Fp = zser(zp, kind) ** power; Fm = zser(zm, kind) ** power
        w = iv.sin(ph) ** 2 if kind == 'Z2' else iv.mpf(1)
        D = D + h * (Fp - Fm) * w
        S = S + h * (Fp + Fm) * w
    return D / S

def villain_coeffs(bV, K):
    # w_V(x) = sum_n exp(-(bV/2)(x - 2 pi n)^2) = (2 pi bV)^(-1/2) sum_k exp(-k^2/(2 bV)) e^{ikx}; constants dropped (they cancel)
    return {k: mp.e ** (-mpf(k * k) / (2 * bV)) for k in range(-K, K + 1)}

def trig_mul(a, b, cap):
    out = {}
    for i, x in a.items():
        for j, y in b.items():
            k = i + j
            if abs(k) <= cap: out[k] = out.get(k, 0) + x * y
    return out

def shifted(v, a):
    # coefficients of w(theta - a): v_k e^{-ika}
    return {k: c * mp.expj(-k * a) for k, c in v.items()}

def odd_factor(g, v):
    # Z(alpha) = (1/2pi) int w(theta - alpha) g(theta) dtheta with g(theta) = sum_m g_m e^{im theta} and w(x) = sum_k v_k e^{ikx}:
    # (1/2pi) int e^{ik(theta - alpha)} e^{im theta} dtheta = [k = -m] e^{im alpha}, so Z(alpha) = sum_m g_m v_{-m} e^{im alpha} (|m| <= K)
    return {m: gm * v[-m] for m, gm in g.items() if -m in v}

def villain_tv(bV, diagonal, K=48):
    v = villain_coeffs(bV, K)
    # shared odd site(s): neighbours w (variable alpha), w' at phi', and 4 balanced others at j*pi/2
    def shared_factor(phip):
        g = shifted(v, phip)
        for j in range(4):
            g = trig_mul(g, shifted(v, mp.pi * j / 2), 6 * K)
        return odd_factor(g, v)
    # the other odd neighbours of w: 5 balanced others at 2 pi j/5
    g5 = {0: mpf(1)}
    for j in range(5):
        g5 = trig_mul(g5, shifted(v, 2 * mp.pi * j / 5), 6 * K)
    other = odd_factor(g5, v)
    nshared = 2 if diagonal else 1
    def density(phip):
        f = {0: mpf(1)}
        sf = shared_factor(phip)
        for _ in range(nshared): f = trig_mul(f, sf, 12 * K)
        for _ in range(6 - nshared): f = trig_mul(f, other, 12 * K)
        return f
    def Ecos(f):
        # density in alpha: sum_k f_k e^{ik alpha}; E[e^{i alpha}] = f_{-1}/f_0
        return (f.get(-1, 0) / f[0]).real
    p = density(mpf(0)); q = density(mp.pi)
    return abs(Ecos(p) - Ecos(q)) / 2, Ecos(p), Ecos(q)

def u1_group():
    return dict(name='U(1)', type='C', d=1, n=2, dimG=1, C2=Fr(0), h=0, t3=Fr(0), t4=Fr(3, 8), o3=Fr(0), m4=Fr(3, 8), c3exact=Fr(0),
                antisym=False, M3=None, T=Fr(1), kappa=Fr(1), hk=Fr(0))

from fractions import Fraction as Fr

def Rplus(group, beta):
    if group == 'SU2':
        R = S2.alpha_su2(beta, 'EXACT'); return R['med90'] / 3
    if group == 'U1':
        al, det = GE.alpha_G(u1_group(), beta); return det['Cmed90'] / 3
    return None

def Rminus(group, beta=None, bV=None):
    if group in ('SU2', 'U1'):
        kind = 'Z2' if group == 'SU2' else 'I0'
        t1 = wilson_tv(beta, kind, 1); t2 = wilson_tv(beta, kind, 2)
        return 6 * t1 + 12 * t2, t1, t2
    t1, a1, b1 = villain_tv(bV, False); t2, a2, b2 = villain_tv(bV, True)
    return 6 * t1 + 12 * t2, t1, t2

def lo(x): return mp.mpf(x.a) if hasattr(x, 'a') else mp.mpf(x)
def hi(x): return mp.mpf(x.b) if hasattr(x, 'b') else mp.mpf(x)
def fm(x, k=7): return mp.nstr(hi(x) if hasattr(x, 'b') else x, k)

def verdict(rp, rm):
    if rp is not None and hi(rp) < 1: return 'CERTIFIED'
    tag = 'row' if (rm is not None and lo(rm) >= 1) else 'bound'
    return 'REFUSED(%s)' % tag

def largest_certified(group, lo0, step0):
    b = Decimal(lo0); step = Decimal(step0)
    if hi(Rplus(group, str(b))) >= 1: return None
    while True:
        nb = b + step
        if hi(Rplus(group, str(nb))) < 1: b = nb
        else:
            if step <= Decimal('0.0001'): break
            step = step / 10
    return b

def smallest_refuted(group, lo0, hi0):
    a = Decimal(lo0); b = Decimal(hi0)
    assert lo(Rminus(group, str(b))[0]) >= 1 and lo(Rminus(group, str(a))[0]) < 1
    while b - a > Decimal('0.0005'):
        m = ((a + b) / 2).quantize(Decimal('0.0001'))
        if lo(Rminus(group, str(m))[0]) >= 1: b = m
        else: a = m
    return a, b

if __name__ == '__main__':
    mode = sys.argv[2]
    if mode == 'watson':
        # Glasser-Zucker's closed form is for W_s = pi^-3 int dk / (1 - (cos k1 + cos k2 + cos k3)/3) = 3 W3 (run 2026-11-02a printed W_s, labelled W3)
        Ws = mp.sqrt(6) / (32 * mp.pi ** 3) * mp.gamma(mpf(1) / 24) * mp.gamma(mpf(5) / 24) * mp.gamma(mpf(7) / 24) * mp.gamma(mpf(11) / 24)
        W = Ws / 3
        W2 = mp.quad(lambda t: mp.e ** (-3 * t) * mp.besseli(0, t) ** 3, [0, 1, 10, 100, mp.inf])
        print('W_s (Gamma closed form, Glasser-Zucker) = %s ; W3 = W_s/3 = %s ; W3 = int_0^inf e^{-3t} I0(t)^3 dt = %s ; |diff| = %s' % (mp.nstr(Ws, 15), mp.nstr(W, 15), mp.nstr(W2, 15), mp.nstr(abs(W - W2), 3)))
        print('FSS long-range-order thresholds of the identity-datum slab sigma-model: SU(2)/O(4): beta > 2 W3 = %s ; U(1)/O(2): beta > W3 = %s' % (mp.nstr(2 * W, 10), mp.nstr(W, 10)))
    elif mode == 'teeth':
        out = []
        # T0: the strong side, and the 0.4924 route reproduced
        for beta in ['0.2452', '0.4924', '0.4925']:
            rp = Rplus('SU2', beta); rm = Rminus('SU2', beta)
            print('SU(2) Wilson beta=%s : R+ = %s  R- = %s (TV1 %s, TV2 %s)  %s  [R- <= R+: %s]' % (beta, fm(rp, 8), mp.nstr(lo(rm[0]), 8),
                  mp.nstr(lo(rm[1]), 6), mp.nstr(lo(rm[2]), 6), verdict(rp, rm[0]), hi(rm[0]) <= hi(rp)))
            sys.stdout.flush()
        # T1: compact U(1) at 1.2 and Villain at 2, 4, 8
        rp = Rplus('U1', '1.2'); rm = Rminus('U1', '1.2')
        print('U(1) Wilson beta=1.2 : R+ = %s  R- = %s (TV1 %s, TV2 %s)  %s' % (fm(rp, 6), mp.nstr(lo(rm[0]), 8), mp.nstr(lo(rm[1]), 6), mp.nstr(lo(rm[2]), 6), verdict(rp, rm[0])))
        sys.stdout.flush()
        for bV in [2, 4, 8]:
            rm = Rminus('V', bV=bV)
            print('U(1) Villain beta_V=%d : R+ = (none: not an exponential one-link family)  R- = %s (TV1 >= %s, TV2 >= %s)  %s' % (bV, mp.nstr(rm[0], 8), mp.nstr(rm[1], 6), mp.nstr(rm[2], 6), verdict(None, rm[0])))
            sys.stdout.flush()
    elif mode == 'thresholds':
        bs = largest_certified('U1', '0.05', '0.05')
        print('U(1) Wilson: R+ < 1 CERTIFIED up to beta = %s (R+ = %s); at %s: R+ = %s' % (bs, fm(Rplus('U1', str(bs)), 8), bs + Decimal('0.0001'), fm(Rplus('U1', str(bs + Decimal('0.0001'))), 8)))
        sys.stdout.flush()
        a, b = smallest_refuted('U1', '0.2', '1.2')
        print('U(1) Wilson: R- >= 1 (row above one, COMPUTED) from beta = %s; below at %s (R- = %s / %s)' % (b, a, mp.nstr(lo(Rminus('U1', str(b))[0]), 8), mp.nstr(lo(Rminus('U1', str(a))[0]), 8)))
        sys.stdout.flush()
        a, b = smallest_refuted('SU2', '0.4', '2.2')
        print('SU(2) Wilson: R- >= 1 (row above one, COMPUTED) from beta = %s; below at %s (R- = %s / %s)' % (b, a, mp.nstr(lo(Rminus('SU2', str(b))[0]), 8), mp.nstr(lo(Rminus('SU2', str(a))[0]), 8)))
        sys.stdout.flush()
    elif mode == 'su2cross':
        # the SU(2) witnessed-row crossing with a coarser interval Riemann sum (N cells): still a rigorous LOWER bound (wider enclosure)
        N = int(sys.argv[3]); a = Decimal(sys.argv[4]); b = Decimal(sys.argv[5])
        def Rm(beta): return 6 * wilson_tv(beta, 'Z2', 1, N) + 12 * wilson_tv(beta, 'Z2', 2, N)
        ra = Rm(str(a)); rb = Rm(str(b))
        print('SU(2) su2cross N=%d: R-(%s) in [%s, %s], R-(%s) in [%s, %s]' % (N, a, mp.nstr(lo(ra), 8), mp.nstr(hi(ra), 8), b, mp.nstr(lo(rb), 8), mp.nstr(hi(rb), 8)))
        sys.stdout.flush()
        assert lo(rb) >= 1 and hi(ra) < 1
        while b - a > Decimal('0.0005'):
            m = ((a + b) / 2).quantize(Decimal('0.0001'))
            rm = Rm(str(m))
            if lo(rm) >= 1: b = m
            elif hi(rm) < 1: a = m
            else:
                print('   enclosure straddles one at %s: [%s, %s]; stop' % (m, mp.nstr(lo(rm), 8), mp.nstr(hi(rm), 8))); break
            sys.stdout.flush()
        print('SU(2) Wilson: R- >= 1 (row above one, COMPUTED, N=%d) at beta = %s; R- < 1 (enclosure) at %s' % (N, b, a))
    elif mode == 'reading':
        for beta in ['2.2']:
            rp = Rplus('SU2', beta); rm = Rminus('SU2', beta)
            print('SU(2) Wilson beta=%s (height-1 row = the one-straight-path-step row by Lemma COMP): R+ = %s  R- = %s (TV1 %s, TV2 %s)  %s' % (
                beta, mp.nstr(hi(rp), 6), mp.nstr(lo(rm[0]), 8), mp.nstr(lo(rm[1]), 6), mp.nstr(lo(rm[2]), 6), verdict(rp, rm[0])))
