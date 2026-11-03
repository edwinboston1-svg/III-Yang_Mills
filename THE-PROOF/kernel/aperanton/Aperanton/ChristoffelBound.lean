import Mathlib

/-!
# ChristoffelBound.lean -- THE NON-UNIFORM CHRISTOFFEL CONSTANT OF THE 2⁴ BLOCK: M ≤ 3(1 + √2), SHARP PER FACE

The one-block floor (the ledger's §92 bis, §98) needs the constant M in sup_{|x| = 1} Σ_p |w_p(x)| ≤ M, where x ∈ (ℝ³)^32 holds the
Lie-algebra coordinates of the 32 links of a 2⁴ block, p runs over its 24 faces, and w_p is the face's Christoffel coupling.
Both orderings of a pair of links give the same term, so with y_i = ε_i x_{ℓ_i} (the face's links in product order, ε = (+, +,
−, −)) the coupling is w_p(x) = −2 B(y), B(y) = Σ_{i<j} y_i × y_j.  This file proves, for four vectors of ℝ³,

  |B(y)| ≤ ((1 + √2)/2) Σ |y_i|²,     with equality at y_j = (cos(jπ/4), sin(jπ/4), 0),

and so, each link lying in exactly three faces of the block, Σ_p |w_p| ≤ 3(1 + √2)|x|² (`block_bound`).  THE PROOF, elementary
and with no spectral theory: B = ½ Σ_i y_i × w_i with w_i = Σ_j sgn(j − i) y_j (`two_B`); for a unit u, u·(y × w) = (u × y)·w ≤
(t|u × y|² + |w|²/t)/2 ≤ (t|y|² + |w|²/t)/2 (Lagrange, `lagrange_le`); and Σ_i |w_i|² ≤ (3 + 2√2) Σ_i |y_i|² by the explicit sum of
squares (3 + 2s)|x|² − |Tx|² = 2(s − 1)(a² + b²) + 2(a + b)², s = √2, a = x₀ − s x₁ + x₂, b = x₁ − s x₂ + x₃ (`sign_quad`: the
4 × 4 sign matrix T has |T|² = cot²(π/8) = 3 + 2√2); the choice t = 1 + √2 balances the two terms because (1 + √2)² = 3 + 2√2.
The numerical sup over the whole block, 6.2595 (§92 bis), and Fontes's uniform ‖S‖ = 5.9601 lie below 3(1 + √2) = 7.2426.
No sorry, no axiom, no native_decide.
-/

namespace ChristoffelBound

open Matrix

/-- the face's bilinear B(y) = Σ_{i<j} y_i × y_j -/
noncomputable def Bf (y0 y1 y2 y3 : Fin 3 → ℝ) : Fin 3 → ℝ :=
  crossProduct y0 y1 + crossProduct y0 y2 + crossProduct y0 y3 + crossProduct y1 y2 + crossProduct y1 y3 +
    crossProduct y2 y3

/-- the squared Euclidean length -/
noncomputable def sq3 (v : Fin 3 → ℝ) : ℝ := dotProduct v v

theorem sq3_eq (v : Fin 3 → ℝ) : sq3 v = v 0 ^ 2 + v 1 ^ 2 + v 2 ^ 2 := by
  simp only [sq3, dotProduct, Fin.sum_univ_three]
  ring

theorem sq3_nonneg (v : Fin 3 → ℝ) : 0 ≤ sq3 v := by
  rw [sq3_eq]
  positivity

/-- THE SIGN MATRIX'S NORM, AS A SUM OF SQUARES: |Tx|² ≤ (3 + 2√2)|x|² for the 4 × 4 matrix T_ij = sgn(j − i) -/
theorem sign_quad (a b c d : ℝ) :
    (b + c + d) ^ 2 + (-a + c + d) ^ 2 + (-a - b + d) ^ 2 + (-a - b - c) ^ 2 ≤
      (3 + 2 * Real.sqrt 2) * (a ^ 2 + b ^ 2 + c ^ 2 + d ^ 2) := by
  have hs : Real.sqrt 2 ^ 2 = 2 := Real.sq_sqrt (by norm_num)
  have hs0 : 0 ≤ Real.sqrt 2 := Real.sqrt_nonneg 2
  have hs1 : 1 < Real.sqrt 2 := by nlinarith
  set s := Real.sqrt 2 with hsdef
  have key : (3 + 2 * s) * (a ^ 2 + b ^ 2 + c ^ 2 + d ^ 2) -
      ((b + c + d) ^ 2 + (-a + c + d) ^ 2 + (-a - b + d) ^ 2 + (-a - b - c) ^ 2) =
      2 * (s - 1) * ((a - s * b + c) ^ 2 + (b - s * c + d) ^ 2) + 2 * ((a - s * b + c) + (b - s * c + d)) ^ 2 := by
    linear_combination (-(2 * s * (b ^ 2 + c ^ 2)) + 4 * a * b + 4 * b * c + 4 * c * d) * hs
  have h1 : 0 ≤ 2 * (s - 1) * ((a - s * b + c) ^ 2 + (b - s * c + d) ^ 2) := by
    have : 0 ≤ s - 1 := by linarith
    positivity
  have h2 : 0 ≤ 2 * ((a - s * b + c) + (b - s * c + d)) ^ 2 := by positivity
  linarith

/-- Lagrange: |u × y|² ≤ |u|²|y|² -/
theorem lagrange_le (u y : Fin 3 → ℝ) : sq3 (crossProduct u y) ≤ sq3 u * sq3 y := by
  rw [sq3_eq, sq3_eq, sq3_eq, cross_apply]
  simp only [Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.head_cons, Matrix.cons_val_two, Matrix.tail_cons]
  nlinarith [sq_nonneg (u 0 * y 0 + u 1 * y 1 + u 2 * y 2)]

/-- the triple product moves the cross: u·(y × w) = (u × y)·w -/
theorem triple (u y w : Fin 3 → ℝ) : dotProduct u (crossProduct y w) = dotProduct (crossProduct u y) w := by
  rw [cross_apply, cross_apply]
  simp only [dotProduct, Fin.sum_univ_three, Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.head_cons,
    Matrix.cons_val_two, Matrix.tail_cons]
  ring

/-- the arithmetic-geometric mean for a dot product: 2 p·q ≤ t|p|² + |q|²/t -/
theorem amgm_dot (p q : Fin 3 → ℝ) (t : ℝ) (ht : 0 < t) : 2 * dotProduct p q ≤ t * sq3 p + sq3 q / t := by
  rw [sq3_eq, sq3_eq]
  simp only [dotProduct, Fin.sum_univ_three]
  have key : t * (p 0 ^ 2 + p 1 ^ 2 + p 2 ^ 2) + (q 0 ^ 2 + q 1 ^ 2 + q 2 ^ 2) / t -
      2 * (p 0 * q 0 + p 1 * q 1 + p 2 * q 2) =
      ((t * p 0 - q 0) ^ 2 + (t * p 1 - q 1) ^ 2 + (t * p 2 - q 2) ^ 2) / t := by
    field_simp
    ring
  have h : 0 ≤ ((t * p 0 - q 0) ^ 2 + (t * p 1 - q 1) ^ 2 + (t * p 2 - q 2) ^ 2) / t := by positivity
  linarith

/-- B = ½ Σ_i y_i × w_i, w_i = Σ_j sgn(j − i) y_j: the face's bilinear through the sign matrix -/
theorem two_B (y0 y1 y2 y3 : Fin 3 → ℝ) (u : Fin 3 → ℝ) :
    2 * dotProduct u (Bf y0 y1 y2 y3) =
      dotProduct u (crossProduct y0 (y1 + y2 + y3)) + dotProduct u (crossProduct y1 (-y0 + y2 + y3)) +
        dotProduct u (crossProduct y2 (-y0 - y1 + y3)) + dotProduct u (crossProduct y3 (-y0 - y1 - y2)) := by
  simp only [Bf, cross_apply, dotProduct, Fin.sum_univ_three, Pi.add_apply, Pi.neg_apply, Pi.sub_apply,
    Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.head_cons, Matrix.cons_val_two, Matrix.tail_cons]
  ring

/-- the sign matrix's bound on vectors: Σ_i |w_i|² ≤ (3 + 2√2) Σ_i |y_i|² -/
theorem sign_vec (y0 y1 y2 y3 : Fin 3 → ℝ) :
    sq3 (y1 + y2 + y3) + sq3 (-y0 + y2 + y3) + sq3 (-y0 - y1 + y3) + sq3 (-y0 - y1 - y2) ≤
      (3 + 2 * Real.sqrt 2) * (sq3 y0 + sq3 y1 + sq3 y2 + sq3 y3) := by
  simp only [sq3_eq, Pi.add_apply, Pi.neg_apply, Pi.sub_apply]
  have h0 := sign_quad (y0 0) (y1 0) (y2 0) (y3 0)
  have h1 := sign_quad (y0 1) (y1 1) (y2 1) (y3 1)
  have h2 := sign_quad (y0 2) (y1 2) (y2 2) (y3 2)
  nlinarith [h0, h1, h2]

/-- THE FACE BOUND, linear form: for a unit u, u·B(y) ≤ ((1 + √2)/2) Σ |y_i|² -/
theorem face_dot_le (y0 y1 y2 y3 u : Fin 3 → ℝ) (hu : sq3 u = 1) :
    dotProduct u (Bf y0 y1 y2 y3) ≤ (1 + Real.sqrt 2) / 2 * (sq3 y0 + sq3 y1 + sq3 y2 + sq3 y3) := by
  have hs : Real.sqrt 2 ^ 2 = 2 := Real.sq_sqrt (by norm_num)
  have hs0 : 0 ≤ Real.sqrt 2 := Real.sqrt_nonneg 2
  set t := 1 + Real.sqrt 2 with htdef
  have ht : 0 < t := by rw [htdef]; linarith
  have htt : (3 + 2 * Real.sqrt 2) / t = t := by
    rw [div_eq_iff ht.ne']
    rw [htdef]
    nlinarith
  -- each term u·(y_i × w_i) = (u × y_i)·w_i ≤ (t|u × y_i|² + |w_i|²/t)/2 ≤ (t|y_i|² + |w_i|²/t)/2
  have term : ∀ y w : Fin 3 → ℝ, 2 * dotProduct u (crossProduct y w) ≤ t * sq3 y + sq3 w / t := by
    intro y w
    rw [triple]
    have h1 := amgm_dot (crossProduct u y) w t ht
    have h2 := lagrange_le u y
    rw [hu, one_mul] at h2
    have h3 : t * sq3 (crossProduct u y) ≤ t * sq3 y := mul_le_mul_of_nonneg_left h2 ht.le
    linarith
  have e := two_B y0 y1 y2 y3 u
  have k0 := term y0 (y1 + y2 + y3)
  have k1 := term y1 (-y0 + y2 + y3)
  have k2 := term y2 (-y0 - y1 + y3)
  have k3 := term y3 (-y0 - y1 - y2)
  have hw := sign_vec y0 y1 y2 y3
  have hW : (sq3 (y1 + y2 + y3) + sq3 (-y0 + y2 + y3) + sq3 (-y0 - y1 + y3) + sq3 (-y0 - y1 - y2)) / t ≤
      t * (sq3 y0 + sq3 y1 + sq3 y2 + sq3 y3) := by
    rw [div_le_iff₀ ht]
    calc _ ≤ (3 + 2 * Real.sqrt 2) * (sq3 y0 + sq3 y1 + sq3 y2 + sq3 y3) := hw
      _ = t * (sq3 y0 + sq3 y1 + sq3 y2 + sq3 y3) * t := by
        rw [htdef]
        linear_combination (-(sq3 y0 + sq3 y1 + sq3 y2 + sq3 y3)) * hs
  have hsum : sq3 (y1 + y2 + y3) / t + sq3 (-y0 + y2 + y3) / t + sq3 (-y0 - y1 + y3) / t + sq3 (-y0 - y1 - y2) / t =
      (sq3 (y1 + y2 + y3) + sq3 (-y0 + y2 + y3) + sq3 (-y0 - y1 + y3) + sq3 (-y0 - y1 - y2)) / t := by ring
  have h4 : 2 * (2 * dotProduct u (Bf y0 y1 y2 y3)) ≤ 2 * (t * (sq3 y0 + sq3 y1 + sq3 y2 + sq3 y3)) := by
    linarith
  have h5 : dotProduct u (Bf y0 y1 y2 y3) ≤ t / 2 * (sq3 y0 + sq3 y1 + sq3 y2 + sq3 y3) := by linarith
  rw [htdef] at h5
  exact h5

/-- THE FACE BOUND: |B(y)|² ≤ ((1 + √2)/2)² (Σ |y_i|²)² -/
theorem face_bound (y0 y1 y2 y3 : Fin 3 → ℝ) :
    sq3 (Bf y0 y1 y2 y3) ≤ ((1 + Real.sqrt 2) / 2 * (sq3 y0 + sq3 y1 + sq3 y2 + sq3 y3)) ^ 2 := by
  set B := Bf y0 y1 y2 y3 with hB
  set S := sq3 y0 + sq3 y1 + sq3 y2 + sq3 y3 with hS
  have hS0 : 0 ≤ S := by
    have := sq3_nonneg y0; have := sq3_nonneg y1; have := sq3_nonneg y2; have := sq3_nonneg y3
    rw [hS]; linarith
  have hc0 : 0 ≤ (1 + Real.sqrt 2) / 2 * S := by
    have : 0 ≤ Real.sqrt 2 := Real.sqrt_nonneg 2
    positivity
  rcases (sq3_nonneg B).eq_or_lt with h0 | hpos
  · rw [← h0]; positivity
  · set r := Real.sqrt (sq3 B) with hr
    have hr0 : 0 < r := Real.sqrt_pos.mpr hpos
    have hrr : r * r = sq3 B := Real.mul_self_sqrt (sq3_nonneg B)
    have hu : sq3 (r⁻¹ • B) = 1 := by
      simp only [sq3, dotProduct_smul, smul_dotProduct, smul_eq_mul]
      rw [show r⁻¹ * (r⁻¹ * dotProduct B B) = dotProduct B B / (r * r) by field_simp]
      rw [hrr]; exact div_self (ne_of_gt hpos)
    have hd := face_dot_le y0 y1 y2 y3 (r⁻¹ • B) hu
    have hdB : dotProduct (r⁻¹ • B) B = r := by
      simp only [smul_dotProduct, smul_eq_mul]
      have : dotProduct B B = r * r := by rw [hrr]; rfl
      rw [this]; field_simp
    rw [← hB, hdB] at hd
    have : r * r ≤ ((1 + Real.sqrt 2) / 2 * S) * ((1 + Real.sqrt 2) / 2 * S) :=
      mul_self_le_mul_self hr0.le hd
    rw [hrr] at this
    nlinarith [this]

/-- THE BOUND IS ATTAINED: y_j = (cos(jπ/4), sin(jπ/4), 0) gives B = (0, 0, 2 + 2√2) and Σ |y_j|² = 4 -/
theorem face_sharp :
    let s := Real.sqrt 2
    let y0 : Fin 3 → ℝ := ![1, 0, 0]
    let y1 : Fin 3 → ℝ := ![s / 2, s / 2, 0]
    let y2 : Fin 3 → ℝ := ![0, 1, 0]
    let y3 : Fin 3 → ℝ := ![-(s / 2), s / 2, 0]
    sq3 y0 + sq3 y1 + sq3 y2 + sq3 y3 = 4 ∧
      sq3 (Bf y0 y1 y2 y3) = ((1 + s) / 2 * (sq3 y0 + sq3 y1 + sq3 y2 + sq3 y3)) ^ 2 := by
  intro s y0 y1 y2 y3
  have hs : s ^ 2 = 2 := Real.sq_sqrt (by norm_num)
  have hsum : sq3 y0 + sq3 y1 + sq3 y2 + sq3 y3 = 4 := by
    simp only [sq3_eq, y0, y1, y2, y3, Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.head_cons,
      Matrix.cons_val_two, Matrix.tail_cons]
    nlinarith [hs]
  refine ⟨hsum, ?_⟩
  rw [hsum]
  simp only [sq3_eq, Bf, cross_apply, y0, y1, y2, y3, Pi.add_apply, Matrix.cons_val_zero, Matrix.cons_val_one,
    Matrix.head_cons, Matrix.cons_val_two, Matrix.tail_cons]
  have hs4 : s ^ 4 = 4 := by nlinarith [hs]
  nlinarith [hs, hs4]

/-- THE BLOCK BOUND from the face bound and the incidence: faces F, each with four links f p i of a link set ι and signs
ε p i = ±1; if every nonnegative weight summed over the faces' link slots is at most three times its sum over the links
(each link in at most three faces), then Σ_p |w_p| ≤ 3(1 + √2) Σ_ℓ |x_ℓ|², w_p = −2 B(ε x_f) -/
theorem block_bound {ι Φ : Type*} [Fintype ι] (F : Finset Φ) (f : Φ → Fin 4 → ι) (ε : Φ → Fin 4 → ℝ)
    (hε : ∀ p i, ε p i ^ 2 = 1)
    (hinc : ∀ g : ι → ℝ, (∀ l, 0 ≤ g l) → ∑ p ∈ F, ∑ i : Fin 4, g (f p i) ≤ 3 * ∑ l, g l)
    (x : ι → (Fin 3 → ℝ)) :
    ∑ p ∈ F, Real.sqrt (sq3 ((-2 : ℝ) • Bf (ε p 0 • x (f p 0)) (ε p 1 • x (f p 1)) (ε p 2 • x (f p 2))
        (ε p 3 • x (f p 3)))) ≤ 3 * (1 + Real.sqrt 2) * ∑ l, sq3 (x l) := by
  have hs0 : 0 ≤ Real.sqrt 2 := Real.sqrt_nonneg 2
  have hsc : ∀ (e : ℝ) (v : Fin 3 → ℝ), e ^ 2 = 1 → sq3 (e • v) = sq3 v := by
    intro e v he
    simp only [sq3, dotProduct_smul, smul_dotProduct, smul_eq_mul]
    rw [← mul_assoc, ← sq, he, one_mul]
  have hface : ∀ p, Real.sqrt (sq3 ((-2 : ℝ) • Bf (ε p 0 • x (f p 0)) (ε p 1 • x (f p 1)) (ε p 2 • x (f p 2))
      (ε p 3 • x (f p 3)))) ≤ (1 + Real.sqrt 2) * ∑ i : Fin 4, sq3 (x (f p i)) := by
    intro p
    have hb := face_bound (ε p 0 • x (f p 0)) (ε p 1 • x (f p 1)) (ε p 2 • x (f p 2)) (ε p 3 • x (f p 3))
    rw [hsc _ _ (hε p 0), hsc _ _ (hε p 1), hsc _ _ (hε p 2), hsc _ _ (hε p 3)] at hb
    have h4 : sq3 ((-2 : ℝ) • Bf (ε p 0 • x (f p 0)) (ε p 1 • x (f p 1)) (ε p 2 • x (f p 2)) (ε p 3 • x (f p 3))) =
        4 * sq3 (Bf (ε p 0 • x (f p 0)) (ε p 1 • x (f p 1)) (ε p 2 • x (f p 2)) (ε p 3 • x (f p 3))) := by
      simp only [sq3, dotProduct_smul, smul_dotProduct, smul_eq_mul]
      ring
    rw [h4, Fin.sum_univ_four]
    have hS0 : 0 ≤ (1 + Real.sqrt 2) * (sq3 (x (f p 0)) + sq3 (x (f p 1)) + sq3 (x (f p 2)) + sq3 (x (f p 3))) := by
      have := sq3_nonneg (x (f p 0)); have := sq3_nonneg (x (f p 1))
      have := sq3_nonneg (x (f p 2)); have := sq3_nonneg (x (f p 3))
      positivity
    rw [Real.sqrt_le_left hS0]
    calc 4 * sq3 (Bf (ε p 0 • x (f p 0)) (ε p 1 • x (f p 1)) (ε p 2 • x (f p 2)) (ε p 3 • x (f p 3)))
        ≤ 4 * ((1 + Real.sqrt 2) / 2 * (sq3 (x (f p 0)) + sq3 (x (f p 1)) + sq3 (x (f p 2)) + sq3 (x (f p 3)))) ^ 2 :=
          by linarith
      _ = ((1 + Real.sqrt 2) * (sq3 (x (f p 0)) + sq3 (x (f p 1)) + sq3 (x (f p 2)) + sq3 (x (f p 3)))) ^ 2 := by ring
  calc ∑ p ∈ F, Real.sqrt (sq3 ((-2 : ℝ) • Bf (ε p 0 • x (f p 0)) (ε p 1 • x (f p 1)) (ε p 2 • x (f p 2))
          (ε p 3 • x (f p 3))))
      ≤ ∑ p ∈ F, (1 + Real.sqrt 2) * ∑ i : Fin 4, sq3 (x (f p i)) := Finset.sum_le_sum fun p _ => hface p
    _ = (1 + Real.sqrt 2) * ∑ p ∈ F, ∑ i : Fin 4, sq3 (x (f p i)) := by rw [Finset.mul_sum]
    _ ≤ (1 + Real.sqrt 2) * (3 * ∑ l, sq3 (x l)) := by
        apply mul_le_mul_of_nonneg_left (hinc (fun l => sq3 (x l)) (fun l => sq3_nonneg _))
        positivity
    _ = 3 * (1 + Real.sqrt 2) * ∑ l, sq3 (x l) := by ring

end ChristoffelBound
