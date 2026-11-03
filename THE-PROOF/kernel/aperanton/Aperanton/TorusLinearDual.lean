/-
  APERANTON -- THE BOUNDLESS, THE EVERY-L STEP (2026-10-28): THE LINEAR GEOMETRY, THE DUAL FACTS -- the four facts the
  dual factor system needs at a side (every plaquette on four cubes, every cube with six faces, every cube's column its
  face mask, the adjacency along a wall) from decides LINEAR in the volume: the four cubes of a plaquette LISTED
  DIRECTLY (`plaqCubes`: for each triple containing the pair, the cube at the site and the cube a step back in the
  triple's third direction) and checked to be distinct members having the plaquette as a face; their COMPLETENESS by
  THE DOUBLE COUNT (the incidences counted by plaquette and by cube: Σ_p #cubes(p) = Σ_k #faces(k) = 6 · 4V = 4 · 6V, so
  four listed cubes each is four cubes each); the multiplicity read as membership (the faces distinct); and the
  adjacency over the listed cubes only.  No sorry, no axiom, no native_decide.
-/
import Mathlib
import Aperanton.TorusL
import Aperanton.TorusLocal
import Aperanton.TorusSysL
import Aperanton.TorusLevels
import Aperanton.TorusLinear

namespace Aperanton

namespace TorusL

open Finset

/-! ## The cubes of a plaquette, listed directly -/

def tripHas (c d : ℕ) : Bool :=
  decide (Torus4.tripA c = d) || decide (Torus4.tripB c = d) || decide (Torus4.tripC c = d)

/-- the direction of the triple c outside the pair (a, b) -/
def third (c a b : ℕ) : ℕ :=
  if Torus4.tripA c ≠ a ∧ Torus4.tripA c ≠ b then Torus4.tripA c
  else if Torus4.tripB c ≠ a ∧ Torus4.tripB c ≠ b then Torus4.tripB c else Torus4.tripC c

/-- the four cubes containing the plaquette (q, s): for each triple containing the pair, the cube at s and the cube a
step back in the triple's third direction -/
def plaqCubes (L q s : ℕ) : List ℕ :=
  (List.range 4).flatMap (fun c =>
    if tripHas c (Torus4.pairMu q) && tripHas c (Torus4.pairNu q) then
      [cube L c s, cube L c (stepM L s (third c (Torus4.pairMu q) (Torus4.pairNu q)))]
    else [])

def plaqCubesOf (L p : ℕ) : List ℕ := plaqCubes L (p / V L) (p % V L)

/-- every plaquette's listed cubes: four, distinct, in range, each having the plaquette as a face -/
abbrev PC (L : ℕ) : Prop :=
  ((List.range (nPlaq L)).all (fun p => decide ((plaqCubesOf L p).Nodup) && ((plaqCubesOf L p).length == 4) &&
    (plaqCubesOf L p).all (fun k => decide (k < nCubes L) && (cubeFaces L (k / V L) (k % V L)).contains p))) = true

/-- every cube has six faces -/
abbrev CubeSix (L : ℕ) : Prop :=
  ((List.range (nCubes L)).all (fun k => (cubeFaces L (k / V L) (k % V L)).length == 6)) = true

/-- the adjacency over the listed cubes: a cube's level against the levels of the cubes of each of its faces -/
abbrev AdjInc (L mu : ℕ) : Prop :=
  ((List.range (nCubes L)).all (fun k => (cubeFaces L (k / V L) (k % V L)).all (fun i =>
    (plaqCubesOf L i).all (fun k' => decide (levelN L mu k' ≤ levelN L mu k + 1))))) = true

/-! ## The faces, read -/

theorem facesOK_at (L : ℕ) (hok : FacesOK L) (k : ℕ) (hk : k < nCubes L) :
    (cubeFaces L (k / V L) (k % V L)).Nodup ∧ ∀ p ∈ cubeFaces L (k / V L) (k % V L), p < nPlaq L := by
  unfold FacesOK at hok
  rw [List.all_eq_true] at hok
  have h := hok k (List.mem_range.mpr hk)
  rw [Bool.and_eq_true, decide_eq_true_eq, List.all_eq_true] at h
  exact ⟨h.1, fun p hp => by simpa using h.2 p hp⟩

theorem cubeSix_at (L : ℕ) (h6 : CubeSix L) (k : ℕ) (hk : k < nCubes L) :
    (cubeFaces L (k / V L) (k % V L)).length = 6 := by
  unfold CubeSix at h6
  rw [List.all_eq_true] at h6
  have h := h6 k (List.mem_range.mpr hk)
  simpa using h

/-- the multiplicity modulo two is the membership, the faces being distinct -/
theorem cubeMult_mod_two (L : ℕ) (hok : FacesOK L) (i : Fin (nPlaq L)) (k : Fin (nCubes L)) :
    (((cubeMult L i k : ℕ) : ZMod 2) = 1) ↔ i.val ∈ cubeFaces L (k.val / V L) (k.val % V L) := by
  have hnd := (facesOK_at L hok k.val k.isLt).1
  unfold cubeMult
  by_cases hm : i.val ∈ cubeFaces L (k.val / V L) (k.val % V L)
  · rw [List.count_eq_one_of_mem hnd hm]
    simp [hm]
  · rw [List.count_eq_zero_of_not_mem hm]
    simp [hm]

/-- a nodup list's members below the width, counted as a Fin-filter card -/
theorem card_filter_mem (n : ℕ) (A : List ℕ) (hnd : A.Nodup) (hlt : ∀ a ∈ A, a < n) :
    (univ.filter (fun p : Fin n => p.val ∈ A)).card = A.length := by
  have := card_filter_fin_eq_length n A hnd hlt (fun _ => True)
  simpa using this

/-! ## The six faces and the column -/

theorem hsix_of (L : ℕ) (hok : FacesOK L) (h6 : CubeSix L) (s : Fin (nCubes L)) :
    (univ.filter (fun i : Fin (nPlaq L) => ((cubeMult L i s : ℕ) : ZMod 2) = 1)).card = 6 := by
  obtain ⟨hnd, hlt⟩ := facesOK_at L hok s.val s.isLt
  rw [Finset.filter_congr (fun i _ => cubeMult_mod_two L hok i s), card_filter_mem (nPlaq L) _ hnd hlt]
  exact cubeSix_at L h6 s.val s.isLt

theorem hcol_of (L : ℕ) (hok : FacesOK L) (k : Fin (nCubes L)) (i : Fin (nPlaq L)) :
    ((cubeMult L i k : ℕ) : ZMod 2) = vecOf L (cubeMask L k.val) i := by
  have hnd := (facesOK_at L hok k.val k.isLt).1
  unfold vecOf cubeMask cubeMult
  rw [vecOfN_apply, testBit_maskOf]
  by_cases hm : i.val ∈ cubeFaces L (k.val / V L) (k.val % V L)
  · rw [List.count_eq_one_of_mem hnd hm]
    simp [hm]
  · rw [List.count_eq_zero_of_not_mem hm]
    simp [hm]

/-! ## The four cubes, by the double count -/

/-- the cubes having a given plaquette as a face are exactly four -/
theorem card_cubes_eq_four (L : ℕ) (hok : FacesOK L) (h6 : CubeSix L) (hpc : PC L) (i : Fin (nPlaq L)) :
    (univ.filter (fun k : Fin (nCubes L) => i.val ∈ cubeFaces L (k.val / V L) (k.val % V L))).card = 4 := by
  set a : Fin (nPlaq L) → ℕ := fun i =>
    (univ.filter (fun k : Fin (nCubes L) => i.val ∈ cubeFaces L (k.val / V L) (k.val % V L))).card with ha
  show a i = 4
  have hlow : ∀ i : Fin (nPlaq L), 4 ≤ a i := by
    intro i
    unfold PC at hpc
    rw [List.all_eq_true] at hpc
    have hp := hpc i.val (List.mem_range.mpr i.isLt)
    simp only [Bool.and_eq_true, decide_eq_true_eq, beq_iff_eq, List.all_eq_true] at hp
    obtain ⟨⟨hnd, hlen⟩, hmem⟩ := hp
    have hsub : (univ.filter (fun k : Fin (nCubes L) => k.val ∈ plaqCubesOf L i.val)) ⊆
        (univ.filter (fun k : Fin (nCubes L) => i.val ∈ cubeFaces L (k.val / V L) (k.val % V L))) := by
      intro k hk
      rw [Finset.mem_filter] at hk ⊢
      refine ⟨hk.1, ?_⟩
      have := (hmem k.val hk.2).2
      simpa using this
    have hcard := card_filter_mem (nCubes L) (plaqCubesOf L i.val) hnd (fun k hk => (hmem k hk).1)
    rw [hlen] at hcard
    calc 4 = _ := hcard.symm
      _ ≤ a i := Finset.card_le_card hsub
  have hsum : ∑ i : Fin (nPlaq L), a i
      = ∑ k : Fin (nCubes L), (cubeFaces L (k.val / V L) (k.val % V L)).length := by
    simp only [ha, Finset.card_filter]
    rw [Finset.sum_comm]
    apply Finset.sum_congr rfl
    intro k _
    obtain ⟨hnd, hlt⟩ := facesOK_at L hok k.val k.isLt
    rw [← Finset.card_filter, card_filter_mem (nPlaq L) _ hnd hlt]
  have h6' : ∀ k : Fin (nCubes L), (cubeFaces L (k.val / V L) (k.val % V L)).length = 6 :=
    fun k => cubeSix_at L h6 k.val k.isLt
  simp only [h6', Finset.sum_const, Finset.card_univ, Fintype.card_fin, smul_eq_mul] at hsum
  have htot : ∑ i : Fin (nPlaq L), (4 : ℕ) = ∑ i : Fin (nPlaq L), a i := by
    rw [hsum]
    simp only [Finset.sum_const, Finset.card_univ, Fintype.card_fin, smul_eq_mul]
    unfold nPlaq nCubes
    ring
  exact ((Finset.sum_eq_sum_iff_of_le (fun i _ => hlow i)).mp htot i (Finset.mem_univ i)).symm

theorem hdeg_of (L : ℕ) (hok : FacesOK L) (h6 : CubeSix L) (hpc : PC L) (i : Fin (nPlaq L)) :
    (univ.filter (fun k : Fin (nCubes L) => ((cubeMult L i k : ℕ) : ZMod 2) = 1)).card = 4 := by
  rw [Finset.filter_congr (fun k _ => cubeMult_mod_two L hok i k)]
  exact card_cubes_eq_four L hok h6 hpc i

/-- THE LISTED CUBES ARE ALL THE CUBES: a cube having the plaquette as a face is among its four -/
theorem plaqCubes_complete (L : ℕ) (hok : FacesOK L) (h6 : CubeSix L) (hpc : PC L) (i : Fin (nPlaq L))
    (k : Fin (nCubes L)) (hm : i.val ∈ cubeFaces L (k.val / V L) (k.val % V L)) :
    k.val ∈ plaqCubesOf L i.val := by
  have hpc' := hpc
  unfold PC at hpc'
  rw [List.all_eq_true] at hpc'
  have hp := hpc' i.val (List.mem_range.mpr i.isLt)
  simp only [Bool.and_eq_true, decide_eq_true_eq, beq_iff_eq, List.all_eq_true] at hp
  obtain ⟨⟨hnd, hlen⟩, hmem⟩ := hp
  have hsub : (univ.filter (fun k : Fin (nCubes L) => k.val ∈ plaqCubesOf L i.val)) ⊆
      (univ.filter (fun k : Fin (nCubes L) => i.val ∈ cubeFaces L (k.val / V L) (k.val % V L))) := by
    intro k hk
    rw [Finset.mem_filter] at hk ⊢
    refine ⟨hk.1, ?_⟩
    have := (hmem k.val hk.2).2
    simpa using this
  have hcardB := card_filter_mem (nCubes L) (plaqCubesOf L i.val) hnd (fun k hk => (hmem k hk).1)
  rw [hlen] at hcardB
  have hcardA := card_cubes_eq_four L hok h6 hpc i
  have heq := Finset.eq_of_subset_of_card_le hsub (by rw [hcardA, hcardB])
  have hkA : k ∈ (univ.filter (fun k : Fin (nCubes L) => i.val ∈ cubeFaces L (k.val / V L) (k.val % V L))) :=
    Finset.mem_filter.mpr ⟨Finset.mem_univ _, hm⟩
  rw [← heq, Finset.mem_filter] at hkA
  exact hkA.2

/-! ## The adjacency from the listed cubes -/

theorem adjList_of (L mu : ℕ) (hok : FacesOK L) (h6 : CubeSix L) (hpc : PC L) (hinc : AdjInc L mu) :
    AdjList L mu := by
  unfold AdjList
  rw [List.all_eq_true]
  intro k hk
  rw [List.all_eq_true]
  intro i hi
  rw [List.all_eq_true]
  intro k' hk'
  rw [Bool.or_eq_true, Bool.not_eq_true', decide_eq_false_iff_not, decide_eq_true_eq]
  by_cases hm : i ∈ cubeFaces L (k' / V L) (k' % V L)
  · right
    have hkl := List.mem_range.mp hk
    have hk'l := List.mem_range.mp hk'
    have hil : i < nPlaq L := (facesOK_at L hok k hkl).2 i hi
    have hk'mem : k' ∈ plaqCubesOf L i :=
      plaqCubes_complete L hok h6 hpc ⟨i, hil⟩ ⟨k', hk'l⟩ hm
    unfold AdjInc at hinc
    rw [List.all_eq_true] at hinc
    have h1 := hinc k hk
    rw [List.all_eq_true] at h1
    have h2 := h1 i hi
    rw [List.all_eq_true] at h2
    have h3 := h2 k' hk'mem
    simpa using h3
  · left
    exact hm

end TorusL

end Aperanton
