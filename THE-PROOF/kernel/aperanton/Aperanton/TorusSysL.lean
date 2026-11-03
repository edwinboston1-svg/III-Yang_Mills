/-
  APERANTON -- THE BOUNDLESS, stage W6 (ADDENDUM I, THE ROAD): THE DUAL SECTOR AS A FACTOR SYSTEM ON THE FOUR-TORUS OF
  ANY SIDE.

  TorusSys.lean read the side-2 dual sectors as Gibbs measures; here the side L is a parameter: the dual lattice's
  links are the 4V cubes, its plaquettes the 6V plaquettes, the twist h a shift, the coupling y -- `torusSys L`, a
  `Z2Sys`.  THE PARITY IS THE DUAL COBOUNDARY SHIFTED BY THE TWIST (`par_eq`), THE WEIGHT y TO THE TWISTED FIELD'S
  WEIGHT (`W_eq_pow`), THE FIBRE BRIDGE (`sum_W_eq`: the sector's partition function is |ker δ*| times Weak.lean's
  coset enumerator) and THE SECTOR'S EXPECTATION AS A GIBBS EXPECTATION (`sectorExp_eq_gibbs`).  THE ROW SUM at any
  side is a DOUBLE COUNT, not a decide over every pair of cubes: with every plaquette on four cubes (`hdeg`) and the
  cube s carrying six faces (`hsix`) -- two facts each side's instance decides, 6V·4V evaluations against the
  4V·4V·6V of the pairwise reading -- Σ_{t ≠ s} shared(s, t) = Σ_{i ∈ faces(s)} (4 − 1) = 18 (`shared_row_of`), so
  Dobrushin's row is at most 18·c₁(y) (`rowsum_le_of`), below one iff y > 17/19 at every side.  THE RANGE OF δ* IS
  THE BOUNDARY CODE D L (`range_cobdDual_eq_D`) from the decided column fact (`hcol`: each cube's column is its face
  mask).  W = 0 (a Gibbs measure written as a factor system); the earning is one system for every side.
  No sorry, no axiom, no native_decide.
-/
import Mathlib
import Aperanton.Z2Slab
import Aperanton.TorusL
import Aperanton.TorusLBridge
import Aperanton.Weak
import Aperanton.Fibre
import Aperanton.TorusSys

open Finset

namespace Aperanton

namespace TorusL

/-- the dual incidence at side L: how many times plaquette i is a face of cube k -/
def cubeMult (L : ℕ) (i : Fin (nPlaq L)) (k : Fin (nCubes L)) : ℕ :=
  (cubeFaces L (k.val / V L) (k.val % V L)).count i.val

/-- the dual theory's factor system on T⁴_L: sites the cubes, factors the plaquettes, the twist h, the coupling y -/
def torusSys (L : ℕ) (h : Fin (nPlaq L) → ZMod 2) (y : ℝ) (hy0 : 0 < y) (hy1 : y ≤ 1) :
    Z2Sys (Fin (nCubes L)) (Fin (nPlaq L)) where
  mult i k := cubeMult L i k
  shift := h
  y := y
  y_pos := hy0
  y_le := hy1

theorem torusSys_y (L : ℕ) (h : Fin (nPlaq L) → ZMod 2) (y : ℝ) (hy0 : 0 < y) (hy1 : y ≤ 1) :
    (torusSys L h y hy0 hy1).y = y := rfl

/-- the dual coboundary δ* : (cubes → F₂) → (plaquettes → F₂) at side L -/
def cobdDual (L : ℕ) : (Fin (nCubes L) → ZMod 2) →ₗ[ZMod 2] (Fin (nPlaq L) → ZMod 2) where
  toFun τ := fun i => ∑ k, (cubeMult L i k : ZMod 2) * τ k
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

/-- the dual coboundary read at a plaquette: the sum over its cubes -/
theorem cobdDual_apply (L : ℕ) (τ : Fin (nCubes L) → ZMod 2) (i : Fin (nPlaq L)) :
    cobdDual L τ i = ∑ k, (cubeMult L i k : ZMod 2) * τ k := by
  simp [cobdDual]

/-- the configuration's additive reading -/
def toAddConf (L : ℕ) (ω : Fin (nCubes L) → Z2) : Fin (nCubes L) → ZMod 2 := fun k => Multiplicative.toAdd (ω k)

/-- THE PARITY IS THE DUAL COBOUNDARY SHIFTED BY THE TWIST -/
theorem par_eq (L : ℕ) (h : Fin (nPlaq L) → ZMod 2) (y : ℝ) (hy0 : 0 < y) (hy1 : y ≤ 1) (i : Fin (nPlaq L))
    (ω : Fin (nCubes L) → Z2) : (torusSys L h y hy0 hy1).par i ω = h i + cobdDual L (toAddConf L ω) i := by
  unfold Z2Sys.par
  rw [cobdDual_apply]
  rfl

/-- THE WEIGHT IS y TO THE WEIGHT OF THE TWISTED PLAQUETTE FIELD -/
theorem W_eq_pow (L : ℕ) (h : Fin (nPlaq L) → ZMod 2) (y : ℝ) (hy0 : 0 < y) (hy1 : y ≤ 1)
    (ω : Fin (nCubes L) → Z2) : (torusSys L h y hy0 hy1).W ω = y ^ wt (h + cobdDual L (toAddConf L ω)) := by
  rw [← TorusSys.prod_ite_eq_pow]
  unfold Z2Sys.W
  refine Finset.prod_congr rfl fun i _ => ?_
  unfold Z2Sys.w
  rw [par_eq, Pi.add_apply, torusSys_y]

/-- the additive reading is a bijection of configurations -/
def confEquiv (L : ℕ) : (Fin (nCubes L) → Z2) ≃ (Fin (nCubes L) → ZMod 2) where
  toFun := toAddConf L
  invFun σ := fun k => Multiplicative.ofAdd (σ k)
  left_inv _ := rfl
  right_inv _ := rfl

theorem confEquiv_apply (L : ℕ) (ω : Fin (nCubes L) → Z2) : confEquiv L ω = toAddConf L ω := rfl

open Classical in
/-- THE FIBRE BRIDGE: the sector's partition function over cube configurations is |ker δ*| times the coset
enumerator of the range of δ* at y -/
theorem sum_W_eq (L : ℕ) (h : Fin (nPlaq L) → ZMod 2) (y : ℝ) (hy0 : 0 < y) (hy1 : y ≤ 1) :
    ∑ ω, (torusSys L h y hy0 hy1).W ω =
      (Fintype.card (LinearMap.ker (cobdDual L)) : ℝ) * enumAt (LinearMap.range (cobdDual L)) h y := by
  simp only [W_eq_pow]
  rw [Fintype.sum_equiv (confEquiv L) (fun ω => y ^ wt (h + cobdDual L (toAddConf L ω)))
    (fun σ => y ^ wt (h + cobdDual L σ)) (fun ω => rfl)]
  rw [sum_comp_linear (cobdDual L) (fun d => y ^ wt (h + d)), enumAt_eq_sum]

/-- the sector's expectation of the twist-shift observable -/
noncomputable def shiftObs (L : ℕ) (h s : Fin (nPlaq L) → ZMod 2) (y : ℝ) (hy0 : 0 < y) (hy1 : y ≤ 1)
    (ω : Fin (nCubes L) → Z2) : ℝ :=
  (torusSys L (h + s) y hy0 hy1).W ω / (torusSys L h y hy0 hy1).W ω

open Classical in
/-- THE SECTOR'S EXPECTATION IS A GIBBS EXPECTATION: E_{h+s}(y)/E_h(y) over the cube configurations -/
theorem sectorExp_eq_gibbs (L : ℕ) (h s : Fin (nPlaq L) → ZMod 2) (y : ℝ) (hy0 : 0 < y) (hy1 : y ≤ 1) :
    sectorExp (LinearMap.range (cobdDual L)) y h s =
      gibbs (torusSys L h y hy0 hy1).W (shiftObs L h s y hy0 hy1) := by
  unfold sectorExp gibbs shiftObs
  have hnum : ∑ ω, (torusSys L h y hy0 hy1).W ω *
      ((torusSys L (h + s) y hy0 hy1).W ω / (torusSys L h y hy0 hy1).W ω)
      = ∑ ω, (torusSys L (h + s) y hy0 hy1).W ω := by
    refine sum_congr rfl fun ω _ => ?_
    rw [← mul_div_assoc, mul_div_cancel_left₀ _ ((torusSys L h y hy0 hy1).W_pos ω).ne']
  rw [hnum, sum_W_eq, sum_W_eq]
  have hk : (0 : ℝ) < Fintype.card (LinearMap.ker (cobdDual L)) := by
    exact_mod_cast Fintype.card_pos_iff.mpr ⟨0⟩
  rw [mul_div_mul_left _ _ hk.ne']

/-! ## The row sum by a double count -/

/-- THE DOUBLE COUNT: with every plaquette on four cubes and the cube s carrying six faces,
Σ_{t ≠ s} |faces(s) ∩ faces(t)| = Σ_{i ∈ faces(s)} (4 − 1) = 18 -/
theorem shared_row_of (L : ℕ) (s : Fin (nCubes L))
    (hdeg : ∀ i : Fin (nPlaq L),
      (univ.filter (fun k : Fin (nCubes L) => ((cubeMult L i k : ℕ) : ZMod 2) = 1)).card = 4)
    (hsix : (univ.filter (fun i : Fin (nPlaq L) => ((cubeMult L i s : ℕ) : ZMod 2) = 1)).card = 6) :
    ∑ t ∈ univ.erase s, (univ.filter (fun i : Fin (nPlaq L) =>
      ((cubeMult L i s : ℕ) : ZMod 2) = 1 ∧ ((cubeMult L i t : ℕ) : ZMod 2) = 1)).card = 18 := by
  have hterm : ∀ t : Fin (nCubes L), (univ.filter (fun i : Fin (nPlaq L) =>
      ((cubeMult L i s : ℕ) : ZMod 2) = 1 ∧ ((cubeMult L i t : ℕ) : ZMod 2) = 1)).card
      = ∑ i : Fin (nPlaq L), if ((cubeMult L i s : ℕ) : ZMod 2) = 1 then
          (if ((cubeMult L i t : ℕ) : ZMod 2) = 1 then 1 else 0) else 0 := by
    intro t
    rw [Finset.card_filter]
    refine sum_congr rfl fun i _ => ?_
    by_cases h1 : ((cubeMult L i s : ℕ) : ZMod 2) = 1 <;>
      by_cases h2 : ((cubeMult L i t : ℕ) : ZMod 2) = 1 <;> simp [h1, h2]
  simp_rw [hterm]
  rw [Finset.sum_comm]
  have hcol : ∀ i : Fin (nPlaq L), (∑ t ∈ univ.erase s, if ((cubeMult L i s : ℕ) : ZMod 2) = 1 then
      (if ((cubeMult L i t : ℕ) : ZMod 2) = 1 then 1 else 0) else 0)
      = if ((cubeMult L i s : ℕ) : ZMod 2) = 1 then 3 else 0 := by
    intro i
    by_cases hA : ((cubeMult L i s : ℕ) : ZMod 2) = 1
    · simp only [if_pos hA]
      have h4 := hdeg i
      rw [Finset.card_filter, ← Finset.add_sum_erase univ _ (mem_univ s), if_pos hA] at h4
      omega
    · simp only [if_neg hA, Finset.sum_const_zero]
  simp_rw [hcol]
  rw [← Finset.sum_filter, Finset.sum_const, hsix]
  norm_num

/-- THE ROW SUM OF THE DUAL SYSTEM'S INTERDEPENDENCE IS AT MOST 18·c₁ AT ANY SIDE -/
theorem rowsum_le_of (L : ℕ) (h : Fin (nPlaq L) → ZMod 2) (y : ℝ) (hy0 : 0 < y) (hy1 : y ≤ 1) (s : Fin (nCubes L))
    (hdeg : ∀ i : Fin (nPlaq L),
      (univ.filter (fun k : Fin (nCubes L) => ((cubeMult L i k : ℕ) : ZMod 2) = 1)).card = 4)
    (hsix : (univ.filter (fun i : Fin (nPlaq L) => ((cubeMult L i s : ℕ) : ZMod 2) = 1)).card = 6) :
    ∑ t, (torusSys L h y hy0 hy1).C s t ≤ 18 * ((1 - y) / (1 + y)) := by
  set Z := torusSys L h y hy0 hy1 with hZ
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
  have h18 : ∑ t ∈ Finset.univ.erase s, Z.shared s t = 18 := shared_row_of L s hdeg hsix
  exact_mod_cast h18.le

/-! ## The range of the dual coboundary -/

/-- δ* on a cube's indicator is the cube's face mask, given the decided column fact -/
theorem cobdDual_single (L : ℕ)
    (hcol : ∀ (k : Fin (nCubes L)) (i : Fin (nPlaq L)), ((cubeMult L i k : ℕ) : ZMod 2) = vecOf L (cubeMask L k.val) i)
    (k : Fin (nCubes L)) : cobdDual L (Pi.single k 1) = vecOf L (cubeMask L k.val) := by
  funext i
  rw [cobdDual_apply, Finset.sum_eq_single k (fun b _ hb => by rw [Pi.single_eq_of_ne hb, mul_zero])
    (fun hk => absurd (mem_univ k) hk), Pi.single_eq_same, mul_one]
  exact hcol k i

/-- THE RANGE OF δ* IS THE BOUNDARY CODE D L -/
theorem range_cobdDual_eq_D (L : ℕ)
    (hcol : ∀ (k : Fin (nCubes L)) (i : Fin (nPlaq L)), ((cubeMult L i k : ℕ) : ZMod 2) = vecOf L (cubeMask L k.val) i) :
    LinearMap.range (cobdDual L) = D L := by
  apply le_antisymm
  · intro x hx
    obtain ⟨σ, rfl⟩ := LinearMap.mem_range.mp hx
    rw [← Finset.univ_sum_single σ, map_sum]
    refine Submodule.sum_mem _ fun k _ => ?_
    rcases zmod2_cases (σ k) with h0 | h1
    · rw [h0, Pi.single_zero, map_zero]
      exact Submodule.zero_mem _
    · rw [h1, cobdDual_single L hcol]
      exact Submodule.subset_span ⟨k, rfl⟩
  · apply Submodule.span_le.mpr
    rintro _ ⟨k, rfl⟩
    exact LinearMap.mem_range.mpr ⟨Pi.single k 1, cobdDual_single L hcol k⟩

end TorusL

end Aperanton
