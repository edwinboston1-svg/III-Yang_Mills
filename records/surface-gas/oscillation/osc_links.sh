#!/bin/bash
# osc_links.sh -- THE OSCILLATION INSTRUMENT (§9 ADDENDUM, the first of its two steps): at the ordered datum, one outside link's value is swept
# over a grid of 391 unit quaternions (the identity; 15 half-angles alpha = k pi/16 times 26 axes: polar cosines -0.75, -0.25, 0.25, 0.75 at six
# azimuths and the two poles) and the coarse loop's first moment E[chi_1(A)] is read at each -- so max - min over the grid is a LOWER bound on
# the link's oscillation (its Dobrushin sup over the link's value at the others fixed), to be set beside the pi-rotation reading the ladders
# took at that link.  Links: the one-step W2L1 ordered ladder's largest (56, the (-1,2,0,0) x-link, influence 0.0329) and its second class (60,
# the (0,1,0,-1) y-link, 0.0282); the two-step's largest (78, the (0,2,0,-1) y-link, 0.00915).  W2_CMAX=0 (the first moment needs c = 0 alone),
# 4 threads.  Records osc_n2_W2L1_link56.txt, osc_n2_W2L1_link60.txt, osc_n4_W2L1_link78.txt.  A frozen copy, never edited while it runs.
set -u
cd "/c/Users/Edwin Boston/OneDrive/Desktop/III/STDLIB/build/aperanton/surface-gas" || exit 2
EXE=./w2_strip_o.exe; THR=4
grid(){ gawk 'BEGIN { pi = 3.141592653589793; print "1 0 0 0";
  for (k = 1; k <= 15; k++) { a = k * pi / 16; w = cos(a); s = sin(a);
    for (t = -0.75; t <= 0.76; t += 0.5) { r = sqrt(1 - t * t); for (f = 0; f < 6; f++) { ph = f * pi / 3; printf "%.12f %.12f %.12f %.12f\n", w, s * r * cos(ph), s * r * sin(ph), s * t } }
    printf "%.12f 0 0 %.12f\n%.12f 0 0 %.12f\n", w, s, w, -s } }'; }
one(){ local n=$1 link=$2 out=$3
  if [ -e "$out" ]; then echo "REFUSED: $out exists"; return; fi
  echo "link $link n=$n begins $(date '+%H:%M:%S')"
  grid | while read -r w x y z; do
    v=$(W2_CMAX=0 W2_SET="$link:$w:$x:$y:$z" OMP_NUM_THREADS=$THR "$EXE" 2.2 2 1 ordered fwd bent "$n" 2>&1 | gawk '/^W2-CLASS a=1 c=0/ { print $7 }')
    echo "W2-OSC link $link n=$n q=($w,$x,$y,$z) E1=$v" >> "$out"
  done
  echo "link $link n=$n ends $(date '+%H:%M:%S'): $(grep -c '^W2-OSC' "$out") points"
  gawk -v L="$link" '/^W2-OSC/ { match($0, /E1=([-+0-9.e]+)/, m); v = m[1] + 0; if (!n++) { mx = mn = v; base = v } if (v > mx) { mx = v; qx = $0 } if (v < mn) { mn = v; qn = $0 }; if ($0 ~ /q=\(1,0,0,0\)/) base = v } END { printf "W2-OSC-READ link %s: base E1 %.9f; grid max %.9f, min %.9f; oscillation (max - min) %.6e; largest |E1 - base| %.6e\n", L, base, mx, mn, mx - mn, (mx - base > base - mn ? mx - base : base - mn); print "  at max: " qx; print "  at min: " qn }' "$out"; }
echo "start $(date '+%H:%M:%S %Z'); grid of $(grid | wc -l) points"
one 2 56 osc_n2_W2L1_link56.txt
one 2 60 osc_n2_W2L1_link60.txt
one 4 78 osc_n4_W2L1_link78.txt
echo "end $(date '+%H:%M:%S %Z')"
