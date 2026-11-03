#!/usr/bin/env python3
# cc_rows.py -- CC, 2026-11-02: the covariance composition on the base side-2 block, CERTIFIED (exact rationals, outward rounding, verified
# super- and sub-solutions). Usage: python cc_rows.py ../rec/geom_cc.json [quick] > ../rec/cc_rows.<date>.txt
# Sections: 1 tooth (i) -- THE SAME CODE with the covariance thrown away reproduces M87's first-order block rows and Theorem 8.7's crossings;
# 2 the composed degree-one recursion at R0 (ideal), R1 (proved remainders), R2 (READING) on both constant sets; the factor e1/e~ with its
# interval, the average-form verdict, the weighted criterion's Perron root enclosed both ways and the certificate (v, eta) where it passes;
# 3 the global two-component row-sum model (every link has the same neighbour histogram) and the cross-term budget c*.
import sys, json, time, hashlib
from fractions import Fraction as F
import cc_core as K
from ivr import I, fmt_dn, fmt_up

T0 = time.time()
def say(*a): print(*a, flush=True)
def iv(p, d=8): return "[%s, %s]" % (fmt_dn(p[0], d), fmt_up(p[1], d))
gpath = sys.argv[1]; QUICK = "quick" in sys.argv[2:]
geom = json.load(open(gpath))
say("CC-ROWS geometry %s sha256 %s; SCB=%d; constants at 320 bits (ivr.py)" % (gpath.split("/")[-1], hashlib.sha256(open(gpath, "rb").read()).hexdigest(), K.SCB))

# M87's first-order block rows (rows.2026-11-02b): (min lo, max hi, average) of (I - C_BB)^-1 C_BO 1 on the base block
M87 = {("0.2414", False): ("0.99971599", "0.99981056", "0.99977091"), ("0.2415", False): ("1.00107500", "1.00161223", "1.00130020"),
       ("0.2452", True): ("0.99887133", "0.99924832", "0.99909034"), ("0.2453", True): ("1.00044836", "1.00067348", "1.00054269"),
       ("0.26", False): ("1.27174619", "1.43973709", "1.34205644"), ("0.28", False): ("1.68510794", "2.21816802", "1.90776100"),
       ("0.26", True): ("1.19616223", "1.31181871", "1.24456921"), ("0.28", True): ("1.54588986", "1.94544123", "1.71280102")}
NEED = {("0.26", False): "2.153", ("0.28", False): "6.317", ("0.26", True): "1.750", ("0.28", True): "4.363"}

# ---------------------------------------------------------------- 1. tooth (i): the first-order reduction in the same code
say("== 1. TOOTH (i): M -> 2T, every remainder 0 (block_system mode 'first'), against M87's records")
FIRST = {}
# 0.2453 sharp: M87's BLOCKS line used the CELL sup of T6 (alpha 1.0003164); its CROSS line used the POINTWISE T6 (alpha 1.0003101, a lower
# bound of the sup, which is what certifies 'above 1'). The KAT compares like with like (cell); the certified FAIL is read with the pointwise.
for (b, sh), (mn, mx, av) in M87.items():
    c = K.consts(F(b), sh)
    res = K.run_block(geom, c, "first", per_class=True)
    s = K.summarize(res)
    lo, hi, v, rf = K.perron_cert(res["Mt"])
    okrows = abs(s["mn"] - F(mn)) < F(1, 10 ** 7) and abs(s["mx"] - F(mx)) < F(1, 10 ** 7) and abs(s["avg"][0] - F(av)) < F(1, 10 ** 7)
    FIRST[(b, sh)] = (c, s)
    say("TOOTH-I %s %s alpha %s | first-order block rows min %s max %s avg %s against M87 (%s, %s, %s): %s | weighted criterion: rho(M1) in [%s, %s] -> %s" %
        (b, "SHARP " if sh else "PROVED", c["alpha"].s(9), fmt_dn(s["mn"], 8), fmt_up(s["mx"], 8), iv(s["avg"]), mn, mx, av,
         "MET" if okrows else "MISSED", fmt_dn(lo, 9), fmt_up(hi, 9), "PASSES (rho < 1)" if hi < 1 else ("FAILS (rho > 1)" if lo > 1 else "UNDECIDED")))
c = K.consts(F("0.2453"), True, pointwise_T6=True)
res = K.run_block(geom, c, "first", per_class=True); lo, hi, v, rf = K.perron_cert(res["Mt"])
say("TOOTH-I 0.2453 SHARP with the POINTWISE T6 (a lower bound of the sup; alpha %s): weighted rho(M1) in [%s, %s] -> %s" %
    (c["alpha"].s(9), fmt_dn(lo, 9), fmt_up(hi, 9), "FAILS (rho > 1): certified, every constant at or below its sup" if lo > 1 else "NOT CERTIFIED"))
say("   (Theorem 8.7's crossings: the first-order weighted criterion must pass at 0.2414 / 0.2452 and fail at 0.2415 / 0.2453)")
say("time %.1f s" % (time.time() - T0))

# ---------------------------------------------------------------- 2. the composed recursion
say("== 2. THE COVARIANCE COMPOSITION (degree-one recursion, WORK.md 4.3): R0 ideal / R1 proved remainders / R2 READING")
for (b, sh) in (("0.2414", False), ("0.2452", True), ("0.26", False), ("0.26", True), ("0.28", False), ("0.28", True)):
    c = K.consts(F(b), sh)
    kap = 2 * c["rate"] / c["cov"]
    s1 = FIRST.get((b, sh), (None, None))[1]
    if s1 is None: s1 = K.summarize(K.run_block(geom, c, "first", per_class=False))
    say("-- beta %s %s: alpha %s, kappa' = 2 rate/cov = %s, first-order indirect sum e1 %s, slack %s, needed factor e1/slack %s%s" %
        (b, "SHARP" if sh else "PROVED", c["alpha"].s(8), kap.s(6), iv(s1["e"], 6), iv(s1["slack"], 6),
         "[%s, %s]" % (fmt_dn(s1["e"][0] / s1["slack"][1], 4), fmt_up(s1["e"][1] / s1["slack"][0], 4)),
         (" (M87: %s)" % NEED[(b, sh)]) if (b, sh) in NEED else ""))
    for setting in ("R0", "R1", "R2"):
        if QUICK and setting == "R2": continue
        rs = K.remainder_set(c, setting)
        res = K.run_block(geom, c, "two", rs, per_class=True)
        s = K.summarize(res)
        fac = (s1["e"][0] / s["e"][1], s1["e"][1] / s["e"][0])
        avgv = "FAILS (avg > 1)" if s["avg"][0] > 1 else ("PASSES (avg < 1)" if s["avg"][1] < 1 else "UNDECIDED")
        lo, hi, v, rf = K.perron_cert(res["Mt"])
        wv = "PASSES (rho < 1)" if hi < 1 else ("FAILS (rho > 1)" if lo > 1 else "UNDECIDED")
        tag = {"R0": "IDEAL   ", "R1": "PROVED-R", "R2": "READING "}[setting]
        say("   %s composed indirect sum %s -> FACTOR e1/e~ in [%s, %s]; block rows [%s, %s], average %s %s; weighted rho(M~) in [%s, %s] %s; in-block TT row <= %.4f" %
            (tag, iv(s["e"], 6), fmt_dn(fac[0], 4), fmt_up(fac[1], 4), fmt_dn(s["mn"], 6), fmt_up(s["mx"], 6), iv(s["avg"], 6), avgv,
             fmt_dn(lo, 6), fmt_up(hi, 6), wv, float(res["inrow_TT_hi"])))
        if hi < 1:
            eta = 1 - hi
            say("      CERTIFICATE (conditional on GAPS 1-2): v (48 rationals, max 1, min %.6f) with M~_hi v <= (1 - eta) v entrywise in exact rationals, eta = %s" %
                (float(min(v)), fmt_dn(eta, 8)))
    say("time %.1f s" % (time.time() - T0))

# ---------------------------------------------------------------- 3. the global two-component row-sum model
say("== 3. THE GLOBAL TWO-COMPONENT CRITERION (every step covariance-priced; rows constant: one neighbour histogram for all 48 links)")
H = geom["hist"][0]
assert all(h == H for h in geom["hist"]), "neighbour histogram not uniform"
say("   neighbour histogram (nI,nII):count = %s" % H)
def global_P(c, setting):
    rs = K.remainder_set(c, setting)
    A = Bq = Cq = D = I(0)
    for kk, cnt in H.items():
        nI, nII = map(int, kk.split(","))
        cTM, cTT, cMM, cMT = K.pair_coef(c, rs, nI, nII)
        A = A + cnt * cMM; Bq = Bq + cnt * cTM; Cq = Cq + cnt * cMT; D = D + cnt * cTT
    return A, Bq, Cq, D
def perron2(A, Bq, Cq, D, end):
    a, b_, c_, d = (getattr(x, end) for x in (A, Bq, Cq, D))
    import math
    disc = (a - d) ** 2 + 4 * b_ * c_
    return ((a + d) + math.sqrt(float(disc))) / 2   # float READING of the 2x2 root; the decision is made by the exact test below
for sh in (False, True):
    for b in ("0.2414", "0.2452", "0.26", "0.27", "0.28", "0.29", "0.30", "0.32"):
        c = K.consts(F(b), sh)
        line = []
        for setting in ("R0", "R1", "R2"):
            A, Bq, Cq, D = global_P(c, setting)
            # exact decision: rho < 1  <=>  A < 1, D < 1, (1 - A)(1 - D) > Bq Cq  (2x2 nonnegative matrix)
            passes = A.hi < 1 and D.hi < 1 and (1 - A.hi) * (1 - D.hi) > Bq.hi * Cq.hi
            fails = A.lo >= 1 or D.lo >= 1 or (1 - A.lo) * (1 - D.lo) < Bq.lo * Cq.lo
            cstar = (1 - A.hi) * (1 - D.hi) / Bq.hi - Cq.hi if A.hi < 1 and D.hi < 1 else None
            line.append("%s: A=%.4f B=%.4f C=%.4f D=%.4f root~%.4f %s c*=%s" % (setting, float(A.hi), float(Bq.hi), float(Cq.hi), float(D.hi),
                        perron2(A, Bq, Cq, D, "hi"), "PASS" if passes else ("FAIL" if fails else "UNDEC"),
                        ("%.4f" % float(cstar)) if cstar is not None else "-"))
        say("   %s beta %s alpha %.6f | %s" % ("SHARP " if sh else "PROVED", b, float(c["alpha"].hi), " | ".join(line)))
say("   (A = sum c^MM, B = sum c^TM, C = sum c^MT, D = sum c^TT over the 76 neighbours; the dual transfer [[A, B], [C, D]]; c* = the largest extra")
say("    lambda -> tau leak per unit lambda per sweep (the partner cross term of GAP 1) under which the global criterion still holds: (1-A)(1-D)/B - C)")
say("CC-ROWS DONE (%.1f s)" % (time.time() - T0))
