#!/bin/bash
# w3l2_diag.sh -- THE REFUSED OBJECT'S CLASS MOMENTS UNDER THE DIAGONAL SLICE MODE: W3L2 two-step at §10's three data with W2_SLICE=diag
# (d_a d_c diagonal slices, each 1/(d_a^2 d_c^2) the state; the class moments exact, the channels refused by name), records
# w2n4_W3L2.2026-11-01c.<datum>.txt -- the §12 stakes S1-S3 read from these; S4 (the peak under full) and the channels from the full
# run's record b when it lands.  8 threads.  A frozen copy, never edited while it runs.
set -u
cd "/c/Users/Edwin Boston/OneDrive/Desktop/III/STDLIB/build/aperanton/surface-gas" || exit 2
echo "start $(date '+%H:%M:%S %Z')"
for d in ordered cancel random:1; do tag=${d/:/}; out="w2n4_W3L2.2026-11-01c.$tag.txt"
  if [ -e "$out" ]; then echo "REFUSED: $out exists"; exit 4; fi
  t0=$(date +%s); W2_SLICE=diag OMP_NUM_THREADS=8 ./w2_strip_s.exe 2.2 3 2 $d fwd bent 4 > "$out" 2>&1
  echo "W3L2 diag $d: $(( $(date +%s) - t0 )) s; $(grep -c '^W2-CLASS' "$out") classes; $(grep 'REFUSED\|out of memory' "$out" | head -1)"
  grep '^W2-CLASS a=2 c=2' "$out" | cut -c1-160
done
echo "end $(date '+%H:%M:%S %Z')"
