#!/usr/bin/env python3
# cert_export.py -- CC, 2026-11-02. Writes the composed recursion's certificate at (beta, set, setting) as a JSON a stranger re-checks with
# cert_check.py (pure Python Fractions, nothing else): M~_hi (48 x 48 outward-rounded upper entries, integers over 2^160, each the T-component
# of a VERIFIED super-solution of the composed recursion for one outside class) and v (48 positive rationals). The check is the inequality
# M~_hi v <= (1 - eta) v entrywise; that M~_hi bounds the recursion's true matrix is this directory's code (cc_core), not the checker's.
# CONDITIONAL on GAPS 1-2 (WORK.md 4.3): it certifies the degree-one recursion's weighted block criterion, not a theorem about the measure.
import sys, json
from fractions import Fraction as F
import cc_core as K
geom = json.load(open(sys.argv[1])); beta = sys.argv[2]; sharp = sys.argv[3] == "sharp"; setting = sys.argv[4]; out = sys.argv[5]
c = K.consts(F(beta), sharp)
res = K.run_block(geom, c, "two", K.remainder_set(c, setting), per_class=True)
lo, hi, v, rf = K.perron_cert(res["Mt"])
Mhi = [[int(e[1] * K.SCL) for e in row] for row in res["Mt"]]
assert all(F(Mhi[i][j], K.SCL) == res["Mt"][i][j][1] for i in range(48) for j in range(48))
json.dump({"beta": beta, "set": "sharp" if sharp else "proved", "setting": setting, "scale_bits": K.SCB,
           "M_hi_scaled": Mhi, "v": [[x.numerator, x.denominator] for x in v],
           "claimed_eta_lower_bound": [(1 - hi).numerator, (1 - hi).denominator] if hi < 1 else None}, open(out, "w"))
print("CERT-EXPORT beta %s %s %s: theta_hi = %.10f, written %s" % (beta, "sharp" if sharp else "proved", setting, float(hi), out))
