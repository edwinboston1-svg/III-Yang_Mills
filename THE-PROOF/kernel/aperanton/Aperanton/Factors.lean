/-
  APERANTON -- THE BOUNDLESS, stage Β3b (ADDENDUM I, THE ROAD): THE INTERDEPENDENCE OF A FACTOR SYSTEM.

  A weight that is a product of positive factors, each reading a finite set of sites and lying between lo and hi
  (`FactorSystem`, `weight`).  The one-site conditional at s is the normalised product of the factors that read s
  (`cond_weight_eq`): every other factor cancels.  Changing site t ≠ s moves each factor reading both s and t by a
  ratio at most hi/lo and no other factor reading s (`factor_ratio`), so the two conditionals are pointwise within
  ρ² with ρ = ∏_{i reads s, t} hi i / lo i (`cond_pointwise`), and by Dobrushin.lean's pointwise ratio bound their
  total-variation distance is at most 1 − ρ⁻² (`interdep_factors`): THE INTERDEPENDENCE MATRIX OF A FACTOR SYSTEM
  IS C s t = 1 − ρ(s, t)⁻², zero where no factor reads both.  Its row sums bound the Dobrushin constant of any
  such Gibbs weight -- the x-transfer slab among them (Slab.lean).  W = 0 for Dobrushin's estimate; the factor form
  is the build.  No sorry, no axiom, no native_decide.
-/
import Mathlib
import Aperanton.Dobrushin

open Finset

namespace Aperanton

section Factors

variable {S : Type*} [Fintype S] [DecidableEq S] {G : Type*} [Fintype G] [DecidableEq G] [Nonempty G]
  {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- a factor system on the sites S with spins G: factors indexed by ι, each reading `sites i`, positive, bounded -/
structure FactorSystem (S G ι : Type*) [Fintype S] [DecidableEq S] [Fintype G] [Fintype ι] where
  sites : ι → Finset S
  w : ι → (S → G) → ℝ
  lo : ι → ℝ
  hi : ι → ℝ
  lo_pos : ∀ i, 0 < lo i
  w_lo : ∀ i ω, lo i ≤ w i ω
  w_hi : ∀ i ω, w i ω ≤ hi i
  w_local : ∀ i (ω : S → G) (s : S) (g : G), s ∉ sites i → w i (Function.update ω s g) = w i ω

variable (F : FactorSystem S G ι)

/-- the weight: the product of the factors -/
def weight (ω : S → G) : ℝ := ∏ i, F.w i ω

theorem weight_pos (ω : S → G) : 0 < weight F ω :=
  prod_pos fun i _ => lt_of_lt_of_le (F.lo_pos i) (F.w_lo i ω)

theorem w_pos (i : ι) (ω : S → G) : 0 < F.w i ω := lt_of_lt_of_le (F.lo_pos i) (F.w_lo i ω)

theorem hi_pos (i : ι) : 0 < F.hi i := by
  obtain ⟨ω⟩ : Nonempty (S → G) := ⟨fun _ => Classical.arbitrary G⟩
  exact lt_of_lt_of_le (w_pos F i ω) (F.w_hi i ω)

theorem one_le_hi_div_lo (i : ι) : 1 ≤ F.hi i / F.lo i := by
  obtain ⟨ω⟩ : Nonempty (S → G) := ⟨fun _ => Classical.arbitrary G⟩
  rw [le_div_iff₀ (F.lo_pos i), one_mul]
  exact le_trans (F.w_lo i ω) (F.w_hi i ω)

/-- the factors reading the site s -/
def touch (s : S) : Finset ι := univ.filter fun i => s ∈ F.sites i

/-- the product of the factors reading s, at the configuration updated at s -/
def partialW (s : S) (ω : S → G) (g : G) : ℝ := ∏ i ∈ touch F s, F.w i (Function.update ω s g)

theorem partial_pos (s : S) (ω : S → G) (g : G) : 0 < partialW F s ω g :=
  prod_pos fun i _ => w_pos F i _

/-- the factors not reading s do not depend on the spin at s -/
theorem prod_not_touch (s : S) (ω : S → G) (g : G) :
    ∏ i ∈ univ.filter (fun i => ¬ s ∈ F.sites i), F.w i (Function.update ω s g) =
      ∏ i ∈ univ.filter (fun i => ¬ s ∈ F.sites i), F.w i ω := by
  refine prod_congr rfl fun i hi => ?_
  exact F.w_local i ω s g (mem_filter.mp hi).2

/-- the weight at an update splits into the touching product and a constant -/
theorem weight_update_eq (s : S) (ω : S → G) (g : G) :
    weight F (Function.update ω s g) =
      partialW F s ω g * ∏ i ∈ univ.filter (fun i => ¬ s ∈ F.sites i), F.w i ω := by
  unfold weight partialW touch
  rw [← prod_not_touch F s ω g, prod_filter_mul_prod_filter_not]

/-- THE CONDITIONAL OF A FACTOR SYSTEM is the normalised touching product -/
theorem cond_weight_eq (s : S) (ω : S → G) (g : G) :
    cond (weight F) s ω g = partialW F s ω g / ∑ g', partialW F s ω g' := by
  unfold cond zsite
  simp only [weight_update_eq]
  rw [← sum_mul]
  have hc : 0 < ∏ i ∈ univ.filter (fun i => ¬ s ∈ F.sites i), F.w i ω := prod_pos fun i _ => w_pos F i ω
  rw [mul_div_mul_right _ _ hc.ne']

/-- the amplification of the conditional at s by a change at t: the product over the factors reading both -/
noncomputable def rho (s t : S) : ℝ := ∏ i ∈ (touch F s).filter (fun i => t ∈ F.sites i), F.hi i / F.lo i

theorem one_le_rho (s t : S) : 1 ≤ rho F s t :=
  Finset.one_le_prod₀ fun i _ => one_le_hi_div_lo F i

theorem rho_pos (s t : S) : 0 < rho F s t := lt_of_lt_of_le one_pos (one_le_rho F s t)

/-- THE FACTOR RATIO: a factor reading s moves by at most hi/lo under a change at t it reads, and not at all
under a change at t it does not read -/
theorem factor_ratio (s t : S) (hst : s ≠ t) (ω : S → G) (h : G) (g : G) (i : ι) (hi : s ∈ F.sites i) :
    F.w i (Function.update ω s g) ≤ (if t ∈ F.sites i then F.hi i / F.lo i else 1) *
      F.w i (Function.update (Function.update ω t h) s g) := by
  by_cases ht : t ∈ F.sites i
  · rw [if_pos ht]
    have h1 := F.w_hi i (Function.update ω s g)
    have h2 := F.w_lo i (Function.update (Function.update ω t h) s g)
    have hlo := F.lo_pos i
    calc F.w i (Function.update ω s g) ≤ F.hi i := h1
      _ = F.hi i / F.lo i * F.lo i := by field_simp
      _ ≤ F.hi i / F.lo i * F.w i (Function.update (Function.update ω t h) s g) :=
          mul_le_mul_of_nonneg_left h2 (div_nonneg (hi_pos F i).le hlo.le)
  · rw [if_neg ht, one_mul]
    have hts : t ≠ s := fun e => hst e.symm
    rw [Function.update_comm hts, F.w_local i (Function.update ω s g) t h ht]

/-- the touching products at ω and at the update at t are within ρ of each other, both ways -/
theorem partial_le (s t : S) (hst : s ≠ t) (ω : S → G) (h : G) (g : G) :
    partialW F s ω g ≤ rho F s t * partialW F s (Function.update ω t h) g := by
  unfold partialW rho
  have hsplit : ∏ i ∈ touch F s, F.w i (Function.update ω s g) ≤
      ∏ i ∈ touch F s, ((if t ∈ F.sites i then F.hi i / F.lo i else 1) *
        F.w i (Function.update (Function.update ω t h) s g)) := by
    refine Finset.prod_le_prod₀ (fun i _ => (w_pos F i _).le) fun i hi => ?_
    exact factor_ratio F s t hst ω h g i (mem_filter.mp hi).2
  rw [prod_mul_distrib] at hsplit
  have hρ : ∏ i ∈ touch F s, (if t ∈ F.sites i then F.hi i / F.lo i else 1) =
      ∏ i ∈ (touch F s).filter (fun i => t ∈ F.sites i), F.hi i / F.lo i := by
    rw [prod_ite, prod_const_one, mul_one]
  rw [hρ] at hsplit
  exact hsplit

theorem partial_le' (s t : S) (hst : s ≠ t) (ω : S → G) (h : G) (g : G) :
    partialW F s (Function.update ω t h) g ≤ rho F s t * partialW F s ω g := by
  have := partial_le F s t hst (Function.update ω t h) (ω t) g
  rwa [Function.update_idem, Function.update_eq_self] at this

/-- THE POINTWISE RATIO of the two conditionals is at most ρ² -/
theorem cond_pointwise (s t : S) (hst : s ≠ t) (ω : S → G) (h : G) (g : G) :
    cond (weight F) s ω g ≤ rho F s t ^ 2 * cond (weight F) s (Function.update ω t h) g := by
  rw [cond_weight_eq, cond_weight_eq]
  have hρ := rho_pos F s t
  have hZ : 0 < ∑ g', partialW F s ω g' := sum_pos (fun g' _ => partial_pos F s ω g') univ_nonempty
  have hZ' : 0 < ∑ g', partialW F s (Function.update ω t h) g' :=
    sum_pos (fun g' _ => partial_pos F s _ g') univ_nonempty
  have hsum : ∑ g', partialW F s (Function.update ω t h) g' ≤ rho F s t * ∑ g', partialW F s ω g' := by
    rw [mul_sum]
    exact sum_le_sum fun g' _ => partial_le' F s t hst ω h g'
  have hpt := partial_le F s t hst ω h g
  rw [div_le_iff₀ hZ]
  calc partialW F s ω g ≤ rho F s t * partialW F s (Function.update ω t h) g := hpt
    _ = rho F s t * partialW F s (Function.update ω t h) g / (∑ g', partialW F s (Function.update ω t h) g') *
          (∑ g', partialW F s (Function.update ω t h) g') := by field_simp
    _ ≤ rho F s t * partialW F s (Function.update ω t h) g / (∑ g', partialW F s (Function.update ω t h) g') *
          (rho F s t * ∑ g', partialW F s ω g') := by
        refine mul_le_mul_of_nonneg_left hsum ?_
        exact div_nonneg (mul_nonneg hρ.le (partial_pos F s _ g).le) hZ'.le
    _ = rho F s t ^ 2 * (partialW F s (Function.update ω t h) g / ∑ g', partialW F s (Function.update ω t h) g') *
          ∑ g', partialW F s ω g' := by ring

/-- THE INTERDEPENDENCE MATRIX OF A FACTOR SYSTEM: C s t = 1 − ρ(s, t)⁻² off the diagonal -/
noncomputable def interdepMat (s t : S) : ℝ := if s = t then 0 else 1 - 1 / rho F s t ^ 2

theorem interdepMat_nonneg (s t : S) : 0 ≤ interdepMat F s t := by
  unfold interdepMat
  split_ifs
  · exact le_refl 0
  · have h1 := one_le_rho F s t
    have h2 : 1 ≤ rho F s t ^ 2 := by nlinarith
    have : 1 / rho F s t ^ 2 ≤ 1 := by rw [div_le_one (by linarith)]; exact h2
    linarith

theorem interdep_factors : Interdep (weight F) (interdepMat F) := by
  intro s t hst ω h
  unfold interdepMat
  rw [if_neg hst]
  have hW := weight_pos F
  have h1 := one_le_rho F s t
  have hr : 1 ≤ rho F s t ^ 2 := by nlinarith
  exact tv_le_of_pointwise _ _ (cond_nonneg _ hW s ω) (cond_sum _ hW s ω) (cond_sum _ hW s _)
    (rho F s t ^ 2) hr (fun g => cond_pointwise F s t hst ω h g)

/-- where no factor reads both sites the interdependence vanishes -/
theorem interdepMat_eq_zero_of_disjoint (s t : S) (hdis : ∀ i, s ∈ F.sites i → t ∉ F.sites i) :
    interdepMat F s t = 0 := by
  unfold interdepMat
  split_ifs with h
  · rfl
  · have hρ : rho F s t = 1 := by
      unfold rho
      apply prod_eq_one
      intro i hi
      exact absurd (mem_filter.mp hi).2 (hdis i (mem_filter.mp (mem_filter.mp hi).1).2)
    rw [hρ]; norm_num

end Factors

end Aperanton
