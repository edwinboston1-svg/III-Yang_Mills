/-
  APERANTON -- THE BOUNDLESS, stage W6 (ADDENDUM I, THE ROAD): THE SECTOR SPLIT OF THE FOUR-TORUS OF ANY SIDE FROM A
  CERTIFICATE'S NUMBERS.

  Torus4Bridge.lean discharged the side-2 split from the side-2 certificate's ranks 45, 45, 51.  Here the argument is
  stated once for every side: given the two decided incidence facts (∂₂∂₃ = 0, the sheets are cycles) and three
  finranks -- rK of the plaquette code K, rD of the boundary code D, rD + 6 of D with the six sheets -- with
  rK + rD + 6 = 6V (the chain complex of T⁴ over F₂: dim Z₂ = 6V − rK, dim B₂ = dim Z₂ − 6), the dual dimension
  (`finrank_orth_K`: the dot product nondegenerate, so finrank K + finrank K^⊥ = 6V), the sheets' independence of
  the boundaries (`finrank_S`, `D_inf_S`, from the rank jump rD → rD + 6 and finrank S ≤ 6), the 64 twists distinct
  (`sheet_sum_injective`, `card_H`) and ONE cardinality identity 2^(6V − rK) = 64 · 2^rD land `torusLSplit`.  A
  side's instance (TorusL<L>.lean) supplies the finranks through Echelon.lean's `finrank_gens_eq` from its emitted
  certificate; the 2^(6V − rK)-member sets are never enumerated.  No sorry, no axiom, no native_decide.
-/
import Mathlib
import Aperanton.Duality
import Aperanton.Echelon
import Aperanton.MacWilliams
import Aperanton.TorusL

open Finset Matrix

namespace Aperanton

namespace TorusL

/-! ## The generator lists and the codes -/

theorem vecOf_eq (L m : ℕ) : vecOf L m = vecOfN (nPlaq L) m := rfl

theorem cobdMasks_length (L : ℕ) : (cobdMasks L).length = nLinks L := by simp [cobdMasks]

theorem cubeMasks_length (L : ℕ) : (cubeMasks L).length = nCubes L := by simp [cubeMasks]

theorem sheetMasks_length (L : ℕ) : (sheetMasks L).length = 6 := by simp [sheetMasks]

theorem cobdMasks_getElem (L i : ℕ) (h : i < (cobdMasks L).length) : (cobdMasks L)[i] = cobdMask L i := by
  simp [cobdMasks]

theorem cubeMasks_getElem (L i : ℕ) (h : i < (cubeMasks L).length) : (cubeMasks L)[i] = cubeMask L i := by
  simp [cubeMasks]

theorem sheetMasks_getElem (L i : ℕ) (h : i < (sheetMasks L).length) : (sheetMasks L)[i] = sheetMask L i := by
  simp [sheetMasks]

/-- the plaquette code is the span of the coboundary list's vectors -/
theorem K_eq (L : ℕ) : K L = Submodule.span (ZMod 2) (basisSet (nPlaq L) (cobdMasks L)) := by
  unfold K basisSet
  congr 1
  ext v
  constructor
  · rintro ⟨l, rfl⟩
    refine ⟨⟨l.val, by rw [cobdMasks_length]; exact l.isLt⟩, ?_⟩
    simp only [List.get_eq_getElem, cobdMasks_getElem, vecOf_eq]
  · rintro ⟨i, rfl⟩
    refine ⟨⟨i.val, lt_of_lt_of_eq i.isLt (cobdMasks_length L)⟩, ?_⟩
    simp only [List.get_eq_getElem, cobdMasks_getElem, vecOf_eq]

/-- the boundary code is the span of the cube list's vectors -/
theorem D_eq (L : ℕ) : D L = Submodule.span (ZMod 2) (basisSet (nPlaq L) (cubeMasks L)) := by
  unfold D basisSet
  congr 1
  ext v
  constructor
  · rintro ⟨k, rfl⟩
    refine ⟨⟨k.val, by rw [cubeMasks_length]; exact k.isLt⟩, ?_⟩
    simp only [List.get_eq_getElem, cubeMasks_getElem, vecOf_eq]
  · rintro ⟨i, rfl⟩
    refine ⟨⟨i.val, lt_of_lt_of_eq i.isLt (cubeMasks_length L)⟩, ?_⟩
    simp only [List.get_eq_getElem, cubeMasks_getElem, vecOf_eq]

/-- the span of the sheets is the span of the sheet list's vectors -/
theorem S_eq (L : ℕ) : S L = Submodule.span (ZMod 2) (basisSet (nPlaq L) (sheetMasks L)) := by
  unfold S basisSet
  congr 1
  ext v
  constructor
  · rintro ⟨q, rfl⟩
    refine ⟨⟨q.val, by rw [sheetMasks_length]; exact q.isLt⟩, ?_⟩
    simp only [List.get_eq_getElem, sheetMasks_getElem, vecOf_eq]
  · rintro ⟨i, rfl⟩
    refine ⟨⟨i.val, lt_of_lt_of_eq i.isLt (sheetMasks_length L)⟩, ?_⟩
    simp only [List.get_eq_getElem, sheetMasks_getElem, vecOf_eq]

/-- the generator set of a concatenation is the union -/
theorem basisSet_append (N : ℕ) (a b : List ℕ) : basisSet N (a ++ b) = basisSet N a ∪ basisSet N b := by
  unfold basisSet
  ext v
  simp only [Set.mem_range, Set.mem_union]
  constructor
  · rintro ⟨i, rfl⟩
    rw [List.get_eq_getElem, List.getElem_append]
    split_ifs with h
    · exact Or.inl ⟨⟨i.val, h⟩, rfl⟩
    · refine Or.inr ⟨⟨i.val - a.length, ?_⟩, rfl⟩
      have hl : (a ++ b).length = a.length + b.length := by simp
      have := lt_of_lt_of_eq i.isLt hl
      omega
  · rintro (⟨i, rfl⟩ | ⟨i, rfl⟩)
    · refine ⟨⟨i.val, by rw [List.length_append]; omega⟩, ?_⟩
      simp only [List.get_eq_getElem, Fin.val_mk]
      rw [List.getElem_append_left i.isLt]
    · refine ⟨⟨a.length + i.val, by rw [List.length_append]; omega⟩, ?_⟩
      simp only [List.get_eq_getElem, Fin.val_mk]
      rw [List.getElem_append_right (Nat.le_add_right _ _)]
      simp

/-! ## The dual dimension -/

/-- the orthogonal of everything is nothing: the dot product is nondegenerate -/
theorem orthogonal_top (L : ℕ) :
    (dotForm : LinearMap.BilinForm (ZMod 2) (Fin (nPlaq L) → ZMod 2)).orthogonal ⊤ = ⊥ := by
  ext x
  rw [LinearMap.BilinForm.mem_orthogonal_iff, Submodule.mem_bot]
  constructor
  · intro h
    exact dotForm_nondegenerate.2 x (fun y => h y Submodule.mem_top)
  · rintro rfl y _
    simp [dotForm_apply]

/-- finrank K^⊥ = 6V − finrank K -/
theorem finrank_orth_K (L rK : ℕ) (hK : Module.finrank (ZMod 2) (K L) = rK) :
    Module.finrank (ZMod 2) (orth (K L)) = nPlaq L - rK := by
  have h := LinearMap.BilinForm.finrank_add_finrank_orthogonal
    (B := (dotForm : LinearMap.BilinForm (ZMod 2) (Fin (nPlaq L) → ZMod 2))) dotForm_isRefl (K L)
  rw [orthogonal_top, inf_bot_eq, finrank_bot, add_zero, Module.finrank_fin_fun, hK] at h
  rw [orth_eq_orthogonal]
  omega

open Classical in
/-- the cardinality of a code from its finrank -/
theorem card_filter_eq (L : ℕ) (W : Submodule (ZMod 2) (Fin (nPlaq L) → ZMod 2)) :
    (Finset.univ.filter (· ∈ W)).card = 2 ^ Module.finrank (ZMod 2) W := by
  classical
  rw [← Fintype.card_subtype, Module.card_eq_pow_finrank (K := ZMod 2), ZMod.card]

/-! ## The sheets are independent of the boundaries -/

theorem finrank_S_le (L : ℕ) : Module.finrank (ZMod 2) (S L) ≤ 6 := by
  unfold S
  have h := finrank_range_le_card (R := ZMod 2) (fun q : Fin 6 => vecOf L (sheetMask L q.val))
  rw [Fintype.card_fin] at h
  exact h

theorem finrank_S (L rD : ℕ) (hD : Module.finrank (ZMod 2) (D L) = rD)
    (hDS : Module.finrank (ZMod 2) ↥(D L ⊔ S L) = rD + 6) :
    Module.finrank (ZMod 2) (S L) = 6 ∧ Module.finrank (ZMod 2) ↥(D L ⊓ S L) = 0 := by
  have h := Submodule.finrank_sup_add_finrank_inf_eq (D L) (S L)
  rw [hDS, hD] at h
  have hS := finrank_S_le L
  constructor <;> omega

theorem D_inf_S (L rD : ℕ) (hD : Module.finrank (ZMod 2) (D L) = rD)
    (hDS : Module.finrank (ZMod 2) ↥(D L ⊔ S L) = rD + 6) : D L ⊓ S L = ⊥ :=
  Submodule.finrank_eq_zero.mp (finrank_S L rD hD hDS).2

/-- the six sheets are linearly independent -/
theorem sheets_linearIndependent (L rD : ℕ) (hD : Module.finrank (ZMod 2) (D L) = rD)
    (hDS : Module.finrank (ZMod 2) ↥(D L ⊔ S L) = rD + 6) :
    LinearIndependent (ZMod 2) (fun q : Fin 6 => vecOf L (sheetMask L q.val)) := by
  rw [linearIndependent_iff_card_eq_finrank_span, Fintype.card_fin]
  exact (finrank_S L rD hD hDS).1.symm

/-- the subset sums of the sheets are distinct: the coefficients of a vanishing combination vanish -/
theorem sheet_sum_injective (L rD : ℕ) (hD : Module.finrank (ZMod 2) (D L) = rD)
    (hDS : Module.finrank (ZMod 2) ↥(D L ⊔ S L) = rD + 6) :
    Function.Injective (fun T : Finset (Fin 6) => ∑ q ∈ T, vecOf L (sheetMask L q.val)) := by
  intro T T' h
  simp only at h
  have hli := sheets_linearIndependent L rD hD hDS
  rw [Fintype.linearIndependent_iff] at hli
  have hcoef := hli (fun q => (if q ∈ T then (1 : ZMod 2) else 0) - (if q ∈ T' then 1 else 0)) (by
    simp only [sub_smul, ite_smul, one_smul, zero_smul, Finset.sum_sub_distrib]
    rw [Finset.sum_ite_mem, Finset.sum_ite_mem, Finset.univ_inter, Finset.univ_inter, h, sub_self])
  ext q
  have := hcoef q
  by_cases hq : q ∈ T <;> by_cases hq' : q ∈ T' <;> simp_all

/-- the 64 twists -/
theorem card_H (L rD : ℕ) (hD : Module.finrank (ZMod 2) (D L) = rD)
    (hDS : Module.finrank (ZMod 2) ↥(D L ⊔ S L) = rD + 6) : (H L).card = 64 := by
  unfold H
  rw [Finset.card_image_of_injective _ (sheet_sum_injective L rD hD hDS), Finset.card_univ,
    Fintype.card_finset, Fintype.card_fin]
  norm_num

/-- a vector of F₂^N added to itself vanishes -/
theorem add_self_vec (L : ℕ) (v : Fin (nPlaq L) → ZMod 2) : v + v = 0 := by
  funext i
  exact CharTwo.add_self_eq_zero (v i)

/-! ## THE THEOREM -/

/-- THE SECTOR SPLIT OF THE FOUR-TORUS OF ANY SIDE FROM A CERTIFICATE'S NUMBERS:
K^⊥ = ⊔_{h ∈ H} (h + D), given ∂₂∂₃ = 0, the sheets cycles, and the three finranks with rK + rD + 6 = 6V -/
theorem torusLSplit (L rK rD : ℕ)
    (hdd : ((cubeMasks L).all (fun c => (cobdMasks L).all (fun l => !(parAnd L c l)))) = true)
    (hsh : ((sheetMasks L).all (fun h => (cobdMasks L).all (fun l => !(parAnd L h l)))) = true)
    (hK : Module.finrank (ZMod 2) (K L) = rK) (hD : Module.finrank (ZMod 2) (D L) = rD)
    (hDS : Module.finrank (ZMod 2) ↥(D L ⊔ S L) = rD + 6) (hsum : rK + rD + 6 = nPlaq L) :
    TorusLSplit L := by
  unfold TorusLSplit
  apply sectorSplit_of_card (K L) (D L) (H L) (D_le_orth_K L hdd)
  · intro h hh
    unfold H at hh
    rw [Finset.mem_image] at hh
    obtain ⟨T, _, rfl⟩ := hh
    exact Submodule.sum_mem _ (fun q _ => sheet_mem_orth_K L hsh q)
  · intro h hh h' hh' hne hmem
    unfold H at hh hh'
    rw [Finset.mem_image] at hh hh'
    obtain ⟨T, _, rfl⟩ := hh
    obtain ⟨T', _, rfl⟩ := hh'
    have hS : ∑ q ∈ T, vecOf L (sheetMask L q.val) + ∑ q ∈ T', vecOf L (sheetMask L q.val) ∈ S L :=
      Submodule.add_mem _ (Submodule.sum_mem _ (fun q _ => Submodule.subset_span ⟨q, rfl⟩))
        (Submodule.sum_mem _ (fun q _ => Submodule.subset_span ⟨q, rfl⟩))
    have hinf : ∑ q ∈ T, vecOf L (sheetMask L q.val) + ∑ q ∈ T', vecOf L (sheetMask L q.val) ∈ D L ⊓ S L :=
      ⟨hmem, hS⟩
    rw [D_inf_S L rD hD hDS, Submodule.mem_bot] at hinf
    apply hne
    have h2 := congrArg (fun v => v + ∑ q ∈ T', vecOf L (sheetMask L q.val)) hinf
    simp only [zero_add] at h2
    rw [← h2, add_assoc, add_self_vec, add_zero]
  · rw [card_filter_eq, finrank_orth_K L rK hK, card_filter_eq, hD, card_H L rD hD hDS]
    have hd : nPlaq L - rK = rD + 6 := by omega
    rw [hd, pow_add]
    ring

end TorusL

end Aperanton
