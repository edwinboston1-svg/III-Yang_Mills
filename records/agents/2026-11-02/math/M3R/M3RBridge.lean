import Mathlib
import Aperanton.CouplingTransient

/-!
# M3RBridge.lean — second reader's check (scratch only, not part of either repository)

M3's §5.2/§11.2 say that `CouplingTransient.window_of_bounded_transient` cannot be applied to the model of record,
because its hypothesis `hr` asks for the shift's bound at every history `s` (clamped, non-trajectory ones included),
while the model controls the shift only along true trajectories that have stayed in the window; M3 proves a new
Lemma A′ on paper and says the Lean lemma becomes applicable only after an (x, E) extension of Bałaban's construction.

This file shows the existing Lean theorem already gives Lemma A′'s conclusion, with no extension of the model:
read the shift of step k as a function of the state's entry 0 (the bare value x₀), continuous and bounded on the
closed set D k of bare values whose trajectory stayed in the window, extend it off D k by Tietze with the same
bounds, and feed the re-encoded shift `fun k s => g k (s 0)` to `window_of_bounded_transient`; the Lean flow and the
true trajectory then agree step by step, by induction, on the bare value it returns.
-/

open CouplingSequence CouplingTransient Set

namespace M3RBridge

/-- the true trajectory, the shift of step k read as a function of the bare value -/
noncomputable def traj (bt : ℕ → ℝ → ℝ) (x₀ : ℝ) : ℕ → ℝ
  | 0 => x₀
  | k + 1 => traj bt x₀ k - bt (k + 1) x₀

/-- the bare values whose trajectory is in the window at the steps 0, …, k − 1 -/
def D (bt : ℕ → ℝ → ℝ) (Xmin : ℝ) (k : ℕ) : Set ℝ := {x₀ | ∀ j < k, Xmin ≤ traj bt x₀ j}

theorem D_succ (bt : ℕ → ℝ → ℝ) (Xmin : ℝ) (k : ℕ) :
    D bt Xmin (k + 1) = D bt Xmin k ∩ (fun x₀ => traj bt x₀ k) ⁻¹' Ici Xmin := by
  ext x₀
  simp only [D, mem_setOf_eq, mem_inter_iff, mem_preimage, mem_Ici]
  constructor
  · intro h
    exact ⟨fun j hj => h j (by omega), h k (by omega)⟩
  · rintro ⟨h, hk⟩ j hj
    rcases Nat.lt_or_ge j k with hjk | hjk
    · exact h j hjk
    · have : j = k := by omega
      subst this
      exact hk

theorem D_anti (bt : ℕ → ℝ → ℝ) (Xmin : ℝ) {j k : ℕ} (h : j ≤ k) : D bt Xmin k ⊆ D bt Xmin j :=
  fun _ hx i hi => hx i (by omega)

/-- Lemma A′'s closedness step: every D k is closed and the trajectory is continuous on it -/
theorem closed_and_cont (bt : ℕ → ℝ → ℝ) (Xmin : ℝ)
    (h1 : ∀ k, ContinuousOn (bt (k + 1)) (D bt Xmin (k + 1))) :
    ∀ k, IsClosed (D bt Xmin k) ∧ ContinuousOn (fun x₀ => traj bt x₀ k) (D bt Xmin k) := by
  intro k
  induction k with
  | zero =>
    refine ⟨?_, ?_⟩
    · have : D bt Xmin 0 = univ := by
        ext x
        simp [D]
      rw [this]
      exact isClosed_univ
    · show ContinuousOn (fun x₀ => x₀) _
      exact continuous_id.continuousOn
  | succ k ih =>
    obtain ⟨hcl, hco⟩ := ih
    have hcl' : IsClosed (D bt Xmin (k + 1)) := by
      rw [D_succ]
      exact hco.preimage_isClosed_of_isClosed hcl isClosed_Ici
    refine ⟨hcl', ?_⟩
    have hsub : D bt Xmin (k + 1) ⊆ D bt Xmin k := D_anti bt Xmin (Nat.le_succ k)
    show ContinuousOn (fun x₀ => traj bt x₀ k - bt (k + 1) x₀) _
    exact (hco.mono hsub).sub (h1 k)

/-- Tietze: the trajectory shift, continuous and bounded on the closed D (k+1), extends to ℝ with the same bounds -/
theorem extend (bt : ℕ → ℝ → ℝ) (a : ℕ → ℝ) (Xmin ρ : ℝ) (hρ : 0 ≤ ρ)
    (h1 : ∀ k, ContinuousOn (bt (k + 1)) (D bt Xmin (k + 1)))
    (h3 : ∀ k, ∀ x ∈ D bt Xmin (k + 1), a (k + 1) - ρ ≤ bt (k + 1) x ∧ bt (k + 1) x ≤ a (k + 1) + ρ) :
    ∀ k, ∃ g : ℝ → ℝ, Continuous g ∧ (∀ x, a (k + 1) - ρ ≤ g x ∧ g x ≤ a (k + 1) + ρ) ∧
      ∀ x ∈ D bt Xmin (k + 1), g x = bt (k + 1) x := by
  intro k
  have hcl := (closed_and_cont bt Xmin h1 (k + 1)).1
  let fc : C(D bt Xmin (k + 1), ℝ) := ⟨(D bt Xmin (k + 1)).restrict (bt (k + 1)), (h1 k).restrict⟩
  have hft : ∀ x, fc x ∈ Icc (a (k + 1) - ρ) (a (k + 1) + ρ) := fun x => h3 k x.1 x.2
  obtain ⟨g, hg, hgf⟩ := ContinuousMap.exists_restrict_eq_forall_mem_of_closed fc hft
    ⟨a (k + 1), by constructor <;> linarith⟩ hcl
  refine ⟨g, g.continuous, fun x => hg x, ?_⟩
  intro x hx
  have h := congrArg (fun F : C(D bt Xmin (k + 1), ℝ) => F ⟨x, hx⟩) hgf
  simpa [fc] using h

/-- the re-encoded shift: step k + 1 reads only entry 0 of the state, the bare value; step 0 is never used -/
noncomputable def recode (a0 : ℝ) (g : ℕ → ℝ → ℝ) : ℕ → (ℕ → ℝ) → ℝ
  | 0 => fun _ => a0
  | k + 1 => fun s => g k (s 0)

/-- LEMMA A′ FROM THE EXISTING LEAN THEOREM: a shift known only on the trajectories that stayed in the window,
continuous and within ρ of the transient there, gives the target, the window and the profile -/
theorem trajectory_window (bt : ℕ → ℝ → ℝ) (a f : ℕ → ℝ) (Xmin c ρ F : ℝ)
    (h1 : ∀ k, ContinuousOn (bt (k + 1)) (D bt Xmin (k + 1)))
    (h3 : ∀ k, ∀ x ∈ D bt Xmin (k + 1), a (k + 1) - ρ ≤ bt (k + 1) x ∧ bt (k + 1) x ≤ a (k + 1) + ρ)
    (ha : ∀ i, a (i + 1) = c + f (i + 1) - f i) (hf : ∀ i, -F ≤ f i ∧ f i ≤ F)
    (hρ : 0 ≤ ρ) (hρc : ρ ≤ c) (K : ℕ) (X : ℝ) (hXw : Xmin + 2 * F ≤ X) :
    ∃ x₀, traj bt x₀ K = X ∧ (∀ j ≤ K, Xmin ≤ traj bt x₀ j) ∧
      ∀ j ≤ K, X + ((K - j : ℕ) : ℝ) * (c - ρ) - 2 * F ≤ traj bt x₀ j ∧
        traj bt x₀ j ≤ X + ((K - j : ℕ) : ℝ) * (c + ρ) + 2 * F := by
  choose g hgc hgb hga using extend bt a Xmin ρ hρ h1 h3
  have hb : ∀ k, Continuous (recode (a 0) g k) := by
    intro k
    cases k with
    | zero => exact continuous_const
    | succ k => exact (hgc k).comp (continuous_apply 0)
  have hr : ∀ k s, (∀ j, Xmin ≤ s j) → a k - ρ ≤ recode (a 0) g k s ∧ recode (a 0) g k s ≤ a k + ρ := by
    intro k s _
    cases k with
    | zero =>
      show a 0 - ρ ≤ a 0 ∧ a 0 ≤ a 0 + ρ
      constructor <;> linarith
    | succ k => exact hgb k (s 0)
  obtain ⟨x₀, hK, hprof, _⟩ :=
    window_of_bounded_transient (recode (a 0) g) hb a f Xmin c ρ F ha hf hρ hρc hr K X hXw
  set b := recode (a 0) g with hbdef
  have h0 : ∀ k, seq b x₀ k 0 = x₀ := fun k => by
    rw [seq_frozen b x₀ k 0 (Nat.zero_le k), val_zero]
  have hmin : ∀ j ≤ K, Xmin ≤ val b x₀ j := by
    intro j hj
    have h := (hprof j hj).1
    have hm : (0 : ℝ) ≤ ((K - j : ℕ) : ℝ) * (c - ρ) := mul_nonneg (Nat.cast_nonneg _) (by linarith)
    linarith
  have key : ∀ k ≤ K, traj bt x₀ k = val b x₀ k ∧ x₀ ∈ D bt Xmin (k + 1) := by
    intro k
    induction k with
    | zero =>
      intro _
      have e0 : traj bt x₀ 0 = val b x₀ 0 := by rw [val_zero]; rfl
      refine ⟨e0, ?_⟩
      intro j hj
      have : j = 0 := by omega
      subst this
      rw [e0]
      exact hmin 0 (Nat.zero_le K)
    | succ k ih =>
      intro hk
      obtain ⟨heq, hD⟩ := ih (by omega)
      have hstep : traj bt x₀ (k + 1) = val b x₀ (k + 1) := by
        rw [val_succ]
        have hbk : b (k + 1) (seq b x₀ k) = g k x₀ := by
          rw [hbdef]
          show g k (seq (recode (a 0) g) x₀ k 0) = g k x₀
          rw [← hbdef, h0 k]
        rw [hbk, hga k x₀ hD, ← heq]
        rfl
      refine ⟨hstep, ?_⟩
      intro j hj
      rcases Nat.lt_or_ge j (k + 1) with h | h
      · exact hD j h
      · have : j = k + 1 := by omega
        subst this
        rw [hstep]
        exact hmin (k + 1) hk
  refine ⟨x₀, ?_, ?_, ?_⟩
  · rw [(key K le_rfl).1]
    exact hK
  · intro j hj
    rw [(key j hj).1]
    exact hmin j hj
  · intro j hj
    rw [(key j hj).1]
    exact hprof j hj

end M3RBridge
