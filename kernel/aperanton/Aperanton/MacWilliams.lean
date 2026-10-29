/-
  APERANTON -- THE BOUNDLESS, stage A2: THE MEET IN GENERAL FORM -- MACWILLIAMS FOR COSETS OF A BINARY CODE.

  For a binary linear code K ≤ F₂^n and a word w, the coset weight enumerator  W_{w+K}(X) = Σ_{c ∈ K} X^{wt(w+c)}
  satisfies  |K^⊥| · W_{w+K}(X) = Σ_{u ∈ K^⊥} (−1)^{u·w} (1 − X)^{wt u} (1 + X)^{n − wt u}.
  The proof is the character sum over the dual code: Σ_{u ∈ K^⊥} (−1)^{u·v} = |K^⊥| [v ∈ K^⊥⊥] and K^⊥⊥ = K
  (Mathlib's `orthogonal_orthogonal` for the nondegenerate symmetric dot product on F₂^n), then the product over
  coordinates.  Α0's T3 (THE MEET of ΞΕΝΟΔΟΧΙΑ's flux record, kernel-checked at 2 × 2 × 2) is the instance with
  K = im δ¹ and K^⊥ = Z₂(Λ).  MacWilliams 1963 is classical (W = 0); Mathlib carries the orthogonality of
  bilinear forms and not the identity.  No sorry, no axiom.
-/
import Mathlib
import Aperanton.TheoremT

open Polynomial Finset Matrix

namespace Aperanton

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- the sign of a bit: 0 ↦ 1, 1 ↦ −1 -/
def sgn2 (b : ZMod 2) : ℤ := if b = 0 then 1 else -1

theorem sgn2_zero : sgn2 0 = 1 := rfl

theorem sgn2_add (a b : ZMod 2) : sgn2 (a + b) = sgn2 a * sgn2 b := by
  fin_cases a <;> fin_cases b <;> decide

theorem sgn2_sum {α : Type*} (s : Finset α) (f : α → ZMod 2) : sgn2 (∑ i ∈ s, f i) = ∏ i ∈ s, sgn2 (f i) := by
  classical
  induction s using Finset.induction_on with
  | empty => simp [sgn2_zero]
  | @insert a s ha ih => rw [Finset.sum_insert ha, Finset.prod_insert ha, sgn2_add, ih]

theorem sum_zmod2 (f : ZMod 2 → Polynomial ℤ) : ∑ b : ZMod 2, f b = f 0 + f 1 := by
  rw [show (Finset.univ : Finset (ZMod 2)) = {0, 1} by decide, Finset.sum_insert (by decide),
    Finset.sum_singleton]

theorem sum_sgn2_mul (a : ZMod 2) :
    ∑ b : ZMod 2, (Polynomial.C (sgn2 (a * b)) * (X : Polynomial ℤ) ^ (if b ≠ 0 then 1 else 0))
      = 1 + Polynomial.C (sgn2 a) * X := by
  rw [sum_zmod2]
  rcases (by decide : ∀ a : ZMod 2, a = 0 ∨ a = 1) a with rfl | rfl <;> simp [sgn2]

/-- the character of the dot product: (−1)^{u·v} -/
def chi2 (u v : ι → ZMod 2) : ℤ := sgn2 (u ⬝ᵥ v)

theorem chi2_add_left (u u' v : ι → ZMod 2) : chi2 (u + u') v = chi2 u v * chi2 u' v := by
  unfold chi2
  rw [add_dotProduct, sgn2_add]

theorem chi2_add_right (u v v' : ι → ZMod 2) : chi2 u (v + v') = chi2 u v * chi2 u v' := by
  unfold chi2
  rw [dotProduct_add, sgn2_add]

theorem chi2_eq_prod (u v : ι → ZMod 2) : chi2 u v = ∏ i, sgn2 (u i * v i) := by
  unfold chi2 dotProduct
  exact sgn2_sum _ _

/-- the orthogonal of a code under the dot product -/
def orth (K : Submodule (ZMod 2) (ι → ZMod 2)) : Submodule (ZMod 2) (ι → ZMod 2) where
  carrier := {v | ∀ u ∈ K, u ⬝ᵥ v = 0}
  zero_mem' := fun u _ => dotProduct_zero u
  add_mem' := by
    intro v v' hv hv' u hu
    rw [dotProduct_add, hv u hu, hv' u hu, add_zero]
  smul_mem' := by
    intro c v hv u hu
    rw [dotProduct_smul, hv u hu, smul_zero]

theorem mem_orth (K : Submodule (ZMod 2) (ι → ZMod 2)) (v : ι → ZMod 2) :
    v ∈ orth K ↔ ∀ u ∈ K, u ⬝ᵥ v = 0 := Iff.rfl

/-- the dot product as Mathlib's bilinear form, to borrow its double-orthogonal theorem -/
noncomputable def dotForm : LinearMap.BilinForm (ZMod 2) (ι → ZMod 2) := Matrix.toBilin' 1

theorem dotForm_apply (u v : ι → ZMod 2) : dotForm u v = u ⬝ᵥ v := by
  simp [dotForm, Matrix.toBilin'_apply']

theorem orth_eq_orthogonal (K : Submodule (ZMod 2) (ι → ZMod 2)) : orth K = dotForm.orthogonal K := by
  ext v
  rw [mem_orth, LinearMap.BilinForm.mem_orthogonal_iff]
  simp only [dotForm_apply]

theorem dotForm_nondegenerate : (dotForm : LinearMap.BilinForm (ZMod 2) (ι → ZMod 2)).Nondegenerate := by
  have hsep : ∀ v : ι → ZMod 2, (∀ w, dotForm v w = 0) → v = 0 := by
    intro v hv
    funext i
    have := hv (Pi.single i 1)
    rw [dotForm_apply, dotProduct_single, mul_one] at this
    exact this
  show LinearMap.SeparatingLeft _ ∧ LinearMap.SeparatingRight _
  refine ⟨hsep, ?_⟩
  intro v hv
  apply hsep v
  intro w
  rw [dotForm_apply, dotProduct_comm, ← dotForm_apply]
  exact hv w

theorem dotForm_isRefl : (dotForm : LinearMap.BilinForm (ZMod 2) (ι → ZMod 2)).IsRefl := by
  intro u v h
  rw [dotForm_apply] at h ⊢
  rw [dotProduct_comm]
  exact h

/-- THE DOUBLE ORTHOGONAL IS THE CODE: K^⊥⊥ = K -/
theorem orth_orth (K : Submodule (ZMod 2) (ι → ZMod 2)) : orth (orth K) = K := by
  rw [orth_eq_orthogonal, orth_eq_orthogonal]
  exact LinearMap.BilinForm.orthogonal_orthogonal dotForm_nondegenerate dotForm_isRefl K

open Classical in
/-- THE CHARACTER SUM OVER A CODE: Σ_{u ∈ H} (−1)^{u·v} = |H| if v ⊥ H, else 0 -/
theorem sum_chi2 (H : Submodule (ZMod 2) (ι → ZMod 2)) (v : ι → ZMod 2) :
    ∑ u ∈ univ.filter (· ∈ H), chi2 u v
      = if v ∈ orth H then ((univ.filter (· ∈ H)).card : ℤ) else 0 := by
  split_ifs with h
  · rw [mem_orth] at h
    rw [Finset.sum_congr rfl (fun u hu => by
      show chi2 u v = 1
      unfold chi2
      rw [h u (mem_filter.mp hu).2, sgn2_zero]), Finset.sum_const, nsmul_eq_mul, mul_one]
  · rw [mem_orth] at h
    push Not at h
    obtain ⟨u₀, hu₀, hne⟩ := h
    have hsgn : chi2 u₀ v = -1 := by
      unfold chi2 sgn2
      rw [if_neg hne]
    have hinv : ∀ u : ι → ZMod 2, u + u₀ + u₀ = u := by
      intro u
      funext i
      simp only [Pi.add_apply]
      rw [add_assoc, CharTwo.add_self_eq_zero, add_zero]
    have hS : ∑ u ∈ univ.filter (· ∈ H), chi2 u v = ∑ u ∈ univ.filter (· ∈ H), chi2 (u + u₀) v := by
      refine Finset.sum_nbij' (fun u => u + u₀) (fun u => u + u₀) ?_ ?_ ?_ ?_ ?_
      · intro u hu
        rw [Finset.mem_filter] at hu ⊢
        exact ⟨Finset.mem_univ _, H.add_mem hu.2 hu₀⟩
      · intro u hu
        rw [Finset.mem_filter] at hu ⊢
        exact ⟨Finset.mem_univ _, H.add_mem hu.2 hu₀⟩
      · intro u _; exact hinv u
      · intro u _; exact hinv u
      · intro u _; rw [hinv u]
    simp_rw [chi2_add_left, hsgn] at hS
    rw [← Finset.sum_mul] at hS
    linarith

/-- the weight as a sum of indicators -/
theorem wt_eq_sum (v : ι → ZMod 2) : wt v = ∑ i, if v i ≠ 0 then 1 else 0 := by
  unfold wt
  rw [Finset.card_filter]

/-- the weight enumerator of all words against a character factors over the coordinates -/
theorem sum_chi2_pow (u : ι → ZMod 2) :
    ∑ v : ι → ZMod 2, Polynomial.C (chi2 u v) * (X : Polynomial ℤ) ^ wt v
      = (1 - X) ^ wt u * (1 + X) ^ (Fintype.card ι - wt u) := by
  classical
  have hpt : ∀ v : ι → ZMod 2, Polynomial.C (chi2 u v) * (X : Polynomial ℤ) ^ wt v
      = ∏ i, (Polynomial.C (sgn2 (u i * v i)) * X ^ (if v i ≠ 0 then 1 else 0)) := by
    intro v
    rw [Finset.prod_mul_distrib, chi2_eq_prod, map_prod, wt_eq_sum, Finset.prod_pow_eq_pow_sum]
  simp_rw [hpt]
  rw [← Fintype.prod_sum (fun i (b : ZMod 2) => Polynomial.C (sgn2 (u i * b)) * X ^ (if b ≠ 0 then 1 else 0))]
  simp_rw [sum_sgn2_mul]
  have hfac : ∀ i, (1 + Polynomial.C (sgn2 (u i)) * (X : Polynomial ℤ))
      = if u i ≠ 0 then (1 - X) else (1 + X) := by
    intro i
    by_cases h : u i = 0
    · simp [h, sgn2]
    · simp [h, sgn2, sub_eq_add_neg]
  simp_rw [hfac]
  rw [Finset.prod_ite, Finset.prod_const, Finset.prod_const]
  have h1 : (Finset.univ.filter (fun i => u i ≠ 0)).card = wt u := rfl
  have h2 : (Finset.univ.filter (fun i => ¬ u i ≠ 0)).card = Fintype.card ι - wt u := by
    have := Finset.card_filter_add_card_filter_not (s := (Finset.univ : Finset ι)) (fun i => u i ≠ 0)
    rw [Finset.card_univ] at this
    unfold wt
    omega
  rw [h1, h2]

open Classical in
/-- the coset enumerator over all words: Σ_{c ∈ K} X^{wt(w+c)} = Σ_v [v + w ∈ K] X^{wt v} -/
theorem cosetEnum_eq_sum (K : Submodule (ZMod 2) (ι → ZMod 2)) (w : ι → ZMod 2) :
    cosetEnum K w = ∑ v : ι → ZMod 2, if v + w ∈ K then (X : Polynomial ℤ) ^ wt v else 0 := by
  unfold cosetEnum
  rw [← Finset.sum_filter]
  refine Finset.sum_nbij' (fun c => w + c) (fun v => v + w) ?_ ?_ ?_ ?_ ?_
  · intro c hc
    have : w + c + w = c := by
      funext i; simp only [Pi.add_apply]; rw [add_comm (w i), add_assoc, CharTwo.add_self_eq_zero, add_zero]
    rw [Finset.mem_filter] at hc ⊢
    refine ⟨Finset.mem_univ _, ?_⟩
    rw [this]; exact hc.2
  · intro v hv
    rw [Finset.mem_filter] at hv ⊢
    exact ⟨Finset.mem_univ _, hv.2⟩
  · intro c _
    funext i; simp only [Pi.add_apply]; rw [add_comm (w i), add_assoc, CharTwo.add_self_eq_zero, add_zero]
  · intro v _
    funext i; simp only [Pi.add_apply]; rw [add_comm (v i), ← add_assoc, CharTwo.add_self_eq_zero, zero_add]
  · intro c _; rfl

open Classical in
/-- MACWILLIAMS FOR COSETS: |K^⊥| · W_{w+K}(X) = Σ_{u ∈ K^⊥} (−1)^{u·w} (1 − X)^{wt u} (1 + X)^{n − wt u} -/
theorem macwilliams (K : Submodule (ZMod 2) (ι → ZMod 2)) (w : ι → ZMod 2) :
    ((univ.filter (· ∈ orth K)).card : Polynomial ℤ) * cosetEnum K w
      = ∑ u ∈ univ.filter (· ∈ orth K),
          Polynomial.C (chi2 u w) * ((1 - X) ^ wt u * (1 + X) ^ (Fintype.card ι - wt u)) := by
  rw [cosetEnum_eq_sum, Finset.mul_sum]
  -- each word's indicator is the character sum over the dual code
  have hind : ∀ v : ι → ZMod 2,
      ((univ.filter (· ∈ orth K)).card : Polynomial ℤ) * (if v + w ∈ K then (X : Polynomial ℤ) ^ wt v else 0)
        = ∑ u ∈ univ.filter (· ∈ orth K), Polynomial.C (chi2 u v) * Polynomial.C (chi2 u w) * X ^ wt v := by
    intro v
    have h1 := sum_chi2 (orth K) (v + w)
    rw [orth_orth] at h1
    have h2 : ((univ.filter (· ∈ orth K)).card : Polynomial ℤ) * (if v + w ∈ K then (X : Polynomial ℤ) ^ wt v else 0)
        = Polynomial.C (∑ u ∈ univ.filter (· ∈ orth K), chi2 u (v + w)) * X ^ wt v := by
      rw [h1]
      split_ifs
      · rw [map_natCast]
      · rw [map_zero, zero_mul, mul_zero]
    rw [h2, map_sum, Finset.sum_mul]
    apply Finset.sum_congr rfl
    intro u _
    rw [chi2_add_right, map_mul]
  simp_rw [hind]
  rw [Finset.sum_comm]
  apply Finset.sum_congr rfl
  intro u _
  rw [← sum_chi2_pow u, Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro v _
  ring

end Aperanton
