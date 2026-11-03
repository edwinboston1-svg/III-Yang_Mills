/-
  APERANTON -- THE BOUNDLESS, stage W6 (ADDENDUM I, THE ROAD): THE WEAK-COUPLING CLAUSE'S ENGINE AT ANY SIDE --
  EVERY DUAL SECTOR'S CORRELATIONS DECAY ALONG THE WALL LEVEL AS (18 c₁(y))^R.

  The dual sector h of the Z₂ theory on T⁴_L at the dual coupling y is the Gibbs measure `torusSys L h y`
  (TorusSysL.lean); its interdependence has row sums at most α = 18·c₁(y) (`rowsum_le_of`, the double count) and
  range one along the wall level (`rangeOne_of`, TorusLevels.lean).  Dobrushin's covariance bound `cov_le`
  (Dobrushin.lean) then reads, in every sector and at every side: an observable f whose oscillation mass sits at
  levels ≤ a and a positive observable g read at levels ≥ a + R have
      |⟨f g⟩ − ⟨f⟩⟨g⟩| ≤ ⟨g⟩ · (#reads)(Σ d) α^R/(1 − α),
  with α < 1 iff y > 17/19 (`alpha_lt_one_iff`).  In the original coupling, y = (1 − y*)/(1 + y*) < 1/18: the
  weak-coupling clause of the three-clause theorem holds for β > ½ ln 18 = 1.445 at every side, against the
  self-dual β_c = 0.4407 -- the clause's engine, the mixture over the 64 twists and the between-sector term being
  the assembly (T3).  The constants are the sector's own: no dependence on L enters α, so the decay is uniform in
  the side.  W = 0 (Dobrushin 1968 on a gauge theory's dual); the earning is the exact coefficient on the torus.
  No sorry, no axiom, no native_decide.
-/
import Mathlib
import Aperanton.Dobrushin
import Aperanton.Z2Slab
import Aperanton.TorusL
import Aperanton.TorusSysL
import Aperanton.TorusLevels

open Finset

namespace Aperanton

namespace TorusL

/-- the sector's Dobrushin coefficient: 18 c₁(y) = 18 (1 − y)/(1 + y) -/
noncomputable def alpha (y : ℝ) : ℝ := 18 * ((1 - y) / (1 + y))

theorem alpha_nonneg (y : ℝ) (hy0 : 0 < y) (hy1 : y ≤ 1) : 0 ≤ alpha y := by
  unfold alpha
  have : 0 ≤ (1 - y) / (1 + y) := div_nonneg (by linarith) (by linarith)
  linarith

/-- 18 c₁(y) < 1 iff y > 17/19 -/
theorem alpha_lt_one_iff (y : ℝ) (hy0 : 0 < y) : alpha y < 1 ↔ (17 : ℝ) / 19 < y := by
  unfold alpha
  have h1 : (0 : ℝ) < 1 + y := by linarith
  rw [← mul_div_assoc, div_lt_one h1]
  constructor <;> intro h <;> linarith

/-- THE SECTOR DECAY AT ANY SIDE: in the dual sector h, an observable f with oscillation mass d at levels ≤ a and a
positive observable g read at levels ≥ a + R have covariance at most ⟨g⟩ · (#reads)(Σ d) α^R/(1 − α), α = 18 c₁(y),
for y > 17/19 -/
theorem sector_cov_le (L mu : ℕ) (hadj : AdjList L mu)
    (hdeg : ∀ i : Fin (nPlaq L),
      (univ.filter (fun k : Fin (nCubes L) => ((cubeMult L i k : ℕ) : ZMod 2) = 1)).card = 4)
    (hsix : ∀ s : Fin (nCubes L),
      (univ.filter (fun i : Fin (nPlaq L) => ((cubeMult L i s : ℕ) : ZMod 2) = 1)).card = 6)
    (h : Fin (nPlaq L) → ZMod 2) (y : ℝ) (hy0 : 0 < y) (hy1 : y ≤ 1) (hy : (17 : ℝ) / 19 < y)
    (f : (Fin (nCubes L) → Z2) → ℝ) (d : Fin (nCubes L) → ℝ) (hf : OscBound f d) (a R : ℕ)
    (hd : ∀ t, a < levelAt L mu t → d t = 0)
    (g : (Fin (nCubes L) → Z2) → ℝ) (hg : ∀ ω, 0 < g ω) (reads : Fin (nCubes L) → Prop) [DecidablePred reads]
    (hfree : ∀ s, ¬ reads s → ∀ ω x, g (Function.update ω s x) = g ω)
    (hreads : ∀ t, levelAt L mu t < a + R → ¬ reads t) :
    |gibbs (torusSys L h y hy0 hy1).W (fun ω => f ω * g ω) -
        gibbs (torusSys L h y hy0 hy1).W f * gibbs (torusSys L h y hy0 hy1).W g| ≤
      gibbs (torusSys L h y hy0 hy1).W g *
        ((∑ t, if reads t then (1 : ℝ) else 0) * (∑ t, d t) * alpha y ^ R / (1 - alpha y)) := by
  have hα1 : alpha y < 1 := (alpha_lt_one_iff y hy0).mpr hy
  exact cov_le (torusSys L h y hy0 hy1).W (torusSys L h y hy0 hy1).W_pos (torusSys L h y hy0 hy1).C
    (torusSys L h y hy0 hy1).C_nonneg (torusSys L h y hy0 hy1).interdep (alpha y) (alpha_nonneg y hy0 hy1) hα1
    (fun s => rowsum_le_of L h y hy0 hy1 s hdeg (hsix s)) (levelAt L mu) (rangeOne_of L mu hadj h y hy0 hy1)
    f d hf a R hd g hg reads hfree hreads

end TorusL

end Aperanton
