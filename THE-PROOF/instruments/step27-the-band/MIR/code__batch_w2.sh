#!/bin/bash
# batch_w2.sh -- the full W2L2 table (a, c <= 2) of the planar two-step object at every heat-bath datum, four developments of 6 threads
MIR=/c/Users/EDWINB~1/AppData/Local/Temp/the author/C--Users-Edwin-Boston-OneDrive-Desktop-III/59ca2c52-22a2-4ac6-93d9-5dadb2bb3bcb/scratchpad/math/MIR
cd "$MIR/code" || exit 1; export OMP_NUM_THREADS=6
development() { for D in "$@"; do b=$(basename "$D" .txt); OUT="$MIR/rec/full_W2L2_$b.txt"; [ -s "$OUT" ] && grep -q W2-DONE "$OUT" && continue
  W2_DATUM="$D" ./w2_strip_n.exe 2.2 2 2 ordered fwd planar 4 > "$OUT" 2>&1; done; }
ALL=( "$MIR"/rec/hbdatum_*.txt "$MIR"/rec/hbd_s*_*.txt ); N=${#ALL[@]}
L0=(); L1=(); L2=(); L3=(); for ((i = 0; i < N; i++)); do case $((i % 4)) in 0) L0+=("${ALL[$i]}");; 1) L1+=("${ALL[$i]}");; 2) L2+=("${ALL[$i]}");; 3) L3+=("${ALL[$i]}");; esac; done
development "${L0[@]}" & development "${L1[@]}" & development "${L2[@]}" & development "${L3[@]}" & wait
echo "BATCH-W2-END $N data $(date)"
