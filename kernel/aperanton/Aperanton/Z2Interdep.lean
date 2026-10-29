/-
  APERANTON -- THE BOUNDLESS, stage Β3b (ADDENDUM I, THE ROAD): THE Z₂ STEP LEMMA -- THE SHARPER INTERDEPENDENCE
  BOUND'S CORE INEQUALITY.

  The concurrent seat's per-site lemma (ΤΟΜΕΥΣ, 10-27 15:3x; the road page carries its statement and proof): for
  Z₂ in temporal gauge, with y = w(−)/w(+) ∈ (0, 1], a site's conditional is P(+) = 1/(1 + v) for an odds v that is
  an even power y^{m−2k} of y, and a change at one neighbour multiplies the odds by y² or y⁻² (one factor's pair
  flipped), so the two conditionals differ by |f(v) − f(v y²)| with f(v) = 1/(1 + v).  THE STEP LEMMA
  (`z2_step_le`): for every v > 0 with v and v y² on the same side of 1, |f(v) − f(v y²)| ≤ (1 − y²)/(2(1 + y²))
  -- cross-multiplied it is (1 − v)(1 − v y²) ≥ 0, which an even power of y ≤ 1 always satisfies (`sign_cond`:
  y^{2j} and y^{2j+2} lie on the same side of 1).  On a two-point spin space the total variation is |P − P′|
  (`tv_bool`), so any two conditionals related by one factor flip are within c(y) = (1 − y²)/(2(1 + y²))
  (`tv_le_c_of_odds`).  The slab's bookkeeping lives in `Z2Slab.lean`: the universal step bound
  c₁(y) = (1 − y)/(1 + y) (`z2_step_univ`, every odds v > 0, no sign condition), the Z₂ factor system with its parities,
  the `Interdep` instance with C(s, t) = shared(s, t) · c₁(y) and the gap `transfer_gap_sharp` with
  α = (3m + 2) c₁(y); the even-site bound c(y) here is the sharper form where the sign condition holds (c₁/c ≤ 1.016 on
  the regime), stated and claimed for nothing beyond this file.  W = 0; no sorry, no axiom, no native_decide.
-/
import Mathlib
import Aperanton.Dobrushin

open Finset

namespace Aperanton

section Z2Step

/-- THE STEP LEMMA: the two conditionals 1/(1 + v) and 1/(1 + v y²) differ by at most (1 − y²)/(2(1 + y²)) when
v and v y² lie on the same side of 1 -/
theorem z2_step_le (y v : ℝ) (hy0 : 0 < y) (hy1 : y ≤ 1) (hv : 0 < v)
    (hsign : 0 ≤ (1 - v) * (1 - v * y ^ 2)) :
    |1 / (1 + v) - 1 / (1 + v * y ^ 2)| ≤ (1 - y ^ 2) / (2 * (1 + y ^ 2)) := by
  have hy2 : 0 ≤ 1 - y ^ 2 := by nlinarith
  have h1v : 0 < 1 + v := by linarith
  have h1vy : 0 < 1 + v * y ^ 2 := by positivity
  have hdiff : 1 / (1 + v) - 1 / (1 + v * y ^ 2) = -(v * (1 - y ^ 2)) / ((1 + v) * (1 + v * y ^ 2)) := by
    field_simp
    ring
  rw [hdiff, abs_div, abs_neg, abs_of_pos (mul_pos h1v h1vy), abs_of_nonneg (mul_nonneg hv.le hy2)]
  rw [div_le_div_iff₀ (mul_pos h1v h1vy) (by positivity)]
  -- v(1 − y²) · 2(1 + y²) ≤ (1 − y²)(1 + v)(1 + v y²) ⟸ 2v(1 + y²) ≤ (1 + v)(1 + v y²) ⟸ (1 − v)(1 − v y²) ≥ 0
  have hkey : 2 * v * (1 + y ^ 2) ≤ (1 + v) * (1 + v * y ^ 2) := by nlinarith
  nlinarith [mul_le_mul_of_nonneg_left hkey hy2]

/-- an even power of y ≤ 1 and the next even power lie on the same side of 1 -/
theorem sign_cond (y : ℝ) (hy0 : 0 < y) (hy1 : y ≤ 1) (j : ℤ) :
    0 ≤ (1 - y ^ (2 * j)) * (1 - y ^ (2 * j) * y ^ 2) := by
  have hpos : 0 < y ^ (2 * j) := zpow_pos hy0 _
  rcases le_or_gt 0 j with hj | hj
  · have h1 : y ^ (2 * j) ≤ 1 := zpow_le_one₀ hy0 hy1 (by omega)
    have h2 : y ^ 2 ≤ 1 := by nlinarith
    have h3 : y ^ (2 * j) * y ^ 2 ≤ 1 := by nlinarith
    nlinarith
  · have h1 : 1 ≤ y ^ (2 * j) := by
      have hinv : (1 : ℝ) ≤ y⁻¹ := by rw [le_inv_comm₀ one_pos hy0]; simpa using hy1
      have : y ^ (2 * j) = y⁻¹ ^ (-(2 * j)) := by rw [inv_zpow', neg_neg]
      rw [this]
      exact one_le_zpow₀ hinv (by omega)
    have h3 : 1 ≤ y ^ (2 * j) * y ^ 2 := by
      have : y ^ (2 * j) * y ^ 2 = y ^ (2 * (j + 1)) := by
        rw [show (2 : ℤ) * (j + 1) = 2 * j + 2 by ring, zpow_add₀ hy0.ne', zpow_ofNat]
      rw [this]
      have hinv : (1 : ℝ) ≤ y⁻¹ := by rw [le_inv_comm₀ one_pos hy0]; simpa using hy1
      have e : y ^ (2 * (j + 1)) = y⁻¹ ^ (-(2 * (j + 1))) := by rw [inv_zpow', neg_neg]
      rw [e]
      exact one_le_zpow₀ hinv (by omega)
    nlinarith

end Z2Step

section TwoPoint

/-- on a two-point spin space the total-variation distance of two distributions is the difference at one point -/
theorem tv_bool (p p' : Bool → ℝ) (h1 : ∑ b, p b = 1) (h1' : ∑ b, p' b = 1) :
    tv p p' = |p true - p' true| := by
  simp only [tv, Fintype.sum_bool] at h1 h1' ⊢
  have : p false - p' false = -(p true - p' true) := by linarith
  rw [this, abs_neg]
  ring

/-- THE PER-SITE BOUND ON A TWO-POINT SPIN: two distributions with odds v and v y² (one factor's pair flipped) are
within c(y) = (1 − y²)/(2(1 + y²)) in total variation -/
theorem tv_le_c_of_odds (y v : ℝ) (hy0 : 0 < y) (hy1 : y ≤ 1) (hv : 0 < v)
    (hsign : 0 ≤ (1 - v) * (1 - v * y ^ 2)) (p p' : Bool → ℝ)
    (hp : p true = 1 / (1 + v)) (hp' : p' true = 1 / (1 + v * y ^ 2))
    (h1 : ∑ b, p b = 1) (h1' : ∑ b, p' b = 1) :
    tv p p' ≤ (1 - y ^ 2) / (2 * (1 + y ^ 2)) := by
  rw [tv_bool p p' h1 h1', hp, hp']
  exact z2_step_le y v hy0 hy1 hv hsign

/-- the eight-neighbour row sum: with every neighbour's move at most c(y) and at most eight neighbours, the row
sum is at most 4(1 − y²)/(1 + y²) -/
theorem rowsum_le_of_eight (y : ℝ) {S : Type*} [Fintype S] [DecidableEq S] (C : S → S → ℝ)
    (hC : ∀ s t, 0 ≤ C s t) (s : S) (nb : Finset S) (hcard : nb.card ≤ 8)
    (hoff : ∀ t, t ∉ nb → C s t = 0) (hc : ∀ t ∈ nb, C s t ≤ (1 - y ^ 2) / (2 * (1 + y ^ 2)))
    (hy2 : 0 ≤ 1 - y ^ 2) (hy1 : 0 < 1 + y ^ 2) :
    ∑ t, C s t ≤ 4 * (1 - y ^ 2) / (1 + y ^ 2) := by
  have hsplit : ∑ t, C s t = ∑ t ∈ nb, C s t := by
    rw [← sum_subset (subset_univ nb)]
    intro t _ ht
    exact hoff t ht
  rw [hsplit]
  calc ∑ t ∈ nb, C s t ≤ ∑ t ∈ nb, (1 - y ^ 2) / (2 * (1 + y ^ 2)) := sum_le_sum hc
    _ = nb.card * ((1 - y ^ 2) / (2 * (1 + y ^ 2))) := by rw [sum_const, nsmul_eq_mul]
    _ ≤ 8 * ((1 - y ^ 2) / (2 * (1 + y ^ 2))) := by
        apply mul_le_mul_of_nonneg_right _ (div_nonneg hy2 (by positivity))
        exact_mod_cast hcard
    _ = 4 * (1 - y ^ 2) / (1 + y ^ 2) := by field_simp; ring

end TwoPoint

end Aperanton
