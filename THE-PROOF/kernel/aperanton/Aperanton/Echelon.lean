/-
  APERANTON -- THE BOUNDLESS, stage W4's bridge B3 (ADDENDUM I, THE ROAD): THE ECHELON CERTIFICATE -- THE RANK OF A
  MASK LIST AS THE FINRANK OF ITS SPAN, CERTIFIED, NEVER COMPUTED IN THE KERNEL BY AN ALGORITHM'S CORRECTNESS.

  THE CERTIFICATE (`EchelonCert`): a list of n masks with a list of n pivot bits such that mask i has its pivot bit
  set (`hit`) and no OTHER mask has that bit (`miss`) -- every clause a bounded test-bit check, decided for a concrete
  list.  THE THEOREM (`card_span_eq_pow`): the span of the masks' vectors in F₂^N has exactly 2^n members.  Below: for
  a selection mask m over the indices, `vecSel m` is the sum of the selected vectors; its coordinate at the pivot of
  i is the indicator of i's selection (`vecSel_pivot`, the one contributor), so distinct selections give distinct
  vectors (`vecSel_injective` through `Nat.eq_of_testBit_eq`), which puts 2^n members in the span; above: the span of
  n vectors has at most 2^n members (`finrank_span_le_card` with `Module.card_eq_pow_finrank`).  THE TRANSFER
  (`span_eq_of_certs`): a generator list whose every member is a certified selection of the basis, and a basis whose
  every member is a certified selection of the generators, span the same submodule -- so the generators' span has
  2^n members and finrank n.  The emitter (gawk -M, or ΜΕΙΖΩΝ's Smith form as the second road) writes, for the
  2⁴ torus, the 45-element bases of δ¹'s and ∂₃'s columns with their pivots and selection tables, and the
  51-element basis of ∂₃'s columns with the six sheets; `Torus4Cert.lean` decides the clauses.  Classical linear
  algebra (W = 0); the earning is that the kernel reads a certificate and never runs the elimination.
  No sorry, no axiom, no native_decide.
-/
import Mathlib

open Finset

namespace Aperanton

section Vec

variable {N : ℕ}

/-- a mask as a vector of F₂^N -/
def vecOfN (N : ℕ) (m : ℕ) : Fin N → ZMod 2 := fun i => if Nat.testBit m i.val then 1 else 0

theorem vecOfN_apply (m : ℕ) (i : Fin N) : vecOfN N m i = if Nat.testBit m i.val then 1 else 0 := rfl

end Vec

section Cert

/-- THE ECHELON CERTIFICATE: n masks, n pivot bits, mask i hits its pivot, no other mask does -/
structure EchelonCert (basis piv : List ℕ) : Prop where
  len : piv.length = basis.length
  hit : ∀ (i : Fin basis.length), Nat.testBit (basis.get i) (piv.getD i.val 0) = true
  miss : ∀ (i j : Fin basis.length), i ≠ j → Nat.testBit (basis.get j) (piv.getD i.val 0) = false

variable (N : ℕ) (basis piv : List ℕ)

/-- the selection of the basis by an index mask m: Σ_{i : testBit m i} vecOf basis[i] -/
def vecSel (m : ℕ) : Fin N → ZMod 2 :=
  ∑ i : Fin basis.length, if Nat.testBit m i.val then vecOfN N (basis.get i) else 0

/-- the set of the basis vectors -/
def basisSet : Set (Fin N → ZMod 2) := Set.range (fun i : Fin basis.length => vecOfN N (basis.get i))

/-- every selection lies in the span of the basis vectors -/
theorem vecSel_mem_span (m : ℕ) : vecSel N basis m ∈ Submodule.span (ZMod 2) (basisSet N basis) := by
  unfold vecSel
  apply Submodule.sum_mem
  intro i _
  split_ifs
  · exact Submodule.subset_span ⟨i, rfl⟩
  · exact Submodule.zero_mem _

/-- THE PIVOT COORDINATE OF A SELECTION IS THE INDICATOR OF THE SELECTION: only mask i contributes at pivot i -/
theorem vecSel_pivot (hc : EchelonCert basis piv) (m : ℕ) (i : Fin basis.length)
    (hp : piv.getD i.val 0 < N) :
    vecSel N basis m ⟨piv.getD i.val 0, hp⟩ = if Nat.testBit m i.val then 1 else 0 := by
  unfold vecSel
  rw [Finset.sum_apply]
  have hterm : ∀ j : Fin basis.length,
      (if Nat.testBit m j.val then vecOfN N (basis.get j) else 0) ⟨piv.getD i.val 0, hp⟩
        = if j = i then (if Nat.testBit m i.val then (1 : ZMod 2) else 0) else 0 := by
    intro j
    by_cases hji : j = i
    · subst hji
      rw [if_pos rfl]
      split_ifs with hm
      · rw [vecOfN_apply, if_pos (hc.hit j)]
      · rfl
    · rw [if_neg hji]
      split_ifs with hm
      · rw [vecOfN_apply, if_neg]
        rw [hc.miss i j (Ne.symm hji)]
        exact Bool.false_ne_true
      · rfl
  simp_rw [hterm]
  rw [Finset.sum_ite_eq']
  simp

/-- THE SELECTIONS ARE DISTINCT: an index mask below 2^n is read off its selection's pivot coordinates -/
theorem vecSel_injective (hc : EchelonCert basis piv) (hpiv : ∀ p ∈ piv, p < N) (m m' : ℕ)
    (hm : m < 2 ^ basis.length) (hm' : m' < 2 ^ basis.length) (h : vecSel N basis m = vecSel N basis m') :
    m = m' := by
  apply Nat.eq_of_testBit_eq
  intro i
  by_cases hi : i < basis.length
  · have hp : piv.getD i 0 < N := by
      have hil : i < piv.length := by rw [hc.len]; exact hi
      rw [List.getD_eq_getElem _ _ hil]
      exact hpiv _ (List.getElem_mem hil)
    have h1 := vecSel_pivot N basis piv hc m ⟨i, hi⟩ hp
    have h2 := vecSel_pivot N basis piv hc m' ⟨i, hi⟩ hp
    rw [h] at h1
    rw [h1] at h2
    by_cases hb : Nat.testBit m i <;> by_cases hb' : Nat.testBit m' i <;> simp_all
  · have hzero : Nat.testBit m i = false := Nat.testBit_lt_two_pow (lt_of_lt_of_le hm (Nat.pow_le_pow_right (by norm_num) (not_lt.mp hi)))
    have hzero' : Nat.testBit m' i = false := Nat.testBit_lt_two_pow (lt_of_lt_of_le hm' (Nat.pow_le_pow_right (by norm_num) (not_lt.mp hi)))
    rw [hzero, hzero']

open Classical in
/-- the span of n certified vectors has at least 2^n members -/
theorem pow_le_card_span (hc : EchelonCert basis piv) (hpiv : ∀ p ∈ piv, p < N) :
    2 ^ basis.length ≤ Fintype.card (Submodule.span (ZMod 2) (basisSet N basis)) := by
  classical
  let f : Fin (2 ^ basis.length) → Submodule.span (ZMod 2) (basisSet N basis) :=
    fun m => ⟨vecSel N basis m.val, vecSel_mem_span N basis m.val⟩
  have hf : Function.Injective f := by
    intro a b hab
    have := congrArg Subtype.val hab
    exact Fin.ext (vecSel_injective N basis piv hc hpiv a.val b.val a.isLt b.isLt this)
  have := Fintype.card_le_of_injective f hf
  simpa using this

open Classical in
/-- the span of n vectors has at most 2^n members -/
theorem card_span_le_pow : Fintype.card (Submodule.span (ZMod 2) (basisSet N basis)) ≤ 2 ^ basis.length := by
  classical
  rw [Module.card_eq_pow_finrank (K := ZMod 2), ZMod.card]
  apply Nat.pow_le_pow_right (by norm_num)
  have h := finrank_range_le_card (R := ZMod 2) (fun i : Fin basis.length => vecOfN N (basis.get i))
  rw [Fintype.card_fin] at h
  exact h

open Classical in
/-- THE SPAN OF A CERTIFIED BASIS HAS EXACTLY 2^n MEMBERS, so its finrank is n -/
theorem card_span_eq_pow (hc : EchelonCert basis piv) (hpiv : ∀ p ∈ piv, p < N) :
    Fintype.card (Submodule.span (ZMod 2) (basisSet N basis)) = 2 ^ basis.length :=
  le_antisymm (card_span_le_pow N basis) (pow_le_card_span N basis piv hc hpiv)

theorem finrank_span_eq (hc : EchelonCert basis piv) (hpiv : ∀ p ∈ piv, p < N) :
    Module.finrank (ZMod 2) (Submodule.span (ZMod 2) (basisSet N basis)) = basis.length := by
  classical
  have h := card_span_eq_pow N basis piv hc hpiv
  rw [Module.card_eq_pow_finrank (K := ZMod 2), ZMod.card] at h
  exact Nat.pow_right_injective (le_refl 2) h

end Cert

section XorSel

/-- the selection at the mask level: the xor of the basis masks whose index bit is set in m -/
def xorSel (m : ℕ) (basis : List ℕ) : ℕ :=
  (List.range basis.length).foldl (fun acc i => if Nat.testBit m i then Nat.xor acc (basis.getD i 0) else acc) 0

/-- a bit of a conditional xor-fold is the xor-fold of the bits -/
theorem testBit_foldl_xor (l : List ℕ) (c : ℕ → Bool) (v : ℕ → ℕ) (j : ℕ) (acc : ℕ) :
    Nat.testBit (l.foldl (fun a i => if c i then Nat.xor a (v i) else a) acc) j
      = l.foldl (fun b i => xor b (c i && Nat.testBit (v i) j)) (Nat.testBit acc j) := by
  induction l generalizing acc with
  | nil => rfl
  | cons i l ih =>
    simp only [List.foldl_cons]
    rw [ih]
    congr 1
    by_cases hc : c i
    · simp [hc, Nat.testBit_xor]
    · simp [hc]

/-- the ZMod 2 indicator of a Bool -/
def bz (b : Bool) : ZMod 2 := if b then 1 else 0

theorem bz_xor (a b : Bool) : bz (xor a b) = bz a + bz b := by
  cases a <;> cases b <;> decide

/-- a Fin-sum of indicators over the range is the xor-fold of the Bools -/
theorem sum_bz_eq_foldl (n : ℕ) (f : ℕ → Bool) (acc : Bool) :
    bz acc + ∑ i : Fin n, bz (f i.val) = bz ((List.range n).foldl (fun b i => xor b (f i)) acc) := by
  induction n generalizing acc with
  | zero => simp only [Fin.sum_univ_zero, add_zero, List.range_zero, List.foldl_nil]
  | succ n ih =>
    rw [Fin.sum_univ_castSucc, List.range_succ, List.foldl_append, List.foldl_cons, List.foldl_nil]
    simp only [Fin.val_castSucc, Fin.val_last]
    rw [← add_assoc, ih acc, bz_xor]

/-- THE BRIDGE: the vector of the mask selection is the selection of the vectors -/
theorem vecOfN_xorSel (N : ℕ) (basis : List ℕ) (m : ℕ) :
    vecOfN N (xorSel m basis) = vecSel N basis m := by
  funext j
  rw [vecOfN_apply, vecSel, Finset.sum_apply]
  unfold xorSel
  rw [testBit_foldl_xor (List.range basis.length) (fun i => Nat.testBit m i) (fun i => basis.getD i 0) j.val 0,
    Nat.zero_testBit]
  have hterm : ∀ i : Fin basis.length,
      (if Nat.testBit m i.val then vecOfN N (basis.get i) else 0) j
        = bz (Nat.testBit m i.val && Nat.testBit (basis.getD i.val 0) j.val) := by
    intro i
    rw [List.getD_eq_getElem _ _ i.isLt]
    by_cases hm : Nat.testBit m i.val
    · simp [hm, vecOfN_apply, bz, List.get_eq_getElem]
    · simp [hm, bz]
  simp_rw [hterm]
  have h := sum_bz_eq_foldl basis.length (fun i => Nat.testBit m i && Nat.testBit (basis.getD i 0) j.val) false
  rw [(by decide : bz false = 0), zero_add] at h
  rw [h]
  rfl

end XorSel

section Transfer

variable (N : ℕ)

/-- a generator list is spanned by the basis when every generator is a mask selection of the basis -/
theorem span_le_of_sel (gens basis : List ℕ) (sel : List ℕ)
    (hsel : ∀ (i : Fin gens.length), gens.get i = xorSel (sel.getD i.val 0) basis) :
    Submodule.span (ZMod 2) (basisSet N gens) ≤ Submodule.span (ZMod 2) (basisSet N basis) := by
  rw [Submodule.span_le]
  rintro _ ⟨i, rfl⟩
  show vecOfN N (gens.get i) ∈ Submodule.span (ZMod 2) (basisSet N basis)
  rw [hsel i, vecOfN_xorSel]
  exact vecSel_mem_span N basis _

/-- THE TRANSFER: mutual mask selections make the two spans equal -/
theorem span_eq_of_certs (gens basis : List ℕ) (selG selB : List ℕ)
    (hselG : ∀ (i : Fin gens.length), gens.get i = xorSel (selG.getD i.val 0) basis)
    (hselB : ∀ (i : Fin basis.length), basis.get i = xorSel (selB.getD i.val 0) gens) :
    Submodule.span (ZMod 2) (basisSet N gens) = Submodule.span (ZMod 2) (basisSet N basis) :=
  le_antisymm (span_le_of_sel N gens basis selG hselG) (span_le_of_sel N basis gens selB hselB)

/-- THE RANK OF A GENERATOR LIST FROM ITS CERTIFICATE: the finrank of the generators' span is the basis length -/
theorem finrank_gens_eq (gens basis piv selG selB : List ℕ) (hc : EchelonCert basis piv)
    (hpiv : ∀ p ∈ piv, p < N)
    (hselG : ∀ (i : Fin gens.length), gens.get i = xorSel (selG.getD i.val 0) basis)
    (hselB : ∀ (i : Fin basis.length), basis.get i = xorSel (selB.getD i.val 0) gens) :
    Module.finrank (ZMod 2) (Submodule.span (ZMod 2) (basisSet N gens)) = basis.length := by
  rw [span_eq_of_certs N gens basis selG selB hselG hselB]
  exact finrank_span_eq N basis piv hc hpiv

open Classical in
/-- the span's cardinality from the certificate -/
theorem card_gens_eq (gens basis piv selG selB : List ℕ) (hc : EchelonCert basis piv)
    (hpiv : ∀ p ∈ piv, p < N)
    (hselG : ∀ (i : Fin gens.length), gens.get i = xorSel (selG.getD i.val 0) basis)
    (hselB : ∀ (i : Fin basis.length), basis.get i = xorSel (selB.getD i.val 0) gens) :
    Fintype.card (Submodule.span (ZMod 2) (basisSet N gens)) = 2 ^ basis.length := by
  classical
  rw [Module.card_eq_pow_finrank (K := ZMod 2), ZMod.card,
    finrank_gens_eq N gens basis piv selG selB hc hpiv hselG hselB]

end Transfer

end Aperanton
