/-
  APERANTON -- THE BOUNDLESS, THE COMPACT TIER, first section (the master plan note §57 RESULTS 10, 2026-10-28 23:1x): DOBRUSHIN'S
  TOTAL VARIATION OVER A PROBABILITY MEASURE. Dobrushin.lean carries the comparison theorem for a finite spin space, by finite sums;
  the strong-coupling gap of SU(2) itself (Osterwalder–Seiler 1978) needs the same theorem with the group's Haar measure in place
  of the sum. This file begins the port at its base: the total variation of two densities against a probability measure μ, its
  positive-part form (∫(p − p′)⁺ = tv when the densities have equal mass), and THE OSCILLATION INEQUALITY -- a bounded function of
  oscillation at most m integrated against the difference of two densities of equal mass is at most tv · m, proved by shifting the
  function to its supremum so that the shifted function lies in [−m, 0] and the two half-integrals of the difference each equal tv.
  The one-site conditionals, the sweep and the comparison theorem follow in the next sections, each the finite proof with ∫ for Σ.
  W = 0: Dobrushin 1968/1970; the measure-theoretic form is textbook; the port is this file's. No sorry, no axiom.
-/
import Mathlib
import Aperanton.Dobrushin

open MeasureTheory

namespace Aperanton

namespace Measure

variable {G : Type*} [MeasurableSpace G] (μ : MeasureTheory.Measure G) [IsProbabilityMeasure μ]

/-- the total-variation distance of two densities against μ: half the L¹ distance -/
noncomputable def tv (p p' : G → ℝ) : ℝ := (∫ g, |p g - p' g| ∂μ) / 2

theorem tv_nonneg (p p' : G → ℝ) : 0 ≤ tv μ p p' := by
  unfold tv
  exact div_nonneg (integral_nonneg fun g => abs_nonneg _) (by norm_num)

theorem tv_self (p : G → ℝ) : tv μ p p = 0 := by simp [tv]

theorem tv_comm (p p' : G → ℝ) : tv μ p p' = tv μ p' p := by
  unfold tv
  congr 1
  apply integral_congr_ae
  filter_upwards with g
  rw [abs_sub_comm]

/-- two densities of mass one are at distance at most one -/
theorem tv_le_one (p p' : G → ℝ) (hp : ∀ g, 0 ≤ p g) (hp' : ∀ g, 0 ≤ p' g)
    (hpi : Integrable p μ) (hpi' : Integrable p' μ)
    (h1 : ∫ g, p g ∂μ = 1) (h1' : ∫ g, p' g ∂μ = 1) : tv μ p p' ≤ 1 := by
  unfold tv
  have h : ∫ g, |p g - p' g| ∂μ ≤ ∫ g, (p g + p' g) ∂μ := by
    apply integral_mono (hpi.sub hpi').abs (hpi.add hpi')
    intro g
    simp only [Pi.sub_apply, Pi.add_apply]
    rw [abs_le]
    constructor <;> linarith [hp g, hp' g]
  rw [integral_add hpi hpi', h1, h1'] at h
  linarith

/-- the positive-part form: for densities of equal mass, tv = ∫ (p − p′)⁺ -/
theorem tv_eq_integral_pos (p p' : G → ℝ) (hpi : Integrable p μ) (hpi' : Integrable p' μ)
    (heq : ∫ g, p g ∂μ = ∫ g, p' g ∂μ) :
    tv μ p p' = ∫ g, max (p g - p' g) 0 ∂μ := by
  have habs : ∀ x : ℝ, |x| = 2 * max x 0 - x := by
    intro x
    rcases le_or_gt 0 x with hx | hx
    · rw [abs_of_nonneg hx, max_eq_left hx]; ring
    · rw [abs_of_neg hx, max_eq_right hx.le]; ring
  have hd : Integrable (fun g => p g - p' g) μ := hpi.sub hpi'
  have hm : Integrable (fun g => max (p g - p' g) 0) μ := hd.pos_part
  have hzero : ∫ g, (p g - p' g) ∂μ = 0 := by rw [integral_sub hpi hpi', heq, sub_self]
  unfold tv
  have : ∫ g, |p g - p' g| ∂μ = ∫ g, (2 * max (p g - p' g) 0 - (p g - p' g)) ∂μ := by
    apply integral_congr_ae
    filter_upwards with g
    exact habs _
  rw [this, integral_sub (hm.const_mul 2) hd, hzero, sub_zero, integral_const_mul]
  ring

/-- the negative-part form, by symmetry -/
theorem tv_eq_integral_neg (p p' : G → ℝ) (hpi : Integrable p μ) (hpi' : Integrable p' μ)
    (heq : ∫ g, p g ∂μ = ∫ g, p' g ∂μ) :
    tv μ p p' = ∫ g, max (p' g - p g) 0 ∂μ := by
  rw [tv_comm]
  exact tv_eq_integral_pos μ p' p hpi' hpi heq.symm

/-- THE POINTWISE RATIO BOUND: densities of mass one with p ≤ r p′ pointwise are at distance at most 1 − 1/r -/
theorem tv_le_of_pointwise (p p' : G → ℝ) (hp : ∀ g, 0 ≤ p g) (hpi : Integrable p μ) (hpi' : Integrable p' μ)
    (h1 : ∫ g, p g ∂μ = 1) (h1' : ∫ g, p' g ∂μ = 1) (r : ℝ) (hr : 1 ≤ r) (hpp : ∀ g, p g ≤ r * p' g) :
    tv μ p p' ≤ 1 - 1 / r := by
  have hr0 : 0 < r := by linarith
  have hr1 : 1 / r ≤ 1 := by rw [div_le_one hr0]; exact hr
  have hmax : ∀ g, max (p g - p' g) 0 ≤ (1 - 1 / r) * p g := by
    intro g
    have hp'g : p g / r ≤ p' g := by rw [div_le_iff₀ hr0]; linarith [hpp g]
    apply max_le
    · have : p g - p' g ≤ p g - p g / r := by linarith
      calc p g - p' g ≤ p g - p g / r := this
        _ = (1 - 1 / r) * p g := by ring
    · exact mul_nonneg (by linarith) (hp g)
  rw [tv_eq_integral_pos μ p p' hpi hpi' (by rw [h1, h1'])]
  calc ∫ g, max (p g - p' g) 0 ∂μ ≤ ∫ g, (1 - 1 / r) * p g ∂μ :=
        integral_mono (hpi.sub hpi').pos_part (hpi.const_mul _) hmax
    _ = (1 - 1 / r) * ∫ g, p g ∂μ := integral_const_mul _ _
    _ = 1 - 1 / r := by rw [h1, mul_one]

/-- THE OSCILLATION INEQUALITY over a measure: a bounded function h of oscillation at most m, integrated against the difference
of two densities of equal mass, is at most tv · m in absolute value -/
theorem abs_integral_sub_mul_le [Nonempty G] (p p' h : G → ℝ) (hpi : Integrable p μ) (hpi' : Integrable p' μ)
    (hh : Measurable h) (heq : ∫ g, p g ∂μ = ∫ g, p' g ∂μ) (m : ℝ) (hm : ∀ g g', |h g - h g'| ≤ m) :
    |∫ g, (p g - p' g) * h g ∂μ| ≤ tv μ p p' * m := by
  obtain ⟨g₀⟩ : Nonempty G := inferInstance
  -- h is bounded: every value within m of h g₀
  have hbdd : ∀ g, |h g| ≤ |h g₀| + m := by
    intro g
    calc |h g| = |(h g - h g₀) + h g₀| := by ring_nf
      _ ≤ |h g - h g₀| + |h g₀| := abs_add_le _ _
      _ ≤ m + |h g₀| := add_le_add (hm g g₀) le_rfl
      _ = |h g₀| + m := add_comm _ _
  have hm0 : 0 ≤ m := le_trans (abs_nonneg _) (hm g₀ g₀)
  -- the supremum c of h: h ≤ c ≤ h + m pointwise
  have hbdd_above : BddAbove (Set.range h) := ⟨|h g₀| + m, by rintro _ ⟨g, rfl⟩; exact le_trans (le_abs_self _) (hbdd g)⟩
  set c := ⨆ g, h g with hc
  have hle : ∀ g, h g ≤ c := fun g => le_ciSup hbdd_above g
  have hge : ∀ g, c ≤ h g + m := by
    intro g
    apply ciSup_le
    intro g'
    have := (abs_le.mp (hm g' g)).2
    linarith
  have hd : Integrable (fun g => p g - p' g) μ := hpi.sub hpi'
  have hzero : ∫ g, (p g - p' g) ∂μ = 0 := by rw [integral_sub hpi hpi', heq, sub_self]
  -- the integrand's shift: (p − p′) h = (p − p′)(h − c) + (p − p′) c
  have hint_h : Integrable (fun g => (p g - p' g) * h g) μ :=
    hd.mul_bdd hh.aestronglyMeasurable (Filter.Eventually.of_forall fun g => by rw [Real.norm_eq_abs]; exact hbdd g)
  have hshift : ∫ g, (p g - p' g) * h g ∂μ = ∫ g, (p g - p' g) * (h g - c) ∂μ := by
    have : ∫ g, (p g - p' g) * (h g - c) ∂μ = ∫ g, (p g - p' g) * h g ∂μ - c * ∫ g, (p g - p' g) ∂μ := by
      rw [← integral_const_mul, ← integral_sub hint_h (hd.const_mul c)]
      apply integral_congr_ae
      filter_upwards with g
      ring
    rw [this, hzero, mul_zero, sub_zero]
  rw [hshift]
  -- bound: (p − p′)(h − c) ≤ (p′ − p)⁺ · m and ≥ −(p − p′)⁺ · m pointwise, since −m ≤ h − c ≤ 0
  have hpt_up : ∀ g, (p g - p' g) * (h g - c) ≤ max (p' g - p g) 0 * m := by
    intro g
    have h1 : h g - c ≤ 0 := by linarith [hle g]
    have h2 : -m ≤ h g - c := by linarith [hge g]
    rcases le_or_gt (p g) (p' g) with hpp | hpp
    · -- p ≤ p′: the product is (nonpositive) × (nonpositive) ≤ (p′ − p) m
      rw [max_eq_left (by linarith)]
      nlinarith
    · -- p > p′: the product is nonpositive ≤ 0 = max(...)·m
      rw [max_eq_right (by linarith), zero_mul]
      nlinarith
  have hpt_lo : ∀ g, -(max (p g - p' g) 0 * m) ≤ (p g - p' g) * (h g - c) := by
    intro g
    have h1 : h g - c ≤ 0 := by linarith [hle g]
    have h2 : -m ≤ h g - c := by linarith [hge g]
    rcases le_or_gt (p' g) (p g) with hpp | hpp
    · rw [max_eq_left (by linarith)]
      nlinarith
    · rw [max_eq_right (by linarith), zero_mul, neg_zero]
      nlinarith
  have hint_shift : Integrable (fun g => (p g - p' g) * (h g - c)) μ :=
    hd.mul_bdd ((hh.sub measurable_const).aestronglyMeasurable) (Filter.Eventually.of_forall fun g => by
      rw [Real.norm_eq_abs, abs_le]; constructor <;> linarith [hle g, hge g])
  have hup : ∫ g, (p g - p' g) * (h g - c) ∂μ ≤ tv μ p p' * m := by
    calc ∫ g, (p g - p' g) * (h g - c) ∂μ ≤ ∫ g, max (p' g - p g) 0 * m ∂μ :=
          integral_mono hint_shift ((hpi'.sub hpi).pos_part.mul_const m) hpt_up
      _ = (∫ g, max (p' g - p g) 0 ∂μ) * m := integral_mul_const _ _
      _ = tv μ p p' * m := by rw [← tv_eq_integral_neg μ p p' hpi hpi' heq]
  have hlo : -(tv μ p p' * m) ≤ ∫ g, (p g - p' g) * (h g - c) ∂μ := by
    calc -(tv μ p p' * m) = -((∫ g, max (p g - p' g) 0 ∂μ) * m) := by rw [← tv_eq_integral_pos μ p p' hpi hpi' heq]
      _ = ∫ g, -(max (p g - p' g) 0 * m) ∂μ := by rw [integral_neg, integral_mul_const]
      _ ≤ ∫ g, (p g - p' g) * (h g - c) ∂μ :=
          integral_mono ((hpi.sub hpi').pos_part.mul_const m).neg hint_shift hpt_lo
  rw [abs_le]
  exact ⟨hlo, hup⟩

section Gibbs

variable {S : Type*} [Fintype S] [DecidableEq S] {G : Type*} [MeasurableSpace G] (μ : MeasureTheory.Measure G)
  [IsProbabilityMeasure μ] [Nonempty G]

/-- the product measure on configurations S → G -/
noncomputable abbrev conf : MeasureTheory.Measure (S → G) := MeasureTheory.Measure.pi (fun _ : S => μ)

/-- a bounded measurable real function on a finite measure space is integrable -/
theorem integrable_of_abs_le {α : Type*} [MeasurableSpace α] (ν : MeasureTheory.Measure α) [IsFiniteMeasure ν]
    (f : α → ℝ) (hf : AEStronglyMeasurable f ν) (K : ℝ) (hK : ∀ x, |f x| ≤ K) : Integrable f ν :=
  (integrable_const K).mono' hf (Filter.Eventually.of_forall fun x => by rw [Real.norm_eq_abs]; exact hK x)

/-- the update at s, as a measurable map of the spin -/
theorem measurable_update_spin (ω : S → G) (s : S) : Measurable (fun g : G => Function.update ω s g) :=
  measurable_update ω (a := s)

/-- THE WEIGHT: measurable, bounded away from zero and bounded above -/
structure Weight (W : (S → G) → ℝ) (m M : ℝ) : Prop where
  meas : Measurable W
  mpos : 0 < m
  lo : ∀ ω, m ≤ W ω
  hi : ∀ ω, W ω ≤ M

theorem Weight.pos {W : (S → G) → ℝ} {m M : ℝ} (h : Weight W m M) (ω : S → G) : 0 < W ω :=
  lt_of_lt_of_le h.mpos (h.lo ω)

theorem Weight.abs_le {W : (S → G) → ℝ} {m M : ℝ} (h : Weight W m M) (ω : S → G) : |W ω| ≤ M := by
  rw [abs_of_pos (h.pos ω)]; exact h.hi ω

/-- AN OBSERVABLE: measurable and bounded by K in absolute value -/
structure Obs (f : (S → G) → ℝ) (K : ℝ) : Prop where
  meas : Measurable f
  bd : ∀ ω, |f ω| ≤ K

theorem Obs.nonneg_K {f : (S → G) → ℝ} {K : ℝ} (h : Obs f K) : 0 ≤ K := by
  obtain ⟨ω⟩ : Nonempty (S → G) := ⟨fun _ => Classical.arbitrary G⟩
  exact le_trans (abs_nonneg _) (h.bd ω)

/-- the Gibbs expectation of f under the weight W -/
noncomputable def gibbs (W : (S → G) → ℝ) (f : (S → G) → ℝ) : ℝ :=
  (∫ ω, W ω * f ω ∂(conf μ)) / ∫ ω, W ω ∂(conf μ)

/-- the one-site partition function at s -/
noncomputable def zsite (W : (S → G) → ℝ) (s : S) (ω : S → G) : ℝ := ∫ g, W (Function.update ω s g) ∂μ

/-- the one-site conditional density at s -/
noncomputable def cond (W : (S → G) → ℝ) (s : S) (ω : S → G) (g : G) : ℝ :=
  W (Function.update ω s g) / zsite μ W s ω

/-- the one-site conditional expectation at s -/
noncomputable def condExp (W : (S → G) → ℝ) (s : S) (f : (S → G) → ℝ) (ω : S → G) : ℝ :=
  ∫ g, cond μ W s ω g * f (Function.update ω s g) ∂μ

variable {μ}

theorem integrable_W_update {W : (S → G) → ℝ} {m M : ℝ} (hW : Weight W m M) (s : S) (ω : S → G) :
    Integrable (fun g => W (Function.update ω s g)) μ :=
  integrable_of_abs_le μ _ (hW.meas.comp (measurable_update_spin ω s)).aestronglyMeasurable M
    (fun g => hW.abs_le _)

theorem integrable_W {W : (S → G) → ℝ} {m M : ℝ} (hW : Weight W m M) : Integrable W (conf μ) :=
  integrable_of_abs_le (conf μ) W hW.meas.aestronglyMeasurable M hW.abs_le

theorem integrable_W_mul {W : (S → G) → ℝ} {m M : ℝ} (hW : Weight W m M) {f : (S → G) → ℝ} {K : ℝ}
    (hf : Obs f K) : Integrable (fun ω => W ω * f ω) (conf μ) :=
  integrable_of_abs_le (conf μ) _ (hW.meas.mul hf.meas).aestronglyMeasurable (M * K) (fun ω => by
    rw [abs_mul]
    exact mul_le_mul (hW.abs_le ω) (hf.bd ω) (abs_nonneg _) (le_trans (abs_nonneg _) (hW.abs_le ω)))

theorem integral_W_pos {W : (S → G) → ℝ} {m M : ℝ} (hW : Weight W m M) : 0 < ∫ ω, W ω ∂(conf μ) := by
  have h := integral_mono (integrable_const (μ := conf μ) m) (integrable_W (μ := μ) hW) hW.lo
  simp only [integral_const, probReal_univ, one_smul] at h
  exact lt_of_lt_of_le hW.mpos h

theorem zsite_pos {W : (S → G) → ℝ} {m M : ℝ} (hW : Weight W m M) (s : S) (ω : S → G) : 0 < zsite μ W s ω := by
  unfold zsite
  have h := integral_mono (integrable_const (μ := μ) m) (integrable_W_update (μ := μ) hW s ω) (fun g => hW.lo _)
  simp only [integral_const, probReal_univ, one_smul] at h
  exact lt_of_lt_of_le hW.mpos h

theorem zsite_update (W : (S → G) → ℝ) (s : S) (ω : S → G) (g : G) :
    zsite μ W s (Function.update ω s g) = zsite μ W s ω := by
  simp only [zsite, Function.update_idem]

theorem cond_nonneg {W : (S → G) → ℝ} {m M : ℝ} (hW : Weight W m M) (s : S) (ω : S → G) (g : G) :
    0 ≤ cond μ W s ω g :=
  div_nonneg (hW.pos _).le (zsite_pos hW s ω).le

theorem cond_integrable {W : (S → G) → ℝ} {m M : ℝ} (hW : Weight W m M) (s : S) (ω : S → G) :
    Integrable (cond μ W s ω) μ := by
  unfold cond
  exact (integrable_W_update hW s ω).div_const _

theorem cond_integral {W : (S → G) → ℝ} {m M : ℝ} (hW : Weight W m M) (s : S) (ω : S → G) :
    ∫ g, cond μ W s ω g ∂μ = 1 := by
  unfold cond
  rw [integral_div]
  exact div_self (zsite_pos hW s ω).ne'

theorem cond_update (W : (S → G) → ℝ) (s : S) (ω : S → G) (g : G) :
    cond μ W s (Function.update ω s g) = cond μ W s ω := by
  funext g'
  simp only [cond, Function.update_idem, zsite_update]

theorem condExp_update (W : (S → G) → ℝ) (s : S) (f : (S → G) → ℝ) (ω : S → G) (g : G) :
    condExp μ W s f (Function.update ω s g) = condExp μ W s f ω := by
  simp only [condExp, cond_update, Function.update_idem]

/-- the conditional expectation of a bounded observable is bounded by the same constant -/
theorem abs_condExp_le {W : (S → G) → ℝ} {m M : ℝ} (hW : Weight W m M) (s : S) {f : (S → G) → ℝ} {K : ℝ}
    (hf : Obs f K) (ω : S → G) : |condExp μ W s f ω| ≤ K := by
  unfold condExp
  have hint : Integrable (fun g => cond μ W s ω g * f (Function.update ω s g)) μ :=
    (cond_integrable hW s ω).mul_bdd (hf.meas.comp (measurable_update_spin ω s)).aestronglyMeasurable
      (Filter.Eventually.of_forall fun g => by rw [Real.norm_eq_abs]; exact hf.bd _)
  calc |∫ g, cond μ W s ω g * f (Function.update ω s g) ∂μ|
      ≤ ∫ g, |cond μ W s ω g * f (Function.update ω s g)| ∂μ := abs_integral_le_integral_abs
    _ ≤ ∫ g, cond μ W s ω g * K ∂μ := by
        apply integral_mono hint.abs ((cond_integrable hW s ω).mul_const K)
        intro g
        dsimp only
        rw [abs_mul, abs_of_nonneg (cond_nonneg hW s ω g)]
        exact mul_le_mul_of_nonneg_left (hf.bd _) (cond_nonneg hW s ω g)
    _ = K := by rw [integral_mul_const, cond_integral hW s ω, one_mul]

/-- the conditional expectation is a measurable function of the configuration -/
theorem measurable_zsite {W : (S → G) → ℝ} {m M : ℝ} (hW : Weight W m M) (s : S) : Measurable (zsite μ W s) := by
  unfold zsite
  have : Measurable (fun p : (S → G) × G => W (Function.update p.1 s p.2)) :=
    hW.meas.comp measurable_update'
  exact (this.stronglyMeasurable.integral_prod_right').measurable

theorem measurable_condExp {W : (S → G) → ℝ} {m M : ℝ} (hW : Weight W m M) (s : S) {f : (S → G) → ℝ} {K : ℝ}
    (hf : Obs f K) : Measurable (condExp μ W s f) := by
  unfold condExp cond
  have h1 : Measurable (fun p : (S → G) × G => W (Function.update p.1 s p.2) / zsite μ W s p.1 *
      f (Function.update p.1 s p.2)) :=
    ((hW.meas.comp measurable_update').div ((measurable_zsite hW s).comp measurable_fst)).mul
      (hf.meas.comp measurable_update')
  exact (h1.stronglyMeasurable.integral_prod_right').measurable

theorem condExp_obs {W : (S → G) → ℝ} {m M : ℝ} (hW : Weight W m M) (s : S) {f : (S → G) → ℝ} {K : ℝ}
    (hf : Obs f K) : Obs (condExp μ W s f) K :=
  ⟨measurable_condExp hW s hf, abs_condExp_le hW s hf⟩

theorem gibbs_sub {W : (S → G) → ℝ} {m M : ℝ} (hW : Weight W m M) {f h : (S → G) → ℝ} {K L : ℝ}
    (hf : Obs f K) (hh : Obs h L) : gibbs μ W (fun ω => f ω - h ω) = gibbs μ W f - gibbs μ W h := by
  unfold gibbs
  rw [← sub_div]
  congr 1
  rw [← integral_sub (integrable_W_mul hW hf) (integrable_W_mul hW hh)]
  apply integral_congr_ae
  filter_upwards with ω
  ring

theorem abs_gibbs_le {W : (S → G) → ℝ} {m M : ℝ} (hW : Weight W m M) {f : (S → G) → ℝ} {K : ℝ} (hf : Obs f K)
    (L : ℝ) (hL : ∀ ω, |f ω| ≤ L) : |gibbs μ W f| ≤ L := by
  have hZ := integral_W_pos (μ := μ) hW
  unfold gibbs
  rw [abs_div, abs_of_pos hZ, div_le_iff₀ hZ]
  calc |∫ ω, W ω * f ω ∂(conf μ)| ≤ ∫ ω, |W ω * f ω| ∂(conf μ) := abs_integral_le_integral_abs
    _ ≤ ∫ ω, W ω * L ∂(conf μ) := by
        apply integral_mono (integrable_W_mul hW hf).abs ((integrable_W hW).mul_const L)
        intro ω
        dsimp only
        rw [abs_mul, abs_of_pos (hW.pos ω)]
        exact mul_le_mul_of_nonneg_left (hL ω) (hW.pos ω).le
    _ = L * ∫ ω, W ω ∂(conf μ) := by rw [integral_mul_const, mul_comm]

theorem gibbs_le_of_le {W : (S → G) → ℝ} {m M : ℝ} (hW : Weight W m M) {f : (S → G) → ℝ} {K : ℝ} (hf : Obs f K)
    (L : ℝ) (hL : ∀ ω, f ω ≤ L) : gibbs μ W f ≤ L := by
  have hZ := integral_W_pos (μ := μ) hW
  unfold gibbs
  rw [div_le_iff₀ hZ]
  calc ∫ ω, W ω * f ω ∂(conf μ) ≤ ∫ ω, W ω * L ∂(conf μ) := by
        apply integral_mono (integrable_W_mul hW hf) ((integrable_W hW).mul_const L)
        intro ω
        exact mul_le_mul_of_nonneg_left (hL ω) (hW.pos ω).le
    _ = L * ∫ ω, W ω ∂(conf μ) := by rw [integral_mul_const, mul_comm]

theorem le_gibbs_of_le {W : (S → G) → ℝ} {m M : ℝ} (hW : Weight W m M) {f : (S → G) → ℝ} {K : ℝ} (hf : Obs f K)
    (L : ℝ) (hL : ∀ ω, L ≤ f ω) : L ≤ gibbs μ W f := by
  have hZ := integral_W_pos (μ := μ) hW
  unfold gibbs
  rw [le_div_iff₀ hZ]
  calc L * ∫ ω, W ω ∂(conf μ) = ∫ ω, W ω * L ∂(conf μ) := by rw [integral_mul_const, mul_comm]
    _ ≤ ∫ ω, W ω * f ω ∂(conf μ) := by
        apply integral_mono ((integrable_W hW).mul_const L) (integrable_W_mul hW hf)
        intro ω
        exact mul_le_mul_of_nonneg_left (hL ω) (hW.pos ω).le

/-- two Gibbs expectations of one bounded function differ by at most its oscillation -/
theorem abs_gibbs_sub_gibbs_le {W W' : (S → G) → ℝ} {m M m' M' : ℝ} (hW : Weight W m M) (hW' : Weight W' m' M')
    {f : (S → G) → ℝ} {K : ℝ} (hf : Obs f K) (Mo : ℝ) (hMo : ∀ ω ω', |f ω - f ω'| ≤ Mo) :
    |gibbs μ W' f - gibbs μ W f| ≤ Mo := by
  obtain ⟨ω₀⟩ : Nonempty (S → G) := ⟨fun _ => Classical.arbitrary G⟩
  have hbdd : BddAbove (Set.range f) := ⟨K, by rintro _ ⟨ω, rfl⟩; exact le_trans (le_abs_self _) (hf.bd ω)⟩
  have hbdd' : BddBelow (Set.range f) := ⟨-K, by rintro _ ⟨ω, rfl⟩; exact neg_le_of_abs_le (hf.bd ω)⟩
  set c := ⨆ ω, f ω with hc
  set c' := ⨅ ω, f ω with hc'
  have h1 := gibbs_le_of_le (μ := μ) hW' hf c (fun ω => le_ciSup hbdd ω)
  have h2 := le_gibbs_of_le (μ := μ) hW' hf c' (fun ω => ciInf_le hbdd' ω)
  have h3 := gibbs_le_of_le (μ := μ) hW hf c (fun ω => le_ciSup hbdd ω)
  have h4 := le_gibbs_of_le (μ := μ) hW hf c' (fun ω => ciInf_le hbdd' ω)
  have hw : c - c' ≤ Mo := by
    have : c ≤ c' + Mo := by
      apply ciSup_le
      intro ω
      have : f ω - Mo ≤ c' := by
        apply le_ciInf
        intro ω'
        have := (abs_le.mp (hMo ω ω')).2
        linarith
      linarith
    linarith
  rw [abs_le]
  constructor <;> linarith

/-- an oscillation bound: changing one site s moves f by at most d s -/
def OscBound (f : (S → G) → ℝ) (d : S → ℝ) : Prop :=
  ∀ s ω g g', |f (Function.update ω s g) - f (Function.update ω s g')| ≤ d s

variable (μ) in
/-- an interdependence bound: changing site t moves site s's conditional by at most C s t -/
def Interdep (W : (S → G) → ℝ) (C : S → S → ℝ) : Prop :=
  ∀ s t, s ≠ t → ∀ ω h, tv μ (cond μ W s ω) (cond μ W s (Function.update ω t h)) ≤ C s t

variable (μ) in
/-- a discrepancy bound between two weights' conditionals -/
def Discrep (W W' : (S → G) → ℝ) (b : S → ℝ) : Prop :=
  ∀ s ω, tv μ (cond μ W s ω) (cond μ W' s ω) ≤ b s

theorem oscBound_nonneg {f : (S → G) → ℝ} {d : S → ℝ} (hf : OscBound f d) (s : S) : 0 ≤ d s := by
  obtain ⟨ω⟩ : Nonempty (S → G) := ⟨fun _ => Classical.arbitrary G⟩
  have := hf s ω (ω s) (ω s)
  exact le_trans (abs_nonneg _) this

/-- LEMMA A: the conditional expectation at s carries the stepped bound (Dobrushin.lean's stepB, reused) -/
theorem oscBound_condExp {W : (S → G) → ℝ} {m M : ℝ} (hW : Weight W m M) (C : S → S → ℝ)
    (hC : Interdep μ W C) {f : (S → G) → ℝ} {K : ℝ} (hf : Obs f K) (d : S → ℝ) (hfd : OscBound f d) (s : S) :
    OscBound (condExp μ W s f) (stepB C s d) := by
  intro t ω g g'
  by_cases hts : t = s
  · subst hts
    rw [condExp_update, condExp_update, sub_self, abs_zero, stepB_self]
  · rw [stepB_of_ne C s d hts]
    set ω₁ := Function.update ω t g with hω₁
    set ω₂ := Function.update ω t g' with hω₂
    have hmeas1 : Measurable (fun x => f (Function.update ω₁ s x)) := hf.meas.comp (measurable_update_spin ω₁ s)
    have hmeas2 : Measurable (fun x => f (Function.update ω₂ s x)) := hf.meas.comp (measurable_update_spin ω₂ s)
    have hi1 : Integrable (fun x => cond μ W s ω₁ x * f (Function.update ω₁ s x)) μ :=
      (cond_integrable hW s ω₁).mul_bdd hmeas1.aestronglyMeasurable (Filter.Eventually.of_forall fun x => by rw [Real.norm_eq_abs]; exact hf.bd _)
    have hi2 : Integrable (fun x => cond μ W s ω₂ x * f (Function.update ω₁ s x)) μ :=
      (cond_integrable hW s ω₂).mul_bdd hmeas1.aestronglyMeasurable (Filter.Eventually.of_forall fun x => by rw [Real.norm_eq_abs]; exact hf.bd _)
    have hi3 : Integrable (fun x => cond μ W s ω₂ x * f (Function.update ω₂ s x)) μ :=
      (cond_integrable hW s ω₂).mul_bdd hmeas2.aestronglyMeasurable (Filter.Eventually.of_forall fun x => by rw [Real.norm_eq_abs]; exact hf.bd _)
    have hsplit : condExp μ W s f ω₁ - condExp μ W s f ω₂ =
        ∫ x, (cond μ W s ω₁ x - cond μ W s ω₂ x) * f (Function.update ω₁ s x) ∂μ +
        ∫ x, cond μ W s ω₂ x * (f (Function.update ω₁ s x) - f (Function.update ω₂ s x)) ∂μ := by
      unfold condExp
      have hA : Integrable (fun x => (cond μ W s ω₁ x - cond μ W s ω₂ x) * f (Function.update ω₁ s x)) μ :=
        (hi1.sub hi2).congr (Filter.Eventually.of_forall fun x => by simp only [Pi.sub_apply]; ring)
      have hB : Integrable (fun x => cond μ W s ω₂ x * (f (Function.update ω₁ s x) - f (Function.update ω₂ s x))) μ :=
        (hi2.sub hi3).congr (Filter.Eventually.of_forall fun x => by simp only [Pi.sub_apply]; ring)
      rw [← integral_sub hi1 hi3, ← integral_add hA hB]
      apply integral_congr_ae
      filter_upwards with x
      ring
    rw [hsplit]
    have hst : s ≠ t := fun h => hts h.symm
    have h1 : |∫ x, (cond μ W s ω₁ x - cond μ W s ω₂ x) * f (Function.update ω₁ s x) ∂μ| ≤ C s t * d s := by
      have hω₂' : ω₂ = Function.update ω₁ t g' := by rw [hω₁, hω₂, Function.update_idem]
      have htv : tv μ (cond μ W s ω₁) (cond μ W s ω₂) ≤ C s t := by rw [hω₂']; exact hC s t hst ω₁ g'
      calc |∫ x, (cond μ W s ω₁ x - cond μ W s ω₂ x) * f (Function.update ω₁ s x) ∂μ|
          ≤ tv μ (cond μ W s ω₁) (cond μ W s ω₂) * d s :=
            abs_integral_sub_mul_le μ _ _ _ (cond_integrable hW s ω₁) (cond_integrable hW s ω₂) hmeas1
              (by rw [cond_integral hW s ω₁, cond_integral hW s ω₂]) (d s) (fun x x' => hfd s ω₁ x x')
        _ ≤ C s t * d s := mul_le_mul_of_nonneg_right htv (oscBound_nonneg hfd s)
    have h2 : |∫ x, cond μ W s ω₂ x * (f (Function.update ω₁ s x) - f (Function.update ω₂ s x)) ∂μ| ≤ d t := by
      calc |∫ x, cond μ W s ω₂ x * (f (Function.update ω₁ s x) - f (Function.update ω₂ s x)) ∂μ|
          ≤ ∫ x, |cond μ W s ω₂ x * (f (Function.update ω₁ s x) - f (Function.update ω₂ s x))| ∂μ :=
            abs_integral_le_integral_abs
        _ ≤ ∫ x, cond μ W s ω₂ x * d t ∂μ := by
            have hi23 : Integrable (fun x => cond μ W s ω₂ x * (f (Function.update ω₁ s x) - f (Function.update ω₂ s x))) μ :=
              (hi2.sub hi3).congr (Filter.Eventually.of_forall fun x => by simp only [Pi.sub_apply]; ring)
            apply integral_mono hi23.abs ((cond_integrable hW s ω₂).mul_const _)
            intro x
            dsimp only
            rw [abs_mul, abs_of_nonneg (cond_nonneg hW s ω₂ x)]
            refine mul_le_mul_of_nonneg_left ?_ (cond_nonneg hW s ω₂ x)
            have e1 : Function.update ω₁ s x = Function.update (Function.update ω s x) t g := by
              rw [hω₁, Function.update_comm hts]
            have e2 : Function.update ω₂ s x = Function.update (Function.update ω s x) t g' := by
              rw [hω₂, Function.update_comm hts]
            rw [e1, e2]
            exact hfd t _ g g'
        _ = d t := by rw [integral_mul_const, cond_integral hW s ω₂, one_mul]
    calc |∫ x, (cond μ W s ω₁ x - cond μ W s ω₂ x) * f (Function.update ω₁ s x) ∂μ +
          ∫ x, cond μ W s ω₂ x * (f (Function.update ω₁ s x) - f (Function.update ω₂ s x)) ∂μ|
        ≤ |∫ x, (cond μ W s ω₁ x - cond μ W s ω₂ x) * f (Function.update ω₁ s x) ∂μ| +
          |∫ x, cond μ W s ω₂ x * (f (Function.update ω₁ s x) - f (Function.update ω₂ s x)) ∂μ| := abs_add_le _ _
      _ ≤ C s t * d s + d t := add_le_add h1 h2
      _ = d t + C s t * d s := by ring

/-- THE GLOBAL OSCILLATION: changing every site moves f by at most Σ d -/
theorem abs_sub_le_sum_osc (f : (S → G) → ℝ) (d : S → ℝ) (hf : OscBound f d) (ω ω' : S → G) :
    |f ω - f ω'| ≤ ∑ t, d t := by
  have key : ∀ T : Finset S, |f (fun t => if t ∈ T then ω' t else ω t) - f ω| ≤ ∑ t ∈ T, d t := by
    intro T
    induction T using Finset.induction_on with
    | empty => simp
    | @insert s T hs ih =>
      set P : S → G := fun t => if t ∈ T then ω' t else ω t with hP
      have hpatch : (fun t => if t ∈ insert s T then ω' t else ω t) = Function.update P s (ω' s) := by
        funext t
        by_cases hts : t = s
        · subst hts; simp [hP]
        · simp [hP, Function.update_of_ne hts, hts]
      rw [Finset.sum_insert hs, hpatch]
      have hstep : |f (Function.update P s (ω' s)) - f P| ≤ d s := by
        have := hf s P (ω' s) (P s)
        rwa [Function.update_eq_self] at this
      calc |f (Function.update P s (ω' s)) - f ω|
          = |(f (Function.update P s (ω' s)) - f P) + (f P - f ω)| := by rw [sub_add_sub_cancel]
        _ ≤ |f (Function.update P s (ω' s)) - f P| + |f P - f ω| := abs_add_le _ _
        _ ≤ d s + ∑ t ∈ T, d t := add_le_add hstep ih
  have := key Finset.univ
  simp only [Finset.mem_univ, if_true] at this
  rw [abs_sub_comm]
  exact this

/-- the conditional expectation is linear under adding a constant -/
theorem condExp_add_const {W : (S → G) → ℝ} {m M : ℝ} (hW : Weight W m M) (s : S) {f : (S → G) → ℝ} {K : ℝ}
    (hf : Obs f K) (c : ℝ) (ω : S → G) :
    condExp μ W s (fun ω' => f ω' + c) ω = condExp μ W s f ω + c := by
  unfold condExp
  have hi : Integrable (fun g => cond μ W s ω g * f (Function.update ω s g)) μ :=
    (cond_integrable hW s ω).mul_bdd (hf.meas.comp (measurable_update_spin ω s)).aestronglyMeasurable
      (Filter.Eventually.of_forall fun g => by rw [Real.norm_eq_abs]; exact hf.bd _)
  have : (fun g => cond μ W s ω g * (f (Function.update ω s g) + c))
      = fun g => cond μ W s ω g * f (Function.update ω s g) + cond μ W s ω g * c := by
    funext g; ring
  rw [this, integral_add hi ((cond_integrable hW s ω).mul_const c), integral_mul_const, cond_integral hW s ω, one_mul]

theorem gibbs_add_const {W : (S → G) → ℝ} {m M : ℝ} (hW : Weight W m M) {f : (S → G) → ℝ} {K : ℝ} (hf : Obs f K)
    (c : ℝ) : gibbs μ W (fun ω => f ω + c) = gibbs μ W f + c := by
  unfold gibbs
  have hZ := integral_W_pos (μ := μ) hW
  have : (fun ω => W ω * (f ω + c)) = fun ω => W ω * f ω + W ω * c := by funext ω; ring
  rw [this, integral_add (integrable_W_mul hW hf) ((integrable_W hW).mul_const c), integral_mul_const, add_div,
    mul_comm (∫ ω, W ω ∂(conf μ)) c, mul_div_assoc, div_self hZ.ne', mul_one]

theorem obs_add_const {f : (S → G) → ℝ} {K : ℝ} (hf : Obs f K) (c : ℝ) : Obs (fun ω => f ω + c) (K + |c|) :=
  ⟨hf.meas.add_const c, fun ω => le_trans (abs_add_le _ _) (add_le_add_right (hf.bd ω) _)⟩

/-- the one-site marginal of W · f at s, written without the conditional -/
theorem condExp_mul_zsite {W : (S → G) → ℝ} {m M : ℝ} (hW : Weight W m M) (s : S) (f : (S → G) → ℝ) (ω : S → G) :
    condExp μ W s f ω * zsite μ W s ω = ∫ g, W (Function.update ω s g) * f (Function.update ω s g) ∂μ := by
  unfold condExp cond
  rw [← integral_mul_const]
  apply integral_congr_ae
  filter_upwards with g
  have hz := (zsite_pos (μ := μ) hW s ω).ne'
  field_simp

/-- LEMMA B, the nonnegative case: the Gibbs measure is stationary for the one-site conditional at s -/
theorem integral_condExp_eq_of_nonneg {W : (S → G) → ℝ} {m M : ℝ} (hW : Weight W m M) (s : S)
    {f : (S → G) → ℝ} {K : ℝ} (hf : Obs f K) (hf0 : ∀ ω, 0 ≤ f ω) :
    ∫ ω, W ω * condExp μ W s f ω ∂(conf μ) = ∫ ω, W ω * f ω ∂(conf μ) := by
  have hc0 : ∀ ω, 0 ≤ condExp μ W s f ω := by
    intro ω
    unfold condExp
    exact integral_nonneg fun g => mul_nonneg (cond_nonneg hW s ω g) (hf0 _)
  have hcobs := condExp_obs (μ := μ) hW s hf
  -- both integrands are nonnegative, measurable and bounded: pass to the lower integrals
  have hL : ∫ ω, W ω * condExp μ W s f ω ∂(conf μ)
      = (∫⁻ ω, ENNReal.ofReal (W ω * condExp μ W s f ω) ∂(conf μ)).toReal :=
    integral_eq_lintegral_of_nonneg_ae (Filter.Eventually.of_forall fun ω => mul_nonneg (hW.pos ω).le (hc0 ω))
      (hW.meas.mul hcobs.meas).aestronglyMeasurable
  have hR : ∫ ω, W ω * f ω ∂(conf μ)
      = (∫⁻ ω, ENNReal.ofReal (W ω * f ω) ∂(conf μ)).toReal :=
    integral_eq_lintegral_of_nonneg_ae (Filter.Eventually.of_forall fun ω => mul_nonneg (hW.pos ω).le (hf0 ω))
      (hW.meas.mul hf.meas).aestronglyMeasurable
  rw [hL, hR]
  congr 1
  -- the lower integrals over the product measure are iterated marginals; peel the coordinate s
  set F₁ : (S → G) → ENNReal := fun ω => ENNReal.ofReal (W ω * condExp μ W s f ω) with hF₁
  set F₂ : (S → G) → ENNReal := fun ω => ENNReal.ofReal (W ω * f ω) with hF₂
  have hF₁m : Measurable F₁ := (hW.meas.mul hcobs.meas).ennreal_ofReal
  have hF₂m : Measurable F₂ := (hW.meas.mul hf.meas).ennreal_ofReal
  obtain ⟨x₀⟩ : Nonempty (S → G) := ⟨fun _ => Classical.arbitrary G⟩
  rw [lintegral_eq_lmarginal_univ x₀, lintegral_eq_lmarginal_univ x₀,
    lmarginal_erase (fun _ : S => μ) F₁ hF₁m (Finset.mem_univ s),
    lmarginal_erase (fun _ : S => μ) F₂ hF₂m (Finset.mem_univ s)]
  congr 1
  funext x
  -- at every configuration the one-site marginals agree
  have hcx := hc0 x
  have hW' : ∀ g, 0 ≤ W (Function.update x s g) := fun g => (hW.pos _).le
  have hint1 : Integrable (fun g => W (Function.update x s g)) μ := integrable_W_update hW s x
  have hint2 : Integrable (fun g => W (Function.update x s g) * f (Function.update x s g)) μ :=
    hint1.mul_bdd (hf.meas.comp (measurable_update_spin x s)).aestronglyMeasurable
      (Filter.Eventually.of_forall fun g => by rw [Real.norm_eq_abs]; exact hf.bd _)
  calc ∫⁻ g, F₁ (Function.update x s g) ∂μ
      = ∫⁻ g, ENNReal.ofReal (condExp μ W s f x) * ENNReal.ofReal (W (Function.update x s g)) ∂μ := by
        apply lintegral_congr
        intro g
        simp only [hF₁, condExp_update]
        rw [mul_comm (W _), ENNReal.ofReal_mul hcx]
    _ = ENNReal.ofReal (condExp μ W s f x) * ∫⁻ g, ENNReal.ofReal (W (Function.update x s g)) ∂μ :=
        lintegral_const_mul _ (hW.meas.comp (measurable_update_spin x s)).ennreal_ofReal
    _ = ENNReal.ofReal (condExp μ W s f x) * ENNReal.ofReal (zsite μ W s x) := by
        unfold zsite
        rw [ofReal_integral_eq_lintegral_ofReal hint1 (Filter.Eventually.of_forall hW')]
    _ = ENNReal.ofReal (condExp μ W s f x * zsite μ W s x) := by rw [ENNReal.ofReal_mul hcx]
    _ = ENNReal.ofReal (∫ g, W (Function.update x s g) * f (Function.update x s g) ∂μ) := by
        rw [condExp_mul_zsite hW s f x]
    _ = ∫⁻ g, ENNReal.ofReal (W (Function.update x s g) * f (Function.update x s g)) ∂μ :=
        ofReal_integral_eq_lintegral_ofReal hint2
          (Filter.Eventually.of_forall fun g => mul_nonneg (hW' g) (hf0 _))
    _ = ∫⁻ g, F₂ (Function.update x s g) ∂μ := by simp only [hF₂]

/-- LEMMA B: the Gibbs measure is stationary for every one-site conditional (detailed balance) -/
theorem gibbs_condExp {W : (S → G) → ℝ} {m M : ℝ} (hW : Weight W m M) (s : S) {f : (S → G) → ℝ} {K : ℝ}
    (hf : Obs f K) : gibbs μ W (condExp μ W s f) = gibbs μ W f := by
  -- shift f by K to a nonnegative observable, use the nonnegative case, shift back
  have hK := hf.nonneg_K
  have hfK : Obs (fun ω => f ω + K) (K + |K|) := obs_add_const hf K
  have hfK0 : ∀ ω, 0 ≤ f ω + K := fun ω => by linarith [neg_le_of_abs_le (hf.bd ω)]
  have hnn := integral_condExp_eq_of_nonneg (μ := μ) hW s hfK hfK0
  have hcK : ∀ ω, condExp μ W s (fun ω' => f ω' + K) ω = condExp μ W s f ω + K := fun ω => condExp_add_const hW s hf K ω
  have hcobs := condExp_obs (μ := μ) hW s hf
  have e1 : gibbs μ W (condExp μ W s (fun ω' => f ω' + K)) = gibbs μ W (condExp μ W s f) + K := by
    have : condExp μ W s (fun ω' => f ω' + K) = fun ω => condExp μ W s f ω + K := funext hcK
    rw [this]
    exact gibbs_add_const hW hcobs K
  have e2 : gibbs μ W (fun ω => f ω + K) = gibbs μ W f + K := gibbs_add_const hW hf K
  have e3 : gibbs μ W (condExp μ W s (fun ω' => f ω' + K)) = gibbs μ W (fun ω => f ω + K) := by
    unfold gibbs
    rw [hnn]
  linarith

/-- LEMMA C: under the second weight, one conditional step of the first moves the expectation by at most b s · d s -/
theorem abs_gibbs_condExp_sub_le {W W' : (S → G) → ℝ} {m M m' M' : ℝ} (hW : Weight W m M) (hW' : Weight W' m' M')
    (b : S → ℝ) (hb : Discrep μ W W' b) {f : (S → G) → ℝ} {K : ℝ} (hf : Obs f K) (d : S → ℝ) (hfd : OscBound f d)
    (s : S) : |gibbs μ W' (condExp μ W s f) - gibbs μ W' f| ≤ b s * d s := by
  rw [← gibbs_condExp hW' s hf, ← gibbs_sub hW' (condExp_obs hW s hf) (condExp_obs hW' s hf)]
  apply abs_gibbs_le hW' ⟨(condExp_obs hW s hf).meas.sub (condExp_obs hW' s hf).meas, fun ω =>
    le_trans (abs_sub _ _) (add_le_add (abs_condExp_le hW s hf ω) (abs_condExp_le hW' s hf ω))⟩ (b s * d s)
  intro ω
  have hmeas : Measurable (fun x => f (Function.update ω s x)) := hf.meas.comp (measurable_update_spin ω s)
  have hpt : condExp μ W s f ω - condExp μ W' s f ω =
      ∫ g, (cond μ W s ω g - cond μ W' s ω g) * f (Function.update ω s g) ∂μ := by
    unfold condExp
    rw [← integral_sub ((cond_integrable hW s ω).mul_bdd hmeas.aestronglyMeasurable
        (Filter.Eventually.of_forall fun g => by rw [Real.norm_eq_abs]; exact hf.bd _))
      ((cond_integrable hW' s ω).mul_bdd hmeas.aestronglyMeasurable
        (Filter.Eventually.of_forall fun g => by rw [Real.norm_eq_abs]; exact hf.bd _))]
    apply integral_congr_ae
    filter_upwards with g
    ring
  rw [Pi.sub_apply, hpt]
  calc |∫ g, (cond μ W s ω g - cond μ W' s ω g) * f (Function.update ω s g) ∂μ|
      ≤ tv μ (cond μ W s ω) (cond μ W' s ω) * d s :=
        abs_integral_sub_mul_le μ _ _ _ (cond_integrable hW s ω) (cond_integrable hW' s ω) hmeas
          (by rw [cond_integral hW s ω, cond_integral hW' s ω]) (d s) (fun x x' => hfd s ω x x')
    _ ≤ b s * d s := mul_le_mul_of_nonneg_right (hb s ω) (oscBound_nonneg hfd s)

end Gibbs

section Sweep

variable {S : Type*} [Fintype S] [DecidableEq S] {G : Type*} [MeasurableSpace G] {μ : MeasureTheory.Measure G}
  [IsProbabilityMeasure μ] [Nonempty G]

/-- the sweep: the sites of the list visited in order, head first -/
noncomputable def sweep (μ : MeasureTheory.Measure G) (W : (S → G) → ℝ) : List S → ((S → G) → ℝ) → ((S → G) → ℝ)
  | [], f => f
  | s :: L, f => sweep μ W L (condExp μ W s f)

theorem sweep_obs {W : (S → G) → ℝ} {m M : ℝ} (hW : Weight W m M) (L : List S) :
    ∀ {f : (S → G) → ℝ} {K : ℝ}, Obs f K → Obs (sweep μ W L f) K := by
  induction L with
  | nil => intro f K hf; exact hf
  | cons s L ih => intro f K hf; exact ih (condExp_obs hW s hf)

theorem oscBound_sweep {W : (S → G) → ℝ} {m M : ℝ} (hW : Weight W m M) (C : S → S → ℝ) (hC : Interdep μ W C)
    (L : List S) : ∀ {f : (S → G) → ℝ} {K : ℝ}, Obs f K → ∀ (d : S → ℝ), OscBound f d →
      OscBound (sweep μ W L f) (applyB C L d) := by
  induction L with
  | nil => intro f K hf d hfd; exact hfd
  | cons s L ih => intro f K hf d hfd; exact ih (condExp_obs hW s hf) _ (oscBound_condExp hW C hC hf d hfd s)

theorem gibbs_sweep {W : (S → G) → ℝ} {m M : ℝ} (hW : Weight W m M) (L : List S) :
    ∀ {f : (S → G) → ℝ} {K : ℝ}, Obs f K → gibbs μ W (sweep μ W L f) = gibbs μ W f := by
  induction L with
  | nil => intro f K _; rfl
  | cons s L ih => intro f K hf; rw [sweep, ih (condExp_obs hW s hf), gibbs_condExp hW s hf]

/-- THE TELESCOPING under the second weight: the sweep moves its expectation by at most Σ b · removed -/
theorem abs_gibbs'_sweep_sub_le {W W' : (S → G) → ℝ} {m M m' M' : ℝ} (hW : Weight W m M) (hW' : Weight W' m' M')
    (C : S → S → ℝ) (hC : Interdep μ W C) (b : S → ℝ) (hb : Discrep μ W W' b) (L : List S) :
    ∀ {f : (S → G) → ℝ} {K : ℝ}, Obs f K → ∀ (d : S → ℝ), OscBound f d →
      |gibbs μ W' f - gibbs μ W' (sweep μ W L f)| ≤ ∑ t, b t * removed C L d t := by
  induction L with
  | nil => intro f K _ d _; simp [sweep, removed]
  | cons s L ih =>
    intro f K hf d hfd
    have h1 := abs_gibbs_condExp_sub_le hW hW' b hb hf d hfd s
    have h2 := ih (condExp_obs hW s hf) (stepB C s d) (oscBound_condExp hW C hC hf d hfd s)
    have hsum : ∑ t, b t * removed C (s :: L) d t = b s * d s + ∑ t, b t * removed C L (stepB C s d) t := by
      simp only [removed, mul_add, Finset.sum_add_distrib, mul_ite, mul_zero, Finset.sum_ite_eq',
        Finset.mem_univ, if_true]
    rw [hsum, sweep]
    calc |gibbs μ W' f - gibbs μ W' (sweep μ W L (condExp μ W s f))|
        = |(gibbs μ W' f - gibbs μ W' (condExp μ W s f)) +
            (gibbs μ W' (condExp μ W s f) - gibbs μ W' (sweep μ W L (condExp μ W s f)))| := by rw [sub_add_sub_cancel]
      _ ≤ |gibbs μ W' f - gibbs μ W' (condExp μ W s f)| +
            |gibbs μ W' (condExp μ W s f) - gibbs μ W' (sweep μ W L (condExp μ W s f))| := abs_add_le _ _
      _ ≤ b s * d s + ∑ t, b t * removed C L (stepB C s d) t := by
          rw [abs_sub_comm] at h1
          exact add_le_add h1 h2

end Sweep

section Comparison

variable {S : Type*} [Fintype S] [DecidableEq S] {G : Type*} [MeasurableSpace G] {μ : MeasureTheory.Measure G}
  [IsProbabilityMeasure μ] [Nonempty G]

/-- THE COMPARISON THEOREM WITH LEVELS, over a probability measure on the spins -/
theorem comparison_level {W W' : (S → G) → ℝ} {m M m' M' : ℝ} (hW : Weight W m M) (hW' : Weight W' m' M')
    (C : S → S → ℝ) (hC : ∀ s t, 0 ≤ C s t) (hCW : Interdep μ W C) (α : ℝ) (hα0 : 0 ≤ α) (hα1 : α < 1)
    (hrow : ∀ s, ∑ t, C s t ≤ α) (φ : S → ℕ) (hφ : RangeOne C φ)
    (b : S → ℝ) (hb0 : ∀ t, 0 ≤ b t) (hb : Discrep μ W W' b)
    {f : (S → G) → ℝ} {K : ℝ} (hf : Obs f K) (d : S → ℝ) (hfd : OscBound f d)
    (a R : ℕ) (hd : ∀ t, a < φ t → d t = 0) (hbR : ∀ t, φ t < a + R → b t = 0) :
    |gibbs μ W' f - gibbs μ W f| ≤ (∑ t, b t) * (∑ t, d t) * α ^ R / (1 - α) := by
  have h1α : 0 < 1 - α := by linarith
  have hd0 : ∀ t, 0 ≤ d t := oscBound_nonneg hfd
  have hrem : ∀ (L : List S) (t : S), a + R ≤ φ t → removed C L d t ≤ α ^ R * (∑ t, d t) / (1 - α) := by
    intro L t ht
    have hr := removed_nonneg C hC L d hd0
    have hinv : ∀ t, removed C L d t ≤ d t + CT C (removed C L d) t := fun t =>
      le_trans (le_add_of_nonneg_right (applyB_nonneg C hC L d hd0 t)) (removed_invariant C hC L d hd0 t)
    have hneu := neumann_le C hC d (removed C L d) hinv R t
    have hzero : ∑ k ∈ Finset.range R, CTpow C k d t = 0 := by
      refine Finset.sum_eq_zero fun k hk => ?_
      have hk' := Finset.mem_range.mp hk
      exact CTpow_level C φ hφ k d a hd t (by omega)
    rw [hzero, zero_add] at hneu
    calc removed C L d t ≤ CTpow C R (removed C L d) t := hneu
      _ ≤ ∑ s, CTpow C R (removed C L d) s := single_le_sum' _ (CTpow_nonneg C hC R _ hr) t
      _ ≤ α ^ R * ∑ s, removed C L d s := sum_CTpow_le C hC α hα0 hrow R _ hr
      _ ≤ α ^ R * ((∑ t, d t) / (1 - α)) :=
          mul_le_mul_of_nonneg_left (sum_removed_le C hC α hα1 hrow L d hd0) (pow_nonneg hα0 R)
      _ = α ^ R * (∑ t, d t) / (1 - α) := by ring
  have hm : ∀ n : ℕ, |gibbs μ W' f - gibbs μ W f| ≤
      (∑ t, b t) * (∑ t, d t) * α ^ R / (1 - α) + α ^ n * ∑ t, d t := by
    intro n
    have hA := abs_gibbs'_sweep_sub_le hW hW' C hCW b hb (fullSweeps S n) hf d hfd
    have hB : |gibbs μ W' (sweep μ W (fullSweeps S n) f) - gibbs μ W (sweep μ W (fullSweeps S n) f)| ≤
        α ^ n * ∑ t, d t := by
      have hosc := oscBound_sweep hW C hCW (fullSweeps S n) hf d hfd
      have hglob := fun ω ω' => abs_sub_le_sum_osc _ _ hosc ω ω'
      exact le_trans (abs_gibbs_sub_gibbs_le hW hW' (sweep_obs hW (fullSweeps S n) hf) _ hglob)
        (applyB_iter_le C hC α hα0 hα1.le hrow n d hd0)
    have hremsum : ∑ t, b t * removed C (fullSweeps S n) d t ≤ (∑ t, b t) * (∑ t, d t) * α ^ R / (1 - α) := by
      calc ∑ t, b t * removed C (fullSweeps S n) d t
          ≤ ∑ t, b t * (α ^ R * (∑ t, d t) / (1 - α)) := by
            refine Finset.sum_le_sum fun t _ => ?_
            by_cases ht : a + R ≤ φ t
            · exact mul_le_mul_of_nonneg_left (hrem _ t ht) (hb0 t)
            · simp [hbR t (by omega)]
        _ = (∑ t, b t) * (∑ t, d t) * α ^ R / (1 - α) := by rw [← Finset.sum_mul]; ring
    rw [gibbs_sweep hW (fullSweeps S n) hf] at hB
    calc |gibbs μ W' f - gibbs μ W f|
        = |(gibbs μ W' f - gibbs μ W' (sweep μ W (fullSweeps S n) f)) +
            (gibbs μ W' (sweep μ W (fullSweeps S n) f) - gibbs μ W f)| := by rw [sub_add_sub_cancel]
      _ ≤ |gibbs μ W' f - gibbs μ W' (sweep μ W (fullSweeps S n) f)| +
            |gibbs μ W' (sweep μ W (fullSweeps S n) f) - gibbs μ W f| := abs_add_le _ _
      _ ≤ (∑ t, b t) * (∑ t, d t) * α ^ R / (1 - α) + α ^ n * ∑ t, d t :=
          add_le_add (le_trans hA hremsum) hB
  by_contra hcon
  push_neg at hcon
  rcases (Finset.sum_nonneg fun t _ => hd0 t).lt_or_eq with hdpos | hdzero
  · have hεpos : 0 < (|gibbs μ W' f - gibbs μ W f| - (∑ t, b t) * (∑ t, d t) * α ^ R / (1 - α)) / ∑ t, d t :=
      div_pos (by linarith) hdpos
    obtain ⟨n, hnε⟩ := exists_pow_lt_of_lt_one hεpos hα1
    have h2 := mul_lt_mul_of_pos_right hnε hdpos
    rw [div_mul_cancel₀ _ hdpos.ne'] at h2
    linarith [hm n]
  · have h0 := hm 0
    rw [← hdzero] at h0 hcon
    simp only [pow_zero, mul_zero, zero_mul, zero_div, add_zero] at h0 hcon
    linarith

/-- THE TILT: multiplying the weight by a positive bounded g changes no conditional at a site g does not read,
and any conditional by at most one -/
theorem discrep_tilt {W g : (S → G) → ℝ} {m M mg Mg : ℝ} (hW : Weight W m M) (hg : Weight g mg Mg)
    (reads : S → Prop) [DecidablePred reads]
    (hfree : ∀ s, ¬ reads s → ∀ ω x, g (Function.update ω s x) = g ω) :
    Discrep μ W (fun ω => g ω * W ω) (fun s => if reads s then 1 else 0) := by
  intro s ω
  beta_reduce
  have hW' : Weight (fun ω => g ω * W ω) (mg * m) (Mg * M) :=
    ⟨hg.meas.mul hW.meas, mul_pos hg.mpos hW.mpos, fun ω => mul_le_mul (hg.lo ω) (hW.lo ω) hW.mpos.le (hg.pos ω).le,
      fun ω => mul_le_mul (hg.hi ω) (hW.hi ω) (hW.pos ω).le (le_trans (hg.pos ω).le (hg.hi ω))⟩
  by_cases hs : reads s
  · rw [if_pos hs]
    exact tv_le_one μ _ _ (cond_nonneg hW s ω) (cond_nonneg hW' s ω) (cond_integrable hW s ω)
      (cond_integrable hW' s ω) (cond_integral hW s ω) (cond_integral hW' s ω)
  · rw [if_neg hs]
    have heq : cond μ (fun ω => g ω * W ω) s ω = cond μ W s ω := by
      funext x
      simp only [cond, zsite, hfree s hs ω]
      rw [integral_const_mul, mul_div_mul_left _ _ (hg.pos ω).ne']
    rw [heq, tv_self]

/-- THE COVARIANCE BOUND over a probability measure on the spins: the covariance of f (bound d at levels ≤ a) and a
positive bounded g read at levels ≥ a + R is at most gibbs W g · (Σ b)(Σ d) α^R/(1 − α), b the indicator of the sites g reads -/
theorem cov_le {W : (S → G) → ℝ} {m M : ℝ} (hW : Weight W m M)
    (C : S → S → ℝ) (hC : ∀ s t, 0 ≤ C s t) (hCW : Interdep μ W C) (α : ℝ) (hα0 : 0 ≤ α) (hα1 : α < 1)
    (hrow : ∀ s, ∑ t, C s t ≤ α) (φ : S → ℕ) (hφ : RangeOne C φ)
    {f : (S → G) → ℝ} {K : ℝ} (hf : Obs f K) (d : S → ℝ) (hfd : OscBound f d) (a R : ℕ) (hd : ∀ t, a < φ t → d t = 0)
    {g : (S → G) → ℝ} {mg Mg : ℝ} (hg : Weight g mg Mg) (reads : S → Prop) [DecidablePred reads]
    (hfree : ∀ s, ¬ reads s → ∀ ω x, g (Function.update ω s x) = g ω)
    (hreads : ∀ t, φ t < a + R → ¬ reads t) :
    |gibbs μ W (fun ω => f ω * g ω) - gibbs μ W f * gibbs μ W g| ≤
      gibbs μ W g * ((∑ t, if reads t then (1 : ℝ) else 0) * (∑ t, d t) * α ^ R / (1 - α)) := by
  have hW' : Weight (fun ω => g ω * W ω) (mg * m) (Mg * M) :=
    ⟨hg.meas.mul hW.meas, mul_pos hg.mpos hW.mpos, fun ω => mul_le_mul (hg.lo ω) (hW.lo ω) hW.mpos.le (hg.pos ω).le,
      fun ω => mul_le_mul (hg.hi ω) (hW.hi ω) (hW.pos ω).le (le_trans (hg.pos ω).le (hg.hi ω))⟩
  have hgobs : Obs g Mg := ⟨hg.meas, fun ω => hg.abs_le ω⟩
  have hZ := integral_W_pos (μ := μ) hW
  have hgpos : 0 < gibbs μ W g := lt_of_lt_of_le hg.mpos (le_gibbs_of_le hW hgobs mg hg.lo)
  have hne := hgpos.ne'
  have hfg : Obs (fun ω => f ω * g ω) (K * Mg) :=
    ⟨hf.meas.mul hg.meas, fun ω => by
      rw [abs_mul]; exact mul_le_mul (hf.bd ω) (hg.abs_le ω) (abs_nonneg _) hf.nonneg_K⟩
  -- the tilted expectation is the ratio
  have htilt : gibbs μ (fun ω => g ω * W ω) f = gibbs μ W (fun ω => f ω * g ω) / gibbs μ W g := by
    simp only [gibbs]
    have hnum : ∫ ω, g ω * W ω * f ω ∂(conf μ) = ∫ ω, W ω * (f ω * g ω) ∂(conf μ) := by
      apply integral_congr_ae; filter_upwards with ω; ring
    have hden : ∫ ω, g ω * W ω ∂(conf μ) = ∫ ω, W ω * g ω ∂(conf μ) := by
      apply integral_congr_ae; filter_upwards with ω; ring
    rw [hnum, hden, div_div_div_cancel_right₀ hZ.ne']
  have hcomp := comparison_level hW hW' C hC hCW α hα0 hα1 hrow φ hφ
    (fun s => if reads s then 1 else 0) (fun t => by split_ifs <;> norm_num)
    (discrep_tilt hW hg reads hfree) hf d hfd a R hd
    (fun t ht => by simp [hreads t ht])
  rw [htilt] at hcomp
  have hkey : gibbs μ W (fun ω => f ω * g ω) - gibbs μ W f * gibbs μ W g =
      gibbs μ W g * (gibbs μ W (fun ω => f ω * g ω) / gibbs μ W g - gibbs μ W f) := by
    rw [mul_sub, mul_div_cancel₀ _ hne]
    ring
  rw [hkey, abs_mul, abs_of_pos hgpos]
  exact mul_le_mul_of_nonneg_left hcomp hgpos.le

end Comparison

section FactorWeight

variable {S : Type*} [Fintype S] [DecidableEq S] {G : Type*} [MeasurableSpace G] {μ : MeasureTheory.Measure G}
  [IsProbabilityMeasure μ] [Nonempty G]

/-- A PLAQUETTE WEIGHT: W is a product over a finite family of plaquettes (finite sets of sites) of factors, each measurable,
reading only its plaquette's sites, and bounded in [e^{−β}, e^{β}] -- the Wilson weight of any compact gauge group on any
lattice, with β the plaquette coupling times the character's range -/
structure FactorWeight (W : (S → G) → ℝ) (P : Finset (Finset S)) (w : Finset S → (S → G) → ℝ) (β : ℝ) : Prop where
  eq : ∀ ω, W ω = ∏ p ∈ P, w p ω
  meas : ∀ p ∈ P, Measurable (w p)
  loc : ∀ p ∈ P, ∀ s, s ∉ p → ∀ ω g, w p (Function.update ω s g) = w p ω
  lo : ∀ p ∈ P, ∀ ω, Real.exp (-β) ≤ w p ω
  hi : ∀ p ∈ P, ∀ ω, w p ω ≤ Real.exp β

/-- the number of plaquettes containing both s and t -/
def ncommon (P : Finset (Finset S)) (s t : S) : ℕ := (P.filter (fun p => s ∈ p ∧ t ∈ p)).card

theorem FactorWeight.pos {W : (S → G) → ℝ} {P : Finset (Finset S)} {w : Finset S → (S → G) → ℝ} {β : ℝ}
    (h : FactorWeight W P w β) (ω : S → G) : 0 < W ω := by
  rw [h.eq ω]
  exact Finset.prod_pos fun p hp => lt_of_lt_of_le (Real.exp_pos _) (h.lo p hp ω)

/-- a plaquette weight is a Weight with the bounds e^{−β|P|} and e^{β|P|} -/
theorem FactorWeight.weight {W : (S → G) → ℝ} {P : Finset (Finset S)} {w : Finset S → (S → G) → ℝ} {β : ℝ}
    (h : FactorWeight W P w β) (hβ : 0 ≤ β) : Weight W (Real.exp (-β * P.card)) (Real.exp (β * P.card)) := by
  refine ⟨?_, Real.exp_pos _, ?_, ?_⟩
  · have : W = fun ω => ∏ p ∈ P, w p ω := funext h.eq
    rw [this]
    exact Finset.measurable_prod P fun p hp => h.meas p hp
  · intro ω
    rw [h.eq ω]
    calc Real.exp (-β * P.card) = ∏ _p ∈ P, Real.exp (-β) := by
          rw [Finset.prod_const, ← Real.exp_nat_mul]; ring_nf
      _ ≤ ∏ p ∈ P, w p ω := Finset.prod_le_prod₀ (fun p _ => (Real.exp_pos _).le) (fun p hp => h.lo p hp ω)
  · intro ω
    rw [h.eq ω]
    calc ∏ p ∈ P, w p ω ≤ ∏ _p ∈ P, Real.exp β :=
          Finset.prod_le_prod₀ (fun p hp => lt_of_lt_of_le (Real.exp_pos _) (h.lo p hp ω) |>.le) (fun p hp => h.hi p hp ω)
      _ = Real.exp (β * P.card) := by rw [Finset.prod_const, ← Real.exp_nat_mul]; ring_nf

/-- the local part of the weight at s: the product of the factors whose plaquette contains s -/
noncomputable def localW (P : Finset (Finset S)) (w : Finset S → (S → G) → ℝ) (s : S) (ω : S → G) : ℝ :=
  ∏ p ∈ P.filter (fun p => s ∈ p), w p ω

/-- the weight factors as (the plaquettes avoiding s) × (the local part), and the first factor does not read s -/
theorem FactorWeight.split {W : (S → G) → ℝ} {P : Finset (Finset S)} {w : Finset S → (S → G) → ℝ} {β : ℝ}
    (h : FactorWeight W P w β) (s : S) (ω : S → G) (g : G) :
    W (Function.update ω s g) = (∏ p ∈ P.filter (fun p => s ∉ p), w p ω) * localW P w s (Function.update ω s g) := by
  rw [h.eq, localW, ← Finset.prod_filter_mul_prod_filter_not P (fun p => s ∈ p), mul_comm]
  congr 1
  apply Finset.prod_congr rfl
  intro p hp
  rw [Finset.mem_filter] at hp
  exact h.loc p hp.1 s hp.2 ω g

/-- the one-site conditional reads only the local part -/
theorem FactorWeight.cond_eq {W : (S → G) → ℝ} {P : Finset (Finset S)} {w : Finset S → (S → G) → ℝ} {β : ℝ}
    (h : FactorWeight W P w β) (s : S) (ω : S → G) (g : G) :
    cond μ W s ω g = localW P w s (Function.update ω s g) / ∫ g', localW P w s (Function.update ω s g') ∂μ := by
  have hA : 0 < ∏ p ∈ P.filter (fun p => s ∉ p), w p ω :=
    Finset.prod_pos fun p hp => lt_of_lt_of_le (Real.exp_pos _) (h.lo p (Finset.mem_filter.mp hp).1 ω)
  unfold cond zsite
  have hz : ∫ g', W (Function.update ω s g') ∂μ
      = (∏ p ∈ P.filter (fun p => s ∉ p), w p ω) * ∫ g', localW P w s (Function.update ω s g') ∂μ := by
    rw [← integral_const_mul]
    apply integral_congr_ae
    filter_upwards with g'
    exact h.split s ω g'
  rw [hz, h.split s ω g, mul_div_mul_left _ _ hA.ne']

/-- the local part at s moves by at most e^{2β n} under a change at t sharing n plaquettes with s -/
theorem FactorWeight.localW_ratio {W : (S → G) → ℝ} {P : Finset (Finset S)} {w : Finset S → (S → G) → ℝ} {β : ℝ}
    (h : FactorWeight W P w β) (hβ : 0 ≤ β) (s t : S) (ω : S → G) (hh : G) (g : G) :
    localW P w s (Function.update ω s g)
      ≤ Real.exp (2 * β * ncommon P s t) * localW P w s (Function.update (Function.update ω t hh) s g) := by
  unfold localW ncommon
  -- split the plaquettes containing s by whether they contain t
  rw [← Finset.prod_filter_mul_prod_filter_not (P.filter (fun p => s ∈ p)) (fun p => t ∈ p),
    ← Finset.prod_filter_mul_prod_filter_not (P.filter (fun p => s ∈ p)) (fun p => t ∈ p)]
  have hfilt : (P.filter (fun p => s ∈ p)).filter (fun p => t ∈ p) = P.filter (fun p => s ∈ p ∧ t ∈ p) := by
    ext p; simp [Finset.mem_filter, and_assoc]
  -- the plaquettes avoiding t are untouched
  have hfree : ∏ p ∈ (P.filter (fun p => s ∈ p)).filter (fun p => ¬ t ∈ p), w p (Function.update ω s g)
      = ∏ p ∈ (P.filter (fun p => s ∈ p)).filter (fun p => ¬ t ∈ p), w p (Function.update (Function.update ω t hh) s g) := by
    apply Finset.prod_congr rfl
    intro p hp
    rw [Finset.mem_filter, Finset.mem_filter] at hp
    by_cases hts : t = s
    · subst hts; exact absurd hp.1.2 hp.2
    · rw [Function.update_comm hts, h.loc p hp.1.1 t hp.2]
  rw [hfilt, hfree]
  have hpos2 : 0 ≤ ∏ p ∈ (P.filter (fun p => s ∈ p)).filter (fun p => ¬ t ∈ p),
      w p (Function.update (Function.update ω t hh) s g) :=
    Finset.prod_nonneg fun p hp => (lt_of_lt_of_le (Real.exp_pos _) (h.lo p (Finset.mem_filter.mp (Finset.mem_filter.mp hp).1).1 _)).le
  rw [← mul_assoc]
  apply mul_le_mul_of_nonneg_right _ hpos2
  -- the common plaquettes: each factor ratio is at most e^{2β}
  calc ∏ p ∈ P.filter (fun p => s ∈ p ∧ t ∈ p), w p (Function.update ω s g)
      ≤ ∏ p ∈ P.filter (fun p => s ∈ p ∧ t ∈ p), (Real.exp (2 * β) * w p (Function.update (Function.update ω t hh) s g)) := by
        apply Finset.prod_le_prod₀
        · intro p hp; exact (lt_of_lt_of_le (Real.exp_pos _) (h.lo p (Finset.mem_filter.mp hp).1 _)).le
        · intro p hp
          have hpP := (Finset.mem_filter.mp hp).1
          calc w p (Function.update ω s g) ≤ Real.exp β := h.hi p hpP _
            _ = Real.exp (2 * β) * Real.exp (-β) := by rw [← Real.exp_add]; ring_nf
            _ ≤ Real.exp (2 * β) * w p (Function.update (Function.update ω t hh) s g) :=
                mul_le_mul_of_nonneg_left (h.lo p hpP _) (Real.exp_pos _).le
    _ = Real.exp (2 * β * (P.filter (fun p => s ∈ p ∧ t ∈ p)).card)
          * ∏ p ∈ P.filter (fun p => s ∈ p ∧ t ∈ p), w p (Function.update (Function.update ω t hh) s g) := by
        rw [Finset.prod_mul_distrib, Finset.prod_const, ← Real.exp_nat_mul]; ring_nf

/-- THE INTERDEPENDENCE OF A PLAQUETTE WEIGHT: changing t moves s's conditional by at most 1 − e^{−4β n}, n the number of
plaquettes containing both -- the crude pointwise bound, zero when s and t share no plaquette -/
theorem FactorWeight.interdep {W : (S → G) → ℝ} {P : Finset (Finset S)} {w : Finset S → (S → G) → ℝ} {β : ℝ}
    (h : FactorWeight W P w β) (hβ : 0 ≤ β) :
    Interdep μ W (fun s t => 1 - Real.exp (-(4 * β * ncommon P s t))) := by
  intro s t hst ω hh
  have hW := h.weight hβ
  set ω' := Function.update ω t hh with hω'
  have hL : ∀ ω₁ : S → G, ∀ g, 0 < localW P w s (Function.update ω₁ s g) := fun ω₁ g =>
    Finset.prod_pos fun p hp => lt_of_lt_of_le (Real.exp_pos _) (h.lo p (Finset.mem_filter.mp hp).1 _)
  have hLint : ∀ ω₁ : S → G, Integrable (fun g => localW P w s (Function.update ω₁ s g)) μ := by
    intro ω₁
    have hm : Measurable (fun g => localW P w s (Function.update ω₁ s g)) := by
      unfold localW
      exact Finset.measurable_prod _ fun p hp => (h.meas p (Finset.mem_filter.mp hp).1).comp (measurable_update_spin ω₁ s)
    refine integrable_of_abs_le μ _ hm.aestronglyMeasurable (Real.exp (β * (P.filter (fun p => s ∈ p)).card)) ?_
    intro g
    rw [abs_of_pos (hL ω₁ g)]
    unfold localW
    calc ∏ p ∈ P.filter (fun p => s ∈ p), w p (Function.update ω₁ s g) ≤ ∏ _p ∈ P.filter (fun p => s ∈ p), Real.exp β :=
          Finset.prod_le_prod₀ (fun p hp => (lt_of_lt_of_le (Real.exp_pos _) (h.lo p (Finset.mem_filter.mp hp).1 _)).le)
            (fun p hp => h.hi p (Finset.mem_filter.mp hp).1 _)
      _ = Real.exp (β * (P.filter (fun p => s ∈ p)).card) := by rw [Finset.prod_const, ← Real.exp_nat_mul]; ring_nf
  -- the two normalisers are within e^{2βn} of each other, by the pointwise ratio integrated
  set n : ℕ := ncommon P s t with hn
  have hZ : ∫ g, localW P w s (Function.update ω s g) ∂μ
      ≤ Real.exp (2 * β * n) * ∫ g, localW P w s (Function.update ω' s g) ∂μ := by
    rw [← integral_const_mul]
    exact integral_mono (hLint ω) ((hLint ω').const_mul _) (fun g => h.localW_ratio hβ s t ω hh g)
  have hZ' : ∫ g, localW P w s (Function.update ω' s g) ∂μ
      ≤ Real.exp (2 * β * n) * ∫ g, localW P w s (Function.update ω s g) ∂μ := by
    rw [← integral_const_mul]
    apply integral_mono (hLint ω') ((hLint ω).const_mul _)
    intro g
    have := h.localW_ratio hβ s t ω' (ω t) g
    rw [hω', Function.update_idem, Function.update_eq_self] at this
    have hnc : ncommon P s t = n := rfl
    rw [← hω'] at this
    exact this
  have hZpos : 0 < ∫ g, localW P w s (Function.update ω s g) ∂μ := by
    have := integral_mono (integrable_const (Real.exp (-β * (P.filter (fun p => s ∈ p)).card))) (hLint ω) (fun g => by
      unfold localW
      calc Real.exp (-β * (P.filter (fun p => s ∈ p)).card) = ∏ _p ∈ P.filter (fun p => s ∈ p), Real.exp (-β) := by
            rw [Finset.prod_const, ← Real.exp_nat_mul]; ring_nf
        _ ≤ ∏ p ∈ P.filter (fun p => s ∈ p), w p (Function.update ω s g) :=
            Finset.prod_le_prod₀ (fun p _ => (Real.exp_pos _).le) (fun p hp => h.lo p (Finset.mem_filter.mp hp).1 _))
    simp only [integral_const, probReal_univ, one_smul] at this
    exact lt_of_lt_of_le (Real.exp_pos _) this
  have hZ'pos : 0 < ∫ g, localW P w s (Function.update ω' s g) ∂μ := by
    have := integral_mono (integrable_const (Real.exp (-β * (P.filter (fun p => s ∈ p)).card))) (hLint ω') (fun g => by
      unfold localW
      calc Real.exp (-β * (P.filter (fun p => s ∈ p)).card) = ∏ _p ∈ P.filter (fun p => s ∈ p), Real.exp (-β) := by
            rw [Finset.prod_const, ← Real.exp_nat_mul]; ring_nf
        _ ≤ ∏ p ∈ P.filter (fun p => s ∈ p), w p (Function.update ω' s g) :=
            Finset.prod_le_prod₀ (fun p _ => (Real.exp_pos _).le) (fun p hp => h.lo p (Finset.mem_filter.mp hp).1 _))
    simp only [integral_const, probReal_univ, one_smul] at this
    exact lt_of_lt_of_le (Real.exp_pos _) this
  -- the pointwise ratio of the conditionals: cond_ω ≤ e^{4βn} cond_ω'
  have hpt : ∀ g, cond μ W s ω g ≤ Real.exp (4 * β * n) * cond μ W s ω' g := by
    intro g
    rw [h.cond_eq s ω g, h.cond_eq s ω' g, div_le_iff₀ hZpos]
    have hr := h.localW_ratio hβ s t ω hh g
    calc localW P w s (Function.update ω s g)
        ≤ Real.exp (2 * β * n) * localW P w s (Function.update ω' s g) := hr
      _ = Real.exp (2 * β * n) * localW P w s (Function.update ω' s g)
            / (∫ g', localW P w s (Function.update ω' s g') ∂μ) * ∫ g', localW P w s (Function.update ω' s g') ∂μ := by
          field_simp
      _ ≤ Real.exp (2 * β * n) * localW P w s (Function.update ω' s g)
            / (∫ g', localW P w s (Function.update ω' s g') ∂μ)
            * (Real.exp (2 * β * n) * ∫ g', localW P w s (Function.update ω s g') ∂μ) := by
          apply mul_le_mul_of_nonneg_left hZ'
          exact div_nonneg (mul_nonneg (Real.exp_pos _).le (hL ω' g).le) hZ'pos.le
      _ = Real.exp (4 * β * n) * (localW P w s (Function.update ω' s g) / ∫ g', localW P w s (Function.update ω' s g') ∂μ)
            * ∫ g', localW P w s (Function.update ω s g') ∂μ := by
          rw [show Real.exp (4 * β * n) = Real.exp (2 * β * n) * Real.exp (2 * β * n) by rw [← Real.exp_add]; ring_nf]
          field_simp
  have hr1 : (1 : ℝ) ≤ Real.exp (4 * β * n) := Real.one_le_exp (by positivity)
  have := tv_le_of_pointwise μ (cond μ W s ω) (cond μ W s ω') (cond_nonneg hW s ω) (cond_integrable hW s ω)
    (cond_integrable hW s ω') (cond_integral hW s ω) (cond_integral hW s ω') _ hr1 hpt
  rw [one_div, ← Real.exp_neg] at this
  exact this

/-- the off-diagonal interdependence matrix of a plaquette weight -/
noncomputable def factorC (P : Finset (Finset S)) (β : ℝ) : S → S → ℝ :=
  fun s t => if s = t then 0 else 1 - Real.exp (-(4 * β * ncommon P s t))

theorem factorC_nonneg (P : Finset (Finset S)) (β : ℝ) (hβ : 0 ≤ β) (s t : S) : 0 ≤ factorC P β s t := by
  unfold factorC
  split_ifs
  · exact le_rfl
  · have : Real.exp (-(4 * β * ncommon P s t)) ≤ 1 := Real.exp_le_one_iff.mpr (by
      have : (0 : ℝ) ≤ 4 * β * ncommon P s t := by positivity
      linarith)
    linarith

theorem FactorWeight.interdep_factorC {W : (S → G) → ℝ} {P : Finset (Finset S)} {w : Finset S → (S → G) → ℝ} {β : ℝ}
    (h : FactorWeight W P w β) (hβ : 0 ≤ β) : Interdep μ W (factorC P β) := by
  intro s t hst ω hh
  have := h.interdep (μ := μ) hβ s t hst ω hh
  unfold factorC
  rw [if_neg hst]
  exact this

/-- 1 − x^n ≤ n (1 − x) on [0, 1] (Bernoulli) -/
theorem one_sub_pow_le (x : ℝ) (hx0 : 0 ≤ x) (hx1 : x ≤ 1) (n : ℕ) : 1 - x ^ n ≤ n * (1 - x) := by
  have hb := one_add_mul_le_pow (show (-2 : ℝ) ≤ x - 1 by linarith) n
  have : (1 + (x - 1)) = x := by ring
  rw [this] at hb
  linarith

/-- THE ROW SUM of the plaquette interdependence: at most (the number of other links in the plaquettes of s) × (1 − e^{−4β});
on a lattice where every link lies in at most m plaquettes of at most k links each, at most m (k − 1)(1 − e^{−4β}) -/
theorem rowsum_factorC_le (P : Finset (Finset S)) (β : ℝ) (hβ : 0 ≤ β) (m k : ℕ)
    (hdeg : ∀ s, (P.filter (fun p => s ∈ p)).card ≤ m) (hk : ∀ p ∈ P, p.card ≤ k) (hk1 : 1 ≤ k) (s : S) :
    ∑ t, factorC P β s t ≤ (m * (k - 1) : ℝ) * (1 - Real.exp (-(4 * β))) := by
  have hx0 : 0 ≤ Real.exp (-(4 * β)) := (Real.exp_pos _).le
  have hx1 : Real.exp (-(4 * β)) ≤ 1 := Real.exp_le_one_iff.mpr (by linarith)
  -- each entry is at most n_{st} (1 − e^{−4β})
  have hentry : ∀ t, factorC P β s t ≤ (if s = t then 0 else (ncommon P s t : ℝ)) * (1 - Real.exp (-(4 * β))) := by
    intro t
    unfold factorC
    split_ifs with hst
    · simp
    · have := one_sub_pow_le (Real.exp (-(4 * β))) hx0 hx1 (ncommon P s t)
      rw [← Real.exp_nat_mul] at this
      have e : (ncommon P s t : ℝ) * -(4 * β) = -(4 * β * ncommon P s t) := by ring
      rw [e] at this
      exact this
  -- Σ_{t ≠ s} n_{st} = Σ_{p ∋ s} (|p| − 1) ≤ m (k − 1)
  have hcount : ∑ t, (if s = t then 0 else (ncommon P s t : ℝ)) ≤ (m * (k - 1) : ℝ) := by
    have hswap : ∑ t, (if s = t then 0 else (ncommon P s t : ℝ))
        = ∑ p ∈ P.filter (fun p => s ∈ p), ((p.erase s).card : ℝ) := by
      unfold ncommon
      simp only [Finset.card_eq_sum_ones, Nat.cast_sum, Nat.cast_one]
      rw [Finset.sum_comm' (t' := P.filter (fun p => s ∈ p)) (s' := fun p => p.erase s)]
      · apply Finset.sum_congr rfl
        intro p hp
        simp only [Finset.sum_ite_eq, Finset.mem_erase]
        rfl
      · intro t p
        simp only [Finset.mem_univ, true_and, Finset.mem_filter, Finset.mem_erase, ne_eq]
        constructor
        · rintro ⟨hts, hp⟩
          exact ⟨⟨hp.1, hp.2.1⟩, fun h => hts h.symm, hp.2.2⟩
        · rintro ⟨⟨hpP, hsp⟩, hts, htp⟩
          exact ⟨fun h => hts h.symm, hpP, hsp, htp⟩
    rw [hswap]
    calc ∑ p ∈ P.filter (fun p => s ∈ p), ((p.erase s).card : ℝ)
        ≤ ∑ _p ∈ P.filter (fun p => s ∈ p), ((k - 1 : ℕ) : ℝ) := by
          apply Finset.sum_le_sum
          intro p hp
          have hpP := (Finset.mem_filter.mp hp).1
          have hsp := (Finset.mem_filter.mp hp).2
          rw [Finset.card_erase_of_mem hsp]
          exact_mod_cast Nat.sub_le_sub_right (hk p hpP) 1
      _ = ((P.filter (fun p => s ∈ p)).card : ℝ) * ((k - 1 : ℕ) : ℝ) := by rw [Finset.sum_const, nsmul_eq_mul]
      _ ≤ (m : ℝ) * ((k - 1 : ℕ) : ℝ) := by
          apply mul_le_mul_of_nonneg_right _ (Nat.cast_nonneg _)
          exact_mod_cast hdeg s
      _ = (m * (k - 1) : ℝ) := by rw [Nat.cast_sub hk1]; ring
  calc ∑ t, factorC P β s t ≤ ∑ t, (if s = t then 0 else (ncommon P s t : ℝ)) * (1 - Real.exp (-(4 * β))) :=
        Finset.sum_le_sum fun t _ => hentry t
    _ = (∑ t, (if s = t then 0 else (ncommon P s t : ℝ))) * (1 - Real.exp (-(4 * β))) := by rw [Finset.sum_mul]
    _ ≤ (m * (k - 1) : ℝ) * (1 - Real.exp (-(4 * β))) :=
        mul_le_mul_of_nonneg_right hcount (by linarith)

/-- THE STRONG-COUPLING COVARIANCE BOUND FOR A PLAQUETTE WEIGHT OVER ANY SPIN SPACE: on a lattice with at most m plaquettes of
at most k links on every link, at every β with m (k − 1)(1 − e^{−4β}) < 1, the covariance of f (bound d at levels ≤ a) and a
positive bounded g read at levels ≥ a + R decays like α^R with α = m (k − 1)(1 − e^{−4β}) -- for the four-dimensional cubic
lattice m = 6, k = 4, α = 18 (1 − e^{−4β}) < 1 at β < 0.0143, the first kernel gap whose spin space may be a compact group -/
theorem cov_le_factor {W : (S → G) → ℝ} {P : Finset (Finset S)} {w : Finset S → (S → G) → ℝ} {β : ℝ}
    (h : FactorWeight W P w β) (hβ : 0 ≤ β) (m k : ℕ)
    (hdeg : ∀ s, (P.filter (fun p => s ∈ p)).card ≤ m) (hk : ∀ p ∈ P, p.card ≤ k) (hk1 : 1 ≤ k)
    (hα1 : (m * (k - 1) : ℝ) * (1 - Real.exp (-(4 * β))) < 1)
    (φ : S → ℕ) (hφ : RangeOne (factorC P β) φ)
    {f : (S → G) → ℝ} {K : ℝ} (hf : Obs f K) (d : S → ℝ) (hfd : OscBound f d) (a R : ℕ) (hd : ∀ t, a < φ t → d t = 0)
    {g : (S → G) → ℝ} {mg Mg : ℝ} (hg : Weight g mg Mg) (reads : S → Prop) [DecidablePred reads]
    (hfree : ∀ s, ¬ reads s → ∀ ω x, g (Function.update ω s x) = g ω)
    (hreads : ∀ t, φ t < a + R → ¬ reads t) :
    |gibbs μ W (fun ω => f ω * g ω) - gibbs μ W f * gibbs μ W g| ≤
      gibbs μ W g * ((∑ t, if reads t then (1 : ℝ) else 0) * (∑ t, d t)
        * ((m * (k - 1) : ℝ) * (1 - Real.exp (-(4 * β)))) ^ R / (1 - (m * (k - 1) : ℝ) * (1 - Real.exp (-(4 * β))))) := by
  have hα0 : 0 ≤ (m * (k - 1) : ℝ) * (1 - Real.exp (-(4 * β))) := by
    apply mul_nonneg
    · have : (1 : ℝ) ≤ k := by exact_mod_cast hk1
      have : (0 : ℝ) ≤ k - 1 := by linarith
      positivity
    · have : Real.exp (-(4 * β)) ≤ 1 := Real.exp_le_one_iff.mpr (by linarith)
      linarith
  exact cov_le (h.weight hβ) (factorC P β) (factorC_nonneg P β hβ) (h.interdep_factorC hβ) _ hα0 hα1
    (rowsum_factorC_le P β hβ m k hdeg hk hk1) φ hφ hf d hfd a R hd hg reads hfree hreads

end FactorWeight

end Measure

end Aperanton
