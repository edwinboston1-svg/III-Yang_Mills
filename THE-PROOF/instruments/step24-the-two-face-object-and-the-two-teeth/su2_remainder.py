"""su2_remainder.py -- THE PHOTON-CARRIED DECIDER, TOOTH 2 (the author's plan of 2026-11-02 11:1x), built by hand by the author.

THE SPLIT, EXACT AT ONE LOOP.  SU(2) Wilson, every link U = e^{iW} V (V the background, W the fluctuation, W = x.sigma/2).
The colour-3 photon carries the background: V = exp(i theta sigma_3 / 2) with theta_bg(x) = eps cos(p x_0) on the links of
direction `bg` (bg = 1: transverse, a field strength in the (0,1) plane; bg = 0: longitudinal, a pure gauge -- the KAT).
The non-abelian remainder is the charged pair w = x^1 + i x^2 and its charged ghosts.  Integrating it at Gaussian order
around the photon background gives
    Gamma(eps) = ln det K_w(eps) - 2 ln det M_gh(eps)            (background gauge, parameter xi; Feynman at xi = 1)
and the photon's effective coupling at momentum p,
    beta_eff(p) = beta + 8 Gamma''(0) / (V p_hat^2),   p_hat^2 = 4 sin^2(p/2),
because the tree action of the background is (beta/16) eps^2 V p_hat^2.  The neutral fluctuation x^3 sees the background
only through cos(theta_p/2), a p-independent constant: U(1) has no drift at this order (tooth 1's statement at one loop).

NO HAND-DERIVED FEYNMAN RULE.  The quadratic form is the exact second-order expansion of Re Tr U_p at an abelian background:
with U_p = e^{iX1} e^{iX2} e^{iX3} e^{iX4} V_p, X1 = W_mu(x), X2 = Ad(V1) W_nu(x+mu), X3 = -Ad(V1 V2 V3^+) W_mu(x+nu),
X4 = -Ad(V_p) W_nu(x), the product is 1 + iS - S^2/2 - (1/2) sum_{i<j} [Xi, Xj] + O(X^3), S = sum Xi, and
    (8/beta) S_2 = sum_p [ cos(theta_p/2) |s_p|^2 - 2 s sin(theta_p/2) sum_{i<j} Im(conj(w_i) w_j) ] + (1/xi) sum_x |(D.w)(x)|^2,
w_1 = w_mu(x), w_2 = e^{iC th_a} w_nu(x+mu), w_3 = -e^{iC(th_a + th_b - th_c)} w_mu(x+nu), w_4 = -e^{iC th_p} w_nu(x), s_p = sum w_i,
C = CHG = -1 (Ad(e^{i phi sigma_3/2}) carries sigma_+ to e^{i phi} sigma_+, whose coefficient in x.sigma is conj(w)),
s the factor on the explicit spin term (1 = Yang-Mills; the other half of the spin coupling is the Weitzenboeck term
inside the covariant curl), (D.w)(x) = sum_mu [w_mu(x) - e^{-iC th_mu(x-mu)} w_mu(x-mu)], ghost M = sum_{x,mu} |D_mu c|^2,
D_mu c(x) = e^{iC th_mu(x)} c(x+mu) - c(x).  Every momentum-space block is the Fourier projection, over the background's
phase, of that expression on plane waves, carried as eps-jets to second order: exact, because every coefficient is a
trigonometric polynomial of degree <= 2 in the phase at order <= 2 (modes 3 and 4 are read and must vanish).

Gamma''/V = < 2 tr(K0^-1 K2) - sum_{s = +-1} tr(K0(k)^-1 K1(k, k+sp) K0(k+sp)^-1 K1(k+sp, k)) >  minus twice the ghost's, the
average over an antiperiodic midpoint grid of N^4 momenta = the finite lattice with twisted charged fields (p = 2 pi m / N).
Usage: python su2_remainder.py kat | run <N> <m,m,...> [spin] [xi] [ghosts 0/1] [bg] [sym 0/1, default 1]
"""
import sys, time
import numpy as np

CHG = -1.0
MS = 8                                    # phase samples; degree <= 2 needs 5, modes 3 and 4 are read as a check
PHIS = 2.0 * np.pi * np.arange(MS) / MS
NMODE = range(-4, 5)


def J(b):
    """jet (orders 0, 1, 2 in eps) of exp(i CHG eps b) over the phase samples, b real (MS,)"""
    b = np.asarray(b, float) * np.ones(MS)
    return np.array([np.ones(MS), 1j * CHG * b, -0.5 * b * b], dtype=complex)


def jm(a, b):
    return np.array([a[0] * b[0], a[0] * b[1] + a[1] * b[0], a[0] * b[2] + a[1] * b[1] + a[2] * b[0]])


ONE = np.array([np.ones(MS), np.zeros(MS), np.zeros(MS)], dtype=complex)
ZERO = (0, 0, 0, 0)


def unit(mu):
    v = [0, 0, 0, 0]; v[mu] = 1; return tuple(v)


def neg(v):
    return tuple(-c for c in v)


class Form:
    """A Hermitian form between plane waves: (i, j, v_bra, v_ket) -> eps-jet over the phase samples.  The matrix element
    [i, j] between bra e^{ik'.x} and ket e^{ik.x}, phase mode n (k'_0 = k_0 + n p), order o, is
    sum over keys of conj(e^{ik'.v_bra}) e^{ik.v_ket} * F[key][n][o]."""
    def __init__(self):
        self.t = {}

    def add(self, i, j, vb, vk, jet):
        key = (i, j, vb, vk)
        self.t[key] = self.t.get(key, 0) + jet

    def fourier(self):
        self.F = {key: {n: (jet * np.exp(-1j * n * PHIS)).sum(axis=1) / MS for n in NMODE} for key, jet in self.t.items()}
        return self

    def alias(self):
        """the largest |coefficient| at modes 3, 4 (must vanish at every order <= 2)"""
        return max(abs(F[n][o]) for F in self.F.values() for n in (-4, -3, 3, 4) for o in range(3))

    def evaluate(self, kb, kk, order, n, dim):
        P = kk.shape[0]
        out = np.zeros((P, dim, dim), complex)
        for (i, j, vb, vk), F in self.F.items():
            c = F[n][order]
            if abs(c) < 1e-15:
                continue
            out[:, i, j] += c * np.exp(-1j * (kb @ np.array(vb, float)) + 1j * (kk @ np.array(vk, float)))
        return out


def gluon_form(p, bg, spin=1.0, xi=1.0):
    f = Form()
    cs = lambda shift: np.cos(PHIS + shift)
    for mu in range(4):
        for nu in range(mu + 1, 4):
            ba = (mu == bg) * cs(0.0)
            bb = (nu == bg) * cs(p * (mu == 0))
            bc = (mu == bg) * cs(p * (nu == 0))
            bd = (nu == bg) * cs(0.0)
            bp = ba + bb - bc - bd
            r = [(mu, ZERO, ONE), (nu, unit(mu), J(ba)), (mu, unit(nu), -J(ba + bb - bc)), (nu, ZERO, -J(bp))]
            cosj = np.array([np.ones(MS), np.zeros(MS), -bp * bp / 8.0], dtype=complex)
            for (ia, va, ca) in r:                      # cos(theta_p/2) |s_p|^2, s_p = sum of the four transported w's
                for (ib, vb, cb) in r:
                    f.add(ia, ib, va, vb, jm(cosj, jm(np.conj(ca), cb)))
            pre = -2.0 * spin * np.array([np.zeros(MS), bp / 2.0, np.zeros(MS)], dtype=complex)   # -2 s sin(theta_p/2)
            for a in range(4):                          # sum_{a<b} Im(conj(w_a) w_b) = (conj(w_a) w_b - conj(w_b) w_a) / 2i
                for b in range(a + 1, 4):
                    (ia, va, ca), (ib, vb, cb) = r[a], r[b]
                    f.add(ia, ib, va, vb, jm(pre, jm(np.conj(ca), cb)) / 2j)
                    f.add(ib, ia, vb, va, -jm(pre, jm(np.conj(cb), ca)) / 2j)
    g = []
    for mu in range(4):                                 # (D.w)(x) = sum_mu [w_mu(x) - e^{-iC th_mu(x-mu)} w_mu(x-mu)]
        bgf = (mu == bg) * np.cos(PHIS - p * (mu == 0))
        g.append([(mu, ZERO, ONE), (mu, neg(unit(mu)), -J(-bgf))])
    for gi in g:
        for gj in g:
            for (ia, va, ca) in gi:
                for (ib, vb, cb) in gj:
                    f.add(ia, ib, va, vb, jm(np.conj(ca), cb) / xi)
    return f.fourier()


def ghost_form(p, bg):
    f = Form()
    for mu in range(4):                                 # D_mu c(x) = e^{iC th_mu(x)} c(x+mu) - c(x)
        bmu = (mu == bg) * np.cos(PHIS)
        h = [(0, unit(mu), J(bmu)), (0, ZERO, -ONE)]
        for (ia, va, ca) in h:
            for (ib, vb, cb) in h:
                f.add(0, 0, va, vb, jm(np.conj(ca), cb))
    return f.fourier()


def second_derivative(form, k, p, dim):
    """2 tr(K0^-1 K2) - sum_s tr(K0(k)^-1 K1(k,k+sp) K0(k+sp)^-1 K1(k+sp,k)), per momentum (P,) ; also the Hermiticity defect"""
    ex = np.array([p, 0.0, 0.0, 0.0])
    K0 = form.evaluate(k, k, 0, 0, dim)
    K2 = form.evaluate(k, k, 2, 0, dim)
    T = 2.0 * np.einsum('pii->p', np.linalg.solve(K0, K2))
    herm = 0.0
    for s in (+1, -1):
        ks = k + s * ex
        K0s = form.evaluate(ks, ks, 0, 0, dim)
        K1 = form.evaluate(ks, k, 1, s, dim)            # bra k+sp, ket k: mode n = s
        K1r = form.evaluate(k, ks, 1, -s, dim)          # bra k, ket k+sp: must be K1^H
        herm = max(herm, np.abs(K1r - np.conj(np.transpose(K1, (0, 2, 1)))).max())
        X = np.linalg.solve(K0, K1r)
        Y = np.linalg.solve(K0s, K1)
        T = T - np.einsum('pij,pji->p', X, Y)
    return T, herm


def grid(N, chunk, sym=False):
    """the antiperiodic momenta (2n+1) pi / N.  sym=True: the integrand is invariant under every sign flip k_mu -> -k_mu
    (reflections; the trace is basis-free) and under k_2 <-> k_3 (the two spectator directions), so the positive
    orthant with k_2 <= k_3 carries the whole sum with weights 16 x (2 if k_2 < k_3 else 1).  Checked against the full
    grid by `kat` before any run uses it."""
    if not sym:
        k1 = 2.0 * np.pi * (np.arange(N) + 0.5) / N
        K = np.stack(np.meshgrid(k1, k1, k1, k1, indexing='ij'), -1).reshape(-1, 4)
        W = np.ones(K.shape[0])
    else:
        kp = np.pi * (2 * np.arange(N // 2) + 1) / N
        K = np.stack(np.meshgrid(kp, kp, kp, kp, indexing='ij'), -1).reshape(-1, 4)
        keep = K[:, 2] <= K[:, 3] + 1e-15
        K = K[keep]
        W = 16.0 * np.where(K[:, 2] < K[:, 3] - 1e-15, 2.0, 1.0)
    for a in range(0, K.shape[0], chunk):
        yield K[a:a + chunk], W[a:a + chunk]


def gamma2(N, m, spin=1.0, xi=1.0, ghosts=True, bg=1, chunk=65536, sym=False):
    """returns (Gamma''_gluon/V, Gamma''_ghost-part/V [already times -2], Hermiticity defect, K0 defect, alias, imag)"""
    p = 2.0 * np.pi * m / N
    fg, fh = gluon_form(p, bg, spin, xi), ghost_form(p, bg)
    sg = sh = 0.0; herm = 0.0; k0d = 0.0; imag = 0.0; wsum = 0.0
    for k, w in grid(N, chunk, sym):
        wsum += w.sum()
        Tg, hg = second_derivative(fg, k, p, 4)
        sg += (w * Tg).sum(); herm = max(herm, hg); imag = max(imag, abs(Tg.imag).max())
        if xi == 1.0:
            khat = (4.0 * np.sin(k / 2.0) ** 2).sum(1)
            K0 = fg.evaluate(k, k, 0, 0, 4)
            k0d = max(k0d, np.abs(K0 - khat[:, None, None] * np.eye(4)).max())
        if ghosts:
            Th, hh = second_derivative(fh, k, p, 1)
            sh += -2.0 * (w * Th).sum(); herm = max(herm, hh)
    V = float(N) ** 4
    if abs(wsum - V) > 0.5:
        raise RuntimeError('grid weights sum to %r, not N^4 = %r' % (wsum, V))
    return (sg / V).real, (sh / V).real if ghosts else 0.0, herm, k0d, max(fg.alias(), fh.alias()), imag


def shift(N, m, **kw):
    g, h, herm, k0d, al, im = gamma2(N, m, **kw)
    p = 2.0 * np.pi * m / N
    ph2 = 4.0 * np.sin(p / 2.0) ** 2
    return 8.0 * (g + h) / ph2, 8.0 * g / ph2, 8.0 * h / ph2, herm, k0d, al, im


def main():
    out = []
    P = lambda s: (print(s, flush=True), out.append(s))
    mode = sys.argv[1] if len(sys.argv) > 1 else 'kat'
    if mode == 'kat':
        P('KNOWN-ANSWER CHECKS (N = 8)')
        for bg, label in ((0, 'longitudinal (pure gauge): Gamma\'\' must vanish'), (1, 'transverse')):
            for m in (1, 2):
                t0 = time.time()
                g, h, herm, k0d, al, im = gamma2(8, m, bg=bg)
                P('  bg=%d m=%d %-48s  Gamma\'\'_gl/V = % .3e  ghost part = % .3e  herm %.1e  K0-khat^2 I %.1e  alias %.1e  imag %.1e  (%.1fs)'
                  % (bg, m, label, g, h, herm, k0d, al, im, time.time() - t0))
        P('SYMMETRY CHECK: the reduced orthant (k_2 <= k_3, weights 16 x 1|2) against the full grid, N = 8 and 12')
        for N in (8, 12):
            for (sp, xi) in ((1.0, 1.0), (0.0, 1.0), (1.0, 2.0)):
                a = gamma2(N, 2, spin=sp, xi=xi, sym=False); b = gamma2(N, 2, spin=sp, xi=xi, sym=True)
                P('  N=%d m=2 spin=%g xi=%g: full (% .15e, % .15e)  reduced (% .15e, % .15e)  rel diff %.1e'
                  % (N, sp, xi, a[0], a[1], b[0], b[1], max(abs(a[0] - b[0]) / abs(a[0]), abs(a[1] - b[1]) / max(abs(a[1]), 1e-300))))
        return out
    N = int(sys.argv[2]); ms = [int(x) for x in sys.argv[3].split(',')]
    spin = float(sys.argv[4]) if len(sys.argv) > 4 else 1.0
    xi = float(sys.argv[5]) if len(sys.argv) > 5 else 1.0
    gh = (sys.argv[6] != '0') if len(sys.argv) > 6 else True
    bg = int(sys.argv[7]) if len(sys.argv) > 7 else 1
    sym = (sys.argv[8] != '0') if len(sys.argv) > 8 else True
    P('RUN N=%d m=%s spin=%g xi=%g ghosts=%s bg=%d sym=%s' % (N, ms, spin, xi, gh, bg, sym))
    res = {}
    for m in ms:
        t0 = time.time()
        tot, gl, ghp, herm, k0d, al, im = shift(N, m, spin=spin, xi=xi, ghosts=gh, bg=bg, sym=sym)
        res[m] = (tot, gl, ghp)
        P('  m=%3d p=%.6f  beta_eff - beta = % .6f  (gluon % .6f, ghost % .6f)  herm %.1e K0 %.1e alias %.1e imag %.1e  (%.0fs)'
          % (m, 2 * np.pi * m / N, tot, gl, ghp, herm, k0d, al, im, time.time() - t0))
    P('  DRIFT PER STEP D(p) = shift(p/2) - shift(p)  [stake for the full theory: -0.257512]:')
    for m in ms:
        if m % 2 == 0 and m // 2 in res:
            a, b = res[m // 2], res[m]
            P('    p = %.6f (m %d -> %d): D = % .6f   (gluon % .6f, ghost % .6f)' % (2 * np.pi * m / N, m, m // 2, a[0] - b[0], a[1] - b[1], a[2] - b[2]))
    return out


if __name__ == '__main__':
    res = main()
    if len(sys.argv) > 1 and sys.argv[-1].endswith('.txt'):
        pass
