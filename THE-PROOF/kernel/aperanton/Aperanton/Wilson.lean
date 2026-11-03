/-
  APERANTON -- THE BOUNDLESS, stage A8h: THE WILSON ACTION'S KERNEL IS POSITIVE SEMIDEFINITE.

  Schur.lean made every polynomial in the character with nonnegative coefficients a positive-definite class function;
  the Wilson action w(g) = exp(β χ(g)), β ≥ 0, is the limit of its partial sums Σ_{k<N} (β χ)^k / k!, entrywise in the
  link kernel, and the cone of positive semidefinite matrices is closed: for every v the quadratic forms
  ⟨v, K_N v⟩ ≥ 0 converge to ⟨v, K v⟩ (`posSemidef_of_tendsto`), so the Wilson kernel is positive semidefinite
  (`wilsonKernel_posSemidef`), positive since the exponential is (`wilsonW_pos`), and a class function
  (`wilsonW_classFn`).  With GaugeAction.lean's lattice theorem this makes every weight hypothesis of the nonabelian
  static-potential theorem a THEOREM for the Wilson action of any real orthogonal representation of any finite group,
  W(1) > 0 alone remaining.  No sorry, no axiom.
-/
import Mathlib
import Aperanton.XTransfer
import Aperanton.GaugeAction
import Aperanton.LinearAction
import Aperanton.Schur

open Matrix Filter Topology

namespace Aperanton

section Closed

variable {n : Type*} [Fintype n] [DecidableEq n]

/-- THE CONE IS CLOSED: an entrywise limit of positive semidefinite matrices is positive semidefinite, given symmetry -/
theorem posSemidef_of_tendsto (K : ℕ → Matrix n n ℝ) (M : Matrix n n ℝ) (hK : ∀ N, (K N).PosSemidef)
    (hM : M.IsHermitian) (hlim : ∀ a b, Tendsto (fun N => K N a b) atTop (𝓝 (M a b))) : M.PosSemidef := by
  apply Matrix.PosSemidef.of_dotProduct_mulVec_nonneg hM
  intro x
  have hform : Tendsto (fun N => star x ⬝ᵥ (K N *ᵥ x)) atTop (𝓝 (star x ⬝ᵥ (M *ᵥ x))) := by
    simp only [dotProduct, mulVec]
    apply tendsto_finsetSum
    intro a _
    apply Tendsto.mul tendsto_const_nhds
    apply tendsto_finsetSum
    intro b _
    exact (hlim a b).mul tendsto_const_nhds
  exact ge_of_tendsto' hform fun N => (hK N).dotProduct_mulVec_nonneg x

end Closed

section Wilson

variable {G : Type*} [Group G] [Fintype G] [DecidableEq G] {d : ℕ}

/-- THE WILSON ACTION: w(g) = exp(β χ(g)) -/
noncomputable def wilsonW (R : OrthRep G d) (β : ℝ) (g : G) : ℝ := Real.exp (β * R.char g)

theorem wilsonW_pos (R : OrthRep G d) (β : ℝ) (g : G) : 0 < wilsonW R β g := Real.exp_pos _

theorem wilsonW_classFn (R : OrthRep G d) (β : ℝ) : IsClassFn (wilsonW R β) := by
  intro x y
  have hχ : R.char (x * y * x⁻¹) = R.char y := by
    have := linearW_classFn R 0 x y
    simp only [linearW, zero_add] at this
    exact this
  simp only [wilsonW, hχ]

/-- the character of an orthogonal representation is inverse-symmetric: χ(g⁻¹) = χ(g) -/
theorem char_inv (R : OrthRep G d) (g : G) : R.char g⁻¹ = R.char g := by
  simp only [OrthRep.char, R.map_inv, Matrix.trace_transpose]

/-- the Wilson kernel is symmetric -/
theorem wilsonKernel_isHermitian (R : OrthRep G d) (β : ℝ) : (linkKernel (wilsonW R β)).IsHermitian := by
  rw [IsHermitian, conjTranspose_eq_transpose_of_trivial]
  ext a b
  simp only [transpose_apply, linkKernel, wilsonW]
  rw [show b * a⁻¹ = (a * b⁻¹)⁻¹ by group, char_inv]

/-- the partial sums of the exponential series are the polynomial actions with coefficients β^k / k! -/
theorem wilsonW_partial (R : OrthRep G d) (β : ℝ) (N : ℕ) (g : G) :
    polyW R N (fun k => β ^ k / (Nat.factorial k : ℝ)) g = ∑ k ∈ Finset.range N, (β * R.char g) ^ k / (Nat.factorial k : ℝ) := by
  simp only [polyW]
  apply Finset.sum_congr rfl
  intro k _
  rw [mul_pow]
  ring

/-- THE WILSON KERNEL IS POSITIVE SEMIDEFINITE for β ≥ 0: the limit of the polynomial actions' kernels -/
theorem wilsonKernel_posSemidef (R : OrthRep G d) (β : ℝ) (hβ : 0 ≤ β) : (linkKernel (wilsonW R β)).PosSemidef := by
  apply posSemidef_of_tendsto (fun N => linkKernel (polyW R N (fun k => β ^ k / (Nat.factorial k : ℝ))))
    (linkKernel (wilsonW R β))
  · intro N
    apply polyKernel_posSemidef
    intro k
    exact div_nonneg (pow_nonneg hβ k) (Nat.cast_nonneg _)
  · exact wilsonKernel_isHermitian R β
  · intro a b
    simp only [linkKernel, wilsonW_partial, wilsonW]
    have h := NormedSpace.expSeries_div_hasSum_exp (β * R.char (a * b⁻¹))
    rw [← Real.exp_eq_exp_ℝ] at h
    exact h.tendsto_sum_nat

end Wilson

section WilsonLattice

variable {G : Type*} [Group G] [Fintype G] [DecidableEq G] {V L : Type*} [DecidableEq V] [Fintype L]
  [DecidableEq L]

/-- the Wilson kernel is positive -/
theorem wilsonKernel_pos (R : OrthRep G d) (β : ℝ) (a b : G) : 0 < linkKernel (wilsonW R β) a b :=
  wilsonW_pos R β _

/-- THE LATTICE THEOREM FOR THE WILSON ACTION, the composition stated: real orthogonal representations R' (the
in-plane weight exp(β' χ_{R'})), R (the x-plaquette weight exp(β χ_R), β ≥ 0) and σ (the loop's, with no nonzero
invariant vector), any finite cross-section of square plaquettes, any T-line leaving a vertex once: the class matrix
of σ has a Gram factorisation φ such that for every unit Perron vector Ω of the transfer matrix the nonabelian Wilson
loop of the x-transfer model converges at every R to Σ_j ⟨F_j Ω, M^R F_j Ω⟩ / λ₀^R, and once that sum is positive at
R = 1 its static potential is at least the sector's gap -- every weight and representation hypothesis a theorem,
W(1) > 0 alone remaining -/
theorem wilson_lattice_potential_gap {d d' e : ℕ} (Λ : Lat V L) {ι : Type*} [Fintype ι] (sq : ι → Square Λ)
    (R' : OrthRep G d') (β' : ℝ) (R : OrthRep G d) (β : ℝ) (hβ : 0 ≤ β)
    (σ : OrthRep G e) (hσ : ∀ u : Fin e → ℝ, (∀ h, σ.ρ h *ᵥ u = u) → u = 0)
    (ℓ₀ : L) (rest : List L) (v : V) (hsrc : Λ.src ℓ₀ = v) (htgt0 : Λ.tgt ℓ₀ ≠ v)
    (hsrc' : ∀ ℓ ∈ rest, Λ.src ℓ ≠ v) (htgt' : ∀ ℓ ∈ rest, Λ.tgt ℓ ≠ v) :
    ∃ φ : G → G → ℝ, (∀ x y, classMat σ x y = ∑ j, φ j x * φ j y) ∧
      ∀ Ω : (L → G) → ℝ,
        transfer (plaqWeight sq (wilsonW R' β')) (tensorKernel (linkKernel (wilsonW R β))) *ᵥ Ω =
          lamMax (transfer (plaqWeight sq (wilsonW R' β')) (tensorKernel (linkKernel (wilsonW R β))))
            (transfer_posSemidef (plaqWeight sq (wilsonW R' β')) _
              (tensorKernel_posSemidef (linkKernel (wilsonW R β)) (wilsonKernel_posSemidef R β hβ))).1 • Ω →
        Ω ⬝ᵥ Ω = 1 →
        (∀ Rr : ℕ, Tendsto (fun a : ℕ =>
            slabLoop (plaqWeight sq (wilsonW R' β')) (tensorKernel (linkKernel (wilsonW R β)))
              (fun c c' => classMat σ (lineHol (ℓ₀ :: rest) c) (lineHol (ℓ₀ :: rest) c')) a Rr /
            slabZ (plaqWeight sq (wilsonW R' β')) (tensorKernel (linkKernel (wilsonW R β))) (a + 1) Rr)
          atTop
          (𝓝 (∑ j, (diagonal (fun c => φ j (lineHol (ℓ₀ :: rest) c)) *ᵥ Ω) ⬝ᵥ
              (transfer (plaqWeight sq (wilsonW R' β')) (tensorKernel (linkKernel (wilsonW R β))) ^ Rr *ᵥ
                (diagonal (fun c => φ j (lineHol (ℓ₀ :: rest) c)) *ᵥ Ω)) /
            lamMax (transfer (plaqWeight sq (wilsonW R' β')) (tensorKernel (linkKernel (wilsonW R β))))
              (transfer_posSemidef (plaqWeight sq (wilsonW R' β')) _
                (tensorKernel_posSemidef (linkKernel (wilsonW R β)) (wilsonKernel_posSemidef R β hβ))).1 ^ Rr))) ∧
        (0 < ∑ j, (diagonal (fun c => φ j (lineHol (ℓ₀ :: rest) c)) *ᵥ Ω) ⬝ᵥ
            (transfer (plaqWeight sq (wilsonW R' β')) (tensorKernel (linkKernel (wilsonW R β))) *ᵥ
              (diagonal (fun c => φ j (lineHol (ℓ₀ :: rest) c)) *ᵥ Ω)) →
          ∃ s : ℝ, 0 < s ∧ Tendsto (fun Rr : ℕ =>
            Real.log (lamMax (transfer (plaqWeight sq (wilsonW R' β')) (tensorKernel (linkKernel (wilsonW R β))))
              (transfer_posSemidef (plaqWeight sq (wilsonW R' β')) _
                (tensorKernel_posSemidef (linkKernel (wilsonW R β)) (wilsonKernel_posSemidef R β hβ))).1) -
            Real.log (∑ j, (diagonal (fun c => φ j (lineHol (ℓ₀ :: rest) c)) *ᵥ Ω) ⬝ᵥ
              (transfer (plaqWeight sq (wilsonW R' β')) (tensorKernel (linkKernel (wilsonW R β))) ^ Rr *ᵥ
                (diagonal (fun c => φ j (lineHol (ℓ₀ :: rest) c)) *ᵥ Ω))) / Rr) atTop (𝓝 s)) := by
  obtain ⟨φ, hφ⟩ := exists_gram (classMat σ) (classMat_posSemidef σ)
  refine ⟨φ, hφ, fun Ω hΩ hn => ?_⟩
  have hmain := lattice_potential_gap Λ sq (wilsonW R' β') (wilsonW_classFn R' β') (wilsonW_pos R' β')
    (wilsonW R β) (wilsonW_classFn R β) (wilsonKernel_posSemidef R β hβ) (wilsonKernel_pos R β)
    ℓ₀ rest v hsrc htgt0 hsrc' htgt' (classMat σ) (classMat_posSemidef σ) (classMat_mulVec_one σ hσ) φ hφ Ω hΩ hn
  refine ⟨hmain.1, fun hW1 => ?_⟩
  obtain ⟨s, hs, -, hlim⟩ := hmain.2 hW1
  exact ⟨s, hs, hlim⟩

end WilsonLattice

end Aperanton
