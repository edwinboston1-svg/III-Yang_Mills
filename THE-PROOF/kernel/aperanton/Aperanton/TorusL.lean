/-
  APERANTON -- THE BOUNDLESS, stage W6 (ADDENDUM I, THE ROAD): THE FOUR-TORUS OF ANY SIDE -- ITS CELLS, INCIDENCES,
  SHEETS AND CODES WITH THE SIDE L A PARAMETER, AND THE TWO BRIDGE LEMMAS (B1, B2) AT EVERY SIDE.

  Torus4.lean built the side-2 torus with bit arithmetic (a coordinate a bit, a step a flip); here a site s < L⁴ is
  read in base L (`coord`: its μ-th digit; `stepP`: that digit advanced modulo L), and every cell, incidence, mask and
  code of Torus4.lean is restated with L explicit -- at L = 2 the masks coincide digit for digit with Torus4's, which
  the side-L emitter re-run at L = 2 shows byte for byte against the side-2 certificate (a sighted control of the
  generalization).  B1 (`dot_vecOf`): the dot product of two mask vectors is the parity of their and, at every side
  (Bridge.lean's bit-sum lemma, generic in the width).  B2 (`D_le_orth_K`, `sheet_mem_orth_K`): from the facts
  ∂₂∂₃ = 0 and "the sheets are cycles" at a side -- hypotheses here, decided by each side's certificate
  (TorusLCert<L>.lean) -- the boundary code and the six sheets lie in the plaquette code's dual.  The sector split at
  a side is the proposition `TorusLSplit L`; TorusLBridge.lean proves it from a certificate's numbers.  W = 0 (the
  cubical complex of a torus); the earning is one geometry for every side.  No sorry, no axiom, no native_decide.
-/
import Mathlib
import Aperanton.Duality
import Aperanton.Torus4
import Aperanton.Echelon
import Aperanton.Bridge

open Finset Matrix

namespace Aperanton

namespace TorusL

/-! ## The cells of (ℤ/L)^4 -/

def V (L : ℕ) : ℕ := L ^ 4
def nLinks (L : ℕ) : ℕ := 4 * V L
def nPlaq (L : ℕ) : ℕ := 6 * V L
def nCubes (L : ℕ) : ℕ := 4 * V L

/-- the coordinate of a site in direction μ: the μ-th base-L digit of s -/
def coord (L s mu : ℕ) : ℕ := (s / L ^ mu) % L

/-- the step in direction μ: that digit advanced modulo L -/
def stepP (L s mu : ℕ) : ℕ := s - coord L s mu * L ^ mu + ((coord L s mu + 1) % L) * L ^ mu

def link (L mu s : ℕ) : ℕ := mu * V L + s
def plaq (L q s : ℕ) : ℕ := q * V L + s
def cube (L c s : ℕ) : ℕ := c * V L + s

/-- the four links of the plaquette (μν) at s: (μ, s), (ν, s + e_μ), (μ, s + e_ν), (ν, s) -/
def plaqLinks (L q s : ℕ) : List ℕ :=
  let mu := Torus4.pairMu q
  let nu := Torus4.pairNu q
  [link L mu s, link L nu (stepP L s mu), link L mu (stepP L s nu), link L nu s]

/-- the six faces of the cube (μνρ) at s -/
def cubeFaces (L c s : ℕ) : List ℕ :=
  let a := Torus4.tripA c
  let b := Torus4.tripB c
  let d := Torus4.tripC c
  [plaq L (Torus4.pairIdx a b) s, plaq L (Torus4.pairIdx a b) (stepP L s d),
   plaq L (Torus4.pairIdx a d) s, plaq L (Torus4.pairIdx a d) (stepP L s b),
   plaq L (Torus4.pairIdx b d) s, plaq L (Torus4.pairIdx b d) (stepP L s a)]

/-- the plaquettes containing a link: the coboundary δ¹ -/
def linkCobd (L l : ℕ) : List ℕ :=
  (List.range (nPlaq L)).filter (fun p => (plaqLinks L (p / V L) (p % V L)).contains l)

/-! ## Masks: one bit per plaquette -/

def cobdMask (L l : ℕ) : ℕ := Torus4.maskOf (linkCobd L l)
def cubeMask (L k : ℕ) : ℕ := Torus4.maskOf (cubeFaces L (k / V L) (k % V L))

/-- the sheet of the pair q: the (μν)-plaquettes at the two other coordinates zero -- L² plaquettes, a two-torus -/
def sheetMask (L q : ℕ) : ℕ :=
  let mu := Torus4.pairMu q
  let nu := Torus4.pairNu q
  Torus4.maskOf (((List.range (V L)).filter (fun s =>
    (List.range 4).all (fun d => d = mu || d = nu || coord L s d = 0))).map (fun s => plaq L q s))

def parAnd (L a b : ℕ) : Bool := Torus4.par (nPlaq L) (Nat.land a b)

def cobdMasks (L : ℕ) : List ℕ := (List.range (nLinks L)).map (cobdMask L)
def cubeMasks (L : ℕ) : List ℕ := (List.range (nCubes L)).map (cubeMask L)
def sheetMasks (L : ℕ) : List ℕ := (List.range 6).map (sheetMask L)

/-! ## The codes -/

/-- a mask as a vector of F₂^(6V) -/
def vecOf (L m : ℕ) : Fin (nPlaq L) → ZMod 2 := vecOfN (nPlaq L) m

/-- the plaquette code: the span of δ¹'s columns -/
def K (L : ℕ) : Submodule (ZMod 2) (Fin (nPlaq L) → ZMod 2) :=
  Submodule.span (ZMod 2) (Set.range (fun l : Fin (nLinks L) => vecOf L (cobdMask L l.val)))

/-- the boundary code: the span of ∂₃'s columns -/
def D (L : ℕ) : Submodule (ZMod 2) (Fin (nPlaq L) → ZMod 2) :=
  Submodule.span (ZMod 2) (Set.range (fun k : Fin (nCubes L) => vecOf L (cubeMask L k.val)))

/-- the span of the six sheets -/
def S (L : ℕ) : Submodule (ZMod 2) (Fin (nPlaq L) → ZMod 2) :=
  Submodule.span (ZMod 2) (Set.range (fun q : Fin 6 => vecOf L (sheetMask L q.val)))

/-- the 64 't Hooft twists: the sums of subsets of the six sheets -/
noncomputable def H (L : ℕ) : Finset (Fin (nPlaq L) → ZMod 2) :=
  (Finset.univ : Finset (Finset (Fin 6))).image (fun T => ∑ q ∈ T, vecOf L (sheetMask L q.val))

/-- the sector split of the four-torus of side L -/
def TorusLSplit (L : ℕ) : Prop := SectorSplit (K L) (D L) (H L)

/-! ## B1 and B2 at every side -/

/-- B1: THE DOT PRODUCT OF MASK VECTORS IS THE PARITY OF THE AND -/
theorem dot_vecOf (L a b : ℕ) : vecOf L a ⬝ᵥ vecOf L b = if parAnd L a b then 1 else 0 := by
  unfold vecOf vecOfN parAnd dotProduct
  have hpt : ∀ i : Fin (nPlaq L), (if Nat.testBit a i.val then (1 : ZMod 2) else 0)
      * (if Nat.testBit b i.val then (1 : ZMod 2) else 0)
      = if Nat.testBit (Nat.land a b) i.val then 1 else 0 := by
    intro i
    have hland : Nat.land a b = a &&& b := rfl
    rw [hland, Nat.testBit_land]
    cases Nat.testBit a i.val <;> cases Nat.testBit b i.val <;> simp
  simp_rw [hpt]
  exact sum_testBit_eq_par (nPlaq L) (Nat.land a b)

theorem parAnd_comm (L a b : ℕ) : parAnd L a b = parAnd L b a := by
  unfold parAnd
  show Torus4.par (nPlaq L) (a &&& b) = Torus4.par (nPlaq L) (b &&& a)
  rw [Nat.land_comm]

/-- a decided `List.all` over the mask lists reads as a statement about every pair -/
theorem parAnd_cube_cobd (L : ℕ)
    (hdd : ((cubeMasks L).all (fun c => (cobdMasks L).all (fun l => !(parAnd L c l)))) = true)
    (k l : ℕ) (hk : k < nCubes L) (hl : l < nLinks L) : parAnd L (cubeMask L k) (cobdMask L l) = false := by
  rw [List.all_eq_true] at hdd
  have hc : cubeMask L k ∈ cubeMasks L := List.mem_map.mpr ⟨k, List.mem_range.mpr hk, rfl⟩
  have h2 := hdd _ hc
  rw [List.all_eq_true] at h2
  have hl' : cobdMask L l ∈ cobdMasks L := List.mem_map.mpr ⟨l, List.mem_range.mpr hl, rfl⟩
  have h3 := h2 _ hl'
  simpa using h3

theorem parAnd_sheet_cobd (L : ℕ)
    (hsh : ((sheetMasks L).all (fun h => (cobdMasks L).all (fun l => !(parAnd L h l)))) = true)
    (q l : ℕ) (hq : q < 6) (hl : l < nLinks L) : parAnd L (sheetMask L q) (cobdMask L l) = false := by
  rw [List.all_eq_true] at hsh
  have hs : sheetMask L q ∈ sheetMasks L := List.mem_map.mpr ⟨q, List.mem_range.mpr hq, rfl⟩
  have h2 := hsh _ hs
  rw [List.all_eq_true] at h2
  have hl' : cobdMask L l ∈ cobdMasks L := List.mem_map.mpr ⟨l, List.mem_range.mpr hl, rfl⟩
  have h3 := h2 _ hl'
  simpa using h3

/-- B2 (first half): THE BOUNDARY CODE LIES IN THE PLAQUETTE CODE'S DUAL, at a side where ∂₂∂₃ = 0 is decided -/
theorem D_le_orth_K (L : ℕ)
    (hdd : ((cubeMasks L).all (fun c => (cobdMasks L).all (fun l => !(parAnd L c l)))) = true) :
    D L ≤ orth (K L) := by
  unfold D K
  rw [Submodule.span_le]
  rintro _ ⟨k, rfl⟩
  rw [SetLike.mem_coe, mem_orth_span_iff]
  rintro _ ⟨l, rfl⟩
  rw [dot_vecOf, parAnd_comm, parAnd_cube_cobd L hdd k.val l.val k.isLt l.isLt]
  simp

/-- B2 (second half): THE SIX SHEETS LIE IN THE PLAQUETTE CODE'S DUAL, at a side where they are decided cycles -/
theorem sheet_mem_orth_K (L : ℕ)
    (hsh : ((sheetMasks L).all (fun h => (cobdMasks L).all (fun l => !(parAnd L h l)))) = true)
    (q : Fin 6) : vecOf L (sheetMask L q.val) ∈ orth (K L) := by
  unfold K
  rw [mem_orth_span_iff]
  rintro _ ⟨l, rfl⟩
  rw [dot_vecOf, parAnd_comm, parAnd_sheet_cobd L hsh q.val l.val q.isLt l.isLt]
  simp

end TorusL

end Aperanton
