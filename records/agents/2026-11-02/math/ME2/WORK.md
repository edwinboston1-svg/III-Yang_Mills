# ME2 — THE OS AXIOM (E2): EUCLIDEAN INVARIANCE OF THE CONTINUUM LIMIT

Proof agent ME2, 2026-11-02 (08:5x EST, read from `date`). Work directory `.../scratchpad/math/ME2/`. Appended as the
work proceeds; nothing above a line is edited after it is written except by a dated correction below it. Labels:
PROVED (full proof here), PROVED GIVEN [named input], CONDITIONAL (on what), OPEN, COMPUTED (exact arithmetic, record
named), READ (primary source read today), CITED (literature, read at abstract/statement level today).

NAMING NOTE. The crossing campaign §21 (III-Yang_Mills `OPEN/the-crossing-campaign.md`) and M3b call "(E1)" the
uniqueness of the limit (the two-cutoff comparison) and "(E2)" Euclidean invariance. THE GROUND §3.1 numbers the OS
axioms differently ((E1) Euclidean invariance, (E2) reflection positivity). This file uses the CAMPAIGN's labels:
(E2) = invariance of the limit's Schwinger functions under the Euclidean group E(4) = ℝ⁴ ⋊ O(4).

## 0. Sources read before deriving

- `math/MATH_BRIEF.md`; `cross/ANSWER.md`.
- THE GROUND (`cross/ground_docx.txt`): §2.1 (Theorem 2.1), §3.1 (OS axioms, Theorem 3.1), §6.2–6.3 (the Alpöge–Sussman
  4D draft's clauses, clause (vi): O(4) under a flux hypothesis on the lattice rotation current; "not claimed:
  invariance under all rotations without the hypothesis of clause (vi)"), §7.2–7.4 (Theorems 7.1, 7.4, Corollaries
  7.2, 7.5, 7.6), §8.3 (the block map, (8.5), Proposition 8.4 the tilt lemmas, Hypotheses I and II, Theorem 8.5 with
  its proof). READ today.
- III-Yang_Mills `OPEN/the-crossing-campaign.md` §21 (the One Flow theorem; the input table: "(E2) Euclidean
  invariance OPEN, an infrared identity").
- `math/M3b/WORK.md` §§0–1, 10–15 (E1-a, E1-b, the obstruction to (E1) "the two-cutoff comparison of the complete
  model"; §11 (E2): the marginal symmetry restoration (W(B₄)-invariant quadratic forms on Λ²ℝ⁴: one, Σ F²), why it does
  not give (E2), "orientation universality ... an infrared statement"; 15.1 Bałaban's block is the centred cube of odd
  side L; 15.4 the block-factor collision L odd vs L = 2).
- `math/M3d/WORK.md` §§0–1, 3, 5–8 (Theorem PI-5: the history decay L^{−β′(k−i)}; its falsifier "a marginal remnant of
  an earlier step that survives its renormalization", NOT MET because the only W(B₄)-invariant marginal structure is
  Σ F²; (R3) the two-cutoff comparison of the complete model OPEN, next object "R_D Lipschitz in its input density";
  (R4) (E2)).

## 1. THE PLAN (deep-think synthesis, written before the derivations below)

The trunk's reduction has three layers. (a) A group lemma: closed H with B₄ ⊆ H ⊆ O(4) is finite or O(4). (b) A
symmetry transfer: invariance under ONE rotation R outside the finite overgroups of B₄ gives O(4). (c)–(d) An
analytic comparison: the theory on aℤ⁴ and on R(aℤ⁴) have the same limit.

What the lenses changed (recorded so the reader can check the reasoning, not only the result):

1. ADVERSARY on (c). The skew first step (blocking R(aℤ⁴) onto the common coarse lattice Laℤ⁴) has symmetry group
   G′ = B₄ ∩ RB₄R⁻¹ only. M3d's Theorem PI-5 and M3b §11.1 control the marginal sector BECAUSE W(B₄) admits one
   marginal direction (Σ F²). Under G′ more marginal directions are symmetry-allowed: metric-type ((1,1), 9 components)
   and Weyl-type ((2,0)⊕(0,2), 10 components). STAKE (S-N): for EVERY R outside the finite overgroups of B₄, G′ admits
   a nonzero Weyl-type invariant — the extra marginal sector cannot be removed by choosing R. (To be proved, §4.)
2. SECOND-ORDER on (c). The skew step's one-loop finite part shifts the isotropic coupling by δx = O(1) in x = 1/g² —
   a finite change of scale (a Λ-parameter ratio), which does NOT vanish as a → 0. Showing δx_total = 0 directly is a
   non-perturbative matching problem. RESOLUTION (stake S-C): it is not needed. If the rotated limit equals the
   original limit up to a dilation D_λ, then conjugating B₄ by the similarity D_λR⁻¹ removes λ (dilations are central),
   so the closed stabilizer contains B₄ and R⁻¹B₄R; when R⁻¹B₄R ⊄ (the largest finite overgroup), the lemma gives O(4),
   and a finite nonzero mass gap then forces λ = 1.
3. FIRST-PRINCIPLES on (d). Uniqueness of the Gibbs state at the UV scale ε is not available (ε is weak coupling, the
   crossover is above it). The comparison must be made at the exit scale a_c, where Hypothesis I is Dobrushin's
   condition; Dobrushin's comparison theorem in its AVERAGED form (conditional laws close on average under the rotated
   coarse measure) needs Hypothesis I for the ORIGINAL theory only. The crossover steps ε → a_c must be Lipschitz in
   their input — a strengthening of (F2) on [β_s, β_x].
4. CROSS-FIELD. The Weyl-type anisotropy is the "k_F" Lorentz-violating coefficient of the Standard-Model Extension; its
   one-loop running in pure Yang–Mills is known (Colladay–McDonald 2007): it DECREASES toward the infrared,
   k_F ∝ g^{−14/11}. So asymptotic freedom kills rotation breaking twice: the created anisotropy is O(g₀²) → 0, and the
   flow does not amplify it. This is "Lorentz invariance as a low-energy phenomenon" (Nielsen–Ninomiya; Chadha–Nielsen)
   met inside a rigorous RG comparison.
5. LITERATURE CHECK changed the map: Alpöge–Sussman's RPM1 (2026, AI-written, unverified) claims O(d) invariance from
   translation invariance + reflection positivity across the coordinate AND DIAGONAL hyperplanes + a Glimm–Jaffe growth
   bound. Stake (S-RP): Wilson's action is reflection positive across the diagonal hyperplanes {x_j = ±x_k} (to be proved,
   §9). If RPM1 is correct and its growth hypothesis could be met, (E2) would need no infrared input at all.

Computations staked before running (§3): S-1 Λ²ℝ⁴ absolutely irreducible under B₄ (commutant dimension 1);
S-2 the finite closed overgroups of B₄ are exactly three, of orders 384, 1152, 2304; S-3 q = (1+2i+2j+4k)/5 gives
5R, 5R⁻¹ integral, R ∉ G₂₃₀₄, R⁻¹B₄R ⊄ G₂₃₀₄; S-4 [ℤ⁴ : ℤ⁴ ∩ Rℤ⁴] — UNGUESSED; S-5 G′ = B₄ ∩ RB₄R⁻¹ for R = L_q —
UNGUESSED order, and dim of G′-invariant symmetric forms on Λ² ≥ 2 with a nonzero Weyl component (stake S-N).

## 2. STAKES FOR THE FIRST INSTRUMENT (`bin/me2_groups.py`, written before it runs; 09:2x EST)

- S-1: commutant of Ad(B₄) on Λ²ℝ⁴ has dimension 1; B₄-invariant symmetric forms on Λ²: dimension 1 (isotropic only).
- S-2: exactly three subgroups K with B₄ ⊆ K ⊆ G₂₃₀₄, orders 384, 1152, 2304; G₂₃₀₄/B₄ has 5 non-trivial left cosets.
- S-3: R = L_q orthogonal, trace 4/5; R ∉ G₂₃₀₄; R⁻¹bR ∉ G₂₃₀₄ for most b (count UNGUESSED, > 0).
- S-4: rank(Mᵀ mod 5) = 2 (Mᵀ M = 25 I forces the column space mod 5 to be totally isotropic, so rank ≤ 2, and M ≢ 0
  mod 5), hence [ℤ⁴ : ℤ⁴ ∩ Rℤ⁴] = 25; the centred cube [−5/2, 5/2)⁴ holds 625 points of R(ℤ⁴).
- S-5: G′ for L_q: order UNGUESSED (contains ±1); a nonzero Weyl-type invariant exists (stake S-N). For the planar
  rotation by arctan(4/3) in the (0,1)-plane: |G′| = 32 (C₄ in the plane × the dihedral group of the square in the
  complementary plane), with a metric-type invariant diag(1,1,−1,−1) among the invariants.

### 2.1 RESULTS of `bin/me2_groups.py` (record `rec/me2_groups_run.2026-11-02a.txt`, rc = 0; nothing in §2 edited)

- S-1 MET: commutant of Ad(B₄) on Λ²ℝ⁴ has dimension 1; one invariant symmetric form, the isotropic one (also for W(F4)).
- S-2 MET: |B₄| = 384, |W(F4)| = 1152, |G₂₃₀₄| = 2304; G₂₃₀₄/B₄ has 5 non-trivial left cosets; the subgroups K with
  B₄ ⊆ K ⊆ G₂₃₀₄ are exactly three (orders 384, 1152, 2304); double cosets B₄\G₂₃₀₄/B₄ have sizes 384, 768, 1152.
- S-3 MET: 5R = [[1,−2,−2,−4],[2,1,−4,2],[2,4,1,−2],[4,−2,2,1]], 5R⁻¹ = 5Rᵀ; trace R = 4/5; R ∉ G₂₃₀₄; R⁻¹bR ∉ G₂₃₀₄
  for 376 of the 384 elements b of B₄.
- S-4 MET: rank(Mᵀ mod 5) = 2, [ℤ⁴ : ℤ⁴ ∩ Rℤ⁴] = 25 (the two lattices share an index-25 sublattice, finer than the cubic
  5ℤ⁴ of index 625); the centred cube [−5/2, 5/2)⁴ holds exactly 625 points of R(ℤ⁴); one block type.
- S-5: G′ for L_q has order 8 (the right multiplications by Q₈ — L_q commutes with them), all orientation-preserving;
  its invariant symmetric forms on Λ² have dimension 9: isotropic 1, θ (F∧F) 1, metric-type 0, Weyl-type 7.
  Planar rotation by arctan(4/3) in the (0,1)-plane: |G′| = 32 (16 orientation-reversing) — stake MET; invariant forms
  dimension 3: isotropic 1, metric 1, Weyl 1, θ 0 — the metric invariant is the stake's diag(1,1,−1,−1) type.
  Further: L_u, u = (3i+4j)/5 (order 4): |G′| = 32, forms 4 (iso 1, θ 1, Weyl 2); L_{(1+2i+2j)/3} (L = 3): |G′| = 16,
  forms 6 (iso 1, θ 1, Weyl 4); a two-sided x ↦ q x q″: |G′| = 4, forms 12 (iso 1, metric 6, Weyl 5).
  STAKE S-N MET on all five: every skew block admits a Weyl-type invariant.

### 2.2 STAKES FOR THE SECOND INSTRUMENT (`bin/me2_search.py`; written before it runs)

Over ~6,000 rational rotations (left/right multiplications by unit quaternions of norm 9, 25, 169; a sample of
two-sided ones of norm 25 × 25; planar Pythagorean rotations in all six coordinate planes; double rotations):
minimum Weyl rank ≥ 1 (S-N, a theorem to be proved in §4); minimum anisotropic (θ + metric + Weyl) rank = 2, attained by
planar rotations (UNGUESSED whether rank 1 occurs).

### 2.3 RESULTS of `bin/me2_search.py` (record `rec/me2_search_run.2026-11-02a.txt`, rc = 0, 2 min 40 s)

6,827 rational rotations (left/right multiplications by the unit quaternions of norm 9, 25, 169; 3,000 two-sided ones
of norm 25 × 25; planar Pythagorean rotations (3,4,5), (5,12,13), (8,15,17) in all six coordinate planes; double
rotations). Ten distinct marginal sectors occur. STAKE MET: the minimum Weyl rank is 1 (never 0); the minimum
anisotropic rank is 2, attained in two ways: (|G′| = 32, 16 orientation-reversing) with metric 1 + Weyl 1 and θ
excluded (planar rotations and 34 two-sided ones), and (|G′| = 24, none reversing) with θ 1 + Weyl 1 (left
multiplication by (−11−4i−4j−4k)/13, whose G′ is the right Q₈ times the cyclic permutation of (i, j, k)). The generic
two-sided rotation has |G′| = 2 (only ±1) and the full 21-dimensional space of quadratic forms: 1 + 1 + 9 + 10.

## 3. THE LEMMA — CLOSED OVERGROUPS OF THE HYPEROCTAHEDRAL GROUP (PROVED; COMPUTED S-1, S-2)

Notation. B₄ = W(B₄), the 384 signed permutation matrices. In quaternion coordinates (1, i, j, k) every element of SO(4)
is x ↦ l x r⁻¹ for a pair (l, r) of unit quaternions, determined up to (−l, −r). 2T ⊂ 2O ⊂ S³ are the binary tetrahedral
(the 24 Hurwitz units) and binary octahedral (48) groups; Q₈ = {±1, ±i, ±j, ±k}. G₂₃₀₄ := the stabilizer in O(4) of the
48 unit vectors of 2O (the 24 short roots and the 24 normalized long roots of F₄) — in Conway–Smith's notation ±[O×O]·2;
W(F₄) extended by the isometric realization of the F₄ diagram automorphism on the normalized roots ("Aut(F₄)", order
2304). d := diag(−1,1,1,1) ∈ B₄ acts as x ↦ −x̄.

LEMMA 3.1 (Λ²ℝ⁴ is absolutely irreducible under B₄). PROOF. For D = diag(ε₁,…,ε₄), Ad(D)(e_i∧e_j) = ε_iε_j e_i∧e_j. The six
characters χ_ij(D) = ε_iε_j of (ℤ/2)⁴ are pairwise distinct (if i ∉ {k, l}, the D with ε_i = −1 and all other ε = +1
separates χ_ij from χ_kl). The projector P_ij = 2⁻⁴ Σ_D χ_ij(D) Ad(D) maps Λ² onto ℂ·e_i∧e_j and preserves every invariant
subspace V, so V = ⊕_{(ij)∈S} ℂ e_i∧e_j for a set S of pairs. A permutation matrix sends e_i∧e_j to ±e_σ(i)∧e_σ(j), so S
is S₄-invariant; S₄ is transitive on 2-subsets; hence S = ∅ or all six pairs. ∎ (Commutant dimension 1: S-1, record a.)

THEOREM 3.2 (THE LEMMA). A closed subgroup H of O(4) containing B₄ is finite or equal to O(4).
PROOF. A closed subgroup of a Lie group is a Lie group (Cartan); H is compact, so its identity component H⁰ is open and
H/H⁰ is finite. If H is infinite, H⁰ ≠ {1} and 𝔥 = Lie(H⁰) ≠ 0. H⁰ is characteristic in H, so conjugation by b ∈ B₄
preserves H⁰ and Ad(b)𝔥 = 𝔥. Under the O(4)-equivariant isomorphism Λ²ℝ⁴ → so(4), u∧v ↦ uvᵀ − vuᵀ, 𝔥 is a nonzero
Ad(B₄)-invariant subspace of Λ²ℝ⁴; by Lemma 3.1, 𝔥 = so(4). A connected Lie subgroup is determined by its Lie algebra and
SO(4) is connected, so H⁰ = SO(4). Since d ∈ B₄ ⊆ H has determinant −1, H ⊇ SO(4) ∪ d·SO(4) = O(4). ∎
Every step of the trunk's proposed proof checks: closedness is used for the Lie structure, compactness for the finiteness
of H/H⁰, the normality of H⁰ for the Ad-invariance; irreducibility over ℝ already suffices.

THEOREM 3.3 (THE FINITE OVERGROUPS ARE EXACTLY THREE). A finite subgroup F of O(4) containing B₄ is W(B₄) (order 384, the
tesseract), W(F₄) (1152, the 24-cell) or G₂₃₀₄ (2304). In particular every finite overgroup of B₄ lies in G₂₃₀₄.
PROOF. (i) F ⊆ G₂₃₀₄. Let Γ ⊂ S³ × S³ be the preimage of F⁺ = F ∩ SO(4), and Γ_B that of B₄⁺. B₄⁺ contains the left
multiplications by Q₈, the right multiplications by Q₈, and the conjugations x ↦ g x g⁻¹, g ∈ 2O (the 24 rotations of the
cube on the pure quaternions); so both projections of Γ_B are 2O, and both projections of Γ ⊇ Γ_B are finite subgroups of
S³ containing 2O. The finite subgroups of S³ are cyclic, binary dihedral (each with a cyclic subgroup of index ≤ 2, which 2O
lacks: its largest cyclic subgroups have order 8, index 6), 2T, 2O and 2I (|2I| = 120 is not a multiple of 48). So both
projections of Γ equal 2O, Γ ⊆ 2O × 2O, and F⁺ ⊆ ±[O×O] = G₂₃₀₄ ∩ SO(4). Since d ∈ B₄ ⊆ F and d ∈ G₂₃₀₄, F = F⁺ ∪ dF⁺ ⊆
G₂₃₀₄. (ii) The subgroups of G₂₃₀₄ containing B₄ are unions of left cosets of B₄; all 2⁵ unions were tested in exact
arithmetic (record a): exactly three are groups, of orders 384, 1152 (W(F₄)) and 2304. ∎
(By hand: Γ_B = {(l, r) ∈ 2O × 2O : π(l) = π(r)}, π: 2O → 2O/Q₈ ≅ S₃; subgroups of 2O × 2O containing Γ_B correspond to
subgroups of S₃ × S₃ containing the diagonal, which are {(s, t) : st⁻¹ ∈ N} for the normal subgroups N ∈ {1, A₃, S₃};
this gives rotation groups of orders 192, 576, 1152, and conjugation by d swaps (l, r) ↦ (r, l), preserving all three.)

COROLLARY 3.4. A closed H with B₄ ⊆ H ⊆ O(4) equals O(4) as soon as it contains ONE element outside G₂₃₀₄, of finite or
infinite order. A rotation with a rational entry whose reduced denominator has an odd prime factor lies outside G₂₃₀₄ (the
rational entries of elements of G₂₃₀₄ lie in ℤ[1/2]). So infinite order is sufficient, not necessary: left multiplication
by u = (3i + 4j)/5 has order 4 (u² = −1) and already forces O(4).

REMARK 3.5 (what the intermediate groups mean physically). A B₄-invariant limit could a priori be invariant under W(F₄) and no
more. The Coxeter invariant degrees say where the first rotation-breaking structure can sit: W(B₄) has basic invariants of
degrees 2, 4, 6, 8 (first anisotropic invariant Σx_μ⁴ at degree 4 — the dimension-six artefacts of the hypercubic lattice);
W(F₄) has degrees 2, 6, 8, 12 (no degree-4 anisotropy: an F₄-symmetric lattice such as the D₄ lattice starts at degree 6).
The lemma says these finite symmetries are the ONLY alternatives to O(4) for a B₄-invariant limit.

## 4. THE NORMALIZER THEOREM — EVERY SKEW BLOCK ADMITS A WEYL-TYPE MARGINAL TERM (PROVED; COMPUTED §§2.1, 2.3)

The symmetric bilinear forms on Λ²ℝ⁴ are the possible dimension-four terms c^{μνρσ} tr F_μν F_ρσ (21-dimensional). Under
SO(4) = (SU(2)_L × SU(2)_R)/±1 with Λ² = Λ²₊ ⊕ Λ²₋ (Hodge star ±1): Sym²Λ² = (0,0) ⊕ (0,0)′ ⊕ (1,1) ⊕ (2,0) ⊕ (0,2) =
ISOTROPIC (Σ F², 1) ⊕ θ (tr F∧F, 1) ⊕ METRIC-TYPE (h_μν T^μν, h traceless symmetric, 9) ⊕ WEYL-TYPE (10). Metric-type
deformations are linear changes of coordinates; Weyl-type ones (birefringent; the k_F of the Standard-Model Extension, §6)
are not.

THEOREM 4.1. Let R ∈ O(4) ∖ G₂₃₀₄ and G′ := B₄ ∩ RB₄R⁻¹ — the largest symmetry group a block map from the lattice R(aℤ⁴)
onto a sublattice of aℤ⁴ with B₄-covariant blocks can have. Then G′ fixes a nonzero vector of (2,0) ⊕ (0,2). Hence Λ²ℝ⁴ is
reducible under G′, and a Weyl-type dimension-four term is allowed by every symmetry of the block map.
PROOF. Suppose G′ fixes no nonzero Weyl-type vector; we show R ∈ G₂₃₀₄. First let R ∈ SO(4), R ↔ (l₀, r₀), and let Γ′ ⊂
S³ × S³ be the preimage of G′⁺ = G′ ∩ SO(4); its projections lie in 2O (G′ ⊆ B₄ ⊆ G₂₃₀₄). The left factor acts on Λ²₊
through SO(3) and trivially on Λ²₋, and (2,0) ≅ Sym²₀(Λ²₊) is the spin-2 representation.
(a) G′ ⊆ SO(4). No fixed vector in (2,0) means the image of p_L(Γ′) in SO(3) fixes no traceless quadrupole. Every cyclic and
dihedral subgroup of SO(3) fixes the uniaxial quadrupole of its axis, so the image is T, O or I, and inside the octahedral
group it is T or O. A subgroup of S³ mapping onto T is 2T (A₄ does not embed in SU(2), whose only involution is −1), and
onto O is 2O ⊇ 2T. So p_L(Γ′) ⊇ 2T; likewise p_R(Γ′) ⊇ 2T from (0,2).
(b) G′ contains an orientation-reversing g. Then g swaps Λ²₊ and Λ²₋; for w ∈ (2,0) fixed by G′⁺, w + g·w is a nonzero
G′-fixed vector (g² and g⁻¹G′⁺g lie in G′⁺). So G′⁺ fixes nothing in (2,0) and p_L(Γ′) ⊇ 2T as in (a); conjugation by g
carries the left projection onto a conjugate of the right one, so p_R(Γ′) contains a binary tetrahedral subgroup of 2O,
which is 2T (the unique subgroup of order 24 of 2O: an index-2 subgroup contains the commutator subgroup [2O, 2O] = 2T).
(c) R⁻¹G′R ⊆ B₄ gives l₀⁻¹ p_L(Γ′) l₀ ⊆ 2O, so l₀⁻¹(2T)l₀ is an order-24 subgroup of 2O, i.e. 2T, and l₀ ∈ N_{S³}(2T) = 2O.
Likewise r₀ ∈ 2O. Hence R ∈ ±[O×O] ⊆ G₂₃₀₄.
If R is orientation-reversing, R = R′d with R′ ∈ SO(4) and RB₄R⁻¹ = R′B₄R′⁻¹ (d ∈ B₄), so G′_R = G′_{R′}; R′ ∈ G₂₃₀₄ by
the above and R = R′d ∈ G₂₃₀₄. Reducibility: irreducibility would leave only the identity as invariant symmetric form. ∎
The census (§2.3, 6,827 rotations) agrees: Weyl rank ≥ 1 always; the minimum anisotropic sector has dimension 2.

WHAT THEOREM 4.1 MEANS FOR (E2). Corollary 3.4 bites only for R outside G₂₃₀₄, and exactly then the comparison block has a
Weyl-type marginal direction. M3d's Theorem PI-5 and M3f's Theorem U rest on "no marginal structure other than Σ F²" (the
W(B₄) count; M3f's kill-switch (K2)). For the rotated flow that falsifier IS MET at the first (skew) step, for EVERY
admissible R: the obstruction is intrinsic to the reduction and cannot be engineered away by choosing the rotation; it must
be carried (§6). The best choices carry two anisotropic directions: the planar Pythagorean rotation by arctan(4/3) (metric 1 +
Weyl 1; θ excluded because G′ contains reflections), or left multiplication by (−11−4i−4j−4k)/13 (θ 1 + Weyl 1).

## 5. THE REDUCTION (b) — WHAT MUST HOLD, THE ROTATION q, AND THE SIMILARITY TRICK (PROVED)

5.1 THE STABILIZER IS CLOSED (PROVED, under the conditions stated). Let Φ be a family of SCALAR gauge-invariant fields (O(4)
acts on test functions only): the renormalized action density (the corpus's field, on test functions flat at the
coincidence diagonals), or scalar functions of the gradient-flowed field at fixed flow time t > 0. Let 𝒯_n be the test space
(𝒮_≠(ℝ⁴ⁿ) ⊂ 𝒮(ℝ⁴ⁿ), the closed subspace of functions flat at coincidences, or C_c^∞ with disjoint supports), E(4) acting by
(g·f)(x₁,…,x_n) = f(g⁻¹x₁,…,g⁻¹x_n). Required: (R1) 𝒯_n is E(4)-invariant and g ↦ g·f is continuous E(4) → 𝒯_n (true for
𝒮 and for its closed invariant subspace 𝒮_≠); (R2) each limit Schwinger function S_n is continuous on 𝒯_n (the corpus's
(E0) form |S_n(φ)| ≤ C_n|φ|_8ⁿ gives it). Then Stab(S) = ∩_{n,f}{g : S_n(g·f) = S_n(f)} is an intersection of closed sets,
a closed subgroup of E(4), and H := Stab(S) ∩ O(4) is closed.
(R3) TRANSLATIONS: with a_j = a₀L^{−K_j}, K_j increasing, a vector v ∈ a_{j₀}ℤ⁴ lies in a_jℤ⁴ for j ≥ j₀, and the torus
measures are invariant under lattice translations, so S(τ_v f) = S(f) on the dense set ∪_j a_jℤ⁴; closedness gives ℝ⁴.
(R4) B₄: the Wilson measure is invariant under the signed permutations about a site, on tori centred so that B₄ acts; the
fields are B₄-covariant scalars; so S(b·f) = S(f). By Theorem 3.2, H is finite or O(4).
THE OBSERVABLE CLASS, EXACTLY. Bare lattice Wilson loops are NOT in it: the perimeter renormalization of a lattice loop
approximating a smooth curve depends on the curve's orientation relative to the lattice (the staircase length), so the
original and the rotated lattices renormalize them differently. Flowed loops (t > 0) need no renormalization and are in it.
Tensor fields (F_μν, T_μν) are in it only after a renormalization covariant under O(4), which on the lattice means tuning the
finite renormalization of each B₄-irreducible component separately (for T_μν, the traceless diagonal and the off-diagonal
parts carry different constants; Caracciolo–Curci–Menotti–Pelissetto 1990). The 0⁺⁺ channel (action density) needs none.

5.2 THE ROTATION q (PROVED; COMPUTED S-3, S-4). q = (1+2i+2j+4k)/5: |1+2i+2j+4k|² = 1+4+4+16 = 25, so |q| = 1 and R = L_q ∈
SO(4) (record a: RᵀR = I). R acts on the real span of {1, q} as rotation by θ with cos θ = Re q = 1/5, and L_qⁿ = L_{qⁿ}; so R
has finite order iff q is a root of unity iff θ/π ∈ ℚ. INFINITE ORDER: if θ/π ∈ ℚ then e^{iθ} is a root of unity and
2cos θ = e^{iθ} + e^{−iθ} is an algebraic integer; 2/5 ∈ ℚ∖ℤ is not. (Equivalently Niven 1956: a rational cos θ with θ/π ∈ ℚ
lies in {0, ±1/2, ±1}.) 5R = [[1,−2,−2,−4],[2,1,−4,2],[2,4,1,−2],[4,−2,2,1]] and 5R⁻¹ = 5Rᵀ are integer matrices, so
5ℤ⁴ = R(5R⁻¹ℤ⁴) ⊆ Rℤ⁴ and 5Rℤ⁴ ⊆ ℤ⁴: aℤ⁴ and R(aℤ⁴) are commensurable and both contain the cubic coarse lattice 5aℤ⁴.
Their full intersection is larger: [ℤ⁴ : ℤ⁴ ∩ Rℤ⁴] = 25 = 5^{rank(Mᵀ mod 5)} (Mᵀ M = 25 I forces a totally isotropic column
space mod 5, rank 2; record a). Since 5aℤ⁴ ⊆ R(aℤ⁴), translations by 5aℤ⁴ preserve R(aℤ⁴): the half-open cubes of side 5a
centred on 5aℤ⁴ cut R(aℤ⁴) into translates of ONE block of exactly 625 points (record a) — one block type, so every
constant of the skew step is a finite computation.
EVERY ODD L. For any odd L ≥ 3 there is R with LR, LR⁻¹ ∈ M₄(ℤ) and R ∉ G₂₃₀₄: r₄(L²) = 8σ(L²) > 8 (Jacobi), so L² = |α|²
for an integer quaternion α with all coordinates of absolute value < L and Re α ≠ 0 (permute coordinates); R = L_{α/L}.
Then the common cubic coarse lattice La ℤ⁴ is reached from R(aℤ⁴) by ONE step of Bałaban's own odd factor L, with centred
blocks (M3b 15.1). Planar rotations (θ excluded from the anisotropic sector, §4) need a prime ≡ 1 mod 4 dividing L; take
L = 5^m or 13^m.

5.3 THE SIMILARITY TRICK (PROVED). Let Sim(4) = ℝ_{>0} × O(4) act on test functions by (λ, g)·f(x) = f(λ⁻¹g⁻¹x) in each
argument; ℝ_{>0} (the dilations D_λ) is CENTRAL. Let H_sim be the stabilizer of S in Sim(4) (closed, by 5.1).
LEMMA 5.3. Suppose B₄ ⊆ H_sim and some (λ, k) ∈ H_sim with k ∈ O(4) such that k⁻¹B₄k ⊄ G₂₃₀₄. Then S is O(4)-invariant.
PROOF. For b ∈ B₄, (λ, k)⁻¹(1, b)(λ, k) = (1, k⁻¹bk) ∈ H_sim — the dilations cancel because they are central. So H :=
H_sim ∩ O(4) is a closed subgroup containing B₄ and k⁻¹B₄k ⊄ G₂₃₀₄; by Theorem 3.3 it is not finite, and by Theorem 3.2 it
is O(4). ∎
For R = L_q, R⁻¹bR ∉ G₂₃₀₄ for 376 of the 384 elements b (record a); for the planar rotation, 352 of 384.
COROLLARY 5.4 (THE DILATION IS TRIVIAL GIVEN A GAP). If moreover S has a mass gap with finite mass, 0 < m* = inf spec(H|Ω⊥)
< ∞ (THE GROUND, Theorem 7.1, non-triviality), then λ = 1. PROOF. By Lemma 5.3, (1, k⁻¹) ∈ H_sim, so (λ, 1) ∈ H_sim: S is
invariant under D_λ. D_λ commutes with the time reflection θ and maps positive-time test functions to positive-time ones,
and S(θf̄·τ_t f) = S(θ(D_λf)‾·τ_{λt}D_λf), i.e. ⟨ψ_f, e^{−tH}ψ_f⟩ = ⟨ψ_{D_λf}, e^{−λtH}ψ_{D_λf}⟩ for all t ≥ 0: the spectral
measure of H in ψ_f is the image under E ↦ λE of that in ψ_{D_λf}. As f runs over a dense set so does D_λf, so
spec(H|Ω⊥) = λ·spec(H|Ω⊥), whence m* = λm* and λ = 1. ∎
WHY THIS MATTERS. The rotated lattice theory, blocked through a skew first step, reaches the unit scale with an isotropic
coupling shifted by δx = O(1) in x = 1/g² (the skew step's one-loop finite part and the different irrelevant feed-in): a
finite change of Λ, which does NOT vanish as a → 0. Proving δx_total = 0 directly is a non-perturbative matching of two
block schemes. Lemma 5.3 makes it unnecessary: the comparison need only show that the rotated limit equals the original
limit at SOME renormalization condition, i.e. up to a dilation; O(4) follows, and λ = 1 is then a consequence (5.4).
REMARK 5.5 (a surviving metric deformation would not hurt either). If the comparison gave S^R = S∘A with A ∈ GL(4) (a metric-
type deformation is a linear change of coordinates), then exponential clustering in every direction and non-triviality make
the stabilizer of S in GL(4) compact (a non-compact closed subgroup contains maps of unbounded distortion, under which
invariance forces every connected correlation at positive separation to vanish); a compact group containing B₄ preserves a
B₄-invariant positive form, hence the standard one, so it lies in O(4) and A·R⁻¹ is orthogonal. So metric deformations are
self-correcting at the level of the limit; only Weyl-type (non-metric) deformations must be shown to vanish (§6).

## 6. THE ULTRAVIOLET SIDE (c) — ORIENTATION UNIVERSALITY AS A TWO-LATTICE COMPARISON, WITH ONE EXTRA ROW

Read before this section (added 09:4x EST on the trunk's message): `math/M3f/WORK.md` §§1–6, 14–17 — (1) R preserves
integrals and the marginal outside its integration region, NOT the density: ρ_K is not the law of the unit-scale block
variables, and E1 is a statement about GENERATING FUNCTIONALS (W_K(τ) of (S₁)); (2) Theorem U (universality inside one
class, backward tuning) and Corollary 5.1; (3) two cutoffs differ at TREE level, handled by the variational sandwich
(Lemma 6.2: contraction L^{−2j}), with (T_loc) and (CB) remaining.

### 6.0 THE DECISION (answer to the trunk's question)

DOES A RATIONALLY ROTATED BARE LATTICE LIE IN A CLASS TO WHICH THE SANDWICH AND THEOREM U APPLY?
- THE SANDWICH: YES, VERBATIM (6.2). After one exact skew step the rotated theory is a density on the common coarse lattice
  Laℤ⁴ whose leading part is −x S^R_1(V), S^R_1 the minimizer action of the rotated Wilson action on R(aℤ⁴) under the skew
  constraint. Its difference from the original's S_1 is a tree-level functional Δ^R := S^R_1 − S_1 with NO part of dimension
  below six (Lemma 6.2′, proved at the quadratic level, the rest by gauge invariance). Lemma 6.2 of M3f applies with Δ^R in
  place of Δ, giving the tree-level contraction L^{−2j}; (T_loc) and (CB) are the same items, in the same form.
- THEOREM U: NO, NOT AS IT STANDS (6.3). Its kill-switch (K2) — "a marginal remnant in the history not removed by the
  step's counterterm" — IS MET by the skew step, for every admissible R (Theorem 4.1): the skew step's localized one-loop
  terms carry a dimension-four ANISOTROPIC remnant y₁ ∈ (Sym²Λ²)^{G′} ⊖ ℝ·Id (Weyl-type always; metric-type or θ depending on
  R), of absolute size O(1), i.e. relative size O(g₀²) against the Wilson term, which Bałaban's scalar counterterm β·A does
  not remove. The refinement of E1 has no such remnant, because the finer lattice's step is B₄-covariant.
- THE REPAIR (6.4): Theorem U plus ONE ROW — the anisotropic marginal tensor, carried as M3b's Lemma Σ₁ carries a coupling
  field. The row CONTRACTS, but at the asymptotic-freedom rate, not geometrically: its unit-scale size is O(g₀²·X) for the
  metric part and O(g₀²·X·(g₀²/γ²)^{7/11}) for the Weyl part (Colladay–McDonald's running), so it vanishes at a rate
  polynomial in 1/log ε⁻¹ — the same order as E1's own rate, which M3f's §6.6 sets by the deep marginal R-terms.
SO: (E2)'s UV input IS E1's two-cutoff argument with the rotation in place of the refinement at TREE level (sandwich,
(T_loc), (CB) identical), PLUS the anisotropic row at LOOP level, PLUS Bałaban's single-step estimates for one periodic
skew block type (6.5). Stated for generating functionals, as M3f (1) requires (6.1).

### 6.1 THE FORM OF THE STATEMENT (M3f (1) applied)

Fix a physical torus T = ℝ⁴/P with period lattice P = NLaℤ⁴ (N a multiple of the needed powers of L), which is a sublattice
of BOTH aℤ⁴ and R(aℤ⁴) (Laℤ⁴ ⊆ R(aℤ⁴)). On T there are two lattice regularizations of Yang–Mills: the Wilson action on
aℤ⁴/P and the Wilson action on R(aℤ⁴)/P. By exact covariance the second is R_* of the Wilson theory on the torus with
periods R⁻¹P ⊆ aℤ⁴ (L R⁻¹ integral). Sources: the same test function h on T coupled to each lattice's own action density
(M3b's (S₁): a complex coupling field τh). Generating functionals W^{orig}_K(τ; β₀), W^{rot}_K(τ; β₀) (K = number of steps to
the unit scale), defined as log Z(τ) − log Z(0) − V(τ) as in M3f 2.4 (d).
E2-UV(T) (THE STATEMENT). There are bare couplings β₀′(a) for the ORIGINAL lattice (backward-tuned so that the two flows
reach the same unit-scale coupling X) such that, for real τ on (S₁)'s disc and K → ∞,
  W^{rot}_K(τ; β₀) − W^{orig}_K(τ; β₀′) → 0,
uniformly on compacts of the complex disc with every τ-derivative (Vitali). By M3f 2.4, this compares partition functions,
which Bałaban's machinery computes exactly; nothing is claimed about the unit-scale densities as laws.

### 6.2 TREE LEVEL: THE SANDWICH APPLIES (PROVED, given (Δ-i) for S^R_1 and (Δ-ii))

Let Q^R be the skew block map R(aℤ⁴) → Laℤ⁴ (gauge-covariant averages of parallel transports along staircase paths of
R(aℤ⁴) between the centred cubes; chosen G′-covariant, in particular symmetric under −1 ∈ G′), followed by Bałaban's standard
centred averages Q^{(j)} on Laℤ⁴ → L^{1+j}aℤ⁴. Hard constraints compose: {U on R(aℤ⁴) : Q^{(j)}Q^R U = V} =
∪_{W : Q^{(j)}W = V}{U : Q^R U = W}. Define the one-step tree actions S^R_1(W) := min{A^R(U) : Q^R U = W} (A^R the Wilson
action on R(aℤ⁴)) and S_1(W) := min{A(U) : Q U = W} (the original's), and S^R_{1+j}(V) = min_{W : Q^{(j)}W = V} S^R_1(W),
S_{1+j}(V) = min_{W : Q^{(j)}W = V} S_1(W).
LEMMA 6.2 (M3f's sandwich, transcribed). With Δ^R := S^R_1 − S_1 (a functional on Laℤ⁴) and W_*, W^R_* the minimizers for V,
  Δ^R(W^R_*(V)) ≤ S^R_{1+j}(V) − S_{1+j}(V) ≤ Δ^R(W_*(V)).
PROOF. W_* is admissible for S^R: S^R_{1+j}(V) ≤ S^R_1(W_*) = S_{1+j}(V) + Δ^R(W_*). W^R_* is admissible for S:
S_{1+j}(V) ≤ S_1(W^R_*) = S^R_{1+j}(V) − Δ^R(W^R_*). ∎ (M3f's Lemma 6.2 is the case S^R_1 → S′_m, S_1 → A^ε; the proof uses
nothing but the composition of hard constraints.)
LEMMA 6.2′ (Δ^R HAS NO PART OF DIMENSION BELOW SIX; PROVED at the quadratic level, the rest by gauge invariance). Linearize
U = e^{iA}: the quadratic part of a one-step tree action is the Gaussian blocked kernel K₁ = [Q̂ K₀⁻¹ Q̂*]⁻¹ on the transverse
(gauge-invariant) sector, with the alias sum over the coarse dual cosets. (i) Q̂^R(0) = I on the vector index: a constant fine
field is pure gauge, A = ∇(A·x), so every path from block y to block y + Lae_μ carries the same integral La·A_μ — the coarse
field at zero momentum IS the fine field, exactly (gauge covariance pins the normalization). (ii) The O(p) term of Q̂^R
vanishes: the averaging is symmetric under −1 ∈ G′. So Q̂^R(p) = I + O(p²), and the alias terms carry |Q̂^R(p + k)|² = O(p²)
for k ≠ 0 (at p = 0 they are character sums over R(aℤ⁴)/Laℤ⁴ that vanish off the fine reciprocal lattice, where the fine
kernel's zero-modes are gauge directions). Hence K^R_1(p) = K^R_0(p) + O(p⁴) on the transverse sector, and K^R_0(p) =
p²δ − pp + O(p⁴) is the naive continuum limit of the Wilson action on R(aℤ⁴), which is ISOTROPIC with Wilson's
coefficient (R is a rotation and the continuum term is O(4)-invariant). The same holds for K₁. So the quadratic part of Δ^R
is O(p⁴): dimension six. Dimension five: no gauge-invariant local scalar (an odd-rank invariant tensor would be needed, and
−1 ∈ G′). The dimension-four gauge-invariant terms c^{μνρσ}tr F_μνF_ρσ are fixed by their quadratic parts, which agree. ∎
CONSEQUENCE (PROVED GIVEN (Δ-i), (Δ-ii)). With S^R_1 in M3f's class 𝒮 (ellipticity with a geometry-dependent constant from
the curl contraction over the skew tube; strip analyticity from CMP 102 Theorem 1 for one skew block type), Lemma WI gives
|Δ^R(W)| ≤ C_Δ Σ_x(|∇F_W|² + |F_W|³), and the sandwich with the smoothness of the interpolants gives
  |S^R_{1+j}(V) − S_{1+j}(V)| ≤ C_Δ L^{−2j}j^c Σ_{coarse p}|V(∂p) − 1|²(1 + O(α)):
the tree-level orientation difference contracts at the same rate as the tree-level cutoff difference. In the language of
M3f (3): both bare lattices flow, at tree level, to the same classically perfect (Hasenfratz–Niedermayer) action; the
sandwich proves the contraction toward it from the rotated side too.

### 6.3 LOOP LEVEL: THEOREM U's (K2) IS MET (PROVED)

The skew step's localized one-loop terms (the log-determinant of the skew-constrained fluctuation operator in the background
U^R_1(V), and the Gaussian-weighted interaction terms) are G′-symmetric local functionals of V. Their dimension-four part is a
G′-invariant symmetric form on Λ²: c₀·Id + y₁ with y₁ ∈ (Sym²Λ²)^{G′} ⊖ ℝ·Id. Bałaban's counterterm at the step is −β·A (the
isotropic Wilson action), which removes c₀·Id and nothing else. By Theorem 4.1, (Sym²Λ²)^{G′} contains a nonzero Weyl-type
vector for every R ∉ G₂₃₀₄, so y₁ is a symmetry-allowed marginal remnant: Theorem U's kill-switch (K2) is met, generically.
(Its size: tree level contributes nothing (Lemma 6.2′); the one-loop terms are O(1) in absolute normalization, against the
O(x₀) = O(1/g₀²) Wilson term: relative size O(g₀²). The refinement of E1 creates no y₁: the finer lattice's one-step output
is B₄-invariant and (Sym²Λ²)^{B₄} = ℝ·Id, S-1.)

### 6.4 THE EXTRA ROW (CONDITIONAL on Lemma Σ_χ below; its mechanism PROVED at the level of one-loop power counting)

After the skew step every step is Bałaban's standard B₄-covariant step. A B₄-equivariant map cannot create a component in a
non-trivial isotypic part from an invariant input; to first order it propagates each anisotropic component linearly within
its isotypic part (second order in y is O(g₀⁴)). Write the dimension-four part of the action at step k as x_kId + y_k and the
RELATIVE anisotropy δ_k := y_k/x_k. Per step, along the renormalized trajectory:
- METRIC-TYPE (1,1): δ_{k+1} = δ_k(1 + O(g_k⁴)). Reason: a metric-type χ = Id + δ is Yang–Mills in linearly changed
  coordinates; the continuum one-loop divergence is GL(4)-covariant, hence proportional to χ itself, so the relative
  anisotropy has no one-loop logarithm. A per-step O(g_k²) term would sum to a one-loop log ε⁻¹ in the bare-to-renormalized
  anisotropy, which Karsch's one-loop computation on asymmetric lattices excludes (his coupling corrections c_σ(ξ), c_τ(ξ) are
  finite: Nucl. Phys. B 205 (1982) 285). Colladay–McDonald state the same: trace components "can be removed from a pure
  Yang-Mills theory" by coordinate redefinitions.
- WEYL-TYPE (2,0)⊕(0,2): δ_{k+1} = δ_k(1 − c_W g_k² + O(g_k⁴)), c_W = (14/3)C₂(G)·(log L)/(16π²) > 0. Reason: this is the
  CPT-even Lorentz-violating coefficient k_F (Riemann symmetries, Bianchi identity, trace-free) of the Standard-Model
  Extension; Colladay–McDonald (Phys. Rev. D 75 (2007) 105002, hep-ph/0609084, eq. (44)) compute β_{k_F} = (14/3)C₂(G)
  g²/(4π)²·k_F and β_g = −(11/3)C₂(G)g³/(4π)² (eq. (43)), solved by k_F = (k_F)₀Q^{7/11} (eq. (47)): k_F ∝ (g²)^{−7/11}. It
  GROWS toward the ultraviolet and DECREASES toward the infrared. The one-loop logarithm is scheme-independent, so it is the
  per-step coefficient of any Wilsonian scheme along the renormalized trajectory (a non-log per-step constant would sum to a
  non-universal log).
- θ (tr F∧F; present when G′ ⊆ SO(4), absent for the planar choice): a total derivative, invisible to every perturbative
  flow; in Bałaban's language a boundary term of polymers; its non-perturbative effect needs large fields, suppressed by
  e^{−8π²/g₀²} at the cutoff. Choosing R with an orientation-reversing element in G′ (planar rotations) excludes it by symmetry.
- FEED-IN: the irrelevant anisotropic history (O(1) in lattice units after the skew step, contracting like L^{−β′(k−1)},
  PI-5) feeds the marginal row by O(g_k² L^{−β′(k−1)}) per step: summable, total O(g₀²) relative.
UNIT-SCALE SIZE. Π_k(1 − c_Wg_k²) = (x_K/x₀)^{c_W/c₀}(1 + o(1)) with c₀ = 2b₀ log L, c_W/c₀ = (14/3)/(22/3) = 7/11 for every
compact simple G. So δ^{metric}_K = O(g₀²) and δ^{Weyl}_K = O(g₀²(g₀²/γ²)^{7/11}); in absolute normalization y_K = Xδ_K → 0,
i.e. like (log ε⁻¹)^{−1} (metric) and (log ε⁻¹)^{−18/11} (Weyl). ROBUSTNESS: the conclusion needs only that every anisotropic
marginal component grows by at most 1 + c g_k² per step with c < c₀ (less relevant than the coupling); metric (c = 0) and
Weyl (c = −c_W < 0) satisfy it with margin, so the exact value 14/3 is not load-bearing — its SIGN only makes it better.
ASYMPTOTIC FREEDOM KILLS ROTATION BREAKING TWICE: the created anisotropy is O(g₀²) → 0, and the flow cannot amplify it.
LEMMA Σ_χ (NAMED; the rigorous form of this row). CMP 119's reduction (3.56)–(3.64) of the second-order term to β′·½Σ tr F²
uses translation invariance and "Euclidean covariance" (B₄); without B₄ it reduces the second-order term to a G′-invariant form
c₀Id + y. Statement: carry y_k ∈ (Sym²Λ²)^{G′} ⊖ ℝ·Id as a constant tensor coupling (an anisotropic Wilson coefficient
x_kId + y_k in the reference action, the device of M3d's R_D with a tensor in place of a scalar D); prove the per-step map
on y is (1 + O(g_k⁴)) on the metric part and (1 − c_Wg_k² + O(g_k⁴)) on the Weyl part, with the normalized remainders
irrelevant uniformly (Theorem PI-5 with the anisotropic counterterm). FALSIFIER: a per-step O(g_k²) growth of the metric part,
or a Weyl coefficient of the wrong sign exceeding c₀.

### 6.5 THE SKEW SINGLE STEP (NAMED; a finite-geometry instance of published estimates)

One step with the skew block (one periodic block type, 625 fine sites per block for L = 5): the averaging operator's
properties (CMP 98: gauge covariance, normalization, the composition with the standard averages), the variational problem
(CMP 102 Theorem 1 and (190) for the skew constraint), the propagators and random-walk expansions of the constrained
operators (CMP 95, 96, 99) and the large-field step, all for one fixed block geometry. Bałaban's analysis is written for
cubes with straight contours; CMP 109 p. 252 insists on lattice-Euclidean covariance of the averaging "very important for the
method" — what it buys is exactly the reduction of 6.3, which the extra row now carries. Every constant is a finite
computation on one block. It enters ONCE (at the cutoff), with g₀ → 0.

### 6.6 STATUS OF E2-UV(T)

CONDITIONAL on: [E1's inputs for the rotated pair: Theorem U's inputs ([BB-a]–[BB-c], Lemma M_c, PI-4, PI-5, (ROB), (W),
(B-SUP)), (T_loc), (CB), with Δ^R in place of Δ] + [6.5: the skew single step] + [Lemma Σ_χ: the anisotropic row]. Given
these, the assembly is M3f's §6.6 with one more term in the bound,
  |W^{rot}_K(τ; β₀) − W^{orig}_K(τ; β₀′)| ≤ C N_T[(K − j_*)q^{K−j_*} + (K(c − ρ))^{1−κ₀/2} + |y_K| + e^{−c(log K)^{2p₀}} + |m_K − m′_K|],
|y_K| = O((log ε⁻¹)^{−1}) — the rate stays polynomial in 1/log ε⁻¹, as for E1.
THE ANSWER TO (c)'s QUESTION. Yes, (E2)'s UV statement is a case of the two-cutoff comparison — a change of the bare
lattice, rotation instead of refinement — at tree level exactly, and at loop level up to one marginal row that refinement
never produces. A non-cubic or rotated block needs, additionally: the single-step estimates for its geometry, and the
anisotropic row (Lemma Σ_χ), whose one-loop coefficients are known (0 and Colladay–McDonald's) and favourable.

### 6.7 DATED PRECISION TO LEMMA 6.2′ (2026-11-02, written after 6.0–6.6; nothing above edited)

The parenthesis in Lemma 6.2′ on the alias terms ("character sums ... vanish off the fine reciprocal lattice") is exact for a
POINT average (the scalar analogue below) but not for Bałaban's path averages, whose alias amplitudes Q̂^R(k) at nonzero coset
momenta k need not vanish (the paths depend on the starting point's position in the block). The conclusion stands by the
argument M3f gives for the refinement (§8.2 as corrected in 14.1): the constrained minimizer obeys the Euler–Lagrange
equation d*dA* = Q*λ with multiplier λ = Δ₁a (the gradient of the value function), so λ̂(P) = O(P²)â(P) and the transverse
alias components Â*(p_l) = (p̂_l²)⁻¹(transverse part of Q̂(p_l)*λ̂(P)) are O(P²|â|); they enter the action at O(P⁴). The
dimension-four coefficient is therefore read at the zero alias alone, where Q̂^R(P) = I + O(P²) and the fine kernel is
isotropic: the argument is blind to the block's shape and to the fine lattice's orientation. Lemma 6.2′ holds as stated.

### 6.8 STAKE (written before `bin/me2_skewkernel.py` runs)

S-K (scalar analogue of Lemma 6.2′; a CHECK). Free scalar field; original Z⁴ with the centred 5⁴ box average onto 5Z⁴;
rotated R(Z⁴) (R = L_q) with the average over its 625 points in the centred cube onto 5Z⁴. Known answers first: Q(0) = 1,
Q(k) = 0 at the 624 nonzero dual cosets (both, to 1e-12). STAKE: for both blockings (K₁ − |P|²)/|P|⁴ converges as |P| → 0
(i.e. the |P|² coefficient is exactly 1 — isotropic), along e₁, (1,1,0,0)/√2, (1,1,1,1)/2, Re₁ and a random direction; the
difference (K₁^R − K₁)/|P|⁴ converges to a NONZERO direction-dependent limit (values UNGUESSED): the orientation difference
is dimension-six (here: order |P|⁴ against the dimension-two |P|²), anisotropic, and present.

### 6.9 RESULTS OF S-K (record `rec/me2_skewkernel_run.2026-11-02a.txt`, rc = 0, 19 s; nothing in 6.8 edited)

KNOWN ANSWERS MET: Q(0) = 1 for both; max |Q(k)| over the 624 nonzero cosets 1.3e−15 (standard), 7.4e−16 (rotated).
THE STAKE HELD. (K₁ − |P|²)/|P|⁴ converges for both blockings (t = 0.08, 0.04, 0.02, 0.01): the |P|² coefficient is exactly
1, isotropic. The limits, read at t = 0.01: standard 1.91677 (e₁), 1.95843 ((1,1,0,0)/√2), 1.97925 ((1,1,1,1)/2); rotated
2.04162, 2.03366, 2.02409, 1.99679 (Re₁), 2.04496 (random). The difference (K₁^R − K₁)/|P|⁴ → 0.1248 (e₁), 0.0752, 0.0448,
0.0352 (Re₁), 0.0732 (random): nonzero, direction-dependent, order |P|⁴ against |P|² — dimension six.
CLOSED FORM, MET. With |Q̂|² = 1 − P·M·P + … and 1/K₀ = |P|⁻²(1 + (1/12)Σ(P·e)⁴/|P|² + …), and the aliases entering only at
O(|P|⁶) (|Q̂(P + k)|² = O(P²) at nonzero cosets), K₁ = |P|² + |P|²(P·M·P) − (1/12)Σ_μ(P·a_μ)⁴ + O(|P|⁶), a_μ the fine axes.
Standard: M = 2I, so the coefficient is 2 − (1/12)Σn_μ⁴ = 1.916667, 1.958333, 1.979167 on the three directions — read
1.91677, 1.95843, 1.97925. Rotated: M^R = m I by Schur (G′ = right Q₈ acts irreducibly on ℍ), and the three readings give
m = 2.0801 consistently (the continuum cube would give 25/12 = 2.0833). So the orientation difference is (m − 2)|P|⁴
(isotropic, the blocks' second moments) + (1/12)[Σ P_μ⁴ − Σ (P·Re_μ)⁴] (anisotropic, the fine lattices' artefacts).

## 7. THE INFRARED SIDE (d) — EQUAL LIMITS FROM CLOSE SPECIFICATIONS UNDER HYPOTHESES I AND II

7.0 WHERE THE COMPARISON MUST BE MADE. Not at the ultraviolet unit scale: there the coupling is γ (weak), no uniqueness
criterion is available, and the uniqueness of the infinite-volume state for the unit-scale theory IS the crossover problem.
The comparison is made at the exit scale a_c, where Hypothesis I is Dobrushin's condition. And by M3f 2.4 (c), Hypotheses I
and II concern the TRUE blocked laws λ_j (not Bałaban's ρ_K); the comparison below is stated for true blocked laws.

THEOREM 7.1 (THE AVERAGED COMPARISON; PROVED). Let Λ be a finite set (or ℤ⁴ with the usual quasilocality), V a compact
metric space, λ and λ̃ probability measures on V^Λ. Let γ_y(dv_y | v_{−y}) be the conditional laws of λ (defined for every
configuration: λ has a positive density in finite volume) and C(y, y′) = sup ‖γ_y(·|v) − γ_y(·|v′)‖_TV over v, v′ differing only
at y′ (THE GROUND (8.5)). Suppose sup_y Σ_{y′} C(y, y′) ≤ α < 1. Let λ̃_y(dv_y | v_{−y}) be ANY version of λ̃'s regular
conditional law (it exists on a standard Borel space; no Gibbs property of λ̃ is assumed) and put
  ã_y := ∫ ‖λ̃_y(·|v_{−y}) − γ_y(·|v_{−y})‖_TV λ̃(dv).
Then for every bounded measurable F,  |λ(F) − λ̃(F)| ≤ Σ_{i,y} δ_i(F) D(i, y) ã_y,  D := Σ_{n≥0} Cⁿ.
PROOF. (Dobrushin's comparison theorem, Georgii, Gibbs Measures, Thm 8.20; the proof gives the averaged form.) Write
γ_yG(v) := ∫ G(w_y, v_{−y}) γ_y(dw_y|v_{−y}) and similarly λ̃_yG. (1) λ(γ_yG) = λ(G) and λ̃(λ̃_yG) = λ̃(G) (disintegration).
(2) For i ≠ y, δ_i(γ_yG) ≤ δ_i(G) + δ_y(G)C(y, i), and δ_y(γ_yG) = 0. (3) |λ̃(G) − λ̃(γ_yG)| = |λ̃(λ̃_yG − γ_yG)| ≤ δ_y(G)·ã_y,
because (λ̃_yG − γ_yG)(v) is the difference of the integrals of a function of oscillation ≤ δ_y(G) against two probability
measures on V. (4) Let y₁, y₂, … run through Λ repeatedly and F_n := γ_{y_n}F_{n−1}, F₀ = F. By (1), λ(F_n) = λ(F); by
Dobrushin's condition and (2), δ(F_n) → 0, so F_n converges uniformly to the constant λ(F) and λ̃(F_n) → λ(F). By (3),
|λ̃(F) − λ̃(F_n)| ≤ Σ_{m≤n} δ_{y_m}(F_{m−1}) ã_{y_m}, and by (2) iterated (Georgii's bookkeeping, Thm 8.20 / Lemma 8.23)
Σ_{m: y_m = y} δ_y(F_{m−1}) ≤ Σ_i δ_i(F)D(i, y). Let n → ∞. ∎
With Hypothesis I's weighted form Σ_{y′}C(y,y′)e^{κ|y−y′|} ≤ α, D(i, y) ≤ e^{−κ|i−y|}/(1 − α) (THE GROUND's proof of Thm 8.5),
so |λ(F) − λ̃(F)| ≤ (1 − α)⁻¹ Σ_i δ_i(F) · sup_y Σ_{y′}e^{−κ|i−y′|}... ≤ C_κ(1 − α)⁻¹ (Σ_i δ_i(F)) sup_y ã_y, uniformly in Λ.

COROLLARY 7.2 (EQUAL LIMITS; PROVED GIVEN the inputs named). At the exit scale a_c, on the common torus T (or in infinite
volume), let λ_j be the true blocked law of the ORIGINAL theory at the backward-tuned bare coupling β₀′(a_j) and λ̃_j that of
the ROTATED theory at β₀(a_j) (skew step, then standard steps, onto the same coarse lattice), with fibre means
F_j = ν_j(O_f | ·) and F̃_j = ν̃_j(Õ_f | ·) of the same smeared observable O_f realized on each fine lattice. Assume
 (H-I) Hypothesis I for λ_j, uniformly in j and T (the original theory only);
 (H-II b) Hypothesis II(b) for F_j: δ_i(F_j) ≤ K′N(f)‖f‖ρ′^{dist(i,S(f))}, so Σ_i δ_i(F_j) ≤ C_f uniformly;
 (UV-a) sup_y ã_y^{(j)} → 0 (the two conditional laws at a_c agree on average under the rotated law);
 (UV-b) λ̃_j|F_j − F̃_j| → 0.
Then S_j(f) − S̃_j(f) = [λ_j(F_j) − λ̃_j(F_j)] + λ̃_j(F_j − F̃_j) → 0 uniformly in T, by Theorem 7.1. The same for every finite
family (products of smeared observables). So the original limit at the renormalization condition β₀′ and the rotated limit
coincide.
WHAT THE ROTATED THEORY NEEDS: NOTHING. Theorem 7.1 asks for Dobrushin's condition only of λ; λ̃ enters through its own
regular conditional laws, which exist. No Hypothesis I or II for the skew-blocked rotated theory, no Gibbs property of λ̃.

7.3 HOW (UV-a), (UV-b) ARE SUPPLIED. By the tilt lemma (THE GROUND Prop. 8.4), if λ̃_j's conditional laws are tilts of
λ_j's by the difference of effective actions, ‖λ̃_y − γ_y‖_TV ≤ 1 − e^{−osc_{v_y}(Ã − A)} ≤ osc_{v_y}(Ã − A), so ã_y ≤
λ̃_j[osc_{v_y}(Ã_j − A_j)]. Hence (UV-a) follows from: E2-UV(T) at the unit scale (§6, generating functionals) + (F2-Lip): the
crossover steps from the unit scale to a_c — (F2) on [β_s, β_x] of the One Flow theorem (crossing campaign §21) — Lipschitz
in their input, in a norm controlling the averaged conditional oscillation of the TRUE blocked effective action at a_c. Any
certified convergent expansion supplies such a Lipschitz bound (analyticity in the activities). (UV-b): the same with the
source carried (S₁). THE INTERFACE "Bałaban density at the unit scale → true blocked law" (M3f 2.4 (c)) is common to the whole
program (Hypothesis I itself needs it) and is not specific to (E2); it is named, not claimed.

7.4 THE ALTERNATIVE FORM ASKED IN (d), AND ITS PRICE. "Equal limiting effective actions at scale ε + uniqueness of the
infinite-volume Gibbs state for that action ⇒ equal limits" is TRUE in this form: if the specifications of A_ε^{(j)} and
Ã_ε^{(j)} converge to that of one A*_ε in the quasilocal topology (uniformly over boundary configurations), every weak limit
of λ_j and of λ̃_j is a Gibbs measure for A*_ε (DLR equations pass to quasilocal limits), and uniqueness makes them equal.
Uniqueness for A*_ε follows from Hypotheses I and II along the flow by DECOMPOSITION: a Gibbs measure at ε has a coarse marginal
at a_c that is Gibbs for the blocked specification (defined for every coarse configuration because Hypothesis II makes the
fibre Gibbs state unique for every v), Dobrushin (Hypothesis I) makes that marginal unique, and Hypothesis II(a) makes every
fibre state unique; so the measure at ε is unique. THE PRICE: convergence of specifications uniformly over ALL boundary data,
large fields included — stronger than Bałaban's analysis gives at ε (small fields controlled, large fields only suppressed).
Theorem 7.1 needs only AVERAGE closeness, under the rotated law, at a_c. That is why 7.1/7.2 is the form adopted.

7.5 VAN ENTER–FERNÁNDEZ–SOKAL: WHICH HYPOTHESIS EXCLUDES THEM. vEFS (J. Stat. Phys. 72 (1993) 879) show that a blocked Gibbs
measure need not be Gibbsian: the conditional law of a block variable can depend non-quasilocally on distant block variables.
THE MECHANISM is a phase transition of the CONSTRAINED (fibre) system at some, typically atypical, block configuration; and van
Enter–Fernández–Kotecký (hep-lat/9409016) show it can occur deep inside the original measure's complete-analyticity region —
so no property of the original measure excludes it. EXCLUDED BY HYPOTHESIS II, demanded FOR EVERY coarse configuration v
(THE GROUND §8.3 stresses "the adversarial ones included"): uniform fibre clustering is exactly the known sufficient condition
for Gibbsianness of the renormalized measure with a convergent interaction (Haller–Kennedy, mp_arc 95-505: the constrained
systems "in the high-temperature phase uniformly in the block-spin configuration"; Bertini–Cirillo–Olivieri, J. Stat. Phys. 97
(1999): strong mixing of the constrained systems). Hypothesis I, in its sup form uniform in the volume, then asserts the
quasilocality and the uniqueness of the blocked specification directly. A merely TYPICAL-v version of Hypothesis II would give
only weak (almost-sure) Gibbsianness (Bricmont–Kupiainen–Lefevere; Maes–Redig–Van Moffaert): if the program moves to a
measure-weighted crossover, Theorem 7.1 must be replaced by a continuity theorem for measure-weighted specifications (e.g. under
approximate tensorization of entropy uniform in the volume) — OPEN in that setting. In the present form the rotated theory's
own possible pathologies (its skew blocking) do not matter at all: 7.1 never asks for its specification.

7.6 TORUS SHAPE AND INFINITE VOLUME (PROVED GIVEN (H-I), (H-II)). The rotated theory on the axis-aligned torus T is R_* of the
original on the torus with periods R⁻¹P ⊆ aℤ⁴ (a sublattice of a_cℤ⁴ when L^{k_c} | N, since L R⁻¹ is integral). Hypotheses I
and II are local statements, so assume them on every torus whose period lattice lies in a_cℤ⁴. Dobrushin uniqueness of the
coarse specification gives, for a torus measure restricted to a box Λ around supp F (a mixture of box Gibbs measures with
boundary conditions, by the torus's DLR equations), |μ_T(F) − μ_∞(F)| ≤ Ce^{−κ dist(supp F, Λ^c)}, uniformly in j: every
sequence of tori, of any shape, gives the same infinite-volume limit S_∞, at a physical rate.

7.7 DATED PRECISION TO THEOREM 7.1's LAST DISPLAY (written after §7; nothing above edited). The garbled line should read:
since the row sums of Cⁿ are ≤ αⁿ, Σ_y D(i, y) ≤ (1 − α)⁻¹, hence |λ(F) − λ̃(F)| ≤ (1 − α)⁻¹ (Σ_i δ_i(F)) sup_y ã_y, uniformly
in Λ. The exponential weight of Hypothesis I is not needed for this bound (it localizes D, which 7.6 uses).

## 8. ASSEMBLY

THEOREM 8.1 ((E2) — CONDITIONAL; the reduction PROVED). Let R ∉ G₂₃₀₄ with LR, LR⁻¹ integral (e.g. L = 5 and R = L_q, or the
planar rotation by arctan(4/3)). Assume
 (E1) the continuum limit of the generating functionals exists, is independent of the cutoff sequence, and changes with the
      renormalization condition only by a dilation (M3b, M3d, M3f: PROVED in parts, full E1 GIVEN (T_loc), (CB) and Theorem
      U's inputs);
 (UV) E2-UV(T) of §6.1 for this R (CONDITIONAL on E1's inputs for the rotated pair, the skew single step 6.5, Lemma Σ_χ 6.4);
 (X)  (F2-Lip) of §7.3 (OPEN; part of the crossover (F2) on [β_s, β_x] of the One Flow theorem, crossing campaign §21);
 (IR) Hypotheses I and II at the exit scale on every torus whose period lattice lies in a_cℤ⁴ (the gap's own hypotheses).
Then every scalar Schwinger function of the limit (the 0⁺⁺ sector and any scalar sector carried as sources) is invariant under
E(4) = ℝ⁴ ⋊ O(4). If the limit also has a finite nonzero mass (Theorem 8.5 + non-triviality), the comparison's dilation is
trivial: the skew and standard block schemes have equal Λ-parameters in the limit.
PROOF. (UV) + (X) give (UV-a), (UV-b) (7.3); Corollary 7.2 gives, on every common torus T and uniformly in T, lim S^{rot}_T =
lim S^{orig,β₀′}_T; 7.6 passes to infinite volume, and exact covariance (S^{rot} = S^{orig} ∘ R⁻¹ on the rotated torus) gives
S(R⁻¹·f) = S′(f) for all f, S′ the original limit at the condition β₀′; (E1) gives S′ = S∘D_λ. So the similarity (λ, R) — up
to the orientation convention — stabilizes S. Lemma 5.3 applies (R⁻¹bR ∉ G₂₃₀₄ for 376 of the 384 b ∈ B₄ for L_q, 352 for
the planar R): O(4)-invariance. With 5.1 (R3), E(4). Corollary 5.4 gives λ = 1. ∎

| Step | Status | Where |
|---|---|---|
| Λ²ℝ⁴ absolutely irreducible under B₄ | PROVED; COMPUTED (commutant dim 1) | §3, record a |
| closed H ⊇ B₄ is finite or O(4) | PROVED | Thm 3.2 |
| the finite ones: W(B₄), W(F₄), G₂₃₀₄ (384, 1152, 2304), all inside G₂₃₀₄ | PROVED (S³ projections) + COMPUTED (all 2⁵ coset unions) | Thm 3.3, record a |
| one element outside G₂₃₀₄ forces O(4); infinite order not needed | PROVED | Cor 3.4 |
| q = (1+2i+2j+4k)/5: |q| = 1, infinite order, 5R and 5R⁻¹ integral, [ℤ⁴ : ℤ⁴ ∩ Rℤ⁴] = 25, 5ℤ⁴ common, one 625-point block | PROVED; COMPUTED | §5.2, record a |
| every odd L admits such R | PROVED (Jacobi r₄) | §5.2 |
| every admissible R gives a skew block with a Weyl-type marginal invariant | PROVED; COMPUTED (6,827 rotations) | Thm 4.1, §2.3 |
| stabilizer closed under (R1)–(R4); observable class (scalar; not bare loops; tensors only with B₄-component renormalization) | PROVED | §5.1 |
| similarity trick: equality up to a dilation suffices | PROVED | Lemma 5.3 |
| dilation trivial given a finite gap | PROVED | Cor 5.4 |
| tree level: sandwich for the rotated pair; Δ^R has no part below dimension six | PROVED (sandwich); PROVED at quadratic order + gauge invariance (Lemma 6.2′, 6.7); scalar analogue COMPUTED, closed form met | §6.2, 6.7, 6.9 |
| loop level: Theorem U's (K2) met by the skew step | PROVED | §6.3 |
| anisotropic row: metric no one-loop log, Weyl ∝ (g²)^{−7/11} (Colladay–McDonald), size O(g₀²) at the unit scale | mechanism PROVED at one-loop power counting; rigorous form = Lemma Σ_χ NAMED | §6.4 |
| skew single step | NAMED (published estimates, one block geometry) | §6.5 |
| E2-UV(T) | CONDITIONAL (E1's inputs + 6.5 + Σ_χ) | §6.6 |
| averaged Dobrushin comparison (only the original needs Hypothesis I) | PROVED | Thm 7.1 |
| equal limits from (H-I), (H-II b), (UV-a), (UV-b) | PROVED GIVEN those | Cor 7.2 |
| (UV-a), (UV-b) from E2-UV + (F2-Lip) | PROVED GIVEN those (tilt lemma); the density-to-true-law interface named | §7.3 |
| vEFS excluded by Hypothesis II (for every v); Hypothesis I asserts the quasilocality | PROVED (as an implication) / CITED (vEFK, Haller–Kennedy, BCO) | §7.5 |
| torus-shape independence of the infinite-volume limit | PROVED GIVEN (H-I), (H-II) | §7.6 |
| (E2) | CONDITIONAL on (E1), (UV), (X), (IR) | Thm 8.1 |

## 9. TWO OTHER ROUTES, AND A THEOREM ONE OF THEM NEEDS

THEOREM 9.1 (WILSON'S ACTION IS REFLECTION POSITIVE ACROSS THE DIAGONAL HYPERPLANES; PROVED). Let G be a compact group, χ the
character of a unitary representation, and μ the Wilson measure ∝ Π_p exp(β Re χ(U_p)) Π_ℓ dU_ℓ on a box of ℤ⁴ invariant under
θ: (x₁, x₂, x₃, x₄) ↦ (x₂, x₁, x₃, x₄) (free boundary conditions), or any limit of such. Let L₊, L₀, L₋ be the links whose
midpoints have x₁ − x₂ > 0, = 0, < 0 (L₀ = the links in directions 3, 4 at sites with x₁ = x₂; θ swaps L₊ and L₋ and fixes L₀
pointwise; (θU)_ℓ := U_{θℓ}, orientations preserved since θ maps e₁ to e₂). Then ∫ \overline{F(θU)} F(U) dμ ≥ 0 for every bounded
F depending only on L₊ ∪ L₀. The same holds across {x_j = ±x_k} for every pair j ≠ k (compose with coordinate permutations
and a sign change).
PROOF. Classify plaquettes by d = x₁ − x₂ of their base point x. (1,2)-plaquettes: all four links in L₊ if d ≥ 1, in L₋ if
d ≤ −1; at d = 0 the links (x, x+e₁), (x+e₁, x+e₁+e₂) lie in L₊ and (x, x+e₂), (x+e₂, x+e₁+e₂) in L₋, and θ maps the first
path X onto the second, Y = X∘θ; U_p = XY⁻¹. (j,3)- and (j,4)-plaquettes (j = 1, 2) have all their links in L₊ ∪ L₀ or all
in L₋ ∪ L₀ (checked case by case: e.g. a (1,3)-plaquette at d = 0 has its 3-link at x in L₀ and its other links in L₊; at
d = −1 its 3-link at x + e₁ is in L₀ and the others in L₋), and θ maps the first kind onto the second. (3,4)-plaquettes lie in
L₊, L₋, or (d = 0) entirely in L₀; split the latter weight as (e^{(β/2)Reχ})², assigning one factor to each side. So
μ ∝ e^{A₊}·e^{A₊∘θ}·Π_{d=0 (1,2)-plaq.} e^{βReχ(XY⁻¹)}, A₊ depending on L₊ ∪ L₀. Expand e^{βReχ(g)} = Σ_r c_r χ_r(g): c_r ≥ 0
because (Re χ)ⁿ = 2⁻ⁿ(χ + χ̄)ⁿ decomposes into irreducible characters with nonnegative multiplicities. And χ_r(XY⁻¹) = Σ_{ab}
D^r_{ab}(X)\overline{D^r_{ab}(Y)} by unitarity, with Y = X∘θ. Multiplying out over the bisected plaquettes,
∫\overline{F∘θ}F dμ = Z⁻¹ Σ_{(r,a,b)} (Πc_r) ∫dU_{L₀} |∫dU_{L₊} F e^{A₊} Π D^r_{ab}(X)|² ≥ 0, using Haar invariance under U_{L₋} =
θU_{L₊} and the reality of A₊. ∎ (On a torus the diagonal reflection has a second invariant set, x₁ − x₂ ≡ N/2, which this
proof does not treat; boxes and their limits suffice for the continuum statement.)

ROUTE RP (Alpöge–Sussman's "RP trick"). Their manuscript RPM1 (2026, AI-written, correctness "not satisfactorily verified" by
its authors; read today at the level of its README and TeX source: abstract, Theorem A, proof outline) claims: a translation-
invariant random distribution with a Glimm–Jaffe growth bound ∫e^{F(χ)}dμ ≤ e^{C(‖χ‖₁ + ‖χ‖₂²)} that is reflection positive
across every coordinate hyperplane AND every diagonal hyperplane {x_j ± x_k = 0} is O(d)-covariant away from coincidences, for
tensor fields of planar weight ≤ 2. Outline (as stated there): RP across t = 0 and across t + x = 0 gives H ≥ |P|, which allows
complex translations; a Glaser-type lemma continues the positive form; the growth bound limits the angular Fourier modes of the
rotated Schwinger functions to |ℓ| ≤ 3N, quarter-turns to ℓ ∈ 4ℤ; a convexity inequality 2M_{a+b} ≤ M_{2a} + M_{2b} and the 45°
symmetry of the reflection family force M_{2a} ∈ 8ℤ, and every nonzero frequency vanishes. EVALUATION. (i) The lattice input
the route needs is Theorem 9.1 (diagonal RP), now PROVED; RP passes to limits, and translation invariance spreads it to all
parallel diagonal hyperplanes. (ii) The growth hypothesis FAILS for the action density in d = 4: ⟨tr F²(x) tr F²(0)⟩ ~
c|x|⁻⁸(log|x|)⁻² is not locally integrable in ℝ⁴, so F(χ) has infinite variance for χ ≥ 0 not vanishing at coincidences;
gradient-flowed fields satisfy growth bounds but are not exactly reflection positive. So RPM1 does not apply as stated. (iii)
In its outline the growth bound enters only through the frequency bound. A version of Theorem A with the growth condition
replaced by the corpus's (E0) on tuples with disjoint supports would make (E2) a COROLLARY of Theorem 9.1 + translation
invariance + (E0) — no universality, no infrared input. A plausibility check done here: the D₄-symmetric Gaussian field with
covariance Σ of the three "metrics" p₁²+p₂², p₁²+4p₂², 4p₁²+p₂² (plus m²) is reflection positive across the axes but NOT
across the diagonals (in diagonal coordinates the two anisotropic terms carry phases e^{±i(3/5)p_⊥x_∥}, and the kernel
e^{−E(s+t)}cos(a(s+t)) is not positive definite) — diagonal RP does kill metric anisotropy that axis RP and D₄ allow.
ROUTE W (the Ward identity; the 4D draft's clause (vi), THE GROUND §6.2): "if the flux of the lattice rotation current through
far spheres vanishes along one sequence of radii, uniformly in the cutoff, then every limit on ℝ⁴ taken along cutoffs that
grow fast enough compared with the volume is invariant under O(4)" — a conditional deduction in an unvetted draft. Its
infrared input is a decay statement for the rotation current x_μT_ρν − x_νT_ρμ: exponential clustering of the renormalized
stress tensor's correlations, uniformly in the cutoff, which the gap supplies once the stress tensor's renormalization is
controlled uniformly (Theorem 8.5 covers bounded observables; T_μν at fixed cutoff has norm ~ a⁻⁴).

| Route | Ultraviolet input | Infrared input | Status |
|---|---|---|---|
| C — commensurable rotation (this file) | E1's two-lattice argument + skew single step + Lemma Σ_χ | Hypotheses I (sup form), II for the original; (F2-Lip); (E1) | reduction PROVED; inputs OPEN |
| W — Ward identity (A–S clause (vi)) | a lattice rotation current; dimension-six anomaly → 0 | uniform exponential clustering of T_μν (the gap) | deduction in an unvetted draft |
| RP — diagonal RP (RPM1 + Theorem 9.1) | (E0)-type regularity only | none | needs RPM1's Theorem A with (E0) in place of the growth bound |

## 10. LITERATURE (e) — WHAT EXISTS, CREDITED

- The group theory: Cartan's closed-subgroup theorem; the finite subgroups of O(4) (Du Val 1964; Conway–Smith, On Quaternions
  and Octonions, 2003); Aut(F₄) of order 2304 with W(F₄) of index 2 (Koca et al., quaternionic constructions of the W(F₄)
  polytopes); Niven, Irrational Numbers (1956). The statement "the closed overgroups of W(B₄) are W(B₄), W(F₄), Aut(F₄) and
  O(4)" was not found stated in the sources searched; its 3D analogue (O_h maximal finite in O(3)) is classical.
- Rotation invariance of lattice continuum limits, rigorous: where the limit is identified with a manifestly invariant
  continuum regularization (P(φ)₂: Guerra–Rosen–Simon, Ann. Math. 101 (1975); φ⁴₃: Park 1977); where the limit is Gaussian (a
  B₄-invariant quadratic form is isotropic — free fields; the scaling limits in Aizenman–Duminil-Copin's φ⁴₄ triviality); and in
  2D integrable models (Smirnov; Chelkak–Smirnov 2012; Duminil-Copin–Kozlowski–Krachun–Manolescu–Oulamara 2020, arXiv
  2012.11672, FK percolation with 1 ≤ q ≤ 4: the square lattice is morphed into isoradial (in effect rotated) lattices by
  star–triangle moves — the closest analogue of comparing differently oriented lattices, with Yang–Baxter where this file uses
  the renormalization group). Physics: Symanzik's improvement (O(a²) rotation breaking by dimension-six operators); Davoudi–
  Savage, PRD 86 (2012) 054505; M. Douglas's pphi2 Lean project (rotation via a Ward-identity anomaly bound, left as an axiom).
- Gauge theory: Alpöge–Sussman 2026 (unvetted): RPM1 and the 4D draft's clause (vi) (§9). Bałaban's papers do not treat
  rotation invariance. The commensurable-rotation reduction itself was not found in the literature searched; it is the
  trunk's (crossing campaign §21's request) completed here.
- Lorentz invariance as an infrared phenomenon: Nielsen–Ninomiya, Nucl. Phys. B 141 (1978) 153 (cited from memory; the search
  did not return it); Chadha–Nielsen, Nucl. Phys. B 217 (1983) 125 (confirmed bibliographically); Colladay–McDonald, PRD 75
  (2007) 105002 (equations (43), (44), (47) read via ar5iv) and their QCD sequel arXiv 0712.2055.
- Anisotropic lattice couplings: Karsch, Nucl. Phys. B 205 (1982) 285 (finite one-loop c_σ(ξ), c_τ(ξ)).
- RG pathologies: van Enter–Fernández–Sokal, J. Stat. Phys. 72 (1993) 879; van Enter–Fernández–Kotecký, hep-lat/9409016;
  Haller–Kennedy, mp_arc 95-505; Bertini–Cirillo–Olivieri, J. Stat. Phys. 97 (1999); Bricmont–Kupiainen–Lefevere (1998).
- Dobrushin's comparison theorem: Dobrushin 1970; Föllmer 1982; Georgii, Gibbs Measures and Phase Transitions, Thm 8.20.

## 11. EVERY COMPACT SIMPLE G (f)

Group-blind: Theorems 3.2, 3.3, 4.1, Lemma 5.3, Corollary 5.4 (spacetime symmetry only); Theorem 7.1, Corollary 7.2 and 7.6
(Dobrushin theory); Theorem 9.1 (every compact G: the Wilson weight's character coefficients are nonnegative). Group-dependent,
in exactly two places, the same two as the gap's: (1) the anisotropic row (§6.4) vanishes because g₀ → 0 — asymptotic
freedom, b₀ = 11C₂(G)/(48π²) > 0 for every compact simple G; the Weyl exponent 7/11 = (14/3)/(22/3) is the SAME for every G
(both coefficients ∝ C₂(G)); for U(1) nothing runs, the created O(e₀²) anisotropy does not vanish, and Route C's UV step does
not close (the U(1) Coulomb-phase limit is Gaussian, and a B₄-invariant quadratic form is isotropic, so (E2) holds there by a
different argument — the control the route's mechanism correctly fails). (2) Hypotheses I and II at the exit scale — the
crossover's group dependence (the drift c(β) of the One Flow theorem). (E2) by Route C asks nothing of G beyond what the gap
asks. Bałaban's single-step estimates (6.5) are carried by the program for SU(2).

## 12. THE LEDGER (this agent's rows)

| Item | Status | Where |
|---|---|---|
| Theorem 3.2 (closed overgroups of B₄: finite or O(4)) | PROVED | §3 |
| Theorem 3.3 (exactly three finite overgroups: 384, 1152, 2304) | PROVED + COMPUTED | §3, rec a |
| Theorem 4.1 (normalizer theorem: every admissible skew block has a Weyl-type marginal invariant) | PROVED + COMPUTED (6,827) | §4, rec b |
| q verified; every odd L admits an R | PROVED + COMPUTED | §5.2 |
| Lemma 5.3 (similarity trick), Cor 5.4 (λ = 1 from the gap) | PROVED | §5.3 |
| sandwich for the rotated pair; Lemma 6.2′ | PROVED (6.2′ at quadratic order + gauge invariance; 6.7) | §6.2 |
| scalar analogue of 6.2′ | COMPUTED, stake HELD, closed form met | §6.9, rec c |
| Theorem U's (K2) met by every skew step | PROVED | §6.3 |
| the anisotropic row (metric 0, Weyl −(14/3)C₂g²/(16π²)·log L per step) | mechanism PROVED at one-loop power counting; Lemma Σ_χ NAMED | §6.4 |
| E2-UV(T) | CONDITIONAL | §6.6 |
| Theorem 7.1 (averaged comparison), Cor 7.2, 7.6 | PROVED (7.2, 7.6 GIVEN their inputs) | §7 |
| vEFS: excluded by Hypothesis II for every v | PROVED (implication) + CITED | §7.5 |
| Theorem 8.1 ((E2)) | CONDITIONAL on (E1), (UV), (X), (IR) | §8 |
| Theorem 9.1 (Wilson's action RP across diagonal hyperplanes, every compact G) | PROVED | §9 |
| RPM1 route | needs Theorem A with (E0) growth; its growth hypothesis FAILS for tr F² in d = 4 | §9 |

## 13. THE PRECISE NEXT OBJECT

FIRST (highest leverage — it could make (E2) free): RPM1's Theorem A with the Glimm–Jaffe growth bound replaced by the
corpus's (E0) bound on test functions flat at the coincidence diagonals: read RPM1's frequency-bound step (|ℓ| ≤ 3N from
growth) line by line and decide whether an (E0)-type bound |S_n(φ)| ≤ C_n|φ|_8ⁿ on disjoint-support tuples bounds the
exponential type of the analytically continued angle dependence. With Theorem 9.1 this would give (E2) from translation
invariance + RP across coordinate and diagonal hyperplanes + (E0), with no infrared input. FALSIFIER: a step of RPM1 that uses
the growth bound at coincident points (e.g. a moment generating function of an unsmeared field).
SECOND (Route C's only genuinely new ultraviolet object): Lemma Σ_χ — CMP 119 (3.56)–(3.64) without W(B₄): carry the
anisotropic tensor coupling y_k ∈ (Sym²Λ²)^{G′} ⊖ ℝ·Id through Bałaban's step, prove the per-step map is (1 + O(g_k⁴)) on the
metric part and (1 − c_W g_k² + O(g_k⁴)) on the Weyl part with the normalized remainders irrelevant uniformly.

## 14. CROSS-FIELD UNIFICATIONS FOUND

(U1) LORENTZ INVARIANCE AS A LOW-ENERGY PHENOMENON IS THE ANISOTROPIC ROW OF THE RG COMPARISON. The Weyl-type deformation the
skew block must create (Theorem 4.1) is the Standard-Model-Extension coefficient k_F; Colladay–McDonald's one-loop running k_F ∝
(g²)^{−7/11} is the per-step contraction of that row; Nielsen–Ninomiya and Chadha–Nielsen's "Lorentz invariance emerges in the
infrared" is, inside a rigorous comparison, the statement that the comparison's extra marginal directions are less relevant
than the coupling. Asymptotic freedom kills rotation breaking twice (creation O(g₀²); no amplification), and the exponent 7/11
is group-independent. U(1), with no running, is the control.
(U2) THE ONLY NEAR-MISSES OF O(4) ARE THE 24-CELL'S SYMMETRIES. A B₄-invariant limit is O(4)-invariant or has symmetry W(B₄),
W(F₄) or Aut(F₄). The Coxeter degrees (2,4,6,8) for B₄ and (2,6,8,12) for F₄ say where rotation breaking first sits —
dimension-six artefacts on ℤ⁴, dimension-eight on an F₄-symmetric (D₄) lattice.
(U3) THE OBSTRUCTION LIVES IN THE BINARY TETRAHEDRAL GROUP. A rotation can be compared with the identity through a block with
full marginal symmetry only if it normalizes 2T, i.e. lies in ±[O×O]·2 — the same binary polyhedral groups (2T, 2O) that are
the finite gauge groups of THE GROUND's Proposition 8.3 and of the kernel's finite-group gap theorems.
(U4) DILATIONS ARE CENTRAL, SO SCALE DROPS OUT OF A SYMMETRY TRANSFER; A MASS PUTS IT BACK AS AN IDENTITY. The similarity trick
removes the non-perturbative Λ-matching between two block schemes; the gap then forces the matching (λ = 1) — a statement about
two renormalization schemes derived from symmetry plus a spectral fact.
(U5) THE INFRARED CONTENT OF EUCLIDEAN INVARIANCE IS CONTINUITY, NOT SYMMETRY. Through a commensurable rotation the infrared step
is Dobrushin's comparison — continuity of the Gibbs state in its specification, averaged under the comparison measure — and the
renormalization-group pathologies of vEFS are excluded by the same uniform fibre clustering (Hypothesis II) that the gap needs.
(U6) DIAGONAL REFLECTION POSITIVITY FOR GAUGE FIELDS. Theorem 9.1 extends to lattice gauge theory the diagonal reflections that
chessboard estimates use for spin systems (Fröhlich–Israel–Lieb–Simon); the bisected plaquettes' character expansion carries the
positivity. Diagonal RP is what forbids metric anisotropy that axis RP and the hypercubic group allow.

## 15. DATED PRECISIONS (2026-11-02, after §§0–14, from a reviewer's pass; nothing above edited)

15.1 THE DILATION CARRIES A FIELD NORMALIZATION (to Lemma 5.3, Cor. 5.4, Thm 8.1). Changing the renormalization condition
rescales lengths AND renormalizes the composite field (the action density's multiplier, M3b's m_K / the trace-anomaly
normalization). So the relation delivered by the comparison is S′_n(f) = c^n S_n(D_λ f) with some c > 0, not a pure
dilation of test functions. Replace Sim(4) by the group 𝒢 = ℝ_{>0}(field scale c) × ℝ_{>0}(dilation λ) × O(4), acting on an
n-point function by (c, λ, g): S_n ↦ c^n S_n((λ, g)·f). Both ℝ_{>0} factors are CENTRAL, so the conjugation of Lemma 5.3
removes c and λ together: (c, λ, k)⁻¹(1, 1, b)(c, λ, k) = (1, 1, k⁻¹bk), and the conclusion (O(4)-invariance) stands
verbatim. Cor. 5.4: with O(4) known, S is invariant under (c, λ, 1); for a finite family f put f′_n := c^n D_λ f_n; then
S(θf̄·τ_tf) = S(θf̄′·τ_{λt}f′), i.e. ⟨ψ_f, e^{−tH}ψ_f⟩ = ⟨ψ_{f′}, e^{−λtH}ψ_{f′}⟩, and the spectral argument gives λ = 1 as before;
then S_n = c^nS_n for all n, and a nonzero connected two-point function forces c² = 1, c = 1.

15.2 "E1-SCALE" IS A SEPARATE INPUT FROM M3f's E1 (to Thm 8.1 and the ledger). M3f's E1 (§6.6) is the convergence of W_K(τ)
along ONE tuning on a fixed torus, given (T_loc), (CB) and Theorem U's inputs. Theorem 8.1's input (E1) asserts more: that the
limits at DIFFERENT renormalization conditions form one (c, λ)-family, S_{X′} = c^n S_X∘D_λ, and that the limit does not depend
on the cutoff sequence. Name it (E1-scale): one-coupling universality across the tuning curve (the renormalized trajectory is
one curve parametrized by the scale, M3d's Proposition E1-b being its trajectory form) plus sequence independence. It is NOT
credited to M3f. Theorem 8.1 is CONDITIONAL on (E1-scale), E2-UV(T), (F2-Lip) and Hypotheses I–II at the exit scale.

15.3 WHICH INPUTS ARE SHARED AND WHICH ARE NEW. Shared with the gap: Hypotheses I and II at the exit scale, and the crossover
(F2) of which (F2-Lip) is a strengthening. Shared with E1: Theorem U's inputs, (T_loc), (CB), and (E1-scale)'s universality.
NEW for (E2): (A) Bałaban's single-step estimates for one periodic skew block (§6.5); (B) Lemma Σ_χ, the anisotropic marginal
row (§6.4). VERDICT: the reduction is PROVED; (E2) is CONDITIONAL on the inputs just named.
