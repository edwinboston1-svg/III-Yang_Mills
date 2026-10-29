/-
  APERANTON -- THE BOUNDLESS, stage W4's bridge (ADDENDUM I, THE ROAD): THE ε-FORM OF THE BETWEEN-SECTOR BOUND, AND
  THE BRIDGE LEMMAS B1 AND B2 FROM THE FOUR-TORUS'S DECIDED MASKS TO ITS CODES.

  THE ε-FORM (`mixture_between_le`): sector weights p summing to one, sector means F, G bounded by M, one sector h₀
  of weight at least 1 − ε: the between-sector term Σ_h p_h |F_h − F̄| |G_h − Ḡ| is at most 8M²ε.  With
  `mixture_cov_le` (Duality.lean) the connected correlation of the mixture is within 8M²ε of the mixture of the
  sectors' connected correlations; on the torus ε is the twisted sectors' total weight, O(y^{d}) by Theorem T,
  so T3's decay transfers through Wegner's duality with an error exponentially small in the twist area.

  B1 (`dot_vecOf`): the dot product of two mask vectors is the parity of the and of the masks -- the bit induction
  that connects `Torus4`'s kernel-decided parities to the codes' dot products.  B2 (`D_le_orth_K`, `sheets_mem_orth`):
  the boundary code lies in the plaquette code's dual and the six sheets lie in it, read off `dd_zero` and
  `sheets_cycle` through B1 and the orthogonality of a span (`mem_orth_span_iff`).  OWED, DESIGNED HERE: B3, the
  rank of a mask list as the finrank of its span -- by an echelon certificate (`EchelonCert`: a basis of distinct
  lowest-bit pivots whose subset-xors are injective, with two-way membership certificates between the basis and the
  generators, both decided), never by the algorithm's correctness; B4, the cardinality identity from B3 with
  `Module.card_eq_pow_finrank` and the dual-dimension formula on `dotForm`.  No sorry, no axiom, no native_decide.
-/
import Mathlib
import Aperanton.Duality
import Aperanton.Torus4

open Finset Matrix

namespace Aperanton

section EpsilonForm

variable {H : Type*} [Fintype H] [DecidableEq H]

/-- a convex combination of values bounded by M is bounded by M -/
theorem abs_mean_le (p X : H → ℝ) (hp0 : ∀ h, 0 ≤ p h) (hp : ∑ h, p h = 1) (M : ℝ)
    (hX : ∀ h, |X h| ≤ M) : |∑ k, p k * X k| ≤ M := by
  calc |∑ k, p k * X k| ≤ ∑ k, |p k * X k| := Finset.abs_sum_le_sum_abs _ _
    _ = ∑ k, p k * |X k| := by
        apply Finset.sum_congr rfl
        intro k _
        rw [abs_mul, abs_of_nonneg (hp0 k)]
    _ ≤ ∑ k, p k * M := by
        apply Finset.sum_le_sum
        intro k _
        exact mul_le_mul_of_nonneg_left (hX k) (hp0 k)
    _ = M := by rw [← Finset.sum_mul, hp, one_mul]

/-- the weight outside the dominant sector is at most ε -/
theorem rest_mass_le (p : H → ℝ) (hp : ∑ h, p h = 1) (h₀ : H) (ε : ℝ) (hε : 1 - ε ≤ p h₀) :
    ∑ h ∈ Finset.univ.erase h₀, p h ≤ ε := by
  have := Finset.add_sum_erase Finset.univ p (Finset.mem_univ h₀)
  rw [hp] at this
  linarith

/-- THE DOMINANT SECTOR'S DEVIATION FROM THE MEAN is at most 2Mε -/
theorem dominant_dev_le (p F : H → ℝ) (hp0 : ∀ h, 0 ≤ p h) (hp : ∑ h, p h = 1) (M : ℝ) (hM : 0 ≤ M)
    (hF : ∀ h, |F h| ≤ M) (h₀ : H) (ε : ℝ) (hε : 1 - ε ≤ p h₀) :
    |F h₀ - ∑ k, p k * F k| ≤ 2 * M * ε := by
  have h1 : F h₀ - ∑ k, p k * F k = ∑ k, p k * (F h₀ - F k) := by
    simp only [mul_sub, Finset.sum_sub_distrib, ← Finset.sum_mul, hp, one_mul]
  rw [h1]
  have hrest := rest_mass_le p hp h₀ ε hε
  calc |∑ k, p k * (F h₀ - F k)| ≤ ∑ k, |p k * (F h₀ - F k)| := Finset.abs_sum_le_sum_abs _ _
    _ = ∑ k, p k * |F h₀ - F k| := by
        apply Finset.sum_congr rfl
        intro k _
        rw [abs_mul, abs_of_nonneg (hp0 k)]
    _ = ∑ k ∈ Finset.univ.erase h₀, p k * |F h₀ - F k| := by
        rw [← Finset.add_sum_erase Finset.univ _ (Finset.mem_univ h₀)]
        simp
    _ ≤ ∑ k ∈ Finset.univ.erase h₀, p k * (2 * M) := by
        apply Finset.sum_le_sum
        intro k _
        apply mul_le_mul_of_nonneg_left _ (hp0 k)
        calc |F h₀ - F k| ≤ |F h₀| + |F k| := abs_sub _ _
          _ ≤ M + M := add_le_add (hF h₀) (hF k)
          _ = 2 * M := by ring
    _ = (∑ k ∈ Finset.univ.erase h₀, p k) * (2 * M) := by rw [Finset.sum_mul]
    _ ≤ ε * (2 * M) := mul_le_mul_of_nonneg_right hrest (by positivity)
    _ = 2 * M * ε := by ring

/-- THE ε-FORM: the between-sector term is at most 8M²ε when one sector carries weight at least 1 − ε -/
theorem mixture_between_le (p F G : H → ℝ) (hp0 : ∀ h, 0 ≤ p h) (hp : ∑ h, p h = 1) (M : ℝ) (hM : 0 ≤ M)
    (hF : ∀ h, |F h| ≤ M) (hG : ∀ h, |G h| ≤ M) (h₀ : H) (ε : ℝ) (hε0 : 0 ≤ ε) (hε : 1 - ε ≤ p h₀) :
    ∑ h, p h * (|F h - ∑ k, p k * F k| * |G h - ∑ k, p k * G k|) ≤ 8 * M ^ 2 * ε := by
  have hGb := abs_mean_le p G hp0 hp M hG
  have hFb := abs_mean_le p F hp0 hp M hF
  have hdevG : ∀ h, |G h - ∑ k, p k * G k| ≤ 2 * M := by
    intro h
    calc |G h - ∑ k, p k * G k| ≤ |G h| + |∑ k, p k * G k| := abs_sub _ _
      _ ≤ M + M := add_le_add (hG h) hGb
      _ = 2 * M := by ring
  have hdevF : ∀ h, |F h - ∑ k, p k * F k| ≤ 2 * M := by
    intro h
    calc |F h - ∑ k, p k * F k| ≤ |F h| + |∑ k, p k * F k| := abs_sub _ _
      _ ≤ M + M := add_le_add (hF h) hFb
      _ = 2 * M := by ring
  have hdom := dominant_dev_le p F hp0 hp M hM hF h₀ ε hε
  have hrest := rest_mass_le p hp h₀ ε hε
  have hp1 : p h₀ ≤ 1 := by
    rw [← hp]
    exact Finset.single_le_sum (fun h _ => hp0 h) (Finset.mem_univ h₀)
  calc ∑ h, p h * (|F h - ∑ k, p k * F k| * |G h - ∑ k, p k * G k|)
      ≤ ∑ h, p h * (|F h - ∑ k, p k * F k| * (2 * M)) := by
        apply Finset.sum_le_sum
        intro h _
        apply mul_le_mul_of_nonneg_left _ (hp0 h)
        exact mul_le_mul_of_nonneg_left (hdevG h) (abs_nonneg _)
    _ = p h₀ * (|F h₀ - ∑ k, p k * F k| * (2 * M))
          + ∑ h ∈ Finset.univ.erase h₀, p h * (|F h - ∑ k, p k * F k| * (2 * M)) := by
        rw [Finset.add_sum_erase Finset.univ (fun h => p h * (|F h - ∑ k, p k * F k| * (2 * M)))
          (Finset.mem_univ h₀)]
    _ ≤ 1 * ((2 * M * ε) * (2 * M)) + ∑ h ∈ Finset.univ.erase h₀, p h * ((2 * M) * (2 * M)) := by
        apply add_le_add
        · apply mul_le_mul hp1 _ (by positivity) (by norm_num)
          exact mul_le_mul_of_nonneg_right hdom (by positivity)
        · apply Finset.sum_le_sum
          intro h _
          apply mul_le_mul_of_nonneg_left _ (hp0 h)
          exact mul_le_mul_of_nonneg_right (hdevF h) (by positivity)
    _ = 4 * M ^ 2 * ε + (∑ h ∈ Finset.univ.erase h₀, p h) * (4 * M ^ 2) := by
        rw [Finset.sum_mul]
        congr 1
        · ring
        · apply Finset.sum_congr rfl
          intro h _
          ring
    _ ≤ 4 * M ^ 2 * ε + ε * (4 * M ^ 2) := by
        apply add_le_add (le_refl _)
        exact mul_le_mul_of_nonneg_right hrest (by positivity)
    _ = 8 * M ^ 2 * ε := by ring

end EpsilonForm

section BridgeB1

open Torus4

/-- the bit sum of a mask below k, in F₂, is its parity -/
theorem sum_testBit_eq_par (k m : ℕ) :
    (∑ i : Fin k, (if Nat.testBit m i.val then (1 : ZMod 2) else 0)) = if par k m then 1 else 0 := by
  induction k generalizing m with
  | zero => simp [par]
  | succ k ih =>
    rw [Fin.sum_univ_succ]
    simp only [Fin.val_zero, Fin.val_succ, Nat.testBit_succ]
    rw [ih (m / 2)]
    by_cases h1 : m % 2 = 1 <;> by_cases h2 : par k (m / 2) = true <;> simp [par, Nat.testBit_zero, h1, h2]
    all_goals decide

/-- B1: THE DOT PRODUCT OF MASK VECTORS IS THE PARITY OF THE AND -/
theorem dot_vecOf (a b : ℕ) : vecOf a ⬝ᵥ vecOf b = if parAnd a b then 1 else 0 := by
  unfold vecOf parAnd dotProduct
  have hpt : ∀ i : Fin nPlaq, (if Nat.testBit a i.val then (1 : ZMod 2) else 0)
      * (if Nat.testBit b i.val then (1 : ZMod 2) else 0)
      = if Nat.testBit (Nat.land a b) i.val then 1 else 0 := by
    intro i
    have hland : Nat.land a b = a &&& b := rfl
    rw [hland, Nat.testBit_land]
    cases Nat.testBit a i.val <;> cases Nat.testBit b i.val <;> simp
  simp_rw [hpt]
  exact sum_testBit_eq_par nPlaq (Nat.land a b)

end BridgeB1

section BridgeB2

open Torus4

/-- a vector is orthogonal to a span iff it is orthogonal to the generators -/
theorem mem_orth_span_iff {ι : Type*} [Fintype ι] [DecidableEq ι] (S : Set (ι → ZMod 2)) (u : ι → ZMod 2) :
    u ∈ orth (Submodule.span (ZMod 2) S) ↔ ∀ v ∈ S, v ⬝ᵥ u = 0 := by
  rw [mem_orth]
  constructor
  · intro h v hv
    exact h v (Submodule.subset_span hv)
  · intro h v hv
    induction hv using Submodule.span_induction with
    | mem x hx => exact h x hx
    | zero => exact zero_dotProduct u
    | add x y _ _ hx hy => rw [add_dotProduct, hx, hy, add_zero]
    | smul c x _ hx => rw [smul_dotProduct, hx, smul_zero]

/-- the parity of the and is symmetric -/
theorem parAnd_comm (a b : ℕ) : parAnd a b = parAnd b a := by
  unfold parAnd
  show par nPlaq (a &&& b) = par nPlaq (b &&& a)
  rw [Nat.land_comm]

/-- a decided `List.all` over the mask lists reads as a statement about every index -/
theorem parAnd_cube_cobd (k l : ℕ) (hk : k < nCubes) (hl : l < nLinks) :
    parAnd (cubeMask k) (cobdMask l) = false := by
  have h := dd_zero
  rw [List.all_eq_true] at h
  have hc : cubeMask k ∈ cubeMasks := List.mem_map.mpr ⟨k, List.mem_range.mpr hk, rfl⟩
  have h2 := h _ hc
  rw [List.all_eq_true] at h2
  have hl' : cobdMask l ∈ cobdMasks := List.mem_map.mpr ⟨l, List.mem_range.mpr hl, rfl⟩
  have h3 := h2 _ hl'
  simpa using h3

theorem parAnd_sheet_cobd (q l : ℕ) (hq : q < 6) (hl : l < nLinks) :
    parAnd (sheetMask q) (cobdMask l) = false := by
  have h := sheets_cycle
  rw [List.all_eq_true] at h
  have hs : sheetMask q ∈ sheetMasks := List.mem_map.mpr ⟨q, List.mem_range.mpr hq, rfl⟩
  have h2 := h _ hs
  rw [List.all_eq_true] at h2
  have hl' : cobdMask l ∈ cobdMasks := List.mem_map.mpr ⟨l, List.mem_range.mpr hl, rfl⟩
  have h3 := h2 _ hl'
  simpa using h3

/-- B2 (first half): THE BOUNDARY CODE LIES IN THE PLAQUETTE CODE'S DUAL -/
theorem D_le_orth_K : D ≤ orth K := by
  unfold D K
  rw [Submodule.span_le]
  rintro _ ⟨k, rfl⟩
  rw [SetLike.mem_coe, mem_orth_span_iff]
  rintro _ ⟨l, rfl⟩
  rw [dot_vecOf, parAnd_comm, parAnd_cube_cobd k.val l.val k.isLt l.isLt]
  simp

/-- B2 (second half): THE SIX SHEETS LIE IN THE PLAQUETTE CODE'S DUAL -/
theorem sheet_mem_orth_K (q : Fin 6) : vecOf (sheetMask q.val) ∈ orth K := by
  unfold K
  rw [mem_orth_span_iff]
  rintro _ ⟨l, rfl⟩
  rw [dot_vecOf, parAnd_comm, parAnd_sheet_cobd q.val l.val q.isLt l.isLt]
  simp

end BridgeB2

end Aperanton
