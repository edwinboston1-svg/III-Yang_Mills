#!/usr/bin/env python3
"""PK — stake S-7: RPM1's Lemma 7.1 at the borderline exponent 4.
Checks exactly, for n <= NMAX, that M_0 = M_1 = 0, M_n = 4n - 8 (n >= 2) satisfies every hypothesis of the lemma
(M_n in 4Z, M_{2n} in 8Z, 2 M_{a+b} <= M_{2a} + M_{2b}) together with the bound M_n <= 4n - 4 — the bound a growth estimate at
per-point exponent 4 with ANY decaying correction factor delivers — while M_n > 0 for n >= 3.
Sighted controls: the checker must REJECT a planted convexity violation and a planted bound violation."""

NMAX = 2000

def check(M, bound):
    errs = []
    n_max = len(M) - 1
    for n in range(n_max + 1):
        if M[n] % 4: errs.append(("4Z", n))
        if n >= 1 and M[n] > bound(n): errs.append(("bound", n))
    for n in range(n_max // 2 + 1):
        if M[2 * n] % 8: errs.append(("8Z", n))
    for a in range(n_max // 2 + 1):
        for b in range(n_max // 2 + 1 - a):
            if 2 * M[a + b] > M[2 * a] + M[2 * b]:
                errs.append(("convexity", a, b))
    return errs

M = [0, 0] + [4 * n - 8 for n in range(2, NMAX + 1)]
e = check(M, lambda n: 4 * n - 4)
print("S-7: M_n = max(0, 4n - 8), n <= %d, bound M_n <= 4n - 4: violations = %d; M_n > 0 for all 3 <= n <= %d: %s"
      % (NMAX, len(e), NMAX, all(M[n] > 0 for n in range(3, NMAX + 1))))
Mc = [0] + [4 * n for n in range(1, 201)]
print("reference: M_n = 4n (RPM1's own weight-3 example at c = 4), bound 4n: violations = %d" % len(check(Mc, lambda n: 4 * n)))
P1 = list(M[:201]); P1[7] = 24          # planted: 2 M_7 = 48 > M_6 + M_8 = 16 + 24 = 40
print("planted convexity violation (M_7 = 24): checker reports %s" % (check(P1, lambda n: 4 * n)[:3]))
P2 = list(M[:201]); P2[10] = 40         # planted: M_10 = 40 > 4*10 - 4 = 36
print("planted bound violation (M_10 = 40 > 36): checker reports %s" % ([x for x in check(P2, lambda n: 4 * n - 4) if x[0] == 'bound'][:3]))
