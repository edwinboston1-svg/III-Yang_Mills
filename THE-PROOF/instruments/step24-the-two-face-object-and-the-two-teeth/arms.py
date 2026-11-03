"""arms.py -- THE PHOTON-CARRIED DECIDER'S ABELIAN ARM, THROUGH TOOTH 2'S OWN ENGINE (the author's fix 4 and fix 6.3).

The same Form machinery as su2_remainder.py (imported, unchanged), pointed at the abelian theories, so the U(1) arm is
not a separate instrument but the same code with the charged remainder removed -- and, because a check that can never
fire is a stamp (law 16), with a SIGHTED control that must fire:

  U1V  Villain U(1): exactly Gaussian, K2 = 0, the shift is 0 and the drift D = 0 identically.
  U1W  Wilson U(1), beta (1 - cos theta_p): the neutral fluctuation sees the background only through cos(theta_p),
       whose second-order coefficient is proportional to p_hat^2, so the shift is p-independent and D = 0 to roundoff.
  +scalar  one complex charged scalar (charge 1, the same transport e^{iC theta} as the SU(2) ghost form, bosonic):
       scalar QED screens, d(1/e^2)/d ln mu = -1/(24 pi^2), so D = +ln 2 / (24 pi^2) = +0.0029263 per step in beta = 1/e^2
       units -- the control that must FIRE, with the opposite sign to SU(2)'s -0.2575.
  SU2  the charged pair and its ghosts (su2_remainder's total) plus the neutral tadpole, which is p-independent
       (it moves beta_eff, never D).

Normalisations: SU(2) tree action (beta/16) eps^2 V p_hat^2 -> beta_eff = beta + 8 Gamma''/(V p_hat^2); U(1) Wilson tree
action beta sum (1 - cos theta_p) = (beta/4) eps^2 V p_hat^2 -> beta_eff = beta + 2 Gamma''/(V p_hat^2) (first written 4 -- caught by the scalar-QED stake before any run).
A real field contributes (1/2) ln det, a complex field ln det, a complex Grassmann pair -2 ln det (the SU(2) ghosts).
Usage: python arms.py <N> <m,m,...> <theory: U1V | U1W | U1V+scalar | U1W+scalar | SU2-neutral>
"""
import sys, time
import numpy as np
import su2_remainder as S


def neutral_form(p, bg, cosmode):
    """the neutral (real) fluctuation: sum_p c(theta_p) |(dx)_p|^2 + |delta x|^2, no transport phases.
    cosmode: 'su2' c = cos(theta_p/2) (second-order coefficient -b^2/8); 'u1' c = cos(theta_p) (-b^2/2); 'villain' c = 1."""
    f = S.Form()
    cs = lambda shift: np.cos(S.PHIS + shift)
    for mu in range(4):
        for nu in range(mu + 1, 4):
            ba = (mu == bg) * cs(0.0)
            bb = (nu == bg) * cs(p * (mu == 0))
            bc = (mu == bg) * cs(p * (nu == 0))
            bd = (nu == bg) * cs(0.0)
            bp = ba + bb - bc - bd
            r = [(mu, S.ZERO, S.ONE), (nu, S.unit(mu), S.ONE), (mu, S.unit(nu), -S.ONE), (nu, S.ZERO, -S.ONE)]
            c2 = {'su2': -bp * bp / 8.0, 'u1': -bp * bp / 2.0, 'villain': 0.0 * bp}[cosmode]
            cj = np.array([np.ones(S.MS), np.zeros(S.MS), c2], dtype=complex)
            for (ia, va, ca) in r:
                for (ib, vb, cb) in r:
                    f.add(ia, ib, va, vb, S.jm(cj, S.jm(np.conj(ca), cb)))
    for mu in range(4):
        for nu in range(4):
            for (va, sa) in ((S.ZERO, 1.0), (S.neg(S.unit(mu)), -1.0)):
                for (vb, sb) in ((S.ZERO, 1.0), (S.neg(S.unit(nu)), -1.0)):
                    f.add(mu, nu, va, vb, sa * sb * S.ONE)
    return f.fourier()


def run(N, m, theory, sym=True, chunk=65536):
    p = 2.0 * np.pi * m / N
    bg = 1
    parts = {}
    forms = []                                  # (label, form, dim, weight on Gamma'')
    if theory.startswith('U1'):
        cosmode = 'villain' if theory.startswith('U1V') else 'u1'
        forms.append(('neutral', neutral_form(p, bg, cosmode), 4, 0.5))
        if theory.endswith('+scalar'):
            forms.append(('scalar', S.ghost_form(p, bg), 1, 1.0))
        factor = 2.0
    elif theory == 'SU2-neutral':
        forms.append(('neutral', neutral_form(p, bg, 'su2'), 4, 0.5))
        factor = 8.0
    else:
        raise SystemExit('unknown theory ' + theory)
    sums = {lab: 0.0 for lab, _, _, _ in forms}
    wsum = 0.0; herm = 0.0
    for k, w in S.grid(N, chunk, sym):
        wsum += w.sum()
        for lab, f, dim, wt in forms:
            T, h = S.second_derivative(f, k, p, dim)
            sums[lab] += wt * (w * T).sum().real; herm = max(herm, h)
    V = float(N) ** 4
    assert abs(wsum - V) < 0.5
    ph2 = 4.0 * np.sin(p / 2.0) ** 2
    for lab in sums:
        parts[lab] = factor * sums[lab] / V / ph2
    return sum(parts.values()), parts, herm


def main():
    N = int(sys.argv[1]); ms = [int(x) for x in sys.argv[2].split(',')]; theory = sys.argv[3]
    print('ARM N=%d m=%s theory=%s (stakes: U1V and U1W D = 0; +scalar D = +0.0029263; SU2-neutral D = 0)' % (N, ms, theory), flush=True)
    res = {}
    for m in ms:
        t0 = time.time()
        tot, parts, herm = run(N, m, theory)
        res[m] = tot
        print('  m=%3d p=%.6f  beta_eff - beta = % .9f  %s  herm %.1e  (%.0fs)'
              % (m, 2 * np.pi * m / N, tot, ' '.join('%s % .9f' % kv for kv in parts.items()), herm, time.time() - t0), flush=True)
    for m in ms:
        if m % 2 == 0 and m // 2 in res:
            print('    p = %.6f (m %d -> %d): D = % .9f' % (2 * np.pi * m / N, m, m // 2, res[m // 2] - res[m]), flush=True)


if __name__ == '__main__':
    main()
