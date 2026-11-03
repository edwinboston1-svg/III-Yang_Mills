/-
  APERANTON -- THE BOUNDLESS, stage W6 (ADDENDUM I, THE ROAD): THE SECTOR TWO-POINT FACTORIZATION AT ANY SIDE --
  THE WEAK-COUPLING CLAUSE'S OBSERVABLE.

  A dual sector's expectation of the shift observable, ⟨shiftObs h s⟩_h = E_{h+s}(y)/E_h(y) (`sectorExp_eq_gibbs`),
  is the sector's reading of the plaquette set supp s.  Here the observable is taken apart: it is the product of
  one ratio per plaquette (`shiftObs_eq_prod`), each ratio one outside supp s (`ratioAt_of_zero`), unchanged when a
  cube adjacent to no plaquette of supp s is updated (`shiftObs_update_of_far`, Dobrushin's `hfree`), at most 1/y per
  plaquette of supp s (`shiftObs_le`, the oscillation mass `dOf`), and MULTIPLICATIVE over disjoint supports
  (`shiftObs_add`).  Dobrushin's covariance bound in the sector (`sector_cov_le`) then reads, for two plaquette sets
  s₂ near the wall (its cubes at levels ≤ a) and s₁ far from it (its cubes at levels ≥ a + R):
      |⟨shiftObs (s₁ + s₂)⟩ − ⟨shiftObs s₁⟩⟨shiftObs s₂⟩| ≤ ⟨shiftObs s₁⟩ · (#cubes of s₁)(Σ dOf s₂) α^R/(1 − α),
  and through the fibre bridge the same for the enumerators (`sector_two_point_enum`): E_{h+s₁+s₂}/E_h factorizes
  as (E_{h+s₁}/E_h)(E_{h+s₂}/E_h) up to α^R, α = 18 c₁(y) -- THE SECTOR TWO-POINT FACTORIZATION, uniform in the side,
  the clause's observable; the vacuum sector's mixture over the 64 twists and the between-sector term are the
  assembly.  W = 0 (Dobrushin on a gauge theory's dual); the earning is the exact statement about the enumerators.
  No sorry, no axiom, no native_decide.
-/
import Mathlib
import Aperanton.Dobrushin
import Aperanton.Z2Slab
import Aperanton.TorusL
import Aperanton.TorusSysL
import Aperanton.TorusLevels
import Aperanton.TorusDecay

open Finset

namespace Aperanton

namespace TorusL

/-- the parity of the twisted system is the untwisted parity plus the shift -/
theorem par_shift (L : ℕ) (h s : Fin (nPlaq L) → ZMod 2) (y : ℝ) (hy0 : 0 < y) (hy1 : y ≤ 1) (i : Fin (nPlaq L))
    (ω : Fin (nCubes L) → Z2) :
    (torusSys L (h + s) y hy0 hy1).par i ω = (torusSys L h y hy0 hy1).par i ω + s i := by
  rw [par_eq, par_eq, Pi.add_apply]
  ring

/-- a cube adjacent to no plaquette i leaves the parity at i unchanged -/
theorem par_update_far (L : ℕ) (h : Fin (nPlaq L) → ZMod 2) (y : ℝ) (hy0 : 0 < y) (hy1 : y ≤ 1)
    (i : Fin (nPlaq L)) (k : Fin (nCubes L)) (hm : cubeMult L i k = 0) (ω : Fin (nCubes L) → Z2) (x : Z2) :
    (torusSys L h y hy0 hy1).par i (Function.update ω k x) = (torusSys L h y hy0 hy1).par i ω := by
  rw [Z2Sys.par_update]
  have hz : ((torusSys L h y hy0 hy1).mult i k : ZMod 2) = 0 := by
    show ((cubeMult L i k : ℕ) : ZMod 2) = 0
    rw [hm, Nat.cast_zero]
  rw [hz, zero_mul, add_zero]

/-- the factor ratio at a plaquette: the twisted factor over the untwisted one -/
noncomputable def ratioAt (L : ℕ) (h s : Fin (nPlaq L) → ZMod 2) (y : ℝ) (hy0 : 0 < y) (hy1 : y ≤ 1)
    (i : Fin (nPlaq L)) (ω : Fin (nCubes L) → Z2) : ℝ :=
  (torusSys L (h + s) y hy0 hy1).w i ω / (torusSys L h y hy0 hy1).w i ω

/-- the ratio in terms of the untwisted parity and the shift -/
theorem ratioAt_eq (L : ℕ) (h s : Fin (nPlaq L) → ZMod 2) (y : ℝ) (hy0 : 0 < y) (hy1 : y ≤ 1) (i : Fin (nPlaq L))
    (ω : Fin (nCubes L) → Z2) :
    ratioAt L h s y hy0 hy1 i ω = (if (torusSys L h y hy0 hy1).par i ω + s i = 1 then y else 1) /
      (if (torusSys L h y hy0 hy1).par i ω = 1 then y else 1) := by
  unfold ratioAt Z2Sys.w
  rw [par_shift, torusSys_y, torusSys_y]

theorem ratioAt_pos (L : ℕ) (h s : Fin (nPlaq L) → ZMod 2) (y : ℝ) (hy0 : 0 < y) (hy1 : y ≤ 1) (i : Fin (nPlaq L))
    (ω : Fin (nCubes L) → Z2) : 0 < ratioAt L h s y hy0 hy1 i ω :=
  div_pos ((torusSys L (h + s) y hy0 hy1).w_pos i ω) ((torusSys L h y hy0 hy1).w_pos i ω)

/-- THE SHIFT OBSERVABLE IS THE PRODUCT OF THE RATIOS -/
theorem shiftObs_eq_prod (L : ℕ) (h s : Fin (nPlaq L) → ZMod 2) (y : ℝ) (hy0 : 0 < y) (hy1 : y ≤ 1)
    (ω : Fin (nCubes L) → Z2) : shiftObs L h s y hy0 hy1 ω = ∏ i, ratioAt L h s y hy0 hy1 i ω := by
  unfold shiftObs ratioAt Z2Sys.W
  rw [Finset.prod_div_distrib]

theorem shiftObs_pos (L : ℕ) (h s : Fin (nPlaq L) → ZMod 2) (y : ℝ) (hy0 : 0 < y) (hy1 : y ≤ 1)
    (ω : Fin (nCubes L) → Z2) : 0 < shiftObs L h s y hy0 hy1 ω :=
  div_pos ((torusSys L (h + s) y hy0 hy1).W_pos ω) ((torusSys L h y hy0 hy1).W_pos ω)

/-- outside the support the ratio is one -/
theorem ratioAt_of_zero (L : ℕ) (h s : Fin (nPlaq L) → ZMod 2) (y : ℝ) (hy0 : 0 < y) (hy1 : y ≤ 1)
    (i : Fin (nPlaq L)) (ω : Fin (nCubes L) → Z2) (hs : s i = 0) : ratioAt L h s y hy0 hy1 i ω = 1 := by
  rw [ratioAt_eq, hs, add_zero]
  have hpos : 0 < (if (torusSys L h y hy0 hy1).par i ω = 1 then y else 1) := by split_ifs <;> linarith
  exact div_self hpos.ne'

/-- a cube adjacent to no plaquette of the support leaves the ratio at every plaquette unchanged -/
theorem ratioAt_update_far (L : ℕ) (h s : Fin (nPlaq L) → ZMod 2) (y : ℝ) (hy0 : 0 < y) (hy1 : y ≤ 1)
    (k : Fin (nCubes L)) (hk : ∀ i, s i ≠ 0 → cubeMult L i k = 0) (i : Fin (nPlaq L))
    (ω : Fin (nCubes L) → Z2) (x : Z2) :
    ratioAt L h s y hy0 hy1 i (Function.update ω k x) = ratioAt L h s y hy0 hy1 i ω := by
  by_cases hs : s i = 0
  · rw [ratioAt_of_zero L h s y hy0 hy1 i _ hs, ratioAt_of_zero L h s y hy0 hy1 i ω hs]
  · rw [ratioAt_eq, ratioAt_eq, par_update_far L h y hy0 hy1 i k (hk i hs)]

/-- Dobrushin's `hfree`: THE SHIFT OBSERVABLE IS UNCHANGED BY A FAR CUBE'S UPDATE -/
theorem shiftObs_update_of_far (L : ℕ) (h s : Fin (nPlaq L) → ZMod 2) (y : ℝ) (hy0 : 0 < y) (hy1 : y ≤ 1)
    (k : Fin (nCubes L)) (hk : ∀ i, s i ≠ 0 → cubeMult L i k = 0) (ω : Fin (nCubes L) → Z2) (x : Z2) :
    shiftObs L h s y hy0 hy1 (Function.update ω k x) = shiftObs L h s y hy0 hy1 ω := by
  rw [shiftObs_eq_prod, shiftObs_eq_prod]
  exact Finset.prod_congr rfl fun i _ => ratioAt_update_far L h s y hy0 hy1 k hk i ω x

/-- a ratio is at most one outside the support and at most 1/y on it -/
theorem ratioAt_le (L : ℕ) (h s : Fin (nPlaq L) → ZMod 2) (y : ℝ) (hy0 : 0 < y) (hy1 : y ≤ 1) (i : Fin (nPlaq L))
    (ω : Fin (nCubes L) → Z2) : ratioAt L h s y hy0 hy1 i ω ≤ if s i = 0 then 1 else 1 / y := by
  by_cases hs : s i = 0
  · rw [if_pos hs, ratioAt_of_zero L h s y hy0 hy1 i ω hs]
  · rw [if_neg hs, ratioAt_eq]
    have hnum : (if (torusSys L h y hy0 hy1).par i ω + s i = 1 then y else 1) ≤ 1 := by split_ifs <;> linarith
    have hden : y ≤ (if (torusSys L h y hy0 hy1).par i ω = 1 then y else 1) := by split_ifs <;> linarith
    have hdpos : 0 < (if (torusSys L h y hy0 hy1).par i ω = 1 then y else 1) := by split_ifs <;> linarith
    rw [div_le_div_iff₀ hdpos hy0]
    nlinarith [mul_le_mul_of_nonneg_right hnum hy0.le, hden]

/-- THE SHIFT OBSERVABLE IS AT MOST (1/y)^|supp s| -/
theorem shiftObs_le (L : ℕ) (h s : Fin (nPlaq L) → ZMod 2) (y : ℝ) (hy0 : 0 < y) (hy1 : y ≤ 1)
    (ω : Fin (nCubes L) → Z2) : shiftObs L h s y hy0 hy1 ω ≤ (1 / y) ^ wt s := by
  rw [shiftObs_eq_prod]
  calc ∏ i, ratioAt L h s y hy0 hy1 i ω ≤ ∏ i, (if s i = 0 then (1 : ℝ) else 1 / y) :=
        Finset.prod_le_prod₀ (fun i _ => (ratioAt_pos L h s y hy0 hy1 i ω).le)
          (fun i _ => ratioAt_le L h s y hy0 hy1 i ω)
    _ = (1 / y) ^ wt s := by
        rw [Finset.prod_ite, Finset.prod_const_one, one_mul, Finset.prod_const]
        congr 1

/-- the oscillation mass of the shift observable: 2 (1/y)^|supp s| at every cube adjacent to the support, 0 elsewhere -/
noncomputable def dOf (L : ℕ) (s : Fin (nPlaq L) → ZMod 2) (y : ℝ) (k : Fin (nCubes L)) : ℝ :=
  if ∃ i, s i ≠ 0 ∧ cubeMult L i k ≠ 0 then 2 * (1 / y) ^ wt s else 0

/-- Dobrushin's `OscBound` for the shift observable -/
theorem shiftObs_oscBound (L : ℕ) (h s : Fin (nPlaq L) → ZMod 2) (y : ℝ) (hy0 : 0 < y) (hy1 : y ≤ 1) :
    OscBound (shiftObs L h s y hy0 hy1) (dOf L s y) := by
  intro k ω g g'
  unfold dOf
  split_ifs with hadj
  · have ha := shiftObs_le L h s y hy0 hy1 (Function.update ω k g)
    have hb := shiftObs_le L h s y hy0 hy1 (Function.update ω k g')
    have ha0 := (shiftObs_pos L h s y hy0 hy1 (Function.update ω k g)).le
    have hb0 := (shiftObs_pos L h s y hy0 hy1 (Function.update ω k g')).le
    calc |shiftObs L h s y hy0 hy1 (Function.update ω k g) - shiftObs L h s y hy0 hy1 (Function.update ω k g')|
        ≤ |shiftObs L h s y hy0 hy1 (Function.update ω k g)| + |shiftObs L h s y hy0 hy1 (Function.update ω k g')| :=
          abs_sub _ _
      _ ≤ 2 * (1 / y) ^ wt s := by
          rw [abs_of_nonneg ha0, abs_of_nonneg hb0]
          linarith
  · push_neg at hadj
    rw [shiftObs_update_of_far L h s y hy0 hy1 k hadj, shiftObs_update_of_far L h s y hy0 hy1 k hadj, sub_self,
      abs_zero]

/-- THE SHIFT OBSERVABLE IS MULTIPLICATIVE OVER DISJOINT SUPPORTS -/
theorem shiftObs_add (L : ℕ) (h s₁ s₂ : Fin (nPlaq L) → ZMod 2) (y : ℝ) (hy0 : 0 < y) (hy1 : y ≤ 1)
    (hdisj : ∀ i, s₁ i = 0 ∨ s₂ i = 0) (ω : Fin (nCubes L) → Z2) :
    shiftObs L h (s₁ + s₂) y hy0 hy1 ω = shiftObs L h s₁ y hy0 hy1 ω * shiftObs L h s₂ y hy0 hy1 ω := by
  rw [shiftObs_eq_prod, shiftObs_eq_prod, shiftObs_eq_prod, ← Finset.prod_mul_distrib]
  refine Finset.prod_congr rfl fun i _ => ?_
  have hpos : 0 < (if (torusSys L h y hy0 hy1).par i ω = 1 then y else 1) := by split_ifs <;> linarith
  rcases hdisj i with h1 | h2
  · rw [ratioAt_eq, ratioAt_eq, ratioAt_eq, Pi.add_apply, h1, zero_add, add_zero, div_self hpos.ne', one_mul]
  · rw [ratioAt_eq, ratioAt_eq, ratioAt_eq, Pi.add_apply, h2, add_zero, add_zero, div_self hpos.ne', mul_one]

/-- THE SECTOR TWO-POINT DECAY AT ANY SIDE: for plaquette sets s₂ near the wall (its cubes at levels ≤ a) and s₁ far
(its cubes at levels ≥ a + R), disjoint, the sector's shift expectation factorizes up to α^R -/
theorem sector_two_point (L mu : ℕ) (hadj : AdjList L mu)
    (hdeg : ∀ i : Fin (nPlaq L),
      (univ.filter (fun k : Fin (nCubes L) => ((cubeMult L i k : ℕ) : ZMod 2) = 1)).card = 4)
    (hsix : ∀ s : Fin (nCubes L),
      (univ.filter (fun i : Fin (nPlaq L) => ((cubeMult L i s : ℕ) : ZMod 2) = 1)).card = 6)
    (h : Fin (nPlaq L) → ZMod 2) (y : ℝ) (hy0 : 0 < y) (hy1 : y ≤ 1) (hy : (17 : ℝ) / 19 < y)
    (s₁ s₂ : Fin (nPlaq L) → ZMod 2) (hdisj : ∀ i, s₁ i = 0 ∨ s₂ i = 0) (a R : ℕ)
    (hnear : ∀ k, (∃ i, s₂ i ≠ 0 ∧ cubeMult L i k ≠ 0) → levelAt L mu k ≤ a)
    (hfar : ∀ k, (∃ i, s₁ i ≠ 0 ∧ cubeMult L i k ≠ 0) → a + R ≤ levelAt L mu k) :
    |gibbs (torusSys L h y hy0 hy1).W (shiftObs L h (s₁ + s₂) y hy0 hy1) -
        gibbs (torusSys L h y hy0 hy1).W (shiftObs L h s₁ y hy0 hy1) *
          gibbs (torusSys L h y hy0 hy1).W (shiftObs L h s₂ y hy0 hy1)| ≤
      gibbs (torusSys L h y hy0 hy1).W (shiftObs L h s₁ y hy0 hy1) *
        ((∑ t, if (∃ i, s₁ i ≠ 0 ∧ cubeMult L i t ≠ 0) then (1 : ℝ) else 0) * (∑ t, dOf L s₂ y t) *
          alpha y ^ R / (1 - alpha y)) := by
  have hprod : (fun ω => shiftObs L h s₂ y hy0 hy1 ω * shiftObs L h s₁ y hy0 hy1 ω)
      = shiftObs L h (s₁ + s₂) y hy0 hy1 := by
    funext ω
    rw [shiftObs_add L h s₁ s₂ y hy0 hy1 hdisj ω, mul_comm]
  have hmain := sector_cov_le L mu hadj hdeg hsix h y hy0 hy1 hy (shiftObs L h s₂ y hy0 hy1) (dOf L s₂ y)
    (shiftObs_oscBound L h s₂ y hy0 hy1) a R
    (fun t ht => by
      have hne : ¬ ∃ i, s₂ i ≠ 0 ∧ cubeMult L i t ≠ 0 := fun hex => by
        have := hnear t hex
        omega
      simp [dOf, hne])
    (shiftObs L h s₁ y hy0 hy1) (shiftObs_pos L h s₁ y hy0 hy1) (fun t => ∃ i, s₁ i ≠ 0 ∧ cubeMult L i t ≠ 0)
    (fun t ht ω x => by
      push_neg at ht
      exact shiftObs_update_of_far L h s₁ y hy0 hy1 t ht ω x)
    (fun t ht hex => by
      have := hfar t hex
      omega)
  rw [hprod, mul_comm (gibbs (torusSys L h y hy0 hy1).W (shiftObs L h s₂ y hy0 hy1))] at hmain
  exact hmain

open Classical in
/-- THE SECTOR TWO-POINT FACTORIZATION OF THE ENUMERATORS: E_{h+s₁+s₂}/E_h parts from (E_{h+s₁}/E_h)(E_{h+s₂}/E_h) by
at most (E_{h+s₁}/E_h)(#cubes of s₁)(Σ dOf s₂) α^R/(1 − α) -/
theorem sector_two_point_enum (L mu : ℕ) (hadj : AdjList L mu)
    (hdeg : ∀ i : Fin (nPlaq L),
      (univ.filter (fun k : Fin (nCubes L) => ((cubeMult L i k : ℕ) : ZMod 2) = 1)).card = 4)
    (hsix : ∀ s : Fin (nCubes L),
      (univ.filter (fun i : Fin (nPlaq L) => ((cubeMult L i s : ℕ) : ZMod 2) = 1)).card = 6)
    (h : Fin (nPlaq L) → ZMod 2) (y : ℝ) (hy0 : 0 < y) (hy1 : y ≤ 1) (hy : (17 : ℝ) / 19 < y)
    (s₁ s₂ : Fin (nPlaq L) → ZMod 2) (hdisj : ∀ i, s₁ i = 0 ∨ s₂ i = 0) (a R : ℕ)
    (hnear : ∀ k, (∃ i, s₂ i ≠ 0 ∧ cubeMult L i k ≠ 0) → levelAt L mu k ≤ a)
    (hfar : ∀ k, (∃ i, s₁ i ≠ 0 ∧ cubeMult L i k ≠ 0) → a + R ≤ levelAt L mu k) :
    |sectorExp (LinearMap.range (cobdDual L)) y h (s₁ + s₂) -
        sectorExp (LinearMap.range (cobdDual L)) y h s₁ * sectorExp (LinearMap.range (cobdDual L)) y h s₂| ≤
      sectorExp (LinearMap.range (cobdDual L)) y h s₁ *
        ((∑ t, if (∃ i, s₁ i ≠ 0 ∧ cubeMult L i t ≠ 0) then (1 : ℝ) else 0) * (∑ t, dOf L s₂ y t) *
          alpha y ^ R / (1 - alpha y)) := by
  rw [sectorExp_eq_gibbs L h (s₁ + s₂) y hy0 hy1, sectorExp_eq_gibbs L h s₁ y hy0 hy1,
    sectorExp_eq_gibbs L h s₂ y hy0 hy1]
  exact sector_two_point L mu hadj hdeg hsix h y hy0 hy1 hy s₁ s₂ hdisj a R hnear hfar

end TorusL

end Aperanton
