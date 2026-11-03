import Aperanton.GephyrosisRoadK4Eq

/-!
# ΓΕΦΥΡΩΣΙΣ — THEOREM Θ at depth two: the box `K = 4` at the prime 5

Addendum IV §13 (Theorem Θ): at a split prime `p = ππ̄` of `ℤ[i]` the modes of a 2D box are graded
by their effective ramification `|v_π(κ) − v_π̄(κ)|`, the depth `e_p(K)` is the largest grade the
box holds, and the top of the profile is `e·2^{s−1}`, so `θ_p = e/2`. At `K = 2, 3` the depth at 5
is one (`2 + i` and its associates) and the law is `2^{s−1}`; at `K = 4` the mode `3 + 4i = (2 + i)²`
enters, the depth is two, and the page staked `T(s) = 2^s`, `θ₅ = 1` — out of its instrument's
reach by two constants. Here the 80-coordinate box is built from the wavevectors and the kernel
decides: the profile closes after one step with shift 2, so `T(s) = 2^s` for EVERY integer seed,
and the default seed 5 attains it FOREVER (`GephyrosisDepthEternal.lean`: the automaton's normalised
state closes at step 10 with period 40, read in chunks) — THE FIRST ETERNAL LAW AT AN ODD PRIME FOR THE
DEFAULT SEED, at the depth the page predicted.
-/

namespace Gephyrosis



def zero80 : List ℤ := List.replicate 80 0

/-- the depth-two certificate: the profile closes after one step with shift 2 from `T(1) = 2` -/
def certK4 : Bool :=
  wfCheck R24lit
  && decide ((autoOrbit R24lit 5 zero80 2).1 = (autoOrbit R24lit 5 zero80 1).1.map (· + 2))
  && naCheck R24lit 5 (autoOrbit R24lit 5 zero80 1).1
  && decide (maxL (autoOrbit R24lit 5 zero80 1).1 = 2)

set_option maxHeartbeats 0 in
theorem certK4_true : certK4 = true := by decide +kernel

/-- `T(s) = 2^s` at (2D, K = 4, p = 5), for every seed: THEOREM Θ's depth two -/
theorem top24_five (c0 : List ℤ) (s : ℕ) (hs : 1 ≤ s) : topOf R24lit 5 c0 s = 2 ^ s := by
  have : Fact (Nat.Prime 5) := ⟨by norm_num⟩
  have hc := certK4_true
  unfold certK4 at hc
  simp only [Bool.and_eq_true] at hc
  obtain ⟨⟨⟨hwf, hcl⟩, hna⟩, h1⟩ := hc
  have htop := top_geom_of_closure R24lit zero80 (wellformed_of_check _ hwf) 2 (by norm_num)
    (of_decide_eq_true hcl) (nonAttain_of_check _ _ _ hna) (by rw [R24lit_n]; norm_num)
    (of_decide_eq_true h1) s hs
  unfold topOf at htop ⊢
  rw [profile_indep R24lit c0 zero80 s, htop]
  rw [show s = (s - 1) + 1 by omega, pow_succ]
  simp only [Nat.add_sub_cancel]
  ring

/-- **THEOREM Θ AT DEPTH TWO, FOR EVERY SEED.** In the 2D box `K = 4` every nonzero coordinate of
every integer seed's exact orbit has 5-adic pole order at most `2^s` at step `s ≥ 1`. -/
theorem five_bound_K4 (c0 : List ℤ) (s : ℕ) (hs : 1 ≤ s) :
    ∀ k < 80, (ratOrbit (road2D 4) c0 s).getD k 0 ≠ 0 →
      -padicValRat 5 ((ratOrbit (road2D 4) c0 s).getD k 0) ≤ 2 ^ s := by
  have : Fact (Nat.Prime 5) := ⟨by norm_num⟩
  have hb := bound_of_top (p := 5) R24lit R24lit_D_ne c0 s
  rw [R24lit_n, ratOrbit_K4lit, top24_five c0 s hs] at hb
  exact hb

end Gephyrosis
