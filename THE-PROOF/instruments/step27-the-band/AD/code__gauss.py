"""gauss.py -- AD: the exact Gaussian anchors of the averaged conditional row.

(A) THE SCALAR KNOWN ANSWERS (M2c §5.1; a second road to its blockfree.c).  Coarse variable Phi(Y) = n^-3 sum_{x in B_Y} phi(x) of the free
    field phi with precision -Delta + M2 on Z^4.  Road 1: the alias sum Chat(K) = n^-4 sum_m |qhat(p_m)|^2/(phat^2 + M2), qhat the block kernel,
    inverted pointwise and transformed back by FFT on the coarse torus of side LC (blockfree.c: the same formula by direct cosine sums).
    Road 2 (n <= 4): the fine torus of side n*LC, its propagator by FFT, the blocked covariance in real space by an n^4 box sum, then the
    coarse precision by FFT -- no alias sum anywhere.  Conditional row = sum_{Y != 0, |Y|_inf <= RAD} |H(Y)|/H(0); shells printed.
(B) THE FIT PATH ON THE SCALAR: score matching (= the Galerkin Schwinger-Dyson system) with the EXACT blocked covariance, the coarse
    precision restricted to sup-distance r and to hypercubic orbit classes; the fitted row against the exact row.
(C) THE PHOTON IN AD'S AVERAGED COORDINATES (Lemma A of WORK.md: in the abelian limit the tree-averaged coarse link is a coarse gauge
    transform of the chain map C1 A_mu(Y) = n^-4 sum_{x in B_Y} sum_{k<n} A_mu(x + k e_mu)).  Gauge-invariant blocked measure: transverse part
    Gaussian with covariance P_T Chat_V P_T (any fine gauge; Feynman here), longitudinal part flat; precision H(K) = (P_T Chat_V P_T)^+.
    Its conditional row (exact) and the coarse plaquette variance of C2 F (the S4 known answer).
usage: python gauss.py OUTFILE
"""
import sys, itertools, math
from fractions import Fraction
import numpy as np

OUT = []
def P(s=''):
    print(s); OUT.append(s)

# ---------------------------------------------------------------- (A) scalar
def Dn(p, n):
    """|sum_{k<n} e^{ikp}|^2 = sin^2(np/2)/sin^2(p/2), n^2 at p = 0 mod 2pi"""
    s = np.sin(p / 2.0)
    out = np.empty_like(p)
    small = np.abs(s) < 1e-12
    out[~small] = (np.sin(n * p[~small] / 2.0) / s[~small]) ** 2
    out[small] = float(n * n)
    return out

def chat_alias(n, LC, M2):
    """Chat(K) on the LC^4 coarse momenta for the coarse variable n^-3 * block sum: Chat = n^-4 sum_m n^-6 prod_r D_n(k_r)/(phat^2 + M2),
    k = (K + 2 pi m)/n; vectorised over (m2, m3) with a Python loop over (m0, m1)"""
    K1 = 2 * np.pi * np.arange(LC) / LC
    kk = (K1[None, :] + 2 * np.pi * np.arange(n)[:, None]) / n          # (n, LC): k for alias m and coarse K
    Dm = np.stack([Dn(kk[m], n) for m in range(n)])                     # (n, LC)
    Sm = 4 * np.sin(kk / 2) ** 2                                         # (n, LC)
    C = np.zeros((LC,) * 4)
    D23 = Dm[:, None, None, :, None] * Dm[None, :, None, None, :]        # (m2, m3, 1, K2, K3) -> reshaped below
    D23 = (Dm[:, None, :, None] * Dm[None, :, None, :])                  # (m2, m3, K2, K3)
    S23 = (Sm[:, None, :, None] + Sm[None, :, None, :])                  # (m2, m3, K2, K3)
    for m0 in range(n):
        for m1 in range(n):
            num01 = Dm[m0][:, None] * Dm[m1][None, :]                      # (K0, K1)
            s01 = Sm[m0][:, None] + Sm[m1][None, :]                        # (K0, K1)
            den = s01[None, None, :, :, None, None] + S23[:, :, None, None, :, :] + M2
            num = num01[None, None, :, :, None, None] * D23[:, :, None, None, :, :]
            with np.errstate(divide='ignore', invalid='ignore'):
                t = num / den
            C += t.sum(axis=(0, 1))
    C /= float(n) ** 10   # Chat = n^-4 sum_m n^-6 prod D_n/(phat^2 + M2) (the exact torus identity; blockfree.c omits n^-4: rows unaffected)
    return C

def chat_fine(n, LC, M2):
    """road 2: fine torus N = n*LC, propagator by FFT, blocked covariance in real space, sampled at coarse offsets, then FFT"""
    N = n * LC
    k = 2 * np.pi * np.arange(N) / N
    s = 4 * np.sin(k / 2) ** 2
    ph2 = s[:, None, None, None] + s[None, :, None, None] + s[None, None, :, None] + s[None, None, None, :] + M2
    with np.errstate(divide='ignore'):
        Gh = 1.0 / ph2
    if M2 == 0:
        Gh[0, 0, 0, 0] = 0.0      # massless: the zero mode removed (the coarse K = 0 mode is set to H = 0 below, as blockfree)
    G = np.fft.ifftn(Gh).real      # G(x) on the fine torus
    del Gh, ph2
    # blocked covariance: Cov(Phi(0), Phi(Y)) = n^-6 sum_{x in B_0, x' in B_Y} G(x' - x) = n^-6 sum_z w(z) G(nY + z), w(z) = prod (n - |z_d|)
    w1 = np.array([n - abs(z) for z in range(-(n - 1), n)], dtype=float)
    CY = np.zeros((LC,) * 4)
    for z in itertools.product(range(-(n - 1), n), repeat=4):
        wz = w1[z[0] + n - 1] * w1[z[1] + n - 1] * w1[z[2] + n - 1] * w1[z[3] + n - 1]
        idx = np.ix_(*[(n * np.arange(LC) + zz) % N for zz in z])
        CY += wz * G[idx]
    CY /= float(n) ** 6
    return np.fft.fftn(CY).real    # Chat(K) on the coarse torus

def row_from_chat(Ch, RAD, M2):
    LC = Ch.shape[0]
    with np.errstate(divide='ignore'):
        Hh = 1.0 / Ch
    if M2 == 0 or not np.isfinite(Hh[0, 0, 0, 0]):
        Hh[0, 0, 0, 0] = 0.0
    H = np.fft.ifftn(Hh).real
    h0 = H[0, 0, 0, 0]
    row = 0.0; shells = [0.0] * (RAD + 1); pos = 0.0
    for Y in itertools.product(range(-RAD, RAD + 1), repeat=4):
        if Y == (0, 0, 0, 0): continue
        v = H[Y[0] % LC, Y[1] % LC, Y[2] % LC, Y[3] % LC] / h0
        d = max(abs(c) for c in Y)
        row += abs(v); shells[d] += abs(v)
        if v > 0: pos += v
    return row, shells, pos, H, Hh

def certify_torus_row(Ch, M2):
    """directed-rounding certificate of the WHOLE torus row sum_{Y != 0} |H(Y)|/H(0) (every coarse offset of the side-LC torus).
    Error budget: Chat by positive alias sums, relative error <= 1e-13 (generous: <= 4096 terms x 1.1e-16 plus 8-ulp transcendental calls);
    Hhat = 1/Chat inherits it; the inverse FFT adds <= (log2 LC^4 + 2) eps relative to sum |Hhat|.  So |H_comp(Y) - H(Y)| <= dH :=
    LC^-4 sum_K |Hhat(K)| (1e-13 + 40 * 2.2e-16).  The bound is evaluated in exact rational arithmetic from the double values."""
    LC = Ch.shape[0]
    Hh = 1.0 / Ch
    H = np.fft.ifftn(Hh).real
    eps_rel = 1e-13 + 40 * 2.220446049250313e-16
    dH = float(np.sum(np.abs(Hh))) / LC ** 4 * eps_rel * 1.0000001
    num = Fraction(0)
    absH = np.abs(H).ravel(); absH[0] = 0.0
    # sum |H| exactly as rationals of the doubles (the double sum itself is not trusted); plus (LC^4 - 1) dH
    for v in absH: num += Fraction(float(v))
    num += Fraction(dH) * (LC ** 4 - 1)
    den = Fraction(float(H[0, 0, 0, 0])) - Fraction(dH)
    ub = num / den
    return float(ub), dH

def scalar_block():
    P('=== (A) THE SCALAR KNOWN ANSWERS: block-averaged free field, conditional row (M2c §5.1); two roads ===')
    P('KAT n = 1, M2 = 0 (row exactly 1) and M2 = 0.25 (row 8/8.25 = 0.9696969697):')
    for M2 in [0.0, 0.25]:
        Ch = chat_alias(1, 16, M2); r, sh, pos, H, _ = row_from_chat(Ch, 5, M2)
        P('  n=1 M2=%g: row (|Y|<=5) = %.10f   shells %s' % (M2, r, ' '.join('%.3e' % s for s in sh[1:])))
    cases = [(2, 0.0, 5), (4, 0.0, 5), (8, 0.0, 5),
             (2, None, 5, 3.85), (4, None, 5, 3.85), (8, None, 5, 3.85), (16, None, 4, 3.85),
             (4, 4.0, 5), (8, None, 4, 7.0), (16, None, 4, 7.0)]
    staked = {(2, 'm0'): 1.408, (4, 'm0'): 1.833, (8, 'm0'): 2.076, (2, 3.85): 0.491, (4, 3.85): 0.825, (8, 3.85): 1.047, (16, 3.85): 1.136,
              (4, 'M2=4'): 0.339, (8, 7.0): 0.534, (16, 7.0): 0.627}
    res = {}
    for c in cases:
        n = c[0]
        if c[1] is None:
            acm = c[3]; M = 2 * math.sinh(acm / (2 * n)); M2 = M * M; key = (n, acm)
        else:
            M2 = c[1]; key = (n, 'm0') if M2 == 0 else (n, 'M2=4')
        RAD = c[2]
        Ch = chat_alias(n, 16, M2)
        r, sh, pos, H, _ = row_from_chat(Ch, RAD, M2)
        line = '  n=%2d M2=%.10f (a_c m = %.3f): road 1 row = %.6f  [staked %.3f]  shells %s  positive %.3e' % (
            n, M2, n * 2 * math.asinh(math.sqrt(M2) / 2), r, staked[key], ' '.join('d%d=%.4e' % (d, s) for d, s in enumerate(sh) if d > 0), pos)
        P(line)
        if n <= 4:
            Ch2 = chat_fine(n, 16, M2)
            r2, sh2, _, _, _ = row_from_chat(Ch2, RAD, M2)
            rel = np.max(np.abs(Ch2 - Ch) / np.abs(Ch)) if M2 > 0 else np.max(np.abs((Ch2 - Ch)[1:]) / np.abs(Ch[1:]))
            P('        road 2 (fine torus %d^4, real-space blocking): row = %.6f   max |Chat2/Chat1 - 1| = %.2e' % (16 * n, r2, rel))
        if M2 > 0:
            ub, dH = certify_torus_row(Ch, M2)
            P('        CERTIFIED (torus of side 16, every offset, directed rounding): row_torus <= %.9f   (dH = %.2e)' % (ub, dH))
        res[key] = (r, Ch, M2)
    return res

# ---------------------------------------------------------------- (B) the fit path on the scalar
def orbit_classes(r):
    """hypercubic orbit classes of offsets with |Y|_inf <= r: key = sorted tuple of |coords|"""
    cl = {}
    for Y in itertools.product(range(-r, r + 1), repeat=4):
        key = tuple(sorted(abs(c) for c in Y))
        cl.setdefault(key, []).append(Y)
    keys = sorted(cl.keys(), key=lambda k: (max(k), sum(k), k))
    return keys, cl

def score_match_scalar(Ch, r, massless):
    """minimise J(H) = 1/2 sum_K Hhat^2 Chat - sum_K Hhat over Hhat = sum_k h_k phi_k, phi_k(K) = sum_{Y in class k} cos(K.Y)."""
    LC = Ch.shape[0]
    keys, cl = orbit_classes(r)
    K1 = 2 * np.pi * np.arange(LC) / LC
    k0, k1, k2, k3 = np.meshgrid(K1, K1, K1, K1, indexing='ij')
    phis = []
    for key in keys:
        ph = np.zeros_like(k0)
        for Y in cl[key]:
            ph += np.cos(k0 * Y[0] + k1 * Y[1] + k2 * Y[2] + k3 * Y[3])
        phis.append(ph.ravel())
    Phi = np.array(phis)                      # (classes, LC^4)
    c = Ch.ravel().copy()
    mask = np.ones_like(c, dtype=bool)
    if massless: mask[0] = False               # K = 0 excluded; Hhat(0) = 0 imposed
    A = (Phi[:, mask] * c[mask]) @ Phi[:, mask].T
    b = Phi[:, mask].sum(axis=1)
    if massless:
        z = np.array([len(cl[k]) for k in keys], dtype=float)   # Hhat(0) = sum h_k |class k| = 0
        Aa = np.zeros((len(keys) + 1, len(keys) + 1)); Aa[:-1, :-1] = A; Aa[:-1, -1] = z; Aa[-1, :-1] = z
        bb = np.zeros(len(keys) + 1); bb[:-1] = b
        h = np.linalg.solve(Aa, bb)[:-1]
    else:
        h = np.linalg.solve(A, b)
    h0 = h[0]
    row = sum(abs(h[i]) * len(cl[keys[i]]) for i in range(1, len(keys))) / h0
    return row, dict(zip(keys, h / h0))

def scalar_fit(res):
    P('')
    P('=== (B) THE FIT PATH ON THE SCALAR: score matching with the exact blocked covariance, couplings to sup-distance r ===')
    for key in [(2, 'm0'), (4, 'm0'), (2, 3.85), (4, 3.85), (8, 3.85), (16, 3.85), (4, 'M2=4'), (8, 7.0), (16, 7.0)]:
        r_exact, Ch, M2 = res[key]
        out = []
        for r in [1, 2]:
            rf, h = score_match_scalar(Ch, r, M2 == 0)
            out.append('r=%d fitted row %.6f (%+.1f%%)' % (r, rf, 100 * (rf / r_exact - 1)))
        P('  %-12s exact row %.6f | %s' % (str(key), r_exact, ' | '.join(out)))

# ---------------------------------------------------------------- (C) the photon in AD's averaged coordinates
def photon_coords(n, LC=16, RAD=3):
    """exact conditional row of the gauge-invariant photon in the tree-averaged coarse links (Lemma A: = C1 A up to a coarse gauge transform)."""
    K1 = 2 * np.pi * np.arange(LC) / LC
    Cv = np.zeros((LC,) * 4 + (4,))              # Feynman gauge: Chat_V diagonal; entry mu = n^-4 sum_m |q_mu(p_m)|^2 / phat^2
    for m in itertools.product(range(n), repeat=4):
        ks = np.meshgrid(*[(K1 + 2 * np.pi * mm) / n for mm in m], indexing='ij')
        ph2 = sum(4 * np.sin(kk / 2) ** 2 for kk in ks)
        blk = Dn(ks[0], n) * Dn(ks[1], n) * Dn(ks[2], n) * Dn(ks[3], n)      # |chi_B|^2
        with np.errstate(divide='ignore', invalid='ignore'):
            for mu in range(4):
                q2 = blk * Dn(ks[mu], n) / float(n) ** 8                       # |q_mu|^2 = n^-8 |chi_B|^2 |S_mu|^2
                t = q2 / ph2
                t[~np.isfinite(t)] = 0.0
                Cv[..., mu] += t
    Cv /= float(n) ** 4
    # coarse gauge direction w(K) = (e^{iK_mu} - 1); P_T = I - w w^H/|w|^2; H = (P_T C P_T)^+ on range(P_T)
    k0, k1, k2, k3 = np.meshgrid(K1, K1, K1, K1, indexing='ij')
    W = np.stack([np.exp(1j * kk) - 1 for kk in (k0, k1, k2, k3)], axis=-1)
    Wf = W.reshape(-1, 4); Cf = Cv.reshape(-1, 4)
    nw = np.einsum('ki,ki->k', Wf.conj(), Wf).real
    nz = nw > 1e-14
    Pt = np.zeros((Wf.shape[0], 4, 4), dtype=complex)
    Pt[nz] = np.eye(4)[None] - np.einsum('ki,kj->kij', Wf[nz], Wf[nz].conj()) / nw[nz, None, None]
    Cm = np.einsum('kij,kj,kjl->kil', Pt, Cf, Pt)
    ev, U = np.linalg.eigh(Cm)
    emax = ev.max(axis=1, keepdims=True)
    inv = np.where(ev > 1e-12 * np.maximum(emax, 1e-300), 1.0 / np.where(ev > 0, ev, 1.0), 0.0)
    Hf = np.einsum('kia,ka,kja->kij', U, inv, U.conj())
    Hf[~nz] = 0.0
    Hk = Hf.reshape((LC,) * 4 + (4, 4))
    # gauge check: w^H H = 0
    gmax = max(np.abs(W[i].conj() @ Hk[i]).max() for i in [(1, 0, 0, 0), (1, 2, 3, 4), (5, 0, 7, 1)])
    Hy = np.fft.ifftn(Hk, axes=(0, 1, 2, 3))      # H(Y)_{mu nu} = LC^-4 sum_K e^{iKY} H(K)  (numpy ifftn has the + sign)
    h00 = Hy[0, 0, 0, 0, 0, 0].real
    row = 0.0; shells = [0.0] * (RAD + 1); imag = 0.0; nent = 0
    for Y in itertools.product(range(-RAD, RAD + 1), repeat=4):
        for nu in range(4):
            if Y == (0, 0, 0, 0) and nu == 0: continue
            v = Hy[Y[0] % LC, Y[1] % LC, Y[2] % LC, Y[3] % LC, 0, nu]
            imag = max(imag, abs(v.imag))
            a = abs(v.real) / h00
            row += a; shells[max(abs(c) for c in Y)] += a
            if a > 1e-12: nent += 1
    return row, shells, gmax, imag, h00, nent

def c2f_variance(n, G=48):
    """beta * Var of the chain-map coarse plaquette C2 F_{01}: int n^-8 prod_r D_n(p_r) D_n(p_0) D_n(p_1) (phat_0^2 + phat_1^2)/phat^2, midpoint rule"""
    p = 2 * np.pi * (np.arange(G) + 0.5) / G - np.pi
    tot = 0.0
    p0, p1 = np.meshgrid(p, p, indexing='ij')
    a0 = Dn(p0, n) ** 2 * Dn(p1, n) ** 2
    s0 = 4 * np.sin(p0 / 2) ** 2; s1 = 4 * np.sin(p1 / 2) ** 2
    for p2 in p:
        for p3 in p:
            d23 = Dn(np.array([p2]), n)[0] * Dn(np.array([p3]), n)[0]
            ph2 = s0 + s1 + 4 * math.sin(p2 / 2) ** 2 + 4 * math.sin(p3 / 2) ** 2
            tot += np.sum(a0 * d23 * (s0 + s1) / ph2)
    return tot / G ** 4 / float(n) ** 8

def photon():
    P('')
    P('=== (C) THE PHOTON IN AD\'S AVERAGED COORDINATES (exact; coarse torus of side 16; sup-distance 3) ===')
    for n in [1, 2, 4]:
        row, sh, gmax, imag, h00, nent = photon_coords(n)
        P('  n=%d: conditional row = %.6f  [S3: n=1 exactly 3; n=2,4 in [2.5, 6]]  shells %s  H00 = %.6f  entries %d  gauge |w^H H| <= %.1e  max|Im| %.1e' % (
            n, row, ' '.join('d%d=%.4e' % (d, s) for d, s in enumerate(sh)), h00, nent, gmax, imag))
    P('  the chain-map coarse plaquette C2 F: beta * Var (S4: 1/2 at n = 1; n = 2, 4 within 15 %):')
    for n in [1, 2, 4]:
        for G in [32, 64]:
            P('    n=%d grid %d^4: beta*Var = %.6f' % (n, G, c2f_variance(n, G)))

if __name__ == '__main__':
    res = scalar_block()
    scalar_fit(res)
    photon()
    if len(sys.argv) > 1:
        with open(sys.argv[1], 'w', encoding='utf-8') as h: h.write('\n'.join(OUT) + '\n')
