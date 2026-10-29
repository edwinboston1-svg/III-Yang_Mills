# kp_reach3.py -- KP reach with the composite-tree shift.  Composite polymers (unions of
# irreducible pieces glued along links) are bounded by the tree generating function
# T = s_irr(alpha + T); the KP condition becomes s_irr(alpha + T) <= T <= alpha, and with
# T = alpha it reads s_irr(2 alpha) <= alpha.  Here s_irr is the branch-free part only
# (irreducible branched pieces are R1's open item), so this is the reach of
# "branch-free pieces + all their forest gluings".
import math, sys
exec(open('kp_reach2.py').read().split('def holds')[0])   # reuse bessel, W2, prep, S
def holds_comp(beta, mu):
    a = prep(beta)
    for k in range(1, 3001):
        al = k*2e-4
        if S(a, 2*al, mu) <= al: return True, al, a[1]
    return False, None, a[1]
def reach_comp(mu):
    lo, hi = 0.05, 2.5
    for _ in range(32):
        mid = 0.5*(lo+hi)
        if holds_comp(mid, mu)[0]: lo = mid
        else: hi = mid
    return lo
for mu in (5.0, 4.0, 3.0, 2.5):
    b = reach_comp(mu); ok, al, u = holds_comp(b, mu)
    print("tail mu = %.1f : KP with composite shift holds to beta = %.4f  u = %.4f  alpha = %.4f" % (mu, b, u, al))
