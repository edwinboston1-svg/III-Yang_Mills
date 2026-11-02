#!/bin/bash
# M7b engine KATs (stakes in WORK.md §2a); one step n = 2 planar, CMAX 0
cd "$(dirname "$0")"; R=../rec/kat1.2026-11-02a.txt; : > $R
run() { echo "### $*" >> $R; env OMP_NUM_THREADS=8 W2_CMAX=0 "$@" | tr -d '\r' | grep -E "COEFM|EXACT|OBJECT|CLASS a=1|KAT FREE|DONE" >> $R; }
for W in 2 3; do C=$(gawk -v B=2.2 -v K=$W -f besselco.awk); run ./w2x.exe 2.2 $W 1 ordered fwd planar 2; run env W2_COEF=$C ./w2x.exe 2.2 $W 1 ordered fwd planar 2; done
run env W2_EXACT=1 ./w2x.exe 2.2 3 1 free fwd planar 2
for DX in 40 50 60; do run env W2_EXACT=1 W2_DEGX=$DX ./w2x.exe 2.2 4 1 ordered fwd planar 2; done
for W in 2 3 4 5 6; do for DAT in ordered cancel; do run ./w2x.exe 2.2 $W 1 $DAT fwd planar 2; run env W2_EXACT=1 ./w2x.exe 2.2 $W 1 $DAT fwd planar 2; done; done
echo "KAT1 DONE $(date)" >> $R
