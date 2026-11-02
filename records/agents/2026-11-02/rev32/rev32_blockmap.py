import sys, os, shutil
# rev32_blockmap.py -- THE GROUND revision 32, part 1: the construction for every fixed integer L, the block map's example
# corrected (the path holonomy empties the reduction; the block average keeps its information), and the widening of Theorem 8.5
# to every measurable coarse map with values in a fixed compact space (Bałaban's averaged variables admitted).
# usage: python rev32_blockmap.py <source/ground dir> <out dir>; every replacement asserted to occur exactly once.
SRC, OUT = sys.argv[1], sys.argv[2]
os.makedirs(OUT, exist_ok=True)
for f in os.listdir(SRC):
    if f.endswith('.js'):
        shutil.copy(os.path.join(SRC, f), os.path.join(OUT, f))


def rd(f):
    with open(os.path.join(OUT, f), encoding='utf-8') as h:
        return h.read()


def wr(f, s):
    with open(os.path.join(OUT, f), 'w', encoding='utf-8', newline='') as h:
        h.write(s)


def once(s, old, new, what):
    c = s.count(old)
    if c != 1:
        sys.exit('REFUSED %s: the old text occurs %d times' % (what, c))
    return s.replace(old, new)


s = rd('content4.js')

s = once(s,
         'Fix a physical length *a*_{c} = 2^{k₀}*a*₀ with *k*₀ ≥ 0, an integer multiple of the unit *a*₀ of Theorem 7.4, and call it the coarse scale. Take the construction with *L* = 2, with lattices whose sides are multiples of *a*_{c} and whose reflection hyperplane is one of the hyperplanes *x*₀ = *n a*_{c}.',
         'Fix a physical length *a*_{c} = *L*^{k₀}*a*₀ with *k*₀ ≥ 0, an integer multiple of the unit *a*₀ of Theorem 7.4, *L* being the fixed integer of its construction, and call it the coarse scale. Take the construction with lattices whose sides are multiples of *a*_{c} and whose reflection hyperplane is one of the hyperplanes *x*₀ = *n a*_{c}.',
         'the coarse scale for every L')

s = once(s,
         'and Φ_{j} is compact; one SU(2) element per coarse link, the holonomy of the block along a fixed path, with the remaining links in a fixed gauge, is such a map.',
         'and Φ_{j} is compact. One SU(2) element per coarse link, the holonomy of the block along a fixed path with the remaining links in a fixed gauge, is such a map, and one on which the reduction below is empty. '
         'For the Gaussian field with covariance *g*²(−Δ)^{−1} in Feynman gauge, the flux through an *n* × *n* square, the angle of the coarse plaquette this map defines, has variance *g*²(4*G*₃(0)*n* + *o*(*n*)), '
         'where 4*G*₃(0) = 4Σ_{m∈ℤ} *G*₄(*m e*₁) = 2*W*/3, *G*_{d} is the inverse of the *d*-dimensional lattice Laplacian, and *W* = √6 Γ(1/24)Γ(5/24)Γ(7/24)Γ(11/24)/(32π³) is the return sum of the three-dimensional walk. '
         'Indeed the variance is *g*² times the sum of *G*₄ over pairs of boundary links of the square, weighted by their orientations; perpendicular sides do not couple, each side with itself gives *S*_{n} = Σ_{|m|<n}(*n* − |*m*|)*G*₄(*m e*₁), the opposite sides give −*T*_{n} with 0 ≤ *T*_{n} ≤ *n G*₃(*n e*₂), which is bounded, and *S*_{n}/*n* → *G*₃(0) by dominated convergence, *G*₄(*m e*₁) being summable. '
         'Along the asymptotically free sequence, where *g*²_{YM} falls only as 1/log *n*, this variance diverges, so at one loop every character mean of the path holonomy tends to zero: its coarse variables tend to independent Haar variables, Hypothesis I below then holds trivially, Hypothesis II(a) becomes the clustering of the Wilson measure itself, and the theorem reduces nothing. That the same holds beyond one loop is the self-energy divergence of bare Wilson lines, which is standard and is not proved here for this map. '
         'The block average, in which each coarse link is the average over the *n*³ parallel fine paths of its block, is free of this: in the same Gaussian field the flux of its coarse plaquette has variance converging, as *n* → ∞, to *g*² times the finite integral 2∫ |Π_{ν} φ(*q*_{ν})|² |1 − *e*^{iq₂}|² |*q*|^{−2} *d*⁴*q*/(2π)⁴, with φ(*q*) = (*e*^{iq} − 1)/(*iq*), the integrand being dominated by an integrable function on ℝ⁴; along the sequence it falls like 1/log *n*, a weak-coupling variable, as the coarse variables of Bałaban\'s renormalisation group are. '
         'The proof of Theorem 8.5 below uses the block map only through the disintegration of μ_{j} along the coarse configuration and through versions of the fibre and blocked conditional laws defined for every coarse configuration, and it holds unchanged for any measurable map from the configurations of a rung to coarse configurations with values in *V*, with Hypotheses I and II read for such versions. This admits the averaged variables of Bałaban\'s renormalisation group, on blocks of odd side centred on the coarse points, whose coarse coordinate at a coarse point depends also on links of the adjacent blocks; so the reduction applies to the coarse variables of the ultraviolet analysis of §8.1 itself.',
         'the block map example and the widening')

s = once(s,
         'Let a construction be as in Theorem 7.4 with L = 2, blocked at the coarse scale a_{c} with a block map as above',
         'Let a construction be as in Theorem 7.4, blocked at the coarse scale a_{c} with a block map as above',
         'Theorem 8.5 for every L')

wr('content4.js', s)
print('REV32 part 1 written to', OUT)
