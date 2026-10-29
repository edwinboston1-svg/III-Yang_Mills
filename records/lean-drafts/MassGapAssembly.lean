/-
  APERANTON -- THE BOUNDLESS, THE ASSEMBLY WITH THE FIBRE (THE GROUND revision 7's Theorem 8.5 in the kernel's finite form;
  2026-10-29 01:2x). The fine measure W on the fine configurations (Sf → G) is carried by the block map blk to the coarse
  configurations (Sc → V): the COARSE WEIGHT is the pushforward Σ_{blk ω = v} W ω, the FIBRE MEAN of f over v is the fibre's own
  Gibbs average, and THE LAW OF TOTAL COVARIANCE holds exactly (`cov_total`): Cov_W(f, g) = ⟨fibre covariance⟩_coarse +
  Cov_coarse(fibre mean of f, fibre mean of g). THE TWO HYPOTHESES OF Σ2, SEPARATE AND NAMED: (I) `CoarseCriterion` -- Dobrushin's
  interdependence of the COARSE weight with row sums ≤ α < 1 and range one in the sup metric (the blocked measure's bound,
  revision 7's Hypothesis I; the family across cutoffs is uniform by the tilt lemmas, CrossoverCriterion.lean); (II)
  `FibreClustering` -- the fibre covariance of f and g bounded by a number ε (revision 7's K′N(f)‖f‖‖g‖ρ′^d, taken as the number
  it is), and the fibre means quasi-local: an oscillation bound d on f's fibre mean vanishing beyond a range a of f's window, and
  g's fibre mean free of the sites it does not read -- the two inequalities are WHAT THE ULTRAVIOLET HALF MUST DELIVER BELOW THE
  COARSE SCALE, WITH NO PROOF IN THE LITERATURE IN THIS FORM FOR SU(2) (THE GROUND revision 7, Hypothesis II, in the same letters);
  and Hypothesis II demands clustering for EVERY coarse configuration, adversarial ones included, because a single-site criterion
  conditions on the worst case -- which is where it exceeds the small-field expansions, which control typical backgrounds and
  the large fields by their probability (revision 8). THE THEOREM (`cov_le_assembly`): |Cov_W(f, g)| ≤ ε + ⟨fibre mean of g⟩ ·
  (Σ reads)(Σ d) α^R/(1 − α) -- the fibre term plus cov_le on the coarse weight applied to the fibre means. What the kernel takes
  in the RANGE form (d = 0 beyond a) revision 7 states with an exponential tail (δ_y ≤ K′N‖f‖ρ′^{dist}); the passage from the tail
  to the range form is the weighted comparison theorem of the page, a separate lemma, not here. WHOLE-BLOCK TOTAL VARIATION IS
  NOWHERE IN THIS FILE: the coarse variables are of one fixed finite type V at every cutoff, and that is why the criterion does
  not saturate (the 00:4x form withdrawn, master plan §62 (c) CORRECTED). W = 0: the law of total covariance and Dobrushin's
  theorem; the separation of the two hypotheses as kernel objects is this file's. No sorry, no axiom, no native_decide.
-/
import Mathlib
import Aperanton.Dobrushin
import Aperanton.MassGapChain

open Finset

namespace Aperanton

variable {Sf Sc : Type*} [Fintype Sf] [DecidableEq Sf] [Fintype Sc] [DecidableEq Sc]
variable {G V : Type*} [Fintype G] [DecidableEq G] [Nonempty G] [Fintype V] [DecidableEq V] [Nonempty V]

/-- THE COARSE WEIGHT: the fine weight pushed forward along the block map -/
noncomputable def coarseW (W : (Sf → G) → ℝ) (blk : (Sf → G) → (Sc → V)) (v : Sc → V) : ℝ :=
  ∑ ω ∈ univ.filter (fun ω => blk ω = v), W ω

/-- THE FIBRE MEAN of f over the coarse configuration v -/
noncomputable def fibreMean (W : (Sf → G) → ℝ) (blk : (Sf → G) → (Sc → V)) (f : (Sf → G) → ℝ) (v : Sc → V) : ℝ :=
  (∑ ω ∈ univ.filter (fun ω => blk ω = v), W ω * f ω) / coarseW W blk v

/-- THE FIBRE COVARIANCE of f and g over v -/
noncomputable def fibreCov (W : (Sf → G) → ℝ) (blk : (Sf → G) → (Sc → V)) (f g : (Sf → G) → ℝ) (v : Sc → V) : ℝ :=
  fibreMean W blk (fun ω => f ω * g ω) v - fibreMean W blk f v * fibreMean W blk g v

theorem coarseW_pos (W : (Sf → G) → ℝ) (hW : ∀ ω, 0 < W ω) (blk : (Sf → G) → (Sc → V)) (hblk : Function.Surjective blk)
    (v : Sc → V) : 0 < coarseW W blk v := by
  unfold coarseW
  obtain ⟨ω₀, hω₀⟩ := hblk v
  apply sum_pos (fun ω _ => hW ω)
  exact ⟨ω₀, mem_filter.mpr ⟨mem_univ _, hω₀⟩⟩

/-- the fibre sum of W · f is the coarse weight times the fibre mean -/
theorem fibre_sum_eq (W : (Sf → G) → ℝ) (hW : ∀ ω, 0 < W ω) (blk : (Sf → G) → (Sc → V)) (hblk : Function.Surjective blk)
    (f : (Sf → G) → ℝ) (v : Sc → V) :
    ∑ ω ∈ univ.filter (fun ω => blk ω = v), W ω * f ω = coarseW W blk v * fibreMean W blk f v := by
  unfold fibreMean
  rw [mul_div_cancel₀ _ (coarseW_pos W hW blk hblk v).ne']

/-- THE TOWER PROPERTY: the fine Gibbs average of f is the coarse Gibbs average of its fibre mean -/
theorem gibbs_eq_coarse (W : (Sf → G) → ℝ) (hW : ∀ ω, 0 < W ω) (blk : (Sf → G) → (Sc → V)) (hblk : Function.Surjective blk)
    (f : (Sf → G) → ℝ) : gibbs W f = gibbs (coarseW W blk) (fibreMean W blk f) := by
  unfold gibbs
  have hnum : ∑ ω, W ω * f ω = ∑ v, coarseW W blk v * fibreMean W blk f v := by
    rw [← Finset.sum_fiberwise univ blk (fun ω => W ω * f ω)]
    exact sum_congr rfl (fun v _ => fibre_sum_eq W hW blk hblk f v)
  have hden : ∑ ω, W ω = ∑ v, coarseW W blk v := by
    unfold coarseW
    exact (Finset.sum_fiberwise univ blk W).symm
  rw [hnum, hden]

/-- the coarse Gibbs average is additive in the observable -/
theorem gibbs_add (W : (Sc → V) → ℝ) (F H : (Sc → V) → ℝ) :
    gibbs W (fun v => F v + H v) = gibbs W F + gibbs W H := by
  unfold gibbs
  rw [← add_div]
  congr 1
  rw [← sum_add_distrib]
  exact sum_congr rfl (fun v _ => by ring)

/-- THE LAW OF TOTAL COVARIANCE, exactly: the fine covariance is the coarse average of the fibre covariance plus the coarse
covariance of the fibre means -/
theorem cov_total (W : (Sf → G) → ℝ) (hW : ∀ ω, 0 < W ω) (blk : (Sf → G) → (Sc → V)) (hblk : Function.Surjective blk)
    (f g : (Sf → G) → ℝ) :
    gibbs W (fun ω => f ω * g ω) - gibbs W f * gibbs W g
      = gibbs (coarseW W blk) (fibreCov W blk f g)
        + (gibbs (coarseW W blk) (fun v => fibreMean W blk f v * fibreMean W blk g v)
            - gibbs (coarseW W blk) (fibreMean W blk f) * gibbs (coarseW W blk) (fibreMean W blk g)) := by
  rw [gibbs_eq_coarse W hW blk hblk (fun ω => f ω * g ω), gibbs_eq_coarse W hW blk hblk f, gibbs_eq_coarse W hW blk hblk g]
  have hsplit : fibreMean W blk (fun ω => f ω * g ω)
      = fun v => fibreCov W blk f g v + fibreMean W blk f v * fibreMean W blk g v := by
    funext v; unfold fibreCov; ring
  rw [hsplit, gibbs_add]
  ring

/-- the coarse average of a function bounded by ε in absolute value is bounded by ε -/
theorem abs_gibbs_le_of_abs_le (W : (Sc → V) → ℝ) (hW : ∀ v, 0 < W v) (F : (Sc → V) → ℝ) (ε : ℝ)
    (hF : ∀ v, |F v| ≤ ε) : |gibbs W F| ≤ ε := by
  unfold gibbs
  have hZ : 0 < ∑ v, W v := sum_pos (fun v _ => hW v) univ_nonempty
  rw [abs_div, abs_of_pos hZ, div_le_iff₀ hZ]
  calc |∑ v, W v * F v| ≤ ∑ v, |W v * F v| := abs_sum_le_sum_abs _ _
    _ = ∑ v, W v * |F v| := sum_congr rfl (fun v _ => by rw [abs_mul, abs_of_pos (hW v)])
    _ ≤ ∑ v, W v * ε := sum_le_sum (fun v _ => mul_le_mul_of_nonneg_left (hF v) (hW v).le)
    _ = ε * ∑ v, W v := by rw [← sum_mul, mul_comm]

/-- HYPOTHESIS I, THE COARSE CRITERION: Dobrushin's interdependence of the coarse weight with row sums ≤ α < 1 and range one -/
structure CoarseCriterion (Wc : (Sc → V) → ℝ) (C : Sc → Sc → ℝ) (α : ℝ) (φ : Sc → ℕ) : Prop where
  interdep : Interdep Wc C
  nonneg : ∀ s t, 0 ≤ C s t
  row : ∀ s, ∑ t, C s t ≤ α
  α_nonneg : 0 ≤ α
  α_lt_one : α < 1
  rangeOne : RangeOne C φ

/-- HYPOTHESIS II, FIBRE CLUSTERING, in the range form the kernel takes: the fibre covariance of f and g bounded by ε at every
coarse configuration, f's fibre mean of oscillation d along the coarse sites with d = 0 beyond the level a, and g's fibre mean
free of the coarse sites it does not read -/
structure FibreClustering (W : (Sf → G) → ℝ) (blk : (Sf → G) → (Sc → V)) (f g : (Sf → G) → ℝ) (ε : ℝ)
    (d : Sc → ℝ) (φ : Sc → ℕ) (a : ℕ) (reads : Sc → Prop) : Prop where
  fibreCov_le : ∀ v, |fibreCov W blk f g v| ≤ ε
  oscBound : OscBound (fibreMean W blk f) d
  range : ∀ t, a < φ t → d t = 0
  free : ∀ s, ¬ reads s → ∀ v x, fibreMean W blk g (Function.update v s x) = fibreMean W blk g v

/-- the fibre mean of a positive observable is positive -/
theorem fibreMean_pos (W : (Sf → G) → ℝ) (hW : ∀ ω, 0 < W ω) (blk : (Sf → G) → (Sc → V)) (hblk : Function.Surjective blk)
    (g : (Sf → G) → ℝ) (hg : ∀ ω, 0 < g ω) (v : Sc → V) : 0 < fibreMean W blk g v := by
  unfold fibreMean
  apply div_pos _ (coarseW_pos W hW blk hblk v)
  obtain ⟨ω₀, hω₀⟩ := hblk v
  apply sum_pos (fun ω _ => mul_pos (hW ω) (hg ω))
  exact ⟨ω₀, mem_filter.mpr ⟨mem_univ _, hω₀⟩⟩

/-- THE ASSEMBLY: the coarse criterion and the fibre clustering give the fine covariance's bound -- the fibre term plus
Dobrushin's comparison on the coarse weight applied to the fibre means -/
theorem cov_le_assembly (W : (Sf → G) → ℝ) (hW : ∀ ω, 0 < W ω) (blk : (Sf → G) → (Sc → V)) (hblk : Function.Surjective blk)
    (C : Sc → Sc → ℝ) (α : ℝ) (φ : Sc → ℕ) (hI : CoarseCriterion (coarseW W blk) C α φ)
    (f g : (Sf → G) → ℝ) (hg : ∀ ω, 0 < g ω) (ε : ℝ) (d : Sc → ℝ) (a R : ℕ) (reads : Sc → Prop) [DecidablePred reads]
    (hII : FibreClustering W blk f g ε d φ a reads) (hreads : ∀ t, φ t < a + R → ¬ reads t) :
    |gibbs W (fun ω => f ω * g ω) - gibbs W f * gibbs W g|
      ≤ ε + gibbs (coarseW W blk) (fibreMean W blk g)
          * ((∑ t, if reads t then (1 : ℝ) else 0) * (∑ t, d t) * α ^ R / (1 - α)) := by
  rw [cov_total W hW blk hblk f g]
  have hWc : ∀ v, 0 < coarseW W blk v := coarseW_pos W hW blk hblk
  have h1 : |gibbs (coarseW W blk) (fibreCov W blk f g)| ≤ ε :=
    abs_gibbs_le_of_abs_le (coarseW W blk) hWc _ ε hII.fibreCov_le
  have h2 := cov_le (coarseW W blk) hWc C hI.nonneg hI.interdep α hI.α_nonneg hI.α_lt_one hI.row φ hI.rangeOne
    (fibreMean W blk f) d hII.oscBound a R hII.range (fibreMean W blk g) (fibreMean_pos W hW blk hblk g hg) reads hII.free hreads
  calc |gibbs (coarseW W blk) (fibreCov W blk f g)
        + (gibbs (coarseW W blk) (fun v => fibreMean W blk f v * fibreMean W blk g v)
            - gibbs (coarseW W blk) (fibreMean W blk f) * gibbs (coarseW W blk) (fibreMean W blk g))|
      ≤ |gibbs (coarseW W blk) (fibreCov W blk f g)|
        + |gibbs (coarseW W blk) (fun v => fibreMean W blk f v * fibreMean W blk g v)
            - gibbs (coarseW W blk) (fibreMean W blk f) * gibbs (coarseW W blk) (fibreMean W blk g)| := abs_add_le _ _
    _ ≤ ε + gibbs (coarseW W blk) (fibreMean W blk g)
          * ((∑ t, if reads t then (1 : ℝ) else 0) * (∑ t, d t) * α ^ R / (1 - α)) := add_le_add h1 h2

end Aperanton
