# kp_reach2.py -- fast version of kp_reach.py: a_j precomputed once per beta, alpha scanned on a grid.
import math, sys
def bessel_I(n, x, terms=60):
    s = 0.0; t = (x/2.0)**n / math.factorial(n)
    for k in range(terms):
        s += t; t *= (x/2.0)**2 / ((k+1)*(k+1+n))
    return s
W2 = {6: 16.0, 10: 240.0, 12: 320.0, 14: 4368.0, 16: 10888.0, 18: 94032.0}
for e in sys.argv[1:]:
    f, v = e.split(':'); W2[int(f)] = float(v)
F0 = max(W2)
def prep(beta):
    I1 = bessel_I(1, beta); a = [bessel_I(tj+1, beta)/I1 for tj in range(0, 12)]
    return a
def S(a, alpha, mu):
    u = a[1]
    def spin(F):
        return 1.0 + sum((a[tj]/u)**F * ((tj+1)/2.0)**2 for tj in range(2, 12))
    tot = sum(3.0*w*u**F*math.exp(2*alpha*F)*spin(F) for F, w in W2.items())
    r = mu*u*math.exp(2*alpha)
    if r >= 1.0: return float('inf')
    return tot + 3.0*4.0/mu * r**(F0+1)/(1.0-r) * spin(F0+1)
def holds(beta, mu):
    a = prep(beta)
    for k in range(1, 3001):
        al = k*2e-4
        s = S(a, al, mu)
        if s <= al: return True, al, s, a[1]
    return False, None, None, a[1]
def reach(mu):
    lo, hi = 0.05, 2.5
    for _ in range(32):
        mid = 0.5*(lo+hi)
        if holds(mid, mu)[0]: lo = mid
        else: hi = mid
    return lo
print("# enumerated through F0 =", F0)
for mu in (5.0, 4.0, 3.0, 2.5):
    b = reach(mu); ok, al, s, u = holds(b, mu)
    print("tail mu = %.1f : KP (branch-free part) holds to beta = %.4f  u = %.4f  alpha = %.4f  S = %.3e" % (mu, b, u, al, s))
