/-
  APERANTON -- THE BOUNDLESS, stage Β3a (ADDENDUM I, THE ROAD): DOBRUSHIN'S COMPARISON THEOREM, FINITE.

  A finite Gibbs measure on configurations S → G (S the sites, G the spins, both finite) with a positive weight W:
  the one-site conditional `cond W s ω` and its expectation `condExp W s f`; an OSCILLATION BOUND d for f (changing
  one site s moves f by at most d s), an INTERDEPENDENCE BOUND C for W (changing site t moves site s's conditional
  by at most C s t in total variation), a DISCREPANCY BOUND b between two weights.  THE OSCILLATION INEQUALITY
  (`abs_sum_sub_mul_le`): integrating a function of oscillation m against the difference of two distributions costs
  at most tv · m.  LEMMA A (`oscBound_condExp`): the conditional expectation at s carries the bound
  t ↦ d t + C s t · d s off s and 0 at s.  LEMMA B (`gibbs_condExp`): the Gibbs measure is stationary for every
  one-site conditional -- detailed balance, one involution of (configuration, spin).  LEMMA C
  (`abs_gibbs_condExp_sub_le`): under the second measure one conditional step moves the expectation by at most
  b s · d s.  THE SWEEP visits sites in a list, the bound vector follows it (`applyB`), the mass removed at each
  visit is kept (`removed`); THE INVARIANT `removed + applyB ≤ d + Cᵀ removed` (`removed_invariant`); the Neumann
  bound and the level bound (`neumann_le`, `CTpow_level`); THE MASS CONTRACTION by a full sweep
  (`applyB_total_le`, `applyB_iter_le`); THE GLOBAL OSCILLATION (`abs_sub_le_sum_osc`); and THE COMPARISON
  THEOREM (`comparison_level`): with row sums of C at most α < 1, C of range one along a level function φ, f's
  bound supported at levels ≤ a and the discrepancy supported at levels ≥ a + R,
      |gibbs W' f − gibbs W f| ≤ (Σ b)(Σ d) α^R / (1 − α).
  THE COVARIANCE (`cov_le`): for g > 0 the tilt W' = g·W has discrepancy zero at every site g does not read and at
  most one elsewhere (`discrep_tilt`), so |Cov(f, g)| ≤ gibbs W g · (Σ b)(Σ d) α^R/(1 − α) -- the RATE α does not
  depend on the number of sites.  W = 0: Dobrushin 1968/1970, the comparison theorem in Georgii's form; the finite
  proof by the sweep invariant and the level bound is this file's.  No sorry, no axiom, no native_decide.
-/
import Mathlib

open Finset Filter Topology

namespace Aperanton

section TV

variable {G : Type*} [Fintype G] [DecidableEq G]

/-- the total-variation distance of two vectors on G: half the ℓ¹ distance -/
noncomputable def tv (p p' : G → ℝ) : ℝ := (∑ g, |p g - p' g|) / 2

theorem tv_nonneg (p p' : G → ℝ) : 0 ≤ tv p p' := by
  unfold tv
  exact div_nonneg (sum_nonneg fun g _ => abs_nonneg _) (by norm_num)

theorem tv_self (p : G → ℝ) : tv p p = 0 := by simp [tv]

/-- two distributions are at distance at most one -/
theorem tv_le_one (p p' : G → ℝ) (hp : ∀ g, 0 ≤ p g) (hp' : ∀ g, 0 ≤ p' g)
    (h1 : ∑ g, p g = 1) (h1' : ∑ g, p' g = 1) : tv p p' ≤ 1 := by
  unfold tv
  have h : ∑ g, |p g - p' g| ≤ ∑ g, (p g + p' g) := by
    apply sum_le_sum
    intro g _
    rw [abs_le]
    constructor <;> linarith [hp g, hp' g]
  rw [sum_add_distrib, h1, h1'] at h
  linarith

/-- THE OSCILLATION INEQUALITY: a function of oscillation at most m integrated against the difference of two
distributions is at most tv · m -/
theorem abs_sum_sub_mul_le [Nonempty G] (p p' h : G → ℝ) (h1 : ∑ g, p g = 1) (h1' : ∑ g, p' g = 1)
    (m : ℝ) (hm : ∀ g g', |h g - h g'| ≤ m) : |∑ g, (p g - p' g) * h g| ≤ tv p p' * m := by
  obtain ⟨g₁, -, hg₁⟩ := exists_max_image univ h univ_nonempty
  obtain ⟨g₂, -, hg₂⟩ := exists_min_image univ h univ_nonempty
  have hc : ∀ g, |h g - (h g₁ + h g₂) / 2| ≤ m / 2 := by
    intro g
    have ha := hg₁ g (mem_univ _)
    have hb := hg₂ g (mem_univ _)
    have hd := abs_le.mp (hm g₁ g₂)
    rw [abs_le]
    constructor <;> linarith
  have hzero : ∑ g, (p g - p' g) = 0 := by rw [sum_sub_distrib, h1, h1', sub_self]
  have hshift : ∑ g, (p g - p' g) * h g = ∑ g, (p g - p' g) * (h g - (h g₁ + h g₂) / 2) := by
    simp only [mul_sub, sum_sub_distrib, ← sum_mul, hzero, zero_mul, sub_zero]
  rw [hshift]
  calc |∑ g, (p g - p' g) * (h g - (h g₁ + h g₂) / 2)|
      ≤ ∑ g, |(p g - p' g) * (h g - (h g₁ + h g₂) / 2)| := abs_sum_le_sum_abs _ _
    _ = ∑ g, |p g - p' g| * |h g - (h g₁ + h g₂) / 2| := by simp only [abs_mul]
    _ ≤ ∑ g, |p g - p' g| * (m / 2) :=
        sum_le_sum fun g _ => mul_le_mul_of_nonneg_left (hc g) (abs_nonneg _)
    _ = tv p p' * m := by rw [← sum_mul, tv]; ring

/-- |x| = 2 max(x, 0) − x -/
theorem abs_eq_two_max_sub (x : ℝ) : |x| = 2 * max x 0 - x := by
  rcases le_total 0 x with hx | hx
  · rw [abs_of_nonneg hx, max_eq_left hx]; ring
  · rw [abs_of_nonpos hx, max_eq_right hx]; ring

/-- THE POINTWISE RATIO BOUND: if p ≤ r p' pointwise (r ≥ 1) for two distributions then tv ≤ 1 − 1/r -/
theorem tv_le_of_pointwise (p p' : G → ℝ) (hp : ∀ g, 0 ≤ p g) (h1 : ∑ g, p g = 1) (h1' : ∑ g, p' g = 1)
    (r : ℝ) (hr : 1 ≤ r) (hpp : ∀ g, p g ≤ r * p' g) : tv p p' ≤ 1 - 1 / r := by
  have hr0 : 0 < r := by linarith
  have hzero : ∑ g, (p g - p' g) = 0 := by rw [sum_sub_distrib, h1, h1', sub_self]
  have hr1 : 1 / r ≤ 1 := by rw [div_le_one hr0]; exact hr
  have hmax : ∀ g, max (p g - p' g) 0 ≤ (1 - 1 / r) * p g := by
    intro g
    have hpg := hp g
    have hkey : p g / r ≤ p' g := by rw [div_le_iff₀ hr0]; linarith [hpp g]
    rcases le_total (p g - p' g) 0 with h | h
    · rw [max_eq_right h]
      exact mul_nonneg (by linarith) hpg
    · rw [max_eq_left h]
      have : (1 - 1 / r) * p g = p g - p g / r := by ring
      linarith
  have hsum : ∑ g, |p g - p' g| = 2 * ∑ g, max (p g - p' g) 0 := by
    rw [mul_sum]
    have : ∀ g, |p g - p' g| = 2 * max (p g - p' g) 0 - (p g - p' g) := fun g => abs_eq_two_max_sub _
    simp only [this, sum_sub_distrib, hzero, sub_zero]
  have hle : ∑ g, max (p g - p' g) 0 ≤ ∑ g, (1 - 1 / r) * p g := sum_le_sum fun g _ => hmax g
  rw [← mul_sum, h1, mul_one] at hle
  unfold tv
  rw [hsum]
  linarith

end TV

section Gibbs

variable {S : Type*} [Fintype S] [DecidableEq S] {G : Type*} [Fintype G] [DecidableEq G] [Nonempty G]

/-- the Gibbs expectation of f under the weight W -/
noncomputable def gibbs (W : (S → G) → ℝ) (f : (S → G) → ℝ) : ℝ := (∑ ω, W ω * f ω) / ∑ ω, W ω

/-- the one-site partition function at s -/
noncomputable def zsite (W : (S → G) → ℝ) (s : S) (ω : S → G) : ℝ := ∑ g, W (Function.update ω s g)

/-- the one-site conditional distribution at s -/
noncomputable def cond (W : (S → G) → ℝ) (s : S) (ω : S → G) (g : G) : ℝ :=
  W (Function.update ω s g) / zsite W s ω

/-- the one-site conditional expectation at s -/
noncomputable def condExp (W : (S → G) → ℝ) (s : S) (f : (S → G) → ℝ) (ω : S → G) : ℝ :=
  ∑ g, cond W s ω g * f (Function.update ω s g)

theorem sum_W_pos (W : (S → G) → ℝ) (hW : ∀ ω, 0 < W ω) : 0 < ∑ ω, W ω :=
  sum_pos (fun ω _ => hW ω) univ_nonempty

theorem zsite_pos (W : (S → G) → ℝ) (hW : ∀ ω, 0 < W ω) (s : S) (ω : S → G) : 0 < zsite W s ω :=
  sum_pos (fun g _ => hW _) univ_nonempty

theorem zsite_update (W : (S → G) → ℝ) (s : S) (ω : S → G) (g : G) :
    zsite W s (Function.update ω s g) = zsite W s ω := by
  simp only [zsite, Function.update_idem]

theorem cond_nonneg (W : (S → G) → ℝ) (hW : ∀ ω, 0 < W ω) (s : S) (ω : S → G) (g : G) :
    0 ≤ cond W s ω g :=
  div_nonneg (hW _).le (zsite_pos W hW s ω).le

theorem cond_sum (W : (S → G) → ℝ) (hW : ∀ ω, 0 < W ω) (s : S) (ω : S → G) : ∑ g, cond W s ω g = 1 := by
  simp only [cond]
  rw [← sum_div]
  exact div_self (zsite_pos W hW s ω).ne'

theorem cond_update (W : (S → G) → ℝ) (s : S) (ω : S → G) (g : G) :
    cond W s (Function.update ω s g) = cond W s ω := by
  funext g'
  simp only [cond, Function.update_idem, zsite_update]

theorem condExp_update (W : (S → G) → ℝ) (s : S) (f : (S → G) → ℝ) (ω : S → G) (g : G) :
    condExp W s f (Function.update ω s g) = condExp W s f ω := by
  simp only [condExp, cond_update, Function.update_idem]

/-- the Gibbs expectation is linear in f -/
theorem gibbs_sub (W : (S → G) → ℝ) (f h : (S → G) → ℝ) :
    gibbs W (fun ω => f ω - h ω) = gibbs W f - gibbs W h := by
  simp only [gibbs, mul_sub, sum_sub_distrib, sub_div]

/-- a Gibbs expectation of a function bounded by K in absolute value is bounded by K -/
theorem abs_gibbs_le (W : (S → G) → ℝ) (hW : ∀ ω, 0 < W ω) (f : (S → G) → ℝ) (K : ℝ)
    (hf : ∀ ω, |f ω| ≤ K) : |gibbs W f| ≤ K := by
  have hZ := sum_W_pos W hW
  simp only [gibbs]
  rw [abs_div, abs_of_pos hZ, div_le_iff₀ hZ]
  calc |∑ ω, W ω * f ω| ≤ ∑ ω, |W ω * f ω| := abs_sum_le_sum_abs _ _
    _ = ∑ ω, W ω * |f ω| := by
        refine sum_congr rfl fun ω _ => ?_
        rw [abs_mul, abs_of_pos (hW ω)]
    _ ≤ ∑ ω, W ω * K := sum_le_sum fun ω _ => mul_le_mul_of_nonneg_left (hf ω) (hW ω).le
    _ = K * ∑ ω, W ω := by rw [← sum_mul, mul_comm]

/-- the Gibbs expectation lies below every upper bound of f -/
theorem gibbs_le_of_le (W : (S → G) → ℝ) (hW : ∀ ω, 0 < W ω) (f : (S → G) → ℝ) (K : ℝ) (hf : ∀ ω, f ω ≤ K) :
    gibbs W f ≤ K := by
  have hZ := sum_W_pos W hW
  simp only [gibbs]
  rw [div_le_iff₀ hZ]
  calc ∑ ω, W ω * f ω ≤ ∑ ω, W ω * K := sum_le_sum fun ω _ => mul_le_mul_of_nonneg_left (hf ω) (hW ω).le
    _ = K * ∑ ω, W ω := by rw [← sum_mul, mul_comm]

theorem le_gibbs_of_le (W : (S → G) → ℝ) (hW : ∀ ω, 0 < W ω) (f : (S → G) → ℝ) (K : ℝ) (hf : ∀ ω, K ≤ f ω) :
    K ≤ gibbs W f := by
  have hZ := sum_W_pos W hW
  simp only [gibbs]
  rw [le_div_iff₀ hZ]
  calc K * ∑ ω, W ω = ∑ ω, W ω * K := by rw [← sum_mul, mul_comm]
    _ ≤ ∑ ω, W ω * f ω := sum_le_sum fun ω _ => mul_le_mul_of_nonneg_left (hf ω) (hW ω).le

/-- two Gibbs expectations of one function differ by at most its oscillation -/
theorem abs_gibbs_sub_gibbs_le (W W' : (S → G) → ℝ) (hW : ∀ ω, 0 < W ω) (hW' : ∀ ω, 0 < W' ω)
    (f : (S → G) → ℝ) (M : ℝ) (hM : ∀ ω ω', |f ω - f ω'| ≤ M) : |gibbs W' f - gibbs W f| ≤ M := by
  haveI : Nonempty (S → G) := ⟨fun _ => Classical.arbitrary G⟩
  obtain ⟨ωmax, hmax⟩ := Finite.exists_max f
  obtain ⟨ωmin, hmin⟩ := Finite.exists_min f
  have h1 := gibbs_le_of_le W' hW' f _ hmax
  have h2 := le_gibbs_of_le W' hW' f _ hmin
  have h3 := gibbs_le_of_le W hW f _ hmax
  have h4 := le_gibbs_of_le W hW f _ hmin
  have hw : f ωmax - f ωmin ≤ M := (abs_le.mp (hM ωmax ωmin)).2
  rw [abs_le]
  constructor <;> linarith

/-- the involution of (configuration, spin) that swaps the spin at s with the stored one -/
def swapAt (s : S) : (S → G) × G ≃ (S → G) × G where
  toFun x := (Function.update x.1 s x.2, x.1 s)
  invFun x := (Function.update x.1 s x.2, x.1 s)
  left_inv x := by
    ext1
    · simp only [Function.update_idem, Function.update_eq_self]
    · simp only [Function.update_self]
  right_inv x := by
    ext1
    · simp only [Function.update_idem, Function.update_eq_self]
    · simp only [Function.update_self]

/-- LEMMA B: the Gibbs measure is stationary for every one-site conditional (detailed balance) -/
theorem gibbs_condExp (W : (S → G) → ℝ) (hW : ∀ ω, 0 < W ω) (s : S) (f : (S → G) → ℝ) :
    gibbs W (condExp W s f) = gibbs W f := by
  simp only [gibbs]
  congr 1
  have hnum : ∑ ω, W ω * condExp W s f ω =
      ∑ x : (S → G) × G,
        W x.1 * (W (Function.update x.1 s x.2) / zsite W s x.1 * f (Function.update x.1 s x.2)) := by
    simp only [condExp, cond, mul_sum]
    rw [Fintype.sum_prod_type]
  rw [hnum, Fintype.sum_equiv (swapAt s) _ (fun x : (S → G) × G =>
      W (Function.update x.1 s x.2) * (W x.1 / zsite W s x.1 * f x.1)) ?_]
  · rw [Fintype.sum_prod_type]
    refine sum_congr rfl fun ω _ => ?_
    have hz := (zsite_pos W hW s ω).ne'
    calc ∑ g, W (Function.update ω s g) * (W ω / zsite W s ω * f ω)
        = (∑ g, W (Function.update ω s g)) * (W ω / zsite W s ω * f ω) := by rw [sum_mul]
      _ = zsite W s ω * (W ω / zsite W s ω * f ω) := rfl
      _ = W ω * f ω := by field_simp
  · intro x
    simp only [swapAt, Equiv.coe_fn_mk, Function.update_idem, Function.update_eq_self, zsite_update]

/-- an oscillation bound: changing one site s moves f by at most d s -/
def OscBound (f : (S → G) → ℝ) (d : S → ℝ) : Prop :=
  ∀ s ω g g', |f (Function.update ω s g) - f (Function.update ω s g')| ≤ d s

/-- an interdependence bound: changing site t moves site s's conditional by at most C s t -/
def Interdep (W : (S → G) → ℝ) (C : S → S → ℝ) : Prop :=
  ∀ s t, s ≠ t → ∀ ω h, tv (cond W s ω) (cond W s (Function.update ω t h)) ≤ C s t

/-- a discrepancy bound between two weights' conditionals -/
def Discrep (W W' : (S → G) → ℝ) (b : S → ℝ) : Prop :=
  ∀ s ω, tv (cond W s ω) (cond W' s ω) ≤ b s

theorem oscBound_nonneg {f : (S → G) → ℝ} {d : S → ℝ} (hf : OscBound f d) (s : S) : 0 ≤ d s := by
  obtain ⟨ω⟩ : Nonempty (S → G) := ⟨fun _ => Classical.arbitrary G⟩
  have := hf s ω (ω s) (ω s)
  exact le_trans (abs_nonneg _) this

/-- the one-step bound vector: zero at s, d t + C s t · d s elsewhere -/
def stepB (C : S → S → ℝ) (s : S) (d : S → ℝ) : S → ℝ := fun t => if t = s then 0 else d t + C s t * d s

theorem stepB_self (C : S → S → ℝ) (s : S) (d : S → ℝ) : stepB C s d s = 0 := by simp [stepB]

theorem stepB_of_ne (C : S → S → ℝ) (s : S) (d : S → ℝ) {t : S} (h : t ≠ s) :
    stepB C s d t = d t + C s t * d s := by simp [stepB, h]

/-- LEMMA A: the conditional expectation at s carries the stepped bound -/
theorem oscBound_condExp (W : (S → G) → ℝ) (hW : ∀ ω, 0 < W ω) (C : S → S → ℝ) (hC : Interdep W C)
    (f : (S → G) → ℝ) (d : S → ℝ) (hf : OscBound f d) (s : S) : OscBound (condExp W s f) (stepB C s d) := by
  intro t ω g g'
  by_cases hts : t = s
  · subst hts
    rw [condExp_update, condExp_update, sub_self, abs_zero, stepB_self]
  · rw [stepB_of_ne C s d hts]
    set ω₁ := Function.update ω t g with hω₁
    set ω₂ := Function.update ω t g' with hω₂
    have hsplit : condExp W s f ω₁ - condExp W s f ω₂ =
        ∑ x, (cond W s ω₁ x - cond W s ω₂ x) * f (Function.update ω₁ s x) +
        ∑ x, cond W s ω₂ x * (f (Function.update ω₁ s x) - f (Function.update ω₂ s x)) := by
      simp only [condExp, sub_mul, mul_sub, sum_sub_distrib, sum_add_distrib]
      ring
    rw [hsplit]
    have hst : s ≠ t := fun h => hts h.symm
    have h1 : |∑ x, (cond W s ω₁ x - cond W s ω₂ x) * f (Function.update ω₁ s x)| ≤ C s t * d s := by
      have hω₂' : ω₂ = Function.update ω₁ t g' := by rw [hω₁, hω₂, Function.update_idem]
      have htv : tv (cond W s ω₁) (cond W s ω₂) ≤ C s t := by rw [hω₂']; exact hC s t hst ω₁ g'
      calc |∑ x, (cond W s ω₁ x - cond W s ω₂ x) * f (Function.update ω₁ s x)|
          ≤ tv (cond W s ω₁) (cond W s ω₂) * d s :=
            abs_sum_sub_mul_le _ _ _ (cond_sum W hW s ω₁) (cond_sum W hW s ω₂) (d s) (fun x x' => hf s ω₁ x x')
        _ ≤ C s t * d s := mul_le_mul_of_nonneg_right htv (oscBound_nonneg hf s)
    have h2 : |∑ x, cond W s ω₂ x * (f (Function.update ω₁ s x) - f (Function.update ω₂ s x))| ≤ d t := by
      calc |∑ x, cond W s ω₂ x * (f (Function.update ω₁ s x) - f (Function.update ω₂ s x))|
          ≤ ∑ x, |cond W s ω₂ x * (f (Function.update ω₁ s x) - f (Function.update ω₂ s x))| :=
            abs_sum_le_sum_abs _ _
        _ = ∑ x, cond W s ω₂ x * |f (Function.update ω₁ s x) - f (Function.update ω₂ s x)| := by
            refine sum_congr rfl fun x _ => ?_
            rw [abs_mul, abs_of_nonneg (cond_nonneg W hW s ω₂ x)]
        _ ≤ ∑ x, cond W s ω₂ x * d t := by
            refine sum_le_sum fun x _ => mul_le_mul_of_nonneg_left ?_ (cond_nonneg W hW s ω₂ x)
            have e1 : Function.update ω₁ s x = Function.update (Function.update ω s x) t g := by
              rw [hω₁, Function.update_comm hts]
            have e2 : Function.update ω₂ s x = Function.update (Function.update ω s x) t g' := by
              rw [hω₂, Function.update_comm hts]
            rw [e1, e2]
            exact hf t _ g g'
        _ = d t := by rw [← sum_mul, cond_sum W hW s ω₂, one_mul]
    calc |∑ x, (cond W s ω₁ x - cond W s ω₂ x) * f (Function.update ω₁ s x) +
          ∑ x, cond W s ω₂ x * (f (Function.update ω₁ s x) - f (Function.update ω₂ s x))|
        ≤ |∑ x, (cond W s ω₁ x - cond W s ω₂ x) * f (Function.update ω₁ s x)| +
          |∑ x, cond W s ω₂ x * (f (Function.update ω₁ s x) - f (Function.update ω₂ s x))| := abs_add_le _ _
      _ ≤ C s t * d s + d t := add_le_add h1 h2
      _ = d t + C s t * d s := by ring

/-- LEMMA C: under the second weight, one conditional step of the first moves the expectation by at most b s · d s -/
theorem abs_gibbs_condExp_sub_le (W W' : (S → G) → ℝ) (hW : ∀ ω, 0 < W ω) (hW' : ∀ ω, 0 < W' ω)
    (b : S → ℝ) (hb : Discrep W W' b) (f : (S → G) → ℝ) (d : S → ℝ) (hf : OscBound f d) (s : S) :
    |gibbs W' (condExp W s f) - gibbs W' f| ≤ b s * d s := by
  rw [← gibbs_condExp W' hW' s f, ← gibbs_sub]
  apply abs_gibbs_le W' hW' _ (b s * d s)
  intro ω
  have hpt : condExp W s f ω - condExp W' s f ω =
      ∑ g, (cond W s ω g - cond W' s ω g) * f (Function.update ω s g) := by
    simp only [condExp, sub_mul, sum_sub_distrib]
  rw [hpt]
  calc |∑ g, (cond W s ω g - cond W' s ω g) * f (Function.update ω s g)|
      ≤ tv (cond W s ω) (cond W' s ω) * d s :=
        abs_sum_sub_mul_le _ _ _ (cond_sum W hW s ω) (cond_sum W' hW' s ω) (d s) (fun x x' => hf s ω x x')
    _ ≤ b s * d s := mul_le_mul_of_nonneg_right (hb s ω) (oscBound_nonneg hf s)

/-- THE GLOBAL OSCILLATION: changing every site moves f by at most Σ d (one site at a time, over a finite set) -/
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
      rw [sum_insert hs, hpatch]
      have hstep : |f (Function.update P s (ω' s)) - f P| ≤ d s := by
        have := hf s P (ω' s) (P s)
        rwa [Function.update_eq_self] at this
      calc |f (Function.update P s (ω' s)) - f ω|
          = |(f (Function.update P s (ω' s)) - f P) + (f P - f ω)| := by rw [sub_add_sub_cancel]
        _ ≤ |f (Function.update P s (ω' s)) - f P| + |f P - f ω| := abs_add_le _ _
        _ ≤ d s + ∑ t ∈ T, d t := add_le_add hstep ih
  have := key univ
  simp only [mem_univ, if_true] at this
  rw [abs_sub_comm]
  exact this

end Gibbs

section Sweep

variable {S : Type*} [Fintype S] [DecidableEq S] {G : Type*} [Fintype G] [DecidableEq G] [Nonempty G]

/-- the sweep: the sites of the list visited in order, head first -/
noncomputable def sweep (W : (S → G) → ℝ) : List S → ((S → G) → ℝ) → ((S → G) → ℝ)
  | [], f => f
  | s :: L, f => sweep W L (condExp W s f)

/-- the bound vector following the sweep -/
def applyB (C : S → S → ℝ) : List S → (S → ℝ) → (S → ℝ)
  | [], d => d
  | s :: L, d => applyB C L (stepB C s d)

/-- the mass removed at the visits of the sweep -/
def removed (C : S → S → ℝ) : List S → (S → ℝ) → (S → ℝ)
  | [], _ => fun _ => 0
  | s :: L, d => fun t => (if t = s then d s else 0) + removed C L (stepB C s d) t

theorem oscBound_sweep (W : (S → G) → ℝ) (hW : ∀ ω, 0 < W ω) (C : S → S → ℝ) (hC : Interdep W C)
    (L : List S) : ∀ (f : (S → G) → ℝ) (d : S → ℝ), OscBound f d → OscBound (sweep W L f) (applyB C L d) := by
  induction L with
  | nil => intro f d hf; exact hf
  | cons s L ih => intro f d hf; exact ih _ _ (oscBound_condExp W hW C hC f d hf s)

theorem gibbs_sweep (W : (S → G) → ℝ) (hW : ∀ ω, 0 < W ω) (L : List S) :
    ∀ f : (S → G) → ℝ, gibbs W (sweep W L f) = gibbs W f := by
  induction L with
  | nil => intro f; rfl
  | cons s L ih => intro f; rw [sweep, ih, gibbs_condExp W hW]

/-- THE TELESCOPING under the second weight: the sweep moves its expectation by at most Σ b · removed -/
theorem abs_gibbs'_sweep_sub_le (W W' : (S → G) → ℝ) (hW : ∀ ω, 0 < W ω) (hW' : ∀ ω, 0 < W' ω)
    (C : S → S → ℝ) (hC : Interdep W C) (b : S → ℝ) (hb : Discrep W W' b) (L : List S) :
    ∀ (f : (S → G) → ℝ) (d : S → ℝ), OscBound f d →
      |gibbs W' f - gibbs W' (sweep W L f)| ≤ ∑ t, b t * removed C L d t := by
  induction L with
  | nil => intro f d _; simp [sweep, removed]
  | cons s L ih =>
    intro f d hf
    have h1 := abs_gibbs_condExp_sub_le W W' hW hW' b hb f d hf s
    have h2 := ih (condExp W s f) (stepB C s d) (oscBound_condExp W hW C hC f d hf s)
    have hsum : ∑ t, b t * removed C (s :: L) d t = b s * d s + ∑ t, b t * removed C L (stepB C s d) t := by
      simp only [removed, mul_add, sum_add_distrib, mul_ite, mul_zero, sum_ite_eq', mem_univ, if_true]
    rw [hsum, sweep]
    calc |gibbs W' f - gibbs W' (sweep W L (condExp W s f))|
        = |(gibbs W' f - gibbs W' (condExp W s f)) +
            (gibbs W' (condExp W s f) - gibbs W' (sweep W L (condExp W s f)))| := by rw [sub_add_sub_cancel]
      _ ≤ |gibbs W' f - gibbs W' (condExp W s f)| +
            |gibbs W' (condExp W s f) - gibbs W' (sweep W L (condExp W s f))| := abs_add_le _ _
      _ ≤ b s * d s + ∑ t, b t * removed C L (stepB C s d) t := by
          rw [abs_sub_comm] at h1
          exact add_le_add h1 h2

theorem stepB_nonneg (C : S → S → ℝ) (hC : ∀ s t, 0 ≤ C s t) (s : S) (d : S → ℝ) (hd : ∀ t, 0 ≤ d t) (t : S) :
    0 ≤ stepB C s d t := by
  by_cases h : t = s
  · rw [h, stepB_self]
  · rw [stepB_of_ne C s d h]; exact add_nonneg (hd t) (mul_nonneg (hC s t) (hd s))

theorem applyB_nonneg (C : S → S → ℝ) (hC : ∀ s t, 0 ≤ C s t) (L : List S) :
    ∀ d : S → ℝ, (∀ t, 0 ≤ d t) → ∀ t, 0 ≤ applyB C L d t := by
  induction L with
  | nil => intro d hd t; exact hd t
  | cons s L ih => intro d hd t; exact ih _ (stepB_nonneg C hC s d hd) t

theorem removed_nonneg (C : S → S → ℝ) (hC : ∀ s t, 0 ≤ C s t) (L : List S) :
    ∀ d : S → ℝ, (∀ t, 0 ≤ d t) → ∀ t, 0 ≤ removed C L d t := by
  induction L with
  | nil => intro d _ t; simp [removed]
  | cons s L ih =>
    intro d hd t
    simp only [removed]
    refine add_nonneg ?_ (ih _ (stepB_nonneg C hC s d hd) t)
    split_ifs <;> simp [hd s]

/-- the transposed action of C on a vector: (Cᵀ v) t = Σ_s C s t · v s -/
def CT (C : S → S → ℝ) (v : S → ℝ) : S → ℝ := fun t => ∑ s, C s t * v s

theorem CT_mono (C : S → S → ℝ) (hC : ∀ s t, 0 ≤ C s t) (v w : S → ℝ) (hvw : ∀ t, v t ≤ w t) (t : S) :
    CT C v t ≤ CT C w t :=
  sum_le_sum fun s _ => mul_le_mul_of_nonneg_left (hvw s) (hC s t)

theorem CT_nonneg (C : S → S → ℝ) (hC : ∀ s t, 0 ≤ C s t) (v : S → ℝ) (hv : ∀ t, 0 ≤ v t) (t : S) :
    0 ≤ CT C v t :=
  sum_nonneg fun s _ => mul_nonneg (hC s t) (hv s)

theorem CT_add (C : S → S → ℝ) (v w : S → ℝ) (t : S) :
    CT C (fun s => v s + w s) t = CT C v t + CT C w t := by
  simp only [CT, mul_add, sum_add_distrib]

/-- THE INVARIANT of the sweep: removed + applyB ≤ d + Cᵀ removed, at every site -/
theorem removed_invariant (C : S → S → ℝ) (hC : ∀ s t, 0 ≤ C s t) (L : List S) :
    ∀ d : S → ℝ, (∀ t, 0 ≤ d t) → ∀ t, removed C L d t + applyB C L d t ≤ d t + CT C (removed C L d) t := by
  induction L with
  | nil => intro d _ t; simp [removed, applyB, CT]
  | cons s L ih =>
    intro d hd t
    have hd' := stepB_nonneg C hC s d hd
    have hih := ih (stepB C s d) hd' t
    simp only [removed, applyB]
    have hCT : CT C (fun t => (if t = s then d s else 0) + removed C L (stepB C s d) t) t =
        C s t * d s + CT C (removed C L (stepB C s d)) t := by
      simp only [CT, mul_add, sum_add_distrib, mul_ite, mul_zero, sum_ite_eq', mem_univ, if_true]
    rw [hCT]
    by_cases hts : t = s
    · subst hts
      rw [stepB_self] at hih
      have hr := removed_nonneg C hC L (stepB C t d) hd' t
      have hc := mul_nonneg (hC t t) (hd t)
      simp only [if_true]
      linarith
    · rw [stepB_of_ne C s d hts] at hih
      simp only [hts, if_false, zero_add]
      linarith

/-- the ℓ¹ contraction of Cᵀ when every row sum of C is at most α -/
theorem sum_CT_le (C : S → S → ℝ) (hC : ∀ s t, 0 ≤ C s t) (α : ℝ) (hrow : ∀ s, ∑ t, C s t ≤ α)
    (v : S → ℝ) (hv : ∀ t, 0 ≤ v t) : ∑ t, CT C v t ≤ α * ∑ t, v t := by
  simp only [CT]
  rw [sum_comm]
  calc ∑ s, ∑ t, C s t * v s = ∑ s, v s * ∑ t, C s t := by
        refine sum_congr rfl fun s _ => ?_
        rw [mul_sum]; refine sum_congr rfl fun t _ => ?_; ring
    _ ≤ ∑ s, v s * α := sum_le_sum fun s _ => mul_le_mul_of_nonneg_left (hrow s) (hv s)
    _ = α * ∑ t, v t := by rw [← sum_mul, mul_comm]

/-- the total removed mass is at most Σ d / (1 − α) -/
theorem sum_removed_le (C : S → S → ℝ) (hC : ∀ s t, 0 ≤ C s t) (α : ℝ) (hα : α < 1)
    (hrow : ∀ s, ∑ t, C s t ≤ α) (L : List S) (d : S → ℝ) (hd : ∀ t, 0 ≤ d t) :
    ∑ t, removed C L d t ≤ (∑ t, d t) / (1 - α) := by
  have h1α : 0 < 1 - α := by linarith
  have hr := removed_nonneg C hC L d hd
  have hinv : ∀ t, removed C L d t ≤ d t + CT C (removed C L d) t := fun t =>
    le_trans (le_add_of_nonneg_right (applyB_nonneg C hC L d hd t)) (removed_invariant C hC L d hd t)
  have hsum : ∑ t, removed C L d t ≤ ∑ t, d t + α * ∑ t, removed C L d t := by
    calc ∑ t, removed C L d t ≤ ∑ t, (d t + CT C (removed C L d) t) := sum_le_sum fun t _ => hinv t
      _ = ∑ t, d t + ∑ t, CT C (removed C L d) t := sum_add_distrib
      _ ≤ ∑ t, d t + α * ∑ t, removed C L d t := by
          linarith [sum_CT_le C hC α hrow (removed C L d) hr]
  rw [le_div_iff₀ h1α]
  linarith

/-- iterating Cᵀ -/
def CTpow (C : S → S → ℝ) : ℕ → (S → ℝ) → (S → ℝ)
  | 0, v => v
  | n + 1, v => CT C (CTpow C n v)

theorem CTpow_succ' (C : S → S → ℝ) (n : ℕ) (v : S → ℝ) : CTpow C (n + 1) v = CTpow C n (CT C v) := by
  induction n generalizing v with
  | zero => rfl
  | succ n ih =>
    show CT C (CTpow C (n + 1) v) = CTpow C (n + 1) (CT C v)
    rw [ih v]
    rfl

theorem CTpow_nonneg (C : S → S → ℝ) (hC : ∀ s t, 0 ≤ C s t) (n : ℕ) :
    ∀ v : S → ℝ, (∀ t, 0 ≤ v t) → ∀ t, 0 ≤ CTpow C n v t := by
  induction n with
  | zero => intro v hv t; exact hv t
  | succ n ih => intro v hv t; exact CT_nonneg C hC _ (ih v hv) t

theorem CTpow_mono (C : S → S → ℝ) (hC : ∀ s t, 0 ≤ C s t) (n : ℕ) :
    ∀ v w : S → ℝ, (∀ t, v t ≤ w t) → ∀ t, CTpow C n v t ≤ CTpow C n w t := by
  induction n with
  | zero => intro v w h t; exact h t
  | succ n ih => intro v w h t; exact CT_mono C hC _ _ (ih v w h) t

theorem CTpow_add (C : S → S → ℝ) (n : ℕ) (v w : S → ℝ) (t : S) :
    CTpow C n (fun s => v s + w s) t = CTpow C n v t + CTpow C n w t := by
  induction n generalizing t with
  | zero => rfl
  | succ n ih =>
    show CT C (CTpow C n (fun s => v s + w s)) t = CT C (CTpow C n v) t + CT C (CTpow C n w) t
    have : CTpow C n (fun s => v s + w s) = fun s => CTpow C n v s + CTpow C n w s := funext fun s => ih s
    rw [this, CT_add]

theorem sum_CTpow_le (C : S → S → ℝ) (hC : ∀ s t, 0 ≤ C s t) (α : ℝ) (hα0 : 0 ≤ α)
    (hrow : ∀ s, ∑ t, C s t ≤ α) (n : ℕ) (v : S → ℝ) (hv : ∀ t, 0 ≤ v t) :
    ∑ t, CTpow C n v t ≤ α ^ n * ∑ t, v t := by
  induction n with
  | zero => simp [CTpow]
  | succ n ih =>
    show ∑ t, CT C (CTpow C n v) t ≤ α ^ (n + 1) * ∑ t, v t
    calc ∑ t, CT C (CTpow C n v) t ≤ α * ∑ t, CTpow C n v t :=
          sum_CT_le C hC α hrow _ (CTpow_nonneg C hC n v hv)
      _ ≤ α * (α ^ n * ∑ t, v t) := mul_le_mul_of_nonneg_left ih hα0
      _ = α ^ (n + 1) * ∑ t, v t := by ring

/-- one entry of a nonnegative vector is at most its total -/
theorem single_le_sum' (v : S → ℝ) (hv : ∀ t, 0 ≤ v t) (t : S) : v t ≤ ∑ s, v s :=
  single_le_sum (fun s _ => hv s) (mem_univ t)

/-- THE NEUMANN BOUND: a nonnegative r with r ≤ d + Cᵀ r satisfies r ≤ Σ_{k<N} (Cᵀ)^k d + (Cᵀ)^N r -/
theorem neumann_le (C : S → S → ℝ) (hC : ∀ s t, 0 ≤ C s t) (d r : S → ℝ)
    (hr : ∀ t, r t ≤ d t + CT C r t) (N : ℕ) (t : S) :
    r t ≤ ∑ k ∈ range N, CTpow C k d t + CTpow C N r t := by
  induction N generalizing t with
  | zero => simp [CTpow]
  | succ N ih =>
    have hstep : CTpow C N r t ≤ CTpow C N d t + CTpow C (N + 1) r t := by
      have := CTpow_mono C hC N r (fun s => d s + CT C r s) hr t
      rw [CTpow_add, ← CTpow_succ'] at this
      exact this
    rw [sum_range_succ]
    linarith [ih t]

/-- a level function: C has range one when C s t = 0 whenever t's level exceeds s's by more than one -/
def RangeOne (C : S → S → ℝ) (φ : S → ℕ) : Prop := ∀ s t, φ s + 1 < φ t → C s t = 0

/-- supports move up by at most one level per application of Cᵀ -/
theorem CTpow_level (C : S → S → ℝ) (φ : S → ℕ) (hφ : RangeOne C φ) (n : ℕ) :
    ∀ (v : S → ℝ) (a : ℕ), (∀ t, a < φ t → v t = 0) → ∀ t, a + n < φ t → CTpow C n v t = 0 := by
  induction n with
  | zero => intro v a hv t ht; exact hv t (by simpa using ht)
  | succ n ih =>
    intro v a hv t ht
    show ∑ s, C s t * CTpow C n v s = 0
    refine sum_eq_zero fun s _ => ?_
    by_cases hs : a + n < φ s
    · rw [ih v a hv s hs, mul_zero]
    · have : φ s + 1 < φ t := by omega
      rw [hφ s t this, zero_mul]

/-- THE MASS CONTRACTION by a list of distinct sites: each visit removes the mass present and adds at most α of it -/
theorem applyB_total_le (C : S → S → ℝ) (hC : ∀ s t, 0 ≤ C s t) (α : ℝ) (hα1 : α ≤ 1)
    (hrow : ∀ s, ∑ t, C s t ≤ α) (L : List S) (hL : L.Nodup) :
    ∀ d : S → ℝ, (∀ t, 0 ≤ d t) →
      ∑ t, applyB C L d t ≤ ∑ t, d t - (1 - α) * ∑ t ∈ L.toFinset, d t := by
  induction L with
  | nil => intro d _; simp [applyB]
  | cons s L ih =>
    intro d hd
    have hnd := List.nodup_cons.mp hL
    have hd' := stepB_nonneg C hC s d hd
    have hih := ih hnd.2 (stepB C s d) hd'
    simp only [applyB]
    have hstep_total : ∑ t, stepB C s d t ≤ ∑ t, d t - (1 - α) * d s := by
      have hform : ∀ t, stepB C s d t = (d t + C s t * d s) - (if t = s then d s + C s s * d s else 0) := by
        intro t
        by_cases h : t = s
        · subst h; rw [stepB_self]; simp
        · rw [stepB_of_ne C s d h]; simp [h]
      simp only [hform, sum_sub_distrib, sum_ite_eq', mem_univ, if_true, sum_add_distrib, ← sum_mul]
      have hprod := mul_le_mul_of_nonneg_right (hrow s) (hd s)
      have hCss := mul_nonneg (hC s s) (hd s)
      linarith
    have hoff : ∑ t ∈ L.toFinset, d t ≤ ∑ t ∈ L.toFinset, stepB C s d t := by
      refine sum_le_sum fun t ht => ?_
      have hts : t ≠ s := fun h => hnd.1 (h ▸ List.mem_toFinset.mp ht)
      rw [stepB_of_ne C s d hts]
      linarith [mul_nonneg (hC s t) (hd s)]
    rw [List.toFinset_cons, sum_insert (fun h => hnd.1 (List.mem_toFinset.mp h))]
    have h1α : 0 ≤ 1 - α := by linarith
    have hmul := mul_le_mul_of_nonneg_left hoff h1α
    linarith

theorem applyB_append (C : S → S → ℝ) (L₁ L₂ : List S) (d : S → ℝ) :
    applyB C (L₁ ++ L₂) d = applyB C L₂ (applyB C L₁ d) := by
  induction L₁ generalizing d with
  | nil => rfl
  | cons s L ih => simp only [List.cons_append, applyB]; exact ih _

theorem sweep_append (W : (S → G) → ℝ) (L₁ L₂ : List S) (f : (S → G) → ℝ) :
    sweep W (L₁ ++ L₂) f = sweep W L₂ (sweep W L₁ f) := by
  induction L₁ generalizing f with
  | nil => rfl
  | cons s L ih => simp only [List.cons_append, sweep]; exact ih _

/-- m full sweeps of every site -/
noncomputable def fullSweeps (S : Type*) [Fintype S] : ℕ → List S
  | 0 => []
  | m + 1 => (univ : Finset S).toList ++ fullSweeps S m

/-- the mass after m full sweeps is at most α^m of the mass before -/
theorem applyB_iter_le (C : S → S → ℝ) (hC : ∀ s t, 0 ≤ C s t) (α : ℝ) (hα0 : 0 ≤ α) (hα1 : α ≤ 1)
    (hrow : ∀ s, ∑ t, C s t ≤ α) (m : ℕ) :
    ∀ d : S → ℝ, (∀ t, 0 ≤ d t) → ∑ t, applyB C (fullSweeps S m) d t ≤ α ^ m * ∑ t, d t := by
  induction m with
  | zero => intro d _; simp [fullSweeps, applyB]
  | succ m ih =>
    intro d hd
    simp only [fullSweeps, applyB_append]
    have hfull := applyB_total_le C hC α hα1 hrow (univ : Finset S).toList (Finset.nodup_toList _) d hd
    rw [Finset.toList_toFinset] at hfull
    have hfull' : ∑ t, applyB C (univ : Finset S).toList d t ≤ α * ∑ t, d t := by linarith
    have hnn := applyB_nonneg C hC (univ : Finset S).toList d hd
    calc ∑ t, applyB C (fullSweeps S m) (applyB C (univ : Finset S).toList d) t
        ≤ α ^ m * ∑ t, applyB C (univ : Finset S).toList d t := ih _ hnn
      _ ≤ α ^ m * (α * ∑ t, d t) := mul_le_mul_of_nonneg_left hfull' (pow_nonneg hα0 m)
      _ = α ^ (m + 1) * ∑ t, d t := by ring

end Sweep

section Comparison

variable {S : Type*} [Fintype S] [DecidableEq S] {G : Type*} [Fintype G] [DecidableEq G] [Nonempty G]

/-- THE COMPARISON THEOREM WITH LEVELS: row sums of C at most α < 1, C of range one along φ, f's oscillation bound
supported at levels ≤ a, the discrepancy supported at levels ≥ a + R: the two Gibbs expectations of f differ by at
most (Σ b)(Σ d) α^R / (1 − α) -/
theorem comparison_level (W W' : (S → G) → ℝ) (hW : ∀ ω, 0 < W ω) (hW' : ∀ ω, 0 < W' ω)
    (C : S → S → ℝ) (hC : ∀ s t, 0 ≤ C s t) (hCW : Interdep W C) (α : ℝ) (hα0 : 0 ≤ α) (hα1 : α < 1)
    (hrow : ∀ s, ∑ t, C s t ≤ α) (φ : S → ℕ) (hφ : RangeOne C φ)
    (b : S → ℝ) (hb0 : ∀ t, 0 ≤ b t) (hb : Discrep W W' b)
    (f : (S → G) → ℝ) (d : S → ℝ) (hf : OscBound f d)
    (a R : ℕ) (hd : ∀ t, a < φ t → d t = 0) (hbR : ∀ t, φ t < a + R → b t = 0) :
    |gibbs W' f - gibbs W f| ≤ (∑ t, b t) * (∑ t, d t) * α ^ R / (1 - α) := by
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
  -- for every number of full sweeps m the difference is at most the removed term plus the residual mass
  have hm : ∀ m : ℕ, |gibbs W' f - gibbs W f| ≤
      (∑ t, b t) * (∑ t, d t) * α ^ R / (1 - α) + α ^ m * ∑ t, d t := by
    intro m
    have hA := abs_gibbs'_sweep_sub_le W W' hW hW' C hCW b hb (fullSweeps S m) f d hf
    have hB : |gibbs W' (sweep W (fullSweeps S m) f) - gibbs W (sweep W (fullSweeps S m) f)| ≤
        α ^ m * ∑ t, d t := by
      have hosc := oscBound_sweep W hW C hCW (fullSweeps S m) f d hf
      have hglob := fun ω ω' => abs_sub_le_sum_osc _ _ hosc ω ω'
      exact le_trans (abs_gibbs_sub_gibbs_le W W' hW hW' _ _ hglob) (applyB_iter_le C hC α hα0 hα1.le hrow m d hd0)
    have hremsum : ∑ t, b t * removed C (fullSweeps S m) d t ≤ (∑ t, b t) * (∑ t, d t) * α ^ R / (1 - α) := by
      calc ∑ t, b t * removed C (fullSweeps S m) d t
          ≤ ∑ t, b t * (α ^ R * (∑ t, d t) / (1 - α)) := by
            refine sum_le_sum fun t _ => ?_
            by_cases ht : a + R ≤ φ t
            · exact mul_le_mul_of_nonneg_left (hrem _ t ht) (hb0 t)
            · simp [hbR t (by omega)]
        _ = (∑ t, b t) * (∑ t, d t) * α ^ R / (1 - α) := by rw [← sum_mul]; ring
    rw [gibbs_sweep W hW (fullSweeps S m) f] at hB
    calc |gibbs W' f - gibbs W f|
        = |(gibbs W' f - gibbs W' (sweep W (fullSweeps S m) f)) +
            (gibbs W' (sweep W (fullSweeps S m) f) - gibbs W f)| := by rw [sub_add_sub_cancel]
      _ ≤ |gibbs W' f - gibbs W' (sweep W (fullSweeps S m) f)| +
            |gibbs W' (sweep W (fullSweeps S m) f) - gibbs W f| := abs_add_le _ _
      _ ≤ (∑ t, b t) * (∑ t, d t) * α ^ R / (1 - α) + α ^ m * ∑ t, d t :=
          add_le_add (le_trans hA hremsum) hB
  -- the residual mass vanishes as m → ∞
  by_contra hcon
  push_neg at hcon
  rcases (sum_nonneg fun t _ => hd0 t).lt_or_eq with hdpos | hdzero
  · have hεpos : 0 < (|gibbs W' f - gibbs W f| - (∑ t, b t) * (∑ t, d t) * α ^ R / (1 - α)) / ∑ t, d t :=
      div_pos (by linarith) hdpos
    obtain ⟨m, hmε⟩ := exists_pow_lt_of_lt_one hεpos hα1
    have h2 := mul_lt_mul_of_pos_right hmε hdpos
    rw [div_mul_cancel₀ _ hdpos.ne'] at h2
    linarith [hm m]
  · have h0 := hm 0
    rw [← hdzero] at h0 hcon
    simp only [pow_zero, mul_zero, zero_mul, zero_div, add_zero] at h0 hcon
    linarith

/-- THE TILT: multiplying the weight by a positive g changes no conditional at a site g does not read, and any
conditional by at most one -/
theorem discrep_tilt (W : (S → G) → ℝ) (hW : ∀ ω, 0 < W ω) (g : (S → G) → ℝ) (hg : ∀ ω, 0 < g ω)
    (reads : S → Prop) [DecidablePred reads]
    (hfree : ∀ s, ¬ reads s → ∀ ω x, g (Function.update ω s x) = g ω) :
    Discrep W (fun ω => g ω * W ω) (fun s => if reads s then 1 else 0) := by
  intro s ω
  beta_reduce
  have hW' : ∀ ω, 0 < g ω * W ω := fun ω => mul_pos (hg ω) (hW ω)
  by_cases hs : reads s
  · rw [if_pos hs]
    exact tv_le_one _ _ (cond_nonneg W hW s ω) (cond_nonneg _ hW' s ω) (cond_sum W hW s ω) (cond_sum _ hW' s ω)
  · rw [if_neg hs]
    have heq : cond (fun ω => g ω * W ω) s ω = cond W s ω := by
      funext x
      simp only [cond, zsite, hfree s hs ω]
      rw [← mul_sum, mul_div_mul_left _ _ (hg ω).ne']
    rw [heq, tv_self]

/-- THE COVARIANCE BOUND: the covariance of f (bound d at levels ≤ a) and a positive g read at levels ≥ a + R is at
most gibbs W g · (Σ b)(Σ d) α^R/(1 − α), b the indicator of the sites g reads -/
theorem cov_le (W : (S → G) → ℝ) (hW : ∀ ω, 0 < W ω)
    (C : S → S → ℝ) (hC : ∀ s t, 0 ≤ C s t) (hCW : Interdep W C) (α : ℝ) (hα0 : 0 ≤ α) (hα1 : α < 1)
    (hrow : ∀ s, ∑ t, C s t ≤ α) (φ : S → ℕ) (hφ : RangeOne C φ)
    (f : (S → G) → ℝ) (d : S → ℝ) (hf : OscBound f d) (a R : ℕ) (hd : ∀ t, a < φ t → d t = 0)
    (g : (S → G) → ℝ) (hg : ∀ ω, 0 < g ω) (reads : S → Prop) [DecidablePred reads]
    (hfree : ∀ s, ¬ reads s → ∀ ω x, g (Function.update ω s x) = g ω)
    (hreads : ∀ t, φ t < a + R → ¬ reads t) :
    |gibbs W (fun ω => f ω * g ω) - gibbs W f * gibbs W g| ≤
      gibbs W g * ((∑ t, if reads t then (1 : ℝ) else 0) * (∑ t, d t) * α ^ R / (1 - α)) := by
  have hW' : ∀ ω, 0 < g ω * W ω := fun ω => mul_pos (hg ω) (hW ω)
  have hZ := sum_W_pos W hW
  have hgpos : 0 < gibbs W g :=
    div_pos (sum_pos (fun ω _ => mul_pos (hW ω) (hg ω)) univ_nonempty) hZ
  have hne := hgpos.ne'
  -- the tilted expectation is the ratio
  have htilt : gibbs (fun ω => g ω * W ω) f = gibbs W (fun ω => f ω * g ω) / gibbs W g := by
    simp only [gibbs]
    have hnum : ∑ ω, g ω * W ω * f ω = ∑ ω, W ω * (f ω * g ω) := sum_congr rfl fun ω _ => by ring
    have hden : ∑ ω, g ω * W ω = ∑ ω, W ω * g ω := sum_congr rfl fun ω _ => by ring
    rw [hnum, hden, div_div_div_cancel_right₀ hZ.ne']
  have hcomp := comparison_level W (fun ω => g ω * W ω) hW hW' C hC hCW α hα0 hα1 hrow φ hφ
    (fun s => if reads s then 1 else 0) (fun t => by split_ifs <;> norm_num)
    (discrep_tilt W hW g hg reads hfree) f d hf a R hd
    (fun t ht => by simp [hreads t ht])
  rw [htilt] at hcomp
  have hkey : gibbs W (fun ω => f ω * g ω) - gibbs W f * gibbs W g =
      gibbs W g * (gibbs W (fun ω => f ω * g ω) / gibbs W g - gibbs W f) := by
    rw [mul_sub, mul_div_cancel₀ _ hne]
    ring
  rw [hkey, abs_mul, abs_of_pos hgpos]
  exact mul_le_mul_of_nonneg_left hcomp hgpos.le

end Comparison

end Aperanton
