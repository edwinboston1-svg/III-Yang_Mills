src = open('su2_eval.py').read()
old = """    m, p2, D, Dr, p3 = phis_regular(r)
    best = iv.mpf(0)
    N = 64
    for i in range(N):
        c = iv.mpf([mp.mpf(i) / N, mp.mpf(i + 1) / N])
        val = p3 * c ** 3 + 3 * Dr * c * (1 - c * c)
        a = abs(val)
        if a.b > best.b:
            best = iv.mpf(a.b)
    return best"""
new = """    # kappa(c) = c (a + b c^2), a = 3 D/r, b = phi''' - 3 D/r; on a c-cell [c1, c2] it is c times a function LINEAR in s = c^2, so
    # |kappa| <= c2 * max(|a + b s1|, |a + b s2|) with a, b intervals (no dependency loss)
    m, p2, D, Dr, p3 = phis_regular(r)
    a = 3 * Dr; bb = p3 - 3 * Dr
    best = iv.mpf(0)
    N = 256
    for i in range(N):
        c1 = iv.mpf(mp.mpf(i) / N); c2 = iv.mpf(mp.mpf(i + 1) / N)
        v1 = abs(a + bb * c1 * c1); v2 = abs(a + bb * c2 * c2)
        hi = c2 * iv.mpf(max(mp.mpf(v1.b), mp.mpf(v2.b)))
        if hi.b > best.b:
            best = iv.mpf(hi.b)
    return best"""
assert old in src
src = src.replace(old, new)
src = src.replace("def sup_over_r(f, R, cells=200, r0=0):", "def sup_over_r(f, R, cells=600, r0=0):")
open('su2_eval.py', 'w').write(src)
print('patched3')
