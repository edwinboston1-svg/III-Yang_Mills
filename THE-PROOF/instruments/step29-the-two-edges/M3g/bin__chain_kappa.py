# Lemma R (iii) check (M3g): the free-part Gram along a (j+1)-chain whose end element(s) are truncated (outward bonds).
# Exact rational entries; eigenvalues in double. Reports lambda_min/a (relative to the full diagonal a) for L = 2..8.
from fractions import Fraction as F
import numpy as np
for L in range(2, 9):
    a = F(2 * L * L + 1, 3 * L); b = F(L * L - 1, 6 * L)
    ap = sum(F(s + 1, L) ** 2 for s in range(L - 1))
    assert ap == F((L - 1) * (2 * L - 1), 6 * L)
    # check b also equals the overlap of the truncated last element with the previous element
    bo = sum(F(L - 1 - s, L) * F(s + 1, L) for s in range(L - 1))
    assert bo == b, (L, bo, b)
    worst_one, worst_two = 1e9, 1e9
    for K in range(1, 60):
        for both in (False, True):
            n = K + 1 if not both else K + 2
            M = np.zeros((n, n))
            for i in range(n):
                M[i, i] = float(a)
                if i + 1 < n: M[i, i + 1] = M[i + 1, i] = float(b)
            M[-1, -1] = float(ap)
            if both: M[0, 0] = float(ap)
            lm = np.linalg.eigvalsh(M)[0] / float(a)
            if both: worst_two = min(worst_two, lm)
            else: worst_one = min(worst_one, lm)
    print(f"L={L}: a={a} b={b} a'={ap} Gershgorin a'-b={ap-b}  min_K lambda_min/a: one end truncated {worst_one:.4f}, both ends {worst_two:.4f}")
