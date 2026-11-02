import sys, os
# rev32_supremum.py -- THE GROUND revision 32, part 1b: why Hypothesis I must take the supremum over coarse configurations.
# The low-temperature Ising model satisfies every typical-configuration form of a single-site criterion, with the frustrated
# configurations priced by their chessboard weight, and has long-range order; no condition depending on a measure only through
# the joint law of its single-pair conditional coefficients implies decay.  Applied to the output of rev32_blockmap.py.
# usage: python rev32_supremum.py <r32 dir>; the replacement asserted to occur exactly once.
OUT = sys.argv[1]
p = os.path.join(OUT, 'content4.js')
with open(p, encoding='utf-8') as h:
    s = h.read()
old = 'and it is named here as the demand it is.'
c = s.count(old)
if c != 1:
    sys.exit('REFUSED: the anchor occurs %d times' % c)
new = ('and it is named here as the demand it is. '
       'It cannot be weakened to typical coarse configurations with the frustrated ones priced by their probability. '
       'The Ising model at low temperature on the tori (ℤ/*L*ℤ)^{d}, *d* ≥ 2, satisfies every such form with both prices as small as one likes, and has long-range order. '
       'On the event that the 2(2*d* − 1) outer neighbours of an adjacent pair carry one sign, the maximal correlation of the pair given the rest is sinh 2β/(cosh 2(2*d* − 1)β + cosh 2β) ≤ *e*^{−4(d−1)β}, every function of a two-valued variable being affine. '
       'The complementary event lies in the union of the 4*d* − 1 events that one bond of the pair\'s star is unsatisfied, and by the chessboard estimate its probability is at most (4*d* − 1)·2^{1/L}*e*^{−2β}, with chessboard weight at most 2^{3^d}*e*^{−2β/c_d} for a constant *c*_{d} depending on *d* alone. '
       'Peierls\' argument gives σ₀σ_{x} mean at least ½ for every *x* and *L* once β is large.'
       '[[fn:R. Peierls, "On Ising\'s model of ferromagnetism", *Proc. Cambridge Philos. Soc.* 32 (1936), 477–481; R. B. Griffiths, "Peierls proof of spontaneous magnetization in a two-dimensional Ising ferromagnet", *Phys. Rev.* 136 (1964), A437–A439; J. Fröhlich, R. Israel, E. H. Lieb and B. Simon, "Phase transitions and reflection positivity. I", *Comm. Math. Phys.* 62 (1978), 1–34, for the chessboard estimate and its use on tori.]] '
       'The chessboard estimate that would price the frustrated configurations is the instrument that proves the order. '
       'More generally, no condition that depends on a measure only through the joint law of its single-pair conditional coefficients implies decay of correlations. '
       'In infinite volume μ^{+} and ½(μ^{+} + μ^{−}) are Gibbs measures of one specification and give that law the same distribution, a maximal correlation being invariant under a bijection of each variable\'s values, while only the first has decaying truncated correlations. '
       'The supremum in (8.5) runs over exactly the configurations that Dobrushin\'s comparison visits when it telescopes between two environments typical of different phases, every intermediate one frustrated.')
s = s.replace(old, new)
with open(p, 'w', encoding='utf-8', newline='') as h:
    h.write(s)
print('REV32 part 1b written')
