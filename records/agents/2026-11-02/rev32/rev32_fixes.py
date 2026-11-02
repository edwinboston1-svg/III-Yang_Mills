import sys, os
# rev32_fixes.py -- THE GROUND revision 32, part 1c, applied after rev32_blockmap.py and rev32_supremum.py:
#  (a) the time extent for odd L (site reflections on the torus need the half period on the lattice) -- M2R's note;
#  (b) Bałaban's averaged variables extended measurably where the average vanishes -- M2R's note;
#  (c) Theorem 8.9's condition list: S12-c' as corrected in scope on the companion page (2026-11-01 18:0x), the planar cycles
#      whose interior links at straight vertices have multiplicity two, of which the 1 x n rectangles and the 2 x 2 square are cases;
#  (d) the open part's sentence "nothing above 0.4764 is proved at all" against the theorem's own tree-dressing 0.4816.
# usage: python rev32_fixes.py <r32 dir>; every replacement asserted to occur exactly once.
OUT = sys.argv[1]
p = os.path.join(OUT, 'content4.js')
with open(p, encoding='utf-8') as h:
    s = h.read()


def once(s, old, new, what):
    c = s.count(old)
    if c != 1:
        sys.exit('REFUSED %s: the old text occurs %d times' % (what, c))
    return s.replace(old, new)


s = once(s,
         'Take the construction with lattices whose sides are multiples of *a*_{c} and whose reflection hyperplane is one of the hyperplanes *x*₀ = *n a*_{c}.',
         'Take the construction with lattices whose sides are multiples of *a*_{c}, the time extent an even multiple when *L* is odd so that the half period lies on the lattice, and whose reflection hyperplane is one of the hyperplanes *x*₀ = *n a*_{c}.',
         '(a) the time extent for odd L')

s = once(s,
         'This admits the averaged variables of Bałaban\'s renormalisation group, on blocks of odd side centred on the coarse points, whose coarse coordinate at a coarse point depends also on links of the adjacent blocks;',
         'This admits the averaged variables of Bałaban\'s renormalisation group, on blocks of odd side centred on the coarse points, whose coarse coordinate at a coarse point depends also on links of the adjacent blocks, once each is extended measurably to the configurations at which its average vanishes;',
         '(b) the measurable extension')

s = once(s,
         'or when every link of the cycle has multiplicity six and the cycle is a unit square, a 1 × n rectangle, a 2 × 2 square or a skew hexagon;',
         'or when every link of the cycle has multiplicity six and the cycle is a skew hexagon or a planar cycle whose interior links at its straight vertices have multiplicity two, which every unit square, 1 × n rectangle and 2 × 2 square is;',
         '(c) the S12 condition list')

s = once(s,
         'and nothing above 0.4764 is proved at all.',
         'and nothing above 0.4816, where the same inequality holds in the tree dressing (0.4764 in the dressing of the page), is proved at all.',
         '(d) the open part')

with open(p, 'w', encoding='utf-8', newline='') as h:
    h.write(s)
print('REV32 part 1c written')
