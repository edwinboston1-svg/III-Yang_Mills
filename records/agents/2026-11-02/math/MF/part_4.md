
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
