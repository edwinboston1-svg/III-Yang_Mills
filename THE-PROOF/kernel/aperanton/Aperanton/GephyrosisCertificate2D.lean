import Aperanton.GephyrosisOrbit

/-!
# ΓΕΦΥΡΩΣΙΣ — the prime-denominator laws of the 2D box `K = 2`, kernel-checked on the exact orbits

Each certificate below is ONE kernel evaluation of the integer road (`GephyrosisOrbit`): the
trajectory of a seed is computed with the a-priori common denominator `Δ_s` of Addendum IV,
every division is checked exact, and at every step the least `p`-adic valuation of the
integer state is checked against a staked deficit `d_s`. The bridge lemma `rational_orbit_eq`
then turns the computation into a statement about the rational orbit of the Galerkin–Euler map:
the largest `p`-adic pole order among the coordinates at step `s` is exactly
`(exponent of p in Δ_s) − d_s`.

* **Theorem V on the numbers (seed 5, p = 5):** the 5-adic pole order is `2^{s−1}` at every
  step `1 ≤ s ≤ 14` — denominators `5, 25, 625, …, 5^{8192}`.
* **The Jacobsthal law on the numbers (seed 19, p = 2):** the 2-adic pole order is
  `J_{s+1} = (2^{s+1} + (−1)^s)/3` at every step `1 ≤ s ≤ 14` — `1, 3, 5, 11, 21, …, 10923`;
  Addendum V's first eternal law, read here as far as the numbers can be written.
* **How a law dies (seed 24, p = 5):** the pole orders `1, 2, 4, 8, 15, 31, 62, 124, 248, 496,
  991, 1981` — the bound `2^{s−1}` is attained for four steps, then the deficit
  `0, 0, 0, 0, 1, 1, 2, 4, 8, 16, 33, 67` opens and never closes (the exact road's own sequence,
  Addendum IV / Addendum V's M-1).
-/

namespace Gephyrosis

/-- The check at one step: every coordinate divisible by `p^d`, some coordinate not by `p^{d+1}`. -/
def deficitCheck (p d : ℕ) (X : List ℤ) : Bool :=
  X.all (fun x => x % ((p : ℤ) ^ d) = 0) && X.any (fun x => x % ((p : ℤ) ^ (d + 1)) ≠ 0)

/-- The deficit check at every step of a trajectory against a schedule `ds`. -/
def checkAll (R : Road) (Δ : ℕ → ℕ) (p : ℕ) (ds : List ℕ) (n : ℕ) (X0 : List ℤ) : Bool :=
  ((itrajAux R Δ 0 n X0).zip ds).all (fun q => deficitCheck p q.2 q.1)

/-- The certificate of a trajectory: exactness, and the deficit check at every step. -/
def certify (R : Road) (Δ : ℕ → ℕ) (p : ℕ) (ds : List ℕ) (n : ℕ) (X0 : List ℤ) : Bool :=
  itrajExact R Δ 0 n X0 && checkAll R Δ p ds n X0

theorem deficitCheck_iff (p d : ℕ) (X : List ℤ) :
    deficitCheck p d X = true ↔
      (∀ x ∈ X, x % ((p : ℤ) ^ d) = 0) ∧ (∃ x ∈ X, x % ((p : ℤ) ^ (d + 1)) ≠ 0) := by
  unfold deficitCheck
  simp [List.all_eq_true, List.any_eq_true]

/-- THE LAW FROM THE CHECK. If `X` passes the deficit check at `p` with deficit `d ≤ e`, and the
`p`-adic valuation of `x/Δ` is `v_p(x) − e` for nonzero `x`, then the pole orders of `X/Δ` are
at most `e − d` and that value is attained. -/
theorem law_of_check (p : ℕ) [hp : Fact p.Prime] (Δ : ℚ) (e d : ℕ) (hde : d ≤ e)
    (hv : ∀ x : ℤ, x ≠ 0 → padicValRat p ((x : ℚ) / Δ) = padicValInt p x - e)
    (X : List ℤ) (hc : deficitCheck p d X = true) :
    (∀ q ∈ X.map (fun x : ℤ => (x : ℚ) / Δ), -((e - d : ℕ) : ℤ) ≤ padicValRat p q) ∧
    (∃ q ∈ X.map (fun x : ℤ => (x : ℚ) / Δ), padicValRat p q = -((e - d : ℕ) : ℤ)) := by
  obtain ⟨hall, x, hxX, hx⟩ := (deficitCheck_iff p d X).1 hc
  have hdvd_of : ∀ y ∈ X, (p : ℤ) ^ d ∣ y := fun y hy => Int.dvd_of_emod_eq_zero (hall y hy)
  constructor
  · intro q hq
    rw [List.mem_map] at hq
    obtain ⟨y, hyX, rfl⟩ := hq
    by_cases hy0 : y = 0
    · subst hy0; simp
    · rw [hv y hy0]
      have h1 := hdvd_of y hyX
      rw [padicValInt_dvd_iff] at h1
      rcases h1 with h1 | h1
      · exact absurd h1 hy0
      · omega
  · refine ⟨(x : ℚ) / Δ, List.mem_map.2 ⟨x, hxX, rfl⟩, ?_⟩
    have hx0 : x ≠ 0 := by
      rintro rfl; apply hx; simp
    rw [hv x hx0]
    have h1 := hdvd_of x hxX
    rw [padicValInt_dvd_iff] at h1
    have h2 : ¬ (p : ℤ) ^ (d + 1) ∣ x := fun hd => hx (Int.emod_eq_zero_of_dvd hd)
    rw [padicValInt_dvd_iff, not_or, not_le] at h2
    rcases h1 with h1 | h1
    · exact absurd h1 hx0
    · have h3 := h2.2
      omega

/-- A prime that never enters a denominator: with `v_p(x/Δ) = v_p(x)` for nonzero `x`, every
coordinate of `X/Δ` has nonnegative `p`-adic valuation. -/
theorem nonneg_of_val (p : ℕ) [Fact p.Prime] (Δ : ℚ)
    (hv : ∀ x : ℤ, x ≠ 0 → padicValRat p ((x : ℚ) / Δ) = padicValInt p x) (X : List ℤ) :
    ∀ q ∈ X.map (fun x : ℤ => (x : ℚ) / Δ), 0 ≤ padicValRat p q := by
  intro q hq
  rw [List.mem_map] at hq
  obtain ⟨y, _, rfl⟩ := hq
  by_cases hy0 : y = 0
  · subst hy0; simp
  · rw [hv y hy0]; exact Int.natCast_nonneg _

/-- The deficit check at step `s`, read off `checkAll`. -/
theorem check_of_checkAll (R : Road) (Δ : ℕ → ℕ) (p n : ℕ) (ds : List ℕ) (X0 : List ℤ)
    (hc : checkAll R Δ p ds n X0 = true) (s : ℕ) (hs : s ≤ n) (hlen : n + 1 ≤ ds.length) :
    deficitCheck p (ds.getD s 0) ((itrajAux R Δ 0 n X0).getD s []) = true := by
  unfold checkAll at hc
  rw [List.all_eq_true] at hc
  have hlenT := itrajAux_length R Δ n 0 X0
  have hlt : s < (itrajAux R Δ 0 n X0).length := by omega
  have hlt' : s < ds.length := by omega
  have hmem : ((itrajAux R Δ 0 n X0).getD s [], ds.getD s 0) ∈ (itrajAux R Δ 0 n X0).zip ds := by
    rw [List.mem_iff_getElem]
    refine ⟨s, ?_, ?_⟩
    · rw [List.length_zip]; omega
    · rw [List.getElem_zip]
      simp [List.getD_eq_getElem?_getD, List.getElem?_eq_getElem hlt, List.getElem?_eq_getElem hlt']
  exact hc _ hmem

theorem getD_zeros (n s : ℕ) : (List.replicate n (0 : ℕ)).getD s 0 = 0 := by
  induction n generalizing s with
  | zero => simp
  | succ n ih =>
    cases s with
    | zero => simp
    | succ s => simp only [List.replicate_succ, List.getD_cons_succ]; exact ih s

/-- The rational orbit of a road from an integer seed, read off an exact integer road with
`Δ_0 = 1`. -/
theorem orbit_of_exact (R : Road) (Δ : ℕ → ℕ) (hΔ : ∀ s, Δ s ≠ 0) (hdvd : ∀ s, Δ s ∣ Δ (s + 1))
    (hD : ∀ k < R.n, R.D k ≠ 0) (h0 : Δ 0 = 1) (X0 : List ℤ) (n : ℕ)
    (hex : itrajExact R Δ 0 n X0 = true) (s : ℕ) (hs : s ≤ n) :
    (stepI R)^[s] (X0.map fun z : ℤ => (z : ℚ))
      = ((itrajAux R Δ 0 n X0).getD s []).map fun x : ℤ => (x : ℚ) / (Δ s : ℚ) := by
  have := rational_orbit_eq R Δ hΔ hdvd hD n 0 X0 hex s hs
  have h1 : (X0.map fun x : ℤ => (x : ℚ) / (Δ 0 : ℚ)) = X0.map fun z : ℤ => (z : ℚ) := by
    apply List.map_congr_left
    intro x _
    rw [h0]; simp
  rw [h1, Nat.zero_add] at this
  exact this

/-! ## The 2D box `K = 2` -/

theorem rorbit22_eq_iterate (seed s : ℕ) :
    rorbit22 seed s = (stepI R22)^[s] ((seedData seed R22.n).map fun z => (z : ℚ)) := by
  induction s with
  | zero => rfl
  | succ s ih => rw [Function.iterate_succ_apply', ← ih]; rfl

theorem delta22_zero : delta22 0 = 1 := by unfold delta22 expTwo expFive; norm_num

/-- `v₅(Δ_s) = 2^{s−1}` and `v₂(Δ_s) = J_{s+1}`. -/
theorem val5_delta22 (s : ℕ) (x : ℤ) (hx : x ≠ 0) :
    padicValRat 5 ((x : ℚ) / (delta22 s : ℚ)) = padicValInt 5 x - expFive s := by
  have : Fact (Nat.Prime 5) := ⟨by norm_num⟩
  rw [padicValRat_div_nat 5 x _ hx (delta22_pos s)]
  congr 1
  unfold delta22
  rw [mul_comm]
  rw [padicValNat_prime_pow_mul 5 _ _ (by positivity)
    (fun h => by have := Nat.prime_five.dvd_of_dvd_pow h; omega)]

theorem val2_delta22 (s : ℕ) (x : ℤ) (hx : x ≠ 0) :
    padicValRat 2 ((x : ℚ) / (delta22 s : ℚ)) = padicValInt 2 x - expTwo s := by
  have : Fact (Nat.Prime 2) := ⟨by norm_num⟩
  rw [padicValRat_div_nat 2 x _ hx (delta22_pos s)]
  congr 1
  unfold delta22
  rw [padicValNat_prime_pow_mul 2 _ _ (by positivity)
    (fun h => by have := Nat.prime_two.dvd_of_dvd_pow h; omega)]

theorem orbit22_of_exact (seed n : ℕ)
    (hex : itrajExact R22 delta22 0 n (seedData seed R22.n) = true) (s : ℕ) (hs : s ≤ n) :
    rorbit22 seed s
      = ((itraj22 seed n).getD s []).map fun x : ℤ => (x : ℚ) / (delta22 s : ℚ) := by
  rw [rorbit22_eq_iterate]
  exact orbit_of_exact R22 delta22 delta22_pos delta22_dvd R22_D_ne delta22_zero _ n hex s hs

/-! ## The certificates -/

/-- The deficit schedules. -/
def zeros (n : ℕ) : List ℕ := List.replicate n 0

/-- seed 24's deficit at 5, steps 0 … 12: the bound `2^{s−1}` holds through step 4 and dies. -/
def deficits24 : List ℕ := [0, 0, 0, 0, 0, 1, 1, 2, 4, 8, 16, 33, 67]

/-- The pole orders `2^{s−1} − d_s` of seed 24: `1, 2, 4, 8, 15, 31, 62, 124, 248, 496, 991, 1981`. -/
theorem deficits24_poles :
    (List.range 13).map (fun s => expFive s - deficits24.getD s 0)
      = [0, 1, 2, 4, 8, 15, 31, 62, 124, 248, 496, 991, 1981] := by
  decide

/-- THEOREM V ON THE NUMBERS. Seed 5 at the 2D box `K = 2`: the integer road with
`Δ_s = 2^{J_{s+1}} 5^{2^{s−1}}` is exact for fourteen steps and the 5-adic bound is attained at
every one of them. -/
theorem cert_seed5_five : certify R22 delta22 5 (zeros 15) 14 (seedData 5 R22.n) = true := by
  decide +kernel

/-- THE JACOBSTHAL LAW ON THE NUMBERS. Seed 19: the 2-adic bound `J_{s+1}` is attained at every
step `s ≤ 14`. -/
theorem cert_seed19_two : certify R22 delta22 2 (zeros 15) 14 (seedData 19 R22.n) = true := by
  decide +kernel

/-- HOW A LAW DIES. Seed 24: the deficits `0, 0, 0, 0, 1, 1, 2, 4, 8, 16, 33, 67` at 5. -/
theorem cert_seed24_five : certify R22 delta22 5 deficits24 12 (seedData 24 R22.n) = true := by
  decide +kernel

/-! ## The laws, as statements about the rational orbit -/

/-- **Theorem V on the orbit of seed 5.** At every step `1 ≤ s ≤ 14` of the exact rational orbit
of ΔΙΝΟΣ' seed 5 in the 2D box `K = 2`, every coordinate has 5-adic valuation at least
`−2^{s−1}`, and some coordinate has valuation exactly `−2^{s−1}`. -/
theorem seed5_five_law (s : ℕ) (hs : s ≤ 14) :
    (∀ q ∈ rorbit22 5 s, -((expFive s : ℕ) : ℤ) ≤ padicValRat 5 q) ∧
    (∃ q ∈ rorbit22 5 s, padicValRat 5 q = -((expFive s : ℕ) : ℤ)) := by
  have : Fact (Nat.Prime 5) := ⟨by norm_num⟩
  have hc := cert_seed5_five
  unfold certify at hc
  rw [Bool.and_eq_true] at hc
  rw [orbit22_of_exact 5 14 hc.1 s hs]
  have hk := check_of_checkAll R22 delta22 5 14 (zeros 15) _ hc.2 s hs (by simp [zeros])
  rw [show (zeros 15).getD s 0 = 0 from getD_zeros 15 s] at hk
  have := law_of_check 5 (delta22 s : ℚ) (expFive s) 0 (Nat.zero_le _) (val5_delta22 s) _ hk
  simpa [itraj22] using this

/-- **The Jacobsthal law on the orbit of seed 19.** At every step `1 ≤ s ≤ 14`, every coordinate
has 2-adic valuation at least `−J_{s+1}` and some coordinate attains it:
`1, 3, 5, 11, 21, 43, 85, 171, 341, 683, 1365, 2731, 5461, 10923`. -/
theorem seed19_two_law (s : ℕ) (hs : s ≤ 14) :
    (∀ q ∈ rorbit22 19 s, -((expTwo s : ℕ) : ℤ) ≤ padicValRat 2 q) ∧
    (∃ q ∈ rorbit22 19 s, padicValRat 2 q = -((expTwo s : ℕ) : ℤ)) := by
  have : Fact (Nat.Prime 2) := ⟨by norm_num⟩
  have hc := cert_seed19_two
  unfold certify at hc
  rw [Bool.and_eq_true] at hc
  rw [orbit22_of_exact 19 14 hc.1 s hs]
  have hk := check_of_checkAll R22 delta22 2 14 (zeros 15) _ hc.2 s hs (by simp [zeros])
  rw [show (zeros 15).getD s 0 = 0 from getD_zeros 15 s] at hk
  have := law_of_check 2 (delta22 s : ℚ) (expTwo s) 0 (Nat.zero_le _) (val2_delta22 s) _ hk
  simpa [itraj22] using this

/-- The Jacobsthal exponents, as the sequence they are. -/
theorem expTwo_values : (List.range 15).map expTwo
    = [0, 1, 3, 5, 11, 21, 43, 85, 171, 341, 683, 1365, 2731, 5461, 10923] := by decide

theorem expFive_values : (List.range 15).map expFive
    = [0, 1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192] := by decide

/-- **How a law dies, on the orbit of seed 24.** At step `s ≤ 12` the largest 5-adic pole order
is `2^{s−1} − d_s` with the deficits `d = 0, 0, 0, 0, 0, 1, 1, 2, 4, 8, 16, 33, 67`:
`1, 2, 4, 8, 15, 31, 62, 124, 248, 496, 991, 1981`. -/
theorem seed24_five_law (s : ℕ) (hs : s ≤ 12) :
    (∀ q ∈ rorbit22 24 s, -((expFive s - deficits24.getD s 0 : ℕ) : ℤ) ≤ padicValRat 5 q) ∧
    (∃ q ∈ rorbit22 24 s, padicValRat 5 q = -((expFive s - deficits24.getD s 0 : ℕ) : ℤ)) := by
  have : Fact (Nat.Prime 5) := ⟨by norm_num⟩
  have hc := cert_seed24_five
  unfold certify at hc
  rw [Bool.and_eq_true] at hc
  rw [orbit22_of_exact 24 12 hc.1 s hs]
  have hk := check_of_checkAll R22 delta22 5 12 deficits24 _ hc.2 s hs (by simp [deficits24])
  have hde : deficits24.getD s 0 ≤ expFive s := by
    have h : ∀ s < 13, deficits24.getD s 0 ≤ expFive s := by decide
    exact h s (by omega)
  have := law_of_check 5 (delta22 s : ℚ) (expFive s) (deficits24.getD s 0) hde (val5_delta22 s) _ hk
  simpa [itraj22] using this

end Gephyrosis
