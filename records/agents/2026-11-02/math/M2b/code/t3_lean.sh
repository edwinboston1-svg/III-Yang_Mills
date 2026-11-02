#!/bin/bash
# t3: the lean block order and the no-snapshot slices against the standard sliced sweep; unset byte-identity re-checked after the edit
W="$(cd "$(dirname "$0")" && pwd)"; cd "$W" || exit 1
T="$W/../rec/t3"; mkdir -p "$T"
gcc -O2 -fopenmp -o w2m.exe w2m.c -lm || exit 1
strip() { sed -E 's/[0-9]+\.[0-9] s/T s/g' "$1"; }
cmpF() { awk 'NR==FNR { if ($1=="W2-F") { k=$2" "$3" "$4" "$5" "$6" "$7; re[k]=$8; im[k]=$9; if ((t=($8<0?-$8:$8))>mx) mx=t } next }
  $1=="W2-F" { k=$2" "$3" "$4" "$5" "$6" "$7; d=$8-re[k]; if (d<0) d=-d; e=$9-im[k]; if (e<0) e=-e; if (d+e>dm) dm=d+e; n++ }
  END { printf "  %d entries, max |dF| relative to max|F| = %.3e\n", n, dm/mx }' "$1" "$2"; }
echo "U1: unset, the modified engine against the original (n = 2, W2L2, planar and bent, cancelling, sliced and not)"
for mode in plain slice; do for geo in planar bent; do
  if [ $mode = slice ]; then export W2_SLICE=full; else unset W2_SLICE; fi
  W2_DUMPF=1 ./w2_orig.exe 2.2 2 2 cancel fwd $geo 2 > "$T/o_${mode}_$geo.txt" 2>&1; W2_DUMPF=1 ./w2m.exe 2.2 2 2 cancel fwd $geo 2 > "$T/m_${mode}_$geo.txt" 2>&1
  if cmp -s <(strip "$T/o_${mode}_$geo.txt") <(strip "$T/m_${mode}_$geo.txt"); then echo "  IDENTICAL $mode $geo"; else echo "  DIFFER $mode $geo"; fi
done; done; unset W2_SLICE
export W2_SLICE=full W2_DUMPF=1
echo "L1: n = 2 W2L2 planar cancel, sliced: LEAN / NOSNAP / LEAN+NOSNAP / LEAN+NOSNAP+WEIGHT0+CLAMP 0,5 against the standard"
./w2m.exe 2.2 2 2 cancel fwd planar 2 > "$T/s2.txt" 2>&1
for v in "W2_LEAN=1" "W2_NOSNAP=1" "W2_LEAN=1 W2_NOSNAP=1" "W2_LEAN=1 W2_NOSNAP=1 W2_WEIGHT0=1 W2_CLAMP=0,5"; do env $v ./w2m.exe 2.2 2 2 cancel fwd planar 2 > "$T/v.txt" 2>&1; echo " $v:"; cmpF "$T/s2.txt" "$T/v.txt"; grep -E "M2b peak" "$T/v.txt" | head -1; done
echo "L2: n = 4 W3L1 planar cancel (two steps), sliced, standard against LEAN+NOSNAP+WEIGHT0"
./w2m.exe 2.2 3 1 cancel fwd planar 4 > "$T/s4.txt" 2>&1; grep -E "W2-DONE|a=1 c=1 E" "$T/s4.txt"
W2_LEAN=1 W2_NOSNAP=1 W2_WEIGHT0=1 ./w2m.exe 2.2 3 1 cancel fwd planar 4 > "$T/v4.txt" 2>&1; grep -E "W2-DONE|a=1 c=1 E|M2b peak" "$T/v4.txt"; cmpF "$T/s4.txt" "$T/v4.txt"
echo "L3: the L1 identity -- the direct W2L1 two-step dump against the W2L2 dump truncated to a, c <= 1 (planar, cancelling)"
./w2m.exe 2.2 2 1 cancel fwd planar 4 > "$T/w2l1.txt" 2>&1
D="/c/Users/Edwin Boston/OneDrive/Desktop/III/STDLIB/build/aperanton/surface-gas"; src="$D/dob_n4_W2L2_planar_cancel.txt"; [ -f "$src" ] || src="$D/dob/dob_n4_W2L2_planar_cancel.txt"
awk '/^W2-F / { split($2,A,"="); split($3,C,"="); if (A[2]<=1 && C[2]<=1) print; next }' "$src" > "$T/w2l2_trunc.txt"; cmpF "$T/w2l2_trunc.txt" "$T/w2l1.txt"
unset W2_SLICE W2_DUMPF
echo "D: W4L1 n = 4 planar staged dry under LEAN+NOSNAP+WEIGHT0"
W2_DRY=1 W2_LEAN=1 W2_NOSNAP=1 W2_WEIGHT0=1 W2_SLICE=full ./w2m.exe 2.2 4 1 cancel fwd planar 4 2>&1 | grep -E "W2-DRY"
echo T3-DONE
