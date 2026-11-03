#!/bin/bash
# M8b: the DHZ adversarial runs (one process per b) and the L = 3 Manton / heat-kernel runs; absolute directory, BLAS 2 threads each
cd "$(dirname "$0")/.." || exit 1
export OMP_NUM_THREADS=2 OPENBLAS_NUM_THREADS=2 MKL_NUM_THREADS=2
: > rec/dhz_launch.log
for b in 0.4 0.5 0.6 0.7; do
  ( python -u -E -P bin/m8b_dhz.py dhz 5 0 adv "$b" > "rec/dhz_adv_${b}.2026-11-02a.txt" 2>&1; echo "adv $b rc=$?" >> rec/dhz_launch.log ) &
done
: > rec/weights3_launch.log
( python -u -E -P bin/m8b_weights3.py manton 5 0 rays,adv "0.4,0.5" > rec/weights3_M.2026-11-02a.txt 2>&1; echo "M3 rc=$?" >> rec/weights3_launch.log ) &
( python -u -E -P bin/m8b_weights3.py hk 2.5 1 rays > rec/weights3_H2.5h.2026-11-02a.txt 2>&1; echo "H3 rc=$?" >> rec/weights3_launch.log ) &
wait
echo "all done" >> rec/dhz_launch.log
