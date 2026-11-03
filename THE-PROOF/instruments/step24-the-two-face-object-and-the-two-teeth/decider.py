"""decider.py -- THE DECIDER'S VERDICT RULE AS CODE (the author's side reading of 2026-11-02 12:1x: "Have the code that reads
2.2 also go through both teeth, or treat its 2.2 reading as unvalidated").

The decider IS the theorem's own hypothesis, examined on the coarse measure by a calibrated path.  A path speaks at a
coupling only if (a) its output is the theorem's input (a Dobrushin row with a Perron certificate, or KP on L1-Haar
activities) and (b) it passed, through the same code, every tooth:
  T1  the abelian refuter alive (Villain U(1): ratio 1 in proper form; the charged scalar must screen),
  T2  the weak side (SU(2)'s one-loop drift -0.257512 per L = 2 step, the parts at their stakes),
  T0  the strong side (Theorem 8.7's region admitted).
Otherwise its reading prints UNVALIDATED.  Verdict alphabet (infix-free, law 46): CERTIFIED / REFUSED / UNVALIDATED.

This file reads the runs of record; it computes nothing new and claims nothing the records do not hold.
Usage: python decider.py  (prints the table; exit 0 always -- the verdict is the token, never the exit code)
"""
import re, sys, os
import numpy as np

HERE = os.path.dirname(os.path.abspath(__file__))
C1 = 0.257512                               # 8 b0 ln 2, SU(2)


def read(name):
    p = os.path.join(HERE, name)
    return open(p, encoding='utf-8', errors='replace').read() if os.path.exists(p) else ''


def tooth1():
    """photon_gauss run b: the proper-form ratios r_inf (three-term fits)"""
    txt = read('photon_gauss.2026-11-02b.txt')
    vals = [float(x) for x in re.findall(r'r_inf = ([0-9.]+) \(c =', txt)]
    sc = read('arms.2026-11-02b.txt')
    # the scalar control: D at p = 0.785398 on the largest N present
    best = None
    for block in re.split(r'(?=ARM N=)', sc):
        m = re.match(r'ARM N=(\d+)', block)
        if not m:
            continue
        N = int(m.group(1))
        for p, d in re.findall(r'p = ([0-9.]+) \(m \d+ -> \d+\): D =\s+([-0-9.]+)', block):
            if abs(float(p) - 0.785398) < 1e-5:
                best = (N, float(d))
    ok_ratio = bool(vals) and all(abs(v - 1.0) <= 0.01 for v in vals)
    ok_scalar = best is not None and best[1] > 0.0          # screening has the opposite sign to SU(2)
    return ok_ratio and ok_scalar, 'r_inf %s; scalar D(0.785) %s' % (
        ', '.join('%.5f' % v for v in vals) if vals else 'none', ('%+.6f at N=%d' % (best[1], best[0])) if best else 'none')


def tooth2():
    """su2_remainder runs b, c, d: the shift beta_eff - beta at (N, m) for the full theory, paired across files as D(p) =
    shift(N, m/2) - shift(N, m), p = 2 pi m / N; fit D = D0 + a p^2 + c / (pN)^2 on p <= 0.8, N >= 48, m >= 4
    (the infrared cutoff acts relative to p)"""
    shifts = {}
    for name in ('su2_remainder.2026-11-02b.txt', 'su2_remainder.2026-11-02c.txt', 'su2_remainder.2026-11-02d.txt'):
        txt = read(name)
        for block in re.split(r'(?=RUN N=)', txt):
            mm = re.match(r'RUN N=(\d+) m=\[[^\]]*\] spin=1 xi=1 ghosts=True bg=1', block)
            if not mm:
                continue
            N = int(mm.group(1))
            for m, s in re.findall(r'm=\s*(\d+) p=[0-9.]+\s+beta_eff - beta = ([-0-9.]+)', block):
                shifts[(N, int(m))] = float(s)
    rows = [(N, 2 * np.pi * m / N, shifts[(N, m // 2)] - s) for (N, m), s in shifts.items() if m % 2 == 0 and (N, m // 2) in shifts]
    use = [(N, p, d) for N, p, d in rows if p <= 0.8 and N >= 48 and N * p / (2 * np.pi) >= 3.99]
    if len(use) < 3:
        return False, 'too few rows (%d) for the limit' % len(use), None
    A = np.array([[1.0, p * p, 1.0 / (p * N) ** 2] for N, p, d in use]); y = np.array([d for N, p, d in use])
    sol, *_ = np.linalg.lstsq(A, y, rcond=None)
    D0 = sol[0]
    return abs(D0 + C1) <= 0.01, 'D0 = %+.5f from %d rows (stake %+.6f); fit a = %+.4f, c = %+.2f' % (D0, len(use), -C1, sol[1], sol[2]), D0


def main():
    t1, s1 = tooth1()
    t2, s2, D0 = tooth2()
    print('THE DECIDER -- teeth through the same code, verdicts CERTIFIED / REFUSED / UNVALIDATED')
    print('  P1 (one loop: photon exact, charged remainder at Gaussian order; output = a coupling, a CALIBRATOR not a speaker)')
    print('     T1 %s  (%s)' % ('PASS' if t1 else 'FAIL', s1))
    print('     T2 %s  (%s)' % ('PASS' if t2 else 'FAIL', s2))
    print('     T0 NOT-PASSABLE  (perturbation theory has no strong-coupling output)')
    if D0 is not None:
        print('     reading at beta = 2.2, two steps: beta_eff = %.4f  -> UNVALIDATED (T0; and a coupling is not the theorem\'s input)' % (2.2 + 2 * D0))
    else:
        print('     reading at beta = 2.2: UNVALIDATED')
    print('  P2 (exact local engine inside, Gaussian exterior integrated, block-averaged coordinates; output = the row with its certificate)')
    print('     T1 NOT-RUN  T2 NOT-RUN  T0 NOT-RUN  (under construction)')
    print('     reading at beta = 2.2: UNVALIDATED')
    print('DECIDER-VERDICT-AT-2.2: UNVALIDATED')


if __name__ == '__main__':
    main()
