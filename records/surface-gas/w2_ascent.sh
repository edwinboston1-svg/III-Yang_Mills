#!/bin/bash
# w2_ascent.sh -- THE WORST-CONFIGURATION ASCENT (THE CROSSING CAMPAIGN §16, 2026-11-01, the trunk seat): coordinate ascent of (8.5)'s
# C_omega(A, B) over the outside links of the one-step two-face object, each link tried at the eight unit quaternions +-1, +-i, +-j, +-k,
# a move accepted when the fast reader's C rises; the full reader on the accepted datum at the end of every pass.  A found value is a LOWER
# bound on the supremum over the outside.  usage: w2_ascent.sh <tag> <start datum file> <link list file> [passes=2] [WMAX=2] [LMAX=2]
# The datum file: one line per outside link, "<index> <w> <x> <y> <z>" in the engine's W2-OUT order; the link list: one index per line.
set -u
cd "$(dirname "$0")" || exit 9
TAG="$1"; START="$2"; LINKS="$3"; PASSES="${4:-2}"; WMAX="${5:-2}"; LMAX="${6:-2}"; BETA=2.2
OUT="ascent/$TAG"; mkdir -p "$OUT"; LOG="$OUT/ascent.log"; CUR="$OUT/datum.cur"; cp "$START" "$CUR"
export OMP_NUM_THREADS="${ASC_THREADS:-4}"
ENG=./w2_strip_dd.exe; RD=./w2_dob.exe
eval_C(){ # $1 = datum file -> prints C (fast reader) or REFUSED or ERROR
  local d="$1" rec="$OUT/eval.dump" rd="$OUT/eval.dob"
  W2_DUMPF=1 W2_DATUM="$d" $ENG $BETA $WMAX $LMAX ordered fwd bent 2 > "$rec" 2>&1 || { echo ERROR; return; }
  grep -q '^W2-FHEAD' "$rec" || { echo ERROR; return; }
  $RD "$rec" 20 20 8 6 > "$rd" 2>&1 || { echo ERROR; return; }
  if grep -q '^W2DOB-REFUSED' "$rd"; then echo REFUSED; return; fi
  grep -o '^W2DOB-C rule degree 20 ([0-9]* points): C = [0-9.]*' "$rd" | tail -1 | sed 's/.*C = //'; }
full_C(){ # $1 = datum file, $2 = label -> the full reader's record kept
  local d="$1" rec="$OUT/$2.dump" rd="$OUT/$2.dob"
  W2_DUMPF=1 W2_DATUM="$d" $ENG $BETA $WMAX $LMAX ordered fwd bent 2 > "$rec" 2>&1; $RD "$rec" 30 60 12 24 > "$rd" 2>&1
  grep -E '^W2DOB-(CENSUS|C rule degree 60|DELTA rule|RESULT|REFUSED)' "$rd" | sed -E 's/ after [0-9]+ accepted moves//; s/ at V=.*//' | cut -c1-200; }
echo "ASCENT $TAG start $(date '+%Y-%m-%d %H:%M:%S') beta=$BETA WMAX=$WMAX LMAX=$LMAX passes=$PASSES links=$(wc -l < "$LINKS") threads=$OMP_NUM_THREADS" | tee -a "$LOG"
base=$(eval_C "$CUR"); echo "BASE C=$base" | tee -a "$LOG"
case "$base" in REFUSED|ERROR) echo "the start datum is $base; nothing to climb" | tee -a "$LOG"; exit 2;; esac
cur="$base"
CANDS=("1 0 0 0" "-1 0 0 0" "0 1 0 0" "0 -1 0 0" "0 0 1 0" "0 0 -1 0" "0 0 0 1" "0 0 0 -1")
for pass in $(seq 1 "$PASSES"); do
  accepted=0; tried=0; refused=0
  for l in $(shuf "$LINKS"); do
    curval=$(awk -v l="$l" '$1 == l { print $2, $3, $4, $5 }' "$CUR")
    bestc="$cur"; bestv=""
    for c in "${CANDS[@]}"; do
      [ "$c" = "$curval" ] && continue
      awk -v l="$l" -v v="$c" '$1 == l { print $1, v; next } { print }' "$CUR" > "$OUT/datum.try"
      t=$(eval_C "$OUT/datum.try"); tried=$((tried + 1))
      case "$t" in REFUSED) refused=$((refused + 1)); continue;; ERROR) echo "ERROR at link $l cand [$c]" | tee -a "$LOG"; continue;; esac
      if awk -v a="$t" -v b="$bestc" 'BEGIN { exit !(a > b + 1e-9) }'; then bestc="$t"; bestv="$c"; fi
    done
    if [ -n "$bestv" ]; then
      awk -v l="$l" -v v="$bestv" '$1 == l { print $1, v; next } { print }' "$CUR" > "$OUT/datum.new" && mv "$OUT/datum.new" "$CUR"
      echo "pass $pass link $l := [$bestv]  C $cur -> $bestc  $(date '+%H:%M:%S')" | tee -a "$LOG"; cur="$bestc"; accepted=$((accepted + 1)); fi
  done
  cp "$CUR" "$OUT/datum.pass$pass"
  echo "PASS $pass end: accepted=$accepted tried=$tried refused=$refused C=$cur $(date '+%H:%M:%S')" | tee -a "$LOG"
  echo "--- the full reader on the pass-$pass datum (W${WMAX}L${LMAX}):" | tee -a "$LOG"; full_C "$CUR" "full_pass$pass" | tee -a "$LOG"
  [ "$accepted" -eq 0 ] && break
done
echo "--- the cap check: the found datum at plaquette spins to 3/2 (W3L${LMAX}):" | tee -a "$LOG"
WMAX=3 full_C "$CUR" "full_W3" | tee -a "$LOG"
echo "ASCENT $TAG end $(date '+%Y-%m-%d %H:%M:%S') C=$cur" | tee -a "$LOG"
