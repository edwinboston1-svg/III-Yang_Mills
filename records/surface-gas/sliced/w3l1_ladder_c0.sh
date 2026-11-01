#!/bin/bash
# w3l1_ladder_c0.sh -- THE TWO-STEP W3L1 INFLUENCE LADDER AT THE ORDERED DATUM UNDER THE B-REPRESENTATION CAP (W2_CMAX=0): the ladder reads
# face A's moments alone (c = 0), so the (1,1) class -- 85 of the 123 seconds a link of the uncapped run in flight since 08:2x -- is not
# computed; the controls of 10:3x: the capped engine's c = 0 lines byte-identical to the landed one-step record, the ladder's tv(A), dE[chi_1(A)],
# dE[chi_2(A)] identical to the landed one-step ladder's lines for links 0..2 (tv(B) and dE[chi_1 chi_1], the post-hoc pair column, read 0 under
# the cap and are not the ladder's quantity).  New names (the uncapped partial run's 36 records stay as they are); 8 threads; the first 36 lines
# compared with the partial run's when passed.  A frozen copy in the scratchpad, never edited while it runs.
set -u
cd "/c/Users/Edwin Boston/OneDrive/Desktop/III/STDLIB/build/aperanton/surface-gas" || exit 2
EXE=./w2_strip_c.exe; PI=3.141592653589793; THR=8
BASE=ladder2/base_ordered_n4_W3L1_c0.txt; TV=ladder2/tv_ordered_n4_W3L1_c0_pi.txt; ROT=ladder2/n4_W3L1_c0
if [ -e "$BASE" ] || [ -e "$TV" ] || [ -d "$ROT" ]; then echo "REFUSED: a record of that name exists"; exit 4; fi
mkdir -p "$ROT"
echo "start $(date '+%H:%M:%S %Z')"
W2_LIST=1 W2_CMAX=0 OMP_NUM_THREADS=$THR "$EXE" 2.2 3 1 ordered fwd bent 4 > "$BASE" 2>&1
NOUT=$(grep -c '^W2-OUT' "$BASE")
echo "base done $(date '+%H:%M:%S'): $NOUT outside links; $(grep '^W2-CLASS a=1 c=0' "$BASE" | cut -c1-120)"
echo "control: the capped base's c=0 class lines against the uncapped base ladder2/base_ordered_n4_W3L1.txt:"
cmp <(grep '^W2-CLASS\|^W2-Z\|^W2-OUT' "$BASE" | grep -v 'c=1' | sed -E 's/; [0-9.]+ s\)/)/') <(grep '^W2-CLASS\|^W2-Z\|^W2-OUT' ladder2/base_ordered_n4_W3L1.txt | grep -v 'c=1' | sed -E 's/; [0-9.]+ s\)/)/') && echo "  IDENTICAL" || echo "  PARTED -- read before trusting the ladder"
: > "$TV"
i=0
while [ "$i" -lt "$NOUT" ]; do
  W2_CMAX=0 W2_ROT="$i:$PI" OMP_NUM_THREADS=$THR "$EXE" 2.2 3 1 ordered fwd bent 4 > "$ROT/rot_$i.txt" 2>&1
  gawk -v N=256 -f w2_tv.awk "$BASE" "$ROT/rot_$i.txt" >> "$TV"
  i=$((i + 1))
  if [ $((i % 20)) -eq 0 ]; then echo "  $i of $NOUT at $(date '+%H:%M:%S')"; fi
  if [ "$i" -eq 36 ]; then echo "control at 36: the capped ladder's tv(A) and dE[chi] columns against the uncapped partial run's 36 lines:"
    cmp <(head -36 "$TV" | sed -E 's/tv\(B\) = [^;]*;//; s/dE\[chi_1 chi_1\] = [^;]*;//') <(head -36 ladder2/tv_ordered_n4_W3L1_pi.txt | sed -E 's/tv\(B\) = [^;]*;//; s/dE\[chi_1 chi_1\] = [^;]*;//') && echo "  IDENTICAL" || echo "  PARTED -- read before trusting the ladder"; fi
done
echo "rotations done $(date '+%H:%M:%S'): $(grep -c '^W2-TV' "$TV") tv lines of $NOUT"
gawk -v n=4 -f w2_ladder.awk "$TV"
echo "end $(date '+%H:%M:%S %Z')"
