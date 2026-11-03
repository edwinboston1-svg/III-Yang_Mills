# cut_k2222.py -- the J10-type cut bound on the densest simple vertex star: S(K_{2,2,2,2}) <= sqrt(S(H+) S(H+)) = S(H+),
# H+ = one half (a part-pair, K_{2,2} = C4 on {+1,-1,+2,-2}) and its copy, each half's 16 cross edges turned into
# 4 parallel edges between every vertex and its copy.  Degrees 6, so star_table's exact P_6 contraction applies.
import star_table as st
C4 = [(0,2),(0,3),(1,2),(1,3)]          # K_{2,2} on parts {0,1} and {2,3}
edges = C4 + [(i+4, j+4) for (i, j) in C4] + [(v, v+4) for v in range(4) for _ in range(4)]
S = st.star_integral(edges, "H+ (C4 x K2, rungs x4)")
print("cut bound: S(K_{2,2,2,2}) <= %s = %.6f ; per-corner rate bound S^(1/48) <= %.5f" % (S, float(S), float(S)**(1/48)))
