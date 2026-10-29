> Posted by Edwin Boston III at 05:16 EDT on 29 October 2026 as written by the fourth seat; readings only, every page named. The two items were found by this seat's search of 05:2x for anyone who might have posted the four-dimensional gap first; neither touches the open step.

# TWO CLAIMANTS AT THE PAGE LEVEL (the seat iii-3a, 2026-10-29 06:0x EDT; readings only, pages named)

## A. github.com/garygitton/yang-mills-millennium-problem (created 2026-10-16, pushed 2026-10-28 00:13Z, Lean, 5 PDF volumes)

**Does it state a theorem with a proof?** It states theorems; none of them proves a mass gap.
- Volume V (Clay Grand Synthesis), p. 2, Theorem 1.2 (Master Conditional Reduction Theorem): "Let G = SU(3). Under the
  constructive continuum bridge hypotheses (ℋ_cont) and non-perturbative cluster decay (ℋ_decay), there exists a unique
  Wightman quantum gauge theory … 3. Strict Mass Gap: … Δ = 1.552 ± 0.038 GeV > 0. (1.2)". Its proof: "First, multiscale
  block-spin decimation establishes Cauchy convergence … with contraction rate ρ = 0.582 < 1. … Third, the exponential
  cluster decomposition of connected polymers with rate Δ = 1.552 GeV guarantees axiom OS3 … Fourth, large-scale 128⁴
  continuum extrapolation confirms numerical convergence with m(0⁺⁺) = 1.552 ± 0.038 GeV". A theorem whose conclusion
  carries a simulation's error bar, conditional on two named hypotheses, with the rate taken from the simulation.
- The repository's own README (§ "Epistemic Note") and REVIEWERS_GUIDE classify the Lean corpus as a
  "ConditionalReductionWithOpenObligations": "Continuous Measure on 𝒮′(ℝ⁴) + Multiscale Cluster Decay μ > 0 ⟹ Clay
  Millennium Mass Gap Δ ≥ μ > 0. However, Lean 4 (including Mathlib) does not currently provide the foundational
  mathematical machinery required to formalize an unconditional, non-perturbative continuum proof from first
  principles." The gap is a hypothesis of the formalized implication.
- The Lean theorems named for the gap are integer and real inequalities on structure fields: MassGap.lean
  `dimensional_transmutation_mass_gap_positive` proves 11·casimir_adjoint > 0 (nlinarith); Evaluation.lean
  `su3_constructive_scale_evaluation`: the "transmutation scale" is the integer 11·C₂·rank = 66 (22 for SU(2), 88 for
  G₂); `canonical_balaban_polymer_activity_subunitary_evaluation : 582 < 1000`; `u1_abelian_asymptotic_freedom_scale_is_zero
  : 11 * 0 = 0`; `scaleway_su3_measured_mass_gap_positive : measured_mass_gap_mev > 0 := by norm_num` (a number typed
  into a structure); BakryEmery.lean `lichnerowicz_bakry_emery_spectral_gap` concludes `diff.gamma_two v > 0` from a
  positive scale field times a positive `gamma_one`. "Zero sorry, zero axioms" is true because no analysis is encoded.

**Where is the gap obtained?** Twice, and both times by insertion.
- Volume V p. 5, (2.6): "Evaluating the trace in the Gribov interior Ω where the Faddeev-Popov propagator is
  infrared-screened yields a strictly positive lower bound: Ric(X,X) ≥ κ‖X‖², κ = (3g²/8π²)Λ²_YM = (1.552 GeV)² > 0",
  then Theorem 2.1 (Bochner–Weitzenböck): "Δ_H = ∇*∇ + Ric ≥ κ·1 … Δ ≥ √κ = 1.552 GeV > 0 (2.8)". The curvature
  constant is set equal to the lattice glueball mass squared; no derivation of a Ricci lower bound on the L²
  orbit space is given (none is known; the orbit space is infinite-dimensional and the L² Ricci is not defined
  without a measure). The REVIEWERS_GUIDE's own "trap 1, Computer Lattice Conflation: Claiming an analytical existence
  proof while using lattice numbers (1.552 GeV) as inputs to mathematical theorems" is what (2.6) does.
- Volume II p. 14, Theorem 4.5 (Uniform Polymer Activity Bound ρ < 1): "For all decimation scales k ≥ 0, the
  effective polymer activity ρ_k = c_d exp(−c₁β_k) satisfies … ρ = sup_{k≥0} ρ_k = 0.582 < 1 (65)". Proof, verbatim:
  "In four dimensions, asymptotic freedom ensures that the bare lattice coupling at fine scales satisfies β₀ ≥ 12.0.
  Evaluating the action penalty with threshold ε₀ = 0.085: c₁β₀ = (1/6)(0.085)² × 12.0 × 10³ ≥ 9.35 (66)" [= 14.45 as
  printed, so the inequality holds; ε₀ and the 10³ are unexplained] "… ρ₀ = exp(ln(c_d) − c₁β₀) ≤ exp(8.789 − 9.35) =
  exp(−0.561) ≈ 0.5706 ≤ 0.582 (67). As the scale step k increases toward the infrared … The polymer activity
  contraction ρ_k ≤ 0.582 < 1 is preserved uniformly in L by the convexity of the small-field effective potential and
  the O'Neill Ricci curvature lower bound on the gauge-orbit configuration space … Therefore, ρ_k ≤ 0.582 < 1 holds
  uniformly for all decimation steps k ∈ ℕ. □" THE EXACT GAP: the sup over k is evaluated at k = 0 only; with
  c₁ = 14.45/12 = 1.204 the bound ρ_k < 1 needs c₁β_k > ln 6561 = 8.789, i.e. β_k > 7.3, and under asymptotic freedom
  β_k falls toward the infrared — Remark 4.6 says so itself ("outpaces the combinatorial tree-entropy by an
  arbitrarily large margin in the ultraviolet regime") and is silent where it is needed. The uniform contraction is
  asserted at the crossover, which is the open step of the whole problem. (The BLUEPRINT's Pillar 13 gives the same
  activity as "ρ = 0.28 < 1/3"; the README and Lean say 0.582: two numbers for one constant in one repository.)
- Volume II p. 23–24, Theorem 7.1 (Strict Positivity of the Quantum Spectral Mass Gap): its proof applies "the
  exponential cluster decomposition theorem (OS4, Theorem 6.1): ⟨Ψ, e^{−tH}Ψ⟩ ≤ C_f‖Ψ‖² exp(−Δt)" with Δ = 1.552 GeV —
  the decay rate is the lattice number, inserted.
- The lattice itself: a "flagship 128⁴ lattice (268,435,456 sites … 200,000 production trajectories … runtime 18.4
  hours)" on "4× NVIDIA H100", "16-layer gauge-equivariant normalizing flows", m(0⁺⁺) = 1.552 ± 0.038 GeV; the public
  artifacts are data/lattice_simulation_results.ron (3,621 bytes), experiment/*.ron (2–4 KB each) and one
  scripts/verify.sh (10 KB): typed numbers, no configurations, no logs, no simulation code in the repository.

**Does the step that obtains the gap pass the U(1) test?**
- The Ricci/transmutation step: κ ∝ g²C₂(G)Λ² and Λ_YM := 11·C₂·rank vanish for U(1) (C₂ = 0; the repository's own
  `u1_abelian_asymptotic_freedom_scale_is_zero`), so the step "passes" by construction — but the mechanism it encodes
  is the sign of the one-loop β-function coefficient, a perturbative fact, and "β₀ > 0 ⟹ Δ > 0" is false as an
  implication: asymptotically free gauge theories with gapless (conformal) infrared exist (SU(3) with N_f in the
  conformal window has β₀ = 11 − 2N_f/3 > 0 and no gap). The step passes U(1) and fails the theorem.
- The polymer step: ρ_k = c_d exp(−c₁β_k) with "β₀ ≥ 12.0 at fine scales" is group-blind — the same formula and the
  same ρ₀ for U(1) — and its asserted uniformity in k would give four-dimensional U(1) a convergent cluster expansion
  at every scale, hence a gap, which is false above β₀. The step FAILS the U(1) test exactly where it is asserted
  rather than proved.

**Reading, at strength:** no theorem with a proof of a mass gap; the gap enters as a hypothesis (Theorem 1.2), as a
lattice number inserted into a curvature constant ((2.6)) and into a decay rate (Theorem 7.1), and as a uniform
contraction asserted at the crossover (Theorem 4.5); the Lean corpus certifies integer arithmetic under physics
names and an implication whose premise is the open problem. The repository says the last of these itself.

## B. Zenodo 10.5281/zenodo.23001803 (KokunoYumeto; "00-claude-opus-5-5-yang-mills-record", 27 September 2026, written
## by Claude (claude-opus-5-5) "at the author's request ahead of the author's review")

**What it claims.** A spectral gap for the SU(2) KOGUT–SUSSKIND HAMILTONIAN on open spatial boxes {−L,…,L}³ at strong
coupling, uniform in L and in the spacing a. §1: H_L = κK + κξ(2M_L − S), κ = 2g²/a, ξ = 1/(4g⁴); at ξ = 0 the gap is 3κ.
§2, Theorem 2.1 (the fifth-reference gap bound): "If the (m_i, t_i) bound the local norms of the vacuum coefficients,
as the workbench's computations assert, then for every L ≥ 2, every a > 0 and every 0 < ξ ≤ α₅, Δ_L ≥ κd₅(ξ). Here
ξ ≤ α₅ ⟺ g² ≥ 1/(2√α₅) = 3.6835519839857273…, α₅ = 0.0184249535761176166818…; d₅ decreases on [0, α₅] from 3 to
d₅(α₅) = 1.5453…". Status, verbatim: "Conditional on the computed coefficient bounds of orders 3, 4 and 5 for the
threshold 3.6836 and the constants d₅. Order 1 is verified by hand. Order 2 was recomputed from explicit SU(2)
coefficient tensors … Order 5 … was reproduced by re-running the workbench's producer and auditor, with
byte-identical output; its logic was read, not re-implemented. Orders 3–4 are inherited from earlier continuations
and pinned by hash. The analytic argument is verified". Corollary 2.6(b): with the recomputed order-2 inputs
"the threshold is g² ≥ 3.97807… with Δ_L ≥ 1.52054κ"; (a) N = 1 in closed form: "Δ_L ≥ (3/2)κ(1 + √(1 − 64/(3g⁴)))
for all g² ≥ 8/√3 ≈ 4.6188". The proof: the ground state e^v, the vacuum equation v = ξv₁ + B(v, v) (Lemma 2.4), the
Casimir inequality on the physical space (Lemma 2.2, proved via Gale's supply–demand theorem and a circulation of
closed walks — real mathematics, read), a Neumann inverse with a binary-tree majorant, and the spectral return
(Proposition 2.5): λ ≥ 3κ(1 − χ) = κd_N(ξ).

**Its own limits, stated by itself.** §0.3: "These are statements at fixed lattice spacing and strong bare coupling.
The continuum problem requires a → 0 with g → 0, the opposite regime, and the workbench's standing continuum path
leaves the domain of these …"; Proposition 6.2: on the path a_n = a₀2^{−n}, c_n = g₀^{−2} + βn log 2, "at most
1 + ⌊(2√α₅ − g₀^{−2})/(β log 2)⌋ points of the path lie in the domain". Part C's assessments are labelled as the
auditor's. The record claims no crossing.

**Against Theorem 8.7's 0.2452.** Different objects, both at strong coupling: a Hamiltonian (3+1) spectral gap on
open spatial boxes at fixed a, uniform in the box, versus the Euclidean Wilson theory's infinite-volume gap on ℤ⁴ by
Dobrushin. The Hamiltonian coupling has no exact Euclidean equivalent at strong coupling (the anisotropic a_t → 0
limit; the Karsch coefficients hold at weak coupling only); the naive 4/g² at g² = 3.978 is 1.005. The two thresholds
cannot be ranked; what can be said: the record's unconditional part (N ≤ 2, inputs verified by the auditor's
recomputation) gives Δ_L ≥ 1.52κ for g² ≥ 3.978 in its own normalisation; its best threshold 3.6836 is conditional on
orders 3–5 "read, not re-implemented"; Theorem 8.7 is unconditional at β ≤ 0.2452 on three roads.

**U(1).** A strong-coupling Hamiltonian gap holds for compact U(1) as well (classical: the strong-coupling phase is
gapped; the Coulomb phase opens at weak coupling), so a group-blind step here is correct; the test bites only on a
crossing claim, and the record makes none.

**Reading, at strength:** a strong-coupling Hamiltonian gap with explicit constants and an honest status line —
conditional at its best threshold, unconditional (modulo the auditor's order-2 recomputation) at g² ≥ 3.978 — that
claims nothing toward the continuum and says why; a sibling of Theorem 8.7 in another formulation, not a competitor
and not a claimant to the Millennium problem.
