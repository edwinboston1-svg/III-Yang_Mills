#!/bin/bash
# scan.sh MODE -- the TILT(alpha, 1) alignment scan of the two-step planar object at beta = 2.2
#   MODE=a : W3L1 CMAX=0 (a'_1/2 = E[chi_1/2(A)]/2), sliced
#   MODE=w : W2L2 CMAX=1 (the pair: (1/2,1/2) class moment and marginals)
MIR=/c/Users/EDWINB~1/AppData/Local/Temp/the author/C--Users-Edwin-Boston-OneDrive-Desktop-III/59ca2c52-22a2-4ac6-93d9-5dadb2bb3bcb/scratchpad/math/MIR
cd "$MIR/code" || exit 1; export OMP_NUM_THREADS=8
for A in 0.000 0.050 0.100 0.150 0.200 0.300 0.400 0.600 0.800 1.5707963267948966; do
  D="$MIR/rec/datum_a$A.txt"; [ -f "$D" ] || gawk -v N=536 -v ALPHA=$A -v S=1 -f tilt_datum.awk > "$D"
  if [ "$1" = a ]; then OUT="$MIR/rec/tilt_W3L1C0_a$A.txt"; [ -s "$OUT" ] && grep -q W2-DONE "$OUT" && continue
    W2_DATUM="$D" W2_SLICE=full W2_CMAX=0 ./w2_strip_n.exe 2.2 3 1 ordered fwd planar 4 > "$OUT" 2>&1
  else OUT="$MIR/rec/tilt_W2L2C1_a$A.txt"; [ -s "$OUT" ] && grep -q W2-DONE "$OUT" && continue
    W2_DATUM="$D" W2_CMAX=1 ./w2_strip_n.exe 2.2 2 2 ordered fwd planar 4 > "$OUT" 2>&1; fi
done
echo "SCAN-$1-END $(date)"
