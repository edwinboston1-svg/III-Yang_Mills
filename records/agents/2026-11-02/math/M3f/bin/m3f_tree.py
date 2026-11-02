# M3f S-T1: tree-level two-cutoff contraction, Gaussian scalar analogue (a CHECK, not a proof input).
# G_k(P) = L^{-2k} sum_l Qk(p_l)^2 / phat2(p_l) = int_0^inf ds prod_mu g_k(P_mu, L^{2k} s)
# g_k(q,t) = sum_{l=0}^{L^k-1} Dk(p_l)^2 exp(-4 t sin^2(p_l/2)),  p_l = (q + 2 pi l)/L^k
# G_inf(P) = int_0^inf ds prod_mu f(P_mu, s),  f(q,s) = sum_n phi(q+2 pi n)^2 exp(-s (q+2 pi n)^2)
import numpy as np, sys, math

L = 3
TWO_PI = 2.0 * math.pi

def Dk2(q, Lk):
    # Dk(p_l)^2 for all l at once; p_l = (q + 2 pi l)/Lk; Dk(p) = sin(Lk p/2)/(Lk sin(p/2))
    l = np.arange(Lk)
    p = (q + TWO_PI * l) / Lk
    s_half = np.sin(p / 2.0)
    num = np.sin(Lk * p / 2.0)
    out = np.empty(Lk)
    small = np.abs(s_half) < 1e-300
    out[~small] = (num[~small] / (Lk * s_half[~small])) ** 2
    out[small] = 1.0
    return out, p

def gk(q, t_arr, Lk):
    d2, p = Dk2(q, Lk)
    w = 4.0 * np.sin(p / 2.0) ** 2  # shape (Lk,)
    # sum_l d2_l exp(-t w_l) for each t
    return np.exp(-np.outer(t_arr, w)) @ d2

def phi2(x):
    out = np.ones_like(x)
    nz = np.abs(x) > 1e-14
    out[nz] = (np.sin(x[nz] / 2.0) / (x[nz] / 2.0)) ** 2
    return out

def f_inf(q, s_arr, N=4000):
    n = np.arange(-N, N + 1)
    x = q + TWO_PI * n
    ph = phi2(x)
    out = np.empty_like(s_arr)
    for i in range(0, len(s_arr), 400):
        sc = s_arr[i:i + 400]
        out[i:i + 400] = np.exp(-np.outer(sc, x * x)) @ ph
    # tail |n| > N: phi(q+2 pi n)^2 ~ 4 sin^2(q/2)/(2 pi n)^2, both signs; midpoint rule from M = N + 1/2
    if abs(q) > 0.0:
        M = N + 0.5
        a = 4.0 * math.pi ** 2 * s_arr
        erfc_v = np.array([math.erfc(math.sqrt(ai) * M) for ai in a])
        integ = np.exp(-a * M * M) / M - np.sqrt(math.pi * a) * erfc_v
        out += 2.0 * 4.0 * math.sin(q / 2.0) ** 2 / (4.0 * math.pi ** 2) * integ
    return out

def integrate_u(F, Pmin2, umin=-36.0, h=0.02):
    umax = math.log(200.0 / Pmin2)
    u = np.arange(umin, umax + h, h)
    s = np.exp(u)
    vals = F(s) * s
    return h * (vals.sum() - 0.5 * (vals[0] + vals[-1]))

def G_k(P, k):
    Lk = L ** k
    def F(s):
        t = (Lk ** 2) * s
        out = np.ones_like(s)
        for q in P:
            out *= gk(q, t, Lk)
        return out
    return integrate_u(F, min(x * x for x in P if x != 0))

def G_inf(P):
    def F(s):
        out = np.ones_like(s)
        for q in P:
            out *= f_inf(q, s)
        return out
    return integrate_u(F, min(x * x for x in P if x != 0))

def main():
    # known answer 1: Parseval on a block, sum_l Dk(p_l)^2 = 1
    worst = 0.0
    for k in range(1, 7):
        for q in (0.0, 0.3, 1.0, math.pi / 2, 2.9):
            d2, _ = Dk2(q, L ** k)
            worst = max(worst, abs(d2.sum() - 1.0))
    print(f"KNOWN-ANSWER Parseval sum_l Dk^2 - 1: worst {worst:.3e}")
    # known answer 2: sum_n phi(q+2 pi n)^2 = 1 (truncated, N=4000)
    w2 = 0.0
    for q in (0.0, 0.3, 1.0, math.pi / 2, 2.9):
        n = np.arange(-4000, 4001)
        w2 = max(w2, abs(phi2(q + TWO_PI * n).sum() - 1.0))
    print(f"KNOWN-ANSWER sum_n phi^2 - 1 (N=4000 truncation): worst {w2:.3e}")
    Ps = [(math.pi / 2, 0.0, 0.0, 0.0), (math.pi / 4, math.pi / 4, 0.0, 0.0), (1.0, 0.6, 0.3, 0.1)]
    for P in Ps:
        Ginf = G_inf(P)
        Kinf = 1.0 / Ginf
        P2 = sum(x * x for x in P)
        print(f"P = {tuple(round(x, 6) for x in P)}  |P|^2 = {P2:.6f}  G_inf = {Ginf:.12f}  K_inf = {Kinf:.12f}  K_inf/|P|^2 = {Kinf / P2:.9f}")
        prevR = None
        for k in range(1, 7):
            Gk = G_k(P, k)
            Kk = 1.0 / Gk
            R = (Kk - Kinf) / Kinf
            ratio = (prevR / R) if (prevR is not None and R != 0) else float('nan')
            print(f"  k={k}  G_k = {Gk:.12f}  K_k = {Kk:.12f}  R_k = {R:+.6e}  R_k*L^(2k) = {R * L ** (2 * k):+.6e}  R_(k-1)/R_k = {ratio:.4f}")
            prevR = R
        sys.stdout.flush()

if __name__ == "__main__":
    main()
