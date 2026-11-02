#!/bin/bash
# run_bent: THE TRUE BENT ROW -- the bent object with its n + 1 corner plaquettes as cycles (w2c.exe, W2_CORNER=1), beside the planar object at the
# same cap and datum; one step (n = 2) at W2L2, W3L2, W4L2 now, two steps (n = 4) at W2L2 once run_w4 has finished. Read by l2dob and the twist reader.
W="$(cd "$(dirname "$0")" && pwd)"; cd "$W" || exit 1
R="$W/../rec/bent"; mkdir -p "$R"
export W2_SLICE=full W2_LEAN=1 W2_NOSNAP=1 W2_WEIGHT0=1 W2_DUMPF=1
rd() { ./l2dob.exe "$1" 30 20 12 > "${1%.txt}.l2.txt" 2>&1; ./twist.exe "$1" 32 > "${1%.txt}.t32.txt" 2>&1
  echo "   $(grep -E 'L2DOB-RESULT|REFUS' "${1%.txt}.l2.txt" | head -1 | sed -E 's/.*(rhoA=[0-9.e+-]+).*(Cgrid=[0-9.e+-]+).*/\1 \2/')  E[chi(A)]=$(grep 'W2-CLASS a=1 c=0' "$1" | sed -E 's/.*= ([+0-9.e-]+) .*/\1/')  $(grep '^TWIST ' "${1%.txt}.t32.txt" | sed -E 's/.*(T_conn\(A\) = [0-9.]+).*/\1/')"; }
one() { local tag=$1 nt=$2; shift 2; echo "== $tag start $(date '+%H:%M:%S')"; OMP_NUM_THREADS=$nt "$@" > "$R/$tag.txt" 2>&1; echo "   rc=$? end $(date '+%H:%M:%S') $(grep -E 'W2-DONE' "$R/$tag.txt")"; rd "$R/$tag.txt"; }
for W_ in 2 3 4; do for d in ordered cancel; do
  one bent_n2_W${W_}L2_$d 6 env W2_CORNER=1 ./w2c.exe 2.2 $W_ 2 $d fwd bent 2
  one plan_n2_W${W_}L2_$d 6 ./w2c.exe 2.2 $W_ 2 $d fwd planar 2
done; done
echo "== waiting for run_w4 $(date '+%H:%M:%S')"; while ! grep -q RUN-W4-DONE "$W/../rec/run_w4.log" 2>/dev/null; do sleep 30; done
for d in ordered cancel; do one bent_n4_W2L2_$d 16 env W2_CORNER=1 ./w2c.exe 2.2 2 2 $d fwd bent 4; done
echo RUN-BENT-DONE $(date '+%H:%M:%S')
