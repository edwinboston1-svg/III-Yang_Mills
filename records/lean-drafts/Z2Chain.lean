/-
  APERANTON -- THE BOUNDLESS, THE Z₂ REHEARSAL OF THE CHAIN (the plan B6, 2026-10-29 00:4x): THE TWO CLAUSES AND THE RAMIFIED
  PLACE BETWEEN THEM, IN THE KERNEL. The chain Σ3 (the strong-coupling clause: Dobrushin's gap on the slab, Z2Slab.lean's
  `transfer_gap_sharp`, admitted at (3m + 2)·(1 − y)/(1 + y) < 1, i.e. y > (3m + 1)/(3m + 3)) and the weak-coupling clause via the
  dual (TorusT3Assembly.lean's `vacuum_two_point_le`, admitted at 17/19 < dualVar y) are two theorems on 4D Z₂, and THE
  SELF-DUAL PLACE y* = √2 − 1 (dualVar y* = y*, the one fixed point of y ↦ (1 − y)/(1 + y) on (0, 1)) is admitted by NEITHER: the
  strong clause needs y > 13/15 at the four-dimensional link degree m = 4, the weak clause needs y < 1/18, and y* = 0.414… lies
  between. This is the chain's law 2 instance, the sighted negative every clause of the SU(2) chain is measured against: a clause
  admitting the self-dual place would be the dead instrument printing a clean world. In the coupling, y = e^{−2β}: the strong
  clause holds for β < ½ ln(15/13) = 0.0716, the weak for β > ½ ln 18 = 1.445, and the transition β_c = ½ ln(1 + √2) = 0.4407
  (y_c = y*) sits in the gap between them -- the clauses refuse exactly where the theory ramifies.  W = 0: the self-duality is
  Wegner's; the arithmetic of the two thresholds and their relation to the fixed point is this file's.  No sorry, no axiom, no
  native_decide.
-/
import Mathlib
import Aperanton.Duality
import Aperanton.Z2Slab
import Aperanton.MassGapChain

namespace Aperanton

/-- the self-dual place of 4D Z₂: the fixed point of the duality map on (0, 1) -/
noncomputable def selfDual : ℝ := Real.sqrt 2 - 1

theorem selfDual_pos : 0 < selfDual := by
  unfold selfDual
  have h : (1 : ℝ) < Real.sqrt 2 := by
    rw [show (1 : ℝ) = Real.sqrt 1 by simp]
    exact Real.sqrt_lt_sqrt (by norm_num) (by norm_num)
  linarith

theorem selfDual_lt_one : selfDual < 1 := by
  unfold selfDual
  have h : Real.sqrt 2 < 2 := by
    rw [show (2 : ℝ) = Real.sqrt 4 by rw [show (4 : ℝ) = 2 ^ 2 by norm_num, Real.sqrt_sq (by norm_num)]]
    exact Real.sqrt_lt_sqrt (by norm_num) (by norm_num)
  linarith

/-- THE FIXED POINT: the duality map fixes the self-dual place -/
theorem dualVar_selfDual : dualVar selfDual = selfDual := by
  unfold dualVar selfDual
  have hs : Real.sqrt 2 * Real.sqrt 2 = 2 := Real.mul_self_sqrt (by norm_num)
  have hne : (1 : ℝ) + (Real.sqrt 2 - 1) ≠ 0 := by
    have := selfDual_pos; unfold selfDual at this; linarith
  rw [div_eq_iff hne]
  nlinarith [hs]

/-- THE STRONG CLAUSE'S THRESHOLD at the four-dimensional link degree: y > 13/15 -/
theorem z2_strong_threshold (y : ℝ) (hy0 : 0 < y) :
    (3 * (4 : ℕ) + 2) * ((1 - y) / (1 + y)) < 1 ↔ (13 : ℝ) / 15 < y := by
  have h := z2_sharp_lt_one 4 y hy0
  norm_num at h ⊢
  exact h

/-- THE WEAK CLAUSE'S THRESHOLD: 17/19 < dualVar y iff y < 1/18 -/
theorem z2_weak_threshold (y : ℝ) (hy0 : 0 < y) : (17 : ℝ) / 19 < dualVar y ↔ y < 1 / 18 := by
  unfold dualVar
  have h1 : (0 : ℝ) < 1 + y := by linarith
  rw [lt_div_iff₀ h1]
  constructor <;> intro h <;> linarith

/-- THE RAMIFIED PLACE REFUSES THE STRONG CLAUSE: the self-dual y* is below 13/15 -/
theorem selfDual_refuses_strong : ¬ ((13 : ℝ) / 15 < selfDual) := by
  unfold selfDual
  have h : Real.sqrt 2 < 1.5 := by
    rw [show (1.5 : ℝ) = Real.sqrt (2.25) by
      rw [show (2.25 : ℝ) = 1.5 ^ 2 by norm_num, Real.sqrt_sq (by norm_num)]]
    exact Real.sqrt_lt_sqrt (by norm_num) (by norm_num)
  intro hc
  linarith

/-- THE RAMIFIED PLACE REFUSES THE WEAK CLAUSE: dualVar y* = y* is above 1/18 -/
theorem selfDual_refuses_weak : ¬ ((17 : ℝ) / 19 < dualVar selfDual) := by
  rw [dualVar_selfDual]
  unfold selfDual
  have h : (1.4 : ℝ) < Real.sqrt 2 := by
    rw [show (1.4 : ℝ) = Real.sqrt (1.96) by
      rw [show (1.96 : ℝ) = 1.4 ^ 2 by norm_num, Real.sqrt_sq (by norm_num)]]
    exact Real.sqrt_lt_sqrt (by norm_num) (by norm_num)
  intro hc
  linarith

/-- THE GAP BETWEEN THE CLAUSES: every y admitted by the strong clause exceeds every y admitted by the weak one, and the
self-dual place lies strictly between the two thresholds -/
theorem clauses_part (y₁ y₂ : ℝ) (h₁ : (13 : ℝ) / 15 < y₁) (h₂ : y₂ < 1 / 18) :
    y₂ < selfDual ∧ selfDual < y₁ := by
  constructor
  · have := selfDual_refuses_weak
    rw [dualVar_selfDual] at this
    unfold selfDual at this ⊢
    have h : (1.4 : ℝ) < Real.sqrt 2 := by
      rw [show (1.4 : ℝ) = Real.sqrt (1.96) by
        rw [show (1.96 : ℝ) = 1.4 ^ 2 by norm_num, Real.sqrt_sq (by norm_num)]]
      exact Real.sqrt_lt_sqrt (by norm_num) (by norm_num)
    linarith
  · have := selfDual_refuses_strong
    unfold selfDual at this ⊢
    have h : Real.sqrt 2 < 1.5 := by
      rw [show (1.5 : ℝ) = Real.sqrt (2.25) by
        rw [show (2.25 : ℝ) = 1.5 ^ 2 by norm_num, Real.sqrt_sq (by norm_num)]]
      exact Real.sqrt_lt_sqrt (by norm_num) (by norm_num)
    linarith

/-- THE STRONG CLAUSE OF THE CHAIN ON 4D Z₂, WHOLE (the plan B6, order (2) of 01:5x): at the four-dimensional link degree, for
every y above the explicit threshold 13/15, every non-Perron eigenvalue of the slab transfer matrix is at most
14·(1 − y)/(1 + y) times the Perron root -- Σ3 for the Z₂ slab with its hypothesis as a number, Z2Slab's transfer_gap_sharp
composed with z2_sharp_lt_one -/
theorem z2_chain_strong {V Lk : Type*} [DecidableEq V] [Fintype Lk] [DecidableEq Lk] {Λ : Lat V Lk}
    {ι : Type*} [Fintype ι] [DecidableEq ι] (sq : ι → Square Λ) (y : ℝ) (hy0 : 0 < y) (hy1 : y ≤ 1)
    (hk : (kZ2 y).PosSemidef) (hm : ∀ ℓ, linkDegree sq ℓ ≤ 4) (hy : (13 : ℝ) / 15 < y) (j : Lk → Z2)
    (hj : (transfer_posSemidef (plaqWeight sq (wZ2 y)) _ (tensorKernel_posSemidef (kZ2 y) hk)).1.eigenvalues j ≠
      lamMax (transfer (plaqWeight sq (wZ2 y)) (tensorKernel (kZ2 y)))
        (transfer_posSemidef (plaqWeight sq (wZ2 y)) _ (tensorKernel_posSemidef (kZ2 y) hk)).1) :
    (transfer_posSemidef (plaqWeight sq (wZ2 y)) _ (tensorKernel_posSemidef (kZ2 y) hk)).1.eigenvalues j ≤
      ((3 * (4 : ℕ) + 2) * ((1 - y) / (1 + y))) * lamMax (transfer (plaqWeight sq (wZ2 y)) (tensorKernel (kZ2 y)))
        (transfer_posSemidef (plaqWeight sq (wZ2 y)) _ (tensorKernel_posSemidef (kZ2 y) hk)).1 :=
  transfer_gap_sharp sq y hy0 hy1 hk 4 hm ((z2_strong_threshold y hy0).mpr hy) j hj

/-- the strong clause's rate is a genuine contraction: 14(1 − y)/(1 + y) lies in (0, 1) on the admitted interval -/
theorem z2_strong_rate_lt_one (y : ℝ) (hy0 : 0 < y) (hy1 : y < 1) (hy : (13 : ℝ) / 15 < y) :
    0 < (3 * (4 : ℕ) + 2) * ((1 - y) / (1 + y)) ∧ (3 * (4 : ℕ) + 2) * ((1 - y) / (1 + y)) < 1 := by
  constructor
  · apply mul_pos (by norm_num)
    apply div_pos <;> linarith
  · exact (z2_strong_threshold y hy0).mpr hy

/-- THE PHYSICAL RATE OF THE Z₂ CHAIN: along any scaling sequence, the strong clause's contraction 14(1 − y)/(1 + y) at range R
and coarse spacing a_c is the physical rate log(1/α)/(R a_c), positive -- Σ3 + Σ4 + Σ5 in the one case where every link is in
the kernel (the finite group), with the ramified place where the clause refuses exhibited above -/
theorem z2_chain_physical (Sc : Scaling) (y : ℝ) (hy0 : 0 < y) (hy1 : y < 1) (hy : (13 : ℝ) / 15 < y)
    (R : ℕ) (hR : 0 < R) (a_c : ℝ) (hac : 0 < a_c) :
    PhysicalGapAlong Sc
      (fun n => Real.log (1 / ((3 * (4 : ℕ) + 2) * ((1 - y) / (1 + y)))) * Sc.a n / (R * a_c))
      (Real.log (1 / ((3 * (4 : ℕ) + 2) * ((1 - y) / (1 + y)))) / (R * a_c)) ∧
    0 < Real.log (1 / ((3 * (4 : ℕ) + 2) * ((1 - y) / (1 + y)))) / (R * a_c) := by
  obtain ⟨hα0, hα1⟩ := z2_strong_rate_lt_one y hy0 hy1 hy
  exact ⟨physicalGap_of_budget Sc _ hα0 hα1 R hR a_c hac, physicalRate_pos _ hα0 hα1 R hR a_c hac⟩

end Aperanton
