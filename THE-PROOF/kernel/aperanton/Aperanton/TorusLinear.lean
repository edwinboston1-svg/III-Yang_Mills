/-
  APERANTON -- THE BOUNDLESS, THE EVERY-L STEP (2026-10-28): THE LINEAR GEOMETRY -- the four-torus's incidence facts
  decided in time LINEAR in the volume, bridged to the mask forms the split consumes.

  The kernel's cost law, measured decide by decide at side 3 (01:1x): an enumeration of ~10^5 closure applications
  costs gigabytes, ~10^4 is free, and the all-plaquette filter behind `linkCobd` (4V · 6V `contains`) alone took the
  kernel 7.7 GB past the import.  So the link's six plaquettes are LISTED DIRECTLY (`linkPlaqs`: for each pair
  containing the link's direction, the plaquette at the site and the one a step back in the other direction) and TWO
  CONSISTENCY DECIDES, each linear (every link of every plaquette lists the plaquette; every plaquette of every link
  lists the link, both in range), give `cobdMask = maskOf (linkPlaqs)` for every link WITHOUT the filter ever running
  in the kernel.  THE BOUNDARY OF A BOUNDARY and THE SHEETS' CYCLICITY are decided as XOR IDENTITIES: the xor over a
  cube's six faces (a sheet's L² plaquettes) of each face's link mask is zero -- one GMP xor per face -- and the bit of
  a xor-fold is the parity of the count, which with the consistency decides is the parity of the intersection the mask
  form reads.  No sorry, no axiom, no native_decide.
-/
import Mathlib
import Aperanton.TorusL
import Aperanton.TorusLocal

namespace Aperanton

namespace TorusL

open Finset

/-! ## The bit of a xor-fold -/

theorem testBit_xorFold (l : List ℕ) (m : ℕ → ℕ) (j acc : ℕ) :
    Nat.testBit (l.foldl (fun acc p => acc ^^^ m p) acc) j
      = l.foldl (fun b p => xor b (Nat.testBit (m p) j)) (Nat.testBit acc j) := by
  induction l generalizing acc with
  | nil => rfl
  | cons p l ih =>
    simp only [List.foldl_cons]
    rw [ih, Nat.testBit_xor]

theorem bodd_eq_decide (n : ℕ) : Nat.bodd n = decide (n % 2 = 1) := by
  cases h : Nat.bodd n <;> simp [Nat.mod_two_of_bodd, h]

/-- a xor-fold of Bools is the parity of the count of trues -/
theorem foldl_xor_eq_parity (l : List ℕ) (f : ℕ → Bool) (b : Bool) :
    l.foldl (fun b p => xor b (f p)) b = xor b (Nat.bodd (l.filter f).length) := by
  induction l generalizing b with
  | nil => simp
  | cons p l ih =>
    simp only [List.foldl_cons]
    rw [ih]
    cases hf : f p
    · simp [List.filter_cons, hf]
    · simp [List.filter_cons, hf, Nat.bodd_succ, Bool.xor_assoc]

/-! ## The link's plaquettes, listed directly -/

/-- the step back in direction μ: that digit decreased modulo L -/
def stepM (L s mu : ℕ) : ℕ := s - coord L s mu * L ^ mu + ((coord L s mu + L - 1) % L) * L ^ mu

/-- the six plaquettes containing the link (μ, s): for each pair containing μ, the plaquette at s and the plaquette
a step back in the pair's other direction -/
def linkPlaqs (L mu s : ℕ) : List ℕ :=
  (List.range 6).flatMap (fun q =>
    if Torus4.pairMu q = mu then [plaq L q s, plaq L q (stepM L s (Torus4.pairNu q))]
    else if Torus4.pairNu q = mu then [plaq L q s, plaq L q (stepM L s (Torus4.pairMu q))]
    else [])

def linkPlaqsOf (L l : ℕ) : List ℕ := linkPlaqs L (l / V L) (l % V L)

/-- the links of a plaquette as a mask over the links -/
def plaqLinkMask (L p : ℕ) : ℕ := Torus4.maskOf (plaqLinks L (p / V L) (p % V L))

/-- CONSISTENCY, ONE WAY: every link of every plaquette is in range and lists the plaquette -/
abbrev C1 (L : ℕ) : Prop :=
  ((List.range (nPlaq L)).all (fun p => (plaqLinks L (p / V L) (p % V L)).all (fun l =>
    decide (l < nLinks L) && (linkPlaqsOf L l).contains p))) = true

/-- CONSISTENCY, THE OTHER WAY: every plaquette of every link is in range and lists the link -/
abbrev C2 (L : ℕ) : Prop :=
  ((List.range (nLinks L)).all (fun l => (linkPlaqsOf L l).all (fun p =>
    decide (p < nPlaq L) && (plaqLinks L (p / V L) (p % V L)).contains l))) = true

theorem mem_linkCobd_iff (L l p : ℕ) :
    p ∈ linkCobd L l ↔ p < nPlaq L ∧ l ∈ plaqLinks L (p / V L) (p % V L) := by
  unfold linkCobd
  simp [List.mem_filter]

theorem mem_linkPlaqs_iff (L : ℕ) (c1 : C1 L) (c2 : C2 L) (l : ℕ) (hl : l < nLinks L) (p : ℕ) :
    p ∈ linkPlaqsOf L l ↔ p < nPlaq L ∧ l ∈ plaqLinks L (p / V L) (p % V L) := by
  constructor
  · intro hp
    unfold C2 at c2
    rw [List.all_eq_true] at c2
    have h := c2 l (List.mem_range.mpr hl)
    rw [List.all_eq_true] at h
    have h := h p hp
    simpa using h
  · rintro ⟨hp, hlp⟩
    unfold C1 at c1
    rw [List.all_eq_true] at c1
    have h := c1 p (List.mem_range.mpr hp)
    rw [List.all_eq_true] at h
    have h := h l hlp
    have h' : l < nLinks L ∧ p ∈ linkPlaqsOf L l := by simpa using h
    exact h'.2

/-- THE COBOUNDARY MASK WITHOUT THE FILTER -/
theorem cobdMask_eq (L : ℕ) (c1 : C1 L) (c2 : C2 L) (l : ℕ) (hl : l < nLinks L) :
    cobdMask L l = Torus4.maskOf (linkPlaqsOf L l) := by
  unfold cobdMask
  apply Nat.eq_of_testBit_eq
  intro p
  rw [testBit_maskOf, testBit_maskOf, decide_eq_decide, mem_linkCobd_iff, mem_linkPlaqs_iff L c1 c2 l hl]

/-- the direct form of the coboundary masks -/
def cobdMasksD (L : ℕ) : List ℕ := (List.range (nLinks L)).map (fun l => Torus4.maskOf (linkPlaqsOf L l))

theorem cobdMasks_eq (L : ℕ) (c1 : C1 L) (c2 : C2 L) : cobdMasks L = cobdMasksD L := by
  unfold cobdMasks cobdMasksD
  apply List.map_congr_left
  intro l hl
  exact cobdMask_eq L c1 c2 l (List.mem_range.mp hl)

/-! ## The boundary of a boundary as a xor identity -/

/-- the xor over a cube's faces of their link masks is zero -/
abbrev DDX (L : ℕ) : Prop :=
  ((List.range (nCubes L)).all (fun k =>
    ((cubeFaces L (k / V L) (k % V L)).foldl (fun acc p => acc ^^^ plaqLinkMask L p) 0) == 0)) = true

/-- the parity of a list's members lying in a link's plaquettes, read as the bit of the xor of their link masks -/
theorem parity_eq_bit (L : ℕ) (c1 : C1 L) (c2 : C2 L) (A : List ℕ) (hlt : ∀ p ∈ A, p < nPlaq L)
    (l : ℕ) (hl : l < nLinks L) :
    decide ((A.filter (fun p => decide (p ∈ linkPlaqsOf L l))).length % 2 = 1)
      = Nat.testBit (A.foldl (fun acc p => acc ^^^ plaqLinkMask L p) 0) l := by
  have hfilt : A.filter (fun p => decide (p ∈ linkPlaqsOf L l))
      = A.filter (fun p => Nat.testBit (plaqLinkMask L p) l) := by
    apply List.filter_congr
    intro p hp
    rw [plaqLinkMask, testBit_maskOf, Bool.eq_iff_iff, decide_eq_true_iff, decide_eq_true_iff,
      mem_linkPlaqs_iff L c1 c2 l hl]
    exact ⟨fun h => h.2, fun h => ⟨hlt p hp, h⟩⟩
  rw [testBit_xorFold, Nat.zero_testBit, foldl_xor_eq_parity, Bool.false_xor, bodd_eq_decide, hfilt]

/-- THE MASK FORM OF ∂₂∂₃ = 0 FROM THE XOR IDENTITY -/
theorem dd_of_xor (L : ℕ) (c1 : C1 L) (c2 : C2 L) (hok : FacesOK L) (hx : DDX L) :
    ((cubeMasks L).all (fun c => (cobdMasks L).all (fun l => !(parAnd L c l)))) = true := by
  rw [List.all_eq_true]
  intro c hc
  rw [cubeMasks, List.mem_map] at hc
  obtain ⟨k, hk, rfl⟩ := hc
  rw [List.all_eq_true]
  intro m hm
  rw [cobdMasks, List.mem_map] at hm
  obtain ⟨l, hl, rfl⟩ := hm
  have hl' := List.mem_range.mp hl
  rw [cobdMask_eq L c1 c2 l hl']
  unfold cubeMask
  rw [parAnd_maskOf]
  unfold FacesOK at hok
  rw [List.all_eq_true] at hok
  have hk' := hok k hk
  rw [Bool.and_eq_true, decide_eq_true_eq, List.all_eq_true] at hk'
  have hnd : (cubeFaces L (k / V L) (k % V L)).Nodup := hk'.1
  have hlt : ∀ p ∈ cubeFaces L (k / V L) (k % V L), p < nPlaq L := fun p hp => by simpa using hk'.2 p hp
  rw [card_filter_fin_eq_length (nPlaq L) _ hnd hlt (fun p => p ∈ linkPlaqsOf L l),
    parity_eq_bit L c1 c2 _ hlt l hl']
  unfold DDX at hx
  rw [List.all_eq_true] at hx
  have hxk := hx k hk
  rw [beq_iff_eq] at hxk
  rw [hxk, Nat.zero_testBit]
  rfl

/-! ## The sheets' cyclicity as a xor identity -/

/-- the xor over a sheet's plaquettes of their link masks is zero -/
abbrev SHX (L : ℕ) : Prop :=
  ((List.range 6).all (fun q =>
    ((sheetList L q).foldl (fun acc p => acc ^^^ plaqLinkMask L p) 0) == 0)) = true

/-- THE MASK FORM OF THE SHEETS' CYCLICITY FROM THE XOR IDENTITY -/
theorem sheets_of_xor (L : ℕ) (c1 : C1 L) (c2 : C2 L) (hok : SheetsOK L) (hx : SHX L) :
    ((sheetMasks L).all (fun h => (cobdMasks L).all (fun l => !(parAnd L h l)))) = true := by
  rw [List.all_eq_true]
  intro c hc
  rw [sheetMasks, List.mem_map] at hc
  obtain ⟨q, hq, rfl⟩ := hc
  rw [List.all_eq_true]
  intro m hm
  rw [cobdMasks, List.mem_map] at hm
  obtain ⟨l, hl, rfl⟩ := hm
  have hl' := List.mem_range.mp hl
  rw [cobdMask_eq L c1 c2 l hl', sheetMask_eq_maskOf, parAnd_maskOf]
  unfold SheetsOK at hok
  rw [List.all_eq_true] at hok
  have hq' := hok q hq
  rw [Bool.and_eq_true, decide_eq_true_eq, List.all_eq_true] at hq'
  have hnd : (sheetList L q).Nodup := hq'.1
  have hlt : ∀ p ∈ sheetList L q, p < nPlaq L := fun p hp => by simpa using hq'.2 p hp
  rw [card_filter_fin_eq_length (nPlaq L) _ hnd hlt (fun p => p ∈ linkPlaqsOf L l),
    parity_eq_bit L c1 c2 _ hlt l hl']
  unfold SHX at hx
  rw [List.all_eq_true] at hx
  have hxq := hx q hq
  rw [beq_iff_eq] at hxq
  rw [hxq, Nat.zero_testBit]
  rfl

end TorusL

end Aperanton
