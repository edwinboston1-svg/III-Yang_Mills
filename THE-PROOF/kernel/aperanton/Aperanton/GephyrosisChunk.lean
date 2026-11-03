import Aperanton.GephyrosisClasses

/-!
# ΓΕΦΥΡΩΣΙΣ — the chunked walk: a long certificate read in bounded pieces

A kernel evaluation of the automaton costs about 300 MB a step for the 52-coordinate 3D road, so a
walk of hundreds of steps cannot be one `decide`. The walk is cut: the state at the end of each piece is
written into the source as a literal, a chunk certificate re-derives the next literal from the last
while reading a predicate at every step, and `autoFrom_add` assembles the pieces. `class_eternal_pieces`
is the closure theorem's conclusion drawn from the pieces a chunked certificate delivers.
-/

namespace Gephyrosis


/-- a chunk certificate: the predicate on the walk from `st0` for `N` steps indexed from `s0`,
and the state the walk ends at -/
def chunkCert (R : Road) (p : ℕ) (st0 stN : List ℤ × List ℕ) (s0 N : ℕ)
    (f : ℕ → (List ℤ × List ℕ) → Bool) : Bool :=
  let orb := orbitAux R p N st0
  checkOrbit f s0 orb && decide (orb.getD N ([], []) = stN)

section Chunks

variable {p : ℕ} [hp : Fact p.Prime]

theorem autoFrom_eq_iterate (R : Road) (st0 : List ℤ × List ℕ) (s : ℕ) :
    autoFrom R p st0 s = (autoStep R p)^[s] st0 := by
  induction s with
  | zero => rfl
  | succ s ih =>
    show autoStep R p (autoFrom R p st0 s) = _
    rw [Function.iterate_succ_apply', ih]

theorem autoFrom_add (R : Road) (st0 : List ℤ × List ℕ) (a b : ℕ) :
    autoFrom R p st0 (a + b) = autoFrom R p (autoFrom R p st0 a) b := by
  rw [autoFrom_eq_iterate, autoFrom_eq_iterate, autoFrom_eq_iterate, Nat.add_comm,
    Function.iterate_add_apply]

theorem autoOrbit_eq_from (R : Road) (c0 : List ℤ) (s : ℕ) :
    autoOrbit R p c0 s = autoFrom R p (autoInit R p c0) s := by
  induction s with
  | zero => rfl
  | succ s ih =>
    show autoStep R p (autoOrbit R p c0 s) = autoStep R p (autoFrom R p (autoInit R p c0) s)
    rw [ih]

theorem orbitAux_getD_from (R : Road) :
    ∀ (n : ℕ) (st0 : List ℤ × List ℕ) (i : ℕ), i ≤ n →
      (orbitAux R p n st0).getD i ([], []) = autoFrom R p st0 i := by
  intro n
  induction n with
  | zero =>
    intro st0 i hi
    have : i = 0 := by omega
    subst this
    rfl
  | succ n ih =>
    intro st0 i hi
    cases i with
    | zero => rfl
    | succ i =>
      have h1 : orbitAux R p (n + 1) st0 = st0 :: orbitAux R p n (autoStep R p st0) := rfl
      rw [h1, List.getD_cons_succ, ih (autoStep R p st0) i (by omega), autoFrom_eq_iterate,
        autoFrom_eq_iterate, Function.iterate_succ_apply]

theorem chunk_read (R : Road) (st0 stN : List ℤ × List ℕ) (s0 N : ℕ)
    (f : ℕ → (List ℤ × List ℕ) → Bool) (h : chunkCert R p st0 stN s0 N f = true) :
    (∀ i ≤ N, f (s0 + i) (autoFrom R p st0 i) = true) ∧ autoFrom R p st0 N = stN := by
  unfold chunkCert at h
  simp only [Bool.and_eq_true] at h
  obtain ⟨h1, h2⟩ := h
  refine ⟨fun i hi => ?_, ?_⟩
  · have := checkOrbit_spec f _ s0 h1 i (by rw [orbitAux_length]; omega)
    rwa [orbitAux_getD_from R N st0 i hi] at this
  · have := of_decide_eq_true h2
    rwa [orbitAux_getD_from R N st0 N le_rfl] at this

end Chunks


section Pieces

variable {p : ℕ} [hp : Fact p.Prime]

/-- the closure theorem's conclusion from its pieces: a closure equation at `(M, L)`, non-attainment
on the closing turn, and liveness up to `M + L` give liveness forever -/
theorem class_eternal_pieces (R : Road) (c0 : List ℤ) (M L : ℕ) (hL : 0 < L) (c : ℤ)
    (hc : 0 ≤ c) (lam : ℕ) (hlam : ¬ p ∣ lam) (hn : 0 < R.n) (hwf : Wellformed R)
    (hclose : autoOrbit R p c0 (M + L)
      = ((autoOrbit R p c0 M).1.map (· + c), scaleR p lam (autoOrbit R p c0 M).2))
    (hNA : ∀ i < L, NonAttain R p (autoOrbit R p c0 (M + i)).1)
    (hinit : ∀ s, 1 ≤ s → s ≤ M + L → TopLive R p c0 s) : ∀ s, 1 ≤ s → TopLive R p c0 s := by
  intro s
  induction s using Nat.strong_induction_on with
  | _ s ih =>
    intro hs
    by_cases hlt : s ≤ M + L
    · exact hinit s hs hlt
    · have := topLive_shift R c0 hwf M L hL c hc lam hlam hclose hNA hn (s - M - L)
      rw [show M + L + (s - M - L) = s by omega, show M + (s - M - L) = s - L by omega] at this
      exact this.mpr (ih (s - L) (by omega) (by omega))

end Pieces

end Gephyrosis
