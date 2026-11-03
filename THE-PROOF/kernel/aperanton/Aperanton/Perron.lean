/-
  APERANTON -- THE BOUNDLESS, stage A4 (second landing): THE PERRON HALF OF THE TRANSFER THEOREM.

  For an entrywise-positive real symmetric matrix T -- the transfer matrix of a finite-group lattice gauge theory in a
  magnetic sector, every Boltzmann weight positive, symmetric at even time (ΑΝΤΑΥΓΕΙΑ T-22) -- the top eigenvalue λ₀
  is simple, carries a strictly positive eigenvector, is fixed by every nonnegative orthogonal symmetry commuting with
  T, and strictly dominates every other eigenvalue in absolute value.  Hence tr(T^L) = λ₀^L (1 + r_L) with
  |r_L| ≤ (dim − 1) ρ^L for a ρ < 1: MECHANISM T's residual theorem (ΤΕΛΕΥΤΗ T-135, ΑΛΜΑ T-140), the exact rate at
  which a finite reading reaches its limit; the correction of order (λ₁/λ₀)^L that ΤΟΜΕΥΣ' §0 names is bounded by the
  spectral gap ΤΟΜΕΥΣ computes, and its `LAMBDA0 chi=0 w=1` line is forced: the vacuum lies in the trivial sector.

  Perron 1907 is classical (W = 0); Mathlib v4.35.0 carries the definitions of an irreducible and a primitive matrix
  (Matrix.IsIrreducible, Matrix.IsPrimitive) and not the theorem.  Proved here from the Rayleigh bound through
  Mathlib's spectral theorem, at the level of dot products; no sorry, no axiom, no native_decide.
-/
import Mathlib
import Aperanton.Transfer

open Matrix Filter Topology

namespace Aperanton

variable {n : Type*} [Fintype n] [DecidableEq n]

omit [DecidableEq n] in
/-- an entrywise-nonnegative form does not decrease when the vector is replaced by its absolute value -/
theorem dot_mulVec_le_abs (T : Matrix n n ℝ) (hT : ∀ i j, 0 ≤ T i j) (v : n → ℝ) :
    v ⬝ᵥ (T *ᵥ v) ≤ (fun i => |v i|) ⬝ᵥ (T *ᵥ fun i => |v i|) := by
  simp only [dotProduct, mulVec, Finset.mul_sum]
  apply Finset.sum_le_sum; intro i _
  apply Finset.sum_le_sum; intro j _
  calc v i * (T i j * v j) ≤ |v i * (T i j * v j)| := le_abs_self _
    _ = |v i| * (T i j * |v j|) := by rw [abs_mul, abs_mul, abs_of_nonneg (hT i j)]

omit [DecidableEq n] in
theorem abs_dot_abs (v : n → ℝ) : (fun i => |v i|) ⬝ᵥ (fun i => |v i|) = v ⬝ᵥ v := by
  simp [dotProduct, abs_mul_abs_self]

omit [DecidableEq n] in
theorem dot_self_pos (w : n → ℝ) (hw0 : w ≠ 0) : 0 < w ⬝ᵥ w := by
  obtain ⟨j, hj⟩ : ∃ j, w j ≠ 0 := by
    by_contra h; push Not at h; exact hw0 (funext h)
  simp only [dotProduct]
  have h1 : w j * w j ≤ ∑ k, w k * w k :=
    Finset.single_le_sum (f := fun k => w k * w k) (fun k _ => mul_self_nonneg (w k)) (Finset.mem_univ j)
  exact lt_of_lt_of_le (mul_self_pos.mpr hj) h1

omit [DecidableEq n] in
/-- a nonnegative nonzero eigenvector of an entrywise-positive matrix is strictly positive, and so is its eigenvalue -/
theorem pos_of_nonneg_eigvec (T : Matrix n n ℝ) (hT : ∀ i j, 0 < T i j) (a : n → ℝ) (ha : ∀ i, 0 ≤ a i)
    (ha0 : a ≠ 0) (μ : ℝ) (hμ : T *ᵥ a = μ • a) : (∀ i, 0 < a i) ∧ 0 < μ := by
  obtain ⟨j, hj⟩ : ∃ j, a j ≠ 0 := by
    by_contra h; push Not at h; exact ha0 (funext h)
  have hj' : 0 < a j := lt_of_le_of_ne (ha j) (Ne.symm hj)
  have hpos : ∀ i, 0 < (T *ᵥ a) i := by
    intro i
    simp only [mulVec, dotProduct]
    have h1 : T i j * a j ≤ ∑ k, T i k * a k :=
      Finset.single_le_sum (f := fun k => T i k * a k) (fun k _ => mul_nonneg (le_of_lt (hT i k)) (ha k))
        (Finset.mem_univ j)
    exact lt_of_lt_of_le (mul_pos (hT i j) hj') h1
  have hall : ∀ i, 0 < a i := by
    intro i
    have h := hpos i
    rw [hμ] at h
    simp only [Pi.smul_apply, smul_eq_mul] at h
    rcases lt_or_eq_of_le (ha i) with hlt | heq
    · exact hlt
    · rw [← heq, mul_zero] at h; exact absurd h (lt_irrefl 0)
  refine ⟨hall, ?_⟩
  have h := hpos j
  rw [hμ] at h
  simp only [Pi.smul_apply, smul_eq_mul] at h
  exact pos_of_mul_pos_left h (le_of_lt (hall j))

/-- the top eigenvalue of a real symmetric matrix -/
noncomputable def lamMax [Nonempty n] (T : Matrix n n ℝ) (hT : T.IsHermitian) : ℝ :=
  Finset.univ.sup' Finset.univ_nonempty hT.eigenvalues

theorem eigenvalues_le_lamMax [Nonempty n] (T : Matrix n n ℝ) (hT : T.IsHermitian) (i : n) :
    hT.eigenvalues i ≤ lamMax T hT :=
  Finset.le_sup' hT.eigenvalues (Finset.mem_univ i)

/-- the quadratic form through the spectral theorem: v ⬝ T v = Σ λ_i w_i² with w = Uᵀ v and w ⬝ w = v ⬝ v -/
theorem quadratic_form_eq (T : Matrix n n ℝ) (hT : T.IsHermitian) (v : n → ℝ) :
    ∃ w : n → ℝ, v ⬝ᵥ (T *ᵥ v) = ∑ i, hT.eigenvalues i * (w i * w i) ∧ w ⬝ᵥ w = v ⬝ᵥ v ∧
      T *ᵥ v = (hT.eigenvectorUnitary : Matrix n n ℝ) *ᵥ (fun i => hT.eigenvalues i * w i) ∧
      v = (hT.eigenvectorUnitary : Matrix n n ℝ) *ᵥ w := by
  set U : Matrix n n ℝ := (hT.eigenvectorUnitary : Matrix n n ℝ) with hU
  have hUU : U * star U = 1 := Unitary.coe_mul_star_self hT.eigenvectorUnitary
  have hstar : star U = Uᵀ := by rw [star_eq_conjTranspose, conjTranspose_eq_transpose_of_trivial]
  have hspec : T = U * diagonal hT.eigenvalues * star U := by
    have h := hT.spectral_theorem
    rw [Unitary.conjStarAlgAut_apply] at h
    simpa [RCLike.ofReal_real_eq_id] using h
  have hw : star U *ᵥ v = v ᵥ* U := by rw [hstar, mulVec_transpose]
  have hnorm : (v ᵥ* U) ⬝ᵥ (star U *ᵥ v) = v ⬝ᵥ v := by
    rw [← dotProduct_mulVec, mulVec_mulVec, hUU, one_mulVec]
  have hTv : T *ᵥ v = U *ᵥ (diagonal hT.eigenvalues *ᵥ (star U *ᵥ v)) := by
    rw [mulVec_mulVec, mulVec_mulVec]
    exact congrArg (fun M => M *ᵥ v) hspec
  refine ⟨star U *ᵥ v, ?_, ?_, ?_, ?_⟩
  · rw [hTv, dotProduct_mulVec, ← hw]
    simp only [dotProduct, mulVec_diagonal]
    apply Finset.sum_congr rfl; intro i _; ring
  · rw [← hnorm]; congr 1
  · rw [hTv]
    congr 1
    ext i; simp [mulVec_diagonal]
  · rw [mulVec_mulVec, hUU, one_mulVec]

/-- THE RAYLEIGH BOUND: v ⬝ T v ≤ λmax · v ⬝ v -/
theorem dot_mulVec_le [Nonempty n] (T : Matrix n n ℝ) (hT : T.IsHermitian) (v : n → ℝ) :
    v ⬝ᵥ (T *ᵥ v) ≤ lamMax T hT * (v ⬝ᵥ v) := by
  obtain ⟨w, h1, h2, -, -⟩ := quadratic_form_eq T hT v
  rw [h1, ← h2, dotProduct, Finset.mul_sum]
  apply Finset.sum_le_sum; intro i _
  exact mul_le_mul_of_nonneg_right (eigenvalues_le_lamMax T hT i) (mul_self_nonneg (w i))

/-- equality in the Rayleigh bound makes v an eigenvector for λmax -/
theorem eigvec_of_dot_mulVec_eq [Nonempty n] (T : Matrix n n ℝ) (hT : T.IsHermitian) (v : n → ℝ)
    (h : v ⬝ᵥ (T *ᵥ v) = lamMax T hT * (v ⬝ᵥ v)) : T *ᵥ v = lamMax T hT • v := by
  obtain ⟨w, h1, h2, h3, h4⟩ := quadratic_form_eq T hT v
  have hterm : ∀ i, hT.eigenvalues i * w i = lamMax T hT * w i := by
    have hs : ∑ i, (lamMax T hT - hT.eigenvalues i) * (w i * w i) = 0 := by
      have h' := h
      rw [h1, ← h2] at h'
      simp only [dotProduct] at h'
      simp only [sub_mul, Finset.sum_sub_distrib, ← Finset.mul_sum]
      linarith
    have hnn : ∀ i ∈ Finset.univ, 0 ≤ (lamMax T hT - hT.eigenvalues i) * (w i * w i) :=
      fun i _ => mul_nonneg (sub_nonneg.mpr (eigenvalues_le_lamMax T hT i)) (mul_self_nonneg _)
    have hz := (Finset.sum_eq_zero_iff_of_nonneg hnn).mp hs
    intro i
    have hi := hz i (Finset.mem_univ i)
    rcases mul_eq_zero.mp hi with h0 | h0
    · rw [sub_eq_zero.mp h0]
    · rw [mul_self_eq_zero.mp h0, mul_zero, mul_zero]
  rw [h3]
  have hfun : (fun i => hT.eigenvalues i * w i) = lamMax T hT • w := by
    ext i; simp [hterm i]
  rw [hfun, mulVec_smul, ← h4]

/-- the absolute value of a λmax-eigenvector is a strictly positive λmax-eigenvector, and λmax > 0 -/
theorem abs_eigvec [Nonempty n] (T : Matrix n n ℝ) (hT : T.IsHermitian) (hpos : ∀ i j, 0 < T i j)
    (w : n → ℝ) (hw0 : w ≠ 0) (hw : T *ᵥ w = lamMax T hT • w) :
    (∀ i, 0 < |w i|) ∧ T *ᵥ (fun i => |w i|) = lamMax T hT • (fun i => |w i|) ∧ 0 < lamMax T hT := by
  have ha0 : (fun i => |w i|) ≠ 0 := by
    intro h; apply hw0; ext i
    have := congrFun h i
    simpa using this
  have hann : ∀ i, 0 ≤ |w i| := fun i => abs_nonneg _
  have heq : (fun i => |w i|) ⬝ᵥ (T *ᵥ fun i => |w i|) = lamMax T hT * ((fun i => |w i|) ⬝ᵥ fun i => |w i|) := by
    apply le_antisymm (dot_mulVec_le T hT _)
    calc lamMax T hT * ((fun i => |w i|) ⬝ᵥ fun i => |w i|) = lamMax T hT * (w ⬝ᵥ w) := by rw [abs_dot_abs]
      _ = w ⬝ᵥ (T *ᵥ w) := by rw [hw, dotProduct_smul, smul_eq_mul]
      _ ≤ (fun i => |w i|) ⬝ᵥ (T *ᵥ fun i => |w i|) := dot_mulVec_le_abs T (fun i j => le_of_lt (hpos i j)) w
  have hae := eigvec_of_dot_mulVec_eq T hT _ heq
  obtain ⟨hapos, hlpos⟩ := pos_of_nonneg_eigvec T hpos _ hann ha0 _ hae
  exact ⟨hapos, hae, hlpos⟩

/-- P1, THE PERRON VECTOR: the top eigenvalue of an entrywise-positive symmetric matrix carries a strictly positive
eigenvector and is itself positive -/
theorem perron_exists [Nonempty n] (T : Matrix n n ℝ) (hT : T.IsHermitian) (hpos : ∀ i j, 0 < T i j) :
    ∃ a : n → ℝ, (∀ i, 0 < a i) ∧ T *ᵥ a = lamMax T hT • a ∧ 0 < lamMax T hT := by
  obtain ⟨i₀, -, hi₀⟩ := Finset.exists_mem_eq_sup' Finset.univ_nonempty hT.eigenvalues
  have he0 : ⇑(hT.eigenvectorBasis i₀) ≠ 0 :=
    (WithLp.ofLp_eq_zero 2).ne.2 (hT.eigenvectorBasis.orthonormal.ne_zero i₀)
  have hev : T *ᵥ ⇑(hT.eigenvectorBasis i₀) = lamMax T hT • ⇑(hT.eigenvectorBasis i₀) := by
    rw [hT.mulVec_eigenvectorBasis i₀]; unfold lamMax; rw [hi₀]
  obtain ⟨h1, h2, h3⟩ := abs_eigvec T hT hpos _ he0 hev
  exact ⟨_, h1, h2, h3⟩

/-- P2, SIMPLICITY: every λmax-eigenvector is a multiple of the Perron vector -/
theorem perron_simple [Nonempty n] (T : Matrix n n ℝ) (hT : T.IsHermitian) (hpos : ∀ i j, 0 < T i j)
    (a : n → ℝ) (hapos : ∀ i, 0 < a i) (ha : T *ᵥ a = lamMax T hT • a)
    (w : n → ℝ) (hw : T *ᵥ w = lamMax T hT • w) : ∃ c : ℝ, w = c • a := by
  obtain ⟨i₀⟩ := ‹Nonempty n›
  refine ⟨w i₀ / a i₀, ?_⟩
  by_contra hne
  have hu_ne : w - (w i₀ / a i₀) • a ≠ 0 := fun h => hne (sub_eq_zero.mp h)
  have huev : T *ᵥ (w - (w i₀ / a i₀) • a) = lamMax T hT • (w - (w i₀ / a i₀) • a) := by
    rw [mulVec_sub, mulVec_smul, hw, ha, smul_sub, smul_comm (w i₀ / a i₀) (lamMax T hT) a]
  have hu0 : (w - (w i₀ / a i₀) • a) i₀ = 0 := by
    simp only [Pi.sub_apply, Pi.smul_apply, smul_eq_mul]
    rw [div_mul_cancel₀ _ (ne_of_gt (hapos i₀)), sub_self]
  have := (abs_eigvec T hT hpos _ hu_ne huev).1 i₀
  rw [hu0, abs_zero] at this
  exact lt_irrefl 0 this

/-- every symmetry commuting with T keeps the Perron line -/
theorem perron_line_invariant [Nonempty n] (T : Matrix n n ℝ) (hT : T.IsHermitian) (hpos : ∀ i j, 0 < T i j)
    (a : n → ℝ) (hapos : ∀ i, 0 < a i) (ha : T *ᵥ a = lamMax T hT • a)
    (P : Matrix n n ℝ) (hP : P * T = T * P) : ∃ c : ℝ, P *ᵥ a = c • a := by
  apply perron_simple T hT hpos a hapos ha
  rw [mulVec_mulVec, ← hP, ← mulVec_mulVec, ha, mulVec_smul]

/-- THE VACUUM IS IN THE TRIVIAL SECTOR: a nonnegative orthogonal symmetry commuting with T (a permutation of the
configurations: the translations and the point symmetries of the torus, the centre shifts) fixes the Perron vector -/
theorem perron_symmetric [Nonempty n] (T : Matrix n n ℝ) (hT : T.IsHermitian) (hpos : ∀ i j, 0 < T i j)
    (a : n → ℝ) (hapos : ∀ i, 0 < a i) (ha : T *ᵥ a = lamMax T hT • a)
    (P : Matrix n n ℝ) (hP : P * T = T * P) (hPnn : ∀ i j, 0 ≤ P i j) (hPorth : Pᵀ * P = 1) : P *ᵥ a = a := by
  obtain ⟨c, hc⟩ := perron_line_invariant T hT hpos a hapos ha P hP
  obtain ⟨i₀⟩ := ‹Nonempty n›
  have hPa_nn : 0 ≤ (P *ᵥ a) i₀ := by
    simp only [mulVec, dotProduct]
    exact Finset.sum_nonneg (fun j _ => mul_nonneg (hPnn i₀ j) (le_of_lt (hapos j)))
  have hc_nn : 0 ≤ c := by
    rw [hc] at hPa_nn
    simp only [Pi.smul_apply, smul_eq_mul] at hPa_nn
    by_contra hneg
    push Not at hneg
    have := mul_neg_of_neg_of_pos hneg (hapos i₀)
    linarith
  have hnorm : (P *ᵥ a) ⬝ᵥ (P *ᵥ a) = a ⬝ᵥ a := by
    rw [dotProduct_mulVec, ← mulVec_transpose, mulVec_mulVec, hPorth, one_mulVec]
  rw [hc, smul_dotProduct, dotProduct_smul, smul_eq_mul, smul_eq_mul, ← mul_assoc] at hnorm
  have ha0 : a ≠ 0 := by
    intro h; have := hapos i₀; rw [h] at this; exact lt_irrefl 0 this
  have haa := dot_self_pos a ha0
  have hc2 : c * c = 1 := by
    have h := hnorm
    rw [← one_mul (a ⬝ᵥ a)] at h
    exact mul_right_cancel₀ (ne_of_gt haa) (by simpa using h)
  rcases mul_self_eq_one_iff.mp hc2 with h1 | h1
  · rw [hc, h1, one_smul]
  · rw [h1] at hc_nn; linarith

/-- P3a: every eigenvalue is at most λmax -/
theorem eigenvalue_le_lamMax' [Nonempty n] (T : Matrix n n ℝ) (hT : T.IsHermitian) (w : n → ℝ) (hw0 : w ≠ 0)
    (μ : ℝ) (hw : T *ᵥ w = μ • w) : μ ≤ lamMax T hT := by
  have h := dot_mulVec_le T hT w
  rw [hw, dotProduct_smul, smul_eq_mul] at h
  exact le_of_mul_le_mul_right h (dot_self_pos w hw0)

/-- P3b, STRICT DOMINANCE FROM BELOW: for an entrywise-positive symmetric matrix every eigenvalue exceeds −λmax;
the strict term is the diagonal one at a coordinate where the eigenvector does not vanish -/
theorem neg_lamMax_lt_eigenvalue [Nonempty n] (T : Matrix n n ℝ) (hT : T.IsHermitian) (hpos : ∀ i j, 0 < T i j)
    (w : n → ℝ) (hw0 : w ≠ 0) (μ : ℝ) (hw : T *ᵥ w = μ • w) : -lamMax T hT < μ := by
  obtain ⟨p, hp⟩ : ∃ p, w p ≠ 0 := by
    by_contra h; push Not at h; exact hw0 (funext h)
  have habs : ∀ i j, |w i * (T i j * w j)| = |w i| * (T i j * |w j|) := fun i j => by
    rw [abs_mul, abs_mul, abs_of_nonneg (le_of_lt (hpos i j))]
  have hstrict : -((fun i => |w i|) ⬝ᵥ (T *ᵥ fun i => |w i|)) < w ⬝ᵥ (T *ᵥ w) := by
    simp only [dotProduct, mulVec, Finset.mul_sum, ← Finset.sum_neg_distrib]
    apply Finset.sum_lt_sum
    · intro i _
      apply Finset.sum_le_sum; intro j _
      rw [← habs i j]; exact neg_abs_le _
    · refine ⟨p, Finset.mem_univ p, ?_⟩
      apply Finset.sum_lt_sum
      · intro j _
        rw [← habs p j]; exact neg_abs_le _
      · refine ⟨p, Finset.mem_univ p, ?_⟩
        have h1 : 0 < w p * (T p p * w p) := by
          have : w p * (T p p * w p) = T p p * (w p * w p) := by ring
          rw [this]; exact mul_pos (hpos p p) (mul_self_pos.mpr hp)
        rw [← habs p p, abs_of_pos h1]; linarith
  have hle := dot_mulVec_le T hT (fun i => |w i|)
  rw [abs_dot_abs] at hle
  rw [hw, dotProduct_smul, smul_eq_mul] at hstrict
  have hww := dot_self_pos w hw0
  have : (-lamMax T hT) * (w ⬝ᵥ w) < μ * (w ⬝ᵥ w) := by linarith
  exact lt_of_mul_lt_mul_right this (le_of_lt hww)

/-- P3, STRICT DOMINANCE: every eigenvalue other than λmax is smaller than λmax in absolute value -/
theorem abs_eigenvalue_lt [Nonempty n] (T : Matrix n n ℝ) (hT : T.IsHermitian) (hpos : ∀ i j, 0 < T i j)
    (i : n) (hi : hT.eigenvalues i ≠ lamMax T hT) : |hT.eigenvalues i| < lamMax T hT := by
  have he0 : ⇑(hT.eigenvectorBasis i) ≠ 0 :=
    (WithLp.ofLp_eq_zero 2).ne.2 (hT.eigenvectorBasis.orthonormal.ne_zero i)
  have h2 := neg_lamMax_lt_eigenvalue T hT hpos _ he0 _ (hT.mulVec_eigenvectorBasis i)
  exact abs_lt.mpr ⟨h2, lt_of_le_of_ne (eigenvalues_le_lamMax T hT i) hi⟩

/-- P2 at the eigenvalue list: λmax occurs exactly once among Mathlib's eigenvalues -/
theorem perron_index_unique [Nonempty n] (T : Matrix n n ℝ) (hT : T.IsHermitian) (hpos : ∀ i j, 0 < T i j)
    (i j : n) (hi : hT.eigenvalues i = lamMax T hT) (hj : hT.eigenvalues j = lamMax T hT) : i = j := by
  by_contra hij
  obtain ⟨a, hapos, ha, -⟩ := perron_exists T hT hpos
  have hei : T *ᵥ ⇑(hT.eigenvectorBasis i) = lamMax T hT • ⇑(hT.eigenvectorBasis i) := by
    rw [hT.mulVec_eigenvectorBasis i, hi]
  have hej : T *ᵥ ⇑(hT.eigenvectorBasis j) = lamMax T hT • ⇑(hT.eigenvectorBasis j) := by
    rw [hT.mulVec_eigenvectorBasis j, hj]
  obtain ⟨ci, hci⟩ := perron_simple T hT hpos a hapos ha _ hei
  obtain ⟨cj, hcj⟩ := perron_simple T hT hpos a hapos ha _ hej
  have hei0 : ⇑(hT.eigenvectorBasis i) ≠ 0 :=
    (WithLp.ofLp_eq_zero 2).ne.2 (hT.eigenvectorBasis.orthonormal.ne_zero i)
  have hej0 : ⇑(hT.eigenvectorBasis j) ≠ 0 :=
    (WithLp.ofLp_eq_zero 2).ne.2 (hT.eigenvectorBasis.orthonormal.ne_zero j)
  have horth : ⇑(hT.eigenvectorBasis j) ⬝ᵥ ⇑(hT.eigenvectorBasis i) = 0 := by
    have h : inner ℝ (hT.eigenvectorBasis i) (hT.eigenvectorBasis j) = (0 : ℝ) :=
      hT.eigenvectorBasis.orthonormal.2 hij
    rw [EuclideanSpace.inner_eq_star_dotProduct] at h
    simpa using h
  rw [hci, hcj, smul_dotProduct, dotProduct_smul, smul_eq_mul, smul_eq_mul] at horth
  obtain ⟨i₀⟩ := ‹Nonempty n›
  have ha0 : a ≠ 0 := by
    intro h; have := hapos i₀; rw [h] at this; exact lt_irrefl 0 this
  have haa := ne_of_gt (dot_self_pos a ha0)
  rcases mul_eq_zero.mp horth with h | h
  · apply hej0; rw [hcj, h, zero_smul]
  · rcases mul_eq_zero.mp h with h' | h'
    · apply hei0; rw [hci, h', zero_smul]
    · exact haa h'

/-- the spectral ratio: the largest |λ_i|/λmax off the Perron index, with 0 at the index itself -/
noncomputable def specRatio [Nonempty n] (T : Matrix n n ℝ) (hT : T.IsHermitian) (i₀ : n) : ℝ :=
  Finset.univ.sup' Finset.univ_nonempty (fun i => if i = i₀ then 0 else |hT.eigenvalues i| / lamMax T hT)

/-- MECHANISM T, THE RESIDUAL THEOREM: for an entrywise-positive symmetric T there is a ρ < 1 with
|tr(T^L) − λmax^L| ≤ (dim − 1) (ρ λmax)^L at every L -- the finite reading reaches its limit at the rate of the
spectral gap, and the correction of order (λ₁/λ₀)^L is bounded, not estimated -/
theorem trace_pow_residual [Nonempty n] (T : Matrix n n ℝ) (hT : T.IsHermitian) (hpos : ∀ i j, 0 < T i j) :
    ∃ ρ : ℝ, 0 ≤ ρ ∧ ρ < 1 ∧ ∀ L : ℕ,
      |(T ^ L).trace - lamMax T hT ^ L| ≤ ((Fintype.card n : ℝ) - 1) * (ρ * lamMax T hT) ^ L := by
  obtain ⟨i₀, -, hi₀⟩ := Finset.exists_mem_eq_sup' Finset.univ_nonempty hT.eigenvalues
  have hl : hT.eigenvalues i₀ = lamMax T hT := hi₀.symm
  have hlpos : 0 < lamMax T hT := (perron_exists T hT hpos).choose_spec.2.2
  set f : n → ℝ := fun i => if i = i₀ then 0 else |hT.eigenvalues i| / lamMax T hT with hf
  have hρ_nonneg : 0 ≤ specRatio T hT i₀ := by
    unfold specRatio
    refine le_trans ?_ (Finset.le_sup' f (Finset.mem_univ i₀))
    simp [hf]
  have hρ_lt : specRatio T hT i₀ < 1 := by
    unfold specRatio
    rw [Finset.sup'_lt_iff]
    intro i _
    by_cases h : i = i₀
    · simp [h]
    · simp only [h, if_false]
      rw [div_lt_one hlpos]
      apply abs_eigenvalue_lt T hT hpos i
      intro hcontra
      exact h (perron_index_unique T hT hpos i i₀ hcontra hl)
  have hbound : ∀ i, i ≠ i₀ → |hT.eigenvalues i| ≤ specRatio T hT i₀ * lamMax T hT := by
    intro i hi
    have h1 : |hT.eigenvalues i| / lamMax T hT ≤ specRatio T hT i₀ := by
      unfold specRatio
      refine le_trans ?_ (Finset.le_sup' f (Finset.mem_univ i))
      simp [hf, hi]
    rwa [div_le_iff₀ hlpos] at h1
  refine ⟨specRatio T hT i₀, hρ_nonneg, hρ_lt, fun L => ?_⟩
  rw [trace_pow_eq_sum_eigenvalues_pow T hT L, ← Finset.add_sum_erase Finset.univ _ (Finset.mem_univ i₀), hl,
    add_sub_cancel_left]
  calc |∑ i ∈ Finset.univ.erase i₀, hT.eigenvalues i ^ L|
      ≤ ∑ i ∈ Finset.univ.erase i₀, |hT.eigenvalues i ^ L| := Finset.abs_sum_le_sum_abs _ _
    _ ≤ ∑ i ∈ Finset.univ.erase i₀, (specRatio T hT i₀ * lamMax T hT) ^ L := by
        apply Finset.sum_le_sum; intro i hi
        rw [abs_pow]
        exact pow_le_pow_left₀ (abs_nonneg _) (hbound i (Finset.ne_of_mem_erase hi)) L
    _ = ((Fintype.card n : ℝ) - 1) * (specRatio T hT i₀ * lamMax T hT) ^ L := by
        rw [Finset.sum_const, Finset.card_erase_of_mem (Finset.mem_univ i₀), Finset.card_univ, nsmul_eq_mul,
          Nat.cast_sub Fintype.card_pos, Nat.cast_one]

/-- THE LEAP: tr(T^L)/λmax^L → 1 -- the finite reading converges to its limit, and the previous theorem is its rate -/
theorem trace_pow_div_tendsto [Nonempty n] (T : Matrix n n ℝ) (hT : T.IsHermitian) (hpos : ∀ i j, 0 < T i j) :
    Tendsto (fun L : ℕ => (T ^ L).trace / lamMax T hT ^ L) atTop (𝓝 1) := by
  obtain ⟨ρ, h0, h1, hb⟩ := trace_pow_residual T hT hpos
  have hlpos : 0 < lamMax T hT := (perron_exists T hT hpos).choose_spec.2.2
  rw [← tendsto_sub_nhds_zero_iff, tendsto_zero_iff_abs_tendsto_zero]
  refine squeeze_zero (g := fun L : ℕ => ((Fintype.card n : ℝ) - 1) * ρ ^ L) (fun L => abs_nonneg _)
    (fun L => ?_) ?_
  · have hlam : 0 < lamMax T hT ^ L := pow_pos hlpos L
    show |(T ^ L).trace / lamMax T hT ^ L - 1| ≤ ((Fintype.card n : ℝ) - 1) * ρ ^ L
    rw [div_sub_one (ne_of_gt hlam), abs_div, abs_of_pos hlam, div_le_iff₀ hlam]
    calc |(T ^ L).trace - lamMax T hT ^ L| ≤ ((Fintype.card n : ℝ) - 1) * (ρ * lamMax T hT) ^ L := hb L
      _ = ((Fintype.card n : ℝ) - 1) * ρ ^ L * lamMax T hT ^ L := by rw [mul_pow]; ring
  · have := (tendsto_pow_atTop_nhds_zero_of_lt_one h0 h1).const_mul ((Fintype.card n : ℝ) - 1)
    simpa using this

end Aperanton
