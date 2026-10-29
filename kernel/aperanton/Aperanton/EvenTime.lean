/-
  APERANTON -- THE BOUNDLESS, stage A3: REFLECTION POSITIVITY AT EVEN TIME (ΑΝΤΑΥΓΕΙΑ T-22, T-718).

  The tower's time is even: one-step reflection positivity fails and even-step holds by detailed balance.  In the
  transfer matrix's language this is one line above Mathlib -- for a real symmetric T every even power is
  T^(2L) = (T^L)ᵀ (T^L), positive semidefinite, so every even-time quadratic form ⟨v, T^(2L) v⟩ is nonnegative and
  the even-time trace is a sum of squares of the eigenvalues' L-th powers.  No sorry, no axiom.
-/
import Mathlib
import Aperanton.Transfer

open Matrix

namespace Aperanton

variable {n : Type*} [Fintype n] [DecidableEq n]

/-- every even power of a real symmetric matrix is positive semidefinite -/
theorem posSemidef_pow_two_mul (T : Matrix n n ℝ) (hT : T.IsHermitian) (L : ℕ) :
    (T ^ (2 * L)).PosSemidef := by
  have h : T ^ (2 * L) = (T ^ L)ᴴ * T ^ L := by
    rw [conjTranspose_pow, hT.eq, ← pow_add, two_mul]
  rw [h]
  exact posSemidef_conjTranspose_mul_self (T ^ L)

/-- THE EVEN-TIME QUADRATIC FORM IS NONNEGATIVE: ⟨v, T^(2L) v⟩ ≥ 0 for every v -/
theorem even_time_nonneg (T : Matrix n n ℝ) (hT : T.IsHermitian) (L : ℕ) (v : n → ℝ) :
    0 ≤ v ⬝ᵥ ((T ^ (2 * L)) *ᵥ v) := by
  have := (posSemidef_pow_two_mul T hT L).dotProduct_mulVec_nonneg v
  simpa using this

/-- the even-time trace is a sum of squares, hence nonnegative -/
theorem trace_pow_two_mul_nonneg (T : Matrix n n ℝ) (hT : T.IsHermitian) (L : ℕ) :
    0 ≤ (T ^ (2 * L)).trace := by
  rw [trace_pow_eq_sum_eigenvalues_pow T hT (2 * L)]
  exact Finset.sum_nonneg (fun i _ => by rw [pow_mul]; exact pow_nonneg (sq_nonneg _) L)

end Aperanton
