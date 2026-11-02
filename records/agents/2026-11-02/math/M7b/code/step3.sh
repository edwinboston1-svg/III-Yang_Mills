#!/bin/bash
# M7b: THE THIRD STEP (n = 2) and THE FOURTH (n = 4) as the exact map on the two-step one-plaquette action (W2_COEF; the face cap 2 makes the
# finite input series exact on faces and staples alike); coarse data ordered, cancel, random:1, random:2; L2 C2 (the class table to spin 1)
cd "$(dirname "$0")"; TAG=$1; CO=$2; N=$3; W=${4:-2}
for DAT in ordered cancel random:1 random:2; do
  OUT=../rec/s3_${TAG}_n${N}_${DAT/:/}.2026-11-02a.txt
  env OMP_NUM_THREADS=${OMPN:-4} W2_COEF=$CO ./w2x.exe 1 $W 2 $DAT fwd planar $N 2>&1 | tr -d '\r' > $OUT
  echo "$TAG n=$N $DAT: $(grep -E 'CLASS a=1 c=0|CLASS a=2 c=0' $OUT | sed 's/.*= //; s/ (imag.*//' | tr '\n' ' ')"
done
