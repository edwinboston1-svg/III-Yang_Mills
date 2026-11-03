#!/usr/bin/env bash
# aperanton_table_gate.sh -- ΑΠΕΡΑΝΤΟΝ, THE TABLE MODE: the lattice gap at strong coupling's honest number from the FINITE star table
# (S1 §24 Theorem L: |N(Y)| <= prod_v r_v, gamma(s) = 3 theta(s)^4, theta(s) = max_{k<=s} r2max(k)^{1/2k}; the family ends at k = 24 because
# a vertex star is a simple subgraph of K_{2,2,2,2}), every table entry an EXACT value where the engine has read every row at that k, else
# the lesser of two certified bounds on the unread rows -- the Frobenius sieve's integer and THE CERTIFIED REALIGNED OPERATOR-NORM BOUND
# (S1 §25; realign_cert.py, exact arithmetic over Q, lam_max certified by an exact LDL^T) -- and the Kotecky-Preiss certificate run on that
# table in both dressings (aperanton_kp_cert.awk, TABLE mode, gawk -M, 2^-128 grid intervals).  Nothing staked: the number is whatever the
# table gives, and this gate re-derives the table from its frozen inputs, re-runs the instrument's known answers and its dead-instrument
# control, re-reads the law-6 census (every exact value under its own realigned bound), and re-runs the certificate at the number and one
# grid step above it.  The sibling of aperanton_gate.sh (the Lean stages and the staked local readings, hours); this one runs in minutes.
# W = 0 on the inequalities (||AB||_F <= ||A||_F ||B||_op; the block Cauchy-Schwarz; Sylvester; Kotecky-Preiss); the earning is the exact
# table, the certified bound and the certified number.  Prereg: the S1 page, every section dated before its run.
set -u
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"; cd "$ROOT" || exit 9
DK_ORGAN="aperanton_table"
. "$ROOT/STDLIB/scripts/lib/dokimasia.sh"

A="$ROOT/STDLIB/build/aperanton"; SG="$A/surface-gas"; B="$A/table_gate"; MUT="$B/mut"; mkdir -p "$MUT"
PRE="$ROOT/DOCS/III-S1-THE-FLUX-SURFACE-GAS.md"
# THE CERTIFICATE OF RECORD TONIGHT is the tree's certificate PLUS the table mode and the rewritten sub-gas mode, kept in the build directory
# (kp_cert_table_wip.awk, committed) while the sibling gate's run an holds STDLIB/scripts/aperanton_kp_cert.awk in its teeth (a file bent by a
# running gate is not edited); arm 1 proves the two are ONE certificate in the staked mode (byte-identical output at Theorem 8.7's point), and
# the copy replaces the tree's file at run an's END, when CERT below flips to the tree path and this gate re-runs.
CERT="$A/kp_cert_table_wip.awk"; CERT_TREE="$ROOT/STDLIB/scripts/aperanton_kp_cert.awk"
TBL="$A/local_tail_table.awk"; RC="$SG/realign_cert.py"; RB="$SG/realign_bound.py"
TAG="2026-10-31g"
REC="$A/local_tail_table.$TAG.txt"; SNAP="$A/local_tail_table.$TAG.inputs.txt"; CAND="$A/local_tail_table.cand.$TAG.rows"
SCANP="$A/kp_cert_table_scan_page.$TAG.txt"; SCANT="$A/kp_cert_table_scan_tree.$TAG.txt"
CENS="$A/realign_census.2026-10-31a.txt"; CENSB="$A/realign_census.2026-10-31b.txt"; CENSIN="$A/realign_census.2026-10-31a.in"
UNREAD="$A/realign_unread.2026-10-31a.in"; BOUNDS=( "$A/realign_bound.2026-10-31a.txt" "$A/realign_bound.2026-10-31b.txt" "$A/realign_bound.2026-10-31c.txt" "$A/realign_bound.2026-10-31d.txt" )
CLX="$A/class_exact.2026-10-31a.txt"; PRIM1="$A/star_exact.2026-10-29c.txt"; PRIM6="$A/star_exact.2026-10-29a.txt"
TAILIN="$A/local_tail.2026-10-30c.in"
for f in "$PRE" "$CERT" "$TBL" "$RC" "$RB" "$REC" "$SNAP" "$CAND" "$SCANP" "$SCANT" "$CENS" "$CENSB" "$CENSIN" "$UNREAD" "${BOUNDS[@]}" "$CLX" "$PRIM1" "$PRIM6" "$TAILIN"; do [ -f "$f" ] || dk_red "missing: $f"; done
PY="$(command -v python || true)"; [ -n "$PY" ] || dk_red "python is not on the PATH (the instrument runs under python -I)"
dk_provenance "$PRE" "$CERT"
# the frozen snapshot of the table's inputs ($SNAP, the exact lines of every pass record and the REALIGN lines, ~100 MB) is read from disk and
# NOT owned: the commit wall refuses a blob over 100 MB; it is reproducible line for line from the landed per-k exact records
# (local_tail_exact.<date>.k<kk>.txt, local_tail_exact_byk.sh) and the REALIGN records, and its line counts are pinned below
dk_own "$TBL" "$RC" "$RB" "$REC" "$CAND" "$SCANP" "$SCANT" "$CENS" "$CENSB" "$CENSIN" "$UNREAD" "${BOUNDS[@]}" "$CLX"

# ---- ARM 1, STRUCTURAL: the certificate carries the table mode and refuses a table of the wrong length; the table builder carries the three
# kinds and both discord censuses; the instrument carries the trace control, the symmetry control and the exact LDL certificate; the kind
# alphabet is infix-free
grep -qF 'if (R2TAB != "") {' "$CERT" || dk_red "the certificate has no TABLE mode"
grep -qF 'KP-CERT REFUSED: R2TAB needs sixteen entries (k = 9..24)' "$CERT" || dk_red "the table mode does not refuse a wrong-length table"
grep -qF 'GTAG = " graded=S24-table"' "$CERT" || dk_red "the table mode has lost its tag"
grep -qF 's>=25 at gamma(24) (the family ends at k = 24)' "$CERT" || dk_red "the table mode has lost the finite family's end"
grep -qF 'kind = "REALIGNED"' "$TBL" || dk_red "the table builder has no REALIGNED kind"
grep -qF 'DISCORD-R id=' "$TBL" || dk_red "the table builder has no realigned discord census"
grep -qF 'DISCORD id=' "$TBL" || dk_red "the table builder has no Frobenius discord census"
grep -qF 'the Gram inverse is not the inverse' "$RC" || dk_red "the instrument has no trace control"
grep -qF 'Tr_N P is not symmetric' "$RC" || dk_red "the instrument has no symmetry control"
grep -qF 'def ldl_posdef(A, idx, mu):' "$RC" || dk_red "the instrument has no exact LDL certificate"
grep -qE 'import numpy|import scipy|import sympy' "$RC" && dk_red "a numerical library has grown in the instrument (the certification is exact Fractions)"
dk_infixfree EXACT FROBENIUS REALIGNED PASS HELD || dk_red "the kind alphabet is not infix-free"
if [ "$CERT" != "$CERT_TREE" ]; then   # the copy and the tree's certificate are one certificate in the staked mode (Theorem 8.7's point, the LOCAL staked tail), byte for byte
  [ -f "$CERT_TREE" ] || dk_red "the tree's certificate is missing: $CERT_TREE"
  s1=$(AWKPATH="$ROOT/STDLIB/scripts" gawk -M -v BESSEL_LIB=1 -v LOCAL=1 -v DRESS=page -v P=2452 -v Q=10000 -v AN=2 -v AD=1000 -v F0=20 -f "$CERT_TREE" 2>&1 | tr -d '\r' | md5sum | cut -c1-32)
  s2=$(AWKPATH="$ROOT/STDLIB/scripts" gawk -M -v BESSEL_LIB=1 -v LOCAL=1 -v DRESS=page -v P=2452 -v Q=10000 -v AN=2 -v AD=1000 -v F0=20 -f "$CERT" 2>&1 | tr -d '\r' | md5sum | cut -c1-32)
  [ "$s1" = "$s2" ] || dk_red "the certificate copy and the tree's certificate part in the staked mode ($s1 vs $s2)"
  dk_say "THE CERTIFICATE COPY: one certificate with the tree's in the staked mode at Theorem 8.7's point (md5 $s1)"
fi
dk_say "STRUCTURAL: the table mode with its sixteen-entry refusal and the family's end at k = 24; the three kinds and both discord censuses; the trace, symmetry and LDL certificates; EXACT/FROBENIUS/REALIGNED/PASS/HELD infix-free"

# ---- ARM 2, THE INSTRUMENT'S CONTROLS, TWO-SIDED: the known answers held in exact arithmetic (projectors idempotent with trace R on seven
# types; seven stars with exact S inside exact^2 <= bound2S <= Frobenius^2) AND the dead instrument refused by name (a planted wrong Gram
# inverse: the partial traces' traces are not R)
RUNK="$B/kat.run"; RUNN="$B/negctl.run"
(cd "$SG" && "$PY" -I realign_cert.py KAT) > "$RUNK" 2>&1 || dk_red "the instrument's KAT run failed (rc $?)"
dk_have "$RUNK" "REALIGN KAT HELD: 7 known answers inside exact^2 <= bound2S <= Frobenius^2; projectors idempotent with trace R on 7 types"
dk_have "$RUNK" "bound2S=1/81 (0.0123457) frob2S=1/1 exact^2=0.000771605  HELD  bound/exact 4.00"
dk_have "$RUNK" "PROJECTOR d=3 h=2: dim Inv 4 (Riordan 4) trace 4 idempotent YES"
[ "$(grep -c '^KAT .* HELD ' "$RUNK")" -eq 7 ] || dk_red "the KAT run holds $(grep -c '^KAT .* HELD ' "$RUNK") known answers, not 7"
nrc=0; (cd "$SG" && "$PY" -I realign_cert.py NEGCTL) > "$RUNN" 2>&1 || nrc=$?
[ "$nrc" -eq 3 ] || dk_red "the dead-instrument control exited $nrc, not 3 (refused by name)"
dk_have "$RUNN" "REALIGN REFUSED: the partial traces of the projector at type d=2 h=0 split (1,0) have traces 2 and 2, not R = 1 -- the Gram inverse is not the inverse"
dk_absent "$RUNN" "NEGCTL FAILED"
dk_say "THE INSTRUMENT: KAT HELD 7/7 with the projectors idempotent; the planted Gram defect REFUSED by name (rc 3)"

# ---- ARM 3, THE LAW-6 CENSUS: every exact value in the frozen census input lies under its own certified realigned bound (3416 of 3464
# rows bounded, the rest outside the lemma's shape), and forty rows re-derive byte for byte
dk_have "$CENS" "REALIGN ROWS END: 3416 rows bounded, 0 DISCORD (an exact value above its own realigned bound)"
[ "$(grep -c 'exact2<=bound2 HELD$' "$CENS")" -eq 3416 ] || dk_red "the census holds $(grep -c 'exact2<=bound2 HELD$' "$CENS") rows, not 3416"
[ "$(grep -c 'DISCORD$' "$CENS")" -eq 0 ] || dk_red "the census carries a DISCORD"
[ "$(grep -c '^WCONF' "$CENSIN")" -eq 3464 ] || dk_red "the frozen census input has $(grep -c '^WCONF' "$CENSIN") rows, not 3464"
dk_have "$CENSB" "REALIGN ROWS END: 3464 rows bounded, 0 DISCORD (an exact value above its own realigned bound)"   # the whole input, the m = 0 rows included (the filter removed at 23:5x)
[ "$(grep -c 'exact2<=bound2 HELD$' "$CENSB")" -eq 3464 ] || dk_red "the whole census holds $(grep -c 'exact2<=bound2 HELD$' "$CENSB") rows, not 3464"
grep -qE '^# END .* rc=0$' "$CENSB" || dk_red "the whole census did not end rc=0"
grep '^WCONF' "$CENSIN" | gawk 'NR % 86 == 1' | head -40 > "$B/census40.in"
(cd "$SG" && "$PY" -I realign_cert.py ROWS "$B/census40.in") > "$B/census40.run" 2>&1 || dk_red "the census re-derivation failed"
n40=0; while IFS= read -r line; do grep -qF -- "$line" "$CENS" || dk_red "a re-derived census row is not in the record: ${line:0:120}"; n40=$((n40+1)); done < <(grep '^REALIGN id=' "$B/census40.run")
[ "$n40" -eq 40 ] || dk_red "the census re-derivation produced $n40 rows, not 40"
dk_say "THE CENSUS: 3416 exact values under their certified bounds, 0 discords; 40 rows re-derived byte for byte"

# ---- ARM 4, THE BOUND RECORD: every slice ended rc=0; every row of the frozen unread input carries a REALIGN line in some slice (ids
# contained by members); twenty rows re-derive byte for byte
for f in "${BOUNDS[@]}"; do grep -qE '^# END .* rc=0$' "$f" || dk_red "a bound slice did not end rc=0: $f"; done
cat "${BOUNDS[@]}" | grep '^REALIGN id=' | sed 's/^REALIGN id=\([^ ]*\) .*/\1/' | sort -u > "$B/bound.ids"
grep '^WCONF' "$UNREAD" | sed 's/.*id=\([^ ]*\) .*/\1/' | sort -u > "$B/unread.ids"
miss=$(comm -23 "$B/unread.ids" "$B/bound.ids" | wc -l); [ "$miss" -eq 0 ] || dk_red "$miss unread rows carry no realigned bound: $(comm -23 "$B/unread.ids" "$B/bound.ids" | head -3 | tr '\n' ' ')"
[ "$(wc -l < "$B/unread.ids")" -eq 6152 ] || dk_red "the frozen unread input has $(wc -l < "$B/unread.ids") ids, not 6152"
grep '^WCONF' "$UNREAD" | gawk 'NR % 307 == 1' | head -20 > "$B/unread20.in"
(cd "$SG" && "$PY" -I realign_cert.py ROWS "$B/unread20.in") > "$B/unread20.run" 2>&1 || dk_red "the bound re-derivation failed"
n20=0; while IFS= read -r line; do cat "${BOUNDS[@]}" | grep -qF -- "$line" || dk_red "a re-derived bound row is not in the record: ${line:0:120}"; n20=$((n20+1)); done < <(grep '^REALIGN id=' "$B/unread20.run")
[ "$n20" -eq 20 ] || dk_red "the bound re-derivation produced $n20 rows, not 20"
dk_say "THE BOUND RECORD: three slices ended rc=0, all 6152 unread ids bounded, 20 rows re-derived byte for byte"

# ---- ARM 5, THE TABLE: rebuilt from the frozen snapshot on the record's candidate rows plus the census rows (the exact pass, gawk -M),
# the R2TAB line equal to the record's and both discord counts zero; the census rows make the realigned discord check LIVE (3416 read
# rows carry a bound)
RUNT="$B/table.run"
gawk -M -f "$TBL" "$SNAP" "$CAND" "$CENSIN" > "$RUNT" 2>&1 || dk_red "the table rebuild failed"
RTAB_REC="$(grep '^R2TAB=' "$REC")"; [ -n "$RTAB_REC" ] || dk_red "the table record has no R2TAB line"
dk_have "$RUNT" "$RTAB_REC"
dk_have "$RUNT" "TABLE DISCORD: 0 read rows above their own Frobenius bound; 0 read rows above their own realigned bound (of 3464 read rows carrying one"
[ "$(grep -c '^DISCORD' "$RUNT")" -eq 0 ] || dk_red "the rebuilt table carries a discord line"
[ "$(grep -c '^TABLE k=' "$RUNT")" -eq 16 ] || dk_red "the rebuilt table has $(grep -c '^TABLE k=' "$RUNT") rows, not 16"
dk_say "THE TABLE: rebuilt from the frozen snapshot, R2TAB equal to the record's, 0 Frobenius discords and 0 realigned discords over 3464 read rows"

# ---- ARM 6, THE CERTIFICATE: the record's number in both dressings, re-run at the number (PASS) and one grid step above it (refused,
# page dressing), and the staked point of Theorem 8.7 (beta = 0.2452) inside the region
TAB="$(echo "$RTAB_REC" | sed 's/^R2TAB=//')"
runcert(){ AWKPATH="$ROOT/STDLIB/scripts" gawk -M -v BESSEL_LIB=1 -v LOCAL=1 -v "R2TAB=$TAB" -v DRESS="$1" -v SCAN=1 -v BETA0="$2" -v BETA1="$2" -v AK0=1 -v AK1=80 -v F0=20 -f "$3" 2>&1 | tr -d '\r' | grep 'KP-CERT SCAN'; }
# (the pins of this arm are written from the record kp_cert_table_scan_page.2026-10-31c.txt / _tree once that record exists: see below)
. "$B/arm6_pins.sh"
dk_say "THE CERTIFICATE: the number re-run in both dressings, refused one step above, Theorem 8.7's point inside"

# ---- ARM 7, THE CLASS-EXACT RECORD: the two sixteen-chord vertices' exact values under their tail ids re-derived from the primary records
# (S from star_exact.2026-10-29c.txt and 2026-10-29a.txt; r2 = 64 S), and the identification of the seven tail rows as the seven classes
S1="$(grep -o 'SIXTEEN-CHORD class=1 S=[0-9]*/[0-9]*' "$PRIM1" | sed 's/.*S=//')"; [ -n "$S1" ] || dk_red "class 1's S is not in its primary record"
S6="$(grep -o 'SIXTEEN-CHORD S=[0-9]*/[0-9]*' "$PRIM6" | sed 's/.*S=//')"; [ -n "$S6" ] || dk_red "class 6's S is not in its primary record"
R1="$(gawk -M -v s="$S1" 'BEGIN { split(s, f, "/"); n = f[1] * 64; d = f[2]; g = n; h = d; while (h) { t = g % h; g = h; h = t } printf "%d/%d", n / g, d / g }')"
R6="$(gawk -M -v s="$S6" 'BEGIN { split(s, f, "/"); n = f[1] * 64; d = f[2]; g = n; h = d; while (h) { t = g % h; g = h; h = t } printf "%d/%d", n / g, d / g }')"
dk_have "$CLX" "STAR-EXACT-FILE id=1281022 k=16 m=8 S=$S1 r2=$R1 "
dk_have "$CLX" "STAR-EXACT-FILE id=1281043 k=16 m=8 S=$S6 r2=$R6 "
[ "$(gawk '/CONF/ && / k=16 / && / m=8 / { delete CH; delete HF; for (i=1;i<=NF;i++) if ($i ~ /^[0-9]+-[0-9]+:[12]$/) { split($i,e,/[-:]/); if (e[3]==2) { CH[e[1]]++; CH[e[2]]++ } else { HF[e[1]]++; HF[e[2]]++ } } ok=1; for (v=0; v<8; v++) if (CH[v]!=4 || HF[v]!=2) ok=0; if (ok) n++ } END { print n+0 }' "$TAILIN")" -eq 7 ] || dk_red "the tail enumeration does not hold exactly seven sixteen-chord rows"
dk_say "THE CLASS RECORD: class 1 and class 6 re-derived from their primaries (r2 = 64 S), seven sixteen-chord rows in the tail"

# ---- ARM 8, THE PAGE: §25 carries the lemma, the instrument, the census, the records and the number, each on its own line
dk_have "$PRE" "## 25. THE CERTIFIED REALIGNED BOUND"
dk_have "$PRE" "|S| ≤ ‖P_1‖_F · Π_{t=2}^{n−1} ‖M_t‖_op · ‖P_n‖_F"
dk_have "$PRE" "‖M_t‖_op² ≤ λ_max(Tr_N P_t) · λ_max(Tr_S P_t)"
dk_have "$PRE" "REALIGN ROWS END: 3416 rows bounded, 0 DISCORD"
dk_say "THE PAGE: §25 present with the lemma, the block Cauchy–Schwarz, and the census line"

# ---- ARM 9, THE EVEN STARS (S1 section 27): the instrument's known answers re-derived (the cycles 2^{2-d}, K_{2,2,2} = 73/324 over 729
# matchings, the empty graph, the disjoint union), the pinch star read from the run (S = 1/8, e^2 = 4 against the desk's stake 6, law 18),
# and the two records' summaries pinned (560 orbits, 90 tame, the maximal excess at the full star; the census's stars at F = 18 and F = 20)
EVS="$SG/even_stars.py"; EVT="$SG/even_stars.table.2026-11-01a.txt"; LFS="$SG/leaf_stars.2026-11-01a.txt"
dk_own "$EVS" "$SG/even_stars_table.py" "$SG/leaf_stars.py" "$EVT" "$LFS"
RUNE="$B/even.run"; (cd "$SG" && PYTHONIOENCODING=utf-8 "$PY" -I even_stars.py kat) > "$RUNE" 2>&1 || dk_red "the even-star instrument's KAT run failed (rc $?)"
dk_have "$RUNE" "KAT K_2,2,2: S = 73/324 (want 73/324) N = 10512 m_max = 4 matchings = 729 MET"
dk_have "$RUNE" "KAT C_8: S = 1/64 (want 1/64) MET"
dk_have "$RUNE" "KAT disjoint union: 1/4 = 1/2 * 1/2 MET"
dk_have "$RUNE" "E2 pinch star (C3 + C4 sharing half-axis 0): S = 1/8 (stake 24/2^7 = 3/16) e2 = 4 (stake 6) m_max = 2"
[ "$(grep -c ' MET$' "$RUNE")" -eq 9 ] || dk_red "the even-star KAT run holds $(grep -c ' MET$' "$RUNE") known answers, not 9"
grep -q 'FAILED' "$RUNE" && dk_red "the even-star KAT run carries a FAILED line"
dk_have "$EVT" "# orbits=560 tame(rho<=1)=90 max_e2=2382893056/729 (e=1807.958726) at mask 111111111111111111111111; max_rho=14.124678 at mask 111111111111111111111111"
[ "$(grep -c '^mask=' "$EVT")" -eq 560 ] || dk_red "the even-star table holds $(grep -c '^mask=' "$EVT") orbit rows, not 560"
dk_have "$LFS" "EVEN sets 576; distinct star orbits 5; max half-axis degree 4"
dk_have "$LFS" "EVEN sets 7112; distinct star orbits 10; max half-axis degree 4"
dk_say "THE EVEN STARS: nine known answers met, the pinch star read 1/8 (the desk's 3/16 refuted), 560 orbits with 90 tame, the census's stars at F = 18 and 20 pinned"

# ---- ARM 10, THE EXIT BUDGET (the far shore section 10): two cells of kp_budget.2026-11-01a.txt re-derived by the certificate's tilt in the
# table mode of record -- at beta = 0.25, alpha = 0.001 the tilt 68/100 passes and 69/100 is refused; at the number 0.4764 the tilt 0 passes
# and 1/100 is refused -- and the record's lines pinned; the tilt's identity when unset is arm 1's md5
BUDR="$A/kp_budget.2026-11-01a.txt"; dk_own "$A/kp_budget.sh" "$BUDR"
runbud(){ AWKPATH="$ROOT/STDLIB/scripts" gawk -M -v BESSEL_LIB=1 -v GRADED=1 -v "R2TAB=$TAB" -v DRESS=page -v P="$1" -v Q=10000 -v AN="$2" -v AD=1000 -v GN=6 -v GD=1 -v F0=20 -v TILTN="$3" -v TILTD=100 -f "$4" 2>&1 | tr -d '\r' | grep 'KP-CERT dress' | sed 's/.*alpha=[0-9.]* -> /beta='"$1"' alpha='"$2"' tilt='"$3"'\/100 -> /'; }
RUNB="$B/budget.run"; { runbud 2500 1 68 "$CERT"; runbud 2500 1 69 "$CERT"; runbud 4764 1 0 "$CERT"; runbud 4764 1 1 "$CERT"; } > "$RUNB" 2>&1
dk_have "$RUNB" "beta=2500 alpha=1 tilt=68/100 -> PASS"
dk_have "$RUNB" "beta=2500 alpha=1 tilt=69/100 -> FAIL"
dk_have "$RUNB" "beta=4764 alpha=1 tilt=0/100 -> PASS"
dk_have "$RUNB" "beta=4764 alpha=1 tilt=1/100 -> FAIL"
dk_have "$BUDR" "KP-BUDGET beta=2500/10000 alpha=1/1000: epsilon in [68/100, 69/100)"
dk_have "$BUDR" "KP-BUDGET beta=4764/10000 alpha=1/1000: epsilon in [0/100, 1/100)"
[ "$(grep -c '^KP-BUDGET' "$BUDR")" -eq 20 ] || dk_red "the budget record holds $(grep -c '^KP-BUDGET' "$BUDR") cells, not 20"
# THE COEFFICIENT-SUPPLIED MODE (the far shore section 10 RESULTS 4 (c)): the Bessel ratios at 0.25 as rationals over 10^30 reproduce the table
# mode's brackets; a planted fourth entry breaks the tail premise and is refused by name; unset, the staked output is byte-identical (arm 1's md5)
runcoef(){ AWKPATH="$ROOT/STDLIB/scripts" gawk -M -v BESSEL_LIB=1 -v DRESS=page -v P=2500 -v Q=10000 -v AN=1 -v AD=1000 -v GN=6 -v GD=1 -v F0=20 -v COEF="$1" -f "$2" 2>&1 | tr -d '\r' | tail -1; }
COEFR=$(gawk -M -v PREC=256 'function I(n,x,  k,t,s){t=(x/2)^n; for(k=1;k<=n;k++) t/=k; s=t; for(k=0;k<400;k++){t*=(x/2)*(x/2)/((k+1)*(k+n+1)); s+=t} return s} BEGIN{b=0.25; for(j2=1;j2<=16;j2++){r=I(j2+1,b)/I(1,b); printf "%s%d/1000000000000000000000000000000", (j2>1?",":""), int(r*1e30)}}')
COEFB=$(echo "$COEFR" | awk -F, '{OFS=","; $4="500000000000000000000000000000/1000000000000000000000000000000"; print}')
RUNC="$B/coef.run"; { runcoef "$COEFR" "$CERT"; runcoef "$COEFB" "$CERT"; } > "$RUNC" 2>&1
dk_have "$RUNC" "KP-CERT dress=page coef=supplied beta=supplied alpha=1/1000 gamma=6/1 F0=20: kappa_U in [0.019543, 0.019543] root in [0.019543, 0.019543] u in [0.06233787, 0.06233787] u~ in [0.06356816, 0.06356816] r_hi=0.320393"
dk_have "$RUNC" "KP-CERT REFUSED: COEF entries 2 and 4 break the tail premise a_{j+1} <= a_j / 8"
grep -q 'coef=supplied.*-> PASS' "$RUNC" || dk_red "the coefficient-supplied run at the Bessel ratios does not PASS"
dk_say "THE EXIT BUDGET: two cells re-derived (0.68 at beta = 0.25; 0.00 at the number), the record's twenty cells present; the coefficient-supplied mode reproduces the table mode at the Bessel ratios and refuses the planted premise break by name"

# ---- ARM 11, W2 THE TWO-FACE OBJECT'S SWEEP (the crossing campaign section 6): the engine built from its source here, the free object's
# known answers re-derived (K1: W(A,B) = W(A) W(B) with E[chi_a(A)] = d_a a_a^4 and every connected pair zero; K2: Z = 1; the channel sums and
# the projector identities), the ordered datum swept forward and reversed to the same moments, a random datum's moment pinned as a value the
# staples' tooth must move, the pair coupling's modes in Wilson units post-processed from the ordered record; the records owned
W2C="$SG/w2_strip.c"; W2M="$SG/w2_modes.awk"; dk_own "$W2C" "$W2M" "$SG/w2_strip.2026-11-01a.free22.txt" "$SG/w2_strip.2026-11-01a.order22.txt"
W2B="$B/w2"; mkdir -p "$W2B"; gcc -O2 -fopenmp -o "$W2B/w2_strip.exe" "$W2C" -lm > "$W2B/cc.log" 2>&1 || dk_red "w2_strip.c does not compile ($W2B/cc.log)"
run_w2(){ (cd "$W2B" && OMP_NUM_THREADS=8 ./w2_strip.exe "$@" 2>&1 | tr -d '\r'); }
RUNW="$W2B/free.run"; run_w2 2.2 2 2 free fwd > "$RUNW" || dk_red "the free run failed"
dk_have "$RUNW" "W2-KAT representations to spin 2/2 (GENINV=1): homomorphism and traces [MET]"
dk_have "$RUNW" "W2-OBJECT bent links=22 (shared=9) outside=174 staples five/four by census; rule degree 16, 1377 points; beta=2.2 WMAX=2 LMAX=2 datum=free order=fwd"
RUNP="$W2B/free_planar.run"; run_w2 2.2 2 2 free fwd planar > "$RUNP" || dk_red "the planar free run failed"
dk_have "$RUNP" "W2-OBJECT planar links=22 (shared=9) outside=176 staples five/four by census; rule degree 16, 1377 points; beta=2.2 WMAX=2 LMAX=2 datum=free order=fwd"
dk_have "$RUNP" "W2-KAT FREE: Z = 1 [MET]; E[chi_a(A)] = d_a a_a^4 and every connected pair zero [MET]"
dk_have "$RUNW" "W2-KAT FREE: Z = 1 [MET]; E[chi_a(A)] = d_a a_a^4 and every connected pair zero [MET]"
dk_have "$RUNW" "W2-CHANNEL-SUM a=2 c=2 sum_k f_k = +3.075545316213e-06 against the class moment +3.075545316213e-06 (sum_k P_k = 1 to"
[ "$(grep -c '^W2-CHANNEL-SUM' "$RUNW")" -eq 4 ] || dk_red "the free run holds $(grep -c '^W2-CHANNEL-SUM' "$RUNW") channel sums, not 4"
grep -q 'FAILED' "$RUNW" && dk_red "the free run carries a FAILED line"
RUNO="$W2B/ordered_fwd.run"; run_w2 2.2 2 2 ordered fwd > "$RUNO" || dk_red "the ordered forward run failed"
RUNR="$W2B/ordered_rev.run"; run_w2 2.2 2 2 ordered rev > "$RUNR" || dk_red "the ordered reversed run failed"
dk_have "$RUNO" "W2-CLASS a=1 c=1 E[chi_a(A) chi_c(B)] = +4.029907368150e-01"
dk_have "$RUNO" "W2-CLASS a=2 c=2 E[chi_a(A) chi_c(B)] = +2.318421497364e-02"
if ! cmp -s <(grep '^W2-CLASS' "$RUNO" | sed 's/ (imag.*//') <(grep '^W2-CLASS' "$RUNR" | sed 's/ (imag.*//'); then dk_red "the forward and reversed sweeps part on the ordered datum"; fi
[ "$(grep -c '^W2-CLASS' "$RUNO")" -eq 9 ] || dk_red "the ordered run holds $(grep -c '^W2-CLASS' "$RUNO") class moments, not 9"
RUNX="$W2B/random1.run"; run_w2 2.2 2 2 random:1 fwd > "$RUNX" || dk_red "the random run failed"
dk_have "$RUNX" "W2-CLASS a=1 c=1 E[chi_a(A) chi_c(B)] = -1.607459101168e-03"
RUNM="$W2B/modes.run"; gawk -v N=128 -v L2=4 -f "$W2M" "$RUNO" > "$RUNM" 2>&1 || dk_red "the modes post-processor refused on the ordered record ($(head -1 "$RUNM"))"
dk_have "$RUNM" "W2-MODES L=2 N=128:"
dk_have "$RUNM" "W2-CONTENT L=2:"
[ "$(grep -c '^W2-MODE a=' "$RUNM")" -eq 25 ] || dk_red "the modes record holds $(grep -c '^W2-MODE a=' "$RUNM") modes, not 25"
dk_say "W2 THE TWO-FACE OBJECT'S SWEEP: built from source; the free object's known answers met (Z = 1, the marginals d_a a_a^4, every connected pair zero, four channel sums); the ordered datum's nine moments equal forward and reversed; a random datum read; the modes post-processed"

# ---- DOKIMASIA: eleven teeth, each a bend of a computation on a copy, each naming its arm and its pin
build_cp(){ cp "$1" "$2"; }
run_negctl_mut(){ local d; d="$(dirname "$1")"; cp "$RB" "$d/realign_bound.py"; cp "$1" "$d/realign_cert_mut.py"; (cd "$d" && "$PY" -I realign_cert_mut.py NEGCTL); return 0; }
run_kat_mut(){ local d; d="$(dirname "$1")"; cp "$RB" "$d/realign_bound.py"; cp "$1" "$d/realign_cert_mut.py"; (cd "$d" && "$PY" -I realign_cert_mut.py KAT); return 0; }
run_table_mut(){ gawk -M -f "$1" "$SNAP" "$CAND" "$CENSIN" 2>&1 | grep '^R2TAB=\|^TABLE DISCORD'; return 0; }
run_cert_mut(){ runcert page "$BSTAR_PAGE" "$1"; return 0; }

DK_BASE_RUN="$RUNN"
dk_tooth "$RC" "$MUT" tracebend \
  '    if trA != R or trB != R:' \
  '    if False:' \
  2 "REALIGN REFUSED: the partial traces of the projector at type d=2 h=0 split (1,0) have traces 2 and 2, not R = 1" build_cp run_negctl_mut
DK_BASE_RUN="$RUNT"
dk_tooth "$TBL" "$MUT" rdiscordbend \
  'num \* num \* RBD\[id\] > RBN\[id\] \* den \* den' \
  'num * num * RBD[id] < RBN[id] * den * den' \
  5 "TABLE DISCORD: 0 read rows above their own Frobenius bound; 0 read rows above their own realigned bound (of 3464 read rows carrying one" build_cp run_table_mut
dk_tooth "$TBL" "$MUT" preferbend \
  '(RBN\[id\] < B \* RBD\[id\])' \
  '(RBN[id] > B * RBD[id])' \
  5 "$RTAB_REC" build_cp run_table_mut
DK_BASE_RUN="$B/cert_page.run"
# (the TABLE mode's lines, not the sub-gas mode's copies of them: the GTL/TTL names and the indentation part the two sites -- law 22 at run a)
dk_tooth "$CERT" "$MUT" gammabend \
  'hh = 3 \* rootm_hi(tn ^ 2, td ^ 2, s); GTL\[s\]' \
  'hh = 30 * rootm_hi(tn ^ 2, td ^ 2, s); GTL[s]' \
  6 "$PASS_PAGE_PIN" build_cp run_cert_mut
dk_tooth "$CERT" "$MUT" entrybend \
  '      for (s = 9; s <= 24; s++) { split(TB\[s - 8\], tf, "/"); tn = tf\[1\] + 0;' \
  '      for (s = 9; s <= 24; s++) { split(TB[s - 8], tf, "/"); tn = (tf[1] + 0) * 1000;' \
  6 "$PASS_PAGE_PIN" build_cp run_cert_mut
# (a factor 2 on the entries SURVIVED at run b: the large-size rates rise a few per cent and the number's margin absorbs it -- law 18, the
#  bend corrected: a factor 1000 lifts every k >= 9 rate past the certificate's divergence line)

run_even_mut(){ local d; d="$(dirname "$1")"; cp "$1" "$d/even_stars_mut.py"; (cd "$d" && PYTHONIOENCODING=utf-8 "$PY" -I even_stars_mut.py kat); return 0; }
run_bud_mut(){ runbud 2500 1 69 "$1"; return 0; }
DK_BASE_RUN="$RUNE"
dk_tooth "$EVS" "$MUT" wickbend \
  'den \*= (2 \*\* k) \* math\.factorial(k + 1)' \
  'den *= (2 ** k) * math.factorial(k)' \
  9 "KAT K_2,2,2: S = 73/324 (want 73/324) N = 10512 m_max = 4 matchings = 729 MET" build_cp run_even_mut
DK_BASE_RUN="$RUNB"
dk_tooth "$CERT" "$MUT" tiltbend \
  'tl = exp_lo(g_lo(TILTN, TILTD)); th = exp_hi(g_hi(TILTN, TILTD));' \
  'tl = exp_lo(g_lo(TILTN, 2 * TILTD)); th = exp_hi(g_hi(TILTN, 2 * TILTD));' \
  10 "beta=2500 alpha=1 tilt=69/100 -> FAIL" build_cp run_bud_mut

run_w2_mut_free(){ local d; d="$(dirname "$1")"; (cd "$d" && cp "$1" w2_strip_mut.c && gcc -O2 -fopenmp -o w2_strip_mut.exe w2_strip_mut.c -lm > /dev/null 2>&1 && OMP_NUM_THREADS=8 ./w2_strip_mut.exe 2.2 2 2 free fwd 2>&1 | tr -d '\r'); return 0; }
run_w2_mut_rand(){ local d; d="$(dirname "$1")"; (cd "$d" && cp "$1" w2_strip_mut.c && gcc -O2 -fopenmp -o w2_strip_mut.exe w2_strip_mut.c -lm > /dev/null 2>&1 && OMP_NUM_THREADS=8 ./w2_strip_mut.exe 2.2 2 2 random:1 fwd 2>&1 | tr -d '\r'); return 0; }
DK_BASE_RUN="$RUNW"
dk_tooth "$W2C" "$MUT" chainbend \
  'add_loop_step(8, 7, 0, 0, 0, 2, -1);' \
  'add_loop_step(8, 7, 0, 0, 0, 2, 1);' \
  11 "W2-KAT FREE: Z = 1 [MET]; E[chi_a(A)] = d_a a_a^4 and every connected pair zero [MET]" build_cp run_w2_mut_free
dk_tooth "$W2C" "$MUT" fusionbend \
  'double w = RW\[pt\] \* DIM\[k\] \* chi(k, RU\[pt\]);' \
  'double w = RW[pt] * DIM[k + 1] * chi(k, RU[pt]);' \
  11 "W2-CHANNEL-SUM a=2 c=2 sum_k f_k = +3.075545316213e-06 against the class moment +3.075545316213e-06 (sum_k P_k = 1 to" build_cp run_w2_mut_free
run_coef_mut(){ runcoef "$COEFR" "$1"; return 0; }
DK_BASE_RUN="$RUNC"
dk_tooth "$CERT" "$MUT" coefbend \
  'AL\[j2\] = g_lo(cfn, cfd); AH\[j2\] = g_hi(cfn, cfd)' \
  'AL[j2] = g_lo(cfn, 2 * cfd); AH[j2] = g_hi(cfn, 2 * cfd)' \
  10 "KP-CERT dress=page coef=supplied beta=supplied alpha=1/1000 gamma=6/1 F0=20: kappa_U in [0.019543, 0.019543] root in [0.019543, 0.019543] u in [0.06233787, 0.06233787] u~ in [0.06356816, 0.06356816] r_hi=0.320393" build_cp run_coef_mut
DK_BASE_RUN="$RUNX"
dk_tooth "$W2C" "$MUT" staplebend \
  'memcpy(q, p, sizeof q); q\[k - 1\] += s; STAP\[l\]\[ns\]\[1\]\[0\] = okey(q, d); STAP\[l\]\[ns\]\[1\]\[1\] = -1;' \
  'memcpy(q, p, sizeof q); q[k - 1] += s; STAP[l][ns][1][0] = okey(q, d); STAP[l][ns][1][1] = 1;' \
  11 "W2-CLASS a=1 c=1 E[chi_a(A) chi_c(B)] = -1.607459101168e-03" build_cp run_w2_mut_rand

dk_teeth_pin 11

DK_BASE_RUN=""
dk_control "$RC" "$MUT" \
  '# answers of the prototype (exact S known) must satisfy exact^2 <= bound2S <= Frobenius^2; and law 6 outside this file: the DISCORD census' \
  '# answers of the prototype (exact S known) must satisfy exact^2 <= bound2S <= Frobenius^2; and law 6 outside this file: the DISCORD census (comment control)' \
  "$RUNK" build_cp run_kat_mut

dk_green "THE-TABLE-MODE-NUMBER-FROM-THE-FINITE-STAR-TABLE-EVERY-ENTRY-EXACT-OR-CERTIFIED-THE-REALIGNED-BOUND-UNDER-3416-EXACT-VALUES-THE-CERTIFICATE-PASSING-AT-THE-NUMBER-AND-REFUSED-ONE-STEP-ABOVE"
