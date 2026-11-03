/-
  APERANTON -- THE BOUNDLESS, stage W7′ (ADDENDUM I, THE ROAD): THE WEAK-COUPLING CLAUSE ASSEMBLED AT ANY SIDE --
  THE VACUUM TWO-POINT FUNCTION OF THE Z₂ THEORY ON T⁴_L AT WEAK COUPLING.

  THE STATEMENT (`vacuum_two_point_le`).  On the four-torus of side L at the original coupling y₀ (so the dual
  coupling y* = (1 − y₀)/(1 + y₀) exceeds 17/19, i.e. y₀ < 1/18, β > ½ ln 18), for two disjoint plaquette sets s₂
  near a wall and s₁ R levels past it, and with every twist given a representative far from both (the sheets
  translated, one wall direction per sheet, R′ levels past it):
      |⟨(−1)^{s₁+s₂}⟩_vac − ⟨(−1)^{s₁}⟩_vac ⟨(−1)^{s₂}⟩_vac|
        ≤ (1/y*)^{|s₁|} · (#cubes of s₁)(Σ dOf s₂) α^R/(1 − α)  +  (2 Σ_q B_q(s₁)) (2 Σ_q B_q(s₂)),
  B_q(s) = (#cubes of the far sheet q)(Σ dOf s) α^{R′}/(1 − α), α = 18 c₁(y*).  THE PIECES: Weak.lean's split of
  the vacuum covariance into the sectors' terms and the between-sector term (`vacuum_cov_le`); each sector's term
  by THE TWO-POINT FACTORIZATION (`sector_two_point_enum`, TorusTwoPoint.lean) with the sector expectation's sup
  (1/y*)^{|s₁|}; the between-sector term by the mixture deviation (`dev_le_mixture'`), THE TELESCOPING OF A TWIST
  OVER ITS SHEETS (`sectorExp_twist_sub_le`: a twist is a subset sum of the six sheets, each step one sheet) and
  THE BETWEEN-SECTOR DEVIATION per sheet (`step_bound`: the sheet read at its far translate by `sectorExp_add_mem`,
  then `sector_dev_le`).  The per-side facts enter as hypotheses: the five incidence facts (`hadj` along the wall
  directions used, `hdeg`, `hsix`, `hcol`), the split, the far translates with their memberships, disjointness and
  levels -- at side 3 all decided (TorusL3, TorusT3L3), the levels there at most one.  W = 0 (Dobrushin on the dual
  of a gauge theory, through Wegner's duality); the earning is the clause as one theorem uniform in the side.
  No sorry, no axiom, no native_decide.
-/
import Mathlib
import Aperanton.Dobrushin
import Aperanton.Duality
import Aperanton.Weak
import Aperanton.TorusL
import Aperanton.TorusLBridge
import Aperanton.TorusSysL
import Aperanton.TorusLevels
import Aperanton.TorusDecay
import Aperanton.TorusTwoPoint
import Aperanton.TorusT3

open Finset

namespace Aperanton

section Helpers

variable {S : Type*} [Fintype S] [DecidableEq S] {G : Type*} [Fintype G] [DecidableEq G] [Nonempty G]

end Helpers

section MixtureFinset

variable {ι : Type*}

/-- a member's distance from a finset mixture is at most the mass-weighted sum of its distances from the members -/
theorem dev_le_mixture' (p F : ι → ℝ) (H : Finset ι) (hp0 : ∀ h ∈ H, 0 ≤ p h) (hp : ∑ h ∈ H, p h = 1)
    (h₀ : ι) : |F h₀ - ∑ k ∈ H, p k * F k| ≤ ∑ k ∈ H, p k * |F h₀ - F k| := by
  have hsplit : F h₀ - ∑ k ∈ H, p k * F k = ∑ k ∈ H, p k * (F h₀ - F k) := by
    simp only [mul_sub, Finset.sum_sub_distrib, ← Finset.sum_mul, hp, one_mul]
  rw [hsplit]
  calc |∑ k ∈ H, p k * (F h₀ - F k)| ≤ ∑ k ∈ H, |p k * (F h₀ - F k)| := Finset.abs_sum_le_sum_abs _ _
    _ = ∑ k ∈ H, p k * |F h₀ - F k| := Finset.sum_congr rfl fun k hk => by rw [abs_mul, abs_of_nonneg (hp0 k hk)]

end MixtureFinset

section Telescoping

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- THE TELESCOPING OF A TWIST OVER ITS SHEETS: if every single-sheet step moves a sector's reading by at most b q,
a subset sum of sheets moves it by at most the sum of the b's -/
theorem sectorExp_twist_sub_le (D : Submodule (ZMod 2) (ι → ZMod 2)) (y : ℝ) (s : ι → ZMod 2)
    (sh : Fin 6 → (ι → ZMod 2)) (b : Fin 6 → ℝ)
    (hstep : ∀ (h' : ι → ZMod 2) (q : Fin 6), |sectorExp D y (h' + sh q) s - sectorExp D y h' s| ≤ b q)
    (h : ι → ZMod 2) (T : Finset (Fin 6)) :
    |sectorExp D y (h + ∑ q ∈ T, sh q) s - sectorExp D y h s| ≤ ∑ q ∈ T, b q := by
  induction T using Finset.induction_on with
  | empty => simp
  | insert q T hq ih =>
    rw [Finset.sum_insert hq, Finset.sum_insert hq,
      show h + (sh q + ∑ r ∈ T, sh r) = h + ∑ r ∈ T, sh r + sh q by abel]
    calc |sectorExp D y (h + ∑ r ∈ T, sh r + sh q) s - sectorExp D y h s|
        ≤ |sectorExp D y (h + ∑ r ∈ T, sh r + sh q) s - sectorExp D y (h + ∑ r ∈ T, sh r) s|
          + |sectorExp D y (h + ∑ r ∈ T, sh r) s - sectorExp D y h s| :=
            abs_sub_le (sectorExp D y (h + ∑ r ∈ T, sh r + sh q) s) (sectorExp D y (h + ∑ r ∈ T, sh r) s)
              (sectorExp D y h s)
      _ ≤ b q + ∑ r ∈ T, b r := add_le_add (hstep _ q) ih

end Telescoping

namespace TorusL

/-- the number of cubes adjacent to a plaquette set -/
noncomputable def cnt (L : ℕ) (t : Fin (nPlaq L) → ZMod 2) : ℝ :=
  ∑ k, if (∃ i, t i ≠ 0 ∧ cubeMult L i k ≠ 0) then (1 : ℝ) else 0

theorem dualVar_le_one (y₀ : ℝ) (hy0 : 0 < y₀) : dualVar y₀ ≤ 1 := by
  unfold dualVar
  rw [div_le_one (by linarith)]
  linarith

open Classical in
/-- the sector expectation of a shift is at most (1/y)^|supp s| -/
theorem sectorExp_le (L : ℕ) (h s : Fin (nPlaq L) → ZMod 2) (y : ℝ) (hy0 : 0 < y) (hy1 : y ≤ 1) :
    sectorExp (LinearMap.range (cobdDual L)) y h s ≤ (1 / y) ^ wt s := by
  rw [sectorExp_eq_gibbs L h s y hy0 hy1]
  exact gibbs_le_of_le _ (torusSys L h y hy0 hy1).W_pos _ _ (shiftObs_le L h s y hy0 hy1)

open Classical in
/-- THE BETWEEN-SECTOR STEP: one sheet, read at its far translate, moves a sector's reading of s by at most
cnt(far)(Σ dOf s) α^{R′}/(1 − α) -/
theorem step_bound (L : ℕ) (mu : ℕ) (hadj : AdjList L mu)
    (hdeg : ∀ i : Fin (nPlaq L),
      (univ.filter (fun k : Fin (nCubes L) => ((cubeMult L i k : ℕ) : ZMod 2) = 1)).card = 4)
    (hsix : ∀ s : Fin (nCubes L),
      (univ.filter (fun i : Fin (nPlaq L) => ((cubeMult L i s : ℕ) : ZMod 2) = 1)).card = 6)
    (y : ℝ) (hy0 : 0 < y) (hy1 : y ≤ 1) (hy : (17 : ℝ) / 19 < y) (s sheet far : Fin (nPlaq L) → ZMod 2)
    (hmem : far + sheet ∈ LinearMap.range (cobdDual L)) (hdisj : ∀ i, far i = 0 ∨ s i = 0) (a' R' : ℕ)
    (hnear : ∀ k, (∃ i, s i ≠ 0 ∧ cubeMult L i k ≠ 0) → levelAt L mu k ≤ a')
    (hfarlev : ∀ k, (∃ i, far i ≠ 0 ∧ cubeMult L i k ≠ 0) → a' + R' ≤ levelAt L mu k) (h' : Fin (nPlaq L) → ZMod 2) :
    |sectorExp (LinearMap.range (cobdDual L)) y (h' + sheet) s - sectorExp (LinearMap.range (cobdDual L)) y h' s| ≤
      cnt L far * (∑ k, dOf L s y k) * alpha y ^ R' / (1 - alpha y) := by
  have hrep : sectorExp (LinearMap.range (cobdDual L)) y (h' + sheet) s =
      sectorExp (LinearMap.range (cobdDual L)) y (h' + far) s := by
    rw [← sectorExp_add_mem (LinearMap.range (cobdDual L)) (h' + sheet) (far + sheet) hmem y s]
    congr 1
    rw [show h' + sheet + (far + sheet) = h' + far + (sheet + sheet) by abel, add_self_vec', add_zero]
  rw [hrep]
  exact sector_dev_le L mu hadj hdeg hsix h' y hy0 hy1 hy far s hdisj a' R' hnear hfarlev

open Classical in
/-- THE WEAK-COUPLING CLAUSE AT ANY SIDE: the vacuum two-point function of the Z₂ theory on T⁴_L at the original
coupling y₀ with dual coupling above 17/19, for disjoint plaquette sets separated by R wall levels, with every sheet
given a far translate (R′ levels past its own wall) -/
theorem vacuum_two_point_le (L : ℕ) (hadj : ∀ mu : Fin 4, AdjList L mu.val)
    (hdeg : ∀ i : Fin (nPlaq L),
      (univ.filter (fun k : Fin (nCubes L) => ((cubeMult L i k : ℕ) : ZMod 2) = 1)).card = 4)
    (hsix : ∀ s : Fin (nCubes L),
      (univ.filter (fun i : Fin (nPlaq L) => ((cubeMult L i s : ℕ) : ZMod 2) = 1)).card = 6)
    (hcol : ∀ (k : Fin (nCubes L)) (i : Fin (nPlaq L)), ((cubeMult L i k : ℕ) : ZMod 2) = vecOf L (cubeMask L k.val) i)
    (hs : TorusLSplit L) (y₀ : ℝ) (hy0 : 0 < y₀) (hy1 : y₀ < 1) (hstar : (17 : ℝ) / 19 < dualVar y₀)
    (s₁ s₂ : Fin (nPlaq L) → ZMod 2) (hdisj : ∀ i, s₁ i = 0 ∨ s₂ i = 0) (mu : Fin 4) (a R : ℕ)
    (hnear : ∀ k, (∃ i, s₂ i ≠ 0 ∧ cubeMult L i k ≠ 0) → levelAt L mu.val k ≤ a)
    (hfar : ∀ k, (∃ i, s₁ i ≠ 0 ∧ cubeMult L i k ≠ 0) → a + R ≤ levelAt L mu.val k)
    (far : Fin 6 → (Fin (nPlaq L) → ZMod 2)) (dir : Fin 6 → Fin 4) (a' R' : ℕ)
    (hfarmem : ∀ q, far q + vecOf L (sheetMask L q.val) ∈ D L)
    (hfardisj₁ : ∀ q i, far q i = 0 ∨ s₁ i = 0) (hfardisj₂ : ∀ q i, far q i = 0 ∨ s₂ i = 0)
    (hnear₁ : ∀ q k, (∃ i, s₁ i ≠ 0 ∧ cubeMult L i k ≠ 0) → levelAt L (dir q).val k ≤ a')
    (hnear₂ : ∀ q k, (∃ i, s₂ i ≠ 0 ∧ cubeMult L i k ≠ 0) → levelAt L (dir q).val k ≤ a')
    (hfarlev : ∀ q k, (∃ i, far q i ≠ 0 ∧ cubeMult L i k ≠ 0) → a' + R' ≤ levelAt L (dir q).val k) :
    |vacExp (K L) y₀ (s₁ + s₂) - vacExp (K L) y₀ s₁ * vacExp (K L) y₀ s₂| ≤
      (1 / dualVar y₀) ^ wt s₁ * (cnt L s₁ * (∑ k, dOf L s₂ (dualVar y₀) k) * alpha (dualVar y₀) ^ R /
          (1 - alpha (dualVar y₀)))
        + (2 * ∑ q : Fin 6, cnt L (far q) * (∑ k, dOf L s₁ (dualVar y₀) k) * alpha (dualVar y₀) ^ R' /
            (1 - alpha (dualVar y₀)))
          * (2 * ∑ q : Fin 6, cnt L (far q) * (∑ k, dOf L s₂ (dualVar y₀) k) * alpha (dualVar y₀) ^ R' /
            (1 - alpha (dualVar y₀))) := by
  set y := dualVar y₀ with hy
  have hy0' : 0 < y := dualVar_pos y₀ hy0 hy1
  have hy1' : y ≤ 1 := dualVar_le_one y₀ hy0
  have hR : LinearMap.range (cobdDual L) = D L := range_cobdDual_eq_D L hcol
  unfold TorusLSplit at hs
  have hH : (H L).Nonempty := hs.nonempty
  have hmass0 : ∀ h ∈ H L, 0 ≤ sectorMass (D L) (H L) y h := fun h _ => sectorMass_nonneg (D L) (H L) y hy0' h
  have hmass1 : ∑ h ∈ H L, sectorMass (D L) (H L) y h = 1 := sectorMass_sum (D L) (H L) hH y hy0'
  -- the sector terms
  set B₁ : ℝ := (1 / y) ^ wt s₁ * (cnt L s₁ * (∑ k, dOf L s₂ y k) * alpha y ^ R / (1 - alpha y)) with hB₁
  have hsector : ∀ h ∈ H L,
      |sectorExp (D L) y h (s₁ + s₂) - sectorExp (D L) y h s₁ * sectorExp (D L) y h s₂| ≤ B₁ := by
    intro h _
    rw [← hR]
    have h2 := sector_two_point_enum L mu.val (hadj mu) hdeg hsix h y hy0' hy1' hstar s₁ s₂ hdisj a R hnear hfar
    have hle := sectorExp_le L h s₁ y hy0' hy1'
    have hc : 0 ≤ cnt L s₁ * (∑ k, dOf L s₂ y k) * alpha y ^ R / (1 - alpha y) := by
      have hα1 : alpha y < 1 := (alpha_lt_one_iff y hy0').mpr hstar
      have hcnt : 0 ≤ cnt L s₁ := Finset.sum_nonneg fun k _ => by split_ifs <;> norm_num
      have hd : 0 ≤ ∑ k, dOf L s₂ y k := Finset.sum_nonneg fun k _ => by
        unfold dOf; split_ifs <;> positivity
      have hα0 : 0 ≤ alpha y := alpha_nonneg y hy0' hy1'
      apply div_nonneg _ (by linarith)
      exact mul_nonneg (mul_nonneg hcnt hd) (pow_nonneg hα0 R)
    calc _ ≤ sectorExp (LinearMap.range (cobdDual L)) y h s₁ *
          (cnt L s₁ * (∑ k, dOf L s₂ y k) * alpha y ^ R / (1 - alpha y)) := h2
      _ ≤ B₁ := mul_le_mul_of_nonneg_right hle hc
  -- the between-sector deviations: every sector's reading is within 2 Σ_q b q of every other's
  have hstep : ∀ (s : Fin (nPlaq L) → ZMod 2), (∀ q i, far q i = 0 ∨ s i = 0) →
      (∀ q k, (∃ i, s i ≠ 0 ∧ cubeMult L i k ≠ 0) → levelAt L (dir q).val k ≤ a') →
      ∀ (h' : Fin (nPlaq L) → ZMod 2) (q : Fin 6),
        |sectorExp (D L) y (h' + vecOf L (sheetMask L q.val)) s - sectorExp (D L) y h' s| ≤
          cnt L (far q) * (∑ k, dOf L s y k) * alpha y ^ R' / (1 - alpha y) := by
    intro s hd hn h' q
    rw [← hR]
    have hmem : far q + vecOf L (sheetMask L q.val) ∈ LinearMap.range (cobdDual L) := by rw [hR]; exact hfarmem q
    exact step_bound L (dir q).val (hadj (dir q)) hdeg hsix y hy0' hy1' hstar s (vecOf L (sheetMask L q.val)) (far q)
      hmem (hd q) a' R' (hn q) (hfarlev q) h'
  have hdev : ∀ (s : Fin (nPlaq L) → ZMod 2), (∀ q i, far q i = 0 ∨ s i = 0) →
      (∀ q k, (∃ i, s i ≠ 0 ∧ cubeMult L i k ≠ 0) → levelAt L (dir q).val k ≤ a') →
      ∀ h ∈ H L, ∀ k ∈ H L, |sectorExp (D L) y h s - sectorExp (D L) y k s| ≤
        2 * ∑ q : Fin 6, cnt L (far q) * (∑ k, dOf L s y k) * alpha y ^ R' / (1 - alpha y) := by
    intro s hd hn h hh k hk
    unfold H at hh hk
    rw [Finset.mem_image] at hh hk
    obtain ⟨T, _, rfl⟩ := hh
    obtain ⟨T', _, rfl⟩ := hk
    have hT := sectorExp_twist_sub_le (D L) y s (fun q => vecOf L (sheetMask L q.val))
      (fun q => cnt L (far q) * (∑ k, dOf L s y k) * alpha y ^ R' / (1 - alpha y)) (hstep s hd hn) 0 T
    have hT' := sectorExp_twist_sub_le (D L) y s (fun q => vecOf L (sheetMask L q.val))
      (fun q => cnt L (far q) * (∑ k, dOf L s y k) * alpha y ^ R' / (1 - alpha y)) (hstep s hd hn) 0 T'
    simp only [zero_add] at hT hT'
    have hb0 : ∀ q, 0 ≤ cnt L (far q) * (∑ k, dOf L s y k) * alpha y ^ R' / (1 - alpha y) := by
      intro q
      have hα1 : alpha y < 1 := (alpha_lt_one_iff y hy0').mpr hstar
      have hcnt : 0 ≤ cnt L (far q) := Finset.sum_nonneg fun k _ => by split_ifs <;> norm_num
      have hdd : 0 ≤ ∑ k, dOf L s y k := Finset.sum_nonneg fun k _ => by
        unfold dOf; split_ifs <;> positivity
      apply div_nonneg _ (by linarith)
      exact mul_nonneg (mul_nonneg hcnt hdd) (pow_nonneg (alpha_nonneg y hy0' hy1') R')
    have hsub : ∀ U : Finset (Fin 6), ∑ q ∈ U, cnt L (far q) * (∑ k, dOf L s y k) * alpha y ^ R' / (1 - alpha y)
        ≤ ∑ q : Fin 6, cnt L (far q) * (∑ k, dOf L s y k) * alpha y ^ R' / (1 - alpha y) :=
      fun U => Finset.sum_le_sum_of_subset_of_nonneg (Finset.subset_univ U) (fun q _ _ => hb0 q)
    calc |sectorExp (D L) y (∑ q ∈ T, vecOf L (sheetMask L q.val)) s -
            sectorExp (D L) y (∑ q ∈ T', vecOf L (sheetMask L q.val)) s|
        ≤ |sectorExp (D L) y (∑ q ∈ T, vecOf L (sheetMask L q.val)) s - sectorExp (D L) y 0 s|
          + |sectorExp (D L) y 0 s - sectorExp (D L) y (∑ q ∈ T', vecOf L (sheetMask L q.val)) s| :=
            abs_sub_le _ _ _
      _ ≤ (∑ q ∈ T, cnt L (far q) * (∑ k, dOf L s y k) * alpha y ^ R' / (1 - alpha y))
          + ∑ q ∈ T', cnt L (far q) * (∑ k, dOf L s y k) * alpha y ^ R' / (1 - alpha y) := by
            rw [abs_sub_comm (sectorExp (D L) y 0 s)]
            exact add_le_add hT hT'
      _ ≤ 2 * ∑ q : Fin 6, cnt L (far q) * (∑ k, dOf L s y k) * alpha y ^ R' / (1 - alpha y) := by
            have := hsub T
            have := hsub T'
            linarith
  set Δ₁ : ℝ := 2 * ∑ q : Fin 6, cnt L (far q) * (∑ k, dOf L s₁ y k) * alpha y ^ R' / (1 - alpha y) with hΔ₁
  set Δ₂ : ℝ := 2 * ∑ q : Fin 6, cnt L (far q) * (∑ k, dOf L s₂ y k) * alpha y ^ R' / (1 - alpha y) with hΔ₂
  have hΔ₁0 : 0 ≤ Δ₁ := by
    rw [hΔ₁]
    apply mul_nonneg (by norm_num)
    apply Finset.sum_nonneg
    intro q _
    have hα1 : alpha y < 1 := (alpha_lt_one_iff y hy0').mpr hstar
    have hcnt : 0 ≤ cnt L (far q) := Finset.sum_nonneg fun k _ => by split_ifs <;> norm_num
    have hdd : 0 ≤ ∑ k, dOf L s₁ y k := Finset.sum_nonneg fun k _ => by
      unfold dOf; split_ifs <;> positivity
    apply div_nonneg _ (by linarith)
    exact mul_nonneg (mul_nonneg hcnt hdd) (pow_nonneg (alpha_nonneg y hy0' hy1') R')
  have hΔ₂0 : 0 ≤ Δ₂ := by
    rw [hΔ₂]
    apply mul_nonneg (by norm_num)
    apply Finset.sum_nonneg
    intro q _
    have hα1 : alpha y < 1 := (alpha_lt_one_iff y hy0').mpr hstar
    have hcnt : 0 ≤ cnt L (far q) := Finset.sum_nonneg fun k _ => by split_ifs <;> norm_num
    have hdd : 0 ≤ ∑ k, dOf L s₂ y k := Finset.sum_nonneg fun k _ => by
      unfold dOf; split_ifs <;> positivity
    apply div_nonneg _ (by linarith)
    exact mul_nonneg (mul_nonneg hcnt hdd) (pow_nonneg (alpha_nonneg y hy0' hy1') R')
  -- a sector's distance from the vacuum mixture
  have hvac : ∀ (s : Fin (nPlaq L) → ZMod 2) (Δ : ℝ), 0 ≤ Δ →
      (∀ h ∈ H L, ∀ k ∈ H L, |sectorExp (D L) y h s - sectorExp (D L) y k s| ≤ Δ) →
      ∀ h ∈ H L, |sectorExp (D L) y h s - vacExp (K L) y₀ s| ≤ Δ := by
    intro s Δ hΔ hpair h hh
    rw [vacExp_eq_mixture (K L) (D L) (H L) hs s y₀ hy0 hy1]
    calc |sectorExp (D L) y h s - ∑ k ∈ H L, sectorMass (D L) (H L) y k * sectorExp (D L) y k s|
        ≤ ∑ k ∈ H L, sectorMass (D L) (H L) y k * |sectorExp (D L) y h s - sectorExp (D L) y k s| :=
          dev_le_mixture' (sectorMass (D L) (H L) y) (fun k => sectorExp (D L) y k s) (H L) hmass0 hmass1 h
      _ ≤ ∑ k ∈ H L, sectorMass (D L) (H L) y k * Δ :=
          Finset.sum_le_sum fun k hk => mul_le_mul_of_nonneg_left (hpair h hh k hk) (hmass0 k hk)
      _ = Δ := by rw [← Finset.sum_mul, hmass1, one_mul]
  have hvac₁ := hvac s₁ Δ₁ hΔ₁0 (hdev s₁ hfardisj₁ hnear₁)
  have hvac₂ := hvac s₂ Δ₂ hΔ₂0 (hdev s₂ hfardisj₂ hnear₂)
  -- the assembly
  have hcov := vacuum_cov_le (K L) (D L) (H L) hs s₁ s₂ y₀ hy0 hy1
  rw [← hy] at hcov
  have hterm1 : ∑ h ∈ H L, sectorMass (D L) (H L) y h *
      |sectorExp (D L) y h (s₁ + s₂) - sectorExp (D L) y h s₁ * sectorExp (D L) y h s₂| ≤ B₁ := by
    calc _ ≤ ∑ h ∈ H L, sectorMass (D L) (H L) y h * B₁ :=
          Finset.sum_le_sum fun h hh => mul_le_mul_of_nonneg_left (hsector h hh) (hmass0 h hh)
      _ = B₁ := by rw [← Finset.sum_mul, hmass1, one_mul]
  have hterm2 : ∑ h ∈ H L, sectorMass (D L) (H L) y h *
      (|sectorExp (D L) y h s₁ - vacExp (K L) y₀ s₁| * |sectorExp (D L) y h s₂ - vacExp (K L) y₀ s₂|) ≤ Δ₁ * Δ₂ := by
    calc _ ≤ ∑ h ∈ H L, sectorMass (D L) (H L) y h * (Δ₁ * Δ₂) := by
          apply Finset.sum_le_sum
          intro h hh
          apply mul_le_mul_of_nonneg_left _ (hmass0 h hh)
          exact mul_le_mul (hvac₁ h hh) (hvac₂ h hh) (abs_nonneg _) hΔ₁0
      _ = Δ₁ * Δ₂ := by rw [← Finset.sum_mul, hmass1, one_mul]
  calc |vacExp (K L) y₀ (s₁ + s₂) - vacExp (K L) y₀ s₁ * vacExp (K L) y₀ s₂| ≤ _ := hcov
    _ ≤ B₁ + Δ₁ * Δ₂ := add_le_add hterm1 hterm2

end TorusL

end Aperanton
