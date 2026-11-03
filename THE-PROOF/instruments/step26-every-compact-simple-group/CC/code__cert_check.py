#!/usr/bin/env python3
# cert_check.py -- a stranger's check of an exported certificate: only Python's fractions module. Reads M_hi (integers over 2^scale_bits)
# and v (rationals), verifies v > 0 and computes theta = max_i (M_hi v)_i / v_i EXACTLY; the certificate holds iff theta < 1, with
# eta = 1 - theta. Optional second argument: a bend factor applied to every M entry (a planted defect; the check must then fail if the
# bend exceeds the margin). Usage: python cert_check.py cert.json [bend_num/bend_den]
import sys, json
from fractions import Fraction as F
d = json.load(open(sys.argv[1]))
S = 1 << d["scale_bits"]
M = [[F(x, S) for x in row] for row in d["M_hi_scaled"]]
v = [F(a, b) for a, b in d["v"]]
bend = F(sys.argv[2]) if len(sys.argv) > 2 else F(1)
assert len(M) == len(v) == 48 and all(len(r) == 48 for r in M), "shape"
assert all(x > 0 for x in v), "v must be positive"
assert all(x >= 0 for r in M for x in r), "M must be nonnegative"
theta = max(sum(bend * M[i][j] * v[j] for j in range(48)) / v[i] for i in range(48))
print("CERT-CHECK %s (beta %s, %s, %s; bend %s): theta = max_i (M v)_i / v_i = %.12f -> %s" %
      (sys.argv[1].replace("\\", "/").split("/")[-1], d["beta"], d["set"], d["setting"], bend, float(theta),
       "HOLDS, eta = %.10f" % float(1 - theta) if theta < 1 else "FAILS"))
