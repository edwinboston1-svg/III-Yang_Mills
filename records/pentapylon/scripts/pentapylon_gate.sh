#!/usr/bin/env bash
# STDLIB/scripts/pentapylon_gate.sh -- ΠΕΝΤΑΠΥΛΟΝ G6-b, THE TUBE GAP'S SERIES THROUGH THE DESIGN LADDER (DOCS/III-PENTAPYLON-THE-FIVE-GATES-
# PREREGISTRATION.md, STAKE 2 of 2026-10-28 11:2x, committed 692d4f2fa strictly before the instrument STDLIB/build/pentapylon/g6_tube.pl).
#
# THE ARMS.
#   0  STRUCTURE: the instrument's pinned lines carry no decimal point (exact rationals; the G6-CELL reading is labelled and unpinned);
#      provenance (the page before the instrument); the record bound to the instrument and to ΑΠΕΡΑΝΤΟΝ's awk by sha256; the frozen
#      pins named by the record's sha256.
#   1  THE KNOWN ANSWERS live: G6-KAT misses=0 (the Catalan numbers to C_7; every shadow's class sizes summing to |G| and m_2 = 1; the
#      hand's even moments at n = 4..12; the parting orders 2, 4, 6, 10).
#   2  THE RECORD re-derived whole (the live rec byte-identical below the header), the frozen pins read back; the moments' columns at
#      n = 4, 6, 8, 12 pinned as the page's hand wrote them; the parting coefficients pinned from the record (UNGUESSED on the page).
#   3  THE DESIGN LADDER: the parting order of every shadow equals t - 1, t the design strength ΑΠΕΡΑΝΤΟΝ's awk DERIVES from the
#      quaternion tables (MODE=design: the first 2j carrying an invariant; t = 2j - 1), composed read-only, never typed.
#   4  THE LADDER (STAKE 4, 7bfd384bd): SU(2)'s tube coefficient I2(2b)/I1(2b) and every shadow's enclosed in exact dyadic intervals (g6_ladder.pl,
#      Math::BigInt fixed point), the defect delta_G = -4 ln(c_G/c_SU2) FALLING strictly along the ladder at y = 1/2, 1/4, 1/8, 1/16 and NEGATIVE,
#      the two roads (certified against STAKE 2's series) MET at y = 1/2; 20 known answers; the record bound to the tube record by sha256.
#   5  THE BOXES (STAKE 5, bdc90b336): ΤΟΜΕΥΣ' box records (2x4 at y = 1/2, 1/4, 1/5; 2x2 and 2x3 at 1/5) read by g7_read.awk (gawk -M, a reading a
#      logarithm of two brackets, nothing typed; 3 known answers), bound by sha256 to the reader, the records, ΣΤΡΟΦΙΓΞ's organ and ΤΟΜΕΥΣ' harness;
#      the string test NEITHER ALIVE, the scaling window DIED, the partings, the y = 1/5 refusal pinned from the run.
#      ARM 5 (live): the box exe built here (the tomeus recipe) and the eight quick cells re-derived live, byte-identical to their records; the 4x4
#      and 1x2 refusals by name -- the harness's x mode and the door tested by an engine they do not own, so tom_main.iii lands on this green.
# DOKIMASIA (predicted in STDLIB/build/pentapylon/tooth_predictions.2026-10-28.txt before any mutant ran): ordbend, catalanbend,
# partbend, each at ARM 1's pin G6-KAT misses=0; lnbend, tailbend, fourbend at ARM 4's pin G6L-KAT misses=0 checks=20; logbend, tubebend, stringbend at ARM 5's pins; the comment control silent.  W = 0: Burnside's moments, the Catalan numbers, the
# strong-coupling tube (Munster, Kogut), the design strength as a moment statement; III's: the exact parting orders and coefficients.
set -u
ROOT="$(cd "$(dirname "$0")/../.." && pwd)"; cd "$ROOT" || exit 9
DK_ORGAN="pentapylon"
. "$ROOT/STDLIB/scripts/lib/dokimasia.sh"
export PATH=/c/ProgramData/mingw64/mingw64/bin:$PATH
B="$ROOT/STDLIB/build/pentapylon"; MUT="$B/mut"
SRC="$B/g6_tube.pl"
AWK="$ROOT/STDLIB/scripts/aperanton_shadow_hinge.awk"
PRE="$ROOT/DOCS/III-PENTAPYLON-THE-FIVE-GATES-PREREGISTRATION.md"
REC="$B/g6_tube.2026-10-28b.txt"; PINS="$B/g6_pins.txt"; PRED="$B/tooth_predictions.2026-10-28.txt"
RUNK="$B/g_kat.txt"; RUNR="$B/g_rec.txt"
mkdir -p "$MUT"
for f in "$SRC" "$AWK" "$PRE" "$REC" "$PINS" "$PRED"; do [ -f "$f" ] || dk_red "missing: $f"; done
dk_provenance "$PRE" "$SRC"
grep -q 'ΠΕΝΤΑΠΥΛΟΝ' "$PRE" || dk_red "the page does not stake ΠΕΝΤΑΠΥΛΟΝ"

# ---- ARM 0: STRUCTURE ----
grep -E '^G6-(KAT|MOM|U|GAPSERIES|PART|PARTING-ORDERS) ' "$REC" | grep -q '[0-9]\.[0-9]' && dk_red "ARM 0: a decimal point in a pinned line -- the pins are exact rationals"
grep -qF -- "instrument g6_tube.pl sha256 $(sha256sum "$SRC" | cut -c1-64)" "$REC" || dk_red "ARM 0: the record was not made by this instrument: re-take it"
grep -qF -- "aperanton_shadow_hinge.awk (the design strengths the gate composes) sha256 $(sha256sum "$AWK" | cut -c1-64)" "$REC" || dk_red "ARM 0: the record was not made beside this ΑΠΕΡΑΝΤΟΝ awk"
grep -qF -- "sha256 $(sha256sum "$REC" | cut -c1-64) " "$PINS" || dk_red "ARM 0: the frozen pins do not name the record by its sha256"
dk_say "ARM 0: the pinned lines exact rationals; the page before the instrument; the record bound to the instrument and to ΑΠΕΡΑΝΤΟΝ's awk by sha256; the pins named by the record's sha256"

# ---- THE BUILD (a perl instrument: the syntax check is the compile, a copy the object) ----
pcc(){ perl -c "$1" > /dev/null 2>&1 && cp "$1" "$2"; }
prun(){ perl "$1" kat 2>&1 | tr -d '\r'; }
pcc "$SRC" "$B/g_tube.pl" || dk_red "the instrument does not parse"
perl "$B/g_tube.pl" kat 2>&1 | tr -d '\r' > "$RUNK" || true
perl "$B/g_tube.pl" rec 2>&1 | tr -d '\r' > "$RUNR" || true

# ---- ARM 1: THE KNOWN ANSWERS ----
dk_have "$RUNK" 'G6-KAT misses=0'
dk_say "ARM 1: the known answers live -- the Catalan numbers to C_7, every shadow's class sizes summing to |G| with m_2 = 1, the hand's even moments at n = 4..12, the parting orders 2, 4, 6, 10 -- misses 0"

# ---- ARM 2: THE RECORD WHOLE, THE PINS, THE COLUMNS ----
tail -n +2 "$REC" > "$B/g_rec_body.txt"
cmp -s "$RUNR" "$B/g_rec_body.txt" || { diff "$RUNR" "$B/g_rec_body.txt" | head -4 | cut -c1-160; dk_red "ARM 2: the live record run differs from the record"; }
dk_pins_from "$PINS" "$RUNR"
dk_have "$RUNR" 'G6-MOM n=4 SU2=2 Q8=4 2T=2 2O=2 2I=2'
dk_have "$RUNR" 'G6-MOM n=6 SU2=5 Q8=16 2T=6 2O=5 2I=5'
dk_have "$RUNR" 'G6-MOM n=8 SU2=14 Q8=64 2T=22 2O=15 2I=14'
dk_have "$RUNR" 'G6-MOM n=12 SU2=132 Q8=1024 2T=342 2O=187 2I=133'
dk_have "$RUNR" 'G6-PART G=Q8 first-order=b^2 coefficient=-4/3 '
dk_have "$RUNR" 'G6-PART G=2T first-order=b^4 coefficient=-1/30 '
dk_have "$RUNR" 'G6-PART G=2O first-order=b^6 coefficient=-1/1260 '
dk_have "$RUNR" 'G6-PART G=2I first-order=b^10 coefficient=-1/9979200 '
dk_have "$RUNR" 'G6 DONE misses=0'
dk_say "ARM 2: the record re-derived whole and its pins read back; the moments at n = 4, 6, 8, 12 as the page's hand wrote them (SU(2) the Catalan numbers 2, 5, 14, 132; Q8 4, 16, 64, 1024; 2T 2, 6, 22, 342; 2O 2, 5, 15, 187; 2I 2, 5, 14, 133); the gap series' parting coefficients pinned from the record -- Q8 -4/3 at b^2, 2T -1/30 at b^4, 2O -1/1260 at b^6, 2I -1/9979200 at b^10 (UNGUESSED on the page, regression guards now)"

# ---- ARM 3: THE DESIGN LADDER, t COMPOSED FROM ΑΠΕΡΑΝΤΟΝ'S AWK ----
ORDERS=$(grep -m1 '^G6-PARTING-ORDERS ' "$RUNR") || dk_red "ARM 3: no parting-orders line"
for pair in Q8:q8 2T:2t 2O:2o 2I:2i; do
  g=${pair%%:*}; a=${pair##*:}
  t=$(gawk -M -v PREC=96 -v GROUP="$a" -v MODE=design -f "$AWK" 2>/dev/null | sed -n 's/.*invariants_by_2j=\[\(.*\)\].*/\1/p' | tr ' ' '\n' | awk -F: '$2 + 0 > 0.5 { print $1 - 1; exit }')
  [ -n "$t" ] || dk_red "ARM 3: ΑΠΕΡΑΝΤΟΝ's awk gave no design strength for $g"
  o=$(printf '%s\n' "$ORDERS" | grep -o " $g=[0-9]*" | sed 's/.*=//')
  [ "$o" = "$((t - 1))" ] || dk_red "ARM 3: $g parts at b^$o while its design strength is t = $t (the stake: t - 1)"
  dk_say "ARM 3: $g -- design strength t = $t from the quaternion table, the gap series parting at b^$o = t - 1"
done
dk_say "ARM 3: THE DESIGN LADDER -- the tube gap's strong-coupling series parts from SU(2)'s at b^(t-1) at every rung, t = 3, 5, 7, 11 derived from the tables, the parting coefficients -4/3, -1/30, -1/1260, -1/9979200 falling seven million-fold from Q8 to 2I"

# ---- ARM 4: THE LADDER (STAKE 4, landed 7bfd384bd strictly before g6_ladder.pl) -- SU(2)'s tube coefficient enclosed and the ----
# defect column delta_G = -4 ln(c_G/c_SU2) as certified intervals at y = 1/2, 1/4, 1/8, 1/16 (Math::BigInt fixed point, dyadic endpoints,
# no float): the known answers live; the record re-derived whole and its pins read back; the order (FALLS-SEPARATED at every y) and the
# signs (NEG at 1/2 and 1/4 as staked; NEG at 1/8 and 1/16, UNGUESSED on the page, regression guards now) pinned from the run and
# RE-DERIVED from the record's DEFECT intervals by this gate's own awk (a second reading of one record); the two roads' meet at y = 1/2
# (the certified defect against STAKE 2's difference series read from the tube record) pinned MET at every rung; every interval under 1e-20.
SRC2="$B/g6_ladder.pl"; REC2="$B/g6_ladder.2026-10-28b.txt"; PINS2="$B/g6_ladder_pins.txt"; RUNK2="$B/g_lkat.txt"; RUNR2="$B/g_lrec.txt"
for f in "$SRC2" "$REC2" "$PINS2"; do [ -f "$f" ] || dk_red "missing: $f"; done
dk_provenance "$PRE" "$SRC2"
grep -q '^use strict; use warnings; use Math::BigInt;' "$SRC2" || dk_red "ARM 4: the ladder instrument does not declare Math::BigInt as its arithmetic"
grep -q 'use Math::BigRat\|use Math::BigFloat' "$SRC2" && dk_red "ARM 4: the ladder instrument loads a rational or float tier (the fixed point is the arithmetic)"
grep -qF -- "instrument g6_ladder.pl sha256 $(sha256sum "$SRC2" | cut -c1-64)" "$REC2" || dk_red "ARM 4: the ladder record was not made by this instrument: re-take it"
grep -qF -- "g6_tube.2026-10-28b.txt (the series road) sha256 $(sha256sum "$REC" | cut -c1-64)" "$REC2" || dk_red "ARM 4: the ladder record was not made beside this tube record"
grep -qF -- "sha256 $(sha256sum "$REC2" | cut -c1-64) " "$PINS2" || dk_red "ARM 4: the frozen ladder pins do not name the record by its sha256"
pcc "$SRC2" "$B/g_ladder.pl" || dk_red "the ladder instrument does not parse"
perl "$B/g_ladder.pl" kat 2>&1 | tr -d '\r' > "$RUNK2" || true
perl "$B/g_ladder.pl" rec 2>&1 | tr -d '\r' > "$RUNR2" || true
dk_have "$RUNK2" 'G6L-KAT misses=0 checks=20'
tail -n +2 "$REC2" > "$B/g_lrec_body.txt"
cmp -s "$RUNR2" "$B/g_lrec_body.txt" || { diff "$RUNR2" "$B/g_lrec_body.txt" | head -4 | cut -c1-160; dk_red "ARM 4: the live ladder record differs from the record"; }
dk_pins_from "$PINS2" "$RUNR2"
for y in 1/2 1/4 1/8 1/16; do grep -qE "^G6L-ORDER y=$y Q8>2T>2O>2I magnitudes=.* FALLS-SEPARATED\$" "$RUNR2" || dk_red "ARM 4: the order at y = $y is not FALLS-SEPARATED"; done
dk_have "$RUNR2" 'G6L-SIGN y=1/2 Q8=NEG 2T=NEG 2O=NEG 2I=NEG'
dk_have "$RUNR2" 'G6L-SIGN y=1/4 Q8=NEG 2T=NEG 2O=NEG 2I=NEG'
dk_have "$RUNR2" 'G6L-SIGN y=1/8 Q8=NEG 2T=NEG 2O=NEG 2I=NEG'
dk_have "$RUNR2" 'G6L-SIGN y=1/16 Q8=NEG 2T=NEG 2O=NEG 2I=NEG'
for g in Q8 2T 2O 2I; do grep -qE "^G6L-MEET G=$g y=1/2 .* MET\$" "$RUNR2" || dk_red "ARM 4: the two roads part at $g"; done
dk_have "$RUNR2" 'G6L-WIDTH max=0.000000000000000000000000000001 below-1e-20=YES'
dk_have "$RUNR2" 'G6L DONE misses=0'
# the gate's own reading of the record's DEFECT intervals (doubles suffice: the intervals are parted by far more than a double resolves)
AWKV=$(awk '/^G6L-DEFECT /{ for (i = 1; i <= NF; i++) { if ($i ~ /^G=/) g = substr($i, 3); if ($i ~ /^y=/) y = substr($i, 3); if ($i ~ /^delta=/) { s = substr($i, 8); sub(/\]$/, "", s); split(s, e, ","); lo[y, g] = e[1] + 0; hi[y, g] = e[2] + 0 } } ys[y] = 1 }
  END { n = split("Q8 2T 2O 2I", G, " "); bad = 0; for (y in ys) { for (i = 1; i <= n; i++) { g = G[i]; if (!(hi[y, g] < 0)) { bad++; print "SIGN-NOT-NEG " y " " g } m1[i] = (hi[y, g] <= 0) ? -hi[y, g] : lo[y, g]; m2[i] = (hi[y, g] <= 0) ? -lo[y, g] : hi[y, g] } for (i = 1; i < n; i++) if (!(m1[i] > m2[i + 1])) { bad++; print "NOT-FALLING " y " " G[i] ">" G[i + 1] } } print "AWK-READING bad=" bad }' "$RUNR2")
printf '%s\n' "$AWKV" | grep -q '^AWK-READING bad=0$' || { printf '%s\n' "$AWKV" | head -5; dk_red "ARM 4: the gate's own reading of the DEFECT intervals disagrees with the record's order or signs"; }
dk_say "ARM 4: THE LADDER -- SU(2)'s tube coefficient I2(2b)/I1(2b) enclosed at y = 1/2 .. 1/16 (0.1699, 0.3218, 0.4459, 0.5418) and the defect column delta_G = -4 ln(c_G/c_SU2) certified: at every y the magnitude FALLS strictly along Q8 > 2T > 2O > 2I with the intervals separated (y = 1/2: 0.151, 4.6e-4, 1.3e-6, 2.4e-12; y = 1/16: 1.150, 0.0733, 0.00323, 1.5e-6), every defect NEGATIVE (the shadow's tube gap below SU(2)'s), the two roads meeting at y = 1/2 within 3.1e-10, 1.7e-11, 1.4e-12, 2.8e-15; 20 known answers, every interval under 1e-30; the gate's own awk reads the same order and signs from the intervals"

# ---- ARM 5: THE BOXES (STAKE 5, landed bdc90b336 strictly before the box door; RESULTS 5 2ca123465) -- the 2x4, 2x2 and 2x3 box ----
# records of ΤΟΜΕΥΣ' box mode read by g7_read.awk (gawk -M at 256 bits: every reading a logarithm of two brackets, nothing typed): the
# reader's record bound by sha256 to the reader, to the box records, to ΤΟΜΕΥΣ' records of record (z2.run, c.run), to ΣΤΡΟΦΙΓΞ's organ
# and ΤΟΜΕΥΣ' harness as they stand; the record re-derived whole and its pins read back; the three known answers live; the string
# test's verdict (NEITHER ALIVE), the scaling window (DIED), the partings, the y = 1/5 refusal pinned from the run.
SRC3="$B/g7_read.awk"; REC3="$B/g7/g7_read.2026-10-28c.txt"; PINS3="$B/g7_pins.txt"; RUNR3="$B/g_boxrec.txt"
TOMZ2="$ROOT/STDLIB/build/tomeus/z2.run"; TOMC="$ROOT/STDLIB/build/tomeus/c.run"
BOXES=("$B/g7/g7_box_2x4_yk2.txt" "$B/g7/g7_box_2x4_yk4.txt" "$B/g7/g7_box_2x4_yk5.txt" "$B/g7/g7_box_2x2_yk5.txt" "$B/g7/g7_box_2x3_yk5.txt" "$B/g7/g7_box_2x2_yk3.txt" "$B/g7/g7_box_2x3_yk3.txt" "$B/g7/g7_box_2x4_yk3.txt")   # an ARRAY: the repo path holds a space (§4)
for f in "$SRC3" "$REC3" "$PINS3" "$TOMZ2" "$TOMC" "${BOXES[@]}"; do [ -f "$f" ] || dk_red "missing: $f"; done
grep -qF -- "reader g7_read.awk sha256 $(sha256sum "$SRC3" | cut -c1-64)" "$REC3" || dk_red "ARM 5: the box reading was not made by this reader: re-take it"
for f in "${BOXES[@]}" "$TOMZ2" "$TOMC"; do grep -qF -- "$(basename "$f") sha256 $(sha256sum "$f" | cut -c1-64)" "$REC3" || dk_red "ARM 5: the box reading was not made on this record: $(basename "$f")"; done
grep -qF -- "strophinx.iii sha256 $(sha256sum "$ROOT/STDLIB/iii/aether/strophinx.iii" | cut -c1-64)" "$REC3" || dk_red "ARM 5: the box records were not made by ΣΤΡΟΦΙΓΞ as it stands"
grep -qF -- "tom_main.iii sha256 $(sha256sum "$ROOT/STDLIB/build/tomeus/tom_main.iii" | cut -c1-64)" "$REC3" || dk_red "ARM 5: the box records were not made by ΤΟΜΕΥΣ' harness as it stands"
grep -qF -- "sha256 $(sha256sum "$REC3" | cut -c1-64) " "$PINS3" || dk_red "ARM 5: the frozen box pins do not name the reading by its sha256"
grep -q '^TOM box lx=2 ly=4$' "$B/g7/g7_box_2x4_yk2.txt" || dk_red "ARM 5: the 2x4 record does not open with the box door's line"
acc(){ gawk -M -f "$1" /dev/null > /dev/null 2>&1 && cp "$1" "$2"; }
arun(){ gawk -M -f "$1" "$TOMZ2" "$TOMC" "${BOXES[@]}" 2>&1 | tr -d '\r'; }   # the array expanded quoted: the repo path holds a space (§4; run g read "cannot open /c/Users/Edwin")
acc "$SRC3" "$B/g_read.awk" || dk_red "the box reader does not parse"
arun "$B/g_read.awk" > "$RUNR3" || true
tail -n +2 "$REC3" > "$B/g_boxrec_body.txt"
cmp -s "$RUNR3" "$B/g_boxrec_body.txt" || { diff "$RUNR3" "$B/g_boxrec_body.txt" | head -4 | cut -c1-160; dk_red "ARM 5: the live box reading differs from the record"; }
dk_have "$RUNR3" 'G7-KAT misses=0 checks=3'
dk_pins_from "$PINS3" "$RUNR3"
grep -qE '^G7-STRING y=1/2 perp=2 .* verdict=NEITHER ALIVE ' "$RUNR3" || dk_red "ARM 5: the three-length string test's verdict moved (staked UNGUESSED among TWOPOINT, LUSCHER, NEITHER; read NEITHER ALIVE)"
grep -qE '^G7-SCALING y=1/4 .* WINDOW-DIED$' "$RUNR3" || dk_red "ARM 5: the scaling window's verdict moved (read DIED on the 2x4 cell)"
for L in 2x3 2x4; do for y in 1/2 1/4; do grep -qE "^G7-PART G=Z2 y=$y L=$L .* PARTED\$" "$RUNR3" || dk_red "ARM 5: (1,0) and (0,1) are not parted on $L at y = $y"; done; done
grep -qE '^G7-REFUSED file=.*g7_box_2x4_yk5.txt blocks=13 misses=13 ' "$RUNR3" || dk_red "ARM 5: the y = 1/5 refusal of the electric sectors on 2x4 is not read as thirteen blocks"
dk_have "$RUNR3" 'G7 DONE misses=0'
dk_say "ARM 5: THE BOXES -- ΣΤΡΟΦΙΓΞ's door reading its caps and ΤΟΜΕΥΣ' box mode give the 2x4 cell at y = 1/2, 1/3, 1/4, 1/5 and the 2x2, 2x3 cells at 1/3 and 1/5; E(4 | perp 2) = 4.216358 at y = 1/2 is ALIVE in [4.20, 4.26] and at NEITHER prediction (the two-point law 4.228543, Luscher 4.230996-4.238008), the three-point solve leaving 0.1218 at L = 2; the 2x4 gap ratio to the tube 0.871776; m sqrt(8) = 4.101342 at y = 1/4 -- the scaling window DIED; the strip m(2 x L) = 2.291106, 1.788305, 1.450043; the ordered side at y = 1/5: 2.599763, 2.171204, 1.919771; (1,0)/(0,1) parted on every box without the swap; the y = 1/5 electric sectors on 2x4 refused by the 60-bit entry (thirteen blocks); the reader's three known answers met"

# ---- ARM 5 (live): THE BOX EXE BUILT HERE AND THE QUICK CELLS RE-DERIVED (2026-10-28 14:2x, the desktop seat) -- the harness's x mode ----
# and ΣΤΡΟΦΙΓΞ's cap-reading door TESTED by an engine they do not own (law 3): the chain compiled by the tomeus recipe into $B/g7build,
# the eight quick cells (2x4 at y = 1/2, 1/3, 1/4, 1/5; 2x2 and 2x3 at 1/3 and 1/5) run live and compared byte for byte with the committed
# box records, the 4x4 box and the 1x2 dead control refused by name; the three 3x4 refusals stay bound by sha256 (their orbit setup costs
# twenty minutes before the refusal).  So tom_main.iii lands through this gate's green with its x mode exercised here, hours before ΤΟΜΕΥΣ'
# own five-hour wave re-certifies the composition -- the landing order the doorseal law allows: a composer's full re-run is its cadence,
# not a precondition for the composed change whose own gate and whose consumer's live build both read green.
G7B="$B/g7build"; G7L="$B/g7live"; rm -rf "$G7B" "$G7L"; mkdir -p "$G7B" "$G7L"
IIIS="$ROOT/COMPILED/iiis-2.exe"; [ -x "$IIIS" ] || dk_red "ARM 5 (live): iiis-2 missing"
ARC="$ROOT/STDLIB/build/iii/libiii_native.a"; [ -f "$ARC" ] || dk_red "ARM 5 (live): libiii_native.a missing"
HRN="$ROOT/STDLIB/build/tomeus/tom_main.iii"; SFXO="$ROOT/STDLIB/iii/aether/strophinx.iii"
for m in verba/keryx aether/belos aether/apeiron aether/kampylotes aether/metaplasis aether/heligmos numera/megethos memoria/arena numera/bigint numera/bigint_div numera/modular aether/resultant aether/sturm_big aether/charpoly aether/strophinx aether/tomeus; do
  b=$(basename "$m"); "$IIIS" "$ROOT/STDLIB/iii/$m.iii" --compile-only --out "$G7B/g_$b.o" > "$G7B/cc_$b.log" 2>&1 || { tail -3 "$G7B/cc_$b.log"; dk_red "ARM 5 (live): cc $m"; }
done
"$IIIS" "$HRN" --compile-only --out "$G7B/g_main.o" > "$G7B/cc_main.log" 2>&1 || { tail -3 "$G7B/cc_main.log"; dk_red "ARM 5 (live): cc the harness"; }
gcc -o "$G7B/g7_box.exe" "$G7B/g_main.o" "$G7B/g_tomeus.o" "$G7B/g_strophinx.o" "$G7B/g_keryx.o" "$G7B/g_belos.o" "$G7B/g_apeiron.o" "$G7B/g_kampylotes.o" "$G7B/g_metaplasis.o" "$G7B/g_heligmos.o" "$G7B/g_megethos.o" "$G7B/g_arena.o" "$G7B/g_bigint.o" "$G7B/g_bigint_div.o" "$G7B/g_modular.o" "$G7B/g_resultant.o" "$G7B/g_sturm_big.o" "$G7B/g_charpoly.o" -Wl,--start-group "$ARC" -Wl,--end-group -lws2_32 -lkernel32 -Wl,--allow-multiple-definition > "$G7B/ln.log" 2>&1 || { tail -3 "$G7B/ln.log"; dk_red "ARM 5 (live): the box exe did not link"; }
boxrun(){ timeout 1200 "$G7B/g7_box.exe" x "$1" "$2" 0 "$3" 4 1 < /dev/null 2>&1 | tr -d '\r' > "$G7L/g7_box_${1}x${2}_yk$3.txt"; }
for c in "2 4 2" "2 4 3" "2 4 4" "2 4 5" "2 2 3" "2 2 5" "2 3 3" "2 3 5"; do set -- $c; boxrun "$1" "$2" "$3"; done
for c in 2x4_yk2 2x4_yk3 2x4_yk4 2x4_yk5 2x2_yk3 2x2_yk5 2x3_yk3 2x3_yk5; do cmp -s "$G7L/g7_box_$c.txt" "$B/g7/g7_box_$c.txt" || { diff "$G7L/g7_box_$c.txt" "$B/g7/g7_box_$c.txt" | head -3 | cut -c1-160; dk_red "ARM 5 (live): the live cell $c differs from its record"; }; done
timeout 60 "$G7B/g7_box.exe" x 4 4 0 2 4 1 < /dev/null 2>&1 | tr -d '\r' | grep -q 'TOM-REFUSED the carrier door refused the box: err=18' || dk_red "ARM 5 (live): the 4x4 box was not refused by name"
timeout 60 "$G7B/g7_box.exe" x 1 2 0 2 4 1 < /dev/null 2>&1 | tr -d '\r' | grep -q 'TOM-REFUSED the carrier door refused the box: err=18' || dk_red "ARM 5 (live): the 1x2 dead control was not refused by name"
dk_tested "$HRN"; dk_tested "$SFXO"
dk_say "ARM 5 (live): the box exe built here from the chain, ΣΤΡΟΦΙΓΞ, ΤΟΜΕΥΣ and the harness; the eight quick cells re-derived live and byte-identical to their records; the 4x4 box and the 1x2 control refused by name -- the harness's x mode and the cap-reading door tested by an engine they do not own"


# ---- ARM 6: THE DUAL-SPIN ROAD (G6 (a) and G7, 2026-10-28 15:5x EDT, the desktop seat) -- the second road to ΤΟΜΕΥΣ' Z2 cells, sharing ----
# no line with the organ (law 6): the electric basis's transfer matrix on the L1 x L2 torus, g6_dual.pl writing the symmetric sector's
# matrix as exact integer polynomials in u and g6_dual.awk reading its top two roots at 320 bits.  Re-derived LIVE on every run (the kat
# mode, half a minute): the fourteen certified Z2 cells of the tree met inside their brackets (G6D-KAT), the 3x4 box read past the organ's
# walls (the stake for the second widening's cells), the 3x3 box at 1/3 and 1/5 -- and compared line for line with the record of 2026-10-28a.
# FROZEN and bound by sha256: the series points (r = lambda_1/(lambda_0 u^4) - 1 at u = 1/1000 .. 1/8000 on 3x3, 1/500 .. 1/2000 on the
# 2-wide boxes) and the (2,3) crossing scan; the 4x4 box (787 orbits) and the (3,4) crossing scan.  THE ISING ANCHOR, live: the two
# coefficients read on 3x3 (u^2: 1; u^4: -15/2) reproduce Arisue-Tabata's lambda'_3 and lambda'_4 through Wegner's duality (u_I = u^2), and
# their lambda'_5 .. lambda'_8 solve the infinite lattice's u^6 .. u^12 -- the ten published coefficients met, the Delta(u) line pinned.
SRC4="$B/g6_dual.pl"; SRC5="$B/g6_dual.awk"; SRC6="$B/g6_ising_anchor.pl"; SPL="$B/g6_dual_sector.pl"; DRV="$B/g6_dual_run.sh"
RECK="$B/g6_dual_kat.2026-10-28c.txt"; RECS="$B/g6_dual_series.2026-10-28a.txt"; RECB="$B/g6_dual_4x4.2026-10-28a.txt"; RECA="$B/g6_ising_anchor.2026-10-28a.txt"; RECE="$B/g6_dual_sec10_4x4.2026-10-28a.txt"
for f in "$SRC4" "$SRC5" "$SRC6" "$SPL" "$DRV" "$RECK" "$RECS" "$RECB" "$RECA" "$RECE"; do [ -f "$f" ] || dk_red "ARM 6: missing $f"; done
sha6(){ sha256sum "$1" | cut -c1-64; }
# the frozen records bind the two stages (the driver only orchestrates them; its own digest is bound through the live kat record, taken after it grew the string sector)
for r in "$RECK" "$RECS" "$RECB"; do dk_have "$r" "instrument-stage1=$(sha6 "$SRC4")"; dk_have "$r" "instrument-stage2=$(sha6 "$SRC5")"; done
dk_have "$RECK" "driver=$(sha6 "$DRV")"; dk_have "$RECK" "sector-instrument=$(sha6 "$SPL")"
[ "$(sha6 "$RECS")" = "d64bb03c26975e59c2cada08e5a96f4fca0ebd9666be18687a410f28cf0e8e78" ] || dk_red "ARM 6: the series record moved"
[ "$(sha6 "$RECB")" = "a2fde364675d652cb766d588edc0a234b3aca6b91daa6870d2e85fa165343d51" ] || dk_red "ARM 6: the 4x4 record moved"
[ "$(sha6 "$RECA")" = "8b8df22ec43e778c2e5cde26e65746ee237ed7ee0d2d192b61c96e02b31cbeec" ] || dk_red "ARM 6: the anchor record moved"
[ "$(sha6 "$RECE")" = "da25baaae1bdb128cad8665471633e7ac2a001cfcd4dee128da76c5f06b23b5c" ] || dk_red "ARM 6: the 4x4 string record moved"
dk_have "$RECE" "sector-instrument=$(sha6 "$SPL")"; dk_have "$RECE" "instrument-stage2=$(sha6 "$SRC5")"
# THE DETECTOR (STAKE 7 (i)): g6_dual_corr.awk run live through the driver's corr mode on 3x3 and 3x4 at 1/2 and 1/4, compared line for line
# with its record; the 4x4 box's record frozen and bound
CAWK="$B/g6_dual_corr.awk"; RECC="$B/g6_dual_corr.2026-10-28a.txt"; RECC4="$B/g6_dual_corr_4x4.2026-10-28a.txt"
for f in "$CAWK" "$RECC" "$RECC4"; do [ -f "$f" ] || dk_red "ARM 6: missing $f"; done
dk_have "$RECC" "detector=$(sha6 "$CAWK")"; dk_have "$RECC4" "detector=$(sha6 "$CAWK")"
[ "$(sha6 "$RECC4")" = "aa7774b043dc8311a7c3686ea20e5f5f35dfbd90e853a71d12999c02f69bad22" ] || dk_red "ARM 6: the 4x4 detector record moved"
# THE EXPONENT AND THE GAP MINIMA (the nu mode): re-derived live (the 2x2 and 3x3 derivatives and scans are seconds; the 4x4 side reads the 4x4 record) and compared with the record
RECN="$B/g6_dual_nu.2026-10-28a.txt"; [ -f "$RECN" ] || dk_red "ARM 6: missing $RECN"
[ "$(sha6 "$RECN")" = "1af2e1e0afb4a22e57302807bf270c2cfe2bd5e2335f018b9501d5de237df65c" ] || dk_red "ARM 6: the nu record moved"
LIVEN="$B/g_dnu.txt"; rm -f "$LIVEN"; bash "$DRV" nu > "$LIVEN" 2>&1 || dk_red "ARM 6: the nu mode refused"
cmp -s <(grep -v '^G6D-RECORD' "$LIVEN") <(grep -v '^G6D-RECORD' "$RECN") || { diff <(grep -v '^G6D-RECORD' "$LIVEN") <(grep -v '^G6D-RECORD' "$RECN") | head -4 | cut -c1-160; dk_red "ARM 6: the nu mode's live run differs from its record"; }
RECL="$B/g6_dual_scan4lo.2026-10-28a.txt"; [ -f "$RECL" ] || dk_red "ARM 6: missing $RECL"
[ "$(sha6 "$RECL")" = "929726c5aa0383bff11302f439cca923e6726bc32c429c35c102a5eaf3dfedd7" ] || dk_red "ARM 6: the low-u (3,4) scan record moved"
dk_have "$RECL" "instrument-stage1=$(sha6 "$SRC4")"; dk_have "$RECL" "instrument-stage2=$(sha6 "$SRC5")"
[ "$(grep -c '^G6D-SCAN4 u=0.5.* diff=-' "$RECL")" -eq 4 ] || dk_red "ARM 6: the low-u scan does not read four negative differences below u = 0.60"
LIVEC="$B/g_dcorr.txt"; rm -f "$LIVEC"; bash "$DRV" corr > "$LIVEC" 2>&1 || dk_red "ARM 6: the detector's driver mode refused"
cmp -s <(grep -v '^G6D-RECORD' "$LIVEC") <(grep -v '^G6D-RECORD' "$RECC") || { diff <(grep -v '^G6D-RECORD' "$LIVEC") <(grep -v '^G6D-RECORD' "$RECC") | head -4 | cut -c1-160; dk_red "ARM 6: the detector's live run differs from its record"; }
[ "$(grep -c 'violations=0 ' "$LIVEC")" -eq 4 ] || dk_red "ARM 6: the detector's theorem check did not read zero violations on all four cells"
[ "$(grep -c 'violations=0 ' "$RECC4")" -eq 2 ] || dk_red "ARM 6: the 4x4 detector record does not read zero violations on both cells"
LIVEK="$B/g_dkat.txt"; rm -f "$LIVEK"; bash "$DRV" kat > "$LIVEK" 2>&1 || dk_red "ARM 6: the driver refused"
dk_have "$LIVEK" 'G6D-KAT misses=0 checks=14'
dk_have "$LIVEK" 'G6D-STRING misses=0 checks=6'
cmp -s <(grep -v '^G6D-RECORD' "$LIVEK") <(grep -v '^G6D-RECORD' "$RECK") || { diff <(grep -v '^G6D-RECORD' "$LIVEK") <(grep -v '^G6D-RECORD' "$RECK") | head -4 | cut -c1-160; dk_red "ARM 6: the live kat run differs from the record of 2026-10-28a"; }
LIVEKF="$B/g_dkat_nosha.txt"; grep -v '^G6D-RECORD' "$LIVEK" > "$LIVEKF"
LIVEA="$B/g_danchor.txt"; rm -f "$LIVEA"; perl "$SRC6" > "$LIVEA" 2>&1 || dk_red "ARM 6: the anchor refused"
cmp -s "$LIVEA" "$RECA" || dk_red "ARM 6: the anchor's live output differs from its record"
[ "$(grep -c '\[MET\]' "$LIVEA")" -eq 10 ] || dk_red "ARM 6: the anchor does not meet all ten published coefficients"
dk_have "$LIVEA" 'ISING-ANCHOR Delta(u) = -4 ln u + (1) u^2 + (-15/2) u^4 + (7/3) u^6 + (-87/4) u^8 + (251/5) u^10 + (-331/2) u^12'
dk_have "$RECK" 'DUAL G=Z2 L=3x4 u=1/3 y=2/4 orbits=88'
dk_have "$RECK" 'gap=4.407142121643281158'
dk_have "$RECK" 'DUAL G=Z2 L=3x4 u=1/2 y=1/3 orbits=88'
dk_have "$RECK" 'gap=2.288153115638292934'
dk_have "$RECK" 'DUAL G=Z2 L=3x4 u=3/5 y=2/8 orbits=88'
dk_have "$RECK" 'gap=1.247950357913738823'
dk_have "$RECK" 'DUAL G=Z2 L=3x4 u=2/3 y=1/5 orbits=88'
dk_have "$RECK" 'gap=1.627693055800359981'
dk_have "$RECB" 'DUAL G=Z2 L=4x4 u=1/3 y=2/4 orbits=787'
dk_have "$RECB" 'gap=4.413260813120230344'
dk_have "$RECB" 'DUAL G=Z2 L=4x4 u=1/2 y=1/3 orbits=787'
dk_have "$RECB" 'gap=2.462262919304910527'
dk_have "$RECB" 'DUAL G=Z2 L=4x4 u=3/5 y=2/8 orbits=787'
dk_have "$RECB" 'gap=1.129352874873374565'
dk_have "$RECB" 'DUAL G=Z2 L=4x4 u=2/3 y=1/5 orbits=787'
dk_have "$RECB" 'gap=1.462082652428910347'
dk_have "$RECK" 'G6D-STRING3 u=1/3 E(3|perp4)=3.093911782150019 E(4|perp3)=4.216126672831144'
dk_have "$RECK" 'G6D-STRING3 u=1/2 E(3|perp4)=1.236557282035882 E(4|perp3)=1.776478974804048'
dk_have "$RECK" 'G6D-STRING3 u=3/5 E(3|perp4)=0.266948024720898 E(4|perp3)=0.472384055175958'
dk_have "$RECK" 'G6D-STRING3 u=2/3 E(3|perp4)=0.044990853362725 E(4|perp3)=0.132564775414295'
dk_have "$RECS" 'DUAL-SER L=3x3 u=1/1000 r=-9.99992000003991937938'
dk_have "$RECS" 'DUAL-SER L=3x3 u=1/2000 r=-2.49999500000062437257'
dk_have "$RECS" 'DUAL-SER L=3x3 u=1/4000 r=-6.24999687500009760732'
dk_have "$RECS" 'DUAL-SER L=3x3 u=1/8000 r=-1.56249980468750152549'
dk_have "$RECS" 'G6D-SCAN the phenomenological-renormalization crossing of 2 m(2x2) and 3 m(3x3), u = P/1000 (the Ising point: beta_c = 0.761413, u_c = 0.64200):'
dk_have "$RECS" 'G6D-SCAN u=0.560 y=0.282051 beta=0.632833 2m(2)=4.4715266560 3m(3)=4.8351616943 diff=-0.3636350383'
dk_have "$RECS" 'G6D-SCAN u=0.580 y=0.265823 beta=0.662463 2m(2)=4.5008225568 3m(3)=4.5264668921 diff=-0.0256443353'
dk_have "$RECS" 'G6D-SCAN u=0.585 y=0.261830 beta=0.670031 2m(2)=4.5163511407 3m(3)=4.4811603548 diff=0.0351907859'
dk_have "$RECS" 'G6D-SCAN u=0.642 y=0.218027 beta=0.761569 2m(2)=4.9128354282 3m(3)=4.8936396813 diff=0.0191957469'
dk_have "$RECS" 'G6D-SCAN u=0.644 y=0.216545 beta=0.764978 2m(2)=4.9336504682 3m(3)=4.9353970336 diff=-0.0017465655'
dk_have "$RECB" 'G6D-SCAN4 u=0.600 y=0.250000 beta=0.693147 3m(3)=4.4267996771 4m(4)=4.5174114995 diff=-0.0906118224'
dk_have "$RECB" 'G6D-SCAN4 u=0.620 y=0.234568 beta=0.725005 3m(3)=4.5431208260 4m(4)=4.3594693691 diff=0.1836514569'
dk_have "$RECB" 'G6D-SCAN4 u=0.630 y=0.226994 beta=0.741416 3m(3)=4.6762558253 4m(4)=4.4945075144 diff=0.1817483110'
dk_have "$RECB" 'G6D-SCAN4 u=0.640 y=0.219512 beta=0.758174 3m(3)=4.8533906318 4m(4)=4.7514684703 diff=0.1019221615'
dk_have "$RECB" 'G6D-SCAN4 u=0.645 y=0.215805 beta=0.766689 3m(3)=4.9568281250 4m(4)=4.9179875350 diff=0.0388405899'
dk_have "$RECB" 'G6D-SCAN4 u=0.650 y=0.212121 beta=0.775299 3m(3)=5.0692989188 4m(4)=5.1056575678 diff=-0.0363586491'
dk_have "$RECB" 'G6D-SCAN4 u=0.660 y=0.204819 beta=0.792814 3m(3)=5.3187945055 4m(4)=5.5329555382 diff=-0.2141610327'
dk_have "$RECE" 'G6D-E44 u=1/3 lambda0=1.022956358066539061701766376263644446850769106 lambda_top=0.015093756647896007497225474549358340852579013 E(4|perp4)=4.216170913012046'
dk_have "$RECE" 'G6D-E44 u=1/2 lambda0=1.342026686396158816786899271279206736323882152 lambda_top=0.225314973240126429661832771854201871483411143 E(4|perp4)=1.784436898523392'
dk_have "$RECE" 'G6D-E44 u=3/5 lambda0=2.994106108934329469508892503287631039773346321 lambda_top=2.016512584540386145835561135213670540959283233 E(4|perp4)=0.395276149799725'
dk_have "$RECE" 'G6D-E44 u=2/3 lambda0=12.217856113062970652722840483340988705932043734 lambda_top=11.550632631947134182944996430770541249209632459 E(4|perp4)=0.056158288725808'
dk_have "$RECN" 'G6D-NU pair=(2,3) u*=0.58211 beta*=0.66565 NO-FIXED-POINT: the two gaps move oppositely with beta there (dm/dbeta 1.00990 and -2.04364) -- the gap minima crossing, not scaling'
dk_have "$RECN" 'G6D-NU pair=(2,3) u*=0.64383 beta*=0.76469 m(2)=2.465948 dm/dbeta=3.07349 m(3)=1.643951 dm/dbeta=4.13489 1/nu=2.7317 nu=0.3661 (3d Ising nu = 0.6300)'
dk_have "$RECN" 'G6D-NU pair=(3,4) u*=0.60661 beta*=0.70354 NO-FIXED-POINT: the two gaps move oppositely with beta there (dm/dbeta 0.85658 and -1.24780) -- the gap minima crossing, not scaling'
dk_have "$RECN" 'G6D-NU pair=(3,4) u*=0.64758 beta*=0.77112 m(3)=1.671281 dm/dbeta=4.36023 m(4)=1.252956 dm/dbeta(secant)=5.44840 1/nu=2.7773 nu=0.3601 (3d Ising nu = 0.6300)'
dk_have "$RECN" 'G6D-GAPMIN L=2 u_min=0.55895 beta_min=0.63131 m(grid)=2.235763'
dk_have "$RECN" 'G6D-GAPMIN L=3 u_min=0.59911 beta_min=0.69177 m(grid)=1.475600'
dk_have "$RECN" 'G6D-GAPMIN L=4 u_min=0.61553 beta_min=0.71778 m(grid)=1.089870'
dk_have "$RECN" 'G6D-GAPMIN ansatz: 1/nu=1.4238 nu=0.7023 a=0.3698 beta_c=0.76916 (Ising nu=0.6300, beta_c=0.761413); with nu=0.6300 fixed on L=3,4: beta_c=0.76272'
dk_have "$LIVEC" 'G6C-DONE L=3x3 u=1/3 t-read=0..40 violations=0'
dk_have "$LIVEC" 'G6C-DONE L=3x3 u=3/5 t-read=0..40 violations=0'
dk_have "$LIVEC" 'G6C-DONE L=3x4 u=1/3 t-read=0..40 violations=0'
dk_have "$LIVEC" 'G6C-DONE L=3x4 u=3/5 t-read=0..40 violations=0'
dk_have "$RECC4" 'G6C-DONE L=4x4 u=1/3 t-read=0..40 violations=0'
dk_have "$RECC4" 'G6C-DONE L=4x4 u=3/5 t-read=0..40 violations=0'
dk_tested "$SRC4"; dk_tested "$SRC5"; dk_tested "$SRC6"; dk_tested "$SPL"; dk_tested "$CAWK"; dk_tested "$DRV"
dk_say "ARM 6: THE DUAL-SPIN ROAD -- the second road meets ΤΟΜΕΥΣ on all fourteen certified Z2 cells and all six certified string cells live (G6D-KAT misses=0 checks=14; G6D-STRING misses=0 checks=6), reads the 3x4 box and its strings past the organ's walls and the 4x4 box beyond its reach, its series points read u^2 and u^4 as 1 and -15/2, and the Ising anchor meets Arisue-Tabata's ten published coefficients, solving u^6 .. u^12 for the infinite lattice"


# ---- THE TEETH (predicted first in $PRED) ----
export DK_BASE_RUN="$RUNK"
K='G6-KAT misses=0'
dk_tooth "$SRC" "$MUT" ordbend 'Q8 => \[ 8,' 'Q8 => [ 6,' 1 "$K" pcc prun
dk_tooth "$SRC" "$MUT" catalanbend '\$c = \$c \* R(2 \* \$k - \$i + 1) / R(\$i)' '$c = $c * R(2 * $k - $i + 1) / R($i + 1)' 1 "$K" pcc prun
dk_tooth "$SRC" "$MUT" partbend 'if (!\$d->is_zero) { \$first = \$k; \$coef = \$d; last }' 'if ($d->is_zero) { $first = $k; $coef = $d; last }' 1 "$K" pcc prun
dk_control "$SRC" "$MUT" 'the moments are integers and the parting is one of them.' 'the moments are integers and the parting is one of them (a comment control).' "$RUNK" pcc prun

# ---- THE LADDER'S TEETH (predicted in $PRED, dated 2026-10-28 12:0x, before any mutant ran) ----
export DK_BASE_RUN="$RUNK2"
K2='G6L-KAT misses=0 checks=20'
dk_tooth "$SRC2" "$MUT" lnbend '\$r + \$TWOP;   # the atanh argument' '$r + $TWOP + $TWOP;   # the atanh argument' 4 "$K2" pcc prun
dk_tooth "$SRC2" "$MUT" tailbend 'cdiv(\$thi \* \$x, \$den);   # the geometric tail of the exponential' 'I(0);   # the geometric tail of the exponential' 4 "$K2" pcc prun
dk_tooth "$SRC2" "$MUT" fourbend 'iv_scale(ln_iv(iv_div(\$C{\$g}{\$ys}, \$SU{\$ys})), -4)' 'iv_scale(ln_iv(iv_div($C{$g}{$ys}, $SU{$ys})), -2)' 4 "$K2" pcc prun
dk_control "$SRC2" "$MUT" 'every endpoint is a dyadic rational and the defect is the difference of two logarithms.' 'every endpoint is a dyadic rational and the defect is the difference of two logarithms (a comment control).' "$RUNK2" pcc prun

# ---- THE BOX READER'S TEETH (predicted in $PRED, dated 2026-10-28 13:2x, before any mutant ran) ----
export DK_BASE_RUN="$RUNR3"
dk_tooth "$SRC3" "$MUT" logbend 'function ln(x) { return log(x) }' 'function ln(x) { return log(x) / log(2) }' 5 'G7-KAT misses=0 checks=3' acc arun
dk_tooth "$SRC3" "$MUT" tubebend 'c = (1 - y) / (1 + y); return -4 \* ln(c)' 'c = (1 + y) / (1 - y); return -4 * ln(c)' 5 'G7-GAP G=Z2 y=1/2 L=2x4 gap=[3.830974659612,3.830974659612] tube=4.394449154672' acc arun
dk_tooth "$SRC3" "$MUT" stringbend 'E4 = EL\[k24, "01"\]; E4h = EH\[k24, "01"\]' 'E4 = EL[k24, "10"]; E4h = EH[k24, "10"]' 5 'verdict=NEITHER ALIVE' acc arun
dk_control "$SRC3" "$MUT" 'a reading is a logarithm of two brackets and nothing is typed.' 'a reading is a logarithm of two brackets and nothing is typed (a comment control).' "$RUNR3" acc arun
# ARM 6's teeth: the Perl stage and the awk stage run through the driver's live kat mode with the mutant in the instrument's place (the
# tables into $MUT), the G6D-RECORD line (which names the mutant's own digest) filtered out so the comment control reads an unchanged run.
dcc(){ perl -c "$1" > /dev/null 2>&1 && cp "$1" "$2"; }
drun(){ G6D_PL="$1" G6D_TABDIR="$MUT" bash "$DRV" kat 2>&1 | grep -v '^G6D-RECORD'; }
dacc(){ gawk -M -f "$1" /dev/null > /dev/null 2>&1 && cp "$1" "$2"; }
darun(){ G6D_AWK="$1" G6D_TABDIR="$MUT" bash "$DRV" kat 2>&1 | grep -v '^G6D-RECORD'; }
arun6(){ perl "$1" 2>&1; }
srun(){ G6D_SPL="$1" G6D_TABDIR="$MUT" bash "$DRV" kat 2>&1 | grep -v '^G6D-RECORD'; }
crun(){ G6D_CAWK="$1" G6D_TABDIR="$MUT" bash "$DRV" corr 2>&1 | grep -v '^G6C-RECORD'; }
export DK_BASE_RUN="$LIVEKF"
dk_tooth "$SPL" "$MUT" windbend '\$CYC\[\$s\] = \$b ^ \$W0 }' '$CYC[$s] = $b ^ 0 }' 6 'G6D-STRING misses=0 checks=6' dcc srun
export DK_BASE_RUN="$LIVEC"
dk_tooth "$CAWK" "$MUT" discbend '  disc = v0\[so\] \* v0\[so\]' '  disc = 0 * v0[so]' 6 'G6C-DONE L=3x3 u=1/3 t-read=0..40 violations=0' dacc crun
export DK_BASE_RUN="$LIVEKF"
dk_tooth "$SRC4" "$MUT" complbend '\$c{\$i}{\$half + \$NP - \$dd}++;' '$c{$i}{$half + $NP - $dd} += 0;' 6 'G6D-KAT misses=0 checks=14' dcc drun
export DK_BASE_RUN="$LIVEKF"
dk_tooth "$SRC5" "$MUT" deflbend 'w\[i\] -= p \* v0\[i\]; lnew += v\[i\] \* w\[i\]' 'w[i] -= 0 * v0[i]; lnew += v[i] * w[i]' 6 'G6D-KAT misses=0 checks=14' dacc darun
export DK_BASE_RUN="$LIVEA"
dk_tooth "$SRC6" "$MUT" anchorbend 'my @a = (R(1), R("-15/2"));' 'my @a = (R(1), R("-7"));' 6 'ISING-ANCHOR Delta(u) = -4 ln u + (1) u^2 + (-15/2) u^4 + (7/3) u^6 + (-87/4) u^8 + (251/5) u^10 + (-331/2) u^12' dcc arun6
export DK_BASE_RUN="$LIVEKF"
dk_control "$SRC4" "$MUT" 'these are orthonormal.' 'these are orthonormal (a comment control).' "$LIVEKF" dcc drun

# ---- ARM 7: GATE 3, THE CAYLEY GAPS BY THE CHARPOLY ROAD (2026-10-28 17:5x EDT, the desktop seat) -- the page's §3 stake run: the four ----
# exceptional binary polyhedral groups built as unit quaternions over Z[omega]/2 and checked closed on every pair, S the inverse-closed
# nearest shell, L = |S| I - A, the characteristic polynomial exact over Z (Hessenberg modulo ~2^30 primes, the Chinese remainder), the
# squarefree part by a rational gcd, the distinct eigenvalues isolated by Sturm, the staked gap's minimal polynomial and multiplicity by
# exact division; the desk's Frobenius factorizations are checked predictions.  The binary dihedral controls Q12, Q16, Q24: the nearest
# shell does not generate, the organ refuses the word gap by name (ΚΑΜΨΙΣ' KAM_E_NOGEN).  Re-derived LIVE every run (seven groups, about
# three minutes, the 120 x 120 charpoly the cost) and compared line for line with the record of 2026-10-28a (RESULTS 10).
SRC7="$B/g3_cayley.pl"; REC7="$B/g3_cayley.2026-10-28a.txt"; LIVE7="$B/g_g3.txt"; LIVE7Q="$B/g_g3q8.txt"
for f in "$SRC7" "$REC7"; do [ -f "$f" ] || dk_red "ARM 7: missing $f"; done
dk_have "$REC7" "instrument g3_cayley.pl sha256 $(sha6 "$SRC7")"
rm -f "$LIVE7" "$LIVE7Q"; perl "$SRC7" all 2>&1 | tr -d '\r' > "$LIVE7" || dk_red "ARM 7: the instrument refused"
grep -v '^# ' "$REC7" | cmp -s - "$LIVE7" || dk_red "ARM 7: the live run parts from the record: $(grep -v '^# ' "$REC7" | diff - "$LIVE7" | head -3 | cut -c1-160)"
dk_have "$LIVE7" "G3-DONE groups=7 deaths=0"
for g in q8 2t 2o 2i; do grep -q "^G3-GAP group=$g .* verdict=MET\$" "$LIVE7" || dk_red "ARM 7: $g's gap is not the staked one"; grep -q "^G3-DESK group=$g .* verdict=MET\$" "$LIVE7" || dk_red "ARM 7: $g's desk factorization REFUTED"; done
for g in q12 q16 q24; do grep -q "^G3-CONNECTED group=$g .*nearest-shell=NOT-GENERATING .*verdict=MET\$" "$LIVE7" || dk_red "ARM 7: $g's nearest shell generates"; done
dk_have "$LIVE7" "G3-GAP group=2i smallest-positive in (2.291796067500, 2.291796067501) staked=12-6phi=9-3sqrt5 minpoly=36x^0+-18x^1+1x^2 multiplicity=4 (staked d^2=4) is-root-of-minpoly=1 below-it=0 |S| staked=12 verdict=MET"
dk_have "$LIVE7" "G3-GAP group=2o smallest-positive in (1.757359312881, 1.757359312881) staked=6-3sqrt2 minpoly=18x^0+-12x^1+1x^2 multiplicity=4 (staked d^2=4) is-root-of-minpoly=1 below-it=0 |S| staked=6 verdict=MET"
dk_say "ARM 7: GATE 3 -- the Cayley gaps of Q8, 2T, 2O, 2I are 6, 4, 6 - 3 sqrt2, 12 - 6 phi, each the fundamental's with multiplicity four and nothing below it; the desk's seven factorizations MET; the three dihedral controls refused by name"
# ARM 7's teeth run the q8 mode (a second each) against its own live base; the pin is the run's closing line, which a bent computation cannot print
g3cc(){ perl -c "$1" > /dev/null 2>&1 && cp "$1" "$2"; }
g3run(){ perl "$1" q8 2>&1 | tr -d '\r'; }
perl "$SRC7" q8 2>&1 | tr -d '\r' > "$LIVE7Q"; dk_have "$LIVE7Q" "G3-DONE groups=1 deaths=0"
export DK_BASE_RUN="$LIVE7Q"
dk_tooth "$SRC7" "$MUT" crtbend '\$x = \$x - \$Mod if \$x > \$half; \$P\[\$k\] = \$x;' '$x = $x - $Mod if $x > $Mod; $P[$k] = $x;' 7 'G3-DONE groups=1 deaths=0' g3cc g3run
dk_tooth "$SRC7" "$MUT" hessbend '\$q\[\$k\] = (\$q\[\$k\] - \$H\[\$m-1\]\[\$m-1\] \* \$prev->\[\$k\]) % \$p' '$q[$k] = ($q[$k] + $H[$m-1][$m-1] * $prev->[$k]) % $p' 7 'G3-DONE groups=1 deaths=0' g3cc g3run
dk_tooth "$SRC7" "$MUT" deskbend 'q8   => \[ \[\[0,1\],1\], \[\[-6,1\],4\], \[\[-8,1\],3\] \],' 'q8   => [ [[0,1],1], [[-6,1],4], [[-7,1],3] ],' 7 'G3-DONE groups=1 deaths=0' g3cc g3run
dk_control "$SRC7" "$MUT" 'floats select S and print readings only.' 'floats select S and print readings only (a comment control).' "$LIVE7Q" g3cc g3run

# ---- ARM 8: STAKE 8, THE INERTIA ROAD (2026-10-28 18:5x EDT, the desktop seat; RESULTS 11) -- the sector's gap bracketed by exact ----
# sign counts: W = D M symmetric from stage 1's tables, the count of eigenvalues above a dyadic c the positive pivots of the fraction-free
# elimination of W - cD (Sylvester, Jacobi), bisection at 48 bits; the dual road's lambdas compared exactly, ΤΟΜΕΥΣ' certified
# intervals overlapped.  Re-derived LIVE on the ten certified cells through 18 orbits (about three minutes) and compared line for
# line with record b; the four 2x4 cells (22 orbits, 40-100 s each) pinned from the record, which the reader's sha256 binds.
SRC8="$B/g6_inertia.pl"; DRV8="$B/g6_inertia_run.sh"; REC8="$B/g6_inertia.2026-10-28b.txt"; LIVE8="$B/g_g6i.txt"
for f in "$SRC8" "$DRV8" "$REC8"; do [ -f "$f" ] || dk_red "ARM 8: missing $f"; done
dk_have "$REC8" "reader g6_inertia.pl sha256 $(sha6 "$SRC8")"; dk_have "$REC8" "driver g6_inertia_run.sh sha256 $(sha6 "$DRV8")"
dk_have "$REC8" "G6I-DONE cells=14 read=14 contains=14 overlap=14 skipped=0"
rm -f "$LIVE8"; G6I_MAXN=18 bash "$DRV8" 2>&1 | tr -d '\r' > "$LIVE8" || dk_red "ARM 8: the driver refused"
dk_have "$LIVE8" "G6I-DONE cells=14 read=10 contains=10 overlap=10 skipped=4"
n8=0; while read -r l; do grep -qF -- "$l" "$REC8" || dk_red "ARM 8: a live line parts from record b: ${l:0:140}"; n8=$((n8+1)); done < <(grep '^G6I-KAT \|^G6I-LAM' "$LIVE8")
[ "$n8" -eq 30 ] || dk_red "ARM 8: $n8 live cell lines, not 30 (ten cells, three lines each)"
for c in 'L=2x4 y=1/2 u=1/3 n=22' 'L=2x4 y=1/3 u=1/2 n=22' 'L=2x4 y=1/4 u=3/5 n=22' 'L=2x4 y=1/5 u=2/3 n=22'; do grep -q "^G6I-KAT $c .*lambdas=CONTAINS overlap=YES\$" "$REC8" || dk_red "ARM 8: the record's 2x4 cell $c is not CONTAINS/YES"; done
dk_say "ARM 8: STAKE 8 -- the inertia road brackets every certified Z2 cell by sign counts alone, the dual road's lambdas inside and ΤΟΜΕΥΣ' intervals met, 14 of 14 (ten live, four from record b)"
# ARM 8's teeth run the reader on the 2x2 cell at u = 1/3 against the dual road's live lambdas (a second each)
dl8=$(gawk -M -v PREC=320 -v ACC=60 -v MAXIT=20000 -v P=1 -v Q=3 -f "$SRC5" "$B/g6_dual_2x2.tab" | grep '^DUAL G' | head -1)
l08=$(sed 's/.*lambda0=\([0-9.]*\).*/\1/' <<<"$dl8"); l18=$(sed 's/.*lambda1=\([0-9.]*\).*/\1/' <<<"$dl8")
g8cc(){ perl -c "$1" > /dev/null 2>&1 && cp "$1" "$2"; }
g8run(){ perl "$1" "$B/g6_dual_2x2.tab" 1 3 48 "$l08" "$l18" 2>&1 | tr -d '\r' | sed 's/ seconds=[0-9]*//'; }   # the wall-clock field stripped: run t read a comment control MOVED on seconds=1 against seconds=0 (law 43)
LIVE8Q="$B/g_g6i2x2.txt"; perl "$SRC8" "$B/g6_dual_2x2.tab" 1 3 48 "$l08" "$l18" 2>&1 | tr -d '\r' | sed 's/ seconds=[0-9]*//' > "$LIVE8Q"
dk_have "$LIVE8Q" "G6I-GAP L=2x2 u=1/3 gap in [3.750210305668558, 3.750210305668861] width=3.029e-13 dual-road-lambdas=CONTAINS"
export DK_BASE_RUN="$LIVE8Q"
dk_tooth "$SRC8" "$MUT" signbend '\$pos++ if \$sg == \$lastsign; \$lastsign = \$sg;' '$pos++ if $sg != $lastsign; $lastsign = $sg;' 8 'G6I-GAP L=2x2 u=1/3 gap in [3.750210305668558, 3.750210305668861] width=3.029e-13 dual-road-lambdas=CONTAINS' g8cc g8run
dk_tooth "$SRC8" "$MUT" bisectbend 'if (\$c >= \$m) { \$lo = \$mid } else { \$hi = \$mid } }' 'if ($c >= $m) { $hi = $mid } else { $lo = $mid } }' 8 'G6I-GAP L=2x2 u=1/3 gap in [3.750210305668558, 3.750210305668861] width=3.029e-13 dual-road-lambdas=CONTAINS' g8cc g8run
dk_control "$SRC8" "$MUT" 'and the only decision a sign.' 'and the only decision a sign (a comment control).' "$LIVE8Q" g8cc g8run


# ---- ARM 9: RESULTS 12.1-12.2, THE TRANSFORM AND THE CHAIN LEMMA (2026-10-28 21:4x EDT, the desktop seat) -- g9_chain.pl builds the Z2 ----
# tube's Doob chain from the electric basis, reads delta(P^k)^{1/k} against lambda_1/lambda_0 (sym mode: the KAT against the inertia road's
# certified gaps) and the two-scale lemma's four rung quantities with its two inequalities (dec mode).  Re-derived LIVE: the three known
# answers and the 2x4 decimation at two couplings (seconds), compared line for line with the record of 2026-10-29a; the 4x3 lines
# pinned from the record, which the instrument's sha256 binds.
SRC9="$B/g9_chain.pl"; REC9="$B/g9_chain.2026-10-29a.txt"; LIVE9="$B/g_g9.txt"; LIVE9S="$B/g_g9sym.txt"; LIVE9D="$B/g_g9dec.txt"
for f in "$SRC9" "$REC9"; do [ -f "$f" ] || dk_red "ARM 9: missing $f"; done
rm -f "$LIVE9" "$LIVE9S" "$LIVE9D"; { perl "$SRC9" 2 2 1 3 8 sym 3.7502103056688159; perl "$SRC9" 2 4 1 3 8 sym 3.8309746596116909; perl "$SRC9" 3 4 1 3 6 sym 4.407142121643281158; perl "$SRC9" 2 4 1 3 8 dec; perl "$SRC9" 2 4 1 2 8 dec; } 2>&1 | tr -d '\r' > "$LIVE9" || dk_red "ARM 9: the instrument refused"
grep -v '^# ' "$REC9" | head -n "$(wc -l < "$LIVE9")" | cmp -s - "$LIVE9" || dk_red "ARM 9: the live run parts from the record: $(grep -v '^# ' "$REC9" | head -n "$(wc -l < "$LIVE9")" | diff - "$LIVE9" | head -3 | cut -c1-160)"
[ "$(grep -c 'G9-KAT .*\[MET\]$' "$LIVE9")" -eq 3 ] || dk_red "ARM 9: a known answer PARTED from the inertia road"
[ "$(grep -c '\[BOUND-HOLDS\]' "$LIVE9")" -eq 38 ] || dk_red "ARM 9: a Gelfand bound VIOLATED live ($(grep -c '\[BOUND-HOLDS\]' "$LIVE9") of 38)"
grep -q 'VIOLATED' "$LIVE9" && dk_red "ARM 9: an inequality VIOLATED live"; grep -q 'VIOLATED' "$REC9" && dk_red "ARM 9: an inequality VIOLATED in the record"
[ "$(grep -c '\[LEMMA-HOLDS RATE-HOLDS\]' "$REC9")" -eq 20 ] || dk_red "ARM 9: the record's twenty lemma cells are not all HOLDS"
dk_have "$REC9" "G9-COARSE k=1 delta(Q)=0.000532664109247 eps_k=0.000631592866449 theta_k=0.244381891857 eta_k=0.00107642825154 rho(M_k)=0.0249123349617 lemma-gap>=1.84619610909 exact-gap=4.40714212164"
dk_have "$LIVE9" "G9-FIBRE coarse=1x4 coarse-orbits=4 fibres=4 largest-fibre=12 eta=0.00237904287632 eps=0.00118588558025 theta=0.374244965625 eps<=eta=YES"
dk_say "ARM 9: RESULTS 12 -- the transform is Dobrushin's coefficient (two known answers MET against the inertia road's certified cells and a third against the dual road's reading, the Gelfand bound holding at every k) and the chain lemma's two inequalities hold on every two-scale cell (2x4 and 4x3 by decimation), its four rung quantities read"
g9cc(){ perl -c "$1" > /dev/null 2>&1 && cp "$1" "$2"; }
g9runA(){ perl "$1" 2 2 1 3 8 sym 3.7502103056688159 2>&1 | tr -d '\r'; }
g9runB(){ perl "$1" 2 4 1 3 8 dec 2>&1 | tr -d '\r'; }
perl "$SRC9" 2 2 1 3 8 sym 3.7502103056688159 2>&1 | tr -d '\r' > "$LIVE9S"; perl "$SRC9" 2 4 1 3 8 dec 2>&1 | tr -d '\r' > "$LIVE9D"
export DK_BASE_RUN="$LIVE9S"
dk_tooth "$SRC9" "$MUT" g9cplbend '\$row\[\$box->{orb}\[\$t\]\] += \$ks \* (\$pw\[\$d\] + \$pw\[\$box->{NP} - \$d\])' '$row[$box->{orb}[$t]] += $ks * ($pw[$d])' 9 'G9-KAT gap=3.75021030566882 reading=3.7502103056688159  [MET]' g9cc g9runA
export DK_BASE_RUN="$LIVE9D"
dk_tooth "$SRC9" "$MUT" g9tvbend 'for 0 \.\. \$n - 1; return \$s / 2 }' 'for 0 .. $n - 1; return $s / 20 }' 9 'G9-GELFAND k=1 delta=0.0852003471204 delta^(1/k)=0.0852003471204 lambda1/lambda0=0.0216884664526 excess=6.351e-02 bound-on-gap=2.46274977097 gap=3.83097465961 [BOUND-HOLDS]' g9cc g9runB
dk_control "$SRC9" "$MUT" 'pins each inequality by a token:' 'pins each inequality by a token (a comment control):' "$LIVE9D" g9cc g9runB

# ---- ARM 10: RESULTS 12.3, THE HIERARCHICAL FLOW'S LINEARISATION (2026-10-28 21:4x EDT, the desktop seat) -- g10_mk_linear.pl reads the ----
# Migdal-Kadanoff step of SU(2) about the heat-kernel line: T(t) - t against t^2/4 + t^3/12, the Jacobian's spectrum against 4^{2-d}, the
# absolute matrix's root.  Re-derived LIVE at t = 0.1 (N = 40, seconds) and compared with the record's block; the four other widths pinned.
SRC10="$B/g10_mk_linear.pl"; REC10="$B/g10_mk_linear.2026-10-29a.txt"; LIVE10="$B/g_g10.txt"
for f in "$SRC10" "$REC10"; do [ -f "$f" ] || dk_red "ARM 10: missing $f"; done
rm -f "$LIVE10"; perl "$SRC10" 0.1 40 2>&1 | tr -d '\r' > "$LIVE10" || dk_red "ARM 10: the instrument refused"
grep 't=0.100000' "$REC10" | cmp -s - <(grep 't=0.100000' "$LIVE10") || dk_red "ARM 10: the live t = 0.1 block parts from the record: $(diff <(grep 't=0.100000' "$REC10") <(grep 't=0.100000' "$LIVE10") | head -3 | cut -c1-160)"
dk_have "$LIVE10" "T(t)-t=0.002586687 (t^2/4=0.002500000, t^2/4+t^3/12=0.002583333)"
dk_have "$LIVE10" "G10-TRANSVERSE t=0.100000 leading=1.052452147 second=0.069251104"
dk_have "$REC10" "G10-TRANSVERSE t=0.050000 leading=1.025597797 second=0.065745820"
dk_have "$REC10" "G10-ABS t=0.100000 rho(|L|)=1.347011736"
dk_say "ARM 10: RESULTS 12.3 -- the step's spectrum about the heat-kernel line is 4^{2-d}(1 + O(t)): the width marginal at 1 + t/2, the quartic at 1/16, the line normally attracting; T(t) - t = t^2/4 + t^3/12 read to 2e-7 at t = 0.05; the absolute matrix's root 1.35 the shadowing wall"
g10cc(){ perl -c "$1" > /dev/null 2>&1 && cp "$1" "$2"; }
g10run(){ perl "$1" 0.1 40 2>&1 | tr -d '\r'; }
export DK_BASE_RUN="$LIVE10"
dk_tooth "$SRC10" "$MUT" g10cgbend '\$n += 2) { \$H\[\$n\] += \$F->\[\$m\] \* \$G->\[\$k\] }' '$n += 1) { $H[$n] += $F->[$m] * $G->[$k] }' 10 'T(t)-t=0.002586687 (t^2/4=0.002500000, t^2/4+t^3/12=0.002583333)' g10cc g10run
dk_tooth "$SRC10" "$MUT" g10jacbend '\$J\[\$n\]\[\$m\] = 4 \* (\$d->\[\$n\] / \$w4->\[\$n\] - \$d->\[0\] / \$w4->\[0\])' '$J[$n][$m] = 2 * ($d->[$n] / $w4->[$n] - $d->[0] / $w4->[0])' 10 'G10-TRANSVERSE t=0.100000 leading=1.052452147 second=0.069251104' g10cc g10run
dk_control "$SRC10" "$MUT" 'the Brownian bridge of SU(2) at the quarter time' 'the Brownian bridge of SU(2) at the quarter time (a comment control)' "$LIVE10" g10cc g10run

# ---- ARM 11: RESULTS 12.4, THE CERTIFIED PART (2026-10-28 21:4x EDT, the desktop seat) -- MKBall.pm (the one copy of the ball arithmetic), ----
# g11_mk_cert.pl (the KAT: the exact rational recursion inside the ball; the trajectories to the threshold or to the wrapping wall) and
# g11_mk_grid.pl (claim (A) at one hundred exact starts, one step each).  Re-derived LIVE: the KAT, the q = 7/10 trajectory, the grid (about
# forty seconds), compared with the records.
SRCM11="$B/MKBall.pm"; SRC11C="$B/g11_mk_cert.pl"; SRC11G="$B/g11_mk_grid.pl"; REC11C="$B/g11_mk_cert.2026-10-29a.txt"; REC11G="$B/g11_mk_grid.2026-10-29a.txt"; LIVE11K="$B/g_g11kat.txt"; LIVE11T="$B/g_g11traj.txt"; LIVE11G="$B/g_g11grid.txt"
for f in "$SRCM11" "$SRC11C" "$SRC11G" "$REC11C" "$REC11G"; do [ -f "$f" ] || dk_red "ARM 11: missing $f"; done
rm -f "$LIVE11K" "$LIVE11T" "$LIVE11G"; perl "$SRC11C" kat 2>&1 | tr -d '\r' > "$LIVE11K" || dk_red "ARM 11: the KAT refused"
dk_have "$LIVE11K" "width=4.81e-15  [CONTAINS]"; grep -q 'ESCAPES' "$LIVE11K" && dk_red "ARM 11: the exact value ESCAPES the ball"
perl "$SRC11C" 7 10 80 0.131 60 30 2>&1 | tr -d '\r' > "$LIVE11T" || dk_red "ARM 11: the trajectory refused"
dk_have "$LIVE11T" "G11-THRESHOLD q=7/10 t in [0.713349887, 0.713349887] reached c1 <= 0.131 at step K*=3 with c1^up=0.0730435393: a certified descent to the kernel"
grep 'q=7/10' "$REC11C" | cmp -s - <(grep 'q=7/10' "$LIVE11T") || dk_red "ARM 11: the live q = 7/10 trajectory parts from the record"
dk_have "$REC11C" "G11-THRESHOLD q=8/10 t in [0.446287102, 0.446287102] reached c1 <= 0.131 at step K*=6"
perl "$SRC11G" 1000 500 995 5 60 30 2>&1 | tr -d '\r' > "$LIVE11G" || dk_red "ARM 11: the grid refused"
dk_have "$LIVE11G" "G11A-SUMMARY Q=1000 k=500..995 step 5 starts=100 (A)HOLDS=99 UNDECIDED=1 T'ABOVE=99 NOT-ABOVE=1 N=60"
grep -v '^# ' "$REC11G" | cmp -s - "$LIVE11G" || dk_red "ARM 11: the live grid parts from the record: $(grep -v '^# ' "$REC11G" | diff - "$LIVE11G" | head -3 | cut -c1-160)"
grep -q '^G11A q=995/1000 .*\[UNDECIDED\]' "$LIVE11G" || dk_red "ARM 11: the refused start is not the one the record names"
dk_say "ARM 11: RESULTS 12.4 -- the ball arithmetic's known answer CONTAINS the exact recursion; claim (A) HOLDS at 99 of 100 exact starts with the hundredth refused by its priced tail; the descent to the kernel's threshold CERTIFIED from q = 7/10 in three steps and from 8/10 in six"
mkcc(){ perl -c "$1" > /dev/null 2>&1 && cp "$1" "$2"; }
mkrun(){ cp "$SRC11C" "$MUT/g11_mk_cert.pl"; cp "$B/../dichotomia/R2Exact.pm" "$MUT/R2Exact.pm"; cp "$1" "$MUT/MKBall.pm"; perl "$MUT/g11_mk_cert.pl" kat 2>&1 | tr -d '\r'; }      # the bent module beside a pristine instrument
g11gcc(){ perl -c "$1" > /dev/null 2>&1 && cp "$1" "$2"; }
g11grun(){ cp "$SRCM11" "$MUT/MKBall.pm"; cp "$B/../dichotomia/R2Exact.pm" "$MUT/R2Exact.pm"; perl "$1" 1000 500 995 5 60 30 2>&1 | tr -d '\r'; }                                  # the pristine modules beside the bent instrument
export DK_BASE_RUN="$LIVE11K"
dk_tooth "$SRCM11" "$MUT" mkepsbend 'use constant EPS => 2 \*\* -52;' 'use constant EPS => 0;' 11 'width=4.81e-15  [CONTAINS]' mkcc mkrun
export DK_BASE_RUN="$LIVE11G"
dk_tooth "$SRC11G" "$MUT" g11tailbend 'my \$corr = (4 \* \$W \*\* 3 \* \$E + 6 \* \$W \*\* 2 \* \$E \*\* 2 + 4 \* \$W \* \$E \*\* 3 + \$E \*\* 4) \* INF;' 'my $corr = 0;' 11 'G11A-SUMMARY Q=1000 k=500..995 step 5 starts=100 (A)HOLDS=99 UNDECIDED=1' g11gcc g11grun
dk_control "$SRC11G" "$MUT" 'One Migdal-Kadanoff step (b = 2, d = 4, the character basis)' 'One Migdal-Kadanoff step (b = 2, d = 4, the character basis; a comment control)' "$LIVE11G" g11gcc g11grun


# ---- ARM 12: RESULTS 13, THE CONE'S MECHANISM (2026-10-28 22:3x-23:1x EDT, the desktop seat) -- g10_mk_quartic.pl reads the trajectory's ----
# quartic content against the predicted fixed point 1/3600 (the prediction in its header before it ran); g10_mk_bridge.pl reads the exact
# S^3 bridge's action on theta^4 (flat to 1e-6) and g10_mk_bridge_ctl.pl its sighted control (the unconditioned moment deviating at O(s)
# through the same quadrature).  Re-derived LIVE: the quartic from t = 0.1 to step 4 (seconds), the bridge and its control at t = 0.3
# (about a minute), each compared line for line with the records of 2026-10-29a.
SRC12Q="$B/g10_mk_quartic.pl"; SRC12B="$B/g10_mk_bridge.pl"; SRC12C="$B/g10_mk_bridge_ctl.pl"; REC12Q="$B/g10_mk_quartic.2026-10-29a.txt"; REC12B="$B/g10_mk_bridge.2026-10-29a.txt"; LIVE12Q="$B/g_g10q.txt"; LIVE12B="$B/g_g10b.txt"; LIVE12C="$B/g_g10c.txt"
for f in "$SRC12Q" "$SRC12B" "$SRC12C" "$REC12Q" "$REC12B"; do [ -f "$f" ] || dk_red "ARM 12: missing $f"; done
rm -f "$LIVE12Q" "$LIVE12B" "$LIVE12C"; perl "$SRC12Q" 0.1 4 0 60 2>&1 | tr -d '\r' > "$LIVE12Q" || dk_red "ARM 12: the quartic reader refused"
grep '^G10Q-STEP' "$LIVE12Q" | cmp -s - <(grep '^G10Q-STEP' "$REC12Q" | head -5) || dk_red "ARM 12: the live quartic steps part from the record: $(diff <(grep '^G10Q-STEP' "$LIVE12Q") <(grep '^G10Q-STEP' "$REC12Q" | head -5) | head -3 | cut -c1-160)"
dk_have "$LIVE12Q" "G10Q-STEP k=2 t_k=0.105307 a2=-2.848e-04 a4=2.8432e-04 (kappa*=2.7778e-04, ratio=1.024)"
dk_have "$REC12Q" "G10Q-STEP k=1 t_k=0.102597 a2=-3.831e-04 a4=3.9249e-04 (kappa*=2.7778e-04, ratio=1.413)"
dk_have "$REC12Q" "G10Q-STEP k=8 t_k=0.794896 a2=-1.764e-03 a4=3.5887e-04 (kappa*=2.7778e-04, ratio=1.292)"
perl "$SRC12B" 0.3 80 6000 2>&1 | tr -d '\r' > "$LIVE12B" || dk_red "ARM 12: the bridge reader refused"
grep 't=0.300000' "$REC12B" | grep '^G10B-BRIDGE' | cmp -s - "$LIVE12B" || dk_red "ARM 12: the live bridge line parts from the record"
dk_have "$LIVE12B" "a4=3.906250e-03 (flat 1/256=3.906250e-03) c(t)=256a4=1.000000"
perl "$SRC12C" 0.3 80 6000 2>&1 | tr -d '\r' > "$LIVE12C" || dk_red "ARM 12: the control refused"
dk_have "$LIVE12C" "CTL t=0.3000 s=0.040541 E_K[theta^2]=0.23666910 flat 6s=0.24324324 (6s-4s^2=0.23666910)"
dk_have "$LIVE12C" "BRIDGE f=theta^4 theta_U=0.5 A=0.065215150 flat=0.065215150 ratio=1.0000000"
dk_say "ARM 12: RESULTS 13 -- the cone's fixed point 1/3600 predicted and met on the exact recursion (the excess over it contracting by the predicted 1/16 per step), the exact S^3 bridge's action on theta^4 the flat formula to seven digits while its sighted control deviates at O(s) through the same quadrature"
g12cc(){ perl -c "$1" > /dev/null 2>&1 && cp "$1" "$2"; }
g12qrun(){ perl "$1" 0.1 4 0 60 2>&1 | tr -d '\r'; }
g12brun(){ perl "$1" 0.3 80 6000 2>&1 | tr -d '\r'; }
export DK_BASE_RUN="$LIVE12Q"
dk_tooth "$SRC12Q" "$MUT" quarticbend '@c = map { (\$v\[\$_\] / \$v\[0\]) \*\* 4 } 0 \.\. \$N }' '@c = map { ($v[$_] / $v[0]) ** 3 } 0 .. $N }' 12 'G10Q-STEP k=2 t_k=0.105307 a2=-2.848e-04 a4=2.8432e-04 (kappa*=2.7778e-04, ratio=1.024)' g12cc g12qrun
export DK_BASE_RUN="$LIVE12B"
dk_tooth "$SRC12B" "$MUT" bridgebend 'exp(-\$_ \* (\$_ + 2) \* 3 \* \$s) / (\$_ + 1)' 'exp(-$_ * ($_ + 2) * 2 * $s) / ($_ + 1)' 12 'a4=3.906250e-03 (flat 1/256=3.906250e-03) c(t)=256a4=1.000000' g12cc g12brun
dk_control "$SRC12Q" "$MUT" 'A reading in doubles, N = 60.' 'A reading in doubles, N = 60 (a comment control).' "$LIVE12Q" g12cc g12qrun


# ---- ARM 13: RESULTS 14, THE SHARP ONE-LINK LEMMA (2026-10-28 23:0x - 2026-10-29 00:2x EDT, the desktop seat) -- g18_mad_lemma.pl's four ----
# pieces: m1 (kappa >= 20 by the variance bound) and axis (the hand lemma's constants on kappa_2 in [0,1]) re-derived LIVE and compared with
# the b records line for line (the clock field stripped, law 43); the mono record (D_1 < 0 on [0.03,1] x [0,1]) and the five direct strips
# (F < 4/(3 pi) on the quarter disk of radius 20 minus the square) read from their b records -- 5434 and 2079 + 1874 + 1425 + 1916 + 1810
# = 9104 rectangles, 0 UNDECIDED, the five sums re-added here against the literal; a live mono run on the sub-square [0.5, 1] x [0, 1]
# at coarse resolution must certify with 0 UNDECIDED (the arm's own short road).  The survey's record pinned at its two sign lines.
SRC13="$B/g18_mad_lemma.pl"; SRV13="$B/g17_mixed_survey.2026-10-29a.txt"; LIVE13M="$B/g_g18m1.txt"; LIVE13A="$B/g_g18axis.txt"; LIVE13N="$B/g_g18mono.txt"
REC13M="$B/g18_m1.2026-10-29b.txt"; REC13A="$B/g18_axis.2026-10-29b.txt"; REC13N="$B/g18_mono.2026-10-29b.txt"
for f in "$SRC13" "$SRV13" "$REC13M" "$REC13A" "$REC13N"; do [ -f "$f" ] || dk_red "ARM 13: missing $f"; done
for s in 0_1 1_2 2_4 4_8 8_20; do [ -f "$B/g18_direct_b${s}.2026-10-29b.txt" ] || dk_red "ARM 13: missing the direct strip b$s"; done
dk_have "$SRV13" "G17-SIGN dF/dkappa_1 >= 0 at 0 cells (F falls along kappa_1 at every cell read)"
dk_have "$SRV13" "G17-MAX  F over 255 cells: 0.42441212 at k1=0 k2=0.01  (BELOW 4/(3 pi) = 0.42441318)"
rm -f "$LIVE13M" "$LIVE13A" "$LIVE13N"
perl "$SRC13" m1 20 40000 2>&1 | tr -d '\r' | sed 's/ ([0-9]* s)$//' > "$LIVE13M" || dk_red "ARM 13: the m1 mode refused"
sed 's/ ([0-9]* s)$//' "$REC13M" | cmp -s - "$LIVE13M" || dk_red "ARM 13: the live m1 line parts from record b: $(cat "$LIVE13M" | cut -c1-160)"
dk_have "$LIVE13M" "G18-M1 m_1(20) in [0.925987598, 0.925987899]; for kappa >= 20 every direction's MAD <= sqrt(1 - m_1^2) <= 0.377554  [BELOW 4/(3 pi) = 0.424413]"
perl "$SRC13" axis 0.03 1 8000 1e-4 2>&1 | tr -d '\r' | sed 's/  ([0-9]* s)$//' > "$LIVE13A" || dk_red "ARM 13: the axis mode refused"
grep '^G18-AXIS-VERDICT' "$REC13A" | sed 's/  ([0-9]* s)$//' | cmp -s - <(grep '^G18-AXIS-VERDICT' "$LIVE13A") || dk_red "ARM 13: the live axis verdict parts from record b"
dk_have "$LIVE13A" "the least k_min = 0.03125 at [0.87500, 1.00000] (k = 0.03); the largest M = 1.6852  [HAND-LEMMA-ADMITTED]"
dk_have "$REC13N" "G18-MONO-VERDICT 5434 rectangles certified, 0 UNDECIDED"
grep -q 'MONOTONE-CERTIFIED' "$REC13N" || dk_red "ARM 13: the mono record is not MONOTONE-CERTIFIED"
SUM13=0; for s in 0_1 1_2 2_4 4_8 8_20; do f="$B/g18_direct_b${s}.2026-10-29b.txt"; grep -q 'DIRECT-CERTIFIED' "$f" || dk_red "ARM 13: strip b$s is not DIRECT-CERTIFIED"; n=$(grep -o '^G18-DIRECT-VERDICT [0-9]* rectangles certified, 0 UNDECIDED' "$f" | awk '{print $2}'); [ -n "$n" ] || dk_red "ARM 13: strip b$s has no clean verdict line"; SUM13=$((SUM13 + n)); done
[ "$SUM13" -eq 9104 ] || dk_red "ARM 13: the five strips sum to $SUM13 rectangles, not 9104"
perl "$SRC13" mono 0.5 1 2000 1e-2 2>&1 | tr -d '\r' | sed 's/  ([0-9]* s)$//' > "$LIVE13N" || dk_red "ARM 13: the live mono sub-square refused"
grep -q '^G18-MONO-VERDICT [0-9]* rectangles certified, 0 UNDECIDED.*MONOTONE-CERTIFIED' "$LIVE13N" || dk_red "ARM 13: the live mono sub-square did not certify: $(grep VERDICT "$LIVE13N" | cut -c1-160)"
dk_say "ARM 13: RESULTS 14 -- the sharp one-link lemma's four pieces of record: m_1(20) and the hand lemma's constants re-derived live, 5434 + 9104 rectangles certified in records b, the live sub-square certified; 0.131 = 3 pi/72 a theorem"
g13cc(){ perl -c "$1" > /dev/null 2>&1 && cp "$1" "$2"; }
g13arun(){ perl "$1" axis 0.03 1 2000 1e-3 2>&1 | tr -d '\r' | sed 's/  ([0-9]* s)$//'; }
g13mrun(){ perl "$1" m1 20 20000 2>&1 | tr -d '\r' | sed 's/ ([0-9]* s)$//'; }
g13nrun(){ perl "$1" mono 0.5 1 2000 1e-2 2>&1 | tr -d '\r' | sed 's/  ([0-9]* s)$//'; }
FAST13A="$B/g_g18axisfast.txt"; g13arun "$SRC13" > "$FAST13A" || dk_red "ARM 13: the fast axis base refused"   # the control compares against a base made by ITS OWN runner (run v: the 8000-cell base against a 2000-cell control read MOVED)
export DK_BASE_RUN="$LIVE13A"
dk_tooth "$SRC13" "$MUT" mboundbend 'my \$M = 2 \* \$m4 + 9 \* \$Vh \* \$Vh + 4 \* \$n3 \* \$Hh' 'my $M = 2 * $m4 + 900 * $Vh * $Vh + 4 * $n3 * $Hh' 13 'HAND-LEMMA-ADMITTED' g13cc g13arun
export DK_BASE_RUN="$LIVE13M"
dk_tooth "$SRC13" "$MUT" varboundbend 'my \$bound = sqrt(1 - \$mlo \* \$mlo);' 'my $bound = 2 * sqrt(1 - $mlo * $mlo);' 13 '[BELOW 4/(3 pi) = 0.424413]' g13cc g13mrun
export DK_BASE_RUN="$LIVE13N"
dk_tooth "$SRC13" "$MUT" monobend '\$E->{V}\[0\] \* \$E->{thi}{P}\[0\] \* (1 - 4 \* \$EPS); \$ok = \$val < 0 }' '$E->{V}[0] * $E->{thi}{P}[0] * 0.5 * (1 - 4 * $EPS); $ok = $val < 0 }' 13 'MONOTONE-CERTIFIED' g13cc g13nrun
dk_control "$SRC13" "$MUT" 'A rectangle that does not certify is bisected on its relatively wider side' 'A rectangle that does not certify is bisected on its relatively wider side (a comment control)' "$FAST13A" g13cc g13arun

# ---- ARM 14: RESULTS 15, THE CERTIFIED DESCENT AND THE TUBE (2026-10-28 23:5x - 2026-10-29 00:5x EDT, the desktop seat) -- mkflow.awk's ----
# known answer LIVE (the exact GMP rational contained, the nearest-rounded liar escaping), its beta = 2.3 flow re-derived LIVE and compared
# with record d step for step (MPFR is deterministic under a fixed rounding mode); the four records' thresholds pinned (K* = 7, 7, 18, 37);
# g20_tube.pl's operator known answers and its strong-coupling known answer at beta_3 = 0.2 re-derived LIVE and compared with record b.
SRC14F="$B/mkflow.awk"; SRC14T="$B/g20_tube.pl"; LIVE14K="$B/g_mkkat.txt"; LIVE14F="$B/g_mkflow23.txt"; LIVE14T="$B/g_tube02.txt"; REC14T="$B/g20_tube_j1.2026-10-29b.txt"
for f in "$SRC14F" "$SRC14T" "$REC14T"; do [ -f "$f" ] || dk_red "ARM 14: missing $f"; done
for b in 2.2 2.3 5 10; do [ -f "$B/mkflow_b${b}.2026-10-29d.txt" ] || dk_red "ARM 14: missing the flow record d at beta $b"; done
rm -f "$LIVE14K" "$LIVE14F" "$LIVE14T"
gawk -M -v mode=kat -f "$SRC14F" 2>&1 | tr -d '\r' > "$LIVE14K" || dk_red "ARM 14: the flow's known answer refused"
grep -q 'of width [0-9.e-]* CONTAINS it$' "$LIVE14K" || dk_red "ARM 14: the flow's interval does not contain the exact rational"
dk_have "$LIVE14K" "which ESCAPES the exact value  [KAT-GREEN]"
gawk -M -v mode=wilson -v beta=2.3 -v N=100 -v KMAX=80 -f "$SRC14F" 2>&1 | tr -d '\r' > "$LIVE14F" || dk_red "ARM 14: the live flow at 2.3 refused"
grep '^MKF-STEP' "$B/mkflow_b2.3.2026-10-29d.txt" | cmp -s - <(grep '^MKF-STEP' "$LIVE14F") || dk_red "ARM 14: the live flow at 2.3 parts from record d"
dk_have "$LIVE14F" "MKF-THRESHOLD mode=wilson beta=2.3 reached c1 <= 0.131 at step K*=7 with c1^up=0.0832391885319700775143479"
dk_have "$B/mkflow_b2.2.2026-10-29d.txt" "reached c1 <= 0.131 at step K*=7 with c1^up=0.0468246472731963236484525"
dk_have "$B/mkflow_b5.2026-10-29d.txt" "reached c1 <= 0.131 at step K*=18 with c1^up=0.0441337005791905977807292"
dk_have "$B/mkflow_b10.2026-10-29d.txt" "reached c1 <= 0.131 at step K*=37 with c1^up=0.123193234125058418513033"
perl "$SRC14T" 0.2 1 40 6 2>&1 | tr -d '\r' | sed 's/  ([0-9]* s)$//' > "$LIVE14T" || dk_red "ARM 14: the tube at beta_3 = 0.2 refused"
dk_have "$LIVE14T" "G20-KAT operators  [ALL MET]"
grep '^G20-SPECTRUM beta=0.2 ' "$REC14T" | sed 's/  (Lanczos.*//' | cmp -s - <(grep '^G20-SPECTRUM beta=0.2 ' "$LIVE14T" | sed 's/  (Lanczos.*//') || dk_red "ARM 14: the live tube spectrum at 0.2 parts from record b"
LIVE14U="$B/g_tube23.txt"; perl "$SRC14T" 2.3 1 60 8 2>&1 | tr -d '' | sed 's/  ([0-9]* s)$//' > "$LIVE14U" || dk_red "ARM 14: the tube at beta_3 = 2.3 refused"
grep '^G20-SPECTRUM beta=2.3 ' "$REC14T" | sed 's/  (Lanczos.*//' | cmp -s - <(grep '^G20-SPECTRUM beta=2.3 ' "$LIVE14U" | sed 's/  (Lanczos.*//') || dk_red "ARM 14: the live tube spectrum at 2.3 parts from record b"
grep '^G20-LUMP beta=2.3 ' "$REC14T" | cmp -s - <(grep '^G20-LUMP beta=2.3 ' "$LIVE14U") || dk_red "ARM 14: the live tube's lumping line at 2.3 parts from record b"
dk_have "$LIVE14U" "the 0++ gap in the zero-flux sector = 2.771287; the torelon (flux (1,0) top against lambda_0) = 1.018863; the full gap 1.018863 IS the torelon"
dk_have "$LIVE14T" "strong-coupling -4 ln c_{1/2}=11.9896 ratio=0.9994 monotone-K=YES torelon-below-0++=YES"
dk_say "ARM 14: RESULTS 15 -- the flow's known answer contains the exact rational and refuses the liar, the 2.3 flow re-derived step for step, K* = 7/7/18/37 of record; the tube's operator known answers met and its strong-coupling gap re-derived against record b"
g14cc(){ cp "$1" "$2"; }
g14krun(){ gawk -M -v mode=kat -f "$1" 2>&1 | tr -d '\r'; }
g14tcc(){ perl -c "$1" > /dev/null 2>&1 && cp "$1" "$2"; }
g14trun(){ perl "$1" 0.2 1 40 6 kat 2>&1 | tr -d '\r'; }
export DK_BASE_RUN="$LIVE14K"
dk_tooth "$SRC14F" "$MUT" decimationbend 'dn(); CNL\[n\] = (VL\[n\] \/ VH\[0\]) ^ 4; up(); CNH\[n\] = (VH\[n\] \/ VL\[0\]) ^ 4' 'dn(); CNL[n] = (VL[n] / VH[0]) ^ 3; up(); CNH[n] = (VH[n] / VL[0]) ^ 3' 14 'KAT-GREEN' g14cc g14krun
export DK_BASE_RUN="$LIVE14T"
dk_tooth "$SRC14T" "$MUT" cornerbend '\$s\[2\] => { legs => \[\[3, +1\], \[1, -1\]\], srule => 2 }' '$s[2] => { legs => [[3, -1], [1, -1]], srule => 2 }' 14 'G20-KAT operators  [ALL MET]' g14tcc g14trun
dk_control "$SRC14F" "$MUT" 'no rounding is priced by hand and no radius compounds through a centre.' 'no rounding is priced by hand and no radius compounds through a centre (a comment control).' "$LIVE14K" g14cc g14krun

# ---- ARM 15: RESULTS 16.7, THE ONE-FACE CONSTANTS AND THE DECIMATION'S LEMMAS CERTIFIED (2026-10-29 02:2x-03:0x EDT, the desktop seat) ----
# g19_vmf.awk re-run LIVE (gawk -M, 256 bits, every endpoint under its own rounding mode, ~100 s) and compared byte for byte with record b (MPFR is
# deterministic under a fixed rounding mode): the corner enclosures and the sup of |D| at the corner; (E1) Var_par <= 1/4 for all kappa; (E2a) the
# sup over all r of 3|(m/r)'|; (E2) the sup over r <= 6 beta of T = |phi'''| + 3|D|/r; (E2DIR) the directional third cumulant's sup; the known
# answers (iii-43's Monte Carlo met, the 3m/kappa liar escaping, isotropy at kappa -> 0) and the hand lemma's margins pinned.
SRC15="$B/g19_vmf.awk"; REC15="$B/g19_vmf.2026-10-29b.txt"; LIVE15="$B/g_g19vmf.txt"
for f in "$SRC15" "$REC15"; do [ -f "$f" ] || dk_red "ARM 15: missing $f"; done
rm -f "$LIVE15"
gawk -M -v betas="0.30 0.32 0.34 0.35 0.36 0.38 0.40" -f "$SRC15" 2>&1 | tr -d '\r' > "$LIVE15" || dk_red "ARM 15: the live g19 refused"
cmp -s "$REC15" "$LIVE15" || dk_red "ARM 15: the live g19 parts from record b"
dk_have "$LIVE15" "G19-VERDICT known answers MET, the liar escapes at 3 of 3, isotropy MET, cells GREEN, the corner sup certified at every beta in range: yes  [G19-GREEN]"
dk_have "$LIVE15" "G19-SUP beta=0.35: |D(5beta, 5beta)| in [0.0117499725971583475, 0.0117499725971583476]"
dk_have "$LIVE15" "G19-CELLS2D [0.5, 2]^2 in 1048576 cells: (C) -D increasing in each variable failed 0"
dk_have "$LIVE15" "G19-CELLS1D [0.5, 2] in 1024 cells: (B1) by hand 341, failed 0"
dk_have "$LIVE15" "G19-HAND kappa=0.5 R<=0.000165239001692047378: (B1)/k^3 >= 0.0195312499999999999  (B2)/k^3 >= 0.0473065159819260149  (B3)/k^3 >= 0.0257915700601175061  [POSITIVE]"
dk_have "$LIVE15" "G19-KAT beta=0.5 kappa=5beta=2.5: |D| in [0.0306482860740691014, 0.0306482860740691015] against the Monte Carlo 0.0306 +- 3e-4: MET; the liar (3m/kappa) |D~| in [-0.0869913001104351624, -0.0869913001104351623]: ESCAPES"
dk_have "$LIVE15" "G19-BASE D(0.5, 0.5) in [-0.00012908018074613158, -0.000129080180746131579]: negative at the square's base corner"
dk_have "$LIVE15" "=> Var_par(kappa) <= 1/4 for all kappa >= 0  [E1-CERTIFIED]"
dk_have "$LIVE15" "(E2b) mu_4 - 3V^2 < 0 failed 0, worst upper bound -0.00758804885828730195; (E2c) chi = kappa A' - A > 0 failed 0"
dk_have "$LIVE15" "G19-E2A sup over r >= 0 of 3A/r = 3|(m/r)'|: the cells' largest upper bound 0.0828270202550751984 at the cell starting r = 2.394"
dk_have "$LIVE15" "G19-E2DIR beta=0.244: the sup over r in [0, 6beta] and over directions u of |kappa_3(<U,u>)| = |phi'''(6beta)| in [0.0604147765896044774, 0.0604147765896044775]"
dk_have "$LIVE15" "=> sup over r in [0, 6beta] of T(r) = T(6beta) <= 0.131795771876738304  [E2-CERTIFIED]"
dk_say "ARM 15: RESULTS 16.7 -- the one-face anisotropy certified at 256 bits with its sup at the corner, and the decimation's lemmas: Var_par <= 1/4 for all kappa (E1), sup 3|(m/r)'| <= 0.082827 (E2a), T(6 beta) <= 0.131796 at beta = 0.244 (E2), the directional third cumulant |phi'''(6 beta)| (E2DIR); live and equal to record b"
g15cc(){ cp "$1" "$2"; }
g15run(){ gawk -M -v betas="0.30 0.32 0.34 0.35 0.36 0.38 0.40" -f "$1" 2>&1 | tr -d '\r'; }
export DK_BASE_RUN="$LIVE15"
dk_tooth "$SRC15" "$MUT" h3bend 'dn(); h3 = 1 \/ 6 + 1 \/ 2 - t1' 'dn(); h3 = 1 / 6 + 1 / 3 - t1' 15 'cells GREEN, the corner sup certified at every beta in range: yes  [G19-GREEN]' g15cc g15run
dk_tooth "$SRC15" "$MUT" liarbend 'up(); t = 3 \* MHI \/ x; dn(); ptl = 1 - t; dn(); t = 3 \* MLO \/ x; up(); pth = 1 - t;' 'up(); t = 4 * MHI / x; dn(); ptl = 1 - t; dn(); t = 4 * MLO / x; up(); pth = 1 - t;' 15 'the liar escapes at 3 of 3' g15cc g15run
dk_tooth "$SRC15" "$MUT" kurtbend 'dn(); KURTL = mu4l - 3 \* VH2 \* VH2; up(); KURTH = mu4h - 3 \* VL2 \* VL2' 'dn(); KURTL = mu4l - 3 * VH2 * VH2; up(); KURTH = mu4h - 2 * VL2 * VL2' 15 '(E2b) mu_4 - 3V^2 < 0 failed 0' g15cc g15run
dk_tooth "$SRC15" "$MUT" e1tailbend 'dn(); tail = 2 \* (1 - MHI); up(); tail = 2 \* (1 - MLO);' 'dn(); tail = 2 * (1 - MHI); up(); tail = 2 * (1 - MLO) + 0.05;' 15 'E1-CERTIFIED' g15cc g15run
dk_control "$SRC15" "$MUT" 'so no rounding is priced by hand.' 'so no rounding is priced by hand (a comment control).' "$LIVE15" g15cc g15run

# ---- ARM 16: RESULTS 16.6, THE CUBE AT THE CERTIFIED FLOW'S RUNG WEIGHT (2026-10-29 02:1x EDT, the desktop seat) -- g14_su2_cube.pl's weight ----
# mode LIVE in its fast form (MODE=dlink: the one-link Delta alone): the Wilson law at beta = 0.5 equal to the delta record's line (Delta_link =
# 0.163334), and the TRUNCATED law at rung 7 of the flow from 2.2 (c_1 = 0.0468246..., beta_eff = 0.187573, Delta_link = 0.032318) re-derived.
SRC16="$B/g14_su2_cube.pl"; LIVE16W="$B/g_g14dlink05.txt"; LIVE16R="$B/g_g14dlinkk7.txt"; REC16D="$B/g14_su2_cube_b0.5_delta.2026-10-29a.txt"
for f in "$SRC16" "$REC16D"; do [ -f "$f" ] || dk_red "ARM 16: missing $f"; done
rm -f "$LIVE16W" "$LIVE16R"
perl "$SRC16" 0.5 dlink 0 8 20 11 2>&1 | tr -d '\r' > "$LIVE16W" || dk_red "ARM 16: the fast mode at 0.5 refused"
grep '^G14D beta=0.5000' "$REC16D" | tr -d '\r' | cmp -s - <(grep '^G14D beta=0.5000' "$LIVE16W") || dk_red "ARM 16: the live one-link Delta at 0.5 parts from the delta record"
dk_have "$LIVE16W" "Delta_link (one link, two of six staples moved, the rest 1) = 0.163334  [Lemma T's 8 beta/(3 pi) = 0.424413]"
G14_C1=0.0468246472731963236484524 G14_C2=0.000382029255316772489943254 G14_RUNG=7 G14_FROM=2.2 perl "$SRC16" 0.5 dlink 0 8 20 11 2>&1 | tr -d '\r' > "$LIVE16R" || dk_red "ARM 16: the fast mode at rung 7 refused"
dk_have "$LIVE16R" "G14W rung 7 of the certified flow from beta=2.2: c_1=0.0468246472732 c_2=0.000382029255317 beta_eff(c_1)=0.187573"
dk_have "$LIVE16R" "G14D-WEIGHT rung 7 of the certified flow from beta=2.2: Delta_link below is the TRUNCATED weight's one-link law"
dk_have "$LIVE16R" "Delta_link (one link, two of six staples moved, the rest 1) = 0.032318"
dk_say "ARM 16: RESULTS 16.6 -- the cube's weight mode live: the Wilson one-link Delta at 0.5 equal to the delta record's, the truncated law at rung 7 of the certified flow from 2.2 (c_1 = 0.0468, beta_eff 0.1876) re-derived"
g16cc(){ perl -c "$1" > /dev/null 2>&1 && cp "$1" "$2"; }
g16run(){ G14_C1=0.0468246472731963236484524 G14_C2=0.000382029255316772489943254 G14_RUNG=7 G14_FROM=2.2 perl "$1" 0.5 dlink 0 8 20 11 2>&1 | tr -d '\r'; }
export DK_BASE_RUN="$LIVE16R"
dk_tooth "$SRC16" "$MUT" trunclawbend 'qtr(\$U, \[1, 0, 0, 0\])) \*\* 4 \* (1 + 2 \* \$A1 \* qtr(\$U, \$g))' 'qtr($U, [1, 0, 0, 0])) ** 3 * (1 + 2 * $A1 * qtr($U, $g))' 16 'Delta_link (one link, two of six staples moved, the rest 1) = 0.032318' g16cc g16run
dk_tooth "$SRC16" "$MUT" overridebend '\$A1 = \$ENV{G14_C1} + 0; \$A2 = (\$ENV{G14_C2} \/\/ 0) + 0;' '$A1 = $ENV{G14_C1} * 2; $A2 = ($ENV{G14_C2} // 0) + 0;' 16 'c_1=0.0468246472732 c_2=0.000382029255317 beta_eff(c_1)=0.187573' g16cc g16run
dk_control "$SRC16" "$MUT" 'the truncation keeps c_1 alone, so the rung enters as' 'the truncation keeps c_1 alone (a comment control), so the rung enters as' "$LIVE16R" g16cc g16run

# ---- ARM 17: RESULTS 16.11-16.12, THE PERFECT DECIMATION'S ROW SUM ON A SECOND ROAD, THE CUBE COVER'S OBSTRUCTION, THE BLOCK SPLIT ----
# (2026-10-29 03:1x-03:3x EDT, the desktop seat).  g24_rowsum.awk LIVE (gawk -M, 256 bits, directed rounding; 3 s) byte-compared with its record:
# the plan seat's row certified below 1 on [0, 0.2414] (proved constants) and [0, 0.2452] (sharp), its known answers met, the half-tilt liar above 1.
# g25_cubecover.pl LIVE: the single-link perfect decimation FOUND at period 2 (its known answer) and NO unit-3-cube cover at period 3 (the local
# obstruction, 37 nodes).  g27_blocksplit.pl LIVE byte-compared with its record: the in-block incidence fractions on the period-2 cover.
SRC17A="$B/g24_rowsum.awk"; REC17A="$B/g24_rowsum.2026-10-29a.txt"; LIVE17A="$B/g_g24.txt"
SRC17B="$B/g25_cubecover.pl"; LIVE17B="$B/g_g25link.txt"; LIVE17C="$B/g_g25cube.txt"
SRC17D="$B/g27_blocksplit.pl"; REC17D="$B/g27_blocksplit.2026-10-29a.txt"; LIVE17D="$B/g_g27.txt"
C17="0.26:0.0352538364247406:0.00835049469130599 0.28:0.0409087584062936:0.00990616778613137 0.30:0.0470291702042949:0.0116466012617517"
for f in "$SRC17A" "$REC17A" "$SRC17B" "$SRC17D" "$REC17D"; do [ -f "$f" ] || dk_red "ARM 17: missing $f"; done
rm -f "$LIVE17A" "$LIVE17B" "$LIVE17C" "$LIVE17D"
gawk -M -f "$SRC17A" 2>&1 | tr -d '\r' > "$LIVE17A" || dk_red "ARM 17: the live row sum refused"
cmp -s "$REC17A" "$LIVE17A" || dk_red "ARM 17: the live row sum parts from its record"
dk_have "$LIVE17A" "the row is certified below 1 on [0, 0.2414] and above 1 from 0.2415"
dk_have "$LIVE17A" "the row is certified below 1 on [0, 0.2452] and above 1 from 0.2453"
dk_have "$LIVE17A" "G24-KAT PROVED at beta = 0.2410: ROW in [0.996296731179099, 0.9962967311791] against the plan seat's ROW_hi = 0.996297: MET"
dk_have "$LIVE17A" "the liar fails where the plan seat said it does"
dk_have "$LIVE17A" "the liar refused at 0.2410: yes; the row certified below 1 to beta = 0.2414 (proved) and 0.2452 (sharp)  [G24-GREEN]"
perl "$SRC17B" 2 2 2 2 link 2>&1 | tr -d '\r' | sed 's/ ([0-9]* s)//' > "$LIVE17B" || dk_red "ARM 17: the link cover refused"
dk_have "$LIVE17B" "AN EXACT COVER by 16 candidates after 17 nodes; the independent count: 0 plaquettes touched not exactly once  [COVER-VERIFIED]"
perl "$SRC17B" 3 3 3 3 cube 3e6 2>&1 | tr -d '\r' | sed 's/ ([0-9]* s)//' > "$LIVE17C" || dk_red "ARM 17: the cube cover refused"
dk_have "$LIVE17C" "G25-RESULT period (3,3,3,3) kind=cube: NO EXACT COVER EXISTS after 37 nodes"
perl "$SRC17D" $C17 2>&1 | tr -d '\r' > "$LIVE17D" || dk_red "ARM 17: the block split refused"
cmp -s "$REC17D" "$LIVE17D" || dk_red "ARM 17: the live block split parts from its record"
dk_have "$LIVE17D" "G27-CLASS intra kept links: 24 classes; per link TYPE I 12.00 (in-block 6.00, fraction 0.500), TYPE II 90.00 (in-block 22.00, fraction 0.244)"
dk_have "$LIVE17D" "G27-ROW beta=0.28 intra: the full row 12 C_dir + 90 C_med = 1.382460; with the in-block incidences removed 0.919072  [BELOW-1]"
dk_say "ARM 17: RESULTS 16.11-16.12 -- the decimation's row certified below 1 to 0.2414 (proved) and 0.2452 (sharp) on the second road, the plan seat's known answers met and the liar refused; the single-link cover found at period 2 and no unit-3-cube cover at period 3; the block split of record"
g17cc(){ cp "$1" "$2"; }
g17arun(){ gawk -M -f "$1" 2>&1 | tr -d '\r'; }
g17pcc(){ perl -c "$1" > /dev/null 2>&1 && cp "$1" "$2"; }
g17brun(){ perl "$1" 2 2 2 2 link 2>&1 | tr -d '\r' | sed 's/ ([0-9]* s)//'; }
g17drun(){ perl "$1" $C17 2>&1 | tr -d '\r'; }
export DK_BASE_RUN="$LIVE17A"
dk_tooth "$SRC17A" "$MUT" tiltbend 'crossing("proved", 1 \/ 4, "PROVED' 'crossing("proved", 1 / 3, "PROVED' 17 'the row is certified below 1 on [0, 0.2414] and above 1 from 0.2415' g17cc g17arun
dk_tooth "$SRC17A" "$MUT" incidencebend 'dn(); RL = 12 \* cdl + 90 \* cml; up(); RH = 12 \* cdh + 90 \* cmh' 'dn(); RL = 11 * cdl + 90 * cml; up(); RH = 11 * cdh + 90 * cmh' 17 'the row is certified below 1 on [0, 0.2414] and above 1 from 0.2415' g17cc g17arun
dk_tooth "$SRC17A" "$MUT" rhobend 'dn(); rhol = (3 \* exp(oml) - 1) \/ 2; up(); rhoh = (3 \* exp(omh) - 1) \/ 2;' 'dn(); rhol = (2 * exp(oml) - 1) / 2; up(); rhoh = (2 * exp(omh) - 1) / 2;' 17 'the row is certified below 1 on [0, 0.2414] and above 1 from 0.2415' g17cc g17arun
dk_control "$SRC17A" "$MUT" 'every term rises with beta (m increasing;' 'every term rises with beta (a comment control; m increasing;' "$LIVE17A" g17cc g17arun
export DK_BASE_RUN="$LIVE17B"
dk_tooth "$SRC17B" "$MUT" plaqbend 'push @p, pid($x, $a, $b), pid(vshift($x, $e, -1), $a, $b)' 'push @p, pid($x, $a, $b)' 17 'AN EXACT COVER by 16 candidates after 17 nodes' g17pcc g17brun
dk_control "$SRC17B" "$MUT" 'the first cover found is printed with its cubes and VERIFIED' 'the first cover found is printed with its cubes (a comment control) and VERIFIED' "$LIVE17B" g17pcc g17brun
export DK_BASE_RUN="$LIVE17D"
dk_tooth "$SRC17D" "$MUT" intrabend 'sub intra { my ($x, $d) = @_; return ($x->\[$d\] % 2 + 2) % 2 == 0 }' 'sub intra { my ($x, $d) = @_; return ($x->[$d] % 2 + 2) % 2 == 1 }' 17 'in-block 6.00, fraction 0.500' g17pcc g17drun
dk_control "$SRC17D" "$MUT" 'A READING of the bound' 'A READING (a comment control) of the bound' "$LIVE17D" g17pcc g17drun

# ---- ARM 18: RESULTS 16.12-16.13, THE CUBE AT SPINS <= 1 AND THE CLOSED RECORDS (2026-10-29 03:2x-03:3x EDT, the desktop seat) -- ----
# g26_cube_spin1.pl LIVE in kat mode (RULE12's moments, the spin-1 homomorphism, the truncated weight's positivity at 2.2; 2 s) and in its spin-1/2
# restriction at 0.5 (40 s), which must reproduce g14's delta record for the same pair (Delta = 0.005857 at the quarter turn); the rung records'
# sup lines and the inertia record's gap line pinned, the inertia reader's digest checked against the record's header.
SRC18="$B/g26_cube_spin1.pl"; LIVE18K="$B/g_g26kat.txt"; LIVE18H="$B/g_g26half.txt"; REC18I="$B/g6_inertia_3x4.2026-10-28a.txt"
for f in "$SRC18" "$REC18I" "$B/g6_inertia.pl"; do [ -f "$f" ] || dk_red "ARM 18: missing $f"; done
for k in 5 6 7; do [ -f "$B/g14_su2_cube_flow2.2_k${k}_delta.2026-10-29a.txt" ] || dk_red "ARM 18: missing the rung record $k"; done
rm -f "$LIVE18K" "$LIVE18H"
perl "$SRC18" 2.2 kat 2>&1 | tr -d '\r' > "$LIVE18K" || dk_red "ARM 18: the kat mode refused"
dk_have "$LIVE18K" "R(q1 q2) = R(q1) R(q2) and tr R = 4w^2 - 1: MET  [KAT-GREEN]"
dk_have "$LIVE18K" "the truncated weight's minimum over V = 0.071034 (positive)"
perl "$SRC18" 0.5 spinhalf 1,2,4,6,8,9,24,26 2>&1 | tr -d '\r' | sed 's/  ([0-9]* s)$//' > "$LIVE18H" || dk_red "ARM 18: the spin-1/2 restriction refused"
dk_have "$LIVE18H" "Delta_cube=0.005857 argmax-g'=(-0.707,0.707,0.000,0.000)"
grep -q 'G14D-PAIR beta=0.5000 datum=symmetric pair=b0:near -> t0:near u=0,0,-1,0:3 u.=0,0,1,0:3 Delta=0.005857 argmax-g.=(-0.707,0.707,0.000,0.000)' "$B/g14_su2_cube_b0.5_delta.2026-10-29a.txt" || dk_red "ARM 18: g14's record no longer carries the pair line the restriction must reproduce"
dk_have "$B/g14_su2_cube_flow2.2_k5_delta.2026-10-29a.txt" "G14D-SUP beta=1.0059 Delta_cube over 3 data and 10 pairs = 0.074256 at symmetric/b0:near -> t0:near; Delta_link = 0.609402; ratio = 0.1219"
dk_have "$B/g14_su2_cube_flow2.2_k6_delta.2026-10-29a.txt" "G14D-SUP beta=0.5919 Delta_cube over 3 data and 10 pairs = 0.010786 at symmetric/b0:near -> t0:near; Delta_link = 0.213332; ratio = 0.0506"
dk_have "$B/g14_su2_cube_flow2.2_k7_delta.2026-10-29a.txt" "G14D-SUP beta=0.1876 Delta_cube over 3 data and 10 pairs = 0.000098 at symmetric/b0:near -> t0:near; Delta_link = 0.032318; ratio = 0.0030"
dk_have "$REC18I" "G6I-GAP L=3x4 u=1/2 gap in [2.288153115629533, 2.288153115653228] width=2.369e-11 dual-road-lambdas=CONTAINS"
grep -qF "$(sha256sum "$B/g6_inertia.pl" | cut -c1-64)" "$REC18I" || dk_red "ARM 18: the inertia reader's digest is not the one its record names"
dk_say "ARM 18: RESULTS 16.12-16.13 -- the spins-<=-1 cube's known answers live (RULE12 exact to degree 12, the spin-1 homomorphism, positivity at 2.2) and its spin-1/2 restriction equal to g14's record; the rung records and the inertia-certified 3x4 gap of record"
g18cc(){ perl -c "$1" > /dev/null 2>&1 && cp "$1" "$2"; }
g18run(){ perl "$1" 2.2 kat 2>&1 | tr -d '\r'; }
export DK_BASE_RUN="$LIVE18K"
dk_tooth "$SRC18" "$MUT" rulebend 'for my $k (1 .. 7) { my $th = $k \* $PI \/ 8;' 'for my $k (1 .. 6) { my $th = $k * $PI / 7;' 18 '[KAT-GREEN]' g18cc g18run
dk_tooth "$SRC18" "$MUT" rotbend '2\*($x\*$y - $w\*$z)' '2*($x*$y + $w*$z)' 18 '[KAT-GREEN]' g18cc g18run
dk_control "$SRC18" "$MUT" 'A READING of a TRUNCATED model, said so' 'A READING of a TRUNCATED model (a comment control), said so' "$LIVE18K" g18cc g18run

# ---- ARM 19: RESULTS 16.15-16.16, THE W_1 CONSTANT, THE LAW'S FIVE COUPLINGS, THE GRIFFITHS READING (2026-10-29 03:4x-04:0x EDT, the desktop ----
# seat) -- g28_w1mad.pl's exact part LIVE (the anti-monotone cost along the axis and Var_perp across it at six concentrations, 1 s): L(0) = 1/4
# pinned, the kappa = 1 values, the consistency verdicts; the fourth-order law's record lines at 0.3/0.7/0.9/1.0 pinned by content (a reading
# of record, the band staked first); g20_tube.pl's Griffiths reading at beta_3 = 0.5 re-run LIVE and its verdict line pinned (a reading's
# regression guard, not a theorem: the negatives sit at the truncation's scale).
SRC19="$B/g28_w1mad.pl"; LIVE19="$B/g_g28exact.txt"; LIVE19G="$B/g_g20griff05.txt"; SRC19T="$B/g20_tube.pl"
for f in "$SRC19" "$SRC19T" "$B/g14_su2_cube_b0.3_delta.2026-10-29a.txt" "$B/g14_su2_cube_b0.7_delta.2026-10-29a.txt" "$B/g14_su2_cube_b0.9_delta.2026-10-29a.txt" "$B/g14_su2_cube_b1.0_delta.2026-10-29a.txt" "$B/g20_griff_b0.5.2026-10-29a.txt"; do [ -f "$f" ] || dk_red "ARM 19: missing $f"; done
rm -f "$LIVE19" "$LIVE19G"
perl "$SRC19" "0 0.5 1 1.5 2 3" 40000 0 2>&1 | tr -d '\r' > "$LIVE19" || dk_red "ARM 19: the W_1 constant's exact part refused"
dk_have "$LIVE19" "G28 kappa=0: m=0.00000000 Var_par=0.25000000 Var_perp=0.25000000 (grid var 0.25000000, masses nu+ 0.21220659 nu- 0.21220659); AXIAL L_par = anti-monotone cost 0.25000000 (the monotone plan 0.26240834, the linear f 0.25000000) [CONSISTENT]; PERPENDICULAR L_perp = Var_perp = 0.25000000 exactly; sup over u in {par, perp} = 0.25000000  [AT-OR-BELOW-1/4]"
dk_have "$LIVE19" "G28-KAT kappa=0: the anti-monotone (reflection) cost 0.2500000000 against 1/4: MET"
dk_have "$LIVE19" "G28 kappa=1: m=0.24019372 Var_par=0.22172580 Var_perp=0.24019372 (grid var 0.22172580, masses nu+ 0.19646824 nu- 0.19646824); AXIAL L_par = anti-monotone cost 0.22518103 (the monotone plan 0.23596319, the linear f 0.22172580) [CONSISTENT]"
dk_have "$LIVE19" "G28 kappa=3: m=0.56792365 Var_par=0.10953908 Var_perp=0.18930788 (grid var 0.10953908, masses nu+ 0.12927326 nu- 0.12927326); AXIAL L_par = anti-monotone cost 0.12409260"
[ "$(grep -c 'AT-OR-BELOW-1/4' "$LIVE19")" -eq 6 ] || dk_red "ARM 19: not every concentration's sup over the symmetric directions is at or below 1/4"
dk_have "$B/g14_su2_cube_b0.3_delta.2026-10-29a.txt" "G14D-SUP beta=0.3000 Delta_cube over 1 data and 10 pairs = 0.000804 at symmetric/b0:near -> t0:near; Delta_link = 0.075707; ratio = 0.0106"
dk_have "$B/g14_su2_cube_b0.7_delta.2026-10-29a.txt" "G14D-SUP beta=0.7000 Delta_cube over 1 data and 10 pairs = 0.019204 at symmetric/b0:near -> t0:near; Delta_link = 0.240848; ratio = 0.0797"
dk_have "$B/g14_su2_cube_b0.9_delta.2026-10-29a.txt" "G14D-SUP beta=0.9000 Delta_cube over 1 data and 10 pairs = 0.049049 at symmetric/b0:near -> t0:near; Delta_link = 0.323567; ratio = 0.1516"
dk_have "$B/g14_su2_cube_b1.0_delta.2026-10-29a.txt" "G14D-SUP beta=1.0000 Delta_cube over 3 data and 10 pairs = 0.072649 at symmetric/b0:near -> t0:near; Delta_link = 0.362908; ratio = 0.2002"
G20_GRIFF=1 perl "$SRC19T" 0.5 1 60 8 2>&1 | tr -d '\r' | sed 's/  ([0-9]* s)$//' > "$LIVE19G" || dk_red "ARM 19: the Griffiths reading at 0.5 refused"
dk_have "$LIVE19G" "G20-GRIFF-VERDICT beta=0.5 JMAX=1: 8 negative connected plaquette-loop correlations below -1e-09 among 180 (J = 1/2 and 1, the 10 pairs, d = 0..8); the worst -3.928e-04; <tr U_p> = 0.248387  [GKS-II-FAILS-IN-THE-TRUNCATED-MODEL]"
dk_have "$LIVE19G" "G20-GRIFF beta=0.5 J=0.5 p=0 q=1 d=0 <W_p W_q>_c = +2.995031e-03"
grep '^G20-GRIFF-VERDICT' "$B/g20_griff_b0.5.2026-10-29a.txt" | tr -d '\r' | cmp -s - <(grep '^G20-GRIFF-VERDICT' "$LIVE19G") || dk_red "ARM 19: the live Griffiths verdict at 0.5 parts from its record"
dk_say "ARM 19: RESULTS 16.15-16.16 -- the W_1 constant's exact part live (L(0) = 1/4 by the reflection plan, the anti-monotone cost along the axis and Var_perp across it at or below 1/4 at every concentration); the fourth-order law's lines of record at four couplings; the Griffiths reading at 0.5 re-derived and equal to its record (a reading: the loop traces positive beyond the truncation's scale, the J = 1 negatives at it)"
g19cc(){ perl -c "$1" > /dev/null 2>&1 && cp "$1" "$2"; }
g19run(){ perl "$1" "0 0.5 1 1.5 2 3" 40000 0 2>&1 | tr -d '\r'; }
export DK_BASE_RUN="$LIVE19"
dk_tooth "$SRC19" "$MUT" costbend '\$anti += \$rp\[\$i\] \* 2 \* sin(abs(\$tj - \$th\[\$i\]) \/ 2) } }' '$anti += $rp[$i] * 2 * sin(abs($tj - $th[$i]) / 3) } }' 19 'AXIAL L_par = anti-monotone cost 0.25000000 (the monotone plan 0.26240834, the linear f 0.25000000) [CONSISTENT]' g19cc g19run
dk_tooth "$SRC19" "$MUT" monobend 'while (\$j < \$N - 1 && \$Fm\[\$j\] < \$level) { \$j++ }' 'while ($j < $N - 1 && $Fm[$j] < $level / 2) { $j++ }' 19 'AXIAL L_par = anti-monotone cost 0.25000000 (the monotone plan 0.26240834, the linear f 0.25000000) [CONSISTENT]' g19cc g19run
dk_control "$SRC19" "$MUT" 'THE REDUCTION.  By Kantorovich-Rubinstein' 'THE REDUCTION (a comment control).  By Kantorovich-Rubinstein' "$LIVE19" g19cc g19run

dk_teeth_pin 47

dk_green "PENTAPYLON-GATE GREEN: 20 arms, 47 teeth bled in named arms, the comment controls silent -- RESULTS 16: beta_P on two roads (the decimation row certified below 1 to 0.2414 proved and 0.2452 sharp), no perfect cube decimation, the block split, the spins-<=-1 cube built with its known answers, the W_1 constant exact in the symmetric directions (L(0) = 1/4), the fourth-order law of record at five couplings, the Griffiths reading; the decimation lemmas certified at 256 bits (Var_par <= 1/4 for all kappa; sup 3|(m/r)'| <= 0.082827; T(6 beta) <= 0.131796 at beta = 0.244; the directional third cumulant) and the one-face anisotropy with its sup at the corner, the cube read at the certified flow's rung weight; RESULTS 14: the sharp one-link lemma of record in every direction (0.131 = 3 pi/72 a theorem); RESULTS 15: the hierarchical descent certified at 256 bits (K* = 7/7/18/37), the tube's known answers and its strong-coupling gap of record; RESULTS 13: the cone's fixed point 1/3600 predicted and met, the exact bridge's action flat to seven digits with its control deviating at O(s); RESULTS 12: the transform is Dobrushin's coefficient (two known answers MET against the inertia road's certified cells, a third against the dual road's reading), the chain lemma's inequalities hold on every two-scale cell, the hierarchical step's spectrum is 4^{2-d}(1 + O(t)) about the heat-kernel line, claim (A) certified at 99 of 100 exact starts and the descent to the kernel's threshold certified from q = 7/10 and 8/10; G6-b: the tube gap's strong-coupling series is a ratio of exponential moments of the fundamental character, the moments integers and SU(2)'s the Catalan numbers; a shadow of design strength t shares SU(2)'s moments through n = t and its gap series parts at b^(t-1) -- Q8 at b^2 by -4/3, 2T at b^4 by -1/30, 2O at b^6 by -1/1260, 2I at b^10 by -1/9979200 -- the mass gap's leading term tracked through the ladder as exact rationals, t composed from ΑΠΕΡΑΝΤΟΝ's tables; THE LADDER (STAKE 4): SU(2)'s tube coefficient enclosed and the defect column certified -- the magnitude falling strictly along Q8 > 2T > 2O > 2I at every y with the intervals separated, every defect negative, the two roads meeting at y = 1/2; THE BOXES (STAKE 5): the 2x4 cell read through ΣΤΡΟΦΙΓΞ's cap-reading door -- the three-length string test ALIVE at NEITHER prediction, the sqrt-area window DIED, the ordered side of the Ising point entered at y = 1/5, the 60-bit wall named; the box exe built and the quick cells re-derived live here; THE DUAL-SPIN ROAD (ARM 6): the second road meets every certified Z2 cell, reads the 3x4 and 4x4 boxes, and the Ising anchor fixes the infinite-lattice series through u^12; GATE 3 (ARM 7): the Cayley gaps of Q8, 2T, 2O, 2I are 6, 4, 6 - 3 sqrt2 and 12 - 6 phi, the fundamental's at each with nothing below, the desk's seven factorizations met, the dihedral nearest shells refused by name; STAKE 8 (ARM 8): the inertia road brackets every certified Z2 cell by sign counts alone, the dual road's lambdas inside and ΤΟΜΕΥΣ' intervals met, 14 of 14"
