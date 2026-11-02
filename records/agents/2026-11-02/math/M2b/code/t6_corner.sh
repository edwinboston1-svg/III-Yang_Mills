#!/bin/bash
# t6: THE TRUE BENT PAIR. (C0) W2_CORNER unset: w2f equals the engine; at the free datum the corners are off (byte-identical below the banner).
# (C1) THE DISCRIMINATING KAT: gauge covariance at the corner vertex (0,1,1,0) (where O2 = (0,1,1) dir 1 starts and B's link (0,1,0) dir 3 ends),
# random datum, n = 2, W2L2 -- the engine (corner entered twice as staples, the other object link read from the datum) must FAIL, the corner
# engine must PASS; the half transform must move both. (C2) the zipper order against the engine's order, both with corners: equal to roundoff.
W="$(cd "$(dirname "$0")" && pwd)"; cd "$W" || exit 1
T="$W/../rec/t6"; mkdir -p "$T"; export OMP_NUM_THREADS=8
rm -f w2c.exe; gcc -O2 -fopenmp -o w2c.exe w2f.c -lm 2>&1 | grep -iE " error"; [ -x w2c.exe ] || { echo BUILD-FAILED; exit 1; }
strip() { sed -E 's/[0-9]+\.[0-9] s/T s/g' "$1" | grep -v "^W2-CORNER"; }
cmpF() { awk 'NR==FNR { if ($1=="W2-F") { k=$2" "$3" "$4" "$5" "$6" "$7; re[k]=$8; im[k]=$9; if ((t=($8<0?-$8:$8))>mx) mx=t } next }
  $1=="W2-F" { k=$2" "$3" "$4" "$5" "$6" "$7; d=$8-re[k]; if (d<0) d=-d; e=$9-im[k]; if (e<0) e=-e; if (d+e>dm) dm=d+e; n++ }
  END { printf "  %d entries, max |dF| relative to max|F| = %.3e\n", n, dm/mx }' "$1" "$2"; }
echo "C0: unset against the engine; the free datum with corners against without"
W2_DUMPF=1 ./w2_orig.exe 2.2 2 2 random:3 fwd bent 2 > "$T/o.txt" 2>&1; W2_DUMPF=1 ./w2c.exe 2.2 2 2 random:3 fwd bent 2 > "$T/f.txt" 2>&1
cmp -s <(strip "$T/o.txt") <(strip "$T/f.txt") && echo "  IDENTICAL (unset)" || echo "  DIFFER (unset)"
W2_DUMPF=1 ./w2c.exe 2.2 2 2 free fwd bent 2 > "$T/fr0.txt" 2>&1; W2_DUMPF=1 W2_CORNER=1 ./w2c.exe 2.2 2 2 free fwd bent 2 > "$T/fr1.txt" 2>&1
cmp -s <(strip "$T/fr0.txt") <(strip "$T/fr1.txt") && echo "  IDENTICAL (free, corners off)" || echo "  DIFFER (free)"
export W2_DUMPF=1
echo "C1: gauge at the corner vertex (0,1,1,0), random datum"
for eng in engine corner; do if [ $eng = corner ]; then export W2_CORNER=1; else unset W2_CORNER; fi
  ./w2c.exe 2.2 2 2 random:3 fwd bent 2 > "$T/g0.txt" 2>&1
  W2_GAUGE="0,1,1,0:0.3,0.5,-0.7,0.4" ./w2c.exe 2.2 2 2 random:3 fwd bent 2 > "$T/g1.txt" 2>&1
  W2_GAUGE="0,1,1,0:0.3,0.5,-0.7,0.4:half" ./w2c.exe 2.2 2 2 random:3 fwd bent 2 > "$T/g2.txt" 2>&1
  echo " $eng: $(grep W2-GAUGE "$T/g1.txt" | sed 's/.*: //')"; cmpF "$T/g0.txt" "$T/g1.txt"; echo "  half (sighted):"; cmpF "$T/g0.txt" "$T/g2.txt"; done
unset W2_CORNER
echo "C2: zipper against the engine's order, both with corners (random and cancelling data)"
for dat in random:3 cancel ordered; do W2_CORNER=1 ./w2c.exe 2.2 2 2 $dat fwd bent 2 > "$T/z.txt" 2>&1; W2_CORNER=orig ./w2c.exe 2.2 2 2 $dat fwd bent 2 > "$T/e.txt" 2>&1; echo " $dat:"; cmpF "$T/e.txt" "$T/z.txt"; done
echo "C3: the corners move the bent object off the planar one at the named data (n = 2, W2L2): class moments"
for dat in ordered cancel; do echo " $dat: planar $(./w2c.exe 2.2 2 2 $dat fwd planar 2 2>&1 | grep 'a=1 c=1 E' | sed -E 's/.*= ([+0-9.e-]+) .*/\1/')  bent-engine $(./w2c.exe 2.2 2 2 $dat fwd bent 2 2>&1 | grep 'a=1 c=1 E' | sed -E 's/.*= ([+0-9.e-]+) .*/\1/')  bent-corner $(W2_CORNER=1 ./w2c.exe 2.2 2 2 $dat fwd bent 2 2>&1 | grep 'a=1 c=1 E' | sed -E 's/.*= ([+0-9.e-]+) .*/\1/')"; done
unset W2_DUMPF W2_CORNER
echo "D: staging the corner objects"
for cell in "2 3 2" "2 4 2" "4 2 2" "4 3 1" "4 3 2"; do set -- $cell; echo " n=$1 W$2 L$3: $(W2_CORNER=1 W2_DRY=1 W2_SLICE=full W2_LEAN=1 W2_NOSNAP=1 W2_WEIGHT0=1 ./w2c.exe 2.2 $2 $3 cancel fwd bent $1 2>&1 | grep W2-DRY-TOTAL)"; done
echo T6-DONE
