#!/usr/bin/env bash
# lean_record.sh -- ΟΛΟΚΛΗΡΩΣΙΣ Ο7, THE KERNEL'S READING AS A RECORD: emits the artifact FRESH beside the organ (never over the committed
# copy), says whether the fresh emission equals the committed artifact byte for byte (LN-FROZEN), has the bare Lean kernel check the fresh
# file (KERNEL-ACCEPTED / KERNEL-REFUSED), then runs the forgery control on it (one digit of the mass numerator bent: KERNEL-REFUSED).
# Paths are normalised to <fresh> / <forged> so a mutant emitter's record and the organ's pin the same lines.
#   env: HLK_LEAN_SH (the emitter; a mutant under DOKIMASIA), HLK_ROOT.  Page DOCS/III-HOLOKLEROSIS-THE-COMPLETION-PREREGISTRATION.md, Ο7.
set -u
ROOT="${HLK_ROOT:-$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)}"; cd "$ROOT" || exit 9
SH="${HLK_LEAN_SH:-STDLIB/build/holoklerosis/holoklerosis_lean.sh}"; ART="STDLIB/certs/holoklerosis/Holoklerosis.lean"; FRESH="${HLK_LEAN_FRESH:-STDLIB/build/holoklerosis/Holoklerosis.fresh.lean}"
CR=$(printf '\r'); norm(){ tr -d "$CR" | sed -E 's#file=[^ ]*forged[^ ]*#file=<forged>#; s#file=[^ ]*\.lean#file=<fresh>#; s#^LN-EMITTED [^ ]*\.lean#LN-EMITTED <fresh>#'; }
[ -f "$SH" ] || { echo "LN-REFUSED: emitter absent: $SH"; echo "LN-END verdict=VACUOUS"; exit 0; }
rm -f "$FRESH"
HLK_LEAN_OUT="$FRESH" bash "$SH" emit 2>&1 | norm
if [ -f "$ART" ] && [ -f "$FRESH" ]; then if cmp -s "$ART" "$FRESH"; then echo "LN-FROZEN committed=$ART equals-fresh=yes"; else echo "LN-FROZEN committed=$ART equals-fresh=no"; fi; else echo "LN-FROZEN committed=$ART equals-fresh=absent"; fi
HLK_LEAN_OUT="$FRESH" bash "$SH" check "$FRESH" 2>&1 | norm | head -3
HLK_LEAN_OUT="$FRESH" bash "$SH" forge 2>&1 | norm | head -2
echo "LN-END theorems=$(grep -c '^theorem ' "$FRESH" 2>/dev/null || echo 0) decide-only=$([ "$(grep -cE '^theorem ' "$FRESH")" = "$(grep -cE '^theorem .* := by decide$' "$FRESH")" ] && echo yes || echo no)"
