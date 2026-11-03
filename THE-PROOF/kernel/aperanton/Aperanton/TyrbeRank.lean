import Aperanton.GephyrosisEternal

/-!
# ΤΥΡΒΗ — Τ3: a law dies in the kernel of a bilinear form

After closure, on a box where the top block `S` is fed at the top scale only by `S × R` terms (Theorem V's
selection rules at (2D, K = 2, p = 5)), the residue step on `S` is the bilinear map `ξ′ = A(ξ, η)`: for a fixed
`ξ = r_S` it is the matrix `A_ξ` acting on `η = r_R`, and the top is dead at the next step exactly when `η` lies in
`ker A_ξ`. The codimension of the death set at step `s` is `rank A_{ξ(s)}` — the effective dimension that Addendum
IV's open item 1 named from the hazard. This module builds `A_ξ` from the road's own attaining terms, eliminates it
over `𝔽_p`, and reads the rank and the matrix–vector identity along seed 5's exact orbit at (2D, K = 2, p = 5) up to
its death at step 35.
-/

namespace Gephyrosis

/-- the indices at the top of a profile, and the rest -/
def topIdx (t : List ℤ) : List ℕ := (List.range t.length).filter fun k => t.getD k 0 = maxL t
def restIdx (t : List ℤ) : List ℕ := (List.range t.length).filter fun k => t.getD k 0 ≠ maxL t

/-- a term attains the top scale at `k` -/
def attains (R : Road) (p : ℕ) (t : List ℤ) (k : ℕ) (tm : Term) : Bool :=
  decide (qscale p t (R.D k) tm = tNext R p t k)

/-- every attaining term of a top coordinate pairs one top index with one rest index -/
def onlySR (R : Road) (p : ℕ) (t : List ℤ) : Bool :=
  (topIdx t).all fun k => ((R.tb.getD k []).filter (attains R p t k)).all fun tm =>
    decide ((tm.a ∈ topIdx t ∧ tm.b ∈ restIdx t) ∨ (tm.b ∈ topIdx t ∧ tm.a ∈ restIdx t))

/-- the matrix of the bilinear feed at `ξ = r_S`: rows the top indices, columns the rest indices, the entry at
`(k, j)` MINUS the sum of `u · r_s` over the attaining terms of `k` pairing the top index `s` with the column `j` (the
residue step carries `(p − 1)·quadRes`, the sign of the Euler step's `−Q/D`) -/
def aMatrix (R : Road) (p : ℕ) (t : List ℤ) (r : List ℕ) : List (List ℕ) :=
  (topIdx t).map fun k => (restIdx t).map fun j =>
    (((R.tb.getD k []).filter (attains R p t k)).map fun tm =>
      if tm.b = j ∧ tm.a ∈ topIdx t then unitOf p tm.T (R.D k) * r.getD tm.a 0
      else if tm.a = j ∧ tm.b ∈ topIdx t then unitOf p tm.T (R.D k) * r.getD tm.b 0 else 0).sum * (p - 1) % p

/-- a matrix–vector product modulo `p` -/
def matvec (p : ℕ) (A : List (List ℕ)) (v : List ℕ) : List ℕ :=
  A.map fun row => (List.zipWith (· * ·) row v).sum % p

/-- the top block of a residue vector, in the top's index order -/
def topRes (t : List ℤ) (r : List ℕ) : List ℕ := (topIdx t).map fun k => r.getD k 0
def restRes (t : List ℤ) (r : List ℕ) : List ℕ := (restIdx t).map fun k => r.getD k 0

/-- the inverse modulo a prime, by Fermat -/
def invModP (p a : ℕ) : ℕ := a ^ (p - 2) % p

/-- Gaussian elimination over `𝔽_p`, column by column (the fuel is the column count) -/
def elimRank (p : ℕ) : ℕ → List (List ℕ) → ℕ
  | 0, _ => 0
  | c + 1, rows =>
    let live := rows.filter fun r => r.any fun x => x % p ≠ 0
    match live.find? (fun r => r.headD 0 % p ≠ 0) with
    | none => elimRank p c (live.map List.tail)
    | some piv =>
      let pv := invModP p (piv.headD 0 % p)
      let reduced := (live.erase piv).map fun r =>
        let f := r.headD 0 % p * pv % p
        (List.zipWith (fun x y => (x + (p - 1) * f * y) % p) r piv).tail
      1 + elimRank p c reduced

def rankModP (p : ℕ) (rows : List (List ℕ)) : ℕ := elimRank p (rows.headD []).length rows

/-- the KAT: a planted dependent row (row 3 = row 1 + row 2 mod 5, rows 1 and 2 independent) has rank 2 — the first draft planted `[2, 4, 1, 3] = 2·[1, 2, 3, 4]` and read rank 1, correctly: the desk, not the elimination, was wrong (law 18); the identity has full rank;
a zero matrix rank 0 -/
theorem rank_kat :
    rankModP 5 [[1, 2, 3, 4], [0, 1, 1, 1], [1, 3, 4, 0]] = 2 ∧
    rankModP 5 [[1, 0, 0], [0, 1, 0], [0, 0, 1]] = 3 ∧
    rankModP 5 [[0, 0], [0, 0]] = 0 ∧
    rankModP 7 [[2, 4], [3, 6]] = 1 := by decide +kernel

/-! ## The readings along seed 5's orbit at (2D, K = 2, p = 5) -/

/-- the walk of seed 5 to its death step -/
def orb22_5 : List (List ℤ × List ℕ) := orbitAux R22s 5 35 (autoInit R22s 5 (seedData 5 24))

/-- the reading at step `s`: the attaining terms of the top are `S × R`, the next top residues ARE the
matrix–vector product, and the rank is what the list says -/
def rankRead (ranks : List ℕ) (s : ℕ) (st : List ℤ × List ℕ) : Bool :=
  decide (s = 0) || decide (35 ≤ s) ||
    (onlySR R22s 5 st.1
      && decide (topRes (autoStep R22s 5 st).1 (autoStep R22s 5 st).2
            = matvec 5 (aMatrix R22s 5 st.1 st.2) (restRes st.1 st.2))
      && decide (rankModP 5 (aMatrix R22s 5 st.1 st.2) = ranks.getD s 0))

/-- the rank sequence read on the compiled interpreter (05:38), pinned as the known answer (law 30: the page staked
"if constant then 2"; it is NOT constant — it wanders between 5 and 7 and falls to 2 at step 34, the step before
the death, as the top's residues die off one by one: 6 of the 8 are already zero at step 34) -/
def ranks22_5 : List ℕ :=
  [0, 7, 7, 7, 6, 7, 5, 6, 6, 6, 6, 6, 7, 5, 6, 6, 6, 6, 6, 7, 5, 5, 5, 6, 6, 7, 7, 7, 7, 7, 5, 5, 5, 5, 2, 0]

def rankCert : Bool :=
  checkOrbit (rankRead ranks22_5) 0 orb22_5
    && decide (topRes (orb22_5.getD 35 ([], [])).1 (orb22_5.getD 35 ([], [])).2 = List.replicate 8 0)

set_option maxHeartbeats 0 in
theorem rankCert_true : rankCert = true := by decide +kernel

section Reading

/-- **Τ3 on the orbit, every step 1..34**: the attaining terms of the top are `S × R`, the next top residues are
the matrix–vector product `A_ξ η`, and the rank of `A_ξ` is the pinned sequence -/
theorem tau3_read (s : ℕ) (h1 : 1 ≤ s) (h34 : s ≤ 34) :
    let st := autoOrbit R22s 5 (seedData 5 24) s
    onlySR R22s 5 st.1 = true ∧
    topRes (autoOrbit R22s 5 (seedData 5 24) (s + 1)).1 (autoOrbit R22s 5 (seedData 5 24) (s + 1)).2
      = matvec 5 (aMatrix R22s 5 st.1 st.2) (restRes st.1 st.2) ∧
    rankModP 5 (aMatrix R22s 5 st.1 st.2) = ranks22_5.getD s 0 := by
  have : Fact (Nat.Prime 5) := ⟨by norm_num⟩
  have hc := rankCert_true
  unfold rankCert at hc
  simp only [Bool.and_eq_true] at hc
  have hr := orbit_check R22s 5 (seedData 5 24) 35 _ hc.1 s (by omega)
  unfold rankRead at hr
  simp only [Bool.or_eq_true, Bool.and_eq_true, decide_eq_true_eq] at hr
  rcases hr with (h | h) | ⟨⟨hsr, hmv⟩, hrk⟩
  · omega
  · omega
  · exact ⟨hsr, hmv, hrk⟩

/-- **THE DEATH IS THE KERNEL**: at step 35 the top residues vanish, and they are `A_{ξ(34)} η(34)` with
`rank A_{ξ(34)} = 2` — seed 5's 5-adic law dies in the kernel of a rank-2 form, after the top's support has
collapsed from eight residues to two. -/
theorem tau3_death :
    topRes (autoOrbit R22s 5 (seedData 5 24) 35).1 (autoOrbit R22s 5 (seedData 5 24) 35).2 = List.replicate 8 0 ∧
    rankModP 5 (aMatrix R22s 5 (autoOrbit R22s 5 (seedData 5 24) 34).1
      (autoOrbit R22s 5 (seedData 5 24) 34).2) = 2 := by
  have : Fact (Nat.Prime 5) := ⟨by norm_num⟩
  have hc := rankCert_true
  unfold rankCert at hc
  simp only [Bool.and_eq_true] at hc
  have hr := (tau3_read 34 (by norm_num) le_rfl).2.2
  rw [show ranks22_5.getD 34 0 = 2 by rfl] at hr
  refine ⟨?_, hr⟩
  have h := of_decide_eq_true hc.2
  unfold orb22_5 at h
  rwa [show autoInit R22s 5 (seedData 5 24) = autoOrbit R22s 5 (seedData 5 24) 0 from rfl,
    orbitAux_getD R22s 5 (seedData 5 24) 35 0 35 le_rfl, Nat.zero_add] at h

end Reading

end Gephyrosis
