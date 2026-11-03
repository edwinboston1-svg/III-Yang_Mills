#!/bin/bash
# R2: THE WHOLE FOUR-SIDED FIRST RING at n = 4, planar, W2L1, EXACT staples (M7b's door; coordinator 11:0x, reader 050_R): the cycles (faces and ring) at W2 (positive at 2.2: min +0.0710).
W="$(cd "$(dirname "$0")" && pwd)"; cd "$W" || exit 1; R="$W/../rec/r2"; mkdir -p "$R"
export OMP_NUM_THREADS=8 W2_SLICE=full W2_LEAN=1 W2_NOSNAP=1 W2_WEIGHT0=1 W2_DUMPF=1 W2_EXACT=1 W2_DEGX=44
for d in ordered cancel; do
  for fr in 0,0,0,0 1,1,1,1; do tag=ring${fr//,/}_n4_W2L1_exact_$d
    echo "== r2 $tag start $(date '+%H:%M:%S')"; W2_FRAME=$fr ./w2s.exe 2.2 2 1 $d fwd planar 4 > "$R/$tag.txt" 2>&1
    echo "   rc=$? end $(date '+%H:%M:%S') $(grep -E 'M2b peak|W2-DONE' "$R/$tag.txt" | tr '\n' ' ')"
    ./l2dob.exe "$R/$tag.txt" 30 20 12 > "$R/$tag.l2.txt" 2>&1; grep -E 'RESULT|CENSUS' "$R/$tag.l2.txt"; done
done; echo R2-DONE $(date '+%H:%M:%S')
