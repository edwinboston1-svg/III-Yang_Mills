#!/bin/bash
# u1_cancel_ladders.sh -- THE U(1) INFLUENCE LADDERS AT THE CANCELLING DATUM, both couplings (1.2 and 0.9), both rungs (the one-step 174
# links, the two-step 532): NMAX 6, LMAX 2, every outside link's phase shifted by pi, every rotated record kept, four links at a time
# (the engine is single-threaded), the tv record assembled in index order; the same exe (w2_u1r.exe) and the same awk as the ordered
# ladders.  Records: ladder1/u1_base_cancel_b{1.2,0.9}_N6.txt, ladder1/u1_tv_cancel_b*_N6_pi.txt, ladder1/u1_n2_cancel_b*/;
# ladder2/u1_base_cancel_b*.txt, ladder2/u1_tv_cancel_b*_pi.txt, ladder2/u1_n4_cancel_b*/.  A frozen copy, never edited while it runs.
set -u
cd "/c/Users/Edwin Boston/OneDrive/Desktop/III/STDLIB/build/aperanton/surface-gas" || exit 2
EXE=./w2_u1r.exe; PI=3.141592653589793; PAR=4
rung(){ local n=$1 B=$2; local dir tag; if [ "$n" = 2 ]; then dir=ladder1; tag="_N6"; else dir=ladder2; tag=""; fi
  local BASE="$dir/u1_base_cancel_b${B}${tag}.txt" TV="$dir/u1_tv_cancel_b${B}${tag}_pi.txt" ROT="$dir/u1_n${n}_cancel_b${B}"
  if [ -e "$BASE" ] || [ -e "$TV" ] || [ -d "$ROT" ]; then echo "REFUSED: a record of that name exists ($BASE)"; exit 4; fi
  mkdir -p "$ROT"
  U1_LIST=1 "$EXE" "$B" 6 2 cancel bent "$n" > "$BASE" 2>&1
  local NOUT; NOUT=$(grep -c '^U1-OUT' "$BASE")
  echo "rung n=$n beta=$B cancel: $NOUT outside links; $(grep '^U1-CLASS a=1 c=0' "$BASE" | head -1 | cut -c1-90) at $(date '+%H:%M:%S')"
  local i=0
  while [ "$i" -lt "$NOUT" ]; do
    if [ "$(jobs -rp | wc -l)" -ge "$PAR" ]; then wait -n; fi
    U1_ROT="$i:$PI" "$EXE" "$B" 6 2 cancel bent "$n" > "$ROT/rot_$i.txt" 2>&1 &
    i=$((i + 1))
  done
  wait
  : > "$TV"; i=0; while [ "$i" -lt "$NOUT" ]; do gawk -v N=256 -f w2_u1_tv.awk "$BASE" "$ROT/rot_$i.txt" >> "$TV"; i=$((i + 1)); done
  echo "rung n=$n beta=$B cancel done $(date '+%H:%M:%S'): $(grep -c '^U1-TV' "$TV") lines, refused $(grep -c REFUSED "$TV")"
  gawk -v n="$n" -f w2_ladder.awk "$TV" | head -1; }
echo "start $(date '+%H:%M:%S %Z')"
for B in 1.2 0.9; do rung 2 "$B"; rung 4 "$B"; done
echo "end $(date '+%H:%M:%S %Z')"
