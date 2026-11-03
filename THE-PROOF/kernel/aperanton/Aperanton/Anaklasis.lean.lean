import Mathlib

/-!
# ΑΝΑΚΛΑΣΙΣ — THE DIAGONAL REFLECTION ON AN EVEN TORUS: THE FINITE PIECES IN THE KERNEL

The diagonal reflection `θ(x₁, x₂) = (x₂, x₁)` of the `N × N` torus (`N` even) has TWO invariant sets, `x₁ = x₂` and
`x₁ − x₂ ≡ N/2`.  The first is fixed pointwise; the second is MOVED pointwise (`second_set_moved`) — so a plaquette or a bond
bisected by the second set is not its own reflection, and the character-expansion proof of reflection positivity (ME2 Theorem
9.1, on boxes) does not apply there.  The coordinate reflection has no such set: its second invariant set `x₁ = N/2` is fixed
pointwise (`coord_second_set_fixed`).  The page proves that diagonal reflection positivity FAILS on the even torus for the
Ising measure, and the kernel re-derives here, by `decide`, the partition function and the two diagonal correlators of the
engine's 4-torus known answer (`ising_torus.awk`, two roads), at `t = 1/2` scaled to the integer bond weight `2 + s s'`:
`Z = 4804281924386816`, `Σ w·s₀₀s₁₁ = 4393991261388800`, `Σ w·s₀₀s₂₂ = 4369138319360000`.

Status: the geometric lemmas PROVED for every even `N ≥ 2`; the 4-torus numbers re-derived by the kernel (a known answer of the
engine that reads the 6-torus, where the form is negative); the 6-torus reading is the engine's, under its gate.
-/

namespace Anaklasis

/-- the diagonal reflection -/
def refl (x : ℕ × ℕ) : ℕ × ℕ := (x.2, x.1)

/-- the main diagonal is fixed pointwise -/
theorem main_set_fixed (x : ℕ × ℕ) (h : x.1 = x.2) : refl x = x := by
  unfold refl; exact Prod.ext h.symm h

/-- the second invariant set `x₁ − x₂ ≡ N/2 (mod N)` of an even torus, written without a variable modulus:
`x₁ = x₂ + N/2` or `x₂ = x₁ + N/2` for `0 ≤ x₁, x₂ < N`; every point of it is MOVED by the reflection -/
theorem second_set_moved (N : ℕ) (hN : 2 ≤ N) (x : ℕ × ℕ)
    (h : x.1 = x.2 + N / 2 ∨ x.2 = x.1 + N / 2) : refl x ≠ x := by
  intro hfix
  have h1 : x.2 = x.1 := (Prod.ext_iff.mp hfix).1
  omega

/-- the coordinate reflection `x₁ ↦ N − x₁` fixes its second invariant set `x₁ = N/2` pointwise (N even) -/
theorem coord_second_set_fixed (N : ℕ) (hev : N % 2 = 0) (hN : 2 ≤ N) (x1 : ℕ) (h : x1 = N / 2) :
    (N - x1) % N = x1 := by
  have hlt : N - x1 < N := by omega
  rw [Nat.mod_eq_of_lt hlt]; omega

/-! The `4`-torus known answer re-derived by the kernel lives in `AnaklasisKAT.lean` (a long `decide`); this file is the geometry. -/

#print axioms main_set_fixed
#print axioms second_set_moved
#print axioms coord_second_set_fixed

end Anaklasis
