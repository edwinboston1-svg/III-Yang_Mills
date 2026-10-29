/-
  APERANTON -- THE BOUNDLESS, stage W5's counting lemma (ADDENDUM I, THE ROAD): THE FIBRES OF A LINEAR MAP OVER ITS
  RANGE ARE COSETS OF ITS KERNEL, ONE CARDINALITY -- so a sum over link configurations of a function of the plaquette
  field is the kernel's size times the sum over the plaquette code.

  THE LEMMA (`sum_comp_linear`): for a linear map δ : F₂^κ → F₂^ι and any F : F₂^ι → ℝ,
      Σ_σ F(δσ) = |ker δ| · Σ_{d ∈ range δ} F(d),
  by grouping the sum over σ by its image (`Finset.sum_comp`) and counting each fibre through the bijection
  k ↦ σ₀ + k from the kernel (`fibre_equiv_ker`).  It is what identifies a dual sector's enumerator ratio
  E_{h+s}/E_h (a sum over plaquette fields d ∈ D) with the Gibbs expectation over LINK configurations of the twisted
  factor system (a sum over σ with d = δσ): the constant |ker δ| cancels in the ratio.  Classical (W = 0); the
  earning is the executable bridge from the enumerator to the Gibbs measure Dobrushin's theorem reads.  No sorry, no
  axiom, no native_decide.
-/
import Mathlib

open Finset

namespace Aperanton

section Fibre

variable {κ ι : Type*} [Fintype κ] [DecidableEq κ] [Fintype ι] [DecidableEq ι]

/-- the fibre of δ over δ σ₀ is the translate of the kernel by σ₀ -/
def fibreEquivKer (δ : (κ → ZMod 2) →ₗ[ZMod 2] (ι → ZMod 2)) (σ₀ : κ → ZMod 2) :
    LinearMap.ker δ ≃ {σ : κ → ZMod 2 // δ σ = δ σ₀} where
  toFun k := ⟨σ₀ + k.1, by rw [map_add, LinearMap.mem_ker.mp k.2, add_zero]⟩
  invFun σ := ⟨σ.1 - σ₀, by rw [LinearMap.mem_ker, map_sub, σ.2, sub_self]⟩
  left_inv k := by
    apply Subtype.ext
    simp only [add_sub_cancel_left]
  right_inv σ := by
    apply Subtype.ext
    simp only [add_sub_cancel]

open Classical in
/-- every fibre over the range has the kernel's cardinality -/
theorem card_fibre (δ : (κ → ZMod 2) →ₗ[ZMod 2] (ι → ZMod 2)) (σ₀ : κ → ZMod 2) :
    (univ.filter (fun σ : κ → ZMod 2 => δ σ = δ σ₀)).card = Fintype.card (LinearMap.ker δ) := by
  classical
  rw [← Fintype.card_subtype]
  exact (Fintype.card_congr (fibreEquivKer δ σ₀)).symm

open Classical in
/-- the image of the whole space is the range, as finsets -/
theorem image_univ_eq_range (δ : (κ → ZMod 2) →ₗ[ZMod 2] (ι → ZMod 2)) :
    (univ : Finset (κ → ZMod 2)).image δ = univ.filter (· ∈ LinearMap.range δ) := by
  classical
  ext d
  simp only [Finset.mem_image, Finset.mem_univ, true_and, Finset.mem_filter, LinearMap.mem_range]

open Classical in
/-- THE FIBRE COUNT: Σ_σ F(δσ) = |ker δ| · Σ_{d ∈ range δ} F(d) -/
theorem sum_comp_linear (δ : (κ → ZMod 2) →ₗ[ZMod 2] (ι → ZMod 2)) (F : (ι → ZMod 2) → ℝ) :
    ∑ σ, F (δ σ) = (Fintype.card (LinearMap.ker δ) : ℝ) * ∑ d ∈ univ.filter (· ∈ LinearMap.range δ), F d := by
  classical
  rw [Finset.sum_comp, image_univ_eq_range, Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro d hd
  rw [Finset.mem_filter, LinearMap.mem_range] at hd
  obtain ⟨σ₀, rfl⟩ := hd.2
  rw [card_fibre δ σ₀, nsmul_eq_mul]

end Fibre

end Aperanton
