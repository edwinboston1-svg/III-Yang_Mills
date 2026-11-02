#!/bin/bash
# KAT C1: the chain's end vertex (3,2) of rightA at n = 2, frame (1,1,1,1), W2L1 LN1, Haar-random datum seed 3, all slices.
W="$(cd "$(dirname "$0")" && pwd)"; cd "$W" || exit 1; R="$W/../rec/kat"
export OMP_NUM_THREADS=4 W2_SLICE=full W2_LEAN=1 W2_NOSNAP=1 W2_DUMPF=1 W2_FRAME=1,1,1,1 W2_CHAIN=rightA W2_LN=1
./w2c.exe 2.2 2 1 random:3 fwd planar 2 > "$R/c1_base.txt" 2>&1; echo base rc=$?
W2_GAUGE=3,2,0,0:0.3,0.5,-0.7,0.4 ./w2c.exe 2.2 2 1 random:3 fwd planar 2 > "$R/c1_gauge_end.txt" 2>&1; echo end rc=$?
W2_GAUGE=3,0,0,0:0.3,0.5,-0.7,0.4 ./w2c.exe 2.2 2 1 random:3 fwd planar 2 > "$R/c1_gauge_start.txt" 2>&1; echo start rc=$?
W2_GAUGE=3,2,0,0:0.3,0.5,-0.7,0.4:half ./w2c.exe 2.2 2 1 random:3 fwd planar 2 > "$R/c1_gauge_half.txt" 2>&1; echo half rc=$?
echo KC1-DONE
