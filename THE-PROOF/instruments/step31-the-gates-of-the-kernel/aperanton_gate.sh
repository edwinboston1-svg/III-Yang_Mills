#!/usr/bin/env bash
# STDLIB/scripts/aperanton_gate.sh -- the gate on ΑΠΕΡΑΝΤΟΝ, the boundless, stage Α0: the finite core of the flux-sector
# results above the bare Lean 4 kernel (LEAN/aperanton/Aperanton/FluxCore.lean, emitted by STDLIB/scripts/aperanton_emit.sh
# from the committed 2x2x2 record).  Page: DOCS/III-APERANTON-THE-BOUNDLESS-PREREGISTRATION.md (first, 52f1e5db3).
#
# CUSTODY, AND THE KERNEL'S READING.  ΕΞΟΔΟΣ' law (T-264): the row is CUSTODY GREEN when the artifact re-emits byte for byte
# from the record, carries decide as its only proof term with no import/axiom/sorry/native_decide, and its literals are the
# record's; the VERDICT is the kernel's.  Lean 4.35.0 stands on this desktop since 2026-10-27 04:34, so the gate also runs
# the kernel on the file and prints its reading as OD:2 (a foreign ENGINE in our hands, ΔΙΑΙΤΗΤΗΣ) -- never as the row's
# green; a foreign hand's run is OD:1.  The teeth bend the EMITTER and the KERNEL must refuse what they emit.
# Since 2026-10-27 the gate also holds the Mathlib stages Α1-Α6a (arms 6-17, lake builds of the twelve files) and Α6b, THE
# KERNEL INSTANCE of the centre's inversion theorem (arm 18): LEAN/aperanton/Aperanton/Z2Inversion.lean, emitted by
# STDLIB/scripts/aperanton_emit_inv.sh from ΣΤΡΟΦΙΓΞ's COMMITTED orbit dump, with two teeth and a comment control on that emitter.
# Α8 (arms 19-20, 2026-10-27): THE SPECTRAL LAW of the Wilson loop (Spectral.lean) and THE X-TRANSFER MODEL with its
# infinite slab (XTransfer.lean) -- the string tension of every finite group on every finite cross-section.
# Α8c (arm 21): THE STRING TENSION IS A GAP (GapBound.lean).  Arm 22: THE SPECTRAL LAW ON THE RECORD -- Z2Moment.lean,
# emitted by STDLIB/scripts/aperanton_emit_mom.sh from the same committed dump, with three teeth and a comment control.
# Α8d (arm 23): THE NONABELIAN WILSON LOOP'S STATIC POTENTIAL IS AT LEAST THE GAP (Nonabelian.lean).  Α8e (arm 24): THE
# GAUGE ACTION ON A CROSS-SECTION, the endpoint hypotheses discharged for every finite group (GaugeAction.lean).  Α8f
# (arm 25): THE LINEAR ACTION -- the representation-theoretic hypotheses discharged from a real orthogonal
# representation (LinearAction.lean).  Α8g (arm 26): THE SCHUR PRODUCT AND THE POLYNOMIAL ACTIONS (Schur.lean).  Α8h
# (arm 27): THE WILSON ACTION'S KERNEL IS POSITIVE SEMIDEFINITE (Wilson.lean).  Β1 (arm 28, ADDENDUM I THE ROAD): THE
# SEPARATION THEOREM -- the Wilson kernel of a FAITHFUL representation positive definite, W(1) > 0 discharged
# (Separation.lean; its standalone compile the base run, two kernel teeth, a comment control).
set -u
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"; cd "$ROOT" || exit 9
DK_ORGAN="aperanton"
. "$ROOT/STDLIB/scripts/lib/dokimasia.sh"
B="$ROOT/STDLIB/build/aperanton"; MUT="$B/mut"; mkdir -p "$B" "$MUT"
PRE="$ROOT/DOCS/III-APERANTON-THE-BOUNDLESS-PREREGISTRATION.md"
EMIT="$ROOT/STDLIB/scripts/aperanton_emit.sh"
ART="$ROOT/LEAN/aperanton/Aperanton/FluxCore.lean"
REC="$ROOT/EXPORT/anexaleipton/expected/z2_flux3d_record.txt"
SEC="$ROOT/EXPORT/anexaleipton/expected/flux_sectors_record.txt"
RUN="$B/run.txt"
for f in "$PRE" "$EMIT" "$ART" "$REC" "$SEC" "$ROOT/LEAN/aperanton/lakefile.toml" "$ROOT/LEAN/aperanton/lean-toolchain" "$ROOT/LEAN/aperanton/Aperanton.lean"; do [ -f "$f" ] || dk_red "missing: $f"; done
command -v gawk >/dev/null 2>&1 || dk_red "gawk is required"
export PATH="$HOME/.elan/bin:$PATH"
command -v lean >/dev/null 2>&1 || dk_red "lean is required for this gate's kernel reading and its teeth (elan: ~/.elan/bin)"
dk_provenance "$PRE" "LEAN/aperanton/Aperanton/FluxCore.lean"
dk_own STDLIB/scripts/aperanton_emit.sh STDLIB/scripts/aperanton_gate.sh STDLIB/scripts/aperanton_block.awk STDLIB/scripts/aperanton_probe.awk STDLIB/scripts/aperanton_su2_link.awk STDLIB/scripts/aperanton_ising_tower.awk STDLIB/scripts/aperanton_ising_tower2.awk STDLIB/scripts/aperanton_ising_tower3.awk STDLIB/scripts/aperanton_ising_tower4.awk STDLIB/scripts/aperanton_tube_gks.awk STDLIB/scripts/aperanton_tilt_cert.awk STDLIB/build/aperanton/mkflow_b2.2.2026-10-29e.txt STDLIB/build/aperanton/mkflow_b2.3.2026-10-29e.txt STDLIB/build/aperanton/mkflow_b5.2026-10-29e.txt STDLIB/build/aperanton/mkflow_b10.2026-10-29e.txt STDLIB/build/aperanton/tilt_cert.2026-10-29b.txt STDLIB/scripts/aperanton_decimation_cert.awk STDLIB/scripts/aperanton_oneloop_step.awk STDLIB/scripts/aperanton_oneloop_step2.awk LEAN/aperanton/Aperanton/VmfBounds.lean LEAN/aperanton/Aperanton/CouplingSequence.lean LEAN/aperanton/Aperanton/CouplingTransient.lean LEAN/aperanton/Aperanton/ChristoffelBound.lean LEAN/aperanton/Aperanton/VertexLaw.lean STDLIB/scripts/aperanton_emit_vertexlaw.sh STDLIB/scripts/aperanton_s8_pauli.awk STDLIB/scripts/aperanton_s8_exact.awk STDLIB/scripts/aperanton_s8_check.awk STDLIB/scripts/aperanton_kp_cert.awk STDLIB/scripts/aperanton_bessel_cert.awk STDLIB/scripts/aperanton_floor_cert.awk STDLIB/scripts/aperanton_bessel_diff.awk STDLIB/scripts/aperanton_band_cert.c STDLIB/scripts/aperanton_dress_kat.c STDLIB/scripts/aperanton_box_cert.c STDLIB/scripts/aperanton_junction_cert.c STDLIB/scripts/aperanton_star_exact.c STDLIB/build/aperanton/shapes/tube4.shape STDLIB/scripts/aperanton_fontes_hessian.awk STDLIB/scripts/aperanton_fontes_peierls.awk STDLIB/scripts/aperanton_fontes_christoffel.awk STDLIB/scripts/aperanton_mk_gap.awk STDLIB/scripts/aperanton_kaufman_step.awk STDLIB/scripts/aperanton_mk_flow.awk STDLIB/scripts/aperanton_mk_flow_u1.awk STDLIB/scripts/aperanton_fibre_cert.awk STDLIB/scripts/aperanton_z2_tube.awk STDLIB/scripts/aperanton_su2_kat.awk STDLIB/scripts/aperanton_bi_flip.awk LEAN/aperanton/Aperanton/TwistEater.lean LEAN/aperanton/Aperanton/TowerStep.lean LEAN/aperanton/Aperanton/DobrushinMeasure.lean LEAN/aperanton/Aperanton/MassGapChain.lean LEAN/aperanton/Aperanton/Z2Chain.lean LEAN/aperanton/Aperanton/UVInterface.lean LEAN/aperanton/Aperanton/CrossoverCriterion.lean LEAN/aperanton/Aperanton/PerfectDecimation.lean STDLIB/scripts/aperanton_perfect_cover.pl STDLIB/scripts/aperanton_decimation_rowsum.awk LEAN/aperanton/Aperanton/MassGapAssembly.lean LEAN/aperanton/Aperanton/TowerChain.lean LEAN/aperanton/Aperanton/Tower.lean LEAN/aperanton/Aperanton/TwistEaterGeneral.lean LEAN/aperanton/Aperanton/TwistEaterSharp.lean STDLIB/scripts/aperanton_flat_marginal.awk LEAN/aperanton/Aperanton/NeumannCoeff.lean LEAN/aperanton/Aperanton/BondMoving.lean STDLIB/scripts/aperanton_mkflow.awk STDLIB/scripts/aperanton_su2_plaq.awk STDLIB/scripts/aperanton_z2_hinge.awk STDLIB/scripts/aperanton_shadow_hinge.awk STDLIB/scripts/aperanton_shadow_counts.awk STDLIB/scripts/aperanton_shadow_counts2.awk STDLIB/scripts/aperanton_su2_cell.awk STDLIB/scripts/aperanton_design_residue.awk LEAN/aperanton/Aperanton/DesignDihedral.lean STDLIB/scripts/aperanton_simon_lieb.awk STDLIB/scripts/aperanton_simon_lieb_box.awk LEAN/aperanton/Aperanton/FluxCore.lean LEAN/aperanton/Aperanton/TheoremT.lean LEAN/aperanton/Aperanton/Transfer.lean LEAN/aperanton/Aperanton/Perron.lean LEAN/aperanton/Aperanton/EvenTime.lean LEAN/aperanton/Aperanton/StringEnergy.lean LEAN/aperanton/Aperanton/Griffiths.lean LEAN/aperanton/Aperanton/Lattice.lean LEAN/aperanton/Aperanton/Rectangle.lean LEAN/aperanton/Aperanton/MacWilliams.lean LEAN/aperanton/Aperanton/MassGap.lean LEAN/aperanton/Aperanton/StrongCoupling.lean LEAN/aperanton/Aperanton/Inversion.lean LEAN/aperanton/Aperanton/Z2Inversion.lean STDLIB/scripts/aperanton_emit_inv.sh LEAN/aperanton/Aperanton/Spectral.lean LEAN/aperanton/Aperanton/XTransfer.lean LEAN/aperanton/Aperanton/GapBound.lean LEAN/aperanton/Aperanton/Nonabelian.lean LEAN/aperanton/Aperanton/GaugeAction.lean LEAN/aperanton/Aperanton/LinearAction.lean LEAN/aperanton/Aperanton/Schur.lean LEAN/aperanton/Aperanton/Wilson.lean LEAN/aperanton/Aperanton/Separation.lean LEAN/aperanton/Aperanton/Z2Moment.lean STDLIB/scripts/aperanton_emit_mom.sh STDLIB/scripts/aperanton_emit_torus4.sh LEAN/aperanton/Aperanton/Dobrushin.lean LEAN/aperanton/Aperanton/Factors.lean LEAN/aperanton/Aperanton/Decay.lean LEAN/aperanton/Aperanton/Slab.lean LEAN/aperanton/Aperanton/Rowsum.lean LEAN/aperanton/Aperanton/Z2Slab.lean LEAN/aperanton/Aperanton/Z2Interdep.lean LEAN/aperanton/Aperanton/Unitary.lean LEAN/aperanton/Aperanton/Scaling.lean LEAN/aperanton/Aperanton/Duality.lean LEAN/aperanton/Aperanton/YM2.lean LEAN/aperanton/Aperanton/YM2Q8.lean LEAN/aperanton/Aperanton/Torus4.lean LEAN/aperanton/Aperanton/Bridge.lean LEAN/aperanton/Aperanton/Echelon.lean LEAN/aperanton/Aperanton/Torus4Cert.lean LEAN/aperanton/Aperanton/Torus4Bridge.lean LEAN/aperanton/Aperanton/DualTorus.lean LEAN/aperanton/Aperanton/Weak.lean LEAN/aperanton/Aperanton/Fibre.lean LEAN/aperanton/Aperanton/Block.lean LEAN/aperanton/Aperanton/ZedEven.lean LEAN/aperanton/Aperanton/TorusSys.lean LEAN/aperanton/Aperanton/TorusL.lean LEAN/aperanton/Aperanton/TorusLBridge.lean LEAN/aperanton/Aperanton/TorusSysL.lean LEAN/aperanton/Aperanton/TorusLevels.lean LEAN/aperanton/Aperanton/TorusDecay.lean LEAN/aperanton/Aperanton/TorusTwoPoint.lean LEAN/aperanton/Aperanton/TorusT3.lean LEAN/aperanton/Aperanton/TorusLTrans.lean LEAN/aperanton/Aperanton/TorusT3Assembly.lean LEAN/aperanton/Aperanton/TorusLocal.lean LEAN/aperanton/Aperanton/EchelonList.lean LEAN/aperanton/Aperanton/DesignCore.lean STDLIB/scripts/aperanton_emit_design.sh LEAN/aperanton/Aperanton/Design.lean LEAN/aperanton/Aperanton/TorusLinear.lean LEAN/aperanton/Aperanton/TorusLinearDual.lean STDLIB/scripts/aperanton_emit_torusL.sh LEAN/aperanton/Aperanton/TorusLCert3.lean LEAN/aperanton/Aperanton/TorusL3.lean STDLIB/scripts/aperanton_emit_torusL_trans.sh LEAN/aperanton/Aperanton/TorusLTrans3.lean LEAN/aperanton/Aperanton/TorusT3L3.lean LEAN/aperanton/Aperanton.lean LEAN/aperanton/lakefile.toml LEAN/aperanton/lake-manifest.json LEAN/aperanton/lean-toolchain LEAN/aperanton/.gitignore

# the runner: the kernel on a .lean file, its reading as one line (the pin), its diagnostics kept
# A LEAN CALL THAT FAILS ONLY IN THE HOST'S ALPHABET IS RERUN ALONE (law 16-bis in the compiler's own alphabet; law 26-ter:
# the retry lived in lean_arm alone and arm 7 bled at 14:34, run q): "failed to read file" (an olean intermittently unreadable
# under the OneDrive tree) and "failed to open file '...': 1450" (ERROR_NO_SYSTEM_RESOURCES at the host's commit wall) are the
# host's, not the file's.  Up to three attempts while EVERY error line is in that alphabet ("error: build failed" is lake's
# summary, not an error of the subject); an elaboration error is the subject's and is refused at once.
lean_retry(){ # $1 = log, $2 = subject label, $3 = directory, $4.. = the command
  local log="$1" label="$2" dir="$3"; shift 3
  local rc attempt nerr nhost
  for attempt in 1 2 3; do
    ( cd "$dir" && "$@" ) > "$log" 2>&1; rc=$?
    [ "$rc" -eq 0 ] && break
    nerr=$(grep -E '(^| )error: ' "$log" | grep -vc 'error: build failed')
    nhost=$(grep -cE "error: failed to (read file|open file '[^']*': [0-9]+)" "$log")
    if [ "$nerr" -gt 0 ] && [ "$nerr" -eq "$nhost" ]; then
      dk_say "lean_retry $label: attempt $attempt failed in the host's alphabet ($(grep -oE "failed to (read|open) file '[^']*'" "$log" | head -1 | sed 's/.*lean\\//')) -- rerun alone"
      sleep 5; continue
    fi
    break
  done
  return "$rc"
}
kernel(){ # $1 = a lean file, $2 = its label (FluxCore unless given); prints KERNEL-ACCEPTED or KERNEL-REFUSED with the error count
  local f="$1" label="${2:-FluxCore}" log; log="$B/kernel.$(basename "$f").log"
  if [ "${f##*.}" != "lean" ]; then cp "$f" "$f.lean"; f="$f.lean"; fi
  lean_retry "$log" "$label" "$(dirname "$f")" lean "$(basename "$f")"; local rc=$?
  local nerr; nerr=$(grep -c ' error: ' "$log")
  local nth; nth=$(grep -c '^theorem ' "$f")
  if [ "$rc" -eq 0 ] && [ "$nerr" -eq 0 ]; then echo "KERNEL-ACCEPTED $label theorems=$nth errors=0 (Lean $(lean --version | grep -oE 'version [0-9.]+' | cut -d' ' -f2))"
  else echo "KERNEL-REFUSED $label theorems=$nth errors=$nerr rc=$rc: $(grep ' error: ' "$log" | head -1 | cut -c1-160)"; fi
}
cc(){ ( cd "$ROOT" && APERANTON_ROOT="$ROOT" bash "$1" "$2" ); }   # a mutant EMITTER builds its artifact from the tree root: bash <mutant> <out>
run_mut(){ kernel "$1"; }
# the inversion emitter's doors: a mutant builds its artifact from HEAD's dump (never the worktree copy), the kernel reads it as Z2Inversion
cc_inv(){ ( cd "$ROOT" && APERANTON_ROOT="$ROOT" bash "$1" "$2" "$B/dump.head.run" ); }
run_mut_inv(){ kernel "$1" Z2Inversion; }
# the separation file's doors: the artifact IS the (mutant) source, compiled standalone above the built Mathlib stages with
# `lake env lean` from the project (the olean cache cannot answer for a mutant); the line read is KERNEL-ACCEPTED/REFUSED
cc_sep(){ cp "$1" "$2"; }
run_mut_sep(){
  local f="$1" log; if [ "${f##*.}" != "lean" ]; then cp "$f" "$f.lean"; f="$f.lean"; fi
  log="$B/kernel.sep.$(basename "$f").log"
  lean_retry "$log" Separation "$ROOT/LEAN/aperanton" lake env lean "$f"; local rc=$?
  local nerr; nerr=$(grep -c ' error: ' "$log")
  local nth; nth=$(grep -c '^theorem ' "$f")
  if [ "$rc" -eq 0 ] && [ "$nerr" -eq 0 ]; then echo "KERNEL-ACCEPTED Separation theorems=$nth errors=0"
  else echo "KERNEL-REFUSED Separation theorems=$nth errors=$nerr rc=$rc: $(grep ' error: ' "$log" | head -1 | cut -c1-160)"; fi
}
# the moment emitter's doors: a mutant builds its artifact from HEAD's dump; the kernel reads it as Z2Moment, or the
# custody runner compares it byte for byte with the committed artifact
cc_mom(){ ( cd "$ROOT" && APERANTON_ROOT="$ROOT" bash "$1" "$2" "$B/dump.head.run" ); }
run_mut_mom(){ kernel "$1" Z2Moment; }
run_mut_momcmp(){ if cmp -s "$1" "$ROOT/LEAN/aperanton/Aperanton/Z2Moment.lean"; then echo "MOMENT-CUSTODY byte-identical"; else echo "MOMENT-CUSTODY MOVED: the re-emission differs from the committed Z2Moment.lean"; fi; }
rm -f "$RUN"
kernel "$ART" > "$RUN"
have(){ grep -qF -- "$1" "$RUN" || dk_red "MISSING PIN: $1"; }

# ---- ARM 1: THE ARTIFACT RE-EMITS BYTE FOR BYTE FROM THE RECORD
bash "$EMIT" "$B/reemit.lean" > "$B/reemit.log" 2>&1 || dk_red "arm 1: the emitter failed ($(tail -1 "$B/reemit.log"))"
cmp -s "$B/reemit.lean" "$ART" || dk_red "arm 1: FluxCore.lean does not regenerate byte-identically from the record (the emitter or the record moved)"
grep -q "commit $(gawk '$1 == "expected/z2_flux3d_record.txt" { print $2 }' "$ROOT/EXPORT/anexaleipton/expected/COMMITS")" "$ART" || dk_red "arm 1: the artifact does not name the record's commit"
dk_say "arm 1 (CUSTODY): FluxCore.lean re-emitted byte for byte from the committed record, the record's commit stamped in it"

# ---- ARM 2: THE STRUCTURE -- decide the only proof term; no import, axiom, sorry, native_decide in the CODE (comments stripped)
strip_lean(){ gawk '
  { line = $0 }
  { out = ""; i = 1
    while (i <= length(line)) {
      if (inblock) { j = index(substr(line, i), "-/"); if (j == 0) { i = length(line) + 1 } else { i = i + j + 1; inblock = 0 }; continue }
      two = substr(line, i, 2)
      if (two == "/-") { inblock = 1; i += 2; continue }
      if (two == "--") { break }
      out = out substr(line, i, 1); i++
    }
    print out }' "$1"; }
strip_lean "$ART" > "$B/code.txt"
for tok in import axiom sorry native_decide; do grep -qE "(^|[^a-zA-Z_.])$tok([^a-zA-Z_]|$)" "$B/code.txt" && dk_red "arm 2: a forbidden token stands in the code: $tok"; done
nth=$(grep -c '^theorem ' "$B/code.txt"); [ "$nth" -eq 15 ] || dk_red "arm 2: $nth theorems, not 15"
nby=$(grep -c ':= by ' "$B/code.txt"); ndec=$(grep -cE ':= by decide( \+kernel)?$' "$B/code.txt")
[ "$nby" -eq "$ndec" ] && [ "$ndec" -eq 15 ] || dk_red "arm 2: $nby proof terms, $ndec of them decide -- decide must be the only proof term"
grep -q '^namespace Aperanton' "$B/code.txt" && grep -q '^end Aperanton' "$B/code.txt" || dk_red "arm 2: the namespace is not closed"
dk_say "arm 2 (THE STRUCTURE): 15 theorems, decide the only proof term (13 by the elaborator's reduction, 2 sent to the kernel directly), no import, no axiom, no sorry, no native_decide"

# ---- ARM 3: THE LITERALS ARE THE RECORD'S -- a_w[k], J_h[k], d(w), m(w), Theorem S's counts, re-derived by a road that is not the emitter's
tr -d '\r' < "$REC" | gawk '
  function idx(name) { return substr(name, 1, 1) + 2 * substr(name, 2, 1) + 4 * substr(name, 3, 1) }
  /^Z2-FLUX3D torus 2x2x2 / { on = 1 } on && /^Z2-FLUX3D end/ { on = 0 }
  on && /^ROAD-A w=[01]+ W_w\(y\) coefficients k:a_k:/ { w = idx(substr($2, 3, 3)); s = ""; for (k = 0; k <= 24; k++) { v = 0; for (i = 1; i <= NF; i++) if ($i ~ ("^" k ":-?[0-9]+$")) { split($i, kv, ":"); v = kv[2] }; s = s ((k > 0) ? ", " : "") v }; print "  | " w " => [" s "]" > "/dev/stdout" }
  on && /^ROAD-B h=[01]+ J_h\[k\] \(two spin configurations per wall set\) k:J_k:/ { h = idx(substr($2, 3, 3)); s = ""; for (k = 0; k <= 24; k++) { v = 0; for (i = 1; i <= NF; i++) if ($i ~ ("^" k ":-?[0-9]+$")) { split($i, kv, ":"); v = kv[2] }; s = s ((k > 0) ? ", " : "") v }; print "  | " h " => [" s "]" > "/dev/stderr" }
' > "$B/rec_A.txt" 2> "$B/rec_J.txt"
sort "$B/rec_A.txt" > "$B/rec_A.sorted"; sort "$B/rec_J.txt" > "$B/rec_J.sorted"
sed -n '/^def A /,/| _ => \[\]/p' "$ART" | grep -E '^  \| [0-7] => \[' | sort > "$B/art_A.sorted"
sed -n '/^def J /,/| _ => \[\]/p' "$ART" | grep -E '^  \| [0-7] => \[' | sort > "$B/art_J.sorted"
cmp -s "$B/rec_A.sorted" "$B/art_A.sorted" || dk_red "arm 3: the artifact's road-A literals part from the record's"
cmp -s "$B/rec_J.sorted" "$B/art_J.sorted" || dk_red "arm 3: the artifact's road-B literals part from the record's"
[ "$(wc -l < "$B/art_A.sorted")" -eq 8 ] && [ "$(wc -l < "$B/art_J.sorted")" -eq 8 ] || dk_red "arm 3: not eight sectors of literals"
DREC=$(tr -d '\r' < "$REC" | gawk '/^Z2-FLUX3D torus 2x2x2 / { on = 1 } on && /^Z2-FLUX3D end/ { on = 0 } on && /^SECTOR w=/ { for (i = 1; i <= NF; i++) if ($i ~ /^d\(w\)=/) d = substr($i, 6); s = s ((s == "") ? "" : ", ") d } END { print "[" s "]" }')
MREC=$(tr -d '\r' < "$REC" | gawk '/^Z2-FLUX3D torus 2x2x2 / { on = 1 } on && /^Z2-FLUX3D end/ { on = 0 } on && /^SECTOR w=/ { for (i = 1; i <= NF; i++) if ($i ~ /^m\(w\)=/) m = substr($i, 6); s = s ((s == "") ? "" : ", ") m } END { print "[" s "]" }')
grep -qF "firstNonzero (A w) 0) = $DREC := by decide" "$ART" || dk_red "arm 3: d(w) in the artifact is not the record's $DREC"
grep -qF "(firstNonzero (A w) 0)) = $MREC := by decide" "$ART" || dk_red "arm 3: m(w) in the artifact is not the record's $MREC"
S2=$(tr -d '\r' < "$SEC" | gawk '/^T4 N=2 / { v = $0 } END { match(v, /\[0\]:[0-9]+/); print substr(v, RSTART + 4, RLENGTH - 4) }')
S3=$(tr -d '\r' < "$SEC" | gawk '/^T4 N=3 / { v = $0 } END { match(v, /\[0\]:[0-9]+/); print substr(v, RSTART + 4, RLENGTH - 4) }')
grep -qF "theorem sectors_T4_N2 : zeroCount 2 = $S2 := by decide" "$ART" || dk_red "arm 3: Theorem S at N = 2 in the artifact is not record b's $S2"
grep -qF "theorem sectors_T4_N3 : zeroCount 3 = $S3 := by decide" "$ART" || dk_red "arm 3: Theorem S at N = 3 in the artifact is not record b's $S3"
dk_say "arm 3 (THE LITERALS): a_w[k] and J_h[k] at all eight sectors, d(w) = $DREC, m(w) = $MREC, Theorem S's $S2 and $S3 -- the record's, re-derived by a second reading"

# ---- ARM 4: THE KERNEL'S READING (OD:2 -- the foreign engine on our machine; the row's verdict is a foreign hand's)
have 'KERNEL-ACCEPTED FluxCore theorems=15 errors=0'
dk_say "arm 4 (THE KERNEL, OD:2): $(cat "$RUN") -- every theorem reduced; CUSTODY is ours, the verdict the kernel's"

# ---- ARM 5: THE PAGE NAMES ITS STAKES
for ph in 'Α0 THE FINITE CORE IN THE KERNEL' '`decide` the only proof term' 'T-271' 'T-135' 'T-140' 'T-500' 'T-22' 'T-718' 'T-475' 'not asserted' 'ADDENDUM I' 'Mechanism T' 'Mechanism S' 'ONE conditional'; do grep -qF -- "$ph" "$PRE" || dk_red "arm 5: the page lost [$ph]"; done
dk_say "arm 5: the page carries its stages, their deciders, the theorems they stand on, and Addendum I's two mechanisms"

# ---- ARM 6: STAGE Α1 ABOVE MATHLIB -- TheoremT.lean elaborates with no sorry (the first stage with imports; OD:2 as arm 4)
T1="$ROOT/LEAN/aperanton/Aperanton/TheoremT.lean"
[ -f "$T1" ] || dk_red "arm 6: missing $T1"
[ -d "$ROOT/LEAN/aperanton/.lake/packages/mathlib" ] || dk_red "arm 6: Mathlib is not fetched under LEAN/aperanton/.lake (lake update; lake exe cache get)"
strip_lean "$T1" > "$B/code_t1.txt"
grep -qE '(^|[^a-zA-Z_.])sorry([^a-zA-Z_]|$)' "$B/code_t1.txt" && dk_red "arm 6: a sorry stands in TheoremT.lean"
grep -qE '(^|[^a-zA-Z_.])axiom([^a-zA-Z_]|$)' "$B/code_t1.txt" && dk_red "arm 6: an axiom stands in TheoremT.lean"
grep -q 'native_decide' "$B/code_t1.txt" && dk_red "arm 6: native_decide in TheoremT.lean"
n1=$(grep -c '^theorem ' "$B/code_t1.txt"); [ "$n1" -eq 9 ] || dk_red "arm 6: $n1 theorems in TheoremT.lean, not 9"
for th in coset_avoids_zero theoremT_divisible theoremT_min_pos theoremT_constant_term trivial_sector_constant_term theoremT; do grep -q "^theorem $th " "$B/code_t1.txt" || dk_red "arm 6: TheoremT.lean lost theorem $th"; done
lean_retry "$B/kernel.TheoremT.log" TheoremT "$ROOT/LEAN/aperanton" lake env lean Aperanton/TheoremT.lean; rc1=$?
if [ "$rc1" -ne 0 ] || grep -q ' error: ' "$B/kernel.TheoremT.log"; then dk_red "arm 6: TheoremT.lean REFUSED (rc=$rc1): $(grep ' error: ' "$B/kernel.TheoremT.log" | head -1 | cut -c1-160)"; fi
dk_say "arm 6 (STAGE Α1, ABOVE MATHLIB): TheoremT.lean -- the coset avoids zero, d(w) >= 1, the enumerator divisible by y^d(w), its constant term zero, the trivial sector's one -- elaborated with Mathlib v4.35.0, 9 theorems, no sorry, no axiom (OD:2)"

# ---- ARM 7: STAGE Α4, THE SPECTRAL HALF OF THE TRANSFER THEOREM -- Transfer.lean elaborates with no sorry
T4="$ROOT/LEAN/aperanton/Aperanton/Transfer.lean"
[ -f "$T4" ] || dk_red "arm 7: missing $T4"
strip_lean "$T4" > "$B/code_t4.txt"
grep -qE '(^|[^a-zA-Z_.])sorry([^a-zA-Z_]|$)' "$B/code_t4.txt" && dk_red "arm 7: a sorry stands in Transfer.lean"
grep -qE '(^|[^a-zA-Z_.])axiom([^a-zA-Z_]|$)' "$B/code_t4.txt" && dk_red "arm 7: an axiom stands in Transfer.lean"
grep -q 'native_decide' "$B/code_t4.txt" && dk_red "arm 7: native_decide in Transfer.lean"
grep -q '^theorem trace_pow_eq_sum_eigenvalues_pow' "$B/code_t4.txt" || dk_red "arm 7: Transfer.lean lost trace_pow_eq_sum_eigenvalues_pow"
lean_retry "$B/kernel.Transfer.log" Transfer "$ROOT/LEAN/aperanton" lake env lean Aperanton/Transfer.lean; rc4=$?
if [ "$rc4" -ne 0 ] || grep -q ' error: ' "$B/kernel.Transfer.log"; then dk_red "arm 7: Transfer.lean REFUSED (rc=$rc4): $(grep ' error: ' "$B/kernel.Transfer.log" | head -1 | cut -c1-160)"; fi
dk_say "arm 7 (STAGE Α4, THE SPECTRAL HALF): Transfer.lean -- tr(T^L) = sum of the eigenvalues' L-th powers for a real symmetric T, by the spectral theorem's conjugation -- elaborated with Mathlib v4.35.0, no sorry, no axiom (OD:2)"

# ---- ARM 8: STAGE Α4, THE PERRON HALF -- Perron.lean builds above Transfer.lean with no sorry; its theorems named
T5="$ROOT/LEAN/aperanton/Aperanton/Perron.lean"
[ -f "$T5" ] || dk_red "arm 8: missing $T5"
strip_lean "$T5" > "$B/code_t5.txt"
grep -qE '(^|[^a-zA-Z_.])sorry([^a-zA-Z_]|$)' "$B/code_t5.txt" && dk_red "arm 8: a sorry stands in Perron.lean"
grep -qE '(^|[^a-zA-Z_.])axiom([^a-zA-Z_]|$)' "$B/code_t5.txt" && dk_red "arm 8: an axiom stands in Perron.lean"
grep -q 'native_decide' "$B/code_t5.txt" && dk_red "arm 8: native_decide in Perron.lean"
for th in perron_exists perron_simple perron_symmetric abs_eigenvalue_lt perron_index_unique trace_pow_residual trace_pow_div_tendsto; do
  grep -q "^theorem $th " "$B/code_t5.txt" || dk_red "arm 8: Perron.lean lost $th"
done
nt5=$(grep -c '^theorem ' "$B/code_t5.txt")
[ "$nt5" -eq 19 ] || dk_red "arm 8: Perron.lean carries $nt5 theorems, not the 19 of the run of record"
lean_retry "$B/kernel.Perron.log" Perron "$ROOT/LEAN/aperanton" lake build Aperanton.Perron; rc5=$?
if [ "$rc5" -ne 0 ] || grep -q ' error: ' "$B/kernel.Perron.log"; then dk_red "arm 8: Perron.lean REFUSED (rc=$rc5): $(grep ' error: ' "$B/kernel.Perron.log" | head -1 | cut -c1-160)"; fi
dk_say "arm 8 (STAGE Α4, THE PERRON HALF): Perron.lean -- for an entrywise-positive symmetric T the top eigenvalue is positive, simple, carries a strictly positive eigenvector fixed by every nonnegative orthogonal symmetry commuting with T, and strictly dominates every other eigenvalue; |tr(T^L) - lam0^L| <= (n-1)(rho lam0)^L with rho < 1 and tr(T^L)/lam0^L -> 1 -- 19 theorems built above Transfer.lean with Mathlib v4.35.0, no sorry, no axiom (OD:2); Perron 1907 is W=0, Mathlib carries the definitions and not the theorem"

# ---- ARMS 9 AND 10: STAGE Α3 (EvenTime.lean) AND STAGE Α4c (StringEnergy.lean) build above the earlier files with no sorry
lean_arm(){ # $1 = arm number, $2 = module stem, $3 = theorem count, $4.. = theorem names required
  local arm="$1" stem="$2" want="$3"; shift 3
  local f="$ROOT/LEAN/aperanton/Aperanton/$stem.lean"
  [ -f "$f" ] || dk_red "arm $arm: missing $f"
  strip_lean "$f" > "$B/code_$stem.txt"
  grep -qE '(^|[^a-zA-Z_.])sorry([^a-zA-Z_]|$)' "$B/code_$stem.txt" && dk_red "arm $arm: a sorry stands in $stem.lean"
  grep -qE '(^|[^a-zA-Z_.])axiom([^a-zA-Z_]|$)' "$B/code_$stem.txt" && dk_red "arm $arm: an axiom stands in $stem.lean"
  grep -q 'native_decide' "$B/code_$stem.txt" && dk_red "arm $arm: native_decide in $stem.lean"
  local th; for th in "$@"; do grep -q "^theorem $th " "$B/code_$stem.txt" || dk_red "arm $arm: $stem.lean lost $th"; done
  local nt; nt=$(grep -c '^theorem ' "$B/code_$stem.txt")
  [ "$nt" -eq "$want" ] || dk_red "arm $arm: $stem.lean carries $nt theorems, not the $want of the run of record"
  # A BUILD WHOSE ONLY FAILURE IS AN UNREADABLE OLEAN IS THE HOST'S, NOT THE FILE'S: on this desktop a Mathlib .olean under
  # the OneDrive tree is intermittently unreadable ("failed to read file", the file intact; three different oleans in three
  # consecutive builds at 08:2x, run f at 06:41, and no Lean process beside them) -- law 16-bis in the compiler's own
  # alphabet.  The arm reruns the build alone up to three times when that alphabet, and no elaboration error, is all the
  # log holds; an elaboration error is the subject's and is refused at once.
  local rc
  lean_retry "$B/kernel.$stem.log" "$stem" "$ROOT/LEAN/aperanton" lake build "Aperanton.$stem"; rc=$?
  if [ "$rc" -ne 0 ] || grep -q ' error: ' "$B/kernel.$stem.log"; then dk_red "arm $arm: $stem.lean REFUSED (rc=$rc): $(grep ' error: ' "$B/kernel.$stem.log" | head -1 | cut -c1-160)"; fi
  # THE BASE RUN IS THE ARM'S OWN READING (run u): the same elaborator on the same bytes, in the pin's alphabet -- the
  # pin of the file's DOKIMASIA is read from here (law 24-quater: from a run, never a static count)
  printf 'KERNEL-ACCEPTED %s theorems=%s errors=0\n' "$stem" "$nt" > "$B/run.$stem.txt"
}
lean_arm 9 EvenTime 3 posSemidef_pow_two_mul even_time_nonneg trace_pow_two_mul_nonneg
dk_say "arm 9 (STAGE Α3, REFLECTION POSITIVITY AT EVEN TIME): EvenTime.lean -- every even power of a real symmetric T is positive semidefinite, the even-time form <v, T^(2L) v> nonnegative, the even-time trace a sum of squares -- 3 theorems built with Mathlib v4.35.0, no sorry, no axiom (OD:2); ΑΝΤΑΥΓΕΙΑ T-22 in the transfer matrix's language"
lean_arm 10 StringEnergy 4 pow_nonneg_diag_pos trace_pow_pos log_trace_div_tendsto string_energy_tendsto
dk_say "arm 10 (STAGE Α4c, THE STRING ENERGY AS AN EXACT LIMIT): StringEnergy.lean -- log tr(T^L)/L -> log lam0 and -(1/L) log(Z_e/Z_0) -> log lam0(T_0) - log lam0(T_e) for two positive symmetric sector matrices of any dimensions -- 4 theorems built above Perron.lean, no sorry, no axiom (OD:2)"

# ---- ARM 130 (D3, THE VERTEX LAW'S TABLE IN THE KERNEL): VertexLaw.lean -- Lemma S8's vertex law (ledger §112 ter, S1 §13) gives
# r(S; T) = prod_v c(D_v) with c(D) = (1/2) 3^-k S(D), S(D) the sum over the 3^k adjoint assignments of the real trace of the Pauli
# product around the vertex cycle; the kernel decides S(D) for every chord diagram of k <= 4 lone-wall boundaries through one vertex
# (complete for Z^4) over Gaussian-integer 2 x 2 matrices, and sigma^2 = 1.  CUSTODY first: the file re-emits byte for byte from
# the committed Pauli record (the quaternion-moment road's equal values are the record's own second road).
VLEMIT="$ROOT/STDLIB/scripts/aperanton_emit_vertexlaw.sh"; VLREC="STDLIB/build/aperanton/s8_pauli.2026-10-29a.txt"; MUTVL="$B/mut_vertexlaw"; mkdir -p "$MUTVL"
bash "$VLEMIT" "$VLREC" "$MUTVL/reemit.lean" > "$MUTVL/reemit.log" 2>&1 || dk_red "arm 130: the VertexLaw emitter failed ($(tail -1 "$MUTVL/reemit.log"))"
cmp -s "$MUTVL/reemit.lean" "$ROOT/LEAN/aperanton/Aperanton/VertexLaw.lean" || dk_red "arm 130: VertexLaw.lean does not regenerate byte-identically from the Pauli record (the emitter or the record moved)"
lean_arm 130 VertexLaw 130 pauli_sq vl_aa vl_abab vl_aabb vl_abcabc vl_abacbc vl_abcdabcd vl_abcadcbd vl_abcadbcd vl_abacdbcd spine_3 spine_4
dk_say "arm 130 (D3, THE VERTEX LAW'S TABLE IN THE KERNEL): VertexLaw.lean re-emitted byte for byte from the Pauli record and read by the kernel -- 130 theorems: S(D) for every chord diagram of k <= 4 walls through one vertex (the triangle 30, K4 -78, the four-cycle 66), sigma^2 = 1"
# ---- ARM 131 (C2, THE KOTECKÝ–PREISS CERTIFICATE OF THE FLUX-SURFACE GAS): aperanton_kp_cert.awk -- S1 §14's inequality verbatim
# (III-Yang_Mills 30267c8) as an interval of exact integers on the grid 2^-128, the Bessel ratios from aperanton_bessel_cert.awk's
# rational enclosures (met by ALOGON's grid cell for cell, arm 133), every tail closed, the dressing root bracketed from both
# sides, refusals by name.  TWO DRESSINGS: DRESS=page, S1 §14's recursion as written (16.65-a) -- the KAT, the scan 0.4256..0.4264
# at gamma = 6, F0 = 20, pinned at beta* = 0.4260 against the page's float 0.4266; DRESS=tree, the repaired dressing
# lemma (ledger §119: the walls counted once on the whole closed set, the pieces a forest on their multiplicity->=2 link sites,
# kappa_U = 2 z1 + kappa' <= the page's kappa) -- the thresholds move up to 0.4378 at gamma = 6 and 0.4952 at gamma = 5/2 (S13
# staked for multi-spine pieces).  Theorem 8.7's region beta = 0.2452 PASS in both modes at gamma = 5/2 and 6 with the left side
# 3e-6.  EVERY THRESHOLD IS CONDITIONAL on the junction theorem (S13, general form; the double's isolated plaquettes cost 3 each and b1(T) <= 3n, so S10' alone proves only gamma = 72) and on S12's remainder (the tail over F > F0 uses 4u^F for every minimal leaf: cycle-rank->=2
# components and multiplicity-6 links staked, the non-orientable clause proved in §119 quinquies and awaiting a second reading) and,
# at gamma = 5/2, on S13.  Nothing above 0.2452 is claimed by this arm.
KPCERT="$ROOT/STDLIB/scripts/aperanton_kp_cert.awk"; KPLIB="$ROOT/STDLIB/scripts/aperanton_bessel_cert.awk"; MUTKP="$B/mut_kpcert"; mkdir -p "$MUTKP"
run_kp(){ local c="$1" d="$2"   # $1 = the certificate, $2 = the directory holding aperanton_bessel_cert.awk
  ( cd "$ROOT" || exit 9
    AWKPATH="$d" gawk -M -v BESSEL_LIB=1 -v DRESS=page -v SCAN=1 -v BETA0=4256 -v BETA1=4264 -v AK0=20 -v AK1=26 -v GN=6 -v GD=1 -f "$c" 2>&1 | tr -d '\r'
    AWKPATH="$d" gawk -M -v BESSEL_LIB=1 -v DRESS=tree -v SCAN=1 -v BETA0=4374 -v BETA1=4382 -v AK0=22 -v AK1=40 -v GN=6 -v GD=1 -f "$c" 2>&1 | tr -d '\r'
    AWKPATH="$d" gawk -M -v BESSEL_LIB=1 -v DRESS=tree -v SCAN=1 -v BETA0=4948 -v BETA1=4956 -v AK0=40 -v AK1=58 -v GN=5 -v GD=2 -f "$c" 2>&1 | tr -d '\r'
    for m in page tree; do for gg in "5 2" "6 1"; do set -- $gg
      AWKPATH="$d" gawk -M -v BESSEL_LIB=1 -v DRESS=$m -v P=2452 -v Q=10000 -v AN=2 -v AD=1000 -v GN=$1 -v GD=$2 -f "$c" 2>&1 | tr -d '\r'; done; done
    # THE LOCAL THEOREM'S COLUMN (LOCAL=1; S1 section 24, 2026-10-30, the author): gamma(s) = 3 theta(s)^4 from the EXACT maxima of r_v^2
    # over the whole local family through k = 8 (local_stars_exact.2026-10-30b.txt), the s-tail at the STAKED rate 4.6125 until the k = 9..24
    # maxima are read; both dressings' scans pinned at their beta* on the 2e-4 grid (page 0.4764; tree 0.4816, its narrow window 0.4810..0.4820 at 06:1x), the KAT at Theorem 8.7's 0.2452 in both dressings, and the sighted
    # negative at beta = 0.60 (the dressing has no root: FAIL by name).  The float road's number (0.4773) was read HIGH by this certificate
    # at 04:4x -- kp_reach6.py had dropped the surfaces' 2^chi -- and corrected in place (law 18); the certificate is the road of record.
    AWKPATH="$d" gawk -M -v BESSEL_LIB=1 -v LOCAL=1 -v DRESS=page -v SCAN=1 -v BETA0=4756 -v BETA1=4768 -v AK0=30 -v AK1=50 -v F0=20 -f "$c" 2>&1 | tr -d '\r'
    AWKPATH="$d" gawk -M -v BESSEL_LIB=1 -v LOCAL=1 -v DRESS=tree -v SCAN=1 -v BETA0=4810 -v BETA1=4820 -v AK0=30 -v AK1=60 -v F0=20 -f "$c" 2>&1 | tr -d '\r'
    for m in page tree; do AWKPATH="$d" gawk -M -v BESSEL_LIB=1 -v LOCAL=1 -v DRESS=$m -v P=2452 -v Q=10000 -v AN=2 -v AD=1000 -v F0=20 -f "$c" 2>&1 | tr -d '\r'; done
    AWKPATH="$d" gawk -M -v BESSEL_LIB=1 -v LOCAL=1 -v DRESS=page -v P=6000 -v Q=10000 -v AN=40 -v AD=10000 -v F0=20 -f "$c" 2>&1 | tr -d '\r' ); }
cc_kp(){ gawk -M -v BESSEL_LIB=1 -f "$KPLIB" > "$2.smoke" 2>&1 && AWKPATH="$ROOT/STDLIB/scripts" gawk -M -v BESSEL_LIB=1 -v P=1 -v Q=1 -v AN=1 -v AD=1000 -f "$1" > "$2.smoke" 2>&1 && cp "$1" "$2"; }   # THE BUILDER HANDS THE RUNNER THE MUTANT SOURCE (19:3x): until run e the smoke test's OUTPUT was written to the .o the runner then ran as a program -- every kp tooth a false bleed and its comment control a certain RED, caught by the hand pre-check before the gate reached it
run_mut_kp(){ run_kp "$1" "$ROOT/STDLIB/scripts"; }
cc_kplib(){ gawk -M -v BESSEL_LIB=1 -f "$1" > "$2.smoke" 2>&1 && cp "$1" "$2"; }   # the source to the .o (19:3x), as cc_kp
run_mut_kplib(){ mkdir -p "$MUTKP/lib"; cp "$1" "$MUTKP/lib/aperanton_bessel_cert.awk"; run_kp "$KPCERT" "$MUTKP/lib"; }
RUNKP="$B/run.kpcert.txt"; rm -f "$RUNKP"; run_kp "$KPCERT" "$ROOT/STDLIB/scripts" > "$RUNKP"
dk_have "$RUNKP" "KP-CERT SCAN dress=page gamma=6/1 F0=20: beta* = 0.4260 (the largest beta with a certified PASS on the 2e-4 grid, alpha on the 1e-4 grid)"
dk_have "$RUNKP" "KP-CERT SCAN dress=page beta=0.4262 gamma=6/1 F0=20: no passing alpha in [0.0020, 0.0026]"
dk_have "$RUNKP" "KP-CERT SCAN dress=tree gamma=6/1 F0=20: beta* = 0.4378 (the largest beta with a certified PASS on the 2e-4 grid, alpha on the 1e-4 grid)"
dk_have "$RUNKP" "KP-CERT SCAN dress=tree gamma=5/2 F0=20: beta* = 0.4952 (the largest beta with a certified PASS on the 2e-4 grid, alpha on the 1e-4 grid)"
dk_have "$RUNKP" "KP-CERT dress=tree beta=2452/10000 alpha=2/1000 gamma=5/2 F0=20:"
dk_have "$RUNKP" "KP-CERT SCAN dress=page graded=S24-local gamma=6/1 F0=20: beta* = 0.4764 (the largest beta with a certified PASS on the 2e-4 grid, alpha on the 1e-4 grid)"
dk_have "$RUNKP" "KP-CERT SCAN dress=page graded=S24-local beta=0.4766 gamma=6/1 F0=20: no passing alpha in [0.0030, 0.0050]"
dk_have "$RUNKP" "KP-CERT SCAN dress=tree graded=S24-local gamma=6/1 F0=20: beta* = 0.4816 (the largest beta with a certified PASS on the 2e-4 grid, alpha on the 1e-4 grid)"
dk_have "$RUNKP" "KP-CERT SCAN dress=tree graded=S24-local beta=0.4816 gamma=6/1 F0=20: PASS for alpha in [0.0041, 0.0052]"
dk_have "$RUNKP" "KP-CERT SCAN dress=tree graded=S24-local beta=0.4818 gamma=6/1 F0=20: no passing alpha in [0.0030, 0.0060]"
dk_have "$RUNKP" "KP-CERT dress=page graded=S24-local beta=2452/10000 alpha=2/1000 gamma=6/1 F0=20:"
dk_have "$RUNKP" "KP-CERT dress=tree graded=S24-local beta=2452/10000 alpha=2/1000 gamma=6/1 F0=20:"
dk_have "$RUNKP" "KP-CERT dress=page graded=S24-local beta=6000/10000 alpha=40/10000 gamma=6/1 F0=20: kappa_U in [0.000000, 0.000000]"
dk_have "$RUNKP" "-> FAIL (the dressing iteration leaves [0, 3]: no root)"
grep -c -- '-> PASS' "$RUNKP" | grep -qx 6 || dk_red "arm 131: Theorem 8.7's region did not PASS in every mode (want six PASS lines: four at the junction column, two at the local column)"
dk_say "arm 131 (C2, THE KOTECKÝ–PREISS CERTIFICATE): S1 §14's inequality certified in exact integer intervals -- the page's dressing beta* = 0.4260 at gamma = 6 (its float 0.4266), the repaired dressing 0.4378 at gamma = 6 and 0.4952 at gamma = 5/2, beta = 0.2452 PASS in both modes at gamma = 5/2 and 6; THE LOCAL THEOREM'S COLUMN (S1 §24's exact table through k = 8, the s-tail staked at 4.6125): beta* = 0.4764 on the page's dressing and 0.4816 on the tree's (both readings under the tail stake), 0.2452 PASS in both dressings, beta = 0.60 refused by name; every threshold conditional on the tail k = 9..24, on S12's remainder and (at the junction column) on S13, nothing above 0.2452 claimed"
# ---- ARM 132 (THE ONE-BLOCK FLOOR CERTIFIED): aperanton_floor_cert.awk -- the Peierls floor of the one-block split with its two proved
# constants (the chessboard constant K = (I(beta)/I(6 beta))^3, the Christoffel edge at M = 3(1 + sqrt 2)) enclosed on the grid 2^-128
# by exact integer division, every series with a closed tail, both bisections two-sided: theta_c in [0.65631675, 0.65631771],
# s_c(107.8) = 12.049905 (the ledger's 12.050), beta_SF in [57.96, 57.97] (the ledger's 58.0) -- conditional on (b) and the split's
# hypotheses, a foothold's floor and not a gap (ledger §116).
FLOORCERT="$ROOT/STDLIB/scripts/aperanton_floor_cert.awk"; MUTFLOOR="$B/mut_floorcert"; mkdir -p "$MUTFLOOR"
cc_floor(){ gawk -M -f "$1" > "$2.smoke" 2>&1 && cp "$1" "$2"; }   # the source to the .o (19:3x), as cc_kp
run_mut_floor(){ gawk -M -f "$1" 2>&1 | tr -d '\r'; }
RUNFLOOR="$B/run.floorcert.txt"; rm -f "$RUNFLOOR"; run_mut_floor "$FLOORCERT" > "$RUNFLOOR"
dk_have "$RUNFLOOR" "FLOOR-CERT theta_c in [0.65631675, 0.65631771] (ledger 0.6563)"
dk_have "$RUNFLOOR" "FLOOR-CERT s_c(107.8) in [12.049905, 12.049905] (ledger 12.050, K = 3146.9)"
dk_have "$RUNFLOOR" "FLOOR-CERT beta_SF in [57.96, 57.97] (the Peierls floor with K and theta_c proved; ledger 58.0)"
dk_have "$RUNFLOOR" "FLOOR-CERT KAT J(1) = I_1(1) e^-1 in [0.2079104153, 0.2079104153] (A&S 0.207910)"
dk_say "arm 132 (THE ONE-BLOCK FLOOR CERTIFIED): aperanton_floor_cert.awk -- theta_c in [0.65631675, 0.65631771], s_c(107.8) = 12.049905, beta_SF in [57.96, 57.97]: the ledger's 0.6563, 12.050 and 58.0 as certified intervals, conditional on (b)"
# ---- ARM 133 (THE BESSEL CONCORDANCE): aperanton_bessel_diff.awk -- two Bessel-ratio engines sharing no line (law 6) on one grid:
# ALOGON's alo_bessel_i (term recurrence at 2^-256, closed tail, the Bessel recurrence as its law-4 check; the grid
# bessel_grid.2026-10-29a.txt, 1001 beta x (u, spin1, a_1..a_7), 70c9785fc) against aperanton_bessel_cert.awk's rational series with the
# tail 2 t_{K+1}.  Two enclosures of one value must intersect; a parting would be a finding on one engine (16-bis).  Live at stride 10
# (909 cells); the whole grid in the record (9009 cells): every cell of this engine INSIDE the grid's, slack 0 (ledger §119 bis).
BDIFF="$ROOT/STDLIB/scripts/aperanton_bessel_diff.awk"; BGRID="$ROOT/STDLIB/build/alogon/bessel_grid.2026-10-29a.txt"; MUTBD="$B/mut_besseldiff"; mkdir -p "$MUTBD"
cc_bdiff(){ AWKPATH="$ROOT/STDLIB/scripts" gawk -M -v BESSEL_LIB=1 -v STRIDE=500 -f "$1" "$BGRID" > "$2.smoke" 2>&1 && cp "$1" "$2"; }   # the source to the .o (19:3x), as cc_kp
run_mut_bdiff(){ ( cd "$ROOT" && AWKPATH="$ROOT/STDLIB/scripts" gawk -M -v BESSEL_LIB=1 -v STRIDE=10 -f "$1" "$BGRID" 2>&1 | tr -d '\r' ); }
RUNBD="$B/run.besseldiff.txt"; rm -f "$RUNBD"; run_mut_bdiff "$BDIFF" > "$RUNBD"
dk_have "$RUNBD" "BESSEL-DIFF rows=909 (stride 10) agree=909 part=0 inside=909 max_slack_units_1e-40=0 against ALO-GRID END rows=9009 refused=0"
dk_have "$RUNBD" "BESSEL-DIFF CONCORD: two engines sharing no line agree on every read cell of the ALOGON grid"
dk_have "$ROOT/STDLIB/build/aperanton/bessel_diff.2026-10-29a.txt" "BESSEL-DIFF rows=9009 (stride 1) agree=9009 part=0 inside=9009 max_slack_units_1e-40=0 against ALO-GRID END rows=9009 refused=0"
dk_say "arm 133 (THE BESSEL CONCORDANCE): aperanton_bessel_cert.awk against ALOGON's grid, 909 cells live and 9009 in the record, every enclosure inside the grid's, 0 partings"
# ---- ARM 134 (THE PIECE FORMULA ON CUBICAL BANDS): aperanton_band_cert.c -- S12's non-orientable clause (ledger §119 quinquies)
# rests on the piece formula |W(P)| = u^|P| 2^chi(P) prod |chi_1/2(w_c)| for a piece of either orientability; measured here on every
# cycle of unit squares in [0,2]^4 to eight squares (480,764 cycles: 196,224 Moebius bands, 277,520 annuli), the interior links
# integrated EXACTLY over the 8-point spherical 3-design as the trace of a cyclic product of integer 8 x 8 matrices, 201 boundary
# assignments per band: four Moebius bands read -4^n tr(w) at every assignment (sign -1, the crosscap's), two annuli +4^n tr(w1) tr(w2),
# 0 partings (record band_cert.2026-10-29a.txt, ledger §119 sexies).
BANDSRC="$ROOT/STDLIB/scripts/aperanton_band_cert.c"; MUTBAND="$B/mut_bandcert"; mkdir -p "$MUTBAND"
cc_band(){ gcc -O2 -x c -o "$2.exe" "$1"; }
run_mut_band(){ "$1.exe" 8 200 2>&1 | tr -d '\r'; }
BANDOBJ="$B/band_cert.o"; rm -f "$BANDOBJ.exe"; cc_band "$BANDSRC" "$BANDOBJ" > "$B/band_cert.cc.log" 2>&1 || dk_red "arm 134: aperanton_band_cert.c did not compile ($(tail -1 "$B/band_cert.cc.log"))"
RUNBAND="$B/run.bandcert.txt"; rm -f "$RUNBAND"; run_mut_band "$BANDOBJ" > "$RUNBAND"
dk_have "$RUNBAND" "BAND-CERT MOEBIUS n=7 chi=0 bcycles=1: squares (0000;01) (0000;02) (0000;23) (0001;02) (0011;01) (0101;02) (0100;03) -- 201 assignments, 51 with tr(w) != 0, sign -1, 0 PART: MET"
dk_have "$RUNBAND" "BAND-CERT ANNULUS n=6 chi=0 bcycles=2: squares (0000;01) (0000;02) (0000;23) (0001;02) (0001;01) (0100;03) -- 201 assignments, 12 with tr(w) != 0, sign +1, 0 PART: MET"
dk_have "$RUNBAND" "BAND-CERT END cycles=480764 moebius=196224 annuli=277520"
grep -c 'PART: MET' "$RUNBAND" | grep -qx 6 || dk_red "arm 134: want six bands MET (four Moebius, two annuli)"
grep -q 'REFUTED\|INCONSISTENT' "$RUNBAND" && dk_red "arm 134: a band REFUTED the piece formula or the three readings parted"
dk_have "$ROOT/STDLIB/build/aperanton/band_cert.2026-10-29a.txt" "BAND-CERT END cycles=480764 moebius=196224 annuli=277520"
dk_say "arm 134 (THE PIECE FORMULA ON CUBICAL BANDS): aperanton_band_cert.c -- four Moebius bands and two annuli in [0,2]^4, the interior links integrated exactly, 201 assignments each, 0 partings, the crosscap's sign -1"
# ---- ARM 135 (THE DRESSING LEMMA'S COUNT ON A CLOSED BASE): aperanton_dress_kat.c -- the repaired dressing lemma (ledger §119) is a
# COUNT: D(U; z) = sum over decorations of z^|D| <= exp((2|U| - 1.5E) z + (8|U| - 6E) lambda'), lambda' the least root of
# sum_{s>=2} 5^{s-1} z^s e^{2zs} e^{P(s) lambda'}.  On the 14-plaquette L-tromino surface (closed, E = 0, 112 sites, two walls -- the
# L's interior faces) every link-connected attachment of at most N plaquettes is generated once and the admissible ones counted by
# size: 2, 1, 0, 1, 46 to N = 5 (the record); the truncation D_N(z) sits under the bound at every z where the recursion has a root
# (0.02..0.08) and the sighted control (half the walls, no pieces) is VIOLATED at every z -- the instrument can see a violation.
DRESSSRC="$ROOT/STDLIB/scripts/aperanton_dress_kat.c"; MUTDRESS="$B/mut_dresskat"; mkdir -p "$MUTDRESS"
cc_dress(){ gcc -O2 -x c -o "$2.exe" "$1" -lm; }
run_mut_dress(){ "$1.exe" 4 2>&1 | tr -d '\r'; }
DRESSOBJ="$B/dress_kat.o"; rm -f "$DRESSOBJ.exe"; cc_dress "$DRESSSRC" "$DRESSOBJ" > "$B/dress_kat.cc.log" 2>&1 || dk_red "arm 135: aperanton_dress_kat.c did not compile ($(tail -1 "$B/dress_kat.cc.log"))"
RUNDRESS="$B/run.dresskat.txt"; rm -f "$RUNDRESS"; run_mut_dress "$DRESSOBJ" > "$RUNDRESS"
dk_have "$RUNDRESS" "DRESS-KAT base=L-tromino |U|=14 links=28 excess=0 sites=112 (8|U|-6E=112) wall-sites=28"
dk_have "$RUNDRESS" "DRESS-KAT counts to N=4: attached 104 6386 302260 12201399 ; admissible decorations by size 2 1 0 1"
dk_have "$RUNDRESS" "DRESS-KAT z=0.04 D_N=1.081602560 bound=11.888392 (lambda'=0.012103, kappa_U=0.176826) HOLDS; control: fake bound 1.040000 VIOLATED (sighted)"
grep -q 'bound=.* VIOLATED;\|NOT VIOLATED' "$RUNDRESS" && dk_red "arm 135: the lemma's bound was VIOLATED or the control did not fire"
dk_have "$ROOT/STDLIB/build/aperanton/dress_kat.2026-10-29a.txt" "DRESS-KAT counts to N=5: attached 104 6386 302260 12201399 442075830 ; admissible decorations by size 2 1 0 1 46"
dk_say "arm 135 (THE DRESSING LEMMA'S COUNT ON A CLOSED BASE): aperanton_dress_kat.c -- the L-tromino's decorations counted to N = 4 live and N = 5 on the record, the bound HOLDS at every rooted z, the sighted control VIOLATED"
# ---- ARM 136 (THE JUNCTION INTEGRAL BY A SPHERICAL DESIGN): aperanton_box_cert.c and aperanton_junction_cert.c -- the second engine
# on the junction theorem's meeting object (the author, 17:5x): the 2x2x2 box's twelve interior walls with every boundary link held and
# the six centre-to-face-centre links integrated, F(g) = int prod_{12 walls} chi_j(holonomy).  Haar is replaced by the uniform measure
# on a spherical t-design (8 points t = 3, 2T t = 5, 2I t = 11), exact for integrands of degree <= t in a link; the strength is read on
# the run from Haar's moments against the Catalan numbers and a degree past it is REFUSED by name.  Spin 1/2 at the identity hold reads
# F = 73/324 by the brute 24^6 sum (the record) and by the streamed octahedron contraction (live) and under 2I (the record): two roads
# and two designs, one number; spin 1 (the meeting object) reads F_1(1) = 16981/202500 under 2I (live), the phi-part of the sum zero.
# The piece formula tr(w_top) tr(w_bottom)/2^n is the control on the tube of four (1/4) and the ring of eight (1/64).
BOXSRC="$ROOT/STDLIB/scripts/aperanton_box_cert.c"; JUNSRC="$ROOT/STDLIB/scripts/aperanton_junction_cert.c"; MUTBOX="$B/mut_boxcert"; MUTJUN="$B/mut_junccert"; mkdir -p "$MUTBOX" "$MUTJUN"
TUBE4="$ROOT/STDLIB/build/aperanton/tube4.shape"; RECBOX="$ROOT/STDLIB/build/aperanton/box_cert.2026-10-29a.txt"; RECJUN="$ROOT/STDLIB/build/aperanton/junction_cert.2026-10-29a.txt"
cc_box(){ gcc -O2 -x c -o "$2.exe" "$1" -lm; }
DBOOK="$ROOT/STDLIB/build/aperanton/doubled_book.shape"
run_mut_box(){ { "$1.exe" "$TUBE4" DESIGN=8; "$1.exe" "$TUBE4" DESIGN=24; "$1.exe" "$TUBE4" DESIGN=24 HOLD=rand:3; "$1.exe" ring8 DESIGN=8; "$1.exe" box222 DESIGN=8; "$1.exe" "$DBOOK" TREE=1 DESIGN=auto; } 2>&1 | tr -d '\r'; }
run_mut_jun(){ { "$1.exe" SPIN=1 DESIGN=24; "$1.exe" SPIN=2 DESIGN=24; "$1.exe" SPIN=2 DESIGN=120; "$1.exe" SPIN=2 DESIGN=120 HOLD=list:0-2:3; "$1.exe" SPIN=2 DESIGN=120 HOLD=list:0-2:10; "$1.exe" GRAPH=BOOK4; "$1.exe" GRAPH=C3; "$1.exe" GRAPH=K2222; "$1.exe" GRAPH=K24; } 2>&1 | tr -d '\r'; }
BOXOBJ="$B/box_cert.o"; rm -f "$BOXOBJ.exe"; cc_box "$BOXSRC" "$BOXOBJ" > "$B/box_cert.cc.log" 2>&1 || dk_red "arm 136: aperanton_box_cert.c did not compile ($(tail -1 "$B/box_cert.cc.log"))"
JUNOBJ="$B/junction_cert.o"; rm -f "$JUNOBJ.exe"; cc_box "$JUNSRC" "$JUNOBJ" > "$B/junction_cert.cc.log" 2>&1 || dk_red "arm 136: aperanton_junction_cert.c did not compile ($(tail -1 "$B/junction_cert.cc.log"))"
RUNBOX="$B/run.boxcert.txt"; rm -f "$RUNBOX"; run_mut_box "$BOXOBJ" > "$RUNBOX"
RUNJUN="$B/run.junccert.txt"; rm -f "$RUNJUN"; run_mut_jun "$JUNOBJ" > "$RUNJUN"
dk_have "$RUNBOX" "BOX-CERT design=8 strength=3 moments: tr^2=8/8=1 tr^4=32/8!=2 tr^6=128/8!=5 tr^8=512/8!=14 tr^10=2048/8!=42 tr^12=8192/8!=132 (parts first at degree 4, strength 3: CONSISTENT)"
dk_have "$RUNBOX" "BOX-CERT design=24 strength=5 moments: tr^2=24/24=1 tr^4=48/24=2 tr^6=144/24!=5 tr^8=528/24!=14 tr^10=2064/24!=42 tr^12=8208/24!=132 (parts first at degree 6, strength 5: CONSISTENT)"
dk_have "$RUNBOX" "BOX-CERT whole set (z^4): 1/4"
dk_have "$RUNBOX" "BOX-CERT whole set (z^4): -1/16"
dk_have "$RUNBOX" "BOX-CERT whole set (z^8): 1/64"
dk_have "$RUNBOX" "BOX-CERT REFUSED DEGREE-EXCEEDS-DESIGN max-free-link-degree=4 strength=3"
[ "$(grep -c 'BOX-CERT whole set (z^4): 1/4' "$RUNBOX")" -eq 2 ] || dk_red "arm 136: the two designs did not both read 1/4 on the tube of four"
# a closed complex integrated whole (TREE=1 holds a spanning tree at the identity, exact by gauge invariance): the double of two
# plaquettes on a spine (a multiplicity-4 link) at spin 1 reads 1 exactly, rho = 1 -- the boundary case of the lemma rho(D) <= 1
dk_have "$RUNBOX" "BOX-CERT whole set (z^4): 1/1  rho = (whole set)^(1/4) = 1.000000 (the float reading of the exact rational)"
dk_have "$RUNBOX" "BOX-CERT phi-parts of every sum: all zero (the integrals are rational)"
grep -q 'REFUSED PHI-PART\|DO NOT VANISH' "$RUNBOX" && dk_red "arm 136: a box sum carried a phi-part"
RECBOXB="$ROOT/STDLIB/build/aperanton/box_cert.2026-10-29b.txt"
dk_have "$RECBOXB" "BOX-CERT TREE: 7 links of a spanning tree (Kruskal by descending degree) held at the identity; vertices 8, links 12, free 5 = the cycle rank"
dk_have "$RECBOXB" "BOX-CERT designs by free link: 4:24 4:24 4:24 4:24 4:24; assignments 7962624"
dk_have "$RECBOXB" "BOX-CERT whole set (z^8): 1/1  rho = (whole set)^(1/8) = 1.000000 (the float reading of the exact rational)"
dk_have "$RECBOXB" "BOX-CERT designs by free link: 4:120 4:120; assignments 14400"
dk_have "$RECBOX" "BOX-CERT J(z) over 191102976 assignments (|G|^free = 191102976): z^0:1/1 z^1:0/1 z^2:0/1 z^3:4/1 z^4:15/4 z^5:3/1 z^6:5/1 z^7:3/1 z^8:15/8 z^9:4/3 z^10:0/1 z^11:0/1 z^12:73/324"
dk_have "$RUNJUN" "JUNCTION-CERT F(2j=1, hold=identity) = 73/324  (sum 43057152 over 24^6)"
dk_have "$RUNJUN" "JUNCTION-CERT REFUSED DEGREE-EXCEEDS-DESIGN 2j=2: each interior link lies on four walls, degree 8 > strength 5"
dk_have "$RUNJUN" "JUNCTION-CERT design=120 strength=11 table: 0 products and inverses outside the table, -1 present; moments: tr^2=(120+0phi)/120=1 tr^4=(240+0phi)/120=2 tr^6=(600+0phi)/120=5 tr^8=(1680+0phi)/120=14 tr^10=(5040+0phi)/120=42 tr^12=(15960+0phi)/120!=132 tr^14=(53040+0phi)/120!=429 (parts first at degree 12, strength 11: CONSISTENT)"
dk_have "$RUNJUN" "JUNCTION-CERT F(2j=2, hold=identity) = 16981/202500  (sum 250395033600 over 120^6)"
dk_have "$RECJUN" "JUNCTION-CERT F(2j=1, hold=identity) = 73/324  (sum 672768000000 over 120^6)"
dk_have "$RECJUN" "JUNCTION-CERT F(2j=2, hold=rand) = 4169/12150000  (sum 1024573440 over 120^6)"
# the star mode (S1 section 23's vertex-star integrals): the books' invariants, the cycle law, the 4D star refused at degree 12, and
# the box double's face-centre star S(K24) = 1/27 -- with S(K222) = F_1(1) the section-23 bound on the box is 16981/3985807500,
# exactly 27 times the exact integral 3^-12 F_1(1): the bound HOLDS (record b)
dk_have "$RUNJUN" "STAR-CERT S(BOOK4, 2j=2) = 3/1  = 3; S^(1/4) = 1.316074 (the float reading of the exact rational)"
dk_have "$RUNJUN" "STAR-CERT S(C3, 2j=2) = 1/3  = 0.333333333; S^(1/3) = 0.693361 (the float reading of the exact rational)"
dk_have "$RUNJUN" "STAR-CERT REFUSED DEGREE-EXCEEDS-DESIGN vertex 1: degree 12 of its variable > 11, past every finite subgroup of SU(2) (2I's first invariant is degree 12): the character calculus's object"
dk_have "$RUNJUN" "STAR-CERT S(K24, 2j=2) = 1/27  = 0.037037037; S^(1/8) = 0.662338 (the float reading of the exact rational)"
RECJUNB="$ROOT/STDLIB/build/aperanton/junction_cert.2026-10-29b.txt"
# THE ONE-SEGMENT THEOREM (record d): a single held segment h enters the box integral as chi_1(h)/3 exactly -- the integrand is linear
# in D^1(h) and invariant under simultaneous conjugation of all six spokes, so F(h) = (F_1(1)/3) chi_1(h): at h = -i (chi_1 = -1)
# F = -16981/607500, at a third-turn (chi_1 = 0) F = 0; read live through the hold-list door and pinned (the parting with the author's
# evaluator at a twelve-wall hold was split by these two probes, 19:3x)
dk_have "$RUNJUN" "JUNCTION-CERT F(2j=2, hold=identity) = -16981/607500  (sum -83465011200 over 120^6)"
dk_have "$RUNJUN" "JUNCTION-CERT F(2j=2, hold=identity) = 0/1  (sum 0 over 120^6)"
dk_have "$RECJUNB" "JUNCTION-CERT F(2j=2, hold=identity, orient=same) = 87049/3037500  (sum 85572648960 over 120^6)"
dk_have "$RECJUNB" "STAR-CERT S(K222, 2j=1) = 73/324  = 0.225308642; S^(1/12) = 0.883212 (the float reading of the exact rational)"
dk_have "$RECJUNB" "STAR-CERT S(BOOK5, 2j=2) = 6/1  = 6; S^(1/5) = 1.430969 (the float reading of the exact rational)"
# the doubled stars (record c): doubled trees 1, the doubled triangle 23/15 (s > 1), the doubled four-cycle 259/225, K23 = 1/27
RECJUNC="$ROOT/STDLIB/build/aperanton/junction_cert.2026-10-29c.txt"
dk_have "$RECJUNC" "STAR-CERT S(0-1,0-1,1-2,1-2,2-0,2-0, 2j=2) = 23/15  = 1.53333333; S^(1/6) = 1.073840 (the float reading of the exact rational)"
dk_have "$RECJUNC" "STAR-CERT S(0-1,0-1,1-2,1-2,2-3,2-3,3-0,3-0, 2j=2) = 259/225  = 1.15111111; S^(1/8) = 1.017747 (the float reading of the exact rational)"
dk_have "$RECJUNC" "STAR-CERT S(0-1,0-1,0-2,0-2,0-3,0-3, 2j=2) = 1/1  = 1; S^(1/6) = 1.000000 (the float reading of the exact rational)"
dk_have "$RECJUNC" "STAR-CERT S(0-3,0-4,1-3,1-4,2-3,2-4, 2j=2) = 1/27  = 0.037037037; S^(1/6) = 0.577350 (the float reading of the exact rational)"
# THE MIXED-SPIN STARS of the author's local theorem (Theorem V, record e), the sheet's edges at spin 1/2 and the piece's at spin 1:
# the hub-and-cycle stars W_3 = 1/9, W_4 = 7/108, W_5 = 5/162, the two-walls-on-one-link star 1/2, the chord 1, the two-plaquette
# disc's boundary vertex 1/3 -- the author's design_star.py readings met on this road, two engines sharing no line
RECJUNE="$ROOT/STDLIB/build/aperanton/junction_cert.2026-10-29e.txt"
dk_have "$RECJUNE" "STAR-CERT S(1-2:1,2-3:1,3-1:1,0-1:2,0-2:2,0-3:2, 2j=2) = 1/9  = 0.111111111; S^(1/6) = 0.693361 (the float reading of the exact rational)"
dk_have "$RECJUNE" "STAR-CERT S(1-2:1,2-3:1,3-4:1,4-1:1,0-1:2,0-2:2,0-3:2,0-4:2, 2j=2) = 7/108  = 0.0648148148; S^(1/8) = 0.710329 (the float reading of the exact rational)"
dk_have "$RECJUNE" "STAR-CERT S(1-2:1,2-3:1,3-4:1,4-5:1,5-1:1,0-1:2,0-2:2,0-3:2,0-4:2,0-5:2, 2j=2) = 5/162  = 0.0308641975; S^(1/10) = 0.706229 (the float reading of the exact rational)"
dk_have "$RECJUNE" "STAR-CERT S(0-1:1,1-2:1,2-0:1,0-1:2,0-2:2, 2j=2) = 1/2  = 0.5; S^(1/5) = 0.870551 (the float reading of the exact rational)"
dk_have "$RECJUNE" "STAR-CERT S(0-1:1,0-1:1,0-1:2, 2j=2) = 1/1  = 1; S^(1/3) = 1.000000 (the float reading of the exact rational)"
dk_have "$RECJUNE" "STAR-CERT S(0-1:1,0-1:1,0-2:2,2-1:2, 2j=2) = 1/3  = 0.333333333; S^(1/4) = 0.759836 (the float reading of the exact rational)"
grep -q 'DOES NOT -- REFUSED\|REFUSED PHI-PART' "$RUNJUN" && dk_red "arm 136: a design sum carried a phi-part"
dk_say "arm 136 (THE JUNCTION INTEGRAL BY A SPHERICAL DESIGN): the box interior's F_1(1) = 16981/202500 under 2I, F_1/2(1) = 73/324 by two roads and two designs, the piece formula on the tube and the ring, every degree past a design's strength refused by name"
TAB137=$(grep "^R2TAB=" "$ROOT/STDLIB/build/aperanton/local_tail_table.2026-10-31g.txt" | sed "s/^R2TAB=//"); [ -n "$TAB137" ] || dk_red "arm 137: the table record of tag 2026-10-31g has no R2TAB line"
# ---- ARM 137 (THE GRADED COLUMN): aperanton_kp_cert.awk under GRADED=1 -- the junction theorem's size-graded gamma(s) (S1 section 21:
# gamma(2) = sqrt 3, gamma(s) = 3 e(D)^{3/D}, D = min(8, s), e(r) = (3^r + 3(-1)^r)/(4 3^{r/2})) DERIVED in the certificate as the
# 2D-th root of E(D)^6/3^D bracketed on the 2^-128 grid (no float typed), z_br(s) = (gamma(s) a_1 e^{2 alpha~})^s for s >= 2 with no
# prefactor 3, the s-tail at gamma(8), the proved supremum.  THE COLUMN IS THE SUB-GAS'S (pieces whose rest links each carry one
# Y-plaquette), said on every line it prints; it bounds nothing about the multiply-used pieces, and nothing above beta = 0.2452 is
# claimed.  The author's float 0.4709 (page, F0 = 20) is the known answer; the certified grid reads 0.4700.
run_kpg(){ local c="$1" d="$2"
  ( cd "$ROOT" || exit 9
    AWKPATH="$d" gawk -M -v BESSEL_LIB=1 -v GRADED=1 -v "R2TAB=$TAB137" -v DRESS=page -v SCAN=1 -v BETA0=4696 -v BETA1=4704 -v AK0=26 -v AK1=34 -v GN=6 -v GD=1 -f "$c" 2>&1 | tr -d '\r'
    AWKPATH="$d" gawk -M -v BESSEL_LIB=1 -v GRADED=1 -v "R2TAB=$TAB137" -v DRESS=page -v P=4700 -v Q=10000 -v AN=3 -v AD=1000 -v GN=6 -v GD=1 -f "$c" 2>&1 | tr -d '\r'
    AWKPATH="$d" gawk -M -v BESSEL_LIB=1 -v GRADED=1 -v "R2TAB=$TAB137" -v DRESS=tree -v P=4700 -v Q=10000 -v AN=3 -v AD=1000 -v GN=6 -v GD=1 -f "$c" 2>&1 | tr -d '\r'
    AWKPATH="$d" gawk -M -v BESSEL_LIB=1 -v GRADED=1 -v "R2TAB=$TAB137" -v DRESS=page -v P=2452 -v Q=10000 -v AN=2 -v AD=1000 -v GN=6 -v GD=1 -f "$c" 2>&1 | tr -d '\r' ); }
run_mut_kpg(){ run_kpg "$1" "$ROOT/STDLIB/scripts"; }
RUNKPG="$B/run.kpgraded.txt"; rm -f "$RUNKPG"; run_kpg "$KPCERT" "$ROOT/STDLIB/scripts" > "$RUNKPG"
dk_have "$RUNKPG" "KP-CERT GRADED (S1 section 21 J6-prime with Theorem L"
dk_have "$RUNKPG" "KP-CERT SCAN dress=page graded=S21-J6prime+S24-table gamma=6/1 F0=20: beta* = 0.4704 (the largest beta with a certified PASS on the 2e-4 grid, alpha on the 1e-4 grid)"
dk_have "$RUNKPG" "KP-CERT dress=page graded=S21-J6prime+S24-table beta=4700/10000 alpha=3/1000 gamma=6/1 F0=20: kappa_U in [0.084202, 0.084202] root in [0.084202, 0.084202] u in [0.11643322, 0.11643322] u~ in [0.12666177, 0.12666183] r_hi=0.648692 LHS in [0.0010014, 0.0010014] alpha=0.0029999 -> PASS"
dk_have "$RUNKPG" "KP-CERT dress=tree graded=S21-J6prime+S24-table beta=4700/10000 alpha=3/1000 gamma=6/1 F0=20: kappa_U in [0.078218, 0.078219] root in [0.022166, 0.022166] u in [0.11643322, 0.11643322] u~ in [0.12590615, 0.12590621] r_hi=0.644822 LHS in [0.0008947, 0.0008947] alpha=0.0029999 -> PASS"
dk_have "$RUNKPG" "KP-CERT dress=page graded=S21-J6prime+S24-table beta=2452/10000 alpha=2/1000 gamma=6/1 F0=20: kappa_U in [0.016419, 0.016419] root in [0.016419, 0.016419] u in [0.06114701, 0.06114701] u~ in [0.06215930, 0.06215930] r_hi=0.315809 LHS in [0.0000030, 0.0000030] alpha=0.0019999 -> PASS"
grep -q 'graded=S21-J6prime+S24-table beta=4700/10000 alpha=3/1000 gamma=6/1 F0=20: .* -> PASS' "$RUNKPG" || dk_red "arm 137: the page point beta = 0.4700, alpha = 0.0030 did not PASS under the graded column"
grep -q 'dress=tree graded=S21-J6prime+S24-table beta=4700/10000 alpha=3/1000 gamma=6/1 F0=20: .* -> PASS' "$RUNKPG" || dk_red "arm 137: the tree point beta = 0.4700, alpha = 0.0030 did not PASS under the graded column"
grep -q 'dress=page graded=S21-J6prime+S24-table beta=2452/10000 alpha=2/1000 gamma=6/1 F0=20: .* -> PASS' "$RUNKPG" || dk_red "arm 137: Theorem 8.7's beta = 0.2452 did not PASS under the graded column"
[ "$(grep -c 'graded=S21-J6prime+S24-table' "$RUNKPG")" -ge 8 ] || dk_red "arm 137: the graded column's lines do not all carry their label"
dk_say "arm 137 (THE GRADED COLUMN): the junction theorem's gamma(s) derived in the certificate from its closed form, the sub-gas's beta* = 0.4700 (page, F0 = 20) certified on the grid, the tree point and Theorem 8.7's point PASS, every line labelled the sub-gas's"
# ---- ARM 138 (THE VERTEX STAR BY INTERTWINERS, EXACT): aperanton_star_exact.c -- the local theorem's vertex star S(G) without the
# design sum over assignments: every vertex integrated by the projector onto its legs' invariants (P_w from the 2I design, degree
# <= 11, a degree-12 vertex refused by name), P_w = V_w R_w from the reduced row echelon form (rank REQUIRED equal to the
# Clebsch-Gordan count; P^2 = P, P = V R checked), S = sum_i W_V(i) W_R(i) across a vertex bipartition chosen on the whole cost,
# modulo three primes = 1 (mod 20) below 2^28, Wang's reconstruction from two verified by the third; the icosian table (its one line
# shared with the design road) re-certified in F_p on every run.  Live: the twenty-one known answers of the design road (the
# degree-12 book a sighted refusal) and the m = 6 vertex across a forced 3|3 split -- a second contraction order, the same residues.
SESRC="$ROOT/STDLIB/scripts/aperanton_star_exact.c"; MUTSE="$B/mut_starexact"; mkdir -p "$MUTSE"
cc_se(){ gcc -O2 -x c -o "$2.exe" "$1" -lm; }
run_mut_se(){ "$1.exe" KAT; "$1.exe" GRAPH=0-1:1,1-5:1,5-2:1,2-3:1,3-4:1,4-0:1,0-1:2,0-2:2,0-3:2,1-2:2,1-3:2,2-3:2,2-4:2,0-5:2,4-5:2 SPLIT=0,1,2; }
SEOBJ="$B/star_exact.o"; rm -f "$SEOBJ.exe"; cc_se "$SESRC" "$SEOBJ" > "$B/star_exact.cc.log" 2>&1 || dk_red "arm 138: aperanton_star_exact.c did not compile ($(tail -1 "$B/star_exact.cc.log"))"
RUNSE="$B/run.starexact.txt"; rm -f "$RUNSE"; run_mut_se "$SEOBJ" > "$RUNSE"
dk_have "$RUNSE" "STAR-EXACT KAT 21 met, 0 parted of 21"
dk_have "$RUNSE" "STAR-EXACT KAT 17 0-1:1,1-2:1,2-3:1,3-0:1,0-1:2,0-2:2,0-3:2,1-2:2,1-3:2,2-3:2                                = 3271/3600    expected 3271/3600    MET"
dk_have "$RUNSE" "STAR-EXACT KAT 20 0-1:1,1-5:1,5-2:1,2-3:1,3-4:1,4-0:1,0-1:2,0-2:2,0-3:2,1-2:2,1-3:2,2-3:2,2-4:2,0-5:2,4-5:2  = 647/2880     expected 647/2880     MET"
dk_have "$RUNSE" "STAR-EXACT KAT 11 0-1:2,0-1:2,0-1:2,0-1:2,0-1:2,0-1:2                                                        = 15/1         expected 15/1         MET"
dk_have "$RUNSE" "STAR-EXACT table p=268435361: 0 defects (unit norm, inverses, products), -1 present; moments tr^2=120*1 tr^4=120*2 tr^6=120*5 tr^8=120*14 tr^10=120*42 tr^12!=120*132 (parts first at degree 12)"
dk_have "$RUNSE" "STAR-EXACT p=268435361 split A=11 B=52: r_A=324 r_B=16 cut=3888; S = 44086780 (mod p)"
dk_have "$RUNSE" "STAR-EXACT S(0-1:1,1-5:1,5-2:1,2-3:1,3-4:1,4-0:1,0-1:2,0-2:2,0-3:2,1-2:2,1-3:2,2-3:2,2-4:2,0-5:2,4-5:2) = 647/2880  = 0.2246527778 (3 primes"
grep -q 'PARTED\|STAR-EXACT REFUSED' "$RUNSE" && dk_red "arm 138: a known answer parted or a run refused"
dk_say "arm 138 (THE VERTEX STAR BY INTERTWINERS, EXACT): twenty-one known answers met live, the degree-12 vertex refused by name, the m = 6 vertex the same across a forced 3|3 split; the sixteen-chord vertex of a Hamiltonian sheet cycle in reach"
# ---- ARM 139 (THE DENSE SHEET VERTICES AND THE PINCHED SHEET): the records.  The rest-link-complete family on the design road
# (junction_cert g: m = 3..6, the stakes first, m = 5 and 6 unguessed -- the per-corner rate NOT monotone in the wall density,
# 1.0699, 1.1135, 1.0816, 1.0737), the pinched sheet on the box engine (box_cert c: two cubes sharing a vertex read 1/256 where
# section 24 (ii)'s stated form 2^(chi - F) gives 1/512 -- the identity holds with the normalisation's chi), the sixteen-chord vertex
# on the intertwiner road (star_exact a: m = 8, k = 16, staked UNGUESSED against the threshold S > 0.4878, single-road), and the
# local enumeration read exactly line by line (local_stars_exact a), the two roads compared id by id.
RECJUNG="$ROOT/STDLIB/build/aperanton/junction_cert.2026-10-29g.txt"; RECBOXC="$ROOT/STDLIB/build/aperanton/box_cert.2026-10-29c.txt"; RECSEA="$ROOT/STDLIB/build/aperanton/star_exact.2026-10-29a.txt"; RECLSX="$ROOT/STDLIB/build/aperanton/local_stars_exact.2026-10-29a.txt"
dk_have "$RECJUNG" "# m = 6 UNGUESSED (120^5 = 2.49e10 assignments, about 25 minutes)."
dk_have "$RECJUNG" "STAR-CERT S(0-1:1,1-5:1,5-2:1,2-3:1,3-4:1,4-0:1,0-1:2,0-2:2,0-3:2,1-2:2,1-3:2,2-3:2,2-4:2,0-5:2,4-5:2, 2j=2) = 647/2880  = 0.224652778; S^(1/15) = 0.905248"
dk_have "$RECJUNG" "DENSE-FAMILY m=3 k=3 S=3/4 r2=3/2=1.500000 rate=(r2)^(1/6)=1.069913"
dk_have "$RECJUNG" "DENSE-FAMILY m=4 k=6 S=3271/3600 r2=3271/900=3.634444 rate=(r2)^(1/12)=1.113533"
dk_have "$RECJUNG" "DENSE-FAMILY m=5 k=7 S=8101/21600 r2=8101/2700=3.000370 rate=(r2)^(1/14)=1.081643"
dk_have "$RECJUNG" "DENSE-FAMILY m=6 k=9 S=647/2880 r2=647/180=3.594444 rate=(r2)^(1/18)=1.073664"
dk_have "$RECBOXC" "BOX-CERT whole set (z^6): 1/16  rho = (whole set)^(1/6) = 0.629961 (the float reading of the exact rational)"
dk_have "$RECBOXC" "BOX-CERT whole set (z^12): 1/256  rho = (whole set)^(1/12) = 0.629961 (the float reading of the exact rational)"
dk_have "$RECSEA" "# (64 S)^(1/32).  STAKED BEFORE THE RUN: S UNGUESSED; it beats the K_4-on-the-square vertex (m = 4, k = 6, r^2 = 3271/900, rate"
dk_have "$RECSEA" "RECON3 S = 8940909179/23328000000 = 0.383269426397 (three primes 268435361 268435121 268434961; bound 3109883153803; UNVERIFIED until a fourth prime)"
dk_have "$RECSEA" "VERIFY: 8940909179/23328000000 mod 268434941 = 101333462; the fourth prime read 101333462: VERIFIED"
dk_have "$RECSEA" "SIXTEEN-CHORD S=8940909179/23328000000 r2=64S=24.529243 rate=(r2)^(1/32)=1.105166 (beats m=4 iff S > 0.4878: NO) -- VERIFIED by the fourth prime 268434941 (three primes reconstruct, the fourth verifies); the author cut bound 0.530673 written before the value HOLDS"
dk_have "$RECSEA" "STAR-EXACT p=268435361 split A=15 B=240: r_A=6561 r_B=6561 cut=20736; S = 152364752 (mod p)"
dk_have "$RECSEA" "STAR-EXACT p=268435121 split A=15 B=240: r_A=6561 r_B=6561 cut=20736; S = 97567234 (mod p)"
dk_have "$RECSEA" "STAR-EXACT p=268434961 split A=15 B=240: r_A=6561 r_B=6561 cut=20736; S = 4830705 (mod p)"
dk_have "$RECSEA" "STAR-EXACT p=268434941 split A=169 B=86: r_A=6561 r_B=6561 cut=20736; S = 101333462 (mod p)"
dk_have "$RECLSX" "STAR-EXACT-FILE two roads: 1025 ids read by both, 1025 MET, 0 PARTED"
dk_have "$RECLSX" "STAR-EXACT-FILE theta(k=1) = 1.000000 at id=1 (r2 = 1/1) over 1 lines read"
dk_have "$RECLSX" "STAR-EXACT-FILE theta(k=2) = 1.000000 at id=3 (r2 = 1/1) over 12 lines read"
dk_have "$RECLSX" "STAR-EXACT-FILE theta(k=3) = 1.069913 at id=67 (r2 = 3/2) over 131 lines read"
dk_have "$RECLSX" "STAR-EXACT-FILE theta(k=4) = 1.051990 at id=228 (r2 = 3/2) over 1539 lines read"
dk_have "$RECLSX" "STAR-EXACT-FILE theta(k=5) = 1.084472 at id=3607 (r2 = 9/4) over 2118 lines read"
dk_have "$RECLSX" "STAR-EXACT-FILE theta(k=1) = 1.000000 at id=1 (r2 = 1/1) over 1 lines read (the addendum included)"
dk_have "$RECLSX" "STAR-EXACT-FILE theta(k=2) = 1.000000 at id=3 (r2 = 1/1) over 12 lines read (the addendum included)"
dk_have "$RECLSX" "STAR-EXACT-FILE theta(k=3) = 1.069913 at id=67 (r2 = 3/2) over 131 lines read (the addendum included)"
dk_have "$RECLSX" "STAR-EXACT-FILE theta(k=4) = 1.051990 at id=228 (r2 = 3/2) over 1539 lines read (the addendum included)"
dk_have "$RECLSX" "STAR-EXACT-FILE theta(k=5) = 1.084472 at id=3607 (r2 = 9/4) over 2118 lines read (the addendum included)"
dk_have "$RECLSX" "STAR-EXACT-FILE theta(k=1) = 1.000000 at id=1 (r2 = 1/1) over 1 lines read (both addenda included)"
dk_have "$RECLSX" "STAR-EXACT-FILE theta(k=2) = 1.000000 at id=3 (r2 = 1/1) over 12 lines read (both addenda included)"
dk_have "$RECLSX" "STAR-EXACT-FILE theta(k=3) = 1.069913 at id=67 (r2 = 3/2) over 131 lines read (both addenda included)"
dk_have "$RECLSX" "STAR-EXACT-FILE theta(k=4) = 1.051990 at id=228 (r2 = 3/2) over 1541 lines read (both addenda included)"
dk_have "$RECLSX" "STAR-EXACT-FILE theta(k=5) = 1.084472 at id=3607 (r2 = 9/4) over 2124 lines read (both addenda included)"
# the second snapshot of the local enumeration (k = 5 CLOSED at 9,620, k = 6 partial; local_stars_exact 10-30a): the first
# snapshot's 3,809 lines reproduced identically, theta(5) exact over the closed k = 5, the six-spoke hubs by the Lie-algebra route
RECLSY="$ROOT/STDLIB/build/aperanton/local_stars_exact.2026-10-30a.txt"
dk_have "$RECLSY" "STAR-EXACT-FILE against the first snapshot: 3809 ids in both, 3809 identical, 0 parted"
dk_have "$RECLSY" "STAR-EXACT-FILE id=11306 k=6 m=6 S=61/3888 r2=61/243 r2^(1/2k)=0.891204"
dk_have "$RECLSY" "STAR-EXACT-FILE theta(k=5) = 1.084472 at id=3607 (r2 = 9/4) over 9620 lines read (the addendum included)"
dk_have "$RECLSY" "STAR-EXACT-FILE theta(k=6) = 1.065407 at id=13828 (r2 = 77/36) over 14840 lines read (the addendum included)"
# THE LOCAL ENUMERATION k = 1..8 READ WHOLE (local_enum.c, byte-identical to the author's Python through k = 5, k = 6..8 from C;
# local_stars_exact 10-30b: 307,529 rows exact on eight shards; theta(k) over every row; the earlier records reproduced line for line)
RECLSZ="$ROOT/STDLIB/build/aperanton/local_stars_exact.2026-10-30b.txt"
dk_have "$RECLSZ" "LOCAL-EXACT theta(k=1) = 1.000000 at id=1 (r2 = 1/1) over 1 rows read, 0 deferred"
dk_have "$RECLSZ" "LOCAL-EXACT theta(k=2) = 1.000000 at id=3 (r2 = 1/1) over 12 rows read, 0 deferred"
dk_have "$RECLSZ" "LOCAL-EXACT theta(k=3) = 1.069913 at id=67 (r2 = 3/2) over 131 rows read, 0 deferred"
dk_have "$RECLSZ" "LOCAL-EXACT theta(k=4) = 1.051990 at id=228 (r2 = 3/2) over 1541 rows read, 0 deferred"
dk_have "$RECLSZ" "LOCAL-EXACT theta(k=5) = 1.084472 at id=3607 (r2 = 9/4) over 9620 rows read, 0 deferred"
dk_have "$RECLSZ" "LOCAL-EXACT theta(k=6) = 1.113533 at id=43118 (r2 = 3271/900) over 36726 rows read, 0 deferred"
dk_have "$RECLSZ" "LOCAL-EXACT theta(k=7) = 1.085364 at id=66272 (r2 = 85/27) over 92396 rows read, 0 deferred"
dk_have "$RECLSZ" "LOCAL-EXACT theta(k=8) = 1.062376 at id=159784 (r2 = 8531/3240) over 167102 rows read, 0 deferred"
dk_have "$RECLSZ" "LOCAL-EXACT determinism control: 26145 rows in both records, 26145 identical, 0 parted"
dk_have "$RECLSZ" "LOCAL-EXACT K4-on-the-square row: STAR-EXACT-FILE id=43118 k=6 m=4 S=3271/3600 r2=3271/900 r2^(1/2k)=1.113533"
# the seven-rest-link vertex (m = 7, k = 12; star_exact b, staked unguessed against S > 0.4128) and THE WHOLE WALL FAMILY read in one
# process (wall_stars_exact a: 134,736 configurations; 8 rows deferred by cost and 5,552 dense rows REFUSED for want of a split under that
# pass's memory cap -- refusals read as refusals (law 10): they are rows of the tail enumeration k = 9..24, read by the tail passes at
# MEMMB=400 and 3000 -- so the WALL-EXACT theta(k) lines are the maxima over the rows READ, as each line says; the author's stake "0 refused"
# failed and the pin is the batch line as it stands, corrected 2026-10-30 06:3x by the author, law 18)
RECSEB="$ROOT/STDLIB/build/aperanton/star_exact.2026-10-29b.txt"; RECWALL="$ROOT/STDLIB/build/aperanton/wall_stars_exact.2026-10-29a.txt"
dk_have "$RECSEB" "STAKED BEFORE THE RUN: S UNGUESSED; it beats the"
dk_have "$RECSEB" "STAR-EXACT S(0-1:1,1-7:1,7-2:1,2-4:1,4-3:1,3-5:1,5-0:1,0-1:2,0-2:2,0-3:2,0-7:2,1-2:2,1-3:2,1-4:2,2-3:2,2-5:2,7-4:2,7-5:2,4-5:2) = 177703/900000  = 0.1974477778 (three primes"
dk_have "$RECSEB" "SEVEN-REST S=177703/900000 r2=32S=6.318329 rate=(r2)^(1/24)=1.079838 (beats m=4 iff S > 0.4128: NO)"
dk_have "$RECWALL" "# shard 0: STAR-EXACT-FILE batch: 16835 lines, 16158 read, 1 deferred, 676 refused; 30 vertex types cached"
dk_have "$RECWALL" "WALL-EXACT theta(k=1) = 1.000000 at id=1 (r2 = 1/1) over 91 rows read, 0 deferred"
dk_have "$RECWALL" "WALL-EXACT theta(k=2) = 1.000000 at id=7 (r2 = 1/1) over 471 rows read, 0 deferred"
dk_have "$RECWALL" "WALL-EXACT theta(k=3) = 1.069913 at id=146 (r2 = 3/2) over 1635 rows read, 0 deferred"
dk_have "$RECWALL" "WALL-EXACT theta(k=4) = 1.051990 at id=1631 (r2 = 3/2) over 4573 rows read, 0 deferred"
dk_have "$RECWALL" "WALL-EXACT theta(k=5) = 1.084472 at id=58901 (r2 = 9/4) over 9844 rows read, 0 deferred"
dk_have "$RECWALL" "WALL-EXACT theta(k=6) = 1.113533 at id=123188 (r2 = 3271/900) over 16974 rows read, 0 deferred"
dk_have "$RECWALL" "WALL-EXACT theta(k=7) = 1.085364 at id=67900 (r2 = 85/27) over 23289 rows read, 0 deferred"
dk_have "$RECWALL" "WALL-EXACT theta(k=8) = 1.062376 at id=74487 (r2 = 8531/3240) over 25699 rows read, 0 deferred"
dk_have "$RECWALL" "WALL-EXACT theta(k=9) = 1.080620 at id=79179 (r2 = 323/80) over 22590 rows read, 0 deferred"
dk_have "$RECWALL" "WALL-EXACT theta(k=10) = 1.065357 at id=84845 (r2 = 862/243) over 15732 rows read, 0 deferred"
dk_have "$RECWALL" "WALL-EXACT theta(k=11) = 1.072972 at id=134332 (r2 = 61031/12960) over 6620 rows read, 0 deferred"
dk_have "$RECWALL" "WALL-EXACT theta(k=12) = 1.080160 at id=87226 (r2 = 3866011/607500) over 1396 rows read, 0 deferred"
dk_have "$RECWALL" "WALL-EXACT theta(k=13) = 1.072827 at id=88106 (r2 = 26869/4320) over 190 rows read, 0 deferred"
dk_have "$RECWALL" "WALL-EXACT theta(k=14) = 1.080002 at id=105115 (r2 = 16772087/1944000) over 21 rows read, 13 deferred"
dk_have "$RECWALL" "WALL-EXACT theta(k=15) = 0.000000 at id= (r2 = ) over 0 rows read, 39 deferred"
dk_have "$RECWALL" "WALL-EXACT theta(k=16) = 0.000000 at id= (r2 = ) over 0 rows read, 7 deferred"
dk_have "$RECWALL" "WALL-EXACT determinism control: 21017 rows in both runs, 21017 identical, 0 parted"
dk_say "arm 139 (THE DENSE SHEET VERTICES AND THE PINCHED SHEET): the rest-link-complete family's rates on the record, the pinched sheet's 1/256, the sixteen-chord vertex read exactly, the local enumeration on two roads id by id"
# ---- ARM 11: STAGE Α5a, GRIFFITHS' INEQUALITIES FOR III'S Z2 WEIGHTS -- Griffiths.lean builds with no sorry
lean_arm 11 Griffiths 40 sum_chi_nonneg griffiths_one partition_pos griffiths_two griffiths_two_expect sum_chi_eq prod_chi_eq_chi_bd sum_chi_w_eq expect_eq_Wc expect_update_mono expect_mono
dk_say "arm 11 (STAGE Α5a, MECHANISM S's INEQUALITIES): Griffiths.lean -- III's Z2 gauge measure as finite sums (spins on links, plaquette characters, the weight prod (1 + y_p chi_p) with 0 <= y_p <= 1): orthogonality, Griffiths I, the partition function positive, Griffiths II by Ginibre's duplication, the character expansion in closed form (surfaces bounded by A over closed surfaces), the two forms equal, and MONOTONICITY IN THE COUPLINGS (every Wilson expectation grows with every y_p, the mechanism of the infinite-volume limit) -- 40 theorems built with Mathlib v4.35.0, no sorry, no axiom (OD:2); Griffiths 1967 and Ginibre 1970 are W=0, Mathlib carries neither"

# ---- ARMS 12 AND 13: STAGE Α5b (Lattice.lean) AND Α5c (Rectangle.lean) -- the infinite volume and the string tension
lean_arm 12 Lattice 21 WcL_restrict WcL_cut WcL_eq_Wc WcL_eq_expect WcL_le_one WcL_mono_box WcL_le_Winf Winf_tendsto bdL_union Winf_mul_le
dk_say "arm 12 (STAGE Α5b, THE INFINITE VOLUME): Lattice.lean -- on any lattice of links and finite plaquettes the combinatorial Wilson expectation of a box, THE RESTRICTION (a zero coupling is an absent plaquette), THE BRIDGE to the finite configuration model, MONOTONICITY IN THE BOX, and THE INFINITE-VOLUME WILSON EXPECTATION as the supremum over all boxes, reached by every exhausting sequence (Winf_tendsto), with Griffiths II surviving the limit (Winf_mul_le) -- 21 theorems built above Griffiths.lean, no sorry, no axiom (OD:2)"
lean_arm 13 Rectangle 38 mem_plaqZ_shift bdL_shift WcL_shift Winf_shift rect_add cube_exhausts bdL_surf Winf_rect_pos Winf_rect_mul_le string_tension_exists
dk_say "arm 13 (STAGE Α5c, THE STRING TENSION): Rectangle.lean -- Z^3, the R x T rectangle loop, translation invariance of the box and the infinite-volume expectations, THE XOR IDENTITY of two rectangles side by side, the minimal surface bounded by the rectangle (so the expectation is positive), Griffiths II in the limit on adjacent rectangles, subadditivity of -log W in the width, and Fekete: THE STRING TENSION EXISTS (string_tension_exists: for every height T, -log W_inf(R x T)/R converges to a nonnegative limit) -- 38 theorems built above Lattice.lean, no sorry, no axiom (OD:2)"

# ---- ARMS 14-17: STAGES Α2 (MacWilliams.lean), Α4d (MassGap.lean), Α5d (StrongCoupling.lean), Α6a (Inversion.lean)
lean_arm 14 MacWilliams 19 sgn2_add sum_sgn2_mul orth_orth sum_chi2 sum_chi2_pow cosetEnum_eq_sum macwilliams
dk_say "arm 14 (STAGE Α2, THE MEET IN GENERAL FORM): MacWilliams.lean -- the dot-product character of F_2^n, the orthogonal of a code with THE DOUBLE ORTHOGONAL THE CODE (Mathlib's orthogonal_orthogonal on the nondegenerate symmetric dot form), THE CHARACTER SUM OVER A CODE (|H| if v is orthogonal to H, else 0), the enumerator against a character factoring over the coordinates, and MACWILLIAMS FOR COSETS: |K^perp| W_{w+K}(X) = sum over u in K^perp of (-1)^{u.w} (1-X)^{wt u} (1+X)^{n-wt u} -- Α0's T3 is its instance; 19 theorems built above TheoremT.lean, no sorry, no axiom (OD:2); MacWilliams 1963 is W=0"
lean_arm 15 MassGap 3 finite_volume_mass_gap finite_volume_mass_gap_log mass_gap_rate
dk_say "arm 15 (STAGE Α4d, THE MASS GAP ON EVERY FINITE CROSS-SECTION): MassGap.lean -- lam0 - |lam_i| > 0 and log lam0 - log |lam_i| > 0 for every non-Perron eigenvalue of an entrywise-positive symmetric transfer matrix, every finite group, coupling and cross-section; the rate theorem restated -- 3 theorems built above Perron.lean, no sorry, no axiom (OD:2)"
lean_arm 16 StrongCoupling 10 bdL_symmDiff WcL_mono_coupling bdL_ne_of_nonempty closed_subsurface_empty surface_unique WcL_surf_eq card_surf Winf_rect_ge string_tension_le
dk_say "arm 16 (STAGE Α5d, THE STRONG-COUPLING FLOOR): StrongCoupling.lean -- a nonempty set of plaquettes of the planar rectangle has a boundary (its lowest plaquette's bottom link is covered once), so inside the minimal surface the only closed surface is empty and the only surface bounded by the rectangle is the minimal one; with the couplings cut to the surface the box expectation is exactly y^{RT}; monotonicity lifts it to W_inf(R x T) >= y^{RT} and THE STRING TENSION IS BOUNDED BY THE STRONG-COUPLING VALUE, sigma(T) <= T log(1/y) -- 10 theorems built above Rectangle.lean, no sorry, no axiom (OD:2)"
lean_arm 17 Inversion 3 inv_eq_of_inversion spectrum_closed_of_similar_inv spectrum_closed_of_inversion
dk_say "arm 17 (STAGE Α6a, THE INVERSION THEOREM OF THE CENTRE, ABSTRACT): Inversion.lean -- M V N = c V with V invertible and N similar to M gives M^-1 = c^-1 V N V^-1 and every spectral value lambda of M has c/lambda in the spectrum (Mathlib's spectrum of a unit's inverse, of a unit multiple and under conjugation) -- the concurrent author's derivation on Z2, Z4 and the staked loci is its instance; 3 theorems built above Mathlib, no sorry, no axiom (OD:2); the kernel instance on the orbit dump lands with the dump"

# ---- ARM 18: STAGE Α6b -- THE KERNEL INSTANCE OF THE CENTRE'S INVERSION THEOREM.  Z2Inversion.lean re-emits byte for byte
# from ΣΤΡΟΦΙΓΞ's COMMITTED orbit dump (git show HEAD:..., never the worktree copy), the emitter's own check reads K integer and
# the orientation of R at both couplings, the alphabet is the bare kernel's, and the kernel reduces D K = M and
# M (S R)(K D) = mu2 (S R) on the record's integers at y = 1/2 and y = 1/4 (OD:2, as arm 4)
INVEMIT="$ROOT/STDLIB/scripts/aperanton_emit_inv.sh"
INVART="$ROOT/LEAN/aperanton/Aperanton/Z2Inversion.lean"
DUMP="STDLIB/build/strophinx/dump.run"
RUNINV="$B/run_inv.txt"
[ -f "$INVEMIT" ] && [ -f "$INVART" ] || dk_red "arm 18: missing $INVEMIT or $INVART"
git ls-files --error-unmatch "$DUMP" >/dev/null 2>&1 || dk_red "arm 18: $DUMP is not tracked -- the kernel instance stands on a COMMITTED dump (ΣΤΡΟΦΙΓΞ's run of record d, fe7e918c8), never on a worktree copy"
rm -f "$B/dump.head.run" "$B/Z2Inversion.reemit.lean" "$B/reemit_inv.log"
git show "HEAD:$DUMP" > "$B/dump.head.run" || dk_red "arm 18: HEAD carries no $DUMP"
[ "$(grep -c '^SFX-ORBIT G=Z2 ' "$B/dump.head.run")" -eq 64 ] && [ "$(grep -c '^SFX-INVERSION G=Z2 ' "$B/dump.head.run")" -eq 2 ] || dk_red "arm 18: HEAD's dump does not carry 64 Z2 orbit lines and 2 inversion lines"
APERANTON_ROOT="$ROOT" bash "$INVEMIT" "$B/Z2Inversion.reemit.lean" "$B/dump.head.run" > "$B/reemit_inv.log" 2>&1 || dk_red "arm 18: the inversion emitter refused HEAD's dump ($(tail -1 "$B/reemit_inv.log"))"
cmp -s "$B/Z2Inversion.reemit.lean" "$INVART" || dk_red "arm 18: Z2Inversion.lean does not regenerate byte-identically from HEAD's dump (the emitter or the dump moved)"
grep -qF 'half: K integer, M V N = mu2 V with R[o][Rf(o)] = 1 (orientation A), mu2 = 419904' "$B/reemit_inv.log" || dk_red "arm 18: the emitter's own check at y = 1/2 did not read mu2 = 419904 under orientation A"
grep -qF 'quarter: K integer, M V N = mu2 V with R[o][Rf(o)] = 1 (orientation A), mu2 = 2624400000000' "$B/reemit_inv.log" || dk_red "arm 18: the emitter's own check at y = 1/4 did not read mu2 = 2624400000000 under orientation A"
strip_lean "$INVART" > "$B/code_inv.txt"
for tok in import axiom sorry native_decide; do grep -qE "(^|[^a-zA-Z_.])$tok([^a-zA-Z_]|$)" "$B/code_inv.txt" && dk_red "arm 18: a forbidden token stands in Z2Inversion.lean's code: $tok"; done
ninv=$(grep -c '^theorem ' "$B/code_inv.txt"); [ "$ninv" -eq 6 ] || dk_red "arm 18: $ninv theorems in Z2Inversion.lean, not 6"
nbyi=$(grep -c ':= by ' "$B/code_inv.txt"); ndeci=$(grep -cE ':= by decide( \+kernel)?$' "$B/code_inv.txt")
[ "$nbyi" -eq "$ndeci" ] && [ "$ndeci" -eq 6 ] || dk_red "arm 18: $nbyi proof terms, $ndeci of them decide -- decide must be the only proof term in Z2Inversion.lean"
for th in mu2_eq_half M_eq_DK_half inversion_half mu2_eq_quarter M_eq_DK_quarter inversion_quarter; do grep -q "^theorem $th " "$B/code_inv.txt" || dk_red "arm 18: Z2Inversion.lean lost $th"; done
grep -q '^def mu2_half : Int := 419904$' "$B/code_inv.txt" && grep -q '^def mu2_quarter : Int := 2624400000000$' "$B/code_inv.txt" || dk_red "arm 18: the literals mu2 = 419904 and 2624400000000 are not in Z2Inversion.lean as the dump gives them"
grep -q '^namespace Z2Inv' "$B/code_inv.txt" && grep -q '^end Z2Inv' "$B/code_inv.txt" || dk_red "arm 18: the namespace Z2Inv is not closed"
grep -q '^import Aperanton.Z2Inversion$' "$ROOT/LEAN/aperanton/Aperanton.lean" || dk_red "arm 18: Aperanton.lean does not import Z2Inversion"
for ph in 'Z2Inversion.lean' 'aperanton_emit_inv.sh' 'fe7e918c8' 'Α6b'; do grep -qF -- "$ph" "$PRE" || dk_red "arm 18: the page does not name $ph"; done
rm -f "$RUNINV"
kernel "$INVART" Z2Inversion > "$RUNINV"
grep -qF 'KERNEL-ACCEPTED Z2Inversion theorems=6 errors=0' "$RUNINV" || dk_red "arm 18: $(cat "$RUNINV")"
dk_say "arm 18 (STAGE Α6b, THE KERNEL INSTANCE, OD:2): $(cat "$RUNINV") -- Z2Inversion.lean re-emitted byte for byte from HEAD's $DUMP (64 orbit lines, 2 inversion lines), K = D^-1 M integer and R oriented by the emitter's own check at both couplings, 6 theorems, decide the only proof term: the bare kernel reduced D K = M and M (S R)(K D) = mu2 (S R) at y = 1/2 (mu2 = 419904 = 648^2) and y = 1/4 (mu2 = 2624400000000 = 1620000^2) on ΣΤΡΟΦΙΓΞ's integers -- the hypothesis of Inversion.lean's theorem discharged on the record"

# ---- ARMS 19-20: STAGE Α8 -- THE SPECTRAL LAW (Spectral.lean) AND THE X-TRANSFER MODEL (XTransfer.lean)
lean_arm 19 Spectral 13 moment_sq_le log_moment_div_tendsto pow_spectral exists_moment wilson_nonneg wilson_log_convex wilson_succ_le string_tension_of_posSemidef string_tension_nonneg_of_transfer
dk_say "arm 19 (STAGE Α8a, THE SPECTRAL LAW OF THE WILSON LOOP): Spectral.lean -- for any real positive semidefinite A and any f, <f, A^R f> is a moment sequence on A's eigenvalues with nonnegative masses (every power A^R = U diag(lambda^R) U*), nonnegative, nonincreasing once the eigenvalues lie in [0, 1], LOG-CONVEX in R (Cauchy-Schwarz on the masses), and log <f, A^R f> / R -> log x*, x* the largest eigenvalue carrying mass, given only <f, A f> > 0; in the transfer matrix's terms sigma = log lambda_0 - log x* >= 0 -- the string tension of every finite group by no Griffiths inequality"
lean_arm 20 XTransfer 22 pathSum_eq_chain chain_num chain_Z exists_gram posSemidef_of_gram tensorKernel_posSemidef tensorKernel_pos transfer_posSemidef transfer_pos perron_limit slab_tendsto string_tension_of_slab z2k_posSemidef z2k_pos
dk_say "arm 20 (STAGE Α8b, THE X-TRANSFER MODEL AND THE INFINITE SLAB): XTransfer.lean -- THE CHAIN (the slab's Gibbs sum over all sequences of cross-section configurations is the matrix sandwich of the site weights and the kernel), THE GRAM FACTORISATION of a positive semidefinite matrix and its converse, THE TENSOR KERNEL positive semidefinite and positive with its single-link kernel, the transfer matrix D^1/2 K D^1/2 positive semidefinite and entrywise positive, THE PERRON LIMIT M^a v / lambda_0^a -> <Omega, v> Omega, THE INFINITE SLAB (the centred two-point function of any observable converges to <F Omega, M^R F Omega> / lambda_0^R) and THE STRING TENSION OF THE SLAB MODEL for every finite group; the Z2 link kernel 1 + y s s' positive semidefinite at 0 <= y and positive below 1"

# ---- ARM 21: STAGE Α8c -- THE STRING TENSION IS A GAP (GapBound.lean)
lean_arm 21 GapBound 18 exists_moment_perron string_tension_gap permMat_orth permMat_comm perron_dot_odd tensorKernel_mul tensorKernel_one tensorKernel_mulVec_eq_zero transfer_mulVec_eq_zero dot_transfer_pos z2kInv_mul tensorKernel_z2k_flip string_tension_z2
dk_say "arm 21 (STAGE Α8c, THE STRING TENSION IS A GAP): GapBound.lean -- the moment sequence with its Perron mass named (<Omega, f>^2), an observable odd under a permutation fixing M has Perron mass zero (the permutation fixes the Perron line), so the string tension is log lambda_0 - log lambda_k for a NON-Perron eigenvalue: STRICTLY POSITIVE, bounded below by the finite-volume mass gap of its sector; the tensor kernel multiplicative and unital, a left-invertible link kernel making the transfer matrix injective, the quadratic form positive on every nonzero vector; THE Z2 INSTANCE WITH NO HYPOTHESIS LEFT (string_tension_z2: the link kernel's inverse (y + s s')/4y, the gauge flip at one endpoint of the T-line)"

# ---- ARM 23: STAGE Α8d -- THE NONABELIAN WILSON LOOP'S STATIC POTENTIAL IS AT LEAST THE GAP (Nonabelian.lean)
lean_arm 23 Nonabelian 9 perron_dot_avg exists_gram_sum_zero potential_gap_family nonabelian_potential_gap prod_ins pathSumPair_eq_sum perron_unit_sign "slab_tendsto'" nonabelian_slab_potential_gap
dk_say "arm 23 (STAGE Α8d, THE NONABELIAN WILSON LOOP'S STATIC POTENTIAL): Nonabelian.lean -- an observable whose average over a finite family of M-fixing permutations vanishes has zero Perron mass; every Gram vector of a nontrivial real class function's class matrix sums to zero, so the T-line vectors F_j = phi_j o h average to zero under the endpoint's gauge group; a finite sum of such two-point functions has a static potential E = lim -log W(R)/R that is a gap (log lambda_0 - log lambda_k, lambda_k non-Perron, strictly positive; the static potential of the T-line sector at every separation, in every phase -- the area law not claimed); the loop's pair weight chi(h(c_a) h(c_a+R)^-1) on the slab is the sum over j of F_j's two-insertion sums, each converging to <F_j Omega, M^R F_j Omega> / lambda_0^R for ANY unit Perron vector (the sign immaterial): the nonabelian Wilson loop of the x-transfer model converges and its static potential is at least the gap once W(1) > 0"

# ---- ARM 24: STAGE Α8e -- THE GAUGE ACTION ON A CROSS-SECTION (GaugeAction.lean)
lean_arm 24 GaugeAction 11 gauge_one gauge_mul gaugePerm_apply hol_gauge plaqWeight_gauge plaqWeight_pos linkKernel_left linkKernel_right tensorKernel_gauge lineHol_gauge lattice_potential_gap
dk_say "arm 24 (STAGE Α8e, THE GAUGE ACTION): GaugeAction.lean -- the gauge transformation by g at a vertex (g left of every link out of it, g^-1 right of every link into it) is a permutation of the configurations; a square plaquette's holonomy is conjugated by g at its base corner and unchanged otherwise, so a product of class-function plaquette weights is gauge invariant; the link kernel w(a b^-1) of a class function is invariant under simultaneous left and under right multiplication, so the tensor kernel is gauge invariant; a line leaving the vertex by its first link and never returning has holonomy equivariant, h(gauge c) = g h(c): THE LATTICE THEOREM -- on any finite cross-section of square plaquettes, for any finite group, positive class-function plaquette weight, class-function link weight with positive semidefinite positive kernel, nontrivial real class function with positive semidefinite class matrix, and T-line leaving a vertex once, the nonabelian Wilson loop of the x-transfer model converges and its static potential is at least the sector's gap once W(1) > 0"

# ---- ARM 25: STAGE Α8f -- THE LINEAR ACTION (LinearAction.lean)
lean_arm 25 LinearAction 16 OrthRep.map_inv classMat_eq_gram classMat_posSemidef sum_rep_invariant sum_rep_eq_zero classMat_mulVec_one abs_char_le linearW_classFn linearW_pos linearKernel_posSemidef linearKernel_pos linear_lattice_potential_gap
dk_say "arm 25 (STAGE Α8f, THE LINEAR ACTION): LinearAction.lean -- for a real orthogonal representation (multiplicative, unital, orthogonal) the inverse is represented by the transpose, so the character's class matrix chi(a b^-1) = tr(rho(a) rho(b)^T) is THE GRAM MATRIX of the representation matrices, positive semidefinite; the average sum_g rho(g) sends every vector to an invariant one, so with no nonzero invariant vector it vanishes and the class matrix kills the constants; |chi(g)| <= d; THE LINEAR ACTION w = C + chi with C > d is a positive class function whose link kernel C J + X is positive semidefinite and positive; THE LATTICE THEOREM FOR THE LINEAR ACTION: three real orthogonal representations (the in-plane weight, the x-plaquette weight, the loop's with no invariant vector), any cross-section of square plaquettes, any T-line leaving a vertex once -- the nonabelian Wilson loop converges and its static potential is at least the sector's gap once W(1) > 0, every representation-theoretic hypothesis discharged"

# ---- ARM 26: STAGE Α8g -- THE SCHUR PRODUCT AND THE POLYNOMIAL ACTIONS (Schur.lean)
lean_arm 26 Schur 10 posSemidef_hadamard posSemidef_smul_nonneg posSemidef_hadamard_pow linkKernel_mul linkKernel_pow linkKernel_add linkKernel_smul polyW_classFn polyKernel_posSemidef polyW_pos
dk_say "arm 26 (STAGE Α8g, THE SCHUR PRODUCT): Schur.lean -- the entrywise product of two positive semidefinite matrices is positive semidefinite (the Gram matrix of the entrywise products of the two Gram families), so are nonnegative multiples and entrywise powers; the link kernel of a product of class functions is the entrywise product of the kernels, of a sum the sum; hence EVERY POLYNOMIAL IN THE CHARACTER WITH NONNEGATIVE COEFFICIENTS -- the partial sums of the Wilson action among them -- has a positive semidefinite link kernel, and is a positive class function when its constant term dominates"

# ---- ARM 27: STAGE Α8h -- THE WILSON ACTION'S KERNEL IS POSITIVE SEMIDEFINITE (Wilson.lean)
lean_arm 27 Wilson 9 posSemidef_of_tendsto wilsonW_pos wilsonW_classFn char_inv wilsonKernel_isHermitian wilsonW_partial wilsonKernel_posSemidef wilsonKernel_pos wilson_lattice_potential_gap
dk_say "arm 27 (STAGE Α8h, THE WILSON ACTION): Wilson.lean -- the cone of positive semidefinite matrices is closed under entrywise limits (every quadratic form a limit of nonnegative ones); the Wilson action exp(beta chi) is a positive class function whose kernel is the entrywise limit of the polynomial actions' kernels (the partial sums of the exponential series, each positive semidefinite by the Schur product), hence POSITIVE SEMIDEFINITE for beta >= 0: Bochner's condition for the Wilson action of any real orthogonal representation of any finite group, with no Fourier theory; its invertibility (W(1) > 0) not built; THE LATTICE THEOREM FOR THE WILSON ACTION stated as a theorem (wilson_lattice_potential_gap), the composition of every discharged hypothesis, W(1) > 0 alone remaining"

# ---- ARM 28: STAGE Β1 -- THE SEPARATION THEOREM, W(1) > 0 DISCHARGED FOR FAITHFUL ACTIONS (Separation.lean)
lean_arm 28 Separation 20 monomial_zero monomial_succ classMat_pow_eq_sum quadratic_pow_eq_sum_sq wilson_quadratic_hasSum moments_vanish exists_separating_entry moment_lagrange_exists wilsonKernel_posDef wilsonKernel_not_posDef_of_not_injective tensorKernel_mulVec_injective classMat_diag loop_pair_pos loop_W1_pos wilson_lattice_potential_gap_faithful q8RepZ_mul q8RepZ_one q8RepZ_orth q8RepZ_injective q8_faithful
grep -q 'hR : Function.Injective R.ρ' "$B/code_Separation.txt" || dk_red "arm 28: the corollary lost its faithfulness hypothesis (hR : Function.Injective R.ρ)"
grep -q 'decide' "$B/code_Separation.txt" || dk_red "arm 28: the Q8 instance is no longer decided"
SEPSRC="$ROOT/LEAN/aperanton/Aperanton/Separation.lean"
RUNSEP="$B/run.sep.txt"; rm -f "$RUNSEP"
run_mut_sep "$SEPSRC" > "$RUNSEP"
grep -qF 'KERNEL-ACCEPTED Separation theorems=20 errors=0' "$RUNSEP" || dk_red "arm 28: the standalone compile of Separation.lean did not print KERNEL-ACCEPTED Separation theorems=20 errors=0: $(cat "$RUNSEP")"
dk_say "arm 28 (STAGE Β1, THE SEPARATION THEOREM): Separation.lean -- the Wilson kernel's quadratic form is the exponential series of sums of squares of monomial moments (the n-th power of the class Gram is the Gram of the n-th tensor power, entry by entry); if it vanishes every moment vanishes; a FAITHFUL representation separates any two elements by an entry, and the Lagrange product of separating factors kills every coordinate: THE WILSON KERNEL OF A FAITHFUL REPRESENTATION IS POSITIVE DEFINITE with no character theory; the sighted negative a theorem (a non-faithful kernel has e_a - e_b in its null space); the tensor kernel injective, the loop pair not null, W(1) > 0, and the lattice theorem UNCONDITIONAL for faithful actions (wilson_lattice_potential_gap_faithful, carrying hR); Q8's four-dimensional real representation a homomorphism, unital, orthogonal and injective BY DECISION over Z; the file compiled standalone: $(cat "$RUNSEP")"

# ---- ARMS 29-45 (ADDENDUM I, THE ROAD, W2-W7): Β3 THE UNIFORM GAP AT STRONG COUPLING WITH ITS SHARP COEFFICIENT,
# Β2 THE REALIFICATION, Β4 THE SCALING TARGET, THE DUALITY, THE PLANE, THE FOUR-TORUS AND ITS CERTIFICATES -- every
# count pinned from the BUILT file of the run of record (law 24-quater), every name required by grep on the stripped
# code, every forbidden token refused (lean_arm); the sharp coefficient's statement required verbatim.  The pin of each
# file's DOKIMASIA is the arm's own reading of the committed source (law 24-quater: from a run, never a static count);
# every mutant is read through the fixing door below.
cc_lean(){ cp "$1" "$2"; }
# THE FIXING DOOR (ΠΗΞΙΣ' law: a cache can be stale, a fixing cannot, because its name is its input): a mutant's reading
# is a function of its bytes, the toolchain, the lakefile, the manifest and the sources it imports transitively; the
# imprint of the imprints of that whole names the reading under STDLIB/build/aperanton/fixings/, and a name already
# fixed is read, with the run that fixed it, instead of compiled again.  A changed input is a different name: nothing
# is invalidated.  The imprint is ΑΠΟΤΥΠΩΜΑ's where the exe stands, git's where it does not (the lander's own rule).
FIXDIR="$ROOT/STDLIB/build/aperanton/fixings"; mkdir -p "$FIXDIR"; : > "$B/fixings.log"  # the door's notices go HERE and to no stream a mutant's reading captures: run v printed one to stdout, run w to stderr, and dk_control reads the runner's 1 and 2 MERGED ("$run" ... > "$name.run" 2>&1 in dokimasia.sh), diffing the reading byte for byte against the base run
fix_digest(){ local b="$ROOT/COMPILED/apotypoma.exe" d=""; if [ -x "$b" ]; then d=$("$b" "$1" 2>/dev/null | grep -Eo '[0-9a-f]{64}' | head -n1); fi
  if [ -n "$d" ]; then printf '%s' "$d"; else git hash-object -- "$1"; fi; }
fix_imports(){ # $1 = a lean file: the stems of its transitive Aperanton imports, one per line, sorted
  local todo seen="" s t
  todo=$(grep -oE '^import Aperanton\.[A-Za-z0-9_]+' "$1" | sed 's/^import Aperanton\.//')
  while [ -n "$todo" ]; do
    s=$(printf '%s\n' "$todo" | head -n1); todo=$(printf '%s\n' "$todo" | tail -n +2)
    case " $seen " in *" $s "*) continue;; esac
    seen="$seen $s"
    t=$(grep -oE '^import Aperanton\.[A-Za-z0-9_]+' "$ROOT/LEAN/aperanton/Aperanton/$s.lean" | sed 's/^import Aperanton\.//')
    [ -n "$t" ] && todo=$(printf '%s\n%s\n' "$todo" "$t" | sed '/^$/d')
  done
  printf '%s\n' $seen | sed '/^$/d' | sort -u
}
fix_key(){ # $1 = the (mutant) file: the imprint of the imprints of everything its reading depends on
  local f="$1" tmp s; tmp="$B/fixkey.$$.txt"
  { printf 'file %s\n' "$(fix_digest "$f")"
    printf 'toolchain %s\n' "$(fix_digest "$ROOT/LEAN/aperanton/lean-toolchain")"
    printf 'lakefile %s\n' "$(fix_digest "$ROOT/LEAN/aperanton/lakefile.toml")"
    printf 'manifest %s\n' "$(fix_digest "$ROOT/LEAN/aperanton/lake-manifest.json")"
    for s in $(fix_imports "$f"); do printf 'import %s %s\n' "$s" "$(fix_digest "$ROOT/LEAN/aperanton/Aperanton/$s.lean")"; done
  } > "$tmp"
  fix_digest "$tmp"; rm -f "$tmp"
}
run_mut_lean(){ # the artifact IS the (mutant) source, compiled standalone above the built stages; MUT_STEM is the pin's label
  local f="$1" log key fix line; if [ "${f##*.}" != "lean" ]; then cp "$f" "$f.lean"; f="$f.lean"; fi
  key=$(fix_key "$f"); fix="$FIXDIR/$key.txt"
  if [ -s "$fix" ]; then
    echo "FIXING $MUT_STEM $(basename "$f"): the reading of $(sed -n '2p' "$fix")" >> "$B/fixings.log"
    sed -n '1p' "$fix"
    return 0
  fi
  log="$B/kernel.$MUT_STEM.$(basename "$f").log"
  lean_retry "$log" "$MUT_STEM" "$ROOT/LEAN/aperanton" lake env lean "$f"; local rc=$?
  local nerr; nerr=$(grep -c ' error: ' "$log")
  local nth; nth=$(grep -c '^theorem ' "$f")
  if [ "$rc" -eq 0 ] && [ "$nerr" -eq 0 ]; then line="KERNEL-ACCEPTED $MUT_STEM theorems=$nth errors=0"
  else line="KERNEL-REFUSED $MUT_STEM theorems=$nth errors=$nerr rc=$rc: $(grep ' error: ' "$log" | head -1 | cut -c1-160)"; fi
  # a reading in the host's alphabet is never fixed (law 16-ter): only a compile that ran is a run
  if ! grep -qE "failed to (read file|open file '[^']*': [0-9]+)|Resource temporarily unavailable" "$log"; then
    printf '%s\n%s %s key %s\n' "$line" "$(date '+%Y-%m-%d %H:%M:%S')" "$(basename "$f")" "$key" > "$fix"
  fi
  echo "$line"
}
lean_arm 29 Dobrushin 52 tv_le_of_pointwise cond_sum gibbs_condExp oscBound_sweep gibbs_sweep comparison_level cov_le discrep_tilt
dk_say "arm 29 (STAGE Β3a, DOBRUSHIN'S COMPARISON THEOREM, FINITE): Dobrushin.lean -- the total variation of two conditionals bounded by a pointwise ratio, the one-site conditional expectation and its sweep (gibbs_sweep: the Gibbs mean of a sweep is the mean), the oscillation bound carried through a sweep by the interdependence matrix, the comparison by levels and THE COVARIANCE BOUND cov_le: |cov(f, g)| <= <g> (reading sites)(oscillation mass) alpha^R / (1 - alpha) for an observable at level a and a positive one read at level a + R"
lean_arm 30 Factors 17 weight_pos cond_weight_eq one_le_rho factor_ratio cond_pointwise interdep_factors interdepMat_eq_zero_of_disjoint
dk_say "arm 30 (STAGE Β3b, THE FACTOR SYSTEM): Factors.lean -- a weight that is a product of local factors each within [lo, hi]; the one-site conditional's ratio under a change at another site is at most rho^2, rho the product of hi/lo over the shared factors; so C(s, t) = 1 - rho^-2 is an interdependence matrix (interdep_factors), zero where no factor reads both sites"
lean_arm 31 Decay 4 dot_eq_zero_of_ne_eigen pow_mulVec_eigen eigenvalue_le_of_decay gap_of_decay
dk_say "arm 31 (STAGE Β3c, THE GAP READ OFF THE DECAY): Decay.lean -- for a positive semidefinite entrywise-positive M with unit Perron vector Omega, |<f, M^R f>/lam0^R - <Omega, f>^2| <= K alpha^R for every f forces every other eigenvalue below alpha lam0 (eigenvalue_le_of_decay); the gap is read off the decay"
lean_arm 32 Slab 18 weight_slab slab_rangeOne slab_one_tendsto slab_cov_le slab_decay transfer_gap_uniform transfer_gap_ratio
grep -q 'hCW : Interdep (weight (slabFactors' "$B/code_Slab.txt" || dk_red "arm 32: slab_cov_le no longer takes an arbitrary interdependence matrix"
dk_say "arm 32 (STAGE Β3, THE SLAB AS A FACTOR SYSTEM): Slab.lean -- the X-transfer slab's Gibbs weight IS a factor system (plaquette factors in [wlo, whi], link factors in [klo, khi]), the level map has range one for its interdependence, the finite slab's two-point covariance obeys cov_le with ANY interdependence matrix C (its nonnegativity, Interdep, row sums <= alpha, range one), the infinite slab's two-point function decays as alpha^R, and THE UNIFORM GAP transfer_gap_uniform: every non-Perron eigenvalue of the transfer matrix is at most alpha lam0; transfer_gap_ratio its instance at C = 1 - rho^-2"
lean_arm 33 Rowsum 9 one_sub_prod_le_sum_one_sub interdepMat_le_sum rowsum_interdepMat_le card_levels_le_two slab_rowsum_le transfer_gap_explicit z2_coefficient_lt_one
dk_say "arm 33 (STAGE Β3's GENERIC COEFFICIENT, THE ROW-SUM LAW): Rowsum.lean -- Sigma_t C(s, t) <= Sigma_{i reads s} (|sites i| - 1)(1 - (lo_i/hi_i)^2) for any factor system; on the slab 3m(1 - (wlo/whi)^2) + 2(1 - (klo/khi)^2), m the link degree; transfer_gap_explicit the gap at that alpha; for Z2 (6d - 10)(1 - y^2), below one iff y^2 > (6d - 11)/(6d - 10)"
lean_arm 34 Z2Slab 33 z2_step_univ z2_step_pm z2_steps Z2Sys.par_update Z2Sys.ratio_eq Z2Sys.odds_pow Z2Sys.eps_update Z2Sys.interdep parity_square parity_link weight_slab_eq_W slabZ2_rangeOne slabZ2_rowsum_le transfer_gap_sharp z2_sharp_lt_one
grep -q '(3 \* m + 2) \* ((1 - y) / (1 + y)) < 1' "$B/code_Z2Slab.txt" || dk_red "arm 34: the sharp coefficient (3m + 2)(1 - y)/(1 + y) is not the statement of transfer_gap_sharp"
grep -q '|1 / (1 + v) - 1 / (1 + v \* y ^ 2)| ≤ (1 - y) / (1 + y)' "$B/code_Z2Slab.txt" || dk_red "arm 34: the universal step bound |1/(1+v) - 1/(1+vy^2)| <= (1 - y)/(1 + y) is not stated"
dk_say "arm 34 (STAGE Β3's SHARP COEFFICIENT, THE PER-SITE BOUND WIRED): Z2Slab.lean -- THE UNIVERSAL STEP BOUND |1/(1 + v) - 1/(1 + v y^2)| <= (1 - y)/(1 + y) for EVERY odds v > 0 (the supremum at v = 1/y; cross-multiplied (1 - y)(1 - v y)^2 >= 0), telescoped over the shared factors; the Z2 factor system with parities and multiplicities, the odds y to a signed count, a neighbour's update negating exactly the shared factors' signs; Interdep with C(s, t) = shared(s, t)(1 - y)/(1 + y); the Z2 Wilson slab identified factor by factor; the row sum <= (3m + 2)(1 - y)/(1 + y); and transfer_gap_sharp: THE MASS GAP OF THE Z2 WILSON SLAB with alpha = (3m + 2)(1 - y)/(1 + y), below one iff y > (3m + 1)/(3m + 3): beta < 0.1257 at d = 3, beta < 0.0716 at d = 4 (8.0x and 6.9x the LGT kernel's thresholds)"
lean_arm 35 Z2Interdep 5 z2_step_le sign_cond tv_bool tv_le_c_of_odds rowsum_le_of_eight
dk_say "arm 35 (STAGE Β3b, THE EVEN-SITE STEP LEMMA): Z2Interdep.lean -- the concurrent author's sharper bound (1 - y^2)/(2(1 + y^2)) where the odds and their step lie on one side of 1, the sign condition for even powers, the two-point total variation; stated beside the universal bound and claimed for nothing beyond its hypothesis"
lean_arm 36 Unitary 22 reBlocks_mul reBlocks_orth realMat_injective realify_char realify_injective realify_noInvariant wilson_lattice_potential_gap_unitary
dk_say "arm 36 (STAGE Β2, THE COMPLEX LIFT): Unitary.lean -- a unitary representation realified to an orthogonal one of twice the dimension (the real blocks multiply and are orthogonal), its character the real part, injectivity carried, the invariant-vector condition carried, and the Wilson static potential's gap for a faithful UNITARY representation through Separation.lean"
lean_arm 37 Scaling 4 sum_ite_le twopoint_le_of_gap clustersUniformly_of_gap cluster_of_limit
grep -q '^def ScalingTarget' "$B/code_Scaling.txt" || dk_red "arm 37: ScalingTarget is no longer a def (it is the goal, never a theorem)"
dk_say "arm 37 (STAGE Β4, THE SCALING TARGET): Scaling.lean -- the two-point function of any observable decays as q^R below the Perron term when every other eigenvalue is at most q lam0, uniform clustering follows, clustering passes to a limit of transfer matrices; ScalingTarget a def (the statement of the continuum limit's requirements, never claimed as a theorem)"
lean_arm 38 Duality 20 sum_orth_split chi2_add_of_orth duality macwilliams_signed duality_signed wt_add_eq_int dualVar_involutive dualVar_fixed wegner_dual dualEnum_eval total_cov mixture_cov_le sectorSplit_of_card mem_orth_range_iff
dk_say "arm 38 (STAGE W4, THE DUALITY ON CODES): Duality.lean -- a sector split (a code K's cosets covering the dual D's classes), |K^perp| W_{w+K}(X) = Sigma_h (-1)^{h.w} dualEnum D h (Wegner and 't Hooft in one line), the signed MacWilliams transform of an observable, the dual variable (an involution, fixed point sqrt 2 - 1, tanh beta = dual of e^{-2 beta}), the covariance of a mixture of sectors bounded by the sectors' own plus the between-sector term, a sector split from membership and one cardinality"
lean_arm 39 YM2 12 mult_mul_dim_cast orth_self transfer_char conv_heat handleOp_char handleOp_lin handleOp_iterate Zraw_eq Zraw_sphere Zraw_torus Zraw_sphere_zero Zraw_torus_zero
dk_say "arm 39 (STAGE W7 = Ω2, THE PLANE): YM2.lean -- two-dimensional Yang-Mills on a finite group over any coefficient ring from character data alone: the heat-kernel weight is transfer-diagonal with eigenvalue |G| x_r^t, self-reproducing under convolution (conv_heat: W_t * W_s = |G| W_{t+s}), the handle operator multiplies by m_r^2, and Z(g, t) = Sigma_r d_r^2 m_r^{2g} x_r^t (Migdal) with the sphere and torus at zero area"
lean_arm 40 YM2Q8 8 mult_mul_deg chi_class chi_one conv_char handle sphere_zero torus_zero migdal
dk_say "arm 40 (STAGE W7, THE FIRST NONABELIAN INSTANCE): YM2Q8.lean -- Q8's five integer characters (ΠΙΝΑΞ's table), degrees 1,1,1,1,2 and multiplicities 8,8,8,8,4, every character-data field decided over the group, the sphere at zero area 8 and the torus 320 decided, Migdal's formula at every area and genus"
lean_arm 41 Torus4 9 link_in_six plaq_four cube_six dd_zero sheets_cycle sheets_distinct rank_cobd rank_bd3 rank_bd3_sheets
grep -q 'theorem rank_cobd : rankMasks cobdMasks = 45' "$B/code_Torus4.txt" && grep -q 'theorem rank_bd3 : rankMasks cubeMasks = 45' "$B/code_Torus4.txt" && grep -q 'theorem rank_bd3_sheets : rankMasks (cubeMasks ++ sheetMasks) = 51' "$B/code_Torus4.txt" || dk_red "arm 41: the ranks 45 / 45 / 51 of the four-torus are not the statements"
dk_say "arm 41 (STAGE W4's INSTANCE, THE FOUR-TORUS OF SIDE TWO): Torus4.lean -- the 2^4 torus's cells as masks, each link in six plaquettes, each plaquette on four links, each cube on six plaquettes, d d = 0, the six sheets are cycles and distinct, and THE RANKS 45 / 45 / 51 (the coboundary image, the cube boundaries, the cube boundaries with the sheets) decided in the kernel"
lean_arm 42 Bridge 12 abs_mean_le rest_mass_le dominant_dev_le mixture_between_le sum_testBit_eq_par dot_vecOf mem_orth_span_iff parAnd_comm D_le_orth_K sheet_mem_orth_K
grep -q '8 \* M \^ 2 \* ε' "$B/code_Bridge.txt" || dk_red "arm 42: the epsilon-form's bound 8 M^2 epsilon is not the statement"
dk_say "arm 42 (STAGE W4's BRIDGE, THE ε-FORM): Bridge.lean -- a mixture whose dominant sector carries mass >= 1 - epsilon has between-sector term <= 8 M^2 epsilon (B1: the rest's mass, the dominant deviation), the mask dot product is the parity, the orthogonal of a span is decided on generators, the cube boundaries and the sheets lie in the orthogonal of the coboundary image (B2)"
lean_arm 43 Echelon 16 vecSel_mem_span vecSel_pivot vecSel_injective pow_le_card_span card_span_le_pow card_span_eq_pow finrank_span_eq testBit_foldl_xor vecOfN_xorSel span_le_of_sel span_eq_of_certs finrank_gens_eq card_gens_eq
dk_say "arm 43 (STAGE W4's BRIDGE B3, THE ECHELON CERTIFICATE): Echelon.lean -- a list of masks with pivot bits (hit on its own pivot, miss on every other) is linearly independent over F2 (the selection map is injective by its pivot coordinates), so the span has exactly 2^len elements and finrank len; a two-way selection certificate makes the span of the generators the span of the basis (finrank_gens_eq)"
# ---- ARM 44: the certificates re-emit byte for byte from the emitter and are decided
T4EMIT="$ROOT/STDLIB/scripts/aperanton_emit_torus4.sh"
T4ART="$ROOT/LEAN/aperanton/Aperanton/Torus4Cert.lean"
[ -f "$T4EMIT" ] && [ -f "$T4ART" ] || dk_red "arm 44: missing $T4EMIT or $T4ART"
rm -f "$B/Torus4Cert.reemit.lean" "$B/reemit_t4.log"
bash "$T4EMIT" "$B/Torus4Cert.reemit.lean" > "$B/reemit_t4.log" 2>&1 || dk_red "arm 44: the torus emitter refused ($(tail -1 "$B/reemit_t4.log" | cut -c1-120))"
grep -qF 'ranks Cobd=45 Bd3=45 Bd3S=51' "$B/reemit_t4.log" || dk_red "arm 44: the emitter's ranks are not 45 / 45 / 51"
cmp -s "$B/Torus4Cert.reemit.lean" "$T4ART" || dk_red "arm 44: Torus4Cert.lean does not regenerate byte-identically from the emitter"
cc_t4(){ ( cd "$ROOT" && bash "$1" "$2" ); }   # a mutant EMITTER builds its artifact: bash <mutant> <out>
run_mut_t4cmp(){ if cmp -s "$1" "$ROOT/LEAN/aperanton/Aperanton/Torus4Cert.lean"; then echo "TORUS4-CUSTODY byte-identical"; else echo "TORUS4-CUSTODY MOVED: the re-emission differs from the committed Torus4Cert.lean"; fi; }
RUNT4CMP="$B/run.t4cmp.txt"; rm -f "$RUNT4CMP"
run_mut_t4cmp "$B/Torus4Cert.reemit.lean" > "$RUNT4CMP"
lean_arm 44 Torus4Cert 25 Cobd_cert Cobd_rank Cobd_selG Cobd_selB Bd3_cert Bd3_rank Bd3S_cert Bd3S_rank ranks
dk_say "arm 44 (STAGE W4's BRIDGE B3, THE CERTIFICATES, OD:2 CUSTODY): Torus4Cert.lean re-emitted byte for byte by the gawk emitter (bases 45 / 45 / 51, their pivots, the two-way selection masks), every hit, miss and selection decided in the kernel, the three ranks as theorems"
lean_arm 45 Torus4Bridge 29 K_eq D_eq finrank_K finrank_D finrank_DS orthogonal_top finrank_orth_K finrank_S D_inf_S sheets_linearIndependent sheet_sum_injective card_H torus4Split
dk_say "arm 45 (STAGE W4's BRIDGE B4, THE SECTOR SPLIT OF THE FOUR-TORUS): Torus4Bridge.lean -- K the coboundary image (finrank 45), D the cube boundaries (45), D + sheets (51), K^perp of finrank 51 by the bilinear form's rank-nullity, the sheets' span S of finrank 6 meeting D trivially, the sheet sums injective, |H| = 64 = 2^6, and torus4Split: THE SECTOR SPLIT OF T^4 AS A THEOREM -- the 't Hooft sectors are exactly the 64 cosets of the dual, pairwise disjoint and covering"
dk_say "arms 29-45 (ADDENDUM I, THE ROAD -- Β3 WITH ITS SHARP COEFFICIENT, Β2, Β4, THE DUALITY, THE PLANE, THE FOUR-TORUS): Dobrushin's comparison theorem with levels, the factor system, the decay-to-gap, the slab (an arbitrary interdependence matrix), the row-sum law, THE PER-SITE COEFFICIENT (3m + 2)(1 - y)/(1 + y) wired into the gap of the Z2 Wilson slab (transfer_gap_sharp; below one iff y > (3m + 1)/(3m + 3): beta < 0.1257 at d = 3, 0.0716 at d = 4), the realification, the scaling target as a def, the duality on codes (Wegner and 't Hooft in one line, the observable transform, the mixture lemma and its epsilon-form), two-dimensional Yang-Mills complete on any coefficient ring and decided on Q8, the four-torus's masks and ranks 45 / 45 / 51 decided, its echelon certificates re-emitted byte for byte and decided, and THE SECTOR SPLIT OF THE FOUR-TORUS AS A THEOREM (torus4Split)"
# ---- ARMS 46-48 (ADDENDUM I, THE ROAD, W4): THE SELF-DUALITY OF THE FOUR-TORUS DECIDED, THE VACUUM SECTOR AS A
# DUAL-SECTOR MIXTURE, AND THE FIBRE COUNT -- the counts the stripper's on the built files (law 24-quater)
lean_arm 46 DualTorus 8 dualPlaq_lt dualPlaq_nodup dualLinkOfCube_lt dualLinkOfCube_nodup dualCubeOfLink_lt dualCubeOfLink_nodup cobd_dual cube_dual
dk_say "arm 46 (STAGE W4's GEOMETRY, THE SELF-DUALITY OF THE FOUR-TORUS, DECIDED): DualTorus.lean -- the dual plaquette, link and cube maps are permutations of the 96, 64 and 64 cells; the coboundary of every link transports to the faces of its dual cube and the faces of every cube to the coboundary of its dual link, decided in the kernel: the dual theory's plaquette code is the original's read in the dual coordinates (Wegner's self-duality at the level of the cells)"
lean_arm 47 Weak 14 chi2_zero_right duality_vacuum duality_vacuum_signed dualEnumShift_eval SectorSplit.nonempty enumAt_eq_sum enumAt_pos sectorMass_nonneg sectorMass_sum dualVar_pos vacuum_Z_eq vacuum_N_eq vacExp_eq_mixture vacuum_cov_le
grep -q 'vacExp K y s = ∑ h ∈ H, sectorMass D H (dualVar y) h \* sectorExp D (dualVar y) h s' "$B/code_Weak.txt" || dk_red "arm 47: the mixture identity is not the statement of vacExp_eq_mixture"
dk_say "arm 47 (STAGE W4, THE VACUUM SECTOR AS A DUAL-SECTOR MIXTURE): Weak.lean -- at the trivial twist every character is one, so the vacuum sector's partition function and signed partition function are plain sums over the dual sectors; evaluated at y they are (1 + y)^n times the coset enumerators at y* = (1 - y)/(1 + y), so the vacuum expectation of any observable is the mixture of the dual sectors' shifted-weight expectations with the sector masses (vacExp_eq_mixture), and THE VACUUM COVARIANCE SPLITS into the mass-weighted within-sector covariances plus the between-sector term (vacuum_cov_le) -- the two terms the next stages pay: every twisted sector's gap at the dual coupling, and the sectors' one-point spread"
lean_arm 48 Fibre 3 card_fibre image_univ_eq_range sum_comp_linear
grep -q 'Fintype.card (LinearMap.ker δ) : ℝ' "$B/code_Fibre.txt" || dk_red "arm 48: the fibre count is not the statement of sum_comp_linear"
dk_say "arm 48 (STAGE W4's COUNTING LEMMA, THE FIBRES OF A LINEAR MAP OVER F2): Fibre.lean -- every fibre of a linear map over its range is a translate of the kernel (card_fibre), the image of the whole space is the range (image_univ_eq_range), and a sum over link configurations of a function of the plaquette field is the kernel's size times the sum over the plaquette code (sum_comp_linear): the bridge from a dual sector's enumerator ratio to the Gibbs expectation over links, the constant cancelling in the ratio"
# ---- ARM 49 (ADDENDUM I, THE ROAD -- THE WINDOW'S IR INSTRUMENT): THE BLOCK CRITERION, exact in rationals.  The
# instrument reads Dobrushin's matrix over BLOCKS of links of the Z2 x-transfer slab (d = 4) and the Dobrushin-Shlosman
# influence (the Hamming-Wasserstein distance of the block laws under one outside change, summed over the outside
# variables and divided by the block's size; Dorlas-Savoie Thm 5.1 / Dobrushin-Shlosman 1985 Thm 2.1, W = 0); its
# KNOWN ANSWER is the one-link block, 7(1 - y^2)/(1 + y^2) exactly; the pins are the run's literals (law 24-quater).
BLOCKSRC="$ROOT/STDLIB/scripts/aperanton_block.awk"; MUTBLK="$B/mut_block"; mkdir -p "$MUTBLK"
cc_block(){ cp "$1" "$2"; }
run_mut_block_link(){ gawk -M -v MODE=link -v P=13 -v Q=15 -f "$1" 2>&1 | grep -E '^(BLOCK|ROWSUM|DSW1|KAT)'; gawk -M -v MODE=link -v P=13 -v Q=15 -v BEND=single -f "$1" 2>&1 | grep -E '^(ROWSUM|KAT)'; }
run_mut_block(){ run_mut_block_link "$1"; gawk -M -v MODE=star -v P=13 -v Q=15 -f "$1" 2>&1 | grep -E '^(BLOCK|ROWSUM|DSSUM|W1:|DSW1|DSROW)'; }
RUNBLK="$B/run.blockcrit.txt"; rm -f "$RUNBLK"; run_mut_block "$BLOCKSRC" > "$RUNBLK"   # NOT run.block.txt: on this case-insensitive tree that is arm 50's run.Block.txt, which overwrote it (run x, 00:03, the katbend DEAD PIN -- the case trap of §4)
haveblk(){ grep -qF -- "$1" "$RUNBLK" || dk_red "arm 49: MISSING PIN: $1"; }
haveblk 'KAT link: 7(1 - y^2)/(1 + y^2) = 196 / 197 ; KAT-MET'
haveblk 'ROWSUM link y=13/15 bend=none alpha = 196 / 197 = 0.994923857868 verdict=ALPHA-BELOW-ONE'
haveblk 'ROWSUM link y=13/15 bend=single alpha = 0 / 1 = 0.000000000000 verdict=ALPHA-BELOW-ONE'
haveblk 'KAT-FAILED'
haveblk 'BLOCK star: links=3 plaquettes=9 internal=0 multi=3 single-spatial=6 temporal=6 terms=15 Emax=15 states=1000 configs=8 neighbours=14 y=13/15 bend=none'
haveblk 'ROWSUM star y=13/15 bend=none alpha = 283148039755015914021043771037303577432844328406615641595729838 / 240559991847043037767912080112148606492391762286455425662070859 = 1.177037119020 verdict=ALPHA-NOT-BELOW-ONE'
haveblk 'W1: cube edges=12 spanning trees=384'
haveblk '(1/|B|) sum r = 95126555987571152906932 / 118510201451401127037951 = 0.802686644884 verdict=DS-W1-BELOW-ONE'
haveblk 'DSROW star y=13/15 bend=none max row = 254714933789460644009055398318851242305740389499006636723404571012 / 299861161400401423404254506748894713010169061713253501694936011023 = 0.849442897506 verdict=ROW-BELOW-ONE'
haveblk ''
dk_say "arm 49 (THE BLOCK CRITERION, THE WINDOW'S IR INSTRUMENT ON THE Z2 CONTROL): aperanton_block.awk -- the one-link block reads Dobrushin's exact one-site coefficient 7(1 - y^2)/(1 + y^2) = 196/197 at y = 13/15 (the known answer, met; the single-term bend reads the lawful zero and fails the known answer); the star block (the three spatial links at a site) reads Dobrushin's matrix over blocks at 1.177 -- the plain block criterion LOSES to the one-link criterion, the kill-switch reading of the stake -- and the Dobrushin-Shlosman Hamming-Wasserstein influence, exact over the 384 spanning trees of the 3-cube, at (1/3) sum r = 0.8027 against the one-link 0.9949: the first block criterion that beats the one-site one on this theory, every number a rational from the run"
# ---- ARM 50 (ADDENDUM I, THE ROAD, W8): THE BLOCK COMPARISON THEOREM -- Dobrushin's sweep machinery over blocks,
# the row form of the Dobrushin-Shlosman / Weitz condition; the count the stripper's on the built file (law 24-quater)
lean_arm 50 Block 38 patch_of_mem patch_of_not_mem patch_patch patch_restr restr_patch patch_update_of_mem patch_update_of_not_mem zblk_pos zblk_patch condB_nonneg condB_sum condB_update_mem condExpB_update_mem gibbs_condExpB abs_sub_le_sum_osc_on abs_sub_le_of_agree oscBound_condExpB mem_blkList blkList_nodup blkList_toFinset mem_sitesOf sitesOf_append sitesOf_nodup applyB_sub_blk applyB_blkList removed_sub_blk removed_blkList removed_append oscBound_sweepB gibbs_sweepB abs_gibbs_condExpB_sub_le sitesOf_univ_toFinset applyB_iterB_le comparison_level_blk g_patch_eq discrep_tilt_blk cov_le_blk
grep -qF -- "|gibbs W' f - gibbs W f| ≤ (∑ t, bB (blk t)) * (∑ t, d t) * α ^ R / (1 - α)" "$B/code_Block.txt" || dk_red "arm 50: the block comparison bound is not the statement of comparison_level_blk"
dk_say "arm 50 (STAGE W8, THE BLOCK COMPARISON THEOREM): Block.lean -- the block conditional expectation with its stationarity (one involution of configuration and block state), the block coupling hypothesis (a coupling of the two block laws under one outside change with the disagreement at block site x at most C x t), LEMMA A-prime (the block step's bound), THE IDENTITY that with C zero inside every block the block step is the site sweep of the block's sites (so Dobrushin.lean's removed-mass invariant, Neumann bound, level bound and contraction apply unchanged), the block comparison theorem comparison_level_blk with the row sums at every site below alpha < 1, and the block covariance bound cov_le_blk by the tilt -- the theorem the block criterion's row reading (arm 49: 0.9257 at y = 13/15) consumes; the one-site theorem is the case of singleton blocks"
# ---- ARM 51 (ADDENDUM I, THE ROAD -- THE CONSTRAINED CRITERION'S FIRST PROBE): the plaquette block's Dobrushin-Shlosman
# influence by an exact min-cost flow (successive shortest paths), UNCONSTRAINED at y = 13/15; the constrained reading
# (the plaquette's product frozen) read 1.357 against this 0.824 and FIRED the stake's falsifier -- the record on the page
PROBESRC="$ROOT/STDLIB/scripts/aperanton_probe.awk"; MUTPRB="$B/mut_probe"; mkdir -p "$MUTPRB"
cc_probe(){ cp "$1" "$2"; }
run_mut_probe(){ gawk -M -v P=13 -v Q=15 -v CONSTR=0 -f "$1" 2>&1 | grep -E '^(PROBE|PROBE-DSW1)'; }
RUNPRB="$B/run.probe.txt"; rm -f "$RUNPRB"; run_mut_probe "$PROBESRC" > "$RUNPRB"
grep -qF -- 'PROBE square CONSTR=0 y=13/15 states=1296 admitted=16 variables=2' "$RUNPRB" || dk_red "arm 51: the probe's header is not the run's"
grep -qF -- 'PROBE-DSW1 square CONSTR=0 FIBMETRIC=0 y=13/15 flows=5760 sum r = 285798543159808172441416 / 86729621146901839568715 = 3.295281812378 ; (1/|B|) sum r = 71449635789952043110354 / 86729621146901839568715 = 0.823820453094 verdict=BELOW-ONE' "$RUNPRB" || dk_red "arm 51: MISSING PIN: the probe's unconstrained reading"
dk_say "arm 51 (THE CONSTRAINED CRITERION'S FIRST PROBE, THE UNCONSTRAINED PLAQUETTE BLOCK): aperanton_probe.awk -- the four links of one spatial plaquette, sixteen states, the Dobrushin-Shlosman influence by an exact min-cost flow on the 4-cube (successive shortest paths in integers; 28 single-term and 8 shared outside variables under the square's symmetry), (1/4) sum r = 0.823820453094 at y = 13/15 (below one, between the one-link 0.9949 and the star 0.8027); the constrained reading of the same block at the same y (1.357405235856, the fiber's Hamming cost doubling every move) fired the falsifier staked at 22:0x and is recorded on the road page, the product-constrained form withdrawn there and the decimation form staked in its place"
# ---- ARM 52 (THE TREK, T5): THE EXACT ONE-SITE COEFFICIENT ON EVEN FIELDS -- ZedEven.lean, the instrument's known answer as a theorem
lean_arm 52 ZedEven 5 z2_step_even_of even_odds_parity z2_step_even even_le_univ z2_even_lt_one
grep -qF -- '|1 / (1 + v) - 1 / (1 + v * y ^ 2)| ≤ (1 - y ^ 2) / (2 * (1 + y ^ 2))' "$B/code_ZedEven.txt" || dk_red "arm 52: the exact step bound is not the statement of z2_step_even_of"
grep -qF -- '(3 * m : ℝ) / (3 * m + 4) < y ^ 2' "$B/code_ZedEven.txt" || dk_red "arm 52: the regime 3m/(3m + 4) < y^2 is not the statement of z2_even_lt_one"
dk_say "arm 52 (THE TREK, T5 -- THE EXACT ONE-SITE COEFFICIENT ON EVEN FIELDS): ZedEven.lean -- for odds v with (1 - v)(1 - v y^2) >= 0 the one-site move |1/(1 + v) - 1/(1 + v y^2)| is at most (1 - y^2)/(2(1 + y^2)), the cross-multiplied difference being (1 - y^2)(1 - v)(1 - v y^2) exactly; every even power y^(2k) of y in (0, 1] meets the condition (both factors nonnegative at k >= 0, both nonpositive at k < 0); the exact coefficient never exceeds the universal (1 - y)/(1 + y) (their cross-multiplied difference (1 - y)^3); and (3m + 2)(1 - y^2)/(2(1 + y^2)) < 1 iff 3m/(3m + 4) < y^2 -- at m = 4, the link degree of the d = 4 slab, this is arm 49's known answer 7(1 - y^2)/(1 + y^2) = 196/197 at y = 13/15 and the threshold y^2 > 3/4, beta < 0.0719; 5 theorems, no sorry, no axiom, no native_decide"
# ---- ARM 53 (ADDENDUM I, THE ROAD, W5): THE DUAL SECTOR AS A FACTOR SYSTEM ON THE FOUR-TORUS -- TorusSys.lean
lean_arm 53 TorusSys 12 cobdDual_apply par_eq prod_ite_eq_pow W_eq_pow confEquiv_apply sum_W_eq sectorExp_eq_gibbs shared_row rowsum_le cubeMult_eq_vecOf cobdDual_single range_cobdDual_eq_D
grep -qF -- 'theorem range_cobdDual_eq_D : LinearMap.range cobdDual = D := by' "$B/code_TorusSys.txt" || dk_red "arm 53: the range of the dual coboundary is not identified with Torus4's D"
grep -qF -- '∑ t, (torusSys h y hy0 hy1).C s t ≤ 18 * ((1 - y) / (1 + y))' "$B/code_TorusSys.txt" || dk_red "arm 53: the row sum 18 c1(y) is not the statement of rowsum_le"
grep -qF -- 'sectorExp (LinearMap.range cobdDual) y h s =' "$B/code_TorusSys.txt" || dk_red "arm 53: the sector expectation is not identified with a Gibbs expectation"
dk_say "arm 53 (STAGE W5, THE DUAL SECTOR AS A FACTOR SYSTEM ON THE FOUR-TORUS): TorusSys.lean -- the dual lattice's 64 cubes as sites and 96 plaquettes as factors with the twist h as the shift (torusSys, a Z2Sys); the parity IS the dual coboundary plus the twist (par_eq), the weight is y to the weight of the twisted plaquette field (W_eq_pow), and THE FIBRE BRIDGE: the sector's partition function over cube configurations is |ker delta*| times Weak.lean's coset enumerator (sum_W_eq, through Fibre.lean's count), so the sector's expectation E_(h+s)/E_h IS a Gibbs expectation over the cube configurations (sectorExp_eq_gibbs, the constant cancelling); the row sum of the interdependence matrix is at most 18 c1(y) (shared_row decided in the kernel on the 64 x 63 x 96 incidences: six faces, three other cubes at each); the range of delta* is Torus4's boundary code D (each cube's column its face mask, cubeMult_eq_vecOf decided on 64 x 96), so Weak.lean's dual sectors and these Gibbs measures are one object; 12 theorems, no sorry, no axiom, no native_decide"
# ---- ARM 54 (THE TREK, T2's FIRST INSTRUMENT): THE DECIMATED CRITERION -- aperanton_block.awk with DECIM=1 (the coarse links frozen as data)
run_mut_decim(){ local f="$1" yy; for yy in "13 15" "5 6" "4 5"; do set -- $yy; gawk -M -v MODE=link -v P=$1 -v Q=$2 -v DECIM=1 -f "$f" 2>&1 | grep -E '^(BLOCK|ROWSUM|DSW1)'; done; }
RUNDCM="$B/run.decim.txt"; rm -f "$RUNDCM"; { run_mut_decim "$BLOCKSRC"; gawk -M -v MODE=star -v P=13 -v Q=15 -v DECIM=1 -f "$BLOCKSRC" 2>&1 | grep -E '^(BLOCK|ROWSUM|DSW1|DSROW)'; } > "$RUNDCM"
grep -qF -- 'ROWSUM link y=13/15 bend=none decim=1 alpha = 140 / 197 = 0.710659898477 verdict=ALPHA-BELOW-ONE' "$RUNDCM" || dk_red "arm 54: MISSING PIN: the decimated one-link reading at 13/15"
grep -qF -- 'ROWSUM link y=5/6 bend=none decim=1 alpha = 55 / 61 = 0.901639344262 verdict=ALPHA-BELOW-ONE' "$RUNDCM" || dk_red "arm 54: MISSING PIN: the decimated one-link reading at 5/6"
grep -qF -- 'ROWSUM link y=4/5 bend=none decim=1 alpha = 45 / 41 = 1.097560975610 verdict=ALPHA-NOT-BELOW-ONE' "$RUNDCM" || dk_red "arm 54: MISSING PIN: the decimated one-link reading at 4/5 (above one: the threshold y^2 > 2/3 is two-sided)"
grep -qF -- 'DSW1 star y=13/15 bend=none decim=1 variables=18 W1-evaluations=25200 sum r = 56283901405180769364716 / 39503400483800375679317 = 1.424786239055 ; (1/|B|) sum r = 56283901405180769364716 / 118510201451401127037951 = 0.474928746352 verdict=DS-W1-BELOW-ONE' "$RUNDCM" || dk_red "arm 54: MISSING PIN: the decimated star's Dobrushin-Shlosman influence at 13/15"
grep -qF -- 'DSROW star y=13/15 bend=none decim=1 max row = 502749560098806701179291096573292752417453703802626588 / 965321347815332232847571477880851099509565999049829191 = 0.520810568664 verdict=ROW-BELOW-ONE' "$RUNDCM" || dk_red "arm 54: MISSING PIN: the decimated star's row form at 13/15"
dk_say "arm 54 (THE TREK, T2's FIRST INSTRUMENT -- THE DECIMATED CRITERION): aperanton_block.awk with DECIM=1 freezes every link whose position along its own direction is even as DATA (the coarse sublattice; the block at odd positions): the one-link row sum 140/197 = 0.7107 at y = 13/15 (against 196/197 undecimated; 10 free neighbours of 14), 55/61 at 5/6, 45/41 at 4/5 -- the decimated one-link threshold y^2 > 2/3, beta < 0.1014; the decimated STAR's Dobrushin-Shlosman influence 0.474928746352 at 13/15 (against 0.802686644884) and its row form 0.520810568664 (against 0.849442897506); on the scratch copy of the same instrument the star read 0.6213/0.6906 at 5/6, 0.7816/0.8769 at 4/5, 1.0494/1.1869 at 3/4, so the decimated star's threshold lies in (3/4, 4/5), beta in (0.1116, 0.1438), against the undecimated star's (0.0771, 0.0912): THE CONSTRAINED CRITERION'S REGION DOUBLED: what the decimated readings certify is Dobrushin uniqueness of the FINE system given the frozen coarse links, i.e. the decimation map well defined (Gibbsian) to beta in (0.1116, 0.1438) -- Haller-Kennedy's statement in this coin, NOT the gap's region; step one of the criterion-controlled renormalization staked on the road page at 22:29, the undecimated readings byte-identical (a print-only tag)"
# ---- ARM 55 (STAGE W6, THE FOUR-TORUS OF ANY SIDE): TorusL.lean -- the geometry with the side a parameter, B1 and B2 at every side
lean_arm 55 TorusL 6 dot_vecOf parAnd_comm parAnd_cube_cobd parAnd_sheet_cobd D_le_orth_K sheet_mem_orth_K
grep -qF -- 'def stepP (L s mu : ℕ) : ℕ := s - coord L s mu * L ^ mu + ((coord L s mu + 1) % L) * L ^ mu' "$B/code_TorusL.txt" || dk_red "arm 55: the step is not the digit advanced modulo L"
dk_say "arm 55 (STAGE W6, THE FOUR-TORUS OF ANY SIDE): TorusL.lean -- a site of (Z/L)^4 read in base L (coord its mu-th digit, stepP that digit advanced modulo L), links/plaquettes/cubes indexed mu*V+s, q*V+s, c*V+s as the side-2 file indexes them, the six sheets of L^2 plaquettes, masks, the codes K, D, S, the 64 twists H and the split TorusLSplit L; B1 (the dot product of mask vectors is the parity of the and) at every side, B2 (the boundary code and the sheets in the plaquette code's dual) at every side from the two decided incidence facts as hypotheses; 6 theorems, no sorry, no axiom, no native_decide"
# ---- ARM 56 (STAGE W6): TorusLBridge.lean -- the sector split at any side from a certificate's numbers
lean_arm 56 TorusLBridge 22 K_eq D_eq S_eq basisSet_append orthogonal_top finrank_orth_K card_filter_eq finrank_S D_inf_S sheets_linearIndependent sheet_sum_injective card_H torusLSplit
grep -qF -- '(hDS : Module.finrank (ZMod 2) ↥(D L ⊔ S L) = rD + 6) (hsum : rK + rD + 6 = nPlaq L) :' "$B/code_TorusLBridge.txt" || dk_red "arm 56: the split's hypotheses are not the three finranks with rK + rD + 6 = 6V"
dk_say "arm 56 (STAGE W6, THE SECTOR SPLIT AT ANY SIDE): TorusLBridge.lean -- the side-2 bridge stated once for every side: from the two decided incidence facts and three finranks (rK of K, rD of D, rD + 6 of D with the sheets) with rK + rD + 6 = 6V, the dual dimension finrank K^perp = 6V - rK (the dot product nondegenerate), the sheets independent of the boundaries (the rank jump rD -> rD + 6 against finrank S <= 6), the 64 twists distinct, and one cardinality identity 2^(6V - rK) = 64 * 2^rD land torusLSplit; 22 theorems, no sorry, no axiom, no native_decide"
# ---- ARM 57 (STAGE W6): TorusSysL.lean -- the dual sector as a factor system at any side, the row sum by a double count
lean_arm 57 TorusSysL 11 torusSys_y cobdDual_apply par_eq W_eq_pow confEquiv_apply sum_W_eq sectorExp_eq_gibbs shared_row_of rowsum_le_of cobdDual_single range_cobdDual_eq_D
grep -qF -- '∑ t, (torusSys L h y hy0 hy1).C s t ≤ 18 * ((1 - y) / (1 + y))' "$B/code_TorusSysL.txt" || dk_red "arm 57: the row sum 18 c1(y) at any side is not the statement of rowsum_le_of"
dk_say "arm 57 (STAGE W6, THE DUAL SECTOR AS A FACTOR SYSTEM AT ANY SIDE): TorusSysL.lean -- torusSys L (sites the 4V cubes, factors the 6V plaquettes, the twist the shift), the parity the dual coboundary plus the twist, the weight y to the twisted field's weight, THE FIBRE BRIDGE and the sector expectation as a Gibbs expectation at every side; THE ROW SUM BY A DOUBLE COUNT: with every plaquette on four cubes and the cube with six faces (two facts a side's instance decides), sum_(t != s) shared(s, t) = 6 * (4 - 1) = 18, so Dobrushin's row is at most 18 c1(y) at every side; the range of delta* is D L from the decided column fact; 11 theorems, no sorry, no axiom, no native_decide"
# ---- ARM 58 (STAGE W6): TorusLevels.lean -- the wall level on the circle and the range one along it
lean_arm 58 TorusLevels 4 cubeMult_ne_zero_iff level_le_of_shared cubeMult_ne_zero_of_one rangeOne_of
grep -qF -- 'def levelN (L mu k : ℕ) : ℕ := min (coord L (k % V L) mu) (L - coord L (k % V L) mu)' "$B/code_TorusLevels.txt" || dk_red "arm 58: the level is not the distance from the wall on the circle"
dk_say "arm 58 (STAGE W6, THE LEVELS OF THE FOUR-TORUS): TorusLevels.lean -- the level of a cube is its site's distance from the wall x_mu = 0 on the circle of length L, min(x, L - x), which a step moves by at most one, the wrap included; THE ADJACENCY FACT in list form (every face of every cube against every cube, a side's instance decides it) read as 'two cubes sharing a face sit at levels at most one apart', so the dual factor system has RANGE ONE along the wall level at every side; 4 theorems, no sorry, no axiom, no native_decide"
# ---- ARM 59 (STAGE W6): TorusDecay.lean -- THE WEAK-COUPLING CLAUSE'S ENGINE: every dual sector's correlations decay as (18 c1(y))^R at any side
lean_arm 59 TorusDecay 3 alpha_nonneg alpha_lt_one_iff sector_cov_le
grep -qF -- 'theorem alpha_lt_one_iff (y : ℝ) (hy0 : 0 < y) : alpha y < 1 ↔ (17 : ℝ) / 19 < y := by' "$B/code_TorusDecay.txt" || dk_red "arm 59: the threshold 17/19 is not the statement of alpha_lt_one_iff"
dk_say "arm 59 (STAGE W6, THE WEAK-COUPLING CLAUSE'S ENGINE AT ANY SIDE): TorusDecay.lean -- in every dual sector h at every side, an observable with oscillation mass at levels <= a and a positive observable read at levels >= a + R have |<fg> - <f><g>| <= <g> (#reads)(sum d) alpha^R/(1 - alpha), alpha = 18 c1(y), below one iff y > 17/19 (cov_le of Dobrushin.lean on torusSys L with the double-count row sum and the wall level's range one); in the original coupling y < 1/18, beta > 1.445 at every side against the self-dual 0.4407 -- the clause's engine, uniform in L; 3 theorems, no sorry, no axiom, no native_decide"
# ---- ARM 60 (STAGE W6): TorusTwoPoint.lean -- THE SECTOR TWO-POINT FACTORIZATION at any side, the weak-coupling clause's observable
lean_arm 60 TorusTwoPoint 15 par_shift par_update_far ratioAt_eq ratioAt_pos shiftObs_eq_prod shiftObs_pos ratioAt_of_zero ratioAt_update_far shiftObs_update_of_far ratioAt_le shiftObs_le shiftObs_oscBound shiftObs_add sector_two_point sector_two_point_enum
grep -qF -- '    shiftObs L h (s₁ + s₂) y hy0 hy1 ω = shiftObs L h s₁ y hy0 hy1 ω * shiftObs L h s₂ y hy0 hy1 ω := by' "$B/code_TorusTwoPoint.txt" || dk_red "arm 60: the shift observable's multiplicativity over disjoint supports is not stated"
dk_say "arm 60 (STAGE W6, THE SECTOR TWO-POINT FACTORIZATION AT ANY SIDE): TorusTwoPoint.lean -- the shift observable E_(h+s)/E_h read as a product of one ratio per plaquette (one outside supp s, at most 1/y on it, unchanged by a far cube's update -- Dobrushin's hfree -- and multiplicative over disjoint supports), its oscillation mass 2 (1/y)^|supp s| on the adjacent cubes; sector_cov_le with the two shift observables gives, for s2 near the wall and s1 at levels >= a + R, |<shift(s1 + s2)> - <shift s1><shift s2>| <= <shift s1> (#cubes of s1)(sum dOf s2) alpha^R/(1 - alpha), and through the fibre bridge the same for the enumerators: E_(h+s1+s2)/E_h factorizes as (E_(h+s1)/E_h)(E_(h+s2)/E_h) up to alpha^R at every side -- the weak-coupling clause's observable; 15 theorems, no sorry, no axiom, no native_decide"
# ---- ARM 61 (STAGE W7', THE ASSEMBLY'S GENERIC LAYER): TorusT3.lean -- the enumerator's invariance under a code shift, the mixture deviation, THE BETWEEN-SECTOR DEVIATION as a corollary of the two-point theorem
lean_arm 61 TorusT3 5 "add_self_vec'" enumAt_add_mem sectorExp_add_mem dev_le_mixture sector_dev_le
grep -qF -- 'enumAt D (h + d) y = enumAt D h y := by' "$B/code_TorusT3.txt" || dk_red "arm 61: the coset enumerator's invariance under a code shift is not stated"
dk_say "arm 61 (STAGE W7', THE ASSEMBLY'S GENERIC LAYER): TorusT3.lean -- a coset enumerator is invariant under a shift by a code element (the sum over D reindexed by c -> c + d), so a twist may be read at any representative; a member's distance from a mixture is at most the mass-weighted sum of its distances from the members; and THE BETWEEN-SECTOR DEVIATION |<shift s>_(h+t) - <shift s>_h| for a twist's representative t placed R levels past the wall is the two-point bound divided by <shift t>_h -- the same theorem read with the twist as the far observable, uniform in the side; what remains per side is geometry (a far representative of every twist: the sheets translated, their slabs' boundaries in D), the per-L facts an instance file decides; 5 theorems, no sorry, no axiom, no native_decide"
# ---- ARM 62 (STAGE W7', THE TWIST TRANSLATIONS, THE GENERIC LAYER): TorusLTrans.lean
lean_arm 62 TorusLTrans 2 vecOfN_xor mem_D_of_sel
dk_say "arm 62 (STAGE W7', THE TWIST TRANSLATIONS, THE GENERIC LAYER): TorusLTrans.lean -- the (mu nu)-sheet at the complementary coordinates (c1, c2) as a mask, the xor of two masks the sum of their vectors over F2, and a mask that is a selection of a side's echelon basis of the cube faces lies in D (through Echelon.lean's two-way selections); 2 theorems, no sorry, no axiom, no native_decide"
# ---- ARM 63 (STAGE W7', THE WEAK-COUPLING CLAUSE ASSEMBLED AT ANY SIDE): TorusT3Assembly.lean
lean_arm 63 TorusT3Assembly 6 "dev_le_mixture'" sectorExp_twist_sub_le dualVar_le_one sectorExp_le step_bound vacuum_two_point_le
grep -qF -- '    |vacExp (K L) y₀ (s₁ + s₂) - vacExp (K L) y₀ s₁ * vacExp (K L) y₀ s₂| ≤' "$B/code_TorusT3Assembly.txt" || dk_red "arm 63: the vacuum two-point bound is not the statement of vacuum_two_point_le"
dk_say "arm 63 (STAGE W7', THE WEAK-COUPLING CLAUSE ASSEMBLED AT ANY SIDE): TorusT3Assembly.lean -- THE VACUUM TWO-POINT FUNCTION of the Z2 theory on T^4_L at the original coupling y0 with dual coupling above 17/19 (y0 < 1/18, beta > 1.445), for disjoint plaquette sets s2 near a wall and s1 R levels past it, every sheet given a far translate R' levels past its own wall: |<(-1)^(s1+s2)> - <(-1)^s1><(-1)^s2>| <= (1/y*)^|s1| (#cubes s1)(sum dOf s2) alpha^R/(1 - alpha) + (2 sum_q B_q(s1))(2 sum_q B_q(s2)) -- Weak.lean's split of the vacuum covariance into the sectors' terms and the between-sector term, each sector's term by THE TWO-POINT FACTORIZATION with the sector expectation's sup, the between-sector term by the mixture deviation, THE TELESCOPING OF A TWIST OVER ITS SHEETS and the per-sheet deviation at the far translate; the per-side facts as hypotheses; the clause as one theorem uniform in the side; 6 theorems, no sorry, no axiom, no native_decide"
# ---- ARM 64 (STAGE W6', THE EVERY-L STEP'S FIRST LEMMAS): TorusLocal.lean -- a mask's bit is membership in its list, a mask parity is an intersection count, the local forms give the mask forms, the incident forms give the local forms
lean_arm 64 TorusLocal 9 testBit_bitOf testBit_maskOf parAnd_maskOf card_filter_fin_eq_length dd_of_local sheetMask_eq_maskOf sheets_of_local localDD_of_inc localSheets_of_inc
dk_say "arm 64 (STAGE W6', THE EVERY-L STEP'S FIRST LEMMAS): TorusLocal.lean -- a bit of a mask built from a list is set iff the index is in the list, the parity of the and of two list masks is the parity of their intersection count (Bridge.lean's bit-sum lemma), a nodup list's filtered members below the width counted as a Fin-filter card, THE LOCAL FORMS of the boundary-of-a-boundary and of the sheets' cyclicity (list counts) carried to the mask forms the split consumes, and THE INCIDENT FORMS: the counts read only over a cube's (a sheet's) own incident links, the all-links form following by a case split (a link on no face has the empty count), so the decide is LINEAR in the volume; 9 theorems, no sorry, no axiom, no native_decide"
# ---- ARM 65 (THE EVERY-L STEP, THE LIST-FORM ECHELON CERTIFICATE): EchelonList.lean -- every check a fold over the lists, the bridges to Echelon.lean's Fin forms
lean_arm 65 EchelonList 5 xorSelAux_eq xorSelL_eq zip_getElem_mem echelonCert_of_lists sel_of_list
grep -qF -- 'theorem xorSelL_eq (m : ℕ) (basis : List ℕ) : xorSelL m basis = xorSel m basis := by' "$B/code_EchelonList.txt" || dk_red "arm 65: the linear selection is not bridged to Echelon.lean's xorSel"
dk_say "arm 65 (THE EVERY-L STEP, THE LIST-FORM ECHELON CERTIFICATE): EchelonList.lean -- Echelon.lean's certificate indexes the basis by List.get over every pair (the miss check r^3 list steps) and its selections by getD inside a fold over range r (G r^2): at side 3 (r = 240) the kernel ran past 18 GB and was killed (01:09), measured decide by decide (the Fin-form hit and miss alone +3.6 GB over the 8.1 GB import, the selections and the all-plaquette filter past the 12 GB cap); here the same facts are folds -- the hit check over basis.zip piv, the miss check as a double all with the element compared by value (the basis nodup), the selection xorSelL ONE fold over the basis carrying the index, the selection checks over gens.zip sel -- and THE BRIDGES carry them to EchelonCert and to the selection hypotheses finrank_gens_eq takes, unchanged; the certificate files decide the list forms and apply the bridges; 5 theorems, no sorry, no axiom, no native_decide"
# ---- ARM 66 (THE TREK, T3 -- THE DESIGN THEOREM'S CORE): DesignCore.lean -- carried-integer quaternions, the product's identities, THE CLOSURE THEOREM FROM GENERATORS
lean_arm 66 DesignCore 9 "Zd.ext_iff'" "Quat.ext_iff'" hmul_assoc hmul_times4_left hmul_times4_right hmul_one quarter_times4 times4_injective closed_of_gens
grep -qF -- '    ∀ x ∈ G, ∀ y ∈ G, inG G (hmul d x y) = true := by' "$B/code_DesignCore.txt" || dk_red "arm 66: the closure theorem is not stated"
dk_say "arm 66 (THE TREK, T3 -- THE DESIGN THEOREM'S CORE): DesignCore.lean -- quaternions over Z[sqrt d] with every coordinate carried four times its value (the kernel divides nowhere but by an exact four), the Hamilton product's associativity and bilinearity and the identity's action as polynomial identities (ring on eight components), and THE CLOSURE THEOREM FROM GENERATORS: a list headed by the identity is closed under the product once every member times every generator is four times a member and every later member is a generator times an earlier member, exactly -- x(s y') = (x s) y' by associativity, x s a member, y' earlier, the induction on the index -- two LINEAR certificates in place of the |G|^2 Cayley table the kernel cannot afford (the 120 x 120 closure of the binary icosahedral group by enumeration measured past the 12 GB cap at 01:1x); 9 theorems, no sorry, no axiom, no native_decide"
# ---- ARM 67 (THE TREK, T3 -- THE DESIGN THEOREM): the design emitter re-emits Design.lean byte for byte, and the three finite subgroups of SU(2) are decided as groups (by the two linear certificates) and as spherical designs of exact strength
DSEMIT="$ROOT/STDLIB/scripts/aperanton_emit_design.sh"; DSART="$ROOT/LEAN/aperanton/Aperanton/Design.lean"
[ -f "$DSEMIT" ] && [ -f "$DSART" ] || dk_red "arm 67: missing $DSEMIT or $DSART"
rm -f "$B/Design.reemit.lean" "$B/reemit_ds.log"
bash "$DSEMIT" "$B/Design.reemit.lean" > "$B/reemit_ds.log" 2>&1 || dk_red "arm 67: the design emitter refused ($(tail -1 "$B/reemit_ds.log" | cut -c1-120))"
grep -qF 'BT=24 gens=2,8 t=5 BO=48 gens=8,24 t=7 BI=120 gens=2,24 t=11 permutations=12' "$B/reemit_ds.log" || dk_red "arm 67: the design emitter's line is not 24 / 48 / 120 at strengths 5 / 7 / 11 with the first generating pairs 2,8 / 8,24 / 2,24"
cmp -s "$B/Design.reemit.lean" "$DSART" || dk_red "arm 67: Design.lean does not regenerate byte-identically from the design emitter"
run_mut_emitDS(){ bash "$1" "$B/Design.mut.lean" 2>&1 | grep -E '^BT=|EMIT-REFUSED'; if cmp -s "$B/Design.mut.lean" "$DSART"; then echo "design-emit IDENTICAL"; else echo "design-emit DIFFERS"; fi; }
RUNEMDS="$B/run.emitDS.txt"; run_mut_emitDS "$DSEMIT" > "$RUNEMDS"
grep -qF -- 'design-emit IDENTICAL' "$RUNEMDS" || dk_red "arm 67: MISSING PIN: the design emitter's identity line"
lean_arm 67 Design 30 BT_card BT_nodup BT_unit BT_conj BT_gen BT_reach BT_closed BT_design BT_strength BT_molien BO_card BO_nodup BO_unit BO_conj BO_gen BO_reach BO_closed BO_design BO_strength BO_molien BI_card BI_nodup BI_unit BI_conj BI_gen BI_reach BI_closed BI_design BI_strength BI_molien
dk_say "arm 67 (THE TREK, T3 -- THE DESIGN THEOREM, OD:2 CUSTODY): Design.lean re-emitted byte for byte by aperanton_emit_design.sh -- the binary tetrahedral, octahedral and icosahedral groups as explicit unit quaternions over Z[sqrt 2] and Z[sqrt 5] carried four times their value (the Hurwitz units; the 24 (e_mu +- e_nu)/sqrt 2; the 96 even permutations of (+-phi, +-1, +-1/phi, 0)/2), each listed in the breadth-first order of its reach from the identity by the first generating pair in list order (the emitter refusing if no pair reaches the whole set), DECIDED a group through DesignCore's closure theorem from the two linear certificates (|G| |S| and |G| products), every element of norm one with its conjugate in the list, no repeats, 24 / 48 / 120, and DECIDED a spherical design of EXACT strength by the Delsarte-Goethals-Seidel criterion: the sum over the group of the SU(2) character of spin n/2 (the Chebyshev U_n at the real part, carried as the integer recurrence 4^n U_n) vanishes for 1 <= n <= t with t = 5, 7, 11, does not vanish at n = t + 1, and there equals |G| 4^(t+1) (Molien: the trivial representation entering spin (t+1)/2 exactly once) -- the known answer computed first by an awk sharing no line; so a finite subgroup is a completion of SU(2) whose residue is the spin tail beyond its strength, the bridge of the finite ladder; classical (Sloane, W = 0), the earning the exact two-sided instance; 30 theorems, no sorry, no axiom, no native_decide"
# ---- ARM 68 (THE EVERY-L STEP, THE LINEAR GEOMETRY): TorusLinear.lean -- the link's plaquettes listed, the consistency decides, the coboundary mask without the filter, the boundary of a boundary and the sheets as xor identities
lean_arm 68 TorusLinear 10 testBit_xorFold bodd_eq_decide foldl_xor_eq_parity mem_linkCobd_iff mem_linkPlaqs_iff cobdMask_eq cobdMasks_eq parity_eq_bit dd_of_xor sheets_of_xor
grep -qF -- 'theorem cobdMasks_eq (L : ℕ) (c1 : C1 L) (c2 : C2 L) : cobdMasks L = cobdMasksD L := by' "$B/code_TorusLinear.txt" || dk_red "arm 68: the coboundary masks are not bridged to their direct form"
dk_say "arm 68 (THE EVERY-L STEP, THE LINEAR GEOMETRY): TorusLinear.lean -- the all-plaquette filter behind linkCobd (4V * 6V contains) alone took the kernel 7.7 GB past the import at side 3, measured; so the link's six plaquettes are LISTED DIRECTLY (linkPlaqs: for each pair containing the link's direction, the plaquette at the site and the one a step back in the other direction) and TWO CONSISTENCY DECIDES, each linear (every link of every plaquette lists the plaquette; every plaquette of every link lists the link, both in range), give cobdMask = maskOf (linkPlaqs) for every link without the filter ever running in the kernel (cobdMask_eq, cobdMasks_eq); THE BOUNDARY OF A BOUNDARY and THE SHEETS' CYCLICITY are xor identities (the xor over a cube's six faces, a sheet's L^2 plaquettes, of each face's link mask is zero: one GMP xor per face) bridged to the mask parities by the bit of a xor-fold being the parity of the count (testBit_xorFold, foldl_xor_eq_parity, parity_eq_bit, dd_of_xor, sheets_of_xor); 10 theorems, no sorry, no axiom, no native_decide"
# ---- ARM 69 (THE EVERY-L STEP, THE LINEAR GEOMETRY'S DUAL FACTS): TorusLinearDual.lean -- the four cubes of a plaquette listed, completed by the double count; the multiplicity as membership; the six faces, the column, the adjacency from the lists
lean_arm 69 TorusLinearDual 10 facesOK_at cubeSix_at cubeMult_mod_two card_filter_mem hsix_of hcol_of card_cubes_eq_four hdeg_of plaqCubes_complete adjList_of
grep -qF -- '  exact ((Finset.sum_eq_sum_iff_of_le (fun i _ => hlow i)).mp htot i (Finset.mem_univ i)).symm' "$B/code_TorusLinearDual.txt" || dk_red "arm 69: the four cubes are not closed by the double count"
dk_say "arm 69 (THE EVERY-L STEP, THE LINEAR GEOMETRY'S DUAL FACTS): TorusLinearDual.lean -- the dual factor system's four facts at a side (every plaquette on four cubes, every cube with six faces, every cube's column its face mask, the adjacency along a wall) from decides LINEAR in the volume: the four cubes of a plaquette LISTED DIRECTLY (plaqCubes: for each triple containing the pair, the cube at the site and the cube a step back in the third direction) and checked distinct members having the plaquette as a face (PC), their COMPLETENESS by THE DOUBLE COUNT (the incidences counted by plaquette and by cube, sum_p #cubes(p) = sum_k #faces(k) = 6 * 4V = 4 * 6V, so four listed each is four each: card_cubes_eq_four, plaqCubes_complete), the multiplicity modulo two as membership (the faces distinct: cubeMult_mod_two), the six faces and the column (hsix_of, hcol_of) and the adjacency over the listed cubes only (AdjInc, adjList_of) -- against the 4 * 4V * 6 * 4V membership tests of the Fin form that no kernel reaches; 10 theorems, no sorry, no axiom, no native_decide"
# ---- ARM 70 (THE EVERY-L STEP, THE SIDE-3 CERTIFICATE, LINEAR): the side-L emitter re-emits the side-3 certificate byte for byte, reproduces the side-2 certificate's lists at L = 2 (the sighted control), and the certificate is decided -- every decide linear in the volume
TLEMIT="$ROOT/STDLIB/scripts/aperanton_emit_torusL.sh"; TLART="$ROOT/LEAN/aperanton/Aperanton/TorusLCert3.lean"
[ -f "$TLEMIT" ] && [ -f "$TLART" ] || dk_red "arm 70: missing $TLEMIT or $TLART"
rm -f "$B/TorusLCert3.reemit.lean" "$B/TorusLCert2.reemit.lean" "$B/reemit_tl.log"
bash "$TLEMIT" 3 "$B/TorusLCert3.reemit.lean" > "$B/reemit_tl.log" 2>&1 || dk_red "arm 70: the side-L emitter refused at L = 3 ($(tail -1 "$B/reemit_tl.log" | cut -c1-120))"
grep -qF 'ranks Cobd=240 Bd3=240 Bd3S=246 side=3 V=81' "$B/reemit_tl.log" || dk_red "arm 70: the emitter's ranks at L = 3 are not 240 / 240 / 246"
cmp -s "$B/TorusLCert3.reemit.lean" "$TLART" || dk_red "arm 70: TorusLCert3.lean does not regenerate byte-identically from the side-L emitter"
bash "$TLEMIT" 2 "$B/TorusLCert2.reemit.lean" >> "$B/reemit_tl.log" 2>&1 || dk_red "arm 70: the side-L emitter refused at L = 2"
diff <(grep -E '^def ' "$B/TorusLCert2.reemit.lean") <(grep -E '^def ' "$ROOT/LEAN/aperanton/Aperanton/Torus4Cert.lean") > /dev/null || dk_red "arm 70: at L = 2 the side-L emitter's lists are not the side-2 certificate's (the sighted control of the generalization)"
run_mut_emitL(){ bash "$1" 3 "$B/TorusLCert3.mut.lean" 2>&1 | grep -E '^ranks|EMIT-REFUSED'; }
RUNEML="$B/run.emitL.txt"; run_mut_emitL "$TLEMIT" > "$RUNEML"
grep -qF -- 'ranks Cobd=240 Bd3=240 Bd3S=246 side=3 V=81' "$RUNEML" || dk_red "arm 70: MISSING PIN: the emitter's ranks line"
lean_arm 70 TorusLCert3 57 c1 c2 faces_ok sheets_ok cube_six plaq_four pc adj_inc cobdMasks_eq3 Cobd_cert Cobd_selG Cobd_selB Cobd_rank Bd3_cert Bd3_selG Bd3_selB Bd3_rank Bd3S_cert Bd3S_selG Bd3S_selB Bd3S_rank ranks ddx shx dd_zero sheets_cycle deg_four faces_six col adj
grep -qF -- 'theorem Cobd_missL : missL basisCobd pivCobd = true := by decide +kernel' "$B/code_TorusLCert3.txt" || dk_red "arm 70: the miss check is not decided in list form"
dk_say "arm 70 (THE EVERY-L STEP, THE SIDE-3 CERTIFICATE, LINEAR, OD:2 CUSTODY): TorusLCert3.lean re-emitted byte for byte by aperanton_emit_torusL.sh at L = 3 (echelon bases of 240, 240 and 246 486-bit masks for the 324 link coboundaries, the 324 cube faces and the faces with the six sheets; pivots; two-way selections), and at L = 2 the same emitter's lists are the side-2 certificate's byte for byte (the sighted control: one geometry, two sides); EVERY DECIDE LINEAR IN THE VOLUME -- the echelon checks in list form (the hit check over basis.zip piv, the miss check as a double all, the selections as one fold each) bridged to Echelon.lean's by EchelonList.lean; the two consistency decides of the link lists, the faces, the sheets, the cube count, the listed cubes of every plaquette, the adjacency over them; the boundary of a boundary and the sheets' cyclicity as xor identities; the coboundary masks in their direct form -- and derived from them the Fin-form certificates, the mask forms and the four dual facts the instance consumes; against the Fin-form certificate that ran the kernel past 18 GB (01:09, measured decide by decide), this one runs flat at the import's footprint; 57 theorems, no sorry, no axiom, no native_decide"
# ---- ARM 71 (STAGE W6, THE SIDE-3 INSTANCE): TorusL3.lean -- the split, the dual facts, the adjacency and the decay at side three, every fact from the linear certificate
lean_arm 71 TorusL3 15 finrank_K3 finrank_D3 finrank_DS3 torusL3Split deg_four3 faces_six3 col3 rowsum_le3 range_cobdDual_eq_D3 adj3 rangeOne3 sector_cov_le3
grep -qF -- 'theorem torusL3Split : TorusLSplit 3 :=' "$B/code_TorusL3.txt" || dk_red "arm 71: the side-3 split is not stated"
dk_say "arm 71 (STAGE W6, THE FOUR-TORUS OF SIDE THREE, THE INSTANCE): TorusL3.lean -- finrank K = D = 240, D with the sheets 246 from the certificate through Echelon.lean, so torusL3Split (Wegner's self-duality read on T^4_3 by duality) with 240 + 240 + 6 = 486 decided; the dual factor system's facts at side 3 (every plaquette on four cubes, every cube with six faces, every cube's column its face mask) and the adjacency along each of the four walls, every one derived from the certificate's linear decides through TorusLinearDual.lean (no decide of its own), so the row sum 18 c1(y), the range of delta* = D, the range one along every wall level and THE SECTOR DECAY hold at side three (a wall level there is at most one: the instance carries the structure, not a number); 15 theorems, no sorry, no axiom, no native_decide"
# ---- ARM 72 (STAGE W7'): the translation emitter re-emits the side-3 translation certificate byte for byte, every sum in the boundary code, and the certificate is decided
TLTEMIT="$ROOT/STDLIB/scripts/aperanton_emit_torusL_trans.sh"; TLTART="$ROOT/LEAN/aperanton/Aperanton/TorusLTrans3.lean"
[ -f "$TLTEMIT" ] && [ -f "$TLTART" ] || dk_red "arm 72: missing $TLTEMIT or $TLTART"
rm -f "$B/TorusLTrans3.reemit.lean" "$B/reemit_tlt.log"
bash "$TLTEMIT" 3 "$B/TorusLTrans3.reemit.lean" > "$B/reemit_tlt.log" 2>&1 || dk_red "arm 72: the translation emitter refused at L = 3 ($(tail -1 "$B/reemit_tlt.log" | cut -c1-120))"
grep -qF 'translations=54 rankD=240 side=3 V=81 verdict=ALL-IN-D' "$B/reemit_tlt.log" || dk_red "arm 72: the translation emitter's line is not 54 sums, rank 240, all in D"
cmp -s "$B/TorusLTrans3.reemit.lean" "$TLTART" || dk_red "arm 72: TorusLTrans3.lean does not regenerate byte-identically from the translation emitter"
run_mut_emitLT(){ bash "$1" 3 "$B/TorusLTrans3.mut.lean" 2>/dev/null | grep -E '^translations'; }
RUNEMLT="$B/run.emitLT.txt"; run_mut_emitLT "$TLTEMIT" > "$RUNEMLT"
grep -qF -- 'translations=54 rankD=240 side=3 V=81 verdict=ALL-IN-D' "$RUNEMLT" || dk_red "arm 72: MISSING PIN: the translation emitter's verdict line"
lean_arm 72 TorusLTrans3 3 trans_len trans_sel trans_eq
dk_say "arm 72 (STAGE W7', THE SIDE-3 TRANSLATION CERTIFICATE, OD:2 CUSTODY): TorusLTrans3.lean re-emitted byte for byte by aperanton_emit_torusL_trans.sh at L = 3 -- the 54 sums of a sheet at the complementary coordinates (c1, c2) with the sheet at (0, 0), each reduced to zero against the side-3 echelon basis of the cube faces (ALL-IN-D: every translate is a representative of its twist) with its selection mask, the kernel deciding each selection against TorusLCert3's basisBd3 and each sum as the xor of the two sheets as TorusLTrans.lean defines them (the emitter's geometry against Lean's, a sighted control); 3 theorems, no sorry, no axiom, no native_decide"
# ---- ARM 73 (STAGE W7'): TorusT3L3.lean -- every sheet's translate is another representative of its twist, at side three
lean_arm 73 TorusT3L3 2 trans_mem_D3 sheet_translate_mem_D3
dk_say "arm 73 (STAGE W7', THE TWIST TRANSLATIONS AT SIDE THREE): TorusT3L3.lean -- each translation sum's selection read as membership in D 3 through the certificate's two-way selections, and the sum as the sum of the two sheets' vectors: the (mu nu)-sheet at any complementary coordinates (c1, c2) plus the sheet at (0, 0) is a boundary at side three, so a twist's sector may be read at any translate of its sheet (sectorExp_add_mem) -- the geometric fact the between-sector deviation needs; 2 theorems, no sorry, no axiom, no native_decide"

# ---- ARM 74 (THE TREK, STAGE IV'S FIRST NUMBER -- THE SU(2) ONE-LINK COEFFICIENT'S KNOWN ANSWER): aperanton_su2_kat.awk
# -- the flip's closed form L_1(beta)/I_1(beta) by the series (the road sharing no line with arm 75's quadrature), the
# crossing 18 L_1/I_1 = 1 at beta* (the ceiling of the one-link method, a theorem), Lemma M read on the grid against
# the rule's own dead-world error, the variance theorem's Neumann coefficients by two roads (the unconditional floor 1/9).
SU2KAT="$ROOT/STDLIB/scripts/aperanton_su2_kat.awk"; SU2LINK="$ROOT/STDLIB/scripts/aperanton_su2_link.awk"; BIFLIP="$ROOT/STDLIB/scripts/aperanton_bi_flip.awk"; MUTSU2="$B/mut_su2"; mkdir -p "$MUTSU2"
cc_su2(){ cp "$1" "$2"; }
run_mut_su2kat(){ gawk -M -v PREC=160 -f "$1" 2>&1 | grep -E '^(aperanton_su2_kat|flip beta=0\.125 |flip beta=0\.15 |crossing|decimated|lemmaM dead|lemmaM grid|hessian|variance)'; }
RUNSU2K="$B/run.su2kat.txt"; rm -f "$RUNSU2K"; run_mut_su2kat "$SU2KAT" > "$RUNSU2K"
havesu2k(){ grep -qF -- "$1" "$RUNSU2K" || dk_red "arm 74: MISSING PIN: $1"; }
havesu2k 'crossing beta*=0.1310307711153333870294052317252045565108 (18 L1/I1 = 1) pi/24=0.1308996938995747182692768076366459535082 window=1.311e-04'
havesu2k 'flip beta=0.125 L1/I1=0.053003344929783428580840051774 18C=0.954060208736101714455120931938 ONE-LINK-HOLDS-AT-FLIP'
havesu2k 'flip beta=0.15 L1/I1=0.063578549225824609531549412688 18C=1.144413886064842971567889428379 ONE-LINK-FAILS'
havesu2k 'lemmaM dead-world K=0: |h - 4/(3pi)| max=2.907e-07'
havesu2k 'least margin=1.061107e-06 at K=0.0100 alpha=1.5708'
havesu2k 'decimated crossing beta*=0.1967929421824351417723940596124545545193 (12 L1/I1 = 1; 12 free of 18 neighbours under the even-position rule)'
havesu2k 'LEMMA-M-READS'
havesu2k 'vs 1/4 VAR-READS'
havesu2k 'max |diff|=2.737e-48 negatives=0 NEUMANN-MET'
dk_say "arm 74 (THE TREK, STAGE IV'S FIRST NUMBER -- THE SU(2) ONE-LINK COEFFICIENT'S KNOWN ANSWER): aperanton_su2_kat.awk -- the one-link conditional of the SU(2) Wilson action is the von Mises-Fisher law on S^3, and at the lone staple's antipodal flip its total variation is EXACTLY L_1(beta)/I_1(beta), the modified Struve function over the modified Bessel function (DLMF 11.5.4; series 4 beta/(3 pi) - 7 beta^3/(90 pi)): the series road meets arm 75's quadrature at every coupling to the quadrature's own error; the flip is one admissible pair, so the one-link Dobrushin criterion FAILS above beta* = 0.13103077111533338702940523172520455651 (the crossing 18 L_1/I_1 = 1 by bisection on positive series, the ceiling of the one-link method on SU(2), a theorem; the decimated crossing 12 L_1/I_1 = 1 at 0.19679294218243514177, 12 free of 18 neighbours under the even-position rule, the twin of arm 54); THE VARIANCE THEOREM (the projection's variance under any vMF law on S^3 at most 1/4 -- across the axis a ratio of positive series with falling coefficient ratios, along the axis 4 I_0^2 - 3 I_1^2 - 4 I_0 I_1/K - 8 I_1^2/K^2 >= 0 whose (K/2)^(2n) coefficient (2n)!/(n!)^4 n(n-1)(n+4)/((n+1)^2(n+2)) is read by Cauchy products against its closed form to 2.7e-48, Neumann's product formula) gives C <= beta/2 and the criterion HOLDS below 1/9 unconditionally -- the window [1/9, beta*] a theorem both ways; LEMMA M (the projection's mean absolute deviation at most its uniform value 4/(3 pi)) would sharpen the floor to pi/24, a window of 1.3e-4: proved across the axis, its Hessian at zero derived by hand and read to five digits on both axes, READ on the grid K <= 0.8, alpha <= pi/2 with least margin 1.06e-6 against the rule's dead-world error 2.9e-7 -- a reading, not a proof, said so; the rule split at the kink acos m_K after a dead world that put the kink on a node read a false refutation of 9e-7"
# ---- ARM 75 (THE TREK, STAGE IV'S FIRST NUMBER -- THE SU(2) ONE-LINK COEFFICIENT READ): aperanton_su2_link.awk at N = 96
# on beta = 0.125, below the crossing: the grid's supremum over the staple geometry (r = 0..5, a, a' = k pi/6, sign +-,
# the plane exact by the cap-intersection lemma) is the flip, the signed one-dimensional road reads the flip and its
# nearest competitor (vMF(2 beta) against the uniform law) with the rule split at the kink, the quadrature's mass
# read as 1, the diagonal as 0.
run_mut_su2link(){ gawk -M -v PREC=160 -v N=96 -v BETAS="0.125" -f "$1" 2>&1 | grep -E '^(aperanton_su2_link|beta=)'; }
RUNSU2L="$B/run.su2link.txt"; rm -f "$RUNSU2L"; run_mut_su2link "$SU2LINK" > "$RUNSU2L"
havesu2l(){ grep -qF -- "$1" "$RUNSU2L" || dk_red "arm 75: MISSING PIN: $1"; }
havesu2l 'aperanton_su2_link PREC=160 N=96 betas=0.125 grid r=6 a=7'
havesu2l 'beta=0.125 C=0.053003352344 row=18C=0.954060342194 DOBRUSHIN-HOLDS argmax[r=0 a=0pi/6'
havesu2l 'flip-1d=0.053003352006 competitor-1d=0.052936363462 flip-lead=6.699e-05 FLIP-LEADS'
havesu2l 'mass-err=6.622e-09 road-err=2.333e-05 diag=0.000e+00'
dk_say "arm 75 (THE TREK, STAGE IV'S FIRST NUMBER -- THE SU(2) ONE-LINK COEFFICIENT READ): aperanton_su2_link.awk -- the two-dimensional Simpson quadrature (N = 96, 160 bits) of the total variation between the one-link conditionals p(.|R + s) and p(.|R + s') over the staple grid (the other five staples' sum r e_0, r = 0..5; s, s' at angles k pi/6 with the sign of s', the plane exact: at fixed concentrations the variation rises with the angle between the axes, the cap-intersection lemma) at beta = 0.125 reads the supremum at the flip (r = 0, |S| = |S'| = 1, S' = -S), C = 0.053003352344 against the series' 0.053003344930 (arm 74), the row 18 C = 0.954 below one, DOBRUSHIN-HOLDS; the signed one-dimensional road with the rule split at the kink reads the flip and its nearest competitor, vMF(2 beta) against the uniform law, the flip leading by 6.7e-5 (the lead growing as beta^3: 4.3e-6 at 0.05, 0.12 at 2.3 on the twelve-coupling record c), where the unsplit rule at N = 24 had read the competitor 7e-5 AHEAD (its kink between nodes; the flip's on the node pi/2) -- law 2 at the quadrature; the aligned road's first draft had compared the diagonal with itself (law 48) and reads every pair with sin a = sin a' = 0 since record b; the mass of p read as 1 to 7e-9, the diagonal as 0 exactly, the dead world beta = 0 all zeros"
# ---- ARM 76 (THE TREK, STAGE III'S FIRST NUMBER -- THE BI ONE-LINK COEFFICIENT AT THE FLIP, AND THE DESIGN RESIDUE ON THE
# OBSERVABLE THAT MATTERS): aperanton_bi_flip.awk -- the 120 elements built, the Haar moments met through degree 10 and
# refused at 12 (the 11-design two-sided), E_BI|<d,U>| by direction against 4/(3 pi), the 119 admissible pairs from s = 1
# at first order, the flip's class form by two roads, the crossing.
run_mut_biflip(){ gawk -M -v PREC=160 -v ND=24 -f "$1" 2>&1 | grep -E '^(aperanton_bi_flip|design|residue|first-order|flip beta=0\.125 |crossing)'; }
RUNBI="$B/run.biflip.txt"; rm -f "$RUNBI"; run_mut_biflip "$BIFLIP" > "$RUNBI"
havebi(){ grep -qF -- "$1" "$RUNBI" || dk_red "arm 76: MISSING PIN: $1"; }
havebi 'aperanton_bi_flip PREC=160 elements=120 unit-err=0.000e+00'
havebi 'design degree=10 E_BI u0^10=0.041015625000000000 haar=0.041015625000000000'
havebi 'design degree=12 E_BI u0^12=0.032470703125000000 haar=0.032226562500000000 |diff|=2.441e-04 DESIGN-REFUSED'
havebi 'residue E_BI|<d,U>|: at e0=0.406940131083312 (the class form (11+6 sqrt5)/60=0.406940131083312) haar 4/(3pi)=0.424413181578388; over 30000 directions min=0.406940131083312'
havebi 'max=0.426207100021057'
havebi 'first-order pairs from s=1: 119 pairs; the flip 0.406940131083312; the best other pair 0.401789847843730'
havebi 'FLIP-LEADS-AT-FIRST-ORDER'
havebi 'flip beta=0.125 C_BI=0.050823594620876575 class-form=0.050823594620876575'
havebi 'crossing BI beta*=0.1366612338750300471511982936244529459611 (18 C_BI = 1)'
dk_say "arm 76 (THE TREK, STAGE III'S FIRST NUMBER -- THE BI ONE-LINK COEFFICIENT AT THE FLIP, AND THE DESIGN RESIDUE ON THE OBSERVABLE THAT MATTERS): aperanton_bi_flip.awk -- the 120 unit quaternions of the binary icosahedral group built (the 24 Hurwitz units, the 96 even permutations of (+-phi, +-1, +-1/phi, 0)/2; every element a unit to 160 bits); THE DESIGN CONTROL TWO-SIDED: the Haar moments E u0^(2k) = Catalan(k)/4^k met on the 120 elements to 1e-48 through degree 10 and REFUSED at degree 12 by 2.4e-4 (an 11-design is not a 12-design); the flip's coefficient by the element sum and by the class form [2 sinh b + 40 sinh(b/2) + 24 sinh(phi b/2) + 24 sinh(b/(2 phi))]/[2 cosh b + 40 cosh(b/2) + 30 + 24 cosh(phi b/2) + 24 cosh(b/(2 phi))] to 1e-48 at ten couplings, slope (11 + 6 sqrt5)/60 = 0.40694 against SU(2)'s 4/(3 pi) = 0.42441, the crossing beta*_BI = 0.13666123387503004715 against SU(2)'s 0.13103077 (the finite observer's one-link region 4.3 percent wider); THE RESIDUE IS A PROPERTY OF THE OBSERVABLE: E_BI|<d,U>| runs over 30,000 directions from 0.40694 at the group's own directions to 0.42621 above the Haar value (mean 0.42269) -- 4.1 percent on the total-variation observable, of either sign by direction -- so T3's transfer clause carries the residue of the functional the theorem reads, exactly computable, not of a polynomial; over the 119 admissible pairs from s = 1 the flip leads at first order by 1.27 percent (the best other pair the 144-degree class, 0.951 x 0.42247 = 0.40179 against 0.40694), where on SU(2) every pair with |Delta| = 2 beta ties"
# ---- ARM 77 (THE TREK, STAGE IV -- THE VARIANCE THEOREM'S COMBINATORIAL CORE IN THE KERNEL): NeumannCoeff.lean -- the
# coefficient of (K/2)^(2n) in 4 I_0^2 - 3 I_1^2 - 4 I_0 I_1/K - 8 I_1^2/K^2 by Neumann's product formula, the four
# binomial terms equal to (2n)!/(n!)^4 n(n-1)(n+4)/((n+1)^2(n+2)) for every n >= 1 (coeff_closed, a rational identity
# decided by field_simp and ring), zero at n = 0 and 1, positive from n = 2 (closed_nonneg, coeff_nonneg): the sign that
# makes the projection's variance under every von Mises-Fisher law on S^3 at most 1/4 and the one-link coefficient at
# most beta/2 -- THEOREM S4's floor 1/9, its combinatorial half now a theorem of the kernel.
lean_arm 77 NeumannCoeff 13 choose_2n_n choose_2n_pred choose_2n1_n choose_2n2_n fact_succ_q fact_pred_q coeff_closed coeff_zero_terms closed_nonneg closed_one closed_two_pos coeff_nonneg
# ---- ARM 78 (W10 -- THE TWO ONE-SIDED BOUNDS A DECIMATION FLOW RESTS ON, IN THE KERNEL): BondMoving.lean -- for any
# nonnegative base weight on a finite configuration set and any two actions A, B: Z(A + B)^2 <= Z(2A) Z(2B)
# (Cauchy-Schwarz: the moved weight bounds the true one from above), Z(A + B) >= Z(2A) exp(E_{2A}[B - A]) (Jensen under
# the moved measure), the symmetric form and the free-energy form -- Kadanoff's bond-moving inequality, the rigorous
# content of every Migdal-Kadanoff flow (and of nothing beyond the free energy: the gap and the vortex free energy are
# ratios these do not sandwich).
lean_arm 78 BondMoving 6 Z_nonneg exp_two_mul_eq_sq Z_add_sq_le Z_add_le_of_eq Z_add_ge_jensen log_Z_add_le
# ---- ARM 79 (THE TREK, W10(a) -- THE EXACT DECIMATION FLOWS IN THE CHARACTER BASIS): aperanton_mkflow.awk -- the
# Migdal-Kadanoff step as two exact maps on the character coefficients (the convolution a monomial map, the bond-moving
# read through the group on an exact midpoint grid), three flows (Tomboulis' upper-bound decimation A, his lower-bound
# decimation L, Migdal's order B), whose rigorous content is two one-sided bounds on the free energy (BondMoving.lean)
# and whose one verdict is whether the flows' twisted ratios part.  Read here: the two-dimensional known answer (the
# heat-kernel area law exactly, kat2d = 0 at every step), the identity controls (beta_eff(0) = beta, osc(0) = 2 beta),
# the Z2 control in four dimensions (CLOSES below its first fixed point, PARTS between the two, OPEN above; the dead
# world), the SU(2) flow at beta = 2.3 (both ends STRONG; the upper-bound flow needs 8 steps to the one-link floor),
# and the exact rational road at y = 1/3 meeting the float road.
MKFLOW="$ROOT/STDLIB/scripts/aperanton_mkflow.awk"; MUTFLOW="$B/mut_flow"; mkdir -p "$MUTFLOW"
cc_flow(){ cp "$1" "$2"; }
run_mut_flow(){ { gawk -M -v PREC=160 -v GROUP=su2 -v D=2 -v JMAX=40 -v BETAS="1 3" -v STEPS=3 -f "$1"; gawk -M -v PREC=160 -v GROUP=z2 -v D=4 -v BETAS="0.2 0.25 0.8 0.85 1 0" -v STEPS=200 -f "$1"; gawk -M -v PREC=160 -v GROUP=su2 -v D=4 -v JMAX=80 -v BETAS="2.3" -v STEPS=60 -f "$1"; gawk -M -v PREC=160 -v GROUP=z2 -v EXACT=1 -v YNUM=1 -v YDEN=3 -v EXSTEPS=3 -f "$1"; } 2>&1 | grep -E '^(flow=A beta=1 n=0 |flow=A beta=3 n=3 |FLOW |SANDWICH |flow=A beta=2\.3 n=0 |flow=A beta=2\.3 n=8 |exact=)'; }
RUNFLOW="$B/run.flow.txt"; rm -f "$RUNFLOW"; run_mut_flow "$MKFLOW" > "$RUNFLOW"
haveflow(){ grep -qF -- "$1" "$RUNFLOW" || dk_red "arm 79: MISSING PIN: $1"; }
haveflow 'flow=A beta=1 n=0 beta_eff=1 osc=2 nine_osc=18 r_twist=0.618493713792 u1=0.48038744774 u2=0.117675313559 u3=0.019372387009 u4=0.00240165250846 tail=0 kat2d=0'
haveflow 'flow=A beta=3 n=3 beta_eff=7.52691542003e-16 osc=1.50538308401e-15 nine_osc=1.3548447756e-14 r_twist=1 u1=3.76345771001e-16 u2=1.34718419893e-39'
haveflow 'SANDWICH pair=AL beta=3 ends=STRONG/STRONG common_steps=3 width_max=1.36845553157e-48 width_end=0 verdict=CLOSES'
haveflow 'FLOW A beta=0.2 end=STRONG steps=7 nstar_floor=5 nstar_ceil=4'
haveflow 'SANDWICH pair=AL beta=0.2 ends=STRONG/STRONG common_steps=2 width_max=0.322533735036 width_end=7.46543302237e-12 verdict=CLOSES'
haveflow 'SANDWICH pair=AL beta=0.25 ends=WEAK/STRONG common_steps=2 width_max=0.761275250026 width_end=0.999999999665 verdict=PARTS'
haveflow 'SANDWICH pair=AB beta=0.8 ends=WEAK/STRONG common_steps=4 width_max=0.392250394821 width_end=0.999999999928 verdict=PARTS'
haveflow 'SANDWICH pair=AB beta=0.85 ends=WEAK/WEAK common_steps=4 width_max=0.151637867763 width_end=0 verdict=OPEN'
haveflow 'SANDWICH pair=AL beta=1 ends=WEAK/STRONG common_steps=4 width_max=1 width_end=1 verdict=PARTS'
haveflow 'FLOW A beta=0 end=STRONG steps=0 nstar_floor=0 nstar_ceil=0'
haveflow 'flow=A beta=2.3 n=0 beta_eff=2.3 osc=4.6 nine_osc=41.4 r_twist=0.382016571815 u1=0.958558156609 u2=0.499413504498 u3=0.180025862791 u4=0.0496346982579 tail=0'
haveflow 'flow=A beta=2.3 n=8 beta_eff=0.0344010256882 osc=0.0688205209975 nine_osc=0.619384688978 r_twist=0.982947131282 u1=0.0171996647563 u2=2.58213109008e-05'
haveflow 'FLOW A beta=2.3 end=STRONG steps=10 nstar_floor=8 nstar_ceil=8'
haveflow 'FLOW B beta=2.3 end=STRONG steps=4 nstar_floor=2 nstar_ceil=2'
haveflow 'FLOW L beta=2.3 end=STRONG steps=3 nstar_floor=2 nstar_ceil=2'
haveflow 'SANDWICH pair=AL beta=2.3 ends=STRONG/STRONG common_steps=3 width_max=0.600202500947 width_end=5.28885909316e-21 verdict=CLOSES'
haveflow 'SANDWICH pair=AB beta=2.3 ends=STRONG/STRONG common_steps=4 width_max=0.586584994081 width_end=1.93371764921e-21 verdict=CLOSES'
haveflow 'exact=A y=1/3 beta=0.549306144334 n=1 u=0.9059506448 float_u=0.9059506448 diff=0 v2=32/20 v3=0/0 v5=4/0 log10h=12.4717353402'
haveflow 'exact=B y=1/3 beta=0.549306144334 n=3 u=1.75078260586e-07 float_u=1.75078260586e-07'
dk_say "arm 79 (THE TREK, W10(a) -- THE EXACT DECIMATION FLOWS IN THE CHARACTER BASIS): aperanton_mkflow.awk -- the Migdal-Kadanoff step read exactly in the character basis (the convolution a monomial map, the bond-moving through the group on an exact midpoint grid), three flows (Tomboulis upper, Tomboulis lower, Migdal), their rigorous content two one-sided free-energy bounds and their one verdict whether the twisted ratios part: the two-dimensional known answer exact (kat2d = 0), the identity controls, the Z2 control across its two fixed points (CLOSES / PARTS / OPEN) with its dead world, the SU(2) flow at beta = 2.3 ending STRONG in 10 steps (the one-link floor at step 8), and the exact rational road meeting the float road at y = 1/3"
# ---- ARM 80 (THE TREK, STAGE IV'S SECOND NUMBER -- THE ONE-PLAQUETTE BLOCK OF SU(2)): aperanton_su2_plaq.awk at N = 8,
# JMAX = 1, beta = 0.125 -- the block of one plaquette in the character basis (the exact collapse to one spin sum), its
# JMAX = 0 control reproducing the one-link flip against the series L_1/I_1 up to the rule's error at this N, the
# block's own influence TV_own and the other links' TV_other under one outside change, the necessary condition
# 15 TV_own < 1 and the marginal proxy 15 TV_own + 45 TV_other against the one-link row 18C.  The run of record is at
# N = 16, JMAX = 3 (su2_plaq.2026-10-28a.txt: the proxy crossing read at 0.147, below the decimated one-link 0.197);
# this arm pins the cheap configuration as a regression guard, never as the number.
PLAQ="$ROOT/STDLIB/scripts/aperanton_su2_plaq.awk"; MUTPLAQ="$B/mut_plaq"; mkdir -p "$MUTPLAQ"
cc_plaq(){ cp "$1" "$2"; }
run_mut_plaq(){ gawk -M -v PREC=160 -v N=8 -v JMAX=1 -v BETAS="0.125" -f "$1" 2>&1 | grep -E '^(aperanton_su2_plaq|control|beta=)'; }
RUNPLAQ="$B/run.plaq.txt"; rm -f "$RUNPLAQ"; run_mut_plaq "$PLAQ" > "$RUNPLAQ"
haveplaq(){ grep -qF -- "$1" "$RUNPLAQ" || dk_red "arm 80: MISSING PIN: $1"; }
haveplaq 'aperanton_su2_plaq PREC=160 N=8 JMAX=1 betas=0.125'
haveplaq 'control beta=0.125 one-link flip by the block instrument at JMAX=0: 0.053184249172 series L1/I1=0.053003344930 |diff|=1.809e-04'
haveplaq 'beta=0.125 TV_own=0.053989315478 at [r=2 a=0pi/2 pl=1'
haveplaq 'TV_other=0.000976780218 at [r=4 a=0pi/2 pl=1 rho=1 Q34=1 |S2|=1.414'
haveplaq 'row>=15TV_own=0.809839732 BLOCK-NOT-REFUTED-BY-THE-NECESSARY-CONDITION marginal-proxy=15TV_own+45TV_other=0.853794842 one-link-row=18C=0.954060209 pairs=2520 mass-err=2.094e-03 diag=0.000e+00 tail=2.264e-02'
dk_say "arm 80 (THE TREK, STAGE IV'S SECOND NUMBER -- THE ONE-PLAQUETTE BLOCK OF SU(2)): aperanton_su2_plaq.awk -- the block of one plaquette in the character basis, its JMAX = 0 control hitting the one-link flip against the series to the rule's error (1.8e-4 at N = 8; 1e-5 at the N = 16 run of record), TV_own = 0.05399 and TV_other = 0.00098 at beta = 0.125 under one outside change, the necessary row 15 TV_own = 0.81 below one, the marginal proxy 0.854 against the one-link row 0.954; the run of record reads the proxy crossing at 0.147, below the decimated one-link crossing 0.197 -- the product block of one plaquette buys less than decimation, as T2 anticipated"
# ---- ARM 81 (W10(b) ON THE ABELIAN CONTROL -- THE TWISTED RATIO OF THE Z2 HINGE AGAINST THE COUPLING): aperanton_z2_hinge.awk
# -- the 3D Z2 gauge theory on ΤΟΜΕΥΣ' 2x2xL hinge in the temporal gauge with the Gauss projection (32 orbits, the
# transfer matrix on the invariant subspace exact), the twist the 't Hooft loop along y (the seam links' temporal
# plaquettes flipped in one step), r = Z^-/Z monotone down in beta at every L (Tomboulis' (5.15) on a cell IS this
# monotonicity, by the reduction of the master plan's section 24; abelian: Griffiths), the dead twist r = 1 and the
# sheet (r_sheet = 1 at even L, = r at odd L) as the law-2 controls.  The run of record is z2_hinge.2026-10-28a.txt
# (L up to 8, beta to 3); this arm pins the cheap grid as a regression guard.
HINGE="$ROOT/STDLIB/scripts/aperanton_z2_hinge.awk"; MUTHINGE="$B/mut_hinge"; mkdir -p "$MUTHINGE"
cc_hinge(){ cp "$1" "$2"; }
run_mut_hinge(){ gawk -M -v PREC=160 -v LS="2 3" -v BMIN=0.2 -v BMAX=1 -v BSTEP=0.2 -f "$1" 2>&1 | grep -E '^(L=|HINGE)'; }
RUNHINGE="$B/run.hinge.txt"; rm -f "$RUNHINGE"; run_mut_hinge "$HINGE" > "$RUNHINGE"
havehinge(){ grep -qF -- "$1" "$RUNHINGE" || dk_red "arm 81: MISSING PIN: $1"; }
havehinge 'L=2 beta=0.2 r=0.993792666958 vortexF=0.00622667863204 F/(4beta)=0.00778334829006 r_sheet=1 r_dead=1'
havehinge 'HINGE L=2 MONOTONE-DOWN first_bad=- r_at_top=0.0792521863512 F/(4beta)_top=0.633780069645 pass_0.9_at=0.4'
havehinge 'L=3 beta=0.2 r=0.999754117753 vortexF=0.000245912481225 F/(4beta)=0.000307390601532 r_sheet=0.999754117753 r_dead=1'
havehinge 'HINGE L=3 MONOTONE-DOWN first_bad=- r_at_top=0.118735408175 F/(4beta)_top=0.532714430535 pass_0.9_at=0.6'
dk_say "arm 81 (W10(b) ON THE ABELIAN CONTROL -- THE TWISTED RATIO OF THE Z2 HINGE AGAINST THE COUPLING): aperanton_z2_hinge.awk -- on the 2x2xL hinge the twisted ratio Z^-/Z falls monotonically in beta at every L (the content of Tomboulis' (5.15) on a cell: A - A^+ has the sign of -dr/dcoupling), the dead twist reads 1 and the sheet its known value to 1e-47; the abelian cell is monotone everywhere (Griffiths) and cannot discriminate, so the reading with teeth is the nonabelian cell through ΤΟΜΕΥΣ' sector spectra, staked"
# ---- ARM 82 (W10(b) ON THE NONABELIAN CELLS -- THE SHADOWS' HINGE): aperanton_shadow_hinge.awk -- the 1x1xL cell with
# the commutator as its spatial plaquette, the finite shadows of SU(2) as unit quaternions (closed member by member),
# the transfer matrix on the conjugation orbits exact; r_xt the winding twist's ratio (the centre in the x-link's
# temporal plaquette at one step), r_xy the sheet twist's (the centre in the commutator at every slice); the dead
# control two insertions in one plane (Z_dead = Z exactly).  Read here on Q8 and 2T: r_xt MONOTONE-DOWN; r_xy
# NOT-MONOTONE on Q8 at L = 3 and 4 (the first exact nonabelian cell where a twisted ratio rises with the coupling);
# the twist absorbed at zero action by anticommuting pairs (the frozen slope read far below the abelian 2: 't Hooft's
# twist eaters).  The runs of record: shadow_hinge.2026-10-28{a,b,c,d}.txt (Q8, 2T, 2O, 2I on finer grids).
SHADOW="$ROOT/STDLIB/scripts/aperanton_shadow_hinge.awk"; MUTSHADOW="$B/mut_shadow"; mkdir -p "$MUTSHADOW"
cc_shadow(){ cp "$1" "$2"; }
run_mut_shadow(){ { gawk -M -v PREC=96 -v GROUP=q8 -v LS="2 3 4" -v BMIN=0.5 -v BMAX=2 -v BSTEP=0.5 -f "$1"; gawk -M -v PREC=96 -v GROUP=2t -v LS="2 3" -v BMIN=0.5 -v BMAX=2 -v BSTEP=0.5 -f "$1"; } 2>&1 | grep -E '^(G=|SHADOW)'; }
RUNSHADOW="$B/run.shadow.txt"; rm -f "$RUNSHADOW"; run_mut_shadow "$SHADOW" > "$RUNSHADOW"
haveshadow(){ grep -qF -- "$1" "$RUNSHADOW" || dk_red "arm 82: MISSING PIN: $1"; }
haveshadow 'G=q8 L=2 beta=0.5 r_xt=0.945254766382 r_xy=0.604013683235 -lnr_xt/beta=0.112601587535 r_dead=1'
haveshadow 'SHADOW G=q8 L=2 xt=MONOTONE-DOWN first_bad_xt=- xy=MONOTONE-DOWN first_bad_xy=- slope_top=0.494469436174 frozen_slope=2 r_xt_top=0.371971190594 r_xy_top=0.276726104812'
haveshadow 'SHADOW G=q8 L=3 xt=MONOTONE-DOWN first_bad_xt=- xy=NOT-MONOTONE first_bad_xy=2 slope_top=0.36331576324 frozen_slope=2 r_xt_top=0.483535024852 r_xy_top=0.25219686174'
haveshadow 'SHADOW G=q8 L=4 xt=MONOTONE-DOWN first_bad_xt=- xy=NOT-MONOTONE first_bad_xy=2 slope_top=0.259417238022 frozen_slope=2 r_xt_top=0.59521387988 r_xy_top=0.213647011059'
haveshadow 'G=2t L=2 beta=0.5 r_xt=0.961225774185 r_xy=0.595782798162 -lnr_xt/beta=0.0790919217761 r_dead=1'
haveshadow 'SHADOW G=2t L=2 xt=MONOTONE-DOWN first_bad_xt=- xy=MONOTONE-DOWN first_bad_xy=- slope_top=0.421150183685 frozen_slope=1 r_xt_top=0.430718571991 r_xy_top=0.0676215445096'
haveshadow 'SHADOW G=2t L=3 xt=MONOTONE-DOWN first_bad_xt=- xy=MONOTONE-DOWN first_bad_xy=- slope_top=0.241881959175 frozen_slope=1.5 r_xt_top=0.616458719326 r_xy_top=0.0295119363602'
dk_say "arm 82 (W10(b) ON THE NONABELIAN CELLS -- THE SHADOWS' HINGE): aperanton_shadow_hinge.awk -- on the 1x1xL cell with the commutator as its plaquette, Q8 and 2T read exactly: the winding twist's ratio falls monotonically in the coupling, the sheet twist's ratio RISES on Q8 at L = 3 and 4 past beta = 2 (the first exact nonabelian cell where a twisted ratio is not monotone in the coupling -- Tomboulis' (5.15) in its cell form fails for the sheet twist there), the twist absorbed at zero action by anticommuting pairs (the frozen slope 0.49 and 0.42 against the abelian 2 and 1), the dead control exact to 1e-28"
# ---- ARM 83 (THE FROZEN LIMITS OF THE TWISTED RATIOS BY COUNTING): aperanton_shadow_counts.awk -- on the 1x1xL cell at
# large coupling both sectors freeze onto time-constant pairs with the Gauss holonomy; the untwisted ground states are
# the pairwise-commuting triples, the winding-twisted ones need the holonomy to anticommute with x, the sheet-twisted
# ones an anticommuting pair; winding = sheet for every shadow (the bijection exchanging the link y and the holonomy
# g), so the two twists share their frozen limit -- 3/11 (Q8), 1/21 (2T), 1/14 (2O), 1/37 (2I) -- and part only in
# the direction of approach (the hinge: the winding twist descends to it, the sheet twist undershoots and climbs).
COUNTS="$ROOT/STDLIB/scripts/aperanton_shadow_counts.awk"; MUTCOUNTS="$B/mut_counts"; mkdir -p "$MUTCOUNTS"
cc_counts(){ cp "$1" "$2"; }
COUNTS2="$ROOT/STDLIB/scripts/aperanton_shadow_counts2.awk"
run_mut_counts(){ local gg; for gg in q8 2t 2o 2i; do gawk -M -v PREC=64 -v GROUP=$gg -f "$1" 2>&1 | grep -E '^COUNTS'; done; gawk -M -v PREC=64 -f "$COUNTS2" 2>&1 | grep -E '^COUNTS2'; }
run_mut_counts2(){ local gg; for gg in q8 2t 2o 2i; do gawk -M -v PREC=64 -v GROUP=$gg -f "$COUNTS" 2>&1 | grep -E '^COUNTS'; done; gawk -M -v PREC=64 -f "$1" 2>&1 | grep -E '^COUNTS2'; }
RUNCOUNTS="$B/run.counts.txt"; rm -f "$RUNCOUNTS"; run_mut_counts "$COUNTS" > "$RUNCOUNTS"
havecounts(){ grep -qF -- "$1" "$RUNCOUNTS" || dk_red "arm 83: MISSING PIN: $1"; }
havecounts 'COUNTS GROUP=q8 elements=8 commuting_pairs=40 anticommuting_pairs=24 plain_triples=176 winding_triples=48 sheet_triples=48 r_xt_inf=0.272727272727 r_xy_inf=0.272727272727'
havecounts 'COUNTS GROUP=2t elements=24 commuting_pairs=168 anticommuting_pairs=24 plain_triples=1008 winding_triples=48 sheet_triples=48 r_xt_inf=0.047619047619 r_xy_inf=0.047619047619'
havecounts 'COUNTS GROUP=2o elements=48 commuting_pairs=384 anticommuting_pairs=96 plain_triples=2688 winding_triples=192 sheet_triples=192 r_xt_inf=0.0714285714286 r_xy_inf=0.0714285714286'
havecounts 'COUNTS GROUP=2i elements=120 commuting_pairs=1080 anticommuting_pairs=120 plain_triples=8880 winding_triples=240 sheet_triples=240 r_xt_inf=0.027027027027 r_xy_inf=0.027027027027'
havecounts 'COUNTS2 GROUP=q8 cell=2x1xL plain=1408 xt=384 yt=384 xy=384 r_xt_inf=0.272727272727 r_yt_inf=0.272727272727 r_xy_inf=0.272727272727'
dk_say "arm 83 (THE FROZEN LIMITS OF THE TWISTED RATIOS BY COUNTING): aperanton_shadow_counts.awk -- the four shadows of SU(2) closed member by member; the plain, winding and sheet ground-state triples on the 1x1xL cell counted (176/48/48, 1008/48/48, 2688/192/192, 8880/240/240); winding = sheet for every shadow by the exchange of the link y and the holonomy g, so the two twists share their frozen limit (3/11, 1/21, 1/14, 1/37) and part only in the direction of approach, which is the whole content of the hinge's monotone/non-monotone split"
# ---- ARM 84 (SU(2) ITSELF ON THE 1x1xL CELL -- THE QUADRATURE ROAD): aperanton_su2_cell.awk -- the compact group's own
# twisted ratios on the cell whose shadows the hinge read: the orbit space (a, b, u) with Haar's product measure (the
# Chebyshev rule of the second kind in a and b, Legendre in u), the commutator as the Fricke polynomial checked against
# the quaternion product at every node, the Gauss-projected temporal kernel by a three-dimensional rule over the
# relative rotation, the transfer matrix on the orbit nodes; the dead control (two insertions in one plane) reads the
# g-rule's own error (2e-3 at NG = 8, 2e-5 at NG = 12).  The runs of record: su2_cell.2026-10-28a.txt (216 orbit nodes,
# 1728 g-nodes, six couplings) and b.txt (the rules' convergence at beta = 1).
SU2CELL="$ROOT/STDLIB/scripts/aperanton_su2_cell.awk"; MUTSU2CELL="$B/mut_su2cell"; mkdir -p "$MUTSU2CELL"
cc_su2cell(){ cp "$1" "$2"; }
run_mut_su2cell(){ gawk -v NA=4 -v NU=4 -v NG=8 -v LS="2" -v BMIN=1 -v BMAX=1 -v BSTEP=0.5 -f "$1" 2>&1 | grep -E '^(SU2 |SU2CELL|REFUSED)' ; gawk -v NA=4 -v NU=4 -v NG=8 -v LS="2" -v BMIN=1 -v BMAX=1 -v BSTEP=0.5 -f "$1" 2>&1 | grep -E '^# aperanton_su2_cell' | sed 's/run [^ ]* //'; }
RUNSU2CELL="$B/run.su2cell.txt"; rm -f "$RUNSU2CELL"; run_mut_su2cell "$SU2CELL" > "$RUNSU2CELL"
havesu2cell(){ grep -qF -- "$1" "$RUNSU2CELL" || dk_red "arm 84: MISSING PIN: $1"; }
havesu2cell '# aperanton_su2_cell.awk NA=4 NU=4 NG=8 orbit_nodes=64 g_nodes=512 measure_total=1 g_total=1 fricke_check=5.55111512313e-16 LS=2 grid=[1,1] step 0.5'
havesu2cell 'SU2 L=2 beta=1 r_xt=0.836490432701 r_xy=0.345206879949 -lnr_xt/beta=0.178540195918 r_dead=0.997739032389'
havesu2cell 'SU2CELL L=2 xt=MONOTONE-DOWN first_bad_xt=- xy=MONOTONE-DOWN first_bad_xy=- r_xt_top=0.836490432701 r_xy_top=0.345206879949 dead_dev_max=0.00226096761'
dk_say "arm 84 (SU(2) ITSELF ON THE 1x1xL CELL -- THE QUADRATURE ROAD): aperanton_su2_cell.awk -- the compact group on the cell its shadows were read on: Haar's product measure on the orbit space (the total reads 1), the Fricke polynomial equal to the quaternion commutator at every node (5.6e-16), the Gauss-projected kernel by a rule over the relative rotation whose error the dead control reads (2.3e-3 at this configuration, 2e-5 at NG = 12), the winding twist 0.8365 and the sheet twist 0.3452 at beta = 1 on L = 2 -- the design bridge's target"
# ---- ARM 85 (T3 CORRECTED -- THE DESIGN RESIDUE PRICED AT THE LINK): aperanton_design_residue.awk -- a t-design integrates one S^3
# variable exactly to degree t, so on a lattice the finite group agrees with Haar on every character term whose degree in EACH link
# is at most t; the bridge's price is the link-degree tail of the character expansion (compounding with the plaquettes at a link,
# growing with beta), not the one-plaquette spin tail the plan priced.  On the 1x1xL cell at beta = 1 the shadows miss SU(2) by
# 0.0949 (Q8), 0.0107 (2T), 0.00166 (2O): above the one-plaquette tails by 58x, 810x, 29000x and below the corrected per-link bound
# at every shadow; the freezing law in the compounded form puts 2T, 2O, 2I on one level p* = 0.915 within the measured errors.
DESIGN="$ROOT/STDLIB/scripts/aperanton_design_residue.awk"; MUTDESIGN="$B/mut_design"; mkdir -p "$MUTDESIGN"
cc_design(){ cp "$1" "$2"; }
HINGEFORDESIGN="$ROOT/STDLIB/scripts/aperanton_shadow_hinge.awk"
run_mut_design(){ gawk -v BETAS="1" -v TS="3 5 7 11" -v COORD="2 1 1" -f "$1" 2>&1 | grep -E '^(BETA|RESIDUE)'; gawk -v SOLVE=0.915 -v TS="5 11" -v COORD="1 1 1 1 1 1" -f "$1" 2>&1 | grep -E '^SOLVE'; local gg; for gg in q8 2t 2o 2i; do gawk -M -v PREC=96 -v GROUP=$gg -v MODE=design -f "$HINGEFORDESIGN" 2>&1 | grep -E '^DESIGN'; done; }
run_mut_designanchor(){ gawk -v BETAS="1" -v TS="3 5 7 11" -v COORD="2 1 1" -f "$DESIGN" 2>&1 | grep -E '^(BETA|RESIDUE)'; gawk -v SOLVE=0.915 -v TS="5 11" -v COORD="1 1 1 1 1 1" -f "$DESIGN" 2>&1 | grep -E '^SOLVE'; local gg; for gg in q8 2t 2o 2i; do gawk -M -v PREC=96 -v GROUP=$gg -v MODE=design -f "$1" 2>&1 | grep -E '^DESIGN'; done; }
RUNDESIGN="$B/run.designstr.txt"; rm -f "$RUNDESIGN"; run_mut_design "$DESIGN" > "$RUNDESIGN"   # NOT run.design.txt: on this case-insensitive tree that is arm 67's run.Design.txt (the Lean tooth designlean's pristine run), which it overwrote -- run z RED, the block trap's second expression (law 26-ter)
havedesign(){ grep -qF -- "$1" "$RUNDESIGN" || dk_red "arm 85: MISSING PIN: $1"; }
havedesign 'BETA beta=1 I1=0.565159 c_half/c0=0.240194 c_1/c0=0.0392251 c_2/c0=0.000480331'
havedesign 'RESIDUE beta=1 t=3 tail1_oneplaq=0.00164293 P_linkdeg=0.411082 B_linkbad=5.71755 lead=0.88688 lead_spins2j=[1 1 1]'
havedesign 'RESIDUE beta=1 t=7 tail1_oneplaq=5.74067e-08 P_linkdeg=0.033242 B_linkbad=0.462348 lead=0.0715297 lead_spins2j=[3 1 1]'
havedesign 'RESIDUE beta=1 t=11 tail1_oneplaq=2.94629e-13 P_linkdeg=0.000835489 B_linkbad=0.0116204 lead=0.00149656 lead_spins2j=[4 2 2]'
havedesign 'SOLVE t=5 pstar=0.915 beta=2.2738 P=0.915 tail1=0.000864876 lead=47.3184 lead_spins2j=[1 1 1 1 1 1]'
havedesign 'SOLVE t=11 pstar=0.915 beta=5.5156 P=0.915 tail1=1.04676e-05 lead=5090.2 lead_spins2j=[2 2 2 2 2 2]'
havedesign 'DESIGN GROUP=q8 elements=8 invariants_by_2j=[ 1:0.000000 2:0.000000 3:0.000000 4:2.000000 5:0.000000 6:1.000000 7:0.000000 8:3.000000 9:0.000000 10:2.000000 11:0.000000 12:4.000000 13:0.000000 14:3.000000 ] first_invariant_2j=4 t=3'
havedesign 'DESIGN GROUP=2t elements=24 invariants_by_2j=[ 1:0.000000 2:0.000000 3:0.000000 4:0.000000 5:0.000000 6:1.000000 7:0.000000 8:1.000000 9:0.000000 10:0.000000 11:0.000000 12:2.000000 13:0.000000 14:1.000000 ] first_invariant_2j=6 t=5'
havedesign 'DESIGN GROUP=2o elements=48 invariants_by_2j=[ 1:0.000000 2:0.000000 3:0.000000 4:0.000000 5:0.000000 6:0.000000 7:0.000000 8:1.000000 9:0.000000 10:0.000000 11:0.000000 12:1.000000 13:0.000000 14:-0.000000 ] first_invariant_2j=8 t=7'
havedesign 'DESIGN GROUP=2i elements=120 invariants_by_2j=[ 1:0.000000 2:-0.000000 3:0.000000 4:-0.000000 5:0.000000 6:0.000000 7:0.000000 8:0.000000 9:0.000000 10:0.000000 11:0.000000 12:1.000000 13:0.000000 14:-0.000000 ] first_invariant_2j=12 t=11'
dk_say "arm 85 (T3 CORRECTED -- THE DESIGN RESIDUE PRICED AT THE LINK): aperanton_design_residue.awk -- the bridge from a finite subgroup to SU(2) is exact on a character term only while every link carries degree at most the design strength, so its price on a lattice is the link-degree tail (0.41, 0.14, 0.033, 0.00084 for t = 3, 5, 7, 11 on the cell at beta = 1 against one-plaquette tails of 1.6e-3, 1.3e-5, 5.7e-8, 2.9e-13), the shadows' measured misses lying below the corrected bound and far above the old one; the freezing law in the compounded form inverted at p* = 0.915 gives 2.27 and 5.52 against the measured 2.15(15) and 5.70(20) in four dimensions"
# ---- ARM 86 (T3 CORRECTED -- THE DESIGN STRENGTHS BY THE CLASS-DATA ROAD, AND THE BINARY DIHEDRAL FAMILY): DesignDihedral.lean --
# the group average of the spin-j character is the invariant count, U_{2j} at the trace by the integer recursion
# U_{n+1} = a U_n - U_{n-1} over the quadratic ring each group needs; the counts to 2j = 14 of Q8, 2T, 2O, 2I decided from their
# class tables as the literal lists (8 x [0 0 0 2 0 1 0 3 0 2 0 4 0 3], 24 x [0 0 0 0 0 1 0 1 0 0 0 2 0 1], 48 x [.. 1 at 8, 1 at
# 12], 120 x [1 at 12]), hence the strengths 3, 5, 7, 11 -- the second road to Design.lean's quaternion road, and the anchor of
# aperanton_design_residue.awk's t; Dic_3, Dic_4, Dic_6 (orders 12, 16, 24) with their first invariant at 2j = 4: the whole binary
# dihedral family is exactly a 3-design, so the compounded freezing law predicts one departure coupling for all of them.
lean_arm 86 DesignDihedral 18 order_Q8 order_T2 order_O2 order_I2 invariants_Q8 invariants_T2 invariants_O2 invariants_I2 strength_Q8 strength_T2 strength_O2 strength_I2 order_Dic3 order_Dic4 order_Dic6 dic3_first_four dic4_first_four dic6_first_four
dk_say "arm 86 (T3 CORRECTED -- THE DESIGN STRENGTHS BY THE CLASS-DATA ROAD, AND THE BINARY DIHEDRAL FAMILY): DesignDihedral.lean -- 18 theorems in the bare kernel: the invariant counts of the four shadows to 2j = 14 from their class tables by the Chebyshev recursion over Z, Z[sqrt 2] and Z[phi] (the strengths 3, 5, 7, 11 as Design.lean reads them from the quaternions and the hinge instrument reads them from the tables -- three roads), and the binary dihedral groups of orders 12, 16, 24 each a 3-design and not a 4-design"
# ---- ARM 87 (THE FINITE-TO-INFINITE CRITERION ON THE CONTROL'S DUAL): aperanton_simon_lieb.awk -- the Simon-Lieb inequality
# (a ferromagnetic Ising model: <s_0 s_x> <= sum over the boundary of a finite box of <s_0 s_y>_B <s_y s_x>) makes ONE finite box
# certify exponential decay in the infinite volume; the 3D Z2 gauge control is dual to the 3D Ising model (tanh beta_I = e^{-2
# beta_g}), so a certified Ising gap below beta_c = 0.2217 is a certified gap of the gauge control in its deconfined phase; the
# 3x3x3 free box's sum reads 0.9296 at beta_I = 0.10 (beta_g = 1.15): CERTIFIED, the rate 0.0524 solved along the graph distance;
# like for like, Dobrushin ON THE DUAL (alpha = 6 tanh beta_I) certifies beta_I < 0.1682, beta_g > 0.896, in closed form -- more than
# the 27-spin box, which is the instrument whose growth passes that line toward beta_c; the certified correlator is the vortex
# sector, the even sector following by Lebowitz at twice the rate; the box crosses one between 0.10 and 0.12; the one-layer
# brute force equals the layer formula; the symmetry spread 1e-16.
SIMONLIEB="$ROOT/STDLIB/scripts/aperanton_simon_lieb.awk"; MUTSL="$B/mut_simonlieb"; mkdir -p "$MUTSL"
cc_simonlieb(){ cp "$1" "$2"; }
run_mut_simonlieb(){ gawk -v BETAS="0 0.10 0.12" -f "$1" 2>&1 | grep -E '^(SIMONLIEB|DOBRUSHIN-DUAL|CONTROL)'; }
RUNSL="$B/run.simonlieb.txt"; rm -f "$RUNSL"; run_mut_simonlieb "$SIMONLIEB" > "$RUNSL"
havesl(){ grep -qF -- "$1" "$RUNSL" || dk_red "arm 87: MISSING PIN: $1"; }
havesl 'SIMONLIEB beta_I=0 S=0 verdict=CERTIFIED rate_plain=- rate_solved=- face=0 edge=0 corner=0 spread=0 dual_y=0 beta_g=-'
havesl 'SIMONLIEB beta_I=0.1 S=0.929614738397 verdict=CERTIFIED rate_plain=0.0729850384526 rate_solved=0.0524329123946 face=0.103954379369 edge=0.021323730631 corner=0.00625046182622'
havesl 'SIMONLIEB beta_I=0.12 S=1.22954869169 verdict=NOT-CERTIFIED rate_plain=- rate_solved=- face=0.12705853031 edge=0.0315980306133 corner=0.011002642809'
havesl 'CONTROL one-layer beta_I=0.1 <s4 s5> brute=0.101647542629 layer=0.101647542629 diff=0'
havesl 'DOBRUSHIN-DUAL beta_I=0.1 alpha=6tanh=0.59800796775 verdict=CERTIFIED rate=0.514151201124 threshold_beta_I=0.168236118311 beta_g_at_threshold=0.895879734614'
dk_say "arm 87 (THE FINITE-TO-INFINITE CRITERION ON THE CONTROL'S DUAL): aperanton_simon_lieb.awk -- the Simon-Lieb sum of the 3D Ising model on a 27-spin free box, exact by the layer transfer matrix: 0.9296 at beta_I = 0.10, below one, so the infinite-volume gap of the 3D Z2 gauge control in its deconfined phase at beta_g = 1.15 is at least 0.0524 by a theorem (the vortex sector; the even sector at twice the rate by Lebowitz); like for like, Dobrushin on the dual Ising model certifies beta_g > 0.896 in closed form, more than this box, which is the instrument whose growth passes that line toward beta_c; the sum crosses one between beta_I = 0.10 and 0.12 for this box; the one-layer brute force equals the layer formula to the last digit, the box's symmetry holds to 1e-16"
# ---- ARM 88 (THE PRODUCT FIBER IN ITS OWN METRIC): aperanton_probe.awk with CONSTR=1 FIBMETRIC=1 -- on the fiber of eight states
# (the plaquette's product fixed) the moves are pair flips and the free coordinates are three, so the theorem's distance is the
# Hamming distance over the three free bits and the normalisation the free count; the influence reads 1.3255 at y = 13/15 (above
# one: the constrained criterion fails where the unconstrained block reads 0.824), refuting the link-Hamming estimate 0.905 of
# the morning's desk (two metrics that are not proportional: k free coordinates are k + (k mod 2) link flips).
run_mut_fibm(){ gawk -M -v P=13 -v Q=15 -v CONSTR=1 -v FIBMETRIC=1 -f "$1" 2>&1 | grep -E '^(PROBE|PROBE-DSW1)'; }
RUNFIBM="$B/run.fibmetric.txt"; rm -f "$RUNFIBM"; run_mut_fibm "$PROBESRC" > "$RUNFIBM"
havefibm(){ grep -qF -- "$1" "$RUNFIBM" || dk_red "arm 88: MISSING PIN: $1"; }
havefibm 'PROBE square CONSTR=1 y=13/15 states=1296 admitted=8 variables=2'
havefibm 'PROBE-DSW1 square CONSTR=1 FIBMETRIC=1 y=13/15 flows=5760 sum r = 2556788097904592539548216510318829453341105623400 / 642988249460083308773809402152551131767772889839 = 3.976414965672 ; (1/|B|) sum r = 852262699301530846516072170106276484447035207800 / 642988249460083308773809402152551131767772889839 = 1.325471655224 verdict=NOT-BELOW-ONE'
dk_say "arm 88 (THE PRODUCT FIBER IN ITS OWN METRIC): aperanton_probe.awk FIBMETRIC=1 -- the single-plaquette product fiber's influence with the three free coordinates' Hamming distance and the free count reads 1.3255 at y = 13/15, above one where the unconstrained block reads 0.824: the product form of T2 has no certified first step at this block, and the morning's rescaled estimate 0.905 is refuted by the record"
# ---- ARM 89 (THE SIMON-LIEB SHAPE ON THE VORTEX SECTOR -- THE SHADOWS): aperanton_shadow_hinge.awk MODE=vortex -- the disorder string
# mu(t) (the spatial plaquette twisted by the centre at slices 0 .. t-1, at infinite L by the Perron vectors) and the box of three cubes
# whose outside bonds are frozen flat (the end slices restricted to the flat orbits); the inequality mu(t) <= c_minus mu(t+1) + c_plus
# mu(t-1) is Simon-Lieb through Wegner's duality on Z2 -- the cell's dual the 1D Ising chain, mu = e^{-2 beta t} and c = e^{-2 beta}
# EXACTLY, the known answer read to twelve digits -- and on Q8 it FAILS at beta = 2 (ratio 1.859: the twist eaters cheapen the
# infinite string, m = 0.736, while the flat-ended box's twist costs 0.250 < m/(1 + m^2)).
VORTEXH="$ROOT/STDLIB/scripts/aperanton_shadow_hinge.awk"; MUTVORT="$B/mut_vortex"; mkdir -p "$MUTVORT"
cc_vortex(){ cp "$1" "$2"; }
run_mut_vortexh(){ gawk -M -v PREC=96 -v GROUP=z2 -v MODE=vortex -v BETAS="1" -v TMAX=3 -f "$1" 2>&1 | grep -E '^(VORTEX|SIMONLIEB-VORTEX)'; gawk -M -v PREC=96 -v GROUP=q8 -v MODE=vortex -v BETAS="2" -v TMAX=3 -f "$1" 2>&1 | grep -E '^(VORTEX|SIMONLIEB-VORTEX)'; }
RUNVORTH="$B/run.vortexh.txt"; rm -f "$RUNVORTH"; run_mut_vortexh "$VORTEXH" > "$RUNVORTH"
havevh(){ grep -qF -- "$1" "$RUNVORTH" || dk_red "arm 89: MISSING PIN: $1"; }
havevh 'VORTEX G=z2 beta=1 lam=25.8899800213 mu(1)=0.135335283237 mu(2)=0.0183156388887 mu(3)=0.00247875217667 c_minus=0.135335283237 c_plus=0.135335283237 known_z2_mu1=0.135335283237 known_z2_c=0.135335283237'
havevh 'SIMONLIEB-VORTEX G=z2 beta=1 t=2 mu(t)=0.0183156388887 rhs=0.0186511015166 ratio=0.982013790038 HOLDS'
havevh 'VORTEX G=q8 beta=2 lam=998.817813116 mu(1)=0.229962773978 mu(2)=0.162595400502 mu(3)=0.119674455151 c_minus=0.250159786164 c_plus=0.250159786164 known_z2_mu1=- known_z2_c=-'
havevh 'SIMONLIEB-VORTEX G=q8 beta=2 t=2 mu(t)=0.162595400502 rhs=0.0874651744737 ratio=1.85897303105 FAILS'
dk_say "arm 89 (THE SIMON-LIEB SHAPE ON THE VORTEX SECTOR -- THE SHADOWS): aperanton_shadow_hinge.awk MODE=vortex -- the disorder string and the flat-ended box on the 1x1xL cell: Z2 reads the dual Ising chain exactly (mu = e^{-2 beta t}, c = e^{-2 beta}, the inequality holding at the ratio 1/(1 + e^{-4 beta})), the theorem Simon-Lieb through the duality on the instrument's own output; Q8 fails it at beta = 2 by the twist eaters (ratio 1.859): a finite-group fact on the sector where the inequality lives"
# ---- ARM 90 (THE SIMON-LIEB SHAPE ON THE VORTEX SECTOR -- SU(2) ITSELF): aperanton_su2_cell.awk MODE=vortex -- the same string and box
# on the compact group by quadrature: the flat end slices carry the UNIFORM measure in the half-angles (the flat moduli of the torus:
# Haar's sin^2 factors cancel against the collapse of the orbit's transverse directions), axes parallel or antiparallel at weight
# 1/2; c_minus = c_plus to 1e-15 (the box's time reversal); SU(2) HOLDS at beta = 1 (ratio 0.759, against Q8's 0.780).
VORTEXS="$ROOT/STDLIB/scripts/aperanton_su2_cell.awk"
run_mut_vortexs(){ gawk -v NA=4 -v NU=4 -v NG=8 -v NF=6 -v MODE=vortex -v BETAS="1" -v TMAX=3 -f "$1" 2>&1 | grep -E '^(VORTEX-SU2|SIMONLIEB-VORTEX-SU2)'; }
RUNVORTS="$B/run.vortexs.txt"; rm -f "$RUNVORTS"; run_mut_vortexs "$VORTEXS" > "$RUNVORTS"
havevs(){ grep -qF -- "$1" "$RUNVORTS" || dk_red "arm 90: MISSING PIN: $1"; }
havevs 'VORTEX-SU2 beta=1 lam=1.8605738284 iterations=12 mu(1)=0.607300255483 mu(2)=0.375633346927 mu(3)=0.232460656716 c_minus=0.589368955671 c_plus=0.589368955671'
havevs 'SIMONLIEB-VORTEX-SU2 beta=1 t=2 mu(t)=0.375633346927 rhs=0.494929011836 ratio=0.758964089685 HOLDS'
dk_say "arm 90 (THE SIMON-LIEB SHAPE ON THE VORTEX SECTOR -- SU(2) ITSELF): aperanton_su2_cell.awk MODE=vortex -- the disorder string at infinite L and the flat-ended box with the flat moduli's uniform measure: SU(2) holds the inequality at beta = 1 (ratio 0.759) where the finer rules read it to beta = 3 in the record su2_vortex.2026-10-28a.txt"
# ---- ARM 91 (THE SIMON-LIEB BOX GROWN BY A SECOND ROAD): aperanton_simon_lieb_box.awk -- the inter-layer coupling exp(beta sum s_i t_i)
# applied as nx ny two-point transforms v[t] e^beta + v[t xor bit] e^-beta (no 512 x 512 matrix), so the box grows to a 4 x 4 layer at
# 2^16 states; the 3 x 3 x 3 box reproduces the first road's S = 0.929614738397 at beta_I = 0.10 to the last digit (two roads sharing no
# line), the 4 x 4 x 4 box at the origin (1,1,1) reads 0.6449 there, certifies to beta_I = 0.12 (beta_g 1.06) and sits at 2.04 on
# Dobrushin-on-the-dual's line 0.1682: at every size gawk holds, the box is behind the one-line bound and is the instrument that grows.
SLBOX="$ROOT/STDLIB/scripts/aperanton_simon_lieb_box.awk"; MUTSLB="$B/mut_slbox"; mkdir -p "$MUTSLB"
cc_slbox(){ cp "$1" "$2"; }
run_mut_slbox(){ gawk -v NX=3 -v NY=3 -v NZ=3 -v BETAS="0.10" -f "$1" 2>&1 | grep -E '^SIMONLIEB-BOX'; gawk -v NX=4 -v NY=4 -v NZ=4 -v OX=1 -v OY=1 -v OZ=1 -v BETAS="0.10" -f "$1" 2>&1 | grep -E '^SIMONLIEB-BOX'; }
RUNSLB="$B/run.slbox.txt"; rm -f "$RUNSLB"; run_mut_slbox "$SLBOX" > "$RUNSLB"
haveslb(){ grep -qF -- "$1" "$RUNSLB" || dk_red "arm 91: MISSING PIN: $1"; }
haveslb 'SIMONLIEB-BOX box=3x3x3 beta_I=0.1 boundary_sites=26 S=0.929614738397 verdict=CERTIFIED rate_plain=0.0729850384526 rate_solved=0.0524329123946 dobrushin_dual=0.59800796775 beta_g=1.15295533518'
haveslb 'SIMONLIEB-BOX box=4x4x4 beta_I=0.1 boundary_sites=56 S=0.644898513195 verdict=CERTIFIED rate_plain=0.438662318449 rate_solved=0.243144485682 dobrushin_dual=0.59800796775 beta_g=1.15295533518'
dk_say "arm 91 (THE SIMON-LIEB BOX GROWN BY A SECOND ROAD): aperanton_simon_lieb_box.awk -- the site-factorised transfer reproduces the dense road's 3x3x3 sum 0.929614738397 at beta_I = 0.10 to the last digit and grows the box to 4x4x4 (S = 0.6449 there, certified to beta_I = 0.12): behind Dobrushin on the dual at every size gawk holds, the instrument whose growth in compiled III is the abelian control's finite-to-infinite road toward beta_c"
# ---- ARM 92 (THE SIMON-LIEB SHAPE ON THE EVEN SECTOR OF THE CONTROL): aperanton_z2_hinge.awk MODE=even -- the plaquette P(0,0) at
# slice 0 against itself at slice t on the 2x2xL cell at infinite L (the Perron vectors of the transfer matrix by power iteration),
# the box the open three-slice slab with its own means, its boundary the eight plaquettes at the slices +-1; the truncated
# Simon-Lieb shape FAILS at every coupling and every t (7 per cent at beta = 0.2, 8 at 0.5, a factor ten at beta = 1): the shape is
# the odd sector's -- the dual spins, where it is a theorem -- and the open non-abelian lemma must be sought on the vortex sector.
Z2EVEN="$ROOT/STDLIB/scripts/aperanton_z2_hinge.awk"; MUTEVEN="$B/mut_even"; mkdir -p "$MUTEVEN"
cc_even(){ cp "$1" "$2"; }
run_mut_even(){ gawk -M -v PREC=160 -v MODE=even -v BETAS="0.5 1" -v TMAX=2 -f "$1" 2>&1 | grep -E '^(EVEN|SIMONLIEB-EVEN)'; }
RUNEVEN="$B/run.even.txt"; rm -f "$RUNEVEN"; run_mut_even "$Z2EVEN" > "$RUNEVEN"
haveeven(){ grep -qF -- "$1" "$RUNEVEN" || dk_red "arm 92: MISSING PIN: $1"; }
haveeven 'EVEN beta=0.5 lam=1214.85667104 iterations=34 <P>=0.613074696439 <P^2>=1 <P0>_B=0.607241321865 <P+1>_B=0.575056574003 box: <P0 P(0,0)+1>_B=0.3787133583 <P0 P(1,0)+1>_B=0.365053500516 <P0 P(0,1)+1>_B=0.365053500516 <P0 P(1,1)+1>_B=0.364806034187'
haveeven 'SIMONLIEB-EVEN beta=0.5 t=2 lhs=0.377540466217 rhs_full=1.13526940002 HOLDS | lhs_T=0.00167988280343 rhs_T=0.00155632330132 FAILS'
haveeven 'SIMONLIEB-EVEN beta=1 t=2 lhs=0.986154661177 rhs_full=7.62687525994 HOLDS | lhs_T=7.71749976866e-06 rhs_T=7.34637427738e-07 FAILS'
dk_say "arm 92 (THE SIMON-LIEB SHAPE ON THE EVEN SECTOR OF THE CONTROL): aperanton_z2_hinge.awk MODE=even -- the truncated Simon-Lieb shape on plaquette correlations fails at every coupling on the 2x2xL cell (0.00168 against 0.00156 at beta = 0.5, 7.7e-6 against 7.3e-7 at beta = 1): the inequality is the odd sector's, and the non-abelian lemma is sought on the vortex sector, where the next two arms read it"
# ---- ARM 93 (THE TWIST EATER'S LAW IN THE KERNEL): TwistEater.lean -- on the 1x1xL cell of Q8, with z^2 = e^beta, the vacuum
# and the twisted transfer matrices (symmetric form, the temporal link integrated over the eight group elements) both have Perron
# root between z^6 and z^6 + 64 z^4: the vacuum's floor is the identity pair's diagonal, the twisted sector's the Rayleigh quotient
# on the TWIST EATER'S ORBIT (+-i, +-j) whose commutator is the twisting element, the ceilings the row sums where the degree-six
# part of every row is exactly the orbit's eight temporal images (counted by decide).  Hence the vortex string's rate
# m = lambda0(T^tw)/lambda0(T) lies in [z^6/(z^6 + 64 z^4), 1 + 64/z^2] and tends to one (rate_tendsto): the twisted sector's
# free energy per slice tends to the vacuum's, while a Simon-Lieb box with the Ising dual's free boundary pays the bare z^-4 for
# its twist -- the shape c >= m/(1 + m^2) dies for every large beta (the master plan note §37.4; measured on the shadows' record).
lean_arm 93 TwistEater 39 qmul_assoc qmul_inv q0_conj ij_eq_k temp_symm temp_two_count eater_qP eater_count K_symm T_herm Ttw_herm lamMax_ge_diag lamMax_T_ge eater_rayleigh lamMax_Ttw_ge lamMax_le_rowsum row_bound lamMax_T_le lamMax_Ttw_le twist_eater_law rate_bounds rate_tendsto
dk_say "arm 93 (THE TWIST EATER'S LAW IN THE KERNEL): TwistEater.lean -- 39 theorems in the bare kernel: Q8's tables decided, the Perron roots of the vacuum and the twisted transfer matrices of the 1x1xL cell both in [z^6, z^6 + 64 z^4], the vortex string's rate tending to one -- why the Simon-Lieb shape cannot survive on the vortex sector of a non-abelian group"
# ---- ARM 94 (THE FLAT MEASURE BY AN EXACT ROAD): aperanton_flat_marginal.awk -- the vortex box's end slice is the limit beta_p -> oo
# of e^{beta_p q0(P)} on a slice's pair; its alpha-marginal from the character expansion (no grid) is
# rho(alpha) = (2/pi) sum_n I_n(beta) sin^2(n alpha) / sum_n I_n(beta): FLAT at 0.325574 at beta = 320 from pi/8 to pi/2, tending to
# 1/pi as beta^-1/2 (the corner mass), where a Haar-weighted limit would read (2/pi) sin^2 alpha -- the uniform measure of arm 90's
# flat nodes on a second exact road, and the FLATBETA grid check convicted (0.600 at every beta_p: a grid cannot collapse a Gaussian).
FLATM="$ROOT/STDLIB/scripts/aperanton_flat_marginal.awk"; MUTFLATM="$B/mut_flatm"; mkdir -p "$MUTFLATM"
cc_flatm(){ cp "$1" "$2"; }
run_mut_flatm(){ gawk -M -v PREC=512 -v BETAS="320" -v ALPHAS="0.0625 0.125 0.25 0.5 0.75 1" -f "$1" 2>&1 | grep -E '^(BETA|  alpha)'; }
RUNFLATM="$B/run.flatm.txt"; rm -f "$RUNFLATM"; run_mut_flatm "$FLATM" > "$RUNFLATM"
haveflatm(){ grep -qF -- "$1" "$RUNFLATM" || dk_red "arm 94: MISSING PIN: $1"; }
haveflatm 'BETA=320 N=183 Z_exact=2.879289e+136 e^beta/beta=2.944993e+136 ratio=0.977690'
haveflatm '  alpha=1*pi/2 rho=0.325574 uniform=0.318310 haar=0.636620'
dk_say "arm 94 (THE FLAT MEASURE BY AN EXACT ROAD): aperanton_flat_marginal.awk -- the end slice's alpha-marginal by the character expansion is flat at beta = 320 (0.325574 at every alpha from pi/8 to pi/2, 1/pi = 0.318310 the limit, Haar's 0.636620 at pi/2 refused) and the partition sum meets e^beta/beta at 0.977690: the vortex box's uniform measure on a second exact road, the orbit-grid check convicted"
# ---- ARM 95 (THE NON-ABELIAN GKS-II FOR CHARACTERS, READ EXACTLY): the hinge's and the SU(2) cell's MODE=gks -- the connected
# two-point functions C_nm(t) = <chi_n(P_0) chi_m(P_t)> - <chi_n><chi_m> of the plaquette characters of DIFFERENT spins at infinite
# L, the equal-spin diagonal non-negative by reflection positivity (the RP control), the off-diagonal the content of a GKS-II that
# Griffiths.lean proves for Z2 and no one has proved for a non-abelian group (Abdesselam-Uraltsev-Webster, Bonn 2025, form
# unpublished; this is the characters' reading).  The pins: 2T at beta = 2 (every off-diagonal positive, 0.0102..0.131), SU(2) at
# the coarse rule beta = 1 (the one-point line, chi_2's negative: the finer records gks_shadow a / gks_su2 a carry the readings).
GKSH="$ROOT/STDLIB/scripts/aperanton_shadow_hinge.awk"; GKSU="$ROOT/STDLIB/scripts/aperanton_su2_cell.awk"; MUTGKS="$B/mut_gks"; mkdir -p "$MUTGKS"
cc_gks(){ cp "$1" "$2"; }
run_mut_gksh(){ gawk -M -v PREC=96 -v GROUP=2t -v MODE=gks -v BETAS="2" -v TMAX=2 -v NMAX=4 -f "$1" 2>&1 | grep -E '^GKS'; }
run_mut_gksu(){ gawk -v NA=4 -v NU=4 -v NG=8 -v MODE=gks -v BETAS="1" -v TMAX=2 -v NMAX=4 -f "$1" 2>&1 | grep -E '^GKS'; }
RUNGKSH="$B/run.gksh.txt"; rm -f "$RUNGKSH"; run_mut_gksh "$GKSH" > "$RUNGKSH"
RUNGKSU="$B/run.gksu.txt"; rm -f "$RUNGKSU"; run_mut_gksu "$GKSU" > "$RUNGKSU"
havegksh(){ grep -qF -- "$1" "$RUNGKSH" || dk_red "arm 95: MISSING PIN: $1"; }
havegksu(){ grep -qF -- "$1" "$RUNGKSU" || dk_red "arm 95: MISSING PIN: $1"; }
havegksh 'GKS-ONE G=2t beta=2 lam=4523.73917101 <chi_1/2>=1.64783641592 <chi_2/2>=2.30454565361 <chi_3/2>=3.29567283184 <chi_4/2>=4.30454565361'
havegksh 'GKS-TWO G=2t beta=2 n=3 m=1 t=1 two=5.49806759994 conn=0.067337892666 HOLDS'
havegksu 'GKS-TWO-SU2 beta=1 n=2 m=1 t=1 two=0.625415301966 conn=0.011091847263 HOLDS'
grep -q "FAILS" "$RUNGKSH" && dk_red "arm 95: a connected character correlation on 2T at beta = 2 is negative"
dk_say "arm 95 (THE NON-ABELIAN GKS-II FOR CHARACTERS, READ EXACTLY): MODE=gks on the hinge and the SU(2) cell -- the connected two-point functions of plaquette characters of different spins are non-negative on 2T at beta = 2 at t = 1, 2 (the pinned n = 3, m = 1 line), the first exact reading of a GKS-II on a non-abelian group; SU(2)'s coarse one-point line pinned, the finer readings in the records"
# ---- ARM 96 (KOVACS-TOMBOULIS' VORTEX-PAIR FACTORISATION, READ EXACTLY): MODE=ktpair -- their Z(2) monopoles are the sign changes
# of the spatial plaquette between slices of the 1x1xL cell; z(l) the relative weight of a monopole pair at distance l in the
# sign-constant background (F = -ln z their two-vortex free energy, LINEAR in l on a tube by geometry: no transverse room for the
# flux to spread, so eq. 25's boundedness is unreadable here and said so), and the two-pair ratio z(l1, d, l2)/(z(l1) z(l2)), their
# eq. 24 in local form, holding with every shape pair (the FKG content) on every cell read: Q8 1.37 at beta = 3, SU(2) 1.0001 at 1.
KTH="$GKSH"; KTU="$GKSU"
run_mut_kth(){ gawk -M -v PREC=96 -v GROUP=q8 -v MODE=ktpair -v BETAS="1 3" -v LMAX=2 -v DMAX=2 -f "$1" 2>&1 | grep -E '^KT'; }
run_mut_ktu(){ gawk -v NA=4 -v NU=4 -v NG=8 -v MODE=ktpair -v BETAS="1 2" -v LMAX=2 -v DMAX=2 -f "$1" 2>&1 | grep -E '^KT'; }
RUNKTH="$B/run.kth.txt"; rm -f "$RUNKTH"; run_mut_kth "$KTH" > "$RUNKTH"
RUNKTU="$B/run.ktu.txt"; rm -f "$RUNKTU"; run_mut_ktu "$KTU" > "$RUNKTU"
havekth(){ grep -qF -- "$1" "$RUNKTH" || dk_red "arm 96: MISSING PIN: $1"; }
havektu(){ grep -qF -- "$1" "$RUNKTU" || dk_red "arm 96: MISSING PIN: $1"; }
havekth 'KT-PAIR G=q8 beta=3 l=1 z=0.000113113837231 F=-ln z=9.08711583722 lambda_vv/lambda_ff=0.00211606581594'
havekth 'KT-FACTOR G=q8 beta=1 l1=1 d=1 l2=2 z12=0.000378930641672 z1z2=0.00037799830622 ratio=1.00246650696 HOLDS'
havektu 'KT-PAIR-SU2 beta=1 l=1 z=0.166620365616 F=-ln z=1.79203731413 lambda_vv/lambda_ff=0.180772529257'
grep -q "FAILS" "$RUNKTH" "$RUNKTU" && dk_red "arm 96: a two-pair ratio below one"
dk_say "arm 96 (KOVACS-TOMBOULIS' VORTEX-PAIR FACTORISATION, READ EXACTLY): MODE=ktpair -- the two-pair ratio of their eq. 24 is above one for every pair of shapes and distances on Q8 (beta = 1, 3) and SU(2) (beta = 1, 2, the coarse rule), the pair's free energy linear in its separation on the tube at the untwisted vortex sector's rate: the easy half of Kovacs-Tomboulis read exactly for the first time, the hard half (their eq. 25) named unreadable on a tube"
# ---- ARM 97 (LAMBDA5(i): THE FLUX-CLASS-RESOLVED SIMON-LIEB SHAPE): the hinge's and the SU(2) cell's MODE=vortex with ENDS=eater --
# the box's end slices restricted to the EATER class (the orbits whose commutator is the twisting element; on SU(2) the single eater
# node (i, j), its moduli modulo conjugation a point), the string and the inequality unchanged.  Where the flat-ended shape fails at
# beta = 2 (arms 89-90: Q8 1.859, SU(2) coarse 1.218) the eater-ended shape HOLDS (Q8 0.553 with c = 0.8407 against the flat-ended
# 0.2502; SU(2) 0.702 with c = 0.5040 against 0.2907): the inequality written in the sector where the twist lives absorbs the twist
# as the infinite string does.  The first candidate finite-box shape that survives the twist eater on the cell; the records
# shadow_vortex c (every shadow, six couplings) and su2_vortex b (SU(2) at NA = NU = 6, NG = 12) carry the readings under S61-S62.
EATERH="$ROOT/STDLIB/scripts/aperanton_shadow_hinge.awk"; EATERS="$ROOT/STDLIB/scripts/aperanton_su2_cell.awk"; MUTEAT="$B/mut_eater"; mkdir -p "$MUTEAT"
cc_eater(){ cp "$1" "$2"; }
run_mut_eaterh(){ gawk -M -v PREC=96 -v GROUP=q8 -v MODE=vortex -v ENDS=eater -v BETAS="2" -v TMAX=3 -f "$1" 2>&1 | grep -E '^(VORTEX|SIMONLIEB)'; }
run_mut_eaters(){ gawk -v NA=4 -v NU=4 -v NG=8 -v NF=6 -v MODE=vortex -v ENDS=eater -v BETAS="2" -v TMAX=3 -f "$1" 2>&1 | grep -E '^(VORTEX|SIMONLIEB)'; }
RUNEATH="$B/run.eaterh.txt"; rm -f "$RUNEATH"; run_mut_eaterh "$EATERH" > "$RUNEATH"
RUNEATS="$B/run.eaters.txt"; rm -f "$RUNEATS"; run_mut_eaters "$EATERS" > "$RUNEATS"
haveeath(){ grep -qF -- "$1" "$RUNEATH" || dk_red "arm 97: MISSING PIN: $1"; }
haveeats(){ grep -qF -- "$1" "$RUNEATS" || dk_red "arm 97: MISSING PIN: $1"; }
haveeath 'VORTEX G=q8 beta=2 lam=998.817813116 mu(1)=0.229962773978 mu(2)=0.162595400502 mu(3)=0.119674455151 c_minus=0.840651221025 c_plus=0.840651221025 known_z2_mu1=- known_z2_c=-'
haveeath 'SIMONLIEB-VORTEX G=q8 beta=2 t=2 mu(t)=0.162595400502 rhs=0.293922963583 ratio=0.553190531697 HOLDS'
haveeats 'VORTEX-SU2 beta=2 lam=6.66396013216 iterations=18 mu(1)=0.336937634994 mu(2)=0.140164151402 mu(3)=0.0589599256338 c_minus=0.503991748381 c_plus=0.503991748381'
haveeats 'SIMONLIEB-VORTEX-SU2 beta=2 t=2 mu(t)=0.140164151402 rhs=0.199529103761 ratio=0.70247472053 HOLDS'
dk_say "arm 97 (LAMBDA5(i): THE FLUX-CLASS-RESOLVED SIMON-LIEB SHAPE): ENDS=eater on the hinge and the SU(2) cell -- with the box's ends in the eater class the shape HOLDS at beta = 2 on Q8 (0.553, c = 0.8407) and on SU(2) (0.702, c = 0.5040) where the flat-ended shape of arms 89-90 fails: the first finite-box shape that survives the twist eater on the cell, its readings on every shadow and SU(2) in the records shadow_vortex c and su2_vortex b"
# ---- ARM 98 (THE TWIST EATER'S LAW FOR EVERY FINITE GROUP WITH AN EATER): TwistEaterGeneral.lean -- the hypotheses a trace-half with a
# gap and an eater; the conclusion both Perron roots of the 1x1xL cell in [z^6, z^6 (1 + |G|^2 z^-2delta)] for z >= 1 (eater_law), the
# rate in [1/(1 + |G|^2 z^-2delta), 1 + |G|^2 z^-2delta] (rate_bounds), tending to one (rate_tendsto); the degree-six terms of a row
# are the |G| zero-cost slices t^-1 s t (temp = 2 iff s' = act t s), every other term 2delta lower; Q8's delta = 1 and |G|^2 = 64
# recover arm 93's bounds.  The general theorem behind §37.4: the magnetic flux is free at zero temperature in a finite volume for
# every finite group with an eater, which is why no abelian-type finite-box criterion survives on its vortex sector.
lean_arm 98 TwistEaterGeneral 40 q_eq_one_iff temp_eq_two_iff temp_le_gap temp_symm act_act comm_act K_symm T_herm Ttw_herm T_one lamMax_T_ge qP_E E_fibre_sum eater_rayleigh lamMax_Ttw_ge lamMax_le_rowsum row_bound lamMax_T_le lamMax_Ttw_le eater_law rate_bounds rate_tendsto
dk_say "arm 98 (THE TWIST EATER'S LAW FOR EVERY FINITE GROUP WITH AN EATER): TwistEaterGeneral.lean -- 40 theorems in the bare kernel over an arbitrary finite group with a trace-half gap delta and an eater: the vacuum and twisted Perron roots of the 1x1xL cell in [z^6, z^6 (1 + |G|^2 z^-2delta)], the vortex string's rate tending to one -- the law of arm 93 for every finite subgroup of SU(2) with -1 and an anticommuting pair"
# ---- ARM 99 (THE TOWER'S STEP): TowerStep.lean -- a coarse variable enters the fine weight as a positive local factor; for two
# coarse variables i, j whose factors sit at level distance R, the mixed second difference of the renormalised Hamiltonian,
# log [Z Z_ij / (Z_i Z_j)] = log [<g_i g_j> / (<g_i><g_j>)] (mixed_difference_eq), is bounded by 2 N_j D_i alpha^R / ((1 - alpha) m_i)
# whenever that is at most one (renorm_interaction_le, from cov_le and |log x| <= 2|x - 1| on x >= 1/2): the effective action at
# the next scale is exponentially local with the fine scale's Dobrushin rate -- T2's per-step certificate output, the first lemma
# of Stage II's Tower.lean (the master plan note §43 (6)(iii)).
lean_arm 99 TowerStep 4 abs_log_le_two_abs_sub_one gibbs_pos mixed_difference_eq renorm_interaction_le
dk_say "arm 99 (THE TOWER'S STEP): TowerStep.lean -- 4 theorems in the bare kernel: the renormalised interaction between two coarse variables at level distance R is at most 2 N_j D_i alpha^R / ((1 - alpha) m_i) -- the next scale's effective action exponentially local with the fine scale's Dobrushin rate, composed from Dobrushin.lean's cov_le"
# ---- ARM 101 (THE TOWER'S COMPOSITION): Tower.lean -- conditioning on the sites outside a block (the coarse data under
# decimation) splits a covariance exactly, cov(f, g) = <cov(f, g | outside b)> + cov(E_b f, E_b g) (cov_total_block, three uses
# of Block.lean's gibbs_condExpB); the constrained term is the covariance on the fibre over b (condCovB_eq_cov_fibre) and is
# bounded by Dobrushin's cov_le with the fibre's own interdependence matrix, row sums <= alpha < 1 (condCov_le_fibre: T2's
# per-scale constrained criterion, the one the instruments measure); the two-scale bound adds the coarse covariance's bound
# (cov_le_two_scales) -- with TowerStep's locality of the renormalised interaction (arm 99) the composition of scales that T1
# reads as the gap's proof skeleton, every hypothesis a finite reading.
lean_arm 101 Tower 8 fibreW_pos condExpB_eq_gibbs_fibre condCovB_eq_cov_fibre condExpB_free_on_block cov_total_block condCov_le_fibre abs_gibbs_condCov_le cov_le_two_scales
dk_say "arm 101 (THE TOWER'S COMPOSITION): Tower.lean -- 8 theorems in the bare kernel: the law of total covariance over a block, the conditional covariance as the fibre's covariance bounded by cov_le with the fibre's own Dobrushin data, and the two-scale bound -- the composition of scales as an exact identity plus two finite criteria"
# ---- ARM 102 (THE Z2 TUBE CONTROL OF THE WINDING TWIST): aperanton_z2_tube.awk -- the 2+1-dimensional Z2 gauge theory on an
# L x L x infinity tube in the gauge-invariant orbit basis of the spatial links (2^(L^2+1) orbits of size 2^(L^2-1), counted
# against the expectation), the winding magnetic twist as one flipped plaquette in the spatial weight (its position a control),
# m_L = lam_tw / lam the vortex line's weight per slice.  L = 1 is the bookkeeping control (the 1x1 spatial plaquette is
# identically one, so m_1 = e^-2beta exactly); L = 2 reads the collapse of the cost from the bookkeeping 2 beta to the
# local-defect value in the confining phase (0.0156 at beta = 0.3 against 2 beta^4) and to just below the thin vortex's
# 2 beta in the ordered phase (1.47 at beta = 1): the winding line pays a perimeter law in both phases of 2+1 dimensions,
# which is why no tube reads confinement through this sector (§42.15; the four-dimensional vortex sheet does).
Z2TUBE="$ROOT/STDLIB/scripts/aperanton_z2_tube.awk"; MUTZ2T="$B/mut_z2tube"; mkdir -p "$MUTZ2T"
cc_z2tube(){ cp "$1" "$2"; }
run_mut_z2tube(){ gawk -v L=1 -v BETAS="0.3" -f "$1" 2>&1 | grep -E '^Z2TUBE'; gawk -v L=2 -v BETAS="1.0" -f "$1" 2>&1 | grep -E '^Z2TUBE'; }
RUNZ2T="$B/run.z2tube.txt"; rm -f "$RUNZ2T"; run_mut_z2tube "$Z2TUBE" > "$RUNZ2T"
havez2t(){ grep -qF -- "$1" "$RUNZ2T" || dk_red "arm 102: MISSING PIN: $1"; }
havez2t 'Z2TUBE L=1 beta=0.3 lam=5.90013894699 lam_tw=3.23806490868 m=0.548811636094 minus_ln_m=0.6'
havez2t 'Z2TUBE L=2 beta=1 lam=177079.035298 lam_tw=40816.6976611 m=0.230499887197 minus_ln_m=1.467504906'
dk_say "arm 102 (THE Z2 TUBE CONTROL OF THE WINDING TWIST): aperanton_z2_tube.awk -- the winding twist on the L x L Z2 tube in the orbit basis: L = 1 the bookkeeping e^-2beta to twelve digits, L = 2 the collapse to the local-defect cost at beta = 0.3 (0.0156) and to just below 2 beta at beta = 1 (1.4675) -- a perimeter law in both phases of 2+1 dimensions, the sector no tube reads confinement through"
# ---- ARM 103 (THE ONSAGER TOWER, SCALES 0 AND 1): aperanton_ising_tower.awk -- T2's decimation tower on the 2D Ising model,
# whose infinite-volume gap is exact (Onsager: m(K) = 2(K* - K), tanh K* = e^-2K, K_c = 0.4407): scale 0 the single-site
# Dobrushin criterion (row sum 4 tanh K, dead at K0 = atanh(1/4) = 0.2554), scale 1 the checkerboard decimation whose free
# spins are independent given the coarse data and whose coarse action is exact (NN 2B, NNN B, a four-spin C on every diamond,
# from 2 cosh(K(a+b+c+d)) = exp(A + B p2 + C abcd)), the coarse single-site criterion the sup over 256 data of the tanh
# difference under each neighbour's flip, dead at K1 by bisection.  THE READING: K1 = 0.297945 > K0 (the first scale GAINS
# 16.7 per cent in K; S68 held), the certified fraction of the true gap 0.61 -> 0.18 over K = 0.05 -> 0.25 at scale 1 against
# 0.56 -> 0.02 at scale 0: the tower's per-scale reach as a number against a known answer (§44 RESULTS 1).
ISINGT="$ROOT/STDLIB/scripts/aperanton_ising_tower.awk"; MUTISG="$B/mut_ising"; mkdir -p "$MUTISG"
cc_ising(){ cp "$1" "$2"; }
run_mut_ising(){ gawk -v KS="0.2 0.3" -f "$1" 2>&1 | grep -E '^ISING'; }
RUNISG="$B/run.isingtower.txt"; rm -f "$RUNISG"; run_mut_ising "$ISINGT" > "$RUNISG"
haveisg(){ grep -qF -- "$1" "$RUNISG" || dk_red "arm 103: MISSING PIN: $1"; }
haveisg 'ISING K=0.2 onsager_m=1.222648 | scale0 alpha0=0.789501 m0=0.236354 ratio0=0.1933 | scale1 B=0.036344 C=-0.002633 entries NN=0.07780 NNN=0.03893 alpha1=0.466886 m1=0.380835 ratio1=0.3115'
haveisg 'ISING-K1 K1=0.297945 (alpha1 = 1) against K0=0.255413: K1/K0=1.1665 K1/Kc=0.6761 GAIN'
dk_say "arm 103 (THE ONSAGER TOWER, SCALES 0 AND 1): aperanton_ising_tower.awk -- the single-site criterion dies at K0 = 0.255413, the checkerboard decimation's exact coarse action carries its criterion to K1 = 0.297945 (a gain of 16.7 per cent, S68 held); at K = 0.2 the certified mass 0.236 (scale 0) and 0.381 (scale 1) against Onsager's 1.223 -- the tower's reach per scale as a number against an exact gap"
# ---- ARM 104 (THE ONSAGER TOWER, SCALE 2): aperanton_ising_tower2.awk -- the scale-1 coarse theory (arm 103) decimated again
# by the checkerboard: the free_2 spins given the coarse_2 data form an Ising model with data-dependent bonds B + C c1 c2 and
# fields 2B, in Dobrushin uniqueness at every K <= K_c (4 tanh(B + |C|) < 1; Haller-Kennedy's condition for the decimation's
# Gibbsianness); the coarse_2 single-site criterion at the origin by a fibre-window transfer matrix of radius 2 (the log-odds
# of the origin's conditional from the fibre partition functions Z+ and Z- plus the four direct NNN couplings; the Dobrushin
# entry per near neighbour the sup over the 256 near data; the far data at a reference, their one-flip sensitivity measured at
# the window's edge below 1.2e-3), dead at K2 by bisection.  THE READING: K2 = 0.35735 against K1 = 0.297945 and K0 = 0.255413 --
# the second scale's step 0.059 LARGER than the first's 0.043, K2/K_c = 0.81: by the rule written before the record, the tower
# is reaching (§44 RESULTS 2).  Record a; record b the window's truncation at R = 3.
ISINGT2="$ROOT/STDLIB/scripts/aperanton_ising_tower2.awk"; MUTISG2="$B/mut_ising2"; mkdir -p "$MUTISG2"
cc_ising2(){ cp "$1" "$2"; }
run_mut_ising2(){ gawk -v KS="0.25" -v R=2 -v BISECT=1 -f "$1" 2>&1 | grep -E '^ISING2'; }
RUNISG2="$B/run.isingtower2.txt"; rm -f "$RUNISG2"; run_mut_ising2 "$ISINGT2" > "$RUNISG2"
haveisg2(){ grep -qF -- "$1" "$RUNISG2" || dk_red "arm 104: MISSING PIN: $1"; }
haveisg2 'ISING2 K=0.25 R=2 onsager_m=0.906829 fibre_alpha=0.239941 entries NNN=0.08115 0.08115 0.08115 0.08115 diag=0.01440 0.01440 0.01440 0.01440 alpha2=0.382164 m2=0.240476 ratio2=0.2652'
haveisg2 'ISING2-K2 R=2 K2=0.35735 (alpha2 = 1, bisection to 1e-4) against K1=0.297945 and K0=0.255413: K2/K1=1.1994 K2/Kc=0.8109 GAIN'
dk_say "arm 104 (THE ONSAGER TOWER, SCALE 2): aperanton_ising_tower2.awk -- the coarse_2 criterion by a fibre-window transfer matrix dies at K2 = 0.35735 against K1 = 0.297945 and K0 = 0.255413 (the second step larger than the first, K2/K_c = 0.81); at K = 0.25 the certified mass 0.240 (0.265 of Onsager) against scale 1's 0.166 -- the tower is reaching, by the rule written before the reading"
# ---- ARM 105 (THE ONSAGER TOWER MADE ITERABLE, WITH ITS FAR TAIL): aperanton_ising_tower3.awk -- one checkerboard decimation
# step of an NN + NNN + plaquette Ising model: the fibre criterion, the coarse criterion by the fibre-window transfer matrix as
# the near row sum plus the far tail (the window's other coarse sites flipped at the reference, summed), and the next scale's
# three couplings by the Walsh transform of the window's log-odds (the omitted terms measured), iterated from scale 2's exact
# couplings.  The KAT: scale 2 at K = 0.25 reproduces arm 104's alpha = 0.382164 (the near sum).  The near-only series read
# K3 = 0.4008, K4 = 0.4336 and then CONVICTED ITSELF at scale 5 (a certified rate above Onsager's gap at K = 0.44: law 4); record
# d read the far tail at most one per cent of the row sum at every cell (0.0094 against 0.712 at scale 5, K = 0.44), so the tail
# is NOT the conviction's cause: the cause is the TRUNCATION of the renormalized interaction to three couplings, whose in-window
# L1 mass the step measures as resl1 (0.274 at scale 2, 0.111 at 3, 0.072 at 4 at K = 0.44) and then DROPS, so every scale past
# the first reads a WEAKER model than the Ising model's coarse-graining; the penalized series is record d's (K2 = 0.3561,
# K3 = 0.4000).  The reading of record: a decimation tower's reach against an exact gap, scale by scale, a certificate only where
# the dropped mass is small against the margin, and said so where it is not (§44 RESULTS 3-6).
ISINGT3="$ROOT/STDLIB/scripts/aperanton_ising_tower3.awk"; MUTISG3="$B/mut_ising3"; mkdir -p "$MUTISG3"
cc_ising3(){ cp "$1" "$2"; }
run_mut_ising3(){ gawk -v K=0.25 -v R=2 -f "$1" 2>&1 | grep -E '^STEP'; gawk -v BISECT3=3 -v R=2 -f "$1" 2>&1 | grep -E '^STEP'; }
RUNISG3="$B/run.isingtower3.txt"; rm -f "$RUNISG3"; run_mut_ising3 "$ISINGT3" > "$RUNISG3"
haveisg3(){ grep -qF -- "$1" "$RUNISG3" || dk_red "arm 105: MISSING PIN: $1"; }
haveisg3 'STEP scale=2 K=0.25 R=2 in: J1=0.108445 J2=0.054223 C4=-0.005835 fibre_alpha=0.239941 | alpha_near=0.382164 tail=0.006823(16 far sites) alpha_pen=0.388988 m=0.236052 ratio=0.2603'
haveisg3 'STEP-K3-PEN R=2 K3=0.4000 (scale 3 alpha_near + far tail = 1, bisection to 3e-4 in [0.2, 0.44]; the effective action truncated to NN+NNN+plaquette, the window radius R, the region beyond it not in the tail) K3/Kc=0.9076'
dk_say "arm 105 (THE ONSAGER TOWER MADE ITERABLE, WITH ITS FAR TAIL): aperanton_ising_tower3.awk -- the step reproduces scale 2 (alpha_near(0.25) = 0.382164); the far tail is at most one per cent of the row sum at every cell, so the scale-5 conviction by Onsager is the truncation's (the dropped interaction's L1 mass resl1 measured at every step, 0.27 at scale 2 at K = 0.44); the penalized K3 = 0.4000 (record d) is a reading of the truncated model, a certificate only where resl1 is small against the margin"
# ---- ARM 108 (THE TUBE THEOREM FOR GKS-II AT EVERY SEPARATION): aperanton_tube_gks.awk on the overlap records -- on a tube the
# connected two-point function of two plaquette characters is C(t) = sum_k w_k r_k^t over the transfer matrix's levels; with N the
# negative carriers, r1 their top rate, W their mass, and S+ the positive mass at rates >= r1 weighted by the rate, S+ > W r1 gives
# C(t) >= r1^(t-1)(S+ - W r1) > 0 at every t >= 1.  Read on the fourteen blocks of overlap a (2T, 2O, 2I at beta = 1, 2, 3) and
# overlap_su2 a (SU(2) at beta = 1, 2, 3) with the carriers above each instrument's resolution: 81 of 84 pairs GKS-ALL-T -- the
# census' holds at t <= 4 extended to every t by the spectrum -- and three NOT CONCLUDED, all SU(2) at beta = 3 against the spin-2
# character, where a level above the leading carrier reads a small negative overlap: if real, GKS-II fails there at t beyond about
# seventy (the counterexample candidate; the finer rule's record b decides it).  The reading of record is the record's, pinned.
TUBEGKS="$ROOT/STDLIB/scripts/aperanton_tube_gks.awk"; MUTTGK="$B/mut_tubegks"; mkdir -p "$MUTTGK"
cc_tubegks(){ cp "$1" "$2"; }
run_mut_tubegks(){ gawk -f "$1" "$ROOT/STDLIB/build/aperanton/overlap.2026-10-28a.txt" "$ROOT/STDLIB/build/aperanton/overlap_su2.2026-10-28a.txt" 2>&1 | grep -E '^TUBE-GKS'; }
RUNTGK="$B/run.tubegks.txt"; rm -f "$RUNTGK"; run_mut_tubegks "$TUBEGKS" > "$RUNTGK"
havetgk(){ grep -qF -- "$1" "$RUNTGK" || dk_red "arm 108: MISSING PIN: $1"; }
havetgk 'TUBE-GKS-TOTAL blocks=14 pairs=84 concluded=81 NOT-EVERY-PAIR'
havetgk 'TUBE-GKS G=2i beta=3 n=1 m=4 top_positive_k=6 r0=0.273089 negW=0.00477537 r1=0.104806 Splus=0.032478 Wr1=0.000500486 C1=0.0533202 margin=0.0533202 carriers=18+/14- cut=1.6e-09 GKS-ALL-T'
havetgk 'TUBE-GKS G=SU2 beta=3 n=1 m=4 top_positive_k=6 r0=0.270903 negW=0.0110418 r1=0.346713 Splus=0 Wr1=0.00382834 C1=0.0377101 margin=0.0377101 carriers=17+/9- cut=8.2e-06 NOT-CONCLUDED(positive-mass-above-the-negative-rates-does-not-dominate;)'
dk_say "arm 108 (THE TUBE THEOREM FOR GKS-II AT EVERY SEPARATION): aperanton_tube_gks.awk -- 81 of 84 character pairs on the fourteen tube blocks conclude GKS-II at every t from the spectrum (S+ > W r1), the three not concluded all SU(2) at beta = 3 against the spin-2 character, the counterexample candidate named with its test"
# ---- ARM 107 (THE ONSAGER TOWER WITH THE INTERACTION CARRIED WHOLE): aperanton_ising_tower4.awk -- the checkerboard
# decimation iterated with every Z2-even term of the 3x3 patch carried to the next scale (255 Walsh terms of the origin's log-odds,
# a term's coupling the mean of its readings, the spread printed), the fibre summed by a Gray-code walk over the radius-2 window's
# 2^16 free spins (one spin flips per state, nine patch codes update, two lookups each), the origin's log-odds as the ratio of the two
# weighted sums from one walk; the Dobrushin row sum over the eight near neighbours plus the far tail at two references.  The KAT:
# the reader on the exact scale-1 table (J1, J2, C4 recovered, every other even term zero, spread zero); the walk against a direct
# enumeration of the explicit energy on the same window (cfg 178; the far flip at (4,2)); the walk's bookkeeping against
# from-scratch codes; alpha_near against the old instrument's 0.382164 within 0.02 (that one a free boundary).  THE READING OF
# RECORD at the kill-switch cell, scale 5 at K = 0.44: m=0.021810 mfine=0.061688 ratio=22.4443 (record a; Onsager 0.002749) -- the sentence §44 RESULTS 7 reads.
ISINGT4="$ROOT/STDLIB/scripts/aperanton_ising_tower4.awk"; MUTISG4="$B/mut_ising4"; mkdir -p "$MUTISG4"
cc_ising4(){ cp "$1" "$2"; }
run_mut_ising4(){ gawk -v KAT=1 -f "$1" 2>&1 | grep -E '^(KAT4|STEP4)'; gawk -v K=0.44 -v NEXT=3 -f "$1" 2>&1 | grep -E '^STEP4'; }
RUNISG4="$B/run.isingtower4.txt"; rm -f "$RUNISG4"; run_mut_ising4 "$ISINGT4" > "$RUNISG4"
haveisg4(){ grep -qF -- "$1" "$RUNISG4" || dk_red "arm 107: MISSING PIN: $1"; }
haveisg4 'KAT4 reader: types=200 NN err=4.16e-17 NNN err=1.39e-17 PLAQ err=8.67e-18 other max=1.99e-17 spread=1.39e-17 evenl1=0.674010 oddl1=1.14e-16 EXACT'
haveisg4 'KAT4 walk vs direct (cfg 178): walk=0.146560470114 direct=0.146560470114 diff=2.34e-13 bookkeeping max=9.77e-15 EXACT'
haveisg4 'STEP4 scale=5 K=0.44 R=2 in: types=200 l1=0.419772 fibre_crude=0.329531 | alpha_near=0.485512 tail_ref=0.002935 tail_min=0.012105(cfg 53) alpha_pen=0.497617 m=0.021810 mfine=0.061688 ratio=22.4443'
dk_say "arm 107 (THE ONSAGER TOWER WITH THE INTERACTION CARRIED WHOLE): aperanton_ising_tower4.awk -- the reader exact on the scale-1 table, the walk equal to the direct road at 1e-9, and at the kill-switch cell (scale 5, K = 0.44) the reading m=0.021810 mfine=0.061688 ratio=22.4443 against Onsager 0.002749 (record a)"
# ---- ARM 110 (THE CERTIFIED SCALE-2 CRITERION ON THE INFINITE LATTICE, THE THEOREM ROAD): aperanton_fibre_cert.awk -- Dobrushin's
# sum for the coarse specification of the Onsager tower's second scale, bounded over EVERY coarse datum of the infinite lattice:
# the influence of a datum on the origin's conditional law is a mixed difference of the fibre's log-partition function, its
# spin-spin covariances bounded by Ding-Song-Sun (1.4) with FKG and Griffiths II, its bond parts by B1/B2, the zero-field two-point
# function of the infinite free fibre by the Lieb-Simon walk sum (the resolvent of tanh(K_f) A on the square lattice), the sites
# beyond the 16th shell by an analytic remainder; the exact T0 on 5, 7, 9, 11 free windows by transfer matrix printed beside the
# walk bound, which dominates every window or the instrument is convicted.  At K = 0.3 the sum is below one: the second scale
# CERTIFIES a coupling above the single-site K0 = 0.2554; the bisection of record locates K2_cert (pinned from the record).
FIBCERT="$ROOT/STDLIB/scripts/aperanton_fibre_cert.awk"; FCREC="$ROOT/STDLIB/build/aperanton/fibre_cert.2026-10-28a.txt"; MUTFC="$B/mut_fibcert"; mkdir -p "$MUTFC"
cc_fibcert(){ cp "$1" "$2"; }
run_mut_fibcert(){ gawk -v K=0.3 -f "$1" 2>&1 | grep -E '^FIBRE-CERT'; }
RUNFC="$B/run.fibcert.txt"; rm -f "$RUNFC"; run_mut_fibcert "$FIBCERT" > "$RUNFC"
havefc(){ grep -qF -- "$1" "$RUNFC" || dk_red "arm 110: MISSING PIN: $1"; }
havefc 'FIBRE-CERT K=0.3 TOTAL=0.926502 = field 0.765634 + bond 0.160868 + remainder 3.241e-13; near window (the 15 sites of fibre_influence) field 0.733104 bond 0.148566 near 0.881670; CERTIFIED (sum < 1)'
havefc 'FIBRE-CERT K=0.3 walk bound: W[0,1]=0.090846474 (ratio to T0_11 1.0551) W[1,1]=0.015771969 (ratio to T0_11 1.0792) W[0,2]=0.008125004 (ratio to T0_11 1.0806) W[1,2]=0.002079548 (ratio to T0_11 1.1044) W[2,2]=0.000361942 (ratio to T0_11 1.1298) W[0,3]=0.000736987 (ratio to T0_11 1.1074) dominates_every_window=yes remainder_per_site=1.230e-47'
grep -qF -- 'FIBRE-CERT-K2 K2_cert in [0.30588, 0.30594] (the theorem road: the certified reach of the second scale; the single-site K0 = 0.2554, the measured K2 = 0.3485)' "$FCREC" || dk_red "arm 110: the K2 bracket is not in the record: FIBRE-CERT-K2 K2_cert in [0.30588, 0.30594] (the theorem road: the certified reach of the second scale; the single-site K0 = 0.2554, the measured K2 = 0.3485)"
dk_say "arm 110 (THE CERTIFIED SCALE-2 CRITERION ON THE INFINITE LATTICE, THE THEOREM ROAD): aperanton_fibre_cert.awk -- Dobrushin's sum for the second scale's coarse specification bounded over every datum by Ding-Song-Sun, B1/B2 and the walk bound, below one at K = 0.3; the walk bound dominates the exact windows; K2_cert bracketed in the record"
# ---- ARM 111 (THE MIGDAL-KADANOFF FLOW OF SU(2) AND ITS U(1) CONTROL): aperanton_mk_flow.awk -- the plaquette weight as a class
# function in the character basis, the MK step at b = 2 in d dimensions exact up to the cut (the bond-moving by the Clebsch-Gordan
# series, the two-dimensional decimation by the fourth power of the coefficients; d = 2 is YM2's heat-kernel composition, c -> c^4):
# from beta = 2.3 in d = 4 the flow reaches the kernel's one-link threshold 0.131 in K* = 8 steps (a first-step transient from the
# Wilson form, then a monotone descent); the heat-kernel start at beta = 40 meets the second-order law t' = t + t^2/4 with a cubic
# remainder near t^3/12 (the Haar measure's (theta/sin theta)^3 broadening, beta' = beta - 1/4 at large beta); the U(1) control
# (aperanton_mk_flow_u1.awk, the Fourier basis) from beta = 6 does NOT reach strong coupling in twelve steps -- a line
# of fixed points to double precision -- at 256 bits a descent of 3e-13 per step at beta_eff 2.8, Ito 1985 permanent confinement of the hierarchical U(N) model, the known artefact -- the discriminator the RATE, 1/4 against e^{-c beta}.  The hierarchical model is the exact model of the
# gluing the Z^4 theorem needs, not that theorem.
MKFLOW="$ROOT/STDLIB/scripts/aperanton_mk_flow.awk"; MKU1="$ROOT/STDLIB/scripts/aperanton_mk_flow_u1.awk"; MUTMK="$B/mut_mkflow"; mkdir -p "$MUTMK"
cc_mkflow(){ cp "$1" "$2"; }
run_mut_mkflow(){ { gawk -v D=4 -v BETA=2.3 -f "$1" | grep -E '^MK-FLOW d=4 beta=2.3 K'; gawk -v D=4 -v BETA=40 -v HK=1 -v KMAX=1 -v NMAX=200 -f "$1" | grep -E '^MK-HK-STEP'; gawk -v D=4 -v BETA=6 -v KMAX=12 -f "$MKU1" | grep -E '^MKU1-FLOW'; } 2>&1; }
RUNMK="$B/run.mkflow.txt"; rm -f "$RUNMK"; run_mut_mkflow "$MKFLOW" > "$RUNMK"
havemk(){ grep -qF -- "$1" "$RUNMK" || dk_red "arm 111: MISSING PIN: $1"; }
havemk 'MK-FLOW d=4 beta=2.3 K*=8 (steps to beta_eff < 0.131) rises=1 final_beta_eff=0.034401026 REACHES-STRONG-COUPLING-WITH-RISES'
havemk 'MK-HK-STEP beta=40 after one step: c_1=0.962966796370 (predicted 0.962968695482, residual -1.899e-06) c_2=0.904267319542 (predicted 0.904272071339, residual -4.752e-06) c_3=0.828050019176 (predicted 0.828058168709, residual -8.150e-06); the width read from c_1: t1=0.025157565, t1 - t - t^2/4 = 1.315e-06, over t^3 = 0.08414 (the cubic coefficient; 1/12 = 0.08333)'
havemk 'MKU1-FLOW d=4 beta=6 K*=-1 rises=11 final_beta_eff=6.442048036 NOT-REACHED-IN-KMAX'
dk_say "arm 111 (THE MIGDAL-KADANOFF FLOW OF SU(2) AND ITS U(1) CONTROL): the exact recursion in the character basis reaches the kernel's threshold from beta = 2.3 in eight steps, the heat-kernel start meets the derived second-order law at beta = 40, and the U(1) control descends only exponentially slowly (Ito 1985) -- the curvature of the group is the rate"
# ---- ARM 112 (THE TOWER CHAIN): TowerChain.lean -- the composition of per-scale certificates: ChainOK holds when at every block
# level the conditional covariance of the current observables given the block is at most that level's K and the next level reads
# their conditional expectations, ending with |cov| <= K_fin; cov_le_chain composes the chain to |cov W f g| <= sum K + K_fin by
# induction on the levels (the master plan note §53's Conversion 2: the gap as the chain's trivial kernel, the hierarchical model's
# correlation decay across levels in exactly this shape).
lean_arm 112 TowerChain 3 chainOK_nil chainOK_cons cov_le_chain
dk_say "arm 112 (THE TOWER CHAIN): TowerChain.lean -- 3 theorems in the bare kernel: a chain of per-level conditional-covariance certificates composes to a covariance bound by their sum"
# ---- ARM 100 (THE TWIST EATER'S LAW SHARPENED): TwistEaterSharp.lean -- the exact row sum of the transfer kernel on the 1x1
# cell, sum_{s'} K z s s' = W^2 for every s (row_sum_exact: the bijection shift s t of G x G under Equiv.sum_comp and the
# product of two sums), W <= z^2 (1 + (|G| - 1) z^-2delta) (Wsum_le: the identity's term apart, the gap on every other), hence
# both Perron roots in [z^6, z^6 (1 + (|G| - 1) z^-2delta)^2] (eater_law_sharp) -- the sharpening of arm 98's bound the master
# plan note §42.2 derived at the desk, the same limit, a smaller constant.
lean_arm 100 TwistEaterSharp 7 temp_split w_pos row_sum_exact Wsum_le Wsum_nonneg row_bound_sharp eater_law_sharp
dk_say "arm 100 (THE TWIST EATER'S LAW SHARPENED): TwistEaterSharp.lean -- 7 theorems in the bare kernel: the transfer kernel's row sum is exactly W^2 for every row, W <= z^2 (1 + (|G| - 1) z^-2delta), both Perron roots in [z^6, z^6 (1 + (|G| - 1) z^-2delta)^2]"
# ---- ARM 113 (THE CONTESTED STEP ON THE EXACTLY SOLVED CONTROL): aperanton_kaufman_step.awk -- the 2D Ising torus in its four
# boundary sectors by Kaufman's closed form, the sign patterns PINNED by brute force on the 3x3 and 4x4 torus (pp all plus with the
# signed gamma_0 = 2(K - K*); pa = ap; aa), then Tomboulis's potential-moving step on spins (the odd rows' and columns' bonds dropped,
# the even ones raised to zeta K, the chain middles summed exactly: A = 2 sqrt(cosh 2 zeta K), tanh K' = tanh^2(zeta K)), alpha
# matching the periodic Z and alpha^- the antiperiodic one at 256 bits: THE EXACT FREE-ENERGY INTERPOLATION'S FIXED POINT IS NOT THE
# TRANSITION -- at K_c = 0.4407 the coarse coupling is 0.3870, the flow's own fixed point 0.4994, the ordered window (0.4407, 0.4994)
# carried into the disordered phase; the parameters coincide for large lattices (O(1/L) in the ordered phase, O(1/L^2) at K_c) and
# the ratio Z^-/Z is not preserved: true and insufficient (the master plan note §55 RESULTS 1).
KAUF="$ROOT/STDLIB/scripts/aperanton_kaufman_step.awk"; MUTKF="$B/mut_kaufman"; mkdir -p "$MUTKF"
cc_kaufman(){ cp "$1" "$2"; }
run_mut_kaufman(){ { gawk -v MODE=kat -f "$1" | grep -E '^KAUF-PIN'; gawk -M -v PREC=256 -v MODE=step -v PP="1,1,1,1" -v PA="1,-1,1,-1" -v KGRID="Kc 0.5" -v LLIST="64 128" -f "$1" | grep -E '^KAUF-STEP'; } 2>&1; }
RUNKF="$B/run.kaufman.txt"; rm -f "$RUNKF"; run_mut_kaufman "$KAUF" > "$RUNKF"
havekf(){ grep -qF -- "$1" "$RUNKF" || dk_red "arm 113: MISSING PIN: $1"; }
havekf 'KAUF-PIN L=4 K=0.3 sector=pp pattern=1,1,1,1'
havekf 'KAUF-PIN L=3 K=0.6 sector=aa pattern=-1,1,1,-1'
havekf 'KAUF-STEP K=Kc L=128 alpha=1.598779529782714253 alpha_minus=1.598728872072727604'
havekf 'KAUF-STEP K=0.5 L=64 alpha=1.656269394471092981 alpha_minus=1.654219304911577338'
dk_say "arm 113 (THE CONTESTED STEP ON THE EXACTLY SOLVED CONTROL): Kaufman's sectors pinned by brute force, and the exact free-energy interpolation of the potential-moving step has its fixed point at K* = 0.4994 against the transition 0.4407 -- no sandwich on Z decides the phase"
# ---- ARM 114 (THE HIERARCHICAL GAP): aperanton_mk_gap.awk -- the hierarchical model whose exact renormalisation is the Migdal-
# Kadanoff step (decimate, then move) read as a LATTICE: the upward influence R_k, the descent kernels H_j, the series and parallel
# two-point functions at the lowest common ancestor, all Clebsch-Gordan products, coefficient products and one integral, with no
# division of functions.  The mean <chi_1> read from every level agrees to 4e-16; at beta = 2.3 the correlation at distances 1, 2,
# 4, 8 reads 2.0e-2, 1.2e-6, 1.3e-19, 6.3e-68 of the variance -- the decay is BY AREA, exp(-c dist^2), not exponential: the
# hierarchical model has no mass gap in the exponential sense (the master plan note §56 RESULTS 1), and at beta >= 3 its weak-
# coupling levels decay by a power before the collapse -- both regimes of the true two-point function, with the gap's exponential
# law living between them in the couplings the model lacks.
MKGAP="$ROOT/STDLIB/scripts/aperanton_mk_gap.awk"; MUTMG="$B/mut_mkgap"; mkdir -p "$MUTMG"
cc_mkgap(){ cp "$1" "$2"; }
run_mut_mkgap(){ gawk -v BETA=2.3 -v KMAX=12 -f "$1" 2>&1 | grep -E '^MKGAP'; }
RUNMG="$B/run.mkgap.txt"; rm -f "$RUNMG"; run_mut_mkgap "$MKGAP" > "$RUNMG"
havemg(){ grep -qF -- "$1" "$RUNMG" || dk_red "arm 114: MISSING PIN: $1"; }
havemg 'MKGAP-MEAN beta=2.3 <chi_1>=0.977865468612180 <chi_2>=0.521453963883255'
havemg 'MKGAP-2PT beta=2.3 level=2 dist=2 c_1=2.035283e-01 Gser=7.020041555839e-07'
dk_say "arm 114 (THE HIERARCHICAL GAP): the hierarchical model's two-point function decays by area, not exponentially -- its mean consistent across every level, its correlation at distance 2 a millionth of the variance at beta = 2.3"
# ---- ARM 121 (THE ASSEMBLY WITH THE FIBRE): MassGapAssembly.lean -- the coarse weight as the pushforward of the fine weight along
# the block map, the fibre mean and fibre covariance, THE LAW OF TOTAL COVARIANCE exact (the fine covariance = the coarse average
# of the fibre covariance + the coarse covariance of the fibre means), Hypothesis I (Dobrushin on the COARSE weight: coarse
# variables of one fixed type, so the criterion does not saturate) and Hypothesis II (the fibre covariance bounded, the fibre
# means quasi-local in the range form) as separate kernel objects, and cov_le_assembly: fine covariance <= the fibre term + cov_le
# on the coarse weight applied to the fibre means. Whole-block total variation is nowhere in the file (the 00:4x form withdrawn,
# master plan §62 (c) CORRECTED); the tail-to-range passage is the page's weighted comparison lemma, named, not claimed.
lean_arm 121 MassGapAssembly 8 coarseW_pos fibre_sum_eq gibbs_eq_coarse gibbs_add cov_total abs_gibbs_le_of_abs_le fibreMean_pos cov_le_assembly
dk_say "arm 121 (THE ASSEMBLY WITH THE FIBRE): MassGapAssembly.lean -- 8 theorems in the bare kernel: the law of total covariance exact, the coarse criterion and the fibre clustering as separate hypotheses, and the fine covariance bounded by the fibre term plus Dobrushin on the coarse weight"
# ---- ARM 122 (THE PERFECT DECIMATION IN THE KERNEL): PerfectDecimation.lean -- the period-2 link cover of Z^4 found by
# exact-cover search (STDLIB/scripts/aperanton_perfect_cover.pl, record perfect_cover.2026-10-29a.txt) decided in the bare
# kernel on the 2^4 torus: every (i,j)-plaquette meets the cover in exactly one link, the cover is independent, it has sixteen
# members, every link lies in six plaquettes -- the combinatorial fact under the ledger's §73(f): the integrated links form a
# product measure given the rest (Hypothesis II exact) and the coarse specification has range two with explicit entries.
lean_arm 122 PerfectDecimation 4 perfect_cover cover_independent cover_card link_in_six
dk_say "arm 122 (THE PERFECT DECIMATION): PerfectDecimation.lean -- 4 theorems in the bare kernel: the period-2 cover meets every plaquette of the 2^4 torus exactly once, independent, sixteen members, six plaquettes per link"
# ---- ARM 123 (THE PERFECT DECIMATION CERTIFIED): aperanton_decimation_cert.awk -- the kept-link Dobrushin row sum of the
# period-2 perfect decimation with every constant proved (the ledger's §73 ter): 12 direct rows at rho(4b/3pi)m(5b) plus the
# tilt of the anisotropy and the cubic tail, 90 mediated rows at rho b^2/(3pi) plus theirs, D5 = m(5b)^2/3 (the two-sided
# Turan inequality, termwise), T6 = m(6b)/2 (the Riccati identity), rho = (3e^w - 1)/2, the tilt lemma tanh(w/4) <= w/4; at
# gawk -M 256 bits padded by 1e-50 it closes at beta0 = 0.241 with ROW below 0.9963 -- a lattice mass gap at strong coupling
# for beta < 0.241 = 1.84 x 3pi/72, group-blind, strong end only.
DCERT="$B/run.decimation_cert.txt"; rm -f "$DCERT"
gawk -M -f STDLIB/scripts/aperanton_decimation_cert.awk > "$DCERT" 2>&1
cc_dcert(){ cp "$1" "$2"; }
run_mut_dcert(){ gawk -M -f "$1" 2>&1; }
dk_have "$DCERT" "DECIMATION-CERT beta0=0.2410 ROW_hi=0.996296731 closes=1 prec=256 pad=1e-50 constants=proved (Turan termwise; T<=m/2; MAD 2/(3pi) of record)"
dk_have "$DCERT" "KAT m(1) = 0.240193723870 (I_2(1)/I_1(1) = 0.240194...); m(0.4)/0.4 = 0.248349824127 (< 1/4)"
dk_say "arm 123 (THE PERFECT DECIMATION CERTIFIED): the kept-link Dobrushin row sum closes at beta0 = 0.241 with every constant proved"
# ---- ARM 115 (THE CROSSOVER CRITERION): CrossoverCriterion.lean -- the consumer of the crossover theorem: a Wilson weight tilted by
# any non-Wilson part delta has Dobrushin interdependence at most e^{o s} C s t + (1 - e^{-Delta s t}), o the oscillation of delta
# along a site and Delta its mixed second difference (the sharp tilt constant e^{o} from the signed-sum argument; 2e^{2o} - 1 the
# first), so the row sums are at most e^{o} alpha + sum_t (1 - e^{-Delta}) and cov_le gives the gap whenever that is below one: the
# influence budget the analytic control of the crossover must deliver, with its number (the master plan note §57).
lean_arm 115 CrossoverCriterion 19 tv_tilt_le tv_tilt_pair_le cond_tilt interdep_tilt rowsum_tilt_le tv_eq_sum_pos tv_tilt_pair_le_sharp interdep_tilt_sharp rowsum_tilt_le_sharp
dk_say "arm 115 (THE CROSSOVER CRITERION): CrossoverCriterion.lean -- 19 theorems in the bare kernel: a Wilson weight tilted by any non-Wilson part keeps Dobrushin's gap whenever e^o times its row sum plus the mixed differences' sum is below one"
# ---- ARM 117 (THE UV INTERFACE): UVInterface.lean -- Σ1's delivery as a definition: a family of effective weights at the physical
# scale, one per cutoff, each a tilt of ONE base weight by a part of oscillation at most o_n and mixed difference at most Δ_n; and
# THE UNIFORMITY THEOREM: the base weight's row sum α₀ gives every cutoff's row sum e^{o_n}α₀ + Σ(1 − e^{−Δ_n}), and when those sit
# under one α < 1 the comparison theorem's rate α and range R are the same for every n -- the physical gap one constant along the
# whole sequence (the plan's Σ4; nothing here proves the interface holds, which is Σ1 cited and Σ2 open).
lean_arm 117 UVInterface 3 interdep_uniform_of_interface rowsum_uniform_of_interface cov_le_uniform_of_interface
dk_say "arm 117 (THE UV INTERFACE): UVInterface.lean -- 3 theorems in the bare kernel: the interface as a definition and the uniform rate and range it buys for every cutoff at once"
# ---- ARM 118 (THE Z2 REHEARSAL OF THE CHAIN): Z2Chain.lean -- the two clauses' thresholds on 4D Z2 (the strong clause y > 13/15 at
# link degree 4, Z2Slab's transfer_gap_sharp; the weak clause y < 1/18 via the dual, TorusT3Assembly's vacuum_two_point_le) and the
# self-dual place y* = sqrt 2 - 1, the fixed point of the duality map, admitted by NEITHER: the chain's ramified place exhibited in
# the kernel (beta < 0.0716 and beta > 1.445 covered, the transition 0.4407 between them) -- the sighted negative the SU(2) chain's
# every clause is measured against (the plan B6; the master plan note §62).
lean_arm 118 Z2Chain 11 selfDual_pos selfDual_lt_one dualVar_selfDual z2_strong_threshold z2_weak_threshold selfDual_refuses_strong selfDual_refuses_weak clauses_part z2_chain_strong z2_strong_rate_lt_one z2_chain_physical
dk_say "arm 118 (THE Z2 REHEARSAL): Z2Chain.lean -- 11 theorems in the bare kernel: both clauses' thresholds and the self-dual place refusing each, the chain's ramified place exhibited"
# ---- ARM 119 (THE CHAIN AS ONE THEOREM): MassGapChain.lean -- the assembly: UVInterface (Sigma-1's delivery as a definition) and
# CrossoverBudget (Sigma-2 as an object: the base interdependence's row sums alpha_0 and every cutoff's budget e^o alpha_0 + sum(1 - e^-Delta)
# under one alpha < 1) give cov_le's decay for every cutoff with the one rate alpha and range R, hence the physical clustering rate
# log(1/alpha)/(R a_c) at the coarse spacing, the same at every cutoff; form (a), the sites as blocks of side a_c and the whole-block
# criterion on the fine measure, so every fine local observable clusters with no fibre clause.  Nothing here proves either hypothesis:
# the file is what Sigma-1 and Sigma-2 are for (the plan B8; the master plan note §62).
lean_arm 119 MassGapChain 3 chain_cov_le physicalGap_of_budget physicalRate_pos
dk_say "arm 119 (THE CHAIN AS ONE THEOREM): MassGapChain.lean -- 3 theorems in the bare kernel: the interface and the budget give one rate and one physical clustering constant for every cutoff"
# ---- ARM 120 (THE TILT BUDGET CERTIFIED ON THE HIERARCHICAL MODEL): aperanton_tilt_cert.awk -- the crossover criterion's budget
# B_k = e^{6 osc} 18 (4/3pi) beta_k + 18 (1 - e^{-2 osc}) of the hierarchical model's flowed weight, every quantity an interval of
# 256-bit numbers under its own rounding (beta_k by bisection on the Bessel enclosure, the characters by the Chebyshev recurrence in
# intervals, the oscillation over [0, pi] bounded by the grid's plus h times an enclosed derivative bound), on the author the author's
# certified flow records carried here (law 40): the KAT first (the pure Wilson vector at 3/10: osc^lo = 0, B^lo = the Wilson row
# 2.2918311805232928; the bent vector off the line), then the four records at NG = 2000: OPEN at k = K* and CLOSES at k = K* + 1
# at 2.2, 2.3 and 5 (B_8 in [0.2815, 0.2819] at 2.3), at K* + 2 at 10 -- the chain closing ON THE HIERARCHICAL MODEL, not on Z^4
# (the master plan note §63 RESULTS 2-4; the label on every line).
TCERT="$ROOT/STDLIB/scripts/aperanton_tilt_cert.awk"; MUTTC="$B/mut_tiltcert"; mkdir -p "$MUTTC"
cc_tiltcert(){ cp "$1" "$2"; }
run_mut_tiltcert(){ { gawk -M -v MODE=kat -v NG=400 -f "$1"; gawk -M -v NG=2000 -f "$1" "$ROOT/STDLIB/build/aperanton/mkflow_b2.3.2026-10-29e.txt" "$ROOT/STDLIB/build/aperanton/mkflow_b2.2.2026-10-29e.txt" "$ROOT/STDLIB/build/aperanton/mkflow_b5.2026-10-29e.txt" "$ROOT/STDLIB/build/aperanton/mkflow_b10.2026-10-29e.txt"; } 2>&1; }
RUNTC="$B/run.tiltcert.txt"; rm -f "$RUNTC"; run_mut_tiltcert "$TCERT" > "$RUNTC"
havetc(){ grep -qF -- "$1" "$RUNTC" || dk_red "arm 120: MISSING PIN: $1"; }
havetc 'TILT-CERT model=kat src=KAT-WILSON-0.3 k=1 c1=[0.074720322596553702, 0.074720322596553702] beta=[0.3, 0.3] osc=[0, 0.0063729521498821234] B=[2.2918311805232928,'
havetc 'TILT-CERT model=kat src=KAT-BENT-c2x2 k=2 c1=[0.074720322596553702, 0.074720322596553702] beta=[0.3, 0.3] osc=[0.056238173617735771,'
havetc 'TILT-CERT model=hierarchical src=mkflow_b2.3.2026-10-29e.txt k=8 c1=[0.0085998323781526159, 0.0085998323781526159] beta=[0.034401025688212111, 0.034401025688212111]'
havetc 'TILT-CERT model=hierarchical src=mkflow_b5.2026-10-29e.txt k=19 c1=[0.00087018635294910674, 0.00087018635294910674]'
grep -F 'src=mkflow_b2.3.2026-10-29e.txt k=8 ' "$RUNTC" | grep -q ' CLOSES$' || dk_red "arm 120: the 2.3 budget does not close at k = 8"
grep -F 'src=mkflow_b2.3.2026-10-29e.txt k=7 ' "$RUNTC" | grep -q ' OPEN$' || dk_red "arm 120: the 2.3 budget is not open at k = 7"
grep -F 'src=mkflow_b10.2026-10-29e.txt k=38 ' "$RUNTC" | grep -q ' OPEN$' || dk_red "arm 120: the 10 budget is not open at k = 38"
grep -F 'src=mkflow_b10.2026-10-29e.txt k=39 ' "$RUNTC" | grep -q ' CLOSES$' || dk_red "arm 120: the 10 budget does not close at k = 39"
grep -q 'REFUSED: the rounding mode' "$RUNTC" && dk_red "arm 120: the rounding mode is not honoured"
dk_say "arm 120 (THE TILT BUDGET CERTIFIED ON THE HIERARCHICAL MODEL): the Wilson KAT met to every digit and the budget OPEN at K* and CLOSING at K* + 1 (2.2, 2.3, 5) or K* + 2 (10) as intervals at 256 bits -- the chain closing on the hierarchical model with a number"
# ---- ARM 124 (LEMMA 8.6 IN THE KERNEL): VmfBounds.lean -- the von Mises-Fisher constants of the decimation's row: by Neumann's
# product formula and the Vandermonde evaluation, 4 I2^2 - 3 I1 I3, I2^2 - I1 I3 (Turan), 3 I1 I3 - 2 I2^2 and r I1 - 4 I2 are
# power series with coefficients C(2k+4,k)(k+6)/((k+2)(k+1)!(k+3)!), C(2k+4,k)/((k+2)(k+1)!(k+3)!), C(2k+4,k) k/((k+2)(k+1)!(k+3)!)
# and 2k/(k!(k+2)!) -- closed forms and signs decided for every k -- and, given the series' values and the recurrence
# r(I1 - I3) = 4 I2, the axial variance is at most 1/4, the anisotropy in [-m^2/3, 0], the perpendicular variance at most 1/4,
# and the third cumulant at most m/2 (the Riccati identity's algebra): every constant of the proved pass of arm 123.
lean_arm 124 VmfBounds 22 factorial_pos_q choose_pos_q fact1_q fact2_q fact3_q turan_closed lower_closed upper_closed perp_closed turan_pos lower_pos upper_nonneg upper_zero upper_one_pos perp_nonneg perp_zero perp_variance_le axial_variance_le anisotropy_nonpos anisotropy_lower riccati_identity third_cumulant_bound
dk_say "arm 124 (LEMMA 8.6 IN THE KERNEL): VmfBounds.lean -- 22 theorems: Turan's coefficients closed and signed, the four bounds on m from the recurrence, the Riccati algebra, the third cumulant at most m/2"
# ---- ARM 125 (THE ONE-BLOCK CONSTANTS RE-DERIVED): aperanton_fontes_hessian.awk, aperanton_fontes_peierls.awk and
# aperanton_fontes_christoffel.awk against their records of 2026-10-29a (the ledger's §92 -- §92 sexies): Fontes's 72-plaquette
# block Hessian reproduced to six digits (lambda_min 0.689343 x3, trace 144) and shown an asymmetric truncation -- the 120
# plaquettes meeting the block give faces^T faces + 3I with spectrum 3 x15, 7 x6, 9 x8, 11 x3 EXACTLY, no zero mode; his
# ||S|| = 5.96 reproduced; his chessboard bound exceeded by the exact single-plaquette marginal 2.24x at his own (9587, 0.025);
# the non-uniform Christoffel constant 6.2595 read from below under its rigorous ceiling 9; the floors as functions of theta*.
FH="$B/run.fontes_hessian.txt"; FP="$B/run.fontes_peierls.txt"; FC="$B/run.fontes_christoffel.txt"; rm -f "$FH" "$FP" "$FC"
gawk -f STDLIB/scripts/aperanton_fontes_hessian.awk > "$FH" 2>/dev/null
gawk -f STDLIB/scripts/aperanton_fontes_peierls.awk > "$FP" 2>/dev/null
gawk -f STDLIB/scripts/aperanton_fontes_christoffel.awk > "$FC" 2>/dev/null
cc_fontes(){ cp "$1" "$2"; }
run_mut_fontes(){ gawk -f "$1" 2>/dev/null; }
dk_have "$FH" "FONTES SET: plaquettes=72 trace=144"
dk_have "$FH" "  spectrum: 3.000000 x15  7.000000 x6  9.000000 x8  11.000000 x3"
dk_have "$FH" "  (H-3)(H-7)(H-9)(H-11) nonzero entries: 0  (0 = the spectrum is contained in {3,7,9,11} EXACTLY)"
dk_have "$FH" "FACES: 24  tr(S^T S)=288  ||S||^2 = 35.522651  ||S|| = 5.960088  (Fontes: 288; [35.52, 35.53]; 5.96)"
dk_have "$FP" "9587      0.025    0.111969     0.049998       2.239"
dk_have "$FP" "Peierls floor at theta_c=0.7383 with entropy 20e=54.37: beta = 18.96"
dk_have "$FC" "M read from below (60 restarts, 400 ascent steps): 6.2595   [uniform ||S|| = 5.9601; crude upper 9]"
dk_have "$FC" "M = 9.0000: theta_c = 0.5636 rad, Peierls floor (54.4 mu1 < 1) beta = 32.1, KP floor (C0 theta_c^2/(3 beta) < 0.1) beta = 11.3"
dk_say "arm 125 (THE ONE-BLOCK CONSTANTS RE-DERIVED): the 72-plaquette Hessian reproduced and shown a truncation; the 120-plaquette spectrum 3 x15 7 x6 9 x8 11 x3 exact; the marginal 2.24x his chessboard bound at (9587, 0.025); the Christoffel constant read 6.2595 under 9"
# ---- ARM 126 (Σ1b's EASY HALF IN THE KERNEL): CouplingSequence.lean -- Bałaban's Theorem 2 (CMP 109 p. 259, its proof never
# published) from its one-step bound: if every renormalisation step lowers x = 1/g^2 by between c1 > 0 and c2 whenever the
# history lies in the window x >= 1/gamma^2 (the shift a continuous function of the whole history, as p. 298 says), then for
# every target 1/g^2 and every number of steps K a bare coupling gives x_K = 1/g^2 with the profile (0.31) at every step --
# the whole sequence in the window -- and the bare coupling vanishes as the cutoff goes; with no running the flow is constant
# (the U(1) line: the chain parts the groups exactly here).  The hard half -- the one-step bound itself -- is Lemmas B and C.
lean_arm 126 CouplingSequence 19 val_zero val_succ seq_frozen seq_filler seq_continuous val_continuous trunc_continuous trunc_bounds trunc_eq val_step val_bounds val_gap val_antitone seq_eq_trunc theorem_two in_window bare_coupling_le bare_coupling_tendsto no_running
dk_say "arm 126 (Σ1b's EASY HALF): CouplingSequence.lean -- 19 theorems in the bare kernel: the one-step bound gives Theorem 2, the profile (0.31) at every step and asymptotic freedom"
# ---- ARM 116 (THE COMPACT TIER): DobrushinMeasure.lean -- Dobrushin's comparison theorem over a probability measure on the spin
# space: the strong-coupling gap's kernel form for SU(2) itself needs the group's Haar measure where Dobrushin.lean has a finite sum;
# the total variation of densities with its positive-part form and the oscillation inequality (the supremum shift), the one-site
# conditionals as densities, detailed balance by the marginal integrals (lmarginal_erase: the coordinate s peeled, the one-site
# marginals equal pointwise), Lemmas A and C, the sweep, the comparison theorem with levels, the tilt and cov_le -- the site-side
# machinery reused from the finite file unchanged. The one-link coefficient for SU(2) enters next (the Lipschitz lemma, §57
# RESULTS 5-6): with it, Osterwalder-Seiler 1978 in the kernel with the first-order coefficient certified.
lean_arm 116 DobrushinMeasure 61 tv_le_of_pointwise tv_eq_integral_pos abs_integral_sub_mul_le gibbs_condExp oscBound_condExp abs_gibbs_condExp_sub_le comparison_level discrep_tilt cov_le FactorWeight.interdep rowsum_factorC_le cov_le_factor
dk_say "arm 116 (THE COMPACT TIER): DobrushinMeasure.lean -- 61 theorems in the bare kernel: Dobrushin's comparison theorem and the covariance bound over a probability measure on the spins, the finite proofs with integrals for sums"
# ---- ARM 127 (Σ1b's WINDOW FROM A BOUNDED TRANSIENT): CouplingTransient.lean -- what Bałaban's Theorem 1 consumes is the
# window 0 < g_k <= gamma, and it follows from asymptotic freedom (c = 8 b0 ln L > 0), a small remainder (rho <= c, Lemma C) and a
# BOUNDED one-loop transient a(i) = c + f(i) - f(i - 1), |f| <= F, with no sign on any single step: for every target X >= X_min + 2F
# a bare x0 gives x_K = X and X + (K - j)(c - rho) - 2F <= x_j <= X + (K - j)(c + rho) + 2F -- (0.31) with the target shifted by 2F.
# By the composition of hard delta functions f(k) = beta(Q_L^k) - c k, so Lemma B is the iterated scheme's finite Lambda-ratio.
lean_arm 127 CouplingTransient 9 trunc_split val_window window_sum transient_of_composite window_sum_bounds window_of_bounded_transient cross_scale_transient in_window_transient negative_step_example
dk_say "arm 127 (Σ1b's WINDOW FROM A BOUNDED TRANSIENT): CouplingTransient.lean -- 9 theorems: the window and the shifted profile from bounded partial sums of the one-loop transient, a negative first step the sighted case"
# ---- ARM 128 (THE NON-UNIFORM CHRISTOFFEL CONSTANT, §98): ChristoffelBound.lean -- per face |B(y)| <= ((1 + sqrt 2)/2) sum |y_i|^2
# for B(y) = sum_{i<j} y_i x y_j, by B = (1/2) sum_i y_i x w_i (w = T y, T the 4 x 4 sign matrix), Lagrange, the arithmetic-
# geometric mean at t = 1 + sqrt 2 and the sum of squares (3 + 2s)|x|^2 - |Tx|^2 = 2(s - 1)(a^2 + b^2) + 2(a + b)^2; attained at
# y_j = (cos(j pi/4), sin(j pi/4), 0); with three faces per link the block bound sum_p |w_p| <= 3(1 + sqrt 2)|x|^2.
lean_arm 128 ChristoffelBound 12 sq3_eq sq3_nonneg sign_quad lagrange_le triple amgm_dot two_B sign_vec face_dot_le face_bound face_sharp block_bound
dk_say "arm 128 (THE CHRISTOFFEL CONSTANT IN THE KERNEL): ChristoffelBound.lean -- 12 theorems: the face bound (1 + sqrt 2)/2 by a sum of squares, its attainment, the block bound 3(1 + sqrt 2) = 7.2426 from three faces per link"
# ---- ARM 129 (THE ONE-LOOP INSTRUMENTS' CONTROLS, §100): the constrained one-step instrument's three readings at N = 4, L = 2
# -- the default log det_{ker Q} M (1.289232), the hard scheme with the delta function's Jacobian log det(Q~Q~^dag) (0.539914, the
# one Balaban's Z^(j) = int dB delta(Q~B) exp(...) carries, CMP 109 (1.4)), the soft scheme at a = 1 (0.931744) -- and the
# composite instrument's controls: the identity step in either slot reproduces the one-step reading to every digit, and the
# composite (2,2) is exactly covariant (max |Q~(D lambda)| below 1e-12 over lambda zero at the coarsest corners, both eps), the test
# that found the stage-1 rows' dropped phase e^{-i Thbar}.  So the second step's coefficient beta_2 = beta(Q2 o Q2) - beta(Q2) is
# read with no vertex of the once-blocked action (the hard delta functions compose).
OL1="$B/run.oneloop_step.txt"; OL2="$B/run.oneloop_step2.txt"; OL3="$B/run.oneloop_cov.txt"; rm -f "$OL1" "$OL2" "$OL3"
cc_ol(){ cp "$1" "$2"; }
run_ol1(){ gawk -v N=4 -v L=2 -f "$1" 2>&1 | grep -E '^ONELOOP-STEP'; }
run_ol2(){ { gawk -v N=4 -v L1=2 -v L2=1 -f "$1"; gawk -v N=4 -v L1=1 -v L2=2 -f "$1"; } 2>&1 | grep -E '^ONELOOP-STEP2 N='; }
run_ol3(){ gawk -v N=4 -v L1=2 -v L2=2 -v TESTCOV=1 -f "$1" 2>&1 | gawk '/^COVARIANCE2/ { for (i = 1; i <= NF; i++) if ($i == "=") { v = $(i + 1) + 0; if (v > m) m = v }; n++ } END { if (n == 2 && m < 1e-12) print "COMPOSITE-COVARIANT N=4 L1=2 L2=2 max|Q D lambda| below 1e-12 over both eps"; else printf "COMPOSITE-NOT-COVARIANT lines %d max %.3e\n", n, m }'; }
run_ol1 STDLIB/scripts/aperanton_oneloop_step.awk > "$OL1"
run_ol2 STDLIB/scripts/aperanton_oneloop_step2.awk > "$OL2"
run_ol3 STDLIB/scripts/aperanton_oneloop_step2.awk > "$OL3"
dk_have "$OL1" "ONELOOP-STEP N=4 L=2 pL=3.1416 Delta_step=-1.289232 beta1_estimate=1.289232"
dk_have "$OL1" "ONELOOP-STEP-HARD N=4 L=2 pL=3.1416 beta1_hard=0.539914 (with the constraint's Jacobian)"
dk_have "$OL1" "ONELOOP-STEP-SOFT N=4 L=2 pL=3.1416 a=1 beta1_soft=0.931744"
dk_have "$OL2" "ONELOOP-STEP2 N=4 L1=2 L2=1 pLL=3.1416 beta_default=1.289232 beta_hard=0.539914"
dk_have "$OL2" "ONELOOP-STEP2 N=4 L1=1 L2=2 pLL=3.1416 beta_default=1.289232 beta_hard=0.539914"
dk_have "$OL3" "COMPOSITE-COVARIANT N=4 L1=2 L2=2 max|Q D lambda| below 1e-12 over both eps"
dk_say "arm 129 (THE ONE-LOOP INSTRUMENTS' CONTROLS): the hard scheme's Jacobian 0.749318 read beside the default and the soft scheme; the composite instrument's identity controls exact in both slots and its covariance below 1e-12"
# ---- ARM 22: THE SPECTRAL LAW ON THE RECORD -- Z2Moment.lean re-emits byte for byte from HEAD's dump, the symmetrizer
# derived from M and consistent on every pair, the law decided by the kernel and the planted control refused by it
MOMEMIT="$ROOT/STDLIB/scripts/aperanton_emit_mom.sh"
MOMART="$ROOT/LEAN/aperanton/Aperanton/Z2Moment.lean"
RUNMOM="$B/run_mom.txt"; RUNMOMCMP="$B/run_momcmp.txt"
[ -f "$MOMEMIT" ] && [ -f "$MOMART" ] || dk_red "arm 22: missing $MOMEMIT or $MOMART"
[ -f "$B/dump.head.run" ] || dk_red "arm 22: arm 18 left no HEAD dump"
rm -f "$B/Z2Moment.reemit.lean" "$B/reemit_mom.log"
APERANTON_ROOT="$ROOT" bash "$MOMEMIT" "$B/Z2Moment.reemit.lean" "$B/dump.head.run" > "$B/reemit_mom.log" 2>&1 || dk_red "arm 22: the moment emitter refused HEAD's dump ($(tail -1 "$B/reemit_mom.log"))"
cmp -s "$B/Z2Moment.reemit.lean" "$MOMART" || dk_red "arm 22: Z2Moment.lean does not regenerate byte-identically from HEAD's dump (the emitter or the dump moved)"
for c in half quarter; do
  grep -qF "$c: symmetrizer consistent on 1024 pairs; LAW violations 0 of 3 sequences (a = 0..2, R = 0..6); CONTROL K5 bites at R = 0" "$B/reemit_mom.log" || dk_red "arm 22: the emitter's own reading at $c is not (symmetrizer consistent on 1024 pairs, law 0 of 3 violated, control K5 biting at R = 0)"
done
strip_lean "$MOMART" > "$B/code_mom.txt"
for tok in import axiom sorry native_decide; do grep -qE "(^|[^a-zA-Z_.])$tok([^a-zA-Z_]|$)" "$B/code_mom.txt" && dk_red "arm 22: a forbidden token stands in Z2Moment.lean's code: $tok"; done
nmom=$(grep -c '^theorem ' "$B/code_mom.txt"); [ "$nmom" -eq 14 ] || dk_red "arm 22: $nmom theorems in Z2Moment.lean, not 14"
[ "$(grep -c ':= by decide +kernel$' "$B/code_mom.txt")" -eq 14 ] || dk_red "arm 22: not every theorem of Z2Moment.lean is closed by decide +kernel"
[ "$(grep -c '^instance ' "$B/code_mom.txt")" -eq 1 ] && [ "$(grep -c ':= by ' "$B/code_mom.txt")" -eq 15 ] || dk_red "arm 22: Z2Moment.lean's proof terms are not the 14 decides and the one decidability instance"
for th in N0_half_values logconvex0_half N1_half_values logconvex1_half N2_half_values logconvex2_half control_half N0_quarter_values logconvex0_quarter N1_quarter_values logconvex1_quarter N2_quarter_values logconvex2_quarter control_quarter; do grep -q "^theorem $th " "$B/code_mom.txt" || dk_red "arm 22: Z2Moment.lean lost $th"; done
grep -q '^theorem control_half : ¬ lc NC_half 0 := by decide +kernel$' "$B/code_mom.txt" && grep -q '^theorem control_quarter : ¬ lc NC_quarter 0 := by decide +kernel$' "$B/code_mom.txt" || dk_red "arm 22: the planted controls are not the kernel-decided negations at R = 0"
for ph in 'Z2Moment.lean' 'aperanton_emit_mom.sh' 'GapBound.lean' 'Α8c'; do grep -qF -- "$ph" "$PRE" || dk_red "arm 22: the page does not name $ph"; done
rm -f "$RUNMOM" "$RUNMOMCMP"
kernel "$MOMART" Z2Moment > "$RUNMOM"
grep -qF 'KERNEL-ACCEPTED Z2Moment theorems=14 errors=0' "$RUNMOM" || dk_red "arm 22: $(cat "$RUNMOM")"
run_mut_momcmp "$B/Z2Moment.reemit.lean" > "$RUNMOMCMP"
grep -qF 'MOMENT-CUSTODY byte-identical' "$RUNMOMCMP" || dk_red "arm 22: $(cat "$RUNMOMCMP")"
dk_say "arm 22 (THE SPECTRAL LAW ON THE RECORD, OD:2): $(cat "$RUNMOM") -- Z2Moment.lean re-emitted byte for byte from HEAD's $DUMP; the symmetrizer Lambda of M derived from M alone and consistent on all 1024 pairs at both couplings; N_a(R) = 1^T M^a S M^R S M^a Lambda^-1 1 nonnegative and log-convex at a = 0, 1, 2, R = 0..4, the N values pinned, the planted control (mismatched ends) refused by the kernel at R = 0 -- Spectral.lean's moment sequence on ΣΤΡΟΦΙΓΞ's integers"

# ---- DOKIMASIA: five teeth on the EMITTER, each an artifact the KERNEL must refuse; the pin is the kernel's acceptance
export DK_BASE_RUN="$RUN"
PIN='KERNEL-ACCEPTED FluxCore theorems=15 errors=0'
dk_tooth "$EMIT" "$MUT" basisbend 'for (t = 1; t <= k; t++) { for (j = deg + 1; j >= 1; j--) c\[j\] = ((j in c) ? c\[j\] : 0) - c\[j - 1\]; deg++ }' 'for (t = 1; t <= k; t++) { for (j = deg + 1; j >= 1; j--) c[j] = ((j in c) ? c[j] : 0) + c[j - 1]; deg++ }' 4 "$PIN" cc run_mut
dk_tooth "$EMIT" "$MUT" jbend 'J\[h, kv\[1\] + 0\] = kv\[2\] + 0' 'J[h, kv[1] + 0] = kv[2] + 2' 4 "$PIN" cc run_mut
dk_tooth "$EMIT" "$MUT" pairbend 'def dot (h w : Nat) : Nat := (bit h 0 \* bit w 0 + bit h 1 \* bit w 1 + bit h 2 \* bit w 2) % 2' 'def dot (h w : Nat) : Nat := (bit h 0 * bit w 0 + bit h 1 * bit w 1 + bit h 2 * bit w 1) % 2' 4 "$PIN" cc run_mut
dk_tooth "$EMIT" "$MUT" signbend 'def sign (h w : Nat) : Int := if dot h w == 1 then -1 else 1' 'def sign (h w : Nat) : Int := if dot h w == 1 then 1 else -1' 4 "$PIN" cc run_mut
dk_tooth "$EMIT" "$MUT" floorbend '\[0, 2, 2, 4, 2, 4, 4, 6\] := by decide' '[0, 2, 2, 4, 2, 4, 4, 5] := by decide' 4 "$PIN" cc run_mut
dk_control "$EMIT" "$MUT" '^  APERANTON -- THE BOUNDLESS, stage A0: THE FINITE CORE' '  APERANTON -- THE BOUNDLESS, stage A0 (comment control): THE FINITE CORE' "$RUN" cc run_mut

# ---- DOKIMASIA, THE INVERSION EMITTER: two teeth -- signdrop (V = R without the parity character: the emitter's OWN check
# refuses, M V N != mu2 V under either orientation of R) and mu2bend (the emitted literal mu2 tenfold: the KERNEL refuses
# mu2_eq_* and inversion_*) -- then the count pinned against the literal 7 and a comment control on the emitted header
MUTINV="$B/mut_inv"; mkdir -p "$MUTINV"
export DK_BASE_RUN="$RUNINV"
PININV='KERNEL-ACCEPTED Z2Inversion theorems=6 errors=0'
dk_tooth "$INVEMIT" "$MUTINV" signdrop 'V\[i, j\] = chi\[c, i\] \* R\[c, i, j\]' 'V[i, j] = R[c, i, j]' 18 "$PININV" cc_inv run_mut_inv
dk_tooth "$INVEMIT" "$MUTINV" mu2bend 'def mu2_%s : Int := %s' 'def mu2_%s : Int := %s0' 18 "$PININV" cc_inv run_mut_inv
dk_control "$INVEMIT" "$MUTINV" '^  print "  APERANTON -- THE BOUNDLESS, stage A6: THE INVERSION THEOREM OF THE CENTRE' '  print "  APERANTON -- THE BOUNDLESS, stage A6 (comment control): THE INVERSION THEOREM OF THE CENTRE' "$RUNINV" cc_inv run_mut_inv

# ---- DOKIMASIA, THE MOMENT EMITTER: nonnegbend (the law's nonnegativity reversed: the KERNEL refuses), controlbend (the
# planted control asserted instead of refuted: the KERNEL refuses), ybend (the end vector Lambda 1 in place of
# Lambda^-1 1: the CUSTODY runner reads a moved re-emission), the count pinned against the literal 10, a comment control
MUTMOM="$B/mut_mom"; mkdir -p "$MUTMOM"
export DK_BASE_RUN="$RUNMOM"
PINMOM='KERNEL-ACCEPTED Z2Moment theorems=14 errors=0'
dk_tooth "$MOMEMIT" "$MUTMOM" nonnegbend '0 ≤ N R ∧ N (R + 1) \* N (R + 1) ≤ N R \* N (R + 2)' 'N R ≤ 0 ∧ N (R + 1) * N (R + 1) ≤ N R * N (R + 2)' 22 "$PINMOM" cc_mom run_mut_mom
dk_tooth "$MOMEMIT" "$MUTMOM" controlbend 'theorem control_%s : ¬ lc NC_%s %d' 'theorem control_%s : lc NC_%s %d' 22 "$PINMOM" cc_mom run_mut_mom
export DK_BASE_RUN="$RUNMOMCMP"
dk_tooth "$MOMEMIT" "$MUTMOM" ybend 'Y\[c, o\] = M\[c, o, 0\] \* (L / M\[c, 0, o\])' 'Y[c, o] = M[c, 0, o] * (L / M[c, o, 0])' 22 'MOMENT-CUSTODY byte-identical' cc_mom run_mut_momcmp
# ---- DOKIMASIA, THE SEPARATION FILE: sepbend (the Lagrange factor's subtrahend bent to 0 -- the separating entry no longer
# separates, the KERNEL refuses the step and the pin leaves the run) and pairbend (the class matrix's diagonal bent to twice
# the dimension -- the KERNEL refuses classMat_diag), both in arm 28; then a comment control on the file's header essay
MUTSEP="$B/mut_sep"; mkdir -p "$MUTSEP"
export DK_BASE_RUN="$RUNSEP"
PINSEP='KERNEL-ACCEPTED Separation theorems=20 errors=0'
dk_tooth "$SEPSRC" "$MUTSEP" sepbend '(R\.ρ a p\.1 p\.2 - R\.ρ b₀ p\.1 p\.2), ?_, ?_, ?_⟩' '(R.ρ a p.1 p.2 - 0), ?_, ?_, ?_⟩' 28 "$PINSEP" cc_sep run_mut_sep
dk_tooth "$SEPSRC" "$MUTSEP" pairbend 'theorem classMat_diag (σ : OrthRep G e) (g : G) : classMat σ g g = e := by' 'theorem classMat_diag (σ : OrthRep G e) (g : G) : classMat σ g g = 2 * e := by' 28 "$PINSEP" cc_sep run_mut_sep
dk_control "$SEPSRC" "$MUTSEP" '^  APERANTON -- THE BOUNDLESS, stage Β1 (ADDENDUM I, THE ROAD): THE SEPARATION THEOREM' '  APERANTON -- THE BOUNDLESS, stage Β1 (ADDENDUM I, THE ROAD; comment control): THE SEPARATION THEOREM' "$RUNSEP" cc_sep run_mut_sep
# ---- DOKIMASIA, THE Β3 FILES AND THE ROAD'S DRAFTS: every tooth bends a STATEMENT (never a checker, law 24) at one
# site (law 56: each pattern a literal found exactly once), the KERNEL refuses the file and the pin leaves the run; the
# custody tooth bends the torus emitter's pivot search and the re-emission moves; then one comment control on the
# newest essay (Z2Slab's)
LEANDIR="$ROOT/LEAN/aperanton/Aperanton"
MUTB3="$B/mut_b3"; mkdir -p "$MUTB3"
export MUT_STEM=Dobrushin DK_BASE_RUN="$B/run.Dobrushin.txt"
dk_tooth "$LEANDIR/Dobrushin.lean" "$MUTB3" tvbend "    (r : ℝ) (hr : 1 ≤ r) (hpp : ∀ g, p g ≤ r \* p' g) : tv p p' ≤ 1 - 1 / r := by" "    (r : ℝ) (hr : 1 ≤ r) (hpp : ∀ g, p g ≤ r * p' g) : tv p p' ≤ 1 - 2 / r := by" 29 "KERNEL-ACCEPTED Dobrushin theorems=52 errors=0" cc_lean run_mut_lean
export MUT_STEM=Factors DK_BASE_RUN="$B/run.Factors.txt"
dk_tooth "$LEANDIR/Factors.lean" "$MUTB3" rhobend 'theorem one_le_rho (s t : S) : 1 ≤ rho F s t :=' 'theorem one_le_rho (s t : S) : 2 ≤ rho F s t :=' 30 "KERNEL-ACCEPTED Factors theorems=17 errors=0" cc_lean run_mut_lean
export MUT_STEM=Slab DK_BASE_RUN="$B/run.Slab.txt"
dk_tooth "$LEANDIR/Slab.lean" "$MUTB3" alphabend 'theorem transfer_gap_uniform (α : ℝ) (hα0 : 0 ≤ α) (hα1 : α < 1)' 'theorem transfer_gap_uniform (α : ℝ) (hα0 : 0 ≤ α) (hα1 : α < 2)' 32 "KERNEL-ACCEPTED Slab theorems=18 errors=0" cc_lean run_mut_lean
export MUT_STEM=Rowsum DK_BASE_RUN="$B/run.Rowsum.txt"
dk_tooth "$LEANDIR/Rowsum.lean" "$MUTB3" coefbend '    (3 \* m + 2) \* (1 - y ^ 2) < 1 ↔ (3 \* m + 1 : ℝ) / (3 \* m + 2) < y ^ 2 := by' '    (3 * m + 2) * (1 - y ^ 2) < 1 ↔ (3 * m : ℝ) / (3 * m + 2) < y ^ 2 := by' 33 "KERNEL-ACCEPTED Rowsum theorems=9 errors=0" cc_lean run_mut_lean
export MUT_STEM=Z2Slab DK_BASE_RUN="$B/run.Z2Slab.txt"
dk_tooth "$LEANDIR/Z2Slab.lean" "$MUTB3" z2stepbend '    |1 / (1 + v) - 1 / (1 + v \* y ^ 2)| ≤ (1 - y) / (1 + y) := by' '    |1 / (1 + v) - 1 / (1 + v * y ^ 2)| ≤ (1 - y) / (2 * (1 + y)) := by' 34 "KERNEL-ACCEPTED Z2Slab theorems=33 errors=0" cc_lean run_mut_lean
dk_tooth "$LEANDIR/Z2Slab.lean" "$MUTB3" sharpbend '    (hα : (3 \* m + 2) \* ((1 - y) / (1 + y)) < 1) (j : Lk → Z2)' '    (hα : (3 * m + 1) * ((1 - y) / (1 + y)) < 1) (j : Lk → Z2)' 34 "KERNEL-ACCEPTED Z2Slab theorems=33 errors=0" cc_lean run_mut_lean
export MUT_STEM=Duality DK_BASE_RUN="$B/run.Duality.txt"
dk_tooth "$LEANDIR/Duality.lean" "$MUTB3" fixbend 'theorem dualVar_fixed : dualVar (Real.sqrt 2 - 1) = Real.sqrt 2 - 1 := by' 'theorem dualVar_fixed : dualVar (Real.sqrt 2 - 1) = Real.sqrt 2 + 1 := by' 38 "KERNEL-ACCEPTED Duality theorems=20 errors=0" cc_lean run_mut_lean
export MUT_STEM=YM2 DK_BASE_RUN="$B/run.YM2.txt"
dk_tooth "$LEANDIR/YM2.lean" "$MUTB3" heatbend '    conv (C.heat x t) (C.heat x s) g = (Fintype.card G : S) \* C.heat x (t + s) g := by' '    conv (C.heat x t) (C.heat x s) g = C.heat x (t + s) g := by' 39 "KERNEL-ACCEPTED YM2 theorems=12 errors=0" cc_lean run_mut_lean
export MUT_STEM=YM2Q8 DK_BASE_RUN="$B/run.YM2Q8.txt"
dk_tooth "$LEANDIR/YM2Q8.lean" "$MUTB3" q8bend 'theorem torus_zero (x : Fin 5 → ℤ) : data.Zraw x 0 1 = 320 := by' 'theorem torus_zero (x : Fin 5 → ℤ) : data.Zraw x 0 1 = 321 := by' 40 "KERNEL-ACCEPTED YM2Q8 theorems=8 errors=0" cc_lean run_mut_lean
export MUT_STEM=Torus4 DK_BASE_RUN="$B/run.Torus4.txt"
dk_tooth "$LEANDIR/Torus4.lean" "$MUTB3" rankbend 'theorem rank_cobd : rankMasks cobdMasks = 45 := by decide +kernel' 'theorem rank_cobd : rankMasks cobdMasks = 44 := by decide +kernel' 41 "KERNEL-ACCEPTED Torus4 theorems=9 errors=0" cc_lean run_mut_lean
export MUT_STEM=Bridge DK_BASE_RUN="$B/run.Bridge.txt"
dk_tooth "$LEANDIR/Bridge.lean" "$MUTB3" mixbend '    ∑ h, p h \* (|F h - ∑ k, p k \* F k| \* |G h - ∑ k, p k \* G k|) ≤ 8 \* M ^ 2 \* ε := by' '    ∑ h, p h * (|F h - ∑ k, p k * F k| * |G h - ∑ k, p k * G k|) ≤ 4 * M ^ 2 * ε := by' 42 "KERNEL-ACCEPTED Bridge theorems=12 errors=0" cc_lean run_mut_lean
export MUT_STEM=Echelon DK_BASE_RUN="$B/run.Echelon.txt"
dk_tooth "$LEANDIR/Echelon.lean" "$MUTB3" pivbend '    vecSel N basis m ⟨piv.getD i.val 0, hp⟩ = if Nat.testBit m i.val then 1 else 0 := by' '    vecSel N basis m ⟨piv.getD i.val 0, hp⟩ = if Nat.testBit m i.val then 0 else 1 := by' 43 "KERNEL-ACCEPTED Echelon theorems=16 errors=0" cc_lean run_mut_lean
export DK_BASE_RUN="$RUNT4CMP"
dk_tooth "$T4EMIT" "$MUTB3" lowbitbend 'function lowbit(v) { return v - and(v, v - 1) }' 'function lowbit(v) { return v - and(v, v - 2) }' 44 'TORUS4-CUSTODY byte-identical' cc_t4 run_mut_t4cmp
export MUT_STEM=Torus4Bridge DK_BASE_RUN="$B/run.Torus4Bridge.txt"
dk_tooth "$LEANDIR/Torus4Bridge.lean" "$MUTB3" cardbend 'theorem card_H : H.card = 64 := by' 'theorem card_H : H.card = 65 := by' 45 "KERNEL-ACCEPTED Torus4Bridge theorems=29 errors=0" cc_lean run_mut_lean
export MUT_STEM=Z2Slab DK_BASE_RUN="$B/run.Z2Slab.txt"
dk_control "$LEANDIR/Z2Slab.lean" "$MUTB3" "^  APERANTON -- THE BOUNDLESS, stage Β3's sharp coefficient (ADDENDUM I, THE ROAD, W2): THE PER-SITE INTERDEPE" "  APERANTON -- THE BOUNDLESS, stage Β3's sharp coefficient (ADDENDUM I, THE ROAD, W2; comment control): THE PER-SITE INTERDEPE" "$B/run.Z2Slab.txt" cc_lean run_mut_lean
export MUT_STEM=DualTorus DK_BASE_RUN="$B/run.DualTorus.txt"
dk_tooth "$LEANDIR/DualTorus.lean" "$MUTB3" dualpairbend 'def dualPair (q : Nat) : Nat := 5 - q' 'def dualPair (q : Nat) : Nat := 4 - q' 46 "KERNEL-ACCEPTED DualTorus theorems=8 errors=0" cc_lean run_mut_lean
export MUT_STEM=Weak DK_BASE_RUN="$B/run.Weak.txt"
dk_tooth "$LEANDIR/Weak.lean" "$MUTB3" couplingbend '    vacExp K y s = ∑ h ∈ H, sectorMass D H (dualVar y) h \* sectorExp D (dualVar y) h s := by' '    vacExp K y s = ∑ h ∈ H, sectorMass D H y h * sectorExp D (dualVar y) h s := by' 47 "KERNEL-ACCEPTED Weak theorems=14 errors=0" cc_lean run_mut_lean
export MUT_STEM=Fibre DK_BASE_RUN="$B/run.Fibre.txt"
dk_tooth "$LEANDIR/Fibre.lean" "$MUTB3" fibrebend '(Fintype.card (LinearMap.ker δ) : ℝ)' '(Fintype.card (LinearMap.range δ) : ℝ)' 48 "KERNEL-ACCEPTED Fibre theorems=3 errors=0" cc_lean run_mut_lean
export DK_BASE_RUN="$RUNBLK"
dk_tooth "$BLOCKSRC" "$MUTBLK" katbend 'kn = 7 \* (Q \* Q - P \* P)' 'kn = 6 * (Q * Q - P * P)' 49 'KAT link: 7(1 - y^2)/(1 + y^2) = 196 / 197 ; KAT-MET' cc_block run_mut_block_link
dk_tooth "$BLOCKSRC" "$MUTBLK" treebend 'cost += cc;' 'cost += 0;' 49 '(1/|B|) sum r = 95126555987571152906932 / 118510201451401127037951 = 0.802686644884 verdict=DS-W1-BELOW-ONE' cc_block run_mut_block
dk_control "$BLOCKSRC" "$MUTBLK" '^# aperanton_block.awk -- THE BLOCK CRITERION on the Z2 gauge theory' '# aperanton_block.awk -- THE BLOCK CRITERION (comment control) on the Z2 gauge theory' "$RUNBLK" cc_block run_mut_block
export MUT_STEM=Block DK_BASE_RUN="$B/run.Block.txt"
dk_tooth "$LEANDIR/Block.lean" "$MUTB3" blockbend "    |gibbs W' f - gibbs W f| ≤ (∑ t, bB (blk t)) \\* (∑ t, d t) \\* α \\^ R / (1 - α) := by" "    |gibbs W' f - gibbs W f| ≤ (∑ t, bB (blk t)) * (∑ t, d t) * α ^ (R + 1) / (1 - α) := by" 50 "KERNEL-ACCEPTED Block theorems=38 errors=0" cc_lean run_mut_lean
export DK_BASE_RUN="$RUNPRB"
dk_tooth "$PROBESRC" "$MUTPRB" flowbend '          if (fl\[v, u\] > 0) c = -hamm(v, u); else c = hamm(u, v)' '          if (fl[v, u] > 0) c = -hamm(v, u); else c = hamm(u, v) + 1' 51 'PROBE-DSW1 square CONSTR=0 FIBMETRIC=0 y=13/15 flows=5760 sum r = 285798543159808172441416 / 86729621146901839568715 = 3.295281812378 ; (1/|B|) sum r = 71449635789952043110354 / 86729621146901839568715 = 0.823820453094 verdict=BELOW-ONE' cc_probe run_mut_probe
dk_control "$PROBESRC" "$MUTPRB" '^# aperanton_probe.awk -- THE CONSTRAINED CRITERION' '# aperanton_probe.awk -- THE CONSTRAINED CRITERION (comment control)' "$RUNPRB" cc_probe run_mut_probe
export DK_BASE_RUN="$RUNDCM"
dk_tooth "$BLOCKSRC" "$MUTBLK" frozenbend 'return (pos % 2 == 0)' 'return 0' 54 'ROWSUM link y=13/15 bend=none decim=1 alpha = 140 / 197 = 0.710659898477 verdict=ALPHA-BELOW-ONE' cc_block run_mut_decim
export MUT_STEM=ZedEven DK_BASE_RUN="$B/run.ZedEven.txt"
dk_tooth "$LEANDIR/ZedEven.lean" "$MUTB3" zedbend '    |1 / (1 + v) - 1 / (1 + v \* y ^ 2)| ≤ (1 - y ^ 2) / (2 \* (1 + y ^ 2)) := by' '    |1 / (1 + v) - 1 / (1 + v * y ^ 2)| ≤ (1 - y ^ 2) / (4 * (1 + y ^ 2)) := by' 52 "KERNEL-ACCEPTED ZedEven theorems=5 errors=0" cc_lean run_mut_lean
export MUT_STEM=TorusSys DK_BASE_RUN="$B/run.TorusSys.txt"
dk_tooth "$LEANDIR/TorusSys.lean" "$MUTB3" torusbend '    ∑ t, (torusSys h y hy0 hy1).C s t ≤ 18 \* ((1 - y) / (1 + y)) := by' '    ∑ t, (torusSys h y hy0 hy1).C s t ≤ 17 * ((1 - y) / (1 + y)) := by' 53 "KERNEL-ACCEPTED TorusSys theorems=12 errors=0" cc_lean run_mut_lean
export MUT_STEM=TorusL DK_BASE_RUN="$B/run.TorusL.txt"
dk_tooth "$LEANDIR/TorusL.lean" "$MUTB3" lbend 'theorem dot_vecOf (L a b : ℕ) : vecOf L a ⬝ᵥ vecOf L b = if parAnd L a b then 1 else 0 := by' 'theorem dot_vecOf (L a b : ℕ) : vecOf L a ⬝ᵥ vecOf L b = if parAnd L a b then 0 else 1 := by' 55 "KERNEL-ACCEPTED TorusL theorems=6 errors=0" cc_lean run_mut_lean
export MUT_STEM=TorusLBridge DK_BASE_RUN="$B/run.TorusLBridge.txt"
dk_tooth "$LEANDIR/TorusLBridge.lean" "$MUTB3" bridgebend '(hsum : rK + rD + 6 = nPlaq L) :' '(hsum : rK + rD + 7 = nPlaq L) :' 56 "KERNEL-ACCEPTED TorusLBridge theorems=22 errors=0" cc_lean run_mut_lean
export MUT_STEM=TorusSysL DK_BASE_RUN="$B/run.TorusSysL.txt"
dk_tooth "$LEANDIR/TorusSysL.lean" "$MUTB3" sysLbend '    ∑ t, (torusSys L h y hy0 hy1).C s t ≤ 18 \* ((1 - y) / (1 + y)) := by' '    ∑ t, (torusSys L h y hy0 hy1).C s t ≤ 17 * ((1 - y) / (1 + y)) := by' 57 "KERNEL-ACCEPTED TorusSysL theorems=11 errors=0" cc_lean run_mut_lean
export MUT_STEM=TorusLevels DK_BASE_RUN="$B/run.TorusLevels.txt"
dk_tooth "$LEANDIR/TorusLevels.lean" "$MUTB3" levelbend '    cubeMult L i k ≠ 0 ↔ i.val ∈ cubeFaces L (k.val / V L) (k.val % V L) := by' '    cubeMult L i k ≠ 0 ↔ i.val ∉ cubeFaces L (k.val / V L) (k.val % V L) := by' 58 "KERNEL-ACCEPTED TorusLevels theorems=4 errors=0" cc_lean run_mut_lean
export MUT_STEM=TorusDecay DK_BASE_RUN="$B/run.TorusDecay.txt"
dk_tooth "$LEANDIR/TorusDecay.lean" "$MUTB3" decaybend 'theorem alpha_lt_one_iff (y : ℝ) (hy0 : 0 < y) : alpha y < 1 ↔ (17 : ℝ) / 19 < y := by' 'theorem alpha_lt_one_iff (y : ℝ) (hy0 : 0 < y) : alpha y < 1 ↔ (16 : ℝ) / 19 < y := by' 59 "KERNEL-ACCEPTED TorusDecay theorems=3 errors=0" cc_lean run_mut_lean
export MUT_STEM=TorusTwoPoint DK_BASE_RUN="$B/run.TorusTwoPoint.txt"
dk_tooth "$LEANDIR/TorusTwoPoint.lean" "$MUTB3" twopointbend '    (ω : Fin (nCubes L) → Z2) : ratioAt L h s y hy0 hy1 i ω ≤ if s i = 0 then 1 else 1 / y := by' '    (ω : Fin (nCubes L) → Z2) : ratioAt L h s y hy0 hy1 i ω ≤ if s i = 0 then 1 else y := by' 60 "KERNEL-ACCEPTED TorusTwoPoint theorems=15 errors=0" cc_lean run_mut_lean
export MUT_STEM=TorusT3 DK_BASE_RUN="$B/run.TorusT3.txt"
dk_tooth "$LEANDIR/TorusT3.lean" "$MUTB3" t3bend 'theorem enumAt_add_mem (D : Submodule (ZMod 2) (ι → ZMod 2)) (h d : ι → ZMod 2) (hd : d ∈ D) (y : ℝ) :' 'theorem enumAt_add_mem (D : Submodule (ZMod 2) (ι → ZMod 2)) (h d : ι → ZMod 2) (hd : d ∉ D) (y : ℝ) :' 61 "KERNEL-ACCEPTED TorusT3 theorems=5 errors=0" cc_lean run_mut_lean
export MUT_STEM=TorusLTrans DK_BASE_RUN="$B/run.TorusLTrans.txt"
dk_tooth "$LEANDIR/TorusLTrans.lean" "$MUTB3" translbend 'theorem vecOfN_xor (N a b : ℕ) : vecOfN N (Nat.xor a b) = vecOfN N a + vecOfN N b := by' 'theorem vecOfN_xor (N a b : ℕ) : vecOfN N (Nat.xor a b) = vecOfN N a := by' 62 "KERNEL-ACCEPTED TorusLTrans theorems=2 errors=0" cc_lean run_mut_lean
export MUT_STEM=TorusT3Assembly DK_BASE_RUN="$B/run.TorusT3Assembly.txt"
dk_tooth "$LEANDIR/TorusT3Assembly.lean" "$MUTB3" assemblybend '(hs : TorusLSplit L) (y₀ : ℝ) (hy0 : 0 < y₀) (hy1 : y₀ < 1) (hstar : (17 : ℝ) / 19 < dualVar y₀)' '(hs : TorusLSplit L) (y₀ : ℝ) (hy0 : 0 < y₀) (hy1 : y₀ < 1) (hstar : (16 : ℝ) / 19 < dualVar y₀)' 63 "KERNEL-ACCEPTED TorusT3Assembly theorems=6 errors=0" cc_lean run_mut_lean
export MUT_STEM=TorusLocal DK_BASE_RUN="$B/run.TorusLocal.txt"
dk_tooth "$LEANDIR/TorusLocal.lean" "$MUTB3" localbend 'theorem testBit_bitOf (i p : ℕ) : Nat.testBit (Torus4.bitOf i) p = decide (p = i) := by' 'theorem testBit_bitOf (i p : ℕ) : Nat.testBit (Torus4.bitOf i) p = decide (p = i + 1) := by' 64 "KERNEL-ACCEPTED TorusLocal theorems=9 errors=0" cc_lean run_mut_lean
export MUT_STEM=EchelonList DK_BASE_RUN="$B/run.EchelonList.txt"
dk_tooth "$LEANDIR/EchelonList.lean" "$MUTB3" echelonbend "  (basis.zip piv).all (fun bp => basis.all (fun b' => (b' == bp.1) || !Nat.testBit b' bp.2))" "  (basis.zip piv).all (fun bp => basis.all (fun b' => (b' == bp.1) || Nat.testBit b' bp.2))" 65 "KERNEL-ACCEPTED EchelonList theorems=5 errors=0" cc_lean run_mut_lean
export MUT_STEM=DesignCore DK_BASE_RUN="$B/run.DesignCore.txt"
dk_tooth "$LEANDIR/DesignCore.lean" "$MUTB3" designcorebend 'theorem quarter_times4 (x : Quat) : quarter (times4 x) = x := by' 'theorem quarter_times4 (x : Quat) : quarter (times4 x) = times4 x := by' 66 "KERNEL-ACCEPTED DesignCore theorems=9 errors=0" cc_lean run_mut_lean
export DK_BASE_RUN="$RUNEMDS"
dk_tooth "$DSEMIT" "$MUTB3" designbend '  hurwitz(); icosa(); emit_group("BI", 5, 11, 120)' '  hurwitz(); icosa(); emit_group("BI", 5, 12, 120)' 67 'BT=24 gens=2,8 t=5 BO=48 gens=8,24 t=7 BI=120 gens=2,24 t=11 permutations=12' cc_lean run_mut_emitDS
export MUT_STEM=Design DK_BASE_RUN="$B/run.Design.txt"
dk_tooth "$LEANDIR/Design.lean" "$MUTB3" designlean 'theorem BI_strength : charSum 5 BI 12 ≠ ⟨0, 0⟩ := by decide +kernel' 'theorem BI_strength : charSum 5 BI 11 ≠ ⟨0, 0⟩ := by decide +kernel' 67 "KERNEL-ACCEPTED Design theorems=30 errors=0" cc_lean run_mut_lean
export MUT_STEM=TorusLinear DK_BASE_RUN="$B/run.TorusLinear.txt"
dk_tooth "$LEANDIR/TorusLinear.lean" "$MUTB3" linearbend 'theorem bodd_eq_decide (n : ℕ) : Nat.bodd n = decide (n % 2 = 1) := by' 'theorem bodd_eq_decide (n : ℕ) : Nat.bodd n = decide (n % 2 = 0) := by' 68 "KERNEL-ACCEPTED TorusLinear theorems=10 errors=0" cc_lean run_mut_lean
export MUT_STEM=TorusLinearDual DK_BASE_RUN="$B/run.TorusLinearDual.txt"
dk_tooth "$LEANDIR/TorusLinearDual.lean" "$MUTB3" dualbend '    (univ.filter (fun k : Fin (nCubes L) => i.val ∈ cubeFaces L (k.val / V L) (k.val % V L))).card = 4 := by' '    (univ.filter (fun k : Fin (nCubes L) => i.val ∈ cubeFaces L (k.val / V L) (k.val % V L))).card = 5 := by' 69 "KERNEL-ACCEPTED TorusLinearDual theorems=10 errors=0" cc_lean run_mut_lean
export DK_BASE_RUN="$RUNEML"
dk_tooth "$TLEMIT" "$MUTB3" emitbend '    m = or(m, bit(plq(a, b, s))); m = or(m, bit(plq(a, b, step(s, d))))' '    m = or(m, bit(plq(a, b, s))); m = or(m, bit(plq(a, b, s)))' 70 'ranks Cobd=240 Bd3=240 Bd3S=246 side=3 V=81' cc_lean run_mut_emitL
export MUT_STEM=TorusLCert3 DK_BASE_RUN="$B/run.TorusLCert3.txt"
export MUT_STEM=TorusL3 DK_BASE_RUN="$B/run.TorusL3.txt"
dk_tooth "$LEANDIR/TorusL3.lean" "$MUTB3" l3bend 'theorem finrank_K3 : Module.finrank (ZMod 2) (K 3) = 240 := by' 'theorem finrank_K3 : Module.finrank (ZMod 2) (K 3) = 241 := by' 71 "KERNEL-ACCEPTED TorusL3 theorems=15 errors=0" cc_lean run_mut_lean
export DK_BASE_RUN="$RUNEMLT"
dk_tooth "$TLTEMIT" "$MUTB3" transemitbend '    m = or(m, bit(plq(a, b, s))); m = or(m, bit(plq(a, b, step(s, d))))' '    m = or(m, bit(plq(a, b, s))); m = or(m, bit(plq(a, b, s)))' 72 'translations=54 rankD=240 side=3 V=81 verdict=ALL-IN-D' cc_lean run_mut_emitLT
export MUT_STEM=TorusT3L3 DK_BASE_RUN="$B/run.TorusT3L3.txt"
dk_tooth "$LEANDIR/TorusT3L3.lean" "$MUTB3" t3l3bend '(hq : q < 6) (h1 : c₁ < 3) (h2 : c₂ < 3) :' '(hq : q < 7) (h1 : c₁ < 3) (h2 : c₂ < 3) :' 73 "KERNEL-ACCEPTED TorusT3L3 theorems=2 errors=0" cc_lean run_mut_lean
export DK_BASE_RUN="$RUNSU2K"
dk_tooth "$SU2KAT" "$MUTSU2" struvebend 't = t \* x \* x / ((2 \* k + 1) \* (2 \* k + 3))' 't = t * x * x / ((2 * k + 1) * (2 * k + 2))' 74 'crossing beta*=0.1310307711153333870294052317252045565108 (18 L1/I1 = 1) pi/24=0.1308996938995747182692768076366459535082 window=1.311e-04' cc_su2 run_mut_su2kat
dk_tooth "$SU2KAT" "$MUTSU2" rowbend 'if (18 \* struve1(mid) / bessel1(mid) < 1) lo = mid; else hi = mid' 'if (17 * struve1(mid) / bessel1(mid) < 1) lo = mid; else hi = mid' 74 'crossing beta*=0.1310307711153333870294052317252045565108 (18 L1/I1 = 1) pi/24=0.1308996938995747182692768076366459535082 window=1.311e-04' cc_su2 run_mut_su2kat
dk_tooth "$SU2KAT" "$MUTSU2" neumannbend 'closed = (g / (f \* f \* f \* f)) \* n \* (n - 1) \* (n + 4) / ((n + 1) \* (n + 1) \* (n + 2))' 'closed = (g / (f * f * f * f)) * n * (n - 1) * (n + 5) / ((n + 1) * (n + 1) * (n + 2))' 74 'max |diff|=2.737e-48 negatives=0 NEUMANN-MET' cc_su2 run_mut_su2kat
dk_tooth "$SU2KAT" "$MUTSU2" haarbend 'for (i = 0; i <= NQ1; i++) { w = WQ\[i\] \* SQ\[i\] \* SQ\[i\] \* exp(K \* TQ\[i\]); mass += w;' 'for (i = 0; i <= NQ1; i++) { w = WQ[i] * SQ[i] * exp(K * TQ[i]); mass += w;' 74 'lemmaM dead-world K=0: |h - 4/(3pi)| max=2.907e-07' cc_su2 run_mut_su2kat
dk_control "$SU2KAT" "$MUTSU2" '^# THE IDENTITY\.  The one-link conditional of the Wilson action at coupling beta with staple sum S is the von Mises-Fisher' '# THE IDENTITY (comment control).  The one-link conditional of the Wilson action at coupling beta with staple sum S is the von Mises-Fisher' "$RUNSU2K" cc_su2 run_mut_su2kat
export DK_BASE_RUN="$RUNSU2L"
dk_tooth "$SU2LINK" "$MUTSU2" su2rowbend '    row = 18 \* best' '    row = 17 * best' 75 'beta=0.125 C=0.053003352344 row=18C=0.954060342194 DOBRUSHIN-HOLDS argmax[r=0 a=0pi/6' cc_su2 run_mut_su2link
dk_tooth "$SU2LINK" "$MUTSU2" su2normbend '      d = exp(beta \* (S0 \* u0 + S1 \* u1)) / ZS - exp(beta \* (T0 \* u0 + T1 \* u1)) / ZT' '      d = exp(beta * (S0 * u0 + S1 * u1)) / ZS - exp(beta * (T0 * u0 + T1 * u1)) / ZS' 75 'beta=0.125 C=0.053003352344 row=18C=0.954060342194 DOBRUSHIN-HOLDS argmax[r=0 a=0pi/6' cc_su2 run_mut_su2link
dk_tooth "$SU2LINK" "$MUTSU2" su2kinkbend '  if (c0 > -1 && c0 < 1) th0 = atan2(sqrt(1 - c0 \* c0), c0); else th0 = PI / 2' '  if (c0 > -1 \&\& c0 < 1) th0 = PI / 2; else th0 = PI / 2' 75 'flip-1d=0.053003352006 competitor-1d=0.052936363462 flip-lead=6.699e-05 FLIP-LEADS' cc_su2 run_mut_su2link
dk_control "$SU2LINK" "$MUTSU2" '^# action, read exactly up to quadrature (gawk -M at PREC bits), with its two-sided controls\.' '# action (comment control), read exactly up to quadrature (gawk -M at PREC bits), with its two-sided controls.' "$RUNSU2L" cc_su2 run_mut_su2link
export DK_BASE_RUN="$RUNBI"
dk_tooth "$BIFLIP" "$MUTSU2" bidesignbend 'cat\[k\] = cat\[k - 1\] \* 2 \* (2 \* k - 1) / (k + 1)' 'cat[k] = cat[k - 1] * 2 * (2 * k - 1) / (k + 2)' 76 'design degree=10 E_BI u0^10=0.041015625000000000 haar=0.041015625000000000' cc_su2 run_mut_biflip
dk_tooth "$BIFLIP" "$MUTSU2" biclassbend 'num = 2 \* sinh(b) + 40 \* sinh(b / 2) + 24 \* sinh(PHI \* b / 2) + 24 \* sinh(b / (2 \* PHI))' 'num = 2 * sinh(b) + 40 * sinh(b / 2) + 23 * sinh(PHI * b / 2) + 24 * sinh(b / (2 * PHI))' 76 'flip beta=0.125 C_BI=0.050823594620876575 class-form=0.050823594620876575' cc_su2 run_mut_biflip
dk_tooth "$BIFLIP" "$MUTSU2" biphibend 'PI = 4 \* atan2(1, 1); PHI = (1 + sqrt(5)) / 2; M0 = 4 / (3 \* PI)' 'PI = 4 * atan2(1, 1); PHI = (1 + sqrt(5)) / 2 + 0.001; M0 = 4 / (3 * PI)' 76 'aperanton_bi_flip PREC=160 elements=120 unit-err=0.000e+00' cc_su2 run_mut_biflip
dk_control "$BIFLIP" "$MUTSU2" '^# On BI the one-link conditional is p(U | S) = exp(beta <S,U>)' '# On BI (comment control) the one-link conditional is p(U | S) = exp(beta <S,U>)' "$RUNBI" cc_su2 run_mut_biflip
export MUT_STEM=NeumannCoeff DK_BASE_RUN="$B/run.NeumannCoeff.txt"
dk_tooth "$LEANDIR/NeumannCoeff.lean" "$MUTB3" neumannclosedbend '((n : ℚ) \* ((n : ℚ) - 1) \* ((n : ℚ) + 4))' '((n : ℚ) * ((n : ℚ) - 1) * ((n : ℚ) + 5))' 77 "KERNEL-ACCEPTED NeumannCoeff theorems=13 errors=0" cc_lean run_mut_lean
export MUT_STEM=BondMoving DK_BASE_RUN="$B/run.BondMoving.txt"
dk_tooth "$LEANDIR/BondMoving.lean" "$MUTB3" bondcsbend '    (Z w (fun x => A x + B x)) ^ 2 ≤ Z w (fun x => 2 \* A x) \* Z w (fun x => 2 \* B x) := by' '    (Z w (fun x => A x + B x)) ^ 2 ≤ Z w (fun x => 2 * A x) * Z w (fun x => 3 * B x) := by' 78 "KERNEL-ACCEPTED BondMoving theorems=6 errors=0" cc_lean run_mut_lean
export DK_BASE_RUN="$RUNFLOW"
dk_tooth "$ROOT/STDLIB/scripts/aperanton_mkflow.awk" "$MUTFLOW" convbend 'a\[m\] = a\[m\] ^ n / dm(m) ^ (n - 1)' 'a[m] = a[m] ^ n / dm(m) ^ n' 79 'flow=A beta=3 n=3 beta_eff=7.52691542003e-16 osc=1.50538308401e-15 nine_osc=1.3548447756e-14 r_twist=1 u1=3.76345771001e-16 u2=1.34718419893e-39' cc_flow run_mut_flow
dk_tooth "$ROOT/STDLIB/scripts/aperanton_mkflow.awk" "$MUTFLOW" pointbend 'for (k = 0; k < NG; k++) g\[k\] = fv\[k\] ^ n' 'for (k = 0; k < NG; k++) g[k] = fv[k] ^ (n + 1)' 79 'FLOW A beta=2.3 end=STRONG steps=10 nstar_floor=8 nstar_ceil=8' cc_flow run_mut_flow
dk_tooth "$ROOT/STDLIB/scripts/aperanton_mkflow.awk" "$MUTFLOW" twistbend 'sg = (m % 2 == 0) ? 1 : -1; s += a\[m\] / dm(m); t += sg \* a\[m\] / dm(m)' 'sg = 1; s += a[m] / dm(m); t += sg * a[m] / dm(m)' 79 'flow=A beta=2.3 n=0 beta_eff=2.3 osc=4.6 nine_osc=41.4 r_twist=0.382016571815 u1=0.958558156609 u2=0.499413504498 u3=0.180025862791 u4=0.0496346982579 tail=0' cc_flow run_mut_flow
dk_tooth "$ROOT/STDLIB/scripts/aperanton_mkflow.awk" "$MUTFLOW" exactbend 'pw = (q + p) ^ 4; mw = (q - p) ^ 4; p = pw - mw; q = pw + mw      # the pointwise power 4' 'pw = (q + p) ^ 3; mw = (q - p) ^ 3; p = pw - mw; q = pw + mw      # the pointwise power 4' 79 'exact=A y=1/3 beta=0.549306144334 n=1 u=0.9059506448 float_u=0.9059506448 diff=0 v2=32/20 v3=0/0 v5=4/0 log10h=12.4717353402' cc_flow run_mut_flow
dk_control "$ROOT/STDLIB/scripts/aperanton_mkflow.awk" "$MUTFLOW" '^# CONTROLS: GROUP=z2, GROUP=u1, D=2 (kat2d), BETAS=0 (dead: a_m = 0 for m > 0, the flow stays dead)\.' '# CONTROLS (comment control): GROUP=z2, GROUP=u1, D=2 (kat2d), BETAS=0 (dead: a_m = 0 for m > 0, the flow stays dead).' "$RUNFLOW" cc_flow run_mut_flow
export DK_BASE_RUN="$RUNPLAQ"
dk_tooth "$PLAQ" "$MUTPLAQ" plaqcjbend 'return 2 \* besselI(n + 1, x) / x }' 'return 2 * besselI(n + 1, x) / (x + 1) }' 80 'control beta=0.125 one-link flip by the block instrument at JMAX=0: 0.053184249172 series L1/I1=0.053003344930 |diff|=1.809e-04' cc_plaq run_mut_plaq
dk_tooth "$PLAQ" "$MUTPLAQ" plaqdimbend 'v = (n + 1) \* cj(n, beta) \* cj(n, beta \* n2)' 'v = (n + 2) * cj(n, beta) * cj(n, beta * n2)' 80 'beta=0.125 TV_own=0.053989315478 at [r=2 a=0pi/2 pl=1' cc_plaq run_mut_plaq
dk_tooth "$PLAQ" "$MUTPLAQ" plaqnormbend 'd = dens("A", beta, S10, S1v, pl, qa0, qa1, u0, u1, u2, u3) / Z0 - dens("B", beta, T10, T1v, pl2, qb0, qb1, u0, u1, u2, u3) / Z1' 'd = dens("A", beta, S10, S1v, pl, qa0, qa1, u0, u1, u2, u3) / Z0 - dens("B", beta, T10, T1v, pl2, qb0, qb1, u0, u1, u2, u3) / Z0' 80 'beta=0.125 TV_own=0.053989315478 at [r=2 a=0pi/2 pl=1' cc_plaq run_mut_plaq
dk_control "$PLAQ" "$MUTPLAQ" '^# THE BLOCK: the four links of one plaquette; each lies in six plaquettes of which five are outside and hold one block' '# THE BLOCK (comment control): the four links of one plaquette; each lies in six plaquettes of which five are outside and hold one block' "$RUNPLAQ" cc_plaq run_mut_plaq
export DK_BASE_RUN="$RUNHINGE"
dk_tooth "$HINGE" "$MUTHINGE" hingeseambend 'if (which == 1 && (i == xl(1, 0) || i == xl(1, 1))) f = -1' 'if (which == 1 \&\& (i == xl(0, 0) || i == xl(1, 1))) f = -1' 81 'HINGE L=2 MONOTONE-DOWN first_bad=- r_at_top=0.0792521863512 F/(4beta)_top=0.633780069645 pass_0.9_at=0.4' cc_hinge run_mut_hinge
dk_tooth "$HINGE" "$MUTHINGE" hingeplaqbend 't += sgn(s, xl(a, b)) \* sgn(s, yl(a + 1, b)) \* sgn(s, xl(a, b + 1)) \* sgn(s, yl(a, b))' 't += sgn(s, xl(a, b)) * sgn(s, yl(a + 1, b)) * sgn(s, xl(a, b + 1)) * sgn(s, yl(a + 1, b + 1))' 81 'HINGE L=2 MONOTONE-DOWN first_bad=- r_at_top=0.0792521863512 F/(4beta)_top=0.633780069645 pass_0.9_at=0.4' cc_hinge run_mut_hinge
dk_tooth "$HINGE" "$MUTHINGE" hingegaugebend 'for (g = 0; g < 16; g++) { t = gauge(s, g); ORB\[t\] = n }' 'for (g = 0; g < 4; g++) { t = gauge(s, g); ORB[t] = n }' 81 'HINGE L=2 MONOTONE-DOWN first_bad=- r_at_top=0.0792521863512 F/(4beta)_top=0.633780069645 pass_0.9_at=0.4' cc_hinge run_mut_hinge
dk_control "$HINGE" "$MUTHINGE" '^# gawk traps honoured: 0 - x never -x; arrays named past the builtins; one BEGIN scope, names read whole\.' '# gawk traps honoured (comment control): 0 - x never -x; arrays named past the builtins; one BEGIN scope, names read whole.' "$RUNHINGE" cc_hinge run_mut_hinge
export DK_BASE_RUN="$RUNSHADOW"
dk_tooth "$SHADOW" "$MUTSHADOW" shadowcommbend 'function comm(x, y) { return MUL\[MUL\[MUL\[x, y\], INV\[x\]\], INV\[y\]\] }' 'function comm(x, y) { return MUL[MUL[MUL[x, y], INV[y]], INV[x]] }' 82 'G=q8 L=2 beta=0.5 r_xt=0.945254766382 r_xy=0.604013683235 -lnr_xt/beta=0.112601587535 r_dead=1' cc_shadow run_mut_shadow
dk_tooth "$SHADOW" "$MUTSHADOW" shadowtwistbend '  if (which == 1) fx = -1' '  if (which == 1) fx = 1' 82 'G=q8 L=2 beta=0.5 r_xt=0.945254766382 r_xy=0.604013683235 -lnr_xt/beta=0.112601587535 r_dead=1' cc_shadow run_mut_shadow
dk_tooth "$SHADOW" "$MUTSHADOW" shadoworbitbend 't = conj(g, x) \* NEL + conj(g, y); ORB\[t\] = n' 't = conj(g, x) * NEL + y; ORB[t] = n' 82 'G=q8 L=2 beta=0.5 r_xt=0.945254766382 r_xy=0.604013683235 -lnr_xt/beta=0.112601587535 r_dead=1' cc_shadow run_mut_shadow
dk_control "$SHADOW" "$MUTSHADOW" '^# gawk traps honoured: 0 - x never -x; arrays named past the builtins; one BEGIN scope, names read whole\.' '# gawk traps honoured (comment control): 0 - x never -x; arrays named past the builtins; one BEGIN scope, names read whole.' "$RUNSHADOW" cc_shadow run_mut_shadow
export DK_BASE_RUN="$RUNCOUNTS"
dk_tooth "$COUNTS" "$MUTCOUNTS" countswindbend 'if (c == ONE && cx == MINUS && cy == ONE) nwind++' 'if (c == ONE \&\& cx == ONE \&\& cy == ONE) nwind++' 83 'COUNTS GROUP=q8 elements=8 commuting_pairs=40 anticommuting_pairs=24 plain_triples=176 winding_triples=48 sheet_triples=48 r_xt_inf=0.272727272727 r_xy_inf=0.272727272727' cc_counts run_mut_counts
dk_tooth "$COUNTS" "$MUTCOUNTS" countscommbend 'function comm(x, y) { return MUL\[MUL\[MUL\[x, y\], INV\[x\]\], INV\[y\]\] }' 'function comm(x, y) { return MUL[MUL[MUL[x, y], INV[y]], INV[x]] }' 83 'COUNTS GROUP=q8 elements=8 commuting_pairs=40 anticommuting_pairs=24 plain_triples=176 winding_triples=48 sheet_triples=48 r_xt_inf=0.272727272727 r_xy_inf=0.272727272727' cc_counts run_mut_counts
dk_tooth "$COUNTS2" "$MUTCOUNTS" counts2twistbend 'tx1m = (MUL\[MINUS, cj(x1, g0)\] == g1)' 'tx1m = (MUL[MINUS, cj(x1, g0)] == g0)' 83 'COUNTS2 GROUP=q8 cell=2x1xL plain=1408 xt=384 yt=384 xy=384 r_xt_inf=0.272727272727 r_yt_inf=0.272727272727 r_xy_inf=0.272727272727' cc_counts run_mut_counts2
dk_control "$COUNTS" "$MUTCOUNTS" '^# gawk traps honoured: 0 - x never -x; arrays named past the builtins; one BEGIN scope, names read whole\.' '# gawk traps honoured (comment control): 0 - x never -x; arrays named past the builtins; one BEGIN scope, names read whole.' "$RUNCOUNTS" cc_counts run_mut_counts
export DK_BASE_RUN="$RUNSU2CELL"
dk_tooth "$SU2CELL" "$MUTSU2CELL" su2cellfrickebend 'fr = 2 \* a \* a + 2 \* b \* b + 2 \* c \* c - 4 \* a \* b \* c - 1' 'fr = 2 * a * a + 2 * b * b + 2 * c * c - 4 * a * b * c - 1.01' 84 'SU2 L=2 beta=1 r_xt=0.836490432701 r_xy=0.345206879949 -lnr_xt/beta=0.178540195918 r_dead=0.997739032389' cc_su2cell run_mut_su2cell
dk_tooth "$SU2CELL" "$MUTSU2CELL" su2celltwistbend 'sp += GWT\[p\] \* exp(beta \* (dx + dy)); sm += GWT\[p\] \* exp(beta \* (dy - dx))' 'sp += GWT[p] * exp(beta * (dx + dy)); sm += GWT[p] * exp(beta * (dy + dx))' 84 'SU2 L=2 beta=1 r_xt=0.836490432701 r_xy=0.345206879949 -lnr_xt/beta=0.178540195918 r_dead=0.997739032389' cc_su2cell run_mut_su2cell
dk_tooth "$SU2CELL" "$MUTSU2CELL" su2cellmeasurebend 'OW\[NO\] = (4 / (PI \* PI)) \* WA\[ia\] \* WA\[ib\] \* WU\[iu\] / 2' 'OW[NO] = (2 / (PI * PI)) * WA[ia] * WA[ib] * WU[iu] / 2' 84 '# aperanton_su2_cell.awk NA=4 NU=4 NG=8 orbit_nodes=64 g_nodes=512 measure_total=1 g_total=1 fricke_check=5.55111512313e-16 LS=2 grid=[1,1] step 0.5' cc_su2cell run_mut_su2cell
dk_control "$SU2CELL" "$MUTSU2CELL" '^# gawk traps honoured: 0 - x never -x; arrays named past the builtins; one BEGIN scope, names read whole\.' '# gawk traps honoured (comment control): 0 - x never -x; arrays named past the builtins; one BEGIN scope, names read whole.' "$RUNSU2CELL" cc_su2cell run_mut_su2cell
export DK_BASE_RUN="$RUNDESIGN"
dk_tooth "$DESIGN" "$MUTDESIGN" designlawbend 'W\[j2\] = DD\[j2\] \* DD\[j2\] \* CC\[j2\] / exp(beta)' 'W[j2] = DD[j2] * CC[j2] / exp(beta)' 85 'RESIDUE beta=1 t=3 tail1_oneplaq=0.00164293 P_linkdeg=0.411082 B_linkbad=5.71755 lead=0.88688 lead_spins2j=[1 1 1]' cc_design run_mut_design
dk_tooth "$DESIGN" "$MUTDESIGN" designconvbend 'PN\[dd + ML\[p\] \* j2\] += PD\[dd\] \* W\[j2\]' 'PN[dd + j2] += PD[dd] * W[j2]' 85 'RESIDUE beta=1 t=3 tail1_oneplaq=0.00164293 P_linkdeg=0.411082 B_linkbad=5.71755 lead=0.88688 lead_spins2j=[1 1 1]' cc_design run_mut_design
dk_tooth "$DESIGN" "$MUTDESIGN" designleadbend 'w2 = DD\[j2\] \* DD\[j2\] \* CC\[j2\] / CC\[0\]' 'w2 = DD[j2] * CC[j2] / CC[0]' 85 'RESIDUE beta=1 t=3 tail1_oneplaq=0.00164293 P_linkdeg=0.411082 B_linkbad=5.71755 lead=0.88688 lead_spins2j=[1 1 1]' cc_design run_mut_design
dk_tooth "$DESIGN" "$MUTDESIGN" designsolvebend 'mid = (lo + hi) / 2; prep(mid); if (ptail(t) < pstar)' 'mid = (lo + hi) / 2; prep(mid * 1.01); if (ptail(t) < pstar)' 85 'SOLVE t=11 pstar=0.915 beta=5.5156 P=0.915 tail1=1.04676e-05 lead=5090.2 lead_spins2j=[2 2 2 2 2 2]' cc_design run_mut_design
dk_tooth "$HINGEFORDESIGN" "$MUTDESIGN" designanchorbend 'if (first == 0 && AVG\[n\] > 0.5) first = n' 'if (first == 0 \&\& AVG[n] > 1.5) first = n' 85 'DESIGN GROUP=2i elements=120 invariants_by_2j=[ 1:0.000000 2:-0.000000 3:0.000000 4:-0.000000 5:0.000000 6:0.000000 7:0.000000 8:0.000000 9:0.000000 10:0.000000 11:0.000000 12:1.000000 13:0.000000 14:-0.000000 ] first_invariant_2j=12 t=11' cc_design run_mut_designanchor
dk_control "$DESIGN" "$MUTDESIGN" '^#   gawk traps honoured: 0 - x never -x; arrays named past the builtins; one BEGIN scope, names read whole\.' '#   gawk traps honoured (comment control): 0 - x never -x; arrays named past the builtins; one BEGIN scope, names read whole.' "$RUNDESIGN" cc_design run_mut_design
export MUT_STEM=DesignDihedral DK_BASE_RUN="$B/run.DesignDihedral.txt"
dk_tooth "$LEANDIR/DesignDihedral.lean" "$MUTB3" dihedralclassbend '   (12, ⟨0, 1⟩), (12, ⟨0, -1⟩), (12, ⟨-1, 1⟩), (12, ⟨1, -1⟩)\]' '   (12, ⟨0, 1⟩), (12, ⟨0, -1⟩), (12, ⟨1, 1⟩), (12, ⟨1, -1⟩)]' 86 "KERNEL-ACCEPTED DesignDihedral theorems=18 errors=0" cc_lean run_mut_lean
dk_tooth "$LEANDIR/DesignDihedral.lean" "$MUTB3" dihedralordfourbend 'def Dic4 : ClassTable 0 2 := \[(1, ⟨2, 0⟩), (1, ⟨-2, 0⟩), (2, ⟨0, 1⟩), (2, ⟨0, -1⟩), (2, ⟨0, 0⟩), (8, ⟨0, 0⟩)\]' 'def Dic4 : ClassTable 0 2 := [(1, ⟨2, 0⟩), (1, ⟨-2, 0⟩), (2, ⟨0, 1⟩), (2, ⟨0, -1⟩), (2, ⟨1, 0⟩), (8, ⟨0, 0⟩)]' 86 "KERNEL-ACCEPTED DesignDihedral theorems=18 errors=0" cc_lean run_mut_lean
export DK_BASE_RUN="$RUNSL"
dk_tooth "$SIMONLIEB" "$MUTSL" simonlayerbend 'for (i = 0; i < 9; i++) e += spin(s, i) \* spin(t, i); T\[s, t\] = exp(beta \* e)' 'for (i = 0; i < 9; i++) e += spin(s, i) * spin(t, (i + 1) % 9); T[s, t] = exp(beta * e)' 87 'SIMONLIEB beta_I=0.1 S=0.929614738397 verdict=CERTIFIED rate_plain=0.0729850384526 rate_solved=0.0524329123946 face=0.103954379369 edge=0.021323730631 corner=0.00625046182622' cc_simonlieb run_mut_simonlieb
dk_tooth "$SIMONLIEB" "$MUTSL" simonbondbend '    if (c < 2) { BA\[NBND\] = 3 \* r + c; BB\[NBND\] = 3 \* r + c + 1; NBND++ }' '    if (c < 1) { BA[NBND] = 3 * r + c; BB[NBND] = 3 * r + c + 1; NBND++ }' 87 'SIMONLIEB beta_I=0.1 S=0.929614738397 verdict=CERTIFIED rate_plain=0.0729850384526 rate_solved=0.0524329123946 face=0.103954379369 edge=0.021323730631 corner=0.00625046182622' cc_simonlieb run_mut_simonlieb
dk_tooth "$SIMONLIEB" "$MUTSL" simonratebend 'if (f < 1) lo = m; else hi = m }; m = lo }' 'if (f < 2) lo = m; else hi = m }; m = lo }' 87 'SIMONLIEB beta_I=0.1 S=0.929614738397 verdict=CERTIFIED rate_plain=0.0729850384526 rate_solved=0.0524329123946 face=0.103954379369 edge=0.021323730631 corner=0.00625046182622' cc_simonlieb run_mut_simonlieb
dk_control "$SIMONLIEB" "$MUTSL" '^#   gawk traps honoured: 0 - x never -x; arrays named past the builtins; one BEGIN scope, names read whole\.' '#   gawk traps honoured (comment control): 0 - x never -x; arrays named past the builtins; one BEGIN scope, names read whole.' "$RUNSL" cc_simonlieb run_mut_simonlieb
export DK_BASE_RUN="$RUNFIBM"
dk_tooth "$PROBESRC" "$MUTPRB" fibmaskbend 'function hamm(a, b) { return FIBMETRIC ? popc(and(xor(a, b), 7)) : popc(xor(a, b)) }' 'function hamm(a, b) { return FIBMETRIC ? popc(and(xor(a, b), 15)) : popc(xor(a, b)) }' 88 'PROBE-DSW1 square CONSTR=1 FIBMETRIC=1 y=13/15 flows=5760 sum r = 2556788097904592539548216510318829453341105623400 / 642988249460083308773809402152551131767772889839 = 3.976414965672 ; (1/|B|) sum r = 852262699301530846516072170106276484447035207800 / 642988249460083308773809402152551131767772889839 = 1.325471655224 verdict=NOT-BELOW-ONE' cc_lean run_mut_fibm
export DK_BASE_RUN="$RUNVORTH"
dk_tooth "$VORTEXH" "$MUTVORT" vortextwistbend 'VDT\[o\] = exp(0 - 2 \* beta \* E0\[comm(x, y)\])' 'VDT[o] = exp(0 - 1 * beta * E0[comm(x, y)])' 89 'VORTEX G=z2 beta=1 lam=25.8899800213 mu(1)=0.135335283237 mu(2)=0.0183156388887 mu(3)=0.00247875217667 c_minus=0.135335283237 c_plus=0.135335283237 known_z2_mu1=0.135335283237 known_z2_c=0.135335283237' cc_vortex run_mut_vortexh
dk_tooth "$VORTEXH" "$MUTVORT" vortexflatbend 'if (VFL\[op\]) acc += M0\[o, op\] / VW\[o\]' 'if (1) acc += M0[o, op] / VW[o]' 89 'VORTEX G=q8 beta=2 lam=998.817813116 mu(1)=0.229962773978 mu(2)=0.162595400502 mu(3)=0.119674455151 c_minus=0.250159786164 c_plus=0.250159786164 known_z2_mu1=- known_z2_c=-' cc_vortex run_mut_vortexh
dk_control "$VORTEXH" "$MUTVORT" '^# gawk traps honoured: 0 - x never -x; arrays named past the builtins; one BEGIN scope, names read whole\.' '# gawk traps honoured (comment control): 0 - x never -x; arrays named past the builtins; one BEGIN scope, names read whole.' "$RUNVORTH" cc_vortex run_mut_vortexh
export DK_BASE_RUN="$RUNVORTS"
dk_tooth "$VORTEXS" "$MUTVORT" vortexanglebend 'al = (k - 0.5) \* PI / NF; ga = (kf - 0.5) \* PI / NF' 'al = (k - 0.5) * PI / (2 * NF); ga = (kf - 0.5) * PI / NF' 90 'VORTEX-SU2 beta=1 lam=1.8605738284 iterations=12 mu(1)=0.607300255483 mu(2)=0.375633346927 mu(3)=0.232460656716 c_minus=0.589368955671 c_plus=0.589368955671' cc_vortex run_mut_vortexs
export DK_BASE_RUN="$RUNSLB"
dk_tooth "$SLBOX" "$MUTSLB" slboxsitebend '  for (i = 0; i < NSITE; i++) { bit = lshift(1, i)' '  for (i = 1; i < NSITE; i++) { bit = lshift(1, i)' 91 'SIMONLIEB-BOX box=3x3x3 beta_I=0.1 boundary_sites=26 S=0.929614738397 verdict=CERTIFIED rate_plain=0.0729850384526 rate_solved=0.0524329123946 dobrushin_dual=0.59800796775 beta_g=1.15295533518' cc_slbox run_mut_slbox
dk_control "$SLBOX" "$MUTSLB" '^#   gawk traps honoured: 0 - x never -x; arrays named past the builtins; one BEGIN scope, names read whole\.' '#   gawk traps honoured (comment control): 0 - x never -x; arrays named past the builtins; one BEGIN scope, names read whole.' "$RUNSLB" cc_slbox run_mut_slbox
export DK_BASE_RUN="$RUNEVEN"
dk_tooth "$Z2EVEN" "$MUTEVEN" evenboxbend '    for (oq = 0; oq < NORB; oq++) { acc0 += EVK\[op, oq\] \* EVW\[oq\]; acc1 += EVK\[op, oq\] \* EVW\[oq\] \* EVO\[q, oq\] }' '    for (oq = 0; oq < NORB; oq++) { acc0 += EVK[op, oq] * EVW[oq]; acc1 += EVK[op, oq] * EVW[oq] * EVO[0, oq] }' 92 'SIMONLIEB-EVEN beta=0.5 t=2 lhs=0.377540466217 rhs_full=1.13526940002 HOLDS | lhs_T=0.00167988280343 rhs_T=0.00155632330132 FAILS' cc_even run_mut_even
dk_control "$Z2EVEN" "$MUTEVEN" '^# gawk traps honoured: 0 - x never -x; arrays named past the builtins; one BEGIN scope, names read whole\.' '# gawk traps honoured (comment control): 0 - x never -x; arrays named past the builtins; one BEGIN scope, names read whole.' "$RUNEVEN" cc_even run_mut_even
export MUT_STEM=TwistEater DK_BASE_RUN="$B/run.TwistEater.txt"
dk_tooth "$LEANDIR/TwistEater.lean" "$MUTB3" eaterorbitbend 'def eater : Finset S := {(2, 4), (2, 5), (3, 4), (3, 5)}' 'def eater : Finset S := {(2, 4), (2, 5), (3, 4), (0, 0)}' 93 "KERNEL-ACCEPTED TwistEater theorems=39 errors=0" cc_lean run_mut_lean
dk_tooth "$LEANDIR/TwistEater.lean" "$MUTB3" eatercountbend 'temp s p\.1 p\.2 = 2)).card = 8 := by decide' 'temp s p.1 p.2 = 2)).card = 9 := by decide' 93 "KERNEL-ACCEPTED TwistEater theorems=39 errors=0" cc_lean run_mut_lean
export DK_BASE_RUN="$RUNFLATM"
# besselbend's PREDICTION CORRECTED (2026-10-30 04:0x EDT, the author, after run al convicted it; law 18, law 20 (v)): doubling every
# term of I_n's series past the first scales EVERY I_n by the same factor (the first term 160^n/n! is below I_n(320) by a hundred
# orders), and the alpha-marginal rho = (2/pi) sum I_n sin^2(n alpha) / sum I_n is a RATIO -- invariant under a uniform scaling,
# so the rho pin cannot move and SURVIVED.  The observable that sees the bend is the partition sum Z = sum I_n itself, pinned on
# the BETA=320 line (Z_exact doubles, the ratio to e^beta/beta doubles); that line is the pin now, read from run.flatm.txt.
dk_tooth "$FLATM" "$MUTFLATM" besselbend 'sum += term; if (term < sum' 'sum += 2 * term; if (term < sum' 94 'BETA=320 N=183 Z_exact=2.879289e+136 e^beta/beta=2.944993e+136 ratio=0.977690' cc_flatm run_mut_flatm
dk_control "$FLATM" "$MUTFLATM" '^#   gawk traps honoured: 0 - x never -x; arrays named past the builtins; one BEGIN scope, names read whole\.' '#   gawk traps honoured (comment control): 0 - x never -x; arrays named past the builtins; one BEGIN scope, names read whole.' "$RUNFLATM" cc_flatm run_mut_flatm
export DK_BASE_RUN="$RUNGKSH"
dk_tooth "$GKSH" "$MUTGKS" gkschebbend 'if (n == 2) return 4 \* q \* q - 1;' 'if (n == 2) return 4 * q * q - 2;' 95 'GKS-ONE G=2t beta=2 lam=4523.73917101 <chi_1/2>=1.64783641592 <chi_2/2>=2.30454565361 <chi_3/2>=3.29567283184 <chi_4/2>=4.30454565361' cc_gks run_mut_gksh
export DK_BASE_RUN="$RUNKTU"
dk_tooth "$KTU" "$MUTGKS" ktsignbend 'SGN\[o\] = (OC\[o\] > 0) ? 1 : ((OC\[o\] < 0) ? -1 : 0)' 'SGN[o] = (OC[o] > -0.5) ? 1 : ((OC[o] < -0.5) ? -1 : 0)' 96 'KT-PAIR-SU2 beta=1 l=1 z=0.166620365616 F=-ln z=1.79203731413 lambda_vv/lambda_ff=0.180772529257' cc_gks run_mut_ktu
export DK_BASE_RUN="$RUNKTH"
dk_tooth "$KTH" "$MUTGKS" ktsignhbend 'SGN\[o\] = (E0\[comm(x, y)\] > 0) ? 1 : ((E0\[comm(x, y)\] < 0) ? -1 : 0)' 'SGN[o] = (E0[comm(x, y)] > 0) ? -1 : ((E0[comm(x, y)] < 0) ? 1 : 0)' 96 'KT-PAIR G=q8 beta=3 l=1 z=0.000113113837231 F=-ln z=9.08711583722 lambda_vv/lambda_ff=0.00211606581594' cc_gks run_mut_kth
export DK_BASE_RUN="$RUNEATH"
dk_tooth "$EATERH" "$MUTEAT" eaterclassbend 'if (ENDS == "eater") VFL\[o\] = (comm(x, y) == MINUS) ? 1 : 0' 'if (ENDS == "eater") VFL[o] = (comm(x, y) == ONE) ? 1 : 0' 97 'VORTEX G=q8 beta=2 lam=998.817813116 mu(1)=0.229962773978 mu(2)=0.162595400502 mu(3)=0.119674455151 c_minus=0.840651221025 c_plus=0.840651221025 known_z2_mu1=- known_z2_c=-' cc_eater run_mut_eaterh
export DK_BASE_RUN="$RUNEATS"
dk_tooth "$EATERS" "$MUTEAT" eaternodebend 'VKF\[0, o\] = kbar(beta, 0, 1, 0, 0, 0, 0, 1, 0,' 'VKF[0, o] = kbar(beta, 0, 1, 0, 0, 0, 1, 0, 0,' 97 'VORTEX-SU2 beta=2 lam=6.66396013216 iterations=18 mu(1)=0.336937634994 mu(2)=0.140164151402 mu(3)=0.0589599256338 c_minus=0.503991748381 c_plus=0.503991748381' cc_eater run_mut_eaters
export MUT_STEM=TwistEaterGeneral DK_BASE_RUN="$B/run.TwistEaterGeneral.txt"
dk_tooth "$LEANDIR/TwistEaterGeneral.lean" "$MUTB3" eaterqzbend '  q_z : Q.q z = -1' '  q_z : Q.q z = 1' 98 "KERNEL-ACCEPTED TwistEaterGeneral theorems=40 errors=0" cc_lean run_mut_lean
dk_tooth "$LEANDIR/TwistEaterGeneral.lean" "$MUTB3" eatergapbend '  gap : ∀ g, g ≠ 1 → q g ≤ 1 - δ' '  gap : ∀ g, g ≠ 1 → q g ≤ 1' 98 "KERNEL-ACCEPTED TwistEaterGeneral theorems=40 errors=0" cc_lean run_mut_lean
export MUT_STEM=TowerStep DK_BASE_RUN="$B/run.TowerStep.txt"
dk_tooth "$LEANDIR/TowerStep.lean" "$MUTB3" towerhalfbend 'theorem abs_log_le_two_abs_sub_one (x : ℝ) (hx : 1 / 2 ≤ x)' 'theorem abs_log_le_two_abs_sub_one (x : ℝ) (hx : 0 ≤ x)' 99 "KERNEL-ACCEPTED TowerStep theorems=4 errors=0" cc_lean run_mut_lean
dk_tooth "$LEANDIR/TowerStep.lean" "$MUTB3" towertwobend '      ≤ 2 \* ((∑ t, if reads t then (1 : ℝ) else 0) \* (∑ t, di t) \* α ^ R / (1 - α) / mi) := by' '      ≤ 1 * ((∑ t, if reads t then (1 : ℝ) else 0) * (∑ t, di t) * α ^ R / (1 - α) / mi) := by' 99 "KERNEL-ACCEPTED TowerStep theorems=4 errors=0" cc_lean run_mut_lean
export MUT_STEM=Tower DK_BASE_RUN="$B/run.Tower.txt"
dk_tooth "$LEANDIR/Tower.lean" "$MUTB3" towercovbend '    cov W f g = gibbs W (condCovB W blk b f g) + cov W (condExpB W blk b f) (condExpB W blk b g) := by' '    cov W f g = gibbs W (condCovB W blk b f g) - cov W (condExpB W blk b f) (condExpB W blk b g) := by' 101 "KERNEL-ACCEPTED Tower theorems=8 errors=0" cc_lean run_mut_lean
dk_tooth "$LEANDIR/Tower.lean" "$MUTB3" towersumbend '    |cov W f g| ≤ K₀ + K₁ := by' '    |cov W f g| ≤ K₀ := by' 101 "KERNEL-ACCEPTED Tower theorems=8 errors=0" cc_lean run_mut_lean
export DK_BASE_RUN="$RUNZ2T"
dk_tooth "$Z2TUBE" "$MUTZ2T" z2twistbend '((i == 0 && j == 0 && flip == 1) ? -1 : (' '((i == 0 \&\& j == 0 \&\& flip == 1) ? 1 : (' 102 'Z2TUBE L=2 beta=1 lam=177079.035298 lam_tw=40816.6976611 m=0.230499887197 minus_ln_m=1.467504906' cc_z2tube run_mut_z2tube
dk_tooth "$Z2TUBE" "$MUTZ2T" z2hammingbend 'acc += exp(beta \* (2 \* L \* L - 2 \* k))' 'acc += exp(beta * (2 * L * L - k))' 102 'Z2TUBE L=2 beta=1 lam=177079.035298 lam_tw=40816.6976611 m=0.230499887197 minus_ln_m=1.467504906' cc_z2tube run_mut_z2tube
dk_control "$Z2TUBE" "$MUTZ2T" '^# gawk traps honoured: 0 - x never -x; arrays named past the builtins; one BEGIN scope, names read whole\.' '# gawk traps honoured (comment control): 0 - x never -x; arrays named past the builtins; one BEGIN scope, names read whole.' "$DK_BASE_RUN" cc_z2tube run_mut_z2tube
export DK_BASE_RUN="$RUNISG"
dk_tooth "$ISINGT" "$MUTISG" isingnnbend 'h += 2 \* CB \* s }' 'h += CB * s }' 103 'ISING-K1 K1=0.297945 (alpha1 = 1) against K0=0.255413: K1/K0=1.1665 K1/Kc=0.6761 GAIN' cc_ising run_mut_ising
dk_tooth "$ISINGT" "$MUTISG" isingfourbend 'CC = (f0 - f2 + 2 \* CB) / 2' 'CC = (f0 - f2 + CB) / 2' 103 'ISING-K1 K1=0.297945 (alpha1 = 1) against K0=0.255413: K1/K0=1.1665 K1/Kc=0.6761 GAIN' cc_ising run_mut_ising
dk_control "$ISINGT" "$MUTISG" '^# gawk traps honoured: 0 - x never -x; arrays named past the builtins; one BEGIN scope, names read whole\.' '# gawk traps honoured (comment control): 0 - x never -x; arrays named past the builtins; one BEGIN scope, names read whole.' "$DK_BASE_RUN" cc_ising run_mut_ising
export DK_BASE_RUN="$RUNISG2"
dk_tooth "$ISINGT2" "$MUTISG2" ising2fieldbend 'hh = 2 \* CB \* (cget(X - 1, Y - 1)' 'hh = CB * (cget(X - 1, Y - 1)' 104 'ISING2-K2 R=2 K2=0.35735 (alpha2 = 1, bisection to 1e-4) against K1=0.297945 and K0=0.255413: K2/K1=1.1994 K2/Kc=0.8109 GAIN' cc_ising2 run_mut_ising2
dk_tooth "$ISINGT2" "$MUTISG2" ising2bondbend 'JH\[b + R\] = CB + CC \* cget(X - 1, Y - 1) \* cget(X - 1, Y + 1)' 'JH[b + R] = CB - CC * cget(X - 1, Y - 1) * cget(X - 1, Y + 1)' 104 'ISING2-K2 R=2 K2=0.35735 (alpha2 = 1, bisection to 1e-4) against K1=0.297945 and K0=0.255413: K2/K1=1.1994 K2/Kc=0.8109 GAIN' cc_ising2 run_mut_ising2
dk_control "$ISINGT2" "$MUTISG2" '^# gawk traps honoured: 0 - x never -x; arrays named past the builtins; one BEGIN scope, names read whole\.' '# gawk traps honoured (comment control): 0 - x never -x; arrays named past the builtins; one BEGIN scope, names read whole.' "$DK_BASE_RUN" cc_ising2 run_mut_ising2
export DK_BASE_RUN="$RUNISG3"
dk_tooth "$ISINGT3" "$MUTISG3" ising3walshbend 'NJ1 /= 256; NJ2 /= 256; NC4 /= 256' 'NJ1 /= 128; NJ2 /= 256; NC4 /= 256' 105 'STEP-K3-PEN R=2 K3=0.4000 (scale 3 alpha_near + far tail = 1, bisection to 3e-4 in [0.2, 0.44]; the effective action truncated to NN+NNN+plaquette, the window radius R, the region beyond it not in the tail) K3/Kc=0.9076' cc_ising3 run_mut_ising3
dk_tooth "$ISINGT3" "$MUTISG3" ising3bondbend 'jv = J2 + C4 \* cget(X - 1, Y + 1) \* cget(X + 1, Y + 1)' 'jv = J2 - C4 * cget(X - 1, Y + 1) * cget(X + 1, Y + 1)' 105 'STEP scale=2 K=0.25 R=2 in: J1=0.108445 J2=0.054223 C4=-0.005835 fibre_alpha=0.239941 | alpha_near=0.382164 tail=0.006823(16 far sites) alpha_pen=0.388988 m=0.236052 ratio=0.2603' cc_ising3 run_mut_ising3
dk_control "$ISINGT3" "$MUTISG3" '^# gawk traps honoured: 0 - x never -x; arrays named past the builtins; one BEGIN scope, names read whole\.' '# gawk traps honoured (comment control): 0 - x never -x; arrays named past the builtins; one BEGIN scope, names read whole.' "$DK_BASE_RUN" cc_ising3 run_mut_ising3
export DK_BASE_RUN="$RUNTGK"
dk_tooth "$TUBEGKS" "$MUTTGK" tubegkshypbend 'if (s > 0 \&\& RK\[k\] >= r1) splus += s \* RK\[k\]' 'if (s > 0) splus += s * RK[k]' 108 'TUBE-GKS-TOTAL blocks=14 pairs=84 concluded=81 NOT-EVERY-PAIR' cc_tubegks run_mut_tubegks
dk_tooth "$TUBEGKS" "$MUTTGK" tubegksresbend 'if (RESSU2 == "") RESSU2 = 1e-5' 'if (RESSU2 == "") RESSU2 = 1e-3' 108 'TUBE-GKS-TOTAL blocks=14 pairs=84 concluded=81 NOT-EVERY-PAIR' cc_tubegks run_mut_tubegks
dk_control "$TUBEGKS" "$MUTTGK" '^# gawk traps honoured: 0 - x never -x; arrays named past the builtins\.' '# gawk traps honoured (comment control): 0 - x never -x; arrays named past the builtins.' "$DK_BASE_RUN" cc_tubegks run_mut_tubegks
export DK_BASE_RUN="$RUNISG4"
dk_tooth "$ISINGT4" "$MUTISG4" ising4meanbend 'TJ\[i\] = (nrd > 0) ? sum / nrd : 0' 'TJ[i] = (nrd > 0) ? sum : 0' 107 'KAT4 reader: types=200 NN err=4.16e-17 NNN err=1.39e-17 PLAQ err=8.67e-18 other max=1.99e-17 spread=1.39e-17 evenl1=0.674010 oddl1=1.14e-16 EXACT' cc_ising4 run_mut_ising4
dk_tooth "$ISINGT4" "$MUTISG4" ising4multbend 'far = FARIDX\[4, 2\]; mult = 8' 'far = FARIDX[4, 2]; mult = 4' 107 'STEP4 scale=5 K=0.44 R=2 in: types=200 l1=0.419772 fibre_crude=0.329531 | alpha_near=0.485512 tail_ref=0.002935 tail_min=0.012105(cfg 53) alpha_pen=0.497617 m=0.021810 mfine=0.061688 ratio=22.4443' cc_ising4 run_mut_ising4
dk_control "$ISINGT4" "$MUTISG4" '^# gawk traps honoured: 0 - x never -x; arrays named past the builtins; one BEGIN scope, names read whole\.' '# gawk traps honoured (comment control): 0 - x never -x; arrays named past the builtins; one BEGIN scope, names read whole.' "$DK_BASE_RUN" cc_ising4 run_mut_ising4
export DK_BASE_RUN="$RUNFC"
dk_tooth "$FIBCERT" "$MUTFC" fcb2bend '    bnd += 4 \* C4 \* C4 \* s }' '    bnd += 2 * C4 * C4 * s }' 110 'FIBRE-CERT K=0.3 TOTAL=0.926502 = field 0.765634 + bond 0.160868 + remainder 3.241e-13; near window (the 15 sites of fibre_influence) field 0.733104 bond 0.148566 near 0.881670; CERTIFIED (sum < 1)' cc_fibcert run_mut_fibcert
dk_tooth "$FIBCERT" "$MUTFC" fcfieldbend 'fld += J1 \* J1 \* wget(wfun, OP\[i\] + P - OP\[a\], OQ\[i\] + Q - OQ\[a\])' 'fld += J1 * wget(wfun, OP[i] + P - OP[a], OQ[i] + Q - OQ[a])' 110 'FIBRE-CERT K=0.3 TOTAL=0.926502 = field 0.765634 + bond 0.160868 + remainder 3.241e-13; near window (the 15 sites of fibre_influence) field 0.733104 bond 0.148566 near 0.881670; CERTIFIED (sum < 1)' cc_fibcert run_mut_fibcert
dk_control "$FIBCERT" "$MUTFC" '^# gawk traps honoured: 0 - x never -x; arrays named past the builtins; no parameter named after a builtin\.' '# gawk traps honoured (comment control): 0 - x never -x; arrays named past the builtins; no parameter named after a builtin.' "$DK_BASE_RUN" cc_fibcert run_mut_fibcert
export DK_BASE_RUN="$RUNMK"
dk_tooth "$MKFLOW" "$MUTMK" mkcgbend 'for (k = abs(m - n); k <= m + n \&\& k <= NMAX; k += 2) OUT\[k\] += acc / (k + 1)' 'for (k = abs(m - n); k <= m + n \&\& k <= NMAX; k += 1) OUT[k] += acc / (k + 1)' 111 'MK-FLOW d=4 beta=2.3 K*=8 (steps to beta_eff < 0.131) rises=1 final_beta_eff=0.034401026 REACHES-STRONG-COUPLING-WITH-RISES' cc_mkflow run_mut_mkflow
dk_tooth "$MKFLOW" "$MUTMK" mkpowbend 'cgprod(P2, P2, P4); z = P4\[0\]; for (k = 0; k <= NMAX; k++) CN\[k\] = (P4\[k\] / z) ^ 4 }' 'cgprod(P2, P2, P4); z = P4[0]; for (k = 0; k <= NMAX; k++) CN[k] = (P4[k] / z) ^ 3 }' 111 'MK-HK-STEP beta=40 after one step: c_1=0.962966796370 (predicted 0.962968695482, residual -1.899e-06) c_2=0.904267319542 (predicted 0.904272071339, residual -4.752e-06) c_3=0.828050019176 (predicted 0.828058168709, residual -8.150e-06); the width read from c_1: t1=0.025157565, t1 - t - t^2/4 = 1.315e-06, over t^3 = 0.08414 (the cubic coefficient; 1/12 = 0.08333)' cc_mkflow run_mut_mkflow
dk_control "$MKFLOW" "$MUTMK" '^# gawk traps honoured: 0 - x never -x; arrays named past the builtins; no parameter named after a builtin; exp guarded against underflow\.' '# gawk traps honoured (comment control): 0 - x never -x; arrays named past the builtins; no parameter named after a builtin; exp guarded against underflow.' "$DK_BASE_RUN" cc_mkflow run_mut_mkflow
export MUT_STEM=TowerChain DK_BASE_RUN="$B/run.TowerChain.txt"
dk_tooth "$LEANDIR/TowerChain.lean" "$MUTB3" chainsumbend '      ChainOK W blk f g bs Ks Kfin → |cov W f g| ≤ Ks.sum + Kfin := by' '      ChainOK W blk f g bs Ks Kfin → |cov W f g| ≤ Kfin := by' 112 "KERNEL-ACCEPTED TowerChain theorems=3 errors=0" cc_lean run_mut_lean
dk_tooth "$LEANDIR/TowerChain.lean" "$MUTB3" chainnilbend '    ChainOK W blk f g \[\] \[\] Kfin ↔ |cov W f g| ≤ Kfin := Iff.rfl' '    ChainOK W blk f g [] [] Kfin ↔ |cov W f g| ≤ 2 * Kfin := Iff.rfl' 112 "KERNEL-ACCEPTED TowerChain theorems=3 errors=0" cc_lean run_mut_lean
export MUT_STEM=TwistEaterSharp DK_BASE_RUN="$B/run.TwistEaterSharp.txt"
dk_tooth "$LEANDIR/TwistEaterSharp.lean" "$MUTB3" sharphypbend 'theorem eater_law_sharp (e : Eater G Q) (z : ℝ) (hz : 1 ≤ z) :' 'theorem eater_law_sharp (e : Eater G Q) (z : ℝ) (hz : 0 ≤ z) :' 100 "KERNEL-ACCEPTED TwistEaterSharp theorems=7 errors=0" cc_lean run_mut_lean
dk_tooth "$LEANDIR/TwistEaterSharp.lean" "$MUTB3" sharpnonnegbend 'theorem Wsum_nonneg (z : ℝ) (hz : 0 < z) : 0 ≤ Wsum Q z :=' 'theorem Wsum_nonneg (z : ℝ) (hz : 0 < z) : 1 ≤ Wsum Q z :=' 100 "KERNEL-ACCEPTED TwistEaterSharp theorems=7 errors=0" cc_lean run_mut_lean
export DK_BASE_RUN="$RUNKF"
dk_tooth "$KAUF" "$MUTKF" gammasignbend 'if (l == 0) g = 2 \* (K - kstar(K)); else g = acosh(x)' 'if (l == 0) g = 2 * (kstar(K) - K); else g = acosh(x)' 113 'KAUF-PIN L=4 K=0.3 sector=pp pattern=1,1,1,1' cc_kaufman run_mut_kaufman
dk_tooth "$KAUF" "$MUTKF" movingconstbend 'function logA(z, K) { return log(2) + 0.5 \* log(cosh_(2 \* z \* K)) }' 'function logA(z, K) { return log(2) + 0.25 * log(cosh_(2 * z * K)) }' 113 'KAUF-STEP K=Kc L=128 alpha=1.598779529782714253 alpha_minus=1.598728872072727604' cc_kaufman run_mut_kaufman
dk_control "$KAUF" "$MUTKF" 'gawk traps honoured: 0 - x never -x; no array named after a builtin\.' 'gawk traps honoured (comment control): 0 - x never -x; no array named after a builtin.' "$DK_BASE_RUN" cc_kaufman run_mut_kaufman
export DK_BASE_RUN="$RUNMG"
dk_tooth "$MKGAP" "$MUTMG" descentbend 'Nn\[n\] = Hp\[n\] \* cc \* cc \* cc; Dk\[n\]' 'Nn[n] = Hp[n] * cc * cc; Dk[n]' 114 'MKGAP-2PT beta=2.3 level=2 dist=2 c_1=2.035283e-01 Gser=7.020041555839e-07' cc_mkgap run_mut_mkgap
dk_tooth "$MKGAP" "$MUTMG" influencebend 'Rk\[n\] = cc \* cc \* cc \* Tn\[n\]' 'Rk[n] = cc * cc * Tn[n]' 114 'MKGAP-2PT beta=2.3 level=2 dist=2 c_1=2.035283e-01 Gser=7.020041555839e-07' cc_mkgap run_mut_mkgap
dk_control "$MKGAP" "$MUTMG" 'gawk traps honoured: 0 - x never -x; no array named after a builtin; exp guarded\.' 'gawk traps honoured (comment control): 0 - x never -x; no array named after a builtin; exp guarded.' "$DK_BASE_RUN" cc_mkgap run_mut_mkgap
export MUT_STEM=MassGapAssembly DK_BASE_RUN="$B/run.MassGapAssembly.txt"
dk_tooth "$LEANDIR/MassGapAssembly.lean" "$MUTB3" fibretermbend '      ≤ ε + gibbs (coarseW W blk) (fibreMean W blk g)' '      ≤ ε / 2 + gibbs (coarseW W blk) (fibreMean W blk g)' 121 "KERNEL-ACCEPTED MassGapAssembly theorems=8 errors=0" cc_lean run_mut_lean
dk_tooth "$LEANDIR/MassGapAssembly.lean" "$MUTB3" totalcovsignbend '      = gibbs (coarseW W blk) (fibreCov W blk f g)' '      = gibbs (coarseW W blk) (fibreCov W blk f g) + 1' 121 "KERNEL-ACCEPTED MassGapAssembly theorems=8 errors=0" cc_lean run_mut_lean
export MUT_STEM=PerfectDecimation DK_BASE_RUN="$B/run.PerfectDecimation.txt"
dk_tooth "$LEANDIR/PerfectDecimation.lean" "$MUTB3" coverrulebend '  else if x4 = x1 ∧ x3 ≠ x1 then 1' '  else if x4 = x1 ∧ x3 ≠ x1 then 3' 122 "KERNEL-ACCEPTED PerfectDecimation theorems=4 errors=0" cc_lean run_mut_lean
dk_tooth "$LEANDIR/PerfectDecimation.lean" "$MUTB3" covercountbend 'theorem perfect_cover : ∀ s : Fin 16, ∀ i j : Fin 4, i < j → coverCount s i j = 1 := by decide' 'theorem perfect_cover : ∀ s : Fin 16, ∀ i j : Fin 4, i < j → coverCount s i j = 2 := by decide' 122 "KERNEL-ACCEPTED PerfectDecimation theorems=4 errors=0" cc_lean run_mut_lean
export DK_BASE_RUN="$DCERT"
dk_tooth STDLIB/scripts/aperanton_decimation_cert.awk "$MUTB3" medcountbend '    row = (12 \* cdir + 90 \* cmed) \* (1 + PAD);  # the proved pass' '    row = (12 * cdir + 89 * cmed) * (1 + PAD);  # the proved pass' 123 "DECIMATION-CERT beta0=0.2410 ROW_hi=0.996296731 closes=1 prec=256 pad=1e-50 constants=proved (Turan termwise; T<=m/2; MAD 2/(3pi) of record)" cc_dcert run_mut_dcert
export DK_BASE_RUN="$DCERT"
dk_tooth STDLIB/scripts/aperanton_decimation_cert.awk "$MUTB3" turanbend '    M5 = m_hi(5 \* b); T6 = m_hi(6 \* b) / 2; D5 = M5 \* M5 / 3;' '    M5 = m_hi(5 * b); T6 = m_hi(6 * b) / 2; D5 = M5 * M5 / 4;' 123 "DECIMATION-CERT beta0=0.2410 ROW_hi=0.996296731 closes=1 prec=256 pad=1e-50 constants=proved (Turan termwise; T<=m/2; MAD 2/(3pi) of record)" cc_dcert run_mut_dcert
export DK_BASE_RUN="$DCERT"
dk_tooth STDLIB/scripts/aperanton_decimation_cert.awk "$MUTB3" certrhobend '    rho = (3 \* exp_hi(om) - 1) / 2;  # the proved pass' '    rho = exp_hi(om);  # the proved pass' 123 "DECIMATION-CERT beta0=0.2410 ROW_hi=0.996296731 closes=1 prec=256 pad=1e-50 constants=proved (Turan termwise; T<=m/2; MAD 2/(3pi) of record)" cc_dcert run_mut_dcert
export MUT_STEM=CrossoverCriterion DK_BASE_RUN="$B/run.CrossoverCriterion.txt"
dk_tooth "$LEANDIR/CrossoverCriterion.lean" "$MUTB3" sharpfactorbend '    Interdep (tilt W δ) (fun s t => Real.exp (o s) \* C s t + (1 - Real.exp (-Δ s t))) := by' '    Interdep (tilt W δ) (fun s t => C s t + (1 - Real.exp (-Δ s t))) := by' 115 "KERNEL-ACCEPTED CrossoverCriterion theorems=19 errors=0" cc_lean run_mut_lean
dk_tooth "$LEANDIR/CrossoverCriterion.lean" "$MUTB3" tiltboundbend '    (ho : Osc ρ o) : tv p (ptilt p ρ) ≤ 1 - Real.exp (-o) := by' '    (ho : Osc ρ o) : tv p (ptilt p ρ) ≤ (1 - Real.exp (-o)) / 2 := by' 115 "KERNEL-ACCEPTED CrossoverCriterion theorems=19 errors=0" cc_lean run_mut_lean
export MUT_STEM=UVInterface DK_BASE_RUN="$B/run.UVInterface.txt"
dk_tooth "$LEANDIR/UVInterface.lean" "$MUTB3" uniformrowbend '    ∑ t, (Real.exp (o n s) \* C s t + (1 - Real.exp (-Δ n s t))) ≤ α :=' '    ∑ t, (Real.exp (o n s) * C s t) ≤ α :=' 117 "KERNEL-ACCEPTED UVInterface theorems=3 errors=0" cc_lean run_mut_lean
dk_tooth "$LEANDIR/UVInterface.lean" "$MUTB3" interfaceoscbend '  tilt : ∀ n, ∃ δ : (S → G) → ℝ, (∀ ω, Wn n ω = W₀ ω \* Real.exp (δ ω)) ∧ OscBound δ (o n) ∧ MixedDiff δ (Δ n)' '  tilt : ∀ n, ∃ δ : (S → G) → ℝ, (∀ ω, Wn n ω = W₀ ω * Real.exp (δ ω)) ∧ OscBound δ (fun _ => 0) ∧ MixedDiff δ (Δ n)' 117 "KERNEL-ACCEPTED UVInterface theorems=3 errors=0" cc_lean run_mut_lean
export MUT_STEM=Z2Chain DK_BASE_RUN="$B/run.Z2Chain.txt"
dk_tooth "$LEANDIR/Z2Chain.lean" "$MUTB3" strongrefusebend 'theorem selfDual_refuses_strong : ¬ ((13 : ℝ) / 15 < selfDual) := by' 'theorem selfDual_refuses_strong : ¬ ((13 : ℝ) / 40 < selfDual) := by' 118 "KERNEL-ACCEPTED Z2Chain theorems=11 errors=0" cc_lean run_mut_lean
dk_tooth "$LEANDIR/Z2Chain.lean" "$MUTB3" fixedpointbend 'theorem dualVar_selfDual : dualVar selfDual = selfDual := by' 'theorem dualVar_selfDual : dualVar selfDual = 1 := by' 118 "KERNEL-ACCEPTED Z2Chain theorems=11 errors=0" cc_lean run_mut_lean
export MUT_STEM=MassGapChain DK_BASE_RUN="$B/run.MassGapChain.txt"
dk_tooth "$LEANDIR/MassGapChain.lean" "$MUTB3" chainratebend '      gibbs (Wn n) g \* ((∑ t, if reads t then (1 : ℝ) else 0) \* (∑ t, d t) \* α ^ R / (1 - α)) :=' '      gibbs (Wn n) g * ((∑ t, if reads t then (1 : ℝ) else 0) * (∑ t, d t) * α ^ (R + 1) / (1 - α)) :=' 119 "KERNEL-ACCEPTED MassGapChain theorems=3 errors=0" cc_lean run_mut_lean
dk_tooth "$LEANDIR/MassGapChain.lean" "$MUTB3" ratesignbend 'theorem physicalRate_pos (α : ℝ) (hα0 : 0 < α) (hα1 : α < 1) (R : ℕ) (hR : 0 < R) (a_c : ℝ) (hac : 0 < a_c) :' 'theorem physicalRate_pos (α : ℝ) (hα0 : 0 < α) (hα1 : α < 2) (R : ℕ) (hR : 0 < R) (a_c : ℝ) (hac : 0 < a_c) :' 119 "KERNEL-ACCEPTED MassGapChain theorems=3 errors=0" cc_lean run_mut_lean
export DK_BASE_RUN="$RUNTC"
dk_tooth "$TCERT" "$MUTTC" wilsonrowbend '  dn(); Blo = exp(6 \* osclo) \* 18 \* (4 / (3 \* PIHI)) \* bl + 18 \* (1 - exp(0 - 2 \* osclo))' '  dn(); Blo = exp(6 * osclo) * 17 * (4 / (3 * PIHI)) * bl + 18 * (1 - exp(0 - 2 * osclo))' 120 'TILT-CERT model=kat src=KAT-WILSON-0.3 k=1 c1=[0.074720322596553702, 0.074720322596553702] beta=[0.3, 0.3] osc=[0, 0.0063729521498821234] B=[2.2918311805232928,' cc_tiltcert run_mut_tiltcert
dk_tooth "$TCERT" "$MUTTC" tiltfloorbend '  up(); Dp = fpmax / fmin + bh; oschi = (dmaxhi - dminlo) + h \* Dp' '  up(); Dp = fpmax / fmin + bh; oschi = (dmaxhi - dminlo)' 120 'TILT-CERT model=kat src=KAT-WILSON-0.3 k=1 c1=[0.074720322596553702, 0.074720322596553702] beta=[0.3, 0.3] osc=[0, 0.0063729521498821234] B=[2.2918311805232928,' cc_tiltcert run_mut_tiltcert
dk_control "$TCERT" "$MUTTC" '^# aperanton_tilt_cert\.awk -- THE TILT BUDGET CERTIFIED: every quantity of B_k an interval' '# aperanton_tilt_cert.awk -- THE TILT BUDGET CERTIFIED (comment control): every quantity of B_k an interval' "$DK_BASE_RUN" cc_tiltcert run_mut_tiltcert
export MUT_STEM=VmfBounds DK_BASE_RUN="$B/run.VmfBounds.txt"
dk_tooth "$LEANDIR/VmfBounds.lean" "$MUTB3" turandenbend '  ((2 \* k + 4).choose k : ℚ) / (((k : ℚ) + 2) \* ((k + 1)! : ℚ) \* ((k + 3)! : ℚ))' '  ((2 * k + 4).choose k : ℚ) / (((k : ℚ) + 3) * ((k + 1)! : ℚ) * ((k + 3)! : ℚ))' 124 "KERNEL-ACCEPTED VmfBounds theorems=22 errors=0" cc_lean run_mut_lean
dk_tooth "$LEANDIR/VmfBounds.lean" "$MUTB3" lowernumbend '  ((2 \* k + 4).choose k : ℚ) \* ((k : ℚ) + 6) / (((k : ℚ) + 2) \* ((k + 1)! : ℚ) \* ((k + 3)! : ℚ))' '  ((2 * k + 4).choose k : ℚ) * ((k : ℚ) + 5) / (((k : ℚ) + 2) * ((k + 1)! : ℚ) * ((k + 3)! : ℚ))' 124 "KERNEL-ACCEPTED VmfBounds theorems=22 errors=0" cc_lean run_mut_lean
export DK_BASE_RUN="$FH"
dk_tooth STDLIB/scripts/aperanton_fontes_hessian.awk "$MUTB3" fullsetbend '  n120 = build(-1); hessian(); t120 = trace(H, 32)' '  n120 = build(0); hessian(); t120 = trace(H, 32)' 125 "  spectrum: 3.000000 x15  7.000000 x6  9.000000 x8  11.000000 x3" cc_fontes run_mut_fontes
export DK_BASE_RUN="$FP"
dk_tooth STDLIB/scripts/aperanton_fontes_peierls.awk "$MUTB3" marginalbend '  return num / den }' '  return num / den * 2 }' 125 "9587      0.025    0.111969     0.049998       2.239" cc_fontes run_mut_fontes
export DK_BASE_RUN="$FC"
dk_tooth STDLIB/scripts/aperanton_fontes_christoffel.awk "$MUTB3" ninebend '(pass == 2 ? best : 9))' '(pass == 2 ? best : 8))' 125 "M = 9.0000: theta_c = 0.5636 rad, Peierls floor (54.4 mu1 < 1) beta = 32.1, KP floor (C0 theta_c^2/(3 beta) < 0.1) beta = 11.3" cc_fontes run_mut_fontes
export MUT_STEM=CouplingSequence DK_BASE_RUN="$B/run.CouplingSequence.txt"
dk_tooth "$LEANDIR/CouplingSequence.lean" "$MUTB3" stepsignbend '    val b x₀ (k + 1) = val b x₀ k - b (k + 1) (seq b x₀ k) := by' '    val b x₀ (k + 1) = val b x₀ k + b (k + 1) (seq b x₀ k) := by' 126 "KERNEL-ACCEPTED CouplingSequence theorems=19 errors=0" cc_lean run_mut_lean
dk_tooth "$LEANDIR/CouplingSequence.lean" "$MUTB3" profilebend '      ∀ j ≤ K, X + ((K - j : ℕ) : ℝ) \* c₁ ≤ val b x₀ j ∧ val b x₀ j ≤ X + ((K - j : ℕ) : ℝ) \* c₂ := by' '      ∀ j ≤ K, X + ((K - j : ℕ) : ℝ) * c₂ ≤ val b x₀ j ∧ val b x₀ j ≤ X + ((K - j : ℕ) : ℝ) * c₂ := by' 126 "KERNEL-ACCEPTED CouplingSequence theorems=19 errors=0" cc_lean run_mut_lean
export MUT_STEM=DobrushinMeasure DK_BASE_RUN="$B/run.DobrushinMeasure.txt"
dk_tooth "$LEANDIR/DobrushinMeasure.lean" "$MUTB3" covratebend '      gibbs μ W g \* ((∑ t, if reads t then (1 : ℝ) else 0) \* (∑ t, d t) \* α ^ R / (1 - α)) := by' '      gibbs μ W g * ((∑ t, if reads t then (1 : ℝ) else 0) * (∑ t, d t) * α ^ (R + 1) / (1 - α)) := by' 116 "KERNEL-ACCEPTED DobrushinMeasure theorems=61 errors=0" cc_lean run_mut_lean
dk_tooth "$LEANDIR/DobrushinMeasure.lean" "$MUTB3" balancebend '    _ = ENNReal.ofReal (condExp μ W s f x \* zsite μ W s x) := by rw \[ENNReal.ofReal_mul hcx\]' '    _ = ENNReal.ofReal (condExp μ W s f x) := by rw [ENNReal.ofReal_mul hcx]' 116 "KERNEL-ACCEPTED DobrushinMeasure theorems=61 errors=0" cc_lean run_mut_lean
export MUT_STEM=CouplingTransient DK_BASE_RUN="$B/run.CouplingTransient.txt"
dk_tooth "$LEANDIR/CouplingTransient.lean" "$MUTB3" telescopebend '    ∑ i ∈ Finset.range m, a (k + 1 + i) = m \* c + f (k + m) - f k := by' '    ∑ i ∈ Finset.range m, a (k + 1 + i) = m * c + f (k + m) + f k := by' 127 "KERNEL-ACCEPTED CouplingTransient theorems=9 errors=0" cc_lean run_mut_lean
dk_tooth "$LEANDIR/CouplingTransient.lean" "$MUTB3" marginbend '    (K : ℕ) (X : ℝ) (hXw : Xmin + 2 \* F ≤ X) :' '    (K : ℕ) (X : ℝ) (hXw : Xmin + F ≤ X) :' 127 "KERNEL-ACCEPTED CouplingTransient theorems=9 errors=0" cc_lean run_mut_lean
export MUT_STEM=ChristoffelBound DK_BASE_RUN="$B/run.ChristoffelBound.txt"
dk_tooth "$LEANDIR/ChristoffelBound.lean" "$MUTB3" signnormbend '      (3 + 2 \* Real.sqrt 2) \* (a ^ 2 + b ^ 2 + c ^ 2 + d ^ 2) := by' '      (3 + Real.sqrt 2) * (a ^ 2 + b ^ 2 + c ^ 2 + d ^ 2) := by' 128 "KERNEL-ACCEPTED ChristoffelBound theorems=12 errors=0" cc_lean run_mut_lean
dk_tooth "$LEANDIR/ChristoffelBound.lean" "$MUTB3" sharpbend '      sq3 (Bf y0 y1 y2 y3) = ((1 + s) / 2 \* (sq3 y0 + sq3 y1 + sq3 y2 + sq3 y3)) ^ 2 := by' '      sq3 (Bf y0 y1 y2 y3) = ((1 + s) / 3 * (sq3 y0 + sq3 y1 + sq3 y2 + sq3 y3)) ^ 2 := by' 128 "KERNEL-ACCEPTED ChristoffelBound theorems=12 errors=0" cc_lean run_mut_lean
export DK_BASE_RUN="$OL1"
dk_tooth STDLIB/scripts/aperanton_oneloop_step.awk "$MUTB3" jacdropbend '  CQQ = (chg ? ldQQ : 0\.5 \* ldQQ); CSOFT = (chg' '  CQQ = 0; CSOFT = (chg' 129 "ONELOOP-STEP-HARD N=4 L=2 pL=3.1416 beta1_hard=0.539914 (with the constraint's Jacobian)" cc_ol run_ol1
export DK_BASE_RUN="$OL3"
dk_tooth STDLIB/scripts/aperanton_oneloop_step2.awk "$MUTB3" rowphasebend '    if (CHG) { pr = cos(-THB\[mu, y1\]); pi_ = sin(-THB\[mu, y1\]) } else' '    if (CHG) { pr = 1; pi_ = 0 } else' 129 "COMPOSITE-COVARIANT N=4 L1=2 L2=2 max|Q D lambda| below 1e-12 over both eps" cc_ol run_ol3
export DK_BASE_RUN="$OL3"
dk_tooth STDLIB/scripts/aperanton_oneloop_step2.awk "$MUTB3" stage2bgbend 'return APR\[nu, pos\] }' 'return (nu == 1 ? 0 : APR[nu, pos]) }' 129 "COMPOSITE-COVARIANT N=4 L1=2 L2=2 max|Q D lambda| below 1e-12 over both eps" cc_ol run_ol3
export MUT_STEM=VertexLaw DK_BASE_RUN="$B/run.VertexLaw.txt"
dk_tooth "$ROOT/LEAN/aperanton/Aperanton/VertexLaw.lean" "$MUTB3" trianglebend 'theorem vl_abcabc : vertexSum 3 \[0, 1, 2, 0, 1, 2\] = 30 := by decide +kernel' 'theorem vl_abcabc : vertexSum 3 [0, 1, 2, 0, 1, 2] = 31 := by decide +kernel' 130 "KERNEL-ACCEPTED VertexLaw theorems=130 errors=0" cc_lean run_mut_lean
dk_tooth "$ROOT/LEAN/aperanton/Aperanton/VertexLaw.lean" "$MUTB3" paulisignbend '  | _ => ⟨⟨1, 0⟩, ⟨0, 0⟩, ⟨0, 0⟩, ⟨-1, 0⟩⟩' '  | _ => ⟨⟨1, 0⟩, ⟨0, 0⟩, ⟨0, 0⟩, ⟨1, 0⟩⟩' 130 "KERNEL-ACCEPTED VertexLaw theorems=130 errors=0" cc_lean run_mut_lean
cc_vlrec(){ bash "$VLEMIT" "$1" "$2" > /dev/null 2>&1; }
run_mut_vlrec(){ if cmp -s "$1" "$ROOT/LEAN/aperanton/Aperanton/VertexLaw.lean"; then echo "VERTEXLAW-CUSTODY byte-identical"; else echo "VERTEXLAW-CUSTODY MOVED: the re-emission differs from the committed VertexLaw.lean"; fi; }
cp "$VLREC" "$MUTVL/record.base" ; echo "VERTEXLAW-CUSTODY byte-identical" > "$MUTVL/custody.base"
export DK_BASE_RUN="$MUTVL/custody.base"
dk_tooth "$MUTVL/record.base" "$MUTVL" recordbend 'S8-PAULI k=3 diagram=abcabc crossings=3 sum=30 c=5/9' 'S8-PAULI k=3 diagram=abcabc crossings=3 sum=31 c=31/54' 130 "VERTEXLAW-CUSTODY byte-identical" cc_vlrec run_mut_vlrec
export DK_BASE_RUN="$RUNKP"
dk_tooth "$KPCERT" "$MUTKP" kpcensusbend '  NF_\[6\] = 4; NF_\[10\] = 60; NF_\[12\] = 80; NF_\[14\] = 1092; NF_\[16\] = 2728; NF_\[18\] = 23508; NF_\[20\] = 80480; NF_\[22\] = 551408' '  NF_[6] = 4; NF_[10] = 60; NF_[12] = 80; NF_[14] = 1092; NF_[16] = 2728; NF_[18] = 23508; NF_[20] = 8048; NF_[22] = 551408' 131 "KP-CERT SCAN dress=page gamma=6/1 F0=20: beta* = 0.4260 (the largest beta with a certified PASS on the 2e-4 grid, alpha on the 1e-4 grid)" cc_kp run_mut_kp
dk_tooth "$KPCERT" "$MUTKP" kploadbend '  a2l = g_lo(8 \* AN, AD); a2h = g_hi(8 \* AN, AD); e2l = exp_lo(a2l); e2h = exp_hi(a2h); E2L = e2l; E2H = e2h' '  a2l = g_lo(4 * AN, AD); a2h = g_hi(4 * AN, AD); e2l = exp_lo(a2l); e2h = exp_hi(a2h); E2L = e2l; E2H = e2h' 131 "KP-CERT SCAN dress=page gamma=6/1 F0=20: beta* = 0.4260 (the largest beta with a certified PASS on the 2e-4 grid, alpha on the 1e-4 grid)" cc_kp run_mut_kp
dk_tooth "$KPCERT" "$MUTKP" kpwallbend '  if (DRESS == "page") { KUL = KL; KUH = KH } else { KUL = KL + 2 \* Z1L; KUH = KH + 2 \* Z1H }' '  if (DRESS == "page") { KUL = KL; KUH = KH } else { KUL = KL + 8 * Z1L; KUH = KH + 8 * Z1H }' 131 "KP-CERT SCAN dress=tree gamma=6/1 F0=20: beta* = 0.4378 (the largest beta with a certified PASS on the 2e-4 grid, alpha on the 1e-4 grid)" cc_kp run_mut_kp
dk_tooth "$KPLIB" "$MUTKP" kpseriesbend '  for (k = 0; k <= K; k++) { num = P ^ (2 \* k + nu); den = (2 \* Q) ^ (2 \* k + nu) \* fact(k) \* fact(k + nu)' '  for (k = 0; k <= K; k++) { num = P ^ (2 * k + nu); den = (2 * Q) ^ (2 * k + nu) * fact(k) * fact(k)' 131 "KP-CERT SCAN dress=page gamma=6/1 F0=20: beta* = 0.4260 (the largest beta with a certified PASS on the 2e-4 grid, alpha on the 1e-4 grid)" cc_kplib run_mut_kplib
dk_tooth "$KPCERT" "$MUTKP" localgammabend '    for (s = 1; s <= 8; s++) { ll = 3 \* rootm_lo(R2N\[s\] ^ 2, R2D\[s\] ^ 2, s); hh = 3 \* rootm_hi(R2N\[s\] ^ 2, R2D\[s\] ^ 2, s)' '    for (s = 1; s <= 8; s++) { ll = 2 * rootm_lo(R2N[s] ^ 2, R2D[s] ^ 2, s); hh = 2 * rootm_hi(R2N[s] ^ 2, R2D[s] ^ 2, s)' 131 "KP-CERT SCAN dress=page graded=S24-local gamma=6/1 F0=20: beta* = 0.4764 (the largest beta with a certified PASS on the 2e-4 grid, alpha on the 1e-4 grid)" cc_kp run_mut_kp
export DK_BASE_RUN="$RUNFLOOR"
dk_tooth "$FLOORCERT" "$MUTFLOOR" floorentropybend '  L20L = ln_lo(20 \* SCALE); L20H = ln_hi(20 \* SCALE); L6L = ln_lo(6 \* SCALE); L6H = ln_hi(6 \* SCALE)' '  L20L = ln_lo(19 * SCALE); L20H = ln_hi(19 * SCALE); L6L = ln_lo(6 * SCALE); L6H = ln_hi(6 * SCALE)' 132 "FLOOR-CERT beta_SF in [57.96, 57.97] (the Peierls floor with K and theta_c proved; ledger 58.0)" cc_floor run_mut_floor
dk_tooth "$FLOORCERT" "$MUTFLOOR" floorchristoffelbend '  D = 2 ^ 20; lo = 0; hi = D; cl = r2 + SCALE; ch = r2 + 1 + SCALE   # (1 + sqrt 2) on the grid' '  D = 2 ^ 20; lo = 0; hi = D; cl = r2; ch = r2 + 1   # sqrt 2 on the grid' 132 "FLOOR-CERT theta_c in [0.65631675, 0.65631771] (ledger 0.6563)" cc_floor run_mut_floor
dk_tooth "$FLOORCERT" "$MUTFLOOR" floorbesselbend '    k++; tn = tn \* zn; td = td \* zd \* k \* (k + 1)' '    k++; tn = tn * zn; td = td * zd * k * k' 132 "FLOOR-CERT s_c(107.8) in [12.049905, 12.049905] (ledger 12.050, K = 3146.9)" cc_floor run_mut_floor
export DK_BASE_RUN="$RUNBD"
dk_tooth "$BDIFF" "$MUTBD" bdifforderbend '  split($4, n, "="); nu = n\[2\] + 0; j2 = nu - 1' '  split($4, n, "="); nu = n[2] + 0; j2 = nu' 133 "BESSEL-DIFF CONCORD: two engines sharing no line agree on every read cell of the ALOGON grid" cc_bdiff run_mut_bdiff
export DK_BASE_RUN="$RUNBAND"
dk_tooth "$BANDSRC" "$MUTBAND" bandconjbend 'if (S\[s\]\.ed\[p\] < 0) q = qconj(q);' 'if (S[s].ed[p] < 0) q = q;' 134 "BAND-CERT MOEBIUS n=7 chi=0 bcycles=1: squares (0000;01) (0000;02) (0000;23) (0001;02) (0011;01) (0101;02) (0100;03) -- 201 assignments, 51 with tr(w) != 0, sign -1, 0 PART: MET" cc_band run_mut_band
dk_tooth "$BANDSRC" "$MUTBAND" bandpowbend 'long long pw = 1; for (k = 0; k < n; k++) pw \*= 4;' 'long long pw = 1; for (k = 0; k < n; k++) pw *= 2;' 134 "BAND-CERT ANNULUS n=6 chi=0 bcycles=2: squares (0000;01) (0000;02) (0000;23) (0001;02) (0001;01) (0100;03) -- 201 assignments, 12 with tr(w) != 0, sign +1, 0 PART: MET" cc_band run_mut_band
dk_tooth "$BANDSRC" "$MUTBAND" bandselectbend 'if (c == 0 && bc == 1 && !o) { if (nmob < 4) measure(np, 1); nmob++; }' 'if (c == 0 \&\& bc == 1 \&\& o) { if (nmob < 4) measure(np, 1); nmob++; }' 134 "BAND-CERT END cycles=480764 moebius=196224 annuli=277520" cc_band run_mut_band
dk_control "$BANDSRC" "$MUTBAND" '^/\* aperanton_band_cert\.c -- THE PIECE FORMULA MEASURED ON CUBICAL BANDS' '/* aperanton_band_cert.c -- THE PIECE FORMULA (comment control) MEASURED ON CUBICAL BANDS' "$RUNBAND" cc_band run_mut_band
export DK_BASE_RUN="$RUNDRESS"
dk_tooth "$DRESSSRC" "$MUTDRESS" dressadmitbend 'if (!linkU\[e\] && mult\[e\] == 1) return 0;' 'if (!linkU[e] \&\& mult[e] == 2) return 0;' 135 "DRESS-KAT counts to N=4: attached 104 6386 302260 12201399 ; admissible decorations by size 2 1 0 1" cc_dress run_mut_dress
dk_tooth "$DRESSSRC" "$MUTDRESS" dresssitebend 'double B = exp(28 \* z + 112 \* lam);' 'double B = exp(28 * z + 56 * lam);' 135 "DRESS-KAT z=0.04 D_N=1.081602560 bound=11.888392 (lambda'=0.012103, kappa_U=0.176826) HOLDS; control: fake bound 1.040000 VIOLATED (sighted)" cc_dress run_mut_dress
dk_control "$DRESSSRC" "$MUTDRESS" '^/\* aperanton_dress_kat\.c -- THE REPAIRED DRESSING LEMMA MEASURED ON A SMALL CLOSED BASE' '/* aperanton_dress_kat.c -- THE REPAIRED DRESSING LEMMA (comment control) MEASURED ON A SMALL CLOSED BASE' "$RUNDRESS" cc_dress run_mut_dress
export DK_BASE_RUN="$RUNBOX"
dk_tooth "$BOXSRC" "$MUTBOX" boxdegbend 'if (maxdeg > strength_of(cap)) {' 'if (maxdeg > strength_of(cap) + 4) {' 136 "BOX-CERT REFUSED DEGREE-EXCEEDS-DESIGN max-free-link-degree=4 strength=3" cc_box run_mut_box
dk_tooth "$BOXSRC" "$MUTBOX" boxchibend 'chi\[p\] = chebyshev(ptwoj\[p\], h\.c\[0\]); }' 'chi[p] = chebyshev(ptwoj[p], zadd(h.c[0], zint(1))); }' 136 "BOX-CERT whole set (z^4): 1/4" cc_box run_mut_box
dk_tooth "$BOXSRC" "$MUTBOX" boxprodbend 'r\.c\[1\] = zsub(zadd(zadd(zmul(p\.c\[0\], q\.c\[1\]), zmul(p\.c\[1\], q\.c\[0\])), zmul(p\.c\[2\], q\.c\[3\])), zmul(p\.c\[3\], q\.c\[2\]));' 'r.c[1] = zadd(zadd(zadd(zmul(p.c[0], q.c[1]), zmul(p.c[1], q.c[0])), zmul(p.c[2], q.c[3])), zmul(p.c[3], q.c[2]));' 136 "BOX-CERT whole set (z^4): -1/16" cc_box run_mut_box
dk_control "$BOXSRC" "$MUTBOX" '^/\* aperanton_box_cert\.c -- THE JUNCTION INTEGRAL OF A PLAQUETTE SET' '/* aperanton_box_cert.c -- THE JUNCTION INTEGRAL (comment control) OF A PLAQUETTE SET' "$RUNBOX" cc_box run_mut_box
export DK_BASE_RUN="$RUNJUN"
dk_tooth "$JUNSRC" "$MUTJUN" juncphibend 'phinv = {-1, 1}' 'phinv = {1, 1}' 136 "JUNCTION-CERT design=120 strength=11 table: 0 products and inverses outside the table, -1 present; moments: tr^2=(120+0phi)/120=1 tr^4=(240+0phi)/120=2 tr^6=(600+0phi)/120=5 tr^8=(1680+0phi)/120=14 tr^10=(5040+0phi)/120=42 tr^12=(15960+0phi)/120!=132 tr^14=(53040+0phi)/120!=429 (parts first at degree 12, strength 11: CONSISTENT)" cc_box run_mut_jun
dk_tooth "$JUNSRC" "$MUTJUN" juncindexbend 'P4\[u0\]\[u1\]\[u4\] = zmul(Wm\[4\]\[0\]\[u4\]\[u0\], Wm\[4\]\[1\]\[u4\]\[u1\]);' 'P4[u0][u1][u4] = zmul(Wm[4][0][u4][u0], Wm[4][1][u4][u0]);' 136 "JUNCTION-CERT F(2j=2, hold=identity) = 16981/202500  (sum 250395033600 over 120^6)" cc_box run_mut_jun
dk_tooth "$JUNSRC" "$MUTJUN" juncchebbend 'c2 = zsub(zmul(tr, c1), c0); c0 = c1; c1 = c2;' 'c2 = zadd(zmul(tr, c1), c0); c0 = c1; c1 = c2;' 136 "JUNCTION-CERT F(2j=2, hold=identity) = 16981/202500  (sum 250395033600 over 120^6)" cc_box run_mut_jun
dk_tooth "$JUNSRC" "$MUTJUN" stardegbend 'int d = sdeg\[v\]; dn\[v\]' 'int d = 2 * sdeg[v]; dn[v]' 136 "STAR-CERT S(K24, 2j=2) = 1/27  = 0.037037037; S^(1/8) = 0.662338 (the float reading of the exact rational)" cc_box run_mut_jun
dk_tooth "$JUNSRC" "$MUTJUN" starsumbend 'for (v = 1; v < nv; v++) { if (++idx\[v\] < dn\[v\]) break; idx\[v\] = 0; } if (v == nv) break; }' 'for (v = 2; v < nv; v++) { if (++idx[v] < dn[v]) break; idx[v] = 0; } if (v == nv) break; }' 136 "STAR-CERT S(C3, 2j=2) = 1/3  = 0.333333333; S^(1/3) = 0.693361 (the float reading of the exact rational)" cc_box run_mut_jun
dk_control "$JUNSRC" "$MUTJUN" '^/\* aperanton_junction_cert\.c -- THE OCTAHEDRON JUNCTION INTEGRAL F(g)' '/* aperanton_junction_cert.c -- THE OCTAHEDRON JUNCTION INTEGRAL (comment control) F(g)' "$RUNJUN" cc_box run_mut_jun
export DK_BASE_RUN="$RUNKPG"
dk_tooth "$KPCERT" "$MUTKP" gradedformbend 'jl = rootm_lo(Es ^ 2, 1, s); jh = rootm_hi(Es ^ 2, 1, s);' 'jl = rootm_lo(Es, 1, s); jh = rootm_hi(Es, 1, s);' 137 "s=4 [3.931112, 3.931112]" cc_kp run_mut_kpg
dk_tooth "$KPCERT" "$MUTKP" gradedsignbend 'Es = (3 ^ s + (s % 2 ? -3 : 3)) / 4;' 'Es = (3 ^ s + (s % 2 ? 3 : -3)) / 4;' 137 "s=3 [3.301927, 3.301927]" cc_kp run_mut_kpg
dk_tooth "$KPCERT" "$MUTKP" gradedprefbend 'bl = pow_lo(mul_lo(mul_lo(ggl, AL\[2\]), e2l), s); bh = pow_hi(mul_hi(mul_hi(ggh, AH\[2\]), e2h), s) }' 'bl = pow_lo(mul_lo(mul_lo(ggl, AL[2]), e2l), s); bh = pow_hi(mul_hi(mul_hi(ggh, AH[2]), e2h), s) / 3 }' 137 "KP-CERT dress=page graded=S21-J6prime+S24-table beta=4700/10000 alpha=3/1000 gamma=6/1 F0=20: kappa_U in [0.084202, 0.084202] root in [0.084202, 0.084202] u in [0.11643322, 0.11643322] u~ in [0.12666177, 0.12666183] r_hi=0.648692 LHS in [0.0010014, 0.0010014] alpha=0.0029999 -> PASS" cc_kp run_mut_kpg
dk_tooth "$KPCERT" "$MUTKP" gradedsupbend 'GTL\[s\] = (jl < TTL\[s\]) ? jl : TTL\[s\]; GTH\[s\] = (jh < TTH\[s\]) ? jh : TTH\[s\] }' 'GTL[s] = (jl < TTL[s]) ? TTL[s] : jl; GTH[s] = (jh < TTH[s]) ? TTH[s] : jh }' 137 "s=5 [4.149485, 4.149485]" cc_kp run_mut_kpg
export DK_BASE_RUN="$RUNSE"
dk_tooth "$SESRC" "$MUTSE" seconjbend 'b = conj ? negm(q\[1\]) : q\[1\], c = q\[2\]' 'b = q[1], c = q[2]' 138 "STAR-EXACT KAT 21 met, 0 parted of 21" cc_se run_mut_se
dk_tooth "$SESRC" "$MUTSE" serotbend 'M\[5\] = mulm(two, subm(mulm(c, d), mulm(a, b)));' 'M[5] = mulm(two, addm(mulm(c, d), mulm(a, b)));' 138 "STAR-EXACT KAT 21 met, 0 parted of 21" cc_se run_mut_se
dk_tooth "$SESRC" "$MUTSE" sescalebend 'Pm\[n\] = (u32)mulm(Pm\[n\], INV120);' 'Pm[n] = (u32)mulm(Pm[n], INV2);' 138 "STAR-EXACT KAT 21 met, 0 parted of 21" cc_se run_mut_se
dk_tooth "$SESRC" "$MUTSE" secgbend 'w\[s2\] += m\[s\]; top += t\[i\];' 'w[s2] += 2 * m[s]; top += t[i];' 138 "STAR-EXACT KAT 21 met, 0 parted of 21" cc_se run_mut_se
dk_tooth "$SESRC" "$MUTSE" sedotbend 's\[0\]\[0\] += x0 \* y0; s\[0\]\[1\]' 's[0][0] += x0 * y0 + 1; s[0][1]' 138 "STAR-EXACT KAT 21 met, 0 parted of 21" cc_se run_mut_se
dk_tooth "$SESRC" "$MUTSE" setablebend 'v\[3\] = mulm(s\[2\] > 0 ? phinv : negm(phinv), INV2);' 'v[3] = mulm(s[2] > 0 ? PHI : negm(PHI), INV2);' 138 "STAR-EXACT KAT 21 met, 0 parted of 21" cc_se run_mut_se
dk_tooth "$SESRC" "$MUTSE" secrtbend 't = mulm(subm(s\[j\] % P, (u64)(X % P)), invm((u64)(M % P)));' 't = mulm(addm(s[j] % P, (u64)(X % P)), invm((u64)(M % P)));' 138 "STAR-EXACT KAT 21 met, 0 parted of 21" cc_se run_mut_se
dk_control "$SESRC" "$MUTSE" '^/\* aperanton_star_exact\.c -- THE VERTEX STAR S(G) BY INTERTWINERS, EXACT' '/* aperanton_star_exact.c -- THE VERTEX STAR (comment control) S(G) BY INTERTWINERS, EXACT' "$RUNSE" cc_se run_mut_se
dk_say "the fixing door: $(grep -c . "$B/fixings.log" || true) of this run's mutant readings were fixings (STDLIB/build/aperanton/fixings, keyed by the mutant's bytes, toolchain and imports; the notices in $B/fixings.log and never in a reading -- runs v and w were RED by that notice alone)"
dk_teeth_pin 210
dk_control "$MOMEMIT" "$MUTMOM" '^  print "  APERANTON -- THE BOUNDLESS, stage A8: THE SPECTRAL LAW OF THE WILSON LOOP ON THE 2 x 2 TORUS OF Z2' '  print "  APERANTON -- THE BOUNDLESS, stage A8 (comment control): THE SPECTRAL LAW OF THE WILSON LOOP ON THE 2 x 2 TORUS OF Z2' "$RUNMOM" cc_mom run_mut_mom

dk_green "ΑΠΕΡΑΝΤΟΝ THE BOUNDLESS Α0+Α1+Α2+Α3+Α4+Α5+Α6+Α8+Β1+Β2+Β3+Β4+W4+W7 CUSTODY GREEN: 135 arms, $DK_BLED/$DK_TEETH teeth -- THE STAR BY INTERTWINERS; THE GRADED COLUMN; THE JUNCTION INTEGRAL BY A DESIGN; THE DRESSING LEMMA'S COUNT; THE PIECE FORMULA ON CUBICAL BANDS; THE BESSEL CONCORDANCE; THE ONE-BLOCK FLOOR CERTIFIED; C2, THE KOTECKÝ–PREISS CERTIFICATE; D3, THE VERTEX LAW'S TABLE IN THE KERNEL; THE ONE-LOOP INSTRUMENTS' CONTROLS; Σ1b's WINDOW FROM A BOUNDED TRANSIENT; THE CHRISTOFFEL CONSTANT IN THE KERNEL; THE COMPACT TIER IN THE KERNEL; Σ1b's EASY HALF IN THE KERNEL; LEMMA 8.6 IN THE KERNEL; THE ONE-BLOCK CONSTANTS RE-DERIVED; THE TILT BUDGET CERTIFIED ON THE HIERARCHICAL MODEL; THE CHAIN AS ONE THEOREM IN THE KERNEL; THE Z2 REHEARSAL IN THE KERNEL; THE UV INTERFACE IN THE KERNEL; THE CROSSOVER CRITERION IN THE KERNEL; THE PERFECT DECIMATION CERTIFIED AT 0.241; THE PERFECT DECIMATION IN THE KERNEL; THE ASSEMBLY WITH THE FIBRE IN THE KERNEL; THE HIERARCHICAL MODEL DECAYS BY AREA; THE EXACT INTERPOLATED FLOW OF THE CONTROL HAS ITS FIXED POINT OFF THE TRANSITION; THE EATER LAW'S ROW SUM EXACT IN THE KERNEL; THE TOWER CHAIN IN THE KERNEL; THE MIGDAL-KADANOFF FLOW DESCENDS AT ONE QUARTER PER STEP AND ITS U(1) CONTROL AT e^{-c beta}; THE SECOND SCALE CERTIFIED ON THE CONTROL; THE INTERACTION CARRIED WHOLE ON THE ONSAGER CONTROL; THE TUBE THEOREM ON THE OVERLAP RECORDS; THE ONSAGER TOWER'S REACH MEASURED WITH ITS TAIL; THE ONSAGER TOWER REACHES AT ITS SECOND SCALE; THE ONSAGER TOWER GAINS AT ITS FIRST SCALE; THE Z2 TUBE'S WINDING TWIST A PERIMETER LAW IN BOTH PHASES; THE TOWER'S COMPOSITION IN THE KERNEL; THE TOWER'S STEP IN THE KERNEL; THE EATER'S LAW FOR EVERY FINITE GROUP IN THE KERNEL; LAMBDA5(i) THE FLUX-CLASS-RESOLVED SHAPE SURVIVES THE EATER; THE NON-ABELIAN GKS-II FOR CHARACTERS AND KOVACS-TOMBOULIS' FACTORISATION READ EXACTLY; THE TWIST EATER'S LAW IN THE KERNEL (the vortex string's rate tends to one); THE FLAT MEASURE BY AN EXACT ROAD; THE EVEN SECTOR FAILS THE SIMON-LIEB SHAPE AT EVERY COUPLING; THE BOX GROWN BY A SECOND ROAD (4x4x4 certified to beta_I = 0.12); THE SIMON-LIEB SHAPE ON THE VORTEX SECTOR (Z2 the theorem met, Q8 fails at beta = 2, SU(2) holds at beta = 1); THE PRODUCT FIBER IN ITS OWN METRIC (1.3255 at 13/15: no certified first step); THE FINITE-TO-INFINITE CRITERION ON THE CONTROL (Simon-Lieb on the dual, behind Dobrushin-on-the-dual at 27 spins, the box the instrument that grows); THE DESIGN STRENGTHS BY THE CLASS-DATA ROAD AND THE DIHEDRAL FAMILY IN THE KERNEL (DesignDihedral 18); T3 CORRECTED (the design residue priced at the link; the freezing law compounded); SU(2) ITSELF ON THE CELL (the quadrature road: the design bridge's target read); THE FROZEN LIMITS BY COUNTING (winding = sheet for every shadow: 3/11, 1/21, 1/14, 1/37); W10(b) THE NONABELIAN CELLS (the shadows' hinge: the winding twist monotone, the sheet twist not on Q8 at L >= 3, the twist eaten at zero action); W10(b) THE ABELIAN CONTROL (the Z2 hinge's twisted ratio monotone in the coupling at every L: Tomboulis' (5.15) on a cell is this monotonicity, Griffiths for the abelian cell, the nonabelian cell staked); STAGE IV'S SECOND NUMBER (the one-plaquette block: the proxy crossing 0.147, below decimation's 0.197); W10(a) THE EXACT DECIMATION FLOWS (the Migdal-Kadanoff maps exact in the character basis; the Z2 control parts its phases between two fixed points; SU(2) ends STRONG from every coupling in the scheme, a reading of the approximate flow and no proof); THE VARIANCE THEOREM'S COMBINATORIAL CORE AND KADANOFF'S BOUNDS IN THE KERNEL (NeumannCoeff 13, BondMoving 6); STAGE IV'S AND STAGE III'S FIRST NUMBERS (the SU(2) one-link Dobrushin coefficient: the flip exactly L_1(beta)/I_1(beta), the one-link criterion failing above beta* = 0.13103 and holding below 1/9 by the variance theorem, both theorems, pi/24 under Lemma M, read; the BI flip's class form, its crossing 0.13666, the design residue 4.1 percent on the total-variation observable) and THE SIDE-3 INSTANCE ON THE LINEAR CERTIFICATE (the split 240 + 240 + 6, the dual facts, the adjacency, the sector decay and the twist translations at side three, every decide linear in the volume), W6 THE FOUR-TORUS OF ANY SIDE (the geometry, the split, the dual sector, the wall level, THE SECTOR DECAY and THE TWO-POINT FACTORIZATION at every side) and W7' THE WEAK-COUPLING CLAUSE ASSEMBLED AT ANY SIDE (the vacuum two-point bound from the sectors' factorization and the between-sector deviation), the every-L lemmas (the incident forms, the list-form echelon certificate, THE LINEAR GEOMETRY: the link lists, the consistency decides, the xor identities, the listed cubes closed by the double count) and T3 THE DESIGN THEOREM (BT, BO, BI decided as groups by two linear certificates and as 5-, 7-, 11-designs of exact strength, the Molien value at the next spin); T5 THE EXACT ONE-SITE COEFFICIENT (ZedEven.lean), W5 THE DUAL SECTOR AS A FACTOR SYSTEM (TorusSys.lean), THE DECIMATED CRITERION (the constrained criterion's region doubled: the decimation well defined to beta in (0.1116, 0.1438)); THE CONSTRAINED CRITERION'S FIRST PROBE (the plaquette block exact by min-cost flow; the product-constrained form refuted and withdrawn, the decimation form staked); THE BLOCK COMPARISON THEOREM (Block.lean: Dobrushin over blocks, the row form); THE BLOCK CRITERION on the Z2 control (the one-link known answer met, the star block at 0.8027 under Dobrushin-Shlosman against 0.9949 one-site, exact); THE SELF-DUALITY OF THE FOUR-TORUS DECIDED, THE VACUUM SECTOR AS A DUAL-SECTOR MIXTURE WITH ITS COVARIANCE SPLIT (vacuum_cov_le), AND THE FIBRE COUNT (sum_comp_linear); THE MASS GAP OF THE Z2 WILSON SLAB AT STRONG COUPLING WITH THE PER-SITE COEFFICIENT (3m + 2)(1 - y)/(1 + y) (transfer_gap_sharp: beta < 0.1257 at d = 3, 0.0716 at d = 4, 8.0x and 6.9x the LGT kernel's thresholds), the uniform gap of the X-transfer slab under any interdependence matrix with Dobrushin's comparison theorem by levels and the gap read off the decay, the realification of unitary representations, the scaling target as a def, the duality on codes with Wegner's dual variable and the mixture lemma's epsilon-form, two-dimensional Yang-Mills on any coefficient ring decided on Q8, the four-torus's ranks 45 / 45 / 51 with its echelon certificates re-emitted byte for byte and decided, and THE SECTOR SPLIT OF THE FOUR-TORUS AS A THEOREM (torus4Split); the Wilson kernel of a faithful representation positive definite by separation, W(1) > 0 discharged for faithful actions; the Wilson action's kernel positive semidefinite by the closed cone; the polynomial actions' kernels positive semidefinite by the Schur product; the nonabelian Wilson loop's static potential at least the gap on any lattice cross-section for any finite group, the linear action's hypotheses discharged from a real orthogonal representation; the static potential a gap (strictly positive, at least the finite-volume mass gap of its sector; the Z2 instance hypothesis-free) and the spectral law decided by the kernel on ΣΤΡΟΦΙΓΞ's integers; the spectral law of the Wilson loop and the x-transfer model's infinite slab, the string tension of every finite group on every finite cross-section; the Z2 kernel instance of the centre's inversion theorem re-emitted from ΣΤΡΟΦΙΓΞ's committed dump and reduced by the bare kernel at both couplings; the finite core of the flux-sector results re-emits byte for byte from the record with decide as its only proof term, its literals the record's; the kernel on this desktop reduced all 15 theorems (OD:2) and refused every bent emission; Theorem T and MacWilliams in general form, even-time reflection positivity, the transfer theorem whole (the spectral sum, Perron's simple dominant root with its residual law, the string energy as the exact limit of two Perron roots, the mass gap on every finite cross-section), Griffiths' inequalities with the coupling monotonicity, the infinite-volume Wilson expectation, THE STRING TENSION'S EXISTENCE with its strong-coupling bound, and the inversion theorem of the centre elaborated above Mathlib with no sorry; the row's verdict stays a foreign hand's (OD:1)"
