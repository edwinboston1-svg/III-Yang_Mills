"""gauss_pipe.py -- AD: the massive-Gaussian known answers (M2c §5.1) put through the SAME fitter and the SAME pair-correlation engine that
read a_c.  The scalar block-averaged field's EXACT second moments (gauss.py's alias sum) are written as one ymc-format .stats record whose
features are the quadratic couplings by hypercubic orbit class to sup-distance r (F_0 = -1/2 sum phi_Y^2, F_k = -sum over class-k pairs
phi_Y phi_Y'; score matching: M_kl = E[grad F_k . grad F_l] per site, b_k = E[Lap F_k] per site = -delta_k0); fit.py's read_stats and
solve return theta (the precision on the pattern); the pair maximal correlation of each class is computed by pairmc.maxcorr on a
Gauss-Hermite grid of the bivariate Gaussian conditional law (log p = -1/2 (h x^2 + h y^2) - t x y), and summed into the row.
usage: python gauss_pipe.py OUTDIR"""
import sys, os, struct, itertools, math
import numpy as np
here = os.path.dirname(os.path.abspath(__file__)); sys.path.insert(0, here)
from gauss import chat_alias
from fit import read_stats, solve
from pairmc import maxcorr

def classes(r):
    cl = {}
    for Y in itertools.product(range(-r, r + 1), repeat=4):
        cl.setdefault(tuple(sorted(abs(c) for c in Y)), []).append(Y)
    keys = sorted(cl, key=lambda k: (max(k), sum(k), k))
    return keys, cl

def write_stats(fn, n, M2, r, LC=16):
    Ch = chat_alias(n, LC, M2)
    if M2 == 0: Ch[0, 0, 0, 0] = 0.0                 # the zero mode removed (the constant field); the Lagrange constraint restores it
    keys, cl = classes(r)
    nf = len(keys)
    # class indicators on the torus (class 0 = the site itself) and M_ab = sum_{Y1 in a, Y2 in b} C(Y1 - Y2) = V^-1 sum_K Chat conj(Ia) Ib
    ind = np.zeros((nf, LC, LC, LC, LC))
    ind[0, 0, 0, 0, 0] = 1.0
    for i, k in enumerate(keys[1:], start=1):
        for Y in cl[k]: ind[(i,) + tuple(c % LC for c in Y)] += 1.0
    F = np.fft.fftn(ind, axes=(1, 2, 3, 4)).reshape(nf, -1)
    M = (np.conj(F) * Ch.ravel()[None, :]) @ F.T / LC ** 4
    M = M.real
    bvec = np.zeros(nf); bvec[0] = -1.0
    with open(fn, 'wb') as h:
        h.write(struct.pack('8i', 1, n * LC, 1, nf, 1, nf, 2, 0)); h.write(struct.pack('i', n)); h.write(struct.pack('d', M2))
        for rep in range(2):                         # two identical 'configurations' so that the jackknife runs (zero error)
            h.write(struct.pack('d', 0.0)); h.write(struct.pack('2d', 0.0, 0.0))
            h.write(M.astype(np.float64).tobytes()); h.write(bvec.astype(np.float64).tobytes()); h.write(np.zeros(nf).tobytes())
            h.write(struct.pack('2q', 1, 0))
    return keys, cl

def pair_rho(h, t, ng=64):
    """maximal correlation of the bivariate Gaussian with precision [[h, t], [t, h]] by Gauss-Hermite Nystrom (exact answer |t|/h)"""
    x, w = np.polynomial.hermite_e.hermegauss(ng)
    s = 1.0 / math.sqrt(h)                           # scale the grid to the conditional width
    X = x * s * 1.6
    lp = -0.5 * h * (X[:, None] ** 2 + X[None, :] ** 2) - t * X[:, None] * X[None, :]
    W = w * np.exp(0.5 * x ** 2) * 1.6 * s  # weights for integrals against dx (undo the e^{-x^2/2} of the rule)
    return maxcorr(lp, W, W)[1]

def main():
    od = sys.argv[1]; os.makedirs(od, exist_ok=True)
    cases = [(2, 3.85), (4, 3.85), (8, 3.85), (4, 'M2=4'), (8, 7.0), (2, 'm0'), (4, 'm0')]
    for (n, spec) in cases:
        if spec == 'm0': M2 = 0.0
        elif spec == 'M2=4': M2 = 4.0
        else: M = 2 * math.sinh(spec / (2 * n)); M2 = M * M
        for r in (1, 2, 5):
            if r == 5 and n >= 8: continue
            fn = os.path.join(od, 'g_n%d_M%.6f_r%d' % (n, M2, r))
            keys, cl = write_stats(fn + '.stats', n, M2, r)
            d = read_stats(fn + '.stats')
            Msum = d['M'][0].sum(0); bsum = d['b'][0].sum(0)
            if M2 == 0:      # massless: the zero mode -- constrain sum_k |class k| theta_k = 0 (Lagrange), as gauss.py (B)
                z = np.array([1.0] + [float(len(cl[k])) for k in keys[1:]])
                nf = len(z); A = np.zeros((nf + 1, nf + 1)); A[:nf, :nf] = Msum; A[:nf, nf] = z; A[nf, :nf] = z
                rhs = np.zeros(nf + 1); rhs[:nf] = -bsum; th = np.linalg.solve(A, rhs)[:nf]
            else:
                th = solve(Msum, bsum, list(range(len(keys))))
            h0 = th[0]
            row_exact = sum(abs(th[i]) * len(cl[keys[i]]) for i in range(1, len(keys))) / h0
            row_pipe = sum(pair_rho(h0, th[i]) * len(cl[keys[i]]) for i in range(1, len(keys)) if abs(th[i]) > 1e-15)
            print('GPIPE n=%d M2=%.8f r=%d: %2d classes; fit.py theta_0 = %.8f; row via maxcorr = %.6f; |t|/h row = %.6f' % (
                n, M2, r, len(keys), h0, row_pipe, row_exact))

if __name__ == '__main__':
    main()
