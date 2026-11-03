#!/usr/bin/env bash
# cei_gate.sh -- THE CONSTRAINED EXACT INTEGRATOR'S GATE: the single-path FACE FIBRE read exactly at beta = 2.2 by substitution on EI's
# engine (THE CROSSING CAMPAIGN §31.10-§31.12, DOCS/III-THE-CROSSING-CAMPAIGN-OF-THE-YANG-MILLS-GAP.md, the stakes landed at c39d3acda
# strictly before the engine at 5e4301fed; the sources under STDLIB/build/aperanton/cei/).  Every known answer an arm, every pin copied
# from a run; every tooth against a computation (law 24), bent in the fragment it attacks and rebuilt through the one inserter; the comment
# control; the tooth count pinned against a literal.  Run it PLAIN (bash STDLIB/scripts/cei_gate.sh > run.txt) and read the verdict.
#   arm 1  THE BUILD: the inserter hits its sixteen anchors on the instruments record's w2e.c and the assembled engine equals the committed
#          cei_face.c byte for byte (a deterministic build from the record)
#   arm 2  K3: with every door unset the engine's output is EI's binary's (the frozen k3_ei.txt) byte for byte up to timings
#   arm 3  K3': with the loops dropped at LMAX 0, Z equals the record's W2-Z to twelve digits
#   arm 4  K-SRC: at the free datum every face plaquette's <1/2 tr U_p> equals I_2(2.2)/I_1(2.2), two sources connected 0; the ordered
#          datum's tied value parts from it (two-sided)
#   arm 5  K5: the datum rotated at the MID-PATH vertex (1,0,0,0) leaves the substituted reading unmoved (|diff| < 1e-12) and the same
#          rotation at the COARSE vertex (2,0,0,0) moves it (|diff| > 1e-6) -- the fibre's residual gauge symmetry, two-sided; at c = 1 and
#          at c = (0.6, 0, 0.8, 0)
#   arm 6  THE PRICE: the engine's peak state at W2 equals ordsub's exhaustive least peak over every order (537824)
#   arm 7  THE GAUSSIAN FACE FIBRE: cei_gauss_face.awk's interior check 0 0 0 0 and its (A0, B4) constrained covariance pinned
#   arm 8  THE READING (a regression guard, law 30: UNGUESSED then pinned): the W2 ordered substituted reading to twelve digits
# TEETH (arm, pin): signbend (5: the partner's sign) · staplebend (8: the inverse staples dropped) · degreebend (5: the rule blind to the
# inverse staples, the 7.6e-9 drift) · sourcebend (4: the chi_1 source weight halved) · multbend (5 at c = (0.6,0,0.8,0): the backward
# multiplier c^-1 made c) · the comment control (no arm may move).
set -u
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"; cd "$ROOT" || exit 9
DK_ORGAN="cei"
. "$ROOT/STDLIB/scripts/lib/dokimasia.sh"
PRE="$ROOT/DOCS/III-THE-CROSSING-CAMPAIGN-OF-THE-YANG-MILLS-GAP.md"
C="$ROOT/STDLIB/build/aperanton/cei"; B="$C/gate"; MUT="$B/mut"; mkdir -p "$MUT"
W2E="$ROOT/STDLIB/build/aperanton/instruments/2026-11-02/math/EI/code/w2e.c"
DECL="$C/cei_decl.c"; FUNCS="$C/cei_funcs.c"; DRIVER="$C/cei_driver.c"; INSERT="$C/cei_insert.awk"; FACE="$C/cei_face.c"
GAUSS="$C/cei_gauss_face.awk"; ORDSUB="$C/ordsub.exe"; ORDW2="$C/best_W2_subst.ord"; K3REF="$C/k3_ei.txt"
for f in "$PRE" "$W2E" "$DECL" "$FUNCS" "$DRIVER" "$INSERT" "$FACE" "$GAUSS" "$ORDW2" "$K3REF"; do [ -f "$f" ] || dk_red "missing: $f"; done
[ -x "$ORDSUB" ] || dk_red "missing: $ORDSUB (build it with ordsub_build.sh)"
dk_provenance "$PRE" "$FUNCS"
dk_own "$DECL" "$DRIVER" "$INSERT" "$FACE" "$GAUSS" "$ORDW2" "$K3REF"
export OMP_NUM_THREADS=2 OMP_WAIT_POLICY=passive
CR=$(printf '\r'); strip(){ tr -d "$CR"; }
tstrip(){ sed -E 's/ in [0-9.]+ s/ in T s/; s/; [0-9.]+ s\)/; T s)/; s/W2-DONE [0-9.]+ s/W2-DONE T s/'; }

# ---- the assembler: the engine from the record's w2e.c and four fragments (any of them a mutant), compiled to $5.exe
assemble(){ local decl="$1" funcs="$2" driver="$3" insert="$4" out="$5"
  gawk -v DECL="$decl" -v FUNCS="$funcs" -v DRIVER="$driver" -f "$insert" "$W2E" > "$out.c" 2> "$out.anchors" || return 1
  grep -q 'anchors hit: 16 of 16' "$out.anchors" || { echo "anchors: $(cat "$out.anchors")"; return 1; }
  gcc -O2 -fopenmp -o "$out.exe" "$out.c" -lm; }
build_funcs(){ assemble "$DECL" "$1" "$DRIVER" "$INSERT" "$2"; }
build_driver(){ assemble "$DECL" "$FUNCS" "$1" "$INSERT" "$2"; }
build_insert(){ assemble "$DECL" "$FUNCS" "$DRIVER" "$1" "$2"; }

# ---- the run: every arm's verdict lines from one engine (the pristine one or a mutant), the pins read from these lines
run_all(){ local E="$1.exe"; [ -x "$E" ] || E="$1"; cd "$C" || exit 9
  local T="$B/t.$$"; mkdir -p "$T"
  # arm 2  K3
  "$E" 2.2 2 2 ordered fwd bent 2 2>&1 | strip > "$T/k3.txt"
  if diff -q <(tstrip < "$K3REF" | strip) <(tstrip < "$T/k3.txt") > /dev/null; then echo "K3-IDENTITY lines=$(wc -l < "$T/k3.txt") verdict=IDENTICAL"; else echo "K3-IDENTITY verdict=DIFFERS"; fi
  # arm 3  K3'
  CEI_DROPLOOPS=1 "$E" 2.2 2 0 ordered fwd bent 2 2>&1 | strip > "$T/k3p.txt"
  local zrec zdrop; zrec=$(grep -o -E 'W2-Z .* Z = [-0-9.e+]+' "$K3REF" | grep -o -E '[-0-9.e+]+$'); zdrop=$(grep -o -E 'CEI-Z src=none Z = [-0-9.e+]+' "$T/k3p.txt" | grep -o -E '[-0-9.e+]+$')
  gawk -v a="$zrec" -v b="$zdrop" 'BEGIN { d = (a - b) / a; if (d < 0) d = -d; printf "K3P-Z record=%s dropped=%.12e reldiff=%.1e verdict=%s\n", a, b, d, (d < 1e-11 ? "MET" : "MISS") }'
  # arm 4  K-SRC
  CEI_DROPLOOPS=1 CEI_SRC=0,3 "$E" 2.2 2 0 free fwd bent 2 2>&1 | strip > "$T/free.txt"
  CEI_DROPLOOPS=1 CEI_SRC=0,4 "$E" 2.2 2 0 ordered fwd bent 2 2>&1 | strip > "$T/tied.txt"
  gawk -v want="$(gawk 'function bi(n,x,s,k,t,i){s=0;for(k=0;k<60;k++){t=(x/2)^(2*k+n);for(i=1;i<=k;i++)t/=i;for(i=1;i<=k+n;i++)t/=i;s+=t}return s} BEGIN{printf "%.15f", bi(2,2.2)/bi(1,2.2)}')" '
    FILENAME ~ /free/ && /CEI-SRC p=0/ { split($0, a, "= "); p = a[2] + 0 } FILENAME ~ /free/ && /CEI-SRC q=3/ { match($0, /U_q> = [-0-9.e+]+/); q = substr($0, RSTART + 7, RLENGTH - 7) + 0; match($0, /CONNECTED = [-0-9.e+]+/); c = substr($0, RSTART + 12, RLENGTH - 12) + 0 }
    FILENAME ~ /tied/ && /CEI-SRC p=0/ { split($0, a, "= "); t = a[2] + 0 }
    END { dp = p - want; if (dp < 0) dp = -dp; dq = q - want; if (dq < 0) dq = -dq; if (c < 0) c = -c; dt = t - want; if (dt < 0) dt = -dt
      printf "K4-FREE p=0 <1/2 tr U_p> = %.12e bessel=%.12e diff=%.1e connected=%.1e verdict=%s\n", p, want, dp, c, (dp < 1e-12 && dq < 1e-12 && c < 1e-12 ? "MET" : "MISS")
      printf "K4-TIED ordered <1/2 tr U_p> = %.12e parts-from-free-by=%.3e verdict=%s\n", t, dt, (dt > 1e-3 ? "PARTS" : "SAME") }' "$T/free.txt" "$T/tied.txt"
  # arms 5, 6, 8 at c = 1, and arm 5 again at c = (0.6, 0, 0.8, 0)
  for cc in "1:0:0:0" "0.6:0:0.8:0"; do
    CEI_C="$cc" CEI_SUBST=1 CEI_ORDER="$ORDW2" CEI_SRC=0,4 "$E" 2.2 2 0 ordered fwd bent 2 2>&1 | strip > "$T/s.txt"
    W2_GAUGE="1,0,0,0:0.6:0.0:0.8:0.0" CEI_C="$cc" CEI_SUBST=1 CEI_ORDER="$ORDW2" CEI_SRC=0,4 "$E" 2.2 2 0 ordered fwd bent 2 2>&1 | strip > "$T/gm.txt"
    W2_GAUGE="2,0,0,0:0.6:0.0:0.8:0.0" CEI_C="$cc" CEI_SUBST=1 CEI_ORDER="$ORDW2" CEI_SRC=0,4 "$E" 2.2 2 0 ordered fwd bent 2 2>&1 | strip > "$T/gc.txt"
    gawk -v cc="$cc" '
      function rd(f, name,   line, v) { while ((getline line < f) > 0) if (line ~ /CEI-SRC q=4/) { match(line, /U_q> = [-0-9.e+]+/); v = substr(line, RSTART + 7, RLENGTH - 7) + 0; match(line, /CONNECTED = [-0-9.e+]+/); CONN[name] = substr(line, RSTART + 12, RLENGTH - 12) + 0; VAL[name] = v } close(f) }
      BEGIN { rd(ARGV[1], "s"); rd(ARGV[2], "gm"); rd(ARGV[3], "gc")
        dm = VAL["s"] - VAL["gm"]; if (dm < 0) dm = -dm; dcm = CONN["s"] - CONN["gm"]; if (dcm < 0) dcm = -dcm; dc = VAL["s"] - VAL["gc"]; if (dc < 0) dc = -dc
        printf "K5-MID c=%s verdict=%s\n", cc, (dm < 1e-12 && dcm < 1e-12 ? "HELD" : "MOVED")
        printf "K5-MID-DETAIL c=%s mid-path-vertex diff=%.1e conn-diff=%.1e\n", cc, dm, dcm
        printf "K5-COARSE c=%s verdict=%s\n", cc, (dc > 1e-6 ? "MOVED" : "HELD")
        printf "K5-COARSE-DETAIL c=%s coarse-vertex diff=%.3e\n", cc, dc
        if (cc == "1:0:0:0") printf "K8-READING c=1 W2 ordered <1/2 tr U_q> = %.12e CONNECTED = %.12e\n", VAL["s"], CONN["s"]
        else printf "K9-READING c=%s W2 ordered <1/2 tr U_q> = %.12e CONNECTED = %.12e\n", cc, VAL["s"], CONN["s"]; exit }' "$T/s.txt" "$T/gm.txt" "$T/gc.txt"
    if [ "$cc" = "1:0:0:0" ]; then local peak; peak=$(grep -o -E 'max state [0-9]+' "$T/s.txt" | head -1 | grep -o -E '[0-9]+$'); local v=MISS; [ "$peak" = "$PEAK" ] && v=MET; echo "K6-PRICE engine-peak=$peak ordsub-least-peak=$PEAK verdict=$v"; fi
    # (run g: the verdict used to be stamped onto the base run after run_all, so the comment control -- which runs run_all raw -- always differed at this line; the verdict is now the run's own)
  done
  rm -rf "$T"; }

# ---- arm 1: the build is deterministic and equals the committed engine
rm -rf "$B/pristine".*; assemble "$DECL" "$FUNCS" "$DRIVER" "$INSERT" "$B/pristine" > "$B/pristine.build.log" 2>&1 || dk_red "arm 1: the assembly failed ($(tail -2 "$B/pristine.build.log" | tr '\n' ' '))"
cmp -s "$B/pristine.c" "$FACE" || dk_red "arm 1: the assembled engine differs from the committed cei_face.c"
dk_say "arm 1: the inserter hits its sixteen anchors on the record's w2e.c and the assembled engine equals the committed cei_face.c byte for byte"

# ---- the pristine run (every arm's lines), ordsub's peak substituted in
RUN="$B/cei.run1.txt"; rm -f "$RUN"
PEAK=$(cd "$C" && ORD_SUBST=1 "$ORDSUB" 2 2 0 0 dpfull 2>/dev/null | grep -o -E 'least peak over every order of them [0-9]+' | grep -o -E '[0-9]+$')
[ -n "$PEAK" ] || dk_red "arm 6: ordsub printed no least peak"
run_all "$B/pristine" > "$RUN"
# arm 7: the Gaussian face reader
gawk -f "$GAUSS" -v BETA=2.2 2>&1 | strip > "$B/gauss.run1.txt" || dk_red "arm 7: the Gaussian face reader failed"
grep -qF 'interior check (exterior links in the four plaquette functionals, must be 0): 0 0 0 0' "$B/gauss.run1.txt" || dk_red "arm 7: a plaquette functional reached outside the object"
grep -qF 'pA0:pB4     -0.098974864836  -0.048762848517   0.492679' "$B/gauss.run1.txt" || dk_red "arm 7: the (A0, B4) constrained covariance moved from its pinned -0.048762848517"
dk_say "arm 7: the Gaussian face fibre -- interior check 0 0 0 0; the (A0, B4) covariance -0.048762848517 constrained against -0.098974864836, ratio 0.492679"
export DK_BASE_RUN="$RUN"
dk_have "$RUN" "K3-IDENTITY lines=36 verdict=IDENTICAL"
dk_have "$RUN" "K3P-Z record=2.362869409647e+33 dropped=2.362869409647e+33 reldiff="
grep -qE '^K3P-Z .* verdict=MET$' "$RUN" || dk_red "arm 3: Z with the loops dropped parts from the record's"
dk_have "$RUN" "K4-FREE p=0 <1/2 tr U_p> = 4.644790252704e-01 bessel=4.644790252704e-01"
grep -qE '^K4-FREE .* verdict=MET$' "$RUN" || dk_red "arm 4: the free-datum source answer parts from the Bessel ratio"
grep -qE '^K4-TIED .* verdict=PARTS$' "$RUN" || dk_red "arm 4: the tied side does not part (the arm cannot see)"
dk_have "$RUN" "K5-MID c=1:0:0:0 verdict=HELD"
dk_have "$RUN" "K5-MID c=0.6:0:0.8:0 verdict=HELD"
dk_have "$RUN" "K5-COARSE c=1:0:0:0 verdict=MOVED"
dk_have "$RUN" "K5-COARSE c=0.6:0:0.8:0 verdict=MOVED"
dk_have "$RUN" "K6-PRICE engine-peak=537824 ordsub-least-peak=537824 verdict=MET"
dk_have "$RUN" "K8-READING c=1 W2 ordered <1/2 tr U_q> = 6.812446854591e-01 CONNECTED = 2.813177104131e-04"
dk_have "$RUN" "K9-READING c=0.6:0:0.8:0 W2 ordered <1/2 tr U_q> = 6.710329649351e-01 CONNECTED = -6.397519025598e-04"
dk_say "arms 2-6, 8: K3 identical to EI's binary; Z equal with the loops dropped; the free-datum Bessel ratio to 1e-12, the tied side parting; the mid-path rotation HELD and the coarse one MOVED at both data; the peak 537824 = ordsub; the reading pinned"

# ---- TEETH: each bends one fragment, rebuilds through the inserter, and must move its arm's pin
dk_tooth "$FUNCS" "$MUT" signbend \
  'STEPL\[c\]\[st\] = p; STEPS\[c\]\[st\] = -sp; STEPPRE\[c\]\[st\] = 1;' \
  'STEPL[c][st] = p; STEPS[c][st] = sp; STEPPRE[c][st] = 1;' \
  5 "K5-MID c=1:0:0:0 verdict=HELD" build_funcs run_all
dk_tooth "$FUNCS" "$MUT" staplebend \
  'ISIGP\[p\]\[m\] = sp; ISIGE\[p\]\[m\] = se; NISTAP\[p\]++; }' \
  'ISIGP[p][m] = sp; ISIGE[p][m] = se; }' \
  8 "K8-READING c=1 W2 ordered <1/2 tr U_q> = 6.812446854591e-01 CONNECTED = 2.813177104131e-04" build_funcs run_all
dk_tooth "$INSERT" "$MUT" degreebend \
  'int d = (NSTAP\[l\] + NISTAP\[l\]) \* WMAX;' \
  'int d = NSTAP[l] * WMAX;' \
  5 "K5-MID c=1:0:0:0 verdict=HELD" build_insert run_all
dk_tooth "$FUNCS" "$MUT" sourcebend \
  'PFAC\[c\]\[q\] = (q > 0 ? FAC\[q - 1\] : 0) + (q + 1 <= WMAX ? FAC\[q + 1\] : 0);' \
  'PFAC[c][q] = (q + 1 <= WMAX ? FAC[q + 1] : 0);' \
  8 "K8-READING c=1 W2 ordered <1/2 tr U_q> = 6.812446854591e-01 CONNECTED = 2.813177104131e-04" build_funcs run_all
# the free datum forces every face plaquette to spin 0, where the FAC[s-1] term does not enter (the first run's inert tooth, law 20 (i)): the
# term that DOES enter at spin 0 is FAC[s+1], and dropping it empties the source -- that tooth is arm 4's
dk_tooth "$FUNCS" "$MUT" sourcebend0 \
  'PFAC\[c\]\[q\] = (q > 0 ? FAC\[q - 1\] : 0) + (q + 1 <= WMAX ? FAC\[q + 1\] : 0);' \
  'PFAC[c][q] = (q > 0 ? FAC[q - 1] : 0);' \
  4 "K4-FREE p=0 <1/2 tr U_p> = 4.644790252704e-01 bessel=4.644790252704e-01" build_funcs run_all
# (run f: the source weight stood at two sites of the driver once the transfer mode needed it too -- law 22 -- so it is one helper, cei_source(c), in the
# functions fragment, and both source teeth bend the helper's single site)
dk_tooth "$FUNCS" "$MUT" multbend \
  'quat ci = qinv(CEIC);' \
  'quat ci = CEIC;' \
  8 "K9-READING c=0.6:0:0.8:0 W2 ordered <1/2 tr U_q> = 6.710329649351e-01 CONNECTED = -6.397519025598e-04" build_funcs run_all
# (run e: aimed at the mid-path gauge check it SURVIVED -- a consistently wrong multiplier is still a gauge-invariant model, law 24 -- so the
# tooth is aimed at the reading at the non-identity datum, where the inverse enters)
dk_teeth_pin 6
dk_control "$FUNCS" "$MUT" \
  '/\* ---- cei_face: the loops dropped, the substitution, the partner staples, the order file ---- \*/' \
  '/* ---- cei_face (comment control): the loops dropped, the substitution, the partner staples, the order file ---- */' \
  "$RUN" build_funcs run_all

dk_green "THE CONSTRAINED EXACT INTEGRATOR: the build deterministic from the record; K3 byte-identical to EI's engine; Z equal with the loops dropped; the free-datum source answer I_2/I_1 to 1e-12 with the tied side parting; the mid-path rotation HELD to 1e-12 and the coarse one MOVED at c = 1 and at c = (0.6,0,0.8,0); the peak 537824 = ordsub's least peak over every order; the Gaussian face fibre's covariance pinned; the W2 ordered reading pinned; five teeth bled in arms 4, 5 and 8, the comment control silent"
