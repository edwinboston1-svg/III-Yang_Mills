import sys
# rev33_s12.py -- THE GROUND revision 33, the S12-c' narrowing: the proof agent M1 found that S12-c' covers RECTANGULAR cycles only
# (at a reflex corner the interior square is unforced); revision 32 wrote "a planar cycle". usage: python rev33_s12.py <content4.js>
p = sys.argv[1]
with open(p, encoding='utf-8') as h:
    s = h.read()
old = 'a skew hexagon or a planar cycle whose interior links at its straight vertices have multiplicity two, which every unit square, 1 × n rectangle and 2 × 2 square is;'
new = 'a skew hexagon or a rectangular cycle whose interior links at its straight vertices have multiplicity two, which every unit square, 1 × n rectangle and 2 × 2 square is;'
c = s.count(old)
if c != 1:
    sys.exit('REFUSED: the S12-c\' phrase occurs %d times' % c)
s = s.replace(old, new)
with open(p, 'w', encoding='utf-8', newline='') as h:
    h.write(s)
print('REV33 S12-c\' narrowed to rectangular cycles')
