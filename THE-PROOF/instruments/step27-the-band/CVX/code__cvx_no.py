"""CVX — the Nielsen-Olesen threshold on the lattice: the exact [LEFT] charged Hessian of the SU(2) Wilson action at a CONSTANT
abelian field strength (a critical point, so the result is coordinate-free), on (a) the covariant gauge slice ker D*_cov (no block
constraint) and (b) the covariant block slice (the TRANSPORTED linearised Balaban average Q_cov = 0 and D*_cov = 0 at non-coarse sites).
Background: U_l = exp(i beta_l sigma_3), beta_2(x) = f x_1, beta_1(N1-1, x_2, .) = -f N1 x_2, f = 2 pi n/(N1 N2): every (1,2) plaquette at
angle f, all others 0.  Charged field omega = w^1 + i w^2, left-trivialised at the link's start, transported by exp(-2 i beta).
   H_ch[omega] = sum_p [cos Phi_p |sum_k x_k|^2 - 2 sin Phi_p sum_{k<l} Im(conj(x_k) x_l)],
   x1 = omega_1, x2 = e^{-2i b1} omega_2, x3 = -e^{-2i(b1+b2-b3)} omega_3, x4 = -e^{-2i Phi} omega_4.
Run: python -u -E -P code/cvx_no.py L N1,N2,N3,N4 n_list > rec/no_<tag>.<date>.txt     (READING mode)
"""
import sys, os, time, itertools
import numpy as np
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))


class CTorus:
    def __init__(self, L, ext):
        self.L = L
        self.ext = np.array(ext)
        self.sites = [np.array(s) for s in itertools.product(*[range(e) for e in self.ext])]
        self.sidx = {tuple(s): i for i, s in enumerate(self.sites)}
        self.nS = len(self.sites)
        self.nLk = 4 * self.nS
        self.E = np.eye(4, dtype=int)
        E = self.E
        pl = []
        for s in self.sites:
            for mu in range(4):
                for nu in range(mu + 1, 4):
                    pl.append((self.lid(s, mu), self.lid(s + E[mu], nu), self.lid(s + E[nu], mu), self.lid(s, nu), mu, nu))
        self.plaqs = pl
        if L == 2:
            self.bset = [np.array(n) for n in itertools.product(range(2), repeat=4)]
        else:
            self.bset = [np.array(n) for n in itertools.product(range(-(L - 1) // 2, (L - 1) // 2 + 1), repeat=4)]
        self.iscoarse = lambda s: all(s % L == 0)
        self.coarse = [s for s in self.sites if self.iscoarse(s)]
        self.paths = self._paths()

    def lid(self, s, mu):
        return 4 * self.sidx[tuple(np.mod(s, self.ext))] + mu

    def site_of_link(self, l):
        return l // 4, l % 4

    def _contour(self, start, nvec, perm):
        steps = []
        z = start.copy()
        for nu in perm:
            for _ in range(abs(int(nvec[nu]))):
                if nvec[nu] > 0:
                    steps.append((self.lid(z, nu), +1)); z = z + self.E[nu]
                else:
                    z = z - self.E[nu]; steps.append((self.lid(z, nu), -1))
        return steps

    def _paths(self):
        """for each coarse link (y, mu): list of (weight, [(link, eps), ...]) with Balaban's linearised average =
        sum weight * sum eps * A_link (flat)."""
        L, E = self.L, self.E
        out = []
        for y in self.coarse:
            for mu in range(4):
                plist = []
                for nvec in self.bset:
                    nz = [nu for nu in range(4) if nvec[nu] != 0]
                    perms = list(itertools.permutations(nz))
                    w = 1.0 / (L ** 4 * len(perms))
                    for perm in perms:
                        c1 = self._contour(y, nvec, perm)
                        st = [(self.lid(y + nvec + j * E[mu], mu), +1) for j in range(L)]
                        c2 = self._contour(y + L * E[mu], nvec, perm)
                        c2r = [(l, -e) for (l, e) in reversed(c2)]
                        plist.append((w, c1 + st + c2r))
                out.append(((tuple(y), mu), plist))
        return out

    def background(self, f):
        N1 = self.ext[0]
        beta = np.zeros(self.nLk)
        for s in self.sites:
            beta[self.lid(s, 1)] = f * s[0]
            if s[0] == N1 - 1:
                beta[self.lid(s, 0)] = -f * N1 * s[1]
        return beta

    def plaq_angles(self, beta):
        return np.array([beta[a] + beta[b] - beta[c] - beta[d] for (a, b, c, d, mu, nu) in self.plaqs])

    def H_charged(self, beta):
        n = self.nLk
        H = np.zeros((n, n), complex)
        for (a, b, c, d, mu, nu) in self.plaqs:
            Phi = beta[a] + beta[b] - beta[c] - beta[d]
            co = [1.0, np.exp(-2j * beta[a]), -np.exp(-2j * (beta[a] + beta[b] - beta[c])), -np.exp(-2j * Phi)]
            li = [a, b, c, d]
            cP, sP = np.cos(Phi), np.sin(Phi)
            for k in range(4):
                for l in range(4):
                    H[li[k], li[l]] += cP * np.conj(co[k]) * co[l]
            for k in range(4):
                for l in range(k + 1, 4):
                    H[li[k], li[l]] += 1j * sP * np.conj(co[k]) * co[l]
                    H[li[l], li[k]] += -1j * sP * np.conj(co[l]) * co[k]
        return H

    def G_cov(self, beta, only_noncoarse=False):
        """gauge directions: (x, mu) -> lam(x) - e^{-2 i beta_(x,mu)} lam(x + mu); columns over sites (or non-coarse sites)."""
        cols = []
        for s in self.sites:
            if only_noncoarse and self.iscoarse(s):
                continue
            v = np.zeros(self.nLk, complex)
            i = self.sidx[tuple(s)]
            for mu in range(4):
                v[4 * i + mu] += 1.0                                   # link (s, mu) starts at s
                lb = self.lid(s - self.E[mu], mu)                      # link (s - mu, mu) ends at s
                v[lb] += -np.exp(-2j * beta[lb])
            cols.append(v)
        return np.array(cols).T

    def Q_cov(self, beta):
        rows = []
        for (key, plist) in self.paths:
            r = np.zeros(self.nLk, complex)
            for (w, steps) in plist:
                chi = 0.0
                for (l, e) in steps:
                    if e > 0:
                        r[l] += w * np.exp(-2j * chi); chi += beta[l]
                    else:
                        chi -= beta[l]; r[l] += -w * np.exp(-2j * chi)
            rows.append(r)
        return np.array(rows)


def kernel_basis(C, tol=1e-9):
    U, s, Vh = np.linalg.svd(C)
    rk = int((s > tol * s[0]).sum())
    return Vh[rk:].conj().T, rk


def main():
    L = int(sys.argv[1])
    ext = [int(x) for x in sys.argv[2].split(',')]
    nlist = [int(x) for x in sys.argv[3].split(',')]
    t0 = time.time()
    T = CTorus(L, ext)
    N1, N2 = ext[0], ext[1]
    print("torus %s, L = %d: sites %d, links %d, plaquettes %d, coarse sites %d, coarse links %d; f-quantum 2pi/%d = %.6f"
          % (tuple(ext), L, T.nS, T.nLk, len(T.plaqs), len(T.coarse), len(T.paths), N1 * N2, 2 * np.pi / (N1 * N2)))
    # KAT at f = 0: flat average from the path builder vs the integer-scaled Q0 of cvx_core (same torus)
    from cvx_core import Torus
    Tc = Torus(L, ext=tuple(ext))
    Qf = T.Q_cov(np.zeros(T.nLk)).real
    print("S-NO.0 (a) flat path average vs cvx_core Q0/SCALE: max |diff| = %.2e" % np.abs(Qf - Tc.Q0 / Tc.SCALE).max())
    H00 = T.H_charged(np.zeros(T.nLk))
    print("S-NO.0 (b) f = 0: |H_ch - curl^T curl| = %.2e" % np.abs(H00 - Tc.H0c).max())
    for n in nlist:
        f = 2 * np.pi * n / (N1 * N2)
        beta = T.background(f)
        ang = T.plaq_angles(beta)
        cang = np.cos(ang)
        H = T.H_charged(beta)
        G = T.G_cov(beta)
        rng = np.random.default_rng(1)
        lam = rng.normal(size=T.nS) + 1j * rng.normal(size=T.nS)
        gv = G @ lam
        null_def = np.linalg.norm(H @ gv) / np.linalg.norm(gv)
        herm = np.abs(H - H.conj().T).max()
        # (a) covariant gauge slice
        Na, rka = kernel_basis(G.conj().T)
        wa = np.linalg.eigvalsh(Na.conj().T @ H @ Na)
        # (b) covariant block slice
        Gn = T.G_cov(beta, only_noncoarse=True)
        Q = T.Q_cov(beta)
        Cb = np.vstack([Q, Gn.conj().T])
        Nb, rkb = kernel_basis(Cb)
        wb = np.linalg.eigvalsh(Nb.conj().T @ H @ Nb)
        print("n = %2d  f = %.6f: plaquette cos spread [%.6f, %.6f] (cos f = %.6f); |H(gauge)|/|gauge| = %.1e, herm %.1e;"
              % (n, f, cang.min(), cang.max(), np.cos(f), null_def, herm))
        print("        (a) gauge slice dim %d: lambda_min = % .6f  (lambda_min/(-2f) = %.4f), next % .5f % .5f"
              % (Na.shape[1], wa[0], wa[0] / (-2 * f), wa[1], wa[2]))
        print("        (b) block slice dim %d (rank %d): lambda_min = % .6f, next % .5f % .5f   (%.0f s)"
              % (Nb.shape[1], rkb, wb[0], wb[1], wb[2], time.time() - t0))


if __name__ == '__main__':
    main()
