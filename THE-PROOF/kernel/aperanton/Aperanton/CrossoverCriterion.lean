/-
  APERANTON -- THE BOUNDLESS, THE CROSSOVER CRITERION (the master plan note §57, 2026-10-28 22:3x): THE CONSUMER OF THE
  CROSSOVER THEOREM, PROVED. Dobrushin's comparison theorem (Dobrushin.lean) turns an interdependence matrix with row sums below
  one into an infinite-volume decay rate; the crossover theorem must deliver such a matrix for the BLOCKED Wilson measure, whose
  action is a Wilson weight W plus a non-Wilson part δ. Here that delivery is made quantitative with no hypothesis on δ beyond
  two oscillations. THE TILT LEMMAS: a probability vector tilted by exp ρ with ρ of oscillation at most o moves by at most
  1 − e^{−o} in total variation (`tv_tilt_le`), and two vectors tilted by the SAME ρ keep their distance up to the factor
  2e^{2o} − 1 (`tv_tilt_pair_le`, exact at o = 0). THE PERTURBED INTERDEPENDENCE (`interdep_tilt`): if W has interdependence C,
  δ oscillates by at most o s along the fibre of s and its mixed second difference in (s, t) is at most Δ s t, then W · exp δ has
  interdependence (2e^{2 o s} − 1) C s t + (1 − e^{−Δ s t}). THE CRITERION (`rowsum_tilt_le`): the row sums are at most
  (2e^{2 o s} − 1) α + Σ_t (1 − e^{−Δ s t}) when C's are at most α. So a blocked action Wilson(β*) + δ inherits the gap of cov_le
  exactly when (2e^{2o} − 1) · 18 c₁(β*) + Σ_t (1 − e^{−Δ_{st} δ}) < 1 -- the influence budget, what the analytic control of the
  crossover must deliver, with its number. The oscillations are the only hypotheses: no smallness of δ itself, no locality beyond
  what Δ encodes (a polymer containing s and t), no symmetry. W = 0: the triangle inequality for the total variation and
  Dobrushin's matrix; the two tilt constants are this file's. No sorry, no axiom, no native_decide.
-/
import Mathlib
import Aperanton.Dobrushin

open Finset

namespace Aperanton

variable {S G : Type*} [Fintype S] [DecidableEq S] [Fintype G] [DecidableEq G]

/-- the total variation is symmetric -/
theorem tv_comm (p q : G → ℝ) : tv p q = tv q p := by
  unfold tv
  congr 1
  exact sum_congr rfl (fun g _ => abs_sub_comm _ _)

/-- a weight tilted by exp δ -/
noncomputable def tilt (W : (S → G) → ℝ) (δ : (S → G) → ℝ) : (S → G) → ℝ := fun ω => W ω * Real.exp (δ ω)

theorem tilt_pos (W : (S → G) → ℝ) (hW : ∀ ω, 0 < W ω) (δ : (S → G) → ℝ) : ∀ ω, 0 < tilt W δ ω :=
  fun ω => mul_pos (hW ω) (Real.exp_pos _)

/-- the normaliser of a tilted vector -/
noncomputable def ptiltZ (p : G → ℝ) (ρ : G → ℝ) : ℝ := ∑ h, p h * Real.exp (ρ h)

/-- a probability vector tilted by exp ρ, normalised -/
noncomputable def ptilt (p : G → ℝ) (ρ : G → ℝ) : G → ℝ := fun g => p g * Real.exp (ρ g) / ptiltZ p ρ

theorem ptiltZ_pos (p : G → ℝ) (hp : ∀ g, 0 ≤ p g) (h1 : ∑ g, p g = 1) (ρ : G → ℝ) : 0 < ptiltZ p ρ := by
  unfold ptiltZ
  have hne : ∃ g, 0 < p g := by
    by_contra hcon
    push_neg at hcon
    have : ∑ g, p g = 0 := sum_eq_zero fun g _ => le_antisymm (hcon g) (hp g)
    linarith
  obtain ⟨g0, hg0⟩ := hne
  have hterm : 0 < p g0 * Real.exp (ρ g0) := mul_pos hg0 (Real.exp_pos _)
  refine lt_of_lt_of_le hterm ?_
  exact single_le_sum (fun h _ => mul_nonneg (hp h) (Real.exp_pos _).le) (mem_univ g0)

theorem ptilt_nonneg (p : G → ℝ) (hp : ∀ g, 0 ≤ p g) (h1 : ∑ g, p g = 1) (ρ : G → ℝ) (g : G) :
    0 ≤ ptilt p ρ g :=
  div_nonneg (mul_nonneg (hp g) (Real.exp_pos _).le) (ptiltZ_pos p hp h1 ρ).le

theorem ptilt_sum (p : G → ℝ) (hp : ∀ g, 0 ≤ p g) (h1 : ∑ g, p g = 1) (ρ : G → ℝ) :
    ∑ g, ptilt p ρ g = 1 := by
  unfold ptilt
  rw [← sum_div]
  exact div_self (ptiltZ_pos p hp h1 ρ).ne'

/-- the oscillation of ρ: every two values within o -/
def Osc (ρ : G → ℝ) (o : ℝ) : Prop := ∀ g g', |ρ g - ρ g'| ≤ o

theorem osc_nonneg [Nonempty G] {ρ : G → ℝ} {o : ℝ} (h : Osc ρ o) : 0 ≤ o := by
  obtain ⟨g⟩ : Nonempty G := inferInstance
  exact le_trans (abs_nonneg _) (h g g)

theorem osc_exp_le {ρ : G → ℝ} {o : ℝ} (h : Osc ρ o) (g g' : G) :
    Real.exp (ρ g) ≤ Real.exp (o) * Real.exp (ρ g') := by
  rw [← Real.exp_add]
  apply Real.exp_le_exp.mpr
  have := (abs_le.mp (h g g')).2
  linarith

/-- the normaliser lies within e^{±o} of every single exponential -/
theorem ptiltZ_le (p : G → ℝ) (hp : ∀ g, 0 ≤ p g) (h1 : ∑ g, p g = 1) (ρ : G → ℝ) (o : ℝ) (ho : Osc ρ o)
    (g : G) : ptiltZ p ρ ≤ Real.exp o * Real.exp (ρ g) := by
  unfold ptiltZ
  calc ∑ h, p h * Real.exp (ρ h) ≤ ∑ h, p h * (Real.exp o * Real.exp (ρ g)) := by
        apply sum_le_sum
        intro h _
        exact mul_le_mul_of_nonneg_left (osc_exp_le ho h g) (hp h)
    _ = Real.exp o * Real.exp (ρ g) := by rw [← sum_mul, h1, one_mul]

theorem ptiltZ_ge (p : G → ℝ) (hp : ∀ g, 0 ≤ p g) (h1 : ∑ g, p g = 1) (ρ : G → ℝ) (o : ℝ) (ho : Osc ρ o)
    (g : G) : Real.exp (ρ g) ≤ Real.exp o * ptiltZ p ρ := by
  unfold ptiltZ
  rw [mul_sum]
  calc Real.exp (ρ g) = ∑ h, p h * Real.exp (ρ g) := by rw [← sum_mul, h1, one_mul]
    _ ≤ ∑ h, Real.exp o * (p h * Real.exp (ρ h)) := by
        apply sum_le_sum
        intro h _
        rw [← mul_assoc, mul_comm (Real.exp o) (p h), mul_assoc]
        exact mul_le_mul_of_nonneg_left (osc_exp_le ho g h) (hp h)

/-- THE FIRST TILT LEMMA: a tilt of oscillation o moves a probability vector by at most 1 − e^{−o} -/
theorem tv_tilt_le [Nonempty G] (p : G → ℝ) (hp : ∀ g, 0 ≤ p g) (h1 : ∑ g, p g = 1) (ρ : G → ℝ) (o : ℝ)
    (ho : Osc ρ o) : tv p (ptilt p ρ) ≤ 1 - Real.exp (-o) := by
  have ho0 : 0 ≤ o := osc_nonneg ho
  have hZ := ptiltZ_pos p hp h1 ρ
  have hr : 1 ≤ Real.exp o := Real.one_le_exp ho0
  have hpt : ∀ g, p g ≤ Real.exp o * ptilt p ρ g := by
    intro g
    unfold ptilt
    rw [mul_div_assoc', le_div_iff₀ hZ]
    calc p g * ptiltZ p ρ ≤ p g * (Real.exp o * Real.exp (ρ g)) :=
          mul_le_mul_of_nonneg_left (ptiltZ_le p hp h1 ρ o ho g) (hp g)
      _ = Real.exp o * (p g * Real.exp (ρ g)) := by ring
  have := tv_le_of_pointwise p (ptilt p ρ) hp h1 (ptilt_sum p hp h1 ρ) (Real.exp o) hr hpt
  rwa [one_div, ← Real.exp_neg] at this

/-- the tilted difference at one point, bounded by the plain difference and the normalisers' gap -/
theorem ptilt_sub_abs_le (p q ρ : G → ℝ) (hq : ∀ g, 0 ≤ q g) (hZp : 0 < ptiltZ p ρ) (hZq : 0 < ptiltZ q ρ)
    (g : G) :
    |ptilt p ρ g - ptilt q ρ g| ≤ |p g - q g| * (Real.exp (ρ g) / ptiltZ p ρ)
      + q g * (Real.exp (ρ g) / ptiltZ q ρ) * (|ptiltZ q ρ - ptiltZ p ρ| / ptiltZ p ρ) := by
  unfold ptilt
  have h1 : p g * Real.exp (ρ g) / ptiltZ p ρ - q g * Real.exp (ρ g) / ptiltZ q ρ
      = (p g - q g) * (Real.exp (ρ g) / ptiltZ p ρ)
        + q g * (Real.exp (ρ g) / ptiltZ q ρ) * ((ptiltZ q ρ - ptiltZ p ρ) / ptiltZ p ρ) := by
    have hp0 := hZp.ne'
    have hq0 := hZq.ne'
    field_simp
    ring
  rw [h1]
  calc |(p g - q g) * (Real.exp (ρ g) / ptiltZ p ρ)
        + q g * (Real.exp (ρ g) / ptiltZ q ρ) * ((ptiltZ q ρ - ptiltZ p ρ) / ptiltZ p ρ)|
      ≤ |(p g - q g) * (Real.exp (ρ g) / ptiltZ p ρ)|
        + |q g * (Real.exp (ρ g) / ptiltZ q ρ) * ((ptiltZ q ρ - ptiltZ p ρ) / ptiltZ p ρ)| := abs_add_le _ _
    _ = |p g - q g| * (Real.exp (ρ g) / ptiltZ p ρ)
        + q g * (Real.exp (ρ g) / ptiltZ q ρ) * (|ptiltZ q ρ - ptiltZ p ρ| / ptiltZ p ρ) := by
        simp only [abs_mul, abs_div, abs_of_pos hZp, abs_of_pos hZq, abs_of_pos (Real.exp_pos (ρ g)),
          abs_of_nonneg (hq g)]

/-- THE SECOND TILT LEMMA: the same tilt on two probability vectors keeps their distance up to 2e^{2o} − 1 -/
theorem tv_tilt_pair_le [Nonempty G] (p q : G → ℝ) (hp : ∀ g, 0 ≤ p g) (hq : ∀ g, 0 ≤ q g)
    (h1 : ∑ g, p g = 1) (h1' : ∑ g, q g = 1) (ρ : G → ℝ) (o : ℝ) (ho : Osc ρ o) :
    tv (ptilt p ρ) (ptilt q ρ) ≤ (2 * Real.exp (2 * o) - 1) * tv p q := by
  have ho0 : 0 ≤ o := osc_nonneg ho
  have hZp := ptiltZ_pos p hp h1 ρ
  have hZq := ptiltZ_pos q hq h1' ρ
  obtain ⟨g0⟩ : Nonempty G := inferInstance
  have hE : Real.exp (2 * o) = Real.exp o * Real.exp o := by rw [← Real.exp_add]; ring_nf
  -- every ratio e^{ρ g}/Z is at most e^o
  have hratio : ∀ (r : G → ℝ), (∀ g, 0 ≤ r g) → ∑ g, r g = 1 → ∀ g, Real.exp (ρ g) / ptiltZ r ρ ≤ Real.exp o := by
    intro r hr hr1 g
    rw [div_le_iff₀ (ptiltZ_pos r hr hr1 ρ)]
    exact ptiltZ_ge r hr hr1 ρ o ho g
  -- the normalisers' gap: Z_q − Z_p = Σ (q − p)(e^{ρ} − e^{ρ g0 − o}), each factor at most e^{ρ g0}(e^{o} − e^{−o})
  have hgap : |ptiltZ q ρ - ptiltZ p ρ| ≤ 2 * tv p q * (Real.exp (ρ g0) * (Real.exp o - Real.exp (-o))) := by
    have hzero : ∑ g, (q g - p g) = 0 := by rw [sum_sub_distrib, h1', h1, sub_self]
    have hrew : ptiltZ q ρ - ptiltZ p ρ
        = ∑ g, (q g - p g) * (Real.exp (ρ g) - Real.exp (ρ g0 - o)) := by
      unfold ptiltZ
      have : ∑ g, (q g - p g) * (Real.exp (ρ g) - Real.exp (ρ g0 - o))
          = ∑ g, (q g - p g) * Real.exp (ρ g) - (∑ g, (q g - p g)) * Real.exp (ρ g0 - o) := by
        rw [sum_mul, ← sum_sub_distrib]
        apply sum_congr rfl
        intro g _
        ring
      rw [this, hzero, zero_mul, sub_zero, ← sum_sub_distrib]
      apply sum_congr rfl
      intro g _
      ring
    rw [hrew]
    calc |∑ g, (q g - p g) * (Real.exp (ρ g) - Real.exp (ρ g0 - o))|
        ≤ ∑ g, |(q g - p g) * (Real.exp (ρ g) - Real.exp (ρ g0 - o))| := abs_sum_le_sum_abs _ _
      _ ≤ ∑ g, |q g - p g| * (Real.exp (ρ g0) * (Real.exp o - Real.exp (-o))) := by
          apply sum_le_sum
          intro g _
          rw [abs_mul]
          apply mul_le_mul_of_nonneg_left _ (abs_nonneg _)
          -- e^{ρ g0 − o} ≤ e^{ρ g} ≤ e^{ρ g0 + o}
          have hlo : Real.exp (ρ g0 - o) ≤ Real.exp (ρ g) := by
            apply Real.exp_le_exp.mpr
            have := (abs_le.mp (ho g0 g)).2
            linarith
          have hhi : Real.exp (ρ g) ≤ Real.exp (ρ g0 + o) := by
            apply Real.exp_le_exp.mpr
            have := (abs_le.mp (ho g g0)).2
            linarith
          rw [abs_of_nonneg (by linarith)]
          have : Real.exp (ρ g0) * (Real.exp o - Real.exp (-o)) = Real.exp (ρ g0 + o) - Real.exp (ρ g0 - o) := by
            rw [mul_sub, ← Real.exp_add, ← Real.exp_add]; ring_nf
          rw [this]
          linarith
      _ = (∑ g, |q g - p g|) * (Real.exp (ρ g0) * (Real.exp o - Real.exp (-o))) := by rw [sum_mul]
      _ = 2 * tv p q * (Real.exp (ρ g0) * (Real.exp o - Real.exp (-o))) := by
          unfold tv
          have : ∑ g, |q g - p g| = ∑ g, |p g - q g| := by
            apply sum_congr rfl
            intro g _
            rw [abs_sub_comm]
          rw [this]
          ring
  -- Z_p ≥ e^{ρ g0 − o}
  have hZplo : Real.exp (ρ g0 - o) ≤ ptiltZ p ρ := by
    have := ptiltZ_ge p hp h1 ρ o ho g0
    rw [Real.exp_sub, div_le_iff₀ (Real.exp_pos o)]
    linarith [mul_comm (Real.exp o) (ptiltZ p ρ)]
  have hgapratio : |ptiltZ q ρ - ptiltZ p ρ| / ptiltZ p ρ ≤ 2 * tv p q * (Real.exp (2 * o) - 1) := by
    rw [div_le_iff₀ hZp]
    calc |ptiltZ q ρ - ptiltZ p ρ|
        ≤ 2 * tv p q * (Real.exp (ρ g0) * (Real.exp o - Real.exp (-o))) := hgap
      _ = 2 * tv p q * (Real.exp (2 * o) - 1) * Real.exp (ρ g0 - o) := by
          rw [hE, Real.exp_sub, Real.exp_neg]
          field_simp
      _ ≤ 2 * tv p q * (Real.exp (2 * o) - 1) * ptiltZ p ρ := by
          apply mul_le_mul_of_nonneg_left hZplo
          apply mul_nonneg (mul_nonneg (by norm_num) (tv_nonneg _ _))
          have : 1 ≤ Real.exp (2 * o) := Real.one_le_exp (by linarith)
          linarith
  -- assemble: Σ |p' − q'| ≤ e^o Σ|p − q| + (Σ q e^{ρ}/Z_q) · gap/Z_p = e^o · 2tv + 1 · gap/Z_p
  have hsumq : ∑ g, q g * (Real.exp (ρ g) / ptiltZ q ρ) = 1 := by
    have : ∑ g, q g * (Real.exp (ρ g) / ptiltZ q ρ) = (∑ g, q g * Real.exp (ρ g)) / ptiltZ q ρ := by
      rw [sum_div]
      apply sum_congr rfl
      intro g _
      ring
    rw [this]
    exact div_self hZq.ne'
  unfold tv
  rw [div_le_iff₀ (by norm_num : (0:ℝ) < 2)]
  calc ∑ g, |ptilt p ρ g - ptilt q ρ g|
      ≤ ∑ g, (|p g - q g| * (Real.exp (ρ g) / ptiltZ p ρ)
          + q g * (Real.exp (ρ g) / ptiltZ q ρ) * (|ptiltZ q ρ - ptiltZ p ρ| / ptiltZ p ρ)) := by
        apply sum_le_sum
        intro g _
        exact ptilt_sub_abs_le p q ρ hq hZp hZq g
    _ = ∑ g, |p g - q g| * (Real.exp (ρ g) / ptiltZ p ρ)
          + (∑ g, q g * (Real.exp (ρ g) / ptiltZ q ρ)) * (|ptiltZ q ρ - ptiltZ p ρ| / ptiltZ p ρ) := by
        rw [sum_add_distrib, sum_mul]
    _ ≤ ∑ g, |p g - q g| * Real.exp o
          + 1 * (2 * tv p q * (Real.exp (2 * o) - 1)) := by
        rw [hsumq]
        apply add_le_add
        · apply sum_le_sum
          intro g _
          exact mul_le_mul_of_nonneg_left (hratio p hp h1 g) (abs_nonneg _)
        · rw [one_mul, one_mul]
          exact hgapratio
    _ ≤ (2 * Real.exp (2 * o) - 1) * tv p q * 2 := by
        unfold tv
        rw [← sum_mul]
        have h2o : Real.exp o ≤ Real.exp (2 * o) := Real.exp_le_exp.mpr (by linarith)
        have hs : 0 ≤ ∑ g, |p g - q g| := sum_nonneg (fun g _ => abs_nonneg _)
        nlinarith [mul_nonneg hs (sub_nonneg.mpr h2o)]

/-- the one-site conditional of a tilted weight is the tilted conditional (the tilt read along the fibre of s) -/
theorem cond_tilt [Nonempty G] (W : (S → G) → ℝ) (hW : ∀ ω, 0 < W ω) (δ : (S → G) → ℝ) (s : S) (ω : S → G) :
    cond (tilt W δ) s ω = ptilt (cond W s ω) (fun g => δ (Function.update ω s g)) := by
  funext g
  unfold cond ptilt ptiltZ zsite tilt
  have hz := zsite_pos W hW s ω
  unfold zsite at hz
  simp_rw [div_mul_eq_mul_div]
  rw [← sum_div, div_div_div_cancel_right₀ hz.ne']

/-- the mixed second difference of δ in (s, t) is at most Δ s t -/
def MixedDiff (δ : (S → G) → ℝ) (Δ : S → S → ℝ) : Prop :=
  ∀ s t ω h g g', |(δ (Function.update ω s g) - δ (Function.update (Function.update ω t h) s g))
    - (δ (Function.update ω s g') - δ (Function.update (Function.update ω t h) s g'))| ≤ Δ s t

/-- THE PERTURBED INTERDEPENDENCE: W · exp δ has interdependence (2e^{2 o s} − 1) C s t + (1 − e^{−Δ s t}) -/
theorem interdep_tilt [Nonempty G] (W : (S → G) → ℝ) (hW : ∀ ω, 0 < W ω) (C : S → S → ℝ) (hC : Interdep W C)
    (δ : (S → G) → ℝ) (o : S → ℝ) (ho : OscBound δ o) (Δ : S → S → ℝ) (hΔ : MixedDiff δ Δ) :
    Interdep (tilt W δ) (fun s t => (2 * Real.exp (2 * o s) - 1) * C s t + (1 - Real.exp (-Δ s t))) := by
  intro s t hst ω h
  rw [cond_tilt W hW δ s ω, cond_tilt W hW δ s (Function.update ω t h)]
  set p := cond W s ω with hp
  set q := cond W s (Function.update ω t h) with hq
  set ρ₁ : G → ℝ := fun g => δ (Function.update ω s g) with hρ₁
  set ρ₂ : G → ℝ := fun g => δ (Function.update (Function.update ω t h) s g) with hρ₂
  have hpn : ∀ g, 0 ≤ p g := cond_nonneg W hW s ω
  have hqn : ∀ g, 0 ≤ q g := cond_nonneg W hW s _
  have hp1 : ∑ g, p g = 1 := cond_sum W hW s ω
  have hq1 : ∑ g, q g = 1 := cond_sum W hW s _
  have hosc1 : Osc ρ₁ (o s) := fun g g' => ho s ω g g'
  -- ρ₂ = ρ₁ + (ρ₂ − ρ₁), and the tilt of a tilt is the tilt by the sum
  have hcomp : ptilt q ρ₂ = ptilt (ptilt q ρ₁) (fun g => ρ₂ g - ρ₁ g) := by
    funext g
    unfold ptilt ptiltZ
    have hZ1 := ptiltZ_pos q hqn hq1 ρ₁
    unfold ptiltZ at hZ1
    have key : ∀ x, q x * Real.exp (ρ₁ x) / (∑ x', q x' * Real.exp (ρ₁ x')) * Real.exp (ρ₂ x - ρ₁ x)
        = q x * Real.exp (ρ₂ x) / (∑ x', q x' * Real.exp (ρ₁ x')) := by
      intro x
      rw [Real.exp_sub]
      field_simp
    simp_rw [key]
    rw [← sum_div, div_div_div_cancel_right₀ hZ1.ne']
  have hosc2 : Osc (fun g => ρ₂ g - ρ₁ g) (Δ s t) := by
    intro g g'
    have := hΔ s t ω h g g'
    simp only [hρ₁, hρ₂]
    rw [← abs_neg]
    convert this using 2
    ring
  -- the triangle: tv(p^ρ₁, q^ρ₂) ≤ tv(p^ρ₁, q^ρ₁) + tv(q^ρ₁, (q^ρ₁)^{ρ₂−ρ₁})
  have htri : tv (ptilt p ρ₁) (ptilt q ρ₂) ≤ tv (ptilt p ρ₁) (ptilt q ρ₁) + tv (ptilt q ρ₁) (ptilt q ρ₂) := by
    unfold tv
    rw [← add_div]
    gcongr
    rw [← sum_add_distrib]
    apply sum_le_sum
    intro g _
    exact abs_sub_le _ _ _
  have h1 : tv (ptilt p ρ₁) (ptilt q ρ₁) ≤ (2 * Real.exp (2 * o s) - 1) * C s t := by
    calc tv (ptilt p ρ₁) (ptilt q ρ₁) ≤ (2 * Real.exp (2 * o s) - 1) * tv p q :=
          tv_tilt_pair_le p q hpn hqn hp1 hq1 ρ₁ (o s) hosc1
      _ ≤ (2 * Real.exp (2 * o s) - 1) * C s t := by
          apply mul_le_mul_of_nonneg_left (hC s t hst ω h)
          have : 1 ≤ Real.exp (2 * o s) := Real.one_le_exp (by linarith [oscBound_nonneg ho s])
          linarith
  have h2 : tv (ptilt q ρ₁) (ptilt q ρ₂) ≤ 1 - Real.exp (-Δ s t) := by
    rw [hcomp]
    exact tv_tilt_le (ptilt q ρ₁) (ptilt_nonneg q hqn hq1 ρ₁) (ptilt_sum q hqn hq1 ρ₁) _ (Δ s t) hosc2
  linarith

/-- the total variation of two probability vectors is the positive part of their difference, summed -/
theorem tv_eq_sum_pos (p p' : G → ℝ) (h1 : ∑ g, p g = 1) (h1' : ∑ g, p' g = 1) :
    tv p p' = ∑ g, max (p g - p' g) 0 := by
  have habs : ∀ x : ℝ, |x| = 2 * max x 0 - x := by
    intro x
    rcases le_or_gt 0 x with hx | hx
    · rw [abs_of_nonneg hx, max_eq_left hx]; ring
    · rw [abs_of_neg hx, max_eq_right hx.le]; ring
  have hzero : ∑ g, (p g - p' g) = 0 := by rw [sum_sub_distrib, h1, h1', sub_self]
  unfold tv
  rw [show (∑ g, |p g - p' g|) = ∑ g, (2 * max (p g - p' g) 0 - (p g - p' g)) from
    sum_congr rfl (fun g _ => habs _)]
  rw [sum_sub_distrib, hzero, sub_zero, ← mul_sum]
  ring

/-- THE SHARP SECOND TILT LEMMA: the same tilt on two probability vectors keeps their distance up to e^{o} -/
theorem tv_tilt_pair_le_sharp [Nonempty G] (p q : G → ℝ) (hp : ∀ g, 0 ≤ p g) (hq : ∀ g, 0 ≤ q g)
    (h1 : ∑ g, p g = 1) (h1' : ∑ g, q g = 1) (ρ : G → ℝ) (o : ℝ) (ho : Osc ρ o) :
    tv (ptilt p ρ) (ptilt q ρ) ≤ Real.exp o * tv p q := by
  classical
  have hZp := ptiltZ_pos p hp h1 ρ
  have hZq := ptiltZ_pos q hq h1' ρ
  have hp'n := ptilt_nonneg p hp h1 ρ
  have hq'n := ptilt_nonneg q hq h1' ρ
  have hp'1 := ptilt_sum p hp h1 ρ
  have hq'1 := ptilt_sum q hq h1' ρ
  obtain ⟨g0, -, hg0⟩ := exists_min_image univ ρ univ_nonempty
  set m := Real.exp (ρ g0) with hm
  have hmpos : 0 < m := Real.exp_pos _
  have hwlo : ∀ g, m ≤ Real.exp (ρ g) := fun g => Real.exp_le_exp.mpr (hg0 g (mem_univ g))
  have hwhi : ∀ g, Real.exp (ρ g) ≤ Real.exp o * m := fun g => osc_exp_le ho g g0
  have hZpm : m ≤ ptiltZ p ρ := by
    unfold ptiltZ
    calc m = ∑ g, p g * m := by rw [← sum_mul, h1, one_mul]
      _ ≤ ∑ g, p g * Real.exp (ρ g) := sum_le_sum fun g _ => mul_le_mul_of_nonneg_left (hwlo g) (hp g)
  -- the difference and its positive and negative parts
  set d : G → ℝ := fun g => p g - q g with hd
  have hdzero : ∑ g, d g = 0 := by simp only [hd]; rw [sum_sub_distrib, h1, h1', sub_self]
  have htv : tv p q = ∑ g, max (d g) 0 := tv_eq_sum_pos p q h1 h1'
  have htvneg : tv p q = ∑ g, max (-d g) 0 := by
    have := tv_eq_sum_pos q p h1' h1
    rw [tv_comm] at this
    simpa [hd, neg_sub] using this
  -- the positive set A of the tilted difference
  set A : Finset G := univ.filter (fun g => 0 < ptilt p ρ g - ptilt q ρ g) with hA
  have htv' : tv (ptilt p ρ) (ptilt q ρ) = ∑ g ∈ A, (ptilt p ρ g - ptilt q ρ g) := by
    rw [tv_eq_sum_pos _ _ hp'1 hq'1, ← sum_filter_add_sum_filter_not univ (fun g => 0 < ptilt p ρ g - ptilt q ρ g)]
    have h2 : ∑ g ∈ univ.filter (fun g => ¬ 0 < ptilt p ρ g - ptilt q ρ g), max (ptilt p ρ g - ptilt q ρ g) 0 = 0 := by
      apply sum_eq_zero
      intro g hg
      rw [mem_filter] at hg
      exact max_eq_right (not_lt.mp hg.2)
    rw [h2, add_zero]
    apply sum_congr rfl
    intro g hg
    rw [mem_filter] at hg
    exact max_eq_left hg.2.le
  -- the tilted difference over A, written through the normalisers
  have hqA : 0 ≤ ∑ g ∈ A, ptilt q ρ g := sum_nonneg fun g _ => hq'n g
  have hqA1 : ∑ g ∈ A, ptilt q ρ g ≤ 1 := by
    rw [← hq'1]
    exact sum_le_sum_of_subset_of_nonneg (subset_univ A) (fun g _ _ => hq'n g)
  have hZdiff : ptiltZ q ρ - ptiltZ p ρ = -(∑ g, Real.exp (ρ g) * d g) := by
    unfold ptiltZ
    rw [← sum_sub_distrib, ← sum_neg_distrib]
    apply sum_congr rfl
    intro g _
    simp only [hd]
    ring
  have hsplit : ∑ g, Real.exp (ρ g) * d g
      = ∑ g ∈ A, Real.exp (ρ g) * d g + ∑ g ∈ univ.filter (fun g => g ∉ A), Real.exp (ρ g) * d g := by
    rw [← sum_filter_add_sum_filter_not univ (fun g => g ∈ A)]
    congr 1
    apply sum_congr _ (fun _ _ => rfl)
    ext g
    simp [hA]
  have hident : ∑ g ∈ A, (ptilt p ρ g - ptilt q ρ g)
      = ((∑ g ∈ A, Real.exp (ρ g) * d g) * (1 - ∑ g ∈ A, ptilt q ρ g)
        - (∑ g ∈ A, ptilt q ρ g) * (∑ g ∈ univ.filter (fun g => g ∉ A), Real.exp (ρ g) * d g)) / ptiltZ p ρ := by
    have hterm : ∀ g, ptilt p ρ g - ptilt q ρ g
        = (Real.exp (ρ g) * d g + ptilt q ρ g * (ptiltZ q ρ - ptiltZ p ρ)) / ptiltZ p ρ := by
      intro g
      unfold ptilt
      simp only [hd]
      field_simp
      ring
    rw [sum_congr rfl (fun g _ => hterm g), ← sum_div, sum_add_distrib, ← sum_mul, hZdiff, hsplit]
    congr 1
    ring
  -- the bounds on the two signed sums
  have hpos : ∑ g ∈ A, Real.exp (ρ g) * d g ≤ Real.exp o * m * tv p q := by
    rw [htv]
    calc ∑ g ∈ A, Real.exp (ρ g) * d g ≤ ∑ g ∈ A, Real.exp (ρ g) * max (d g) 0 :=
          sum_le_sum fun g _ => mul_le_mul_of_nonneg_left (le_max_left _ _) (Real.exp_pos _).le
      _ ≤ ∑ g ∈ A, (Real.exp o * m) * max (d g) 0 :=
          sum_le_sum fun g _ => mul_le_mul_of_nonneg_right (hwhi g) (le_max_right _ _)
      _ ≤ ∑ g, (Real.exp o * m) * max (d g) 0 :=
          sum_le_sum_of_subset_of_nonneg (subset_univ A)
            (fun g _ _ => mul_nonneg (mul_nonneg (Real.exp_pos _).le hmpos.le) (le_max_right _ _))
      _ = Real.exp o * m * ∑ g, max (d g) 0 := by rw [mul_sum]
  have hneg : -(∑ g ∈ univ.filter (fun g => g ∉ A), Real.exp (ρ g) * d g) ≤ Real.exp o * m * tv p q := by
    rw [htvneg, ← sum_neg_distrib]
    calc ∑ g ∈ univ.filter (fun g => g ∉ A), -(Real.exp (ρ g) * d g)
        ≤ ∑ g ∈ univ.filter (fun g => g ∉ A), Real.exp (ρ g) * max (-d g) 0 := by
          apply sum_le_sum
          intro g _
          rw [neg_mul_eq_mul_neg]
          exact mul_le_mul_of_nonneg_left (le_max_left _ _) (Real.exp_pos _).le
      _ ≤ ∑ g ∈ univ.filter (fun g => g ∉ A), (Real.exp o * m) * max (-d g) 0 :=
          sum_le_sum fun g _ => mul_le_mul_of_nonneg_right (hwhi g) (le_max_right _ _)
      _ ≤ ∑ g, (Real.exp o * m) * max (-d g) 0 :=
          sum_le_sum_of_subset_of_nonneg (subset_univ _)
            (fun g _ _ => mul_nonneg (mul_nonneg (Real.exp_pos _).le hmpos.le) (le_max_right _ _))
      _ = Real.exp o * m * ∑ g, max (-d g) 0 := by rw [mul_sum]
  -- assemble
  rw [htv', hident, div_le_iff₀ hZp]
  have hB : 0 ≤ Real.exp o * m * tv p q := mul_nonneg (mul_nonneg (Real.exp_pos _).le hmpos.le) (tv_nonneg _ _)
  calc (∑ g ∈ A, Real.exp (ρ g) * d g) * (1 - ∑ g ∈ A, ptilt q ρ g)
        - (∑ g ∈ A, ptilt q ρ g) * (∑ g ∈ univ.filter (fun g => g ∉ A), Real.exp (ρ g) * d g)
      ≤ (Real.exp o * m * tv p q) * (1 - ∑ g ∈ A, ptilt q ρ g)
        + (∑ g ∈ A, ptilt q ρ g) * (Real.exp o * m * tv p q) := by
        have e1 := mul_le_mul_of_nonneg_right hpos (by linarith : 0 ≤ 1 - ∑ g ∈ A, ptilt q ρ g)
        have e2 := mul_le_mul_of_nonneg_left hneg hqA
        linarith
    _ = Real.exp o * m * tv p q := by ring
    _ ≤ Real.exp o * tv p q * ptiltZ p ρ := by
        have := mul_le_mul_of_nonneg_left hZpm (mul_nonneg (Real.exp_pos o).le (tv_nonneg p q))
        linarith [mul_comm (Real.exp o * tv p q) m]

/-- THE PERTURBED INTERDEPENDENCE, SHARP: W · exp δ has interdependence e^{o s} C s t + (1 − e^{−Δ s t}) -/
theorem interdep_tilt_sharp [Nonempty G] (W : (S → G) → ℝ) (hW : ∀ ω, 0 < W ω) (C : S → S → ℝ) (hC : Interdep W C)
    (δ : (S → G) → ℝ) (o : S → ℝ) (ho : OscBound δ o) (Δ : S → S → ℝ) (hΔ : MixedDiff δ Δ) :
    Interdep (tilt W δ) (fun s t => Real.exp (o s) * C s t + (1 - Real.exp (-Δ s t))) := by
  intro s t hst ω h
  rw [cond_tilt W hW δ s ω, cond_tilt W hW δ s (Function.update ω t h)]
  set p := cond W s ω with hp
  set q := cond W s (Function.update ω t h) with hq
  set ρ₁ : G → ℝ := fun g => δ (Function.update ω s g) with hρ₁
  set ρ₂ : G → ℝ := fun g => δ (Function.update (Function.update ω t h) s g) with hρ₂
  have hpn : ∀ g, 0 ≤ p g := cond_nonneg W hW s ω
  have hqn : ∀ g, 0 ≤ q g := cond_nonneg W hW s _
  have hp1 : ∑ g, p g = 1 := cond_sum W hW s ω
  have hq1 : ∑ g, q g = 1 := cond_sum W hW s _
  have hosc1 : Osc ρ₁ (o s) := fun g g' => ho s ω g g'
  have hcomp : ptilt q ρ₂ = ptilt (ptilt q ρ₁) (fun g => ρ₂ g - ρ₁ g) := by
    funext g
    unfold ptilt ptiltZ
    have hZ1 := ptiltZ_pos q hqn hq1 ρ₁
    unfold ptiltZ at hZ1
    have key : ∀ x, q x * Real.exp (ρ₁ x) / (∑ x', q x' * Real.exp (ρ₁ x')) * Real.exp (ρ₂ x - ρ₁ x)
        = q x * Real.exp (ρ₂ x) / (∑ x', q x' * Real.exp (ρ₁ x')) := by
      intro x
      rw [Real.exp_sub]
      field_simp
    simp_rw [key]
    rw [← sum_div, div_div_div_cancel_right₀ hZ1.ne']
  have hosc2 : Osc (fun g => ρ₂ g - ρ₁ g) (Δ s t) := by
    intro g g'
    have := hΔ s t ω h g g'
    simp only [hρ₁, hρ₂]
    rw [← abs_neg]
    convert this using 2
    ring
  have htri : tv (ptilt p ρ₁) (ptilt q ρ₂) ≤ tv (ptilt p ρ₁) (ptilt q ρ₁) + tv (ptilt q ρ₁) (ptilt q ρ₂) := by
    unfold tv
    rw [← add_div]
    gcongr
    rw [← sum_add_distrib]
    apply sum_le_sum
    intro g _
    exact abs_sub_le _ _ _
  have h1 : tv (ptilt p ρ₁) (ptilt q ρ₁) ≤ Real.exp (o s) * C s t := by
    calc tv (ptilt p ρ₁) (ptilt q ρ₁) ≤ Real.exp (o s) * tv p q :=
          tv_tilt_pair_le_sharp p q hpn hqn hp1 hq1 ρ₁ (o s) hosc1
      _ ≤ Real.exp (o s) * C s t := mul_le_mul_of_nonneg_left (hC s t hst ω h) (Real.exp_pos _).le
  have h2 : tv (ptilt q ρ₁) (ptilt q ρ₂) ≤ 1 - Real.exp (-Δ s t) := by
    rw [hcomp]
    exact tv_tilt_le (ptilt q ρ₁) (ptilt_nonneg q hqn hq1 ρ₁) (ptilt_sum q hqn hq1 ρ₁) _ (Δ s t) hosc2
  linarith

/-- THE CRITERION, SHARP: the tilted row sums are at most e^{o s} α + Σ_t (1 − e^{−Δ s t}) -/
theorem rowsum_tilt_le_sharp (C : S → S → ℝ) (α : ℝ) (hα : ∀ s, ∑ t, C s t ≤ α)
    (o : S → ℝ) (Δ : S → S → ℝ) (s : S) :
    ∑ t, (Real.exp (o s) * C s t + (1 - Real.exp (-Δ s t)))
      ≤ Real.exp (o s) * α + ∑ t, (1 - Real.exp (-Δ s t)) := by
  rw [sum_add_distrib, ← mul_sum]
  refine add_le_add ?_ le_rfl
  exact mul_le_mul_of_nonneg_left (hα s) (Real.exp_pos _).le

/-- THE CRITERION: the tilted row sums are at most (2e^{2 o s} − 1) α + Σ_t (1 − e^{−Δ s t}) -/
theorem rowsum_tilt_le (C : S → S → ℝ) (α : ℝ) (hα : ∀ s, ∑ t, C s t ≤ α) (hCn : ∀ s t, 0 ≤ C s t)
    (o : S → ℝ) (ho : ∀ s, 0 ≤ o s) (Δ : S → S → ℝ) (s : S) :
    ∑ t, ((2 * Real.exp (2 * o s) - 1) * C s t + (1 - Real.exp (-Δ s t)))
      ≤ (2 * Real.exp (2 * o s) - 1) * α + ∑ t, (1 - Real.exp (-Δ s t)) := by
  rw [sum_add_distrib, ← mul_sum]
  refine add_le_add ?_ le_rfl
  apply mul_le_mul_of_nonneg_left (hα s)
  have : 1 ≤ Real.exp (2 * o s) := Real.one_le_exp (by linarith [ho s])
  linarith

end Aperanton
