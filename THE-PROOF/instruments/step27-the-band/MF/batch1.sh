#!/bin/bash
# batch1.sh -- the Gaussian fibre's rate for every map, d = 2, 3, 4, L = 2..16 (road A at K_perp = 0, dir 0 and dir d-1; road B both lines, K_perp = 0)
# output: one line per (d, L, map, dir): A rate (median of logratio over D in [Dlo, Dhi]) and B kappa on each line
cd "$(dirname "$0")"
OUT=rec/batch1.2026-11-02a.txt
: > $OUT
for d in 2 3 4; do
  case $d in 2) LS="2 4 8 16 32";; 3) LS="2 4 8 16";; 4) LS="2 4 8 16";; esac
  for L in $LS; do
    MAPS="dec heat:0.125"; for k in $(seq 1 $d); do MAPS="$MAPS box$k"; done
    for map in $MAPS; do
      for dir in 0 $((d-1)); do
        A=$(./gfib.exe $d $L $map A 512 $((L/2)) $dir 2>/dev/null | gawk -f rateA.awk)
        B0=$(./gfib.exe $d $L $map B $dir 1 0 2>/dev/null | grep "^B" | sed 's/.*kappa(Kperp=0)=\([^ ]*\).*/\1/')
        B1=$(./gfib.exe $d $L $map B $dir 1 1 2>/dev/null | grep "^B" | sed 's/.*kappa(Kperp=0)=\([^ ]*\).*/\1/')
        echo "RATE d=$d L=$L map=$map dir=$dir roadA_kernel=$A roadB_ReK0=$B0 roadB_ReKpi=$B1" | tee -a $OUT
      done
    done
  done
done
