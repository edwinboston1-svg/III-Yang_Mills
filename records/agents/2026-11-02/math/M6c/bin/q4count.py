"""M6c probe (exact integer counts, no floats in the counts): connected induced subgraphs of the hypercube graphs Q_n.

N1(n)   = #connected induced subgraphs of Q_n containing vertex 0                      (Lemma F's c_{n} for n = 3: 91)
N2(n,h) = #connected induced subgraphs of Q_n containing vertex 0 and a fixed vertex of Hamming weight h (h = n: antipodal)
by size.  Used for the diagonal-staircase family of d-polymers (the 16 cubes around a lattice point form Q_4).
Run: python -E -P bin/q4count.py > rec/q4count.txt
"""
import sys


def counts(n):
    N = 1 << n
    adj = [[v ^ (1 << b) for b in range(n)] for v in range(N)]
    N1 = {}
    N2 = {h: {} for h in range(n + 1)}
    for mask in range(1 << N):
        if not mask & 1:
            continue
        seen = 1
        stack = [0]
        while stack:
            u = stack.pop()
            for w in adj[u]:
                if (mask >> w) & 1 and not (seen >> w) & 1:
                    seen |= 1 << w
                    stack.append(w)
        if seen != mask:
            continue
        k = bin(mask).count("1")
        N1[k] = N1.get(k, 0) + 1
        for h in range(n + 1):
            t = (1 << h) - 1  # the vertex 0...01..1 of weight h
            if (mask >> t) & 1:
                N2[h][k] = N2[h].get(k, 0) + 1
    return N1, N2


for n in (2, 3, 4):
    N1, N2 = counts(n)
    print(f"Q_{n}: N1 = {sum(N1.values())}  by size {dict(sorted(N1.items()))}")
    for h in range(n + 1):
        print(f"      N2(h={h}) = {sum(N2[h].values())}  by size {dict(sorted(N2[h].items()))}")
    sys.stdout.flush()
