#!/bin/bash
# su2_second_coupling.sh -- THE SU(2) INFLUENCE LADDER AT A SECOND AND A THIRD COUPLING (the §11 ADDENDUM RESULTS' next instrument): the
# one-step (174 links) and two-step (532 links) objects at W2L1, the ordered datum, every outside link rotated by pi about the x-axis, at
# beta = 1.5 (the strong-coupling side of SU(2)'s crossover) and beta = 3.0 (the weak-coupling side), beside the landed 2.2 pair -- so that
# SU(2)'s direction from one step to two is read on both sides of its crossover as U(1)'s now is on both sides of its beta_c.  Under the
# B-representation cap W2_CMAX=0 (the ladder's quantity unchanged by it, controlled 10:3x), 8 threads, every rotated record kept, new names.
# A frozen copy in the scratchpad, never edited while it runs.
set -u
cd "/c/Users/Edwin Boston/OneDrive/Desktop/III/STDLIB/build/aperanton/surface-gas" || exit 2
EXE=./w2_strip_c.exe; PI=3.141592653589793; THR=8
rung(){ local n=$1 B=$2 dir=$3; local BASE="$dir/base_ordered_n${n}_W2L1_b${B}.txt" TV="$dir/tv_ordered_n${n}_W2L1_b${B}_pi.txt" ROT="$dir/n${n}_W2L1_b${B}"
  if [ -e "$BASE" ] || [ -e "$TV" ] || [ -d "$ROT" ]; then echo "REFUSED: a record of that name exists ($BASE)"; exit 4; fi
  mkdir -p "$ROT"
  W2_LIST=1 W2_CMAX=0 OMP_NUM_THREADS=$THR "$EXE" "$B" 2 1 ordered fwd bent "$n" > "$BASE" 2>&1
  local NOUT; NOUT=$(grep -c '^W2-OUT' "$BASE")
  echo "rung n=$n beta=$B: $NOUT outside links; $(grep '^W2-CLASS a=1 c=0' "$BASE" | cut -c1-100) at $(date '+%H:%M:%S')"
  : > "$TV"; local i=0
  while [ "$i" -lt "$NOUT" ]; do
    W2_CMAX=0 W2_ROT="$i:$PI" OMP_NUM_THREADS=$THR "$EXE" "$B" 2 1 ordered fwd bent "$n" > "$ROT/rot_$i.txt" 2>&1
    gawk -v N=256 -f w2_tv.awk "$BASE" "$ROT/rot_$i.txt" >> "$TV"
    i=$((i + 1)); if [ $((i % 100)) -eq 0 ]; then echo "  $i of $NOUT at $(date '+%H:%M:%S')"; fi
  done
  echo "rung n=$n beta=$B done $(date '+%H:%M:%S'): $(grep -c '^W2-TV' "$TV") lines"
  gawk -v n="$n" -f w2_ladder.awk "$TV" | head -1; }
echo "start $(date '+%H:%M:%S %Z')"
for B in 1.5 3.0; do rung 2 "$B" ladder1; rung 4 "$B" ladder2; done
echo "end $(date '+%H:%M:%S %Z')"
