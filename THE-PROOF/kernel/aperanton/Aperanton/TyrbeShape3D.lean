import Aperanton.GephyrosisRoadK31Eq

/-!
# ΤΥΡΒΗ — Τ1 in three dimensions: the period-two shape, and the page's even-step stake refuted

The page staked, at (3D, K = 1, p = 3): odd steps with the eight body-diagonal coordinates at the top and the
other 44 one below; even steps with all 52 at the top. The automaton's own profile (read 05:30 on the compiled
interpreter, decided here by the kernel) REFUTES the even-step half and sharpens the law: the body diagonals carry
sixteen coordinates, two polarisations times two trigonometric types, and only the SECOND polarisation is
ramified at 3 — its divisor `2|k × pol₁|² = 12` — while the first polarisation's divisor is `2|pol₁|² = 4`. The grade
in three dimensions is the polarisation's divisor, `v₃(D_k)`, not the wavevector's. Three classes result:
`A` (grade 1, eight coordinates), `B` (grade 0 on the diagonals, eight), `C` (grade 0 off them, thirty-six); at
odd steps `A` is at the top `J_s` and `B`, `C` one below; at even steps `A` and `C` are at the top and `B` one
below — the top is 8 wide at odd steps and 44 at even, as Addendum IV measured without naming the eight.
-/

namespace Gephyrosis

/-- the predicted 3D shape at top `T`: the ramified class at `T`, the diagonal's unramified polarisation at
`T − 1`, the rest at `T − lag` (`lag = 1` at odd steps, `0` at even) -/
def shape3 (T lag : ℤ) : List ℤ :=
  (basis3D 1).map fun b =>
    if vpI 3 (divisor3 b) = 1 then T else if b.k.normSq = 3 then T - 1 else T - lag

theorem shape3_shift (T lag c : ℤ) : (shape3 T lag).map (· + c) = shape3 (T + c) lag := by
  unfold shape3
  rw [List.map_map]
  apply List.map_congr_left
  intro b _
  simp only [Function.comp]
  split_ifs <;> ring

/-- the three classes: 8 ramified, 8 unramified diagonal, 36 off-diagonal -/
theorem class_counts_3D :
    ((basis3D 1).filter fun b => vpI 3 (divisor3 b) = 1).length = 8 ∧
    ((basis3D 1).filter fun b => vpI 3 (divisor3 b) ≠ 1 ∧ b.k.normSq = 3).length = 8 ∧
    ((basis3D 1).filter fun b => vpI 3 (divisor3 b) ≠ 1 ∧ b.k.normSq ≠ 3).length = 36 := by
  decide +kernel

theorem shape31_1 : (autoOrbit R31lit 3 zero52 1).1 = shape3 1 1 := by decide +kernel
theorem shape31_2 : (autoOrbit R31lit 3 zero52 2).1 = shape3 1 0 := by decide +kernel
theorem shape31_3 : (autoOrbit R31lit 3 zero52 3).1 = shape3 3 1 := by decide +kernel
theorem shape31_4 : (autoOrbit R31lit 3 zero52 4).1 = shape3 5 0 := by decide +kernel

/-- the profile closes at (2, 2) with shift 4 on the literal road (the same closure `certP3` read on `R31s`) -/
theorem close31lit :
    wfCheck R31lit = true ∧
    (autoOrbit R31lit 3 zero52 4).1 = (autoOrbit R31lit 3 zero52 2).1.map (· + 4) ∧
    naCheck R31lit 3 (autoOrbit R31lit 3 zero52 2).1 = true ∧
    naCheck R31lit 3 (autoOrbit R31lit 3 zero52 3).1 = true := by
  refine ⟨?_, ?_, ?_, ?_⟩ <;> decide +kernel

/-- **Τ1 in three dimensions, every step `s ≥ 2`, every integer seed**: the profile is `shape3 J_s (s mod 2)`. -/
theorem tau1_3D_three (c0 : List ℤ) (s : ℕ) (hs : 2 ≤ s) :
    (autoOrbit R31lit 3 c0 s).1 = shape3 (jacobsthal s : ℤ) ((s % 2 : ℕ) : ℤ) := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  obtain ⟨hwf, hcl, hna2, hna3⟩ := close31lit
  have hNA : ∀ i < 2, NonAttain R31lit 3 (autoOrbit R31lit 3 zero52 (2 + i)).1 := by
    intro i hi
    interval_cases i
    · exact nonAttain_of_check _ _ _ hna2
    · exact nonAttain_of_check _ _ _ hna3
  have key : ∀ i, (autoOrbit R31lit 3 zero52 (2 + i)).1
      = shape3 (jacobsthal (2 + i) : ℤ) (((2 + i) % 2 : ℕ) : ℤ) := by
    intro i
    induction i using Nat.strong_induction_on with
    | _ i ih =>
      rcases i with _ | _ | i
      · exact shape31_2
      · exact shape31_3
      · have h := (closure_profile R31lit zero52 (wellformed_of_check _ hwf) 2 2 (by norm_num) 4
          (by norm_num) hcl hNA i).1
        rw [show 2 + 2 + i = 2 + (i + 2) by omega] at h
        rw [h, ih i (by omega), shape3_shift]
        have hj : (jacobsthal (2 + (i + 2)) : ℤ) = jacobsthal (2 + i) + 4 * 2 ^ i := by
          rw [show 2 + (i + 2) = (2 + i) + 2 by omega, jacobsthal_add_two]
          push_cast
          ring
        rw [hj, show (2 + (i + 2)) % 2 = (2 + i) % 2 by omega]
  rw [profile_indep R31lit c0 zero52 s]
  have := key (s - 2)
  rwa [show 2 + (s - 2) = s by omega] at this

/-- the even-step stake of the page, REFUTED: the eight unramified diagonal coordinates sit one below the top at
step 2 (and at every even step by `tau1_3D_three`), so the top is 44 wide, not 52. -/
theorem even_stake_refuted :
    ∃ k < 52, (autoOrbit R31lit 3 zero52 2).1.getD k 0 ≠ maxL (autoOrbit R31lit 3 zero52 2).1 := by
  decide +kernel

end Gephyrosis
