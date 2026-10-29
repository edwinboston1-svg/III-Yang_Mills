/-
  APERANTON -- THE BOUNDLESS, stage A5 (first landing): GRIFFITHS' INEQUALITIES FOR III'S Z₂ WEIGHTS.

  Mechanism S carries a finite reading to infinite volume by subadditivity, and subadditivity of the Wilson loop's
  logarithm is Griffiths' second inequality.  Here the Z₂ gauge measure is written exactly as III writes it --
  spins σ_e = ±1 on links, the plaquette character χ_p(σ) = ∏_{e ∈ p} σ_e, the weight ∏_p (1 + y_p χ_p(σ)) with
  0 ≤ y_p ≤ 1 (the record's (1 ± y) factors) -- and the two inequalities are proved on the finite sums:
    GRIFFITHS I   Σ_σ χ_A(σ) w(σ) ≥ 0,
    GRIFFITHS II  ⟨χ_A χ_B⟩ ≥ ⟨χ_A⟩⟨χ_B⟩,
  by the character expansion (the sum of a character over all configurations is 0 or 2^|E|) and Ginibre's
  duplication (σ' = σ ⊕ τ; each doubled plaquette factor splits into three terms with nonnegative coefficients
  and nonnegative τ-factors).  Griffiths 1967 and Ginibre 1970 are classical (W = 0); Mathlib carries neither.
  No sorry, no axiom, no native_decide.
-/
import Mathlib

open Finset

namespace Aperanton

/-- the spin of a Boolean link variable: false ↦ +1, true ↦ −1, so that sgn is a character of (Bool, xor) -/
def sgn (b : Bool) : ℝ := if b then -1 else 1

@[simp] theorem sgn_true : sgn true = -1 := rfl
@[simp] theorem sgn_false : sgn false = 1 := rfl

theorem sgn_mul_self (b : Bool) : sgn b * sgn b = 1 := by cases b <;> simp [sgn]

theorem sgn_xor (a b : Bool) : sgn (xor a b) = sgn a * sgn b := by
  cases a <;> cases b <;> simp [sgn]

theorem sum_sgn : ∑ b : Bool, sgn b = 0 := by simp [sgn]

variable {E : Type*} [Fintype E] [DecidableEq E]

/-- the character of a link set (an indicator S) at a configuration σ: ∏_{e ∈ S} σ_e -/
def chi (S σ : E → Bool) : ℝ := ∏ e, if S e then sgn (σ e) else 1

/-- the xor of two configurations -/
def xorc (σ τ : E → Bool) : E → Bool := fun e => xor (σ e) (τ e)

theorem chi_mul (S T σ : E → Bool) : chi S σ * chi T σ = chi (fun e => xor (S e) (T e)) σ := by
  unfold chi
  rw [← Finset.prod_mul_distrib]
  apply Finset.prod_congr rfl
  intro e _
  rcases Bool.eq_false_or_eq_true (S e) with h | h <;>
    rcases Bool.eq_false_or_eq_true (T e) with h' | h' <;> simp [h, h', sgn_mul_self]

theorem chi_xorc (S σ τ : E → Bool) : chi S (xorc σ τ) = chi S σ * chi S τ := by
  unfold chi xorc
  rw [← Finset.prod_mul_distrib]
  apply Finset.prod_congr rfl
  intro e _
  cases S e <;> simp [sgn_xor]

theorem chi_mul_self (S σ : E → Bool) : chi S σ * chi S σ = 1 := by
  unfold chi
  rw [← Finset.prod_mul_distrib]
  apply Finset.prod_eq_one
  intro e _
  cases S e <;> simp [sgn_mul_self]

theorem chi_zero (σ : E → Bool) : chi (fun _ => false) σ = 1 := by simp [chi]

theorem chi_eq_one_or_neg_one (S σ : E → Bool) : chi S σ = 1 ∨ chi S σ = -1 :=
  mul_self_eq_one_iff.mp (chi_mul_self S σ)

theorem one_add_chi_nonneg (S σ : E → Bool) : 0 ≤ 1 + chi S σ := by
  rcases chi_eq_one_or_neg_one S σ with h | h <;> rw [h] <;> norm_num

theorem one_sub_chi_nonneg (S σ : E → Bool) : 0 ≤ 1 - chi S σ := by
  rcases chi_eq_one_or_neg_one S σ with h | h <;> rw [h] <;> norm_num

theorem chi_le_one (S σ : E → Bool) : chi S σ ≤ 1 := by
  rcases chi_eq_one_or_neg_one S σ with h | h <;> rw [h] <;> norm_num

/-- ORTHOGONALITY: the sum of a character over all configurations is nonnegative (it is 0 or 2^|E|) -/
theorem sum_chi_nonneg (S : E → Bool) : 0 ≤ ∑ σ : E → Bool, chi S σ := by
  unfold chi
  rw [show (∑ σ : E → Bool, ∏ e, if S e then sgn (σ e) else 1)
      = ∏ e, ∑ b : Bool, (if S e then sgn b else 1) from
    (Fintype.prod_sum fun e (b : Bool) => if S e then sgn b else 1).symm]
  apply Finset.prod_nonneg
  intro e _
  cases h : S e <;> simp [h, sgn]

/-- the sum of all configurations is 2^|E| -/
theorem sum_one_config : ∑ _σ : E → Bool, (1 : ℝ) = (Fintype.card (E → Bool) : ℝ) := by simp

/-- the involution τ ↦ σ ⊕ τ reindexes a sum over configurations -/
theorem sum_xorc (σ : E → Bool) (G : (E → Bool) → ℝ) :
    ∑ σ' : E → Bool, G σ' = ∑ τ : E → Bool, G (xorc σ τ) := by
  have hinv : Function.Involutive (xorc σ) := by
    intro τ
    funext e
    rcases Bool.eq_false_or_eq_true (σ e) with h | h <;>
      rcases Bool.eq_false_or_eq_true (τ e) with h' | h' <;> simp [xorc, h, h']
  exact (Fintype.sum_equiv hinv.toPerm (fun τ => G (xorc σ τ)) G (fun τ => rfl)).symm

variable {P : Type*} [Fintype P] [DecidableEq P]

/-- the sum of a character against any product of plaquette characters is nonnegative -/
theorem sum_chi_prod_nonneg (plaq : P → E → Bool) (t : Finset P) :
    ∀ A : E → Bool, 0 ≤ ∑ σ : E → Bool, chi A σ * ∏ p ∈ t, chi (plaq p) σ := by
  induction t using Finset.induction_on with
  | empty => intro A; simpa using sum_chi_nonneg A
  | @insert p t hp ih =>
    intro A
    have h : ∀ σ : E → Bool, chi A σ * ∏ q ∈ insert p t, chi (plaq q) σ
        = chi (fun e => xor (A e) (plaq p e)) σ * ∏ q ∈ t, chi (plaq q) σ := by
      intro σ
      rw [Finset.prod_insert hp, ← mul_assoc, chi_mul]
    simp_rw [h]
    exact ih _

/-- III's Z₂ weight: ∏_p (1 + y_p χ_p(σ)) -/
def w (plaq : P → E → Bool) (y : P → ℝ) (σ : E → Bool) : ℝ := ∏ p, (1 + y p * chi (plaq p) σ)

theorem w_nonneg (plaq : P → E → Bool) (y : P → ℝ) (hy0 : ∀ p, 0 ≤ y p) (hy1 : ∀ p, y p ≤ 1) (σ : E → Bool) :
    0 ≤ w plaq y σ := by
  unfold w
  apply Finset.prod_nonneg
  intro p _
  rcases chi_eq_one_or_neg_one (plaq p) σ with h | h <;> rw [h] <;> linarith [hy0 p, hy1 p]

/-- THE CHARACTER EXPANSION of the weight: w = Σ_{t ⊆ P} (∏_{p ∈ t} y_p) ∏_{p ∈ t} χ_p -/
theorem w_expand (plaq : P → E → Bool) (y : P → ℝ) (σ : E → Bool) :
    w plaq y σ = ∑ t ∈ (Finset.univ : Finset P).powerset, (∏ p ∈ t, y p) * ∏ p ∈ t, chi (plaq p) σ := by
  unfold w
  simp_rw [add_comm (1 : ℝ)]
  rw [Finset.prod_add]
  apply Finset.sum_congr rfl
  intro t _
  rw [Finset.prod_const_one, mul_one, Finset.prod_mul_distrib]

/-- GRIFFITHS I (unnormalised): Σ_σ χ_A(σ) w(σ) ≥ 0 for nonnegative couplings -/
theorem griffiths_one (plaq : P → E → Bool) (y : P → ℝ) (hy0 : ∀ p, 0 ≤ y p) (A : E → Bool) :
    0 ≤ ∑ σ : E → Bool, chi A σ * w plaq y σ := by
  simp_rw [w_expand, Finset.mul_sum]
  rw [Finset.sum_comm]
  apply Finset.sum_nonneg
  intro t _
  have h1 : ∑ σ : E → Bool, chi A σ * ((∏ p ∈ t, y p) * ∏ p ∈ t, chi (plaq p) σ)
      = (∏ p ∈ t, y p) * ∑ σ : E → Bool, chi A σ * ∏ p ∈ t, chi (plaq p) σ := by
    rw [Finset.mul_sum]
    apply Finset.sum_congr rfl
    intro σ _
    ring
  rw [h1]
  exact mul_nonneg (Finset.prod_nonneg (fun p _ => hy0 p)) (sum_chi_prod_nonneg plaq t A)

/-- the partition function is positive: its empty-set term is 2^|E| and every other term is nonnegative -/
theorem partition_pos (plaq : P → E → Bool) (y : P → ℝ) (hy0 : ∀ p, 0 ≤ y p) :
    0 < ∑ σ : E → Bool, w plaq y σ := by
  simp_rw [w_expand]
  rw [Finset.sum_comm]
  have hterm : ∀ t ∈ (Finset.univ : Finset P).powerset,
      0 ≤ ∑ σ : E → Bool, (∏ p ∈ t, y p) * ∏ p ∈ t, chi (plaq p) σ := by
    intro t _
    rw [← Finset.mul_sum]
    refine mul_nonneg (Finset.prod_nonneg (fun p _ => hy0 p)) ?_
    have := sum_chi_prod_nonneg plaq t (fun _ => false)
    simpa [chi_zero] using this
  have hempty : ∑ σ : E → Bool, (∏ p ∈ (∅ : Finset P), y p) * ∏ p ∈ (∅ : Finset P), chi (plaq p) σ
      = (Fintype.card (E → Bool) : ℝ) := by simp
  have h1 := Finset.single_le_sum hterm (Finset.empty_mem_powerset (Finset.univ : Finset P))
  rw [hempty] at h1
  exact lt_of_lt_of_le (Nat.cast_pos.mpr Fintype.card_pos) h1

/-- one doubled plaquette factor splits into three terms, each a nonnegative coefficient times a nonnegative
τ-factor times at most one σ-character -/
theorem doubled_factor (yp a b : ℝ) (ha : a * a = 1) :
    (1 + yp * a) * (1 + yp * (a * b))
      = (1 + yp ^ 2) / 2 * (1 + b) + (1 - yp ^ 2) / 2 * (1 - b) + yp * (1 + b) * a := by
  linear_combination (yp ^ 2 * b) * ha

/-- the three coefficients of the doubled factor at plaquette p, as functions of τ -/
noncomputable def coef (plaq : P → E → Bool) (y : P → ℝ) (τ : E → Bool) (p : P) : Fin 3 → ℝ :=
  ![(1 + y p ^ 2) / 2 * (1 + chi (plaq p) τ), (1 - y p ^ 2) / 2 * (1 - chi (plaq p) τ),
    y p * (1 + chi (plaq p) τ)]

theorem coef_nonneg (plaq : P → E → Bool) (y : P → ℝ) (hy0 : ∀ p, 0 ≤ y p) (hy1 : ∀ p, y p ≤ 1)
    (τ : E → Bool) (p : P) (c : Fin 3) : 0 ≤ coef plaq y τ p c := by
  have h2 : y p ^ 2 ≤ 1 := pow_le_one₀ (hy0 p) (hy1 p)
  have ha := one_add_chi_nonneg (plaq p) τ
  have hb := one_sub_chi_nonneg (plaq p) τ
  fin_cases c
  · simp only [coef, Matrix.cons_val_zero]
    exact mul_nonneg (by positivity) ha
  · simp only [coef, Matrix.cons_val_one, Matrix.cons_val_zero]
    exact mul_nonneg (by linarith) hb
  · simp only [coef, Matrix.cons_val_two, Matrix.cons_val_one, Matrix.cons_val_zero]
    exact mul_nonneg (hy0 p) ha

theorem doubled_factor_sum (plaq : P → E → Bool) (y : P → ℝ) (σ τ : E → Bool) (p : P) :
    (1 + y p * chi (plaq p) σ) * (1 + y p * (chi (plaq p) σ * chi (plaq p) τ))
      = ∑ c : Fin 3, coef plaq y τ p c * (if c = 2 then chi (plaq p) σ else 1) := by
  rw [Fin.sum_univ_three, doubled_factor (y p) (chi (plaq p) σ) (chi (plaq p) τ) (chi_mul_self _ _)]
  simp [coef]

/-- THE INNER SUM OF THE DUPLICATION IS NONNEGATIVE: for every τ,
Σ_σ χ_C(σ) ∏_p (1 + y_p χ_p(σ))(1 + y_p χ_p(σ)χ_p(τ)) ≥ 0 -/
theorem inner_nonneg (plaq : P → E → Bool) (y : P → ℝ) (hy0 : ∀ p, 0 ≤ y p) (hy1 : ∀ p, y p ≤ 1)
    (C τ : E → Bool) :
    0 ≤ ∑ σ : E → Bool, chi C σ *
      ∏ p, ((1 + y p * chi (plaq p) σ) * (1 + y p * (chi (plaq p) σ * chi (plaq p) τ))) := by
  simp_rw [doubled_factor_sum plaq y _ τ]
  simp_rw [Fintype.prod_sum, Finset.mul_sum]
  rw [Finset.sum_comm]
  apply Finset.sum_nonneg
  intro c _
  have hsplit : ∀ σ : E → Bool, chi C σ * ∏ p, (coef plaq y τ p (c p) * (if c p = 2 then chi (plaq p) σ else 1))
      = (∏ p, coef plaq y τ p (c p)) *
        (chi C σ * ∏ p ∈ Finset.univ.filter (fun p => c p = 2), chi (plaq p) σ) := by
    intro σ
    rw [Finset.prod_mul_distrib, Finset.prod_filter]
    ring
  simp_rw [hsplit]
  rw [← Finset.mul_sum]
  exact mul_nonneg (Finset.prod_nonneg (fun p _ => coef_nonneg plaq y hy0 hy1 τ p (c p)))
    (sum_chi_prod_nonneg plaq _ C)

/-- GRIFFITHS II (unnormalised): (Σ χ_A w)(Σ χ_B w) ≤ (Σ χ_A χ_B w)(Σ w) for couplings in [0, 1] -/
theorem griffiths_two (plaq : P → E → Bool) (y : P → ℝ) (hy0 : ∀ p, 0 ≤ y p) (hy1 : ∀ p, y p ≤ 1)
    (A B : E → Bool) :
    (∑ σ : E → Bool, chi A σ * w plaq y σ) * (∑ σ : E → Bool, chi B σ * w plaq y σ)
      ≤ (∑ σ : E → Bool, chi A σ * chi B σ * w plaq y σ) * (∑ σ : E → Bool, w plaq y σ) := by
  -- the doubled sum D equals 2 (RHS − LHS) and is nonnegative
  have hid : ∑ σ : E → Bool, ∑ σ' : E → Bool,
        (chi A σ - chi A σ') * (chi B σ - chi B σ') * (w plaq y σ * w plaq y σ')
      = 2 * ((∑ σ : E → Bool, chi A σ * chi B σ * w plaq y σ) * (∑ σ : E → Bool, w plaq y σ)
          - (∑ σ : E → Bool, chi A σ * w plaq y σ) * (∑ σ : E → Bool, chi B σ * w plaq y σ)) := by
    have e1 : ∑ σ : E → Bool, ∑ σ' : E → Bool,
          (chi A σ - chi A σ') * (chi B σ - chi B σ') * (w plaq y σ * w plaq y σ')
        = (∑ σ : E → Bool, ∑ σ' : E → Bool,
            (chi A σ * chi B σ * w plaq y σ * w plaq y σ' - chi A σ * w plaq y σ * (chi B σ' * w plaq y σ')))
          + ∑ σ : E → Bool, ∑ σ' : E → Bool,
            (chi A σ' * chi B σ' * w plaq y σ' * w plaq y σ - chi A σ' * w plaq y σ' * (chi B σ * w plaq y σ)) := by
      rw [← Finset.sum_add_distrib]
      apply Finset.sum_congr rfl; intro σ _
      rw [← Finset.sum_add_distrib]
      apply Finset.sum_congr rfl; intro σ' _
      ring
    have e2 : ∑ σ : E → Bool, ∑ σ' : E → Bool,
          (chi A σ' * chi B σ' * w plaq y σ' * w plaq y σ - chi A σ' * w plaq y σ' * (chi B σ * w plaq y σ))
        = ∑ σ : E → Bool, ∑ σ' : E → Bool,
          (chi A σ * chi B σ * w plaq y σ * w plaq y σ' - chi A σ * w plaq y σ * (chi B σ' * w plaq y σ')) :=
      Finset.sum_comm
    have e3 : ∑ σ : E → Bool, ∑ σ' : E → Bool,
          (chi A σ * chi B σ * w plaq y σ * w plaq y σ' - chi A σ * w plaq y σ * (chi B σ' * w plaq y σ'))
        = (∑ σ : E → Bool, chi A σ * chi B σ * w plaq y σ) * (∑ σ : E → Bool, w plaq y σ)
          - (∑ σ : E → Bool, chi A σ * w plaq y σ) * (∑ σ : E → Bool, chi B σ * w plaq y σ) := by
      rw [Finset.sum_mul_sum, Finset.sum_mul_sum, ← Finset.sum_sub_distrib]
      apply Finset.sum_congr rfl; intro σ _
      rw [← Finset.sum_sub_distrib]
    rw [e1, e2, e3]
    ring
  have hnn : 0 ≤ ∑ σ : E → Bool, ∑ σ' : E → Bool,
      (chi A σ - chi A σ') * (chi B σ - chi B σ') * (w plaq y σ * w plaq y σ') := by
    have hre : ∀ σ : E → Bool, ∑ σ' : E → Bool,
          (chi A σ - chi A σ') * (chi B σ - chi B σ') * (w plaq y σ * w plaq y σ')
        = ∑ τ : E → Bool, (chi A σ - chi A (xorc σ τ)) * (chi B σ - chi B (xorc σ τ))
            * (w plaq y σ * w plaq y (xorc σ τ)) :=
      fun σ => sum_xorc σ _
    simp_rw [hre]
    rw [Finset.sum_comm]
    apply Finset.sum_nonneg
    intro τ _
    have hpt : ∑ σ : E → Bool, (chi A σ - chi A (xorc σ τ)) * (chi B σ - chi B (xorc σ τ))
          * (w plaq y σ * w plaq y (xorc σ τ))
        = (1 - chi A τ) * (1 - chi B τ) * ∑ σ : E → Bool, chi (fun e => xor (A e) (B e)) σ *
            ∏ p, ((1 + y p * chi (plaq p) σ) * (1 + y p * (chi (plaq p) σ * chi (plaq p) τ))) := by
      rw [Finset.mul_sum]
      apply Finset.sum_congr rfl
      intro σ _
      rw [← chi_mul, chi_xorc, chi_xorc]
      unfold w
      rw [← Finset.prod_mul_distrib]
      simp_rw [chi_xorc]
      ring
    rw [hpt]
    exact mul_nonneg (mul_nonneg (one_sub_chi_nonneg A τ) (one_sub_chi_nonneg B τ))
      (inner_nonneg plaq y hy0 hy1 _ τ)
  linarith

/-- the expectation of a character -/
noncomputable def expect (plaq : P → E → Bool) (y : P → ℝ) (A : E → Bool) : ℝ :=
  (∑ σ : E → Bool, chi A σ * w plaq y σ) / (∑ σ : E → Bool, w plaq y σ)

theorem expect_nonneg (plaq : P → E → Bool) (y : P → ℝ) (hy0 : ∀ p, 0 ≤ y p) (A : E → Bool) :
    0 ≤ expect plaq y A :=
  div_nonneg (griffiths_one plaq y hy0 A) (le_of_lt (partition_pos plaq y hy0))

theorem expect_le_one (plaq : P → E → Bool) (y : P → ℝ) (hy0 : ∀ p, 0 ≤ y p) (hy1 : ∀ p, y p ≤ 1)
    (A : E → Bool) : expect plaq y A ≤ 1 := by
  unfold expect
  rw [div_le_one (partition_pos plaq y hy0)]
  apply Finset.sum_le_sum
  intro σ _
  calc chi A σ * w plaq y σ ≤ 1 * w plaq y σ :=
        mul_le_mul_of_nonneg_right (chi_le_one A σ) (w_nonneg plaq y hy0 hy1 σ)
    _ = w plaq y σ := one_mul _

/-- GRIFFITHS II: ⟨χ_A⟩⟨χ_B⟩ ≤ ⟨χ_{A ⊕ B}⟩ -- the Wilson loop of a union of two adjacent loops is at least the
product of the two loops', the subadditivity Mechanism S stands on -/
theorem griffiths_two_expect (plaq : P → E → Bool) (y : P → ℝ) (hy0 : ∀ p, 0 ≤ y p) (hy1 : ∀ p, y p ≤ 1)
    (A B : E → Bool) :
    expect plaq y A * expect plaq y B ≤ expect plaq y (fun e => xor (A e) (B e)) := by
  have hZ := partition_pos plaq y hy0
  have h := griffiths_two plaq y hy0 hy1 A B
  simp_rw [chi_mul] at h
  unfold expect
  rw [div_mul_div_comm, div_le_div_iff₀ (mul_pos hZ hZ) hZ]
  calc (∑ σ : E → Bool, chi A σ * w plaq y σ) * (∑ σ : E → Bool, chi B σ * w plaq y σ) * (∑ σ : E → Bool, w plaq y σ)
      ≤ (∑ σ : E → Bool, chi (fun e => xor (A e) (B e)) σ * w plaq y σ) * (∑ σ : E → Bool, w plaq y σ)
          * (∑ σ : E → Bool, w plaq y σ) := mul_le_mul_of_nonneg_right h (le_of_lt hZ)
    _ = (∑ σ : E → Bool, chi (fun e => xor (A e) (B e)) σ * w plaq y σ)
          * ((∑ σ : E → Bool, w plaq y σ) * (∑ σ : E → Bool, w plaq y σ)) := by ring

/-! ### The character expansion in closed form, and monotonicity in the couplings -/

/-- EXACT ORTHOGONALITY: the sum of a character over all configurations is 2^|E| at the empty set and 0 elsewhere -/
theorem sum_chi_eq (S : E → Bool) :
    ∑ σ : E → Bool, chi S σ = if S = (fun _ => false) then (2 : ℝ) ^ Fintype.card E else 0 := by
  unfold chi
  rw [show (∑ σ : E → Bool, ∏ e, if S e then sgn (σ e) else 1)
      = ∏ e, ∑ b : Bool, (if S e then sgn b else 1) from
    (Fintype.prod_sum fun e (b : Bool) => if S e then sgn b else 1).symm]
  by_cases hS : S = fun _ => false
  · subst hS; simp
  · rw [if_neg hS]
    obtain ⟨e₀, he₀⟩ : ∃ e, S e = true := by
      by_contra h
      push Not at h
      apply hS
      funext e
      simpa using h e
    apply Finset.prod_eq_zero (Finset.mem_univ e₀)
    simp [he₀, sgn]

/-- the boundary of a set of plaquettes: the links covered an odd number of times -/
def bd (plaq : P → E → Bool) (t : Finset P) : E → Bool :=
  fun e => decide (Odd (t.filter (fun p => plaq p e = true)).card)

theorem bd_empty (plaq : P → E → Bool) : bd plaq ∅ = fun _ => false := by
  funext e; simp [bd]

theorem bd_insert (plaq : P → E → Bool) (p : P) (t : Finset P) (hp : p ∉ t) :
    bd plaq (insert p t) = fun e => xor (plaq p e) (bd plaq t e) := by
  funext e
  simp only [bd]
  by_cases h : plaq p e = true
  · have hp' : p ∉ t.filter (fun q => plaq q e = true) := fun h' => hp (Finset.mem_filter.mp h').1
    rw [Finset.filter_insert, if_pos h, Finset.card_insert_of_notMem hp', h, Bool.true_xor, ← decide_not,
      decide_eq_decide]
    exact Nat.odd_add_one
  · rw [Finset.filter_insert, if_neg h]
    simp [h]

/-- a product of plaquette characters is the character of the boundary -/
theorem prod_chi_eq_chi_bd (plaq : P → E → Bool) (t : Finset P) (σ : E → Bool) :
    ∏ p ∈ t, chi (plaq p) σ = chi (bd plaq t) σ := by
  induction t using Finset.induction_on with
  | empty => simp [bd_empty, chi_zero]
  | @insert p t hp ih => rw [Finset.prod_insert hp, ih, chi_mul, bd_insert plaq p t hp]

/-- THE CHARACTER EXPANSION IN CLOSED FORM: Σ_σ χ_A w = 2^|E| Σ_{t : ∂t = A} ∏_{p ∈ t} y_p -/
theorem sum_chi_w_eq (plaq : P → E → Bool) (y : P → ℝ) (A : E → Bool) :
    ∑ σ : E → Bool, chi A σ * w plaq y σ
      = (2 : ℝ) ^ Fintype.card E *
        ∑ t ∈ (Finset.univ : Finset P).powerset, if bd plaq t = A then ∏ p ∈ t, y p else 0 := by
  simp_rw [w_expand, Finset.mul_sum]
  rw [Finset.sum_comm]
  apply Finset.sum_congr rfl
  intro t _
  have h1 : ∀ σ : E → Bool, chi A σ * ((∏ p ∈ t, y p) * ∏ p ∈ t, chi (plaq p) σ)
      = (∏ p ∈ t, y p) * chi (fun e => xor (A e) (bd plaq t e)) σ := by
    intro σ
    rw [prod_chi_eq_chi_bd, ← chi_mul]
    ring
  simp_rw [h1]
  rw [← Finset.mul_sum, sum_chi_eq]
  have hiff : ((fun e => xor (A e) (bd plaq t e)) = fun _ => false) ↔ bd plaq t = A := by
    constructor
    · intro h
      funext e
      have he := congrFun h e
      rcases Bool.eq_false_or_eq_true (A e) with ha | ha <;>
        rcases Bool.eq_false_or_eq_true (bd plaq t e) with hb | hb <;> simp_all
    · intro h
      funext e
      rw [h]
      simp
  by_cases h : bd plaq t = A
  · rw [if_pos (hiff.mpr h), if_pos h]; ring
  · rw [if_neg (fun h' => h (hiff.mp h')), if_neg h]; ring

/-- the Wilson expectation in combinatorial form: surfaces bounded by A over closed surfaces, both inside Λ -/
noncomputable def Wc (plaq : P → E → Bool) (y : P → ℝ) (Λ : Finset P) (A : E → Bool) : ℝ :=
  (∑ t ∈ Λ.powerset, if bd plaq t = A then ∏ p ∈ t, y p else 0)
    / (∑ t ∈ Λ.powerset, if bd plaq t = (fun _ => false) then ∏ p ∈ t, y p else 0)

/-- THE TWO FORMS AGREE: the configuration expectation is the combinatorial Wilson expectation over all plaquettes -/
theorem expect_eq_Wc (plaq : P → E → Bool) (y : P → ℝ) (A : E → Bool) :
    expect plaq y A = Wc plaq y Finset.univ A := by
  unfold expect Wc
  have hnum := sum_chi_w_eq plaq y A
  have hden := sum_chi_w_eq plaq y (fun _ => false)
  simp only [chi_zero, one_mul] at hden
  rw [hnum, hden, mul_div_mul_left _ _ (by positivity : (2 : ℝ) ^ Fintype.card E ≠ 0)]

/-- the weight with one coupling replaced factors through the weight with that coupling removed -/
theorem w_update (plaq : P → E → Bool) (y : P → ℝ) (p₀ : P) (a : ℝ) (σ : E → Bool) :
    w plaq (Function.update y p₀ a) σ
      = (1 + a * chi (plaq p₀) σ) * w plaq (Function.update y p₀ 0) σ := by
  unfold w
  rw [← Finset.mul_prod_erase Finset.univ (fun p => 1 + Function.update y p₀ a p * chi (plaq p) σ)
        (Finset.mem_univ p₀),
    ← Finset.mul_prod_erase Finset.univ (fun p => 1 + Function.update y p₀ 0 p * chi (plaq p) σ)
        (Finset.mem_univ p₀)]
  simp only [Function.update_self, zero_mul, add_zero, one_mul]
  congr 1
  apply Finset.prod_congr rfl
  intro p hp
  rw [Function.update_of_ne (Finset.ne_of_mem_erase hp), Function.update_of_ne (Finset.ne_of_mem_erase hp)]

theorem update_nonneg (y : P → ℝ) (hy0 : ∀ p, 0 ≤ y p) (p₀ : P) {a : ℝ} (ha : 0 ≤ a) :
    ∀ p, 0 ≤ Function.update y p₀ a p := by
  intro p
  by_cases h : p = p₀
  · subst h; simp [ha]
  · rw [Function.update_of_ne h]; exact hy0 p

theorem update_le_one (y : P → ℝ) (hy1 : ∀ p, y p ≤ 1) (p₀ : P) {a : ℝ} (ha : a ≤ 1) :
    ∀ p, Function.update y p₀ a p ≤ 1 := by
  intro p
  by_cases h : p = p₀
  · subst h; simp [ha]
  · rw [Function.update_of_ne h]; exact hy1 p

/-- MONOTONICITY IN ONE COUPLING (Griffiths II's first consequence): raising one y_p raises every ⟨χ_A⟩ -/
theorem expect_update_mono (plaq : P → E → Bool) (y : P → ℝ) (hy0 : ∀ p, 0 ≤ y p) (hy1 : ∀ p, y p ≤ 1)
    (p₀ : P) (A : E → Bool) {a b : ℝ} (ha : 0 ≤ a) (hab : a ≤ b) (hb : b ≤ 1) :
    expect plaq (Function.update y p₀ a) A ≤ expect plaq (Function.update y p₀ b) A := by
  have hy₀0 : ∀ p, 0 ≤ Function.update y p₀ 0 p := update_nonneg y hy0 p₀ le_rfl
  have hy₀1 : ∀ p, Function.update y p₀ 0 p ≤ 1 := update_le_one y hy1 p₀ zero_le_one
  have hN : ∀ c : ℝ, ∑ σ : E → Bool, chi A σ * w plaq (Function.update y p₀ c) σ
      = (∑ σ : E → Bool, chi A σ * w plaq (Function.update y p₀ 0) σ)
        + c * ∑ σ : E → Bool, chi A σ * chi (plaq p₀) σ * w plaq (Function.update y p₀ 0) σ := by
    intro c
    simp_rw [w_update plaq y p₀ c]
    rw [Finset.mul_sum, ← Finset.sum_add_distrib]
    apply Finset.sum_congr rfl
    intro σ _
    ring
  have hZ : ∀ c : ℝ, ∑ σ : E → Bool, w plaq (Function.update y p₀ c) σ
      = (∑ σ : E → Bool, w plaq (Function.update y p₀ 0) σ)
        + c * ∑ σ : E → Bool, chi (plaq p₀) σ * w plaq (Function.update y p₀ 0) σ := by
    intro c
    simp_rw [w_update plaq y p₀ c]
    rw [Finset.mul_sum, ← Finset.sum_add_distrib]
    apply Finset.sum_congr rfl
    intro σ _
    ring
  have hG := griffiths_two plaq (Function.update y p₀ 0) hy₀0 hy₀1 A (plaq p₀)
  have hZa := partition_pos plaq (Function.update y p₀ a) (update_nonneg y hy0 p₀ ha)
  have hZb := partition_pos plaq (Function.update y p₀ b) (update_nonneg y hy0 p₀ (le_trans ha hab))
  unfold expect
  rw [div_le_div_iff₀ hZa hZb]
  rw [hN a, hN b, hZ a, hZ b]
  rw [hZ a] at hZa
  rw [hZ b] at hZb
  nlinarith [mul_nonneg (sub_nonneg.mpr hab) (sub_nonneg.mpr hG)]

/-- the couplings blended: y' on D, y elsewhere -/
def blend (y y' : P → ℝ) (D : Finset P) : P → ℝ := fun p => if p ∈ D then y' p else y p

theorem blend_nonneg (y y' : P → ℝ) (hy0 : ∀ p, 0 ≤ y p) (hy0' : ∀ p, 0 ≤ y' p) (D : Finset P) :
    ∀ p, 0 ≤ blend y y' D p := by
  intro p; by_cases h : p ∈ D <;> simp [blend, h, hy0 p, hy0' p]

theorem blend_le_one (y y' : P → ℝ) (hy1 : ∀ p, y p ≤ 1) (hy1' : ∀ p, y' p ≤ 1) (D : Finset P) :
    ∀ p, blend y y' D p ≤ 1 := by
  intro p; by_cases h : p ∈ D <;> simp [blend, h, hy1 p, hy1' p]

/-- MONOTONICITY IN THE COUPLINGS: every ⟨χ_A⟩ is nondecreasing in every y_p -- the Wilson loop grows with the
volume it lives in, the mechanism of the infinite-volume limit -/
theorem expect_mono (plaq : P → E → Bool) (y y' : P → ℝ) (hy0 : ∀ p, 0 ≤ y p) (hyy : ∀ p, y p ≤ y' p)
    (hy1 : ∀ p, y' p ≤ 1) (A : E → Bool) : expect plaq y A ≤ expect plaq y' A := by
  have hy0' : ∀ p, 0 ≤ y' p := fun p => le_trans (hy0 p) (hyy p)
  have hy1l : ∀ p, y p ≤ 1 := fun p => le_trans (hyy p) (hy1 p)
  have key : ∀ D : Finset P, expect plaq y A ≤ expect plaq (blend y y' D) A := by
    intro D
    induction D using Finset.induction_on with
    | empty =>
      have h0 : blend y y' ∅ = y := by funext p; simp [blend]
      rw [h0]
    | @insert p D hp ih =>
      refine le_trans ih ?_
      have h1 : blend y y' D = Function.update (blend y y' D) p (y p) := by
        funext q
        by_cases hq : q = p
        · subst hq; simp [blend, hp]
        · rw [Function.update_of_ne hq]
      have h2 : blend y y' (insert p D) = Function.update (blend y y' D) p (y' p) := by
        funext q
        by_cases hq : q = p
        · subst hq; simp [blend]
        · rw [Function.update_of_ne hq]; simp [blend, hq]
      rw [h2]
      conv_lhs => rw [h1]
      exact expect_update_mono plaq (blend y y' D) (blend_nonneg y y' hy0 hy0' D) (blend_le_one y y' hy1l hy1 D)
        p A (hy0 p) (hyy p) (hy1 p)
  have hu : blend y y' Finset.univ = y' := by funext p; simp [blend]
  have := key Finset.univ
  rw [hu] at this
  exact this

end Aperanton
