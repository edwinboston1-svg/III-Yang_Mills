# MG2 g2_read2.py -- the n = 1 planar two-face reading in the CHARACTER BASIS (exact projection on the truncated span), and the crossover
# matching.  Physical joint law of the two plaquette loops: p(A,B) = w(A) w(B) rho_link(A,B) / Z, rho_link = sum_{c,d} chi_c(A) K_cd chi_d(B),
# K = diag(phiX) M diag(phiX), phiX = (phi^(5))^3, M_cd = E_{w^4}[chi_c chi_d].  For F = sum u_a chi_a, G = sum v_b chi_b:
#   E[FG] = u^T Wm K Wm^T v / Z,  Wm_ac = int chi_a chi_c w;  Gram_A = sum_c T_{aa'c} (K s)_c / Z,  T_{aa'c} = int chi_a chi_a' chi_c w,  s = Wm e0.
import sys
import numpy as np
from g2_window import group

def coeffs(g, beta, k, L, chis, dims):
    d = g.dim(g.rho); chir = g.chi(g.rho)
    f = np.exp((k * beta / d) * chir - k * beta); f = f / np.sum(g.h * f)
    return f, np.array([np.sum(g.h * chis[i] * f) / dims[i] for i in range(len(L))])

def read(g, beta, Cspan, CK, datum='ordered', even=False):
    LK = g.irreps(CK); chisK = np.array([g.chi(l) for l in LK]); dimsK = np.array([g.dim(l) for l in LK])
    span = [i for i, l in enumerate(LK) if g.C2(l) <= Cspan + 1e-9 and (not even or np.sum(l) % 2 == 0)]
    w, phi1 = coeffs(g, beta, 1, LK, chisK, dimsK)
    if datum == 'free':
        phiX = np.array([1.0 if np.sum(l) == 0 else 0.0 for l in LK]); f4 = np.ones_like(w)
    else:
        f5, phi5 = coeffs(g, beta, 5, LK, chisK, dimsK); f4, _ = coeffs(g, beta, 4, LK, chisK, dimsK); phiX = phi5 ** 3
    hw = g.h * w
    M = (chisK * (g.h * f4)) @ chisK.T
    K = phiX[:, None] * M * phiX[None, :]
    Wm = (chisK * hw) @ chisK.T                                  # int chi_a chi_c w
    s = Wm[:, 0]                                                 # int chi_c w  (chi_0 = 1)
    Ks = K @ s; Z = s @ Ks
    S = np.ix_(span, range(len(LK)))
    EFG = (Wm[span, :] @ K @ Wm[:, span]) / Z
    mA = EFG[:, [span.index(0)]].flatten() if 0 in span else None
    chs = chisK[span]
    Gram = np.zeros((len(span), len(span)))
    for c in range(len(LK)):
        if abs(Ks[c]) < 1e-300: continue
        Gram += Ks[c] * ((chs * (hw * chisK[c])) @ chs.T)
    Gram /= Z
    i0 = span.index(0)
    mvec = Gram[:, i0]                                           # E[chi_a(A)]
    Cov = EFG - np.outer(mvec, mvec)
    CA = Gram - np.outer(mvec, mvec)
    ev, U = np.linalg.eigh(CA)
    keep = ev > ev.max() * 1e-12
    T = U[:, keep] / np.sqrt(ev[keep])
    sv = np.linalg.svd(T.T @ Cov @ T, compute_uv=False)
    # positivity of the truncated link kernel on the grid (a check)
    rho = chisK.T @ K @ chisK
    return dict(nK=len(LK), nspan=len(span), maxcorr=sv[0], second=sv[1] if len(sv) > 1 else 0.0, a_rho=phi1[[i for i, l in enumerate(LK) if tuple(l) == tuple(g.rho)][0]],
                tail=float(np.abs(phiX[-max(1, len(LK)//10):]).max()), posmin=float(rho.min() / np.abs(rho).max()), dims_top=int(dimsK[-1]))

if __name__ == '__main__':
    mode = sys.argv[1]
    if mode == 'cross':
        gs = group('SU2', 256); L = gs.irreps(20); ch = np.array([gs.chi(l) for l in L]); dm = np.array([gs.dim(l) for l in L])
        for b in [2.2, 2.3]:
            _, ph = coeffs(gs, b, 1, L, ch, dm); print('SU(2) a_1/2(%.2f) = %.8f' % (b, ph[1]))
        target = {b: coeffs(gs, b, 1, L, ch, dm)[1][1] for b in [2.2, 2.3]}
        gg = group('G2', 128); L2 = gg.irreps(30); ch2 = np.array([gg.chi(l) for l in L2]); dm2 = np.array([gg.dim(l) for l in L2])
        def a7(b): return coeffs(gg, b, 1, L2, ch2, dm2)[1][1]
        for b in [7.875, 9.45, 10.0, 12.0, 15.0, 20.0]:
            print('G2 a_7(%.3f) = %.8f' % (b, a7(b)))
        for b0, t in target.items():
            lo, hi = 5.0, 40.0
            for _ in range(60):
                mid = (lo + hi) / 2
                if a7(mid) < t: lo = mid
                else: hi = mid
            print('G2 coupling matching a_7 = a_1/2(SU(2) at %.2f) = %.6f : beta = %.5f' % (b0, t, lo))
    else:
        name, beta, ng, Cspan, CK = sys.argv[2], float(sys.argv[3]), int(sys.argv[4]), float(sys.argv[5]), float(sys.argv[6])
        datum = sys.argv[7] if len(sys.argv) > 7 else 'ordered'
        g = group(name, ng)
        R = read(g, beta, Cspan, CK, datum)
        line = '== %s beta=%g datum=%s grid=%d Cspan=%g CK=%g (span %d of %d irreps, top dim %d) a_rho=%.6f tail(phiX)=%.1e rho_link min/max=%.1e | MAXCORR=%.6f next=%.6f' % (
            g.name, beta, datum, ng, Cspan, CK, R['nspan'], R['nK'], R['dims_top'], R['a_rho'], R['tail'], R['posmin'], R['maxcorr'], R['second'])
        if name == 'SU2':
            Re = read(g, beta, Cspan, CK, datum, even=True)
            line += ' | centre-even (SO(3)) MAXCORR=%.6f' % Re['maxcorr']
        print(line)
