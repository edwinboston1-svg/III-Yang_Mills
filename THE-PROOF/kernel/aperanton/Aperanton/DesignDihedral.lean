/-
  LEAN/aperanton/Aperanton/DesignDihedral.lean -- THE DESIGN STRENGTHS BY THE CLASS-DATA ROAD, AND THE BINARY DIHEDRAL FAMILY
  (T3 corrected, 2026-10-28).  No import: the bare kernel; `decide` the only proof term.  Design.lean (emitted by
  aperanton_emit_design.sh, arm 67) already decides BT, BO, BI as 5-, 7-, 11-designs from their explicit quaternions; this file is
  the SECOND ROAD -- the class tables and the Chebyshev recursion over the quadratic rings, sharing no line -- and carries what
  Design.lean does not: Q8 and the binary dihedral family Dic_n (n = 2, 3, 4, 6), every member a 3-design and not a 4-design, the
  discriminating prediction of the compounded freezing law (the master plan note §29.5).

  THE MATHEMATICS.  For a finite subgroup G of SU(2) the group average of the spin-j character,
      (1/|G|) sum_{g in G} chi_j(g)  =  dim (V_j)^G  =  the number of G-invariants in the spin-j representation,
  and chi_j(g) = U_{2j}(cos theta_g) = the Chebyshev polynomial of the second kind in the half-trace, which satisfies the
  INTEGER recursion in the trace a = tr g:  U_0 = 1,  U_1 = a,  U_{n+1} = a U_n - U_{n-1}.  A finite subgroup is a spherical
  t-design on S^3 exactly when the averages vanish for 0 < 2j <= t (the matrix coefficients of spin j are the harmonic
  polynomials of degree 2j; the average over G of a matrix coefficient is the projector onto the invariants), so the design
  strength t is (the first 2j with a nonzero invariant count) - 1.  THE LINK-DEGREE IDENTITY (T3 corrected; the proof on the road
  page): on G^E the counting measure integrates exactly every polynomial of degree <= t in EACH link variable, by induction link
  by link, so a character term of the lattice weight with link degrees D_l = sum_{p containing l} m_{l,p} 2j_p <= t for every l is
  integrated exactly, and the residue of the finite theory against SU(2) is the sum of the terms with some D_l > t.

  THE DATA.  The conjugacy classes of each shadow by (size, trace), the trace in the quadratic ring the group needs:
    Q8  (order 8):   trace 2 (1), -2 (1), 0 (6)                                                  over Z
    2T  (order 24):  2 (1), -2 (1), 1 (8), -1 (8), 0 (6)                                         over Z
    2O  (order 48):  2 (1), -2 (1), 1 (8), -1 (8), 0 (18), sqrt2 (6), -sqrt2 (6)                 over Z[sqrt 2]
    2I  (order 120): 2 (1), -2 (1), 1 (20), -1 (20), 0 (30), phi (12), -phi (12), phi-1 (12), 1-phi (12)   over Z[phi]
  (the quaternion tables of STDLIB/scripts/aperanton_shadow_hinge.awk, whose MODE=design reading prints the same counts from the
  120 elements themselves: the two roads share no line).

  THE THEOREMS.  invariants G n = |G| * (the invariant count at 2j = n), for n = 1..14, as the literal lists:
    Q8: 0 0 0 2 0 1 0 3 0 2 0 4 0 3      2T: 0 0 0 0 0 1 0 1 0 0 0 2 0 1      2O: 0 0 0 0 0 0 0 1 0 0 0 1 0 0
    2I: 0 0 0 0 0 0 0 0 0 0 0 1 0 0   -- the first invariant in degree 4, 6, 8, 12 (the Molien series of the binary polyhedral
  groups), hence the design strengths 3, 5, 7, 11.  The irrational classes enter in Galois-conjugate pairs of equal size, so
  every sum lands in Z (the second coordinate reads 0): decided, not assumed.
-/

namespace Aperanton.DesignDihedral

/-- The quadratic ring Z[x]/(x^2 - p x - q): an element a + b x.  p = 1, q = 1 is Z[phi]; p = 0, q = 2 is Z[sqrt 2];
    with b = 0 throughout it is Z itself. -/
structure Q2 (p q : Int) where
  a : Int
  b : Int
deriving DecidableEq, Repr

namespace Q2
variable {p q : Int}

def one : Q2 p q := ⟨1, 0⟩
def ofInt (n : Int) : Q2 p q := ⟨n, 0⟩
def add (x y : Q2 p q) : Q2 p q := ⟨x.a + y.a, x.b + y.b⟩
def sub (x y : Q2 p q) : Q2 p q := ⟨x.a - y.a, x.b - y.b⟩
/-- (a + b x)(c + d x) = ac + (ad + bc) x + bd x^2 = (ac + q bd) + (ad + bc + p bd) x -/
def mul (x y : Q2 p q) : Q2 p q := ⟨x.a * y.a + q * (x.b * y.b), x.a * y.b + x.b * y.a + p * (x.b * y.b)⟩
def smul (n : Int) (x : Q2 p q) : Q2 p q := ⟨n * x.a, n * x.b⟩

end Q2

/-- The pair (U_n, U_{n+1}) of Chebyshev values of the second kind at half-trace a/2, by the integer recursion
    U_0 = 1, U_1 = a, U_{n+1} = a U_n - U_{n-1}: structural in n, so the kernel reduces it. -/
def chebPair {p q : Int} (a : Q2 p q) : Nat → Q2 p q × Q2 p q
  | 0 => (Q2.one, a)
  | n + 1 => let r := chebPair a n; (r.2, Q2.sub (Q2.mul a r.2) r.1)

def cheb {p q : Int} (a : Q2 p q) (n : Nat) : Q2 p q := (chebPair a n).1

/-- A class table: (class size, trace). -/
abbrev ClassTable (p q : Int) := List (Int × Q2 p q)

/-- |G| times the invariant count at 2j = n: the sum over the classes of size * U_n(trace). -/
def invariants {p q : Int} (cls : ClassTable p q) (n : Nat) : Q2 p q :=
  cls.foldl (fun acc c => Q2.add acc (Q2.smul c.1 (cheb c.2 n))) ⟨0, 0⟩

def order {p q : Int} (cls : ClassTable p q) : Int := cls.foldl (fun acc c => acc + c.1) 0

/-- The invariant lists for n = 1..14, as integers (the second coordinate must read 0). -/
def invList {p q : Int} (cls : ClassTable p q) : List (Q2 p q) :=
  (List.range 14).map (fun k => invariants cls (k + 1))

def intList (l : List Int) : List (Q2 0 0) := l.map Q2.ofInt

/-- The design strength: (the first n >= 1 with a nonzero invariant count) - 1, read on the list. -/
def firstNonzero : List Int → Nat → Nat
  | [], _ => 0
  | x :: xs, n => if x ≠ 0 then n else firstNonzero xs (n + 1)

/- ---- the four shadows ---- -/

def Q8 : ClassTable 0 0 := [(1, ⟨2, 0⟩), (1, ⟨-2, 0⟩), (6, ⟨0, 0⟩)]
def T2 : ClassTable 0 0 := [(1, ⟨2, 0⟩), (1, ⟨-2, 0⟩), (8, ⟨1, 0⟩), (8, ⟨-1, 0⟩), (6, ⟨0, 0⟩)]
/-- 2O over Z[sqrt 2] (p = 0, q = 2): the twelve elements of order 8 have trace ± sqrt 2. -/
def O2 : ClassTable 0 2 :=
  [(1, ⟨2, 0⟩), (1, ⟨-2, 0⟩), (8, ⟨1, 0⟩), (8, ⟨-1, 0⟩), (18, ⟨0, 0⟩), (6, ⟨0, 1⟩), (6, ⟨0, -1⟩)]
/-- 2I over Z[phi] (p = 1, q = 1): the elements of order 10 have trace phi and 1 - phi, those of order 5 have trace
    phi - 1 and -phi. -/
def I2 : ClassTable 1 1 :=
  [(1, ⟨2, 0⟩), (1, ⟨-2, 0⟩), (20, ⟨1, 0⟩), (20, ⟨-1, 0⟩), (30, ⟨0, 0⟩),
   (12, ⟨0, 1⟩), (12, ⟨0, -1⟩), (12, ⟨-1, 1⟩), (12, ⟨1, -1⟩)]

theorem order_Q8 : order Q8 = 8 := by decide
theorem order_T2 : order T2 = 24 := by decide
theorem order_O2 : order O2 = 48 := by decide
theorem order_I2 : order I2 = 120 := by decide

/-- Q8: |G| times the invariant counts at 2j = 1..14 are 8 * [0,0,0,2,0,1,0,3,0,2,0,4,0,3]. -/
theorem invariants_Q8 :
    invList Q8 = intList [0, 0, 0, 16, 0, 8, 0, 24, 0, 16, 0, 32, 0, 24] := by decide

/-- 2T: 24 * [0,0,0,0,0,1,0,1,0,0,0,2,0,1]. -/
theorem invariants_T2 :
    invList T2 = intList [0, 0, 0, 0, 0, 24, 0, 24, 0, 0, 0, 48, 0, 24] := by decide

/-- 2O: 48 * [0,0,0,0,0,0,0,1,0,0,0,1,0,0]; every sum has a vanishing sqrt 2 coordinate. -/
theorem invariants_O2 :
    invList O2 = ([0, 0, 0, 0, 0, 0, 0, 48, 0, 0, 0, 48, 0, 0] : List Int).map (fun n => (⟨n, 0⟩ : Q2 0 2)) := by
  decide

/-- 2I: 120 * [0 (eleven times), 1, 0, 0]; every sum has a vanishing phi coordinate. -/
theorem invariants_I2 :
    invList I2 = ([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 120, 0, 0] : List Int).map (fun n => (⟨n, 0⟩ : Q2 1 1)) := by
  decide

/-- The design strengths: the first nonzero invariant at 2j = 4, 6, 8, 12, so t = 3, 5, 7, 11. -/
theorem strength_Q8 : firstNonzero [0, 0, 0, 16, 0, 8, 0, 24, 0, 16, 0, 32, 0, 24] 1 - 1 = 3 := by decide
theorem strength_T2 : firstNonzero [0, 0, 0, 0, 0, 24, 0, 24, 0, 0, 0, 48, 0, 24] 1 - 1 = 5 := by decide
theorem strength_O2 : firstNonzero [0, 0, 0, 0, 0, 0, 0, 48, 0, 0, 0, 48, 0, 0] 1 - 1 = 7 := by decide
theorem strength_I2 : firstNonzero [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 120, 0, 0] 1 - 1 = 11 := by decide

/-- The binary dihedral family Dic_n for n = 2..6 (order 4n; classes: trace ±2 (1 each), the 2n elements of order 4 outside
    the cyclic part (trace 0), and the cyclic part's traces 2 cos(pi k / n) in conjugate pairs) has its first invariant at 2j = 4 for
    every n: the whole family is exactly a 3-design -- the discriminating prediction of the compounded freezing law (§29.5 of the
    master plan note).  Here n = 2 (Q8), 3, 4, 6 are decided with rational traces (2 cos(pi/3) = 1, 2 cos(pi/2) = 0,
    2 cos(2pi/3) = -1, 2 cos(pi/6) = sqrt 3 for n = 6 over Z[sqrt 3]). -/
def Dic3 : ClassTable 0 0 := [(1, ⟨2, 0⟩), (1, ⟨-2, 0⟩), (2, ⟨1, 0⟩), (2, ⟨-1, 0⟩), (6, ⟨0, 0⟩)]
def Dic4 : ClassTable 0 2 := [(1, ⟨2, 0⟩), (1, ⟨-2, 0⟩), (2, ⟨0, 1⟩), (2, ⟨0, -1⟩), (2, ⟨0, 0⟩), (8, ⟨0, 0⟩)]
def Dic6 : ClassTable 0 3 :=
  [(1, ⟨2, 0⟩), (1, ⟨-2, 0⟩), (2, ⟨0, 1⟩), (2, ⟨0, -1⟩), (2, ⟨1, 0⟩), (2, ⟨-1, 0⟩), (2, ⟨0, 0⟩), (12, ⟨0, 0⟩)]

theorem order_Dic3 : order Dic3 = 12 := by decide
theorem order_Dic4 : order Dic4 = 16 := by decide
theorem order_Dic6 : order Dic6 = 24 := by decide

/-- Dic_3, Dic_4, Dic_6: the first four invariant counts (times the order) are 0, 0, 0, nonzero -- a 3-design and not a 4-design. -/
theorem dic3_first_four : (List.range 4).map (fun k => invariants Dic3 (k + 1)) = intList [0, 0, 0, 12] := by decide
theorem dic4_first_four :
    (List.range 4).map (fun k => invariants Dic4 (k + 1)) = ([0, 0, 0, 16] : List Int).map (fun n => (⟨n, 0⟩ : Q2 0 2)) := by
  decide
theorem dic6_first_four :
    (List.range 4).map (fun k => invariants Dic6 (k + 1)) = ([0, 0, 0, 24] : List Int).map (fun n => (⟨n, 0⟩ : Q2 0 3)) := by
  decide

end Aperanton.DesignDihedral
