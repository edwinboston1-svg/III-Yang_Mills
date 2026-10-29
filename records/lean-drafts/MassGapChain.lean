/-
  APERANTON -- THE BOUNDLESS, THE CHAIN AS ONE THEOREM (the plan B8, 2026-10-29 00:5x): Σ1's interface and Σ2's budget give Σ3's
  decay with ONE rate for every cutoff, and the physical gap along the scaling sequence is one constant. THE HYPOTHESES, exactly:
  (i) `UVInterface W₀ Wn o Δ` -- every effective weight at the physical scale is the base weight tilted by a part of oscillation
  at most o_n and mixed second difference at most Δ_n (Σ1, cited on the page; UVInterface.lean); (ii) `CrossoverBudget` -- the
  base weight's Dobrushin interdependence C has row sums at most α₀, and every cutoff's budget e^{o_n s} α₀ + Σ_t (1 − e^{−Δ_n s t})
  sits under one α < 1 (Σ2, the open hypothesis, stated as an object: the influence budget of the blocked action at the
  crossover scale, master plan §57, §62, §63). THE CONCLUSION: cov_le's covariance bound for every W_n with the one rate α and
  range R (`chain_cov_le`), hence the physical clustering rate log(1/α)/(R a_c) at the coarse spacing a_c, the same at every
  cutoff (`physicalGap_of_budget`: PhysicalGapAlong with the fine-lattice rate log(1/α)·a_n/(R a_c)).
  THE FORM OF Σ2 (corrected 01:1x, law 18 at the 00:4x reading): the sites S are THE COARSE LINKS at spacing a_c and the spin
  G is ONE SU(2) element per coarse link -- the blocked measure's variables, of one type at every rung -- so `Interdep` is
  Dobrushin's single-site criterion on the BLOCKED measure and the theorem's decay is for observables OF THE COARSE VARIABLES.
  Instantiating S as blocks with G a block's whole configuration (the 00:4x proposal) is NOT a usable form: the whole-block total
  variation under a neighbouring block's change compounds the ~L³ boundary links' sensitivities and is ~1 at any block larger
  than a few links. Fine observables' clustering needs the FIBRE CLAUSE beside this file (the conditional law of the fine
  variables given the coarse ones quasi-local; THE GROUND's Hypothesis III and Theorem 8.6), which has no non-abelian proof and
  is named as Σ2's second half, not assumed here. Nothing here proves either hypothesis: the file is what Σ1 and Σ2 are FOR, and the
  statement every instance (the hierarchical model's, §63 RESULTS 2, closed at k = 8) is an instance of.  W = 0: Dobrushin's
  theorem and the scaling definitions; the composition and the form are this file's. No sorry, no axiom, no native_decide.
-/
import Mathlib
import Aperanton.Dobrushin
import Aperanton.CrossoverCriterion
import Aperanton.UVInterface
import Aperanton.Scaling

open Finset

namespace Aperanton

variable {S G : Type*} [Fintype S] [DecidableEq S] [Fintype G] [DecidableEq G] [Nonempty G]

/-- THE Σ2 HYPOTHESIS AS AN OBJECT: the base weight's interdependence with its row sums, and the influence budget of every
cutoff's tilt under one α < 1 -/
structure CrossoverBudget (W₀ : (S → G) → ℝ) (C : S → S → ℝ) (α₀ : ℝ) (o : ℕ → S → ℝ) (Δ : ℕ → S → S → ℝ) (α : ℝ) :
    Prop where
  interdep : Interdep W₀ C
  nonneg : ∀ s t, 0 ≤ C s t
  row : ∀ s, ∑ t, C s t ≤ α₀
  budget : ∀ n s, Real.exp (o n s) * α₀ + ∑ t, (1 - Real.exp (-Δ n s t)) ≤ α
  α_nonneg : 0 ≤ α
  α_lt_one : α < 1

/-- THE CHAIN, Σ1 + Σ2 ⟹ Σ3 UNIFORMLY: under the interface and the budget, every cutoff's weight satisfies cov_le's covariance
bound with the one rate α and range R -/
theorem chain_cov_le {W₀ : (S → G) → ℝ} (hW₀ : ∀ ω, 0 < W₀ ω)
    {Wn : ℕ → (S → G) → ℝ} {o : ℕ → S → ℝ} {Δ : ℕ → S → S → ℝ} (hI : UVInterface W₀ Wn o Δ)
    (ho : ∀ n s, 0 ≤ o n s) (hΔ : ∀ n s t, 0 ≤ Δ n s t)
    {C : S → S → ℝ} {α₀ α : ℝ} (hB : CrossoverBudget W₀ C α₀ o Δ α)
    (φ : S → ℕ) (hφ : ∀ n, RangeOne (fun s t => Real.exp (o n s) * C s t + (1 - Real.exp (-Δ n s t))) φ)
    (f : (S → G) → ℝ) (d : S → ℝ) (hf : OscBound f d) (a R : ℕ) (hd : ∀ t, a < φ t → d t = 0)
    (g : (S → G) → ℝ) (hg : ∀ ω, 0 < g ω) (reads : S → Prop) [DecidablePred reads]
    (hfree : ∀ s, ¬ reads s → ∀ ω x, g (Function.update ω s x) = g ω)
    (hreads : ∀ t, φ t < a + R → ¬ reads t) (n : ℕ) :
    |gibbs (Wn n) (fun ω => f ω * g ω) - gibbs (Wn n) f * gibbs (Wn n) g| ≤
      gibbs (Wn n) g * ((∑ t, if reads t then (1 : ℝ) else 0) * (∑ t, d t) * α ^ R / (1 - α)) :=
  cov_le_uniform_of_interface hW₀ hB.interdep hB.nonneg α₀ hB.row hI ho hΔ α hB.α_nonneg hB.α_lt_one hB.budget
    φ hφ f d hf a R hd g hg reads hfree hreads n

/-- THE PHYSICAL RATE: a covariance decay α per coarse step of spacing a_c and range R is the physical rate
log(1/α)/(R a_c), the same at every cutoff; along any scaling sequence the fine-lattice rate log(1/α)·a_n/(R a_c) carries it -/
theorem physicalGap_of_budget (Sc : Scaling) (α : ℝ) (hα0 : 0 < α) (hα1 : α < 1) (R : ℕ) (hR : 0 < R)
    (a_c : ℝ) (hac : 0 < a_c) :
    PhysicalGapAlong Sc (fun n => Real.log (1 / α) * Sc.a n / (R * a_c)) (Real.log (1 / α) / (R * a_c)) := by
  intro n
  have han : 0 < Sc.a n := Sc.a_pos n
  have hRac : 0 < (R : ℝ) * a_c := mul_pos (by exact_mod_cast hR) hac
  rw [le_div_iff₀ han]
  field_simp

/-- the physical rate is positive: α < 1 -/
theorem physicalRate_pos (α : ℝ) (hα0 : 0 < α) (hα1 : α < 1) (R : ℕ) (hR : 0 < R) (a_c : ℝ) (hac : 0 < a_c) :
    0 < Real.log (1 / α) / (R * a_c) := by
  apply div_pos
  · rw [one_div]
    exact Real.log_pos (one_lt_inv_iff₀.mpr ⟨hα0, hα1⟩)
  · exact mul_pos (by exact_mod_cast hR) hac

end Aperanton
