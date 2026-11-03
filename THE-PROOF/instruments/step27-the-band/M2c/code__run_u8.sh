#!/bin/bash
W="$(cd "$(dirname "$0")" && pwd)"; cd "$W" || exit 1; R="$W/../rec/u1"; export OMP_NUM_THREADS=8
for d in ordered cancel; do echo "== u8 n8 N3L2 $d start $(date '+%H:%M:%S')"; ./w2u8.exe 1.2 3 2 $d planar 8 > "$R/u1_n8_N3L2_$d.txt" 2>&1; echo "   rc=$? end $(date '+%H:%M:%S')"; ./l2dob.exe "$R/u1_n8_N3L2_$d.txt" > "$R/u1_n8_N3L2_$d.l2.txt" 2>&1; grep -E 'L2DOB-U1' "$R/u1_n8_N3L2_$d.l2.txt"; done; echo U8-DONE
