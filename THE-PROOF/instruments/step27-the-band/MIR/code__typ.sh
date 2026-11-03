#!/bin/bash
# typ.sh -- the two-step planar object at the three heat-bath data (beta = 2.2): W2L2 CMAX=1 (positive truncation, the pair) and W4L1 CMAX=0
# (positive truncation, spins <= 2, the one-plaquette coefficient), each exact at its datum
MIR=/c/Users/EDWINB~1/AppData/Local/Temp/the author/C--Users-Edwin-Boston-OneDrive-Desktop-III/59ca2c52-22a2-4ac6-93d9-5dadb2bb3bcb/scratchpad/math/MIR
cd "$MIR/code" || exit 1; export OMP_NUM_THREADS=8
for k in 0 1 2; do D="$MIR/rec/hbdatum_$k.txt"
  W2_DATUM="$D" W2_CMAX=1 ./w2_strip_n.exe 2.2 2 2 ordered fwd planar 4 > "$MIR/rec/typ_W2L2C1_hb$k.txt" 2>&1; done
echo "TYP-W2-END $(date)"
for k in 0 1 2; do D="$MIR/rec/hbdatum_$k.txt"
  W2_DATUM="$D" W2_SLICE=full W2_CMAX=0 ./w2_strip_n.exe 2.2 4 1 ordered fwd planar 4 > "$MIR/rec/typ_W4L1C0_hb$k.txt" 2>&1; done
echo "TYP-W4-END $(date)"
