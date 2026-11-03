/-
  APERANTON -- THE BOUNDLESS, stage W6 (ADDENDUM I, THE ROAD): THE FOUR-TORUS OF SIDE THREE -- THE INSTANCE.

  The parametric bridge (TorusLBridge.lean) lands the sector split at a side from its certificate's finranks; the
  side-3 certificate (TorusLCert3.lean, emitted and decided: 324 link coboundaries, 324 cube faces, the six sheets of
  nine plaquettes, 486-bit masks, ranks 240 / 240 / 246) supplies them through Echelon.lean's `finrank_gens_eq`, so
  `torusL3Split : TorusLSplit 3` -- Wegner's self-duality read on T⁴₃ by `duality` -- is a theorem with no further
  decide: 240 + 240 + 6 = 486 is the chain complex of T⁴ over F₂ at side three.  The dual factor system's three
  decided facts at this side follow (every plaquette on four cubes, every cube with six faces, every cube's column its
  face mask: 486 · 324 evaluations each), so TorusSysL.lean's row sum 18·c₁ and the identification of δ*'s range with
  D hold at side three.  No sorry, no axiom, no native_decide.
-/
import Mathlib
import Aperanton.TorusL
import Aperanton.TorusLBridge
import Aperanton.TorusLCert3
import Aperanton.TorusSysL
import Aperanton.TorusLevels
import Aperanton.TorusDecay

open Finset

namespace Aperanton

namespace TorusL

open TorusLCert3

theorem piv_lt_Cobd3 : ∀ p ∈ pivCobd, p < nPlaq 3 := Cobd_piv_lt
theorem piv_lt_Bd3_3 : ∀ p ∈ pivBd3, p < nPlaq 3 := Bd3_piv_lt
theorem piv_lt_Bd3S_3 : ∀ p ∈ pivBd3S, p < nPlaq 3 := Bd3S_piv_lt

/-- finrank K = 240 at side three, from the certificate -/
theorem finrank_K3 : Module.finrank (ZMod 2) (K 3) = 240 := by
  rw [K_eq, finrank_gens_eq (nPlaq 3) (cobdMasks 3) basisCobd pivCobd selGCobd selBCobd Cobd_cert piv_lt_Cobd3
    Cobd_selG Cobd_selB]
  exact Cobd_rank

/-- finrank D = 240 at side three -/
theorem finrank_D3 : Module.finrank (ZMod 2) (D 3) = 240 := by
  rw [D_eq, finrank_gens_eq (nPlaq 3) (cubeMasks 3) basisBd3 pivBd3 selGBd3 selBBd3 Bd3_cert piv_lt_Bd3_3
    Bd3_selG Bd3_selB]
  exact Bd3_rank

/-- finrank (D ⊔ S) = 246 at side three -/
theorem finrank_DS3 : Module.finrank (ZMod 2) ↥(D 3 ⊔ S 3) = 246 := by
  rw [D_eq, S_eq, ← Submodule.span_union, ← basisSet_append,
    finrank_gens_eq (nPlaq 3) (cubeMasks 3 ++ sheetMasks 3) basisBd3S pivBd3S selGBd3S selBBd3S Bd3S_cert
      piv_lt_Bd3S_3 Bd3S_selG Bd3S_selB]
  exact Bd3S_rank

/-- THE SECTOR SPLIT OF THE FOUR-TORUS OF SIDE THREE -/
theorem torusL3Split : TorusLSplit 3 :=
  torusLSplit 3 240 240 dd_zero sheets_cycle finrank_K3 finrank_D3 finrank_DS3 (by decide)

/-! ## The dual factor system's decided facts at side three -/

/-- every plaquette is a face of exactly four cubes -/
theorem deg_four3 : ∀ i : Fin (nPlaq 3),
    (univ.filter (fun k : Fin (nCubes 3) => ((cubeMult 3 i k : ℕ) : ZMod 2) = 1)).card = 4 :=
  deg_four

/-- every cube carries exactly six faces -/
theorem faces_six3 : ∀ s : Fin (nCubes 3),
    (univ.filter (fun i : Fin (nPlaq 3) => ((cubeMult 3 i s : ℕ) : ZMod 2) = 1)).card = 6 :=
  faces_six

/-- every cube's column is its face mask -/
theorem col3 : ∀ (k : Fin (nCubes 3)) (i : Fin (nPlaq 3)),
    ((cubeMult 3 i k : ℕ) : ZMod 2) = vecOf 3 (cubeMask 3 k.val) i :=
  col

/-- THE ROW SUM AT SIDE THREE: Dobrushin's row of the dual system is at most 18·c₁(y) -/
theorem rowsum_le3 (h : Fin (nPlaq 3) → ZMod 2) (y : ℝ) (hy0 : 0 < y) (hy1 : y ≤ 1) (s : Fin (nCubes 3)) :
    ∑ t, (torusSys 3 h y hy0 hy1).C s t ≤ 18 * ((1 - y) / (1 + y)) :=
  rowsum_le_of 3 h y hy0 hy1 s deg_four3 (faces_six3 s)

/-- THE RANGE OF δ* IS D AT SIDE THREE -/
theorem range_cobdDual_eq_D3 : LinearMap.range (cobdDual 3) = D 3 := range_cobdDual_eq_D 3 col3

/-- the adjacency fact at side three along each of the four walls x_μ = 0: every face of every cube lies on cubes at
most one level up (4 · 324 · 6 · 324 membership tests) -/
theorem adj3 : ∀ mu : Fin 4, AdjList 3 mu.val := adj

/-- THE DUAL SYSTEM AT SIDE THREE HAS RANGE ONE ALONG EVERY WALL LEVEL -/
theorem rangeOne3 (mu : Fin 4) (h : Fin (nPlaq 3) → ZMod 2) (y : ℝ) (hy0 : 0 < y) (hy1 : y ≤ 1) :
    RangeOne (torusSys 3 h y hy0 hy1).C (levelAt 3 mu.val) :=
  rangeOne_of 3 mu.val (adj3 mu) h y hy0 hy1

/-- THE SECTOR DECAY AT SIDE THREE: every dual sector's correlations along any wall level decay as (18 c₁(y))^R
for y > 17/19 (at side three a wall level is at most one, so the instance carries the structure, not a number) -/
theorem sector_cov_le3 (mu : Fin 4) (h : Fin (nPlaq 3) → ZMod 2) (y : ℝ) (hy0 : 0 < y) (hy1 : y ≤ 1)
    (hy : (17 : ℝ) / 19 < y)
    (f : (Fin (nCubes 3) → Z2) → ℝ) (d : Fin (nCubes 3) → ℝ) (hf : OscBound f d) (a R : ℕ)
    (hd : ∀ t, a < levelAt 3 mu.val t → d t = 0)
    (g : (Fin (nCubes 3) → Z2) → ℝ) (hg : ∀ ω, 0 < g ω) (reads : Fin (nCubes 3) → Prop) [DecidablePred reads]
    (hfree : ∀ s, ¬ reads s → ∀ ω x, g (Function.update ω s x) = g ω)
    (hreads : ∀ t, levelAt 3 mu.val t < a + R → ¬ reads t) :
    |gibbs (torusSys 3 h y hy0 hy1).W (fun ω => f ω * g ω) -
        gibbs (torusSys 3 h y hy0 hy1).W f * gibbs (torusSys 3 h y hy0 hy1).W g| ≤
      gibbs (torusSys 3 h y hy0 hy1).W g *
        ((∑ t, if reads t then (1 : ℝ) else 0) * (∑ t, d t) * alpha y ^ R / (1 - alpha y)) :=
  sector_cov_le 3 mu.val (adj3 mu) deg_four3 faces_six3 h y hy0 hy1 hy f d hf a R hd g hg reads hfree hreads

end TorusL

end Aperanton
