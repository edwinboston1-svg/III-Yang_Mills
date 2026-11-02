#!/bin/bash
# ENV1: the right neighbour of A (chain rightA) on frame (0,0,0,1), n = 4 (two steps), planar, W2L1, chain cap LN2, both data; truncated and exact staples.
W="$(cd "$(dirname "$0")" && pwd)"; cd "$W" || exit 1; R="$W/../rec/env"; mkdir -p "$R"
export OMP_NUM_THREADS=4 W2_SLICE=full W2_LEAN=1 W2_NOSNAP=1 W2_WEIGHT0=1 W2_FRAME=0,0,0,1 W2_CHAIN=rightA W2_LN=2
for st in trunc exact; do for d in ordered cancel; do
  if [ $st = exact ]; then export W2_EXACT=1 W2_DEGX=44; else unset W2_EXACT W2_DEGX; fi
  echo "== env1 $st $d start $(date '+%H:%M:%S')"; ./w2c.exe 2.2 2 1 $d fwd planar 4 > "$R/env1_rightA_f0001_n4_W2L1_LN2_${st}_$d.txt" 2>&1; echo "   rc=$? end $(date '+%H:%M:%S') $(grep -E 'W2-M2c|W2-DONE' "$R/env1_rightA_f0001_n4_W2L1_LN2_${st}_$d.txt" | tr '\n' ' ')"
done; done; echo ENV1-DONE
