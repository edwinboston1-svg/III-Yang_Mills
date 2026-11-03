import Aperanton.GephyrosisClosure
import Aperanton.GephyrosisCertificate3D

/-!
# ΓΕΦΥΡΩΣΙΣ — the laws for ALL steps, and the exact steps where they break

Theorems T and D with the kernel's evaluation of the one-digit automaton:

* **THE FIRST ETERNAL LAW** (Addendum V): for the integer seed 19 of the 2D, `K = 2`
  Galerkin–Euler map, the largest 2-adic pole order among the coordinates of the exact orbit is
  the Jacobsthal number `J_{s+1} = (2^{s+1} + (−1)^s)/3` at EVERY step `s ≥ 1`. The automaton's
  normalised state closes at step 4 with period 2 (the profile shifted by `2^5`), so the
  certificate is six steps of the automaton and the theorem is about infinitely many rationals
  whose heights double each step.
* **THE BREAK AT 35** (Addendum IV, P-V5): for the integer seed 5 at the prime 5 the 5-adic pole
  order is exactly `2^{s−1}` for `1 ≤ s ≤ 34` and STRICTLY BELOW `2^{34}` at step 35 — a statement
  about a rational number of about `1.5·10^{11}` bits, decided by 35 steps of the automaton.
* **THE BREAK AT 2** (P-V6): the same seed's 2-adic law `J_{s+1}` holds at step 1 and dies at 2.
* **THE BREAK AT 705** in three dimensions: for seed 5 of the 3D, `K = 1` map at the prime 3 the
  pole order is the Jacobsthal number `J_s` for `1 ≤ s ≤ 704` and strictly below `J_{705}` at 705.

Every statement is about `rorbit22`/`rorbit31`, the orbits of the roads whose tensors were
cross-checked against ΔΙΝΟΣ' feed lines, through `stepI_road2Dsym`/`stepI_road3Dsym`.
-/

namespace Gephyrosis

/-! ## The Jacobsthal numbers in closed form (the recursion is exponential to evaluate) -/

/-- `J_n = (2^n − (−1)^n)/3` -/
def jacF (n : ℕ) : ℕ := if n % 2 = 0 then (2 ^ n - 1) / 3 else (2 ^ n + 1) / 3

theorem jacF_eq (n : ℕ) : jacF n = jacobsthal n := by
  have h := three_mul_jacobsthal n
  unfold jacF
  split_ifs with he
  · have h1 : (-1 : ℤ) ^ n = 1 := Even.neg_one_pow (Nat.even_iff.mpr he)
    rw [h1] at h
    have h2 : 3 * jacobsthal n = 2 ^ n - 1 := by
      have h3 : ((2 ^ n - 1 : ℕ) : ℤ) = 2 ^ n - 1 := by
        rw [Nat.cast_sub Nat.one_le_two_pow]
        push_cast
        ring
      have h4 : (3 * jacobsthal n : ℤ) = ((2 ^ n - 1 : ℕ) : ℤ) := by rw [h3]; linarith
      exact_mod_cast h4
    rw [← h2, Nat.mul_div_cancel_left _ (by norm_num)]
  · have h1 : (-1 : ℤ) ^ n = -1 := Odd.neg_one_pow (Nat.odd_iff.mpr (by omega))
    rw [h1] at h
    have h2 : 3 * jacobsthal n = 2 ^ n + 1 := by
      have h4 : (3 * jacobsthal n : ℤ) = ((2 ^ n + 1 : ℕ) : ℤ) := by push_cast; linarith
      exact_mod_cast h4
    rw [← h2, Nat.mul_div_cancel_left _ (by norm_num)]

/-- `J_{n+2} = J_n + 2^n` -/
theorem jacobsthal_add_two (n : ℕ) : jacobsthal (n + 2) = jacobsthal n + 2 ^ n := by
  have h1 := three_mul_jacobsthal (n + 2)
  have h2 := three_mul_jacobsthal n
  have h3 : (-1 : ℤ) ^ (n + 2) = (-1) ^ n := by ring
  have h4 : (2 : ℤ) ^ (n + 2) = 4 * 2 ^ n := by ring
  rw [h3, h4] at h1
  have : (jacobsthal (n + 2) : ℤ) = jacobsthal n + 2 ^ n := by linarith
  exact_mod_cast this

/-! ## The symmetrised roads and their orbits are the roads' orbits -/

theorem seedDraws_length (r m : ℕ) : (seedDraws r m).length = m := by
  induction m generalizing r with
  | zero => rfl
  | succ m ih =>
    show (_ :: seedDraws (lcgNext r) m).length = m + 1
    rw [List.length_cons, ih]

theorem map_range_getD {α β : Type*} (l : List α) (d : α) (f : α → β) (n : ℕ)
    (hn : l.length = n) : (List.range n).map (fun k => f (l.getD k d)) = l.map f := by
  subst hn
  induction l with
  | nil => rfl
  | cons a l ih =>
    rw [List.length_cons, List.range_succ_eq_map, List.map_cons, List.map_map]
    have hcomp : ((fun k => f ((a :: l).getD k d)) ∘ Nat.succ) = fun k => f (l.getD k d) := by
      funext k
      rfl
    rw [hcomp, ih]
    rfl

def R22s : Road := road2Dsym 2

theorem R22s_D_ne (k : ℕ) (hk : k < R22s.n) : R22s.D k ≠ 0 := by
  have : (List.range R22s.n).all (fun k => decide (R22s.D k ≠ 0)) = true := by
    decide +kernel
  rw [List.all_eq_true] at this
  have := this k (List.mem_range.2 hk)
  simpa using this

theorem R22s_n : R22s.n = 24 := by decide

theorem ratOrbit_eq_rorbit22 (seed s : ℕ) :
    ratOrbit R22s (seedData seed 24) s = rorbit22 seed s := by
  induction s with
  | zero =>
    show (List.range R22s.n).map _ = (seedData seed R22.n).map _
    have h2 : R22.n = 24 := by decide
    rw [R22s_n, h2]
    exact map_range_getD (seedData seed 24) 0 (fun z : ℤ => (z : ℚ)) 24 (seedDraws_length _ _)
  | succ s ih =>
    show stepI (road2Dsym 2) (ratOrbit R22s (seedData seed 24) s) = stepI (road2D 2) (rorbit22 seed s)
    rw [ih, stepI_road2Dsym]

def R31s : Road := road3Dsym 1

theorem R31s_D_ne (k : ℕ) (hk : k < R31s.n) : R31s.D k ≠ 0 := by
  have : (List.range R31s.n).all (fun k => decide (R31s.D k ≠ 0)) = true := by
    decide +kernel
  rw [List.all_eq_true] at this
  have := this k (List.mem_range.2 hk)
  simpa using this

theorem R31s_n : R31s.n = 52 := by decide

theorem road3Dord_eq : road3Dord 1 = R31 := rfl

theorem ratOrbit_eq_rorbit31 (seed s : ℕ) :
    ratOrbit R31s (seedData seed 52) s = rorbit31 seed s := by
  induction s with
  | zero =>
    show (List.range R31s.n).map _ = (seedData seed R31.n).map _
    have h2 : R31.n = 52 := by decide
    rw [R31s_n, h2]
    exact map_range_getD (seedData seed 52) 0 (fun z : ℤ => (z : ℚ)) 52 (seedDraws_length _ _)
  | succ s ih =>
    show stepI (road3Dsym 1) (ratOrbit R31s (seedData seed 52) s) = stepI R31 (rorbit31 seed s)
    rw [ih, stepI_road3Dsym, road3Dord_eq]

/-! ## THE FIRST ETERNAL LAW: seed 19, the prime 2, all steps -/

def seed19 : List ℤ := seedData 19 24

/-- the reading at step `s`: the top is `J_{s+1}` and live -/
def chk19 (s : ℕ) (st : List ℤ × List ℕ) : Bool :=
  decide (s = 0) || (decide (maxL st.1 = (jacF (s + 1) : ℤ)) && topLiveB R22s st)

/-- The certificate: the road is well formed; the automaton's state at step 6 is the state at
step 4 with every pole order raised by `32 = 2^5` and the residues unchanged; no linear term
attains at steps 4 and 5; and at steps 1–5 the top is `J_{s+1}` and live. -/
def cert19 : Bool :=
  wfCheck R22s
  && decide (autoOrbit R22s 2 seed19 6
      = ((autoOrbit R22s 2 seed19 4).1.map (· + 32), scaleR 2 1 (autoOrbit R22s 2 seed19 4).2))
  && naCheck R22s 2 (autoOrbit R22s 2 seed19 4).1
  && naCheck R22s 2 (autoOrbit R22s 2 seed19 5).1
  && checkOrbit chk19 0 (orbitAux R22s 2 5 (autoInit R22s 2 seed19))

theorem cert19_true : cert19 = true := by decide +kernel

theorem seed19_top (s : ℕ) (hs : 1 ≤ s) :
    topOf R22s 2 seed19 s = (jacobsthal (s + 1) : ℤ) ∧ TopLive R22s 2 seed19 s := by
  have : Fact (Nat.Prime 2) := ⟨Nat.prime_two⟩
  have hc := cert19_true
  unfold cert19 at hc
  simp only [Bool.and_eq_true] at hc
  obtain ⟨⟨⟨⟨hwf, hcl⟩, hna4⟩, hna5⟩, hrange⟩ := hc
  have hwf' := wellformed_of_check _ hwf
  have hcl' := of_decide_eq_true hcl
  have hNA : ∀ i < 2, NonAttain R22s 2 (autoOrbit R22s 2 seed19 (4 + i)).1 := by
    intro i hi
    interval_cases i
    · exact nonAttain_of_check _ _ _ hna4
    · exact nonAttain_of_check _ _ _ hna5
  have hn : 0 < R22s.n := by rw [R22s_n]; norm_num
  have hsmall : ∀ s, 1 ≤ s → s ≤ 5 →
      topOf R22s 2 seed19 s = (jacobsthal (s + 1) : ℤ) ∧ TopLive R22s 2 seed19 s := by
    intro s h1 h5
    have := orbit_check R22s 2 seed19 5 chk19 hrange s h5
    unfold chk19 at this
    simp only [Bool.or_eq_true, decide_eq_true_eq, Bool.and_eq_true] at this
    rcases this with h | ⟨ht, hl⟩
    · omega
    · exact ⟨by unfold topOf; rw [ht, jacF_eq], topLive_of_check _ _ _ hl⟩
  induction s using Nat.strong_induction_on with
  | _ s ih =>
    by_cases h5 : s ≤ 5
    · exact hsmall s hs h5
    · have hprev := ih (s - 2) (by omega) (by omega)
      have hts := top_shift R22s seed19 hwf' 4 2 (by norm_num) 32 (by norm_num) 1 hcl' hNA hn
        (s - 6)
      have htl := topLive_shift R22s seed19 hwf' 4 2 (by norm_num) 32 (by norm_num) 1
        (by norm_num) hcl' hNA hn (s - 6)
      rw [show 4 + 2 + (s - 6) = s by omega, show 4 + (s - 6) = s - 2 by omega] at hts htl
      refine ⟨?_, htl.mpr hprev.2⟩
      rw [hts, hprev.1]
      have hJ : jacobsthal (s + 1) = jacobsthal (s - 1) + 2 ^ (s - 1) := by
        have := jacobsthal_add_two (s - 1)
        rwa [show s - 1 + 2 = s + 1 by omega] at this
      have hs2 : s - 2 + 1 = s - 1 := by omega
      have h32 : (32 : ℤ) * 2 ^ (s - 6) = 2 ^ (s - 1) := by
        rw [show s - 1 = (s - 6) + 5 by omega, pow_add]
        ring
      rw [hs2, hJ, h32]
      push_cast
      ring

/-- **THE FIRST ETERNAL LAW, KERNEL-CERTIFIED.** For the integer seed 19 of the 2D, `K = 2`
Galerkin–Euler map, at EVERY step `s ≥ 1` every nonzero coordinate of the exact orbit has 2-adic
pole order at most the Jacobsthal number `J_{s+1}`, and some coordinate attains it. -/
theorem seed19_eternal_law (s : ℕ) (hs : 1 ≤ s) :
    (∀ k < 24, (rorbit22 19 s).getD k 0 ≠ 0 →
        -padicValRat 2 ((rorbit22 19 s).getD k 0) ≤ (jacobsthal (s + 1) : ℤ)) ∧
    (∃ k < 24, (rorbit22 19 s).getD k 0 ≠ 0 ∧
        -padicValRat 2 ((rorbit22 19 s).getD k 0) = (jacobsthal (s + 1) : ℤ)) := by
  have : Fact (Nat.Prime 2) := ⟨Nat.prime_two⟩
  obtain ⟨htop, hlive⟩ := seed19_top s hs
  have h := law_of_top R22s R22s_D_ne seed19 s hlive
  rw [htop, show seed19 = seedData 19 24 from rfl, ratOrbit_eq_rorbit22, R22s_n] at h
  exact h

/-- The closed form of the law: `3·J_{s+1} = 2^{s+1} + (−1)^s`. -/
theorem jacobsthal_closed (s : ℕ) : (3 * jacobsthal (s + 1) : ℤ) = 2 ^ (s + 1) + (-1) ^ s := by
  rw [three_mul_jacobsthal (s + 1)]
  ring

/-! ## THE BREAK AT 35: seed 5, the prime 5 -/

def seed5 : List ℤ := seedData 5 24

/-- the reading at step `s`: the top is `2^{s−1}`, live before 35 and dead at 35 -/
def chk5 (s : ℕ) (st : List ℤ × List ℕ) : Bool :=
  decide (s = 0) || (decide (maxL st.1 = (2 : ℤ) ^ (s - 1))
    && (if s < 35 then topLiveB R22s st else decide (topLiveB R22s st = false)))

def cert5 : Bool := checkOrbit chk5 0 (orbitAux R22s 5 35 (autoInit R22s 5 seed5))

theorem cert5_true : cert5 = true := by decide +kernel

theorem cert5_read (s : ℕ) (h1 : 1 ≤ s) (h35 : s ≤ 35) :
    topOf R22s 5 seed5 s = 2 ^ (s - 1) ∧
      (s < 35 → TopLive R22s 5 seed5 s) ∧ (s = 35 → ¬ TopLive R22s 5 seed5 s) := by
  have : Fact (Nat.Prime 5) := ⟨by norm_num⟩
  have hc := orbit_check R22s 5 seed5 35 chk5 cert5_true s h35
  unfold chk5 at hc
  simp only [Bool.or_eq_true, decide_eq_true_eq, Bool.and_eq_true] at hc
  rcases hc with h | ⟨ht, hl⟩
  · omega
  · refine ⟨by unfold topOf; exact ht, ?_, ?_⟩
    · intro hlt
      rw [if_pos hlt] at hl
      exact topLive_of_check _ _ _ hl
    · intro heq
      rw [if_neg (by omega)] at hl
      exact topDead_of_check _ _ _ (of_decide_eq_true hl)

/-- **THE 5-ADIC LAW OF SEED 5 TO STEP 34.** -/
theorem seed5_five_law_to_34 (s : ℕ) (hs : 1 ≤ s) (h34 : s ≤ 34) :
    (∀ k < 24, (rorbit22 5 s).getD k 0 ≠ 0 →
        -padicValRat 5 ((rorbit22 5 s).getD k 0) ≤ 2 ^ (s - 1)) ∧
    (∃ k < 24, (rorbit22 5 s).getD k 0 ≠ 0 ∧
        -padicValRat 5 ((rorbit22 5 s).getD k 0) = 2 ^ (s - 1)) := by
  have : Fact (Nat.Prime 5) := ⟨by norm_num⟩
  obtain ⟨htop, hlive, -⟩ := cert5_read s hs (by omega)
  have h := law_of_top R22s R22s_D_ne seed5 s (hlive (by omega))
  rw [htop, show seed5 = seedData 5 24 from rfl, ratOrbit_eq_rorbit22, R22s_n] at h
  exact h

/-- **THE BREAK AT 35 (Addendum IV, `BREAKS-AT-STEP 35`).** At step 35 every nonzero coordinate of
seed 5's exact orbit has 5-adic pole order STRICTLY BELOW `2^{34}` — the law `5^{2^{s−1}}` ends. -/
theorem seed5_five_breaks_at_35 :
    ∀ k < 24, (rorbit22 5 35).getD k 0 ≠ 0 →
      -padicValRat 5 ((rorbit22 5 35).getD k 0) ≤ 2 ^ 34 - 1 := by
  have : Fact (Nat.Prime 5) := ⟨by norm_num⟩
  obtain ⟨htop, -, hdead⟩ := cert5_read 35 (by norm_num) le_rfl
  have h := break_of_dead R22s R22s_D_ne seed5 35 (hdead rfl)
  rw [htop, show seed5 = seedData 5 24 from rfl, ratOrbit_eq_rorbit22, R22s_n] at h
  exact h

/-! ## THE BREAK AT 2: seed 5, the prime 2 -/

def chk5b (s : ℕ) (st : List ℤ × List ℕ) : Bool :=
  decide (s = 0) || (decide (maxL st.1 = (jacF (s + 1) : ℤ))
    && (if s < 2 then topLiveB R22s st else decide (topLiveB R22s st = false)))

def cert5b : Bool := checkOrbit chk5b 0 (orbitAux R22s 2 2 (autoInit R22s 2 seed5))

theorem cert5b_true : cert5b = true := by decide +kernel

/-- **THE 2-ADIC LAW OF SEED 5 DIES AT STEP 2 (P-V6).** At step 1 the pole order is `J_2 = 1`
exactly; at step 2 every nonzero coordinate has pole order strictly below `J_3 = 3`. -/
theorem seed5_two_breaks_at_2 :
    (∃ k < 24, (rorbit22 5 1).getD k 0 ≠ 0 ∧ -padicValRat 2 ((rorbit22 5 1).getD k 0) = 1) ∧
    (∀ k < 24, (rorbit22 5 2).getD k 0 ≠ 0 →
      -padicValRat 2 ((rorbit22 5 2).getD k 0) ≤ 2) := by
  have : Fact (Nat.Prime 2) := ⟨Nat.prime_two⟩
  have h1 := orbit_check R22s 2 seed5 2 chk5b cert5b_true 1 (by norm_num)
  have h2 := orbit_check R22s 2 seed5 2 chk5b cert5b_true 2 le_rfl
  unfold chk5b at h1 h2
  simp only [Bool.or_eq_true, decide_eq_true_eq, Bool.and_eq_true] at h1 h2
  rcases h1 with h | ⟨ht1, hl1⟩
  · omega
  rcases h2 with h | ⟨ht2, hl2⟩
  · omega
  rw [if_pos (by norm_num)] at hl1
  rw [if_neg (by norm_num)] at hl2
  have hlive := topLive_of_check (p := 2) _ _ _ hl1
  have hdead := topDead_of_check (p := 2) _ _ _ (of_decide_eq_true hl2)
  have e1 := (law_of_top R22s R22s_D_ne seed5 1 hlive).2
  have e2 := break_of_dead R22s R22s_D_ne seed5 2 hdead
  have t1 : topOf R22s 2 seed5 1 = 1 := by unfold topOf; rw [ht1]; decide
  have t2 : topOf R22s 2 seed5 2 = 3 := by unfold topOf; rw [ht2]; decide
  rw [t1, show seed5 = seedData 5 24 from rfl, ratOrbit_eq_rorbit22, R22s_n] at e1
  rw [t2, show seed5 = seedData 5 24 from rfl, ratOrbit_eq_rorbit22, R22s_n] at e2
  exact ⟨e1, fun k hk hne => by have := e2 k hk hne; linarith⟩

end Gephyrosis
