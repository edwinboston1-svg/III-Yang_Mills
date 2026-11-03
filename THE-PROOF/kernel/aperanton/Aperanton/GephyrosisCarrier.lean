import Mathlib.Analysis.InnerProductSpace.PiL2
import Mathlib.Tactic

/-!
# ΓΕΦΥΡΩΣΙΣ — the finite carrier (Theorem F), the universal fluid (Theorem U) and the residual
gauge (Theorem R) of Addendum X, at their strength: classical, W = 0

* **Theorem F.** On a finite carrier every point value of the velocity field is a linear
  functional of the coefficients, hence bounded by a constant of the carrier times the energy
  norm (Cauchy–Schwarz). Bounded energy on `[0, 1)` therefore forbids unbounded velocity: the
  conjunction `{bounded energy, unbounded velocity}` of the forced blow-up lives in the completion
  alone.
* **Theorem U.** A fluid of `N` molecules of mass `m` with total kinetic energy `E` has every
  molecular speed at most `√(2E/m)`, and every cell average of the molecular velocities is bounded
  by the largest speed: the fluid that exists is a finite carrier.
* **Theorem R.** Any field `u` with any pressure `p` solves the forced equation with the force
  defined as its residual: the forced blow-up is a statement about the regularity class imposed
  on the force, and the unforced alternatives are the class `f ≡ 0`.

None of this is new mathematics (the equivalence of norms; `v² ≤ 2E/m`; a definition); it is the
frame's placement of the question, kept here so that the paper's section citing it points at a
checked statement.
-/

namespace Gephyrosis

/-! ## Theorem F -/

/-- A point value of a field on a finite carrier is a linear combination of the coordinates:
`u(x) = Σ_i w_i c_i`. Cauchy–Schwarz bounds it by `(Σ w_i²)^{1/2} ‖c‖₂`. -/
theorem pointValue_sq_le (n : ℕ) (w c : Fin n → ℝ) :
    (∑ i, w i * c i) ^ 2 ≤ (∑ i, w i ^ 2) * (∑ i, c i ^ 2) :=
  Finset.sum_mul_sq_le_sq_mul_sq Finset.univ w c

/-- **Theorem F (the finite-carrier no-go).** On a carrier with `n` degrees of freedom and point
functionals `w_x`, the sup over any family of points of `|u(x)|²` is at most
`C_n · ‖c‖₂²` with `C_n = sup_x Σ_i w_x(i)²`; so if the energy `‖c(t)‖₂²` stays below `E` on an
interval, every point value stays below `√(C_n E)` there. -/
theorem theoremF (n : ℕ) (W : Set (Fin n → ℝ)) (C : ℝ) (hC : ∀ w ∈ W, ∑ i, w i ^ 2 ≤ C)
    (c : Fin n → ℝ) (E : ℝ) (hE : ∑ i, c i ^ 2 ≤ E) :
    ∀ w ∈ W, (∑ i, w i * c i) ^ 2 ≤ C * E := by
  intro w hw
  calc (∑ i, w i * c i) ^ 2 ≤ (∑ i, w i ^ 2) * (∑ i, c i ^ 2) := pointValue_sq_le n w c
    _ ≤ C * E := by
      apply mul_le_mul (hC w hw) hE (Finset.sum_nonneg fun i _ => sq_nonneg _)
      have := hC w hw
      have : 0 ≤ ∑ i, w i ^ 2 := Finset.sum_nonneg fun i _ => sq_nonneg _
      linarith

/-- Theorem F read as a contrapositive: on a finite carrier, unbounded point values along a
sequence of states force unbounded energy. -/
theorem theoremF_contra (n : ℕ) (W : Set (Fin n → ℝ)) (C : ℝ) (hC : ∀ w ∈ W, ∑ i, w i ^ 2 ≤ C)
    (c : ℕ → Fin n → ℝ) (E : ℝ) (hE : ∀ t, ∑ i, c t i ^ 2 ≤ E) :
    ∀ t, ∀ w ∈ W, (∑ i, w i * c t i) ^ 2 ≤ C * E :=
  fun t => theoremF n W C hC (c t) E (hE t)

/-! ## Theorem U -/

/-- **Theorem U (the universal fluid).** `N` molecules of mass `m > 0` with velocities `v_i` and
kinetic energy `E = Σ ½ m v_i²`: every speed satisfies `v_i² ≤ 2E/m`, and any weighted average
of the velocities with nonnegative weights summing to one is bounded by the largest speed. -/
theorem theoremU_speed (N : ℕ) (m : ℝ) (hm : 0 < m) (v : Fin N → ℝ) (E : ℝ)
    (hE : E = ∑ i, (1 / 2) * m * v i ^ 2) (i : Fin N) : v i ^ 2 ≤ 2 * E / m := by
  have hle : (1 / 2) * m * v i ^ 2 ≤ E := by
    rw [hE]
    exact Finset.single_le_sum (f := fun j => (1 / 2) * m * v j ^ 2) (fun j _ => by positivity)
      (Finset.mem_univ i)
  rw [le_div_iff₀ hm]
  linarith

theorem theoremU_average (N : ℕ) (v : Fin N → ℝ) (a : Fin N → ℝ) (ha : ∀ i, 0 ≤ a i)
    (hsum : ∑ i, a i = 1) (S : ℝ) (hS : ∀ i, |v i| ≤ S) : |∑ i, a i * v i| ≤ S := by
  calc |∑ i, a i * v i| ≤ ∑ i, |a i * v i| := Finset.abs_sum_le_sum_abs _ _
    _ = ∑ i, a i * |v i| := by
      apply Finset.sum_congr rfl
      intro i _
      rw [abs_mul, abs_of_nonneg (ha i)]
    _ ≤ ∑ i, a i * S := by
      apply Finset.sum_le_sum
      intro i _
      exact mul_le_mul_of_nonneg_left (hS i) (ha i)
    _ = S := by rw [← Finset.sum_mul, hsum, one_mul]

/-! ## Theorem R -/

/-- A field with a time derivative, a transport term, a Laplacian and a pressure gradient, all
as given data on a type of points: the residual is `R = ∂ₜu + (u·∇)u − Δu + ∇p`. -/
def residual {X V : Type*} [AddCommGroup V] (dtu adv lap gradp : X → V) : X → V :=
  fun x => dtu x + adv x - lap x + gradp x

/-- The forced equation with force `f`: `∂ₜu + (u·∇)u − Δu + ∇p = f`. -/
def forcedEq {X V : Type*} [AddCommGroup V] (dtu adv lap gradp f : X → V) : Prop :=
  ∀ x, dtu x + adv x - lap x + gradp x = f x

/-- **Theorem R (the residual gauge).** Every field solves the forced equation with
`f := its residual`. -/
theorem theoremR {X V : Type*} [AddCommGroup V] (dtu adv lap gradp : X → V) :
    forcedEq dtu adv lap gradp (residual dtu adv lap gradp) :=
  fun _ => rfl

/-- The unforced equation is the class `f ≡ 0`: a field solves it iff its residual vanishes. -/
theorem unforced_iff {X V : Type*} [AddCommGroup V] (dtu adv lap gradp : X → V) :
    forcedEq dtu adv lap gradp (fun _ => 0) ↔ residual dtu adv lap gradp = fun _ => 0 := by
  constructor
  · intro h; funext x; exact h x
  · intro h x; exact congrFun h x

/-- The ordering of forced statements is the ordering of the classes imposed on the force:
if the admitted class `𝒞` is enlarged, every field whose residual lies in `𝒞` still qualifies. -/
theorem forced_class_mono {X V : Type*} [AddCommGroup V] (𝒞 𝒞' : Set (X → V)) (h : 𝒞 ⊆ 𝒞')
    (dtu adv lap gradp : X → V) (hr : residual dtu adv lap gradp ∈ 𝒞) :
    residual dtu adv lap gradp ∈ 𝒞' := h hr

end Gephyrosis
