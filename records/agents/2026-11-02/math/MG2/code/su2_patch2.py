src = open('su2_eval.py').read()
src = src.replace("""def alpha_su2(beta, mode):
    b = iv.mpf(beta)""", """def alpha_su2(beta, mode):
    b = iv.mpf(str(beta)) if isinstance(beta, str) else iv.mpf(beta)   # a decimal string is enclosed exactly""")
src = src.replace("""        D5 = sup_over_r(lambda r: abs(phis(r)[2]), 5 * mp.mpf(beta))
        T6 = sup_over_r(cum3_max, 6 * mp.mpf(beta))""", """        D5 = sup_over_r(lambda r: abs(phis(r)[2]), 5 * b.b.b)
        T6 = sup_over_r(cum3_max, 6 * b.b.b)""")
src = src.replace("""    b = mp.mpf(lo); last = None
    while b <= mp.mpf(hi) + mp.mpf(step) / 10:
        R = alpha_su2(b, mode)
        if mp.mpf(R['alpha'].b.b) < 1: last = b
        else: break
        b += mp.mpf(step)
    return last, b""", """    from decimal import Decimal
    b = Decimal(lo); last = None
    while b <= Decimal(hi) + Decimal(step) / 10:
        R = alpha_su2(str(b), mode)
        if mp.mpf(R['alpha'].b.b) < 1: last = b
        else: break
        b += Decimal(step)
    return last, b""")
src = src.replace("""print('%s ROOT: certified alpha < 1 at beta = %s; first grid point not certified: %s' % (mode, mp.nstr(last, 8), mp.nstr(first_fail, 8)))""", """print('%s ROOT: certified alpha < 1 at beta = %s; first grid point not certified: %s' % (mode, last, first_fail))""")
src = src.replace("""        R = alpha_su2(mp.mpf(beta), mode)""", """        R = alpha_su2(beta, mode)""")
open('su2_eval.py', 'w').write(src)
print('patched2')
