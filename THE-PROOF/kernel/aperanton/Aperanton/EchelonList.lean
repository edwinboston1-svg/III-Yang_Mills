/-
  APERANTON -- THE BOUNDLESS, THE EVERY-L STEP (2026-10-28): THE LIST-FORM ECHELON CERTIFICATE -- every check a fold
  over the lists, no `List.get`, no `Fin` enumeration, so the kernel's cost is LINEAR in the data.

  Echelon.lean states a certificate in Fin-indexed form: `hit` and `miss` index the basis by `List.get` (cost i each)
  over every pair (r² pairs), and a selection `xorSel` indexes the basis by `getD` inside a fold over `range r`: the
  kernel's cost is r³ for the miss check and G·r² for the selections -- at side 3 (r = 240) the certificate ran the
  kernel past 18 GB and was killed (01:09); at side 4 (r = 765) the Fin form is hopeless.  Here the same facts are
  stated as folds: the hit check over `basis.zip piv`, the miss check as a double `all` with the element compared by
  value (so the basis must be `Nodup`), the selection `xorSelL` as ONE fold over the basis carrying the index, and the
  selection checks over `gens.zip sel`.  THE BRIDGES carry the list forms to Echelon.lean's `EchelonCert` and to the
  selection hypotheses its consumers (`finrank_gens_eq`, `card_gens_eq`) take, unchanged: the certificate files decide
  the list forms and apply the bridges.  No sorry, no axiom, no native_decide.
-/
import Mathlib
import Aperanton.Echelon

namespace Aperanton

namespace EchelonList

/-! ## The linear selection -/

/-- the selection as one fold over the basis, the index carried: the xor of the basis masks whose index bit is set -/
def xorSelAux (m : ℕ) : List ℕ → ℕ → ℕ → ℕ
  | [], _, acc => acc
  | b :: l, k, acc => xorSelAux m l (k + 1) (if Nat.testBit m k then Nat.xor acc b else acc)

def xorSelL (m : ℕ) (basis : List ℕ) : ℕ := xorSelAux m basis 0 0

/-- the fold with the index carried is the range fold with the list indexed, from any start -/
theorem xorSelAux_eq (m : ℕ) (l : List ℕ) (k acc : ℕ) :
    xorSelAux m l k acc
      = (List.range' k l.length).foldl
          (fun a i => if Nat.testBit m i then Nat.xor a (l.getD (i - k) 0) else a) acc := by
  induction l generalizing k acc with
  | nil => rfl
  | cons b l ih =>
    rw [xorSelAux, ih, List.length_cons, List.range'_succ, List.foldl_cons, Nat.sub_self]
    simp only [List.getD_cons_zero]
    apply List.foldl_ext
    intro a i hi
    rw [List.mem_range'] at hi
    have h1 : i - k = (i - (k + 1)) + 1 := by omega
    rw [h1, List.getD_cons_succ]

/-- THE BRIDGE: the linear selection is Echelon.lean's selection -/
theorem xorSelL_eq (m : ℕ) (basis : List ℕ) : xorSelL m basis = xorSel m basis := by
  unfold xorSelL xorSel
  rw [xorSelAux_eq, List.range_eq_range']
  apply List.foldl_ext
  intro a i _
  rw [Nat.sub_zero]

/-! ## The list-form checks -/

/-- every basis element has its pivot bit set -/
def hitL (basis piv : List ℕ) : Bool := (basis.zip piv).all (fun bp => Nat.testBit bp.1 bp.2)

/-- every OTHER basis element has the pivot bit clear (the element compared by value: the basis is nodup) -/
def missL (basis piv : List ℕ) : Bool :=
  (basis.zip piv).all (fun bp => basis.all (fun b' => (b' == bp.1) || !Nat.testBit b' bp.2))

/-- every generator is the linear selection of the basis by its mask -/
def selL (gens sel basis : List ℕ) : Bool := (gens.zip sel).all (fun gs => gs.1 == xorSelL gs.2 basis)

/-! ## The bridges to the Fin forms -/

theorem zip_getElem_mem {α β : Type*} (l₁ : List α) (l₂ : List β) (i : ℕ) (h₁ : i < l₁.length)
    (h₂ : i < l₂.length) : (l₁[i], l₂[i]) ∈ l₁.zip l₂ := by
  have h : i < (l₁.zip l₂).length := by rw [List.length_zip]; omega
  have := List.getElem_mem h
  rwa [List.getElem_zip] at this

/-- THE CERTIFICATE FROM THE LIST FORMS -/
theorem echelonCert_of_lists (basis piv : List ℕ) (hlen : piv.length = basis.length) (hnd : basis.Nodup)
    (hhit : hitL basis piv = true) (hmiss : missL basis piv = true) : EchelonCert basis piv := by
  refine ⟨hlen, ?_, ?_⟩
  · intro i
    have hi : i.val < piv.length := by rw [hlen]; exact i.isLt
    have hmem := zip_getElem_mem basis piv i.val i.isLt hi
    unfold hitL at hhit
    rw [List.all_eq_true] at hhit
    have := hhit _ hmem
    rw [List.getD_eq_getElem _ _ hi]
    simpa [List.get_eq_getElem] using this
  · intro i j hij
    have hi : i.val < piv.length := by rw [hlen]; exact i.isLt
    have hmem := zip_getElem_mem basis piv i.val i.isLt hi
    unfold missL at hmiss
    rw [List.all_eq_true] at hmiss
    have hrow := hmiss _ hmem
    rw [List.all_eq_true] at hrow
    have hj := hrow _ (List.getElem_mem j.isLt)
    simp only [Bool.or_eq_true, beq_iff_eq, Bool.not_eq_true'] at hj
    rcases hj with hj | hj
    · exfalso
      apply hij
      exact Fin.ext ((List.Nodup.getElem_inj_iff hnd).mp hj.symm)
    · rw [List.getD_eq_getElem _ _ hi]
      simpa [List.get_eq_getElem] using hj

/-- THE SELECTION HYPOTHESIS FROM THE LIST FORM -/
theorem sel_of_list (gens sel basis : List ℕ) (hlen : sel.length = gens.length) (h : selL gens sel basis = true) :
    ∀ i : Fin gens.length, gens.get i = xorSel (sel.getD i.val 0) basis := by
  intro i
  have hi : i.val < sel.length := by rw [hlen]; exact i.isLt
  have hmem := zip_getElem_mem gens sel i.val i.isLt hi
  unfold selL at h
  rw [List.all_eq_true] at h
  have := h _ hmem
  simp only [beq_iff_eq] at this
  rw [List.getD_eq_getElem _ _ hi, ← xorSelL_eq, List.get_eq_getElem]
  exact this

end EchelonList

end Aperanton
