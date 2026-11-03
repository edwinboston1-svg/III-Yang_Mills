"""UV1 item 3: a known-answer test of Theorem K on an exactly solvable NONABELIAN blocking — 2D SU(2) Wilson lattice gauge theory,
an L x L block of plaquettes blocked into one coarse plaquette (exact: the coarse weight is the L^2-fold convolution of the fine one).

 w'(theta) = sum_d A_d chi_d(theta),  A_d = a_d(beta)^{L^2} d^{1-L^2},  a_d(x) = 2 d I_d(x)/x;   chi_d''(0) = -d(d^2-1)/3,
 beta' := -w''(0)/w(0) = (1/3) sum_d A_d d (d^2-1) / sum_d A_d d      (the coarse coupling: S'(U) = beta'(1 - 1/2 tr U) + O(theta^4)).
Tree beta/L^2; desk one loop h(0) = -1/3 - 1/(2L^2); h(u) := beta'(1/u) - 1/(u L^2), u = 1/beta = zeta^2.
Theorem K: |Delta(beta)| = |h(u) - h(0)| <= A2(u) u with A2(u) = sup_{v<=u} |h'(v) + 2 v h''(v)| (= (1/2) d^2/dzeta^2 of h(zeta^2));
the mean-value form in u: |h(u) - h(0)| <= u sup_{v<=u}|h'(v)|.  READINGS (mpmath, 40 digits; the sums converge geometrically).
Run: python -u -E -P code/uv1_k2d.py > rec/k2d.<date>.txt
"""
import mpmath as m
from mpmath import mp, mpf

mp.dps = 40


def ratios(x, D):
    """rho_d = I_d(x)/I_1(x), d = 1..D, by Miller's backward recurrence (I_n is the minimal solution as n grows)."""
    N = int(D + x + 40 * m.sqrt(x) + 200)
    ip1 = mpf(0)
    i0 = mpf(10) ** (-300)
    vals = {}
    for n in range(N, 0, -1):
        im1 = ip1 + (2 * n / x) * i0      # I_{n-1} = I_{n+1} + (2n/x) I_n
        ip1, i0 = i0, im1                  # now i0 = I_{n-1}
        if n - 1 <= D:
            vals[n - 1] = i0
        if abs(i0) > mpf(10) ** 300:       # rescale
            ip1 /= mpf(10) ** 300
            i0 /= mpf(10) ** 300
            for k in vals:
                vals[k] /= mpf(10) ** 300
    return [None] + [vals[d] / vals[1] for d in range(1, D + 1)]


def betap(beta, L):
    L2 = L * L
    D = int(40 + 10 * m.sqrt(beta / L2 + 1) * 4)
    rho = ratios(beta, D)
    # A_d d = (d I_d)^{L2} d^{1-L2} d / const = d^2 rho_d^{L2} (up to a d-independent factor)
    lnw = [None] + [2 * m.log(d) + L2 * m.log(rho[d]) for d in range(1, D + 1)]
    mx = max(lnw[1:])
    num = mpf(0)
    den = mpf(0)
    for d in range(1, D + 1):
        w = m.exp(lnw[d] - mx)
        num += w * (d * d - 1)
        den += w
    return num / den / 3


for L in (2, 3):
    print("=== L = %d ===" % L)
    h0 = mpf(-1) / 3 - mpf(1) / (2 * L * L) + mpf(5) / (6 * L ** 4)
    h = lambda u: betap(1 / u, L) - 1 / (u * L * L)
    # the two-loop coefficient h'(0) by Richardson on (h(u) - h0)/u
    us = [mpf(1) / (100 * 2 ** k) for k in range(0, 6)]
    vals = [(h(u) - h0) / u for u in us]
    R = vals[:]
    for k in range(1, 4):
        R = [(2 ** k * R[i + 1] - R[i]) / (2 ** k - 1) for i in range(len(R) - 1)]
    print("  one loop: h(1/3200) = %s (desk h(0) = -1/3 - 1/(2L^2) + 5/(6L^4) = %s)" % (m.nstr(h(mpf(1) / 3200), 15), m.nstr(h0, 15)))
    hp0 = R[-1]
    print("  two-loop coefficient h'(0) (Richardson) = %s" % m.nstr(hp0, 15))
    print("  beta  | Delta(beta) = h(u)-h(0) | beta*Delta | A2(u) = sup_{v<=u}|h'+2vh''| | sup_{v<=u}|h'| | A2/|h'(0)|")
    for beta in (mpf(100), mpf(30), mpf(10), mpf(5), mpf(3), mpf(2), mpf('1.5'), mpf(1)):
        u = 1 / beta
        D = h(u) - h0
        # sup over a grid of v in (0, u]
        best2 = mpf(0)
        best1 = mpf(0)
        for j in range(1, 41):
            v = u * j / 40
            h1 = m.diff(h, v, 1)
            h2 = m.diff(h, v, 2)
            best2 = max(best2, abs(h1 + 2 * v * h2))
            best1 = max(best1, abs(h1))
        best2 = max(best2, abs(hp0))
        best1 = max(best1, abs(hp0))
        print("  %5s | %s | %s | %s | %s | %s" % (m.nstr(beta, 4), m.nstr(D, 10), m.nstr(beta * D, 10), m.nstr(best2, 10),
                                                  m.nstr(best1, 10), m.nstr(best2 / abs(hp0), 6)))
