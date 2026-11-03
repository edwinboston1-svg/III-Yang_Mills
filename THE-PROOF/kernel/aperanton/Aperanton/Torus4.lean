/-
  APERANTON -- THE BOUNDLESS, stage W4's instance (ADDENDUM I, THE ROAD): THE FOUR-TORUS OF SIDE TWO -- ITS CELLS,
  ITS INCIDENCES, ITS SIX SHEETS AND ITS RANKS, DECIDED IN THE KERNEL; THE SECTOR SPLIT AS THE STATED GOAL.

  THE CARRIER.  (ℤ/2)^4: 16 sites (the bits of s ∈ [0,16)), 64 links (μ, s), 96 plaquettes (q, s) with q one of the
  six pairs μ < ν, 64 cubes (c, s) with c one of the four triples, 16 four-cells.  A step in direction μ is the bit
  flip s xor 2^μ.  A plaquette's four links, a cube's six faces, a link's six plaquettes (`link_in_six`) are the
  cubical incidences; every cell set is a MASK, a natural number with one bit per plaquette, and every incidence
  question is a parity of a bitwise and -- GMP-accelerated in the kernel, FluxCore's method one dimension up.

  DECIDED HERE (the facts the split needs, each a `decide` on the masks): ∂₂∂₃ = 0 -- every cube's face mask is
  orthogonal to every link's coboundary mask (`dd_zero`, 64 × 64 parities); the six sheets -- the (μν)-plaquettes
  at the other two coordinates zero, each a two-torus of four plaquettes -- are 2-cycles (`sheets_cycle`); and
  THE RANKS by the xor-basis with ascending lowest-bit pivots (`rankMasks`; a reduced nonzero vector has no pivot
  bit, every nonzero span element has its least pivot bit, so the basis length is the F₂-rank of the span):
  rank δ¹ = 45 (`rank_cobd`), rank ∂₃ = 45 (`rank_bd3`), rank (∂₃ ∪ sheets) = 51 (`rank_bd3_sheets`) -- the
  predictions of the cellular chain complex of T⁴ with Betti numbers 1, 4, 6, 4, 1 over F₂ (dim Z₂ = 96 − 45 = 51,
  dim B₂ = 51 − 6 = 45), so a kernel reading of any other number convicts the definitions, not the torus.

  THE GOAL, STATED AND NOT ASSERTED (`Torus4Split`): `SectorSplit K D H` for K the plaquette code (the span of δ¹'s
  64 columns), D the boundary code (the span of ∂₃'s 64 columns) and H the 64 sums of subsets of the six sheets --
  the hypothesis under which `Duality.duality` reads Wegner's self-duality on this torus.  Its proof is
  `sectorSplit_of_card` with four BRIDGE LEMMAS, owed and named: (B1) `vecOf a ⬝ᵥ vecOf b = [parity (a ∧ b)]`, the
  dot product of mask vectors is the parity of the and (induction on the bits); (B2) D ≤ orth K from `dd_zero` and
  B1, and the sheets in orth K from `sheets_cycle` and B1; (B3) the rank of a mask list is the finrank of the span
  of its vectors (the xor-basis's correctness as a theorem, or the second road: ΜΕΙΖΩΝ's exact Smith form of the
  same incidence matrices, law 6); (B4) the cardinality |K^⊥| = 64 · |D| from B3 with `Module.card_eq_pow_finrank`
  and `LinearMap.BilinForm.finrank_add_finrank_orthogonal` on `dotForm` (MacWilliams.lean), the sheets' pairwise
  inequivalence from the rank jump 45 → 51.  The 2^51-member finsets are never enumerated.
  No sorry, no axiom, no native_decide.
-/
import Mathlib
import Aperanton.Duality

namespace Aperanton

namespace Torus4

/-! ## The cells of (ℤ/2)^4 -/

def V : Nat := 16
def nLinks : Nat := 64
def nPlaq : Nat := 96
def nCubes : Nat := 64

/-- the coordinate of a site in direction μ: the bit μ of s -/
def coord (s mu : Nat) : Nat := (s / 2 ^ mu) % 2

/-- the step in direction μ on the 2-torus is the bit flip -/
def stepP (s mu : Nat) : Nat := Nat.xor s (2 ^ mu)

/-- the six pairs μ < ν, indexed 0..5 -/
def pairMu (q : Nat) : Nat := if q < 3 then 0 else if q < 5 then 1 else 2
def pairNu (q : Nat) : Nat := if q = 0 then 1 else if q = 1 then 2 else if q = 2 then 3 else if q = 3 then 2 else 3
def pairIdx (mu nu : Nat) : Nat :=
  if mu = 0 then nu - 1 else if mu = 1 then nu + 1 else 5

/-- the four triples μ < ν < ρ, indexed 0..3: (0,1,2), (0,1,3), (0,2,3), (1,2,3) -/
def tripA (c : Nat) : Nat := if c < 3 then 0 else 1
def tripB (c : Nat) : Nat := if c < 2 then 1 else 2
def tripC (c : Nat) : Nat := if c = 0 then 2 else 3

def link (mu s : Nat) : Nat := mu * V + s
def plaq (q s : Nat) : Nat := q * V + s
def cube (c s : Nat) : Nat := c * V + s

/-- the four links of the plaquette (μν) at s: (μ, s), (ν, s + e_μ), (μ, s + e_ν), (ν, s) -/
def plaqLinks (q s : Nat) : List Nat :=
  let mu := pairMu q
  let nu := pairNu q
  [link mu s, link nu (stepP s mu), link mu (stepP s nu), link nu s]

/-- the six faces of the cube (μνρ) at s -/
def cubeFaces (c s : Nat) : List Nat :=
  let a := tripA c
  let b := tripB c
  let d := tripC c
  [plaq (pairIdx a b) s, plaq (pairIdx a b) (stepP s d),
   plaq (pairIdx a d) s, plaq (pairIdx a d) (stepP s b),
   plaq (pairIdx b d) s, plaq (pairIdx b d) (stepP s a)]

/-- the plaquettes containing a link: the coboundary δ¹ -/
def linkCobd (l : Nat) : List Nat :=
  (List.range nPlaq).filter (fun p => (plaqLinks (p / V) (p % V)).contains l)

/-! ## Masks: one bit per plaquette -/

def bitOf (i : Nat) : Nat := 1 <<< i
def maskOf (l : List Nat) : Nat := l.foldl (fun m i => Nat.lor m (bitOf i)) 0

def cobdMask (l : Nat) : Nat := maskOf (linkCobd l)
def cubeMask (k : Nat) : Nat := maskOf (cubeFaces (k / V) (k % V))

/-- the sheet of the pair q: the (μν)-plaquettes at the two other coordinates zero -- a two-torus, a 2-cycle -/
def sheetMask (q : Nat) : Nat :=
  let mu := pairMu q
  let nu := pairNu q
  maskOf (((List.range V).filter (fun s =>
    (List.range 4).all (fun d => d = mu || d = nu || coord s d = 0))).map (fun s => plaq q s))

/-- the parity of the number of set bits, bounded fuel -/
def par : Nat → Nat → Bool
  | 0, _ => false
  | k + 1, m => xor (decide (m % 2 = 1)) (par k (m / 2))

def parAnd (a b : Nat) : Bool := par nPlaq (Nat.land a b)

/-! ## The xor-basis with ascending lowest-bit pivots -/

def lowBit (v : Nat) : Nat := v - Nat.land v (v - 1)

def reduce (basis : List Nat) (v : Nat) : Nat :=
  basis.foldl (fun w b => if Nat.land w (lowBit b) != 0 then Nat.xor w b else w) v

def insertSorted (b : Nat) : List Nat → List Nat
  | [] => [b]
  | c :: cs => if lowBit b < lowBit c then b :: c :: cs else c :: insertSorted b cs

def xorBasis (vs : List Nat) : List Nat :=
  vs.foldl (fun basis v => let w := reduce basis v; if w == 0 then basis else insertSorted w basis) []

def rankMasks (vs : List Nat) : Nat := (xorBasis vs).length

def cobdMasks : List Nat := (List.range nLinks).map cobdMask
def cubeMasks : List Nat := (List.range nCubes).map cubeMask
def sheetMasks : List Nat := (List.range 6).map sheetMask

/-! ## The decided facts -/

/-- every link lies in six plaquettes; every plaquette has four links; every cube six faces -/
theorem link_in_six : ((List.range nLinks).all (fun l => (linkCobd l).length == 6)) = true := by
  decide +kernel
theorem plaq_four : ((List.range nPlaq).all (fun p => (plaqLinks (p / V) (p % V)).length == 4)) = true := by
  decide +kernel
theorem cube_six : ((List.range nCubes).all (fun k => (cubeFaces (k / V) (k % V)).length == 6)) = true := by
  decide +kernel

/-- ∂₂ ∂₃ = 0: every cube's faces meet every link's coboundary an even number of times -/
theorem dd_zero : (cubeMasks.all (fun c => cobdMasks.all (fun l => !(parAnd c l)))) = true := by decide +kernel

/-- the six sheets are 2-cycles -/
theorem sheets_cycle : (sheetMasks.all (fun h => cobdMasks.all (fun l => !(parAnd h l)))) = true := by decide +kernel

/-- the sheets are pairwise distinct and nonzero -/
theorem sheets_distinct : (sheetMasks.Nodup ∧ sheetMasks.all (fun h => h != 0)) := by decide +kernel

/-- THE RANKS: rank δ¹ = 45, rank ∂₃ = 45, rank (∂₃ ∪ sheets) = 51 -- the chain complex of T⁴ over F₂ -/
theorem rank_cobd : rankMasks cobdMasks = 45 := by decide +kernel
theorem rank_bd3 : rankMasks cubeMasks = 45 := by decide +kernel
theorem rank_bd3_sheets : rankMasks (cubeMasks ++ sheetMasks) = 51 := by decide +kernel

/-! ## The split as a stated goal -/

/-- a mask as a vector of F₂^96 -/
def vecOf (m : Nat) : Fin nPlaq → ZMod 2 := fun i => if Nat.testBit m i.val then 1 else 0

/-- the plaquette code: the span of δ¹'s columns -/
def K : Submodule (ZMod 2) (Fin nPlaq → ZMod 2) :=
  Submodule.span (ZMod 2) (Set.range (fun l : Fin nLinks => vecOf (cobdMask l.val)))

/-- the boundary code: the span of ∂₃'s columns -- the dual lattice's plaquette code -/
def D : Submodule (ZMod 2) (Fin nPlaq → ZMod 2) :=
  Submodule.span (ZMod 2) (Set.range (fun k : Fin nCubes => vecOf (cubeMask k.val)))

/-- the 64 't Hooft twists: the sums of subsets of the six sheets -/
noncomputable def H : Finset (Fin nPlaq → ZMod 2) :=
  (Finset.univ : Finset (Finset (Fin 6))).image (fun T => ∑ q ∈ T, vecOf (sheetMask q.val))

/-- THE GOAL: the sector split of the four-torus of side two, under which `duality` reads Wegner's self-duality
on it -- stated, not asserted; its proof is `sectorSplit_of_card` with the four bridge lemmas named in the header -/
def Torus4Split : Prop := SectorSplit K D H

end Torus4

end Aperanton
