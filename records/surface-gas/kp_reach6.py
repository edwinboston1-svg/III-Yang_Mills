# kp_reach5.py -- THE FOLD-IN (S1 section 14): the Kotecky-Preiss reach of the full polymer system with every
# input named by the lemma that supplies it.  Status of each input is printed; the number is CONDITIONAL on the
# inputs marked STAKED and is never a theorem until each is proved on the page.
#
# Polymers: closed link-connected plaquette sets with admissible spins, incompatible when they share a link.
# KP holds if, for every link, sum over polymers through it of |W| e^{alpha |L|} <= alpha  (a(X) = alpha |L(X)|).
# The sum is organised as:  LEAVES (Z2-minimal all-1/2 sets) x DRESSING (integer-spin pieces, every level)
#                           composed by the TREE (forest gluings exact, cycle gluings at cost 2).
#
#   LEAVES through a link, size F:
#     surfaces N(F) enumerated to F0 (surf.c, two roads; PROVED), weight u^F 2^chi (S2) summed over the single
#       spin with the spin factor (PROVED); the tail N(F) <= 5^(F-1) (closing tree; PROVED) at weight <= 4 u^F (S11);
#     contact leaves (pinches, double contacts, ...) enumerated at F = 18, 20 (iii-38; count), weight <= 4 u^F
#       (S12: STAKED -- read 4 on every one to F = 20; the tail's 5^(F-1) counts them (Lemma P; iii-38, to be read)).
#   DRESSING factor e^{kappa |X|} per leaf plaquette, kappa the least root of
#       kappa = 2 z1 e^kappa + sum_{s>=2} 20 5^(s-1) z_s e^{kappa s}        (iii-38's dressing lemma 16.65: STAKED until read)
#     with z1 = e^{2 alpha} sum_{j>=1} d_j a_j             (lone walls: S7 exact, S8 |r| <= 1: PROVED, orientable rests)
#          z_s = e^{2 alpha s} sum_j d_j a_j^s             (surface pieces: S9, PROVED, orientable rests)
#          plus branched pieces: K * e^{2 alpha s} sum_j d_j a_j^s at count 20 5^(s-1) (S13: STAKED, K = 2 the tripod's value)
#     The e^{2 alpha} per piece plaquette pays its off-rest links in the KP weight.
#   TREE: per link the load is alpha + T (forest, S3) + 2T (cycle sites <= 2|X| at cost 2, S4': PROVED orientable;
#     non-orientable rests: A1, STAKED, none to F = 20); KP iff s(4 alpha) <= alpha  (kappa_tree = 4).
import math, sys, os
def bessel_I(n, x, terms=80):
    s = 0.0; t = (x/2.0)**n / math.factorial(n)
    for k in range(terms):
        s += t; t *= (x/2.0)**2 / ((k+1)*(k+1+n))
    return s
NSURF = {6: 4.0, 10: 60.0, 12: 80.0, 14: 1092.0, 16: 2728.0, 18: 23508.0, 20: 80480.0, 22: 551408.0}   # through a plaquette
NCONT = {18: 576.0, 20: 4800.0}                                                                        # contact leaves (pinches 576; 3840 + 960)
F0 = int(os.environ.get("F0", "20"))                       # the tail starts after the last size where ALL leaves are enumerated
GTABLE = [float(x) for x in os.environ.get("GTABLE", "3,1.7321,3.4641,5.6577,6.7349,7.8103,8.6101,9.2673").split(",")]   # gamma(s) for s = 1..7, then gamma(s >= 8): THE JUNCTION THEOREM v1 (S1 section 21): N(Y) <= prod_v sqrt(e(deg_T v)) * 3^k, e(d) = (3^d + 3(-1)^d)/(4 3^(d/2)); degrees <= min(8, s), k = 0 below 9, the joint max 3.09 per plaquette
def gam(s): return GTABLE[min(s, 8) - 1]
MU = float(os.environ.get("MU", "5.0"))                    # the tail branching (5 proved)
KTREE = float(os.environ.get("KTREE", "4.0"))
def prep(beta):
    I1 = bessel_I(1, beta)
    return [bessel_I(tj+1, beta)/I1 for tj in range(0, 14)]       # a[tj] = a_{j}, tj = 2j
def kappa_dress(a, alpha):
    u = a[1]
    z1 = math.exp(2*alpha)*sum((tj+1)*a[tj] for tj in range(2, 14, 2))
    def zs(s): return math.exp(2*alpha*s)*sum((tj+1)*a[tj]**s for tj in range(2, 14, 2))
    def zbr(s): return (gam(s)*a[2]*math.exp(2*alpha))**s          # the junction theorem v1: no prefactor, gamma graded by size
    def g(k):                                                         # iii-38's dressing lemma 16.65-a: roots 8|U|, 5^(s-1) per root
        v = 2*z1*math.exp(k)
        for s in range(2, 80):
            term = 8*5.0**(s-1)*max(zs(s), zbr(s) if s >= 2 else 0.0)*math.exp(k*s)
            v += term
            if term < 1e-18: break
        return v
    # least root of k = g(k) by iteration from 0 (g increasing, convex); refuse if it runs away
    k = 0.0
    for _ in range(200):
        kn = g(k)
        if not (kn < 5.0): return float('inf')
        if abs(kn - k) < 1e-13: return kn
        k = kn
    return k
def leaf_sum(a, alpha, kap):
    u = a[1]
    ue = u*math.exp(kap)                                     # the dressed leaf weight per plaquette
    def spin(F):                                             # the single higher spin of a surface, relative to 1/2
        return 1.0 + sum((a[tj]/u)**F*((tj+1)/2.0)**2 for tj in range(2, 14))
    tot = 0.0
    for F, w in NSURF.items():
        if F <= F0: tot += 3.0*w*ue**F*math.exp(2*alpha*F)*spin(F)        # 3 = links per plaquette-count conversion (sum through a link = 3x through a plaquette)
    for F, w in NCONT.items():
        if F <= F0: tot += 3.0*w*4.0*ue**F*math.exp(2*alpha*F)
    r = MU*ue*math.exp(2*alpha)
    if r >= 1.0: return float('inf')
    tot += 3.0*(4.0/MU)*r**(F0+1)/(1.0-r)*spin(F0+1)
    return tot
def holds(beta, alpha):
    a = prep(beta)
    kap = kappa_dress(a, KTREE*alpha)
    if kap == float('inf'): return False, kap
    return leaf_sum(a, KTREE*alpha, kap) <= alpha, kap
def reach():
    lo, hi = 0.05, 2.5
    best = None
    for _ in range(30):
        mid = 0.5*(lo+hi); ok = False
        for k in range(1, 2001):
            al = k*2e-4
            h, kap = holds(mid, al)
            if h: ok = True; best = (mid, al, kap); break
        if ok: lo = mid
        else: hi = mid
    return lo, best
b, best = reach()
a = prep(b)
print("# kp_reach6: F0 = %d, MU = %.2f, KTREE = %.0f, GTABLE = %s" % (F0, MU, KTREE, GTABLE))
print("KP holds to beta = %.4f   u = %.4f  a1 = %.5f  alpha = %.4f  kappa_dress = %.4f" % (b, a[1], a[2], best[1], best[2]))
