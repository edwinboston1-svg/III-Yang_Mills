#!/bin/bash
# run_w4: the two-step planar object at plaquette spins to 2 (W4) and loop representations to spin 1/2 (L1), beta = 2.2, the cancelling and
# the ordered data, under the weight filter, the lean order and no snapshot (each tested exact in t2/t3); first the W3L1 ordered cell for the
# matched L1 ladder. Every dump read by M2's reader l2dob (road A, road B, sigma_H, the TV ascent). Stakes: WORK.md section 2, written first.
W="$(cd "$(dirname "$0")" && pwd)"; cd "$W" || exit 1
R="$W/../rec/w4"; mkdir -p "$R"
export OMP_NUM_THREADS=16 W2_SLICE=full W2_LEAN=1 W2_NOSNAP=1 W2_WEIGHT0=1 W2_DUMPF=1
run() { local tag=$1; shift; echo "== $tag start $(date '+%Y-%m-%d %H:%M:%S')"; ./w2m.exe "$@" > "$R/$tag.txt" 2>&1; echo "   rc=$? end $(date '+%H:%M:%S')"; grep -E "W2-CLASS|M2b peak|W2-DONE" "$R/$tag.txt";
  ./l2dob.exe "$R/$tag.txt" 30 20 12 > "$R/$tag.l2.txt" 2>&1; grep -E "L2DOB-RESULT|REFUS|SIGNED" "$R/$tag.l2.txt"; }
run dob_n4_W3L1_planar_ordered 2.2 3 1 ordered fwd planar 4
run dob_n4_W4L1_planar_cancel 2.2 4 1 cancel fwd planar 4
run dob_n4_W4L1_planar_ordered 2.2 4 1 ordered fwd planar 4
echo RUN-W4-DONE $(date '+%H:%M:%S')
