#!/bin/bash
# t2: clamps and the weight filter against the unclamped sliced run (n = 2, W2L2, planar and bent, cancelling datum), every F entry compared
W="$(cd "$(dirname "$0")" && pwd)"; cd "$W" || exit 1
T="$W/../rec/t2"; mkdir -p "$T"
gcc -O2 -fopenmp -o w2m.exe w2m.c -lm || exit 1
export W2_SLICE=full W2_DUMPF=1
cmpF() { awk 'NR==FNR { if ($1=="W2-F") { k=$2" "$3" "$4" "$5" "$6" "$7; re[k]=$8; im[k]=$9; if ((t=($8<0?-$8:$8))>mx) mx=t } next }
  $1=="W2-F" { k=$2" "$3" "$4" "$5" "$6" "$7; d=$8-re[k]; if (d<0) d=-d; e=$9-im[k]; if (e<0) e=-e; if (d+e>dm) dm=d+e; n++ }
  END { printf "  %d entries, max |dF| relative to max|F| = %.3e\n", n, dm/mx }' "$1" "$2"; }
for geo in planar bent; do
  ./w2m.exe 2.2 2 2 cancel fwd $geo 2 > "$T/base_$geo.txt" 2>&1
  for cl in 0 4 0,5 1,4; do
    W2_CLAMP=$cl ./w2m.exe 2.2 2 2 cancel fwd $geo 2 > "$T/clamp_${geo}_$cl.txt" 2>&1
    echo "$geo CLAMP=$cl:"; cmpF "$T/base_$geo.txt" "$T/clamp_${geo}_$cl.txt"
  done
  W2_WEIGHT0=1 ./w2m.exe 2.2 2 2 cancel fwd $geo 2 > "$T/w0_$geo.txt" 2>&1; echo "$geo WEIGHT0:"; cmpF "$T/base_$geo.txt" "$T/w0_$geo.txt"
  W2_WEIGHT0=1 W2_CLAMP=0,5 ./w2m.exe 2.2 2 2 cancel fwd $geo 2 > "$T/w0c_$geo.txt" 2>&1; echo "$geo WEIGHT0+CLAMP 0,5:"; cmpF "$T/base_$geo.txt" "$T/w0c_$geo.txt"
done
echo "SIGHTED: WEIGHT0 at the random datum must FAIL (no U(1) invariance there)"
./w2m.exe 2.2 2 2 random:1 fwd planar 2 > "$T/base_rand.txt" 2>&1; W2_WEIGHT0=1 ./w2m.exe 2.2 2 2 random:1 fwd planar 2 > "$T/w0_rand.txt" 2>&1; cmpF "$T/base_rand.txt" "$T/w0_rand.txt"
echo T2-DONE
