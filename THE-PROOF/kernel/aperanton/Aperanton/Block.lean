/-
  APERANTON -- THE BOUNDLESS, stage W8 (ADDENDUM I, THE ROAD -- THE WINDOW'S IR INSTRUMENT): THE BLOCK COMPARISON
  THEOREM, FINITE.

  Dobrushin's comparison theorem (Dobrushin.lean) sweeps SITES: one site's conditional law, an interdependence
  matrix of one-site total variations, row sums below one.  Measured on the Z₂ slab (aperanton_block.awk), the same
  theorem with a BLOCK of links as a site loses to the one-site criterion (1.177 against 0.995 at y = 13/15); the
  criterion that wins is Dobrushin–Shlosman's, where a block's law under one outside change is COUPLED to the law
  before the change and what is charged is the coupling's disagreement at each block site.  This file is that
  theorem in the finite setting, by the same sweep machinery: a BLOCK CONDITIONAL EXPECTATION `condExpB` (the block
  overwritten by `patch`, LEMMA B′: the Gibbs measure is stationary for it, one involution of (configuration,
  block state)); a BLOCK COUPLING hypothesis `BlockCoupling` (for every block, outside site and change, a coupling
  of the two block laws with the disagreement at block site x at most C x t); LEMMA A′ (`oscBound_condExpB`): the
  block conditional expectation carries the bound 0 on the block and d t + Σ_{x ∈ block} C x t · d x outside; and
  THE IDENTITY that makes the rest free: with C zero inside every block, the block step IS the site sweep of the
  block's sites (`applyB_blkList`, `removed_blkList`), so the removed-mass invariant, the Neumann bound, the level
  bound and the mass contraction of Dobrushin.lean apply to the block sweep unchanged.  THE BLOCK COMPARISON
  THEOREM (`comparison_level_blk`): with the row sums Σ_t C x t ≤ α < 1 at every site x (the "influence on a site"
  form: Weitz 2005 Thm 2.5, Rebeschini–van Handel 2013 Cor. 2.8 (3)), C of range one along a level function, f's
  bound supported at levels ≤ a and the block discrepancy supported at levels ≥ a + R,
      |gibbs W' f − gibbs W f| ≤ (Σ_t b_{blk t})(Σ d) α^R / (1 − α);
  THE COVARIANCE (`cov_le_blk`) by the tilt.  The one-site theorem is the case of singleton blocks.  W = 0
  (Dobrushin 1968/1970; Dobrushin–Shlosman 1985; Weitz 2005; Rebeschini–van Handel 2013 prove it by Gibbs samplers
  and say the method of estimates does not extend past single sites -- here it does, through the identity above);
  the finite proof is this file's.  No sorry, no axiom, no native_decide.
-/
import Mathlib
import Aperanton.Dobrushin

open Finset

namespace Aperanton

section Block

variable {S : Type*} [Fintype S] [DecidableEq S] {G : Type*} [Fintype G] [DecidableEq G] [Nonempty G]
  {β : Type*} [Fintype β] [DecidableEq β]

/-- the sites of block b -/
abbrev Blk (blk : S → β) (b : β) := {t : S // blk t = b}

/-- the configuration with block b overwritten by ξ -/
def patch (blk : S → β) (b : β) (ω : S → G) (ξ : Blk blk b → G) : S → G :=
  fun t => if h : blk t = b then ξ ⟨t, h⟩ else ω t

theorem patch_of_mem (blk : S → β) (b : β) (ω : S → G) (ξ : Blk blk b → G) (t : S) (h : blk t = b) :
    patch blk b ω ξ t = ξ ⟨t, h⟩ := by simp [patch, h]

theorem patch_of_not_mem (blk : S → β) (b : β) (ω : S → G) (ξ : Blk blk b → G) (t : S) (h : blk t ≠ b) :
    patch blk b ω ξ t = ω t := by simp [patch, h]

theorem patch_patch (blk : S → β) (b : β) (ω : S → G) (ξ ξ' : Blk blk b → G) :
    patch blk b (patch blk b ω ξ) ξ' = patch blk b ω ξ' := by
  funext t; by_cases h : blk t = b <;> simp [patch, h]

/-- the restriction of a configuration to block b -/
def restr (blk : S → β) (b : β) (ω : S → G) : Blk blk b → G := fun x => ω x.1

theorem patch_restr (blk : S → β) (b : β) (ω : S → G) : patch blk b ω (restr blk b ω) = ω := by
  funext t; by_cases h : blk t = b <;> simp [patch, restr, h]

theorem restr_patch (blk : S → β) (b : β) (ω : S → G) (ξ : Blk blk b → G) :
    restr blk b (patch blk b ω ξ) = ξ := by
  funext x; simp [restr, patch, x.2]

theorem patch_update_of_mem (blk : S → β) (b : β) (ω : S → G) (ξ : Blk blk b → G) (t : S) (h : blk t = b)
    (g : G) : patch blk b (Function.update ω t g) ξ = patch blk b ω ξ := by
  funext s; by_cases hs : blk s = b
  · simp [patch, hs]
  · have hst : s ≠ t := fun e => hs (e ▸ h)
    simp [patch, hs, Function.update_of_ne hst]

theorem patch_update_of_not_mem (blk : S → β) (b : β) (ω : S → G) (ξ : Blk blk b → G) (t : S)
    (h : blk t ≠ b) (g : G) : patch blk b (Function.update ω t g) ξ = Function.update (patch blk b ω ξ) t g := by
  funext s; by_cases hst : s = t
  · subst hst; simp [patch, h]
  · by_cases hs : blk s = b
    · simp [patch, hs, Function.update_of_ne hst]
    · simp [patch, hs, Function.update_of_ne hst]

/-- the block partition function at b -/
noncomputable def zblk (W : (S → G) → ℝ) (blk : S → β) (b : β) (ω : S → G) : ℝ := ∑ ξ, W (patch blk b ω ξ)

/-- the block conditional distribution at b -/
noncomputable def condB (W : (S → G) → ℝ) (blk : S → β) (b : β) (ω : S → G) (ξ : Blk blk b → G) : ℝ :=
  W (patch blk b ω ξ) / zblk W blk b ω

/-- the block conditional expectation at b -/
noncomputable def condExpB (W : (S → G) → ℝ) (blk : S → β) (b : β) (f : (S → G) → ℝ) (ω : S → G) : ℝ :=
  ∑ ξ, condB W blk b ω ξ * f (patch blk b ω ξ)

theorem zblk_pos (W : (S → G) → ℝ) (hW : ∀ ω, 0 < W ω) (blk : S → β) (b : β) (ω : S → G) :
    0 < zblk W blk b ω :=
  sum_pos (fun ξ _ => hW _) univ_nonempty

theorem zblk_patch (W : (S → G) → ℝ) (blk : S → β) (b : β) (ω : S → G) (ξ : Blk blk b → G) :
    zblk W blk b (patch blk b ω ξ) = zblk W blk b ω := by
  simp only [zblk, patch_patch]

theorem condB_nonneg (W : (S → G) → ℝ) (hW : ∀ ω, 0 < W ω) (blk : S → β) (b : β) (ω : S → G)
    (ξ : Blk blk b → G) : 0 ≤ condB W blk b ω ξ :=
  div_nonneg (hW _).le (zblk_pos W hW blk b ω).le

theorem condB_sum (W : (S → G) → ℝ) (hW : ∀ ω, 0 < W ω) (blk : S → β) (b : β) (ω : S → G) :
    ∑ ξ, condB W blk b ω ξ = 1 := by
  simp only [condB]
  rw [← sum_div]
  exact div_self (zblk_pos W hW blk b ω).ne'

theorem condB_update_mem (W : (S → G) → ℝ) (blk : S → β) (b : β) (ω : S → G) (t : S) (ht : blk t = b)
    (g : G) : condB W blk b (Function.update ω t g) = condB W blk b ω := by
  funext ξ
  simp only [condB, zblk, patch_update_of_mem blk b ω _ t ht g]

theorem condExpB_update_mem (W : (S → G) → ℝ) (blk : S → β) (b : β) (f : (S → G) → ℝ) (ω : S → G) (t : S)
    (ht : blk t = b) (g : G) : condExpB W blk b f (Function.update ω t g) = condExpB W blk b f ω := by
  simp only [condExpB, condB_update_mem W blk b ω t ht g, patch_update_of_mem blk b ω _ t ht g]

/-- the involution of (configuration, block state) that swaps the block's state with the stored one -/
def swapBlk (blk : S → β) (b : β) : (S → G) × (Blk blk b → G) ≃ (S → G) × (Blk blk b → G) where
  toFun x := (patch blk b x.1 x.2, restr blk b x.1)
  invFun x := (patch blk b x.1 x.2, restr blk b x.1)
  left_inv x := by
    ext1
    · simp only [patch_patch, patch_restr]
    · simp only [restr_patch]
  right_inv x := by
    ext1
    · simp only [patch_patch, patch_restr]
    · simp only [restr_patch]

/-- LEMMA B′: the Gibbs measure is stationary for every block conditional (detailed balance) -/
theorem gibbs_condExpB (W : (S → G) → ℝ) (hW : ∀ ω, 0 < W ω) (blk : S → β) (b : β) (f : (S → G) → ℝ) :
    gibbs W (condExpB W blk b f) = gibbs W f := by
  simp only [gibbs]
  congr 1
  have hnum : ∑ ω, W ω * condExpB W blk b f ω =
      ∑ x : (S → G) × (Blk blk b → G),
        W x.1 * (W (patch blk b x.1 x.2) / zblk W blk b x.1 * f (patch blk b x.1 x.2)) := by
    simp only [condExpB, condB, mul_sum]
    rw [Fintype.sum_prod_type]
  rw [hnum, Fintype.sum_equiv (swapBlk blk b) _ (fun x : (S → G) × (Blk blk b → G) =>
      W (patch blk b x.1 x.2) * (W x.1 / zblk W blk b x.1 * f x.1)) ?_]
  · rw [Fintype.sum_prod_type]
    refine sum_congr rfl fun ω _ => ?_
    have hz := (zblk_pos W hW blk b ω).ne'
    calc ∑ ξ, W (patch blk b ω ξ) * (W ω / zblk W blk b ω * f ω)
        = (∑ ξ, W (patch blk b ω ξ)) * (W ω / zblk W blk b ω * f ω) := by rw [sum_mul]
      _ = zblk W blk b ω * (W ω / zblk W blk b ω * f ω) := rfl
      _ = W ω * f ω := by field_simp
  · intro x
    simp only [swapBlk, Equiv.coe_fn_mk, patch_patch, patch_restr, zblk_patch]

/-- the global oscillation over a set: overwriting the sites of T by ω' moves f by at most Σ_T d -/
theorem abs_sub_le_sum_osc_on (f : (S → G) → ℝ) (d : S → ℝ) (hf : OscBound f d) (ω ω' : S → G) (T : Finset S) :
    |f (fun t => if t ∈ T then ω' t else ω t) - f ω| ≤ ∑ t ∈ T, d t := by
  induction T using Finset.induction_on with
  | empty => simp
  | @insert s T hs ih =>
    set P : S → G := fun t => if t ∈ T then ω' t else ω t with hP
    have hpatch : (fun t => if t ∈ insert s T then ω' t else ω t) = Function.update P s (ω' s) := by
      funext t
      by_cases hts : t = s
      · subst hts; simp [hP]
      · simp [hP, Function.update_of_ne hts, hts]
    rw [sum_insert hs, hpatch]
    have hstep : |f (Function.update P s (ω' s)) - f P| ≤ d s := by
      have := hf s P (ω' s) (P s)
      rwa [Function.update_eq_self] at this
    calc |f (Function.update P s (ω' s)) - f ω|
        = |(f (Function.update P s (ω' s)) - f P) + (f P - f ω)| := by rw [sub_add_sub_cancel]
      _ ≤ |f (Function.update P s (ω' s)) - f P| + |f P - f ω| := abs_add_le _ _
      _ ≤ d s + ∑ t ∈ T, d t := add_le_add hstep ih

/-- two configurations agreeing off T are at most Σ_T d apart in f -/
theorem abs_sub_le_of_agree (f : (S → G) → ℝ) (d : S → ℝ) (hf : OscBound f d) (ω ω' : S → G) (T : Finset S)
    (hT : ∀ t, t ∉ T → ω t = ω' t) : |f ω' - f ω| ≤ ∑ t ∈ T, d t := by
  have h := abs_sub_le_sum_osc_on f d hf ω ω' T
  have heq : (fun t => if t ∈ T then ω' t else ω t) = ω' := by
    funext t
    by_cases ht : t ∈ T
    · simp [ht]
    · simp [ht, hT t ht]
  rwa [heq] at h

/-- a block coupling: for every block b, outside site t and change at t, a coupling of the two block laws whose
disagreement at block site x is at most C x t -/
def BlockCoupling (W : (S → G) → ℝ) (blk : S → β) (C : S → S → ℝ) : Prop :=
  ∀ (b : β) (t : S), blk t ≠ b → ∀ (ω : S → G) (g : G),
    ∃ Q : (Blk blk b → G) → (Blk blk b → G) → ℝ,
      (∀ ξ ξ', 0 ≤ Q ξ ξ') ∧ (∀ ξ, ∑ ξ', Q ξ ξ' = condB W blk b ω ξ) ∧
      (∀ ξ', ∑ ξ, Q ξ ξ' = condB W blk b (Function.update ω t g) ξ') ∧
      (∀ x : Blk blk b, ∑ ξ, ∑ ξ', Q ξ ξ' * (if ξ x = ξ' x then 0 else 1) ≤ C x.1 t)

/-- the block step on the bound vector: zero on the block, d t + Σ_{x ∈ block} C x t · d x outside -/
def stepBlk (C : S → S → ℝ) (blk : S → β) (b : β) (d : S → ℝ) : S → ℝ :=
  fun t => if blk t = b then 0 else d t + ∑ x : Blk blk b, C x.1 t * d x.1

/-- LEMMA A′: the block conditional expectation carries the block step's bound -/
theorem oscBound_condExpB (W : (S → G) → ℝ) (hW : ∀ ω, 0 < W ω) (blk : S → β) (C : S → S → ℝ)
    (hC : BlockCoupling W blk C) (f : (S → G) → ℝ) (d : S → ℝ) (hf : OscBound f d) (b : β) :
    OscBound (condExpB W blk b f) (stepBlk C blk b d) := by
  intro t ω g g'
  have hd0 := oscBound_nonneg hf
  by_cases ht : blk t = b
  · rw [condExpB_update_mem W blk b f ω t ht g, condExpB_update_mem W blk b f ω t ht g', sub_self, abs_zero]
    simp [stepBlk, ht]
  · simp only [stepBlk, if_neg ht]
    set ω₁ := Function.update ω t g with hω₁
    set ω₂ := Function.update ω t g' with hω₂
    have hω₂' : ω₂ = Function.update ω₁ t g' := by rw [hω₁, hω₂, Function.update_idem]
    obtain ⟨Q, hQ0, hQ1, hQ2, hQC⟩ := hC b t ht ω₁ g'
    rw [← hω₂'] at hQ2
    -- the two expectations as double sums against the coupling
    have e1 : condExpB W blk b f ω₁ = ∑ ξ, ∑ ξ', Q ξ ξ' * f (patch blk b ω₁ ξ) := by
      simp only [condExpB]
      refine sum_congr rfl fun ξ _ => ?_
      rw [← hQ1 ξ, sum_mul]
    have e2 : condExpB W blk b f ω₂ = ∑ ξ, ∑ ξ', Q ξ ξ' * f (patch blk b ω₂ ξ') := by
      simp only [condExpB]
      rw [sum_comm]
      refine sum_congr rfl fun ξ' _ => ?_
      rw [← hQ2 ξ', sum_mul]
    -- the pointwise bound: the two patched configurations agree off t and the disagreeing block sites
    have hpt : ∀ ξ ξ', |f (patch blk b ω₁ ξ) - f (patch blk b ω₂ ξ')| ≤
        d t + ∑ x : Blk blk b, (if ξ x = ξ' x then 0 else 1) * d x.1 := by
      intro ξ ξ'
      set T : Finset S := insert t ((univ.filter fun x : Blk blk b => ξ x ≠ ξ' x).image Subtype.val) with hT
      have hagree : ∀ s, s ∉ T → patch blk b ω₂ ξ' s = patch blk b ω₁ ξ s := by
        intro s hs
        have hst : s ≠ t := fun h => hs (by rw [hT, h]; exact mem_insert_self t _)
        by_cases hsb : blk s = b
        · have hx : ξ ⟨s, hsb⟩ = ξ' ⟨s, hsb⟩ := by
            by_contra hne
            apply hs
            rw [hT, mem_insert]
            exact Or.inr (mem_image.mpr ⟨⟨s, hsb⟩, mem_filter.mpr ⟨mem_univ _, hne⟩, rfl⟩)
          rw [patch_of_mem blk b ω₂ ξ' s hsb, patch_of_mem blk b ω₁ ξ s hsb, hx]
        · rw [patch_of_not_mem blk b ω₂ ξ' s hsb, patch_of_not_mem blk b ω₁ ξ s hsb, hω₁, hω₂,
            Function.update_of_ne hst, Function.update_of_ne hst]
      have h1 := abs_sub_le_of_agree f d hf (patch blk b ω₂ ξ') (patch blk b ω₁ ξ) T hagree
      refine le_trans h1 ?_
      have htnot : t ∉ (univ.filter fun x : Blk blk b => ξ x ≠ ξ' x).image Subtype.val := by
        simp only [mem_image, mem_filter, mem_univ, true_and, not_exists, not_and]
        intro x _ hx
        exact ht (hx ▸ x.2)
      rw [hT, sum_insert htnot, sum_image (fun x _ y _ h => Subtype.ext h), sum_filter]
      apply le_of_eq
      congr 1
      refine sum_congr rfl fun x _ => ?_
      by_cases hx : ξ x = ξ' x <;> simp [hx]
    have hQtot : ∑ ξ, ∑ ξ', Q ξ ξ' = 1 := by
      simp only [hQ1]
      exact condB_sum W hW blk b ω₁
    rw [e1, e2]
    calc |∑ ξ, ∑ ξ', Q ξ ξ' * f (patch blk b ω₁ ξ) - ∑ ξ, ∑ ξ', Q ξ ξ' * f (patch blk b ω₂ ξ')|
        = |∑ ξ, ∑ ξ', Q ξ ξ' * (f (patch blk b ω₁ ξ) - f (patch blk b ω₂ ξ'))| := by
          simp only [mul_sub, sum_sub_distrib]
      _ ≤ ∑ ξ, ∑ ξ', Q ξ ξ' * (d t + ∑ x : Blk blk b, (if ξ x = ξ' x then 0 else 1) * d x.1) := by
          refine le_trans (abs_sum_le_sum_abs _ _) (sum_le_sum fun ξ _ => ?_)
          refine le_trans (abs_sum_le_sum_abs _ _) (sum_le_sum fun ξ' _ => ?_)
          rw [abs_mul, abs_of_nonneg (hQ0 ξ ξ')]
          exact mul_le_mul_of_nonneg_left (hpt ξ ξ') (hQ0 ξ ξ')
      _ = (∑ ξ, ∑ ξ', Q ξ ξ') * d t +
          ∑ x : Blk blk b, (∑ ξ, ∑ ξ', Q ξ ξ' * (if ξ x = ξ' x then 0 else 1)) * d x.1 := by
          have e3 : ∀ ξ ξ', Q ξ ξ' * (d t + ∑ x : Blk blk b, (if ξ x = ξ' x then (0 : ℝ) else 1) * d x.1)
              = Q ξ ξ' * d t + ∑ x : Blk blk b, (Q ξ ξ' * (if ξ x = ξ' x then (0 : ℝ) else 1)) * d x.1 := by
            intro ξ ξ'
            rw [mul_add, mul_sum]
            congr 1
            exact sum_congr rfl fun x _ => by ring
          simp only [e3, sum_add_distrib]
          congr 1
          · rw [sum_mul]
            exact sum_congr rfl fun ξ _ => (Finset.sum_mul _ _ _).symm
          · simp only [sum_mul]
            exact (sum_congr rfl fun ξ _ => Finset.sum_comm).trans Finset.sum_comm
      _ ≤ d t + ∑ x : Blk blk b, C x.1 t * d x.1 := by
          rw [hQtot, one_mul]
          exact add_le_add (le_refl (d t))
            (sum_le_sum fun x _ => mul_le_mul_of_nonneg_right (hQC x) (hd0 x.1))

end Block

section BlockSweep

variable {S : Type*} [Fintype S] [DecidableEq S] {G : Type*} [Fintype G] [DecidableEq G] [Nonempty G]
  {β : Type*} [Fintype β] [DecidableEq β]

/-- the sites of block b as a list -/
noncomputable def blkList (blk : S → β) (b : β) : List S := (univ.filter fun t => blk t = b).toList

theorem mem_blkList (blk : S → β) (b : β) (s : S) : s ∈ blkList blk b ↔ blk s = b := by
  simp [blkList]

theorem blkList_nodup (blk : S → β) (b : β) : (blkList blk b).Nodup := Finset.nodup_toList _

theorem blkList_toFinset (blk : S → β) (b : β) : (blkList blk b).toFinset = univ.filter fun t => blk t = b := by
  simp [blkList]

/-- the sites of a list of blocks, block by block -/
noncomputable def sitesOf (blk : S → β) : List β → List S
  | [] => []
  | b :: L => blkList blk b ++ sitesOf blk L

theorem mem_sitesOf (blk : S → β) (L : List β) (s : S) : s ∈ sitesOf blk L ↔ blk s ∈ L := by
  induction L with
  | nil => simp [sitesOf]
  | cons b L ih => simp [sitesOf, List.mem_append, mem_blkList, ih]

theorem sitesOf_append (blk : S → β) (L₁ L₂ : List β) :
    sitesOf blk (L₁ ++ L₂) = sitesOf blk L₁ ++ sitesOf blk L₂ := by
  induction L₁ with
  | nil => rfl
  | cons b L ih => simp [sitesOf, ih, List.append_assoc]

theorem sitesOf_nodup (blk : S → β) (L : List β) (hL : L.Nodup) : (sitesOf blk L).Nodup := by
  induction L with
  | nil => simp [sitesOf]
  | cons b L ih =>
    have hnd := List.nodup_cons.mp hL
    simp only [sitesOf]
    rw [List.nodup_append]
    refine ⟨blkList_nodup blk b, ih hnd.2, ?_⟩
    intro s hs s' hs' heq
    subst heq
    rw [mem_blkList] at hs
    rw [mem_sitesOf] at hs'
    exact hnd.1 (hs ▸ hs')

/-- the site sweep of a block's sites with no coupling inside the block is the block step -/
theorem applyB_sub_blk (C : S → S → ℝ) (blk : S → β) (b : β) (hCblk : ∀ s t, blk s = blk t → C s t = 0) :
    ∀ (L : List S), L.Nodup → (∀ s ∈ L, blk s = b) → ∀ (d : S → ℝ) (t : S),
      applyB C L d t = if t ∈ L then 0 else d t + ∑ x ∈ L.toFinset, C x t * d x := by
  intro L
  induction L with
  | nil => intro _ _ d t; simp [applyB]
  | cons s L ih =>
    intro hL hb d t
    have hnd := List.nodup_cons.mp hL
    have hsb : blk s = b := hb s List.mem_cons_self
    have hLb : ∀ x ∈ L, blk x = b := fun x hx => hb x (List.mem_cons_of_mem _ hx)
    simp only [applyB]
    rw [ih hnd.2 hLb]
    have hstep : ∀ x ∈ L, stepB C s d x = d x := by
      intro x hx
      have hxs : x ≠ s := fun h => hnd.1 (h ▸ hx)
      rw [stepB_of_ne C s d hxs, hCblk s x (hsb.trans (hLb x hx).symm), zero_mul, add_zero]
    have hsum : ∑ x ∈ L.toFinset, C x t * stepB C s d x = ∑ x ∈ L.toFinset, C x t * d x :=
      sum_congr rfl fun x hx => by rw [hstep x (List.mem_toFinset.mp hx)]
    rw [hsum]
    by_cases htL : t ∈ L
    · simp [htL]
    · rw [if_neg htL, List.toFinset_cons, sum_insert (fun h => hnd.1 (List.mem_toFinset.mp h))]
      by_cases hts : t = s
      · subst hts
        rw [if_pos List.mem_cons_self, stepB_self]
        have : ∀ x ∈ L.toFinset, C x t * d x = 0 := fun x hx => by
          rw [hCblk x t ((hLb x (List.mem_toFinset.mp hx)).trans hsb.symm), zero_mul]
        rw [sum_eq_zero this]
        simp
      · rw [if_neg (by simp [hts, htL]), stepB_of_ne C s d hts]
        ring

theorem applyB_blkList (C : S → S → ℝ) (blk : S → β) (b : β) (hCblk : ∀ s t, blk s = blk t → C s t = 0)
    (d : S → ℝ) : applyB C (blkList blk b) d = stepBlk C blk b d := by
  funext t
  rw [applyB_sub_blk C blk b hCblk (blkList blk b) (blkList_nodup blk b)
    (fun s hs => (mem_blkList blk b s).mp hs) d t, blkList_toFinset]
  simp only [stepBlk]
  by_cases ht : blk t = b
  · rw [if_pos ((mem_blkList blk b t).mpr ht), if_pos ht]
  · rw [if_neg (fun h => ht ((mem_blkList blk b t).mp h)), if_neg ht]
    congr 1
    exact Finset.sum_subtype (univ.filter fun t => blk t = b) (fun x => by simp) (fun x => C x t * d x)

/-- the mass removed by the site sweep of a block's sites is the block's mass -/
theorem removed_sub_blk (C : S → S → ℝ) (blk : S → β) (b : β) (hCblk : ∀ s t, blk s = blk t → C s t = 0) :
    ∀ (L : List S), L.Nodup → (∀ s ∈ L, blk s = b) → ∀ (d : S → ℝ) (t : S),
      removed C L d t = if t ∈ L then d t else 0 := by
  intro L
  induction L with
  | nil => intro _ _ d t; simp [removed]
  | cons s L ih =>
    intro hL hb d t
    have hnd := List.nodup_cons.mp hL
    have hsb : blk s = b := hb s List.mem_cons_self
    have hLb : ∀ x ∈ L, blk x = b := fun x hx => hb x (List.mem_cons_of_mem _ hx)
    simp only [removed]
    rw [ih hnd.2 hLb]
    by_cases hts : t = s
    · subst hts
      have htL : t ∉ L := hnd.1
      simp [htL]
    · by_cases htL : t ∈ L
      · rw [if_neg hts, if_pos htL, if_pos (List.mem_cons_of_mem _ htL), stepB_of_ne C s d hts,
          hCblk s t (hsb.trans (hLb t htL).symm), zero_mul, add_zero, zero_add]
      · rw [if_neg hts, if_neg htL, if_neg (by simp [hts, htL])]
        simp

theorem removed_blkList (C : S → S → ℝ) (blk : S → β) (b : β) (hCblk : ∀ s t, blk s = blk t → C s t = 0)
    (d : S → ℝ) (t : S) : removed C (blkList blk b) d t = if blk t = b then d t else 0 := by
  rw [removed_sub_blk C blk b hCblk (blkList blk b) (blkList_nodup blk b)
    (fun s hs => (mem_blkList blk b s).mp hs) d t]
  by_cases ht : blk t = b
  · rw [if_pos ((mem_blkList blk b t).mpr ht), if_pos ht]
  · rw [if_neg (fun h => ht ((mem_blkList blk b t).mp h)), if_neg ht]

theorem removed_append (C : S → S → ℝ) (L₁ L₂ : List S) :
    ∀ (d : S → ℝ) (t : S), removed C (L₁ ++ L₂) d t = removed C L₁ d t + removed C L₂ (applyB C L₁ d) t := by
  induction L₁ with
  | nil => intro d t; simp [removed, applyB]
  | cons s L ih =>
    intro d t
    simp only [List.cons_append, removed, applyB]
    rw [ih]
    ring

/-- the block sweep: the blocks of the list visited in order, head first -/
noncomputable def sweepB (W : (S → G) → ℝ) (blk : S → β) : List β → ((S → G) → ℝ) → ((S → G) → ℝ)
  | [], f => f
  | b :: L, f => sweepB W blk L (condExpB W blk b f)

theorem oscBound_sweepB (W : (S → G) → ℝ) (hW : ∀ ω, 0 < W ω) (blk : S → β) (C : S → S → ℝ)
    (hCblk : ∀ s t, blk s = blk t → C s t = 0) (hC : BlockCoupling W blk C) (L : List β) :
    ∀ (f : (S → G) → ℝ) (d : S → ℝ), OscBound f d → OscBound (sweepB W blk L f) (applyB C (sitesOf blk L) d) := by
  induction L with
  | nil => intro f d hf; exact hf
  | cons b L ih =>
    intro f d hf
    simp only [sweepB, sitesOf, applyB_append, applyB_blkList C blk b hCblk]
    exact ih _ _ (oscBound_condExpB W hW blk C hC f d hf b)

theorem gibbs_sweepB (W : (S → G) → ℝ) (hW : ∀ ω, 0 < W ω) (blk : S → β) (L : List β) :
    ∀ f : (S → G) → ℝ, gibbs W (sweepB W blk L f) = gibbs W f := by
  induction L with
  | nil => intro f; rfl
  | cons b L ih => intro f; rw [sweepB, ih, gibbs_condExpB W hW]

/-- a block discrepancy bound between two weights' block conditionals -/
def DiscrepB (W W' : (S → G) → ℝ) (blk : S → β) (bB : β → ℝ) : Prop :=
  ∀ b ω, tv (condB W blk b ω) (condB W' blk b ω) ≤ bB b

/-- LEMMA C′: under the second weight, one block conditional step of the first moves the expectation by at most
bB b times the block's oscillation mass -/
theorem abs_gibbs_condExpB_sub_le (W W' : (S → G) → ℝ) (hW : ∀ ω, 0 < W ω) (hW' : ∀ ω, 0 < W' ω)
    (blk : S → β) (bB : β → ℝ) (hb : DiscrepB W W' blk bB) (f : (S → G) → ℝ) (d : S → ℝ) (hf : OscBound f d)
    (b : β) : |gibbs W' (condExpB W blk b f) - gibbs W' f| ≤ bB b * ∑ x : Blk blk b, d x.1 := by
  rw [← gibbs_condExpB W' hW' blk b f, ← gibbs_sub]
  apply abs_gibbs_le W' hW' _ (bB b * ∑ x : Blk blk b, d x.1)
  intro ω
  have hpt : condExpB W blk b f ω - condExpB W' blk b f ω =
      ∑ ξ, (condB W blk b ω ξ - condB W' blk b ω ξ) * f (patch blk b ω ξ) := by
    simp only [condExpB, sub_mul, sum_sub_distrib]
  rw [hpt]
  have hosc : ∀ ξ ξ', |f (patch blk b ω ξ) - f (patch blk b ω ξ')| ≤ ∑ x : Blk blk b, d x.1 := by
    intro ξ ξ'
    have h := abs_sub_le_of_agree f d hf (patch blk b ω ξ') (patch blk b ω ξ) (univ.filter fun t => blk t = b)
      (fun t ht => by
        have htb : blk t ≠ b := by simpa using ht
        rw [patch_of_not_mem blk b ω ξ' t htb, patch_of_not_mem blk b ω ξ t htb])
    calc |f (patch blk b ω ξ) - f (patch blk b ω ξ')|
        ≤ ∑ t ∈ univ.filter (fun t => blk t = b), d t := h
      _ = ∑ x : Blk blk b, d x.1 := Finset.sum_subtype _ (fun x => by simp) _
  calc |∑ ξ, (condB W blk b ω ξ - condB W' blk b ω ξ) * f (patch blk b ω ξ)|
      ≤ tv (condB W blk b ω) (condB W' blk b ω) * ∑ x : Blk blk b, d x.1 :=
        abs_sum_sub_mul_le _ _ _ (condB_sum W hW blk b ω) (condB_sum W' hW' blk b ω) _ hosc
    _ ≤ bB b * ∑ x : Blk blk b, d x.1 :=
        mul_le_mul_of_nonneg_right (hb b ω) (sum_nonneg fun x _ => oscBound_nonneg hf x.1)

/-- THE TELESCOPING under the second weight: the block sweep moves its expectation by at most Σ bB · removed -/
theorem abs_gibbs'_sweepB_sub_le (W W' : (S → G) → ℝ) (hW : ∀ ω, 0 < W ω) (hW' : ∀ ω, 0 < W' ω)
    (blk : S → β) (C : S → S → ℝ) (hCblk : ∀ s t, blk s = blk t → C s t = 0) (hC : BlockCoupling W blk C)
    (bB : β → ℝ) (hb : DiscrepB W W' blk bB) (L : List β) :
    ∀ (f : (S → G) → ℝ) (d : S → ℝ), OscBound f d →
      |gibbs W' f - gibbs W' (sweepB W blk L f)| ≤ ∑ t, bB (blk t) * removed C (sitesOf blk L) d t := by
  induction L with
  | nil => intro f d _; simp [sweepB, sitesOf, removed]
  | cons b L ih =>
    intro f d hf
    have h1 := abs_gibbs_condExpB_sub_le W W' hW hW' blk bB hb f d hf b
    have h2 := ih (condExpB W blk b f) (stepBlk C blk b d) (oscBound_condExpB W hW blk C hC f d hf b)
    have hsum : ∑ t, bB (blk t) * removed C (sitesOf blk (b :: L)) d t =
        bB b * ∑ x : Blk blk b, d x.1 + ∑ t, bB (blk t) * removed C (sitesOf blk L) (stepBlk C blk b d) t := by
      simp only [sitesOf, removed_append, removed_blkList C blk b hCblk, applyB_blkList C blk b hCblk, mul_add,
        sum_add_distrib]
      congr 1
      rw [mul_sum, ← Finset.sum_subtype (univ.filter fun t => blk t = b) (fun x => by simp) (fun x => bB b * d x),
        sum_filter]
      refine sum_congr rfl fun t _ => ?_
      by_cases ht : blk t = b <;> simp [ht]
    rw [hsum, sweepB]
    calc |gibbs W' f - gibbs W' (sweepB W blk L (condExpB W blk b f))|
        = |(gibbs W' f - gibbs W' (condExpB W blk b f)) +
            (gibbs W' (condExpB W blk b f) - gibbs W' (sweepB W blk L (condExpB W blk b f)))| := by
          rw [sub_add_sub_cancel]
      _ ≤ |gibbs W' f - gibbs W' (condExpB W blk b f)| +
            |gibbs W' (condExpB W blk b f) - gibbs W' (sweepB W blk L (condExpB W blk b f))| := abs_add_le _ _
      _ ≤ bB b * ∑ x : Blk blk b, d x.1 + ∑ t, bB (blk t) * removed C (sitesOf blk L) (stepBlk C blk b d) t := by
          rw [abs_sub_comm] at h1
          exact add_le_add h1 h2

/-- m full block sweeps -/
noncomputable def fullSweepsB (β : Type*) [Fintype β] : ℕ → List β
  | 0 => []
  | m + 1 => (univ : Finset β).toList ++ fullSweepsB β m

theorem sitesOf_univ_toFinset (blk : S → β) : (sitesOf blk (univ : Finset β).toList).toFinset = univ := by
  ext s
  simp [mem_sitesOf]

/-- the mass after m full block sweeps is at most α^m of the mass before -/
theorem applyB_iterB_le (C : S → S → ℝ) (hC : ∀ s t, 0 ≤ C s t) (blk : S → β) (α : ℝ) (hα0 : 0 ≤ α)
    (hα1 : α ≤ 1) (hrow : ∀ s, ∑ t, C s t ≤ α) (m : ℕ) :
    ∀ d : S → ℝ, (∀ t, 0 ≤ d t) → ∑ t, applyB C (sitesOf blk (fullSweepsB β m)) d t ≤ α ^ m * ∑ t, d t := by
  induction m with
  | zero => intro d _; simp [fullSweepsB, sitesOf, applyB]
  | succ m ih =>
    intro d hd
    simp only [fullSweepsB, sitesOf_append, applyB_append]
    have hfull := applyB_total_le C hC α hα1 hrow (sitesOf blk (univ : Finset β).toList)
      (sitesOf_nodup blk _ (Finset.nodup_toList _)) d hd
    rw [sitesOf_univ_toFinset] at hfull
    have hfull' : ∑ t, applyB C (sitesOf blk (univ : Finset β).toList) d t ≤ α * ∑ t, d t := by linarith
    have hnn := applyB_nonneg C hC (sitesOf blk (univ : Finset β).toList) d hd
    calc ∑ t, applyB C (sitesOf blk (fullSweepsB β m)) (applyB C (sitesOf blk (univ : Finset β).toList) d) t
        ≤ α ^ m * ∑ t, applyB C (sitesOf blk (univ : Finset β).toList) d t := ih _ hnn
      _ ≤ α ^ m * (α * ∑ t, d t) := mul_le_mul_of_nonneg_left hfull' (pow_nonneg hα0 m)
      _ = α ^ (m + 1) * ∑ t, d t := by ring

/-- THE BLOCK COMPARISON THEOREM WITH LEVELS: the row sums of the coupling matrix at most α < 1 at every site, C
zero inside every block and of range one along φ, f's oscillation bound supported at levels ≤ a, the block
discrepancy supported at levels ≥ a + R: the two Gibbs expectations of f differ by at most
(Σ_t bB (blk t))(Σ d) α^R / (1 − α) -/
theorem comparison_level_blk (W W' : (S → G) → ℝ) (hW : ∀ ω, 0 < W ω) (hW' : ∀ ω, 0 < W' ω)
    (blk : S → β) (C : S → S → ℝ) (hC : ∀ s t, 0 ≤ C s t) (hCblk : ∀ s t, blk s = blk t → C s t = 0)
    (hCW : BlockCoupling W blk C) (α : ℝ) (hα0 : 0 ≤ α) (hα1 : α < 1)
    (hrow : ∀ s, ∑ t, C s t ≤ α) (φ : S → ℕ) (hφ : RangeOne C φ)
    (bB : β → ℝ) (hb0 : ∀ b, 0 ≤ bB b) (hb : DiscrepB W W' blk bB)
    (f : (S → G) → ℝ) (d : S → ℝ) (hf : OscBound f d)
    (a R : ℕ) (hd : ∀ t, a < φ t → d t = 0) (hbR : ∀ t, φ t < a + R → bB (blk t) = 0) :
    |gibbs W' f - gibbs W f| ≤ (∑ t, bB (blk t)) * (∑ t, d t) * α ^ R / (1 - α) := by
  have h1α : 0 < 1 - α := by linarith
  have hd0 : ∀ t, 0 ≤ d t := oscBound_nonneg hf
  -- the removed mass at a site of level ≥ a + R is at most α^R Σ d / (1 − α), for every sweep list
  have hrem : ∀ (L : List S) (t : S), a + R ≤ φ t → removed C L d t ≤ α ^ R * (∑ t, d t) / (1 - α) := by
    intro L t ht
    have hr := removed_nonneg C hC L d hd0
    have hinv : ∀ t, removed C L d t ≤ d t + CT C (removed C L d) t := fun t =>
      le_trans (le_add_of_nonneg_right (applyB_nonneg C hC L d hd0 t)) (removed_invariant C hC L d hd0 t)
    have hneu := neumann_le C hC d (removed C L d) hinv R t
    have hzero : ∑ k ∈ range R, CTpow C k d t = 0 := by
      refine sum_eq_zero fun k hk => ?_
      have hk' := mem_range.mp hk
      exact CTpow_level C φ hφ k d a hd t (by omega)
    rw [hzero, zero_add] at hneu
    calc removed C L d t ≤ CTpow C R (removed C L d) t := hneu
      _ ≤ ∑ s, CTpow C R (removed C L d) s := single_le_sum' _ (CTpow_nonneg C hC R _ hr) t
      _ ≤ α ^ R * ∑ s, removed C L d s := sum_CTpow_le C hC α hα0 hrow R _ hr
      _ ≤ α ^ R * ((∑ t, d t) / (1 - α)) :=
          mul_le_mul_of_nonneg_left (sum_removed_le C hC α hα1 hrow L d hd0) (pow_nonneg hα0 R)
      _ = α ^ R * (∑ t, d t) / (1 - α) := by ring
  -- for every number of full block sweeps m the difference is at most the removed term plus the residual mass
  have hm : ∀ m : ℕ, |gibbs W' f - gibbs W f| ≤
      (∑ t, bB (blk t)) * (∑ t, d t) * α ^ R / (1 - α) + α ^ m * ∑ t, d t := by
    intro m
    have hA := abs_gibbs'_sweepB_sub_le W W' hW hW' blk C hCblk hCW bB hb (fullSweepsB β m) f d hf
    have hB : |gibbs W' (sweepB W blk (fullSweepsB β m) f) - gibbs W (sweepB W blk (fullSweepsB β m) f)| ≤
        α ^ m * ∑ t, d t := by
      have hosc := oscBound_sweepB W hW blk C hCblk hCW (fullSweepsB β m) f d hf
      have hglob := fun ω ω' => abs_sub_le_sum_osc _ _ hosc ω ω'
      exact le_trans (abs_gibbs_sub_gibbs_le W W' hW hW' _ _ hglob)
        (applyB_iterB_le C hC blk α hα0 hα1.le hrow m d hd0)
    have hremsum : ∑ t, bB (blk t) * removed C (sitesOf blk (fullSweepsB β m)) d t ≤
        (∑ t, bB (blk t)) * (∑ t, d t) * α ^ R / (1 - α) := by
      calc ∑ t, bB (blk t) * removed C (sitesOf blk (fullSweepsB β m)) d t
          ≤ ∑ t, bB (blk t) * (α ^ R * (∑ t, d t) / (1 - α)) := by
            refine sum_le_sum fun t _ => ?_
            by_cases ht : a + R ≤ φ t
            · exact mul_le_mul_of_nonneg_left (hrem _ t ht) (hb0 (blk t))
            · simp [hbR t (by omega)]
        _ = (∑ t, bB (blk t)) * (∑ t, d t) * α ^ R / (1 - α) := by rw [← sum_mul]; ring
    rw [gibbs_sweepB W hW blk (fullSweepsB β m) f] at hB
    calc |gibbs W' f - gibbs W f|
        = |(gibbs W' f - gibbs W' (sweepB W blk (fullSweepsB β m) f)) +
            (gibbs W' (sweepB W blk (fullSweepsB β m) f) - gibbs W f)| := by rw [sub_add_sub_cancel]
      _ ≤ |gibbs W' f - gibbs W' (sweepB W blk (fullSweepsB β m) f)| +
            |gibbs W' (sweepB W blk (fullSweepsB β m) f) - gibbs W f| := abs_add_le _ _
      _ ≤ (∑ t, bB (blk t)) * (∑ t, d t) * α ^ R / (1 - α) + α ^ m * ∑ t, d t :=
          add_le_add (le_trans hA hremsum) hB
  -- the residual mass vanishes as m → ∞
  by_contra hcon
  push_neg at hcon
  rcases (sum_nonneg fun t _ => hd0 t).lt_or_eq with hdpos | hdzero
  · have hεpos : 0 < (|gibbs W' f - gibbs W f| - (∑ t, bB (blk t)) * (∑ t, d t) * α ^ R / (1 - α)) / ∑ t, d t :=
      div_pos (by linarith) hdpos
    obtain ⟨m, hmε⟩ := exists_pow_lt_of_lt_one hεpos hα1
    have h2 := mul_lt_mul_of_pos_right hmε hdpos
    rw [div_mul_cancel₀ _ hdpos.ne'] at h2
    linarith [hm m]
  · have h0 := hm 0
    rw [← hdzero] at h0 hcon
    simp only [pow_zero, mul_zero, zero_mul, zero_div, add_zero] at h0 hcon
    linarith

/-- a positive tilt read at no site of a block leaves that block's conditional unchanged -/
theorem g_patch_eq (g : (S → G) → ℝ) (blk : S → β) (b : β)
    (hfree : ∀ s, blk s = b → ∀ ω x, g (Function.update ω s x) = g ω) (ω : S → G) (ξ : Blk blk b → G) :
    g (patch blk b ω ξ) = g ω := by
  have key : ∀ T : Finset S, (∀ s ∈ T, blk s = b) →
      g (fun t => if t ∈ T then patch blk b ω ξ t else ω t) = g ω := by
    intro T
    induction T using Finset.induction_on with
    | empty => intro _; simp
    | @insert s T hs ih =>
      intro hT
      set P : S → G := fun t => if t ∈ T then patch blk b ω ξ t else ω t with hP
      have hpatch : (fun t => if t ∈ insert s T then patch blk b ω ξ t else ω t) =
          Function.update P s (patch blk b ω ξ s) := by
        funext t
        by_cases hts : t = s
        · subst hts; simp [hP]
        · simp [hP, Function.update_of_ne hts, hts]
      rw [hpatch, hfree s (hT s (mem_insert_self s T)), ih (fun x hx => hT x (mem_insert_of_mem hx))]
  have h := key (univ.filter fun t => blk t = b) (fun s hs => (mem_filter.mp hs).2)
  have heq : (fun t => if t ∈ univ.filter (fun t => blk t = b) then patch blk b ω ξ t else ω t) =
      patch blk b ω ξ := by
    funext t
    by_cases ht : blk t = b
    · simp [ht]
    · simp [ht, patch_of_not_mem blk b ω ξ t ht]
  rwa [heq] at h

/-- THE TILT ON BLOCKS: multiplying the weight by a positive g changes no block conditional of a block g reads no
site of, and any by at most one -/
theorem discrep_tilt_blk (W : (S → G) → ℝ) (hW : ∀ ω, 0 < W ω) (g : (S → G) → ℝ) (hg : ∀ ω, 0 < g ω)
    (blk : S → β) (reads : S → Prop) [DecidablePred reads]
    (hfree : ∀ s, ¬ reads s → ∀ ω x, g (Function.update ω s x) = g ω) :
    DiscrepB W (fun ω => g ω * W ω) blk (fun b => if ∃ x : Blk blk b, reads x.1 then 1 else 0) := by
  intro b ω
  beta_reduce
  have hW' : ∀ ω, 0 < g ω * W ω := fun ω => mul_pos (hg ω) (hW ω)
  by_cases hb : ∃ x : Blk blk b, reads x.1
  · rw [if_pos hb]
    exact tv_le_one _ _ (condB_nonneg W hW blk b ω) (condB_nonneg _ hW' blk b ω) (condB_sum W hW blk b ω)
      (condB_sum _ hW' blk b ω)
  · rw [if_neg hb]
    have hnone : ∀ s, blk s = b → ∀ ω x, g (Function.update ω s x) = g ω := by
      intro s hs
      have : ¬ reads s := fun hr => hb ⟨⟨s, hs⟩, hr⟩
      exact hfree s this
    have heq : condB (fun ω => g ω * W ω) blk b ω = condB W blk b ω := by
      funext ξ
      simp only [condB, zblk, g_patch_eq g blk b hnone ω]
      rw [← mul_sum, mul_div_mul_left _ _ (hg ω).ne']
    rw [heq, tv_self]

/-- THE BLOCK COVARIANCE BOUND: the covariance of f (bound d at levels ≤ a) and a positive g read at levels ≥ a + R
is at most gibbs W g · (Σ b)(Σ d) α^R/(1 − α), b the indicator of the blocks g reads -/
theorem cov_le_blk (W : (S → G) → ℝ) (hW : ∀ ω, 0 < W ω)
    (blk : S → β) (C : S → S → ℝ) (hC : ∀ s t, 0 ≤ C s t) (hCblk : ∀ s t, blk s = blk t → C s t = 0)
    (hCW : BlockCoupling W blk C) (α : ℝ) (hα0 : 0 ≤ α) (hα1 : α < 1)
    (hrow : ∀ s, ∑ t, C s t ≤ α) (φ : S → ℕ) (hφ : RangeOne C φ)
    (f : (S → G) → ℝ) (d : S → ℝ) (hf : OscBound f d) (a R : ℕ) (hd : ∀ t, a < φ t → d t = 0)
    (g : (S → G) → ℝ) (hg : ∀ ω, 0 < g ω) (reads : S → Prop) [DecidablePred reads]
    (hfree : ∀ s, ¬ reads s → ∀ ω x, g (Function.update ω s x) = g ω)
    (hreads : ∀ t, φ t < a + R → ∀ x : Blk blk (blk t), ¬ reads x.1) :
    |gibbs W (fun ω => f ω * g ω) - gibbs W f * gibbs W g| ≤
      gibbs W g * ((∑ t, if ∃ x : Blk blk (blk t), reads x.1 then (1 : ℝ) else 0) * (∑ t, d t) * α ^ R / (1 - α)) := by
  have hW' : ∀ ω, 0 < g ω * W ω := fun ω => mul_pos (hg ω) (hW ω)
  have hZ := sum_W_pos W hW
  have hgpos : 0 < gibbs W g :=
    div_pos (sum_pos (fun ω _ => mul_pos (hW ω) (hg ω)) univ_nonempty) hZ
  have hne := hgpos.ne'
  have htilt : gibbs (fun ω => g ω * W ω) f = gibbs W (fun ω => f ω * g ω) / gibbs W g := by
    simp only [gibbs]
    have hnum : ∑ ω, g ω * W ω * f ω = ∑ ω, W ω * (f ω * g ω) := sum_congr rfl fun ω _ => by ring
    have hden : ∑ ω, g ω * W ω = ∑ ω, W ω * g ω := sum_congr rfl fun ω _ => by ring
    rw [hnum, hden, div_div_div_cancel_right₀ hZ.ne']
  have hcomp := comparison_level_blk W (fun ω => g ω * W ω) hW hW' blk C hC hCblk hCW α hα0 hα1 hrow φ hφ
    (fun b => if ∃ x : Blk blk b, reads x.1 then 1 else 0) (fun b => by split_ifs <;> norm_num)
    (discrep_tilt_blk W hW g hg blk reads hfree) f d hf a R hd
    (fun t ht => by
      have : ¬ ∃ x : Blk blk (blk t), reads x.1 := fun ⟨x, hx⟩ => hreads t ht x hx
      simp [this])
  rw [htilt] at hcomp
  have hkey : gibbs W (fun ω => f ω * g ω) - gibbs W f * gibbs W g =
      gibbs W g * (gibbs W (fun ω => f ω * g ω) / gibbs W g - gibbs W f) := by
    rw [mul_sub, mul_div_cancel₀ _ hne]
    ring
  rw [hkey, abs_mul, abs_of_pos hgpos]
  exact mul_le_mul_of_nonneg_left hcomp hgpos.le

end BlockSweep

end Aperanton
