/-
  APERANTON -- THE BOUNDLESS, stage Β1 (ADDENDUM I, THE ROAD): THE SEPARATION THEOREM -- W(1) > 0 FALLS FOR
  FAITHFUL ACTIONS.

  The day's lattice theorem (Wilson.lean, `wilson_lattice_potential_gap`) bounds a Wilson loop's static potential by
  the sector's gap FOR LOOPS WITH W(1) > 0.  Here that hypothesis is discharged wherever the x-plaquette action's
  representation R is FAITHFUL, with no character theory: for a real orthogonal R the quadratic form of the Wilson
  kernel exp(β χ(ab⁻¹)) is the exponential series Σ_n (βⁿ/n!) Σ_P (Σ_a x_a ∏_i R.ρ(a)_{P i})² over index words P
  (`classMat_pow_eq_sum`, `quadratic_pow_eq_sum_sq`, `wilson_quadratic_hasSum`) -- the n-th power of the class
  Gram is the Gram of the n-th tensor power, written out entry by entry.  If the form vanishes every monomial
  moment vanishes (`moments_vanish`); a faithful R separates any two group elements by some matrix entry
  (`exists_separating_entry`), and the Lagrange product of separating factors, built by induction on a finite set
  of elements, is nonzero at a₀ and zero on the set while all its weighted moments vanish (`moment_lagrange_exists`),
  so every x_{a₀} = 0: THE WILSON KERNEL OF A FAITHFUL REPRESENTATION IS POSITIVE DEFINITE (`wilsonKernel_posDef`).
  Separation plus Gram is definiteness.  The sighted negative is a theorem: a non-faithful R has e_a − e_b in the
  kernel's null space (`wilsonKernel_not_posDef_of_not_injective`), so the hypothesis is physics, not caution -- the
  theory of a non-faithful action is the quotient group's, and a loop charged under the kernel averages to zero.
  The tensor kernel of a positive definite kernel is injective, its inverse the tensor kernel of the inverse
  (`tensorKernel_mulVec_injective`, from GapBound.lean's `tensorKernel_mul` and `tensorKernel_one`); the loop pair
  is not null when the loop's dimension is positive (`loop_pair_pos`, `classMat_diag`); hence W(1) > 0
  (`loop_W1_pos`) and THE COROLLARY `wilson_lattice_potential_gap_faithful`: the landed theorem's conclusion with
  the antecedent `0 < Σ_j ⟨F_j Ω, M F_j Ω⟩` gone and nothing else moved -- for faithful actions, every loop;
  otherwise, for loops with W(1) > 0.  The instance for concordance is Q₈ (the concurrent seat's group): its
  faithful four-dimensional real representation by left multiplication on ℍ in the basis (1, i, j, k), entries
  0 and ±1, is a homomorphism, unital, orthogonal and injective BY DECISION over ℤ (`q8RepZ_mul`, `q8RepZ_one`,
  `q8RepZ_orth`, `q8RepZ_injective`), cast to an `OrthRep` (`q8Rep`, `q8_faithful`).  W = 0: the separation
  argument is interpolation (Lagrange), the Gram identity is Schur's; the composition, the sighted negative and the
  decision are the build.  No sorry, no axiom, no native_decide.
-/
import Mathlib
import Aperanton.XTransfer
import Aperanton.GapBound
import Aperanton.GaugeAction
import Aperanton.LinearAction
import Aperanton.Schur
import Aperanton.Wilson

open Matrix Filter Topology

namespace Aperanton

section Separation

variable {G : Type*} [Group G] [Fintype G] [DecidableEq G] {d : ℕ}

/-- a monomial in the entries of the representation: the product over an index word -/
def monomial (R : OrthRep G d) (n : ℕ) (P : Fin n → Fin d × Fin d) (a : G) : ℝ :=
  ∏ i, R.ρ a (P i).1 (P i).2

theorem monomial_zero (R : OrthRep G d) (P : Fin 0 → Fin d × Fin d) (a : G) : monomial R 0 P a = 1 := by
  simp [monomial]

theorem monomial_succ (R : OrthRep G d) (n : ℕ) (p : Fin d × Fin d) (P : Fin n → Fin d × Fin d) (a : G) :
    monomial R (n + 1) (Fin.cons p P) a = R.ρ a p.1 p.2 * monomial R n P a := by
  simp [monomial, Fin.prod_univ_succ]

/-- the n-th power of the class matrix is the sum over index words of products of monomials: the Gram of the
n-th tensor power, entry by entry -/
theorem classMat_pow_eq_sum (R : OrthRep G d) (a b : G) (n : ℕ) :
    classMat R a b ^ n = ∑ P : Fin n → Fin d × Fin d, monomial R n P a * monomial R n P b := by
  rw [classMat_eq_gram, ← Fin.prod_const n]
  rw [Finset.prod_univ_sum (fun _ : Fin n => (Finset.univ : Finset (Fin d × Fin d)))]
  rw [Fintype.piFinset_univ]
  refine Finset.sum_congr rfl fun P _ => ?_
  simp only [monomial, Finset.prod_mul_distrib]

/-- the quadratic form of the n-th Schur power is a sum of squares of monomial moments -/
theorem quadratic_pow_eq_sum_sq (R : OrthRep G d) (x : G → ℝ) (n : ℕ) :
    ∑ a, ∑ b, x a * x b * classMat R a b ^ n =
      ∑ P : Fin n → Fin d × Fin d, (∑ a, x a * monomial R n P a) ^ 2 := by
  have h1 : ∀ P : Fin n → Fin d × Fin d, (∑ a, x a * monomial R n P a) ^ 2 =
      ∑ a, ∑ b, x a * x b * (monomial R n P a * monomial R n P b) := by
    intro P
    rw [sq, Finset.sum_mul_sum]
    refine Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => ?_
    ring
  simp_rw [h1, classMat_pow_eq_sum, Finset.mul_sum]
  conv_rhs => rw [Finset.sum_comm]
  refine Finset.sum_congr rfl fun a _ => ?_
  conv_rhs => rw [Finset.sum_comm]

/-- the quadratic form of the Wilson kernel is the exponential series of the Schur powers' forms -/
theorem wilson_quadratic_hasSum (R : OrthRep G d) (β : ℝ) (x : G → ℝ) :
    HasSum (fun n : ℕ => β ^ n / (Nat.factorial n : ℝ) * ∑ a, ∑ b, x a * x b * classMat R a b ^ n)
      (∑ a, ∑ b, x a * x b * linkKernel (wilsonW R β) a b) := by
  have hab : ∀ a b : G, HasSum (fun n : ℕ => x a * x b * ((β * classMat R a b) ^ n / (Nat.factorial n : ℝ)))
      (x a * x b * linkKernel (wilsonW R β) a b) := by
    intro a b
    have h := NormedSpace.expSeries_div_hasSum_exp (β * classMat R a b)
    rw [← Real.exp_eq_exp_ℝ] at h
    have hk : linkKernel (wilsonW R β) a b = Real.exp (β * classMat R a b) := rfl
    rw [hk]
    exact h.mul_left _
  have hsum := hasSum_sum (fun a (_ : a ∈ (Finset.univ : Finset G)) =>
    hasSum_sum (fun b (_ : b ∈ (Finset.univ : Finset G)) => hab a b))
  convert hsum using 1
  funext n
  rw [Finset.mul_sum]
  refine Finset.sum_congr rfl fun a _ => ?_
  rw [Finset.mul_sum]
  refine Finset.sum_congr rfl fun b _ => ?_
  rw [mul_pow]
  ring

/-- if the Wilson kernel's quadratic form vanishes at β > 0, every monomial moment vanishes -/
theorem moments_vanish (R : OrthRep G d) (β : ℝ) (hβ : 0 < β) (x : G → ℝ)
    (h0 : ∑ a, ∑ b, x a * x b * linkKernel (wilsonW R β) a b = 0) :
    ∀ (n : ℕ) (P : Fin n → Fin d × Fin d), ∑ a, x a * monomial R n P a = 0 := by
  intro n P
  have hs := wilson_quadratic_hasSum R β x
  rw [h0] at hs
  have hterm : ∀ m : ℕ, 0 ≤ β ^ m / (Nat.factorial m : ℝ) * ∑ a, ∑ b, x a * x b * classMat R a b ^ m := by
    intro m
    apply mul_nonneg (div_nonneg (pow_nonneg hβ.le m) (Nat.cast_nonneg _))
    rw [quadratic_pow_eq_sum_sq]
    exact Finset.sum_nonneg fun P _ => sq_nonneg _
  have hle : β ^ n / (Nat.factorial n : ℝ) * ∑ a, ∑ b, x a * x b * classMat R a b ^ n ≤ 0 :=
    le_hasSum hs n fun m _ => hterm m
  have heq : β ^ n / (Nat.factorial n : ℝ) * ∑ a, ∑ b, x a * x b * classMat R a b ^ n = 0 :=
    le_antisymm hle (hterm n)
  have hpos : 0 < β ^ n / (Nat.factorial n : ℝ) :=
    div_pos (pow_pos hβ n) (Nat.cast_pos.mpr (Nat.factorial_pos n))
  have hq : ∑ a, ∑ b, x a * x b * classMat R a b ^ n = 0 := by
    rcases mul_eq_zero.mp heq with h | h
    · exact absurd h hpos.ne'
    · exact h
  rw [quadratic_pow_eq_sum_sq] at hq
  have hP := (Finset.sum_eq_zero_iff_of_nonneg fun P _ => sq_nonneg (∑ a, x a * monomial R n P a)).mp hq P
    (Finset.mem_univ _)
  exact (pow_eq_zero_iff two_ne_zero).mp hP

/-- a faithful representation separates any two elements by some entry -/
theorem exists_separating_entry (R : OrthRep G d) (hR : Function.Injective R.ρ) {a b : G} (hab : a ≠ b) :
    ∃ p : Fin d × Fin d, R.ρ a p.1 p.2 ≠ R.ρ b p.1 p.2 := by
  by_contra h
  push_neg at h
  apply hab
  apply hR
  ext i j
  exact h (i, j)

/-- THE LAGRANGE STEP: a function nonzero at a₀, zero on a finite set not containing a₀, all of whose weighted
moments vanish -- built by induction on the set, one separating factor per element -/
theorem moment_lagrange_exists (R : OrthRep G d) (hR : Function.Injective R.ρ) (x : G → ℝ)
    (hmom : ∀ (n : ℕ) (P : Fin n → Fin d × Fin d), ∑ a, x a * monomial R n P a = 0)
    (a₀ : G) (s : Finset G) (hs : a₀ ∉ s) :
    ∃ f : G → ℝ, f a₀ ≠ 0 ∧ (∀ b ∈ s, f b = 0) ∧
      ∀ (n : ℕ) (P : Fin n → Fin d × Fin d), ∑ a, x a * (f a * monomial R n P a) = 0 := by
  induction s using Finset.induction_on with
  | empty =>
    refine ⟨fun _ => 1, one_ne_zero, fun b hb => absurd hb (Finset.notMem_empty b), fun n P => ?_⟩
    simpa using hmom n P
  | @insert b₀ s hb₀ ih =>
    have hs' : a₀ ∉ s := fun h => hs (Finset.mem_insert_of_mem h)
    have hne : a₀ ≠ b₀ := fun h => hs (h ▸ Finset.mem_insert_self b₀ s)
    obtain ⟨f, hf0, hfs, hfm⟩ := ih hs'
    obtain ⟨p, hp⟩ := exists_separating_entry R hR hne
    refine ⟨fun a => f a * (R.ρ a p.1 p.2 - R.ρ b₀ p.1 p.2), ?_, ?_, ?_⟩
    · exact mul_ne_zero hf0 (sub_ne_zero.mpr hp)
    · intro b hb
      rcases Finset.mem_insert.mp hb with rfl | hb'
      · simp
      · simp [hfs b hb']
    · intro n P
      have h1 := hfm (n + 1) (Fin.cons p P)
      have h2 := hfm n P
      simp only [monomial_succ] at h1
      calc ∑ a, x a * (f a * (R.ρ a p.1 p.2 - R.ρ b₀ p.1 p.2) * monomial R n P a)
          = ∑ a, (x a * (f a * (R.ρ a p.1 p.2 * monomial R n P a)) -
              R.ρ b₀ p.1 p.2 * (x a * (f a * monomial R n P a))) := by
            refine Finset.sum_congr rfl fun a _ => ?_
            ring
        _ = ∑ a, x a * (f a * (R.ρ a p.1 p.2 * monomial R n P a)) -
              R.ρ b₀ p.1 p.2 * ∑ a, x a * (f a * monomial R n P a) := by
            rw [Finset.sum_sub_distrib, Finset.mul_sum]
        _ = 0 := by rw [h1, h2]; ring

/-- THE SEPARATION THEOREM: the Wilson kernel of a FAITHFUL real orthogonal representation at β > 0 is positive
DEFINITE -- separation plus Gram, no character theory -/
theorem wilsonKernel_posDef (R : OrthRep G d) (hR : Function.Injective R.ρ) (β : ℝ) (hβ : 0 < β) :
    (linkKernel (wilsonW R β)).PosDef := by
  have hpsd := wilsonKernel_posSemidef R β hβ.le
  rw [hpsd.posDef_iff_mulVec_injective]
  intro x y hxy
  have hz : linkKernel (wilsonW R β) *ᵥ (x - y) = 0 := by rw [mulVec_sub, hxy, sub_self]
  suffices h : x - y = 0 from sub_eq_zero.mp h
  set v := x - y with hv
  have hq : ∑ a, ∑ b, v a * v b * linkKernel (wilsonW R β) a b = 0 := by
    calc ∑ a, ∑ b, v a * v b * linkKernel (wilsonW R β) a b
        = v ⬝ᵥ (linkKernel (wilsonW R β) *ᵥ v) := by
          simp only [dotProduct, mulVec, Finset.mul_sum]
          refine Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => ?_
          ring
      _ = 0 := by rw [hz, dotProduct_zero]
  have hmom := moments_vanish R β hβ v hq
  ext a₀
  show v a₀ = 0
  obtain ⟨f, hf0, hfs, hfm⟩ :=
    moment_lagrange_exists R hR v hmom a₀ (Finset.univ.erase a₀) (Finset.notMem_erase a₀ _)
  have h0 := hfm 0 (fun i => Fin.elim0 i)
  simp only [monomial_zero, mul_one] at h0
  rw [Finset.sum_eq_single a₀
    (fun b _ hb => by rw [hfs b (Finset.mem_erase.mpr ⟨hb, Finset.mem_univ b⟩), mul_zero])
    (fun h => absurd (Finset.mem_univ a₀) h)] at h0
  rcases mul_eq_zero.mp h0 with h | h
  · exact h
  · exact absurd h hf0

/-- THE SIGHTED NEGATIVE: a non-faithful representation's Wilson kernel is not positive definite -- the difference
of the indicators of a pair with equal images lies in its null space -/
theorem wilsonKernel_not_posDef_of_not_injective (R : OrthRep G d) (β : ℝ) {a b : G} (hab : a ≠ b)
    (h : R.ρ a = R.ρ b) : ¬ (linkKernel (wilsonW R β)).PosDef := by
  intro hpd
  have hinj := hpd.mulVec_injective
  have hcol : ∀ c, linkKernel (wilsonW R β) c a = linkKernel (wilsonW R β) c b := by
    intro c
    show Real.exp (β * classMat R c a) = Real.exp (β * classMat R c b)
    rw [classMat_eq_gram, classMat_eq_gram, h]
  have hz : linkKernel (wilsonW R β) *ᵥ (Pi.single a 1 - Pi.single b 1) = 0 := by
    rw [mulVec_sub]
    ext c
    have h1 : (linkKernel (wilsonW R β) *ᵥ Pi.single a (1 : ℝ)) c = linkKernel (wilsonW R β) c a := by
      simp [mulVec, dotProduct, Pi.single_apply]
    have h2 : (linkKernel (wilsonW R β) *ᵥ Pi.single b (1 : ℝ)) c = linkKernel (wilsonW R β) c b := by
      simp [mulVec, dotProduct, Pi.single_apply]
    simp only [Pi.sub_apply, Pi.zero_apply, h1, h2, hcol c, sub_self]
  have hv : (Pi.single a (1 : ℝ) - Pi.single b 1 : G → ℝ) = 0 := hinj (by rw [hz, mulVec_zero])
  have hva := congrFun hv a
  simp [Pi.single_apply, hab] at hva

end Separation

section Tensor

variable {G : Type*} [Group G] [Fintype G] [DecidableEq G] {L : Type*} [Fintype L] [DecidableEq L]

/-- THE TENSOR KERNEL OF A POSITIVE DEFINITE KERNEL IS INJECTIVE: its inverse is the tensor kernel of the inverse -/
theorem tensorKernel_mulVec_injective (k : Matrix G G ℝ) (hk : k.PosDef) :
    ∀ v : (L → G) → ℝ, (tensorKernel k : Matrix (L → G) (L → G) ℝ) *ᵥ v = 0 → v = 0 := by
  intro v hv
  have hu : IsUnit k.det := (Matrix.isUnit_iff_isUnit_det k).mp hk.isUnit
  have hinv : (tensorKernel k⁻¹ : Matrix (L → G) (L → G) ℝ) * tensorKernel k = 1 := by
    rw [tensorKernel_mul, nonsing_inv_mul k hu, tensorKernel_one]
  calc v = (1 : Matrix (L → G) (L → G) ℝ) *ᵥ v := (one_mulVec v).symm
    _ = (tensorKernel k⁻¹ * tensorKernel k) *ᵥ v := by rw [hinv]
    _ = tensorKernel k⁻¹ *ᵥ (tensorKernel k *ᵥ v) := (mulVec_mulVec v _ _).symm
    _ = 0 := by rw [hv, mulVec_zero]

end Tensor

section Loop

variable {G : Type*} [Group G] [Fintype G] [DecidableEq G] {L : Type*} [Fintype L] [DecidableEq L] {e : ℕ}

/-- the class matrix's diagonal is the representation's dimension -/
theorem classMat_diag (σ : OrthRep G e) (g : G) : classMat σ g g = e := by
  simp only [classMat, mul_inv_cancel, OrthRep.char, σ.map_one, Matrix.trace_one, Fintype.card_fin]

/-- THE LOOP PAIR IS NOT NULL: with a Gram factorisation of the loop's class matrix and a unit vector Ω, some
F_j Ω is nonzero once the loop's dimension is positive -/
theorem loop_pair_pos (σ : OrthRep G e) (he : 0 < e) (φ : G → G → ℝ)
    (hφ : ∀ x y, classMat σ x y = ∑ j, φ j x * φ j y) (h : (L → G) → G) (Ω : (L → G) → ℝ)
    (hn : Ω ⬝ᵥ Ω = 1) : ∃ j, diagonal (fun c => φ j (h c)) *ᵥ Ω ≠ 0 := by
  by_contra hall
  push_neg at hall
  have hzero : ∀ c, Ω c = 0 := by
    intro c
    have hsum : ∑ j, φ j (h c) * φ j (h c) * (Ω c * Ω c) = 0 := by
      refine Finset.sum_eq_zero fun j _ => ?_
      have hjc := congrFun (hall j) c
      rw [mulVec_diagonal] at hjc
      simp only [Pi.zero_apply] at hjc
      calc φ j (h c) * φ j (h c) * (Ω c * Ω c) = (φ j (h c) * Ω c) * (φ j (h c) * Ω c) := by ring
        _ = 0 := by rw [hjc, mul_zero]
    rw [← Finset.sum_mul, ← hφ, classMat_diag] at hsum
    rcases mul_eq_zero.mp hsum with h0 | h0
    · exact absurd h0 (by exact_mod_cast he.ne')
    · exact mul_self_eq_zero.mp h0
  have hdot : Ω ⬝ᵥ Ω = 0 := by simp [dotProduct, hzero]
  rw [hdot] at hn
  exact zero_ne_one hn

end Loop

section Faithful

variable {G : Type*} [Group G] [Fintype G] [DecidableEq G] {V L : Type*} [DecidableEq V] [Fintype L]
  [DecidableEq L]

/-- W(1) > 0 FOR A FAITHFUL ACTION: the loop pair's form under the transfer matrix is positive -/
theorem loop_W1_pos {d d' e : ℕ} (Λ : Lat V L) {ι : Type*} [Fintype ι] (sq : ι → Square Λ)
    (R' : OrthRep G d') (β' : ℝ) (R : OrthRep G d) (hR : Function.Injective R.ρ) (β : ℝ) (hβ : 0 < β)
    (σ : OrthRep G e) (he : 0 < e) (φ : G → G → ℝ) (hφ : ∀ x y, classMat σ x y = ∑ j, φ j x * φ j y)
    (h : (L → G) → G) (Ω : (L → G) → ℝ) (hn : Ω ⬝ᵥ Ω = 1) :
    0 < ∑ j, (diagonal (fun c => φ j (h c)) *ᵥ Ω) ⬝ᵥ
        (transfer (plaqWeight sq (wilsonW R' β')) (tensorKernel (linkKernel (wilsonW R β))) *ᵥ
          (diagonal (fun c => φ j (h c)) *ᵥ Ω)) := by
  obtain ⟨j₀, hj₀⟩ := loop_pair_pos σ he φ hφ h Ω hn
  have hK : (tensorKernel (linkKernel (wilsonW R β)) : Matrix (L → G) (L → G) ℝ).PosSemidef :=
    tensorKernel_posSemidef _ (wilsonKernel_posSemidef R β hβ.le)
  have hKinj := tensorKernel_mulVec_injective (L := L) (linkKernel (wilsonW R β)) (wilsonKernel_posDef R hR β hβ)
  have hD : ∀ c, 0 < plaqWeight sq (wilsonW R' β') c := fun c => plaqWeight_pos sq _ (wilsonW_pos R' β') c
  apply Finset.sum_pos'
  · intro j _
    simpa using (transfer_posSemidef _ _ hK).dotProduct_mulVec_nonneg (diagonal (fun c => φ j (h c)) *ᵥ Ω)
  · exact ⟨j₀, Finset.mem_univ _, dot_transfer_pos _ hD _ hK hKinj _ hj₀⟩

/-- THE LATTICE THEOREM FOR A FAITHFUL WILSON ACTION, UNCONDITIONAL: the landed theorem's conclusion with the
antecedent `0 < Σ_j ⟨F_j Ω, M F_j Ω⟩` discharged by the separation theorem -- for faithful actions, every loop
of positive dimension with no invariant vector has static potential strictly positive and at least the sector's
gap; the faithfulness is the x-plaquette action's representation R, not the loop's -/
theorem wilson_lattice_potential_gap_faithful {d d' e : ℕ} (Λ : Lat V L) {ι : Type*} [Fintype ι]
    (sq : ι → Square Λ) (R' : OrthRep G d') (β' : ℝ) (R : OrthRep G d) (hR : Function.Injective R.ρ)
    (β : ℝ) (hβ : 0 < β) (σ : OrthRep G e) (he : 0 < e)
    (hσ : ∀ u : Fin e → ℝ, (∀ h, σ.ρ h *ᵥ u = u) → u = 0)
    (ℓ₀ : L) (rest : List L) (v : V) (hsrc : Λ.src ℓ₀ = v) (htgt0 : Λ.tgt ℓ₀ ≠ v)
    (hsrc' : ∀ ℓ ∈ rest, Λ.src ℓ ≠ v) (htgt' : ∀ ℓ ∈ rest, Λ.tgt ℓ ≠ v) :
    ∃ φ : G → G → ℝ, (∀ x y, classMat σ x y = ∑ j, φ j x * φ j y) ∧
      ∀ Ω : (L → G) → ℝ,
        transfer (plaqWeight sq (wilsonW R' β')) (tensorKernel (linkKernel (wilsonW R β))) *ᵥ Ω =
          lamMax (transfer (plaqWeight sq (wilsonW R' β')) (tensorKernel (linkKernel (wilsonW R β))))
            (transfer_posSemidef (plaqWeight sq (wilsonW R' β')) _
              (tensorKernel_posSemidef (linkKernel (wilsonW R β)) (wilsonKernel_posSemidef R β hβ.le))).1 • Ω →
        Ω ⬝ᵥ Ω = 1 →
        (∀ Rr : ℕ, Tendsto (fun a : ℕ =>
            slabLoop (plaqWeight sq (wilsonW R' β')) (tensorKernel (linkKernel (wilsonW R β)))
              (fun c c' => classMat σ (lineHol (ℓ₀ :: rest) c) (lineHol (ℓ₀ :: rest) c')) a Rr /
            slabZ (plaqWeight sq (wilsonW R' β')) (tensorKernel (linkKernel (wilsonW R β))) (a + 1) Rr)
          atTop
          (𝓝 (∑ j, (diagonal (fun c => φ j (lineHol (ℓ₀ :: rest) c)) *ᵥ Ω) ⬝ᵥ
              (transfer (plaqWeight sq (wilsonW R' β')) (tensorKernel (linkKernel (wilsonW R β))) ^ Rr *ᵥ
                (diagonal (fun c => φ j (lineHol (ℓ₀ :: rest) c)) *ᵥ Ω)) /
            lamMax (transfer (plaqWeight sq (wilsonW R' β')) (tensorKernel (linkKernel (wilsonW R β))))
              (transfer_posSemidef (plaqWeight sq (wilsonW R' β')) _
                (tensorKernel_posSemidef (linkKernel (wilsonW R β)) (wilsonKernel_posSemidef R β hβ.le))).1 ^ Rr))) ∧
        ∃ s : ℝ, 0 < s ∧ Tendsto (fun Rr : ℕ =>
            Real.log (lamMax (transfer (plaqWeight sq (wilsonW R' β')) (tensorKernel (linkKernel (wilsonW R β))))
              (transfer_posSemidef (plaqWeight sq (wilsonW R' β')) _
                (tensorKernel_posSemidef (linkKernel (wilsonW R β)) (wilsonKernel_posSemidef R β hβ.le))).1) -
            Real.log (∑ j, (diagonal (fun c => φ j (lineHol (ℓ₀ :: rest) c)) *ᵥ Ω) ⬝ᵥ
              (transfer (plaqWeight sq (wilsonW R' β')) (tensorKernel (linkKernel (wilsonW R β))) ^ Rr *ᵥ
                (diagonal (fun c => φ j (lineHol (ℓ₀ :: rest) c)) *ᵥ Ω))) / Rr) atTop (𝓝 s) := by
  obtain ⟨φ, hφ, H⟩ :=
    wilson_lattice_potential_gap Λ sq R' β' R β hβ.le σ hσ ℓ₀ rest v hsrc htgt0 hsrc' htgt'
  refine ⟨φ, hφ, fun Ω hΩ hn => ?_⟩
  obtain ⟨h1, h2⟩ := H Ω hΩ hn
  exact ⟨h1, h2 (loop_W1_pos Λ sq R' β' R hR β hβ σ he φ hφ _ Ω hn)⟩

end Faithful

section Q8

/-- left multiplication by i on ℍ = ℝ⁴ in the basis (1, i, j, k), as an integer matrix -/
def q8I : Matrix (Fin 4) (Fin 4) ℤ := !![0, -1, 0, 0; 1, 0, 0, 0; 0, 0, 0, -1; 0, 0, 1, 0]

/-- left multiplication by j -/
def q8J : Matrix (Fin 4) (Fin 4) ℤ := !![0, 0, -1, 0; 0, 0, 0, 1; 1, 0, 0, 0; 0, -1, 0, 0]

/-- the quaternion group Q₈ = QuaternionGroup 2 on ℍ: a k ↦ L(i)^k, xa k ↦ L(j) L(i)^k -/
def q8RepZ : QuaternionGroup 2 → Matrix (Fin 4) (Fin 4) ℤ
  | QuaternionGroup.a k => q8I ^ k.val
  | QuaternionGroup.xa k => q8J * q8I ^ k.val

theorem q8RepZ_mul : ∀ x y : QuaternionGroup 2, q8RepZ (x * y) = q8RepZ x * q8RepZ y := by decide

theorem q8RepZ_one : q8RepZ 1 = 1 := by decide

theorem q8RepZ_orth : ∀ x : QuaternionGroup 2, q8RepZ x * (q8RepZ x)ᵀ = 1 := by decide

theorem q8RepZ_injective : Function.Injective q8RepZ := by decide

/-- Q₈'s four-dimensional real representation, cast from the integer one -/
noncomputable def q8Rep : OrthRep (QuaternionGroup 2) 4 where
  ρ g := (q8RepZ g).map (Int.castRingHom ℝ)
  map_mul _ _ := by rw [q8RepZ_mul, Matrix.map_mul]
  map_one := by rw [q8RepZ_one]; exact Matrix.map_one _ (by simp) (by simp)
  orth a := by
    rw [← Matrix.transpose_map, ← Matrix.map_mul, q8RepZ_orth]; exact Matrix.map_one _ (by simp) (by simp)

/-- THE INSTANCE FOR CONCORDANCE: Q₈'s representation is faithful, decided -/
theorem q8_faithful : Function.Injective q8Rep.ρ := fun a b h =>
  q8RepZ_injective (Matrix.map_injective Int.cast_injective h)

end Q8

end Aperanton
