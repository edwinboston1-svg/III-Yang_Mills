import Aperanton.GephyrosisTensor
import Mathlib.NumberTheory.Padics.PadicVal.Basic

/-!
# ΓΕΦΥΡΩΣΙΣ — the integer road: the exact orbit with a known denominator

Addendum VI §7: the common denominator of the exact orbit at step `s` divides a number `Δ_s`
known before the orbit is computed (Theorem T's max-plus bound at every ramified prime), so the
orbit is carried as `X(s) = Δ_s · c(s) ∈ ℤⁿ`, one integer per coordinate, and every step ends in
exact divisions by small integers — EXACT OR REFUSED: a nonzero remainder is a counterexample to
Theorem T's bound.

Here the road is built in Lean and its exactness is DECIDED by the kernel step by step; the
bridge lemma `step_map_div` proves, once and for all, that an exact integer step is the rational
Galerkin–Euler step on `X/Δ`. Nothing about the orbit is assumed: the denominators `Δ_s` are a
hypothesis of the bridge lemma, discharged by the kernel's `% = 0`.

A `Road` is a truncation seen by the step: its number of coordinates, the viscous rates
`κ_k = |k|²`, the divisors `D_k = 2|e_k|²`, and the sparse tensor as term lists — the 2D and 3D
boxes of `GephyrosisTensor` and `GephyrosisTensor3D` are its instances.

At the 2D box `K = 2` the divisors are `2|e_k|² ∈ {2, 4, 8, 10, 16}`, the ramified primes are
`2` and `5`, and the max-plus bounds of Addendum IV are `v₅ ≤ 2^{s−1}` (Theorem V) and
`v₂ ≤ J_{s+1}` (the shifted Jacobsthal bound), so `Δ_s = 2^{J_{s+1}} 5^{2^{s−1}}`.
-/

namespace Gephyrosis

/-- A truncation as the step sees it. -/
structure Road where
  n : ℕ
  κ : ℕ → ℤ
  D : ℕ → ℤ
  tb : List (List Term)

/-- The quadratic form of coordinate `k` on an integer state: `Q_k(X) = Σ T·X_a·X_b`. -/
def iquad (ts : List Term) (X : List ℤ) : ℤ :=
  (ts.map fun t => t.T * X.getD t.a 0 * X.getD t.b 0).sum

/-- The rational quadratic form, as a sum (the same shape as `iquad`). -/
def quadSum (ts : List Term) (x : List ℚ) : ℚ :=
  (ts.map fun t => (t.T : ℚ) * x.getD t.a 0 * x.getD t.b 0).sum

/-- The rational step by index: `F(x)_k = (1 − κ_k) x_k − Q_k(x)/D_k`. -/
def stepI (R : Road) (x : List ℚ) : List ℚ :=
  (List.range R.n).map fun k =>
    (1 - (R.κ k : ℚ)) * x.getD k 0 - quadSum (R.tb.getD k []) x / (R.D k : ℚ)

/-- The integer numerator and divisor of the quadratic term of coordinate `k`, from denominators
`Δ` (this step) and `Δ'` (the next): `Δ'·Q_k(X)` over `Δ²·D_k`. -/
def iquadNum (R : Road) (Δ' : ℕ) (X : List ℤ) (k : ℕ) : ℤ :=
  (Δ' : ℤ) * iquad (R.tb.getD k []) X

def iquadDen (R : Road) (Δ : ℕ) (k : ℕ) : ℤ := (Δ : ℤ) ^ 2 * R.D k

/-- One coordinate of the integer step: `X'_k = (Δ'/Δ)(1 − κ_k) X_k − Δ'Q_k(X)/(Δ² D_k)`. -/
def istepAt (R : Road) (Δ Δ' : ℕ) (X : List ℤ) (k : ℕ) : ℤ :=
  ((Δ' / Δ : ℕ) : ℤ) * (1 - R.κ k) * X.getD k 0 - iquadNum R Δ' X k / iquadDen R Δ k

/-- The integer step. -/
def istep (R : Road) (Δ Δ' : ℕ) (X : List ℤ) : List ℤ :=
  (List.range R.n).map (istepAt R Δ Δ' X)

/-- The step is EXACT when every quadratic division has remainder zero. -/
def istepExact (R : Road) (Δ Δ' : ℕ) (X : List ℤ) : Bool :=
  (List.range R.n).all fun k => iquadNum R Δ' X k % iquadDen R Δ k = 0

/-- The integer trajectory `[X₀, X₁, …, Xₙ]` under a denominator schedule `Δ : ℕ → ℕ`, starting
at step index `s₀`. -/
def itrajAux (R : Road) (Δ : ℕ → ℕ) : ℕ → ℕ → List ℤ → List (List ℤ)
  | _, 0, X => [X]
  | s, n + 1, X => X :: itrajAux R Δ (s + 1) n (istep R (Δ s) (Δ (s + 1)) X)

/-- Exactness along a trajectory of `n` steps from step index `s₀`. -/
def itrajExact (R : Road) (Δ : ℕ → ℕ) : ℕ → ℕ → List ℤ → Bool
  | _, 0, _ => true
  | s, n + 1, X => istepExact R (Δ s) (Δ (s + 1)) X
      && itrajExact R Δ (s + 1) n (istep R (Δ s) (Δ (s + 1)) X)

/-! ## The bridge: an exact integer step is the rational step on `X/Δ` -/

theorem getD_map_div (X : List ℤ) (Δ : ℚ) (a : ℕ) :
    (X.map fun x : ℤ => (x : ℚ) / Δ).getD a 0 = (X.getD a 0 : ℚ) / Δ := by
  induction X generalizing a with
  | nil => simp
  | cons x xs ih =>
    cases a with
    | zero => simp
    | succ a => simp only [List.map_cons, List.getD_cons_succ]; exact ih a

theorem quadSum_map_div (ts : List Term) (X : List ℤ) (Δ : ℚ) :
    quadSum ts (X.map fun x : ℤ => (x : ℚ) / Δ) = (iquad ts X : ℚ) / Δ ^ 2 := by
  unfold quadSum iquad
  induction ts with
  | nil => simp
  | cons t ts ih =>
    simp only [List.map_cons, List.sum_cons, Int.cast_add, Int.cast_mul, getD_map_div] at ih ⊢
    rw [ih]
    ring

theorem istepExact_iff {R : Road} {Δ Δ' : ℕ} {X : List ℤ} :
    istepExact R Δ Δ' X = true ↔ ∀ k < R.n, iquadNum R Δ' X k % iquadDen R Δ k = 0 := by
  unfold istepExact
  simp [List.all_eq_true, List.mem_range]

/-- THE BRIDGE LEMMA. If `Δ ∣ Δ'`, both nonzero, every divisor is nonzero and the integer step is
exact, then the rational Galerkin–Euler step of `X/Δ` is `X'/Δ'`. -/
theorem step_map_div (R : Road) (Δ Δ' : ℕ) (X : List ℤ)
    (hΔ : Δ ≠ 0) (hΔ' : Δ' ≠ 0) (hdvd : Δ ∣ Δ') (hD : ∀ k < R.n, R.D k ≠ 0)
    (hex : istepExact R Δ Δ' X = true) :
    stepI R (X.map fun x : ℤ => (x : ℚ) / (Δ : ℚ))
      = (istep R Δ Δ' X).map fun x : ℤ => (x : ℚ) / (Δ' : ℚ) := by
  unfold stepI istep
  rw [List.map_map]
  apply List.map_congr_left
  intro k hk
  rw [List.mem_range] at hk
  have hex' := (istepExact_iff.1 hex) k hk
  have hDk := hD k hk
  simp only [Function.comp, istepAt]
  rw [getD_map_div, quadSum_map_div]
  obtain ⟨m, hm⟩ := hdvd
  have hmdiv : (Δ' / Δ : ℕ) = m := by rw [hm]; exact Nat.mul_div_cancel_left m (Nat.pos_of_ne_zero hΔ)
  have hdiv : (iquadNum R Δ' X k / iquadDen R Δ k) * iquadDen R Δ k = iquadNum R Δ' X k :=
    Int.ediv_mul_cancel (Int.dvd_of_emod_eq_zero hex')
  have hΔq : (Δ : ℚ) ≠ 0 := by exact_mod_cast hΔ
  have hΔ'q : (Δ' : ℚ) ≠ 0 := by exact_mod_cast hΔ'
  have hm0 : m ≠ 0 := by
    rintro rfl
    rw [Nat.mul_zero] at hm
    exact hΔ' hm
  have hmq : (m : ℚ) ≠ 0 := by exact_mod_cast hm0
  have hDq : (R.D k : ℚ) ≠ 0 := by exact_mod_cast hDk
  rw [hmdiv]
  have key : ((iquadNum R Δ' X k / iquadDen R Δ k : ℤ) : ℚ)
      = (iquadNum R Δ' X k : ℚ) / (iquadDen R Δ k : ℚ) := by
    have hden : (iquadDen R Δ k : ℚ) ≠ 0 := by
      unfold iquadDen; push_cast; exact mul_ne_zero (pow_ne_zero 2 hΔq) hDq
    rw [eq_div_iff hden]
    exact_mod_cast hdiv
  push_cast
  rw [key]
  unfold iquadNum iquadDen
  push_cast
  rw [hm]
  push_cast
  field_simp

/-- THE ORBIT THEOREM, generic form: if the integer trajectory is exact for `n` steps from step
`s₀`, then for every `j ≤ n` the rational orbit of `X/Δ_{s₀}` after `j` steps is `X_j/Δ_{s₀+j}`. -/
theorem rational_orbit_eq (R : Road) (Δ : ℕ → ℕ)
    (hΔ : ∀ s, Δ s ≠ 0) (hdvd : ∀ s, Δ s ∣ Δ (s + 1)) (hD : ∀ k < R.n, R.D k ≠ 0) :
    ∀ (n s0 : ℕ) (X : List ℤ), itrajExact R Δ s0 n X = true →
      ∀ j ≤ n, (stepI R)^[j] (X.map fun x : ℤ => (x : ℚ) / (Δ s0 : ℚ))
        = ((itrajAux R Δ s0 n X).getD j []).map fun x : ℤ => (x : ℚ) / (Δ (s0 + j) : ℚ) := by
  intro n
  induction n with
  | zero =>
    intro s0 X _ j hj
    have : j = 0 := by omega
    subst this
    simp [itrajAux]
  | succ n ih =>
    intro s0 X hex j hj
    simp only [itrajExact, Bool.and_eq_true] at hex
    obtain ⟨hex1, hexr⟩ := hex
    cases j with
    | zero => simp [itrajAux]
    | succ j =>
      have hj' : j ≤ n := by omega
      have h1 := step_map_div R (Δ s0) (Δ (s0 + 1)) X (hΔ s0) (hΔ (s0 + 1)) (hdvd s0) hD hex1
      have h2 := ih (s0 + 1) (istep R (Δ s0) (Δ (s0 + 1)) X) hexr j hj'
      rw [Function.iterate_succ_apply, h1, h2]
      simp only [itrajAux, List.getD_cons_succ]
      have hs : s0 + 1 + j = s0 + (j + 1) := by omega
      rw [hs]

/-- The length of a trajectory. -/
theorem itrajAux_length (R : Road) (Δ : ℕ → ℕ) :
    ∀ (n s0 : ℕ) (X : List ℤ), (itrajAux R Δ s0 n X).length = n + 1 := by
  intro n
  induction n with
  | zero => intro s0 X; rfl
  | succ n ih => intro s0 X; simp [itrajAux, ih]

/-! ## Valuations read off the integer road -/

/-- `padicValNat` through two divisibilities. -/
theorem padicValNat_eq_of_dvd_of_not_dvd {p n v : ℕ} [Fact p.Prime] (hn : n ≠ 0)
    (h1 : p ^ v ∣ n) (h2 : ¬ p ^ (v + 1) ∣ n) : padicValNat p n = v := by
  have u := (padicValNat_dvd_iff_le (p := p) hn).1 h1
  have w := (padicValNat_dvd_iff_le (p := p) hn).not.1 h2
  omega

/-- `v_p(p^e · m) = e` when `p ∤ m`. -/
theorem padicValNat_prime_pow_mul (p : ℕ) [hp : Fact p.Prime] (e m : ℕ) (hm : m ≠ 0)
    (hpm : ¬ p ∣ m) : padicValNat p (p ^ e * m) = e := by
  apply padicValNat_eq_of_dvd_of_not_dvd (mul_ne_zero (pow_ne_zero _ hp.out.ne_zero) hm)
    (dvd_mul_right _ _)
  intro hdiv
  rw [pow_succ] at hdiv
  exact hpm ((Nat.mul_dvd_mul_iff_left (pow_pos hp.out.pos _)).1 hdiv)

/-- A prime never divides a product of powers of two other primes. -/
theorem prime_not_dvd_pow_mul_pow {p q r : ℕ} (hp : p.Prime) (hq : q.Prime) (hr : r.Prime)
    (hpq : p ≠ q) (hpr : p ≠ r) (a b : ℕ) : ¬ p ∣ q ^ a * r ^ b := by
  intro h
  rcases (Nat.Prime.dvd_mul hp).1 h with h1 | h1
  · exact hpq ((Nat.prime_dvd_prime_iff_eq hp hq).1 (hp.dvd_of_dvd_pow h1))
  · exact hpr ((Nat.prime_dvd_prime_iff_eq hp hr).1 (hp.dvd_of_dvd_pow h1))

/-- The `p`-adic valuation of `x/Δ` is `v_p(x) − v_p(Δ)`. -/
theorem padicValRat_div_nat (p : ℕ) [Fact p.Prime] (x : ℤ) (Δ : ℕ) (hx : x ≠ 0) (hΔ : Δ ≠ 0) :
    padicValRat p ((x : ℚ) / (Δ : ℚ)) = padicValInt p x - padicValNat p Δ := by
  have hd : (Δ : ℚ) ≠ 0 := by exact_mod_cast hΔ
  have hXq : (x : ℚ) ≠ 0 := by exact_mod_cast hx
  rw [padicValRat.div (p := p) hXq hd, padicValRat.of_int, padicValRat.of_nat]

/-- A coordinate prime to `p` has `padicValInt p X = 0`. -/
theorem padicValInt_eq_zero_of_mod (p : ℕ) [Fact p.Prime] (X : ℤ) (h : X % p ≠ 0) :
    padicValInt p X = 0 := by
  apply padicValInt.eq_zero_of_not_dvd
  intro hd
  exact h (Int.emod_eq_zero_of_dvd hd)

/-! ## The Jacobsthal numbers and the exponent schedules -/

/-- The Jacobsthal numbers `J₀ = 0, J₁ = 1, J_{n+2} = J_{n+1} + 2J_n`. -/
def jacobsthal : ℕ → ℕ
  | 0 => 0
  | 1 => 1
  | n + 2 => jacobsthal (n + 1) + 2 * jacobsthal n

/-- `3 J_n = 2^n − (−1)^n` -/
theorem three_mul_jacobsthal (n : ℕ) : (3 * jacobsthal n : ℤ) = 2 ^ n - (-1) ^ n := by
  induction n using Nat.strong_induction_on with
  | _ n ih =>
    match n with
    | 0 => simp [jacobsthal]
    | 1 => simp [jacobsthal]
    | n + 2 =>
      have h1 := ih (n + 1) (by omega)
      have h0 := ih n (by omega)
      simp only [jacobsthal]
      push_cast at h1 h0 ⊢
      have : (2 : ℤ) ^ (n + 2) = 4 * 2 ^ n := by ring
      have : (-1 : ℤ) ^ (n + 2) = (-1) ^ n := by ring
      have : (2 : ℤ) ^ (n + 1) = 2 * 2 ^ n := by ring
      have : (-1 : ℤ) ^ (n + 1) = -(-1) ^ n := by ring
      linarith

/-- `J_{n+1} = 2 J_n + (−1)^n` -/
theorem jacobsthal_succ (n : ℕ) : (jacobsthal (n + 1) : ℤ) = 2 * jacobsthal n + (-1) ^ n := by
  have h1 := three_mul_jacobsthal (n + 1)
  have h0 := three_mul_jacobsthal n
  have : (2 : ℤ) ^ (n + 1) = 2 * 2 ^ n := by ring
  have : (-1 : ℤ) ^ (n + 1) = -(-1) ^ n := by ring
  linarith

theorem jacobsthal_mono (n : ℕ) : jacobsthal n ≤ jacobsthal (n + 1) := by
  cases n with
  | zero => simp [jacobsthal]
  | succ n =>
    have h := jacobsthal_succ (n + 1)
    have hpos : (1 : ℤ) ≤ jacobsthal (n + 1) := by
      have := three_mul_jacobsthal (n + 1)
      have h2 : (2 : ℤ) ^ (n + 1) ≥ 2 := by
        calc (2 : ℤ) ^ (n + 1) = 2 * 2 ^ n := by ring
          _ ≥ 2 * 1 := by gcongr; exact one_le_pow₀ (by norm_num)
          _ = 2 := by ring
      have h3 : ((-1 : ℤ) ^ (n + 1)) ≤ 1 := by
        rcases neg_one_pow_eq_or ℤ (n + 1) with h | h <;> (rw [h]; try norm_num)
      linarith
    have h2 : (jacobsthal (n + 1 + 1) : ℤ) ≥ jacobsthal (n + 1) := by
      rw [h]
      rcases neg_one_pow_eq_or ℤ (n + 1) with h | h <;> (rw [h]; try linarith)
    exact_mod_cast h2

/-- The 2-adic exponent of the a-priori denominator at the 2D boxes: `J_{s+1}` for `s ≥ 1`. -/
def expTwo : ℕ → ℕ
  | 0 => 0
  | s + 1 => jacobsthal (s + 2)

/-- The exponent of a simply ramified odd prime: `2^{s−1}` for `s ≥ 1`. -/
def expFive : ℕ → ℕ
  | 0 => 0
  | s + 1 => 2 ^ s

theorem expTwo_mono (s : ℕ) : expTwo s ≤ expTwo (s + 1) := by
  cases s with
  | zero => simp [expTwo, jacobsthal]
  | succ s => simp only [expTwo]; exact jacobsthal_mono (s + 2)

theorem expFive_mono (s : ℕ) : expFive s ≤ expFive (s + 1) := by
  cases s with
  | zero => simp [expFive]
  | succ s => simp only [expFive]; exact Nat.pow_le_pow_right (by norm_num) (by omega)

/-! ## The 2D box `K = 2` as a road -/

/-- `Δ_s = 2^{J_{s+1}} · 5^{2^{s−1}}`, `Δ_0 = 1`. -/
def delta22 (s : ℕ) : ℕ := 2 ^ expTwo s * 5 ^ expFive s

theorem delta22_pos (s : ℕ) : delta22 s ≠ 0 := by
  unfold delta22; positivity

theorem delta22_dvd (s : ℕ) : delta22 s ∣ delta22 (s + 1) := by
  unfold delta22
  exact Nat.mul_dvd_mul (Nat.pow_dvd_pow 2 (expTwo_mono s)) (Nat.pow_dvd_pow 5 (expFive_mono s))

/-- The road of a 2D box: its basis, rates, divisors and term lists. -/
def road2D (K : ℕ) : Road :=
  let B := basis2D K
  ⟨B.length, fun k => kappa (B.getD k default), fun k => divisor (B.getD k default), termsByCoord B⟩

def R22 : Road := road2D 2

theorem R22_D_ne (k : ℕ) (hk : k < R22.n) : R22.D k ≠ 0 := by
  have : (List.range R22.n).all (fun k => decide (R22.D k ≠ 0)) = true := by
    decide +kernel
  rw [List.all_eq_true] at this
  have := this k (List.mem_range.2 hk)
  simpa using this

/-- The integer trajectory of a seed at the 2D box `K = 2` through `n` steps. -/
def itraj22 (seed n : ℕ) : List (List ℤ) :=
  itrajAux R22 delta22 0 n (seedData seed R22.n)

/-- The rational orbit (the map of `GephyrosisTensor`, by index) of the same seed. -/
def rorbit22 (seed : ℕ) : ℕ → List ℚ
  | 0 => (seedData seed R22.n).map fun z => (z : ℚ)
  | n + 1 => stepI R22 (rorbit22 seed n)

end Gephyrosis
