/-
  APERANTON -- THE BOUNDLESS, stage A8e: THE GAUGE ACTION ON A CROSS-SECTION, AND THE NONABELIAN THEOREM'S ENDPOINT
  HYPOTHESES DISCHARGED FOR EVERY FINITE GROUP.

  Nonabelian.lean assumes an endpoint action: permutations σ_g of the cross-section's configurations under which D
  and the tensor kernel are invariant and the T-line's holonomy is equivariant, h(σ_g c) = g · h(c).  Here it is
  built from the lattice: a cross-section is a set of oriented links (src, tgt); the gauge transformation by g at
  the vertex v puts g on the left of every link out of v and g⁻¹ on the right of every link into v
  (`gauge`, a permutation: `gaugePerm`).  A SQUARE plaquette's holonomy c₁ c₂ c₃⁻¹ c₄⁻¹ is CONJUGATED by g when v is its
  base corner and unchanged otherwise -- the inner gauge factors cancel at the shared vertices whatever coincidences
  the lattice has (`hol_gauge`); so a product of CLASS-FUNCTION plaquette weights is gauge invariant
  (`plaqWeight_gauge`).  The link kernel k(a, b) = w(a b⁻¹) of a class function w has k(x a, x b) = k(a, b) and
  k(a x, b x) = k(a, b), so the tensor kernel is gauge invariant (`tensorKernel_gauge`).  A T-line that leaves v by
  its first link and never returns has holonomy ∏ c_ℓ equivariant: h(gauge v g c) = g · h(c) (`lineHol_gauge`).
  With these, THE LATTICE THEOREM (`lattice_potential_gap`): on any finite cross-section of square plaquettes, for
  any finite group, any positive class-function plaquette weight, any class-function link weight whose kernel is
  positive semidefinite and positive, any nontrivial real class function χ with positive semidefinite class matrix,
  and any T-line leaving a vertex once, the nonabelian Wilson loop of the x-transfer model converges and, once
  W(1) > 0, its static potential is at least the sector's gap.  No sorry, no axiom.
-/
import Mathlib
import Aperanton.Perron
import Aperanton.Spectral
import Aperanton.XTransfer
import Aperanton.GapBound
import Aperanton.Nonabelian

open Matrix Filter Topology

namespace Aperanton

section Gauge

variable {G : Type*} [Group G] {V L : Type*} [DecidableEq V]

/-- a cross-section: oriented links -/
structure Lat (V L : Type*) where
  src : L → V
  tgt : L → V

/-- the gauge transformation by g at v: g on the left of a link out of v, g⁻¹ on the right of a link into v -/
def gauge (Λ : Lat V L) (v : V) (g : G) (c : L → G) : L → G :=
  fun ℓ => (if Λ.src ℓ = v then g else 1) * c ℓ * (if Λ.tgt ℓ = v then g⁻¹ else 1)

theorem gauge_one (Λ : Lat V L) (v : V) (c : L → G) : gauge Λ v (1 : G) c = c := by
  funext ℓ
  simp [gauge]

theorem gauge_mul (Λ : Lat V L) (v : V) (g g' : G) (c : L → G) :
    gauge Λ v g (gauge Λ v g' c) = gauge Λ v (g * g') c := by
  funext ℓ
  simp only [gauge]
  split_ifs <;> simp [mul_assoc]

/-- the gauge transformation as a permutation of the configurations -/
def gaugePerm (Λ : Lat V L) (v : V) (g : G) : Equiv.Perm (L → G) where
  toFun := gauge Λ v g
  invFun := gauge Λ v g⁻¹
  left_inv := fun c => by rw [gauge_mul, inv_mul_cancel, gauge_one]
  right_inv := fun c => by rw [gauge_mul, mul_inv_cancel, gauge_one]

theorem gaugePerm_apply (Λ : Lat V L) (v : V) (g : G) (c : L → G) : gaugePerm Λ v g c = gauge Λ v g c := rfl

/-- a square plaquette: ℓ₁ from v₀ to v₁, ℓ₂ from v₁ to v₂, ℓ₃ from v₃ to v₂, ℓ₄ from v₀ to v₃ -/
structure Square (Λ : Lat V L) where
  ℓ₁ : L
  ℓ₂ : L
  ℓ₃ : L
  ℓ₄ : L
  h12 : Λ.tgt ℓ₁ = Λ.src ℓ₂
  h23 : Λ.tgt ℓ₂ = Λ.tgt ℓ₃
  h34 : Λ.src ℓ₃ = Λ.tgt ℓ₄
  h41 : Λ.src ℓ₄ = Λ.src ℓ₁

/-- the holonomy around the square -/
def hol {Λ : Lat V L} (p : Square Λ) (c : L → G) : G := c p.ℓ₁ * c p.ℓ₂ * (c p.ℓ₃)⁻¹ * (c p.ℓ₄)⁻¹

/-- THE HOLONOMY IS CONJUGATED by g when v is the base corner and unchanged otherwise -/
theorem hol_gauge {Λ : Lat V L} (p : Square Λ) (v : V) (g : G) (c : L → G) :
    hol p (gauge Λ v g c) =
      (if Λ.src p.ℓ₁ = v then g else 1) * hol p c * (if Λ.src p.ℓ₁ = v then g⁻¹ else 1) := by
  simp only [hol, gauge, _root_.mul_inv_rev, inv_inv]
  have e12 := p.h12
  have e23 := p.h23
  have e34 := p.h34
  have e41 := p.h41
  rw [← e12, e23, ← e34, e41]
  simp only [mul_assoc]
  split_ifs <;> simp [mul_assoc]

end Gauge

section Weights

variable {G : Type*} [Group G] [Fintype G] [DecidableEq G] {V L : Type*} [DecidableEq V] [Fintype L]
  [DecidableEq L]

/-- a class function: invariant under conjugation -/
def IsClassFn (w : G → ℝ) : Prop := ∀ x y : G, w (x * y * x⁻¹) = w y

/-- a cross-section's weight: the product of a class-function weight over its square plaquettes -/
def plaqWeight {Λ : Lat V L} {ι : Type*} [Fintype ι] (sq : ι → Square Λ) (w : G → ℝ) (c : L → G) : ℝ :=
  ∏ i, w (hol (sq i) c)

/-- THE PLAQUETTE WEIGHT IS GAUGE INVARIANT -/
theorem plaqWeight_gauge {Λ : Lat V L} {ι : Type*} [Fintype ι] (sq : ι → Square Λ) (w : G → ℝ)
    (hw : IsClassFn w) (v : V) (g : G) (c : L → G) : plaqWeight sq w (gauge Λ v g c) = plaqWeight sq w c := by
  unfold plaqWeight
  apply Finset.prod_congr rfl
  intro i _
  rw [hol_gauge]
  split_ifs
  · exact hw g _
  · simp

theorem plaqWeight_pos {Λ : Lat V L} {ι : Type*} [Fintype ι] (sq : ι → Square Λ) (w : G → ℝ)
    (hw : ∀ x, 0 < w x) (c : L → G) : 0 < plaqWeight sq w c :=
  Finset.prod_pos fun i _ => hw _

/-- the link kernel of a class function: k(a, b) = w(a b⁻¹) -/
def linkKernel (w : G → ℝ) : Matrix G G ℝ := fun a b => w (a * b⁻¹)

theorem linkKernel_left (w : G → ℝ) (hw : IsClassFn w) (x a b : G) :
    linkKernel w (x * a) (x * b) = linkKernel w a b := by
  simp only [linkKernel, _root_.mul_inv_rev]
  rw [show x * a * (b⁻¹ * x⁻¹) = x * (a * b⁻¹) * x⁻¹ by group]
  exact hw x _

theorem linkKernel_right (w : G → ℝ) (a b x : G) :
    linkKernel w (a * x) (b * x) = linkKernel w a b := by
  simp only [linkKernel, _root_.mul_inv_rev]
  rw [show a * x * (x⁻¹ * b⁻¹) = a * b⁻¹ by group]

/-- THE TENSOR KERNEL OF A CLASS-FUNCTION LINK WEIGHT IS GAUGE INVARIANT -/
theorem tensorKernel_gauge {Λ : Lat V L} (w : G → ℝ) (hw : IsClassFn w) (v : V) (g : G) (c c' : L → G) :
    tensorKernel (linkKernel w) (gauge Λ v g c) (gauge Λ v g c') = tensorKernel (linkKernel w) c c' := by
  simp only [tensorKernel, gauge]
  apply Finset.prod_congr rfl
  intro ℓ _
  split_ifs
  · rw [linkKernel_right, linkKernel_left w hw]
  · rw [mul_one, mul_one, linkKernel_left w hw]
  · rw [one_mul, one_mul, linkKernel_right]
  · rw [one_mul, one_mul, mul_one, mul_one]

/-- the holonomy along a line of forward links -/
def lineHol (line : List L) (c : L → G) : G := (line.map c).prod

/-- THE LINE'S HOLONOMY IS EQUIVARIANT at a vertex it leaves by its first link and never touches again -/
theorem lineHol_gauge {Λ : Lat V L} (ℓ₀ : L) (rest : List L) (v : V) (g : G) (c : L → G)
    (hsrc : Λ.src ℓ₀ = v) (htgt0 : Λ.tgt ℓ₀ ≠ v) (hsrc' : ∀ ℓ ∈ rest, Λ.src ℓ ≠ v)
    (htgt' : ∀ ℓ ∈ rest, Λ.tgt ℓ ≠ v) :
    lineHol (ℓ₀ :: rest) (gauge Λ v g c) = g * lineHol (ℓ₀ :: rest) c := by
  simp only [lineHol, List.map_cons, List.prod_cons]
  have h0 : gauge Λ v g c ℓ₀ = g * c ℓ₀ := by
    simp [gauge, hsrc, htgt0]
  have hrest : rest.map (gauge Λ v g c) = rest.map c := by
    apply List.map_congr_left
    intro ℓ hℓ
    simp [gauge, hsrc' ℓ hℓ, htgt' ℓ hℓ]
  rw [h0, hrest, mul_assoc]

end Weights

section LatticeTheorem

variable {G : Type*} [Group G] [Fintype G] [DecidableEq G] {V L : Type*} [DecidableEq V] [Fintype L]
  [DecidableEq L]

/-- THE LATTICE THEOREM: on a finite cross-section of square plaquettes, for a finite group G, a positive
class-function plaquette weight w, a class-function link weight w' whose kernel is positive semidefinite and
positive, a nontrivial real class function χ whose class matrix X is positive semidefinite, factorised as
X = Σ_j φ_j ⊗ φ_j, and a T-line leaving the vertex v by its first link and never touching v again: with Ω any unit
Perron vector of the transfer matrix, the nonabelian Wilson loop of the x-transfer model converges at every R to
Σ_j ⟨F_j Ω, M^R F_j Ω⟩ / λ₀^R, and once that sum is positive at R = 1 its static potential is at least the gap -/
theorem lattice_potential_gap [Nonempty (L → G)] (Λ : Lat V L) {ι : Type*} [Fintype ι] (sq : ι → Square Λ)
    (w : G → ℝ) (hw : IsClassFn w) (hwpos : ∀ x, 0 < w x)
    (w' : G → ℝ) (hw' : IsClassFn w') (hk : (linkKernel w').PosSemidef) (hkpos : ∀ a b, 0 < linkKernel w' a b)
    (ℓ₀ : L) (rest : List L) (v : V) (hsrc : Λ.src ℓ₀ = v) (htgt0 : Λ.tgt ℓ₀ ≠ v)
    (hsrc' : ∀ ℓ ∈ rest, Λ.src ℓ ≠ v) (htgt' : ∀ ℓ ∈ rest, Λ.tgt ℓ ≠ v)
    (X : Matrix G G ℝ) (hX : X.PosSemidef) (hX1 : X *ᵥ (fun _ => (1 : ℝ)) = 0)
    (φ : G → G → ℝ) (hφ : ∀ x y, X x y = ∑ j, φ j x * φ j y)
    (Ω : (L → G) → ℝ)
    (hΩ : transfer (plaqWeight sq w) (tensorKernel (linkKernel w')) *ᵥ Ω =
      lamMax (transfer (plaqWeight sq w) (tensorKernel (linkKernel w')))
        (transfer_posSemidef (plaqWeight sq w) _ (tensorKernel_posSemidef (linkKernel w') hk)).1 • Ω)
    (hn : Ω ⬝ᵥ Ω = 1) :
    (∀ R : ℕ, Tendsto (fun a : ℕ => slabLoop (plaqWeight sq w) (tensorKernel (linkKernel w'))
        (fun c c' => X (lineHol (ℓ₀ :: rest) c) (lineHol (ℓ₀ :: rest) c')) a R /
        slabZ (plaqWeight sq w) (tensorKernel (linkKernel w')) (a + 1) R) atTop
      (𝓝 (∑ j, (diagonal (fun c => φ j (lineHol (ℓ₀ :: rest) c)) *ᵥ Ω) ⬝ᵥ
          (transfer (plaqWeight sq w) (tensorKernel (linkKernel w')) ^ R *ᵥ
            (diagonal (fun c => φ j (lineHol (ℓ₀ :: rest) c)) *ᵥ Ω)) /
        lamMax (transfer (plaqWeight sq w) (tensorKernel (linkKernel w')))
          (transfer_posSemidef (plaqWeight sq w) _ (tensorKernel_posSemidef (linkKernel w') hk)).1 ^ R))) ∧
    (0 < ∑ j, (diagonal (fun c => φ j (lineHol (ℓ₀ :: rest) c)) *ᵥ Ω) ⬝ᵥ
        (transfer (plaqWeight sq w) (tensorKernel (linkKernel w')) *ᵥ
          (diagonal (fun c => φ j (lineHol (ℓ₀ :: rest) c)) *ᵥ Ω)) →
      ∃ s : ℝ, 0 < s ∧
        (∃ i, (transfer_posSemidef (plaqWeight sq w) _ (tensorKernel_posSemidef (linkKernel w') hk)).1.eigenvalues i ≠
            lamMax (transfer (plaqWeight sq w) (tensorKernel (linkKernel w')))
              (transfer_posSemidef (plaqWeight sq w) _ (tensorKernel_posSemidef (linkKernel w') hk)).1 ∧
          0 < (transfer_posSemidef (plaqWeight sq w) _ (tensorKernel_posSemidef (linkKernel w') hk)).1.eigenvalues i ∧
          s = Real.log (lamMax (transfer (plaqWeight sq w) (tensorKernel (linkKernel w')))
              (transfer_posSemidef (plaqWeight sq w) _ (tensorKernel_posSemidef (linkKernel w') hk)).1) -
            Real.log ((transfer_posSemidef (plaqWeight sq w) _ (tensorKernel_posSemidef (linkKernel w') hk)).1.eigenvalues i)) ∧
        Tendsto (fun R : ℕ => Real.log (lamMax (transfer (plaqWeight sq w) (tensorKernel (linkKernel w')))
            (transfer_posSemidef (plaqWeight sq w) _ (tensorKernel_posSemidef (linkKernel w') hk)).1) -
          Real.log (∑ j, (diagonal (fun c => φ j (lineHol (ℓ₀ :: rest) c)) *ᵥ Ω) ⬝ᵥ
            (transfer (plaqWeight sq w) (tensorKernel (linkKernel w')) ^ R *ᵥ
              (diagonal (fun c => φ j (lineHol (ℓ₀ :: rest) c)) *ᵥ Ω))) / R) atTop (𝓝 s)) := by
  apply nonabelian_slab_potential_gap (plaqWeight sq w) (plaqWeight_pos sq w hwpos) (linkKernel w') hk hkpos
    (lineHol (ℓ₀ :: rest)) X hX hX1 φ hφ (fun g => gaugePerm Λ v g) ?_ ?_ ?_ Ω hΩ hn
  · intro g c
    rw [gaugePerm_apply]
    exact plaqWeight_gauge sq w hw v g c
  · intro g c c'
    rw [gaugePerm_apply, gaugePerm_apply]
    exact tensorKernel_gauge w' hw' v g c c'
  · intro g c
    rw [gaugePerm_apply]
    exact lineHol_gauge ℓ₀ rest v g c hsrc htgt0 hsrc' htgt'

end LatticeTheorem

end Aperanton
