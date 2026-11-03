import Mathlib.Tactic

/-!
# ΓΕΦΥΡΩΣΙΣ — the 2D Galerkin–Euler map, from first principles

The forward-Euler step of the Fourier–Galerkin truncation of the 2D Navier–Stokes equations
(viscosity 1, step 1) on the torus, in ΔΙΝΟΣ' basis, defined here from the physics alone:

* the kept wavevectors of the box `|k|_∞ ≤ K` (first nonzero coordinate positive, in ΔΙΝΟΣ'
  loop order), one polarisation `e(k) = (−k_y, k_x)` per mode, two trigonometric types;
* the trilinear coefficient `TX[a][b][c] = (e_a·k_b)(e_b·e_c) σ_b · 4·mean(T_a T_b' T_c)`,
  which is the Galerkin projection of `(φ_a·∇)φ_b` onto `φ_c` divided by `|e_c|²/2`
  (so the pressure never appears: it is orthogonal to every divergence-free mode);
* the step `F(c)_k = (1 − |k|²) c_k − Q_k(c) / (2|e_k|²)`, `Q_k(c) = Σ_{a,b} TX[a][b][k] c_a c_b`;
* ΔΙΝΟΣ' seed generator (a 64-bit linear congruential generator, draws in `{−3, …, 3}`).

Nothing here is a tabulated number: every coefficient is derived from the wavevectors.
The `#eval` lines at the end print the terms feeding the `|k|² = 2` coordinates at `K = 2`
in the format of ΔΙΝΟΣ' `DIN-PADIC-WIDE-FEED` lines (`STDLIB/build/gephyrosis/run4.txt`)
and the `K = 1` linear-recurrence matrix of Addendum III, for the two-road check (law 6).
-/

namespace Gephyrosis

/-- A 2D wavevector. -/
structure Vec2 where
  x : ℤ
  y : ℤ
deriving DecidableEq, Repr, Inhabited

namespace Vec2

def dot (a b : Vec2) : ℤ := a.x * b.x + a.y * b.y

def normSq (a : Vec2) : ℤ := a.dot a

/-- the divergence-free polarisation `e(k) = (−k_y, k_x)` -/
def pol (k : Vec2) : Vec2 := ⟨-k.y, k.x⟩

def cross (a b : Vec2) : ℤ := a.x * b.y - a.y * b.x

end Vec2

/-- The kept wavevectors of the 2D box `|k|_∞ ≤ K`: one of each `±k` pair, the first nonzero
coordinate positive, `m` outer and `n` inner from `−K` to `K` (ΔΙΝΟΣ' `setup`). -/
def modes2D (K : ℕ) : List Vec2 :=
  (List.range (2 * K + 1)).flatMap fun i =>
    (List.range (2 * K + 1)).filterMap fun j =>
      let m : ℤ := (i : ℤ) - (K : ℤ)
      let n : ℤ := (j : ℤ) - (K : ℤ)
      if 0 < m ∨ (m = 0 ∧ 0 < n) then some ⟨m, n⟩ else none

/-- A basis function `e(k) · T(k·x)`: the mode and its trigonometric type (`0` cos, `1` sin). -/
structure Basis2 where
  k : Vec2
  t : ℕ
deriving DecidableEq, Repr, Inhabited

/-- The coordinates of the truncation: `(mode, cos)`, `(mode, sin)` for each kept mode. -/
def basis2D (K : ℕ) : List Basis2 := (modes2D K).flatMap fun k => [⟨k, 0⟩, ⟨k, 1⟩]

/-- `4 · mean_{x ∈ T²} T₁(k₁·x) T₂(k₂·x) T₃(k₃·x)` for nonzero wavevectors, where `T_j` is
cos (`t_j = 0`) or sin (`t_j = 1`). Writing each factor as `Σ_ε w_j(ε) e^{iε k_j·x}/2` with
`w_cos = 1`, `w_sin(ε) = −iε`, the mean is `(1/8) Σ_ε [ε₁k₁ + ε₂k₂ + ε₃k₃ = 0] Π w_j(ε_j)`;
the matching sign patterns come in one `±` pair (so `ε₁ = 1` may be fixed), the product is
real only when the number of sines is even, and it is `1` for no sines and `−ε_jε_k` for sines
at positions `j, k`. -/
def i3 (k1 k2 k3 : Vec2) (t1 t2 t3 : ℕ) : ℤ :=
  if (t1 + t2 + t3) % 2 = 1 then 0 else
  let pats : List (ℤ × ℤ) := [(1, 1), (1, -1), (-1, 1), (-1, -1)]
  match pats.find? (fun p =>
      k1.x + p.1 * k2.x + p.2 * k3.x = 0 ∧ k1.y + p.1 * k2.y + p.2 * k3.y = 0) with
  | none => 0
  | some (e2, e3) =>
      let eps : List ℤ := [1, e2, e3]
      let ts : List ℕ := [t1, t2, t3]
      let sines := (eps.zip ts).filterMap fun q => if q.2 = 1 then some q.1 else none
      match sines with
      | [] => 1
      | [ej, ek] => -(ej * ek)
      | _ => 0

/-- The trilinear coefficient: `(φ_a·∇)φ_b = (e_a·k_b) e_b T_a(k_a·x) T_b'(k_b·x)` with
`T_b' = σ_b T_{1−t_b}` (`σ_b = −1` for cos, `+1` for sin), projected on `φ_c` and divided by
`mean(φ_c·φ_c) = |e_c|²/2`:  `TX[a][b][c] = (e_a·k_b)(e_b·e_c) σ_b i3(…)`, so that the
coefficient of `φ_c` in `(u·∇)u` is `Σ_{a,b} TX[a][b][c] c_a c_b / (2|e_c|²)`. -/
def tx (a b c : Basis2) : ℤ :=
  let ea := a.k.pol
  let eb := b.k.pol
  let ec := c.k.pol
  let sigma : ℤ := if b.t = 0 then -1 else 1
  ea.dot b.k * eb.dot ec * sigma * i3 a.k b.k c.k a.t (1 - b.t) c.t

/-- `|k|²`, the viscous rate of a mode. -/
def kappa (bk : Basis2) : ℤ := bk.k.normSq

/-- `2|e_k|²`, the Galerkin divisor of a coordinate. -/
def divisor (bk : Basis2) : ℤ := 2 * bk.k.pol.normSq

/-- One nonzero entry of the tensor. -/
structure Term where
  a : ℕ
  b : ℕ
  c : ℕ
  T : ℤ
deriving Repr, DecidableEq

/-- The nonzero entries feeding coordinate `c`, in `(a, b)` order. -/
def termsFor (B : List Basis2) (c : ℕ) : List Term :=
  let n := B.length
  let bc := B.getD c default
  (List.range n).flatMap fun a => (List.range n).filterMap fun b =>
    let T := tx (B.getD a default) (B.getD b default) bc
    if T = 0 then none else some ⟨a, b, c, T⟩

/-- The sparse tensor, one term list per output coordinate. -/
def termsByCoord (B : List Basis2) : List (List Term) :=
  (List.range B.length).map (termsFor B)

/-- `Q_k(x) = Σ_{(a,b)} TX[a][b][k] x_a x_b` from the term list of `k`. -/
def quadAt (ts : List Term) (x : List ℚ) : ℚ :=
  ts.foldl (fun acc t => acc + (t.T : ℚ) * x.getD t.a 0 * x.getD t.b 0) 0

/-- The forward-Euler Galerkin step with step `h` (as a rational):
`F_h(x)_k = x_k + h (−|k|² x_k − Q_k(x)/(2|e_k|²))`. -/
def stepH (h : ℚ) (B : List Basis2) (tb : List (List Term)) (x : List ℚ) : List ℚ :=
  (B.zip (tb.zip x)).map fun q =>
    let bk := q.1
    let ts := q.2.1
    let xk := q.2.2
    xk + h * (-(kappa bk : ℚ) * xk - quadAt ts x / (divisor bk : ℚ))

/-- The step of record, `h = 1`: `F(x)_k = (1 − |k|²) x_k − Q_k(x)/(2|e_k|²)`. -/
def step (B : List Basis2) (tb : List (List Term)) (x : List ℚ) : List ℚ := stepH 1 B tb x

/-! ## ΔΙΝΟΣ' seed generator -/

/-- The 64-bit LCG of ΔΙΝΟΣ: `r ↦ r·6364136223846793005 + 1442695040888963407 mod 2⁶⁴`. -/
def lcgNext (r : ℕ) : ℕ := (r * 6364136223846793005 + 1442695040888963407) % 18446744073709551616

/-- The generator's state for an integer seed: `seed·2654435761 + 777` in 64 bits. -/
def seedState (seed : ℕ) : ℕ := (seed * 2654435761 + 777) % 18446744073709551616

/-- `n` draws, each `(r ≫ 33) mod 7 − 3` after advancing the state. -/
def seedDraws : ℕ → ℕ → List ℤ
  | _, 0 => []
  | r, m + 1 =>
      let r' := lcgNext r
      ((((r' / 8589934592) % 7 : ℕ) : ℤ) - 3) :: seedDraws r' m

/-- ΔΙΝΟΣ' initial data for a seed: one draw per coordinate, in index order. -/
def seedData (seed n : ℕ) : List ℤ := seedDraws (seedState seed) n

/-! ## Trajectories and valuations -/

/-- `[x, F x, F² x, …, Fⁿ x]`. -/
def trajAux (B : List Basis2) (tb : List (List Term)) : ℕ → List ℚ → List (List ℚ)
  | 0, x => [x]
  | n + 1, x => x :: trajAux B tb n (step B tb x)

/-- The exact orbit of ΔΙΝΟΣ' seed in the 2D box `K`, steps `0 … n`. -/
def traj2D (K seed n : ℕ) : List (List ℚ) :=
  let B := basis2D K
  let tb := termsByCoord B
  trajAux B tb n ((seedData seed B.length).map fun z => (z : ℚ))

/-- `Fⁿ(seed)`. -/
def orbit2D (K seed n : ℕ) : List ℚ := (traj2D K seed n).getD n []

/-- The `p`-adic valuation of a natural number by repeated division, with fuel. -/
def vpF (p : ℕ) : ℕ → ℕ → ℕ
  | 0, _ => 0
  | f + 1, n => if n ≠ 0 ∧ n % p = 0 then vpF p f (n / p) + 1 else 0

/-- The largest `p`-adic valuation of a denominator along a state: the pole order of the state. -/
def topDenVal (p f : ℕ) (x : List ℚ) : ℕ := x.foldl (fun m q => max m (vpF p f q.den)) 0

/-! ## The two-road check: the tensor against ΔΙΝΟΣ' feed lines, the seed against Addendum III -/

/-- A feed line in ΔΙΝΟΣ' format for coordinate `c`. -/
def feedLine (K c : ℕ) : String :=
  let B := basis2D K
  let ts := termsFor B c
  let body := ts.foldl (fun s t =>
    s ++ s!" ({t.a},{t.b},T={t.T},K2a={(B.getD t.a default).k.normSq},K2b={(B.getD t.b default).k.normSq})") ""
  s!"DIN-PADIC-WIDE-FEED c={c} K2={(B.getD c default).k.normSq} terms={body}"

/-- The `K = 1` linear-recurrence matrix of Addendum III for a seed: on the growing coordinates
`g ∈ {0, 1, 4, 5}` (the `|k|² = 1` modes) the quadratic feed is linear in them with the frozen
coordinates `f ∈ {2, 3, 6, 7}` (the `|k|² = 2` modes) as coefficients:
`G[g][g'] = Σ_f (TX[f][g'][g] + TX[g'][f][g]) c_f(0)`. -/
def gMatrixK1 (seed : ℕ) : List (List ℤ) :=
  let B := basis2D 1
  let c0 := seedData seed B.length
  let growing := [0, 1, 4, 5]
  let frozen := [2, 3, 6, 7]
  growing.map fun g => growing.map fun g' =>
    frozen.foldl (fun acc f =>
      acc + (tx (B.getD f default) (B.getD g' default) (B.getD g default)
             + tx (B.getD g' default) (B.getD f default) (B.getD g default)) * c0.getD f 0) 0

end Gephyrosis
