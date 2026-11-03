src = open('rowlow.py', encoding='utf-8').read()
old = src[src.index("def loops_through(link):"):src.index("def conjq(q):")]
new = '''_LT = {}
def _loops_through_origin(d):
    res = []
    for b in itertools.product(range(-3, 4), repeat=4):
        for fi, st, steps in LOOPS:
            ls = loop_links(st, steps, b)
            if any((l[0], l[1]) == ((0, 0, 0, 0), d) for l in ls): res.append((fi, ls))
    return res
def loops_through(link):
    """every (family, ordered link list) containing link = (site, dir): the translate of the origin's list"""
    x, d = link
    if d not in _LT: _LT[d] = _loops_through_origin(d)
    return [(fi, [(tuple(a + b for a, b in zip(l[0], x)), l[1], l[2]) for l in ls]) for fi, ls in _LT[d]]

'''
src = src.replace(old, new)
open('rowlow.py', 'w', encoding='utf-8').write(src)
print('ok')
