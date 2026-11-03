/-
  APERANTON -- THE BOUNDLESS, stage W7′ (ADDENDUM I, THE ROAD): THE ASSEMBLY OF THE WEAK-COUPLING CLAUSE -- THE
  GENERIC LAYER.

  Weak.lean splits the vacuum sector's connected two-point function into the mass-weighted sectors' connected
  two-point functions plus a between-sector term (`vacuum_cov_le`); TorusTwoPoint.lean bounds every sector's term
  by α^R (`sector_two_point_enum`).  THE BETWEEN-SECTOR TERM is the sectors' disagreement about one observable,
  |⟨shift s⟩_{h+t} − ⟨shift s⟩_h| over the twists t, and it is THE SAME TWO-POINT THEOREM READ WITH THE TWIST AS
  THE FAR OBSERVABLE: a coset enumerator does not change under a shift by a code element (`enumAt_add_mem`, so a
  twist may be read at any representative, `sectorExp_add_mem`), and with the twist's representative t′ placed
  R levels past the wall, ⟨shift s⟩_{h+t′} = ⟨shift (t′ + s)⟩_h / ⟨shift t′⟩_h, whose distance from ⟨shift s⟩_h is
  the two-point bound divided by ⟨shift t′⟩_h (`sector_dev_le`).  A sector's distance from the vacuum mixture is
  at most the mass-weighted sum of its distances from the sectors (`dev_le_mixture`).  What remains per side is
  GEOMETRY: a representative of every twist far from the wall (the sheets translated, their slabs' boundaries in D)
  -- the per-L facts the instance files decide.  W = 0; the earning is the between-sector term as a corollary of
  the two-point theorem, uniform in the side.  No sorry, no axiom, no native_decide.
-/
import Mathlib
import Aperanton.Duality
import Aperanton.Weak
import Aperanton.TorusL
import Aperanton.TorusSysL
import Aperanton.TorusLevels
import Aperanton.TorusDecay
import Aperanton.TorusTwoPoint

open Finset

namespace Aperanton

section EnumInvariance

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- a vector of F₂^ι added to itself vanishes -/
theorem add_self_vec' (v : ι → ZMod 2) : v + v = 0 := by
  funext i
  exact CharTwo.add_self_eq_zero (v i)

open Classical in
/-- THE COSET ENUMERATOR IS INVARIANT UNDER A SHIFT BY A CODE ELEMENT: a twist may be read at any representative -/
theorem enumAt_add_mem (D : Submodule (ZMod 2) (ι → ZMod 2)) (h d : ι → ZMod 2) (hd : d ∈ D) (y : ℝ) :
    enumAt D (h + d) y = enumAt D h y := by
  rw [enumAt_eq_sum, enumAt_eq_sum]
  have hdd : d + d = 0 := add_self_vec' d
  refine Finset.sum_nbij' (fun c => c + d) (fun c => c + d) ?_ ?_ ?_ ?_ ?_
  · intro c hc
    rw [Finset.mem_filter] at hc ⊢
    exact ⟨Finset.mem_univ _, Submodule.add_mem _ hc.2 hd⟩
  · intro c hc
    rw [Finset.mem_filter] at hc ⊢
    exact ⟨Finset.mem_univ _, Submodule.add_mem _ hc.2 hd⟩
  · intro c _
    rw [add_assoc, hdd, add_zero]
  · intro c _
    rw [add_assoc, hdd, add_zero]
  · intro c _
    rw [show h + d + c = h + (c + d) by abel]

/-- the sector expectation is invariant under a shift of the twist by a code element -/
theorem sectorExp_add_mem (D : Submodule (ZMod 2) (ι → ZMod 2)) (h d : ι → ZMod 2) (hd : d ∈ D) (y : ℝ)
    (s : ι → ZMod 2) : sectorExp D y (h + d) s = sectorExp D y h s := by
  unfold sectorExp
  rw [show h + d + s = h + s + d by abel, enumAt_add_mem D (h + s) d hd, enumAt_add_mem D h d hd]

end EnumInvariance

section MixtureDeviation

variable {H : Type*} [Fintype H]

/-- a member's distance from the mixture is at most the mass-weighted sum of its distances from the members -/
theorem dev_le_mixture (p F : H → ℝ) (hp0 : ∀ h, 0 ≤ p h) (hp : ∑ h, p h = 1) (h₀ : H) :
    |F h₀ - ∑ k, p k * F k| ≤ ∑ k, p k * |F h₀ - F k| := by
  have hsplit : F h₀ - ∑ k, p k * F k = ∑ k, p k * (F h₀ - F k) := by
    simp only [mul_sub, Finset.sum_sub_distrib, ← Finset.sum_mul, hp, one_mul]
  rw [hsplit]
  calc |∑ k, p k * (F h₀ - F k)| ≤ ∑ k, |p k * (F h₀ - F k)| := Finset.abs_sum_le_sum_abs _ _
    _ = ∑ k, p k * |F h₀ - F k| := Finset.sum_congr rfl fun k _ => by rw [abs_mul, abs_of_nonneg (hp0 k)]

end MixtureDeviation

namespace TorusL

open Classical in
/-- THE BETWEEN-SECTOR DEVIATION AT ANY SIDE: a twist's representative t placed R levels past the wall changes the
sector's reading of a plaquette set s near the wall by at most (#cubes of t)(Σ dOf s) α^R/(1 − α) -/
theorem sector_dev_le (L mu : ℕ) (hadj : AdjList L mu)
    (hdeg : ∀ i : Fin (nPlaq L),
      (univ.filter (fun k : Fin (nCubes L) => ((cubeMult L i k : ℕ) : ZMod 2) = 1)).card = 4)
    (hsix : ∀ s : Fin (nCubes L),
      (univ.filter (fun i : Fin (nPlaq L) => ((cubeMult L i s : ℕ) : ZMod 2) = 1)).card = 6)
    (h : Fin (nPlaq L) → ZMod 2) (y : ℝ) (hy0 : 0 < y) (hy1 : y ≤ 1) (hy : (17 : ℝ) / 19 < y)
    (t s : Fin (nPlaq L) → ZMod 2) (hdisj : ∀ i, t i = 0 ∨ s i = 0) (a R : ℕ)
    (hnear : ∀ k, (∃ i, s i ≠ 0 ∧ cubeMult L i k ≠ 0) → levelAt L mu k ≤ a)
    (hfar : ∀ k, (∃ i, t i ≠ 0 ∧ cubeMult L i k ≠ 0) → a + R ≤ levelAt L mu k) :
    |sectorExp (LinearMap.range (cobdDual L)) y (h + t) s - sectorExp (LinearMap.range (cobdDual L)) y h s| ≤
      (∑ k, if (∃ i, t i ≠ 0 ∧ cubeMult L i k ≠ 0) then (1 : ℝ) else 0) * (∑ k, dOf L s y k) *
        alpha y ^ R / (1 - alpha y) := by
  have hT := sector_two_point_enum L mu hadj hdeg hsix h y hy0 hy1 hy t s hdisj a R hnear hfar
  have hY : 0 < sectorExp (LinearMap.range (cobdDual L)) y h t :=
    div_pos (enumAt_pos _ _ _ hy0) (enumAt_pos _ _ _ hy0)
  have hXY : sectorExp (LinearMap.range (cobdDual L)) y (h + t) s =
      sectorExp (LinearMap.range (cobdDual L)) y h (t + s) / sectorExp (LinearMap.range (cobdDual L)) y h t := by
    unfold sectorExp
    rw [div_div_div_cancel_right₀ (enumAt_pos _ h y hy0).ne', add_assoc]
  rw [hXY, div_sub' hY.ne', abs_div, abs_of_pos hY, div_le_iff₀ hY]
  linarith [hT]

end TorusL

end Aperanton
