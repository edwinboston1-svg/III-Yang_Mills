/-
  APERANTON -- THE BOUNDLESS, stage W7′ (ADDENDUM I, THE ROAD): THE TWIST TRANSLATIONS -- THE GENERIC LAYER.

  A twist class is represented by a sheet; the (μν)-sheet at the complementary coordinates (c₁, c₂) (`sheetAtMask`:
  the (μν)-plaquettes with x_ρ = c₁, x_σ = c₂, ρ < σ the two directions outside the pair -- Torus4's `dualPair` names
  the complementary pair, its `pairMu`/`pairNu` the two directions) is another representative of the same class
  iff its sum with the sheet at (0, 0) lies in the boundary code D.  The side's emitted certificate
  (TorusLTrans<L>.lean, from aperanton_emit_torusL_trans.sh) decides that each such sum is a selection of the
  certificate's echelon basis of the cube faces, and that it IS the xor of the two sheets as defined here; the xor
  of two masks is the sum of their vectors (`vecOfN_xor`), so each sum's vector lies in D (`mem_D_of_sel`).  With
  that, the between-sector deviation (TorusT3.lean, `sector_dev_le`) is read at a representative far from the wall.
  W = 0 (a 2-chain's boundary); the earning is the certificate's form.  No sorry, no axiom, no native_decide.
-/
import Mathlib
import Aperanton.Echelon
import Aperanton.TorusL
import Aperanton.TorusLBridge

open Finset

namespace Aperanton

/-- the xor of two masks is the sum of their vectors over F₂ -/
theorem vecOfN_xor (N a b : ℕ) : vecOfN N (Nat.xor a b) = vecOfN N a + vecOfN N b := by
  funext i
  simp only [vecOfN, Pi.add_apply]
  have hx : Nat.xor a b = a ^^^ b := rfl
  rw [hx, Nat.testBit_xor]
  cases Nat.testBit a i.val <;> cases Nat.testBit b i.val <;> decide

namespace TorusL

/-- the (μν)-sheet at the complementary coordinates (c₁ at the smaller direction outside the pair, c₂ at the larger) -/
def sheetAtMask (L q c₁ c₂ : ℕ) : ℕ :=
  Torus4.maskOf (((List.range (V L)).filter (fun s =>
    coord L s (Torus4.pairMu (5 - q)) = c₁ && coord L s (Torus4.pairNu (5 - q)) = c₂)).map
      (fun s => plaq L q s))

/-- a mask that is a selection of the certificate's basis of the cube faces lies in D -/
theorem mem_D_of_sel (L : ℕ) (basis piv selG selB : List ℕ) (hc : EchelonCert basis piv)
    (hpiv : ∀ p ∈ piv, p < nPlaq L)
    (hselG : ∀ (i : Fin (cubeMasks L).length), (cubeMasks L).get i = xorSel (selG.getD i.val 0) basis)
    (hselB : ∀ (i : Fin basis.length), basis.get i = xorSel (selB.getD i.val 0) (cubeMasks L))
    (m sel : ℕ) (hm : m = xorSel sel basis) : vecOf L m ∈ D L := by
  rw [D_eq, span_eq_of_certs (nPlaq L) (cubeMasks L) basis selG selB hselG hselB, vecOf_eq, hm, vecOfN_xorSel]
  exact vecSel_mem_span (nPlaq L) basis sel

end TorusL

end Aperanton
