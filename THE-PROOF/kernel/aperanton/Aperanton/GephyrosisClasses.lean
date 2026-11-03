import Aperanton.GephyrosisBounds

/-!
# ΓΕΦΥΡΩΣΙΣ — the classes: seeds that never grow, and seeds whose law is eternal

The automaton reads the seed only through its residues, so a law is a property of a RESIDUE CLASS
of seeds. Two kinds of class are certified here.

* **THE INVARIANT LATTICE** (Addendum IV §12). The profile `(0 on the ramified coordinates,
  −1 elsewhere)` is a FIXED POINT of the max-plus recursion, so every seed whose unramified
  coordinates are divisible by `p` has a `p`-integral orbit FOREVER, the unramified coordinates
  staying divisible by `p`: at (2D, K = 2, p = 5), (3D, K = 1, p = 3), (2D, K = 3, p = 5) and
  (2D, K = 3, p = 13). A positive-density family of initial data on which the prime never enters.
* **THE ETERNAL CLASSES.** Theorem D with the residues: a seed whose normalised state closes with
  every top live attains the bound at EVERY step. At (2D, K = 2, p = 2) the integer seeds
  29, 65, 100, 111, 118 (with 19) — all six of the first 120 that Addendum V found — attain
  `J_{s+1}` forever (residue periods 28, 56, 56, 2, 2); in 3D at the prime 3 the seeds 17, 21, 36
  attain `J_s` forever (periods 18, 16, 6).
-/

namespace Gephyrosis

section FromState

variable {p : ℕ} [hp : Fact p.Prime]

/-- the automaton from an arbitrary initial state -/
def autoFrom (R : Road) (p : ℕ) (st0 : List ℤ × List ℕ) : ℕ → List ℤ × List ℕ
  | 0 => st0
  | s + 1 => autoStep R p (autoFrom R p st0 s)

/-- Theorem T from any initial state that carries the invariant. -/
theorem theoremT_from (R : Road) (hD : ∀ k < R.n, R.D k ≠ 0) (c0 : List ℤ)
    (st0 : List ℤ × List ℕ)
    (h0 : ∀ k, IRes p ((p : ℚ) ^ (st0.1.getD k 0) * (ratOrbit R c0 0).getD k 0)
      ((st0.2.getD k 0 : ℕ) : ZMod p)) :
    ∀ s k, IRes p ((p : ℚ) ^ ((autoFrom R p st0 s).1.getD k 0) * (ratOrbit R c0 s).getD k 0)
      (((autoFrom R p st0 s).2.getD k 0 : ℕ) : ZMod p) := by
  intro s
  induction s with
  | zero => exact h0
  | succ s ih =>
    exact theoremT_step (p := p) R hD (autoFrom R p st0 s).1 (autoFrom R p st0 s).2
      (ratOrbit R c0 s) ih

/-- A profile fixed by the step stays forever. -/
theorem profile_fixed (R : Road) (st0 : List ℤ × List ℕ)
    (hfix : (List.range R.n).map (tNext R p st0.1) = st0.1) :
    ∀ s, (autoFrom R p st0 s).1 = st0.1 := by
  intro s
  induction s with
  | zero => rfl
  | succ s ih =>
    show (List.range R.n).map (tNext R p (autoFrom R p st0 s).1) = st0.1
    rw [ih]
    exact hfix

/-- A nonpositive fixed profile keeps every coordinate `p`-integral forever. -/
theorem integral_of_fixed (R : Road) (hD : ∀ k < R.n, R.D k ≠ 0) (c0 : List ℤ)
    (st0 : List ℤ × List ℕ)
    (h0 : ∀ k, IRes p ((p : ℚ) ^ (st0.1.getD k 0) * (ratOrbit R c0 0).getD k 0)
      ((st0.2.getD k 0 : ℕ) : ZMod p))
    (hfix : (List.range R.n).map (tNext R p st0.1) = st0.1) (hneg : ∀ k, st0.1.getD k 0 ≤ 0)
    (s k : ℕ) (hne : (ratOrbit R c0 s).getD k 0 ≠ 0) :
    -(st0.1.getD k 0) ≤ padicValRat p ((ratOrbit R c0 s).getD k 0) := by
  have h := theoremT_from R hD c0 st0 h0 s k
  rw [profile_fixed R st0 hfix s] at h
  by_cases hr : (((autoFrom R p st0 s).2.getD k 0 : ℕ) : ZMod p) = 0
  · rw [hr] at h
    have := val_of_dead h hne
    linarith
  · have := (val_of_live h hr).2
    linarith

/-! ## Eternal classes -/

/-- the class certificate: the closure at `(M, L, c, lam)`, the linear terms non-attaining and the
tops live on the turn, the tops live on `[1, M + L]` -/
def classCert (R : Road) (p : ℕ) (c0 : List ℤ) (M L : ℕ) (c : ℤ) (lam : ℕ) : Bool :=
  let orb := orbitAux R p (M + L) (autoInit R p c0)
  wfCheck R
  && decide (orb.getD (M + L) ([], [])
      = ((orb.getD M ([], [])).1.map (· + c), scaleR p lam (orb.getD M ([], [])).2))
  && checkOrbit (fun s st => (decide (s = 0) || topLiveB R st) && (decide (s < M) || naCheck R p st.1))
      0 orb

/-- A class whose certificate holds has its top live at every step `s ≥ 1`. -/
theorem class_eternal (R : Road) (c0 : List ℤ) (M L : ℕ) (hM : 1 ≤ M) (hL : 0 < L) (c : ℤ)
    (hc : 0 ≤ c) (lam : ℕ) (hlam : ¬ p ∣ lam) (hn : 0 < R.n)
    (hcert : classCert R p c0 M L c lam = true) : ∀ s, 1 ≤ s → TopLive R p c0 s := by
  unfold classCert at hcert
  simp only [Bool.and_eq_true] at hcert
  obtain ⟨⟨hwf, hcl⟩, hchk⟩ := hcert
  have hwf' := wellformed_of_check _ hwf
  have hcl' := of_decide_eq_true hcl
  rw [show autoInit R p c0 = autoOrbit R p c0 0 from rfl,
    orbitAux_getD R p c0 (M + L) 0 (M + L) le_rfl,
    orbitAux_getD R p c0 (M + L) 0 M (by omega), Nat.zero_add, Nat.zero_add] at hcl'
  have hread := orbit_check R p c0 (M + L) _ hchk
  have hNA : ∀ i < L, NonAttain R p (autoOrbit R p c0 (M + i)).1 := by
    intro i hi
    have := hread (M + i) (by omega)
    simp only [Bool.and_eq_true, Bool.or_eq_true, decide_eq_true_eq] at this
    rcases this.2 with h | h
    · omega
    · exact nonAttain_of_check _ _ _ h
  have hinit : ∀ s, 1 ≤ s → s ≤ M + L → TopLive R p c0 s := by
    intro s h1 h2
    have := hread s h2
    simp only [Bool.and_eq_true, Bool.or_eq_true, decide_eq_true_eq] at this
    rcases this.1 with h | h
    · omega
    · exact topLive_of_check _ _ _ h
  intro s
  induction s using Nat.strong_induction_on with
  | _ s ih =>
    intro hs
    by_cases hlt : s ≤ M + L
    · exact hinit s hs hlt
    · have := topLive_shift R c0 hwf' M L hL c hc lam hlam hcl' hNA hn (s - M - L)
      rw [show M + L + (s - M - L) = s by omega, show M + (s - M - L) = s - L by omega] at this
      exact this.mpr (ih (s - L) (by omega) (by omega))

end FromState

/-! ## The invariant lattices -/

/-- the lattice profile: `0` where the divisor carries `p`, `−1` elsewhere -/
def latticeProfile (R : Road) (p : ℕ) : List ℤ :=
  (List.range R.n).map fun k => if (R.D k) % (p : ℤ) = 0 then 0 else -1

/-- the lattice residues of a seed: the residue of `c_k` on the ramified coordinates, of `c_k / p`
on the others -/
def latticeRes (R : Road) (p : ℕ) (c0 : List ℤ) : List ℕ :=
  (List.range R.n).map fun k =>
    if (R.D k) % (p : ℤ) = 0 then (c0.getD k 0 % (p : ℤ)).toNat
    else ((c0.getD k 0 / (p : ℤ)) % (p : ℤ)).toNat

def latticeFixCheck (R : Road) (p : ℕ) : Bool :=
  decide ((List.range R.n).map (tNext R p (latticeProfile R p)) = latticeProfile R p)

section Lattice

variable {p : ℕ} [hp : Fact p.Prime]

theorem lattice_h0 (R : Road) (c0 : List ℤ)
    (hc : ∀ k < R.n, (R.D k) % (p : ℤ) ≠ 0 → (p : ℤ) ∣ c0.getD k 0) :
    ∀ k, IRes p ((p : ℚ) ^ ((latticeProfile R p).getD k 0) * (ratOrbit R c0 0).getD k 0)
      (((latticeRes R p c0).getD k 0 : ℕ) : ZMod p) := by
  intro k
  by_cases hk : k < R.n
  · have ht : (latticeProfile R p).getD k 0 = if (R.D k) % (p : ℤ) = 0 then 0 else -1 := by
      unfold latticeProfile; rw [getD_map_range, if_pos hk]
    have hr : (latticeRes R p c0).getD k 0 = if (R.D k) % (p : ℤ) = 0
        then (c0.getD k 0 % (p : ℤ)).toNat else ((c0.getD k 0 / (p : ℤ)) % (p : ℤ)).toNat := by
      unfold latticeRes; rw [getD_map_range, if_pos hk]
    have hc0 : (ratOrbit R c0 0).getD k 0 = ((c0.getD k 0 : ℤ) : ℚ) := by
      show ((List.range R.n).map _).getD k 0 = _
      rw [getD_map_range, if_pos hk]
    rw [ht, hr, hc0]
    split_ifs with hdiv
    · rw [zpow_zero, one_mul, natCast_toNat_emod]
      exact IRes.ofInt _
    · obtain ⟨m, hm⟩ := hc k hk hdiv
      have hp0 : (p : ℤ) ≠ 0 := by exact_mod_cast hp.out.ne_zero
      have hpq : (p : ℚ) ≠ 0 := by exact_mod_cast hp.out.ne_zero
      have hmdiv : c0.getD k 0 / (p : ℤ) = m := by rw [hm]; exact Int.mul_ediv_cancel_left m hp0
      rw [hmdiv, natCast_toNat_emod, hm]
      have : (p : ℚ) ^ (-1 : ℤ) * (((p : ℤ) * m : ℤ) : ℚ) = (m : ℚ) := by
        rw [zpow_neg_one]; push_cast; field_simp
      rw [this]
      exact IRes.ofInt _
  · have ht : (latticeProfile R p).getD k 0 = 0 := by
      unfold latticeProfile; rw [getD_map_range, if_neg hk]
    have hr : (latticeRes R p c0).getD k 0 = 0 := by
      unfold latticeRes; rw [getD_map_range, if_neg hk]
    have hc0 : (ratOrbit R c0 0).getD k 0 = 0 := by
      show ((List.range R.n).map _).getD k 0 = _
      rw [getD_map_range, if_neg hk]
    rw [ht, hr, hc0]
    simpa using IRes.zero (p := p)

theorem latticeProfile_nonpos (R : Road) (k : ℕ) : (latticeProfile R p).getD k 0 ≤ 0 := by
  unfold latticeProfile
  rw [getD_map_range]
  split_ifs <;> omega

/-- THE INVARIANT LATTICE, GENERIC: if the lattice profile is fixed by the step, every seed whose
unramified coordinates are divisible by `p` has a `p`-integral orbit forever, the unramified
coordinates staying divisible by `p`. -/
theorem lattice_integral (R : Road) (hD : ∀ k < R.n, R.D k ≠ 0) (hfix : latticeFixCheck R p = true)
    (c0 : List ℤ) (hc : ∀ k < R.n, (R.D k) % (p : ℤ) ≠ 0 → (p : ℤ) ∣ c0.getD k 0) (s k : ℕ)
    (hk : k < R.n) (hne : (ratOrbit R c0 s).getD k 0 ≠ 0) :
    (if (R.D k) % (p : ℤ) = 0 then 0 else 1) ≤ padicValRat p ((ratOrbit R c0 s).getD k 0) := by
  have h := integral_of_fixed R hD c0 (latticeProfile R p, latticeRes R p c0) (lattice_h0 R c0 hc)
    (of_decide_eq_true hfix) (latticeProfile_nonpos R) s k hne
  have ht : (latticeProfile R p).getD k 0 = if (R.D k) % (p : ℤ) = 0 then 0 else -1 := by
    unfold latticeProfile; rw [getD_map_range, if_pos hk]
  rw [ht] at h
  split_ifs at h ⊢ <;> linarith

end Lattice

theorem latticeFix22_five : latticeFixCheck R22s 5 = true := by decide +kernel
theorem latticeFix31_three : latticeFixCheck R31s 3 = true := by decide +kernel
theorem latticeFix23_five : latticeFixCheck R23s 5 = true := by decide +kernel
theorem latticeFix23_thirteen : latticeFixCheck R23s 13 = true := by decide +kernel

/-- **THE SEEDS THAT NEVER GROW (2D, K = 2, p = 5).** Every integer seed whose 16 unramified
coordinates (those whose divisor `2|k|²` is not divisible by 5) are divisible by 5 has an exact
orbit that is 5-integral at every step; its unramified coordinates stay divisible by 5. -/
theorem lattice_K2_five (c0 : List ℤ)
    (hc : ∀ k < 24, (R22s.D k) % 5 ≠ 0 → (5 : ℤ) ∣ c0.getD k 0) (s k : ℕ) (hk : k < 24)
    (hne : (ratOrbit (road2D 2) c0 s).getD k 0 ≠ 0) :
    (if (R22s.D k) % 5 = 0 then 0 else 1) ≤ padicValRat 5 ((ratOrbit (road2D 2) c0 s).getD k 0) := by
  have : Fact (Nat.Prime 5) := ⟨by norm_num⟩
  have h := lattice_integral (p := 5) R22s R22s_D_ne latticeFix22_five c0
    (by rw [R22s_n]; exact_mod_cast hc) s k (by rw [R22s_n]; exact hk)
  rw [show R22s = road2Dsym 2 from rfl, ratOrbit_sym2] at h
  exact_mod_cast h hne

/-- **THE SEEDS THAT NEVER GROW (3D, K = 1, p = 3).** -/
theorem lattice_3D_three (c0 : List ℤ)
    (hc : ∀ k < 52, (R31s.D k) % 3 ≠ 0 → (3 : ℤ) ∣ c0.getD k 0) (s k : ℕ) (hk : k < 52)
    (hne : (ratOrbit (road3Dord 1) c0 s).getD k 0 ≠ 0) :
    (if (R31s.D k) % 3 = 0 then 0 else 1) ≤ padicValRat 3 ((ratOrbit (road3Dord 1) c0 s).getD k 0) := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  have h := lattice_integral (p := 3) R31s R31s_D_ne latticeFix31_three c0
    (by rw [R31s_n]; exact_mod_cast hc) s k (by rw [R31s_n]; exact hk)
  rw [show R31s = road3Dsym 1 from rfl, ratOrbit_sym3] at h
  exact_mod_cast h hne

/-- **THE SEEDS THAT NEVER GROW (2D, K = 3, p = 5).** -/
theorem lattice_K3_five (c0 : List ℤ)
    (hc : ∀ k < 48, (R23s.D k) % 5 ≠ 0 → (5 : ℤ) ∣ c0.getD k 0) (s k : ℕ) (hk : k < 48)
    (hne : (ratOrbit (road2D 3) c0 s).getD k 0 ≠ 0) :
    (if (R23s.D k) % 5 = 0 then 0 else 1) ≤ padicValRat 5 ((ratOrbit (road2D 3) c0 s).getD k 0) := by
  have : Fact (Nat.Prime 5) := ⟨by norm_num⟩
  have h := lattice_integral (p := 5) R23s R23s_D_ne latticeFix23_five c0
    (by rw [R23s_n]; exact_mod_cast hc) s k (by rw [R23s_n]; exact hk)
  rw [show R23s = road2Dsym 3 from rfl, ratOrbit_sym2] at h
  exact_mod_cast h hne

/-- **THE SEEDS THAT NEVER GROW (2D, K = 3, p = 13).** -/
theorem lattice_K3_thirteen (c0 : List ℤ)
    (hc : ∀ k < 48, (R23s.D k) % 13 ≠ 0 → (13 : ℤ) ∣ c0.getD k 0) (s k : ℕ) (hk : k < 48)
    (hne : (ratOrbit (road2D 3) c0 s).getD k 0 ≠ 0) :
    (if (R23s.D k) % 13 = 0 then 0 else 1) ≤ padicValRat 13 ((ratOrbit (road2D 3) c0 s).getD k 0) := by
  have : Fact (Nat.Prime 13) := ⟨by norm_num⟩
  have h := lattice_integral (p := 13) R23s R23s_D_ne latticeFix23_thirteen c0
    (by rw [R23s_n]; exact_mod_cast hc) s k (by rw [R23s_n]; exact hk)
  rw [show R23s = road2Dsym 3 from rfl, ratOrbit_sym2] at h
  exact_mod_cast h hne

/-! ## The eternal classes at (2D, K = 2, p = 2): the six seeds of Addendum V -/

/-- the attained law for a 2-adic class at `K = 2`: `J_{s+1}` reached at every step -/
theorem two_law_of_cert (seed M L : ℕ) (hM : 1 ≤ M) (hL : 0 < L) (c : ℤ) (hc : 0 ≤ c)
    (hcert : classCert R22s 2 (seedData seed 24) M L c 1 = true) (s : ℕ) (hs : 1 ≤ s) :
    (∀ k < 24, (rorbit22 seed s).getD k 0 ≠ 0 →
        -padicValRat 2 ((rorbit22 seed s).getD k 0) ≤ (jacobsthal (s + 1) : ℤ)) ∧
    (∃ k < 24, (rorbit22 seed s).getD k 0 ≠ 0 ∧
        -padicValRat 2 ((rorbit22 seed s).getD k 0) = (jacobsthal (s + 1) : ℤ)) := by
  have : Fact (Nat.Prime 2) := ⟨Nat.prime_two⟩
  have hlive := class_eternal (p := 2) R22s (seedData seed 24) M L hM hL c hc 1 (by norm_num)
    (by rw [R22s_n]; norm_num) hcert s hs
  have h := law_of_top R22s R22s_D_ne (seedData seed 24) s hlive
  rw [top22_two _ s hs, ratOrbit_eq_rorbit22, R22s_n] at h
  exact h

theorem cert29 : classCert R22s 2 (seedData 29 24) 2 28 715827880 1 = true := by decide +kernel
theorem cert65 : classCert R22s 2 (seedData 65 24) 2 56 192153584101141160 1 = true := by
  decide +kernel
theorem cert100 : classCert R22s 2 (seedData 100 24) 2 56 192153584101141160 1 = true := by
  decide +kernel
theorem cert111 : classCert R22s 2 (seedData 111 24) 5 2 64 1 = true := by decide +kernel
theorem cert118 : classCert R22s 2 (seedData 118 24) 6 2 128 1 = true := by decide +kernel

/-- **FIVE MORE ETERNAL 2-ADIC LAWS**: the integer seeds 29, 65, 100, 111, 118 attain `J_{s+1}`
at every step (with 19, all six of the first 120 seeds that Addendum V read `PROVED-ALL-STEPS`). -/
theorem seed29_eternal_law (s : ℕ) (hs : 1 ≤ s) :
    (∀ k < 24, (rorbit22 29 s).getD k 0 ≠ 0 →
        -padicValRat 2 ((rorbit22 29 s).getD k 0) ≤ (jacobsthal (s + 1) : ℤ)) ∧
    (∃ k < 24, (rorbit22 29 s).getD k 0 ≠ 0 ∧
        -padicValRat 2 ((rorbit22 29 s).getD k 0) = (jacobsthal (s + 1) : ℤ)) :=
  two_law_of_cert 29 2 28 (by norm_num) (by norm_num) _ (by norm_num) cert29 s hs

theorem seed65_eternal_law (s : ℕ) (hs : 1 ≤ s) :
    (∀ k < 24, (rorbit22 65 s).getD k 0 ≠ 0 →
        -padicValRat 2 ((rorbit22 65 s).getD k 0) ≤ (jacobsthal (s + 1) : ℤ)) ∧
    (∃ k < 24, (rorbit22 65 s).getD k 0 ≠ 0 ∧
        -padicValRat 2 ((rorbit22 65 s).getD k 0) = (jacobsthal (s + 1) : ℤ)) :=
  two_law_of_cert 65 2 56 (by norm_num) (by norm_num) _ (by norm_num) cert65 s hs

theorem seed100_eternal_law (s : ℕ) (hs : 1 ≤ s) :
    (∀ k < 24, (rorbit22 100 s).getD k 0 ≠ 0 →
        -padicValRat 2 ((rorbit22 100 s).getD k 0) ≤ (jacobsthal (s + 1) : ℤ)) ∧
    (∃ k < 24, (rorbit22 100 s).getD k 0 ≠ 0 ∧
        -padicValRat 2 ((rorbit22 100 s).getD k 0) = (jacobsthal (s + 1) : ℤ)) :=
  two_law_of_cert 100 2 56 (by norm_num) (by norm_num) _ (by norm_num) cert100 s hs

theorem seed111_eternal_law (s : ℕ) (hs : 1 ≤ s) :
    (∀ k < 24, (rorbit22 111 s).getD k 0 ≠ 0 →
        -padicValRat 2 ((rorbit22 111 s).getD k 0) ≤ (jacobsthal (s + 1) : ℤ)) ∧
    (∃ k < 24, (rorbit22 111 s).getD k 0 ≠ 0 ∧
        -padicValRat 2 ((rorbit22 111 s).getD k 0) = (jacobsthal (s + 1) : ℤ)) :=
  two_law_of_cert 111 5 2 (by norm_num) (by norm_num) _ (by norm_num) cert111 s hs

theorem seed118_eternal_law (s : ℕ) (hs : 1 ≤ s) :
    (∀ k < 24, (rorbit22 118 s).getD k 0 ≠ 0 →
        -padicValRat 2 ((rorbit22 118 s).getD k 0) ≤ (jacobsthal (s + 1) : ℤ)) ∧
    (∃ k < 24, (rorbit22 118 s).getD k 0 ≠ 0 ∧
        -padicValRat 2 ((rorbit22 118 s).getD k 0) = (jacobsthal (s + 1) : ℤ)) :=
  two_law_of_cert 118 6 2 (by norm_num) (by norm_num) _ (by norm_num) cert118 s hs

/-! ## Eternal classes in three dimensions at the prime 3 -/

theorem three_law_of_cert (seed M L : ℕ) (hM : 1 ≤ M) (hL : 0 < L) (c : ℤ) (hc : 0 ≤ c)
    (hcert : classCert R31s 3 (seedData seed 52) M L c 1 = true) (s : ℕ) (hs : 1 ≤ s) :
    (∀ k < 52, (rorbit31 seed s).getD k 0 ≠ 0 →
        -padicValRat 3 ((rorbit31 seed s).getD k 0) ≤ (jacobsthal s : ℤ)) ∧
    (∃ k < 52, (rorbit31 seed s).getD k 0 ≠ 0 ∧
        -padicValRat 3 ((rorbit31 seed s).getD k 0) = (jacobsthal s : ℤ)) := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  have hlive := class_eternal (p := 3) R31s (seedData seed 52) M L hM hL c hc 1 (by norm_num)
    (by rw [R31s_n]; norm_num) hcert s hs
  have h := law_of_top R31s R31s_D_ne (seedData seed 52) s hlive
  rw [top31_three _ s hs, ratOrbit_eq_rorbit31, R31s_n] at h
  exact h

theorem cert3D17 : classCert R31s 3 (seedData 17 52) 14 18 1431650304 1 = true := by
  decide +kernel
/-- **ETERNAL JACOBSTHAL LAWS IN THREE DIMENSIONS**: the integer seed 17 of the 3D box `K = 1`
attains `J_s` at every step (the seeds 21 and 36, whose closures take 53 and 107 steps, are read in chunks in
`GephyrosisClasses3D.lean`). -/
theorem seed17_3D_eternal_law (s : ℕ) (hs : 1 ≤ s) :
    (∀ k < 52, (rorbit31 17 s).getD k 0 ≠ 0 →
        -padicValRat 3 ((rorbit31 17 s).getD k 0) ≤ (jacobsthal s : ℤ)) ∧
    (∃ k < 52, (rorbit31 17 s).getD k 0 ≠ 0 ∧
        -padicValRat 3 ((rorbit31 17 s).getD k 0) = (jacobsthal s : ℤ)) :=
  three_law_of_cert 17 14 18 (by norm_num) (by norm_num) _ (by norm_num) cert3D17 s hs

/-! ## Eternal classes at an ODD prime: (2D, K = 2, p = 5) -/

/-- the attained law for a 5-adic class at `K = 2`: `2^{s−1}` reached at every step; the residue
scaling `lam` may be any unit -/
theorem five_law_of_cert (seed M L : ℕ) (hM : 1 ≤ M) (hL : 0 < L) (c : ℤ) (hc : 0 ≤ c) (lam : ℕ)
    (hlam : ¬ 5 ∣ lam) (hcert : classCert R22s 5 (seedData seed 24) M L c lam = true) (s : ℕ)
    (hs : 1 ≤ s) :
    (∀ k < 24, (rorbit22 seed s).getD k 0 ≠ 0 →
        -padicValRat 5 ((rorbit22 seed s).getD k 0) ≤ 2 ^ (s - 1)) ∧
    (∃ k < 24, (rorbit22 seed s).getD k 0 ≠ 0 ∧
        -padicValRat 5 ((rorbit22 seed s).getD k 0) = 2 ^ (s - 1)) := by
  have : Fact (Nat.Prime 5) := ⟨by norm_num⟩
  have hlive := class_eternal (p := 5) R22s (seedData seed 24) M L hM hL c hc lam hlam
    (by rw [R22s_n]; norm_num) hcert s hs
  have h := law_of_top R22s R22s_D_ne (seedData seed 24) s hlive
  rw [top22_five _ s hs, ratOrbit_eq_rorbit22, R22s_n] at h
  exact h

theorem cert2688 : classCert R22s 5 (seedData 2688 24) 6 32 137438953440 1 = true := by
  decide +kernel
theorem cert2932 : classCert R22s 5 (seedData 2932 24) 18 48 36893488147418972160 3 = true := by
  decide +kernel
theorem cert3691 : classCert R22s 5 (seedData 3691 24) 24 24 140737479966720 1 = true := by
  decide +kernel

/-- **ETERNAL LAWS AT AN ODD PRIME.** The integer seeds 2688, 2932 and 3691 of the 2D box `K = 2`
attain the 5-adic bound `2^{s−1}` at every step `s ≥ 1`: three integer seeds whose exact orbits
carry EXACTLY `5^{2^{s−1}}` in their denominators forever. The residue state of seed 2932 returns
scaled by the unit 3 (period 48), the other two unscaled (periods 32 and 24). -/
theorem seed2688_eternal_law (s : ℕ) (hs : 1 ≤ s) :
    (∀ k < 24, (rorbit22 2688 s).getD k 0 ≠ 0 →
        -padicValRat 5 ((rorbit22 2688 s).getD k 0) ≤ 2 ^ (s - 1)) ∧
    (∃ k < 24, (rorbit22 2688 s).getD k 0 ≠ 0 ∧
        -padicValRat 5 ((rorbit22 2688 s).getD k 0) = 2 ^ (s - 1)) :=
  five_law_of_cert 2688 6 32 (by norm_num) (by norm_num) _ (by norm_num) 1 (by norm_num) cert2688 s hs

theorem seed2932_eternal_law (s : ℕ) (hs : 1 ≤ s) :
    (∀ k < 24, (rorbit22 2932 s).getD k 0 ≠ 0 →
        -padicValRat 5 ((rorbit22 2932 s).getD k 0) ≤ 2 ^ (s - 1)) ∧
    (∃ k < 24, (rorbit22 2932 s).getD k 0 ≠ 0 ∧
        -padicValRat 5 ((rorbit22 2932 s).getD k 0) = 2 ^ (s - 1)) :=
  five_law_of_cert 2932 18 48 (by norm_num) (by norm_num) _ (by norm_num) 3 (by norm_num) cert2932
    s hs

theorem seed3691_eternal_law (s : ℕ) (hs : 1 ≤ s) :
    (∀ k < 24, (rorbit22 3691 s).getD k 0 ≠ 0 →
        -padicValRat 5 ((rorbit22 3691 s).getD k 0) ≤ 2 ^ (s - 1)) ∧
    (∃ k < 24, (rorbit22 3691 s).getD k 0 ≠ 0 ∧
        -padicValRat 5 ((rorbit22 3691 s).getD k 0) = 2 ^ (s - 1)) :=
  five_law_of_cert 3691 24 24 (by norm_num) (by norm_num) _ (by norm_num) 1 (by norm_num) cert3691
    s hs

end Gephyrosis
