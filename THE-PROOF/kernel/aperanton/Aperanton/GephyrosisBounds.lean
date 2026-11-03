import Aperanton.GephyrosisEternal

/-!
# ΓΕΦΥΡΩΣΙΣ — the bounds for EVERY seed, and Theorem I on every orbit

The profile `t(s)` of the one-digit automaton never looks at the residues (Theorem T), so it is
the same for every integer seed, and Theorem D's closure for the profile alone turns a few steps
of the max-plus recursion into the BOUND of Addendum IV for every seed and every step:

* 2D, `K = 2`, the prime 5: `−v₅(c_k(s)) ≤ 2^{s−1}` (Theorem V's bound), for every integer seed;
* 2D, `K = 2`, the prime 2: `−v₂(c_k(s)) ≤ J_{s+1}`, for every integer seed;
* 2D, `K = 3`, the primes 5 and 13: `≤ 2^{s−1}`, for every integer seed;
* 3D, `K = 1`, the prime 3: `−v₃(c_k(s)) ≤ J_s` (Theorem J's bound), for every integer seed;
* **THEOREM I ON EVERY ORBIT**: in the 2D box `K = 3`, whose divisors carry the prime 3 at the
  shells `|k|² = 9, 18`, NO coordinate of ANY integer seed's orbit EVER has 3 in its denominator —
  the division by `2|k|²` there is an identity, not an operation (a prime `≡ 3 (mod 4)` never
  ramifies the flow: Addendum IV §11).
-/

namespace Gephyrosis

section Profile

variable {p : ℕ} [hp : Fact p.Prime]

/-- The profile does not depend on the seed. -/
theorem profile_indep (R : Road) (c0 c0' : List ℤ) (s : ℕ) :
    (autoOrbit R p c0 s).1 = (autoOrbit R p c0' s).1 := by
  induction s with
  | zero => rfl
  | succ s ih =>
    show (List.range R.n).map (tNext R p (autoOrbit R p c0 s).1)
      = (List.range R.n).map (tNext R p (autoOrbit R p c0' s).1)
    rw [ih]

/-- THEOREM D FOR THE PROFILE ALONE: a turn that returns shifted returns forever. -/
theorem closure_profile (R : Road) (c0 : List ℤ) (hwf : Wellformed R) (M L : ℕ) (hL : 0 < L)
    (c : ℤ) (hc : 0 ≤ c)
    (hclose : (autoOrbit R p c0 (M + L)).1 = (autoOrbit R p c0 M).1.map (· + c))
    (hNA : ∀ i < L, NonAttain R p (autoOrbit R p c0 (M + i)).1) :
    ∀ i, (autoOrbit R p c0 (M + L + i)).1 = (autoOrbit R p c0 (M + i)).1.map (· + c * 2 ^ i)
      ∧ NonAttain R p (autoOrbit R p c0 (M + i)).1 := by
  intro i
  induction i using Nat.strong_induction_on with
  | _ i ih =>
    have hna_i : NonAttain R p (autoOrbit R p c0 (M + i)).1 := by
      by_cases hi : i < L
      · exact hNA i hi
      · have hiL : i - L < i := by omega
        obtain ⟨heq, hna'⟩ := ih (i - L) hiL
        have hMi : M + i = M + L + (i - L) := by omega
        rw [hMi, heq]
        exact nonAttain_shift R p _ _ hwf (orbit_len (p := p) R c0 _).1 (by positivity) hna'
    refine ⟨?_, hna_i⟩
    cases i with
    | zero => simpa using hclose
    | succ i =>
      obtain ⟨heq, hna⟩ := ih i (Nat.lt_succ_self i)
      have h1 : (autoOrbit R p c0 (M + L + (i + 1))).1
          = (List.range R.n).map (tNext R p (autoOrbit R p c0 (M + L + i)).1) := by
        rw [show M + L + (i + 1) = (M + L + i) + 1 by omega]
        rfl
      have h2 : (autoOrbit R p c0 (M + (i + 1))).1
          = (List.range R.n).map (tNext R p (autoOrbit R p c0 (M + i)).1) := by
        rw [show M + (i + 1) = (M + i) + 1 by omega]
        rfl
      rw [h1, h2, heq, List.map_map]
      apply List.map_congr_left
      intro k hk
      rw [List.mem_range] at hk
      simp only [Function.comp]
      rw [tNext_shift R p _ _ k hk hwf (orbit_len (p := p) R c0 _).1 (by positivity) hna]
      ring

theorem top_shift_profile (R : Road) (c0 : List ℤ) (hwf : Wellformed R) (M L : ℕ) (hL : 0 < L)
    (c : ℤ) (hc : 0 ≤ c)
    (hclose : (autoOrbit R p c0 (M + L)).1 = (autoOrbit R p c0 M).1.map (· + c))
    (hNA : ∀ i < L, NonAttain R p (autoOrbit R p c0 (M + i)).1) (hn : 0 < R.n) (i : ℕ) :
    topOf R p c0 (M + L + i) = topOf R p c0 (M + i) + c * 2 ^ i := by
  unfold topOf
  rw [(closure_profile R c0 hwf M L hL c hc hclose hNA i).1]
  exact maxL_map_add _ (List.ne_nil_of_length_pos
    (by rw [(orbit_len (p := p) R c0 _).1]; exact hn)) _

/-- A one-step closure with shift `c` from `T(1) = c` gives `T(s) = c·2^{s−1}`. -/
theorem top_geom_of_closure (R : Road) (c0 : List ℤ) (hwf : Wellformed R) (c : ℤ) (hc : 0 ≤ c)
    (hclose : (autoOrbit R p c0 2).1 = (autoOrbit R p c0 1).1.map (· + c))
    (hNA : NonAttain R p (autoOrbit R p c0 1).1) (hn : 0 < R.n) (h1 : topOf R p c0 1 = c) :
    ∀ s, 1 ≤ s → topOf R p c0 s = c * 2 ^ (s - 1) := by
  have hNA' : ∀ i < 1, NonAttain R p (autoOrbit R p c0 (1 + i)).1 := by
    intro i hi
    have : i = 0 := by omega
    subst this
    exact hNA
  have key : ∀ i, topOf R p c0 (1 + i) = c * 2 ^ i := by
    intro i
    induction i with
    | zero => simpa using h1
    | succ i ih =>
      have := top_shift_profile R c0 hwf 1 1 (by norm_num) c hc hclose hNA' hn i
      rw [show 1 + 1 + i = 1 + (i + 1) by omega] at this
      rw [this, ih]
      ring
  intro s hs
  have := key (s - 1)
  rwa [show 1 + (s - 1) = s by omega] at this

/-- A two-step closure with shift `2^{M+δ}` from `T(M) = J_{M+δ}`, `T(M+1) = J_{M+1+δ}` gives
`T(s) = J_{s+δ}` for all `s ≥ M`. -/
theorem top_jac_of_closure (R : Road) (c0 : List ℤ) (hwf : Wellformed R) (M δ : ℕ)
    (hclose : (autoOrbit R p c0 (M + 2)).1 = (autoOrbit R p c0 M).1.map (· + 2 ^ (M + δ)))
    (hNA : ∀ i < 2, NonAttain R p (autoOrbit R p c0 (M + i)).1) (hn : 0 < R.n)
    (h0 : topOf R p c0 M = (jacobsthal (M + δ) : ℤ))
    (h1 : topOf R p c0 (M + 1) = (jacobsthal (M + 1 + δ) : ℤ)) :
    ∀ s, M ≤ s → topOf R p c0 s = (jacobsthal (s + δ) : ℤ) := by
  have key : ∀ i, topOf R p c0 (M + i) = (jacobsthal (M + i + δ) : ℤ) := by
    intro i
    induction i using Nat.strong_induction_on with
    | _ i ih =>
      match i with
      | 0 => simpa using h0
      | 1 => simpa using h1
      | i + 2 =>
        have hs := top_shift_profile R c0 hwf M 2 (by norm_num) (2 ^ (M + δ)) (by positivity)
          hclose hNA hn i
        rw [show M + 2 + i = M + (i + 2) by omega] at hs
        rw [hs, ih i (by omega)]
        have hJ := jacobsthal_add_two (M + i + δ)
        rw [show M + (i + 2) + δ = M + i + δ + 2 by omega, hJ]
        push_cast
        ring
  intro s hs
  have := key (s - M)
  rwa [show M + (s - M) = s by omega] at this

/-- THE BOUND FOR EVERY SEED, live or dead: no nonzero coordinate exceeds `T(s)`. -/
theorem bound_of_top (R : Road) (hD : ∀ k < R.n, R.D k ≠ 0) (c0 : List ℤ) (s : ℕ) :
    ∀ k < R.n, (ratOrbit R c0 s).getD k 0 ≠ 0 →
      -padicValRat p ((ratOrbit R c0 s).getD k 0) ≤ topOf R p c0 s := by
  intro k hk hne
  have ht := getD_le_top (p := p) R c0 s k hk
  by_cases hr : (autoOrbit R p c0 s).2.getD k 0 = 0
  · rcases pole_of_dead R hD c0 s k hr with h | h
    · exact absurd h hne
    · linarith
  · have := (pole_of_live R hD c0 s k hr (res_lt (p := p) R c0 s k)).2
    linarith

/-! ## Theorem I on every orbit: a profile that never leaves zero -/

/-- every term's coefficient carries at least the divisor's power of `p` -/
def integralCheck (R : Road) (p : ℕ) : Bool :=
  (List.range R.n).all fun k =>
    (R.tb.getD k []).all fun tm => decide (vpI p (R.D k) ≤ vpI p tm.T)

theorem maxL_le_of_forall {l : List ℤ} {b : ℤ} (hb : 0 ≤ b) (h : ∀ x ∈ l, x ≤ b) :
    maxL l ≤ b := by
  cases l with
  | nil => simpa [maxL] using hb
  | cons a l =>
    simp only [maxL]
    have hall : ∀ x ∈ a :: l, x ≤ b := h
    clear h
    induction l generalizing a with
    | nil => exact hall a (List.mem_cons_self ..)
    | cons c l ih =>
      simp only [List.foldl_cons]
      apply ih (max a c)
      intro x hx
      rcases List.mem_cons.mp hx with rfl | hx
      · exact max_le (hall a (List.mem_cons_self ..))
          (hall c (List.mem_cons_of_mem _ (List.mem_cons_self ..)))
      · exact hall x (List.mem_cons_of_mem _ (List.mem_cons_of_mem _ hx))

theorem profile_nonpos (R : Road) (hchk : integralCheck R p = true) (c0 : List ℤ) :
    ∀ s k, (autoOrbit R p c0 s).1.getD k 0 ≤ 0 := by
  intro s
  induction s with
  | zero =>
    intro k
    show ((List.range R.n).map _).getD k 0 ≤ 0
    rw [getD_map_range]
    split_ifs <;> exact le_rfl
  | succ s ih =>
    intro k
    show ((List.range R.n).map (tNext R p (autoOrbit R p c0 s).1)).getD k 0 ≤ 0
    rw [getD_map_range]
    split_ifs with hk
    · unfold integralCheck at hchk
      rw [List.all_eq_true] at hchk
      have hk' := hchk k (List.mem_range.2 hk)
      rw [List.all_eq_true] at hk'
      have hq : qmax R p (autoOrbit R p c0 s).1 k ≤ 0 := by
        unfold qmax
        apply maxL_le_of_forall le_rfl
        intro x hx
        rw [List.mem_map] at hx
        obtain ⟨tm, hm, rfl⟩ := hx
        have h1 := ih tm.a
        have h2 := ih tm.b
        have h3 := of_decide_eq_true (hk' tm hm)
        unfold qscale
        omega
      unfold tNext
      split_ifs
      · exact hq
      · apply max_le _ hq
        unfold lscale
        have := ih k
        omega
    · exact le_rfl

/-- THEOREM I ON AN ORBIT, EVERY STEP: a nonzero coordinate has nonnegative `p`-adic valuation. -/
theorem integral_of_check (R : Road) (hD : ∀ k < R.n, R.D k ≠ 0) (hchk : integralCheck R p = true)
    (c0 : List ℤ) (s k : ℕ) (hne : (ratOrbit R c0 s).getD k 0 ≠ 0) :
    0 ≤ padicValRat p ((ratOrbit R c0 s).getD k 0) := by
  have ht := profile_nonpos R hchk c0 s k
  by_cases hr : (autoOrbit R p c0 s).2.getD k 0 = 0
  · rcases pole_of_dead R hD c0 s k hr with h | h
    · exact absurd h hne
    · linarith
  · have := (pole_of_live R hD c0 s k hr (res_lt (p := p) R c0 s k)).2
    linarith

end Profile

/-! ## The symmetrised roads' orbits are the roads' orbits, for any seed -/

theorem ratOrbit_sym2 (K : ℕ) (c0 : List ℤ) (s : ℕ) :
    ratOrbit (road2Dsym K) c0 s = ratOrbit (road2D K) c0 s := by
  induction s with
  | zero => rfl
  | succ s ih =>
    show stepI (road2Dsym K) _ = stepI (road2D K) _
    rw [ih, stepI_road2Dsym]

theorem ratOrbit_sym3 (c0 : List ℤ) (s : ℕ) :
    ratOrbit (road3Dsym 1) c0 s = ratOrbit (road3Dord 1) c0 s := by
  induction s with
  | zero => rfl
  | succ s ih =>
    show stepI (road3Dsym 1) _ = stepI (road3Dord 1) _
    rw [ih, stepI_road3Dsym]

def zero24 : List ℤ := List.replicate 24 0
def zero48 : List ℤ := List.replicate 48 0
def zero52 : List ℤ := List.replicate 52 0

/-! ## The profile tops, for every seed -/

/-- the profile certificate at (2D, K = 2, p = 5): a one-step closure with shift 1 -/
def certP5 : Bool :=
  wfCheck R22s
  && decide ((autoOrbit R22s 5 zero24 2).1 = (autoOrbit R22s 5 zero24 1).1.map (· + 1))
  && naCheck R22s 5 (autoOrbit R22s 5 zero24 1).1
  && decide (maxL (autoOrbit R22s 5 zero24 1).1 = 1)

theorem certP5_true : certP5 = true := by decide +kernel

/-- `T(s) = 2^{s−1}` at (2D, K = 2, p = 5), for every seed -/
theorem top22_five (c0 : List ℤ) (s : ℕ) (hs : 1 ≤ s) : topOf R22s 5 c0 s = 2 ^ (s - 1) := by
  have : Fact (Nat.Prime 5) := ⟨by norm_num⟩
  have hc := certP5_true
  unfold certP5 at hc
  simp only [Bool.and_eq_true] at hc
  obtain ⟨⟨⟨hwf, hcl⟩, hna⟩, h1⟩ := hc
  have htop := top_geom_of_closure R22s zero24 (wellformed_of_check _ hwf) 1 (by norm_num)
    (of_decide_eq_true hcl) (nonAttain_of_check _ _ _ hna) (by rw [R22s_n]; norm_num)
    (of_decide_eq_true h1) s hs
  unfold topOf at htop ⊢
  rw [profile_indep R22s c0 zero24 s, htop]
  ring

/-- the profile certificate at (2D, K = 2, p = 2): a two-step closure with shift `2^2` from step 1 -/
def certP2 : Bool :=
  wfCheck R22s
  && decide ((autoOrbit R22s 2 zero24 3).1 = (autoOrbit R22s 2 zero24 1).1.map (· + 4))
  && naCheck R22s 2 (autoOrbit R22s 2 zero24 1).1
  && naCheck R22s 2 (autoOrbit R22s 2 zero24 2).1
  && decide (maxL (autoOrbit R22s 2 zero24 1).1 = 1)
  && decide (maxL (autoOrbit R22s 2 zero24 2).1 = 3)

theorem certP2_true : certP2 = true := by decide +kernel

/-- `T(s) = J_{s+1}` at (2D, K = 2, p = 2), for every seed -/
theorem top22_two (c0 : List ℤ) (s : ℕ) (hs : 1 ≤ s) :
    topOf R22s 2 c0 s = (jacobsthal (s + 1) : ℤ) := by
  have : Fact (Nat.Prime 2) := ⟨Nat.prime_two⟩
  have hc := certP2_true
  unfold certP2 at hc
  simp only [Bool.and_eq_true] at hc
  obtain ⟨⟨⟨⟨⟨hwf, hcl⟩, hna1⟩, hna2⟩, h1⟩, h2⟩ := hc
  have hNA : ∀ i < 2, NonAttain R22s 2 (autoOrbit R22s 2 zero24 (1 + i)).1 := by
    intro i hi
    interval_cases i
    · exact nonAttain_of_check _ _ _ hna1
    · exact nonAttain_of_check _ _ _ hna2
  have htop := top_jac_of_closure R22s zero24 (wellformed_of_check _ hwf) 1 1
    (of_decide_eq_true hcl) hNA (by rw [R22s_n]; norm_num)
    (by unfold topOf; rw [of_decide_eq_true h1]; decide)
    (by unfold topOf; rw [of_decide_eq_true h2]; decide) s hs
  unfold topOf at htop ⊢
  rw [profile_indep R22s c0 zero24 s]
  exact htop

/-- the profile certificate at (3D, K = 1, p = 3): a two-step closure with shift `2^2` from step 2 -/
def certP3 : Bool :=
  wfCheck R31s
  && decide ((autoOrbit R31s 3 zero52 4).1 = (autoOrbit R31s 3 zero52 2).1.map (· + 4))
  && naCheck R31s 3 (autoOrbit R31s 3 zero52 2).1
  && naCheck R31s 3 (autoOrbit R31s 3 zero52 3).1
  && decide (maxL (autoOrbit R31s 3 zero52 1).1 = 1)
  && decide (maxL (autoOrbit R31s 3 zero52 2).1 = 1)
  && decide (maxL (autoOrbit R31s 3 zero52 3).1 = 3)

theorem certP3_true : certP3 = true := by decide +kernel

/-- `T(s) = J_s` at (3D, K = 1, p = 3), for every seed -/
theorem top31_three (c0 : List ℤ) (s : ℕ) (hs : 1 ≤ s) :
    topOf R31s 3 c0 s = (jacobsthal s : ℤ) := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  have hc := certP3_true
  unfold certP3 at hc
  simp only [Bool.and_eq_true] at hc
  obtain ⟨⟨⟨⟨⟨⟨hwf, hcl⟩, hna2⟩, hna3⟩, h1⟩, h2⟩, h3⟩ := hc
  have hNA : ∀ i < 2, NonAttain R31s 3 (autoOrbit R31s 3 zero52 (2 + i)).1 := by
    intro i hi
    interval_cases i
    · exact nonAttain_of_check _ _ _ hna2
    · exact nonAttain_of_check _ _ _ hna3
  unfold topOf
  rw [profile_indep R31s c0 zero52 s]
  by_cases h2s : 2 ≤ s
  · have htop := top_jac_of_closure R31s zero52 (wellformed_of_check _ hwf) 2 0
      (of_decide_eq_true hcl) hNA (by rw [R31s_n]; norm_num)
      (by unfold topOf; rw [of_decide_eq_true h2]; decide)
      (by unfold topOf; rw [of_decide_eq_true h3]; decide) s h2s
    unfold topOf at htop
    rwa [Nat.add_zero] at htop
  · have hs1 : s = 1 := by omega
    subst hs1
    rw [of_decide_eq_true h1]
    decide

def R23s : Road := road2Dsym 3

theorem R23s_D_ne (k : ℕ) (hk : k < R23s.n) : R23s.D k ≠ 0 := by
  have : (List.range R23s.n).all (fun k => decide (R23s.D k ≠ 0)) = true := by
    decide +kernel
  rw [List.all_eq_true] at this
  have := this k (List.mem_range.2 hk)
  simpa using this

theorem R23s_n : R23s.n = 48 := by decide

/-- the profile certificates at (2D, K = 3, p = 5) and (2D, K = 3, p = 13) -/
def certP5K3 : Bool :=
  wfCheck R23s
  && decide ((autoOrbit R23s 5 zero48 2).1 = (autoOrbit R23s 5 zero48 1).1.map (· + 1))
  && naCheck R23s 5 (autoOrbit R23s 5 zero48 1).1
  && decide (maxL (autoOrbit R23s 5 zero48 1).1 = 1)

def certP13K3 : Bool :=
  wfCheck R23s
  && decide ((autoOrbit R23s 13 zero48 2).1 = (autoOrbit R23s 13 zero48 1).1.map (· + 1))
  && naCheck R23s 13 (autoOrbit R23s 13 zero48 1).1
  && decide (maxL (autoOrbit R23s 13 zero48 1).1 = 1)

theorem certP5K3_true : certP5K3 = true := by decide +kernel
theorem certP13K3_true : certP13K3 = true := by decide +kernel

theorem top23_five (c0 : List ℤ) (s : ℕ) (hs : 1 ≤ s) : topOf R23s 5 c0 s = 2 ^ (s - 1) := by
  have : Fact (Nat.Prime 5) := ⟨by norm_num⟩
  have hc := certP5K3_true
  unfold certP5K3 at hc
  simp only [Bool.and_eq_true] at hc
  obtain ⟨⟨⟨hwf, hcl⟩, hna⟩, h1⟩ := hc
  have htop := top_geom_of_closure R23s zero48 (wellformed_of_check _ hwf) 1 (by norm_num)
    (of_decide_eq_true hcl) (nonAttain_of_check _ _ _ hna) (by rw [R23s_n]; norm_num)
    (of_decide_eq_true h1) s hs
  unfold topOf at htop ⊢
  rw [profile_indep R23s c0 zero48 s, htop]
  ring

theorem top23_thirteen (c0 : List ℤ) (s : ℕ) (hs : 1 ≤ s) : topOf R23s 13 c0 s = 2 ^ (s - 1) := by
  have : Fact (Nat.Prime 13) := ⟨by norm_num⟩
  have hc := certP13K3_true
  unfold certP13K3 at hc
  simp only [Bool.and_eq_true] at hc
  obtain ⟨⟨⟨hwf, hcl⟩, hna⟩, h1⟩ := hc
  have htop := top_geom_of_closure R23s zero48 (wellformed_of_check _ hwf) 1 (by norm_num)
    (of_decide_eq_true hcl) (nonAttain_of_check _ _ _ hna) (by rw [R23s_n]; norm_num)
    (of_decide_eq_true h1) s hs
  unfold topOf at htop ⊢
  rw [profile_indep R23s c0 zero48 s, htop]
  ring

/-! ## The bounds, for every seed -/

/-- **THEOREM V'S BOUND FOR EVERY SEED.** In the 2D box `K = 2`, for every integer seed and
every step `s ≥ 1`, every nonzero coordinate of the exact orbit has 5-adic pole order at most
`2^{s−1}`. -/
theorem five_bound_K2 (c0 : List ℤ) (s : ℕ) (hs : 1 ≤ s) :
    ∀ k < 24, (ratOrbit (road2D 2) c0 s).getD k 0 ≠ 0 →
      -padicValRat 5 ((ratOrbit (road2D 2) c0 s).getD k 0) ≤ 2 ^ (s - 1) := by
  have : Fact (Nat.Prime 5) := ⟨by norm_num⟩
  have hb := bound_of_top (p := 5) R22s R22s_D_ne c0 s
  rw [R22s_n, show R22s = road2Dsym 2 from rfl, ratOrbit_sym2, show road2Dsym 2 = R22s from rfl,
    top22_five c0 s hs] at hb
  exact hb

/-- **THE 2-ADIC BOUND FOR EVERY SEED.** In the 2D box `K = 2`, for every integer seed and every
step `s ≥ 1`, every nonzero coordinate has 2-adic pole order at most the Jacobsthal number
`J_{s+1}`. -/
theorem two_bound_K2 (c0 : List ℤ) (s : ℕ) (hs : 1 ≤ s) :
    ∀ k < 24, (ratOrbit (road2D 2) c0 s).getD k 0 ≠ 0 →
      -padicValRat 2 ((ratOrbit (road2D 2) c0 s).getD k 0) ≤ (jacobsthal (s + 1) : ℤ) := by
  have : Fact (Nat.Prime 2) := ⟨Nat.prime_two⟩
  have hb := bound_of_top (p := 2) R22s R22s_D_ne c0 s
  rw [R22s_n, show R22s = road2Dsym 2 from rfl, ratOrbit_sym2, show road2Dsym 2 = R22s from rfl,
    top22_two c0 s hs] at hb
  exact hb

/-- **THEOREM J'S BOUND FOR EVERY SEED.** In the 3D box `K = 1`, for every integer seed and every
step `s ≥ 1`, every nonzero coordinate has 3-adic pole order at most the Jacobsthal number `J_s`. -/
theorem three_bound_3D (c0 : List ℤ) (s : ℕ) (hs : 1 ≤ s) :
    ∀ k < 52, (ratOrbit (road3Dord 1) c0 s).getD k 0 ≠ 0 →
      -padicValRat 3 ((ratOrbit (road3Dord 1) c0 s).getD k 0) ≤ (jacobsthal s : ℤ) := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  have hb := bound_of_top (p := 3) R31s R31s_D_ne c0 s
  rw [R31s_n, show R31s = road3Dsym 1 from rfl, ratOrbit_sym3, show road3Dsym 1 = R31s from rfl,
    top31_three c0 s hs] at hb
  exact hb

/-- **THEOREM V'S BOUND AT `K = 3`, p = 5, FOR EVERY SEED.** -/
theorem five_bound_K3 (c0 : List ℤ) (s : ℕ) (hs : 1 ≤ s) :
    ∀ k < 48, (ratOrbit (road2D 3) c0 s).getD k 0 ≠ 0 →
      -padicValRat 5 ((ratOrbit (road2D 3) c0 s).getD k 0) ≤ 2 ^ (s - 1) := by
  have : Fact (Nat.Prime 5) := ⟨by norm_num⟩
  have hb := bound_of_top (p := 5) R23s R23s_D_ne c0 s
  rw [R23s_n, show R23s = road2Dsym 3 from rfl, ratOrbit_sym2] at hb
  rw [show road2Dsym 3 = R23s from rfl, top23_five c0 s hs] at hb
  exact hb

/-- **THEOREM V'S BOUND AT `K = 3`, p = 13, FOR EVERY SEED.** -/
theorem thirteen_bound_K3 (c0 : List ℤ) (s : ℕ) (hs : 1 ≤ s) :
    ∀ k < 48, (ratOrbit (road2D 3) c0 s).getD k 0 ≠ 0 →
      -padicValRat 13 ((ratOrbit (road2D 3) c0 s).getD k 0) ≤ 2 ^ (s - 1) := by
  have : Fact (Nat.Prime 13) := ⟨by norm_num⟩
  have hb := bound_of_top (p := 13) R23s R23s_D_ne c0 s
  rw [R23s_n, show R23s = road2Dsym 3 from rfl, ratOrbit_sym2] at hb
  rw [show road2Dsym 3 = R23s from rfl, top23_thirteen c0 s hs] at hb
  exact hb

/-! ## Theorem I on every orbit at `K = 3` -/

theorem certI3_true : integralCheck R23s 3 = true := by decide +kernel

/-- **THEOREM I ON EVERY ORBIT.** In the 2D box `K = 3`, whose divisors `2|k|²` are divisible by 3
at the shells `|k|² = 9` and `18`, every nonzero coordinate of every integer seed's exact orbit has
NONNEGATIVE 3-adic valuation at every step: the prime 3 never enters a denominator. -/
theorem three_integral_K3 (c0 : List ℤ) (s k : ℕ)
    (hne : (ratOrbit (road2D 3) c0 s).getD k 0 ≠ 0) :
    0 ≤ padicValRat 3 ((ratOrbit (road2D 3) c0 s).getD k 0) := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  have h := integral_of_check (p := 3) R23s R23s_D_ne certI3_true c0 s k
  rw [show R23s = road2Dsym 3 from rfl, ratOrbit_sym2] at h
  exact h hne

/-- The box `K = 3` does carry the prime 3 in its divisors. -/
theorem K3_divisors_three :
    18 ∈ (List.range R23s.n).map R23s.D ∧ 36 ∈ (List.range R23s.n).map R23s.D := by
  decide +kernel

end Gephyrosis
