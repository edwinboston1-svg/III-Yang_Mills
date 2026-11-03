import Mathlib
import Aperanton.CouplingSequence

/-!
# CouplingTransient.lean -- Σ1b's WINDOW FROM A BOUNDED TRANSIENT: NO STEP NEEDS A SIGN

CouplingSequence.lean proves Bałaban's Theorem 2 (CMP 109, p. 259) from a one-step bound c₁ ≤ b ≤ c₂ with c₁ > 0: every
renormalisation step must lower x = 1/g² by a positive amount.  The constrained instrument (the ledger's §100) read the
one-loop transient of the first step NEGATIVE in a scheme as natural as any (S_loop, corner anchor, block 3: δ₀ ≈ −0.21), so
per-step positivity is a property of a scheme, not of the theory.  This file removes it.  What Bałaban's Theorem 1 (CMP 122,
p. 355) consumes is the WINDOW, 0 < g_k ≤ γ at every scale, and the window follows from three things only:

* ASYMPTOTIC FREEDOM, a constant c > 0 (8b₀ log L in Wilson units) that every step's one-loop shift carries on average;
* A BOUNDED TRANSIENT: the one-loop shift of step i is a(i) = c + f(i) − f(i − 1) with |f| ≤ F -- the partial sums of the
  deviations stay bounded, while a single a(i) may have either sign.  By the composition of hard delta functions (§100),
  Σ_{i ≤ k} a(i) = β(Q^k), the one-step coefficient of the k-fold iterated averaging, so f(k) = β(Q^k) − c k is the iterated
  block scheme's matching constant against Wilson's -- bounded exactly when that scheme has a finite Λ-ratio;
* A SMALL REMAINDER: the true shift, a continuous function of the whole history, differs from a(k) by at most ρ ≤ c on the
  window (the higher orders and the large fields, Lemma C: ρ ≤ C₁γ² + C₂e^{−c′/γ²}).

The theorem (`window_of_bounded_transient`): for every target X ≥ X_min + 2F and every number of steps K there is a bare x₀
whose flow ends at x_K = X and satisfies X + (K − j)(c − ρ) − 2F ≤ x_j ≤ X + (K − j)(c + ρ) + 2F at every step j -- hence the
whole sequence in the window.  The proof is CouplingSequence's (the truncation, the intermediate value theorem, the truncation
inactive on the window) with the per-step monotonicity replaced by the telescoped window sum Σ_{i=j+1}^{K} a(i) =
(K − j) c + f(K) − f(j).  The margin 2F is the only price of an unsigned transient.

The falsifiers stand: U(1) has c = 0 (no running), and the profile then gives no window at all once ρ > 0; the free massless
field has no coupling.  No sorry, no axiom, no native_decide.
-/

namespace CouplingTransient

open CouplingSequence

/-- the shift's two-sided bound transported to the truncated flow, where it holds for every history -/
theorem trunc_split (b : ℕ → (ℕ → ℝ) → ℝ) (a : ℕ → ℝ) (Xmin ρ : ℝ)
    (hr : ∀ k s, (∀ j, Xmin ≤ s j) → a k - ρ ≤ b k s ∧ b k s ≤ a k + ρ) (k : ℕ) (s : ℕ → ℝ) :
    a k - ρ ≤ trunc b Xmin k s ∧ trunc b Xmin k s ≤ a k + ρ :=
  hr k (fun j => max (s j) Xmin) (fun j => le_max_right (s j) Xmin)

/-- m steps of a flow whose k-th shift is a(k) ± ρ: x_{k+m} = x_k − Σ_{i<m} a(k+1+i) ± m ρ -/
theorem val_window (b : ℕ → (ℕ → ℝ) → ℝ) (a : ℕ → ℝ) (ρ : ℝ) (hr : ∀ k s, a k - ρ ≤ b k s ∧ b k s ≤ a k + ρ)
    (x₀ : ℝ) (k m : ℕ) :
    val b x₀ k - ∑ i ∈ Finset.range m, a (k + 1 + i) - m * ρ ≤ val b x₀ (k + m) ∧
      val b x₀ (k + m) ≤ val b x₀ k - ∑ i ∈ Finset.range m, a (k + 1 + i) + m * ρ := by
  induction m with
  | zero => simp
  | succ m ih =>
    have h := hr (k + m + 1) (seq b x₀ (k + m))
    rw [show k + (m + 1) = k + m + 1 by ring, val_succ, Finset.sum_range_succ,
      show k + 1 + m = k + m + 1 by ring]
    push_cast
    constructor <;> linarith [ih.1, ih.2, h.1, h.2]

/-- THE TELESCOPED WINDOW SUM: with a(i+1) = c + f(i+1) − f(i), Σ_{i<m} a(k+1+i) = m c + f(k+m) − f(k) -/
theorem window_sum (a f : ℕ → ℝ) (c : ℝ) (ha : ∀ i, a (i + 1) = c + f (i + 1) - f i) (k m : ℕ) :
    ∑ i ∈ Finset.range m, a (k + 1 + i) = m * c + f (k + m) - f k := by
  induction m with
  | zero => simp
  | succ m ih =>
    rw [Finset.sum_range_succ, ih, show k + 1 + m = (k + m) + 1 by ring, ha (k + m),
      show k + (m + 1) = (k + m) + 1 by ring]
    push_cast
    ring

/-- a composite sequence B (the one-step coefficient of the k-fold iterated averaging) gives the transient form with
f(k) = B(k) − c k: its increments are c plus the increments of f -/
theorem transient_of_composite (B : ℕ → ℝ) (c : ℝ) (i : ℕ) :
    B (i + 1) - B i = c + (B (i + 1) - c * ((i + 1 : ℕ) : ℝ)) - (B i - c * (i : ℝ)) := by
  push_cast
  ring

/-- the window sum lies within 2F of (K − j) c when |f| ≤ F -/
theorem window_sum_bounds (a f : ℕ → ℝ) (c F : ℝ) (ha : ∀ i, a (i + 1) = c + f (i + 1) - f i)
    (hf : ∀ i, -F ≤ f i ∧ f i ≤ F) (k m : ℕ) :
    m * c - 2 * F ≤ ∑ i ∈ Finset.range m, a (k + 1 + i) ∧ ∑ i ∈ Finset.range m, a (k + 1 + i) ≤ m * c + 2 * F := by
  rw [window_sum a f c ha k m]
  have h1 := hf (k + m)
  have h2 := hf k
  constructor <;> linarith [h1.1, h1.2, h2.1, h2.2]

/-- Σ1b's WINDOW FROM A BOUNDED TRANSIENT: for every target X ≥ X_min + 2F and every number of steps K there is a bare x₀
whose flow ends at x_K = X with X + (K − j)(c − ρ) − 2F ≤ x_j ≤ X + (K − j)(c + ρ) + 2F at every step -- no step's shift
is assumed positive -/
theorem window_of_bounded_transient (b : ℕ → (ℕ → ℝ) → ℝ) (hb : ∀ k, Continuous (b k)) (a f : ℕ → ℝ)
    (Xmin c ρ F : ℝ) (ha : ∀ i, a (i + 1) = c + f (i + 1) - f i) (hf : ∀ i, -F ≤ f i ∧ f i ≤ F)
    (hρ : 0 ≤ ρ) (hρc : ρ ≤ c) (hr : ∀ k s, (∀ j, Xmin ≤ s j) → a k - ρ ≤ b k s ∧ b k s ≤ a k + ρ)
    (K : ℕ) (X : ℝ) (hXw : Xmin + 2 * F ≤ X) :
    ∃ x₀, val b x₀ K = X ∧ (∀ j ≤ K, X + ((K - j : ℕ) : ℝ) * (c - ρ) - 2 * F ≤ val b x₀ j ∧
      val b x₀ j ≤ X + ((K - j : ℕ) : ℝ) * (c + ρ) + 2 * F) ∧
      ∀ i j, i ≤ j → j ≤ K → val b x₀ j + ((j - i : ℕ) : ℝ) * (c - ρ) - 2 * F ≤ val b x₀ i := by
  have htc : ∀ k, Continuous (trunc b Xmin k) := trunc_continuous b hb Xmin
  have htr : ∀ k s, a k - ρ ≤ trunc b Xmin k s ∧ trunc b Xmin k s ≤ a k + ρ := trunc_split b a Xmin ρ hr
  have hK : (0 : ℝ) ≤ (K : ℝ) := Nat.cast_nonneg K
  set S : ℝ := ∑ i ∈ Finset.range K, a (0 + 1 + i) with hS
  have hKρ : (0 : ℝ) ≤ (K : ℝ) * ρ := mul_nonneg hK hρ
  have hab : X + S - K * ρ ≤ X + S + K * ρ := by linarith
  have hcont : ContinuousOn (fun x₀ => val (trunc b Xmin) x₀ K) (Set.Icc (X + S - K * ρ) (X + S + K * ρ)) :=
    (val_continuous (trunc b Xmin) htc K).continuousOn
  have hw : ∀ x₀ : ℝ, x₀ - S - K * ρ ≤ val (trunc b Xmin) x₀ K ∧ val (trunc b Xmin) x₀ K ≤ x₀ - S + K * ρ := by
    intro x₀
    have h := val_window (trunc b Xmin) a ρ htr x₀ 0 K
    rw [show (0 : ℕ) + K = K by ring, val_zero] at h
    exact ⟨by linarith [h.1], by linarith [h.2]⟩
  have hlo : val (trunc b Xmin) (X + S - K * ρ) K ≤ X := by
    have := (hw (X + S - K * ρ)).2
    linarith
  have hhi : X ≤ val (trunc b Xmin) (X + S + K * ρ) K := by
    have := (hw (X + S + K * ρ)).1
    linarith
  obtain ⟨x₀, _, hval⟩ := intermediate_value_Icc hab hcont ⟨hlo, hhi⟩
  have hvalK : val (trunc b Xmin) x₀ K = X := hval
  -- the profile of the truncated flow, read backward from x_K = X through the telescoped window sum
  have hprofT : ∀ j ≤ K, X + ((K - j : ℕ) : ℝ) * (c - ρ) - 2 * F ≤ val (trunc b Xmin) x₀ j ∧
      val (trunc b Xmin) x₀ j ≤ X + ((K - j : ℕ) : ℝ) * (c + ρ) + 2 * F := by
    intro j hj
    have h := val_window (trunc b Xmin) a ρ htr x₀ j (K - j)
    rw [show j + (K - j) = K by omega, hvalK] at h
    have hs := window_sum_bounds a f c F ha hf j (K - j)
    constructor <;> nlinarith [h.1, h.2, hs.1, hs.2]
  have hentries : ∀ k ≤ K, ∀ j, Xmin ≤ seq (trunc b Xmin) x₀ k j := by
    have hmin : ∀ j ≤ K, Xmin ≤ val (trunc b Xmin) x₀ j := by
      intro j hj
      have h := (hprofT j hj).1
      have hm : (0 : ℝ) ≤ ((K - j : ℕ) : ℝ) * (c - ρ) := mul_nonneg (Nat.cast_nonneg _) (by linarith)
      linarith
    intro k hk j
    rcases Nat.lt_or_ge k j with h | h
    · rw [seq_filler (trunc b Xmin) x₀ k j h]
      have h0 := hmin 0 (Nat.zero_le K)
      rw [val_zero] at h0
      exact h0
    · rw [seq_frozen (trunc b Xmin) x₀ k j h]
      exact hmin j (by omega)
  -- THE CROSS-SCALE COMPARISON of the truncated flow: a finer scale's x is the coarser one's plus (j − i)(c − ρ), less 2F
  have hcrossT : ∀ i j, i ≤ j → j ≤ K → val (trunc b Xmin) x₀ j + ((j - i : ℕ) : ℝ) * (c - ρ) - 2 * F ≤
      val (trunc b Xmin) x₀ i := by
    intro i j hij _
    have h := val_window (trunc b Xmin) a ρ htr x₀ i (j - i)
    rw [show i + (j - i) = j by omega] at h
    have hs := window_sum_bounds a f c F ha hf i (j - i)
    nlinarith [h.1, h.2, hs.1, hs.2]
  have heq := seq_eq_trunc b Xmin x₀ K hentries
  refine ⟨x₀, ?_, ?_, ?_⟩
  · have hK' : seq b x₀ K K = seq (trunc b Xmin) x₀ K K := congrFun (heq K le_rfl) K
    show seq b x₀ K K = X
    rw [hK']
    exact hvalK
  · intro j hj
    have hj' : seq b x₀ j j = seq (trunc b Xmin) x₀ j j := congrFun (heq j hj) j
    show X + ((K - j : ℕ) : ℝ) * (c - ρ) - 2 * F ≤ seq b x₀ j j ∧ seq b x₀ j j ≤ X + ((K - j : ℕ) : ℝ) * (c + ρ) + 2 * F
    rw [hj']
    exact hprofT j hj
  · intro i j hij hjK
    have hi' : seq b x₀ i i = seq (trunc b Xmin) x₀ i i := congrFun (heq i (le_trans hij hjK)) i
    have hj' : seq b x₀ j j = seq (trunc b Xmin) x₀ j j := congrFun (heq j hjK) j
    show seq b x₀ j j + ((j - i : ℕ) : ℝ) * (c - ρ) - 2 * F ≤ seq b x₀ i i
    rw [hi', hj']
    exact hcrossT i j hij hjK

/-- THE CROSS-SCALE CLAUSE THAT LFR II's INDUCTION USES: Bałaban's (1.86) (CMP 122, p. 386) needs the large-field threshold
of an earlier scale to dominate the current one's up to the factor (1 + β₀)⁻¹, p₀(g_i) ≥ (1 + β₀)⁻¹ p₀(g_j) for i ≤ j, with
p₀(g) = A₀ (log g⁻²)^{p₀} (CMP 119, p. 245) -- not a consequence of the window alone.  It follows from x_i ≥ x_j − 2F (the
inverse coupling of a finer scale is at least the coarser one's less 2F), the clause proved here: then log x_i ≥ log x_j −
4F/x_j for x_j ≥ 4F, so the polylogarithmic threshold changes by a factor tending to one as γ → 0 -/
theorem cross_scale_transient (b : ℕ → (ℕ → ℝ) → ℝ) (hb : ∀ k, Continuous (b k)) (a f : ℕ → ℝ)
    (Xmin c ρ F : ℝ) (ha : ∀ i, a (i + 1) = c + f (i + 1) - f i) (hf : ∀ i, -F ≤ f i ∧ f i ≤ F)
    (hρ : 0 ≤ ρ) (hρc : ρ ≤ c) (hr : ∀ k s, (∀ j, Xmin ≤ s j) → a k - ρ ≤ b k s ∧ b k s ≤ a k + ρ)
    (K : ℕ) (X : ℝ) (hX : Xmin + 2 * F ≤ X) :
    ∃ x₀, val b x₀ K = X ∧ ∀ i j, i ≤ j → j ≤ K → val b x₀ j - 2 * F ≤ val b x₀ i := by
  obtain ⟨x₀, hK, _, hcross⟩ := window_of_bounded_transient b hb a f Xmin c ρ F ha hf hρ hρc hr K X hX
  refine ⟨x₀, hK, fun i j hij hjK => ?_⟩
  have h := hcross i j hij hjK
  have hm : (0 : ℝ) ≤ ((j - i : ℕ) : ℝ) * (c - ρ) := mul_nonneg (Nat.cast_nonneg _) (by linarith)
  linarith

/-- the window: every x_j is at least X_min, i.e. every coupling of the sequence is at most γ -/
theorem in_window_transient (b : ℕ → (ℕ → ℝ) → ℝ) (hb : ∀ k, Continuous (b k)) (a f : ℕ → ℝ)
    (Xmin c ρ F : ℝ) (ha : ∀ i, a (i + 1) = c + f (i + 1) - f i) (hf : ∀ i, -F ≤ f i ∧ f i ≤ F)
    (hρ : 0 ≤ ρ) (hρc : ρ ≤ c) (hr : ∀ k s, (∀ j, Xmin ≤ s j) → a k - ρ ≤ b k s ∧ b k s ≤ a k + ρ)
    (K : ℕ) (X : ℝ) (hX : Xmin + 2 * F ≤ X) :
    ∃ x₀, val b x₀ K = X ∧ ∀ j ≤ K, Xmin ≤ val b x₀ j := by
  obtain ⟨x₀, hK, hprof, _⟩ := window_of_bounded_transient b hb a f Xmin c ρ F ha hf hρ hρc hr K X hX
  refine ⟨x₀, hK, fun j hj => ?_⟩
  have h := (hprof j hj).1
  have hm : (0 : ℝ) ≤ ((K - j : ℕ) : ℝ) * (c - ρ) := mul_nonneg (Nat.cast_nonneg _) (by linarith)
  linarith

/-- A NEGATIVE STEP IS ALLOWED: the transient f = (0, −1, 0, 0, ...) with c = 1/2 makes the first one-loop shift negative,
a(1) = 1/2 − 1 = −1/2 < 0, while |f| ≤ 1 -- the hypotheses of the window theorem hold where CouplingSequence's c₁ > 0 fails -/
theorem negative_step_example :
    let f : ℕ → ℝ := fun i => if i = 1 then -1 else 0
    let a : ℕ → ℝ := fun i => if i = 0 then 0 else (1 / 2 : ℝ) + f i - f (i - 1)
    a 1 < 0 ∧ (∀ i, a (i + 1) = 1 / 2 + f (i + 1) - f i) ∧ (∀ i, -1 ≤ f i ∧ f i ≤ 1) := by
  refine ⟨by norm_num, ?_, ?_⟩
  · intro i
    simp only [Nat.add_sub_cancel, Nat.add_eq_zero_iff, one_ne_zero, and_false, if_false]
  · intro i
    by_cases h : i = 1 <;> simp [h]

end CouplingTransient
