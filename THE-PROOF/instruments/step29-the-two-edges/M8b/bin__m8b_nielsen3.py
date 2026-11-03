"""M8b THE CHROMOMAGNETIC CHECK (READING): at the L = 2 soft-mode crossings, (a) is the background ABELIAN (all link vectors B_l, hence all
plaquette Lie-algebra values X_p, along one colour direction n: the 128 x 3 matrix of link vectors has rank one)?  (b) is the negative
eigenvector v CHARGED (orthogonal to n in colour at every link: sum_l (v_l . n)^2 / |v|^2 = 0)?  If both, the loss of convexity is the
Nielsen-Olesen (Savvidy) instability of charged fluctuations in an abelian chromomagnetic background — the spin coupling ad(F) of the
Yang-Mills Hessian, which the composition term of the split IS in log-holonomy coordinates — cut off in the infrared by the block gap gamma0.
Also: the crossing field against gamma0 at L = 2 and L = 3 (the predicted scaling b_edge proportional to gamma0).
Run: python -u -E -P bin/m8b_nielsen.py WEIGHT BETA > rec/nielsen_<w>.<date>.txt
"""
import os, sys
import numpy as np
here = os.path.dirname(os.path.abspath(__file__))
WEIGHT = sys.argv[1]; BETA = sys.argv[2]
sys.argv = [sys.argv[0], WEIGHT, BETA, '0', 'none', '']
src = open(os.path.join(here, 'm8b_weights3.py'), encoding='utf-8').read()
cut = src.index("if 'repro' in MODES:")
exec(src[:cut])
for j in range(4):
    d = v0[:, j]
    B1 = T @ d
    B1 = B1 / np.linalg.norm(B1.reshape(nLk, 3), axis=1).max()
    sv = np.linalg.svd(B1.reshape(nLk, 3), compute_uv=False)
    lo, hi = 0.0, None
    for t in np.arange(0.05, 1.8001, 0.05):
        lm, am = lam_min(t * B1)
        if lm < 0:
            hi = t; break
        lo = t
    for _ in range(20):
        mid = 0.5 * (lo + hi)
        lm, am = lam_min(mid * B1)
        if lm < 0:
            hi = mid
        else:
            lo = mid
    Bc = hi * B1
    Hf, ang = hess_full(Bc)
    w, U = np.linalg.eigh(T.T @ Hf @ T)
    Uc, sc, Vc = np.linalg.svd(Bc.reshape(nLk, 3), full_matrices=False)
    n = Vc[0]
    out = []
    for k in range(3):
        v = (T @ U[:, k]).reshape(nLk, 3)
        out.append((w[k], float(np.sum((v @ n) ** 2) / np.sum(v ** 2))))
    print("soft mode %d: link-vector singular values of the background (rank one = abelian): %s | crossing b = %.5f, max plaquette angle %.4f | "
          "lowest three eigenpairs (lambda, neutral fraction sum (v.n)^2/|v|^2): %s"
          % (j, np.round(sv / sv[0], 6), hi, ang.max(), "; ".join("(%.4f, %.2e)" % o for o in out)))
    sys.stdout.flush()
