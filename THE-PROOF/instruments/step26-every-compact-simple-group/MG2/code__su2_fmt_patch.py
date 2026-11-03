import re
src = open('su2_eval.py').read()
src = src.replace("""def fmt(x, n=8):
    return '[%s, %s]' % (mp.nstr(x.a, n), mp.nstr(x.b, n))""", """def fmt(x, n=8):
    lo = mp.mpf(x.a.a); hi = mp.mpf(x.b.b)
    return '[%s, %s]' % (mp.nstr(lo, n), mp.nstr(hi, n))""")
src = src.replace("""if __name__ == '__main__':
    mode = sys.argv[1] if len(sys.argv) > 1 else 'L86'
    for beta in""", """def root(mode, lo, hi, step):
    # largest grid point beta (step) in [lo, hi] with certified alpha < 1 (alpha increasing in beta)
    b = mp.mpf(lo); last = None
    while b <= mp.mpf(hi) + mp.mpf(step) / 10:
        R = alpha_su2(b, mode)
        if mp.mpf(R['alpha'].b.b) < 1: last = b
        else: break
        b += mp.mpf(step)
    return last, b

if __name__ == '__main__':
    mode = sys.argv[1] if len(sys.argv) > 1 else 'L86'
    if len(sys.argv) > 2 and sys.argv[2] == 'root':
        last, first_fail = root(mode, sys.argv[3], sys.argv[4], sys.argv[5])
        print('%s ROOT: certified alpha < 1 at beta = %s; first grid point not certified: %s' % (mode, mp.nstr(last, 8), mp.nstr(first_fail, 8)))
        sys.exit(0)
    for beta in""")
open('su2_eval.py', 'w').write(src)
print('patched')
