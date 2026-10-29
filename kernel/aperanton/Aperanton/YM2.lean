/-
  APERANTON -- THE BOUNDLESS, stage W7 = Ω2 THE PLANE (ADDENDUM I, THE ROAD, §2 of the 16:39 note): TWO-DIMENSIONAL
  YANG–MILLS FOR A FINITE GROUP, COMPLETE AND EXACT, FROM THREE CHARACTER IDENTITIES.

  THE OBJECT.  A finite group G, its irreducible characters χ_r (r ∈ R) valued in any commutative ring S, their
  degrees d_r and the multiplicities m_r = |G|/d_r (an integer: d_r divides |G|).  `CharData` carries the three
  classical identities every finite group satisfies and nothing else: χ_r is a class function (`χ_class`),
  χ_r(1) = d_r (`χ_one`), THE CONVOLUTION IDENTITY Σ_y χ_r(y) χ_s(y⁻¹x) = δ_rs m_r χ_r(x) (`conv_char`, the second
  orthogonality in its multiplicative form), and THE HANDLE IDENTITY Σ_a χ_r(x·a y a⁻¹) = m_r χ_r(x) χ_r(y)
  (`handle`, Schur's lemma summed over the group).  For the SU(2) shadows (Q₈, 2T, 2O, 2I: ΑΡΑΧΝΗ T-175, ΚΑΜΨΙΣ
  Add. IV) the identities are DECIDED from ΠΙΝΑΞ's exact tables in ΚΥΚΛΟΤΟΜΙΑ's ring; for every finite group they
  are Mathlib's orthogonality relations (`FDRep.char_orthonormal`) in another costume -- the discharge is owed.

  THE THEORY.  Migdal's plaquette weight in the character basis, W_t(g) = Σ_r d_r x_r^t χ_r(g) with x_r the Casimir
  weight of r (ΚΑΜΨΙΣ T-475: the Cayley Laplacian is the Casimir; x_r = q^{C_r} makes Z ∈ ℤ[q]) and t the area in
  plaquette units.  THE SELF-REPRODUCTION (`conv_heat`): W_t ∗ W_s = |G| · W_{t+s} -- integrating the link shared by
  two faces of areas t and s gives one face of area t + s with no change of form, which is why the lattice theory
  at every spacing IS the continuum theory and the continuum limit is the identity on the data (Migdal 1975,
  Witten 1991).  THE TRANSFER OPERATOR (`transfer_char`): convolution by W_t is DIAGONAL on characters with
  eigenvalue |G| x_r^t, so on a spatial circle the spectrum is discrete, the energies the Casimirs times the
  length, the gap the least nonzero Casimir -- the two-dimensional "mass gap", with no propagating excitation
  (ΚΡΑΣΠΕΔΟΝ T-183 certifies it by inertia on the Cayley Laplacian).  THE HANDLE OPERATOR (`handleOp`, Hf(x) =
  Σ_{a,b} f(x[a,b])) acts on χ_r by m_r² (`handleOp_char`, from `handle` and `conv_char`), so THE PARTITION FUNCTION
  OF A CLOSED SURFACE OF GENUS g AND AREA t, `Zraw x t g = (H^g W_t)(1)`, is Σ_r d_r² m_r^{2g} x_r^t
  (`Zraw_eq`) -- Migdal's Σ_r d_r^{2−2g} e^{−g²A C₂(r)/2} multiplied through by |G|^{2g}, exact in S with no
  division: the sphere Σ_r d_r² x_r^t, the torus |G|² Σ_r x_r^t.  At t = 0 the torus reads |G|² · |R| and the
  sphere Σ d_r² = |G|: ΕΛΙΓΜΟΣ T-155 (|Hom(π₁, G)| = |G|^{2g−1} Σ_r (|G|/d_r)^{2g−2}, Mednykh) and ΑΘΙΚΤΟΝ
  (Frobenius) are this theorem at zero area -- the tree held two-dimensional Yang–Mills at zero area already.
  Classical throughout (W = 0); the earning is the one exact statement on any coefficient ring, every instance a
  decided table.  No sorry, no axiom, no native_decide.
-/
import Mathlib

open Finset

namespace Aperanton

/-- THE CHARACTER DATA of a finite group: degrees, multiplicities |G|/d, characters, and the three identities -/
structure CharData (G : Type*) [Group G] [Fintype G] (S : Type*) [CommRing S] (R : Type*) [Fintype R] [DecidableEq R] where
  d : R → ℕ
  mult : R → ℕ
  χ : R → G → S
  mult_mul_dim : ∀ r, mult r * d r = Fintype.card G
  χ_class : ∀ r (g h : G), χ r (g * h * g⁻¹) = χ r h
  χ_one : ∀ r, χ r 1 = (d r : S)
  conv_char : ∀ r s (x : G), ∑ y, χ r y * χ s (y⁻¹ * x) = if r = s then (mult r : S) * χ r x else 0
  handle : ∀ r (x y : G), ∑ a, χ r (x * (a * y * a⁻¹)) = (mult r : S) * χ r x * χ r y

variable {G : Type*} [Group G] [Fintype G] {S : Type*} [CommRing S] {R : Type*} [Fintype R] [DecidableEq R]

/-- the convolution on the group algebra: (f ∗ g)(x) = Σ_y f(y) g(y⁻¹ x) -/
def conv (f g : G → S) : G → S := fun x => ∑ y, f y * g (y⁻¹ * x)

namespace CharData

variable (C : CharData G S R)

/-- the multiplicity times the degree is the order, in the coefficient ring -/
theorem mult_mul_dim_cast (r : R) : (C.mult r : S) * (C.d r : S) = (Fintype.card G : S) := by
  rw [← Nat.cast_mul, C.mult_mul_dim]

/-- MIGDAL'S WEIGHT in the character basis: W_t = Σ_r d_r x_r^t χ_r, x_r the Casimir weight, t the area -/
def heat (x : R → S) (t : ℕ) : G → S := fun g => ∑ r, (C.d r : S) * x r ^ t * C.χ r g

/-- the first orthogonality, derived: Σ_y χ_r(y) χ_r(y⁻¹) = |G| -/
theorem orth_self (r : R) : ∑ y, C.χ r y * C.χ r y⁻¹ = (Fintype.card G : S) := by
  have h := C.conv_char r r 1
  rw [if_pos rfl, C.χ_one, mult_mul_dim_cast] at h
  rw [← h]
  apply Finset.sum_congr rfl
  intro y _
  rw [mul_one]

/-- THE TRANSFER OPERATOR IS DIAGONAL ON CHARACTERS: W_t ∗ χ_r = |G| x_r^t χ_r -/
theorem transfer_char (x : R → S) (t : ℕ) (r : R) (g : G) :
    conv (C.heat x t) (C.χ r) g = (Fintype.card G : S) * x r ^ t * C.χ r g := by
  unfold conv heat
  simp_rw [Finset.sum_mul]
  rw [Finset.sum_comm]
  have hterm : ∀ s : R, ∑ y, (C.d s : S) * x s ^ t * C.χ s y * C.χ r (y⁻¹ * g)
      = (C.d s : S) * x s ^ t * ∑ y, C.χ s y * C.χ r (y⁻¹ * g) := by
    intro s
    rw [Finset.mul_sum]
    apply Finset.sum_congr rfl
    intro y _
    ring
  simp_rw [hterm, C.conv_char]
  simp only [mul_ite, mul_zero, Finset.sum_ite_eq', Finset.sum_ite_eq, Finset.mem_univ, if_true]
  have hm := C.mult_mul_dim_cast r
  linear_combination (x r ^ t * C.χ r g) * hm

/-- THE SELF-REPRODUCTION: W_t ∗ W_s = |G| · W_{t+s} -- the lattice theory at every spacing is the continuum theory -/
theorem conv_heat (x : R → S) (t s : ℕ) (g : G) :
    conv (C.heat x t) (C.heat x s) g = (Fintype.card G : S) * C.heat x (t + s) g := by
  have hexp : conv (C.heat x t) (C.heat x s) g
      = ∑ r, (C.d r : S) * x r ^ s * conv (C.heat x t) (C.χ r) g := by
    unfold conv
    have h1 : ∀ y : G, C.heat x t y * C.heat x s (y⁻¹ * g)
        = ∑ r, (C.d r : S) * x r ^ s * (C.heat x t y * C.χ r (y⁻¹ * g)) := by
      intro y
      show C.heat x t y * (∑ r, (C.d r : S) * x r ^ s * C.χ r (y⁻¹ * g))
        = ∑ r, (C.d r : S) * x r ^ s * (C.heat x t y * C.χ r (y⁻¹ * g))
      rw [Finset.mul_sum]
      apply Finset.sum_congr rfl
      intro r _
      ring
    simp_rw [h1]
    rw [Finset.sum_comm]
    apply Finset.sum_congr rfl
    intro r _
    rw [Finset.mul_sum]
  rw [hexp]
  simp_rw [C.transfer_char]
  unfold heat
  rw [Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro r _
  rw [pow_add]
  ring

/-- THE HANDLE OPERATOR: (Hf)(x) = Σ_{a,b} f(x · a b a⁻¹ b⁻¹) -- one handle glued onto the surface -/
def handleOp (f : G → S) : G → S := fun x => ∑ a, ∑ b, f (x * (a * b * a⁻¹ * b⁻¹))

/-- a handle multiplies χ_r by m_r² -/
theorem handleOp_char (r : R) (x : G) : handleOp (C.χ r) x = (C.mult r : S) ^ 2 * C.χ r x := by
  unfold handleOp
  have h1 : ∀ b : G, ∑ a, C.χ r (x * (a * b * a⁻¹ * b⁻¹)) = (C.mult r : S) * C.χ r (b⁻¹ * x) * C.χ r b := by
    intro b
    rw [← C.handle r (b⁻¹ * x) b]
    apply Finset.sum_congr rfl
    intro a _
    rw [← C.χ_class r b⁻¹ (x * (a * b * a⁻¹ * b⁻¹))]
    congr 1
    group
  rw [Finset.sum_comm]
  simp_rw [h1, mul_assoc]
  rw [← Finset.mul_sum]
  have h2 : ∑ b, C.χ r (b⁻¹ * x) * C.χ r b = (C.mult r : S) * C.χ r x := by
    have h := C.conv_char r r x
    rw [if_pos rfl] at h
    rw [← h]
    apply Finset.sum_congr rfl
    intro b _
    ring
  rw [h2]
  ring

/-- the handle operator is linear over the character basis -/
theorem handleOp_lin (c : R → S) (x : G) :
    handleOp (fun g => ∑ r, c r * C.χ r g) x = ∑ r, c r * handleOp (C.χ r) x := by
  unfold handleOp
  simp only [Finset.mul_sum]
  calc (∑ a, ∑ b, ∑ r, c r * C.χ r (x * (a * b * a⁻¹ * b⁻¹)))
      = ∑ a, ∑ r, ∑ b, c r * C.χ r (x * (a * b * a⁻¹ * b⁻¹)) :=
        Finset.sum_congr rfl (fun _ _ => Finset.sum_comm)
    _ = ∑ r, ∑ a, ∑ b, c r * C.χ r (x * (a * b * a⁻¹ * b⁻¹)) := Finset.sum_comm

/-- g handles on the plaquette weight, pointwise: H^g W_t = Σ_r d_r x_r^t m_r^{2g} χ_r -/
theorem handleOp_iterate (x : R → S) (t : ℕ) (g : ℕ) (y : G) :
    (handleOp)^[g] (C.heat x t) y = ∑ r, (C.d r : S) * x r ^ t * (C.mult r : S) ^ (2 * g) * C.χ r y := by
  induction g generalizing y with
  | zero =>
    simp only [Function.iterate_zero, id_eq, heat, mul_zero, pow_zero, mul_one]
  | succ n ih =>
    rw [Function.iterate_succ_apply']
    have hfun : (handleOp)^[n] (C.heat x t)
        = fun z => ∑ r, ((C.d r : S) * x r ^ t * (C.mult r : S) ^ (2 * n)) * C.χ r z := by
      funext z
      rw [ih z]
    rw [hfun, C.handleOp_lin]
    apply Finset.sum_congr rfl
    intro r _
    rw [C.handleOp_char]
    rw [show 2 * (n + 1) = 2 * n + 2 by ring, pow_add]
    ring

/-- THE PARTITION FUNCTION OF A CLOSED SURFACE of genus g and area t, the links summed without normalisation -/
def Zraw (x : R → S) (t g : ℕ) : S := (handleOp)^[g] (C.heat x t) 1

/-- MIGDAL'S FORMULA, EXACT IN ANY RING: Z_g(t) = Σ_r d_r² m_r^{2g} x_r^t -/
theorem Zraw_eq (x : R → S) (t g : ℕ) :
    C.Zraw x t g = ∑ r, (C.d r : S) ^ 2 * (C.mult r : S) ^ (2 * g) * x r ^ t := by
  unfold Zraw
  rw [C.handleOp_iterate]
  apply Finset.sum_congr rfl
  intro r _
  rw [C.χ_one]
  ring

/-- the sphere: Σ_r d_r² x_r^t -/
theorem Zraw_sphere (x : R → S) (t : ℕ) : C.Zraw x t 0 = ∑ r, (C.d r : S) ^ 2 * x r ^ t := by
  rw [C.Zraw_eq]
  apply Finset.sum_congr rfl
  intro r _
  simp

/-- the torus: |G|² Σ_r x_r^t -/
theorem Zraw_torus (x : R → S) (t : ℕ) : C.Zraw x t 1 = (Fintype.card G : S) ^ 2 * ∑ r, x r ^ t := by
  rw [C.Zraw_eq, Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro r _
  have hm := C.mult_mul_dim_cast r
  rw [show 2 * 1 = 2 by norm_num]
  linear_combination (x r ^ t * ((C.d r : S) * (C.mult r : S) + (Fintype.card G : S))) * hm

/-- ZERO AREA: the sphere's count is Σ_r d_r² = |G| -- Frobenius (ΑΘΙΚΤΟΝ), the torus |G|² |R| (Mednykh, ΕΛΙΓΜΟΣ T-155) -/
theorem Zraw_sphere_zero (x : R → S) : C.Zraw x 0 0 = ∑ r, (C.d r : S) ^ 2 := by
  rw [C.Zraw_sphere]
  simp

theorem Zraw_torus_zero (x : R → S) : C.Zraw x 0 1 = (Fintype.card G : S) ^ 2 * (Fintype.card R : S) := by
  rw [C.Zraw_torus]
  simp

end CharData

end Aperanton
