# UV2: the SINGLE-SCALE (bulk) slice-Poincare scalar constant by Bloch-Floquet, EXACT formula (WORK.md section 4):
#   R_n(k) = a n^{-2} sigma_B(k) S2(k)^2 / S3(k),   S_p(k) = sum_{m in {0..n-1}^d} |h_m|^2 / sigma_m^p,
#   theta_m = (k + 2 pi m)/n,  |h_m|^2 = prod_i sin^2(k_i/2) / (n^2 sin^2(theta_{m,i}/2)),  sigma(theta) = sum_i 4 sin^2(theta_i/2).
#   c_bulk(n,d) = inf_{k != 0} R_n(k).   Double precision on a grid + local refinement: a READING; the certified value is in
#   uv2_bloch_cert.py (interval arithmetic at the minimizer and a Lipschitz enclosure).
import sys, itertools, time
import numpy as np

def R(n, d, K):
    """K: array (P, d) of block momenta in (0, pi]^d (no zero component handled separately). Returns R_n(k) (a = 1)."""
    K = np.atleast_2d(K)
    P = K.shape[0]
    ms = np.array(list(itertools.product(range(n), repeat=d)), dtype=float)        # (n^d, d)
    S2 = np.zeros(P); S3 = np.zeros(P)
    sk2 = np.sin(K / 2) ** 2                                                       # (P, d)
    for chunk in np.array_split(np.arange(ms.shape[0]), max(1, ms.shape[0] // 256)):
        th = (K[:, None, :] + 2 * np.pi * ms[None, chunk, :]) / n                  # (P, c, d)
        st2 = np.sin(th / 2) ** 2
        with np.errstate(divide='ignore', invalid='ignore'):
            h2 = np.prod(np.where(st2 > 0, sk2[:, None, :] / (n * n * st2), 1.0), axis=2)
        sig = 4 * st2.sum(axis=2)
        S2 += (h2 / sig ** 2).sum(axis=1); S3 += (h2 / sig ** 3).sum(axis=1)
    sB = 4 * sk2.sum(axis=1)
    return sB * S2 ** 2 / (S3 * n * n)

def scan(n, d, g):
    # grid on (0, pi]^d; by the symmetries k_i -> -k_i and permutations, restrict to 0 < k_1 <= ... <= k_d <= pi
    ks = np.pi * (np.arange(1, g + 1) / g)
    best = (np.inf, None)
    pts = np.array([p for p in itertools.combinations_with_replacement(ks, d)])
    vals = np.concatenate([R(n, d, pts[i:i + 4096]) for i in range(0, len(pts), 4096)])
    i = int(np.argmin(vals))
    return vals[i], pts[i], vals

if __name__ == "__main__":
    rec = open(sys.argv[1], 'a', encoding='utf-8') if len(sys.argv) > 1 else None
    def say(s):
        print(s, flush=True)
        if rec: rec.write(s + "\n"); rec.flush()
    for d, ns, g in ((1, (2, 3, 4, 6, 8, 16, 32), 400), (2, (2, 3, 4, 6, 8, 12, 16), 60), (3, (2, 3, 4, 6, 8), 24), (4, (2, 3, 4, 6), 12)):
        for n in ns:
            t0 = time.time()
            v, k, vals = scan(n, d, g)
            corner = R(n, d, np.full((1, d), np.pi))[0]
            # also the stripe and the smallest-k behaviour
            stripe = R(n, d, np.array([[np.pi] + [1e-9] * (d - 1)]))[0] if d > 1 else corner
            small = R(n, d, np.full((1, d), 1e-3))[0]
            say(f"d={d} n={n:2d}: grid min R = {v:.6f} at k/pi = {np.round(k / np.pi, 3)}; R(pi,...,pi) = {corner:.6f}; "
                f"R(stripe) = {stripe:.6f}; R(k->0) = {small:.6f} [{time.time() - t0:.1f}s]")
    if rec: rec.close()
