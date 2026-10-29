/-
  APERANTON -- THE BOUNDLESS, stage A4 (fourth landing): THE MASS GAP ON EVERY FINITE CROSS-SECTION.

  For an entrywise-positive symmetric transfer matrix the Perron root is simple and strictly dominant (Perron.lean),
  so on every finite cross-section the gap between the vacuum and every other state is strictly positive:
  λ₀ − |λ_i| > 0, and in energies log λ₀ − log |λ_i| > 0 whenever λ_i ≠ 0.  This is the mass gap ΤΟΜΕΥΣ brackets
  (Δ = 3.750210305668 on Z₂ at y = 1/2 on the 2 × 2 cross-section) as a theorem for every finite group, every
  coupling and every cross-section.  Its uniformity in the cross-section is Α9's goal, stated there and not here.
  No sorry, no axiom.
-/
import Mathlib
import Aperanton.Perron

open Matrix

namespace Aperanton

variable {n : Type*} [Fintype n] [DecidableEq n] [Nonempty n]

/-- THE MASS GAP ON A FINITE CROSS-SECTION: every eigenvalue other than the Perron root lies strictly below it in
absolute value -/
theorem finite_volume_mass_gap (T : Matrix n n ℝ) (hT : T.IsHermitian) (hpos : ∀ i j, 0 < T i j) (i : n)
    (hi : hT.eigenvalues i ≠ lamMax T hT) : 0 < lamMax T hT - |hT.eigenvalues i| :=
  sub_pos.mpr (abs_eigenvalue_lt T hT hpos i hi)

/-- the same gap in energies: log λ₀ − log |λ_i| > 0 for every nonzero non-Perron eigenvalue -/
theorem finite_volume_mass_gap_log (T : Matrix n n ℝ) (hT : T.IsHermitian) (hpos : ∀ i j, 0 < T i j) (i : n)
    (hi : hT.eigenvalues i ≠ lamMax T hT) (h0 : hT.eigenvalues i ≠ 0) :
    0 < Real.log (lamMax T hT) - Real.log |hT.eigenvalues i| :=
  sub_pos.mpr (Real.log_lt_log (abs_pos.mpr h0) (abs_eigenvalue_lt T hT hpos i hi))

/-- the gap is the rate of the residual: with ρ the spectral ratio of Perron.lean, every non-Perron eigenvalue is
at most ρ λ₀ with ρ < 1 -- the finite-cross-section mass gap is log(1/ρ) > 0 -/
theorem mass_gap_rate (T : Matrix n n ℝ) (hT : T.IsHermitian) (hpos : ∀ i j, 0 < T i j) :
    ∃ ρ : ℝ, 0 ≤ ρ ∧ ρ < 1 ∧ ∀ L : ℕ,
      |(T ^ L).trace - lamMax T hT ^ L| ≤ ((Fintype.card n : ℝ) - 1) * (ρ * lamMax T hT) ^ L :=
  trace_pow_residual T hT hpos

end Aperanton
