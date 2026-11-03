#!/bin/bash
# M8b: launch the convexity runs (one process per weight; BLAS pinned to one thread each); records in rec/weights_<tag>.2026-11-02a.txt
cd "$(dirname "$0")/.." || exit 1
export OMP_NUM_THREADS=1 OPENBLAS_NUM_THREADS=1 MKL_NUM_THREADS=1
BL="0.3,0.5,0.6,0.7,0.8,0.9,1.0,1.1"
BW="0.3,0.4,0.5,0.6,0.7"
run() { tag=$1; shift; python -u -E -P bin/m8b_weights.py "$@" > rec/weights_${tag}.2026-11-02a.txt 2>&1; echo "$tag rc=$?" >> rec/weights_launch.2026-11-02a.log; }
: > rec/weights_launch.2026-11-02a.log
run W     wilson 5   0 repro,rays,adv "0.55,0.6,0.65" &
run M     manton 5   0 rays,adv "$BL" &
run H2.5  hk     2.5 0 rays,adv "$BL" &
run H5    hk     5   0 rays,adv "$BL" &
run H10   hk     10  0 rays,adv "$BL" &
run H20   hk     20  0 rays,adv "$BL" &
run H2.5h hk     2.5 1 rays,adv "$BL" &
run H5h   hk     5   1 rays,adv "$BL" &
run W2.5h wilson 2.5 1 rays,adv "$BW" &
run W5h   wilson 5   1 rays,adv "$BW" &
wait
echo "all done" >> rec/weights_launch.2026-11-02a.log
