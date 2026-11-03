#!/usr/bin/env python3
# cc_scan.py -- CC, 2026-11-02. S-5: where the degree-one recursion's weighted block criterion rho(M~) < 1 crosses, on the grid 10^-4, for
# R0 (ideal) and R1 (proved remainders) on both constant sets, and R2 (READING). Every coefficient is nondecreasing in beta, so rho(M~(beta))
# is nondecreasing and a certified pass at beta holds on [0, beta]. Then TOOTH (iii-a): at R1-proved's last passing grid point the
# certificate (v, eta) is re-checked by an independent recomputation (the control: unchanged -> holds) and with the covariance bent up
# (+1 %, +5 %) -> must FAIL. CONDITIONAL on GAPS 1-2 (WORK.md 4.3): these are the class's thresholds, not theorems about the measure.
import sys, json, time
from fractions import Fraction as F
import cc_core as K
from ivr import fmt_dn, fmt_up
T0 = time.time()
def say(*a): print(*a, flush=True)
geom = json.load(open(sys.argv[1]))
def rho_at(k, sharp, setting, bend=None):
    c = K.consts(F(k, 10 ** 4), sharp)
    if bend is not None: c = dict(c); c["cov"] = c["cov"] * bend
    rs = K.remainder_set(c, setting)
    res = K.run_block(geom, c, "two", rs, per_class=True)
    lo, hi, v, rf = K.perron_cert(res["Mt"])
    return lo, hi, v, res
def scan(sharp, setting, k0, k1):
    lo_k, hi_k = k0, k1           # invariant: certified pass at lo_k, certified fail at hi_k
    l, h, _, _ = rho_at(lo_k, sharp, setting); assert h < 1, "no certified pass at the lower end %d" % lo_k
    l, h, _, _ = rho_at(hi_k, sharp, setting); assert l > 1, "no certified fail at the upper end %d" % hi_k
    while hi_k - lo_k > 1:
        mid = (lo_k + hi_k) // 2
        l, h, _, _ = rho_at(mid, sharp, setting)
        if h < 1: lo_k = mid
        elif l > 1: hi_k = mid
        else: say("   REFUSED: rho straddles 1 at %d" % mid); break
    return lo_k, hi_k
OUT = {}
for sharp in (False, True):
    for setting in ("R0", "R1", "R2"):
        a, b = scan(sharp, setting, 2400, 2800)
        la, ha, va, _ = rho_at(a, sharp, setting); lb, hb, vb, _ = rho_at(b, sharp, setting)
        tag = {"R0": "IDEAL", "R1": "PROVED-REMAINDERS", "R2": "READING"}[setting]
        say("SCAN %s %-17s weighted rho(M~) < 1 certified at beta = %s (rho in [%s, %s], eta = %s); > 1 at %s (rho in [%s, %s]) -> crossing in [%s, %s)" %
            ("SHARP " if sharp else "PROVED", tag, a / 1e4, fmt_dn(la, 6), fmt_up(ha, 6), fmt_dn(1 - ha, 6), b / 1e4, fmt_dn(lb, 6), fmt_up(hb, 6), a / 1e4, b / 1e4))
        OUT[(sharp, setting)] = (a, va)
    say("time %.1f s" % (time.time() - T0))
# TOOTH (iii-a): the planted bent covariance at R1-proved's last passing point
k, v = OUT[(False, "R1")]
for label, bend in (("CONTROL (unchanged)", None), ("PLANTED cov x 1.01", F(101, 100)), ("PLANTED cov x 1.05", F(105, 100))):
    c = K.consts(F(k, 10 ** 4), False)
    if bend is not None: c = dict(c); c["cov"] = c["cov"] * bend
    res = K.run_block(geom, c, "two", K.remainder_set(c, "R1"), per_class=True)
    Mt = res["Mt"]; n = 48
    # the stranger's check of the STORED certificate v (from the unbent run): theta = max_i (M~_hi v)_i / v_i, exact rationals
    theta = max(sum(Mt[i][j][1] * v[j] for j in range(n)) / v[i] for i in range(n))
    say("TOOTH-IIIa beta %s %-22s: stored v re-checked, max_i (M~_hi v)_i / v_i = %s -> %s" %
        (k / 1e4, label, fmt_up(theta, 8), "CERTIFICATE HOLDS (theta < 1)" if theta < 1 else "CERTIFICATE BROKEN (theta >= 1)"))
say("CC-SCAN DONE (%.1f s)" % (time.time() - T0))
