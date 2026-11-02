#!/bin/bash
# t4: the twist KAT. Flipping U_l -> -U_l on link 0 (face A's bottom link, on loop A) preserves Haar; it twists plaquette 0 (w(U) -> w(-U)),
# negates link 0's staples and maps A -> -A. So F_tw^{ac} = (-1)^a F^{ac} entry by entry (Z unchanged). Sighted control: twist plaquette 0
# with link 1's staples negated (an inconsistent path) must FAIL. n = 2, W2L2, planar and bent, cancelling and random data.
W="$(cd "$(dirname "$0")" && pwd)"; cd "$W" || exit 1
T="$W/../rec/t4"; mkdir -p "$T"; export OMP_NUM_THREADS=8 W2_DUMPF=1
kat() { awk 'NR==FNR { if ($1=="W2-F") { k=$2" "$3" "$4" "$5" "$6" "$7; re[k]=$8; im[k]=$9; if ((t=($8<0?-$8:$8))>mx) mx=t } next }
  $1=="W2-F" { split($2,A,"="); s=(A[2]%2)?-1:1; k=$2" "$3" "$4" "$5" "$6" "$7; d=$8-s*re[k]; if (d<0) d=-d; e=$9-s*im[k]; if (e<0) e=-e; if (d+e>dm) dm=d+e; n++ }
  END { printf "  %d entries: max |F_tw - (-1)^a F| relative to max|F| = %.3e\n", n, dm/mx }' "$1" "$2"; }
for geo in planar bent; do for dat in cancel random:1; do
  ./w2m.exe 2.2 2 2 $dat fwd $geo 2 > "$T/base.txt" 2>&1
  W2_TWIST=0:0 ./w2m.exe 2.2 2 2 $dat fwd $geo 2 > "$T/tw.txt" 2>&1
  W2_TWIST=0:1 ./w2m.exe 2.2 2 2 $dat fwd $geo 2 > "$T/bad.txt" 2>&1
  echo "$geo $dat: consistent twist (plaquette 0, link 0):"; kat "$T/base.txt" "$T/tw.txt"
  echo "$geo $dat: SIGHTED inconsistent twist (plaquette 0, link 1) must fail:"; kat "$T/base.txt" "$T/bad.txt"
done; done
echo "two steps, n = 4 W2L1 planar cancel (plaquette 0 = (0,0,0) in face A; link 0 its bottom):"
W2_LISTOBJ=1 ./w2m.exe 2.2 2 1 cancel fwd planar 4 2>/dev/null | grep -E "^W2-LINK 0 |^W2-PLAQ 0 "
./w2m.exe 2.2 2 1 cancel fwd planar 4 > "$T/b4.txt" 2>&1; W2_TWIST=0:0 ./w2m.exe 2.2 2 1 cancel fwd planar 4 > "$T/t4.txt" 2>&1; kat "$T/b4.txt" "$T/t4.txt"
echo T4-DONE
