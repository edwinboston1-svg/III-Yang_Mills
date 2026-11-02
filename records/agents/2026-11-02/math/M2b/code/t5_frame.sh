#!/bin/bash
# t5: the integrated ring. (F0) W2_FRAME=0,0,0,0 must reproduce the engine (the generic order equals the engine's link for link); (G) gauge covariance
# at a frame vertex and at a core vertex, framed and unframed, random datum: every F entry unchanged; the HALF transform (sighted) must move them;
# (F1) the framed object's census (links, staples, peak) printed; (D) dry staging of the framed cells.
W="$(cd "$(dirname "$0")" && pwd)"; cd "$W" || exit 1
T="$W/../rec/t5"; mkdir -p "$T"; export OMP_NUM_THREADS=8
gcc -O2 -fopenmp -o w2f.exe w2f.c -lm 2>&1 | grep -iE " error" ; [ -x w2f.exe ] || exit 1
strip() { sed -E 's/[0-9]+\.[0-9] s/T s/g' "$1" | grep -v "^W2-FRAME"; }
cmpF() { awk 'NR==FNR { if ($1=="W2-F") { k=$2" "$3" "$4" "$5" "$6" "$7; re[k]=$8; im[k]=$9; if ((t=($8<0?-$8:$8))>mx) mx=t } next }
  $1=="W2-F" { k=$2" "$3" "$4" "$5" "$6" "$7; d=$8-re[k]; if (d<0) d=-d; e=$9-im[k]; if (e<0) e=-e; if (d+e>dm) dm=d+e; n++ }
  END { printf "  %d entries, max |dF| relative to max|F| = %.3e\n", n, dm/mx }' "$1" "$2"; }
echo "F0: frame 0,0,0,0 against no frame (n = 2, W2L2 planar cancel, unsliced and sliced)"
for s in "" full; do if [ -n "$s" ]; then export W2_SLICE=$s; else unset W2_SLICE; fi
  W2_DUMPF=1 ./w2f.exe 2.2 2 2 cancel fwd planar 2 > "$T/nf.txt" 2>&1; W2_DUMPF=1 W2_FRAME=0,0,0,0 ./w2f.exe 2.2 2 2 cancel fwd planar 2 > "$T/f0.txt" 2>&1
  if cmp -s <(strip "$T/nf.txt") <(strip "$T/f0.txt"); then echo "  IDENTICAL (slice=${s:-none})"; else echo "  DIFFER (slice=${s:-none})"; diff <(strip "$T/nf.txt") <(strip "$T/f0.txt") | head -4; fi; done; unset W2_SLICE
echo "F1: the framed census (n = 2, frame 1,1,0,0 and 1,1,1,1)"
for fr in 1,1,0,0 1,1,1,1; do W2_FRAME=$fr W2_DRY=1 W2_SLICE=full ./w2f.exe 2.2 2 2 cancel fwd planar 2 2>&1 | grep -E "W2-OBJECT|W2-DRY-TOTAL"; done
export W2_DUMPF=1
echo "G: gauge covariance, random datum, n = 2 W2L2, at the core vertex (1,0,0,0) and the frame vertex (1,3,0,0) with frame 1,1,0,0"
for fr in none 1,1,0,0; do for v in 1,0,0,0 1,3,0,0 -1,-1,0,0; do
  if [ $fr = none ]; then case $v in 1,0,0,0) ;; *) continue;; esac; unset W2_FRAME; else export W2_FRAME=$fr; fi
  ./w2f.exe 2.2 2 2 random:3 fwd planar 2 > "$T/g0.txt" 2>&1
  W2_GAUGE="$v,0:0.3,0.5,-0.7,0.4" ./w2f.exe 2.2 2 2 random:3 fwd planar 2 > "$T/g1.txt" 2>&1
  W2_GAUGE="$v,0:0.3,0.5,-0.7,0.4:half" ./w2f.exe 2.2 2 2 random:3 fwd planar 2 > "$T/g2.txt" 2>&1
  echo " frame=$fr vertex=$v: $(grep W2-GAUGE "$T/g1.txt" | sed 's/.*: //')"; cmpF "$T/g0.txt" "$T/g1.txt"; echo "  HALF (sighted, must move):"; cmpF "$T/g0.txt" "$T/g2.txt"
done; done; unset W2_FRAME W2_DUMPF
echo "D: dry staging"
for cell in "2 2 2 1,1,0,0" "2 3 2 1,1,0,0" "4 2 2 1,0,0,0" "4 2 2 1,1,0,0" "4 2 1 1,1,0,0"; do set -- $cell; echo " n=$1 W$2 L$3 frame $4:"; W2_FRAME=$4 W2_DRY=1 W2_SLICE=full W2_LEAN=1 W2_NOSNAP=1 W2_WEIGHT0=1 ./w2f.exe 2.2 $2 $3 cancel fwd planar $1 2>&1 | grep -E "W2-DRY-TOTAL"; done
echo T5-DONE
