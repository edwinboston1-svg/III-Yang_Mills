/-
  APERANTON -- THE BOUNDLESS, THE TREK T3 (2026-10-28): THE DESIGN THEOREM -- THE FINITE SUBGROUPS OF SU(2) AS SPHERICAL
  DESIGNS, VERIFIED WHOLE AND TWO-SIDED IN THE KERNEL.  EMITTED by STDLIB/scripts/aperanton_emit_design.sh.

  The binary tetrahedral (24), octahedral (48) and icosahedral (120) groups as explicit unit quaternions with coordinates
  in Z[sqrt 2] and Z[sqrt 5], each pair ⟨p, q⟩ the number p + q sqrt d, EVERY COORDINATE CARRIED FOUR TIMES ITS VALUE so
  that the kernel divides nowhere but by an exact four (DesignCore.lean).  THE GROUP, by DesignCore's closure theorem
  from two LINEAR certificates: (a) every member times every generator is four times a member, (b) the list is headed
  by the identity and every later member is a generator times an earlier member, exactly (the list in the breadth-first
  order of that reach) -- in place of the |G|^2 Cayley table the kernel cannot afford; every element of norm one
  (carried: sixteen) with its conjugate in the list; no repeats; 24 / 48 / 120 -- decided.  THE DESIGN: by
  Delsarte-Goethals-Seidel a finite X in S^3 is a spherical t-design iff the pair sum of the Gegenbauer polynomial
  U_k(<x, y>) vanishes for 1 <= k <= t, and for a group the pair sum is |G| times the sum of U_k at the real parts, so
  the group is a t-design iff the sum over G of U_n(Re g) vanishes for 1 <= n <= t.  That sum is carried as the integer
  recurrence V_n = 4^n U_n(a/4): it vanishes for 1 <= n <= t with t = 5, 7, 11 (BT a 5-design, BO a 7-design, BI an
  11-design on S^3), does NOT vanish at n = t + 1 -- the strength is exact -- and there equals |G| 4^(t+1), the trivial
  representation entering spin (t+1)/2 exactly once (Molien).  U_n at the real part is the SU(2) character of spin n/2,
  so the average over the finite group of any class function whose character expansion stops at spin t/2 IS the Haar
  integral: a finite subgroup is a completion of SU(2) whose residue is the spin tail beyond its strength (T3 of the
  trek).  Classical (Sloane; W = 0); the earning is the exact two-sided instance the ladder BT -> BO -> BI -> SU(2)
  stands on.  No sorry, no axiom, no native_decide.
-/
import Mathlib
import Aperanton.DesignCore

namespace Aperanton

namespace Design

/-- BT: 24 unit quaternions, every coordinate four times its value, in the breadth-first order of the reach -/
def BT : List Quat := [
  ⟨⟨4, 0⟩, ⟨0, 0⟩, ⟨0, 0⟩, ⟨0, 0⟩⟩,
  ⟨⟨0, 0⟩, ⟨4, 0⟩, ⟨0, 0⟩, ⟨0, 0⟩⟩,
  ⟨⟨2, 0⟩, ⟨2, 0⟩, ⟨2, 0⟩, ⟨2, 0⟩⟩,
  ⟨⟨-4, 0⟩, ⟨0, 0⟩, ⟨0, 0⟩, ⟨0, 0⟩⟩,
  ⟨⟨-2, 0⟩, ⟨2, 0⟩, ⟨2, 0⟩, ⟨-2, 0⟩⟩,
  ⟨⟨-2, 0⟩, ⟨2, 0⟩, ⟨-2, 0⟩, ⟨2, 0⟩⟩,
  ⟨⟨-2, 0⟩, ⟨2, 0⟩, ⟨2, 0⟩, ⟨2, 0⟩⟩,
  ⟨⟨0, 0⟩, ⟨-4, 0⟩, ⟨0, 0⟩, ⟨0, 0⟩⟩,
  ⟨⟨-2, 0⟩, ⟨-2, 0⟩, ⟨-2, 0⟩, ⟨-2, 0⟩⟩,
  ⟨⟨-2, 0⟩, ⟨-2, 0⟩, ⟨2, 0⟩, ⟨2, 0⟩⟩,
  ⟨⟨-2, 0⟩, ⟨-2, 0⟩, ⟨2, 0⟩, ⟨-2, 0⟩⟩,
  ⟨⟨-2, 0⟩, ⟨2, 0⟩, ⟨-2, 0⟩, ⟨-2, 0⟩⟩,
  ⟨⟨-2, 0⟩, ⟨-2, 0⟩, ⟨-2, 0⟩, ⟨2, 0⟩⟩,
  ⟨⟨2, 0⟩, ⟨-2, 0⟩, ⟨-2, 0⟩, ⟨2, 0⟩⟩,
  ⟨⟨2, 0⟩, ⟨-2, 0⟩, ⟨2, 0⟩, ⟨-2, 0⟩⟩,
  ⟨⟨2, 0⟩, ⟨-2, 0⟩, ⟨-2, 0⟩, ⟨-2, 0⟩⟩,
  ⟨⟨2, 0⟩, ⟨-2, 0⟩, ⟨2, 0⟩, ⟨2, 0⟩⟩,
  ⟨⟨0, 0⟩, ⟨0, 0⟩, ⟨0, 0⟩, ⟨-4, 0⟩⟩,
  ⟨⟨0, 0⟩, ⟨0, 0⟩, ⟨-4, 0⟩, ⟨0, 0⟩⟩,
  ⟨⟨2, 0⟩, ⟨2, 0⟩, ⟨-2, 0⟩, ⟨-2, 0⟩⟩,
  ⟨⟨2, 0⟩, ⟨2, 0⟩, ⟨-2, 0⟩, ⟨2, 0⟩⟩,
  ⟨⟨2, 0⟩, ⟨2, 0⟩, ⟨2, 0⟩, ⟨-2, 0⟩⟩,
  ⟨⟨0, 0⟩, ⟨0, 0⟩, ⟨0, 0⟩, ⟨4, 0⟩⟩,
  ⟨⟨0, 0⟩, ⟨0, 0⟩, ⟨4, 0⟩, ⟨0, 0⟩⟩
]

/-- the two generators of BT (the first pair in list order that reaches the whole set) -/
def SBT : List Quat := [
  ⟨⟨0, 0⟩, ⟨4, 0⟩, ⟨0, 0⟩, ⟨0, 0⟩⟩,
  ⟨⟨2, 0⟩, ⟨2, 0⟩, ⟨2, 0⟩, ⟨2, 0⟩⟩
]

/-- the reach: member i = generator k times member j, j < i -/
def predBT : List (ℕ × ℕ) := [(0, 0), (0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (3, 0), (3, 1), (4, 0), (4, 1), (5, 1), (6, 0), (7, 1), (8, 0), (8, 1), (10, 0), (11, 1), (12, 1), (13, 0), (13, 1), (15, 0), (16, 1), (17, 0)]

theorem BT_card : BT.length = 24 := by decide +kernel
theorem BT_nodup : BT.Nodup := by decide +kernel
theorem BT_unit : (BT.all (fun x => norm2 2 x = ⟨16, 0⟩)) = true := by decide +kernel
theorem BT_conj : (BT.all (fun x => conj x ∈ BT)) = true := by decide +kernel
/-- (a) every member times every generator is four times a member -/
theorem BT_gen : genClosed 2 BT SBT = true := by decide +kernel
/-- (b) the identity first, every later member a generator times an earlier member, exactly -/
theorem BT_reach : reachCert 2 BT SBT predBT = true := by decide +kernel
/-- THE GROUP: closed under the product, by the closure theorem from (a) and (b) -/
theorem BT_closed : ∀ x ∈ BT, ∀ y ∈ BT, inG BT (hmul 2 x y) = true :=
  closed_of_gens 2 BT SBT predBT BT_gen BT_reach
/-- THE DESIGN: every character of spin 1/2 .. 5/2 sums to zero over BT -/
theorem BT_design : ((List.range 5).all (fun n => charSum 2 BT (n + 1) = ⟨0, 0⟩)) = true := by decide +kernel
/-- and the strength is exact: spin 6/2 does not -/
theorem BT_strength : charSum 2 BT 6 ≠ ⟨0, 0⟩ := by decide +kernel
/-- MOLIEN: at spin 6/2 the trivial representation enters BT exactly once, so the carried sum is |G| 4^6 -/
theorem BT_molien : charSum 2 BT 6 = ⟨98304, 0⟩ := by decide +kernel

/-- BO: 48 unit quaternions, every coordinate four times its value, in the breadth-first order of the reach -/
def BO : List Quat := [
  ⟨⟨4, 0⟩, ⟨0, 0⟩, ⟨0, 0⟩, ⟨0, 0⟩⟩,
  ⟨⟨2, 0⟩, ⟨2, 0⟩, ⟨2, 0⟩, ⟨2, 0⟩⟩,
  ⟨⟨0, 2⟩, ⟨0, 2⟩, ⟨0, 0⟩, ⟨0, 0⟩⟩,
  ⟨⟨-2, 0⟩, ⟨2, 0⟩, ⟨2, 0⟩, ⟨2, 0⟩⟩,
  ⟨⟨0, 0⟩, ⟨0, 2⟩, ⟨0, 0⟩, ⟨0, 2⟩⟩,
  ⟨⟨0, 0⟩, ⟨0, 2⟩, ⟨0, 2⟩, ⟨0, 0⟩⟩,
  ⟨⟨0, 0⟩, ⟨4, 0⟩, ⟨0, 0⟩, ⟨0, 0⟩⟩,
  ⟨⟨-4, 0⟩, ⟨0, 0⟩, ⟨0, 0⟩, ⟨0, 0⟩⟩,
  ⟨⟨0, -2⟩, ⟨0, 0⟩, ⟨0, 0⟩, ⟨0, 2⟩⟩,
  ⟨⟨0, -2⟩, ⟨0, 2⟩, ⟨0, 0⟩, ⟨0, 0⟩⟩,
  ⟨⟨-2, 0⟩, ⟨2, 0⟩, ⟨-2, 0⟩, ⟨2, 0⟩⟩,
  ⟨⟨0, -2⟩, ⟨0, 0⟩, ⟨0, 2⟩, ⟨0, 0⟩⟩,
  ⟨⟨-2, 0⟩, ⟨2, 0⟩, ⟨2, 0⟩, ⟨-2, 0⟩⟩,
  ⟨⟨-2, 0⟩, ⟨-2, 0⟩, ⟨-2, 0⟩, ⟨-2, 0⟩⟩,
  ⟨⟨0, -2⟩, ⟨0, -2⟩, ⟨0, 0⟩, ⟨0, 0⟩⟩,
  ⟨⟨0, -2⟩, ⟨0, 0⟩, ⟨0, -2⟩, ⟨0, 0⟩⟩,
  ⟨⟨-2, 0⟩, ⟨-2, 0⟩, ⟨-2, 0⟩, ⟨2, 0⟩⟩,
  ⟨⟨0, -2⟩, ⟨0, 0⟩, ⟨0, 0⟩, ⟨0, -2⟩⟩,
  ⟨⟨-2, 0⟩, ⟨2, 0⟩, ⟨-2, 0⟩, ⟨-2, 0⟩⟩,
  ⟨⟨-2, 0⟩, ⟨-2, 0⟩, ⟨2, 0⟩, ⟨2, 0⟩⟩,
  ⟨⟨-2, 0⟩, ⟨-2, 0⟩, ⟨2, 0⟩, ⟨-2, 0⟩⟩,
  ⟨⟨2, 0⟩, ⟨-2, 0⟩, ⟨-2, 0⟩, ⟨-2, 0⟩⟩,
  ⟨⟨0, 0⟩, ⟨0, -2⟩, ⟨0, 0⟩, ⟨0, -2⟩⟩,
  ⟨⟨0, 0⟩, ⟨0, -2⟩, ⟨0, -2⟩, ⟨0, 0⟩⟩,
  ⟨⟨0, 0⟩, ⟨-4, 0⟩, ⟨0, 0⟩, ⟨0, 0⟩⟩,
  ⟨⟨0, 0⟩, ⟨0, 0⟩, ⟨0, -2⟩, ⟨0, -2⟩⟩,
  ⟨⟨0, 0⟩, ⟨0, 0⟩, ⟨-4, 0⟩, ⟨0, 0⟩⟩,
  ⟨⟨0, 0⟩, ⟨0, 0⟩, ⟨0, 0⟩, ⟨-4, 0⟩⟩,
  ⟨⟨0, 0⟩, ⟨0, -2⟩, ⟨0, 0⟩, ⟨0, 2⟩⟩,
  ⟨⟨0, 0⟩, ⟨0, -2⟩, ⟨0, 2⟩, ⟨0, 0⟩⟩,
  ⟨⟨0, 2⟩, ⟨0, 0⟩, ⟨0, 0⟩, ⟨0, -2⟩⟩,
  ⟨⟨0, 2⟩, ⟨0, -2⟩, ⟨0, 0⟩, ⟨0, 0⟩⟩,
  ⟨⟨2, 0⟩, ⟨-2, 0⟩, ⟨2, 0⟩, ⟨-2, 0⟩⟩,
  ⟨⟨0, 2⟩, ⟨0, 0⟩, ⟨0, -2⟩, ⟨0, 0⟩⟩,
  ⟨⟨2, 0⟩, ⟨-2, 0⟩, ⟨-2, 0⟩, ⟨2, 0⟩⟩,
  ⟨⟨2, 0⟩, ⟨2, 0⟩, ⟨-2, 0⟩, ⟨-2, 0⟩⟩,
  ⟨⟨0, 0⟩, ⟨0, 0⟩, ⟨0, 2⟩, ⟨0, -2⟩⟩,
  ⟨⟨0, 0⟩, ⟨0, 0⟩, ⟨0, -2⟩, ⟨0, 2⟩⟩,
  ⟨⟨2, 0⟩, ⟨-2, 0⟩, ⟨2, 0⟩, ⟨2, 0⟩⟩,
  ⟨⟨0, 2⟩, ⟨0, 0⟩, ⟨0, 2⟩, ⟨0, 0⟩⟩,
  ⟨⟨2, 0⟩, ⟨2, 0⟩, ⟨2, 0⟩, ⟨-2, 0⟩⟩,
  ⟨⟨0, 2⟩, ⟨0, 0⟩, ⟨0, 0⟩, ⟨0, 2⟩⟩,
  ⟨⟨2, 0⟩, ⟨2, 0⟩, ⟨-2, 0⟩, ⟨2, 0⟩⟩,
  ⟨⟨0, 0⟩, ⟨0, 2⟩, ⟨0, 0⟩, ⟨0, -2⟩⟩,
  ⟨⟨0, 0⟩, ⟨0, 0⟩, ⟨4, 0⟩, ⟨0, 0⟩⟩,
  ⟨⟨0, 0⟩, ⟨0, 2⟩, ⟨0, -2⟩, ⟨0, 0⟩⟩,
  ⟨⟨0, 0⟩, ⟨0, 0⟩, ⟨0, 0⟩, ⟨4, 0⟩⟩,
  ⟨⟨0, 0⟩, ⟨0, 0⟩, ⟨0, 2⟩, ⟨0, 2⟩⟩
]

/-- the two generators of BO (the first pair in list order that reaches the whole set) -/
def SBO : List Quat := [
  ⟨⟨2, 0⟩, ⟨2, 0⟩, ⟨2, 0⟩, ⟨2, 0⟩⟩,
  ⟨⟨0, 2⟩, ⟨0, 2⟩, ⟨0, 0⟩, ⟨0, 0⟩⟩
]

/-- the reach: member i = generator k times member j, j < i -/
def predBO : List (ℕ × ℕ) := [(0, 0), (0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (3, 0), (3, 1), (4, 0), (4, 1), (5, 0), (6, 0), (7, 0), (7, 1), (8, 0), (8, 1), (9, 0), (10, 0), (11, 1), (12, 0), (13, 0), (13, 1), (14, 0), (14, 1), (15, 0), (16, 0), (18, 0), (19, 1), (20, 1), (21, 1), (22, 0), (22, 1), (23, 0), (24, 0), (26, 0), (27, 1), (28, 0), (29, 1), (30, 0), (30, 1), (31, 0), (34, 0), (35, 1), (36, 1), (37, 0), (38, 0), (39, 0)]

theorem BO_card : BO.length = 48 := by decide +kernel
theorem BO_nodup : BO.Nodup := by decide +kernel
theorem BO_unit : (BO.all (fun x => norm2 2 x = ⟨16, 0⟩)) = true := by decide +kernel
theorem BO_conj : (BO.all (fun x => conj x ∈ BO)) = true := by decide +kernel
/-- (a) every member times every generator is four times a member -/
theorem BO_gen : genClosed 2 BO SBO = true := by decide +kernel
/-- (b) the identity first, every later member a generator times an earlier member, exactly -/
theorem BO_reach : reachCert 2 BO SBO predBO = true := by decide +kernel
/-- THE GROUP: closed under the product, by the closure theorem from (a) and (b) -/
theorem BO_closed : ∀ x ∈ BO, ∀ y ∈ BO, inG BO (hmul 2 x y) = true :=
  closed_of_gens 2 BO SBO predBO BO_gen BO_reach
/-- THE DESIGN: every character of spin 1/2 .. 7/2 sums to zero over BO -/
theorem BO_design : ((List.range 7).all (fun n => charSum 2 BO (n + 1) = ⟨0, 0⟩)) = true := by decide +kernel
/-- and the strength is exact: spin 8/2 does not -/
theorem BO_strength : charSum 2 BO 8 ≠ ⟨0, 0⟩ := by decide +kernel
/-- MOLIEN: at spin 8/2 the trivial representation enters BO exactly once, so the carried sum is |G| 4^8 -/
theorem BO_molien : charSum 2 BO 8 = ⟨3145728, 0⟩ := by decide +kernel

/-- BI: 120 unit quaternions, every coordinate four times its value, in the breadth-first order of the reach -/
def BI : List Quat := [
  ⟨⟨4, 0⟩, ⟨0, 0⟩, ⟨0, 0⟩, ⟨0, 0⟩⟩,
  ⟨⟨0, 0⟩, ⟨4, 0⟩, ⟨0, 0⟩, ⟨0, 0⟩⟩,
  ⟨⟨1, 1⟩, ⟨2, 0⟩, ⟨-1, 1⟩, ⟨0, 0⟩⟩,
  ⟨⟨-4, 0⟩, ⟨0, 0⟩, ⟨0, 0⟩, ⟨0, 0⟩⟩,
  ⟨⟨-2, 0⟩, ⟨1, 1⟩, ⟨0, 0⟩, ⟨1, -1⟩⟩,
  ⟨⟨-2, 0⟩, ⟨1, 1⟩, ⟨0, 0⟩, ⟨-1, 1⟩⟩,
  ⟨⟨-1, 1⟩, ⟨1, 1⟩, ⟨2, 0⟩, ⟨0, 0⟩⟩,
  ⟨⟨0, 0⟩, ⟨-4, 0⟩, ⟨0, 0⟩, ⟨0, 0⟩⟩,
  ⟨⟨-1, -1⟩, ⟨-2, 0⟩, ⟨1, -1⟩, ⟨0, 0⟩⟩,
  ⟨⟨-1, -1⟩, ⟨-2, 0⟩, ⟨-1, 1⟩, ⟨0, 0⟩⟩,
  ⟨⟨-1, -1⟩, ⟨-1, 1⟩, ⟨0, 0⟩, ⟨-2, 0⟩⟩,
  ⟨⟨-1, -1⟩, ⟨2, 0⟩, ⟨1, -1⟩, ⟨0, 0⟩⟩,
  ⟨⟨-1, -1⟩, ⟨-1, 1⟩, ⟨0, 0⟩, ⟨2, 0⟩⟩,
  ⟨⟨1, -1⟩, ⟨1, 1⟩, ⟨2, 0⟩, ⟨0, 0⟩⟩,
  ⟨⟨2, 0⟩, ⟨-1, -1⟩, ⟨0, 0⟩, ⟨-1, 1⟩⟩,
  ⟨⟨2, 0⟩, ⟨-1, -1⟩, ⟨0, 0⟩, ⟨1, -1⟩⟩,
  ⟨⟨1, -1⟩, ⟨-1, -1⟩, ⟨-2, 0⟩, ⟨0, 0⟩⟩,
  ⟨⟨-2, 0⟩, ⟨-1, -1⟩, ⟨0, 0⟩, ⟨-1, 1⟩⟩,
  ⟨⟨1, -1⟩, ⟨-1, -1⟩, ⟨2, 0⟩, ⟨0, 0⟩⟩,
  ⟨⟨-1, -1⟩, ⟨1, -1⟩, ⟨0, 0⟩, ⟨-2, 0⟩⟩,
  ⟨⟨-2, 0⟩, ⟨-1, -1⟩, ⟨0, 0⟩, ⟨1, -1⟩⟩,
  ⟨⟨-1, -1⟩, ⟨0, 0⟩, ⟨-2, 0⟩, ⟨1, -1⟩⟩,
  ⟨⟨-1, -1⟩, ⟨0, 0⟩, ⟨-2, 0⟩, ⟨-1, 1⟩⟩,
  ⟨⟨-1, -1⟩, ⟨1, -1⟩, ⟨0, 0⟩, ⟨2, 0⟩⟩,
  ⟨⟨-1, -1⟩, ⟨2, 0⟩, ⟨-1, 1⟩, ⟨0, 0⟩⟩,
  ⟨⟨1, 1⟩, ⟨2, 0⟩, ⟨1, -1⟩, ⟨0, 0⟩⟩,
  ⟨⟨1, 1⟩, ⟨1, -1⟩, ⟨0, 0⟩, ⟨2, 0⟩⟩,
  ⟨⟨1, 1⟩, ⟨-2, 0⟩, ⟨-1, 1⟩, ⟨0, 0⟩⟩,
  ⟨⟨1, 1⟩, ⟨1, -1⟩, ⟨0, 0⟩, ⟨-2, 0⟩⟩,
  ⟨⟨-1, 1⟩, ⟨-1, -1⟩, ⟨-2, 0⟩, ⟨0, 0⟩⟩,
  ⟨⟨1, 1⟩, ⟨-2, 0⟩, ⟨1, -1⟩, ⟨0, 0⟩⟩,
  ⟨⟨0, 0⟩, ⟨-1, -1⟩, ⟨1, -1⟩, ⟨2, 0⟩⟩,
  ⟨⟨0, 0⟩, ⟨-1, -1⟩, ⟨-1, 1⟩, ⟨2, 0⟩⟩,
  ⟨⟨-1, 1⟩, ⟨-1, -1⟩, ⟨2, 0⟩, ⟨0, 0⟩⟩,
  ⟨⟨0, 0⟩, ⟨-1, -1⟩, ⟨-1, 1⟩, ⟨-2, 0⟩⟩,
  ⟨⟨-2, 0⟩, ⟨-2, 0⟩, ⟨-2, 0⟩, ⟨-2, 0⟩⟩,
  ⟨⟨0, 0⟩, ⟨-1, -1⟩, ⟨1, -1⟩, ⟨-2, 0⟩⟩,
  ⟨⟨-2, 0⟩, ⟨1, -1⟩, ⟨-1, -1⟩, ⟨0, 0⟩⟩,
  ⟨⟨-2, 0⟩, ⟨-2, 0⟩, ⟨-2, 0⟩, ⟨2, 0⟩⟩,
  ⟨⟨2, 0⟩, ⟨1, 1⟩, ⟨0, 0⟩, ⟨1, -1⟩⟩,
  ⟨⟨-1, 1⟩, ⟨1, 1⟩, ⟨-2, 0⟩, ⟨0, 0⟩⟩,
  ⟨⟨1, 1⟩, ⟨-1, 1⟩, ⟨0, 0⟩, ⟨2, 0⟩⟩,
  ⟨⟨2, 0⟩, ⟨1, 1⟩, ⟨0, 0⟩, ⟨-1, 1⟩⟩,
  ⟨⟨1, 1⟩, ⟨0, 0⟩, ⟨2, 0⟩, ⟨-1, 1⟩⟩,
  ⟨⟨1, 1⟩, ⟨0, 0⟩, ⟨2, 0⟩, ⟨1, -1⟩⟩,
  ⟨⟨1, 1⟩, ⟨-1, 1⟩, ⟨0, 0⟩, ⟨-2, 0⟩⟩,
  ⟨⟨1, 1⟩, ⟨0, 0⟩, ⟨-2, 0⟩, ⟨1, -1⟩⟩,
  ⟨⟨2, 0⟩, ⟨-2, 0⟩, ⟨-2, 0⟩, ⟨2, 0⟩⟩,
  ⟨⟨1, 1⟩, ⟨0, 0⟩, ⟨-2, 0⟩, ⟨-1, 1⟩⟩,
  ⟨⟨-1, 1⟩, ⟨-2, 0⟩, ⟨0, 0⟩, ⟨1, 1⟩⟩,
  ⟨⟨2, 0⟩, ⟨-2, 0⟩, ⟨2, 0⟩, ⟨2, 0⟩⟩,
  ⟨⟨2, 0⟩, ⟨-2, 0⟩, ⟨2, 0⟩, ⟨-2, 0⟩⟩,
  ⟨⟨-1, 1⟩, ⟨-2, 0⟩, ⟨0, 0⟩, ⟨-1, -1⟩⟩,
  ⟨⟨0, 0⟩, ⟨-2, 0⟩, ⟨-1, -1⟩, ⟨1, -1⟩⟩,
  ⟨⟨2, 0⟩, ⟨-2, 0⟩, ⟨-2, 0⟩, ⟨-2, 0⟩⟩,
  ⟨⟨0, 0⟩, ⟨-2, 0⟩, ⟨-1, -1⟩, ⟨-1, 1⟩⟩,
  ⟨⟨0, 0⟩, ⟨1, 1⟩, ⟨-1, 1⟩, ⟨-2, 0⟩⟩,
  ⟨⟨0, 0⟩, ⟨1, 1⟩, ⟨1, -1⟩, ⟨-2, 0⟩⟩,
  ⟨⟨1, -1⟩, ⟨1, 1⟩, ⟨-2, 0⟩, ⟨0, 0⟩⟩,
  ⟨⟨0, 0⟩, ⟨1, 1⟩, ⟨1, -1⟩, ⟨2, 0⟩⟩,
  ⟨⟨2, 0⟩, ⟨2, 0⟩, ⟨2, 0⟩, ⟨2, 0⟩⟩,
  ⟨⟨0, 0⟩, ⟨1, 1⟩, ⟨-1, 1⟩, ⟨2, 0⟩⟩,
  ⟨⟨2, 0⟩, ⟨-1, 1⟩, ⟨1, 1⟩, ⟨0, 0⟩⟩,
  ⟨⟨2, 0⟩, ⟨2, 0⟩, ⟨2, 0⟩, ⟨-2, 0⟩⟩,
  ⟨⟨2, 0⟩, ⟨2, 0⟩, ⟨-2, 0⟩, ⟨-2, 0⟩⟩,
  ⟨⟨2, 0⟩, ⟨-1, 1⟩, ⟨-1, -1⟩, ⟨0, 0⟩⟩,
  ⟨⟨2, 0⟩, ⟨0, 0⟩, ⟨1, -1⟩, ⟨1, 1⟩⟩,
  ⟨⟨2, 0⟩, ⟨2, 0⟩, ⟨-2, 0⟩, ⟨2, 0⟩⟩,
  ⟨⟨2, 0⟩, ⟨0, 0⟩, ⟨-1, 1⟩, ⟨1, 1⟩⟩,
  ⟨⟨2, 0⟩, ⟨1, -1⟩, ⟨1, 1⟩, ⟨0, 0⟩⟩,
  ⟨⟨2, 0⟩, ⟨0, 0⟩, ⟨-1, 1⟩, ⟨-1, -1⟩⟩,
  ⟨⟨2, 0⟩, ⟨0, 0⟩, ⟨1, -1⟩, ⟨-1, -1⟩⟩,
  ⟨⟨2, 0⟩, ⟨1, -1⟩, ⟨-1, -1⟩, ⟨0, 0⟩⟩,
  ⟨⟨-1, -1⟩, ⟨0, 0⟩, ⟨2, 0⟩, ⟨-1, 1⟩⟩,
  ⟨⟨-2, 0⟩, ⟨2, 0⟩, ⟨2, 0⟩, ⟨-2, 0⟩⟩,
  ⟨⟨-1, -1⟩, ⟨0, 0⟩, ⟨2, 0⟩, ⟨1, -1⟩⟩,
  ⟨⟨1, -1⟩, ⟨2, 0⟩, ⟨0, 0⟩, ⟨-1, -1⟩⟩,
  ⟨⟨-2, 0⟩, ⟨2, 0⟩, ⟨-2, 0⟩, ⟨-2, 0⟩⟩,
  ⟨⟨-2, 0⟩, ⟨2, 0⟩, ⟨-2, 0⟩, ⟨2, 0⟩⟩,
  ⟨⟨1, -1⟩, ⟨2, 0⟩, ⟨0, 0⟩, ⟨1, 1⟩⟩,
  ⟨⟨0, 0⟩, ⟨2, 0⟩, ⟨1, 1⟩, ⟨-1, 1⟩⟩,
  ⟨⟨-2, 0⟩, ⟨2, 0⟩, ⟨2, 0⟩, ⟨2, 0⟩⟩,
  ⟨⟨0, 0⟩, ⟨2, 0⟩, ⟨1, 1⟩, ⟨1, -1⟩⟩,
  ⟨⟨-1, 1⟩, ⟨2, 0⟩, ⟨0, 0⟩, ⟨-1, -1⟩⟩,
  ⟨⟨0, 0⟩, ⟨2, 0⟩, ⟨-1, -1⟩, ⟨1, -1⟩⟩,
  ⟨⟨0, 0⟩, ⟨2, 0⟩, ⟨-1, -1⟩, ⟨-1, 1⟩⟩,
  ⟨⟨-1, 1⟩, ⟨2, 0⟩, ⟨0, 0⟩, ⟨1, 1⟩⟩,
  ⟨⟨-1, 1⟩, ⟨0, 0⟩, ⟨1, 1⟩, ⟨2, 0⟩⟩,
  ⟨⟨-1, 1⟩, ⟨0, 0⟩, ⟨1, 1⟩, ⟨-2, 0⟩⟩,
  ⟨⟨-2, 0⟩, ⟨-2, 0⟩, ⟨2, 0⟩, ⟨2, 0⟩⟩,
  ⟨⟨-2, 0⟩, ⟨1, -1⟩, ⟨1, 1⟩, ⟨0, 0⟩⟩,
  ⟨⟨-2, 0⟩, ⟨0, 0⟩, ⟨-1, 1⟩, ⟨-1, -1⟩⟩,
  ⟨⟨-2, 0⟩, ⟨-2, 0⟩, ⟨2, 0⟩, ⟨-2, 0⟩⟩,
  ⟨⟨-2, 0⟩, ⟨0, 0⟩, ⟨1, -1⟩, ⟨-1, -1⟩⟩,
  ⟨⟨-2, 0⟩, ⟨-1, 1⟩, ⟨-1, -1⟩, ⟨0, 0⟩⟩,
  ⟨⟨-2, 0⟩, ⟨0, 0⟩, ⟨1, -1⟩, ⟨1, 1⟩⟩,
  ⟨⟨-2, 0⟩, ⟨0, 0⟩, ⟨-1, 1⟩, ⟨1, 1⟩⟩,
  ⟨⟨-2, 0⟩, ⟨-1, 1⟩, ⟨1, 1⟩, ⟨0, 0⟩⟩,
  ⟨⟨0, 0⟩, ⟨-1, 1⟩, ⟨2, 0⟩, ⟨-1, -1⟩⟩,
  ⟨⟨0, 0⟩, ⟨-1, 1⟩, ⟨-2, 0⟩, ⟨-1, -1⟩⟩,
  ⟨⟨0, 0⟩, ⟨-1, 1⟩, ⟨-2, 0⟩, ⟨1, 1⟩⟩,
  ⟨⟨0, 0⟩, ⟨-1, 1⟩, ⟨2, 0⟩, ⟨1, 1⟩⟩,
  ⟨⟨0, 0⟩, ⟨0, 0⟩, ⟨4, 0⟩, ⟨0, 0⟩⟩,
  ⟨⟨1, -1⟩, ⟨-2, 0⟩, ⟨0, 0⟩, ⟨1, 1⟩⟩,
  ⟨⟨0, 0⟩, ⟨-2, 0⟩, ⟨1, 1⟩, ⟨-1, 1⟩⟩,
  ⟨⟨0, 0⟩, ⟨-2, 0⟩, ⟨1, 1⟩, ⟨1, -1⟩⟩,
  ⟨⟨1, -1⟩, ⟨-2, 0⟩, ⟨0, 0⟩, ⟨-1, -1⟩⟩,
  ⟨⟨1, -1⟩, ⟨0, 0⟩, ⟨-1, -1⟩, ⟨-2, 0⟩⟩,
  ⟨⟨1, -1⟩, ⟨0, 0⟩, ⟨-1, -1⟩, ⟨2, 0⟩⟩,
  ⟨⟨1, -1⟩, ⟨0, 0⟩, ⟨1, 1⟩, ⟨2, 0⟩⟩,
  ⟨⟨1, -1⟩, ⟨0, 0⟩, ⟨1, 1⟩, ⟨-2, 0⟩⟩,
  ⟨⟨0, 0⟩, ⟨0, 0⟩, ⟨0, 0⟩, ⟨-4, 0⟩⟩,
  ⟨⟨0, 0⟩, ⟨0, 0⟩, ⟨0, 0⟩, ⟨4, 0⟩⟩,
  ⟨⟨0, 0⟩, ⟨1, -1⟩, ⟨-2, 0⟩, ⟨1, 1⟩⟩,
  ⟨⟨0, 0⟩, ⟨1, -1⟩, ⟨2, 0⟩, ⟨1, 1⟩⟩,
  ⟨⟨0, 0⟩, ⟨1, -1⟩, ⟨2, 0⟩, ⟨-1, -1⟩⟩,
  ⟨⟨0, 0⟩, ⟨1, -1⟩, ⟨-2, 0⟩, ⟨-1, -1⟩⟩,
  ⟨⟨0, 0⟩, ⟨0, 0⟩, ⟨-4, 0⟩, ⟨0, 0⟩⟩,
  ⟨⟨-1, 1⟩, ⟨0, 0⟩, ⟨-1, -1⟩, ⟨-2, 0⟩⟩,
  ⟨⟨-1, 1⟩, ⟨0, 0⟩, ⟨-1, -1⟩, ⟨2, 0⟩⟩
]

/-- the two generators of BI (the first pair in list order that reaches the whole set) -/
def SBI : List Quat := [
  ⟨⟨0, 0⟩, ⟨4, 0⟩, ⟨0, 0⟩, ⟨0, 0⟩⟩,
  ⟨⟨1, 1⟩, ⟨2, 0⟩, ⟨-1, 1⟩, ⟨0, 0⟩⟩
]

/-- the reach: member i = generator k times member j, j < i -/
def predBI : List (ℕ × ℕ) := [(0, 0), (0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (3, 0), (3, 1), (4, 0), (4, 1), (5, 1), (6, 0), (6, 1), (7, 1), (8, 0), (8, 1), (9, 1), (10, 0), (10, 1), (11, 0), (11, 1), (12, 1), (13, 0), (13, 1), (14, 0), (14, 1), (15, 1), (16, 0), (16, 1), (17, 0), (17, 1), (18, 1), (19, 0), (21, 0), (21, 1), (22, 0), (22, 1), (23, 1), (25, 1), (26, 0), (26, 1), (27, 0), (27, 1), (28, 1), (29, 0), (31, 0), (31, 1), (32, 0), (32, 1), (33, 1), (35, 0), (37, 0), (37, 1), (38, 0), (38, 1), (39, 1), (40, 1), (41, 0), (43, 0), (43, 1), (44, 0), (44, 1), (45, 1), (47, 0), (49, 0), (49, 1), (50, 0), (50, 1), (51, 1), (53, 0), (55, 0), (55, 1), (56, 0), (56, 1), (57, 0), (57, 1), (58, 1), (60, 0), (62, 0), (62, 1), (63, 0), (63, 1), (64, 1), (66, 0), (68, 0), (68, 1), (69, 1), (70, 1), (74, 0), (76, 0), (76, 1), (77, 0), (77, 1), (78, 1), (80, 0), (82, 0), (82, 1), (83, 1), (84, 1), (87, 0), (87, 1), (88, 1), (89, 1), (91, 0), (93, 0), (93, 1), (94, 1), (95, 1), (98, 0), (98, 1), (99, 1), (102, 0), (103, 1), (104, 1), (107, 0), (107, 1), (108, 1), (113, 0), (113, 1)]

theorem BI_card : BI.length = 120 := by decide +kernel
theorem BI_nodup : BI.Nodup := by decide +kernel
theorem BI_unit : (BI.all (fun x => norm2 5 x = ⟨16, 0⟩)) = true := by decide +kernel
theorem BI_conj : (BI.all (fun x => conj x ∈ BI)) = true := by decide +kernel
/-- (a) every member times every generator is four times a member -/
theorem BI_gen : genClosed 5 BI SBI = true := by decide +kernel
/-- (b) the identity first, every later member a generator times an earlier member, exactly -/
theorem BI_reach : reachCert 5 BI SBI predBI = true := by decide +kernel
/-- THE GROUP: closed under the product, by the closure theorem from (a) and (b) -/
theorem BI_closed : ∀ x ∈ BI, ∀ y ∈ BI, inG BI (hmul 5 x y) = true :=
  closed_of_gens 5 BI SBI predBI BI_gen BI_reach
/-- THE DESIGN: every character of spin 1/2 .. 11/2 sums to zero over BI -/
theorem BI_design : ((List.range 11).all (fun n => charSum 5 BI (n + 1) = ⟨0, 0⟩)) = true := by decide +kernel
/-- and the strength is exact: spin 12/2 does not -/
theorem BI_strength : charSum 5 BI 12 ≠ ⟨0, 0⟩ := by decide +kernel
/-- MOLIEN: at spin 12/2 the trivial representation enters BI exactly once, so the carried sum is |G| 4^12 -/
theorem BI_molien : charSum 5 BI 12 = ⟨2013265920, 0⟩ := by decide +kernel

end Design

end Aperanton
