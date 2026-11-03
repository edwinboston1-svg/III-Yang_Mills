/-
  APERANTON -- THE BOUNDLESS, stage A8b: THE X-TRANSFER MODEL OF A FINITE GROUP AND THE INFINITE SLAB.

  A finite group's lattice gauge theory on a slab of L + 1 cross-sections along x, every x-link in temporal gauge, has
  the Gibbs weight  ∏_x D(c_x) ∏_x K(c_x, c_{x+1}):  c_x the configuration of the cross-section's links, D(c) the
  product of the in-plane plaquette weights (any positive function of c), K(c, c') = ∏_ℓ k(c_ℓ, c'_ℓ) the product
  over the links of the x-plaquette's weight k(g, h) = w(g h⁻¹), w the plaquette weight.  Proved here above Mathlib:
  (1) THE CHAIN: the sum over all sequences c_0..c_L of u(c_0) ∏_x G_x(c_x) ∏_x M(c_x, c_{x+1}) v(c_L) is the
      matrix sandwich u · (diag G_0 · M · diag G_1 · M ⋯ diag G_L) · v, for any kernel M and any site weights G;
  (2) THE GRAM FACTORISATION of a real symmetric positive semidefinite matrix, X a b = Σ_j φ_j a φ_j b, and its
      converse; hence THE TENSOR KERNEL K is positive semidefinite whenever the single-link kernel k is (it is the Gram
      matrix of the products Φ_J(c) = ∏_ℓ φ_{J ℓ}(c ℓ)), and positive whenever k is;
  (3) THE TRANSFER MATRIX M = D^{1/2} K D^{1/2} is symmetric, positive semidefinite and entrywise positive, so Perron
      (Perron.lean) applies: λ₀ simple, the vacuum Ω strictly signed, every other eigenvalue smaller in modulus, and
      THE PERRON LIMIT M^a v / λ₀^a → ⟨Ω, v⟩ Ω;
  (4) THE INFINITE SLAB: for any observable F of a cross-section, the two-point function placed
      symmetrically in the slab, Σ F(c_a) F(c_{a+R}) weight / Z over the slab of length 2a + R, converges as a → ∞ to ⟨F Ω, M^R F Ω⟩ / λ₀^R --
      a moment sequence in R on the spectrum of M / λ₀ ⊂ [0, 1] (Spectral.lean), so THE STRING TENSION OF EVERY FINITE
      GROUP EXISTS on every finite cross-section: with χ(a b⁻¹) = Σ_j φ_j(a) φ_j(b), the Gram factorisation of the
      positive-definite class function χ, the R × T Wilson loop is a finite sum of such two-point functions, one per
      Gram vector, each a moment sequence on the same points.
  No sorry, no axiom.
-/
import Mathlib
import Aperanton.Perron
import Aperanton.Spectral

open Matrix Filter Topology

namespace Aperanton

section Chain

variable {n : Type*} [Fintype n] [DecidableEq n]

/-- the slab's Gibbs sum: over the sequences c_0..c_L, u(c_0) ∏_x G_{s+x}(c_x) ∏_x M(c_x, c_{x+1}) v(c_L) -/
def pathSum (M : Matrix n n ℝ) (G : ℕ → n → ℝ) (u v : n → ℝ) (s L : ℕ) : ℝ :=
  ∑ c : Fin (L + 1) → n, u (c 0) * (∏ x : Fin (L + 1), G (s + x) (c x)) *
    (∏ x : Fin L, M (c x.castSucc) (c x.succ)) * v (c (Fin.last L))

/-- the matrix chain diag(G_s) M diag(G_{s+1}) M ⋯ diag(G_{s+L}) -/
def chain (M : Matrix n n ℝ) (G : ℕ → n → ℝ) (s : ℕ) : ℕ → Matrix n n ℝ
  | 0 => diagonal (G s)
  | L + 1 => diagonal (G s) * M * chain M G (s + 1) L

/-- THE CHAIN: the Gibbs sum is the matrix sandwich -/
theorem pathSum_eq_chain (M : Matrix n n ℝ) (G : ℕ → n → ℝ) (v : n → ℝ) :
    ∀ (L s : ℕ) (u : n → ℝ), pathSum M G u v s L = u ⬝ᵥ (chain M G s L *ᵥ v) := by
  intro L
  induction L with
  | zero =>
    intro s u
    simp only [pathSum, chain]
    rw [Fintype.sum_equiv (Equiv.funUnique (Fin 1) n) _ (fun z => u z * G s z * v z)]
    · simp only [dotProduct, mulVec_diagonal]
      apply Finset.sum_congr rfl
      intro z _
      ring
    · intro c
      simp
  | succ L ih =>
    intro s u
    simp only [pathSum]
    rw [Fintype.sum_equiv
      (⟨fun c => (c 0, fun i => c i.succ), fun p => Fin.cons p.1 p.2,
        fun c => Fin.cons_self_tail c,
        fun p => Prod.ext (by simp) (funext fun i => by simp)⟩ :
        (Fin (L + 1 + 1) → n) ≃ n × (Fin (L + 1) → n)) _
      (fun p : n × (Fin (L + 1) → n) => u p.1 * G s p.1 * M p.1 (p.2 0) *
        ((∏ x : Fin (L + 1), G (s + 1 + x) (p.2 x)) *
          (∏ x : Fin L, M (p.2 x.castSucc) (p.2 x.succ)) * v (p.2 (Fin.last L))))]
    · rw [Fintype.sum_prod_type]
      have hin : ∀ z : n, ∑ c : Fin (L + 1) → n, u z * G s z * M z (c 0) *
          ((∏ x : Fin (L + 1), G (s + 1 + x) (c x)) * (∏ x : Fin L, M (c x.castSucc) (c x.succ)) *
            v (c (Fin.last L))) = u z * G s z * pathSum M G (fun y => M z y) v (s + 1) L := by
        intro z
        simp only [pathSum, Finset.mul_sum]
        apply Finset.sum_congr rfl
        intro c _
        ring
      simp only [hin, ih, chain]
      rw [← mulVec_mulVec, ← mulVec_mulVec]
      have hd : diagonal (G s) *ᵥ (M *ᵥ (chain M G (s + 1) L *ᵥ v)) =
          fun z => G s z * (M *ᵥ (chain M G (s + 1) L *ᵥ v)) z :=
        funext fun z => mulVec_diagonal _ _ _
      rw [hd]
      simp only [dotProduct]
      apply Finset.sum_congr rfl
      intro z _
      simp only [mulVec, dotProduct]
      ring
    · intro c
      show u (c 0) * (∏ x : Fin (L + 1 + 1), G (s + x) (c x)) *
          (∏ x : Fin (L + 1), M (c x.castSucc) (c x.succ)) * v (c (Fin.last (L + 1))) =
        u (c 0) * G s (c 0) * M (c 0) (c (0 : Fin (L + 1)).succ) *
          ((∏ x : Fin (L + 1), G (s + 1 + x) (c x.succ)) *
            (∏ x : Fin L, M (c x.castSucc.succ) (c x.succ.succ)) * v (c (Fin.last L).succ))
      simp only [Fin.prod_univ_succ, Fin.castSucc_zero, Fin.succ_castSucc, Fin.val_succ, Fin.val_zero,
        add_zero, Fin.succ_last]
      ring_nf

theorem diagonal_const_one : diagonal (fun _ : n => (1 : ℝ)) = (1 : Matrix n n ℝ) := by
  ext i j
  simp [diagonal_apply, one_apply]

/-- the chain depends on the site weights only along its sites -/
theorem chain_congr (M : Matrix n n ℝ) (G G' : ℕ → n → ℝ) :
    ∀ (L s : ℕ), (∀ x, s ≤ x → x ≤ s + L → G x = G' x) → chain M G s L = chain M G' s L := by
  intro L
  induction L with
  | zero =>
    intro s h
    simp only [chain]
    rw [h s le_rfl (by omega)]
  | succ L ih =>
    intro s h
    simp only [chain]
    rw [h s le_rfl (by omega), ih (s + 1) (fun x hx hx' => h x (by omega) (by omega))]

/-- a chain of unit weights over L steps is M^L -/
theorem chain_one (M : Matrix n n ℝ) :
    ∀ (L s : ℕ), chain M (fun _ => fun _ => (1 : ℝ)) s L = M ^ L := by
  intro L
  induction L with
  | zero =>
    intro s
    simp only [chain, pow_zero]
    exact diagonal_const_one
  | succ L ih =>
    intro s
    simp only [chain]
    rw [diagonal_const_one, one_mul, ih, pow_succ']

/-- the chain splits at a site -/
theorem chain_split (M : Matrix n n ℝ) (G : ℕ → n → ℝ) :
    ∀ (L₁ L₂ s : ℕ), chain M G s (L₁ + 1 + L₂) = chain M G s L₁ * M * chain M G (s + L₁ + 1) L₂ := by
  intro L₁
  induction L₁ with
  | zero =>
    intro L₂ s
    rw [show (0 : ℕ) + 1 + L₂ = L₂ + 1 by ring, show s + 0 + 1 = s + 1 by ring]
    simp only [chain]
  | succ L₁ ih =>
    intro L₂ s
    have h1 : L₁ + 1 + 1 + L₂ = (L₁ + 1 + L₂) + 1 := by ring
    rw [h1]
    simp only [chain]
    rw [ih L₂ (s + 1)]
    have h2 : s + 1 + L₁ + 1 = s + (L₁ + 1) + 1 := by ring
    rw [h2]
    simp only [mul_assoc]

/-- unit weights up to the last site, F there: M^L diag F -/
theorem chain_last (M : Matrix n n ℝ) (F : n → ℝ) :
    ∀ (L s : ℕ), chain M (fun x c => if x = s + L then F c else 1) s L = M ^ L * diagonal F := by
  intro L
  induction L with
  | zero =>
    intro s
    simp [chain]
  | succ L ih =>
    intro s
    simp only [chain]
    have hs : (fun c => if s = s + (L + 1) then F c else (1 : ℝ)) = fun _ => 1 := by
      funext c
      rw [if_neg (by omega)]
    rw [hs, diagonal_const_one, one_mul]
    have hG : (fun x c => if x = s + 1 + L then F c else (1 : ℝ)) =
        (fun x c => if x = s + (L + 1) then F c else 1) := by
      funext x c
      rw [show s + 1 + L = s + (L + 1) by ring]
    rw [← hG, ih (s + 1), pow_succ', mul_assoc]

/-- the site weights of two insertions of F, at a and at a + R (both at once when R = 0) -/
def ins (F : n → ℝ) (a R : ℕ) : ℕ → n → ℝ :=
  fun x c => (if x = a then F c else 1) * (if x = a + R then F c else 1)

/-- the chain with F at both ends and unit weights between: diag F · M^R · diag F -/
theorem chain_two (M : Matrix n n ℝ) (F : n → ℝ) (a : ℕ) :
    ∀ R : ℕ, chain M (ins F a R) a R = diagonal F * M ^ R * diagonal F := by
  intro R
  cases R with
  | zero =>
    simp [chain, ins, diagonal_mul_diagonal]
  | succ R =>
    simp only [chain]
    have h1 : ins F a (R + 1) a = F := by
      funext c
      have hne : ¬ (a = a + (R + 1)) := by omega
      simp [ins, hne]
    rw [h1]
    have h2 : chain M (ins F a (R + 1)) (a + 1) R = M ^ R * diagonal F := by
      rw [chain_congr M (ins F a (R + 1)) (fun x c => if x = a + 1 + R then F c else 1) R (a + 1)]
      · exact chain_last M F R (a + 1)
      · intro x hx hx'
        funext c
        simp only [ins]
        rw [if_neg (by omega), one_mul, show a + (R + 1) = a + 1 + R by ring]
    rw [h2, pow_succ']
    simp only [mul_assoc]

/-- the numerator's chain: a + 1 unit sites, the loop, a + 1 unit sites -/
theorem chain_num (M : Matrix n n ℝ) (F : n → ℝ) (a R : ℕ) :
    chain M (ins F (a + 1) R) 0 (2 * (a + 1) + R) =
      M ^ (a + 1) * (diagonal F * M ^ R * diagonal F) * M ^ (a + 1) := by
  have hL : 2 * (a + 1) + R = a + 1 + (R + 1 + a) := by ring
  rw [hL, chain_split M _ a (R + 1 + a) 0]
  have hfirst : chain M (ins F (a + 1) R) 0 a = M ^ a := by
    rw [chain_congr M (ins F (a + 1) R) (fun _ => fun _ => (1 : ℝ)) a 0]
    · exact chain_one M a 0
    · intro x hx hx'
      funext c
      simp only [ins]
      rw [if_neg (by omega), if_neg (by omega), mul_one]
  rw [hfirst]
  simp only [zero_add]
  rw [chain_split M _ R a (a + 1), chain_two M F (a + 1) R]
  have hlast : chain M (ins F (a + 1) R) (a + 1 + R + 1) a = M ^ a := by
    rw [chain_congr M (ins F (a + 1) R) (fun _ => fun _ => (1 : ℝ)) a (a + 1 + R + 1)]
    · exact chain_one M a _
    · intro x hx hx'
      funext c
      simp only [ins]
      rw [if_neg (by omega), if_neg (by omega), mul_one]
  rw [hlast]
  calc M ^ a * M * (diagonal F * M ^ R * diagonal F * M * M ^ a)
      = (M ^ a * M) * (diagonal F * M ^ R * diagonal F) * (M * M ^ a) := by simp only [mul_assoc]
    _ = M ^ (a + 1) * (diagonal F * M ^ R * diagonal F) * M ^ (a + 1) := by
        rw [← pow_succ, ← pow_succ']

/-- the partition function's chain: M^(2(a+1)+R) split as M^(a+1) · M^R · M^(a+1) -/
theorem chain_Z (M : Matrix n n ℝ) (a R : ℕ) :
    chain M (fun _ => fun _ => (1 : ℝ)) 0 (2 * (a + 1) + R) = M ^ (a + 1) * M ^ R * M ^ (a + 1) := by
  rw [chain_one, show 2 * (a + 1) + R = (a + 1) + R + (a + 1) by ring, pow_add, pow_add]

end Chain

section Gram

variable {n : Type*} [Fintype n] [DecidableEq n]

/-- THE GRAM FACTORISATION: a real symmetric positive semidefinite matrix is a sum of products of its scaled
eigenvector coordinates, X a b = Σ_j φ_j a φ_j b -/
theorem exists_gram (X : Matrix n n ℝ) (hX : X.PosSemidef) :
    ∃ φ : n → n → ℝ, ∀ a b, X a b = ∑ j, φ j a * φ j b := by
  set U : Matrix n n ℝ := (hX.1.eigenvectorUnitary : Matrix n n ℝ) with hU
  have hspec : X = U * diagonal hX.1.eigenvalues * star U := by
    have h := hX.1.spectral_theorem
    rw [Unitary.conjStarAlgAut_apply] at h
    simpa [RCLike.ofReal_real_eq_id] using h
  have hstar : star U = Uᵀ := by rw [star_eq_conjTranspose, conjTranspose_eq_transpose_of_trivial]
  refine ⟨fun j a => Real.sqrt (hX.1.eigenvalues j) * U a j, fun a b => ?_⟩
  have hsq : ∀ j, Real.sqrt (hX.1.eigenvalues j) * Real.sqrt (hX.1.eigenvalues j) =
      hX.1.eigenvalues j := fun j => Real.mul_self_sqrt (hX.eigenvalues_nonneg j)
  conv_lhs => rw [hspec]
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

/-- a Gram matrix is positive semidefinite -/
theorem posSemidef_of_gram {m : Type*} [Fintype m] (X : Matrix n n ℝ) (φ : m → n → ℝ)
    (h : ∀ a b, X a b = ∑ j, φ j a * φ j b) : X.PosSemidef := by
  have hX : X = (Matrix.of φ)ᴴ * Matrix.of φ := by
    ext a b
    rw [h, mul_apply]
    simp [conjTranspose_apply, Matrix.of_apply]
  rw [hX]
  exact posSemidef_conjTranspose_mul_self _

end Gram

section Tensor

variable {G : Type*} [Fintype G] [DecidableEq G] {L : Type*} [Fintype L] [DecidableEq L]

/-- the tensor kernel over the links: K(c, c') = ∏_ℓ k(c ℓ, c' ℓ) -/
def tensorKernel (k : Matrix G G ℝ) : Matrix (L → G) (L → G) ℝ :=
  fun c c' => ∏ ℓ, k (c ℓ) (c' ℓ)

/-- THE TENSOR KERNEL IS POSITIVE SEMIDEFINITE when the single-link kernel is: it is the Gram matrix of the
products Φ_J(c) = ∏_ℓ φ_{J ℓ}(c ℓ) over the assignments J of a Gram vector to every link -/
theorem tensorKernel_posSemidef (k : Matrix G G ℝ) (hk : k.PosSemidef) :
    (tensorKernel k : Matrix (L → G) (L → G) ℝ).PosSemidef := by
  obtain ⟨φ, hφ⟩ := exists_gram k hk
  apply posSemidef_of_gram (tensorKernel k) (fun J : L → G => fun c => ∏ ℓ, φ (J ℓ) (c ℓ))
  intro c c'
  simp only [tensorKernel, hφ]
  rw [Fintype.prod_sum]
  apply Finset.sum_congr rfl
  intro J _
  rw [Finset.prod_mul_distrib]

omit [Fintype G] [DecidableEq G] [DecidableEq L] in
/-- the tensor kernel of a positive kernel is positive -/
theorem tensorKernel_pos (k : Matrix G G ℝ) (hk : ∀ g h, 0 < k g h) (c c' : L → G) :
    0 < tensorKernel k c c' :=
  Finset.prod_pos fun ℓ _ => hk _ _

end Tensor

section Transfer

variable {n : Type*} [Fintype n] [DecidableEq n]

/-- the symmetric transfer matrix M = D^{1/2} K D^{1/2} of a cross-section weight D and a kernel K -/
noncomputable def transfer (D : n → ℝ) (K : Matrix n n ℝ) : Matrix n n ℝ :=
  diagonal (fun c => Real.sqrt (D c)) * K * diagonal (fun c => Real.sqrt (D c))

theorem transfer_apply (D : n → ℝ) (K : Matrix n n ℝ) (c c' : n) :
    transfer D K c c' = Real.sqrt (D c) * K c c' * Real.sqrt (D c') := by
  simp [transfer, mul_apply, diagonal_apply, Finset.sum_mul]

/-- THE TRANSFER MATRIX IS POSITIVE SEMIDEFINITE when K is -/
theorem transfer_posSemidef (D : n → ℝ) (K : Matrix n n ℝ) (hK : K.PosSemidef) :
    (transfer D K).PosSemidef := by
  have h : transfer D K =
      (diagonal (fun c => Real.sqrt (D c)))ᴴ * K * diagonal (fun c => Real.sqrt (D c)) := by
    rw [transfer, conjTranspose_eq_transpose_of_trivial, diagonal_transpose]
  rw [h]
  exact hK.conjTranspose_mul_mul_same _

/-- THE TRANSFER MATRIX IS ENTRYWISE POSITIVE when D and K are -/
theorem transfer_pos (D : n → ℝ) (hD : ∀ c, 0 < D c) (K : Matrix n n ℝ) (hK : ∀ c c', 0 < K c c')
    (c c' : n) : 0 < transfer D K c c' := by
  rw [transfer_apply]
  exact mul_pos (mul_pos (Real.sqrt_pos.mpr (hD c)) (hK c c')) (Real.sqrt_pos.mpr (hD c'))

/-- the slab's Gibbs sum with F at the sites a and a + R: ∏_x D(c_x) ∏_x K(c_x, c_{x+1}) with D(c) = √D(c) · √D(c)
distributed over the chain, so that it is pathSum of M with the end vectors √D and the site weights ins F a R -/
noncomputable def slabNum (D : n → ℝ) (K : Matrix n n ℝ) (F : n → ℝ) (a R : ℕ) : ℝ :=
  pathSum (transfer D K) (ins F a R) (fun c => Real.sqrt (D c)) (fun c => Real.sqrt (D c)) 0 (2 * a + R)

/-- the slab's partition function -/
noncomputable def slabZ (D : n → ℝ) (K : Matrix n n ℝ) (a R : ℕ) : ℝ :=
  pathSum (transfer D K) (fun _ => fun _ => 1) (fun c => Real.sqrt (D c)) (fun c => Real.sqrt (D c)) 0
    (2 * a + R)

end Transfer

section Limit

variable {n : Type*} [Fintype n] [DecidableEq n]

/-- a symmetric matrix's powers are symmetric -/
theorem transpose_pow_eq (M : Matrix n n ℝ) (hM : M.IsHermitian) (k : ℕ) : (M ^ k)ᵀ = M ^ k := by
  rw [transpose_pow]
  have : Mᵀ = M := by
    have h := hM.eq
    rwa [conjTranspose_eq_transpose_of_trivial] at h
  rw [this]

/-- THE PERRON LIMIT: for M symmetric and entrywise positive, M^a v / λ₀^a → ⟨Ω, v⟩ Ω entrywise, Ω the unit Perron
vector, every entry nonzero -/
theorem perron_limit [Nonempty n] (M : Matrix n n ℝ) (hM : M.IsHermitian) (hpos : ∀ i j, 0 < M i j) :
    ∃ Ω : n → ℝ, Ω ⬝ᵥ Ω = 1 ∧ M *ᵥ Ω = lamMax M hM • Ω ∧ (∀ i, Ω i ≠ 0) ∧
      ∀ (v : n → ℝ) (i : n), Tendsto (fun a : ℕ => (M ^ a *ᵥ v) i / lamMax M hM ^ a) atTop
        (𝓝 ((Ω ⬝ᵥ v) * Ω i)) := by
  obtain ⟨i₀, -, hi₀⟩ := Finset.exists_mem_eq_sup' Finset.univ_nonempty hM.eigenvalues
  have hl : hM.eigenvalues i₀ = lamMax M hM := hi₀.symm
  set U : Matrix n n ℝ := (hM.eigenvectorUnitary : Matrix n n ℝ) with hU
  have hstar : star U = Uᵀ := by rw [star_eq_conjTranspose, conjTranspose_eq_transpose_of_trivial]
  have hUU' : star U * U = 1 := Unitary.coe_star_mul_self hM.eigenvectorUnitary
  have hlpos : 0 < lamMax M hM := (perron_exists M hM hpos).choose_spec.2.2
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
  refine ⟨Ω, hnorm, hΩeig, hne, fun v i => ?_⟩
  have hexp : ∀ a : ℕ, (M ^ a *ᵥ v) i / lamMax M hM ^ a =
      ∑ k, U i k * ((hM.eigenvalues k / lamMax M hM) ^ a * (star U *ᵥ v) k) := by
    intro a
    rw [pow_spectral M hM a, ← mulVec_mulVec, ← mulVec_mulVec, ← hU]
    have hdv : diagonal (fun i => hM.eigenvalues i ^ a) *ᵥ (star U *ᵥ v) =
        fun k => hM.eigenvalues k ^ a * (star U *ᵥ v) k := funext fun k => mulVec_diagonal _ _ _
    rw [hdv]
    simp only [mulVec, dotProduct, Finset.sum_div, div_pow]
    apply Finset.sum_congr rfl
    intro k _
    ring
  have hw : (star U *ᵥ v) i₀ = Ω ⬝ᵥ v := by
    simp [mulVec, dotProduct, hstar, transpose_apply, hΩ]
  have hlim : ∀ k, Tendsto (fun a : ℕ => U i k * ((hM.eigenvalues k / lamMax M hM) ^ a *
      (star U *ᵥ v) k)) atTop (𝓝 (if k = i₀ then U i k * (star U *ᵥ v) k else 0)) := by
    intro k
    by_cases hk : k = i₀
    · subst hk
      simp only [hl, div_self hlpos.ne', one_pow, one_mul, if_true]
      exact tendsto_const_nhds
    · rw [if_neg hk]
      have hne' : hM.eigenvalues k ≠ lamMax M hM := fun h =>
        hk (perron_index_unique M hM hpos k i₀ h hl)
      have habs : |hM.eigenvalues k / lamMax M hM| < 1 := by
        rw [abs_div, abs_of_pos hlpos, div_lt_one hlpos]
        exact abs_eigenvalue_lt M hM hpos k hne'
      have := (tendsto_pow_atTop_nhds_zero_of_abs_lt_one habs).mul
        (tendsto_const_nhds (x := (star U *ᵥ v) k))
      have := tendsto_const_nhds (x := U i k) |>.mul this
      simpa using this
  have hsum := tendsto_finsetSum Finset.univ (fun k _ => hlim k)
  rw [Finset.sum_ite_eq' Finset.univ i₀, if_pos (Finset.mem_univ _), hw] at hsum
  refine hsum.congr' ?_ |>.trans ?_
  · exact Filter.Eventually.of_forall fun a => (hexp a).symm
  · rw [mul_comm]

/-- THE INFINITE SLAB: the two-point function of F placed symmetrically in the slab converges to ⟨F Ω, M^R F Ω⟩ / λ₀^R, Ω the unit Perron
vector of the transfer matrix -/
theorem slab_tendsto [Nonempty n] (D : n → ℝ) (hD : ∀ c, 0 < D c) (K : Matrix n n ℝ) (hK : K.PosSemidef)
    (hKpos : ∀ c c', 0 < K c c') (F : n → ℝ) :
    ∃ Ω : n → ℝ, Ω ⬝ᵥ Ω = 1 ∧
      transfer D K *ᵥ Ω = lamMax (transfer D K) (transfer_posSemidef D K hK).1 • Ω ∧ (∀ i, Ω i ≠ 0) ∧
      ∀ R : ℕ, Tendsto (fun a : ℕ => slabNum D K F (a + 1) R / slabZ D K (a + 1) R) atTop
        (𝓝 ((diagonal F *ᵥ Ω) ⬝ᵥ (transfer D K ^ R *ᵥ (diagonal F *ᵥ Ω)) /
          lamMax (transfer D K) (transfer_posSemidef D K hK).1 ^ R)) := by
  set M := transfer D K with hMdef
  have hM : M.IsHermitian := (transfer_posSemidef D K hK).1
  have hpos : ∀ i j, 0 < M i j := transfer_pos D hD K hKpos
  obtain ⟨Ω, hnorm, hΩeig, hne, hlim⟩ := perron_limit M hM hpos
  set l := lamMax M hM with hl
  have hlpos : 0 < l := (perron_exists M hM hpos).choose_spec.2.2
  set d : n → ℝ := fun c => Real.sqrt (D c) with hd
  refine ⟨Ω, hnorm, hΩeig, hne, fun R => ?_⟩
  set X : Matrix n n ℝ := diagonal F * M ^ R * diagonal F with hX
  -- the numerator and the partition function as sandwiches
  have hnum : ∀ a : ℕ, slabNum D K F (a + 1) R = (M ^ (a + 1) *ᵥ d) ⬝ᵥ (X *ᵥ (M ^ (a + 1) *ᵥ d)) := by
    intro a
    simp only [slabNum]
    rw [pathSum_eq_chain, chain_num, ← mulVec_mulVec, ← mulVec_mulVec, dotProduct_mulVec,
      ← mulVec_transpose, transpose_pow_eq M hM]
  have hZ : ∀ a : ℕ, slabZ D K (a + 1) R = (M ^ (a + 1) *ᵥ d) ⬝ᵥ (M ^ R *ᵥ (M ^ (a + 1) *ᵥ d)) := by
    intro a
    simp only [slabZ]
    rw [pathSum_eq_chain, chain_Z, ← mulVec_mulVec, ← mulVec_mulVec, dotProduct_mulVec,
      ← mulVec_transpose, transpose_pow_eq M hM]
  -- the normalised sandwiches as double sums over the normalised vectors
  have hq : ∀ (B : Matrix n n ℝ) (a : ℕ),
      (M ^ (a + 1) *ᵥ d) ⬝ᵥ (B *ᵥ (M ^ (a + 1) *ᵥ d)) / (l ^ (a + 1) * l ^ (a + 1)) =
      ∑ i, ∑ j, ((M ^ (a + 1) *ᵥ d) i / l ^ (a + 1)) * B i j * ((M ^ (a + 1) *ᵥ d) j / l ^ (a + 1)) := by
    intro B a
    set w : n → ℝ := M ^ (a + 1) *ᵥ d with hw
    have hl1 : l ^ (a + 1) ≠ 0 := pow_ne_zero _ hlpos.ne'
    simp only [dotProduct, mulVec, Finset.mul_sum, Finset.sum_div]
    apply Finset.sum_congr rfl
    intro i _
    apply Finset.sum_congr rfl
    intro j _
    field_simp
  have hqlim : ∀ B : Matrix n n ℝ, Tendsto (fun a : ℕ =>
      (M ^ (a + 1) *ᵥ d) ⬝ᵥ (B *ᵥ (M ^ (a + 1) *ᵥ d)) / (l ^ (a + 1) * l ^ (a + 1))) atTop
      (𝓝 ((Ω ⬝ᵥ d) * (Ω ⬝ᵥ d) * (Ω ⬝ᵥ (B *ᵥ Ω)))) := by
    intro B
    have h1 : ∀ i, Tendsto (fun a : ℕ => (M ^ (a + 1) *ᵥ d) i / l ^ (a + 1)) atTop
        (𝓝 ((Ω ⬝ᵥ d) * Ω i)) := fun i => (hlim d i).comp (tendsto_add_atTop_nat 1)
    have h2 : Tendsto (fun a : ℕ => ∑ i, ∑ j, ((M ^ (a + 1) *ᵥ d) i / l ^ (a + 1)) * B i j *
        ((M ^ (a + 1) *ᵥ d) j / l ^ (a + 1))) atTop
        (𝓝 (∑ i, ∑ j, ((Ω ⬝ᵥ d) * Ω i) * B i j * ((Ω ⬝ᵥ d) * Ω j))) := by
      apply tendsto_finsetSum
      intro i _
      apply tendsto_finsetSum
      intro j _
      exact ((h1 i).mul tendsto_const_nhds).mul (h1 j)
    have h3 : (∑ i, ∑ j, ((Ω ⬝ᵥ d) * Ω i) * B i j * ((Ω ⬝ᵥ d) * Ω j)) =
        (Ω ⬝ᵥ d) * (Ω ⬝ᵥ d) * (Ω ⬝ᵥ (B *ᵥ Ω)) := by
      set s : ℝ := Ω ⬝ᵥ d with hs
      simp only [dotProduct, mulVec, Finset.mul_sum]
      apply Finset.sum_congr rfl
      intro i _
      apply Finset.sum_congr rfl
      intro j _
      ring
    rw [h3] at h2
    exact h2.congr' (Filter.Eventually.of_forall fun a => (hq B a).symm)
  -- ⟨Ω, M^R Ω⟩ = l^R and ⟨Ω, X Ω⟩ = ⟨F Ω, M^R F Ω⟩
  have hpowΩ : ∀ k : ℕ, M ^ k *ᵥ Ω = l ^ k • Ω := by
    intro k
    induction k with
    | zero => simp
    | succ k ih => rw [pow_succ', ← mulVec_mulVec, ih, mulVec_smul, hΩeig, smul_smul, pow_succ]
  have hΩMR : Ω ⬝ᵥ (M ^ R *ᵥ Ω) = l ^ R := by
    rw [hpowΩ, dotProduct_smul, hnorm, smul_eq_mul, mul_one]
  have hΩX : Ω ⬝ᵥ (X *ᵥ Ω) = (diagonal F *ᵥ Ω) ⬝ᵥ (M ^ R *ᵥ (diagonal F *ᵥ Ω)) := by
    rw [hX, ← mulVec_mulVec, ← mulVec_mulVec, dotProduct_mulVec, ← mulVec_transpose,
      diagonal_transpose]
  have hΩd : (Ω ⬝ᵥ d) ≠ 0 := by
    have hΩsign := perron_simple M hM hpos
    obtain ⟨p, hppos, hp, -⟩ := perron_exists M hM hpos
    obtain ⟨c, hc⟩ := hΩsign p hppos hp Ω hΩeig
    have hc0 : c ≠ 0 := by
      intro h0
      have := hne (Classical.arbitrary n)
      rw [hc, h0, zero_smul] at this
      exact this rfl
    rw [hc, smul_dotProduct, smul_eq_mul]
    apply mul_ne_zero hc0
    apply ne_of_gt
    apply Finset.sum_pos
    · intro i _
      exact mul_pos (hppos i) (Real.sqrt_pos.mpr (hD i))
    · exact Finset.univ_nonempty
  have hden : (Ω ⬝ᵥ d) * (Ω ⬝ᵥ d) * (Ω ⬝ᵥ (M ^ R *ᵥ Ω)) ≠ 0 := by
    rw [hΩMR]
    exact mul_ne_zero (mul_ne_zero hΩd hΩd) (pow_ne_zero _ hlpos.ne')
  have hratio : ∀ a : ℕ, slabNum D K F (a + 1) R / slabZ D K (a + 1) R =
      ((M ^ (a + 1) *ᵥ d) ⬝ᵥ (X *ᵥ (M ^ (a + 1) *ᵥ d)) / (l ^ (a + 1) * l ^ (a + 1))) /
      ((M ^ (a + 1) *ᵥ d) ⬝ᵥ (M ^ R *ᵥ (M ^ (a + 1) *ᵥ d)) / (l ^ (a + 1) * l ^ (a + 1))) := by
    intro a
    rw [hnum, hZ, div_div_div_cancel_right₀ (mul_ne_zero (pow_ne_zero _ hlpos.ne') (pow_ne_zero _ hlpos.ne'))]
  have hmain := (hqlim X).div (hqlim (M ^ R)) hden
  have hmain' := hmain.congr' (Filter.Eventually.of_forall fun a => (hratio a).symm)
  have hval : (Ω ⬝ᵥ d) * (Ω ⬝ᵥ d) * (Ω ⬝ᵥ (X *ᵥ Ω)) / ((Ω ⬝ᵥ d) * (Ω ⬝ᵥ d) * (Ω ⬝ᵥ (M ^ R *ᵥ Ω))) =
      (diagonal F *ᵥ Ω) ⬝ᵥ (M ^ R *ᵥ (diagonal F *ᵥ Ω)) / l ^ R := by
    rw [hΩMR, hΩX, mul_div_mul_left _ _ (mul_ne_zero hΩd hΩd)]
  rw [hval] at hmain'
  exact hmain'

/-- THE STRING TENSION OF THE SLAB MODEL EXISTS, EVERY FINITE GROUP: the infinite-slab two-point function of F is
W(R) = ⟨F Ω, M^R F Ω⟩ / λ₀^R at every R, and when W(1) > 0 the sequence log λ₀ − log ⟨F Ω, M^R F Ω⟩ / R, which is
−log W(R) / R, converges to a σ ≥ 0 -/
theorem string_tension_of_slab [Nonempty n] (D : n → ℝ) (hD : ∀ c, 0 < D c) (K : Matrix n n ℝ)
    (hK : K.PosSemidef) (hKpos : ∀ c c', 0 < K c c') (F : n → ℝ) :
    ∃ Ω : n → ℝ, Ω ⬝ᵥ Ω = 1 ∧ (∀ i, Ω i ≠ 0) ∧
      (∀ R : ℕ, Tendsto (fun a : ℕ => slabNum D K F (a + 1) R / slabZ D K (a + 1) R) atTop
        (𝓝 ((diagonal F *ᵥ Ω) ⬝ᵥ (transfer D K ^ R *ᵥ (diagonal F *ᵥ Ω)) /
          lamMax (transfer D K) (transfer_posSemidef D K hK).1 ^ R))) ∧
      (0 < (diagonal F *ᵥ Ω) ⬝ᵥ (transfer D K *ᵥ (diagonal F *ᵥ Ω)) →
        ∃ σ : ℝ, 0 ≤ σ ∧ Tendsto (fun R : ℕ =>
          Real.log (lamMax (transfer D K) (transfer_posSemidef D K hK).1) -
            Real.log ((diagonal F *ᵥ Ω) ⬝ᵥ (transfer D K ^ R *ᵥ (diagonal F *ᵥ Ω))) / R) atTop (𝓝 σ)) := by
  obtain ⟨Ω, hnorm, -, hne, hlim⟩ := slab_tendsto D hD K hK hKpos F
  refine ⟨Ω, hnorm, hne, hlim, fun hpos1 => ?_⟩
  exact string_tension_nonneg_of_transfer (transfer D K) (transfer_posSemidef D K hK) (diagonal F *ᵥ Ω) hpos1

end Limit


section Z2

/-- the Z₂ link kernel k(a, b) = 1 + y s(a) s(b), s the sign of a bit: the x-plaquette's weight 1 + y χ in the
tanh form, the hypothesis of Griffiths.lean's measure -/
def z2k (y : ℝ) : Matrix Bool Bool ℝ :=
  fun a b => 1 + y * (if a then -1 else 1) * (if b then -1 else 1)

/-- THE Z₂ LINK KERNEL IS POSITIVE SEMIDEFINITE for 0 ≤ y: it is the Gram matrix of (1, 1) and (√y, −√y) -/
theorem z2k_posSemidef (y : ℝ) (hy : 0 ≤ y) : (z2k y).PosSemidef := by
  apply posSemidef_of_gram (z2k y)
    (fun j : Fin 2 => fun a => if j = 0 then 1 else Real.sqrt y * (if a then -1 else 1))
  intro a b
  simp only [z2k, Fin.sum_univ_two]
  simp only [Fin.isValue, if_true, show (1 : Fin 2) ≠ 0 by decide, if_false]
  have h := Real.mul_self_sqrt hy
  cases a <;> cases b <;> simp <;> nlinarith [h]

/-- THE Z₂ LINK KERNEL IS POSITIVE for 0 ≤ y < 1 -/
theorem z2k_pos (y : ℝ) (hy0 : 0 ≤ y) (hy1 : y < 1) (a b : Bool) : 0 < z2k y a b := by
  simp only [z2k]
  cases a <;> cases b <;> simp <;> linarith

end Z2

end Aperanton
