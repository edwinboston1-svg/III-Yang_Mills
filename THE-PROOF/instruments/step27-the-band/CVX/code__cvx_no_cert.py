"""CVX — the constant-field (Nielsen-Olesen) spectrum CERTIFIED two-sided at every quantised flux of a torus.  (v2, after review)
Lower side: Finsler + verified Cholesky on the real embedding of A = H - mu I + kappa C^dag C (complex Hermitian), mu = reading - margin.
Upper side: Rayleigh quotient of the computed eigenvector v, corrected into ker C EXACTLY by the minimal-norm projection delta, with
||delta|| <= ||C v|| / sigma_min(C), sigma_min(C)^2 >= lo CERTIFIED by a verified Cholesky of C C^dag - s I (lo = s - residual > 0 required).
ERROR MODEL (cancellation-safe): absolute budgets on the STRUCTURAL nonzero pattern — every H entry touched by a plaquette and every C
entry touched by a gauge column or an averaging path carries |error| <= 1e-12 (the a-priori bound is ~1e-13: phases are exact roots of
unity rounded once from a 30-digit table, at most four phase products and 40 summands per entry); propagated into C^dag C as
dC (S^T|C| + |C|^T S) + dC^2 S^T S + (m + 2) u |C|^T |C|, and the assembly of A as 4u (|H| + |mu| I + kappa |C|^T|C|).
Run: [CVX_MARGIN=0.05] python -u -E -P code/cvx_no_cert.py L N1,N2,N3,N4 n_list > rec/no_cert_<tag>.<date>.txt
"""
import sys, os, time, gc
import numpy as np
import mpmath as mp
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from cvx_no import CTorus, kernel_basis
from cvx_verify import verified_lmin_lower

U = 2.0 ** -53
DH = 1e-12
DC = 1e-12
MARGIN = float(os.environ.get("CVX_MARGIN", "0.01"))


class ExactPhases:
    def __init__(self, M):
        mp.mp.dps = 30
        self.M = M
        self.tab = np.array([complex(float(mp.cos(2 * mp.pi * k / M)), float(mp.sin(2 * mp.pi * k / M))) for k in range(M)])

    def e(self, k):
        return self.tab[int(k) % self.M]


def build(T, n, ph):
    """H, G, Gn, Q and their structural patterns (touched entries)."""
    N1, N2 = T.ext[0], T.ext[1]
    m = np.zeros(T.nLk, dtype=np.int64)
    for s in T.sites:
        m[T.lid(s, 1)] = s[0]
        if s[0] == N1 - 1:
            m[T.lid(s, 0)] = -N1 * s[1]
    E = lambda k: ph.e(-2 * n * k)
    f = 2 * np.pi * n / (N1 * N2)
    nL = T.nLk
    H = np.zeros((nL, nL), complex)
    SH = np.zeros((nL, nL), dtype=bool)
    for (a, b, c, d, mu, nu) in T.plaqs:
        kp = m[a] + m[b] - m[c] - m[d]
        eP = ph.e(n * kp)
        cP, sP = eP.real, eP.imag
        co = [1.0, E(m[a]), -E(m[a] + m[b] - m[c]), -E(kp)]
        li = [a, b, c, d]
        for k in range(4):
            for l in range(4):
                H[li[k], li[l]] += cP * np.conj(co[k]) * co[l]
                SH[li[k], li[l]] = True
        for k in range(4):
            for l in range(k + 1, 4):
                H[li[k], li[l]] += 1j * sP * np.conj(co[k]) * co[l]
                H[li[l], li[k]] += -1j * sP * np.conj(co[l]) * co[k]

    def Gmat(only_nc):
        cols, pats = [], []
        for s in T.sites:
            if only_nc and T.iscoarse(s):
                continue
            v = np.zeros(nL, complex); p = np.zeros(nL, dtype=bool)
            i = T.sidx[tuple(s)]
            for mu in range(4):
                v[4 * i + mu] += 1.0; p[4 * i + mu] = True
                lb = T.lid(s - T.E[mu], mu)
                v[lb] += -E(m[lb]); p[lb] = True
            cols.append(v); pats.append(p)
        return np.array(cols).T, np.array(pats).T
    G, SG = Gmat(False)
    Gn, SGn = Gmat(True)
    rows, pats = [], []
    for (key, plist) in T.paths:
        r = np.zeros(nL, complex); p = np.zeros(nL, dtype=bool)
        for (w, steps) in plist:
            chi = 0
            for (l, e) in steps:
                p[l] = True
                if e > 0:
                    r[l] += w * E(chi); chi += m[l]
                else:
                    chi -= m[l]; r[l] += -w * E(chi)
        rows.append(r); pats.append(p)
    return H, SH, G, SG, Gn, SGn, np.array(rows), np.array(pats), f


def realemb(A):
    return np.block([[A.real, -A.imag], [A.imag, A.real]])


def ea_A_rows(H, SH, C, SC, kappa, mu, r0, r1):
    """entrywise bound on |A_true - A_float| for rows r0:r1 of A = H - mu I + kappa C^dag C."""
    m = C.shape[0]
    aC = np.abs(C); S = SC.astype(float)
    dCC = DC * (S[:, r0:r1].T @ aC + aC[:, r0:r1].T @ S) + DC * DC * (S[:, r0:r1].T @ S) + (m + 2) * U * (aC[:, r0:r1].T @ aC)
    E = DH * SH[r0:r1].astype(float) + kappa * dCC + 4 * U * (np.abs(H[r0:r1]) + kappa * (aC[:, r0:r1].T @ aC))
    E[np.arange(r1 - r0), np.arange(r0, r1)] += 4 * U * abs(mu)
    return E


def kappa_for(H, C, mu, margin):
    sv = np.linalg.svd(C, compute_uv=False)
    smin = sv[sv > 1e-9 * sv[0]].min()
    N = np.abs(H - mu * np.eye(H.shape[0])).sum(axis=1).max()
    return 2.0 ** np.ceil(np.log2(4 * (N + N * N / margin) / smin ** 2))


def lower_bound(H, SH, C, SC, lam_read, margin, blk=486):
    """Finsler + verified Cholesky, residual by row blocks (memory-light); returns (mu, certified lower bound on lambda_min(A), rb, kappa)."""
    mu = lam_read - margin
    n = H.shape[0]
    kappa = kappa_for(H, C, mu, margin)
    delta = 0.25 * margin

    def A_rows(r0, r1):
        Ar = H[r0:r1, :] + kappa * (C[:, r0:r1].conj().T @ C)
        Ar[np.arange(r1 - r0), np.arange(r0, r1)] -= mu
        return Ar
    R = np.empty((2 * n, 2 * n))
    for r0 in range(0, n, blk):
        r1 = min(n, r0 + blk)
        Ar = A_rows(r0, r1)
        R[r0:r1, :n] = Ar.real; R[r0:r1, n:] = -Ar.imag
        R[n + r0:n + r1, :n] = Ar.imag; R[n + r0:n + r1, n:] = Ar.real
    R[np.arange(2 * n), np.arange(2 * n)] -= delta
    try:
        Lf = np.linalg.cholesky(R)
    except np.linalg.LinAlgError:
        return mu, None, None, kappa
    del R; gc.collect()
    rn = np.linalg.norm(Lf, axis=1) * (1 + 2 * n * U)
    rn_sum = rn.sum() * (1 + 2 * n * U)
    g = (2 * n + 2) * U / (1 - (2 * n + 2) * U)
    rowsum = np.zeros(2 * n)
    for r0 in range(0, n, blk):
        r1 = min(n, r0 + blk)
        Ar = A_rows(r0, r1)
        Ec = ea_A_rows(H, SH, C, SC, kappa, mu, r0, r1)
        for half in (0, 1):
            rows = np.arange(r0, r1) + half * n
            Rb = np.empty((r1 - r0, 2 * n))
            if half == 0:
                Rb[:, :n] = Ar.real; Rb[:, n:] = -Ar.imag
            else:
                Rb[:, :n] = Ar.imag; Rb[:, n:] = Ar.real
            Rb[np.arange(r1 - r0), rows] -= delta
            Rc = Rb - Lf[rows] @ Lf.T
            bnd = np.abs(Rc) * (1 + U) + U * np.abs(Rb)
            bnd[:, :n] += Ec; bnd[:, n:] += Ec
            rowsum[rows] = bnd.sum(axis=1) + g * rn[rows] * rn_sum
    rb = rowsum.max() * (1 + 8 * n * U) + 1e-300
    del Lf; gc.collect()
    return mu, delta - rb, rb, kappa


def upper_bound(H, SH, C, SC, v):
    m, n = C.shape
    aC = np.abs(C); S = SC.astype(float)
    CCt = C @ C.conj().T
    Ecc = DC * (S @ aC.T + aC @ S.T) + DC * DC * (S @ S.T) + (n + 2) * U * (aC @ aC.T)
    EA = np.block([[Ecc, Ecc], [Ecc, Ecc]])
    s2 = np.linalg.eigvalsh(CCt)[0]
    s2c = 0.5 * s2
    smin2 = None
    for _ in range(4):
        lo, rb = verified_lmin_lower(realemb(CCt), s2c, EA)
        if lo is not None and lo > 0:
            smin2 = lo
            break
        s2c *= 0.5
    if smin2 is None:
        raise RuntimeError("sigma_min(C) not certified")
    smin_c = np.sqrt(smin2) * (1 - 1e-15)
    av = np.abs(v)
    r = C @ v
    rnorm = np.linalg.norm(r) * (1 + U) + DC * np.linalg.norm(S @ av) + (n + 2) * U * np.linalg.norm(aC @ av)
    rnorm *= (1 + 4 * n * U)
    dnorm = rnorm / smin_c * (1 + 1e-15)
    aH = np.abs(H); sH = SH.astype(float)
    Hv = H @ v
    num = np.vdot(v, Hv).real
    num_err = DH * (av @ sH @ av) + 2 * (n + 2) * U * (av @ aH @ av)
    Hvn = (np.linalg.norm(Hv) * (1 + U) + DH * np.linalg.norm(sH @ av) + (n + 2) * U * np.linalg.norm(aH @ av)) * (1 + 4 * n * U)
    Hn = (aH + DH * sH).sum(axis=1).max() * (1 + 2 * n * U)
    Nup = num + num_err + 2 * dnorm * Hvn + Hn * dnorm ** 2
    Nup = Nup + 1e-15 * abs(Nup)
    vn = np.linalg.norm(v)
    Dlo, Dhi = (vn * (1 - 2 * n * U) - dnorm) ** 2, (vn * (1 + 2 * n * U) + dnorm) ** 2
    up = Nup / Dhi if Nup < 0 else Nup / Dlo
    return up + 1e-14 * abs(up), dnorm, smin_c


def main():
    L = int(sys.argv[1]); ext = [int(x) for x in sys.argv[2].split(',')]; nlist = [int(x) for x in sys.argv[3].split(',')]
    t0 = time.time()
    T = CTorus(L, ext)
    ph = ExactPhases(ext[0] * ext[1])
    print("torus %s L = %d: certified two-sided enclosures of the lowest charged eigenvalue at constant flux f = 2 pi n / %d (margin %g)"
          % (tuple(ext), L, ext[0] * ext[1], MARGIN))
    for n in nlist:
        H, SH, G, SG, Gn, SGn, Q, SQ, f = build(T, n, ph)
        out = []
        for name, C, SC in (('(a) gauge slice', G.conj().T, SG.T), ('(b) covariant block slice', np.vstack([Q, Gn.conj().T]), np.vstack([SQ, SGn.T]))):
            Nb, rk = kernel_basis(C)
            w, Uv = np.linalg.eigh(Nb.conj().T @ H @ Nb)
            lam = w[0]
            v = Nb @ Uv[:, 0]
            del Nb, Uv; gc.collect()
            mu, lo, rb, kappa = lower_bound(H, SH, C, SC, lam, MARGIN)
            up, dn, smc = upper_bound(H, SH, C, SC, v)
            ok = lo is not None and lo >= 0
            out.append("%s: lambda_min in [%.6f, %.6f] %s (READING %.6f; Finsler kappa 2^%d, residual %.1e; |delta| %.1e; sigma_min(C) >= %.4f certified)"
                       % (name, mu if ok else float('nan'), up, 'CERTIFIED' if ok else 'LOWER SIDE NOT CERTIFIED', lam,
                          int(np.log2(kappa)), rb if rb is not None else float('nan'), dn, smc))
        print("n = %2d f = %.6f:\n   %s\n   %s   [%.0f s]" % (n, f, out[0], out[1], time.time() - t0), flush=True)


if __name__ == '__main__':
    main()
