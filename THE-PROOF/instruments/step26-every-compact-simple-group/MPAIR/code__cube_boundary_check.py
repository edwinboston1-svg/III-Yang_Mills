# MPAIR cube_boundary_check.py -- the tuple set of cube_boundary.py is the same for larger cubes (N = 8, 9; four offsets), and for
# the smallest cubes N = 2..5 it is a SUBSET or not (Chatterjee's Definition 2.3 quantifies over every cube, small ones included).
import sys, itertools
sys.path.insert(0, sys.argv[1])
import cube_boundary as cb
base = set()
for N in (6, 7):
    for c in itertools.product(range(2), repeat=4):
        base |= set(cb.enumerate_cube(c, N)[0].keys())
print('base tuple set (N=6,7):', len(base))
for N in (8, 9):
    for c in [(0,0,0,0), (1,0,1,0), (0,1,1,1), (1,1,1,1)]:
        t = set(cb.enumerate_cube(c, N)[0].keys())
        print('N=%d c=%s: %d tuples, new vs base: %s' % (N, c, len(t), sorted(t - base)))
for N in (2, 3, 4, 5):
    new = set()
    for c in itertools.product(range(2), repeat=4):
        new |= set(cb.enumerate_cube(c, N)[0].keys())
    print('N=%d (all offsets): %d tuples, NOT in base: %s' % (N, len(new), sorted(new - base)))
