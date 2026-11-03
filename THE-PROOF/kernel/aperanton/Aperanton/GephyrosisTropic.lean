import Mathlib.Tactic

/-!
# ΓΕΦΥΡΩΣΙΣ — the tropical skeleton: the max-plus laws of the finite places (Addenda IV and VI)

At a ramified prime `p` the `p`-adic pole orders of the exact Galerkin–Euler orbit are bounded by
a max-plus recursion on the profile `t_k(s) = −v_p(c_k(s))`: the quadratic term of the step
carries `t'_k = max_{(a,b)} (t_a + t_b + ω_{ab;k})` (Theorem T). On the standing boxes the
recursion collapses onto a few blocks and has a closed form:

* **Theorem V (2D, K = 2, p = 5).** The ramified block `S` (the modes of norm 5) and the rest
  `R` obey `(x, y) ↦ (max(x + y + 1, 2y + 1, x), max(2x − 1, x + y, 2y, y))` from `(1, 0)`, and
  the solution is `x(s) = 2^{s−1}`, `y(s) = 2^{s−1} − 1`: the pole order doubles every step.
* **Theorem J (3D, K = 1, p = 3).** The recursion `x' = 2y + 1`, `y' = max(x + y, 2y)` from
  `(1, 0)` is solved by the Jacobsthal numbers: `x(s) = J_s`, `y(s) = J_s − [s odd]`, with
  `J_{s+1} = 2J_s + (−1)^s` and `3J_s = 2^s − (−1)^s`.
* **Theorem D (the closed profile).** Once the normalised profile is periodic with period `L`
  and per-step deficits `m_j`, the top obeys `T(s+1) = 2T(s) − m_s`, so over `n` periods
  `(2^L − 1)·T(s₀ + nL) = 2^{nL}·((2^L − 1)·T(s₀) − M) + M`, `M = Σ_{j<L} 2^{L−1−j} m_j`,
  and the growth rate `θ = lim T(s)/2^s = (T(s₀) − M/(2^L − 1))/2^{s₀}` is decided by one period.
* **Theorem H (the step shift, Addendum VI).** A max-plus quadratic map is homogeneous of
  degree two: adding `γ` to every coordinate adds `2γ` to every coordinate of the image, so a
  step `h = u/w` with `v_p(w) = m` shifts every profile of the flat start by `(2^s − 1)·m`.

Every statement here is a theorem about integer recursions; the correspondence with the orbit
is Theorem T (the soundness of the max-plus bound) and is checked on the numbers in
`GephyrosisCertificate2D` through the integer road.
-/

namespace Gephyrosis

/-! ## Theorem V: the 2D block recursion -/

/-- The block map of (2D, K = 2, p = 5) on `(x, y) = (S-top, R-top)` (Addendum IV, Theorem V). -/
def blockV (xy : ℕ × ℕ) : ℕ × ℕ :=
  (max (max (xy.1 + xy.2 + 1) (2 * xy.2 + 1)) xy.1,
   max (max (2 * xy.1 - 1) (xy.1 + xy.2)) (max (2 * xy.2) xy.2))

/-- One step of the block map on the invariant line `y + 1 = x`, `x ≥ 1`. -/
theorem blockV_step (x y : ℕ) (h : y + 1 = x) (_h1 : 1 ≤ x) :
    blockV (x, y) = (2 * x, 2 * x - 1) := by
  unfold blockV
  simp only [Prod.mk.injEq]
  omega

/-- **Theorem V.** From `(1, 0)` the block map reads `(2^{s−1}, 2^{s−1} − 1)` after `s − 1` steps:
`x(s) = 2^{s−1}` for every `s ≥ 1`. -/
theorem theoremV (n : ℕ) : blockV^[n] (1, 0) = (2 ^ n, 2 ^ n - 1) := by
  induction n with
  | zero => simp
  | succ n ih =>
    rw [Function.iterate_succ_apply', ih]
    have h1 : 1 ≤ 2 ^ n := Nat.one_le_two_pow
    rw [blockV_step (2 ^ n) (2 ^ n - 1) (by omega) h1]
    simp only [Prod.mk.injEq, pow_succ]
    omega

/-! ## Theorem J: the 3D recursion and the Jacobsthal numbers -/

/-- The Jacobsthal numbers `J₀ = 0, J₁ = 1, J_{n+2} = J_{n+1} + 2J_n`. -/
def jac : ℕ → ℕ
  | 0 => 0
  | 1 => 1
  | n + 2 => jac (n + 1) + 2 * jac n

theorem three_mul_jac (n : ℕ) : (3 * jac n : ℤ) = 2 ^ n - (-1) ^ n := by
  induction n using Nat.strong_induction_on with
  | _ n ih =>
    match n with
    | 0 => simp [jac]
    | 1 => simp [jac]
    | n + 2 =>
      have h1 := ih (n + 1) (by omega)
      have h0 := ih n (by omega)
      simp only [jac]
      push_cast at h1 h0 ⊢
      have e1 : (2 : ℤ) ^ (n + 2) = 4 * 2 ^ n := by ring
      have e2 : (-1 : ℤ) ^ (n + 2) = (-1) ^ n := by ring
      have e3 : (2 : ℤ) ^ (n + 1) = 2 * 2 ^ n := by ring
      have e4 : (-1 : ℤ) ^ (n + 1) = -(-1) ^ n := by ring
      linarith

/-- `J_{n+1} = 2 J_n + (−1)^n` -/
theorem jac_succ (n : ℕ) : (jac (n + 1) : ℤ) = 2 * jac n + (-1) ^ n := by
  have h1 := three_mul_jac (n + 1)
  have h0 := three_mul_jac n
  have e3 : (2 : ℤ) ^ (n + 1) = 2 * 2 ^ n := by ring
  have e4 : (-1 : ℤ) ^ (n + 1) = -(-1) ^ n := by ring
  linarith

theorem jac_pos (n : ℕ) (hn : 1 ≤ n) : 1 ≤ jac n := by
  induction n using Nat.strong_induction_on with
  | _ n ih =>
    match n with
    | 0 => omega
    | 1 => simp [jac]
    | n + 2 =>
      have := ih (n + 1) (by omega) (by omega)
      simp only [jac]; omega

/-- The block map of (3D, K = 1, p = 3) (Addendum IV, Theorem J). -/
def blockJ (xy : ℕ × ℕ) : ℕ × ℕ := (2 * xy.2 + 1, max (xy.1 + xy.2) (2 * xy.2))

/-- The parity indicator `[s odd]`. -/
def odd1 (s : ℕ) : ℕ := s % 2

/-- **Theorem J.** From `(1, 0)` at `s = 1`, the block map reads `(J_s, J_s − [s odd])` at step `s`. -/
theorem theoremJ (n : ℕ) : blockJ^[n] (1, 0) = (jac (n + 1), jac (n + 1) - odd1 (n + 1)) := by
  induction n with
  | zero => simp [jac, odd1]
  | succ n ih =>
    rw [Function.iterate_succ_apply', ih]
    unfold blockJ odd1
    simp only [Prod.mk.injEq]
    have hs := jac_succ (n + 1)
    have hs' := jac_succ (n + 2)
    have hp := jac_pos (n + 1) (by omega)
    rcases Nat.even_or_odd n with he | ho
    · -- n even: n + 1 odd, n + 2 even
      have h1 : ((-1 : ℤ) ^ (n + 1)) = -1 := by
        rw [pow_succ, he.neg_one_pow]; ring
      have h2 : ((-1 : ℤ) ^ (n + 2)) = 1 := by
        have : (n + 2) % 2 = 0 := by obtain ⟨k, hk⟩ := he; omega
        exact (Nat.even_iff.2 this).neg_one_pow
      rw [h1] at hs; rw [h2] at hs'
      have hm1 : (n + 1) % 2 = 1 := by obtain ⟨k, hk⟩ := he; omega
      have hm2 : (n + 1 + 1) % 2 = 0 := by obtain ⟨k, hk⟩ := he; omega
      rw [hm1, hm2]
      constructor <;> omega
    · -- n odd: n + 1 even, n + 2 odd
      have h1 : ((-1 : ℤ) ^ (n + 1)) = 1 := by
        rw [pow_succ, ho.neg_one_pow]; ring
      have h2 : ((-1 : ℤ) ^ (n + 2)) = -1 := by
        have : (n + 2) % 2 = 1 := by obtain ⟨k, hk⟩ := ho; omega
        exact (Nat.odd_iff.2 this).neg_one_pow
      rw [h1] at hs; rw [h2] at hs'
      have hm1 : (n + 1) % 2 = 0 := by obtain ⟨k, hk⟩ := ho; omega
      have hm2 : (n + 1 + 1) % 2 = 1 := by obtain ⟨k, hk⟩ := ho; omega
      rw [hm1, hm2]
      constructor <;> omega

/-- The Jacobsthal numbers to `J₁₅ = 10923`. -/
theorem jac_values : (List.range 16).map jac
    = [0, 1, 1, 3, 5, 11, 21, 43, 85, 171, 341, 683, 1365, 2731, 5461, 10923] := by decide

/-! ## Theorem D: the closed profile and the growth rate -/

/-- The top of a profile with per-step deficits `m`: `T(s+1) = 2T(s) − m(s)`. -/
def topRec (m : ℕ → ℤ) (T0 : ℤ) : ℕ → ℤ
  | 0 => T0
  | s + 1 => 2 * topRec m T0 s - m s

/-- The weight of one period of deficits: `M = Σ_{j<L} 2^{L−1−j} m_j`. -/
def periodWeight (m : ℕ → ℤ) (L : ℕ) : ℤ :=
  (Finset.range L).sum fun j => 2 ^ (L - 1 - j) * m j

/-- One period of the recursion: `T(s + L) = 2^L T(s) − Σ_{j<L} 2^{L−1−j} m(s + j)`. -/
theorem topRec_period (m : ℕ → ℤ) (T0 : ℤ) (s L : ℕ) :
    topRec m T0 (s + L) = 2 ^ L * topRec m T0 s
      - (Finset.range L).sum fun j => 2 ^ (L - 1 - j) * m (s + j) := by
  induction L with
  | zero => simp
  | succ L ih =>
    rw [show s + (L + 1) = (s + L) + 1 by omega, topRec, ih, Finset.sum_range_succ]
    have : ∀ j ∈ Finset.range L, (2 : ℤ) ^ (L + 1 - 1 - j) * m (s + j)
        = 2 * (2 ^ (L - 1 - j) * m (s + j)) := by
      intro j hj
      rw [Finset.mem_range] at hj
      rw [show L + 1 - 1 - j = (L - 1 - j) + 1 by omega, pow_succ]
      ring
    rw [Finset.sum_congr rfl this, ← Finset.mul_sum]
    simp only [Nat.add_sub_cancel, Nat.sub_self, pow_zero, one_mul]
    ring

/-- **Theorem D.** If the deficits are periodic with period `L` from step `s₀` on, then after
`n` periods `(2^L − 1)·T(s₀ + nL) = 2^{nL}·((2^L − 1)·T(s₀) − M) + M`: the whole future of the
top is a closed form in `n`, and `T(s)/2^s` converges to `(T(s₀) − M/(2^L − 1))/2^{s₀}`. -/
theorem theoremD (m : ℕ → ℤ) (T0 : ℤ) (s0 L : ℕ) (hper : ∀ s ≥ s0, m (s + L) = m s) (n : ℕ) :
    (2 ^ L - 1) * topRec m T0 (s0 + n * L)
      = 2 ^ (n * L) * ((2 ^ L - 1) * topRec m T0 s0 - periodWeight (fun j => m (s0 + j)) L)
        + periodWeight (fun j => m (s0 + j)) L := by
  have hshift : ∀ k j, m (s0 + k * L + j) = m (s0 + j) := by
    intro k j
    induction k with
    | zero => simp
    | succ k ihk =>
      rw [show s0 + (k + 1) * L + j = (s0 + k * L + j) + L by ring, hper _ (by omega), ihk]
  induction n with
  | zero => simp
  | succ n ih =>
    rw [show s0 + (n + 1) * L = (s0 + n * L) + L by ring, topRec_period]
    have hw : ((Finset.range L).sum fun j => 2 ^ (L - 1 - j) * m (s0 + n * L + j))
        = periodWeight (fun j => m (s0 + j)) L := by
      unfold periodWeight
      apply Finset.sum_congr rfl
      intro j _
      rw [hshift n j]
    rw [hw]
    have h2 : (2 : ℤ) ^ ((n + 1) * L) = 2 ^ (n * L) * 2 ^ L := by
      rw [← pow_add]; ring_nf
    rw [h2]
    linear_combination (2 : ℤ) ^ L * ih

/-! ## Theorem H: the step shift by homogeneity -/

/-- A max-plus quadratic map `Φ : (ι → ℤ) → (ι → ℤ)` is homogeneous of degree two: adding `γ`
to every coordinate adds `2γ` to every coordinate of the image. -/
def Hom2 {ι : Type*} (Φ : (ι → ℤ) → (ι → ℤ)) : Prop :=
  ∀ (t : ι → ℤ) (γ : ℤ), Φ (fun k => t k + γ) = fun k => Φ t k + 2 * γ

/-- **Theorem H.** Under a homogeneous map, the orbit of the flat profile `γ` is the orbit of the
flat profile `0` shifted by `2^s γ`; so with `γ = m = v_p(w)` the profile of the step `h = u/w`
is the profile of `h = 1` plus `(2^s − 1) m`. -/
theorem theoremH {ι : Type*} (Φ : (ι → ℤ) → (ι → ℤ)) (hΦ : Hom2 Φ) (γ : ℤ) (s : ℕ) :
    Φ^[s] (fun _ => γ) = fun k => Φ^[s] (fun _ => 0) k + 2 ^ s * γ := by
  induction s with
  | zero => funext k; simp
  | succ s ih =>
    rw [Function.iterate_succ_apply', ih, hΦ, Function.iterate_succ_apply']
    funext k
    ring

/-- The max-plus quadratic map of a finite support: `Φ(t)_k = max over the terms (a, b, ω)
feeding `k` of `t_a + t_b + ω`, taken over a nonempty list of terms` — it is homogeneous. -/
def maxPlus {ι : Type*} (terms : ι → List (ι × ι × ℤ)) (t : ι → ℤ) (k : ι) : ℤ :=
  (terms k).foldl (fun acc q => max acc (t q.1 + t q.2.1 + q.2.2)) (t k + t k)

theorem foldl_max_shift {ι : Type*} (t : ι → ℤ) (γ : ℤ) (l : List (ι × ι × ℤ)) (a : ℤ) :
    l.foldl (fun acc q => max acc ((t q.1 + γ) + (t q.2.1 + γ) + q.2.2)) (a + 2 * γ)
      = l.foldl (fun acc q => max acc (t q.1 + t q.2.1 + q.2.2)) a + 2 * γ := by
  induction l generalizing a with
  | nil => simp
  | cons q l ih =>
    simp only [List.foldl_cons]
    rw [← ih]
    congr 1
    rw [show (t q.1 + γ) + (t q.2.1 + γ) + q.2.2 = (t q.1 + t q.2.1 + q.2.2) + 2 * γ by ring]
    exact max_add_add_right a _ (2 * γ)

/-- The max-plus quadratic map is homogeneous of degree two (the seed of Theorem H). -/
theorem maxPlus_hom2 {ι : Type*} (terms : ι → List (ι × ι × ℤ)) : Hom2 (maxPlus terms) := by
  intro t γ
  funext k
  unfold maxPlus
  rw [show (t k + γ) + (t k + γ) = (t k + t k) + 2 * γ by ring]
  exact foldl_max_shift t γ (terms k) (t k + t k)

end Gephyrosis
