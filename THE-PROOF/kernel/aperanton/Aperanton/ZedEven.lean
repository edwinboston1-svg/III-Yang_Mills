/-
  APERANTON -- THE BOUNDLESS, stage T5 (THE TREK, 2026-10-27): THE EXACT ONE-SITE COEFFICIENT ON EVEN FIELDS.

  The universal one-site step of Z2Slab.lean, `z2_step_univ`, bounds |1/(1+v) − 1/(1+v·y²)| by (1 − y)/(1 + y) for
  EVERY positive odds v, the supremum sitting at v = 1/y.  On the Z₂ slab a site's odds are y to a SIGNED COUNT whose
  parity is the number of factor slots reading the site, and that number is even on every cubic slab (2(d − 2)
  squares and two temporal pairs), so the odds are EVEN powers of y and 1/y is never reached.  THE EXACT STEP: for
  v = y^{2k}, the move is at most (1 − y²)/(2(1 + y²)), attained at v = 1 and at v = y^{−2}, because
      2v(1 + y²) ≤ (1 + v)(1 + v·y²)  ⟺  0 ≤ (1 − v)(1 − v·y²),
  and an even power of y never lies strictly between 1 and y^{−2}.  The instrument aperanton_block.awk read this
  coefficient as its known answer (7(1 − y²)/(1 + y²) on the one-link block at d = 4, 196/197 at y = 13/15); here
  it is a theorem.  The consumer: the slab's row sum (3m + 2)·(1 − y²)/(2(1 + y²)), below one iff y² > 3m/(3m + 4)
  — β < ¼·ln(4/3) = 0.0719 at d = 4, against the universal 0.0716.  W = 0 (an inequality of rational functions);
  the earning is the exactness, measured first.  No sorry, no axiom, no native_decide.
-/
import Mathlib

namespace Aperanton

section ZedEven

/-- the exact one-site move at odds v with (1 − v)(1 − v y²) ≥ 0: at most (1 − y²)/(2(1 + y²)) -/
theorem z2_step_even_of (y v : ℝ) (hy0 : 0 < y) (hy1 : y ≤ 1) (hv : 0 < v)
    (hpar : 0 ≤ (1 - v) * (1 - v * y ^ 2)) :
    |1 / (1 + v) - 1 / (1 + v * y ^ 2)| ≤ (1 - y ^ 2) / (2 * (1 + y ^ 2)) := by
  have hy2 : 0 ≤ 1 - y ^ 2 := by nlinarith
  have h1 : 0 < 1 + v := by linarith
  have h2 : 0 < 1 + v * y ^ 2 := by positivity
  have h3 : 0 < 2 * (1 + y ^ 2) := by positivity
  have hy21 : y ^ 2 - 1 ≤ 0 := by linarith
  have hdiff : 1 / (1 + v) - 1 / (1 + v * y ^ 2) = v * (y ^ 2 - 1) / ((1 + v) * (1 + v * y ^ 2)) := by
    rw [div_sub_div _ _ h1.ne' h2.ne']
    congr 1
    ring
  rw [hdiff, abs_div, abs_of_pos (mul_pos h1 h2), abs_mul, abs_of_pos hv, abs_of_nonpos hy21,
    neg_sub, div_le_div_iff₀ (mul_pos h1 h2) h3]
  nlinarith [mul_nonneg hy2 hpar]

/-- an even power of y ∈ (0, 1] never lies strictly between 1 and y^{−2}: (1 − y^{2k})(1 − y^{2k} y²) ≥ 0 -/
theorem even_odds_parity (y : ℝ) (hy0 : 0 < y) (hy1 : y ≤ 1) (k : ℤ) :
    0 ≤ (1 - y ^ (2 * k)) * (1 - y ^ (2 * k) * y ^ 2) := by
  rcases Int.eq_nat_or_neg k with ⟨n, hn | hn⟩
  · -- k = n ≥ 0: both factors nonnegative
    subst hn
    have e : y ^ (2 * (n : ℤ)) = y ^ (2 * n) := by
      rw [show (2 : ℤ) * (n : ℤ) = ((2 * n : ℕ) : ℤ) by norm_cast, zpow_natCast]
    rw [e]
    have ha : y ^ (2 * n) ≤ 1 := pow_le_one₀ hy0.le hy1
    have hb : y ^ (2 * n) * y ^ 2 ≤ 1 := by
      rw [← pow_add]; exact pow_le_one₀ hy0.le hy1
    exact mul_nonneg (by linarith) (by linarith)
  · -- k = −n: both factors nonpositive (n = 0 gives the zero factor)
    subst hn
    have e : y ^ (2 * (-(n : ℤ))) = (y ^ (2 * n))⁻¹ := by
      rw [show (2 : ℤ) * (-(n : ℤ)) = -((2 * n : ℕ) : ℤ) by omega, zpow_neg, zpow_natCast]
    rw [e]
    have hp : 0 < y ^ (2 * n) := pow_pos hy0 _
    have hle : y ^ (2 * n) ≤ 1 := pow_le_one₀ hy0.le hy1
    have ha : 1 ≤ (y ^ (2 * n))⁻¹ := one_le_inv_iff₀.mpr ⟨hp, hle⟩
    rcases Nat.eq_zero_or_pos n with hn0 | hn0
    · subst hn0
      simp
    · have hb : 1 ≤ (y ^ (2 * n))⁻¹ * y ^ 2 := by
        have e2 : y ^ (2 * n) = y ^ (2 * n - 2) * y ^ 2 := by
          rw [← pow_add]; congr 1; omega
        have hq : 0 < y ^ (2 * n - 2) := pow_pos hy0 _
        have hleq : y ^ (2 * n - 2) ≤ 1 := pow_le_one₀ hy0.le hy1
        rw [e2, mul_inv, mul_assoc, inv_mul_cancel₀ (pow_pos hy0 2).ne', mul_one]
        exact one_le_inv_iff₀.mpr ⟨hq, hleq⟩
      have ha' : 1 - (y ^ (2 * n))⁻¹ ≤ 0 := by linarith
      have hb' : 1 - (y ^ (2 * n))⁻¹ * y ^ 2 ≤ 0 := by linarith
      nlinarith [ha', hb']

/-- THE EXACT ONE-SITE STEP ON EVEN FIELDS -/
theorem z2_step_even (y : ℝ) (hy0 : 0 < y) (hy1 : y ≤ 1) (k : ℤ) :
    |1 / (1 + y ^ (2 * k)) - 1 / (1 + y ^ (2 * k) * y ^ 2)| ≤ (1 - y ^ 2) / (2 * (1 + y ^ 2)) :=
  z2_step_even_of y _ hy0 hy1 (zpow_pos hy0 _) (even_odds_parity y hy0 hy1 k)

/-- the exact coefficient is never above the universal one -/
theorem even_le_univ (y : ℝ) (hy0 : 0 < y) (hy1 : y ≤ 1) :
    (1 - y ^ 2) / (2 * (1 + y ^ 2)) ≤ (1 - y) / (1 + y) := by
  have h1 : 0 < 1 + y := by linarith
  have h3 : 0 < 2 * (1 + y ^ 2) := by positivity
  have h1y : 0 ≤ 1 - y := by linarith
  rw [div_le_div_iff₀ h3 h1]
  nlinarith [mul_nonneg (mul_nonneg h1y h1y) h1y]

/-- the regime of the exact coefficient: (3m + 2)·(1 − y²)/(2(1 + y²)) < 1 iff 3m/(3m + 4) < y² -/
theorem z2_even_lt_one (m : ℕ) (y : ℝ) :
    (3 * m + 2) * ((1 - y ^ 2) / (2 * (1 + y ^ 2))) < 1 ↔ (3 * m : ℝ) / (3 * m + 4) < y ^ 2 := by
  have h3 : (0 : ℝ) < 2 * (1 + y ^ 2) := by positivity
  have h4 : (0 : ℝ) < 3 * m + 4 := by positivity
  rw [← mul_div_assoc, div_lt_one h3, div_lt_iff₀ h4]
  constructor <;> intro h <;> nlinarith

end ZedEven

end Aperanton
