#!/usr/bin/env python
# blockresponse.py -- Edwin Boston III, 2026-10-29. A READING, not a certificate.
# The linear response of interior plaquettes to boundary links in a box of side L with frozen typical boundary,
# for SU(2) (Kennedy-Pendleton heat bath) and U(1) (exact von Mises heat bath), Wilson action.
# STAKES (OPEN/the-crossing.md, written before this ran): S1 SU(2) beta=2.3 exponential, rate in [1.0, 1.8];
# S2 U(1) beta=1.2 power, exponent in [3, 5]; S3 periodic plaquette in [0.59, 0.61] (SU2 2.3), [0.75, 0.82] (U1 1.2);
# S4 weighted row sums at the centre UNGUESSED.
# usage: python blockresponse.py su2|u1 beta L therm_periodic therm_box sweeps seed
import sys, math, random, time
import numpy as np

group, beta, L = sys.argv[1], float(sys.argv[2]), int(sys.argv[3])
TP, TB, NS, seed = int(sys.argv[4]), int(sys.argv[5]), int(sys.argv[6]), int(sys.argv[7])
random.seed(seed); np.random.seed(seed)
N = L + 2                      # the box 1..L plus one frozen layer on each side
D = 4

# ---------- lattice indexing ----------
def site(x): return ((x[0] * N + x[1]) * N + x[2]) * N + x[3]
def coords(s): return (s // (N * N * N), (s // (N * N)) % N, (s // N) % N, s % N)
NSITE = N ** D
def shift(x, mu, d, per):
    y = list(x); y[mu] += d
    if per: y[mu] %= N
    elif y[mu] < 0 or y[mu] >= N: return None
    return tuple(y)

# ---------- SU(2) as unit quaternions (a0, a1, a2, a3) <-> a0 + i a.sigma ----------
def qmul(p, q):
    return (p[0]*q[0] - p[1]*q[1] - p[2]*q[2] - p[3]*q[3],
            p[0]*q[1] + p[1]*q[0] - (p[2]*q[3] - p[3]*q[2]),
            p[0]*q[2] + p[2]*q[0] - (p[3]*q[1] - p[1]*q[3]),
            p[0]*q[3] + p[3]*q[0] - (p[1]*q[2] - p[2]*q[1]))
def qconj(p): return (p[0], -p[1], -p[2], -p[3])
def qadd(p, q): return (p[0]+q[0], p[1]+q[1], p[2]+q[2], p[3]+q[3])
def qrand():
    while True:
        v = [random.gauss(0, 1) for _ in range(4)]
        n = math.sqrt(sum(t*t for t in v))
        if n > 1e-12: return tuple(t / n for t in v)

def staple_sum(U, x, mu, per):
    """S with tr(U_p) summed over plaquettes containing link (x,mu) = tr(U(x,mu) S); quaternion sum."""
    S = (0.0, 0.0, 0.0, 0.0)
    xm = shift(x, mu, 1, per)
    if xm is None: return S
    for nu in range(D):
        if nu == mu: continue
        xn = shift(x, nu, 1, per); xmn = shift(xm, nu, 1, per)
        if xn is not None and xmn is not None:
            # forward: U(x+mu,nu) U(x+nu,mu)^ U(x,nu)^
            S = qadd(S, qmul(qmul(U[site(xm)][nu], qconj(U[site(xn)][mu])), qconj(U[site(x)][nu])))
        xb = shift(x, nu, -1, per); xmb = shift(xm, nu, -1, per)
        if xb is not None and xmb is not None:
            # backward: U(x+mu-nu,nu)^ U(x-nu,mu)^ U(x-nu,nu)
            S = qadd(S, qmul(qmul(qconj(U[site(xmb)][nu]), qconj(U[site(xb)][mu])), U[site(xb)][nu]))
    return S

def kp_a0(alpha):
    """a0 with density ~ sqrt(1-a0^2) exp(alpha a0) on [-1,1] (Kennedy-Pendleton)."""
    while True:
        r1, r2, r3, r4 = random.random(), random.random(), random.random(), random.random()
        X = -math.log(1 - r1) / alpha; Xp = -math.log(1 - r2) / alpha
        c = math.cos(2 * math.pi * r3); delta = X * c * c + Xp
        if r4 * r4 <= 1 - delta / 2: return 1 - delta

def heatbath_su2(U, x, mu, per):
    S = staple_sum(U, x, mu, per)
    k = math.sqrt(S[0]*S[0] + S[1]*S[1] + S[2]*S[2] + S[3]*S[3])
    if k < 1e-12:
        U[site(x)][mu] = qrand(); return
    V = tuple(t / k for t in S)
    alpha = beta * k            # weight exp((beta/2) k tr X) = exp(beta k x0)
    a0 = kp_a0(alpha)
    r = math.sqrt(max(0.0, 1 - a0 * a0))
    ct = 2 * random.random() - 1; st = math.sqrt(1 - ct * ct); ph = 2 * math.pi * random.random()
    X = (a0, r * st * math.cos(ph), r * st * math.sin(ph), r * ct)
    U[site(x)][mu] = qmul(X, qconj(V))     # U = X V^{-1}

def plaq_su2(U, x, mu, nu, per):
    xm = shift(x, mu, 1, per); xn = shift(x, nu, 1, per)
    P = qmul(qmul(qmul(U[site(x)][mu], U[site(xm)][nu]), qconj(U[site(xn)][mu])), qconj(U[site(x)][nu]))
    return P[0]                              # (1/2) tr U_p

# ---------- U(1) as angles ----------
def staple_u1(T, x, mu, per):
    S = 0j
    xm = shift(x, mu, 1, per)
    if xm is None: return S
    for nu in range(D):
        if nu == mu: continue
        xn = shift(x, nu, 1, per); xmn = shift(xm, nu, 1, per)
        if xn is not None and xmn is not None:
            S += np.exp(1j * (T[site(xm)][nu] - T[site(xn)][mu] - T[site(x)][nu]))
        xb = shift(x, nu, -1, per); xmb = shift(xm, nu, -1, per)
        if xb is not None and xmb is not None:
            S += np.exp(1j * (-T[site(xmb)][nu] - T[site(xb)][mu] + T[site(xb)][nu]))
    return S

def heatbath_u1(T, x, mu, per):
    S = staple_u1(T, x, mu, per)        # sum cos(theta + s_p) = Re e^{i theta} S  -> vonmises(-arg S, beta|S|)
    k = abs(S)
    if k < 1e-12: T[site(x)][mu] = random.uniform(-math.pi, math.pi); return
    T[site(x)][mu] = float(np.random.vonmises(-np.angle(S), beta * k))

def plaq_u1(T, x, mu, nu, per):
    xm = shift(x, mu, 1, per); xn = shift(x, nu, 1, per)
    return math.cos(T[site(x)][mu] + T[site(xm)][nu] - T[site(xn)][mu] - T[site(x)][nu])

# ---------- the box ----------
def interior_site(x): return all(1 <= c <= L for c in x)
def interior_link(x, mu):
    xm = shift(x, mu, 1, False)
    return xm is not None and interior_site(x) and interior_site(xm)

all_links = [(coords(s), mu) for s in range(NSITE) for mu in range(D) if shift(coords(s), mu, 1, False) is not None]
int_links = [(x, mu) for (x, mu) in all_links if interior_link(x, mu)]
int_set = set(int_links)
# plaquettes: (x, mu, nu) with mu < nu
all_plaqs = []
for s in range(NSITE):
    x = coords(s)
    for mu in range(D):
        for nu in range(mu + 1, D):
            if shift(x, mu, 1, False) is not None and shift(x, nu, 1, False) is not None:
                all_plaqs.append((x, mu, nu))
def plaq_links(p):
    x, mu, nu = p
    return [(x, mu), (shift(x, mu, 1, False), nu), (shift(x, nu, 1, False), mu), (x, nu)]
int_plaqs = [p for p in all_plaqs if all(l in int_set for l in plaq_links(p))]
touching = [p for p in all_plaqs if any(l in int_set for l in plaq_links(p))]
bnd_links = sorted({l for p in touching for l in plaq_links(p) if l not in int_set})
centre = (L + 1) / 2.0
def pcentre(p):
    x, mu, nu = p
    c = [float(t) for t in x]; c[mu] += 0.5; c[nu] += 0.5
    return c
def lmid(l):
    x, mu = l
    c = [float(t) for t in x]; c[mu] += 0.5
    return c
obs_plaqs = [p for p in int_plaqs if max(abs(c - centre) for c in pcentre(p)) <= 1.5]
dist = np.array([[max(abs(a - b) for a, b in zip(pcentre(p), lmid(l))) for l in bnd_links] for p in obs_plaqs])
print(f"group={group} beta={beta} L={L} N={N} sites={NSITE} interior_links={len(int_links)} interior_plaqs={len(int_plaqs)} "
      f"boundary_links_touching={len(bnd_links)} observed_plaqs={len(obs_plaqs)} seed={seed}", flush=True)

# ---------- state ----------
if group == "su2":
    U = [[(1.0, 0.0, 0.0, 0.0) for _ in range(D)] for _ in range(NSITE)]
    hb, plaq = heatbath_su2, plaq_su2
else:
    U = [[0.0 for _ in range(D)] for _ in range(NSITE)]
    hb, plaq = heatbath_u1, plaq_u1

t0 = time.time()
# periodic thermalisation on the full N^4 torus (typical configuration), KAT S3 from its last half
per_links = [(coords(s), mu) for s in range(NSITE) for mu in range(D)]
per_plaqs = [(coords(s), mu, nu) for s in range(NSITE) for mu in range(D) for nu in range(mu + 1, D)]
acc = 0.0; nacc = 0
for sweep in range(TP):
    for (x, mu) in per_links: hb(U, x, mu, True)
    if sweep >= TP // 2:
        acc += sum(plaq(U, x, mu, nu, True) for (x, mu, nu) in per_plaqs) / len(per_plaqs); nacc += 1
print(f"KAT periodic plaquette <P> = {acc / nacc:.5f} over {nacc} sweeps of {N}^4 ({time.time() - t0:.0f} s)", flush=True)

# freeze the boundary; thermalise the interior with open boundary
for sweep in range(TB):
    for (x, mu) in int_links: hb(U, x, mu, False)

# ---------- measurement ----------
def Qvec():
    """derivative of the action under a left rotation of each boundary link: SU(2): -(beta/2) vec(U S); U(1): -beta sum eps sin phi."""
    out = np.zeros((len(bnd_links), 3 if group == "su2" else 1))
    for i, (x, mu) in enumerate(bnd_links):
        if group == "su2":
            M = qmul(U[site(x)][mu], staple_sum(U, x, mu, False))
            out[i] = (-beta / 2 * M[1], -beta / 2 * M[2], -beta / 2 * M[3])
        else:
            S = staple_u1(U, x, mu, False)
            z = np.exp(1j * U[site(x)][mu]) * S
            out[i, 0] = -beta * z.imag          # d/dtheta Re(e^{i theta} S) = -Im(e^{i theta} S)
    return out
nP, nB, nc = len(obs_plaqs), len(bnd_links), (3 if group == "su2" else 1)
SP = np.zeros(nP); SQ = np.zeros((nB, nc)); SPQ = np.zeros((nP, nB, nc)); SPP = 0.0
for sweep in range(NS):
    for (x, mu) in int_links: hb(U, x, mu, False)
    P = np.array([plaq(U, x, mu, nu, False) for (x, mu, nu) in obs_plaqs])
    Q = Qvec()
    SP += P; SQ += Q; SPQ += P[:, None, None] * Q[None, :, :]; SPP += float(np.mean(P))
    if (sweep + 1) % 200 == 0:
        print(f"  sweep {sweep + 1}/{NS}  <P_centre> = {SPP / (sweep + 1):.5f}  ({time.time() - t0:.0f} s)", flush=True)
n = NS
cov = SPQ / n - (SP / n)[:, None, None] * (SQ / n)[None, :, :]
J = np.sqrt((cov ** 2).sum(axis=2))                      # nP x nB
print(f"RESULT <P_centre> = {SP.mean() / n:.5f}")
# profile against distance
bins = np.arange(np.floor(dist.min() * 2) / 2, dist.max() + 0.5, 0.5)
rows = []
for b in bins:
    m = (dist >= b) & (dist < b + 0.5)
    if m.sum() > 0:
        rows.append((b + 0.25, float(J[m].mean()), int(m.sum())))
        print(f"PROFILE r = {b + 0.25:.2f}  mean J = {J[m].mean():.3e}  pairs = {int(m.sum())}")
r = np.array([t[0] for t in rows]); y = np.array([t[1] for t in rows])
ok = y > 0
if ok.sum() >= 3:
    a, c = np.polyfit(r[ok], np.log(y[ok]), 1)
    print(f"FIT exponential: J ~ exp({a:.3f} r), rate = {-a:.3f} per spacing; residual {np.std(np.log(y[ok]) - (a * r[ok] + c)):.3f}")
    a2, c2 = np.polyfit(np.log(r[ok]), np.log(y[ok]), 1)
    print(f"FIT power: J ~ r^{a2:.3f}; residual {np.std(np.log(y[ok]) - (a2 * np.log(r[ok]) + c2)):.3f}")
for kappa in (0.0, 0.5, 1.0):
    w = (J * np.exp(kappa * dist)).sum(axis=1)
    print(f"ROWSUM kappa = {kappa}: Sum_y J(x,y) e^(kappa d) at the centre: mean {w.mean():.4e} max {w.max():.4e} over {nP} plaquettes")
print(f"done in {time.time() - t0:.0f} s")
