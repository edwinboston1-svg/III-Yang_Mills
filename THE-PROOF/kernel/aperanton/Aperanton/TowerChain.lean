/-
  ΑΠΕΡΑΝΤΟΝ — THE TOWER'S CHAIN: k NESTED CONDITIONINGS COMPOSE INTO ONE BOUND (Stage II, Tower.lean part 2)

  Tower.lean proves one level: cov(f, g) = ⟨cov(f, g | outside b)⟩ + cov(E_b f, E_b g), and the two-scale bound
  |cov(f, g)| ≤ K₀ + K₁ from a uniform bound K₀ on the constrained covariance and a bound K₁ on the coarse covariance.
  The tower applies this at every scale with the coarse observables E_b f, E_b g as the next scale's f, g: a chain of
  blocks b₁, …, b_k with per-scale constrained bounds K₁, …, K_k and a bound K_fin on the coarsest covariance gives
      |cov(f, g)| ≤ K₁ + ⋯ + K_k + K_fin.
  This is the composition T1 reads as "the gap is the tower's trivial kernel": every K_i is a finite reading (the
  Onsager tower's per-scale criteria), and the sum is the certified bound.  No sorry, no axiom, no native_decide.
-/
import Aperanton.Tower

open Finset

namespace Aperanton

section TowerChain

variable {S : Type*} [Fintype S] [DecidableEq S] {G : Type*} [Fintype G] [DecidableEq G] [Nonempty G]
  {β : Type*} [Fintype β] [DecidableEq β]

/-- the chain's hypotheses: at each block a uniform bound on the constrained covariance of the current observables, the
    next level on their conditional expectations, and at the end a bound on the coarsest covariance -/
def ChainOK (W : (S → G) → ℝ) (blk : S → β) :
    ((S → G) → ℝ) → ((S → G) → ℝ) → List β → List ℝ → ℝ → Prop
  | f, g, [], [], Kfin => |cov W f g| ≤ Kfin
  | f, g, b :: bs, K :: Ks, Kfin =>
      (∀ ω, |condCovB W blk b f g ω| ≤ K) ∧ ChainOK W blk (condExpB W blk b f) (condExpB W blk b g) bs Ks Kfin
  | _, _, _ :: _, [], _ => False
  | _, _, [], _ :: _, _ => False

theorem chainOK_nil (W : (S → G) → ℝ) (blk : S → β) (f g : (S → G) → ℝ) (Kfin : ℝ) :
    ChainOK W blk f g [] [] Kfin ↔ |cov W f g| ≤ Kfin := Iff.rfl

theorem chainOK_cons (W : (S → G) → ℝ) (blk : S → β) (f g : (S → G) → ℝ) (b : β) (bs : List β) (K : ℝ) (Ks : List ℝ)
    (Kfin : ℝ) :
    ChainOK W blk f g (b :: bs) (K :: Ks) Kfin ↔
      (∀ ω, |condCovB W blk b f g ω| ≤ K) ∧ ChainOK W blk (condExpB W blk b f) (condExpB W blk b g) bs Ks Kfin :=
  Iff.rfl

/-- THE TOWER'S CHAIN -/
theorem cov_le_chain (W : (S → G) → ℝ) (hW : ∀ ω, 0 < W ω) (blk : S → β) :
    ∀ (bs : List β) (Ks : List ℝ) (f g : (S → G) → ℝ) (Kfin : ℝ),
      ChainOK W blk f g bs Ks Kfin → |cov W f g| ≤ Ks.sum + Kfin := by
  intro bs
  induction bs with
  | nil =>
    intro Ks f g Kfin h
    cases Ks with
    | nil => simpa [ChainOK] using h
    | cons K Ks => exact absurd h (by simp [ChainOK])
  | cons b bs ih =>
    intro Ks f g Kfin h
    cases Ks with
    | nil => exact absurd h (by simp [ChainOK])
    | cons K Ks =>
      rw [chainOK_cons] at h
      obtain ⟨h0, hrest⟩ := h
      have h1 := ih Ks (condExpB W blk b f) (condExpB W blk b g) Kfin hrest
      have := cov_le_two_scales W hW blk b f g K (Ks.sum + Kfin) h0 h1
      simpa [List.sum_cons, add_assoc] using this

end TowerChain

end Aperanton
