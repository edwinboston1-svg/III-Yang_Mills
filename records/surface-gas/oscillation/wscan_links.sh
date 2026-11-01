#!/bin/bash
# wscan_links.sh -- THE OSCILLATION, EXACT IN ITS ONE VARIABLE: at the ordered datum the object is invariant under a global conjugation
# (every other outside link is the identity, the plaquette weights and the loop's character are class functions, the Haar measure is
# invariant), so the coarse loop's moment depends on the one varied link through its CLASS alone -- its rotation angle, w = cos(angle/2) --
# which pass 2 read to twelve digits over 203 axes at the half-turn.  So the single-link oscillation at this datum is a function on
# [-1, 1], scanned here at 181 rotation angles 0, 2, ..., 360 degrees about x (w from 1 to -1), at the three strongest links; the extremes
# bracketed to two degrees.  Records wscan_n2_W2L1_link56.txt, wscan_n2_W2L1_link60.txt, wscan_n4_W2L1_link78.txt.  W2_CMAX=0, 4 threads.
set -u
cd "/c/Users/Edwin Boston/OneDrive/Desktop/III/STDLIB/build/aperanton/surface-gas" || exit 2
EXE=./w2_strip_o.exe; THR=4
one(){ local n=$1 link=$2 out=$3
  if [ -e "$out" ]; then echo "REFUSED: $out exists"; return; fi
  echo "link $link n=$n begins $(date '+%H:%M:%S')"
  for ((k = 0; k <= 180; k++)); do
    read -r w x <<< "$(gawk -v k=$k 'BEGIN { a = k * 3.141592653589793 / 180; printf "%.12f %.12f", cos(a), sin(a) }')"
    v=$(W2_CMAX=0 W2_SET="$link:$w:$x:0:0" OMP_NUM_THREADS=$THR "$EXE" 2.2 2 1 ordered fwd bent "$n" 2>&1 | gawk '/^W2-CLASS a=1 c=0/ { print $7 }')
    echo "W2-WSCAN link $link n=$n angle=$((2 * k)) w=$w E1=$v" >> "$out"
  done
  echo "link $link n=$n ends $(date '+%H:%M:%S')"
  gawk -v L="$link" '/^W2-WSCAN/ { match($0, /angle=([0-9]+)/, a); match($0, /E1=([-+0-9.e]+)/, m); v = m[1] + 0; if (a[1] == 0) base = v; if (a[1] == 180) px = v; if (!n++) { mx = mn = v; ax = an = 0 } if (v > mx) { mx = v; ax = a[1] } if (v < mn) { mn = v; an = a[1] } } END { d = px - base; if (d < 0) d = -d; printf "W2-WSCAN-READ link %s: base %.9f; the pi point %.9f (|dE| %.6e); max %.9f at %d deg, min %.9f at %d deg; oscillation %.6e; the pi point is %.3f of it; largest |E1 - base| %.6e\n", L, base, px, d, mx, ax, mn, an, mx - mn, d / (mx - mn), (mx - base > base - mn ? mx - base : base - mn) }' "$out"; }
echo "start $(date '+%H:%M:%S %Z')"
one 2 56 wscan_n2_W2L1_link56.txt
one 2 60 wscan_n2_W2L1_link60.txt
one 4 78 wscan_n4_W2L1_link78.txt
echo "end $(date '+%H:%M:%S %Z')"
