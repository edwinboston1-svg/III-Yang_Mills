#!/usr/bin/env bash
# holoklerosis_lean.sh -- ΟΛΟΚΛΗΡΩΣΙΣ Ο7, THE FINITE PIECES IN THE STRANGER'S KERNEL.  Emits STDLIB/certs/holoklerosis/Holoklerosis.lean
# (CUSTODY: generated from the stages' records, every literal read from a record and never typed; a missing record REFUSES the emission)
# above the BARE Lean 4 kernel -- no import, no axiom, no sorry, no native_decide, `decide` the only proof term, exactly ΕΞΟΔΟΣ' route --
# and checks it with `lean`, printing KERNEL-ACCEPTED or KERNEL-REFUSED with the error count.  The pieces:
#   (1) the Klein-bottle counts of Ο2 as kernel enumerations over the group tables of Q8 and S3 read from ΑΘΙΚΤΟΝ's run (the tables
#       themselves rebuilt here from the groups' rules -- Q8 as unit quaternions on the index p*2+s of ΕΛΙΓΜΟΣ, S3 as permutations);
#   (2) the 691 identities of Ο9 as Nat equalities, the mass numerator's divisibility included (the kernel's GMP arithmetic);
#   (3) the first anisotropic degrees of Ο3 as list computations on the coefficient lists read from the Weyl record;
#   (4) the fibre's exact pole of Ο1: the quadratic z^2 + 6 z + 1 divides the determinant whose integer coefficients are read from the
#       fibre record, the synthetic division re-run by the kernel over Int;
#   (5) MG2's inequality of Ο5 at SU(2) as the integer comparisons alpha_hi(beta*) < 2^128 and alpha_lo(beta* + 1e-4) >= 2^128 on the grid
#       integers read from the MG2 record.
# A forged literal (one digit of the mass numerator) must be KERNEL-REFUSED (the sighted control, run beside the artifact).
# Page DOCS/III-HOLOKLEROSIS-THE-COMPLETION-PREREGISTRATION.md (e6c1349a9), Ο7.
#   usage: holoklerosis_lean.sh [emit|check|forge]   (emit writes the artifact; check runs lean on it; forge runs the bent copy)
set -u
ROOT="${HLK_ROOT:-$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)}"; cd "$ROOT" || exit 9
B="STDLIB/build/holoklerosis"; ART="${HLK_LEAN_OUT:-STDLIB/certs/holoklerosis/Holoklerosis.lean}"; mkdir -p "$(dirname "$ART")"   # HLK_LEAN_OUT: a mutant emits beside the organ, never over the artifact
R691="$B/h691.run1.txt"; RFP="$B/fibre_pole.2026-11-02a.txt"; RWY="$B/weyl_molien.2026-11-02a.txt"; RMG="$B/mg2_cert.2026-11-02a.txt"; RAK="STDLIB/build/athikton/run.txt"
MODE="${1:-emit}"
CR=$(printf '\r')
need(){ [ -f "$1" ] || { echo "LN-REFUSED: record absent: $1"; exit 2; }; }
emit(){
  for f in "$R691" "$RFP" "$RWY" "$RMG" "$RAK"; do need "$f"; done
  NUM=$(tr -d "$CR" < "$R691" | grep -E '^H691-CELL C9 ' | grep -oE 'numerator=[0-9]+' | head -1 | cut -d= -f2); COF=$(tr -d "$CR" < "$R691" | grep -E '^H691-CELL C9 ' | grep -oE 'cofactor=[0-9]+' | head -1 | cut -d= -f2)
  GAP=$(tr -d "$CR" < "$R691" | grep -oE 'e1=[0-9]+' | head -1 | cut -d= -f2); MU=$(tr -d "$CR" < "$R691" | grep -oE ' mu=[0-9]+' | head -1 | cut -d= -f2); SEAM=$(tr -d "$CR" < "$R691" | grep -oE 'seam=[0-9]+' | head -1 | cut -d= -f2)
  [ -n "$NUM" ] && [ -n "$COF" ] && [ -n "$GAP" ] && [ -n "$MU" ] && [ -n "$SEAM" ] || { echo "LN-REFUSED: the 691 record lacks a literal"; exit 2; }
  COEF=$(tr -d "$CR" < "$RFP" | grep -E '^FP-COEFFS Kperp=\(0,0,0\) m2=0/1 ' | head -1 | sed 's/.*coefficients=//')
  [ -n "$COEF" ] || { echo "LN-REFUSED: the fibre record lacks the coefficients at Kperp = 0"; exit 2; }
  WB4=$(tr -d "$CR" < "$RWY" | grep -E '^WY-SERIES group=B4 ' | sed 's/.*coefficients=//; s/ product-met.*//'); WD4=$(tr -d "$CR" < "$RWY" | grep -E '^WY-SERIES group=D4 ' | sed 's/.*coefficients=//; s/ product-met.*//'); WF4=$(tr -d "$CR" < "$RWY" | grep -E '^WY-SERIES group=F4 ' | sed 's/.*coefficients=//; s/ product-met.*//')
  [ -n "$WB4" ] && [ -n "$WD4" ] && [ -n "$WF4" ] || { echo "LN-REFUSED: the Weyl record lacks a series"; exit 2; }
  AH=$(tr -d "$CR" < "$RMG" | grep -E '^MG-GRID group=SU\(2\) ' | grep -oE 'alpha_hi_at_beta\*=[0-9]+' | cut -d= -f2); ALN=$(tr -d "$CR" < "$RMG" | grep -E '^MG-GRID group=SU\(2\) ' | grep -oE 'alpha_lo_at_next=[0-9]+' | cut -d= -f2)
  [ -n "$AH" ] && [ -n "$ALN" ] || { echo "LN-REFUSED: the MG2 record lacks SU(2)'s grid integers"; exit 2; }
  KQ8=$(tr -d "$CR" < "$RAK" | grep -E '^AKTNHOM Q8 +k=2 ' | grep -oE 'BRUTE=[0-9]+' | cut -d= -f2); KS3=$(tr -d "$CR" < "$RAK" | grep -E '^AKTNHOM S3 +k=2 ' | grep -oE 'BRUTE=[0-9]+' | cut -d= -f2)
  [ -n "$KQ8" ] && [ -n "$KS3" ] || { echo "LN-REFUSED: ΑΘΙΚΤΟΝ's run lacks the Klein-bottle counts"; exit 2; }
  lean_list(){ printf '[%s]' "$(printf '%s' "$1" | sed 's/,/, /g')"; }
  cat > "$ART" <<EOF
/-
  ΟΛΟΚΛΗΡΩΣΙΣ -- THE COMPLETION, Ο7: the finite pieces of stages Ο1, Ο2, Ο3, Ο5 and Ο9 restated above the bare Lean 4 kernel.
  No import, no axiom, no sorry, no native_decide: every theorem is proved by \`decide\`, so the kernel's own reduction is the entire
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
theorem klein_bottle_q8 : kb q8mul 8 8 = $KQ8 := by decide
theorem klein_bottle_s3 : kb s3mul 6 6 = $KS3 := by decide

theorem kummer_index_rank16 : $GAP = 691 * 45 := by decide
theorem niemeier_gap_rank24 : $MU = 691 * 6075 ∧ 6075 = 3^5 * 5^2 := by decide
theorem ramanujan_seam : $SEAM = 3 * 691 := by decide
theorem mass_numerator_divisible : $NUM = 691 * $COF := by decide

/-- the first index n >= 1 at which a coefficient exceeds the O(4) count (1 at even n, 0 at odd n) -/
def firstAniso : List Nat → Nat → Nat
  | [], _ => 0
  | c :: rest, n => if n ≥ 1 ∧ c > (if n % 2 == 0 then 1 else 0) then n else firstAniso rest (n + 1)
theorem first_anisotropic_B4 : firstAniso $(lean_list "$WB4") 0 = 4 := by decide
theorem first_anisotropic_D4 : firstAniso $(lean_list "$WD4") 0 = 4 := by decide
theorem first_anisotropic_F4 : firstAniso $(lean_list "$WF4") 0 = 6 := by decide

/-- the remainder of P(z) by z^2 + b z + 1 computed by Horner in the quotient ring: z^2 = -b z - 1; carries (r0, r1) with P = r0 + r1 z -/
def remQuad (b : Int) (cs : List Int) : Int × Int :=
  -- Horner from the top coefficient: (r0, r1) -> (r0, r1) * z + c  with z^2 = -b z - 1:  (r0 + r1 z) z = r0 z + r1 z^2 = -r1 + (r0 - b r1) z
  (cs.reverse).foldl (fun (r : Int × Int) (c : Int) => (c - r.2, r.1 - b * r.2)) (0, 0)
theorem fibre_pole_cosh3 : remQuad 6 $(lean_list "$COEF") = (0, 0) := by decide

theorem mg2_su2_pass_at_beta_star : $AH < 2^128 := by decide
theorem mg2_su2_fail_at_next : $ALN ≥ 2^128 := by decide

end Holoklerosis
EOF
  echo "LN-EMITTED $ART theorems=$(grep -c '^theorem ' "$ART") literals: numerator=$NUM cofactor=$COF e1=$GAP mu=$MU seam=$SEAM klein=Q8:$KQ8,S3:$KS3 coeffs=$(printf '%s' "$COEF" | tr ',' '\n' | wc -l | tr -d ' ')"
}
strip_lean(){ # the code with the block comments /- ... -/ and the line comments -- removed (as ΕΞΟΔΟΣ' gate strips before its token check)
  awk 'BEGIN { inb = 0 } { line = $0; out = ""
      while (length(line) > 0) { if (inb) { e = index(line, "-/"); if (e == 0) { line = ""; break } line = substr(line, e + 2); inb = 0 }
        else { b = index(line, "/-"); if (b == 0) { out = out line; line = ""; break } out = out substr(line, 1, b - 1); line = substr(line, b + 2); inb = 1 } }
      sub(/--.*$/, "", out); print out }' "$1"; }
check(){ local f="${1:-$ART}" out n code
  [ -f "$f" ] || { echo "LN-REFUSED: artifact absent: $f"; exit 2; }
  code=$(strip_lean "$f")
  printf '%s\n' "$code" | grep -qE '(^|[^a-zA-Z_])import([^a-zA-Z_]|$)' && { echo "KERNEL-REFUSED file=$f reason=import"; return 1; }
  printf '%s\n' "$code" | grep -qE '(^|[^a-zA-Z_])axiom([^a-zA-Z_]|$)' && { echo "KERNEL-REFUSED file=$f reason=axiom"; return 1; }
  printf '%s\n' "$code" | grep -qE '(^|[^a-zA-Z_])sorry([^a-zA-Z_]|$)' && { echo "KERNEL-REFUSED file=$f reason=sorry"; return 1; }
  printf '%s\n' "$code" | grep -q 'native_decide' && { echo "KERNEL-REFUSED file=$f reason=native_decide"; return 1; }
  [ "$(printf '%s\n' "$code" | grep -cE '^theorem ')" = "$(printf '%s\n' "$code" | grep -cE '^theorem .* := by decide$')" ] || { echo "KERNEL-REFUSED file=$f reason=a-theorem-not-by-decide"; return 1; }
  out=$(lean "$f" 2>&1 | tr -d "$CR"); n=$(printf '%s\n' "$out" | grep -cE 'error:')
  if [ "$n" -eq 0 ] && [ -z "$out" ]; then echo "KERNEL-ACCEPTED file=$f theorems=$(grep -c '^theorem ' "$f") errors=0"; return 0; fi
  echo "KERNEL-REFUSED file=$f errors=$n"; printf '%s\n' "$out" | head -6; return 1; }
forge(){ local f="$B/Holoklerosis.forged.lean"; [ -f "$ART" ] || { echo "LN-REFUSED: artifact absent"; exit 2; }
  sed -E '0,/mass_numerator_divisible : [0-9]+/s/(mass_numerator_divisible : [0-9]*)[0-9] = /\10 = /' "$ART" | sed 's/^  Holoklerosis -- THE COMPLETION/  FORGED COPY (the sighted control) -- THE COMPLETION/' > "$f"
  cmp -s "$ART" "$f" && { echo "LN-REFUSED: the forgery changed nothing"; exit 2; }
  check "$f"; }
case "$MODE" in emit) emit;; check) check;; forge) forge;; *) echo "LN-REFUSED: mode must be emit, check or forge"; exit 2;; esac
