#!/bin/bash
# AD teeth, one after another, the same engine as the SU(2) reading: T1 Villain at beta_V = 2, 4, 8; T0 SU(2) at 0.2452 and 0.2.
cd "$(dirname "$0")/.."
export OMP_NUM_THREADS=8
for bv in 2 4 8; do
  ./code/ymc.exe vil $bv 24 1,2,4 $((300 + bv)) 0 1 100 rec/vil/vil_b${bv}_N24 8 4 > rec/vil/vil_b${bv}_N24.log 2>&1
done
for b in 0.2452 0.2; do
  ./code/ymc.exe su2 $b 24 1,2,4 4401 100 3 100 rec/su2/su2_b${b}_N24 8 4 > rec/su2/su2_b${b}_N24.log 2>&1
done
echo TEETH-DONE > rec/teeth.done
