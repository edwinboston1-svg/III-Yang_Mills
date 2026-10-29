#!/usr/bin/env python
# wilsonloops.py -- Edwin Boston III, 2026-10-29. A READING, not a certificate.
# The running of the coupling under blocking, measured where it must act: Wilson loops W(R,T), R,T <= 4, on a periodic
# N^4 lattice, Creutz ratios chi(I,I) = -ln[W(I,I)W(I-1,I-1)/(W(I,I-1)W(I-1,I))], and the one-step blocked couplings by
# matching the I x I loop to one plaquette, c_1(beta_eff(I a)) = W(I,I) (SU(2): m(beta) = I2/I1 inverted; U(1): I1/I0 inverted).
# STAKES (written before the run; OPEN/the-crossing.md section 3b):
#  S5 SU(2) at beta = 2.3: chi(2,2), chi(3,3), chi(4,4) fall toward a plateau in [0.10, 0.20] (the string tension sigma a^2
#     at this coupling, sqrt(sigma) a = 0.37); the matched coupling runs: beta_eff(2a) in [0.9, 1.6], beta_eff(4a) in [0.25, 0.7].
#  S6 U(1) at beta = 1.2 (Coulomb): chi(I,I) falls below 0.05 by I = 4 (perimeter law); beta_eff(Ia) stays within a factor
#     1.5 of 1.2 for I = 2 and does not fall below 0.6 at I = 4.
#  S7 U(1) at beta = 0.9 (confining, the control): chi(I,I) plateaus above 0.3 and beta_eff(2a) < 0.4.
# usage: python wilsonloops.py su2|u1 beta N therm meas stride seed
import sys, math, random, time
import numpy as np
group, beta, N = sys.argv[1], float(sys.argv[2]), int(sys.argv[3])
TH, NM, STRIDE, seed = int(sys.argv[4]), int(sys.argv[5]), int(sys.argv[6]), int(sys.argv[7])
random.seed(seed); np.random.seed(seed)
D = 4; NSITE = N ** D
def site(x): return ((x[0] * N + x[1]) * N + x[2]) * N + x[3]
def coords(s): return (s // (N * N * N), (s // (N * N)) % N, (s // N) % N, s % N)
def shift(x, mu, d):
    y = list(x); y[mu] = (y[mu] + d) % N; return tuple(y)
def qmul(p, q):
    return (p[0]*q[0] - p[1]*q[1] - p[2]*q[2] - p[3]*q[3],
            p[0]*q[1] + p[1]*q[0] - (p[2]*q[3] - p[3]*q[2]),
            p[0]*q[2] + p[2]*q[0] - (p[3]*q[1] - p[1]*q[3]),
            p[0]*q[3] + p[3]*q[0] - (p[1]*q[2] - p[2]*q[1]))
def qconj(p): return (p[0], -p[1], -p[2], -p[3])
def qadd(p, q): return (p[0]+q[0], p[1]+q[1], p[2]+q[2], p[3]+q[3])
def qrand():
    while True:
        v = [random.gauss(0, 1) for _ in range(4)]; n = math.sqrt(sum(t*t for t in v))
        if n > 1e-12: return tuple(t / n for t in v)
def kp_a0(alpha):
    while True:
        r1, r2, r3, r4 = random.random(), random.random(), random.random(), random.random()
        X = -math.log(1 - r1) / alpha; Xp = -math.log(1 - r2) / alpha
        c = math.cos(2 * math.pi * r3); delta = X * c * c + Xp
        if r4 * r4 <= 1 - delta / 2: return 1 - delta
if group == "su2":
    U = [[(1.0, 0.0, 0.0, 0.0) for _ in range(D)] for _ in range(NSITE)]
    def staple(x, mu):
        S = (0.0, 0.0, 0.0, 0.0); xm = shift(x, mu, 1)
        for nu in range(D):
            if nu == mu: continue
            xn = shift(x, nu, 1); xb = shift(x, nu, -1); xmb = shift(xm, nu, -1)
            S = qadd(S, qmul(qmul(U[site(xm)][nu], qconj(U[site(xn)][mu])), qconj(U[site(x)][nu])))
            S = qadd(S, qmul(qmul(qconj(U[site(xmb)][nu]), qconj(U[site(xb)][mu])), U[site(xb)][nu]))
        return S
    def hb(x, mu):
        S = staple(x, mu); k = math.sqrt(sum(t*t for t in S))
        if k < 1e-12: U[site(x)][mu] = qrand(); return
        V = tuple(t / k for t in S); a0 = kp_a0(beta * k); r = math.sqrt(max(0.0, 1 - a0*a0))
        ct = 2*random.random() - 1; st = math.sqrt(1 - ct*ct); ph = 2*math.pi*random.random()
        U[site(x)][mu] = qmul((a0, r*st*math.cos(ph), r*st*math.sin(ph), r*ct), qconj(V))
    def loop(x, mu, nu, R, T):
        """(1/2) tr of the R x T Wilson loop at x in the (mu, nu) plane."""
        P = (1.0, 0.0, 0.0, 0.0); y = x
        for _ in range(R): P = qmul(P, U[site(y)][mu]); y = shift(y, mu, 1)
        for _ in range(T): P = qmul(P, U[site(y)][nu]); y = shift(y, nu, 1)
        for _ in range(R): y = shift(y, mu, -1); P = qmul(P, qconj(U[site(y)][mu]))
        for _ in range(T): y = shift(y, nu, -1); P = qmul(P, qconj(U[site(y)][nu]))
        return P[0]
else:
    U = [[0.0 for _ in range(D)] for _ in range(NSITE)]
    def hb(x, mu):
        S = 0j; xm = shift(x, mu, 1)
        for nu in range(D):
            if nu == mu: continue
            xn = shift(x, nu, 1); xb = shift(x, nu, -1); xmb = shift(xm, nu, -1)
            S += np.exp(1j * (U[site(xm)][nu] - U[site(xn)][mu] - U[site(x)][nu]))
            S += np.exp(1j * (-U[site(xmb)][nu] - U[site(xb)][mu] + U[site(xb)][nu]))
        k = abs(S)
        U[site(x)][mu] = random.uniform(-math.pi, math.pi) if k < 1e-12 else float(np.random.vonmises(-np.angle(S), beta * k))
    def loop(x, mu, nu, R, T):
        th = 0.0; y = x
        for _ in range(R): th += U[site(y)][mu]; y = shift(y, mu, 1)
        for _ in range(T): th += U[site(y)][nu]; y = shift(y, nu, 1)
        for _ in range(R): y = shift(y, mu, -1); th -= U[site(y)][mu]
        for _ in range(T): y = shift(y, nu, -1); th -= U[site(y)][nu]
        return math.cos(th)
links = [(coords(s), mu) for s in range(NSITE) for mu in range(D)]
print(f"group={group} beta={beta} N={N} therm={TH} meas={NM} stride={STRIDE} seed={seed}", flush=True)
t0 = time.time()
for sweep in range(TH):
    for (x, mu) in links: hb(x, mu)
print(f"thermalised in {time.time() - t0:.0f} s", flush=True)
RT = [(R, T) for R in range(1, 5) for T in range(1, 5)]
acc = {rt: [] for rt in RT}
planes = [(0, 1), (2, 3)]
sites_sub = [coords(s) for s in range(NSITE) if sum(coords(s)) % 2 == 0]   # every second site
for m in range(NM):
    for _ in range(STRIDE):
        for (x, mu) in links: hb(x, mu)
    for rt in RT:
        R, T = rt
        v = sum(loop(x, mu, nu, R, T) for x in sites_sub for (mu, nu) in planes) / (len(sites_sub) * len(planes))
        acc[rt].append(v)
    if (m + 1) % 10 == 0:
        print(f"  measurement {m + 1}/{NM}  W(1,1) = {np.mean(acc[(1,1)]):.5f}  W(2,2) = {np.mean(acc[(2,2)]):.5f}  ({time.time() - t0:.0f} s)", flush=True)
W = {rt: (float(np.mean(acc[rt])), float(np.std(acc[rt]) / math.sqrt(len(acc[rt])))) for rt in RT}
for rt in RT:
    print(f"W({rt[0]},{rt[1]}) = {W[rt][0]:.6f} +- {W[rt][1]:.6f}")
for I in (2, 3, 4):
    a, b, c, d = W[(I, I)][0], W[(I-1, I-1)][0], W[(I, I-1)][0], W[(I-1, I)][0]
    chi = -math.log(a * b / (c * d)) if a > 0 and b > 0 and c > 0 and d > 0 else float("nan")
    print(f"CHI({I},{I}) = {chi:.4f}")
# the matched one-step coupling: W(I,I) = c_1(beta_eff), c_1 = I2(b)/I1(b) for SU(2) (its plaquette mean), I1(b)/I0(b) for U(1)
def bess(nu, x, terms=80):
    h = x / 2; s = 0.0
    for k in range(terms): s += h ** (2*k + nu) / (math.factorial(k) * math.factorial(k + nu))
    return s
def c1(b): return bess(2, b) / bess(1, b) if group == "su2" else bess(1, b) / bess(0, b)
def invert(w):
    if w <= 0: return 0.0
    lo, hi = 0.0, 50.0
    for _ in range(100):
        mid = (lo + hi) / 2
        if c1(mid) < w: lo = mid
        else: hi = mid
    return lo
for I in (1, 2, 3, 4):
    print(f"BETA_EFF({I}a) = {invert(W[(I,I)][0]):.4f}   (from W({I},{I}) = {W[(I,I)][0]:.5f})")
print(f"done in {time.time() - t0:.0f} s")
