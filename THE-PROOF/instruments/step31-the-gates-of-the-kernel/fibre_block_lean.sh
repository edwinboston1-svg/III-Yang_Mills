#!/usr/bin/env bash
# fibre_block_lean.sh -- ΟΛΟΚΛΗΡΩΣΙΣ Addendum IV part 3, THE LAW IN THE KERNEL AS A RECORD: the hand-written artifact
# STDLIB/certs/holoklerosis/FibreBlockLaw.lean (the blocked Gaussian fibre's law cosh kappa_n = (2n^2 + 1)/(n^2 - 1) at n = 2, 4, 8 as finite
# identities -- P_n's values and derivatives at 2, the csc^4 numerator identity, and 3 N_n(w) = C_n w^n q_n(w^n) over Z[zeta_n] computed by the
# kernel) checked by Ο7's own kernel door (holoklerosis_lean.sh check: no import, no axiom, no sorry, no native_decide, every theorem
# `:= by decide`, then `lean` with no output), then the forgery control: ONE literal bent (P_8''(2) = 672 -> 673) must be KERNEL-REFUSED.
# Paths are normalised to <law> / <forged> so a mutant artifact's record and the organ's pin the same lines.  The law file is CUSTODY of
# this record and of the development's gate (arm 21); nothing in it is read from a run.
# THE FIRST RECORD CONVICTED THE SCRIPT (04:13): it had passed the file as a positional word, which the door ignores -- it checked Ο7's own artifact
# twice (theorems=13 against the artifact's 25) and never saw the forged copy; the pins, counted from the artifact itself, parted from the run.
#   env: HLK_ROOT; HLK_FBL_LAW (the artifact; a mutant under DOKIMASIA); HLK_FBL_FORGED (where the bent copy is written, never over the artifact).
#   Page DOCS/III-HOLOKLEROSIS-THE-COMPLETION-PREREGISTRATION.md, Addendum IV part 3.
set -u
ROOT="${HLK_ROOT:-$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)}"; cd "$ROOT" || exit 9
SH="STDLIB/build/holoklerosis/holoklerosis_lean.sh"; LAW="${HLK_FBL_LAW:-STDLIB/certs/holoklerosis/FibreBlockLaw.lean}"
FORGED="${HLK_FBL_FORGED:-STDLIB/build/holoklerosis/FibreBlockLaw.forged.lean}"
CR=$(printf '\r'); norm(){ tr -d "$CR" | sed -E 's#file=[^ ]*forged[^ ]*#file=<forged>#; s#file=[^ ]*\.lean#file=<law>#'; }
[ -f "$SH" ] || { echo "FBL-REFUSED: the kernel door is absent: $SH"; echo "FBL-END verdict=VACUOUS"; exit 0; }
[ -f "$LAW" ] || { echo "FBL-REFUSED: the law artifact is absent: $LAW"; echo "FBL-END verdict=VACUOUS"; exit 0; }
th=$(grep -c '^theorem ' "$LAW"); ctl=$(grep -c '^theorem control_' "$LAW"); dec=$(grep -cE '^theorem .* := by decide$' "$LAW")
echo "FBL-FILE artifact=$LAW theorems=$th controls=$ctl laws=$(grep -cE '^theorem (numerator|law|cosh|P[248]_)' "$LAW")"
HLK_LEAN_OUT="$LAW" bash "$SH" check 2>&1 | norm | head -3   # the door reads its file from HLK_LEAN_OUT, never from a positional word (lean_record.sh does the same)
rm -f "$FORGED"
sed -E 's/^(theorem P8_d2 : peval \(pderiv \(pderiv P8\)\) 2 = )672( := by decide)$/\1673\2/' "$LAW" > "$FORGED"
if cmp -s "$LAW" "$FORGED"; then echo "FBL-REFUSED: the forgery changed nothing (the P8_d2 line is not as written)"; echo "FBL-END theorems=$th decide-only=$([ "$th" = "$dec" ] && echo yes || echo no) forgery=UNMADE"; exit 2; fi
HLK_LEAN_OUT="$FORGED" bash "$SH" check 2>&1 | norm | head -2
echo "FBL-END theorems=$th controls=$ctl decide-only=$([ "$th" = "$dec" ] && echo yes || echo no) forgery=MADE"
