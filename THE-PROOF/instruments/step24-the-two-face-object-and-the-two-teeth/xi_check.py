"""xi_check.py -- tooth 2's gauge-parameter check: the two limit roads per xi (su2_remainder.py records b and e)."""
import re, os, numpy as np
HERE = os.path.dirname(os.path.abspath(__file__))
sh = {}
for name in ('su2_remainder.2026-11-02b.txt', 'su2_remainder.2026-11-02c.txt', 'su2_remainder.2026-11-02d.txt', 'su2_remainder.2026-11-02e.txt'):
    p = os.path.join(HERE, name)
    if not os.path.exists(p): continue
    for block in re.split(r'(?=RUN N=)', open(p, encoding='utf-8', errors='replace').read()):
        mm = re.match(r'RUN N=(\d+) m=\[[^\]]*\] spin=1 xi=([0-9.]+) ghosts=True bg=1', block)
        if not mm: continue
        N, xi = int(mm.group(1)), float(mm.group(2))
        for m, s in re.findall(r'm=\s*(\d+) p=[0-9.]+\s+beta_eff - beta = ([-0-9.]+)', block):
            sh[(xi, N, int(m))] = float(s)
for xi in sorted({k[0] for k in sh}):
    D = {}
    for (x, N, m), s in sh.items():
        if x == xi and m % 2 == 0 and (xi, N, m // 2) in sh:
            D.setdefault(round(2 * np.pi * m / N, 6), {})[N] = sh[(xi, N, m // 2)] - s
    lim = {}
    for p in sorted(D):
        Ns = sorted(D[p])
        if len(Ns) >= 2:
            N1, N2 = Ns[-2], Ns[-1]
            lim[p] = (D[p][N2] * N2**2 - D[p][N1] * N1**2) / (N2**2 - N1**2)
    ps = sorted(q for q in lim if q <= 0.8)
    line = 'xi=%-4g ' % xi + '  '.join('p=%.3f:%s' % (p, ','.join('%+.5f@%d' % (D[p][N], N) for N in sorted(D[p]))) for p in sorted(D) if p <= 1.6)
    if len(ps) >= 2:
        A = np.array([[1.0, q * q] for q in ps]); y = np.array([lim[q] for q in ps])
        sol, *_ = np.linalg.lstsq(A, y, rcond=None)
        line += '  | Richardson limits %s | D0 = %+.5f' % (', '.join('%+.5f' % lim[q] for q in ps), sol[0])
    print(line)
