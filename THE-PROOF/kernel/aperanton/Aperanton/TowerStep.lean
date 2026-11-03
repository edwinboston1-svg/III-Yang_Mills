/-
  ΑΠΕΡΑΝΤΟΝ — THE TOWER'S STEP: THE LOCALITY OF THE RENORMALISED INTERACTION (Stage II, the first lemma of Tower.lean)

  T2 (the criterion-controlled renormalisation) certifies each scale by Dobrushin's comparison theorem on the fine measure
  constrained on the coarse variables and needs, for the NEXT scale, that the renormalised interaction between two coarse
  variables decays in their distance.  This file proves exactly that from Dobrushin.lean's cov_le:

    a coarse variable enters the fine weight W as a positive local factor g (changing it multiplies W by g); for two coarse
    variables i, j whose factors g_i, g_j are supported at level distance R in the interdependence range, the mixed second
    difference of the renormalised Hamiltonian H' = -log Z,

        Δ_i Δ_j H' = log [ Z · Z_{ij} / (Z_i · Z_j) ] = log [ ⟨g_i g_j⟩ / (⟨g_i⟩⟨g_j⟩) ],

    is bounded by 2 ε with ε = N_j · D_i · α^R / ((1 - α) · m_i), where α is the fine measure's Dobrushin coefficient, N_j the
    number of sites g_j reads, D_i the total oscillation of g_i and m_i its positive lower bound — whenever ε ≤ 1/2.

  So the effective action at the next scale is exponentially local with the fine scale's Dobrushin rate: the tower's step.
  No sorry, no axiom, no native_decide.
-/
import Aperanton.Dobrushin

open Finset

namespace TowerStep

variable {S G : Type*} [Fintype S] [DecidableEq S] [Fintype G] [DecidableEq G] [Nonempty G]

open Aperanton

/-- |log x| ≤ 2 |x - 1| for x ≥ 1/2 -/
theorem abs_log_le_two_abs_sub_one (x : ℝ) (hx : 1 / 2 ≤ x) : |Real.log x| ≤ 2 * |x - 1| := by
  have hx0 : 0 < x := by linarith
  have h1 := Real.log_le_sub_one_of_pos hx0
  have h2 := Real.one_sub_inv_le_log_of_pos hx0
  rcases le_or_gt 1 x with h | h
  · have hl : 0 ≤ Real.log x := Real.log_nonneg h
    rw [abs_of_nonneg hl, abs_of_nonneg (by linarith : (0 : ℝ) ≤ x - 1)]
    linarith
  · have hl : Real.log x ≤ 0 := Real.log_nonpos (le_of_lt hx0) (le_of_lt h)
    rw [abs_of_nonpos hl, abs_of_neg (by linarith : x - 1 < 0)]
    -- -log x ≤ x⁻¹ - 1 = (1 - x)/x ≤ 2 (1 - x) since x ≥ 1/2
    have hinv : x⁻¹ - 1 ≤ 2 * (1 - x) := by
      rw [inv_eq_one_div]
      rw [div_sub_one (ne_of_gt hx0), div_le_iff₀ hx0]
      nlinarith
    linarith

/-- the Gibbs expectation of a positive function is positive -/
theorem gibbs_pos (W : (S → G) → ℝ) (hW : ∀ ω, 0 < W ω) (g : (S → G) → ℝ) (hg : ∀ ω, 0 < g ω) :
    0 < gibbs W g := by
  unfold gibbs
  apply div_pos
  · exact Finset.sum_pos (fun ω _ => mul_pos (hW ω) (hg ω)) ⟨fun _ => Classical.arbitrary G, Finset.mem_univ _⟩
  · exact sum_W_pos W hW

/-- the mixed second difference of the renormalised Hamiltonian is the normalised covariance ratio:
    Z · Z_{ij} / (Z_i · Z_j) = ⟨g_i g_j⟩ / (⟨g_i⟩ ⟨g_j⟩) -/
theorem mixed_difference_eq (W : (S → G) → ℝ) (hW : ∀ ω, 0 < W ω) (gi gj : (S → G) → ℝ)
    (hgi : ∀ ω, 0 < gi ω) (hgj : ∀ ω, 0 < gj ω) :
    (∑ ω, W ω) * (∑ ω, gi ω * gj ω * W ω) / ((∑ ω, gi ω * W ω) * (∑ ω, gj ω * W ω))
      = gibbs W (fun ω => gi ω * gj ω) / (gibbs W gi * gibbs W gj) := by
  have hZ : 0 < ∑ ω, W ω := sum_W_pos W hW
  have hZi : 0 < ∑ ω, gi ω * W ω :=
    Finset.sum_pos (fun ω _ => mul_pos (hgi ω) (hW ω)) ⟨fun _ => Classical.arbitrary G, Finset.mem_univ _⟩
  have hZj : 0 < ∑ ω, gj ω * W ω :=
    Finset.sum_pos (fun ω _ => mul_pos (hgj ω) (hW ω)) ⟨fun _ => Classical.arbitrary G, Finset.mem_univ _⟩
  have e1 : ∑ ω, W ω * (gi ω * gj ω) = ∑ ω, gi ω * gj ω * W ω := Finset.sum_congr rfl (fun ω _ => by ring)
  have e2 : ∑ ω, W ω * gi ω = ∑ ω, gi ω * W ω := Finset.sum_congr rfl (fun ω _ => by ring)
  have e3 : ∑ ω, W ω * gj ω = ∑ ω, gj ω * W ω := Finset.sum_congr rfl (fun ω _ => by ring)
  unfold gibbs
  rw [e1, e2, e3]
  field_simp

/-- THE TOWER'S STEP: the renormalised interaction between two coarse variables at level distance R is at most
    2 N_j D_i α^R / ((1 - α) m_i), whenever that quantity is at most one. -/
theorem renorm_interaction_le (W : (S → G) → ℝ) (hW : ∀ ω, 0 < W ω)
    (C : S → S → ℝ) (hC : ∀ s t, 0 ≤ C s t) (hCW : Interdep W C) (α : ℝ) (hα0 : 0 ≤ α) (hα1 : α < 1)
    (hrow : ∀ s, ∑ t, C s t ≤ α) (φ : S → ℕ) (hφ : RangeOne C φ)
    (gi : (S → G) → ℝ) (hgi : ∀ ω, 0 < gi ω) (di : S → ℝ) (hdi : OscBound gi di)
    (a R : ℕ) (hd : ∀ t, a < φ t → di t = 0)
    (gj : (S → G) → ℝ) (hgj : ∀ ω, 0 < gj ω) (reads : S → Prop) [DecidablePred reads]
    (hfree : ∀ s, ¬ reads s → ∀ ω x, gj (Function.update ω s x) = gj ω)
    (hreads : ∀ t, φ t < a + R → ¬ reads t)
    (mi : ℝ) (hmi : 0 < mi) (hlo : ∀ ω, mi ≤ gi ω)
    (hε : (∑ t, if reads t then (1 : ℝ) else 0) * (∑ t, di t) * α ^ R / (1 - α) / mi ≤ 1 / 2) :
    |Real.log (gibbs W (fun ω => gi ω * gj ω) / (gibbs W gi * gibbs W gj))|
      ≤ 2 * ((∑ t, if reads t then (1 : ℝ) else 0) * (∑ t, di t) * α ^ R / (1 - α) / mi) := by
  set N : ℝ := ∑ t, if reads t then (1 : ℝ) else 0 with hN
  set D : ℝ := ∑ t, di t with hD
  set ε : ℝ := N * D * α ^ R / (1 - α) / mi with hε_def
  have hcov := cov_le W hW C hC hCW α hα0 hα1 hrow φ hφ gi di hdi a R hd gj hgj reads hfree hreads
  have hGi : mi ≤ gibbs W gi := le_gibbs_of_le W hW gi mi hlo
  have hGi0 : 0 < gibbs W gi := lt_of_lt_of_le hmi hGi
  have hGj0 : 0 < gibbs W gj := gibbs_pos W hW gj hgj
  have h1α : 0 < 1 - α := by linarith
  have hN0 : 0 ≤ N := Finset.sum_nonneg (fun t _ => by split_ifs <;> norm_num)
  have hD0 : 0 ≤ D := Finset.sum_nonneg (fun t _ => oscBound_nonneg hdi t)
  have hαR : 0 ≤ α ^ R := pow_nonneg hα0 R
  set x : ℝ := gibbs W (fun ω => gi ω * gj ω) / (gibbs W gi * gibbs W gj) with hx
  -- |x - 1| ≤ ε
  have hx1 : |x - 1| ≤ ε := by
    have hden : 0 < gibbs W gi * gibbs W gj := mul_pos hGi0 hGj0
    have : x - 1 = (gibbs W (fun ω => gi ω * gj ω) - gibbs W gi * gibbs W gj) / (gibbs W gi * gibbs W gj) := by
      rw [hx]; field_simp
    rw [this, abs_div, abs_of_pos hden, div_le_iff₀ hden]
    calc |gibbs W (fun ω => gi ω * gj ω) - gibbs W gi * gibbs W gj|
        ≤ gibbs W gj * (N * D * α ^ R / (1 - α)) := hcov
      _ = (N * D * α ^ R / (1 - α) / mi) * (mi * gibbs W gj) := by field_simp
      _ ≤ ε * (gibbs W gi * gibbs W gj) := by
          rw [hε_def]
          apply mul_le_mul_of_nonneg_left _ (by positivity)
          exact mul_le_mul_of_nonneg_right hGi (le_of_lt hGj0)
  have hε0 : 0 ≤ ε := by rw [hε_def]; positivity
  have hxhalf : 1 / 2 ≤ x := by
    have := abs_le.mp hx1
    linarith
  calc |Real.log x| ≤ 2 * |x - 1| := abs_log_le_two_abs_sub_one x hxhalf
    _ ≤ 2 * ε := by linarith

end TowerStep
