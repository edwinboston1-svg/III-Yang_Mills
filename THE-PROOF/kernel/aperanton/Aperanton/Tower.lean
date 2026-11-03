/-
  ΑΠΕΡΑΝΤΟΝ — THE TOWER'S COMPOSITION: THE LAW OF TOTAL COVARIANCE OVER A BLOCK, AND THE FIBRE BOUND (Stage II, Tower.lean)

  T1 reads the gap as the triviality of every scale's localisation kernel; T2 certifies each scale by Dobrushin's criterion on
  the fine measure constrained on the coarse variables.  What composes the scales is an EXACT identity: conditioning on the
  sites outside a block b (the coarse data under decimation), the covariance of two observables splits as

      cov(f, g) = ⟨ cov(f, g | outside b) ⟩ + cov( E[f | outside b], E[g | outside b] ),

  the first term the constrained (fine-scale) covariance — a covariance on the FIBRE over b, bounded by Dobrushin's cov_le with
  the fibre's own interdependence matrix (the constrained criterion T2 measures) — the second a covariance of functions of the
  coarse data alone, bounded at the coarse scale by the same criterion on the marginal (whose interactions TowerStep.lean
  shows exponentially local; that bound is part 2, owed).  Here: the identity (cov_total_block), the fibre identities
  (condExpB_eq_gibbs_fibre, condCovB_eq_cov_fibre), the fibre bound (condCov_le_fibre) and the two-term bound
  (cov_le_two_scales).  No sorry, no axiom, no native_decide.
-/
import Aperanton.Block

open Finset

namespace Aperanton

section Tower

variable {S : Type*} [Fintype S] [DecidableEq S] {G : Type*} [Fintype G] [DecidableEq G] [Nonempty G]
  {β : Type*} [Fintype β] [DecidableEq β]

/-- the covariance under the weight W -/
noncomputable def cov (W : (S → G) → ℝ) (f g : (S → G) → ℝ) : ℝ :=
  gibbs W (fun ω => f ω * g ω) - gibbs W f * gibbs W g

/-- the conditional covariance given the sites outside block b -/
noncomputable def condCovB (W : (S → G) → ℝ) (blk : S → β) (b : β) (f g : (S → G) → ℝ) (ω : S → G) : ℝ :=
  condExpB W blk b (fun ω' => f ω' * g ω') ω - condExpB W blk b f ω * condExpB W blk b g ω

/-- the fibre weight over block b at the outside data ω -/
noncomputable def fibreW (W : (S → G) → ℝ) (blk : S → β) (b : β) (ω : S → G) : (Blk blk b → G) → ℝ :=
  fun ξ => W (patch blk b ω ξ)

theorem fibreW_pos (W : (S → G) → ℝ) (hW : ∀ ω, 0 < W ω) (blk : S → β) (b : β) (ω : S → G) :
    ∀ ξ, 0 < fibreW W blk b ω ξ := fun ξ => hW _

/-- the block conditional expectation is the Gibbs expectation on the fibre -/
theorem condExpB_eq_gibbs_fibre (W : (S → G) → ℝ) (blk : S → β) (b : β) (f : (S → G) → ℝ) (ω : S → G) :
    condExpB W blk b f ω = gibbs (fibreW W blk b ω) (fun ξ => f (patch blk b ω ξ)) := by
  simp only [condExpB, condB, gibbs, fibreW, zblk]
  rw [Finset.sum_div]
  apply Finset.sum_congr rfl
  intro ξ _
  ring

/-- the conditional covariance is the covariance on the fibre -/
theorem condCovB_eq_cov_fibre (W : (S → G) → ℝ) (blk : S → β) (b : β) (f g : (S → G) → ℝ) (ω : S → G) :
    condCovB W blk b f g ω
      = cov (fibreW W blk b ω) (fun ξ => f (patch blk b ω ξ)) (fun ξ => g (patch blk b ω ξ)) := by
  unfold condCovB cov
  rw [condExpB_eq_gibbs_fibre, condExpB_eq_gibbs_fibre, condExpB_eq_gibbs_fibre]

/-- the conditional expectation does not depend on the block's own sites -/
theorem condExpB_free_on_block (W : (S → G) → ℝ) (blk : S → β) (b : β) (f : (S → G) → ℝ) (t : S)
    (ht : blk t = b) (ω : S → G) (x : G) :
    condExpB W blk b f (Function.update ω t x) = condExpB W blk b f ω :=
  condExpB_update_mem W blk b f ω t ht x

/-- THE LAW OF TOTAL COVARIANCE OVER A BLOCK -/
theorem cov_total_block (W : (S → G) → ℝ) (hW : ∀ ω, 0 < W ω) (blk : S → β) (b : β) (f g : (S → G) → ℝ) :
    cov W f g = gibbs W (condCovB W blk b f g) + cov W (condExpB W blk b f) (condExpB W blk b g) := by
  unfold cov condCovB
  have h1 : gibbs W (fun ω => f ω * g ω) = gibbs W (condExpB W blk b (fun ω' => f ω' * g ω')) :=
    (gibbs_condExpB W hW blk b _).symm
  have hf : gibbs W (condExpB W blk b f) = gibbs W f := gibbs_condExpB W hW blk b f
  have hg : gibbs W (condExpB W blk b g) = gibbs W g := gibbs_condExpB W hW blk b g
  rw [gibbs_sub W (condExpB W blk b (fun ω' => f ω' * g ω')) (fun ω => condExpB W blk b f ω * condExpB W blk b g ω),
    hf, hg, h1]
  ring

/-- THE FIBRE BOUND: the constrained covariance at outside data ω is bounded by Dobrushin's cov_le on the fibre, with the
    fibre's interdependence matrix C (row sums ≤ α < 1, range one in the level φ), f's oscillation d supported at levels ≤ a,
    g positive and reading only levels ≥ a + R -/
theorem condCov_le_fibre (W : (S → G) → ℝ) (hW : ∀ ω, 0 < W ω) (blk : S → β) (b : β) (f g : (S → G) → ℝ) (ω : S → G)
    (C : Blk blk b → Blk blk b → ℝ) (hC : ∀ s t, 0 ≤ C s t) (hCW : Interdep (fibreW W blk b ω) C)
    (α : ℝ) (hα0 : 0 ≤ α) (hα1 : α < 1) (hrow : ∀ s, ∑ t, C s t ≤ α) (φ : Blk blk b → ℕ) (hφ : RangeOne C φ)
    (d : Blk blk b → ℝ) (hf : OscBound (fun ξ => f (patch blk b ω ξ)) d) (a R : ℕ) (hd : ∀ t, a < φ t → d t = 0)
    (hg : ∀ ξ, 0 < g (patch blk b ω ξ)) (reads : Blk blk b → Prop) [DecidablePred reads]
    (hfree : ∀ s, ¬ reads s → ∀ ξ x, g (patch blk b ω (Function.update ξ s x)) = g (patch blk b ω ξ))
    (hreads : ∀ t, φ t < a + R → ¬ reads t) :
    |condCovB W blk b f g ω| ≤
      gibbs (fibreW W blk b ω) (fun ξ => g (patch blk b ω ξ)) *
        ((∑ t, if reads t then (1 : ℝ) else 0) * (∑ t, d t) * α ^ R / (1 - α)) := by
  rw [condCovB_eq_cov_fibre]
  unfold cov
  exact cov_le (fibreW W blk b ω) (fibreW_pos W hW blk b ω) C hC hCW α hα0 hα1 hrow φ hφ
    (fun ξ => f (patch blk b ω ξ)) d hf a R hd (fun ξ => g (patch blk b ω ξ)) hg reads hfree hreads

/-- the constrained covariance's expectation is bounded by its uniform bound -/
theorem abs_gibbs_condCov_le (W : (S → G) → ℝ) (hW : ∀ ω, 0 < W ω) (blk : S → β) (b : β) (f g : (S → G) → ℝ)
    (K : ℝ) (hK : ∀ ω, |condCovB W blk b f g ω| ≤ K) : |gibbs W (condCovB W blk b f g)| ≤ K :=
  abs_gibbs_le W hW _ K hK

/-- THE TWO-SCALE BOUND: a uniform bound on the constrained covariance and a bound on the coarse covariance bound the whole -/
theorem cov_le_two_scales (W : (S → G) → ℝ) (hW : ∀ ω, 0 < W ω) (blk : S → β) (b : β) (f g : (S → G) → ℝ)
    (K₀ K₁ : ℝ) (h₀ : ∀ ω, |condCovB W blk b f g ω| ≤ K₀)
    (h₁ : |cov W (condExpB W blk b f) (condExpB W blk b g)| ≤ K₁) :
    |cov W f g| ≤ K₀ + K₁ := by
  rw [cov_total_block W hW blk b f g]
  calc |gibbs W (condCovB W blk b f g) + cov W (condExpB W blk b f) (condExpB W blk b g)|
      ≤ |gibbs W (condCovB W blk b f g)| + |cov W (condExpB W blk b f) (condExpB W blk b g)| := abs_add_le _ _
    _ ≤ K₀ + K₁ := add_le_add (abs_gibbs_condCov_le W hW blk b f g K₀ h₀) h₁

end Tower

end Aperanton
