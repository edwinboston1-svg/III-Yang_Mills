import Aperanton.GephyrosisOrbit
import Aperanton.GephyrosisTensor3D
import Mathlib.FieldTheory.Finite.Basic

/-!
# ΓΕΦΥΡΩΣΙΣ — THEOREM T, the one-digit automaton (Addendum IV §2), generically

Addendum IV reads the `p`-adic pole orders of the exact Galerkin–Euler orbit off a ONE-DIGIT
system: a profile `t ∈ ℤⁿ` (the pole-order bound of each coordinate) and a residue `r ∈ 𝔽_pⁿ`
(the leading digit), evolving by

    t′_k = max( t_k − v_p(λ_k),  max_{(a,b)} ( t_a + t_b + v_p(D_k) − v_p(T_{abk}) ) ),
    r′_k = Σ over the terms ATTAINING that maximum of  unit(coefficient) · r_a r_b   (mod p),

a max-plus recursion for `t` that never looks at `r`, and a homogeneous quadratic map for `r`.

**THEOREM T.** `−v_p(c_k(s)) ≤ t_k(s)` for every step and coordinate, with equality iff
`r_k(s) ≠ 0`, and then `r_k(s)` is the residue of `p^{t_k(s)} c_k(s)`.

The proof here is the page's: the invariant `p^{t_k} c_k ∈ ℤ_(p)` with residue `r_k`, carried by
`IRes` (a `p`-integral rational and its residue, as a numerator–denominator pair), through one
step — each term of `F(c)_k` times `p^{t′_k}` is `p^e · unit · (p^{t_a}c_a)(p^{t_b}c_b)` with `e ≥ 0`,
contributing its unit times the residues exactly when `e = 0` and a multiple of `p` otherwise.

The automaton is computable and the kernel decides its orbit: `GephyrosisEternal` reads the
all-steps laws (Theorem D's closure) and the exact break steps off it.

The step must be read on the SYMMETRISED tensor (the coefficient of the monomial `c_a c_b`, `a ≤ b`,
is `T_{abk} + T_{bak}`): the same-shell cancellation (Addendum IV's selection rule L-a) is exact
and invisible term by term. `quadSum_sym` proves the symmetrised step is the step.
-/

namespace Gephyrosis

open Finset

/-! ## The valuation and unit part of an integer, by trial division -/

/-- `vpAux p f n`: the exponent of `p` in `n`, by at most `f` divisions. -/
def vpAux (p : ℕ) : ℕ → ℤ → ℕ
  | 0, _ => 0
  | f + 1, n => if n ≠ 0 ∧ n % (p : ℤ) = 0 then vpAux p f (n / (p : ℤ)) + 1 else 0

/-- `v_p(n)` for `n ≠ 0` (and `0` at `n = 0`). -/
def vpI (p : ℕ) (n : ℤ) : ℕ := vpAux p n.natAbs n

/-- the unit part `n / p^{v_p(n)}` -/
def unitI (p : ℕ) (n : ℤ) : ℤ := n / (p : ℤ) ^ vpI p n

theorem vpAux_spec (p : ℕ) (hp : 2 ≤ p) : ∀ (f : ℕ) (n : ℤ), n ≠ 0 → n.natAbs < p ^ f →
    n = (p : ℤ) ^ vpAux p f n * (n / (p : ℤ) ^ vpAux p f n) ∧
      ¬ (p : ℤ) ∣ n / (p : ℤ) ^ vpAux p f n := by
  intro f
  induction f with
  | zero =>
    intro n hn hlt
    have h0 : n = 0 := by simpa using hlt
    exact (hn h0).elim
  | succ f ih =>
    intro n hn hlt
    have hp0 : (p : ℤ) ≠ 0 := by exact_mod_cast (show p ≠ 0 by omega)
    have hppos : (0 : ℤ) < p := by exact_mod_cast (show 0 < p by omega)
    simp only [vpAux]
    split_ifs with h
    · obtain ⟨-, hmod⟩ := h
      obtain ⟨m, hm⟩ := Int.dvd_of_emod_eq_zero hmod
      have hmdiv : n / (p : ℤ) = m := by rw [hm]; exact Int.mul_ediv_cancel_left m hp0
      rw [hmdiv]
      have hm0 : m ≠ 0 := by rintro rfl; simp at hm; exact hn hm
      have hmlt : m.natAbs < p ^ f := by
        have h1 : n.natAbs = p * m.natAbs := by rw [hm, Int.natAbs_mul, Int.natAbs_natCast]
        rw [h1, pow_succ'] at hlt
        exact Nat.lt_of_mul_lt_mul_left hlt
      obtain ⟨h1, h2⟩ := ih m hm0 hmlt
      have hdiv : n / (p : ℤ) ^ (vpAux p f m + 1) = m / (p : ℤ) ^ vpAux p f m := by
        rw [hm, pow_succ']
        exact Int.mul_ediv_mul_of_pos _ _ hppos
      rw [hdiv]
      refine ⟨?_, h2⟩
      rw [pow_succ']
      calc n = (p : ℤ) * m := hm
        _ = (p : ℤ) * ((p : ℤ) ^ vpAux p f m * (m / (p : ℤ) ^ vpAux p f m)) := by rw [← h1]
        _ = _ := by ring
    · simp only [pow_zero, Int.ediv_one, one_mul, true_and]
      intro hd
      exact h ⟨hn, Int.emod_eq_zero_of_dvd hd⟩

theorem vpI_spec (p : ℕ) (hp : 2 ≤ p) (n : ℤ) (hn : n ≠ 0) :
    n = (p : ℤ) ^ vpI p n * unitI p n ∧ ¬ (p : ℤ) ∣ unitI p n :=
  vpAux_spec p hp n.natAbs n hn (Nat.lt_pow_self (by omega))

theorem unitI_zero (p : ℕ) : unitI p 0 = 0 := by simp [unitI]

/-! ## Residue classes of `p`-integral rationals -/

/-- `x` is a `p`-integral rational with residue `r`: `x = N/M`, `p ∤ M`, `N ≡ r·M (mod p)`. -/
def IRes (p : ℕ) (x : ℚ) (r : ZMod p) : Prop :=
  ∃ N M : ℤ, ¬ ((p : ℤ) ∣ M) ∧ x = (N : ℚ) / (M : ℚ) ∧ ((N : ZMod p) = r * (M : ZMod p))

section IRes

variable {p : ℕ} [hp : Fact p.Prime]

theorem M_ne_of_not_dvd {M : ℤ} (h : ¬ ((p : ℤ) ∣ M)) : (M : ℚ) ≠ 0 := by
  intro h0
  apply h
  have : M = 0 := by exact_mod_cast h0
  rw [this]
  exact dvd_zero _

theorem not_dvd_one_int : ¬ ((p : ℤ) ∣ (1 : ℤ)) := by
  intro h
  have h1 : p ∣ 1 := by exact_mod_cast h
  exact hp.out.one_lt.ne' (Nat.dvd_one.mp h1)

theorem prime_dvd_mul_int {a b : ℤ} (h : (p : ℤ) ∣ a * b) : (p : ℤ) ∣ a ∨ (p : ℤ) ∣ b :=
  (Nat.prime_iff_prime_int.mp hp.out).dvd_mul.mp h

theorem IRes.ofInt (n : ℤ) : IRes p (n : ℚ) (n : ZMod p) :=
  ⟨n, 1, not_dvd_one_int, by simp, by simp⟩

theorem IRes.zero : IRes p 0 0 := by simpa using IRes.ofInt (p := p) 0

theorem IRes.add {x y : ℚ} {r s : ZMod p} (hx : IRes p x r) (hy : IRes p y s) :
    IRes p (x + y) (r + s) := by
  obtain ⟨N₁, M₁, hM₁, hx, hr⟩ := hx
  obtain ⟨N₂, M₂, hM₂, hy, hs⟩ := hy
  refine ⟨N₁ * M₂ + M₁ * N₂, M₁ * M₂, ?_, ?_, ?_⟩
  · intro h
    rcases prime_dvd_mul_int h with h | h
    · exact hM₁ h
    · exact hM₂ h
  · rw [hx, hy, div_add_div _ _ (M_ne_of_not_dvd hM₁) (M_ne_of_not_dvd hM₂)]
    push_cast
    ring
  · push_cast
    rw [hr, hs]
    ring

theorem IRes.mul {x y : ℚ} {r s : ZMod p} (hx : IRes p x r) (hy : IRes p y s) :
    IRes p (x * y) (r * s) := by
  obtain ⟨N₁, M₁, hM₁, hx, hr⟩ := hx
  obtain ⟨N₂, M₂, hM₂, hy, hs⟩ := hy
  refine ⟨N₁ * N₂, M₁ * M₂, ?_, ?_, ?_⟩
  · intro h
    rcases prime_dvd_mul_int h with h | h
    · exact hM₁ h
    · exact hM₂ h
  · rw [hx, hy, div_mul_div_comm]
    push_cast
    ring
  · push_cast
    rw [hr, hs]
    ring

theorem IRes.neg {x : ℚ} {r : ZMod p} (hx : IRes p x r) : IRes p (-x) (-r) := by
  obtain ⟨N, M, hM, hx, hr⟩ := hx
  refine ⟨-N, M, hM, ?_, ?_⟩
  · rw [hx]; push_cast; ring
  · push_cast; rw [hr]; ring

theorem IRes.pmul {x : ℚ} {r : ZMod p} (hx : IRes p x r) : IRes p ((p : ℚ) * x) 0 := by
  obtain ⟨N, M, hM, hx, hr⟩ := hx
  refine ⟨(p : ℤ) * N, M, hM, ?_, ?_⟩
  · rw [hx]; push_cast; ring
  · push_cast; simp

theorem IRes.ppow (e : ℕ) {x : ℚ} {r : ZMod p} (hx : IRes p x r) :
    IRes p ((p : ℚ) ^ e * x) (if e = 0 then r else 0) := by
  induction e with
  | zero => simpa using hx
  | succ e ih =>
    have h := IRes.pmul ih
    simp only [Nat.succ_ne_zero, if_false]
    rw [pow_succ', mul_assoc]
    exact h

theorem IRes.unitDiv {x : ℚ} {r : ZMod p} {D : ℤ} (hD : ¬ ((p : ℤ) ∣ D)) (hx : IRes p x r) :
    IRes p (x / (D : ℚ)) (r * ((D : ZMod p)⁻¹)) := by
  obtain ⟨N, M, hM, hx, hr⟩ := hx
  refine ⟨N, M * D, ?_, ?_, ?_⟩
  · intro h
    rcases prime_dvd_mul_int h with h | h
    · exact hM h
    · exact hD h
  · rw [hx, div_div]; push_cast; rfl
  · have hD' : (D : ZMod p) ≠ 0 := by
      rw [Ne, ZMod.intCast_zmod_eq_zero_iff_dvd]; exact hD
    push_cast
    rw [hr]
    field_simp

theorem IRes.list_sum {α : Type*} (l : List α) (f : α → ℚ) (g : α → ZMod p)
    (h : ∀ a ∈ l, IRes p (f a) (g a)) : IRes p (l.map f).sum (l.map g).sum := by
  induction l with
  | nil => simpa using IRes.zero (p := p)
  | cons a l ih =>
    simp only [List.map_cons, List.sum_cons]
    exact IRes.add (h a (List.mem_cons_self ..)) (ih fun b hb => h b (List.mem_cons_of_mem _ hb))

/-- A live residue reads the valuation exactly. -/
theorem IRes.val_eq_zero {x : ℚ} {r : ZMod p} (hx : IRes p x r) (hr : r ≠ 0) :
    x ≠ 0 ∧ padicValRat p x = 0 := by
  obtain ⟨N, M, hM, hx, hres⟩ := hx
  have hM' : (M : ZMod p) ≠ 0 := by rw [Ne, ZMod.intCast_zmod_eq_zero_iff_dvd]; exact hM
  have hN : ¬ ((p : ℤ) ∣ N) := by
    intro h
    have h0 : (N : ZMod p) = 0 := (ZMod.intCast_zmod_eq_zero_iff_dvd N p).mpr h
    rw [h0] at hres
    rcases mul_eq_zero.mp hres.symm with h | h
    · exact hr h
    · exact hM' h
  have hN0 : N ≠ 0 := by rintro rfl; exact hN (dvd_zero _)
  refine ⟨?_, ?_⟩
  · rw [hx]; exact div_ne_zero (by exact_mod_cast hN0) (M_ne_of_not_dvd hM)
  · rw [hx, padicValRat.div (p := p) (by exact_mod_cast hN0) (M_ne_of_not_dvd hM),
      padicValRat.of_int, padicValRat.of_int, padicValInt.eq_zero_of_not_dvd hN,
      padicValInt.eq_zero_of_not_dvd hM]
    simp

/-- A dead residue puts the valuation at least one higher. -/
theorem IRes.val_pos {x : ℚ} (hx : IRes p x 0) (h0 : x ≠ 0) : 1 ≤ padicValRat p x := by
  obtain ⟨N, M, hM, hx, hres⟩ := hx
  simp only [zero_mul] at hres
  have hN : (p : ℤ) ∣ N := (ZMod.intCast_zmod_eq_zero_iff_dvd N p).mp hres
  have hN0 : N ≠ 0 := by rintro rfl; simp at hx; exact h0 hx
  rw [hx, padicValRat.div (p := p) (by exact_mod_cast hN0) (M_ne_of_not_dvd hM),
    padicValRat.of_int, padicValRat.of_int, padicValInt.eq_zero_of_not_dvd hM, Nat.cast_zero,
    sub_zero]
  have h1 : 1 ≤ padicValInt p N := by
    have := (padicValInt_dvd_iff (p := p) 1 N).mp (by simpa using hN)
    rcases this with h | h
    · exact absurd h hN0
    · exact h
  exact_mod_cast h1

theorem padicValRat_zpow_mul {x : ℚ} {t : ℤ} (hx : x ≠ 0) :
    padicValRat p ((p : ℚ) ^ t * x) = t + padicValRat p x := by
  have hp0 : (p : ℚ) ≠ 0 := by exact_mod_cast hp.out.ne_zero
  rw [padicValRat.mul (zpow_ne_zero _ hp0) hx, padicValRat.zpow, padicValRat.self hp.out.one_lt]
  ring

/-- THE READING, live: `−v_p(x) = t` exactly. -/
theorem val_of_live {x : ℚ} {t : ℤ} {r : ZMod p} (h : IRes p ((p : ℚ) ^ t * x) r) (hr : r ≠ 0) :
    x ≠ 0 ∧ padicValRat p x = -t := by
  obtain ⟨hne, hv⟩ := IRes.val_eq_zero h hr
  have hp0 : (p : ℚ) ≠ 0 := by exact_mod_cast hp.out.ne_zero
  have hx : x ≠ 0 := by rintro rfl; simp at hne
  refine ⟨hx, ?_⟩
  rw [padicValRat_zpow_mul hx] at hv
  linarith

/-- THE READING, dead: `−v_p(x) < t`. -/
theorem val_of_dead {x : ℚ} {t : ℤ} (h : IRes p ((p : ℚ) ^ t * x) 0) (hx : x ≠ 0) :
    1 - t ≤ padicValRat p x := by
  have hp0 : (p : ℚ) ≠ 0 := by exact_mod_cast hp.out.ne_zero
  have := IRes.val_pos h (mul_ne_zero (zpow_ne_zero _ hp0) hx)
  rw [padicValRat_zpow_mul hx] at this
  linarith

/-- The residue of an integer reduced modulo `p`, as a natural number, cast back. -/
theorem natCast_toNat_emod (z : ℤ) : (((z % (p : ℤ)).toNat : ℕ) : ZMod p) = (z : ZMod p) := by
  have hp0 : (p : ℤ) ≠ 0 := by exact_mod_cast hp.out.ne_zero
  have h := Int.emod_nonneg z hp0
  have h1 : (((z % (p : ℤ)).toNat : ℤ)) = z % (p : ℤ) := Int.toNat_of_nonneg h
  have h2 : (((z % (p : ℤ)).toNat : ℕ) : ZMod p) = (((z % (p : ℤ)).toNat : ℤ) : ZMod p) := by
    push_cast; rfl
  rw [h2, h1, ZMod.intCast_mod]

theorem inv_eq_pow_sub_two (x : ZMod p) (hx : x ≠ 0) : x⁻¹ = x ^ (p - 2) := by
  have h := ZMod.pow_card_sub_one_eq_one hx
  have h2 : p - 2 + 1 = p - 1 := by have := hp.out.two_le; omega
  have h3 : x * x ^ (p - 2) = 1 := by rw [← pow_succ', h2]; exact h
  exact inv_eq_of_mul_eq_one_right h3

end IRes

/-! ## The term comprehension and its symmetrisation -/

/-- The nonzero terms of a coefficient function `g` into coordinate `c`, over `a, b < n`. -/
def termsOf (g : ℕ → ℕ → ℤ) (n c : ℕ) : List Term :=
  (List.range n).flatMap fun a => (List.range n).filterMap fun b =>
    if g a b = 0 then none else some ⟨a, b, c, g a b⟩

/-- The symmetrised coefficient of the monomial `x_a x_b` (`a ≤ b`): `g a b + g b a`. -/
def symCoef (g : ℕ → ℕ → ℤ) (a b : ℕ) : ℤ :=
  if a ≤ b then g a b + (if a < b then g b a else 0) else 0

theorem sum_map_range {M : Type*} [AddCommMonoid M] (h : ℕ → M) (n : ℕ) :
    ((List.range n).map h).sum = ∑ i ∈ range n, h i := by
  induction n with
  | zero => simp
  | succ n ih =>
    rw [List.range_succ, List.map_append, List.sum_append, Finset.sum_range_succ, ih]
    simp

theorem sum_map_filterMap {α β M : Type*} [AddCommMonoid M] (l : List α) (g : α → Option β)
    (h : β → M) : ((l.filterMap g).map h).sum = (l.map fun a => (g a).elim 0 h).sum := by
  induction l with
  | nil => simp
  | cons a l ih =>
    rw [List.filterMap_cons]
    cases hg : g a with
    | none => simp [hg, ih]
    | some b => simp [hg, ih]

theorem sum_map_flatMap {α β M : Type*} [AddCommMonoid M] (l : List α) (f : α → List β)
    (h : β → M) : ((l.flatMap f).map h).sum = (l.map fun a => ((f a).map h).sum).sum := by
  induction l with
  | nil => simp
  | cons a l ih => simp [List.flatMap_cons, List.map_append, List.sum_append, ih]

theorem quadSum_termsOf (g : ℕ → ℕ → ℤ) (n c : ℕ) (x : List ℚ) :
    quadSum (termsOf g n c) x
      = ∑ a ∈ range n, ∑ b ∈ range n, (g a b : ℚ) * x.getD a 0 * x.getD b 0 := by
  unfold quadSum termsOf
  rw [sum_map_flatMap, sum_map_range]
  refine Finset.sum_congr rfl fun a _ => ?_
  rw [sum_map_filterMap, sum_map_range]
  refine Finset.sum_congr rfl fun b _ => ?_
  split_ifs with h
  · simp [h]
  · simp

theorem sum_sym (g : ℕ → ℕ → ℤ) (n : ℕ) (x : ℕ → ℚ) :
    ∑ a ∈ range n, ∑ b ∈ range n, (symCoef g a b : ℚ) * x a * x b
      = ∑ a ∈ range n, ∑ b ∈ range n, (g a b : ℚ) * x a * x b := by
  have h1 : ∀ a b, (symCoef g a b : ℚ) * x a * x b
      = (if a ≤ b then (g a b : ℚ) * x a * x b else 0)
        + (if a < b then (g b a : ℚ) * x a * x b else 0) := by
    intro a b
    unfold symCoef
    split_ifs <;> push_cast <;> first | (exfalso; omega) | ring
  simp_rw [h1, Finset.sum_add_distrib]
  have h2 : ∑ a ∈ range n, ∑ b ∈ range n, (if a < b then (g b a : ℚ) * x a * x b else 0)
      = ∑ a ∈ range n, ∑ b ∈ range n, (if b < a then (g a b : ℚ) * x a * x b else 0) := by
    rw [Finset.sum_comm]
    refine Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => ?_
    split_ifs <;> ring
  rw [h2, ← Finset.sum_add_distrib]
  refine Finset.sum_congr rfl fun a _ => ?_
  rw [← Finset.sum_add_distrib]
  refine Finset.sum_congr rfl fun b _ => ?_
  split_ifs <;> first | (exfalso; omega) | ring

/-- THE SYMMETRISED STEP IS THE STEP. -/
theorem quadSum_sym (g : ℕ → ℕ → ℤ) (n c : ℕ) (x : List ℚ) :
    quadSum (termsOf (symCoef g) n c) x = quadSum (termsOf g n c) x := by
  rw [quadSum_termsOf, quadSum_termsOf]
  exact sum_sym g n (fun a => x.getD a 0)

theorem getD_map_range {α : Type*} (f : ℕ → α) (n k : ℕ) (d : α) :
    ((List.range n).map f).getD k d = if k < n then f k else d := by
  rw [List.getD_eq_getElem?_getD, List.getElem?_map]
  split_ifs with hk
  · rw [List.getElem?_range hk]; rfl
  · rw [List.getElem?_eq_none (by simpa using hk)]; rfl

/-- The 2D tensor as a coefficient function into coordinate `c`. -/
def g2 (B : List Basis2) (c a b : ℕ) : ℤ :=
  tx (B.getD a default) (B.getD b default) (B.getD c default)

theorem termsFor_eq (B : List Basis2) (c : ℕ) : termsFor B c = termsOf (g2 B c) B.length c := rfl

/-- The 2D box as a road with the SYMMETRISED tensor. -/
def road2Dsym (K : ℕ) : Road :=
  let B := basis2D K
  ⟨B.length, fun k => kappa (B.getD k default), fun k => divisor (B.getD k default),
    (List.range B.length).map fun c => termsOf (symCoef (g2 B c)) B.length c⟩

theorem stepI_road2Dsym (K : ℕ) (x : List ℚ) : stepI (road2Dsym K) x = stepI (road2D K) x := by
  unfold stepI
  apply List.map_congr_left
  intro k hk
  rw [List.mem_range] at hk
  have hk' : k < (basis2D K).length := hk
  have h1 : (road2Dsym K).tb.getD k [] = termsOf (symCoef (g2 (basis2D K) k)) (basis2D K).length k := by
    show ((List.range (basis2D K).length).map _).getD k [] = _
    rw [getD_map_range, if_pos hk']
  have h2 : (road2D K).tb.getD k [] = termsOf (g2 (basis2D K) k) (basis2D K).length k := by
    show ((List.range (basis2D K).length).map _).getD k [] = _
    rw [getD_map_range, if_pos hk', termsFor_eq]
  show (1 - ((road2Dsym K).κ k : ℚ)) * x.getD k 0 - quadSum ((road2Dsym K).tb.getD k []) x / ((road2Dsym K).D k : ℚ)
    = (1 - ((road2D K).κ k : ℚ)) * x.getD k 0 - quadSum ((road2D K).tb.getD k []) x / ((road2D K).D k : ℚ)
  rw [h1, h2, quadSum_sym]
  rfl

/-- The 3D tensor as a coefficient function. -/
def g3 (B : List Basis3) (c a b : ℕ) : ℤ :=
  tx3 (B.getD a default) (B.getD b default) (B.getD c default)

theorem termsFor3_eq (B : List Basis3) (c : ℕ) : termsFor3 B c = termsOf (g3 B c) B.length c := rfl

/-- The road of a 3D box with the ordered tensor (the structure `road3D` of
`GephyrosisCertificate3D` builds). -/
def road3Dord (K : ℕ) : Road :=
  let B := basis3D K
  ⟨B.length, fun k => kappa3 (B.getD k default), fun k => divisor3 (B.getD k default),
    termsByCoord3 B⟩

def road3Dsym (K : ℕ) : Road :=
  let B := basis3D K
  ⟨B.length, fun k => kappa3 (B.getD k default), fun k => divisor3 (B.getD k default),
    (List.range B.length).map fun c => termsOf (symCoef (g3 B c)) B.length c⟩

theorem stepI_road3Dsym (K : ℕ) (x : List ℚ) :
    stepI (road3Dsym K) x = stepI (road3Dord K) x := by
  unfold stepI
  apply List.map_congr_left
  intro k hk
  rw [List.mem_range] at hk
  have hk' : k < (basis3D K).length := hk
  have h1 : (road3Dsym K).tb.getD k [] = termsOf (symCoef (g3 (basis3D K) k)) (basis3D K).length k := by
    show ((List.range (basis3D K).length).map _).getD k [] = _
    rw [getD_map_range, if_pos hk']
  have h2 : (road3Dord K).tb.getD k [] = termsOf (g3 (basis3D K) k) (basis3D K).length k := by
    show ((List.range (basis3D K).length).map _).getD k [] = _
    rw [getD_map_range, if_pos hk', termsFor3_eq]
  show (1 - ((road3Dsym K).κ k : ℚ)) * x.getD k 0 - quadSum ((road3Dsym K).tb.getD k []) x / ((road3Dsym K).D k : ℚ)
    = (1 - ((road3Dord K).κ k : ℚ)) * x.getD k 0 - quadSum ((road3Dord K).tb.getD k []) x / ((road3Dord K).D k : ℚ)
  rw [h1, h2, quadSum_sym]
  rfl

/-! ## The automaton -/

/-- `p`-adic scale of the term `tm` into a coordinate with divisor `D`:
`t_a + t_b + v_p(D) − v_p(T)`. -/
def qscale (p : ℕ) (t : List ℤ) (D : ℤ) (tm : Term) : ℤ :=
  t.getD tm.a 0 + t.getD tm.b 0 + (vpI p D : ℤ) - (vpI p tm.T : ℤ)

/-- scale of the linear term `λ_k c_k`: `t_k − v_p(λ_k)` -/
def lscale (p : ℕ) (t : List ℤ) (lam : ℤ) (k : ℕ) : ℤ := t.getD k 0 - (vpI p lam : ℤ)

def maxL : List ℤ → ℤ
  | [] => 0
  | a :: l => l.foldl max a

theorem init_le_foldl_max (l : List ℤ) (b : ℤ) : b ≤ l.foldl max b := by
  induction l generalizing b with
  | nil => simp
  | cons a l ih => exact le_trans (le_max_left b a) (ih (max b a))

theorem le_foldl_max {a : ℤ} {l : List ℤ} (h : a ∈ l) (b : ℤ) : a ≤ l.foldl max b := by
  induction l generalizing b with
  | nil => simp at h
  | cons c l ih =>
    rcases List.mem_cons.mp h with rfl | h
    · exact le_trans (le_max_right b a) (init_le_foldl_max l _)
    · exact ih h _

theorem le_maxL {a : ℤ} {l : List ℤ} (h : a ∈ l) : a ≤ maxL l := by
  cases l with
  | nil => simp at h
  | cons c l =>
    rcases List.mem_cons.mp h with rfl | h
    · exact init_le_foldl_max l a
    · exact le_foldl_max h c

def lamOf (R : Road) (k : ℕ) : ℤ := 1 - R.κ k

def qmax (R : Road) (p : ℕ) (t : List ℤ) (k : ℕ) : ℤ :=
  maxL ((R.tb.getD k []).map (qscale p t (R.D k)))

/-- the profile step `t′_k` -/
def tNext (R : Road) (p : ℕ) (t : List ℤ) (k : ℕ) : ℤ :=
  if lamOf R k = 0 then qmax R p t k else max (lscale p t (lamOf R k) k) (qmax R p t k)

theorem qscale_le_tNext (R : Road) (p : ℕ) (t : List ℤ) (k : ℕ) {tm : Term}
    (h : tm ∈ R.tb.getD k []) : qscale p t (R.D k) tm ≤ tNext R p t k := by
  have h1 : qscale p t (R.D k) tm ≤ qmax R p t k := le_maxL (List.mem_map_of_mem h)
  unfold tNext
  split_ifs
  · exact h1
  · exact le_trans h1 (le_max_right _ _)

theorem lscale_le_tNext (R : Road) (p : ℕ) (t : List ℤ) (k : ℕ) (h : lamOf R k ≠ 0) :
    lscale p t (lamOf R k) k ≤ tNext R p t k := by
  unfold tNext
  rw [if_neg h]
  exact le_max_left _ _

/-- the unit of `N / D` modulo `p`, as a natural number below `p` -/
def unitOf (p : ℕ) (N D : ℤ) : ℕ :=
  ((unitI p N % (p : ℤ)).toNat * (unitI p D % (p : ℤ)).toNat ^ (p - 2)) % p

def unitL (p : ℕ) (lam : ℤ) : ℕ := (unitI p lam % (p : ℤ)).toNat

/-- the quadratic part of the residue step: the attaining terms' units times the residues -/
def quadRes (R : Road) (p : ℕ) (t : List ℤ) (r : List ℕ) (k : ℕ) : ℕ :=
  ((R.tb.getD k []).map fun tm =>
    if qscale p t (R.D k) tm = tNext R p t k then
      unitOf p tm.T (R.D k) * r.getD tm.a 0 * r.getD tm.b 0 else 0).sum

/-- the linear part of the residue step -/
def linRes (R : Road) (p : ℕ) (t : List ℤ) (r : List ℕ) (k : ℕ) : ℕ :=
  if lamOf R k ≠ 0 ∧ lscale p t (lamOf R k) k = tNext R p t k then
    unitL p (lamOf R k) * r.getD k 0 else 0

/-- the residue step `r′_k` (the quadratic part enters with the sign of `−Q_k/D_k`) -/
def rNext (R : Road) (p : ℕ) (t : List ℤ) (r : List ℕ) (k : ℕ) : ℕ :=
  (linRes R p t r k + (p - 1) * quadRes R p t r k) % p

def autoStep (R : Road) (p : ℕ) (st : List ℤ × List ℕ) : List ℤ × List ℕ :=
  ((List.range R.n).map (tNext R p st.1), (List.range R.n).map (rNext R p st.1 st.2))

def autoInit (R : Road) (p : ℕ) (c0 : List ℤ) : List ℤ × List ℕ :=
  ((List.range R.n).map fun _ => (0 : ℤ),
    (List.range R.n).map fun k => (c0.getD k 0 % (p : ℤ)).toNat)

def autoOrbit (R : Road) (p : ℕ) (c0 : List ℤ) : ℕ → List ℤ × List ℕ
  | 0 => autoInit R p c0
  | s + 1 => autoStep R p (autoOrbit R p c0 s)

/-- The exact rational orbit of an integer seed, from the step of the road. -/
def ratOrbit (R : Road) (c0 : List ℤ) : ℕ → List ℚ
  | 0 => (List.range R.n).map fun k => ((c0.getD k 0 : ℤ) : ℚ)
  | s + 1 => stepI R (ratOrbit R c0 s)

/-! ## Theorem T, one step -/

section TheoremT

variable {p : ℕ} [hp : Fact p.Prime]

theorem unitOf_cast {T D : ℤ} (hD : ¬ ((p : ℤ) ∣ unitI p D)) :
    ((unitOf p T D : ℕ) : ZMod p) = (unitI p T : ZMod p) * (unitI p D : ZMod p)⁻¹ := by
  unfold unitOf
  rw [ZMod.natCast_mod, Nat.cast_mul, Nat.cast_pow, natCast_toNat_emod, natCast_toNat_emod]
  have hD' : (unitI p D : ZMod p) ≠ 0 := by
    rw [Ne, ZMod.intCast_zmod_eq_zero_iff_dvd]; exact hD
  rw [inv_eq_pow_sub_two _ hD']

theorem unitL_cast (lam : ℤ) : ((unitL p lam : ℕ) : ZMod p) = (unitI p lam : ZMod p) := by
  unfold unitL
  exact natCast_toNat_emod _

theorem unitOf_zero_left (D : ℤ) : unitOf p 0 D = 0 := by
  simp [unitOf, unitI_zero]

/-- One quadratic term, times `p^{t′}`: `p`-integral, with the unit's residue exactly when the
term attains the scale `t′`. -/
theorem term_IRes {tk ta tb : ℤ} {xa xb : ℚ} {ra rb : ZMod p} (T D : ℤ) (hD : D ≠ 0)
    (hle : ta + tb + (vpI p D : ℤ) - (vpI p T : ℤ) ≤ tk)
    (ha : IRes p ((p : ℚ) ^ ta * xa) ra) (hb : IRes p ((p : ℚ) ^ tb * xb) rb) :
    IRes p ((p : ℚ) ^ tk * ((T : ℚ) * xa * xb) / (D : ℚ))
      (if ta + tb + (vpI p D : ℤ) - (vpI p T : ℤ) = tk then
        ((unitOf p T D : ℕ) : ZMod p) * ra * rb else 0) := by
  have hp2 : 2 ≤ p := hp.out.two_le
  have hp0 : (p : ℚ) ≠ 0 := by exact_mod_cast hp.out.ne_zero
  by_cases hT : T = 0
  · subst hT
    have h0 : (p : ℚ) ^ tk * (((0 : ℤ) : ℚ) * xa * xb) / (D : ℚ) = 0 := by simp
    rw [h0, unitOf_zero_left]
    simp only [Nat.cast_zero, zero_mul, ite_self]
    exact IRes.zero
  obtain ⟨hTd, hT'⟩ := vpI_spec p hp2 T hT
  obtain ⟨hDd, hD'⟩ := vpI_spec p hp2 D hD
  set vT := vpI p T with hvT
  set vD := vpI p D with hvD
  set T' := unitI p T with hT'def
  set D' := unitI p D with hD'def
  set e : ℕ := (tk - (ta + tb + (vD : ℤ) - (vT : ℤ))).toNat with he_def
  have he : (e : ℤ) = tk - (ta + tb + (vD : ℤ) - (vT : ℤ)) := Int.toNat_of_nonneg (by omega)
  have hD'q : (D' : ℚ) ≠ 0 := M_ne_of_not_dvd hD'
  have hTq : ((T : ℤ) : ℚ) = (p : ℚ) ^ vT * (T' : ℚ) := by
    rw [hTd]; push_cast; ring
  have hDq : ((D : ℤ) : ℚ) = (p : ℚ) ^ vD * (D' : ℚ) := by
    rw [hDd]; push_cast; ring
  have htk : tk = (e : ℤ) + ta + tb + (vD : ℤ) - (vT : ℤ) := by omega
  have key : (p : ℚ) ^ tk * ((T : ℚ) * xa * xb) / (D : ℚ)
      = (p : ℚ) ^ e * ((T' : ℚ) * (((p : ℚ) ^ ta * xa) * ((p : ℚ) ^ tb * xb))) / (D' : ℚ) := by
    rw [htk, hTq, hDq, zpow_sub₀ hp0, zpow_add₀ hp0, zpow_add₀ hp0, zpow_add₀ hp0]
    simp only [zpow_natCast]
    field_simp
  rw [key]
  have h1 := IRes.unitDiv hD' (IRes.ppow e (IRes.mul (IRes.ofInt T') (IRes.mul ha hb)))
  have hres : (if ta + tb + (vD : ℤ) - (vT : ℤ) = tk then
        ((unitOf p T D : ℕ) : ZMod p) * ra * rb else 0)
      = (if e = 0 then (T' : ZMod p) * (ra * rb) else 0) * (D' : ZMod p)⁻¹ := by
    rw [unitOf_cast hD', ← hT'def, ← hD'def]
    by_cases hatt : ta + tb + (vD : ℤ) - (vT : ℤ) = tk
    · have he0 : e = 0 := by omega
      rw [if_pos hatt, if_pos he0]
      ring
    · have he0 : e ≠ 0 := by omega
      rw [if_neg hatt, if_neg he0]
      ring
  rw [hres]
  exact h1

/-- The linear term, times `p^{t′}`. -/
theorem lin_IRes {tk t_k : ℤ} {xk : ℚ} {rk : ZMod p} (lam : ℤ)
    (hle : lam ≠ 0 → t_k - (vpI p lam : ℤ) ≤ tk)
    (hk : IRes p ((p : ℚ) ^ t_k * xk) rk) :
    IRes p ((p : ℚ) ^ tk * ((lam : ℚ) * xk))
      (if lam ≠ 0 ∧ t_k - (vpI p lam : ℤ) = tk then ((unitL p lam : ℕ) : ZMod p) * rk else 0) := by
  have hp2 : 2 ≤ p := hp.out.two_le
  have hp0 : (p : ℚ) ≠ 0 := by exact_mod_cast hp.out.ne_zero
  by_cases hl : lam = 0
  · subst hl
    simp only [ne_eq, not_true_eq_false, false_and, if_false, Int.cast_zero, zero_mul, mul_zero]
    exact IRes.zero
  obtain ⟨hld, hl'⟩ := vpI_spec p hp2 lam hl
  set v := vpI p lam with hv
  set lam' := unitI p lam with hl'def
  set e : ℕ := (tk - (t_k - (v : ℤ))).toNat with he_def
  have he : (e : ℤ) = tk - (t_k - (v : ℤ)) := Int.toNat_of_nonneg (by have := hle hl; omega)
  have hlq : ((lam : ℤ) : ℚ) = (p : ℚ) ^ v * (lam' : ℚ) := by rw [hld]; push_cast; ring
  have htk : tk = (e : ℤ) + t_k - (v : ℤ) := by omega
  have key : (p : ℚ) ^ tk * ((lam : ℚ) * xk) = (p : ℚ) ^ e * ((lam' : ℚ) * ((p : ℚ) ^ t_k * xk)) := by
    rw [htk, hlq, zpow_sub₀ hp0, zpow_add₀ hp0]
    simp only [zpow_natCast]
    field_simp
  rw [key]
  have h1 := IRes.ppow e (IRes.mul (IRes.ofInt lam') hk)
  have hres : (if lam ≠ 0 ∧ t_k - (v : ℤ) = tk then ((unitL p lam : ℕ) : ZMod p) * rk else 0)
      = (if e = 0 then (lam' : ZMod p) * rk else 0) := by
    rw [unitL_cast, ← hl'def]
    by_cases hatt : t_k - (v : ℤ) = tk
    · have he0 : e = 0 := by omega
      rw [if_pos ⟨hl, hatt⟩, if_pos he0]
    · have he0 : e ≠ 0 := by omega
      rw [if_neg (fun h => hatt h.2), if_neg he0]
  rw [hres]
  exact h1

theorem rNext_cast (R : Road) (t : List ℤ) (r : List ℕ) (k : ℕ) :
    ((rNext R p t r k : ℕ) : ZMod p)
      = ((linRes R p t r k : ℕ) : ZMod p) - ((quadRes R p t r k : ℕ) : ZMod p) := by
  unfold rNext
  rw [ZMod.natCast_mod, Nat.cast_add, Nat.cast_mul, Nat.cast_sub hp.out.one_le,
    ZMod.natCast_self]
  ring

theorem getD_stepI (R : Road) (c : List ℚ) (k : ℕ) (hk : k < R.n) :
    (stepI R c).getD k 0
      = (1 - (R.κ k : ℚ)) * c.getD k 0 - quadSum (R.tb.getD k []) c / (R.D k : ℚ) := by
  unfold stepI
  rw [getD_map_range, if_pos hk]

theorem getD_stepI_ge (R : Road) (c : List ℚ) (k : ℕ) (hk : ¬ k < R.n) :
    (stepI R c).getD k 0 = 0 := by
  unfold stepI
  rw [getD_map_range, if_neg hk]

theorem sum_map_mul_div (l : List Term) (f : Term → ℚ) (A D : ℚ) :
    A * ((l.map f).sum / D) = (l.map fun tm => A * f tm / D).sum := by
  induction l with
  | nil => simp
  | cons a l ih =>
    simp only [List.map_cons, List.sum_cons]
    rw [add_div, mul_add, ih, mul_div_assoc]

/-- THEOREM T, ONE STEP. -/
theorem theoremT_step (R : Road) (hD : ∀ k < R.n, R.D k ≠ 0)
    (t : List ℤ) (r : List ℕ) (c : List ℚ)
    (hinv : ∀ k, IRes p ((p : ℚ) ^ (t.getD k 0) * c.getD k 0) ((r.getD k 0 : ℕ) : ZMod p)) :
    ∀ k, IRes p ((p : ℚ) ^ ((autoStep R p (t, r)).1.getD k 0) * (stepI R c).getD k 0)
      (((autoStep R p (t, r)).2.getD k 0 : ℕ) : ZMod p) := by
  intro k
  by_cases hk : k < R.n
  · have ht' : (autoStep R p (t, r)).1.getD k 0 = tNext R p t k := by
      show ((List.range R.n).map _).getD k 0 = _
      rw [getD_map_range, if_pos hk]
    have hr' : (autoStep R p (t, r)).2.getD k 0 = rNext R p t r k := by
      show ((List.range R.n).map _).getD k 0 = _
      rw [getD_map_range, if_pos hk]
    rw [ht', hr', getD_stepI R c k hk, rNext_cast]
    set tk := tNext R p t k with htk
    set ts := R.tb.getD k [] with hts
    have hlin : IRes p ((p : ℚ) ^ tk * ((1 - (R.κ k : ℚ)) * c.getD k 0))
        ((linRes R p t r k : ℕ) : ZMod p) := by
      have h := lin_IRes (p := p) (tk := tk) (lamOf R k)
        (fun hl => lscale_le_tNext R p t k hl) (hinv k)
      unfold linRes
      unfold lamOf at h
      unfold lscale
      have hc : ((1 - R.κ k : ℤ) : ℚ) = 1 - (R.κ k : ℚ) := by push_cast; ring
      rw [hc] at h
      unfold lamOf
      convert h using 2
      split_ifs <;> simp
    have hquad : IRes p ((p : ℚ) ^ tk * (quadSum ts c / (R.D k : ℚ)))
        ((quadRes R p t r k : ℕ) : ZMod p) := by
      unfold quadSum
      rw [sum_map_mul_div]
      unfold quadRes
      rw [Nat.cast_list_sum, List.map_map]
      apply IRes.list_sum
      intro tm hm
      have h := term_IRes (p := p) (tk := tk) tm.T (R.D k) (hD k hk)
        (qscale_le_tNext R p t k hm) (hinv tm.a) (hinv tm.b)
      simp only [Function.comp]
      unfold qscale at h ⊢
      convert h using 2
      split_ifs <;> push_cast <;> ring
    have hres : ((linRes R p t r k : ℕ) : ZMod p) - ((quadRes R p t r k : ℕ) : ZMod p)
        = ((linRes R p t r k : ℕ) : ZMod p) + -((quadRes R p t r k : ℕ) : ZMod p) :=
      sub_eq_add_neg _ _
    have hval : (p : ℚ) ^ tk * ((1 - (R.κ k : ℚ)) * c.getD k 0 - quadSum ts c / (R.D k : ℚ))
        = (p : ℚ) ^ tk * ((1 - (R.κ k : ℚ)) * c.getD k 0)
          + -((p : ℚ) ^ tk * (quadSum ts c / (R.D k : ℚ))) := by ring
    rw [hval, hres]
    exact IRes.add hlin (IRes.neg hquad)
  · have ht' : (autoStep R p (t, r)).1.getD k 0 = 0 := by
      show ((List.range R.n).map _).getD k 0 = _
      rw [getD_map_range, if_neg hk]
    have hr' : (autoStep R p (t, r)).2.getD k 0 = 0 := by
      show ((List.range R.n).map _).getD k 0 = _
      rw [getD_map_range, if_neg hk]
    rw [ht', hr', getD_stepI_ge R c k hk]
    simpa using IRes.zero (p := p)

/-- THEOREM T. Along the whole orbit, `p^{t_k(s)} c_k(s)` is `p`-integral with residue `r_k(s)`. -/
theorem theoremT (R : Road) (hD : ∀ k < R.n, R.D k ≠ 0) (c0 : List ℤ) :
    ∀ s k, IRes p ((p : ℚ) ^ ((autoOrbit R p c0 s).1.getD k 0) * (ratOrbit R c0 s).getD k 0)
      (((autoOrbit R p c0 s).2.getD k 0 : ℕ) : ZMod p) := by
  intro s
  induction s with
  | zero =>
    intro k
    by_cases hk : k < R.n
    · have ht : (autoOrbit R p c0 0).1.getD k 0 = 0 := by
        show ((List.range R.n).map _).getD k 0 = _
        rw [getD_map_range, if_pos hk]
      have hr : (autoOrbit R p c0 0).2.getD k 0 = (c0.getD k 0 % (p : ℤ)).toNat := by
        show ((List.range R.n).map _).getD k 0 = _
        rw [getD_map_range, if_pos hk]
      have hc : (ratOrbit R c0 0).getD k 0 = ((c0.getD k 0 : ℤ) : ℚ) := by
        show ((List.range R.n).map _).getD k 0 = _
        rw [getD_map_range, if_pos hk]
      rw [ht, hr, hc, natCast_toNat_emod, zpow_zero, one_mul]
      exact IRes.ofInt _
    · have ht : (autoOrbit R p c0 0).1.getD k 0 = 0 := by
        show ((List.range R.n).map _).getD k 0 = _
        rw [getD_map_range, if_neg hk]
      have hr : (autoOrbit R p c0 0).2.getD k 0 = 0 := by
        show ((List.range R.n).map _).getD k 0 = _
        rw [getD_map_range, if_neg hk]
      have hc : (ratOrbit R c0 0).getD k 0 = 0 := by
        show ((List.range R.n).map _).getD k 0 = _
        rw [getD_map_range, if_neg hk]
      rw [ht, hr, hc]
      simpa using IRes.zero (p := p)
  | succ s ih =>
    have := theoremT_step (p := p) R hD (autoOrbit R p c0 s).1 (autoOrbit R p c0 s).2
      (ratOrbit R c0 s) ih
    exact this

/-! ## The readings -/

/-- A live coordinate's pole order is exactly `t_k(s)`. -/
theorem pole_of_live (R : Road) (hD : ∀ k < R.n, R.D k ≠ 0) (c0 : List ℤ) (s k : ℕ)
    (hlive : (autoOrbit R p c0 s).2.getD k 0 ≠ 0)
    (hlt : (autoOrbit R p c0 s).2.getD k 0 < p) :
    (ratOrbit R c0 s).getD k 0 ≠ 0 ∧
      padicValRat p ((ratOrbit R c0 s).getD k 0) = -((autoOrbit R p c0 s).1.getD k 0) := by
  have h := theoremT (p := p) R hD c0 s k
  apply val_of_live h
  intro h0
  have hd : p ∣ (autoOrbit R p c0 s).2.getD k 0 := (ZMod.natCast_eq_zero_iff _ _).mp h0
  exact hlive (Nat.eq_zero_of_dvd_of_lt hd hlt)

/-- A dead coordinate's pole order is strictly below `t_k(s)` (or the coordinate is zero). -/
theorem pole_of_dead (R : Road) (hD : ∀ k < R.n, R.D k ≠ 0) (c0 : List ℤ) (s k : ℕ)
    (hdead : (autoOrbit R p c0 s).2.getD k 0 = 0) :
    (ratOrbit R c0 s).getD k 0 = 0 ∨
      1 - (autoOrbit R p c0 s).1.getD k 0 ≤ padicValRat p ((ratOrbit R c0 s).getD k 0) := by
  have h := theoremT (p := p) R hD c0 s k
  rw [hdead] at h
  simp only [Nat.cast_zero] at h
  by_cases hc : (ratOrbit R c0 s).getD k 0 = 0
  · exact Or.inl hc
  · exact Or.inr (val_of_dead h hc)

end TheoremT

end Gephyrosis
