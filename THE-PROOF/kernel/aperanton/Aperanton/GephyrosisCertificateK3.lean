import Aperanton.GephyrosisCertificate2D

/-!
# ΓΕΦΥΡΩΣΙΣ — Theorem I on an orbit: the 2D box `K = 3`

The box `|k|_∞ ≤ 3` has 48 coordinates and the divisors `2|e_k|² ∈ {2, 4, 8, 10, 16, 18, 20, 26,
36}`: the prime 3 divides the divisors of the modes `(3,0), (0,3), (3,3)` (`|k|² = 9, 18`), and
the primes 5 and 13 are the box's ramified primes (`𝔑(3) = 65`). Theorem I says that 3 never
enters a denominator (a prime `≡ 3 (mod 4)` divides a norm only through both coordinates, and
Theorem G's `p^{2j}` then pays for the divisor), and Theorem V says the 5-adic and 13-adic pole
orders are `2^{s−1}`. The integer road with

  `Δ_s = 2^{J_{s+1}} · 5^{2^{s−1}} · 13^{2^{s−1}}` — no factor of 3 —

is checked exact for ten steps of seed 5, with the 5- and 13-adic bounds attained at every step:
the exactness IS Theorem I on this orbit, and the kernel decides it.
-/

namespace Gephyrosis

def R23 : Road := road2D 3

/-- `Δ_s = 2^{J_{s+1}} 5^{2^{s−1}} 13^{2^{s−1}}`, `Δ_0 = 1`. -/
def delta23 (s : ℕ) : ℕ := 2 ^ expTwo s * 5 ^ expFive s * 13 ^ expFive s

theorem delta23_pos (s : ℕ) : delta23 s ≠ 0 := by unfold delta23; positivity

theorem delta23_zero : delta23 0 = 1 := by unfold delta23 expTwo expFive; norm_num

theorem delta23_dvd (s : ℕ) : delta23 s ∣ delta23 (s + 1) := by
  unfold delta23
  exact Nat.mul_dvd_mul
    (Nat.mul_dvd_mul (Nat.pow_dvd_pow 2 (expTwo_mono s)) (Nat.pow_dvd_pow 5 (expFive_mono s)))
    (Nat.pow_dvd_pow 13 (expFive_mono s))

theorem R23_D_ne (k : ℕ) (hk : k < R23.n) : R23.D k ≠ 0 := by
  have : (List.range R23.n).all (fun k => decide (R23.D k ≠ 0)) = true := by
    decide +kernel
  rw [List.all_eq_true] at this
  have := this k (List.mem_range.2 hk)
  simpa using this

/-- The rational orbit of a seed at `K = 3`. -/
def rorbit23 (seed : ℕ) : ℕ → List ℚ
  | 0 => (seedData seed R23.n).map fun z => (z : ℚ)
  | n + 1 => stepI R23 (rorbit23 seed n)

theorem rorbit23_eq_iterate (seed s : ℕ) :
    rorbit23 seed s = (stepI R23)^[s] ((seedData seed R23.n).map fun z => (z : ℚ)) := by
  induction s with
  | zero => rfl
  | succ s ih => rw [Function.iterate_succ_apply', ← ih]; rfl

/-- The integer trajectory at `K = 3`. -/
def itraj23 (seed n : ℕ) : List (List ℤ) :=
  itrajAux R23 delta23 0 n (seedData seed R23.n)

theorem orbit23_of_exact (seed n : ℕ)
    (hex : itrajExact R23 delta23 0 n (seedData seed R23.n) = true) (s : ℕ) (hs : s ≤ n) :
    rorbit23 seed s
      = ((itraj23 seed n).getD s []).map fun x : ℤ => (x : ℚ) / (delta23 s : ℚ) := by
  rw [rorbit23_eq_iterate]
  exact orbit_of_exact R23 delta23 delta23_pos delta23_dvd R23_D_ne delta23_zero _ n hex s hs

/-! ## Valuations of `x / (2^a 5^b 13^b)` -/

theorem val5_delta23 (s : ℕ) (x : ℤ) (hx : x ≠ 0) :
    padicValRat 5 ((x : ℚ) / (delta23 s : ℚ)) = padicValInt 5 x - expFive s := by
  have : Fact (Nat.Prime 5) := ⟨by norm_num⟩
  rw [padicValRat_div_nat 5 x _ hx (delta23_pos s)]
  congr 1
  unfold delta23
  rw [show 2 ^ expTwo s * 5 ^ expFive s * 13 ^ expFive s
      = 5 ^ expFive s * (2 ^ expTwo s * 13 ^ expFive s) by ring]
  rw [padicValNat_prime_pow_mul 5 _ _ (by positivity)
    (prime_not_dvd_pow_mul_pow (by norm_num) Nat.prime_two (by norm_num) (by norm_num) (by norm_num) _ _)]

theorem val13_delta23 (s : ℕ) (x : ℤ) (hx : x ≠ 0) :
    padicValRat 13 ((x : ℚ) / (delta23 s : ℚ)) = padicValInt 13 x - expFive s := by
  have : Fact (Nat.Prime 13) := ⟨by norm_num⟩
  rw [padicValRat_div_nat 13 x _ hx (delta23_pos s)]
  congr 1
  unfold delta23
  rw [show 2 ^ expTwo s * 5 ^ expFive s * 13 ^ expFive s
      = 13 ^ expFive s * (2 ^ expTwo s * 5 ^ expFive s) by ring]
  rw [padicValNat_prime_pow_mul 13 _ _ (by positivity)
    (prime_not_dvd_pow_mul_pow (by norm_num) Nat.prime_two Nat.prime_five (by norm_num) (by norm_num) _ _)]

/-- The prime 3 is absent from `Δ_s`: `v₃(x/Δ_s) = v₃(x)`. -/
theorem val3_delta23 (s : ℕ) (x : ℤ) (hx : x ≠ 0) :
    padicValRat 3 ((x : ℚ) / (delta23 s : ℚ)) = padicValInt 3 x := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  rw [padicValRat_div_nat 3 x _ hx (delta23_pos s)]
  have hv : padicValNat 3 (delta23 s) = 0 := by
    apply padicValNat.eq_zero_of_not_dvd
    unfold delta23
    intro h
    rcases (Nat.Prime.dvd_mul Nat.prime_three).1 h with h1 | h1
    · exact prime_not_dvd_pow_mul_pow Nat.prime_three Nat.prime_two Nat.prime_five
        (by norm_num) (by norm_num) _ _ h1
    · have := Nat.prime_three.dvd_of_dvd_pow h1
      omega
  rw [hv]; simp

/-! ## The certificate -/

/-- THEOREM I ON AN ORBIT. Seed 5 at `K = 3`: the integer road without the prime 3 is exact for
ten steps, and the 5-adic and 13-adic bounds `2^{s−1}` are attained at every step. -/
theorem cert_seed5_K3 :
    (itrajExact R23 delta23 0 10 (seedData 5 R23.n)
      && checkAll R23 delta23 5 (zeros 11) 10 (seedData 5 R23.n)
      && checkAll R23 delta23 13 (zeros 11) 10 (seedData 5 R23.n)) = true := by
  decide +kernel

/-- **Theorem I on the orbit of seed 5 at `K = 3`.** For every step `s ≤ 10`, every coordinate
of the exact rational orbit has nonnegative 3-adic valuation: the prime 3, which divides three of
the box's divisors, never enters a denominator. -/
theorem seed5_K3_three_law (s : ℕ) (hs : s ≤ 10) :
    ∀ q ∈ rorbit23 5 s, 0 ≤ padicValRat 3 q := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  have hc := cert_seed5_K3
  simp only [Bool.and_eq_true] at hc
  rw [orbit23_of_exact 5 10 hc.1.1 s hs]
  exact nonneg_of_val 3 (delta23 s : ℚ) (val3_delta23 s) _

/-- **Theorem V at `K = 3`, p = 5.** The 5-adic pole order of seed 5's orbit is `2^{s−1}` at
every step `1 ≤ s ≤ 10`. -/
theorem seed5_K3_five_law (s : ℕ) (hs : s ≤ 10) :
    (∀ q ∈ rorbit23 5 s, -((expFive s : ℕ) : ℤ) ≤ padicValRat 5 q) ∧
    (∃ q ∈ rorbit23 5 s, padicValRat 5 q = -((expFive s : ℕ) : ℤ)) := by
  have : Fact (Nat.Prime 5) := ⟨by norm_num⟩
  have hc := cert_seed5_K3
  simp only [Bool.and_eq_true] at hc
  rw [orbit23_of_exact 5 10 hc.1.1 s hs]
  have hk := check_of_checkAll R23 delta23 5 10 (zeros 11) _ hc.1.2 s hs (by simp [zeros])
  rw [show (zeros 11).getD s 0 = 0 from getD_zeros 11 s] at hk
  have := law_of_check 5 (delta23 s : ℚ) (expFive s) 0 (Nat.zero_le _) (val5_delta23 s) _ hk
  simpa [itraj23] using this

/-- **Theorem V at `K = 3`, p = 13.** The 13-adic pole order of seed 5's orbit is `2^{s−1}` at
every step `1 ≤ s ≤ 10`. -/
theorem seed5_K3_thirteen_law (s : ℕ) (hs : s ≤ 10) :
    (∀ q ∈ rorbit23 5 s, -((expFive s : ℕ) : ℤ) ≤ padicValRat 13 q) ∧
    (∃ q ∈ rorbit23 5 s, padicValRat 13 q = -((expFive s : ℕ) : ℤ)) := by
  have : Fact (Nat.Prime 13) := ⟨by norm_num⟩
  have hc := cert_seed5_K3
  simp only [Bool.and_eq_true] at hc
  rw [orbit23_of_exact 5 10 hc.1.1 s hs]
  have hk := check_of_checkAll R23 delta23 13 10 (zeros 11) _ hc.2 s hs (by simp [zeros])
  rw [show (zeros 11).getD s 0 = 0 from getD_zeros 11 s] at hk
  have := law_of_check 13 (delta23 s : ℚ) (expFive s) 0 (Nat.zero_le _) (val13_delta23 s) _ hk
  simpa [itraj23] using this

/-- The divisors of the box `K = 3` carry the prime 3: `2|e_k|² = 18` and `36` occur. -/
theorem divisors_K3 : 18 ∈ (List.range R23.n).map R23.D ∧ 36 ∈ (List.range R23.n).map R23.D := by
  decide +kernel

end Gephyrosis
