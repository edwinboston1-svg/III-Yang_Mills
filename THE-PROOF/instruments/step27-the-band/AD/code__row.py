"""row.py -- AD: the L2 conditional row of a FITTED coarse action (fit.py's json), with its certificate.

For the link c and each neighbour class (neigh.json: the links c' sharing loops with c, grouped by the multiset of shared families):
  R_free : the pair's maximal correlation at the FREE environment -- every loop through c or c' that the pair does not share carries no
           tilt (its staple configuration cancels: the four-simplex frame cancels spins 1/2 and 1 at once), the shared loops ALIGNED (each
           shared loop's frame chosen so its spin-1/2 term adds with the others).  Computed by quadrature (pairmc.py, exact to degree 15).
           The scan envscan.py found every von Mises-Fisher tilt LOWERS a one-loop pair's maximal correlation, so R_free is the reading of
           the supremum; it is a LOWER bound only where its environment is realisable (one-loop classes: always).
  R_birk : tanh(Delta/4), Delta = sum over shared loops of the cross-ratio oscillations 4|t_1/2| + (8/3)|t_1| + 4|t_3/2| (SU(2)) or
           sum_k 4|t_k| (U(1)): PROVED for every environment (Birkhoff-Hopf: lambda_2 of the Markov operator <= its projective contraction
           tanh(Delta/4); the single-site tilts cancel from every cross-ratio; rho^2 = lambda_2(P P*) <= tanh^2(Delta/4)).
The weighted row sum_{c'} R e^{kappa d(c,c')} for both; the certificate (v = 1 by the lattice symmetry -- every coarse link is equivalent
and R is symmetric, so R1 = (row) 1) and eta = 1 - row, the sum taken in exact rationals from the doubles, rounded up by 1e-12 relative per
entry (the quadrature's own error, measured, is below 1e-11).
usage: python row.py FITJSON n MODEL [kappa ...]"""
import sys, os, json, math
from fractions import Fraction
import numpy as np
from scipy.special import iv
here = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, here)
from pairmc import s3_rule, u1_rule, maxcorr, qmul

NEIGH = json.load(open(os.path.join(here, 'neigh.json')))
FAMS = ['plaq', 'rect', 'chair', 'parag']

def gfun(gsu2, rep, x):
    if gsu2:
        return [x, (4 * x * x - 1) / 3, 2 * x ** 3 - x][rep]
    return [x, 2 * x * x - 1, 4 * x ** 3 - 3 * x][rep]

def coupling_by_family(fit_block, model):
    m = fit_block['models'][model]
    th = np.zeros((4, 3))
    for k, f in enumerate(m['idx']):
        fam, rep = divmod(f, 3); th[fam, rep] = m['theta'][k]
    jk = []
    for js in m['jack']:
        t = np.zeros((4, 3))
        for k, f in enumerate(m['idx']):
            fam, rep = divmod(f, 3); t[fam, rep] = js[k]
        jk.append(t)
    return th, jk

def class_rows(th, gsu2, Q, W, quad=True):
    """per class: (n, distances, R_first, R_free, R_birk)"""
    out = []
    X = Q @ (Q * np.array([1, -1, -1, -1])).T if gsu2 else None     # Re(U V) = <u, conj v>
    if not gsu2:
        X = Q @ (Q * np.array([1, -1, -1, -1])).T
    for cl in NEIGH:
        sh = np.zeros(3)                       # aligned sums per rep
        delta = 0.0; first = 0.0
        coup_terms = []
        for fam, mult in cl['shared']:
            t = th[fam]
            if gsu2:
                s = 1.0 if t[0] >= 0 else -1.0       # align the spin-1/2 part; spin 3/2 flips with it, spin 1 does not
                coup_terms.append((mult, s * t[0], t[1], s * t[2]))
                delta += mult * (4 * abs(t[0]) + (8.0 / 3) * abs(t[1]) + 4 * abs(t[2]))
            else:
                s = 1.0 if t[0] >= 0 else -1.0       # charge-1 alignment; charge 2 unaffected by U -> -U? (U(1): v -> v e^{i pi} flips odd charges)
                coup_terms.append((mult, s * t[0], t[1], s * t[2]))
                delta += mult * 4 * (abs(t[0]) + abs(t[1]) + abs(t[2]))
        # first-order sup: max over reps of (sum |t|)/d^2 (SU(2): 4, 9, 16) or (sum |t|)/2 (U(1))
        tot = np.zeros(3)
        for fam, mult in cl['shared']:
            tot += mult * np.abs(th[fam])
        first = max(tot[0] / 4, tot[1] / 9, tot[2] / 16) if gsu2 else max(tot) / 2
        rfree = float('nan')
        if quad:
            lp = np.zeros_like(X)
            for (mult, a, b, c) in coup_terms:
                lp += mult * (a * gfun(gsu2, 0, X) + b * gfun(gsu2, 1, X) + c * gfun(gsu2, 2, X))
            rfree = maxcorr(lp, W, W)[1]
        out.append((cl['n'], cl['dist'], first, rfree, math.tanh(delta / 4)))
    return out

def weighted(rows, kappa, which):
    s = 0.0
    for (n, ds, a, b, c) in rows:
        r = {'first': a, 'free': b, 'birk': c}[which]
        s += sum(r * math.exp(kappa * d) for d in ds)
    return s

def certify(rows, kappa, which):
    """outward-rounded row sum: each entry rounded up by 1e-12 relative, each exp(kappa d) by 1e-15 relative, summed in rationals"""
    tot = Fraction(0)
    for (n, ds, a, b, c) in rows:
        r = {'first': a, 'free': b, 'birk': c}[which]
        rr = Fraction(r) * (1 + Fraction(1, 10 ** 12))
        for d in ds:
            tot += rr * Fraction(math.exp(kappa * d)) * (1 + Fraction(1, 10 ** 15))
    return tot

def main():
    fj = json.load(open(sys.argv[1])); n = sys.argv[2]; model = sys.argv[3]
    kappas = [float(k) for k in sys.argv[4:]] or [0.0]
    gsu2 = fj['G'] == 'su2'
    Q, W = s3_rule(8) if gsu2 else u1_rule(256)
    th, jk = coupling_by_family(fj['blocks'][n], model)
    print('ROW %s n=%s model=%s G=%s beta=%g: fitted couplings (family x rep):' % (fj['prefix'], n, model, fj['G'], fj['beta']))
    for f in range(4):
        print('   %-6s %s' % (FAMS[f], '  '.join('%+.6f' % x for x in th[f])))
    rows = class_rows(th, gsu2, Q, W)
    print('   %-62s %4s %10s %10s %10s' % ('class (shared loops)', 'n', 'R_first', 'R_free', 'R_birk'))
    for cl, (cn, ds, a, b, c) in zip(NEIGH, rows):
        lab = ' + '.join('%d %s' % (m, FAMS[f]) for f, m in cl['shared'])
        print('   %-62s %4d %10.6f %10.6f %10.6f' % (lab, cn, a, b, c))
    # jackknife over the couplings (first-order and Birkhoff are cheap; free by quadrature on a subset)
    jr = {'first': [], 'free': [], 'birk': []}
    for t in jk:
        rr = class_rows(t, gsu2, Q, W, quad=True)
        for w in jr: jr[w].append(weighted(rr, 0.0, w))
    nb = len(jk)
    for kappa in kappas:
        line = []
        for w in ['first', 'free', 'birk']:
            val = weighted(rows, kappa, w)
            if kappa == 0.0:
                arr = np.array(jr[w]); err = math.sqrt((nb - 1) / nb * ((arr - arr.mean()) ** 2).sum())
                line.append('%s %.6f(%.6f)' % (w, val, err))
            else:
                line.append('%s %.6f' % (w, val))
        cert = certify(rows, kappa, 'free'); certb = certify(rows, kappa, 'birk')
        print('   kappa=%.3f: weighted row  %s' % (kappa, '  '.join(line)))
        print('      certificate on R_free: v = 1, row <= %.9f, eta = %.9f %s;  on R_birk: row <= %.9f, eta = %.9f %s' % (
            float(cert), float(1 - cert), 'CERTIFIED' if cert < 1 else 'REFUSED', float(certb), float(1 - certb), 'CERTIFIED' if certb < 1 else 'REFUSED'))

if __name__ == '__main__':
    main()
