"""limit_check.py -- tooth 2's limit read a second way, sharing no fit with decider.py: pure Richardson in N at fixed p
(two sizes per p, correction c_p/(pN)^2 eliminated exactly), then D(p) -> D0 by a polynomial in p^2 through the p-rows."""
import re, os, numpy as np
HERE = os.path.dirname(os.path.abspath(__file__))
sh = {}
for name in ('su2_remainder.2026-11-02b.txt', 'su2_remainder.2026-11-02c.txt', 'su2_remainder.2026-11-02d.txt'):
    p = os.path.join(HERE, name)
    if not os.path.exists(p): continue
    for block in re.split(r'(?=RUN N=)', open(p, encoding='utf-8', errors='replace').read()):
        mm = re.match(r'RUN N=(\d+) m=\[[^\]]*\] spin=1 xi=1 ghosts=True bg=1', block)
        if not mm: continue
        N = int(mm.group(1))
        for m, s in re.findall(r'm=\s*(\d+) p=[0-9.]+\s+beta_eff - beta = ([-0-9.]+)', block):
            sh[(N, int(m))] = float(s)
D = {}
for (N, m), s in sh.items():
    if m % 2 == 0 and (N, m // 2) in sh:
        p = round(2 * np.pi * m / N, 6); D.setdefault(p, {})[N] = sh[(N, m // 2)] - s
print('D(p, N):')
for p in sorted(D): print('  p=%.6f  ' % p + '  '.join('N=%d %+.6f' % (N, D[p][N]) for N in sorted(D[p])))
lim = {}
for p in sorted(D):
    Ns = sorted(D[p])
    if len(Ns) >= 2:
        N1, N2 = Ns[-2], Ns[-1]; d1, d2 = D[p][N1], D[p][N2]
        lim[p] = (d2 * N2**2 - d1 * N1**2) / (N2**2 - N1**2)   # eliminates c/N^2 at fixed p (same as c/(pN)^2 at fixed p)
        print('  p=%.6f Richardson(N=%d,%d): D_inf = %+.6f' % (p, N1, N2, lim[p]))
ps = sorted(q for q in lim if q <= 0.8)
if len(ps) >= 2:
    A = np.array([[1.0, q*q] for q in ps]); y = np.array([lim[q] for q in ps])
    sol, *_ = np.linalg.lstsq(A, y, rcond=None)
    print('D0 (linear in p^2 through %s): %+.6f  stake -0.257512  diff %+.6f' % (['%.3f' % q for q in ps], sol[0], sol[0] + 0.257512))
if len(ps) >= 3:
    A = np.array([[1.0, q*q, q**4] for q in ps]); y = np.array([lim[q] for q in ps])
    sol = np.linalg.solve(A[:3], y[:3]) if len(ps) == 3 else np.linalg.lstsq(A, y, rcond=None)[0]
    print('D0 (quadratic in p^2): %+.6f  diff %+.6f' % (sol[0], sol[0] + 0.257512))
