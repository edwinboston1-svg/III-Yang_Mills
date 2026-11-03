import json, sys
from fractions import Fraction as F
import cc_core as K
from ivr import fmt_dn, fmt_up
geom = json.load(open("../rec/geom_cc.json"))
for b, sh, need in (("0.26", False, "2.1527"), ("0.26", True, "1.7503"), ("0.28", False, "6.3170"), ("0.28", True, "4.3634")):
    c = K.consts(F(b), sh)
    s1 = K.summarize(K.run_block(geom, c, "first", per_class=False))
    res = K.run_block(geom, c, "two", K.remainder_set(c, "R3"), per_class=True); s = K.summarize(res)
    lo, hi, v, rf = K.perron_cert(res["Mt"])
    fac = (s1["e"][0] / s["e"][1], s1["e"][1] / s["e"][0])
    print("R3-FLOOR beta %s %s: e1 [%s, %s] slack [%s, %s] composed e~ [%s, %s] -> FACTOR [%s, %s] (needed %s); block avg [%s, %s]; weighted rho [%s, %s] -> %s" %
          (b, "SHARP " if sh else "PROVED", fmt_dn(s1["e"][0], 6), fmt_up(s1["e"][1], 6), fmt_dn(s1["slack"][0], 6), fmt_up(s1["slack"][1], 6),
           fmt_dn(s["e"][0], 6), fmt_up(s["e"][1], 6), fmt_dn(fac[0], 4), fmt_up(fac[1], 4), need, fmt_dn(s["avg"][0], 6), fmt_up(s["avg"][1], 6),
           fmt_dn(lo, 6), fmt_up(hi, 6), "PASSES" if hi < 1 else ("FAILS" if lo > 1 else "UNDECIDED")), flush=True)
