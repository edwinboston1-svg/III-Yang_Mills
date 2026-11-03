import Mathlib.NumberTheory.LegendreSymbol.Basic
import Mathlib.NumberTheory.Padics.PadicVal.Basic
import Mathlib.Tactic

/-!
# ΓΕΦΥΡΩΣΙΣ — the arithmetic of the selection rules (Addendum IV)

The Galerkin–Euler nonlinearity couples the modes `a, b` into `k = a + b` with the coefficient
`(e_a · k_b)(e_b · e_k) = (a × b) · (…)` and, after symmetrisation, the factor `|b|² − |a|²`.
The facts below are the integer identities behind the selection rules and Theorem G, and the
obstruction Theorem I: a prime `p ≡ 3 (mod 4)` dividing `x² + y²` divides both `x` and `y`,
so no such prime ever enters a 2D divisor to an odd power, and none is ever ramified for the flow.

* `cross_add_self` — `a × (a + b) = a × b`: the coupling into `k = a + b` carries the cross product.
* `lagrange_two` — Lagrange's identity in two variables, `(a × b)² + (a·b)² = |a|²|b|²`.
* `theorem_G_cross`, `theorem_G_norm` — Theorem G: for `k = p^j k'` and `b = k − a`,
  `a × b = p^j (a × k')` and `|b|² − |a|² = p^j (p^j |k'|² − 2 a·k')`, so the symmetrised coupling
  into a mode divisible by `p^j` carries `p^{2j}`.
* `three_dvd_of_dvd_sq_add_sq` — rule L-d: `3 ∣ x² + y² ⟹ 3 ∣ x ∧ 3 ∣ y`.
* `prime_three_mod_four_dvd_of_dvd_sq_add_sq` — Theorem I's obstruction for every `p ≡ 3 (mod 4)`.
* `two_dvd_padicValNat_sq_add_sq` — hence `v_p(x² + y²)` is even for every such prime.
-/

namespace Gephyrosis

/-- A wavevector of the 2D box, as a pair of integers. -/
abbrev IVec := ℤ × ℤ

def cross (a b : IVec) : ℤ := a.1 * b.2 - a.2 * b.1
def dotp (a b : IVec) : ℤ := a.1 * b.1 + a.2 * b.2
def nsq (a : IVec) : ℤ := a.1 * a.1 + a.2 * a.2

/-- The coupling into `k = a + b` carries the cross product of the pair. -/
theorem cross_add_self (a b : IVec) : cross a (a.1 + b.1, a.2 + b.2) = cross a b := by
  unfold cross; ring

/-- Lagrange's identity in two variables. -/
theorem lagrange_two (a b : IVec) : cross a b ^ 2 + dotp a b ^ 2 = nsq a * nsq b := by
  unfold cross dotp nsq; ring

/-- Theorem G, the cross product: with `k = p^j k'` and `b = k − a`, `a × b = p^j (a × k')`. -/
theorem theorem_G_cross (p : ℤ) (j : ℕ) (a k' : IVec) :
    cross a (p ^ j * k'.1 - a.1, p ^ j * k'.2 - a.2) = p ^ j * cross a k' := by
  unfold cross; ring

/-- Theorem G, the norm difference: `|b|² − |a|² = p^j (p^j |k'|² − 2 a·k')`. -/
theorem theorem_G_norm (p : ℤ) (j : ℕ) (a k' : IVec) :
    nsq (p ^ j * k'.1 - a.1, p ^ j * k'.2 - a.2) - nsq a
      = p ^ j * (p ^ j * nsq k' - 2 * dotp a k') := by
  unfold nsq dotp; ring

/-- Hence the symmetrised coupling `(a × b)(|b|² − |a|²)` into `k = p^j k'` carries `p^{2j}`. -/
theorem theorem_G_dvd (p : ℤ) (j : ℕ) (a k' : IVec) :
    p ^ (2 * j) ∣ cross a (p ^ j * k'.1 - a.1, p ^ j * k'.2 - a.2)
      * (nsq (p ^ j * k'.1 - a.1, p ^ j * k'.2 - a.2) - nsq a) := by
  rw [theorem_G_cross, theorem_G_norm, pow_mul', pow_two]
  exact mul_dvd_mul (Dvd.intro _ rfl) (Dvd.intro _ rfl)

/-- Rule L-d: `3 ∣ x² + y²` forces `3 ∣ x` and `3 ∣ y`. -/
theorem three_dvd_of_dvd_sq_add_sq (x y : ℤ) (h : (3 : ℤ) ∣ x ^ 2 + y ^ 2) :
    (3 : ℤ) ∣ x ∧ (3 : ℤ) ∣ y := by
  have key : ∀ a b : ZMod 3, a ^ 2 + b ^ 2 = 0 → a = 0 ∧ b = 0 := by decide
  have h' : ((x : ZMod 3)) ^ 2 + ((y : ZMod 3)) ^ 2 = 0 := by
    have := (ZMod.intCast_zmod_eq_zero_iff_dvd (x ^ 2 + y ^ 2) 3).2 h
    push_cast at this
    exact this
  obtain ⟨hx, hy⟩ := key _ _ h'
  exact ⟨(ZMod.intCast_zmod_eq_zero_iff_dvd x 3).1 hx, (ZMod.intCast_zmod_eq_zero_iff_dvd y 3).1 hy⟩

/-- Theorem I's obstruction: a prime `p ≡ 3 (mod 4)` dividing `x² + y²` divides both. -/
theorem prime_three_mod_four_dvd_of_dvd_sq_add_sq (p : ℕ) [hp : Fact p.Prime] (hp3 : p % 4 = 3)
    (x y : ℤ) (h : (p : ℤ) ∣ x ^ 2 + y ^ 2) : (p : ℤ) ∣ x ∧ (p : ℤ) ∣ y := by
  have hz : ((x : ZMod p)) ^ 2 + ((y : ZMod p)) ^ 2 = 0 := by
    have := (ZMod.intCast_zmod_eq_zero_iff_dvd (x ^ 2 + y ^ 2) p).2 h
    push_cast at this
    exact this
  by_contra hcon
  rcases not_and_or.1 hcon with hx | hy
  · have hx' : (x : ZMod p) ≠ 0 := fun h0 => hx ((ZMod.intCast_zmod_eq_zero_iff_dvd x p).1 h0)
    exact ZMod.mod_four_ne_three_of_sq_eq_neg_sq hx' (eq_neg_of_add_eq_zero_left hz) hp3
  · have hy' : (y : ZMod p) ≠ 0 := fun h0 => hy ((ZMod.intCast_zmod_eq_zero_iff_dvd y p).1 h0)
    have hz' : ((y : ZMod p)) ^ 2 + ((x : ZMod p)) ^ 2 = 0 := by rw [add_comm]; exact hz
    exact ZMod.mod_four_ne_three_of_sq_eq_neg_sq hy' (eq_neg_of_add_eq_zero_left hz') hp3

/-- Such a prime divides `x² + y²` only through `p²`: the obstruction, iterated. -/
theorem sq_dvd_of_dvd_sq_add_sq (p : ℕ) [Fact p.Prime] (hp3 : p % 4 = 3) (x y : ℤ)
    (h : (p : ℤ) ∣ x ^ 2 + y ^ 2) : ((p : ℤ) ^ 2) ∣ x ^ 2 + y ^ 2 := by
  obtain ⟨hx, hy⟩ := prime_three_mod_four_dvd_of_dvd_sq_add_sq p hp3 x y h
  obtain ⟨u, rfl⟩ := hx
  obtain ⟨v, rfl⟩ := hy
  exact ⟨u ^ 2 + v ^ 2, by ring⟩

/-- Theorem I in valuations: `v_p(x² + y²)` is even for every prime `p ≡ 3 (mod 4)`, so the
`p`-part of every 2D divisor `2|k|²` is a square and `p` is never ramified for the flow. -/
theorem two_dvd_padicValNat_sq_add_sq (p : ℕ) [hp : Fact p.Prime] (hp3 : p % 4 = 3) (x y : ℤ)
    (hxy : x ^ 2 + y ^ 2 ≠ 0) : 2 ∣ padicValInt p (x ^ 2 + y ^ 2) := by
  -- strong induction on the valuation: divide both coordinates by `p` while `p` divides the sum
  suffices H : ∀ n : ℕ, ∀ x y : ℤ, x ^ 2 + y ^ 2 ≠ 0 → padicValInt p (x ^ 2 + y ^ 2) ≤ n →
      2 ∣ padicValInt p (x ^ 2 + y ^ 2) from H _ x y hxy le_rfl
  intro n
  induction n using Nat.strong_induction_on with
  | _ n ih =>
    intro x y hxy hle
    by_cases hdvd : (p : ℤ) ∣ x ^ 2 + y ^ 2
    · obtain ⟨hx, hy⟩ := prime_three_mod_four_dvd_of_dvd_sq_add_sq p hp3 x y hdvd
      obtain ⟨u, rfl⟩ := hx
      obtain ⟨v, rfl⟩ := hy
      have hp0 : (p : ℤ) ≠ 0 := by exact_mod_cast hp.out.ne_zero
      have hfac' : ((p : ℤ) * u) ^ 2 + ((p : ℤ) * v) ^ 2 = (p : ℤ) * ((p : ℤ) * (u ^ 2 + v ^ 2)) := by
        ring
      have huv : u ^ 2 + v ^ 2 ≠ 0 := by
        intro h0; apply hxy; rw [hfac', h0, mul_zero, mul_zero]
      have hval : padicValInt p (((p : ℤ) * u) ^ 2 + ((p : ℤ) * v) ^ 2)
          = 2 + padicValInt p (u ^ 2 + v ^ 2) := by
        rw [hfac', padicValInt.mul hp0 (mul_ne_zero hp0 huv), padicValInt.mul hp0 huv,
          padicValInt.self hp.out.one_lt]
        ring
      rw [hval] at hle ⊢
      have hn : padicValInt p (u ^ 2 + v ^ 2) < n := by omega
      obtain ⟨m, hm⟩ := ih _ hn u v huv le_rfl
      exact ⟨m + 1, by omega⟩
    · rw [padicValInt.eq_zero_of_not_dvd hdvd]
      exact dvd_zero 2

end Gephyrosis
