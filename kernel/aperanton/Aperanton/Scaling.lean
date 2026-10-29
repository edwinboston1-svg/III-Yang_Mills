/-
  APERANTON -- THE BOUNDLESS, stage Β4 (ADDENDUM I, THE ROAD): THE LATTICE-SCALING TARGET AND THE LIMIT-PASSING
  THEOREM.

  A SCALING SEQUENCE is a sequence of lattice spacings a_n > 0 tending to zero with couplings β_n (`Scaling`);
  THE PHYSICAL GAP ALONG IT is the lower bound Δ ≤ Δ_lat(n) / a_n at every n (`PhysicalGapAlong`) -- the two
  finite readings per scale the continuum gap reduces to: the lattice gap read exactly, and the spacing from the
  scaling map.  On a positive symmetric transfer matrix whose non-Perron eigenvalues are at most q λ₀, every
  connected two-point function lies in [0, (f·f) q^R] (`twopoint_le_of_gap`, the moment representation with the
  Perron mass removed), hence clusters in PHYSICAL distance at rate Δ uniformly along the sequence when the
  physical gap is bounded below (`clustersUniformly_of_gap`); and THE GAP PASSES TO THE LIMIT
  (`cluster_of_limit`): if the lattice two-point functions converge, at every physical separation x along the
  lattice points nearest to it, to a limit function, that limit is at most K e^{−Δ x}.  The theorem is the limit of
  inequalities and claims nothing about the existence of the limit, which is the continuum clause of C22 -- the
  open problem -- stated here as the target `ScalingTarget`, a definition, never asserted (ΚΑΤΑΤΜΗΣΙΣ T-271: the
  quantity is named).  W = 0; no sorry, no axiom, no native_decide.
-/
import Mathlib
import Aperanton.Perron
import Aperanton.Spectral
import Aperanton.GapBound
import Aperanton.Decay

open Matrix Filter Topology Finset

namespace Aperanton

section Target

/-- a scaling sequence: spacings tending to zero, with their couplings -/
structure Scaling where
  a : ℕ → ℝ
  β : ℕ → ℝ
  a_pos : ∀ n, 0 < a n
  a_tendsto : Tendsto a atTop (𝓝 0)

/-- THE PHYSICAL GAP ALONG A SCALING SEQUENCE: the lattice gap in physical units bounded below at every scale --
the two finite readings per scale (Δ_lat(n), a_n) the continuum gap reduces to -/
def PhysicalGapAlong (S : Scaling) (Δlat : ℕ → ℝ) (Δ : ℝ) : Prop := ∀ n, Δ ≤ Δlat n / S.a n

/-- uniform exponential clustering of a family of lattice two-point functions in physical distance -/
def ClustersUniformly (S : Scaling) (C : ℕ → ℕ → ℝ) (Δ K : ℝ) : Prop :=
  ∀ n (R : ℕ), |C n R| ≤ K * Real.exp (-Δ * (S.a n * R))

/-- THE LATTICE-SCALING TARGET, a definition and never an assertion: along a scaling sequence the physical gap is
bounded below by a positive Δ and every lattice two-point function of a named observable converges at every physical
separation to a limit -- the reduction of C22's continuum clause to finite readings -/
def ScalingTarget (S : Scaling) (Δlat : ℕ → ℝ) (C : ℕ → ℕ → ℝ) : Prop :=
  ∃ Δ : ℝ, 0 < Δ ∧ PhysicalGapAlong S Δlat Δ ∧
    ∃ Cinf : ℝ → ℝ, ∀ x : ℝ, 0 ≤ x → ∀ R : ℕ → ℕ, Tendsto (fun n => S.a n * R n) atTop (𝓝 x) →
      Tendsto (fun n => C n (R n)) atTop (𝓝 (Cinf x))

end Target

section Lattice

variable {n : Type*} [Fintype n] [DecidableEq n] [Nonempty n]

/-- a sum with one term replaced is at most the sum plus the replacement, the terms being nonnegative -/
theorem sum_ite_le (B : n → ℝ) (hB : ∀ k, 0 ≤ B k) (i₀ : n) (A : ℝ) :
    ∑ k, (if k = i₀ then A else B k) ≤ ∑ k, B k + A := by
  have hpt : ∀ k, (if k = i₀ then A else B k) ≤ B k + (if k = i₀ then A else 0) := by
    intro k
    split_ifs
    · linarith [hB k]
    · simp
  calc ∑ k, (if k = i₀ then A else B k) ≤ ∑ k, (B k + (if k = i₀ then A else 0)) := sum_le_sum fun k _ => hpt k
    _ = ∑ k, B k + A := by rw [sum_add_distrib, sum_ite_eq', if_pos (mem_univ i₀)]

/-- THE CONNECTED TWO-POINT FUNCTION IS BOUNDED BY THE GAP: with every non-Perron eigenvalue at most q λ₀
(0 ≤ q), the normalised two-point function of f minus its Perron mass lies in [0, (f·f) q^R] -/
theorem twopoint_le_of_gap (M : Matrix n n ℝ) (hM : M.PosSemidef) (hpos : ∀ i j, 0 < M i j) (q : ℝ) (hq : 0 ≤ q)
    (hgap : ∀ k, hM.1.eigenvalues k ≠ lamMax M hM.1 → hM.1.eigenvalues k ≤ q * lamMax M hM.1)
    (f : n → ℝ) (R : ℕ) :
    ∃ Ω : n → ℝ, M *ᵥ Ω = lamMax M hM.1 • Ω ∧ (∀ i, Ω i ≠ 0) ∧
      0 ≤ f ⬝ᵥ ((M ^ R) *ᵥ f) / lamMax M hM.1 ^ R - (Ω ⬝ᵥ f) ^ 2 ∧
      f ⬝ᵥ ((M ^ R) *ᵥ f) / lamMax M hM.1 ^ R - (Ω ⬝ᵥ f) ^ 2 ≤ (f ⬝ᵥ f) * q ^ R := by
  obtain ⟨m, i₀, Ω, hm, hl, hmom, hΩ, hne, hmi₀⟩ := exists_moment_perron M hM.1 hpos f
  obtain ⟨_, -, -, hl0⟩ := perron_exists M hM.1 hpos
  have hx := hM.eigenvalues_nonneg
  have hli : 0 < hM.1.eigenvalues i₀ := by rw [hl]; exact hl0
  have hpow : 0 < hM.1.eigenvalues i₀ ^ R := pow_pos hli R
  refine ⟨Ω, hΩ, hne, ?_, ?_⟩
  · -- the Perron mass is one term of the nonnegative moment sum
    rw [hmom R, moment, ← hmi₀, ← hl, sub_nonneg, le_div_iff₀ hpow]
    exact single_le_sum (f := fun k => m k * hM.1.eigenvalues k ^ R)
      (fun k _ => mul_nonneg (hm k) (pow_nonneg (hx k) R)) (mem_univ i₀)
  · -- the non-Perron terms are each at most m_k q^R, and Σ m_k = f·f
    have hsum : ∑ k, m k = f ⬝ᵥ f := by
      have := hmom 0
      simpa [moment] using this.symm
    rw [hmom R, moment, ← hmi₀, ← hl, sub_le_iff_le_add, div_le_iff₀ hpow]
    have hterm : ∀ k, m k * hM.1.eigenvalues k ^ R ≤
        (if k = i₀ then m i₀ * hM.1.eigenvalues i₀ ^ R else m k * q ^ R * hM.1.eigenvalues i₀ ^ R) := by
      intro k
      split_ifs with hk
      · subst hk; exact le_refl _
      · have hne' : hM.1.eigenvalues k ≠ lamMax M hM.1 := fun h =>
          hk (perron_index_unique M hM.1 hpos k i₀ h hl)
        have hle := hgap k hne'
        rw [← hl] at hle
        calc m k * hM.1.eigenvalues k ^ R ≤ m k * (q * hM.1.eigenvalues i₀) ^ R :=
              mul_le_mul_of_nonneg_left (pow_le_pow_left₀ (hx k) hle R) (hm k)
          _ = m k * q ^ R * hM.1.eigenvalues i₀ ^ R := by rw [mul_pow]; ring
    calc ∑ k, m k * hM.1.eigenvalues k ^ R
        ≤ ∑ k, (if k = i₀ then m i₀ * hM.1.eigenvalues i₀ ^ R else m k * q ^ R * hM.1.eigenvalues i₀ ^ R) :=
          sum_le_sum fun k _ => hterm k
      _ ≤ ∑ k, m k * q ^ R * hM.1.eigenvalues i₀ ^ R + m i₀ * hM.1.eigenvalues i₀ ^ R :=
          sum_ite_le _ (fun k => mul_nonneg (mul_nonneg (hm k) (pow_nonneg hq R)) hpow.le) i₀ _
      _ = ((f ⬝ᵥ f) * q ^ R + m i₀) * hM.1.eigenvalues i₀ ^ R := by
          rw [← sum_mul, ← sum_mul, hsum]; ring

/-- clustering in physical distance at the physical gap's rate, uniformly along the sequence -/
theorem clustersUniformly_of_gap (S : Scaling) (Δlat : ℕ → ℝ) (Δ : ℝ) (hΔ : PhysicalGapAlong S Δlat Δ)
    (C : ℕ → ℕ → ℝ) (K : ℝ) (hK : 0 ≤ K) (hC : ∀ n R, |C n R| ≤ K * Real.exp (-Δlat n * R)) :
    ClustersUniformly S C Δ K := by
  intro n R
  refine le_trans (hC n R) (mul_le_mul_of_nonneg_left ?_ hK)
  apply Real.exp_le_exp.mpr
  have h := hΔ n
  rw [le_div_iff₀ (S.a_pos n)] at h
  have hR : (0 : ℝ) ≤ R := Nat.cast_nonneg R
  have := mul_le_mul_of_nonneg_right h hR
  nlinarith

/-- THE GAP PASSES TO THE LIMIT: a uniformly clustering family whose two-point functions converge at every physical
separation, along the lattice points nearest to it, has a limit at most K e^{−Δ x} -/
theorem cluster_of_limit (S : Scaling) (C : ℕ → ℕ → ℝ) (Δ K : ℝ) (hcl : ClustersUniformly S C Δ K)
    (Cinf : ℝ → ℝ) (x : ℝ) (hx : 0 ≤ x)
    (hlim : ∀ R : ℕ → ℕ, Tendsto (fun n => S.a n * R n) atTop (𝓝 x) →
      Tendsto (fun n => C n (R n)) atTop (𝓝 (Cinf x))) :
    |Cinf x| ≤ K * Real.exp (-Δ * x) := by
  set R : ℕ → ℕ := fun n => ⌊x / S.a n⌋₊ with hRdef
  have hup : ∀ n, S.a n * R n ≤ x := by
    intro n
    have hfl : ((⌊x / S.a n⌋₊ : ℕ) : ℝ) ≤ x / S.a n := Nat.floor_le (div_nonneg hx (S.a_pos n).le)
    have hcancel : S.a n * (x / S.a n) = x := by
      rw [← mul_div_assoc]
      exact mul_div_cancel_left₀ x (S.a_pos n).ne'
    calc S.a n * R n = S.a n * ((⌊x / S.a n⌋₊ : ℕ) : ℝ) := rfl
      _ ≤ S.a n * (x / S.a n) := mul_le_mul_of_nonneg_left hfl (S.a_pos n).le
      _ = x := hcancel
  have hlo : ∀ n, x - S.a n ≤ S.a n * R n := by
    intro n
    have hfl : x / S.a n < ((⌊x / S.a n⌋₊ : ℕ) : ℝ) + 1 := Nat.lt_floor_add_one (x / S.a n)
    have hcancel : S.a n * (x / S.a n) = x := by
      rw [← mul_div_assoc]
      exact mul_div_cancel_left₀ x (S.a_pos n).ne'
    have := mul_lt_mul_of_pos_left hfl (S.a_pos n)
    rw [hcancel, mul_add, mul_one] at this
    show x - S.a n ≤ S.a n * ((⌊x / S.a n⌋₊ : ℕ) : ℝ)
    linarith
  have hconv : Tendsto (fun n => S.a n * R n) atTop (𝓝 x) := by
    have hlow : Tendsto (fun n => x - S.a n) atTop (𝓝 x) := by
      have := (tendsto_const_nhds (x := x)).sub S.a_tendsto
      simpa using this
    exact tendsto_of_tendsto_of_tendsto_of_le_of_le hlow tendsto_const_nhds hlo hup
  have h1 : Tendsto (fun n => |C n (R n)|) atTop (𝓝 |Cinf x|) := (hlim R hconv).abs
  have h2 : Tendsto (fun n => K * Real.exp (-Δ * (S.a n * R n))) atTop (𝓝 (K * Real.exp (-Δ * x))) := by
    apply Tendsto.const_mul
    exact Real.continuous_exp.continuousAt.tendsto.comp (hconv.const_mul (-Δ))
  exact le_of_tendsto_of_tendsto' h1 h2 fun n => hcl n (R n)

end Lattice

end Aperanton
