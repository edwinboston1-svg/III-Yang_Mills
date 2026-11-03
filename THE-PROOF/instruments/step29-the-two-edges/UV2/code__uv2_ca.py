# UV2: C_a^opt(n,d) = sup_k n^4/(sigma_B(k) S2(k)) on a k-grid (the bulk Delta^2-energy of the minimal extension per unit coarse
# energy), and the discrete blend-profile sums X0, X1, X2 of WORK.md section 8 (exact finite sums).  READING, double precision.
import sys, itertools, numpy as np
def S2(n, d, K):
    ms = np.array(list(itertools.product(range(n), repeat=d)), dtype=float)
    out = np.zeros(len(K))
    for j, k in enumerate(K):
        th = (k[None, :] + 2 * np.pi * ms) / n
        st2 = np.sin(th / 2) ** 2
        h2 = np.prod(np.where(st2 > 0, np.sin(k / 2)[None, :] ** 2 / (n * n * st2), 1.0), axis=1)
        out[j] = (h2 / (4 * st2.sum(axis=1)) ** 2).sum()
    return out
for d, ns, g in ((2, (2, 4, 8), 40), (4, (2, 3, 4, 6), 8)):
    for n in ns:
        K = np.array(list(itertools.combinations_with_replacement(np.pi * np.arange(1, g + 1) / g, d)))
        sB = 4 * (np.sin(K / 2) ** 2).sum(axis=1)
        val = n ** 4 / (sB * S2(n, d, K))
        i = int(np.argmax(val))
        print(f"d={d} n={n}: C_a^opt = {val[i]:.4f} at k/pi = {np.round(K[i] / np.pi, 3)}", flush=True)
for L in (2, 3, 4, 6, 8):
    # q(s) = (1-s)^2 (1 - beta s), beta solving sum_{t=0}^{L-1} q(t/L) = 0
    t = np.arange(L) / L
    beta = ((1 - t) ** 2).sum() / ((1 - t) ** 2 * t).sum()
    q = lambda s: np.where(s < 1, (1 - s) ** 2 * (1 - beta * s), 0.0)
    ch = q(np.arange(L + 2) / L)                          # chi(0..L+1), chi(L) = chi(L+1) = 0
    X0 = (ch[:L] ** 2).sum(); X1 = ((ch[1:L + 1] - ch[:L]) ** 2).sum()
    X2 = ((ch[2:L + 2] - 2 * ch[1:L + 1] + ch[:L]) ** 2).sum()   # second differences at t = 1..L (t = 0 handled separately)
    print(f"L={L}: beta={beta:.4f} chi={np.round(ch[:L + 1], 4)} sum={ch[:L].sum():.2e} X0={X0:.4f} X1={X1:.4f} (L*X1={L * X1:.3f}) X2={X2:.4f} (L^3*X2={L ** 3 * X2:.3f})")
