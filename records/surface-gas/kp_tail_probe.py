# kp_tail_probe.py -- the float road with a TWO-PIECE TAIL: gamma(s) = the exact-table value for s <= S_EXACT and a loose proven value
# (the Frobenius sieve's maximum per-corner rate, gamma = 3 rate^4) for s > S_EXACT; prints the reach at F0 = 20.  Measures what closing
# the deep tail by the PROVEN loose bound costs in beta*, so the exact passes are spent where they buy the number.
# usage: S_EXACT=16 GTAIL=13.07 python -I kp_tail_probe.py     (the local table through k = 8, 4.6125 to S_EXACT, GTAIL beyond)
import math, os, sys
sys.argv = [sys.argv[0]]
src = open(os.path.join(os.path.dirname(os.path.abspath(__file__)), "kp_reach6.py"), encoding="utf-8").read()
src = src.split("b, best = reach()")[0]
exec(compile(src, "kp_reach6.py", "exec"))
S_EXACT = int(os.environ.get("S_EXACT", "16")); GTAIL = float(os.environ.get("GTAIL", "13.07"))
TABLE = [3.0, 3.0, 3.9312, 3.9312, 4.1495, 4.6125, 4.6125, 4.6125]
def gam(s):
    if s <= 8: return TABLE[s - 1]
    if s <= S_EXACT: return 4.6125
    return GTAIL
b, best = reach()
print("# kp_tail_probe: F0 = %d, MU = %.2f, exact table to s = %d (4.6125 past 8), gamma = %.3f for s > %d" % (F0, MU, S_EXACT, GTAIL, S_EXACT))
print("KP holds to beta = %.4f   alpha = %.4f  kappa_dress = %.4f" % (b, best[1], best[2]))
