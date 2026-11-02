#!/bin/bash
# M7b: the two-step object with EXACT staples, A's marginal (L1 C0), face caps 3 and 4, both data
cd "$(dirname "$0")"
for W in 3 4; do for DAT in ordered cancel; do
  OUT=../rec/x_n4_${DAT}_Wf${W}_L1C0.2026-11-02a.txt
  echo "start $DAT W$W $(date)" >> ../rec/twostep1.log
  env OMP_NUM_THREADS=12 W2_CMAX=0 W2_EXACT=1 ./w2x.exe 2.2 $W 1 $DAT fwd planar 4 2>&1 | tr -d '\r' > $OUT
  echo "end $DAT W$W rc=$? $(date)" >> ../rec/twostep1.log
done; done
echo "TWOSTEP1 DONE $(date)" >> ../rec/twostep1.log
