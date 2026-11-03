import re, sys
p = sys.argv[1]
s = open(p, encoding="utf-8").read()
old_start = s.index("def betap(beta, L):")
old_end = s.index("for L in (2, 3):")
new = '''def ratios(x, D):
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


'''
s = s[:old_start] + new + s[old_end:]
s = s.replace("us = [mpf(1) / (1000 * 2 ** k) for k in range(0, 6)]", "us = [mpf(1) / (100 * 2 ** k) for k in range(0, 6)]")
s = s.replace("h(mpf('1e-4'))", "h(mpf(1) / 3200)").replace("one loop: h(1e-4)", "one loop: h(1/3200)")
open(p, "w", encoding="utf-8").write(s)
print("patched")
