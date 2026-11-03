/-
  APERANTON -- THE BOUNDLESS, THE TREK (2026-10-28 13:2x): THE TWIST EATER'S LAW FOR EVERY FINITE GROUP WITH AN EATER.

  TwistEater.lean decided the law on Q₈ by its tables.  Here the group is any finite group G carrying a TRACE-HALF q : G → ℝ --
  q 1 = 1, −1 ≤ q ≤ 1, a class function invariant under inversion, with a GAP δ > 0 below the identity (q g ≤ 1 − δ for g ≠ 1:
  every finite subgroup of SU(2) with its q₀ = Re tr / 2 has one) -- and an EATER: a central z with q z = −1 and a pair (x, y)
  whose commutator is z (Q₈'s (i, j), hence every 2T, 2O, 2I).  On the 1 x 1 x L cell the vacuum and the twisted transfer
  matrices in symmetric form, z² = e^β,
      T(s, s') = z^{qP s + qP s'} K(s, s'),   T^tw(s, s') = z^{−qP s − qP s'} K(s, s'),   K(s, s') = (1/|G|) Σ_t z^{2 temp(s, s', t)},
  have Perron roots in  [z⁶, z⁶ (1 + |G|² z^{−2δ})]  for every z ≥ 1 (eater_law): the vacuum's floor is the identity pair's diagonal,
  the twisted sector's the Rayleigh quotient on the eater's conjugation orbit, the ceilings the row sums -- a row's degree-six
  terms are exactly the |G| slices reached through a temporal link at zero cost (temp = 2 iff s' = t⁻¹ s t), every other term
  sits 2δ lower.  Hence the vortex string's rate m = λ₀(T^tw)/λ₀(T) lies in [1/(1 + |G|² z^{−2δ}), 1 + |G|² z^{−2δ}] and tends to
  one (rate_tendsto): the twisted sector's zero-temperature free energy is the vacuum's, for every finite group with an eater,
  which is why no finite-box criterion that prices the centre twist survives large β on the vortex sector of such a group
  (the master plan note §37.4, §41).  Q₈ has δ = 1 and |G|² = 64: the bounds of TwistEater.lean.  No sorry, no axiom, no
  native_decide; Perron.lean supplies λ₀, its Rayleigh bound and its positive eigenvector.
-/
import Mathlib
import Aperanton.Perron

set_option maxHeartbeats 1000000

namespace TwistEaterGeneral

open Matrix BigOperators Finset Aperanton

variable {G : Type*} [Group G] [Fintype G] [DecidableEq G]

/-- a trace-half on G: the class function of a faithful representation into SU(2) read as Re tr / 2, with its gap below the identity -/
structure TraceHalf (G : Type*) [Group G] where
  q : G → ℝ
  q_one : q 1 = 1
  q_le_one : ∀ g, q g ≤ 1
  q_ge_neg_one : ∀ g, -1 ≤ q g
  q_conj : ∀ g t, q (t * g * t⁻¹) = q g
  q_inv : ∀ g, q g⁻¹ = q g
  δ : ℝ
  δ_pos : 0 < δ
  gap : ∀ g, g ≠ 1 → q g ≤ 1 - δ

/-- an eater of the twisting element: a central z with q z = −1 and a pair whose commutator is z -/
structure Eater (G : Type*) [Group G] (Q : TraceHalf G) where
  z : G
  z_central : ∀ g, z * g = g * z
  q_z : Q.q z = -1
  x : G
  y : G
  comm_eq : x * y * x⁻¹ * y⁻¹ = z

variable (Q : TraceHalf G)

/-! ## the cell -/

/-- the spatial plaquette of a slice (x, y) -/
def comm (s : G × G) : G := s.1 * s.2 * s.1⁻¹ * s.2⁻¹

/-- q of the plaquette -/
def qP (s : G × G) : ℝ := Q.q (comm s)

/-- the temporal exponent between two slices through the temporal link t -/
def temp (s s' : G × G) (t : G) : ℝ := Q.q (s.1 * t * s'.1⁻¹ * t⁻¹) + Q.q (s.2 * t * s'.2⁻¹ * t⁻¹)

/-- the slice reached from s through t at zero temporal cost -/
def act (t : G) (s : G × G) : G × G := (t⁻¹ * s.1 * t, t⁻¹ * s.2 * t)

theorem q_eq_one_iff (g : G) : Q.q g = 1 ↔ g = 1 := by
  constructor
  · intro h
    by_contra hne
    have := Q.gap g hne
    have := Q.δ_pos
    linarith
  · rintro rfl
    exact Q.q_one

theorem qP_le_one (s : G × G) : qP Q s ≤ 1 := Q.q_le_one _
theorem qP_ge (s : G × G) : -1 ≤ qP Q s := Q.q_ge_neg_one _
theorem qP_one : qP Q (1, 1) = 1 := by
  unfold qP comm
  simp [Q.q_one]

theorem temp_le_two (s s' : G × G) (t : G) : temp Q s s' t ≤ 2 := by
  unfold temp
  have h1 := Q.q_le_one (s.1 * t * s'.1⁻¹ * t⁻¹)
  have h2 := Q.q_le_one (s.2 * t * s'.2⁻¹ * t⁻¹)
  linarith

theorem link_eq_one_iff (a b t : G) : a * t * b⁻¹ * t⁻¹ = 1 ↔ b = t⁻¹ * a * t := by
  constructor
  · intro h
    have h2 : a * t * b⁻¹ = t := by
      have := congrArg (· * t) h
      simpa [mul_assoc] using this
    have h3 : a * t = t * b := by
      have := congrArg (· * b) h2
      simpa [mul_assoc] using this
    calc b = t⁻¹ * (t * b) := by group
      _ = t⁻¹ * (a * t) := by rw [h3]
      _ = t⁻¹ * a * t := by group
  · rintro rfl
    group

theorem temp_eq_two_iff (s s' : G × G) (t : G) : temp Q s s' t = 2 ↔ s' = act t s := by
  unfold temp act
  have h1 := Q.q_le_one (s.1 * t * s'.1⁻¹ * t⁻¹)
  have h2 := Q.q_le_one (s.2 * t * s'.2⁻¹ * t⁻¹)
  constructor
  · intro h
    have ha : Q.q (s.1 * t * s'.1⁻¹ * t⁻¹) = 1 := by linarith
    have hb : Q.q (s.2 * t * s'.2⁻¹ * t⁻¹) = 1 := by linarith
    rw [q_eq_one_iff, link_eq_one_iff] at ha hb
    exact Prod.ext ha hb
  · intro h
    have ha : s'.1 = t⁻¹ * s.1 * t := by rw [h]
    have hb : s'.2 = t⁻¹ * s.2 * t := by rw [h]
    rw [← link_eq_one_iff, ← q_eq_one_iff Q] at ha hb
    rw [ha, hb]; norm_num

theorem temp_le_gap (s s' : G × G) (t : G) (h : s' ≠ act t s) : temp Q s s' t ≤ 2 - Q.δ := by
  have hne : ¬ (s.1 * t * s'.1⁻¹ * t⁻¹ = 1 ∧ s.2 * t * s'.2⁻¹ * t⁻¹ = 1) := by
    rintro ⟨ha, hb⟩
    rw [link_eq_one_iff] at ha hb
    exact h (Prod.ext ha hb)
  unfold temp
  by_cases ha : s.1 * t * s'.1⁻¹ * t⁻¹ = 1
  · have hb : s.2 * t * s'.2⁻¹ * t⁻¹ ≠ 1 := fun hb => hne ⟨ha, hb⟩
    have := Q.gap _ hb
    have := Q.q_le_one (s.1 * t * s'.1⁻¹ * t⁻¹)
    linarith
  · have := Q.gap _ ha
    have := Q.q_le_one (s.2 * t * s'.2⁻¹ * t⁻¹)
    linarith

theorem temp_symm (s s' : G × G) (t : G) : temp Q s' s t⁻¹ = temp Q s s' t := by
  unfold temp
  have ka : s'.1 * t⁻¹ * s.1⁻¹ * t⁻¹⁻¹ = t⁻¹ * (s.1 * t * s'.1⁻¹ * t⁻¹)⁻¹ * t⁻¹⁻¹ := by group
  have kb : s'.2 * t⁻¹ * s.2⁻¹ * t⁻¹⁻¹ = t⁻¹ * (s.2 * t * s'.2⁻¹ * t⁻¹)⁻¹ * t⁻¹⁻¹ := by group
  rw [ka, kb, Q.q_conj, Q.q_conj, Q.q_inv, Q.q_inv]

theorem act_act (t u : G) (s : G × G) : act t (act u s) = act (u * t) s := by
  unfold act
  ext <;> simp [mul_assoc]

theorem comm_act (t : G) (s : G × G) : comm (act t s) = t⁻¹ * comm s * t := by
  unfold comm act
  simp only
  group

theorem temp_one (t : G) : temp Q (1, 1) (1, 1) t = 2 := by
  unfold temp
  simp only [one_mul, inv_one, mul_one, mul_inv_cancel, Q.q_one]
  norm_num

/-! ## the transfer matrices -/

noncomputable def K (z : ℝ) (s s' : G × G) : ℝ := (1 / (Fintype.card G : ℝ)) * ∑ t, z ^ (2 * temp Q s s' t)

noncomputable def T (z : ℝ) : Matrix (G × G) (G × G) ℝ := fun s s' => z ^ (qP Q s + qP Q s') * K Q z s s'

noncomputable def Ttw (z : ℝ) : Matrix (G × G) (G × G) ℝ := fun s s' => z ^ (-(qP Q s) - qP Q s') * K Q z s s'

theorem card_pos : (0 : ℝ) < (Fintype.card G : ℝ) := by exact_mod_cast Fintype.card_pos

theorem K_pos (z : ℝ) (hz : 0 < z) (s s' : G × G) : 0 < K Q z s s' := by
  unfold K
  apply mul_pos (by have := card_pos (G := G); positivity)
  exact Finset.sum_pos (fun t _ => Real.rpow_pos_of_pos hz _) univ_nonempty

theorem K_symm (z : ℝ) (s s' : G × G) : K Q z s s' = K Q z s' s := by
  unfold K
  congr 1
  rw [← Equiv.sum_comp (Equiv.inv G) (fun t => z ^ (2 * temp Q s' s t))]
  apply Finset.sum_congr rfl
  intro t _
  simp only [Equiv.inv_apply]
  rw [temp_symm]

theorem T_pos (z : ℝ) (hz : 0 < z) : ∀ s s', 0 < T Q z s s' :=
  fun s s' => mul_pos (Real.rpow_pos_of_pos hz _) (K_pos Q z hz s s')

theorem Ttw_pos (z : ℝ) (hz : 0 < z) : ∀ s s', 0 < Ttw Q z s s' :=
  fun s s' => mul_pos (Real.rpow_pos_of_pos hz _) (K_pos Q z hz s s')

theorem T_herm (z : ℝ) : (T Q z).IsHermitian := by
  apply Matrix.IsHermitian.ext
  intro s s'
  simp only [star_trivial, T]
  rw [K_symm, add_comm]

theorem Ttw_herm (z : ℝ) : (Ttw Q z).IsHermitian := by
  apply Matrix.IsHermitian.ext
  intro s s'
  simp only [star_trivial, Ttw]
  rw [K_symm]
  congr 2
  ring

/-! ## the lower bounds -/

theorem K_one (z : ℝ) : K Q z (1, 1) (1, 1) = z ^ (4 : ℝ) := by
  unfold K
  have h : ∀ t ∈ (univ : Finset G), z ^ (2 * temp Q (1, 1) (1, 1) t) = z ^ (4 : ℝ) :=
    fun t _ => by rw [temp_one]; norm_num
  rw [Finset.sum_congr rfl h, Finset.sum_const, Finset.card_univ, nsmul_eq_mul]
  have hc := card_pos (G := G)
  field_simp

theorem T_one (z : ℝ) (hz : 0 < z) : T Q z (1, 1) (1, 1) = z ^ (6 : ℝ) := by
  unfold T
  rw [K_one, qP_one, ← Real.rpow_add hz]
  norm_num

/-- the Rayleigh bound read at a basis vector: λ₀ ≥ every diagonal entry -/
theorem lamMax_ge_diag (M : Matrix (G × G) (G × G) ℝ) (hM : M.IsHermitian) (s : G × G) : M s s ≤ lamMax M hM := by
  have h := dot_mulVec_le M hM (Pi.single s 1)
  simp only [dotProduct, mulVec, Pi.single_apply, mul_ite, mul_one, mul_zero, ite_mul, one_mul, zero_mul,
    Finset.sum_ite_eq', Finset.mem_univ, if_true] at h
  linarith

theorem lamMax_T_ge (z : ℝ) (hz : 0 < z) : z ^ (6 : ℝ) ≤ lamMax (T Q z) (T_herm Q z) := by
  rw [← T_one Q z hz]; exact lamMax_ge_diag _ _ _

section EaterOrbit
variable (e : Eater G Q)

/-- the eater's conjugation orbit -/
def E : Finset (G × G) := univ.image (fun t => act t (e.x, e.y))

theorem mem_E_iff (s : G × G) : s ∈ E Q e ↔ ∃ t, act t (e.x, e.y) = s := by
  unfold E
  simp [Finset.mem_image]

theorem E_nonempty : (E Q e).Nonempty := ⟨_, (mem_E_iff Q e _).mpr ⟨1, rfl⟩⟩

theorem E_closed (t : G) (s : G × G) (hs : s ∈ E Q e) : act t s ∈ E Q e := by
  obtain ⟨u, hu⟩ := (mem_E_iff Q e s).mp hs
  exact (mem_E_iff Q e _).mpr ⟨u * t, by rw [← act_act, hu]⟩

theorem qP_E (s : G × G) (hs : s ∈ E Q e) : qP Q s = -1 := by
  obtain ⟨t, rfl⟩ := (mem_E_iff Q e s).mp hs
  unfold qP
  rw [comm_act]
  have hc : comm (e.x, e.y) = e.z := e.comm_eq
  rw [hc]
  have hz : t⁻¹ * e.z * t = e.z := by rw [← e.z_central]; group
  rw [hz, e.q_z]

/-- the slices of the orbit reached from s ∈ E through all |G| temporal links, counted by their target -/
theorem E_fibre_sum (s : G × G) (hs : s ∈ E Q e) :
    ∑ s' ∈ E Q e, ((univ.filter (fun t : G => act t s = s')).card : ℝ) = Fintype.card G := by
  have h := Finset.card_eq_sum_card_fiberwise (s := (univ : Finset G)) (t := E Q e) (f := fun t => act t s)
    (fun t _ => E_closed Q e t s hs)
  rw [Finset.card_univ] at h
  exact_mod_cast h.symm

/-- the indicator of the orbit -/
noncomputable def eaterVec : (G × G) → ℝ := fun s => if s ∈ E Q e then 1 else 0

theorem eaterVec_dot : eaterVec Q e ⬝ᵥ eaterVec Q e = ((E Q e).card : ℝ) := by
  have h : ∀ s : G × G, eaterVec Q e s * eaterVec Q e s = if s ∈ E Q e then 1 else 0 := by
    intro s; unfold eaterVec; split_ifs <;> simp
  simp only [dotProduct, h]
  rw [Finset.sum_ite_mem, Finset.univ_inter, Finset.sum_const]
  simp

theorem Ttw_E_entry (z : ℝ) (hz : 1 ≤ z) (s s' : G × G) (hs : s ∈ E Q e) (hs' : s' ∈ E Q e) :
    z ^ (2 : ℝ) * ((1 / (Fintype.card G : ℝ)) * ((univ.filter (fun t : G => act t s = s')).card : ℝ) * z ^ (4 : ℝ))
      ≤ Ttw Q z s s' := by
  have hz0 : 0 < z := lt_of_lt_of_le one_pos hz
  unfold Ttw
  have hq : -(qP Q s) - qP Q s' = 2 := by rw [qP_E Q e s hs, qP_E Q e s' hs']; norm_num
  rw [hq]
  apply mul_le_mul_of_nonneg_left _ (Real.rpow_nonneg hz0.le _)
  unfold K
  rw [mul_assoc]
  apply mul_le_mul_of_nonneg_left _ (by have := card_pos (G := G); positivity)
  have hA : ∑ t ∈ univ.filter (fun t : G => act t s = s'), z ^ (2 * temp Q s s' t)
      = ((univ.filter (fun t : G => act t s = s')).card : ℝ) * z ^ (4 : ℝ) := by
    rw [Finset.sum_congr rfl (g := fun _ => z ^ (4 : ℝ))
      (fun t ht => by
        have h2 : temp Q s s' t = 2 := (temp_eq_two_iff Q s s' t).mpr (Finset.mem_filter.mp ht).2.symm
        rw [h2]; norm_num)]
    rw [Finset.sum_const, nsmul_eq_mul]
  rw [← hA]
  exact Finset.sum_le_sum_of_subset_of_nonneg (Finset.filter_subset _ _) (fun t _ _ => Real.rpow_nonneg hz0.le _)

theorem eater_rayleigh (z : ℝ) (hz : 1 ≤ z) :
    ((E Q e).card : ℝ) * z ^ (6 : ℝ) ≤ eaterVec Q e ⬝ᵥ (Ttw Q z *ᵥ eaterVec Q e) := by
  have hz0 : 0 < z := lt_of_lt_of_le one_pos hz
  have hdot : eaterVec Q e ⬝ᵥ (Ttw Q z *ᵥ eaterVec Q e) = ∑ s ∈ E Q e, ∑ s' ∈ E Q e, Ttw Q z s s' := by
    simp only [dotProduct, mulVec, eaterVec, mul_ite, mul_one, mul_zero, ite_mul, one_mul, zero_mul]
    rw [Finset.sum_ite_mem, Finset.univ_inter]
    apply Finset.sum_congr rfl; intro s _
    rw [Finset.sum_ite_mem, Finset.univ_inter]
  rw [hdot]
  have hc := card_pos (G := G)
  have hz6 : z ^ (6 : ℝ) = z ^ (2 : ℝ) * z ^ (4 : ℝ) := by rw [← Real.rpow_add hz0]; norm_num
  calc ((E Q e).card : ℝ) * z ^ (6 : ℝ)
      = ∑ s ∈ E Q e, ∑ s' ∈ E Q e, z ^ (2 : ℝ) * ((1 / (Fintype.card G : ℝ)) * ((univ.filter (fun t : G => act t s = s')).card : ℝ) * z ^ (4 : ℝ)) := by
        have hrow : ∀ s ∈ E Q e, ∑ s' ∈ E Q e, z ^ (2 : ℝ) * ((1 / (Fintype.card G : ℝ)) * ((univ.filter (fun t : G => act t s = s')).card : ℝ) * z ^ (4 : ℝ)) = z ^ (6 : ℝ) := by
          intro s hs
          have hf := E_fibre_sum Q e s hs
          calc ∑ s' ∈ E Q e, z ^ (2 : ℝ) * ((1 / (Fintype.card G : ℝ)) * ((univ.filter (fun t : G => act t s = s')).card : ℝ) * z ^ (4 : ℝ))
              = z ^ (2 : ℝ) * (1 / (Fintype.card G : ℝ)) * z ^ (4 : ℝ) * ∑ s' ∈ E Q e, ((univ.filter (fun t : G => act t s = s')).card : ℝ) := by
                rw [Finset.mul_sum]; apply Finset.sum_congr rfl; intro s' _; ring
            _ = z ^ (6 : ℝ) := by rw [hf, hz6]; field_simp
        rw [Finset.sum_congr rfl hrow, Finset.sum_const, nsmul_eq_mul]
    _ ≤ ∑ s ∈ E Q e, ∑ s' ∈ E Q e, Ttw Q z s s' :=
        Finset.sum_le_sum (fun s hs => Finset.sum_le_sum (fun s' hs' => Ttw_E_entry Q e z hz s s' hs hs'))

include e in
theorem lamMax_Ttw_ge (z : ℝ) (hz : 1 ≤ z) : z ^ (6 : ℝ) ≤ lamMax (Ttw Q z) (Ttw_herm Q z) := by
  have h := dot_mulVec_le (Ttw Q z) (Ttw_herm Q z) (eaterVec Q e)
  rw [eaterVec_dot] at h
  have h2 := eater_rayleigh Q e z hz
  have hE : (0 : ℝ) < (E Q e).card := by exact_mod_cast Finset.card_pos.mpr (E_nonempty Q e)
  nlinarith

end EaterOrbit

/-! ## the upper bounds: the row sums -/

theorem lamMax_le_rowsum (M : Matrix (G × G) (G × G) ℝ) (hM : M.IsHermitian) (hpos : ∀ i j, 0 < M i j) (R : ℝ)
    (hR : ∀ i, ∑ j, M i j ≤ R) : lamMax M hM ≤ R := by
  obtain ⟨a, hapos, ha, -⟩ := perron_exists M hM hpos
  obtain ⟨i₀, -, hi₀⟩ := Finset.exists_max_image univ a univ_nonempty
  have hrow : lamMax M hM * a i₀ = ∑ j, M i₀ j * a j := by
    have h := congrFun ha i₀
    simp only [mulVec, dotProduct, Pi.smul_apply, smul_eq_mul] at h
    linarith
  have hle : ∑ j, M i₀ j * a j ≤ (∑ j, M i₀ j) * a i₀ := by
    rw [Finset.sum_mul]
    apply Finset.sum_le_sum; intro j _
    exact mul_le_mul_of_nonneg_left (hi₀ j (mem_univ j)) (hpos i₀ j).le
  have hai : 0 < a i₀ := hapos i₀
  have hfin : lamMax M hM * a i₀ ≤ R * a i₀ := by
    calc lamMax M hM * a i₀ = ∑ j, M i₀ j * a j := hrow
      _ ≤ (∑ j, M i₀ j) * a i₀ := hle
      _ ≤ R * a i₀ := mul_le_mul_of_nonneg_right (hR i₀) hai.le
  exact le_of_mul_le_mul_right hfin hai

/-- a row as one sum over t of sums over s' -/
theorem row_as_sum (z : ℝ) (hz : 0 < z) (ex : (G × G) → (G × G) → ℝ) (s : G × G) :
    ∑ s', z ^ (ex s s') * K Q z s s' = (1 / (Fintype.card G : ℝ)) * ∑ t, ∑ s', z ^ (ex s s' + 2 * temp Q s s' t) := by
  have h1 : ∀ s' : G × G, z ^ (ex s s') * K Q z s s' = ∑ t, (1 / (Fintype.card G : ℝ)) * z ^ (ex s s' + 2 * temp Q s s' t) := by
    intro s'
    unfold K
    rw [Finset.mul_sum, Finset.mul_sum]
    apply Finset.sum_congr rfl; intro t _
    rw [Real.rpow_add hz]
    ring
  simp_rw [h1]
  rw [Finset.sum_comm, Finset.mul_sum]
  apply Finset.sum_congr rfl; intro t _
  rw [Finset.mul_sum]

/-- THE ROW BOUND: with every exponent ex ≤ 2, a row sums to at most z⁶ (1 + |G|² z^{−2δ}) -- for each temporal link one slice
at degree six (the zero-cost target act t s), every other slice 2δ lower -/
theorem row_bound (z : ℝ) (hz : 1 ≤ z) (ex : (G × G) → (G × G) → ℝ) (he : ∀ s s', ex s s' ≤ 2) (s : G × G) :
    ∑ s', z ^ (ex s s') * K Q z s s' ≤ z ^ (6 : ℝ) * (1 + ((Fintype.card G : ℝ)) ^ 2 * z ^ (-(2 * Q.δ))) := by
  have hz0 : 0 < z := lt_of_lt_of_le one_pos hz
  have hc := card_pos (G := G)
  rw [row_as_sum Q z hz0 ex s]
  have hin : ∀ t : G, ∑ s', z ^ (ex s s' + 2 * temp Q s s' t) ≤ z ^ (6 : ℝ) + ((Fintype.card G : ℝ)) ^ 2 * z ^ (6 - 2 * Q.δ) := by
    intro t
    rw [← Finset.add_sum_erase univ _ (Finset.mem_univ (act t s))]
    have hmain : z ^ (ex s (act t s) + 2 * temp Q s (act t s) t) ≤ z ^ (6 : ℝ) := by
      apply Real.rpow_le_rpow_of_exponent_le hz
      have h2 : temp Q s (act t s) t = 2 := (temp_eq_two_iff Q s _ t).mpr rfl
      have := he s (act t s)
      linarith
    have hrest : ∑ s' ∈ univ.erase (act t s), z ^ (ex s s' + 2 * temp Q s s' t) ≤ ((Fintype.card G : ℝ)) ^ 2 * z ^ (6 - 2 * Q.δ) := by
      calc ∑ s' ∈ univ.erase (act t s), z ^ (ex s s' + 2 * temp Q s s' t)
          ≤ ∑ s' ∈ univ.erase (act t s), z ^ (6 - 2 * Q.δ) := by
            apply Finset.sum_le_sum; intro s' hs'
            have hne : s' ≠ act t s := Finset.ne_of_mem_erase hs'
            apply Real.rpow_le_rpow_of_exponent_le hz
            have := temp_le_gap Q s s' t hne
            have := he s s'
            linarith
        _ = ((univ.erase (act t s)).card : ℝ) * z ^ (6 - 2 * Q.δ) := by rw [Finset.sum_const, nsmul_eq_mul]
        _ ≤ ((Fintype.card G : ℝ)) ^ 2 * z ^ (6 - 2 * Q.δ) := by
            apply mul_le_mul_of_nonneg_right _ (Real.rpow_nonneg hz0.le _)
            have hcard : (univ.erase (act t s)).card ≤ Fintype.card (G × G) := by
              calc (univ.erase (act t s)).card ≤ (univ : Finset (G × G)).card := Finset.card_erase_le
                _ = Fintype.card (G × G) := Finset.card_univ
            rw [Fintype.card_prod] at hcard
            have : ((univ.erase (act t s)).card : ℝ) ≤ (Fintype.card G : ℝ) * (Fintype.card G : ℝ) := by exact_mod_cast hcard
            nlinarith
    linarith
  have hsum : ∑ t : G, ∑ s', z ^ (ex s s' + 2 * temp Q s s' t) ≤ (Fintype.card G : ℝ) * (z ^ (6 : ℝ) + ((Fintype.card G : ℝ)) ^ 2 * z ^ (6 - 2 * Q.δ)) := by
    calc ∑ t : G, ∑ s', z ^ (ex s s' + 2 * temp Q s s' t) ≤ ∑ t : G, (z ^ (6 : ℝ) + ((Fintype.card G : ℝ)) ^ 2 * z ^ (6 - 2 * Q.δ)) :=
          Finset.sum_le_sum (fun t _ => hin t)
      _ = (Fintype.card G : ℝ) * (z ^ (6 : ℝ) + ((Fintype.card G : ℝ)) ^ 2 * z ^ (6 - 2 * Q.δ)) := by
          rw [Finset.sum_const, Finset.card_univ, nsmul_eq_mul]
  have hsplit : z ^ (6 - 2 * Q.δ) = z ^ (6 : ℝ) * z ^ (-(2 * Q.δ)) := by
    rw [← Real.rpow_add hz0]; ring_nf
  calc (1 / (Fintype.card G : ℝ)) * ∑ t : G, ∑ s', z ^ (ex s s' + 2 * temp Q s s' t)
      ≤ (1 / (Fintype.card G : ℝ)) * ((Fintype.card G : ℝ) * (z ^ (6 : ℝ) + ((Fintype.card G : ℝ)) ^ 2 * z ^ (6 - 2 * Q.δ))) :=
        mul_le_mul_of_nonneg_left hsum (by positivity)
    _ = z ^ (6 : ℝ) + ((Fintype.card G : ℝ)) ^ 2 * z ^ (6 - 2 * Q.δ) := by field_simp
    _ = z ^ (6 : ℝ) * (1 + ((Fintype.card G : ℝ)) ^ 2 * z ^ (-(2 * Q.δ))) := by rw [hsplit]; ring

theorem lamMax_T_le (z : ℝ) (hz : 1 ≤ z) :
    lamMax (T Q z) (T_herm Q z) ≤ z ^ (6 : ℝ) * (1 + ((Fintype.card G : ℝ)) ^ 2 * z ^ (-(2 * Q.δ))) := by
  have hz0 : 0 < z := lt_of_lt_of_le one_pos hz
  apply lamMax_le_rowsum _ _ (T_pos Q z hz0)
  intro s
  exact row_bound Q z hz (fun s s' => qP Q s + qP Q s')
    (fun s s' => by have := qP_le_one Q s; have := qP_le_one Q s'; linarith) s

theorem lamMax_Ttw_le (z : ℝ) (hz : 1 ≤ z) :
    lamMax (Ttw Q z) (Ttw_herm Q z) ≤ z ^ (6 : ℝ) * (1 + ((Fintype.card G : ℝ)) ^ 2 * z ^ (-(2 * Q.δ))) := by
  have hz0 : 0 < z := lt_of_lt_of_le one_pos hz
  apply lamMax_le_rowsum _ _ (Ttw_pos Q z hz0)
  intro s
  exact row_bound Q z hz (fun s s' => -(qP Q s) - qP Q s')
    (fun s s' => by have := qP_ge Q s; have := qP_ge Q s'; linarith) s

/-! ## THE EATER'S LAW -/

theorem eater_law (e : Eater G Q) (z : ℝ) (hz : 1 ≤ z) :
    z ^ (6 : ℝ) ≤ lamMax (T Q z) (T_herm Q z) ∧
    lamMax (T Q z) (T_herm Q z) ≤ z ^ (6 : ℝ) * (1 + ((Fintype.card G : ℝ)) ^ 2 * z ^ (-(2 * Q.δ))) ∧
    z ^ (6 : ℝ) ≤ lamMax (Ttw Q z) (Ttw_herm Q z) ∧
    lamMax (Ttw Q z) (Ttw_herm Q z) ≤ z ^ (6 : ℝ) * (1 + ((Fintype.card G : ℝ)) ^ 2 * z ^ (-(2 * Q.δ))) :=
  ⟨lamMax_T_ge Q z (lt_of_lt_of_le one_pos hz), lamMax_T_le Q z hz, lamMax_Ttw_ge Q e z hz, lamMax_Ttw_le Q z hz⟩

/-- the vortex string's rate -/
noncomputable def rate (z : ℝ) : ℝ := lamMax (Ttw Q z) (Ttw_herm Q z) / lamMax (T Q z) (T_herm Q z)

theorem rate_bounds (e : Eater G Q) (z : ℝ) (hz : 1 ≤ z) :
    (1 + ((Fintype.card G : ℝ)) ^ 2 * z ^ (-(2 * Q.δ)))⁻¹ ≤ rate Q z ∧
    rate Q z ≤ 1 + ((Fintype.card G : ℝ)) ^ 2 * z ^ (-(2 * Q.δ)) := by
  obtain ⟨h1, h2, h3, h4⟩ := eater_law Q e z hz
  have hz0 : 0 < z := lt_of_lt_of_le one_pos hz
  have h6 : 0 < z ^ (6 : ℝ) := Real.rpow_pos_of_pos hz0 _
  set c := 1 + ((Fintype.card G : ℝ)) ^ 2 * z ^ (-(2 * Q.δ)) with hc
  have hc1 : 1 ≤ c := by
    have : 0 ≤ ((Fintype.card G : ℝ)) ^ 2 * z ^ (-(2 * Q.δ)) := by
      have := Real.rpow_nonneg hz0.le (-(2 * Q.δ)); positivity
    linarith
  have hcpos : 0 < c := by linarith
  have hT : 0 < lamMax (T Q z) (T_herm Q z) := lt_of_lt_of_le h6 h1
  unfold rate
  constructor
  · rw [inv_eq_one_div, div_le_div_iff₀ hcpos hT]
    nlinarith [h2, h3, h6, hT]
  · rw [div_le_iff₀ hT]
    nlinarith [h1, h4, h6, hT, hcpos]

/-- m → 1 as β → ∞: the twisted sector's free energy per slice tends to the vacuum's, for every finite group with an eater -/
theorem rate_tendsto (e : Eater G Q) : Filter.Tendsto (rate Q) Filter.atTop (nhds 1) := by
  have h0 : Filter.Tendsto (fun z : ℝ => ((Fintype.card G : ℝ)) ^ 2 * z ^ (-(2 * Q.δ))) Filter.atTop (nhds 0) := by
    have := (tendsto_rpow_neg_atTop (by have := Q.δ_pos; positivity : (0 : ℝ) < 2 * Q.δ)).const_mul (((Fintype.card G : ℝ)) ^ 2)
    simpa using this
  have hhi : Filter.Tendsto (fun z : ℝ => 1 + ((Fintype.card G : ℝ)) ^ 2 * z ^ (-(2 * Q.δ))) Filter.atTop (nhds 1) := by
    simpa using tendsto_const_nhds.add h0
  have hlo : Filter.Tendsto (fun z : ℝ => (1 + ((Fintype.card G : ℝ)) ^ 2 * z ^ (-(2 * Q.δ)))⁻¹) Filter.atTop (nhds 1) := by
    simpa using hhi.inv₀ one_ne_zero
  refine tendsto_of_tendsto_of_tendsto_of_le_of_le' hlo hhi ?_ ?_
  · exact Filter.eventually_atTop.mpr ⟨1, fun z hz => (rate_bounds Q e z hz).1⟩
  · exact Filter.eventually_atTop.mpr ⟨1, fun z hz => (rate_bounds Q e z hz).2⟩

end TwistEaterGeneral
