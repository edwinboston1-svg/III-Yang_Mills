
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
= three-dimensional decimation, ∝ L^{−1/2}), averaged map 3.54, 5.28, ≈ 6.0 (at the alias bound → 2π).

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
