/-
  APERANTON -- THE BOUNDLESS, stage Β2 (ADDENDUM I, THE ROAD): THE COMPLEX LIFT.

  A unitary representation ρ : G → U(d) is realified: the real matrix [[Re ρ, −Im ρ], [Im ρ, Re ρ]] on
  Fin d ⊕ Fin d (`reBlocks`) is multiplicative (`reBlocks_mul`: the real and imaginary parts of a product by
  Complex.mul_re and mul_im, entry by entry), unital (`reBlocks_one`), its transpose is the realification of the
  conjugate transpose (`reBlocks_transpose`), so unitarity becomes orthogonality (`reBlocks_orth`); its trace is
  twice the real part of the trace (`trace_reBlocks`); it is injective when ρ is (`reBlocks_injective`); and a real
  invariant vector of the realification is the real and imaginary parts of a complex invariant vector of ρ
  (`reBlocks_invariant`).  Reindexed along `finSumFinEquiv` to `Fin (d + d)` it is an `OrthRep G (d + d)`
  (`UnitaryRep.realify`), faithful when ρ is (`realify_injective`), with no invariant vector when ρ has none
  (`realify_noInvariant`): EVERY LANDED LATTICE THEOREM AND Β1 APPLY TO THE WILSON ACTION e^{β·2 Re tr ρ} OF
  EVERY UNITARY REPRESENTATION OF EVERY FINITE GROUP (`wilson_lattice_potential_gap_unitary`) -- SU(N)'s
  fundamental on every finite subgroup among them.  W = 0 (the realification is textbook); the composition with
  the lattice theorem is the build.  No sorry, no axiom, no native_decide.
-/
import Mathlib
import Aperanton.LinearAction
import Aperanton.Wilson
import Aperanton.Separation

open Matrix Finset

namespace Aperanton

section ReBlocks

variable {d : ℕ}

/-- the realification of a complex matrix: [[Re, −Im], [Im, Re]] on Fin d ⊕ Fin d -/
def reBlocks (A : Matrix (Fin d) (Fin d) ℂ) : Matrix (Fin d ⊕ Fin d) (Fin d ⊕ Fin d) ℝ :=
  fromBlocks (A.map Complex.re) (-(A.map Complex.im)) (A.map Complex.im) (A.map Complex.re)

theorem map_re_mul (A B : Matrix (Fin d) (Fin d) ℂ) :
    (A * B).map Complex.re = A.map Complex.re * B.map Complex.re - A.map Complex.im * B.map Complex.im := by
  ext i j
  simp only [Matrix.map_apply, Matrix.mul_apply, Matrix.sub_apply, Complex.re_sum, Complex.mul_re, sum_sub_distrib]

theorem map_im_mul (A B : Matrix (Fin d) (Fin d) ℂ) :
    (A * B).map Complex.im = A.map Complex.re * B.map Complex.im + A.map Complex.im * B.map Complex.re := by
  ext i j
  simp only [Matrix.map_apply, Matrix.mul_apply, Matrix.add_apply, Complex.im_sum, Complex.mul_im, sum_add_distrib]

/-- the realification is multiplicative -/
theorem reBlocks_mul (A B : Matrix (Fin d) (Fin d) ℂ) : reBlocks (A * B) = reBlocks A * reBlocks B := by
  simp only [reBlocks, fromBlocks_multiply, map_re_mul, map_im_mul]
  congr 1 <;> (try simp only [Matrix.neg_mul, Matrix.mul_neg]) <;> abel

theorem map_re_one : (1 : Matrix (Fin d) (Fin d) ℂ).map Complex.re = 1 := by
  ext i j
  simp only [map_apply, one_apply]
  split_ifs <;> simp

theorem map_im_one : (1 : Matrix (Fin d) (Fin d) ℂ).map Complex.im = 0 := by
  ext i j
  simp only [Matrix.map_apply, Matrix.one_apply, Matrix.zero_apply]
  split_ifs <;> simp

/-- the realification is unital -/
theorem reBlocks_one : reBlocks (1 : Matrix (Fin d) (Fin d) ℂ) = 1 := by
  simp only [reBlocks, map_re_one, map_im_one, neg_zero, fromBlocks_one]

theorem map_re_conjTranspose (A : Matrix (Fin d) (Fin d) ℂ) :
    Aᴴ.map Complex.re = (A.map Complex.re)ᵀ := by
  ext i j
  simp [map_apply, conjTranspose_apply, transpose_apply, Complex.conj_re]

theorem map_im_conjTranspose (A : Matrix (Fin d) (Fin d) ℂ) :
    Aᴴ.map Complex.im = -(A.map Complex.im)ᵀ := by
  ext i j
  simp [map_apply, conjTranspose_apply, transpose_apply, Complex.conj_im]

/-- the transpose of the realification is the realification of the conjugate transpose -/
theorem reBlocks_transpose (A : Matrix (Fin d) (Fin d) ℂ) : (reBlocks A)ᵀ = reBlocks Aᴴ := by
  simp only [reBlocks, fromBlocks_transpose, map_re_conjTranspose, map_im_conjTranspose, transpose_neg,
    neg_neg]

/-- a unitary matrix realifies to an orthogonal one -/
theorem reBlocks_orth (A : Matrix (Fin d) (Fin d) ℂ) (hA : A * Aᴴ = 1) : reBlocks A * (reBlocks A)ᵀ = 1 := by
  rw [reBlocks_transpose, ← reBlocks_mul, hA, reBlocks_one]

/-- the trace of the realification is twice the real part of the trace -/
theorem trace_reBlocks (A : Matrix (Fin d) (Fin d) ℂ) : (reBlocks A).trace = 2 * A.trace.re := by
  simp only [Matrix.trace, Matrix.diag_apply, reBlocks, Fintype.sum_sum_type, Matrix.fromBlocks_apply₁₁,
    Matrix.fromBlocks_apply₂₂, Matrix.map_apply, Complex.re_sum]
  ring

/-- the realification is injective -/
theorem reBlocks_injective : Function.Injective (reBlocks (d := d)) := by
  intro A B h
  have hre : A.map Complex.re = B.map Complex.re := by
    have := congrArg Matrix.toBlocks₁₁ h
    simpa [reBlocks, toBlocks_fromBlocks₁₁] using this
  have him : A.map Complex.im = B.map Complex.im := by
    have := congrArg Matrix.toBlocks₂₁ h
    simpa [reBlocks, toBlocks_fromBlocks₂₁] using this
  ext i j
  apply Complex.ext
  · have := congrFun (congrFun hre i) j
    simpa [Matrix.map_apply] using this
  · have := congrFun (congrFun him i) j
    simpa [Matrix.map_apply] using this

/-- a real invariant vector of the realification is the real and imaginary parts of a complex invariant vector -/
theorem reBlocks_invariant (A : Matrix (Fin d) (Fin d) ℂ) (x y : Fin d → ℝ)
    (h : reBlocks A *ᵥ Sum.elim x y = Sum.elim x y) :
    A *ᵥ (fun i => (⟨x i, y i⟩ : ℂ)) = fun i => (⟨x i, y i⟩ : ℂ) := by
  simp only [reBlocks, fromBlocks_mulVec] at h
  have h1 : A.map Complex.re *ᵥ x + (-(A.map Complex.im)) *ᵥ y = x := by
    have := congrArg (fun v => v ∘ Sum.inl) h
    funext i
    exact congrFun this i
  have h2 : A.map Complex.im *ᵥ x + A.map Complex.re *ᵥ y = y := by
    have := congrArg (fun v => v ∘ Sum.inr) h
    funext i
    exact congrFun this i
  funext i
  apply Complex.ext
  · have := congrFun h1 i
    simp only [Pi.add_apply, mulVec, dotProduct, Matrix.map_apply, Matrix.neg_apply] at this
    show (∑ j, A i j * (⟨x j, y j⟩ : ℂ)).re = x i
    rw [Complex.re_sum, ← this, ← Finset.sum_add_distrib]
    refine Finset.sum_congr rfl fun j _ => ?_
    show (A i j).re * x j - (A i j).im * y j = (A i j).re * x j + -(A i j).im * y j
    ring
  · have := congrFun h2 i
    simp only [Pi.add_apply, mulVec, dotProduct, Matrix.map_apply] at this
    show (∑ j, A i j * (⟨x j, y j⟩ : ℂ)).im = y i
    rw [Complex.im_sum, ← this, ← Finset.sum_add_distrib]
    refine Finset.sum_congr rfl fun j _ => ?_
    show (A i j).re * y j + (A i j).im * x j = (A i j).im * x j + (A i j).re * y j
    ring

end ReBlocks

section Realify

variable {G : Type*} [Group G] [Fintype G] [DecidableEq G] {d : ℕ}

/-- a unitary representation: multiplicative, unital, unitary -/
structure UnitaryRep (G : Type*) [Group G] (d : ℕ) where
  ρ : G → Matrix (Fin d) (Fin d) ℂ
  map_mul : ∀ a b, ρ (a * b) = ρ a * ρ b
  map_one : ρ 1 = 1
  unitary : ∀ a, ρ a * (ρ a)ᴴ = 1

/-- the reindexing of the realification to Fin (d + d) -/
def realMat (A : Matrix (Fin d) (Fin d) ℂ) : Matrix (Fin (d + d)) (Fin (d + d)) ℝ :=
  (reBlocks A).submatrix finSumFinEquiv.symm finSumFinEquiv.symm

theorem realMat_mul (A B : Matrix (Fin d) (Fin d) ℂ) : realMat (A * B) = realMat A * realMat B := by
  simp only [realMat, reBlocks_mul]
  rw [submatrix_mul_equiv]

theorem realMat_one : realMat (1 : Matrix (Fin d) (Fin d) ℂ) = 1 := by
  simp only [realMat, reBlocks_one]
  exact submatrix_one_equiv _

theorem realMat_transpose (A : Matrix (Fin d) (Fin d) ℂ) : (realMat A)ᵀ = realMat Aᴴ := by
  simp only [realMat, transpose_submatrix, reBlocks_transpose]

theorem realMat_injective : Function.Injective (realMat (d := d)) := by
  intro A B h
  apply reBlocks_injective
  ext i j
  have := congrFun (congrFun h (finSumFinEquiv i)) (finSumFinEquiv j)
  simpa [realMat, submatrix_apply] using this

theorem trace_realMat (A : Matrix (Fin d) (Fin d) ℂ) : (realMat A).trace = 2 * A.trace.re := by
  rw [← trace_reBlocks]
  simp only [realMat, Matrix.trace, Matrix.diag_apply, Matrix.submatrix_apply]
  exact Fintype.sum_equiv finSumFinEquiv.symm _ _ (fun i => rfl)

/-- THE REALIFIED REPRESENTATION: an orthogonal representation of dimension d + d with character 2 Re tr ρ -/
def UnitaryRep.realify (U : UnitaryRep G d) : OrthRep G (d + d) where
  ρ g := realMat (U.ρ g)
  map_mul a b := by rw [U.map_mul, realMat_mul]
  map_one := by rw [U.map_one, realMat_one]
  orth a := by rw [realMat_transpose, ← realMat_mul, U.unitary, realMat_one]

theorem realify_char (U : UnitaryRep G d) (g : G) : U.realify.char g = 2 * (U.ρ g).trace.re := by
  simp only [OrthRep.char, UnitaryRep.realify, trace_realMat]

/-- the realification is faithful when the unitary representation is -/
theorem realify_injective (U : UnitaryRep G d) (hU : Function.Injective U.ρ) :
    Function.Injective U.realify.ρ := fun a b h => hU (realMat_injective h)

/-- the realification has no nonzero invariant vector when the unitary representation has none -/
theorem realify_noInvariant (U : UnitaryRep G d)
    (hU : ∀ v : Fin d → ℂ, (∀ h, U.ρ h *ᵥ v = v) → v = 0) :
    ∀ u : Fin (d + d) → ℝ, (∀ h, U.realify.ρ h *ᵥ u = u) → u = 0 := by
  intro u hu
  set x : Fin d → ℝ := fun i => u (finSumFinEquiv (Sum.inl i)) with hx
  set y : Fin d → ℝ := fun i => u (finSumFinEquiv (Sum.inr i)) with hy
  have hsplit : u = (Sum.elim x y) ∘ finSumFinEquiv.symm := by
    funext i
    obtain ⟨s, rfl⟩ := finSumFinEquiv.surjective i
    rw [Function.comp_apply, Equiv.symm_apply_apply]
    rcases s with i | i <;> rfl
  have hinv : ∀ h, reBlocks (U.ρ h) *ᵥ Sum.elim x y = Sum.elim x y := by
    intro h
    have := hu h
    simp only [UnitaryRep.realify, realMat] at this
    rw [hsplit] at this
    funext s
    have := congrFun this (finSumFinEquiv s)
    simp only [Function.comp, Equiv.symm_apply_apply] at this
    rw [← this]
    simp only [mulVec, dotProduct, submatrix_apply, Function.comp, Equiv.symm_apply_apply]
    exact Fintype.sum_equiv finSumFinEquiv _ _ (fun t => by simp)
  have hz := hU (fun i => (⟨x i, y i⟩ : ℂ)) (fun h => reBlocks_invariant (U.ρ h) x y (hinv h))
  have hxz : x = 0 := by
    funext i
    have := congrFun hz i
    simpa using congrArg Complex.re this
  have hyz : y = 0 := by
    funext i
    have := congrFun hz i
    simpa using congrArg Complex.im this
  rw [hsplit, hxz, hyz]
  funext i
  obtain ⟨s, rfl⟩ := finSumFinEquiv.surjective i
  rcases s with i | i <;> simp

end Realify

section UnitaryLattice

variable {G : Type*} [Group G] [Fintype G] [DecidableEq G] {V L : Type*} [DecidableEq V] [Fintype L]
  [DecidableEq L]

/-- THE LATTICE THEOREM FOR THE WILSON ACTION OF EVERY UNITARY REPRESENTATION, UNCONDITIONAL FOR FAITHFUL ONES:
the in-plane weight exp(β′ · 2 Re tr ρ′), the x-plaquette weight exp(β · 2 Re tr ρ) of a FAITHFUL unitary ρ at
β > 0, a loop representation σ of positive dimension with no complex invariant vector -- every loop's static
potential is strictly positive and at least the sector's gap; SU(N)'s fundamental on every finite subgroup is
such a ρ -/
theorem wilson_lattice_potential_gap_unitary {d d' e : ℕ} (Λ : Lat V L) {ι : Type*} [Fintype ι]
    (sq : ι → Square Λ) (U' : UnitaryRep G d') (β' : ℝ) (U : UnitaryRep G d) (hU : Function.Injective U.ρ)
    (β : ℝ) (hβ : 0 < β) (σ : UnitaryRep G e) (he : 0 < e)
    (hσ : ∀ v : Fin e → ℂ, (∀ h, σ.ρ h *ᵥ v = v) → v = 0)
    (ℓ₀ : L) (rest : List L) (v : V) (hsrc : Λ.src ℓ₀ = v) (htgt0 : Λ.tgt ℓ₀ ≠ v)
    (hsrc' : ∀ ℓ ∈ rest, Λ.src ℓ ≠ v) (htgt' : ∀ ℓ ∈ rest, Λ.tgt ℓ ≠ v) :
    ∃ φ : G → G → ℝ, (∀ x y, classMat σ.realify x y = ∑ j, φ j x * φ j y) ∧
      ∀ Ω : (L → G) → ℝ,
        transfer (plaqWeight sq (wilsonW U'.realify β')) (tensorKernel (linkKernel (wilsonW U.realify β))) *ᵥ Ω =
          lamMax (transfer (plaqWeight sq (wilsonW U'.realify β')) (tensorKernel (linkKernel (wilsonW U.realify β))))
            (transfer_posSemidef (plaqWeight sq (wilsonW U'.realify β')) _
              (tensorKernel_posSemidef (linkKernel (wilsonW U.realify β))
                (wilsonKernel_posSemidef U.realify β hβ.le))).1 • Ω →
        Ω ⬝ᵥ Ω = 1 →
        (∀ Rr : ℕ, Filter.Tendsto (fun a : ℕ =>
            slabLoop (plaqWeight sq (wilsonW U'.realify β')) (tensorKernel (linkKernel (wilsonW U.realify β)))
              (fun c c' => classMat σ.realify (lineHol (ℓ₀ :: rest) c) (lineHol (ℓ₀ :: rest) c')) a Rr /
            slabZ (plaqWeight sq (wilsonW U'.realify β')) (tensorKernel (linkKernel (wilsonW U.realify β)))
              (a + 1) Rr)
          Filter.atTop
          (nhds (∑ j, (diagonal (fun c => φ j (lineHol (ℓ₀ :: rest) c)) *ᵥ Ω) ⬝ᵥ
              (transfer (plaqWeight sq (wilsonW U'.realify β'))
                (tensorKernel (linkKernel (wilsonW U.realify β))) ^ Rr *ᵥ
                (diagonal (fun c => φ j (lineHol (ℓ₀ :: rest) c)) *ᵥ Ω)) /
            lamMax (transfer (plaqWeight sq (wilsonW U'.realify β'))
                (tensorKernel (linkKernel (wilsonW U.realify β))))
              (transfer_posSemidef (plaqWeight sq (wilsonW U'.realify β')) _
                (tensorKernel_posSemidef (linkKernel (wilsonW U.realify β))
                  (wilsonKernel_posSemidef U.realify β hβ.le))).1 ^ Rr))) ∧
        ∃ s : ℝ, 0 < s ∧ Filter.Tendsto (fun Rr : ℕ =>
            Real.log (lamMax (transfer (plaqWeight sq (wilsonW U'.realify β'))
                (tensorKernel (linkKernel (wilsonW U.realify β))))
              (transfer_posSemidef (plaqWeight sq (wilsonW U'.realify β')) _
                (tensorKernel_posSemidef (linkKernel (wilsonW U.realify β))
                  (wilsonKernel_posSemidef U.realify β hβ.le))).1) -
            Real.log (∑ j, (diagonal (fun c => φ j (lineHol (ℓ₀ :: rest) c)) *ᵥ Ω) ⬝ᵥ
              (transfer (plaqWeight sq (wilsonW U'.realify β'))
                (tensorKernel (linkKernel (wilsonW U.realify β))) ^ Rr *ᵥ
                (diagonal (fun c => φ j (lineHol (ℓ₀ :: rest) c)) *ᵥ Ω))) / Rr) Filter.atTop (nhds s) :=
  wilson_lattice_potential_gap_faithful Λ sq U'.realify β' U.realify (realify_injective U hU) β hβ
    σ.realify (by omega) (realify_noInvariant σ hσ) ℓ₀ rest v hsrc htgt0 hsrc' htgt'

end UnitaryLattice

end Aperanton
