import Aperanton.GephyrosisDepth
import Aperanton.TyrbeShape

/-!
# ΤΥΡΒΗ — Τ1 at the first box with two grades: (2D, K = 4, p = 5)

The page staked a three-level shape: the eight coordinates of the modes `(3,4), (4,3), (3,−4), (4,−3)` (grade 2,
`|k|² = 25`) at the top, twenty-four coordinates of grade 1 (`|k|² ∈ {5, 10, 20}`) one below, forty-eight of
grade 0 two below, at every step — `T(s) = 2^s`. Decided on the literal road `R24lit` and carried to every step
by the profile closure of `certK4`.
-/

namespace Gephyrosis

theorem shape24_five_1 : (autoOrbit R24lit 5 zero80 1).1 = shape2 4 5 2 2 := by decide +kernel
theorem shape24_five_2 : (autoOrbit R24lit 5 zero80 2).1 = shape2 4 5 2 4 := by decide +kernel

/-- the counts the page staked: 8 at the top, 24 one below, 48 two below -/
theorem top_counts_K4 :
    ((basis2D 4).filter fun b => grade2 5 b = 2).length = 8 ∧
    ((basis2D 4).filter fun b => grade2 5 b = 1).length = 24 ∧
    ((basis2D 4).filter fun b => grade2 5 b = 0).length = 48 := by decide +kernel

/-- **Τ1 at (2D, K = 4, p = 5)**: the three-level shape `2^s − (2 − g_k)` at every step, every integer seed. -/
theorem tau1_K4_five (c0 : List ℤ) (s : ℕ) (hs : 1 ≤ s) :
    (autoOrbit R24lit 5 c0 s).1 = shape2 4 5 2 (2 ^ s) := by
  have : Fact (Nat.Prime 5) := ⟨by norm_num⟩
  have hc := certK4_true
  unfold certK4 at hc
  simp only [Bool.and_eq_true] at hc
  obtain ⟨⟨⟨hwf, hcl⟩, hna⟩, -⟩ := hc
  rw [profile_indep R24lit c0 zero80 s,
    profile_geom R24lit zero80 (wellformed_of_check _ hwf) 2 (by norm_num) (of_decide_eq_true hcl)
      (nonAttain_of_check _ _ _ hna) s hs, shape24_five_1, shape2_shift]
  have h2 : (2 : ℤ) ^ s = 2 * 2 ^ (s - 1) := by
    rw [← pow_succ', Nat.sub_add_cancel hs]
  have h : (2 : ℤ) + 2 * (2 ^ (s - 1) - 1) = 2 ^ s := by rw [h2]; ring
  rw [h]

/-- **Τ2 at K = 4**: the three-level shape is present at step 1 from every integer seed. -/
theorem tau2_K4_five (c0 : List ℤ) : (autoOrbit R24lit 5 c0 1).1 = shape2 4 5 2 2 := by
  have : Fact (Nat.Prime 5) := ⟨by norm_num⟩
  rw [profile_indep R24lit c0 zero80 1, shape24_five_1]

end Gephyrosis
