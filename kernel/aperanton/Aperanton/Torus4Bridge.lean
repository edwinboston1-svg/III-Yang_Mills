/-
  APERANTON -- THE BOUNDLESS, stage W4's bridge B4 (ADDENDUM I, THE ROAD): THE SECTOR SPLIT OF THE FOUR-TORUS OF
  SIDE TWO AS A THEOREM -- `Torus4Split` discharged from the echelon certificates.

  THE PIECES.  The plaquette code K is the span of δ¹'s 64 columns, the boundary code D the span of ∂₃'s 64 columns,
  and the certificates (Torus4Cert.lean, decided) give their finranks, 45 and 45, and the finrank 51 of D with the
  six sheets (`finrank_K`, `finrank_D`, `finrank_DS`, through Echelon.lean's `finrank_gens_eq`).  THE DUAL DIMENSION:
  the dot product is nondegenerate and reflexive (MacWilliams.lean), its orthogonal of ⊤ is ⊥ (`orthogonal_top`), so
  finrank K + finrank K^⊥ = 96 (`finrank_add_finrank_orthogonal`) and |K^⊥| = 2^51 (`card_orth_K`).  THE SHEETS:
  with S the span of the six sheets, finrank (D ⊔ S) = 51 = finrank D + finrank S − finrank (D ⊓ S) and
  finrank S ≤ 6 force finrank S = 6 and D ⊓ S = ⊥ (`sheets_independent`, `D_inf_S`): the 64 subset-sums of the
  sheets are distinct and no nonzero one lies in D.  THEN `sectorSplit_of_card` (Duality.lean) lands THE THEOREM
  `torus4Split : SectorSplit K D H` -- the hypothesis under which `duality` reads Wegner's self-duality on this
  torus -- from B2 (Bridge.lean), the sheets' independence and ONE cardinality identity 2^51 = 64 · 2^45, the
  2^51-member sets never enumerated.  No sorry, no axiom, no native_decide.
-/
import Mathlib
import Aperanton.Duality
import Aperanton.Torus4
import Aperanton.Bridge
import Aperanton.Echelon
import Aperanton.Torus4Cert

open Finset Matrix

namespace Aperanton

namespace Torus4

open Torus4Cert

/-! ## The generator lists and the codes -/

theorem vecOf_eq (m : ℕ) : vecOf m = vecOfN nPlaq m := rfl

theorem cobdMasks_length : cobdMasks.length = nLinks := by simp [cobdMasks, nLinks]

theorem cubeMasks_length : cubeMasks.length = nCubes := by simp [cubeMasks, nCubes]

theorem sheetMasks_length : sheetMasks.length = 6 := by simp [sheetMasks]

theorem cobdMasks_getElem (i : ℕ) (h : i < cobdMasks.length) : cobdMasks[i] = cobdMask i := by
  simp [cobdMasks]

theorem cubeMasks_getElem (i : ℕ) (h : i < cubeMasks.length) : cubeMasks[i] = cubeMask i := by
  simp [cubeMasks]

theorem sheetMasks_getElem (i : ℕ) (h : i < sheetMasks.length) : sheetMasks[i] = sheetMask i := by
  simp [sheetMasks]

/-- the plaquette code is the span of the coboundary list's vectors -/
theorem K_eq : K = Submodule.span (ZMod 2) (basisSet nPlaq cobdMasks) := by
  unfold K basisSet
  congr 1
  ext v
  constructor
  · rintro ⟨l, rfl⟩
    refine ⟨⟨l.val, by rw [cobdMasks_length]; exact l.isLt⟩, ?_⟩
    simp only [List.get_eq_getElem, cobdMasks_getElem, vecOf_eq]
  · rintro ⟨i, rfl⟩
    refine ⟨⟨i.val, lt_of_lt_of_eq i.isLt cobdMasks_length⟩, ?_⟩
    simp only [List.get_eq_getElem, cobdMasks_getElem, vecOf_eq]

/-- the boundary code is the span of the cube list's vectors -/
theorem D_eq : D = Submodule.span (ZMod 2) (basisSet nPlaq cubeMasks) := by
  unfold D basisSet
  congr 1
  ext v
  constructor
  · rintro ⟨k, rfl⟩
    refine ⟨⟨k.val, by rw [cubeMasks_length]; exact k.isLt⟩, ?_⟩
    simp only [List.get_eq_getElem, cubeMasks_getElem, vecOf_eq]
  · rintro ⟨i, rfl⟩
    refine ⟨⟨i.val, lt_of_lt_of_eq i.isLt cubeMasks_length⟩, ?_⟩
    simp only [List.get_eq_getElem, cubeMasks_getElem, vecOf_eq]

/-- the span of the sheets -/
def S : Submodule (ZMod 2) (Fin nPlaq → ZMod 2) :=
  Submodule.span (ZMod 2) (Set.range (fun q : Fin 6 => vecOf (sheetMask q.val)))

theorem S_eq : S = Submodule.span (ZMod 2) (basisSet nPlaq sheetMasks) := by
  unfold S basisSet
  congr 1
  ext v
  constructor
  · rintro ⟨q, rfl⟩
    refine ⟨⟨q.val, by rw [sheetMasks_length]; exact q.isLt⟩, ?_⟩
    simp only [List.get_eq_getElem, sheetMasks_getElem, vecOf_eq]
  · rintro ⟨i, rfl⟩
    refine ⟨⟨i.val, lt_of_lt_of_eq i.isLt sheetMasks_length⟩, ?_⟩
    simp only [List.get_eq_getElem, sheetMasks_getElem, vecOf_eq]

/-- the generator set of a concatenation is the union -/
theorem basisSet_append (a b : List ℕ) : basisSet nPlaq (a ++ b) = basisSet nPlaq a ∪ basisSet nPlaq b := by
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

/-! ## The finranks from the certificates -/

theorem piv_lt_nPlaq_Cobd : ∀ p ∈ pivCobd, p < nPlaq := Cobd_piv_lt
theorem piv_lt_nPlaq_Bd3 : ∀ p ∈ pivBd3, p < nPlaq := Bd3_piv_lt
theorem piv_lt_nPlaq_Bd3S : ∀ p ∈ pivBd3S, p < nPlaq := Bd3S_piv_lt

theorem finrank_K : Module.finrank (ZMod 2) K = 45 := by
  rw [K_eq, finrank_gens_eq nPlaq cobdMasks basisCobd pivCobd selGCobd selBCobd Cobd_cert piv_lt_nPlaq_Cobd
    Cobd_selG Cobd_selB]
  exact Cobd_rank

theorem finrank_D : Module.finrank (ZMod 2) D = 45 := by
  rw [D_eq, finrank_gens_eq nPlaq cubeMasks basisBd3 pivBd3 selGBd3 selBBd3 Bd3_cert piv_lt_nPlaq_Bd3
    Bd3_selG Bd3_selB]
  exact Bd3_rank

theorem finrank_DS : Module.finrank (ZMod 2) ↥(D ⊔ S) = 51 := by
  rw [D_eq, S_eq, ← Submodule.span_union, ← basisSet_append,
    finrank_gens_eq nPlaq (cubeMasks ++ sheetMasks) basisBd3S pivBd3S selGBd3S selBBd3S Bd3S_cert
      piv_lt_nPlaq_Bd3S Bd3S_selG Bd3S_selB]
  exact Bd3S_rank

/-! ## The dual dimension -/

/-- the orthogonal of everything is nothing: the dot product is nondegenerate -/
theorem orthogonal_top : (dotForm : LinearMap.BilinForm (ZMod 2) (Fin nPlaq → ZMod 2)).orthogonal ⊤ = ⊥ := by
  ext x
  rw [LinearMap.BilinForm.mem_orthogonal_iff, Submodule.mem_bot]
  constructor
  · intro h
    exact dotForm_nondegenerate.2 x (fun y => h y Submodule.mem_top)
  · rintro rfl y _
    simp [dotForm_apply]

theorem finrank_orth_K : Module.finrank (ZMod 2) (orth K) = 51 := by
  have h := LinearMap.BilinForm.finrank_add_finrank_orthogonal
    (B := (dotForm : LinearMap.BilinForm (ZMod 2) (Fin nPlaq → ZMod 2))) dotForm_isRefl K
  rw [orthogonal_top, inf_bot_eq, finrank_bot, add_zero, Module.finrank_fin_fun, finrank_K] at h
  rw [orth_eq_orthogonal]
  have : (96 : ℕ) = nPlaq := rfl
  omega

open Classical in
/-- the cardinality of a code from its finrank -/
theorem card_filter_eq (W : Submodule (ZMod 2) (Fin nPlaq → ZMod 2)) :
    (Finset.univ.filter (· ∈ W)).card = 2 ^ Module.finrank (ZMod 2) W := by
  classical
  rw [← Fintype.card_subtype, Module.card_eq_pow_finrank (K := ZMod 2), ZMod.card]

/-! ## The sheets are independent of the boundaries -/

theorem finrank_S_le : Module.finrank (ZMod 2) S ≤ 6 := by
  unfold S
  have h := finrank_range_le_card (R := ZMod 2) (fun q : Fin 6 => vecOf (sheetMask q.val))
  rw [Fintype.card_fin] at h
  exact h

theorem finrank_S : Module.finrank (ZMod 2) S = 6 ∧ Module.finrank (ZMod 2) ↥(D ⊓ S) = 0 := by
  have h := Submodule.finrank_sup_add_finrank_inf_eq D S
  rw [finrank_DS, finrank_D] at h
  have hS := finrank_S_le
  constructor <;> omega

theorem D_inf_S : D ⊓ S = ⊥ := Submodule.finrank_eq_zero.mp finrank_S.2

/-- the six sheets are linearly independent -/
theorem sheets_linearIndependent : LinearIndependent (ZMod 2) (fun q : Fin 6 => vecOf (sheetMask q.val)) := by
  rw [linearIndependent_iff_card_eq_finrank_span, Fintype.card_fin]
  exact finrank_S.1.symm

/-- a nonzero combination of sheets is not a boundary -/
theorem sheet_sum_not_mem_D (T : Finset (Fin 6)) (hT : T.Nonempty) :
    ∑ q ∈ T, vecOf (sheetMask q.val) ∉ D := by
  intro hmem
  have hS : ∑ q ∈ T, vecOf (sheetMask q.val) ∈ S := Submodule.sum_mem _ (fun q _ => Submodule.subset_span ⟨q, rfl⟩)
  have hinf : ∑ q ∈ T, vecOf (sheetMask q.val) ∈ D ⊓ S := ⟨hmem, hS⟩
  rw [D_inf_S, Submodule.mem_bot] at hinf
  obtain ⟨q₀, hq₀⟩ := hT
  have hli := sheets_linearIndependent
  rw [Fintype.linearIndependent_iff] at hli
  have h := hli (fun q => if q ∈ T then 1 else 0) (by
    rw [← hinf]
    simp only [ite_smul, one_smul, zero_smul]
    rw [Finset.sum_ite_mem, Finset.univ_inter])
  have := h q₀
  rw [if_pos hq₀] at this
  exact one_ne_zero this

/-- the subset sums of the sheets are distinct: the coefficients of a vanishing combination vanish -/
theorem sheet_sum_injective :
    Function.Injective (fun T : Finset (Fin 6) => ∑ q ∈ T, vecOf (sheetMask q.val)) := by
  intro T T' h
  simp only at h
  have hli := sheets_linearIndependent
  rw [Fintype.linearIndependent_iff] at hli
  have hcoef := hli (fun q => (if q ∈ T then (1 : ZMod 2) else 0) - (if q ∈ T' then 1 else 0)) (by
    simp only [sub_smul, ite_smul, one_smul, zero_smul, Finset.sum_sub_distrib]
    rw [Finset.sum_ite_mem, Finset.sum_ite_mem, Finset.univ_inter, Finset.univ_inter, h, sub_self])
  ext q
  have := hcoef q
  by_cases hq : q ∈ T <;> by_cases hq' : q ∈ T' <;> simp_all

/-- the 64 twists -/
theorem card_H : H.card = 64 := by
  unfold H
  rw [Finset.card_image_of_injective _ sheet_sum_injective, Finset.card_univ, Fintype.card_finset, Fintype.card_fin]
  norm_num

/-- a vector of F₂^N added to itself vanishes -/
theorem add_self_vec (v : Fin nPlaq → ZMod 2) : v + v = 0 := by
  funext i
  exact CharTwo.add_self_eq_zero (v i)

/-! ## THE THEOREM -/

/-- THE SECTOR SPLIT OF THE FOUR-TORUS OF SIDE TWO: K^⊥ = ⊔_{h ∈ H} (h + D), from the certificates -/
theorem torus4Split : Torus4Split := by
  unfold Torus4Split
  apply sectorSplit_of_card K D H D_le_orth_K
  · intro h hh
    unfold H at hh
    rw [Finset.mem_image] at hh
    obtain ⟨T, _, rfl⟩ := hh
    exact Submodule.sum_mem _ (fun q _ => sheet_mem_orth_K q)
  · intro h hh h' hh' hne hmem
    unfold H at hh hh'
    rw [Finset.mem_image] at hh hh'
    obtain ⟨T, _, rfl⟩ := hh
    obtain ⟨T', _, rfl⟩ := hh'
    have hS : ∑ q ∈ T, vecOf (sheetMask q.val) + ∑ q ∈ T', vecOf (sheetMask q.val) ∈ S :=
      Submodule.add_mem _ (Submodule.sum_mem _ (fun q _ => Submodule.subset_span ⟨q, rfl⟩))
        (Submodule.sum_mem _ (fun q _ => Submodule.subset_span ⟨q, rfl⟩))
    have hinf : ∑ q ∈ T, vecOf (sheetMask q.val) + ∑ q ∈ T', vecOf (sheetMask q.val) ∈ D ⊓ S := ⟨hmem, hS⟩
    rw [D_inf_S, Submodule.mem_bot] at hinf
    apply hne
    have h2 := congrArg (fun v => v + ∑ q ∈ T', vecOf (sheetMask q.val)) hinf
    simp only [zero_add] at h2
    rw [← h2, add_assoc, add_self_vec, add_zero]
  · rw [card_filter_eq, finrank_orth_K, card_filter_eq, finrank_D, card_H]
    norm_num

end Torus4

end Aperanton
