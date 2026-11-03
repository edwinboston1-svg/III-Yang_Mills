# cross-check the regular forms against the Bessel-ratio forms at point radii (READING)
import sys; sys.path.insert(0, '.')
from su2_eval import *
for rs in ['0.3', '1.0', '1.2', '1.47']:
    r = iv.mpf(rs)
    m1 = m_of(r); p2a = 1 - 3*m1/r - m1*m1; Da = p2a - m1/r; p3a = -3*p2a/r + 3*m1/(r*r) - 2*m1*p2a
    m, p2, D, Dr, p3 = phis_regular(r)
    print(rs, 'm', mp.nstr(mp.mpf(m1.a),12), mp.nstr(mp.mpf(m.a),12), 'phi2', mp.nstr(mp.mpf(p2a.a),12), mp.nstr(mp.mpf(p2.a),12), 'D', mp.nstr(mp.mpf(Da.a),12), mp.nstr(mp.mpf(D.a),12), 'phi3', mp.nstr(mp.mpf(p3a.a),12), mp.nstr(mp.mpf(p3.a),12), 'widths', mp.nstr(mp.mpf(p3.b)-mp.mpf(p3.a),3))
