/-
  APERANTON -- THE BOUNDLESS, THE UV INTERFACE (the plan B7, 2026-10-28 23:4x): Σ1'S DELIVERY AS A DEFINITION, AND THE
  UNIFORMITY IT BUYS (Σ4), PROVED. The renormalisation-group steps from the cutoff to a fixed physical scale deliver a family of
  effective weights W_n, one per cutoff index n. The INTERFACE this road needs of them is one sentence: every W_n is a tilt of one
  base weight W₀ by a non-Wilson part δ_n with oscillation at most o_n along every site and mixed second differences at most Δ_n
  (`UVInterface`). THE UNIFORMITY THEOREM (`interdep_uniform_of_interface`, `rowsum_uniform_of_interface`): if W₀'s
  interdependence has row sums at most α₀, then every W_n's has row sums at most e^{o_n} α₀ + Σ_t (1 − e^{−Δ_n}), and when
  those are all at most α < 1 the comparison theorem's rate α and range R are the same for every n -- the physical gap one
  constant along the whole sequence (Scaling.lean's PhysicalGapAlong with Δ = log(1/α)/(R a₀ 2^{k₀})). Nothing here proves the
  interface holds: that is Σ1 (Bałaban's theorems, cited on the page) and Σ2 (the crossover bound); this file is what they are
  for. W = 0: Dobrushin's theorem; the interface as a definition and the uniformity through the sharp tilt constant are this
  file's. No sorry, no axiom, no native_decide.
-/
import Mathlib
import Aperanton.Dobrushin
import Aperanton.CrossoverCriterion

open Finset

namespace Aperanton

variable {S G : Type*} [Fintype S] [DecidableEq S] [Fintype G] [DecidableEq G] [Nonempty G]

/-- THE UV INTERFACE: a family of effective weights at one physical scale, each a tilt of the base weight by a part δ_n with
oscillation at most o_n s along the site s and mixed second difference at most Δ_n s t -/
structure UVInterface (W₀ : (S → G) → ℝ) (Wn : ℕ → (S → G) → ℝ) (o : ℕ → S → ℝ) (Δ : ℕ → S → S → ℝ) : Prop where
  tilt : ∀ n, ∃ δ : (S → G) → ℝ, (∀ ω, Wn n ω = W₀ ω * Real.exp (δ ω)) ∧ OscBound δ (o n) ∧ MixedDiff δ (Δ n)

/-- the tilted family's interdependence, cutoff by cutoff -/
theorem interdep_uniform_of_interface {W₀ : (S → G) → ℝ} (hW₀ : ∀ ω, 0 < W₀ ω) {C : S → S → ℝ} (hC : Interdep W₀ C)
    {Wn : ℕ → (S → G) → ℝ} {o : ℕ → S → ℝ} {Δ : ℕ → S → S → ℝ} (hI : UVInterface W₀ Wn o Δ) (n : ℕ) :
    Interdep (Wn n) (fun s t => Real.exp (o n s) * C s t + (1 - Real.exp (-Δ n s t))) := by
  obtain ⟨δ, hδ, hosc, hmix⟩ := hI.tilt n
  have heq : Wn n = tilt W₀ δ := funext fun ω => hδ ω
  rw [heq]
  exact interdep_tilt_sharp W₀ hW₀ C hC δ (o n) hosc (Δ n) hmix

/-- THE UNIFORM ROW SUM: one α for every cutoff -/
theorem rowsum_uniform_of_interface {W₀ : (S → G) → ℝ} {C : S → S → ℝ} (α₀ : ℝ) (hrow₀ : ∀ s, ∑ t, C s t ≤ α₀)
    {o : ℕ → S → ℝ} {Δ : ℕ → S → S → ℝ} (α : ℝ)
    (hα : ∀ n s, Real.exp (o n s) * α₀ + ∑ t, (1 - Real.exp (-Δ n s t)) ≤ α) (n : ℕ) (s : S) :
    ∑ t, (Real.exp (o n s) * C s t + (1 - Real.exp (-Δ n s t))) ≤ α :=
  le_trans (rowsum_tilt_le_sharp C α₀ hrow₀ (o n) (Δ n) s) (hα n s)

/-- THE UNIFORM DECAY: with the interface and one α < 1 for every cutoff, the covariance bound of cov_le holds for every W_n
with the same rate α and range R -- the physical gap along the sequence is one constant -/
theorem cov_le_uniform_of_interface {W₀ : (S → G) → ℝ} (hW₀ : ∀ ω, 0 < W₀ ω) {C : S → S → ℝ} (hC : Interdep W₀ C)
    (hC0 : ∀ s t, 0 ≤ C s t) (α₀ : ℝ) (hrow₀ : ∀ s, ∑ t, C s t ≤ α₀)
    {Wn : ℕ → (S → G) → ℝ} {o : ℕ → S → ℝ} {Δ : ℕ → S → S → ℝ} (hI : UVInterface W₀ Wn o Δ)
    (ho : ∀ n s, 0 ≤ o n s) (hΔ : ∀ n s t, 0 ≤ Δ n s t)
    (α : ℝ) (hα0 : 0 ≤ α) (hα1 : α < 1) (hα : ∀ n s, Real.exp (o n s) * α₀ + ∑ t, (1 - Real.exp (-Δ n s t)) ≤ α)
    (φ : S → ℕ) (hφ : ∀ n, RangeOne (fun s t => Real.exp (o n s) * C s t + (1 - Real.exp (-Δ n s t))) φ)
    (f : (S → G) → ℝ) (d : S → ℝ) (hf : OscBound f d) (a R : ℕ) (hd : ∀ t, a < φ t → d t = 0)
    (g : (S → G) → ℝ) (hg : ∀ ω, 0 < g ω) (reads : S → Prop) [DecidablePred reads]
    (hfree : ∀ s, ¬ reads s → ∀ ω x, g (Function.update ω s x) = g ω)
    (hreads : ∀ t, φ t < a + R → ¬ reads t) (n : ℕ) :
    |gibbs (Wn n) (fun ω => f ω * g ω) - gibbs (Wn n) f * gibbs (Wn n) g| ≤
      gibbs (Wn n) g * ((∑ t, if reads t then (1 : ℝ) else 0) * (∑ t, d t) * α ^ R / (1 - α)) := by
  obtain ⟨δ, hδ, hosc, hmix⟩ := hI.tilt n
  have hWn : ∀ ω, 0 < Wn n ω := fun ω => by rw [hδ ω]; exact mul_pos (hW₀ ω) (Real.exp_pos _)
  have hCn : ∀ s t, 0 ≤ Real.exp (o n s) * C s t + (1 - Real.exp (-Δ n s t)) := by
    intro s t
    have h1 : 0 ≤ Real.exp (o n s) * C s t := mul_nonneg (Real.exp_pos _).le (hC0 s t)
    have h2 : Real.exp (-Δ n s t) ≤ 1 := Real.exp_le_one_iff.mpr (by linarith [hΔ n s t])
    linarith
  exact cov_le (Wn n) hWn _ hCn (interdep_uniform_of_interface hW₀ hC hI n) α hα0 hα1
    (rowsum_uniform_of_interface α₀ hrow₀ α hα n) φ (hφ n) f d hf a R hd g hg reads hfree hreads

end Aperanton
