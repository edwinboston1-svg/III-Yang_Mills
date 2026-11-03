"""lemmaA_read.py -- the sampled side of Lemma A: -2 beta log <cos Theta_coarse plaquette> from a ymc.c Villain record."""
import sys, os, math
import numpy as np
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from fit import read_stats

d = read_stats(sys.argv[1] + '.stats'); beta = d['beta']
for i, n in enumerate(d['nl']):
    g = d['g'][i]; nl = d['nlink'][i]; visited = nl / 4.0
    c = g[:, 0] / (6.0 * visited)          # per-configuration <cos Theta> over the coarse plaquettes counted
    m = c.mean(); e = c.std() / math.sqrt(len(c))
    v = -2 * beta * math.log(m); ve = 2 * beta * e / m
    print('LEMMA-A sampled beta=%g N=%d n=%d: <cos Theta> = %.10f +- %.2e  ->  -2 beta log<cos> = %.6f +- %.6f' % (beta, d['N'], n, m, e, v, ve))
