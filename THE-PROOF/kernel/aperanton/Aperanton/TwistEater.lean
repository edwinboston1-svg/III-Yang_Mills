/-
  APERANTON -- THE BOUNDLESS, THE TREK (2026-10-28 11:3x): THE TWIST EATER'S RATE -- WHY THE SIMON-LIEB SHAPE DIES ON THE
  VORTEX SECTOR OF A NON-ABELIAN GROUP.

  On the 1 x 1 x L cell of Q₈ (the two spatial links x, y of a slice a pair s = (x, y), the temporal link t integrated) the
  transfer matrix in its symmetric form is
      T(z)(s, s')   = z^{qP s + qP s'}   K(z)(s, s'),      K(z)(s, s') = (1/8) Σ_t z^{2 (q₀(x t x'⁻¹ t⁻¹) + q₀(y t y'⁻¹ t⁻¹))},
  with z² = e^β, qP s = q₀([x, y]) the spatial plaquette's trace half, q₀(±1) = ±1 and q₀(±i, ±j, ±k) = 0; the vortex string's
  per-slice rate m(β) = λ₀(T^tw)/λ₀(T) is the Perron ratio of the twisted sector, T^tw(z)(s, s') = z^{-qP s - qP s'} K(z)(s, s')
  (the twist multiplies a slice by e^{-2β q₀(P)}).  THEOREM (twist_eater_law): for z ≥ 1,
      z⁶ ≤ λ₀(T(z)) ≤ z⁶ + 64 z⁴     and     z⁶ ≤ λ₀(T^tw(z)) ≤ z⁶ + 64 z⁴,
  so z⁶/(z⁶ + 64 z⁴) ≤ m ≤ (z⁶ + 64 z⁴)/z⁶ (rate_bounds) and m → 1 as β → ∞ (rate_tendsto).  The lower bound of the vacuum
  sector is the identity pair's diagonal entry (every t fixes it); the lower bound of the twisted sector is the Rayleigh
  quotient on the TWIST EATER'S ORBIT {(±i, ±j)} -- the pairs whose commutator is the twisting element, on which the twist
  costs nothing; the upper bounds are the row sums, where the degree-six part of every row is exactly the orbit's eight
  temporal images.  The twisted sector's zero-temperature free energy equals the vacuum's ('t Hooft's twist eaters), and since
  a Simon-Lieb box with the Ising dual's free boundary pays the bare e^{-2β} = z⁻⁴ for its one twist, the shape c ≥ m/(1 + m²)
  fails for every large β: the master plan note §37.4 (measured: Q₈ fails from β = 1.5, 2T/2O/2I from 2; m = 0.854 at β = 3).
  The group tables are decided in the kernel (associativity, inverses, the commutator table), every count by `decide`;
  Perron.lean supplies λ₀ as the top eigenvalue of a positive symmetric matrix with its Rayleigh bound and its positive
  eigenvector.  No sorry, no axiom, no native_decide.
-/
import Mathlib
import Aperanton.Perron

set_option maxRecDepth 100000
set_option maxHeartbeats 4000000

namespace TwistEater

open Matrix BigOperators Finset
open Aperanton

/-! ## Q₈ on Fin 8: 0 ↦ 1, 1 ↦ −1, 2 ↦ i, 3 ↦ −i, 4 ↦ j, 5 ↦ −j, 6 ↦ k, 7 ↦ −k -/

/-- the sign of the element: even index positive, odd negative -/
def sgn (a : Fin 8) : ℤ := if a.val % 2 = 0 then 1 else -1

/-- the base unit: 0 for ±1, 1 for ±i, 2 for ±j, 3 for ±k -/
def base (a : Fin 8) : ℕ := a.val / 2

/-- the base units multiply as (unit, sign) -/
def bmul (a b : ℕ) : ℕ × ℤ :=
  match a, b with
  | 0, b => (b, 1)
  | a, 0 => (a, 1)
  | 1, 1 => (0, -1) | 1, 2 => (3, 1) | 1, 3 => (2, -1)
  | 2, 1 => (3, -1) | 2, 2 => (0, -1) | 2, 3 => (1, 1)
  | 3, 1 => (2, 1) | 3, 2 => (1, -1) | 3, 3 => (0, -1)
  | _, _ => (0, 1)

/-- the element of unit u (0..3) and sign s (±1) -/
def mk (u : ℕ) (s : ℤ) : Fin 8 := ⟨(2 * u + (if s = 1 then 0 else 1)) % 8, Nat.mod_lt _ (by norm_num)⟩

/-- the product in Q₈ -/
def qmul (a b : Fin 8) : Fin 8 := let p := bmul (base a) (base b); mk p.1 (sgn a * sgn b * p.2)

/-- the inverse: ±1 are their own inverses, the others negate -/
def qinv (a : Fin 8) : Fin 8 := if base a = 0 then a else mk (base a) (-(sgn a))

/-- q₀: half the trace in the defining representation -/
def q0 (a : Fin 8) : ℤ := if base a = 0 then sgn a else 0

theorem qmul_assoc : ∀ a b c : Fin 8, qmul (qmul a b) c = qmul a (qmul b c) := by decide
theorem qmul_one : ∀ a : Fin 8, qmul a 0 = a ∧ qmul 0 a = a := by decide
theorem qmul_inv : ∀ a : Fin 8, qmul a (qinv a) = 0 ∧ qmul (qinv a) a = 0 := by decide
theorem qinv_qinv : ∀ a : Fin 8, qinv (qinv a) = a := by decide
theorem q0_inv : ∀ a : Fin 8, q0 (qinv a) = q0 a := by decide
theorem q0_conj : ∀ a t : Fin 8, q0 (qmul (qmul t a) (qinv t)) = q0 a := by decide
/-- the table is Q₈ and not its abelian shadow: i j = k, j i = −k -/
theorem ij_eq_k : qmul 2 4 = 6 ∧ qmul 4 2 = 7 := by decide

/-! ## the cell: pairs of links, the plaquette, the temporal exponent -/

abbrev S := Fin 8 × Fin 8

/-- the spatial plaquette x y x⁻¹ y⁻¹ -/
def comm (s : S) : Fin 8 := qmul (qmul (qmul s.1 s.2) (qinv s.1)) (qinv s.2)

/-- q₀ of the plaquette -/
def qP (s : S) : ℤ := q0 (comm s)

/-- the temporal exponent between two slices through the temporal link t -/
def temp (s s' : S) (t : Fin 8) : ℤ :=
  q0 (qmul (qmul (qmul s.1 t) (qinv s'.1)) (qinv t)) + q0 (qmul (qmul (qmul s.2 t) (qinv s'.2)) (qinv t))

theorem qP_bounds : ∀ s : S, -1 ≤ qP s ∧ qP s ≤ 1 := by decide
theorem qP_id : qP (0, 0) = 1 := by decide
theorem temp_le_two : ∀ s s' : S, ∀ t : Fin 8, temp s s' t ≤ 2 := by decide
theorem temp_symm : ∀ s s' : S, ∀ t : Fin 8, temp s' s (qinv t) = temp s s' t := by decide
theorem temp_id : ∀ t : Fin 8, temp (0, 0) (0, 0) t = 2 := by decide
/-- every row has exactly eight degree-six terms: the orbit's temporal images -/
theorem temp_two_count : ∀ s : S, (univ.filter (fun p : S × Fin 8 => temp s p.1 p.2 = 2)).card = 8 := by decide

/-- THE TWIST EATER'S ORBIT: the pairs (±i, ±j), whose commutator is −1 -/
def eater : Finset S := {(2, 4), (2, 5), (3, 4), (3, 5)}

theorem eater_card : eater.card = 4 := by decide
theorem eater_qP : ∀ s ∈ eater, qP s = -1 := by decide
/-- the orbit's temporal images: thirty-two triples (s, s', t) inside the orbit at exponent two -/
theorem eater_count :
    (∑ s ∈ eater, ∑ s' ∈ eater, ((univ.filter (fun t : Fin 8 => temp s s' t = 2)).card : ℤ)) = 32 := by decide

/-! ## the transfer matrices -/

/-- the temporal kernel -/
noncomputable def K (z : ℝ) (s s' : S) : ℝ := (1 / 8) * ∑ t : Fin 8, z ^ (2 * temp s s' t)

/-- the vacuum sector's transfer matrix, symmetric form -/
noncomputable def T (z : ℝ) : Matrix S S ℝ := fun s s' => z ^ (qP s + qP s') * K z s s'

/-- the twisted sector's transfer matrix, symmetric form -/
noncomputable def Ttw (z : ℝ) : Matrix S S ℝ := fun s s' => z ^ (-(qP s) - qP s') * K z s s'

theorem K_pos (z : ℝ) (hz : 0 < z) (s s' : S) : 0 < K z s s' := by
  unfold K
  apply mul_pos (by norm_num)
  exact Finset.sum_pos (fun t _ => zpow_pos hz _) univ_nonempty

/-- the involution t ↦ t⁻¹ of the temporal link -/
def invPerm : Equiv.Perm (Fin 8) := Function.Involutive.toPerm qinv qinv_qinv

theorem K_symm (z : ℝ) (s s' : S) : K z s s' = K z s' s := by
  unfold K
  congr 1
  rw [← Equiv.sum_comp invPerm (fun t => z ^ (2 * temp s' s t))]
  apply Finset.sum_congr rfl
  intro t _
  show z ^ (2 * temp s s' t) = z ^ (2 * temp s' s (qinv t))
  rw [temp_symm]

theorem T_pos (z : ℝ) (hz : 0 < z) : ∀ s s', 0 < T z s s' :=
  fun s s' => mul_pos (zpow_pos hz _) (K_pos z hz s s')

theorem Ttw_pos (z : ℝ) (hz : 0 < z) : ∀ s s', 0 < Ttw z s s' :=
  fun s s' => mul_pos (zpow_pos hz _) (K_pos z hz s s')

theorem T_herm (z : ℝ) : (T z).IsHermitian := by
  apply Matrix.IsHermitian.ext
  intro s s'
  simp only [star_trivial, T]
  rw [K_symm, add_comm]

theorem Ttw_herm (z : ℝ) : (Ttw z).IsHermitian := by
  apply Matrix.IsHermitian.ext
  intro s s'
  simp only [star_trivial, Ttw]
  rw [K_symm]
  congr 2
  ring

/-! ## the lower bounds: the identity pair's diagonal, the eater orbit's Rayleigh quotient -/

theorem K_id (z : ℝ) : K z (0, 0) (0, 0) = z ^ (4 : ℤ) := by
  unfold K
  have h : ∀ t ∈ (univ : Finset (Fin 8)), z ^ (2 * temp (0, 0) (0, 0) t) = z ^ (4 : ℤ) :=
    fun t _ => by rw [temp_id]; norm_num
  rw [Finset.sum_congr rfl h, Finset.sum_const, Finset.card_univ, Fintype.card_fin, nsmul_eq_mul]
  push_cast
  ring

theorem T_id (z : ℝ) (hz : z ≠ 0) : T z (0, 0) (0, 0) = z ^ (6 : ℤ) := by
  unfold T
  rw [K_id, qP_id, ← zpow_add₀ hz]
  norm_num

/-- the Rayleigh bound read at a basis vector: λ₀ ≥ every diagonal entry -/
theorem lamMax_ge_diag (M : Matrix S S ℝ) (hM : M.IsHermitian) (s : S) : M s s ≤ lamMax M hM := by
  have h := dot_mulVec_le M hM (Pi.single s 1)
  simp only [dotProduct, mulVec, Pi.single_apply, mul_ite, mul_one, mul_zero, ite_mul, one_mul, zero_mul,
    Finset.sum_ite_eq', Finset.mem_univ, if_true] at h
  linarith

theorem lamMax_T_ge (z : ℝ) (hz : z ≠ 0) : z ^ (6 : ℤ) ≤ lamMax (T z) (T_herm z) := by
  rw [← T_id z hz]; exact lamMax_ge_diag _ _ _

/-- the indicator of the eater orbit -/
noncomputable def eaterVec : S → ℝ := fun s => if s ∈ eater then 1 else 0

theorem eaterVec_dot : eaterVec ⬝ᵥ eaterVec = 4 := by
  have h : ∀ s : S, eaterVec s * eaterVec s = if s ∈ eater then 1 else 0 := by
    intro s; unfold eaterVec; split_ifs <;> simp
  simp only [dotProduct, h]
  rw [Finset.sum_ite_mem, Finset.univ_inter, Finset.sum_const, eater_card]
  simp

/-- the degree-six share of a kernel entry -/
noncomputable def c6 (s s' : S) : ℝ := ((univ.filter (fun t : Fin 8 => temp s s' t = 2)).card : ℝ)

/-- on the orbit every entry of the twisted matrix is at least z² times the degree-six share of its kernel -/
theorem Ttw_eater_entry (z : ℝ) (hz : 1 ≤ z) (s s' : S) (hs : s ∈ eater) (hs' : s' ∈ eater) :
    z ^ (2 : ℤ) * ((1 / 8) * c6 s s' * z ^ (4 : ℤ)) ≤ Ttw z s s' := by
  have hz0 : 0 < z := lt_of_lt_of_le one_pos hz
  unfold Ttw
  have hq : -(qP s) - qP s' = 2 := by rw [eater_qP s hs, eater_qP s' hs']; norm_num
  rw [hq]
  apply mul_le_mul_of_nonneg_left _ (zpow_nonneg hz0.le _)
  unfold K
  rw [mul_assoc]
  apply mul_le_mul_of_nonneg_left _ (by norm_num)
  have hA : ∑ t ∈ univ.filter (fun t : Fin 8 => temp s s' t = 2), z ^ (2 * temp s s' t) = c6 s s' * z ^ (4 : ℤ) := by
    rw [Finset.sum_congr rfl (g := fun _ => z ^ (4 : ℤ))
      (fun t ht => by rw [(Finset.mem_filter.mp ht).2]; norm_num)]
    rw [Finset.sum_const, nsmul_eq_mul]
    rfl
  rw [← hA]
  exact Finset.sum_le_sum_of_subset_of_nonneg (Finset.filter_subset _ _) (fun t _ _ => zpow_nonneg hz0.le _)

theorem eater_rayleigh (z : ℝ) (hz : 1 ≤ z) : 4 * z ^ (6 : ℤ) ≤ eaterVec ⬝ᵥ (Ttw z *ᵥ eaterVec) := by
  have hz0 : 0 < z := lt_of_lt_of_le one_pos hz
  have hdot : eaterVec ⬝ᵥ (Ttw z *ᵥ eaterVec) = ∑ s ∈ eater, ∑ s' ∈ eater, Ttw z s s' := by
    simp only [dotProduct, mulVec, eaterVec, mul_ite, mul_one, mul_zero, ite_mul, one_mul, zero_mul]
    rw [Finset.sum_ite_mem, Finset.univ_inter]
    apply Finset.sum_congr rfl; intro s _
    rw [Finset.sum_ite_mem, Finset.univ_inter]
  rw [hdot]
  have hcount : (∑ s ∈ eater, ∑ s' ∈ eater, c6 s s') = 32 := by
    have h := eater_count
    unfold c6
    exact_mod_cast h
  have hfact : ∑ s ∈ eater, ∑ s' ∈ eater, z ^ (2 : ℤ) * ((1 / 8) * c6 s s' * z ^ (4 : ℤ))
      = z ^ (2 : ℤ) * (1 / 8) * z ^ (4 : ℤ) * ∑ s ∈ eater, ∑ s' ∈ eater, c6 s s' := by
    rw [Finset.mul_sum]
    apply Finset.sum_congr rfl; intro s _
    rw [Finset.mul_sum]
    apply Finset.sum_congr rfl; intro s' _
    ring
  have hz6 : z ^ (2 : ℤ) * (1 / 8) * z ^ (4 : ℤ) * 32 = 4 * z ^ (6 : ℤ) := by
    rw [show z ^ (6 : ℤ) = z ^ (2 : ℤ) * z ^ (4 : ℤ) by rw [← zpow_add₀ hz0.ne']; norm_num]
    ring
  calc 4 * z ^ (6 : ℤ) = ∑ s ∈ eater, ∑ s' ∈ eater, z ^ (2 : ℤ) * ((1 / 8) * c6 s s' * z ^ (4 : ℤ)) := by
        rw [hfact, hcount, hz6]
    _ ≤ ∑ s ∈ eater, ∑ s' ∈ eater, Ttw z s s' :=
        Finset.sum_le_sum (fun s hs => Finset.sum_le_sum (fun s' hs' => Ttw_eater_entry z hz s s' hs hs'))

theorem lamMax_Ttw_ge (z : ℝ) (hz : 1 ≤ z) : z ^ (6 : ℤ) ≤ lamMax (Ttw z) (Ttw_herm z) := by
  have h := dot_mulVec_le (Ttw z) (Ttw_herm z) eaterVec
  rw [eaterVec_dot] at h
  have h2 := eater_rayleigh z hz
  linarith

/-! ## the upper bounds: the row sums -/

/-- λ₀ of a positive symmetric matrix is at most its largest row sum -/
theorem lamMax_le_rowsum (M : Matrix S S ℝ) (hM : M.IsHermitian) (hpos : ∀ i j, 0 < M i j) (R : ℝ)
    (hR : ∀ i, ∑ j, M i j ≤ R) : lamMax M hM ≤ R := by
  obtain ⟨a, hapos, ha, -⟩ := perron_exists M hM hpos
  obtain ⟨i₀, -, hi₀⟩ := Finset.exists_max_image univ a univ_nonempty
  have hrow : lamMax M hM * a i₀ = ∑ j, M i₀ j * a j := by
    have h := congrFun ha i₀
    simp only [mulVec, dotProduct, Pi.smul_apply, smul_eq_mul] at h
    linarith
  have hle : ∑ j, M i₀ j * a j ≤ (∑ j, M i₀ j) * a i₀ := by
    rw [Finset.sum_mul]
    apply Finset.sum_le_sum; intro j _
    exact mul_le_mul_of_nonneg_left (hi₀ j (mem_univ j)) (hpos i₀ j).le
  have hai : 0 < a i₀ := hapos i₀
  have hfin : lamMax M hM * a i₀ ≤ R * a i₀ := by
    calc lamMax M hM * a i₀ = ∑ j, M i₀ j * a j := hrow
      _ ≤ (∑ j, M i₀ j) * a i₀ := hle
      _ ≤ R * a i₀ := mul_le_mul_of_nonneg_right (hR i₀) hai.le
  exact le_of_mul_le_mul_right hfin hai

/-- a row of either matrix as one sum over (s', t) -/
theorem row_as_sum (z : ℝ) (hz : z ≠ 0) (e : S → S → ℤ) (s : S) :
    ∑ s', z ^ (e s s') * K z s s' = (1 / 8) * ∑ p : S × Fin 8, z ^ (e s p.1 + 2 * temp s p.1 p.2) := by
  have h1 : ∀ s' : S, z ^ (e s s') * K z s s' = ∑ t : Fin 8, (1 / 8) * z ^ (e s s' + 2 * temp s s' t) := by
    intro s'
    unfold K
    rw [Finset.mul_sum, Finset.mul_sum]
    apply Finset.sum_congr rfl; intro t _
    rw [zpow_add₀ hz]
    ring
  simp_rw [h1]
  rw [Finset.mul_sum]
  exact (Fintype.sum_prod_type' _).symm

/-- THE ROW BOUND: with every exponent e ≤ 2, a row sums to at most z⁶ + 64 z⁴ -- eight terms of degree six (the orbit's
images, where temp = 2), the rest of degree at most four -/
theorem row_bound (z : ℝ) (hz : 1 ≤ z) (e : S → S → ℤ) (he : ∀ s s', e s s' ≤ 2) (s : S) :
    ∑ s', z ^ (e s s') * K z s s' ≤ z ^ (6 : ℤ) + 64 * z ^ (4 : ℤ) := by
  have hz0 : 0 < z := lt_of_lt_of_le one_pos hz
  rw [row_as_sum z hz0.ne' e s]
  set A := (univ : Finset (S × Fin 8)).filter (fun p => temp s p.1 p.2 = 2) with hA
  have hsplit : ∑ p : S × Fin 8, z ^ (e s p.1 + 2 * temp s p.1 p.2)
      = ∑ p ∈ univ \ A, z ^ (e s p.1 + 2 * temp s p.1 p.2) + ∑ p ∈ A, z ^ (e s p.1 + 2 * temp s p.1 p.2) :=
    (Finset.sum_sdiff (Finset.filter_subset _ _)).symm
  have hA6 : ∑ p ∈ A, z ^ (e s p.1 + 2 * temp s p.1 p.2) ≤ 8 * z ^ (6 : ℤ) := by
    calc ∑ p ∈ A, z ^ (e s p.1 + 2 * temp s p.1 p.2) ≤ ∑ p ∈ A, z ^ (6 : ℤ) := by
          apply Finset.sum_le_sum; intro p hp
          have ht : temp s p.1 p.2 = 2 := (Finset.mem_filter.mp hp).2
          apply zpow_le_zpow_right₀ hz
          have := he s p.1
          omega
      _ = 8 * z ^ (6 : ℤ) := by rw [Finset.sum_const, nsmul_eq_mul, hA, temp_two_count s]; norm_num
  have hrest : ∑ p ∈ univ \ A, z ^ (e s p.1 + 2 * temp s p.1 p.2) ≤ 512 * z ^ (4 : ℤ) := by
    calc ∑ p ∈ univ \ A, z ^ (e s p.1 + 2 * temp s p.1 p.2) ≤ ∑ p ∈ univ \ A, z ^ (4 : ℤ) := by
          apply Finset.sum_le_sum; intro p hp
          have hnot : ¬ temp s p.1 p.2 = 2 :=
            fun h => (Finset.mem_sdiff.mp hp).2 (Finset.mem_filter.mpr ⟨mem_univ _, h⟩)
          have h2 := temp_le_two s p.1 p.2
          apply zpow_le_zpow_right₀ hz
          have := he s p.1
          omega
      _ ≤ ∑ p : S × Fin 8, z ^ (4 : ℤ) :=
          Finset.sum_le_sum_of_subset_of_nonneg Finset.sdiff_subset (fun _ _ _ => zpow_nonneg hz0.le _)
      _ = 512 * z ^ (4 : ℤ) := by
          rw [Finset.sum_const, Finset.card_univ, nsmul_eq_mul]
          simp only [Fintype.card_prod, Fintype.card_fin]
          norm_num
  rw [hsplit]
  linarith [hA6, hrest]

theorem lamMax_T_le (z : ℝ) (hz : 1 ≤ z) : lamMax (T z) (T_herm z) ≤ z ^ (6 : ℤ) + 64 * z ^ (4 : ℤ) := by
  have hz0 : 0 < z := lt_of_lt_of_le one_pos hz
  apply lamMax_le_rowsum _ _ (T_pos z hz0)
  intro s
  exact row_bound z hz (fun s s' => qP s + qP s')
    (fun s s' => by have h1 := qP_bounds s; have h2 := qP_bounds s'; omega) s

theorem lamMax_Ttw_le (z : ℝ) (hz : 1 ≤ z) : lamMax (Ttw z) (Ttw_herm z) ≤ z ^ (6 : ℤ) + 64 * z ^ (4 : ℤ) := by
  have hz0 : 0 < z := lt_of_lt_of_le one_pos hz
  apply lamMax_le_rowsum _ _ (Ttw_pos z hz0)
  intro s
  exact row_bound z hz (fun s s' => -(qP s) - qP s')
    (fun s s' => by have h1 := qP_bounds s; have h2 := qP_bounds s'; omega) s

/-! ## THE TWIST EATER'S LAW -/

theorem twist_eater_law (z : ℝ) (hz : 1 ≤ z) :
    z ^ (6 : ℤ) ≤ lamMax (T z) (T_herm z) ∧ lamMax (T z) (T_herm z) ≤ z ^ (6 : ℤ) + 64 * z ^ (4 : ℤ) ∧
    z ^ (6 : ℤ) ≤ lamMax (Ttw z) (Ttw_herm z) ∧ lamMax (Ttw z) (Ttw_herm z) ≤ z ^ (6 : ℤ) + 64 * z ^ (4 : ℤ) :=
  ⟨lamMax_T_ge z (lt_of_lt_of_le one_pos hz).ne', lamMax_T_le z hz, lamMax_Ttw_ge z hz, lamMax_Ttw_le z hz⟩

/-- the vortex string's rate: the Perron ratio of the twisted sector -/
noncomputable def rate (z : ℝ) : ℝ := lamMax (Ttw z) (Ttw_herm z) / lamMax (T z) (T_herm z)

theorem rate_bounds (z : ℝ) (hz : 1 ≤ z) :
    z ^ (6 : ℤ) / (z ^ (6 : ℤ) + 64 * z ^ (4 : ℤ)) ≤ rate z ∧
    rate z ≤ (z ^ (6 : ℤ) + 64 * z ^ (4 : ℤ)) / z ^ (6 : ℤ) := by
  obtain ⟨h1, h2, h3, h4⟩ := twist_eater_law z hz
  have hz0 : 0 < z := lt_of_lt_of_le one_pos hz
  have h6 : 0 < z ^ (6 : ℤ) := zpow_pos hz0 _
  have hU : 0 < z ^ (6 : ℤ) + 64 * z ^ (4 : ℤ) := by positivity
  have hT : 0 < lamMax (T z) (T_herm z) := lt_of_lt_of_le h6 h1
  unfold rate
  constructor
  · rw [div_le_div_iff₀ hU hT]
    nlinarith [h2, h3, h6, hT]
  · rw [div_le_div_iff₀ hT h6]
    nlinarith [h1, h4, h6, hT]

/-- the bounds in their closed form: 1/(1 + 64/z²) ≤ m ≤ 1 + 64/z² -/
theorem rate_bounds' (z : ℝ) (hz : 1 ≤ z) : 1 / (1 + 64 / z ^ 2) ≤ rate z ∧ rate z ≤ 1 + 64 / z ^ 2 := by
  have hz0 : 0 < z := lt_of_lt_of_le one_pos hz
  obtain ⟨h1, h2⟩ := rate_bounds z hz
  have hk : (z ^ (6 : ℤ) + 64 * z ^ (4 : ℤ)) / z ^ (6 : ℤ) = 1 + 64 / z ^ 2 := by
    have h46 : z ^ (4 : ℤ) / z ^ (6 : ℤ) = 1 / z ^ 2 := by
      rw [← zpow_sub₀ hz0.ne', show (4 : ℤ) - 6 = -(2 : ℕ) by norm_num, _root_.zpow_neg, _root_.zpow_natCast, one_div]
    rw [add_div, div_self (zpow_pos hz0 _).ne', mul_div_assoc, h46]
    ring
  have hk' : z ^ (6 : ℤ) / (z ^ (6 : ℤ) + 64 * z ^ (4 : ℤ)) = 1 / (1 + 64 / z ^ 2) := by
    rw [← hk, one_div_div]
  exact ⟨hk' ▸ h1, hk ▸ h2⟩

/-- m → 1 as β → ∞: the twisted sector's free energy per slice tends to the vacuum's -/
theorem rate_tendsto : Filter.Tendsto rate Filter.atTop (nhds 1) := by
  have h0 : Filter.Tendsto (fun z : ℝ => 64 / z ^ 2) Filter.atTop (nhds 0) :=
    tendsto_const_nhds.div_atTop (Filter.tendsto_pow_atTop (by norm_num : (2 : ℕ) ≠ 0))
  have hhi : Filter.Tendsto (fun z : ℝ => 1 + 64 / z ^ 2) Filter.atTop (nhds 1) := by
    simpa using tendsto_const_nhds.add h0
  have hlo : Filter.Tendsto (fun z : ℝ => (1 + 64 / z ^ 2)⁻¹) Filter.atTop (nhds 1) := by
    simpa using hhi.inv₀ one_ne_zero
  refine tendsto_of_tendsto_of_tendsto_of_le_of_le' hlo hhi ?_ ?_
  · exact Filter.eventually_atTop.mpr ⟨1, fun z hz => by simpa [one_div] using (rate_bounds' z hz).1⟩
  · exact Filter.eventually_atTop.mpr ⟨1, fun z hz => (rate_bounds' z hz).2⟩

end TwistEater
