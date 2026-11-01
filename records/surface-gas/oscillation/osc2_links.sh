#!/bin/bash
# osc2_links.sh -- THE OSCILLATION INSTRUMENT, SECOND PASS: the first pass's grid (15 half-angles x 26 axes) missed the ladder's own point,
# the half-turn about the x-axis, whose deviation at link 56 (0.0658) exceeds the grid's largest (0.0590) -- so this pass takes (a) the
# half-turn (alpha = pi/2, q = (0, n)) about 200 axes of a Fibonacci sphere, the three coordinate axes included exactly, and (b) the angle
# scan about the x-axis at alpha = k pi/32, k = 1..31 (the ladder's axis, 31 angles), at links 56 and 60 (one step) and 78 (two steps), the
# ordered datum, W2_CMAX=0, 4 threads; records osc2_n2_W2L1_link56.txt, osc2_n2_W2L1_link60.txt, osc2_n4_W2L1_link78.txt.  A frozen copy.
set -u
cd "/c/Users/Edwin Boston/OneDrive/Desktop/III/STDLIB/build/aperanton/surface-gas" || exit 2
EXE=./w2_strip_o.exe; THR=4
grid(){ gawk 'BEGIN { pi = 3.141592653589793; print "1 0 0 0";
  print "0 1 0 0"; print "0 0 1 0"; print "0 0 0 1";                                   # the half-turns about x, y, z exactly
  N = 200; g = (1 + sqrt(5)) / 2; for (i = 0; i < N; i++) { z = 1 - 2 * (i + 0.5) / N; r = sqrt(1 - z * z); ph = 2 * pi * i / g; printf "0 %.12f %.12f %.12f\n", r * cos(ph), r * sin(ph), z }
  for (k = 1; k <= 31; k++) { a = k * pi / 32; printf "%.12f %.12f 0 0\n", cos(a), sin(a) } }'; }
one(){ local n=$1 link=$2 out=$3
  if [ -e "$out" ]; then echo "REFUSED: $out exists"; return; fi
  echo "link $link n=$n begins $(date '+%H:%M:%S')"
  grid | while read -r w x y z; do
    v=$(W2_CMAX=0 W2_SET="$link:$w:$x:$y:$z" OMP_NUM_THREADS=$THR "$EXE" 2.2 2 1 ordered fwd bent "$n" 2>&1 | gawk '/^W2-CLASS a=1 c=0/ { print $7 }')
    echo "W2-OSC link $link n=$n q=($w,$x,$y,$z) E1=$v" >> "$out"
  done
  echo "link $link n=$n ends $(date '+%H:%M:%S'): $(grep -c '^W2-OSC' "$out") points"
  gawk -v L="$link" '/^W2-OSC/ { match($0, /E1=([-+0-9.e]+)/, m); v = m[1] + 0; if (!n++) { mx = mn = v } if (v > mx) { mx = v; qx = $0 } if (v < mn) { mn = v; qn = $0 }; if ($0 ~ /q=\(1,0,0,0\)/) base = v; if ($0 ~ /q=\(0,1,0,0\)/) px = v } END { printf "W2-OSC2-READ link %s: base E1 %.9f; the pi-x point %.9f (|dE| %.6e); grid max %.9f, min %.9f; oscillation %.6e; largest |E1 - base| %.6e; the pi-x deviation is %.3f of the largest and %.3f of the oscillation\n", L, base, px, (px - base < 0 ? base - px : px - base), mx, mn, mx - mn, (mx - base > base - mn ? mx - base : base - mn), (px - base < 0 ? base - px : px - base) / (mx - base > base - mn ? mx - base : base - mn), (px - base < 0 ? base - px : px - base) / (mx - mn); print "  at max: " qx; print "  at min: " qn }' "$out"; }
echo "start $(date '+%H:%M:%S %Z'); grid of $(grid | wc -l) points"
one 2 56 osc2_n2_W2L1_link56.txt
one 2 60 osc2_n2_W2L1_link60.txt
one 4 78 osc2_n4_W2L1_link78.txt
echo "end $(date '+%H:%M:%S %Z')"
