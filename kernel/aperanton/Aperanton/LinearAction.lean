/-
  APERANTON -- THE BOUNDLESS, stage A8f: THE LINEAR ACTION -- the representation-theoretic hypotheses of the lattice
  theorem discharged from a real orthogonal representation, with no Fourier theory.

  GaugeAction.lean's lattice theorem asks, for a general finite group, that the Wilson loop's class matrix
  X(a, b) = χ(a b⁻¹) be positive semidefinite and kill the constants, and that the link weight's kernel
  k(a, b) = w(a b⁻¹) be positive semidefinite and positive.  For a REAL ORTHOGONAL representation ρ (ρ(ab) = ρ(a) ρ(b),
  ρ(a) ρ(a)ᵀ = 1, ρ(1) = 1) all of this is finite linear algebra: ρ(b⁻¹) = ρ(b)ᵀ, so χ(a b⁻¹) = tr(ρ(a) ρ(b)ᵀ) is THE
  GRAM MATRIX of the vectors ρ(a) ∈ ℝ^{d×d} (`classMat_posSemidef`); the sum P = Σ_g ρ(g) sends every vector to an
  invariant one, so when ρ has no nonzero invariant vector P = 0 and the class matrix kills the constants
  (`classMat_mulVec_one`); |χ(g)| ≤ d since the diagonal of an orthogonal matrix lies in [−1, 1] (`abs_char_le`); and
  THE LINEAR ACTION w(g) = C + χ(g) with C > d is a positive class function whose link kernel C·J + X is positive
  semidefinite and positive (`linearKernel_posSemidef`, `linearKernel_pos`).  WHAT THE LINEAR ACTION DOES NOT GIVE: W(1) > 0.  Its kernel
  C·J + X is positive semidefinite, not positive definite, and the loop's one-step correlation ⟨F Ω, M F Ω⟩ is a sum of
  squared overlaps with products of ρ's coefficients along the endpoint's links -- EXACTLY ZERO when the loop's
  representation is absent from those short tensor products, and then the lattice theorem says nothing about that
  loop.  Cite it "for loops with W(1) > 0"; W(1) is a number to compute per instance.  The complex unitary representations
  enter through their realifications (a d-dimensional unitary representation is a 2d-dimensional orthogonal one with
  character 2 Re χ), so the real parts of all characters are covered.  No sorry, no axiom.
-/
import Mathlib
import Aperanton.XTransfer
import Aperanton.GaugeAction

open Matrix

namespace Aperanton

section Orthogonal

variable {G : Type*} [Group G] [Fintype G] [DecidableEq G] {d : ℕ}

/-- a real orthogonal representation: multiplicative, unital, orthogonal -/
structure OrthRep (G : Type*) [Group G] (d : ℕ) where
  ρ : G → Matrix (Fin d) (Fin d) ℝ
  map_mul : ∀ a b, ρ (a * b) = ρ a * ρ b
  map_one : ρ 1 = 1
  orth : ∀ a, ρ a * (ρ a)ᵀ = 1

/-- the character -/
def OrthRep.char (R : OrthRep G d) (g : G) : ℝ := (R.ρ g).trace

/-- the inverse is represented by the transpose -/
theorem OrthRep.map_inv (R : OrthRep G d) (b : G) : R.ρ b⁻¹ = (R.ρ b)ᵀ := by
  have h1 : R.ρ b * R.ρ b⁻¹ = 1 := by rw [← R.map_mul, mul_inv_cancel, R.map_one]
  have e1 : (R.ρ b)⁻¹ = R.ρ b⁻¹ := Matrix.inv_eq_right_inv h1
  have e2 : (R.ρ b)⁻¹ = (R.ρ b)ᵀ := Matrix.inv_eq_right_inv (R.orth b)
  rw [← e1, e2]

/-- the transpose is a left inverse too -/
theorem OrthRep.orth' (R : OrthRep G d) (x : G) : (R.ρ x)ᵀ * R.ρ x = 1 := by
  rw [← R.map_inv, ← R.map_mul, inv_mul_cancel, R.map_one]

/-- the class matrix of the character, χ(a b⁻¹) = tr(ρ(a) ρ(b)ᵀ) -/
def classMat (R : OrthRep G d) : Matrix G G ℝ := fun a b => R.char (a * b⁻¹)

theorem classMat_eq_trace (R : OrthRep G d) (a b : G) : classMat R a b = (R.ρ a * (R.ρ b)ᵀ).trace := by
  simp only [classMat, OrthRep.char, R.map_mul, R.map_inv]

/-- THE CLASS MATRIX IS THE GRAM MATRIX OF THE REPRESENTATION MATRICES: χ(a b⁻¹) = Σ_{ij} ρ(a)_{ij} ρ(b)_{ij} -/
theorem classMat_eq_gram (R : OrthRep G d) (a b : G) :
    classMat R a b = ∑ p : Fin d × Fin d, R.ρ a p.1 p.2 * R.ρ b p.1 p.2 := by
  rw [classMat_eq_trace]
  simp only [Matrix.trace, Matrix.diag, mul_apply, transpose_apply]
  rw [Fintype.sum_prod_type]

/-- THE CLASS MATRIX IS POSITIVE SEMIDEFINITE -/
theorem classMat_posSemidef (R : OrthRep G d) : (classMat R).PosSemidef :=
  posSemidef_of_gram (classMat R) (fun p : Fin d × Fin d => fun a => R.ρ a p.1 p.2) (classMat_eq_gram R)

/-- the averaging operator Σ_g ρ(g) sends every vector to an invariant one -/
theorem sum_rep_invariant (R : OrthRep G d) (h : G) (u : Fin d → ℝ) :
    R.ρ h *ᵥ ((∑ g, R.ρ g) *ᵥ u) = (∑ g, R.ρ g) *ᵥ u := by
  rw [mulVec_mulVec, Finset.mul_sum]
  congr 1
  rw [show (∑ g, R.ρ h * R.ρ g) = ∑ g, R.ρ (h * g) from Finset.sum_congr rfl fun g _ => (R.map_mul h g).symm]
  exact Equiv.sum_comp (Equiv.mulLeft h) R.ρ

/-- WITH NO NONZERO INVARIANT VECTOR, THE AVERAGE OF THE REPRESENTATION VANISHES -/
theorem sum_rep_eq_zero (R : OrthRep G d) (hinv : ∀ u : Fin d → ℝ, (∀ h, R.ρ h *ᵥ u = u) → u = 0) :
    (∑ g, R.ρ g) = 0 := by
  apply Matrix.ext
  intro i j
  have hcol : (∑ g, R.ρ g) *ᵥ Pi.single j 1 = 0 :=
    hinv _ (fun h => sum_rep_invariant R h _)
  have := congrFun hcol i
  simpa [mulVec, dotProduct, Pi.single_apply] using this

/-- THE CLASS MATRIX KILLS THE CONSTANTS when ρ has no nonzero invariant vector -/
theorem classMat_mulVec_one (R : OrthRep G d) (hinv : ∀ u : Fin d → ℝ, (∀ h, R.ρ h *ᵥ u = u) → u = 0) :
    classMat R *ᵥ (fun _ => (1 : ℝ)) = 0 := by
  funext a
  simp only [mulVec, dotProduct, mul_one, Pi.zero_apply]
  simp only [classMat_eq_trace]
  rw [← Matrix.trace_sum, ← Finset.mul_sum, ← Matrix.transpose_sum, sum_rep_eq_zero R hinv]
  simp

/-- the diagonal of an orthogonal matrix lies in [−1, 1], so |χ(g)| ≤ d -/
theorem abs_char_le (R : OrthRep G d) (g : G) : |R.char g| ≤ d := by
  have hrow : ∀ i, R.ρ g i i * R.ρ g i i ≤ 1 := by
    intro i
    have h := congrFun (congrFun (R.orth g) i) i
    rw [mul_apply, one_apply_eq] at h
    rw [← h]
    have : R.ρ g i i * (R.ρ g)ᵀ i i = R.ρ g i i * R.ρ g i i := by rw [transpose_apply]
    rw [← this]
    exact Finset.single_le_sum (f := fun j => R.ρ g i j * (R.ρ g)ᵀ j i)
      (fun j _ => by rw [transpose_apply]; exact mul_self_nonneg _) (Finset.mem_univ i)
  have hbound : ∀ i, |R.ρ g i i| ≤ 1 := fun i => by
    have := sq_le_sq.mp (show (R.ρ g i i) ^ 2 ≤ (1 : ℝ) ^ 2 by rw [one_pow, sq]; exact hrow i)
    rwa [abs_one] at this
  calc |R.char g| = |∑ i, R.ρ g i i| := rfl
    _ ≤ ∑ i, |R.ρ g i i| := Finset.abs_sum_le_sum_abs _ _
    _ ≤ ∑ i : Fin d, (1 : ℝ) := Finset.sum_le_sum fun i _ => hbound i
    _ = d := by simp

/-- THE LINEAR ACTION: w(g) = C + χ(g) -/
def linearW (R : OrthRep G d) (C : ℝ) (g : G) : ℝ := C + R.char g

theorem linearW_classFn (R : OrthRep G d) (C : ℝ) : IsClassFn (linearW R C) := by
  intro x y
  simp only [linearW, OrthRep.char, R.map_mul, R.map_inv]
  congr 1
  rw [Matrix.trace_mul_comm, ← mul_assoc, R.orth', one_mul]

theorem linearW_pos (R : OrthRep G d) (C : ℝ) (hC : (d : ℝ) < C) (g : G) : 0 < linearW R C g := by
  have := abs_char_le R g
  have := neg_abs_le (R.char g)
  simp only [linearW]
  linarith

/-- the link kernel of the linear action is C·J + the class matrix -/
theorem linearKernel_eq (R : OrthRep G d) (C : ℝ) :
    linkKernel (linearW R C) = Matrix.of (fun _ _ => C) + classMat R := by
  ext a b
  simp [linkKernel, linearW, classMat, OrthRep.char]

/-- the all-C matrix is positive semidefinite for C ≥ 0 -/
theorem constMat_posSemidef (C : ℝ) (hC : 0 ≤ C) : (Matrix.of (fun _ _ : G => C)).PosSemidef :=
  posSemidef_of_gram (Matrix.of (fun _ _ : G => C)) (fun _ : Unit => fun _ => Real.sqrt C)
    (fun a b => by simp [Real.mul_self_sqrt hC])

/-- THE LINK KERNEL OF THE LINEAR ACTION IS POSITIVE SEMIDEFINITE for C ≥ 0 -/
theorem linearKernel_posSemidef (R : OrthRep G d) (C : ℝ) (hC : 0 ≤ C) :
    (linkKernel (linearW R C)).PosSemidef := by
  rw [linearKernel_eq]
  exact (constMat_posSemidef C hC).add (classMat_posSemidef R)

/-- THE LINK KERNEL OF THE LINEAR ACTION IS POSITIVE for C > d -/
theorem linearKernel_pos (R : OrthRep G d) (C : ℝ) (hC : (d : ℝ) < C) (a b : G) :
    0 < linkKernel (linearW R C) a b :=
  linearW_pos R C hC _

end Orthogonal

section LinearLattice

variable {G : Type*} [Group G] [Fintype G] [DecidableEq G] {V L : Type*} [DecidableEq V] [Fintype L]
  [DecidableEq L]

/-- THE LATTICE THEOREM FOR THE LINEAR ACTION, every representation-theoretic hypothesis discharged: for a finite
group G with real orthogonal representations R' (the in-plane plaquette weight C' + χ_{R'}), R (the x-plaquette weight
C + χ_R, C > d) and σ (the loop's, with no nonzero invariant vector), on any finite cross-section of square plaquettes
and any T-line leaving a vertex once, the class matrix of σ has a Gram factorisation φ such that, for every unit Perron
vector Ω of the transfer matrix, the nonabelian Wilson loop of the x-transfer model converges at every R to
Σ_j ⟨F_j Ω, M^R F_j Ω⟩ / λ₀^R, and once that sum is positive at R = 1 its static potential is at least the sector's
gap -/
theorem linear_lattice_potential_gap {d d' e : ℕ} (Λ : Lat V L) {ι : Type*} [Fintype ι] (sq : ι → Square Λ)
    (R' : OrthRep G d') (C' : ℝ) (hC' : (d' : ℝ) < C') (R : OrthRep G d) (C : ℝ) (hC : (d : ℝ) < C)
    (σ : OrthRep G e) (hσ : ∀ u : Fin e → ℝ, (∀ h, σ.ρ h *ᵥ u = u) → u = 0)
    (ℓ₀ : L) (rest : List L) (v : V) (hsrc : Λ.src ℓ₀ = v) (htgt0 : Λ.tgt ℓ₀ ≠ v)
    (hsrc' : ∀ ℓ ∈ rest, Λ.src ℓ ≠ v) (htgt' : ∀ ℓ ∈ rest, Λ.tgt ℓ ≠ v) :
    ∃ φ : G → G → ℝ, (∀ x y, classMat σ x y = ∑ j, φ j x * φ j y) ∧
      ∀ Ω : (L → G) → ℝ,
        transfer (plaqWeight sq (linearW R' C')) (tensorKernel (linkKernel (linearW R C))) *ᵥ Ω =
          lamMax (transfer (plaqWeight sq (linearW R' C')) (tensorKernel (linkKernel (linearW R C))))
            (transfer_posSemidef (plaqWeight sq (linearW R' C')) _
              (tensorKernel_posSemidef (linkKernel (linearW R C)) (linearKernel_posSemidef R C (by linarith [hC, (Nat.cast_nonneg d : (0:ℝ) ≤ d)])))).1 • Ω →
        Ω ⬝ᵥ Ω = 1 →
        (∀ Rr : ℕ, Filter.Tendsto (fun a : ℕ =>
            slabLoop (plaqWeight sq (linearW R' C')) (tensorKernel (linkKernel (linearW R C)))
              (fun c c' => classMat σ (lineHol (ℓ₀ :: rest) c) (lineHol (ℓ₀ :: rest) c')) a Rr /
            slabZ (plaqWeight sq (linearW R' C')) (tensorKernel (linkKernel (linearW R C))) (a + 1) Rr)
          Filter.atTop
          (nhds (∑ j, (diagonal (fun c => φ j (lineHol (ℓ₀ :: rest) c)) *ᵥ Ω) ⬝ᵥ
              (transfer (plaqWeight sq (linearW R' C')) (tensorKernel (linkKernel (linearW R C))) ^ Rr *ᵥ
                (diagonal (fun c => φ j (lineHol (ℓ₀ :: rest) c)) *ᵥ Ω)) /
            lamMax (transfer (plaqWeight sq (linearW R' C')) (tensorKernel (linkKernel (linearW R C))))
              (transfer_posSemidef (plaqWeight sq (linearW R' C')) _
                (tensorKernel_posSemidef (linkKernel (linearW R C)) (linearKernel_posSemidef R C (by linarith [hC, (Nat.cast_nonneg d : (0:ℝ) ≤ d)])))).1 ^ Rr))) ∧
        (0 < ∑ j, (diagonal (fun c => φ j (lineHol (ℓ₀ :: rest) c)) *ᵥ Ω) ⬝ᵥ
            (transfer (plaqWeight sq (linearW R' C')) (tensorKernel (linkKernel (linearW R C))) *ᵥ
              (diagonal (fun c => φ j (lineHol (ℓ₀ :: rest) c)) *ᵥ Ω)) →
          ∃ s : ℝ, 0 < s ∧ Filter.Tendsto (fun Rr : ℕ =>
            Real.log (lamMax (transfer (plaqWeight sq (linearW R' C')) (tensorKernel (linkKernel (linearW R C))))
              (transfer_posSemidef (plaqWeight sq (linearW R' C')) _
                (tensorKernel_posSemidef (linkKernel (linearW R C)) (linearKernel_posSemidef R C (by linarith [hC, (Nat.cast_nonneg d : (0:ℝ) ≤ d)])))).1) -
            Real.log (∑ j, (diagonal (fun c => φ j (lineHol (ℓ₀ :: rest) c)) *ᵥ Ω) ⬝ᵥ
              (transfer (plaqWeight sq (linearW R' C')) (tensorKernel (linkKernel (linearW R C))) ^ Rr *ᵥ
                (diagonal (fun c => φ j (lineHol (ℓ₀ :: rest) c)) *ᵥ Ω))) / Rr) Filter.atTop (nhds s)) := by
  have hC0 : (0 : ℝ) ≤ C := by linarith [hC, (Nat.cast_nonneg d : (0:ℝ) ≤ d)]
  obtain ⟨φ, hφ⟩ := exists_gram (classMat σ) (classMat_posSemidef σ)
  refine ⟨φ, hφ, fun Ω hΩ hn => ?_⟩
  have hmain := lattice_potential_gap Λ sq (linearW R' C') (linearW_classFn R' C') (linearW_pos R' C' hC')
    (linearW R C) (linearW_classFn R C) (linearKernel_posSemidef R C hC0) (linearKernel_pos R C hC)
    ℓ₀ rest v hsrc htgt0 hsrc' htgt' (classMat σ) (classMat_posSemidef σ) (classMat_mulVec_one σ hσ) φ hφ Ω hΩ hn
  refine ⟨hmain.1, fun hW1 => ?_⟩
  obtain ⟨s, hs, -, hlim⟩ := hmain.2 hW1
  exact ⟨s, hs, hlim⟩

end LinearLattice


end Aperanton
