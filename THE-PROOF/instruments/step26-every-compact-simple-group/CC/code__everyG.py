#!/usr/bin/env python3
# everyG.py -- CC, 2026-11-02 (rule 4, the cheap form). MG2's Theorem 8.7_G constants (general_eval.py, copied byte-identical, imported
# read-only): the per-step gain of the covariance composition kappa'_G = 2 (TV rate)/(mean-shift rate) = M/(e^omega s(r0)), r0 = 6 beta mu(5 beta)
# the conditional law's radius, M = e^{omega'/2}/sqrt(n) MG2's MAD bound, s(r0) Lemma NH's covariance bound; and the IDEAL global two-component
# criterion (every remainder 0; WORK.md §3.3): A = e^w s(r0) L, B = (M/2) L, C = 2 sqrt(e^w s(r0)) N, D = N, with L = 12 l_I + 90 l_II,
# l_I = beta mu(5b), l_II = beta^2 s(5b), N = 12 C^n_dir + 90 C^n_med. KAT: 2B + D = alpha_G (MG2's row) at every beta.
# mpmath intervals at 200 bits (MG2's arithmetic). The ideal global criterion is CONDITIONAL (GAPS 1-2) and a READING of the class's value.
import sys, hashlib, os
from mpmath import iv, mp
HERE = os.path.dirname(os.path.abspath(__file__)); sys.path.insert(0, HERE)
import general_eval as GE
print("EVERYG general_eval.py sha256", hashlib.sha256(open(os.path.join(HERE, "general_eval.py"), "rb").read()).hexdigest())
G = {g["name"]: g for g in GE.group_table()}

def parts(g, beta):
    al, det = GE.alpha_G(g, beta)
    b = iv.mpf(beta); K5 = det["K5"]; K6 = det["K6"]; c3 = det["c3"]; M = det["M"]; om = det["om"]
    r0 = 6 * b * K5["mu"]
    s0 = GE.constants(g, iv.mpf(r0.b), c3)["s"]        # s at the (rounded-up) conditional radius: s is increasing in r
    lI = b * K5["mu"]; lII = b * b * K5["s"]
    CNd = (b * b * K5["D"] + (iv.mpf(2) / 3) * b ** 3 * K6["T"]) / 4
    x = b * b * K5["D"]; y = 2 * b ** 3 * K5["Tx"]; mn = x if x.b <= y.b else y
    CNm = (mn + (iv.mpf(2) / 3) * b ** 3 * K6["T"]) / 4
    L = 12 * lI + 90 * lII; N = 12 * CNd + 90 * CNm
    eom = iv.exp(om)
    A = eom * s0 * L; B = M / 2 * L; C = 2 * iv.sqrt(eom * s0) * N; D = N
    kap = M / (eom * s0)
    kat = 2 * B + D
    return dict(al=al, A=A, B=B, C=C, D=D, kap=kap, kat=kat, r0=r0, s0=s0, M=M)
def passes(p): return p["A"].b < 1 and p["D"].b < 1 and (1 - p["A"].b) * (1 - p["D"].b) > p["B"].b * p["C"].b
def f(x, k=5): return mp.nstr(mp.mpf(x.b), k)
BSTAR = {"SU(2)": "0.1704", "SU(3)": "0.3568", "G2": "0.5171"}
for name in ("SU(2)", "SU(3)", "G2"):
    g = G[name]
    p = parts(g, BSTAR[name])
    print("EVERYG %-6s at MG2's beta* %s: alpha_G %s; KAT 2B + D = %s (equal to alpha_G: %s); kappa'_G = %s; r0 = %s, s(r0) = %s (1/n = %s), M = %s" %
          (name, BSTAR[name], f(p["al"], 7), f(p["kat"], 7), "MET" if abs(mp.mpf(p["kat"].b) - mp.mpf(p["al"].b)) < 1e-12 else "MISSED",
           f(p["kap"], 4), f(p["r0"], 4), f(p["s0"], 5), mp.nstr(mp.mpf(1) / g["n"], 5), f(p["M"], 5)))
    print("        ideal global [[A, B], [C, D]] = [[%s, %s], [%s, %s]] -> %s" % (f(p["A"]), f(p["B"]), f(p["C"]), f(p["D"]), "PASSES" if passes(p) else "fails"))
    # the ideal global criterion's crossing on the grid 10^-3 (march up from beta*)
    bb = mp.mpf(BSTAR[name]); step = mp.mpf("0.01"); last = None
    while True:
        nb = bb + step
        if passes(parts(g, mp.nstr(nb, 6))): bb = nb; last = nb
        else:
            if step <= mp.mpf("0.001"): break
            step = step / 10
    q = parts(g, mp.nstr(bb, 6))
    print("        IDEAL global two-component criterion (CONDITIONAL, a READING of the class): passes on the grid to beta = %s (first-order beta* %s, ratio %s); there alpha_G = %s, kappa'_G = %s" %
          (mp.nstr(bb, 5), BSTAR[name], mp.nstr(bb / mp.mpf(BSTAR[name]), 4), f(q["al"], 5), f(q["kap"], 4)))
