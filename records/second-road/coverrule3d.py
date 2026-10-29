import itertools
rule = {((0,0,0),0), ((0,0,1),1), ((0,1,1),1), ((1,0,0),0), ((1,1,0),2), ((1,1,1),2)}
def is_cover(x, d):
    return (tuple(c % 2 for c in x), d) in rule
def check(L):
    bad = 0; total = 0
    for x in itertools.product(range(L), repeat=3):
        for i in range(3):
            for j in range(i+1, 3):
                ei = [0]*3; ei[i] = 1; ej = [0]*3; ej[j] = 1
                xi = tuple((x[k]+ei[k]) % L for k in range(3)); xj = tuple((x[k]+ej[k]) % L for k in range(3))
                n = sum(1 for (y, d) in [(x, i), (xi, j), (xj, i), (x, j)] if is_cover(y, d))
                total += 1; bad += (n != 1)
    return total, bad
for L in (2, 4, 6, 8):
    print("3D COVER L=%d: plaquettes=%d with count != 1: %d" % ((L,) + check(L)))
rule.add(((0,1,0),0)); print("CONTROL (one link added) L=2: plaquettes=%d with count != 1: %d (must be > 0)" % check(2))
