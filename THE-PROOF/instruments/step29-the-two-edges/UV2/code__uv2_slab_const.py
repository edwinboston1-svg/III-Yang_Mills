# UV2: evaluate the PROVED constant of Theorem SP-SLAB (WORK.md section 8.4) from its explicit formula.
# Inputs: c = c_bulk(L,d), C = C_a^opt(L,d) (Bloch, rec/bloch + rec/ca_profile), the blend-profile sums X0, X1, X2, chi(1) (exact finite sums),
# P_L = 1/(4 sin^2(pi/(2L))).  Every formula below is the one written in section 8.4, term by term.
import math
import numpy as np
BULK = {(2, 2): (0.500000, 32.0000), (2, 4): (0.327190, 58.5143), (2, 8): (0.283718, 69.4442),
        (4, 2): (0.500000, 64.0000), (4, 3): (0.350788, 110.0459), (4, 4): (0.283811, 143.0407), (4, 6): (0.231226, 177.9985)}
def profile(L):
    t = np.arange(L) / L
    beta = ((1 - t) ** 2).sum() / ((1 - t) ** 2 * t).sum()
    q = lambda s: np.where(s < 1, (1 - s) ** 2 * (1 - beta * s), 0.0)
    ch = q(np.arange(L + 2) / L)
    X0 = (ch[:L] ** 2).sum(); X1 = ((ch[1:L + 1] - ch[:L]) ** 2).sum()
    X2 = ((ch[2:L + 2] - 2 * ch[1:L + 1] + ch[:L]) ** 2).sum()
    return X0, X1, X2, ch[1]
RIG = {k: ((4 / math.pi ** 2) * (2 / math.pi) ** (2 * k[0]), (k[0] * math.pi ** 4 / 4) * (math.pi / 2) ** (2 * k[0])) for k in BULK}
for tagset, TAB in (("READINGS (grid) of c, C", BULK), ("CLOSED-FORM rigorous c, C (m = 0 term)", RIG)):
  print("#", tagset)
  for (d, L), (c, C) in sorted(TAB.items()):
    X0, X1, X2, ch1 = profile(L)
    PL = 1 / (4 * math.sin(math.pi / (2 * L)) ** 2)
    # pieces, each as (coefficient of E0, coefficient of Ebar)
    D0 = (9 * L, 9 * L ** 3 / c + 4 * L / c + 4 * L * C)          # sum |d0|^2
    DT = (2.0, 4 * L / c + 4 * L * C)                             # sum |D_perp d0|^2
    DL = (8 * (d - 1), (4 / L + 16 * L) * C)                      # sum |Delta_perp d0|^2
    LDb = (0.0, 2 * L / c + 2 * L * C)                            # layer of |D_d lambda^b|^2
    LLb = (0.0, (2 / L + 8 * L) * C)                              # layer of |Delta_perp lambda^b|^2
    add = lambda *ps: tuple(sum(p[i] for p in ps) for i in (0, 1))
    mul = lambda k, p: (k * p[0], k * p[1])
    # ||ell^-1 D lt||^2 <= E0 + (2/c) Ebar + 4 L^-2 (X0 DT + X1 D0)            [two interfaces, disjoint blends]
    B = add((1.0, 2 / c), mul(4 / L ** 2, add(mul(X0, DT), mul(X1, D0))))
    # ||Delta lt||^2 <= 4d E0 + 2[4 LLb + 4 DL + 4 LDb + 4 (chi(1)-1)^2 D0] + 2 C Ebar + 8 X0 DL + 8 X2 D0
    A = add((4.0 * d, 0.0), mul(2, add(mul(4, LLb), mul(4, DL), mul(4, LDb), mul(4 * (ch1 - 1) ** 2, D0))),
            (0.0, 2 * C), mul(8 * X0, DL), mul(8 * X2, D0))
    # Ebar <= E1 + (4d/L^2) E0, N = E0 + E1
    toN = lambda p: max(p[0] + 4 * d / L ** 2 * p[1], p[1])
    Cb, Ca = toN(B), toN(A)
    for conv, Cc in (('max', PL / L ** 2), ('min', PL / L ** 2 + 1)):
        cp = 1 / (math.sqrt(Cb) + math.sqrt(Ca * Cc)) ** 2
        print(f"d={d} L={L} [{conv}]: c_bulk={c:.4f} C_a^opt={C:.2f} X0={X0:.3f} X1={X1:.3f} X2={X2:.4f} chi(1)={ch1:.4f} P_L/L^2={PL / L ** 2:.4f} | "
              f"C_b <= {Cb:.1f}, C_a <= {Ca:.1f}, C_c <= {Cc:.4f} | PROVED c_scal(slab) >= {cp:.3e}")
