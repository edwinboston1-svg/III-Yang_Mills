# M2R — THE SECOND READING OF M2/WORK.md (2026-11-02)

Second reader, desktop seat, read-only outside this directory. Sources read in full before any verdict: the shared brief
(math/MATH_BRIEF.md); THE GROUND §§7–8 (cross/ground_docx.txt lines 163–327: Theorem 7.1, Corollary 7.2, Lemma 7.3, Theorem 7.4,
Propositions 8.1, 8.2, 8.4, Hypotheses I and II, Theorem 8.5 and its proof, the discussion after it); the draft M2/WORK.md (all 507
lines); its reader M2/l2dob.c (survey); the engine III/STDLIB/build/aperanton/surface-gas/w2_strip_n.c (all 330 lines, working tree;
`git diff` shows 24 added lines against HEAD, none in build()). Every computation of this reading is in this directory with its record.

Verdict alphabet: HOLDS / FAILS at <step> / CONDITIONAL on <exactly what>.

---

## Item 7 — §6.0's integrity finding (the bent engine enters the n+1 corner plaquettes twice): CONFIRMED AT THE LINE

Read in the engine (working tree, which agrees with HEAD on build()):
- line 64, `okey`: registers ANY (base, direction) as an outside link; it never consults the object table `LB` that `lkey` keeps.
- line 70, `is_obj_plaq`: true only for the 2n² face plaquettes added at lines 81–82.
- lines 99–107, the staple loop: for every object link l and every plaquette through l that is not a face plaquette, the three other
  links of that plaquette enter `STAP[l]` through `okey` — so an object link lying in a non-face plaquette is read from the DATUM.
- In the bent geometry the plaquette at base (0,j,0) in the (1,3) plane holds face A's x-link (0,j,0)→(1,j,0) (an object link for
  j = 0..n, line 81) and face B's z-link (0,j,0)→(0,j,1) (an object link for j = 0..n, line 82), and it is not a face plaquette. It is
  therefore entered twice: in A's x-link's weight with B's z-link at its datum value (line 106, `okey(p, k)` with k = 3), and in B's
  z-link's weight with A's x-link at its datum value (line 106, k = 1). Each of the 2(n+1) hinge links is integrated as an object link
  AND fixed at its datum value inside the other link's corner staple.

Replicated by machine (stapcheck.c, a copy of lines 61–107's logic plus a census asking `lkey` about every staple link; records
stap_n{2,4}_{bent,planar}.txt):

| geometry | n | staples holding an object link read from the datum | distinct plaquettes | staples five / four |
|---|---|---|---|---|
| bent | 2 | 6 | 3: (1,3)-plaquettes at (0,0,0), (0,1,0), (0,2,0) | 12 / 10 |
| planar | 2 | 0 | 0 | 12 / 10 |
| bent | 4 | 10 | 5: (1,3)-plaquettes at (0,j,0), j = 0..4 | 24 / 52 |
| planar | 4 | 0 | 0 | 24 / 52 |

No other non-face plaquette contains two object links (checked by the census, and by hand: two face-A links share only (1,2)-plaquettes
at z = 0, two face-B links only (2,3)-plaquettes at x = 0, and the only mixed incidences are the corners). The planar object is clean.

The draft's mechanism for D6 is also right, and sharper than "indistinguishable": at the ordered datum every outside link is the
identity (line 229), so every staple is the identity, every link weight is w(U)^{NSTAP(l)} with NSTAP(l) = 6 − #(face plaquettes on l)
in BOTH geometries (the census's five/four counts agree), and the two objects are the same 2-complex (two n×n grids sharing an edge of
n links) — the bent engine's law at the ordered datum IS the planar law, identically, not to the digit. At the cancelling datum (line
230) only the middle links of the shared link's four staples move, none of them in a corner plaquette, and the multiset of the shared
link's staple values {1, −1, i, −i} is the same in both geometries, so again bent ≡ planar. The true bent object carries, per corner,
the single factor w(U_Ax · U_{(1,j,0),3} · U_{(0,j,1),1}⁻¹ · U_Bz⁻¹) coupling A to B; the engine never computed it. At the random datum
the engine computes a third object (each corner replaced by two plaquettes through independent phantom links), as the draft says.

VERDICT 7: HOLDS (the finding is confirmed at lines 64, 70, 99–107, and by the replica's census).

---

## Sighted tests run for items 1, 2, 3, 6 (records in this directory; double precision, readings, not certificates)

l2check.c (records l2check_seed{1..5}.txt): per seed, 300 random positive symmetric kernels (n = 3..14, k = 1..5); 120 random Gibbs
systems (3–4 sites, 2–4 states, random pair potentials of strength 0.3–2.8, 60 (F, G) pairs each, R computed as the max over EVERY
environment of the exact pair maximal correlation); 200 projection pairs with planted intersections × 400 vectors; 300 mixture systems
(A, B, ξ, ω₂) at every ξ. Worst ratio lhs/rhs over the five seeds (a ratio above 1 + 10⁻⁹ would be a counterexample):

| statement | worst over 5 seeds | reading |
|---|---|---|
| 1.1(iii) χ² identity, relative error | 1.1·10⁻¹¹ | identity MET |
| 1.1(ii) ‖Pᵏ‖_{L²₀}^{1/k} against λ₁/λ₀, absolute | < 10⁻¹² | identity MET (the first run's 8·10⁻⁴ was the TESTER's absolute Jacobi threshold stopping on a matrix of size 10⁻¹⁰; made relative, rerun) |
| 1.1(iv) ‖Pᵏ‖_{L²₀}/δ(Pᵏ) | 0.99998 | HELD |
| 2.1 ℓ_z(K_yF)/(ℓ_z(F) + Rℓ_y(F)) | 1.000000000000 | HELD (equality is the trivial case F independent of v_y) |
| 2.3 (1 − ρ(R))/gap(−L) | 0.99984 | HELD |
| 2.3 \|Cov\|/(ℓ(F)ᵀDℓ(G)) | 0.9971 | HELD |
| 2.3 Var/((1 − ρ(R))⁻¹ΣE Var) | 0.9932 | HELD |
| 2.5 ρ_ξ²/(C_ξ(y\|z)C_ξ(z\|y)), three or more states | 0.999999 | HELD |
| 2.5 binary pairs, \|ρ_ξ²/(CC) − 1\| | 6·10⁻⁸ | EQUALITY (item 3) |
| 7.2 ‖(I−Q)PF‖/(‖(I−Q)F‖ + c‖(I−P)F‖) | 0.9987 | HELD |
| 5.1 ρ_ξ(A,B)/(sup ρ_ω + ρ(A;ω)ρ(B;ω)) | 0.9960 | HELD |
| 7.1 ρ_ξ(A,B)/(√(M_AM_B)Eρ_ω + ρ(A;ω)ρ(B;ω)) | 0.9861 | HELD |

projgap.c (projgap.txt): the draft's "Consequences" after Lemma 7.2 read for ARBITRARY orthogonal projections (12,000 random families,
N = 2..5 subspaces of ℝ⁴..ℝ¹², planted common parts, 3,420 with ρ(C) < 1): worst (1 − ρ(C))/λ_min(Σ(I − P_i) on (∩M_i)^⊥) = 1 + 7·10⁻¹¹,
at N = 2 cells where the bound is an equality (rounding). HELD.

---

## Item 1 — Proposition 1.1: HOLDS (classical, W = 0)

(i)–(ii) are the ground-state (Doob) transform: ⟨g, Pf⟩_π = λ₀⁻¹∬gψ₀Tψ₀f is symmetric; multiplication by ψ₀ is unitary L²(π) → L²(dx)
(ψ₀ continuous, bounded below on compact X) and UPU⁻¹ = T/λ₀; P on L²₀(π) is unitarily T/λ₀ on ψ₀^⊥, compact self-adjoint, whose norm is
its largest |eigenvalue|. "m_lat = −log‖P‖_{L²₀}" needs T POSITIVE (otherwise λ₁ is the largest modulus, possibly a negative eigenvalue):
the Wilson transfer matrix on the gauge-invariant sector is positive (Osterwalder–Seiler; Lüscher), and its kernel ∫dg T(U, V^g) is
symmetric by gauge invariance and time-reflection symmetry. Z_{2k} must be read as Tr(TP₀)^{2k}, P₀ the gauge projection (the periodic
lattice in temporal gauge keeps one slice of time links) — i.e. T is the gauge-projected transfer matrix.

(iii) is correct line by line: p_k = Tᵏ(x,y)/(λ₀ᵏψ₀(x)ψ₀(y)), ∬p_k²dπdπ = λ₀^{−2k}‖Tᵏ‖²_HS = λ₀^{−2k}Tr T^{2k}, ∬p_k = 1, so the π-average of
χ²(Pᵏ(x,·)‖π) is Σ_{i≥1}(λ_i/λ₀)^{2k}. Classical: the averaged ℓ²-distance identity for reversible chains (Saloff-Coste, Lectures on
finite Markov chains, 1997; Levin–Peres–Wilmer ch. 12). (iv) ‖Pᵏ‖_{L²₀} ≤ δ(Pᵏ) is the classical bound of the subdominant eigenvalue by
Dobrushin's ergodicity coefficient (Seneta, Non-negative Matrices and Markov Chains, 1981; Proposition 8.1's oscillation argument), valid
because eigenfunctions of nonzero eigenvalues are continuous, hence bounded.

What is dominated and what is not. The NORM is dominated by Proposition 8.1's coefficient; the averaged χ² of (iii) is NOT, and is not
even bounded by 1: on a product of N independent copies of the positive kernel [[1, b],[b, 1]] (ratio β = (1−b)/(1+b)),
Σ_{i≥1}(λ_i/λ₀)^{2k} = (1 + β^{2k})^N − 1, which exceeds 1 ≥ δ(Pᵏ) at β = ½, k = 1 once N ≥ 4. The draft claims no such domination and says
the χ² route needs the free energy to precision e^{−2km}·(number of low states) — the right reading: on a cross-section of V sites the
average carries at least the multiplicity of the first excited level, so it bounds the gap only for 2k·m_lat ≳ log V.

VERDICT 1: HOLDS.

---

## Item 2 — Lemma 2.1 / 7.2, Proposition 2.2, Theorem 2.3: HOLD; the tensorization half is classical (Kassabov 2011), the bilinear
covariance bound is the draft's own assembly

Lemma 2.1, line by line. On the fibre over ξ: F = f(X) + g(Y) + h with h ⊥ S exists and is unique because the Friedrichs cosine of
L²₀(X), L²₀(Y) is ρ < 1 (closed direct sum); E[h|X] = E[h|Y] = 0; K_yF = Tf + g =: u; ℓ_z(K_yF)_ξ² = ‖u‖² − ‖T*u‖² (as ⟨u(Y), w(X)⟩ =
⟨T*u, w⟩); the second piece is ‖g − T*g‖ ≤ ℓ_z(F)_ξ since Q_zF = (g − T*g) + h with h orthogonal; the first is ⟨f,(A − A²)f⟩^{1/2}, A = T*T,
and (s − ρ²)(1 − s) ≤ 0 on [0, ρ²] gives A − A² ≤ ρ²(I − A) while ℓ_y(F)_ξ² ≥ ⟨f,(I − A)f⟩; ρ = 1 handled; Minkowski in L²(dξ). Correct.

Lemma 7.2: on Halmos' generic part (I−Q)P(x,y) = (S²x, −CSx), of norm ‖Sx‖ ≤ ‖Sx − Cy‖ + ‖Cy‖ = ‖(I−Q)F‖ + ‖Cy‖, with
‖C‖ = ‖PQ − P_{M∩N}‖ = c; the four trivial summands hold with coefficient 0; Minkowski over the orthogonal summands. Correct. Lemma 2.1 is
its case P = K_y, Q = K_z (Ran K_y ∩ Ran K_z = L²(σ(ξ)) by positivity; c = ess sup_ξ ρ_ξ, the norm of a decomposable operator).

Proposition 2.2: I + hL = (1 − |Λ|h)I + hΣK_y has non-negative coefficients for h ≤ 1/|Λ|; subadditivity, Lemma 2.1 and ℓ_z(K_zG) = 0
give ℓ((I + hL)G) ≤ ((1 − h)I + hR)ℓ(G); the matrix is entrywise non-negative, so the bound iterates; (I + tL/n)ⁿ → e^{tL} in norm and ℓ is
continuous. Correct. Nothing uses that K_y is a conditional expectation: by Lemma 7.2, Proposition 2.2 and Theorem 2.3 hold for any finite
family of orthogonal projections with R the matrix of pairwise Friedrichs cosines (the draft's "Consequences"; projgap.c above).

Theorem 2.3: E(F,G) = ΣQ_y-inner products; ker L = constants; Cov(F,G) = ∫₀^∞E(P_tF,G)dt (⟨P_TF,G⟩ → λ(F)λ(G) by the spectral theorem);
|E(P_tF,G)| ≤ Σ_y(e^{−t(I−R)}ℓ(F))_yℓ_y(G); ∫₀^∞e^{−t(I−R)}dt = (I − R)⁻¹ ≥ 0 for ρ(R) < 1. Tensorization: d‖P_tF − λF‖²/dt = −2‖ℓ(P_tF)‖²,
componentwise domination by e^{−t(I−R)}ℓ(F) ≥ 0, ‖e^{−t(I−R)}‖ = e^{−t(1−ρ(R))} (R symmetric non-negative). Decay: Rⁿ(x,y)e^{κ|x−y|} ≤ R̃ⁿ(x,y),
row sums of R̃ⁿ ≤ αⁿ, ρ(R) ≤ α. All correct.

A sharpness fact the draft does not state (checked by hand): Theorem 2.3 is EXACT on linear observables of a Gaussian field with
non-negative partial correlations. With precision J and B = I − D_J^{−1/2}JD_J^{−1/2} ≥ 0: R = B (Gebelein–Lancaster), ℓ_x(φ_x) = J_xx^{−1/2},
ℓ_z(φ_x) = 0 for z ≠ x, and ℓ_x(φ_x)(I − R)⁻¹(x,y)ℓ_y(φ_y) = J⁻¹(x,y) = Cov(φ_x, φ_y). For the massive free field D = (I − R)⁻¹ ∝ J⁻¹ decays at the
true mass (cosh μ = 1 + m²/2 on an axis); only the weighted-row-sum corollary of §4 (rate log(1 + m²/2d) ≈ m²/2d) loses the square root.

What is classical (sources read this session):
- Two blocks: the L² rate of the two-component Gibbs sampler is the squared maximal correlation (Liu, Wong, Kong, Biometrika 81 (1994);
  restated in Amit, Ann. Statist. 24 (1996)). Amit, J. Multivariate Anal. 38 (1991) 82–99 computes stochastic-relaxation rates in L² as
  products of projections through angles between subspaces.
- The tensorization half of Theorem 2.3, Var(F) ≤ (1 − ρ(R))⁻¹Σ_yE[Var(F|v_{y^c})], and its quadratic form Var(F) ≤ ℓ(F)ᵀ(I − R)⁻¹ℓ(F), is
  Kassabov's subspace-arrangement theorem (Subspace arrangements and property T, Groups Geom. Dyn. 5 (2011) 445–477, arXiv:0911.1983,
  Theorem 5.1: d₀(v)² ≤ d_vᵀA⁻¹d_v, A with 1 on the diagonal and −ε_ij ≤ −cos∠(V_i,V_j) off it; Theorem 1.2), after Dymara–Januszkiewicz and
  Ershov–Jaikin-Zapirain, applied to V_y = Ran K_y, whose pairwise Friedrichs cosine is exactly the draft's R(y,z). (Checked: his
  Definition 3.2 is the Friedrichs angle, the supremum over unit vectors perpendicular to V_1 ∩ V_2 — "factoring it out" — which is the
  convention the identification needs, since here every pairwise intersection is all of L²(σ(ξ)).) For Glauber dynamics a
  weaker form is Peyre, Tensorizing maximal correlations, arXiv:1004.1602 (2010), Theorem 4.2.5 / Corollary 4.2.12: gap ≥ (1 − ‖ε‖)₊², with
  ε_ij bounding the Hilbertian correlation "seen from the natural σ-metalgebra" — under the conditional law given ANY subset of the other
  variables at any values (his Def. 3.1.13, Remark 3.1.14). The draft conditions on the full environment only and gets 1 − ρ(R) ≥ (1 − ρ(R))².
- TV-currency analogues: Dobrushin's comparison theorem; Föllmer (J. Funct. Anal. 46, 1982) and Künsch (CMP 84, 1982) for the covariance
  estimate; for the gap with an operator norm of Dobrushin's matrix, Hayes (2006) and Wu (Ann. Probab. 34, 2006), as summarized in secondary
  notes (not read in the original here).
- Dobrushin–Shlosman in L²: the finite-volume block criteria (complete analyticity; Stroock–Zegarlinski 1992; Martinelli–Olivieri 1994) are
  block conditions with a supremum over boundary data. By Lemma 7.2 the draft's theorem applies verbatim to block heat baths (K_B
  integrating a block of coarse sites), so it supplies the L² single-block Dobrushin-type member of that family, not a finite-size criterion.

The draft's own (not found in Kassabov 2011, Peyre 2010, or the Amit and Liu–Wong–Kong abstracts): the BILINEAR bound
|Cov(F,G)| ≤ ℓ(F)ᵀ(I − R)⁻¹ℓ(G) with the exponential decay of (I − R)⁻¹ from weighted row sums — the L² Föllmer estimate. It does not follow
from Kassabov's quadratic bound (polarization loses the decay), and it is the piece Theorem 3.1 needs. Technique W = 0 (Föllmer's semigroup
route with the two-subspace inequality in place of the oscillation inequality); the earning is the assembly and the identification
R = Friedrichs cosine = conditional maximal correlation. The draft's "Label" (priority UNCHECKED) now resolves: tensorization = Kassabov 2011
Thm 5.1; bilinear decay form = this draft.

VERDICT 2: HOLDS (Lemma 2.1, Lemma 7.2, Proposition 2.2, Theorem 2.3, and the general-projection "Consequences").

---

## Item 3 — Proposition 2.5: HOLDS, and it is sharp

At fixed ξ, ρ_ξ² = ‖TT*‖_{L²₀}, and TT* = E[E[·|v_y]|v_z] is a reversible Markov operator on functions of v_z, compact (bounded kernel
density), its eigenfunctions of nonzero eigenvalue bounded; |λ| ≤ δ(TT*) by the oscillation argument and δ(TT*) ≤ C_ξ(y|z)C_ξ(z|y) by
submultiplicativity. The conditional law of v_y given (v_z, ξ) is the single-site conditional law, so C_ξ(y|z) ≤ C(y,z), and
R(y,z) ≤ √(C(y,z)C(z,y)) ≤ ½(C(y,z) + C(z,y)). On a torus with the construction's coarse translations C(y,z) = c(z − y), row and column
sums of C̃ coincide, and Hypothesis I ⇒ I-L² with the same κ, α. Classical in its parts (Dobrushin–Seneta; submultiplicativity), W = 0.

Sharpness (proved here, not in the draft): for BINARY sites it is an equality. With the 2×2 conditional table p_ab and
Δ = p₁₁p₀₀ − p₁₀p₀₁: ρ = |Δ|/√(p_{1·}p_{0·}p_{·1}p_{·0}), C(y|z) = |p₁₁/p_{·1} − p₁₀/p_{·0}| = |Δ|/(p_{·1}p_{·0}), C(z|y) = |Δ|/(p_{1·}p_{0·}),
so ρ² = C(y|z)C(z|y) (l2check: |ρ²/(CC) − 1| ≤ 6·10⁻⁸, the rounding of a small eigenvalue). Three or more states reached 0.999999. The
product is the stronger of the available bounds: η_χ² ≤ η_KL ≤ η_TV gives only ρ² ≤ min(C(y|z), C(z|y)).

The leading-mode constants are right: p = 1 + εχ_½(U)χ_½(V) gives ρ = ε and C = ½ε·4·E_Haar|χ_½| = ½ε·4·8/(3π) = 16ε/(3π);
p = 1 + 2ε cos φ cos ψ gives ρ = ε and C = 4ε/π.

VERDICT 3: HOLDS.

---

## Item 4 — Theorem 3.1 (Theorem 8.5-L²): HOLDS as a conditional theorem; it contains Theorem 8.5; the averaged fibre clause suffices

The proof, line by line.
1. μ_j(fg) − μ_j(f)μ_j(g) = Cov_{λ_j}(F,G) + E_{λ_j}[ν_j(fg|v) − F(v)G(v)] — the law of total covariance. Correct.
2. The second term is bounded by II-L²(a) verbatim. (THE GROUND's own proof also uses only the λ_j-mean here — its Hypothesis II(a)'s
   supremum was never needed for this term.)
3. I-L² gives ρ(R_j) ≤ α < 1; Theorem 2.3 gives |Cov_{λ_j}(F,G)| ≤ Σℓ_x(F)D(x,y)ℓ_y(G) with D(x,y) ≤ e^{−κ|x−y|}/(1 − α); II-L²(b) gives
   ℓ_x(F) ≤ K′N(f)‖f‖ρ′^{r_x}; the product is ≤ K′²N(f)N(g)‖f‖‖g‖ρ^{e(x,y)}/(1 − α), ρ = max(e^{−κ}, ρ′). Correct.
4. e(x,y) ≥ d by the triangle inequality on the coarse torus; #{e ≤ n} ≤ N(f)N(g)(2n+1)⁸ (max-norm balls in four dimensions); the sum is
   ≤ N(f)N(g)Σ_{n≥d}(2n+1)⁸ρⁿ ≤ K₁ρ₁^d. Correct; K depends on (ρ, ρ₁, α, K′, N(f), N(g), ‖f‖, ‖g‖) only.
5. The time direction: f with links in [0, w] sits in blocks of time index 0..⌊w/a_c⌋; θf̄ in blocks of index ≤ 0 (a spatial link at
   x₀ = 0 is in block 0 and is fixed by θ); τ_tf in blocks of index ≥ ⌊t/a_c⌋; so d ≥ ⌊t/a_c⌋ ≥ t/a_c − 1. Reflection and translation
   INVARIANCE of μ_j give μ_j(θf̄)μ_j(τ_tf) = |μ_j(f)|². Then S_j(θf̄·τ_tf) − |S_j(f)|² ≤ (K/ρ₁)e^{−m₁t} with a constant uniform in j and in the
   lattice. Correct.
6. Theorem 7.4 with r_j = 0 on D, for every ρ₁ ∈ (ρ, 1): no spectrum in (0, log(1/ρ)/a_c) = (0, m). Correct.

Reflection positivity. Theorem 3.1 adds no positivity requirement: the blocked measure need not be reflection positive; positivity enters
only through Theorem 7.4 (the lattice Wilson measures on tori of even side, reflected through the site hyperplane x₀ = n·a_c,
Osterwalder–Seiler), and step 5 uses only reflection INVARIANCE. I also checked the one place where a dyadic time set could have cost
Theorem 7.4 its semigroup: the limit's transfer operators T_t, t ∈ D, are positive self-adjoint contractions with T_{t+s} = T_tT_s, so
T_t = T_1^t on D and the functional calculus extends them to e^{−tH}, t ≥ 0. No gap there.

The transfer to the continuum is Theorem 7.4 as a black box, under its hypothesis that the construction's Schwinger functions converge
along a subsequence; Theorem 3.1 supplies its clustering hypothesis with r_j = 0 and nothing else. The conclusion lives on "the sector
generated by the observables bounded uniformly in j" with N(f) bounded uniformly — the same sector as Theorem 8.5. One fact about that
sector, inherited from THE GROUND and not created by the draft: strictly local bounded observables of fixed physical size built from bare
holonomies (smeared plaquette traces, bare Wilson loops) have TRIVIAL continuum limits (the linear self-energy divergence of bare Wilson
lines drives ⟨χ_j(W)⟩ → 0 at fixed physical size; a smeared plaquette trace tends to a constant), while the bounded observables with
nontrivial limits (gradient-flowed loops) are only quasi-local, N(f) = ∞. The proof of Theorem 3.1 extends to quasi-local f if II-L²(b) is
stated with r the distance to a core of f (step 4 only needs the decay of ℓ_x(F)); as written, the theorem does not by itself supply a
non-trivial sector (Theorem 7.4 says as much: "If S is non-trivial").

The uniformity in the cutoff is assumed, exactly as in Theorem 8.5: I-L² and II-L² at every rung j ≥ j₀ with constants uniform in j and
the volume. Nothing in the proof requires more.

The role of Proposition 8.4. In THE GROUND's proof, the first inequality of (8.6) bounds b_y after the tilt by G′ = G + 2‖g‖; Theorem 3.1
replaces the tilt and Dobrushin's comparison theorem by Theorem 2.3, so Proposition 8.4 plays NO role in its proof. Its second role — the
fourth link, (8.7): Hypothesis I at one rung j₁ propagates to later rungs whose conditional laws are tilts of small oscillation and small
weighted mixed difference — has no counterpart in the draft. It has one, and here it is.

**Lemma R (the L² form of (8.7); proved in this review).** Let π be a law of (X, Y) on compact spaces with continuous positive density, δ a
bounded function, π′ = e^δπ/Z. Put o_X = sup_y osc_x δ(x, y), o_Y = sup_x osc_y δ(x, y), Δ = sup_{y,y′} osc_x[δ(x, y) − δ(x, y′)]. Then

 ρ(π′) ≤ e^{(o_X + o_Y)/2} ρ(π) + 1 − e^{−2Δ}.

*Proof.* Fix (x₀, y₀) and split δ = δ₁(x) + δ₂(y) + δ₁₂(x, y) with δ₁ = δ(·, y₀), δ₂ = δ(x₀, ·) − δ(x₀, y₀); then |δ₁₂| ≤ Δ, osc δ₁ ≤ o_X,
osc δ₂ ≤ o_Y. (i) The product tilt π₁ ∝ a(x)b(y)π, a = e^{δ₁}, b = e^{δ₂}: the normalised kernel M = π/√(π_Xπ_Y) becomes M₁ = D₁MD₂ with
D₁ = √(a/β), β(x) = E_π[b(Y)|X = x], and D₂ = √(b/α), α(y) = E_π[a(X)|Y = y] (direct computation of π₁'s marginals). Writing
M = √π_X ⊗ √π_Y + R₀ with ‖R₀‖ = ρ(π), M₁ is a rank-one operator plus D₁R₀D₂, so its second singular value — which is ρ(π₁) — is at most
‖D₁‖‖D₂‖ρ(π) ≤ √((a_max/b_min)(b_max/a_min)) ρ(π) = e^{(o_X+o_Y)/2}ρ(π). (ii) The mixed tilt π′ ∝ e^{δ₁₂}π₁ has density ratio within e^{2Δ};
1 − ρ is the spectral gap of the two-site heat bath (Dirichlet form E[Var(F|X)] + E[Var(F|Y)], two projections of Friedrichs cosine ρ), and
by Holley–Stroock the gap moves by at most the factor e^{−2Δ}: 1 − ρ(π′) ≥ e^{−2Δ}(1 − ρ(π₁)). Combine. ∎

Tested on 900,000 random laws, 2–5 states per variable (tilt2.c, record tilt2.txt): worst ratio 0.99988, about 120 cases per 300,000
within 1 % of the bound, none above it. The product-tilt constant ½ is the right one: the worst log(ρ′/ρ)/(o_X + o_Y) over 400,000 product
tilts was 0.4982 (tiltcheck.c, record tiltcheck.txt). The split is necessary: Holley–Stroock alone gives ρ(π′) ≤ 1 − e^{−o}(1 − ρ) with o the
JOINT oscillation (held on the same sample, worst 0.999999), whose additive term carries the single-site oscillation and so is not summable
over z. With Lemma R, if λ_j's conditional laws are tilts e^{δ_j} of λ_{j₁}'s with sup_y o_y(δ_j) → 0 and Σ_z(1 − e^{−2Δ_yz(δ_j)})e^{κ|y−z|} → 0,
then I-L² at j₁ with α₁ gives I-L² at later rungs with any α ∈ (α₁, 1): THE GROUND's fourth-link sentence after Theorem 8.5 transfers to
the L² currency with the same inputs.

Does the averaged fibre clause really suffice? Yes, and the reason is exact: Theorem 2.3 consumes the fibre mean F only through the
L²(λ_j) local fluctuations ℓ_x(F), and the fibre covariance enters only through its λ_j-mean, so an adversarial coarse configuration enters
weighted by its probability. The price is the currency of the coarse matrix: Dobrushin's comparison theorem consumes sup-oscillations δ_i(F),
so the averaging of Hypothesis II is bought by replacing Hypothesis I's C by R. The supremum that remains is the ess-sup over the COARSE
environment ξ inside R_j(y, y′), as the draft's §5.1 says.

The strengthening. On the construction's tori (coarse translation invariance), Hypothesis I ⇒ I-L² (Proposition 2.5) and Hypothesis II ⇒
II-L² (|mean| ≤ sup; ℓ_x ≤ δ_x/2), with the same conclusion and rate: Theorem 3.1 contains Theorem 8.5 (and drops its factor 3 from G′).

A minor defect: §3 item 3 cites "Table 3 ... a known answer for Hypothesis I-L² at the fine scale (§6, K-T3)"; §6 defines no K-T3 (the
string occurs once in the file). The claim itself is Proposition 2.5 applied to Theorem 8.7's matrix, which is translation invariant;
no run supports it.

VERDICT 4: HOLDS — CONDITIONAL on (a) Hypotheses I-L² and II-L² at every rung j ≥ j₀ with uniform constants (unproved for SU(2): I-L² is
the crossing itself; II-L² is stated in no published form), and (b) Theorem 7.4's construction hypothesis (a convergent subsequence of
Schwinger functions). Given (a) and (b) the passage to the gap of every limit point is complete; the averaged fibre clause suffices.

**A structural fact about the block map, which bears on whether (a) is a reduction.** THE GROUND names as its example the holonomy block
map: one SU(2) element per coarse link, the holonomy along a FIXED fine path of physical length a_c. A bare Wilson line of physical length L
carries the linear self-energy divergence, exp(−c·g²(a)·L/a) in its gauge-invariant completions, and with asymptotic freedom
g²(a)·L/a → ∞. So as j → ∞ every gauge-invariant function of these coarse variables (coarse Wilson loops of side a_c) has character
expectations → 0 and the coarse variables become asymptotically Haar-uniform; their mutual correlations carry a vanishing AMPLITUDE (the
wrapped UV noise of each path is independent), with the long-distance profile of the theory itself. Two consequences. First, the
α-smallness of I-L² (and of Hypothesis I) becomes free in the continuum limit, but its κ does not: with a power-law profile (U(1)'s
Coulomb phase) Σ_z R(y,z)e^{κ|y−z|} still diverges in infinite volume for every κ > 0 however small the amplitude, so I-L² still refuses
U(1) at every rung, as Theorem 4.1 demands; with an exponential profile it holds exactly for κ below the coarse decay rate. So I-L² is not
trivial but TAUTOLOGICAL here: it is the gap restricted to coarse observables, at rate κ/a_c. Second, conditioning on an asymptotically
independent variable leaves the fibre measure asymptotically the full Wilson measure, so II-L²(a) at large j is the clustering of μ_j
itself — the conclusion. With this block map neither Theorem 8.5 nor Theorem 3.1 moves the infrared problem out of the hypotheses: I
assumes it on the coarse observables, II on the rest, and both carry the group-dependence. The reduction has the content
§8.1 assigns it (the fibre massive at the block scale for EVERY theory, the coarse bound discriminating SU(2) from U(1)) only for averaged
block variables with non-trivial continuum limits — Bałaban's averaged block variables, or gradient-flow-smoothed links. Strength: the
mechanism is the standard self-energy divergence of bare Wilson lines; the convergence of λ_j to the Haar product in the norm R, and the
asymptotics of ν_j(·|v), are not proved here. What would settle it on the record's own objects: the holonomy-blocked one-plaquette
coefficient's fall with blocking steps (2.2 → 1.888 → 1.553 → 1.161 → 0.662 → 0.109 at the ordered datum) read for U(1) in its Coulomb
phase at the same steps — a fall there is self-energy, not running.

---

## Item 5 — Theorem 4.1 (the refusal of U(1)): HOLDS as stated; its U(1) application is CONDITIONAL; one attribution is reversed

The theorem is Theorem 2.3's contrapositive: ℓ_x(F) ≤ osc_x(F)/2 ≤ ‖F‖_∞ on X and 0 off it, D ≤ e^{−κ|·|}/(1 − α), so |Cov_λ(F, G)| ≤
|X||Y|‖F‖‖G‖e^{−κ dist}/(1 − α) uniformly in the volume; if the torus states along the sequence converge to a state in which two coarse
observables have a connected correlation decaying slower than every exponential, the bound fails at the given κ on some torus. Correct. It
is a property of every sufficient condition for uniform exponential clustering, as the draft says; its content is the contraposition.

The free field: R = A/(2d) is right (the pair's conditional law is Gaussian with precision [[2d, −1], [−1, 2d]]; Gebelein–Lancaster gives the
maximal correlation as the absolute partial correlation 1/(2d), independent of ξ), every row sum is exactly 1, ρ(R) = 1 on ℤ^d. For the
massive field R = A/(2d + m²) and the weighted-row-sum rate is log(1 + m²/2d); by item 2's exactness fact, D = (I − R)⁻¹ = (2d + m²)J⁻¹, so
Theorem 2.3 itself returns the exact covariance and the true mass — the margin is a property of the field, not a looseness of the theorem.

The U(1) application needs, for the action and block map at hand, a theorem that two functions of coarse plaquette holonomies have a
non-exponential connected correlation in the torus-limit state. The draft attributes: Fröhlich–Spencer (1982) "for the Villain action",
Guth (1980) "the perimeter law for the Wilson action". Guth's proof (Phys. Rev. D 21 (1980) 2291–2307) is for an action of the VILLAIN form;
Fröhlich and Spencer (Commun. Math. Phys. 83 (1982) 411–454, preprint IHES P/81/40) state that their methods are not geared to the Villain
action and generalize Guth's result. So the attributions are reversed in the action. At β = 1.2 with Wilson's action the masslessness is
the measured phase diagram (numerics), as the draft says. VERDICT 5: HOLDS (Theorem 4.1 and the free-field computation); the U(1)
instance is CONDITIONAL on extracting the non-exponential coarse correlation from Fröhlich–Spencer for the given action in the torus-limit
state (rigorous in their range), numerical at β = 1.2.

---

## Item 6 — Lemmas 5.1 and 7.1 (the mixture inequalities): HOLD under ξ ⊂ σ(ω)

Lemma 5.1: with ξ a function of ω, λ(dA, dB | ξ) = ∫ν₀(dω|ξ)p_ω(dA, dB) (conditioning on ω inside the ξ-fibre); the law of total covariance;
the first term ≤ sup ρ_ω·(∫Var_ω f)^{1/2}(∫Var_ω g)^{1/2} ≤ sup ρ_ω; the second ≤ (Var m_f Var m_g)^{1/2} ≤ ρ_ξ(A;ω)ρ_ξ(B;ω) because
Var E[f(A)|ω] ≤ ρ_ξ(A;ω)²Var f. Correct. Lemma 7.1: Var_ω(f) ≤ ∫(f − Ef)²p_ω ≤ M_A Var(f) with M_A = ess sup p_ω/p; the rest as before.
Correct. Both are W = 0 (total covariance, Cauchy–Schwarz, a density ratio); l2check reads worst ratios 0.9960 and 0.9861 over 1,500
systems. Two notes: M_A ≥ 1 always (p = ∫ν₀p_ω), so √(M_AM_B) is a multiplicative price on the direct part that must be O(1) for the bound
to be used — "needs no smallness" is right only in that sense; and the hypothesis ξ ⊂ σ(ω) fails for the record's two-face objects with
LOOP variables (the draft says so: coarse loops sharing a coarse link with A depend on object links). VERDICT 6: HOLDS.

---

## Beyond the seven items

- §6's readings are maximal correlations of the LMAX-truncated reconstruction p_L = p_A^L p_B^L + c_L (l2dob.c lines 84–100: the
  marginals AND the cross-covariance truncated at spin LMAX/2, the truncated marginals in the weights 1/p_A). That number is neither an
  upper nor a lower bound of the object's ρ_ω (the low-spin projection of the cross-covariance would bound ρ_ω from below only with the
  TRUE marginals as weights). The draft calls them readings, which is their strength; the "0.63 / 0.77 < 1" at W3L2 is a reading of a
  truncated, planar, pinned, one-datum direct part, as §6.6 says.
- The most important missing estimate is Hypothesis I-L² itself at one exit scale, uniformly in the cutoff — and, by the structural fact
  under item 4, for a block map whose coarse variables have non-trivial continuum limits. Its exact remaining supremum is the ess-sup over
  the coarse environment in R_j; Lemma R above supplies the fourth link in the same currency once one rung is certified.

## Summary of verdicts

| item | verdict | decisive line |
|---|---|---|
| 1 Prop 1.1 | HOLDS (classical) | P ≅ T/λ₀ on ψ₀^⊥; ∬p_k² = λ₀^{−2k}Tr T^{2k}; the norm ≤ δ(Pᵏ), the χ² average is not ((1 + β^{2k})^N − 1 > 1) |
| 2 L2.1/7.2, P2.2, T2.3 | HOLDS | two-subspace inequality; Metzler comparison; Cov = ∫E(P_tF,G)dt. Tensorization = Kassabov 2011 Thm 5.1; bilinear decay form is the draft's; exact on Gaussian linear observables |
| 3 Prop 2.5 | HOLDS, sharp | ρ² = ‖TT*‖ ≤ δ(TT*) ≤ C(y\|z)C(z\|y), equality for binary sites |
| 4 Thm 3.1 | HOLDS, CONDITIONAL on I-L², II-L² uniformly and Theorem 7.4's convergence | the fibre enters only via ℓ_x(F) and its λ-mean; Prop 8.4 has no role; its fourth-link role in L² is Lemma R (proved here) |
| 5 Thm 4.1 | HOLDS; U(1) instance CONDITIONAL | contrapositive of Theorem 2.3; Guth = Villain action, Fröhlich–Spencer = not Villain-specific (reversed in the draft) |
| 6 Lemmas 5.1/7.1 | HOLDS under ξ ⊂ σ(ω) | total covariance + Cauchy–Schwarz + density ratio |
| 7 §6.0 engine finding | HOLDS (confirmed) | w2_strip_n.c:64 okey never consults LB; :70 face plaquettes only; :99–107 the (1,3) corner plaquettes at (0,j,0), j = 0..n, entered twice |

