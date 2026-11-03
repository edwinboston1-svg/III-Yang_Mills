#!/usr/bin/env python3
# explore_ideal.py -- CC, 2026-11-02. A READING (double precision), not a certificate: the IDEAL covariance-composition
# factor on the side-2 base block, to orient before any theorem is written. Usage: python explore_ideal.py ../../M87/geom.json
import sys, json, math
import numpy as np

def bessel_I(nu, x, K=80):
    h = x / 2.0; t = h ** nu / math.factorial(nu); s = 0.0
    for k in range(K):
        s += t; t *= h * h / ((k + 1) * (k + 1 + nu))
    return s
def m(r): return bessel_I(2, r) / bessel_I(1, r) if r > 0 else 0.0
def regs(r):
    z = r * r / 4.0
    A = sum(z ** k / (math.factorial(k) * math.factorial(k + 2)) for k in range(60))
    B = sum(z ** k / (math.factorial(k) * math.factorial(k + 1)) for k in range(60))
    P = sum(math.factorial(4 + 2 * k) / (math.factorial(k) * math.factorial(4 + k) * math.factorial(2 + k) * math.factorial(3 + k)) * z ** k for k in range(60))
    return z, A, B, P
def Dabs(r):
    z, A, B, P = regs(r); return z * P / B ** 2
def phi2(r):
    z, A, B, P = regs(r); return A / (2 * B) - z * P / B ** 2
def phi3abs(r): return 2 * m(r) * phi2(r) - 3 * Dabs(r) / r

def consts(beta, sharp):
    M5 = m(5 * beta)
    if sharp: D5 = Dabs(5 * beta); T6 = phi3abs(6 * beta) * 1.0004   # pointwise; the cell sup is ~3.5e-4 relatively larger
    else: D5 = M5 ** 2 / 3; T6 = m(6 * beta) / 2
    om = 3 * beta ** 2 * D5 + 2 * beta ** 3 * T6
    rho = (3 * math.exp(om) - 1) / 2
    lin_dir = rho * 4 * beta / (3 * math.pi) * M5
    nl_dir = 0.25 * (beta ** 2 * D5 + 2 / 3 * beta ** 3 * T6)
    lin_med = rho * beta ** 2 / (3 * math.pi)
    nl_med = 0.25 * (min(beta ** 2 * D5, 2 * beta ** 3 * T6) + 2 / 3 * beta ** 3 * T6)
    return dict(M5=M5, D5=D5, T6=T6, om=om, rho=rho, lin_dir=lin_dir, nl_dir=nl_dir, lin_med=lin_med, nl_med=nl_med,
                Cdir=lin_dir + nl_dir, Cmed=lin_med + nl_med, alpha=12 * (lin_dir + nl_dir) + 90 * (lin_med + nl_med))

geom = json.load(open(sys.argv[1]))
blk = geom["G"]["base_block"]; cls = geom["G"]["base"]; links = blk["links"]; n = len(links)
NI = np.array(blk["NI"], float); NII = np.array(blk["NII"], float)
n1in = np.array([cls[l]["n1in"] for l in links], float); n2in = np.array([cls[l]["n2in"] for l in links], float)

for beta, sharp in ((0.2414, False), (0.26, False), (0.28, False), (0.26, True), (0.28, True)):
    c = consts(beta, sharp)
    kap = 16 / (3 * math.pi) * c["rho"] / math.exp(c["om"])
    Cbb = NI * c["Cdir"] + NII * c["Cmed"]
    Lin = NI * c["lin_dir"] + NII * c["lin_med"]; Nl = NI * c["nl_dir"] + NII * c["nl_med"]
    r = (12 - n1in) * c["Cdir"] + (90 - n2in) * c["Cmed"]
    I = np.eye(n)
    t1 = np.linalg.solve(I - Cbb, r); e1 = (t1 - r).sum(); slack = (1 - r).sum()
    t_id = np.linalg.solve(I - Lin / kap - Nl, r); e_id = (t_id - r).sum()
    t_all = np.linalg.solve(I - Cbb / kap, r); e_all = (t_all - r).sum()
    print("beta=%.4f %s alpha=%.6f kappa'=%.4f  lin share of row %.3f | first-order indirect sum %.4f slack %.4f need factor %.3f" %
          (beta, "SHARP " if sharp else "PROVED", c["alpha"], kap, (12 * c["lin_dir"] + 90 * c["lin_med"]) / c["alpha"], e1, slack, e1 / slack))
    print("    IDEAL (linear in-block steps / kappa', nonlinear at TV): indirect sum %.4f -> factor %.3f ; block avg row %.5f ; max row %.5f" %
          (e_id, e1 / e_id, t_id.mean(), t_id.max()))
    print("    ALL in-block steps / kappa' (an over-generous ceiling):  indirect sum %.4f -> factor %.3f ; block avg row %.5f ; max row %.5f" %
          (e_all, e1 / e_all, t_all.mean(), t_all.max()))
    print("    max in-block row (first order) %.4f ; spectral radius C_BB %.4f" % (Cbb.sum(1).max(), max(abs(np.linalg.eigvals(Cbb)))))
