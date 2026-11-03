# wall_enum.py -- the WALL configurations as CONF lines for the star engines (no star integral computed here): every
# sheet cycle of K_{2,2,2,2} up to symmetry, every chord set up to the cycle's stabilizer, the reduced spin-1/2 cycle on
# the chords' vertices in the sheet's order; the same line format as local_enum.py (a-b:2 spin 1, r-r':1 spin 1/2,
# ratio: r2 = 2^(m-2) * S).  WCONF id=<n> d=<cycle length> k=<chords> m=<rest links> edges: ...
import sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import wall_sweep as ws
if __name__ == "__main__":
    KMAX = int(os.environ.get("KMAX", "16")); out = os.environ.get("OUT", "wall_enum.txt")
    n = 0
    with open(out, "w") as f:
        for C in ws.cycles_up_to_symmetry():
            c0 = n
            for k, Gamma, order in ws.wall_configs(C, KMAX):
                n += 1; m = len(order)
                sheet = []
                if m == 2: sheet = ["%d-%d:1" % (order[0], order[1])] * 2
                elif m >= 3: sheet = ["%d-%d:1" % (order[i], order[(i + 1) % m]) for i in range(m)]
                f.write("WCONF id=%d d=%d k=%d m=%d edges: %s %s ratio: r2 = 2^%d * S\n" % (n, len(C), k, m, " ".join("%d-%d:2" % e for e in Gamma), " ".join(sheet), max(m - 2, 0)))
            f.write("== cycle %s (length %d): %d configurations (cumulative %d)\n" % (list(C), len(C), n - c0, n)); f.flush()
            print("cycle", list(C), n - c0, flush=True)
    print("total", n)
