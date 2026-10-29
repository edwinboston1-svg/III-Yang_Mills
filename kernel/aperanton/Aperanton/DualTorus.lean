/-
  APERANTON -- THE BOUNDLESS, stage W4's geometry (ADDENDUM I, THE ROAD): THE SELF-DUALITY OF THE FOUR-TORUS OF SIDE
  TWO, DECIDED.

  The dual lattice of the 2⁴ torus is the 2⁴ torus again: dual sites at the cube centres, a dual link through every
  cube in the direction its triple leaves out, a dual plaquette through every plaquette in the complementary pair of
  directions, a dual cube around every link.  In the site indexing of Torus4.lean the maps are integers: the pair
  q ↦ 5 − q (the complementary pairs are {0,1}|{2,3}, {0,2}|{1,3}, {0,3}|{1,2}), the triple c ↦ the direction 3 − c,
  and a dual cell's site is the original's with the bits of the complementary directions flipped (`dualPlaq`,
  `dualLinkOfCube`, `dualCubeOfLink`).  THE THEOREM (`cobd_dual`, `cube_dual`), decided by the kernel on the 64 + 64
  masks: the coboundary of every link, read through the plaquette map, is the face set of its dual cube, and the face
  set of every cube is the coboundary of its dual link -- so the dual theory's plaquette code (the span of the cube
  faces, `D` of Torus4.lean) is the original plaquette code `K` read in the dual coordinates: Wegner's self-duality of
  the four-dimensional Z₂ gauge theory at the level of the cells, which the dual enumerators of `Duality.lean` need in
  order to be the enumerators of the same theory at the dual coupling.  The plaquette map is a permutation of the 96
  plaquettes (`dualPlaq_lt`, `dualPlaq_nodup`); its square is the translation by every direction, not the identity.
  Classical (Wegner 1971; W = 0); the earning is the decided instance.  No sorry, no axiom, no native_decide.
-/
import Mathlib
import Aperanton.Torus4

namespace Aperanton

namespace Torus4

/-- the complementary pair of directions: q ↦ 5 − q -/
def dualPair (q : Nat) : Nat := 5 - q

/-- the dual plaquette of (q, s): the complementary pair at the site with that pair's bits flipped -/
def dualPlaq (p : Nat) : Nat :=
  plaq (dualPair (p / V)) (stepP (stepP (p % V) (pairMu (dualPair (p / V)))) (pairNu (dualPair (p / V))))

/-- the dual link of the cube (c, s): the direction the triple leaves out, at the site stepped in it -/
def dualLinkOfCube (k : Nat) : Nat := link (3 - k / V) (stepP (k % V) (3 - k / V))

/-- the dual cube of the link (μ, s): the triple leaving μ out, at the site with the other three bits flipped -/
def dualCubeOfLink (l : Nat) : Nat := cube (3 - l / V) (Nat.xor (l % V) (15 - 2 ^ (l / V)))

/-- a mask transported bit by bit through a map of plaquettes -/
def maskMap (f : Nat → Nat) (m : Nat) : Nat :=
  maskOf (((List.range nPlaq).filter (fun p => Nat.testBit m p)).map f)

/-- the dual plaquette map stays below 96 -/
theorem dualPlaq_lt : ∀ p ∈ List.range nPlaq, dualPlaq p < nPlaq := by decide +kernel

/-- and is injective: a permutation of the 96 plaquettes -/
theorem dualPlaq_nodup : ((List.range nPlaq).map dualPlaq).Nodup := by decide +kernel

/-- the dual link map is a permutation of the 64 links -/
theorem dualLinkOfCube_lt : ∀ k ∈ List.range nCubes, dualLinkOfCube k < nLinks := by decide +kernel
theorem dualLinkOfCube_nodup : ((List.range nCubes).map dualLinkOfCube).Nodup := by decide +kernel

/-- the dual cube map is a permutation of the 64 cubes -/
theorem dualCubeOfLink_lt : ∀ l ∈ List.range nLinks, dualCubeOfLink l < nCubes := by decide +kernel
theorem dualCubeOfLink_nodup : ((List.range nLinks).map dualCubeOfLink).Nodup := by decide +kernel

/-- THE SELF-DUALITY, DECIDED: the coboundary of every link transports to the faces of its dual cube -/
theorem cobd_dual : ∀ l ∈ List.range nLinks, maskMap dualPlaq (cobdMask l) = cubeMask (dualCubeOfLink l) := by
  decide +kernel

/-- and the faces of every cube transport to the coboundary of its dual link -/
theorem cube_dual : ∀ k ∈ List.range nCubes, maskMap dualPlaq (cubeMask k) = cobdMask (dualLinkOfCube k) := by
  decide +kernel

end Torus4

end Aperanton
