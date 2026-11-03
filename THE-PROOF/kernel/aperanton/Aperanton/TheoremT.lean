/-
  APERANTON -- THE BOUNDLESS, stage A1: THEOREM T IN GENERAL FORM (XENODOCHIA 13.3; ANEKOUSTON T-500 at the gauge field).

  For a binary linear code C (the coboundaries B^2 = im δ^1 of any finite cell complex are one) and a word w outside
  it, the coset w + C avoids 0, so its weight enumerator  W_{w+C}(y) = Σ_{c ∈ C} y^{wt(w + c)}  has zero constant term
  and is divisible by y^{d(w)}, d(w) = min wt(w + c) ≥ 1: every coefficient of the weak-coupling expansion of the
  sector's weight below order d(w) is zero, and the sector enters as y^{d(w)} = e^{-2β d(w)} -- zero to every order
  in 1/β.  The trivial coset has constant term 1.  Proved above Mathlib; no sorry.
-/
import Mathlib

namespace Aperanton

open Polynomial Finset

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- the weight of a binary word: the number of nonzero coordinates -/
def wt (v : ι → ZMod 2) : ℕ := (univ.filter (fun i => v i ≠ 0)).card

theorem wt_eq_zero_iff (v : ι → ZMod 2) : wt v = 0 ↔ v = 0 := by
  unfold wt
  rw [card_eq_zero, filter_eq_empty_iff]
  constructor
  · intro h
    funext i
    by_contra hi
    exact h (mem_univ i) hi
  · intro h i _ hi
    exact hi (by simp [h])

theorem one_le_wt_of_ne_zero {v : ι → ZMod 2} (h : v ≠ 0) : 1 ≤ wt v := by
  rcases Nat.eq_zero_or_pos (wt v) with h0 | h0
  · exact absurd ((wt_eq_zero_iff v).1 h0) h
  · exact h0

/-- THE COSET AVOIDS ZERO: w ∉ C and c ∈ C give w + c ≠ 0 -/
theorem coset_avoids_zero (C : Submodule (ZMod 2) (ι → ZMod 2)) {w : ι → ZMod 2} (hw : w ∉ C)
    {c : ι → ZMod 2} (hc : c ∈ C) : w + c ≠ 0 := by
  intro h
  apply hw
  have : w = -c := eq_neg_of_add_eq_zero_left h
  rw [this]
  exact C.neg_mem hc

open Classical in
/-- the coset weight enumerator  W_{w+C}(y) = Σ_{c ∈ C} y^{wt(w + c)}  as an integer polynomial -/
noncomputable def cosetEnum (C : Submodule (ZMod 2) (ι → ZMod 2)) (w : ι → ZMod 2) : Polynomial ℤ :=
  ∑ c ∈ univ.filter (fun c => c ∈ C), (X : Polynomial ℤ) ^ wt (w + c)

open Classical in
/-- the code's members as a finset; nonempty, since 0 ∈ C -/
theorem code_nonempty (C : Submodule (ZMod 2) (ι → ZMod 2)) :
    (univ.filter (fun c => c ∈ C)).Nonempty :=
  ⟨0, mem_filter.2 ⟨mem_univ _, C.zero_mem⟩⟩

open Classical in
/-- the least weight in the coset, d(w) -/
noncomputable def cosetMin (C : Submodule (ZMod 2) (ι → ZMod 2)) (w : ι → ZMod 2) : ℕ :=
  (univ.filter (fun c => c ∈ C)).inf' (code_nonempty C) (fun c => wt (w + c))

open Classical in
/-- THEOREM T, the floor: every coefficient of the coset enumerator below d(w) is zero -- the polynomial is divisible
    by y^{d(w)} -/
theorem theoremT_divisible (C : Submodule (ZMod 2) (ι → ZMod 2)) (w : ι → ZMod 2) :
    (X : Polynomial ℤ) ^ cosetMin C w ∣ cosetEnum C w := by
  unfold cosetEnum
  apply Finset.dvd_sum
  intro c hc
  apply pow_dvd_pow
  unfold cosetMin
  exact Finset.inf'_le (fun c => wt (w + c)) hc

open Classical in
/-- THEOREM T, the minimum: for w outside C, d(w) ≥ 1 -/
theorem theoremT_min_pos (C : Submodule (ZMod 2) (ι → ZMod 2)) {w : ι → ZMod 2} (hw : w ∉ C) :
    1 ≤ cosetMin C w := by
  unfold cosetMin
  apply Finset.le_inf'
  intro c hc
  rw [mem_filter] at hc
  exact one_le_wt_of_ne_zero (coset_avoids_zero C hw hc.2)

open Classical in
/-- THEOREM T, the constant term: for w outside C the sector's enumerator vanishes at y = 0 -/
theorem theoremT_constant_term (C : Submodule (ZMod 2) (ι → ZMod 2)) {w : ι → ZMod 2} (hw : w ∉ C) :
    (cosetEnum C w).coeff 0 = 0 := by
  unfold cosetEnum
  rw [Polynomial.finsetSum_coeff]
  apply Finset.sum_eq_zero
  intro c hc
  rw [mem_filter] at hc
  rw [Polynomial.coeff_X_pow]
  have hne : (0 : ℕ) ≠ wt (w + c) := by
    intro h0
    exact coset_avoids_zero C hw hc.2 ((wt_eq_zero_iff _).1 h0.symm)
  simp [hne]

open Classical in
/-- the trivial sector weighs 1 at y = 0: the single configuration with no frustrated plaquette -/
theorem trivial_sector_constant_term (C : Submodule (ZMod 2) (ι → ZMod 2)) :
    (cosetEnum C 0).coeff 0 = 1 := by
  unfold cosetEnum
  rw [Polynomial.finsetSum_coeff]
  rw [Finset.sum_eq_single (0 : ι → ZMod 2)]
  · have h0 : wt ((0 : ι → ZMod 2) + 0) = 0 := (wt_eq_zero_iff _).2 (by simp)
    rw [Polynomial.coeff_X_pow, h0]
    simp
  · intro c hc hne
    rw [mem_filter] at hc
    rw [Polynomial.coeff_X_pow]
    have hne' : (0 : ℕ) ≠ wt c := by
      intro h0
      exact hne ((wt_eq_zero_iff _).1 h0.symm)
    simp [hne']
  · intro h
    exact absurd (mem_filter.2 ⟨mem_univ _, C.zero_mem⟩) h

/-- THEOREM T, the sector's ratio: with y = e^{-2β}, the sector's weight is y^{d(w)} times a polynomial, so it is
    zero to every order in 1/β -- the statement in the coefficient form the kernel reads -/
theorem theoremT (C : Submodule (ZMod 2) (ι → ZMod 2)) {w : ι → ZMod 2} (hw : w ∉ C) :
    1 ≤ cosetMin C w ∧ (X : Polynomial ℤ) ^ cosetMin C w ∣ cosetEnum C w ∧ (cosetEnum C w).coeff 0 = 0 :=
  ⟨theoremT_min_pos C hw, theoremT_divisible C w, theoremT_constant_term C hw⟩

end Aperanton
