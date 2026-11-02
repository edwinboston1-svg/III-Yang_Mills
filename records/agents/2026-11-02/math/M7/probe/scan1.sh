#!/bin/bash
# the single centre-flip scan at one step (n = 2), planar, WMAX 2, LMAX 1, CMAX 0: every outside link flipped alone
cd "$(dirname "$0")"
for i in $(seq 0 175); do v=$(OMP_NUM_THREADS=4 W2_CMAX=0 W2_SET="$i:-1:0:0:0" ./w2_strip_n.exe 2.2 2 1 ordered fwd planar 2 | tr -d '\r' | grep 'W2-CLASS a=1 c=0' | awk '{print $7}'); echo "FLIP1 $i $v"; done
echo SCAN1-END
