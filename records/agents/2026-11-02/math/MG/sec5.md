## 5. LINK (2): THE REDUCTION — THEOREMS 7.1, 7.4, 8.5, 8.5′ AND THE BLOCK MAPS, FOR EVERY G

### 5.1 Reflection positivity for every compact G (PROVED: the input every theorem of §7 and §8.3 takes)

LEMMA RP_G. For every compact group G, every finite-dimensional unitary representation ρ and every β ≥ 0, the plaquette weight
w(U) = exp((β/d_ρ) Re χ_ρ(U)) has nonnegative coefficients in the irreducible characters, w = Σ_{r∈Ĝ} c_r(β) χ_r with c_r ≥ 0 and
Σ_r d_r c_r = w(1) = e^β < ∞; hence w is a continuous positive-definite class function, the kernel (g, h) ↦ w(gh^{−1}) is positive
semidefinite, and the Wilson measure on every periodic lattice is reflection positive with a positive transfer matrix.
PROOF. Re χ_ρ = ½(χ_ρ + χ_ρ̄) = ½χ_{ρ⊕ρ̄}. Every power χ_{ρ⊕ρ̄}^n = χ_{(ρ⊕ρ̄)^{⊗n}} is a character of a genuine representation, so it
is a combination of irreducible characters with nonnegative integer multiplicities; e^{tX} = Σ_n t^nX^n/n! with t = β/(2d_ρ) ≥ 0 is
therefore a nonnegative combination, converging absolutely in sup norm (Σ_n t^n(2d_ρ)^n/n! = e^β). Evaluating at U = 1 (χ_r(1) = d_r)
gives Σ d_rc_r = e^β. A class function with nonnegative character coefficients is positive definite: Σ_{i,j} ξ_iξ̄_j w(g_ig_j^{−1}) =
Σ_r c_r Σ_{i,j} ξ_iξ̄_j χ_r(g_ig_j^{−1}) = Σ_r c_r ‖Σ_i ξ_i D^r(g_i)‖²_HS ≥ 0. Reflection positivity of the lattice measure with a
positive-definite plaquette weight, and positivity of its transfer matrix, is Osterwalder–Seiler's theorem (1978) for compact gauge
groups, with Lüscher's construction of the transfer matrix (LITERATURE, THE GROUND's Sources [5], [7]); the program's kernel proves the
finite-group form for every unitary representation of every finite group (Unitary.lean, READ at its head). ∎

### 5.2 Theorems 7.1, 7.4, Lemma 7.3, Corollaries 7.2, 7.5 — PROVED for every G (read: no group enters)

Theorem 7.1 is the spectral theorem on the Osterwalder–Schrader space of a reflection-positive, time-translation-invariant S;
Lemma 7.3 is a passage to the limit of inequalities between Schwinger functions flat at the diagonals; Theorem 7.4 consumes (a) Wilson
measures on periodic lattices "with bare couplings tuned along the sequence" — for G the tuning is Theorem 2_G's (§4.2) — (b) Lemma
4.2's transfer-matrix bound and (c) RP, Lemma RP_G. Corollary 7.2's Euclidean-rotation step and Corollary 7.5 use (E1), a property of
the limit, not of G. Every statement holds verbatim for every compact simple G.

### 5.3 Theorem 8.5, Theorem 8.5′ (M2 Theorem 3.1), Proposition 8.4, M2 Theorem 4.1, campaign §20 — PROVED for every G

Theorem 8.5's proof uses: the law of total covariance along a measurable coarse map; Dobrushin's comparison theorem "for arbitrary
single-site spaces" (Georgii Thm 8.20) on the blocked measure, whose single-site space V is compact; Proposition 8.4 (tilts, on any
probability space); the counting of pairs (2n + 1)⁸ on the coarse lattice. No group. Theorem 8.5′ (M2 §3) replaces the comparison by the
L² covariance theorem (M2 Theorem 2.3: projections K_y on L²(λ), a positive density on a product of compact spaces) — no group;
M2's Theorem 4.1 (the refusal) is stated by M2 "with any compact group G". Campaign §20's reduction C^λ(y, y′) ≤ δ_yT_∂/(1 − δ_y) uses the
Markov property of the Wilson specification (each block's conditional law depends on the 80 = 3⁴ − 1 neighbouring blocks) and
Dobrushin's contraction — no group. The block maps enter only through their measurability and the existence of versions of the fibre
and blocked conditional laws for every coarse configuration (THE GROUND §8.3, READ: "it holds unchanged for any measurable map from
the configurations of a rung to coarse configurations with values in V").

### 5.4 Block maps for general G: the holonomy map, the averaged map, and the projection's domain (PROVED)

(a) THE HOLONOMY MAP: one G-element per coarse link (the ordered product along a fixed fine path, the remaining links in a fixed
gauge) is a measurable bijection of each block's configurations onto V × Φ_j with V = G⁴ (four coarse links per coarse site),
defined EVERYWHERE, for every G. Its ultraviolet instability is G-blind: in the Gaussian field each colour component of the coarse
flux has variance g²(4G₃(0)n + o(n)) (THE GROUND's computation, componentwise in g), so every normalised character mean
E[χ_r(v)]/d_r ≈ exp(−½C₂(r)·g²·Var) → 0 for every r ≠ 0 along the asymptotically free sequence: the coarse variables tend to independent
Haar variables for every G, and Hypothesis II(a) carries all the content (THE GROUND's diagnosis, now for every G).
(b) THE AVERAGED MAP needs a projection to G. Let E_G := span_ℝ ρ(G) ⊂ End(V_ρ) with ⟨A, B⟩ := Re tr(A†B), and for M ∈ E_G let
  Π_G(M) := argmax_{g∈G} ⟨ρ(g), M⟩  — the nearest point of ρ(G) to M (‖M − ρ(g)‖² = ‖M‖² + d_ρ − 2⟨ρ(g), M⟩).
LEMMA P_G. (i) φ(M) := max_g ⟨ρ(g), M⟩ is convex and finite on E_G; Π_G(M) is a single point exactly where φ is differentiable, and
there ∇φ(M) = ρ(Π_G(M)). Hence the cut locus 𝒞_G := {M : the maximiser is not unique} is a Borel set of Lebesgue measure zero in E_G,
and Π_G is continuous on E_G ∖ 𝒞_G (real-analytic where the maximum is nondegenerate). (ii) Bi-equivariance: Π_G(ρ(h)Mρ(k)) =
hΠ_G(M)k off 𝒞_G; in particular Π_G(ρ(z)M) = zΠ_G(M) for z ∈ Z(G) (ρ irreducible, so ρ(z) = ζ_z·1). (iii) SU(2), ρ fundamental:
E_G = ℍ ≅ ℝ⁴, Π(M) = M/|M| and 𝒞 = {0}. (iv) SU(N), N ≥ 3, ρ fundamental: E_G = M_N(ℂ), and 𝒞 contains a real-analytic
hypersurface through M₀ = e^{iπ/N}·1 across which Π_G jumps between 1 and ω·1 (ω = e^{2πi/N}): THE AVERAGED BLOCK MAP OF SU(N≥3) IS
DISCONTINUOUS ACROSS A CODIMENSION-ONE SET, AND ITS JUMPS ARE CENTRE ELEMENTS. (v) A Borel selection of the argmax exists on all of E_G (the argmax is a nonempty compact-valued upper
hemicontinuous correspondence: Kuratowski–Ryll-Nardzewski), so the averaged coarse map M ↦ Π_G(M) is measurable for every G whatever
the law of M — which is all Theorems 8.5 and 8.5′ consume; when the law of the average is absolutely continuous on E_G (necessary:
k·dim G ≥ dim E_G for k summands; for SU(2) two independent uniform points of S³ already have a density on the ball of radius 2), the
selection on the null set 𝒞_G is immaterial.
PROOF. (i) φ is the support function of the compact set K = ρ(G), a supremum of linear functions: convex, finite, Lipschitz. Its
subdifferential at M is conv{ρ(g) : g a maximiser} (Danskin). Every point of K lies on the sphere ‖A‖² = d_ρ, so every point of K is
an extreme point of conv K (a sphere is strictly convex); hence the subdifferential is a singleton iff the maximiser set is one point,
i.e. φ is differentiable at M iff the maximiser is unique, and then ∇φ = ρ(Π_G(M)). A convex function on a finite-dimensional space is
differentiable outside a Lebesgue-null Borel set (Rademacher). Continuity off 𝒞: if M_n → M with unique maximisers g_n and g a limit
point of g_n, then g maximises at M (continuity of ⟨ρ(·), ·⟩), so g = Π(M): the bounded sequence has the single limit point Π(M).
Real-analyticity at a nondegenerate maximum: the implicit-function theorem for ∇_g⟨ρ(g), M⟩ = 0. (ii) ⟨ρ(g), ρ(h)Mρ(k)⟩ =
⟨ρ(h^{−1}gk^{−1}), M⟩ (unitarity, cyclicity), so the maximisers transform by g ↦ hgk. (iii) For SU(2), ρ(g) is a unit quaternion and
⟨ρ(g), M⟩ = 2⟨g, M⟩_{ℝ⁴} on ℍ; the maximiser of a nonzero linear functional on S³ is unique. (iv) On the torus, g = diag(e^{iθ_j}) with
Σθ_j ∈ 2πℤ, ⟨ρ(g), M₀⟩ = Σ_j cos(π/N − θ_j). For any g ∈ SU(N), ⟨ρ(g), M₀⟩ = Re(e^{iπ/N} tr g†) and conjugation-invariance reduces the
maximisation to the torus; a critical point has sin(π/N − θ_j) equal for all j, so each θ_j ∈ {s, π + 2π/N − s} (mod 2π) for one s;
with k coordinates in the second class the value is (N − 2k)cos(π/N − s), and for 1 ≤ k ≤ N − 1 this is at most N − 2 < N cos(π/N) (N ≥ 3: N − N cos(π/N) ≤ π²/(2N) < 2), so the maximum is at θ_j ≡ θ, Nθ ∈ 2πℤ, value
N cos(π/N − 2πm/N), largest exactly at m = 0 and m = 1: the two central elements 1 and ω·1, both nondegenerate (the Hessian in
direction X = iH ∈ su(N) is −cos(π/N)·tr H² < 0, tr H = 0 removing the linear term). Near M₀ the two local maximum values f₀(M), f₁(M)
are analytic with gradients ρ(1) = 1 and ρ(ω·1) = ω·1 (Danskin); 1 ≠ ω·1, so {f₀ = f₁} is a real-analytic hypersurface through M₀, on
whose two sides Π_G equals the continuation of 1 and of ω·1 respectively. (v) The correspondence M ↦ argmax is nonempty, compact-valued and upper hemicontinuous (Berge's maximum theorem), hence admits a Borel
selection (Kuratowski–Ryll-Nardzewski — LITERATURE). ∎
CONSEQUENCES. (1) Theorems 8.5, 8.5′ hold for the averaged map of every G. (2) M4's averaged-map twist identity (its clause conditional on
the cutting set S, M4R item 1′) uses only Π_G(ζM) = ζΠ_G(M) for central ζ, which (ii) gives for every G and every z ∈ Z(G). (3) The
DOMAIN ISSUE, NAMED EXACTLY: for SU(2) the averaged map is singular only at a zero average (codimension four, the GROUND's "configurations
at which its average vanishes"); for SU(N ≥ 3) it is singular on a codimension-ONE set where it jumps by a centre element — the averaged
coarse variable itself carries a centre-vortex interface wherever the fine average sits between two centre elements; for trivial-centre
G (G₂ ⊂ SO(7) in its 7, F₄ in its 26, E₈ in its 248) the cut locus is null and its jumps are between non-central maximisers. Bałaban's
small-field analysis never meets 𝒞_G (averages within distance ε of ρ(G), where the maximiser is unique and analytic: CMP 98's averaging
through g); the large-field regions, where 𝒞_G lives, are handled by his large-field expansions, whose positivity input is
1 − Re χ_ρ(U)/d_ρ ≥ 0 with equality iff U = 1 (ρ faithful) — true for every G.

VERDICT ON LINK (2): Theorems 7.1, 7.4, 8.5, 8.5′ (and §20's reduction, M2's refusal theorem, Proposition D∞) are PROVED for every compact
simple G; the only G-input is reflection positivity (Lemma RP_G) and a measurable block map (the holonomy map everywhere; the averaged
map off the null cut locus 𝒞_G of Lemma P_G).

