#!/usr/bin/env python3
# u1_arm.py -- CC, 2026-11-02 (second version: the first, u1_arm.2026-11-02a, timed out with its output unflushed -- a 401-point direction
# sweep inside a 200-point radius supremum inside a beta march; kept on record). TOOTH (ii), the strong-coupling U(1) arm: a READING (double
# precision) and a WEAK tooth -- every criterion built on strong-coupling constants refuses at large beta because the constants grow without
# bound, so the arm cannot fail at large beta_V; it shows where the U(1) thresholds sit against U(1)'s transition (compact Wilson U(1) in 4D
# near beta ~ 1.01, a literature value quoted as a READING). U(1) = S^1 in R^2: von Mises law, m = I1/I0, phi'' = 1 - m/r - m^2 (Riccati,
# n = 2), covariance eigenvalues phi'' and m/r (both 1/2 at Haar), D = phi'' - m/r, third cumulant phi''' c^3 + 3(D/r)c(1 - c^2) (Lemma 8.6's
# dimension-free formula), MAD at Haar E|cos| = 2/pi taken as the supremum (READING), TV rate rho/pi; kappa' = (4/pi) rho e^-w (1.273).
import math, sys
def I(nu, x, K=60):
    h = x / 2; t = h ** nu / math.factorial(nu); s = 0.0
    for k in range(K): s += t; t *= h * h / ((k + 1) * (k + 1 + nu))
    return s
NR = 3000; RMAX = 9.0
rs = [RMAX * (k + 1) / NR for k in range(NR)]
mm = [I(1, r) / I(0, r) for r in rs]
p2 = [1 - m / r - m * m for m, r in zip(mm, rs)]
DD = [abs(p - m / r) for p, m, r in zip(p2, mm, rs)]
p3 = [(p2[min(k + 1, NR - 1)] - p2[max(k - 1, 0)]) / (rs[min(k + 1, NR - 1)] - rs[max(k - 1, 0)]) for k in range(NR)]
cs = [k / 200 for k in range(201)]
TT = [max(abs(p3[k] * c ** 3 - 3 * (DD[k] / rs[k]) * c * (1 - c * c)) for c in cs) for k in range(NR)]
SS = [max(p, m / r) for p, m, r in zip(p2, mm, rs)]
def runmax(a):
    out = []; best = 0.0
    for v in a: best = max(best, v); out.append(best)
    return out
DDm, TTm, SSm = runmax(DD), runmax(TT), runmax(SS)
def at(tab, r): return tab[min(NR - 1, max(0, int(r / RMAX * NR)))]
def m_of(r): return I(1, r) / I(0, r)
def rows(beta):
    M5 = m_of(5 * beta); D5 = at(DDm, 5 * beta); T6 = at(TTm, 6 * beta); T5 = at(TTm, 5 * beta); s5 = max(0.5, at(SSm, 5 * beta))
    om = 3 * beta ** 2 * D5 + 2 * beta ** 3 * T6; rho = (3 * math.exp(om) - 1) / 2; rate = rho / math.pi
    lI = beta * M5; lII = beta ** 2 * s5
    CNd = (beta ** 2 * D5 + 2 / 3 * beta ** 3 * T6) / 4; CNm = (min(beta ** 2 * D5, 2 * beta ** 3 * T5) + 2 / 3 * beta ** 3 * T6) / 4
    alpha = 12 * (2 * rate * lI + CNd) + 90 * (2 * rate * lII + CNm)
    cov = math.exp(om) * 0.5
    L = 12 * lI + 90 * lII; N = 12 * CNd + 90 * CNm
    A = cov * L; B = rate * L; C = 2 * math.sqrt(cov) * N; Dd = N
    ok = A < 1 and Dd < 1 and (1 - A) * (1 - Dd) > B * C
    return alpha, A, B, C, Dd, ok, 2 * rate / cov
def bisect(pred, lo, hi):   # pred(lo) True, pred(hi) False
    for _ in range(40):
        mid = (lo + hi) / 2
        if pred(mid): lo = mid
        else: hi = mid
    return lo
print("U1-ARM (READING) kappa'_U(1) at Haar = 4/pi = %.6f (SU(2): 16/(3 pi) = %.6f)" % (4 / math.pi, 16 / (3 * math.pi)), flush=True)
first = bisect(lambda b: rows(b)[0] < 1, 0.01, 1.4)
ideal = bisect(lambda b: rows(b)[5], 0.01, 1.4)
print("U1-ARM first-order row alpha_U(1) < 1 up to beta ~ %.4f; the IDEAL global two-component criterion (CONDITIONAL) holds up to beta ~ %.4f" % (first, ideal), flush=True)
for b in (first, ideal, 0.5, 1.0, 1.0111, 1.4):
    al, A, B, C, Dd, ok, kap = rows(b)
    print("U1-ARM beta %.4f: alpha %.4f | ideal global [[A,B],[C,D]] = [[%.4f, %.4f], [%.4f, %.4f]] -> %s | kappa' %.4f" % (b, al, A, B, C, Dd, "ADMITS" if ok else "REFUSES", kap), flush=True)
print("U1-ARM verdict (weak tooth, said as such): both criteria REFUSE every beta >= %.4f, in particular the Coulomb regime beta >= 1.0111;"
      " the arm cannot fail at large beta" % max(first, ideal), flush=True)
