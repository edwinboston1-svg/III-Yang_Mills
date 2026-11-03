#!/bin/bash
# R1: THE WHOLE FOUR-SIDED FIRST RING at n = 4 (two steps), planar, W2L1, TRUNCATED staples (byte-comparable to M2b), ordered then cancelling.
# Stakes SR1-SR4: WORK.md section 1, written before this run.
W="$(cd "$(dirname "$0")" && pwd)"; cd "$W" || exit 1
R="$W/../rec/r1"; mkdir -p "$R"
export OMP_NUM_THREADS=8 W2_SLICE=full W2_LEAN=1 W2_NOSNAP=1 W2_WEIGHT0=1 W2_DUMPF=1
for d in ordered cancel; do
  echo "== r1 ring1111 n4 W2L1 trunc $d start $(date '+%H:%M:%S')"
  W2_FRAME=1,1,1,1 ./w2s.exe 2.2 2 1 $d fwd planar 4 > "$R/ring1111_n4_W2L1_trunc_$d.txt" 2>&1
  echo "   rc=$? end $(date '+%H:%M:%S') $(grep -E 'M2b peak|W2-DONE' "$R/ring1111_n4_W2L1_trunc_$d.txt" | tr '\n' ' ')"
  ./l2dob.exe "$R/ring1111_n4_W2L1_trunc_$d.txt" 30 20 12 > "$R/ring1111_n4_W2L1_trunc_$d.l2.txt" 2>&1
  grep -E 'RESULT|CENSUS' "$R/ring1111_n4_W2L1_trunc_$d.l2.txt"
done
echo R1-DONE $(date '+%H:%M:%S')
