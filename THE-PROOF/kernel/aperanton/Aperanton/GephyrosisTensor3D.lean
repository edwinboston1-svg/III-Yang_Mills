import Aperanton.GephyrosisOrbit

/-!
# ΓΕΦΥΡΩΣΙΣ — the 3D Galerin–Euler map, from first principles

The 3D box `|k|_∞ ≤ K` with ΔΙΝΟΣ' two polarisations per mode: `e₁ = (−k_y, k_x, 0)` (and
`(1, 0, 0)` for a wavevector along `z`), `e₂ = k × e₁`; the basis `(mode, polarisation, type)`
nested in that order. The coefficient `TX[a][b][c] = (e_a·k_b)(e_b·e_c) σ_b i3(…)` and the step
are the 2D ones with 3D dot products; `i3` is the same trigonometric mean over sign patterns.
The feed lines of the `|k|² = 2` coordinates at `K = 1` (`DIN-PADIC-WIDE-FEED`, the 24 lines of
`run4.txt`) are the two-road check.
-/

namespace Gephyrosis

structure Vec3 where
  x : ℤ
  y : ℤ
  z : ℤ
deriving DecidableEq, Repr, Inhabited

namespace Vec3

def dot (a b : Vec3) : ℤ := a.x * b.x + a.y * b.y + a.z * b.z

def normSq (a : Vec3) : ℤ := a.dot a

def cross (a b : Vec3) : Vec3 := ⟨a.y * b.z - a.z * b.y, a.z * b.x - a.x * b.z, a.x * b.y - a.y * b.x⟩

/-- the first polarisation -/
def pol1 (k : Vec3) : Vec3 := if k.x = 0 ∧ k.y = 0 then ⟨1, 0, 0⟩ else ⟨-k.y, k.x, 0⟩

/-- the second polarisation `k × e₁` -/
def pol2 (k : Vec3) : Vec3 := k.cross (pol1 k)

def pol (k : Vec3) (j : ℕ) : Vec3 := if j = 0 then pol1 k else pol2 k

end Vec3

/-- The kept wavevectors of the 3D box: first nonzero coordinate positive, loops `m`, `n`, `l`. -/
def modes3D (K : ℕ) : List Vec3 :=
  (List.range (2 * K + 1)).flatMap fun i =>
    (List.range (2 * K + 1)).flatMap fun j =>
      (List.range (2 * K + 1)).filterMap fun h =>
        let m : ℤ := (i : ℤ) - (K : ℤ)
        let n : ℤ := (j : ℤ) - (K : ℤ)
        let l : ℤ := (h : ℤ) - (K : ℤ)
        if 0 < m ∨ (m = 0 ∧ 0 < n) ∨ (m = 0 ∧ n = 0 ∧ 0 < l) then some ⟨m, n, l⟩ else none

structure Basis3 where
  k : Vec3
  j : ℕ
  t : ℕ
deriving DecidableEq, Repr, Inhabited

/-- `(mode, polarisation, type)` in that nesting: index `4·mode + 2·pol + type`. -/
def basis3D (K : ℕ) : List Basis3 :=
  (modes3D K).flatMap fun k => [⟨k, 0, 0⟩, ⟨k, 0, 1⟩, ⟨k, 1, 0⟩, ⟨k, 1, 1⟩]

def i3v (k1 k2 k3 : Vec3) (t1 t2 t3 : ℕ) : ℤ :=
  if (t1 + t2 + t3) % 2 = 1 then 0 else
  let pats : List (ℤ × ℤ) := [(1, 1), (1, -1), (-1, 1), (-1, -1)]
  match pats.find? (fun p =>
      k1.x + p.1 * k2.x + p.2 * k3.x = 0 ∧ k1.y + p.1 * k2.y + p.2 * k3.y = 0
        ∧ k1.z + p.1 * k2.z + p.2 * k3.z = 0) with
  | none => 0
  | some (e2, e3) =>
      let eps : List ℤ := [1, e2, e3]
      let ts : List ℕ := [t1, t2, t3]
      let sines := (eps.zip ts).filterMap fun q => if q.2 = 1 then some q.1 else none
      match sines with
      | [] => 1
      | [ej, ek] => -(ej * ek)
      | _ => 0

def tx3 (a b c : Basis3) : ℤ :=
  let ea := a.k.pol a.j
  let eb := b.k.pol b.j
  let ec := c.k.pol c.j
  let sigma : ℤ := if b.t = 0 then -1 else 1
  ea.dot b.k * eb.dot ec * sigma * i3v a.k b.k c.k a.t (1 - b.t) c.t

def kappa3 (bk : Basis3) : ℤ := bk.k.normSq

def divisor3 (bk : Basis3) : ℤ := 2 * (bk.k.pol bk.j).normSq

def termsFor3 (B : List Basis3) (c : ℕ) : List Term :=
  let n := B.length
  let bc := B.getD c default
  (List.range n).flatMap fun a => (List.range n).filterMap fun b =>
    let T := tx3 (B.getD a default) (B.getD b default) bc
    if T = 0 then none else some ⟨a, b, c, T⟩

def termsByCoord3 (B : List Basis3) : List (List Term) :=
  (List.range B.length).map (termsFor3 B)


/-- A feed line in ΔΙΝΟΣ' format (its `K2=2` is a literal label on these lines). -/
def feedLine3 (K c : ℕ) : String :=
  let B := basis3D K
  let ts := termsFor3 B c
  let body := ts.foldl (fun s t =>
    s ++ s!" ({t.a},{t.b},T={t.T},K2a={(B.getD t.a default).k.normSq},K2b={(B.getD t.b default).k.normSq})") ""
  s!"DIN-PADIC-WIDE-FEED c={c} K2=2 terms={body}"

end Gephyrosis
