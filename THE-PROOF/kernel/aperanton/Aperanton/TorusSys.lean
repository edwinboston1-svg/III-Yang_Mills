/-
  APERANTON -- THE BOUNDLESS, stage W5 (ADDENDUM I, THE ROAD): THE DUAL SECTOR AS A FACTOR SYSTEM ON THE FOUR-TORUS.

  Weak.lean reads the vacuum sector of the Z₂ theory on T⁴₂ as a mixture of the DUAL sectors h + D at the dual
  coupling y*; a dual sector is an algebraic object there (a coset enumerator).  Here it is a GIBBS MEASURE: the
  dual lattice's links are the 64 cubes, its plaquettes the 96 plaquettes (each the face of four cubes), the
  twist h a shift on the factors, the coupling y* -- a `Z2Sys` (`torusSys`), the factor system Dobrushin's theorem
  reads.  THE PARITY IS THE DUAL COBOUNDARY (`par_eq`: shift plus δ*τ), THE WEIGHT IS y TO THE TWISTED FIELD'S WEIGHT
  (`W_eq_pow`), and THE FIBRE BRIDGE (`sum_W_eq`, from Fibre.lean's count): the sector's partition function over
  cube configurations is |ker δ*| times the coset enumerator at y, so THE SECTOR'S EXPECTATION OF THE SHIFT IS A
  GIBBS EXPECTATION (`sectorExp_eq_gibbs`) -- the constant cancels in the ratio.  THE ROW SUM (`rowsum_le`): a cube
  has six faces and each face three other cubes, so Dobrushin's row is at most 18·c₁(y), decided on the incidences
  (`shared_row`); the sector's interdependence is `torusSys`'s own (`Z2Sys.interdep`); the decay with distance is
  the side-L torus's, the side-2 torus having every pair of cubes within one step.  THE RANGE OF δ* IS TORUS4'S D
  (`range_cobdDual_eq_D`: each cube's column is its face mask, decided), so Weak.lean's sectors and these Gibbs
  measures are the same objects.  W = 0 (a Gibbs measure written as a factor system); the earning is the executable
  bridge.  No sorry, no axiom, no native_decide.
-/
import Mathlib
import Aperanton.Z2Slab
import Aperanton.Torus4
import Aperanton.Weak
import Aperanton.Fibre

open Finset

namespace Aperanton

namespace TorusSys

open Torus4

/-- the dual incidence: how many times plaquette i is a face of cube k (zero or one on the torus of side two) -/
def cubeMult (i : Fin nPlaq) (k : Fin nCubes) : ℕ := (cubeFaces (k.val / V) (k.val % V)).count i.val

/-- the dual theory's factor system on T⁴₂: sites the cubes, factors the plaquettes, the twist h, the coupling y -/
def torusSys (h : Fin nPlaq → ZMod 2) (y : ℝ) (hy0 : 0 < y) (hy1 : y ≤ 1) : Z2Sys (Fin nCubes) (Fin nPlaq) where
  mult i k := cubeMult i k
  shift := h
  y := y
  y_pos := hy0
  y_le := hy1

/-- the dual coboundary δ* : (cubes → F₂) → (plaquettes → F₂) -/
def cobdDual : (Fin nCubes → ZMod 2) →ₗ[ZMod 2] (Fin nPlaq → ZMod 2) where
  toFun τ := fun i => ∑ k, (cubeMult i k : ZMod 2) * τ k
  map_add' := by
    intro τ τ'
    funext i
    simp only [Pi.add_apply, mul_add, sum_add_distrib]
  map_smul' := by
    intro c τ
    funext i
    simp only [Pi.smul_apply, smul_eq_mul, RingHom.id_apply, mul_sum]
    refine sum_congr rfl fun k _ => ?_
    ring

/-- the configuration's additive reading -/
def toAddConf (ω : Fin nCubes → Z2) : Fin nCubes → ZMod 2 := fun k => Multiplicative.toAdd (ω k)

/-- the dual coboundary read at a plaquette: the sum over its cubes -/
theorem cobdDual_apply (τ : Fin nCubes → ZMod 2) (i : Fin nPlaq) :
    cobdDual τ i = ∑ k, (cubeMult i k : ZMod 2) * τ k := by
  simp [cobdDual]

/-- THE PARITY IS THE DUAL COBOUNDARY SHIFTED BY THE TWIST -/
theorem par_eq (h : Fin nPlaq → ZMod 2) (y : ℝ) (hy0 : 0 < y) (hy1 : y ≤ 1) (i : Fin nPlaq)
    (ω : Fin nCubes → Z2) : (torusSys h y hy0 hy1).par i ω = h i + cobdDual (toAddConf ω) i := by
  unfold Z2Sys.par
  rw [cobdDual_apply]
  rfl

/-- a product of y over the odd factors is y to their count -/
theorem prod_ite_eq_pow {n : Type*} [Fintype n] [DecidableEq n] (p : n → ZMod 2) (y : ℝ) :
    (∏ i, if p i = 1 then y else 1) = y ^ wt p := by
  rw [prod_ite, prod_const, prod_const_one, mul_one]
  congr 1
  unfold wt
  congr 1
  ext i
  simp only [mem_filter, mem_univ, true_and]
  rcases zmod2_cases (p i) with h0 | h1
  · rw [h0]; decide
  · rw [h1]; decide

/-- THE WEIGHT IS y TO THE WEIGHT OF THE TWISTED PLAQUETTE FIELD -/
theorem W_eq_pow (h : Fin nPlaq → ZMod 2) (y : ℝ) (hy0 : 0 < y) (hy1 : y ≤ 1) (ω : Fin nCubes → Z2) :
    (torusSys h y hy0 hy1).W ω = y ^ wt (h + cobdDual (toAddConf ω)) := by
  unfold Z2Sys.W Z2Sys.w
  rw [← prod_ite_eq_pow]
  rfl

/-- the additive reading is a bijection of configurations -/
def confEquiv : (Fin nCubes → Z2) ≃ (Fin nCubes → ZMod 2) where
  toFun := toAddConf
  invFun σ := fun k => Multiplicative.ofAdd (σ k)
  left_inv _ := rfl
  right_inv _ := rfl

theorem confEquiv_apply (ω : Fin nCubes → Z2) : confEquiv ω = toAddConf ω := rfl

open Classical in
/-- THE FIBRE BRIDGE: the sector's partition function over cube configurations is |ker δ*| times the coset
enumerator of the range of δ* at y -/
theorem sum_W_eq (h : Fin nPlaq → ZMod 2) (y : ℝ) (hy0 : 0 < y) (hy1 : y ≤ 1) :
    ∑ ω, (torusSys h y hy0 hy1).W ω =
      (Fintype.card (LinearMap.ker cobdDual) : ℝ) * enumAt (LinearMap.range cobdDual) h y := by
  simp only [W_eq_pow]
  rw [Fintype.sum_equiv confEquiv (fun ω => y ^ wt (h + cobdDual (toAddConf ω)))
    (fun σ => y ^ wt (h + cobdDual σ)) (fun ω => rfl)]
  rw [sum_comp_linear cobdDual (fun d => y ^ wt (h + d)), enumAt_eq_sum]

/-- the sector's expectation of the twist-shift observable -/
noncomputable def shiftObs (h s : Fin nPlaq → ZMod 2) (y : ℝ) (hy0 : 0 < y) (hy1 : y ≤ 1)
    (ω : Fin nCubes → Z2) : ℝ :=
  (torusSys (h + s) y hy0 hy1).W ω / (torusSys h y hy0 hy1).W ω

open Classical in
/-- THE SECTOR'S EXPECTATION IS A GIBBS EXPECTATION: E_{h+s}(y)/E_h(y) over the cube configurations -/
theorem sectorExp_eq_gibbs (h s : Fin nPlaq → ZMod 2) (y : ℝ) (hy0 : 0 < y) (hy1 : y ≤ 1) :
    sectorExp (LinearMap.range cobdDual) y h s =
      gibbs (torusSys h y hy0 hy1).W (shiftObs h s y hy0 hy1) := by
  unfold sectorExp gibbs shiftObs
  have hnum : ∑ ω, (torusSys h y hy0 hy1).W ω * ((torusSys (h + s) y hy0 hy1).W ω / (torusSys h y hy0 hy1).W ω)
      = ∑ ω, (torusSys (h + s) y hy0 hy1).W ω := by
    refine sum_congr rfl fun ω _ => ?_
    rw [← mul_div_assoc, mul_div_cancel_left₀ _ ((torusSys h y hy0 hy1).W_pos ω).ne']
  rw [hnum, sum_W_eq, sum_W_eq]
  have hk : (0 : ℝ) < Fintype.card (LinearMap.ker cobdDual) := by
    exact_mod_cast Fintype.card_pos_iff.mpr ⟨0⟩
  rw [mul_div_mul_left _ _ hk.ne']

/-- THE ROW SUM OF THE DUAL SYSTEM'S INCIDENCES IS EIGHTEEN: every cube shares a face with eighteen cube-slots
(six faces, three other cubes at each), decided on the incidences -/
theorem shared_row : ∀ s : Fin nCubes,
    ∑ t ∈ univ.erase s, ((univ.filter fun i : Fin nPlaq =>
      ((cubeMult i s : ℕ) : ZMod 2) = 1 ∧ ((cubeMult i t : ℕ) : ZMod 2) = 1).card) = 18 := by
  decide +kernel

/-- THE ROW SUM OF THE DUAL SYSTEM'S INTERDEPENDENCE IS AT MOST 18·c₁ -/
theorem rowsum_le (h : Fin nPlaq → ZMod 2) (y : ℝ) (hy0 : 0 < y) (hy1 : y ≤ 1) (s : Fin nCubes) :
    ∑ t, (torusSys h y hy0 hy1).C s t ≤ 18 * ((1 - y) / (1 + y)) := by
  set Z := torusSys h y hy0 hy1 with hZ
  have hc1 : 0 ≤ (1 - y) / (1 + y) := Z.c1_nonneg
  have hdiag : Z.C s s = 0 := by unfold Z2Sys.C; simp
  rw [← Finset.add_sum_erase Finset.univ _ (Finset.mem_univ s), hdiag, zero_add]
  have hoff : ∀ t ∈ Finset.univ.erase s, Z.C s t = (Z.shared s t : ℝ) * ((1 - y) / (1 + y)) := by
    intro t ht
    unfold Z2Sys.C
    rw [if_neg (Finset.ne_of_mem_erase ht).symm]
    rfl
  rw [Finset.sum_congr rfl hoff, ← Finset.sum_mul]
  apply mul_le_mul_of_nonneg_right _ hc1
  have h18 : ∑ t ∈ Finset.univ.erase s, Z.shared s t = 18 := shared_row s
  exact_mod_cast h18.le

/-- each cube's incidence column is its face mask, decided on the 64 × 96 incidences -/
theorem cubeMult_eq_vecOf : ∀ (k : Fin nCubes) (i : Fin nPlaq),
    ((cubeMult i k : ℕ) : ZMod 2) = vecOf (cubeMask k.val) i := by
  decide +kernel

/-- δ* on a cube's indicator is the cube's face mask -/
theorem cobdDual_single (k : Fin nCubes) : cobdDual (Pi.single k 1) = vecOf (cubeMask k.val) := by
  funext i
  show (∑ k', (cubeMult i k' : ZMod 2) * (Pi.single k (1 : ZMod 2) : Fin nCubes → ZMod 2) k') = _
  rw [Finset.sum_eq_single k (fun b _ hb => by rw [Pi.single_eq_of_ne hb, mul_zero])
    (fun hk => absurd (mem_univ k) hk), Pi.single_eq_same, mul_one]
  exact cubeMult_eq_vecOf k i

/-- THE RANGE OF δ* IS TORUS4'S BOUNDARY CODE D -/
theorem range_cobdDual_eq_D : LinearMap.range cobdDual = D := by
  apply le_antisymm
  · intro x hx
    obtain ⟨σ, rfl⟩ := LinearMap.mem_range.mp hx
    rw [← Finset.univ_sum_single σ, map_sum]
    refine Submodule.sum_mem _ fun k _ => ?_
    rcases zmod2_cases (σ k) with h0 | h1
    · rw [h0, Pi.single_zero, map_zero]
      exact Submodule.zero_mem _
    · rw [h1, cobdDual_single]
      exact Submodule.subset_span ⟨k, rfl⟩
  · apply Submodule.span_le.mpr
    rintro _ ⟨k, rfl⟩
    exact LinearMap.mem_range.mpr ⟨Pi.single k 1, cobdDual_single k⟩

end TorusSys

end Aperanton
