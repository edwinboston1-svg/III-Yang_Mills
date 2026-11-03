/-
  APERANTON -- THE BOUNDLESS, stage A8a: THE SPECTRAL LAW OF THE WILSON LOOP, AND THE STRING TENSION OF EVERY
  FINITE GROUP.

  In the x-direction transfer picture -- the loop's T-sides in the cross-section, its R-sides along x, the x-links in
  temporal gauge -- the Wilson loop of an R x T rectangle in the slab infinite along x reads W(R) = ⟨f, A^R f⟩: A the
  x-transfer matrix (real symmetric, positive semidefinite by reflection positivity in x) and f the T-line's vector in
  the vacuum; for a nonabelian character chi(a b⁻¹) = Σ_j F_j(a) conj F_j(b) it is a sum of such terms, each the sum
  of its real and imaginary parts' two.  So W(R) = Σ_k m_k x_k^R with m_k ≥ 0 on the eigenvalues x_k of A: A MOMENT
  SEQUENCE.  Proved here above Mathlib for any real positive semidefinite A and any f: the spectral representation
  (every power A^R = U diag(λ^R) U*), W nonnegative, nonincreasing once the eigenvalues lie in [0, 1], LOG-CONVEX in R
  (W(R+1)² ≤ W(R) W(R+2), Cauchy–Schwarz on the masses), and THE STRING TENSION EXISTS: log W(R) / R → log x*, x* the
  largest eigenvalue carrying mass, given only W(1) > 0; in the transfer matrix's own terms σ = log λ₀ − log x* ≥ 0.
  No Griffiths inequality and no abelian structure stand behind it -- this is Mechanism S's road for every finite
  group and every positive-definite plaquette weight on every finite cross-section; the x-transfer's construction and
  its positivity are stage A8b.  No sorry, no axiom.
-/
import Mathlib
import Aperanton.Perron

open Matrix Filter Topology

namespace Aperanton

section Moments

variable {ι : Type*} [Fintype ι]

/-- the moment sequence of masses m at points x: W(R) = Σ_i m_i x_i^R -/
def moment (m x : ι → ℝ) (R : ℕ) : ℝ := ∑ i, m i * x i ^ R

theorem moment_nonneg (m x : ι → ℝ) (hm : ∀ i, 0 ≤ m i) (hx : ∀ i, 0 ≤ x i) (R : ℕ) :
    0 ≤ moment m x R :=
  Finset.sum_nonneg fun i _ => mul_nonneg (hm i) (pow_nonneg (hx i) R)

theorem moment_zero (m x : ι → ℝ) : moment m x 0 = ∑ i, m i := by
  simp [moment]

/-- a sum of moment sequences on the same points is the moment sequence of the summed masses -/
theorem moment_sum {κ : Type*} (s : Finset κ) (m : κ → ι → ℝ) (x : ι → ℝ) (R : ℕ) :
    ∑ j ∈ s, moment (m j) x R = moment (fun i => ∑ j ∈ s, m j i) x R := by
  simp only [moment, Finset.sum_mul]
  rw [Finset.sum_comm]

/-- NONINCREASING when the points lie in [0, 1] -/
theorem moment_succ_le (m x : ι → ℝ) (hm : ∀ i, 0 ≤ m i) (hx : ∀ i, 0 ≤ x i) (hx1 : ∀ i, x i ≤ 1)
    (R : ℕ) : moment m x (R + 1) ≤ moment m x R := by
  unfold moment
  apply Finset.sum_le_sum
  intro i _
  calc m i * x i ^ (R + 1) = m i * x i ^ R * x i := by ring
    _ ≤ m i * x i ^ R * 1 :=
        mul_le_mul_of_nonneg_left (hx1 i) (mul_nonneg (hm i) (pow_nonneg (hx i) R))
    _ = m i * x i ^ R := by ring

/-- LOG-CONVEXITY: W(R+1)² ≤ W(R) W(R+2) -- Cauchy–Schwarz on the masses -/
theorem moment_sq_le (m x : ι → ℝ) (hm : ∀ i, 0 ≤ m i) (hx : ∀ i, 0 ≤ x i) (R : ℕ) :
    moment m x (R + 1) ^ 2 ≤ moment m x R * moment m x (R + 2) := by
  have hnn : ∀ i (S : ℕ), 0 ≤ m i * x i ^ S := fun i S => mul_nonneg (hm i) (pow_nonneg (hx i) S)
  have key : ∀ i, m i * x i ^ (R + 1) =
      Real.sqrt (m i * x i ^ R) * Real.sqrt (m i * x i ^ (R + 2)) := by
    intro i
    rw [← Real.sqrt_mul (hnn i R)]
    have : m i * x i ^ R * (m i * x i ^ (R + 2)) = (m i * x i ^ (R + 1)) ^ 2 := by ring
    rw [this, Real.sqrt_sq (hnn i (R + 1))]
  unfold moment
  simp_rw [key]
  calc (∑ i, Real.sqrt (m i * x i ^ R) * Real.sqrt (m i * x i ^ (R + 2))) ^ 2
      ≤ (∑ i, Real.sqrt (m i * x i ^ R) ^ 2) * ∑ i, Real.sqrt (m i * x i ^ (R + 2)) ^ 2 :=
        Finset.sum_mul_sq_le_sq_mul_sq _ _ _
    _ = (∑ i, m i * x i ^ R) * ∑ i, m i * x i ^ (R + 2) := by
        congr 1 <;> exact Finset.sum_congr rfl fun i _ => Real.sq_sqrt (hnn i _)

/-- THE STRING TENSION EXISTS: log W(R) / R → log x*, x* the largest point carrying mass -/
theorem log_moment_div_tendsto (m x : ι → ℝ) (hm : ∀ i, 0 ≤ m i) (hx : ∀ i, 0 ≤ x i)
    (i₀ : ι) (hm₀ : 0 < m i₀) (hx₀ : 0 < x i₀) (hmax : ∀ i, 0 < m i → x i ≤ x i₀) :
    Tendsto (fun R : ℕ => Real.log (moment m x R) / R) atTop (𝓝 (Real.log (x i₀))) := by
  have hlow : ∀ R : ℕ, m i₀ * x i₀ ^ R ≤ moment m x R := fun R =>
    Finset.single_le_sum (fun i _ => mul_nonneg (hm i) (pow_nonneg (hx i) R)) (Finset.mem_univ i₀)
  have hup : ∀ R : ℕ, moment m x R ≤ (∑ i, m i) * x i₀ ^ R := by
    intro R
    unfold moment
    rw [Finset.sum_mul]
    apply Finset.sum_le_sum
    intro i _
    by_cases h : 0 < m i
    · exact mul_le_mul_of_nonneg_left (pow_le_pow_left₀ (hx i) (hmax i h) R) (hm i)
    · have h0 : m i = 0 := le_antisymm (not_lt.mp h) (hm i)
      simp [h0]
  have hpos : ∀ R : ℕ, 0 < moment m x R := fun R =>
    lt_of_lt_of_le (mul_pos hm₀ (pow_pos hx₀ R)) (hlow R)
  have hsum : 0 < ∑ i, m i :=
    lt_of_lt_of_le hm₀ (Finset.single_le_sum (fun i _ => hm i) (Finset.mem_univ i₀))
  have hlogl : ∀ R : ℕ, Real.log (m i₀) + R * Real.log (x i₀) ≤ Real.log (moment m x R) := by
    intro R
    rw [← Real.log_pow, ← Real.log_mul hm₀.ne' (pow_pos hx₀ R).ne']
    exact Real.log_le_log (mul_pos hm₀ (pow_pos hx₀ R)) (hlow R)
  have hlogu : ∀ R : ℕ, Real.log (moment m x R) ≤ Real.log (∑ i, m i) + R * Real.log (x i₀) := by
    intro R
    rw [← Real.log_pow, ← Real.log_mul hsum.ne' (pow_pos hx₀ R).ne']
    exact Real.log_le_log (hpos R) (hup R)
  have h1 : Tendsto (fun R : ℕ => Real.log (m i₀) / R + Real.log (x i₀)) atTop
      (𝓝 (Real.log (x i₀))) := by
    have := (tendsto_const_div_atTop_nhds_zero_nat (Real.log (m i₀))).add
      (tendsto_const_nhds (x := Real.log (x i₀)))
    simpa using this
  have h2 : Tendsto (fun R : ℕ => Real.log (∑ i, m i) / R + Real.log (x i₀)) atTop
      (𝓝 (Real.log (x i₀))) := by
    have := (tendsto_const_div_atTop_nhds_zero_nat (Real.log (∑ i, m i))).add
      (tendsto_const_nhds (x := Real.log (x i₀)))
    simpa using this
  refine tendsto_of_tendsto_of_tendsto_of_le_of_le' h1 h2 ?_ ?_
  · filter_upwards [eventually_gt_atTop 0] with R hR
    have hR' : (0 : ℝ) < R := by exact_mod_cast hR
    have := hlogl R
    rw [div_add' _ _ _ hR'.ne']
    apply div_le_div_of_nonneg_right _ hR'.le
    linarith [this]
  · filter_upwards [eventually_gt_atTop 0] with R hR
    have hR' : (0 : ℝ) < R := by exact_mod_cast hR
    have := hlogu R
    rw [div_add' _ _ _ hR'.ne']
    apply div_le_div_of_nonneg_right _ hR'.le
    linarith [this]

end Moments

section Spectral

variable {n : Type*} [Fintype n] [DecidableEq n]

/-- the spectral decomposition of every power: A^R = U diag(λ^R) U* -/
theorem pow_spectral (A : Matrix n n ℝ) (hA : A.IsHermitian) (R : ℕ) :
    A ^ R = (hA.eigenvectorUnitary : Matrix n n ℝ) * diagonal (fun i => hA.eigenvalues i ^ R) *
      star (hA.eigenvectorUnitary : Matrix n n ℝ) := by
  set U : Matrix n n ℝ := (hA.eigenvectorUnitary : Matrix n n ℝ) with hU
  have hUU : U * star U = 1 := Unitary.coe_mul_star_self hA.eigenvectorUnitary
  have hUU' : star U * U = 1 := Unitary.coe_star_mul_self hA.eigenvectorUnitary
  have hspec : A = U * diagonal hA.eigenvalues * star U := by
    have h := hA.spectral_theorem
    rw [Unitary.conjStarAlgAut_apply] at h
    simpa [RCLike.ofReal_real_eq_id] using h
  induction R with
  | zero =>
    have h0 : diagonal (fun i => hA.eigenvalues i ^ 0) = (1 : Matrix n n ℝ) := by
      simp [diagonal_one]
    rw [pow_zero, h0, mul_one, hUU]
  | succ R ih =>
    calc A ^ (R + 1) = A ^ R * A := pow_succ A R
      _ = U * diagonal (fun i => hA.eigenvalues i ^ R) * star U *
            (U * diagonal hA.eigenvalues * star U) := by
          rw [ih]
          exact congrArg (fun M => U * diagonal (fun i => hA.eigenvalues i ^ R) * star U * M) hspec
      _ = U * (diagonal (fun i => hA.eigenvalues i ^ R) * (star U * U) * diagonal hA.eigenvalues) *
            star U := by
          simp only [mul_assoc]
      _ = U * diagonal (fun i => hA.eigenvalues i ^ (R + 1)) * star U := by
          rw [hUU', mul_one, diagonal_mul_diagonal]
          simp only [pow_succ]

/-- THE SPECTRAL REPRESENTATION: ⟨f, A^R f⟩ is a moment sequence on A's eigenvalues with nonnegative masses -/
theorem exists_moment (A : Matrix n n ℝ) (hA : A.IsHermitian) (f : n → ℝ) :
    ∃ m : n → ℝ, (∀ i, 0 ≤ m i) ∧ ∀ R : ℕ, f ⬝ᵥ ((A ^ R) *ᵥ f) = moment m hA.eigenvalues R := by
  set U : Matrix n n ℝ := (hA.eigenvectorUnitary : Matrix n n ℝ) with hU
  have hstar : star U = Uᵀ := by rw [star_eq_conjTranspose, conjTranspose_eq_transpose_of_trivial]
  have hw : star U *ᵥ f = f ᵥ* U := by rw [hstar, mulVec_transpose]
  refine ⟨fun i => (star U *ᵥ f) i * (star U *ᵥ f) i, fun i => mul_self_nonneg _, fun R => ?_⟩
  rw [pow_spectral A hA R, ← mulVec_mulVec, ← mulVec_mulVec, dotProduct_mulVec, ← hw]
  simp only [moment, dotProduct, mulVec_diagonal]
  apply Finset.sum_congr rfl
  intro i _
  ring

/-- THE WILSON LOOP IS NONNEGATIVE: for A positive semidefinite, ⟨f, A^R f⟩ ≥ 0 at every R -/
theorem wilson_nonneg (A : Matrix n n ℝ) (hA : A.PosSemidef) (f : n → ℝ) (R : ℕ) :
    0 ≤ f ⬝ᵥ ((A ^ R) *ᵥ f) := by
  obtain ⟨m, hm, hmom⟩ := exists_moment A hA.1 f
  rw [hmom]
  exact moment_nonneg m _ hm hA.eigenvalues_nonneg R

/-- THE WILSON LOOP IS LOG-CONVEX IN R: ⟨f, A^(R+1) f⟩² ≤ ⟨f, A^R f⟩ ⟨f, A^(R+2) f⟩ -/
theorem wilson_log_convex (A : Matrix n n ℝ) (hA : A.PosSemidef) (f : n → ℝ) (R : ℕ) :
    (f ⬝ᵥ ((A ^ (R + 1)) *ᵥ f)) ^ 2 ≤ (f ⬝ᵥ ((A ^ R) *ᵥ f)) * (f ⬝ᵥ ((A ^ (R + 2)) *ᵥ f)) := by
  obtain ⟨m, hm, hmom⟩ := exists_moment A hA.1 f
  rw [hmom, hmom, hmom]
  exact moment_sq_le m _ hm hA.eigenvalues_nonneg R

/-- THE WILSON LOOP IS NONINCREASING IN R once A's eigenvalues lie in [0, 1] -/
theorem wilson_succ_le (A : Matrix n n ℝ) (hA : A.PosSemidef) (hle : ∀ i, hA.1.eigenvalues i ≤ 1)
    (f : n → ℝ) (R : ℕ) : f ⬝ᵥ ((A ^ (R + 1)) *ᵥ f) ≤ f ⬝ᵥ ((A ^ R) *ᵥ f) := by
  obtain ⟨m, hm, hmom⟩ := exists_moment A hA.1 f
  rw [hmom, hmom]
  exact moment_succ_le m _ hm hA.eigenvalues_nonneg hle R

/-- THE STRING TENSION EXISTS, EVERY FINITE GROUP: for A positive semidefinite and ⟨f, A f⟩ > 0,
log ⟨f, A^R f⟩ / R converges to log x*, x* an eigenvalue of A -- the largest carrying mass -/
theorem string_tension_of_posSemidef (A : Matrix n n ℝ) (hA : A.PosSemidef) (f : n → ℝ)
    (hf : 0 < f ⬝ᵥ (A *ᵥ f)) :
    ∃ xs : ℝ, 0 < xs ∧ (∃ i, hA.1.eigenvalues i = xs) ∧
      Tendsto (fun R : ℕ => Real.log (f ⬝ᵥ ((A ^ R) *ᵥ f)) / R) atTop (𝓝 (Real.log xs)) := by
  obtain ⟨m, hm, hmom⟩ := exists_moment A hA.1 f
  have hx := hA.eigenvalues_nonneg
  have h1 : 0 < moment m hA.1.eigenvalues 1 := by
    rw [← hmom 1]
    simpa using hf
  have hex : ∃ i, 0 < m i ∧ 0 < hA.1.eigenvalues i := by
    by_contra hcon
    push_neg at hcon
    have : moment m hA.1.eigenvalues 1 = 0 := by
      unfold moment
      apply Finset.sum_eq_zero
      intro i _
      rcases (hm i).lt_or_eq with hmi | hmi
      · have := le_antisymm (hcon i hmi) (hx i)
        simp [this]
      · simp [← hmi]
    linarith
  obtain ⟨i₁, hm₁, hx₁⟩ := hex
  obtain ⟨i₀, hi₀, hmax⟩ := Finset.exists_max_image (Finset.univ.filter (fun i => 0 < m i))
    hA.1.eigenvalues ⟨i₁, Finset.mem_filter.mpr ⟨Finset.mem_univ _, hm₁⟩⟩
  have hm₀ : 0 < m i₀ := (Finset.mem_filter.mp hi₀).2
  have hx₀ : 0 < hA.1.eigenvalues i₀ :=
    lt_of_lt_of_le hx₁ (hmax i₁ (Finset.mem_filter.mpr ⟨Finset.mem_univ _, hm₁⟩))
  refine ⟨hA.1.eigenvalues i₀, hx₀, ⟨i₀, rfl⟩, ?_⟩
  have := log_moment_div_tendsto m hA.1.eigenvalues hm hx i₀ hm₀ hx₀
    (fun i hi => hmax i (Finset.mem_filter.mpr ⟨Finset.mem_univ _, hi⟩))
  refine this.congr fun R => ?_
  rw [hmom R]

/-- THE STRING TENSION IN THE TRANSFER MATRIX'S OWN TERMS: for M positive semidefinite and a T-line vector f with
⟨f, M f⟩ > 0, the loop W(R) = ⟨f, M^R f⟩ / λ₀^R has -log W(R) / R = log λ₀ - log ⟨f, M^R f⟩ / R → σ with
σ = log λ₀ - log x* ≥ 0, λ₀ the largest eigenvalue and x* the largest eigenvalue carrying mass -/
theorem string_tension_nonneg_of_transfer [Nonempty n] (M : Matrix n n ℝ) (hM : M.PosSemidef)
    (f : n → ℝ) (hf : 0 < f ⬝ᵥ (M *ᵥ f)) :
    ∃ σ : ℝ, 0 ≤ σ ∧ Tendsto (fun R : ℕ => Real.log (lamMax M hM.1) -
      Real.log (f ⬝ᵥ ((M ^ R) *ᵥ f)) / R) atTop (𝓝 σ) := by
  obtain ⟨xs, hxs, ⟨i₀, hi₀⟩, hlim⟩ := string_tension_of_posSemidef M hM f hf
  have hle : xs ≤ lamMax M hM.1 := by
    rw [← hi₀]
    exact eigenvalues_le_lamMax M hM.1 i₀
  refine ⟨Real.log (lamMax M hM.1) - Real.log xs, sub_nonneg.mpr (Real.log_le_log hxs hle), ?_⟩
  exact tendsto_const_nhds.sub hlim

end Spectral

end Aperanton
