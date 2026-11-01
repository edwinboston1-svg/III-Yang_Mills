#!/bin/bash
# u1_ladder_b0.9_n4.sh -- THE TWO-STEP U(1) INFLUENCE LADDER AT beta = 0.9 (the confining side of the infinite-volume beta_c ~ 1.01; the
# campaign's §2 standard 2 names it the sighted abelian control at every instrument): NMAX 6, LMAX 2, the ordered datum, bent, n = 4
# (the 32-plaquette two-step object, 532 outside links), every outside link's phase shifted by pi, the rotated records KEPT; four links
# at a time (the engine is single-threaded); the tv record written afterwards in index order from the kept records, so its bytes do not
# depend on the scheduling.  The exe is the one that made the b1.2 two-step record (w2_u1r.exe, 06:28), proved so by remaking that base
# byte for byte before the run.  A frozen copy in the scratchpad: never edited while it runs.
set -u
cd "/c/Users/Edwin Boston/OneDrive/Desktop/III/STDLIB/build/aperanton/surface-gas" || exit 2
EXE=./w2_u1r.exe; B=0.9; NM=6; LM=2; D=ordered; N=4; PI=3.141592653589793; PAR=4
OUT=ladder2; ROT="$OUT/u1_n4_b0.9"; mkdir -p "$ROT"
echo "start $(date '+%H:%M:%S %Z')"
U1_LIST=1 "$EXE" 1.2 $NM $LM $D bent $N > "$ROT/ctl_base_b1.2.txt" 2>&1
if cmp -s "$ROT/ctl_base_b1.2.txt" "$OUT/u1_base_${D}_b1.2.txt"; then echo "control: the exe remakes the b1.2 two-step base byte for byte ($(date '+%H:%M:%S'))"
else echo "REFUSED: the exe does not remake the b1.2 two-step base"; cmp "$ROT/ctl_base_b1.2.txt" "$OUT/u1_base_${D}_b1.2.txt"; exit 3; fi
BASE="$OUT/u1_base_${D}_b${B}.txt"; TV="$OUT/u1_tv_${D}_b${B}_pi.txt"
if [ -e "$BASE" ] || [ -e "$TV" ]; then echo "REFUSED: a record of that name exists ($BASE / $TV); a re-run never writes to a landed record's name"; exit 4; fi
U1_LIST=1 "$EXE" $B $NM $LM $D bent $N > "$BASE" 2>&1
NOUT=$(grep -c '^U1-OUT' "$BASE")
echo "ladder U(1) n=$N beta=$B NMAX=$NM LMAX=$LM $D: $NOUT outside links; $(grep '^U1-OBJECT' "$BASE")"
echo "base: $(grep '^U1-CLASS a=1 c=0' "$BASE" | head -1)"
i=0
while [ "$i" -lt "$NOUT" ]; do
  if [ "$(jobs -rp | wc -l)" -ge "$PAR" ]; then wait -n; fi
  U1_ROT="$i:$PI" "$EXE" $B $NM $LM $D bent $N > "$ROT/rot_$i.txt" 2>&1 &
  i=$((i + 1))
done
wait
echo "rotations done $(date '+%H:%M:%S'): $(ls "$ROT" | grep -c '^rot_') records"
: > "$TV"
i=0; while [ "$i" -lt "$NOUT" ]; do gawk -v N=256 -f w2_u1_tv.awk "$BASE" "$ROT/rot_$i.txt" >> "$TV"; i=$((i + 1)); done
echo "tv record $(date '+%H:%M:%S'): $(grep -c '^U1-TV' "$TV") lines of $NOUT; refused: $(grep -c 'REFUSED' "$TV")"
gawk -v n=4 -f w2_ladder.awk "$TV"
echo "end $(date '+%H:%M:%S %Z')"
