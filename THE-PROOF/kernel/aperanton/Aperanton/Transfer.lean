/-
  APERANTON -- THE BOUNDLESS, stage A4 (first landing): THE TRANSFER THEOREM'S SPECTRAL HALF.

  TELEUTE (T-135) in matrix form: a quantity riding one operator T is a sum of its eigenvalues' powers, so its L-th
  reading is  tr(T^L) = Σ_i λ_i^L,  and every finite reading is an exact function of the spectrum ΤΟΜΕΥΣ computes.
  For a real symmetric T (the transfer matrix of a finite-group gauge theory at even time, ΑΝΤΑΥΓΕΙΑ T-22) Mathlib's
  spectral theorem carries the power to the eigenvalues through the continuous functional calculus.  Proved above
  Mathlib; no sorry.  The Perron half (λ₁ simple and dominant for a nonnegative irreducible T) is the next landing.
-/
import Mathlib

namespace Aperanton

open Matrix

variable {n : Type*} [Fintype n] [DecidableEq n]

/-- the trace of a power of a real symmetric matrix is the power sum of its eigenvalues -/
theorem trace_pow_eq_sum_eigenvalues_pow (T : Matrix n n ℝ) (hT : T.IsHermitian) (L : ℕ) :
    (T ^ L).trace = ∑ i, (hT.eigenvalues i) ^ L := by
  -- the spectral theorem writes T as U diag(λ) U*; a conjugation is multiplicative and keeps the trace, a diagonal
  -- matrix's power is the power of its diagonal, and its trace is the sum of its entries
  have h : T = (Unitary.conjStarAlgAut ℝ (Matrix n n ℝ)) hT.eigenvectorUnitary
      (diagonal (RCLike.ofReal ∘ hT.eigenvalues)) := hT.spectral_theorem
  calc (T ^ L).trace
      = (((Unitary.conjStarAlgAut ℝ (Matrix n n ℝ)) hT.eigenvectorUnitary
          (diagonal (RCLike.ofReal ∘ hT.eigenvalues))) ^ L).trace := by rw [← h]
    _ = ((Unitary.conjStarAlgAut ℝ (Matrix n n ℝ)) hT.eigenvectorUnitary
          ((diagonal (RCLike.ofReal ∘ hT.eigenvalues)) ^ L)).trace := by rw [map_pow]
    _ = ((diagonal (RCLike.ofReal ∘ hT.eigenvalues)) ^ L).trace := trace_map _ _
    _ = (diagonal ((RCLike.ofReal ∘ hT.eigenvalues) ^ L)).trace := by rw [diagonal_pow]
    _ = ∑ i, (hT.eigenvalues i) ^ L := by simp [trace_diagonal, Function.comp]

end Aperanton
