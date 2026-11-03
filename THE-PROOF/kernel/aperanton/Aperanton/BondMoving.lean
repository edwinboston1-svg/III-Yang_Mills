import Mathlib

/-!
# BondMoving.lean -- THE TREK, W10: THE TWO ONE-SIDED BOUNDS A DECIMATION FLOW RESTS ON, IN THE KERNEL

A lattice gauge weight is Z(H) = sum_x w(x) exp(H(x)) over a finite configuration set with a nonnegative base weight w
(the product Haar measure on a finite group) and an action H = sum over plaquettes.  Splitting the plaquettes into two
families A and B (H = A + B), the two classical inequalities that make Migdal-Kadanoff "bond moving" a BOUND rather than
an approximation (Kadanoff 1976, Rev. Mod. Phys. 49; W = 0 for the mathematics, the kernel form ours):

  (upper)  Z(A + B)^2 <= Z(2A) * Z(2B)            -- Cauchy-Schwarz: the moved weight 2A on half the plaquettes and
                                                   0 on the other half bounds the true weight from above (when the
                                                   two halves give the same moved weight, Z(A + B) <= Z(2A));
  (lower)  Z(A + B) >= Z(2A) * exp(E_{2A}[B - A]) -- Jensen under the moved measure: the true weight is bounded from
                                                   below by the moved one times the exponential of the mean
                                                   correction.

Both are exact finite statements for ANY base weight w >= 0 with Z(2A) > 0 and any real actions, so they hold for every
group, every lattice, every family split, and every twisted sector (a twist is a sign on a plaquette's action, which is
just another H).  The flow instrument aperanton_mkflow.awk reads the flows these bounds justify.
No sorry, no axiom, no native_decide.
-/

namespace BondMoving

open Finset Real

variable {Ω : Type*} [Fintype Ω]

/-- the partition function of the action H under the base weight w -/
noncomputable def Z (w : Ω → ℝ) (H : Ω → ℝ) : ℝ := ∑ x, w x * Real.exp (H x)

theorem Z_nonneg (w : Ω → ℝ) (hw : ∀ x, 0 ≤ w x) (H : Ω → ℝ) : 0 ≤ Z w H := by
  unfold Z
  exact Finset.sum_nonneg (fun x _ => mul_nonneg (hw x) (Real.exp_pos _).le)

/-- exp (2a) = (exp a)^2 -/
theorem exp_two_mul_eq_sq (a : ℝ) : Real.exp (2 * a) = Real.exp a ^ 2 := by
  rw [sq, ← Real.exp_add]; congr 1; ring

/-- THE UPPER BOUND (Cauchy-Schwarz): Z(A + B)^2 <= Z(2A) Z(2B) -/
theorem Z_add_sq_le (w : Ω → ℝ) (hw : ∀ x, 0 ≤ w x) (A B : Ω → ℝ) :
    (Z w (fun x => A x + B x)) ^ 2 ≤ Z w (fun x => 2 * A x) * Z w (fun x => 2 * B x) := by
  unfold Z
  -- the two square roots: f = sqrt w * exp A, g = sqrt w * exp B
  have h1 : ∀ x, w x * Real.exp (A x + B x)
      = (Real.sqrt (w x) * Real.exp (A x)) * (Real.sqrt (w x) * Real.exp (B x)) := by
    intro x
    rw [Real.exp_add]
    have hs : Real.sqrt (w x) * Real.sqrt (w x) = w x := Real.mul_self_sqrt (hw x)
    calc w x * (Real.exp (A x) * Real.exp (B x))
        = (Real.sqrt (w x) * Real.sqrt (w x)) * (Real.exp (A x) * Real.exp (B x)) := by rw [hs]
      _ = (Real.sqrt (w x) * Real.exp (A x)) * (Real.sqrt (w x) * Real.exp (B x)) := by ring
  have h2 : ∀ x, w x * Real.exp (2 * A x) = (Real.sqrt (w x) * Real.exp (A x)) ^ 2 := by
    intro x
    have hs : Real.sqrt (w x) ^ 2 = w x := Real.sq_sqrt (hw x)
    calc w x * Real.exp (2 * A x) = Real.sqrt (w x) ^ 2 * Real.exp (A x) ^ 2 := by
            rw [exp_two_mul_eq_sq, hs]
      _ = (Real.sqrt (w x) * Real.exp (A x)) ^ 2 := by ring
  have h3 : ∀ x, w x * Real.exp (2 * B x) = (Real.sqrt (w x) * Real.exp (B x)) ^ 2 := by
    intro x
    have hs : Real.sqrt (w x) ^ 2 = w x := Real.sq_sqrt (hw x)
    calc w x * Real.exp (2 * B x) = Real.sqrt (w x) ^ 2 * Real.exp (B x) ^ 2 := by
            rw [exp_two_mul_eq_sq, hs]
      _ = (Real.sqrt (w x) * Real.exp (B x)) ^ 2 := by ring
  simp_rw [h1, h2, h3]
  exact Finset.sum_mul_sq_le_sq_mul_sq _ _ _

/-- the symmetric form: when the two halves give the same moved weight, Z(A + B) <= Z(2A) -/
theorem Z_add_le_of_eq (w : Ω → ℝ) (hw : ∀ x, 0 ≤ w x) (A B : Ω → ℝ)
    (hsym : Z w (fun x => 2 * A x) = Z w (fun x => 2 * B x)) :
    Z w (fun x => A x + B x) ≤ Z w (fun x => 2 * A x) := by
  have h := Z_add_sq_le w hw A B
  rw [← hsym, ← sq] at h
  have hZ := Z_nonneg w hw (fun x => A x + B x)
  have hZ2 := Z_nonneg w hw (fun x => 2 * A x)
  have hs := Real.sqrt_le_sqrt h
  rwa [Real.sqrt_sq hZ, Real.sqrt_sq hZ2] at hs

/-- THE LOWER BOUND (Jensen): Z(A + B) >= Z(2A) * exp(E_{2A}[B - A]), the mean under the moved measure w exp(2A)/Z(2A) -/
theorem Z_add_ge_jensen (w : Ω → ℝ) (hw : ∀ x, 0 ≤ w x) (A B : Ω → ℝ)
    (hpos : 0 < Z w (fun x => 2 * A x)) :
    Z w (fun x => 2 * A x) * Real.exp ((∑ x, w x * Real.exp (2 * A x) * (B x - A x)) / Z w (fun x => 2 * A x))
      ≤ Z w (fun x => A x + B x) := by
  set Z2 := Z w (fun x => 2 * A x) with hZ2
  have hne : Z2 ≠ 0 := hpos.ne'
  -- the probability weights p x = w x exp(2 A x) / Z2
  set p : Ω → ℝ := fun x => w x * Real.exp (2 * A x) / Z2 with hp
  have hp0 : ∀ x ∈ (Finset.univ : Finset Ω), 0 ≤ p x := by
    intro x _
    exact div_nonneg (mul_nonneg (hw x) (Real.exp_pos _).le) hpos.le
  have hp1 : ∑ x ∈ (Finset.univ : Finset Ω), p x = 1 := by
    have hsum : ∑ x, w x * Real.exp (2 * A x) = Z2 := by simp only [hZ2, Z]
    simp only [hp]
    rw [← Finset.sum_div, hsum]
    exact div_self hne
  -- Jensen for exp: exp (sum p_x t_x) <= sum p_x exp t_x
  have hJ := (convexOn_exp).map_sum_le hp0 hp1 (fun x _ => Set.mem_univ (B x - A x))
  -- identify the two sides
  have hmean : ∑ x, p x • (B x - A x)
      = (∑ x, w x * Real.exp (2 * A x) * (B x - A x)) / Z2 := by
    rw [Finset.sum_div]
    refine Finset.sum_congr rfl ?_
    intro x _
    simp only [hp, smul_eq_mul]
    ring
  have hright : ∑ x, p x • Real.exp (B x - A x) = Z w (fun x => A x + B x) / Z2 := by
    simp only [Z]
    rw [Finset.sum_div]
    refine Finset.sum_congr rfl ?_
    intro x _
    simp only [hp, smul_eq_mul]
    have he : Real.exp (2 * A x) * Real.exp (B x - A x) = Real.exp (A x + B x) := by
      rw [← Real.exp_add]; congr 1; ring
    calc w x * Real.exp (2 * A x) / Z2 * Real.exp (B x - A x)
        = w x * (Real.exp (2 * A x) * Real.exp (B x - A x)) / Z2 := by ring
      _ = w x * Real.exp (A x + B x) / Z2 := by rw [he]
  rw [hmean, hright] at hJ
  -- multiply through by Z2 > 0
  have hm := mul_le_mul_of_nonneg_left hJ hpos.le
  have hc : Z2 * (Z w (fun x => A x + B x) / Z2) = Z w (fun x => A x + B x) := by
    field_simp
  rw [hc] at hm
  exact hm

/-- the free-energy form of the upper bound: log Z(A + B) <= (log Z(2A) + log Z(2B)) / 2 -/
theorem log_Z_add_le (w : Ω → ℝ) (hw : ∀ x, 0 ≤ w x) (A B : Ω → ℝ)
    (hA : 0 < Z w (fun x => 2 * A x)) (hB : 0 < Z w (fun x => 2 * B x))
    (hAB : 0 < Z w (fun x => A x + B x)) :
    Real.log (Z w (fun x => A x + B x))
      ≤ (Real.log (Z w (fun x => 2 * A x)) + Real.log (Z w (fun x => 2 * B x))) / 2 := by
  have h := Z_add_sq_le w hw A B
  have hl := Real.log_le_log (pow_pos hAB 2) h
  rw [Real.log_pow, Real.log_mul hA.ne' hB.ne'] at hl
  push_cast at hl
  linarith

end BondMoving
