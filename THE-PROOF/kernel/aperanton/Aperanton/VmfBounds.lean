import Mathlib

/-!
# VmfBounds.lean -- THE GROUND'S LEMMA 8.6 IN THE KERNEL: the von Mises-Fisher constants of the decimation's row

Theorem 8.7 (the perfect decimation's Dobrushin certificate, STDLIB/scripts/aperanton_decimation_cert.awk, the proved
pass: beta_0 = 0.2410) rests on four bounds on the SU(2) one-link law's cumulants along the von Mises-Fisher family of
concentration r.  With I_nu the modified Bessel functions and m = I_2/I_1 (the mean resultant along the axis):

  (P)  the perpendicular variance  m/r <= 1/4;
  (V)  the axial variance  phi'' = 1 - 3m/r - m^2 <= 1/4;
  (D)  the anisotropy  D = phi'' - m/r  lies in [-m^2/3, 0];
  (T)  the third cumulant  |phi'''| <= m/2.

By Neumann's product formula  I_mu I_nu = sum_k (r/2)^(2k+mu+nu) (2k+mu+nu)!/(k! (k+mu)! (k+nu)! (k+mu+nu)!)  and the
Vandermonde evaluation  sum_j C(a,j) C(b,k-j) = C(a+b,k)  of the Cauchy products, each of (P), (V), (D) is a TERMWISE
inequality between power series with nonnegative coefficients, the Bessel recurrence  r(I_1 - I_3) = 4 I_2  carrying the
product inequalities into the ratio m:

  (V)      4 I_2^2 - 3 I_1 I_3 >= 0 : the coefficient of (r/2)^(2k+4) is C(2k+4,k) (k+6) / ((k+2) (k+1)! (k+3)!)   `lower`
  (D <= 0)   I_2^2 -   I_1 I_3 >= 0 : C(2k+4,k) / ((k+2) (k+1)! (k+3)!)   -- Turan's inequality                      `turan`
  (D >= -m^2/3) 3 I_1 I_3 - 2 I_2^2 >= 0 : C(2k+4,k) k / ((k+2) (k+1)! (k+3)!)                                         `upper`
  (P)      r I_1 - 4 I_2 >= 0       : the coefficient of (r/2)^(2k+2) is 2k / (k! (k+2)!)                             `perp`

and (T) is the Riccati identity  phi''' = 3|D|/r - 2 m phi''  (the ratio obeys  m' = 1 - 3m/r - m^2) read with the four
bounds.  This file decides, in the kernel: the closed forms and signs of the four coefficient sequences for every k; the
four translations from the product inequalities and the recurrence to the bounds on m (pure algebra, given the series'
VALUES); the Riccati identity's algebraic content; and (T) from (P), (V), (D).  The analytic steps -- the series as
functions, Neumann's formula, the recurrence, the derivative of the ratio -- stay on the page as the hypotheses these
identities serve (NeumannCoeff.lean's pattern); the instrument reads the same series at 256 bits.  No sorry, no axiom,
no native_decide.
-/

namespace VmfBounds

open Nat

/-! ## The coefficient sequences, by Neumann's formula after the Vandermonde evaluation -/

/-- the coefficient of (r/2)^(2k+4) in I_2^2 -/
noncomputable def p22 (k : ℕ) : ℚ := ((2 * k + 4).choose k : ℚ) / (((k + 2)! : ℚ) ^ 2)

/-- the coefficient of (r/2)^(2k+4) in I_1 I_3 -/
noncomputable def p13 (k : ℕ) : ℚ := ((2 * k + 4).choose k : ℚ) / (((k + 1)! : ℚ) * ((k + 3)! : ℚ))

/-- Turan's coefficient, I_2^2 - I_1 I_3 -/
noncomputable def turan (k : ℕ) : ℚ := p22 k - p13 k

noncomputable def turanClosed (k : ℕ) : ℚ :=
  ((2 * k + 4).choose k : ℚ) / (((k : ℚ) + 2) * ((k + 1)! : ℚ) * ((k + 3)! : ℚ))

/-- the lower Turan coefficient, 4 I_2^2 - 3 I_1 I_3 (the axial variance's bound) -/
noncomputable def lower (k : ℕ) : ℚ := 4 * p22 k - 3 * p13 k

noncomputable def lowerClosed (k : ℕ) : ℚ :=
  ((2 * k + 4).choose k : ℚ) * ((k : ℚ) + 6) / (((k : ℚ) + 2) * ((k + 1)! : ℚ) * ((k + 3)! : ℚ))

/-- the upper Turan coefficient, 3 I_1 I_3 - 2 I_2^2 (the anisotropy's floor) -/
noncomputable def upper (k : ℕ) : ℚ := 3 * p13 k - 2 * p22 k

noncomputable def upperClosed (k : ℕ) : ℚ :=
  ((2 * k + 4).choose k : ℚ) * (k : ℚ) / (((k : ℚ) + 2) * ((k + 1)! : ℚ) * ((k + 3)! : ℚ))

/-- the perpendicular coefficient of (r/2)^(2k+2) in r I_1 - 4 I_2 -/
noncomputable def perp (k : ℕ) : ℚ := 2 / ((k ! : ℚ) * ((k + 1)! : ℚ)) - 4 / ((k ! : ℚ) * ((k + 2)! : ℚ))

noncomputable def perpClosed (k : ℕ) : ℚ := 2 * (k : ℚ) / ((k ! : ℚ) * ((k + 2)! : ℚ))

theorem factorial_pos_q (n : ℕ) : (0 : ℚ) < (n ! : ℚ) := by exact_mod_cast Nat.factorial_pos n

theorem choose_pos_q (k : ℕ) : (0 : ℚ) < ((2 * k + 4).choose k : ℚ) := by
  exact_mod_cast Nat.choose_pos (by omega : k ≤ 2 * k + 4)

/-- the factorial steps as rational identities -/
theorem fact1_q (k : ℕ) : ((k + 1)! : ℚ) = ((k : ℚ) + 1) * (k ! : ℚ) := by
  rw [Nat.factorial_succ]; push_cast; ring

theorem fact2_q (k : ℕ) : ((k + 2)! : ℚ) = ((k : ℚ) + 2) * ((k + 1)! : ℚ) := by
  rw [show k + 2 = (k + 1) + 1 by ring, Nat.factorial_succ]; push_cast; ring

theorem fact3_q (k : ℕ) : ((k + 3)! : ℚ) = ((k : ℚ) + 3) * ((k : ℚ) + 2) * ((k + 1)! : ℚ) := by
  rw [show k + 3 = (k + 2) + 1 by ring, Nat.factorial_succ, show k + 2 = (k + 1) + 1 by ring, Nat.factorial_succ]
  push_cast; ring

/-! ## The closed forms -/

/-- TURAN'S COEFFICIENT, closed -/
theorem turan_closed (k : ℕ) : turan k = turanClosed k := by
  unfold turan turanClosed p22 p13
  rw [fact2_q, fact3_q]
  have hf : ((k + 1)! : ℚ) ≠ 0 := ne_of_gt (factorial_pos_q (k + 1))
  have h2 : (k : ℚ) + 2 ≠ 0 := by positivity
  have h3 : (k : ℚ) + 3 ≠ 0 := by positivity
  field_simp
  ring

/-- THE LOWER TURAN COEFFICIENT, closed -/
theorem lower_closed (k : ℕ) : lower k = lowerClosed k := by
  unfold lower lowerClosed p22 p13
  rw [fact2_q, fact3_q]
  have hf : ((k + 1)! : ℚ) ≠ 0 := ne_of_gt (factorial_pos_q (k + 1))
  have h2 : (k : ℚ) + 2 ≠ 0 := by positivity
  have h3 : (k : ℚ) + 3 ≠ 0 := by positivity
  field_simp
  ring

/-- THE UPPER TURAN COEFFICIENT, closed -/
theorem upper_closed (k : ℕ) : upper k = upperClosed k := by
  unfold upper upperClosed p22 p13
  rw [fact3_q, fact2_q]
  have hf : ((k + 1)! : ℚ) ≠ 0 := ne_of_gt (factorial_pos_q (k + 1))
  have h2 : (k : ℚ) + 2 ≠ 0 := by positivity
  have h3 : (k : ℚ) + 3 ≠ 0 := by positivity
  field_simp
  ring

/-- THE PERPENDICULAR COEFFICIENT, closed -/
theorem perp_closed (k : ℕ) : perp k = perpClosed k := by
  unfold perp perpClosed
  rw [fact2_q, fact1_q]
  have hf : (k ! : ℚ) ≠ 0 := ne_of_gt (factorial_pos_q k)
  have h1 : (k : ℚ) + 1 ≠ 0 := by positivity
  have h2 : (k : ℚ) + 2 ≠ 0 := by positivity
  field_simp
  ring

/-! ## The signs -/

/-- Turan's coefficient is positive for every k: I_2^2 - I_1 I_3 is a series with positive coefficients -/
theorem turan_pos (k : ℕ) : 0 < turan k := by
  rw [turan_closed]; unfold turanClosed
  have hc := choose_pos_q k
  have hd : (0 : ℚ) < ((k : ℚ) + 2) * ((k + 1)! : ℚ) * ((k + 3)! : ℚ) := by positivity
  exact div_pos hc hd

/-- the lower Turan coefficient is positive: 4 I_2^2 - 3 I_1 I_3 has positive coefficients -/
theorem lower_pos (k : ℕ) : 0 < lower k := by
  rw [lower_closed]; unfold lowerClosed
  have hc := choose_pos_q k
  have hn : (0 : ℚ) < ((2 * k + 4).choose k : ℚ) * ((k : ℚ) + 6) := by positivity
  have hd : (0 : ℚ) < ((k : ℚ) + 2) * ((k + 1)! : ℚ) * ((k + 3)! : ℚ) := by positivity
  exact div_pos hn hd

/-- the upper Turan coefficient is nonnegative, zero exactly at k = 0: 3 I_1 I_3 - 2 I_2^2 has nonnegative coefficients -/
theorem upper_nonneg (k : ℕ) : 0 ≤ upper k := by
  rw [upper_closed]; unfold upperClosed
  positivity

theorem upper_zero : upper 0 = 0 := by
  rw [upper_closed]; unfold upperClosed; norm_num

theorem upper_one_pos : 0 < upper 1 := by
  rw [upper_closed]; unfold upperClosed; norm_num [Nat.factorial]

/-- the perpendicular coefficient is nonnegative, zero exactly at k = 0: r I_1 - 4 I_2 has nonnegative coefficients -/
theorem perp_nonneg (k : ℕ) : 0 ≤ perp k := by
  rw [perp_closed]; unfold perpClosed
  positivity

theorem perp_zero : perp 0 = 0 := by
  rw [perp_closed]; unfold perpClosed; norm_num

/-! ## From the products to the ratio: the four bounds on m, given the series' values and the recurrence -/

/-- (P) the perpendicular variance: from 4 I_2 <= r I_1,  m/r <= 1/4 -/
theorem perp_variance_le (I1 I2 r : ℝ) (h1 : 0 < I1) (hr : 0 < r) (hP : 4 * I2 ≤ r * I1) :
    (I2 / I1) / r ≤ 1 / 4 := by
  have key : (I2 / I1) / r = I2 / (I1 * r) := by field_simp
  rw [key, div_le_iff₀ (by positivity)]
  nlinarith

/-- (V) the axial variance: from the recurrence r (I_1 - I_3) = 4 I_2 and 3 I_1 I_3 <= 4 I_2^2,  1 - 3m/r - m^2 <= 1/4 -/
theorem axial_variance_le (I1 I2 I3 r : ℝ) (h1 : 0 < I1) (hr : 0 < r) (hrec : r * (I1 - I3) = 4 * I2)
    (hT : 3 * I1 * I3 ≤ 4 * I2 ^ 2) :
    1 - 3 * (I2 / I1) / r - (I2 / I1) ^ 2 ≤ 1 / 4 := by
  have key : 1 - 3 * (I2 / I1) / r - (I2 / I1) ^ 2 = (I1 ^ 2 * r - 3 * I1 * I2 - I2 ^ 2 * r) / (I1 ^ 2 * r) := by
    field_simp <;> ring
  rw [key, div_le_iff₀ (by positivity)]
  have h3 : I1 * (r * I3) = I1 * (r * I1 - 4 * I2) := by rw [show r * I3 = r * I1 - 4 * I2 by linarith]
  nlinarith [mul_le_mul_of_nonneg_left hT hr.le, h3]

/-- (D <= 0) the anisotropy is nonpositive: from the recurrence and Turan's I_1 I_3 <= I_2^2 -/
theorem anisotropy_nonpos (I1 I2 I3 r : ℝ) (h1 : 0 < I1) (hr : 0 < r) (hrec : r * (I1 - I3) = 4 * I2)
    (hT : I1 * I3 ≤ I2 ^ 2) :
    (1 - 3 * (I2 / I1) / r - (I2 / I1) ^ 2) - (I2 / I1) / r ≤ 0 := by
  have key : (1 - 3 * (I2 / I1) / r - (I2 / I1) ^ 2) - (I2 / I1) / r
      = (I1 ^ 2 * r - 4 * I1 * I2 - I2 ^ 2 * r) / (I1 ^ 2 * r) := by
    field_simp; ring
  rw [key, div_le_iff₀ (by positivity)]
  have h3 : I1 * (r * I3) = I1 * (r * I1 - 4 * I2) := by rw [show r * I3 = r * I1 - 4 * I2 by linarith]
  nlinarith [mul_le_mul_of_nonneg_left hT hr.le, h3]

/-- (D >= -m^2/3) the anisotropy's floor: from the recurrence and the upper Turan 2 I_2^2 <= 3 I_1 I_3 -/
theorem anisotropy_lower (I1 I2 I3 r : ℝ) (h1 : 0 < I1) (hr : 0 < r) (hrec : r * (I1 - I3) = 4 * I2)
    (hU : 2 * I2 ^ 2 ≤ 3 * I1 * I3) :
    -((I2 / I1) ^ 2) / 3 ≤ (1 - 3 * (I2 / I1) / r - (I2 / I1) ^ 2) - (I2 / I1) / r := by
  have key : (1 - 3 * (I2 / I1) / r - (I2 / I1) ^ 2) - (I2 / I1) / r - (-((I2 / I1) ^ 2) / 3)
      = (3 * I1 ^ 2 * r - 12 * I1 * I2 - 2 * I2 ^ 2 * r) / (3 * I1 ^ 2 * r) := by
    field_simp; ring
  have hpos : 0 ≤ (3 * I1 ^ 2 * r - 12 * I1 * I2 - 2 * I2 ^ 2 * r) / (3 * I1 ^ 2 * r) := by
    apply div_nonneg _ (by positivity)
    have h3 : I1 * (r * I3) = I1 * (r * I1 - 4 * I2) := by rw [show r * I3 = r * I1 - 4 * I2 by linarith]
    nlinarith [mul_le_mul_of_nonneg_left hU hr.le, h3]
  linarith [key, hpos]

/-! ## The third cumulant -/

/-- the Riccati identity's algebraic content: with phi'' = 1 - 3m/r - m^2 and |D| = m^2 + 4m/r - 1, the two expressions
of phi''' agree -- the page supplies m' = phi'' and m'' = 3m/r^2 - (3/r + 2m) m' -/
theorem riccati_identity (m r : ℝ) (hr : r ≠ 0) :
    3 * (m ^ 2 + 4 * m / r - 1) / r - 2 * m * (1 - 3 * m / r - m ^ 2)
      = 3 * m / r ^ 2 - (3 / r + 2 * m) * (1 - 3 * m / r - m ^ 2) := by
  field_simp
  ring

/-- (T) from (P), (V), (D): with 0 <= |D| <= m^2/3, 0 <= phi'' <= 1/4 and m/r <= 1/4,  |3|D|/r - 2 m phi''| <= m/2 -/
theorem third_cumulant_bound (m r D ph2 : ℝ) (hm : 0 ≤ m) (hr : 0 < r) (hD0 : 0 ≤ D) (hD : D ≤ m ^ 2 / 3)
    (hp0 : 0 ≤ ph2) (hp : ph2 ≤ 1 / 4) (hmr : m / r ≤ 1 / 4) :
    |3 * D / r - 2 * m * ph2| ≤ m / 2 := by
  have hm' : m ≤ r / 4 := by
    have := (div_le_iff₀ hr).mp hmr
    linarith
  have h3D : 3 * D ≤ m ^ 2 := by linarith
  have hm2 : m ^ 2 ≤ m * r / 4 := by nlinarith [mul_le_mul_of_nonneg_left hm' hm]
  have hA : 3 * D / r ≤ m / 4 := by
    rw [div_le_iff₀ hr]; nlinarith
  have hB : 0 ≤ 3 * D / r := by positivity
  have hC : 2 * m * ph2 ≤ m / 2 := by nlinarith [mul_le_mul_of_nonneg_left hp hm]
  have hD' : 0 ≤ 2 * m * ph2 := by positivity
  rw [abs_le]; constructor <;> linarith

end VmfBounds
