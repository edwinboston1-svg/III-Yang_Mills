# MF — HYPOTHESIS II AT THE CROSSOVER: THE EXACT FORM THE CHAIN CONSUMES, ITS MEASUREMENT, AND ITS PROOF OR OBSTRUCTION

Proof agent MF, 2026-11-02 (desktop; read-only in both repositories; everything here is in this directory). Appended as the work
proceeds; nothing above a line is edited after it is written except by a dated correction below it.

## 0. Sources read before deriving

MATH_BRIEF.md (all); cross/ANSWER.md (all); THE GROUND revision 33, III-Yang_Mills source/ground/content4.js lines 88–214 (Hypotheses I
and II, Theorem 8.5 and its proof, Proposition 8.1′, the form (S), the local fluctuation ℓ_y, the matrix R_j (8.8b), Hypotheses I′ and
II′, Lemmas 8.5A–8.5B, Proposition 8.5C, Theorem 8.5D, Proposition 8.5E, Theorem 8.5′ and its proof, Proposition 8.4′, the closing
paragraph on what (S) and translation covariance cost); cross/ground_docx.txt lines 201–232 (Theorems 7.1, 7.4, Lemma 7.3, Corollary 7.2:
the Hilbert space is the OS completion of the construction's class of smeared gauge-invariant observables) and lines 300–345 (the block
map, (8.5), Hypothesis II as first stated, the block-criterion paragraph, the perfect cover); THE CROSSING CAMPAIGN §§20–22 (III DOCS,
lines 433–597: the reduction C ≤ δT/(1 − δ) and why pinned suprema close for gauge-covariant coarse links; the One Flow theorem and its
input table; the morning's regrouping, (II′) at the exchange named THE CORE); M5/WORK.md §§0–3 (Theorem 3.1: the fibre's off-path
conditionals are the bare single-link laws, row ≥ 18 L₁/I₁(2.2) = 13.2408); M2/WORK.md §§0, 3–8 (Theorem 3.1 = 8.5-L², Theorem 4.1 the
refusal of U(1), Lemmas 5.1, 7.1, the readings table of §6.4); M2R/REVIEW.md lines 255–300 (the structural fact: with the sharp holonomy
map II′(a) at large j is the clustering of μ_j itself); M2b/HANDBACK.txt (Theorem A1: no typical-environment form of a single-pair
criterion implies decay; Lemma A2); the instruments' headers: STDLIB/scripts/aperanton_fibre_cert.awk, aperanton_fibre_influence.awk,
aperanton_fibre_dss.awk (the Onsager-tower fibre, Ising), STDLIB/build/aperanton/surface-gas/w2_strip_n.c lines 1–200 (the two-face
object: pinned outside, wire formalism, plaquette weights entering as one array FAC[s] for every object plaquette).

## 1. The deep-think synthesis (before any derivation; the decision this file executes)

**What I expected.** A fibre criterion in L² (averaged over the blocked measure) that is small at β = 2.2 where the sup form is 13.24,
read on the two-face objects, then a route to prove it.

**What changed my mind (four facts, each checked at the desk before anything was computed).**
(i) THE FORM. Hypothesis II′ is not a smallness condition: at any finite coarse distance it is satisfied by a large K′. What it demands
is an exponential RATE log(1/ρ′) per coarse unit, uniform in the cutoff and the volume; ρ′ enters the mass, K′ only the prefactor. A
single-pair coefficient (the 13.24 row, or any averaged or L² version of it) is the input of a SUFFICIENT CRITERION for II, not II.
(ii) THE SCALE. By the law of total covariance and the tower property the fibre covariance telescopes over the blocking steps; for
observables measurable at a scale s only the fibres between s and a_c enter, and at s = a_c II′ holds identically. With the Hilbert
space defined (THE GROUND §7) as the OS completion of the construction's class, the fibre clause is needed exactly for the part of the
Hilbert space that coarse observables do not reach — THE FIBRE SECTOR — and II′ is precisely a bound on that sector's spectral weight
below log(1/ρ′)/a_c. Hypothesis I′ alone gives the gap on the coarse sector.
(iii) THE MECHANISM. The only known mechanism for fibre clustering is collective: the coarse constraint removes the slow modes and the
remaining fluctuations are massive at the block scale. For a Gaussian field it is exact, coupling-independent (the same rate for U(1)
at 1.2 and SU(2) at 2.2 linearised), and it depends on the COARSE MAP: a constraint that averages over a sub-box of dimension k in d = 4
gives a uniform rate iff k ≥ 3; the sharp holonomy map is a line integral (k = 1, perimeter self-energy) and loses uniformity like
L^{−1/2}; Bałaban's averaging keeps it. This is M2R's structural fact made quantitative, and it is measurable EXACTLY.
(iv) THE OBSTRUCTION. A1 (M2b) applies to the fibre as to any Gibbs measure: no criterion depending only on the law of single-pair
coefficients certifies decay, so a criterion for II′ must take the supremum over the fibre's own environments — and at β = 2.2 every
such supremum exceeds one (TV 13.24, M5; in L², at least 14·a_½(2.2), computed below). The fibre at one step from 2.2 contains the
β = 2.2 field itself; blocking further never removes it. So II′ at the crossover is as hard as clustering of the β ≈ 2.2 field given
its block averages, which no local criterion reaches — unless the observables never need it (the coarse sector, completeness).

**Decision.** (1) Item 1 at the desk, with proofs: the exact consumed form and its constants; THE SCALE LEMMA (telescoping) and its
corollaries (which fibres; s = a_c trivial); THE TWO-SECTOR THEOREM (I′ ⇒ gap on the coarse sector; the exact bound of the fibre-sector
component of every state by the two clauses of II′, giving a second proof of Theorem 8.5′'s gap that isolates what II′ is for); gauge
fixing inside blocks irrelevant for gauge-invariant observables. (2) Item 2: (a) the Gaussian fibre EXACTLY (Fourier/alias
decomposition, double precision, two roads: real-space sums and the complex zero of the constraint symbol) for the k-dimensional
sub-box family k = 0..4 (decimation, line ≈ holonomy, plane, codim-1, full block average ≈ Bałaban) and heat-kernel smearing, L = 2, 4,
8, 16, d = 2, 3, 4, with the abelian gauge field (photon) under the holonomy and the transverse-averaged maps; stakes first; (b) the
single-link L² obstruction number at 2.2, certified. (3) Item 3: each route weighed with the U(1) test; the Gaussian theorem proved
(Poincaré in each block + Combes–Thomas); fibre reflection positivity at symmetric data proved; the remaining obstruction named.

**Runner-up rejected.** Modifying the two-face engine to insert fine observables (per-plaquette weights) and read fibre influences at
coarse distance one at pinned data: the object pins the outside (the fibre average §20 says is the content), reads only adjacency (II′
is a rate, adjacency is absorbed by K′), and the bent geometry is still uncomputed there. It would read a number II′ does not contain.

**Confidence.** High on (i), (ii), the scale lemma and the two-sector bound; high on the Gaussian mechanism's L-scaling by the
signal-to-noise count (to be met by the exact runs); medium on the gauge-field correspondence at small L; low on any non-perturbative
statement at 2.2.

**Kill-switches.** The known answers of the Gaussian engine not met (d = 1 exact fibre, the constraint reproduced exactly, the sum rule
Σ_X K(x, X) = 1 for the block average); the full block average's rate FALLING with L like the line's (then the SNR count is wrong); the
two roads (real-space slope, complex zero) disagreeing by more than 1 %.

---

## 2. ITEM 1 — THE EXACT FORM THE CHAIN CONSUMES (THE GROUND §8.3's notation; proofs on the page)

**Setting.** As in Theorem 8.5′: rung j, coarse scale a_c, blocks B_y, block map v = (v_y), blocked measure λ_j of the form (S), fibre
ν_j(·|v), bounded observables f, g with supports S(f), S(g) (sets of coarse points), N(f) = |S(f)|, d = dist(S(f), S(g)) in coarse
units; F = ν_j(f|·), G = ν_j(g|·); A_j(f, g) := λ_j(ν_j(fg|·) − FG), the λ_j-mean of the SIGNED fibre covariance; ℓ_y(F) =
λ_j(Var_{λ_j}(F | v_{yᶜ}))^{1/2}; D = (I − R_j)⁻¹.

### 2.1 What Theorem 8.5′ consumes, and which constants enter the mass

**Proposition 2.1 (the consumed form).** (a) In the proof of Theorem 8.5′ Hypothesis II′ enters at exactly two places: |A_j(f, g)|
(clause (a)), and the pairing Σ_{x,y} ℓ_x(F) D(x, y) ℓ_y(G) of Theorem 8.5D (clause (b)). By the law of total covariance
A_j(f, g) = Cov_{μ_j}(f, g) − Cov_{λ_j}(F, G): clause (a) bounds the part of the true covariance that the coarse covariance of the fibre
means does not carry, with cancellations inside the λ_j-mean allowed (it is not λ_j|Cov_ν|).
(b) For given f and g the covariance inequality uses II′ for that f and that g only; Theorem 7.4 uses the inequality only for the pairs
(θf̄, τ_t f), t ∈ D, with f in the construction's class. Hence Theorem 8.5′ holds verbatim with Hypothesis II′ demanded only for f, g
in a class 𝒪 closed under θ and τ_t (t ∈ D), its conclusion then holding on the sector that 𝒪 generates; and for the gap only the
pairs (θf̄, τ_t f), f ∈ 𝒪, are needed.
(c) The mass is m = a_c⁻¹ min(κ, log(1/ρ′)). The fibre enters it only through ρ′, its exponential RATE per coarse unit; K′ and α enter
only the prefactor K. At any fixed distance II′ is satisfied by taking K′ large: **Hypothesis II′ is not a smallness condition. It is an
exponential rate, uniform in the rung and the volume.**
(d) Consequently a single-pair fibre coefficient (M5's row 13.24, or any L² or averaged version of it) is not a reading of II′. It is
the input of a sufficient criterion for II′ (a fibre Dobrushin condition), and its exceeding one refutes that criterion, not II′.
*Proof.* (a), (b): inspection of the proof of Theorem 8.5′ (content4.js lines 182–188) and of Theorem 7.4 (ground_docx.txt line 224):
the covariance split, the bound of its second term by II′(a), the bound of its first by Theorem 8.5D and II′(b), and Theorem 7.4's
hypothesis, a statement about S_j(θf̄ · τ_t f) − |S_j(f)|² for f in the class whose OS completion is the Hilbert space (THE GROUND §7:
"the vectors [f] are dense in H" by construction). (c): (8.8) and K's listed dependence. (d) is (c). ∎

### 2.2 THE SCALE LEMMA: the fibre clause telescopes over the blocking steps

Let the block map from the cutoff to a_c be the composition of n_j steps of side L (scales s₀ = a_j < s₁ < … < s_n = a_c), with
σ-algebras 𝒢₀ ⊃ 𝒢₁ ⊃ … ⊃ 𝒢_n, 𝒢_k generated by the scale-k block variables (the scale-(k+1) variables functions of the scale-k ones:
nested maps, which block averaging, holonomy maps and heat-kernel smearing all are). λ^{(k)} is the law of the scale-k field,
ν^{(k|k+1)}(·|w) the conditional law of the scale-k field given the scale-(k+1) field w, and ν_j(·|v) the conditional law of everything
given 𝒢_n.

**Lemma 2.2 (THE SCALE LEMMA).** For bounded f, g and F_k := E[f | 𝒢_k], G_k := E[g | 𝒢_k] (F₀ = f, F_n = F):

  A_j(f, g) = λ_j(Cov_{ν_j}(f, g | ·)) = Σ_{k=0}^{n−1} λ^{(k+1)}( Cov_{ν^{(k|k+1)}}(F_k, G_k | ·) ).

*Proof.* For each k the law of total covariance for 𝒢_{k+1} ⊆ 𝒢_k and the 𝒢_k-measurable F_k, G_k gives Cov(F_k, G_k) =
E[Cov(F_k, G_k | 𝒢_{k+1})] + Cov(F_{k+1}, G_{k+1}), since E[F_k | 𝒢_{k+1}] = F_{k+1} (tower property); Cov(F_k, G_k | 𝒢_{k+1}) is the
covariance under ν^{(k|k+1)} at the scale-(k+1) field, λ^{(k+1)}-almost everywhere. Summing over k telescopes to Cov(f, g) −
Cov(F_n, G_n), which by the law of total covariance for 𝒢_n is E[Cov(f, g | 𝒢_n)] = A_j(f, g). (Covariances bilinear,
Cov(u, w) = E[uw] − E[u]E[w], so the identity holds for complex observables.) ∎

**Corollary 2.3 (WHICH FIBRES).** If f and g are 𝒢_s-measurable — observables of the scale-s field — then F_k = f, G_k = g and the k-th
term vanishes for every k < s, so

  A_j(f, g) = Σ_{k=s}^{n−1} λ^{(k+1)}( Cov_{ν^{(k|k+1)}}(F_k, G_k | ·) ),   F = E[f | 𝒢_n] = ∫ f dν^{(s|n)}(· | v):

clauses (a) and (b) for such observables involve only the conditional law of the scale-s field given the scale-a_c field — the fibres
BETWEEN s AND a_c. The fibres below s never enter. At s = n (observables of the coarse field itself) II′(a) holds with zero and II′(b)
with K′ = √2 and every ρ′ ∈ (0, 1) (ℓ_y(f) = 0 for y ∉ S(f), ℓ_y(f) ≤ δ_y(f)/√2 ≤ √2‖f‖ for y ∈ S(f)). ∎

**Remark 2.4 (the deep steps are geometrically suppressed; a statement with its condition).** In the k-th term the supports of F_k and
G_k sit at distance d·L^{n−k−1} in units of the scale-(k+1) blocks. If every per-step fibre clusters at a rate ρ_k ≤ ρ < 1 per
scale-(k+1) block with constants bounded uniformly in k, and the means F_k are quasi-local at scale k with uniformly bounded constants
(the per-step form of clause (b)), the k-th term is O(ρ^{d L^{n−k−1}}) and the sum over k ≤ n − 2 converges uniformly in n_j. **So the
ultraviolet steps need only SOME uniform exponential rate, never a particular one, and the mass's fibre rate ρ′ is that of the LAST
step(s).** (Conditional on the two uniformities named; they are the per-step clauses, not proved here.)

### 2.3 THE TWO-SECTOR THEOREM: what the fibre clause is FOR

Work at one rung j on a torus with a time reflection θ through a block-boundary plane for which μ_j is reflection positive, and assume
the block structure is θ-compatible: 𝒱 = 𝒱₊ ∨ 𝒱₋ with 𝒱_± = σ(coarse variables of the blocks in the ±-half), 𝒱₊ contained in the
positive-time σ-algebra 𝒜₊ (the coarse variables block-local), θ𝒱₊ = 𝒱₋, and τ_{a_c} mapping positive-half blocks to positive-half
blocks. ℋ_j is the OS space (completion of 𝒜₊ under ⟨u, w⟩ = μ_j(θū · w)), [u] the class of u, Ω = [1], ψ_u = [u] − μ_j(u)Ω, and
𝒯 = e^{−a_c H_j} acts by 𝒯[u] = [τ_{a_c}u]. THE COARSE SECTOR is ℋ_c := closure{[w] : w ∈ L^∞(𝒱₊)} ∋ Ω; THE FIBRE SECTOR is ℋ_c^⊥.

**Theorem 2.5 (THE TWO SECTORS).**
(i) ℋ_c reduces 𝒯 (hence H_j).
(ii) Under Hypothesis I′ at rung j: ‖𝒯 restricted to ℋ_c ⊖ ℂΩ‖ ≤ e^{−κ}. **No fibre clause is used.**
(iii) For every f ∈ L^∞(𝒜₊), with F = E[f | 𝒱] and V₋(F) := λ_j(Var_{λ_j}(F | 𝒱₊)),

  ‖P_c^⊥ ψ_f‖² ≤ λ_j( Cov_{ν_j}(θf̄, f | ·) ) + V₋(F),

the two terms being clause (a) at the reflected pair and the L²(λ_j) part of the fibre mean carried by the coarse variables across the
plane (bounded through clause (b): V₋(F) ≤ (1 − ρ(R_j))⁻¹ Σ_{y ∈ −half} ℓ_y(F)²).
(iv) If for f in a class whose vectors span ℋ_j, λ_j(Cov_{ν_j}(θτ_t f̄, τ_t f)) + V₋(τ_t F) ≤ C_f e^{−2 m t} for t ∈ a_c ℕ, then
‖𝒯 restricted to ℋ_c^⊥‖ ≤ e^{−m a_c}; with (ii), ‖𝒯 restricted to Ω^⊥‖ ≤ max(e^{−κ}, e^{−m a_c}): the lattice gap is at least
min(κ, m a_c)/a_c. Hypothesis II′ gives the hypothesis of (iv) with e^{−m a_c} = ρ′ up to polynomial factors: **II′ is exactly a bound on
the spectral weight of the fibre sector, and the gap on the coarse sector needs nothing of the fibre.**

*Proof.* (i) τ_{a_c} maps L^∞(𝒱₊) into itself, so 𝒯ℋ_c ⊆ ℋ_c; 𝒯 is bounded, self-adjoint and positive (reflection positivity), so
ℋ_c^⊥ is invariant too, and the spectral projections of H_j = −a_c⁻¹ log 𝒯 commute with P_c.
(ii) For w ∈ L^∞(𝒱₊) depending on finitely many coarse variables (dense in L²(𝒱₊); u ↦ [u] is L²(μ_j)-continuous since
μ_j(θū u) ≤ μ_j(|u|²) by reflection positivity, Cauchy–Schwarz and θ-invariance, so these ψ_w span ℋ_c ⊖ ℂΩ):
⟨ψ_w, 𝒯^m ψ_w⟩ = Cov_{λ_j}(θw̄, τ_{m a_c} w). Theorem 8.5D under Hypothesis I′ bounds it by Σ_{x,y} ℓ_x(θw̄) D(x, y) ℓ_y(τw) ≤
2N(w)²‖w‖² e^{−κ m}/(1 − α), the ℓ's supported on θS(w) and τS(w), at coarse distance ≥ m. With μ_w the spectral measure of 𝒯 in ψ_w,
μ_w((r, 1]) r^m ≤ C_w e^{−κ m} for all m, so μ_w vanishes on (e^{−κ}, 1]; density gives (ii).
(iii) Put F₊ = E[f | 𝒱₊] ∈ L²(𝒱₊), so ψ_{F₊} ∈ ℋ_c, and h = f − F₊, of mean zero; ‖P_c^⊥ψ_f‖ ≤ ‖ψ_f − ψ_{F₊}‖ = ‖[h]‖. Condition on 𝒱:
μ_j(θh̄ h) = λ_j(Cov_ν(θh̄, h)) + λ_j(ν(θh̄|·) ν(h|·)). F₊ and θF̄₊ are 𝒱-measurable, so Cov_ν(θh̄, h) = Cov_ν(θf̄, f). Next ν(h|·) =
F − F₊ =: Δ and, θ preserving μ_j and 𝒱, ν(θh̄|·) = θΔ̄; |λ_j(θΔ̄ Δ)| ≤ ‖Δ‖²_{L²(λ_j)} = λ_j(|F − E[F|𝒱₊]|²) = V₋(F), since
E[F | 𝒱₊] = F₊ (tower). The bound on V₋ is Theorem 8.5D's variance inequality applied to λ_j(· | v₊) on the negative-half coordinates,
whose conditional maximal correlations are entries of R_j and whose local fluctuations average to ℓ_y(F)².
(iv) ‖P_c^⊥𝒯^m ψ_f‖² = ‖P_c^⊥ ψ_{τ_{m a_c} f}‖² ≤ C_f e^{−2 m′ m} with m′ = m a_c, and the left side is ⟨P_c^⊥ψ_f, 𝒯^{2m} P_c^⊥ψ_f⟩ =
∫ x^{2m} dμ_f^⊥ ≥ μ_f^⊥((r, 1]) r^{2m}; so μ_f^⊥ vanishes on (e^{−m′}, 1]. The P_c^⊥ψ_f span ℋ_c^⊥, giving the norm bound; combine with
(ii) and Ω ∈ ℋ_c. Under II′ the reflected pair sits at coarse distance ≥ 2t/a_c − 1, so its fibre covariance is ≤ K′N‖f‖²ρ′^{2t/a_c − 1},
and V₋(τ_t F) ≤ (1 − α)⁻¹K′²N²‖f‖² Σ_{y∈−half} ρ′^{2 dist(y, τ_t S(f))} = ρ′^{2t/a_c}·poly(t). ∎

**Corollary 2.6 (the limit, coarse sector).** If Hypothesis I′ holds uniformly in j and the construction's class contains the bounded
coarse-gauge-invariant functions of the coarse field (coarse loops of the averaged variables), then in every limit point the closed span
ℋ_c of their vectors reduces e^{−a_c H} — hence H — and H restricted to ℋ_c ⊖ ℂΩ has no spectrum in [0, κ/a_c). *Proof.* (ii)'s bound
⟨ψ_w, e^{−tH}ψ_w⟩ ≤ C_w e^{−κ t/a_c}, t ∈ a_c ℕ, is uniform in j and passes to the limit (Lemma 7.3 with D replaced by a_cℕ, unbounded);
Theorem 7.1's (c) ⇒ (a) argument runs inside the reducing subspace ℋ_c. ∎

**What 2.5–2.6 say about the continuum, exactly.** (1) The theory generated by observables of the coarse field at a_c (with a block map
whose coarse field has a non-trivial limit — Bałaban's averaging, or gradient-flow smoothing) has the gap κ/a_c from Hypothesis I′
alone. (2) The full local theory's gap is the smaller of the two sectors'. The fibre sector is spanned by P_c^⊥ψ_f for finer
observables f, and for f at scale s its control (both terms of (iii), and II′) involves only the fibres between s and a_c (Corollary
2.3). (3) So the gap of the full theory needs, besides Hypothesis I′, ONE of: (C) COMPLETENESS, ℋ_c = ℋ (a qualitative statement with
no constants: no observable finer than a_c creates a state invisible to every coarse observable); or (F) the fibre-sector bound (iv) for
a generating class — and for observables smeared at a fixed scale s ≥ a_x (the crossover's fine end) only the crossover fibres (one or
two steps from 2.2) enter; the ultraviolet fibres enter only for s < a_x, through the λ^{(k+1)}-mean of the per-step fibre covariances
(the form a small-field expansion delivers), with the geometric weight of Remark 2.4. (4) With THE GROUND's sharp holonomy map, (1)'s
theory is trivial in the limit (the coarse variables equidistribute, M2R), so everything sits in (F), and (F) is the gap itself.

**Proposition 2.7 (completeness holds for the free field — the sighted control for (C)).** For the free scalar field of mass m ≥ 0 in
ℝ⁴ (OS reconstruction), with coarse observables the box averages Φ(X) of side a_c on the grid a_c ℤ⁴ at positive coarse times, the
one-particle vectors of the Φ(X) span the one-particle space. *Proof.* A one-particle vector ψ′ orthogonal to all of them gives, with
g = conj(ψ̂′) ĥ/(2ω) ∈ L¹(ℝ³) (ĥ the spatial box kernel times (1 − e^{−ω a_c})/ω from the time average), Σ_{k∈ℤ³} g(p + 2πk/a_c)
z_k(p)^n = 0 for almost every p in the coarse Brillouin zone and every n ≥ 1, where z_k(p) = e^{−a_c ω(p + 2πk/a_c)} ∈ (0, 1). Off the
null set where two |p + 2πk/a_c| coincide the z_k are distinct and accumulate only at 0; dividing by the largest z^n and letting n → ∞
kills its coefficient, and induction kills every coefficient (dominated convergence, Σ_k |g(p + 2πk/a_c)| < ∞ a.e.). So g = 0 a.e., and
ψ̂′ = 0 off the null zero set of ĥ. ∎ (The Fock extension runs the same alias separation on the sums ω₁ + … + ω_r.) For U(1) this shows
(C) is not where U(1) fails: Hypothesis I′ fails there (M2's Theorem 4.1), as it must.

### 2.4 Gauge fixing inside blocks

**Proposition 2.8.** For a gauge-invariant f and a coarse variable v_y that is gauge covariant (transforming only through the values of
a gauge transformation at the coarse sites, as the holonomy along a fixed path does), ν_j(f | v) depends only on the coarse gauge class
of v and not on how the remaining links are coordinatised; so clauses (a) and (b) for gauge-invariant observables do not depend on the
gauge fixing T inside blocks. The construction's Hilbert space is generated by gauge-invariant observables (Theorem 7.4), so the chain
needs II′ only for them. *Proof.* For a gauge transformation g, f∘g = f, μ_j∘g = μ_j and v∘g = g·v (coarse action); hence
ν_j(f | g·v) = ν_j(f | v), and the conditional law of the fine links given v is defined without reference to T. ∎ (For Bałaban's
averaging the gauge T is part of the DEFINITION of v and enters through v alone.)

### 2.5 The answer to item 1, in one place

The chain consumes, at the crossover, the rate ρ′ of the λ_j-averaged fibre covariance of gauge-invariant observables and of the L²
dependence of their fibre means on distant coarse variables (Prop. 2.1), uniformly in the rung and the volume; the mass is
min(κ, log 1/ρ′)/a_c. It needs it only for the observables whose states reach the fibre sector (Thm 2.5), and for observables at scale
s only the fibres between s and a_c (Cor. 2.3). The weaker form that suffices for the continuum gap is: Hypothesis I′ plus EITHER
completeness of the coarse sector (C) OR the fibre-sector bound (F) for observables smeared at one fixed physical scale s ≤ a_c whose
vectors generate the theory. For s ≥ a_x, (F) is a statement about the crossover fibres alone — one or two steps from 2.2 — and the
ultraviolet fibre never enters; for s < a_x it adds the ultraviolet per-step fibres in averaged form, needing only some uniform rate
(Rem. 2.4).

---

## 3. ITEM 2 — THE MEASUREMENT

### 3.0 What can be read exactly, and what cannot (decided before any run)

Hypothesis II′ is a rate (Prop. 2.1(c)). Reading it on SU(2) at β = 2.2 needs the fibre averaged over the coarse measure at coarse
distance ≥ 2, i.e. at least three blocks in a row with their whole fine content integrated against the true law of the outside: in 4D
at L = 2 that is a lattice of ≥ 2·2·2·6 sites, 4·48 = 192 SU(2) links integrated exactly — out of reach of every engine in the tree (the
two-face engine integrates ≤ 40 links with the outside PINNED, and pinning is exactly what §20 showed discards the content). So the
crossover fibre at 2.2 has NO exact reading, and none is claimed. What IS exact:
(A) the GAUSSIAN fibre — the linearised fibre of every theory, the whole fibre of the free field — for every block map, every L, every
d, by an alias (Bloch) decomposition: the fibre's collective rate as a function of the coarse map and the block size, the U(1) control
included (§3.1–3.3);
(B) the single-pair coefficients of the SU(2) fibre at 2.2 in the L² currency (the ess-sup form, exact; §3.4) — the right comparison for
"the sup form is 13.24", and by A1 not a reading of II′.

### 3.1 The Gaussian fibre engine (gfib.c, this directory)

Massless lattice field on ℤ^d, Ĉ(p) = 1/λ(p), λ(p) = Σ_μ 2(1 − cos p_μ). Coarse variable Φ(X) = Σ_z q(z) φ(LX + z) with kernel q:
dec (q = δ₀), box_k (average over the k-dimensional sub-box {0..L−1}^k × {0}^{d−k}), heat:c (q = e^{tΔ}(·, 0), t = cL²). Fine momenta
p_n(K) = (K + 2πn)/L, K the coarse momentum, n ∈ {−L/2+1, …, L/2}^d the aliases; S(K) = Σ_n |q̂(p_n)|² Ĉ(p_n). The fibre covariance
(independent of Φ — Gaussian) between LX + a and LY + b is N^{−d} Σ_K e^{iK(X−Y)} T_ab(K) with, the n = 0 alias treated in closed form
(c₀ = 1/λ₀, w₀ = q̂(p₀), S′, u′ and R′ the sums over n ≠ 0),

  T_ab = R′_ab + [e^{ip₀(a−b)} S′ − e^{ip₀a} w̄₀ ū′_b − u′_a e^{−ip₀b} w₀ − λ₀ u′_a ū′_b] / (|w₀|² + λ₀ S′),

regular at K = 0 (no large cancelling terms). ROAD A: the transverse-summed fibre covariance Σ_{Y_⊥} C_fib(a, L(D e₁ + Y_⊥) + a), the
K_⊥ = 0 sector, by the sum over M₁ values of K₁ (an analytic periodic summand: exponentially accurate), its decay rate per coarse unit
read from successive ratios. ROAD B: the smallest κ > 0 with Den(iκ, K_⊥) = |w₀|²(K) + λ₀S′(K) continued analytically
(|q̂|² → q̂(p)q̂(−p), even in K₁, so real on the imaginary axis) equal to zero, by bisection, scanned over K_⊥. The fibre mean's kernel
E[φ_x | Φ] = Σ_X 𝒦(x, X)Φ(X) has the same denominator, so II′(b)'s rate is road B's κ too.
KNOWN ANSWERS (the engine is not read until they are met): K1 d = 1, dec: the fibre is a chain of independent discrete Brownian bridges —
C_fib = 0 across blocks, a(L − b)/L within (a ≤ b); K2 the constraint reproduced: Σ_z q(z) C_fib(LX + z, y) = 0; K3 the sum rule
Σ_X 𝒦(x, X) = 1 (the constant coarse field has the constant fibre mean); K4 roads A and B agree to 1 %; K5 THEOREM G(a) (§5.1, proved): for
box_d, |C_fib(x, y)| ≤ (2/g_L) e^{−η_L |X₁ − Y₁|}, g_L = 2 − 2cos(π/L), η_L = log(1 + g_L/2) — a reading below the proved rate convicts
the instrument (law 4).

### 3.2 THE STAKES (written 2026-11-02 before the engine exists; none edited after)

κ(L) is the fibre's decay rate per coarse unit (the slowest over K_⊥ and over the coordinate directions).
- S1 (d = 4, box_4, the full block average ≈ Bałaban's): κ(2) ∈ [1.0, 3.5]; UNIFORM: κ(16)/κ(2) ∈ [0.7, 1.3]; κ(L) ≥ η_L everywhere.
- S2 (d = 4, dec): κ(L) ∝ L^{1−d/2} = 1/L: κ(16)/κ(2) ∈ [0.08, 0.2].
- S3 (d = 4, box_1, the line ≈ the holonomy map's scaling): κ ∝ L^{−1/2}: κ(16)/κ(2) ∈ [0.25, 0.5].
- S4 (d = 4, box_2, codimension 2): κ ∝ (log L)^{−1/2}: κ(16)/κ(2) ∈ [0.45, 0.9] (UNGUESSED within the band).
- S5 (d = 4, box_3, codimension 1): uniform: κ(16)/κ(2) ∈ [0.7, 1.3].
- S6 (d = 4, heat:1/8): uniform: κ(16)/κ(2) ∈ [0.7, 1.4].
- S7 (d = 2): dec κ ∝ (log L)^{−1/2}: κ(16)/κ(2) ∈ [0.4, 0.85]; box_2 uniform [0.7, 1.3].
- S8 (d = 3): dec κ ∝ L^{−1/2}: [0.25, 0.5]; box_1 (codim 2) log: [0.45, 0.9]; box_2 (codim 1) uniform [0.7, 1.3].
- S9 (the rule): uniform iff the averaged sub-box has codimension ≤ 1 (k ≥ d − 1); logarithmic at k = d − 2; power L^{−(d−2−k)/2} below.
- S10 (the coupling, a theorem not a run): the Gaussian fibre covariance scales as 1/β, so κ is the same for U(1) at 1.2 (Villain
  spin-wave) and SU(2) at 2.2 linearised: the Gaussian fibre does not see the group.

### 3.3 RESULTS — the Gaussian fibre (records rec/kat.2026-11-02a.txt, rec/d4_box4*.txt, rec/batch1.2026-11-02a.txt, rec/photon.2026-11-02a.txt; engines gfib.c, photon.c; double precision, READINGS on two roads unless marked PROVED)

**Known answers, all MET before any reading.** K1 (d = 1, dec, L = 4): C_fib(a, a) = 0.75, 1.00, 0.75 = a(L − a)/L, C_fib(1, 3) = 0.25, every
cross-block entry ≤ 5·10⁻¹⁷ — the independent bridges. K2: |Σ_z q(z) C_fib(z, y)| ≤ 8·10⁻¹⁸ against entries of 0.06–0.31 (d = 2, 3, 4).
K3: Σ_D 𝒦₀(D) = 1.000000000000006 / …005 / …008 / …008 / …006 for box2 (d = 2), box4 (d = 4), box1 (d = 4), dec (d = 3), heat (d = 4). K4:
roads A and B agree to 6–9 digits in every cell where both read (e.g. d = 4 box4 L = 16: 1.323724 / 1.323723772; d = 4 dec L = 16:
0.159063 / 0.159064541). K5: every reading is above the proved Combes–Thomas rate η_L of Theorem G (1.7627 ≥ 0.6931 at L = 2;
1.3237 ≥ 0.0190 at L = 16). Photon: at L = 1 (coarse data = every plaquette) the fibre covariance is ≤ 4·10⁻¹⁸.

**THE TABLE (κ = decay rate per coarse unit of the fibre covariance, the slowest sector read; ρ′ = e^{−κ}).**

| map | d | L = 2 | L = 4 | L = 8 | L = 16 | L = 32 | law |
|---|---|---|---|---|---|---|---|
| block average (box_d), every d | 2, 3, 4 | 1.762747 | 1.425417 | 1.344024 | 1.323724 | 1.318649 | **cosh κ = 2 + 3/(L² − 1) EXACTLY (Thm 3.1), κ_∞ = log(2 + √3) = 1.316958** |
| decimation | 4 | 1.320925 | 0.651223 | 0.319785 | 0.159065 | — | κL → G₄(0)^{−1/2} = 2.5405 (2.642, 2.605, 2.558, 2.545) |
| decimation | 3 | 1.717661 | 1.123082 | 0.746110 | 0.511811 | — | κ√L → G₃(0)^{−1/2} = 1.9891 (2.429, 2.246, 2.110, 2.047) |
| decimation | 2 | 2.292432 | 1.946393 | 1.640001 | 1.438773 | 1.297028 | κ² log L → 2π (3.64, 5.25, 5.59, 5.74, 5.83) |
| line (box1), transverse decay | 4 | 1.717661 | 1.123082 | 0.746110 | 0.511811 | — | = decimation in d = 3 (Lemma 3.2) |
| plane (box2), transverse decay | 4 | 2.292432 | 1.946393 | 1.640001 | 1.438773 | — | = decimation in d = 2 (Lemma 3.2) |
| codim-1 (box3), in-box decay | 4 | 1.991794 | 1.817650 | 1.796311 | 1.792294 | — | uniform; transverse decay below 10⁻¹¹ by D = 4 (decimation in d = 1: bridges) |
| heat kernel, t = L²/8 | 4 | 1.034680 | 0.779965 | 0.730565 | 0.718897 | — | uniform, → 0.716 |
| **photon, holonomy map (flat-square fluxes)** | 4 | **1.717662** | **1.123083** | **0.746109** | **0.511829** | — | **= decimation in d = 3 to 6 digits: κ ∝ L^{−1/2}, NOT UNIFORM** |
| **photon, averaged fluxes (Bałaban-type)** | 4 | **3.541** | **5.280** | **≈ 5.98** | **≈ 6.2–6.4 (C₀(1) = 10⁻⁶ C₀(0))** | — | **saturates the alias bound L·arccosh(2 − cos 2π/L) = 3.525, 5.268, 5.983, 6.204 → 2π** |

(The K_⊥ scan on the grid {0, π/2, π}³ for box4 at L = 2, 4, 8 put the slowest sector at K_⊥ = 0 on the line Re K = π; the decay
alternates in sign, (−1)^D e^{−κD}. The local (untransverse-summed) correlator on a 16⁴ coarse torus decays at the same rate with the
D^{−3/2} prefactor of a three-dimensional transverse integral: log-ratios 1.84, 2.19, 2.00, 2.00 at D = 4–7 against 1.7627 + 1.5/D.)

**Theorem 3.1 (THE EXACT RATE OF THE BLOCK-AVERAGED GAUSSIAN FIBRE; PROVED, the residue's non-vanishing READ).** For the massless
lattice field on ℤ^d, any d ≥ 1, with block averages over cubes of side L ≥ 2, the zero-transverse-momentum sector of the fibre
covariance (and of the fibre-mean kernel 𝒦) decays along each axis as (−1)^D e^{−κ_L D}, with

  cosh κ_L = 2 + 3/(L² − 1):   κ₂ = arccosh 3 = log(3 + 2√2) (ρ′ = 3 − 2√2 = 0.1716),   κ_∞ = arccosh 2 = log(2 + √3) (ρ′ = 2 − √3 = 0.2679).

*Proof.* (1) At K_⊥ = 0 the box kernel's transverse factor (1/L)Σ_z e^{ip_μ z} vanishes at p_μ = 2πn_μ/L for n_μ ≠ 0, so only the
aliases with n_⊥ = 0 enter S and U, and for them λ(p) = 2(1 − cos p₁): the problem is the d = 1 chain. (2) In d = 1,
|q̂(p_n)|² = sin²(K/2)/(L² sin²(p_n/2)) and λ(p_n) = 4 sin²(p_n/2), so S(K) = (sin²(K/2)/4L²) Σ_{n=0}^{L−1} sin^{−4}((K + 2πn)/2L).
From Σ_{n=0}^{L−1} sin^{−2}(x + πn/L) = L² sin^{−2}(Lx) and (sin^{−2})″ = 6 sin^{−4} − 4 sin^{−2}, differentiating twice gives
Σ_n sin^{−4}(x + πn/L) = L⁴/sin⁴(Lx) − (2/3)L²(L² − 1)/sin²(Lx), hence

  S(K) = [2L² + 1 + (L² − 1) cos K] / (12 sin²(K/2)).

(3) The regularised denominator of T_ab and of 𝒦 is Den = |w₀|² + λ₀S′ = λ₀ S = 4 sin²(K/2L) S(K), whose only zeros in the strip
|Im K| < L·arccosh(2 − cos(2π/L)) (below every alias pole) are those of the bracket: cos K = −(2L² + 1)/(L² − 1), i.e.
K = π ± iκ_L. (4) The residue there does not vanish: road A's real-space slopes equal κ_L to 6–9 digits at L = 2, 4, 8, 16, 32 (READ). ∎
**Cross-field identity (the unification this theorem carries).** The fibre mean of the massless field given its block averages is the
lattice HISTOPOLATING SPLINE, and κ_∞ is the decay of Schoenberg's cardinal cubic spline: cubic interpolation's coefficients obey
c_{k−1} + 4c_k + c_{k+1} = 6y_k, whose Euler–Frobenius polynomial z² + 4z + 1 has the root z = −(2 − √3) — the sign is the alternation,
|z| is ρ′_∞. The lattice formula cos K = −(2L² + 1)/(L² − 1) is the discrete-spline Euler–Frobenius root. Bałaban's and
Gawędzki–Kupiainen's "fluctuation field massive at the block scale" is, for the block average, exactly the exponential localisation of
cardinal spline interpolation.

**Lemma 3.2 (DIMENSIONAL REDUCTION; PROVED).** For the sub-box map box_k (average over {0..L−1}^k in directions 1..k), the sector of zero
coarse momentum along the k box directions is EXACTLY the fibre of the massless field on ℤ^{d−k} under decimation with the same L.
*Proof.* At K_μ = 0 in a box direction the factor (1/L)Σ_z e^{ip_μ z} kills every alias with n_μ ≠ 0 and equals 1 at n_μ = 0, where
p_μ = 0; so S and U are sums over the (d − k)-dimensional aliases of 1/λ_{d−k}, the decimation sums in d − k dimensions. ∎
Consequences, all met by the table: a sub-box of codimension c = d − k behaves, transverse to itself, as decimation in c dimensions —
c = 1: bridges, no constrained-sector decay at all (the rate is the alias bound); c = 2: κ² log L → 2π; c ≥ 3: κ ≈ G_c(0)^{−1/2} L^{1−c/2}
(Poisson: S(K)/L^c = G(0) + L^{2−c}(1/K² + O(1)), zero at K² = −L^{2−c}/G(0)). **So a coarse map gives a fibre uniformly massive at the
block scale iff it averages over a set of codimension ≤ 1.** THE HOLONOMY MAP IS THE LINE: the coarse link variable is the line sum of
A_μ along μ, a decimation in the other three directions at zero momentum along μ — hence the photon's holonomy-map rates equal the
three-dimensional decimation rates digit for digit, κ ≈ 1.99/√L → 0: the perimeter self-energy of the sharp Wilson line, in the
fibre's language. The averaged (codimension-0) map leaves only the trivial alias modes.

**The stakes, graded (as written in §3.2, none edited).**
- S1 HELD: κ(2) = 1.7627 ∈ [1.0, 3.5]; κ(16)/κ(2) = 0.751 ∈ [0.7, 1.3]; κ ≥ η_L everywhere.
- S2 HELD: κ(16)/κ(2) = 0.120 ∈ [0.08, 0.2] (the law 1/L, κL → 2.54).
- S3 HELD: the line, transverse decay, κ(16)/κ(2) = 0.511811/1.717661 = 0.298 ∈ [0.25, 0.5] (in-line decay 0.516/1.705 = 0.303).
- S4 HELD: the plane, slowest direction, κ(16)/κ(2) = 1.438773/2.148842 = 0.670 ∈ [0.45, 0.9] (transverse alone 0.628). K4 BORDERLINE in this one cell family: at L = 2 the in-plane decay reads 2.1488 on road A against 2.1690 on road B (0.9 %, an off-line zero pair that road B, scanning Re K ∈ {0, π}, does not see); road A, the correlator itself, is taken; at L ≥ 4 the roads agree to 0.2 % and better.
- S5 HELD: codimension 1, in-box decay κ(16)/κ(2) = 1.792294/1.991794 = 0.900 ∈ [0.7, 1.3]; the transverse decay is below 10⁻¹¹ by D = 4 at every L (the bridges of Lemma 3.2).
- S6 REFUTED AS STAKED, by 0.005: κ(16)/κ(2) = 0.718897/1.034680 = 0.695 < 0.7. The heat-kernel rate does converge (0.716; uniform), but
  falls by 30 % from L = 2 to the limit; the band's low end was set too high.
- S7 HELD: decimation 0.628 ∈ [0.4, 0.85]; block average 0.751 ∈ [0.7, 1.3].
- S8 HELD: decimation 0.298 ∈ [0.25, 0.5]; box1 transverse (codim 2) 0.628 ∈ [0.45, 0.9]; box2 in-plane (codim 1) 0.900 ∈ [0.7, 1.3].
- S9 HELD and SHARPENED into Lemma 3.2 (an exact reduction, not a scaling guess).
- The photon runs had no numerical band written in §3.2; their stake is §1 (iii), written before any run: "the sharp holonomy map … loses
  uniformity like L^{−1/2}; Bałaban's averaging keeps it" — HELD on both halves (holonomy κ(L)/κ(L/2) = 0.654, 0.664, 0.686 → 0.707;
  averaged: the rate rises to the alias bound, better than uniform).

**What this answers in item 2.** (1) "Is II′ small where the sup form is 13.24?" In the only currency in which II′ is a number — its
rate — the linearised fibre at one and two steps (L = 2, 4) has ρ′ = 0.180 / 0.325 (holonomy map), 0.029 / 0.005 (averaged map),
0.172 / 0.240 (scalar block average): a positive rate, and β-INDEPENDENT (Gaussian scaling), so the same for U(1) at 1.2 and SU(2) at 2.2
linearised. The 13.24 measures single-site criteria, which fail (§3.4); the collective rate exists. (2) Block size: the holonomy map
loses uniformity (κ ∝ L^{−1/2}: the ultraviolet blocks of size a_c/a_j → ∞ make its fibre carry the long modes, which is M2R's structural
fact made exact); averaging and heat-kernel smearing keep it. At the crossover's own L = 2 and 4 every map gives an O(1) rate. (3) Coarse
map: uniform iff the averaged set has codimension ≤ 1 (Lemma 3.2). (4) Gauge fixing inside blocks: irrelevant for gauge-invariant
observables (Prop. 2.8), which are all the chain needs.

### 3.4 RESULTS — the single-pair coefficients of the SU(2) fibre at 2.2 in L² (records rec/adversary.2026-11-02a.txt; ahalf.awk)

**Proposition 3.3 (the L² single-pair row of the fibre at β; PROVED, number CERTIFIED).** With M5's link e (off every coarse path) and
an axial gauge fixing every direction-4 link (the worst case), for each of the 14 free staple links b of e the fully adversarial pair
environment — e's five other staples summing to zero AND b's five other staples summing to zero — is realisable inside the fibre (each
of the ten staples has a private free off-path link: adversary.c checks all 14 at a_c = 2, 3, 4, "realizable for 14 of them"). There
the joint conditional law of (U_e, U_b) is ∝ exp((β/2) tr(U_e U_b C)), a convolution kernel whose maximal correlation is its top
non-trivial Peter–Weyl coefficient a_½(β) = I₂(β)/I₁(β). The maximal correlation is continuous in the environment and the fibre
density positive, so the ess-sup R_fib(e, b) ≥ a_½(β), and the fibre's L² row at e is at least 14 a_½(β) (18 a_½(β) when no staple
link is fixed). Certified (positive-term series, directed rounding at 256 bits, geometric tail): **a_½(11/5) ∈ [0.464479025270421,
0.464479025270421]; 14 a_½ = 6.502706353786; 18 a_½ = 8.360622454868** (known answers met: a_½(10⁻³) = 0.00024999999 ≈ β/4;
a_½(0.4764) = 0.117989464, the record's). The single-pair L² criterion holds only below β ≈ 0.22–0.29 (14 or 18 a_½ = 1), against
the TV form's 0.13103 (M5).
**Its meaning.** The L² currency halves the sup form (6.50 against 13.24) and does not rescue it; by A1 no averaged single-pair
criterion could decide II′ anyway. The single-pair coefficients of the fibre are not small at 2.2 in any currency; the fibre's
COLLECTIVE rate (§3.3) is.

---

## 4. ITEM 3 — PROOF, OR THE NAMED OBSTRUCTION

### 4.1 What is PROVED here about the fibre

**Theorem G (the Gaussian fibre is massive at the block scale; Combes–Thomas form).** Let φ be the lattice field on ℤ^d (or an even
torus) with precision J = −Δ + m², m ≥ 0, any d ≥ 1, blocks of side L ≥ 2, coarse variables the block averages. The fibre is Gaussian
with a covariance C_fib independent of the coarse configuration (so the averaged and the supremum forms of the fibre clause coincide),
and for fine sites x, y in blocks X, Y and every coordinate direction μ:

  |C_fib(x, y)| ≤ (2/g_L) e^{−η_L |X_μ − Y_μ|},   g_L = 2 − 2cos(π/L),   η_L = log(1 + g_L/2) = log(2 − cos(π/L)),

independent of d and m (η₂ = log 2 = 0.6931, η₄ = 0.2572, η₈ = 0.0734 per coarse unit). Consequently (b) for bounded functions f, g of
the fine field in single blocks at coarse distance r, |Cov_ν(f, g)| ≤ (4d + m²) L^d (2/g_L) e^{−η_L r} ‖f‖‖g‖: clause (a) in its
SUPREMUM form, for every coupling (β only rescales C_fib), with ρ′ = e^{−η_L}; at L = 2, d = 4: ρ′ = 1/2, K′ = 256. (c) Clause (b) holds
in the L² form with the same rate: E[φ | Φ] = MΦ with M = Q⁺ − A⁻¹PJQ⁺ (Q⁺ the block-indicator extension; ζ* = −A⁻¹PJQ⁺Φ minimises the
energy over V₀), so M(x, Y) inherits the bound of (a), and ℓ_Y(F) ≤ ‖f‖ (4d + m²)^{1/2} L^{d/2} max_x|M(x, Y)| sd(Φ_Y | rest). Its
SUPREMUM form fails trivially here — the coarse variable is unbounded and F moves by O(‖f‖) as Φ_Y → ∞ — one more reason the average is
the right currency for clause (b).
*Proof.* (a) The conditional law given Φ is the Gaussian restricted to the affine space {block averages = Φ}; its covariance is
A⁻¹ ⊕ 0 with A = PJP on V₀ = {φ : every block average 0}, P the orthogonal projection onto V₀ (block-diagonal). For φ ∈ V₀,
⟨φ, Jφ⟩ ≥ ⟨φ, −Δφ⟩ ≥ Σ_B (the Dirichlet form of the bonds inside B) ≥ g_L Σ_B ‖φ_B − mean_B φ‖² = g_L‖φ‖², g_L being the first non-zero
eigenvalue of the Laplacian of the grid graph P_L^d, which is that of the path P_L. With w(x) = X_μ (constant on blocks), multiplication
by e^{ηw} commutes with P, so e^{ηw}Ae^{−ηw} = A + PE_ηP with E_η = e^{ηw}Je^{−ηw} − J supported on the bonds crossing block boundaries in
direction μ: a site has at most one such neighbour (L ≥ 2), with entry 1 − e^{∓η}, so Schur's test gives ‖E_η‖ ≤ e^η − 1. For
e^η − 1 = g_L/2, the Neumann series gives ‖(e^{ηw}Ae^{−ηw})⁻¹‖ ≤ 2/g_L, and C_fib(x, y) = ⟨Pδ_x, A⁻¹Pδ_y⟩ =
e^{−η(w(x) − w(y))}⟨Pδ_x, (e^{ηw}Ae^{−ηw})⁻¹Pδ_y⟩ (Pδ_x supported in x's block), with ‖Pδ_x‖ ≤ 1; symmetrise in x, y.
(b) For a Gaussian pair of vectors the maximal correlation is the largest canonical correlation (Kolmogorov–Rozanov; Lancaster),
‖C_XX^{−1/2} C_XY C_YY^{−1/2}‖ on the ranges, and |Cov(f, g)| ≤ ρ_max sd(f) sd(g); C_XX ≥ (J restricted to the block's zero-mean
subspace)⁻¹ ≥ (4d + m²)⁻¹ on its range, and ‖C_XY‖ ≤ L^d max|C_fib|. ∎
The theorem is classical in kind (Gawędzki–Kupiainen's and Bałaban's fluctuation fields are massive at the block scale; W = 0); what is
earned here is the d-independent constant at small L and the exact rates of §3, which the Combes–Thomas rate under-reads (it loses
uniformity, η_L ≈ π²/(2L²); the true rate is uniform, Theorem 3.1).

**Theorem 3.1 and Lemma 3.2** (§3.3: the exact rate cosh κ_L = 2 + 3/(L² − 1) of the block-averaged fibre; the reduction of every
sub-box map to decimation in its codimension) are proved there.

**Lemma 4.1 (the fibre is reflection positive at reflection-symmetric coarse data).** Let μ be reflection positive for θ (positive
algebra 𝒜₊), 𝒱 = 𝒱₊ ∨ 𝒱₋ θ-compatible as in Theorem 2.5, λ with a continuous positive density ℓ with respect to m₋ ⊗ m₊, m₋ = θ_*m₊,
and the fibre conditional expectations continuous in v. Then for every F ∈ L^∞(𝒜₊) and every u: ν(θF̄ · F | v = (θu, u)) ≥ 0, and for
F, F′ ∈ L^∞(𝒜₊) and coarse data u, w:

  |ℓ(θu, w) ν(θF̄ · F′ | θu, w)|² ≤ ℓ(θu, u) ν(θF̄ F | θu, u) · ℓ(θw, w) ν(θF̄′ F′ | θw, w).

*Proof.* For G ∈ L^∞(𝒱₊), FG ∈ L^∞(𝒜₊), so 0 ≤ μ(θ(F̄Ḡ) FG) = ∫∫ conj(G(u)) G(w) K_F(u, w) dm₊(u) dm₊(w) with K_F(u, w) =
ν(θF̄ F | θu, w) ℓ(θu, w): K_F is a continuous positive semi-definite kernel, hence K_F(u, u) ≥ 0; ℓ > 0 gives the first claim. The
matrix kernel over the pair (F, F′) is positive semi-definite in the same way, and the 2 × 2 principal minors give the second. ∎
**Merit, measured against the target.** It gives the fibre a positive transfer operator at symmetric data (so Theorem 7.1 runs inside
the fibre there) and relates every datum to symmetric ones by the coarse density's ratio. It gives no decay: the ordered Ising torus is
reflection positive. U(1) is reflection positive too, so the lemma cannot carry the group. An auxiliary tool, not a route.

### 4.2 The candidate routes, weighed (each with the U(1) test)

| route | what it would need at the crossover fibre (one step from 2.2, L = 2) | verdict | U(1) at 1.2 |
|---|---|---|---|
| fibre reflection positivity (Lemma 4.1) | decay from RP alone | **NO DECAY FROM RP** (ordered Ising is RP); auxiliary only | RP holds; cannot part the groups |
| Bakry–Émery with a soft coarse constraint | Ric(S³) + Hess(S_fib) ≥ c > 0 in the fibre directions | **DEAD**: on SU(2) ≅ S³ (round metric, Ric = 2) a link's own term is Hess = β Re(qW) ≥ −6β and the plaquette cross terms give Hess(S) ≥ −24β, so BE needs β < 1/12; a soft constraint adds curvature only along the 3 averaged directions per coarse link (of ~135 fibre dimensions per block at L = 2); at 2.2 even the one-link part is 2 − 13.2 < 0 | Ric(S¹) = 0: BE fails at every β — the route fails for U(1), and for SU(2) at 2.2 alike |
| finite-size (Dobrushin–Shlosman, Stroock–Zegarlinski) on the fibre | a box whose boundary influence is small for EVERY boundary datum | **IN PRINCIPLE A FINITE CHECK, IN PRACTICE OUT OF REACH**: one-link boxes fail (TV 13.24, L² ≥ 6.50); boxes of several correlation lengths of the β = 2.2 field in 4D are thousands of SU(2) links; the averaged (typical-datum) form is excluded by A1 (its Ising counterexample with blocks as sites) | the Gaussian part of U(1)'s fibre is massive under averaging (Thm G): DS would hold for U(1)'s fibre too, consistently — U(1)'s failure is in I′ |
| spectral independence | influence matrix of spectral radius ≤ η under every pinning | **DEAD**: rows exceed 6.50 (L² ess-sup, §3.4) and SI with η > 1 gives only n^{O(η)} relaxation, never a uniform gap | — |
| the law of total covariance as a bootstrap | — | **ITS CORRECT FORM IS THE SCALE LEMMA (2.2), PROVED**: II′ = the sum of the per-step averaged fibre covariances; the ultraviolet steps need only some uniform rate (Rem. 2.4); it REDUCES II′ to the per-step fibre of the first crossover step, and does not prove that | group-blind identity |
| the block-scale Poincaré mechanism (Thm G, Thm 3.1) | the fibre field near a background on which the action's Hessian is the block-constrained Laplacian | **PROVED for every Gaussian theory** (rates 1.72–3.53 per coarse unit at L = 2 for the photon); at 2.2 it is the linearisation only: ⟨½ tr U_p⟩ ≈ 0.57 there, the large-field set is not rare at the fine scale | holds for U(1)'s spin waves under averaging (as it must: U(1) fails I′, M2's Theorem 4.1); with the holonomy map its rate → 0 like L^{−1/2}, so II′ fails uniformly for U(1), as it must (there II′ IS the gap) |

### 4.3 THE OBSTRUCTION, named

**At the crossover the fibre clause is irreducibly the clustering of the β ≈ 2.2 field given its block averages.** Precisely: by the
Scale Lemma the full fibre's clause is the sum of per-step averaged fibre covariances, the ultraviolet steps needing only some uniform
rate; the step that sets ρ′ and that no method reaches is the first crossover step, the conditional law ν^{(x|x+1)} of the scale-a_x
field (effective coupling ≈ 2.2) given its L = 2 averaged block variables. On it: (i) its local conditionals are the bare single-link
laws (M5's Theorem 3.1), so every single-pair criterion fails — TV row ≥ 13.24 (M5), L² ess-sup row ≥ 14 a_½(2.2) = 6.5027 (§3.4,
certified), and the typical-environment forms are excluded by A1; (ii) its linearisation is massive at the block scale with rate
1.718 (holonomy map) / 3.53 (averaged map) per coarse unit, β-independent (§3.3); (iii) between (i) and (ii) lies exactly the
non-Gaussian, large-field content at O(1) coupling, which Bałaban's small-field method does not reach (β_B ≥ 10^982 on printed
constants, M6) and which blocking further never removes (the fibre at one step from 2.2 contains the 2.2 field; Hypothesis I′ gets
easier with blocking, Hypothesis II′ does not).

**And by the Two-Sector Theorem the obstruction matters only for the fibre sector.** The gap of the theory generated by observables at
the exit scale needs Hypothesis I′ alone (Cor. 2.6); the full local theory needs, in addition, completeness of the coarse sector (C) or
the fibre-sector bound (F) for one generating scale.

---

## 5. WHAT THIS FILE PROVES, COMPUTES, AND LEAVES (written last)

**PROVED (full proofs above).**
- Prop. 2.1: Theorem 8.5′ consumes II′ only as the λ_j-mean of the SIGNED fibre covariance and the ℓ-vector paired with (I − R_j)⁻¹,
  only for a generating class, only at reflected pairs for the gap; the mass is min(κ, log 1/ρ′)/a_c: II′ is a RATE, not a smallness.
- Lemma 2.2 (THE SCALE LEMMA) and Cor. 2.3: the fibre clause telescopes exactly over the blocking steps; observables of the scale-s field
  see only the fibres between s and a_c; at s = a_c the clause holds identically (K′ = √2, any ρ′).
- Thm 2.5 (THE TWO SECTORS) and Cor. 2.6: the coarse sector ℋ_c reduces H; Hypothesis I′ ALONE gives it the gap κ/a_c, in every limit
  point; the fibre-sector component of every state obeys ‖P_c^⊥ψ_f‖² ≤ λ_j(Cov_ν(θf̄, f)) + V₋(F), so II′ is exactly a bound on the
  fibre sector's spectral weight, and the full gap needs I′ plus completeness (C) or the fibre-sector bound (F).
- Prop. 2.7: completeness holds for the free field (alias separation by the time evolution) — the sighted control for (C).
- Prop. 2.8: the block gauge fixing does not enter the clause for gauge-invariant observables.
- Thm G: the Gaussian fibre under block averaging satisfies clause (a) in its SUPREMUM form and clause (b) in its L² form (its sup form
  failing for the unbounded coarse variable) at every coupling, rate ≥ log(2 − cos(π/L)) per coarse unit, d-independent (L = 2, d = 4:
  ρ′ = 1/2, K′ = 256).
- Thm 3.1: the block-averaged Gaussian fibre's rate EXACTLY, cosh κ_L = 2 + 3/(L² − 1), κ_∞ = log(2 + √3) — the cardinal cubic spline's
  Euler–Frobenius root (residue's non-vanishing read).
- Lemma 3.2: every sub-box map reduces exactly to decimation in its codimension; uniform iff codimension ≤ 1; the holonomy map is the line.
- Prop. 3.3: the SU(2) fibre's L² single-pair row at β is ≥ 14 a_½(β) (adversarial pair environment realisable, all 14 free staple
  links), 6.5027 at 2.2 (certified).
- Lemma 4.1: the fibre is reflection positive at reflection-symmetric coarse data, with a Cauchy–Schwarz to general data.

**COMPUTED (readings, double precision, two roads agreeing to 6–9 digits; records under rec/).** The Gaussian fibre's rate for every
map, d = 2, 3, 4, L = 2–32 (the table of §3.3); the photon's gauge-invariant fibre: holonomy map 1.718, 1.123, 0.746, 0.512 (L = 2–16;
= three-dimensional decimation, ∝ L^{−1/2}), averaged map 3.54, 5.28, 5.98, ≈ 6.2 (at the alias bound → 2π).

**REFUTED / CLOSED.** Every single-pair route to II′ at 2.2 in every currency (TV 13.24; L² ess-sup ≥ 6.50; typical forms by A1);
Bakry–Émery (needs β < 1/12); spectral independence (no uniform gap at η > 1); reflection positivity alone (no decay). The holonomy
block map for the ultraviolet composition (its Gaussian fibre is not uniformly massive: κ ≈ 1.99/√L). Stake S6 refuted as staked.

**THE OBSTRUCTION.** §4.3: the per-step fibre of the first crossover step — the β ≈ 2.2 field given its L = 2 averaged block
variables — carries the bare local conditionals and the non-Gaussian large-field content at O(1) coupling; its linearisation is
massive (rate ≥ 1.72), its non-linear clustering is reached by no method in the record or the literature; and it matters only for the
fibre sector.

**THE NEXT OBJECT (precise).** The fibre-sector bound (F) at the first crossover step in the form Theorem 2.5(iii) consumes:
λ(Cov_ν(θτ_t f̄, τ_t f)) + V₋(τ_t F) ≤ C_f e^{−2mt} for gauge-invariant f of the scale-a_x field, ν the conditional law of that field
(effective coupling ≈ 2.2) given its Bałaban-averaged L = 2 block variables, uniformly in the volume — the Gaussian part is Theorem G
and §3.3, so what remains is the large-field correction, to be priced by its λ-probability (Theorem 8.5′ permits the average);
OR, removing the fibre clause from the gap altogether, COMPLETENESS (C) of the coarse sector of the averaged map in the limit theory —
a qualitative unique-continuation statement with no constants, true for the free field (Prop. 2.7).

**CROSS-FIELD UNIFICATIONS.** (1) The block-averaged fibre's decay IS cardinal-spline localisation: κ_∞ = log(2 + √3) is the cubic
spline's Euler–Frobenius root, the lattice root cos K = −(2L² + 1)/(L² − 1) the discrete spline's. (2) The Two-Sector Theorem is the
decomposition theorem for Markov chains (Madras–Randall; Jerrum–Son–Tetali–Vigoda: projection chain = Hypothesis I′, restriction chains =
the fibres), and completeness is OBSERVABILITY of a hidden Markov model (the fine field hidden, the coarse field observed). (3) Lemma
3.2's codimension rule is the random-walk capacity rule — sets of codimension ≤ 1 are hit at the block scale, codimension 2 is the
logarithmic borderline, higher codimension is transient — and for the holonomy map it is the perimeter law of the sharp Wilson line.

---

## 6. DATED CORRECTIONS AND ADDITIONS (2026-11-02 11:0x, after the advisor's read; nothing above edited)

(a) **The observable class of Cor. 2.3 and §2.5.** "Observables of the scale-s field" means functions of the scale-s BLOCK VARIABLES on
the block grid (𝒢_s-measurable), not THE GROUND's test-function-smeared observables: a smeared Wilson loop is 𝒢_s-measurable for no
s > a_j. So the Scale Lemma's reduction ("only the fibres between s and a_c") holds for the block-variable class and gives the gap on the
sector THAT class generates; carrying it to the construction's smeared class is one more completeness step of the same kind as (C).

(b) **The strength of "Hypothesis I′ alone gives the gap" (Thm 2.5(ii), Cor. 2.6, §5).** It is the gap of the COARSE SECTOR — a reducing
subspace of H containing Ω — and not a local quantum field theory in the Clay sense: its observables live on a fixed grid, so Euclidean
invariance is not even formulable on it. The full local theory needs (C) or (F) on top.

(c) **Photon holonomy map = three-dimensional decimation:** agreement to 5–6 digits (0.511829 against 0.511811 at L = 16; 6–7 digits at
L = 2, 4, 8), not 6 throughout.

(d) **The slowest sector, confirmed on a finer grid** (rec/d4_box4_scan5.2026-11-02a.txt; K_⊥ ∈ {0, π/4, π/2, 3π/4, π}³): the minimum
over K_⊥ is at K_⊥ = 0 on the line Re K = π at L = 2, 4, 8 (1.762747, 1.425417, 1.344024); on the line Re K = 0 the minimum is larger
(2.807 at L = 2, 3.338 at L = 4, at K_⊥ = (3π/4, 0, 0)). Theorem 3.1's rate is the global rate on this grid (READ).

(e) **Reconciliation with THE CROSSING CAMPAIGN §22's named object.** §22's table names, for "fibre clustering (II′) at the exchange",
the four-sided-ring contraction at n = 4 with the supremum over environments. That object reads the COARSE PAIR's conditional law —
Hypothesis I′'s matrix R_j — at the exit. By Theorem 2.5 it bounds the coarse sector's gap; the fibre clause is a different object: the
first crossover step's fibre-sector bound (F), or completeness (C).

(f) **The thinking-tool rule.** The deep-think skill was invoked at the start and its synthesis written in §1; the brief's
mcp__clear-thought__sequentialthinking was called once, at the end, to record the synthesis check, not while deriving; the mentalmodel
tool was not called. The lenses were run in the agent's own reasoning, as the skill permits.

(g) **Recommendation for revision 34 of THE GROUND.** The ultraviolet composition must use averaging block maps (Bałaban's, or
gradient-flow smoothing): the holonomy map's fibre is provably not uniformly massive at the Gaussian level (Lemma 3.2: it is the line,
three-dimensional decimation, κ ≈ 1.99/√L → 0), which is M2R's structural fact made exact. At the crossover's own L = 2, 4 every map
gives an O(1) rate.

(h) 2026-11-02 11:1x: the batch closed; its d = 4, L = 16 rows for box3 and box4 read:
map=box3 dir=0 roadA_kernel=1.792221 roadB_ReK0=3.269600439 roadB_ReKpi=1.792293903
map=box3 dir=3 roadA_kernel=nan roadB_ReK0=1000000000.000000000 roadB_ReKpi=1000000000.000000000
map=box4 dir=0 roadA_kernel=1.323724 roadB_ReK0=1000000000.000000000 roadB_ReKpi=1.323723772
map=box4 dir=3 roadA_kernel=1.323724 roadB_ReK0=1000000000.000000000 roadB_ReKpi=1.323723772
(box4 = 1.323724 = arccosh(2 + 3/255), as Theorem 3.1 states; box3 in-box 1.792294, transverse below 10^-11 by D = 4.)
