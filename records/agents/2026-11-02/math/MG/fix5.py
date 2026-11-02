import io, sys
p = sys.argv[1]
s = io.open(p, encoding='utf-8').read()
old1 = "any coordinate in the second class contributes −cos(π/N − s) and lowers the sum, so the maximum is at θ_j ≡ θ, Nθ ∈ 2πℤ, value"
new1 = "with k coordinates in the second class the value is (N − 2k)cos(π/N − s), and for 1 ≤ k ≤ N − 1 this is at most N − 2 < N cos(π/N) (N ≥ 3: N − N cos(π/N) ≤ π²/(2N) < 2), so the maximum is at θ_j ≡ θ, Nθ ∈ 2πℤ, value"
old2 = "(v) Under the Wilson measure the average M = Σ_i c_iρ(U(π_i))\nhas a law absolutely continuous on E_G as soon as the family of paths is large enough that the average's law is (Ragozin-type\nsmoothing of convolutions of the orbit measure; for the families of THE GROUND's averaged map, n³ ≥ 2 parallel paths) — then 𝒞_G\nis a null event and any measurable extension of Π_G on it gives a measurable coarse map, which is all Theorems 8.5 and 8.5′ consume."
new2 = "(v) A Borel selection of the argmax exists on all of E_G (the argmax is a nonempty compact-valued upper\nhemicontinuous correspondence: Kuratowski–Ryll-Nardzewski), so the averaged coarse map M ↦ Π_G(M) is measurable for every G whatever\nthe law of M — which is all Theorems 8.5 and 8.5′ consume; when the law of the average is absolutely continuous on E_G (necessary:\nk·dim G ≥ dim E_G for k summands; for SU(2) two independent uniform points of S³ already have a density on the ball of radius 2), the\nselection on the null set 𝒞_G is immaterial."
old3 = "(v) The law of M is the image of the Wilson measure, which has\na continuous positive density with respect to Haar; absolute continuity on E_G of the image of Haar under (U_i) ↦ Σc_iρ(U_i) for enough\nsummands is the smoothing of iterated convolutions of a compact orbit's measure (Ragozin, J. Funct. Anal. 1972, for orbital measures —\nLITERATURE; for SU(2) it is elementary: the sum of two independent uniform points of S³ has a density on the ball of radius 2). ∎"
new3 = "(v) The correspondence M ↦ argmax is nonempty, compact-valued and upper hemicontinuous (Berge's maximum theorem), hence admits a Borel\nselection (Kuratowski–Ryll-Nardzewski — LITERATURE). ∎"
for o, n in ((old1, new1), (old2, new2), (old3, new3)):
    if s.count(o) != 1:
        print('MISS', o[:60]); sys.exit(1)
    s = s.replace(o, n)
io.open(p, 'w', encoding='utf-8').write(s)
print('patched')
