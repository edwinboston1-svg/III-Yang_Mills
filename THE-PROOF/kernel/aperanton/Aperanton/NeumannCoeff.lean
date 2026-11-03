import Mathlib

/-!
# NeumannCoeff.lean -- THE TREK, STAGE IV: the combinatorial core of THE VARIANCE THEOREM

The SU(2) one-link Dobrushin coefficient's unconditional floor (the criterion holds below beta = 1/9) rests on the
variance of the projection of a von Mises-Fisher law on S^3 being at most 1/4 in every direction.  Along the axis
that reads, with m = I_2/I_1 and E t^2 = 1 - 3m/K, as 4 I_0^2 - 3 I_1^2 - 4 I_0 I_1/K - 8 I_1^2/K^2 >= 0, and by
Neumann's product formula the coefficient of (K/2)^(2n) in that expression is

    c_n = 4 C(2n,n)/(n!)^2 - 3 C(2n,n-1)/(n!)^2 - 2 C(2n+1,n)/(n! (n+1)!) - 2 C(2n+2,n)/((n+1)!)^2
        = (2n)!/(n!)^4 * n (n-1)(n+4) / ((n+1)^2 (n+2)),

zero at n = 0, 1 and positive from n = 2 (the four binomials are the Vandermonde evaluations of the Cauchy products
of the Bessel series: sum_j C(n,j)^2 = C(2n,n), sum_j C(n+1,j) C(n+1,j+1) = C(2n+2,n), sum_j C(n,j) C(n+1,j+1) =
C(2n+1,n)).  This file decides the closed form and its sign in the kernel: `coeff_closed` is the rational identity
for every n >= 1 (the n = 0 case is `coeff_zero_terms`), `coeff_nonneg` its sign.  The analytic steps (the Bessel
series as functions, the moment identity E t^2 = 1 - 3m/K) stay on the page as the hypotheses the identity serves;
the instrument aperanton_su2_kat.awk reads the same coefficients by Cauchy products against this closed form.
No sorry, no axiom, no native_decide.
-/

namespace NeumannCoeff

open Nat

/-- the coefficient as the four binomial terms, for n >= 1 (the term C(2n, n-1) uses the natural n - 1) -/
noncomputable def coeff (n : ℕ) : ℚ :=
  4 * ((2 * n).choose n : ℚ) / ((n ! : ℚ) ^ 2)
    - 3 * ((2 * n).choose (n - 1) : ℚ) / ((n ! : ℚ) ^ 2)
    - 2 * ((2 * n + 1).choose n : ℚ) / ((n ! : ℚ) * ((n + 1)! : ℚ))
    - 2 * ((2 * n + 2).choose n : ℚ) / (((n + 1)! : ℚ) ^ 2)

/-- the closed form (2n)!/(n!)^4 * n(n-1)(n+4)/((n+1)^2 (n+2)) -/
noncomputable def closed (n : ℕ) : ℚ :=
  ((2 * n)! : ℚ) / ((n ! : ℚ) ^ 4) * ((n : ℚ) * ((n : ℚ) - 1) * ((n : ℚ) + 4)) / ((((n : ℚ) + 1) ^ 2) * ((n : ℚ) + 2))

theorem factorial_pos_q (n : ℕ) : (0 : ℚ) < (n ! : ℚ) := by exact_mod_cast Nat.factorial_pos n

/-- the first binomial: C(2n, n) = (2n)!/(n! n!) -/
theorem choose_2n_n (n : ℕ) : ((2 * n).choose n : ℚ) = ((2 * n)! : ℚ) / ((n ! : ℚ) * (n ! : ℚ)) := by
  rw [Nat.cast_choose ℚ (by omega : n ≤ 2 * n)]
  have : 2 * n - n = n := by omega
  rw [this]

/-- the second binomial for n >= 1: C(2n, n-1) = (2n)!/((n-1)! (n+1)!) -/
theorem choose_2n_pred (n : ℕ) (hn : 1 ≤ n) :
    ((2 * n).choose (n - 1) : ℚ) = ((2 * n)! : ℚ) / (((n - 1)! : ℚ) * ((n + 1)! : ℚ)) := by
  rw [Nat.cast_choose ℚ (by omega : n - 1 ≤ 2 * n)]
  have : 2 * n - (n - 1) = n + 1 := by omega
  rw [this]

/-- the third binomial: C(2n+1, n) = (2n+1)!/(n! (n+1)!) -/
theorem choose_2n1_n (n : ℕ) : ((2 * n + 1).choose n : ℚ) = ((2 * n + 1)! : ℚ) / ((n ! : ℚ) * ((n + 1)! : ℚ)) := by
  rw [Nat.cast_choose ℚ (by omega : n ≤ 2 * n + 1)]
  have : 2 * n + 1 - n = n + 1 := by omega
  rw [this]

/-- the fourth binomial: C(2n+2, n) = (2n+2)!/(n! (n+2)!) -/
theorem choose_2n2_n (n : ℕ) : ((2 * n + 2).choose n : ℚ) = ((2 * n + 2)! : ℚ) / ((n ! : ℚ) * ((n + 2)! : ℚ)) := by
  rw [Nat.cast_choose ℚ (by omega : n ≤ 2 * n + 2)]
  have : 2 * n + 2 - n = n + 2 := by omega
  rw [this]

/-- the factorial steps as rational identities -/
theorem fact_succ_q (m : ℕ) : ((m + 1)! : ℚ) = ((m : ℚ) + 1) * (m ! : ℚ) := by
  rw [Nat.factorial_succ]; push_cast; ring

theorem fact_pred_q (n : ℕ) (hn : 1 ≤ n) : (n ! : ℚ) = (n : ℚ) * ((n - 1)! : ℚ) := by
  obtain ⟨k, rfl⟩ : ∃ k, n = k + 1 := ⟨n - 1, by omega⟩
  simp only [Nat.add_sub_cancel]
  rw [Nat.factorial_succ]; push_cast; ring

/-- THE CLOSED FORM, for every n >= 1 -/
theorem coeff_closed (n : ℕ) (hn : 1 ≤ n) : coeff n = closed n := by
  unfold coeff closed
  rw [choose_2n_n, choose_2n_pred n hn, choose_2n1_n, choose_2n2_n]
  have h2n1 : ((2 * n + 1)! : ℚ) = ((2 * (n : ℚ)) + 1) * ((2 * n)! : ℚ) := by
    rw [Nat.factorial_succ]; push_cast; ring
  have h2n2 : ((2 * n + 2)! : ℚ) = ((2 * (n : ℚ)) + 2) * ((2 * (n : ℚ)) + 1) * ((2 * n)! : ℚ) := by
    rw [show 2 * n + 2 = (2 * n + 1) + 1 by ring, Nat.factorial_succ, Nat.factorial_succ]; push_cast; ring
  have hn1 : ((n + 1)! : ℚ) = ((n : ℚ) + 1) * (n ! : ℚ) := fact_succ_q n
  have hn2 : ((n + 2)! : ℚ) = ((n : ℚ) + 2) * ((n : ℚ) + 1) * (n ! : ℚ) := by
    rw [show n + 2 = (n + 1) + 1 by ring, Nat.factorial_succ, Nat.factorial_succ]; push_cast; ring
  have hpred : (n ! : ℚ) = (n : ℚ) * ((n - 1)! : ℚ) := fact_pred_q n hn
  have hnpos : (0 : ℚ) < (n : ℚ) := by exact_mod_cast hn
  have hn0 : (n : ℚ) ≠ 0 := ne_of_gt hnpos
  have hfp0 : ((n - 1)! : ℚ) ≠ 0 := ne_of_gt (factorial_pos_q (n - 1))
  have hf20 : ((2 * n)! : ℚ) ≠ 0 := ne_of_gt (factorial_pos_q (2 * n))
  have hn10 : (n : ℚ) + 1 ≠ 0 := by positivity
  have hn20 : (n : ℚ) + 2 ≠ 0 := by positivity
  have h2n10 : 2 * (n : ℚ) + 1 ≠ 0 := by positivity
  have h2n20 : 2 * (n : ℚ) + 2 ≠ 0 := by positivity
  rw [h2n1, h2n2, hn1, hn2]
  rw [hpred]
  field_simp
  ring

/-- the n = 0 case: the three terms the series carries at n = 0 sum to zero (the term C(2n, n-1) is absent there) -/
theorem coeff_zero_terms : (4 * ((2 * 0).choose 0 : ℚ) / ((0 ! : ℚ) ^ 2)
    - 2 * ((2 * 0 + 1).choose 0 : ℚ) / ((0 ! : ℚ) * ((0 + 1)! : ℚ))
    - 2 * ((2 * 0 + 2).choose 0 : ℚ) / (((0 + 1)! : ℚ) ^ 2)) = 0 := by
  norm_num [Nat.factorial, Nat.choose]

/-- THE SIGN: the closed form is nonnegative for every n, zero exactly at n = 0 and n = 1 -/
theorem closed_nonneg (n : ℕ) : 0 ≤ closed n := by
  unfold closed
  have hnum : (0 : ℚ) ≤ (n : ℚ) * ((n : ℚ) - 1) * ((n : ℚ) + 4) := by
    rcases Nat.lt_or_ge n 1 with h | h
    · have : n = 0 := by omega
      subst this; norm_num
    · have h1 : (1 : ℚ) ≤ (n : ℚ) := by exact_mod_cast h
      have hm : (0 : ℚ) ≤ (n : ℚ) - 1 := by linarith
      have hp : (0 : ℚ) ≤ (n : ℚ) + 4 := by positivity
      have hq : (0 : ℚ) ≤ (n : ℚ) := by positivity
      exact mul_nonneg (mul_nonneg hq hm) hp
  have hden : (0 : ℚ) < (((n : ℚ) + 1) ^ 2) * ((n : ℚ) + 2) := by positivity
  have hA : (0 : ℚ) ≤ ((2 * n)! : ℚ) / ((n ! : ℚ) ^ 4) := by positivity
  exact div_nonneg (mul_nonneg hA hnum) hden.le

theorem closed_one : closed 1 = 0 := by unfold closed; norm_num
theorem closed_two_pos : 0 < closed 2 := by unfold closed; norm_num [Nat.factorial]

/-- the coefficient is nonnegative for every n >= 1 (and its n = 0 value is 0 by `coeff_zero_terms`) -/
theorem coeff_nonneg (n : ℕ) (hn : 1 ≤ n) : 0 ≤ coeff n := by
  rw [coeff_closed n hn]; exact closed_nonneg n

end NeumannCoeff
