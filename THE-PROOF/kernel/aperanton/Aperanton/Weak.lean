/-
  APERANTON -- THE BOUNDLESS, stage W4 (ADDENDUM I, THE ROAD): THE VACUUM SECTOR IS A DUAL-SECTOR MIXTURE -- THE
  WEAK-COUPLING TWO-POINT FUNCTION THROUGH THE DUALITY, SPLIT INTO ITS WITHIN-SECTOR AND BETWEEN-SECTOR TERMS.

  The vacuum sector of the Z₂ gauge theory (the coset 0 + K: every plaquette field a coboundary, the theory of
  periodic link variables, THE SLAB'S OWN THEORY) has, by `duality` and `duality_signed` at the trivial twist w = 0,
  every character equal to one, so its partition function and its signed partition function are plain sums over the
  dual sectors (`duality_vacuum`, `duality_vacuum_signed`).  Evaluated at the coupling y (`dualEnum_eval`,
  `dualEnumShift_eval`) the dual sums are (1 + y)^n times the coset enumerators at the dual coupling
  y* = (1 − y)/(1 + y), so THE VACUUM-SECTOR EXPECTATION OF AN OBSERVABLE IS THE MIXTURE, with the sector masses
  E_h(y*)/Σ E_h(y*), OF THE DUAL SECTORS' EXPECTATIONS E_{h+s}(y*)/E_h(y*) (`vacExp_eq_mixture`) -- each the dual
  sector's expectation of the shifted weight, the disorder observable, a local function of the dual configuration
  (y*^{wt(c+s)} = y*^{wt c} · Π_{p ∈ s} y*^{1 − 2 c_p}).  THE COVARIANCE SPLITS (`vacuum_cov_le`, through
  `mixture_cov_le`): the vacuum sector's connected two-point function is at most the mass-weighted sum of the dual
  sectors' connected two-point functions plus the between-sector term.  The next stages pay the two terms: within a
  dual sector the decay is the twisted slab's gap at the dual coupling (the same factor bounds, so the mechanism of
  `transfer_gap_sharp` applies where y* > (3m+1)/(3m+3), which is the ORIGINAL theory's weak coupling), and the
  between-sector term is the sectors' one-point spread.  This file claims the identity and the inequality, both exact,
  on any sector split -- the four-torus of side two supplies one (`torus4Split`).  W = 0 for the duality (Wegner
  1971, 't Hooft 1979); the earning is the executable split.  No sorry, no axiom, no native_decide.
-/
import Mathlib
import Aperanton.Duality

open Polynomial Finset Matrix

namespace Aperanton

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

section VacuumDuality

/-- the character at the trivial twist is one -/
theorem chi2_zero_right (h : ι → ZMod 2) : chi2 h 0 = 1 := by
  unfold chi2
  rw [dotProduct_zero, sgn2_zero]

open Classical in
/-- THE VACUUM SECTOR'S DUALITY: |K^⊥| · W_K(X) = Σ_h Σ_{d ∈ D} (1 − X)^{wt(h+d)} (1 + X)^{n − wt(h+d)} -/
theorem duality_vacuum (K D : Submodule (ZMod 2) (ι → ZMod 2)) (H : Finset (ι → ZMod 2))
    (hs : SectorSplit K D H) :
    ((univ.filter (· ∈ orth K)).card : Polynomial ℤ) * cosetEnum K 0 = ∑ h ∈ H, dualEnum D h := by
  have h := duality K D H hs 0 (fun d _ => dotProduct_zero d)
  simp only [chi2_zero_right, Polynomial.C_1, one_mul] at h
  exact h

open Classical in
/-- the same with the observable (−1)^{s·c} inserted -/
theorem duality_vacuum_signed (K D : Submodule (ZMod 2) (ι → ZMod 2)) (H : Finset (ι → ZMod 2))
    (hs : SectorSplit K D H) (s : ι → ZMod 2) :
    ((univ.filter (· ∈ orth K)).card : Polynomial ℤ) * cosetEnumSigned K 0 s
      = ∑ h ∈ H, dualEnumShift D h s := by
  have h := duality_signed K D H hs 0 s (fun d _ => dotProduct_zero d)
  simp only [chi2_zero_right, Polynomial.C_1, one_mul] at h
  exact h

/-- the shifted dual sum in the dual variable: (1 + y)^n · W_{h+s+D}(y*) -/
theorem dualEnumShift_eval (D : Submodule (ZMod 2) (ι → ZMod 2)) (h s : ι → ZMod 2) (y : ℝ)
    (hy : 1 + y ≠ 0) :
    (dualEnumShift D h s).eval₂ (Int.castRingHom ℝ) y
      = (1 + y) ^ Fintype.card ι * (cosetEnum D (h + s)).eval₂ (Int.castRingHom ℝ) (dualVar y) := by
  classical
  unfold dualEnumShift cosetEnum dualVar
  simp only [Polynomial.eval₂_finsetSum, Polynomial.eval₂_mul, Polynomial.eval₂_pow, Polynomial.eval₂_sub,
    Polynomial.eval₂_add, Polynomial.eval₂_one, Polynomial.eval₂_X]
  rw [Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro d _
  rw [add_right_comm h d s]
  have hk := wt_le_card (h + s + d)
  rw [div_pow, ← pow_sub_mul_pow (1 + y) hk]
  have hpk : (1 + y) ^ wt (h + s + d) ≠ 0 := pow_ne_zero _ hy
  field_simp

/-- a sector split has a sector: the dual code holds zero -/
theorem SectorSplit.nonempty {K D : Submodule (ZMod 2) (ι → ZMod 2)} {H : Finset (ι → ZMod 2)}
    (hs : SectorSplit K D H) : H.Nonempty := by
  classical
  by_contra hcon
  rw [Finset.not_nonempty_iff_eq_empty] at hcon
  have h0 : (0 : ι → ZMod 2) ∈ univ.filter (· ∈ orth K) := by simp [Submodule.zero_mem]
  rw [hs.cover, hcon, Finset.biUnion_empty] at h0
  simp at h0

end VacuumDuality

section Mixture

/-- a coset enumerator at a real coupling -/
noncomputable def enumAt (D : Submodule (ZMod 2) (ι → ZMod 2)) (h : ι → ZMod 2) (y : ℝ) : ℝ :=
  (cosetEnum D h).eval₂ (Int.castRingHom ℝ) y

open Classical in
theorem enumAt_eq_sum (D : Submodule (ZMod 2) (ι → ZMod 2)) (h : ι → ZMod 2) (y : ℝ) :
    enumAt D h y = ∑ c ∈ univ.filter (· ∈ D), y ^ wt (h + c) := by
  unfold enumAt cosetEnum
  simp only [Polynomial.eval₂_finsetSum, Polynomial.eval₂_pow, Polynomial.eval₂_X]

/-- a coset enumerator at a positive coupling is positive: the code holds zero -/
theorem enumAt_pos (D : Submodule (ZMod 2) (ι → ZMod 2)) (h : ι → ZMod 2) (y : ℝ) (hy : 0 < y) :
    0 < enumAt D h y := by
  classical
  rw [enumAt_eq_sum]
  apply Finset.sum_pos
  · intro c _
    exact pow_pos hy _
  · exact ⟨0, by simp [Submodule.zero_mem]⟩

/-- the mass of the dual sector h among the sectors H at the coupling y -/
noncomputable def sectorMass (D : Submodule (ZMod 2) (ι → ZMod 2)) (H : Finset (ι → ZMod 2)) (y : ℝ)
    (h : ι → ZMod 2) : ℝ :=
  enumAt D h y / ∑ h' ∈ H, enumAt D h' y

/-- the dual sector's expectation of the shifted weight: E_{h+s}/E_h -/
noncomputable def sectorExp (D : Submodule (ZMod 2) (ι → ZMod 2)) (y : ℝ) (h s : ι → ZMod 2) : ℝ :=
  enumAt D (h + s) y / enumAt D h y

/-- the vacuum sector's expectation of the observable (−1)^{s·c} -/
noncomputable def vacExp (K : Submodule (ZMod 2) (ι → ZMod 2)) (y : ℝ) (s : ι → ZMod 2) : ℝ :=
  (cosetEnumSigned K 0 s).eval₂ (Int.castRingHom ℝ) y / enumAt K 0 y

theorem sectorMass_nonneg (D : Submodule (ZMod 2) (ι → ZMod 2)) (H : Finset (ι → ZMod 2)) (y : ℝ)
    (hy : 0 < y) (h : ι → ZMod 2) : 0 ≤ sectorMass D H y h := by
  unfold sectorMass
  apply div_nonneg (enumAt_pos D h y hy).le
  exact Finset.sum_nonneg (fun h' _ => (enumAt_pos D h' y hy).le)

theorem sectorMass_sum (D : Submodule (ZMod 2) (ι → ZMod 2)) (H : Finset (ι → ZMod 2)) (hH : H.Nonempty)
    (y : ℝ) (hy : 0 < y) : ∑ h ∈ H, sectorMass D H y h = 1 := by
  unfold sectorMass
  rw [← Finset.sum_div]
  have hT : 0 < ∑ h' ∈ H, enumAt D h' y := Finset.sum_pos (fun h' _ => enumAt_pos D h' y hy) hH
  exact div_self hT.ne'

theorem dualVar_pos (y : ℝ) (hy0 : 0 < y) (hy1 : y < 1) : 0 < dualVar y := by
  unfold dualVar
  apply div_pos <;> linarith

open Classical in
/-- the vacuum partition function at y against the dual sector sum at y* -/
theorem vacuum_Z_eq (K D : Submodule (ZMod 2) (ι → ZMod 2)) (H : Finset (ι → ZMod 2))
    (hs : SectorSplit K D H) (y : ℝ) (hy : 1 + y ≠ 0) :
    ((univ.filter (· ∈ orth K)).card : ℝ) * enumAt K 0 y
      = (1 + y) ^ Fintype.card ι * ∑ h ∈ H, enumAt D h (dualVar y) := by
  have this := congrArg (Polynomial.eval₂ (Int.castRingHom ℝ) y) (duality_vacuum K D H hs)
  simp only [Polynomial.eval₂_mul, Polynomial.eval₂_natCast, Polynomial.eval₂_finsetSum] at this
  rw [Finset.mul_sum]
  unfold enumAt
  rw [this]
  exact Finset.sum_congr rfl (fun h _ => dualEnum_eval D h y hy)

open Classical in
/-- the vacuum signed partition function at y against the dual shifted sector sum at y* -/
theorem vacuum_N_eq (K D : Submodule (ZMod 2) (ι → ZMod 2)) (H : Finset (ι → ZMod 2))
    (hs : SectorSplit K D H) (s : ι → ZMod 2) (y : ℝ) (hy : 1 + y ≠ 0) :
    ((univ.filter (· ∈ orth K)).card : ℝ) * (cosetEnumSigned K 0 s).eval₂ (Int.castRingHom ℝ) y
      = (1 + y) ^ Fintype.card ι * ∑ h ∈ H, enumAt D (h + s) (dualVar y) := by
  have this := congrArg (Polynomial.eval₂ (Int.castRingHom ℝ) y) (duality_vacuum_signed K D H hs s)
  simp only [Polynomial.eval₂_mul, Polynomial.eval₂_natCast, Polynomial.eval₂_finsetSum] at this
  rw [Finset.mul_sum]
  unfold enumAt
  rw [this]
  exact Finset.sum_congr rfl (fun h _ => dualEnumShift_eval D h s y hy)

open Classical in
/-- THE VACUUM SECTOR IS THE DUAL-SECTOR MIXTURE: ⟨(−1)^{s·c}⟩_{0+K}(y) = Σ_h m_h(y*) · E_{h+s}(y*)/E_h(y*) -/
theorem vacExp_eq_mixture (K D : Submodule (ZMod 2) (ι → ZMod 2)) (H : Finset (ι → ZMod 2))
    (hs : SectorSplit K D H) (s : ι → ZMod 2) (y : ℝ) (hy0 : 0 < y) (hy1 : y < 1) :
    vacExp K y s = ∑ h ∈ H, sectorMass D H (dualVar y) h * sectorExp D (dualVar y) h s := by
  have hy : 1 + y ≠ 0 := by linarith
  have hstar : 0 < dualVar y := dualVar_pos y hy0 hy1
  have hH : H.Nonempty := hs.nonempty
  have hZ : 0 < enumAt K 0 y := enumAt_pos K 0 y hy0
  have hT : 0 < ∑ h ∈ H, enumAt D h (dualVar y) := Finset.sum_pos (fun h _ => enumAt_pos D h _ hstar) hH
  have hcard : (0 : ℝ) < ((univ.filter (· ∈ orth K)).card : ℝ) := by
    exact_mod_cast Finset.card_pos.mpr ⟨0, by simp [Submodule.zero_mem]⟩
  have hR : ∑ h ∈ H, sectorMass D H (dualVar y) h * sectorExp D (dualVar y) h s
      = (∑ h ∈ H, enumAt D (h + s) (dualVar y)) / ∑ h ∈ H, enumAt D h (dualVar y) := by
    rw [Finset.sum_div]
    apply Finset.sum_congr rfl
    intro h _
    unfold sectorMass sectorExp
    have hE : 0 < enumAt D h (dualVar y) := enumAt_pos D h _ hstar
    field_simp
  rw [hR]
  unfold vacExp
  rw [div_eq_div_iff hZ.ne' hT.ne']
  have h1 := vacuum_Z_eq K D H hs y hy
  have h2 := vacuum_N_eq K D H hs s y hy
  apply mul_left_cancel₀ hcard.ne'
  calc ((univ.filter (· ∈ orth K)).card : ℝ)
        * ((cosetEnumSigned K 0 s).eval₂ (Int.castRingHom ℝ) y * ∑ h ∈ H, enumAt D h (dualVar y))
      = (((univ.filter (· ∈ orth K)).card : ℝ) * (cosetEnumSigned K 0 s).eval₂ (Int.castRingHom ℝ) y)
          * ∑ h ∈ H, enumAt D h (dualVar y) := by ring
    _ = ((1 + y) ^ Fintype.card ι * ∑ h ∈ H, enumAt D (h + s) (dualVar y))
          * ∑ h ∈ H, enumAt D h (dualVar y) := by rw [h2]
    _ = (∑ h ∈ H, enumAt D (h + s) (dualVar y))
          * ((1 + y) ^ Fintype.card ι * ∑ h ∈ H, enumAt D h (dualVar y)) := by ring
    _ = (∑ h ∈ H, enumAt D (h + s) (dualVar y))
          * (((univ.filter (· ∈ orth K)).card : ℝ) * enumAt K 0 y) := by rw [h1]
    _ = ((univ.filter (· ∈ orth K)).card : ℝ)
          * ((∑ h ∈ H, enumAt D (h + s) (dualVar y)) * enumAt K 0 y) := by ring

open Classical in
/-- THE VACUUM COVARIANCE SPLITS: the connected two-point function of the vacuum sector is at most the
mass-weighted sum of the dual sectors' connected two-point functions plus the between-sector term -/
theorem vacuum_cov_le (K D : Submodule (ZMod 2) (ι → ZMod 2)) (H : Finset (ι → ZMod 2))
    (hs : SectorSplit K D H) (s₁ s₂ : ι → ZMod 2) (y : ℝ) (hy0 : 0 < y) (hy1 : y < 1) :
    |vacExp K y (s₁ + s₂) - vacExp K y s₁ * vacExp K y s₂|
      ≤ ∑ h ∈ H, sectorMass D H (dualVar y) h
            * |sectorExp D (dualVar y) h (s₁ + s₂) - sectorExp D (dualVar y) h s₁ * sectorExp D (dualVar y) h s₂|
        + ∑ h ∈ H, sectorMass D H (dualVar y) h
            * (|sectorExp D (dualVar y) h s₁ - vacExp K y s₁|
              * |sectorExp D (dualVar y) h s₂ - vacExp K y s₂|) := by
  have hstar : 0 < dualVar y := dualVar_pos y hy0 hy1
  have hH : H.Nonempty := hs.nonempty
  rw [vacExp_eq_mixture K D H hs (s₁ + s₂) y hy0 hy1, vacExp_eq_mixture K D H hs s₁ y hy0 hy1,
    vacExp_eq_mixture K D H hs s₂ y hy0 hy1]
  have hm := mixture_cov_le (H := ↥H) (fun h => sectorMass D H (dualVar y) h.1)
    (fun h => sectorExp D (dualVar y) h.1 s₁) (fun h => sectorExp D (dualVar y) h.1 s₂)
    (fun h => sectorExp D (dualVar y) h.1 (s₁ + s₂))
    (fun h => sectorMass_nonneg D H _ hstar h.1)
    (by rw [Finset.sum_coe_sort]; exact sectorMass_sum D H hH _ hstar)
  simp only [← Finset.sum_coe_sort H]
  exact hm

end Mixture

end Aperanton
