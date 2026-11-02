#!/bin/bash
cd "$(dirname "$0")"
date; OMP_NUM_THREADS=12 W2_CMAX=0 ./w2_strip_n.exe 2.2 4 1 ordered fwd planar 4 | tr -d '\r' > w4_n4_ordered_L1C0.2026-11-02a.txt; echo "rc=$?"; date
