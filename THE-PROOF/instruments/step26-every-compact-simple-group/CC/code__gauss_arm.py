#!/usr/bin/env python3
# gauss_arm.py -- CC, 2026-11-02. TOOTH (ii), the Gaussian arm (M2c's Lemma P): Villain U(1) at large beta_V is the photon, a Gaussian
# field whose Feynman-gauge component is the massless lattice field; its conditional mean is LINEAR in the neighbours, so the covariance
# composition is EXACT there and the degree-one recursion's M-channel is the whole story. Lemma P: the conditional row of a gapless
# Gaussian is >= 1. The SAME certified Solver (cc_core) is run on the side-2 block of Z^4 sites, H = (8 + m^2) I - A, K = 1/(8 + m^2):
#   M_x = sum_{z in B, z~x} K M_z + sum_{y not in B, y~x} K (unit outside change).
# The arm must REFUSE m = 0 (rows exactly 1, rho(M~) = 1) and ADMIT m^2 > 0; a planted bent covariance (K x (1 - 2^-6)) must make the
# massless field PASS -- which is what a mispriced composition would do to a gapless theory (the arm firing).
import itertools
from fractions import Fraction as F
import cc_core as K
from ivr import fmt_dn, fmt_up

sites = list(itertools.product((0, 1), repeat=4)); idx = {s: i for i, s in enumerate(sites)}
def run(Kc, label):
    n = 16
    G = [[F(0)] * n for _ in range(n)]
    rhs = {j: [F(0)] * n for j in range(n)}
    for s in sites:
        for mu in range(4):
            t = list(s); t[mu] = 1 - t[mu]; G[idx[s]][idx[tuple(t)]] = Kc        # in-block neighbour (flip inside {0,1})
            # the outside neighbour in direction mu: coordinate -1 (if s_mu = 0) or 2 (if 1); its class (site mod 2) is the flipped site
            rhs[idx[tuple(t)]][idx[s]] += Kc
    S = K.Solver(G, G)
    tot = [sum(rhs[j][x] for j in range(n)) for x in range(n)]
    assert S.certify_positive(tot, tot)
    lo, hi = S.solve(tot, tot)
    Mt = [[None] * n for _ in range(n)]
    for j in range(n):
        a, b = S.solve(rhs[j], rhs[j])
        for x in range(n): Mt[x][j] = (a[x], b[x])
    tl, th, v, rf = K.perron_cert(Mt)
    # EXACT test (rational arithmetic, no rounding): does the all-ones vector solve the total system, 1 = tot + G 1? Then the block rows
    # are exactly 1 (rho(G) < 1 is certified above, so the solution is unique), the folded matrix has M~ 1 = 1 by linearity, and
    # Collatz-Wielandt with v = 1 gives rho(M~) = 1 exactly: REFUSED.
    exact_one = all(tot[x] + sum(G[x]) == 1 for x in range(n))
    if exact_one: tl = th = F(1)
    verdict = "ADMITTED (rho < 1)" if th < 1 else ("REFUSED (rho >= 1)" if tl >= 1 else "UNDECIDED")
    if exact_one: print("GAUSS   exact: the all-ones vector solves 1 = tot + G 1 in rational arithmetic -> rows exactly 1, rho(M~) = 1 exactly")
    print("GAUSS %-34s K = %-12s block rows in [%s, %s]; rho(M~) in [%s, %s] -> %s" %
          (label, str(Kc) if Kc.denominator < 10 ** 6 else "%.10f" % float(Kc), fmt_dn(min(lo), 12), fmt_up(max(hi), 12),
           fmt_dn(tl, 12), fmt_up(th, 12), verdict))
    return verdict
v0 = run(F(1, 8), "massless (m = 0): the photon")
v1 = run(F(1, 8) * (1 - F(1, 2 ** 6)), "PLANTED: covariance bent down 2^-6")
v2 = run(F(1, 9), "massive m^2 = 1")
v3 = run(F(10, 81), "massive m^2 = 0.1")
ok = v0.startswith("REFUSED") and v1.startswith("ADMITTED") and v2.startswith("ADMITTED") and v3.startswith("ADMITTED")
print("GAUSS-ARM verdict: massless REFUSED, massive ADMITTED, and the planted bend ADMITS the massless field (the arm can fire): %s" % ("MET" if ok else "MISSED"))
