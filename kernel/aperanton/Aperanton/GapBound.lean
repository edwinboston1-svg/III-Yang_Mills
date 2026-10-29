/-
  APERANTON -- THE BOUNDLESS, stage A8c: THE STATIC POTENTIAL IS AT LEAST THE GAP.

  THE QUANTITY, NAMED EXACTLY (corrected 2026-10-27 12:10 by date, before this file's second landing): lim_R −log W(R, T)/R at
  FIXED T -- called the string tension σ(T) below and in Spectral.lean -- is the STATIC POTENTIAL E(T) of the T-line's
  sector above the vacuum; the bounds here are on E(T), in every phase.  The area law E(T) ≥ σ∞ T with σ∞ > 0, the
  string tension proper, is not proved here and not claimed.

  Spectral.lean reads the string tension off the moment sequence W(R) = ⟨f, M^R f⟩: σ = log λ₀ − log x*, x* the
  largest eigenvalue carrying mass.  The mass at the Perron index is ⟨Ω, f⟩², Ω the unit Perron vector (named here,
  `exists_moment_perron`).  When f is orthogonal to the Perron line that mass is zero, so x* is a NON-Perron eigenvalue
  and σ = log λ₀ − log λ_k > 0 by Perron's strict dominance (`string_tension_gap`): THE STRING TENSION IS BOUNDED BELOW
  BY THE FINITE-VOLUME MASS GAP OF ITS SECTOR, MassGap.lean's quantity.  The orthogonality is bought by a symmetry: a
  permutation of the configurations fixing M fixes the Perron line (Perron.lean's `perron_symmetric`), so an
  observable ODD under it has Σ_c Ω(c)² F(c) = 0 (`perron_dot_odd`); for the T-line of a Wilson loop the symmetry is
  the gauge transformation at one endpoint, which flips exactly one link of the line.  THE Z₂ INSTANCE WITH NO
  HYPOTHESIS LEFT (`string_tension_z2`): on any finite cross-section, at any 0 < y < 1, for any positive in-plane
  weight D invariant under the flip of a link set S and any ±1 observable odd under it, the slab's two-point function
  converges to ⟨F Ω, M^R F Ω⟩ / λ₀^R and −log W(R)/R converges to a σ > 0 that is a gap log λ₀ − log λ_k -- the
  positivity W(1) > 0 is discharged by the invertibility of the Z₂ link kernel (det = 4y), lifted to the tensor kernel
  (`tensorKernel_mul`, `tensorKernel_one`) and to the transfer matrix.  No sorry, no axiom.
-/
import Mathlib
import Aperanton.Perron
import Aperanton.Spectral
import Aperanton.XTransfer

open Matrix Filter Topology

namespace Aperanton

section PerronMass

variable {n : Type*} [Fintype n] [DecidableEq n]

/-- THE MOMENT SEQUENCE WITH ITS PERRON MASS NAMED: for M symmetric and entrywise positive, ⟨f, M^R f⟩ is a moment
sequence on M's eigenvalues whose mass at the Perron index i₀ is ⟨Ω, f⟩², Ω the unit Perron vector -/
theorem exists_moment_perron [Nonempty n] (M : Matrix n n ℝ) (hM : M.IsHermitian) (hpos : ∀ i j, 0 < M i j)
    (f : n → ℝ) :
    ∃ (m : n → ℝ) (i₀ : n) (Ω : n → ℝ), (∀ i, 0 ≤ m i) ∧ hM.eigenvalues i₀ = lamMax M hM ∧
      (∀ R : ℕ, f ⬝ᵥ ((M ^ R) *ᵥ f) = moment m hM.eigenvalues R) ∧
      M *ᵥ Ω = lamMax M hM • Ω ∧ (∀ i, Ω i ≠ 0) ∧ m i₀ = (Ω ⬝ᵥ f) ^ 2 := by
  obtain ⟨i₀, -, hi₀⟩ := Finset.exists_mem_eq_sup' Finset.univ_nonempty hM.eigenvalues
  have hl : hM.eigenvalues i₀ = lamMax M hM := hi₀.symm
  set U : Matrix n n ℝ := (hM.eigenvectorUnitary : Matrix n n ℝ) with hU
  have hstar : star U = Uᵀ := by rw [star_eq_conjTranspose, conjTranspose_eq_transpose_of_trivial]
  have hUU' : star U * U = 1 := Unitary.coe_star_mul_self hM.eigenvectorUnitary
  have hw : star U *ᵥ f = f ᵥ* U := by rw [hstar, mulVec_transpose]
  set Ω : n → ℝ := fun i => U i i₀ with hΩ
  have hcol : ⇑(hM.eigenvectorBasis i₀) = Ω := by
    funext i
    simp [hΩ, hU, Matrix.IsHermitian.eigenvectorUnitary_apply]
  have hΩeig : M *ᵥ Ω = lamMax M hM • Ω := by
    have h := hM.mulVec_eigenvectorBasis i₀
    rw [hl, hcol] at h
    exact h
  have hnorm : Ω ⬝ᵥ Ω = 1 := by
    have h := congrFun (congrFun hUU' i₀) i₀
    simp only [mul_apply, hstar, transpose_apply, one_apply_eq] at h
    simpa [dotProduct, hΩ] using h
  have hΩ0 : Ω ≠ 0 := by
    intro h
    rw [h, zero_dotProduct] at hnorm
    exact zero_ne_one hnorm
  have hne : ∀ i, Ω i ≠ 0 := by
    obtain ⟨p, hppos, hp, -⟩ := perron_exists M hM hpos
    obtain ⟨c, hc⟩ := perron_simple M hM hpos p hppos hp Ω hΩeig
    have hc0 : c ≠ 0 := by
      intro h0
      apply hΩ0
      rw [hc, h0, zero_smul]
    intro i
    rw [hc]
    simp only [Pi.smul_apply, smul_eq_mul]
    exact mul_ne_zero hc0 (ne_of_gt (hppos i))
  refine ⟨fun i => (star U *ᵥ f) i * (star U *ᵥ f) i, i₀, Ω, fun i => mul_self_nonneg _, hl, fun R => ?_,
    hΩeig, hne, ?_⟩
  · rw [pow_spectral M hM R, ← mulVec_mulVec, ← mulVec_mulVec, dotProduct_mulVec, ← hw]
    simp only [moment, dotProduct, mulVec_diagonal]
    apply Finset.sum_congr rfl
    intro i _
    ring
  · have : (star U *ᵥ f) i₀ = Ω ⬝ᵥ f := by
      simp [mulVec, dotProduct, hstar, hΩ]
    show (star U *ᵥ f) i₀ * (star U *ᵥ f) i₀ = (Ω ⬝ᵥ f) ^ 2
    rw [this, sq]

/-- THE STRING TENSION IS A GAP: for M symmetric, entrywise positive and positive semidefinite, and f orthogonal to
the Perron line with ⟨f, M f⟩ > 0, the string tension is log λ₀ − log λ_k for a NON-Perron eigenvalue λ_k > 0, hence
strictly positive -- bounded below by the finite-volume mass gap of f's sector -/
theorem string_tension_gap [Nonempty n] (M : Matrix n n ℝ) (hM : M.PosSemidef) (hpos : ∀ i j, 0 < M i j)
    (f : n → ℝ) (hf : 0 < f ⬝ᵥ (M *ᵥ f))
    (horth : ∀ Ω : n → ℝ, M *ᵥ Ω = lamMax M hM.1 • Ω → Ω ⬝ᵥ f = 0) :
    ∃ σ : ℝ, 0 < σ ∧ (∃ k, hM.1.eigenvalues k ≠ lamMax M hM.1 ∧ 0 < hM.1.eigenvalues k ∧
      σ = Real.log (lamMax M hM.1) - Real.log (hM.1.eigenvalues k)) ∧
      Tendsto (fun R : ℕ => Real.log (lamMax M hM.1) - Real.log (f ⬝ᵥ ((M ^ R) *ᵥ f)) / R) atTop (𝓝 σ) := by
  obtain ⟨m, i₀, Ω, hm, hl, hmom, hΩeig, -, hmi₀⟩ := exists_moment_perron M hM.1 hpos f
  have hx := hM.eigenvalues_nonneg
  have hm0 : m i₀ = 0 := by
    rw [hmi₀, horth Ω hΩeig]
    ring
  have h1 : 0 < moment m hM.1.eigenvalues 1 := by
    rw [← hmom 1]
    simpa using hf
  have hex : ∃ i, 0 < m i ∧ 0 < hM.1.eigenvalues i := by
    by_contra hcon
    push_neg at hcon
    have : moment m hM.1.eigenvalues 1 = 0 := by
      unfold moment
      apply Finset.sum_eq_zero
      intro i _
      rcases (hm i).lt_or_eq with hmi | hmi
      · have := le_antisymm (hcon i hmi) (hx i)
        simp [this]
      · simp [← hmi]
    linarith
  obtain ⟨i₁, hm₁, hx₁⟩ := hex
  obtain ⟨k, hk, hmax⟩ := Finset.exists_max_image (Finset.univ.filter (fun i => 0 < m i))
    hM.1.eigenvalues ⟨i₁, Finset.mem_filter.mpr ⟨Finset.mem_univ _, hm₁⟩⟩
  have hmk : 0 < m k := (Finset.mem_filter.mp hk).2
  have hxk : 0 < hM.1.eigenvalues k :=
    lt_of_lt_of_le hx₁ (hmax i₁ (Finset.mem_filter.mpr ⟨Finset.mem_univ _, hm₁⟩))
  have hki₀ : k ≠ i₀ := by
    intro h
    rw [h, hm0] at hmk
    exact lt_irrefl 0 hmk
  have hkl : hM.1.eigenvalues k ≠ lamMax M hM.1 := fun h =>
    hki₀ (perron_index_unique M hM.1 hpos k i₀ h hl)
  have hlt : hM.1.eigenvalues k < lamMax M hM.1 := by
    have := abs_eigenvalue_lt M hM.1 hpos k hkl
    rwa [abs_of_pos hxk] at this
  refine ⟨Real.log (lamMax M hM.1) - Real.log (hM.1.eigenvalues k),
    sub_pos.mpr (Real.log_lt_log hxk hlt), ⟨k, hkl, hxk, rfl⟩, ?_⟩
  have hlim := log_moment_div_tendsto m hM.1.eigenvalues hm hx k hmk hxk
    (fun i hi => hmax i (Finset.mem_filter.mpr ⟨Finset.mem_univ _, hi⟩))
  have h2 : Tendsto (fun R : ℕ => Real.log (f ⬝ᵥ ((M ^ R) *ᵥ f)) / R) atTop
      (𝓝 (Real.log (hM.1.eigenvalues k))) := hlim.congr fun R => by rw [hmom R]
  exact tendsto_const_nhds.sub h2

end PerronMass

section Odd

variable {n : Type*} [Fintype n] [DecidableEq n]

/-- the permutation matrix of σ: (P v)(a) = v (σ a) -/
def permMat (σ : Equiv.Perm n) : Matrix n n ℝ := fun a b => if b = σ a then 1 else 0

theorem permMat_mulVec (σ : Equiv.Perm n) (v : n → ℝ) : permMat σ *ᵥ v = fun a => v (σ a) := by
  funext a
  simp [permMat, mulVec, dotProduct]

theorem permMat_nonneg (σ : Equiv.Perm n) (a b : n) : 0 ≤ permMat σ a b := by
  unfold permMat
  split_ifs <;> norm_num

theorem permMat_orth (σ : Equiv.Perm n) : (permMat σ)ᵀ * permMat σ = 1 := by
  ext a b
  simp only [mul_apply, transpose_apply, permMat, one_apply]
  rw [Finset.sum_eq_single (σ.symm a)]
  · rw [Equiv.apply_symm_apply, if_pos rfl, one_mul]
    by_cases h : a = b
    · subst h
      simp
    · rw [if_neg (Ne.symm h), if_neg h]
  · intro c _ hc
    have : a ≠ σ c := fun h => hc (by rw [h, Equiv.symm_apply_apply])
    rw [if_neg this, zero_mul]
  · intro h
    exact absurd (Finset.mem_univ _) h

/-- a permutation under which M is invariant commutes with M -/
theorem permMat_comm (σ : Equiv.Perm n) (M : Matrix n n ℝ) (hinv : ∀ a b, M (σ a) (σ b) = M a b) :
    permMat σ * M = M * permMat σ := by
  ext a b
  simp only [mul_apply, permMat]
  rw [Finset.sum_eq_single (σ a), Finset.sum_eq_single (σ.symm b)]
  · rw [if_pos rfl, one_mul, Equiv.apply_symm_apply, if_pos rfl, mul_one]
    conv_lhs => rw [← Equiv.apply_symm_apply σ b]
    exact hinv a (σ.symm b)
  · intro c _ hc
    have : b ≠ σ c := fun h => hc (by rw [h, Equiv.symm_apply_apply])
    rw [if_neg this, mul_zero]
  · intro h
    exact absurd (Finset.mem_univ _) h
  · intro c _ hc
    rw [if_neg hc, zero_mul]
  · intro h
    exact absurd (Finset.mem_univ _) h

/-- THE PERRON MASS OF AN ODD OBSERVABLE VANISHES: a permutation of the configurations fixing M fixes the Perron line,
so for two Perron eigenvectors Ω₁, Ω₂ and an observable F odd under the permutation, Σ_c Ω₁(c) F(c) Ω₂(c) = 0 -/
theorem perron_dot_odd [Nonempty n] (M : Matrix n n ℝ) (hM : M.IsHermitian) (hpos : ∀ i j, 0 < M i j)
    (σ : Equiv.Perm n) (hinv : ∀ a b, M (σ a) (σ b) = M a b) (F : n → ℝ) (hodd : ∀ a, F (σ a) = -F a)
    (Ω₁ Ω₂ : n → ℝ) (h₁ : M *ᵥ Ω₁ = lamMax M hM • Ω₁) (h₂ : M *ᵥ Ω₂ = lamMax M hM • Ω₂) :
    Ω₁ ⬝ᵥ (diagonal F *ᵥ Ω₂) = 0 := by
  obtain ⟨a, hapos, ha, -⟩ := perron_exists M hM hpos
  obtain ⟨c₁, hc₁⟩ := perron_simple M hM hpos a hapos ha Ω₁ h₁
  obtain ⟨c₂, hc₂⟩ := perron_simple M hM hpos a hapos ha Ω₂ h₂
  have hPa : permMat σ *ᵥ a = a :=
    perron_symmetric M hM hpos a hapos ha (permMat σ) (permMat_comm σ M hinv) (permMat_nonneg σ)
      (permMat_orth σ)
  have hfix : ∀ x, a (σ x) = a x := by
    intro x
    have := congrFun hPa x
    rw [permMat_mulVec] at this
    exact this
  have hsum : ∑ x, F x * (a x * a x) = 0 := by
    have h := Equiv.sum_comp σ (fun x => F x * (a x * a x))
    simp only [hodd, hfix] at h
    have : ∑ x, -F x * (a x * a x) = -∑ x, F x * (a x * a x) := by
      rw [← Finset.sum_neg_distrib]
      apply Finset.sum_congr rfl
      intro x _
      ring
    linarith
  rw [hc₁, hc₂]
  have hterm : ∀ x, (c₁ • a) x * (diagonal F *ᵥ (c₂ • a)) x = c₁ * c₂ * (F x * (a x * a x)) := by
    intro x
    rw [mulVec_diagonal]
    simp only [Pi.smul_apply, smul_eq_mul]
    ring
  unfold dotProduct
  simp only [hterm]
  rw [← Finset.mul_sum, hsum, mul_zero]

end Odd

section Invertible

variable {G : Type*} [Fintype G] [DecidableEq G] {L : Type*} [Fintype L] [DecidableEq L]

/-- the tensor kernel is multiplicative: K(k) K(k') = K(k k') -/
theorem tensorKernel_mul (k k' : Matrix G G ℝ) :
    (tensorKernel k : Matrix (L → G) (L → G) ℝ) * tensorKernel k' = tensorKernel (k * k') := by
  ext c c''
  simp only [mul_apply, tensorKernel]
  rw [Fintype.prod_sum]
  apply Finset.sum_congr rfl
  intro c' _
  rw [Finset.prod_mul_distrib]

/-- the tensor kernel of the identity is the identity -/
theorem tensorKernel_one : (tensorKernel (1 : Matrix G G ℝ) : Matrix (L → G) (L → G) ℝ) = 1 := by
  ext c c'
  simp only [tensorKernel, one_apply]
  by_cases h : c = c'
  · subst h
    simp
  · rw [if_neg h]
    obtain ⟨ℓ, hℓ⟩ : ∃ ℓ, c ℓ ≠ c' ℓ := by
      by_contra hcon
      push_neg at hcon
      exact h (funext hcon)
    exact Finset.prod_eq_zero (Finset.mem_univ ℓ) (by rw [if_neg hℓ])

/-- a left-invertible single-link kernel makes the tensor kernel injective -/
theorem tensorKernel_mulVec_eq_zero (k k' : Matrix G G ℝ) (hk : k' * k = 1) (v : (L → G) → ℝ)
    (h : (tensorKernel k : Matrix (L → G) (L → G) ℝ) *ᵥ v = 0) : v = 0 := by
  have : (tensorKernel k' : Matrix (L → G) (L → G) ℝ) *ᵥ (tensorKernel k *ᵥ v) = v := by
    rw [mulVec_mulVec, tensorKernel_mul, hk, tensorKernel_one, one_mulVec]
  rw [h, mulVec_zero] at this
  exact this.symm

end Invertible

section Transfer

variable {n : Type*} [Fintype n] [DecidableEq n]

/-- an injective kernel makes the transfer matrix injective -/
theorem transfer_mulVec_eq_zero (D : n → ℝ) (hD : ∀ c, 0 < D c) (K : Matrix n n ℝ)
    (hKinj : ∀ v, K *ᵥ v = 0 → v = 0) (v : n → ℝ) (h : transfer D K *ᵥ v = 0) : v = 0 := by
  have hsq : ∀ c, Real.sqrt (D c) ≠ 0 := fun c => (Real.sqrt_pos.mpr (hD c)).ne'
  have hdiag0 : ∀ w : n → ℝ, diagonal (fun c => Real.sqrt (D c)) *ᵥ w = 0 → w = 0 := by
    intro w hw
    funext c
    have := congrFun hw c
    rw [mulVec_diagonal, Pi.zero_apply] at this
    exact (mul_eq_zero.mp this).resolve_left (hsq c)
  have h1 : diagonal (fun c => Real.sqrt (D c)) *ᵥ
      (K *ᵥ (diagonal (fun c => Real.sqrt (D c)) *ᵥ v)) = 0 := by
    rw [mulVec_mulVec, mulVec_mulVec]
    exact h
  exact hdiag0 v (hKinj _ (hdiag0 _ h1))

/-- THE QUADRATIC FORM OF THE TRANSFER MATRIX IS POSITIVE on every nonzero vector when the kernel is positive
semidefinite and injective -/
theorem dot_transfer_pos (D : n → ℝ) (hD : ∀ c, 0 < D c) (K : Matrix n n ℝ) (hK : K.PosSemidef)
    (hKinj : ∀ v, K *ᵥ v = 0 → v = 0) (v : n → ℝ) (hv : v ≠ 0) : 0 < v ⬝ᵥ (transfer D K *ᵥ v) := by
  have hM := transfer_posSemidef D K hK
  have hnn : 0 ≤ v ⬝ᵥ (transfer D K *ᵥ v) := by simpa using hM.dotProduct_mulVec_nonneg v
  rcases hnn.lt_or_eq with h | h
  · exact h
  · exfalso
    have h0 : star v ⬝ᵥ (transfer D K *ᵥ v) = 0 := by simpa using h.symm
    exact hv (transfer_mulVec_eq_zero D hD K hKinj v (hM.dotProduct_mulVec_zero_iff.mp h0))

end Transfer

section Z2Gap

variable {L : Type*} [Fintype L] [DecidableEq L]

/-- the Z₂ link kernel's inverse at y > 0: (1 / 4y) (y + s(a) s(b)) -/
noncomputable def z2kInv (y : ℝ) : Matrix Bool Bool ℝ :=
  fun a b => (1 / (4 * y)) * (y + (if a then -1 else 1) * (if b then -1 else 1))

theorem z2kInv_mul (y : ℝ) (hy : 0 < y) : z2kInv y * z2k y = 1 := by
  ext a c
  simp only [mul_apply, z2kInv, z2k, one_apply, Fintype.sum_bool]
  have h4 : (4 * y) ≠ 0 := by positivity
  cases a <;> cases c <;> simp <;> field_simp <;> ring

/-- the flip of the links in S (a gauge transformation at a vertex whose links are S) -/
def flipS (S : Finset L) : (L → Bool) → (L → Bool) := fun c ℓ => if ℓ ∈ S then !(c ℓ) else c ℓ

theorem flipS_involutive (S : Finset L) : Function.Involutive (flipS S) := by
  intro c
  funext ℓ
  simp only [flipS]
  split_ifs <;> simp

/-- the flip as a permutation of the configurations -/
def flipPerm (S : Finset L) : Equiv.Perm (L → Bool) := (flipS_involutive S).toPerm

theorem flipPerm_apply (S : Finset L) (c : L → Bool) : flipPerm S c = flipS S c := rfl

/-- the Z₂ link kernel is invariant under a simultaneous flip of both arguments -/
theorem z2k_not_not (y : ℝ) (a b : Bool) : z2k y (!a) (!b) = z2k y a b := by
  cases a <;> cases b <;> simp [z2k]

/-- the tensor kernel of the Z₂ link kernel is invariant under the flip -/
theorem tensorKernel_z2k_flip (y : ℝ) (S : Finset L) (a b : L → Bool) :
    tensorKernel (z2k y) (flipS S a) (flipS S b) = tensorKernel (z2k y) a b := by
  simp only [tensorKernel, flipS]
  apply Finset.prod_congr rfl
  intro ℓ _
  split_ifs
  · exact z2k_not_not y _ _
  · rfl

/-- THE Z₂ INSTANCE WITH NO HYPOTHESIS LEFT: on any finite cross-section L, at any 0 < y < 1, for any positive
in-plane weight D invariant under the flip of a link set S and any ±1 observable F odd under that flip (the T-line of
a Wilson loop, S the links at one of its endpoints), the slab's two-point function of F converges to
W(R) = ⟨F Ω, M^R F Ω⟩ / λ₀^R at every R, and −log W(R)/R converges to a σ > 0 that is a gap: log λ₀ − log λ_k for a
non-Perron eigenvalue λ_k of the transfer matrix -/
theorem string_tension_z2 (y : ℝ) (hy0 : 0 < y) (hy1 : y < 1) (D : (L → Bool) → ℝ) (hD : ∀ c, 0 < D c)
    (S : Finset L) (hDS : ∀ c, D (flipS S c) = D c) (F : (L → Bool) → ℝ) (hF : ∀ c, F c = 1 ∨ F c = -1)
    (hodd : ∀ c, F (flipS S c) = -F c) :
    ∃ Ω : (L → Bool) → ℝ, Ω ⬝ᵥ Ω = 1 ∧ (∀ i, Ω i ≠ 0) ∧
      (∀ R : ℕ, Tendsto (fun a : ℕ => slabNum D (tensorKernel (z2k y)) F (a + 1) R /
          slabZ D (tensorKernel (z2k y)) (a + 1) R) atTop
        (𝓝 ((diagonal F *ᵥ Ω) ⬝ᵥ (transfer D (tensorKernel (z2k y)) ^ R *ᵥ (diagonal F *ᵥ Ω)) /
          lamMax (transfer D (tensorKernel (z2k y)))
            (transfer_posSemidef D _ (tensorKernel_posSemidef _ (z2k_posSemidef y hy0.le))).1 ^ R))) ∧
      ∃ σ : ℝ, 0 < σ ∧
        (∃ k, (transfer_posSemidef D _ (tensorKernel_posSemidef _ (z2k_posSemidef y hy0.le))).1.eigenvalues k ≠
            lamMax (transfer D (tensorKernel (z2k y)))
              (transfer_posSemidef D _ (tensorKernel_posSemidef _ (z2k_posSemidef y hy0.le))).1 ∧
          0 < (transfer_posSemidef D _ (tensorKernel_posSemidef _ (z2k_posSemidef y hy0.le))).1.eigenvalues k ∧
          σ = Real.log (lamMax (transfer D (tensorKernel (z2k y)))
              (transfer_posSemidef D _ (tensorKernel_posSemidef _ (z2k_posSemidef y hy0.le))).1) -
            Real.log ((transfer_posSemidef D _ (tensorKernel_posSemidef _ (z2k_posSemidef y hy0.le))).1.eigenvalues k)) ∧
        Tendsto (fun R : ℕ => Real.log (lamMax (transfer D (tensorKernel (z2k y)))
            (transfer_posSemidef D _ (tensorKernel_posSemidef _ (z2k_posSemidef y hy0.le))).1) -
          Real.log ((diagonal F *ᵥ Ω) ⬝ᵥ (transfer D (tensorKernel (z2k y)) ^ R *ᵥ (diagonal F *ᵥ Ω))) / R)
          atTop (𝓝 σ) := by
  set K : Matrix (L → Bool) (L → Bool) ℝ := tensorKernel (z2k y) with hKdef
  have hK : K.PosSemidef := tensorKernel_posSemidef _ (z2k_posSemidef y hy0.le)
  have hKpos : ∀ c c', 0 < K c c' := tensorKernel_pos _ (z2k_pos y hy0.le hy1)
  set M : Matrix (L → Bool) (L → Bool) ℝ := transfer D K with hMdef
  have hM : M.PosSemidef := transfer_posSemidef D K hK
  have hpos : ∀ i j, 0 < M i j := transfer_pos D hD K hKpos
  obtain ⟨Ω, hnorm, hΩeig, hne, hlim⟩ := slab_tendsto D hD K hK hKpos F
  refine ⟨Ω, hnorm, hne, hlim, ?_⟩
  -- the injectivity of K, hence W(1) > 0
  have hKinj : ∀ v, K *ᵥ v = 0 → v = 0 := fun v hv =>
    tensorKernel_mulVec_eq_zero (z2k y) (z2kInv y) (z2kInv_mul y hy0) v hv
  have hf0 : diagonal F *ᵥ Ω ≠ 0 := by
    intro h
    have hc := congrFun h (Classical.arbitrary _)
    rw [mulVec_diagonal, Pi.zero_apply] at hc
    rcases mul_eq_zero.mp hc with h1 | h1
    · rcases hF (Classical.arbitrary _) with h2 | h2 <;> rw [h2] at h1 <;> norm_num at h1
    · exact hne _ h1
  have hf : 0 < (diagonal F *ᵥ Ω) ⬝ᵥ (M *ᵥ (diagonal F *ᵥ Ω)) := dot_transfer_pos D hD K hK hKinj _ hf0
  -- M is invariant under the flip and F is odd, so the Perron mass of F Ω vanishes
  have hinv : ∀ a b, M (flipPerm S a) (flipPerm S b) = M a b := by
    intro a b
    simp only [flipPerm_apply, hMdef, transfer_apply, hDS, hKdef, tensorKernel_z2k_flip]
  have horth : ∀ Ω' : (L → Bool) → ℝ, M *ᵥ Ω' = lamMax M hM.1 • Ω' → Ω' ⬝ᵥ (diagonal F *ᵥ Ω) = 0 := by
    intro Ω' hΩ'
    exact perron_dot_odd M hM.1 hpos (flipPerm S) hinv F (fun a => hodd a) Ω' Ω hΩ' hΩeig
  exact string_tension_gap M hM hpos _ hf horth

end Z2Gap

end Aperanton
