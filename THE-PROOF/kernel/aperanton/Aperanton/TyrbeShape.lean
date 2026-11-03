import Aperanton.GephyrosisBounds

/-!
# ΤΥΡΒΗ — Τ1 and Τ2: the finite-place spectrum is the ramification grade, from step one

`DOCS/III-TYRBE-THE-TURBULENCE-PREREGISTRATION.md` stakes, for a split prime `p` and a 2D box with `K < p`, that
every coordinate's pole-order profile sits below the top by exactly `e − g_k`, `g_k = v_p(|k|²)` the grade of its
mode and `e` the depth of the box, at EVERY step `s ≥ 1` (Τ1), and that this shape is present from step 1 (Τ2).
The kernel decides the shape at steps 1 and 2 on the automaton's own profile (seed-independent), and the closure
certificates of `GephyrosisBounds.lean` carry it to every step by `profile_geom`: a profile that closes after one
step with shift `c` is its step-1 shape raised by `c·(2^{s−1} − 1)`.
-/

namespace Gephyrosis

/-- the grade of a 2D mode at `p`: `v_p(|k|²)`, the effective ramification of Theorem G when `K < p` -/
def grade2 (p : ℕ) (b : Basis2) : ℕ := vpI p b.k.normSq

/-- the predicted finite-place spectrum of a box at `p`: `T − (e − g_k)` in the box's coordinate order -/
def shape2 (K p e : ℕ) (T : ℤ) : List ℤ := (basis2D K).map fun b => T - ((e : ℤ) - (grade2 p b : ℤ))

theorem shape2_shift (K p e : ℕ) (T c : ℤ) : (shape2 K p e T).map (· + c) = shape2 K p e (T + c) := by
  unfold shape2
  rw [List.map_map]
  apply List.map_congr_left
  intro b _
  simp only [Function.comp]
  ring

section Geom

variable {p : ℕ} [hp : Fact p.Prime]

/-- a profile closing after one step with shift `c` is its step-1 shape raised by `c·(2^{s−1} − 1)` -/
theorem profile_geom (R : Road) (c0 : List ℤ) (hwf : Wellformed R) (c : ℤ) (hc : 0 ≤ c)
    (hclose : (autoOrbit R p c0 2).1 = (autoOrbit R p c0 1).1.map (· + c))
    (hNA : NonAttain R p (autoOrbit R p c0 1).1) :
    ∀ s, 1 ≤ s → (autoOrbit R p c0 s).1 = (autoOrbit R p c0 1).1.map (· + c * (2 ^ (s - 1) - 1)) := by
  have hNA' : ∀ i < 1, NonAttain R p (autoOrbit R p c0 (1 + i)).1 := by
    intro i hi
    have : i = 0 := by omega
    subst this
    exact hNA
  have key : ∀ i, (autoOrbit R p c0 (1 + i)).1 = (autoOrbit R p c0 1).1.map (· + c * (2 ^ i - 1)) := by
    intro i
    induction i with
    | zero =>
      simp
    | succ i ih =>
      have h := (closure_profile R c0 hwf 1 1 (by norm_num) c hc hclose hNA' i).1
      rw [show 1 + 1 + i = 1 + (i + 1) by omega] at h
      rw [h, ih, List.map_map]
      apply List.map_congr_left
      intro x _
      simp only [Function.comp]
      ring
  intro s hs
  have := key (s - 1)
  rwa [show 1 + (s - 1) = s by omega] at this

end Geom

/-! ## The shapes at steps 1 and 2, decided by the kernel on the profile automaton -/

theorem shape22_five_1 : (autoOrbit R22s 5 zero24 1).1 = shape2 2 5 1 1 := by decide +kernel
theorem shape22_five_2 : (autoOrbit R22s 5 zero24 2).1 = shape2 2 5 1 2 := by decide +kernel
theorem shape23_five_1 : (autoOrbit R23s 5 zero48 1).1 = shape2 3 5 1 1 := by decide +kernel
theorem shape23_five_2 : (autoOrbit R23s 5 zero48 2).1 = shape2 3 5 1 2 := by decide +kernel
theorem shape23_thirteen_1 : (autoOrbit R23s 13 zero48 1).1 = shape2 3 13 1 1 := by decide +kernel
theorem shape23_thirteen_2 : (autoOrbit R23s 13 zero48 2).1 = shape2 3 13 1 2 := by decide +kernel

/-- the counts the page staked: 8 coordinates at the top at (K = 2, 5), 16 at (K = 3, 5), 8 at (K = 3, 13) -/
theorem top_counts :
    ((basis2D 2).filter fun b => grade2 5 b = 1).length = 8 ∧
    ((basis2D 3).filter fun b => grade2 5 b = 1).length = 16 ∧
    ((basis2D 3).filter fun b => grade2 13 b = 1).length = 8 := by decide +kernel

/-! ## Τ1 at every step, Τ2 at step one, for every integer seed -/

/-- **Τ1 at (2D, K = 2, p = 5)**: every coordinate's pole-order bound is `2^{s−1} − (1 − g_k)` at every step. -/
theorem tau1_K2_five (c0 : List ℤ) (s : ℕ) (hs : 1 ≤ s) :
    (autoOrbit R22s 5 c0 s).1 = shape2 2 5 1 (2 ^ (s - 1)) := by
  have : Fact (Nat.Prime 5) := ⟨by norm_num⟩
  have hc := certP5_true
  unfold certP5 at hc
  simp only [Bool.and_eq_true] at hc
  obtain ⟨⟨⟨hwf, hcl⟩, hna⟩, -⟩ := hc
  rw [profile_indep R22s c0 zero24 s,
    profile_geom R22s zero24 (wellformed_of_check _ hwf) 1 (by norm_num) (of_decide_eq_true hcl)
      (nonAttain_of_check _ _ _ hna) s hs, shape22_five_1, shape2_shift]
  have h : (1 : ℤ) + 1 * (2 ^ (s - 1) - 1) = 2 ^ (s - 1) := by ring
  rw [h]

/-- **Τ1 at (2D, K = 3, p = 5)** -/
theorem tau1_K3_five (c0 : List ℤ) (s : ℕ) (hs : 1 ≤ s) :
    (autoOrbit R23s 5 c0 s).1 = shape2 3 5 1 (2 ^ (s - 1)) := by
  have : Fact (Nat.Prime 5) := ⟨by norm_num⟩
  have hc := certP5K3_true
  unfold certP5K3 at hc
  simp only [Bool.and_eq_true] at hc
  obtain ⟨⟨⟨hwf, hcl⟩, hna⟩, -⟩ := hc
  rw [profile_indep R23s c0 zero48 s,
    profile_geom R23s zero48 (wellformed_of_check _ hwf) 1 (by norm_num) (of_decide_eq_true hcl)
      (nonAttain_of_check _ _ _ hna) s hs, shape23_five_1, shape2_shift]
  have h : (1 : ℤ) + 1 * (2 ^ (s - 1) - 1) = 2 ^ (s - 1) := by ring
  rw [h]

/-- **Τ1 at (2D, K = 3, p = 13)** -/
theorem tau1_K3_thirteen (c0 : List ℤ) (s : ℕ) (hs : 1 ≤ s) :
    (autoOrbit R23s 13 c0 s).1 = shape2 3 13 1 (2 ^ (s - 1)) := by
  have : Fact (Nat.Prime 13) := ⟨by norm_num⟩
  have hc := certP13K3_true
  unfold certP13K3 at hc
  simp only [Bool.and_eq_true] at hc
  obtain ⟨⟨⟨hwf, hcl⟩, hna⟩, -⟩ := hc
  rw [profile_indep R23s c0 zero48 s,
    profile_geom R23s zero48 (wellformed_of_check _ hwf) 1 (by norm_num) (of_decide_eq_true hcl)
      (nonAttain_of_check _ _ _ hna) s hs, shape23_thirteen_1, shape2_shift]
  have h : (1 : ℤ) + 1 * (2 ^ (s - 1) - 1) = 2 ^ (s - 1) := by ring
  rw [h]

/-- **Τ2**: the shape is present at step 1 from every integer seed (the cascade time is one step). -/
theorem tau2_K2_five (c0 : List ℤ) : (autoOrbit R22s 5 c0 1).1 = shape2 2 5 1 1 := by
  have : Fact (Nat.Prime 5) := ⟨by norm_num⟩
  rw [profile_indep R22s c0 zero24 1, shape22_five_1]

theorem tau2_K3_five (c0 : List ℤ) : (autoOrbit R23s 5 c0 1).1 = shape2 3 5 1 1 := by
  have : Fact (Nat.Prime 5) := ⟨by norm_num⟩
  rw [profile_indep R23s c0 zero48 1, shape23_five_1]

theorem tau2_K3_thirteen (c0 : List ℤ) : (autoOrbit R23s 13 c0 1).1 = shape2 3 13 1 1 := by
  have : Fact (Nat.Prime 13) := ⟨by norm_num⟩
  rw [profile_indep R23s c0 zero48 1, shape23_thirteen_1]

/-- **Τ1 on the exact orbit**: at (2D, K = 2, p = 5) every nonzero coordinate's 5-adic pole order is at most
`2^{s−1} − (1 − g_k)`, the grade's lag below the top, for every integer seed and step. -/
theorem tau1_K2_five_orbit (c0 : List ℤ) (s : ℕ) (hs : 1 ≤ s) :
    ∀ k < 24, (ratOrbit (road2D 2) c0 s).getD k 0 ≠ 0 →
      -padicValRat 5 ((ratOrbit (road2D 2) c0 s).getD k 0) ≤ (shape2 2 5 1 (2 ^ (s - 1))).getD k 0 := by
  have : Fact (Nat.Prime 5) := ⟨by norm_num⟩
  intro k hk hne
  have hne' : (ratOrbit R22s c0 s).getD k 0 ≠ 0 := by
    rwa [show R22s = road2Dsym 2 from rfl, ratOrbit_sym2]
  have key : -padicValRat 5 ((ratOrbit R22s c0 s).getD k 0) ≤ (autoOrbit R22s 5 c0 s).1.getD k 0 := by
    by_cases hr : (autoOrbit R22s 5 c0 s).2.getD k 0 = 0
    · rcases pole_of_dead R22s R22s_D_ne c0 s k hr with h | h
      · exact absurd h hne'
      · linarith
    · have := (pole_of_live R22s R22s_D_ne c0 s k hr (res_lt (p := 5) R22s c0 s k)).2
      linarith
  rw [tau1_K2_five c0 s hs] at key
  rwa [show R22s = road2Dsym 2 from rfl, ratOrbit_sym2] at key

end Gephyrosis
