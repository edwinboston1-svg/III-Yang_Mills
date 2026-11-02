#!/bin/bash
# M7b: the two-step object with EXACT staples: (Q2) the class table a, c <= 1 (L2 C2) at face cap 3, diagonal slices (class moments only),
# both data; (Q3) A's marginals to spin 1 (L2 C0) at face cap 4, diagonal slices, both data
cd "$(dirname "$0")"
for DAT in ordered cancel; do
  OUT=../rec/x_n4_${DAT}_Wf3_L2C2diag.2026-11-02a.txt; echo "start Q2 $DAT $(date)" >> ../rec/twostep2.log
  env OMP_NUM_THREADS=12 W2_SLICE=diag W2_EXACT=1 ./w2x.exe 2.2 3 2 $DAT fwd planar 4 2>&1 | tr -d '\r' > $OUT
  echo "end Q2 $DAT rc=$? $(date)" >> ../rec/twostep2.log
done
for DAT in ordered cancel; do
  OUT=../rec/x_n4_${DAT}_Wf4_L2C0diag.2026-11-02a.txt; echo "start Q3 $DAT $(date)" >> ../rec/twostep2.log
  env OMP_NUM_THREADS=12 W2_SLICE=diag W2_CMAX=0 W2_EXACT=1 ./w2x.exe 2.2 4 2 $DAT fwd planar 4 2>&1 | tr -d '\r' > $OUT
  echo "end Q3 $DAT rc=$? $(date)" >> ../rec/twostep2.log
done
echo "TWOSTEP2 DONE $(date)" >> ../rec/twostep2.log
