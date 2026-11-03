/-
  APERANTON -- THE BOUNDLESS, stage W7′ (ADDENDUM I, THE ROAD): THE TWIST TRANSLATIONS AT SIDE THREE -- EVERY SHEET'S
  TRANSLATE IS ANOTHER REPRESENTATIVE OF ITS TWIST.

  The side-3 translation certificate (TorusLTrans3.lean, emitted and decided) says each of the 54 sums "sheet at
  (c₁, c₂) plus sheet at (0, 0)" is a selection of the side-3 echelon basis of the cube faces and is the xor of the
  two sheets as TorusLTrans.lean defines them; here the selection is read as membership in the boundary code D 3
  (`trans_mem_D3`, through Echelon.lean and the certificate's two-way selections) and the sum as the sum of the two
  sheets' vectors (`sheet_translate_mem_D3`), so a twist's sector may be read at any translate of its sheet
  (`sectorExp_add_mem`, TorusT3.lean) -- the geometric fact the between-sector deviation needs, at side three.
  No sorry, no axiom, no native_decide.
-/
import Mathlib
import Aperanton.TorusL
import Aperanton.TorusLBridge
import Aperanton.TorusLCert3
import Aperanton.TorusL3
import Aperanton.TorusLTrans
import Aperanton.TorusLTrans3

open Finset

namespace Aperanton

namespace TorusL

/-- every translation sum lies in D 3 -/
theorem trans_mem_D3 (j : Fin TorusLTrans3.transMasks.length) : vecOf 3 (TorusLTrans3.transMasks.get j) ∈ D 3 :=
  mem_D_of_sel 3 TorusLCert3.basisBd3 TorusLCert3.pivBd3 TorusLCert3.selGBd3 TorusLCert3.selBBd3
    TorusLCert3.Bd3_cert piv_lt_Bd3_3 TorusLCert3.Bd3_selG TorusLCert3.Bd3_selB _ _ (TorusLTrans3.trans_sel j)

/-- THE TRANSLATE IS A REPRESENTATIVE: the (μν)-sheet at the complementary coordinates (c₁, c₂) plus the sheet at
(0, 0) is a boundary, at side three -/
theorem sheet_translate_mem_D3 (q c₁ c₂ : ℕ) (hq : q < 6) (h1 : c₁ < 3) (h2 : c₂ < 3) :
    vecOf 3 (sheetAtMask 3 q c₁ c₂) + vecOf 3 (sheetAtMask 3 q 0 0) ∈ D 3 := by
  have hj : q * 9 + c₁ * 3 + c₂ < TorusLTrans3.transMasks.length := by
    rw [TorusLTrans3.trans_len]
    omega
  have h := trans_mem_D3 ⟨q * 9 + c₁ * 3 + c₂, hj⟩
  rw [TorusLTrans3.trans_eq] at h
  simp only at h
  have e1 : (q * 9 + c₁ * 3 + c₂) / 9 = q := by omega
  have e2 : (q * 9 + c₁ * 3 + c₂) % 9 / 3 = c₁ := by omega
  have e3 : (q * 9 + c₁ * 3 + c₂) % 3 = c₂ := by omega
  rw [e1, e2, e3, vecOf_eq, vecOfN_xor, ← vecOf_eq, ← vecOf_eq] at h
  exact h

end TorusL

end Aperanton
