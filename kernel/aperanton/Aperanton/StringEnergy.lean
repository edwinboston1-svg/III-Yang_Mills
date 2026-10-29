/-
  APERANTON -- THE BOUNDLESS, stage A4 (third landing): THE STRING ENERGY AS AN EXACT LIMIT.

  On a fixed cross-section the 't Hooft string energy of a magnetic sector is the limit, in the time extent L, of
  −(1/L) log (Z_e(L)/Z_0(L)) with Z_e(L) = tr(T_e^L) the sector's partition function.  By the Perron half each
  sector's transfer matrix (entrywise positive, symmetric) has a simple dominant root λ₀(T_e), so log tr(T_e^L)/L
  converges to log λ₀(T_e) and the string energy IS log λ₀(T_0) − log λ₀(T_e): the infinite-time limit is an exact
  function of two Perron roots, the quantity ΤΟΜΕΥΣ brackets (E_(1,0) = 1.922653751538… on Z₂ at y = 1/2) and the
  record's settled increments approach (1.950149 at L = 6, the finite-L correction 0.0275 = the residual theorem's
  r_L in the log).  No sorry, no axiom.
-/
import Mathlib
import Aperanton.Perron

open Matrix Filter Topology

namespace Aperanton

variable {n : Type*} [Fintype n] [DecidableEq n]

/-- every power of an entrywise-positive matrix is entrywise nonnegative with a positive diagonal -/
theorem pow_nonneg_diag_pos (T : Matrix n n ℝ) (hpos : ∀ i j, 0 < T i j) (L : ℕ) :
    (∀ i j, 0 ≤ (T ^ L) i j) ∧ (∀ i, 0 < (T ^ L) i i) := by
  classical
  induction L with
  | zero =>
    refine ⟨fun i j => ?_, fun i => ?_⟩
    · rw [pow_zero]; by_cases h : i = j
      · subst h; simp
      · simp [Matrix.one_apply, h]
    · rw [pow_zero]; simp
  | succ L ih =>
    obtain ⟨hnn, hdg⟩ := ih
    refine ⟨fun i j => ?_, fun i => ?_⟩
    · rw [pow_succ, Matrix.mul_apply]
      exact Finset.sum_nonneg (fun k _ => mul_nonneg (hnn i k) (le_of_lt (hpos k j)))
    · rw [pow_succ, Matrix.mul_apply]
      have h1 : (T ^ L) i i * T i i ≤ ∑ k, (T ^ L) i k * T k i :=
        Finset.single_le_sum (f := fun k => (T ^ L) i k * T k i)
          (fun k _ => mul_nonneg (hnn i k) (le_of_lt (hpos k i))) (Finset.mem_univ i)
      exact lt_of_lt_of_le (mul_pos (hdg i) (hpos i i)) h1

/-- the trace of every power of an entrywise-positive matrix is positive -/
theorem trace_pow_pos [Nonempty n] (T : Matrix n n ℝ) (hpos : ∀ i j, 0 < T i j) (L : ℕ) :
    0 < (T ^ L).trace := by
  obtain ⟨i₀⟩ := ‹Nonempty n›
  obtain ⟨hnn, hdg⟩ := pow_nonneg_diag_pos T hpos L
  simp only [trace, diag]
  have h1 : (T ^ L) i₀ i₀ ≤ ∑ i, (T ^ L) i i :=
    Finset.single_le_sum (f := fun i => (T ^ L) i i) (fun i _ => le_of_lt (hdg i)) (Finset.mem_univ i₀)
  exact lt_of_lt_of_le (hdg i₀) h1

/-- THE FREE ENERGY PER UNIT TIME: log tr(T^L) / L → log λ₀ -/
theorem log_trace_div_tendsto [Nonempty n] (T : Matrix n n ℝ) (hT : T.IsHermitian) (hpos : ∀ i j, 0 < T i j) :
    Tendsto (fun L : ℕ => Real.log ((T ^ L).trace) / L) atTop (𝓝 (Real.log (lamMax T hT))) := by
  have hl : 0 < lamMax T hT := (perron_exists T hT hpos).choose_spec.2.2
  have hq := trace_pow_div_tendsto T hT hpos
  have hqlog : Tendsto (fun L : ℕ => Real.log ((T ^ L).trace / lamMax T hT ^ L)) atTop (𝓝 0) := by
    have := ((Real.continuousAt_log one_ne_zero).tendsto).comp hq
    simpa [Function.comp_def] using this
  have h1 : Tendsto (fun L : ℕ => Real.log ((T ^ L).trace / lamMax T hT ^ L) / (L : ℝ)) atTop (𝓝 0) :=
    hqlog.div_atTop tendsto_natCast_atTop_atTop
  have h2 : Tendsto (fun L : ℕ => Real.log (lamMax T hT) + Real.log ((T ^ L).trace / lamMax T hT ^ L) / (L : ℝ))
      atTop (𝓝 (Real.log (lamMax T hT) + 0)) := h1.const_add _
  rw [add_zero] at h2
  refine h2.congr' ?_
  filter_upwards [eventually_ne_atTop 0] with L hL
  have hLr : (L : ℝ) ≠ 0 := Nat.cast_ne_zero.mpr hL
  have htr : 0 < (T ^ L).trace := trace_pow_pos T hpos L
  have hlL : lamMax T hT ^ L ≠ 0 := pow_ne_zero L (ne_of_gt hl)
  rw [Real.log_div (ne_of_gt htr) hlL, Real.log_pow, sub_div, mul_div_cancel_left₀ _ hLr]
  ring

/-- Α4c, THE STRING ENERGY AS AN EXACT LIMIT: for two sectors' transfer matrices (entrywise positive, symmetric,
of any two dimensions) the energy −(1/L) log (Z_e(L)/Z_0(L)) converges to log λ₀(T_0) − log λ₀(T_e) -/
theorem string_energy_tendsto {m : Type*} [Fintype m] [DecidableEq m] [Nonempty m] [Nonempty n]
    (T₀ : Matrix n n ℝ) (h₀ : T₀.IsHermitian) (p₀ : ∀ i j, 0 < T₀ i j)
    (T₁ : Matrix m m ℝ) (h₁ : T₁.IsHermitian) (p₁ : ∀ i j, 0 < T₁ i j) :
    Tendsto (fun L : ℕ => -(Real.log ((T₁ ^ L).trace) - Real.log ((T₀ ^ L).trace)) / (L : ℝ)) atTop
      (𝓝 (Real.log (lamMax T₀ h₀) - Real.log (lamMax T₁ h₁))) := by
  have a := log_trace_div_tendsto T₀ h₀ p₀
  have b := log_trace_div_tendsto T₁ h₁ p₁
  refine (a.sub b).congr' (Eventually.of_forall (fun L => ?_))
  ring

end Aperanton
