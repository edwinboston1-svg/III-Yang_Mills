"""ME2b K-1..K-3, O-1, O-2: one-loop log coefficients of Yang-Mills with a constant constitutive tensor
chi = chi_0 + k, background field method, k-independent background Feynman gauge, exact rational arithmetic.

Action (1/4g^2) chi^{mu nu rho sigma} F^a_{mu nu} F^a_{rho sigma};  chi_0^{mu nu rho sigma} = (d^{mu rho} d^{nu sigma}
- d^{mu sigma} d^{nu rho})/2.  Quantum field a, background A; color factor C2 = 1 (each two-vertex loop gives +C2).
Vertices (momentum space, incoming q, background momentum p, component (alpha beta), background index lambda):
  V1 = v_{alpha beta lambda}(q,p) = (2q+p)_lambda d_{alpha beta} + 2(p_alpha d_{beta lambda} - p_beta d_{alpha lambda})
  d1 = u_{alpha beta lambda}(q,p) = 2 k^{mu alpha lambda beta}(q+p)_mu + 2 k^{mu beta lambda alpha} q_mu
                                    + 2 k^{mu lambda alpha beta} p_mu
  d0 = 2 k^{mu alpha rho beta} q_mu q_rho ;  ghost vertex (2q+p)_lambda ;  G = d/q^2.
Two-point coefficient Pi_{lambda kappa}(p) of A_lambda(-p) A_kappa(p); LOG[.] = coefficient of 1/q^4 after the p^2
expansion and the S^3 angular average (the log divergence is LOG * ln(Lambda/mu)/(8 pi^2)).
Run:  python -I me2b_oneloop.py
"""
import sympy as sp
from sympy import Rational as Q
from itertools import combinations
import random, sys, time

q = sp.symbols('q0:4'); p = sp.symbols('p0:4'); t, Q2 = sp.symbols('t Q2', positive=True)
D = lambda a, b: 1 if a == b else 0
R4 = range(4)

def dot(x, y): return sum(x[i] * y[i] for i in R4)

# ---------- angular average over S^3 ----------
from math import factorial
GHALF = {}  # Gamma(n+1/2)/sqrt(pi) = (2n-1)!!/2^n
def ghalf(n):
    if n not in GHALF:
        v = Q(1)
        for j in range(n): v *= Q(2 * j + 1, 2)
        GHALF[n] = v
    return GHALF[n]
def angavg_poly(expr):
    """expr: polynomial in q (coefficients may involve p, Q2). Return sum over monomials of
    coeff * <q^alpha> with <prod q_i^{2a_i}> = prod Gamma(a_i+1/2) / (pi^2 (n+1)!) * Q2^n."""
    P = sp.Poly(sp.expand(expr), *q)
    out = 0
    for mon, coeff in P.terms():
        if any(m % 2 for m in mon): continue
        a = [m // 2 for m in mon]; n = sum(a)
        # prod Gamma(a_i+1/2) = pi^2 prod ghalf(a_i)  (four factors of sqrt(pi))
        w = ghalf(a[0]) * ghalf(a[1]) * ghalf(a[2]) * ghalf(a[3]) / factorial(n + 1)
        out += coeff * w * Q2 ** n
    return sp.expand(out)

def inv_qp(b):
    """((q+p)^2)^(-b) with p -> t p, to order t^2, in terms of Q2 = q^2."""
    s = 2 * t * dot(q, p) + t ** 2 * dot(p, p)
    return Q2 ** (-b) * (1 - b * s / Q2 + Q(b * (b + 1), 2) * s ** 2 / Q2 ** 2)

def LOG(num, a, b):
    """num(q,p) / (Q2^a ((q+p)^2)^b): p^2 coefficient, angular-averaged, as coefficient of Q2^-2."""
    num_t = sp.expand(num.subs({p[i]: t * p[i] for i in R4}, simultaneous=True))
    expr = sp.expand(num_t * inv_qp(b))
    c2 = expr.coeff(t, 2)
    c2 = sp.expand(c2 * Q2 ** (-a))
    # c2 is a sum of (q-polynomial)*Q2^m terms; average the q-part term by term
    terms = sp.Add.make_args(c2)
    tot = 0
    for term in terms:
        tot += angavg_poly(term)
    tot = sp.simplify(sp.expand(tot) * Q2 ** 2)
    assert not tot.has(Q2), f"non-log remainder: {tot}"
    return sp.expand(tot)

# ---------- tensors ----------
def v_tensor(qq, pp):
    return [[[(2 * qq[l] + pp[l]) * D(al, be) + 2 * (pp[al] * D(be, l) - pp[be] * D(al, l))
              for l in R4] for be in R4] for al in R4]
def u_tensor(k, qq, pp):
    qp = [qq[i] + pp[i] for i in R4]
    return [[[sum(2 * k[mu][al][l][be] * qp[mu] + 2 * k[mu][be][l][al] * qq[mu] + 2 * k[mu][l][al][be] * pp[mu]
                  for mu in R4) for l in R4] for be in R4] for al in R4]
def d0_tensor(k, qq):
    return [[sum(2 * k[mu][al][rho][be] * qq[mu] * qq[rho] for mu in R4 for rho in R4) for be in R4] for al in R4]

def k_from_form(B):
    """B: 6x6 symmetric form on Lambda^2 in basis e_{mu nu} (mu<nu); k^{mu nu rho sigma} = (1/2) s s B."""
    pairs = list(combinations(R4, 2)); pos = {pr: i for i, pr in enumerate(pairs)}
    def sp_(m, n):
        if m == n: return 0, None
        return (1, pos[(m, n)]) if m < n else (-1, pos[(n, m)])
    k = [[[[0] * 4 for _ in R4] for _ in R4] for _ in R4]
    for m in R4:
        for n in R4:
            s1, i = sp_(m, n)
            if not s1: continue
            for r in R4:
                for s_ in R4:
                    s2, j = sp_(r, s_)
                    if not s2: continue
                    k[m][n][r][s_] = Q(1, 2) * s1 * s2 * B[i][j]
    return k

pairs = list(combinations(R4, 2))
def form_iso(): return [[Q(int(i == j)) for j in range(6)] for i in range(6)]
def form_metric(h):
    return [[h[m][r] * D(n, s_) - h[m][s_] * D(n, r) - h[n][r] * D(m, s_) + h[n][s_] * D(m, r)
             for (r, s_) in pairs] for (m, n) in pairs]
def levi(*x):
    if len(set(x)) < 4: return 0
    sgn = 1
    for i in range(4):
        for j in range(i + 1, 4):
            if x[i] > x[j]: sgn = -sgn
    return sgn
def form_theta(): return [[Q(levi(m, n, r, s_)) for (r, s_) in pairs] for (m, n) in pairs]
def diagform(w): return [[Q(w.get(pairs[i], 0)) if i == j else Q(0) for j in range(6)] for i in range(6)]

def tree_structure(k):
    """Tree-level two-point structure of the k-term: 2 k^{mu lambda rho kappa} p_mu p_rho."""
    return [[sp.expand(sum(2 * k[mu][l][rho][kap] * p[mu] * p[rho] for mu in R4 for rho in R4)) for kap in R4] for l in R4]

def trace2(M, N):
    return sum(M[a][b] * N[b][a] for a in R4 for b in R4)
def mm(M, N): return [[sum(M[a][c] * N[c][b] for c in R4) for b in R4] for a in R4]
def slice_l(T, l): return [[T[a][b][l] for b in R4] for a in R4]

qp = [q[i] + p[i] for i in R4]; mp = [-p[i] for i in R4]
V_m = v_tensor(qp, mp)     # v(q+p, -p): carries A(-p), index lambda
V_p = v_tensor(q, p)       # v(q, p): carries A(p), index kappa

def pi_gluon():
    # Gamma_gl = -1/2 sum_q tr[v(q+p,-p)_lambda v(q,p)_kappa] / (q^2 (q+p)^2)
    return [[-Q(1, 2) * LOG(trace2(slice_l(V_m, l), slice_l(V_p, kap)), 1, 1) for kap in R4] for l in R4]
def pi_ghost():
    return [[LOG((2 * qp[l] + mp[l]) * (2 * q[kap] + p[kap]), 1, 1) for kap in R4] for l in R4]

def pi_k(k):
    U_p = u_tensor(k, q, p)             # u(q,p): carries A(p), kappa
    U_m = u_tensor(k, qp, mp)           # u(q+p,-p): carries A(-p), lambda
    D0q = d0_tensor(k, q); D0qp = d0_tensor(k, qp)
    out = [[0] * 4 for _ in R4]
    for l in R4:
        Vm_l = slice_l(V_m, l); Um_l = slice_l(U_m, l)
        for kap in R4:
            Vp_k = slice_l(V_p, kap); Up_k = slice_l(U_p, kap)
            # term A: -tr[G(q) v(q+p,-p) G(q+p) u(q,p)]  -> -tr[Vm Up]/(q^2 (q+p)^2)
            tA = LOG(-trace2(Vm_l, Up_k), 1, 1)
            # term B: -tr[G(q+p) v(q,p) G(q) u(q+p,-p)] -> -tr[Vp Um]/(q^2 (q+p)^2)
            tB = LOG(-trace2(Vp_k, Um_l), 1, 1)
            # term C: tr[G(q) v(q+p,-p) G(q+p) v(q,p) G(q) d0(q)] -> tr[Vm Vp D0q]/(q^4 (q+p)^2)
            tC = LOG(trace2(mm(Vm_l, Vp_k), D0q), 2, 1)
            # term D: tr[G(q+p) v(q,p) G(q) v(q+p,-p) G(q+p) d0(q+p)] -> tr[Vp Vm D0qp]/(q^2 (q+p)^4)
            tD = LOG(trace2(mm(Vp_k, Vm_l), D0qp), 1, 2)
            out[l][kap] = sp.expand(Q(1, 2) * (tA + tB + tC + tD))
    return out

def ratio_to(M, S):
    """Return c with M = c S (entrywise), or None."""
    c = None
    for a in R4:
        for b in R4:
            Ms, Ss = sp.expand(M[a][b]), sp.expand(S[a][b])
            if Ss == 0:
                if Ms != 0: return None
                continue
            r = sp.simplify(Ms / Ss)
            if r.free_symbols: return None
            if c is None: c = r
            elif sp.simplify(r - c) != 0: return None
    return c
def transverse(M):
    return all(sp.expand(sum(M[a][b] * p[b] for b in R4)) == 0 for a in R4)

if __name__ == "__main__":
    t0 = time.time()
    chi0 = k_from_form(form_iso())
    # vertex consistency: u(chi_0) + gauge-fixing vertex = v ;  d0(chi_0) + q q = q^2 d
    U0 = u_tensor(chi0, q, p); V0 = v_tensor(q, p)
    vgf = [[[(q[al] + p[al]) * D(be, l) + q[be] * D(al, l) for l in R4] for be in R4] for al in R4]
    okv = all(sp.expand(U0[a][b][l] + vgf[a][b][l] - V0[a][b][l]) == 0 for a in R4 for b in R4 for l in R4)
    D00 = d0_tensor(chi0, q)
    okd = all(sp.expand(D00[a][b] + q[a] * q[b] - dot(q, q) * D(a, b)) == 0 for a in R4 for b in R4)
    print(f"vertex check u(chi0)+v_gf = v: {okv};  d0(chi0)+qq = q^2 d: {okd}")
    S0 = tree_structure(chi0)
    print("tree structure of chi_0 = 2 chi0 p p  (should be p^2 d - p p):",
          ratio_to(S0, [[dot(p, p) * D(a, b) - p[a] * p[b] for b in R4] for a in R4]))
    Pg = pi_gluon(); Pgh = pi_ghost()
    ag, agh = ratio_to(Pg, S0), ratio_to(Pgh, S0)
    print(f"K-1  gluon loop = {ag} * (p^2 d - pp)  transverse={transverse(Pg)}")
    print(f"     ghost loop = {agh} * (p^2 d - pp)  transverse={transverse(Pgh)}")
    A0 = sp.simplify(ag + agh) if (ag is not None and agh is not None) else None
    print(f"     total A0 = {A0};  gluon/ghost = {sp.simplify(ag/agh) if ag is not None and agh else None};  "
          f"A0 * 3 = {sp.simplify(3*A0) if A0 is not None else None}  ({time.time()-t0:.0f}s)")
    sys.stdout.flush()
    cases = []
    cases.append(("isotropic chi_0 (K-2)", chi0))
    cases.append(("theta", k_from_form(form_theta())))
    h1 = [[Q(int(i == j)) * (1 if i < 2 else -1) for j in R4] for i in R4]
    cases.append(("metric diag h=(1,1,-1,-1) (O-1)", k_from_form(form_metric(h1))))
    h2 = [[Q(0)] * 4 for _ in R4]; h2[0][1] = h2[1][0] = Q(1)
    cases.append(("metric offdiag h=e0e1+e1e0 (O-1)", k_from_form(form_metric(h2))))
    wW = {(0, 1): 1, (2, 3): 1, (0, 2): Q(-1, 2), (0, 3): Q(-1, 2), (1, 2): Q(-1, 2), (1, 3): Q(-1, 2)}
    cases.append(("Weyl diag (planar invariant) (O-2)", k_from_form(diagform(wW))))
    # random Weyl: random symmetric B, project out iso, theta, metric (orthogonal projection, tr(B B'))
    random.seed(20261102)
    Bm = sp.Matrix(6, 6, lambda i, j: 0)
    for i in range(6):
        for j in range(i, 6):
            x = Q(random.randint(-5, 5)); Bm[i, j] = x; Bm[j, i] = x
    basis = [sp.Matrix(form_iso()), sp.Matrix(form_theta())]
    for (a_, b_) in [(i, j) for i in R4 for j in range(i, 4)]:
        h = [[Q(0)] * 4 for _ in R4]
        if a_ == b_: h[a_][a_] = Q(1); h[3 if a_ != 3 else 0][3 if a_ != 3 else 0] = Q(-1)
        else: h[a_][b_] = h[b_][a_] = Q(1)
        basis.append(sp.Matrix(form_metric(h)))
    ipm = lambda X, Y: sum(X[i, j] * Y[i, j] for i in range(6) for j in range(6))
    G = sp.Matrix(len(basis), len(basis), lambda i, j: ipm(basis[i], basis[j]))
    rk = G.rank()
    # least squares projection onto span(basis)
    rhs = sp.Matrix([ipm(b, Bm) for b in basis])
    sol = G.pinv() * rhs
    proj = sum((sol[i] * basis[i] for i in range(len(basis))), sp.zeros(6, 6))
    W = Bm - proj
    W = W.applyfunc(sp.nsimplify)
    print(f"     random Weyl: span rank {rk} (expect 11 = 1+1+9), residual orthogonal: "
          f"{all(sp.simplify(ipm(b, W)) == 0 for b in basis)}")
    cases.append(("Weyl random (O-2)", k_from_form([[W[i, j] for j in range(6)] for i in range(6)])))
    for name, k in cases:
        t1 = time.time()
        Pk = pi_k(k); Sk = tree_structure(k)
        allzeroS = all(sp.expand(Sk[a][b]) == 0 for a in R4 for b in R4)
        allzeroP = all(sp.expand(Pk[a][b]) == 0 for a in R4 for b in R4)
        if allzeroS:
            print(f"{name}: tree structure zero; response zero: {allzeroP}  ({time.time()-t1:.0f}s)")
        else:
            lam = ratio_to(Pk, Sk)
            print(f"{name}: response = lambda * tree with lambda = {lam};  lambda/A0 = "
                  f"{sp.simplify(lam / A0) if lam is not None else 'NOT PROPORTIONAL'};  transverse={transverse(Pk)}"
                  f"  ({time.time()-t1:.0f}s)")
            if lam is None:
                print("   Pk =", Pk); print("   Sk =", Sk)
        sys.stdout.flush()
