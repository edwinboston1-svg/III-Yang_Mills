/-
  APERANTON -- THE BOUNDLESS, stage Β3's sharp coefficient (ADDENDUM I, THE ROAD, W2): THE PER-SITE INTERDEPENDENCE OF
  A Z₂ FACTOR SYSTEM, AND THE SLAB'S SHARP α WIRED INTO THE GAP -- not deferred.

  THE STEP (`z2_step_univ`): for every odds v > 0 and y ∈ (0, 1], a step of the odds by y² moves 1/(1+v) by at most
  c₁(y) = (1 − y)/(1 + y) -- the universal bound, the supremum attained at v = 1/y (cross-multiplied it is
  (1 − y)(1 − vy)² ≥ 0); the even-site bound c₂(y) = (1 − y²)/(2(1 + y²)) of the ΤΟΜΕΥΣ seat's lemma holds when v and
  vy² lie on one side of 1, which the slab's end levels do not guarantee, and c₁ is within two percent of it on the
  regime (0.1257 against 0.1277 at d = 3, 0.0716 against 0.0719 at d = 4) with no parity bookkeeping.  Steps
  telescope (`z2_steps`): a change of the odds by y^{2Σε}, ε = ±1 over a list, moves 1/(1+v) by at most the list's
  length times c₁.

  THE SYSTEM (`Z2Sys`): factors reading sites with multiplicities, each weighing its odd parity by y; its weight is a
  factor-system weight on `S → Multiplicative (ZMod 2)`.  THE ODDS (`odds_pow`): at a site s the odds of 1 against
  0 are y to a signed count over the factors reading s oddly, the sign of factor i being its parity with s set to
  0 (`eps`).  THE UPDATE (`eps_update`): changing a site t ≠ s negates exactly the signs of the factors reading both
  s and t oddly.  THE INTERDEPENDENCE (`interdep`): `Interdep Z.W Z.C` with C(s, t) = shared(s, t) · c₁(y),
  shared the number of factors reading both oddly -- Dobrushin's matrix at the per-site sharpness.

  THE SLAB (`slabZ2`): the Z₂ Wilson slab (w′(g) = y for g ≠ 1, k(a, b) = y for a ≠ b) IS a Z₂ factor system
  (`weight_slab_eq_W`): its row sums are at most (3m + 2) · c₁(y) for a square system of link degree ≤ m with
  distinct links (`slabZ2_rowsum_le`), the matrix has range one along the level (`slabZ2_rangeOne`), and so
  `transfer_gap_sharp`: THE MASS GAP OF THE Z₂ WILSON SLAB with α = (3m + 2)(1 − y)/(1 + y) -- (6d − 10)·c₁(y) on the
  cubic lattice: below one iff y > (6d − 11)/(6d − 9): β < ½ ln(9/7) = 0.1257 at d = 3, β < ½ ln(15/13) = 0.0716 at
  d = 4 (`z2_sharp_lt_one`).  No sorry, no axiom, no native_decide.
-/
import Mathlib
import Aperanton.Dobrushin
import Aperanton.Factors
import Aperanton.Slab
import Aperanton.Rowsum

open Finset

namespace Aperanton

/-! ## The universal step bound and its telescoping -/

section Steps

theorem z2_step_univ (y v : ℝ) (hy0 : 0 < y) (hy1 : y ≤ 1) (hv : 0 < v) :
    |1 / (1 + v) - 1 / (1 + v * y ^ 2)| ≤ (1 - y) / (1 + y) := by
  have h1v : 0 < 1 + v := by linarith
  have h1vy : 0 < 1 + v * y ^ 2 := by positivity
  have hy2 : 0 ≤ 1 - y ^ 2 := by nlinarith
  have hy1' : 0 ≤ 1 - y := by linarith
  have hdiff : 1 / (1 + v) - 1 / (1 + v * y ^ 2) = -(v * (1 - y ^ 2)) / ((1 + v) * (1 + v * y ^ 2)) := by
    field_simp
    ring
  rw [hdiff, abs_div, abs_neg, abs_of_pos (mul_pos h1v h1vy), abs_of_nonneg (mul_nonneg hv.le hy2)]
  rw [div_le_div_iff₀ (mul_pos h1v h1vy) (by linarith)]
  nlinarith [mul_nonneg hy1' (sq_nonneg (1 - v * y))]

/-- the step down (× y²) and the step up (× y⁻²) -/
theorem z2_step_pm (y v : ℝ) (hy0 : 0 < y) (hy1 : y ≤ 1) (hv : 0 < v) (ε : ℤ) (hε : ε = 1 ∨ ε = -1) :
    |1 / (1 + v) - 1 / (1 + v * y ^ (2 * ε))| ≤ (1 - y) / (1 + y) := by
  rcases hε with rfl | rfl
  · rw [show (2 : ℤ) * 1 = ((2 : ℕ) : ℤ) by norm_num, zpow_natCast]
    exact z2_step_univ y v hy0 hy1 hv
  · have hu : 0 < v * y ^ (2 * (-1 : ℤ)) := mul_pos hv (zpow_pos hy0 _)
    have key := z2_step_univ y (v * y ^ (2 * (-1 : ℤ))) hy0 hy1 hu
    have hvu : v * y ^ (2 * (-1 : ℤ)) * y ^ 2 = v := by
      rw [mul_assoc, ← zpow_natCast y 2, ← zpow_add₀ hy0.ne']
      simp
    rw [hvu] at key
    rw [abs_sub_comm]
    exact key

/-- THE TELESCOPING: a change of the odds by y^{2Σε} over a list of signs moves 1/(1+v) by at most length · c₁ -/
theorem z2_steps (y v : ℝ) (hy0 : 0 < y) (hy1 : y ≤ 1) (hv : 0 < v) (l : List ℤ)
    (hl : ∀ ε ∈ l, ε = 1 ∨ ε = -1) :
    |1 / (1 + v) - 1 / (1 + v * y ^ (2 * l.sum))| ≤ l.length * ((1 - y) / (1 + y)) := by
  induction l generalizing v with
  | nil => simp
  | cons ε l ih =>
    have hε : ε = 1 ∨ ε = -1 := hl ε List.mem_cons_self
    have hl' : ∀ ε' ∈ l, ε' = 1 ∨ ε' = -1 := fun ε' h => hl ε' (List.mem_cons_of_mem ε h)
    have hu : 0 < v * y ^ (2 * ε) := mul_pos hv (zpow_pos hy0 _)
    have hsplit : v * y ^ (2 * (ε :: l).sum) = v * y ^ (2 * ε) * y ^ (2 * l.sum) := by
      rw [List.sum_cons, mul_add, zpow_add₀ hy0.ne', mul_assoc]
    rw [hsplit, List.length_cons]
    calc |1 / (1 + v) - 1 / (1 + v * y ^ (2 * ε) * y ^ (2 * l.sum))|
        ≤ |1 / (1 + v) - 1 / (1 + v * y ^ (2 * ε))|
          + |1 / (1 + v * y ^ (2 * ε)) - 1 / (1 + v * y ^ (2 * ε) * y ^ (2 * l.sum))| := by
            rw [← sub_add_sub_cancel (1 / (1 + v)) (1 / (1 + v * y ^ (2 * ε)))]
            exact abs_add_le _ _
      _ ≤ (1 - y) / (1 + y) + l.length * ((1 - y) / (1 + y)) :=
          add_le_add (z2_step_pm y v hy0 hy1 hv ε hε) (ih (v * y ^ (2 * ε)) hu hl')
      _ = ((l.length + 1 : ℕ) : ℝ) * ((1 - y) / (1 + y)) := by push_cast; ring

end Steps

/-! ## The Z₂ factor system -/

section Z2System

/-- the two-element spin: Z₂ written multiplicatively, as the gauge files write it -/
abbrev Z2 := Multiplicative (ZMod 2)

/-- a Z₂ factor system: factors read their sites with multiplicities and weigh the odd parity by y -/
structure Z2Sys (S ι : Type*) where
  mult : ι → S → ℕ
  /-- the twist: the parity added to the factor (a flipped coupling), zero for the untwisted theory -/
  shift : ι → ZMod 2 := fun _ => 0
  y : ℝ
  y_pos : 0 < y
  y_le : y ≤ 1

variable {S : Type*} [Fintype S] [DecidableEq S] {ι : Type*} [Fintype ι] [DecidableEq ι] (Z : Z2Sys S ι)

/-- the parity read by factor i -/
def Z2Sys.par (i : ι) (ω : S → Z2) : ZMod 2 :=
  Z.shift i + ∑ s, (Z.mult i s : ZMod 2) * Multiplicative.toAdd (ω s)

/-- the factor's weight: y at odd parity, 1 at even -/
def Z2Sys.w (i : ι) (ω : S → Z2) : ℝ := if Z.par i ω = 1 then Z.y else 1

/-- the system's weight -/
def Z2Sys.W (ω : S → Z2) : ℝ := ∏ i, Z.w i ω

theorem Z2Sys.w_pos (i : ι) (ω : S → Z2) : 0 < Z.w i ω := by
  unfold Z2Sys.w
  split_ifs
  · exact Z.y_pos
  · exact one_pos

theorem Z2Sys.W_pos (ω : S → Z2) : 0 < Z.W ω := Finset.prod_pos (fun i _ => Z.w_pos i ω)

/-- the parity after an update at s moves by the multiplicity times the change -/
theorem Z2Sys.par_update (i : ι) (ω : S → Z2) (s : S) (g : Z2) :
    Z.par i (Function.update ω s g)
      = Z.par i ω + (Z.mult i s : ZMod 2) * (Multiplicative.toAdd g - Multiplicative.toAdd (ω s)) := by
  unfold Z2Sys.par
  have hterm : ∀ s', (Z.mult i s' : ZMod 2) * Multiplicative.toAdd (Function.update ω s g s')
      - (Z.mult i s' : ZMod 2) * Multiplicative.toAdd (ω s')
      = if s' = s then (Z.mult i s : ZMod 2) * (Multiplicative.toAdd g - Multiplicative.toAdd (ω s)) else 0 := by
    intro s'
    by_cases h : s' = s
    · subst h
      rw [if_pos rfl, Function.update_self]
      ring
    · rw [if_neg h, Function.update_of_ne h]
      ring
  have hsum := Finset.sum_congr rfl (fun s' (_ : s' ∈ univ) => hterm s')
  rw [Finset.sum_sub_distrib, Finset.sum_ite_eq' univ s, if_pos (mem_univ s)] at hsum
  linear_combination hsum

/-- the two elements of Z₂ -/
theorem sum_Z2 (f : Z2 → ℝ) : ∑ g, f g = f (Multiplicative.ofAdd 0) + f (Multiplicative.ofAdd 1) := by
  rw [show (univ : Finset Z2) = {Multiplicative.ofAdd 0, Multiplicative.ofAdd 1} by decide,
    Finset.sum_insert (by decide), Finset.sum_singleton]

/-- on a two-point spin the total variation is the difference at one point -/
theorem tv_Z2 (p p' : Z2 → ℝ) (h1 : ∑ g, p g = 1) (h1' : ∑ g, p' g = 1) :
    tv p p' = |p (Multiplicative.ofAdd 0) - p' (Multiplicative.ofAdd 0)| := by
  rw [sum_Z2] at h1 h1'
  unfold tv
  rw [sum_Z2]
  have : p (Multiplicative.ofAdd 1) - p' (Multiplicative.ofAdd 1)
      = -(p (Multiplicative.ofAdd 0) - p' (Multiplicative.ofAdd 0)) := by linarith
  rw [this, abs_neg]
  ring

/-- the conditional of the value 0 at s is 1/(1 + v), v the odds of 1 against 0 -/
theorem cond_zero_eq (W : (S → Z2) → ℝ) (hW : ∀ ω, 0 < W ω) (s : S) (ω : S → Z2) :
    cond W s ω (Multiplicative.ofAdd 0)
      = 1 / (1 + W (Function.update ω s (Multiplicative.ofAdd 1)) / W (Function.update ω s (Multiplicative.ofAdd 0))) := by
  unfold cond zsite
  rw [sum_Z2]
  have hA := hW (Function.update ω s (Multiplicative.ofAdd 0))
  have hB := hW (Function.update ω s (Multiplicative.ofAdd 1))
  field_simp

/-- the odds at s factor over the factors -/
theorem Z2Sys.odds_eq (s : S) (ω : S → Z2) :
    Z.W (Function.update ω s (Multiplicative.ofAdd 1)) / Z.W (Function.update ω s (Multiplicative.ofAdd 0))
      = ∏ i, Z.w i (Function.update ω s (Multiplicative.ofAdd 1))
          / Z.w i (Function.update ω s (Multiplicative.ofAdd 0)) := by
  unfold Z2Sys.W
  rw [Finset.prod_div_distrib]

/-- the sign of factor i at s: +1 if the parity with s set to 0 is even, −1 if odd -/
def Z2Sys.eps (i : ι) (s : S) (ω : S → Z2) : ℤ :=
  if Z.par i (Function.update ω s (Multiplicative.ofAdd 0)) = 1 then -1 else 1

theorem Z2Sys.eps_pm (i : ι) (s : S) (ω : S → Z2) : Z.eps i s ω = 1 ∨ Z.eps i s ω = -1 := by
  unfold Z2Sys.eps
  split_ifs <;> simp

theorem zmod2_zero_or_one (a : ZMod 2) : a = 0 ∨ a = 1 := by
  revert a
  decide

/-- the ratio of factor i under the flip of s: y^{ε} if i reads s oddly, 1 otherwise -/
theorem Z2Sys.ratio_eq (i : ι) (s : S) (ω : S → Z2) :
    Z.w i (Function.update ω s (Multiplicative.ofAdd 1)) / Z.w i (Function.update ω s (Multiplicative.ofAdd 0))
      = if (Z.mult i s : ZMod 2) = 1 then Z.y ^ (Z.eps i s ω) else 1 := by
  have h0 := Z.par_update i ω s (Multiplicative.ofAdd 0)
  have h1 := Z.par_update i ω s (Multiplicative.ofAdd 1)
  simp only [toAdd_ofAdd] at h0 h1
  have hrel : Z.par i (Function.update ω s (Multiplicative.ofAdd 1))
      = Z.par i (Function.update ω s (Multiplicative.ofAdd 0)) + (Z.mult i s : ZMod 2) := by
    rw [h0, h1]
    ring
  have hy := Z.y_pos.ne'
  unfold Z2Sys.w Z2Sys.eps
  rcases zmod2_zero_or_one (Z.mult i s : ZMod 2) with hm | hm
  · rw [hm, add_zero] at hrel
    rw [hrel, if_neg (show ¬ ((Z.mult i s : ZMod 2) = 1) by rw [hm]; decide)]
    split_ifs <;> simp [hy]
  · rw [hm] at hrel
    rw [if_pos hm]
    rcases zmod2_zero_or_one (Z.par i (Function.update ω s (Multiplicative.ofAdd 0))) with hp | hp
    · rw [hrel, hp, zero_add, if_pos rfl, if_neg (by decide : ¬ ((0 : ZMod 2) = 1)),
        if_neg (by decide : ¬ ((0 : ZMod 2) = 1))]
      simp
    · rw [hrel, hp, if_neg (by decide : ¬ ((1 : ZMod 2) + 1 = 1)), if_pos rfl, if_pos rfl]
      simp [zpow_neg, zpow_one]

/-- y to a finite sum of integer exponents is the product of the powers -/
theorem zpow_finset_sum {κ : Type*} (a : ℝ) (ha : a ≠ 0) (s : Finset κ) (f : κ → ℤ) :
    a ^ (∑ i ∈ s, f i) = ∏ i ∈ s, a ^ f i := by
  classical
  induction s using Finset.induction_on with
  | empty => simp
  | @insert i s hi ih => rw [Finset.sum_insert hi, Finset.prod_insert hi, zpow_add₀ ha, ih]

/-- THE ODDS: y to the signed count of the factors reading s oddly -/
theorem Z2Sys.odds_pow (s : S) (ω : S → Z2) :
    Z.W (Function.update ω s (Multiplicative.ofAdd 1)) / Z.W (Function.update ω s (Multiplicative.ofAdd 0))
      = Z.y ^ (∑ i ∈ univ.filter (fun i => (Z.mult i s : ZMod 2) = 1), Z.eps i s ω) := by
  rw [Z.odds_eq, ← Finset.prod_filter_mul_prod_filter_not univ (fun i => (Z.mult i s : ZMod 2) = 1)]
  rw [Finset.prod_congr rfl (fun i hi => (Z.ratio_eq i s ω).trans (if_pos (mem_filter.mp hi).2)),
    Finset.prod_congr rfl (fun i hi => (Z.ratio_eq i s ω).trans (if_neg (mem_filter.mp hi).2)),
    Finset.prod_const_one, mul_one, zpow_finset_sum Z.y Z.y_pos.ne']

/-- THE UPDATE: changing t ≠ s negates the signs of exactly the factors reading both s and t oddly -/
theorem Z2Sys.eps_update (i : ι) (s t : S) (hst : s ≠ t) (ω : S → Z2) (h : Z2)
    (hh : Multiplicative.toAdd h ≠ Multiplicative.toAdd (ω t)) :
    Z.eps i s (Function.update ω t h)
      = if (Z.mult i t : ZMod 2) = 1 then - Z.eps i s ω else Z.eps i s ω := by
  unfold Z2Sys.eps
  rw [Function.update_comm hst.symm, Z.par_update i (Function.update ω s (Multiplicative.ofAdd 0)) t h,
    Function.update_of_ne hst.symm]
  have hδ : Multiplicative.toAdd h - Multiplicative.toAdd (ω t) = 1 := by
    rcases zmod2_zero_or_one (Multiplicative.toAdd h - Multiplicative.toAdd (ω t)) with h0 | h0
    · exact absurd (sub_eq_zero.mp h0) hh
    · exact h0
  rw [hδ, mul_one]
  generalize Z.par i (Function.update ω s (Multiplicative.ofAdd 0)) = p
  generalize (Z.mult i t : ZMod 2) = m
  revert p m
  decide

/-- the number of factors reading both s and t oddly -/
def Z2Sys.shared (s t : S) : ℕ :=
  (univ.filter (fun i => (Z.mult i s : ZMod 2) = 1 ∧ (Z.mult i t : ZMod 2) = 1)).card

/-- THE PER-SITE INTERDEPENDENCE MATRIX: shared(s, t) · c₁(y) off the diagonal -/
noncomputable def Z2Sys.C (s t : S) : ℝ := if s = t then 0 else (Z.shared s t : ℝ) * ((1 - Z.y) / (1 + Z.y))

theorem Z2Sys.c1_nonneg : 0 ≤ (1 - Z.y) / (1 + Z.y) := by
  have := Z.y_pos
  have := Z.y_le
  apply div_nonneg <;> linarith

theorem Z2Sys.C_nonneg (s t : S) : 0 ≤ Z.C s t := by
  unfold Z2Sys.C
  split_ifs
  · exact le_refl 0
  · exact mul_nonneg (Nat.cast_nonneg _) Z.c1_nonneg

/-- THE INTERDEPENDENCE BOUND of a Z₂ factor system at the per-site sharpness -/
theorem Z2Sys.interdep : Interdep Z.W Z.C := by
  intro s t hst ω h
  unfold Z2Sys.C
  rw [if_neg hst]
  rw [tv_Z2 _ _ (cond_sum Z.W Z.W_pos s ω) (cond_sum Z.W Z.W_pos s _), cond_zero_eq Z.W Z.W_pos,
    cond_zero_eq Z.W Z.W_pos, Z.odds_pow, Z.odds_pow]
  by_cases hh : Multiplicative.toAdd h = Multiplicative.toAdd (ω t)
  · have hid : Function.update ω t h = ω := by
      funext u
      by_cases hu : u = t
      · subst hu
        rw [Function.update_self]
        exact Multiplicative.toAdd.injective hh
      · rw [Function.update_of_ne hu]
    rw [hid, sub_self, abs_zero]
    exact mul_nonneg (Nat.cast_nonneg _) Z.c1_nonneg
  · -- the exponent after the update: the old one plus twice the negated signs over the shared factors
    set E := univ.filter (fun i => (Z.mult i s : ZMod 2) = 1) with hE
    set I := univ.filter (fun i => (Z.mult i s : ZMod 2) = 1 ∧ (Z.mult i t : ZMod 2) = 1) with hI
    have hexp : ∑ i ∈ E, Z.eps i s (Function.update ω t h)
        = ∑ i ∈ E, Z.eps i s ω + 2 * ∑ i ∈ I, (- Z.eps i s ω) := by
      have hpt : ∀ i ∈ E, Z.eps i s (Function.update ω t h)
          = Z.eps i s ω + (if (Z.mult i t : ZMod 2) = 1 then 2 * (- Z.eps i s ω) else 0) := by
        intro i _
        rw [Z.eps_update i s t hst ω h hh]
        split_ifs <;> ring
      rw [Finset.sum_congr rfl hpt, Finset.sum_add_distrib, ← Finset.sum_filter, Finset.filter_filter,
        Finset.mul_sum]
    rw [hexp, zpow_add₀ Z.y_pos.ne']
    have hv : 0 < Z.y ^ (∑ i ∈ E, Z.eps i s ω) := zpow_pos Z.y_pos _
    set l : List ℤ := I.toList.map (fun i => - Z.eps i s ω) with hl
    have hlsum : l.sum = ∑ i ∈ I, (- Z.eps i s ω) := by
      rw [hl, Finset.sum_map_toList]
    have hllen : l.length = Z.shared s t := by
      rw [hl, List.length_map, Finset.length_toList]
      rfl
    have hlpm : ∀ ε ∈ l, ε = 1 ∨ ε = -1 := by
      intro ε hε
      rw [hl, List.mem_map] at hε
      obtain ⟨i, _, rfl⟩ := hε
      rcases Z.eps_pm i s ω with h1 | h1 <;> rw [h1] <;> norm_num
    have key := z2_steps Z.y _ Z.y_pos Z.y_le hv l hlpm
    rw [hlsum, hllen] at key
    exact key

end Z2System

/-! ## The Z₂ Wilson slab as a Z₂ factor system, and its sharp gap -/

section SlabZ2

variable {V Lk : Type*} [DecidableEq V] [Fintype Lk] [DecidableEq Lk] {Λ : Lat V Lk}
  {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- the Z₂ plaquette weight: y for a frustrated plaquette -/
def wZ2 (y : ℝ) : Z2 → ℝ := fun g => if g = 1 then 1 else y

/-- the Z₂ link kernel: y for a flipped link -/
def kZ2 (y : ℝ) : Matrix Z2 Z2 ℝ := fun a b => if a = b then 1 else y

theorem wZ2_lo (y : ℝ) (hy1 : y ≤ 1) (g : Z2) : y ≤ wZ2 y g := by
  unfold wZ2; split_ifs <;> linarith
theorem wZ2_hi (y : ℝ) (hy1 : y ≤ 1) (g : Z2) : wZ2 y g ≤ 1 := by
  unfold wZ2; split_ifs <;> linarith
theorem kZ2_lo (y : ℝ) (hy1 : y ≤ 1) (a b : Z2) : y ≤ kZ2 y a b := by
  unfold kZ2; split_ifs <;> linarith
theorem kZ2_hi (y : ℝ) (hy1 : y ≤ 1) (a b : Z2) : kZ2 y a b ≤ 1 := by
  unfold kZ2; split_ifs <;> linarith

/-- the four links of a square as a list, with multiplicity -/
def squareList (p : Square Λ) : List Lk := [p.ℓ₁, p.ℓ₂, p.ℓ₃, p.ℓ₄]

/-- the Z₂ system of the slab: plaquette factors at each level reading a square's links with their multiplicities,
link factors reading a link at two consecutive levels -/
def slabZ2 (sq : ι → Square Λ) (y : ℝ) (hy0 : 0 < y) (hy1 : y ≤ 1) (T : ℕ) :
    Z2Sys (Fin (T + 1) × Lk) (SlabIdx ι Lk T) where
  mult
    | Sum.inl (x, i) => fun s => if s.1 = x then (squareList (sq i)).count s.2 else 0
    | Sum.inr (x, ℓ) => fun s => if s.2 = ℓ ∧ (s.1 = x.castSucc ∨ s.1 = x.succ) then 1 else 0
  y := y
  y_pos := hy0
  y_le := hy1

/-- the holonomy of a square in Z₂ is the parity of its four links -/
theorem toAdd_hol (p : Square Λ) (c : Lk → Z2) :
    Multiplicative.toAdd (hol p c)
      = Multiplicative.toAdd (c p.ℓ₁) + Multiplicative.toAdd (c p.ℓ₂)
        + Multiplicative.toAdd (c p.ℓ₃) + Multiplicative.toAdd (c p.ℓ₄) := by
  unfold hol
  rw [toAdd_mul, toAdd_mul, toAdd_mul, toAdd_inv, toAdd_inv, CharTwo.neg_eq, CharTwo.neg_eq]

/-- the parity of the plaquette factor is the parity of the square's four links at that level -/
theorem parity_square (sq : ι → Square Λ) (y : ℝ) (hy0 : 0 < y) (hy1 : y ≤ 1) (T : ℕ) (x : Fin (T + 1)) (i : ι)
    (ω : Fin (T + 1) × Lk → Z2) :
    (slabZ2 sq y hy0 hy1 T).par (Sum.inl (x, i)) ω
      = Multiplicative.toAdd (hol (sq i) (fun ℓ => ω (x, ℓ))) := by
  rw [toAdd_hol]
  -- the right side as the count-weighted sum over the links
  have hlist : Multiplicative.toAdd (ω (x, (sq i).ℓ₁)) + Multiplicative.toAdd (ω (x, (sq i).ℓ₂))
        + Multiplicative.toAdd (ω (x, (sq i).ℓ₃)) + Multiplicative.toAdd (ω (x, (sq i).ℓ₄))
      = ∑ ℓ, ((squareList (sq i)).count ℓ : ZMod 2) * Multiplicative.toAdd (ω (x, ℓ)) := by
    have h := Finset.sum_list_map_count (squareList (sq i)) (fun ℓ => Multiplicative.toAdd (ω (x, ℓ)))
    have hext : ∑ m ∈ (squareList (sq i)).toFinset,
          (squareList (sq i)).count m • Multiplicative.toAdd (ω (x, m))
        = ∑ ℓ, (squareList (sq i)).count ℓ • Multiplicative.toAdd (ω (x, ℓ)) :=
      Finset.sum_subset (Finset.subset_univ _) (fun ℓ _ hℓ => by
        rw [List.count_eq_zero_of_not_mem (by simpa using hℓ), zero_nsmul])
    rw [hext] at h
    simp only [nsmul_eq_mul] at h
    rw [← h]
    simp [squareList, add_assoc]
  rw [hlist]
  show (slabZ2 sq y hy0 hy1 T).shift (Sum.inl (x, i))
      + ∑ s, ((if s.1 = x then (squareList (sq i)).count s.2 else 0 : ℕ) : ZMod 2) * Multiplicative.toAdd (ω s) = _
  rw [show (slabZ2 sq y hy0 hy1 T).shift (Sum.inl (x, i)) = 0 from rfl, zero_add]
  -- the sites at level x carry the counts, the others zero
  have hsplit : ∀ s : Fin (T + 1) × Lk,
      ((if s.1 = x then (squareList (sq i)).count s.2 else 0 : ℕ) : ZMod 2) * Multiplicative.toAdd (ω s)
        = if s.1 = x then ((squareList (sq i)).count s.2 : ZMod 2) * Multiplicative.toAdd (ω (x, s.2)) else 0 := by
    intro s
    by_cases h : s.1 = x
    · rw [if_pos h, if_pos h]
      have : s = (x, s.2) := Prod.ext h rfl
      rw [← this]
    · rw [if_neg h, if_neg h]
      simp
  rw [Finset.sum_congr rfl (fun s _ => hsplit s), ← Finset.sum_filter]
  exact Finset.sum_bij (fun (s : Fin (T + 1) × Lk) _ => s.2) (fun s _ => Finset.mem_univ _)
    (fun a ha b hb hab => by
      simp only [Finset.mem_filter, Finset.mem_univ, true_and] at ha hb
      exact Prod.ext (ha.trans hb.symm) hab)
    (fun ℓ _ => ⟨(x, ℓ), by simp, rfl⟩)
    (fun s _ => rfl)

/-- the parity of the link factor is the sum of the link's values at the two levels -/
theorem parity_link (sq : ι → Square Λ) (y : ℝ) (hy0 : 0 < y) (hy1 : y ≤ 1) (T : ℕ) (x : Fin T) (ℓ : Lk)
    (ω : Fin (T + 1) × Lk → Z2) :
    (slabZ2 sq y hy0 hy1 T).par (Sum.inr (x, ℓ)) ω
      = Multiplicative.toAdd (ω (x.castSucc, ℓ)) + Multiplicative.toAdd (ω (x.succ, ℓ)) := by
  show (slabZ2 sq y hy0 hy1 T).shift (Sum.inr (x, ℓ))
      + ∑ s, ((if s.2 = ℓ ∧ (s.1 = x.castSucc ∨ s.1 = x.succ) then 1 else 0 : ℕ) : ZMod 2)
      * Multiplicative.toAdd (ω s) = _
  rw [show (slabZ2 sq y hy0 hy1 T).shift (Sum.inr (x, ℓ)) = 0 from rfl, zero_add]
  have hne : (x.castSucc, ℓ) ≠ (x.succ, ℓ) := by
    intro h
    have := congrArg Prod.fst h
    exact absurd (Fin.ext_iff.mp this) (by simp)
  have hset : (Finset.univ.filter (fun s : Fin (T + 1) × Lk => s.2 = ℓ ∧ (s.1 = x.castSucc ∨ s.1 = x.succ)))
      = {(x.castSucc, ℓ), (x.succ, ℓ)} := by
    ext s
    simp only [Finset.mem_filter, Finset.mem_univ, true_and, Finset.mem_insert, Finset.mem_singleton]
    constructor
    · rintro ⟨h2, h1 | h1⟩
      · left; exact Prod.ext h1 h2
      · right; exact Prod.ext h1 h2
    · rintro (rfl | rfl)
      · exact ⟨rfl, Or.inl rfl⟩
      · exact ⟨rfl, Or.inr rfl⟩
  have hterm : ∀ s : Fin (T + 1) × Lk,
      ((if s.2 = ℓ ∧ (s.1 = x.castSucc ∨ s.1 = x.succ) then 1 else 0 : ℕ) : ZMod 2) * Multiplicative.toAdd (ω s)
        = if s.2 = ℓ ∧ (s.1 = x.castSucc ∨ s.1 = x.succ) then Multiplicative.toAdd (ω s) else 0 := by
    intro s
    split_ifs <;> simp
  rw [Finset.sum_congr rfl (fun s _ => hterm s), ← Finset.sum_filter, hset, Finset.sum_pair hne]

/-- THE SLAB IS A Z₂ FACTOR SYSTEM: the weights agree factor by factor -/
theorem weight_slab_eq_W (sq : ι → Square Λ) (y : ℝ) (hy0 : 0 < y) (hy1 : y ≤ 1) (T : ℕ) :
    weight (slabFactors sq (wZ2 y) y 1 hy0 (wZ2_lo y hy1) (wZ2_hi y hy1) (kZ2 y) y 1 hy0 (kZ2_lo y hy1)
      (kZ2_hi y hy1) T) = (slabZ2 sq y hy0 hy1 T).W := by
  funext ω
  unfold weight Z2Sys.W
  apply Finset.prod_congr rfl
  rintro (⟨x, i⟩ | ⟨x, ℓ⟩) _
  · show wZ2 y (hol (sq i) (fun ℓ => ω (x, ℓ))) = (slabZ2 sq y hy0 hy1 T).w (Sum.inl (x, i)) ω
    unfold Z2Sys.w
    rw [parity_square]
    unfold wZ2
    rcases zmod2_zero_or_one (Multiplicative.toAdd (hol (sq i) (fun ℓ => ω (x, ℓ)))) with h0 | h0
    · rw [h0, if_pos (toAdd_eq_zero.mp h0), if_neg (by decide)]
    · rw [h0, if_pos rfl, if_neg]
      · rfl
      · intro h1
        rw [h1, toAdd_one] at h0
        exact absurd h0 (by decide)
  · show kZ2 y (ω (x.castSucc, ℓ)) (ω (x.succ, ℓ)) = (slabZ2 sq y hy0 hy1 T).w (Sum.inr (x, ℓ)) ω
    unfold Z2Sys.w
    rw [parity_link]
    unfold kZ2
    by_cases heq : ω (x.castSucc, ℓ) = ω (x.succ, ℓ)
    · rw [if_pos heq, heq, if_neg]
      rw [← CharTwo.sub_eq_add, sub_self]
      decide
    · rw [if_neg heq, if_pos]
      · rfl
      · rcases zmod2_zero_or_one (Multiplicative.toAdd (ω (x.castSucc, ℓ)) + Multiplicative.toAdd (ω (x.succ, ℓ)))
          with h0 | h0
        · exfalso
          rw [← CharTwo.sub_eq_add, sub_eq_zero] at h0
          exact heq (Multiplicative.toAdd.injective h0)
        · exact h0

end SlabZ2

/-! ## The row sum, the range, and the sharp gap -/

section SlabZ2Gap

open Matrix

variable {V Lk : Type*} [DecidableEq V] [Fintype Lk] [DecidableEq Lk] {Λ : Lat V Lk}
  {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- the matrix has range one along the level: a factor reading two sites oddly reads them at levels one apart -/
theorem slabZ2_rangeOne (sq : ι → Square Λ) (y : ℝ) (hy0 : 0 < y) (hy1 : y ≤ 1) (T : ℕ) :
    RangeOne (slabZ2 sq y hy0 hy1 T).C level := by
  intro s t hst
  unfold Z2Sys.C
  have hne : s ≠ t := by
    intro h; rw [h] at hst; omega
  rw [if_neg hne]
  have hshared : (slabZ2 sq y hy0 hy1 T).shared s t = 0 := by
    unfold Z2Sys.shared
    rw [Finset.card_eq_zero, Finset.filter_eq_empty_iff]
    rintro (⟨x, i⟩ | ⟨x, ℓ⟩) _ ⟨hs, ht⟩
    · -- a plaquette factor reads one level
      change ((if s.1 = x then (squareList (sq i)).count s.2 else 0 : ℕ) : ZMod 2) = 1 at hs
      change ((if t.1 = x then (squareList (sq i)).count t.2 else 0 : ℕ) : ZMod 2) = 1 at ht
      have hsx : s.1 = x := by
        by_contra h; rw [if_neg h] at hs; exact absurd hs (by decide)
      have htx : t.1 = x := by
        by_contra h; rw [if_neg h] at ht; exact absurd ht (by decide)
      simp only [level] at hst
      rw [hsx, htx] at hst
      omega
    · -- a link factor reads two consecutive levels
      change ((if s.2 = ℓ ∧ (s.1 = x.castSucc ∨ s.1 = x.succ) then 1 else 0 : ℕ) : ZMod 2) = 1 at hs
      change ((if t.2 = ℓ ∧ (t.1 = x.castSucc ∨ t.1 = x.succ) then 1 else 0 : ℕ) : ZMod 2) = 1 at ht
      have hs' : s.1 = x.castSucc ∨ s.1 = x.succ := by
        by_contra h
        rw [if_neg (fun h' => h h'.2)] at hs
        exact absurd hs (by decide)
      have ht' : t.1 = x.castSucc ∨ t.1 = x.succ := by
        by_contra h
        rw [if_neg (fun h' => h h'.2)] at ht
        exact absurd ht (by decide)
      simp only [level] at hst
      rcases hs' with h1 | h1 <;> rcases ht' with h2 | h2 <;> rw [h1, h2] at hst <;>
        simp only [Fin.coe_castSucc, Fin.val_succ] at hst <;> omega
  rw [hshared]
  simp

/-- the number of sites a factor reads oddly, other than s: at most three for a plaquette, one for a link -/
theorem slabZ2_odd_sites_le (sq : ι → Square Λ) (y : ℝ) (hy0 : 0 < y) (hy1 : y ≤ 1) (T : ℕ)
    (s : Fin (T + 1) × Lk) (f : SlabIdx ι Lk T)
    (hf : ((slabZ2 sq y hy0 hy1 T).mult f s : ZMod 2) = 1) :
    ((Finset.univ.erase s).filter (fun t => ((slabZ2 sq y hy0 hy1 T).mult f t : ZMod 2) = 1)).card
      ≤ (match f with | Sum.inl _ => 3 | Sum.inr _ => 1) := by
  rcases f with ⟨x, i⟩ | ⟨x, ℓ⟩
  · -- the odd sites of a plaquette factor lie among the four links at the level x
    have hsub : (Finset.univ.erase s).filter (fun t => ((slabZ2 sq y hy0 hy1 T).mult (Sum.inl (x, i)) t : ZMod 2) = 1)
        ⊆ ((squareLinks (sq i)).image (fun ℓ' => (x, ℓ'))).erase s := by
      intro t ht
      simp only [Finset.mem_filter, Finset.mem_erase] at ht
      obtain ⟨⟨hts, _⟩, hodd⟩ := ht
      change ((if t.1 = x then (squareList (sq i)).count t.2 else 0 : ℕ) : ZMod 2) = 1 at hodd
      have htx : t.1 = x := by
        by_contra h; rw [if_neg h] at hodd; exact absurd hodd (by decide)
      rw [if_pos htx] at hodd
      have hmem : t.2 ∈ squareList (sq i) := by
        by_contra h
        rw [List.count_eq_zero_of_not_mem h] at hodd
        exact absurd hodd (by decide)
      rw [Finset.mem_erase, Finset.mem_image]
      refine ⟨hts, t.2, ?_, Prod.ext htx.symm rfl⟩
      simp only [squareList, List.mem_cons, List.mem_singleton, List.not_mem_nil, or_false] at hmem
      simp only [squareLinks, Finset.mem_insert, Finset.mem_singleton]
      tauto
    have hs : s ∈ (squareLinks (sq i)).image (fun ℓ' => (x, ℓ')) := by
      change ((if s.1 = x then (squareList (sq i)).count s.2 else 0 : ℕ) : ZMod 2) = 1 at hf
      have hsx : s.1 = x := by
        by_contra h; rw [if_neg h] at hf; exact absurd hf (by decide)
      rw [if_pos hsx] at hf
      have hmem : s.2 ∈ squareList (sq i) := by
        by_contra h
        rw [List.count_eq_zero_of_not_mem h] at hf
        exact absurd hf (by decide)
      rw [Finset.mem_image]
      refine ⟨s.2, ?_, Prod.ext hsx.symm rfl⟩
      simp only [squareList, List.mem_cons, List.mem_singleton, List.not_mem_nil, or_false] at hmem
      simp only [squareLinks, Finset.mem_insert, Finset.mem_singleton]
      tauto
    calc _ ≤ (((squareLinks (sq i)).image (fun ℓ' => (x, ℓ'))).erase s).card := Finset.card_le_card hsub
      _ = ((squareLinks (sq i)).image (fun ℓ' => (x, ℓ'))).card - 1 := Finset.card_erase_of_mem hs
      _ ≤ 4 - 1 := by
          apply Nat.sub_le_sub_right
          refine le_trans Finset.card_image_le ?_
          unfold squareLinks
          refine le_trans (Finset.card_insert_le _ _) ?_
          refine Nat.succ_le_succ (le_trans (Finset.card_insert_le _ _) ?_)
          refine Nat.succ_le_succ (le_trans (Finset.card_insert_le _ _) ?_)
          rw [Finset.card_singleton]
      _ = 3 := by norm_num
  · -- the odd sites of a link factor are its two sites
    have hsub : (Finset.univ.erase s).filter (fun t => ((slabZ2 sq y hy0 hy1 T).mult (Sum.inr (x, ℓ)) t : ZMod 2) = 1)
        ⊆ ({(x.castSucc, ℓ), (x.succ, ℓ)} : Finset (Fin (T + 1) × Lk)).erase s := by
      intro t ht
      simp only [Finset.mem_filter, Finset.mem_erase] at ht
      obtain ⟨⟨hts, _⟩, hodd⟩ := ht
      change ((if t.2 = ℓ ∧ (t.1 = x.castSucc ∨ t.1 = x.succ) then 1 else 0 : ℕ) : ZMod 2) = 1 at hodd
      have ht' : t.2 = ℓ ∧ (t.1 = x.castSucc ∨ t.1 = x.succ) := by
        by_contra h; rw [if_neg h] at hodd; exact absurd hodd (by decide)
      rw [Finset.mem_erase, Finset.mem_insert, Finset.mem_singleton]
      refine ⟨hts, ?_⟩
      rcases ht'.2 with h1 | h1
      · left; exact Prod.ext h1 ht'.1
      · right; exact Prod.ext h1 ht'.1
    have hs : s ∈ ({(x.castSucc, ℓ), (x.succ, ℓ)} : Finset (Fin (T + 1) × Lk)) := by
      change ((if s.2 = ℓ ∧ (s.1 = x.castSucc ∨ s.1 = x.succ) then 1 else 0 : ℕ) : ZMod 2) = 1 at hf
      have hs' : s.2 = ℓ ∧ (s.1 = x.castSucc ∨ s.1 = x.succ) := by
        by_contra h; rw [if_neg h] at hf; exact absurd hf (by decide)
      rw [Finset.mem_insert, Finset.mem_singleton]
      rcases hs'.2 with h1 | h1
      · left; exact Prod.ext h1 hs'.1
      · right; exact Prod.ext h1 hs'.1
    calc _ ≤ (({(x.castSucc, ℓ), (x.succ, ℓ)} : Finset (Fin (T + 1) × Lk)).erase s).card :=
          Finset.card_le_card hsub
      _ = ({(x.castSucc, ℓ), (x.succ, ℓ)} : Finset (Fin (T + 1) × Lk)).card - 1 := Finset.card_erase_of_mem hs
      _ ≤ 2 - 1 := by
          apply Nat.sub_le_sub_right
          refine le_trans (Finset.card_insert_le _ _) ?_
          rw [Finset.card_singleton]
      _ = 1 := by norm_num

/-- the factors reading s oddly: at most m plaquette factors and at most two link factors -/
theorem slabZ2_odd_factors_le (sq : ι → Square Λ) (y : ℝ) (hy0 : 0 < y) (hy1 : y ≤ 1) (T : ℕ) (m : ℕ)
    (hm : ∀ ℓ, linkDegree sq ℓ ≤ m) (s : Fin (T + 1) × Lk) :
    ((Finset.univ : Finset (Fin (T + 1) × ι)).filter
        (fun i => ((slabZ2 sq y hy0 hy1 T).mult (Sum.inl i) s : ZMod 2) = 1)).card ≤ m ∧
    ((Finset.univ : Finset (Fin T × Lk)).filter
        (fun i => ((slabZ2 sq y hy0 hy1 T).mult (Sum.inr i) s : ZMod 2) = 1)).card ≤ 2 := by
  obtain ⟨x, ℓ⟩ := s
  constructor
  · have hsub : (Finset.univ : Finset (Fin (T + 1) × ι)).filter
          (fun i => ((slabZ2 sq y hy0 hy1 T).mult (Sum.inl i) (x, ℓ) : ZMod 2) = 1)
        ⊆ (Finset.univ.filter (fun j : ι => ℓ ∈ squareLinks (sq j))).image (fun j => (x, j)) := by
      rintro ⟨x', j⟩ hj
      simp only [Finset.mem_filter, Finset.mem_univ, true_and] at hj
      change ((if x = x' then (squareList (sq j)).count ℓ else 0 : ℕ) : ZMod 2) = 1 at hj
      have hx : x = x' := by
        by_contra h; rw [if_neg h] at hj; exact absurd hj (by decide)
      rw [if_pos hx] at hj
      have hmem : ℓ ∈ squareList (sq j) := by
        by_contra h
        rw [List.count_eq_zero_of_not_mem h] at hj
        exact absurd hj (by decide)
      rw [Finset.mem_image]
      refine ⟨j, ?_, by rw [hx]⟩
      simp only [Finset.mem_filter, Finset.mem_univ, true_and]
      simp only [squareList, List.mem_cons, List.mem_singleton, List.not_mem_nil, or_false] at hmem
      simp only [squareLinks, Finset.mem_insert, Finset.mem_singleton]
      tauto
    calc _ ≤ ((Finset.univ.filter (fun j : ι => ℓ ∈ squareLinks (sq j))).image (fun j => (x, j))).card :=
          Finset.card_le_card hsub
      _ ≤ (Finset.univ.filter (fun j : ι => ℓ ∈ squareLinks (sq j))).card := Finset.card_image_le
      _ ≤ m := hm ℓ
  · have hsub : (Finset.univ : Finset (Fin T × Lk)).filter
          (fun i => ((slabZ2 sq y hy0 hy1 T).mult (Sum.inr i) (x, ℓ) : ZMod 2) = 1)
        ⊆ (Finset.univ.filter (fun x' : Fin T => x = x'.castSucc ∨ x = x'.succ)).image (fun x' => (x', ℓ)) := by
      rintro ⟨x', ℓ'⟩ hj
      simp only [Finset.mem_filter, Finset.mem_univ, true_and] at hj
      change ((if ℓ = ℓ' ∧ (x = x'.castSucc ∨ x = x'.succ) then 1 else 0 : ℕ) : ZMod 2) = 1 at hj
      have h' : ℓ = ℓ' ∧ (x = x'.castSucc ∨ x = x'.succ) := by
        by_contra h; rw [if_neg h] at hj; exact absurd hj (by decide)
      rw [Finset.mem_image]
      refine ⟨x', ?_, by rw [h'.1]⟩
      simp only [Finset.mem_filter, Finset.mem_univ, true_and]
      exact h'.2
    calc _ ≤ ((Finset.univ.filter (fun x' : Fin T => x = x'.castSucc ∨ x = x'.succ)).image (fun x' => (x', ℓ))).card :=
          Finset.card_le_card hsub
      _ ≤ (Finset.univ.filter (fun x' : Fin T => x = x'.castSucc ∨ x = x'.succ)).card := Finset.card_image_le
      _ ≤ 2 := card_levels_le_two T x

/-- THE ROW SUM OF THE SHARP MATRIX: at most (3m + 2) · c₁(y) -/
theorem slabZ2_rowsum_le (sq : ι → Square Λ) (y : ℝ) (hy0 : 0 < y) (hy1 : y ≤ 1) (T : ℕ) (m : ℕ)
    (hm : ∀ ℓ, linkDegree sq ℓ ≤ m) (s : Fin (T + 1) × Lk) :
    ∑ t, (slabZ2 sq y hy0 hy1 T).C s t ≤ (3 * m + 2) * ((1 - y) / (1 + y)) := by
  set Z := slabZ2 sq y hy0 hy1 T with hZ
  have hc1 : 0 ≤ (1 - y) / (1 + y) := Z.c1_nonneg
  -- the diagonal is zero; off it the entry is shared · c₁
  have hdiag : Z.C s s = 0 := by unfold Z2Sys.C; simp
  rw [← Finset.add_sum_erase Finset.univ _ (Finset.mem_univ s), hdiag, zero_add]
  have hoff : ∀ t ∈ Finset.univ.erase s, Z.C s t = (Z.shared s t : ℝ) * ((1 - y) / (1 + y)) := by
    intro t ht
    unfold Z2Sys.C
    rw [if_neg (Finset.ne_of_mem_erase ht).symm]
    rfl
  rw [Finset.sum_congr rfl hoff, ← Finset.sum_mul]
  apply mul_le_mul_of_nonneg_right _ hc1
  -- Σ_{t ≠ s} shared(s, t) = Σ_f [f reads s oddly] · #{t ≠ s : f reads t oddly}
  have hswap : ∑ t ∈ Finset.univ.erase s, (Z.shared s t : ℝ)
      = ∑ f : SlabIdx ι Lk T, if (Z.mult f s : ZMod 2) = 1 then
          (((Finset.univ.erase s).filter (fun t => (Z.mult f t : ZMod 2) = 1)).card : ℝ) else 0 := by
    unfold Z2Sys.shared
    push_cast
    simp only [Finset.card_filter]
    push_cast
    rw [Finset.sum_comm]
    apply Finset.sum_congr rfl
    intro f _
    split_ifs with hf
    · apply Finset.sum_congr rfl
      intro t _
      simp [hf]
    · apply Finset.sum_eq_zero
      intro t _
      simp [hf]
  rw [hswap, Fintype.sum_sum_type]
  obtain ⟨hA, hB⟩ := slabZ2_odd_factors_le sq y hy0 hy1 T m hm s
  have hinl : ∑ f : Fin (T + 1) × ι, (if (Z.mult (Sum.inl f) s : ZMod 2) = 1 then
        (((Finset.univ.erase s).filter (fun t => (Z.mult (Sum.inl f) t : ZMod 2) = 1)).card : ℝ) else 0)
      ≤ 3 * m := by
    calc _ ≤ ∑ f : Fin (T + 1) × ι, (if (Z.mult (Sum.inl f) s : ZMod 2) = 1 then (3 : ℝ) else 0) := by
          apply Finset.sum_le_sum
          intro f _
          split_ifs with hf
          · exact_mod_cast slabZ2_odd_sites_le sq y hy0 hy1 T s (Sum.inl f) hf
          · exact le_refl 0
      _ = ((Finset.univ.filter (fun f : Fin (T + 1) × ι => (Z.mult (Sum.inl f) s : ZMod 2) = 1)).card : ℝ) * 3 := by
          rw [← Finset.sum_filter, Finset.sum_const, nsmul_eq_mul]
      _ ≤ (m : ℝ) * 3 := by
          apply mul_le_mul_of_nonneg_right _ (by norm_num)
          exact_mod_cast hA
      _ = 3 * m := by ring
  have hinr : ∑ f : Fin T × Lk, (if (Z.mult (Sum.inr f) s : ZMod 2) = 1 then
        (((Finset.univ.erase s).filter (fun t => (Z.mult (Sum.inr f) t : ZMod 2) = 1)).card : ℝ) else 0)
      ≤ 2 := by
    calc _ ≤ ∑ f : Fin T × Lk, (if (Z.mult (Sum.inr f) s : ZMod 2) = 1 then (1 : ℝ) else 0) := by
          apply Finset.sum_le_sum
          intro f _
          split_ifs with hf
          · exact_mod_cast slabZ2_odd_sites_le sq y hy0 hy1 T s (Sum.inr f) hf
          · exact le_refl 0
      _ = ((Finset.univ.filter (fun f : Fin T × Lk => (Z.mult (Sum.inr f) s : ZMod 2) = 1)).card : ℝ) * 1 := by
          rw [← Finset.sum_filter, Finset.sum_const, nsmul_eq_mul]
      _ ≤ 2 := by
          rw [mul_one]
          exact_mod_cast hB
  linarith [hinl, hinr]

/-- THE MASS GAP OF THE Z₂ WILSON SLAB WITH THE SHARP COEFFICIENT: every eigenvalue of the transfer matrix other
than the Perron root is at most (3m + 2)·(1 − y)/(1 + y) · λ₀ -- (6d − 10)·c₁(y) on the cubic lattice -/
theorem transfer_gap_sharp (sq : ι → Square Λ) (y : ℝ) (hy0 : 0 < y) (hy1 : y ≤ 1)
    (hk : (kZ2 y).PosSemidef) (m : ℕ) (hm : ∀ ℓ, linkDegree sq ℓ ≤ m)
    (hα : (3 * m + 2) * ((1 - y) / (1 + y)) < 1) (j : Lk → Z2)
    (hj : (transfer_posSemidef (plaqWeight sq (wZ2 y)) _ (tensorKernel_posSemidef (kZ2 y) hk)).1.eigenvalues j ≠
      lamMax (transfer (plaqWeight sq (wZ2 y)) (tensorKernel (kZ2 y)))
        (transfer_posSemidef (plaqWeight sq (wZ2 y)) _ (tensorKernel_posSemidef (kZ2 y) hk)).1) :
    (transfer_posSemidef (plaqWeight sq (wZ2 y)) _ (tensorKernel_posSemidef (kZ2 y) hk)).1.eigenvalues j ≤
      ((3 * m + 2) * ((1 - y) / (1 + y))) * lamMax (transfer (plaqWeight sq (wZ2 y)) (tensorKernel (kZ2 y)))
        (transfer_posSemidef (plaqWeight sq (wZ2 y)) _ (tensorKernel_posSemidef (kZ2 y) hk)).1 := by
  have hα0 : 0 ≤ (3 * m + 2) * ((1 - y) / (1 + y)) := by
    apply mul_nonneg (by positivity)
    apply div_nonneg <;> linarith
  exact transfer_gap_uniform sq (wZ2 y) y 1 hy0 (wZ2_lo y hy1) (wZ2_hi y hy1) (kZ2 y) hk y 1 hy0 (kZ2_lo y hy1)
    (kZ2_hi y hy1) _ hα0 hα (fun T => (slabZ2 sq y hy0 hy1 T).C) (fun T => (slabZ2 sq y hy0 hy1 T).C_nonneg)
    (fun T => by rw [weight_slab_eq_W]; exact (slabZ2 sq y hy0 hy1 T).interdep)
    (fun T s => slabZ2_rowsum_le sq y hy0 hy1 T m hm s) (fun T => slabZ2_rangeOne sq y hy0 hy1 T) j hj

/-- the regime: (3m + 2)·c₁ < 1 iff y > (3m + 1)/(3m + 3) -- 7/9 at m = 2 (β < ½ ln(9/7) = 0.1257 in three
dimensions), 13/15 at m = 4 (β < ½ ln(15/13) = 0.0716 in four) -/
theorem z2_sharp_lt_one (m : ℕ) (y : ℝ) (hy0 : 0 < y) :
    (3 * m + 2) * ((1 - y) / (1 + y)) < 1 ↔ (3 * m + 1 : ℝ) / (3 * m + 3) < y := by
  have h1 : (0 : ℝ) < 1 + y := by linarith
  have h2 : (0 : ℝ) < 3 * m + 3 := by positivity
  rw [← mul_div_assoc, div_lt_one h1, div_lt_iff₀ h2]
  constructor <;> intro h <;> nlinarith

end SlabZ2Gap

end Aperanton
