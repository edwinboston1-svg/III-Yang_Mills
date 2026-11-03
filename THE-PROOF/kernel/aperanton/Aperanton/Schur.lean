/-
  APERANTON -- THE BOUNDLESS, stage A8g: THE SCHUR PRODUCT, AND THE POLYNOMIAL ACTIONS.

  The Hadamard (entrywise) product of two positive semidefinite real matrices is positive semidefinite: with the Gram
  factorisations X = Σ_j φ_j ⊗ φ_j and Y = Σ_k ψ_k ⊗ ψ_k, X ∘ Y = Σ_{j,k} (φ_j ∘ ψ_k) ⊗ (φ_j ∘ ψ_k) is again a Gram matrix
  (`posSemidef_hadamard`), and so is any sum of positive semidefinite matrices scaled by nonnegative reals.  The link
  kernel of a product of class functions is the Hadamard product of their kernels, and that of a sum the sum
  (`linkKernel_mul`, `linkKernel_add`, `linkKernel_smul`), so EVERY POLYNOMIAL IN THE CHARACTER WITH NONNEGATIVE
  COEFFICIENTS, p(χ) = Σ_n c_n χ^n with c_n ≥ 0 -- the partial sums of the Wilson action e^{β χ} among them -- has a
  positive semidefinite link kernel (`polyKernel_posSemidef`), and it is a positive class function when c_0 > Σ_{n ≥ 1}
  c_n d^n (`polyW_pos`).  The Wilson action itself is the limit of these; its kernel's positive semidefiniteness is the
  closedness of the cone under that limit, not built here.  No sorry, no axiom.
-/
import Mathlib
import Aperanton.XTransfer
import Aperanton.GaugeAction
import Aperanton.LinearAction

open Matrix

namespace Aperanton

section Hadamard

variable {n : Type*} [Fintype n] [DecidableEq n]

/-- THE SCHUR PRODUCT THEOREM: the entrywise product of positive semidefinite matrices is positive semidefinite -/
theorem posSemidef_hadamard (X Y : Matrix n n ℝ) (hX : X.PosSemidef) (hY : Y.PosSemidef) :
    (Matrix.of fun a b => X a b * Y a b).PosSemidef := by
  obtain ⟨φ, hφ⟩ := exists_gram X hX
  obtain ⟨ψ, hψ⟩ := exists_gram Y hY
  apply posSemidef_of_gram (Matrix.of fun a b => X a b * Y a b)
    (fun p : n × n => fun a => φ p.1 a * ψ p.2 a)
  intro a b
  simp only [Matrix.of_apply, hφ, hψ]
  rw [Finset.sum_mul_sum, Fintype.sum_prod_type]
  apply Finset.sum_congr rfl
  intro j _
  apply Finset.sum_congr rfl
  intro k _
  ring

/-- a nonnegative multiple of a positive semidefinite matrix is positive semidefinite -/
theorem posSemidef_smul_nonneg (X : Matrix n n ℝ) (hX : X.PosSemidef) (c : ℝ) (hc : 0 ≤ c) :
    (c • X).PosSemidef := by
  obtain ⟨φ, hφ⟩ := exists_gram X hX
  apply posSemidef_of_gram (c • X) (fun j => fun a => Real.sqrt c * φ j a)
  intro a b
  simp only [Matrix.smul_apply, smul_eq_mul, hφ, Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro j _
  have := Real.mul_self_sqrt hc
  calc c * (φ j a * φ j b) = (Real.sqrt c * Real.sqrt c) * (φ j a * φ j b) := by rw [this]
    _ = Real.sqrt c * φ j a * (Real.sqrt c * φ j b) := by ring

/-- the entrywise power of a positive semidefinite matrix is positive semidefinite -/
theorem posSemidef_hadamard_pow (X : Matrix n n ℝ) (hX : X.PosSemidef) :
    ∀ k : ℕ, (Matrix.of fun a b => X a b ^ k).PosSemidef
  | 0 => by
      apply posSemidef_of_gram (Matrix.of fun a b => X a b ^ 0) (fun _ : Unit => fun _ => (1 : ℝ))
      intro a b
      simp
  | k + 1 => by
      have h := posSemidef_hadamard X (Matrix.of fun a b => X a b ^ k) hX (posSemidef_hadamard_pow X hX k)
      have e : (Matrix.of fun a b => X a b ^ (k + 1)) = Matrix.of fun a b => X a b * (Matrix.of fun a b => X a b ^ k) a b := by
        ext a b
        simp [pow_succ, mul_comm]
      rw [e]
      exact h

end Hadamard

section Polynomial

variable {G : Type*} [Group G] [Fintype G] [DecidableEq G]

theorem linkKernel_mul (w w' : G → ℝ) :
    linkKernel (fun g => w g * w' g) = Matrix.of fun a b => linkKernel w a b * linkKernel w' a b := by
  ext a b
  simp [linkKernel]

theorem linkKernel_pow (w : G → ℝ) (k : ℕ) :
    linkKernel (fun g => w g ^ k) = Matrix.of fun a b => linkKernel w a b ^ k := by
  ext a b
  simp [linkKernel]

theorem linkKernel_add (w w' : G → ℝ) : linkKernel (fun g => w g + w' g) = linkKernel w + linkKernel w' := by
  ext a b
  simp [linkKernel]

theorem linkKernel_smul (c : ℝ) (w : G → ℝ) : linkKernel (fun g => c * w g) = c • linkKernel w := by
  ext a b
  simp [linkKernel]

/-- a polynomial in the character: p(χ) = Σ_{k < N} c_k χ^k -/
def polyW {d : ℕ} (R : OrthRep G d) (N : ℕ) (c : ℕ → ℝ) (g : G) : ℝ := ∑ k ∈ Finset.range N, c k * R.char g ^ k

theorem polyW_classFn {d : ℕ} (R : OrthRep G d) (N : ℕ) (c : ℕ → ℝ) : IsClassFn (polyW R N c) := by
  intro x y
  have hχ : R.char (x * y * x⁻¹) = R.char y := by
    have := linearW_classFn R 0 x y
    simp only [linearW, zero_add] at this
    exact this
  simp only [polyW, hχ]

/-- THE LINK KERNEL OF A POLYNOMIAL WITH NONNEGATIVE COEFFICIENTS IS POSITIVE SEMIDEFINITE: the character's kernel is
the class matrix, a Gram matrix; its entrywise powers are Schur products; a nonnegative combination is a sum -/
theorem polyKernel_posSemidef {d : ℕ} (R : OrthRep G d) (N : ℕ) (c : ℕ → ℝ) (hc : ∀ k, 0 ≤ c k) :
    (linkKernel (polyW R N c)).PosSemidef := by
  have hχ : linkKernel R.char = classMat R := by
    ext a b
    simp [linkKernel, classMat]
  induction N with
  | zero =>
      have e : linkKernel (polyW R 0 c) = (0 : Matrix G G ℝ) := by
        ext a b
        simp [linkKernel, polyW]
      rw [e]
      exact Matrix.PosSemidef.zero
  | succ N ih =>
      have e : linkKernel (polyW R (N + 1) c) =
          linkKernel (polyW R N c) + c N • Matrix.of (fun a b => classMat R a b ^ N) := by
        ext a b
        simp only [linkKernel, polyW, Finset.sum_range_succ, Matrix.add_apply, Matrix.smul_apply, smul_eq_mul,
          Matrix.of_apply, classMat]
      rw [e]
      exact ih.add (posSemidef_smul_nonneg _ (posSemidef_hadamard_pow (classMat R) (classMat_posSemidef R) N)
        (c N) (hc N))

/-- the polynomial action is positive when the constant term dominates: c_0 > Σ_{1 ≤ k ≤ N} c_k d^k -/
theorem polyW_pos {d : ℕ} (R : OrthRep G d) (N : ℕ) (c : ℕ → ℝ) (hc : ∀ k, 0 ≤ c k)
    (hdom : ∑ k ∈ Finset.range N, c (k + 1) * (d : ℝ) ^ (k + 1) < c 0) (g : G) :
    0 < polyW R (N + 1) c g := by
  have hχ := abs_char_le R g
  have hterm : ∀ k ∈ Finset.range N,
      -(c (k + 1) * (d : ℝ) ^ (k + 1)) ≤ c (k + 1) * R.char g ^ (k + 1) := by
    intro k _
    have h1 : |R.char g ^ (k + 1)| ≤ (d : ℝ) ^ (k + 1) := by
      rw [abs_pow]
      exact pow_le_pow_left₀ (abs_nonneg _) hχ (k + 1)
    have h2 : -((d : ℝ) ^ (k + 1)) ≤ R.char g ^ (k + 1) := by
      have := neg_abs_le (R.char g ^ (k + 1))
      linarith
    calc -(c (k + 1) * (d : ℝ) ^ (k + 1)) = c (k + 1) * (-((d : ℝ) ^ (k + 1))) := by ring
      _ ≤ c (k + 1) * R.char g ^ (k + 1) := mul_le_mul_of_nonneg_left h2 (hc (k + 1))
  have hsum := Finset.sum_le_sum hterm
  rw [Finset.sum_neg_distrib] at hsum
  simp only [polyW]
  rw [Finset.sum_range_succ']
  simp only [pow_zero, mul_one]
  linarith

end Polynomial

end Aperanton
