/-
  APERANTON -- THE BOUNDLESS, stage Β3's coefficient (ADDENDUM I, THE ROAD, W2): THE ROW SUM OF A FACTOR SYSTEM'S
  INTERDEPENDENCE MATRIX AS A COUNT OF INCIDENCES, AND THE SLAB'S EXPLICIT α.

  THE ABSTRACT LAW (`rowsum_interdepMat_le`): for any factor system and any site s,
      Σ_t C(s, t) ≤ Σ_{i reading s} (|sites i| − 1) · (1 − (lo_i/hi_i)²),
  because C(s, t) = 1 − Π_{i reading s and t} (lo_i/hi_i)² and 1 − Π a_i ≤ Σ (1 − a_i) for a_i ∈ [0, 1]
  (`one_sub_prod_le_sum_one_sub`), then the double sum over (t, i) is counted factor by factor.  THE SLAB
  (`slab_rowsum_le`): a site (x, ℓ) of the slab is read by the plaquette factors of the squares containing ℓ at
  level x -- at most m of them, m the degree of the cross-section's square system (2(d − 2) on the cubic lattice),
  each reading three other sites -- and by at most two link factors, each reading one other site; so
      Σ_t C(s, t) ≤ 3m · (1 − (wlo/whi)²) + 2 · (1 − (klo/khi)²).
  For the Z₂ Wilson slab (wlo = klo = y = e^{−2β}, whi = khi = 1, m = 2(d − 2)) this is (6d − 10)(1 − y²), below one
  iff y² > (6d − 11)/(6d − 10): β < ¼ ln(8/7) = 0.0334 at d = 3, β < ¼ ln(14/13) = 0.0185 at d = 4 -- the generic
  ratio coefficient, already wider than the LGT kernel's 1/(32n(d−1)) (0.0156 at d = 3, 0.0104 at d = 4) and the
  coefficient `transfer_gap_explicit` carries.  The per-site coefficient (`Z2Slab.lean`, `transfer_gap_sharp`:
  α = (3m + 2)(1 − y)/(1 + y), below one iff y > (3m + 1)/(3m + 3) -- β < 0.1257 at d = 3, 0.0716 at d = 4) is wired
  through `Slab.lean`'s theorems generalised to an arbitrary interdependence matrix.  No sorry, no axiom, no native_decide.
-/
import Mathlib
import Aperanton.Slab

open Finset

namespace Aperanton

section OneSubProd

/-- 1 − Π aᵢ ≤ Σ (1 − aᵢ) for aᵢ ∈ [0, 1] -/
theorem one_sub_prod_le_sum_one_sub {ι : Type*} [DecidableEq ι] (s : Finset ι) (a : ι → ℝ)
    (h0 : ∀ i ∈ s, 0 ≤ a i) (h1 : ∀ i ∈ s, a i ≤ 1) :
    1 - ∏ i ∈ s, a i ≤ ∑ i ∈ s, (1 - a i) := by
  induction s using Finset.induction_on with
  | empty => simp
  | @insert j s hj ih =>
    rw [Finset.prod_insert hj, Finset.sum_insert hj]
    have h0' : ∀ i ∈ s, 0 ≤ a i := fun i hi => h0 i (Finset.mem_insert_of_mem hi)
    have h1' : ∀ i ∈ s, a i ≤ 1 := fun i hi => h1 i (Finset.mem_insert_of_mem hi)
    have ih' := ih h0' h1'
    have hP0 : 0 ≤ ∏ i ∈ s, a i := Finset.prod_nonneg h0'
    have hP1 : ∏ i ∈ s, a i ≤ 1 := Finset.prod_le_one₀ h0' h1'
    have haj0 := h0 j (Finset.mem_insert_self j s)
    have haj1 := h1 j (Finset.mem_insert_self j s)
    nlinarith [mul_nonneg (sub_nonneg.mpr haj1) (sub_nonneg.mpr hP1)]

end OneSubProd

section Rowsum

variable {S : Type*} [Fintype S] [DecidableEq S] {G : Type*} [Fintype G] [DecidableEq G] [Nonempty G]
  {ι : Type*} [Fintype ι] [DecidableEq ι]

variable (F : FactorSystem S G ι)

/-- the inverse square of ρ is the product of the squared lower-to-upper ratios over the shared factors -/
theorem inv_rho_sq (s t : S) :
    1 / rho F s t ^ 2 = ∏ i ∈ (touch F s).filter (fun i => t ∈ F.sites i), (F.lo i / F.hi i) ^ 2 := by
  unfold rho
  rw [← Finset.prod_pow, one_div, ← Finset.prod_inv_distrib]
  apply Finset.prod_congr rfl
  intro i _
  rw [div_pow, div_pow, inv_div]

/-- each off-diagonal entry is at most the sum over the shared factors of 1 − (lo/hi)² -/
theorem interdepMat_le_sum (s t : S) (hst : s ≠ t) :
    interdepMat F s t ≤ ∑ i ∈ (touch F s).filter (fun i => t ∈ F.sites i), (1 - (F.lo i / F.hi i) ^ 2) := by
  unfold interdepMat
  rw [if_neg hst, inv_rho_sq]
  apply one_sub_prod_le_sum_one_sub
  · intro i _
    exact sq_nonneg _
  · intro i _
    have hlo := F.lo_pos i
    have hhi := hi_pos F i
    have hle : F.lo i ≤ F.hi i := le_trans (F.w_lo i (Classical.arbitrary _)) (F.w_hi i (Classical.arbitrary _))
    have hdiv : F.lo i / F.hi i ≤ 1 := by rw [div_le_one hhi]; exact hle
    have hdiv0 : 0 ≤ F.lo i / F.hi i := div_nonneg hlo.le hhi.le
    nlinarith

/-- THE ROW-SUM LAW: Σ_t C(s, t) ≤ Σ_{i reading s} (|sites i| − 1)(1 − (lo_i/hi_i)²) -/
theorem rowsum_interdepMat_le (s : S) :
    ∑ t, interdepMat F s t
      ≤ ∑ i ∈ touch F s, (((F.sites i).erase s).card : ℝ) * (1 - (F.lo i / F.hi i) ^ 2) := by
  have hdiag : interdepMat F s s = 0 := by unfold interdepMat; simp
  rw [← Finset.add_sum_erase Finset.univ _ (Finset.mem_univ s), hdiag, zero_add]
  calc ∑ t ∈ Finset.univ.erase s, interdepMat F s t
      ≤ ∑ t ∈ Finset.univ.erase s, ∑ i ∈ (touch F s).filter (fun i => t ∈ F.sites i), (1 - (F.lo i / F.hi i) ^ 2) := by
        apply Finset.sum_le_sum
        intro t ht
        exact interdepMat_le_sum F s t (Finset.ne_of_mem_erase ht).symm
    _ = ∑ t ∈ Finset.univ.erase s, ∑ i ∈ touch F s, (if t ∈ F.sites i then (1 - (F.lo i / F.hi i) ^ 2) else 0) := by
        apply Finset.sum_congr rfl
        intro t _
        rw [Finset.sum_filter]
    _ = ∑ i ∈ touch F s, ∑ t ∈ Finset.univ.erase s, (if t ∈ F.sites i then (1 - (F.lo i / F.hi i) ^ 2) else 0) :=
        Finset.sum_comm
    _ = ∑ i ∈ touch F s, (((F.sites i).erase s).card : ℝ) * (1 - (F.lo i / F.hi i) ^ 2) := by
        apply Finset.sum_congr rfl
        intro i _
        rw [← Finset.sum_filter, Finset.sum_const, nsmul_eq_mul]
        congr 3
        ext t
        simp only [Finset.mem_filter, Finset.mem_erase, Finset.mem_univ, true_and]
        tauto

end Rowsum

section SlabRowsum

variable {G : Type*} [Group G] [Fintype G] [DecidableEq G] {V Lk : Type*} [DecidableEq V] [Fintype Lk]
  [DecidableEq Lk] {Λ : Lat V Lk} {ι : Type*} [Fintype ι] [DecidableEq ι]
  (sq : ι → Square Λ) (w' : G → ℝ) (wlo whi : ℝ) (hwlo : 0 < wlo) (hw'lo : ∀ g, wlo ≤ w' g)
  (hw'hi : ∀ g, w' g ≤ whi) (k : Matrix G G ℝ) (klo khi : ℝ) (hklo : 0 < klo) (hk_lo : ∀ a b, klo ≤ k a b)
  (hk_hi : ∀ a b, k a b ≤ khi) (T : ℕ)

/-- the degree of a link in the square system: the number of squares containing it -/
def linkDegree (ℓ : Lk) : ℕ := (Finset.univ.filter (fun i => ℓ ∈ squareLinks (sq i))).card

/-- at most two link factors read a level: the one below and the one above -/
theorem card_levels_le_two (x : Fin (T + 1)) :
    (Finset.univ.filter (fun x' : Fin T => x = x'.castSucc ∨ x = x'.succ)).card ≤ 2 := by
  have hsub : Finset.univ.filter (fun x' : Fin T => x = x'.castSucc ∨ x = x'.succ)
      ⊆ Finset.univ.filter (fun x' : Fin T => x'.val = x.val) ∪ Finset.univ.filter (fun x' : Fin T => x'.val + 1 = x.val) := by
    intro x' hx'
    simp only [Finset.mem_filter, Finset.mem_univ, true_and, Finset.mem_union] at hx' ⊢
    rcases hx' with h | h
    · left; rw [h]; rfl
    · right; rw [h]; rfl
  calc _ ≤ (Finset.univ.filter (fun x' : Fin T => x'.val = x.val) ∪ Finset.univ.filter (fun x' : Fin T => x'.val + 1 = x.val)).card :=
        Finset.card_le_card hsub
    _ ≤ (Finset.univ.filter (fun x' : Fin T => x'.val = x.val)).card
          + (Finset.univ.filter (fun x' : Fin T => x'.val + 1 = x.val)).card := Finset.card_union_le _ _
    _ ≤ 1 + 1 := by
        apply add_le_add
        · apply Finset.card_le_one.mpr
          intro a ha b hb
          simp only [Finset.mem_filter, Finset.mem_univ, true_and] at ha hb
          exact Fin.ext (ha.trans hb.symm)
        · apply Finset.card_le_one.mpr
          intro a ha b hb
          simp only [Finset.mem_filter, Finset.mem_univ, true_and] at ha hb
          exact Fin.ext (by omega)

/-- THE SLAB'S ROW SUM: at most 3m(1 − (wlo/whi)²) + 2(1 − (klo/khi)²), m the largest link degree -/
theorem slab_rowsum_le (m : ℕ) (hm : ∀ ℓ, linkDegree sq ℓ ≤ m) (hwhi : 0 < whi) (hkhi : 0 < khi)
    (s : Fin (T + 1) × Lk) :
    ∑ t, interdepMat (slabFactors sq w' wlo whi hwlo hw'lo hw'hi k klo khi hklo hk_lo hk_hi T) s t
      ≤ 3 * m * (1 - (wlo / whi) ^ 2) + 2 * (1 - (klo / khi) ^ 2) := by
  set F := slabFactors sq w' wlo whi hwlo hw'lo hw'hi k klo khi hklo hk_lo hk_hi T with hF
  obtain ⟨x, ℓ⟩ := s
  refine le_trans (rowsum_interdepMat_le F (x, ℓ)) ?_
  -- the bounds on the two kinds of factor
  have hw0 : 0 ≤ 1 - (wlo / whi) ^ 2 := by
    have : wlo ≤ whi := le_trans (hw'lo (Classical.arbitrary _)) (hw'hi (Classical.arbitrary _))
    have h1 : wlo / whi ≤ 1 := by rw [div_le_one hwhi]; exact this
    have h0 : 0 ≤ wlo / whi := div_nonneg hwlo.le hwhi.le
    nlinarith
  have hk0 : 0 ≤ 1 - (klo / khi) ^ 2 := by
    have : klo ≤ khi := le_trans (hk_lo (Classical.arbitrary _) (Classical.arbitrary _))
      (hk_hi (Classical.arbitrary _) (Classical.arbitrary _))
    have h1 : klo / khi ≤ 1 := by rw [div_le_one hkhi]; exact this
    have h0 : 0 ≤ klo / khi := div_nonneg hklo.le hkhi.le
    nlinarith
  -- the factors reading (x, ℓ), as an indicator sum over every factor, split by kind
  unfold touch
  rw [Finset.sum_filter, Fintype.sum_sum_type]
  -- the plaquette factors: those of the squares containing ℓ at the level x, each reading three other sites
  have hinl : ∑ i : Fin (T + 1) × ι, (if (x, ℓ) ∈ F.sites (Sum.inl i) then
        (((F.sites (Sum.inl i)).erase (x, ℓ)).card : ℝ) * (1 - (F.lo (Sum.inl i) / F.hi (Sum.inl i)) ^ 2) else 0)
      ≤ 3 * m * (1 - (wlo / whi) ^ 2) := by
    have hterm : ∀ i : Fin (T + 1) × ι, (if (x, ℓ) ∈ F.sites (Sum.inl i) then
        (((F.sites (Sum.inl i)).erase (x, ℓ)).card : ℝ) * (1 - (F.lo (Sum.inl i) / F.hi (Sum.inl i)) ^ 2) else 0)
        ≤ if i.1 = x ∧ ℓ ∈ squareLinks (sq i.2) then 3 * (1 - (wlo / whi) ^ 2) else 0 := by
      rintro ⟨x', j⟩
      have hmem : (x, ℓ) ∈ F.sites (Sum.inl (x', j)) ↔ x' = x ∧ ℓ ∈ squareLinks (sq j) := by
        show (x, ℓ) ∈ (squareLinks (sq j)).image (fun ℓ' => (x', ℓ')) ↔ _
        simp only [Finset.mem_image, Prod.mk.injEq]
        constructor
        · rintro ⟨ℓ', hℓ', rfl, rfl⟩
          exact ⟨rfl, hℓ'⟩
        · rintro ⟨rfl, hℓ⟩
          exact ⟨ℓ, hℓ, rfl, rfl⟩
      by_cases hP : x' = x ∧ ℓ ∈ squareLinks (sq j)
      · rw [if_pos (hmem.mpr hP), if_pos hP]
        have hcard : (((F.sites (Sum.inl (x', j))).erase (x, ℓ)).card : ℝ) ≤ 3 := by
          have h2 : (F.sites (Sum.inl (x', j))).card ≤ 4 := by
            show ((squareLinks (sq j)).image (fun ℓ' => (x', ℓ'))).card ≤ 4
            refine le_trans Finset.card_image_le ?_
            unfold squareLinks
            refine le_trans (Finset.card_insert_le _ _) ?_
            refine Nat.succ_le_succ (le_trans (Finset.card_insert_le _ _) ?_)
            refine Nat.succ_le_succ (le_trans (Finset.card_insert_le _ _) ?_)
            rw [Finset.card_singleton]
          rw [Finset.card_erase_of_mem (hmem.mpr hP)]
          exact_mod_cast (by omega : (F.sites (Sum.inl (x', j))).card - 1 ≤ 3)
        show (((F.sites (Sum.inl (x', j))).erase (x, ℓ)).card : ℝ) * (1 - (wlo / whi) ^ 2)
          ≤ 3 * (1 - (wlo / whi) ^ 2)
        exact mul_le_mul_of_nonneg_right hcard hw0
      · rw [if_neg (fun h => hP (hmem.mp h)), if_neg hP]
    calc _ ≤ ∑ i : Fin (T + 1) × ι, (if i.1 = x ∧ ℓ ∈ squareLinks (sq i.2) then 3 * (1 - (wlo / whi) ^ 2) else 0) :=
          Finset.sum_le_sum (fun i _ => hterm i)
      _ = ∑ j : ι, (if ℓ ∈ squareLinks (sq j) then 3 * (1 - (wlo / whi) ^ 2) else 0) := by
          rw [Fintype.sum_prod_type, Finset.sum_comm]
          apply Finset.sum_congr rfl
          intro j _
          simp_rw [ite_and]
          rw [Finset.sum_ite_eq']
          simp
      _ = (linkDegree sq ℓ : ℝ) * (3 * (1 - (wlo / whi) ^ 2)) := by
          rw [← Finset.sum_filter, Finset.sum_const, nsmul_eq_mul]
          rfl
      _ ≤ (m : ℝ) * (3 * (1 - (wlo / whi) ^ 2)) := by
          apply mul_le_mul_of_nonneg_right _ (by positivity)
          exact_mod_cast hm ℓ
      _ = 3 * m * (1 - (wlo / whi) ^ 2) := by ring
  -- the link factors: the one below and the one above, each reading one other site
  have hinr : ∑ i : Fin T × Lk, (if (x, ℓ) ∈ F.sites (Sum.inr i) then
        (((F.sites (Sum.inr i)).erase (x, ℓ)).card : ℝ) * (1 - (F.lo (Sum.inr i) / F.hi (Sum.inr i)) ^ 2) else 0)
      ≤ 2 * (1 - (klo / khi) ^ 2) := by
    have hterm : ∀ i : Fin T × Lk, (if (x, ℓ) ∈ F.sites (Sum.inr i) then
        (((F.sites (Sum.inr i)).erase (x, ℓ)).card : ℝ) * (1 - (F.lo (Sum.inr i) / F.hi (Sum.inr i)) ^ 2) else 0)
        ≤ if i.2 = ℓ ∧ (x = i.1.castSucc ∨ x = i.1.succ) then (1 - (klo / khi) ^ 2) else 0 := by
      rintro ⟨x', ℓ'⟩
      have hmem : (x, ℓ) ∈ F.sites (Sum.inr (x', ℓ')) ↔ ℓ' = ℓ ∧ (x = x'.castSucc ∨ x = x'.succ) := by
        show (x, ℓ) ∈ ({(x'.castSucc, ℓ'), (x'.succ, ℓ')} : Finset (Fin (T + 1) × Lk)) ↔ _
        simp only [Finset.mem_insert, Finset.mem_singleton, Prod.mk.injEq]
        constructor
        · rintro (⟨h1, h2⟩ | ⟨h1, h2⟩)
          · exact ⟨h2.symm, Or.inl h1⟩
          · exact ⟨h2.symm, Or.inr h1⟩
        · rintro ⟨rfl, h | h⟩
          · exact Or.inl ⟨h, rfl⟩
          · exact Or.inr ⟨h, rfl⟩
      by_cases hP : ℓ' = ℓ ∧ (x = x'.castSucc ∨ x = x'.succ)
      · rw [if_pos (hmem.mpr hP), if_pos hP]
        have hcard : (((F.sites (Sum.inr (x', ℓ'))).erase (x, ℓ)).card : ℝ) ≤ 1 := by
          have h2 : (F.sites (Sum.inr (x', ℓ'))).card ≤ 2 := by
            show ({(x'.castSucc, ℓ'), (x'.succ, ℓ')} : Finset (Fin (T + 1) × Lk)).card ≤ 2
            refine le_trans (Finset.card_insert_le _ _) ?_
            rw [Finset.card_singleton]
          rw [Finset.card_erase_of_mem (hmem.mpr hP)]
          exact_mod_cast (by omega : (F.sites (Sum.inr (x', ℓ'))).card - 1 ≤ 1)
        show (((F.sites (Sum.inr (x', ℓ'))).erase (x, ℓ)).card : ℝ) * (1 - (klo / khi) ^ 2)
          ≤ 1 - (klo / khi) ^ 2
        calc _ ≤ 1 * (1 - (klo / khi) ^ 2) := mul_le_mul_of_nonneg_right hcard hk0
          _ = _ := one_mul _
      · rw [if_neg (fun h => hP (hmem.mp h)), if_neg hP]
    calc _ ≤ ∑ i : Fin T × Lk, (if i.2 = ℓ ∧ (x = i.1.castSucc ∨ x = i.1.succ) then (1 - (klo / khi) ^ 2) else 0) :=
          Finset.sum_le_sum (fun i _ => hterm i)
      _ = ∑ x' : Fin T, (if x = x'.castSucc ∨ x = x'.succ then (1 - (klo / khi) ^ 2) else 0) := by
          rw [Fintype.sum_prod_type]
          apply Finset.sum_congr rfl
          intro x' _
          simp_rw [ite_and]
          rw [Finset.sum_ite_eq']
          simp
      _ = ((Finset.univ.filter (fun x' : Fin T => x = x'.castSucc ∨ x = x'.succ)).card : ℝ)
            * (1 - (klo / khi) ^ 2) := by
          rw [← Finset.sum_filter, Finset.sum_const, nsmul_eq_mul]
      _ ≤ 2 * (1 - (klo / khi) ^ 2) := by
          apply mul_le_mul_of_nonneg_right _ hk0
          exact_mod_cast card_levels_le_two T x
  linarith [hinl, hinr]

end SlabRowsum

section ExplicitGap

open Matrix

variable {G : Type*} [Group G] [Fintype G] [DecidableEq G] {V Lk : Type*} [DecidableEq V] [Fintype Lk]
  [DecidableEq Lk] {Λ : Lat V Lk} {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- THE MASS GAP WITH ITS COEFFICIENT WRITTEN OUT: on every finite cross-section whose links lie in at most m squares,
every eigenvalue of the transfer matrix other than the Perron root is at most
(3m(1 − (wlo/whi)²) + 2(1 − (klo/khi)²)) · λ₀ whenever that coefficient is below one -- for the Z₂ Wilson slab
(6d − 10)(1 − y²), below one at β < ¼ ln(8/7) in three dimensions and β < ¼ ln(14/13) in four -/
theorem transfer_gap_explicit (sq : ι → Square Λ) (w' : G → ℝ) (wlo whi : ℝ) (hwlo : 0 < wlo)
    (hw'lo : ∀ g, wlo ≤ w' g) (hw'hi : ∀ g, w' g ≤ whi) (k : Matrix G G ℝ) (hk : k.PosSemidef) (klo khi : ℝ)
    (hklo : 0 < klo) (hk_lo : ∀ a b, klo ≤ k a b) (hk_hi : ∀ a b, k a b ≤ khi) (hwhi : 0 < whi) (hkhi : 0 < khi)
    (m : ℕ) (hm : ∀ ℓ, linkDegree sq ℓ ≤ m)
    (hα : 3 * m * (1 - (wlo / whi) ^ 2) + 2 * (1 - (klo / khi) ^ 2) < 1) (j : Lk → G)
    (hj : (transfer_posSemidef (plaqWeight sq w') _ (tensorKernel_posSemidef k hk)).1.eigenvalues j ≠
      lamMax (transfer (plaqWeight sq w') (tensorKernel k))
        (transfer_posSemidef (plaqWeight sq w') _ (tensorKernel_posSemidef k hk)).1) :
    (transfer_posSemidef (plaqWeight sq w') _ (tensorKernel_posSemidef k hk)).1.eigenvalues j ≤
      (3 * m * (1 - (wlo / whi) ^ 2) + 2 * (1 - (klo / khi) ^ 2)) * lamMax (transfer (plaqWeight sq w') (tensorKernel k))
        (transfer_posSemidef (plaqWeight sq w') _ (tensorKernel_posSemidef k hk)).1 := by
  have hw0 : 0 ≤ 1 - (wlo / whi) ^ 2 := by
    have : wlo ≤ whi := le_trans (hw'lo (Classical.arbitrary _)) (hw'hi (Classical.arbitrary _))
    have h1 : wlo / whi ≤ 1 := by rw [div_le_one hwhi]; exact this
    have h0 : 0 ≤ wlo / whi := div_nonneg hwlo.le hwhi.le
    nlinarith
  have hk0 : 0 ≤ 1 - (klo / khi) ^ 2 := by
    have : klo ≤ khi := le_trans (hk_lo (Classical.arbitrary _) (Classical.arbitrary _))
      (hk_hi (Classical.arbitrary _) (Classical.arbitrary _))
    have h1 : klo / khi ≤ 1 := by rw [div_le_one hkhi]; exact this
    have h0 : 0 ≤ klo / khi := div_nonneg hklo.le hkhi.le
    nlinarith
  have hα0 : 0 ≤ 3 * m * (1 - (wlo / whi) ^ 2) + 2 * (1 - (klo / khi) ^ 2) := by positivity
  exact transfer_gap_ratio sq w' wlo whi hwlo hw'lo hw'hi k hk klo khi hklo hk_lo hk_hi _ hα0 hα
    (fun T s => slab_rowsum_le sq w' wlo whi hwlo hw'lo hw'hi k klo khi hklo hk_lo hk_hi T m hm hwhi hkhi s) j hj

/-- the Z₂ Wilson numbers: with wlo = klo = y and whi = khi = 1 the coefficient is (3m + 2)(1 − y²) -/
theorem z2_coefficient (m : ℕ) (y : ℝ) :
    3 * m * (1 - (y / 1) ^ 2) + 2 * (1 - (y / 1) ^ 2) = (3 * m + 2) * (1 - y ^ 2) := by
  simp only [div_one]
  ring

/-- below one iff y² > (3m + 1)/(3m + 2): at m = 2 (three dimensions) y² > 7/8, at m = 4 (four dimensions) y² > 13/14 -/
theorem z2_coefficient_lt_one (m : ℕ) (y : ℝ) :
    (3 * m + 2) * (1 - y ^ 2) < 1 ↔ (3 * m + 1 : ℝ) / (3 * m + 2) < y ^ 2 := by
  have hpos : (0 : ℝ) < 3 * m + 2 := by positivity
  rw [div_lt_iff₀ hpos]
  constructor <;> intro h <;> nlinarith

end ExplicitGap

end Aperanton
