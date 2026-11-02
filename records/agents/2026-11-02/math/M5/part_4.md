
---

## 4. TURÁN SLAVING UNDER TILTS: THE BLOCKED ACTION LEAVES THE CONVOLUTION CLASS AT ONCE, AND THE LEAK IS LINEAR IN THE VORTEX CHANNEL

M4's Theorem 8.1 holds for CONVOLUTION couplings K(UV⁻¹)dUdV (Haar marginals). On ℤ⁴ no pair-conditional law of two coarse links is one:
each link lies in five other plaquettes, whose staples tilt its law. The question "does the blocked action stay in the convolution class"
has two layers. (i) The conditional laws Hypothesis I is stated on: never convolutions, for any action with a nonconstant one-plaquette part
(the tilt a(v_a) = Π_{P∋a, P≠P₀} w′(v_a S_P) is constant only where the five staples cancel); with bonds, not even tilted convolutions. (ii) The
one-plaquette weight's own coefficient sequence (the MK decimation's coupling IS a convolution): there 𝒯 matters, and it is closed under
convolution (M4); whether bond moving's pointwise power preserves 𝒯 is not decided here (Wilson weights trivially; OPEN in general).
Layer (i) is what Hypothesis I needs, and on it the theorem below is the answer.

**Theorem 4.1 (THE TILT LEAK).** Let K be a continuous positive-definite class function on SU(2), K ≥ 0, ∫K = 1, K = Σ_j d_jκ_jχ_j, with
K_e, K_o its integer- and half-integer-spin parts, K′_e := K_e − P₀ (P₀ the constants), κ̃ := sup_{j ∈ ℕ, j ≥ 1}κ_j, κ_odd := sup_{j ∈ ℕ+½}κ_j.
Let a, b be continuous and positive with even/odd parts (under U ↦ −U) a_e, a_o, b_e, b_o, and π(dU, dV) = Z⁻¹a(U)b(V)K(UV⁻¹)dUdV.
(a) THE FOUR-FLIP IDENTITY. The joint law of the SO(3) projections has density Z⁻¹[a_e(U)b_e(V)K_e(UV⁻¹) + a_o(U)b_o(V)K_o(UV⁻¹)].
(b) For even f, g centred under the marginals of π,
  Cov_π(f, g) = Z⁻¹[ ⟨fa_e⟩⟨gb_e⟩ + ⟨fa_e, K′_e(gb_e)⟩ + ⟨fa_o, K_o(gb_o)⟩ ]   (⟨·⟩, ⟨·,·⟩ in L²(Haar), K acting by convolution),
  with ⟨fa_e⟩ = −⟨b_e⟩⁻¹[⟨fa_e, K′_e b_e⟩ + ⟨fa_o, K_o b_o⟩] and ⟨gb_e⟩ = −⟨a_e⟩⁻¹[⟨K′_e a_e, gb_e⟩ + ⟨K_o a_o, gb_o⟩].
(c) With A_e = ‖a_e‖_∞, A_o = ‖a_o‖_∞, A′_e = ‖a_e − ⟨a_e⟩‖_∞ (and B's likewise) and m = inf a · inf b:
  ρ̃(π) ≤ (A_eB_e κ̃ + A_oB_o κ_odd)/m + (A_eB′_e κ̃ + A_oB_o κ_odd)(A′_eB_e κ̃ + A_oB_o κ_odd)/(m⟨a_e⟩⟨b_e⟩).
  The term A_oB_oκ_odd/m — THE LEAK — is LINEAR in the vortex channel κ_odd (= κ_½ in 𝒯), while Turán's term is κ̃ ≤ κ_½².
*Proof.* (a) Average π over the four sign flips (U, V) ↦ (εU, ε′V): with a(εU) = a_e + εa_o, b(ε′V) = b_e + ε′b_o, K(εε′g) = K_e + εε′K_o, exactly
the monomials ε⁰ε′⁰ (a_eb_eK_e) and ε²ε′² (a_ob_oK_o) survive the average. (b) E_π[fg] = Z⁻¹⟨fa, 𝒦(gb)⟩ with 𝒦 the convolution by K; for even f,
g the parity of each product selects a_e(gb_e)K_e and a_o(gb_o)K_o (K_e annihilates odd functions, K_o even ones); split K_e = P₀ + K′_e. The
two centring conditions E_π f = Z⁻¹⟨fa, 𝒦b⟩ = 0 and E_π g = 0 are the stated formulas for ⟨fa_e⟩, ⟨gb_e⟩. (c) ‖K′_e‖ = κ̃ and ‖K_o‖ = κ_odd on
L²(Haar) (Schur: spin-j components are multiplied by κ_j); K′_e b_e = K′_e(b_e − ⟨b_e⟩). Normalise Var_π f = Var_π g = 1: since π_U = Z⁻¹a(K*b) ≥
Z⁻¹ inf a inf b (K ≥ 0, ∫K = 1), ‖f‖₂² ≤ Z/m, and likewise ‖g‖₂² ≤ Z/m. Cauchy–Schwarz term by term, then the supremum over f, g. ∎

**The leak is real (a sighted exact example; z4_leak.awk, record rec/z4_leak.txt, exact rationals).** On Z₄ (centre {0, 2}, quotient Z₂) with
convolution coefficients (1, k₁, k₂, k₁) — k₁ the centre-odd (vortex) characters, k₂ the quotient's — and tilts a = (A, 1, 1/A, 1), b likewise,
the quotient channel is the Pearson correlation of the parities, computed exactly. Known answers MET: untilted, ρ̃ = k₂ and ρ = k₁ exactly.
Tilted (all exact comparisons with k₁²):
| k₁ | k₂ | A = B | ρ̃ (quotient) | ρ (all functions) | ρ̃/ρ² | Turán slaving |
|---|---|---|---|---|---|---|
| 0.1 | 0.01 | 1 | 0.010000 | 0.100000 | 1.000 | holds (edge) |
| 0.1 | 0.01 | 2 | 0.026763 | 0.088988 | 3.38 | FAILS |
| 0.1 | 0.01 | 3 | 0.036743 | 0.075188 | 6.50 | FAILS |
| 0.1 | 0 | 2 | 0.017094 | 0.088889 | 2.16 | FAILS (the leak alone) |
| 0.03 | 0.0009 | 2 | 0.006153 | 0.026669 | 8.65 | FAILS |
The ratio grows as k₁ falls at fixed tilt — linear against quadratic — exactly the mechanism of (c). The record's one-step ordered cells
(ρ_EE/ρ_OO² = 1.85–3.26, M4 §7, marginal E[χ_½(A)] = 0.62: a strong tilt) sit in the same band; its two-step cells (0.07–0.28, E[χ_½(A)] =
0.146: a weak tilt) sit below one. M4's reading "the objects' direct coupling enters a Turán-like regime between the first and second step"
is this theorem: the tilt shrinks.

**SU(2) at first order (labelled: an expansion, not a bound).** With a = exp(½cχ_½(U)), b = exp(½cχ_½(V)) (a Wilson tilt of strength c along a
staple sum) and f = g = χ_1: Cov(χ_1(U), χ_1(V)) = κ_1 + ¼c²(κ_½ + κ_{3/2}) + O(c²κ̃, c⁴), since a_o = ½cχ_½ + O(c³), χ_1χ_½ = χ_½ + χ_{3/2},
and ⟨χ_½ + χ_{3/2}, K_o(χ_½ + χ_{3/2})⟩ = κ_½ + κ_{3/2}. For a Wilson-class K at strong coupling κ_1 ≈ (2/3)κ_½², so slaving (ρ̃ ≤ κ_½²) needs
¼c²κ_½ ≲ ⅓κ_½², i.e. c² ≲ (4/3)κ_½.

**THE ℤ⁴ CONSEQUENCE (first order, labelled).** For a Wilson-like coarse action at β′ the tilt of a link from its five other plaquettes has
c = β′|W|, |W| ≤ 5 the staple sum, and κ_½ ≈ β′/4: sup-form slaving of the pair-conditional laws needs β′|W|² ≲ 1/3, i.e. β′ ≲ 1/75 ≈ 0.013 at
the worst environment (|W| = 5) and β′ ≲ 1/15 ≈ 0.07 at a typical one (|W|² ≈ 5). At the two-step landing couplings (β′ ≈ 0.22–0.29) the
rigorous bound (c) is vacuous (A_oB_o/m = sinh²(5β′)e^{10β′} ≈ 74 at 0.29). **So Turán slaving does not control the SO(3) channel R̃ by the
vortex channel on ℤ⁴ in the window, and does not help (W-S)'s supremum; it holds on untilted convolutions (MK, exact 2D blocking) and returns
on ℤ⁴ only in deep strong coupling (β′ ≲ 0.01), where every criterion closes anyway.** By how much the action leaves the class: by the
odd tilt size A_oB_o/m of its conditional laws — O(25β′²) at small β′ in the sup, O(1) and above at the landing couplings.
