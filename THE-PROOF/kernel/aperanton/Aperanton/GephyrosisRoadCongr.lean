import Aperanton.GephyrosisBounds

/-!
# ΓΕΦΥΡΩΣΙΣ — a road is used only through its length, its linear and divisor coefficients at each
coordinate, and its term list at each coordinate

The exact step `stepI` and the automaton `autoStep` read a road `R` only at `R.n`, `R.κ k`, `R.D k` and
`R.tb.getD k []` for `k < R.n`. Two roads that agree there have the same exact orbits and the same
automaton orbits. This is what lets a road be handed to the kernel as a LITERAL — its tensor written out
and verified coordinate by coordinate — instead of being recomputed from the wavevectors inside every
declaration: the kernel's memory for the 80-coordinate box `K = 4` was the tensor, not the walk.
-/

namespace Gephyrosis

/-- two roads agree below their common length -/
structure RoadAgree (R R' : Road) : Prop where
  n : R.n = R'.n
  κ : ∀ k < R.n, R.κ k = R'.κ k
  D : ∀ k < R.n, R.D k = R'.D k
  tb : ∀ k < R.n, R.tb.getD k [] = R'.tb.getD k []

theorem stepI_congr (R R' : Road) (h : RoadAgree R R') (x : List ℚ) : stepI R x = stepI R' x := by
  unfold stepI
  rw [← h.n]
  apply List.map_congr_left
  intro k hk
  have hk' := List.mem_range.1 hk
  rw [h.κ k hk', h.D k hk', h.tb k hk']

theorem ratOrbit_congr (R R' : Road) (h : RoadAgree R R') (c0 : List ℤ) (s : ℕ) :
    ratOrbit R c0 s = ratOrbit R' c0 s := by
  induction s with
  | zero =>
    show (List.range R.n).map _ = (List.range R'.n).map _
    rw [h.n]
  | succ s ih =>
    show stepI R (ratOrbit R c0 s) = stepI R' (ratOrbit R' c0 s)
    rw [ih, stepI_congr R R' h]

section Auto

variable {p : ℕ} [hp : Fact p.Prime]

theorem tNext_congr (R R' : Road) (h : RoadAgree R R') (t : List ℤ) (k : ℕ) (hk : k < R.n) :
    tNext R p t k = tNext R' p t k := by
  unfold tNext qmax lamOf
  rw [h.κ k hk, h.D k hk, h.tb k hk]

theorem rNext_congr (R R' : Road) (h : RoadAgree R R') (t : List ℤ) (r : List ℕ) (k : ℕ)
    (hk : k < R.n) : rNext R p t r k = rNext R' p t r k := by
  unfold rNext linRes quadRes
  rw [tNext_congr (p := p) R R' h t k hk]
  unfold lamOf
  rw [h.κ k hk, h.D k hk, h.tb k hk]

theorem autoStep_congr (R R' : Road) (h : RoadAgree R R') (st : List ℤ × List ℕ) :
    autoStep R p st = autoStep R' p st := by
  unfold autoStep
  rw [← h.n]
  congr 1
  · apply List.map_congr_left
    intro k hk
    exact tNext_congr R R' h st.1 k (List.mem_range.1 hk)
  · apply List.map_congr_left
    intro k hk
    exact rNext_congr R R' h st.1 st.2 k (List.mem_range.1 hk)

theorem autoInit_congr (R R' : Road) (h : RoadAgree R R') (c0 : List ℤ) :
    autoInit R p c0 = autoInit R' p c0 := by
  unfold autoInit
  rw [h.n]

theorem autoOrbit_congr (R R' : Road) (h : RoadAgree R R') (c0 : List ℤ) (s : ℕ) :
    autoOrbit R p c0 s = autoOrbit R' p c0 s := by
  induction s with
  | zero => exact autoInit_congr R R' h c0
  | succ s ih =>
    show autoStep R p (autoOrbit R p c0 s) = autoStep R' p (autoOrbit R' p c0 s)
    rw [ih, autoStep_congr R R' h]

end Auto

end Gephyrosis
