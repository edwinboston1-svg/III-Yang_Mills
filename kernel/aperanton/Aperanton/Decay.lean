/-
  APERANTON -- THE BOUNDLESS, stage Β3c (ADDENDUM I, THE ROAD): THE GAP READ OFF THE DECAY.

  A positive symmetric matrix M with Perron root λ₀ and unit Perron vector Ω.  If EVERY two-point function
  ⟨f, M^R f⟩/λ₀^R decays to its Perron mass (Ω·f)² at a rate α < 1 -- with a constant that may depend on f --
  then every eigenvalue other than λ₀ is at most α λ₀ (`eigenvalue_le_of_decay`): take f an eigenvector v_k,
  whose Perron mass is zero (`dot_eq_zero_of_ne_eigen`, symmetric matrices have orthogonal eigenspaces) and whose
  two-point function is (λ_k/λ₀)^R exactly; a ratio above α would outgrow K α^R.  Hence THE GAP IS AT LEAST
  −log α (`gap_of_decay`): log λ₀ − log λ_k ≥ −log α for every mass-carrying eigenvalue.  This is the step by
  which a Dobrushin covariance bound on the slab -- whose RATE α does not depend on the cross-section -- becomes a
  mass gap UNIFORM IN THE CROSS-SECTION once the slab's two-point functions are read through XTransfer.lean's limit.
  W = 0; no sorry, no axiom, no native_decide.
-/
import Mathlib
import Aperanton.Perron
import Aperanton.Spectral
import Aperanton.XTransfer
import Aperanton.GapBound

open Matrix Filter Topology

namespace Aperanton

section Decay

variable {n : Type*} [Fintype n] [DecidableEq n] [Nonempty n]

/-- eigenvectors of a real symmetric matrix at distinct eigenvalues are orthogonal -/
theorem dot_eq_zero_of_ne_eigen (M : Matrix n n ℝ) (hM : M.IsHermitian) (Ω v : n → ℝ) (μ ν : ℝ)
    (hΩ : M *ᵥ Ω = μ • Ω) (hv : M *ᵥ v = ν • v) (hne : μ ≠ ν) : Ω ⬝ᵥ v = 0 := by
  have hMT : Mᵀ = M := by rw [← conjTranspose_eq_transpose_of_trivial, hM.eq]
  have h1 : Ω ⬝ᵥ (M *ᵥ v) = ν * (Ω ⬝ᵥ v) := by rw [hv, dotProduct_smul, smul_eq_mul]
  have h2 : Ω ⬝ᵥ (M *ᵥ v) = μ * (Ω ⬝ᵥ v) := by
    rw [dotProduct_mulVec, ← mulVec_transpose, hMT, hΩ, smul_dotProduct, smul_eq_mul]
  have h3 : (μ - ν) * (Ω ⬝ᵥ v) = 0 := by rw [sub_mul, ← h2, ← h1, sub_self]
  rcases mul_eq_zero.mp h3 with h | h
  · exact absurd (sub_eq_zero.mp h) hne
  · exact h

/-- powers act on an eigenvector by powers of the eigenvalue -/
theorem pow_mulVec_eigen (M : Matrix n n ℝ) (v : n → ℝ) (ν : ℝ) (hv : M *ᵥ v = ν • v) (R : ℕ) :
    (M ^ R) *ᵥ v = ν ^ R • v := by
  induction R with
  | zero => simp
  | succ R ih =>
    rw [pow_succ, ← mulVec_mulVec, hv, mulVec_smul, ih, smul_smul, pow_succ, mul_comm]

/-- THE GAP READ OFF THE DECAY: if every two-point function decays to its Perron mass at rate α, every eigenvalue
other than the Perron root is at most α λ₀ -/
theorem eigenvalue_le_of_decay (M : Matrix n n ℝ) (hM : M.PosSemidef) (hpos : ∀ i j, 0 < M i j)
    (Ω : n → ℝ) (hΩ : M *ᵥ Ω = lamMax M hM.1 • Ω) (α : ℝ) (hα0 : 0 ≤ α)
    (hdecay : ∀ f : n → ℝ, ∃ K : ℝ, ∀ R : ℕ,
      |f ⬝ᵥ ((M ^ R) *ᵥ f) / lamMax M hM.1 ^ R - (Ω ⬝ᵥ f) ^ 2| ≤ K * α ^ R)
    (k : n) (hk : hM.1.eigenvalues k ≠ lamMax M hM.1) :
    hM.1.eigenvalues k ≤ α * lamMax M hM.1 := by
  obtain ⟨_, -, -, hl0⟩ := perron_exists M hM.1 hpos
  have hlk : 0 ≤ hM.1.eigenvalues k := hM.eigenvalues_nonneg k
  set v : n → ℝ := ⇑(hM.1.eigenvectorBasis k) with hvdef
  have hev : M *ᵥ v = hM.1.eigenvalues k • v := hM.1.mulVec_eigenvectorBasis k
  have hvv : v ⬝ᵥ v = 1 := by
    have h : inner ℝ (hM.1.eigenvectorBasis k) (hM.1.eigenvectorBasis k) = (1 : ℝ) := by
      have := orthonormal_iff_ite.mp hM.1.eigenvectorBasis.orthonormal k k
      simpa using this
    rw [EuclideanSpace.inner_eq_star_dotProduct] at h
    simpa using h
  have horth : Ω ⬝ᵥ v = 0 :=
    dot_eq_zero_of_ne_eigen M hM.1 Ω v _ _ hΩ hev (fun h => hk h.symm)
  obtain ⟨K, hK⟩ := hdecay v
  have hbound : ∀ R : ℕ, (hM.1.eigenvalues k / lamMax M hM.1) ^ R ≤ K * α ^ R := by
    intro R
    have h := hK R
    rw [pow_mulVec_eigen M v _ hev R, dotProduct_smul, hvv, smul_eq_mul, mul_one, horth] at h
    simp only [sq, mul_zero, sub_zero] at h
    rw [← div_pow] at h
    exact le_trans (le_abs_self _) h
  by_contra hcon
  push_neg at hcon
  have hq : α < hM.1.eigenvalues k / lamMax M hM.1 := by
    rw [lt_div_iff₀ hl0]; exact hcon
  rcases hα0.lt_or_eq with hαpos | hαzero
  · -- the ratio (q/α)^R is bounded by K yet grows without bound
    have hqα : 1 < hM.1.eigenvalues k / lamMax M hM.1 / α := by
      rw [lt_div_iff₀ hαpos, one_mul]; exact hq
    have hgrow := tendsto_pow_atTop_atTop_of_one_lt hqα
    obtain ⟨R, hR⟩ := (hgrow.eventually (eventually_gt_atTop K)).exists
    have hle : (hM.1.eigenvalues k / lamMax M hM.1 / α) ^ R ≤ K := by
      rw [div_pow, div_le_iff₀ (pow_pos hαpos R)]
      exact hbound R
    linarith
  · -- α = 0: the first power already forces the ratio to zero
    rw [← hαzero] at hq hbound
    have h1 := hbound 1
    simp only [pow_one, mul_zero] at h1
    linarith

/-- THE UNIFORM GAP: with the decay rate α ∈ (0, 1), log λ₀ − log λ_k ≥ −log α for every positive eigenvalue
other than the Perron root -/
theorem gap_of_decay (M : Matrix n n ℝ) (hM : M.PosSemidef) (hpos : ∀ i j, 0 < M i j)
    (Ω : n → ℝ) (hΩ : M *ᵥ Ω = lamMax M hM.1 • Ω) (α : ℝ) (hα0 : 0 < α)
    (hdecay : ∀ f : n → ℝ, ∃ K : ℝ, ∀ R : ℕ,
      |f ⬝ᵥ ((M ^ R) *ᵥ f) / lamMax M hM.1 ^ R - (Ω ⬝ᵥ f) ^ 2| ≤ K * α ^ R)
    (k : n) (hk : hM.1.eigenvalues k ≠ lamMax M hM.1) (hkpos : 0 < hM.1.eigenvalues k) :
    -Real.log α ≤ Real.log (lamMax M hM.1) - Real.log (hM.1.eigenvalues k) := by
  obtain ⟨_, -, -, hl0⟩ := perron_exists M hM.1 hpos
  have hle := eigenvalue_le_of_decay M hM hpos Ω hΩ α hα0.le hdecay k hk
  have hlog := Real.log_le_log hkpos hle
  rw [Real.log_mul hα0.ne' hl0.ne'] at hlog
  linarith

end Decay

end Aperanton
