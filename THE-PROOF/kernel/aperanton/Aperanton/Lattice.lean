/-
  APERANTON -- THE BOUNDLESS, stage A5 (second landing): THE INFINITE-VOLUME WILSON LOOP EXISTS.

  The lattice is any set of links E with plaquettes P, each plaquette a finite set of links; nothing is finite.
  The Wilson expectation on a finite box Λ ⊆ P is written in the combinatorial form the character expansion gave
  (Griffiths.lean, `expect_eq_Wc`): surfaces inside Λ bounded by A over closed surfaces inside Λ.  Three facts carry
  it to infinity: a coupling of zero is an absent plaquette, so the box's expectation is the bigger box's at the
  cut couplings (THE RESTRICTION); the finite box is a finite configuration model, where Griffiths II made every
  expectation nondecreasing in every coupling (THE BRIDGE and THE MONOTONICITY); and a nondecreasing sequence
  bounded by one converges to its supremum (THE LIMIT).  Hence W_∞(A) = sup_Λ W_Λ(A) exists and every exhausting
  sequence of boxes reaches it: Mechanism S, the first half, proved for III's Z₂ weights.  No sorry, no axiom.
-/
import Mathlib
import Aperanton.Griffiths

open Finset Filter Topology

set_option maxHeartbeats 800000

namespace Aperanton

variable {E : Type*} {P : Type*} [DecidableEq E] [DecidableEq P]

/-- the indicator of a plaquette's finite link set -/
def toInd (plaqF : P → Finset E) : P → E → Bool := fun p e => decide (e ∈ plaqF p)

/-- the links touched by a box of plaquettes -/
def linksOf (plaqF : P → Finset E) (Λ : Finset P) : Finset E := Λ.biUnion plaqF

/-- the boundary of a set of plaquettes on any lattice: the links covered an odd number of times -/
def bdL (plaq : P → E → Bool) (t : Finset P) : E → Bool :=
  fun e => decide (Odd (t.filter (fun p => plaq p e = true)).card)

/-- on a finite lattice the two boundaries are one definition -/
theorem bdL_eq_bd [Fintype E] [Fintype P] (plaq : P → E → Bool) (t : Finset P) : bdL plaq t = bd plaq t := rfl

open Classical in
/-- THE WILSON EXPECTATION ON A BOX, combinatorial form: surfaces bounded by A over closed surfaces, inside Λ -/
noncomputable def WcL (plaq : P → E → Bool) (y : P → ℝ) (Λ : Finset P) (A : E → Bool) : ℝ :=
  (∑ t ∈ Λ.powerset, if bdL plaq t = A then ∏ p ∈ t, y p else 0)
    / (∑ t ∈ Λ.powerset, if bdL plaq t = (fun _ => false) then ∏ p ∈ t, y p else 0)

/-- the couplings cut to a box -/
def cut (y : P → ℝ) (Λ : Finset P) : P → ℝ := fun p => if p ∈ Λ then y p else 0

theorem cut_nonneg (y : P → ℝ) (hy0 : ∀ p, 0 ≤ y p) (Λ : Finset P) : ∀ p, 0 ≤ cut y Λ p := by
  intro p; unfold cut; split_ifs; · exact hy0 p
  · exact le_rfl

theorem cut_le (y : P → ℝ) (hy0 : ∀ p, 0 ≤ y p) (Λ : Finset P) : ∀ p, cut y Λ p ≤ y p := by
  intro p; unfold cut; split_ifs; · exact le_rfl
  · exact hy0 p

theorem cut_zero_outside (y : P → ℝ) (Λ : Finset P) : ∀ p, p ∉ Λ → cut y Λ p = 0 := by
  intro p hp; simp [cut, hp]

/-- THE RESTRICTION: couplings vanishing outside the smaller box make the bigger box's expectation the smaller's -/
theorem WcL_restrict (plaq : P → E → Bool) (y : P → ℝ) {Λ Λ' : Finset P} (h : Λ ⊆ Λ')
    (hy : ∀ p, p ∉ Λ → y p = 0) (A : E → Bool) : WcL plaq y Λ' A = WcL plaq y Λ A := by
  classical
  unfold WcL
  have key : ∀ B : E → Bool,
      (∑ t ∈ Λ'.powerset, if bdL plaq t = B then ∏ p ∈ t, y p else 0)
        = ∑ t ∈ Λ.powerset, if bdL plaq t = B then ∏ p ∈ t, y p else 0 := by
    intro B
    symm
    apply Finset.sum_subset (Finset.powerset_mono.mpr h)
    intro t ht hnot
    rw [Finset.mem_powerset] at ht hnot
    obtain ⟨p, hp, hpΛ⟩ : ∃ p ∈ t, p ∉ Λ := by
      by_contra hc
      push Not at hc
      exact hnot (fun p hp => hc p hp)
    have hz : ∏ q ∈ t, y q = 0 := Finset.prod_eq_zero hp (hy p hpΛ)
    rw [hz]
    simp
  rw [key A, key (fun _ => false)]

/-- cutting the couplings to the box changes nothing on the box -/
theorem WcL_cut (plaq : P → E → Bool) (y : P → ℝ) (Λ : Finset P) (A : E → Bool) :
    WcL plaq (cut y Λ) Λ A = WcL plaq y Λ A := by
  classical
  unfold WcL
  have key : ∀ t ∈ Λ.powerset, ∏ p ∈ t, cut y Λ p = ∏ p ∈ t, y p := by
    intro t ht
    apply Finset.prod_congr rfl
    intro p hp
    simp [cut, Finset.mem_powerset.mp ht hp]
  have h2 : ∀ B : E → Bool,
      (∑ t ∈ Λ.powerset, if bdL plaq t = B then ∏ p ∈ t, cut y Λ p else 0)
        = ∑ t ∈ Λ.powerset, if bdL plaq t = B then ∏ p ∈ t, y p else 0 := by
    intro B
    apply Finset.sum_congr rfl
    intro t ht
    rw [key t ht]
  rw [h2 A, h2 (fun _ => false)]

/-- a surface inside the box has its boundary inside the box's links -/
theorem bdL_subset_links (plaqF : P → Finset E) {Λ : Finset P} {t : Finset P} (ht : t ⊆ Λ) (e : E)
    (he : e ∉ linksOf plaqF Λ) : bdL (toInd plaqF) t e = false := by
  unfold bdL
  have hf : t.filter (fun p => toInd plaqF p e = true) = ∅ := by
    apply Finset.filter_eq_empty_iff.mpr
    intro p hp hpe
    apply he
    unfold linksOf
    rw [Finset.mem_biUnion]
    exact ⟨p, ht hp, by simpa [toInd] using hpe⟩
  rw [hf]
  simp

/-- a box too small for the loop carries no surface bounded by it: the expectation is zero -/
theorem WcL_eq_zero_of_not_subset (plaqF : P → Finset E) (y : P → ℝ) (Λ : Finset P) (A : E → Bool)
    (hA : ¬ ∀ e, A e = true → e ∈ linksOf plaqF Λ) : WcL (toInd plaqF) y Λ A = 0 := by
  classical
  unfold WcL
  push Not at hA
  obtain ⟨e, he, heΛ⟩ := hA
  have key : ∀ t ∈ Λ.powerset, (if bdL (toInd plaqF) t = A then ∏ p ∈ t, y p else 0) = 0 := by
    intro t ht
    rw [if_neg]
    intro hb
    have := congrFun hb e
    rw [bdL_subset_links plaqF (Finset.mem_powerset.mp ht) e heΛ] at this
    rw [he] at this
    exact Bool.false_ne_true this
  rw [Finset.sum_eq_zero key, zero_div]

/-- THE BRIDGE: the box's combinatorial expectation is the configuration expectation of the finite model on the
box's own plaquettes and links -/
theorem WcL_eq_Wc (plaqF : P → Finset E) (y : P → ℝ) (Λ : Finset P) (A : E → Bool)
    (hA : ∀ e, A e = true → e ∈ linksOf plaqF Λ) :
    WcL (toInd plaqF) y Λ A
      = Wc (fun (p : ↥Λ) (e : ↥(linksOf plaqF Λ)) => toInd plaqF p.1 e.1) (fun p => y p.1) Finset.univ
          (fun e => A e.1) := by
  classical
  unfold WcL Wc
  -- the boundary of a surface read on the box's links agrees with the lattice boundary
  have hbd : ∀ (t₀ : Finset ↥Λ) (e : ↥(linksOf plaqF Λ)),
      bd (fun (p : ↥Λ) (e : ↥(linksOf plaqF Λ)) => toInd plaqF p.1 e.1) t₀ e
        = bdL (toInd plaqF) (t₀.map (Function.Embedding.subtype _)) e.1 := by
    intro t₀ e
    simp only [bd, bdL, Finset.filter_map, Finset.card_map]
    rfl
  have hmem : ∀ t₀ : Finset ↥Λ, t₀.map (Function.Embedding.subtype _) ⊆ Λ := by
    intro t₀ p hp
    rw [Finset.mem_map] at hp
    obtain ⟨q, -, rfl⟩ := hp
    exact q.2
  have hiff : ∀ t₀ : Finset ↥Λ,
      (bdL (toInd plaqF) (t₀.map (Function.Embedding.subtype _)) = A
        ↔ bd (fun (p : ↥Λ) (e : ↥(linksOf plaqF Λ)) => toInd plaqF p.1 e.1) t₀ = fun e => A e.1) := by
    intro t₀
    constructor
    · intro h
      funext e
      rw [hbd, h]
    · intro h
      funext e
      by_cases he : e ∈ linksOf plaqF Λ
      · have := congrFun h ⟨e, he⟩
        rw [hbd] at this
        exact this
      · rw [bdL_subset_links plaqF (hmem t₀) e he]
        by_contra hc
        have : A e = true := by
          rcases Bool.eq_false_or_eq_true (A e) with h1 | h1
          · exact h1
          · exact absurd h1.symm hc
        exact he (hA e this)
  -- the two sums correspond under t ↦ t.subtype, t₀ ↦ t₀.map
  have hleft : ∀ t ∈ Λ.powerset, (t.subtype (· ∈ Λ)).map (Function.Embedding.subtype _) = t := by
    intro t ht
    rw [Finset.subtype_map]
    exact Finset.filter_true_of_mem (fun p hp => Finset.mem_powerset.mp ht hp)
  have hright : ∀ t₀ : Finset ↥Λ, (t₀.map (Function.Embedding.subtype _)).subtype (· ∈ Λ) = t₀ := by
    intro t₀
    ext x
    rw [Finset.mem_subtype]
    exact Finset.mem_map' _
  have hprod : ∀ t ∈ Λ.powerset, ∏ p ∈ t.subtype (· ∈ Λ), y p.1 = ∏ p ∈ t, y p := by
    intro t ht
    conv_rhs => rw [← hleft t ht]
    rw [Finset.prod_map]
    rfl
  have key : ∀ B : E → Bool, (∀ e, B e = true → e ∈ linksOf plaqF Λ) →
      (∑ t ∈ Λ.powerset, if bdL (toInd plaqF) t = B then ∏ p ∈ t, y p else 0)
        = ∑ t₀ ∈ (Finset.univ : Finset ↥Λ).powerset,
            if bd (fun (p : ↥Λ) (e : ↥(linksOf plaqF Λ)) => toInd plaqF p.1 e.1) t₀ = (fun e => B e.1)
            then ∏ p ∈ t₀, y p.1 else 0 := by
    intro B hB
    have hiffB : ∀ t₀ : Finset ↥Λ,
        (bdL (toInd plaqF) (t₀.map (Function.Embedding.subtype _)) = B
          ↔ bd (fun (p : ↥Λ) (e : ↥(linksOf plaqF Λ)) => toInd plaqF p.1 e.1) t₀ = fun e => B e.1) := by
      intro t₀
      constructor
      · intro h
        funext e
        rw [hbd, h]
      · intro h
        funext e
        by_cases he : e ∈ linksOf plaqF Λ
        · have := congrFun h ⟨e, he⟩
          rw [hbd] at this
          exact this
        · rw [bdL_subset_links plaqF (hmem t₀) e he]
          by_contra hc
          have : B e = true := by
            rcases Bool.eq_false_or_eq_true (B e) with h1 | h1
            · exact h1
            · exact absurd h1.symm hc
          exact he (hB e this)
    refine Finset.sum_bij' (fun t _ => t.subtype (· ∈ Λ)) (fun t₀ _ => t₀.map (Function.Embedding.subtype _))
      (fun t _ => Finset.mem_powerset.mpr (Finset.subset_univ _))
      (fun t₀ _ => Finset.mem_powerset.mpr (hmem t₀)) (fun t ht => hleft t ht) (fun t₀ _ => hright t₀) ?_
    intro t ht
    have hb := hiffB (t.subtype (· ∈ Λ))
    rw [hleft t ht] at hb
    by_cases h : bdL (toInd plaqF) t = B
    · rw [if_pos h, if_pos (hb.mp h), hprod t ht]
    · rw [if_neg h, if_neg (fun h' => h (hb.mpr h'))]
  rw [key A hA, key (fun _ => false) (fun e he => absurd he Bool.false_ne_true)]

/-- the box expectation is nonnegative: every term of both sums is, and the denominator's empty term is one -/
theorem WcL_nonneg (plaq : P → E → Bool) (y : P → ℝ) (hy0 : ∀ p, 0 ≤ y p) (Λ : Finset P) (A : E → Bool) :
    0 ≤ WcL plaq y Λ A := by
  classical
  unfold WcL
  apply div_nonneg
  · apply Finset.sum_nonneg
    intro t _
    split_ifs
    · exact Finset.prod_nonneg (fun p _ => hy0 p)
    · exact le_rfl
  · apply Finset.sum_nonneg
    intro t _
    split_ifs
    · exact Finset.prod_nonneg (fun p _ => hy0 p)
    · exact le_rfl

/-- THE BRIDGE TO THE EXPECTATION: the box expectation is the finite model's configuration expectation -/
theorem WcL_eq_expect (plaqF : P → Finset E) (y : P → ℝ) (Λ : Finset P) (A : E → Bool)
    (hA : ∀ e, A e = true → e ∈ linksOf plaqF Λ) :
    WcL (toInd plaqF) y Λ A
      = expect (fun (p : ↥Λ) (e : ↥(linksOf plaqF Λ)) => toInd plaqF p.1 e.1) (fun p => y p.1) (fun e => A e.1) := by
  rw [expect_eq_Wc]
  exact WcL_eq_Wc plaqF y Λ A hA

/-- the box expectation is at most one (through the bridge: it is a configuration expectation) -/
theorem WcL_le_one (plaqF : P → Finset E) (y : P → ℝ) (hy0 : ∀ p, 0 ≤ y p) (hy1 : ∀ p, y p ≤ 1)
    (Λ : Finset P) (A : E → Bool) : WcL (toInd plaqF) y Λ A ≤ 1 := by
  by_cases hA : ∀ e, A e = true → e ∈ linksOf plaqF Λ
  · rw [WcL_eq_expect plaqF y Λ A hA]
    exact expect_le_one (fun (p : ↥Λ) (e : ↥(linksOf plaqF Λ)) => toInd plaqF p.1 e.1) (fun p => y p.1)
      (fun (p : ↥Λ) => hy0 p.1) (fun (p : ↥Λ) => hy1 p.1) (fun e => A e.1)
  · rw [WcL_eq_zero_of_not_subset plaqF y Λ A hA]
    exact zero_le_one

theorem linksOf_mono (plaqF : P → Finset E) {Λ Λ' : Finset P} (h : Λ ⊆ Λ') :
    linksOf plaqF Λ ⊆ linksOf plaqF Λ' := Finset.biUnion_subset_biUnion_of_subset_left _ h

/-- THE MONOTONICITY IN THE BOX: a loop inside a box has a larger expectation in every larger box -/
theorem WcL_mono_box (plaqF : P → Finset E) (y : P → ℝ) (hy0 : ∀ p, 0 ≤ y p) (hy1 : ∀ p, y p ≤ 1)
    {Λ Λ' : Finset P} (h : Λ ⊆ Λ') (A : E → Bool) (hA : ∀ e, A e = true → e ∈ linksOf plaqF Λ) :
    WcL (toInd plaqF) y Λ A ≤ WcL (toInd plaqF) y Λ' A := by
  have hA' : ∀ e, A e = true → e ∈ linksOf plaqF Λ' := fun e he => linksOf_mono plaqF h (hA e he)
  have h1 : WcL (toInd plaqF) y Λ A = WcL (toInd plaqF) (cut y Λ) Λ' A := by
    rw [WcL_restrict (toInd plaqF) (cut y Λ) h (cut_zero_outside y Λ) A, WcL_cut]
  have h2 := WcL_eq_expect plaqF (cut y Λ) Λ' A hA'
  have h3 := WcL_eq_expect plaqF y Λ' A hA'
  have h4 := expect_mono (fun (p : ↥Λ') (e : ↥(linksOf plaqF Λ')) => toInd plaqF p.1 e.1)
    (fun (p : ↥Λ') => cut y Λ p.1) (fun (p : ↥Λ') => y p.1) (fun (p : ↥Λ') => cut_nonneg y hy0 Λ p.1)
    (fun (p : ↥Λ') => cut_le y hy0 Λ p.1) (fun (p : ↥Λ') => hy1 p.1) (fun e => A e.1)
  rw [h1, h2, h3]
  exact h4

/-- THE INFINITE-VOLUME WILSON EXPECTATION: the supremum over every finite box -/
noncomputable def Winf (plaqF : P → Finset E) (y : P → ℝ) (A : E → Bool) : ℝ :=
  ⨆ Λ : Finset P, WcL (toInd plaqF) y Λ A

theorem bddAbove_WcL (plaqF : P → Finset E) (y : P → ℝ) (hy0 : ∀ p, 0 ≤ y p) (hy1 : ∀ p, y p ≤ 1)
    (A : E → Bool) : BddAbove (Set.range fun Λ : Finset P => WcL (toInd plaqF) y Λ A) := by
  refine ⟨1, ?_⟩
  rintro _ ⟨Λ, rfl⟩
  exact WcL_le_one plaqF y hy0 hy1 Λ A

theorem WcL_le_Winf (plaqF : P → Finset E) (y : P → ℝ) (hy0 : ∀ p, 0 ≤ y p) (hy1 : ∀ p, y p ≤ 1)
    (Λ : Finset P) (A : E → Bool) : WcL (toInd plaqF) y Λ A ≤ Winf plaqF y A :=
  le_ciSup (bddAbove_WcL plaqF y hy0 hy1 A) Λ

/-- THE INFINITE-VOLUME LIMIT EXISTS: along every exhausting nondecreasing sequence of boxes the Wilson
expectation converges, to the supremum over all boxes -- Mechanism S, first half -/
theorem Winf_tendsto (plaqF : P → Finset E) (y : P → ℝ) (hy0 : ∀ p, 0 ≤ y p) (hy1 : ∀ p, y p ≤ 1)
    (Λ : ℕ → Finset P) (hmono : Monotone Λ) (hex : ∀ S : Finset P, ∃ n, S ⊆ Λ n) (A : E → Bool)
    (hA : ∀ e, A e = true → e ∈ linksOf plaqF (Λ 0)) :
    Tendsto (fun n => WcL (toInd plaqF) y (Λ n) A) atTop (𝓝 (Winf plaqF y A)) := by
  have hAn : ∀ n, ∀ e, A e = true → e ∈ linksOf plaqF (Λ n) :=
    fun n e he => linksOf_mono plaqF (hmono (Nat.zero_le n)) (hA e he)
  have hm : Monotone (fun n => WcL (toInd plaqF) y (Λ n) A) :=
    fun m n hmn => WcL_mono_box plaqF y hy0 hy1 (hmono hmn) A (hAn m)
  have hb : BddAbove (Set.range fun n => WcL (toInd plaqF) y (Λ n) A) := by
    refine ⟨1, ?_⟩
    rintro _ ⟨n, rfl⟩
    exact WcL_le_one plaqF y hy0 hy1 (Λ n) A
  have hlim := tendsto_atTop_ciSup hm hb
  have hsup : (⨆ n, WcL (toInd plaqF) y (Λ n) A) = Winf plaqF y A := by
    apply le_antisymm
    · exact ciSup_le (fun n => WcL_le_Winf plaqF y hy0 hy1 (Λ n) A)
    · apply ciSup_le
      intro S
      by_cases hS : ∀ e, A e = true → e ∈ linksOf plaqF S
      · obtain ⟨n, hn⟩ := hex S
        exact le_trans (WcL_mono_box plaqF y hy0 hy1 hn A hS) (le_ciSup hb n)
      · rw [WcL_eq_zero_of_not_subset plaqF y S A hS]
        exact le_trans (WcL_nonneg _ y hy0 (Λ 0) A) (le_ciSup hb 0)
  rw [hsup] at hlim
  exact hlim

/-- the boundary of an inserted plaquette: the plaquette's links xor the old boundary -/
theorem bdL_insert (plaq : P → E → Bool) (p : P) (t : Finset P) (hp : p ∉ t) :
    bdL plaq (insert p t) = fun e => xor (plaq p e) (bdL plaq t e) := by
  funext e
  simp only [bdL]
  by_cases h : plaq p e = true
  · have hp' : p ∉ t.filter (fun q => plaq q e = true) := fun h' => hp (Finset.mem_filter.mp h').1
    rw [Finset.filter_insert, if_pos h, Finset.card_insert_of_notMem hp', h, Bool.true_xor, ← decide_not,
      decide_eq_decide]
    exact Nat.odd_add_one
  · rw [Finset.filter_insert, if_neg h]
    simp [h]

/-- the boundary of a disjoint union is the xor of the boundaries -/
theorem bdL_union (plaq : P → E → Bool) (s t : Finset P) (hst : Disjoint s t) :
    bdL plaq (s ∪ t) = fun e => xor (bdL plaq s e) (bdL plaq t e) := by
  induction t using Finset.induction_on with
  | empty =>
    funext e
    simp [bdL]
  | @insert p t hp ih =>
    have hps : p ∉ s := fun h => Finset.disjoint_left.mp hst h (Finset.mem_insert_self p t)
    have hst' : Disjoint s t := Finset.disjoint_of_subset_right (Finset.subset_insert p t) hst
    have hpu : p ∉ s ∪ t := by
      rw [Finset.mem_union]; push Not; exact ⟨hps, hp⟩
    rw [Finset.union_insert, bdL_insert plaq p (s ∪ t) hpu, ih hst', bdL_insert plaq p t hp]
    funext e
    rcases Bool.eq_false_or_eq_true (plaq p e) with h1 | h1 <;>
      rcases Bool.eq_false_or_eq_true (bdL plaq s e) with h2 | h2 <;>
      rcases Bool.eq_false_or_eq_true (bdL plaq t e) with h3 | h3 <;> simp [h1, h2, h3]

/-- the support of an xor lies in the union of the supports -/
theorem xor_support {A B : E → Bool} {S : Finset E} (hA : ∀ e, A e = true → e ∈ S) (hB : ∀ e, B e = true → e ∈ S) :
    ∀ e, xor (A e) (B e) = true → e ∈ S := by
  intro e he
  rcases Bool.eq_false_or_eq_true (A e) with h1 | h1
  · exact hA e h1
  · rcases Bool.eq_false_or_eq_true (B e) with h2 | h2
    · exact hB e h2
    · rw [h1, h2] at he; exact absurd he (by decide)

/-- GRIFFITHS II IN THE LIMIT: W_∞(A) W_∞(B) ≤ W_∞(A ⊕ B) -/
theorem Winf_mul_le (plaqF : P → Finset E) (y : P → ℝ) (hy0 : ∀ p, 0 ≤ y p) (hy1 : ∀ p, y p ≤ 1)
    (Λ : ℕ → Finset P) (hmono : Monotone Λ) (hex : ∀ S : Finset P, ∃ n, S ⊆ Λ n) (A B : E → Bool)
    (hA : ∀ e, A e = true → e ∈ linksOf plaqF (Λ 0)) (hB : ∀ e, B e = true → e ∈ linksOf plaqF (Λ 0)) :
    Winf plaqF y A * Winf plaqF y B ≤ Winf plaqF y (fun e => xor (A e) (B e)) := by
  have hAB : ∀ e, xor (A e) (B e) = true → e ∈ linksOf plaqF (Λ 0) := xor_support hA hB
  have ta := Winf_tendsto plaqF y hy0 hy1 Λ hmono hex A hA
  have tb := Winf_tendsto plaqF y hy0 hy1 Λ hmono hex B hB
  have tab := Winf_tendsto plaqF y hy0 hy1 Λ hmono hex _ hAB
  refine le_of_tendsto_of_tendsto' (ta.mul tb) tab (fun n => ?_)
  have hAn : ∀ e, A e = true → e ∈ linksOf plaqF (Λ n) :=
    fun e he => linksOf_mono plaqF (hmono (Nat.zero_le n)) (hA e he)
  have hBn : ∀ e, B e = true → e ∈ linksOf plaqF (Λ n) :=
    fun e he => linksOf_mono plaqF (hmono (Nat.zero_le n)) (hB e he)
  have hABn : ∀ e, xor (A e) (B e) = true → e ∈ linksOf plaqF (Λ n) := xor_support hAn hBn
  rw [WcL_eq_expect plaqF y (Λ n) A hAn, WcL_eq_expect plaqF y (Λ n) B hBn,
    WcL_eq_expect plaqF y (Λ n) (fun e => xor (A e) (B e)) hABn]
  exact griffiths_two_expect (fun (p : ↥(Λ n)) (e : ↥(linksOf plaqF (Λ n))) => toInd plaqF p.1 e.1)
    (fun (p : ↥(Λ n)) => y p.1) (fun (p : ↥(Λ n)) => hy0 p.1) (fun (p : ↥(Λ n)) => hy1 p.1)
    (fun e => A e.1) (fun e => B e.1)

end Aperanton
