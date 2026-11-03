/-
  ΑΠΕΡΑΝΤΟΝ — THE TWIST EATER'S LAW, SHARPENED: THE ROW SUM IS EXACT (the master plan note §42.2)

  The transfer kernel's row sum on the 1 × 1 cell does not depend on the row: for fixed s and t the map
  s' ↦ (s.1 t s'.1⁻¹ t⁻¹, s.2 t s'.2⁻¹ t⁻¹) is a bijection of G × G, so

      ∑_{s'} K z s s' = (∑_g z^{2 q g})² = W²,   W ≤ z² (1 + (|G| − 1) z^{−2δ}),

  and both Perron roots lie in [z⁶, z⁶ (1 + (|G| − 1) z^{−2δ})²] — sharper than TwistEaterGeneral's
  z⁶ (1 + |G|² z^{−2δ}) (for Q₈: 1 + 14 z^{−2} + 49 z^{−4} against 1 + 64 z^{−2}), with the same limit.
  No sorry, no axiom, no native_decide.
-/
import Aperanton.TwistEaterGeneral

open Finset Aperanton

namespace TwistEaterGeneral

variable {G : Type*} [Group G] [Fintype G] [DecidableEq G] (Q : TraceHalf G)

/-- the temporal weight of one group element -/
noncomputable def w (z : ℝ) (g : G) : ℝ := z ^ (2 * Q.q g)

/-- the total temporal weight of one link -/
noncomputable def Wsum (z : ℝ) : ℝ := ∑ g, w Q z g

/-- the change of variables s' ↦ (a₁, a₂) at fixed s and t -/
def shift (s : G × G) (t : G) : (G × G) ≃ (G × G) where
  toFun s' := (s.1 * t * s'.1⁻¹ * t⁻¹, s.2 * t * s'.2⁻¹ * t⁻¹)
  invFun a := (t⁻¹ * a.1⁻¹ * s.1 * t, t⁻¹ * a.2⁻¹ * s.2 * t)
  left_inv s' := by
    apply Prod.ext
    · simp only []; group
    · simp only []; group
  right_inv a := by
    apply Prod.ext
    · simp only []; group
    · simp only []; group

theorem temp_split (z : ℝ) (hz : 0 < z) (s s' : G × G) (t : G) :
    z ^ (2 * temp Q s s' t) = w Q z (s.1 * t * s'.1⁻¹ * t⁻¹) * w Q z (s.2 * t * s'.2⁻¹ * t⁻¹) := by
  unfold temp w
  rw [mul_add, Real.rpow_add hz]

theorem w_pos (z : ℝ) (hz : 0 < z) (g : G) : 0 < w Q z g := Real.rpow_pos_of_pos hz _

/-- THE EXACT ROW SUM: ∑_{s'} K z s s' = W², independent of s -/
theorem row_sum_exact (z : ℝ) (hz : 0 < z) (s : G × G) : ∑ s', K Q z s s' = (Wsum Q z) ^ 2 := by
  have hc : (0 : ℝ) < (Fintype.card G : ℝ) := card_pos
  have h : ∀ t : G, ∑ s', z ^ (2 * temp Q s s' t) = (Wsum Q z) ^ 2 := by
    intro t
    calc ∑ s', z ^ (2 * temp Q s s' t)
        = ∑ s', w Q z ((shift s t s').1) * w Q z ((shift s t s').2) := by
          apply Finset.sum_congr rfl; intro s' _; rw [temp_split Q z hz]; rfl
      _ = ∑ a : G × G, w Q z a.1 * w Q z a.2 :=
          Equiv.sum_comp (shift s t) (fun a : G × G => w Q z a.1 * w Q z a.2)
      _ = (∑ a, w Q z a) * (∑ b, w Q z b) := by
          rw [Fintype.sum_prod_type, ← Finset.sum_mul_sum]
      _ = (Wsum Q z) ^ 2 := by unfold Wsum; ring
  unfold K
  rw [← Finset.mul_sum, Finset.sum_comm]
  simp_rw [h]
  rw [Finset.sum_const, Finset.card_univ, nsmul_eq_mul]
  field_simp

/-- W ≤ z² (1 + (|G| − 1) z^{−2δ}) for z ≥ 1 -/
theorem Wsum_le (z : ℝ) (hz : 1 ≤ z) :
    Wsum Q z ≤ z ^ (2 : ℝ) * (1 + ((Fintype.card G : ℝ) - 1) * z ^ (-(2 * Q.δ))) := by
  have hz0 : 0 < z := lt_of_lt_of_le one_pos hz
  unfold Wsum
  rw [← Finset.add_sum_erase univ (fun g => w Q z g) (Finset.mem_univ (1 : G))]
  have h1 : w Q z 1 = z ^ (2 : ℝ) := by unfold w; rw [Q.q_one]; norm_num
  have hrest : ∑ g ∈ univ.erase (1 : G), w Q z g ≤ ((Fintype.card G : ℝ) - 1) * (z ^ (2 : ℝ) * z ^ (-(2 * Q.δ))) := by
    have hcard : ((univ.erase (1 : G)).card : ℝ) = (Fintype.card G : ℝ) - 1 := by
      rw [Finset.card_erase_of_mem (Finset.mem_univ _), Finset.card_univ]
      have : 1 ≤ Fintype.card G := Fintype.card_pos
      push_cast [Nat.cast_sub this]
      ring
    have hb : ∀ g ∈ univ.erase (1 : G), w Q z g ≤ z ^ (2 : ℝ) * z ^ (-(2 * Q.δ)) := by
      intro g hg
      have hg1 : g ≠ 1 := Finset.ne_of_mem_erase hg
      unfold w
      rw [← Real.rpow_add hz0]
      apply Real.rpow_le_rpow_of_exponent_le hz
      have := Q.gap g hg1
      linarith
    calc ∑ g ∈ univ.erase (1 : G), w Q z g
        ≤ ∑ _g ∈ univ.erase (1 : G), z ^ (2 : ℝ) * z ^ (-(2 * Q.δ)) := Finset.sum_le_sum hb
      _ = ((univ.erase (1 : G)).card : ℝ) * (z ^ (2 : ℝ) * z ^ (-(2 * Q.δ))) := by
          rw [Finset.sum_const, nsmul_eq_mul]
      _ = ((Fintype.card G : ℝ) - 1) * (z ^ (2 : ℝ) * z ^ (-(2 * Q.δ))) := by rw [hcard]
  rw [h1]
  calc z ^ (2 : ℝ) + ∑ g ∈ univ.erase (1 : G), w Q z g
      ≤ z ^ (2 : ℝ) + ((Fintype.card G : ℝ) - 1) * (z ^ (2 : ℝ) * z ^ (-(2 * Q.δ))) := by linarith
    _ = z ^ (2 : ℝ) * (1 + ((Fintype.card G : ℝ) - 1) * z ^ (-(2 * Q.δ))) := by ring

theorem Wsum_nonneg (z : ℝ) (hz : 0 < z) : 0 ≤ Wsum Q z :=
  Finset.sum_nonneg (fun g _ => le_of_lt (w_pos Q z hz g))

/-- the sharpened row bound for either sector: ∑_{s'} z^{ex s s'} K z s s' ≤ z⁶ (1 + (|G| − 1) z^{−2δ})² -/
theorem row_bound_sharp (z : ℝ) (hz : 1 ≤ z) (ex : (G × G) → (G × G) → ℝ) (he : ∀ s s', ex s s' ≤ 2) (s : G × G) :
    ∑ s', z ^ (ex s s') * K Q z s s' ≤ z ^ (6 : ℝ) * (1 + ((Fintype.card G : ℝ) - 1) * z ^ (-(2 * Q.δ))) ^ 2 := by
  have hz0 : 0 < z := lt_of_lt_of_le one_pos hz
  have hW := Wsum_le Q z hz
  have hW0 := Wsum_nonneg Q z hz0
  have hA : 0 ≤ z ^ (2 : ℝ) * (1 + ((Fintype.card G : ℝ) - 1) * z ^ (-(2 * Q.δ))) := by
    have hc : (1 : ℝ) ≤ (Fintype.card G : ℝ) := by exact_mod_cast Fintype.card_pos
    positivity
  calc ∑ s', z ^ (ex s s') * K Q z s s'
      ≤ ∑ s', z ^ (2 : ℝ) * K Q z s s' := by
        apply Finset.sum_le_sum; intro s' _
        apply mul_le_mul_of_nonneg_right _ (le_of_lt (K_pos Q z hz0 s s'))
        exact Real.rpow_le_rpow_of_exponent_le hz (he s s')
    _ = z ^ (2 : ℝ) * (Wsum Q z) ^ 2 := by rw [← Finset.mul_sum, row_sum_exact Q z hz0 s]
    _ ≤ z ^ (2 : ℝ) * (z ^ (2 : ℝ) * (1 + ((Fintype.card G : ℝ) - 1) * z ^ (-(2 * Q.δ)))) ^ 2 := by
        apply mul_le_mul_of_nonneg_left _ (le_of_lt (Real.rpow_pos_of_pos hz0 _))
        exact pow_le_pow_left₀ hW0 hW 2
    _ = z ^ (6 : ℝ) * (1 + ((Fintype.card G : ℝ) - 1) * z ^ (-(2 * Q.δ))) ^ 2 := by
        have : z ^ (6 : ℝ) = z ^ (2 : ℝ) * (z ^ (2 : ℝ)) ^ 2 := by
          rw [← Real.rpow_natCast (z ^ (2 : ℝ)) 2, ← Real.rpow_mul (le_of_lt hz0), ← Real.rpow_add hz0]; norm_num
        rw [this]; ring

/-- THE SHARPENED EATER LAW: both Perron roots in [z⁶, z⁶ (1 + (|G| − 1) z^{−2δ})²] -/
theorem eater_law_sharp (e : Eater G Q) (z : ℝ) (hz : 1 ≤ z) :
    z ^ (6 : ℝ) ≤ lamMax (T Q z) (T_herm Q z) ∧
    lamMax (T Q z) (T_herm Q z) ≤ z ^ (6 : ℝ) * (1 + ((Fintype.card G : ℝ) - 1) * z ^ (-(2 * Q.δ))) ^ 2 ∧
    z ^ (6 : ℝ) ≤ lamMax (Ttw Q z) (Ttw_herm Q z) ∧
    lamMax (Ttw Q z) (Ttw_herm Q z) ≤ z ^ (6 : ℝ) * (1 + ((Fintype.card G : ℝ) - 1) * z ^ (-(2 * Q.δ))) ^ 2 := by
  have hz0 : 0 < z := lt_of_lt_of_le one_pos hz
  refine ⟨lamMax_T_ge Q z hz0, ?_, lamMax_Ttw_ge Q e z hz, ?_⟩
  · apply lamMax_le_rowsum _ _ (T_pos Q z hz0)
    intro s
    exact row_bound_sharp Q z hz (fun s s' => qP Q s + qP Q s')
      (fun s s' => by have := qP_le_one Q s; have := qP_le_one Q s'; linarith) s
  · apply lamMax_le_rowsum _ _ (Ttw_pos Q z hz0)
    intro s
    exact row_bound_sharp Q z hz (fun s s' => -(qP Q s) - qP Q s')
      (fun s s' => by have := qP_ge Q s; have := qP_ge Q s'; linarith) s

end TwistEaterGeneral
