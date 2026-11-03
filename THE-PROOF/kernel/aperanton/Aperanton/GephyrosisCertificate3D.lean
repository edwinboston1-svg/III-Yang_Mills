import Aperanton.GephyrosisTensor3D
import Aperanton.GephyrosisCertificate2D

/-!
# ΓΕΦΥΡΩΣΙΣ — the Jacobsthal law at the prime 3 on the 3D box `K = 1`

The 3D box `|k|_∞ ≤ 1` has 13 modes and 52 coordinates; its divisors `2|e_k|² ∈ {2, 4, 8, 12}`
carry the primes 2 and 3, and the exact orbit lives in `ℤ[1/6]`. Theorem J (Addendum IV) says the
3-adic pole order of the orbit is the Jacobsthal number `J_s = (2^s − (−1)^s)/3`:
`1, 1, 3, 5, 11, 21, 43, 85, 171, 341, 683, 1365, 2731, 5461, 10923`. The integer road here
carries `Δ_s = 2^{2^{s+1}} · 3^{J_s}` (the 2-adic exponent a safe bound, the 3-adic exponent the
law), is checked exact for fifteen steps of seed 5, and the 3-adic bound is checked attained at
every step: the Jacobsthal denominators on the numbers.
-/

namespace Gephyrosis

/-- The road of a 3D box. -/
def road3D (K : ℕ) : Road :=
  let B := basis3D K
  ⟨B.length, fun k => kappa3 (B.getD k default), fun k => divisor3 (B.getD k default),
    termsByCoord3 B⟩

def R31 : Road := road3D 1

theorem R31_D_ne (k : ℕ) (hk : k < R31.n) : R31.D k ≠ 0 := by
  have : (List.range R31.n).all (fun k => decide (R31.D k ≠ 0)) = true := by
    decide +kernel
  rw [List.all_eq_true] at this
  have := this k (List.mem_range.2 hk)
  simpa using this

/-- The 2-adic exponent carried at 3D: `2^{s+1}` for `s ≥ 1` (a bound, not a law). -/
def expA : ℕ → ℕ
  | 0 => 0
  | s + 1 => 2 ^ (s + 2)

theorem expA_mono (s : ℕ) : expA s ≤ expA (s + 1) := by
  cases s with
  | zero => simp [expA]
  | succ s => simp only [expA]; exact Nat.pow_le_pow_right (by norm_num) (by omega)

/-- `Δ_s = 2^{2^{s+1}} · 3^{J_s}`, `Δ_0 = 1`. -/
def delta31 (s : ℕ) : ℕ := 2 ^ expA s * 3 ^ jacobsthal s

theorem delta31_pos (s : ℕ) : delta31 s ≠ 0 := by unfold delta31; positivity

theorem delta31_zero : delta31 0 = 1 := by unfold delta31 expA jacobsthal; norm_num

theorem delta31_dvd (s : ℕ) : delta31 s ∣ delta31 (s + 1) := by
  unfold delta31
  exact Nat.mul_dvd_mul (Nat.pow_dvd_pow 2 (expA_mono s)) (Nat.pow_dvd_pow 3 (jacobsthal_mono s))

/-- The rational orbit of a seed at the 3D box `K = 1`. -/
def rorbit31 (seed : ℕ) : ℕ → List ℚ
  | 0 => (seedData seed R31.n).map fun z => (z : ℚ)
  | n + 1 => stepI R31 (rorbit31 seed n)

theorem rorbit31_eq_iterate (seed s : ℕ) :
    rorbit31 seed s = (stepI R31)^[s] ((seedData seed R31.n).map fun z => (z : ℚ)) := by
  induction s with
  | zero => rfl
  | succ s ih => rw [Function.iterate_succ_apply', ← ih]; rfl

def itraj31 (seed n : ℕ) : List (List ℤ) :=
  itrajAux R31 delta31 0 n (seedData seed R31.n)

theorem orbit31_of_exact (seed n : ℕ)
    (hex : itrajExact R31 delta31 0 n (seedData seed R31.n) = true) (s : ℕ) (hs : s ≤ n) :
    rorbit31 seed s
      = ((itraj31 seed n).getD s []).map fun x : ℤ => (x : ℚ) / (delta31 s : ℚ) := by
  rw [rorbit31_eq_iterate]
  exact orbit_of_exact R31 delta31 delta31_pos delta31_dvd R31_D_ne delta31_zero _ n hex s hs

/-- `v₃(x/Δ_s) = v₃(x) − J_s`. -/
theorem val3_delta31 (s : ℕ) (x : ℤ) (hx : x ≠ 0) :
    padicValRat 3 ((x : ℚ) / (delta31 s : ℚ)) = padicValInt 3 x - jacobsthal s := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  rw [padicValRat_div_nat 3 x _ hx (delta31_pos s)]
  congr 1
  unfold delta31
  rw [mul_comm]
  rw [padicValNat_prime_pow_mul 3 _ _ (by positivity)
    (fun h => by have := Nat.prime_three.dvd_of_dvd_pow h; omega)]

/-- THE JACOBSTHAL LAW AT 3 ON THE NUMBERS. Seed 5 at the 3D box `K = 1`: the integer road is
exact for fifteen steps and the 3-adic bound `J_s` is attained at every step. -/
theorem cert_seed5_3D :
    (itrajExact R31 delta31 0 15 (seedData 5 R31.n)
      && checkAll R31 delta31 3 (zeros 16) 15 (seedData 5 R31.n)) = true := by
  decide +kernel

/-- **Theorem J on the orbit of seed 5.** At every step `s ≤ 15` of the exact rational orbit of
seed 5 in the 3D box `K = 1`, every coordinate has 3-adic valuation at least `−J_s` and some
coordinate attains it: `1, 1, 3, 5, 11, 21, 43, 85, 171, 341, 683, 1365, 2731, 5461, 10923`. -/
theorem seed5_3D_three_law (s : ℕ) (hs : s ≤ 15) :
    (∀ q ∈ rorbit31 5 s, -((jacobsthal s : ℕ) : ℤ) ≤ padicValRat 3 q) ∧
    (∃ q ∈ rorbit31 5 s, padicValRat 3 q = -((jacobsthal s : ℕ) : ℤ)) := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  have hc := cert_seed5_3D
  simp only [Bool.and_eq_true] at hc
  rw [orbit31_of_exact 5 15 hc.1 s hs]
  have hk := check_of_checkAll R31 delta31 3 15 (zeros 16) _ hc.2 s hs (by simp [zeros])
  rw [show (zeros 16).getD s 0 = 0 from getD_zeros 16 s] at hk
  have := law_of_check 3 (delta31 s : ℚ) (jacobsthal s) 0 (Nat.zero_le _) (val3_delta31 s) _ hk
  simpa [itraj31] using this

/-- The Jacobsthal numbers to `J₁₅`. -/
theorem jacobsthal_values : (List.range 16).map jacobsthal
    = [0, 1, 1, 3, 5, 11, 21, 43, 85, 171, 341, 683, 1365, 2731, 5461, 10923] := by decide

/-- The divisors of the 3D box carry the prime 3 through `12 = 2·|(−1, −1, 2)|²`. -/
theorem divisors_3D : 12 ∈ (List.range R31.n).map R31.D := by decide +kernel

end Gephyrosis
