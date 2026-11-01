#!/bin/bash
# w3l2_read.sh -- §12's RESULTS READER: the three W3L2 two-step records against the four stakes (S1 direction, S2 size against the cap within
# a factor 2 of W2L2's ratios, S3 the two-step's cap dependence, S4 the peak 21,870,000 at (2,2) and 6,480,000 at (1,1)), every number
# from the records through w2_modes.awk.  usage: bash w3l2_read.sh [record letter, default b]
set -u
cd "/c/Users/Edwin Boston/OneDrive/Desktop/III/STDLIB/build/aperanton/surface-gas" || exit 2
L=${1:-b}
modes(){ gawk -v N=256 -f w2_modes.awk "$1" 2>&1 | gawk '/^W2-MODES/ { match($0, /sup\|delta_2\| = ([-+0-9.e]+)/, m); sup = m[1] } /^W2-MODE a=1 c=1/ { match($0, /bhat\(e\^delta-1\)=([-+0-9.e]+)/, m); hh = m[1] } /^W2-MODE a=2 c=2/ { match($0, /bhat\(e\^delta-1\)=([-+0-9.e]+)/, m); oo = m[1] } /^W2-CONTENT/ { match($0, /r_mod = ([-+0-9.e]+)/, m); rm = m[1] } /REFUSED/ { ref = 1 } END { if (ref) print "REFUSED"; else printf "%s %s %s %s\n", hh, oo, sup, rm }'; }
ratio(){ gawk -v a="$1" -v b="$2" 'BEGIN { if (b + 0 == 0) print "n/a"; else printf "%.3f", a / b }'; }
echo "== §12 RESULTS reader on w2n4_W3L2.2026-11-01$L.*.txt ($(date '+%H:%M:%S'))"
for d in ordered cancel random1; do f="w2n4_W3L2.2026-11-01$L.$d.txt"
  case $d in ordered) one=ladder1/base_ordered.txt; w2l2one=w2n2_W2L2.2026-11-01a.ordered.txt; w2l2two=w2n4_W2L2.2026-11-01a.ordered.txt; RW="0.23 0.07 0.27 0.07";;
              cancel)  one=ladder1/base_cancel_n2_W3L2.txt; w2l2one=w2n2_W2L2.2026-11-01a.cancel.txt; w2l2two=w2n4_W2L2.2026-11-01a.cancel.txt; RW="0.10 0.008 0.08 0.009";;
              random1) one=""; w2l2one=w2n2_W2L2.2026-11-01a.random1.txt; w2l2two=w2n4_W2L2.2026-11-01a.random1.txt; RW="";; esac
  echo "-- $d: $f"
  [ -f "$f" ] || { echo "   (no record yet)"; continue; }
  nc=$(grep -c '^W2-CLASS' "$f"); echo "   classes $nc of 9; $(grep -o 'W2-REFUSED.*' "$f" | head -1)"
  [ "$nc" -eq 9 ] || { echo "   (incomplete: its numbers are not read)"; continue; }
  echo "   S4 THE PEAK: $(grep '^W2-CLASS a=2 c=2' "$f" | grep -o 'max state [0-9]*') (stake 21,870,000); $(grep '^W2-CLASS a=1 c=1' "$f" | grep -o 'max state [0-9]*') (stake 6,480,000); $(grep '^W2-CLASS a=2 c=2' "$f" | grep -o '[0-9.]* s; [0-9]* slices')"
  two=$(modes "$f"); echo "   two-step W3L2 modes [(½,½) (1,1) sup|δ₂| r_mod]: $two"
  [ -n "$one" ] && [ -f "$one" ] && { on=$(modes "$one"); echo "   one-step W3L2 modes: $on"
    set -- $two; t1=$1; t2=$2; t3=$3; t4=$4; set -- $on; o1=$1; o2=$2; o3=$3; o4=$4
    echo "   S1 THE DIRECTION (two-step below one-step at (½,½), sup, r_mod): $(ratio $t1 $o1) $(ratio $t3 $o3) $(ratio $t4 $o4) -- all < 1 ? $(gawk -v a=$t1 -v b=$o1 -v c=$t3 -v d=$o3 -v e=$t4 -v f=$o4 'BEGIN { print (a < b && c < d && e < f) ? "HELD" : "FAILED" }')"
    echo "   S2 THE SIZE AGAINST THE CAP: W3L2 ratios [(½,½) (1,1) sup r_mod] = $(ratio $t1 $o1) $(ratio $t2 $o2) $(ratio $t3 $o3) $(ratio $t4 $o4) against W2L2's $RW -- within a factor 2 each ? $(gawk -v r="$(ratio $t1 $o1) $(ratio $t2 $o2) $(ratio $t3 $o3) $(ratio $t4 $o4)" -v w="$RW" 'BEGIN { n = split(r, R, " "); split(w, W, " "); ok = 1; for (i = 1; i <= n; i++) { q = (R[i] + 0) / (W[i] + 0); if (q > 2 || q < 0.5) { ok = 0; bad = bad " col" i "=" sprintf("%.2f", q) } } print ok ? "HELD" : "PARTED" bad }')"; }
  [ -f "$w2l2two" ] && { w2=$(modes "$w2l2two"); echo "   S3 THE TWO-STEP'S CAP DEPENDENCE: W2L2 two-step modes $w2 -> W3L2 two-step $two; the moves: $(set -- $w2; a1=$1; a2=$2; a3=$3; a4=$4; set -- $two; echo "$(ratio $1 $a1) $(ratio $2 $a2) $(ratio $3 $a3) $(ratio $4 $a4)") (the one-step moved ×1.3–5 with the cap)"; }
done
