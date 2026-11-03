/-
  APERANTON -- THE BOUNDLESS, stage W6′ (ADDENDUM I, THE ROAD): THE EVERY-L STEP'S FIRST LEMMAS -- A MASK'S BIT IS
  MEMBERSHIP IN ITS LIST, AND A MASK PARITY IS AN INTERSECTION COUNT.

  The side-3 certificate decides ∂₂∂₃ = 0 as a mask parity for every pair of a cube and a link: 4V·4V parities each a
  6V-deep recursion (`Torus4.par`), 105,000 × 486 at side 3 and 1,000,000 × 1536 at side 4 -- the one decide that
  does not scale.  The parity of the and of two masks built from lists is the parity of the lists' intersection
  count (`parAnd_maskOf`), because a mask's bit is membership in its list (`testBit_maskOf`); so the same fact reads
  LOCALLY -- a cube's faces against a link's plaquettes, six against six -- and a side's instance decides the local
  form in time linear in the volume.  W = 0; the earning is the decide that scales.
  No sorry, no axiom, no native_decide.
-/
import Mathlib
import Aperanton.TorusL
import Aperanton.Bridge

open Finset

namespace Aperanton

namespace TorusL

/-- one bit set: the bit of `1 <<< i` is the index itself -/
theorem testBit_bitOf (i p : ℕ) : Nat.testBit (Torus4.bitOf i) p = decide (p = i) := by
  unfold Torus4.bitOf
  rw [Nat.shiftLeft_eq, one_mul, Nat.testBit_two_pow]
  by_cases h : p = i
  · subst h; simp
  · simp [h, Ne.symm h]

/-- a bit of a mask built from a list is set iff the index is in the list -/
theorem testBit_maskOf (l : List ℕ) (p : ℕ) : Nat.testBit (Torus4.maskOf l) p = decide (p ∈ l) := by
  unfold Torus4.maskOf
  suffices h : ∀ acc : ℕ, Nat.testBit (l.foldl (fun m i => Nat.lor m (Torus4.bitOf i)) acc) p
      = (Nat.testBit acc p || decide (p ∈ l)) by
    rw [h 0, Nat.zero_testBit, Bool.false_or]
  induction l with
  | nil => intro acc; simp
  | cons i t ih =>
    intro acc
    rw [List.foldl_cons, ih]
    have hlor : Nat.testBit (Nat.lor acc (Torus4.bitOf i)) p = (Nat.testBit acc p || decide (p = i)) := by
      show Nat.testBit (acc ||| Torus4.bitOf i) p = _
      rw [Nat.testBit_lor, testBit_bitOf]
    rw [hlor]
    by_cases hp : p = i
    · subst hp; simp
    · simp [hp, List.mem_cons]

/-- THE PARITY OF THE AND OF TWO LIST MASKS IS THE PARITY OF THEIR INTERSECTION COUNT (below the width) -/
theorem parAnd_maskOf (L : ℕ) (A B : List ℕ) :
    parAnd L (Torus4.maskOf A) (Torus4.maskOf B) =
      decide ((univ.filter (fun p : Fin (nPlaq L) => p.val ∈ A ∧ p.val ∈ B)).card % 2 = 1) := by
  unfold parAnd
  have hsum := sum_testBit_eq_par (nPlaq L) (Nat.land (Torus4.maskOf A) (Torus4.maskOf B))
  have hpt : ∀ i : Fin (nPlaq L),
      (if Nat.testBit (Nat.land (Torus4.maskOf A) (Torus4.maskOf B)) i.val then (1 : ZMod 2) else 0)
        = if i.val ∈ A ∧ i.val ∈ B then 1 else 0 := by
    intro i
    have hland : Nat.land (Torus4.maskOf A) (Torus4.maskOf B) = Torus4.maskOf A &&& Torus4.maskOf B := rfl
    rw [hland, Nat.testBit_land, testBit_maskOf, testBit_maskOf]
    by_cases ha : i.val ∈ A <;> by_cases hb : i.val ∈ B <;> simp [ha, hb]
  simp_rw [hpt] at hsum
  rw [← Finset.sum_filter, Finset.sum_const, nsmul_eq_mul, mul_one] at hsum
  -- hsum : (card : ZMod 2) = if par .. then 1 else 0
  set c := (univ.filter (fun p : Fin (nPlaq L) => p.val ∈ A ∧ p.val ∈ B)).card with hc
  have hmod : ((c : ℕ) : ZMod 2) = ((c % 2 : ℕ) : ZMod 2) := (ZMod.natCast_mod c 2).symm
  rw [hmod] at hsum
  rcases Nat.mod_two_eq_zero_or_one c with h0 | h1
  · rw [h0] at hsum
    simp only [Nat.cast_zero] at hsum
    cases hpar : Torus4.par (nPlaq L) (Nat.land (Torus4.maskOf A) (Torus4.maskOf B))
    · simp [h0]
    · rw [hpar] at hsum
      simp at hsum
  · rw [h1] at hsum
    simp only [Nat.cast_one] at hsum
    cases hpar : Torus4.par (nPlaq L) (Nat.land (Torus4.maskOf A) (Torus4.maskOf B))
    · rw [hpar] at hsum
      simp at hsum
    · simp [h1]

/-- the count of a nodup list's members below n satisfying P, as a Fin-filter card -/
theorem card_filter_fin_eq_length (n : ℕ) (A : List ℕ) (hA : A.Nodup) (hlt : ∀ a ∈ A, a < n)
    (P : ℕ → Prop) [DecidablePred P] :
    (univ.filter (fun p : Fin n => p.val ∈ A ∧ P p.val)).card = (A.filter (fun a => decide (P a))).length := by
  rw [← List.toFinset_card_of_nodup (List.Nodup.filter _ hA)]
  apply Finset.card_bij (fun p _ => p.val)
  · intro p hp
    rw [Finset.mem_filter] at hp
    rw [List.mem_toFinset, List.mem_filter]
    exact ⟨hp.2.1, by simpa using hp.2.2⟩
  · intro p _ q _ h
    exact Fin.ext h
  · intro a ha
    rw [List.mem_toFinset, List.mem_filter] at ha
    refine ⟨⟨a, hlt a ha.1⟩, ?_, rfl⟩
    rw [Finset.mem_filter]
    exact ⟨Finset.mem_univ _, ha.1, by simpa using ha.2⟩

/-- THE LOCAL FORM OF ∂₂∂₃ = 0: every cube's faces meet every link's plaquettes an even number of times, as list counts
(4V · 4V pairs, six faces against four links each) -/
abbrev LocalDD (L : ℕ) : Prop :=
  ((List.range (nCubes L)).all (fun k => (List.range (nLinks L)).all (fun l =>
    ((cubeFaces L (k / V L) (k % V L)).filter
      (fun p => (plaqLinks L (p / V L) (p % V L)).contains l)).length % 2 == 0))) = true

/-- the faces of every cube are distinct and below the width -/
abbrev FacesOK (L : ℕ) : Prop :=
  ((List.range (nCubes L)).all (fun k => decide ((cubeFaces L (k / V L) (k % V L)).Nodup) &&
    (cubeFaces L (k / V L) (k % V L)).all (fun p => p < nPlaq L))) = true

/-- THE MASK FORM FROM THE LOCAL FORM: the decide that scales gives the decide the bridge reads -/
theorem dd_of_local (L : ℕ) (hloc : LocalDD L) (hok : FacesOK L) :
    ((cubeMasks L).all (fun c => (cobdMasks L).all (fun l => !(parAnd L c l)))) = true := by
  rw [List.all_eq_true]
  intro c hc
  rw [cubeMasks, List.mem_map] at hc
  obtain ⟨k, hk, rfl⟩ := hc
  rw [List.all_eq_true]
  intro m hm
  rw [cobdMasks, List.mem_map] at hm
  obtain ⟨l, hl, rfl⟩ := hm
  unfold cubeMask cobdMask
  rw [parAnd_maskOf]
  unfold FacesOK at hok
  rw [List.all_eq_true] at hok
  have hk' := hok k hk
  rw [Bool.and_eq_true, decide_eq_true_eq, List.all_eq_true] at hk'
  have hnd : (cubeFaces L (k / V L) (k % V L)).Nodup := hk'.1
  have hlt : ∀ p ∈ cubeFaces L (k / V L) (k % V L), p < nPlaq L := fun p hp => by simpa using hk'.2 p hp
  unfold LocalDD at hloc
  rw [List.all_eq_true] at hloc
  have hkl := hloc k hk
  rw [List.all_eq_true] at hkl
  have hev := hkl l hl
  simp only [beq_iff_eq] at hev
  rw [card_filter_fin_eq_length (nPlaq L) _ hnd hlt (fun p => p ∈ linkCobd L l)]
  have hfilt : (cubeFaces L (k / V L) (k % V L)).filter (fun p => decide (p ∈ linkCobd L l))
      = (cubeFaces L (k / V L) (k % V L)).filter (fun p => (plaqLinks L (p / V L) (p % V L)).contains l) := by
    apply List.filter_congr
    intro p hp
    rw [Bool.eq_iff_iff, decide_eq_true_iff]
    simp only [linkCobd, List.mem_filter, List.mem_range]
    constructor
    · intro h
      exact h.2
    · intro h
      exact ⟨hlt p hp, h⟩
  rw [hfilt, hev]
  decide

/-- the sheet of the pair q as a list of plaquettes -/
def sheetList (L q : ℕ) : List ℕ :=
  ((List.range (V L)).filter (fun s =>
    (List.range 4).all (fun d => d = Torus4.pairMu q || d = Torus4.pairNu q || coord L s d = 0))).map
      (fun s => plaq L q s)

theorem sheetMask_eq_maskOf (L q : ℕ) : sheetMask L q = Torus4.maskOf (sheetList L q) := rfl

/-- THE LOCAL FORM OF THE SHEETS' CYCLICITY: every sheet meets every link's plaquettes an even number of times -/
abbrev LocalSheets (L : ℕ) : Prop :=
  ((List.range 6).all (fun q => (List.range (nLinks L)).all (fun l =>
    ((sheetList L q).filter (fun p => (plaqLinks L (p / V L) (p % V L)).contains l)).length % 2 == 0))) = true

/-- the plaquettes of every sheet are distinct and below the width -/
abbrev SheetsOK (L : ℕ) : Prop :=
  ((List.range 6).all (fun q => decide ((sheetList L q).Nodup) && (sheetList L q).all (fun p => p < nPlaq L))) = true

/-- THE MASK FORM OF THE SHEETS' CYCLICITY FROM THE LOCAL FORM -/
theorem sheets_of_local (L : ℕ) (hloc : LocalSheets L) (hok : SheetsOK L) :
    ((sheetMasks L).all (fun h => (cobdMasks L).all (fun l => !(parAnd L h l)))) = true := by
  rw [List.all_eq_true]
  intro c hc
  rw [sheetMasks, List.mem_map] at hc
  obtain ⟨q, hq, rfl⟩ := hc
  rw [List.all_eq_true]
  intro m hm
  rw [cobdMasks, List.mem_map] at hm
  obtain ⟨l, hl, rfl⟩ := hm
  unfold cobdMask
  rw [sheetMask_eq_maskOf, parAnd_maskOf]
  unfold SheetsOK at hok
  rw [List.all_eq_true] at hok
  have hq' := hok q hq
  rw [Bool.and_eq_true, decide_eq_true_eq, List.all_eq_true] at hq'
  have hnd : (sheetList L q).Nodup := hq'.1
  have hlt : ∀ p ∈ sheetList L q, p < nPlaq L := fun p hp => by simpa using hq'.2 p hp
  unfold LocalSheets at hloc
  rw [List.all_eq_true] at hloc
  have hql := hloc q hq
  rw [List.all_eq_true] at hql
  have hev := hql l hl
  simp only [beq_iff_eq] at hev
  rw [card_filter_fin_eq_length (nPlaq L) _ hnd hlt (fun p => p ∈ linkCobd L l)]
  have hfilt : (sheetList L q).filter (fun p => decide (p ∈ linkCobd L l))
      = (sheetList L q).filter (fun p => (plaqLinks L (p / V L) (p % V L)).contains l) := by
    apply List.filter_congr
    intro p hp
    rw [Bool.eq_iff_iff, decide_eq_true_iff]
    simp only [linkCobd, List.mem_filter, List.mem_range]
    constructor
    · intro h
      exact h.2
    · intro h
      exact ⟨hlt p hp, h⟩
  rw [hfilt, hev]
  decide

/-! ## The incident forms: the decides that are LINEAR in the volume

A link off every face of a cube meets its faces zero times, an even count for free; only the links ON the cube's faces
need their count read.  So the local form is quantified over the cube's own incident links (six faces, four links each)
and the all-links form follows by a case split -- the certificate at side L decides 24 counts per cube, never 4V. -/

/-- the local form of ∂₂∂₃ = 0 over the INCIDENT links only -/
abbrev LocalDDInc (L : ℕ) : Prop :=
  ((List.range (nCubes L)).all (fun k =>
    ((cubeFaces L (k / V L) (k % V L)).flatMap (fun p => plaqLinks L (p / V L) (p % V L))).all (fun l =>
      ((cubeFaces L (k / V L) (k % V L)).filter
        (fun p => (plaqLinks L (p / V L) (p % V L)).contains l)).length % 2 == 0))) = true

/-- THE INCIDENT FORM GIVES THE ALL-LINKS FORM: a link on no face has the empty filter -/
theorem localDD_of_inc (L : ℕ) (h : LocalDDInc L) : LocalDD L := by
  unfold LocalDD LocalDDInc at *
  rw [List.all_eq_true] at h ⊢
  intro k hk
  have hk' := h k hk
  rw [List.all_eq_true] at hk' ⊢
  intro l _
  by_cases hmem : l ∈ (cubeFaces L (k / V L) (k % V L)).flatMap (fun p => plaqLinks L (p / V L) (p % V L))
  · exact hk' l hmem
  · have hfilt : (cubeFaces L (k / V L) (k % V L)).filter
        (fun p => (plaqLinks L (p / V L) (p % V L)).contains l) = [] := by
      rw [List.filter_eq_nil_iff]
      intro p hp hcont
      apply hmem
      rw [List.mem_flatMap]
      exact ⟨p, hp, by simpa using hcont⟩
    rw [hfilt]
    decide

/-- the local form of the sheets' cyclicity over the INCIDENT links only -/
abbrev LocalSheetsInc (L : ℕ) : Prop :=
  ((List.range 6).all (fun q =>
    ((sheetList L q).flatMap (fun p => plaqLinks L (p / V L) (p % V L))).all (fun l =>
      ((sheetList L q).filter (fun p => (plaqLinks L (p / V L) (p % V L)).contains l)).length % 2 == 0))) = true

/-- THE INCIDENT FORM GIVES THE ALL-LINKS FORM for the sheets -/
theorem localSheets_of_inc (L : ℕ) (h : LocalSheetsInc L) : LocalSheets L := by
  unfold LocalSheets LocalSheetsInc at *
  rw [List.all_eq_true] at h ⊢
  intro q hq
  have hq' := h q hq
  rw [List.all_eq_true] at hq' ⊢
  intro l _
  by_cases hmem : l ∈ (sheetList L q).flatMap (fun p => plaqLinks L (p / V L) (p % V L))
  · exact hq' l hmem
  · have hfilt : (sheetList L q).filter (fun p => (plaqLinks L (p / V L) (p % V L)).contains l) = [] := by
      rw [List.filter_eq_nil_iff]
      intro p hp hcont
      apply hmem
      rw [List.mem_flatMap]
      exact ⟨p, hp, by simpa using hcont⟩
    rw [hfilt]
    decide

end TorusL

end Aperanton
