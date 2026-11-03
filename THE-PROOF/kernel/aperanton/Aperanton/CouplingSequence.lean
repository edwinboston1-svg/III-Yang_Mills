import Mathlib

/-!
# CouplingSequence.lean -- Σ1b's EASY HALF: BAŁABAN'S THEOREM 2 FROM ITS ONE-STEP BOUND

Bałaban's ultraviolet stability theorem for four-dimensional lattice Yang–Mills (CMP 122 (1989), p. 355, Theorem 1) holds
under the hypothesis that the effective couplings stay in ]0, γ] at every scale; the theorem that discharges it, Theorem 2
of CMP 109, was never published, and it is a theorem of the proof this tree is writing (build Σ1b).  Its hard half is the
one-step inequality in Bałaban's scheme (the one-loop coefficient per step and the higher-order remainder); this file is the
easy half: THE ONE-STEP BOUND IMPLIES THE SEQUENCE STATEMENT.

Bałaban's statement (CMP 109, p. 259): "Let d = 4, G = SU(2), and let γ be a sufficiently small positive constant, then for
a sufficiently small positive g there exists a bare coupling constant g₀ = g₀(ε, g) such that the sequence of the effective
coupling constants g_k is contained in the interval ]0, γ], and g_K = g. Moreover, there exist constants β, β′, 0 < β ≤ β′,
such that g_k satisfy the inequality 1/g² + β log(L^k ε)^{−1} ≤ 1/g_k² ≤ 1/g² + β′ log(L^k ε)^{−1}. (0.31)"

Conventions, from his page.  k = 0 is the bare lattice of spacing ε, k = K = log_L(1/ε) the unit lattice, x_k = 1/g_k², so
log(L^k ε)^{−1} = (K − k) log L and a step LOWERS x (the coupling grows toward coarse scales): x_{k+1} = x_k − b_{k+1}.  The
shift b_{k+1} is a continuous function of the whole sequence (his β_{j+1}(g_j) is extracted from the j-th step's output,
(0.28), which reads the history through the effective action); its bound c₁ ≤ b ≤ c₂, c₁ > 0 -- in his units
c₁ = β log L, c₂ = β′ log L -- is assumed where EVERY entry is at least X_min = 1/γ², which the causal form implies (the
shift reads only the prefix; the entries beyond the current step are the filler x₀ here).  That one-step bound, with the
shift's continuity in the history, is the HARD HALF of Σ1b (the one-loop coefficient per step and the higher-order remainder).

The theorem (`theorem_two`): for every target X = 1/g² ≥ X_min and every number of steps K there is a bare x₀ in
[X + K c₁, X + K c₂] whose flow ends at x_K = X and satisfies (0.31) at every step,
X + (K − j) c₁ ≤ x_j ≤ X + (K − j) c₂ -- hence the whole sequence in the window ]0, γ] -- and the bare coupling vanishes as
the cutoff is removed (`bare_coupling_tendsto`): ASYMPTOTIC FREEDOM is (0.31) at j = 0.
The proof: replace each argument by its max with X_min (the truncation keeps continuity and makes the bound global), so the
truncated flow is continuous in x₀ and falls by c₁ to c₂ per step; the intermediate value theorem on x₀ gives x_K = X;
monotonicity puts every x_j ≥ X ≥ X_min, where the truncation is inactive, so the true flow is the truncated one.

The standing falsifiers.  U(1) has zero one-loop coefficient: with no running (`no_running`, b ≡ 0) the flow is constant,
x_K = x₀, the bare coupling equals the renormalised one at every cutoff and c₁ > 0 fails -- the chain separates the groups
exactly here.  The free massless field has no coupling to run.  No sorry, no axiom, no native_decide.
-/

namespace CouplingSequence

/-- the state after k steps: entries 0..k are x_0..x_k, the later entries are the filler x₀ -/
noncomputable def seq (b : ℕ → (ℕ → ℝ) → ℝ) (x₀ : ℝ) : ℕ → (ℕ → ℝ)
  | 0 => fun _ => x₀
  | k + 1 => Function.update (seq b x₀ k) (k + 1) (seq b x₀ k k - b (k + 1) (seq b x₀ k))

/-- the coupling variable x_k = 1/g_k² -/
noncomputable def val (b : ℕ → (ℕ → ℝ) → ℝ) (x₀ : ℝ) (k : ℕ) : ℝ := seq b x₀ k k

theorem val_zero (b : ℕ → (ℕ → ℝ) → ℝ) (x₀ : ℝ) : val b x₀ 0 = x₀ := rfl

/-- one step lowers x by the shift read from the history -/
theorem val_succ (b : ℕ → (ℕ → ℝ) → ℝ) (x₀ : ℝ) (k : ℕ) :
    val b x₀ (k + 1) = val b x₀ k - b (k + 1) (seq b x₀ k) := by
  simp only [val, seq, Function.update_self]

/-- the entries already written are frozen -/
theorem seq_frozen (b : ℕ → (ℕ → ℝ) → ℝ) (x₀ : ℝ) : ∀ k j, j ≤ k → seq b x₀ k j = val b x₀ j := by
  intro k
  induction k with
  | zero =>
    intro j hj
    have hj0 : j = 0 := by omega
    subst hj0
    rfl
  | succ k ih =>
    intro j hj
    rcases Nat.lt_or_ge j (k + 1) with h | h
    · have hne : j ≠ k + 1 := by omega
      simp only [seq, Function.update_of_ne hne]
      exact ih j (by omega)
    · have hjk : j = k + 1 := by omega
      subst hjk
      rfl

/-- the filler beyond the written entries is x₀ -/
theorem seq_filler (b : ℕ → (ℕ → ℝ) → ℝ) (x₀ : ℝ) : ∀ k j, k < j → seq b x₀ k j = x₀ := by
  intro k
  induction k with
  | zero => intro j _; rfl
  | succ k ih =>
    intro j hj
    have hne : j ≠ k + 1 := by omega
    simp only [seq, Function.update_of_ne hne]
    exact ih j (by omega)

/-- the state is continuous in the bare value -/
theorem seq_continuous (b : ℕ → (ℕ → ℝ) → ℝ) (hb : ∀ k, Continuous (b k)) (k : ℕ) :
    Continuous (fun x₀ => seq b x₀ k) := by
  induction k with
  | zero => exact continuous_pi fun _ => continuous_id
  | succ k ih =>
    simp only [seq]
    exact ih.update (k + 1) (((continuous_apply k).comp ih).sub ((hb (k + 1)).comp ih))

theorem val_continuous (b : ℕ → (ℕ → ℝ) → ℝ) (hb : ∀ k, Continuous (b k)) (k : ℕ) :
    Continuous (fun x₀ => val b x₀ k) :=
  (continuous_apply k).comp (seq_continuous b hb k)

/-- the truncation: every argument replaced by its max with X_min -/
noncomputable def trunc (b : ℕ → (ℕ → ℝ) → ℝ) (Xmin : ℝ) : ℕ → (ℕ → ℝ) → ℝ :=
  fun k s => b k (fun j => max (s j) Xmin)

theorem trunc_continuous (b : ℕ → (ℕ → ℝ) → ℝ) (hb : ∀ k, Continuous (b k)) (Xmin : ℝ) (k : ℕ) :
    Continuous (trunc b Xmin k) := by
  unfold trunc
  exact (hb k).comp (continuous_pi fun j => (continuous_apply j).max continuous_const)

/-- the truncated shift obeys the bound everywhere -/
theorem trunc_bounds (b : ℕ → (ℕ → ℝ) → ℝ) (Xmin c₁ c₂ : ℝ)
    (hbd : ∀ k s, (∀ j, Xmin ≤ s j) → c₁ ≤ b k s ∧ b k s ≤ c₂) (k : ℕ) (s : ℕ → ℝ) :
    c₁ ≤ trunc b Xmin k s ∧ trunc b Xmin k s ≤ c₂ :=
  hbd k (fun j => max (s j) Xmin) (fun j => le_max_right (s j) Xmin)

/-- the truncation is inactive where every entry is at least X_min -/
theorem trunc_eq (b : ℕ → (ℕ → ℝ) → ℝ) (Xmin : ℝ) (k : ℕ) (s : ℕ → ℝ) (hs : ∀ j, Xmin ≤ s j) :
    trunc b Xmin k s = b k s := by
  unfold trunc
  congr 1
  funext j
  exact max_eq_left (hs j)

/-- one step of a globally bounded flow falls by c₁ to c₂ -/
theorem val_step (b : ℕ → (ℕ → ℝ) → ℝ) (c₁ c₂ : ℝ) (hbd : ∀ k s, c₁ ≤ b k s ∧ b k s ≤ c₂) (x₀ : ℝ) (k : ℕ) :
    val b x₀ k - c₂ ≤ val b x₀ (k + 1) ∧ val b x₀ (k + 1) ≤ val b x₀ k - c₁ := by
  rw [val_succ]
  have h := hbd (k + 1) (seq b x₀ k)
  constructor <;> linarith [h.1, h.2]

/-- after k steps a globally bounded flow lies in [x₀ − k c₂, x₀ − k c₁] -/
theorem val_bounds (b : ℕ → (ℕ → ℝ) → ℝ) (c₁ c₂ : ℝ) (hbd : ∀ k s, c₁ ≤ b k s ∧ b k s ≤ c₂) (x₀ : ℝ) (k : ℕ) :
    x₀ - k * c₂ ≤ val b x₀ k ∧ val b x₀ k ≤ x₀ - k * c₁ := by
  induction k with
  | zero => simp [val_zero]
  | succ k ih =>
    have h := val_step b c₁ c₂ hbd x₀ k
    push_cast
    constructor <;> linarith [ih.1, ih.2, h.1, h.2]

/-- m steps of a globally bounded flow fall by m c₁ to m c₂ -/
theorem val_gap (b : ℕ → (ℕ → ℝ) → ℝ) (c₁ c₂ : ℝ) (hbd : ∀ k s, c₁ ≤ b k s ∧ b k s ≤ c₂) (x₀ : ℝ) (k m : ℕ) :
    val b x₀ k - m * c₂ ≤ val b x₀ (k + m) ∧ val b x₀ (k + m) ≤ val b x₀ k - m * c₁ := by
  induction m with
  | zero => simp
  | succ m ih =>
    have h := val_step b c₁ c₂ hbd x₀ (k + m)
    rw [show k + (m + 1) = k + m + 1 by ring]
    push_cast
    constructor <;> linarith [ih.1, ih.2, h.1, h.2]

/-- a flow falling by at least c₁ ≥ 0 per step is antitone -/
theorem val_antitone (b : ℕ → (ℕ → ℝ) → ℝ) (c₁ c₂ : ℝ) (hc₁ : 0 ≤ c₁) (hbd : ∀ k s, c₁ ≤ b k s ∧ b k s ≤ c₂)
    (x₀ : ℝ) : Antitone (val b x₀) :=
  antitone_nat_of_succ_le fun n => by
    have h := val_step b c₁ c₂ hbd x₀ n
    linarith [h.2]

/-- while every entry of the truncated state stays at least X_min, the true flow is the truncated one -/
theorem seq_eq_trunc (b : ℕ → (ℕ → ℝ) → ℝ) (Xmin x₀ : ℝ) (K : ℕ)
    (hall : ∀ k ≤ K, ∀ j, Xmin ≤ seq (trunc b Xmin) x₀ k j) :
    ∀ k ≤ K, seq b x₀ k = seq (trunc b Xmin) x₀ k := by
  intro k
  induction k with
  | zero => intro _; rfl
  | succ k ih =>
    intro hk
    have ih' := ih (by omega)
    simp only [seq]
    rw [ih', trunc_eq b Xmin (k + 1) _ (hall k (by omega))]

/-- Σ1b's EASY HALF -- BAŁABAN'S THEOREM 2 FROM THE ONE-STEP BOUND: for every target X ≥ X_min and every number of steps K
there is a bare x₀ in [X + K c₁, X + K c₂] whose flow ends at x_K = X and obeys (0.31) at every step,
X + (K − j) c₁ ≤ x_j ≤ X + (K − j) c₂ -/
theorem theorem_two (b : ℕ → (ℕ → ℝ) → ℝ) (hb : ∀ k, Continuous (b k)) (Xmin c₁ c₂ : ℝ) (hc₁ : 0 < c₁)
    (hc : c₁ ≤ c₂) (hbd : ∀ k s, (∀ j, Xmin ≤ s j) → c₁ ≤ b k s ∧ b k s ≤ c₂) (K : ℕ) (X : ℝ) (hX : Xmin ≤ X) :
    ∃ x₀, X + K * c₁ ≤ x₀ ∧ x₀ ≤ X + K * c₂ ∧ val b x₀ K = X ∧
      ∀ j ≤ K, X + ((K - j : ℕ) : ℝ) * c₁ ≤ val b x₀ j ∧ val b x₀ j ≤ X + ((K - j : ℕ) : ℝ) * c₂ := by
  have htc : ∀ k, Continuous (trunc b Xmin k) := trunc_continuous b hb Xmin
  have htbd : ∀ k s, c₁ ≤ trunc b Xmin k s ∧ trunc b Xmin k s ≤ c₂ := trunc_bounds b Xmin c₁ c₂ hbd
  have hK : (0 : ℝ) ≤ (K : ℝ) := Nat.cast_nonneg K
  have hab : X + K * c₁ ≤ X + K * c₂ := by
    have := mul_le_mul_of_nonneg_left hc hK
    linarith
  have hcont : ContinuousOn (fun x₀ => val (trunc b Xmin) x₀ K) (Set.Icc (X + K * c₁) (X + K * c₂)) :=
    (val_continuous (trunc b Xmin) htc K).continuousOn
  have hlo : val (trunc b Xmin) (X + K * c₁) K ≤ X := by
    have := (val_bounds (trunc b Xmin) c₁ c₂ htbd (X + K * c₁) K).2
    linarith
  have hhi : X ≤ val (trunc b Xmin) (X + K * c₂) K := by
    have := (val_bounds (trunc b Xmin) c₁ c₂ htbd (X + K * c₂) K).1
    linarith
  obtain ⟨x₀, hx₀, hval⟩ := intermediate_value_Icc hab hcont ⟨hlo, hhi⟩
  have hvalK : val (trunc b Xmin) x₀ K = X := hval
  have hanti := val_antitone (trunc b Xmin) c₁ c₂ hc₁.le htbd x₀
  have hKc : (0 : ℝ) ≤ (K : ℝ) * c₁ := mul_nonneg hK hc₁.le
  have hx₀X : X ≤ x₀ := by
    have := hx₀.1
    linarith
  have hentries : ∀ k ≤ K, ∀ j, Xmin ≤ seq (trunc b Xmin) x₀ k j := by
    intro k hk j
    rcases Nat.lt_or_ge k j with h | h
    · rw [seq_filler (trunc b Xmin) x₀ k j h]
      linarith
    · rw [seq_frozen (trunc b Xmin) x₀ k j h]
      have hle : val (trunc b Xmin) x₀ K ≤ val (trunc b Xmin) x₀ j := hanti (by omega)
      linarith
  have heq := seq_eq_trunc b Xmin x₀ K hentries
  refine ⟨x₀, hx₀.1, hx₀.2, ?_, ?_⟩
  · have hK' : seq b x₀ K K = seq (trunc b Xmin) x₀ K K := congrFun (heq K le_rfl) K
    show seq b x₀ K K = X
    rw [hK']
    exact hvalK
  · intro j hj
    have hj' : seq b x₀ j j = seq (trunc b Xmin) x₀ j j := congrFun (heq j hj) j
    have hg := val_gap (trunc b Xmin) c₁ c₂ htbd x₀ j (K - j)
    rw [show j + (K - j) = K by omega, hvalK] at hg
    show X + ((K - j : ℕ) : ℝ) * c₁ ≤ seq b x₀ j j ∧ seq b x₀ j j ≤ X + ((K - j : ℕ) : ℝ) * c₂
    rw [hj']
    have hv : val (trunc b Xmin) x₀ j = seq (trunc b Xmin) x₀ j j := rfl
    constructor <;> linarith [hg.1, hg.2]

/-- the window: every coupling of the sequence is at most γ, i.e. every x_j is at least X_min -/
theorem in_window (b : ℕ → (ℕ → ℝ) → ℝ) (hb : ∀ k, Continuous (b k)) (Xmin c₁ c₂ : ℝ) (hc₁ : 0 < c₁)
    (hc : c₁ ≤ c₂) (hbd : ∀ k s, (∀ j, Xmin ≤ s j) → c₁ ≤ b k s ∧ b k s ≤ c₂) (K : ℕ) (X : ℝ) (hX : Xmin ≤ X) :
    ∃ x₀, val b x₀ K = X ∧ ∀ j ≤ K, Xmin ≤ val b x₀ j := by
  obtain ⟨x₀, _, _, hK, hprof⟩ := theorem_two b hb Xmin c₁ c₂ hc₁ hc hbd K X hX
  refine ⟨x₀, hK, fun j hj => ?_⟩
  have h := (hprof j hj).1
  have hm : (0 : ℝ) ≤ ((K - j : ℕ) : ℝ) * c₁ := mul_nonneg (Nat.cast_nonneg _) hc₁.le
  linarith

/-- the bare coupling squared, 1/x₀, is at most 1/(X + K c₁) -/
theorem bare_coupling_le (X c₁ x₀ : ℝ) (K : ℕ) (hX : 0 < X) (hc₁ : 0 < c₁) (h : X + K * c₁ ≤ x₀) :
    1 / x₀ ≤ 1 / (X + K * c₁) := by
  have hKc : (0 : ℝ) ≤ (K : ℝ) * c₁ := mul_nonneg (Nat.cast_nonneg K) hc₁.le
  have hpos : 0 < X + K * c₁ := by linarith
  exact one_div_le_one_div_of_le hpos h

/-- ASYMPTOTIC FREEDOM, the second clause: the bound on the bare coupling squared vanishes as the number of steps grows -/
theorem bare_coupling_tendsto (X c₁ : ℝ) (hX : 0 < X) (hc₁ : 0 < c₁) :
    Filter.Tendsto (fun K : ℕ => (X + K * c₁)⁻¹) Filter.atTop (nhds 0) := by
  have h1 : Filter.Tendsto (fun K : ℕ => (K : ℝ) * c₁) Filter.atTop Filter.atTop :=
    Filter.Tendsto.atTop_mul_const hc₁ tendsto_natCast_atTop_atTop
  have h2 : Filter.Tendsto (fun K : ℕ => X + (K : ℝ) * c₁) Filter.atTop Filter.atTop :=
    Filter.tendsto_atTop_mono (fun K => by linarith) h1
  exact tendsto_inv_atTop_zero.comp h2

/-- THE U(1) LINE: with no running the flow is constant -- the bare coupling equals the renormalised one at every cutoff -/
theorem no_running (x₀ : ℝ) (K : ℕ) : val (fun _ _ => 0) x₀ K = x₀ := by
  induction K with
  | zero => rfl
  | succ k ih => simp [val_succ, ih]

end CouplingSequence
