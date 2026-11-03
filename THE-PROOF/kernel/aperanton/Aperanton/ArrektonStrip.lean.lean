import Aperanton.GephyrosisRoadK31Eq

/-!
# ΑΡΡΗΚΤΟΝ ADDENDUM VI — THEOREM W2 (i) IN THE KERNEL: THE PATTERN IS BLIND TO THE SIGN

`stripRoad R` is the road `R` with every tensor coefficient replaced by its absolute value — the
support kept, every valuation kept, every sign dropped.  The one-digit automaton's PROFILE
(`(autoOrbit R p c0 s).1`, Theorem T's `t`-recursion) is IDENTICAL on `R` and on `stripRoad R`
for every prime `p`, every integer seed `c0` and every step `s`: `profile_strip`.  The RESIDUES
(the second component) are not — `residues_part` exhibits a step of the literal 3D road at `K = 1`
where they differ.  The theorem is the Lean form of Addendum VI's W2 (i): every law the road
derives from the profile — Theorem T's bounds, Theorem D's closure, the height constants, the
conductor, ΤΥΡΒΗ's shape and cascade time, the pattern depth — is shared with the sign-stripped
model, whose Galerkin equations blow up in finite time at every box (W2 (ii), on the page).

Status: PROVED here (the general theorem by induction on the step; the parting of the residues
by `decide +kernel` on the literal road).  Nothing about the flow's existence is claimed; the
theorem says what the profile cannot see.
-/

namespace Gephyrosis

/-- the term with its coefficient's sign dropped: the support and the valuation kept -/
def stripTerm (t : Term) : Term := { t with T := (t.T.natAbs : ℤ) }

/-- the road with every coefficient's sign dropped -/
def stripRoad (R : Road) : Road := { R with tb := R.tb.map (List.map stripTerm) }

theorem vpAux_neg (p : ℕ) : ∀ (f : ℕ) (n : ℤ), vpAux p f (-n) = vpAux p f n := by
  intro f
  induction f with
  | zero => intro n; rfl
  | succ f ih =>
    intro n
    simp only [vpAux]
    by_cases h : n ≠ 0 ∧ n % (p : ℤ) = 0
    · have hd : (p : ℤ) ∣ n := Int.dvd_of_emod_eq_zero h.2
      have h' : -n ≠ 0 ∧ (-n) % (p : ℤ) = 0 :=
        ⟨neg_ne_zero.mpr h.1, Int.emod_eq_zero_of_dvd ((dvd_neg).mpr hd)⟩
      rw [if_pos h', if_pos h, Int.neg_ediv_of_dvd hd, ih]
    · have h' : ¬ (-n ≠ 0 ∧ (-n) % (p : ℤ) = 0) := by
        intro hc
        apply h
        refine ⟨fun h0 => hc.1 (by simp [h0]), ?_⟩
        exact Int.emod_eq_zero_of_dvd ((dvd_neg).mp (Int.dvd_of_emod_eq_zero hc.2))
      rw [if_neg h', if_neg h]

theorem vpI_neg (p : ℕ) (n : ℤ) : vpI p (-n) = vpI p n := by
  unfold vpI
  rw [Int.natAbs_neg, vpAux_neg]

/-- the valuation of an integer is the valuation of its absolute value -/
theorem vpI_natAbs (p : ℕ) (n : ℤ) : vpI p (n.natAbs : ℤ) = vpI p n := by
  rcases Int.natAbs_eq n with h | h
  · rw [← h]
  · calc vpI p (n.natAbs : ℤ) = vpI p (-(n.natAbs : ℤ)) := (vpI_neg p _).symm
      _ = vpI p n := by rw [← h]

theorem qscale_strip (p : ℕ) (t : List ℤ) (D : ℤ) (tm : Term) :
    qscale p t D (stripTerm tm) = qscale p t D tm := by
  unfold qscale
  show t.getD tm.a 0 + t.getD tm.b 0 + (vpI p D : ℤ) - (vpI p (tm.T.natAbs : ℤ) : ℤ) = _
  rw [vpI_natAbs]

theorem getD_map_nil {α β : Type} (f : List α → List β) (hf : f [] = [])
    (l : List (List α)) (k : ℕ) : (l.map f).getD k [] = f (l.getD k []) := by
  induction l generalizing k with
  | nil => simp [hf]
  | cons x xs ih =>
    cases k with
    | zero => simp
    | succ n => simpa using ih n

theorem tb_strip (R : Road) (k : ℕ) :
    (stripRoad R).tb.getD k [] = (R.tb.getD k []).map stripTerm :=
  getD_map_nil (List.map stripTerm) rfl R.tb k

theorem qmax_strip (R : Road) (p : ℕ) (t : List ℤ) (k : ℕ) :
    qmax (stripRoad R) p t k = qmax R p t k := by
  unfold qmax
  rw [tb_strip]
  show maxL (((R.tb.getD k []).map stripTerm).map (qscale p t (R.D k))) = _
  rw [List.map_map]
  congr 1
  apply List.map_congr_left
  intro tm _
  exact qscale_strip p t (R.D k) tm

theorem tNext_strip (R : Road) (p : ℕ) (t : List ℤ) (k : ℕ) :
    tNext (stripRoad R) p t k = tNext R p t k := by
  unfold tNext
  rw [qmax_strip]
  rfl

/-- **W2 (i)**: the profile of the one-digit automaton is the same on the road and on its
sign-stripped road, at every prime, from every integer seed, at every step. -/
theorem profile_strip (R : Road) (p : ℕ) (c0 : List ℤ) :
    ∀ s : ℕ, (autoOrbit (stripRoad R) p c0 s).1 = (autoOrbit R p c0 s).1
  | 0 => rfl
  | s + 1 => by
    simp only [autoOrbit, autoStep]
    rw [profile_strip R p c0 s]
    exact List.map_congr_left (fun k _ => tNext_strip R p _ k)

/-- the seed of ones on the 52 coordinates of the 3D box at `K = 1` -/
def one52 : List ℤ := List.replicate 52 1

/-- the residues PART: on the literal 3D road the units see the sign at the first step -/
theorem residues_part :
    (autoOrbit (stripRoad R31lit) 3 one52 1).2 ≠ (autoOrbit R31lit 3 one52 1).2 := by
  decide +kernel

/-- and the profiles do not, read by the kernel on the literal road to step 4 -/
theorem profile_same_4 :
    (autoOrbit (stripRoad R31lit) 3 one52 4).1 = (autoOrbit R31lit 3 one52 4).1 :=
  profile_strip R31lit 3 one52 4

#print axioms profile_strip
#print axioms residues_part
#print axioms profile_same_4

end Gephyrosis
