/-
  APERANTON -- THE BOUNDLESS, stage A6 (first landing): THE CENTRE'S INVERSION THEOREM, abstract form.

  The concurrent seat (ΤΟΜΕΥΣ, 2026-10-27) derived at the desk and then read on Z₂, Z₄ and the staked loci that the
  transfer matrix M = D K of a finite-group gauge theory on the 2 × 2 torus obeys M (S R_f)(K D) = μ² (S R_f) for a
  parity character S and a central frustrating translation R_f, so that every block's spectrum is closed under
  λ ↦ μ²/λ.  The spectral consequence is a theorem about any square matrix: if M V N = c V with V invertible and N
  similar to M, then M⁻¹ is similar to c⁻¹ M and every λ in the spectrum of M has c/λ in it.  Proved above Mathlib
  for real matrices (Mathlib's spectrum of a unit's inverse, of a unit multiple, and under conjugation); the
  integer identity on the record's matrices is the kernel's instance.  No sorry, no axiom.
-/
import Mathlib

open Matrix
open scoped Pointwise

namespace Aperanton

variable {n : Type*} [Fintype n] [DecidableEq n]

/-- the inverse of M from the inversion identity: M⁻¹ = c⁻¹ V N V⁻¹ -/
theorem inv_eq_of_inversion (M V N : Matrix n n ℝ) (c : ℝ) (hc : c ≠ 0) (hV : IsUnit V.det)
    (h : M * V * N = c • V) : M⁻¹ = c⁻¹ • (V * N * V⁻¹) := by
  apply Matrix.inv_eq_right_inv
  calc M * (c⁻¹ • (V * N * V⁻¹)) = c⁻¹ • (M * V * N * V⁻¹) := by
        rw [Matrix.mul_smul, ← mul_assoc, ← mul_assoc]
    _ = c⁻¹ • (c • V * V⁻¹) := by rw [h]
    _ = c⁻¹ • (c • (V * V⁻¹)) := by rw [Matrix.smul_mul]
    _ = c⁻¹ • (c • (1 : Matrix n n ℝ)) := by rw [Matrix.mul_nonsing_inv V hV]
    _ = 1 := by rw [smul_smul, inv_mul_cancel₀ hc, one_smul]

/-- THE SPECTRUM IS CLOSED UNDER λ ↦ c/λ: for M similar to c M⁻¹ through an invertible U, every spectral value
λ of M has c/λ in the spectrum -/
theorem spectrum_closed_of_similar_inv [Nonempty n] (M U : Matrix n n ℝ) (c : ℝ) (hc : c ≠ 0) (hM : IsUnit M.det)
    (hU : IsUnit U.det) (h : M⁻¹ = c⁻¹ • (U * M * U⁻¹)) :
    ∀ l ∈ spectrum ℝ M, c / l ∈ spectrum ℝ M := by
  intro l hl
  have hMu : IsUnit M := (Matrix.isUnit_iff_isUnit_det M).mpr hM
  have hUu : IsUnit U := (Matrix.isUnit_iff_isUnit_det U).mpr hU
  have hl0 : l ≠ 0 := by
    intro h0
    rw [h0] at hl
    exact (spectrum.zero_mem_iff ℝ).mp hl hMu
  -- λ⁻¹ ∈ σ(M⁻¹)
  have h1 : l⁻¹ ∈ spectrum ℝ M⁻¹ := by
    have := (spectrum.inv_mem_iff (r := Units.mk0 l hl0) (a := hMu.unit)).mp (by simpa using hl)
    simpa [Matrix.coe_units_inv] using this
  -- σ(M⁻¹) = c⁻¹ • σ(U M U⁻¹) = c⁻¹ • σ(M)
  have hconj : spectrum ℝ (U * M * U⁻¹) = spectrum ℝ M := by
    have := spectrum.units_conjugate (R := ℝ) (a := M) (u := hUu.unit)
    simpa [Matrix.coe_units_inv] using this
  have h2 : spectrum ℝ M⁻¹ = (c⁻¹ : ℝ) • spectrum ℝ M := by
    rw [h, spectrum.smul_eq_smul c⁻¹ _ (by rw [hconj]; exact ⟨l, hl⟩), hconj]
  rw [h2] at h1
  obtain ⟨m, hm, hml⟩ := Set.mem_smul_set.mp h1
  have : m = c / l := by
    have : l⁻¹ = c⁻¹ * m := by rw [← hml]; rfl
    field_simp at this ⊢
    linarith
  rw [← this]
  exact hm

/-- THE CENTRE'S INVERSION THEOREM, abstract: M V N = c V with V invertible and N = D⁻¹ M D (D invertible) make
every spectral value λ of M come with c/λ -/
theorem spectrum_closed_of_inversion [Nonempty n] (M V D N : Matrix n n ℝ) (c : ℝ) (hc : c ≠ 0) (hM : IsUnit M.det)
    (hV : IsUnit V.det) (hD : IsUnit D.det) (hN : D * N = M * D) (h : M * V * N = c • V) :
    ∀ l ∈ spectrum ℝ M, c / l ∈ spectrum ℝ M := by
  have hinv := inv_eq_of_inversion M V N c hc hV h
  -- N = D⁻¹ M D, so V N V⁻¹ = (V D⁻¹) M (V D⁻¹)⁻¹
  have hN' : N = D⁻¹ * M * D := by
    calc N = D⁻¹ * (D * N) := by rw [← mul_assoc, Matrix.nonsing_inv_mul D hD, one_mul]
      _ = D⁻¹ * (M * D) := by rw [hN]
      _ = D⁻¹ * M * D := by rw [mul_assoc]
  have hU : IsUnit (V * D⁻¹).det := by
    rw [Matrix.det_mul]
    exact hV.mul (Matrix.isUnit_nonsing_inv_det D hD)
  apply spectrum_closed_of_similar_inv M (V * D⁻¹) c hc hM hU
  rw [hinv, hN', Matrix.mul_inv_rev, Matrix.nonsing_inv_nonsing_inv D hD]
  congr 1
  simp only [mul_assoc]

end Aperanton
