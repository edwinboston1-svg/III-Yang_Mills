/-
  APERANTON -- THE BOUNDLESS, stage W7 = Ω2 THE PLANE, THE FIRST NONABELIAN INSTANCE: TWO-DIMENSIONAL YANG–MILLS
  FOR Q₈ IN THE KERNEL -- the character data of the quaternion group DECIDED, Migdal's formula read off.

  THE DATA.  Q₈ = ⟨a, x | a⁴ = 1, x² = a², xax⁻¹ = a⁻¹⟩ (Mathlib's `QuaternionGroup 2`: elements `a i`, `xa i`,
  i ∈ ℤ/4) has five irreducible characters: the trivial one, the three signs (trivial on ⟨a⟩, on ⟨a², x⟩, on
  ⟨a², xa⟩ respectively) and the two-dimensional one (2 at 1, −2 at a², 0 elsewhere) -- ΠΙΝΑΞ's table, written as
  integers.  Degrees 1, 1, 1, 1, 2; multiplicities 8, 8, 8, 8, 4.  EVERY FIELD OF `CharData` IS DECIDED by the kernel
  over the group: the class property (320 instances), χ(1) = d, the convolution identity (200 sums of eight) and the
  handle identity (320 sums of eight).  THEN YM2.lean's theorems are Q₈'s: the self-reproduction, the transfer
  operator diagonal with eigenvalue 8·x_r^t, and Migdal's formula Σ_r d_r² m_r^{2g} x_r^t -- at zero area the sphere
  reads 8 (Frobenius, ΑΘΙΚΤΟΝ) and the torus 320 = 8² · 5 (Mednykh, ΕΛΙΓΜΟΣ T-155), decided.  The Casimir weights
  x_r are ΚΑΜΨΙΣ T-475's (the Cayley Laplacian is the Casimir); the formula holds for every x.
  No sorry, no axiom, no native_decide.
-/
import Mathlib
import Aperanton.YM2

open QuaternionGroup

namespace Aperanton

namespace Q8

/-- the five irreducible characters of Q₈ as integers -/
def chi : Fin 5 → QuaternionGroup 2 → ℤ
  | ⟨0, _⟩, _ => 1
  | ⟨1, _⟩, a _ => 1
  | ⟨1, _⟩, xa _ => -1
  | ⟨2, _⟩, a i => if i.val % 2 = 0 then 1 else -1
  | ⟨2, _⟩, xa i => if i.val % 2 = 0 then 1 else -1
  | ⟨3, _⟩, a i => if i.val % 2 = 0 then 1 else -1
  | ⟨3, _⟩, xa i => if i.val % 2 = 0 then -1 else 1
  | ⟨4, _⟩, a i => if i.val = 0 then 2 else if i.val = 2 then -2 else 0
  | ⟨4, _⟩, xa _ => 0

/-- the degrees -/
def deg : Fin 5 → ℕ := ![1, 1, 1, 1, 2]

/-- the multiplicities |G|/d -/
def mult : Fin 5 → ℕ := ![8, 8, 8, 8, 4]

theorem mult_mul_deg : ∀ r, mult r * deg r = Fintype.card (QuaternionGroup 2) := by decide

theorem chi_class : ∀ r (g h : QuaternionGroup 2), chi r (g * h * g⁻¹) = chi r h := by decide

theorem chi_one : ∀ r, chi r 1 = (deg r : ℤ) := by decide

theorem conv_char : ∀ r s (x : QuaternionGroup 2),
    ∑ y, chi r y * chi s (y⁻¹ * x) = if r = s then (mult r : ℤ) * chi r x else 0 := by decide

theorem handle : ∀ r (x y : QuaternionGroup 2),
    ∑ a, chi r (x * (a * y * a⁻¹)) = (mult r : ℤ) * chi r x * chi r y := by decide

/-- THE CHARACTER DATA OF Q₈, every field decided -/
def data : CharData (QuaternionGroup 2) ℤ (Fin 5) where
  d := deg
  mult := mult
  χ := chi
  mult_mul_dim := mult_mul_deg
  χ_class := chi_class
  χ_one := chi_one
  conv_char := conv_char
  handle := handle

/-- the sphere at zero area counts the group: Σ d² = 8 -/
theorem sphere_zero (x : Fin 5 → ℤ) : data.Zraw x 0 0 = 8 := by
  rw [data.Zraw_sphere_zero]
  decide

/-- the torus at zero area: |G|² · |R| = 320 -/
theorem torus_zero (x : Fin 5 → ℤ) : data.Zraw x 0 1 = 320 := by
  rw [data.Zraw_torus_zero]
  decide

/-- MIGDAL'S FORMULA FOR Q₈ at every area and genus, as the five-term sum -/
theorem migdal (x : Fin 5 → ℤ) (t g : ℕ) :
    data.Zraw x t g = x 0 ^ t * 8 ^ (2 * g) + x 1 ^ t * 8 ^ (2 * g) + x 2 ^ t * 8 ^ (2 * g)
      + x 3 ^ t * 8 ^ (2 * g) + 4 * x 4 ^ t * 4 ^ (2 * g) := by
  rw [data.Zraw_eq]
  simp only [Fin.sum_univ_five]
  show (1 : ℤ) ^ 2 * (8 : ℕ) ^ (2 * g) * x 0 ^ t + (1 : ℤ) ^ 2 * (8 : ℕ) ^ (2 * g) * x 1 ^ t
      + (1 : ℤ) ^ 2 * (8 : ℕ) ^ (2 * g) * x 2 ^ t + (1 : ℤ) ^ 2 * (8 : ℕ) ^ (2 * g) * x 3 ^ t
      + (2 : ℤ) ^ 2 * (4 : ℕ) ^ (2 * g) * x 4 ^ t = _
  push_cast
  ring

end Q8

end Aperanton
