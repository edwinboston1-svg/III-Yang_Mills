#!/bin/bash
# ladder_mode_runs.sh -- THE LADDERS UNDER THE LADDER MODE (w2_strip_l.exe, W2_LADDER=1: one stored forward sweep, one backward pass, a
# mini-sweep per outside link; controlled 11:5x-12:0x against the landed records: 174/174 and 532/532 links at the ordered datum to the
# records' digits, the row sum to seven): (1) the SU(2) second and third couplings, beta = 1.5 and 3.0, one step and two steps at W2L1, the
# ordered datum -- the one-step rungs and the 1.5 two-step were also read link by link (su2_second_coupling.sh, stopped at the 3.0 two-step),
# so those three are the ladder mode's controls at a new coupling; (2) THE CAP: the two-step W3L1 ladder at 2.2, the run the
# link-by-link ladder could not finish (127 of 532 under the capped engine when stopped).  Records ladder{1,2}/lad_ordered_n{2,4}_W{2,3}L1[_b<beta>].txt.
set -u
cd "/c/Users/Edwin Boston/OneDrive/Desktop/III/STDLIB/build/aperanton/surface-gas" || exit 2
EXE=./w2_strip_l.exe; THR=8
run(){ local n=$1 W=$2 B=$3 out=$4; if [ -e "$out" ]; then echo "REFUSED: $out exists"; return; fi
  local t0; t0=$(date +%s); W2_LIST=1 W2_LADDER=1 OMP_NUM_THREADS=$THR "$EXE" "$B" "$W" 1 ordered fwd bent "$n" > "$out" 2>&1
  echo "$out: $(( $(date +%s) - t0 )) s; $(grep -c '^W2-LAD ' "$out") links; $(grep '^W2-LADDER-CLASS a=1' "$out" | grep -o 'the cut identity[^;]*')"
  gawk -v n="$n" -f w2_ladder.awk "$out" | head -1; }
echo "start $(date '+%H:%M:%S %Z')"
for B in 1.5 3.0; do run 2 2 "$B" "ladder1/lad_ordered_n2_W2L1_b$B.txt"; run 4 2 "$B" "ladder2/lad_ordered_n4_W2L1_b$B.txt"; done
run 4 3 2.2 ladder2/lad_ordered_n4_W3L1.txt
echo "end $(date '+%H:%M:%S %Z')"
