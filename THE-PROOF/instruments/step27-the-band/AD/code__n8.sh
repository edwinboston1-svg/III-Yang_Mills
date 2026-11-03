#!/bin/bash
# AD: the next scale a_c = 8a at beta = 2.2 (32^4; n = 4 beside it as the finite-size check of the 24^4 reading), then Villain beta_V = 2 at n = 8.
cd "$(dirname "$0")/.."
export OMP_NUM_THREADS=8
./code/ymc.exe su2 2.2 32 4,8 8801 200 4 150 rec/su2/su2_b2.2_N32 1 8 > rec/su2/su2_b2.2_N32.log 2>&1
./code/ymc.exe vil 2 32 4,8 8802 0 1 60 rec/vil/vil_b2_N32 1 8 > rec/vil/vil_b2_N32.log 2>&1
echo N8-DONE > rec/n8.done
