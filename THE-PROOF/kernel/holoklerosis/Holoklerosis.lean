/-
  ΟΛΟΚΛΗΡΩΣΙΣ -- THE COMPLETION, Ο7: the finite pieces of stages Ο1, Ο2, Ο3, Ο5 and Ο9 restated above the bare Lean 4 kernel.
  No import, no axiom, no sorry, no native_decide: every theorem is proved by `decide`, so the kernel's own reduction is the entire
  verification.  Every literal below was read from a run of record by STDLIB/build/holoklerosis/holoklerosis_lean.sh at emission
  time (the 691 reader's run, the fibre pole's record, the Weyl census, MG2's second road, ΑΘΙΚΤΟΝ's run); the gate re-derives
  this file from those records.  CUSTODY; DO NOT EDIT.  Page DOCS/III-HOLOKLEROSIS-THE-COMPLETION-PREREGISTRATION.md (e6c1349a9).
-/
set_option maxRecDepth 4096

namespace Holoklerosis

/-- Q8 as ΕΛΙΓΜΟΣ indexes it: p*2+s with p in {1, i, j, k} and s the sign; the product by the quaternion rules. -/
def q8mul (a b : Nat) : Nat :=
  let pa := a / 2; let sa := a % 2; let pb := b / 2; let sb := b % 2
  -- the unit table on {1, i, j, k}: the result's unit and its sign
  let r : Nat × Nat :=
    match pa, pb with
    | 0, x => (x, 0) | x, 0 => (x, 0)
    | 1, 1 => (0, 1) | 2, 2 => (0, 1) | 3, 3 => (0, 1)
    | 1, 2 => (3, 0) | 2, 1 => (3, 1)
    | 2, 3 => (1, 0) | 3, 2 => (1, 1)
    | 3, 1 => (2, 0) | 1, 3 => (2, 1)
    | _, _ => (0, 0)
  r.1 * 2 + (sa + sb + r.2) % 2

/-- S3 as permutations of three letters indexed 0..5: (a b c) stored as a*9+b*3+c decoded by index. -/
def s3perm (i : Nat) : Nat × Nat × Nat :=
  match i with
  | 0 => (0, 1, 2) | 1 => (1, 2, 0) | 2 => (2, 0, 1) | 3 => (0, 2, 1) | 4 => (2, 1, 0) | _ => (1, 0, 2)
def s3index (p : Nat × Nat × Nat) : Nat :=
  match p with
  | (0, 1, 2) => 0 | (1, 2, 0) => 1 | (2, 0, 1) => 2 | (0, 2, 1) => 3 | (2, 1, 0) => 4 | _ => 5
def s3mul (a b : Nat) : Nat :=
  let p := s3perm a; let q := s3perm b
  let app := fun (x : Nat) => match x with | 0 => p.1 | 1 => p.2.1 | _ => p.2.2
  s3index (app q.1, app q.2.1, app q.2.2)

/-- the Klein-bottle count: the pairs (a, b) with a^2 b^2 = e, e the index 0, by a two-level fuel recursion -/
def kbRow (mul : Nat → Nat → Nat) (a : Nat) : Nat → Nat
  | 0 => 0
  | b + 1 => (if mul (mul (mul a a) b) b == 0 then 1 else 0) + kbRow mul a b
def kb (mul : Nat → Nat → Nat) (n : Nat) : Nat → Nat
  | 0 => 0
  | a + 1 => kbRow mul a n + kb mul n a

theorem q8_is_a_group_sample : q8mul 2 4 = 6 ∧ q8mul 4 2 = 7 ∧ q8mul 2 2 = 1 := by decide
theorem klein_bottle_q8 : kb q8mul 8 8 = 40 := by decide
theorem klein_bottle_s3 : kb s3mul 6 6 = 18 := by decide

theorem kummer_index_rank16 : 31095 = 691 * 45 := by decide
theorem niemeier_gap_rank24 : 4197825 = 691 * 6075 ∧ 6075 = 3^5 * 5^2 := by decide
theorem ramanujan_seam : 2073 = 3 * 691 := by decide
theorem mass_numerator_divisible : 1027637932586061520960267 = 691 * 1487175010978381361737 := by decide

/-- the first index n >= 1 at which a coefficient exceeds the O(4) count (1 at even n, 0 at odd n) -/
def firstAniso : List Nat → Nat → Nat
  | [], _ => 0
  | c :: rest, n => if n ≥ 1 ∧ c > (if n % 2 == 0 then 1 else 0) then n else firstAniso rest (n + 1)
theorem first_anisotropic_B4 : firstAniso [1, 0, 1, 0, 2, 0, 3, 0, 5, 0, 6, 0, 9, 0, 11, 0, 15, 0, 18, 0, 23, 0, 27, 0, 34] 0 = 4 := by decide
theorem first_anisotropic_D4 : firstAniso [1, 0, 1, 0, 3, 0, 4, 0, 7, 0, 9, 0, 14, 0, 17, 0, 24, 0, 29, 0, 38, 0, 45, 0, 57] 0 = 4 := by decide
theorem first_anisotropic_F4 : firstAniso [1, 0, 1, 0, 1, 0, 2, 0, 3, 0, 3, 0, 5, 0, 6, 0, 7, 0, 9, 0, 11, 0, 12, 0, 16] 0 = 6 := by decide

/-- the remainder of P(z) by z^2 + b z + 1 computed by Horner in the quotient ring: z^2 = -b z - 1; carries (r0, r1) with P = r0 + r1 z -/
def remQuad (b : Int) (cs : List Int) : Int × Int :=
  -- Horner from the top coefficient: (r0, r1) -> (r0, r1) * z + c  with z^2 = -b z - 1:  (r0 + r1 z) z = r0 z + r1 z^2 = -r1 + (r0 - b r1) z
  (cs.reverse).foldl (fun (r : Int × Int) (c : Int) => (c - r.2, r.1 - b * r.2)) (0, 0)
theorem fibre_pole_cosh3 : remQuad 6 [0, 0, 0, 0, 0, 0, 0, 0, -170141183460469231731687303715884105728, 99362451140914031331305385370076317745152, -23064338829901209053547530891725249372487680, 2754320339978798529734516014966366892531384320, -181085654602334352647598109510997397853920296960, 6420140194056057282640043364510857103181552287744, -106556678128465504478449706881911580616286783143936, 331814244482887809537865576923486972612206846279680, 7113425783425261754279537056071945125077851727462400, 331814244482887809537865576923486972612206846279680, -106556678128465504478449706881911580616286783143936, 6420140194056057282640043364510857103181552287744, -181085654602334352647598109510997397853920296960, 2754320339978798529734516014966366892531384320, -23064338829901209053547530891725249372487680, 99362451140914031331305385370076317745152, -170141183460469231731687303715884105728] = (0, 0) := by decide

theorem mg2_su2_pass_at_beta_star : 339810696399316894272676464379313194734 < 2^128 := by decide
theorem mg2_su2_fail_at_next : 340449417570092390796957781843874761944 ≥ 2^128 := by decide

end Holoklerosis
