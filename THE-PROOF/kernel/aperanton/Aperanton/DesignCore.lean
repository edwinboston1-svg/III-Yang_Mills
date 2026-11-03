/-
  APERANTON -- THE BOUNDLESS, THE TREK T3 (2026-10-28): THE DESIGN THEOREM'S CORE -- carried-integer quaternions over
  Z[sqrt d], the Hamilton product's associativity and bilinearity as polynomial identities, and THE CLOSURE THEOREM
  FROM GENERATORS: a finite list of carried quaternions headed by the identity is closed under the product once (a) every
  member times every generator is four times a member and (b) every later member is a generator times an earlier
  member, exactly -- two LINEAR certificates (|G|·|S| products and |G| products) in place of the |G|² Cayley table the
  kernel cannot afford (the 120 × 120 closure of the binary icosahedral group by enumeration ran the kernel past the
  12 GB cap at 01:1x, measured).  The carried arithmetic: every coordinate four times its value, so a product of carried
  elements is sixteen times the true product, four times a carried element, and the kernel divides nowhere but by an
  exact four.  Classical content (Hamilton; the generator argument is the word argument of any finite group); the
  earning is the certificate shape.  No sorry, no axiom, no native_decide.
-/
import Mathlib

namespace Aperanton

namespace Design

/-- a number p + q sqrt d with integer p, q; the radicand d is a parameter of the arithmetic -/
structure Zd where
  p : ℤ
  q : ℤ
deriving DecidableEq, Repr

@[simp] theorem Zd.mk_p (p q : ℤ) : (Zd.mk p q).p = p := rfl
@[simp] theorem Zd.mk_q (p q : ℤ) : (Zd.mk p q).q = q := rfl

theorem Zd.ext_iff' (x y : Zd) : x = y ↔ x.p = y.p ∧ x.q = y.q := by
  cases x; cases y; simp

instance : Add Zd := ⟨fun x y => ⟨x.p + y.p, x.q + y.q⟩⟩
instance : Zero Zd := ⟨⟨0, 0⟩⟩
instance : Neg Zd := ⟨fun x => ⟨-x.p, -x.q⟩⟩
instance : Sub Zd := ⟨fun x y => ⟨x.p - y.p, x.q - y.q⟩⟩

@[simp] theorem Zd.add_p (x y : Zd) : (x + y).p = x.p + y.p := rfl
@[simp] theorem Zd.add_q (x y : Zd) : (x + y).q = x.q + y.q := rfl
@[simp] theorem Zd.sub_p (x y : Zd) : (x - y).p = x.p - y.p := rfl
@[simp] theorem Zd.sub_q (x y : Zd) : (x - y).q = x.q - y.q := rfl
@[simp] theorem Zd.neg_p (x : Zd) : (-x).p = -x.p := rfl
@[simp] theorem Zd.neg_q (x : Zd) : (-x).q = -x.q := rfl
@[simp] theorem Zd.zero_p : (0 : Zd).p = 0 := rfl
@[simp] theorem Zd.zero_q : (0 : Zd).q = 0 := rfl

/-- the product in Z[sqrt d] -/
def zmul (d : ℤ) (x y : Zd) : Zd := ⟨x.p * y.p + d * x.q * y.q, x.p * y.q + x.q * y.p⟩

@[simp] theorem zmul_p (d : ℤ) (x y : Zd) : (zmul d x y).p = x.p * y.p + d * x.q * y.q := rfl
@[simp] theorem zmul_q (d : ℤ) (x y : Zd) : (zmul d x y).q = x.p * y.q + x.q * y.p := rfl

/-- a quaternion a + b i + c j + e k with coordinates in Z[sqrt d] -/
structure Quat where
  a : Zd
  b : Zd
  c : Zd
  e : Zd
deriving DecidableEq, Repr

theorem Quat.ext_iff' (x y : Quat) : x = y ↔ x.a = y.a ∧ x.b = y.b ∧ x.c = y.c ∧ x.e = y.e := by
  cases x; cases y; simp

/-- the Hamilton product -/
def hmul (d : ℤ) (x y : Quat) : Quat :=
  ⟨zmul d x.a y.a - zmul d x.b y.b - zmul d x.c y.c - zmul d x.e y.e,
   zmul d x.a y.b + zmul d x.b y.a + zmul d x.c y.e - zmul d x.e y.c,
   zmul d x.a y.c - zmul d x.b y.e + zmul d x.c y.a + zmul d x.e y.b,
   zmul d x.a y.e + zmul d x.b y.c - zmul d x.c y.b + zmul d x.e y.a⟩

def conj (x : Quat) : Quat := ⟨x.a, -x.b, -x.c, -x.e⟩

def norm2 (d : ℤ) (x : Quat) : Zd := zmul d x.a x.a + zmul d x.b x.b + zmul d x.c x.c + zmul d x.e x.e

def mul4 (x : Zd) : Zd := ⟨4 * x.p, 4 * x.q⟩
def div4 (x : Zd) : Zd := ⟨x.p / 4, x.q / 4⟩
def quarter (x : Quat) : Quat := ⟨div4 x.a, div4 x.b, div4 x.c, div4 x.e⟩
def times4 (x : Quat) : Quat := ⟨mul4 x.a, mul4 x.b, mul4 x.c, mul4 x.e⟩

/-- the carried identity -/
def one : Quat := ⟨⟨4, 0⟩, ⟨0, 0⟩, ⟨0, 0⟩, ⟨0, 0⟩⟩

/-- a product of two carried elements (sixteen times the true product) is in the carried list iff it is four times
a member: divisible by four coordinate-wise with the quarter in the list -/
def inG (G : List Quat) (z : Quat) : Bool := decide (times4 (quarter z) = z) && decide (quarter z ∈ G)

/-- the carried Chebyshev value V_n = 4^n U_n(a/4) at a carried real part a: V 0 = 1, V 1 = 2a,
V (n+2) = 2a V (n+1) - 16 V n -- the SU(2) character of spin n/2 at a unit quaternion of real part a/4, times 4^n -/
def cheb (d : ℤ) (a : Zd) : ℕ → Zd
  | 0 => ⟨1, 0⟩
  | 1 => ⟨2 * a.p, 2 * a.q⟩
  | n + 2 => zmul d ⟨2 * a.p, 2 * a.q⟩ (cheb d a (n + 1)) - ⟨16 * (cheb d a n).p, 16 * (cheb d a n).q⟩

/-- the sum over a list of the carried character of spin n/2 at the real parts -/
def charSum (d : ℤ) (G : List Quat) (n : ℕ) : Zd := (G.map (fun g => cheb d g.a n)).sum

/-! ## The product's identities -/

theorem hmul_assoc (d : ℤ) (x y z : Quat) : hmul d (hmul d x y) z = hmul d x (hmul d y z) := by
  obtain ⟨⟨xap, xaq⟩, ⟨xbp, xbq⟩, ⟨xcp, xcq⟩, ⟨xep, xeq⟩⟩ := x
  obtain ⟨⟨yap, yaq⟩, ⟨ybp, ybq⟩, ⟨ycp, ycq⟩, ⟨yep, yeq⟩⟩ := y
  obtain ⟨⟨zap, zaq⟩, ⟨zbp, zbq⟩, ⟨zcp, zcq⟩, ⟨zep, zeq⟩⟩ := z
  simp only [hmul, Quat.ext_iff', Zd.ext_iff', Zd.sub_p, Zd.sub_q, Zd.add_p, Zd.add_q, zmul_p, zmul_q,
    Zd.mk_p, Zd.mk_q]
  refine ⟨⟨?_, ?_⟩, ⟨?_, ?_⟩, ⟨?_, ?_⟩, ⟨?_, ?_⟩⟩ <;> ring

theorem hmul_times4_left (d : ℤ) (x y : Quat) : hmul d (times4 x) y = times4 (hmul d x y) := by
  obtain ⟨⟨xap, xaq⟩, ⟨xbp, xbq⟩, ⟨xcp, xcq⟩, ⟨xep, xeq⟩⟩ := x
  obtain ⟨⟨yap, yaq⟩, ⟨ybp, ybq⟩, ⟨ycp, ycq⟩, ⟨yep, yeq⟩⟩ := y
  simp only [hmul, times4, mul4, Quat.ext_iff', Zd.ext_iff', Zd.sub_p, Zd.sub_q, Zd.add_p, Zd.add_q, zmul_p,
    zmul_q, Zd.mk_p, Zd.mk_q]
  refine ⟨⟨?_, ?_⟩, ⟨?_, ?_⟩, ⟨?_, ?_⟩, ⟨?_, ?_⟩⟩ <;> ring

theorem hmul_times4_right (d : ℤ) (x y : Quat) : hmul d x (times4 y) = times4 (hmul d x y) := by
  obtain ⟨⟨xap, xaq⟩, ⟨xbp, xbq⟩, ⟨xcp, xcq⟩, ⟨xep, xeq⟩⟩ := x
  obtain ⟨⟨yap, yaq⟩, ⟨ybp, ybq⟩, ⟨ycp, ycq⟩, ⟨yep, yeq⟩⟩ := y
  simp only [hmul, times4, mul4, Quat.ext_iff', Zd.ext_iff', Zd.sub_p, Zd.sub_q, Zd.add_p, Zd.add_q, zmul_p,
    zmul_q, Zd.mk_p, Zd.mk_q]
  refine ⟨⟨?_, ?_⟩, ⟨?_, ?_⟩, ⟨?_, ?_⟩, ⟨?_, ?_⟩⟩ <;> ring

theorem hmul_one (d : ℤ) (x : Quat) : hmul d x one = times4 x := by
  obtain ⟨⟨xap, xaq⟩, ⟨xbp, xbq⟩, ⟨xcp, xcq⟩, ⟨xep, xeq⟩⟩ := x
  simp only [hmul, one, times4, mul4, Quat.ext_iff', Zd.ext_iff', Zd.sub_p, Zd.sub_q, Zd.add_p, Zd.add_q, zmul_p,
    zmul_q, Zd.mk_p, Zd.mk_q]
  refine ⟨⟨?_, ?_⟩, ⟨?_, ?_⟩, ⟨?_, ?_⟩, ⟨?_, ?_⟩⟩ <;> ring

theorem quarter_times4 (x : Quat) : quarter (times4 x) = x := by
  obtain ⟨⟨xap, xaq⟩, ⟨xbp, xbq⟩, ⟨xcp, xcq⟩, ⟨xep, xeq⟩⟩ := x
  simp only [quarter, times4, div4, mul4, Quat.ext_iff', Zd.ext_iff', Zd.mk_p, Zd.mk_q]
  omega

theorem times4_injective : Function.Injective times4 := by
  intro x y h
  obtain ⟨⟨xap, xaq⟩, ⟨xbp, xbq⟩, ⟨xcp, xcq⟩, ⟨xep, xeq⟩⟩ := x
  obtain ⟨⟨yap, yaq⟩, ⟨ybp, ybq⟩, ⟨ycp, ycq⟩, ⟨yep, yeq⟩⟩ := y
  simp only [times4, mul4, Quat.ext_iff', Zd.ext_iff', Zd.mk_p, Zd.mk_q] at h ⊢
  omega

/-! ## The closure theorem from generators -/

/-- (a) every member times every generator is four times a member -/
def genClosed (d : ℤ) (G S : List Quat) : Bool := G.all (fun x => S.all (fun s => inG G (hmul d x s)))

/-- (b) the list is headed by the identity, and every later member is a generator (on the left) times an earlier
member, exactly: pred i = (j, k) with j < i, G i = quarter (S k * G j) -/
def reachCert (d : ℤ) (G S : List Quat) (pred : List (ℕ × ℕ)) : Bool :=
  decide (G.getD 0 one = one) &&
  (List.range G.length).all (fun i => decide (i = 0) ||
    (decide ((pred.getD i (0, 0)).1 < i) && decide ((pred.getD i (0, 0)).2 < S.length) &&
     decide (times4 (quarter (hmul d (S.getD (pred.getD i (0, 0)).2 one) (G.getD (pred.getD i (0, 0)).1 one)))
       = hmul d (S.getD (pred.getD i (0, 0)).2 one) (G.getD (pred.getD i (0, 0)).1 one)) &&
     decide (G.getD i one
       = quarter (hmul d (S.getD (pred.getD i (0, 0)).2 one) (G.getD (pred.getD i (0, 0)).1 one)))))

/-- THE CLOSURE THEOREM: (a) and (b) make the list closed under the product -- x * y for y = s * y' is (x * s) * y'
by associativity, x * s a member by (a), and y' earlier, so the induction on the member's index closes -/
theorem closed_of_gens (d : ℤ) (G S : List Quat) (pred : List (ℕ × ℕ))
    (hgen : genClosed d G S = true) (hreach : reachCert d G S pred = true) :
    ∀ x ∈ G, ∀ y ∈ G, inG G (hmul d x y) = true := by
  unfold reachCert at hreach
  rw [Bool.and_eq_true, decide_eq_true_eq, List.all_eq_true] at hreach
  obtain ⟨h0, hstep⟩ := hreach
  unfold genClosed at hgen
  rw [List.all_eq_true] at hgen
  have main : ∀ i, i < G.length → ∀ x ∈ G, inG G (hmul d x (G.getD i one)) = true := by
    intro i
    induction i using Nat.strong_induction_on with
    | _ i ih =>
      intro hi x hx
      have hs := hstep i (List.mem_range.mpr hi)
      rw [Bool.or_eq_true, decide_eq_true_eq] at hs
      rcases hs with hi0 | hs
      · subst hi0
        rw [h0, hmul_one]
        unfold inG
        simp [quarter_times4, hx]
      · simp only [Bool.and_eq_true, decide_eq_true_eq] at hs
        obtain ⟨⟨⟨hj, hk⟩, hex⟩, hGi⟩ := hs
        have hsmem : S.getD (pred.getD i (0, 0)).2 one ∈ S := by
          rw [List.getD_eq_getElem _ _ hk]
          exact List.getElem_mem hk
        have hxs := hgen x hx
        rw [List.all_eq_true] at hxs
        have hxs := hxs _ hsmem
        unfold inG at hxs
        rw [Bool.and_eq_true, decide_eq_true_eq, decide_eq_true_eq] at hxs
        obtain ⟨hxs_ex, hxs_mem⟩ := hxs
        have hIH := ih _ hj (by omega) _ hxs_mem
        have e1 : times4 (hmul d x (G.getD i one))
            = hmul d x (hmul d (S.getD (pred.getD i (0, 0)).2 one) (G.getD (pred.getD i (0, 0)).1 one)) := by
          rw [hGi, ← hmul_times4_right, hex]
        have e2 : hmul d x (hmul d (S.getD (pred.getD i (0, 0)).2 one) (G.getD (pred.getD i (0, 0)).1 one))
            = hmul d (times4 (quarter (hmul d x (S.getD (pred.getD i (0, 0)).2 one))))
                (G.getD (pred.getD i (0, 0)).1 one) := by
          rw [← hmul_assoc, hxs_ex]
        have key : times4 (hmul d x (G.getD i one))
            = times4 (hmul d (quarter (hmul d x (S.getD (pred.getD i (0, 0)).2 one)))
                (G.getD (pred.getD i (0, 0)).1 one)) := by
          rw [e1, e2, hmul_times4_left]
        rw [times4_injective key]
        exact hIH
  intro x hx y hy
  obtain ⟨i, hi, rfl⟩ := List.mem_iff_getElem.mp hy
  have := main i hi x hx
  rwa [List.getD_eq_getElem _ _ hi] at this

end Design

end Aperanton
