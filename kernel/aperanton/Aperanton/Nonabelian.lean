/-
  APERANTON -- THE BOUNDLESS, stage A8d: THE NONABELIAN WILSON LOOP'S STATIC POTENTIAL IS AT LEAST THE GAP.

  THE QUANTITY, NAMED EXACTLY.  The limit lim_R −log W(R, T)/R at FIXED T -- what the earlier files call the string
  tension σ(T) -- is the STATIC POTENTIAL E(T) of the T-line's sector above the vacuum.  Every bound here is on E(T):
  E(T) ≥ the window's gap in that sector, in every phase.  The area law -- E(T) ≥ σ∞ T, σ∞ > 0, the string tension
  proper -- is NOT proved here and is not claimed; it is Α9's question with the uniform gap.

  GapBound.lean bought the gap for an observable ODD under one symmetry.  A nonabelian character is not odd under
  one gauge transformation but AVERAGES TO ZERO over the endpoint's group: with the Gram factorisation
  χ(a b⁻¹) = Σ_j φ_j(a) φ_j(b) of the positive semidefinite class matrix X of a REAL class function χ (a real
  character, or the real part of one), every Gram vector φ_j of a χ that kills the constants (Σ_b χ(b) = 0: a
  nontrivial one) has Σ_a φ_j(a) = 0 (`exists_gram_sum_zero`: the
  constants lie in X's kernel and the Gram vectors are eigenvectors of nonzero eigenvalue, orthogonal to them), so
  F_j = φ_j ∘ h for the T-line's holonomy h has Σ_g F_j(σ_g c) = Σ_a φ_j(a) = 0 under the gauge transformations σ_g
  at one endpoint (h(σ_g c) = g · h(c)).  A family of M-invariant permutations fixes the Perron line, so an observable
  whose family-average vanishes has zero Perron mass (`perron_dot_avg`), term by term; the loop's two-point function
  W(R) = Σ_j ⟨F_j Ω, M^R F_j Ω⟩ is a sum of moment sequences with no Perron mass, and its static potential is
  E = log λ₀ − log λ_k for a non-Perron λ_k > 0 (`potential_gap_family`): STRICTLY POSITIVE, at least the
  finite-volume mass gap of the loop's sector (`nonabelian_potential_gap`).  On the slab: the loop's Gibbs sum
  with the pair weight P(c_a, c_{a+R}) = χ(h(c_a) h(c_{a+R})⁻¹) is Σ_j of the two-point sums of F_j
  (`pathSumPair_eq_sum`), each converging to ⟨F_j Ω, M^R F_j Ω⟩ / λ₀^R with ONE unit Perron vector Ω
  (`slab_tendsto'`, the sign of Ω immaterial), so the nonabelian Wilson loop of the x-transfer model converges to
  the moment sequence whose static potential is at least the gap (`nonabelian_slab_potential_gap`).  The hypotheses
  stated at their strength: X positive semidefinite (for a real character the Gram matrix of a unitary
  representation's matrix coefficients; for the real part of a complex one, of the coefficients and their conjugates),
  X 1 = 0 (nontrivial), the endpoint action (M-invariant, equivariant on h), W(1) > 0 (the transfer matrix
  injective and some F_j Ω ≠ 0).  No sorry, no axiom.
-/
import Mathlib
import Aperanton.Perron
import Aperanton.Spectral
import Aperanton.XTransfer
import Aperanton.GapBound

open Matrix Filter Topology

namespace Aperanton

section Averaged

variable {n : Type*} [Fintype n] [DecidableEq n]

/-- THE PERRON MASS OF AN OBSERVABLE WHOSE FAMILY-AVERAGE VANISHES IS ZERO: a finite family of permutations fixing M
fixes the Perron line, and an observable with Σ_g F(σ_g c) = 0 at every c has Σ_c Ω₁(c) F(c) Ω₂(c) = 0 for any two
Perron eigenvectors -/
theorem perron_dot_avg [Nonempty n] {ι : Type*} [Fintype ι] [Nonempty ι] (M : Matrix n n ℝ)
    (hM : M.IsHermitian) (hpos : ∀ i j, 0 < M i j) (σ : ι → Equiv.Perm n)
    (hinv : ∀ g a b, M (σ g a) (σ g b) = M a b) (F : n → ℝ) (havg : ∀ c, ∑ g, F (σ g c) = 0)
    (Ω₁ Ω₂ : n → ℝ) (h₁ : M *ᵥ Ω₁ = lamMax M hM • Ω₁) (h₂ : M *ᵥ Ω₂ = lamMax M hM • Ω₂) :
    Ω₁ ⬝ᵥ (diagonal F *ᵥ Ω₂) = 0 := by
  obtain ⟨a, hapos, ha, -⟩ := perron_exists M hM hpos
  obtain ⟨c₁, hc₁⟩ := perron_simple M hM hpos a hapos ha Ω₁ h₁
  obtain ⟨c₂, hc₂⟩ := perron_simple M hM hpos a hapos ha Ω₂ h₂
  have hfix : ∀ g x, a (σ g x) = a x := by
    intro g x
    have hPa : permMat (σ g) *ᵥ a = a :=
      perron_symmetric M hM hpos a hapos ha (permMat (σ g)) (permMat_comm (σ g) M (hinv g))
        (permMat_nonneg (σ g)) (permMat_orth (σ g))
    have := congrFun hPa x
    rw [permMat_mulVec] at this
    exact this
  have hsum : ∑ x, F x * (a x * a x) = 0 := by
    have hg : ∀ g : ι, ∑ x, F x * (a x * a x) = ∑ x, F (σ g x) * (a x * a x) := by
      intro g
      rw [← Equiv.sum_comp (σ g) (fun x => F x * (a x * a x))]
      apply Finset.sum_congr rfl
      intro x _
      rw [hfix g x]
    have htot : (Fintype.card ι : ℝ) * ∑ x, F x * (a x * a x) =
        ∑ g : ι, ∑ x, F (σ g x) * (a x * a x) := by
      rw [Finset.sum_congr rfl (fun g _ => (hg g).symm), Finset.sum_const, Finset.card_univ, nsmul_eq_mul]
    rw [Finset.sum_comm] at htot
    have hz : ∑ x, ∑ g : ι, F (σ g x) * (a x * a x) = 0 := by
      apply Finset.sum_eq_zero
      intro x _
      rw [← Finset.sum_mul, havg x, zero_mul]
    rw [hz] at htot
    have hcard : (Fintype.card ι : ℝ) ≠ 0 := by
      have := Fintype.card_pos (α := ι)
      positivity
    exact (mul_eq_zero.mp htot).resolve_left hcard
  rw [hc₁, hc₂]
  have hterm : ∀ x, (c₁ • a) x * (diagonal F *ᵥ (c₂ • a)) x = c₁ * c₂ * (F x * (a x * a x)) := by
    intro x
    rw [mulVec_diagonal]
    simp only [Pi.smul_apply, smul_eq_mul]
    ring
  unfold dotProduct
  simp only [hterm]
  rw [← Finset.mul_sum, hsum, mul_zero]

/-- the Gram vectors of a positive semidefinite X that kills the constants have zero sum: the constants lie in
X's kernel, and an eigenvector of nonzero eigenvalue is orthogonal to the kernel -/
theorem exists_gram_sum_zero (X : Matrix n n ℝ) (hX : X.PosSemidef) (h1 : X *ᵥ (fun _ => (1 : ℝ)) = 0) :
    ∃ φ : n → n → ℝ, (∀ a b, X a b = ∑ j, φ j a * φ j b) ∧ ∀ j, ∑ a, φ j a = 0 := by
  set U : Matrix n n ℝ := (hX.1.eigenvectorUnitary : Matrix n n ℝ) with hU
  have hspec : X = U * diagonal hX.1.eigenvalues * star U := by
    have h := hX.1.spectral_theorem
    rw [Unitary.conjStarAlgAut_apply] at h
    simpa [RCLike.ofReal_real_eq_id] using h
  have hstar : star U = Uᵀ := by rw [star_eq_conjTranspose, conjTranspose_eq_transpose_of_trivial]
  have hXt : Xᵀ = X := by
    have h := hX.1.eq
    rwa [conjTranspose_eq_transpose_of_trivial] at h
  have hsq : ∀ j, Real.sqrt (hX.1.eigenvalues j) * Real.sqrt (hX.1.eigenvalues j) =
      hX.1.eigenvalues j := fun j => Real.mul_self_sqrt (hX.eigenvalues_nonneg j)
  refine ⟨fun j a => Real.sqrt (hX.1.eigenvalues j) * U a j, fun a b => ?_, fun j => ?_⟩
  · conv_lhs => rw [hspec]
    simp only [mul_apply, diagonal_apply, hstar, transpose_apply, Finset.sum_mul]
    rw [Finset.sum_comm]
    apply Finset.sum_congr rfl
    intro j _
    rw [Finset.sum_eq_single j]
    · rw [if_pos rfl]
      have hrhs : (Real.sqrt (hX.1.eigenvalues j) * U a j) * (Real.sqrt (hX.1.eigenvalues j) * U b j) =
          U a j * (Real.sqrt (hX.1.eigenvalues j) * Real.sqrt (hX.1.eigenvalues j)) * U b j := by ring
      rw [hrhs, hsq j]
    · intro k _ hk
      rw [if_neg (Ne.symm hk)]
      ring
    · intro h
      exact absurd (Finset.mem_univ j) h
  · rw [← Finset.mul_sum]
    by_cases hμ : hX.1.eigenvalues j = 0
    · rw [hμ, Real.sqrt_zero, zero_mul]
    · have hcol : X *ᵥ (fun a => U a j) = hX.1.eigenvalues j • (fun a => U a j) := by
        have h := hX.1.mulVec_eigenvectorBasis j
        have hc : ⇑(hX.1.eigenvectorBasis j) = fun a => U a j := by
          funext a
          simp [hU, Matrix.IsHermitian.eigenvectorUnitary_apply]
        rw [hc] at h
        exact h
      have hpair : (X *ᵥ (fun a => U a j)) ⬝ᵥ (fun _ => (1 : ℝ)) =
          (fun a => U a j) ⬝ᵥ (X *ᵥ fun _ => (1 : ℝ)) := by
        rw [dotProduct_mulVec, ← mulVec_transpose, hXt]
      rw [hcol, h1, dotProduct_zero, smul_dotProduct, smul_eq_mul] at hpair
      have hdot : (fun a => U a j) ⬝ᵥ (fun _ => (1 : ℝ)) = 0 :=
        (mul_eq_zero.mp hpair).resolve_left hμ
      have : ∑ a, U a j = 0 := by
        simpa [dotProduct] using hdot
      rw [this, mul_zero]

/-- THE STATIC POTENTIAL OF A FINITE SUM OF TWO-POINT FUNCTIONS IS AT LEAST THE GAP: W(R) = Σ_j ⟨f_j, M^R f_j⟩ with
every f_j orthogonal to the Perron line and W(1) > 0 has log λ₀ − log W(R)/R → E > 0, E = log λ₀ − log λ_k for a
non-Perron λ_k -/
theorem potential_gap_family [Nonempty n] {ι : Type*} [Fintype ι] (M : Matrix n n ℝ) (hM : M.PosSemidef)
    (hpos : ∀ i j, 0 < M i j) (f : ι → n → ℝ) (hf : 0 < ∑ j, f j ⬝ᵥ (M *ᵥ f j))
    (horth : ∀ j, ∀ Ω : n → ℝ, M *ᵥ Ω = lamMax M hM.1 • Ω → Ω ⬝ᵥ f j = 0) :
    ∃ σ : ℝ, 0 < σ ∧ (∃ k, hM.1.eigenvalues k ≠ lamMax M hM.1 ∧ 0 < hM.1.eigenvalues k ∧
      σ = Real.log (lamMax M hM.1) - Real.log (hM.1.eigenvalues k)) ∧
      Tendsto (fun R : ℕ => Real.log (lamMax M hM.1) -
        Real.log (∑ j, f j ⬝ᵥ ((M ^ R) *ᵥ f j)) / R) atTop (𝓝 σ) := by
  have hall := fun j => exists_moment_perron M hM.1 hpos (f j)
  choose m i₀ Ω hm hl hmom hΩeig hne hmi₀ using hall
  have hx := hM.eigenvalues_nonneg
  set mm : n → ℝ := fun i => ∑ j, m j i with hmm
  have hmmnn : ∀ i, 0 ≤ mm i := fun i => Finset.sum_nonneg fun j _ => hm j i
  have htot : ∀ R : ℕ, ∑ j, f j ⬝ᵥ ((M ^ R) *ᵥ f j) = moment mm hM.1.eigenvalues R := by
    intro R
    rw [Finset.sum_congr rfl (fun j _ => hmom j R)]
    exact moment_sum Finset.univ m hM.1.eigenvalues R
  have hne_ι : Nonempty ι := by
    by_contra hcon
    rw [not_nonempty_iff] at hcon
    haveI := hcon
    simp at hf
  obtain ⟨j₀⟩ := hne_ι
  have hsame : ∀ j, i₀ j = i₀ j₀ := fun j => perron_index_unique M hM.1 hpos _ _ (hl j) (hl j₀)
  have hmm0 : mm (i₀ j₀) = 0 := by
    apply Finset.sum_eq_zero
    intro j _
    rw [← hsame j, hmi₀ j, horth j (Ω j) (hΩeig j)]
    ring
  have h1 : 0 < moment mm hM.1.eigenvalues 1 := by
    rw [← htot 1]
    simpa using hf
  have hex : ∃ i, 0 < mm i ∧ 0 < hM.1.eigenvalues i := by
    by_contra hcon
    push_neg at hcon
    have : moment mm hM.1.eigenvalues 1 = 0 := by
      unfold moment
      apply Finset.sum_eq_zero
      intro i _
      rcases (hmmnn i).lt_or_eq with hmi | hmi
      · have := le_antisymm (hcon i hmi) (hx i)
        simp [this]
      · simp [← hmi]
    linarith
  obtain ⟨i₁, hm₁, hx₁⟩ := hex
  obtain ⟨k, hk, hmax⟩ := Finset.exists_max_image (Finset.univ.filter (fun i => 0 < mm i))
    hM.1.eigenvalues ⟨i₁, Finset.mem_filter.mpr ⟨Finset.mem_univ _, hm₁⟩⟩
  have hmk : 0 < mm k := (Finset.mem_filter.mp hk).2
  have hxk : 0 < hM.1.eigenvalues k :=
    lt_of_lt_of_le hx₁ (hmax i₁ (Finset.mem_filter.mpr ⟨Finset.mem_univ _, hm₁⟩))
  have hki₀ : k ≠ i₀ j₀ := by
    intro h
    rw [h, hmm0] at hmk
    exact lt_irrefl 0 hmk
  have hkl : hM.1.eigenvalues k ≠ lamMax M hM.1 := fun h =>
    hki₀ (perron_index_unique M hM.1 hpos k (i₀ j₀) h (hl j₀))
  have hlt : hM.1.eigenvalues k < lamMax M hM.1 := by
    have := abs_eigenvalue_lt M hM.1 hpos k hkl
    rwa [abs_of_pos hxk] at this
  refine ⟨Real.log (lamMax M hM.1) - Real.log (hM.1.eigenvalues k),
    sub_pos.mpr (Real.log_lt_log hxk hlt), ⟨k, hkl, hxk, rfl⟩, ?_⟩
  have hlim := log_moment_div_tendsto mm hM.1.eigenvalues hmmnn hx k hmk hxk
    (fun i hi => hmax i (Finset.mem_filter.mpr ⟨Finset.mem_univ _, hi⟩))
  have h2 : Tendsto (fun R : ℕ => Real.log (∑ j, f j ⬝ᵥ ((M ^ R) *ᵥ f j)) / R) atTop
      (𝓝 (Real.log (hM.1.eigenvalues k))) := hlim.congr fun R => by rw [htot R]
  exact tendsto_const_nhds.sub h2

end Averaged

section Nonabelian

variable {n : Type*} [Fintype n] [DecidableEq n] {G : Type*} [Fintype G] [DecidableEq G] [Group G]

/-- THE NONABELIAN WILSON LOOP'S STATIC POTENTIAL IS AT LEAST THE GAP, abstract: M the transfer matrix (symmetric,
entrywise positive, positive semidefinite), h the T-line's holonomy into the group, X(a, b) = χ(a b⁻¹) the class
matrix of a real class function -- positive semidefinite and killing the constants -- and σ_g the gauge
transformations at one endpoint of the line (M-invariant permutations with h(σ_g c) = g · h(c)).  Then X has a Gram
factorisation whose vectors F_j = φ_j ∘ h all have zero Perron mass, and the loop's two-point function
W(R) = Σ_j ⟨F_j Ω, M^R F_j Ω⟩ (Ω any Perron eigenvector), once W(1) > 0, has log λ₀ − log W(R)/R → E > 0 with
E = log λ₀ − log λ_k for a non-Perron λ_k -/
theorem nonabelian_potential_gap [Nonempty n] (M : Matrix n n ℝ) (hM : M.PosSemidef)
    (hpos : ∀ i j, 0 < M i j) (h : n → G) (X : Matrix G G ℝ) (hX : X.PosSemidef)
    (hX1 : X *ᵥ (fun _ => (1 : ℝ)) = 0) (σ : G → Equiv.Perm n) (hinv : ∀ g a b, M (σ g a) (σ g b) = M a b)
    (hact : ∀ g c, h (σ g c) = g * h c) :
    ∃ φ : G → G → ℝ, (∀ a b, X a b = ∑ j, φ j a * φ j b) ∧
      ∀ Ω : n → ℝ, M *ᵥ Ω = lamMax M hM.1 • Ω →
        (∀ j, ∀ Ω' : n → ℝ, M *ᵥ Ω' = lamMax M hM.1 • Ω' →
          Ω' ⬝ᵥ (diagonal (fun c => φ j (h c)) *ᵥ Ω) = 0) ∧
        (0 < ∑ j, (diagonal (fun c => φ j (h c)) *ᵥ Ω) ⬝ᵥ (M *ᵥ (diagonal (fun c => φ j (h c)) *ᵥ Ω)) →
          ∃ s : ℝ, 0 < s ∧ (∃ k, hM.1.eigenvalues k ≠ lamMax M hM.1 ∧ 0 < hM.1.eigenvalues k ∧
            s = Real.log (lamMax M hM.1) - Real.log (hM.1.eigenvalues k)) ∧
            Tendsto (fun R : ℕ => Real.log (lamMax M hM.1) - Real.log (∑ j,
              (diagonal (fun c => φ j (h c)) *ᵥ Ω) ⬝ᵥ ((M ^ R) *ᵥ (diagonal (fun c => φ j (h c)) *ᵥ Ω))) / R)
              atTop (𝓝 s)) := by
  obtain ⟨φ, hφ, hφ0⟩ := exists_gram_sum_zero X hX hX1
  refine ⟨φ, hφ, fun Ω hΩ => ⟨fun j Ω' hΩ' => ?_, fun hW1 => ?_⟩⟩
  · apply perron_dot_avg M hM.1 hpos σ hinv (fun c => φ j (h c)) _ Ω' Ω hΩ' hΩ
    intro c
    simp only [hact]
    have := Equiv.sum_comp (Equiv.mulRight (h c)) (φ j)
    simp only [Equiv.coe_mulRight] at this
    rw [this]
    exact hφ0 j
  · have horth : ∀ j, ∀ Ω' : n → ℝ, M *ᵥ Ω' = lamMax M hM.1 • Ω' →
        Ω' ⬝ᵥ (diagonal (fun c => φ j (h c)) *ᵥ Ω) = 0 := by
      intro j Ω' hΩ'
      apply perron_dot_avg M hM.1 hpos σ hinv (fun c => φ j (h c)) _ Ω' Ω hΩ' hΩ
      intro c
      simp only [hact]
      have := Equiv.sum_comp (Equiv.mulRight (h c)) (φ j)
      simp only [Equiv.coe_mulRight] at this
      rw [this]
      exact hφ0 j
    exact potential_gap_family M hM hpos (fun j => diagonal (fun c => φ j (h c)) *ᵥ Ω) hW1 horth

end Nonabelian

section Slab

variable {n : Type*} [Fintype n] [DecidableEq n]

/-- the product of the two insertions' site weights over a sequence is the observable at the two sites -/
theorem prod_ins (F : n → ℝ) (a R L : ℕ) (ha : a + R ≤ L) (c : Fin (L + 1) → n) :
    ∏ x : Fin (L + 1), ins F a R (x : ℕ) (c x) = F (c ⟨a, by omega⟩) * F (c ⟨a + R, by omega⟩) := by
  simp only [ins]
  rw [Finset.prod_mul_distrib]
  congr 1
  · rw [Finset.prod_eq_single ⟨a, by omega⟩]
    · simp
    · intro b _ hb
      rw [if_neg]
      intro hb'
      exact hb (Fin.ext hb')
    · intro hmem
      exact absurd (Finset.mem_univ _) hmem
  · rw [Finset.prod_eq_single ⟨a + R, by omega⟩]
    · simp
    · intro b _ hb
      rw [if_neg]
      intro hb'
      exact hb (Fin.ext hb')
    · intro hmem
      exact absurd (Finset.mem_univ _) hmem

/-- the slab's Gibbs sum with a PAIR weight P at the sites a and a + R: the Wilson loop's χ(h(c_a) h(c_{a+R})⁻¹) -/
def pathSumPair (M : Matrix n n ℝ) (P : n → n → ℝ) (u v : n → ℝ) (a R L : ℕ) (ha : a + R ≤ L) : ℝ :=
  ∑ c : Fin (L + 1) → n, u (c 0) * P (c ⟨a, by omega⟩) (c ⟨a + R, by omega⟩) *
    (∏ x : Fin L, M (c x.castSucc) (c x.succ)) * v (c (Fin.last L))

/-- THE LOOP IS A SUM OF TWO-POINT FUNCTIONS: a pair weight with a Gram factorisation P(x, y) = Σ_j F_j(x) F_j(y)
makes the pair sum the sum over j of the two-insertion sums of F_j -/
theorem pathSumPair_eq_sum {ι : Type*} [Fintype ι] (M : Matrix n n ℝ) (P : n → n → ℝ) (F : ι → n → ℝ)
    (hP : ∀ x y, P x y = ∑ j, F j x * F j y) (u v : n → ℝ) (a R L : ℕ) (ha : a + R ≤ L) :
    pathSumPair M P u v a R L ha = ∑ j, pathSum M (ins (F j) a R) u v 0 L := by
  simp only [pathSumPair, pathSum, zero_add]
  rw [Finset.sum_comm]
  apply Finset.sum_congr rfl
  intro c _
  rw [hP, Finset.mul_sum, Finset.sum_mul, Finset.sum_mul]
  apply Finset.sum_congr rfl
  intro j _
  rw [prod_ins (F j) a R L ha c]

/-- two unit Perron eigenvectors of a symmetric entrywise-positive matrix agree up to sign -/
theorem perron_unit_sign [Nonempty n] (M : Matrix n n ℝ) (hM : M.IsHermitian) (hpos : ∀ i j, 0 < M i j)
    (Ω Ω' : n → ℝ) (hΩ : M *ᵥ Ω = lamMax M hM • Ω) (hΩ' : M *ᵥ Ω' = lamMax M hM • Ω')
    (hn : Ω ⬝ᵥ Ω = 1) (hn' : Ω' ⬝ᵥ Ω' = 1) : Ω' = Ω ∨ Ω' = -Ω := by
  obtain ⟨a, hapos, ha, -⟩ := perron_exists M hM hpos
  obtain ⟨c, hc⟩ := perron_simple M hM hpos a hapos ha Ω hΩ
  obtain ⟨c', hc'⟩ := perron_simple M hM hpos a hapos ha Ω' hΩ'
  have haa : 0 < a ⬝ᵥ a := by
    apply Finset.sum_pos
    · intro i _
      exact mul_pos (hapos i) (hapos i)
    · exact Finset.univ_nonempty
  rw [hc, smul_dotProduct, dotProduct_smul, smul_eq_mul, smul_eq_mul] at hn
  rw [hc', smul_dotProduct, dotProduct_smul, smul_eq_mul, smul_eq_mul] at hn'
  have hcc : c' * c' = c * c := by
    have h1 : c * c * (a ⬝ᵥ a) = 1 := by rw [← hn]; ring
    have h2 : c' * c' * (a ⬝ᵥ a) = 1 := by rw [← hn']; ring
    have := h1.trans h2.symm
    exact (mul_right_cancel₀ haa.ne' this).symm
  rcases mul_self_eq_mul_self_iff.mp hcc with h | h
  · left
    rw [hc, hc', h]
  · right
    rw [hc, hc', h, neg_smul]

/-- THE INFINITE SLAB WITH ANY UNIT PERRON VECTOR: the two-point function of F placed symmetrically in the slab
converges to ⟨F Ω, M^R F Ω⟩ / λ₀^R for every unit Perron eigenvector Ω (its sign is immaterial) -/
theorem slab_tendsto' [Nonempty n] (D : n → ℝ) (hD : ∀ c, 0 < D c) (K : Matrix n n ℝ) (hK : K.PosSemidef)
    (hKpos : ∀ c c', 0 < K c c') (F : n → ℝ) (Ω : n → ℝ)
    (hΩ : transfer D K *ᵥ Ω = lamMax (transfer D K) (transfer_posSemidef D K hK).1 • Ω) (hn : Ω ⬝ᵥ Ω = 1)
    (R : ℕ) :
    Tendsto (fun a : ℕ => slabNum D K F (a + 1) R / slabZ D K (a + 1) R) atTop
      (𝓝 ((diagonal F *ᵥ Ω) ⬝ᵥ (transfer D K ^ R *ᵥ (diagonal F *ᵥ Ω)) /
        lamMax (transfer D K) (transfer_posSemidef D K hK).1 ^ R)) := by
  obtain ⟨Ω₀, hn₀, hΩ₀, -, hlim⟩ := slab_tendsto D hD K hK hKpos F
  have hM : (transfer D K).IsHermitian := (transfer_posSemidef D K hK).1
  have hpos : ∀ i j, 0 < transfer D K i j := transfer_pos D hD K hKpos
  rcases perron_unit_sign (transfer D K) hM hpos Ω₀ Ω hΩ₀ hΩ hn₀ hn with h | h
  · rw [h]
    exact hlim R
  · rw [h]
    have : (diagonal F *ᵥ -Ω₀) ⬝ᵥ (transfer D K ^ R *ᵥ (diagonal F *ᵥ -Ω₀)) =
        (diagonal F *ᵥ Ω₀) ⬝ᵥ (transfer D K ^ R *ᵥ (diagonal F *ᵥ Ω₀)) := by
      rw [mulVec_neg, mulVec_neg, neg_dotProduct, dotProduct_neg, neg_neg]
    rw [this]
    exact hlim R

/-- the slab's Wilson loop with the pair weight P placed symmetrically: a + 1 vacuum cross-sections either side -/
noncomputable def slabLoop (D : n → ℝ) (K : Matrix n n ℝ) (P : n → n → ℝ) (a R : ℕ) : ℝ :=
  pathSumPair (transfer D K) P (fun c => Real.sqrt (D c)) (fun c => Real.sqrt (D c)) (a + 1) R
    (2 * (a + 1) + R) (by omega)

/-- THE NONABELIAN WILSON LOOP OF THE X-TRANSFER MODEL CONVERGES, AND ITS STATIC POTENTIAL IS AT LEAST THE GAP: with
the class matrix X of a nontrivial real class function factorised as X(x, y) = Σ_j φ_j(x) φ_j(y), the loop's pair
weight P(c, c') = X(h c, h c') on the slab, D positive, k the link kernel (positive semidefinite and positive), the
endpoint gauge action σ_g (D-invariant, equivariant on h), and Ω any unit Perron vector of M = D^{1/2} K D^{1/2}:
the loop's slab expectation converges to W(R) = Σ_j ⟨F_j Ω, M^R F_j Ω⟩ / λ₀^R at every R, and if W(1) > 0 then
log λ₀ − log Σ_j ⟨F_j Ω, M^R F_j Ω⟩ / R → E > 0, a gap -/
theorem nonabelian_slab_potential_gap {G : Type*} [Fintype G] [DecidableEq G] [Group G]
    {L : Type*} [Fintype L] [DecidableEq L]
    (D : (L → G) → ℝ) (hD : ∀ c, 0 < D c) (k : Matrix G G ℝ) (hk : k.PosSemidef) (hkpos : ∀ g g', 0 < k g g')
    (h : (L → G) → G) (X : Matrix G G ℝ) (hX : X.PosSemidef) (hX1 : X *ᵥ (fun _ => (1 : ℝ)) = 0)
    (φ : G → G → ℝ) (hφ : ∀ x y, X x y = ∑ j, φ j x * φ j y)
    (σ : G → Equiv.Perm (L → G)) (hDinv : ∀ g c, D (σ g c) = D c)
    (hKinv : ∀ g c c', tensorKernel k (σ g c) (σ g c') = tensorKernel k c c')
    (hact : ∀ g c, h (σ g c) = g * h c)
    (Ω : (L → G) → ℝ)
    (hΩ : transfer D (tensorKernel k) *ᵥ Ω =
      lamMax (transfer D (tensorKernel k)) (transfer_posSemidef D _ (tensorKernel_posSemidef k hk)).1 • Ω)
    (hn : Ω ⬝ᵥ Ω = 1) :
    (∀ R : ℕ, Tendsto (fun a : ℕ => slabLoop D (tensorKernel k) (fun c c' => X (h c) (h c')) a R /
        slabZ D (tensorKernel k) (a + 1) R) atTop
      (𝓝 (∑ j, (diagonal (fun c => φ j (h c)) *ᵥ Ω) ⬝ᵥ
          (transfer D (tensorKernel k) ^ R *ᵥ (diagonal (fun c => φ j (h c)) *ᵥ Ω)) /
        lamMax (transfer D (tensorKernel k)) (transfer_posSemidef D _ (tensorKernel_posSemidef k hk)).1 ^ R))) ∧
    (0 < ∑ j, (diagonal (fun c => φ j (h c)) *ᵥ Ω) ⬝ᵥ
        (transfer D (tensorKernel k) *ᵥ (diagonal (fun c => φ j (h c)) *ᵥ Ω)) →
      ∃ s : ℝ, 0 < s ∧
        (∃ i, (transfer_posSemidef D _ (tensorKernel_posSemidef k hk)).1.eigenvalues i ≠
            lamMax (transfer D (tensorKernel k)) (transfer_posSemidef D _ (tensorKernel_posSemidef k hk)).1 ∧
          0 < (transfer_posSemidef D _ (tensorKernel_posSemidef k hk)).1.eigenvalues i ∧
          s = Real.log (lamMax (transfer D (tensorKernel k))
              (transfer_posSemidef D _ (tensorKernel_posSemidef k hk)).1) -
            Real.log ((transfer_posSemidef D _ (tensorKernel_posSemidef k hk)).1.eigenvalues i)) ∧
        Tendsto (fun R : ℕ => Real.log (lamMax (transfer D (tensorKernel k))
            (transfer_posSemidef D _ (tensorKernel_posSemidef k hk)).1) -
          Real.log (∑ j, (diagonal (fun c => φ j (h c)) *ᵥ Ω) ⬝ᵥ
            (transfer D (tensorKernel k) ^ R *ᵥ (diagonal (fun c => φ j (h c)) *ᵥ Ω))) / R) atTop (𝓝 s)) := by
  set K : Matrix (L → G) (L → G) ℝ := tensorKernel k with hKdef
  have hK : K.PosSemidef := tensorKernel_posSemidef k hk
  have hKpos : ∀ c c', 0 < K c c' := tensorKernel_pos k hkpos
  set M : Matrix (L → G) (L → G) ℝ := transfer D K with hMdef
  have hM : M.PosSemidef := transfer_posSemidef D K hK
  have hpos : ∀ i j, 0 < M i j := transfer_pos D hD K hKpos
  have hMinv : ∀ g a b, M (σ g a) (σ g b) = M a b := by
    intro g a b
    simp only [hMdef, transfer_apply, hDinv]
    rw [hKinv]
  refine ⟨fun R => ?_, fun hW1 => ?_⟩
  · -- the loop's slab sum is the sum over j of the two-insertion sums
    have hdecomp : ∀ a : ℕ, slabLoop D K (fun c c' => X (h c) (h c')) a R =
        ∑ j, slabNum D K (fun c => φ j (h c)) (a + 1) R := by
      intro a
      simp only [slabLoop, slabNum]
      exact pathSumPair_eq_sum M (fun c c' => X (h c) (h c')) (fun j c => φ j (h c))
        (fun c c' => hφ (h c) (h c')) _ _ (a + 1) R (2 * (a + 1) + R) (by omega)
    have hlimj : ∀ j, Tendsto (fun a : ℕ => slabNum D K (fun c => φ j (h c)) (a + 1) R / slabZ D K (a + 1) R)
        atTop (𝓝 ((diagonal (fun c => φ j (h c)) *ᵥ Ω) ⬝ᵥ
          (M ^ R *ᵥ (diagonal (fun c => φ j (h c)) *ᵥ Ω)) / lamMax M hM.1 ^ R)) :=
      fun j => slab_tendsto' D hD K hK hKpos (fun c => φ j (h c)) Ω hΩ hn R
    have hsum := tendsto_finsetSum Finset.univ (fun j _ => hlimj j)
    have hmain : Tendsto (fun a : ℕ => slabLoop D K (fun c c' => X (h c) (h c')) a R / slabZ D K (a + 1) R)
        atTop (𝓝 (∑ j, (diagonal (fun c => φ j (h c)) *ᵥ Ω) ⬝ᵥ
          (M ^ R *ᵥ (diagonal (fun c => φ j (h c)) *ᵥ Ω)) / lamMax M hM.1 ^ R)) := by
      refine hsum.congr' (Filter.Eventually.of_forall fun a => ?_)
      show ∑ j, slabNum D K (fun c => φ j (h c)) (a + 1) R / slabZ D K (a + 1) R =
        slabLoop D K (fun c c' => X (h c) (h c')) a R / slabZ D K (a + 1) R
      rw [hdecomp a, Finset.sum_div]
    simpa [hMdef, hKdef] using hmain
  · -- every Gram vector of X sums to zero, since 1ᵀ X 1 = Σ_j (Σ_x φ_j x)² and X 1 = 0
    have hφ0 : ∀ j, ∑ x, φ j x = 0 := by
      -- Σ_x φ_j(x) = 0: from X 1 = 0 and the Gram form, Σ_j (Σ_x φ_j x)^2 = 1ᵀ X 1 = 0
      have hXX : ∑ j, (∑ x, φ j x) ^ 2 = 0 := by
        have h0 : (fun _ => (1 : ℝ)) ⬝ᵥ (X *ᵥ fun _ => (1 : ℝ)) = 0 := by rw [hX1, dotProduct_zero]
        have hsq : ∀ j, (∑ x, φ j x) ^ 2 = ∑ x, ∑ y, φ j x * φ j y := fun j => by
          rw [sq, Finset.sum_mul_sum]
        simp only [hsq]
        rw [← h0]
        simp only [dotProduct, mulVec, hφ, Finset.mul_sum, Finset.sum_mul, one_mul, mul_one]
        rw [Finset.sum_comm]
        apply Finset.sum_congr rfl
        intro j _
        rw [Finset.sum_comm]
      intro j
      have := (Finset.sum_eq_zero_iff_of_nonneg (fun j _ => sq_nonneg (∑ x, φ j x))).mp hXX j (Finset.mem_univ j)
      exact pow_eq_zero_iff (two_ne_zero) |>.mp this
    have horth : ∀ j, ∀ Ω' : (L → G) → ℝ, M *ᵥ Ω' = lamMax M hM.1 • Ω' →
        Ω' ⬝ᵥ (diagonal (fun c => φ j (h c)) *ᵥ Ω) = 0 := by
      intro j Ω' hΩ'
      apply perron_dot_avg M hM.1 hpos σ hMinv (fun c => φ j (h c)) _ Ω' Ω hΩ' hΩ
      intro c
      simp only [hact]
      have := Equiv.sum_comp (Equiv.mulRight (h c)) (φ j)
      simp only [Equiv.coe_mulRight] at this
      rw [this]
      exact hφ0 j
    exact potential_gap_family M hM hpos (fun j => diagonal (fun c => φ j (h c)) *ᵥ Ω) hW1 horth

end Slab

end Aperanton
