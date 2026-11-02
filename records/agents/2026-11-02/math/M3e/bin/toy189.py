"""M3e toy check of Lemma A (second-order adjoint identity) and of the decay mechanism behind CMP 102 (189)-(190).
Double precision; a check of algebra and mechanism, not a proof. Ring of N sites, blocks of b sites, abelian real fields.
Usage: python -E -P toy189.py <outfile>
"""
import sys
import numpy as np

np.set_printoptions(precision=4, linewidth=160)
N, b = 96, 4
nB = N // b
m = 0.6
kap2, kap3 = 0.5, 0.3
g3, g4 = 0.5, 0.2
j0 = 0.05
rng = np.random.default_rng(20261102)
out = []

def say(*a):
    s = " ".join(str(x) for x in a)
    out.append(s)
    print(s)

# --- linear structure -------------------------------------------------------------------------------------------
Lap = np.zeros((N, N))
for i in range(N):
    Lap[i, i] = 2.0
    Lap[i, (i + 1) % N] -= 1.0
    Lap[i, (i - 1) % N] -= 1.0
K = Lap + m * m * np.eye(N)          # analogue of Delta_pi (+ gauge fixing) ; G = K^{-1}
G = np.linalg.inv(K)
Q = np.zeros((nB, N))
for c in range(nB):
    Q[c, c * b:(c + 1) * b] = 1.0 / b
QGQ = Q @ G @ Q.T
Pi = np.linalg.inv(QGQ)               # analogue of (QGQ*)^{-1}
H = G @ Q.T @ Pi                      # analogue of (3.126): QH = I
assert np.allclose(Q @ H, np.eye(nB))
J = j0 * np.cos(2 * np.pi * 3 * np.arange(N) / N)

blk = np.arange(N) // b               # block of each fine site
def ring(i, j):
    d = abs(i - j) % N
    return min(d, N - d)

# --- nonlinear average C (block local, starts at second order) ----------------------------------------------------
def Cfun(A):
    QA = Q @ A
    s2 = np.array([np.mean(A[c * b:(c + 1) * b] ** 2) for c in range(nB)])
    s3 = np.array([np.mean(A[c * b:(c + 1) * b] ** 3) for c in range(nB)])
    return kap2 * (s2 - QA ** 2) + kap3 * s3

def Cjac(A):                          # dC/dA : nB x N
    QA = Q @ A
    Jm = np.zeros((nB, N))
    for c in range(nB):
        sl = slice(c * b, (c + 1) * b)
        Jm[c, sl] = kap2 * (2 * A[sl] / b - 2 * QA[c] / b) + kap3 * 3 * A[sl] ** 2 / b
    return Jm

def Chess(A, Lam):                    # sum_c Lam_c * Hess(C_c) : N x N
    Hm = np.zeros((N, N))
    for c in range(nB):
        sl = slice(c * b, (c + 1) * b)
        blkH = kap2 * (2 * np.eye(b) / b - 2 * np.ones((b, b)) / b ** 2) + np.diag(kap3 * 6 * A[sl] / b)
        Hm[sl, sl] += Lam[c] * blkH
    return Hm

# --- V0 local (cubic with a derivative + quartic) ------------------------------------------------------------------
def V0(A):
    Ap = np.roll(A, -1)
    return np.sum(g3 * A ** 2 * (Ap - A) + g4 * A ** 4)

def V0grad(A):
    Ap = np.roll(A, -1)
    Am = np.roll(A, 1)
    g = g3 * (2 * A * (Ap - A) - A ** 2) + g4 * 4 * A ** 3
    g += g3 * Am ** 2                 # derivative of term i-1 wrt A_i (A_{i} appears as A_{(i-1)+1})
    return g

def V0hess(A):
    Hm = np.zeros((N, N))
    for i in range(N):
        ip = (i + 1) % N
        # term_i = g3*(A_i^2 A_ip - A_i^3) + g4*A_i^4
        Hm[i, i] += g3 * (2 * A[ip] - 6 * A[i]) + g4 * 12 * A[i] ** 2
        Hm[i, ip] += g3 * 2 * A[i]
        Hm[ip, i] += g3 * 2 * A[i]
    return Hm

def Gtot(A):
    return A @ J + 0.5 * A @ K @ A + V0(A)

def Gtot_grad(A):
    return J + K @ A + V0grad(A)

def Gtot_hess(A):
    return K + V0hess(A)

# --- linearizing transformation ------------------------------------------------------------------------------------
def Dfun(Ap):
    X = np.zeros(nB)
    for it in range(500):
        Xn = Cfun(Ap - H @ X)
        if np.max(np.abs(Xn - X)) < 1e-15:
            X = Xn
            break
        X = Xn
    return X

def frak(Ap):
    X = Dfun(Ap)
    A = Ap - H @ X
    Cp = Cjac(A)
    Nn = Cp @ H
    Dj = np.linalg.solve(np.eye(nB) + Nn, Cp)   # (70): frakD = (I+N)^{-1} C'
    T = np.eye(N) - H @ Dj                      # Jacobian of (47)
    return X, A, Cp, Nn, Dj, T

def F_value(Ap):
    X = Dfun(Ap)
    return Gtot(Ap - H @ X)

def F_grad(Ap):
    X, A, Cp, Nn, Dj, T = frak(Ap)
    return T.T @ Gtot_grad(A)

def F_hess_adjoint(Ap):               # Lemma A: no second derivative of D
    X, A, Cp, Nn, Dj, T = frak(Ap)
    dXW = -H.T @ Gtot_grad(A)
    Lam = np.linalg.solve((np.eye(nB) + Nn).T, dXW)
    Q2 = Gtot_hess(A) + Chess(A, Lam)
    return T.T @ Q2 @ T, Dj

def F_hess_fd(Ap, h=1e-5):
    Hm = np.zeros((N, N))
    for i in range(N):
        e = np.zeros(N); e[i] = h
        Hm[:, i] = (F_grad(Ap + e) - F_grad(Ap - e)) / (2 * h)
    return 0.5 * (Hm + Hm.T)

def profile(M, kind="ff"):
    """max |M(i,j)| at ring distance r; kind ff: fine-fine; fb: fine x block (distance from i to block centre)."""
    R = N // 2 + 1
    P = np.zeros(R)
    rows, cols = M.shape
    for i in range(rows):
        for j in range(cols):
            if kind == "ff":
                r = ring(i, j)
            elif kind == "fb":
                r = ring(i, j * b + (b - 1) / 2.0) if False else min(ring(i, j * b + k) for k in range(b))
            elif kind == "bf":
                r = min(ring(i * b + k, j) for k in range(b))
            else:  # bb
                r = ring(i * b, j * b)
            r = int(round(r))
            P[r] = max(P[r], abs(M[i, j]))
    return P

def rate(P, r0, r1):
    rs = np.array([r for r in range(r0, r1 + 1) if P[r] > 0])
    vals = np.log(P[rs])
    A_ = np.vstack([rs, np.ones_like(rs)]).T
    sl, ic = np.linalg.lstsq(A_, vals, rcond=None)[0]
    return -sl

# --- a smooth random A' --------------------------------------------------------------------------------------------
def smooth_field(eps):
    k = np.arange(N)
    f = np.zeros(N)
    for n_ in range(1, 6):
        f += rng.normal() * np.cos(2 * np.pi * n_ * k / N + rng.uniform(0, 2 * np.pi)) / n_
    f += 0.3 * rng.normal(size=N)
    return eps * f / np.max(np.abs(f))

say("toy189: N=%d b=%d m=%.2f kap2=%.2f kap3=%.2f g3=%.2f g4=%.2f j0=%.3f" % (N, b, m, kap2, kap3, g3, g4, j0))
Ap = smooth_field(0.15)

# S1 ---------------------------------------------------------------------------------------------------------------
Hadj, Dj = F_hess_adjoint(Ap)
Hfd = F_hess_fd(Ap)
relerr = np.max(np.abs(Hadj - Hfd)) / np.max(np.abs(Hfd))
say("S1 Lemma A vs finite differences: max|adj-fd|/max|fd| = %.3e" % relerr)
# a control: the formula WITHOUT the Lambda (C'') term must fail visibly
X, A, Cp, Nn, Dj2, T = frak(Ap)
Hbad = T.T @ Gtot_hess(A) @ T
say("S1 control (Lambda term dropped): rel err = %.3e" % (np.max(np.abs(Hbad - Hfd)) / np.max(np.abs(Hfd))))

# kernel rates -------------------------------------------------------------------------------------------------------
PH = profile(H, "fb")
PG = profile(G, "ff")
PPi = profile(Pi, "bb")
PD = profile(Dj, "bf")
muH, muG = rate(PH, 6, 30), rate(PG, 6, 30)
muPi = rate(PPi, 8, 40)
muD = rate(PD, 6, 30)
say("kernel rates (fit on tails): mu_G=%.4f mu_H=%.4f mu_Pi=%.4f mu_frakD=%.4f" % (muG, muH, muPi, muD))
say("  exact lattice rate of G: arccosh(1+m^2/2) = %.4f" % np.arccosh(1 + m * m / 2))

# S2 ---------------------------------------------------------------------------------------------------------------
H0, _ = F_hess_adjoint(np.zeros(N))
HV = Hadj - H0
PV = profile(HV, "ff")
muV = rate(PV, 6, 30)
mn = min(muH, muD, muPi)
say("S2 Hess V profile P(r), r=0..40 step 4:", " ".join("%.2e" % PV[r] for r in range(0, 41, 4)))
say("S2 fitted rate of Hess V = %.4f ; min(mu_H,mu_frakD,mu_Pi) = %.4f ; ratio = %.3f (stake >= 0.9)" % (muV, mn, muV / mn))

# S3 ---------------------------------------------------------------------------------------------------------------
Ps = []
for t in (0.25, 0.5):
    Ht, _ = F_hess_adjoint(t * Ap)
    Ps.append(np.max(np.abs(Ht - H0)))
say("S3 max|Hess V(tA')| at t=0.25, 0.5: %.4e %.4e ratio %.3f (stake 2 +- 10%%)" % (Ps[0], Ps[1], Ps[1] / Ps[0]))

# S4: constrained minimizer and dA*/dB ------------------------------------------------------------------------------
# A' = H B + P0 w, P0 = projection on ker Q (orthonormal basis Z of ker Q)
U_, S_, Vt_ = np.linalg.svd(Q)
Z = Vt_[nB:].T                        # N x (N-nB), Q Z = 0
def solve_min(B):
    w = np.zeros(N - nB)
    for it in range(60):
        Ap_ = H @ B + Z @ w
        g = Z.T @ F_grad(Ap_)
        if np.max(np.abs(g)) < 1e-13:
            break
        Hs, _ = F_hess_adjoint(Ap_)
        w = w - np.linalg.solve(Z.T @ Hs @ Z, g)
    Ap_ = H @ B + Z @ w
    X_ = Dfun(Ap_)
    return Ap_ - H @ X_, Ap_, it
B0 = Q @ smooth_field(0.12)
Astar, Apstar, its = solve_min(B0)
say("S4 Newton converged in %d iterations; check Q A* + C(A*) - B = %.2e" % (its, np.max(np.abs(Q @ Astar + Cfun(Astar) - B0))))
# Jacobian dA*/dB by central differences of the solver
hB = 1e-6
JB = np.zeros((N, nB))
for c in range(nB):
    e = np.zeros(nB); e[c] = hB
    JB[:, c] = (solve_min(B0 + e)[0] - solve_min(B0 - e)[0]) / (2 * hB)
PJ = profile(JB, "fb")
muJ = rate(PJ, 6, 30)
mn4 = min(muH, muD, muPi, muG)
# subtract the linear part H (the B-derivative at B=0 is H exactly) to see the nonlinear correction's decay
PJn = profile(JB - H, "fb")
muJn = rate(PJn, 6, 30)
say("S4 dA*/dB column profile r=0..40 step 4:", " ".join("%.2e" % PJ[r] for r in range(0, 41, 4)))
say("S4 rate(dA*/dB) = %.4f ; rate(dA*/dB - H) = %.4f ; min rates = %.4f ; ratios %.3f %.3f (stake >= 0.9)"
    % (muJ, muJn, mn4, muJ / mn4, muJn / mn4))

with open(sys.argv[1], "w") as fh:
    fh.write("\n".join(out) + "\n")
