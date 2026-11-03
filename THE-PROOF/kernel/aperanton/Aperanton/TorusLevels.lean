/-
  APERANTON -- THE BOUNDLESS, stage W6 (ADDENDUM I, THE ROAD): THE LEVELS OF THE FOUR-TORUS -- DISTANCE FROM A WALL,
  AND THE DUAL FACTOR SYSTEM'S RANGE ONE ALONG IT.

  Dobrushin's comparison theorem reads decay along a LEVEL φ : sites → ℕ with the interdependence of range one
  (`RangeOne`: C s t = 0 whenever φ s + 1 < φ t).  On the slab the level was the time coordinate; on the torus of
  side L the level of a cube is its site's distance from the wall x_μ = 0 ON THE CIRCLE, min(x_μ, L − x_μ)
  (`levelAt`), which a step in any direction moves by at most one, the wrap included.  Two cubes with a nonzero
  interdependence share a face, and the cubes sharing a face sit at sites one step apart, so their levels differ by
  at most one: THE ADJACENCY FACT, in a list form each side's instance decides (every face of every cube against
  every cube: 4V·6·4V membership tests), carried here as the hypothesis `hadj` of `rangeOne_of`.  With it, every
  dual sector at side L is a Gibbs measure whose correlations between the wall and the cubes R levels away decay as
  α^R, α = 18·c₁(y) (`cov_le`, Dobrushin.lean), uniformly in L -- the weak-coupling clause's engine.  W = 0;
  the earning is the level that survives the wrap.  No sorry, no axiom, no native_decide.
-/
import Mathlib
import Aperanton.TorusL
import Aperanton.TorusSysL

open Finset

namespace Aperanton

namespace TorusL

/-- the level of a cube index: its site's distance from the wall x_μ = 0 on the circle of length L -/
def levelN (L mu k : ℕ) : ℕ := min (coord L (k % V L) mu) (L - coord L (k % V L) mu)

def levelAt (L mu : ℕ) (k : Fin (nCubes L)) : ℕ := levelN L mu k.val

/-- THE ADJACENCY FACT in list form: every face of every cube lies on cubes whose level is at most one more (an
`abbrev`, so a side's instance decides it as the Bool equation it is) -/
abbrev AdjList (L mu : ℕ) : Prop :=
  ((List.range (nCubes L)).all (fun k => (cubeFaces L (k / V L) (k % V L)).all (fun i =>
    (List.range (nCubes L)).all (fun k' =>
      !(decide (i ∈ cubeFaces L (k' / V L) (k' % V L))) || decide (levelN L mu k' ≤ levelN L mu k + 1))))) = true

/-- a nonzero incidence is a membership -/
theorem cubeMult_ne_zero_iff (L : ℕ) (i : Fin (nPlaq L)) (k : Fin (nCubes L)) :
    cubeMult L i k ≠ 0 ↔ i.val ∈ cubeFaces L (k.val / V L) (k.val % V L) := by
  unfold cubeMult
  rw [Ne, List.count_eq_zero, not_not]

/-- the adjacency fact read at two cubes sharing a face -/
theorem level_le_of_shared (L mu : ℕ) (hadj : AdjList L mu) (i : Fin (nPlaq L)) (k k' : Fin (nCubes L))
    (hk : cubeMult L i k ≠ 0) (hk' : cubeMult L i k' ≠ 0) : levelAt L mu k' ≤ levelAt L mu k + 1 := by
  unfold AdjList at hadj
  rw [List.all_eq_true] at hadj
  have h1 := hadj k.val (List.mem_range.mpr k.isLt)
  rw [List.all_eq_true] at h1
  have h2 := h1 i.val ((cubeMult_ne_zero_iff L i k).mp hk)
  rw [List.all_eq_true] at h2
  have h3 := h2 k'.val (List.mem_range.mpr k'.isLt)
  have hmem : i.val ∈ cubeFaces L (k'.val / V L) (k'.val % V L) := (cubeMult_ne_zero_iff L i k').mp hk'
  simp [hmem] at h3
  exact h3

/-- an incidence read as one in F₂ is nonzero -/
theorem cubeMult_ne_zero_of_one (L : ℕ) (i : Fin (nPlaq L)) (k : Fin (nCubes L))
    (h : ((cubeMult L i k : ℕ) : ZMod 2) = 1) : cubeMult L i k ≠ 0 := by
  intro h0
  rw [h0] at h
  exact absurd h (by decide)

/-- THE DUAL FACTOR SYSTEM HAS RANGE ONE ALONG THE WALL LEVEL -/
theorem rangeOne_of (L mu : ℕ) (hadj : AdjList L mu) (h : Fin (nPlaq L) → ZMod 2) (y : ℝ) (hy0 : 0 < y)
    (hy1 : y ≤ 1) : RangeOne (torusSys L h y hy0 hy1).C (levelAt L mu) := by
  intro s t hst
  unfold Z2Sys.C
  have hne : s ≠ t := by
    intro e
    rw [e] at hst
    omega
  rw [if_neg hne]
  have hshared : (torusSys L h y hy0 hy1).shared s t = 0 := by
    unfold Z2Sys.shared
    rw [Finset.card_eq_zero, Finset.filter_eq_empty_iff]
    intro i _ hp
    have hs : cubeMult L i s ≠ 0 := cubeMult_ne_zero_of_one L i s hp.1
    have ht : cubeMult L i t ≠ 0 := cubeMult_ne_zero_of_one L i t hp.2
    have := level_le_of_shared L mu hadj i s t hs ht
    omega
  rw [hshared]
  simp

end TorusL

end Aperanton
