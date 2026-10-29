/-
  APERANTON -- THE BOUNDLESS, stage W4 (ADDENDUM I, THE ROAD, §2 of the 16:39 note): THE DUALITY -- WEGNER'S
  SELF-DUALITY AND 't HOOFT'S ELECTRIC/MAGNETIC TRANSFORM AS ONE THEOREM ON BINARY CODES, BUILT ON Α2.

  WHAT IS PROVED HERE (abstract, every finite complex at once).  Let K ≤ F₂^n be a code (the plaquette code
  K = im δ¹ of a lattice), D ≤ K^⊥ a subcode and H a finite set of representatives with K^⊥ the DISJOINT union of the
  cosets h + D, h ∈ H (`SectorSplit`; on the four-torus K^⊥ = Z₂(Λ) = B₂(Λ) ⊕ H₂(T⁴; F₂), D = B₂(Λ) = im ∂₃, which
  under Poincaré duality is the DUAL lattice's plaquette code, and H the 64 't Hooft twists).  Then for every
  twist w with w ⊥ D (every 2-cocycle: coboundaries pair to zero with cocycles, the parent page's §3 Α2):

    |K^⊥| · W_{w+K}(X)  =  Σ_{h ∈ H} (−1)^{h·w} · Σ_{d ∈ D} (1 − X)^{wt(h+d)} (1 + X)^{n − wt(h+d)}      (`duality`)

  -- the sector-w partition function of the theory (K, X) equals the character-weighted sum over the sectors h of
  the theory (D, X*) read in the HIGH-TEMPERATURE variable X* = (1 − X)/(1 + X) (`dualEnum_eval`): with
  X = e^{−2β} that is X* = tanh β (`wegner_dual`), Wegner's relation tanh β* = e^{−2β}; the map X ↦ X* is an
  involution (`dualVar_involutive`) with the fixed point √2 − 1, i.e. β_c = ½ ln(1 + √2) (`dualVar_fixed`).  The
  character (−1)^{h·w} is 't Hooft's electric/magnetic Fourier transform: the electric sector w of one theory is the
  sum over the magnetic sectors h of its dual with the pairing's sign.  THE OBSERVABLE TRANSFORM (`duality_signed`):
  inserting the local observable (−1)^{s·v} (a product of plaquette variables over the support of s) shifts the dual
  weight by s, wt(h + d) ↦ wt(h + d + s) -- and the shift is a LOCAL function of the dual configuration on the
  support of s (`wt_add_eq_int`: wt(u + s) = wt u + wt s − 2 |supp u ∩ supp s|), so the algebra of local
  gauge-invariant observables maps to itself.  THE MIXTURE LEMMA (`mixture_cov_le`): the connected correlation of a
  sector-mixture is bounded by the mixture of the sectors' connected correlations plus the between-sector term
  (the law of total covariance, `total_cov`); on a finite torus the vacuum sector of one theory is the MIXTURE over
  the dual's twisted sectors, so T3's decay transfers sector by sector and the between-sector term is paid by
  Theorem T (the twisted sectors' weights are O(y^{d(h)}), d(h) the minimal twist area).

  WHAT III THIS STANDS ON.  Α2 (`macwilliams`, the character sum over the dual code, kernel-checked on the 2×2×2
  record as FluxCore's THE MEET -- which IS this theorem's three-dimensional instance, the gauge/Ising duality);
  Α1 (`theoremT`: the twisted sector's weight is O(y^{d(w)})); FluxCore's sheets (the representatives H as the
  homology classes' cycles); ΕΝΑΛΛΑΓΗ's exchange (the same Fourier transform on surfaces for every abelian group,
  its fixed point in ℤ[ζ₈]) is the surface instance; T-107 (ΣΑΓΗΝΗ: the whole interaction is |H₂| linear
  constraints) is why D ⊕ H exhausts K^⊥.  Classical: Wegner 1971 (J. Math. Phys. 12, 2259), Balian–Drouffe–Itzykson
  1975 (Phys. Rev. D 11, 2098), 't Hooft 1979 (Nucl. Phys. B 153, 141), MacWilliams 1963.  W = 0 on the statements;
  the earning is the one theorem on codes from which every instance is read.

  OWED, SAID HERE (the next file, `Torus4.lean`, by emit-and-decide): the four-torus instance of `SectorSplit` --
  D = im ∂₃ ≤ ker ∂₂ = orth (im δ¹) (the adjointness ⟨δ¹a, u⟩ = ⟨a, ∂₂u⟩), the six sheets independent modulo B₂,
  dim Z₂ = dim B₂ + 6 (ranks of the 2⁴ torus's 96 × 64 incidence matrices decided in the kernel; the full finsets
  have 2^51 members and are never enumerated; the ABSTRACT HALF is below: `sectorSplit_of_card` builds the split
  from membership, pairwise non-equivalence of the representatives and ONE cardinality identity, and
  `mem_orth_range_iff` is the adjointness, the dual of an incidence image is the kernel of the transpose) -- and
  the ε-form of the between-sector bound (the dominant sector of weight ≥ 1 − ε makes the between term ≤ 8M²ε),
  stated at the desk, not yet written.  No sorry, no axiom.
-/
import Mathlib
import Aperanton.MacWilliams

open Polynomial Finset Matrix

namespace Aperanton

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

section Weight

/-- the weight never exceeds the length -/
theorem wt_le_card (v : ι → ZMod 2) : wt v ≤ Fintype.card ι := by
  unfold wt
  exact (Finset.card_filter_le _ _).trans (le_of_eq Finset.card_univ)

/-- THE SHIFT IS LOCAL: wt(u + s) = wt u + wt s − 2 |supp u ∩ supp s| -/
theorem wt_add_eq_int (u s : ι → ZMod 2) :
    (wt (u + s) : ℤ) = wt u + wt s - 2 * ((univ.filter (fun i => u i ≠ 0 ∧ s i ≠ 0)).card : ℤ) := by
  simp only [wt_eq_sum, Finset.card_filter]
  push_cast
  rw [← Finset.sum_add_distrib, Finset.mul_sum, ← Finset.sum_sub_distrib]
  apply Finset.sum_congr rfl
  intro i _
  simp only [Pi.add_apply]
  rcases (by decide : ∀ a : ZMod 2, a = 0 ∨ a = 1) (u i) with h1 | h1 <;>
    rcases (by decide : ∀ a : ZMod 2, a = 0 ∨ a = 1) (s i) with h2 | h2 <;>
    simp [h1, h2] <;> decide

end Weight

section Sectors

open Classical in
/-- THE SECTOR SPLIT: the dual code K^⊥ is the disjoint union of the cosets h + D, h ∈ H -- on the four-torus
K^⊥ = Z₂(Λ) = B₂(Λ) ⊕ H₂, D = B₂(Λ) the dual lattice's plaquette code, H the 't Hooft twists -/
structure SectorSplit (K D : Submodule (ZMod 2) (ι → ZMod 2)) (H : Finset (ι → ZMod 2)) : Prop where
  cover : (univ.filter (· ∈ orth K)) = H.biUnion (fun h => (univ.filter (· ∈ D)).image (fun d => h + d))
  disj : (H : Set (ι → ZMod 2)).PairwiseDisjoint (fun h => (univ.filter (· ∈ D)).image (fun d => h + d))

open Classical in
/-- a sum over the dual code is the double sum over sectors and the subcode -/
theorem sum_orth_split {K D : Submodule (ZMod 2) (ι → ZMod 2)} {H : Finset (ι → ZMod 2)}
    (hs : SectorSplit K D H) (f : (ι → ZMod 2) → Polynomial ℤ) :
    ∑ u ∈ univ.filter (· ∈ orth K), f u = ∑ h ∈ H, ∑ d ∈ univ.filter (· ∈ D), f (h + d) := by
  rw [hs.cover, Finset.sum_biUnion hs.disj]
  apply Finset.sum_congr rfl
  intro h _
  rw [Finset.sum_image]
  intro d _ d' _ hdd
  exact add_left_cancel hdd

/-- a cocycle pairs to zero with every boundary, so the character of a coset is the character of its representative -/
theorem chi2_add_of_orth {D : Submodule (ZMod 2) (ι → ZMod 2)} {w : ι → ZMod 2}
    (hw : ∀ d ∈ D, d ⬝ᵥ w = 0) (h d : ι → ZMod 2) (hd : d ∈ D) : chi2 (h + d) w = chi2 h w := by
  have hone : chi2 d w = 1 := by
    unfold chi2
    rw [hw d hd, sgn2_zero]
  rw [chi2_add_left, hone, mul_one]

open Classical in
/-- the dual theory's sector sum in the high-temperature variable: Σ_{d ∈ D} (1 − X)^{wt(h+d)} (1 + X)^{n − wt(h+d)} -/
noncomputable def dualEnum (D : Submodule (ZMod 2) (ι → ZMod 2)) (h : ι → ZMod 2) : Polynomial ℤ :=
  ∑ d ∈ univ.filter (· ∈ D), (1 - X) ^ wt (h + d) * (1 + X) ^ (Fintype.card ι - wt (h + d))

open Classical in
/-- the same with the dual observable's shift s -/
noncomputable def dualEnumShift (D : Submodule (ZMod 2) (ι → ZMod 2)) (h s : ι → ZMod 2) : Polynomial ℤ :=
  ∑ d ∈ univ.filter (· ∈ D), (1 - X) ^ wt (h + d + s) * (1 + X) ^ (Fintype.card ι - wt (h + d + s))

open Classical in
theorem dualEnumShift_zero (D : Submodule (ZMod 2) (ι → ZMod 2)) (h : ι → ZMod 2) :
    dualEnumShift D h 0 = dualEnum D h := by
  unfold dualEnumShift dualEnum
  simp only [add_zero]

open Classical in
/-- THE DUALITY THEOREM (Wegner's self-duality and 't Hooft's transform in one line):
|K^⊥| · W_{w+K}(X) = Σ_{h ∈ H} (−1)^{h·w} · Σ_{d ∈ D} (1 − X)^{wt(h+d)} (1 + X)^{n − wt(h+d)} -/
theorem duality (K D : Submodule (ZMod 2) (ι → ZMod 2)) (H : Finset (ι → ZMod 2)) (hs : SectorSplit K D H)
    (w : ι → ZMod 2) (hw : ∀ d ∈ D, d ⬝ᵥ w = 0) :
    ((univ.filter (· ∈ orth K)).card : Polynomial ℤ) * cosetEnum K w
      = ∑ h ∈ H, Polynomial.C (chi2 h w) * dualEnum D h := by
  rw [macwilliams K w,
    sum_orth_split hs (fun u => Polynomial.C (chi2 u w) * ((1 - X) ^ wt u * (1 + X) ^ (Fintype.card ι - wt u)))]
  apply Finset.sum_congr rfl
  intro h _
  unfold dualEnum
  rw [Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro d hd
  beta_reduce
  rw [chi2_add_of_orth hw h d (Finset.mem_filter.mp hd).2]

end Sectors

section Observable

open Classical in
/-- the signed coset enumerator: the sector's partition function with the local observable (−1)^{s·v} inserted -/
noncomputable def cosetEnumSigned (K : Submodule (ZMod 2) (ι → ZMod 2)) (w s : ι → ZMod 2) : Polynomial ℤ :=
  ∑ c ∈ univ.filter (fun c => c ∈ K), Polynomial.C (chi2 s (w + c)) * (X : Polynomial ℤ) ^ wt (w + c)

open Classical in
theorem cosetEnumSigned_zero (K : Submodule (ZMod 2) (ι → ZMod 2)) (w : ι → ZMod 2) :
    cosetEnumSigned K w 0 = cosetEnum K w := by
  unfold cosetEnumSigned cosetEnum
  apply Finset.sum_congr rfl
  intro c _
  have : chi2 0 (w + c) = 1 := by
    unfold chi2
    rw [zero_dotProduct, sgn2_zero]
  rw [this, map_one, one_mul]

open Classical in
/-- the signed enumerator over all words -/
theorem cosetEnumSigned_eq_sum (K : Submodule (ZMod 2) (ι → ZMod 2)) (w s : ι → ZMod 2) :
    cosetEnumSigned K w s
      = ∑ v : ι → ZMod 2, if v + w ∈ K then Polynomial.C (chi2 s v) * (X : Polynomial ℤ) ^ wt v else 0 := by
  unfold cosetEnumSigned
  rw [← Finset.sum_filter]
  refine Finset.sum_nbij' (fun c => w + c) (fun v => v + w) ?_ ?_ ?_ ?_ ?_
  · intro c hc
    have : w + c + w = c := by
      funext i; simp only [Pi.add_apply]; rw [add_comm (w i), add_assoc, CharTwo.add_self_eq_zero, add_zero]
    rw [Finset.mem_filter] at hc ⊢
    refine ⟨Finset.mem_univ _, ?_⟩
    rw [this]; exact hc.2
  · intro v hv
    rw [Finset.mem_filter] at hv ⊢
    exact ⟨Finset.mem_univ _, hv.2⟩
  · intro c _
    funext i; simp only [Pi.add_apply]; rw [add_comm (w i), add_assoc, CharTwo.add_self_eq_zero, add_zero]
  · intro v _
    funext i; simp only [Pi.add_apply]; rw [add_comm (v i), ← add_assoc, CharTwo.add_self_eq_zero, zero_add]
  · intro c _; rfl

open Classical in
/-- MACWILLIAMS WITH AN OBSERVABLE: |K^⊥| · Σ_{v ∈ w+K} (−1)^{s·v} X^{wt v}
= Σ_{u ∈ K^⊥} (−1)^{u·w} (1 − X)^{wt(u+s)} (1 + X)^{n − wt(u+s)} -- the dual weight shifted by s -/
theorem macwilliams_signed (K : Submodule (ZMod 2) (ι → ZMod 2)) (w s : ι → ZMod 2) :
    ((univ.filter (· ∈ orth K)).card : Polynomial ℤ) * cosetEnumSigned K w s
      = ∑ u ∈ univ.filter (· ∈ orth K),
          Polynomial.C (chi2 u w) * ((1 - X) ^ wt (u + s) * (1 + X) ^ (Fintype.card ι - wt (u + s))) := by
  rw [cosetEnumSigned_eq_sum, Finset.mul_sum]
  have hind : ∀ v : ι → ZMod 2,
      ((univ.filter (· ∈ orth K)).card : Polynomial ℤ)
          * (if v + w ∈ K then Polynomial.C (chi2 s v) * (X : Polynomial ℤ) ^ wt v else 0)
        = ∑ u ∈ univ.filter (· ∈ orth K),
            Polynomial.C (chi2 u v) * Polynomial.C (chi2 u w) * (Polynomial.C (chi2 s v) * X ^ wt v) := by
    intro v
    have h1 := sum_chi2 (orth K) (v + w)
    rw [orth_orth] at h1
    have h2 : ((univ.filter (· ∈ orth K)).card : Polynomial ℤ)
          * (if v + w ∈ K then Polynomial.C (chi2 s v) * (X : Polynomial ℤ) ^ wt v else 0)
        = Polynomial.C (∑ u ∈ univ.filter (· ∈ orth K), chi2 u (v + w)) * (Polynomial.C (chi2 s v) * X ^ wt v) := by
      rw [h1]
      split_ifs
      · rw [map_natCast]
      · rw [map_zero, zero_mul, mul_zero]
    rw [h2, map_sum, Finset.sum_mul]
    apply Finset.sum_congr rfl
    intro u _
    rw [chi2_add_right, map_mul]
  simp_rw [hind]
  rw [Finset.sum_comm]
  apply Finset.sum_congr rfl
  intro u _
  rw [← sum_chi2_pow (u + s), Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro v _
  rw [chi2_add_left, map_mul]
  ring

open Classical in
/-- THE OBSERVABLE TRANSFORM: the sector-w expectation of a local observable is the character-weighted sum over the
dual's sectors of the dual's sum with the weight shifted by s -/
theorem duality_signed (K D : Submodule (ZMod 2) (ι → ZMod 2)) (H : Finset (ι → ZMod 2))
    (hs : SectorSplit K D H) (w s : ι → ZMod 2) (hw : ∀ d ∈ D, d ⬝ᵥ w = 0) :
    ((univ.filter (· ∈ orth K)).card : Polynomial ℤ) * cosetEnumSigned K w s
      = ∑ h ∈ H, Polynomial.C (chi2 h w) * dualEnumShift D h s := by
  rw [macwilliams_signed K w s,
    sum_orth_split hs (fun u => Polynomial.C (chi2 u w)
      * ((1 - X) ^ wt (u + s) * (1 + X) ^ (Fintype.card ι - wt (u + s))))]
  apply Finset.sum_congr rfl
  intro h _
  unfold dualEnumShift
  rw [Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro d hd
  beta_reduce
  rw [chi2_add_of_orth hw h d (Finset.mem_filter.mp hd).2]

end Observable

section Variable

/-- the dual variable X* = (1 − X)/(1 + X): with X = e^{−2β} it is tanh β -/
noncomputable def dualVar (y : ℝ) : ℝ := (1 - y) / (1 + y)

/-- the duality is an involution -/
theorem dualVar_involutive (y : ℝ) (hy : 1 + y ≠ 0) : dualVar (dualVar y) = y := by
  unfold dualVar
  field_simp
  ring

/-- the self-dual point: √2 − 1, i.e. β_c = ½ ln(1 + √2) -/
theorem dualVar_fixed : dualVar (Real.sqrt 2 - 1) = Real.sqrt 2 - 1 := by
  unfold dualVar
  have h2 : Real.sqrt 2 * Real.sqrt 2 = 2 := Real.mul_self_sqrt (by norm_num)
  have hpos : 0 < Real.sqrt 2 := Real.sqrt_pos.mpr (by norm_num)
  rw [div_eq_iff (by linarith)]
  nlinarith [h2]

/-- WEGNER'S RELATION: (1 − e^{−2β})/(1 + e^{−2β}) = tanh β, so X* = tanh β when X = e^{−2β} -/
theorem wegner_dual (β : ℝ) : dualVar (Real.exp (-2 * β)) = Real.tanh β := by
  unfold dualVar
  have ha : Real.exp (-β) = (Real.exp β)⁻¹ := Real.exp_neg β
  have hb : Real.exp (-2 * β) = (Real.exp β)⁻¹ * (Real.exp β)⁻¹ := by
    rw [show -2 * β = -β + -β by ring, Real.exp_add, ha]
  have hpos : 0 < Real.exp β := Real.exp_pos β
  rw [Real.tanh_eq_sinh_div_cosh, Real.sinh_eq, Real.cosh_eq, ha, hb]
  field_simp

/-- THE DUAL SUM IN THE DUAL VARIABLE: Σ_{d ∈ D} (1 − y)^{wt(h+d)} (1 + y)^{n − wt(h+d)} = (1 + y)^n · W_{h+D}(y*) -/
theorem dualEnum_eval (D : Submodule (ZMod 2) (ι → ZMod 2)) (h : ι → ZMod 2) (y : ℝ) (hy : 1 + y ≠ 0) :
    (dualEnum D h).eval₂ (Int.castRingHom ℝ) y
      = (1 + y) ^ Fintype.card ι * (cosetEnum D h).eval₂ (Int.castRingHom ℝ) (dualVar y) := by
  classical
  unfold dualEnum cosetEnum dualVar
  simp only [Polynomial.eval₂_finsetSum, Polynomial.eval₂_mul, Polynomial.eval₂_pow, Polynomial.eval₂_sub,
    Polynomial.eval₂_add, Polynomial.eval₂_one, Polynomial.eval₂_X]
  rw [Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro d _
  have hk := wt_le_card (h + d)
  rw [div_pow, ← pow_sub_mul_pow (1 + y) hk]
  have hpk : (1 + y) ^ wt (h + d) ≠ 0 := pow_ne_zero _ hy
  field_simp

end Variable

section Mixture

variable {H : Type*} [Fintype H]

/-- THE LAW OF TOTAL COVARIANCE: the between-sector term is the centred sum -/
theorem total_cov (p F G : H → ℝ) (hp : ∑ h, p h = 1) :
    ∑ h, p h * (F h - ∑ k, p k * F k) * (G h - ∑ k, p k * G k)
      = ∑ h, p h * F h * G h - (∑ h, p h * F h) * (∑ h, p h * G h) := by
  have hterm : ∀ h, p h * (F h - ∑ k, p k * F k) * (G h - ∑ k, p k * G k)
      = p h * F h * G h - (∑ k, p k * F k) * (p h * G h) - (∑ k, p k * G k) * (p h * F h)
        + ((∑ k, p k * F k) * (∑ k, p k * G k)) * p h := by
    intro h; ring
  simp_rw [hterm]
  rw [Finset.sum_add_distrib, Finset.sum_sub_distrib, Finset.sum_sub_distrib, ← Finset.mul_sum, ← Finset.mul_sum,
    ← Finset.mul_sum, hp]
  ring

/-- THE MIXTURE LEMMA: the connected correlation of a mixture of sectors is at most the mixture of the sectors'
connected correlations plus the between-sector term; p the sector weights, Cfg h = E_h[fg], F h = E_h f, G h = E_h g -/
theorem mixture_cov_le (p F G Cfg : H → ℝ) (hp0 : ∀ h, 0 ≤ p h) (hp : ∑ h, p h = 1) :
    |∑ h, p h * Cfg h - (∑ h, p h * F h) * (∑ h, p h * G h)|
      ≤ ∑ h, p h * |Cfg h - F h * G h|
        + ∑ h, p h * (|F h - ∑ k, p k * F k| * |G h - ∑ k, p k * G k|) := by
  have hsplit : ∑ h, p h * Cfg h - (∑ h, p h * F h) * (∑ h, p h * G h)
      = ∑ h, p h * (Cfg h - F h * G h)
        + ∑ h, p h * (F h - ∑ k, p k * F k) * (G h - ∑ k, p k * G k) := by
    rw [total_cov p F G hp]
    have hsub : ∑ h, p h * (Cfg h - F h * G h) = ∑ h, p h * Cfg h - ∑ h, p h * F h * G h := by
      rw [← Finset.sum_sub_distrib]
      apply Finset.sum_congr rfl
      intro h _
      ring
    rw [hsub]
    ring
  rw [hsplit]
  calc |∑ h, p h * (Cfg h - F h * G h) + ∑ h, p h * (F h - ∑ k, p k * F k) * (G h - ∑ k, p k * G k)|
      ≤ |∑ h, p h * (Cfg h - F h * G h)|
          + |∑ h, p h * (F h - ∑ k, p k * F k) * (G h - ∑ k, p k * G k)| := abs_add_le _ _
    _ ≤ ∑ h, |p h * (Cfg h - F h * G h)|
          + ∑ h, |p h * (F h - ∑ k, p k * F k) * (G h - ∑ k, p k * G k)| :=
        add_le_add (Finset.abs_sum_le_sum_abs _ _) (Finset.abs_sum_le_sum_abs _ _)
    _ = ∑ h, p h * |Cfg h - F h * G h|
          + ∑ h, p h * (|F h - ∑ k, p k * F k| * |G h - ∑ k, p k * G k|) := by
        congr 1
        · apply Finset.sum_congr rfl
          intro h _
          rw [abs_mul, abs_of_nonneg (hp0 h)]
        · apply Finset.sum_congr rfl
          intro h _
          rw [abs_mul, abs_mul, abs_of_nonneg (hp0 h), mul_assoc]

end Mixture

section TorusPrelude

/-- the two values of a bit -/
theorem zmod2_cases (a : ZMod 2) : a = 0 ∨ a = 1 := by
  revert a
  decide

/-- in characteristic two, h + d = h' + d' gives h + h' = d + d' -/
theorem add_eq_add_swap {h h' d d' : ι → ZMod 2} (hx : h + d = h' + d') : h + h' = d + d' := by
  funext i
  have hi := congrFun hx i
  simp only [Pi.add_apply] at hi ⊢
  rcases zmod2_cases (h i) with e1 | e1 <;> rcases zmod2_cases (h' i) with e2 | e2 <;>
    rcases zmod2_cases (d i) with e3 | e3 <;> rcases zmod2_cases (d' i) with e4 | e4 <;>
    rw [e1, e2, e3, e4] at hi ⊢ <;> first | decide | exact absurd hi (by decide)

open Classical in
/-- THE SPLIT FROM A COUNT: representatives inside the dual code, pairwise inequivalent modulo the subcode D ≤ K^⊥,
and ONE cardinality identity |K^⊥| = |H| · |D| give the sector split -- the four-torus instance supplies the
identity from the ranks of its incidence matrices (2^51 = 64 · 2^45), never from an enumeration -/
theorem sectorSplit_of_card (K D : Submodule (ZMod 2) (ι → ZMod 2)) (H : Finset (ι → ZMod 2))
    (hD : D ≤ orth K) (hH : ∀ h ∈ H, h ∈ orth K)
    (hsep : ∀ h ∈ H, ∀ h' ∈ H, h ≠ h' → h + h' ∉ D)
    (hcard : (univ.filter (· ∈ orth K)).card = H.card * (univ.filter (· ∈ D)).card) :
    SectorSplit K D H := by
  set t : (ι → ZMod 2) → Finset (ι → ZMod 2) := fun h => (univ.filter (· ∈ D)).image (fun d => h + d) with ht
  have hdisj : ∀ h ∈ H, ∀ h' ∈ H, h ≠ h' → Disjoint (t h) (t h') := by
    intro h hh h' hh' hne
    rw [Finset.disjoint_left]
    intro x hx hx'
    rw [ht] at hx hx'
    simp only [Finset.mem_image, Finset.mem_filter, Finset.mem_univ, true_and] at hx hx'
    obtain ⟨d, hd, rfl⟩ := hx
    obtain ⟨d', hd', hdd⟩ := hx'
    have hsum : h + h' = d + d' := add_eq_add_swap hdd.symm
    exact hsep h hh h' hh' hne (by rw [hsum]; exact D.add_mem hd hd')
  have hsub : H.biUnion t ⊆ univ.filter (· ∈ orth K) := by
    intro x hx
    rw [Finset.mem_biUnion] at hx
    obtain ⟨h, hh, hx⟩ := hx
    rw [ht] at hx
    simp only [Finset.mem_image, Finset.mem_filter, Finset.mem_univ, true_and] at hx
    obtain ⟨d, hd, rfl⟩ := hx
    rw [Finset.mem_filter]
    exact ⟨Finset.mem_univ _, (orth K).add_mem (hH h hh) (hD hd)⟩
  have hcardU : (H.biUnion t).card = H.card * (univ.filter (· ∈ D)).card := by
    rw [Finset.card_biUnion hdisj]
    have : ∀ h ∈ H, (t h).card = (univ.filter (· ∈ D)).card := by
      intro h _
      rw [ht]
      exact Finset.card_image_of_injective _ (add_right_injective h)
    rw [Finset.sum_congr rfl this, Finset.sum_const, smul_eq_mul]
  refine ⟨?_, ?_⟩
  · exact (Finset.eq_of_subset_of_card_le hsub (le_of_eq (by rw [hcard, hcardU]))).symm
  · intro h hh h' hh' hne
    exact hdisj h (Finset.mem_coe.mp hh) h' (Finset.mem_coe.mp hh') hne

/-- THE ADJOINTNESS: the dual of the image of an incidence matrix A (the coboundary δ¹, rows the plaquettes,
columns the links) is the kernel of its transpose (the boundary ∂₂): K^⊥ = Z₂ -/
theorem mem_orth_range_iff {L : Type*} [Fintype L] [DecidableEq L] (A : Matrix ι L (ZMod 2)) (u : ι → ZMod 2) :
    u ∈ orth (LinearMap.range (Matrix.mulVecLin A)) ↔ A.transpose *ᵥ u = 0 := by
  rw [mem_orth]
  constructor
  · intro hu
    funext l
    have := hu (A *ᵥ Pi.single l 1) ⟨Pi.single l 1, rfl⟩
    rw [dotProduct_comm, dotProduct_mulVec, ← mulVec_transpose, dotProduct_single, mul_one] at this
    exact this
  · intro hu v hv
    obtain ⟨a, rfl⟩ := hv
    show (A *ᵥ a) ⬝ᵥ u = 0
    rw [dotProduct_comm, dotProduct_mulVec, ← mulVec_transpose, hu, zero_dotProduct]

end TorusPrelude

end Aperanton
