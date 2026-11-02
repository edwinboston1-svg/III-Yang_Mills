#!/bin/bash
# M4's channel reader over the record's PLANAR-GEOMETRY cells (planar dumps; bent dumps at the ordered and cancelling data,
# which equal the planar object exactly; no bent random cell). Output: rec/chan_<cell>.txt, one file per cell.
D="$(cd "$(dirname "$0")" && pwd)"
T="/c/Users/Edwin Boston/OneDrive/Desktop/III/STDLIB/build/aperanton/surface-gas"
X="$D/m4chan.exe"
mkdir -p "$D/rec"
for f in dob_n2_W2L2_free dob_n2_W2L2_planar_ordered dob_n2_W2L2_planar_cancel dob_n2_W2L2_planar_random1 \
         dob_n2_W3L2_ordered dob_n2_W3L2_cancel dob_n2_W3L4_ordered dob_n2_W3L4_cancel \
         dob_n4_W2L2_planar_ordered dob_n4_W2L2_planar_cancel dob_n4_W2L2_planar_random1 \
         dob_n4_W3L2_cancel dob_n4_W2L4_ordered dob_n4_W2L4_cancel; do
  "$X" SU2 "$T/$f.txt" 30 16 > "$D/rec/chan_$f.txt" 2>&1
done
"$X" SCHUR "$T/w2n4_W3L2.2026-11-01b.ordered.txt" 30 16 > "$D/rec/chan_n4_W3L2_ordered_schur.txt" 2>&1
for f in u1_n2_b1.2_N6_L4_free u1_n2_b1.2_N6_L6_ordered u1_n2_b1.2_N6_L6_cancel u1_n4_b1.2_N6_L6_ordered u1_n4_b1.2_N6_L6_cancel \
         u1_n2_b0.9_N6_L6_ordered u1_n2_b0.9_N6_L6_cancel u1_n4_b0.9_N6_L6_ordered u1_n4_b0.9_N6_L6_cancel; do
  "$X" U1 "$T/dob_u1/$f.txt" 2048 256 > "$D/rec/chan_$f.txt" 2>&1
done
# convergence of the quadrature on two cells
"$X" SU2 "$T/dob_n2_W3L2_ordered.txt" 40 20 > "$D/rec/chan_dob_n2_W3L2_ordered_G40T20.txt" 2>&1
"$X" SU2 "$T/dob_n4_W2L2_planar_ordered.txt" 40 20 > "$D/rec/chan_dob_n4_W2L2_planar_ordered_G40T20.txt" 2>&1
echo done
