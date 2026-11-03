import Aperanton.GephyrosisOrbit

/-!
# ΓΕΦΥΡΩΣΙΣ — energy conservation as an identity of the tensor (Theorem O's exact form)

The Galerkin nonlinearity conserves energy: `Σ_k c_k Q_k(c) = 0` identically, because the cubic
form `Σ_{a,b,k} TX[a][b][k] c_a c_b c_k` has a symmetrisation that vanishes on every triple —
a finite fact about the tensor, decided here by the kernel for the 2D box `K = 2` (and the
enstrophy-weighted form `Σ_k |k|² c_k Q_k(c)`, which vanishes in two dimensions and not in three).

With it, the exact identity of Addendum VI §5 follows for every step: multiplying the
Galerkin–Euler step `c'_k = (1 − |k|²) c_k − Q_k(c)/D_k` by `D_k c_k` and summing,

  `Σ_k D_k c_k c'_k = Σ_k D_k (1 − |k|²) c_k²`   (E)

— the energy form of consecutive states, with no trace of the nonlinearity. Read at a prime it is
Theorem O: the leading digits of consecutive steps are orthogonal for the energy form.
-/

namespace Gephyrosis

/-- The cubic form of a tensor `T` on `Fin n`: `Σ_{a,b,k} T a b k · x_a x_b x_k`. -/
def cubic {n : ℕ} (T : Fin n → Fin n → Fin n → ℚ) (x : Fin n → ℚ) : ℚ :=
  ∑ a, ∑ b, ∑ k, T a b k * (x a * x b * x k)

/-- The symmetrisation over the six orderings of a triple. -/
def symT {n : ℕ} (T : Fin n → Fin n → Fin n → ℚ) (a b k : Fin n) : ℚ :=
  T a b k + T a k b + T b a k + T b k a + T k a b + T k b a

theorem cubic_swap_ab {n : ℕ} (T : Fin n → Fin n → Fin n → ℚ) (x : Fin n → ℚ) :
    cubic (fun a b k => T b a k) x = cubic T x := by
  unfold cubic
  rw [Finset.sum_comm]
  refine Finset.sum_congr rfl fun b _ => Finset.sum_congr rfl fun a _ =>
    Finset.sum_congr rfl fun k _ => ?_
  ring

theorem cubic_swap_bk {n : ℕ} (T : Fin n → Fin n → Fin n → ℚ) (x : Fin n → ℚ) :
    cubic (fun a b k => T a k b) x = cubic T x := by
  unfold cubic
  refine Finset.sum_congr rfl fun a _ => ?_
  rw [Finset.sum_comm]
  refine Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun b _ => ?_
  ring

/-- Every ordering of the indices gives the same cubic form. -/
theorem cubic_perm_sum {n : ℕ} (T : Fin n → Fin n → Fin n → ℚ) (x : Fin n → ℚ) :
    cubic (fun a b k => symT T a b k) x = 6 * cubic T x := by
  have e1 : cubic (fun a b k => T a k b) x = cubic T x := cubic_swap_bk T x
  have e2 : cubic (fun a b k => T b a k) x = cubic T x := cubic_swap_ab T x
  have e3 : cubic (fun a b k => T b k a) x = cubic T x := by
    have := cubic_swap_ab (fun a b k => T a k b) x
    rw [e1] at this
    exact this
  have e4 : cubic (fun a b k => T k a b) x = cubic T x := by
    have := cubic_swap_bk (fun a b k => T b a k) x
    rw [e2] at this
    exact this
  have e5 : cubic (fun a b k => T k b a) x = cubic T x := by
    have := cubic_swap_ab (fun a b k => T k a b) x
    rw [e4] at this
    exact this
  unfold symT
  have : cubic (fun a b k => T a b k + T a k b + T b a k + T b k a + T k a b + T k b a) x
      = cubic T x + cubic (fun a b k => T a k b) x + cubic (fun a b k => T b a k) x
        + cubic (fun a b k => T b k a) x + cubic (fun a b k => T k a b) x
        + cubic (fun a b k => T k b a) x := by
    unfold cubic
    simp only [add_mul, Finset.sum_add_distrib]
  rw [this, e1, e2, e3, e4, e5]
  ring

/-- **The cubic vanishes when its symmetrisation does:** a tensor whose symmetrisation vanishes
on every triple has an identically vanishing cubic form. -/
theorem cubic_eq_zero_of_symT {n : ℕ} (T : Fin n → Fin n → Fin n → ℚ)
    (h : ∀ a b k, symT T a b k = 0) (x : Fin n → ℚ) : cubic T x = 0 := by
  have := cubic_perm_sum T x
  have h0 : cubic (fun a b k => symT T a b k) x = 0 := by
    unfold cubic
    simp [h]
  rw [h0] at this
  linarith

/-! ## The identity (E) for the dense step -/

/-- The Galerkin–Euler step in dense form on `Fin n`: `F(x)_k = (1 − κ_k) x_k − Q_k(x)/D_k`,
`Q_k(x) = Σ_{a,b} T a b k x_a x_b`. -/
def stepF {n : ℕ} (T : Fin n → Fin n → Fin n → ℚ) (κ D : Fin n → ℚ) (x : Fin n → ℚ) (k : Fin n) : ℚ :=
  (1 - κ k) * x k - (∑ a, ∑ b, T a b k * (x a * x b)) / D k

/-- **(E), Addendum VI §5.** For a tensor with vanishing cubic form and nonzero divisors,
`Σ_k D_k x_k F(x)_k = Σ_k D_k (1 − κ_k) x_k²`. -/
theorem energy_identity {n : ℕ} (T : Fin n → Fin n → Fin n → ℚ) (κ D : Fin n → ℚ)
    (hD : ∀ k, D k ≠ 0) (hT : ∀ x, cubic T x = 0) (x : Fin n → ℚ) :
    ∑ k, D k * x k * stepF T κ D x k = ∑ k, D k * (1 - κ k) * x k ^ 2 := by
  have hc : ∑ k, x k * ∑ a, ∑ b, T a b k * (x a * x b) = 0 := by
    have h0 := hT x
    unfold cubic at h0
    have : ∑ k, x k * ∑ a, ∑ b, T a b k * (x a * x b)
        = ∑ a, ∑ b, ∑ k, T a b k * (x a * x b * x k) := by
      simp only [Finset.mul_sum]
      rw [Finset.sum_comm]
      refine Finset.sum_congr rfl fun a _ => ?_
      rw [Finset.sum_comm]
      refine Finset.sum_congr rfl fun b _ => Finset.sum_congr rfl fun k _ => ?_
      ring
    rw [this, h0]
  unfold stepF
  have : ∀ k, D k * x k * ((1 - κ k) * x k - (∑ a, ∑ b, T a b k * (x a * x b)) / D k)
      = D k * (1 - κ k) * x k ^ 2 - x k * ∑ a, ∑ b, T a b k * (x a * x b) := by
    intro k
    field_simp [hD k]
  simp only [this, Finset.sum_sub_distrib, hc, sub_zero]

/-! ## The 2D box `K = 2` -/

/-- The basis of the 2D box `K = 2` (24 coordinates). -/
def B22 : List Basis2 := basis2D 2

/-- The tensor of the 2D box `K = 2` as a function on `Fin 24`. -/
def T22 (a b k : Fin 24) : ℚ :=
  (tx (B22.getD a default) (B22.getD b default) (B22.getD k default) : ℚ)

/-- The viscous rates and divisors as functions. -/
def kappa22q (k : Fin 24) : ℚ := (kappa (B22.getD k default) : ℚ)
def D22q (k : Fin 24) : ℚ := (divisor (B22.getD k default) : ℚ)

/-- The enstrophy-weighted tensor. -/
def TZ22 (a b k : Fin 24) : ℚ := kappa22q k * T22 a b k

/-- The symmetrisation of the `K = 2` tensor vanishes on every triple (the kernel's census). -/
theorem symT22_zero : ∀ a b k : Fin 24,
    tx (B22.getD a default) (B22.getD b default) (B22.getD k default)
    + tx (B22.getD a default) (B22.getD k default) (B22.getD b default)
    + tx (B22.getD b default) (B22.getD a default) (B22.getD k default)
    + tx (B22.getD b default) (B22.getD k default) (B22.getD a default)
    + tx (B22.getD k default) (B22.getD a default) (B22.getD b default)
    + tx (B22.getD k default) (B22.getD b default) (B22.getD a default) = 0 := by
  decide +kernel

/-- The enstrophy-weighted symmetrisation vanishes too (two dimensions). -/
theorem symZ22_zero : ∀ a b k : Fin 24,
    kappa (B22.getD k default) * tx (B22.getD a default) (B22.getD b default) (B22.getD k default)
    + kappa (B22.getD b default) * tx (B22.getD a default) (B22.getD k default) (B22.getD b default)
    + kappa (B22.getD k default) * tx (B22.getD b default) (B22.getD a default) (B22.getD k default)
    + kappa (B22.getD a default) * tx (B22.getD b default) (B22.getD k default) (B22.getD a default)
    + kappa (B22.getD b default) * tx (B22.getD k default) (B22.getD a default) (B22.getD b default)
    + kappa (B22.getD a default) * tx (B22.getD k default) (B22.getD b default) (B22.getD a default) = 0 := by
  decide +kernel

/-- **Energy conservation of the `K = 2` nonlinearity:** `Σ_k x_k Q_k(x) = 0` for every state. -/
theorem energy_cubic22 (x : Fin 24 → ℚ) : cubic T22 x = 0 := by
  apply cubic_eq_zero_of_symT
  intro a b k
  unfold symT T22
  have := symT22_zero a b k
  exact_mod_cast this

/-- **Enstrophy conservation of the `K = 2` nonlinearity:** `Σ_k |k|² x_k Q_k(x) = 0`. -/
theorem enstrophy_cubic22 (x : Fin 24 → ℚ) : cubic TZ22 x = 0 := by
  apply cubic_eq_zero_of_symT
  intro a b k
  unfold symT TZ22 T22 kappa22q
  have := symZ22_zero a b k
  exact_mod_cast this

theorem B22_length : B22.length = 24 := by decide +kernel

theorem D22q_ne (k : Fin 24) : D22q k ≠ 0 := by
  have h := R22_D_ne k (by
    show (k : ℕ) < (road2D 2).n
    rw [show (road2D 2).n = 24 by decide +kernel]
    exact k.isLt)
  unfold D22q
  exact_mod_cast h

/-- **(E) at the 2D box `K = 2`:** `Σ_k D_k x_k F(x)_k = Σ_k D_k (1 − |k|²) x_k²` for every state. -/
theorem energy_identity22 (x : Fin 24 → ℚ) :
    ∑ k, D22q k * x k * stepF T22 kappa22q D22q x k = ∑ k, D22q k * (1 - kappa22q k) * x k ^ 2 :=
  energy_identity T22 kappa22q D22q D22q_ne energy_cubic22 x

end Gephyrosis
