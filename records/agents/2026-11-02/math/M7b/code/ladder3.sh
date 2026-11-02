#!/bin/bash
# M7b: THE beta = 3.0 LADDER RE-READ (the coordinator's 047_R/048_R question): one step n = 2, ordered datum, every outside link rotated by the
# angle A (W2_ROT, the record's instrument), the first moment against the base; the record's geometry (bent, W2_ALLOW_BENT) so that only the
# truncation varies: W2 truncated (the record), W4 truncated (positive at beta = 3), and EXACT staples with face cap 4 (every weight positive)
cd "$(dirname "$0")"; MODE=$1; A=$2; OUT=../rec/lad3_${MODE}_a${A}.txt; : > $OUT
case $MODE in w2) ENVV=""; W=2;; w4) ENVV=""; W=4;; x4) ENVV="W2_EXACT=1"; W=4;; esac
base=$(env W2_ALLOW_BENT=1 W2_CMAX=0 OMP_NUM_THREADS=6 $ENVV ./w2x.exe 3.0 $W 1 ordered fwd bent 2 | tr -d '\r' | grep "CLASS a=1 c=0" | sed 's/.*= //; s/ (imag.*//')
echo "BASE $MODE $base" >> $OUT
for k in $(seq 0 173); do v=$(env W2_ALLOW_BENT=1 W2_CMAX=0 OMP_NUM_THREADS=6 W2_ROT=$k:$A $ENVV ./w2x.exe 3.0 $W 1 ordered fwd bent 2 | tr -d '\r' | grep "CLASS a=1 c=0" | sed 's/.*= //; s/ (imag.*//'); echo "ROT $k $v" >> $OUT; done
gawk -v B=$base '/^ROT/ { n++; d = $3 - B; if (d > 0) up++ } END { printf "LADDER3 %s a=%s: base %.10f; %d of %d rotations RAISE the first moment\n", M, A, B, up, n }' M=$MODE A=$A $OUT >> $OUT
