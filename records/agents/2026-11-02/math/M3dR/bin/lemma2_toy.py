# M3dR toy check of M3d Lemma 2 (iv): the contour rotation M_d for a complex weighted Gaussian.
# COMPUTED only (double precision); a structural toy, not Balaban's operators.
import sys
import numpy as np
from scipy.linalg import sqrtm, inv, eigh, svd, norm

rng = np.random.default_rng(int(sys.argv[1]) if len(sys.argv) > 1 else 1)
n, N = 60, 240
theta0 = 0.25

# plaquette pieces w_p (rows of W), Q0 = W^T W, condition number ~1e4
U, _ = np.linalg.qr(rng.standard_normal((N, N)))
V, _ = np.linalg.qr(rng.standard_normal((n, n)))
s = np.logspace(0, -2, n)                      # singular values 1 .. 1e-2  -> cond(Q0) = 1e4
W = U[:, :n] @ np.diag(s) @ V.T
Q0 = W.T @ W
ev = np.linalg.eigvalsh(Q0)
print(f"cond(Q0) = {ev[-1]/ev[0]:.3e}")

Q0h = np.real(sqrtm(Q0)); Q0mh = inv(Q0h)

def check(dvec, label):
    Qd = W.T @ np.diag(1 + dvec) @ W
    K = Q0mh @ (Qd - Q0) @ Q0mh
    nK = norm(K, 2)
    # M3d's rotation and the alternative
    MB = inv(sqrtm(Qd)) @ Q0h
    MA = Q0mh @ inv(sqrtm(np.eye(n) + K)) @ Q0h
    out = [f"[{label}] ||K|| = {nK:.4f}"]
    for name, M in (("M^B (M3d)", MB), ("M^A (alt)", MA)):
        res = norm(M.T @ Qd @ M - Q0, 2) / norm(Q0, 2)
        Et = Q0h @ (M - np.eye(n)) @ Q0mh
        nE = norm(Et, 2)
        nplain = norm(M - np.eye(n), 2)
        mins = []
        for t in np.linspace(0, 1, 21):
            S = (np.eye(n) + t * Et).T @ (np.eye(n) + K) @ (np.eye(n) + t * Et)
            ReS = np.real(S); ReS = 0.5 * (ReS + ReS.T)
            mins.append(np.linalg.eigvalsh(ReS)[0])
        out.append(f"   {name}: |M^T Qd M - Q0|/|Q0| = {res:.2e}; ||Etilde|| (relative) = {nE:.4f}; "
                   f"||M - I|| (plain) = {nplain:.4f}; min_t lambda_min(Re S_t) = {min(mins):.4f}")
    print("\n".join(out))

# S-2: d(p) i.i.d. uniform in the disc |d| <= theta0/2 (NOT nearly constant)
r = (theta0 / 2) * np.sqrt(rng.random(N)); ph = 2 * np.pi * rng.random(N)
check(r * np.exp(1j * ph), "S-2 iid disc")
# S-2': worst-ish: d(p) = +- i theta0/2 alternating by a random sign
check(1j * (theta0 / 2) * np.sign(rng.standard_normal(N)), "S-2' +-i theta0/2")
# S-3: nearly constant d = 0.1i + delta, |delta| <= 1e-3
dl = 0.1j
dd = 1e-3 * np.sqrt(rng.random(N)) * np.exp(2j * np.pi * rng.random(N))
check(dl + dd, "S-3 nearly constant")
